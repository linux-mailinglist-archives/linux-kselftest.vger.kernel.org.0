Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C094E4C3744
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 21:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiBXU4t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 15:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiBXU4t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 15:56:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A452C1D0360;
        Thu, 24 Feb 2022 12:56:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 429C7618FA;
        Thu, 24 Feb 2022 20:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01D3C340E9;
        Thu, 24 Feb 2022 20:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645736177;
        bh=+yCLcGp91fyf8IidI1eikAsq2RLPsTRaBUxy5F0GI2c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tX7EPlTBWPpzhFY8AelPxQWhmXxCzDPC6QLuuVFR5TvmHyCgVDSUzaLo4ccQti+B2
         VEicz8NEi2jCuqGun0nnYdwycSXg80kGSYovUroJWq3pWcuVNAY/HFpU9B0HVR8j65
         wfIrElApbofLSNQii5PY1rrIRYf9gq7dWox+pWL1ynqClAUh6NLOCaNTxEJdM2blRy
         QvuYbSmqFtz+0mG4l7VEZUQeRv6Rg9ayRHLoZOqNIBz29iKL+NOVkfWnDfJknio9il
         HXmUkh/Xbk2tEm7L4vaPPNX/irp5mDu/P8i7BnwA/s2PWQyV4ua/BrHujtbF0B8+bW
         pWr6W2Lmya+7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 414325C03B0; Thu, 24 Feb 2022 12:56:17 -0800 (PST)
Date:   Thu, 24 Feb 2022 12:56:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] torture: Make thread detection more robust by using
 lspcu
Message-ID: <20220224205617.GY4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220222120718.17141-1-pmenzel@molgen.mpg.de>
 <20220222120718.17141-2-pmenzel@molgen.mpg.de>
 <20220222174328.GL4285@paulmck-ThinkPad-P17-Gen-1>
 <1084da08-f67d-b5d7-add4-580e9246b7b7@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084da08-f67d-b5d7-add4-580e9246b7b7@molgen.mpg.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 24, 2022 at 09:24:11AM +0100, Paul Menzel wrote:
> Dear Paul,
> 
> 
> Am 22.02.22 um 18:43 schrieb Paul E. McKenney:
> > On Tue, Feb 22, 2022 at 01:07:17PM +0100, Paul Menzel wrote:
> > > For consecutive numbers *lscpu* collapses the output and just shows the
> > > range with start and end. The processors are numbered that way on POWER8.
> > > 
> > >      $ sudo ppc64_cpu --smt=8
> > >      $ lscpu | grep '^NUMA node'
> > >      NUMA node(s):                    2
> > >      NUMA node0 CPU(s):               0-79
> > >      NUMA node8 CPU(s):               80-159
> > > 
> > > This causes the heuristic to detect the number threads per core, looking
> > > for the number after the first comma, to fail, and QEMU aborts because of
> > > invalid arguments.
> > > 
> > >      $ lscpu | sed -n -e '/^NUMA node0/s/^[^,]*,\([0-9]*\),.*$/\1/p'
> > >      $
> > > 
> > > (Before the last patch, the whole line was returned.)
> > > 
> > >      $ lscpu | grep '^NUMA node0' | sed -e 's/^[^,-]*(,|\-)\([0-9]*\),.*$/\1/'
> > >      NUMA node0 CPU(s):               0-79
> > > 
> > > *lscpu* shows the number of threads per core, so use that value directly.
> > > 
> > >      $ sudo ppc64_cpu --smt=8
> > >      $ lscpu | grep 'Thread(s) per core'
> > >      Thread(s) per core:              8
> > >      $ sudo ppc64_cpu --smt=off
> > >      $ lscpu | grep 'Thread(s) per core'
> > >      Thread(s) per core:              1
> > > 
> > > Note, the replaced heuristic is also incorrect for that case, where the
> > > threads per core are disabled.
> > > 
> > >      $ lscpu | sed -n -e '/^NUMA node0/s/^[^,]*,\([0-9]*\),.*$/\1/p'
> > >      8
> > > 
> > > Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > 
> > Makes sense, and thank you for chasing this down and for the fix!
> > 
> > But should this patch and 1/2 be merged?  Or am I confused and they
> > are somehow affecting two different lines of scripting?
> 
> You are right. I guess with 1/2 I just wanted to document clearly, what I
> learned in #sed@irc.libera.chat, that means, how to avoid using grep, when
> sed is used.

Nothing wrong with that!

I have merged the two patches as shown below.  Does this work for you?

							Thanx, Paul

------------------------------------------------------------------------

commit 9f0daba62e958c31326c7a9eae33651e3a3cc6b4
Author: Paul Menzel <pmenzel@molgen.mpg.de>
Date:   Tue Feb 22 13:07:16 2022 +0100

    torture: Make thread detection more robust by using lspcu
    
    For consecutive numbers the lscpu command collapses the output and just
    shows the range with start and end. The processors are numbered that
    way on POWER8.
    
        $ sudo ppc64_cpu --smt=8
        $ lscpu | grep '^NUMA node'
        NUMA node(s):                    2
        NUMA node0 CPU(s):               0-79
        NUMA node8 CPU(s):               80-159
    
    This causes the heuristic to detect the number threads per core, looking
    for the number after the first comma, to fail, and QEMU aborts because of
    invalid arguments.
    
        $ lscpu | grep '^NUMA node0' | sed -e 's/^[^,-]*(,|\-)\([0-9]*\),.*$/\1/'
        NUMA node0 CPU(s):               0-79
    
    But the lscpu command shows the number of threads per core:
    
        $ sudo ppc64_cpu --smt=8
        $ lscpu | grep 'Thread(s) per core'
        Thread(s) per core:              8
        $ sudo ppc64_cpu --smt=off
        $ lscpu | grep 'Thread(s) per core'
        Thread(s) per core:              1
    
    This commit therefore directly uses that value.
    
    Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index c35ba24f994c3..66d0414d8e4bc 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -301,7 +301,7 @@ specify_qemu_cpus () {
 			echo $2 -smp $3
 			;;
 		qemu-system-ppc64)
-			nt="`lscpu | grep '^NUMA node0' | sed -e 's/^[^,]*,\([0-9]*\),.*$/\1/'`"
+			nt="`lscpu | sed -n 's/^Thread(s) per core:\s*//p'`"
 			echo $2 -smp cores=`expr \( $3 + $nt - 1 \) / $nt`,threads=$nt
 			;;
 		esac
