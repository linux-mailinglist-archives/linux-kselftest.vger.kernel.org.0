Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7651D60EDF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 04:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiJ0CfG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 22:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiJ0CfF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 22:35:05 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7C2D1AF34;
        Wed, 26 Oct 2022 19:35:02 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29R2YunU026375;
        Thu, 27 Oct 2022 04:34:56 +0200
Date:   Thu, 27 Oct 2022 04:34:56 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: always rebuild the sysroot when
 running a test
Message-ID: <20221027023456.GA26215@1wt.eu>
References: <20221026054508.19634-1-w@1wt.eu>
 <20221026164825.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <20221026195902.GB24197@1wt.eu>
 <20221026204138.GQ5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026204138.GQ5600@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 26, 2022 at 01:41:38PM -0700, Paul E. McKenney wrote:
> > > I have queued this.  I expect to push this into the next merge window,
> > > thus avoiding the need to document the need for "make clean" in my
> > > pull request.  ;-)
> > 
> > Stupid question, is it really worth postponing it, considering that
> > we've just introduced this series right now ? I mean, if the current
> > usage is confusing, it's probably better to propose the fix before
> > 6.1-final ? It's not a new feature here but rather a fix for a recently
> > introduced one, thus I think it could be part of the next fix series.
> > Rest assured I don't want to put a mess into your patch workflow, just
> > asking :-)
> 
> You lost me here.

Ah sorry!

> My intent is to push these nolicb patches into the upcoming v6.2
> merge window:
> 
> 2318a710bffbd tools/nolibc: Fix missing strlen() definition and infinite loop with gcc-12
> 6937b8de8f1c3 tools/nolibc/string: Fix memcmp() implementation
> e1bbfe393c900 selftests/nolibc: Add 7 tests for memcmp()
> 3f2c1c45a3a9a selftests/nolibc: Always rebuild the sysroot when running a test
> 
> I didn't see the problem until I queued the third patch (e1bbfe393c900),
> and it is still in -rcu, not in v6.1.
> 
> What am I missing here?

I thought that since some of them are fixes, they would be pushed during
6.1-rc so that we don't release 6.1 with known defects. For example Rasmus'
fix for memcmp() or the strlen() fix would IMHO make sense for this
release since we're aware of the bugs and we have the fixes. The 3rd one
is indeed an addition and in no way a fix and it can easily wait for 6.2.
The 4th one is more of a usability fix but I agree that for this last one
it's debatable, I was mostly seeing this as a possiility to avoid causing
needless confusion.

Hoping this clarifies my initial question.

Thanks,
Willy
