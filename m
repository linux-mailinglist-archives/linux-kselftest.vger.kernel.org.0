Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE56607D24
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 19:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJURBr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 13:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJURBp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 13:01:45 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A8C022514;
        Fri, 21 Oct 2022 10:01:42 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29LH1Y3N013131;
        Fri, 21 Oct 2022 19:01:34 +0200
Date:   Fri, 21 Oct 2022 19:01:34 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add 7 tests for memcmp()
Message-ID: <20221021170134.GB8420@1wt.eu>
References: <20221021060340.7515-1-w@1wt.eu>
 <20221021155645.GK5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021155645.GK5600@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 21, 2022 at 08:56:45AM -0700, Paul E. McKenney wrote:
> On Fri, Oct 21, 2022 at 08:03:40AM +0200, Willy Tarreau wrote:
> > This adds 7 combinations of input values for memcmp() using signed and
> > unsigned bytes, which will trigger on the original code before Rasmus'
> > fix. This is mostly aimed at helping backporters verify their work, and
> > showing how tests for corner cases can be added to the selftests suite.
> > 
> > Before the fix it reports:
> >   12 memcmp_20_20 = 0                      [OK]
> >   13 memcmp_20_60 = -64                    [OK]
> >   14 memcmp_60_20 = 64                     [OK]
> >   15 memcmp_20_e0 = 64                    [FAIL]
> >   16 memcmp_e0_20 = -64                   [FAIL]
> >   17 memcmp_80_e0 = -96                    [OK]
> >   18 memcmp_e0_80 = 96                     [OK]
> > 
> > And after:
> >   12 memcmp_20_20 = 0                      [OK]
> >   13 memcmp_20_60 = -64                    [OK]
> >   14 memcmp_60_20 = 64                     [OK]
> >   15 memcmp_20_e0 = -192                   [OK]
> >   16 memcmp_e0_20 = 192                    [OK]
> >   17 memcmp_80_e0 = -96                    [OK]
> >   18 memcmp_e0_80 = 96                     [OK]
> > 
> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Signed-off-by: Willy Tarreau <w@1wt.eu>
> 
> I have pulled both of these in, thank you!
 
Thanks!

> One thing, though...  I had to do "make clean" in both tools/include/nolibc
> and tools/testing/selftests/nolibc to make those two "[FAIL]" indications
> go away.  Does this mean that I am doing something wrong?

No you didn't do anything wrong, it was the same for me and initially it
was intentional, but probably it wasn't that good an idea. What happens
is that we first prepare a pseudo-sysroot with kernel headers and nolibc
headers, then we build the test based on this sysroot. Thus if any uapi
header or nolibc header changes, nothing is detected. And I'm not much
willing to always reinstall everything for every single test, nor to
detect long dependency chains. Maybe I should think about adding another
target to clean+test at the same time, or maybe make the current
"nolibc-test" target do that and have a "retest" to only rebuild. But
that needs to be thought about with the QEMU test as well (because most
of the time for a quick test I don't build the kernel nor start QEMU, I
just call the executable directly).

Any ideas or suggestions are welcome, of course. We could consider that
if we build a kernel and start QEMU, it's long enough to justify a
systematic clean maybe ?

> It would be good to know before I send the pull request containing these,
> so that we can let Linus know of anything special he needs to do to
> ensure a valid test result.

I see. In the worst case, a preliminary "make clean" will do it. We just
need to decide what's the best solution for everyone (i.e. not waste too
much time between tests while not getting misleading results by accident).

Thanks!
Willy
