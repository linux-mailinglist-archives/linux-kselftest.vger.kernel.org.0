Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528D678C222
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 12:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbjH2KQe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 06:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbjH2KQa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 06:16:30 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8762F9;
        Tue, 29 Aug 2023 03:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693304185;
        bh=mdFDAQP5J31KOKjv/zKAqqp9gA/YCjsW8cCLllwIzmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HvqgMnnRcwNXe54XUwiTbAEzI0Ld2EETfvX2rhE0SbBp6ZIpI8arNfNtxC4ufJD64
         Ok7Zhte1pXx+2KS9gcNimPirqJ5QCXWx9SAwfxupO41kJ9cVMKfJzvNeuQHa2b8no7
         AgvG0cypKRu7jcRnzcW9nle6ewPuK7eSiBGwaBto=
Date:   Tue, 29 Aug 2023 12:16:23 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        Yuan Tan <tanyuan@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: add stdarg.h header
Message-ID: <b2c2ca69-b9bb-40b1-a05a-6d2f66e01034@t-8ch.de>
References: <20230827-nolibc-nostdinc-v1-0-995d1811f1f3@weissschuh.net>
 <20230827-nolibc-nostdinc-v1-1-995d1811f1f3@weissschuh.net>
 <ZO2QC/fw6LKdtLSb@1wt.eu>
 <2b6c62f1-c1f1-4f2c-ba0c-981e066f4268@t-8ch.de>
 <ZO25u3crGixkGKWe@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZO25u3crGixkGKWe@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-29 11:26:19+0200, Willy Tarreau wrote:
> On Tue, Aug 29, 2023 at 11:14:09AM +0200, Thomas Weißschuh wrote:
> > Hi Willy!
> > 
> > On 2023-08-29 08:28:27+0200, Willy Tarreau wrote:
> > > On Sun, Aug 27, 2023 at 10:00:15AM +0200, Thomas Weißschuh wrote:
> > > > This allows nolic to work with `-nostdinc` avoiding any reliance on
> > > > system headers.
> > > > 
> > > > The implementation has been lifted from musl libc 1.2.4.
> > > > There is already an implementation of stdarg.h in include/linux/stdarg.h
> > > > but that is GPL licensed and therefore not suitable for nolibc.
> > > 
> > > I'm a bit confused because for me, stdarg was normally provided by the
> > > compiler, but I could be mistaken. It's just that it reminds me not so
> > > old memories. Therefore maybe we just need to include or define
> > > "something" to use it.
> > 
> > It is indeed provided by the compiler.
> 
> OK. But then, doesn't it mean that if we don't provide our stdarg.h,
> the compilers' will be used ? I'm asking because we're already using
> va_list and va_args, for example in vfprintf() in stdio.h, which
> precisely includes <stdarg.h> so it must indeed come from the compiler.

It will be used *iff* -nostdinc is *not* passed.

I think we need to clarify the definition of the word "provided".
For me it means that the compiler ships an implementation of this header
file in the compiler-specific include directory.

If -nostdinc is passed this include directory is not actually usable.

If a user wants to avoid the implicit usage of any system-provided
headers they need to pass -nostdinc, as far as I know there is no flag
to keep only the compiler-specific include directories.

One usecase is in nolibc-test itself, where Zhangjin ran into weird
and inconsistent behavior of system includes being pulled in.
By using -nostdinc we avoid this.

I can also see this being useful for normal users.

> > I could not find anybody doing this differently.
> > Using builtins seems to me to be the normal way to expose compiler
> > implementation specifics.
> 
> OK but it's already what the compiler does itself in its own stdarg that
> is provided. That's why I don't understand what specific case we're trying
> to cover here, I feel like we're providing an alternate stdarg in case the
> compiler doesn't provide one except that I've not seen a compiler not
> provide it (even tcc comes with it), it's like stddef.

It's all about supporting -nostdinc.


FYI stdint.h is also provided by nolibc, gcc and glibc.
