Return-Path: <linux-kselftest+bounces-27888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE15CA4994E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962171896E02
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C8F26B94B;
	Fri, 28 Feb 2025 12:29:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804E826B0BF;
	Fri, 28 Feb 2025 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745745; cv=none; b=jjW0gH6Yc0EuhLqz7WysNP+VXY/U/I7yTBO2vNjpiMwZig3Mp0uAwI09vqB5shP8o0JW+ylGZgasGgZyrsp1rkUPzxnYT87+MqS81qHFsr4kxWX0+a2HEK7vQMliu4oXkrIOY8sizBXlK0+5Uvg9FfC0M94wfsJpujrV2Mbzvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745745; c=relaxed/simple;
	bh=vhKbyqqu/sCV4uc5AMIoV8m0IKyR09BN6A/6tbCL3x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnuDiMggyqsaIWTCjWDOyALovjzg94qEP/Zrd6/SThgFRGf42zeiGNc7T7mB1/xJt71cW39yGMwoYgn2Vi6CvSncnHY0B4CoTlHfgFvDgUxWsys8jg6ixC2376e+gSxUrpD4mus08AuQ1TU6wwODGSNK36vEyunsv9/CuAiaEkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 292C11688;
	Fri, 28 Feb 2025 04:29:19 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B2553F6A8;
	Fri, 28 Feb 2025 04:29:01 -0800 (PST)
Message-ID: <3440d93a-86e2-4dd3-80f8-dc7daa0aff41@arm.com>
Date: Fri, 28 Feb 2025 12:29:00 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] selftests: vDSO: parse_vdso: Use UAPI headers
 instead of libc headers
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
 <20250226-parse_vdso-nolibc-v2-12-28e14e031ed8@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-12-28e14e031ed8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2025 11:44, Thomas Weißschuh wrote:
> To allow the usage of parse_vdso.c together with a limited libc like
> nolibc, use the kernels own elf.h and auxvec.h headers.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  tools/testing/selftests/vDSO/Makefile     | 3 +++
>  tools/testing/selftests/vDSO/parse_vdso.c | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index 1cf14a8da43803249f72fe1b09689c8834806986..bc8ca186fb877dc11740c37f1e07e45e84c2ae92 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -19,6 +19,9 @@ LDLIBS += -lgcc_s
>  endif
>  
>  include ../lib.mk
> +
> +CFLAGS += $(TOOLS_INCLUDES)
> +
>  $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
>  $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
>  $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
> diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
> index 3638fe605e80ca41b29d43c6ac452964eef35d56..200c534cc70e2c2381fce3be5c0ebe4cb5675e84 100644
> --- a/tools/testing/selftests/vDSO/parse_vdso.c
> +++ b/tools/testing/selftests/vDSO/parse_vdso.c
> @@ -19,7 +19,8 @@
>  #include <stdint.h>
>  #include <string.h>
>  #include <limits.h>
> -#include <elf.h>
> +#include <linux/auxvec.h>
> +#include <linux/elf.h>
>  
>  #include "parse_vdso.h"
>  
> 

-- 
Regards,
Vincenzo


