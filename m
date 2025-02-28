Return-Path: <linux-kselftest+bounces-27878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D297A4991A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07B53BBA59
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9495826AA83;
	Fri, 28 Feb 2025 12:23:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2820268C6D;
	Fri, 28 Feb 2025 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745403; cv=none; b=nnmRZAW0fk6Eg0nYxjEU19oGxXeN3XBzhAnoqLxoeE7Gb5iZWQKSrWxtuQ8IwBnjNywoheJLJPhE1NeCBTB62VIvAbSFfwtzOvjFZ4hO01ojDRrLahnA9U9Z+3h1ijTS0gGGPhLLRrFw0AmhXMrNP++MaVCnE+sN+D0P7KGLMn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745403; c=relaxed/simple;
	bh=q+5uplZoaM6bddJkmQX/taWc24IosormQD9P+DCvSxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aesQw9xmlOAxTHeV31ja0bH8pUK797QnD6pqf0WVBdh9zUUN1UdR0bbjewcj7k44rW4BHwvvPN/PU+8//WwBS77Syd5/bN2kgXDbVgfcXSqmjLScXgPybh+vwpQ7MiuI2VeSN2hU0nysiWgwPwlsbq9JZJb9wZqvXYKNE5Mimok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 494CA1688;
	Fri, 28 Feb 2025 04:23:36 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4CE13F6A8;
	Fri, 28 Feb 2025 04:23:18 -0800 (PST)
Message-ID: <289933df-3ffb-4a40-9d71-7f4bb3d4020d@arm.com>
Date: Fri, 28 Feb 2025 12:23:17 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] elf, uapi: Add definition for STN_UNDEF
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
 <20250226-parse_vdso-nolibc-v2-2-28e14e031ed8@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-2-28e14e031ed8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2025 11:44, Thomas Weißschuh wrote:
> The definition is used by tools/testing/selftests/vDSO/parse_vdso.c.
> To be able to build the vDSO selftests without a libc dependency,
> add the definition to the kernels own UAPI headers.
> 
> Link: https://refspecs.linuxfoundation.org/elf/gabi4+/ch4.symtab.html
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  include/uapi/linux/elf.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index b44069d29cecc0f9de90ee66bfffd2137f4275a8..448695c7364042b10682acc8223eb6053ad039dd 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -125,6 +125,8 @@ typedef __s64	Elf64_Sxword;
>  #define STB_GLOBAL 1
>  #define STB_WEAK   2
>  
> +#define STN_UNDEF 0
> +
>  #define STT_NOTYPE  0
>  #define STT_OBJECT  1
>  #define STT_FUNC    2
> 

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

-- 
Regards,
Vincenzo


