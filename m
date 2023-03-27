Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F906CA8BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 17:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjC0PPX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 11:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjC0PPW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 11:15:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6B7122;
        Mon, 27 Mar 2023 08:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ESG8YxL4RYEQX1LFkg3iiiQWrSAkB2oA83asusDbCz4=; b=NWAfI7QUlRz5+ccBJuYiIVOHkK
        QcMvSDy6LPabwrq5DTM051didsJVlsxaLJpRqwkSJtJxeg4drvCeKgpS0iOXkwr0Mcp8Z4uDaRIgE
        rL3DwDja41UzXNHqcjp5ES1nZVdAGAejX9PAjNqdX0quYv4jKjdz9VvwFU4GXXSSNYpa/GFmKIWgQ
        7knDdaHckHpJBZi7ikYjLB6V4cnUq7hSBlAQZx1HPysqEdpoFcys15/XC/INGGyp8O9HPWCwFXbJG
        tTgpiRFuCJFGAXWM1CjzfdpGG5Ol1IECAXg+C3cR6dyuWTsnYsP390rbFeRYdY4YUONI58dk3rgE3
        vr8AwB5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pgoYm-007VJI-Qe; Mon, 27 Mar 2023 15:15:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BBBA9300379;
        Mon, 27 Mar 2023 17:14:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A0F8200D8E1F; Mon, 27 Mar 2023 17:14:58 +0200 (CEST)
Date:   Mon, 27 Mar 2023 17:14:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH rcu v2 0/7] RCU-related lockdep changes for v6.4
Message-ID: <20230327151458.GB11425@hirez.programming.kicks-ass.net>
References: <20230323042614.1191120-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323042614.1191120-1-boqun.feng@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 22, 2023 at 09:26:07PM -0700, Boqun Feng wrote:
> Boqun Feng (4):
>   locking/lockdep: Introduce lock_sync()
>   rcu: Annotate SRCU's update-side lockdep dependencies
>   locking: Reduce the number of locks in ww_mutex stress tests
>   locking/lockdep: Improve the deadlock scenario print for sync and read
>     lock
> 
> Paul E. McKenney (3):
>   rcutorture: Add SRCU deadlock scenarios
>   rcutorture: Add RCU Tasks Trace and SRCU deadlock scenarios
>   rcutorture: Add srcu_lockdep.sh
> 
>  include/linux/lockdep.h                       |   8 +-
>  include/linux/srcu.h                          |  34 +++-
>  kernel/locking/lockdep.c                      |  64 +++++-
>  kernel/locking/test-ww_mutex.c                |   2 +-
>  kernel/rcu/rcutorture.c                       | 185 ++++++++++++++++++
>  kernel/rcu/srcutiny.c                         |   2 +
>  kernel/rcu/srcutree.c                         |   2 +
>  .../selftests/rcutorture/bin/srcu_lockdep.sh  |  78 ++++++++
>  8 files changed, 364 insertions(+), 11 deletions(-)
>  create mode 100755 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
