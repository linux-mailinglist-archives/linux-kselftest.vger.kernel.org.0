Return-Path: <linux-kselftest+bounces-29025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D01A60FFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 12:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34771749E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 11:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE891FDA82;
	Fri, 14 Mar 2025 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vCtRBqFz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F92F1FAC25
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952040; cv=none; b=pmnw2/8Gc2CEI9TrA5Zt1kbAku3cv2rNUIz+V0qnm/eFkeIZe60reKv61DCsc5rElpusYwcBn8ln5+NEqeaU1VdPDVzIEQypIWEBFmtN1BZ/xAKH1pfF6mcYEVDiUSvjpXP26rn2m0l7zl253Ae1U6+/AyS9Ph2j0ZRXcehGUdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952040; c=relaxed/simple;
	bh=VFo619g1ewrwqe/TdYiWkAB8pKkLXxjuW43KtWiO5EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcECU3eBlfipsVF3mQigLEnwSlpBmrbynKGsJWJTFcWYjzkgr5T6CdaRd/A7HPfXE1UqMD1sLduV2TbeyOOg527dhUTeEE1a4JE0xW/tC7yUA+Q9ZzzDN1VU93foDbqrT0VdhVX7sNujks+IC2pT7zoQ+LBlOQDvtTFhUbVN2BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vCtRBqFz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0a5cfd7dso13304795e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 04:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741952037; x=1742556837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nsvbx0/e3umNGv5t27NVbjQ76HCEZqmQcUDkEBMQhSw=;
        b=vCtRBqFzOc8z91AC5oBWsRqbEqxKYvRIXZ55bTJ+2REe30JiBEn8OuLpAR+GzOxSjz
         WDSDsPr9CFy8Tl3n6qmu230zpJIIg2UU97T2bKuBWKDiS7c92MzJI03iV62Hz1rTtu9l
         LRA1jv0sEbPDwL4Mxj4JcVUfq4vo5BP6wCpzPaJWyJtBJ/XOqAWzST+LxeoAq+Nt9ps8
         9ePmnTdzDjAl2QIhQ4OHX6il0LHH77Cq/N2DAFhqU3llu5KUt5yJFJuFncEjklLYL9tr
         /6HGxDHusyIHHSIQDjWw/r87Msb1fMfR+o8mB3pTVmKkP/qxqieaNoVnNHcxjOSPAQbS
         1ElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741952037; x=1742556837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nsvbx0/e3umNGv5t27NVbjQ76HCEZqmQcUDkEBMQhSw=;
        b=n6bM2O1w3e7GF1XgOxl5KsFNOtrbAm/0/Qa3uK+wPpGo0Bva52XgdkcyjZyHv+M0cC
         saVb/rh3WgFiRHa034qLJgtEkVi5quJ1AZTOf/MTrrxTlMzHZoB+Dzp0oJjrvICs5Oci
         DtF+3u7NAGodJYq9rYV3LLiQ5Rglmoas5/TiN78gWzDxh7Jq7byjBwoUrajjpUCTERhA
         5kn2D+0RZ3MpHxCDltowR6J5CHMsnlfhUWI25cCa8Tb+TBF+vdeTu1QzmlZXdOUom8St
         3NsgtWsg6G6z7dwNL1Tmo1wWMAUAmlJyY3L6tXYbR9uGvR+8PcsXKStk7F/JgCi4aHXS
         Aa+w==
X-Forwarded-Encrypted: i=1; AJvYcCWh5zMYGOi8E1t9Hdyak6PQkoZzQi6LJQt4JGu52DH4czZxa4MVNUSQzWfT3G42dpbFPBK1tJuHH6tls/1OH0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFnw7jwL2PAAxa0p6YpWnU1KnTmikJziKtM2CmFy1tDXPZ1mJw
	oEMplgb9lgVkSS7rMo9FLGKa/v8yK9eBU24VGEzef3NdwhLXCeSQ35DqsAaFJbU=
