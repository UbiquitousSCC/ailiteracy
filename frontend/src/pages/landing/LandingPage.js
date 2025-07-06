import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  Box,
  Container,
  Grid,
  Card,
  CardContent,
  IconButton,
  Drawer,
  List,
  ListItem,
  ListItemText,
  Paper,
  Avatar,
  Fab,
  Link,
  Divider,
  useMediaQuery,
  useTheme,
  AppBar,
  Toolbar,
  Typography,
  Button,
  TextField,
  Chip,
} from '@mui/material';
import {
  Psychology as BrainIcon,
  People as PeopleIcon,
  BarChart as BarChartIcon,
  PlayArrow as PlayIcon,
  CheckCircle as CheckCircleIcon,
  Star as StarIcon,
  ArrowForward as ArrowForwardIcon,
  Menu as MenuIcon,
  Close as CloseIcon,
  Email as EmailIcon,
  Phone as PhoneIcon,
  LocationOn as LocationIcon,
  GitHub as GitHubIcon,
  Twitter as TwitterIcon,
  LinkedIn as LinkedInIcon,
  EmojiEvents as TrophyIcon,
  MyLocation as TargetIcon,
  FlashOn as ZapIcon,
  Book as BookOpenIcon,
  Code as Code2Icon,
  TrendingUp as TrendingUpIcon,
  Memory as CpuIcon,
  Visibility as EyeIcon,
  Mic as MicIcon,
  SportsEsports as GameController2Icon,
} from '@mui/icons-material';
import './LandingPage.css';

// 浮動背景元素組件
const FloatingElements = () => (
  <Box className="floating-background">
    <Box className="floating-element floating-1" />
    <Box className="floating-element floating-2" />
    <Box className="floating-element floating-3" />
    <Box className="floating-element floating-4" />
  </Box>
);

// 程式碼展示組件 - AI模型訓練版本
const AICodeDemo = () => (
  <Paper elevation={0} className="code-demo">
    <Box className="code-demo-dots">
      <Box className="dot red" />
      <Box className="dot yellow" />
      <Box className="dot green" />
    </Box>
    <Box className="code-terminal">
      <Box className="code-comment"># AI模型訓練範例</Box>
      <Box className="code-line">
        <Box component="span" className="code-keyword">import</Box>{' '}
        <Box component="span" className="code-function">tensorflow</Box> as tf
      </Box>
      <Box className="code-line">
        <Box component="span" className="code-keyword">from</Box>{' '}
        <Box component="span" className="code-function">sklearn</Box> import datasets
      </Box>
      <Box className="code-line">
        <Box component="span" className="code-comment"># 建立神經網路模型</Box>
      </Box>
      <Box className="code-line">
        model = tf.<Box component="span" className="code-function">keras</Box>.Sequential([
      </Box>
      <Box className="code-line indent-1">
        tf.keras.layers.<Box component="span" className="code-function">Dense</Box>(128),
      </Box>
      <Box className="code-line indent-1">
        tf.keras.layers.<Box component="span" className="code-function">Dense</Box>(10)
      </Box>
      <Box className="code-line">])</Box>
    </Box>
    <Box className="code-result">
      <Box className="result-text">
        <BrainIcon className="result-icon" sx={{ color: 'var(--neo-purple)' }} />
        <Typography variant="body2" className="result-label" sx={{ color: 'var(--neo-purple)', fontWeight: 'bold' }}>
          AI模型建構中...
        </Typography>
      </Box>
      <Box className="accuracy-badge">
        <Chip
          label="準確率: 95%"
          sx={{
            bgcolor: 'var(--neo-lime)',
            color: 'black',
            border: '1px solid black',
            fontSize: '0.75rem',
            fontWeight: 'bold',
          }}
        />
      </Box>
    </Box>
  </Paper>
);

