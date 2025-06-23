from flask import Blueprint, request, jsonify
from requests.exceptions import ReadTimeout
from docker.errors import ContainerError, APIError
from backend.models.user import User
from backend.models.lesson import Lesson
from backend.models.progress import Progress, SubmissionHistory
from backend import db
from datetime import datetime
import docker
import tempfile
import os
import time
import re

bp = Blueprint('code_runner', __name__, url_prefix='/api/code')

# Docker配置
DOCKER_IMAGE = 'python:3.9-alpine'
EXECUTION_TIMEOUT = 10  # 秒
MEMORY_LIMIT = '128m'
CPU_LIMIT = 0.5

def get_docker_client():
    """获取Docker客户端"""
    try:
        client = docker.from_env()
        return client
    except Exception as e:
        print(f"Docker連接失敗: {str(e)}")
        return None

def is_code_safe(code):
    """檢查程式碼安全性"""
    dangerous_patterns = [
        r'import\s+os',
        r'import\s+subprocess',
        r'import\s+sys',
        r'import\s+socket',
        r'import\s+requests',
        r'import\s+urllib',
        r'from\s+os\s+import',
        r'from\s+subprocess\s+import',
        r'__import__',
        r'eval\s*\(',
        r'exec\s*\(',
        r'open\s*\(',
        r'file\s*\(',
        r'input\s*\(',
        r'raw_input\s*\(',
        r'compile\s*\(',
        r'globals\s*\(',
        r'locals\s*\(',
        r'vars\s*\(',
        r'dir\s*\(',
        r'exit\s*\(',
        r'quit\s*\(',
        r'while\s+True\s*:',
        r'for.*in.*range\s*\(\s*\d{6,}',  # 防止大循环
    ]
    
    for pattern in dangerous_patterns:
        if re.search(pattern, code, re.IGNORECASE):
            return False, f"程式碼包含不安全的操作: {pattern}"
    
    return True, "程式碼安全"

# def execute_python_code(code):
#     """在Docker容器中安全执行Python程式碼"""
#     client = get_docker_client()
#     if not client:
#         return False, "Docker服務不可用", "", "無法連接到Docker服務"
    
#     # 安全檢查
#     is_safe, safety_message = is_code_safe(code)
#     if not is_safe:
#         return False, "", "", safety_message
    
#     TEMP_CODE_DIR = '/app/backend/tmp_code_files' # Directory inside backend container, mapped from host
#     try:
#         os.makedirs(TEMP_CODE_DIR, exist_ok=True) # Ensure the directory exists
#         # 创建临时文件 in the specified directory
#         with tempfile.NamedTemporaryFile(mode='w', suffix='.py', delete=False, dir=TEMP_CODE_DIR) as f:
#             f.write(code)
#             temp_file = f.name
        
#         # Get the basename of the temp file and construct the host-relative path
#         temp_file_basename = os.path.basename(temp_file)
#         # Construct the absolute path on the host for the temp file
#         host_project_path = os.getenv('HOST_PROJECT_PATH')
#         if not host_project_path:
#             print("Error: HOST_PROJECT_PATH environment variable is not set. Cannot determine absolute path for volume mount.")
#             return False, "", "Server configuration error: HOST_PROJECT_PATH not set.", "内部服务器配置错误"
        
#         # Ensure host_project_path uses forward slashes for os.path.join consistency if needed, 
#         # though os.path.join should handle mixed slashes on Windows.
#         # For Docker volume paths, it's generally safer if the Python string uses forward slashes or escaped backslashes.
#         # However, os.path.join will produce OS-specific paths. Docker on Windows usually handles these.

#         temp_file_on_host_absolute = os.path.join(host_project_path, 'backend', 'tmp_code_files', temp_file_basename)

#         # 准备Docker执行环境
#         container_code_path = '/tmp/user_code.py'
        
#         # 运行Docker容器
#         try:
#             # For debugging, print the path that will be used for the volume mount
#             # print(f"Attempting to mount: {temp_file_on_host_absolute} -> {container_code_path}")
#             result = client.containers.run(
#                 image=DOCKER_IMAGE,
#                 command=f'python {container_code_path}',
#                 volumes={temp_file_on_host_absolute: {'bind': container_code_path, 'mode': 'ro'}},
#                 remove=True,  # 执行完自动删除
#                 stdout=True,
#                 stderr=True
#             )
            
#             # 获取输出 - result 已经是字节串
#             if isinstance(result, bytes):
#                 output = result.decode('utf-8').strip()
#             else:
#                 output = str(result).strip()
            
#             return True, output, "", "執行成功"
                
#         except docker.errors.ContainerError as e:
#             # 容器執行錯誤（非零退出程式碼）
#             error_output = ""
#             if hasattr(e, 'stderr') and e.stderr:
#                 error_output = e.stderr.decode('utf-8') if isinstance(e.stderr, bytes) else str(e.stderr)
#             else:
#                 error_output = str(e)
#             return False, "", error_output, "程式碼執行出錯"
            
