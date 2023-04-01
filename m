Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAFC6D2FCD
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Apr 2023 13:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDALEm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Apr 2023 07:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDALEl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Apr 2023 07:04:41 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E09B2527C;
        Sat,  1 Apr 2023 04:04:39 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 331B4XZ1015062;
        Sat, 1 Apr 2023 13:04:33 +0200
Date:   Sat, 1 Apr 2023 13:04:33 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: validate C99 compatibility
Message-ID: <ZCgPwavNqLAfclpV@1wt.eu>
References: <20230328-nolibc-c99-v1-1-a8302fb19f19@weissschuh.net>
 <ZCPJm/Nb2AGlJqXg@1wt.eu>
 <2be5dd3f-d4ca-499a-9f7e-3113b4f04412@t-8ch.de>
 <ZCPWrrrlVRsaVIsl@1wt.eu>
 <ZCgBcs3RT07BrNA9@1wt.eu>
 <de90f88a-f741-4ed6-a153-3309a568aea7@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de90f88a-f741-4ed6-a153-3309a568aea7@t-8ch.de>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 01, 2023 at 10:33:45AM +0000, Thomas Weißschuh wrote:
> Hi Willy,
> 
> sorry for the late response to your previous mail, I was traveling.

Don't be sorry, I hardly have the time to respond between week-ends,
so you're waiting for me more than the other way around!

> > I just ran some tests and there's actually better to achieve what you're
> > looking for. Let's just use -fno-asm, it removes the GNU-specific "asm",
> > "inline", and "typeof" in favor of the "__" variants. With gcc 11.3 it
> > gives me this, which is exactly what we were looking for:
> > 
> >   gcc -Os -fno-ident -fno-asynchronous-unwind-tables -fno-stack-protector -DNOLIBC_STACKPROTECTOR -mstack-protector-guard=global -fstack-protector-all -fno-asm -s -o nolibc-test \
> >     -nostdlib -static -Isysroot/x86/include nolibc-test.c -lgcc
> >   In file included from sysroot/x86/include/stdlib.h:14,
> >                    from sysroot/x86/include/nolibc.h:103,
> >                    from sysroot/x86/include/errno.h:26,
> >                    from sysroot/x86/include/stdio.h:14,
> >                    from nolibc-test.c:15:
> >   sysroot/x86/include/string.h: In function 'memset':
> >   sysroot/x86/include/string.h:93:17: error: 'asm' undeclared (first use in this function)
> >      93 |                 asm volatile("");
> >         |                 ^~~
> >   sysroot/x86/include/string.h:93:17: note: each undeclared identifier is reported only once for each function it appears in
> >   sysroot/x86/include/string.h:93:20: error: expected ';' before 'volatile'
> >      93 |                 asm volatile("");
> >         |                    ^~~~~~~~~
> >         |                    ;
> >   sysroot/x86/include/string.h: In function 'strlen':
> >   sysroot/x86/include/string.h:142:17: warning: implicit declaration of function 'asm' [-Wimplicit-function-declaration]
> >     142 |                 asm("");
> >         |                 ^~~
> >   nolibc-test.c: In function 'main':
> >   nolibc-test.c:898:25: error: 'asm' undeclared (first use in this function)
> >     898 |                         asm volatile ("outb %%al, %%dx" :: "d"(0x501), "a"(0));
> >         |                         ^~~
> >   nolibc-test.c:898:28: error: expected ';' before 'volatile'
> >     898 |                         asm volatile ("outb %%al, %%dx" :: "d"(0x501), "a"(0));
> >         |                            ^~~~~~~~~
> >         |                            ;
> >   make: *** [Makefile:128: nolibc-test] Error 1
> > 
> > With this, we don't need to force -std=c99 nor to build two variants,
> > a single variant will catch GCCisms even with older compilers while not
> > being overly annoying.
> 
> The original goal was to have a fixed and explicit baseline that is
> supported. Using -std= ensures that no deviations are accidentally
> introduced.
> 
> Using -fno-asm only prevents this specific gnu-ism. All other gnu-isms
> and features from whatever the current compilers default language level
> is are still allowed.
> 
> Therefore I'm not convinced of this aproach.
> 
> These are the aproaches I can see that reach this goal:
> 
> * Declare C99 as baseline, build with -std=c99
> * Declare C99 and GNU89 as baseline, build with both.
> * Declare C99 and GNU89 as baseline, build with -std=c99,
>   wait for people to complain if something breaks on gnu89
>   (same as current status)
> * Declare C89 as baseline, remove all C99-isms and gnu-isms
>   (C++ comments, "inline" and some smaller stuff),
>   build with -std=c89.
> 
> Personally I think C99 is a baseline that is easy to fulfill by nolibc
> and should not restrict users.

I *am* affected. I do maintain some code that builds using an older
version of nolibc and still builds with the current one, that builds
fine on gcc 4.4..4.9 (as still present on some still supported distros
such as RHEL7 which comes with gcc-4.8). I just tried to build
nolibc-test with gcc-4.7 (which I still have for plenty of archs and
that is ~50% faster than 11.x, something appreciable during wide
range bisects) and it breaks on the size_t declared inside the for
statement.

We could possibly go with your 3rd proposal above (i.e. both baselines,
only build with c99 and wait for reports). Or we could equally build
with "-std=gnu89 -fno-asm" and make sure we stay away from any recent
accidental deviation. All relevant compilers in use for a while are
compatible with this because this has been the default for a very long
time. By the way, it's worth noting that no single gcc version ever
used c99 as a default standard.

Thanks,
Willy
