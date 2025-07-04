import os
from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_cors import CORS

# Initialize extensions
db = SQLAlchemy()
migrate = Migrate()

def create_app(test_config=None):
    # Create and configure the app
    app = Flask(__name__, instance_relative_config=True)
    
    if test_config is None:
        # Load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # Load the test config if passed in
        app.config.from_mapping(test_config)

    # Ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    # Configure database
    app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URL', 'sqlite:///python_learning.db')
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    
    # Initialize extensions with app
    db.init_app(app)
    migrate.init_app(app, db)
    # 配置 CORS 以接受任何源的請求
    CORS(app, resources={r"/*": {"origins": "*"}}, supports_credentials=True)

    # ========== 添加根路由 ==========
    @app.route('/')
    def index():
        return jsonify({
            "name": "AI Literacy Learning Platform API",
            "version": "1.0",
            "status": "running",
            "message": "Welcome to AI Literacy API"
        })
    
    @app.route('/api')
    def api_index():
        return jsonify({
            "message": "AI Literacy API Endpoints",
            "endpoints": {
                "authentication": "/api/auth",
                "courses": "/api/courses",
                "lessons": "/api/lessons",
                "progress": "/api/progress",
                "users": "/api/users",
                "code_execution": "/api/execute",
                "code_runner": "/api/run",
                "lesson_content": "/api/lesson-content",
                "student": "/api/student"
            }
        })
    
    @app.route('/api/health')
    def health_check():
        return jsonify({
            "status": "healthy",
            "database": "connected" if db.engine else "disconnected",
            "service": "AI Literacy Backend"
        })
    # ========== 根路由結束 ==========

    # Register blueprints
    from .routes import auth, courses, lessons, progress, users, code_execution, lesson_content, lesson_content_fillblank, student, code_runner
    
    app.register_blueprint(auth.bp)
    app.register_blueprint(courses.bp)
    app.register_blueprint(lessons.bp)
    app.register_blueprint(progress.bp)
    app.register_blueprint(users.bp)
    app.register_blueprint(code_execution.bp)
    app.register_blueprint(code_runner.bp)  # 注册新的程式碼运行模块
    app.register_blueprint(lesson_content.bp)
    app.register_blueprint(lesson_content_fillblank.bp)
    app.register_blueprint(student.bp)

    return app