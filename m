Return-Path: <linux-kselftest+bounces-27884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F814A49933
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EFF17AABD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6301B26B2B2;
	Fri, 28 Feb 2025 12:26:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC48A26A1CD;
	Fri, 28 Feb 2025 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745599; cv=none; b=j5TwsFjM6PvoDLIOoDdJrHOsYovoDC+dPcPS+A2uAcfdm1VxFNVfYcWybGGIKnX0lnPH1FdTdCK83u+RF74NlUbTUoWOePe8BGCFxDFtUMsJ+0XETmLLM7xOlMpLj28VEV8auuS3T0Sbk/eXKAQRlVuZSzYrVzaf8/StJnutBPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745599; c=relaxed/simple;
	bh=k4EvqHsnZo9PvoU+o/S0qUQMn8zrVz7NVxme6pIPv9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTVzdRJS1luHAesE1qxb+RhlJXKUz0W0Sc/hjdHS1x942QFPRAvDQMIOYCrgZMD9ml8oLSJKhR5gU2MgcvH20us38vSSZaGK/YACAf5wPkSuCWjeyfQdQMlv71p/VXWrAhqtZLyoREbHpzU2bgV2wG2dDQ88epbqKeAZVYQF0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 876B01688;
	Fri, 28 Feb 2025 04:26:52 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E35DA3F6A8;
	Fri, 28 Feb 2025 04:26:34 -0800 (PST)
Message-ID: <0f8a6c7c-7490-4c12-875e-874bb8373f2c@arm.com>
Date: Fri, 28 Feb 2025 12:26:33 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] selftests: Add headers target
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
 <20250226-parse_vdso-nolibc-v2-8-28e14e031ed8@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-8-28e14e031ed8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2025 11:44, Thomas Weißschuh wrote:
> Some selftests need access to a full UAPI headers tree, for example when
> building with nolibc which heavily relies on UAPI headers.
> A reference to such a tree is available in the KHDR_INCLUDES variable,
> but there is currently no way to populate such a tree automatically.
> 
> Provide a target that the tests can depend on to get access to usable
> UAPI headers.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  tools/testing/selftests/lib.mk | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index d6edcfcb5be832ddee4c3d34b5ad221e9295f878..5303900339292e618dee4fd7ff8a7c2fa3209a68 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -228,4 +228,7 @@ $(OUTPUT)/%:%.S
>  	$(LINK.S) $^ $(LDLIBS) -o $@
>  endif
>  
> -.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir
> +headers:
> +	$(Q)$(MAKE) -C $(top_srcdir) headers
> +
> +.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir headers
> 

-- 
Regards,
Vincenzo


