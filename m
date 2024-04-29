Return-Path: <linux-kselftest+bounces-9007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BE78B52C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 10:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D5F1F218F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BDC1640B;
	Mon, 29 Apr 2024 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uLrmyNoi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387B883D
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377771; cv=none; b=cBQDOIDpbf6UaTcYmH2cU/SwZSewEJpSzBqd7WtscpYJikoj68DX3vgyJvD5BajswsODdLkA4Q8t9ZgGp+TAuMREmrMnGISGSJBQWs9mGww6xV1xQCYdfD/70irFHlhedh2u5Wz2oPBDBlyZbt450FWjsJgp59XnYuhznNFly/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377771; c=relaxed/simple;
	bh=9HoXmHzHQZ9ELzIrBrYKNCb/oWvWn5TWjSoHPopcX6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUEXicm0FncUA4GiLy7j2eN87ew7uQII8qAfH1IU09NiUklA8jHhq9y4iODdYB25oKKtSVPmcAGcm01TeT+2ePM3LMHaBBxhUg1ie4D8sluCZ+qqQ+wkVo4vTVhK9xXOvbhS5CvNTDwKfW5KTDjIp73oDUSwwXQDsbQ2jxVJ9Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uLrmyNoi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34aa836b948so690965f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 01:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714377767; x=1714982567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9lk6J9c7nceHYPPSuxHCl/jFNOuQDl39RqYLkN6g2zo=;
        b=uLrmyNoivx3LSuqSymvFaYWv9E98dWMFdUXz055tfEppaax/syZeM6hnC9AyWAziau
         ohUoc62nwq4ReIlXzWipN31JfYleJL7l0i7T4RYimDyfDBulsM2uB1xMPwPCj6uxxe7L
         n+9pzABtdkovUUKWLRDzKywvfya03I/uhaC8WiWG+2ap84BnjuR39Vd1J/tYESQ70h2F
         HInkAfX8L7Tfa8LNnTzAGfpxlpcdWLcYZxRkly+O3iw1u1Zcdk4kdTfms0G4v8zVUx56
         6ybgjL4EFBOrcwvt2IsGybTv8lHIuKiEcnXdfZrfKJjI1NvKIPPXe2W7d4KGPRHsy6st
         zI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714377767; x=1714982567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lk6J9c7nceHYPPSuxHCl/jFNOuQDl39RqYLkN6g2zo=;
        b=ofGYfxHMVp8ZKPVixLGkV7DnjIltXcaO2FKfhJsTBI0KXqLhFXbAbnW5HrKb0T4+n/
         OVuwUiy3DnkAr+hlLWYuGGceJG9VVokMtfNIYwQL/gaaqmac9ipxWY61iKxJEj0wgtoZ
         1KbU0NUkmbl7giGkqEwhpUgCcyj3CxQhXKRioOeMInWFeuLcC9UBIVNExW08DSMBlQq1
         wHuCLmNsNPqo36RRQNF9gGbp004sn996Pwcibv589osMJftalOI/T6QwefB+auO5MtSU
         QDQgOBThtSXh2QUnyhTEF/ywQ0IZThN7TpPWecGV6PyVYLGKvSbJUdVc0TXEoDi4gENV
         CqAw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ0a817K8yiC8ZhsUc6CNbrRSHFjd1NE8TaCJcFA9G3IvpXPUIC54oVx9FhOajkE8Dxcwr4/rcwWSSVlTn1mZSSuLQJ1NDVrRorw/Gbic5
X-Gm-Message-State: AOJu0YyHGksaBwl0Rj4zDcsm7isEWO/xyEBsATWucEQD0+LaqsotHIFM
	P7WzG31vnTno1pNTC2Sy0HsxuSMgeuDxYxGJhYcJHukc6ixEsCsz7KScy4IJaGI=
