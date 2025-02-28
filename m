Return-Path: <linux-kselftest+bounces-27880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368F7A4991F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA997A8F47
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3186E26AA9A;
	Fri, 28 Feb 2025 12:24:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6DD26A1CD;
	Fri, 28 Feb 2025 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745459; cv=none; b=UtqPGLX06SLIMUEKrGqOAaLGYJB2PX4ojFZEfj44/uxKc5v99lcNmY7DoOqO8JzcsqMraO61rK1ZmB6ppxqd0mzewHZ+Rpm02LfVBCL/fXyG52Er2nBlhNnJZ9lCuBbujDYp4Xmu+Wzu7GfejyyiJ+TMXD1vsT4AxyESYE3AKBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745459; c=relaxed/simple;
	bh=IRkqSm4v7Emoms/dT4aG8Mvz+CXcCoa7/bNQPzCIUXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AosPx6HXtPpdsA6UjaBNYtDIxc1ITF4/eK87oOuaUHcPoPi7BWgqU8Qa2XJJdUq5zG6EiuOjjD+fAOQ/1IUiN5Xfmt4+84Bo18YUGZsvf1W9Wxzerlevf4L0zBRNZL3+qLKEqe+iFM58SUe6STZMBAhOl261pUEhZ9FQcCV0cik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 615CC1688;
	Fri, 28 Feb 2025 04:24:32 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E9113F6A8;
	Fri, 28 Feb 2025 04:24:14 -0800 (PST)
Message-ID: <8e793c2a-f4f8-41a2-beb9-5e4049f7d79b@arm.com>
Date: Fri, 28 Feb 2025 12:24:13 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] elf, uapi: Add definitions for VER_FLG_BASE and
 VER_FLG_WEAK
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
 <20250226-parse_vdso-nolibc-v2-4-28e14e031ed8@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-4-28e14e031ed8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2025 11:44, Thomas Weißschuh wrote:
> The definitions are used by tools/testing/selftests/vDSO/parse_vdso.c.
> To be able to build the vDSO selftests without a libc dependency,
> add the definitions to the kernels own UAPI headers.
> 
> Link: https://docs.oracle.com/cd/E19683-01/816-1386/chapter6-80869/index.html
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  include/uapi/linux/elf.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index c5383cc7bb13c931fea083de5243c4006f795006..d040f12ff1c0ae3dde5c371c81d6089118fbe8ed 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -136,6 +136,9 @@ typedef __s64	Elf64_Sxword;
>  #define STT_COMMON  5
>  #define STT_TLS     6
>  
> +#define VER_FLG_BASE 0x1
> +#define VER_FLG_WEAK 0x2
> +
>  #define ELF_ST_BIND(x)		((x) >> 4)
>  #define ELF_ST_TYPE(x)		((x) & 0xf)
>  #define ELF32_ST_BIND(x)	ELF_ST_BIND(x)
> 

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

-- 
Regards,
Vincenzo


