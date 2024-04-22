Return-Path: <linux-kselftest+bounces-8611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED858ACC38
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 13:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499861F2240A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 11:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66BE1465BE;
	Mon, 22 Apr 2024 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VpPbZLaw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2122714430B
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713786089; cv=none; b=R/xZSK6d83VuOaeG+CYSAVE82tRD0JECnr03tm2xcLcYZh21x2o6CXue+9TltfoANkMT6AkBr2SOMH9+S7eRQF2by2qMnfL7xEcxU2L5zroxEBujUWR+7vpHfRahVjSgVlYKIsOL5IQtlP4vHVEwGSyMviyIXwKuYMJoI0wyE38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713786089; c=relaxed/simple;
	bh=7KJ7vDaSx0rWHDQDkmEvrUR/MLLStUJAcboh4KtxB9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0RWUFv+WKP15PUxecD6PSW7OogyCBwLFZPHqNZIHCc0lqvYuiDyuje9owACKcVYoGGLAhkmw0hBUQcK0pIXzkLD34Tty21WDKKb5V0Tt1ULPdL6W22ve1ednLvUKGs/es+riz2J6zdpcPhfdNooim40xG5cQ5Z+MgW29gfvBg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VpPbZLaw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-347c6d6fc02so651861f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713786086; x=1714390886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGqDQHMjrZlO15Rvq0SOqA/APBPIM6ni8f7xyO7pFgU=;
        b=VpPbZLawUMlZNudFUcwqgbbVCA+9/pMgghQHKBrkUkE8sybZstKBydDy/pfM6SxepJ
         d+k2XT7Tn3xD14gDFnU9lGhVDRfOO+EV6tjQsI0y9nBL6RnYkmEfsTL3segsGTBecIR1
         udn7j9Rh94qThGRhqXETDDMrefqqyERUndHs2FrdnRD5QXUps4NZRcKBQySkySo3qZtq
         rG/s8OiwpJOtmjQQDDlHdnxQ4JDW9tlrJDMccDtvpfZO87r5ZL/b4lDqbMdIR/m69mMw
         pGBpvX1THj8hCT9tFnQ/rY5UQb7/Z8gpd9fCXmsBDh/o13mkKC+UqutoMP8nCkPG0HUG
         5jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713786086; x=1714390886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGqDQHMjrZlO15Rvq0SOqA/APBPIM6ni8f7xyO7pFgU=;
        b=LxptNmoz8OHPqNKWl2tvxdxtBihPCePGg8Y2MvafEEIF8FyUAfEjyWu2ZfXqeTTVcI
         zCGbU6hwHVgQgeOII9qghL9r2LGDXahRyoxqJud3B8hsFOrvDdXgrpC2ljOTpTmrDpr4
         FatvO3twkOITNlv7GfvqmqVW5Bho4ZlWf0j4+IJSS2NgOpRfpWX9MQHx3XteHS2Mq0mt
         1KbNAHlyPP7+ds0TD50S8sYL7cW8AzwPZ2lVj5esrL1dhNMnHIOK0vCA/jv5WJmZRrnB
         mxhXQa3G4nl1AH1wgUa2Cs0S4+MRURHtRDO8NL9gJ1CFILt8oARle8dRuqdxUGzN3tN+
         qqMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSp5Y1hgho1rnf2L+cxlhMGDj6O5aJsROfHCGPMBLnZ/f42JBQHpxqNwN3+2nexpIAY0Mzy0TIqFe5O2EibEK1j1J7e8/y/L2qinnKaghi
X-Gm-Message-State: AOJu0YxW4lUquZJXX4PqxeFwigYJCrTpBTygma2AxSGy0i9CDP9fZoJ6
	hhvgeQqrS8w1FH9zhGx1CWZUEfcpYtR+IkC0YowDjS1utngVbB/xBEyeircVMuI=
X-Google-Smtp-Source: AGHT+IHTzRl5EROPxdfWdXZvfgKbo2IebGI7y5OdOSFbmkZ4wmW+9Re1DyIi+sB900+gcrU8oHywLQ==
X-Received: by 2002:a05:600c:468f:b0:418:9941:ca28 with SMTP id p15-20020a05600c468f00b004189941ca28mr6743806wmo.2.1713786086657;
        Mon, 22 Apr 2024 04:41:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:9f43:3ca4:162c:d540? ([2a01:e0a:999:a3a0:9f43:3ca4:162c:d540])
        by smtp.gmail.com with ESMTPSA id m25-20020a05600c3b1900b0041816c3049csm16496334wms.11.2024.04.22.04.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 04:41:26 -0700 (PDT)
