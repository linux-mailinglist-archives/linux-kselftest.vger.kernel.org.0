Return-Path: <linux-kselftest+bounces-29033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3BDA610FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 13:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F863BFD79
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CB21FF1B0;
	Fri, 14 Mar 2025 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="P17ff/7r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125E31FDE35
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955012; cv=none; b=PgcMP7OkMQ9ehhJ1ZD0qVQfxnvEFiRe0QC6rfYXa50cRmHziZAya9z3Vvig2h+gpR6UlzaBzRDs5DLIN27MDCidaaGsXscx9YRux3r1ALnzBrz4l5gtMhiUYl/GMkP/Zbz48Qtu2fBGoim+yOQysGynb7yiBPUgg0Vmf+aYvBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955012; c=relaxed/simple;
	bh=Z4JyRsmuxnQvtktNf2axg7S3KaoJGRJjY+RY2W7OhWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FeiwdFaure8DcyNXqu1ClWH0+Tsalw1lHb9pTtKlfeRgl/8JR9h6b7O7PuoGA/fDRk9Y5RECvf1lxCL9Fqfj2iTEhURNcLV77kj6Xa3iLUhcrQngVN2ecGGQ+evfrZGXwmlQR9NsIXqu/GjKtKy14JUKV+XixLLmKlVBgaWmn60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=P17ff/7r; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso13530565e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 05:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741955007; x=1742559807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WP6+QPN2p5r500R0hJqs0tnx9bBYWE9RADg1EjXw61M=;
        b=P17ff/7rLjYg3VQS3PnSPOjdSu6M9PbqVWP9jTBGw9XcGuDWxxI4qX4+zr37W7yQdN
         2dVDeo6ZorgilJRDKJD6Gvg0s7ojVibSd46EyfhLh/eUD7lJQlTzSFnxAGVi5fzKLUN9
         B596u5M2QfccI3cdDJtVrk0QZelF3eIuZpWGT2YvpRhnwcT9UT0qIgISRxck/VC6/8RP
         PrcsgNDQhyRkcmDwJfDLO9n9xPzFDrSLVCegf7f2/SQ5IQdYhzeMLchA9FZq/0sl9qdr
         +D4Y4BpU7qHRqO2TB622VbnNtN0/35wMbEIfnv0brivHUcgUivYXxQVojbXfbQt0GSSc
         iGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955007; x=1742559807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WP6+QPN2p5r500R0hJqs0tnx9bBYWE9RADg1EjXw61M=;
        b=lzN670w2DrQ5XBfbcSsnZtA+nnsVy7NJIRtHQU19IK1LOqwLYv1IUPdSV1ocPovTfe
         FsN2gWR94FIsNFHyuHcveU8Dtg5aRMk5gbveBq6Vx/YB7YqUfayLNkceSoHGFMxRP7wz
         HoyEWZNvXcwq4TAQCa1cojuoxOOmP2KuIKB5wYkdRS6H2qxuIQqrXkohEy3h5q3l5Lmj
         TMVVpAn+9WcnowEDNq2N8WzSqUtttoeD0QZs/XmGr4rFoYHF8YH8PpUqzc1L/sF9iRNI
         tes4YlweBvEkppujcD2qvPzbdIqSn/e4PlHzkGApo4xukgv0JOUF+V0ZQBSWHJeZHRUK
         40jA==
X-Forwarded-Encrypted: i=1; AJvYcCXgRm7HsloQTqcMvJla9FUt1kxvUbl/Sj7OLs8TkFrS+vV0GSsGxXgu3J+fai9tGoGXEdx4qXpshHFJcJ4mTiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn5mLl14TUyhemdclTChyAhXo7q98kKicpU0ykHvNIdWQfvmvU
	SEepc5NcFgDJqFOziVIh9T0PTKfF3NUwVnp7PLYnnKs/OR4H8VQ7wE5iA3Svg5kGavdICOjRVjw
	EnSI=
