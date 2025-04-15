Return-Path: <linux-kselftest+bounces-30913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B722FA8ABC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 01:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D951903252
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 23:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4568A2D8DA0;
	Tue, 15 Apr 2025 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cRKAMnZB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E643029CB32
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758231; cv=none; b=gKcPlRkoTTjtyOKo4kuXehKd0nq+S5JA9n+ccKWLu1Pl59Jtv7a68D82wOET4aJkWwFyLEt+fQkVxZ0cahE6Y3UTb3ntVR97Bzc9tJvC4qyQtcqKMguAd4TM398o9cyW+omqNxy8+JX3lb6h42vyE2a/eimExO5Ox1CTICmKRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758231; c=relaxed/simple;
	bh=RkQLs8plGTuvUlQpD4z6Bt6uSx+18zdXjv8PJk5Ra00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBEwnE2BY+1qszBGaoI/tz5mLn6ptMtCHPHExwFVTaU/XFdYbQBJzlChaxGonBbSpowA/JAA3FIX2cSO1aw9k4SvvcY613JQGv/KOyYGVzfSTqdwhN1qd60n120iULyaZ+edDydmkb4ry0vD/7/7JP0yHUy6u6gJrgWnnlD7LC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cRKAMnZB; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-86142446f3fso142009139f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 16:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744758226; x=1745363026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLtzUoinmCTRg/YY7Wr14vwtUY7ngISrrQXhsgabO6k=;
        b=cRKAMnZBVb8qewGk7FE1Js2xVVRJ3Joi4ubRFyqavZXh2NdxfVGBsCK4K3pKPRd5mC
         +5xUutzyKw/EREwftsY8NMy0JhVruOmUbnb5oWRt7paKa2qzJy616amh7jVODxzUDSzH
         UWcUFkwJsAevFs2UTunHHtQG785als8tmtDoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744758226; x=1745363026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLtzUoinmCTRg/YY7Wr14vwtUY7ngISrrQXhsgabO6k=;
        b=Qag31HdAJV1AMtBNMqiQHQ8WM0IuR3iCFbT0L+e+wtmGJQkJC5auwvoYE60yc2YOtW
         1hQJcbOtCF/SDR05n98gHcXEnHnMRp3TpCNMDAG6G5d2PiT8J8H7w4oRdH38yrtrC6L8
         IhLCC5ilE2bLCo7yEYYhQDYoImJM8j7ALhlFiWfYHBLr7h+NDeuImJqjzF7cX3dA9Jnh
         XFKh/SG3S9NMw7tkYl0XU18cRgVNlhsNSj+xOu8PizxB5ViCWRENMyjyQ5gbxKJDN1dV
         awUb8NC4MP5cVOM4YtUOVd7GbRJsXNrnelMaHtYbN11toXWiGH2I2qFfry4v4bf/U5aV
         euzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnd9nu4LO4p3ea3LeH7JjnAcbPNiGCuOP0Mpu5q9KsAgQ+3IngYmNLOzEGLGeTaoeQMISesR3vCHn5AYdEOxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd0PnMVglzfIvmedUx0WwZSCWVIWSUi7kYVubLbppobyvBP+WR
	151dqoG6U6FjKo9H3YYh84IYmeIyqFhIZ3IREYaeZQsG1tCwGPLzlFZ9h4qTVmw=
X-Gm-Gg: ASbGncvWUhyqSfYp2FOVZ8K0DiUTPoBeAcn8mQmNjY+A8qN7WNXD2tC/hBCX5D6CePL
	/wkJABsbSupsDqAfp0hKYYInMhbj5QyvETQmaEcy90+mZkpNwB0+RVuem5BcJO1y/MrUg+34amd
	ph8aoDWJaZjfHT/ZQHVX+r/bEmvQJh/8k/mS2dVktM5DzrIB6H7wI0JUQj2lQbu5+4CLLq++2Bj
	Vv1LL+RMfip6hkyTGPJEw6hmXRlSAkb6x2QK3gvQZ4T6X95SjXGRiSWoofex8/ksv28+VNEod6N
	OiMbrKGIF169K6oBgf4QTNKi6RXOnzKwqHXSR2kuvqBdC0kKpCg=
X-Google-Smtp-Source: AGHT+IEaQK9ACTBp4v/WNl75tUwR4darm0GTMobrZuIgjTZw8Z0T7gU4A8rMAO1vHodWxi9Nxm1a/w==
X-Received: by 2002:a05:6602:3789:b0:85b:41cc:f709 with SMTP id ca18e2360f4ac-861bfcfa944mr162858439f.14.1744758225819;
        Tue, 15 Apr 2025 16:03:45 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8616522c958sm271806039f.6.2025.04.15.16.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 16:03:45 -0700 (PDT)
Message-ID: <658670d0-086b-49e9-85ac-3e002fa8322b@linuxfoundation.org>
Date: Tue, 15 Apr 2025 17:03:44 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Differentiate bash and dash in
 dynevent_limitations.tc
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250414210900.4de5e8b9@gandalf.local.home>
 <20250416075832.cd27bcb52b7e31d0f5717273@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250416075832.cd27bcb52b7e31d0f5717273@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/25 16:58, Masami Hiramatsu (Google) wrote:
> On Mon, 14 Apr 2025 21:09:00 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: Steven Rostedt <rostedt@goodmis.org>
>>
>> bash and dash evaluate variables differently.
>> dash will evaluate '\\' every time it is read whereas bash does not.
>>
>>    TEST_STRING="$TEST_STRING \\$i"
>>    echo $TEST_STRING
>>
>> With i=123
>> On bash, that will print "\123"
>> but on dash, that will print the escape sequence of \123 as the \ will be
>> interpreted again in the echo.
>>
>> The dynevent_limitations.tc test created a very large list of arguments to
>> test the maximum number of arguments to pass to the dynamic events file.
>> It had a loop of:
>>
>>     TEST_STRING=$1
>>     # Acceptable
>>     for i in `seq 1 $MAX_ARGS`; do
>>       TEST_STRING="$TEST_STRING \\$i"
>>     done
>>     echo "$TEST_STRING" >> dynamic_events
>>
>> This worked fine on bash, but when run on dash it failed.
>>
>> This was due to dash interpreting the "\\$i" twice. Once when it was
>> assigned to TEST_STRING and a second time with the echo $TEST_STRING.
>>
>> bash does not process the backslash more than the first time.
>>
>> To solve this, assign a double backslash to a variable "bs" and then echo
>> it to "ts". If "ts" changes, it is dash, if not, it is bash. Then update
>> "bs" accordingly, and use that to assign TEST_STRING.
>>
>> Now this could possibly just check if "$BASH" is defined or not, but this
>> is testing if the issue exists and not just which shell is being used.
>>
> 
> Thanks for fixing this issue!
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Steve, do you want me to pick this up for rc3?

thanks,
-- Shuah

