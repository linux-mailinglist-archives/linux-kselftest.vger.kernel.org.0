Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D781D9DE4
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 19:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgESR3M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 May 2020 13:29:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729185AbgESR3M (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 May 2020 13:29:12 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC702075F;
        Tue, 19 May 2020 17:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589909351;
        bh=l8ymiYuKfdsRmQw6Cm7rnQiWDG9HYPK4dsgenRxrdtc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e2RJRqHKW/iq4dxwrAz5Tz68/UNyype6IhQyjrf2FLIvRoDYx+DTDA59HR/2nS8Lc
         smnr1j+quIaQYInOMqH27LibpZ9Pnmei2/QNZcSVXALxaEkwZl9egD1EU9k1kpd0Tc
         70OtAQK89StfzM2ui/YD1T2jhvOUOLTvGxl2O1dk=
Subject: Re: [PATCH 2/3] selftests: vdso: Use a header file to prototype
 parse_vdso API
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20200505174728.46594-1-broonie@kernel.org>
 <20200505174728.46594-3-broonie@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <aaeb0619-68d2-18f8-f72a-b8b37f348b4e@kernel.org>
Date:   Tue, 19 May 2020 11:29:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505174728.46594-3-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/5/20 11:47 AM, Mark Brown wrote:
> Both vdso_test_gettimeofday and vdso_standalone_test_x86 use the library in
> parse_vdso.c but each separately declares the API it offers which is not
> ideal. Create a header file with prototypes of the functions and use it in
> both the library and the tests to ensure that the same prototypes are used
> throughout.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/vDSO/parse_vdso.c     | 24 +-------------
>   tools/testing/selftests/vDSO/parse_vdso.h     | 31 +++++++++++++++++++
>   .../selftests/vDSO/vdso_standalone_test_x86.c |  4 +--
>   .../selftests/vDSO/vdso_test_gettimeofday.c   |  5 +--
>   4 files changed, 34 insertions(+), 30 deletions(-)
>   create mode 100644 tools/testing/selftests/vDSO/parse_vdso.h
> 
> diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
> index 1dbb4b87268f..413f75620a35 100644
> --- a/tools/testing/selftests/vDSO/parse_vdso.c
> +++ b/tools/testing/selftests/vDSO/parse_vdso.c
> @@ -21,29 +21,7 @@
>   #include <limits.h>
>   #include <elf.h>
>   
> -/*
> - * To use this vDSO parser, first call one of the vdso_init_* functions.
> - * If you've already parsed auxv, then pass the value of AT_SYSINFO_EHDR
> - * to vdso_init_from_sysinfo_ehdr.  Otherwise pass auxv to vdso_init_from_auxv.
> - * Then call vdso_sym for each symbol you want.  For example, to look up
> - * gettimeofday on x86_64, use:
> - *
> - *     <some pointer> = vdso_sym("LINUX_2.6", "gettimeofday");
> - * or
> - *     <some pointer> = vdso_sym("LINUX_2.6", "__vdso_gettimeofday");
> - *
> - * vdso_sym will return 0 if the symbol doesn't exist or if the init function
> - * failed or was not called.  vdso_sym is a little slow, so its return value
> - * should be cached.
> - *
> - * vdso_sym is threadsafe; the init functions are not.
> - *
> - * These are the prototypes:
> - */
> -extern void vdso_init_from_auxv(void *auxv);
> -extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
> -extern void *vdso_sym(const char *version, const char *name);
> -
> +#include "parse_vdso.h"
>   
>   /* And here's the code. */
>   #ifndef ELF_BITS
> diff --git a/tools/testing/selftests/vDSO/parse_vdso.h b/tools/testing/selftests/vDSO/parse_vdso.h
> new file mode 100644
> index 000000000000..ea4b8635bb0b
> --- /dev/null
> +++ b/tools/testing/selftests/vDSO/parse_vdso.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef PARSE_VDSO_H
> +#define PARSE_VDSO_H
> +
> +#include <stdint.h>
> +
> +/*
> + * To use this vDSO parser, first call one of the vdso_init_* functions.
> + * If you've already parsed auxv, then pass the value of AT_SYSINFO_EHDR
> + * to vdso_init_from_sysinfo_ehdr.  Otherwise pass auxv to vdso_init_from_auxv.
> + * Then call vdso_sym for each symbol you want.  For example, to look up
> + * gettimeofday on x86_64, use:
> + *
> + *     <some pointer> = vdso_sym("LINUX_2.6", "gettimeofday");
> + * or
> + *     <some pointer> = vdso_sym("LINUX_2.6", "__vdso_gettimeofday");
> + *
> + * vdso_sym will return 0 if the symbol doesn't exist or if the init function
> + * failed or was not called.  vdso_sym is a little slow, so its return value
> + * should be cached.
> + *
> + * vdso_sym is threadsafe; the init functions are not.
> + *
> + * These are the prototypes:
> + */
> +extern void *vdso_sym(const char *version, const char *name);
> +extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
> +extern void vdso_init_from_auxv(void *auxv);
> +

You don't need extern here - this should be in scope?

> +#endif
> diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> index 5ac4b00acfbc..8a44ff973ee1 100644
> --- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> +++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> @@ -16,9 +16,7 @@
>   #include <unistd.h>
>   #include <stdint.h>
>   
> -extern void *vdso_sym(const char *version, const char *name);
> -extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
> -extern void vdso_init_from_auxv(void *auxv);


thanks,
-- Shuah
