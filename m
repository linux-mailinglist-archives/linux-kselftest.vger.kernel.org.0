Return-Path: <linux-kselftest+bounces-33367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856EBABD1B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 10:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069B93AD5A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 08:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBAE2641CC;
	Tue, 20 May 2025 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YbITwSei"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25F4263C6A
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729193; cv=none; b=iJtkOVQSWQDi67DIbGgIoxbf+EgCds/6tEKYyCwfD7gtetiFNUjypJZWt+HJzwRpVsHouDJfljRBbgh2EjQGNW/f//j4r7/xH9sRRoeoau/11h07yp5jYOv5pN+HNL2idy47sVVo4xBOaVAgDjhbLLKP2N1chD6f2IXA+BIZDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729193; c=relaxed/simple;
	bh=oIeZDvZ06+adGEcc2PTcN9SlCbujZpBAp1mCH9C1Smw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/eziF4GhPnROzyd21GnH4xYsSgZJlUHiLktLqy+84smwPSPgEqUN2K7yecXwqvUXLUCDdsatrtKeYwaCjXnzpTvevIi/OFGKWzKPsa4lMZiCiweO27XFCb6JXFb3CH6GQ5pDhxKPSlxHo196ZZfsfH7TxqqD8nAIj0DXIYLZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YbITwSei; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfe574976so37200825e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 01:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747729189; x=1748333989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rg4dqqae5QAhm/jj8YkR21SQpKcd2PY6mEVX2p2RC/E=;
        b=YbITwSeizmZTb4FHUBv2km9ODeH/W1bdvnX3RZw7o9fw9gKd1vD/PCqLqBCUA2ZL/o
         DRhenXVr+2QzKz+XoR+inJOiWl4wJ6BuF44WjLxK0i/ShYKsWIYzs2hKT4JLSKHuHQXt
         jrYxtzKtyyailtF+p6D5LjeUyOz1IRUmbpdZdeHScPW/vNlvX1d8gjboPjO2Pf/xwz32
         8HytyKBdAcdsBu0/nUZUjEXmu6sChpxKt8TXWr5hDt3Itz1fAx9qFTAxF7S3eO7Gl8KN
         TH0ekSCbegqfTEl9Bs+M4BPtfh183BXHpIGCalPKSH+4GlRjy6ziYtEr1JYVld0eIoS6
         Tu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747729189; x=1748333989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg4dqqae5QAhm/jj8YkR21SQpKcd2PY6mEVX2p2RC/E=;
        b=Lul09ur9r742Tn6VsHdCa0f+wWyA6QoHgFgL6ygsiZnJQI9lWcqLFU1Rq9/AY/bB78
         MCj3ggUtp4LYlSybj8E+iuu3ku3g6X4EET/FnfIdi65AfWee4kQeiRz1WiG7pk/+ymRp
         X/RF2+I3K4PoPBMdy/cXOM0ZroVROI0LcC0lRXL73P8D3Z8avH9e1M7uVW1fietlh0Mx
         tNdMU86v3pcf6lwlSl07g5RbpnDhsv/9JC3BvCQ8+E6tdvsvS8cB4ZNPbsqB8sWqG4Ll
         DYNN6O4tOkQipYLB5bvQBKtG2Gv6ueiFIDCbUi19lZS0DKFBLRHlWKmO7i4OZySHPGbp
         gURA==
X-Forwarded-Encrypted: i=1; AJvYcCVnro1DKcxpKJh/eb1JnR1XXy/647iy91isALX+M6D0bfoAhix7pLYWOnK3k6R+FLVAAfaTpXOEP0Td+iMBPRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmz7hMSqQ6FLQJdgktkglIwZSn8bsPrMhATjKoUHr4BRW3dt37
	7Yj3vrHVJAlQgF5vfGDpl+41tep9ileliOPOcMg/d4mL1VDql7ttfIhMr3qQeRpz3h0=
