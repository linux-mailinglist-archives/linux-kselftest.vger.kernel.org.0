Return-Path: <linux-kselftest+bounces-24582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485FAA126CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 16:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DB23A16E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 15:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCDA13C81B;
	Wed, 15 Jan 2025 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcn5udG+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63AE481B3
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736953404; cv=none; b=RRTMAB+8XXPBXRzv2mUIrCH5W4TGrddTj9r4jYPeqD5zWySDr/lqRrCX8i6O369Y27TCxX+WmseTBJi9HuO/G0ajLZAP7lLPjOwKGz+fMuY5p658BV+DOAu8xAfLQNGAwfjJ+rV32I/OOinoh9kC+fYwveaFyrX18HzEcgKiZ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736953404; c=relaxed/simple;
	bh=/KhDQXFdx1HNLxOFKGUlHSJs6ggG4sn8IIiQrBLO5bI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=tU+TiPlgwL677xRSCNQnvkX1ohpfxSOhWsz54o89IlZhOQ2liiXz26MIFC1LjNPiL8wXTtB2MNUrq1jMJTCOnPkbjbC4lqQBAWA6znLpZ2bO+Fxm+rWUlXL+VM2PI0g31LrrfHa6E+kcAdLv4J7tpLZwGAc3m5k5q+lJsi9ZPH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bcn5udG+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736953400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0abEoGkyoE1QdfpXorZ/cAQ2SjeYoeosF/RXyM4oSu8=;
	b=bcn5udG+ycvjqPXCJ9N0Td2+iAnfCGdFd8cKCf4yu++DbRzmBtllH1yeM6lS43j72Obqa6
	/Uo7Tzw7THVywu5lDth02TnTJ5R4bqkQDnMqgGUYQ/+UaVOKeB2lTrWC9DMsF1Ae4rs8ko
	xAgnTPeE1PL+MR22iLjfXA55vq4Wcz4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-eZSnbazBMOms7Gb4l5pWYA-1; Wed, 15 Jan 2025 10:03:19 -0500
X-MC-Unique: eZSnbazBMOms7Gb4l5pWYA-1
X-Mimecast-MFC-AGG-ID: eZSnbazBMOms7Gb4l5pWYA
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6ecd22efbso179841885a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 07:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736953399; x=1737558199;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0abEoGkyoE1QdfpXorZ/cAQ2SjeYoeosF/RXyM4oSu8=;
        b=wONq8fwifXDms3ajP4sVqoTs/tfOZsnqelZcxPki9N/6evrIraouaI55Lx1rqml8b3
         6U1mt+lEBlLZBQIGiR4QJSF7hmwvJfNnYJm4LNI3Uo6OmbjPk4OBT0wEg0jlMynqJQe9
         nyOVU+Ys5v2/qeI4Ky5yfTGy/J1qGThJaBOWPdBJ6HIZz7+kDYOCxgmFQVfoW83ToK49
         FTCG3I4Z5MT6crcTCbkjWnjjFzpLJSYFdL08PUoxcJv0UiK6WnTieXa6xjRpxaje30OE
         ELUO2+CyW6JOPFNRXvhJjiBgXJmEXsXbf6FjUAoVDFqQNKixVMS1TGw46PpqmNxAM/AG
         2Ugw==
X-Forwarded-Encrypted: i=1; AJvYcCXzKVMHkCIOTF51VEbj27Svio6JuVUS065C3J8/tHVp1s1+KMK5tXh1OJmGBeGEAWl2E2d3BiJw+icn30ORvBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKTk1U7Jlagstgl88THljdHwPyzZSQm5PANut1O6xz0O9omRq
	m3z2U7d9RdNPPOjpcMBUS+P7THORux5ATvitWQzC2iF8po50e+XV7f2QWiND4qbp1aIA7O60juz
	n4TSIf7C2UUQPVD6uoRmEvtMq7/I6ceizQz03j0i53iYTLqPzBHWjcmSw/TgMZBCIeA==
X-Gm-Gg: ASbGnctGDMEreyU4Pbpy9H5jTi7q77gI521nPO6x4c+b+SNyvH5ReRYd0vFjTbQoUtt
	z1UG+cpuoOp2LyeMA0RZszGqAdKVFhH6W4KS2JGjZZWXowQFXBIKYGzdRjGQQVzsAxd/mlcm/nE
	rEmg/bBJDjB4qC4nJjrCtgttNmznZ6eQSKkuB4rjuASss9AhQhxYihYWPvHeHC2qJKCVfgZEZx5
	ZON3bP2sGqh3AWvVjNb3A0eti6xFwKOfSbT9eCDEta7e2njYy/seoSuOQEdwptTy+2CsnzrMcPX
	9tkz11qZYjkt6BrQO9g8lXqUqQieGibr86RD4Fc=
