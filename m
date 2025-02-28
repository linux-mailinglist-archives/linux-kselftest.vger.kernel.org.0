Return-Path: <linux-kselftest+bounces-27881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 429B7A49920
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F85D16C411
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D89B26AA8D;
	Fri, 28 Feb 2025 12:24:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D842F25B696;
	Fri, 28 Feb 2025 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745487; cv=none; b=o/WUeoRmMyAHBrXNcwJ5d/EqgFu4NpbeVT8urVQX8bepEl6voV6+GXy+GeDZxQ+TZWuGoIWsb4f+pF+7H5S8lcWccFh0NBX5wY+dmplbKsDCsosJZ38LvgdUIdLxD7ubf5PFLjns5TP5NwXGHOFRjMThE6Y6mFWpSiEfxchPvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745487; c=relaxed/simple;
	bh=XEo2F33a0Ti/Z5D7GEbwdyKrCV9Yqq9t4Xa23qpJfWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xjuv/5DEBaimCjkLBjdiUg7k1TkwCAndI/Ra6nP7Kav3f+srdDdBZzDrP8vseTqYZy9zi638FMFO0NAAuopwPiThMawwBdt2uSYZejgJkxQwwyaon9dX8C3c7hDlmtE55jFl1mwZtu9aicGxIVgRRz7d82pRQSmoJA7umQ+0gog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E3DF1688;
	Fri, 28 Feb 2025 04:25:00 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9C1F3F6A8;
	Fri, 28 Feb 2025 04:24:42 -0800 (PST)
Message-ID: <cf0f9c4c-e23d-4209-bf27-b2de2cfe0e96@arm.com>
Date: Fri, 28 Feb 2025 12:24:41 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] elf, uapi: Add type ElfXX_Versym
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
 <20250226-parse_vdso-nolibc-v2-5-28e14e031ed8@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-5-28e14e031ed8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2025 11:44, Thomas Weißschuh wrote:
> The types are used by tools/testing/selftests/vDSO/parse_vdso.c.
> To be able to build the vDSO selftests without a libc dependency,
> add the types to the kernels own UAPI headers.
> 
> As documented by elf(5).
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  include/uapi/linux/elf.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index d040f12ff1c0ae3dde5c371c81d6089118fbe8ed..8846fe03ca5b836c96aad1be6d8fb9daf3d4b1d9 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -11,6 +11,7 @@ typedef __u16	Elf32_Half;
>  typedef __u32	Elf32_Off;
>  typedef __s32	Elf32_Sword;
>  typedef __u32	Elf32_Word;
> +typedef __u16	Elf32_Versym;
>  
>  /* 64-bit ELF base types. */
>  typedef __u64	Elf64_Addr;
> @@ -21,6 +22,7 @@ typedef __s32	Elf64_Sword;
>  typedef __u32	Elf64_Word;
>  typedef __u64	Elf64_Xword;
>  typedef __s64	Elf64_Sxword;
> +typedef __u16	Elf64_Versym;
>  
>  /* These constants are for the segment types stored in the image headers */
>  #define PT_NULL    0
> 

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

-- 
Regards,
Vincenzo


