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
} from '@mui/material';
import {
  Code as CodeIcon,
  People as PeopleIcon,
  BarChart as BarChartIcon,
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

// 程式碼展示組件
const CodeDemo = () => (
  <Paper elevation={0} className="code-demo">
    <Box className="code-demo-dots">
      <Box className="dot red" />
      <Box className="dot yellow" />
      <Box className="dot green" />
    </Box>
    <Box className="code-terminal">
      <Box className="code-comment"># Python挑戰：FizzBuzz</Box>
      <Box className="code-line">
        <Box component="span" className="code-keyword">def</Box>{' '}
        <Box component="span" className="code-function">fizzbuzz</Box>():
      </Box>
      <Box className="code-line indent-1">
        <Box component="span" className="code-keyword">for</Box> i{' '}
        <Box component="span" className="code-keyword">in</Box>{' '}
        <Box component="span" className="code-function">range</Box>(1, 101):
      </Box>
      <Box className="code-line indent-2">
        <Box component="span" className="code-keyword">if</Box> i % 15 == 0:
      </Box>
      <Box className="code-line indent-3">
        <Box component="span" className="code-function">print</Box>("FizzBuzz")
      </Box>
    </Box>
    <Box className="code-result">
      <Box className="result-text">
        <CheckCircleIcon className="result-icon" />
        <Typography variant="body2" className="result-label">
          挑戰完成！
        </Typography>
      </Box>
      <Box className="star-rating">
        {[1, 2, 3, 4, 5].map((star) => (
          <StarIcon key={star} className="star" />
        ))}
      </Box>
    </Box>
  </Paper>
);

function LandingPage() {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const theme = useTheme();
  const isMobile = useMediaQuery(theme.breakpoints.down('md'));
  const navigate = useNavigate();

  const handleGetStarted = () => {
    navigate('/register');
  };

  const handleLogin = () => {
    navigate('/login');
  };

  const features = [
    {
      icon: <CodeIcon className="feature-icon" />,
      title: '互動程式設計挑戰',
      description: '透過我們的互動程式碼編輯器解決真實的Python問題。獲得即時回饋和提示，指導您的學習之旅。',
      className: 'feature-card-gray',
      items: ['500+ 程式設計挑戰', '即時程式碼執行', '分步解決方案'],
    },
    {
      icon: <BarChartIcon className="feature-icon-alt" />,
      title: '學生表現儀表板',
      description: '透過詳細的分析、表現指標和為每個學生需求量身定制的個人化學習路徑來追蹤進度。',
      className: 'feature-card-lime',
      items: ['進度追蹤', '表現分析', '個人化推薦'],
    },
    {
      icon: <PeopleIcon className="feature-icon" />,
      title: '教師管理工具',
      description: '為教育工作者提供全面的工具來管理課堂、建立作業並即時監控學生進度。',
      className: 'feature-card-lavender',
      items: ['課堂管理', '作業建立', '即時監控'],
    },
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
                <CodeIcon />
              </Avatar>
              <Typography variant="h6" className="logo-text">
                Python學習平台
              </Typography>
            </Box>

            {!isMobile ? (
              <Box className="desktop-nav">
                <Link href="#about" className="nav-link">關於我們</Link>
                <Link href="#features" className="nav-link">開始學習</Link>
                <Link href="#login" className="nav-link">教師登入</Link>
                <Button 
                  variant="contained" 
                  className="cta-button"
                  onClick={handleGetStarted}
                >
                  立即開始
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
              <ListItemText primary="關於我們" className="mobile-nav-item" />
            </ListItem>
            <ListItem>
              <ListItemText primary="開始學習" className="mobile-nav-item" />
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
                立即開始
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
                <Typography variant="h1" className="hero-title">
                  透過
                  <Box component="span" className="hero-highlight"> 互動</Box>
                  <br />
                  <Box className="hero-chip">
                    挑戰掌握Python！
                  </Box>
                </Typography>
                
                <Typography variant="h6" className="hero-description">
                  加入數千名學生和教師，使用我們的前沿平台透過實作程式設計挑戰和真實專案學習Python程式設計。
                </Typography>

                <Box className="hero-buttons">
                  <Button
                    variant="contained"
                    size="large"
                    endIcon={<ArrowForwardIcon />}
                    onClick={handleGetStarted}
                    className="hero-primary-button"
                  >
                    立即開始學習
                  </Button>
                </Box>

                <Grid container spacing={2} className="hero-stats">
                  <Grid item xs={4}>
                    <Box className="stat-item">
                      <Typography variant="h4" className="stat-number">10K+</Typography>
                      <Typography variant="body2" className="stat-label">學生</Typography>
                    </Box>
                  </Grid>
                  <Grid item xs={4}>
                    <Box className="stat-item">
                      <Typography variant="h4" className="stat-number">500+</Typography>
                      <Typography variant="body2" className="stat-label">教師</Typography>
                    </Box>
                  </Grid>
                  <Grid item xs={4}>
                    <Box className="stat-item">
                      <Typography variant="h4" className="stat-number">1000+</Typography>
                      <Typography variant="body2" className="stat-label">挑戰題</Typography>
                    </Box>
                  </Grid>
                </Grid>
              </Box>
            </Grid>

            <Grid item xs={12} lg={6}>
              <Box className="hero-demo">
                <CodeDemo />
                
                {/* 浮動圖標 */}
                <Fab size="small" className="floating-fab floating-fab-1">
                  <CodeIcon />
                </Fab>
                <Fab size="small" className="floating-fab floating-fab-2">
                  <StarIcon />
                </Fab>
              </Box>
            </Grid>
          </Grid>
        </Container>
      </Box>

      {/* 功能特色 */}
      <Box id="features" className="features-section">
        <Container maxWidth="xl">
          <Box className="features-header">
            <Typography variant="h2" className="features-title">
              為什麼選擇我們的
              <Box className="features-chip">平台？</Box>
            </Typography>
            <Typography variant="h6" className="features-description">
              我們的平台結合了前沿技術和經過驗證的教育方法，提供無與倫比的學習體驗。
            </Typography>
          </Box>

          <Grid container spacing={4}>
            {features.map((feature, index) => (
              <Grid item xs={12} md={4} key={index}>
                <Card className={`feature-card ${feature.className}`}>
                  <CardContent className="feature-content">
                    <Avatar className={`feature-avatar ${index === 1 ? 'avatar-white' : 'avatar-purple'}`}>
                      {feature.icon}
                    </Avatar>
                    
                    <Typography variant="h5" className="feature-title">
                      {feature.title}
                    </Typography>
                    
                    <Typography variant="body1" className="feature-description">
                      {feature.description}
                    </Typography>
                    
                    <Box className="feature-items">
                      {feature.items.map((item, itemIndex) => (
                        <Box key={itemIndex} className="feature-item">
                          <CheckCircleIcon className="check-icon" />
                          <Typography variant="body2" className="item-text">
                            {item}
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
              登入以存取您的個人化儀表板並繼續您的Python學習之旅。
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
                    <CodeIcon />
                  </Avatar>
                  <Typography variant="h6" className="footer-title">
                    Python學習平台
                  </Typography>
                </Box>
                <Typography variant="body2" className="footer-description">
                  透過互動學習和實作程式設計挑戰，培養下一代Python開發者。
                </Typography>
                <Box className="social-links">
                  <IconButton className="social-button">
                    <GitHubIcon />
                  </IconButton>
                  <IconButton className="social-button">
                    <TwitterIcon />
                  </IconButton>
                  <IconButton className="social-button">
                    <LinkedInIcon />
                  </IconButton>
                </Box>
              </Box>
            </Grid>

            <Grid item xs={12} md={3}>
              <Typography variant="h6" className="footer-section-title">
                學習內容
              </Typography>
              <Box className="footer-links">
                {['Python基礎', '進階主題', '資料科學', '網頁開發', '機器學習'].map((item) => (
                  <Typography key={item} variant="body2" className="footer-link">
                    <Link href="#">{item}</Link>
                  </Typography>
                ))}
              </Box>
            </Grid>

            <Grid item xs={12} md={3}>
              <Typography variant="h6" className="footer-section-title">
                支援服務
              </Typography>
              <Box className="footer-links">
                {['幫助中心', '使用文件', '社群論壇', '聯絡支援', '錯誤回報'].map((item) => (
                  <Typography key={item} variant="body2" className="footer-link">
                    <Link href="#">{item}</Link>
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
                    support@pythonlearning.com
                  </Typography>
                </Box>
                <Box className="contact-item">
                  <PhoneIcon className="contact-icon" />
                  <Typography variant="body2" className="contact-text">
                    +886 2-2345-6789
                  </Typography>
                </Box>
                <Box className="contact-item">
                  <LocationIcon className="contact-icon" />
                  <Typography variant="body2" className="contact-text">
                    台北市信義區教育科技大樓123號
                  </Typography>
                </Box>
              </Box>
            </Grid>
          </Grid>

          <Divider className="footer-divider" />
          
          <Box className="footer-bottom">
            <Typography variant="body2" className="copyright">
              © 2025 Python學習平台。保留所有權利。
            </Typography>
            <Box className="footer-legal">
              {['隱私政策', '服務條款', 'Cookie政策'].map((item) => (
                <Link key={item} href="#" variant="body2" className="legal-link">
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