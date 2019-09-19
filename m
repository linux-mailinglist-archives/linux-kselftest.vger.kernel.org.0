Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB2F4B810F
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2019 20:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391852AbfISSz3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Sep 2019 14:55:29 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:50821 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391845AbfISSz3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Sep 2019 14:55:29 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 703621BF203;
        Thu, 19 Sep 2019 18:55:27 +0000 (UTC)
Date:   Thu, 19 Sep 2019 20:55:25 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/kselftest/runner.sh: Add 45 second timeout per
 test
Message-ID: <20190919185525.GD21254@piout.net>
References: <201909191102.97FA56072@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909191102.97FA56072@keescook>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 19/09/2019 11:06:44-0700, Kees Cook wrote:
> Commit a745f7af3cbd ("selftests/harness: Add 30 second timeout per
> test") solves the problem of kselftest_harness.h-using binary tests
> possibly hanging forever. However, scripts and other binaries can still
> hang forever. This adds a global timeout to each test script run.
> 
> To make this configurable (e.g. as needed in the "rtc" test case),
> include a new per-test-directory "settings" file (similar to "config")
> that can contain kselftest-specific settings. The first recognized field
> is "timeout".
> 

Seems good to me. I was also wondering whether this is actually
reasonable to have tests running for so long. I wanted to discuss that
at LPC but I missed the session.

> Additionally, this splits the reporting for timeouts into a specific
> "TIMEOUT" not-ok (and adds exit code reporting in the remaining case).
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/kselftest/runner.sh | 36 +++++++++++++++++++--
>  tools/testing/selftests/rtc/settings        |  1 +
>  2 files changed, 34 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/rtc/settings
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index 00c9020bdda8..84de7bc74f2c 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -3,9 +3,14 @@
>  #
>  # Runs a set of tests in a given subdirectory.
>  export skip_rc=4
> +export timeout_rc=124
>  export logfile=/dev/stdout
>  export per_test_logging=
>  
> +# Defaults for "settings" file fields:
> +# "timeout" how many seconds to let each test run before failing.
> +export kselftest_default_timeout=45
> +
>  # There isn't a shell-agnostic way to find the path of a sourced file,
>  # so we must rely on BASE_DIR being set to find other tools.
>  if [ -z "$BASE_DIR" ]; then
> @@ -24,6 +29,16 @@ tap_prefix()
>  	fi
>  }
>  
> +tap_timeout()
> +{
> +	# Make sure tests will time out if utility is available.
> +	if [ -x /usr/bin/timeout ] ; then
> +		/usr/bin/timeout "$kselftest_timeout" "$1"
> +	else
> +		"$1"
> +	fi
> +}
> +
>  run_one()
>  {
>  	DIR="$1"
> @@ -32,6 +47,18 @@ run_one()
>  
>  	BASENAME_TEST=$(basename $TEST)
>  
> +	# Reset any "settings"-file variables.
> +	export kselftest_timeout="$kselftest_default_timeout"
> +	# Load per-test-directory kselftest "settings" file.
> +	settings="$BASE_DIR/$DIR/settings"
> +	if [ -r "$settings" ] ; then
> +		while read line ; do
> +			field=$(echo "$line" | cut -d= -f1)
> +			value=$(echo "$line" | cut -d= -f2-)
> +			eval "kselftest_$field"="$value"
> +		done < "$settings"
> +	fi
> +
>  	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
>  	echo "# $TEST_HDR_MSG"
>  	if [ ! -x "$TEST" ]; then
> @@ -44,14 +71,17 @@ run_one()
>  		echo "not ok $test_num $TEST_HDR_MSG"
>  	else
>  		cd `dirname $TEST` > /dev/null
> -		(((((./$BASENAME_TEST 2>&1; echo $? >&3) |
> +		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
>  			tap_prefix >&4) 3>&1) |
>  			(read xs; exit $xs)) 4>>"$logfile" &&
>  		echo "ok $test_num $TEST_HDR_MSG") ||
> -		(if [ $? -eq $skip_rc ]; then	\
> +		(rc=$?;	\
> +		if [ $rc -eq $skip_rc ]; then	\
>  			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
> +		elif [ $rc -eq $timeout_rc ]; then \
> +			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
>  		else
> -			echo "not ok $test_num $TEST_HDR_MSG"
> +			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
>  		fi)
>  		cd - >/dev/null
>  	fi
> diff --git a/tools/testing/selftests/rtc/settings b/tools/testing/selftests/rtc/settings
> new file mode 100644
> index 000000000000..ba4d85f74cd6
> --- /dev/null
> +++ b/tools/testing/selftests/rtc/settings
> @@ -0,0 +1 @@
> +timeout=90
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
