Return-Path: <linux-kselftest+bounces-27882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353B8A49922
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A839416D098
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093E226AAA9;
	Fri, 28 Feb 2025 12:25:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D65A26AA83;
	Fri, 28 Feb 2025 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745508; cv=none; b=ggqTysFQALmvg/ZYvAoxRkKJ4xpOx3vZ6lrWtSFZEsvtOCKHf/Rux+aWQsNlHIc8+q8fksRQOF8KHn61IHHSgbj79e9ftM8+73ZwsMsiEz4nmlzjlsDm1ot8grjOg3N8KVXemS91cEOlqjCjenPP9j6RqaWazyZsWcgKHDt/eys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745508; c=relaxed/simple;
	bh=EgYTsb8SgK35ajAyJ1BGm2OuxPtzfoOzV36j+4vxHck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwumXfbgoSzEFlVzHjFRNMv/4qWjoJbhM9sOfORNf2+Djy6xb0azHGfoSXFJml5JX/RyVuzTwthUz2Y811rDe/h8KH6522FkPWqpvRZxJVh+dc532XA5yeyAPPtW7S+A+3Lv6ToEMsJXIYKlWPhacJdNaMtAV2uuElA72FpevvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D5871688;
	Fri, 28 Feb 2025 04:25:22 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 773A93F6A8;
	Fri, 28 Feb 2025 04:25:04 -0800 (PST)
Message-ID: <e62791df-1570-4ac2-998f-86ece5903cb3@arm.com>
Date: Fri, 28 Feb 2025 12:25:03 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] elf, uapi: Add types ElfXX_Verdef and
 ElfXX_Veraux
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
 <20250226-parse_vdso-nolibc-v2-6-28e14e031ed8@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-6-28e14e031ed8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2025 11:44, Thomas Weißschuh wrote:
> The types are used by tools/testing/selftests/vDSO/parse_vdso.c.
> To be able to build the vDSO selftests without a libc dependency,
> add the types to the kernels own UAPI headers.
> 
> Link: https://refspecs.linuxfoundation.org/LSB_5.0.0/LSB-Core-generic/LSB-Core-generic/symversion.html#VERDEFEXTS
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  include/uapi/linux/elf.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index 8846fe03ca5b836c96aad1be6d8fb9daf3d4b1d9..49f9f90458d8ca8e7b8f823d32be0a719ff827b3 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -491,4 +491,34 @@ typedef struct elf64_note {
>  /* Bits for GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
>  #define GNU_PROPERTY_AARCH64_FEATURE_1_BTI	(1U << 0)
>  
> +typedef struct {
> +  Elf32_Half	vd_version;
> +  Elf32_Half	vd_flags;
> +  Elf32_Half	vd_ndx;
> +  Elf32_Half	vd_cnt;
> +  Elf32_Word	vd_hash;
> +  Elf32_Word	vd_aux;
> +  Elf32_Word	vd_next;
> +} Elf32_Verdef;
> +
> +typedef struct {
> +  Elf64_Half	vd_version;
> +  Elf64_Half	vd_flags;
> +  Elf64_Half	vd_ndx;
> +  Elf64_Half	vd_cnt;
> +  Elf64_Word	vd_hash;
> +  Elf64_Word	vd_aux;
> +  Elf64_Word	vd_next;
> +} Elf64_Verdef;
> +
> +typedef struct {
> +  Elf32_Word    vda_name;
> +  Elf32_Word    vda_next;
> +} Elf32_Verdaux;
> +
> +typedef struct {
> +  Elf64_Word    vda_name;
> +  Elf64_Word    vda_next;
> +} Elf64_Verdaux;
> +
>  #endif /* _UAPI_LINUX_ELF_H */
> 

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

-- 
Regards,
Vincenzo


