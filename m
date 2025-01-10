Return-Path: <linux-kselftest+bounces-24223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CD8A0982E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 18:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03265188D92F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 17:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34CC2135CB;
	Fri, 10 Jan 2025 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwyJbHgX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A4212B17;
	Fri, 10 Jan 2025 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736529211; cv=none; b=YjF6tmsDBDJEZKCl0rnVJ7BguDwYkij07Rn1uQEmOwMcBeTh4Uz+4+aWGYE0SkA9Ei/0YtLPwJOvMxHEUT8G6O2+mdz7mG4sJr6BjddgOB+2EA3JSAi/2aUkz7tWFUaw3ifmwtwnuF8TEGEaa0OMD2sYuMqaqjj8iZrR1ydIELc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736529211; c=relaxed/simple;
	bh=jRgYSBdXynrhgAusPeQD9gogiqgCNjthOe/yXYNExWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WayYcXZY32bMGacAKEnD+ZpgPB/LM/HqTmHizTaYngo4NKr+eUNflEdL6FcLuE094XdnNSNvNs00Ddw1YBW5dk/R+W1NIJHqaX8p5bESiJXawgX0c+okdIl72CQOLIqPqo/G7GC8ztOBFI0WYlmX6SCpVbKfafXO+demt4HVzSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwyJbHgX; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5189105c5f5so1313753e0c.0;
        Fri, 10 Jan 2025 09:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736529209; x=1737134009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSJG/Izidq4B8E6HnVk74WEYb8yOlpPjGefRz+rv/FI=;
        b=gwyJbHgXHBuzBHn5FvDE9O4EDQXEtAqF3uyGDQvhacbGpjk3RM6QNHIgVyRyWj+eKR
         v3npvXZbyV0lLzV4hp51nAGmj7oi0M3ESHqRPOhvk0fnx5olRWwDY85ZtafXq+sHcyf4
         tArZWRWvXLr0qncNFiDO7tRd6ayclRIyA3zJ47D+VPpGwFYf2piX7l/B1i+xM/YLaKVb
         D8b4EmRpu1HzDxDCHO0VD/SvFFC8q+/d4HxgaF0nQv51dwkW1bJYFc4oSry412+7tT63
         QbgRcTtSY6Vytjw86DNoBfwXKiTGDNwT6P72lbOSIwYJC4GZhSRGd6Rbv8hP8OBU3l7C
         8ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736529209; x=1737134009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSJG/Izidq4B8E6HnVk74WEYb8yOlpPjGefRz+rv/FI=;
        b=wyAi+0Hn6CG2iOh0ete7pzy/RQ4hd+AFpWx76tA5Fx2gjIQwL2zWc9ZM38TVeZ+RZI
         GZ48zCPeRBQAGdYaEP87IT+rWh/fpAI43FPv2YYVbq2Bz1deSBWALXn2tiFaBMyFxnMl
         /SNo0s7AQR8Chj7kCFs8rRXn18LfOcE5YA6YK18/TWTzE59zknWaZLcgLcC9Tq3A7HEU
         Ouuvp+/soOjQ96kvVaxAgKtGfYVPqvBcNHh2d44tfv9rhpJ6SLGN9c5gIV7mExRZI5qs
         tNAbGXUVmXA6bxZs7hyN3Z6oW8S9RJ5YyOV5zeG7jQbjpoKaafH2UTVvmFNa24xa2Wny
         kiMA==
X-Forwarded-Encrypted: i=1; AJvYcCVzNvqMeSi9AbacLOdBbq74+cNretRJh8d1o1xNAPC8Aj6/jq3GU5doYj7remDRR3gVyNnYUlyDQcjmpOrCjw==@vger.kernel.org, AJvYcCX2/jEY8FUwpHRcNGr4gGhJGThL32fUzdX7EboIHfOrv4/F1zoWJ59nsv1IHDDu5bS6Tit3K/ORaosUTYXYcbOw@vger.kernel.org, AJvYcCX4c9Mk3KYoXkvANVl4BgdTg2o6Fbilr61bHAmtB0u4iqaiKb+a9VEbEKRGH56s8ddmu40wNKyz5qUXetA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBwYk/jeqFJA3aLvRIgmCxe5yFEN3tGcU82ixKg5kDjrad8K5
	g1lv9r4lGhLxBvpW5uRkAOQ4khKgIx4TKpb4exlrXcFm7fyrgOkC
X-Gm-Gg: ASbGncvPo/QZ+l7txZqe/DBODI13oOc1DC5KPZC6LdXMb3a2xCHMqP1cdp5ehCnUGsO
	jHOQQtRvqRMz/hf1WEm0FYr3NAUVkO60BxNnfeeaiuVC0sOkIekpFbawn7L4aFOb3Sxy5SkvRJc
	CLi2yhxSBhkEvvUeRYxjhNOR81BN1bQI5NQmLpwbpZ2Jnr9hrSh5teYWhEDKwPK/WjueDnEmLbR
	dIDsmODWpCKL7g9cmJohHLBt4UrtPe7PkDbbjs7/7CUcBxIhz9pJDvpbfJ1mnzYDaZCq1uyR1Gx
	Hf5/uUPYlRA9+VhMJlmN2o65pHMVZEY+
