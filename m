Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C1C6E141A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 20:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjDMSZy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 14:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjDMSZu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 14:25:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF7C65A0;
        Thu, 13 Apr 2023 11:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9671A640BB;
        Thu, 13 Apr 2023 18:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C2AC433D2;
        Thu, 13 Apr 2023 18:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681410326;
        bh=RPPHK2wusuNzTrh/xTUXAr5TVfW5x62BG8HQv6dbelw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ncH0pGlbyVpnPa8p8GDG6lecXnLSUwTCJ1F1S4Z0X2Y/WLmZxFR+Lt7Ed6GFg9yeG
         dNIx6q8zZPG3mfq6RjGrs5r7zxddmk1wNAE4bGEc/hA3fk4fEXq3yTHR4BXMb/FXpX
         JDStk/qymSiH9q8OxdukrCZdgZ9Pe6nG7EqvqgxwVFcaI6MuSi2gZTbCW4jY4HbIoC
         FF1qHY5BDJFpQ531L/xKxSF3RSn+1+oLvk9AmvhgaLHzJYNLYUXCYMg7EIFk/FYcQR
         LoSCLNENH3PfacUnaGYkRu+xmjohl/E06pWILfZDQTPUBCqZ/fLhi66TJ8aFuZhzfA
         2g65KtJ1sqIBA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4DE4315404B3; Thu, 13 Apr 2023 11:25:26 -0700 (PDT)
Date:   Thu, 13 Apr 2023 11:25:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Mark Brown <broonie@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: Fix build of stdio.h due to header ordering
Message-ID: <4d72305f-da35-4585-aea3-16444944ca2f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230413-nolibc-stdio-fix-v1-1-fa05fc3ba1fe@kernel.org>
 <ZDg3K2nI+5l6as/L@1wt.eu>
 <c8021d03-4da0-4956-8744-4a3a1f8dd533@paulmck-laptop>
 <ZDg/CsWixum2DdUM@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDg/CsWixum2DdUM@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 13, 2023 at 07:42:34PM +0200, Willy Tarreau wrote:
> Hi Paul,
> 
> On Thu, Apr 13, 2023 at 10:33:54AM -0700, Paul E. McKenney wrote:
> > Queued and pushed, thank you both!
> 
> Thanks!
> 
> > With respect to -next, travel plans next week are causing me to instead
> > update my rcu/next branch to the merge point of all of this coming
> > merge window's pull requests.  Though it only makes a difference of a
> > few days, as I would normally pull rcu/next back the Monday before the
> > merge window opens.
> > 
> > There is some possibility that I will be off the grid for extended periods
> > next week, which shouldn't make any difference for nolibc, aside from my
> > possibly being unresponsive during that time.  The odds of an emergency
> > fix to last merge window's changes are quite low this late in cycle,
> > and I will be back before the next merge window opens.
> > 
> > Just let me know what I need to pull in, and I will do that early the
> > week after this coming one.  Or you can buffer it up and send me one
> > big series upon my return, your choice.  Either way works for me.  ;-)
> 
> Thanks for letting us know! Anyway there shouldn't be anything urgent
> with nolibc. And if anyone would be blocked I would go back to the old
> method where I queue that in a branch in my repo, so please travel in
> peace ;-)

Thank you, Willy!

							Thanx, Paul