X-Gm-Gg: ASbGncurkJYaah5a3hadYTtpFCsotG1Pzpe5NE95Gd7TPf1qSjsOYdGIw5K6WecDxtK
	4Sb4egl9nCIkn04BXDL2qunleyJY39y4JrflMAf8tNBXHZGSNnG8ffmwsnzLxI11hhySDM6pmPw
	iRMTyxaEo6e2T2iNjH5XdO9XgPN1E2N5RK1JDRtB8mu27ASEuukXKm9B5Dai7kw5+FHFlawApg4
	ESprtuXCm2Y4gF5zzEOE/2BInS2Jtp/TbvUXhDlyX2sZHhn/YgC9rXYGCZtpXeVcvnlUfMHdjki
	4u7EUyWmZmMXcNwbhkYz34pntzRXUiARkdM8X0cOOa7M0UH1pJ5qdFcMUiYC2qnNyG/Xgcwm94f
	WwH8SIq4R0CXurqXHqwaA
X-Google-Smtp-Source: AGHT+IEnBNI1O6DOXTrHnPp911hPTHbpDnBVZzrdBEbI+pdS0MKdIeQtQ/je5/atfqHW1EnEtC8JdA==
X-Received: by 2002:a05:600c:1c03:b0:43d:2313:7b49 with SMTP id 5b1f17b1804b1-442fd627744mr144511695e9.12.1747729189050;
        Tue, 20 May 2025 01:19:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aea59sm21045525e9.25.2025.05.20.01.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 01:19:48 -0700 (PDT)
Message-ID: <126762fc-17ca-4e9d-94d0-3aed1ae321ff@rivosinc.com>
Date: Tue, 20 May 2025 10:19:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/14] riscv: misaligned: move emulated access
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
References: <20250515082217.433227-1-cleger@rivosinc.com>
 <20250515082217.433227-10-cleger@rivosinc.com> <aCu_ce-kVQsyjrh5@ghost>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <aCu_ce-kVQsyjrh5@ghost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/05/2025 01:32, Charlie Jenkins wrote:
> On Thu, May 15, 2025 at 10:22:10AM +0200, Clément Léger wrote:
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
>> index e551ba17f557..287ec37021c8 100644
>> --- a/arch/riscv/kernel/traps_misaligned.c
>> +++ b/arch/riscv/kernel/traps_misaligned.c
>> @@ -647,6 +647,18 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
>>  }
>>  #endif
>>  
>> +static bool all_cpus_unaligned_scalar_access_emulated(void)
>> +{
>> +	int cpu;
>> +
>> +	for_each_online_cpu(cpu)
>> +		if (per_cpu(misaligned_access_speed, cpu) !=
> 
> misaligned_access_speed is only defined when
> CONFIG_RISCV_SCALAR_MISALIGNED. This function should return false when
> !CONFIG_RISCV_SCALAR_MISALIGNED and only use this logic otherwise.

Hi Charlie,

misaligned_access_speed is defined in unaligned_access_speed.c which is
compiled based on CONFIG_RISCV_MISALIGNED (ditto for trap_misaligned.c)

obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o

However, the declaration for it in the header cpu-feature.h however is
under a CONFIG_RISCV_SCALAR_MISALIGNED ifdef. So either the declaration
or the definition is wrong but the ifdefery soup makes it quite
difficult to understand what's going on.

I would suggest to move the DECLARE_PER_CPU under
CONFIG_RISCV_MISALIGNED so that it reduces ifdef in traps_misaligned as
well.

Thanks,

Clément

> 
> - Charlie
> 
>> +		    RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
>> +			return false;
>> +
>> +	return true;
>> +}
>> +
>>  #ifdef CONFIG_RISCV_SCALAR_MISALIGNED
>>  
>>  static bool unaligned_ctl __read_mostly;
>> @@ -685,8 +697,6 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
>>  
>>  bool __init check_unaligned_access_emulated_all_cpus(void)
>>  {
>> -	int cpu;
>> -
>>  	/*
>>  	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
>>  	 * accesses emulated since tasks requesting such control can run on any
>> @@ -694,10 +704,8 @@ bool __init check_unaligned_access_emulated_all_cpus(void)
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
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


