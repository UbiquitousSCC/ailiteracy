import React, { useState, useEffect, useCallback } from 'react';
import { useAuth } from '../../contexts/AuthContext'; // Import useAuth hook
import { 
  Container, 
  Typography, 
  Box, 
  CircularProgress, 
  Alert,
  Paper,
  Stepper,
  Step,
  StepLabel,
  Button,
  Divider,
  Card,
  CardContent,
  FormControl,
  FormControlLabel,
  RadioGroup,
  Radio,
  TextField,
  Snackbar
} from '@mui/material';
import { useParams, useNavigate } from 'react-router-dom';
import axios from 'axios';
import CodeMirror from '@uiw/react-codemirror';
import { python } from '@codemirror/lang-python';

import PlayArrowIcon from '@mui/icons-material/PlayArrow';
import { DragDropContext, Droppable, Draggable } from 'react-beautiful-dnd';
import { ArrowBack, ArrowForward, Check, Code, QuestionAnswer, TextFields } from '@mui/icons-material';

const LessonView = () => {
  // Auth and Router hooks
  const { lessonId } = useParams();
  const navigate = useNavigate();
  const { currentUser } = useAuth();

  // Lesson state
  const [lesson, setLesson] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [snackbar, setSnackbar] = useState({ open: false, message: '', severity: 'success' });

  // Coding exercise state
  const [code, setCode] = useState('');
  const [codeOutput, setCodeOutput] = useState('');
  const [codeRunning, setCodeRunning] = useState(false);
  const [response, setResponse] = useState(null); // For storing backend response from code execution/submission

  // New State for unit/course navigation
  const [courseStructure, setCourseStructure] = useState(null);
  const [currentUnitLessons, setCurrentUnitLessons] = useState([]);
  const [currentLessonIndexInUnit, setCurrentLessonIndexInUnit] = useState(-1);
  const [courseLoading, setCourseLoading] = useState(false);
  const [courseError, setCourseError] = useState('');

  // Multiple choice state (remains for potential future use or if parts of UI still reference it)
  const [selectedOptions, setSelectedOptions] = useState({});
  
  // Fill-in-the-blank state (remains for potential future use or if parts of UI still reference it)
  const [blanks, setBlanks] = useState([]); // This might have been for draggable items
  const [filledBlanks, setFilledBlanks] = useState([]); // For user input in text fields

  // useEffect for fetching current lesson data
  useEffect(() => {

    const fetchLessonData = async () => {
      try {
        setLoading(true);
        
        // Fetch lesson details including all content types
        const lessonResponse = await axios.get(`/api/lessons/${lessonId}`);
        const lessonData = lessonResponse.data.lesson;
        
        // 适配后端的数据结构
        // 后端返回的是content和content_type字段，而不是前端期望的数组结构
        const adaptedLesson = {
          ...lessonData,
          coding_exercises: [],
          multiple_choice_questions: [],
          fill_blank_exercises: []
        };
        
        // 根据content_type来填充相应的数组
        if (lessonData.content_type === 'coding') {
          adaptedLesson.coding_exercises = [{
            instructions: lessonData.content.instructions || '',
            starter_code: lessonData.content.starter_code || '',
            solution_code: lessonData.content.solution_code || '',
            test_code: lessonData.content.test_code || ''
          }];

          if (currentUser) { // Ensure currentUser is loaded
            const studentId = currentUser.id;
            const localStorageKey = `lessonCode_${lessonId}_${studentId}`;
            const savedCode = localStorage.getItem(localStorageKey);

            if (savedCode !== null) {
              setCode(savedCode);
            } else {
              // Fallback to starter code if no saved code is found
              setCode(adaptedLesson.coding_exercises[0].starter_code || '# 在這裡編寫您的程式碼\n');
            }
          } else {
            // If user is not logged in, use starter code
            setCode(adaptedLesson.coding_exercises[0].starter_code || '# 在這裡編寫您的程式碼\n');
          }
        } 
        else if (lessonData.content_type === 'multiple_choice') {
          adaptedLesson.multiple_choice_questions = [{
            question_text: lessonData.content.question || '',
            options: lessonData.content.options || [],
            correct_option_index: lessonData.content.correct_option || 0
          }];
        } 
        else if (lessonData.content_type === 'fill_in_blank') {
          adaptedLesson.fill_blank_exercises = [{
            text_template: lessonData.content.text || '',
            blanks: JSON.stringify(lessonData.content.blanks || [])
          }];
          
          // 初始化填空题内容
          const blanksList = lessonData.content.blanks || [];
          setBlanks(blanksList);
          setFilledBlanks(Array(blanksList.length).fill(null));
        }
        
        setLesson(adaptedLesson);
      } catch (err) {
        setError('載入課程資料失敗');
        console.error(err);
      } finally {
        setLoading(false);
      }
    };
    
    fetchLessonData();
  }, [lessonId, currentUser]);

  // NEW useEffect for fetching course structure when lesson.course_id is available
  useEffect(() => {
    if (lesson && lesson.course_id) {
      const fetchCourseStructure = async () => {
        setCourseLoading(true);
        setCourseError('');
        try {
          const courseResponse = await axios.get(`/api/courses/${lesson.course_id}`);
          setCourseStructure(courseResponse.data.course); 
        } catch (err) {
          console.error("Failed to fetch course structure:", err);
          setCourseError('無法載入課程結構，影響自動導航功能。');
          setSnackbar({ open: true, message: '無法載入課程結構，請稍後再試或聯繫管理員。', severity: 'error' });
        } finally {
          setCourseLoading(false);
        }
      };
      fetchCourseStructure();
    }
  }, [lesson]); // Runs when lesson (and thus lesson.course_id) changes

  // NEW useEffect for processing course structure to find current unit's lessons
  useEffect(() => {
    if (courseStructure && lesson && lesson.unit_id) {
      const unit = courseStructure.units.find(u => u.id === lesson.unit_id);
      if (unit && unit.lessons && unit.lessons.length > 0) {
        const sortedLessons = [...unit.lessons].sort((a, b) => a.order - b.order);
        setCurrentUnitLessons(sortedLessons);
        const currentIndex = sortedLessons.findIndex(l => l.id === parseInt(lessonId, 10));
        setCurrentLessonIndexInUnit(currentIndex);
      } else {
        setCurrentUnitLessons([]);
        setCurrentLessonIndexInUnit(-1);
        if (unit && (!unit.lessons || unit.lessons.length === 0)) {
            console.warn(`No lessons found in unit ${lesson.unit_id} within the course structure.`);
        } else if (!unit) {
            console.warn(`Unit ${lesson.unit_id} not found in course structure.`);
        }
      }
    } else {
        setCurrentUnitLessons([]);
        setCurrentLessonIndexInUnit(-1);
    }
  }, [courseStructure, lesson, lessonId]); // Runs when courseStructure or lesson (for unit_id and lesson.id) changes


  const handleCodeChange = useCallback((value) => {
    setCode(value);
    if (currentUser) { // Ensure currentUser is loaded before saving
      const studentId = currentUser.id;
      const localStorageKey = `lessonCode_${lessonId}_${studentId}`;
      localStorage.setItem(localStorageKey, value);
    }
  }, [lessonId, currentUser]);

  // 僅執行程式碼，不提交評分
  const executeCode = async () => {
    if (!(lesson.content_type === 'coding' || (lesson.coding_exercises && lesson.coding_exercises.length > 0))) return;
    
    try {
      setCodeRunning(true);
      setCodeOutput('正在執行程式碼...');
      // 使用獨立的執行API
      const response = await axios.post(`/api/code/run`, {
        code: code
      });
      
      setCodeOutput(response.data.output || (response.data.error ? `錯誤: ${response.data.error}` : 'No output'));
      // 清除測試結果
      setResponse(null);
    } catch (error) {
      console.error('Error executing code:', error);
      setCodeOutput(error.response?.data?.error || error.message || '執行程式碼時發生錯誤');
    } finally {
      setCodeRunning(false);
    }
  };

  // 提交程式碼並評分
  const runCode = async () => {
    if (!(lesson.content_type === 'coding' || (lesson.coding_exercises && lesson.coding_exercises.length > 0))) return;
    
    try {
      setCodeRunning(true);
      setCodeOutput('正在執行並評分程式碼...');
      // 使用新的 code_runner API
      const response = await axios.post(`/api/code/submit/${lessonId}`, {
        code: code
      });
      
      setCodeOutput(response.data.output || 'No output');
      setResponse(response.data);
      
      // 顯示評分結果
      if (response.data.passed) {
        setSnackbar({
          open: true,
          message: `Success! You scored ${response.data.score}%`,
          severity: 'success'
        });
      } else {
        setSnackbar({
          open: true,
          message: 'Your code did not pass all tests. Try again!',
          severity: 'warning'
        });
      }
    } catch (error) {
      console.error('Error running code:', error);
      
      // 處理 422 錯誤（通常是認證問題）
      if (error.response?.status === 422) {
        setCodeOutput('認證錯誤：請重新登入');
        setSnackbar({
          open: true,
          message: '認證已過期，請重新登入',
          severity: 'error'
        });
        // 可選：自動導向登入頁面
        setTimeout(() => {
          navigate('/login');
        }, 2000);
      } else if (error.response?.status === 401) {
        setCodeOutput('未授權：請重新登入');
        setSnackbar({
          open: true,
          message: '請先登入才能提交程式碼',
          severity: 'error'
        });
        setTimeout(() => {
          navigate('/login');
        }, 2000);
      } else {
        setCodeOutput(error.response?.data?.error || error.message || '提交程式碼時發生錯誤');
        setSnackbar({
          open: true,
          message: error.response?.data?.error || '執行程式碼出錯',
          severity: 'error'
        });
      }
    } finally {
      setCodeRunning(false);
    }
  };

  const handleOptionChange = (questionId, optionIndex) => {
    setSelectedOptions({
      ...selectedOptions,
      [questionId]: optionIndex
    });
  };

  const submitMultipleChoice = async () => {
    if (!((lesson.content_type === 'multiple_choice' && lesson.content) || (lesson.multiple_choice_questions && lesson.multiple_choice_questions.length > 0))) return;
    
    try {
      // 根據content_type調整submissions格式
      let submissions;
      
      if (lesson.content_type === 'multiple_choice') {
        // 使用content數據結構
        submissions = { answers: selectedOptions };
      } else {
        // 使用數組數據結構
        submissions = Object.entries(selectedOptions).map(([questionId, optionIndex]) => ({
          question_id: parseInt(questionId),
          selected_option_index: optionIndex
        }));
      }
      
      const response = await axios.post(`/api/progress/multiple-choice/${lessonId}`, {
        answers: selectedOptions
      });
      
      setSnackbar({
        open: true,
        message: `Submitted! You scored ${response.data.score}%`,
        severity: response.data.score >= 70 ? 'success' : 'warning'
      });
      
    } catch (err) {
      setSnackbar({
        open: true,
        message: 'Error submitting answers',
        severity: 'error'
      });
    }
  };

  const handleDragEnd = (result) => {
    if (!result.destination) return;
    
    const sourceIndex = result.source.index;
    const destIndex = result.destination.droppableId.split('-')[1];
    
    const newFilledBlanks = [...filledBlanks];
    newFilledBlanks[destIndex] = blanks[destIndex].options[sourceIndex];
    
    setFilledBlanks(newFilledBlanks);
  };

  const submitFillBlanks = async () => {
    // 检查lesson.content_type为fill_in_blank或存在fill_blank_exercises
    if (!(lesson.content_type === 'fill_in_blank' || (lesson.fill_blank_exercises && lesson.fill_blank_exercises.length > 0))) return;
    
    try {
      // 使用lesson.id而不是exercise.id
      
      const response = await axios.post(`/api/progress/fill-blank/${lessonId}`, {
        answers: filledBlanks
      });
      
      setSnackbar({
        open: true,
        message: `Submitted! You scored ${response.data.score}%`,
        severity: response.data.score >= 70 ? 'success' : 'warning'
      });
      
    } catch (err) {
      setSnackbar({
        open: true,
        message: 'Error submitting answers',
        severity: 'error'
      });
    }
  };

  

  

  const handleCloseSnackbar = () => {
    setSnackbar({ ...snackbar, open: false });
  };

  // NEW Navigation Handler
  const handleAdvance = () => {
    if (currentLessonIndexInUnit === -1 || currentUnitLessons.length === 0) {
      setSnackbar({ open: true, message: '無法確定下一課，資料可能仍在載入中或配置有誤。', severity: 'warning' });
      return;
    }

    const nextLessonIndex = currentLessonIndexInUnit + 1;
    if (nextLessonIndex < currentUnitLessons.length) {
      const nextLesson = currentUnitLessons[nextLessonIndex];
      navigate(`/student/lessons/${nextLesson.id}`);
    } else {
      // Last lesson in the unit
      if (lesson && lesson.course_id) {
        navigate(`/student/courses/${lesson.course_id}`);
      } else {
        // Fallback if course_id is somehow not available
        setSnackbar({ open: true, message: '課程ID遺失，無法返回課程頁面。', severity: 'error' });
        navigate('/student/dashboard'); // Or some other safe fallback
      }
    }
  };


  if (loading) {
    return (
      <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '80vh' }}>
        <CircularProgress />
      </Box>
    );
  }

  if (!lesson) {
    return (
      <Container maxWidth="lg" sx={{ mt: 4 }}>
        <Alert severity="error">課程不存在或您沒有訪問此課程的權限。</Alert>
      </Container>
    );
  }

  const steps = [
    { label: '編碼練習', icon: <Code /> },
    { label: '選擇題', icon: <QuestionAnswer /> },
    { label: '填空題', icon: <TextFields /> }
  ];

  // Render the text with blanks for the fill-in-the-blank exercise
  const renderTextWithBlanks = () => {
    if (!lesson.fill_blank_exercises || lesson.fill_blank_exercises.length === 0) {
      return <Typography>沒有可用的填空練習。</Typography>;
    }
    
    const exercise = lesson.fill_blank_exercises[0];
    let textParts = exercise.text_template.split(/{{(\d+)}}/);
    
    return (
      <Box>
        {textParts.map((part, index) => {
          if (index % 2 === 0) {
            // Regular text
            return <Typography component="span" key={index}>{part}</Typography>;
          } else {
            // Blank to fill
            const blankIndex = parseInt(part);
            return (
              <Droppable droppableId={`blank-${blankIndex}`} key={index}>
                {(provided, snapshot) => (
                  <Box
                    ref={provided.innerRef}
                    {...provided.droppableProps}
                    component="span"
                    sx={{
                      display: 'inline-block',
                      minWidth: '120px',
                      minHeight: '30px',
                      border: '2px dashed',
                      borderColor: snapshot.isDraggingOver ? 'primary.main' : 'grey.400',
                      borderRadius: '4px',
                      padding: '0 8px',
                      margin: '0 4px',
                      backgroundColor: snapshot.isDraggingOver ? 'rgba(63, 81, 181, 0.1)' : 'transparent',
                    }}
                  >
                    {filledBlanks[blankIndex] || ''}
                    {provided.placeholder}
                  </Box>
                )}
              </Droppable>
            );
          }
        })}
      </Box>
    );
  };

  return (
    <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
      <Paper elevation={3} sx={{ p: 3, mb: 4 }}>
        <Typography variant="h4" gutterBottom>
          {lesson.title}
        </Typography>
        <Typography variant="body1" color="text.secondary">
          {lesson.description}
        </Typography>
      </Paper>
      
      {error && <Alert severity="error" sx={{ mb: 3 }}>{error}</Alert>}
      
      <Box sx={{ width: '100%' }}>
        
        <Box sx={{ mt: 2, mb: 4 }}>
            <Box>
              <Typography variant="h6" gutterBottom>
                程式碼練習
              </Typography>
              
              {((lesson.content_type === 'coding' && lesson.content) || (lesson.coding_exercises && lesson.coding_exercises.length > 0)) ? (
                <>
                  <Card variant="outlined" sx={{ mb: 3 }}>
                    <CardContent>
                      <Typography variant="body1" gutterBottom>
                        <strong>指令：</strong>
                      </Typography>
                      <Typography variant="body2">
                        {lesson.content_type === 'coding' ? lesson.content.instructions : lesson.coding_exercises[0].instructions}
                      </Typography>
                    </CardContent>
                  </Card>
                  
                  <Typography variant="subtitle1" gutterBottom>
                    您的程式碼：
                  </Typography>
                  <Box className="code-editor" sx={{ mb: 2 }}>
                    <CodeMirror
                      value={code}
                      height="400px"
                      extensions={[python()]}
                      onChange={handleCodeChange}
                      // theme="okaidia" // Remove this prop
                    />
                  </Box>
                  
                  <Box sx={{ mt: 2, display: 'flex', gap: 1 }}>
                    <Button 
                      variant="contained" 
                      color="secondary"
                      startIcon={<PlayArrowIcon />} 
                      onClick={executeCode} 
                      disabled={codeRunning}
                    >
                      執行程式碼
                    </Button>
                    <Button 
                      variant="contained" 
                      color="primary" 
                      startIcon={<Check />} 
                      onClick={runCode} 
                      disabled={codeRunning}
                    >
                      提交並評分
                    </Button>
                  </Box>
                  
                  {codeOutput && (
                    <Box sx={{ mt: 2 }}>
                      <Typography variant="subtitle1" gutterBottom>
                        執行結果：
                      </Typography>
                      <Paper 
                        variant="outlined" 
                        sx={{ 
                          p: 2, 
                          backgroundColor: '#f5f5f5',
                          fontFamily: 'monospace',
                          whiteSpace: 'pre-wrap'
                        }}
                      >
                        {codeOutput}
                      </Paper>
                      
                      {/* 測試結果區域 */}
                      {response && response.test_results && (
                        <Box sx={{ mt: 3 }}>
                          <Typography variant="subtitle1" gutterBottom>
                            測試結果：
                          </Typography>
                          <Box sx={{ mb: 2 }}>
                            <Typography variant="body2">
                              分數：<strong>{response.score || 0}</strong>/{response.max_score || 100}
                            </Typography>
                          </Box>
                          {response.test_results.map((test, index) => (
                            <Paper
                              key={index}
                              variant="outlined"
                              sx={{
                                p: 1.5,
                                mb: 1,
                                borderLeft: test.passed ? '4px solid #4caf50' : '4px solid #f44336',
                                backgroundColor: test.passed ? '#e8f5e9' : '#ffebee'
                              }}
                            >
                              <Typography variant="body2">
                                <strong>測試 {test.test_case}：</strong> {test.message}
                              </Typography>
                            </Paper>
                          ))}
                        </Box>
                      )}
                    </Box>
                  )}
                </>
              ) : (
                <Alert severity="info">沒有可用的程式碼練習。</Alert>
              )}
            </Box>
        </Box>
        
        <Divider sx={{ my: 3 }} />
        
        <Box sx={{ display: 'flex', justifyContent: 'space-between', mt: 3, mb: 2 }}>
          <Button 
            variant="outlined"
            onClick={() => navigate(lesson && lesson.course_id ? `/student/courses/${lesson.course_id}` : '/student/dashboard')}
            startIcon={<ArrowBack />}
          >
            返回課程總覽
          </Button>
          <Button
            variant="contained"
            onClick={handleAdvance}
            disabled={courseLoading || currentLessonIndexInUnit === -1 || currentUnitLessons.length === 0}
            endIcon={currentLessonIndexInUnit !== -1 && currentLessonIndexInUnit === currentUnitLessons.length - 1 ? <Check /> : <ArrowForward />}
          >
            {courseLoading ? '載入中...' : 
              (currentLessonIndexInUnit !== -1 && currentUnitLessons.length > 0 ? 
                (currentLessonIndexInUnit === currentUnitLessons.length - 1 ? '完成單元，返回課程' : '下一課') 
              : '下一步')}
          </Button>
        </Box>
      </Box>
      
      <Snackbar
        open={snackbar.open}
        autoHideDuration={6000}
        onClose={handleCloseSnackbar}
        message={snackbar.message}
        severity={snackbar.severity}
      />
    </Container>
  );
};

export default LessonView;