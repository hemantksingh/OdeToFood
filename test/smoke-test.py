import sys
import requests
import yaml

def fail(message):
    print (message)
    sys.exit(-1)

def get_sys_arg(name, number, options):
    if len(sys.argv) <= number or ((sys.argv[number] in options) ==  False):
        fail("Must provide a valid '%s'. Options are %s." % (name, options))
    return sys.argv[number]

def check_url(url, content):
    print ("Checking: %s" %(url))
    response = requests.get(url)

    check_response_status_200(response)
    check_response_contains_content(response, content)

def check_response_status_200(response):
    if response.status_code != 200:
        fail("'%s' did not respond with 200. Actual response code was '%s'"
            % (response.url, response.status_code))

def check_response_contains_content(response, content):
    if content not in response.text:
        fail("%s did not contain expected text: '%s'"
            % (response.url, content))

if __name__ == "__main__":
    pages_to_test = "./test/pages-to-test.yaml"
    dataMap = yaml.load(open(pages_to_test))
    host = get_sys_arg("HOST", 1, ["localhost"])
    for page, content in dataMap["pages"].items():
        url = "http://%s%s" %(host, page)
        check_url(url, content)
