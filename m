Return-Path: <linux-kselftest+bounces-7443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4652589CF41
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 02:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37E81F21FE8
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 00:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4090B389;
	Tue,  9 Apr 2024 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="t6hfHAYV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FAE19B
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Apr 2024 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622006; cv=none; b=mDkHwOmujLrlpMqyAuLFGsn5ZaRkGS49bVwRVKthdpWrLx0CjYabnb8vDq5CCKYrza6qP42aQwe9UodynmBYQ008Ry8/PWfUxxjxLLjLy/yti/idUtZshjDPRVfN+byyTc0kajHrKDksFS+86wBvxOF6MCYo7r2NcLPM/QQrBAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622006; c=relaxed/simple;
	bh=7AyJE+Ynxw1W3Oop+jkW2MDTcjqw7F9xUTd+5z52JAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHbILyShwhS01pyWDdAjAQSqsvyLyyoCTVK+m861DXhhXzzt8Jm9S08B7YTjdjfnsKUxixlF1+PWg7QUVp+tkftw52+T3GV+T2pUNjr/s3blFRNB0wKQ1007Jr1CryfyCtbtrBAYtHgfP1wUk6jdU6hLsFPlOPTh3QIEo1iIdRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=t6hfHAYV; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ecf8ebff50so3027320b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Apr 2024 17:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712622004; x=1713226804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJJm0YinR6Fz1JQTj6m9HJC7BJLubttssqp1IhI/OVY=;
        b=t6hfHAYVV0N2oSkEDZTbLXE68ltwkqsRbF7GAF95khFXygtm43m8BFcjGXWk1yuu10
         ZR+uIUr7QBbsBf4gEygKbUPVpPnhQcwLG/H/C585ERn04Qcbl+TRkzWbhKqkR+eoCTF/
         6ou9tIWstBJV1owuQiHpeagkUg80/AkGpYk5ykYBXjwdFAtbfxjcLYvUJ3YUxzUHoTP/
         uXpH8PVu9lvkvdXm1b3rrf3sU49LhgECiergtHayLB0OLA8HcE1fQdLeOe7QRKChgfv3
         J9VnGBkYhmYmcDUNrh7W19e3uV1y02QgFVBvm2CGvqUrm5JnKZzmzZmUWVGBijeUVYRt
         hGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622004; x=1713226804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJJm0YinR6Fz1JQTj6m9HJC7BJLubttssqp1IhI/OVY=;
        b=GY3CD7wO+OqORQlpmFYQIyYHhOpc3BBLAa9i+iCw9+Q4DrbQTDoAN+sXcbaUVdWrwO
         dEv313sACNyoWLzeTq6XeBBEIsUbjBx0biM6Nk63oeM+ocnLRUiWrJz1w7rlrYJYU63Q
         MGEix+4FGTNiUv1ISSYGurG+CQu9FJUJZkg1HQpoG2e5zuGpcDtCr6ZrbDhY2HafNjz/
         sMMtXemBAQ01yPBdBO9hwFHQhJroZGQhpGL+MnTZxujd08MLo81Z3Cj9tVTOogW2dc/u
         jDeW5JTWkqPIpbo8sS8FiCRTIYY0+MmMA3Qj9grXYysxv5sCAfnGg3VCvpoDlj9Sl+DS
         eZrg==
X-Forwarded-Encrypted: i=1; AJvYcCVt/0MD4RNzyzO6EKw+PvaOagZ82xjnxZHivGjRGikm3NtdCa0xn7qVaSd8B44qB/7BC8TtmJgvhvaGZNRmN/FOafCOEFEMTtXmp8TFCBgC
X-Gm-Message-State: AOJu0YypKbFLWsQXhjQQJLZOuTwpIMzq8QmDDJ34VN0B1vtpyX+OFBNS
	dNpKOZMwWdyGfAXkSo1MPCFjourkdUXez4HzHkrVI2vUiCjkbaeHqFstblwnQaY=