X-Gm-Gg: ASbGncskiRWSn+0ukK1h3wsDUB/FpUDByr/vsCzLTYxVUPF8z1YjogV8vGDkeNcLioO
	4YG6qFodseB+yLKMza7kd77Kk3orFM9lxdDitfuQ65MF2KhxobiTpmnRzJxmXr8MqUfBtiEkN4t
	PqjstGj1qy9xZmh+2SlKiTVQI5ubwT6qKVyO4g5vPKix/Fxo0/JaqGbfnt0RgZbXyh2rL1tf58n
	m8KU+Fa4nGiYY6yDxKv0BxcYN9YTgLpLt8lXoi3G6T7dE9PLG5ppmdvW7VwV+9pbR08OSw/aXd5
	DlnDohlM8gapLH60u4EN8VXX79l8aW3ztTpS5vShBpRfMJhcpbKVSomMp/GHsMeqaZVuqnfnByt
	d8E3FynJ19EuO1g==
X-Google-Smtp-Source: AGHT+IECzef4MEIZSEOP5RVqxJ+PV0zddyhXW52CcNjDzrN5wKIHRVBzHv0+gxm6G7pjP8xbxVlCBQ==
X-Received: by 2002:a05:600c:218b:b0:43d:36c:f24 with SMTP id 5b1f17b1804b1-43d1ef4a5bbmr28499645e9.13.1741955007236;
        Fri, 14 Mar 2025 05:23:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60b46sm15737925e9.32.2025.03.14.05.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 05:23:26 -0700 (PDT)
Message-ID: <8990d87e-b46e-4c1e-b337-a954563f6474@rivosinc.com>
Date: Fri, 14 Mar 2025 13:23:25 +0100
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
 <dad465de-e5da-4ebb-8395-ea9e181a6f57@rivosinc.com>
 <20250314-10d8d58329aceac21e727ebe@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250314-10d8d58329aceac21e727ebe@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14/03/2025 13:02, Andrew Jones wrote:
