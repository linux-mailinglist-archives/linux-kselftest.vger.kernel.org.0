Return-Path: <linux-kselftest+bounces-6977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBD3894DC7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 10:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24EA1C210C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 08:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CA54501C;
	Tue,  2 Apr 2024 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YyTDyppR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65B93EA73
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Apr 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047429; cv=none; b=PSY6ScRgcxsXqAaCYL0qGRPVA+jR3OOSHuMA/byh0Kw6D+JYNtwLFGEWCMzNKQFNnkyPHbi2MtkvFLDdnosCt+eR/P9GvSAEb+Wr8NtBjuDvQ/bloYkRW492dZ+lwDhZ3vx49wTGVqNuFQfwAIDZGiVZMe84z+nxjVgM5HqHmBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047429; c=relaxed/simple;
	bh=lRW7ZLuKa0j9IDi6x5isHllL3lXa/vVHzH/iCRWfhwo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q8uRnubfgmwnLMvlomc+fBdKFbDygAQTgolmKNEubn0fNO72YD4WONO2uYl3tvQd9vL3DGNPXxV/Dch+l/t8mtATtATD76shgnF9tO2p8MRNvx7ty2f8jSGdRmyx+XHcd4UL5NYYhabSXCaBNMQneGqhh8KYedvFntFwPbi1ZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YyTDyppR; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a4a14c52fcso2759928eaf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Apr 2024 01:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712047427; x=1712652227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1ao1EWfYPtfm1HGEz8PRLBvpnUq6uoeFW7iGA9WZBEg=;
        b=YyTDyppR4qwNmp/vq3UfwdAUVnSHc26a0CViq8kV+ZMkNovCtkYoF45SMF90pL5Rif
         2WwyjCJrtH5NqXsDVwwtHv824+kFYfoGjtFN2a2T31UrDrfMt7nQcZPMsRDC8qae80sf
         GVXhCOqF2jZnA0pMr5lW5ncKOuGd8IjRVsBvWm/gfASIQkwLGRtmhF2AXmff59EYIX8V
         gp76Evar07s9n38RdltdgPuk9mNv0+5gQWUNpKcCWq+yZ5UfGC9PQg5gMxuqKBEUZxpE
         zP8mkEPkzl/b1xHuOU/UkDw0i7G/IkvpnIZujZW3aeiWPpv8y4CnOzCKmNSOWf7m6rTq
         f2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712047427; x=1712652227;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ao1EWfYPtfm1HGEz8PRLBvpnUq6uoeFW7iGA9WZBEg=;
        b=HfiG1c9TSKRfpL9eV6IgcmvmZ1Qcn+ZXZLrK7EFicAZIat03G+AZRiMQG9IcAVs1bM
         vFTQ7BK022DAUmW21B1vlJ62vs4wx8B51lQ8H2OywRmQFApPb4vPoNItWlvoO5qQ6GpI
         6QFG4actAhfUPF24zgOwiiYgotIL8Pt0Lct11H5UzQPc2/Ti/SPLB42NJ3DS72b3IvWD
         WpcMwIcc/c7qNSo3n7UZvdwr8HmWdBaeKhYIQDAnasQg+TwC50pxqB4aGJ11wvBaC6A5
         zVhUPMqv/sERq+x2orAYJI5VL1rANCWxa1x/wE+8VEoKZEtXQSGOkL4gmAz3i5DzCXhp
         2RBg==
X-Forwarded-Encrypted: i=1; AJvYcCXaUrnFcRQgoy3UmjhTfT1SFD93Y5G80gcDfCZgtDSPuQt3uHQE/RbcYVxRdJQlxSZlIoTtyUCqDrkigmQquPo2kh63kd8luiyNpL9qML6w
X-Gm-Message-State: AOJu0YyeN2JwyBUakLDblvJI4KRfw3wSV64QvymEXeTaqszmyX/yfQ/x
	cyn8D0uOELpD6KqmV06GG3UROPonfNuJhZjz/kDqr9ebpvHPSADePCb5K9sFob8=
X-Google-Smtp-Source: AGHT+IHeap9PtoP9dWxZ8Fxsi6MBW8mCRxu5nAbnRlzNqlVnyWHQm9bQqROV6m51/MeKVk/nOwVHCw==
X-Received: by 2002:a05:6358:e484:b0:183:bd0c:d2c6 with SMTP id by4-20020a056358e48400b00183bd0cd2c6mr4187597rwb.11.1712047426879;
        Tue, 02 Apr 2024 01:43:46 -0700 (PDT)
Received: from [172.16.0.34] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
        by smtp.gmail.com with ESMTPSA id e19-20020a63f553000000b005e485fbd455sm9184675pgk.45.2024.04.02.01.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 01:43:46 -0700 (PDT)
Message-ID: <d382c616-5212-4da2-be63-6ed0a85e13f7@rivosinc.com>
Date: Tue, 2 Apr 2024 01:43:45 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v4 12/15] KVM: riscv: selftests: Add SBI PMU extension
 definitions
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>,
 Conor Dooley <conor.dooley@microchip.com>, Guo Ren <guoren@kernel.org>,
 Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 Will Deacon <will@kernel.org>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-13-atishp@rivosinc.com>
 <20240302-698f4322ab7ba74fc3dba416@orel>
