# Pull base image.
FROM ryanlee2014/cupoj-judger-env:1.0.3

# Install Node.js
RUN set -xe && \
    useradd -m -u 1536 judge && \
    cd ~ && \
    wget https://github.com/JetBrains/kotlin/releases/download/v1.3.72/kotlin-compiler-1.3.72.zip && \
    unzip kotlin-compiler-1.3.72.zip && \
    mv kotlinc /usr/lib/kotlinc && \
    rm -rf kotlin-compiler-1.3.72.zip && \
    cd ~ && \
    echo 'fun main(args: Array<String>) {println("Hello, World!")}' > hello.kt && \
    /usr/lib/kotlin-native/bin/kotlinc hello.kt -o hello -opt && \
    mv ~/.konan /home/judge/.konan && \
    chgrp -R judge /home/judge/.konan && \
    chown -R judge /home/judge/.konan && \
    cd ~

ENV PATH="/usr/lib/kotlinc/bin:/usr/lib/kotlin-native/bin:${PATH}"

CMD echo 'hello world!'