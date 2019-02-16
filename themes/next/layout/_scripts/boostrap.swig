{%
  set boot_scripts = [
    'src/bootstrap.js'
  ]
%}

{% for bs in boot_scripts %}
  <script src="{{ url_for(theme.js) }}/{{ bs }}?v={{ version }}"></script>
{% endfor %}

<script type="text/javascript">
    var message_Path = '/live2d/'
    var home_Path = 'https://vincent.ga/'  //此处修改为你的域名，必须带斜杠
</script>
<script type="text/javascript" src="/live2d/js/live2d.js"></script>
<script type="text/javascript" src="/live2d/js/message.js"></script>
<script type="text/javascript">
    loadlive2d("live2d", "/live2d/model/tia/model.json");
</script>