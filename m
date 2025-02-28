Return-Path: <linux-kselftest+bounces-27885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 882F8A49935
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF07E1899437
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE7226B2C5;
	Fri, 28 Feb 2025 12:27:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B290726B2CB;
	Fri, 28 Feb 2025 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745626; cv=none; b=GLZIpSfQtiYxiVyp9nZDUY2p/pdzOU0WXjM/lsZ7zzbXTQXyKmr1OpBKa6in2st/Uo5Jm2EyOl1U1bkGqdCRW/1lDHqxNj6swuncAGr/OP1gdVhVELdWKiLiUQ2qJV3sxX/VHdMy9Fi8cqrjpFCO+VDbxUtA2GrMXXu4UvAIabk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745626; c=relaxed/simple;
	bh=uJ5ssx/1V5lN3iy4yBnWCDCp4/Q8YuL2p1SBWJOTBRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyguPOBP9mNQVkueXtVTwgfZdyDQD0KC4RwwF5ElVvkpKTxFpcLkDmLmELv+DpvWNMS+LeeFwfYDkIxk3z9PzJj7ATm1QTXLztsdb1sq+yjorjrHgW9vEJRfh6s0CPytR13W4E5LYR5bsjtmQ/7cKuEPeM1E1uVqWsZPb+eNVhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60BD21688;
	Fri, 28 Feb 2025 04:27:19 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF3583F6A8;
	Fri, 28 Feb 2025 04:27:01 -0800 (PST)
Message-ID: <608911a5-c0c9-4115-98a2-3e31b6b360af@arm.com>
Date: Fri, 28 Feb 2025 12:27:00 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] tools/nolibc: add limits.h shim header
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
 <20250226-parse_vdso-nolibc-v2-9-28e14e031ed8@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-9-28e14e031ed8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2025 11:44, Thomas Weißschuh wrote:
> limits.h is a widely used standard header.
> Missing it from nolibc requires adoption effort to port applications.
> 
> Add a shim header which includes the global nolibc.h header.
> It makes all nolibc symbols available.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  tools/include/nolibc/Makefile | 1 +
>  tools/include/nolibc/limits.h | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
> index a1f55fb24bb38c1f49c653af5825e8bcc569a56d..c1299a053145786da89001a5f95f5527ffbe2fa4 100644
> --- a/tools/include/nolibc/Makefile
> +++ b/tools/include/nolibc/Makefile
> @@ -30,6 +30,7 @@ all_files := \
>  		crt.h \
>  		ctype.h \
>  		errno.h \
> +		limits.h \
>  		nolibc.h \
>  		signal.h \
>  		stackprotector.h \
> diff --git a/tools/include/nolibc/limits.h b/tools/include/nolibc/limits.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..306d4141f4d245ca3f801f451745540b0f7294cd
> --- /dev/null
> +++ b/tools/include/nolibc/limits.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * Shim limits.h header for NOLIBC.
> + * Copyright (C) 2025 Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> + */
> +
> +#include "nolibc.h"
> 

-- 
Regards,
Vincenzo


