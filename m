Return-Path: <linux-kselftest+bounces-29024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B0CA60FDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 12:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68073882963
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 11:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6CF1FECB7;
	Fri, 14 Mar 2025 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bqbPhERJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544101FE457
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951290; cv=none; b=EnVzGGvMWAtV92FGov/ReAyl72na+SXfXP5jxg7cBNvRSgepsk4GZkm7Jrx9ekP3Y1I9wUsF113Bn8W7Wj6fMwKCcxo89pmLwPh2qCiItRfgZlACMGwFbOiU/blK1ke73Vtbpn9OCBEXc9X7NclFBhc1YzJ4DBXzkxsMAosG2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951290; c=relaxed/simple;
	bh=CxQhkQEHcVp50sqGLhhVeW5rEWOlyU0IM4BxFtlaXac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtA4K+RwPD3ic8ZYpQHnGNLg2UyH03VJjxA93CQ3afELzUJ0FY9xeC40uEQ+VwRqWs6SUFFptvLUcSOexkTd9fzM9/yFHS9WVckEADG4gmctKShAFD3Ga3EDfL8QVEa7zHNwMuIouMARY3SZVPjqMmOAjhehOW9jfRzBxW71xu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bqbPhERJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so17671045e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 04:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741951286; x=1742556086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6XtzYhqUw84uSezb9doRczkUr+a5kXQaPrl1FQvJuA=;
        b=bqbPhERJhaprC4ZfVm+Gk5HBFmD7bbvxPLmobJO2El7zfnDpyfiecoHumIqThd1N9M
         iBBL+b5bpcuY3EbOAzIPRvhW6Vd16Pa5IaRf/lZRJCqYAT8Ts4AKezOLRvVj5ELk4xT3
         wPjLpNH8Vegf/e0OyB9D2d8KG1ycm1+VV6Odtbi7kgtyhawG31/6qmxoLret/r15zUnD
         PtaQSzLbbjcrthDqFSCSdvkRed7WGWe6TLrwFb+Ovn7UfGss3YVastAAicQQQlaMDxd/
         75SVmd80NoiH13GOgyzR0zBqCR/1nTfZeNzHJag0+8yj4wzntj2OyXJ7bTp0x7gPdY86
         UPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741951286; x=1742556086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6XtzYhqUw84uSezb9doRczkUr+a5kXQaPrl1FQvJuA=;
        b=uMWyAZ/hdKonvwtSEFMUNWKYGdVqWzKiHO1T6xlETkuC5tgRWZBrBiep49IPTgtMRb
         q6j4R3AyMAoge1+hNxNQLZ59kXLzdDRuym0OM0t8/0pP3/u4wvb1/y1OlWgoIYZJrnfo
         3b19OE36dc2mDFafJymCvB2YFC9gG7ZAFEVgd1S0j/E7eImU0Wp2Ac+F7RMg7SSYTbT6
         JbwTEcu2IIR4gAkrwoxbBF+1CtG3hfVYuC7bdUiCEex/mHVSSIRDn0+3xv5dQOdIZ7Nb
         foJTZakJpJC+fc84W4pouOPbnak3+snPSSU6WILvLCpdJPOcKBIccknKb6zGGc+uZZYq
         lkVA==
X-Forwarded-Encrypted: i=1; AJvYcCWfQ85UwnonyxQbQ9wlv1XD4R64RyHQ0UINfF4SfffanWi4hCMOvbeR65n+fK3C+BmilUJZvqMByfdeby2o2Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywEH4FhsofVZ1KsPbiK7HQBuQfg1WT8O0CuONAxp/4nc89zDav
	Ub9DtGQ0H0vmdu9uT9a0fkORt1g2O2emrLI1YZyd1MJ61vQbQWpaVjyn7zo6hn4=
X-Gm-Gg: ASbGnctYNbSJMUtUpZhcgJtgLFcmkU/69ur02PTPcsmqggPb129VJ46usxkJP/Q/mAW
	ewFvBXG4d3cPOgYXpJcV5MJQ4FEFrgt6FthlFV4CSsfhix6Ymcyedy7F0TKii2FaQhPrdJ35ebm
	BDEiAw5WKi8spnNmp+cd3cpCV89XoTkSqd8QBPTqmCr1nmxCG2HQDL1FTNo9GX/Y7Nvv+9mGjcF
	N2oIiethJH/yQFtwoGVYc3ChZGyDRIEljm0SM+h6u2I0hlpTbd9fOsvxRIQh0HQ24sVZcDKYv5y
	Q3T3ejLBtodWzeeeUihpQsikDaxl0zYdNGGFEd1jOOgpTYwBKtK/OZ+A27AV8HmwuGA4IH0DbxT
	6GG4k6FyxqbjnMg==
