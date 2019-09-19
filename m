Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53656B823C
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2019 22:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392413AbfISUJk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Sep 2019 16:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390722AbfISUJk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Sep 2019 16:09:40 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84C1121920;
        Thu, 19 Sep 2019 20:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568923779;
        bh=qZltYXXezlfIR0mvTZ54TzRXeU3rx2j1Ow2oeBRBwLA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bflzlQqT7QyBWzjA/2vxhsT8XaLkmzvpVY4296gOL2hgt05+zLXaT4shaz3+Mc8HC
         Fn/k9sTKT3M+IS+QQTXf0onWLnzJmnbWwfeqlZhPtrexV+7l/wzUj0zIXQqIt7u41z
         07folbE4+8yxQQbNFZqJ93jqYIVkR59ooedfKlxM=
Subject: Re: [PATCH] selftests/kselftest/runner.sh: Add 45 second timeout per
 test
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <201909191102.97FA56072@keescook>
 <20190919185525.GD21254@piout.net>
From:   shuah <shuah@kernel.org>
Message-ID: <4844c68f-603d-14f2-f976-5bd255268c0d@kernel.org>
Date:   Thu, 19 Sep 2019 14:09:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919185525.GD21254@piout.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/19/19 12:55 PM, Alexandre Belloni wrote:
> On 19/09/2019 11:06:44-0700, Kees Cook wrote:
>> Commit a745f7af3cbd ("selftests/harness: Add 30 second timeout per
>> test") solves the problem of kselftest_harness.h-using binary tests
>> possibly hanging forever. However, scripts and other binaries can still
>> hang forever. This adds a global timeout to each test script run.
>>

Timeout is good, but really tests should not hang. So we have to somehow
indicate that the test needs to be fixed.

This timeout is a band-aid and not real solution for the problem. This
arbitrary value doesn't take into account that the test(s) in that
particular directory (TARGET) could be running normally and working
through all the tests.

We need some way to differentiate the two cases.

>> To make this configurable (e.g. as needed in the "rtc" test case),
>> include a new per-test-directory "settings" file (similar to "config")
>> that can contain kselftest-specific settings. The first recognized field
>> is "timeout".
>>
> 
> Seems good to me. I was also wondering whether this is actually
> reasonable to have tests running for so long. I wanted to discuss that
> at LPC but I missed the session.
> 

There is the individual test times and overall kselftest run time. We
have lots of tests now and it does take long.

>> Additionally, this splits the reporting for timeouts into a specific
>> "TIMEOUT" not-ok (and adds exit code reporting in the remaining case).
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>   tools/testing/selftests/kselftest/runner.sh | 36 +++++++++++++++++++--
>>   tools/testing/selftests/rtc/settings        |  1 +
>>   2 files changed, 34 insertions(+), 3 deletions(-)
>>   create mode 100644 tools/testing/selftests/rtc/settings
>>
>> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
>> index 00c9020bdda8..84de7bc74f2c 100644
>> --- a/tools/testing/selftests/kselftest/runner.sh
>> +++ b/tools/testing/selftests/kselftest/runner.sh
>> @@ -3,9 +3,14 @@
>>   #
>>   # Runs a set of tests in a given subdirectory.
>>   export skip_rc=4
>> +export timeout_rc=124
>>   export logfile=/dev/stdout
>>   export per_test_logging=
>>   
>> +# Defaults for "settings" file fields:
>> +# "timeout" how many seconds to let each test run before failing.
>> +export kselftest_default_timeout=45
>> +
>>   # There isn't a shell-agnostic way to find the path of a sourced file,
>>   # so we must rely on BASE_DIR being set to find other tools.
>>   if [ -z "$BASE_DIR" ]; then
>> @@ -24,6 +29,16 @@ tap_prefix()
>>   	fi
>>   }
>>   
>> +tap_timeout()
>> +{
>> +	# Make sure tests will time out if utility is available.
>> +	if [ -x /usr/bin/timeout ] ; then
>> +		/usr/bin/timeout "$kselftest_timeout" "$1"
>> +	else
>> +		"$1"
>> +	fi
>> +}
>> +
>>   run_one()
>>   {
>>   	DIR="$1"
>> @@ -32,6 +47,18 @@ run_one()
>>   
>>   	BASENAME_TEST=$(basename $TEST)
>>   
>> +	# Reset any "settings"-file variables.
>> +	export kselftest_timeout="$kselftest_default_timeout"
>> +	# Load per-test-directory kselftest "settings" file.
>> +	settings="$BASE_DIR/$DIR/settings"
>> +	if [ -r "$settings" ] ; then
>> +		while read line ; do
>> +			field=$(echo "$line" | cut -d= -f1)
>> +			value=$(echo "$line" | cut -d= -f2-)
>> +			eval "kselftest_$field"="$value"
>> +		done < "$settings"
>> +	fi
>> +
>>   	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
>>   	echo "# $TEST_HDR_MSG"
>>   	if [ ! -x "$TEST" ]; then
>> @@ -44,14 +71,17 @@ run_one()
>>   		echo "not ok $test_num $TEST_HDR_MSG"
>>   	else
>>   		cd `dirname $TEST` > /dev/null
>> -		(((((./$BASENAME_TEST 2>&1; echo $? >&3) |
>> +		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
>>   			tap_prefix >&4) 3>&1) |
>>   			(read xs; exit $xs)) 4>>"$logfile" &&
>>   		echo "ok $test_num $TEST_HDR_MSG") ||
>> -		(if [ $? -eq $skip_rc ]; then	\
>> +		(rc=$?;	\
>> +		if [ $rc -eq $skip_rc ]; then	\
>>   			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
>> +		elif [ $rc -eq $timeout_rc ]; then \
>> +			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
>>   		else
>> -			echo "not ok $test_num $TEST_HDR_MSG"
>> +			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
>>   		fi)
>>   		cd - >/dev/null
>>   	fi
>> diff --git a/tools/testing/selftests/rtc/settings b/tools/testing/selftests/rtc/settings
>> new file mode 100644
>> index 000000000000..ba4d85f74cd6
>> --- /dev/null
>> +++ b/tools/testing/selftests/rtc/settings
>> @@ -0,0 +1 @@
>> +timeout=90
>> -- 
>> 2.17.1
>>
>>
>> -- 
>> Kees Cook
> 

thanks,
-- Shuah