X-Mozilla-News-Host: news://nntp.lore.kernel.org
Content-Language: en-US
In-Reply-To: <20240302-698f4322ab7ba74fc3dba416@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/2/24 03:00, Andrew Jones wrote:
> On Wed, Feb 28, 2024 at 05:01:27PM -0800, Atish Patra wrote:
>> The SBI PMU extension definition is required for upcoming SBI PMU
>> selftests.
>>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   .../selftests/kvm/include/riscv/processor.h   | 67 +++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
>> index f75c381fa35a..a49a39c8e8d4 100644
>> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
>> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> 
> We should probably create a new header (include/riscv/sbi.h) since
> otherwise processor.h is very quickly going to look like an SBI
> header with a few non-sbi things in it. Can we add a patch prior to
> this one that moves the SBI stuff we currently have in processor.h
> out to an sbi.h? Or, we could start synchronizing a copy of
> arch/riscv/include/asm/sbi.h in tools/arch/riscv/include/asm like
> we've done for csr.h
> 
A separate sbi.h makes sense. I have moved the definitions to sbi.h as 
of now.

There is still lot more changes in sbi.h which is not required for 
selftests even after this patch. But I am okay with syncing with sbi.h
But I am not sure what should be the synchronization policy for sbi.h.

As needed or regular sync with after every release? The csr.h is already 
out of date even though it was created last MW (one change is part of 
this series).

Let me know if you have any thoughts about that. I can send another 
version with that.

>> @@ -169,17 +169,84 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector, exception_handl
>>   enum sbi_ext_id {
>>   	SBI_EXT_BASE = 0x10,
>>   	SBI_EXT_STA = 0x535441,
>> +	SBI_EXT_PMU = 0x504D55,
>>   };
>>   
>>   enum sbi_ext_base_fid {
>>   	SBI_EXT_BASE_PROBE_EXT = 3,
>>   };
>>   
>> +enum sbi_ext_pmu_fid {
>> +	SBI_EXT_PMU_NUM_COUNTERS = 0,
>> +	SBI_EXT_PMU_COUNTER_GET_INFO,
>> +	SBI_EXT_PMU_COUNTER_CFG_MATCH,
>> +	SBI_EXT_PMU_COUNTER_START,
>> +	SBI_EXT_PMU_COUNTER_STOP,
>> +	SBI_EXT_PMU_COUNTER_FW_READ,
>> +	SBI_EXT_PMU_COUNTER_FW_READ_HI,
>> +	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
>> +};
>> +
>> +union sbi_pmu_ctr_info {
>> +	unsigned long value;
>> +	struct {
>> +		unsigned long csr:12;
>> +		unsigned long width:6;
>> +#if __riscv_xlen == 32
>> +		unsigned long reserved:13;
>> +#else
>> +		unsigned long reserved:45;
>> +#endif
>> +		unsigned long type:1;
>> +	};
>> +};
>> +
>>   struct sbiret {
>>   	long error;
>>   	long value;
>>   };
>>   
>> +/** General pmu event codes specified in SBI PMU extension */
>> +enum sbi_pmu_hw_generic_events_t {
>> +	SBI_PMU_HW_NO_EVENT			= 0,
>> +	SBI_PMU_HW_CPU_CYCLES			= 1,
>> +	SBI_PMU_HW_INSTRUCTIONS			= 2,
>> +	SBI_PMU_HW_CACHE_REFERENCES		= 3,
>> +	SBI_PMU_HW_CACHE_MISSES			= 4,
>> +	SBI_PMU_HW_BRANCH_INSTRUCTIONS		= 5,
>> +	SBI_PMU_HW_BRANCH_MISSES		= 6,
>> +	SBI_PMU_HW_BUS_CYCLES			= 7,
>> +	SBI_PMU_HW_STALLED_CYCLES_FRONTEND	= 8,
>> +	SBI_PMU_HW_STALLED_CYCLES_BACKEND	= 9,
>> +	SBI_PMU_HW_REF_CPU_CYCLES		= 10,
>> +
>> +	SBI_PMU_HW_GENERAL_MAX,
>> +};
>> +
>> +/* SBI PMU counter types */
>> +enum sbi_pmu_ctr_type {
>> +	SBI_PMU_CTR_TYPE_HW = 0x0,
>> +	SBI_PMU_CTR_TYPE_FW,
>> +};
>> +
>> +/* Flags defined for config matching function */
>> +#define SBI_PMU_CFG_FLAG_SKIP_MATCH	(1 << 0)
>> +#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	(1 << 1)
>> +#define SBI_PMU_CFG_FLAG_AUTO_START	(1 << 2)
>> +#define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 3)
>> +#define SBI_PMU_CFG_FLAG_SET_VSINH	(1 << 4)
>> +#define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
>> +#define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 6)
>> +#define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 7)
>> +
>> +/* Flags defined for counter start function */
>> +#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
>> +#define SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT BIT(1)
>> +
>> +/* Flags defined for counter stop function */
>> +#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
>> +#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
> 
> When changing shifts to BIT()'s, don't forget these (easy not to forget
> if we go with the synch sbi.h to tools approach)
> 
>> +
>>   struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>>   			unsigned long arg1, unsigned long arg2,
>>   			unsigned long arg3, unsigned long arg4,
>> -- 
>> 2.34.1
>>
> 
> Thanks,
> drew


