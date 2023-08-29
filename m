Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3461678C113
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 11:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjH2JOl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 05:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjH2JOP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 05:14:15 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F316C12F;
        Tue, 29 Aug 2023 02:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693300449;
        bh=yOd12dKjU1kppRqI5P4SrXk9R3jPF/EYzDjRcvYq2Ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/f0GkvjXRxA7QHxhxMPN3Jk6cgR6J7uC4h81diWK9C6fDDzFJvLxtrb+ZKDm9mC2
         7VdHU91aCwyGUx0AnQVRqxAnqBJrBel3yhT5RRAsQKDYAXI3cEMxAm2i7l0EutfeKk
         jK6Cp835xSqXn3eR2Mw35RO0BCGTqvSUrIFStH7A=
Date:   Tue, 29 Aug 2023 11:14:09 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        Yuan Tan <tanyuan@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: add stdarg.h header
Message-ID: <2b6c62f1-c1f1-4f2c-ba0c-981e066f4268@t-8ch.de>
References: <20230827-nolibc-nostdinc-v1-0-995d1811f1f3@weissschuh.net>
 <20230827-nolibc-nostdinc-v1-1-995d1811f1f3@weissschuh.net>
 <ZO2QC/fw6LKdtLSb@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZO2QC/fw6LKdtLSb@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Willy!

On 2023-08-29 08:28:27+0200, Willy Tarreau wrote:
> On Sun, Aug 27, 2023 at 10:00:15AM +0200, Thomas Weißschuh wrote:
> > This allows nolic to work with `-nostdinc` avoiding any reliance on
> > system headers.
> > 
> > The implementation has been lifted from musl libc 1.2.4.
> > There is already an implementation of stdarg.h in include/linux/stdarg.h
> > but that is GPL licensed and therefore not suitable for nolibc.
> 
> I'm a bit confused because for me, stdarg was normally provided by the
> compiler, but I could be mistaken. It's just that it reminds me not so
> old memories. Therefore maybe we just need to include or define
> "something" to use it.

It is indeed provided by the compiler.

I could not find anybody doing this differently.
Using builtins seems to me to be the normal way to expose compiler
implementation specifics.

> > +#ifndef _NOLIBC_STDARG_H
> > +#define _NOLIBC_STDARG_H
> > +
> > +typedef __builtin_va_list va_list;
> > +#define va_start(v, l)   __builtin_va_start(v, l)
> > +#define va_end(v)        __builtin_va_end(v)
> > +#define va_arg(v, l)     __builtin_va_arg(v, l)
> > +#define va_copy(d, s)    __builtin_va_copy(d, s)
> > +
> > +#endif /* _NOLIBC_STDARG_H */
> 
> Also, regarding the doubt above, I really think these should be guarded
> (maybe just use va_start as a hint), because the risk that they come
> from libc headers or maybe from the compiler via another include path
> is non-negligible.

I can add a guard.
It would only protect against the case where the other stdarg.h is
loaded first, not if ours is loaded first.

Although these symbols should always only come from some <stdarg.h>
and within a single CU this should always end up being the same file.


Thomas
