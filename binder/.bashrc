export LOG_LEVEL="ERROR"
export RASAX_PASSWORD="rasademo"

rasa () {
  if [[ $1 == "x" ]]; then 
    echo "preparing session.."
    (/srv/conda/bin/rasa "$@" &)
    (/home/jovyan/ngrok http 5002  > /dev/null &)
    sleep 2
    URL=$(curl localhost:4040/api/tunnels | \
          python -m json.tool | \
          grep public_url | \
          grep https | \
          sed 's/"*[^"]*": "\([^"]*\)",/\1/')
    printf "starting ."
    until $(curl --output /dev/null --silent --head --fail http://localhost:5002); do
        printf '.'
        sleep 2
    done
    URL=${URL}"/login?username=me&password=${RASAX_PASSWORD}"
    echo "button $URL"
  else
    /srv/conda/bin/rasa "$@"
  fi
}