> On Fri, Mar 14, 2025 at 12:33:55PM +0100, Clément Léger wrote:
>>
>>
>> On 13/03/2025 13:39, Andrew Jones wrote:
>>> On Mon, Mar 10, 2025 at 04:12:09PM +0100, Clément Léger wrote:
>>>> This SBI extensions enables supervisor mode to control feature that are
>>>> under M-mode control (For instance, Svadu menvcfg ADUE bit, Ssdbltrp
>>>> DTE, etc).
>>>>
>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>> ---
>>>>  arch/riscv/include/asm/sbi.h |  5 ++
>>>>  arch/riscv/kernel/sbi.c      | 97 ++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 102 insertions(+)
>>>>
>>>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>>>> index bb077d0c912f..fc87c609c11a 100644
>>>> --- a/arch/riscv/include/asm/sbi.h
>>>> +++ b/arch/riscv/include/asm/sbi.h
>>>> @@ -503,6 +503,11 @@ int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
>>>>  				unsigned long asid);
>>>>  long sbi_probe_extension(int ext);
>>>>  
>>>> +int sbi_fwft_all_cpus_set(u32 feature, unsigned long value, unsigned long flags,
>>>> +			  bool revert_on_failure);
>>>> +int sbi_fwft_get(u32 feature, unsigned long *value);
>>>> +int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags);
>>>> +
>>>>  /* Check if current SBI specification version is 0.1 or not */
>>>>  static inline int sbi_spec_is_0_1(void)
>>>>  {
>>>> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
>>>> index 1989b8cade1b..256910db1307 100644
>>>> --- a/arch/riscv/kernel/sbi.c
>>>> +++ b/arch/riscv/kernel/sbi.c
>>>> @@ -299,6 +299,103 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +int sbi_fwft_get(u32 feature, unsigned long *value)
>>>> +{
>>>> +	return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>> +/**
>>>> + * sbi_fwft_set() - Set a feature on all online cpus
>>>
>>> copy+paste of description from sbi_fwft_all_cpus_set(). This function
>>> only sets the feature on the calling hart.
>>>
>>>> + * @feature: The feature to be set
>>>> + * @value: The feature value to be set
>>>> + * @flags: FWFT feature set flags
>>>> + *
>>>> + * Return: 0 on success, appropriate linux error code otherwise.
>>>> + */
>>>> +int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags)
>>>> +{
>>>> +	return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>> +struct fwft_set_req {
>>>> +	u32 feature;
>>>> +	unsigned long value;
>>>> +	unsigned long flags;
>>>> +	cpumask_t mask;
>>>> +};
>>>> +
>>>> +static void cpu_sbi_fwft_set(void *arg)
>>>> +{
>>>> +	struct fwft_set_req *req = arg;
>>>> +
>>>> +	if (sbi_fwft_set(req->feature, req->value, req->flags))
>>>> +		cpumask_clear_cpu(smp_processor_id(), &req->mask);
>>>> +}
>>>> +
>>>> +static int sbi_fwft_feature_local_set(u32 feature, unsigned long value,
>>>> +				      unsigned long flags,
>>>> +				      bool revert_on_fail)
>>>> +{
>>>> +	int ret;
>>>> +	unsigned long prev_value;
>>>> +	cpumask_t tmp;
>>>> +	struct fwft_set_req req = {
>>>> +		.feature = feature,
>>>> +		.value = value,
>>>> +		.flags = flags,
>>>> +	};
>>>> +
>>>> +	cpumask_copy(&req.mask, cpu_online_mask);
>>>> +
>>>> +	/* We can not revert if features are locked */
>>>> +	if (revert_on_fail && flags & SBI_FWFT_SET_FLAG_LOCK)
>>>
>>> Should use () around the flags &. I thought checkpatch complained about
>>> that?
>>>
>>>> +		return -EINVAL;
>>>> +
>>>> +	/* Reset value is the same for all cpus, read it once. */
>>>
>>> How do we know we're reading the reset value? sbi_fwft_all_cpus_set() may
>>> be called multiple times on the same feature. And harts may have had
>>> sbi_fwft_set() called on them independently. I think we should drop the
>>> whole prev_value optimization.
>>
>> That's actually used for revert_on_failure as well not only the
>> optimization.
> 
> At least the comment should drop the word 'Reset' and if there's a chance
> that not all harts having the same value then we should call get on all
> of them. (We'll probably want SBI FWFT functions which operate on
> hartmasks eventually.)

Ok, then I can pass a cpu_mask as well so that caller just have to pass
online_cpus() if they want it on all cpus.

> 
>>
>>>
>>>> +	ret = sbi_fwft_get(feature, &prev_value);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	/* Feature might already be set to the value we want */
>>>> +	if (prev_value == value)
>>>> +		return 0;
>>>> +
>>>> +	on_each_cpu_mask(&req.mask, cpu_sbi_fwft_set, &req, 1);
>>>> +	if (cpumask_equal(&req.mask, cpu_online_mask))
>>>> +		return 0;
>>>> +
>>>> +	pr_err("Failed to set feature %x for all online cpus, reverting\n",
>>>> +	       feature);
>>>
>>> nit: I'd let the above line stick out. We have 100 chars.
>>>
>>>> +
>>>> +	req.value = prev_value;
>>>> +	cpumask_copy(&tmp, &req.mask);
>>>> +	on_each_cpu_mask(&req.mask, cpu_sbi_fwft_set, &req, 1);
>>>> +	if (cpumask_equal(&req.mask, &tmp))
>>>> +		return 0;
>>>
>>> I'm not sure we want the revert_on_fail support either. What happens when
>>> the revert fails and we return -EINVAL below? Also returning zero when
>>> revert succeeds means the caller won't know if we successfully set what
>>> we wanted or just successfully reverted.
>>
>> So that might actually be needed for features that needs to be enabled
>> on all hart or not enabled at all. If we fail to enable all of them,
>> them the hart will be in some non coherent state between the harts.
>> The returned error code though is wrong and I'm not sure we would have a
>> way to gracefully handle revertion failure (except maybe panicking ?).
> 
> How about offlining all harts which don't have the desired state, along
> with complaining loudly to the boot log.
> 
> Thanks,
> drew


