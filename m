Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E416B78C169
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 11:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjH2J2s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 05:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjH2J2f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 05:28:35 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FE7CE56;
        Tue, 29 Aug 2023 02:28:10 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37T9QJ8E013415;
        Tue, 29 Aug 2023 11:26:19 +0200
Date:   Tue, 29 Aug 2023 11:26:19 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        Yuan Tan <tanyuan@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: add stdarg.h header
Message-ID: <ZO25u3crGixkGKWe@1wt.eu>
References: <20230827-nolibc-nostdinc-v1-0-995d1811f1f3@weissschuh.net>
 <20230827-nolibc-nostdinc-v1-1-995d1811f1f3@weissschuh.net>
 <ZO2QC/fw6LKdtLSb@1wt.eu>
 <2b6c62f1-c1f1-4f2c-ba0c-981e066f4268@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b6c62f1-c1f1-4f2c-ba0c-981e066f4268@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 29, 2023 at 11:14:09AM +0200, Thomas Weißschuh wrote:
> Hi Willy!
> 
> On 2023-08-29 08:28:27+0200, Willy Tarreau wrote:
> > On Sun, Aug 27, 2023 at 10:00:15AM +0200, Thomas Weißschuh wrote:
> > > This allows nolic to work with `-nostdinc` avoiding any reliance on
> > > system headers.
> > > 
> > > The implementation has been lifted from musl libc 1.2.4.
> > > There is already an implementation of stdarg.h in include/linux/stdarg.h
> > > but that is GPL licensed and therefore not suitable for nolibc.
> > 
> > I'm a bit confused because for me, stdarg was normally provided by the
> > compiler, but I could be mistaken. It's just that it reminds me not so
> > old memories. Therefore maybe we just need to include or define
> > "something" to use it.
> 
> It is indeed provided by the compiler.

OK. But then, doesn't it mean that if we don't provide our stdarg.h,
the compilers' will be used ? I'm asking because we're already using
va_list and va_args, for example in vfprintf() in stdio.h, which
precisely includes <stdarg.h> so it must indeed come from the compiler.

> I could not find anybody doing this differently.
> Using builtins seems to me to be the normal way to expose compiler
> implementation specifics.

OK but it's already what the compiler does itself in its own stdarg that
is provided. That's why I don't understand what specific case we're trying
to cover here, I feel like we're providing an alternate stdarg in case the
compiler doesn't provide one except that I've not seen a compiler not
provide it (even tcc comes with it), it's like stddef.

Thanks,
Willy
