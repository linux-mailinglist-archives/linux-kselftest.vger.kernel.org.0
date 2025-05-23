Return-Path: <linux-kselftest+bounces-33667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725ECAC293E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 20:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9789A165E9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 18:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3868221736;
	Fri, 23 May 2025 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cb6ir8xE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BBE21ABD3
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748023351; cv=none; b=adj+1CpcEfccBd8bbnfVGGf/YgsN6JFoS9JApVEUjZIle6WUeXc2eTeRcLyDaiY+xvw8H01KjmVfpa1NpNVJHiRLCth64hUPG8HAq3Rgfz9LuhregrqCRGHRUAtqPIyxJAAyDdgh4Aedu4WGLFUFgr/tZSnndA0bK4PG5C+aLE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748023351; c=relaxed/simple;
	bh=/IJS+eg31HVMWiLhSeRqgdbO7HyM9IVVNSvfwS9h97Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDGS7aAHi4r7FpiSVSIG0hchZGtHXNJASGayVajv/1ZU/QvLIE3dNqRbWhaiSB6o7Sw0rNbS6VE70fNwmf3EyZCyGrTyoR+qJJFWCAspaVgKclfhHaDE3KefJzX155wYvkwWyoiwnKOCtXI8nz/5rFSwZ0SU9uKw5xbLDh+lCXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cb6ir8xE; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5dd587b3-8c04-41d1-b677-5b07266cfec5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748023337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVgfGwkpVOgVzuNCU5zCPpN93of0x7k+aYCz5DP0VOA=;
	b=cb6ir8xE4q8LN9CRbizpHOwYHG/1HnOlKRh3ajaE1tDkmTd8L19cu4lPf8tqbFVowAvU7o
	37f+G4WGNnNmva62kOAHzlLog/TeUa+vG94ciSfJV4Agz/wUc+d1DCUpdSbMrQe4M9rbRz
	+MQCdF0ERsqq1cCkeU0V+ucqdayBGaM=
Date: Fri, 23 May 2025 11:02:11 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 13/14] RISC-V: KVM: add support for FWFT SBI extension
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>, Deepak Gupta <debug@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 linux-riscv <linux-riscv-bounces@lists.infradead.org>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
 <20250523101932.1594077-14-cleger@rivosinc.com>
 <DA3K95ZYJ52S.1K6O3LN6WEI0N@ventanamicro.com>
 <9f9e2869-725d-4590-887a-9b0ef091472e@rivosinc.com>
 <DA3OJ7WWUGLT.35AVP0QQDJRZV@ventanamicro.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <DA3OJ7WWUGLT.35AVP0QQDJRZV@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/23/25 9:27 AM, Radim KrÄmÃ¡Å wrote:
> 2025-05-23T17:29:49+02:00, Clément Léger <cleger@rivosinc.com>:
>> On 23/05/2025 15:05, Radim Krčmář wrote:
>>> 2025-05-23T12:19:30+02:00, Clément Léger <cleger@rivosinc.com>:
>>>> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
>>>> +static const enum sbi_fwft_feature_t kvm_fwft_defined_features[] = {
>>>> +	SBI_FWFT_MISALIGNED_EXC_DELEG,
>>>> +	SBI_FWFT_LANDING_PAD,
>>>> +	SBI_FWFT_SHADOW_STACK,
>>>> +	SBI_FWFT_DOUBLE_TRAP,
>>>> +	SBI_FWFT_PTE_AD_HW_UPDATING,
>>>> +	SBI_FWFT_POINTER_MASKING_PMLEN,
>>>> +};
>>>
>>> How will userspace control which subset of these features is allowed in
>>> the guest?
>>>
>>> (We can reuse the KVM SBI extension interface if we don't want to add a
>>>   FWFT specific ONE_REG.)
>>
>> Hi Radim,
>>
>> I didn't looked at that part. But most likely using the kvm one reg
>> interface seems ok like what is done for STA ? We could have per feature
>> override with one reg per feature.
> 
> Sounds fine.
> 

Yeah. We can have a follow up series for SBI FWFT state that allows user 
space to toggle each state individually.

>> Is this something blocking though ? We'd like to merge FWFT once SBI 3.0
>> is ratified so that would be nice not delaying it too much. I'll take a
>> look at it to see if it isn't too long to implement.
> 
> Not blocking, but I would at least default FWFT to disabled, because
> current userspace cannot handle [14/14].  (Well... save/restore was
> probably broken even before, but let's try to not make it worse. :])
> 

User space can not enable or disable misaligned access delegation as 
there is no interface for now rightly pointed by you. I guess supporting 
that would be quicker than fixing the broader guest save/restore 
anyways. Isn't it ?

We can have the patches ready for the next MW for FWFT one reg interface.

> Thanks.
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