function LandingPage() {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [loginForm, setLoginForm] = useState({ username: '', password: '' });
  const theme = useTheme();
  const isMobile = useMediaQuery(theme.breakpoints.down('md'));
  const navigate = useNavigate();

  const handleGetStarted = () => {
    navigate('/login');
  };

  const handleLogin = () => {
    navigate('/login');
  };

  const handleLoginSubmit = (e) => {
    e.preventDefault();
    navigate('/login');
  };

  // 學習階段資料
  const learningStages = [
    {
      stage: '第一階段',
      units: '單元 1-10',
      title: '程式基礎建立',
      icon: <BookOpenIcon className="feature-icon" />,
      color: 'stage-card-gray',
      items: ['運算子與資料型別', '變數與陣列操作', 'AI基本概念認識']
    },
    {
      stage: '第二階段',
      units: '單元 11-25',
      title: 'APCS競賽準備',
      icon: <TargetIcon className="feature-icon-alt" />,
      color: 'stage-card-lime',
      items: ['條件判斷與迴圈', '函數與遞迴應用', '物件導向程式設計']
    },
    {
      stage: '第三階段',
      units: '單元 26-35',
      title: 'AI模型與應用',
      icon: <BrainIcon className="feature-icon" />,
      color: 'stage-card-lavender',
      items: ['機器學習五步驟', '資料視覺化分析', '回歸模型實作']
    },
    {
      stage: '第四階段',
      units: '單元 36-48',
      title: '進階AI技術',
      icon: <ZapIcon className="feature-icon-black" />,
      color: 'stage-card-white',
      items: ['影像與語音辨識', '深度學習模型', 'AI倫理與應用']
    }
  ];

  // APCS級分資料
  const apcsLevels = [
    { range: '41-50分', level: '5級分', name: '進階', color: '#22C55E' },
    { range: '31-40分', level: '4級分', name: '中階', color: '#3B82F6' },
    { range: '21-30分', level: '3級分', name: '基礎', color: '#EAB308' },
    { range: '11-20分', level: '2級分', name: '入門', color: '#F97316' },
    { range: '0-10分', level: '1級分', name: '初學', color: '#EF4444' }
  ];

  // 頂尖大學APCS門檻
  const universityRequirements = [
    { school: '國立臺灣大學', dept: '資訊工程學系', concept: '4級分', practice: '4級分' },
    { school: '國立清華大學', dept: '資訊工程學系', concept: '4級分', practice: '4級分' },
    { school: '國立陽明交通大學', dept: '資訊工程學系', concept: '4級分', practice: '4級分' },
    { school: '國立成功大學', dept: '工業與資訊管理學系', concept: '4級分', practice: '3級分' },
    { school: '國立中興大學', dept: '資訊工程學系', concept: '4級分', practice: '3級分' },
    { school: '國立中央大學', dept: '資訊工程學系', concept: '4級分', practice: '4級分' }
  ];

  // AI模組資料
  const aiModules = [
    // Python 基礎模組
    {
      icon: <CpuIcon className="feature-icon" />,
      title: 'Python 程式入門',
      description: '從變數、資料型態到輸入輸出，建立基礎程式能力',
      color: '#7C3AED',
      features: ['變數與資料型別', 'print 輸出', 'input 輸入', '運算子使用']
    },
    {
      icon: <BarChartIcon className="feature-icon" />,
      title: '流程控制與邏輯',
      description: '學會使用條件判斷與迴圈，打造互動程式邏輯',
      color: 'var(--neo-purple)',
      features: ['if/else 判斷', 'for/while 迴圈', '巢狀邏輯', '錯誤處理']
    },
    {
      icon: <GameController2Icon className="feature-icon" />,
      title: 'AI素養與倫理',
      description: '探索AI在社會中的角色，學習判斷科技帶來的影響與責任',
      color: '#2563EB',
      features: [
        'AI偏誤與公平性',
        '資料隱私與安全',
        'AI決策模擬討論'
      ]
    },
    {
      icon: <MicIcon className="feature-icon" />,
      title: '認識 AI 是什麼',
      description: '了解 AI 在生活中的應用與基本概念',
      color: '#16A34A',
      features: ['什麼是 AI', '日常AI應用', '機器學習 vs 人工智慧', '常見案例討論']
    },
    {
      icon: <EyeIcon className="feature-icon" />,
      title: '資料與特徵',
      description: '學會如何觀察資料、理解 AI 為什麼需要特徵',
      color: '#EA580C',
      features: ['資料是什麼', '分類與數值資料', '特徵挑選概念', '簡單統計方法']
    },
    {
      icon: <TrendingUpIcon className="feature-icon" />,
      title: 'AI 小任務實作',
      description: '用簡單邏輯與資料模擬 AI 決策流程',
      color: '#DC2626',
      features: ['簡易資料判斷', 'if邏輯模擬模型', 'AI判斷流程', '任務體驗']
    }
  ];


  return (
    <Box className="landing-page">
      {/* 浮動背景元素 */}
      <FloatingElements />

      {/* 頭部導航 */}
      <AppBar position="sticky" className="landing-header">
        <Container maxWidth="xl">
          <Toolbar className="landing-toolbar">
            <Box className="logo-section">
              <Avatar className="logo-avatar">
                <BrainIcon />
              </Avatar>
              <Box sx={{ display: 'flex', flexDirection: 'column' }}>
                <Typography variant="h6" className="logo-text">
                  AI素養學習平台
                </Typography>
                <Typography variant="caption" sx={{ color: 'var(--neo-purple)', fontWeight: 'bold', fontSize: '0.75rem' }}>
                  成大AI園丁團隊
                </Typography>
              </Box>
            </Box>

            {!isMobile ? (
              <Box className="desktop-nav">
                <Link href="#about" className="nav-link">課程介紹</Link>
                <Link href="#features" className="nav-link">APCS準備</Link>
                <Link href="#ai-modules" className="nav-link">AI模組</Link>
                <Link href="#login" className="nav-link">教師登入</Link>
                <Button
                  variant="contained"
                  className="cta-button"
                  onClick={handleGetStarted}
                >
                  立即開始學習
                </Button>
              </Box>
            ) : (
              <IconButton
                onClick={() => setIsMenuOpen(true)}
                className="mobile-menu-button"
              >
                <MenuIcon />
              </IconButton>
            )}
          </Toolbar>
        </Container>
      </AppBar>

      {/* 行動端選單 */}
      <Drawer
        anchor="right"
        open={isMenuOpen}
        onClose={() => setIsMenuOpen(false)}
        classes={{ paper: 'mobile-drawer' }}
      >
        <Box className="mobile-menu">
          <Box className="mobile-menu-header">
            <IconButton onClick={() => setIsMenuOpen(false)}>
              <CloseIcon />
            </IconButton>
          </Box>
          <List>
            <ListItem>
              <ListItemText primary="課程介紹" className="mobile-nav-item" />
            </ListItem>
            <ListItem>
              <ListItemText primary="APCS準備" className="mobile-nav-item" />
            </ListItem>
            <ListItem>
              <ListItemText primary="AI模組" className="mobile-nav-item" />
            </ListItem>
            <ListItem>
              <ListItemText primary="教師登入" className="mobile-nav-item" />
            </ListItem>
            <ListItem>
              <Button
                fullWidth
                variant="contained"
                className="mobile-cta-button"
                onClick={handleGetStarted}
              >
                立即開始學習
              </Button>
            </ListItem>
          </List>
        </Box>
      </Drawer>

      {/* 主頁橫幅 */}
      <Box className="hero-section">
        <Container maxWidth="xl">
          <Grid container spacing={6} alignItems="center">
            <Grid item xs={12} lg={6}>
              <Box className="hero-content">
                <Box className="achievement-badge" sx={{ mb: 2 }}>
                  <Chip
                    label="🏆 APCS 4-5級分保證"
                    sx={{
                      bgcolor: 'var(--neo-lime)',
                      color: 'black',
                      border: '2px solid black',
                      borderRadius: '50px',
                      fontWeight: 'bold',
                      fontSize: '0.875rem',
                    }}
                  />
                </Box>

                <Typography variant="h1" className="hero-title" sx={{ fontSize: { xs: '2.5rem', md: '4rem' } }}>
                  從
                  <Box component="span" className="hero-highlight"> Python基礎</Box>
                  <br />
                  到
                  <Box className="hero-chip" sx={{ mt: 1, display: 'inline-block' }}>
                    AI機器學習專家！
                  </Box>
                </Typography>

                <Typography variant="h6" className="hero-description">
                由成大AI園丁團隊規劃的48單元課程，帶領孩子從零開始學習Python程式設計，逐步建立邏輯思維與AI素養，為未來升學與競賽做好準備。
                </Typography>

                <Box className="hero-buttons">
                  <Button
                    variant="contained"
                    size="large"
                    endIcon={<ArrowForwardIcon />}
                    onClick={handleGetStarted}
                    className="hero-primary-button"
                  >
                    開始AI學習之旅
                  </Button>

                </Box>

                <Grid container spacing={2} className="hero-stats">
                  <Grid item xs={4}>
                    <Box className="stat-item">
                      <Typography variant="h4" className="stat-number">48</Typography>
                      <Typography variant="body2" className="stat-label">完整單元</Typography>
                    </Box>
                  </Grid>
                  <Grid item xs={4}>
                    <Box className="stat-item">
                      <Typography variant="h4" className="stat-number">3</Typography>
                      <Typography variant="body2" className="stat-label">能力面向</Typography>
                      <Typography variant="body2" className="stat-label">程式力 - 解題力 - AI素養</Typography>
                    </Box>
                  </Grid>
                  <Grid item xs={4}>
                    <Box className="stat-item">
                      <Typography variant="h4" className="stat-number">APCS</Typography>
                      <Typography variant="body2" className="stat-label">競賽準備</Typography>
                    </Box>
                  </Grid>
                </Grid>
              </Box>
            </Grid>

            <Grid item xs={12} lg={6}>
              <Box className="hero-demo">
                <AICodeDemo />

                {/* 浮動圖標 */}
                <Fab size="medium" className="floating-fab floating-fab-1">
                  <BrainIcon sx={{ fontSize: '24px !important' }} />
                </Fab>
                <Fab size="medium" className="floating-fab floating-fab-2">
                  <TrophyIcon sx={{ fontSize: '24px !important' }} />
                </Fab>
              </Box>
            </Grid>
          </Grid>
        </Container>
      </Box>

      {/* 課程階段介紹 */}
      <Box id="about" className="features-section">
        <Container maxWidth="xl">
          <Box className="features-header">
            <Typography variant="h2" className="features-title" sx={{ fontSize: { xs: '2rem', md: '3rem' } }}>
              完整的
              <Box className="features-chip">AI學習路徑</Box>
            </Typography>
            <Typography variant="h6" className="description">
              從程式設計入門到AI基本應用，48個循序漸進的單元，幫助您穩紮穩打培養AI素養。
            </Typography>
          </Box>

          <Grid container spacing={3}>
            {learningStages.map((stage, index) => (
              <Grid item xs={12} md={6} lg={3} key={index}>
                <Card className={`stage-card ${stage.color}`}>
                  <CardContent className="stage-content">
                    <Avatar className={`stage-avatar ${index === 1 ? 'avatar-white' : index === 3 ? 'avatar-lime' : 'avatar-purple'}`}>
                      {stage.icon}
                    </Avatar>

                    <Typography variant="h6" className="stage-title" sx={{ fontWeight: 'bold', mb: 1 }}>
                      {stage.stage}
                    </Typography>

                    <Typography variant="body2" className="stage-units" sx={{ color: '#6B7280', mb: 1 }}>
                      {stage.units}
                    </Typography>

                    <Typography variant="subtitle1" className="stage-subtitle" sx={{ fontWeight: 'bold', mb: 2 }}>
                      {stage.title}
                    </Typography>

                    <Box className="stage-items">
                      {stage.items.map((item, itemIndex) => (
                        <Typography key={itemIndex} variant="body2" className="stage-item" sx={{ fontSize: '0.875rem', color: '#374151', mb: 0.5 }}>
                          • {item}
                        </Typography>
                      ))}
                    </Box>
                  </CardContent>
                </Card>
              </Grid>
            ))}
          </Grid>
        </Container>
      </Box>

      {/* APCS競賽準備 */}
      <Box id="features" className="apcs-section">
        <Container maxWidth="xl">
          <Box className="apcs-header">
            <Typography variant="h2" className="apcs-title" sx={{ fontSize: { xs: '2rem', md: '3rem' } }}>
              <Box className="apcs-chip" sx={{ mr: 1 }}>APCS競賽</Box>
              準備專區
            </Typography>
            <Typography variant="h6" className="description">
              針對APCS程式設計檢定，提供完整的觀念題與實作題訓練，助您達到4-5級分的優異成績！
            </Typography>
          </Box>

          <Grid container spacing={6} alignItems="center" sx={{ mb: 8 }}>
            <Grid item xs={12} lg={6}>
              <Card className="apcs-info-card">
                <CardContent sx={{ p: 3 }}>
                  <Box sx={{ display: 'flex', alignItems: 'center', gap: 2, mb: 3 }}>
                    <TrophyIcon sx={{ fontSize: 32, color: 'var(--neo-purple)' }} />
                    <Typography variant="h5" sx={{ fontWeight: 'bold' }}>
                      APCS評分制度
                    </Typography>
                  </Box>
                  <Box sx={{ display: 'flex', flexDirection: 'column', gap: 2 }}>
                    <Paper className="apcs-section-card gray">
                      <Typography variant="subtitle1" sx={{ fontWeight: 'bold', mb: 1 }}>
                        觀念題（選擇題）
                      </Typography>
                      <Typography variant="body2" sx={{ color: '#6B7280' }}>
                        20題，每題2.5分，測驗程式設計基礎概念與邏輯推理
                      </Typography>
                    </Paper>
                    <Paper className="apcs-section-card lavender">
                      <Typography variant="subtitle1" sx={{ fontWeight: 'bold', mb: 1 }}>
                        實作題（程式題）
                      </Typography>
                      <Typography variant="body2" sx={{ color: '#6B7280' }}>
                        2題，總分50分，系統評分程式正確性與效率
                      </Typography>
                    </Paper>
                  </Box>
                </CardContent>
              </Card>
            </Grid>

            <Grid item xs={12} lg={6}>
              <Typography variant="h5" sx={{ fontWeight: 'bold', mb: 2 }}>
                級分對照表
              </Typography>
              <Box sx={{ display: 'flex', flexDirection: 'column', gap: 1 }}>
                {apcsLevels.map((item, index) => (
                  <Paper key={index} className="level-card">
                    <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', p: 2 }}>
                      <Box sx={{ display: 'flex', alignItems: 'center', gap: 2 }}>
                        <Box sx={{ width: 16, height: 16, borderRadius: '50%', bgcolor: item.color }} />
                        <Typography variant="subtitle2" sx={{ fontWeight: 'bold' }}>
                          {item.level}
                        </Typography>
                        <Typography variant="body2" sx={{ color: '#6B7280' }}>
                          ({item.name})
                        </Typography>
                      </Box>
                      <Typography variant="body2" sx={{ fontWeight: 'medium' }}>
                        {item.range}
                      </Typography>
                    </Box>
                  </Paper>
                ))}
              </Box>
            </Grid>
          </Grid>

          <Card className="university-requirements-card">
            <CardContent sx={{ p: 4 }}>
              <Typography variant="h5" sx={{ fontWeight: 'bold', textAlign: 'center', mb: 3 }}>
                頂尖大學APCS門檻
              </Typography>
              <Grid container spacing={2}>
                {universityRequirements.map((item, index) => (
                  <Grid item xs={12} md={6} lg={4} key={index}>
                    <Paper className="university-card">
                      <Typography variant="subtitle2" sx={{ fontWeight: 'bold', fontSize: '0.875rem' }}>
                        {item.school}
                      </Typography>
                      <Typography variant="caption" sx={{ color: '#6B7280', display: 'block', mb: 1 }}>
                        {item.dept}
                      </Typography>
                      <Box sx={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.75rem' }}>
                        <Typography variant="caption">
                          觀念: <Box component="span" sx={{ fontWeight: 'bold', color: 'var(--neo-purple)' }}>{item.concept}</Box>
                        </Typography>
                        <Typography variant="caption">
                          實作: <Box component="span" sx={{ fontWeight: 'bold', color: 'var(--neo-purple)' }}>{item.practice}</Box>
                        </Typography>
                      </Box>
                    </Paper>
                  </Grid>
                ))}
              </Grid>
            </CardContent>
          </Card>
        </Container>
      </Box>

      {/* AI模組特色 */}
      <Box id="ai-modules" className="ai-modules-section">
        <Container maxWidth="xl">
          <Box className="ai-modules-header">
            <Typography variant="h2" className="ai-modules-title" sx={{ fontSize: { xs: '2rem', md: '3rem' } }}>
              豐富的
              <Box className="ai-modules-chip">AI技術模組</Box>
            </Typography>
            <Typography variant="h6" className="description">
              從基礎機器學習到前沿深度學習技術，涵蓋影像辨識、語音處理、強化學習等熱門AI應用領域
            </Typography>
          </Box>

          <Grid container spacing={4}>
            {aiModules.map((module, index) => (
              <Grid item xs={12} md={6} lg={4} key={index}>
                <Card className="ai-module-card">
                  <CardContent className="ai-module-content">
                    <Avatar
                      className="ai-module-avatar"
                      sx={{
                        bgcolor: module.color,
                        width: 64,
                        height: 64,
                        mb: 3,
                        border: '2px solid black',
                        borderRadius: '12px',
                      }}
                    >
                      {module.icon}
                    </Avatar>

                    <Typography variant="h6" className="ai-module-title" sx={{ fontWeight: 'bold', mb: 2 }}>
                      {module.title}
                    </Typography>

                    <Typography variant="body2" className="ai-module-description" sx={{ color: '#6B7280', mb: 2, lineHeight: 1.6 }}>
                      {module.description}
                    </Typography>

                    <Box className="ai-module-features">
                      {module.features.map((feature, featureIndex) => (
                        <Box key={featureIndex} className="ai-module-feature" sx={{ display: 'flex', alignItems: 'center', gap: 1, mb: 1 }}>
                          <CheckCircleIcon sx={{ color: '#22C55E', fontSize: 16 }} />
                          <Typography variant="caption" sx={{ color: '#6B7280' }}>
                            {feature}
                          </Typography>
                        </Box>
                      ))}
                    </Box>
                  </CardContent>
                </Card>
              </Grid>
            ))}
          </Grid>
        </Container>
      </Box>

      {/* 登入預覽區域 */}
      <Box id="login" className="login-section">
        <Container maxWidth="md">
          <Box className="login-header">
            <Typography variant="h2" className="login-title">
              準備開始
              <Box className="login-chip">學習了嗎？</Box>
            </Typography>
            <Typography variant="h6" className="login-description">
              登入平台，開始您的AI素養培養計畫，成為未來的AI專家！
            </Typography>
          </Box>

          <Box className="login-buttons">
            <Button
              variant="contained"
              size="large"
              onClick={handleLogin}
              className="login-primary-button"
            >
              登入帳戶
            </Button>
          </Box>
        </Container>
      </Box>

      {/* 頁尾 */}
      <Box component="footer" className="footer-section">
        <Container maxWidth="xl">
          <Grid container spacing={4} className="footer-content">
            <Grid item xs={12} md={3}>
              <Box className="footer-brand">
                <Box className="footer-logo">
                  <Avatar className="footer-avatar">
                    <BrainIcon />
                  </Avatar>
                  <Box sx={{ display: 'flex', flexDirection: 'column' }}>
                    <Typography variant="h6" className="footer-title">
                      AI素養學習平台
                    </Typography>
                    <Typography variant="caption" sx={{ color: 'var(--neo-lime)', fontWeight: 'bold' }}>
                      成大AI園丁團隊
                    </Typography>
                  </Box>
                </Box>
                <Typography variant="body2" className="footer-description">
                  專業的AI教育團隊，致力於培養下一代AI人才，從Python基礎到深度學習應用的完整學習體驗。
                </Typography>
              </Box>
            </Grid>

            <Grid item xs={12} md={3}>
              <Typography variant="h6" className="footer-section-title">
                課程內容
              </Typography>
              <Box className="footer-links">
                {['Python基礎程式設計', 'APCS競賽準備', '機器學習入門', '深度學習應用', 'AI倫理與社會影響'].map((item) => (
                  <Typography key={item} variant="body2" className="footer-link">
                    <Link href="#" underline="none">{item}</Link>
                  </Typography>
                ))}
              </Box>
            </Grid>

            <Grid item xs={12} md={3}>
              <Typography variant="h6" className="footer-section-title">
                AI技術模組
              </Typography>
              <Box className="footer-links">
                {['影像辨識技術', '語音處理系統', '自然語言處理', '強化學習', '時間序列預測'].map((item) => (
                  <Typography key={item} variant="body2" className="footer-link">
                    <Link href="#" underline="none">{item}</Link>
                  </Typography>
                ))}
              </Box>
            </Grid>

            <Grid item xs={12} md={3}>
              <Typography variant="h6" className="footer-section-title">
                聯絡資訊
              </Typography>
              <Box className="footer-contact">
                <Box className="contact-item">
                  <EmailIcon className="contact-icon" />
                  <Typography variant="body2" className="contact-text">
                    z10801032@gmail.com
                  </Typography>
                </Box>
                <Box className="contact-item">
                  <LocationIcon className="contact-icon" />
                  <Typography variant="body2" className="contact-text">
                    百大多向思考補習班
                  </Typography>
                </Box>
                <Box className="contact-item">
                  <LocationIcon className="contact-icon" />
                  <Typography variant="body2" className="contact-text">
                    臺師補習班
                  </Typography>
                </Box>
              </Box>
            </Grid>
          </Grid>

          <Divider className="footer-divider" />

          <Box className="footer-bottom">
            <Typography variant="body2" className="copyright">
              © 2025 成大AI園丁團隊 AI素養學習平台。保留所有權利。
            </Typography>
            <Box className="footer-legal">
              {['隱私政策', '服務條款', '學習協議'].map((item) => (
                <Link key={item} href="#" variant="body2" className="legal-link" underline="none">
                  {item}
                </Link>
              ))}
            </Box>
          </Box>
        </Container>
      </Box>
    </Box>
  );
}

export default LandingPage;
