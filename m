Return-Path: <linux-kselftest+bounces-33675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BFBAC2A60
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 21:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72A49E0745
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 19:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDFA1D130E;
	Fri, 23 May 2025 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cE8JETa/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34681A9B32
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028126; cv=none; b=eV71E6hBXBEmytFTICs/QM8gy2j0o3bMg92IaOVGJ19OHKK5yIpk+MkiS0O5mL9FYCg7wG7o/5dEz5rwMUYDNpqreZAwKBPStrzNi9Iy39SflYSho1zldsr++RD/P8y2NrtqDPJRpnN5LHxAKLLMfRCcerBDKZpgGIXNaNY+ySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028126; c=relaxed/simple;
	bh=QTgsq+8ZSYotM2YZLiiLRhq0j7JWuLmmzU6tbY7ZKFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQc1Bh/jYnrNV8+M81DgaQvGlPhA0d9kr+CosmaPXBzbDEh6+lO1xN6eCfGl7wplPSDl/sfMKSOsyN9i9j6PdPQwJXNjhufE6CbVGf39BcHkx6lUxgAQS7oBNQqxEtY/w542qk7jnTfiAPpNsoUjg9dJXGVteGCvhBP0CaLA4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cE8JETa/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7398d65476eso223519b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 12:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1748028123; x=1748632923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ral+N2d0KfCW37vBolJovFgnCe0tWP7reKx7tiu0DfE=;
        b=cE8JETa/oOGBqW0x9SvgpyUmskZh1q7/pZkOozdng89F5CqAU0gpMM0ZIsko11MFDl
         GQpX5f+z47jJllsE22FaQmoulPgEwqrRvHkQxNrVuS8huyrmowpv2S11zk6KsRpRJoTh
         215wcU0Uyz8CrsJM1grlvO/scEM2W0FJN6YQplJX9nawK2FzH9otqaLmpRM414sOWQLR
         x+CI+QxQokpK8VEE5RPpWLDm/cQv/5uqDPP/zzGu5mXZWeKr+hOv82A29IvQO0L0uFd1
         SwD7ANJ8U+3xzyU7m+dYS9ZBkCDCDhcfeI6WGwgvScLyMFs930ERMPwSErxqOwFK9FS1
         +LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748028123; x=1748632923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ral+N2d0KfCW37vBolJovFgnCe0tWP7reKx7tiu0DfE=;
        b=Xim0b42FP8e2zPLMlZ6y9Xw5CCekFw7DyarNvLu1MfcZ96NzKT9ObOYh+bOdnP+rfz
         DioD8uq+o85jvtBMTWXzi7CzQi4rqr/U/RgsiIu5QWP/8jjSr/MrCLZmiLsGRQg5J0qy
         S3l0zZDRAXWpjgGlrX1IdIBF+RiusIIDP33bBcC3AC5Ficiwe0u6sTI5U7FVYR+RygYF
         mlKxnWCt7IEhs1f3Q7hfjcnWuPZ0faYHfx9kDddiPEtRt1stG/KnFfVz9KVXuDqc1vC4
         czJL1z0aM1AgzjCPFsEetbvPIcAlAvb4ovicjppcv2cxHQr1+ETZR/bD272fyZFnqdZt
         5L2w==
X-Forwarded-Encrypted: i=1; AJvYcCX70ODcKd8LKtfSdaWg4hGPAp44nDea3U85JjnELFfoS+Mciz3Oe7zde4B1lquBFMw5Ub5vrlDEjuwOy1nXLOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAU+Aowjhl9we6uiD/r6Nngv39qo1emXoTZHX+suETDB3zaj5O
	KQW+XcH6+YiLLP/Cf066bRCqCV9GFPfNJ51jv4dimmg8UQEuPegFT8wLJVuDxvAyWoU=