X-Google-Smtp-Source: AGHT+IHKlLChws6cu3BYTCJ7MCM6PzdBML/rgAzu6AAweXKWc1ZvRCFZaiBR3BYcpCZV7gSpWy06EQ==
X-Received: by 2002:a05:6a21:199:b0:1a7:9e84:dc51 with SMTP id le25-20020a056a21019900b001a79e84dc51mr1952924pzb.7.1712622003695;
        Mon, 08 Apr 2024 17:20:03 -0700 (PDT)
Received: from ?IPV6:2601:647:4180:9630::e8c1? ([2601:647:4180:9630::e8c1])
        by smtp.gmail.com with ESMTPSA id y22-20020a056a00181600b006ed0b798f1fsm5677375pfa.119.2024.04.08.17.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 17:20:02 -0700 (PDT)
Message-ID: <be088afd-923e-4aed-a786-5398e46c05f5@rivosinc.com>
Date: Mon, 8 Apr 2024 17:20:01 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/22] drivers/perf: riscv: Use BIT macro for shifting
 operations
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <akaher@vmware.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Alexey Makhalov <amakhalov@vmware.com>, Anup Patel <anup@brainfault.org>,
 Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Will Deacon <will@kernel.org>, x86@kernel.org
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-5-atishp@rivosinc.com>
 <20240404-9a84f2090d00f6b994e1de7c@orel>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240404-9a84f2090d00f6b994e1de7c@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 04:08, Andrew Jones wrote:
> On Wed, Apr 03, 2024 at 01:04:33AM -0700, Atish Patra wrote:
>> It is a good practice to use BIT() instead of (1UL << x).
> 
> (1UL << x) isn't generally a problem. The problem is with (1 << x).
> 

Yes. That's why, the commit message said it's good to have :)
I improved the commit message to specify about 1 << x as well.

>> Replace the current usages with BIT().
>>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   arch/riscv/include/asm/sbi.h | 20 ++++++++++----------
>>   drivers/perf/riscv_pmu_sbi.c |  2 +-
>>   2 files changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>> index ef8311dafb91..4afa2cd01bae 100644
>> --- a/arch/riscv/include/asm/sbi.h
>> +++ b/arch/riscv/include/asm/sbi.h
>> @@ -233,20 +233,20 @@ enum sbi_pmu_ctr_type {
>>   #define SBI_PMU_EVENT_IDX_INVALID 0xFFFFFFFF
>>   
>>   /* Flags defined for config matching function */
>> -#define SBI_PMU_CFG_FLAG_SKIP_MATCH	(1 << 0)
>> -#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	(1 << 1)
>> -#define SBI_PMU_CFG_FLAG_AUTO_START	(1 << 2)
>> -#define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 3)
>> -#define SBI_PMU_CFG_FLAG_SET_VSINH	(1 << 4)
>> -#define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
>> -#define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 6)
>> -#define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 7)
>> +#define SBI_PMU_CFG_FLAG_SKIP_MATCH	BIT(0)
>> +#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	BIT(1)
>> +#define SBI_PMU_CFG_FLAG_AUTO_START	BIT(2)
>> +#define SBI_PMU_CFG_FLAG_SET_VUINH	BIT(3)
>> +#define SBI_PMU_CFG_FLAG_SET_VSINH	BIT(4)
>> +#define SBI_PMU_CFG_FLAG_SET_UINH	BIT(5)
>> +#define SBI_PMU_CFG_FLAG_SET_SINH	BIT(6)
>> +#define SBI_PMU_CFG_FLAG_SET_MINH	BIT(7)
>>   
>>   /* Flags defined for counter start function */
>> -#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
>> +#define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
>>   
>>   /* Flags defined for counter stop function */
>> -#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
>> +#define SBI_PMU_STOP_FLAG_RESET BIT(0)
>>   
>>   enum sbi_ext_dbcn_fid {
>>   	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index babf1b9a4dbe..a83ae82301e3 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
>> @@ -386,7 +386,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
>>   			cmask = 1;
>>   		} else if (event->attr.config == PERF_COUNT_HW_INSTRUCTIONS) {
>>   			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
>> -			cmask = 1UL << (CSR_INSTRET - CSR_CYCLE);
>> +			cmask = BIT(CSR_INSTRET - CSR_CYCLE);
>>   		}
>>   	}
>>   
>> -- 
>> 2.34.1
>>
> 
> Other than the commit message,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Thanks,
> drew


