Return-Path: <linux-kselftest+bounces-28437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDB6A55970
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 23:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C07817A387A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 22:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEB4272917;
	Thu,  6 Mar 2025 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3R2KCvb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B1B155342;
	Thu,  6 Mar 2025 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299159; cv=none; b=pRhOIIkf+JvQDMRVBIJv6ZGFMMrTM7ZwqM7dckQsECqf7zf0Tal5QCDJRP1Ivu/FsDUN7dUffjkQDu0SjE3vWaxbg9CJS5lb5wHdrPyDkW8yHG/Hiz6xxBpsamaP24huF2ExwLIY3tjecz00SrjNB22w7XxV4z6r4RbFNVVomIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299159; c=relaxed/simple;
	bh=+sabWWNgYhqx08Z5grRAbwqNFekSBNSN06iAaMOFvBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fu7QwFnzJg2Tw9LNXZ4Cutt6FAedIyGrKuY7dwAo4mxogfPdshp7Qj8jHdXZEB5R9Of1cmekOY57DHK5Uka00vSTFTQy6rZDk/SzunM2RQDMF5ameQ7ucQuMzqc4m82rlLMDcrwGAArVQFOUk/mooLodTIZWUhuU6+iBDvTB6lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3R2KCvb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f8263ae0so23683685ad.0;
        Thu, 06 Mar 2025 14:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741299157; x=1741903957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+Jq5X4jSNDF11QdcBP4rcb9bMRR3aqNbsP12WYItBI=;
        b=R3R2KCvbkTNWkilmSMUt7CXSeY2pm3SQZu0ONmO7m1qP1cAkfepHmyovYHDunZ9y0E
         GqnKiP/S6ZXdRrgIVEomEKH9dpowo5Y6V3ehHwVAowNTgzOH66A7ffGWS96wlAPH/BcE
         IAOuG7XYE7jjJ9eTdVdSzEzxJOp2/jm1HCLaKc7HzzmRyvmJgAHhkDsA861MTUsk5LKe
         1bGTdUjdHKOKv+HhOFUKfPN0FsoJ4bQTlIxmV8tUzfayhIMPhE1vcYThI0Ni0JWxY8Cj
         MEwqOAGZU+Rq8kUBmiLdF2UWWeH/1qQR+BriQjEJsXaQz1IPVA9be2Sq686tI3RL2zPp
         wibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741299157; x=1741903957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+Jq5X4jSNDF11QdcBP4rcb9bMRR3aqNbsP12WYItBI=;
        b=jV+esP7+YFrIhJsWuq9htfyq/dmAGAxYDCfSbCmMkO6VPvq3mPFdbAlbbZoM/JaM6d
         GI2reYxiET0qrpErzjZGcKq9pgd+hROBb5xh7oZlNHmDwi69mfujdL8sX5GBkRs/I089
         2ss4Y02Xbyr4wYuvRJ4cqzafUfoIQekHT0Fcd5zUl23DjtxQXodpXp0+I4yPBUZ08j0m
         KByscPw/4AP3h7zG+EMDDGg4zPY4qwTzjRfLjjD2W6LTioZ8oyJFNtkHAEbLtTEenBAV
         6Lf9T17cpCJ/H1OntE+ltu+ecckWfHaYOCqpeJowfBplfbrNn0tTlI2gcYMcvyTiItyK
         KACg==
X-Forwarded-Encrypted: i=1; AJvYcCWwrBTi4wAUscKa20Zl22yzF2OtkX64ZC8vYi7D01jyefvSinLmkCAgVA3M9/UEZAcmz9aqnW6tDvQRNcC+wEwe@vger.kernel.org, AJvYcCX/rtBiEmFyrpHeYVgA9JHE0dAuvM+izXrmL1h/myGHmfidhOgAvD2LuWfHmsmvltObzkA1c+3SOUy9qyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1acbri7Rx1rhzg+NYO/z7t2Ss7v/cXJDy0dl95/8v8uLVZus4
	40qELboySRFdVRaFfmilsfDa3hp7OCQg2oylrq7VslGWxbxeThF+
X-Gm-Gg: ASbGncuXcSycaDadxmObgGY6nB/4WqEPM/YlNMKudJegtgjbPb0H6wjRTqAo+253b0G
	v3N7K4tADFtzcWwueupMn5WacsfzHesSNymeMSpp4OaK/Rk7bAka8RdXWBH3KkPHz8gg8WhrvrK
	1xbxtP45h8eQzyaSPI9TVh5UWMNfEOa1hMot7QeXVSjT+pjUj+2dXhqImRvUuXIWzmd4/G2OCK1
	uCAvcwknCZHsDDMrYK7vqU+PUBAH8JoKEM6neXw1ylWOmBtAiZOIpYzxEQtiNLHB8+oTK4G/fvO
	d9xa1LPZSDCC+rihMxSql9GYXr7TUuarxUqvrapt2nXFkKiCbBQf3Jcm5yvO/4sZc467Kgw/74q
	MVDu+PT8OMKG/wbwmLlTF
X-Google-Smtp-Source: AGHT+IFnZYQpL+b0CcPNlfmXqGPZImhe+OjZAVhs0wvS1ab8bHEg8OBP/DIAFWYcE+bU7/I+kFUEBg==
X-Received: by 2002:a17:903:1b63:b0:223:3ef1:a30a with SMTP id d9443c01a7336-22428bd36demr14982035ad.45.1741299157307;
        Thu, 06 Mar 2025 14:12:37 -0800 (PST)
