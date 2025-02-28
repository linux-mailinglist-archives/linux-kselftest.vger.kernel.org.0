Return-Path: <linux-kselftest+bounces-27886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BD6A49939
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86E816BBBB
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1116E26AAAB;
	Fri, 28 Feb 2025 12:28:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3072356D1;
	Fri, 28 Feb 2025 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745693; cv=none; b=SgaelUAk+D18CBOUjhS9RYpmIc8F+GpCv4lI+gzO6HsyDQWnnNkjiMiBLfgRr/AFosQ9udV3MSS9OP2yQIcOd+QU9tl0MB6WXCai4ATZLS+H+QHVTqUjv8mDyB8UHAfyJF4nA3GjQiDk0UWM1x2kTXoO0PZwDvqoCT9EGr7esaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745693; c=relaxed/simple;
	bh=dPQQeCJ6zMXLp4WRSXuju/fSqlI129Q0WmkmNQYgv0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7jZoFlmiv75IYrK8frv67vGZLwUXgHRK3yrVhIykjcg/1zLCFV3cg1jaSQ+ORaZ6J8devralzYUgJOI1t2I46bluyYhEZvooVi0TJkkuCjMYvsFu5cER8LfXOVuHOENZXYUGi0jBvB+oG6Zhsr2bV1O7IJpImgALAv/lA1YBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 030F71688;
	Fri, 28 Feb 2025 04:28:26 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 612313F6A8;
	Fri, 28 Feb 2025 04:28:08 -0800 (PST)
Message-ID: <fe56c774-dcd8-475f-8008-e5baa87908ef@arm.com>
Date: Fri, 28 Feb 2025 12:28:06 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] selftests: vDSO: vdso_standalone_test_x86: Use
 vdso_init_form_sysinfo_ehdr
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
 <20250226-parse_vdso-nolibc-v2-10-28e14e031ed8@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-10-28e14e031ed8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2025 11:44, Thomas Weißschuh wrote:
> vdso_standalone_test_x86 is the only user of vdso_init_from_auxv().
> Instead of combining the parsing the aux vector with the parsing of the
> vDSO, split them apart into getauxval() and the regular
> vdso_init_from_sysinfo_ehdr().
> 
> The implementation of getauxval() is taken from
> tools/include/nolibc/stdlib.h.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
> All of this code will be deleted later again.
> ---
>  .../selftests/vDSO/vdso_standalone_test_x86.c      | 27 +++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> index 644915862af8883131e5defd336f1bd80736fc0f..500608f89c66b5747e3d845ebc54e4c3a35b6ccd 100644
> --- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> +++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> @@ -15,6 +15,7 @@
>  #include <sys/time.h>
>  #include <unistd.h>
>  #include <stdint.h>
> +#include <linux/auxvec.h>
>  
>  #include "parse_vdso.h"
>  
> @@ -84,6 +85,30 @@ void to_base10(char *lastdig, time_t n)
>  	}
>  }
>  
> +unsigned long getauxval(const unsigned long *auxv, unsigned long type)
> +{
> +	unsigned long ret;
> +
> +	if (!auxv)
> +		return 0;
> +
> +	while (1) {
> +		if (!auxv[0] && !auxv[1]) {
> +			ret = 0;
> +			break;
> +		}
> +
> +		if (auxv[0] == type) {
> +			ret = auxv[1];
> +			break;
> +		}
> +
> +		auxv += 2;
> +	}
> +
> +	return ret;
> +}
> +
>  void c_main(void **stack)
>  {
>  	/* Parse the stack */
> @@ -96,7 +121,7 @@ void c_main(void **stack)
>  	stack++;
>  
>  	/* Now we're pointing at auxv.  Initialize the vDSO parser. */
> -	vdso_init_from_auxv((void *)stack);
> +	vdso_init_from_sysinfo_ehdr(getauxval((unsigned long *)stack, AT_SYSINFO_EHDR));
>  
>  	/* Find gettimeofday. */
>  	typedef long (*gtod_t)(struct timeval *tv, struct timezone *tz);
> 

-- 
Regards,
Vincenzo


