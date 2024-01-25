Return-Path: <linux-kselftest+bounces-3595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B8183CB13
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 19:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6CA1F26CA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 18:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC46137C38;
	Thu, 25 Jan 2024 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ndRNjLNt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0F213667D
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207188; cv=none; b=hwLkexxh7TdYtamd+6CH76DP+ZD9uPcqSAaI6fLwdeMx7WfexmHuCjrsS5PWYwh/gd378vcFqx4A9/4nzwpXTUYQr/HWVMmllWnYePOIarUFggg8PBzOySX2s2c/8SgImaibAe+Z5n8SflKHx5QRWQbfJG7ZIiT/4A6xWPtvrp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207188; c=relaxed/simple;
	bh=jx00gY1ANnXUmZbXujxCZw5ack5kqcVrRKjf2wSzAGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFGK3yyvBJAkuwkkcU+2+j/3E148/r1gZNzVv5icvhe8gFWsgiPGZ3aTvRbEWF6hm5Y1Mdj4JH7dUQq3Hdyda+bvX3t4h1hmFW+7ctvFD65Vtxi9ge/FsQRavYuog7uUaFeYWBHLykM43Hl6sN3dmRNzyoPk9alIFbC+YuJZK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ndRNjLNt; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cf450eba00so5726141a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 10:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706207184; x=1706811984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyuZ0gVdBuvlPmtjlhSz8uJtD77t/nVDJ3cBvemqEj0=;
        b=ndRNjLNtyb2HSEDOmH/SyIDmrte0pVJhbjx5ZFOqTVaN7zTiNt5Hv0poqPgH1fvEvW
         o4qDLhKbdvSU8IfpisXd196IA9OWyysxT9b6MZ/eBWwz+s+GogE5RDlWdvAZ6Pv7CqeX
         d1nZwoWmgxZh8V3wrRsluC8eWBvyzqJMrD1yWLdPmXld+IZZ2zckxZ7vER8J/2glMQMQ
         DNtMgs5Iwnxpov8tsBR+gQpM/ZaS8IorzAJ5KtBQs0MLqSmcIN6bJGDpJOdOaNkkBFXq
         Tq0YI3Ng8+ZVomByK6VtS5pDVUXFVyRFuNVKXd5CbYV60X5g0mGS76qtBFj6D+YS6wIs
         im9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706207184; x=1706811984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyuZ0gVdBuvlPmtjlhSz8uJtD77t/nVDJ3cBvemqEj0=;
        b=GgOxS+N5rgQYX3GH0ZhYSAFXwW4HvhOYu7m5sBk4xCs1n1SCS4Ubxaq5d5M2P74mue
         6/N0AtcP5VlSsXR1ISd7yYNSBp9I4wor9X7StYuflId8QZKBCCK1Ccm5Q/nByqeTO64l
         Vwxf03tRI9+w1647vYZUElxli/euyoVBmk1EMf3KRnPw0yNRTneJMpSH03NpNLz/eOy9
         UJ2GCI5F0OlLHUrgmm4fuLMAsxQJmv/H5PHxsklPO29RCYZwRgrAKXaqFIav/xVtA12l
         XN1dAvUmUSNXMYMf3uqGiP0qZlmPgtENG/pd9i051EXsEHUr9Wj6Y/MvW7QBx2Ron3lr
         5A/w==
X-Gm-Message-State: AOJu0YwSVi0pJwNh+uxY2XnCvZlSzHsPDunaqslYsT8knXtUyunBZKg1
	VerXSs8tPO/bjTW18BxE+mKq7KJpsSum03cfihi5xwQWVfHOexBwH0rCuyZn7gE=
X-Google-Smtp-Source: AGHT+IFBV2oC78chsLzac9k77DXS5/WbnhoEAPatEDRZ6lhNeqqRGgEsUCPUu1zeHuG1e8R3Jwt8hg==
X-Received: by 2002:a05:6a20:1453:b0:199:ad49:ea79 with SMTP id a19-20020a056a20145300b00199ad49ea79mr78878pzi.63.1706207184482;
        Thu, 25 Jan 2024 10:26:24 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j38-20020a635526000000b005cf7c4bb938sm13685563pgb.94.2024.01.25.10.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 10:26:24 -0800 (PST)
