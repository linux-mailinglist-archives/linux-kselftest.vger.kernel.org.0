Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3656654A5D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 02:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiLWBKn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 20:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbiLWBKS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 20:10:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182C895;
        Thu, 22 Dec 2022 17:05:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94B96B81FBC;
        Fri, 23 Dec 2022 01:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C266C433D2;
        Fri, 23 Dec 2022 01:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671757506;
        bh=7ahZpcyG2PSirGYeAzw4AdHX+r8zs2cmUr29y4fA5ZI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=N/3OZVNjxAo43ERVEk8Q+gsP1eAjJCti+aAdUjH9nl7KfcIIWHz/uK2h73HRAUwyx
         gVYGcE3YYuPwk0zIb/NqIfNdUI1WRSmb8q4+OnQItO6xQy2foS5FwmlvoqtkAQ6Rca
         mvYDOovL6DdR3t19NvrKK/PW67e3OyqHB6ihyIjPI+y6LTGW4Uu6SHTffkzCfxDKBc
         Q9pZjsbQzwXMRRrjj0NatWEdZnaePOUlIDnUgwbqwTaY6SAJ6U5FwJ0kWohMVgSRsQ
         Y3GhPCKMOFpvlgd7Sd2lGdN3OqllCNLq/ak6pKDiwH6HuurVaxjUw5OqaTY+b84esP
         cViIQiHSY20NQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EC6665C1456; Thu, 22 Dec 2022 17:05:05 -0800 (PST)
Date:   Thu, 22 Dec 2022 17:05:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Michal Clapinski <mclapinski@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrei Vagin <avagin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] sched/membarrier, selftests: Introduce
 MEMBARRIER_CMD_GET_REGISTRATIONS
Message-ID: <20221223010505.GT4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221207164338.1535591-1-mclapinski@google.com>
 <9fad5641-ebd4-d2e5-6f87-2c409c336072@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fad5641-ebd4-d2e5-6f87-2c409c336072@efficios.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 22, 2022 at 10:28:28AM -0500, Mathieu Desnoyers wrote:
> On 2022-12-07 11:43, Michal Clapinski wrote:
> > This change provides a method to query previously issued registrations.
> > It's needed for CRIU (checkpoint/restore in userspace). Before this
> > change we had to issue private membarrier commands during checkpoint -
> > if they succeeded, they must have been registered. Unfortunately global
> > membarrier succeeds even on unregistered processes, so there was no way to
> > tell if MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED had been issued or not.
> > 
> > CRIU is run after the process has been frozen with ptrace, so we don't
> > have to worry too much about the result of running this command in parallel
> > with registration commands.
> 
> Peter, Paul, I'm OK with the proposed changes. Should we route this through
> sched/core from the tip tree ?
> 
> For both patches:
> 
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Also for both patches:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> Thanks,
> 
> Mathieu
> 
> > 
> > Michal Clapinski (2):
> >    sched/membarrier: Introduce MEMBARRIER_CMD_GET_REGISTRATIONS
> >    selftests/membarrier: Test MEMBARRIER_CMD_GET_REGISTRATIONS
> > 
> >   include/uapi/linux/membarrier.h               |  4 ++
> >   kernel/sched/membarrier.c                     | 39 ++++++++++++++++++-
> >   .../membarrier/membarrier_test_impl.h         | 33 ++++++++++++++++
> >   .../membarrier/membarrier_test_multi_thread.c |  2 +-
> >   .../membarrier_test_single_thread.c           |  6 ++-
> >   5 files changed, 81 insertions(+), 3 deletions(-)
> > 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
