import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import { Box, ThemeProvider, createTheme, CssBaseline } from '@mui/material';

import { useAuth } from './contexts/AuthContext';

// Layout components
import Layout from './components/layout/Layout';

// Auth components
import Login from './pages/auth/Login';
import Register from './pages/auth/Register';

// Student components
import StudentDashboard from './pages/student/StudentDashboard';
import CourseList from './pages/student/CourseList';
import CourseView from './pages/student/CourseView';
import LessonView from './pages/student/LessonView';
import StudentProgress from './pages/student/StudentProgress';
import StudentProfilePage from './pages/student/StudentProfilePage';
import Achievements from './pages/student/Achievements';
import Feedback from './pages/student/Feedback';

// Teacher components
import TeacherDashboard from './pages/teacher/TeacherDashboard';
import CourseManagement from './pages/teacher/CourseManagement';
import CourseEditor from './pages/teacher/CourseEditor';
import LessonEditor from './pages/teacher/LessonEditor';
import StudentManagement from './pages/teacher/StudentManagement';
import StudentsPage from './pages/teacher/StudentsPage';

// Common components
import ProfilePage from './pages/common/ProfilePage';
import LandingPage from './pages/landing/LandingPage';


function App() {
  console.log('=== Environment Debug ===');
  console.log('NODE_ENV:', process.env.NODE_ENV);
  console.log('REACT_APP_API_URL:', process.env.REACT_APP_API_URL);
  console.log('All env vars:', process.env);
  console.log('========================');
  const { currentUser, loading } = useAuth();

  // Protected route component
  const ProtectedRoute = ({ children, requiredRole }) => {
    if (loading) {
      return <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>Loading...</Box>;
    }

    if (!currentUser) {
      return <Navigate to="/login" />;
    }

    if (requiredRole && currentUser.role !== requiredRole) {
      return <Navigate to={currentUser.role === 'teacher' ? '/teacher/dashboard' : '/student/dashboard'} />;
    }

    return children;
  };

  const neoBrutalismTheme = createTheme({
    palette: {
      primary: {
        main: '#6A0DAD', // 紫色
        contrastText: '#FFFFFF',
      },
      secondary: {
        main: '#9370DB', // 較淺的紫色
        contrastText: '#FFFFFF',
      },
      background: {
        default: '#FFFFFF',
        paper: '#F5F5F5',
      },
      text: {
        primary: '#000000',
      },
    },
    typography: {
      fontFamily: [
        // 您可以指定喜歡的字體，或保留 MUI 預設
        '-apple-system',
        'BlinkMacSystemFont',
        '"Segoe UI"',
        'Roboto',
        '"Helvetica Neue"',
        'Arial',
        'sans-serif',
        '"Apple Color Emoji"',
        '"Segoe UI Emoji"',
        '"Segoe UI Symbol"',
      ].join(','),
      h1: { fontWeight: 'bold' },
      h2: { fontWeight: 'bold' },
      h3: { fontWeight: 'bold' },
      h4: { fontWeight: 'bold' },
      h5: { fontWeight: 'bold' },
      h6: { fontWeight: 'bold' },
    },
    components: {
      MuiButton: {
        styleOverrides: {
          root: {
            borderRadius: 0,
            boxShadow: '4px 4px 0px rgba(0, 0, 0, 0.25)', // 黑色陰影
            border: '1px solid #000000', // 黑色邊框
            textTransform: 'none', // Neo Brutalism 通常不用全大寫按鈕文字
            fontWeight: 'bold',
          },
          containedPrimary: {
            backgroundColor: '#6A0DAD',
            color: '#FFFFFF',
            '&:hover': {
              backgroundColor: '#5A0BAB', // Hover 時稍微深一點的紫色
              boxShadow: '6px 6px 0px rgba(0, 0, 0, 0.3)',
            },
          },
          outlinedPrimary: {
            borderColor: '#6A0DAD',
            color: '#6A0DAD',
            '&:hover': {
              backgroundColor: 'rgba(106, 13, 173, 0.04)', // Hover 時輕微紫色背景
              borderColor: '#5A0BAB',
              boxShadow: '4px 4px 0px rgba(0, 0, 0, 0.25)',
            },
          }
        },
      },
      MuiPaper: { // 用於 Card, Accordion 等
        styleOverrides: {
          root: {
            border: '2px solid #000000',
            boxShadow: '5px 5px 0px rgba(0, 0, 0, 0.25)',
            borderRadius: 0, // Neo Brutalism 通常邊角銳利
          },
        },
      },
      MuiAccordion: {
        styleOverrides: {
          root: {
            border: '2px solid #000000',
            boxShadow: '5px 5px 0px rgba(0, 0, 0, 0.25)',
            borderRadius: 0,
            '&:before': { // 移除 Accordion 預設的頂部分隔線
              display: 'none',
            },
            '&.Mui-expanded': { // 展開時的樣式
              margin: '16px 0', // 避免與其他 Accordion 疊加
            }
          },
        },
      },
      MuiAppBar: { // 頂部導覽列
        styleOverrides: {
          root: {
            boxShadow: 'none', // Neo Brutalism 通常頂部導覽列沒有陰影或有硬邊框
            borderBottom: '2px solid #000000',
            backgroundColor: '#FFFFFF', // 可以設為白色或主色
            color: '#000000', // 文字顏色
          }
        }
      },
      MuiChip: {
        styleOverrides: {
          root: {
            borderRadius: '4px', // 可以設為 0 以獲得更銳利的邊角
            border: '1px solid #000000',
            fontWeight: 'bold',
          },
          colorPrimary: {
            backgroundColor: '#6A0DAD',
            color: '#FFFFFF',
          },
          colorSecondary: {
            backgroundColor: '#9370DB',
            color: '#FFFFFF',
          }
        },
      },
      // 您可以繼續為其他 MUI 元件 (如 MuiTextField, MuiCard 等) 添加 styleOverrides
    },
  });

  return (
    <ThemeProvider theme={neoBrutalismTheme}>
      <CssBaseline />
      <Routes>

        <Route path="/landing" element={<LandingPage />} />

        {/* Public routes */}
        <Route path="/login" element={
          currentUser ?
            <Navigate to={currentUser.role === 'teacher' ? '/teacher/dashboard' : '/student/dashboard'} /> :
            <Login />
        } />
        <Route path="/register" element={
          currentUser ?
            <Navigate to={currentUser.role === 'teacher' ? '/teacher/dashboard' : '/student/dashboard'} /> :
            <Register />
        } />

        {/* Student routes */}
        <Route path="/student" element={
          <ProtectedRoute requiredRole="student">
            <Layout />
          </ProtectedRoute>
        }>
          <Route path="dashboard" element={<StudentDashboard />} />
          <Route path="courses" element={<CourseList />} />
          <Route path="courses/:courseId" element={<CourseView />} />
          <Route path="lessons/:lessonId" element={<LessonView />} />
          <Route path="progress" element={<StudentProgress />} />
          <Route path="profile" element={<StudentProfilePage />} />
          <Route path="achievements" element={<Achievements />} />
          <Route path="feedback" element={<Feedback />} />
        </Route>

        {/* Teacher routes */}
        <Route path="/teacher" element={
          <ProtectedRoute requiredRole="teacher">
            <Layout />
          </ProtectedRoute>
        }>
          <Route path="dashboard" element={<TeacherDashboard />} />
          <Route path="courses" element={<CourseManagement />} />
          <Route path="courses/new" element={<CourseEditor />} />
          <Route path="courses/:courseId" element={<CourseEditor />} />
          <Route path="units/:unitId/lessons/new" element={<LessonEditor />} />
          <Route path="lessons/:lessonId" element={<LessonEditor />} />
          <Route path="students" element={<StudentsPage />} />
          <Route path="students/:studentId/progress" element={<StudentProgress />} />
          <Route path="courses/:courseId/students" element={<StudentManagement />} />
          <Route path="profile" element={<ProfilePage />} />
        </Route>

        {/* Default redirect */}
        <Route path="/" element={
          currentUser ?
            <Navigate to={currentUser.role === 'teacher' ? '/teacher/dashboard' : '/student/dashboard'} /> :
            <Navigate to="/landing" />
        } />

        {/* Catch all - redirect to appropriate dashboard or login */}
        <Route path="*" element={
          currentUser ?
            <Navigate to={currentUser.role === 'teacher' ? '/teacher/dashboard' : '/student/dashboard'} /> :
            <Navigate to="/landing" />
        } />
      </Routes>
    </ThemeProvider>
  );
}

export default App;
