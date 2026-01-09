Return-Path: <linux-kselftest+bounces-48610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD3AD0AA95
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 15:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4607B30141EF
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 14:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCF435FF7B;
	Fri,  9 Jan 2026 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhtLiJ2J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565EB35FF5C;
	Fri,  9 Jan 2026 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969415; cv=none; b=C2uWUbyk1Q16/fzimt5F+DwxF4Jxl77Ar/U+P5YH47HWnSlbS8LWcrdDUBL4CpRfqSMz6UkCvKXFGqexBbaJCjdPzTyhIHl/QJJmvTro1ndS+/ipZIeZOlNENkaAAxmuzbZHC3E6GJEVQRMXCGYmjVMgbBOANEfJvR76y5bS6Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969415; c=relaxed/simple;
	bh=82tEv9SG7gSK/LrzCEIL2spKzNdelM3NvqXeiRK8STE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJN9LOuDzy6riYhcBM18HKIfjhG+TXbHlTLohQEZn+AtxJ3fcrhcpHRkx90FQ4vLXzV0SUA5aGe0lnmM3OJEoX6Y012xPbHb7OIj3E1bDWO3ejNA4K/dcHx63EE7erudAPs5KlBpShaxX1oKMVEsGtuzo2VviMW5mTm5eY7iPlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhtLiJ2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9195EC4CEF1;
	Fri,  9 Jan 2026 14:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767969414;
	bh=82tEv9SG7gSK/LrzCEIL2spKzNdelM3NvqXeiRK8STE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MhtLiJ2Jw1Ie2N6+7M9wBYZaSgPjKd03jZ3UvNzNT3dfPx2iHn1o2NgPPZ3l3mFz3
	 erAuDYxtYRxAWXtVQK0l4k+xIflevKP7HnuV+tlZcmyEAzib8+MHHx9FPGw21q2bfx
	 ah++xxqbs1eF2vzFrM+sPfz+2HdoKLeERkgTJwV4/CF5WRX5HY0MKdGtLIfBHnWh6v
	 QPcKq8shsSTkd2tbw6Bs/2lOFokQ31YJxtvpJ6vaZe1g43Z+KSyfGiJx18fcXOP1Gu
	 hobaiA2rSCs8nAlRz6j6MNHPuYKnZr0MlaQOAnYfFU/X13suUuJaZMpVJrVLY95jsX
	 fbsD/u04KMFTg==
Date: Fri, 9 Jan 2026 15:36:52 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
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
Message-ID: <aWEShKdoEAG0PiPM@localhost.localdomain>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
 <20260101163417.1065705-5-joelagnelf@nvidia.com>
 <aV_n5RqNbikyN90u@localhost.localdomain>
 <20260109034930.GA1105379@joelbox2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109034930.GA1105379@joelbox2>

Le Thu, Jan 08, 2026 at 10:49:30PM -0500, Joel Fernandes a écrit :
> > > @@ -688,6 +690,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> > >  		     bypass_ncbs > 2 * qhimark)) {
> > >  			flush_bypass = true;
> > >  		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
> > > +			rdp->nocb_gp_wake_attempt = false;
> > 
> > This is when nocb_cb_wait() is done with callbacks but nocb_gp_wait() is done
> > with them sooner, when the grace period is done for all pending callbacks.
> > 
> > Something like this would perhaps be more accurate:
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index e6cd56603cad..52010cbeaa76 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -746,6 +746,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> >  			needwait_gp = true;
> >  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> >  					    TPS("NeedWaitGP"));
> > +		} else if (!rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
> > +			rdp->nocb_gp_wake_attempt = false;
> >  		}
> 
> Hmm, I am trying to understand why this suggestion is better than what I
> already have. It is one extra line and adds another conditional.
> 
> Also shouldn't it be:
> 
>   } else if (!rcu_cblist_n_cbs(&rdp->nocb_bypass) &&
>              rcu_segcblist_empty(&rdp->cblist)) {
>       rdp->nocb_gp_wake_attempt = false;
>   }
> 
>   ?

This else already means that rcu_segcblist_nextgp() returned false because there
is no pending callbacks. rcu_segcblist_empty() is different because it also test
done callbacks.

> 
> My goal was to mark wake_attempt as false when ALL callbacks on the rdp were
> drained. IOW, the GP thread is done with the rdp.

So nocb_gp_wait (the rcuog kthreads) handle the pending callbacks, advancing
them throughout grace periods until they are moved to the done state.

But once they are moved as done, the callbacks are the responsibility of
nocb_cb_wait() (the rcuo kthreads) and nocb_gp_wait() stops paying attention
to that rdp if there are no more pending callbacks.

So with your initial patch, you still have rdp->nocb_gp_wake_attempt == true
even when there are only done callbacks. But without an appropriate wake-up
after subsequent enqueue, nocb_gp_wait() may ignore new callbacks, event though
rdp->nocb_gp_wake_attempt == true suggests otherwise.

> Btw, I have more patches coming to simplify nocb_gp_wait()... it is quite long
> :)

Cool :)

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