X-Google-Smtp-Source: AGHT+IGd/GTek2EtViHRdRFeIXZn3n2LYf5CPBHrEQdxd9jjHLyUtqDgKKXlzgWCD9IG4KWRHuQ70A==
X-Received: by 2002:adf:eb88:0:b0:34c:a12:8722 with SMTP id t8-20020adfeb88000000b0034c0a128722mr6358975wrn.1.1714377766520;
        Mon, 29 Apr 2024 01:02:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:2fec:d20:2b60:e334? ([2a01:e0a:999:a3a0:2fec:d20:2b60:e334])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d6b88000000b0034c462f920csm8446915wrx.40.2024.04.29.01.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 01:02:45 -0700 (PDT)
Message-ID: <7b2b8045-b814-4f93-a9ce-4e3d087c8f0e@rivosinc.com>
Date: Mon, 29 Apr 2024 10:02:44 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/11] riscv: add ISA extensions validation
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
References: <20240423124326.2532796-1-cleger@rivosinc.com>
 <20240423124326.2532796-3-cleger@rivosinc.com>
 <20240426-smugly-jury-e933a4ef035c@spud>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240426-smugly-jury-e933a4ef035c@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/04/2024 16:23, Conor Dooley wrote:
> On Tue, Apr 23, 2024 at 02:43:16PM +0200, Clément Léger wrote:
>> Since a few extensions (Zicbom/Zicboz) already needs validation and
>> future ones will need it as well (Zc*) add a validate() callback to
>> struct riscv_isa_ext_data. This require to rework the way extensions are
>> parsed and split it in two phases. First phase is isa string or isa
>> extension list parsing and consists in enabling all the extensions in a
>> temporary bitmask without any validation. The second step "resolves" the
>> final isa bitmap, handling potential missing dependencies. The mechanism
>> is quite simple and simply validate each extension described in the
>> temporary bitmap before enabling it in the final isa bitmap. This
>> process takes place until the final isa bitmap reaches a stable state.
>> In order to avoid any potential infinite looping, allow looping a
>> maximum of the number of extension we handle. Zicboz and Zicbom
>> extensions are modified to use this validation mechanism.
> 
> Yaknow, seeing the implemtation I'm having second thoughts. I think
> there's two pretty separate actions going on here - the first is things
> like Zicbom or Zicboz where we are looking at the DT to find some extra
> properties which we can do exactly once. The other is the Zc* case,
> where we are making sure that extensions they depend on are enabled.
> I understand that the latter may need to loop, but I don't think there's
> a reason to loop in the Zicbom or Zicboz case.

That's a good point, we could potentially avoid that by specifying
different return values for the validate callback (Similar to what is
done by platform driver probing):

- 0 -> Ok, enable the extension
- -EDEFER -> Try to probe again later
- -E<whatever> -> Disabled the extension once for all in the original
ISA bitmap so the callback won't get called again.

That would also allows to get rid of at least the extra loop that is
done to verify the stability of the ISA even if there were no defered
probed extensions.

Thanks,

Clément

