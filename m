Return-Path: <linux-kselftest+bounces-27879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6ABA4991D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E1C7A7B6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9891626A1C8;
	Fri, 28 Feb 2025 12:23:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1C726A1CD;
	Fri, 28 Feb 2025 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745432; cv=none; b=Q9pqXONqY/MBOj6m2+217kfSUknGB8y5F9jKjTM+TyhLOflNcwaqsY5Pdfh380nKDiSyXs+AeJOqMo7btEeDUVfqPhu+ob0mdkw1FKU2pMaiptvLcxmEs/WRKSvRGhL0d0yVj1J092pm8m3r9xqIpRqgV6m1ke7Swlx/Ik20RTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745432; c=relaxed/simple;
	bh=jTvQedNooV/SsENEACJJWwUvvkX3ucetv2jZAFI3aHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9n996pjmHcirIdt/HNg1kjVowmypF/thzDAldm2XWKnhCGkQeXdhu7rz0J3aShZi7AH3Uo7yuuN46JJeMIZMhjfK8lWtsU2MJed0t3Npa1VyINwGP6F4pTxPQff1+co8UP6sqW5Q4FKs68jqs9UJU5gmY82jgmMQygb50hOce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A56C01688;
	Fri, 28 Feb 2025 04:24:05 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09FD63F6A8;
	Fri, 28 Feb 2025 04:23:47 -0800 (PST)
Message-ID: <b59ffaa8-85ad-4e72-a2ae-dd878c5f3e36@arm.com>
Date: Fri, 28 Feb 2025 12:23:46 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] elf, uapi: Add definition for DT_GNU_HASH
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
 <20250226-parse_vdso-nolibc-v2-3-28e14e031ed8@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-3-28e14e031ed8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2025 11:44, Thomas Weißschuh wrote:
> The definition is used by tools/testing/selftests/vDSO/parse_vdso.c.
> To be able to build the vDSO selftests without a libc dependency,
> add the define to the kernels own UAPI headers.
> 
> Link: https://refspecs.linuxbase.org/LSB_5.0.0/LSB-Core-generic/LSB-Core-generic/libc-ddefs.html
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  include/uapi/linux/elf.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index 448695c7364042b10682acc8223eb6053ad039dd..c5383cc7bb13c931fea083de5243c4006f795006 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -107,6 +107,7 @@ typedef __s64	Elf64_Sxword;
>  #define DT_VALRNGLO	0x6ffffd00
>  #define DT_VALRNGHI	0x6ffffdff
>  #define DT_ADDRRNGLO	0x6ffffe00
> +#define DT_GNU_HASH	0x6ffffef5
>  #define DT_ADDRRNGHI	0x6ffffeff
>  #define DT_VERSYM	0x6ffffff0
>  #define DT_RELACOUNT	0x6ffffff9
> 

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

-- 
Regards,
Vincenzo


