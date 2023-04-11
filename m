Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB92B6DE157
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDKQp0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDKQpQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7E72690;
        Tue, 11 Apr 2023 09:45:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A0A76241E;
        Tue, 11 Apr 2023 16:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA0FC4339B;
        Tue, 11 Apr 2023 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681231463;
        bh=yxWndtrxm7KXvbmNlpUHoxZkfyHgM4MFEDIMiMnEyYQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=txzqcMuxReIUiyqf8Je/ZUFIKuSqiFS3/ibvncUcfHSG/SyAQG8G1iR+4UMcRMIfb
         fmen+XKqhKS/sMrg62ZqvqKxXAY/u1ykj2KXQP8NFt+6pK4tS1qSAxgvW48/lBrqQx
         4/geo+l3FslxuyNDsCWxnGY8wVwQ38S2HIT4Ka9YMzPhN4el32qh6stnbXgUv4+CIR
         p0aBU9kppxS1ti9UnbEY5iduQtfR3qcy1oRLapcBtrI2uzZRlvAoXWoYTH3BO9nXet
         9RUd99jPjPOgtSMawOHoXSYgpQdaGMt/hfdPDfMN21VicoeHxkeGJbFZnlwYnOGhVS
         dsoe6UmCJSSPQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 677061540478; Tue, 11 Apr 2023 09:44:23 -0700 (PDT)
Date:   Tue, 11 Apr 2023 09:44:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tools/nolibc/stdio: Implement vprintf()
Message-ID: <6a323775-6274-4d0c-844a-da53146c2abe@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230405-kselftest-nolibc-v2-0-2ac2495814b5@kernel.org>
 <20230405-kselftest-nolibc-v2-1-2ac2495814b5@kernel.org>
 <ZC8OwUPAC4s413jP@1wt.eu>
 <cbece9a0-b8d0-4f3e-9a55-9fe87e111392@paulmck-laptop>
 <fc52d5c1-61db-b8e3-e608-12434b0ee740@linuxfoundation.org>
 <9dfb88e8-2a61-47a8-876e-581e4c717217@sirena.org.uk>
 <20230411150320.GA23045@willie-the-truck>
 <0144ab97-f34a-4803-8fdb-52340f2d73f2@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0144ab97-f34a-4803-8fdb-52340f2d73f2@sirena.org.uk>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 11, 2023 at 04:13:11PM +0100, Mark Brown wrote:
> On Tue, Apr 11, 2023 at 04:03:21PM +0100, Will Deacon wrote:
> > On Tue, Apr 11, 2023 at 03:31:10PM +0100, Mark Brown wrote:
> 
> > > It seems like more of a kselftest change than anything else so probably
> > > makes sense for it to go that way?  The example user isn't really even
> > > needed.
> 
> > Fine by me, as long as it doesn't conflict with any other arm64 selftest
> > changes you hope to land for 6.4.
> 
> That shouldn't be an issue.

Shuah, looks to me like this one is yours in kselftest, then.  ;-)

							Thanx, Paul
