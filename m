Return-Path: <linux-kselftest+bounces-24584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B42A12793
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 16:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE5E188A3CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B07F1591EA;
	Wed, 15 Jan 2025 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JWQ618aX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE0A1411EB
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736955119; cv=none; b=Tc6+KoT5/2JdKi15kGForRRJwUl9UdGjrXzeCRGDYu/vKSLpkdaYn70ZeET70QwfTeQswoa7bleLHzu3d959Ul4YUpUfvalJ0el7gBr8akXJ3KpkS8xk5UUr5W+zpHAqoyeWqF+mq715iKPd46tEkHG9EofhKEv9FRddhJ9jEio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736955119; c=relaxed/simple;
	bh=jXF89xKBnh+AD5qH+eCYzKNmJC1ZXvrRrlsJfnRr8Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOl5i5ZyckNr2W4hoNF57ifgcGpXj8O8IeWVAFcgmGtqR32LfBAYV6LibZyyMSqla3IZOHcokC4/4KmMNWeZUIx9qOmIglDiPwjeKICUY0hzL0gUkA+D3KqVETst3U1hOhOIuOM2zxk0uxvJ4/6IMjhpQ5iQ+pYor4Y23Nt8a0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JWQ618aX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43624b2d453so72681845e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 07:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736955114; x=1737559914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1vqnrUKIh63ENHovv3lz9LwYLlI+FHwNt6f3V45tzuM=;
        b=JWQ618aXAEspyOpvM8Q3paIWkEp5rYxuwHvdxzyYKmaYfSrhqN+YD/ri7Iulg0bgeJ
         QUc7GTX5wqpYJbBMYL2k/n16FEhfutLg1NcJiLzY95/T82g1IFUImlxaU5I+uQpMz6Hf
         An/BmGG11a/zaOEm/Koi8u9dFGDx68MYQNTsC0qEkBvtRkLKHpBhzyMvpampADg77lEh
         MLgw8SW4d4j4HXSafbvAm94pdfc/0n9YBcXq6JbAKab4wP2yEyrjP/xjGibzTkYxqniY
         gfWNmQDr5Jey2KWnk4H7oQhoqg2a0xDQ9dMIebJMUrozFFNvLrg7UiIjp7MlOD0+3uaq
         iglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736955114; x=1737559914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vqnrUKIh63ENHovv3lz9LwYLlI+FHwNt6f3V45tzuM=;
        b=XHUYowiA2odp3HwVpaEzibB7dlMalvzta/BtgBKLEVhuZvnN4c6wmfrPcqAEsciQcL
         PslFNyeBA5an05GXNMI0wWh0fD8rRbrgtO5IBQO378aWoUcW0l3zdTvB1qRExSfcXlEN
         z45EYfdFm6KSbMoVEE8rj3F9k8RRWfQGPQZtCwDTgrrn0fmC2MwrW/9M+GANqIWIKeDB
         QbI/lf/LDsmaVI93v/JkQJh1NSVGUdGG7gda/gtGxUD5VZe7EzCM/LCJL4QYrplrUWsH
         Zcp9DkA6Xw+nhXUc+gyJBOVMxCdzk7e4zyyNtX58goBW6XQEOwA+ewM+pXtcuSmDX554
         ETLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrM8ILhltCMAL13ADtIZmsCs6C8ZHDGg22GKB2fzheqg+P+kbCCW/vf//KGNeDZQs4p/+8/AQwn+JTBvGWbXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMp3sPVr2YShxToTybHtYKOoKc71RNzXDtsPoOoajB0stLKMP1
	CwvFbshUNKDJtZGO0U6K04WdjtcGFnbO53SkBGKas3YMT4xF0Mq8wNTUm4XeuL4=
X-Gm-Gg: ASbGncs+kECVROD8e+LLys6aBfSTUjUhF3AIlI+eu4NqlPMTHW4mwrH4TvgYrEEtXL0
	tAF/XAfTjwJ9aVs4fSa9tpgpFFkZPunA7Df1UEzbuk5RvMO5QByD6d097ckQ4FsB2BOFtfwJH6i
	48y5rl605uI2Mms2djneQ8KV2zULvL8tvBCGeTGBE+WhU2oY5j9qNZrIE09kkjogCpsGvqItt1o
	+sjmC4YG8gk09ahAdDrDQfT8/RFphiZSh16Dp1yYr/YSd7TE6uGDUKTLA==
