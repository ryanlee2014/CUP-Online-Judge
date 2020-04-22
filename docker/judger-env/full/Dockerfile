# Pull base image.
FROM ryanlee2014/cupoj-judger-env:1.0.3

# Install Node.js
RUN set -xe && \
    cd ~ && \
    echo 'fun main(args: Array<String>) {println("Hello, World!")}' > hello.kt && \
    /usr/lib/kotlin-native/bin/kotlinc hello.kt -o hello -opt && \
    mv ~/.konan /home/judge/.konan && \
    chgrp -R judge /home/judge/.konan && \
    chown -R judge /home/judge/.konan && \
    cd ~

ENV PATH="/usr/lib/kotlinc/bin:/usr/lib/kotlin-native/bin:${PATH}"

CMD echo 'hello world!'