Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1863C6B660E
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Mar 2023 13:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCLM46 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Mar 2023 08:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjCLM46 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Mar 2023 08:56:58 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D0653755E;
        Sun, 12 Mar 2023 05:56:55 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32CCuhwm002207;
        Sun, 12 Mar 2023 13:56:43 +0100
Date:   Sun, 12 Mar 2023 13:56:43 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 4/5] tools/nolibc: add support for stack protector
Message-ID: <ZA3MC89PEq058cdo@1wt.eu>
References: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
 <20230223-nolibc-stackprotector-v1-4-3e74d81b3f21@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230223-nolibc-stackprotector-v1-4-3e74d81b3f21@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

thanks for this patchset. I must confess it's not very clear to me which
class of programs using nolibc could benefit from stack protection, but
if you think it can improve the overall value (even if just by allowing
to test more combinations), I'm fine with this given that it doesn't
remove anything.

I'm having a few comments below:

On Tue, Mar 07, 2023 at 10:22:33PM +0000, Thomas Weiﬂschuh wrote:
> diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
> new file mode 100644
> index 000000000000..ca1360b7afd8
> --- /dev/null
> +++ b/tools/include/nolibc/stackprotector.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * Stack protector support for NOLIBC
> + * Copyright (C) 2023 Thomas Weiﬂschuh <linux@weissschuh.net>
> + */
> +
> +#ifndef _NOLIBC_STACKPROTECTOR_H
> +#define _NOLIBC_STACKPROTECTOR_H
> +
> +#include "arch.h"
> +
> +#if defined(NOLIBC_STACKPROTECTOR)
> +
> +#if !defined(__ARCH_SUPPORTS_STACK_PROTECTOR)
> +#error "nolibc does not support stack protectors on this arch"
> +#endif
> +
> +#include "sys.h"
> +#include "stdlib.h"
> +
> +__attribute__((weak,noreturn,section(".text.nolibc_stack_chk")))
> +void __stack_chk_fail(void)
> +{
> +	write(STDERR_FILENO, "!!Stack smashing detected!!\n", 28);
> +	abort();
> +}

Don't you think you should call the syscall directly here like you
did for __stack_chk_init() and/or declare the function with the
no_stackprotector attribute ? I'm wondering if there could be a
risk that it fails again if called from a bad condition. If you're
certain it cannot, maybe just explain it in a 2-line comment above
the function so that others don't ask the same in the future.

> +__attribute__((weak,no_stack_protector,section(".text.nolibc_stack_chk")))
> +void __stack_chk_init(void)
> +{
> +	// raw syscall assembly as calling a function would trigger the
> +	// stackprotector itself
> +	my_syscall3(__NR_getrandom, &__stack_chk_guard, sizeof(__stack_chk_guard), 0);

For full-line comments, the regular C-style "/* */" is preferred (and
please also use the multi-line format when needed). "//" tends to be
reserved for short ones at the end of a line.

> +	// a bit more randomness in case getrandom() fails
> +	__stack_chk_guard |= (uintptr_t) &__stack_chk_guard;

Using |= will in fact remove randomness rather than add, because it
will turn some zero bits to ones but not the opposite. Maybe you'd
want to use "^=" or "+=" instead ?

Thanks,
Willy