> 
> That said, I do actually like the idea of having specific callbacks for
> extensions that require them, rather than calling extension_check()
> unconditionally.
> 
> I've not reviewed the actual code here FWIW, just spent some time
> thinking about the idea. I might do that later on this revision, or on
> another, depending on what you think of splitting the Zicbom and Zicboz
> type extra prop checking from dependency related stuff like Zc*.
> 
> Cheers,
> Conor.
> 
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/cpufeature.h |   1 +
>>  arch/riscv/kernel/cpufeature.c      | 201 ++++++++++++++++------------
>>  2 files changed, 118 insertions(+), 84 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>> index 347805446151..328f895f6b8f 100644
>> --- a/arch/riscv/include/asm/cpufeature.h
>> +++ b/arch/riscv/include/asm/cpufeature.h
>> @@ -70,6 +70,7 @@ struct riscv_isa_ext_data {
>>  	const char *property;
>>  	const unsigned int *subset_ext_ids;
>>  	const unsigned int subset_ext_size;
>> +	bool (*validate)(const struct riscv_isa_ext_data *data, const unsigned long *isa_bitmap);
>>  };
>>  
>>  extern const struct riscv_isa_ext_data riscv_isa_ext[];
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 115ba001f1bc..6d238c8dbccf 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -72,51 +72,62 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned i
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
>> +	return id != RISCV_ISA_EXT_INVALID;
>> +}
>> +
>> +static bool riscv_ext_zicbom_validate(const struct riscv_isa_ext_data *data,
>> +				      const unsigned long *isa_bitmap)
>> +{
>> +	if (!riscv_cbom_block_size) {
>> +		pr_err_once("Zicbom detected in ISA string,"
>> +			    "disabling as no cbom-block-size found\n");
>> +		return false;
>> +	} else if (!is_power_of_2(riscv_cbom_block_size)) {
>> +		pr_err_once("Zicbom disabled as cbom-block-size present,"
>> +			    "but is not a power-of-2\n");
>>  		return false;
>>  	}
>> +	return true;
>> +}
>>  
>> +static bool riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
>> +				      const unsigned long *isa_bitmap)
>> +{
>> +	if (!riscv_cboz_block_size) {
>> +		pr_err_once("Zicboz detected in ISA string,"
>> +			    "disabling as no cboz-block-size found\n");
>> +		return false;
>> +	} else if (!is_power_of_2(riscv_cboz_block_size)) {
>> +		pr_err_once("Zicboz disabled as cboz-block-size present,"
>> +			    "but is not a power-of-2\n");
>> +		return false;
>> +	}
>>  	return true;
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
>> @@ -247,8 +258,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
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
>> @@ -310,33 +323,70 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
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
>> +static void __init riscv_resolve_isa(const unsigned long *isa_bitmap, struct riscv_isainfo *isainfo,
>> +				     unsigned long *this_hwcap, unsigned long *isa2hwcap)
>> +{
>> +	const struct riscv_isa_ext_data *ext;
>> +	DECLARE_BITMAP(prev_bitmap, RISCV_ISA_EXT_MAX);
>> +	int max_loop_count = riscv_isa_ext_count + 1;
>> +
>> +	do {
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
>> +			if (ext->validate && !ext->validate(ext, isainfo->isa))
>> +				continue;
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
>> +	} while (memcmp(prev_bitmap, isainfo->isa, sizeof(prev_bitmap)));
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
>> @@ -349,7 +399,7 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
>>  	while (*isa) {
>>  		const char *ext = isa++;
>>  		const char *ext_end = isa;
>> -		bool ext_long = false, ext_err = false;
>> +		bool ext_err = false;
>>  
>>  		switch (*ext) {
>>  		case 's':
>> @@ -389,7 +439,6 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
>>  			 * character itself while eliminating the extensions version number.
>>  			 * A simple re-increment solves this problem.
>>  			 */
>> -			ext_long = true;
>>  			for (; *isa && *isa != '_'; ++isa)
>>  				if (unlikely(!isalnum(*isa)))
>>  					ext_err = true;
>> @@ -469,17 +518,8 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
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
>> @@ -501,6 +541,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
>>  	for_each_possible_cpu(cpu) {
>>  		struct riscv_isainfo *isainfo = &hart_isa[cpu];
>>  		unsigned long this_hwcap = 0;
>> +		DECLARE_BITMAP(isa_bitmap, RISCV_ISA_EXT_MAX) = { 0 };
>>  
>>  		if (acpi_disabled) {
>>  			node = of_cpu_device_node_get(cpu);
>> @@ -523,7 +564,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
>>  			}
>>  		}
>>  
>> -		riscv_parse_isa_string(&this_hwcap, isainfo, isa2hwcap, isa);
>> +		riscv_resolve_isa_string(isa, isa_bitmap);
>>  
>>  		/*
>>  		 * These ones were as they were part of the base ISA when the
>> @@ -531,10 +572,10 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
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
>> @@ -548,9 +589,11 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
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
>> @@ -579,6 +622,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
>>  		unsigned long this_hwcap = 0;
>>  		struct device_node *cpu_node;
>>  		struct riscv_isainfo *isainfo = &hart_isa[cpu];
>> +		DECLARE_BITMAP(isa_bitmap, RISCV_ISA_EXT_MAX) = { 0 };
>>  
>>  		cpu_node = of_cpu_device_node_get(cpu);
>>  		if (!cpu_node) {
>> @@ -598,22 +642,11 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
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

