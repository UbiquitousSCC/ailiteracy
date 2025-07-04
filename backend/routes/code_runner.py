from flask import Blueprint, request, jsonify
from backend.models.user import User
from backend.models.lesson import Lesson
from backend.models.progress import Progress, SubmissionHistory
from backend import db
from datetime import datetime
import requests
import re

bp = Blueprint('code_runner', __name__, url_prefix='/api/code')

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
        r'for.*in.*range\s*\(\s*\d{6,}',
    ]
    
    for pattern in dangerous_patterns:
        if re.search(pattern, code, re.IGNORECASE):
            return False, f"程式碼包含不安全的操作: {pattern}"
    
    return True, "程式碼安全"

def execute_python_code(code):
    """使用 Piston API 執行 Python 程式碼"""
    # 安全檢查
    is_safe, safety_message = is_code_safe(code)
    if not is_safe:
        return False, "", "", safety_message
    
    try:
        # 使用 Piston API
        response = requests.post(
            "https://emkc.org/api/v2/piston/execute",
            json={
                "language": "python",
                "version": "3.10",
                "files": [{
                    "content": code
                }]
            },
            timeout=10
        )
        
        if response.status_code == 200:
            result = response.json()
            run = result.get('run', {})
            
            # 獲取輸出
            stdout = run.get('stdout', '')
            stderr = run.get('stderr', '')
            
            # 檢查執行結果
            if run.get('code') == 0:
                # 執行成功（退出碼為 0）
                return True, stdout, stderr, "執行成功"
            else:
                # 執行失敗（非零退出碼）
                return False, stdout, stderr, "程式碼執行出錯"
        else:
            return False, "", "", f"API 錯誤: {response.status_code}"
            
    except requests.exceptions.Timeout:
        return False, "", "執行超時", "程式碼執行超過了限制時間"
    except requests.exceptions.ConnectionError:
        return False, "", "", "無法連接到執行服務"
    except Exception as e:
        return False, "", "", f"執行失敗: {str(e)}"

@bp.route('/run', methods=['POST'])
def run_code():
    """運行程式碼並返回結果"""
    data = request.get_json()
    
    if not data or 'code' not in data:
        return jsonify({'error': 'No code submitted'}), 400
    
    submitted_code = data.get('code', '').strip()
    
    if not submitted_code:
        return jsonify({'error': 'Empty code submitted'}), 400
    
    # 執行程式碼
    success, stdout, stderr, message = execute_python_code(submitted_code)
    
    if success:
        return jsonify({
            'message': 'Code executed successfully',
            'output': stdout,
            'error': stderr if stderr else None,
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
    """提交編程作業並自動評分"""
    data = request.get_json()
    
    # 從請求中獲取 student_id，如果沒有則使用默認值 1
    user_id = data.get('student_id', 1)
    
    # 驗證用戶
    user = User.query.get(user_id)
    if not user or not user.is_student():
        return jsonify({'error': 'Only students can submit solutions'}), 403
    
    if not data or 'code' not in data:
        return jsonify({'error': 'No code submitted'}), 400
    
    submitted_code = data.get('code', '').strip()
    
    if not submitted_code:
        return jsonify({'error': 'Empty code submitted'}), 400
    
    # 驗證課程存在
    lesson = Lesson.query.get(lesson_id)
    if not lesson:
        return jsonify({'error': 'Lesson not found'}), 404
    
    try:
        # 執行程式碼並獲取實際輸出
        success, stdout, stderr, message = execute_python_code(submitted_code)
        
        # 評分邏輯
        test_results = []
        passed_tests = 0
        total_tests = 2
        
        if not success:
            # 程式碼執行失敗
            test_results = [{
                'test_case': 1,
                'passed': False,
                'message': f'程式碼執行失敗: {stderr or message}'
            }]
            score = 0
        else:
            # 測試1: 程式碼成功執行
            test_results.append({
                'test_case': 1,
                'passed': True,
                'message': '程式碼成功執行'
            })
            passed_tests += 1
            
            # 測試2: 檢查是否有輸出
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
        
        # 計算分數
        score = int((passed_tests / total_tests) * 100)
        
        # 記錄提交歷史
        submission = SubmissionHistory(
            student_id=user_id,
            lesson_id=lesson_id,
            submission_type='coding',
            content=submitted_code,
            score=score,
            feedback=f'通過 {passed_tests}/{total_tests} 個測試用例'
        )
        db.session.add(submission)
        
        # 更新或創建進度記錄
        progress = Progress.query.filter_by(student_id=user_id, lesson_id=lesson_id).first()
        if progress:
            if score > progress.coding_score:
                progress.coding_score = score
            if passed_tests == total_tests:
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
                completed=(passed_tests == total_tests)
            )
            db.session.add(progress)
        
        db.session.commit()
        
        # 準備返回的輸出
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
    """檢查服務狀態"""
    try:
        # 測試 Piston API
        response = requests.post(
            "https://emkc.org/api/v2/piston/execute",
            json={
                "language": "python",
                "version": "3.10",
                "files": [{
                    "content": "print('Hello from Piston!')"
                }]
            },
            timeout=5
        )
        
        if response.status_code == 200:
            result = response.json()
            output = result.get('run', {}).get('stdout', '')
            return jsonify({
                'status': 'healthy',
                'service': 'Piston API',
                'message': 'Code execution service is ready',
                'test_output': output
            }), 200
        else:
            return jsonify({
                'status': 'unhealthy',
                'service': 'Piston API',
                'message': f'API returned status {response.status_code}'
            }), 503
    except Exception as e:
        return jsonify({
            'status': 'unhealthy',
            'service': 'Piston API',
            'message': f'Cannot connect to execution service: {str(e)}'
        }), 503