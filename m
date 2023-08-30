Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA8478DAC8
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbjH3ShI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242212AbjH3H2B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 03:28:01 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 948751BB;
        Wed, 30 Aug 2023 00:27:58 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37U7Rjoa025275;
        Wed, 30 Aug 2023 09:27:45 +0200
Date:   Wed, 30 Aug 2023 09:27:45 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        Yuan Tan <tanyuan@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: add stdarg.h header
Message-ID: <ZO7vcTwa4GjWkPDe@1wt.eu>
References: <20230827-nolibc-nostdinc-v1-0-995d1811f1f3@weissschuh.net>
 <20230827-nolibc-nostdinc-v1-1-995d1811f1f3@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230827-nolibc-nostdinc-v1-1-995d1811f1f3@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 27, 2023 at 10:00:15AM +0200, Thomas Weiﬂschuh wrote:
> This allows nolic to work with `-nostdinc` avoiding any reliance on
> system headers.
> 
> The implementation has been lifted from musl libc 1.2.4.
> There is already an implementation of stdarg.h in include/linux/stdarg.h
> but that is GPL licensed and therefore not suitable for nolibc.
> 
> The used compiler builtins have been validated to be at least available
> since GCC 4.1.2 and clang 3.0.0.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/include/nolibc/Makefile |  1 +
>  tools/include/nolibc/stdarg.h | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
> index 909b6eb500fe..e69c26abe1ea 100644
> --- a/tools/include/nolibc/Makefile
> +++ b/tools/include/nolibc/Makefile
> @@ -34,6 +34,7 @@ all_files := \
>  		signal.h \
>  		stackprotector.h \
>  		std.h \
> +		stdarg.h \
>  		stdint.h \
>  		stdlib.h \
>  		string.h \
> diff --git a/tools/include/nolibc/stdarg.h b/tools/include/nolibc/stdarg.h
> new file mode 100644
> index 000000000000..c628b5783da6
> --- /dev/null
> +++ b/tools/include/nolibc/stdarg.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * Variadic argument support for NOLIBC
> + * Copyright (C) 2005-2020 Rich Felker, et al.
> + */
> +
> +#ifndef _NOLIBC_STDARG_H
> +#define _NOLIBC_STDARG_H
> +
> +typedef __builtin_va_list va_list;
> +#define va_start(v, l)   __builtin_va_start(v, l)
> +#define va_end(v)        __builtin_va_end(v)
> +#define va_arg(v, l)     __builtin_va_arg(v, l)
> +#define va_copy(d, s)    __builtin_va_copy(d, s)
> +
> +#endif /* _NOLIBC_STDARG_H */

Now with your other explanation I agree, however we need to change:

  #include <stdarg.h>

to

  #include "stdarg.h"

in stdio.h and sys.h so that we always use ours from now on.

Willy