Date: Thu, 25 Jan 2024 10:26:19 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, corbet@lwn.net, aou@eecs.berkeley.edu,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, shuah@kernel.org, brauner@kernel.org,
	guoren@kernel.org, samitolvanen@google.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, waylingii@gmail.com,
	greentime.hu@sifive.com, heiko@sntech.de, jszhang@kernel.org,
	shikemeng@huaweicloud.com, david@redhat.com, charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn, willy@infradead.org,
	vincent.chen@sifive.com, andy.chiu@sifive.com, gerg@kernel.org,
	jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
	ancientmodern4@gmail.com, mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com, bhe@redhat.com, ruscur@russell.cc,
	bgray@linux.ibm.com, alx@kernel.org, baruch@tkos.co.il,
	zhangqing@loongson.cn, catalin.marinas@arm.com, revest@chromium.org,
	josh@joshtriplett.org, joey.gouly@arm.com, shr@devkernel.io,
	omosnace@redhat.com, ojeda@kernel.org, jhubbard@nvidia.com,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 05/28] riscv: zicfiss/zicfilp enumeration
Message-ID: <ZbKny7ZAG5FWHwwF@debug.ba.rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-6-debug@rivosinc.com>
 <20240125-unscathed-coeditor-31f04e811489@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240125-unscathed-coeditor-31f04e811489@spud>

On Thu, Jan 25, 2024 at 05:59:24PM +0000, Conor Dooley wrote:
>Yo,
>
>Series is RFC, so not gonna review it in depth, just wanted to comment
>on this particular patch.
>
>On Wed, Jan 24, 2024 at 10:21:30PM -0800, debug@rivosinc.com wrote:
>> From: Deepak Gupta <debug@rivosinc.com>
>>
>> This patch adds support for detecting zicfiss and zicfilp. zicfiss and zicfilp
>> stands for unprivleged integer spec extension for shadow stack and branch
>> tracking on indirect branches, respectively.
>>
>> This patch looks for zicfiss and zicfilp in device tree and accordinlgy lights
>> up bit in cpu feature bitmap. Furthermore this patch adds detection utility
>> functions to return whether shadow stack or landing pads are supported by
>> cpu.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/cpufeature.h | 18 ++++++++++++++++++
>>  arch/riscv/include/asm/hwcap.h      |  2 ++
>>  arch/riscv/include/asm/processor.h  |  1 +
>>  arch/riscv/kernel/cpufeature.c      |  2 ++
>>  4 files changed, 23 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>> index a418c3112cd6..216190731c55 100644
>> --- a/arch/riscv/include/asm/cpufeature.h
>> +++ b/arch/riscv/include/asm/cpufeature.h
>> @@ -133,4 +133,22 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
>>  	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
>>  }
>>
>> +static inline bool cpu_supports_shadow_stack(void)
>> +{
>> +#ifdef CONFIG_RISCV_USER_CFI
>
>In passing, I don't see any reason for not using IS_ENABLED() here.

No reason. I should probably do that. More readable.
Thanks.

>
>> +	return riscv_isa_extension_available(NULL, ZICFISS);
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
>> +static inline bool cpu_supports_indirect_br_lp_instr(void)
>> +{
>> +#ifdef CONFIG_RISCV_USER_CFI
>> +	return riscv_isa_extension_available(NULL, ZICFILP);
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
>>  #endif
>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>> index 06d30526ef3b..918165cfb4fa 100644
>> --- a/arch/riscv/include/asm/hwcap.h
>> +++ b/arch/riscv/include/asm/hwcap.h
>> @@ -57,6 +57,8 @@
>>  #define RISCV_ISA_EXT_ZIHPM		42
>>  #define RISCV_ISA_EXT_SMSTATEEN		43
>>  #define RISCV_ISA_EXT_ZICOND		44
>> +#define RISCV_ISA_EXT_ZICFISS	45
>> +#define RISCV_ISA_EXT_ZICFILP	46
>>
>>  #define RISCV_ISA_EXT_MAX		64
>>
>> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
>> index f19f861cda54..ee2f51787ff8 100644
>> --- a/arch/riscv/include/asm/processor.h
>> +++ b/arch/riscv/include/asm/processor.h
>> @@ -13,6 +13,7 @@
>>  #include <vdso/processor.h>
>>
>>  #include <asm/ptrace.h>
>> +#include <asm/hwcap.h>
>>
>>  #ifdef CONFIG_64BIT
>>  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 98623393fd1f..16624bc9a46b 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -185,6 +185,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>>  	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
>>  	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
>> +	__RISCV_ISA_EXT_DATA(zicfiss, RISCV_ISA_EXT_ZICFISS),
>> +	__RISCV_ISA_EXT_DATA(zicfilp, RISCV_ISA_EXT_ZICFILP),
>
>Anything you add to this array, you need to document in a dt-binding.

You mean Documentation/devicetree/bindings/riscv/extensions.yaml
(or possibly any other yaml if needed?)

>Also, you added these in the wrong place. There's a massive comment
>before the array describing the order entries must be in, please take a
>look.

I see the comment.
In my defense, looks like I missed it when I was rebasing.

Will fix it.

>
>Thanks,
>Conor.
>
>
>>  };
>>
>>  const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
>> --
>> 2.43.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv



