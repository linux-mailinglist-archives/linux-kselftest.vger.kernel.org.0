Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAB74C0049
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Feb 2022 18:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbiBVRn4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Feb 2022 12:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiBVRnz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Feb 2022 12:43:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCA01688F9;
        Tue, 22 Feb 2022 09:43:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CADEB6135F;
        Tue, 22 Feb 2022 17:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35572C340E8;
        Tue, 22 Feb 2022 17:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645551809;
        bh=DmHgyuRJSQJXP4y4nwKOfhnNvc5tuz329RwqznVDwN8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JM5TDoR6PLHEOElzcfgrnX1loUapcSrdjr7XcOcrIjsueMby9+yUu4DOD1tR2K2BE
         DtZGtIpWShSj52o9Se+0WlnzqiZLRJ5as4EETAQhVJI9vco8jEqxR76h6uaYMkeMJh
         4xNZPKeq29P4sQpuSWyT8h6wW9PV/2yT6w5vQDVVQm56MWOeG8IFMxpgzbDioWnu1L
         tO9CL/Rm0QXUzVRSBUk6LSQNiGpj/jsfQJXB5GW7Uz43N4yVnjzkSJ3bM8htdu/6oa
         LKlJ+DmxlScYISA5nd6eWFGnVdbx2a9uSfpKuxVQSvMt9KXbgRukiGrj/yqCmonDl2
         uarqfHSejNm9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E2E105C031F; Tue, 22 Feb 2022 09:43:28 -0800 (PST)
Date:   Tue, 22 Feb 2022 09:43:28 -0800
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
Message-ID: <20220222174328.GL4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220222120718.17141-1-pmenzel@molgen.mpg.de>
 <20220222120718.17141-2-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222120718.17141-2-pmenzel@molgen.mpg.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 22, 2022 at 01:07:17PM +0100, Paul Menzel wrote:
> For consecutive numbers *lscpu* collapses the output and just shows the
> range with start and end. The processors are numbered that way on POWER8.
> 
>     $ sudo ppc64_cpu --smt=8
>     $ lscpu | grep '^NUMA node'
>     NUMA node(s):                    2
>     NUMA node0 CPU(s):               0-79
>     NUMA node8 CPU(s):               80-159
> 
> This causes the heuristic to detect the number threads per core, looking
> for the number after the first comma, to fail, and QEMU aborts because of
> invalid arguments.
> 
>     $ lscpu | sed -n -e '/^NUMA node0/s/^[^,]*,\([0-9]*\),.*$/\1/p'
>     $
> 
> (Before the last patch, the whole line was returned.)
> 
>     $ lscpu | grep '^NUMA node0' | sed -e 's/^[^,-]*(,|\-)\([0-9]*\),.*$/\1/'
>     NUMA node0 CPU(s):               0-79
> 
> *lscpu* shows the number of threads per core, so use that value directly.
> 
>     $ sudo ppc64_cpu --smt=8
>     $ lscpu | grep 'Thread(s) per core'
>     Thread(s) per core:              8
>     $ sudo ppc64_cpu --smt=off
>     $ lscpu | grep 'Thread(s) per core'
>     Thread(s) per core:              1
> 
> Note, the replaced heuristic is also incorrect for that case, where the
> threads per core are disabled.
> 
>     $ lscpu | sed -n -e '/^NUMA node0/s/^[^,]*,\([0-9]*\),.*$/\1/p'
>     8
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Makes sense, and thank you for chasing this down and for the fix!

But should this patch and 1/2 be merged?  Or am I confused and they
are somehow affecting two different lines of scripting?

							Thanx, Paul

> ---
>  tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
> index 5cff520955e6..66d0414d8e4b 100644
> --- a/tools/testing/selftests/rcutorture/bin/functions.sh
> +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
> @@ -301,7 +301,7 @@ specify_qemu_cpus () {
>  			echo $2 -smp $3
>  			;;
>  		qemu-system-ppc64)
> -			nt="`lscpu | sed -n -e '/^NUMA node0/s/^[^,]*,\([0-9]*\),.*$/\1/p'`"
> +			nt="`lscpu | sed -n 's/^Thread(s) per core:\s*//p'`"
>  			echo $2 -smp cores=`expr \( $3 + $nt - 1 \) / $nt`,threads=$nt
>  			;;
>  		esac
> -- 
> 2.35.1
> 
