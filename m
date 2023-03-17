Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085396BF0D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 19:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjCQSif (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 14:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjCQSi3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 14:38:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8165A558B;
        Fri, 17 Mar 2023 11:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68520B8268B;
        Fri, 17 Mar 2023 18:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2631BC433D2;
        Fri, 17 Mar 2023 18:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679078300;
        bh=3evC/H1IWweU6IKTFkngiSrFDaZSqyZnEsOOVz+Z9Jg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=o/U7xcPmPMbRDgMydSj4RGzoKjEQpQvF8eTJeKoXBg3pZv2xKoVJDbo/BMm7HnINl
         j7ZfURb+hP2FP7L5n/aJLw/Eyjp+tJ0ILLVyYL20R2ezsDqKs01CL4UwILNjW6FBr0
         PHsXtsufITHsPUmlXQUTJ4goBfUDKxYCfxanLuQItF5mH4K2qTMNH5baDFuDEn9O4D
         yto8/RwnSOWH0D52sq1kDYOK5ggwuxxh7G63K3jT4CoZCTQxcQcVrlBBiyvL8LJHyl
         Ztj13v5MjABWnWsTAz6X3RrXjMPfF53c5L+IvhEadfWfCfqyidzPwSpmnQL5ekG90m
         FRShO7uDycCTQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A2D731540381; Fri, 17 Mar 2023 11:38:19 -0700 (PDT)
Date:   Fri, 17 Mar 2023 11:38:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Shuah Khan <shuah@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        seanjc@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH rcu 3/7] locking: Reduce the number of locks in ww_mutex
 stress tests
Message-ID: <2e8a6800-78e7-42bf-b4ff-5d7ef43511c5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230317031339.10277-1-boqun.feng@gmail.com>
 <20230317031339.10277-4-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317031339.10277-4-boqun.feng@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 16, 2023 at 08:13:35PM -0700, Boqun Feng wrote:
> The stress test in test_ww_mutex_init() uses 4095 locks since
> lockdep::reference has 12 bits, and since we are going to reduce it to
> 11 bits to support lock_sync(), and 2047 is still a reasonable number of
> the max nesting level for locks, so adjust the test.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202302011445.9d99dae2-oliver.sang@intel.com
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/locking/test-ww_mutex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
> index 29dc253d03af..93cca6e69860 100644
> --- a/kernel/locking/test-ww_mutex.c
> +++ b/kernel/locking/test-ww_mutex.c
> @@ -659,7 +659,7 @@ static int __init test_ww_mutex_init(void)
>  	if (ret)
>  		return ret;
>  
> -	ret = stress(4095, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
> +	ret = stress(2047, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.39.2
> 
