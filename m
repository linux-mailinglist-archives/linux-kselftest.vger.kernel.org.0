Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1405776F07F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 19:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjHCRTk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 13:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjHCRTj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 13:19:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE88B3A97;
        Thu,  3 Aug 2023 10:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 225E761E54;
        Thu,  3 Aug 2023 17:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F83C433C8;
        Thu,  3 Aug 2023 17:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691083175;
        bh=rGBR/A6wmiGr7kQr72xa+WcmnICxmO1tIDp2ngWhxZk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MsBEdHdxEHN4vLWoAOVU+s9ykjbclLv+OIzSCl0C49tgmsjHVJQ5ygWIYZDE/EIPs
         qjnLWeIeQ4xYSqhpqyj2qe7RMhzZBvtpBKf3PZdpt2AUe35AjEiiSYpSu/Z8FXEm8v
         sUS+N1kCbVWGfKLR4dFlsI+gbROM2nLPrC3iwviqvfTB1a8GmhD8ICzfUa3X7pxuUN
         B5z4LVC5/Fsm4WLBLm5liBnKMFa4CEio/QvQuHKNznGf9bB6OIH7j698jBReX4XMYe
         DMn38IrJOroMIVUB3bDKwIOYsmInDp751Y/jtYXs6WWDrgtTCNLbvvn4WNnyAtsPrt
         1Fmz7qE6uWYxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 11523CE0C8E; Thu,  3 Aug 2023 10:19:35 -0700 (PDT)
Date:   Thu, 3 Aug 2023 10:19:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lucas Karpinski <lkarpins@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: cgroup: fix test_kmem_basic false positives
Message-ID: <0a2b5245-0c81-4492-a846-b35fb85b227e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230801135632.1768830-1-hannes@cmpxchg.org>
 <c40ca485-f52e-411a-9f33-3adabc53c0fc@paulmck-laptop>
 <tqt5od6fuwid5qf2vjhkxef2swlccpki5oikx4pdoabyycrdpe@kzx2rpscvwgs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tqt5od6fuwid5qf2vjhkxef2swlccpki5oikx4pdoabyycrdpe@kzx2rpscvwgs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 03, 2023 at 12:13:26PM -0400, Lucas Karpinski wrote:
> On Tue, Aug 01, 2023 at 09:39:28AM -0700, Paul E. McKenney wrote:
> > On Tue, Aug 01, 2023 at 09:56:32AM -0400, Johannes Weiner wrote:
> > > This test fails routinely in our prod testing environment, and I can
> > > reproduce it locally as well.
> > > 
> > > The test allocates dcache inside a cgroup, then drops the memory limit
> > > and checks that usage drops correspondingly. The reason it fails is
> > > because dentries are freed with an RCU delay - a debugging sleep shows
> > > that usage drops as expected shortly after.
> > > 
> > > Insert a 1s sleep after dropping the limit. This should be good
> > > enough, assuming that machines running those tests are otherwise not
> > > very busy.
> > > 
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > I am putting together something more formal, but this will certainly
> > improve things, as Johannes says, assuming the system goes mostly
> > idle during that one-second wait.  So:
> > 
> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > Yes, there are corner cases, such as the system having millions of
> > RCU callbacks queued and being unable to invoke them all during that
> > one-second interval.  But that is a corner case, and that is exactly
> > why I will be putting together something more formal.  ;-)
> > 
> > 							Thanx, Paul
> > 
> > > ---
> > >  tools/testing/selftests/cgroup/test_kmem.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> > > index 258ddc565deb..1b2cec9d18a4 100644
> > > --- a/tools/testing/selftests/cgroup/test_kmem.c
> > > +++ b/tools/testing/selftests/cgroup/test_kmem.c
> > > @@ -70,6 +70,10 @@ static int test_kmem_basic(const char *root)
> > >  		goto cleanup;
> > >  
> > >  	cg_write(cg, "memory.high", "1M");
> > > +
> > > +	/* wait for RCU freeing */
> > > +	sleep(1);
> > > +
> > >  	slab1 = cg_read_key_long(cg, "memory.stat", "slab ");
> > >  	if (slab1 <= 0)
> > >  		goto cleanup;
> > > -- 
> > > 2.41.0
> > >
> 
> The same issue exists in the test case test_kmem_memcg_deletion. I
> wouldn't mind posting the patch, but it seems you want to propose
> something more formal. Let me know your opinion.

I am proposing a /sys/module/rcutree/parameters/do_rcu_barrier
file.  Writing a "1" into this file results in an rcu_barrier()
in the kernel, but set up so that there is no more than a single
rcu_barrier() call per second.

So you could do the following:

	run-a-test
	echo 1 > /sys/module/rcutree/parameters/do_rcu_barrier # As root
	# All RCU callbacks from run-a-test have now been invoked
	run-another-test

Please note that this handles only RCU, as in call_rcu(), and not
SRCU, Tasks RCU, and so on.

							Thanx, Paul
