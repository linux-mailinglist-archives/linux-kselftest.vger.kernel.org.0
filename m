Return-Path: <linux-kselftest+bounces-27891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C89E8A49955
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD656175070
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5D726B0A1;
	Fri, 28 Feb 2025 12:30:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CD4268C6D;
	Fri, 28 Feb 2025 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745828; cv=none; b=G9HCtFimmxd+H9zYJks+V6VWLU6YD5c0DJPDq9vjYBDVNuTPz8UWwU3T/PNFnUVPDW1umjQWm0vPeFy3nPfm7XpmFmF86ZywwJByMjyUISbELs/tVmDThV5lELs9sPJtujH9U1ZKaj1nxphpL06LvhRuag0XdQ0e35grkIjorG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745828; c=relaxed/simple;
	bh=QJlaGNw2Jqlyim50A/tecSVxZiHWEaao7R+wuGUHqK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cS4L3TsoQZUMF6WKeLVsRrjZac+vbPyWE5be+dAqsHyErTuxrcJUDOGTaQytN5ALQ8mwuyCXYMGxyUHBAzMiVtD5zuOJr3WGU9KlfeH8sHnWwiJM0s0opAKXlBb9PheqSWNN6IzfhuU6qblIQmvkM/ypTwN8wqdS8vk+EpC5G8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AB831477;
	Fri, 28 Feb 2025 04:30:41 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D68363F6A8;
	Fri, 28 Feb 2025 04:30:23 -0800 (PST)
Message-ID: <02b4e5ba-b740-4da4-8a6b-9a5e325b3e8f@arm.com>
Date: Fri, 28 Feb 2025 12:30:22 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] selftests: vDSO: vdso_test_gettimeofday: Make
 compatible with nolibc
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
 <20250226-parse_vdso-nolibc-v2-15-28e14e031ed8@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-15-28e14e031ed8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2025 11:44, Thomas Weißschuh wrote:
> nolibc does not provide sys/time.h and sys/auxv.h,
> instead their definitions are available unconditionally.
> 
> Guard the includes so they are not attempted on nolibc.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  tools/testing/selftests/vDSO/vdso_test_gettimeofday.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
> index 636a56ccf8e4e7943ca446fe3fad6897598ca77f..9ce795b806f0992b83cef78c7e16fac0e54750da 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
> @@ -11,8 +11,10 @@
>   */
>  
>  #include <stdio.h>
> +#ifndef NOLIBC
>  #include <sys/auxv.h>
>  #include <sys/time.h>
> +#endif
>  
>  #include "../kselftest.h"
>  #include "parse_vdso.h"
> 

-- 
Regards,
Vincenzo


