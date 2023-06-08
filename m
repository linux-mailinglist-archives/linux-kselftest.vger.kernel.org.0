Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2598727C5F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 12:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjFHKKU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 06:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbjFHKKR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 06:10:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B787D1FDF;
        Thu,  8 Jun 2023 03:10:14 -0700 (PDT)
X-QQ-mid: bizesmtp72t1686219003tjya3x6c
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Jun 2023 18:10:02 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: OY3aTMibIIceE4+5YMhobSaP1h6B+Or/hGya94VrcWvAEv5xCwQu0Z/MZpJYV
        Ar2k1rxgj+mzz5Bred1gka6b/wnlYIcP2cznOwc6Q1lWV/QtRGQABsAD0iPVkazj5zrKEJJ
        4yenMpsSY6eaUXToKdoAMu5DGmacd4TafyDwCTMFzbnIotUEcJ73LUN7gNa4nJiMVrNuBpF
        nML9dz03A9tNi3xoi3xhNNftGCzmqafbEFd7rzuUOpxPqFa2BDMuvXHvh/Kw6KUfW79UO6Q
        T7LMJFZRNlWpeARnV94EZnsNovZu0P4Bk1QOktX9Mx6dIifpGuG/dr0RZfCjHS3fwCZ49TK
        2yVeO4XsPkG13xVZ/RbYpxQNEO2/PfbEfxLHtUqM5SLXwTv2pTp1Qb3O2z4VQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13470355492363888723
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        w@1wt.eu
Subject: Re: [PATCH v3 0/3] tools/nolibc: add a new syscall helper
Date:   Thu,  8 Jun 2023 18:10:01 +0800
Message-Id: <20230608101001.38243-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87e7a391-b97b-4001-b12a-76d20790563e@t-8ch.de>
References: <87e7a391-b97b-4001-b12a-76d20790563e@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On 2023-06-07 19:28:58+0800, Zhangjin Wu wrote:
> > Willy, Thomas
> > 
> > This is the revision of the v2 syscall helpers [1], it is based on
> > 20230606-nolibc-rv32+stkp7a of [2]. It doesn't conflict with the v4 of
> > -ENOSYS patchset [3], so, it is ok to simply merge both of them.
> > 
> > This revision mainly applied Thomas' method, removed the __syscall()
> > helper and replaced it with __sysret() instead, because __syscall()
> > looks like _syscall() and syscall(), it may mixlead the developers.
> >
(...)
> > BTW, two questions for Thomas,
> > 
> > * This commit 659a49abc9c2 ("tools/nolibc: validate C89 compatibility")
> >   enables -std=c89, why not gnu11 used by kernel ? ;-)
> 
> Because nolibc needs to support whatever its users need.
> As nolibc is header-only all of it needs to work everywhere.
> C89 should work for everybody :-)
> 

Get it, thanks.

> The kernel on the other hand is compiled standalone and is not limited
> by its users.
> 
> See the discussion here:
> 
> https://lore.kernel.org/all/20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net/
> https://lore.kernel.org/all/20230328-nolibc-c99-v1-1-a8302fb19f19@weissschuh.net/
>

Thanks very much for sharing the whole history info.

And as the your commit 063b6bc5b39f ("tools/nolibc: use __inline__ syntax")
explains, the 'inline' keyword has been used in many headers of include/uapi/,
so, how our -std=c89 work with them? I did find the clue eventually, here maybe:

    $ grep -n inline scripts/headers_install.sh
    11:	echo "asm/inline/volatile keywords."
    37:	s/(^|[[:space:](])(inline|asm|volatile)([[:space:](]|$)/\1__\2__\3/g

The headers_install target helped us convert all of the new keywords to the old
ones, it's magic ;-)

So, it should work if people not want to try a -I/path/to/include/uapi/, I did
this for musl before, even If we do this, this may help:

    diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
    index 933bc0be7e1c..33d546cf9af0 100644
    --- a/tools/include/nolibc/std.h
    +++ b/tools/include/nolibc/std.h
    @@ -7,6 +7,14 @@
     #ifndef _NOLIBC_STD_H
     #define _NOLIBC_STD_H
     
    +#ifndef NOLIBC_TEST
    +#ifndef __STDC_VERSION__
    +#define inline __inline__
    +#define asm __asm__
    +#define volatile __volatile__
    +#endif
    +#endif
    +
     /* Declare a few quite common macros and types that usually are in stdlib.h,
      * stdint.h, ctype.h, unistd.h and a few other common locations. Please place
      * integer type definitions and generic macros here, but avoid OS-specific and
    diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
    index 4a3a105e1fdf..46f061a4458a 100644
    --- a/tools/testing/selftests/nolibc/Makefile
    +++ b/tools/testing/selftests/nolibc/Makefile
    @@ -78,7 +78,7 @@ endif

     CFLAGS_s390 = -m64
     CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
    -CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
    +CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -DNOLIBC_TEST \
                    $(call cc-option,-fno-stack-protector) \
                    $(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)

Is this worth a new patch? I do think it is not required.

> > * Do we need to tune the order of the macros in unistd.h like this:
> > 
> >     #define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))
> >     #define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)
> >     #define __syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
> >     #define _sycall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
> >     #define syscall(...) _syscall_n(_sycall_narg(__VA_ARGS__), ##__VA_ARGS__)
> > 
> >   Before, It works but seems not put in using order:
> > 
> >     #define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))
> >     #define _sycall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
> >     #define __syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
> >     #define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)
> >     #define syscall(...) _syscall_n(_sycall_narg(__VA_ARGS__), ##__VA_ARGS__)
> 
> Not sure it makes a big difference.
> If you want to change it, go for it.
>

Only switched two of them, oh, just found the '_sycall_narg' did miss a 's'
character, it may be really worth a patch now, I know why I focused on the
order so much, because the missing 's' made it not aligned well ;-)
 
> >
(...) 
> >  tools/include/nolibc/sys.h    | 364 +++++-----------------------------
> >  tools/include/nolibc/unistd.h |  11 +-
> >  2 files changed, 55 insertions(+), 320 deletions(-)
> 
> For the full series:
> 
> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
>

Thanks a lot, I'm really appreciated.

Best regards,
Zhangjin
 
> Thanks,
> Thomas