#         except docker.errors.APIError as e:
#             return False, "", str(e), "Docker API錯誤"
            
#         except Exception as e:
#             return False, "", str(e), f"容器執行異常: {type(e).__name__}"
            
#     except Exception as e:
#         return False, "", "", f"執行準備失敗: {str(e)}"
#     finally:
#         # 清理臨時文件
#         try:
#             if 'temp_file' in locals():
#                 os.unlink(temp_file)
#         except:
#             pass
# # 引入新的 Timeout 異常


def execute_python_code(code):
    """在Docker容器中安全执行Python程式碼（修改後版本）"""
    client = get_docker_client()
    if not client:
        return False, "Docker服務不可用", "", "無法連接到Docker服務"

    is_safe, safety_message = is_code_safe(code)
    if not is_safe:
        return False, "", "", safety_message

    temp_file_on_host_absolute = None
    container = None
    
    # 使用 try...finally 確保臨時檔案和容器總能被清理
    try:
        # --- 準備臨時檔案 ---
        TEMP_CODE_DIR = '/app/backend/tmp_code_files'
        os.makedirs(TEMP_CODE_DIR, exist_ok=True)
        with tempfile.NamedTemporaryFile(mode='w', suffix='.py', delete=False, dir=TEMP_CODE_DIR) as f:
            f.write(code)
            temp_file_local_path = f.name
        
        temp_file_basename = os.path.basename(temp_file_local_path)
        host_project_path = os.getenv('HOST_PROJECT_PATH')
        if not host_project_path:
            return False, "", "Server configuration error: HOST_PROJECT_PATH not set.", "内部服务器配置错误"
        
        temp_file_on_host_absolute = os.path.join(host_project_path, 'backend', 'tmp_code_files', temp_file_basename)
        container_code_path = f'/tmp/{temp_file_basename}' # 給容器內的路徑一個唯一的名字

        # --- 執行 Docker 容器 (非阻塞式) ---
        container = client.containers.run(
            image=DOCKER_IMAGE,
            command=f'python {container_code_path}',
            volumes={temp_file_on_host_absolute: {'bind': container_code_path, 'mode': 'ro'}},
            mem_limit=MEMORY_LIMIT,
            # nano_cpus=int(CPU_LIMIT * 1e9), # 如果您的 Docker 版本支援
            detach=True  # 關鍵修改：讓容器在背景運行，立刻返回 container 物件
        )

        # 等待容器執行完畢，並設定超時
        try:
            result = container.wait(timeout=EXECUTION_TIMEOUT)
            stdout = container.logs(stdout=True, stderr=False).decode('utf-8').strip()
            stderr = container.logs(stdout=False, stderr=True).decode('utf-8').strip()

            # 檢查容器的退出碼
            if result['StatusCode'] == 0:
                return True, stdout, stderr, "執行成功"
            else:
                return False, stdout, stderr, "程式碼執行出錯"

        except (ReadTimeout, ConnectionError):
            # 捕獲執行超時的錯誤
            container.stop(timeout=5) # 溫和地停止超時的容器
            return False, "", "執行超時", "程式碼執行超過了限制時間"
            
    except (ContainerError, APIError) as e:
        return False, "", str(e), "Docker 容器或 API 錯誤"
    
    except Exception as e:
        return False, "", f"執行準備失敗: {str(e)}", "未知的伺服器錯誤"
        
    finally:
        # --- 徹底的清理工作 ---
        # 1. 確保容器被移除
        if container:
            try:
                # 再次嘗試停止和移除，以防萬一
                container.remove(force=True)
            except APIError as e:
                # 容器可能已經被移除了，這是正常的
                if "No such container" not in str(e):
                    print(f"清理容器時發生錯誤: {e}")
            except Exception as e:
                 print(f"清理容器時發生未知錯誤: {e}")

        # 2. 確保臨時檔案被刪除
        if temp_file_on_host_absolute and os.path.exists(temp_file_local_path):
            try:
                os.unlink(temp_file_local_path)
            except Exception as e:
                print(f"清理臨時檔案時發生錯誤: {e}")


@bp.route('/run', methods=['POST'])
def run_code():
    """运行程式碼并返回结果"""
    data = request.get_json()
    
    if not data or 'code' not in data:
        return jsonify({'error': 'No code submitted'}), 400
    
    submitted_code = data.get('code', '').strip()
    
    if not submitted_code:
        return jsonify({'error': 'Empty code submitted'}), 400
    
    # 执行程式碼
    success, stdout, stderr, message = execute_python_code(submitted_code)
    
    if success:
        return jsonify({
            'message': 'Code executed successfully',
            'output': stdout,
            'error': None,
            'execution_time': '< 1s'
        }), 200
    else:
        return jsonify({
            'message': 'Code execution failed',
            'output': stdout,
            'error': stderr or message,
            'execution_time': None
        }), 400

