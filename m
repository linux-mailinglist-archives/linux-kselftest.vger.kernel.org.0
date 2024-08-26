Return-Path: <linux-kselftest+bounces-16280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5D695F350
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 15:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A99B20AD2
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 13:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5731865F8;
	Mon, 26 Aug 2024 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HUReV4MW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49E93D71
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680411; cv=none; b=GSK+ZOI+X0tobTQQPrsoRaRk3SRbQ6Am8MV/whuPJDUen8tfgiVHFes2eKiobVd54+/0uvk8/kpmYjTpdpZraW58F1wN6T3Xvoxrx5olvM921ZYKNavRnvNyn6ZV+KP7hYoQm2kH0gBUkDOdpQFg/zq3G3hUDU1OHVC+OqTJisU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680411; c=relaxed/simple;
	bh=Unqx8jmeFdF1VI5QOpi4woYBB3HElD7uCXnAKWY7p3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqwP4DlB6ry+UOJUS/8L/fxOO/Hk/NJmmEeoAci48d1KZ4UqfDt7KUdoI4X9Ov1ZN173N1V3mWFqovmagMqRcGE+cw+KblgUxrL7uZXJmxXnN6by++joc/p96SuwTrGettFhRKCEsIn6G7A8GtCp/G5murmuYU2G/VWVa3ZQ79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HUReV4MW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201ee6b084bso35916165ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724680409; x=1725285209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Q9PuXmg221v4n3ZTHASMPKovmaAn+KWVQTnJOgnGGc=;
        b=HUReV4MWCmsCMNZbMEcp9XXMs8oxkpkgHLci9RZGSOUbBd5DCsV3uroinBPRJ1W8Qw
         X7+4pBxnHmPsn49Nl9ho1YxA+F/N3IDHZrw2coQNdAmYzLeH3Y89n4ZFFqaaDoz1a6bL
         m7cC5hxnz8+nYIQKGy4Z9WHjNpEioiULU2r0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680409; x=1725285209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Q9PuXmg221v4n3ZTHASMPKovmaAn+KWVQTnJOgnGGc=;
        b=eDTpWO5JUmNABadfW2M7dznNVRv0J5kVYIHWam+gRCM0Lbu+J4pNYxKDCseoM1IWtS
         UhNK/keKigJNdwFvCbdOYlVRWzi1SpHmINkjFVwk++uyz9bwngR7UJuIk+RM3li2Toly
         3snPqv80mZVSQieSkp3kh9Q/B8jPrjReqEyxnXqqnj/WVs9r1l1OSDfRzyqQAYiAhN4i
         b50vONQK6PuTNOyj/XTkHfsnCszh/sqAzJ9QaMMNI5Ije2KT/I7qqyKbmckDTYBV/5co
         laZJWU7Ih7EP7R5UvrIlB4oQCsS4q/5trY5KPlUAGfC630Vv7s/nJikfkTJ0PlAOUKG9
         dIHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbk9GwN2P+FLymLlIK29pZY8NUeT5aPE/JpCyF7PBav0AIvqyp9uaOKsPUzZCCoQpN9KTe2R+6ZS04bd0rzlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoyDxamDIVFdQCgkRc0O4YlHIbPT8ElDHJttacz2X/iLyRlBhn
	pbaaTqg+cE0Q0w3+7vfZgou0td0Vvyw8B+mmMglEoBdqjTxjDXqDbfXG8fQXzP0=
X-Google-Smtp-Source: AGHT+IHPm3yVwNwle/7bH3vLcBP8lhcS/vg7K/OhSlZ4Tf+Gfj75dqkDPda3S/tSNa+iUkm9JiM9Hg==
X-Received: by 2002:a17:902:e5cd:b0:1fd:876b:2a5c with SMTP id d9443c01a7336-2039e56ad74mr124917195ad.65.1724680408762;
        Mon, 26 Aug 2024 06:53:28 -0700 (PDT)
Received: from [192.168.121.153] ([218.49.71.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560faddsm67820495ad.231.2024.08.26.06.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 06:53:28 -0700 (PDT)
Message-ID: <32d722e4-7c0d-414e-b94b-8c40e0be0302@linuxfoundation.org>
Date: Mon, 26 Aug 2024 07:53:22 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ftrace/selftest: Test combination of function_graph
 tracer and function profiler
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240821150903.05c6cf96@gandalf.local.home>
 <3901c521-be69-4824-a571-9182b9af02b6@linuxfoundation.org>
 <20240822091929.0db8837f@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240822091929.0db8837f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 07:19, Steven Rostedt wrote:
> On Wed, 21 Aug 2024 21:54:42 -0600
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 8/21/24 13:09, Steven Rostedt wrote:
>>> From: Steven Rostedt <rostedt@goodmis.org>
>>>
>>> Masami reported a bug when running function graph tracing then the
>>> function profiler. The following commands would cause a kernel crash:
>>>
>>>     # cd /sys/kernel/tracing/
>>>     # echo function_graph > current_tracer
>>>     # echo 1 > function_profile_enabled
>>>
>>> In that order. Create a test to test this two to make sure this does not
>>> come back as a regression.
>>>
>>> Link: https://lore.kernel.org/172398528350.293426.8347220120333730248.stgit@devnote2
>>>
>>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>> ---
>>>    .../ftrace/test.d/ftrace/fgraph-profiler.tc   | 30 +++++++++++++++++++
>>>    1 file changed, 30 insertions(+)
>>>    create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
>>>
>>> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
>>> new file mode 100644
>>> index 000000000000..62d44a1395da
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
>>> @@ -0,0 +1,30 @@
>>> +#!/bin/sh
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# description: ftrace - function profiler with function graph tracing
>>> +# requires: function_profile_enabled set_ftrace_filter function_graph:tracer
>>> +
>>> +# The function graph tracer can now be run along side of the function
>>> +# profiler. But there was a bug that caused the combination of the two
>>> +# to crash. It also required the function graph tracer to be started
>>> +# first.
>>> +#
>>> +# This test triggers that bug
>>> +#
>>> +# We need function_graph and profiling to to run this test
>>> +
>>> +fail() { # mesg
>>> +    echo $1
>>> +    exit_fail
>>> +}
>>> +
>>> +echo "Enabling function graph tracer:"
>>> +echo function_graph > current_tracer
>>> +echo "enable profiler"
>>> +
>>> +# Older kernels do not allow function_profile to be enabled with
>>> +# function graph tracer. If the below fails, mark it as unsupported
>>> +echo 1 > function_profile_enabled || exit_unsupported
>>> +
>>> +sleep 1
>>
>> Any specific reason for this sleep 1 - can you add a comment on top?
> 
> We add sleep 1 in several locations of the ftrace selftests to let the
> tracing run for a bit just to see if it triggers anything. Otherwise the
> clean up can happen before anything gets traced. Although, it's highly
> unlikely in this case, but still.
> 
> I could add a comment if you want of just:
> 
> # let it run for a bit
> sleep 1
> 
> 
>>> +
>>> +exit 0
>>
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>> Let me know if you would like v2 for this to be taken through my tree.
> 
> I'll make a v2 if you want me to.

No need for a v2

thanks,
-- Shuah


