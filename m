Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF2A6E1395
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 19:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjDMRd6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 13:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjDMRd5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 13:33:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59A186BD;
        Thu, 13 Apr 2023 10:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2452463FE9;
        Thu, 13 Apr 2023 17:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55962C433D2;
        Thu, 13 Apr 2023 17:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681407235;
        bh=71WwyMIBy/Sh3GkQNe/Y3Tzlac75kWmJdT/ujgMPth0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TK6Io+YeLpLPM97i7IDMfaHYl9sDi1jB+6ITtwfuUd/QjlDF9yrz1uTYCRoq4w5nV
         qrSNfMDG7ILZVYVy+lLAF7DpXV1DClpSmPqxZjgE/LKOGl0c1oVKkjx1EQdmbsMoXS
         NGHT25HneRJIo4UwNNW/eEkO1OqDVMRUYORiFAuDMeYP4RmXY9wVlsWd3vZ+Lx2UP/
         GpLC3wP5KMV/JoNwNhia8+3uSzI+vPNEKzjxQv2e9Ud+V1K/I+idJ5Gy2wykj361Gw
         /UTfRk9cxRDf3VRE/+5Z5fF23tbiNbbjGQf9/RqS0JVyZ8zZFFxSGgjtqeaPWZESgL
         np+QF5RLD/jZQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D7B8A15404B3; Thu, 13 Apr 2023 10:33:54 -0700 (PDT)
Date:   Thu, 13 Apr 2023 10:33:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Mark Brown <broonie@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: Fix build of stdio.h due to header ordering
Message-ID: <c8021d03-4da0-4956-8744-4a3a1f8dd533@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230413-nolibc-stdio-fix-v1-1-fa05fc3ba1fe@kernel.org>
 <ZDg3K2nI+5l6as/L@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDg3K2nI+5l6as/L@1wt.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 13, 2023 at 07:08:59PM +0200, Willy Tarreau wrote:
> Hi Mark,
> 
> Sorry for this issue, I don't know why it didn't trigger in our tests,
> maybe due to the includes being explicit in the test program.
> 
> On Thu, Apr 13, 2023 at 05:26:32PM +0100, Mark Brown wrote:
> > When we added fd based file streams we created references to STx_FILENO in
> > stdio.h but these constants are declared in unistd.h which is the last file
> > included by the top level nolibc.h meaning those constants are not defined
> > when we try to build stdio.h. This causes programs using nolibc.h to fail
> > to build.
> > 
> > Reorder the headers to avoid this issue.
> > 
> > Fixes: d449546c957f ("tools/nolibc: implement fd-based FILE streams")
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> Acked-by: Willy Tarreau <w@1wt.eu>
> 
> Paul, the commit above is in your rcu/next branch but fortunately not
> in the series you've prepared for 6.4, so it will be sufficient to pick
> it on top of next and you can take it directly if you want.

Queued and pushed, thank you both!

With respect to -next, travel plans next week are causing me to instead
update my rcu/next branch to the merge point of all of this coming
merge window's pull requests.  Though it only makes a difference of a
few days, as I would normally pull rcu/next back the Monday before the
merge window opens.

There is some possibility that I will be off the grid for extended periods
next week, which shouldn't make any difference for nolibc, aside from my
possibly being unresponsive during that time.  The odds of an emergency
fix to last merge window's changes are quite low this late in cycle,
and I will be back before the next merge window opens.

Just let me know what I need to pull in, and I will do that early the
week after this coming one.  Or you can buffer it up and send me one
big series upon my return, your choice.  Either way works for me.  ;-)

							Thanx, Paul
