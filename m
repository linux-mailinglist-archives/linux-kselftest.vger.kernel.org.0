Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FC9611D5F
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Oct 2022 00:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJ1WWT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 18:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJ1WWS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 18:22:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAC9230AB8;
        Fri, 28 Oct 2022 15:22:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE570B82A8C;
        Fri, 28 Oct 2022 22:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FACFC433D6;
        Fri, 28 Oct 2022 22:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666995734;
        bh=6IsD/VDiCGWiqM8PmP7en4IAVivnTYw5J8ZAvemVnNw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IVDIpIEwAW5JY8EItFRpIBRfPn6WjbimLXjqX3qpNHQ/uoRjJj+uROArdA+va+8PL
         1Q+wHNVOYA773bhOcv/b1/WXIlbxvE3erb0XrX0B9n++Z52fa09hEFgFCFrrDjip1U
         /0GKrE6/qfvZp6cVZhoVh6HN7j74CVNbcmu9hJ2BqiTStJtSZhD0PQI8CugOG8V6OM
         v49DFssv3iSIiOegneXKCXoUjjfnd04OQZCQbpVnDh4Nafj3psMfpOnLzCirnLwOXW
         9+v3I9g27RPTvCGQQHyeQ8a3Mgsl84UuU4IqQ8uZBFFzNTISGMWwYDmihyE0+YogsX
         C0EcnjF2pFlNw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 32CA45C1040; Fri, 28 Oct 2022 15:22:14 -0700 (PDT)
Date:   Fri, 28 Oct 2022 15:22:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: always rebuild the sysroot when
 running a test
Message-ID: <20221028222214.GU5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221026054508.19634-1-w@1wt.eu>
 <20221026164825.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <20221026195902.GB24197@1wt.eu>
 <20221026204138.GQ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221027023456.GA26215@1wt.eu>
 <20221027170453.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <20221027171307.GA30081@1wt.eu>
 <20221027182629.GF5600@paulmck-ThinkPad-P17-Gen-1>
 <20221028193405.GA8395@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028193405.GA8395@1wt.eu>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URG_BIZ autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 28, 2022 at 09:34:05PM +0200, Willy Tarreau wrote:
> Hi Paul,
> 
> On Thu, Oct 27, 2022 at 11:26:29AM -0700, Paul E. McKenney wrote:
> > > We'll see, but in any case it would just be a minor detail, but I'll
> > > give you a quick response so that you don't have to deal with multiple
> > > versions of the patch, we all know that it's painful.
> > 
> > If I don't hear otherwise from you by the end of tomorrow (Friday),
> > Pacific Time, I will rebase those two patches in preparation for sending
> > a pull request for the regression.  I will of course run the pull-message
> > text past you before sending the pull request.
> 
> No news on this front, so feel free to pick what you already have.

Very good, thank you!

I currently expect to send something like the pull request shown
below early next week.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

Hello, Linus,

This pull request fixes a couple of nolibc string-function bugs noted
by kernel test robot, Rasmus Villemoes, Willy Tarreau.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc-urgent.2022.10.28a

for you to fetch changes up to b3f4f51ea68a495f8a5956064c33dce711a2df91:

  tools/nolibc/string: Fix memcmp() implementation (2022-10-28 15:07:02 -0700)

----------------------------------------------------------------
Urgent nolibc pull request for v6.1

This pull request contains a couple of commits that fix string-function
bugs introduced by:

96980b833a21 ("tools/nolibc/string: do not use __builtin_strlen() at -O0")
66b6f755ad45 ("rcutorture: Import a copy of nolibc")

These appeared in v5.19 and v5.0, respectively, but it would be good
to get these fixes in sooner rather than later.  Commits providing the
corresponding tests are in -rcu and I expect to submit them into the
upcoming v6.2 merge window.

----------------------------------------------------------------
Rasmus Villemoes (1):
      tools/nolibc/string: Fix memcmp() implementation

Willy Tarreau (1):
      tools/nolibc: Fix missing strlen() definition and infinite loop with gcc-12

 tools/include/nolibc/string.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)
