Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121E649EEE4
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 00:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241715AbiA0Xfz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 18:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241407AbiA0Xfy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 18:35:54 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3616CC061714
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 15:35:54 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id s1so3940566ilj.7
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 15:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RYM+OoI+sRVj0DaSYGxbB41tOrylxhqAidM+/G1N3g0=;
        b=aUmOfv6amDCIBKl7cyPdoqr3OVRCXg/GstZMqtSv+fITjqVWvfqyOq/r0cMRiImy7f
         jbXsYP0X2iG49ox22cjU1ue9zF3rsmeyuVuo8MfW9gXAxR/U7nhC6eGB0v5bHYIi9yuY
         gVjAWZgleK+Hx7zcLbv28glClAnV0OyI80Af8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RYM+OoI+sRVj0DaSYGxbB41tOrylxhqAidM+/G1N3g0=;
        b=H3AYwhZFqq1hd7NSsGcQlMpQ8OdWJbU/tP1DxVfZ6B638NA31eMNQDOtSt3j5Svcpb
         yn/6PbX+kYOxLJPMIc/FzUSc6oowdpxSsFSwTQOMQajUFAlt1jsxm7Btl8KrFs4+y2Wl
         aZ377Z6GQf24n+VSWVLmdiOHCKCF1yHwLzmf5fhPJNuVtMMwx9b2DSgv4DisWD9c38ga
         ZcQs4flQyXokHZQDSWTZIPcHWSHVVipUBoTcPseqnESgIR2jxkXwyU0LEB/UJIS7G4V1
         k3GKlwACOF/OFHqyErq/daBMEGTmNidSC7O7EQeNY/EsTuqzCM916Dnmm3wrZIN94AsO
         Y9zg==
X-Gm-Message-State: AOAM532XVtJ4K+rqBXUL667BG4eDDH2VUITrtTQyF4yRxBWCRCw7AvOO
        qZk79iSFQnHk3UHfvZ8uRKFE+M7LK8Qirw==
X-Google-Smtp-Source: ABdhPJzY7qLxZttJ7C11awsFFi9BVO1qm82AAFY577TQWVn1v7pp1cm4kKMZYdLRWRT0HBybjT3K6A==
X-Received: by 2002:a05:6e02:1a8d:: with SMTP id k13mr4160072ilv.257.1643326553510;
        Thu, 27 Jan 2022 15:35:53 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:fcdb:3423:ed25:a583? ([2601:282:8200:4c:fcdb:3423:ed25:a583])
        by smtp.gmail.com with ESMTPSA id y11sm12708870ilp.18.2022.01.27.15.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:35:53 -0800 (PST)
Subject: Re: [PATCH v4] selftests/kselftest/runner.sh: Pass optional command
 parameters in environment
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220126103230.35285-1-cristian.marussi@arm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6905ff91-c363-91b3-7240-8bb728f45c39@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 16:35:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220126103230.35285-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/26/22 3:32 AM, Cristian Marussi wrote:
> Some testcases allow for optional commandline parameters but as of now
> there is now way to provide such arguments to the runner script.
> 
> Add support to retrieve such optional command parameters fron environment
> variables named so as to include the all-uppercase test executable name,
> sanitized substituting any non-acceptable varname characters with "_",
> following the pattern:
> 
> 	KSELFTEST_<UPPERCASE_SANITIZED_TEST_NAME>_ARGS="options"
> 
> Optional command parameters support is not available if 'tr' is not
> installed on the test system.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v3 --> v4
> - rebased on v5.17-rc1
> v2 --> v3
> - improved varname sanitation
> v1 --> v2
> - using env vars instead of settings file
> - added missing varname sanitation
> 
> Usage examples:
> 
> 	KSELFTEST_RTCTEST_ARGS="/dev/rtc1" /opt/ksft_fixes/run_kselftest.sh -c rtc
> 
> 	KSELFTEST_CPU_ON_OFF_TEST_SH_ARGS="-a -p 10" /opt/ksft_fixes/run_kselftest.sh -c cpu-hotplug
> ---
>   tools/testing/selftests/kselftest/runner.sh | 30 ++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index a9ba782d8ca0..294619ade49f 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -18,6 +18,8 @@ if [ -z "$BASE_DIR" ]; then
>   	exit 1
>   fi
>   
> +TR_CMD=$(command -v tr)
> +
>   # If Perl is unavailable, we must fall back to line-at-a-time prefixing
>   # with sed instead of unbuffered output.
>   tap_prefix()
> @@ -49,6 +51,31 @@ run_one()
>   
>   	# Reset any "settings"-file variables.
>   	export kselftest_timeout="$kselftest_default_timeout"
> +
> +	# Safe default if tr not available
> +	kselftest_cmd_args_ref="KSELFTEST_ARGS"
> +
> +	# Optional arguments for this command, possibly defined as an
> +	# environment variable built using the test executable in all
> +	# uppercase and sanitized substituting non acceptable shell
> +	# variable name characters with "_" as in:
> +	#
> +	# 	KSELFTEST_<UPPERCASE_SANITIZED_TESTNAME>_ARGS="<options>"
> +	#
> +	# e.g.
> +	#
> +	# 	rtctest --> KSELFTEST_RTCTEST_ARGS="/dev/rtc1"
> +	#
> +	# 	cpu-on-off-test.sh --> KSELFTEST_CPU_ON_OFF_TEST_SH_ARGS="-a -p 10"
> +	#
> +	if [ -n "$TR_CMD" ]; then
> +		BASENAME_SANITIZED=$(echo "$BASENAME_TEST" | \
> +					$TR_CMD -d "[:blank:][:cntrl:]" | \
> +					$TR_CMD -c "[:alnum:]_" "_" | \
> +					$TR_CMD [:lower:] [:upper:])
> +		kselftest_cmd_args_ref="KSELFTEST_${BASENAME_SANITIZED}_ARGS"
> +	fi
> +
>   	# Load per-test-directory kselftest "settings" file.
>   	settings="$BASE_DIR/$DIR/settings"
>   	if [ -r "$settings" ] ; then
> @@ -69,7 +96,8 @@ run_one()
>   		echo "# Warning: file $TEST is missing!"
>   		echo "not ok $test_num $TEST_HDR_MSG"
>   	else
> -		cmd="./$BASENAME_TEST"
> +		eval kselftest_cmd_args="\$${kselftest_cmd_args_ref:-}"
> +		cmd="./$BASENAME_TEST $kselftest_cmd_args"
>   		if [ ! -x "$TEST" ]; then
>   			echo "# Warning: file $TEST is not executable"
>   
> 

Looks good to me. Applying to linux-kselftest next for 5.18

thanks,
-- Shuah
