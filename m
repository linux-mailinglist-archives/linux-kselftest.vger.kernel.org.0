Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E8D60B3E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Oct 2022 19:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiJXRUu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Oct 2022 13:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiJXRUW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Oct 2022 13:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61775B488B;
        Mon, 24 Oct 2022 08:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6DFC6147E;
        Mon, 24 Oct 2022 15:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067D6C433D6;
        Mon, 24 Oct 2022 15:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666626838;
        bh=xl7mmNiO+KxU9FEr9SMbHT7CAElv66IlG802OmzTKPE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pMRB0LGkQxnFaxDpwo1v3IlmbV0LH16sYA2TjYzugCN6v9vJotr4/dBhOpAZ5+cyZ
         1NwWMBR3MjLGMIB5kTrK4QeH8O/x8A6LWSJzpctvpd+b9cdHbYUYmPJjmgsCd/mkso
         f/b9jEdU172T6uCv1rhv6mJ0bDqy2HhToMf6d6VV+OkXLxaQMlIRJZ+0+/baTBGzJ+
         crHuND076LW/0gU7mwx/62q+NNoqG7eE9SuUKfdde7vBWsmt5pfla7HOL9hQZSDDqt
         w3l5K7Ox9uqxgB/qJUuObnKZa3fnJPjlgiBIHELiNAkQDihpxj12AVa0tHv5QAtl5F
         rAAprsrcNMHhw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 932C95C06CD; Mon, 24 Oct 2022 08:53:57 -0700 (PDT)
Date:   Mon, 24 Oct 2022 08:53:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add 7 tests for memcmp()
Message-ID: <20221024155357.GZ5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221021060340.7515-1-w@1wt.eu>
 <20221021155645.GK5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021170134.GB8420@1wt.eu>
 <20221021170738.GM5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021172026.GC8420@1wt.eu>
 <20221021180040.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <20221022112228.GB30596@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022112228.GB30596@1wt.eu>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 22, 2022 at 01:22:28PM +0200, Willy Tarreau wrote:
> On Fri, Oct 21, 2022 at 11:00:40AM -0700, Paul E. McKenney wrote:
> > > It's even easier, you don't even need the clean phase in include/nolibc.
> > > I'm doing this and it's sufficient:
> > > 
> > >   make -C tools/testing/selftests/nolibc clean
> > >   make -C tools/testing/selftests/nolibc nolibc-test
> > >   tools/testing/selftests/nolibc/nolibc-test
> > > 
> > > Or for the test under QEMU, which involves a kernel build:
> > > 
> > >   make -C tools/testing/selftests/nolibc clean
> > >   make -C tools/testing/selftests/nolibc -j $(nproc) run
> > > 
> > > Where would you first look for such a hint ? Maybe the help output of
> > > the default "make" command could send as a hint that a clean is needed
> > > after patching nolibc and that could be sufficient ? I just want to make
> > > sure users don't waste their time trying to find what they could be doing
> > > wrong.
> > 
> > Maybe it suffices for the near term for me to put this information in
> > the signed tag for the pull request?
> 
> It can be sufficient for short term indeed, but it can be easy as well
> for me to mention it in the make output.

Why not both?  ;-)

> > Another approach would be to remind about "make clean" in the case of
> > a test failure.  Or make test failure combined with a detected change
> > trigger an automatic "make clean" and a retry.
> 
> In fact failures are not the only case. For me it was the opposite. I
> applied Rasmus' fix, then I developed the test, verified that it worked,
> then reverted Rasmus' fix... to find that the test didn't catch the
> failure. I had a second look at the original patch and figured that
> the -192..+192 values were really not possible with a char so I
> concluded that a clean was needed. But leaving something in a claimed
> working state while it's not can be sufficiently misleading and make
> one waste significant time, because in such cases we rarely search why
> it works.

Fair point!  False negatives can be quite annoying as well.

> > Or other schemes of increasing complexity and fragility.  ;-)
> 
> That's exactly what I'd like to avoid with such a lightweight component.
> If it takes more time to figure why something is going wrong than to
> write a test, we'll all give up. I think that a clean for QEMU is worth
> it because the kernel is rebuilt and its dependencies are quite robust,
> so that one would be a surprise. For other tests, probably leaving it
> explicit with a hint that it's needed should suffice. I'll recheck what
> conditions the installation of uapi headers because that's really what
> I don't want to see happening all the time. The rest is discrete, it's
> just a few files being copied, maybe it can be done every time.
> 
> Will keep thinking about it and hopefully propose a patch to make the
> tests easier to use before we're too far in the 6.1 release.

Another possibility is to have a separate developers' and maintainers'
option.  Linus and I do "make whatever" for some value of "whatever"
that builds from scratch, doing whatever cleaning that might be required.
Developers use targets that are faster but have the possibility of false
positives and false negatives.

But maybe you have something better in mind.

> Thanks for keeping the conversation flowing, that helps me!

Looking forward to seeing what you come up with!

							Thanx, Paul
