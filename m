Return-Path: <linux-kselftest+bounces-31548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3627BA9AD8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 14:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3A018939AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 12:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85F527A936;
	Thu, 24 Apr 2025 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CV874tSA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D73A8F58
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498108; cv=none; b=dKdfBw5KQeEsk7xrJ0eW5EVHE6DTBsRcMFI97zgJnSK9Melg6ZH1coNXwVh1ZsTf3uyHtXOrucjFqMVytHGzpthaxV58/IwP2uhmXL8SVTMmkExS6xgm2ipz4oWqYg1Pm0R9AffeyCbUo4DqtlsdOzFoTd71Pttlo0/KDhuilCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498108; c=relaxed/simple;
	bh=6IMg657M64uQmwN+jh4utQmYgOvUnVhFe0GlDIgoHdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrGqdXLWhd3guJL2nbg/rYX6Np49r2F3yIMNyTXJ2SX4nqJ/lmaqu6BpAxB6thhSmjLkrMP9bujgO0pYj8C2lNFWZS4Rr7X/OhIzdv/QcjphZ1AYOfNQ+r2mR5kkkSDOowi6phr8ZJXT0ljfk0qYhdXkP1i5MTATTFz56UZTcWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CV874tSA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf848528aso6779655e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 05:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745498104; x=1746102904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNMAR2ow2m6nJc7QSxTl3I9Uc8Pm3w7ZW7eElxL9kzk=;
        b=CV874tSAThAe0Q8AGgsz2fCdMzfBqAqSPPVo0p2ZDGgV9llwVZRTwQps3gvfaXQTDa
         kkUuO2b/cfBdZ2UoxdeRsx5vA1PyNrAX8WvPfAE3YOz3YfWySMV5t4YevWxIVYEXMfUN
         CfH/MouZGAT74/G5lcdL1+VGu2GvVlJvH/JwC+OKyEKp37sfB8VAVMKPwZOwuIvB78DM
         qJanJ5YVKw7c2cGpV7GNSvWewii2CXwDPnX1A0xK8q9x48oMv1xquqgg4fLb52wxgku/
         /YvT86ItqK+X3EsyL5Q+hH3zGz6aiddUPQhxvXKaUjXlgGsbvN8fmhzCn4vPY7JmfYBX
         mjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745498104; x=1746102904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNMAR2ow2m6nJc7QSxTl3I9Uc8Pm3w7ZW7eElxL9kzk=;
        b=QF9pahawMmO/atAXrJ/fZfFTlyj4urLR1LsvIGqtB1w9QGh0YD/mONc5YtBm62x0Qr
         i7kq3y5BxkEBwb2tZqN8wrWURWTNbz4CDYO8uuUgxkaBDMrtI0/41K2LNaa7v+UmQ6Fu
         66DMEioG0tau26wromA/VscRfvcg3MmdH9RMP6XL8Vdv//vWPSu4tXTFBfF0/yi1Zgyj
         lQCb2rPJtfHRsIrL4QmgqFHG2XrGVmudcSjRdJlNDy1OEuGcDV6FN2WRzoF7MXMsYlUY
         0qcX6QvFmQLw9oSt57m2cgMSX7ko+VBSWmJ9rWHnMTvJ9585jky9rWl58WEtHc9zyCr9
         km4A==
X-Forwarded-Encrypted: i=1; AJvYcCXWXRPph8Xr1G0ym3nScy/G1Pgm/lakEwETjvMHByWQ5sRp73neZdUTXeRYkaXoznwj4O/mVlaFPm+hYk/mXjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqzPs+bDJvWMABJXSvDOtqjVB0NoXBJsdzEnO1j1mGYx4cSw6q
	wjEGCUyASEDmjUImy8TqfUUy6u+fsrNMOAiQsNf60FF3JRxQqxO70bVxStlIqu0=
X-Gm-Gg: ASbGncsChJc/VlJATXLl2UTI52SQ42JX59uJlZPKvt31uFgW3MCuq//A/4ypk3ozYVg
	rRQ76HQvGK8W9Udl0kXr+jXPOBsIAAmoF8q2tFuw67+QoVmdOo0BRPmB5gwpBGVF+HwSYVTsHX2
	YEzyyC3nsLIBNt5lZ4PCiSNvI/9EplXPePsXWtFOhxO5X4nv1LG38ddGdjC2wR0G0tyubpF/Pvq
	ubM5B0Cppr2Bfy2fWtRfBPNREBFxBPJnMmKfNvZbUzqaU8TqB18+D9Y8fCP2LMzL3N1z0hUGFiz
	JoZMOO+w38ow5nDqUbBQ2+mOzui9TwELmzGPUY72lMA6sdZvG6wtbPFCQSiQaHeV/3IIQ6KEXo4
	YGD/kysI0Aw==
