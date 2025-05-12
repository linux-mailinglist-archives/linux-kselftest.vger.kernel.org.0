Return-Path: <linux-kselftest+bounces-32872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05F4AB4102
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 20:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F11F466C04
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 18:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2593296D23;
	Mon, 12 May 2025 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hGlf2DxK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114BB1EE03B;
	Mon, 12 May 2025 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072842; cv=none; b=T4zfIvV5vgnN9xduoVolfkYrIkoS6hJ+cbySUOB7ppSI756jBAOkvFLVkNyui1h/xvI6yRcgIqzXhw3lW2BbH+nJDAjGmSW4ShQJaLZfCjSoDWsL1ZrN3ySBCDa8uni9GZiFBXjecXSHvaWdNh0lFM3SbrCCRT8YVY9cvXKp8uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072842; c=relaxed/simple;
	bh=fGBDzm38SHotQ4ArsU6HmeU+3zz7XAVrMhlyZFy3IZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdtO0QeLJpAvMGQqE5i1DnjVF926LbVVmvQuVv2QkwMb9oK+X1ksh3gy4PPCjYp9TjoHEjFJLTrdkBfCNNnNABz3yqogBvkIDcfQWLlStHk7DGMh/JjWmCzpzQz1G1dZN/6aYfNIdcZVouJE9OtEm6C6HPL7C9Cs41u0U3wO3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hGlf2DxK; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f27b0506-4841-4650-a0ee-0fe1643fdf37@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747072827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ma5n1WWRt3IZMb/J5uvgHDAZKLn3T38CaI/Jo/Q76W4=;
	b=hGlf2DxK/ll+4zVXxruxyenHniDCnXz8vzRbFapb8hUS/itdZEy/TPz0teFHV4TatUnnP5
	BZv20ibsOKJy8hV5P8G/DZG5leGxmgDJH5uq+u9fW1PbSJFjurDRqz8BLE1IErge+GiHcI
	Rumre5V3Jb6JPbLB6RELqbbucJ4f7ug=
Date: Mon, 12 May 2025 11:00:21 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 04/14] riscv: sbi: add FWFT extension interface
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>, Deepak Gupta <debug@rivosinc.com>
References: <20250424173204.1948385-1-cleger@rivosinc.com>
 <20250424173204.1948385-5-cleger@rivosinc.com>
 <1c385a47-0a01-4be4-a34b-51a2f168e62d@linux.dev>
 <fe9d801b-007d-476d-97fe-96d0f3d218cd@rivosinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <fe9d801b-007d-476d-97fe-96d0f3d218cd@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/12/25 1:14 AM, Clément Léger wrote:
>
> On 09/05/2025 02:18, Atish Patra wrote:
>> On 4/24/25 10:31 AM, ClÃ©ment LÃ©ger wrote:
>>> This SBI extensions enables supervisor mode to control feature that are
>>> under M-mode control (For instance, Svadu menvcfg ADUE bit, Ssdbltrp
>>> DTE, etc). Add an interface to set local features for a specific cpu
>>> mask as well as for the online cpu mask.
>>>
>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>>> ---
>>>    arch/riscv/include/asm/sbi.h | 17 +++++++++++
>>>    arch/riscv/kernel/sbi.c      | 57 ++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 74 insertions(+)
>>>
>>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>>> index 7ec249fea880..3bbef56bcefc 100644
>>> --- a/arch/riscv/include/asm/sbi.h
>>> +++ b/arch/riscv/include/asm/sbi.h
>>> @@ -503,6 +503,23 @@ int sbi_remote_hfence_vvma_asid(const struct
>>> cpumask *cpu_mask,
>>>                    unsigned long asid);
>>>    long sbi_probe_extension(int ext);
>>>    +int sbi_fwft_set(u32 feature, unsigned long value, unsigned long
>>> flags);
>>> +int sbi_fwft_set_cpumask(const cpumask_t *mask, u32 feature,
>>> +             unsigned long value, unsigned long flags);
>>> +/**
>>> + * sbi_fwft_set_online_cpus() - Set a feature on all online cpus
>>> + * @feature: The feature to be set
>>> + * @value: The feature value to be set
>>> + * @flags: FWFT feature set flags
>>> + *
>>> + * Return: 0 on success, appropriate linux error code otherwise.
>>> + */
>>> +static inline int sbi_fwft_set_online_cpus(u32 feature, unsigned long
>>> value,
>>> +                       unsigned long flags)
>>> +{
>>> +    return sbi_fwft_set_cpumask(cpu_online_mask, feature, value, flags);
>>> +}
>>> +
>>>    /* Check if current SBI specification version is 0.1 or not */
>>>    static inline int sbi_spec_is_0_1(void)
>>>    {
>>> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
>>> index 1d44c35305a9..d57e4dae7dac 100644
>>> --- a/arch/riscv/kernel/sbi.c
>>> +++ b/arch/riscv/kernel/sbi.c
>>> @@ -299,6 +299,63 @@ static int __sbi_rfence_v02(int fid, const struct
>>> cpumask *cpu_mask,
>>>        return 0;
>>>    }
>>>    +/**
>>> + * sbi_fwft_set() - Set a feature on the local hart
>>> + * @feature: The feature ID to be set
>>> + * @value: The feature value to be set
>>> + * @flags: FWFT feature set flags
>>> + *
>>> + * Return: 0 on success, appropriate linux error code otherwise.
>>> + */
>>> +int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +
>>> +struct fwft_set_req {
>>> +    u32 feature;
>>> +    unsigned long value;
>>> +    unsigned long flags;
>>> +    atomic_t error;
>>> +};
>>> +
>>> +static void cpu_sbi_fwft_set(void *arg)
>>> +{
>>> +    struct fwft_set_req *req = arg;
>>> +    int ret;
>>> +
>>> +    ret = sbi_fwft_set(req->feature, req->value, req->flags);
>>> +    if (ret)
>>> +        atomic_set(&req->error, ret);
>> What happens when cpuX executed first reported an error but cpuY
>> executed this function later and report success.
>>
>> The error will be masked in that case.
> We actually only set the bit if an error happened (consider it as a
> sticky error bit). So if CPUy reports success, it won't clear the bit.

Ahh yes. I missed that.

> Thanks,
>
> Clément
>
>>> +}
>>> +
>>> +/**
>>> + * sbi_fwft_set_cpumask() - Set a feature for the specified cpumask
>>> + * @mask: CPU mask of cpus that need the feature to be set
>>> + * @feature: The feature ID to be set
>>> + * @value: The feature value to be set
>>> + * @flags: FWFT feature set flags
>>> + *
>>> + * Return: 0 on success, appropriate linux error code otherwise.
>>> + */
>>> +int sbi_fwft_set_cpumask(const cpumask_t *mask, u32 feature,
>>> +                   unsigned long value, unsigned long flags)
>>> +{
>>> +    struct fwft_set_req req = {
>>> +        .feature = feature,
>>> +        .value = value,
>>> +        .flags = flags,
>>> +        .error = ATOMIC_INIT(0),
>>> +    };
>>> +
>>> +    if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
>>> +        return -EINVAL;
>>> +
>>> +    on_each_cpu_mask(mask, cpu_sbi_fwft_set, &req, 1);
>>> +
>>> +    return atomic_read(&req.error);
>>> +}
>>> +
>>>    /**
>>>     * sbi_set_timer() - Program the timer for next timer event.
>>>     * @stime_value: The value after which next timer event should fire.

