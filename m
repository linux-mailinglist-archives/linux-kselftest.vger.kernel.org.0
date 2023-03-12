Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975206B6C62
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 00:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCLXHF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Mar 2023 19:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCLXHE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Mar 2023 19:07:04 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4086C17171;
        Sun, 12 Mar 2023 16:07:03 -0700 (PDT)
Date:   Sun, 12 Mar 2023 23:06:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678662420;
        bh=5dEBzzp91jUe7QOaIJDo+f1xSfiM90NXcZjIcBmzSb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBu9n+33MZYj5fNLhH7dWNCWRVDrODRgzCxilFLbryM+kyaPoV9IMEgGINZcvZhvB
         Ckhf4rHGZLS4GXVU/6+qypywkZ7aPXT4uaqiPeAmkToYM9d64tt5Fj4arb84Bid2ZO
         CGsxZenH5a5pySV3bGQe7afPVw6IX4Eq9DEJV62o=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 4/5] tools/nolibc: add support for stack protector
Message-ID: <68b4b33d-711b-4b5d-b932-6beceffbcf28@t-8ch.de>
References: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
 <20230223-nolibc-stackprotector-v1-4-3e74d81b3f21@weissschuh.net>
 <ZA3MC89PEq058cdo@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZA3MC89PEq058cdo@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 12, 2023 at 01:56:43PM +0100, Willy Tarreau wrote:
> Hi Thomas,
> 
> thanks for this patchset. I must confess it's not very clear to me which
> class of programs using nolibc could benefit from stack protection, but
> if you think it can improve the overall value (even if just by allowing
> to test more combinations), I'm fine with this given that it doesn't
> remove anything.

I forgot the rationale, will add it properly to the next revision:

This is useful when using nolibc for security-critical tools.
Using nolibc has the advantage that the code is easily auditable and
sandboxable with seccomp as no unexpected syscalls are used.
Using compiler-assistent stack protection provides another security
mechanism.

> I'm having a few comments below:
> 
> On Tue, Mar 07, 2023 at 10:22:33PM +0000, Thomas Weißschuh wrote:
> > diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
> > new file mode 100644
> > index 000000000000..ca1360b7afd8
> > --- /dev/null
> > +++ b/tools/include/nolibc/stackprotector.h
> > @@ -0,0 +1,48 @@
> > +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> > +/*
> > + * Stack protector support for NOLIBC
> > + * Copyright (C) 2023 Thomas Weißschuh <linux@weissschuh.net>
> > + */
> > +
> > +#ifndef _NOLIBC_STACKPROTECTOR_H
> > +#define _NOLIBC_STACKPROTECTOR_H
> > +
> > +#include "arch.h"
> > +
> > +#if defined(NOLIBC_STACKPROTECTOR)
> > +
> > +#if !defined(__ARCH_SUPPORTS_STACK_PROTECTOR)
> > +#error "nolibc does not support stack protectors on this arch"
> > +#endif
> > +
> > +#include "sys.h"
> > +#include "stdlib.h"
> > +
> > +__attribute__((weak,noreturn,section(".text.nolibc_stack_chk")))
> > +void __stack_chk_fail(void)
> > +{
> > +	write(STDERR_FILENO, "!!Stack smashing detected!!\n", 28);
> > +	abort();
> > +}
> 
> Don't you think you should call the syscall directly here like you
> did for __stack_chk_init() and/or declare the function with the
> no_stackprotector attribute ? I'm wondering if there could be a
> risk that it fails again if called from a bad condition. If you're
> certain it cannot, maybe just explain it in a 2-line comment above
> the function so that others don't ask the same in the future.

Good point. It probably works because the compiler decided to inline the
call. But syscalls are more robust, I'll change that.

> > +__attribute__((weak,no_stack_protector,section(".text.nolibc_stack_chk")))
> > +void __stack_chk_init(void)
> > +{
> > +	// raw syscall assembly as calling a function would trigger the
> > +	// stackprotector itself
> > +	my_syscall3(__NR_getrandom, &__stack_chk_guard, sizeof(__stack_chk_guard), 0);
> 
> For full-line comments, the regular C-style "/* */" is preferred (and
> please also use the multi-line format when needed). "//" tends to be
> reserved for short ones at the end of a line.

Of course, will be changed.

> > +	// a bit more randomness in case getrandom() fails
> > +	__stack_chk_guard |= (uintptr_t) &__stack_chk_guard;
> 
> Using |= will in fact remove randomness rather than add, because it
> will turn some zero bits to ones but not the opposite. Maybe you'd
> want to use "^=" or "+=" instead ?

Indeed, will change that.
