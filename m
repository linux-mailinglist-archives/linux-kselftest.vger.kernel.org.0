Return-Path: <linux-kselftest+bounces-31547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01D5A9AD82
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 14:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E056218951A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 12:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6986327B4E8;
	Thu, 24 Apr 2025 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ouvFTuPc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DC527A90F
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497926; cv=none; b=VlXaTqRit3aE4hHE6SptXBmHGakp08X5aU7Uv9JHAcSilTqRudcbtJkXeMt720Bla2xCocsW580GxJzlHvb/xt/elET31Rj4r/8+Q8/sy9FcecaRnokEioWZQz07bRws7KiCWjYZZS8vx6GX33bhsXxqNKqfGhBJO6K9VAEgIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497926; c=relaxed/simple;
	bh=DebhlcyRhbRiLH7Hw/JJUYX8s/MyyC03g3SuMWCXRxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3nasRKbhNSjuDqZhywd1fR4YrJF27MYY8xDUkbmYgjEbnSfLTQ0ITqTCggTDTqyOZVGnZwzzibMeSJrRHme6XqFBllgwgx3OJky0SRfw+Kf1+FG18/RAmmR0Jfk1JJd/EJy7hREW+FtaPPX/4J5YCfJ9sN1AOMJUrfV2HPA0gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ouvFTuPc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso788713f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 05:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745497922; x=1746102722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sjc14tFyag0YtVPIXBTjoyM3oPXcpSiYksqErLNt2L0=;
        b=ouvFTuPcykAOFzZ4V94TFIOqFz3HqBbaFs5gRrjRHOBeQPlpD/q6tjnKPNKE70pztZ
         BlCkmNed/Uob7QUz5I6aG2Ft1Je5Vq0P0G6wBot0svpYOKfJZ5L+Rb34vMY7M793yeXw
         p7zCxEOT5TFb5MLM7HLWfG+R8FaI85cpR2NZt3GJCbDRRUPSRElu/MOlyFYmKxM5srQx
         G2TsyZI2laV9/g4cJJN5noMFVN+laNzgFBOTAuvbUDmv0D75sHqg9iGot1P3wTj9FZjw
         4BGf+hJvfETSyHx0V7U2yHSo2SH2QzStqy0+9zjf4oFMd4iaMFLfYfdKe6kGhecaUgkB
         YfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745497922; x=1746102722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjc14tFyag0YtVPIXBTjoyM3oPXcpSiYksqErLNt2L0=;
        b=mD5h87lCQss+kc4PRNDvIlQmonOl2l3cB1TQNbHT4k90BMRT3zC+TpYgqB6F9QLcvd
         bD+zZmU2V9hdICSVrW5Gb5Ikfwhbs3gcH2zXx5R8bvwPinFLRrTRd8mo0fveaiLu23or
         yXs/OEOmNImZXVKCN9Adwvv41+O/1DYT/OYNXEF80JXiLxyvs3DKsgS/joBLeS+Re4FU
         m7i9MKDcZEl6dcpLKxb4bV2sSniR/hjdi1nNzOXHjD6SFENz5cPZjcRRC3Q6u1h+u28a
         dlS6C1ns0iyzlp85EKZrJ4w/xdF9X6gj3sTScASRVNDjWE/pDagLV+qd5BDzm2pJQrY4
         GpjA==
X-Forwarded-Encrypted: i=1; AJvYcCXY7XN9IfLN85z4UlEs84SCMYXm5Dc90BnMFjdcTGtwi1ddoEysLbgNQ8jq0wBZPFJOAruYQsx25iQ6jWncdHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPXglF17CuT59mBLBzwYweA72vzqd1KRywJlICTymSkOzqFNwG
	0GNwPeHkRIKoOO+Rv5vu4jW0PetyCGgMt2FRMWTbG4DOMyjvf8onS0rIJMrgwzs=
