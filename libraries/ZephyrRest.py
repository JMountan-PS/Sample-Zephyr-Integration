import requests
import json
from robot.api import logger

class zephyr_rest:

    base_url = 'http://your-jira-host:port/your-jira-context/rest/atm/1.0/'
    #replace <your-jira-host>, <port>, <your-jira-context>


    #https://confluence.atlassian.com/enterprise/using-personal-access-tokens-1026032365.html


    def __init__(self):
        self.active_session = requests.Session()

    #auth method assuming personal access token
    def set_auth_pat(self, personal_access_token):
        self.pat = personal_access_token
        self.headers = {'Authorization':f"Bearer {self.pat}",
                        "Content-Type":"application/json"}
        self.auth_session.headers.update(self.headers)

    #auth method assuming basic auth
    def set_auth_basic(self, username, password):
        self.username = username
        self.password = password
        self.headers = {"Content-Type":"application/json"}
        self.auth_session.auth = (username,password)

    #auth method assuming Oauth2.0
    def set_oauth_2(self, client_id, client_secret):
        self.client_id = client_id
        self.client_secret = client_secret
        self.auth_session.auth = (client_id,client_secret)
        self.headers = {"Content-Type":"application/json",
                        "audience":"jire.uberinternal.com",
                        "grant_type":"client_credentials"}
        response = self.auth_session.post(f"{zephyr_rest.base_url}/oauth2/token",headers=self.headers)
        logger.console(response.status_code)
        logger.console(response.reason)

        return json.loads(response.text)['access_token']

    def update_tc_result(self, status, key, comment, name)
        self.
