Return-Path: <linux-kselftest+bounces-7441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C833E89CF28
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 02:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818222835C5
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 00:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9199E10E6;
	Tue,  9 Apr 2024 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ag5YBuC4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50C2181
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Apr 2024 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712621087; cv=none; b=S0cJmL0PMrrZzPGlJg9NtcHN210h7QHrRzvNCA9hj1i2AWlyEPtaDkmYcZwvGEMXamrJQeaSQsOHI3HGEDtEHF/E5GN47CWqGVTvYjbeHm0P9LpXmxjJWFrFiVVa5IASNb+3se5r0t7jMmYrBOTFfIXFuj0VynRtam3qBV+DTbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712621087; c=relaxed/simple;
	bh=tGemAdGs1i/th5kpM2ts3FwXyK6yltFMw9jonLi8+1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEarfnPlM3OaAbmfdLbHXuO8du7h/flQaibxQDnj2mAakDWgFHhV1MxBZnsqO8Z2K9jjO0nLcZAEAlgtXt50Z0GN27p08PKDLjml0B5bOyit2lHMc1mwFtDlRHlP+fdym2OKGdBgmaNl9iV+d5Z3S4l/GB+t3kc0hT7gCuAi2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ag5YBuC4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e424bd30fbso11196925ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Apr 2024 17:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712621084; x=1713225884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xd+FWiZlX/lpCLCXGGzdHlU3p21YETfnnn9ljhWHF9I=;
        b=ag5YBuC4jZYDWk+vcemFhfpKim+usl0i89xx/mLRK/sZ5KhQu4noBx6ZHCWYMvbb3z
         1HberzLuUvZ17p8Xp5sTpijGt+9K+T787qIibS53AIQnhGEsCskhHiJHhqTaHTdGbdJB
         4WOrHva4e8dWwlu0Fp50P+XxdpZJEP7HxVU2wenl4GV9nFd6Us/ONeBn8hzAUTCSy0rP
         DM9/owVNWzWVhxY04snMMIxglq4qND5KGAp/5eMeEQb8D8lDXqSzvtKnhAPVRi11mC/P
         xr4qRFRV01w8gYyXp4yy0SLWXIcQUf4OcVnbSIGue3lSE1x4W9UhZEdev9rED215ppxZ
         BJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712621084; x=1713225884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xd+FWiZlX/lpCLCXGGzdHlU3p21YETfnnn9ljhWHF9I=;
        b=exXdvxqU/VyUJB8XXYDvllfw3tmtP6UaFN+QuVTjAiP+opemiokTANu7AEYxKuYLOK
         uRGYs2JCsIB7mWMGitU2qDoYg2/a38P/GX8mb0JrH9v1aGd7xjLeJvahcFsKChXZ6QdL
         rsXJJi9tonXesl6nNMicg+TGK8TsIXTfQsiQVvLauuwjqqlZBJdOXd3fsfpvzR4OiJzb
         wg4LH5KKZ4aqTuQrkVg05D+ODTLlfv5JJuLScMouRqjIrFF7SvT6xb9rvMcu/PlutvS7
         lMnVD47QpSE18MU304SAOTi6ZgWO+z0bx5oU8MmcLmJBaqn9I9VJNfXW6lTQgmZ+poVv
         HYXw==
X-Forwarded-Encrypted: i=1; AJvYcCVmnj+iPm58dja9BCrb/xcdok8hNFtKO+gTDzFU3KmXwfuzAwIZrq0iHgXr3uSASQ1WDYR9BUZpjzOamYKaZ3f/iSDCIQjRPZF4wlWghTfB
X-Gm-Message-State: AOJu0Yz/H0edYGhmiQhRTAG6SLuriTnYx62rnm/9RrJP1RumrlNG/Iw+
	QnUJRBqA3iPBNtkvdKRYOa7u/oaFWNuSiDZqUDiiQxBSLDyye8lp1qCr9nFT5EQ=
X-Google-Smtp-Source: AGHT+IG0OLdQkdZe7TuiqVfC4hYuT4+LNj+NNHp96L1eyYQkeOCssr3BNq26TdksuIIDjP/3fRra5A==
X-Received: by 2002:a17:902:d2ca:b0:1e4:1932:b0a5 with SMTP id n10-20020a170902d2ca00b001e41932b0a5mr5371923plc.68.1712621084126;
        Mon, 08 Apr 2024 17:04:44 -0700 (PDT)
