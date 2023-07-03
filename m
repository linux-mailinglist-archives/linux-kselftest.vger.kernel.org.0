Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3F2745994
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 12:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjGCKFQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 06:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjGCKFA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 06:05:00 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6D4C10EB;
        Mon,  3 Jul 2023 03:04:13 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 363A3xSs023937;
        Mon, 3 Jul 2023 12:03:59 +0200
Date:   Mon, 3 Jul 2023 12:03:59 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, david.laight@aculab.com, thomas@t-8ch.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 10/14] tools/nolibc: __sysret: support syscalls who
 return a pointer
Message-ID: <ZKKdD/p4UkEavru6@1wt.eu>
References: <20230702191733.GI16233@1wt.eu>
 <20230703083651.491785-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703083651.491785-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 03, 2023 at 04:36:51PM +0800, Zhangjin Wu wrote:
> > Syscalls that return pointer use that -MAX_ERRNO range to encode errors
> > (such as mmap()). I just do not know if there is a convention saying that
> > other ones also restrict themselves to that range or not. If you find
> > some info which guarantees that it's the case for all of them, then by
> > all means let's proceed like this, but in this case it should be mentioned
> > in the comment why we think it's valid to do this. For now it's presented
> > as an opportunity only.
> 
> Currently, I only found a prove-in-use case in musl:
> 
>     https://elixir.bootlin.com/musl/latest/source/src/internal/syscall_ret.c:
> 
>     #include <errno.h>
>     #include "syscall.h"
> 
>     long __syscall_ret(unsigned long r)
>     {
>     	if (r > -4096UL) {
>     		errno = -r;
>     		return -1;
>     	}
>     	return r;
>     }
> 
> Our new implementation (based on the one used by mmap()) is almostly the same
> as musl. Not sure if this is enough. I have tried to 'git blame' on
> __syscall_ret() of musl to find some clue, but failed, because the function has
> been added before importing into its git repo.

OK, we already used the glibc-saved registers in the past to determine
the official list of clobbered registers (and the ABI spec was even
updated based on this). Here, musl is sufficiently deployed to consider
this as valid. You can simply go that route and mention in the commit
message that while you found no official reference stating that this is
valid for int/long returns, you found at least one other implementation
relying on this (i.e. if the kernel ever changes it will cause breakage).

> > Also, the rest of the commit message regarding uintptr_t (which we don't
> > use), bit values and modular arithmetics is extremely confusing and not
> > needed at all. What matters is only to know if we need to consider only
> > values -MAX_ERRNO..-1 as error or all negative ones. If so, then it's
> > obvious that ret >= (unsigned long)-MAX_ERRNO catches them all, as the
> > current mmap() function already does with -4095UL.
> >
> 
> Yes, will clean up the commit message, but at first, let's continue get
> more information about which one is ok:
> 
> - -MAX_ERRNO..-1 as error, for sys_mmap (we know in nolibc) currently
> 
> - all negative ones, for others currently

You can double-check in glibc for example, but I'm starting to guess
you'll find the same test as above, i.e. errors are exclusively >-4096,
regardless of the expected return type.

Thanks!
Willy
