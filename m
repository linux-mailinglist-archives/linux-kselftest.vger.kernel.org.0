Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0141860E31C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 16:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiJZOR4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 10:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiJZORf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 10:17:35 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D33F1110B2C;
        Wed, 26 Oct 2022 07:17:33 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29QEHP9v022475;
        Wed, 26 Oct 2022 16:17:25 +0200
Date:   Wed, 26 Oct 2022 16:17:25 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add 7 tests for memcmp()
Message-ID: <20221026141725.GB19206@1wt.eu>
References: <20221021060340.7515-1-w@1wt.eu>
 <20221021155645.GK5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021170134.GB8420@1wt.eu>
 <20221021170738.GM5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021172026.GC8420@1wt.eu>
 <20221021180040.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <20221022112228.GB30596@1wt.eu>
 <20221024155357.GZ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221026053922.GA19206@1wt.eu>
 <20221026135733.GK5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026135733.GK5600@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 26, 2022 at 06:57:33AM -0700, Paul E. McKenney wrote:
> On Wed, Oct 26, 2022 at 07:39:22AM +0200, Willy Tarreau wrote:
> > Hi Paul,
> > 
> > On Mon, Oct 24, 2022 at 08:53:57AM -0700, Paul E. McKenney wrote:
> > > > Will keep thinking about it and hopefully propose a patch to make the
> > > > tests easier to use before we're too far in the 6.1 release.
> > > 
> > > Another possibility is to have a separate developers' and maintainers'
> > > option.  Linus and I do "make whatever" for some value of "whatever"
> > > that builds from scratch, doing whatever cleaning that might be required.
> > > Developers use targets that are faster but have the possibility of false
> > > positives and false negatives.
> > > 
> > > But maybe you have something better in mind.
> > > 
> > > > Thanks for keeping the conversation flowing, that helps me!
> > > 
> > > Looking forward to seeing what you come up with!
> > 
> > I could finally figure what was taking time in the installation process.
> > Interestingly, it's "make headers", which is not redone without a "make
> > clean" at the kernel level. The "make headers_install" only takes a few
> > hundred milliseconds, so issuing a systematic "make clean" in the nolibc
> > test dir only takes ~800ms here to perform a full rebuild, which is totally
> > acceptable to me.
> > 
> > Thus what I've done is to mark the sysroot target as .phony and start it
> > with a removal of the current include dir so that we systematically rebuild
> > it. Now there's no such risk of running a test against an earlier version
> > anymore, and there are no "make clean" to worry about anymore either.
> > That looks much better to me!
> > 
> > And I could confirm that just issuing:
> > 
> >   $ time make -j8 -C tools/testing/selftests/nolibc run
> > 
> > after reverting Rasmus' fix led me to this pretty quickly:
> > 
> >   ...
> >   Kernel: arch/x86/boot/bzImage is ready  (#3)
> >   make[1]: Leaving directory '/k'
> >   15 memcmp_20_e0 = 64                    [FAIL]
> >   16 memcmp_e0_20 = -64                   [FAIL]
> >   See all results in /k/tools/testing/selftests/nolibc/run.out
> >   make: Leaving directory '/k/tools/testing/selftests/nolibc'
> > 
> >   real    0m14.538s
> >   user    0m27.828s
> >   sys     0m4.576s
> > 
> > No more false positives nor false negatives anymore. I'm sending you
> > the patch separately.
> > 
> > Thanks for the discussion, the solution is way better now!
> 
> Nice, looking forward to the patch!

In case you don't have it, it's this one:

   https://lore.kernel.org/all/20221026054508.19634-1-w@1wt.eu/

Do not hesitate to let me know if I should resend it.

Thanks!
Willy
