Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A54274F860
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 21:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjGKT24 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 15:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjGKT2z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 15:28:55 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72BA110C2;
        Tue, 11 Jul 2023 12:28:53 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36BJShiT006359;
        Tue, 11 Jul 2023 21:28:43 +0200
Date:   Tue, 11 Jul 2023 21:28:43 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 01/12] tools/nolibc: rename arch-<ARCH>.h to
 <ARCH>/arch.h
Message-ID: <20230711192843.GC31402@1wt.eu>
References: <ZK0HouRo8g6jqkTi@1wt.eu>
 <20230711163830.10271-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711163830.10271-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Wed, Jul 12, 2023 at 12:38:30AM +0800, Zhangjin Wu wrote:
> > > >   both sys.h and crt.h are not a sub modules of arch.h (although they
> > > >   have minimal arch specific code), so, like sys.h, crt.h should be
> > > >   included in the top-level headers, not in arch.h,
> > 
> > Why ? Keep in mind that these are only include files, to in the end,
> > *all* of them are included. The ordering is the only thing that really
> > matters.
> >
> 
> Yeah, I know this. The only thing confused me is the relationship among
> crt.h, sys.h and arch.h, the include position should better reflects
> their relationship, currently, we have mixed two "divide" methods
> together, one is arch and non-arch, another is the parallel
> functions/features.
> 
> so, the only left question is where should we include crt.h in? Firstly,
> I put it like sys.h (In my mind, it should be), If you two both agree to
> put it in arch-<ARCH.h>, I will renew this series with it, this is
> definitely a lighter way than the reorg method, I don't persist ;-)

Then let's start this way. And if later we find a better organization
*and* a good reason to change it, we can do it. Please also keep in mind
that constantly renaming/moving inflicts extra pain to the stable team
when backporting fixes if any. That's another reason for not moving code
around often.

> > > In musl crt_arch.h seems to be used in different ways. So it makes sense
> > > to split it from syscall_arch.h. In nolibc there is no such distinction.
> > > And everything will end up in a global namespace anyways.
> > 
> > Exactly. Musl is musl and nolibc is nolibc. Musl is a regular libc in that
> > it provides a .so that is built from many .c files. As such it's desirable
> > to split along certain edges. nolibc contains no single C file. It's only
> > meant to be included as-is in the user's C file. This changes a lot of
> > things, even in terms of splitting. Also keep in mind that musl is a
> > general-purpose libc, and that some distros are entirely built on it.
> > nolibc doesn't have such goal nor expectation, the first user was a
> > preinit code I wrote long ago, and the second one is rcutorture which
> > contains a while() loop around gettimeofday() IIRC. We must not just
> > blindly imitate other components' choices because they work, when we're
> > dealing with different constraints. If ours are acceptable, no need to
> > complicate everything.
> >
> 
> Willy, I know the difference between musl and nolibc, the musl code
> referenced here is only used to clear my confusion about "the
> relationship among crt.h, sys.h and arch.h" I mentiond above.

OK, but even so, our includes are "private" and do not necessarily need
to be organized like other projects. That doesn't mean that good ideas
from other ones should not help us decide, of course, I just mean that
it's normal to see differences.

> BTW, I do think nolibc have more using scenes, I like it very much and
> have used it in my own "Linux Lab" open source project [1] to let it
> work as the minimal rootfs to speed up kernel features learning and
> development, I do like the 'kernel-only deployments' feature behind
> nolibc [2], although there is something like "Unikernel Linux" [3], but
> that differs from a normal Linux system and is more complicated ;-)
> 
> I'm even imaging using it with a pure-header shell and a pure-header gui
> to let them further work together as a tiny rtos ;-)

I'm not denying the possibilities for other use cases. I still have
somewhere a small 1MB kernel image+rootfs that is sufficient to SSH into
remotely or download and flash a firmware image over tftp/http/serial,
so I see pretty well how this can be useful, and suspect this could
eventually happen again. But doing incremental changes that don't seem
to go in a particular direction is not much helpful and complicates
participation from everyone.

However of course, if someone comes and say "I'd like to use it in this
or that environment but for this I need all that", it's easier to follow
and try to steer in a direction that adapts smoothly to all users' needs.
Another point, please also remember that we moved it into the kernel to
help those who need to adjust their tests easily contribute the missing
calls (like you did for a number of things). But I tend to think that as
long as it's in the kernel, the activity should remain related to the
kernel usage. If you have bigger plans for a much larger project, the
kernel's process will slow you down and you'll experience some rejection
for breaking certain principles, so in this case such work would better
be done outside (after re-updating the original repo that I left rot for
a while).

> > > The arch-specific code in nolibc in mainline is currentl ~200 lines per
> > > arch. With this series in general it will be even less.
> > > If at some point there are many more architectures it may make sense to
> > > introduce an arch/ directory then.
> > 
> > And even then I'm not convinced because the number of archs will remain
> > low anyway.
> >
> 
> We have 8 now, the maximum may be 'ls -d arch/*/ | wc -l', it is 22
> currently ;-)

Yes but I'm not convinced that all of them will be ported there, for
various reasons ranging from lack of interest or lack of use cases, to
lack of maintainer time.

> > > > Like musl, if required, another top-level arch/ may be required to put
> > > > all of the <ARCH>/ directories together to clean up the top-level nolibc
> > > > directory.
> > > 
> > > At the moment in mainline there are 26 files in nolibc.
> > > That does not seem excessive, in fact it looks to be less than most
> > > other kernel directories.
> > 
> > Indeed :-)  Note that it started with a single one!
> 
> Yeah, I learned the history, but I do think we will have more, as the
> requirements become more and more ;-)

Sure, but it grew fast thanks to being easy to understand and locate
stuff. This should be seen as a feature I guess.

Cheers,
Willy