X-Google-Smtp-Source: AGHT+IG3kHQwZtuC4Ysp3cANtbOTE9JmK3wljiHmMzPB4y66FwZUu7l+6M3B3NnDSAQBGnYagFcg4A==
X-Received: by 2002:a05:6000:712:b0:385:ee3f:5cbf with SMTP id ffacd0b85a97d-38a87305369mr24469573f8f.20.1736955113748;
        Wed, 15 Jan 2025 07:31:53 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e383df8sm18236107f8f.38.2025.01.15.07.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 07:31:53 -0800 (PST)
Date: Wed, 15 Jan 2025 16:31:51 +0100
From: Petr Mladek <pmladek@suse.com>
To: Filipe Xavier <felipeaggger@gmail.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Felipe Xavier <felipe_life@live.com>
Subject: Re: [PATCH v2] selftests: livepatch: test if ftrace can trace a
 livepatched function
Message-ID: <Z4fU57ir_IXGlsWq@pathway.suse.cz>
References: <20250111-ftrace-selftest-livepatch-v2-1-9f4ff90f251a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111-ftrace-selftest-livepatch-v2-1-9f4ff90f251a@gmail.com>

Hi Filipe,

first, thanks for the test. It is good. I just suggest a lot of clean
up ;-)

On Sat 2025-01-11 15:42:27, Filipe Xavier wrote:
> This new test makes sure that ftrace can trace a
> function that was introduced by a livepatch.
> ---
> Changes in v2:
> - functions.sh: added reset tracing on push and pop_config.
> - test-ftrace.sh: enabled tracing_on before test init.
> - nitpick: added double quotations on filenames and fixed some wording. 
> - Link to v1: https://lore.kernel.org/r/20250102-ftrace-selftest-livepatch-v1-1-84880baefc1b@gmail.com
> ---
>  tools/testing/selftests/livepatch/functions.sh   | 14 ++++++++++
>  tools/testing/selftests/livepatch/test-ftrace.sh | 33 ++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index e5d06fb402335d85959bafe099087effc6ddce12..e6c13514002dae5f8d7461f90b8241ab43024ea4 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -62,6 +62,9 @@ function push_config() {
>  			awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
>  	FTRACE_ENABLED=$(sysctl --values kernel.ftrace_enabled)
>  	KPROBE_ENABLED=$(cat "$SYSFS_KPROBES_DIR/enabled")
> +	TRACING_ON=$(cat "$SYSFS_DEBUG_DIR/tracing/tracing_on")

The $SYSFS_DEBUG_DIR/tracing directory is used many times. It would
make sense to define:

SYSFS_TRACING_DIR="$SYSFS_DEBUG_DIR/tracing"

and use:

	TRACING_ON=$(cat "$SYSFS_TRACING_DIR/tracing_on")

> +	CURRENT_TRACER=$(cat "$SYSFS_DEBUG_DIR/tracing/current_tracer")
> +	FTRACE_FILTER=$(cat "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter")
>  }
>  
>  function pop_config() {
> @@ -74,6 +77,17 @@ function pop_config() {
>  	if [[ -n "$KPROBE_ENABLED" ]]; then
>  		echo "$KPROBE_ENABLED" > "$SYSFS_KPROBES_DIR/enabled"
>  	fi
> +	if [[ -n "$TRACING_ON" ]]; then
> +		echo "$TRACING_ON" > "$SYSFS_DEBUG_DIR/tracing/tracing_on"
> +	fi
> +	if [[ -n "$CURRENT_TRACER" ]]; then
> +		echo "$CURRENT_TRACER" > "$SYSFS_DEBUG_DIR/tracing/current_tracer"
> +	fi
> +	if [[ "$FTRACE_FILTER" == *"#"* ]]; then
> +		echo > "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter"

My understanding is that this is handling the situation when the
filter is:

   #### all functions enabled ####

I was curious about the pattern *"#"*. The quotation looked pretty
non-standard to me. It made me to read the bash documentation and
the rules for extressions in [[ ]] looked quite complicated.

I wonder if we could make this more for "dummies". The following
seems to work:

	if [[ -n "$FTRACE_FILTER" ]]; then
		echo "$FTRACE_FILTER"
			| sed -e "/#### all functions enabled ####/d"
			> "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter"
	fi

Note that the string "#### all functions enabled ####" is a very
stable thing. It has never been modified since it was introduced
by the commit 0c75a3ed633419d75d ("ftrace: state that all functions
are enabled in set_ftrace_filter") in Feb 2009.

The string is used also in ftrace selftests, see
tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc

> +	elif [[ -n "$FTRACE_FILTER" ]]; then
> +		echo "$FTRACE_FILTER" > "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter"
> +	fi
>  }
>  
>  function set_dynamic_debug() {
> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
> index fe14f248913acbec46fb6c0fec38a2fc84209d39..66af5d726c52e48e5177804e182b4ff31784d5ac 100755
> --- a/tools/testing/selftests/livepatch/test-ftrace.sh
> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
> @@ -61,4 +61,37 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
>  % rmmod $MOD_LIVEPATCH"
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

The above mentioned ftrace selftest shows that the behavior gets
more complicated when "traceoff" is used:

  1. The "traceoff" entries are not cleared by the above command.
  2. The "traceoff" entries might cause that the tracing will
     stop before we finish this test.

> +echo "function" > "$SYSFS_DEBUG_DIR/tracing/current_tracer"
> +echo "" > "$TRACE_FILE"

I suggest to change the ordering and make sure that nothing is running
before we start:

# Start with the clean up
echo 0 > "$SYSFS_TRACING_DIR/tracing_on"
echo '!*:traceoff' > $SYSFS_TRACING_DIR/set_ftrace_filter
echo "" > "$SYSFS_TRACING_DIR/current_tracer"
echo "" > $SYSFS_TRACING_DIR/trace
# Setup and start our tracing
echo "function" > "$SYSFS_TRACING_DIR/current_tracer"
echo $FUNCTION_NAME > "$SYSFS_TRACING_DIR/set_ftrace_filter"
echo 1 > "$SYSFS_TRACING_DIR/tracing_on"

I suggest to this into helper functions which might be used
by more tests:

# cleanup_tracing() - stop and clean up function tracing
function cleanup_tracing() {
	echo 0 > "$SYSFS_TRACING_DIR/tracing_on"
	echo '!*:traceoff' > $SYSFS_TRACING_DIR/set_ftrace_filter
	echo "" > "$SYSFS_TRACING_DIR/current_tracer"
	echo "" > $SYSFS_TRACING_DIR/trace
}

# trace_function(function) - start tracing of a function
#	function - to be traced function
function trace_function() {
	local function="$1"; shift

	cleanup_tracing

	echo "function" > "$SYSFS_TRACING_DIR/current_tracer"
	echo "$functions" > $SYSFS_TRACING_DIR/set_ftrace_filter
	echo 1 > "$SYSFS_TRACING_DIR/tracing_on"
}

# check_traced_function(function) - check whether function appeared in trace log
#	function - to be traced function
function check_trace_function() {
	local function="$1"; shift

	if ! grep -q "$function" $SYSFS_TRACING_DIR/trace" ; then
		die "Function ($function) did not appear in the trace"
	fi
}

As Marcos suggested, it would make sense to add the above mentioned
helper functions in a separate patch.

> +
> +if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
> +	echo -e "FAIL\n\n"
> +	die "livepatch kselftest(s) failed"
> +fi
> +
> +grep -q $FUNCTION_NAME "$TRACE_FILE"
> +FOUND=$?

We could replace this with the above proposed

	check_traced_function "$FUNCTION_NAME"

Also I would personally stop the tracing after this sub-test finishes.
We might use the cleanup_tracing function here.

	cleanup_tracing

> +
> +disable_lp $MOD_LIVEPATCH
> +unload_lp $MOD_LIVEPATCH
> +
> +if [ "$FOUND" -eq 1 ]; then
> +	echo -e "FAIL\n\n"
> +	die "livepatch kselftest(s) failed"
> +fi

As mentioned by Marcos, we should also print "ok" on success.
I would personally use the "check_result" function here. It
could catch non-expected entries in dmesg.

> +
>  exit 0

Best Regards,
Petr

