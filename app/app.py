# from honomara_members_site import app
from honomara_web_backend import app

if __name__ == '__main__':
    app.run(debug=True,port=5000,host='0.0.0.0')
