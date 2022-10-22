Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A40608CBC
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Oct 2022 13:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiJVLhU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Oct 2022 07:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiJVLhF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Oct 2022 07:37:05 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BE9C176B8F;
        Sat, 22 Oct 2022 04:22:42 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29MBMStf030728;
        Sat, 22 Oct 2022 13:22:28 +0200
Date:   Sat, 22 Oct 2022 13:22:28 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add 7 tests for memcmp()
Message-ID: <20221022112228.GB30596@1wt.eu>
References: <20221021060340.7515-1-w@1wt.eu>
 <20221021155645.GK5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021170134.GB8420@1wt.eu>
 <20221021170738.GM5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021172026.GC8420@1wt.eu>
 <20221021180040.GN5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021180040.GN5600@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 21, 2022 at 11:00:40AM -0700, Paul E. McKenney wrote:
> > It's even easier, you don't even need the clean phase in include/nolibc.
> > I'm doing this and it's sufficient:
> > 
> >   make -C tools/testing/selftests/nolibc clean
> >   make -C tools/testing/selftests/nolibc nolibc-test
> >   tools/testing/selftests/nolibc/nolibc-test
> > 
> > Or for the test under QEMU, which involves a kernel build:
> > 
> >   make -C tools/testing/selftests/nolibc clean
> >   make -C tools/testing/selftests/nolibc -j $(nproc) run
> > 
> > Where would you first look for such a hint ? Maybe the help output of
> > the default "make" command could send as a hint that a clean is needed
> > after patching nolibc and that could be sufficient ? I just want to make
> > sure users don't waste their time trying to find what they could be doing
> > wrong.
> 
> Maybe it suffices for the near term for me to put this information in
> the signed tag for the pull request?

It can be sufficient for short term indeed, but it can be easy as well
for me to mention it in the make output.

> Another approach would be to remind about "make clean" in the case of
> a test failure.  Or make test failure combined with a detected change
> trigger an automatic "make clean" and a retry.

In fact failures are not the only case. For me it was the opposite. I
applied Rasmus' fix, then I developed the test, verified that it worked,
then reverted Rasmus' fix... to find that the test didn't catch the
failure. I had a second look at the original patch and figured that
the -192..+192 values were really not possible with a char so I
concluded that a clean was needed. But leaving something in a claimed
working state while it's not can be sufficiently misleading and make
one waste significant time, because in such cases we rarely search why
it works.

> Or other schemes of increasing complexity and fragility.  ;-)

That's exactly what I'd like to avoid with such a lightweight component.
If it takes more time to figure why something is going wrong than to
write a test, we'll all give up. I think that a clean for QEMU is worth
it because the kernel is rebuilt and its dependencies are quite robust,
so that one would be a surprise. For other tests, probably leaving it
explicit with a hint that it's needed should suffice. I'll recheck what
conditions the installation of uapi headers because that's really what
I don't want to see happening all the time. The rest is discrete, it's
just a few files being copied, maybe it can be done every time.

Will keep thinking about it and hopefully propose a patch to make the
tests easier to use before we're too far in the 6.1 release.

Thanks for keeping the conversation flowing, that helps me!
Willy
