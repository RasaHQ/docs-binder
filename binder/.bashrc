export LOG_LEVEL="ERROR"
export RASA_X_PASSWORD="rasademo"

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
    until $(curl --output /dev/null --silent --fail http://localhost:5002); do
        printf '.'
        sleep 2
    done
    URL=${URL}"/login?username=me&password=${RASA_X_PASSWORD}"
    echo "button $URL"
  else
    /srv/conda/bin/rasa "$@"
  fi
}
