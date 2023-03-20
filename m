Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B4E6C1199
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 13:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjCTMNf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 08:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCTMNe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 08:13:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657261CACA;
        Mon, 20 Mar 2023 05:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GJdEKWPIVw/eEI9/Pcq9tAkhFXUieuQ+zft5brv7JyE=; b=LpgeE8Jgx0q339NgIGR6n5lQ0v
        YQwk8La2zF1EGqr0bnc6UaAsX5unjmAakuBRdwnJV+zJfivazuJ1pbBGOo2QFqLOugy6Xw7JpBcok
        qgGTYlZlMJHma92YD8AK50Xyc3TlcgBKryl/bMyT/eAqYLrj9BCz8XswU6oNufsWsegst9PE8FWv1
        t/pJJ3YUxYABaOxX5dLwfxDM+F6x6/SG9nC7K68q7IxOTTGyheFVufWHIMRBheaDhEVaIh4r51bVL
        w9yPoSfBrqZ6umPTdAtpz3hLdi6Hb3oOfO2zZwngs6HrUa/q6cgTFU6k0q/ov2PB9CTZ4hD5Q9bAE
        SeeJh41A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1peENw-001046-Bb; Mon, 20 Mar 2023 12:13:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FD0930031E;
        Mon, 20 Mar 2023 13:13:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D09220EEFFC4; Mon, 20 Mar 2023 13:13:05 +0100 (CET)
Date:   Mon, 20 Mar 2023 13:13:05 +0100
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
Subject: Re: [PATCH rcu 4/7] locking/lockdep: Improve the deadlock scenario
 print for sync and read lock
Message-ID: <20230320121305.GK2194297@hirez.programming.kicks-ass.net>
References: <20230317031339.10277-1-boqun.feng@gmail.com>
 <20230317031339.10277-5-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317031339.10277-5-boqun.feng@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 16, 2023 at 08:13:36PM -0700, Boqun Feng wrote:
> Lock scenario print is always a weak spot of lockdep splats. Improvement
> can be made if we rework the dependency search and the error printing.
> 
> However without touching the graph search, we can improve a little for
> the circular deadlock case, since we have the to-be-added lock
> dependency, and know whether these two locks are read/write/sync.
> 
> In order to know whether a held_lock is sync or not, a bit was
> "stolen" from ->references, which reduce our limit for the same lock
> class nesting from 2^12 to 2^11, and it should still be good enough.
> 
> Besides, since we now have bit in held_lock for sync, we don't need the
> "hardirqoffs being 1" trick, and also we can avoid the __lock_release()
> if we jump out of __lock_acquire() before the held_lock stored.
> 
> With these changes, a deadlock case evolved with read lock and sync gets
> a better print-out from:
> 
> 	[...]  Possible unsafe locking scenario:
> 	[...]
> 	[...]        CPU0                    CPU1
> 	[...]        ----                    ----
> 	[...]   lock(srcuA);
> 	[...]                                lock(srcuB);
> 	[...]                                lock(srcuA);
> 	[...]   lock(srcuB);
> 
> to
> 
> 	[...]  Possible unsafe locking scenario:
> 	[...]
> 	[...]        CPU0                    CPU1
> 	[...]        ----                    ----
> 	[...]   rlock(srcuA);
> 	[...]                                lock(srcuB);
> 	[...]                                lock(srcuA);
> 	[...]   sync(srcuB);
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  include/linux/lockdep.h  |  3 ++-
>  kernel/locking/lockdep.c | 48 ++++++++++++++++++++++++++--------------
>  2 files changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 14d9dbedc6c1..b32256e9e944 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -134,7 +134,8 @@ struct held_lock {
>  	unsigned int read:2;        /* see lock_acquire() comment */
>  	unsigned int check:1;       /* see lock_acquire() comment */
>  	unsigned int hardirqs_off:1;
> -	unsigned int references:12;					/* 32 bits */
> +	unsigned int sync:1;
> +	unsigned int references:11;					/* 32 bits */
>  	unsigned int pin_count;
>  };
>  

Yeah, I suppose we can do that -- another option is to steal some bits
from pin_count, but whatever (references used to be 11 a long while ago,
no problem going back to that).

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
