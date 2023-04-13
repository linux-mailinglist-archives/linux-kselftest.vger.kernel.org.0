Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF486E13AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 19:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDMRmm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 13:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMRml (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 13:42:41 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3453919A3;
        Thu, 13 Apr 2023 10:42:39 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 33DHgYws004366;
        Thu, 13 Apr 2023 19:42:34 +0200
Date:   Thu, 13 Apr 2023 19:42:34 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: Fix build of stdio.h due to header ordering
Message-ID: <ZDg/CsWixum2DdUM@1wt.eu>
References: <20230413-nolibc-stdio-fix-v1-1-fa05fc3ba1fe@kernel.org>
 <ZDg3K2nI+5l6as/L@1wt.eu>
 <c8021d03-4da0-4956-8744-4a3a1f8dd533@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8021d03-4da0-4956-8744-4a3a1f8dd533@paulmck-laptop>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Paul,

On Thu, Apr 13, 2023 at 10:33:54AM -0700, Paul E. McKenney wrote:
> Queued and pushed, thank you both!

Thanks!

> With respect to -next, travel plans next week are causing me to instead
> update my rcu/next branch to the merge point of all of this coming
> merge window's pull requests.  Though it only makes a difference of a
> few days, as I would normally pull rcu/next back the Monday before the
> merge window opens.
> 
> There is some possibility that I will be off the grid for extended periods
> next week, which shouldn't make any difference for nolibc, aside from my
> possibly being unresponsive during that time.  The odds of an emergency
> fix to last merge window's changes are quite low this late in cycle,
> and I will be back before the next merge window opens.
> 
> Just let me know what I need to pull in, and I will do that early the
> week after this coming one.  Or you can buffer it up and send me one
> big series upon my return, your choice.  Either way works for me.  ;-)

Thanks for letting us know! Anyway there shouldn't be anything urgent
with nolibc. And if anyone would be blocked I would go back to the old
method where I queue that in a branch in my repo, so please travel in
peace ;-)

Thank you!
Willy