@bp.route('/submit/<int:lesson_id>', methods=['POST'])
def submit_code(lesson_id):
    """提交编程作业并自动评分"""
    # 移除JWT认证，使用固定的学生ID（在实际应用中可能需要其他方式获取）
    # 为了简化，这里使用请求中的 student_id 参数
    data = request.get_json()
    
    # 从请求中获取 student_id，如果没有则使用默认值 1
    user_id = data.get('student_id', 1)
    
    # 验证用户
    user = User.query.get(user_id)
    if not user or not user.is_student():
        return jsonify({'error': 'Only students can submit solutions'}), 403
    
    if not data or 'code' not in data:
        return jsonify({'error': 'No code submitted'}), 400
    
    submitted_code = data.get('code', '').strip()
    
    if not submitted_code:
        return jsonify({'error': 'Empty code submitted'}), 400
    
    # 验证课程存在
    lesson = Lesson.query.get(lesson_id)
    if not lesson:
        return jsonify({'error': 'Lesson not found'}), 404
    
    try:
        # 执行程式碼并获取实际输出
        success, stdout, stderr, message = execute_python_code(submitted_code)
        
        # 评分逻辑
        test_results = []
        passed_tests = 0
        total_tests = 2
        
        if not success:
            # 程式碼执行失败
            test_results = [{
                'test_case': 1,
                'passed': False,
                'message': f'程式碼執行失敗: {stderr or message}'
            }]
            score = 0
        else:
            # 测试1: 程式碼成功執行
            test_results.append({
                'test_case': 1,
                'passed': True,
                'message': '程式碼成功執行'
            })
            passed_tests += 1
            
            # 测试2: 检查是否有输出
            if stdout.strip():
                test_results.append({
                    'test_case': 2,
                    'passed': True,
                    'message': '程式碼產生了輸出'
                })
                passed_tests += 1
            else:
                test_results.append({
                    'test_case': 2,
                    'passed': False,
                    'message': '程式碼沒有產生輸出'
                })
            
            # # 测试3: 检查特定输出（根据作业要求定制）
            # expected_outputs = ['hello', 'Hello', 'HELLO']
            # output_found = any(expected in stdout for expected in expected_outputs)
            
            # if output_found:
            #     test_results.append({
            #         'test_case': 3,
            #         'passed': True,
            #         'message': '輸出包含預期內容'
            #     })
            #     passed_tests += 1
            # else:
            #     test_results.append({
            #         'test_case': 3,
            #         'passed': False,
            #         'message': f'輸出不包含預期內容。實際輸出: "{stdout.strip()}"'
            #     })
        
        # 計算分數
        score = int((passed_tests / total_tests) * 100)
        
        # 记录提交历史
        submission = SubmissionHistory(
            student_id=user_id,
            lesson_id=lesson_id,
            submission_type='coding',
            content=submitted_code,
            score=score,
            feedback=f'通过 {passed_tests}/{total_tests} 个测试用例'
        )
        db.session.add(submission)
        
        # 更新或创建进度记录
        progress = Progress.query.filter_by(student_id=user_id, lesson_id=lesson_id).first()
        if progress:
            if score > progress.coding_score:
                progress.coding_score = score
            if passed_tests == total_tests: # Check if all tests passed
                progress.completed = True
            progress.attempts += 1
            progress.last_attempt_at = datetime.utcnow()
        else:
            progress = Progress(
                student_id=user_id,
                lesson_id=lesson_id,
                coding_score=score,
                attempts=1,
                last_attempt_at=datetime.utcnow(),
                completed=(passed_tests == total_tests) # Set completed based on test results
            )
            db.session.add(progress)
        
        db.session.commit()
        
        # 准备返回的输出
        execution_output = stdout if success else f"錯誤: {stderr or message}"
        
        return jsonify({
            'message': '程式碼提交並評分',
            'score': score,
            'max_score': 100,
            'output': execution_output,
            'test_results': test_results,
            'passed': passed_tests == total_tests,
            'feedback': f'通過 {passed_tests}/{total_tests} 個測試用例',
            'execution_success': success
        }), 200
        
    except Exception as e:
        db.session.rollback()
        return jsonify({
            'error': f'系統錯誤: {str(e)}',
            'message': '程式碼提交失敗'
        }), 500

@bp.route('/health', methods=['GET'])
def health_check():
    """检查Docker服务状态"""
    client = get_docker_client()
    if client:
        try:
            client.ping()
            return jsonify({
                'status': 'healthy',
                'docker': 'connected',
                'message': 'Code execution service is ready'
            }), 200
        except:
            return jsonify({
                'status': 'unhealthy',
                'docker': 'disconnected',
                'message': 'Docker service unavailable'
            }), 503
    else:
        return jsonify({
            'status': 'unhealthy',
            'docker': 'unavailable',
            'message': 'Cannot connect to Docker'
        }), 503