X-Gm-Gg: ASbGncuKRwv8/wd5O7jDI2I1dFLpCCf8F7dEcWm4zHTyzCn5a1tcDA/COXj+SK84v4I
	DWkhXKzedBnKLsTuVS6/ey/E5TENsGIglm1iZujdplI2V6WJu5GG84wS5TnQt3OpTbBOBjvukBr
	CEPHXgzLdLWxkY0KlEHTwJyPfyg9FSQ3eNJFBv00iyUe87919i1QH/LOQaPDpc7kP5JJNEKR7FB
	mOFxMY89tc72OfrxUAAJT+6ABbf6mvHHnZ60B/hehFOkz37u9zFiFbyJ0NDbIEyupC6/ySal2/z
	2M/Sn4Ayqy8R6uLMyEmyXbIrZyQMfi0uj+QCpBsW7P4htfqW2woX/MWTAb+JH3jLYCG0nDHXd56
	nbRP2at9IVrof6LcZ6OBs
X-Google-Smtp-Source: AGHT+IFZ/6OL3e/+nBzCYIYloiMUYM//2VK/chpXTyoMI+nuh1v5hqPREUkHkrHrx1lhvJEatv4h8w==
X-Received: by 2002:a05:6a00:391e:b0:742:ae7e:7da1 with SMTP id d2e1a72fcca58-745fdb50dfamr1094649b3a.0.1748028123175;
        Fri, 23 May 2025 12:22:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98770cdsm13178352b3a.151.2025.05.23.12.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 12:22:02 -0700 (PDT)
Message-ID: <b2afb9c7-a3d2-4bf6-bfaa-d804358ccd88@rivosinc.com>
Date: Fri, 23 May 2025 21:21:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/14] riscv: misaligned: move emulated access
 uniformity check in a function
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>, Deepak Gupta <debug@rivosinc.com>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
 <20250523101932.1594077-10-cleger@rivosinc.com> <aDC-0qe5STR7ow4m@ghost>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <aDC-0qe5STR7ow4m@ghost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23/05/2025 20:30, Charlie Jenkins wrote:
> On Fri, May 23, 2025 at 12:19:26PM +0200, Clément Léger wrote:
>> Split the code that check for the uniformity of misaligned accesses
>> performance on all cpus from check_unaligned_access_emulated_all_cpus()
>> to its own function which will be used for delegation check. No
>> functional changes intended.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> ---
>>  arch/riscv/kernel/traps_misaligned.c | 20 ++++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
>> index f1b2af515592..7ecaa8103fe7 100644
>> --- a/arch/riscv/kernel/traps_misaligned.c
>> +++ b/arch/riscv/kernel/traps_misaligned.c
>> @@ -645,6 +645,18 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
>>  }
>>  #endif
>>  
>> +static bool all_cpus_unaligned_scalar_access_emulated(void)
>> +{
>> +	int cpu;
>> +
>> +	for_each_online_cpu(cpu)
>> +		if (per_cpu(misaligned_access_speed, cpu) !=
>> +		    RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
>> +			return false;
>> +
>> +	return true;
>> +}
> 
> This ends up wasting time when !CONFIG_RISCV_SCALAR_MISALIGNED since it
> will always return false in that case. Maybe there is a way to simplify
> the ifdefs and still have performant code, but I don't think this is a
> big enough problem to prevent this patch from merging.

Yeah I though of that as well but the amount of call to this function is
probably well below 10 times so I guess it does not really matters in
that case to justify yet another ifdef ?

> 
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> Tested-by: Charlie Jenkins <charlie@rivosinc.com>

Thanks,

Clément

> 
>> +
>>  #ifdef CONFIG_RISCV_SCALAR_MISALIGNED
>>  
>>  static bool unaligned_ctl __read_mostly;
>> @@ -683,8 +695,6 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
>>  
>>  bool __init check_unaligned_access_emulated_all_cpus(void)
>>  {
>> -	int cpu;
>> -
>>  	/*
>>  	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
>>  	 * accesses emulated since tasks requesting such control can run on any
>> @@ -692,10 +702,8 @@ bool __init check_unaligned_access_emulated_all_cpus(void)
>>  	 */
>>  	on_each_cpu(check_unaligned_access_emulated, NULL, 1);
>>  
>> -	for_each_online_cpu(cpu)
>> -		if (per_cpu(misaligned_access_speed, cpu)
>> -		    != RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
>> -			return false;
>> +	if (!all_cpus_unaligned_scalar_access_emulated())
>> +		return false;
>>  
>>  	unaligned_ctl = true;
>>  	return true;
>> -- 
>> 2.49.0
>>