X-Google-Smtp-Source: AGHT+IGVtiMSUESCXxVr8lAA6TW/b8o7vs1YUH21uoFbmNmUInqOubAKtgP45r/urKl+RsY3D8dRJg==
X-Received: by 2002:a05:600c:1c8d:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-4409bd1f46cmr23664385e9.17.1745498103920;
        Thu, 24 Apr 2025 05:35:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2a2e59sm19303745e9.16.2025.04.24.05.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 05:35:03 -0700 (PDT)
Message-ID: <f6c5c92d-73aa-41a7-99bb-f95e388ea294@rivosinc.com>
Date: Thu, 24 Apr 2025 14:35:02 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/13] riscv: sbi: add SBI FWFT extension calls
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>
References: <20250417122337.547969-1-cleger@rivosinc.com>
 <20250417122337.547969-5-cleger@rivosinc.com>
 <20250424-c0700f89bcd29438d6d8d65c@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250424-c0700f89bcd29438d6d8d65c@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 24/04/2025 13:06, Andrew Jones wrote:
> On Thu, Apr 17, 2025 at 02:19:51PM +0200, Clément Léger wrote:
>> Add FWFT extension calls. This will be ratified in SBI V3.0 hence, it is
>> provided as a separate commit that can be left out if needed.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/kernel/sbi.c | 20 +++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
>> index 379981c2bb21..7b062189b184 100644
>> --- a/arch/riscv/kernel/sbi.c
>> +++ b/arch/riscv/kernel/sbi.c
>> @@ -299,6 +299,8 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>>  	return 0;
>>  }
>>  
>> +static bool sbi_fwft_supported;
> 
> At some point we may want an SBI extension bitmap, but this is only the
> second SBI extension supported boolean that I'm aware of, so I guess we're
> still OK for now.

That seems reasonable to have a bitmap rather than duplicating
*ext*_supported. If that's something that bothers you, I can take care
of it and use a bitmap. SSE will also have a sse_supported boolean but
in it's own driver file though.

> 
>> +
>>  /**
>>   * sbi_fwft_set() - Set a feature on the local hart
>>   * @feature: The feature ID to be set
>> @@ -309,7 +311,15 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>>   */
>>  int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags)
>>  {
>> -	return -EOPNOTSUPP;
>> +	struct sbiret ret;
>> +
>> +	if (!sbi_fwft_supported)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = sbi_ecall(SBI_EXT_FWFT, SBI_EXT_FWFT_SET,
>> +			feature, value, flags, 0, 0, 0);
>> +
>> +	return sbi_err_map_linux_errno(ret.error);
>>  }
>>  
>>  struct fwft_set_req {
>> @@ -348,6 +358,9 @@ int sbi_fwft_local_set_cpumask(const cpumask_t *mask, u32 feature,
>>  		.error = ATOMIC_INIT(0),
>>  	};
>>  
>> +	if (!sbi_fwft_supported)
>> +		return -EOPNOTSUPP;
>> +
>>  	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
>>  		return -EINVAL;
>>  
>> @@ -679,6 +692,11 @@ void __init sbi_init(void)
>>  			pr_info("SBI DBCN extension detected\n");
>>  			sbi_debug_console_available = true;
>>  		}
>> +		if ((sbi_spec_version >= sbi_mk_version(3, 0)) &&
>> +		    (sbi_probe_extension(SBI_EXT_FWFT) > 0)) {
> 
> Unnecessary (), but I see it's consistent with the expressions above.

I can fix the other ones as well in another commit.

> 
>> +			pr_info("SBI FWFT extension detected\n");
>> +			sbi_fwft_supported = true;
>> +		}
>>  	} else {
>>  		__sbi_set_timer = __sbi_set_timer_v01;
>>  		__sbi_send_ipi	= __sbi_send_ipi_v01;
>> -- 
>> 2.49.0
>>

Thanks,

Clément

> 
> Besides the () nit
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


