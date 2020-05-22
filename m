Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488F11DEC64
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 May 2020 17:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgEVPsP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 11:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730058AbgEVPsP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 11:48:15 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E1C206F6;
        Fri, 22 May 2020 15:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590162494;
        bh=hAQh+NskLuVas6SAuRdAcPjU7GA2DWYYhA+A9VY0zBU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eOC5H7vVEa2M+vp6cbRe2Pb+9Dv953vdlFrSwjihC5x9/IT/+QJQeDtz2AiIAolcQ
         jwxd03pdoctenKXXmEN9pucdQfBzAx6ipQOFoDJDxZ8w7UP+trNvSBI9xZidcGb4/6
         Rc+nVj76Y3vVE799v3t7KwW9n6hKFVYUeR4a/FwM=
Subject: Re: [PATCH v2 2/3] selftests: vdso: Use a header file to prototype
 parse_vdso API
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20200521203707.37304-1-broonie@kernel.org>
 <20200521203707.37304-3-broonie@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <3948bdcc-0d6a-836c-f935-65ce1e914537@kernel.org>
Date:   Fri, 22 May 2020 09:48:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521203707.37304-3-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/21/20 2:37 PM, Mark Brown wrote:
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

Please remove these externs. I understand it is must a move.
Might as well clean this up.

Send me v3 for just this one.

thanks,
-- Shuah