Received: from ?IPV6:2601:647:4180:9630::e8c1? ([2601:647:4180:9630::e8c1])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b001e1071cf0bbsm4411011plg.302.2024.04.08.17.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 17:04:43 -0700 (PDT)
Message-ID: <e95f9821-e83c-4abb-941d-60ce24b9c0a3@rivosinc.com>
Date: Mon, 8 Apr 2024 17:04:41 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/22] drivers/perf: riscv: Read upper bits of a
 firmware counter
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>, Anup Patel <anup@brainfault.org>,
 Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Alexey Makhalov <amakhalov@vmware.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Will Deacon <will@kernel.org>, x86@kernel.org
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-4-atishp@rivosinc.com>
 <20240404-89ee7d7f90a5fcc91809065e@orel>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240404-89ee7d7f90a5fcc91809065e@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 04:02, Andrew Jones wrote:
> On Wed, Apr 03, 2024 at 01:04:32AM -0700, Atish Patra wrote:
>> SBI v2.0 introduced a explicit function to read the upper 32 bits
>> for any firmware counter width that is longer than 32bits.
>> This is only applicable for RV32 where firmware counter can be
>> 64 bit.
>>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   drivers/perf/riscv_pmu_sbi.c | 25 ++++++++++++++++++++-----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index 3e44d2fb8bf8..babf1b9a4dbe 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
>> @@ -57,6 +57,8 @@ asm volatile(ALTERNATIVE(						\
>>   PMU_FORMAT_ATTR(event, "config:0-47");
>>   PMU_FORMAT_ATTR(firmware, "config:63");
>>   
>> +static bool sbi_v2_available;
>> +
>>   static struct attribute *riscv_arch_formats_attr[] = {
>>   	&format_attr_event.attr,
>>   	&format_attr_firmware.attr,
>> @@ -511,19 +513,29 @@ static u64 pmu_sbi_ctr_read(struct perf_event *event)
>>   	struct hw_perf_event *hwc = &event->hw;
>>   	int idx = hwc->idx;
>>   	struct sbiret ret;
>> -	union sbi_pmu_ctr_info info;
>>   	u64 val = 0;
>> +	union sbi_pmu_ctr_info info = pmu_ctr_list[idx];
>>   
>>   	if (pmu_sbi_is_fw_event(event)) {
>>   		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
>>   				hwc->idx, 0, 0, 0, 0, 0);
>> -		if (!ret.error)
>> -			val = ret.value;
>> +		if (ret.error)
>> +			return 0;
>> +
>> +		val = ret.value;
>> +		if (IS_ENABLED(CONFIG_32BIT) && sbi_v2_available && info.width >= 32) {
>> +			ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ_HI,
>> +					hwc->idx, 0, 0, 0, 0, 0);
>> +			if (!ret.error)
>> +				val |= ((u64)ret.value << 32);
>> +			else
>> +				WARN_ONCE(1, "Unable to read upper 32 bits of firmware counter error: %d\n",
>> +					  sbi_err_map_linux_errno(ret.error));
> 
> I don't think we should use sbi_err_map_linux_errno() in this case since
> we don't have a 1:1 mapping of SBI errors to Linux errors and we don't
> propagate the error as a Linux error. For warnings, it's better to output
> the exact SBI error.
> 

Sure. Fixed it.

>> +		}
>>   	} else {
>> -		info = pmu_ctr_list[idx];
>>   		val = riscv_pmu_ctr_read_csr(info.csr);
>>   		if (IS_ENABLED(CONFIG_32BIT))
>> -			val = ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 31 | val;
>> +			val |= ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 32;
>>   	}
>>   
>>   	return val;
>> @@ -1135,6 +1147,9 @@ static int __init pmu_sbi_devinit(void)
>>   		return 0;
>>   	}
>>   
>> +	if (sbi_spec_version >= sbi_mk_version(2, 0))
>> +		sbi_v2_available = true;
>> +
>>   	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
>>   				      "perf/riscv/pmu:starting",
>>   				      pmu_sbi_starting_cpu, pmu_sbi_dying_cpu);
>> -- 
>> 2.34.1
>>
> 
> Thanks,
> drew


