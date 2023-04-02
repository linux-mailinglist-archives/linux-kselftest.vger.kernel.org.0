Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98BA6D37C6
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 14:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjDBMDf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 08:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDBMDe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 08:03:34 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAC51A948;
        Sun,  2 Apr 2023 05:03:32 -0700 (PDT)
Date:   Sun, 2 Apr 2023 12:00:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680437009;
        bh=J6EUXY7ZNeAl1Bncy9vRZdILjTEGiNKvAMcj5y/RNbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XYl6kyn/n2/W85dGTuwMMjP3992BXmiTLIzzY+BGq+SdNFKmwixp5qftFEyNDck2M
         gD5MC9PJ4HDv6nXHaOS9/4XmTIXyatxf14vcHh4hNzamvTsnRexHVggfbkRoPvnrFD
         KxEgYhoVaEy2jSj4AmV9TFIKlmE8T6eoLu2U2Ark=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: validate C99 compatibility
Message-ID: <84882550-b036-47fd-9bef-3657ac32e46e@t-8ch.de>
References: <20230328-nolibc-c99-v1-1-a8302fb19f19@weissschuh.net>
 <ZCPJm/Nb2AGlJqXg@1wt.eu>
 <2be5dd3f-d4ca-499a-9f7e-3113b4f04412@t-8ch.de>
 <ZCPWrrrlVRsaVIsl@1wt.eu>
 <ZCgBcs3RT07BrNA9@1wt.eu>
 <de90f88a-f741-4ed6-a153-3309a568aea7@t-8ch.de>
 <ZCgPwavNqLAfclpV@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCgPwavNqLAfclpV@1wt.eu>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-04-01 13:04:33+0200, Willy Tarreau wrote:
> On Sat, Apr 01, 2023 at 10:33:45AM +0000, Thomas Weißschuh wrote:
> > Hi Willy,
> > 
> > sorry for the late response to your previous mail, I was traveling.
> 
> Don't be sorry, I hardly have the time to respond between week-ends,
> so you're waiting for me more than the other way around!
> 
> > > I just ran some tests and there's actually better to achieve what you're
> > > looking for. Let's just use -fno-asm, it removes the GNU-specific "asm",
> > > "inline", and "typeof" in favor of the "__" variants. With gcc 11.3 it
> > > gives me this, which is exactly what we were looking for:
> > > 
> > >   gcc -Os -fno-ident -fno-asynchronous-unwind-tables -fno-stack-protector -DNOLIBC_STACKPROTECTOR -mstack-protector-guard=global -fstack-protector-all -fno-asm -s -o nolibc-test \
> > >     -nostdlib -static -Isysroot/x86/include nolibc-test.c -lgcc
> > >   In file included from sysroot/x86/include/stdlib.h:14,
> > >                    from sysroot/x86/include/nolibc.h:103,
> > >                    from sysroot/x86/include/errno.h:26,
> > >                    from sysroot/x86/include/stdio.h:14,
> > >                    from nolibc-test.c:15:
> > >   sysroot/x86/include/string.h: In function 'memset':
> > >   sysroot/x86/include/string.h:93:17: error: 'asm' undeclared (first use in this function)
> > >      93 |                 asm volatile("");
> > >         |                 ^~~
> > >   sysroot/x86/include/string.h:93:17: note: each undeclared identifier is reported only once for each function it appears in
> > >   sysroot/x86/include/string.h:93:20: error: expected ';' before 'volatile'
> > >      93 |                 asm volatile("");
> > >         |                    ^~~~~~~~~
> > >         |                    ;
> > >   sysroot/x86/include/string.h: In function 'strlen':
> > >   sysroot/x86/include/string.h:142:17: warning: implicit declaration of function 'asm' [-Wimplicit-function-declaration]
> > >     142 |                 asm("");
> > >         |                 ^~~
> > >   nolibc-test.c: In function 'main':
> > >   nolibc-test.c:898:25: error: 'asm' undeclared (first use in this function)
> > >     898 |                         asm volatile ("outb %%al, %%dx" :: "d"(0x501), "a"(0));
> > >         |                         ^~~
> > >   nolibc-test.c:898:28: error: expected ';' before 'volatile'
> > >     898 |                         asm volatile ("outb %%al, %%dx" :: "d"(0x501), "a"(0));
> > >         |                            ^~~~~~~~~
> > >         |                            ;
> > >   make: *** [Makefile:128: nolibc-test] Error 1
> > > 
> > > With this, we don't need to force -std=c99 nor to build two variants,
> > > a single variant will catch GCCisms even with older compilers while not
> > > being overly annoying.
> > 
> > The original goal was to have a fixed and explicit baseline that is
> > supported. Using -std= ensures that no deviations are accidentally
> > introduced.
> > 
> > Using -fno-asm only prevents this specific gnu-ism. All other gnu-isms
> > and features from whatever the current compilers default language level
> > is are still allowed.
> > 
> > Therefore I'm not convinced of this aproach.
> > 
> > These are the aproaches I can see that reach this goal:
> > 
> > * Declare C99 as baseline, build with -std=c99
> > * Declare C99 and GNU89 as baseline, build with both.
> > * Declare C99 and GNU89 as baseline, build with -std=c99,
> >   wait for people to complain if something breaks on gnu89
> >   (same as current status)
> > * Declare C89 as baseline, remove all C99-isms and gnu-isms
> >   (C++ comments, "inline" and some smaller stuff),
> >   build with -std=c89.
> > 
> > Personally I think C99 is a baseline that is easy to fulfill by nolibc
> > and should not restrict users.
> 
> I *am* affected. I do maintain some code that builds using an older
> version of nolibc and still builds with the current one, that builds
> fine on gcc 4.4..4.9 (as still present on some still supported distros
> such as RHEL7 which comes with gcc-4.8). I just tried to build
> nolibc-test with gcc-4.7 (which I still have for plenty of archs and
> that is ~50% faster than 11.x, something appreciable during wide
> range bisects) and it breaks on the size_t declared inside the for
> statement.

> We could possibly go with your 3rd proposal above (i.e. both baselines,
> only build with c99 and wait for reports). Or we could equally build
> with "-std=gnu89 -fno-asm" and make sure we stay away from any recent
> accidental deviation. All relevant compilers in use for a while are
> compatible with this because this has been the default for a very long
> time. By the way, it's worth noting that no single gcc version ever
> used c99 as a default standard.

Personally I don't trust myself not to accidentally introduce
incompatible code.
Case in point with the above mentioned declaration.
Also it's non-obvious for new contributors.

I'll resend a version that also builds with -std=gnu89.

Thomas
