Return-Path: <linux-kselftest+bounces-27087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE7DA3E054
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 17:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9135A16FBD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179491FDA94;
	Thu, 20 Feb 2025 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JThSDjfx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73853200B9F
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068293; cv=none; b=X5twFplejxdVL3OT/5yX7xqUg7KgAv3V4QYysNNnGRzRiL0HU3aHNIt8yZfzOvbQ/sAqHZS7V/E5liFLz0KsmZg7K7cAIx/UD5uPIrKs/XRZVDcf+v/eL2oftuzsWBq+YfxAUzcdmYwh/PLEJWlqxwmcpf0E+Q5hvK+PXBI+Ay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068293; c=relaxed/simple;
	bh=/dWabNOB3H/l45GLrHuFpQul4Awb4+rHqOfNRlYWSVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tqs6x3VSe4+RyAOtRqQLV+3wgyBEVr+w4+KWCUvfHgqf9wJGYlQv+l5NjdkbfCy/z/nfMimfHrITLUXBG9NbIiVpG5RqJM2SsQiGnnfNuyrVqEres8i84VGrZWM57KPubN5DnnP4MAKx/1pIbpqIX8yLUV58iCc1kH6mnASbZhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JThSDjfx; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-855d73856f3so11413739f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 08:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740068290; x=1740673090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XgyoPRXU6a6kG4N3+disEL2MEnPtdcZMZBxF77QaXes=;
        b=JThSDjfxYNINHmAnk9NMcxlPw/YGxJiLcxuatlHW2d8cem7g3uF7+VCOvam6wXu3jN
         V1nWqwwZZf8QksaJMEYHT4Jx7sX2A5wf+CfAkNyqi70iJ/HrF/2s8q3h1cqgrVZ8y9VU
         91w+O3ObA+uUPuGF7rlYnZDga3LacDjT+RWxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068290; x=1740673090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgyoPRXU6a6kG4N3+disEL2MEnPtdcZMZBxF77QaXes=;
        b=IsdhY6Lu9lS/n8SpKboKSUehSyx/eCxLmWQGBS7FLdfiyPAs95mB0nMcatIIlk+Ip3
         fNuG2vJS/2yvHGHh4SxG698S6Yaq76lMKszbt4lUgQMUfVFXZzOvA3xgMSrRO1CfzB2U
         UWHla5OMYpHD+cnWTULqckOoH4qHMHVCvv/X6LsVHoOhSgFXA8LfZa0GOfol3VXGXmET
         NBUYysm+SUs/6PfduzT2HHXDPKgHlsvacq4W6RCsCtq4Urb3ZWQr82LV2Nt+odAX+/Kg
         nA8HlG9lIr0iT7r82Se9vNi/95EsLhNFZRCebp+16dS9avjHn1TQSEds6+j0baxJPg7H
         dr6w==
X-Forwarded-Encrypted: i=1; AJvYcCUQtuUve2qVJiKKQPTiAR3Uye32BcokqhaTNpRYzn/7nNqjrpH9rPr4kCTXZAzJ2wIOQ6WERg2w9LMA44by7Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZtnxXE44Tzcd+W4IXsNzJOTRFeWaCsFFTawtRM1p9NSnUIASi
	f9UtYtFYOALV4ZzIbZyEZEXxHYQM00Kpc26o/w7l+FL6rfBEmc3EWs3jzplaBqM=
X-Gm-Gg: ASbGncthfqmWzUh27AHv2Xrlt5pofGuzRt4aQfdK1HnAXzLu59mXn2RdRXR8T0j5s7r
	t4KkaNRuJWsXSR9y4ISRuD/RzwBeDaVgxcjTawFFbb5Pfj3WV66vu3QyZq1PJOtPhwZYg8DCouW
	aV/8PXOTOX3ksmTIbwL3kehAHb1z5M7+BmbI0yGWA36BafUkNPC2s3M16BDDGZ7/JzJxPglRwtB
	3h6KYSiYi/m/W181hIfjbCfNfvACXl2a+HJtoBxZfOS2lVdgxDuBJ8464gbAIo8PvXI3R/G7BSe
	4gEgJRJZlVZXkVpuCi8Lmp6LQA==
X-Google-Smtp-Source: AGHT+IEJ7Oc5HsTMETSfAVR01i2ff6EJ8L0D+zb08Ob/9RlyCuyRRRxFupWsQAosXlRZJP1IxnAqqQ==
X-Received: by 2002:a05:6602:6c03:b0:855:bd9c:717a with SMTP id ca18e2360f4ac-855bd9c724cmr892782639f.4.1740068290492;
        Thu, 20 Feb 2025 08:18:10 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-855c0791a3esm56942139f.29.2025.02.20.08.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:18:09 -0800 (PST)
Message-ID: <3ae6c7de-fb0a-4c65-afca-c0c91289650b@linuxfoundation.org>
Date: Thu, 20 Feb 2025 09:18:09 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/tracing: Test only toplevel README file not the
 instances
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250115191758.35b62738@gandalf.local.home>
 <20250115202607.00c6d353@gandalf.local.home>
 <571133ce-b4ae-4a9f-8601-443774804d1e@linuxfoundation.org>
 <20250123172530.474e873f@gandalf.local.home>
 <d39de60f-c87f-4c59-9226-9080f9008f3e@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <d39de60f-c87f-4c59-9226-9080f9008f3e@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/25 16:54, Shuah Khan wrote:
> On 1/23/25 15:25, Steven Rostedt wrote:
>> On Thu, 23 Jan 2025 14:56:55 -0700
>> Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>>>>
>>>> Damn, I forgot to add Shuah and kselftests mailing list to that one though :-p
>>>
>>> Do I need to do anything or is this taken care of?
>>
>> I think you can take that series. If you want I can resend with you and the
>> mailing list Cc'd.
>>
> 
> Yes please resend.
> 

Steve, did you resend the series?

thanks,
-- Shuah

