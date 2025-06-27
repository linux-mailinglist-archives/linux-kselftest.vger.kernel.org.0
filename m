Return-Path: <linux-kselftest+bounces-36019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CEAAEC2FC
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 01:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 329A77A7160
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 23:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FA72900A4;
	Fri, 27 Jun 2025 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNyXAkF6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6E428F93E;
	Fri, 27 Jun 2025 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751066704; cv=none; b=QtAN14/aIo+AMCgIwldf4k67eWSvk06Zzdfq2v7UEIZz6zRaS6DeIvarBQf2Nb07z0cg9OoHjKVZiC+L+EJFRDydSZX0nfu+1DZW6ZRSU5fnz6eDOYEeFoNoX561CN4A6JKFCjMUemqj+lGgt8KQv4DK2LgOvn2cxfg5hrYUNvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751066704; c=relaxed/simple;
	bh=DfSQpv9BuNSk64qvvBNZUTv3g4SIIiQk09oIHwENVY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npT5egd1HQkgNxLAPgqTeVzsB+CSLAno1MT9lyqguhW3pDev0REuHhQ3wfYd+epSwUZL+qYk0wFMWVi2ElB4GkUNrS7STl6hZ/wqMALoohdcigTjm8d9Rled6Xj8ybxMd3LDQ21dDA47jqcPzf4sOqX3E/tm+uYsF29lJrIJ6Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNyXAkF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D5EC4CEE3;
	Fri, 27 Jun 2025 23:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751066704;
	bh=DfSQpv9BuNSk64qvvBNZUTv3g4SIIiQk09oIHwENVY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pNyXAkF6cZWOvWn90iksGtmuCHGJmD7csiIPE0tIt6mQjftEKe3iwEF06C9i6/wUu
	 MuXPrLqqqzQBTJodh0PXlvDA+BnTC8BsdsL87qZNvLhsfdZ4OjFKTPu4hSteamQ32D
	 c5c79SfoKN4SbQ6vXXpPNc09h6/FerH7z8ajBJMfGtZQs9JHdFLrVj3JnDWl8CGhEK
	 bauUvgsBAw0q1xUk+vxFhi51EOOPu3BZB2plvXtCc17sa/RmTNdEMW77IQSAy1NsP3
	 N+nfEEpAuoG7CvKDIiRwcW+E+hE0kYYsS8MWqAp8x9X9/qgIE+pVCU+nlBfC8FHAZW
	 Qq/i4gZI0qQcw==
Date: Fri, 27 Jun 2025 16:25:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: alok.a.tiwari@oracle.com, pctammela@mojatatu.com, horms@kernel.org,
 donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, pabeni@redhat.com, jhs@mojatatu.com,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v20 net-next 1/6] sched: Struct definition and parsing
 of dualpi2 qdisc
Message-ID: <20250627162502.0a82accf@kernel.org>
In-Reply-To: <20250621193331.16421-2-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
	<20250621193331.16421-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Jun 2025 21:33:26 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
> +static struct netlink_range_validation dualpi2_alpha_beta_range = {
> +	.min = 1,
> +	.max = ALPHA_BETA_MAX,
> +};
> +
> +static struct netlink_range_validation dualpi2_wc_range = {
> +	.min = 0,
> +	.max = MAX_WC,
> +};
> +
> +static struct netlink_range_validation dualpi2_ecn_mask_range = {
> +	.min = TCA_DUALPI2_ECN_MASK_L4S_ECT,
> +	.max = TCA_DUALPI2_ECN_MASK_MAX,
> +};

ranges which fit in s16 can be expressed directly with
NLA_POLICY_RANGE(), you don't need the out-of-line struct.

> +static const struct nla_policy dualpi2_policy[TCA_DUALPI2_MAX + 1] = {
> +	[TCA_DUALPI2_LIMIT]		= NLA_POLICY_MIN(NLA_U32, 1),
> +	[TCA_DUALPI2_MEMORY_LIMIT]	= NLA_POLICY_MIN(NLA_U32, 1),
> +	[TCA_DUALPI2_TARGET]		= {.type = NLA_U32},

nit: spaces around {} brackets 		= { .type = NLA_U32 },

> +	[TCA_DUALPI2_TUPDATE]		= NLA_POLICY_MIN(NLA_U32, 1),
> +	[TCA_DUALPI2_ALPHA]		=
> +		NLA_POLICY_FULL_RANGE(NLA_U32, &dualpi2_alpha_beta_range),
> +	[TCA_DUALPI2_BETA]		=
> +		NLA_POLICY_FULL_RANGE(NLA_U32, &dualpi2_alpha_beta_range),
> +	[TCA_DUALPI2_STEP_THRESH]	= {.type = NLA_U32},
> +	[TCA_DUALPI2_STEP_PACKETS]	= {.type = NLA_FLAG},
> +	[TCA_DUALPI2_MIN_QLEN_STEP]	= {.type = NLA_U32},
> +	[TCA_DUALPI2_COUPLING]		= NLA_POLICY_MIN(NLA_U8, 1),
> +	[TCA_DUALPI2_DROP_OVERLOAD]	=
> +		NLA_POLICY_MAX(NLA_U8, TCA_DUALPI2_DROP_OVERLOAD_MAX),
> +	[TCA_DUALPI2_DROP_EARLY]	=
> +		NLA_POLICY_MAX(NLA_U8, TCA_DUALPI2_DROP_EARLY_MAX),
> +	[TCA_DUALPI2_C_PROTECTION]	=
> +		NLA_POLICY_FULL_RANGE(NLA_U8, &dualpi2_wc_range),
> +	[TCA_DUALPI2_ECN_MASK]		=
> +		NLA_POLICY_FULL_RANGE(NLA_U8, &dualpi2_ecn_mask_range),
> +	[TCA_DUALPI2_SPLIT_GSO]		=
> +		NLA_POLICY_MAX(NLA_U8, TCA_DUALPI2_SPLIT_GSO_MAX),
> +};
> +
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

should there be an extack message here?

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
> +		WRITE_ONCE(q->pi2_tupdate, convert_us_to_nsec(tupdate));
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
> +			   step_pkt ? step_th : convert_us_to_nsec(step_th));
> +	}

I don't get the reason for all these WRITE_ONCE()s.
You lock the qdisc to make modifications, right?
And the block under which I'm responding is performing two dependent
writes, one to ->step_in_packets and the other to ->step_thresh
a change which is definitely not atomic..

