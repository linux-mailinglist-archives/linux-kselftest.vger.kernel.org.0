Return-Path: <linux-kselftest+bounces-32517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C394AACBB8
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 19:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56CF11BA7BA0
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27702836A0;
	Tue,  6 May 2025 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YL3YEaYr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A9280004;
	Tue,  6 May 2025 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550460; cv=none; b=JymSOGRL254W+5uDu+1TxULliu2ICJjUL9Su/S8lXmJ2AOB0ONal3Gjc6tDQRcjWtECdMwcigmOU7YLBQqwHWwiYfcsFShHk4bBK3AxkNvXESb6uVL13xKyxv3JKEdC9/vwKMofIAAak6D8Sk9qJXs1u3AJCghtVfEt3X8EygcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550460; c=relaxed/simple;
	bh=Z823hMcPPZYof/30Mxd4GikB2LdielMOJnKPtKVaJJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+vlnIutEjYyeu3nKWwXOPYVXHsHRfMIUXpMzZyZaOsMhhToIXYw1ZguQ0BfsDQsTU+tpzm3yh3+D9vculft7shCTzTRrVEO0dnhoIRJ3iEj1qTKTy1+Al8lWdm1CtKNWqIOLUA7T+Xan3Zf4vwhWfIrmOM1ILxhmU669xt37s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YL3YEaYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EBEC4CEE4;
	Tue,  6 May 2025 16:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746550460;
	bh=Z823hMcPPZYof/30Mxd4GikB2LdielMOJnKPtKVaJJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YL3YEaYr57UMngRzXMXrksbEZIqcZBsKrq7PXc0bWMKfXdbxTgJFw7DbOS+9qizqO
	 19hovTHqCV5gLImcp92jsNdA19Y0ZGpk/kZhnZzHZNobwkkDkr/3DI07YB2O7Qefle
	 m7fC3H7VKI/swGNBTK4l+DYuLjXADxCHzi2KXd8GbnGv5c8d5I+xWR1blxU0alF5hq
	 4BRtLMASrD/UKkSUH8eMQmHgJm8fEg5upjCC9j9OeGTJ73kJOiL5P3SDo3zd0lWrWD
	 tFYDwAtPA7CVJQ8IWQHP35Iv6AFnRN6AVj4cjxoX9rwbiRAEGCHTFND8EFWvYOg3VG
	 fldAYzCX49bxg==
Date: Tue, 6 May 2025 17:54:13 +0100
From: Simon Horman <horms@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
	dave.taht@gmail.com, pabeni@redhat.com, jhs@mojatatu.com,
	kuba@kernel.org, stephen@networkplumber.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, andrew+netdev@lunn.ch, ast@fiberby.net,
	liuhangbin@gmail.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, ij@kernel.org,
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v14 net-next 1/5] sched: Struct definition and parsing of
 dualpi2 qdisc
Message-ID: <20250506165413.GW3339421@horms.kernel.org>
References: <20250505094837.7192-1-chia-yu.chang@nokia-bell-labs.com>
 <20250505094837.7192-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505094837.7192-2-chia-yu.chang@nokia-bell-labs.com>

