Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236596F0295
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 10:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243096AbjD0I35 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Apr 2023 04:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjD0I3x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Apr 2023 04:29:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B6819B9;
        Thu, 27 Apr 2023 01:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A2A663B98;
        Thu, 27 Apr 2023 08:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187B8C4339B;
        Thu, 27 Apr 2023 08:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682584191;
        bh=sY0kxvVgQRX9F8cq5ylxtU1vKe3/bQabvwR1G3kDi3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KLO9xmpLdw3bo6+Sz8+9XIpE5j2Yt2O6CLyKgntS56Pnsszu9BE7vB6woq39vTYdj
         BUnJjMxPQjRIypwJgCLpasEptkOFpnJdPgBJOq64QQVxb9EdaGQ8gctjczrUpCzavl
         uoPIgHurxZTwheHSop+r6YZ0YEoO7yc+qSrmBBG4=
Date:   Thu, 27 Apr 2023 10:29:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     sashal@kernel.org, stable@vger.kernel.org, shuah@kernel.org,
        sj38.park@gmail.com, akpm@linux-foundation.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v2] selftests/kselftest/runner/run_one(): Allow running
 non-executable files
Message-ID: <2023042743-cheesy-parasitic-206d@gregkh>
References: <20210810164534.25902-1-sj38.park@gmail.com>
 <20230425004637.156064-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425004637.156064-1-sj@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 25, 2023 at 12:46:37AM +0000, SeongJae Park wrote:
> Hi Greg and Sasha,
> 
> On Tue, 10 Aug 2021 16:45:34 +0000 SeongJae Park <sj38.park@gmail.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > When running a test program, 'run_one()' checks if the program has the
> > execution permission and fails if it doesn't.  However, it's easy to
> > mistakenly missing the permission, as some common tools like 'diff'
> > don't support the permission change well[1].  Compared to that, making
> > mistakes in the test program's path would only rare, as those are
> > explicitly listed in 'TEST_PROGS'.  Therefore, it might make more sense
> > to resolve the situation on our own and run the program.
> > 
> > For the reason, this commit makes the test program runner function to
> > still print the warning message but try parsing the interpreter of the
> > program and explicitly run it with the interpreter, in the case.
> > 
> > [1] https://lore.kernel.org/mm-commits/YRJisBs9AunccCD4@kroah.com/
> > 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> This patch has merged into the mainline by the commit 303f8e2d0200
> ("selftests/kselftest/runner/run_one(): allow running non-executable files").
> However, this patch has not added to v5.15.y, while there are some selftests
> having no execution permission, including that for DAMON.  As a result, the
> selftests always fail unless this patch is manually applied.  Could you please
> add this patch to v5.15.y?  I confirmed this patch can cleanly cherry-picked on
> the latest v5.15.y.

Now queued up, thanks.

greg k-h