X-Gm-Gg: ASbGncunk1PozxCm3CW+ctDLTbyLZ2UGdXNQ+xk6oa98gtLUZpfnyx0IEWBtJq4sLmO
	vuOcb+ARHjF+Tqk/T6n5WyA31526RB/crey+rAQ7Nb9lmEMTzkz23bE9ZRdKJG50ukEp0mteggi
	x0xeP7D2TXR5DDFk7CK9u22+nQgMbs90b/hbFk0tXHIEnM2HLcYOv1DvBIguO04IVoz+mRSKrP4
	456y1MtTbTtZcgnj0L7zU3aHJmFkpvhYZh6yfd8gaZfc97diB6dary4pFT+VyS/44uR43ptUwp4
	pB8rVuctoJMOjIN3LTUXAAI8MWmT0NikbKyTO/k1qB3dbskAFYlhQoV82MFZ5+romSWlvBYC1E2
	dIFYVTt6oGw==
X-Google-Smtp-Source: AGHT+IFbJZjPmuMD3YIQwLoJ857azwRhf/epJ6CxLQ+gyc15vU+Ezwb55G76EYJKFKkcG3RmozFEJg==
X-Received: by 2002:a05:6000:2911:b0:39c:e28:5f0d with SMTP id ffacd0b85a97d-3a06cf5ede6mr2159263f8f.25.1745497922377;
        Thu, 24 Apr 2025 05:32:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d4c4b52sm1997065f8f.55.2025.04.24.05.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 05:32:01 -0700 (PDT)
Message-ID: <67e81f13-5e5e-4630-9a3f-73856b952e6e@rivosinc.com>
Date: Thu, 24 Apr 2025 14:32:01 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/13] riscv: sbi: add FWFT extension interface
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>
References: <20250417122337.547969-1-cleger@rivosinc.com>
 <20250417122337.547969-4-cleger@rivosinc.com>
 <20250424-c85c9d2f189fe4470038b519@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250424-c85c9d2f189fe4470038b519@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 24/04/2025 13:00, Andrew Jones wrote:
> On Thu, Apr 17, 2025 at 02:19:50PM +0200, Clément Léger wrote:
>> This SBI extensions enables supervisor mode to control feature that are
>> under M-mode control (For instance, Svadu menvcfg ADUE bit, Ssdbltrp
>> DTE, etc). Add an interface to set local features for a specific cpu
>> mask as well as for the online cpu mask.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> ---
>>  arch/riscv/include/asm/sbi.h | 17 +++++++++++
>>  arch/riscv/kernel/sbi.c      | 57 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 74 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>> index 7ec249fea880..c8eab315c80e 100644
>> --- a/arch/riscv/include/asm/sbi.h
>> +++ b/arch/riscv/include/asm/sbi.h
>> @@ -503,6 +503,23 @@ int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
>>  				unsigned long asid);
>>  long sbi_probe_extension(int ext);
>>  
>> +int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags);
>> +int sbi_fwft_local_set_cpumask(const cpumask_t *mask, u32 feature,
>> +			       unsigned long value, unsigned long flags);
> 
> I'm confused by the naming that includes 'local' and 'cpumask' together
> and...
> 
>> +/**
>> + * sbi_fwft_local_set() - Set a feature on all online cpus
>> + * @feature: The feature to be set
>> + * @value: The feature value to be set
>> + * @flags: FWFT feature set flags
>> + *
>> + * Return: 0 on success, appropriate linux error code otherwise.
>> + */
>> +static inline int sbi_fwft_local_set(u32 feature, unsigned long value,
>> +				     unsigned long flags)
>> +{
>> +	return sbi_fwft_local_set_cpumask(cpu_online_mask, feature, value, flags);
> 
> ...that something named with just 'local' is applied to all online cpus.
> I've always considered 'local' functions to only affect the calling cpu.

Yeah I thought of that as well, local here refers to the fact that this
function applies for a local feature (as described in the SBI
documentation) but agreed that it's really missleading. Any idea for a
better naming ?

Thanks,

Clément

> 
> Thanks,
> drew