On Mon, May 05, 2025 at 11:48:33AM +0200, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> DualPI2 is the reference implementation of IETF RFC9332 DualQ Coupled
> AQM (https://datatracker.ietf.org/doc/html/rfc9332) providing two
> queues called low latency (L-queue) and classic (C-queue). By default,
> it enqueues non-ECN and ECT(0) packets into the C-queue and ECT(1) and
> CE packets into the low latency queue (L-queue), as per IETF RFC9332 spec.
> 
> This patch defines the dualpi2 Qdisc structure and parsing, and the
> following two patches include dumping and enqueue/dequeue for the DualPI2.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

...

> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c

...

> +static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
> +			  struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *tb[TCA_DUALPI2_MAX + 1];
> +	struct dualpi2_sched_data *q;
> +	int old_backlog;
> +	int old_qlen;
> +	int err;
> +
> +	if (!opt)
> +		return -EINVAL;
> +	err = nla_parse_nested(tb, TCA_DUALPI2_MAX, opt, dualpi2_policy,
> +			       extack);
> +	if (err < 0)
> +		return err;
> +
> +	q = qdisc_priv(sch);
> +	sch_tree_lock(sch);
> +
> +	if (tb[TCA_DUALPI2_LIMIT]) {
> +		u32 limit = nla_get_u32(tb[TCA_DUALPI2_LIMIT]);
> +
> +		WRITE_ONCE(sch->limit, limit);
> +		WRITE_ONCE(q->memory_limit, get_memory_limit(sch, limit));
> +	}
> +
> +	if (tb[TCA_DUALPI2_MEMORY_LIMIT])
> +		WRITE_ONCE(q->memory_limit,
> +			   nla_get_u32(tb[TCA_DUALPI2_MEMORY_LIMIT]));
> +
> +	if (tb[TCA_DUALPI2_TARGET]) {
> +		u64 target = nla_get_u32(tb[TCA_DUALPI2_TARGET]);
> +
> +		WRITE_ONCE(q->pi2_target, target * NSEC_PER_USEC);
> +	}
> +
> +	if (tb[TCA_DUALPI2_TUPDATE]) {
> +		u64 tupdate = nla_get_u32(tb[TCA_DUALPI2_TUPDATE]);
> +
> +		WRITE_ONCE(q->pi2_tupdate, tupdate * NSEC_PER_USEC);
> +	}
> +
> +	if (tb[TCA_DUALPI2_ALPHA]) {
> +		u32 alpha = nla_get_u32(tb[TCA_DUALPI2_ALPHA]);
> +
> +		WRITE_ONCE(q->pi2_alpha, dualpi2_scale_alpha_beta(alpha));
> +	}
> +
> +	if (tb[TCA_DUALPI2_BETA]) {
> +		u32 beta = nla_get_u32(tb[TCA_DUALPI2_BETA]);
> +
> +		WRITE_ONCE(q->pi2_beta, dualpi2_scale_alpha_beta(beta));
> +	}
> +
> +	if (tb[TCA_DUALPI2_STEP_THRESH]) {
> +		u32 step_th = nla_get_u32(tb[TCA_DUALPI2_STEP_THRESH]);
> +		bool step_pkt = nla_get_flag(tb[TCA_DUALPI2_STEP_PACKETS]);
> +
> +		WRITE_ONCE(q->step_in_packets, step_pkt);
> +		WRITE_ONCE(q->step_thresh,
> +			   step_pkt ? step_th : (step_th * NSEC_PER_USEC));
> +	}
> +
> +	if (tb[TCA_DUALPI2_MIN_QLEN_STEP])
> +		WRITE_ONCE(q->min_qlen_step,
> +			   nla_get_u32(tb[TCA_DUALPI2_MIN_QLEN_STEP]));
> +
> +	if (tb[TCA_DUALPI2_COUPLING]) {
> +		u8 coupling = nla_get_u8(tb[TCA_DUALPI2_COUPLING]);
> +
> +		WRITE_ONCE(q->coupling_factor, coupling);
> +	}
> +
> +	if (tb[TCA_DUALPI2_DROP_OVERLOAD]) {
> +		u8 drop_overload = nla_get_u8(tb[TCA_DUALPI2_DROP_OVERLOAD]);
> +
> +		WRITE_ONCE(q->drop_overload, (bool)drop_overload);
> +	}
> +
> +	if (tb[TCA_DUALPI2_DROP_EARLY]) {
> +		u8 drop_early = nla_get_u8(tb[TCA_DUALPI2_DROP_EARLY]);
> +
> +		WRITE_ONCE(q->drop_early, (bool)drop_early);
> +	}
> +
> +	if (tb[TCA_DUALPI2_C_PROTECTION]) {
> +		u8 wc = nla_get_u8(tb[TCA_DUALPI2_C_PROTECTION]);
> +
> +		dualpi2_calculate_c_protection(sch, q, wc);
> +	}
> +
> +	if (tb[TCA_DUALPI2_ECN_MASK]) {
> +		u8 ecn_mask = nla_get_u8(tb[TCA_DUALPI2_ECN_MASK]);
> +
> +		if (ecn_mask != TCA_DUALPI2_ECN_MASK_L4S_ECT &&
> +		    ecn_mask != TCA_DUALPI2_ECN_MASK_ANY_ECT)
> +			return -EINVAL;

sch_tree_lock() is leaked here.

Flagged by Sparse and Smatch.

> +		WRITE_ONCE(q->ecn_mask, ecn_mask);
> +	}
> +
> +	if (tb[TCA_DUALPI2_SPLIT_GSO]) {
> +		u8 split_gso = nla_get_u8(tb[TCA_DUALPI2_SPLIT_GSO]);
> +
> +		WRITE_ONCE(q->split_gso, (bool)split_gso);
> +	}
> +
> +	old_qlen = qdisc_qlen(sch);
> +	old_backlog = sch->qstats.backlog;
> +	while (qdisc_qlen(sch) > sch->limit ||
> +	       q->memory_used > q->memory_limit) {
> +		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
> +
> +		q->memory_used -= skb->truesize;
> +		qdisc_qstats_backlog_dec(sch, skb);
> +		rtnl_qdisc_drop(skb, sch);
> +	}
> +	qdisc_tree_reduce_backlog(sch, old_qlen - qdisc_qlen(sch),
> +				  old_backlog - sch->qstats.backlog);
> +
> +	sch_tree_unlock(sch);
> +	return 0;
> +}

...

