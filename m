Return-Path: <linux-kselftest+bounces-27889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C01A49953
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 664A97AB690
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4907826B2C5;
	Fri, 28 Feb 2025 12:29:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C156426AAAB;
	Fri, 28 Feb 2025 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745777; cv=none; b=Whh7ELdyelqa8oQu7gFaWCpHb3F2H5AbVrDEQvOxDaYdwABuaT9hnb8EO7f8L3f1JCFDR+S49MiWGeVsM7eELm5WwZngM3F+Za0vK0fsFkHSOotg58gQWX9zYG0NLYGRUpC8qdzoiwD8cjRpgQj1oXPOE19PonSVtiX2fdqwLwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745777; c=relaxed/simple;
	bh=jboa5arFTOP7VXYuP1ykfGNrKtENDDZnV+mJDw226bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjHq9aICWb9kAZsNo7Rj7TMHe/W+TpGtuI/ngrj7+SOPDAXRCOdjp1Gu0lt918BvDvKobEYOk4rQ0maXVfpgTlPDzEhwun7hMPhDqnH7XaeyUSqLD92TiR8trm80Rxw9ebCVAxZahJ7iOd11lRLRT+5kt1eTN/mzzdMnK2/VGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D6A11688;
	Fri, 28 Feb 2025 04:29:50 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBE3B3F6A8;
	Fri, 28 Feb 2025 04:29:32 -0800 (PST)
Message-ID: <9f9192cc-245c-4adf-b72f-61f0537e7f26@arm.com>
Date: Fri, 28 Feb 2025 12:29:31 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] selftests: vDSO: parse_vdso: Test
 __SIZEOF_LONG__ instead of ULONG_MAX
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
 <20250226-parse_vdso-nolibc-v2-13-28e14e031ed8@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-13-28e14e031ed8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2025 11:44, Thomas Weißschuh wrote:
> According to limits.h(2) ULONG_MAX is only guaranteed to expand to an
> expression, not a symbolic constant which can be evaluated by the
> preprocessor.
> Specifically the definition of ULONG_MAX from nolibc can no be evaluated
> by the preprocessor. To provide compatibility with nolibc, check with
> __SIZEOF_LONG__ instead, with is provided directly by the preprocessor
> and therefore always a symbolic constant.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  tools/testing/selftests/vDSO/parse_vdso.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
> index 200c534cc70e2c2381fce3be5c0ebe4cb5675e84..902b8f9984a1f70049d46bcd4f199df24f507dcb 100644
> --- a/tools/testing/selftests/vDSO/parse_vdso.c
> +++ b/tools/testing/selftests/vDSO/parse_vdso.c
> @@ -26,7 +26,7 @@
>  
>  /* And here's the code. */
>  #ifndef ELF_BITS
> -# if ULONG_MAX > 0xffffffffUL
> +# if __SIZEOF_LONG__ >= 8
>  #  define ELF_BITS 64
>  # else
>  #  define ELF_BITS 32
> 

-- 
Regards,
Vincenzo


