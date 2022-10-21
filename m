Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8283F607E00
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 20:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJUSAo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 14:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJUSAo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 14:00:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C819D270230;
        Fri, 21 Oct 2022 11:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D19E61F3A;
        Fri, 21 Oct 2022 18:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8DEC433C1;
        Fri, 21 Oct 2022 18:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666375241;
        bh=R0d7GbR4WqFTxJjlIduQBHoHpTAaNJnHLTmphjs1HKg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XB1hvGK5kXHVtLG256zhU0UPuEHWDzNt8PIEmvig+cs8IQXXv4GARJni9R9ygVBoC
         soXiJd2WfuesOVtAkTSNqjIs7fIdWZGKdugMTSJgH3Ec0utINn3txNmgNFqVmVfnip
         xR65U9fiXSK/+GAmbO2N8b3WQw08b2GsGIgHrkGJg+ADJOWsbvK7WUe2HjalFmbIeP
         /1ulKpaJVYx3Vdg9lZDgPdGcY89r6i143BO5gB4nOokRq+Ub6YDh2YQHsGFTb2Q198
         UDN5sCfelt/OhJYRD4Mv/gURDeHUUqgxVFbo7i/6I1e9Qon9FAjMmhMjxx4RVssTTr
         HQn9/5VDrc5wg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EA10E5C0543; Fri, 21 Oct 2022 11:00:40 -0700 (PDT)
Date:   Fri, 21 Oct 2022 11:00:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add 7 tests for memcmp()
Message-ID: <20221021180040.GN5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221021060340.7515-1-w@1wt.eu>
 <20221021155645.GK5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021170134.GB8420@1wt.eu>
 <20221021170738.GM5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021172026.GC8420@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021172026.GC8420@1wt.eu>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 21, 2022 at 07:20:26PM +0200, Willy Tarreau wrote:
> On Fri, Oct 21, 2022 at 10:07:38AM -0700, Paul E. McKenney wrote:
> > > I see. In the worst case, a preliminary "make clean" will do it. We just
> > > need to decide what's the best solution for everyone (i.e. not waste too
> > > much time between tests while not getting misleading results by accident).
> > 
> > Maybe just document the careful/slow way, then people doing it more
> > frequently can do it the clever/fast way.
> > 
> > My guess is that the careful/slow is this:
> > 
> > 	pushd tools/include/nolibc
> > 	make clean
> > 	make
> > 	popd
> > 	pushd tools/testing/selftests/nolibc
> > 	make clean
> > 	make -j32 run
> > 
> > Or did I miss a turn in there somewhere?
> 
> It's even easier, you don't even need the clean phase in include/nolibc.
> I'm doing this and it's sufficient:
> 
>   make -C tools/testing/selftests/nolibc clean
>   make -C tools/testing/selftests/nolibc nolibc-test
>   tools/testing/selftests/nolibc/nolibc-test
> 
> Or for the test under QEMU, which involves a kernel build:
> 
>   make -C tools/testing/selftests/nolibc clean
>   make -C tools/testing/selftests/nolibc -j $(nproc) run
> 
> Where would you first look for such a hint ? Maybe the help output of
> the default "make" command could send as a hint that a clean is needed
> after patching nolibc and that could be sufficient ? I just want to make
> sure users don't waste their time trying to find what they could be doing
> wrong.

Maybe it suffices for the near term for me to put this information in
the signed tag for the pull request?

Another approach would be to remind about "make clean" in the case of
a test failure.  Or make test failure combined with a detected change
trigger an automatic "make clean" and a retry.  Or other schemes of
increasing complexity and fragility.  ;-)

Other approaches?

							Thanx, Paul
