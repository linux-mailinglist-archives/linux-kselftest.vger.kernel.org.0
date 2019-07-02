Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B2A5DB04
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2019 03:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfGCBjk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jul 2019 21:39:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43036 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGCBjk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jul 2019 21:39:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id w79so646589oif.10
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jul 2019 18:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FUA9iG25CmIH4MahZvHYUlC3QW6l7WDczQJ9a6ioMLY=;
        b=POQmgBOadRPayXo9Fd+ZXV6uH8TQK55zqk1MmI2iyDjPQuE4BVwjuhe9k5HwRxPxFF
         QNrZV2C2MOyW3no2nxSlnryuZE+jS7R99MLxn27yMHpXBhjo/PVOl5cjLDjvEpQve0BR
         p+H02z5QHigVh1/dmkHT9Tm6XDXZ9kV/R+OB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FUA9iG25CmIH4MahZvHYUlC3QW6l7WDczQJ9a6ioMLY=;
        b=t7jToJGVTVn7TIltwmdAPic6PZTHr1k7DbfjusR7HEEOFFXI9MQFPIu4f3oNBFfHYW
         mxuYxcufQFXdDcj7Thm5HIZEMYMEHiPDZG64iDoZOPFtR4Uy5llfpaaLVfng7C1xaLym
         X7ESUwy4HxGAxme/AR9SjWAUtSJa/pzIbmK7nlyM6LqGTW64gPCnCkiFYQQyfq9MEgLw
         ewzZkglw3ZuxsKE19Qc8sCeHzQ+KGX9l6te/Sqp05Vapi5K/51TZy2HpKP2cA/rlQR+a
         l//oDSr337LWk+mXAJNTemjFYNsEB+Up7kUY9O9FKSm4O0/1TvGirDUqhEK/4DCWcOXs
         wCqQ==
X-Gm-Message-State: APjAAAVxouBVFqfK0Ixoqesp1SyNaLshO/pw6nqHIofh8MZkDQ0mE2Yo
        h/7UgKynJLlA+dgyk+LxTVnUU2CvlUk=
X-Google-Smtp-Source: APXvYqxEO0SQAfPRdHXgWGt25UD9Hdx0nrlm5DNCZqVSYLbgGPtkci7ooH6NOC+nmhe8H7B8/MSvUw==
X-Received: by 2002:a63:c0e:: with SMTP id b14mr32619599pgl.4.1562102158371;
        Tue, 02 Jul 2019 14:15:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t24sm6937pfh.113.2019.07.02.14.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 14:15:56 -0700 (PDT)
Date:   Tue, 2 Jul 2019 10:23:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/kselftest/runner.sh: Add 30 second timeout per
 test
Message-ID: <201907021012.5C8D05A878@keescook>
References: <20190612164146.25280-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612164146.25280-1-anders.roxell@linaro.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 12, 2019 at 06:41:46PM +0200, Anders Roxell wrote:
> Commit a745f7af3cbd ("selftests/harness: Add 30 second timeout per
> test") solves that binary tests doesn't hang forever. However, scripts
> can still hang forever, this adds an timeout to each test script run. This
> assumes that an individual test doesn't take longer than 30 seconds.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/kselftest/runner.sh | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index 00c9020bdda8..cff7d2d83648 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -5,6 +5,7 @@
>  export skip_rc=4
>  export logfile=/dev/stdout
>  export per_test_logging=
> +export TEST_TIMEOUT_DEFAULT=30

I would name this "kselftest_timeout" to avoid namespace collisions and
to drop the "default" name, since while setting it here is a default,
when used by other parts of the test environment, we'll be changing it
to non-default, so it's weird to have "default" in the name.

>  
>  # There isn't a shell-agnostic way to find the path of a sourced file,
>  # so we must rely on BASE_DIR being set to find other tools.
> @@ -24,6 +25,14 @@ tap_prefix()
>  	fi
>  }
>  
> +tap_timeout()
> +{
> +	if [ -x /usr/bin/timeout ] && [ -x "$BASENAME_TEST" ] \

The -x test on BASENAME_TEST is already done earlier in run_one(). Also,
this needs to be "$1" (the argument to tap_timeout).

> +		&& file $BASENAME_TEST |grep -q "shell script"; then

"file" seems pretty heavy here. How about "head -c2":

		&& [ '#!' = "$(head -c2 "$1")" ]

> +		echo -n "timeout $TEST_TIMEOUT_DEFAULT"

And this needs to actually _run_ it, not echo anything.

> +	fi
> +}

I would expect tap_timeout() to be:

tap_timeout()
{
	# If we have the "timeout" tool and the test is a script,
	# set our timeout.
	if [ -x /usr/bin/timeout ] &&
	   [ '#!' = "$(head -c2 "$1")" ] ; then
		/usr/bin/timeout "$kselftest_timeout" "$1"
	else
		"$1"
	fi
}

Another thought: should kselftest be changed so that this is the ONLY
timeout mechanism? i.e. remove the binary timeout code I originally
added, and just use this instead? Then we don't have to distinguish
between script and non-script, etc.

-Kees

> +
>  run_one()
>  {
>  	DIR="$1"
> @@ -44,7 +53,7 @@ run_one()
>  		echo "not ok $test_num $TEST_HDR_MSG"
>  	else
>  		cd `dirname $TEST` > /dev/null
> -		(((((./$BASENAME_TEST 2>&1; echo $? >&3) |
> +		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
>  			tap_prefix >&4) 3>&1) |
>  			(read xs; exit $xs)) 4>>"$logfile" &&
>  		echo "ok $test_num $TEST_HDR_MSG") ||
> -- 
> 2.11.0
> 

-- 
Kees Cook
