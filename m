Return-Path: <linux-kselftest+bounces-18357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1542986384
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 17:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575E91F26E85
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B8217BEAB;
	Wed, 25 Sep 2024 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cmTBwm4Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F59B172BAE
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277646; cv=none; b=AucV3QTEJGfZlZGHKSuK6rpjIDdTPtL+6lf0+1/n/+Qn8di7nav5O+fTnLcP8591LsJpNppmEIq1b6J3pREtzJ7Q2OvlqrcuoAkPhuOefdTEto96hdqr1Y+4uWfHHdu/hz/Lwn49xfGXnxPLUry8Cs35SOshhjNLNRSkGElINd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277646; c=relaxed/simple;
	bh=XaGEPxm13ZPyb7M9Q1SxZsnROr0WKNhOw8TakKeNanc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HstpMmd/ULLGa6bkkCyVTgcWOdmoUPFdI2zonFTvwJ4YnBOZKTzmj2RtSKl5BHn+bmxzCe+ZNGkeR0P+WD6UsVQO8TyTNfA2BxTDdQ9dhgiKbpdk2TNV90lprrZc4LsLFsbIR1iEI3GaGBQS7zCI7GcKg4g1kk/V4Ud14iNEIso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cmTBwm4Q; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a08c5a2bddso32391635ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 08:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727277643; x=1727882443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85DZ/vgxOYbmSudD4vwdiq4BSHmbhOCjGRMKG9Chzlc=;
        b=cmTBwm4QjYC0OpsBiWzmKtOGMeY5dZCrNEyHslDjeG9Tf0UTxuGfh9JhjnUKA4dYJa
         JI07+hv7IbGj9fG8LNGy8CGcWEn/sAPdprchPd5BP+gN/yoS2FceMaRfAfSuz51b8BGJ
         7OyO882acxdmZywihWyz8zS+qmrvKzel3hVGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727277643; x=1727882443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85DZ/vgxOYbmSudD4vwdiq4BSHmbhOCjGRMKG9Chzlc=;
        b=PL7yD2hRd0UOGKaihVFrUrQgctPTPm7FtNKagx21/G75F6gO+ySHhQgIX6LfA+LwDW
         ROkPnE3p1Wd7tbqzZ3/bgf0RbT3KvCsNg69KL2g3Qfjz3As4rMyiZxaa4xc9lLSopwGr
         23yH4Q3xPQHKcRhkJQ/6dUDRMQe5Ojnqhc3SZ3Ynv75Ja4BKO/+uxVTRG2wobhiQSyeF
         DRHzGYQrTeXQo4huzcbdDb1iT+9zhFPBUnBkPxYIAIt9rR2KW11VkcZkehCyl1B4Iukv
         UIjBh1PR4Afdw6EXfZzXKWwcIPCD77BzqEXRSH/Oxmq2txIFmyBmuckr9sVfkHyuEhEX
         xEKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTFTjbAecxxW3Aez26kPhEFma3/mcfhZBygUPFvgJaDDeB+Byn/LhqCIUzkhBrlT9pvZwVprSjEOsGLsx072w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCWaW3aQU7Yqj4mFw1YioAov4qql01q0xb9oAums6aRvF6D8V
	U4RbNpHCyMOjqNI397tCG/N8ZZC6I7eAP7m7bCgwPrQbwcly0SEEP27pYQjWhNY=
X-Google-Smtp-Source: AGHT+IFI7DFenmcYY8kh9TfP8aJOyHdE3yc7uSvC+foon1IBV/U2ir7CEi9In42oU480kpPYgX+Sgw==
X-Received: by 2002:a05:6e02:164d:b0:3a0:9ec4:92b6 with SMTP id e9e14a558f8ab-3a26d78ef1bmr31918605ab.15.1727277642685;
        Wed, 25 Sep 2024 08:20:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a1a56daabasm11293495ab.39.2024.09.25.08.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 08:20:42 -0700 (PDT)
Message-ID: <b0647b67-5cba-4e42-9d42-d12ba2aa2174@linuxfoundation.org>
Date: Wed, 25 Sep 2024 09:20:41 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: timers: Remove local NSEC_PER_SEC and
 USEC_PER_SEC defines
To: John Stultz <jstultz@google.com>
Cc: tglx@linutronix.de, sboyd@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1727191485.git.skhan@linuxfoundation.org>
 <f797bc704d8eb03234a3447c77fa7b704339f89a.1727191485.git.skhan@linuxfoundation.org>
 <CANDhNCpsEQL+S8gadXMjvbE-6r8c6owzz+_DhN6JAVqQ8Hg=_g@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANDhNCpsEQL+S8gadXMjvbE-6r8c6owzz+_DhN6JAVqQ8Hg=_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/24 17:59, John Stultz wrote:
> On Tue, Sep 24, 2024 at 8:57 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> Remove local NSEC_PER_SEC and USEC_PER_SEC defines. Pick them up from
>> include/vdso/time64.h. This requires -I $(top_srcdir) to the timers
>> Makefile to include the include/vdso/time64.h.
>>
>> posix_timers test names the defines NSECS_PER_SEC and USECS_PER_SEC.
>> Include the include/vdso/time64.h and change NSECS_PER_SEC and
>> USECS_PER_SEC references to NSEC_PER_SEC and USEC_PER_SEC respectively.
> 
> Nit: You got the last bit switched there. This patch changes local
> NSEC_PER_SEC to the upstream defined NSECS_PER_SEC.

I think what IO have is correct. posix_timers defines them as NSECS_PER_SEC
and USECS_PER_SEC and the header file doesn't have the extra S. It could
use rephrasing thought to make it clear.

Is it okay to fix this when I apply the patch or would you like me to send v2?

> 
> Overall no objection from me. I've always pushed to have the tests be
> mostly self-contained so they can be built outside of the kernel
> source, but at this point the current kselftest.h dependencies means
> it already takes some work, so this isn't introducing an undue
> hardship.
> 

Yes. At this point it would be hard to build it outside. DO you think
these defines can be part of uapi?
  
> Other then the nit,
>    Acked-by: John Stultz <jstultz@google.com>
> 
>> diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/selftests/timers/adjtick.c
>> index 205b76a4abb4..cb9a30f54662 100644
>> --- a/tools/testing/selftests/timers/adjtick.c
>> +++ b/tools/testing/selftests/timers/adjtick.c
>> @@ -22,14 +22,12 @@
>>   #include <sys/time.h>
>>   #include <sys/timex.h>
>>   #include <time.h>
>> +#include <include/vdso/time64.h>
>>
>>   #include "../kselftest.h"
>>
>>   #define CLOCK_MONOTONIC_RAW    4
> 
> I suspect CLOCK_MONOTONIC_RAW (and the other clockid definitions)
> could be similarly removed here as well in a future patch?

Yes. It could be cleaned up. I will send a patch in for this.

thanks,
-- Shuah