Message-ID: <7d06aaa0-cafc-4396-b5d9-8b64b6a1e643@rivosinc.com>
Date: Mon, 22 Apr 2024 13:41:25 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
 Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <20240418124300.1387978-1-cleger@rivosinc.com>
 <20240418124300.1387978-5-cleger@rivosinc.com>
 <20240419-clinic-amusing-d23b1b6d2af2@spud>
 <6ab9e591-f2f2-4267-8bdd-169ef0243e14@rivosinc.com>
 <20240422-daylight-sassy-ff3b0d867fef@wendy>
 <032530b8-a26e-494f-bd9c-3e1661add5d4@rivosinc.com>
 <20240422-matchbook-unlikable-59987a8d8b1f@wendy>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240422-matchbook-unlikable-59987a8d8b1f@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22/04/2024 13:36, Conor Dooley wrote:
> On Mon, Apr 22, 2024 at 01:14:26PM +0200, Clément Léger wrote:
>> On 22/04/2024 11:35, Conor Dooley wrote:
>>> On Mon, Apr 22, 2024 at 10:53:10AM +0200, Clément Léger wrote:
>>>> On 19/04/2024 17:51, Conor Dooley wrote:
>>>>> On Thu, Apr 18, 2024 at 02:42:27PM +0200, Clément Léger wrote:
>>>>>> The Zc* standard extension for code reduction introduces new extensions.
>>>>>> This patch adds support for Zca, Zcf, Zcd and Zcb. Zce, Zcmt and Zcmp
>>>>>> are left out of this patch since they are targeting microcontrollers/
>>>>>> embedded CPUs instead of application processors.
>>>>>>
>>>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>>>> ---
>>>>>>  arch/riscv/include/asm/hwcap.h | 4 ++++
>>>>>>  arch/riscv/kernel/cpufeature.c | 4 ++++
>>>>>>  2 files changed, 8 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>>>>>> index 543e3ea2da0e..b7551bad341b 100644
>>>>>> --- a/arch/riscv/include/asm/hwcap.h
>>>>>> +++ b/arch/riscv/include/asm/hwcap.h
>>>>>> @@ -82,6 +82,10 @@
>>>>>>  #define RISCV_ISA_EXT_ZACAS		73
>>>>>>  #define RISCV_ISA_EXT_XANDESPMU		74
>>>>>>  #define RISCV_ISA_EXT_ZIMOP		75
>>>>>> +#define RISCV_ISA_EXT_ZCA		76
>>>>>> +#define RISCV_ISA_EXT_ZCB		77
>>>>>> +#define RISCV_ISA_EXT_ZCD		78
>>>>>> +#define RISCV_ISA_EXT_ZCF		79
>>>>>>  
>>>>>>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>>>>>>  
>>>>>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>>>>>> index 115ba001f1bc..09dee071274d 100644
>>>>>> --- a/arch/riscv/kernel/cpufeature.c
>>>>>> +++ b/arch/riscv/kernel/cpufeature.c
>>>>>> @@ -261,6 +261,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>>>>>>  	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
>>>>>>  	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
>>>>>>  	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
>>>>>> +	__RISCV_ISA_EXT_DATA(zca, RISCV_ISA_EXT_ZCA),
>>>>>> +	__RISCV_ISA_EXT_DATA(zcb, RISCV_ISA_EXT_ZCB),
>>>>>> +	__RISCV_ISA_EXT_DATA(zcd, RISCV_ISA_EXT_ZCD),
>>>>>> +	__RISCV_ISA_EXT_DATA(zcf, RISCV_ISA_EXT_ZCF),
>>>>>>  	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
>>>>>>  	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
>>>>>>  	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
>>>>>
>>>>> Ye, this looks exactly like what I "feared".
>>>>
>>>> Ok but for instance, Qemu actually set Zc* based on C/F/D. So the ISA
>>>> string containing theses dependencies should actually also be allowed.
>>>> So should we simply ignore them in the ISA string and always do our own
>>>> "post-processing" based on C/F/D?
>>>
>>> I'm not familiar with the contents of all of these extensions, but I
>>> assume the reasoning for splitting them out is that you can implement
>>> them but not maybe not implement C (or something similar)? If that's the
>>> case, you cannot always imply.
>>
>> Yeah, they can be implemented independently so we need to be able to
>> parse them independently.
> 
>> However, the kernel currently requires C
> 
> No it doesn't!
> There's a Kconfig option that controls whether or not we build with
> compressed instructions.

Acked, missed that. That is then advocating to keep separate Zc* extensions.

> 
>> so we
>> should always have Zca/Zcf/Zcd. But if that changes in the future, then,
>> that won't be true anymore. Better keep it generic probably
> 

