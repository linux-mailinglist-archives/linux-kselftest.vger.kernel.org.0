Return-Path: <linux-kselftest+bounces-48548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DC2D050A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 18:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48C48304BBF4
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 17:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281D52F12CE;
	Thu,  8 Jan 2026 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GF+r+yu4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038E929AAF7;
	Thu,  8 Jan 2026 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892969; cv=none; b=HDk/Jzhp8+2I8nZmgjT1On2QzeO8LxgH3M5verQZCFv7Co1qsTFnkCNDeTiN7YASYdp6qY54LyfbZBkeXX8oCbCa2NziDxe8dwaba/2DCGiqayrM3h8Bk+igtS1wcpQ8O9+7fnupI4P4DSmELMhlboMDsIqJtbu6gQAY0Oa+JXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892969; c=relaxed/simple;
	bh=3Sp0aOAyDH1k9247khgpfRzB4UdA8aNZBokql5zf+Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGqXsoIMAMDFIawkpz0uI07/VcDQUtpkvSmwp2xapvhk0NsB1z5t0ti2GygFEkTyMBYNUhZDQyhg88ifwNiAKXpnfKDO0LLlC4Tf1g4Dqrej9ifTq9dywAErdWJhwRfmdlr8m7t9Yn0WeGR/FoTT4mXXwleClLeN9UiV1bNaZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GF+r+yu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D6AC116C6;
	Thu,  8 Jan 2026 17:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892968;
	bh=3Sp0aOAyDH1k9247khgpfRzB4UdA8aNZBokql5zf+Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GF+r+yu4AEqWVlTVbzuVwJFfmaojt98EgL6qtscfYmnHvy5OhBZkWoKDcSn5kyzcL
	 DdIOSXWWIypIh6yKFE7QA7Yc4K51QkuY7hzr1NF8YDHd7pZxiyHQawX49InNE8jRgl
	 NH/JUpdxTR3YneLGUfp0bdBvKBAow+Y2dnLx+f0QGAR2+c4Xtpvk3qQYzbmhc4xmmJ
	 kPU0S9MCy2ptM/7otVffFPES/TBiXummZRWVqUM9vovnT5UVhOhmkf+DWGc1sBmrWz
	 jHyt3bXRkG/2faF2HHca3yppks0Rum178oK+PfQ5KJO2uG1RWiVzxcB38ar0lIDaJi
	 1OZBg1PndtpUQ==
Date: Thu, 8 Jan 2026 18:22:45 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next 4/8] rcu/nocb: Add warning if no rcuog wake up
 attempt happened during overload
Message-ID: <aV_n5RqNbikyN90u@localhost.localdomain>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
 <20260101163417.1065705-5-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260101163417.1065705-5-joelagnelf@nvidia.com>

Le Thu, Jan 01, 2026 at 11:34:13AM -0500, Joel Fernandes a écrit :
> To be sure we have no rcog wake ups that were lost, add a warning
> to cover the case where the rdp is overloaded with callbacks but
> no wake up was attempted.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tree.c      | 4 ++++
>  kernel/rcu/tree.h      | 1 +
>  kernel/rcu/tree_nocb.h | 6 +++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 293bbd9ac3f4..78c045a5ef03 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3767,6 +3767,10 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  		debug_rcu_head_unqueue(&rdp->barrier_head);
>  		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
>  	}
> +#ifdef CONFIG_RCU_NOCB_CPU
> +	if (wake_nocb)
> +		rdp->nocb_gp_wake_attempt = true;
> +#endif

entrain only queues a callback if the list is non-empty. And if it's
non-empty, rdp->nocb_gp_wake_attempt should be true already.

>  	rcu_nocb_unlock(rdp);
>  	if (wake_nocb)
>  		wake_nocb_gp(rdp, false);
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 653fb4ba5852..74bd6a2a2f84 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -257,6 +257,7 @@ struct rcu_data {
>  	unsigned long nocb_gp_loops;	/* # passes through wait code. */
>  	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
>  	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
> +	bool nocb_gp_wake_attempt;	/* Was a rcuog wakeup attempted? */

How about nocb_gp_handling ?

>  	struct task_struct *nocb_cb_kthread;
>  	struct list_head nocb_head_rdp; /*
>  					 * Head of rcu_data list in wakeup chain,
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index daff2756cd90..7e9d465c8ab1 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -546,6 +546,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  	lazy_len = READ_ONCE(rdp->lazy_len);
>  	if (was_alldone) {
>  		rdp->qlen_last_fqs_check = len;
> +		rdp->nocb_gp_wake_attempt = true;
>  		rcu_nocb_unlock(rdp);
>  		// Only lazy CBs in bypass list
>  		if (lazy_len && bypass_len == lazy_len) {
> @@ -563,7 +564,8 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  
>  		return;
>  	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
> -		/* ... or if many callbacks queued. */
> +		/* Callback overload condition. */
> +		WARN_ON_ONCE(!rdp->nocb_gp_wake_attempt);
>  		rdp->qlen_last_fqs_check = len;
>  		j = jiffies;
>  		if (j != rdp->nocb_gp_adv_time &&
> @@ -688,6 +690,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  		     bypass_ncbs > 2 * qhimark)) {
>  			flush_bypass = true;
>  		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
> +			rdp->nocb_gp_wake_attempt = false;

This is when nocb_cb_wait() is done with callbacks but nocb_gp_wait() is done
with them sooner, when the grace period is done for all pending callbacks.

Something like this would perhaps be more accurate:

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index e6cd56603cad..52010cbeaa76 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -746,6 +746,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 			needwait_gp = true;
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("NeedWaitGP"));
+		} else if (!rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
+			rdp->nocb_gp_wake_attempt = false;
 		}
 		if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
 			needwake = rdp->nocb_cb_sleep;


>  			rcu_nocb_unlock_irqrestore(rdp, flags);
>  			continue; /* No callbacks here, try next. */
>  		}
> @@ -1254,6 +1257,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  			continue;
>  		}
>  		rcu_nocb_try_flush_bypass(rdp, jiffies);
> +		rdp->nocb_gp_wake_attempt = true;

Same here, we should expect rdp->nocb_gp_wake_attempt to be already on since
there are lazy callbacks. That's a good opportunity to test the related assertion
though.

Thanks.

>  		rcu_nocb_unlock_irqrestore(rdp, flags);
>  		wake_nocb_gp(rdp, false);
>  		sc->nr_to_scan -= _count;
> -- 
> 2.34.1
> 

-- 
Frederic Weisbecker
SUSE Labs

