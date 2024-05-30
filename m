Return-Path: <linux-kselftest+bounces-10905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7A88D46CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 10:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311641C2142C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 08:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC2A14A62A;
	Thu, 30 May 2024 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jrGn5udO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615214C5B3
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056765; cv=none; b=Tr2Rax3P6qGZ3SoeDaAGn695At2nhyXVgARcVatVbCpPJJU3a7RjWNrqMlUtMC8LoVhaGLWfCqAyWXL9B57x1TzeAP5ylpR/bYejthLcXDDSkSkABGW2DIVK+O76BdyDvA07v2lGoHoZ0FMYwQm5Jwxq23Jha4Zfc+jusPVgMQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056765; c=relaxed/simple;
	bh=mwYATlGqSRRpITnG8BIh7RCuTwAeiIWonLTkywmLt9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODiEahOVqESy7MBMz3g7WNqUPMKnpkvwqMny+w8X8lWSSk/eOkYF8wSESzRGptG1Np1uwjoHdLbJNVO9tQgqc/JHjNMfKL2fIVZl/1F5mJvYUdRX6j8tairAlH8dBs0/tXiH8Q5KbTfL9D8KYeQgKTUV2zeuwNnlVN5epo+80oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jrGn5udO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5295f2f6ba2so33115e87.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717056762; x=1717661562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0RoFCn1cKvd1zoXQP5ZuJdh9HnrCwhzMajErjx8js2Q=;
        b=jrGn5udOweDMzlyebgYMx5PKm98he5FC/bTVeFYtsgyL+SaQCkL6TIWKSd2Q8/if6T
         bWG4M8OADBdjA1z2e56hNf81cCRwrtpJi+ZKXgUpv+sj4psmxkZsI60HUXQw+1A/qnAv
         WpzSUOyUsYQZBW9luY2gwVOJIXm0ZJsiDqSzXMrBBbnzGOoFVFJkY7J3blQp0ffdd39i
         eguFyN3R6XdU7P1UC1U1xGEJ5QursoDqQDZ8PmQbge1AvDeEP5wfv26O2i+uZhAo5Fyo
         p8rvE7gsQjk5el9aUTLffp5IY0XxijSa7zzqdeDeFGirHHci69yIHawoA+UUcXK43QOa
         I3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717056762; x=1717661562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RoFCn1cKvd1zoXQP5ZuJdh9HnrCwhzMajErjx8js2Q=;
        b=L+eHNRHHN7bQr/5vxdaIb+M2n5zUVGoQDaAd0t8AvWlVr2rxoh9EmDwIHZsVaJwBqP
         FYai+4o/dEULhK93/FrBcnyxlWNxu/GGh8wubUbiCIthWkfmF/VEl3ndAqMvTHxIXytC
         2uUgeMM644Xg+J32cs3GdhA6akJIlTnGKw1W74ArrDqmUkVpJRUvVXmUzsraRZv6PC3J
         O43b+6/SVQs6iT7YoQ3fLE+VxN2X7ggtG+b/I1OzxcPBWOJB9xDSmCK7K0ZEWEg9cUrc
         ViJum/BK3cTjq17z9wUaB/LN5wpqPGEFnkiE77sZnGNlRhY5FP3gYKbL8SMJaqzMJKmw
         5vhw==
X-Forwarded-Encrypted: i=1; AJvYcCUC/r8lU7e/KswLe3CMEIscxm7rempJPsL5uX9i+Z+MQ4kM5KvRqRSfz/cDW4JhZbmf3zjpw3O9IS5vHg1y/MTtjdlQrxxHYgFYuhJ2wCEu
X-Gm-Message-State: AOJu0YwII8PyE7PdHlIU4i9zqsqmjOCPCccRfOgzrHUHe4q5+lfrZmf9
	mfODVxsJ2rZHdu4Cy/8Cw/FzZEDFzus8U7ag7XKkdas8KjTgBIoSx4S4GhxjNmg=
X-Google-Smtp-Source: AGHT+IFDH/BtR0IqfU1MMNNRmaYz2QjK/JKuYYRlqhpvwnINHfFSvpEeQs/Qm8e5sz1sHPGcXd9sFQ==
X-Received: by 2002:a05:6512:1111:b0:51f:1bf8:3ea9 with SMTP id 2adb3069b0e04-52b7d49951fmr1181406e87.3.1717056761685;
        Thu, 30 May 2024 01:12:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:a3c2:7707:741:7c5c? ([2a01:e0a:999:a3a0:a3c2:7707:741:7c5c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42126fea343sm17505945e9.0.2024.05.30.01.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 01:12:41 -0700 (PDT)
Message-ID: <4d23f17e-cc1e-45e3-9ca2-a884baacf207@rivosinc.com>
Date: Thu, 30 May 2024 10:12:39 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/16] riscv: add ISA extension parsing for Zimop
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
 Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <20240517145302.971019-1-cleger@rivosinc.com>
 <20240517145302.971019-3-cleger@rivosinc.com> <ZlenZ+NvXxOxvqEO@ghost>
 <ZleqVUhDW+xgiTwu@ghost>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <ZleqVUhDW+xgiTwu@ghost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/05/2024 00:21, Charlie Jenkins wrote:
> On Wed, May 29, 2024 at 03:08:39PM -0700, Charlie Jenkins wrote:
>> On Fri, May 17, 2024 at 04:52:42PM +0200, Clément Léger wrote:
>>> Add parsing for Zimop ISA extension which was ratified in commit
>>> 58220614a5f of the riscv-isa-manual.
>>>
>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>> ---
>>>  arch/riscv/include/asm/hwcap.h | 1 +
>>>  arch/riscv/kernel/cpufeature.c | 1 +
>>>  2 files changed, 2 insertions(+)
>>>
>>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>>> index 1f2d2599c655..b1896dade74c 100644
>>> --- a/arch/riscv/include/asm/hwcap.h
>>> +++ b/arch/riscv/include/asm/hwcap.h
>>> @@ -80,6 +80,7 @@
>>>  #define RISCV_ISA_EXT_ZFA		71
>>>  #define RISCV_ISA_EXT_ZTSO		72
>>>  #define RISCV_ISA_EXT_ZACAS		73
>>> +#define RISCV_ISA_EXT_ZIMOP		74
>>
>> Since my changes for removing xandespmu haven't landed here yet I think
>> you should keep RISCV_ISA_EXT_XANDESPMU in the diff here and make
>> RISCV_ISA_EXT_ZIMOP have a key of 75. Palmer can probably resolve the
>> conflicting keys when these two series are merged.
>>
>> - Charlie
> 
> I missed that other patches in this series were based off my
> xtheadvector changes. It's not in the cover letter that there is a
> dependency though. What do you need from that series for this series to
> work?

Hey Charlie, I'm not based directly on any of your series, but on
riscv/for-next which probably already contains your patches.

Clément

> 
> - Charlie
> 
>>
>>>  
>>>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>>>  
>>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>>> index 2993318b8ea2..41f8ae22e7a0 100644
>>> --- a/arch/riscv/kernel/cpufeature.c
>>> +++ b/arch/riscv/kernel/cpufeature.c
>>> @@ -241,6 +241,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>>>  	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
>>>  	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>>>  	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
>>> +	__RISCV_ISA_EXT_DATA(zimop, RISCV_ISA_EXT_ZIMOP),
>>>  	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
>>>  	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
>>>  	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
>>> -- 
>>> 2.43.0
>>>
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>