Received: from ?IPV6:2804:d57:4e50:a700:f33d:65d1:e22e:109b? ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91c50sm17466085ad.185.2025.03.06.14.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 14:12:36 -0800 (PST)
Message-ID: <b2637bad-9022-496a-9b83-0d348a6350b4@gmail.com>
Date: Thu, 6 Mar 2025 19:12:32 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: livepatch: test if ftrace can trace a
 livepatched function
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Felipe Xavier <felipe_life@live.com>
References: <20250111-ftrace-selftest-livepatch-v2-1-9f4ff90f251a@gmail.com>
Content-Language: en-US
From: Filipe Xavier <felipeaggger@gmail.com>
In-Reply-To: <20250111-ftrace-selftest-livepatch-v2-1-9f4ff90f251a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/11/25 3:42 PM, Filipe Xavier wrote:

> This new test makes sure that ftrace can trace a
> function that was introduced by a livepatch.
>
> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
> ---
> Changes in v2:
> - functions.sh: added reset tracing on push and pop_config.
> - test-ftrace.sh: enabled tracing_on before test init.
> - nitpick: added double quotations on filenames and fixed some wording.
> - Link to v1: https://lore.kernel.org/r/20250102-ftrace-selftest-livepatch-v1-1-84880baefc1b@gmail.com
> ---
>   tools/testing/selftests/livepatch/functions.sh   | 14 ++++++++++
>   tools/testing/selftests/livepatch/test-ftrace.sh | 33 ++++++++++++++++++++++++
>   2 files changed, 47 insertions(+)
>
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index e5d06fb402335d85959bafe099087effc6ddce12..e6c13514002dae5f8d7461f90b8241ab43024ea4 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -62,6 +62,9 @@ function push_config() {
>   			awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
>   	FTRACE_ENABLED=$(sysctl --values kernel.ftrace_enabled)
>   	KPROBE_ENABLED=$(cat "$SYSFS_KPROBES_DIR/enabled")
> +	TRACING_ON=$(cat "$SYSFS_DEBUG_DIR/tracing/tracing_on")
> +	CURRENT_TRACER=$(cat "$SYSFS_DEBUG_DIR/tracing/current_tracer")
> +	FTRACE_FILTER=$(cat "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter")
>   }
>   
>   function pop_config() {
> @@ -74,6 +77,17 @@ function pop_config() {
>   	if [[ -n "$KPROBE_ENABLED" ]]; then
>   		echo "$KPROBE_ENABLED" > "$SYSFS_KPROBES_DIR/enabled"
>   	fi
> +	if [[ -n "$TRACING_ON" ]]; then
> +		echo "$TRACING_ON" > "$SYSFS_DEBUG_DIR/tracing/tracing_on"
> +	fi
> +	if [[ -n "$CURRENT_TRACER" ]]; then
> +		echo "$CURRENT_TRACER" > "$SYSFS_DEBUG_DIR/tracing/current_tracer"
> +	fi
> +	if [[ "$FTRACE_FILTER" == *"#"* ]]; then
> +		echo > "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter"
> +	elif [[ -n "$FTRACE_FILTER" ]]; then
> +		echo "$FTRACE_FILTER" > "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter"
> +	fi
>   }
>   
>   function set_dynamic_debug() {
> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
> index fe14f248913acbec46fb6c0fec38a2fc84209d39..66af5d726c52e48e5177804e182b4ff31784d5ac 100755
> --- a/tools/testing/selftests/livepatch/test-ftrace.sh
> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
> @@ -61,4 +61,37 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
>   % rmmod $MOD_LIVEPATCH"
>   
>   
> +# - verify livepatch can load
> +# - check if traces have a patched function
> +# - unload livepatch and reset trace
> +
> +start_test "trace livepatched function and check that the live patch remains in effect"
> +
> +TRACE_FILE="$SYSFS_DEBUG_DIR/tracing/trace"
> +FUNCTION_NAME="livepatch_cmdline_proc_show"
> +
> +load_lp $MOD_LIVEPATCH
> +
> +echo 1 > "$SYSFS_DEBUG_DIR/tracing/tracing_on"
> +echo $FUNCTION_NAME > "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter"
> +echo "function" > "$SYSFS_DEBUG_DIR/tracing/current_tracer"
> +echo "" > "$TRACE_FILE"
> +
> +if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
> +	echo -e "FAIL\n\n"
> +	die "livepatch kselftest(s) failed"
> +fi
> +
> +grep -q $FUNCTION_NAME "$TRACE_FILE"
> +FOUND=$?
> +
> +disable_lp $MOD_LIVEPATCH
> +unload_lp $MOD_LIVEPATCH
> +
> +if [ "$FOUND" -eq 1 ]; then
> +	echo -e "FAIL\n\n"
> +	die "livepatch kselftest(s) failed"
> +fi
> +
> +
>   exit 0
>
> ---
> base-commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
> change-id: 20250101-ftrace-selftest-livepatch-161fb77dbed8
>
> Best regards,

Hi Folks, sorry for the delay... thanks everyone for the feedback's.

I applied almost all the requested adjustments, except this one:

 > echo '!*:traceoff' > "$SYSFS_TRACING_DIR/set_ftrace_filter"
causes this error:  "echo: write error: no such device"

 > echo "" > "$SYSFS_TRACING_DIR/current_tracer"
causes this error:  "echo: write error: invalid argument"

I sent a new patchSet(splited) to the list.

Cheers,

Filipe Xavier


