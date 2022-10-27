Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639E460FE65
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 19:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbiJ0RFA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 13:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbiJ0REz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 13:04:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DA65F7FC;
        Thu, 27 Oct 2022 10:04:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 374BA623FC;
        Thu, 27 Oct 2022 17:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBCBC43142;
        Thu, 27 Oct 2022 17:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666890293;
        bh=5b0G7zUDx/jkhftOATWSU27zAnGDN0j5g3bEJWoIeWY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SoKgpXd/0Esgwc1NXA4zdPaDnDkz3ajt9dAQwKLZMdf1w36lkE+fkALORlbO4RXj2
         0GwVuB7/ld6YtbvmdFjp7D6AfbQKkgo+3qiV2j8rNOx8m/BOC3wdluoT35QcsAjAhJ
         aPa5w+5if7ux+/DN6Rk9nT1oza6jd117bVO52RIQlDD8Az2eGYpSGB4WPRQrdtS8Oh
         cuY3hfNNYwA7dtKQDMfFOvGhAUfE5XxpS2pgOe16B1sqd2pomhyGnNLtwo3s4x2kaZ
         nn7pxKxFH7yp2fUcVxAZi1c10SJDRveLkffIjdXnAcryiK7vE2Ljz9p9lf7uDmb1fj
         LNl2dS30yEwgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3EB785C0A59; Thu, 27 Oct 2022 10:04:53 -0700 (PDT)
Date:   Thu, 27 Oct 2022 10:04:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: always rebuild the sysroot when
 running a test
Message-ID: <20221027170453.GA5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221026054508.19634-1-w@1wt.eu>
 <20221026164825.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <20221026195902.GB24197@1wt.eu>
 <20221026204138.GQ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221027023456.GA26215@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027023456.GA26215@1wt.eu>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 27, 2022 at 04:34:56AM +0200, Willy Tarreau wrote:
> On Wed, Oct 26, 2022 at 01:41:38PM -0700, Paul E. McKenney wrote:
> > > > I have queued this.  I expect to push this into the next merge window,
> > > > thus avoiding the need to document the need for "make clean" in my
> > > > pull request.  ;-)
> > > 
> > > Stupid question, is it really worth postponing it, considering that
> > > we've just introduced this series right now ? I mean, if the current
> > > usage is confusing, it's probably better to propose the fix before
> > > 6.1-final ? It's not a new feature here but rather a fix for a recently
> > > introduced one, thus I think it could be part of the next fix series.
> > > Rest assured I don't want to put a mess into your patch workflow, just
> > > asking :-)
> > 
> > You lost me here.
> 
> Ah sorry!
> 
> > My intent is to push these nolicb patches into the upcoming v6.2
> > merge window:
> > 
> > 2318a710bffbd tools/nolibc: Fix missing strlen() definition and infinite loop with gcc-12
> > 6937b8de8f1c3 tools/nolibc/string: Fix memcmp() implementation
> > e1bbfe393c900 selftests/nolibc: Add 7 tests for memcmp()
> > 3f2c1c45a3a9a selftests/nolibc: Always rebuild the sysroot when running a test
> > 
> > I didn't see the problem until I queued the third patch (e1bbfe393c900),
> > and it is still in -rcu, not in v6.1.
> > 
> > What am I missing here?
> 
> I thought that since some of them are fixes, they would be pushed during
> 6.1-rc so that we don't release 6.1 with known defects. For example Rasmus'
> fix for memcmp() or the strlen() fix would IMHO make sense for this
> release since we're aware of the bugs and we have the fixes. The 3rd one
> is indeed an addition and in no way a fix and it can easily wait for 6.2.
> The 4th one is more of a usability fix but I agree that for this last one
> it's debatable, I was mostly seeing this as a possiility to avoid causing
> needless confusion.
> 
> Hoping this clarifies my initial question.

Very much so, thank you!

I was not considering the bug fixed by the first two patches to be
serious, my mistake, apologies for my misclassification.

Given that background, I would rebase these two, test them, and send
off a pull request, probably early next week.

2318a710bffbd tools/nolibc: Fix missing strlen() definition and infinite loop with gcc-12
6937b8de8f1c3 tools/nolibc/string: Fix memcmp() implementation

I would push the other two commits into the upcoming merge window.

Or might the discussion between you and Rasmus result in changes to
either of those first two commits?  If so, I should of course wait for
that discussion to resolve.

							Thanx, Paul
