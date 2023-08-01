Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4EC76B9CD
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 18:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjHAQje (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 12:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjHAQjb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 12:39:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494F71FE5;
        Tue,  1 Aug 2023 09:39:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF72761634;
        Tue,  1 Aug 2023 16:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E39BC433C8;
        Tue,  1 Aug 2023 16:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690907969;
        bh=peOB4gYXHi9+NQFqAEhqF+m0ecPnTZOeDb0Ne46VrRw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sstKmFBZwEw5V1wDtDA9C654z/Yt8zMozmuZHnlnXA+FW1Bfr3b4cWTxtjWqAVrMc
         DGtbYQFs7QmqFA7SlAYC0oArqV3nFtR4/0L4aN7rkwIo83nqld1sh7qIz7oBdHAR9i
         kWqZ66M4DSoRCfRCezLkRP5GmObapL0IaVJeb+prgzS2jCu0lsFrTMet1a6E59wBeS
         cJR78bviYofqm3PhnqJ4cHr6D4hD10UeWMTjXBosOQISY7JvEccmRLNse6D3BpiG6R
         1/i/Z4AXElHXBtgQTqbP1oxoGtE0IF18eC5+32UBmpx4NFOPrmEUvG1h06FdZEjCb7
         pG1VVo7qCb6Lw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A6A0BCE0908; Tue,  1 Aug 2023 09:39:28 -0700 (PDT)
Date:   Tue, 1 Aug 2023 09:39:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: cgroup: fix test_kmem_basic false positives
Message-ID: <c40ca485-f52e-411a-9f33-3adabc53c0fc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230801135632.1768830-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801135632.1768830-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 01, 2023 at 09:56:32AM -0400, Johannes Weiner wrote:
> This test fails routinely in our prod testing environment, and I can
> reproduce it locally as well.
> 
> The test allocates dcache inside a cgroup, then drops the memory limit
> and checks that usage drops correspondingly. The reason it fails is
> because dentries are freed with an RCU delay - a debugging sleep shows
> that usage drops as expected shortly after.
> 
> Insert a 1s sleep after dropping the limit. This should be good
> enough, assuming that machines running those tests are otherwise not
> very busy.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

I am putting together something more formal, but this will certainly
improve things, as Johannes says, assuming the system goes mostly
idle during that one-second wait.  So:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

Yes, there are corner cases, such as the system having millions of
RCU callbacks queued and being unable to invoke them all during that
one-second interval.  But that is a corner case, and that is exactly
why I will be putting together something more formal.  ;-)

							Thanx, Paul

> ---
>  tools/testing/selftests/cgroup/test_kmem.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> index 258ddc565deb..1b2cec9d18a4 100644
> --- a/tools/testing/selftests/cgroup/test_kmem.c
> +++ b/tools/testing/selftests/cgroup/test_kmem.c
> @@ -70,6 +70,10 @@ static int test_kmem_basic(const char *root)
>  		goto cleanup;
>  
>  	cg_write(cg, "memory.high", "1M");
> +
> +	/* wait for RCU freeing */
> +	sleep(1);
> +
>  	slab1 = cg_read_key_long(cg, "memory.stat", "slab ");
>  	if (slab1 <= 0)
>  		goto cleanup;
> -- 
> 2.41.0
> 
