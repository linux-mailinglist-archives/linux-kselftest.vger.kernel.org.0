Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E3061002A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 20:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiJ0S0x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 14:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiJ0S0e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 14:26:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59F74DB65;
        Thu, 27 Oct 2022 11:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF2BDB824BC;
        Thu, 27 Oct 2022 18:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFB9C433D6;
        Thu, 27 Oct 2022 18:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666895190;
        bh=wma9TzoIDA+DTOwALcOueK9AiE1EyfWmz+CoJNPRnH0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jNT56GMvod5SPSxbUukNY+ZqvN66AYjBCtQLdWwe2wnXat0J100nPxOdMLu5ZrJaS
         D2iNz5X9jlcJq7XsmyA/SF1jar5yzAWrJSZuheYMP/Z04n9FtKWNt6qbiJgV3GKWmY
         29NoMigCwJ+L/yfnn1fmTtQpBXZCtKu0gbDEdyD6+lp5iXvPSjTsK2UKUmMghzZYxN
         BxM3BQ6sR6nLV7y8lRFGXJ1gS+NnRdnp0wKELm3GA6YrqfV9042XyA00boiHf49ve7
         TtTUglzyiZZGV5kvZmnMZ727AUC0EuDHBZlBCfRoWqQv4ygugYuLsiSRvSfsa/NL+s
         qlonCLkq99x+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0419B5C0A59; Thu, 27 Oct 2022 11:26:30 -0700 (PDT)
Date:   Thu, 27 Oct 2022 11:26:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: always rebuild the sysroot when
 running a test
Message-ID: <20221027182629.GF5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221026054508.19634-1-w@1wt.eu>
 <20221026164825.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <20221026195902.GB24197@1wt.eu>
 <20221026204138.GQ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221027023456.GA26215@1wt.eu>
 <20221027170453.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <20221027171307.GA30081@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027171307.GA30081@1wt.eu>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 27, 2022 at 07:13:08PM +0200, Willy Tarreau wrote:
> On Thu, Oct 27, 2022 at 10:04:53AM -0700, Paul E. McKenney wrote:
> > > > My intent is to push these nolicb patches into the upcoming v6.2
> > > > merge window:
> > > > 
> > > > 2318a710bffbd tools/nolibc: Fix missing strlen() definition and infinite loop with gcc-12
> > > > 6937b8de8f1c3 tools/nolibc/string: Fix memcmp() implementation
> > > > e1bbfe393c900 selftests/nolibc: Add 7 tests for memcmp()
> > > > 3f2c1c45a3a9a selftests/nolibc: Always rebuild the sysroot when running a test
> > > > 
> > > > I didn't see the problem until I queued the third patch (e1bbfe393c900),
> > > > and it is still in -rcu, not in v6.1.
> > > > 
> > > > What am I missing here?
> > > 
> > > I thought that since some of them are fixes, they would be pushed during
> > > 6.1-rc so that we don't release 6.1 with known defects. For example Rasmus'
> > > fix for memcmp() or the strlen() fix would IMHO make sense for this
> > > release since we're aware of the bugs and we have the fixes. The 3rd one
> > > is indeed an addition and in no way a fix and it can easily wait for 6.2.
> > > The 4th one is more of a usability fix but I agree that for this last one
> > > it's debatable, I was mostly seeing this as a possiility to avoid causing
> > > needless confusion.
> > > 
> > > Hoping this clarifies my initial question.
> > 
> > Very much so, thank you!
> > 
> > I was not considering the bug fixed by the first two patches to be
> > serious, my mistake, apologies for my misclassification.
> 
> No worries, I wasn't probably clear upfront about the purpose.
> 
> > Given that background, I would rebase these two, test them, and send
> > off a pull request, probably early next week.
> > 
> > 2318a710bffbd tools/nolibc: Fix missing strlen() definition and infinite loop with gcc-12
> > 6937b8de8f1c3 tools/nolibc/string: Fix memcmp() implementation
> 
> Perfect, thank you!
> 
> > I would push the other two commits into the upcoming merge window.
> 
> OK!
> 
> > Or might the discussion between you and Rasmus result in changes to
> > either of those first two commits?  If so, I should of course wait for
> > that discussion to resolve.
> 
> We'll see, but in any case it would just be a minor detail, but I'll
> give you a quick response so that you don't have to deal with multiple
> versions of the patch, we all know that it's painful.

If I don't hear otherwise from you by the end of tomorrow (Friday),
Pacific Time, I will rebase those two patches in preparation for sending
a pull request for the regression.  I will of course run the pull-message
text past you before sending the pull request.

							Thanx, Paul