X-Received: by 2002:a05:620a:4513:b0:7b1:4a2a:9ae0 with SMTP id af79cd13be357-7be523dac64mr554726885a.9.1736953398941;
        Wed, 15 Jan 2025 07:03:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqThpU+a/wawXkrQbgAp6/dywjE1IdqD+XX/1OB0uRU6P5pD+Nm1/7o/u7tCUjar01Xr4xug==
X-Received: by 2002:a05:620a:4513:b0:7b1:4a2a:9ae0 with SMTP id af79cd13be357-7be523dac64mr554718685a.9.1736953398353;
        Wed, 15 Jan 2025 07:03:18 -0800 (PST)
Received: from [192.168.1.45] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad85fe81sm65591506d6.6.2025.01.15.07.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 07:03:17 -0800 (PST)
Message-ID: <e8aae0a4-3f51-e29e-ec1e-2914851d7f5c@redhat.com>
Date: Wed, 15 Jan 2025 10:03:15 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
 Filipe Xavier <felipeaggger@gmail.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 Shuah Khan <shuah@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Felipe Xavier <felipe_life@live.com>
References: <20250111-ftrace-selftest-livepatch-v2-1-9f4ff90f251a@gmail.com>
 <12c6681e2d13994c2efd5d25372293b9f53a9f8a.camel@suse.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2] selftests: livepatch: test if ftrace can trace a
 livepatched function
