
def should_display_button(output):
    return 'button' in output

def display_data_for_button(url):
    content = {
        'data': {
            'text/html': '<a href="{}" target="_blank"><button class="button">Open UI</button></a>'.format(url)
         },
        'metadata': {}
    }
    return content