X-Google-Smtp-Source: AGHT+IErP8qvq746zyvXwHe8mZyxZGPM1+PAT2EmHiyauS39z1Ran8DQYDEXDSexX2TpLkVg6PG6NQ==
X-Received: by 2002:a05:6122:2011:b0:518:89d9:dd99 with SMTP id 71dfb90a1353d-51c6c1ff93fmr11519819e0c.3.1736529209031;
        Fri, 10 Jan 2025 09:13:29 -0800 (PST)
Received: from ?IPV6:2804:d57:4e50:a700:a12d:2a91:966f:2aae? ([2804:d57:4e50:a700:a12d:2a91:966f:2aae])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51c7fc0128fsm2359016e0c.31.2025.01.10.09.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 09:13:28 -0800 (PST)
Message-ID: <9edd671a-be5e-41c9-a8dc-b1fd1d5e3375@gmail.com>
Date: Fri, 10 Jan 2025 14:13:24 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: livepatch: test if ftrace can trace a
 livepatched function
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Felipe Xavier <felipe_life@live.com>
References: <20250102-ftrace-selftest-livepatch-v1-1-84880baefc1b@gmail.com>
 <Z31VBN3zo47Ohr27@redhat.com>
Content-Language: en-US
From: Filipe Xavier <felipeaggger@gmail.com>
In-Reply-To: <Z31VBN3zo47Ohr27@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Em 07/01/2025 13:23, Joe Lawrence escreveu:

> On Thu, Jan 02, 2025 at 03:42:10PM -0300, Filipe Xavier wrote:
>> This new test makes sure that ftrace can trace a
>> function that was introduced by a livepatch.
>>
> Hi Filipe,
>
> Thanks for adding a test!
>
> Aside: another similar test could verify that the original function, in
> this case cmdline_proc_show(), can still be traced despite it being
> livepatched.  That may be non-intuitive but it demonstrates how the
> ftrace handler works.

Thanks for the review Joe!

I have fixed all points mentioned below,

and have a patch ready to submit.

Do you believe that this other similar test could be sent later,

or is it required in this patch?

>   
>> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
>> ---
>>   tools/testing/selftests/livepatch/test-ftrace.sh | 37 ++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
>> index fe14f248913acbec46fb6c0fec38a2fc84209d39..5f0d5308c88669e84210393ce7b8aa138b694ebd 100755
>> --- a/tools/testing/selftests/livepatch/test-ftrace.sh
>> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
>> @@ -61,4 +61,41 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
>>   % rmmod $MOD_LIVEPATCH"
>>   
>>   
>> +# - verify livepatch can load
>> +# - check traces if have a patched function
> nit: wording?  "check if traces have a patched function" ?
>
>> +# - unload livepatch and reset trace
>> +
>> +start_test "livepatch trace patched function and check that the live patch remains in effect"
> nit: wording?  "trace livepatched function and check ..." ?
>
>> +
>> +TRACE_FILE="$SYSFS_DEBUG_DIR/tracing/trace"
>> +FUNCTION_NAME="livepatch_cmdline_proc_show"
>> +
>> +load_lp $MOD_LIVEPATCH
>> +
>> +echo $FUNCTION_NAME > $SYSFS_DEBUG_DIR/tracing/set_ftrace_filter
>> +echo "function" > $SYSFS_DEBUG_DIR/tracing/current_tracer
>> +echo "" > $TRACE_FILE
> A few suggestions:
>
> - The tracing is also dependent on the 'tracing_on' file, so if it
>    happens to be turned off, the test will fail.
>
> - See functions.sh :: push_config() and pop_config() for an example of
>    saving the existing values rather than turning them all off at the end
>    of the test.
>
> - Nitpick: shellcheck suggests wrapping filenames in double quotations,
>    applicable in several places.
>
>> +
>> +if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
>> +	echo -e "FAIL\n\n"
>> +	die "livepatch kselftest(s) failed"
>> +fi
>> +
>> +grep -q $FUNCTION_NAME $TRACE_FILE
>> +FOUND=$?
>> +
>> +disable_lp $MOD_LIVEPATCH
>> +unload_lp $MOD_LIVEPATCH
>> +
>> +# Reset tracing
>> +echo "nop" > $SYSFS_DEBUG_DIR/tracing/current_tracer
>> +echo "" > $SYSFS_DEBUG_DIR/tracing/set_ftrace_filter
>> +echo "" > $TRACE_FILE
>> +
>> +if [ "$FOUND" -eq 1 ]; then
>> +	echo -e "FAIL\n\n"
>> +	die "livepatch kselftest(s) failed"
>> +fi
>> +
>> +
>>   exit 0
>>
>> ---
>> base-commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
>> change-id: 20250101-ftrace-selftest-livepatch-161fb77dbed8
>>
>> Best regards,
>> -- 
>> Filipe Xavier <felipeaggger@gmail.com>
>>
> Thanks,
> --
> Joe
>