X-Gm-Gg: ASbGnctVlJ7w3ovc0WKc/1c9dX4X9l85Cu8DLQmDo1svh94GzxRsrqsUYHul9oa4COL
	gNn11loIm1MjjuYw/Hf5JhhtB0vPz0Je7dTFDK1GNSA7AEl/TeeKIQaWa/H/6CtjEMer/RFyBQz
	aAhKp7A3mMIO61MM7qB9kEedKw5B4fi+sIJjRzxpANRGcSfYQRP+WTtZ5UZj6/TEnR3gssPTfwH
	XacqOCbL3lWCOIlr7h4/zKEjMHJwSpQzSK3zdJo0W/csNRt55SH06cAou0SiF3h/oPHv8oQQLRB
	+e133oNj1n5FgbpuIu4GKaSZvMYav2fmxI3hD3hHrqoGqhQRO7zJvRuPZG0XGuEczsWzNrkw/tp
	u1qx47vPg/g1vsw==
X-Google-Smtp-Source: AGHT+IGFCS6aHC85bI1G02X5ARi0quKTYrYIojfOtWsQSuEVwoRIcZmL2DpiMo0uOfjcu6utBxTbug==
X-Received: by 2002:a05:6000:4025:b0:391:1139:2653 with SMTP id ffacd0b85a97d-3971ffb3a29mr1899191f8f.52.1741952036756;
        Fri, 14 Mar 2025 04:33:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe65977sm14993745e9.36.2025.03.14.04.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 04:33:56 -0700 (PDT)
Message-ID: <dad465de-e5da-4ebb-8395-ea9e181a6f57@rivosinc.com>
Date: Fri, 14 Mar 2025 12:33:55 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/17] riscv: sbi: add FWFT extension interface
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-3-cleger@rivosinc.com>
 <20250313-5c22df0c08337905367fa125@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250313-5c22df0c08337905367fa125@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 13/03/2025 13:39, Andrew Jones wrote:
> On Mon, Mar 10, 2025 at 04:12:09PM +0100, Clément Léger wrote:
>> This SBI extensions enables supervisor mode to control feature that are
>> under M-mode control (For instance, Svadu menvcfg ADUE bit, Ssdbltrp
>> DTE, etc).
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/sbi.h |  5 ++
>>  arch/riscv/kernel/sbi.c      | 97 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 102 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>> index bb077d0c912f..fc87c609c11a 100644
>> --- a/arch/riscv/include/asm/sbi.h
>> +++ b/arch/riscv/include/asm/sbi.h
>> @@ -503,6 +503,11 @@ int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
>>  				unsigned long asid);
>>  long sbi_probe_extension(int ext);
>>  
>> +int sbi_fwft_all_cpus_set(u32 feature, unsigned long value, unsigned long flags,
>> +			  bool revert_on_failure);
>> +int sbi_fwft_get(u32 feature, unsigned long *value);
>> +int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags);
>> +
>>  /* Check if current SBI specification version is 0.1 or not */
>>  static inline int sbi_spec_is_0_1(void)
>>  {
>> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
>> index 1989b8cade1b..256910db1307 100644
>> --- a/arch/riscv/kernel/sbi.c
>> +++ b/arch/riscv/kernel/sbi.c
>> @@ -299,6 +299,103 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>>  	return 0;
>>  }
>>  
>> +int sbi_fwft_get(u32 feature, unsigned long *value)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +/**
>> + * sbi_fwft_set() - Set a feature on all online cpus
> 
> copy+paste of description from sbi_fwft_all_cpus_set(). This function
> only sets the feature on the calling hart.
> 
>> + * @feature: The feature to be set
>> + * @value: The feature value to be set
>> + * @flags: FWFT feature set flags
>> + *
>> + * Return: 0 on success, appropriate linux error code otherwise.
>> + */
>> +int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +struct fwft_set_req {
>> +	u32 feature;
>> +	unsigned long value;
>> +	unsigned long flags;
>> +	cpumask_t mask;
>> +};
>> +
>> +static void cpu_sbi_fwft_set(void *arg)
>> +{
>> +	struct fwft_set_req *req = arg;
>> +
>> +	if (sbi_fwft_set(req->feature, req->value, req->flags))
>> +		cpumask_clear_cpu(smp_processor_id(), &req->mask);
>> +}
>> +
>> +static int sbi_fwft_feature_local_set(u32 feature, unsigned long value,
>> +				      unsigned long flags,
>> +				      bool revert_on_fail)
>> +{
>> +	int ret;
>> +	unsigned long prev_value;
>> +	cpumask_t tmp;
>> +	struct fwft_set_req req = {
>> +		.feature = feature,
>> +		.value = value,
>> +		.flags = flags,
>> +	};
>> +
>> +	cpumask_copy(&req.mask, cpu_online_mask);
>> +
>> +	/* We can not revert if features are locked */
>> +	if (revert_on_fail && flags & SBI_FWFT_SET_FLAG_LOCK)
> 
> Should use () around the flags &. I thought checkpatch complained about
> that?
> 
>> +		return -EINVAL;
>> +
>> +	/* Reset value is the same for all cpus, read it once. */
> 
> How do we know we're reading the reset value? sbi_fwft_all_cpus_set() may
> be called multiple times on the same feature. And harts may have had
> sbi_fwft_set() called on them independently. I think we should drop the
> whole prev_value optimization.

That's actually used for revert_on_failure as well not only the
optimization.

> 
>> +	ret = sbi_fwft_get(feature, &prev_value);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Feature might already be set to the value we want */
>> +	if (prev_value == value)
>> +		return 0;
>> +
>> +	on_each_cpu_mask(&req.mask, cpu_sbi_fwft_set, &req, 1);
>> +	if (cpumask_equal(&req.mask, cpu_online_mask))
>> +		return 0;
>> +
>> +	pr_err("Failed to set feature %x for all online cpus, reverting\n",
>> +	       feature);
> 
> nit: I'd let the above line stick out. We have 100 chars.
> 
>> +
>> +	req.value = prev_value;
>> +	cpumask_copy(&tmp, &req.mask);
>> +	on_each_cpu_mask(&req.mask, cpu_sbi_fwft_set, &req, 1);
>> +	if (cpumask_equal(&req.mask, &tmp))
>> +		return 0;
> 
> I'm not sure we want the revert_on_fail support either. What happens when
> the revert fails and we return -EINVAL below? Also returning zero when
> revert succeeds means the caller won't know if we successfully set what
> we wanted or just successfully reverted.

So that might actually be needed for features that needs to be enabled
on all hart or not enabled at all. If we fail to enable all of them,
them the hart will be in some non coherent state between the harts.
The returned error code though is wrong and I'm not sure we would have a
way to gracefully handle revertion failure (except maybe panicking ?).

Thanks,

Clément

> 
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +/**
>> + * sbi_fwft_all_cpus_set() - Set a feature on all online cpus
>> + * @feature: The feature to be set
>> + * @value: The feature value to be set
>> + * @flags: FWFT feature set flags
>> + * @revert_on_fail: true if feature value should be restored to it's orignal
> 
> its original
> 
>> + * 		    value on failure.
> 
> Line 'value' up under 'true'
> 
>> + *
>> + * Return: 0 on success, appropriate linux error code otherwise.
>> + */
>> +int sbi_fwft_all_cpus_set(u32 feature, unsigned long value, unsigned long flags,
>> +			  bool revert_on_fail)
>> +{
>> +	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
>> +		return sbi_fwft_set(feature, value, flags);
>> +
>> +	return sbi_fwft_feature_local_set(feature, value, flags,
>> +					  revert_on_fail);
>> +}
>> +
>>  /**
>>   * sbi_set_timer() - Program the timer for next timer event.
>>   * @stime_value: The value after which next timer event should fire.
>> -- 
>> 2.47.2
> 
> Thanks,
> drew


