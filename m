Return-Path: <linux-kselftest+bounces-10258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450EE8C6750
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 15:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDADA285226
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D7D85C6F;
	Wed, 15 May 2024 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3PFE6nlA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C04D8595B
	for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779589; cv=none; b=fWUt448ofHtJPfv10IqwnkFdkBcRg6QMfX1J1Ob1izXXdHLL0La9/qcKwMy1sWfCupPGXWfCmRAgwnQWe5mcsAZsvPmL8l10Cko0BYo3wTSwL+Kll6d5AyoKa2HJ1ULAxtREKtqb0vTPZ+egoQOPsTbPDVXfxIaBRhzKBm4hgjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779589; c=relaxed/simple;
	bh=Ay36m1Hv1uA4nVw2mx1bBjHXOneciByDqnlcaCc4eOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmmPc7O1TwaO/K2/4rdm8EqWBXQtOvBUfGgbUQ0V9xA4oESFhebEGGD2HC8eApvZgvhbIx42Zwh14rEarcoaxe0H0WNqIBGCwdU8QdNyEjCTIUVc72eUmK1dh9GOmm8j3rQsZYctpB1F9Y79C8CKk2Zi8YbtOEOjl4u+vib6OD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3PFE6nlA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41ff0c3eacdso4520205e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2024 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715779585; x=1716384385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4jRaTLo0FBNHYO1U6ebOfybdn0s3zuus+R/Yo6bdlE=;
        b=3PFE6nlA5QUxWJwfWpBkcFnGNIv7gP7QV8KPFK/8T/uFRZ+DGGa/mL5fvMEVGMrZnE
         n3vQ7DkTQh/C2r1Kbs/KWSiN2WgymPgJoyFlvW/zp033Rif9F/BhERVUxLEnQ4MCkr+n
         /s+4yTPo/VDgnr8wmOp/Yy7BF9OdcOZZgwRbgbQ3sKmCYTeN7tZgE9TE4RekSIkvwJUd
         vj3vZiGphr8UnzFl/TgWsy08OUOVPLZ12+LVNJqPzidpNtcxFebW9q0bHoBKP4yGXZsG
         TtuLJWgg6X4kpdLZHINKZ7OQ3Cu8/ARRYoFd6F66kMhCciDzCL7sxHKdHAdqCU2YJkt0
         Hj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715779585; x=1716384385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4jRaTLo0FBNHYO1U6ebOfybdn0s3zuus+R/Yo6bdlE=;
        b=qf3FVR01PsE4mAdNPGUr5yds6DUftJrckQX9U6/Ta4TBDuEX8hnBdhKsRdgEHc9CMz
         bV6dwYdaUCLv9xZZG2dzm4MnppTnb6IEIN3ijrgZJIDCuA7i6fTX9qZ2i1MyAIzcaEBl
         wGZsnZYFZTi4NjK5mhH4/8okpMLZU4V90t1GmuvxHu4spAt4I1MH8eBP9QLVHeZt5eFm
         r4UKeDjwet0E2fOlvEDEjPYrhCc4IJkQx6PvaBJneVSJdOjr/R2M628v0DXd93d4t4O1
         iYH1Zjvw3UAG75E7uMlXpelItqe8eYk6wsopkGrProCEiX+/z2JdD5GvWSLJwqKSiFBC
         NtMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBG8O7P6JbTYmh6M49Nnlc/G9jU0ppdGDjcoyzVjH0P7cLQCPzgkLONMjeDJQxAUKJ2LelLCJyYlCjO1Zl9agaEu0itjJnPT1Eh836dFv2
X-Gm-Message-State: AOJu0YzaEeVR+Vf7Rv7rMHxZcb+o4rymsJUaGX7rQdrpFC7vOip6hmju
	mtIzYiKmjBYxhkB9ajawHMEyjzBWssIkZqW6HUhQhGTEQwjZ3YgY/Z2+iB5SslU=
X-Google-Smtp-Source: AGHT+IF/WKhF6PXHO1JN4EiQHsyuki3NYd7GxeZ1PvC8tJ0bB/n5WVvtu6sOSb+rsq6GKiqpgb39IQ==
X-Received: by 2002:a5d:4d10:0:b0:34c:f989:dc25 with SMTP id ffacd0b85a97d-3504a9689demr10930354f8f.6.1715779585335;
        Wed, 15 May 2024 06:26:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:f218:39c8:532e:12d6? ([2a01:e0a:999:a3a0:f218:39c8:532e:12d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a78cdsm16462077f8f.58.2024.05.15.06.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 06:26:24 -0700 (PDT)
Message-ID: <7a26604f-2653-4140-9294-637b340282d1@rivosinc.com>
Date: Wed, 15 May 2024 15:26:23 +0200
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
 <20240514-headcount-shrill-390ac0b9233c@spud>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240514-headcount-shrill-390ac0b9233c@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14/05/2024 19:39, Conor Dooley wrote:
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
> 
> I guess the original code did this too, but as the branches return the
> else here should go.

Indeed.

> 
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
> 
> I really don't understand what this comment is trying to say.
> I think what you're trying to say is that it is safe to call
> riscv_isa_extension_valid() for bundles, but wouldn't it just be clearer
> to drop the function calls and do the comparison to ..._INVALID here
> since riscv_isa_extension_valid() has been reduced to just that single
> comparison?

Yeah, that comment is a remnant of the rpevious code but does not make
sense anymore. I'll remove it along with riscv_isa_extension_valid() and
just compare to RISCV_ISA_EXT_INVALID.

> 
> I'd understand this function looking as it did if
> riscv_isa_extension_valid() was more than a oneliner.
> 
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
> 
> This function is badly in need of some new variable names for the first
> two parameters. It's hard to follow what each of them is meant to be
> once you're inside this function and removed from their definitions.
> The first parameter is the source bitmap that we've already filled from
> the dt/acpi scan of that hart and the second is the per-hart data
> structure that we're gonna assign it to and keep "forever", I think the
> naming should reflect that.

Yeah, wasn't sure of the naming at all. Would you be ok with the following:

- source_isa: Input ISA bitmap parsed from ISA string (DT/ACPI)
- resolved_isa: Output ISA bitmap resolved from the first one
(configuration and extension dependencies matching).

Since I'm a non-native english speaker, I'm not sure at all if it
correctly means what they do, feel free to tell me if you have some
better options.

> 
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
> 
> Why not bitmap_copy()?

Not reason at all, just forgot it existed.

> 
>> +		for (int i = 0; i < riscv_isa_ext_count; i++) {
> 
> Why would we even be testing extensions that have been disabled rather
> than iterating just over the set that has been turned on? IOW, does
> for_each_set_bit() work here?

I think the loop can acutally be done the other way (not sure, need to
check thoug) and iterate on isa_bitmap first rather than on extension array.

> 
>> +			ext = &riscv_isa_ext[i];
>> +
>> +			/* Bundle extensions ids are invalid*/
>> +			if (!riscv_isa_extension_valid(ext->id))
>> +				continue;
>> +
> 
>> +			if (!test_bit(ext->id, isa_bitmap) || test_bit(ext->id, isainfo->isa))
>> +				continue;
> 
> What's this test excluding? I think this deserves a comment.

Skips non set extension id in isa bitmap or extensions already enabled
in resolved bitmap. Will be rendered useless if changing the loop order.

> 
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
> 
> I don't see why this needs to be renamed, I think the original name here
> was fine - and the new name makes the operation of the caller of this
> function less clear to me.
> 

Bad renaming from a previous version where it conflicted with a new
function. No reason to keep it as is though, I'll revert that.

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
> 
> I think this code would, and the non-string variant below, benefit from
> a similar renaming to make the "flow" of information clearer.
> 
> In general tho, this stuff looks sane to me. There's a bunch of moving
> pieces at the moment with various extensions, so I hope that some of
> them (the vector subsets & the non-vector parts (1-9) of Charlie's series
> for vendor stuff maybe) get merged as 6.10 material so that we can
> reduce what's in play while we try to add this stuff.

Yes sure.

Thanks,

Clément

> 
> I'll suggest that to Palmer tomorrow I think..
> 
> Cheers,
> Conor.
> 
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
> 
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

