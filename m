Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BF9745024
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jul 2023 20:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGBS5r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Jul 2023 14:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjGBS5o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Jul 2023 14:57:44 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AAFE5B;
        Sun,  2 Jul 2023 11:57:16 -0700 (PDT)
Date:   Sun, 2 Jul 2023 20:57:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1688324230; bh=67ILj3chIboW2gmsBz04V0Mib+VgnjMHIAk/zViRZ/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I4wmFcsE48BwNsSf/NiYdrV2MaT8cgcaO8c1oFIG9IFyjeQvnkNvSB3BFW6Eszhte
         e8k9qEe8ohCQcD7VshlVt7ULvk7BOT3Cf3/BZMVcIMX8bkU9ULaLkLPcLUGJhas/pQ
         fG68qTYRXpNDXQe8ka2YkquxZxqTDRlGvbLWswV8=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 03/11] tools/nolibc: include crt.h before arch.h
Message-ID: <e1cf8fd3-f8cd-4c3c-9f8c-24bbc0a7cde3@t-8ch.de>
References: <cover.1687976753.git.falcon@tinylab.org>
 <c61b5bc53895e8c6b2f30d59f86067973e6bbce0.1687976753.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c61b5bc53895e8c6b2f30d59f86067973e6bbce0.1687976753.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-06-29 02:54:35+0800, Zhangjin Wu wrote:
> The crt.h provides a new _start_c() function, which is required by the
> new assembly _start entry of arch-<ARCH>.h (included by arch.h), let's
> include crt.h before arch.h.
> 
> This '#include "crt.h"' doesn't let the new _start_c() work immediately,
> but it is a base of the coming patches to move most of the assembly
> _start operations to the _start_c() function for every supported
> architecture.

Why don't the arch-*.h files include this new header?
They are the users of the new symbol.

> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/include/nolibc/Makefile | 1 +
>  tools/include/nolibc/nolibc.h | 1 +
>  tools/include/nolibc/signal.h | 1 +
>  tools/include/nolibc/stdio.h  | 1 +
>  tools/include/nolibc/stdlib.h | 1 +
>  tools/include/nolibc/sys.h    | 1 +
>  tools/include/nolibc/time.h   | 1 +
>  tools/include/nolibc/unistd.h | 1 +
>  8 files changed, 8 insertions(+)
> 
> diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
> index 875e13e3c851..00471e59b11e 100644
> --- a/tools/include/nolibc/Makefile
> +++ b/tools/include/nolibc/Makefile
> @@ -37,6 +37,7 @@ NARCH            = $(or $(NARCH_$(ARCH)),$(ARCH))
>  arch_file := arch-$(NARCH).h
>  all_files := \
>  		compiler.h \
> +		crt.h \

This should be part of the patch adding the file.

>  		ctype.h \
>  		errno.h \
>  		nolibc.h \
> diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
> index 1f8d821000ac..2cc9ccd90d56 100644
> --- a/tools/include/nolibc/nolibc.h
> +++ b/tools/include/nolibc/nolibc.h
> @@ -93,6 +93,7 @@
>  #define _NOLIBC_H
>  
>  #include "std.h"
> +#include "crt.h"
>  #include "arch.h"
>  #include "types.h"
>  #include "sys.h"
> diff --git a/tools/include/nolibc/signal.h b/tools/include/nolibc/signal.h
> index 137552216e46..f0a1418c1cb2 100644
> --- a/tools/include/nolibc/signal.h
> +++ b/tools/include/nolibc/signal.h
> @@ -8,6 +8,7 @@
>  #define _NOLIBC_SIGNAL_H
>  
>  #include "std.h"
> +#include "crt.h"
>  #include "arch.h"
>  #include "types.h"
>  #include "sys.h"
> diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> index 0eef91daf289..89d3749b3620 100644
> --- a/tools/include/nolibc/stdio.h
> +++ b/tools/include/nolibc/stdio.h
> @@ -10,6 +10,7 @@
>  #include <stdarg.h>
>  
>  #include "std.h"
> +#include "crt.h"
>  #include "arch.h"
>  #include "errno.h"
>  #include "types.h"
> diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
> index 902162f80337..0ff7fac40bd4 100644
> --- a/tools/include/nolibc/stdlib.h
> +++ b/tools/include/nolibc/stdlib.h
> @@ -8,6 +8,7 @@
>  #define _NOLIBC_STDLIB_H
>  
>  #include "std.h"
> +#include "crt.h"
>  #include "arch.h"
>  #include "types.h"
>  #include "sys.h"
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 2c302f3feb71..b6c33c40c037 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -24,6 +24,7 @@
>  #include <linux/reboot.h> /* for LINUX_REBOOT_* */
>  #include <linux/prctl.h>
>  
> +#include "crt.h"
>  #include "arch.h"
>  #include "errno.h"
>  #include "types.h"
> diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
> index 84655361b9ad..bbe8f9aa3e9b 100644
> --- a/tools/include/nolibc/time.h
> +++ b/tools/include/nolibc/time.h
> @@ -8,6 +8,7 @@
>  #define _NOLIBC_TIME_H
>  
>  #include "std.h"
> +#include "crt.h"
>  #include "arch.h"
>  #include "types.h"
>  #include "sys.h"
> diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
> index e38f3660c051..f1677224bb5a 100644
> --- a/tools/include/nolibc/unistd.h
> +++ b/tools/include/nolibc/unistd.h
> @@ -8,6 +8,7 @@
>  #define _NOLIBC_UNISTD_H
>  
>  #include "std.h"
> +#include "crt.h"
>  #include "arch.h"
>  #include "types.h"
>  #include "sys.h"
> -- 
> 2.25.1
> 
