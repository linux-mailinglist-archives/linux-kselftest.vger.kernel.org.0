Return-Path: <linux-kselftest+bounces-9112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F8E8B6B50
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 09:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38371F227FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 07:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C760937719;
	Tue, 30 Apr 2024 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BudeoV1n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F13179BE
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461533; cv=none; b=G+1hF/4OVvBjv2TJagrdXwxiTZuwGvdUUd8kDhmKNq+4UbRXtVRjTDhdoakqTYYcN6nimMUdfhYhTLZvYmOJqgOqRJOxcS8zXTQYXA7hkMXbkukyx4FNIIFVC9aU67B0ftGQcnzCxSIxyLNi4wO0d1ZmfbZskAmLf/sc9LWYxTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461533; c=relaxed/simple;
	bh=sMc4WZcZUeHtIgXYqQBjLbl/GUmQ1JDtx07Fg0nFR8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=megb4qjPGk8lsU8Ao6TeSnWot3yY9oZBUdlP68P1+okVdHCeyPrSjSKFrKHsvfh3ssiDaZFS77e53RyJURAUjE5eTtja6WxfSe2bEtg/nfRWh6ErK0IFSyixP1mPLTzzdEAE5ksCNsWiqlhZCBsSjFvx7nGr4K7QLjmL9GxhKO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BudeoV1n; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41c02fb8cebso1734745e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 00:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714461530; x=1715066330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DFOA47pYt83bMvIpv2bCMuSr/+A8ku+7xtbTJXLGrLA=;
        b=BudeoV1nH7uwVd+7ByzAc27p6fttfCdzb34+Pwuo1Ss21wbl3FnDBceISV0qUj/2V2
         3PnFievIhS5Z4kIub6MJpNyHCmqQO8w40qQUAZmHNEAAlf2bR8XeWU5XQcDhsMRNgnUN
         PTzJScnUnREfcOlnyxxftr5oa/Dvttk+Ga9G8FXQ28wLkTFPAS5h7gscu9/2xUHp/ML/
         qZw25RIR4kGZFVjfEO5ISeezw56bssy8W1qLbdnlrVgXxTzrB8Wbn2s2C3y/2EVOFMgK
         G41BOnThlkAtDB9QPzjD9XT4kUDF1ycAldkKlTyBeIT1XVlkknxn/xyW2Qnglrki40xX
         ZBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714461530; x=1715066330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFOA47pYt83bMvIpv2bCMuSr/+A8ku+7xtbTJXLGrLA=;
        b=KUrETmhoDKgP9+ViFYkdzAX2jFl+YjfrA4uCPBa/sGik9C4D4mIxGTVZ+5oKIGd7Ev
         46FkBRC73K1QAIWFVaULj0XJKAbjEgU/8X7ZEu3qSNQs8IxMhtXeLqkqlLGca8BXz36W
         8DtK+1jwyiQa/we2ERKDgLx2eQnYnTzT+xiqKMuyBjuLlwIizrvtnVCiBZi01QOp2VrA
         yAJ2NtF73GzdXhng42k+axCY8Lbju72LhgwF3YrSE31Up5MXaUH8KN0h1XW87zV+7utk
         lqIVjKU9ty+APuiv4WDt1+FBSQfa8sZQgl8OILR/lfxPH1aJ72QfanU3sOch7GhIG6Zb
         wYKw==
X-Forwarded-Encrypted: i=1; AJvYcCVYc/oE8Sxue3hFRHIZcftTQKJZG0lYCwG2GWlSeRhJuTAt48hoBGCUJ20dDEWNZXlkLNOd5DiiC3buEVTQyLXJWPG91WFkqRdqemLTqWII
X-Gm-Message-State: AOJu0YxWRV7bsiueWkMWyKubCt6f9e3HYGvOLkfn3sTkQuxAVzjuLvz7
	Y2Ni6DcwrBPoRkpKxXMgiweHnv/9PzbzQPfVQCntj+jfkZjBziK/jMpi8Q5XEIM=
X-Google-Smtp-Source: AGHT+IEg+ywRvlwQvwVo0sNKmOppHrYG3FZGGsVxdHy8+YK4rRcPsEzVD91jPuUYMwuYIVvBgYRBqQ==
X-Received: by 2002:a5d:47a2:0:b0:34d:1d1a:2dc7 with SMTP id 2-20020a5d47a2000000b0034d1d1a2dc7mr4069136wrb.6.1714461529580;
        Tue, 30 Apr 2024 00:18:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:c21b:67fd:90ab:9053? ([2a01:e0a:999:a3a0:c21b:67fd:90ab:9053])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d4d8a000000b0034cf989dbf5sm5170282wru.44.2024.04.30.00.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 00:18:49 -0700 (PDT)
Message-ID: <5d5febd5-d113-4e8c-9535-9e75acf23398@rivosinc.com>
Date: Tue, 30 Apr 2024 09:18:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] riscv: add ISA extensions validation
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
 Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <20240429150553.625165-1-cleger@rivosinc.com>
 <20240429150553.625165-3-cleger@rivosinc.com>
 <20240429-subtext-tabby-3a1532f058a5@spud>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240429-subtext-tabby-3a1532f058a5@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/04/2024 00:15, Conor Dooley wrote:
> On Mon, Apr 29, 2024 at 05:04:55PM +0200, Clément Léger wrote:
>> Since a few extensions (Zicbom/Zicboz) already needs validation and
>> future ones will need it as well (Zc*) add a validate() callback to
>> struct riscv_isa_ext_data. This require to rework the way extensions are
>> parsed and split it in two phases. First phase is isa string or isa
>> extension list parsing and consists in enabling all the extensions in a
>> temporary bitmask without any validation. The second step "resolves" the
>> final isa bitmap, handling potential missing dependencies. The mechanism
>> is quite simple and simply validate each extension described in the
>> temporary bitmap before enabling it in the final isa bitmap. validate()
>> callbacks can return either 0 for success, -EPROBEDEFER if extension
>> needs to be validated again at next loop. A previous ISA bitmap is kept
>> to avoid looping mutliple times if an extension dependencies are never
>> satisfied until we reach a stable state. In order to avoid any potential
>> infinite looping, allow looping a maximum of the number of extension we
>> handle. Zicboz and Zicbom extensions are modified to use this validation
>> mechanism.
> 
> Your reply to my last review only talked about part of my comments,
> which is usually what you do when you're gonna implement the rest, but
> you haven't.
> I like the change you've made to shorten looping, but I'd at least like
> a response to why a split is not worth doing :)

Hi Conor,

Missed that point since I was feeling that my solution actually
addresses your concerns. Your argument was that there is no reason to
loop for Zicbom/Zicboz but that would also apply to Zcf in case we are
on RV64 as well (since zcf is not supported on RV64). So for Zcf, that
would lead to using both mecanism or additional ifdefery with little to
no added value since the current solution actually solves both cases:

- We don't have any extra looping if all validation callback returns 0
(except the initial one on riscv_isa_ext, which is kind of unavoidable).
- Zicbom, Zicboz callbacks will be called only once (which was one of
your concern).

Adding a second kind of callback for after loop validation would only
lead to a bunch of additional macros/ifdefery for extensions with
validate() callback, with validate_end() or with both (ie Zcf)). For
these reasons, I do not think there is a need for a separate mechanism
nor additional callback for such extensions except adding extra code
with no real added functionality.

AFAIK, the platform driver probing mechanism works the same, the probe()
callback is actually called even if for some reason properties are
missing from nodes for platform devices and thus the probe() returns
-EINVAL or whatever.

Hope this answers your question,

Thanks,

Clément

> 
> Thanks,
> Conor.
> 
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/cpufeature.h |   1 +
>>  arch/riscv/kernel/cpufeature.c      | 211 ++++++++++++++++------------
>>  2 files changed, 126 insertions(+), 86 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>> index 347805446151..000796c2d0b1 100644
>> --- a/arch/riscv/include/asm/cpufeature.h
>> +++ b/arch/riscv/include/asm/cpufeature.h
>> @@ -70,6 +70,7 @@ struct riscv_isa_ext_data {
>>  	const char *property;
>>  	const unsigned int *subset_ext_ids;
>>  	const unsigned int subset_ext_size;
>> +	int (*validate)(const struct riscv_isa_ext_data *data, const unsigned long *isa_bitmap);
>>  };
>>  
>>  extern const struct riscv_isa_ext_data riscv_isa_ext[];
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 115ba001f1bc..cb2ffa6c8c33 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -72,51 +72,58 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned i
>>  }
>>  EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
>>  
>> -static bool riscv_isa_extension_check(int id)
>> +static bool riscv_isa_extension_valid(int id)
>>  {
>> -	switch (id) {
>> -	case RISCV_ISA_EXT_ZICBOM:
>> -		if (!riscv_cbom_block_size) {
>> -			pr_err("Zicbom detected in ISA string, disabling as no cbom-block-size found\n");
>> -			return false;
>> -		} else if (!is_power_of_2(riscv_cbom_block_size)) {
>> -			pr_err("Zicbom disabled as cbom-block-size present, but is not a power-of-2\n");
>> -			return false;
>> -		}
>> -		return true;
>> -	case RISCV_ISA_EXT_ZICBOZ:
>> -		if (!riscv_cboz_block_size) {
>> -			pr_err("Zicboz detected in ISA string, disabling as no cboz-block-size found\n");
>> -			return false;
>> -		} else if (!is_power_of_2(riscv_cboz_block_size)) {
>> -			pr_err("Zicboz disabled as cboz-block-size present, but is not a power-of-2\n");
>> -			return false;
>> -		}
>> -		return true;
>> -	case RISCV_ISA_EXT_INVALID:
>> -		return false;
>> +	return id != RISCV_ISA_EXT_INVALID;
>> +}
>> +
>> +static int riscv_ext_zicbom_validate(const struct riscv_isa_ext_data *data,
>> +				     const unsigned long *isa_bitmap)
>> +{
>> +	if (!riscv_cbom_block_size) {
>> +		pr_err("Zicbom detected in ISA string, disabling as no cbom-block-size found\n");
>> +		return -EINVAL;
>> +	} else if (!is_power_of_2(riscv_cbom_block_size)) {
>> +		pr_err("Zicbom disabled as cbom-block-size present, but is not a power-of-2\n");
>> +		return -EINVAL;
>>  	}
>> +	return 0;
>> +}
>>  
>> -	return true;
>> +static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
>> +				     const unsigned long *isa_bitmap)
>> +{
>> +	if (!riscv_cboz_block_size) {
>> +		pr_err("Zicboz detected in ISA string, disabling as no cboz-block-size found\n");
>> +		return -EINVAL;
>> +	} else if (!is_power_of_2(riscv_cboz_block_size)) {
>> +		pr_err("Zicboz disabled as cboz-block-size present, but is not a power-of-2\n");
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>>  }
>>  
>> -#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size) {	\
>> -	.name = #_name,								\
>> -	.property = #_name,							\
>> -	.id = _id,								\
>> -	.subset_ext_ids = _subset_exts,						\
>> -	.subset_ext_size = _subset_exts_size					\
>> +#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size, _validate) {	\
>> +	.name = #_name,									\
>> +	.property = #_name,								\
>> +	.id = _id,									\
>> +	.subset_ext_ids = _subset_exts,							\
>> +	.subset_ext_size = _subset_exts_size,						\
>> +	.validate = _validate								\
>>  }
>>  
>> -#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0)
>> +#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, NULL)
>>  
>>  /* Used to declare pure "lasso" extension (Zk for instance) */
>>  #define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
>> -	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_SIZE(_bundled_exts))
>> +	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, \
>> +			    ARRAY_SIZE(_bundled_exts), NULL)
>>  
>>  /* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
>>  #define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
>> -	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
>> +	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), NULL)
>> +#define __RISCV_ISA_EXT_SUPERSET_VALIDATE(_name, _id, _sub_exts, _validate) \
>> +	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), _validate)
>>  
>>  static const unsigned int riscv_zk_bundled_exts[] = {
>>  	RISCV_ISA_EXT_ZBKB,
>> @@ -247,8 +254,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>>  	__RISCV_ISA_EXT_DATA(c, RISCV_ISA_EXT_c),
>>  	__RISCV_ISA_EXT_DATA(v, RISCV_ISA_EXT_v),
>>  	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
>> -	__RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts),
>> -	__RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts),
>> +	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts,
>> +					  riscv_ext_zicbom_validate),
>> +	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
>> +					  riscv_ext_zicboz_validate),
>>  	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
>>  	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
>>  	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
>> @@ -310,33 +319,80 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>>  
>>  const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
>>  
>> -static void __init match_isa_ext(const struct riscv_isa_ext_data *ext, const char *name,
>> -				 const char *name_end, struct riscv_isainfo *isainfo)
>> +static void riscv_isa_set_ext(const struct riscv_isa_ext_data *ext, unsigned long *bitmap)
>>  {
>> -	if ((name_end - name == strlen(ext->name)) &&
>> -	     !strncasecmp(name, ext->name, name_end - name)) {
>> -		/*
>> -		 * If this is a bundle, enable all the ISA extensions that
>> -		 * comprise the bundle.
>> -		 */
>> -		if (ext->subset_ext_size) {
>> -			for (int i = 0; i < ext->subset_ext_size; i++) {
>> -				if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
>> -					set_bit(ext->subset_ext_ids[i], isainfo->isa);
>> -			}
>> +	/*
>> +	 * This is valid even for bundle extensions which uses the RISCV_ISA_EXT_INVALID id
>> +	 * (rejected by riscv_isa_extension_valid()).
>> +	 */
>> +	if (riscv_isa_extension_valid(ext->id))
>> +		set_bit(ext->id, bitmap);
>> +
>> +	for (int i = 0; i < ext->subset_ext_size; i++) {
>> +		if (riscv_isa_extension_valid(ext->subset_ext_ids[i]))
>> +			set_bit(ext->subset_ext_ids[i], bitmap);
>> +	}
>> +}
>> +
>> +static void __init riscv_resolve_isa(unsigned long *isa_bitmap, struct riscv_isainfo *isainfo,
>> +				     unsigned long *this_hwcap, unsigned long *isa2hwcap)
>> +{
>> +	bool loop;
>> +	const struct riscv_isa_ext_data *ext;
>> +	DECLARE_BITMAP(prev_bitmap, RISCV_ISA_EXT_MAX);
>> +	int max_loop_count = riscv_isa_ext_count, ret;
>> +
>> +	do {
>> +		loop = false;
>> +		if (max_loop_count-- < 0) {
>> +			pr_err("Failed to reach a stable ISA state\n");
>> +			return;
>>  		}
>> +		memcpy(prev_bitmap, isainfo->isa, sizeof(prev_bitmap));
>> +		for (int i = 0; i < riscv_isa_ext_count; i++) {
>> +			ext = &riscv_isa_ext[i];
>> +
>> +			/* Bundle extensions ids are invalid*/
>> +			if (!riscv_isa_extension_valid(ext->id))
>> +				continue;
>> +
>> +			if (!test_bit(ext->id, isa_bitmap) || test_bit(ext->id, isainfo->isa))
>> +				continue;
>> +
>> +			if (ext->validate) {
>> +				ret = ext->validate(ext, isainfo->isa);
>> +				if (ret) {
>> +					if (ret == -EPROBE_DEFER)
>> +						loop = true;
>> +					else
>> +						clear_bit(ext->id, isa_bitmap);
>> +					continue;
>> +				}
>> +			}
>>  
>> -		/*
>> -		 * This is valid even for bundle extensions which uses the RISCV_ISA_EXT_INVALID id
>> -		 * (rejected by riscv_isa_extension_check()).
>> -		 */
>> -		if (riscv_isa_extension_check(ext->id))
>>  			set_bit(ext->id, isainfo->isa);
>> +
>> +			/* Only single letter extensions get set in hwcap */
>> +			if (ext->id < RISCV_ISA_EXT_BASE)
>> +				*this_hwcap |= isa2hwcap[ext->id];
>> +		}
>> +	} while (loop && memcmp(prev_bitmap, isainfo->isa, sizeof(prev_bitmap)));
>> +}
>> +
>> +static void __init match_isa_ext(const char *name, const char *name_end, unsigned long *bitmap)
>> +{
>> +	for (int i = 0; i < riscv_isa_ext_count; i++) {
>> +		const struct riscv_isa_ext_data *ext = &riscv_isa_ext[i];
>> +
>> +		if ((name_end - name == strlen(ext->name)) &&
>> +		    !strncasecmp(name, ext->name, name_end - name)) {
>> +			riscv_isa_set_ext(ext, bitmap);
>> +			break;
>> +		}
>>  	}
>>  }
>>  
>> -static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct riscv_isainfo *isainfo,
>> -					  unsigned long *isa2hwcap, const char *isa)
>> +static void __init riscv_resolve_isa_string(const char *isa, unsigned long *bitmap)
>>  {
>>  	/*
>>  	 * For all possible cpus, we have already validated in
>> @@ -349,7 +405,7 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
>>  	while (*isa) {
>>  		const char *ext = isa++;
>>  		const char *ext_end = isa;
>> -		bool ext_long = false, ext_err = false;
>> +		bool ext_err = false;
>>  
>>  		switch (*ext) {
>>  		case 's':
>> @@ -389,7 +445,6 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
>>  			 * character itself while eliminating the extensions version number.
>>  			 * A simple re-increment solves this problem.
>>  			 */
>> -			ext_long = true;
>>  			for (; *isa && *isa != '_'; ++isa)
>>  				if (unlikely(!isalnum(*isa)))
>>  					ext_err = true;
>> @@ -469,17 +524,8 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
>>  
>>  		if (unlikely(ext_err))
>>  			continue;
>> -		if (!ext_long) {
>> -			int nr = tolower(*ext) - 'a';
>>  
>> -			if (riscv_isa_extension_check(nr)) {
>> -				*this_hwcap |= isa2hwcap[nr];
>> -				set_bit(nr, isainfo->isa);
>> -			}
>> -		} else {
>> -			for (int i = 0; i < riscv_isa_ext_count; i++)
>> -				match_isa_ext(&riscv_isa_ext[i], ext, ext_end, isainfo);
>> -		}
>> +		match_isa_ext(ext, ext_end, bitmap);
>>  	}
>>  }
>>  
>> @@ -501,6 +547,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
>>  	for_each_possible_cpu(cpu) {
>>  		struct riscv_isainfo *isainfo = &hart_isa[cpu];
>>  		unsigned long this_hwcap = 0;
>> +		DECLARE_BITMAP(isa_bitmap, RISCV_ISA_EXT_MAX) = { 0 };
>>  
>>  		if (acpi_disabled) {
>>  			node = of_cpu_device_node_get(cpu);
>> @@ -523,7 +570,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
>>  			}
>>  		}
>>  
>> -		riscv_parse_isa_string(&this_hwcap, isainfo, isa2hwcap, isa);
>> +		riscv_resolve_isa_string(isa, isa_bitmap);
>>  
>>  		/*
>>  		 * These ones were as they were part of the base ISA when the
>> @@ -531,10 +578,10 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
>>  		 * unconditionally where `i` is in riscv,isa on DT systems.
>>  		 */
>>  		if (acpi_disabled) {
>> -			set_bit(RISCV_ISA_EXT_ZICSR, isainfo->isa);
>> -			set_bit(RISCV_ISA_EXT_ZIFENCEI, isainfo->isa);
>> -			set_bit(RISCV_ISA_EXT_ZICNTR, isainfo->isa);
>> -			set_bit(RISCV_ISA_EXT_ZIHPM, isainfo->isa);
>> +			set_bit(RISCV_ISA_EXT_ZICSR, isa_bitmap);
>> +			set_bit(RISCV_ISA_EXT_ZIFENCEI, isa_bitmap);
>> +			set_bit(RISCV_ISA_EXT_ZICNTR, isa_bitmap);
>> +			set_bit(RISCV_ISA_EXT_ZIHPM, isa_bitmap);
>>  		}
>>  
>>  		/*
>> @@ -548,9 +595,11 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
>>  		if (acpi_disabled && riscv_cached_mvendorid(cpu) == THEAD_VENDOR_ID &&
>>  		    riscv_cached_marchid(cpu) == 0x0) {
>>  			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_v];
>> -			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
>> +			clear_bit(RISCV_ISA_EXT_v, isa_bitmap);
>>  		}
>>  
>> +		riscv_resolve_isa(isa_bitmap, isainfo, &this_hwcap, isa2hwcap);
>> +
>>  		/*
>>  		 * All "okay" hart should have same isa. Set HWCAP based on
>>  		 * common capabilities of every "okay" hart, in case they don't
>> @@ -579,6 +628,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
>>  		unsigned long this_hwcap = 0;
>>  		struct device_node *cpu_node;
>>  		struct riscv_isainfo *isainfo = &hart_isa[cpu];
>> +		DECLARE_BITMAP(isa_bitmap, RISCV_ISA_EXT_MAX) = { 0 };
>>  
>>  		cpu_node = of_cpu_device_node_get(cpu);
>>  		if (!cpu_node) {
>> @@ -598,22 +648,11 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
>>  						     ext->property) < 0)
>>  				continue;
>>  
>> -			if (ext->subset_ext_size) {
>> -				for (int j = 0; j < ext->subset_ext_size; j++) {
>> -					if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
>> -						set_bit(ext->subset_ext_ids[j], isainfo->isa);
>> -				}
>> -			}
>> -
>> -			if (riscv_isa_extension_check(ext->id)) {
>> -				set_bit(ext->id, isainfo->isa);
>> -
>> -				/* Only single letter extensions get set in hwcap */
>> -				if (strnlen(riscv_isa_ext[i].name, 2) == 1)
>> -					this_hwcap |= isa2hwcap[riscv_isa_ext[i].id];
>> -			}
>> +			riscv_isa_set_ext(ext, isa_bitmap);
>>  		}
>>  
>> +		riscv_resolve_isa(isa_bitmap, isainfo, &this_hwcap, isa2hwcap);
>> +
>>  		of_node_put(cpu_node);
>>  
>>  		/*
>> -- 
>> 2.43.0
>>

