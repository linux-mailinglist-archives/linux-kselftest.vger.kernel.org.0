Return-Path: <linux-kselftest+bounces-39258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37810B2B498
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 01:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E109F4E4FC8
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 23:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40F520D51C;
	Mon, 18 Aug 2025 23:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQbzzPG4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C121883E;
	Mon, 18 Aug 2025 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755559536; cv=none; b=tHdBQWXZpBa8I7RYtp+CeNy4i9gCM75MbrPRnMxoWh5OgH+3+aa+2smcfRFx5Y1DAAPnPhR4YGsAgzg9XnTRrtSSKRB0k8ph5GKC8RqQ4SZta/MhCxSxpUE2O4sypE3+JHns4d2hkdw83P2AEmS55ilbabEigXkoZ8t5soDz7HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755559536; c=relaxed/simple;
	bh=Z/fOjp/Ym9YooMKQnrRWOQT8w9dEmQrzw4wTszp9L3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mCas9gWs2UOAk7jth9AuVob0I6/d3zQ17RM3tG3EeR9ueCU6y27s7eRvL76sByr4XwTpZQnYStRacAuDITk4S1gO9S6i7+2tLgPoToF9VPAvN5j32Gbv6uTNeKFodLTgJCFGiCYyGjsQkrUUqEAOOhluMJQcMW7u+NmZ7vZOFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQbzzPG4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755559535; x=1787095535;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Z/fOjp/Ym9YooMKQnrRWOQT8w9dEmQrzw4wTszp9L3s=;
  b=BQbzzPG4bMOuM3m6kmit59ABfisYIpFwGfZQ7MMHcXxA6IwxJz3hpGkR
   oKW39q/H6GFLfzU1e064YypsGFS06VKVeerCGqsZ8/zJrvxZbEN2ZwaOf
   794KbU4IpsYXtDhuWn/4wXNw4oadmI6+Jcg3YYK5HHFHkxPEs43nZuqBt
   QozEZrVMEiQu6qTlkWjj6b5COx13nHp72V1hOu3JlGMXTR/MUUwHWMwFS
   FYbfans7CNhT34s4oYZjoCq2QEvSGKue8PDNBsZxlI8iO1mhu/3cJ+Peg
   JG06k1UdSv4Pt/ngzTLL8DdnExyr+NY2Ta9pnzkpWr5NCUhmtpJWdPdFp
   Q==;
X-CSE-ConnectionGUID: 8YI0Ui88RVOJWK2uA1AOgQ==
X-CSE-MsgGUID: EMd1im/JTHiieR0QZApCUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="61627992"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="61627992"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 16:25:35 -0700
X-CSE-ConnectionGUID: F5tq7uFnToWNTQu7SXkcSg==
X-CSE-MsgGUID: waurPwuXTVGwkqVYXmfW5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="166936014"
Received: from vcostago-mobl3.jf.intel.com (HELO vcostago-mobl3) ([10.98.24.140])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 16:25:34 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson
 <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, Adhemerval Zanella
 <adhemerval.zanella@linaro.org>, Adithya Jayachandran
 <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, Ard
 Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, David Matlack <dmatlack@google.com>,
 dmaengine@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, James
 Houghton <jthoughton@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Joel
 Granados <joel.granados@kernel.org>, Josh Hilke <jrhilke@google.com>,
 Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "Mike Rapoport (Microsoft)"
 <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Vipin Sharma <vipinsh@google.com>, Wei Yang
 <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Subject: Re: [PATCH 12/33] tools headers: Import iosubmit_cmds512()
In-Reply-To: <20250620232031.2705638-13-dmatlack@google.com>
References: <20250620232031.2705638-1-dmatlack@google.com>
 <20250620232031.2705638-13-dmatlack@google.com>
Date: Mon, 18 Aug 2025 16:25:33 -0700
Message-ID: <87jz302owi.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Matlack <dmatlack@google.com> writes:

> Import iosubmit_cmds512() from arch/x86/include/asm/io.h into tools/ so
> it can be used by VFIO selftests to interact with Intel DSA devices.
>

minor: perhaps move this patch to be near the one that adds the DSA
driver? (in case there's a next revision)

Anyway,

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

> Also pull in movdir64b() from arch/x86/include/asm/special_insns.h into
> tools/, which is the underlying instruction used by iosubmit_cmds512().
>
> Changes made when importing: None
>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  tools/arch/x86/include/asm/io.h            | 26 +++++++++++++++++++++
>  tools/arch/x86/include/asm/special_insns.h | 27 ++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 tools/arch/x86/include/asm/special_insns.h
>
> diff --git a/tools/arch/x86/include/asm/io.h b/tools/arch/x86/include/asm/io.h
> index 4c787a2363de..ecad61a3ea52 100644
> --- a/tools/arch/x86/include/asm/io.h
> +++ b/tools/arch/x86/include/asm/io.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/compiler.h>
>  #include <linux/types.h>
> +#include "special_insns.h"
>  
>  #define build_mmio_read(name, size, type, reg, barrier) \
>  static inline type name(const volatile void __iomem *addr) \
> @@ -72,4 +73,29 @@ build_mmio_write(__writeq, "q", u64, "r", )
>  
>  #include <asm-generic/io.h>
>  
> +/**
> + * iosubmit_cmds512 - copy data to single MMIO location, in 512-bit units
> + * @dst: destination, in MMIO space (must be 512-bit aligned)
> + * @src: source
> + * @count: number of 512 bits quantities to submit
> + *
> + * Submit data from kernel space to MMIO space, in units of 512 bits at a
> + * time.  Order of access is not guaranteed, nor is a memory barrier
> + * performed afterwards.
> + *
> + * Warning: Do not use this helper unless your driver has checked that the CPU
> + * instruction is supported on the platform.
> + */
> +static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
> +				    size_t count)
> +{
> +	const u8 *from = src;
> +	const u8 *end = from + count * 64;
> +
> +	while (from < end) {
> +		movdir64b(dst, from);
> +		from += 64;
> +	}
> +}
> +
>  #endif /* _TOOLS_ASM_X86_IO_H */
> diff --git a/tools/arch/x86/include/asm/special_insns.h b/tools/arch/x86/include/asm/special_insns.h
> new file mode 100644
> index 000000000000..04af42a99c38
> --- /dev/null
> +++ b/tools/arch/x86/include/asm/special_insns.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TOOLS_ASM_X86_SPECIAL_INSNS_H
> +#define _TOOLS_ASM_X86_SPECIAL_INSNS_H
> +
> +/* The dst parameter must be 64-bytes aligned */
> +static inline void movdir64b(void *dst, const void *src)
> +{
> +	const struct { char _[64]; } *__src = src;
> +	struct { char _[64]; } *__dst = dst;
> +
> +	/*
> +	 * MOVDIR64B %(rdx), rax.
> +	 *
> +	 * Both __src and __dst must be memory constraints in order to tell the
> +	 * compiler that no other memory accesses should be reordered around
> +	 * this one.
> +	 *
> +	 * Also, both must be supplied as lvalues because this tells
> +	 * the compiler what the object is (its size) the instruction accesses.
> +	 * I.e., not the pointers but what they point to, thus the deref'ing '*'.
> +	 */
> +	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> +		     : "+m" (*__dst)
> +		     :  "m" (*__src), "a" (__dst), "d" (__src));
> +}
> +
> +#endif /* _TOOLS_ASM_X86_SPECIAL_INSNS_H */
> -- 
> 2.50.0.rc2.701.gf1e915cc24-goog
>

-- 
Vinicius

