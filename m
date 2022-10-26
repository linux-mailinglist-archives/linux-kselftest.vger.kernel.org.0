Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8215B60E2BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 15:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiJZN6b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 09:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiJZN5q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 09:57:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936566C941;
        Wed, 26 Oct 2022 06:57:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DA3A61EB1;
        Wed, 26 Oct 2022 13:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915D1C433C1;
        Wed, 26 Oct 2022 13:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666792653;
        bh=iYKHMvchQIp87mwU83wThwb0OZA3KotzKOlVoc0s0MA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hmqX9Q0xyTNhZXq7aaKH37rZEwY9NhtQD6VbHx63tcNWXmuU+JEJFI3UNu+CpmicW
         PDQ3gtolLiSjlORamI0zl4bvLqBSKcnwQIeC+LyeMfMCi9Fx2g+UBREJow0vJa2AnR
         wyk05vh+Sv/AoH4K1pTdUHlbj+PxEy6KFiOzslto5DIVb9vUKMUFpPGWAY8lsYKnXK
         qztDGjizLA2otYmNXwa3yTQ8QotCPywMeb9jARof+A0TxLX4csh8S7vFGfUdk/d0NZ
         VcL5ycbT1xQyWvfY4ITUpqVlZIFBIITFT623w0PO1tKt4Xc5qK4fsyphP1kv/NMDAX
         ENPFqdiKQihTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3DBA65C069B; Wed, 26 Oct 2022 06:57:33 -0700 (PDT)
Date:   Wed, 26 Oct 2022 06:57:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add 7 tests for memcmp()
Message-ID: <20221026135733.GK5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221021060340.7515-1-w@1wt.eu>
 <20221021155645.GK5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021170134.GB8420@1wt.eu>
 <20221021170738.GM5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021172026.GC8420@1wt.eu>
 <20221021180040.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <20221022112228.GB30596@1wt.eu>
 <20221024155357.GZ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221026053922.GA19206@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026053922.GA19206@1wt.eu>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 26, 2022 at 07:39:22AM +0200, Willy Tarreau wrote:
> Hi Paul,
> 
> On Mon, Oct 24, 2022 at 08:53:57AM -0700, Paul E. McKenney wrote:
> > > Will keep thinking about it and hopefully propose a patch to make the
> > > tests easier to use before we're too far in the 6.1 release.
> > 
> > Another possibility is to have a separate developers' and maintainers'
> > option.  Linus and I do "make whatever" for some value of "whatever"
> > that builds from scratch, doing whatever cleaning that might be required.
> > Developers use targets that are faster but have the possibility of false
> > positives and false negatives.
> > 
> > But maybe you have something better in mind.
> > 
> > > Thanks for keeping the conversation flowing, that helps me!
> > 
> > Looking forward to seeing what you come up with!
> 
> I could finally figure what was taking time in the installation process.
> Interestingly, it's "make headers", which is not redone without a "make
> clean" at the kernel level. The "make headers_install" only takes a few
> hundred milliseconds, so issuing a systematic "make clean" in the nolibc
> test dir only takes ~800ms here to perform a full rebuild, which is totally
> acceptable to me.
> 
> Thus what I've done is to mark the sysroot target as .phony and start it
> with a removal of the current include dir so that we systematically rebuild
> it. Now there's no such risk of running a test against an earlier version
> anymore, and there are no "make clean" to worry about anymore either.
> That looks much better to me!
> 
> And I could confirm that just issuing:
> 
>   $ time make -j8 -C tools/testing/selftests/nolibc run
> 
> after reverting Rasmus' fix led me to this pretty quickly:
> 
>   ...
>   Kernel: arch/x86/boot/bzImage is ready  (#3)
>   make[1]: Leaving directory '/k'
>   15 memcmp_20_e0 = 64                    [FAIL]
>   16 memcmp_e0_20 = -64                   [FAIL]
>   See all results in /k/tools/testing/selftests/nolibc/run.out
>   make: Leaving directory '/k/tools/testing/selftests/nolibc'
> 
>   real    0m14.538s
>   user    0m27.828s
>   sys     0m4.576s
> 
> No more false positives nor false negatives anymore. I'm sending you
> the patch separately.
> 
> Thanks for the discussion, the solution is way better now!

Nice, looking forward to the patch!

							Thanx, Paul