X-Google-Smtp-Source: AGHT+IEYaWqqZpuQnf2ljZyi0dtBkuDfK6pK0aoroD3vMSUCfCqdnElivAtTAt81Xq+zCSEqCysJ0Q==
X-Received: by 2002:a05:600c:190e:b0:43c:f513:9585 with SMTP id 5b1f17b1804b1-43d1ec808ebmr27086195e9.13.1741951285516;
        Fri, 14 Mar 2025 04:21:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fac7asm14341405e9.28.2025.03.14.04.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 04:21:25 -0700 (PDT)
Message-ID: <c411446b-e161-48fa-a94b-e04c00f62b01@rivosinc.com>
Date: Fri, 14 Mar 2025 12:21:24 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/17] riscv: sbi: add SBI FWFT extension calls
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-4-cleger@rivosinc.com>
 <20250313-ce439653d16b484dba6a8d3e@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250313-ce439653d16b484dba6a8d3e@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 13/03/2025 13:44, Andrew Jones wrote:
> On Mon, Mar 10, 2025 at 04:12:10PM +0100, Clément Léger wrote:
>> Add FWFT extension calls. This will be ratified in SBI V3.0 hence, it is
>> provided as a separate commit that can be left out if needed.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/kernel/sbi.c | 30 ++++++++++++++++++++++++++++--
>>  1 file changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
>> index 256910db1307..af8e2199e32d 100644
>> --- a/arch/riscv/kernel/sbi.c
>> +++ b/arch/riscv/kernel/sbi.c
>> @@ -299,9 +299,19 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>>  	return 0;
>>  }
>>  
>> +static bool sbi_fwft_supported;
>> +
>>  int sbi_fwft_get(u32 feature, unsigned long *value)
>>  {
>> -	return -EOPNOTSUPP;
>> +	struct sbiret ret;
>> +
>> +	if (!sbi_fwft_supported)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = sbi_ecall(SBI_EXT_FWFT, SBI_EXT_FWFT_GET,
>> +			feature, 0, 0, 0, 0, 0);
>> +
>> +	return sbi_err_map_linux_errno(ret.error);
>>  }
>>  
>>  /**
>> @@ -314,7 +324,15 @@ int sbi_fwft_get(u32 feature, unsigned long *value)
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
> 
> sbi_err_map_linux_errno() doesn't know about SBI_ERR_DENIED_LOCKED.

Not only it doesn't knows about DENIED_LOCKED but also another bunch of
errors. I'll add them in a separate commit.

> 
>>  }
>>  
>>  struct fwft_set_req {
>> @@ -389,6 +407,9 @@ static int sbi_fwft_feature_local_set(u32 feature, unsigned long value,
>>  int sbi_fwft_all_cpus_set(u32 feature, unsigned long value, unsigned long flags,
>>  			  bool revert_on_fail)
>>  {
>> +	if (!sbi_fwft_supported)
>> +		return -EOPNOTSUPP;
>> +
>>  	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
>>  		return sbi_fwft_set(feature, value, flags);
>>  
>> @@ -719,6 +740,11 @@ void __init sbi_init(void)
>>  			pr_info("SBI DBCN extension detected\n");
>>  			sbi_debug_console_available = true;
>>  		}
>> +		if ((sbi_spec_version >= sbi_mk_version(2, 0)) &&
> 
> Should check sbi_mk_version(3, 0)

Oh yes that was for testing purpose and I incorrectly squashed it.

> 
>> +		    (sbi_probe_extension(SBI_EXT_FWFT) > 0)) {
>> +			pr_info("SBI FWFT extension detected\n");
>> +			sbi_fwft_supported = true;
>> +		}
>>  	} else {
>>  		__sbi_set_timer = __sbi_set_timer_v01;
>>  		__sbi_send_ipi	= __sbi_send_ipi_v01;
>> -- 
>> 2.47.2
>>
> 

Thanks,

Clément

> Thanks,
> drew