In-Reply-To: <12c6681e2d13994c2efd5d25372293b9f53a9f8a.camel@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/14/25 12:18, Marcos Paulo de Souza wrote:
> On Sat, 2025-01-11 at 15:42 -0300, Filipe Xavier wrote:
>> This new test makes sure that ftrace can trace a
>> function that was introduced by a livepatch.
>>
>> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
> 
> Thanks for the new test Filipe!
> 
> I have some nits below, but these don't need to be addressed for the
> test to be merged. Either way,
> 
> Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> Tested-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> 
> 
>> ---
>> Changes in v2:
>> - functions.sh: added reset tracing on push and pop_config.
>> - test-ftrace.sh: enabled tracing_on before test init.
>> - nitpick: added double quotations on filenames and fixed some
>> wording. 
>> - Link to v1:
>> https://lore.kernel.org/r/20250102-ftrace-selftest-livepatch-v1-1-84880baefc1b@gmail.com
>> ---
>>  tools/testing/selftests/livepatch/functions.sh   | 14 ++++++++++
>>  tools/testing/selftests/livepatch/test-ftrace.sh | 33
>> ++++++++++++++++++++++++
>>  2 files changed, 47 insertions(+)
>>
>> diff --git a/tools/testing/selftests/livepatch/functions.sh
>> b/tools/testing/selftests/livepatch/functions.sh
>> index
>> e5d06fb402335d85959bafe099087effc6ddce12..e6c13514002dae5f8d7461f90b8
>> 241ab43024ea4 100644
>> --- a/tools/testing/selftests/livepatch/functions.sh
>> +++ b/tools/testing/selftests/livepatch/functions.sh
>> @@ -62,6 +62,9 @@ function push_config() {
>>  			awk -F'[: ]' '{print "file " $1 " line " $2
>> " " $4}')
>>  	FTRACE_ENABLED=$(sysctl --values kernel.ftrace_enabled)
>>  	KPROBE_ENABLED=$(cat "$SYSFS_KPROBES_DIR/enabled")
>> +	TRACING_ON=$(cat "$SYSFS_DEBUG_DIR/tracing/tracing_on")
>> +	CURRENT_TRACER=$(cat
>> "$SYSFS_DEBUG_DIR/tracing/current_tracer")
>> +	FTRACE_FILTER=$(cat
>> "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter")
>>  }
>>  
>>  function pop_config() {
>> @@ -74,6 +77,17 @@ function pop_config() {
>>  	if [[ -n "$KPROBE_ENABLED" ]]; then
>>  		echo "$KPROBE_ENABLED" >
>> "$SYSFS_KPROBES_DIR/enabled"
>>  	fi
>> +	if [[ -n "$TRACING_ON" ]]; then
>> +		echo "$TRACING_ON" >
>> "$SYSFS_DEBUG_DIR/tracing/tracing_on"
>> +	fi
>> +	if [[ -n "$CURRENT_TRACER" ]]; then
>> +		echo "$CURRENT_TRACER" >
>> "$SYSFS_DEBUG_DIR/tracing/current_tracer"
>> +	fi
>> +	if [[ "$FTRACE_FILTER" == *"#"* ]]; then
>> +		echo > "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter"
>> +	elif [[ -n "$FTRACE_FILTER" ]]; then
>> +		echo "$FTRACE_FILTER" >
>> "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter"
>> +	fi
>>  }
> 
> I believe that this could be a separate patch, since this is new
> functionality that's being added to functions.sh, and not exactly
> related to the new test.
> 
>>  
>>  function set_dynamic_debug() {
>> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh
>> b/tools/testing/selftests/livepatch/test-ftrace.sh
>> index
>> fe14f248913acbec46fb6c0fec38a2fc84209d39..66af5d726c52e48e5177804e182
>> b4ff31784d5ac 100755
>> --- a/tools/testing/selftests/livepatch/test-ftrace.sh
>> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
>> @@ -61,4 +61,37 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
>>  % rmmod $MOD_LIVEPATCH"
>>  
>>  
>> +# - verify livepatch can load
>> +# - check if traces have a patched function
>> +# - unload livepatch and reset trace
>> +
>> +start_test "trace livepatched function and check that the live patch
>> remains in effect"
>> +
>> +TRACE_FILE="$SYSFS_DEBUG_DIR/tracing/trace"
>> +FUNCTION_NAME="livepatch_cmdline_proc_show"
>> +
>> +load_lp $MOD_LIVEPATCH
>> +
>> +echo 1 > "$SYSFS_DEBUG_DIR/tracing/tracing_on"
>> +echo $FUNCTION_NAME > "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter"
>> +echo "function" > "$SYSFS_DEBUG_DIR/tracing/current_tracer"
>> +echo "" > "$TRACE_FILE"
>> +
>> +if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live
>> patched" ]] ; then
>> +	echo -e "FAIL\n\n"
>> +	die "livepatch kselftest(s) failed"
>> +fi
>> +
>> +grep -q $FUNCTION_NAME "$TRACE_FILE"
>> +FOUND=$?
>> +
>> +disable_lp $MOD_LIVEPATCH
>> +unload_lp $MOD_LIVEPATCH
>> +
>> +if [ "$FOUND" -eq 1 ]; then
>> +	echo -e "FAIL\n\n"
>> +	die "livepatch kselftest(s) failed"
>> +fi
>> +
>> +
>>  exit 0
> 
> The test works, and that's very cool. But when running locally, I find
> the if we miss check_result call it doesn't add a newline after the
> "ok":
> 
> ...
> # timeout set to 0                                                    
> # selftests: livepatch: test-ftrace.sh                                
> # TEST: livepatch interaction with ftrace_enabled sysctl ... ok       
> # TEST: trace livepatched function and check that the live patch
> remains in effect ... ok 5 selftests: livepatch: test-ftrace.sh       
> # timeout set to 0                                                    
> # selftests: livepatch: test-sysfs.sh  
> ...
> 
> If the check_result below is added the output if sane again:
> 
> ...
> # selftests: livepatch: test-ftrace.sh
> # TEST: livepatch interaction with ftrace_enabled sysctl ... ok
> # TEST: trace livepatched function and check that the live patch
> remains in effect ... ok
> ok 5 selftests: livepatch: test-ftrace.sh
> ...
> 
> I checked and this would be the only one test without using
> check_result, so maybe we should add this either way? I'm not sure what
> you guys think about it.
> 
> 
> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh
> b/tools/testing/selftests/livepatch/test-ftrace.sh
> index 66af5d726c52..135c0fb17a98 100755
> --- a/tools/testing/selftests/livepatch/test-ftrace.sh
> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
> @@ -93,5 +93,18 @@ if [ "$FOUND" -eq 1 ]; then
>  	die "livepatch kselftest(s) failed"
>  fi
>  
> +check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> +livepatch: '$MOD_LIVEPATCH': completing patching transition
> +livepatch: '$MOD_LIVEPATCH': patching complete
> +% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
> +livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
> +livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> +livepatch: '$MOD_LIVEPATCH': unpatching complete
> +% rmmod $MOD_LIVEPATCH"
> +
>  

Ah good catch, I noticed the newline, too, but didn't notice that the
test wasn't using check_result().  For consistency, let's make that
change before merging.

Thanks,

-- 
Joe


