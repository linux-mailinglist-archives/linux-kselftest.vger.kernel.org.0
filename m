Return-Path: <linux-kselftest+bounces-31285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCC6A96563
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 12:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF9117BA40
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 10:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D2B20B1FC;
	Tue, 22 Apr 2025 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPEQfXQc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7EF20B1F7
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316459; cv=none; b=tir8Edt2U/dhHrBFGxD+Voz20MZPlfipm+W9GqsMI9/8HrSNy/vxc11w3QT151iEGu18MN7V7AKPNptkXwOcjeWv6Ck5tqN4ABt+KaYpIB7RZQLYUXg2t/EhAhJJyaANjVcIOjOOYJBwRquXfueKS03MRztJ76V2Gx8d196uTp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316459; c=relaxed/simple;
	bh=7qsQY4zJi1GBxYfVWJ/Jk+NsdM+fh4kYWBM6nhX7IVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nhQ8e4fiCOPXK8eE5qlxoeyj2LCQm1JFdtPPbSnQ2NSyOAEuj0zMNI7TAqBVIvDQ/HDWZvH2PbEymCWvscj1Z25d7UA2NPl/yCGmwKh6zXSEpgCCruqgMpR63pCeiIQ6rsXWGmG2U9a6ueoWLHyK4CdBxFptaKa3NO+eAmR3BhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hPEQfXQc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745316455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yz+WObe139Yg8z1subX5ABuEaiGZ01WOPhfF4lMpXx4=;
	b=hPEQfXQcfYRzrkEhMG76MluFxmraXLOhZ+godEUOQxr2GuGjaOsDWYTEMdWjpByQVF6tHj
	bcYhPs20+g0naKCvw+lI97yCd84rqePld2uRtx+vbRjeV09DsEmzYpd7WAlIo1wIzcvRh9
	Ge0gIpqOeWBPFACkmvjtswg2RrsKWT4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-ovrTnxw0NuGC1AtK2zBW5A-1; Tue, 22 Apr 2025 06:07:34 -0400
X-MC-Unique: ovrTnxw0NuGC1AtK2zBW5A-1
X-Mimecast-MFC-AGG-ID: ovrTnxw0NuGC1AtK2zBW5A_1745316453
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-391492acb59so2298876f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 03:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316453; x=1745921253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yz+WObe139Yg8z1subX5ABuEaiGZ01WOPhfF4lMpXx4=;
        b=l5W8JP94Ax8Aj7/UdDpx5blNXj9NJPhSQs3AIencrT0nOOLj+0HAzBNx2ZLaLMvKm1
         6d9eIHD+B+ThSNJtfeayqhwBdZIDo8CsYKjgquWeSuk+uFcUtrRfvUZIfZ6h0c3dNsET
         P8egHPUGzpXeG5/7M3PlksRGw12E5+EASuEXwsIq1EfEVDFr8+a+KNMh9MncAFoer5u1
         9uYoRyTTRa50mFd7UeL2er80ENyd0RsDmrzU1daZ90OO6qYvD68GHXAcfOAO0DASwpLp
         sOVptIuI+FdCoX6Pt1FJvLCW1sNgryFttipLyNa4SCHuzW9ucl7BygqqCymVXx2D5dfC
         WvGw==
X-Forwarded-Encrypted: i=1; AJvYcCW+W+CgYuOuWkbqfe2DckVB7aMqzqzAiOWlY5uB8PXkIed7PliJ/1jVzuj8KMZCG+vDzONYo/H+Wq4OxPV6vYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5kBWg9Go3QkA1+YTbnjQvGPcGnGzl5lZATYm72Br/n4UV3Jwp
	kexwzXOJn9QCRs/z11/sz83Bc8KXX6fCfSTXjLinRyagDo14XOZsmqulYdNpqVPUiD4WEbrKH0H
	g4jhDglejrf4JNkOTW/CsLFypQOxiEUnPwpOWfNxL3hjxInYE/J3bplBnXUEmQDRLLg==
X-Gm-Gg: ASbGncvwAjCrzTjYwE0ZUbnazTVhiu4VpyqwuP5WEUxVhzOJqHoXHMBmpGoOoyKRuNJ
	z54h41b74GwS3hCAK92VA6cPs6JQ/GCRvGaAteLfOPcXJ3bu+0IshQ0CBq4Z4KB1BRI3Rtant5+
	zDzN0A1RID6pLHSTByeBYgRwpi68g9ucUzbXXLToqZYWr6Mhlo95kKcxfYBoQH/hCfe5D7bTZCB
	8e+12Yg224rX0Lgr8d1T+r3JvvT4xzVxXPA3gaZcLE2dvLdY+gMR/PqF2vfaBNsk3t+6ihIC8IR
	qjdEVR+8Z94p01HFXSy7YN+84ecNAWXHO1s+
X-Received: by 2002:a05:6000:2403:b0:39b:f12c:385e with SMTP id ffacd0b85a97d-39efba460f4mr11363095f8f.20.1745316453074;
        Tue, 22 Apr 2025 03:07:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC2MPSoSTTGElrWizhKj7puDvznu1saATnNf0IHrzVc5zmkkz+Y//cDrSY0pkq6wf+0XWvOg==
X-Received: by 2002:a05:6000:2403:b0:39b:f12c:385e with SMTP id ffacd0b85a97d-39efba460f4mr11363063f8f.20.1745316452493;
        Tue, 22 Apr 2025 03:07:32 -0700 (PDT)
Received: from [192.168.88.253] (146-241-86-8.dyn.eolo.it. [146.241.86.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43bef1sm14453992f8f.49.2025.04.22.03.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 03:07:32 -0700 (PDT)
Message-ID: <75af7a51-1a7a-4e65-8ce6-f28411800070@redhat.com>
Date: Tue, 22 Apr 2025 12:07:29 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 net-next 3/5] sched: Struct definition and parsing of
 dualpi2 qdisc
To: chia-yu.chang@nokia-bell-labs.com, xandfury@gmail.com,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
 <20250415124317.11561-4-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250415124317.11561-4-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/15/25 2:43 PM, chia-yu.chang@nokia-bell-labs.com wrote:
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
> ---
>  include/uapi/linux/pkt_sched.h |  24 ++
>  net/sched/sch_dualpi2.c        | 552 +++++++++++++++++++++++++++++++++
>  2 files changed, 576 insertions(+)
>  create mode 100644 net/sched/sch_dualpi2.c
> 
> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
> index 25a9a47001cd..fd5bec118cdc 100644
> --- a/include/uapi/linux/pkt_sched.h
> +++ b/include/uapi/linux/pkt_sched.h
> @@ -1210,4 +1210,28 @@ enum {
>  
>  #define TCA_ETS_MAX (__TCA_ETS_MAX - 1)
>  
> +/* DUALPI2 */
> +enum {
> +	TCA_DUALPI2_UNSPEC,
> +	TCA_DUALPI2_LIMIT,		/* Packets */
> +	TCA_DUALPI2_MEMORY_LIMIT,	/* Bytes */
> +	TCA_DUALPI2_TARGET,		/* us */
> +	TCA_DUALPI2_TUPDATE,		/* us */
> +	TCA_DUALPI2_ALPHA,		/* Hz scaled up by 256 */
> +	TCA_DUALPI2_BETA,		/* HZ scaled up by 256 */
> +	TCA_DUALPI2_STEP_THRESH,	/* Packets or us */
> +	TCA_DUALPI2_STEP_PACKETS,	/* Whether STEP_THRESH is in packets */
> +	TCA_DUALPI2_MIN_QLEN_STEP,	/* Minimum qlen to apply STEP_THRESH */
> +	TCA_DUALPI2_COUPLING,		/* Coupling factor between queues */
> +	TCA_DUALPI2_DROP_OVERLOAD,	/* Whether to drop on overload */
> +	TCA_DUALPI2_DROP_EARLY,		/* Whether to drop on enqueue */
> +	TCA_DUALPI2_C_PROTECTION,	/* Percentage */
> +	TCA_DUALPI2_ECN_MASK,		/* L4S queue classification mask */
> +	TCA_DUALPI2_SPLIT_GSO,		/* Split GSO packets at enqueue */
> +	TCA_DUALPI2_PAD,
> +	__TCA_DUALPI2_MAX
> +};
> +
> +#define TCA_DUALPI2_MAX   (__TCA_DUALPI2_MAX - 1)
> +
>  #endif
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> new file mode 100644
> index 000000000000..3f91f6b1db2f
> --- /dev/null
> +++ b/net/sched/sch_dualpi2.c
> @@ -0,0 +1,552 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +/* Copyright (C) 2024 Nokia
> + *
> + * Author: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> + * Author: Olga Albisser <olga@albisser.org>
> + * Author: Henrik Steen <henrist@henrist.net>
> + * Author: Olivier Tilmans <olivier.tilmans@nokia.com>
> + * Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> + *
> + * DualPI Improved with a Square (dualpi2):
> + * - Supports congestion controls that comply with the Prague requirements
> + *   in RFC9331 (e.g. TCP-Prague)
> + * - Supports coupled dual-queue with PI2 as defined in RFC9332
> + * - Supports ECN L4S-identifier (IP.ECN==0b*1)
> + *
> + * note: Although DCTCP and BBRv3 can use shallow-threshold ECN marks,
> + *   they do not meet the 'Prague L4S Requirements' listed in RFC 9331
> + *   Section 4, so they can only be used with DualPI2 in a datacenter
> + *   context.
> + *
> + * References:
> + * - RFC9332: https://datatracker.ietf.org/doc/html/rfc9332
> + * - De Schepper, Koen, et al. "PI 2: A linearized AQM for both classic and
> + *   scalable TCP."  in proc. ACM CoNEXT'16, 2016.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/hrtimer.h>
> +#include <linux/if_vlan.h>
> +#include <linux/kernel.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/skbuff.h>
> +#include <linux/types.h>
> +
> +#include <net/gso.h>
> +#include <net/inet_ecn.h>
> +#include <net/pkt_cls.h>
> +#include <net/pkt_sched.h>
> +
> +/* 32b enable to support flows with windows up to ~8.6 * 1e9 packets
> + * i.e., twice the maximal snd_cwnd.
> + * MAX_PROB must be consistent with the RNG in dualpi2_roll().
> + */
> +#define MAX_PROB U32_MAX
> +
> +/* alpha/beta values exchanged over netlink are in units of 256ns */
> +#define ALPHA_BETA_SHIFT 8
> +
> +/* Scaled values of alpha/beta must fit in 32b to avoid overflow in later
> + * computations. Consequently (see and dualpi2_scale_alpha_beta()), their
> + * netlink-provided values can use at most 31b, i.e. be at most (2^23)-1
> + * (~4MHz) as those are given in 1/256th. This enable to tune alpha/beta to
> + * control flows whose maximal RTTs can be in usec up to few secs.
> + */
> +#define ALPHA_BETA_MAX ((1U << 31) - 1)
> +
> +/* Internal alpha/beta are in units of 64ns.
> + * This enables to use all alpha/beta values in the allowed range without loss
> + * of precision due to rounding when scaling them internally, e.g.,
> + * scale_alpha_beta(1) will not round down to 0.
> + */
> +#define ALPHA_BETA_GRANULARITY 6
> +
> +#define ALPHA_BETA_SCALING (ALPHA_BETA_SHIFT - ALPHA_BETA_GRANULARITY)
> +
> +/* We express the weights (wc, wl) in %, i.e., wc + wl = 100 */
> +#define MAX_WC 100
> +
> +struct dualpi2_sched_data {
> +	struct Qdisc *l_queue;	/* The L4S Low latency queue (L-queue) */
> +	struct Qdisc *sch;	/* The Classic queue (C-queue) */
> +
> +	/* Registered tc filters */
> +	struct tcf_proto __rcu *tcf_filters;
> +	struct tcf_block *tcf_block;
> +
> +	struct { /* PI2 parameters */
> +		u64	target;	/* Target delay in nanoseconds */
> +		u32	tupdate;/* Timer frequency in nanoseconds */
> +		u32	prob;	/* Base PI probability */
> +		u32	alpha;	/* Gain factor for the integral rate response */
> +		u32	beta;	/* Gain factor for the proportional response */
> +		struct hrtimer timer; /* prob update timer */
> +	} pi2;

I think I already suggested in a previois revision to avoid using
anonimous struct to logically group some fields??? The preferred way to
reach such goal is to add a prefix to the field name.

> +
> +	struct { /* Step AQM (L-queue only) parameters */
> +		u32	thresh;	/* Step threshold */
> +		bool	in_packets; /* Whether the step is in packets or time */
> +	} step;
> +
> +	struct { /* C-queue starvation protection */
> +		s32	credit; /* Credit (sign indicates which queue) */
> +		s32	init;	/* Reset value of the credit */
> +		u8	wc;	/* C-queue weight (between 0 and MAX_WC) */
> +		u8	wl;	/* L-queue weight (MAX_WC - wc) */
> +	} c_protection;
> +
> +	/* General dualQ parameters */
> +	u32	memory_limit;	/* Memory limit of both queues */
> +	u8	coupling_factor;/* Coupling factor (k) between both queues */
> +	u8	ecn_mask;	/* Mask to match packets into L-queue */
> +	u32	min_qlen_step;	/* Minimum queue length to apply step thresh */
> +	bool	drop_early;	/* Drop at enqueue instead of dequeue if true */
> +	bool	drop_overload;	/* Drop (1) on overload, or overflow (0) */
> +	bool	split_gso;	/* Split aggregated skb (1) or leave as is */
> +
> +	/* Statistics */
> +	u64	c_head_ts;	/* Enqueue timestamp of the C-queue head */
> +	u64	l_head_ts;	/* Enqueue timestamp of the L-queue head */
> +	u64	last_qdelay;	/* Q delay val at the last probability update */
> +	u32	packets_in_c;	/* Enqueue packet counter of the C-queue */
> +	u32	packets_in_l;	/* Enqueue packet counter of the L-queue */
> +	u32	maxq;		/* Maximum queue size of the C-queue */
> +	u32	ecn_mark;	/* ECN mark pkt counter due to PI probability */
> +	u32	step_marks;	/* ECN mark pkt counter due to step AQM */
> +	u32	memory_used;	/* Memory used of both queues */
> +	u32	max_memory_used;/* Maximum used memory */
> +};
> +
> +static u32 dualpi2_scale_alpha_beta(u32 param)
> +{
> +	u64 tmp = ((u64)param * MAX_PROB >> ALPHA_BETA_SCALING);
> +
> +	do_div(tmp, NSEC_PER_SEC);
> +	return tmp;
> +}
> +
> +static ktime_t next_pi2_timeout(struct dualpi2_sched_data *q)
> +{
> +	return ktime_add_ns(ktime_get_ns(), q->pi2.tupdate);
> +}
> +
> +static void dualpi2_reset_c_protection(struct dualpi2_sched_data *q)
> +{
> +	q->c_protection.credit = q->c_protection.init;
> +}
> +
> +/* This computes the initial credit value and WRR weight for the L queue (wl)
> + * from the weight of the C queue (wc).
> + * If wl > wc, the scheduler will start with the L queue when reset.
> + */
> +static void dualpi2_calculate_c_protection(struct Qdisc *sch,
> +					   struct dualpi2_sched_data *q, u32 wc)
> +{
> +	q->c_protection.wc = wc;
> +	q->c_protection.wl = MAX_WC - wc;
> +	q->c_protection.init = (s32)psched_mtu(qdisc_dev(sch)) *
> +		((int)q->c_protection.wc - (int)q->c_protection.wl);
> +	dualpi2_reset_c_protection(q);
> +}
> +
> +static s64 __scale_delta(u64 diff)
> +{
> +	do_div(diff, 1 << ALPHA_BETA_GRANULARITY);
> +	return diff;
> +}
> +
> +static void get_queue_delays(struct dualpi2_sched_data *q, u64 *qdelay_c,
> +			     u64 *qdelay_l)
> +{
> +	u64 now, qc, ql;
> +
> +	now = ktime_get_ns();
> +	qc = READ_ONCE(q->c_head_ts);
> +	ql = READ_ONCE(q->l_head_ts);
> +
> +	*qdelay_c = qc ? now - qc : 0;
> +	*qdelay_l = ql ? now - ql : 0;
> +}
> +
> +static u32 calculate_probability(struct Qdisc *sch)
> +{
> +	struct dualpi2_sched_data *q = qdisc_priv(sch);
> +	u32 new_prob;
> +	u64 qdelay_c;
> +	u64 qdelay_l;
> +	u64 qdelay;
> +	s64 delta;
> +
> +	get_queue_delays(q, &qdelay_c, &qdelay_l);
> +	qdelay = max(qdelay_l, qdelay_c);
> +	/* Alpha and beta take at most 32b, i.e, the delay difference would
> +	 * overflow for queuing delay differences > ~4.2sec.
> +	 */
> +	delta = ((s64)qdelay - q->pi2.target) * q->pi2.alpha;
> +	delta += ((s64)qdelay - q->last_qdelay) * q->pi2.beta;
> +	if (delta > 0) {
> +		new_prob = __scale_delta(delta) + q->pi2.prob;
> +		if (new_prob < q->pi2.prob)
> +			new_prob = MAX_PROB;
> +	} else {
> +		new_prob = q->pi2.prob - __scale_delta(~delta + 1);
> +		if (new_prob > q->pi2.prob)
> +			new_prob = 0;
> +	}
> +	q->last_qdelay = qdelay;
> +	/* If we do not drop on overload, ensure we cap the L4S probability to
> +	 * 100% to keep window fairness when overflowing.
> +	 */
> +	if (!q->drop_overload)
> +		return min_t(u32, new_prob, MAX_PROB / q->coupling_factor);
> +	return new_prob;
> +}
> +
> +static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
> +{
> +	struct dualpi2_sched_data *q = from_timer(q, timer, pi2.timer);
> +
> +	WRITE_ONCE(q->pi2.prob, calculate_probability(q->sch));
> +
> +	hrtimer_set_expires(&q->pi2.timer, next_pi2_timeout(q));
> +	return HRTIMER_RESTART;
> +}
> +
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
> +static const struct nla_policy dualpi2_policy[TCA_DUALPI2_MAX + 1] = {
> +	[TCA_DUALPI2_LIMIT]		= NLA_POLICY_MIN(NLA_U32, 1),
> +	[TCA_DUALPI2_MEMORY_LIMIT]	= NLA_POLICY_MIN(NLA_U32, 1),
> +	[TCA_DUALPI2_TARGET]		= {.type = NLA_U32},
> +	[TCA_DUALPI2_TUPDATE]		= NLA_POLICY_MIN(NLA_U32, 1),
> +	[TCA_DUALPI2_ALPHA]		=
> +		NLA_POLICY_FULL_RANGE(NLA_U32, &dualpi2_alpha_beta_range),
> +	[TCA_DUALPI2_BETA]		=
> +		NLA_POLICY_FULL_RANGE(NLA_U32, &dualpi2_alpha_beta_range),
> +	[TCA_DUALPI2_STEP_THRESH]	= {.type = NLA_U32},
> +	[TCA_DUALPI2_STEP_PACKETS]	= {.type = NLA_U8},
> +	[TCA_DUALPI2_MIN_QLEN_STEP]	= {.type = NLA_U32},
> +	[TCA_DUALPI2_COUPLING]		= NLA_POLICY_MIN(NLA_U8, 1),
> +	[TCA_DUALPI2_DROP_OVERLOAD]	= {.type = NLA_U8},
> +	[TCA_DUALPI2_DROP_EARLY]	= {.type = NLA_U8},
> +	[TCA_DUALPI2_C_PROTECTION]	=
> +		NLA_POLICY_FULL_RANGE(NLA_U8, &dualpi2_wc_range),
> +	[TCA_DUALPI2_ECN_MASK]		= {.type = NLA_U8},
> +	[TCA_DUALPI2_SPLIT_GSO]		= {.type = NLA_U8},
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
> +		WRITE_ONCE(q->memory_limit, limit * psched_mtu(qdisc_dev(sch)));

Without more strict policy, large value of 'limit' will cause overflow
in the above multiplication, possibly leading to unsuitable very small
'memory_limit'

You should update the policy and/or use 64 bits integer for 'memory_limit'

> +	}
> +
> +	if (tb[TCA_DUALPI2_MEMORY_LIMIT])
> +		WRITE_ONCE(q->memory_limit,
> +			   nla_get_u32(tb[TCA_DUALPI2_MEMORY_LIMIT]));
> +
> +	if (tb[TCA_DUALPI2_TARGET]) {
> +		u64 target = nla_get_u32(tb[TCA_DUALPI2_TARGET]);
> +
> +		WRITE_ONCE(q->pi2.target, target * NSEC_PER_USEC);
> +	}
> +
> +	if (tb[TCA_DUALPI2_TUPDATE]) {
> +		u64 tupdate = nla_get_u32(tb[TCA_DUALPI2_TUPDATE]);
> +
> +		WRITE_ONCE(q->pi2.tupdate, tupdate * NSEC_PER_USEC);
> +	}
> +
> +	if (tb[TCA_DUALPI2_ALPHA]) {
> +		u32 alpha = nla_get_u32(tb[TCA_DUALPI2_ALPHA]);
> +
> +		WRITE_ONCE(q->pi2.alpha, dualpi2_scale_alpha_beta(alpha));
> +	}
> +
> +	if (tb[TCA_DUALPI2_BETA]) {
> +		u32 beta = nla_get_u32(tb[TCA_DUALPI2_BETA]);
> +
> +		WRITE_ONCE(q->pi2.beta, dualpi2_scale_alpha_beta(beta));
> +	}
> +
> +	if (tb[TCA_DUALPI2_STEP_PACKETS]) {
> +		bool step_pkt = !!nla_get_u8(tb[TCA_DUALPI2_STEP_PACKETS]);
> +		u32 step_th = READ_ONCE(q->step.thresh);
> +
> +		WRITE_ONCE(q->step.in_packets, step_pkt);
> +		WRITE_ONCE(q->step.thresh,
> +			   step_pkt ? step_th : (step_th * NSEC_PER_USEC));
> +	}
> +
> +	if (tb[TCA_DUALPI2_STEP_THRESH]) {
> +		u32 step_th = nla_get_u32(tb[TCA_DUALPI2_STEP_THRESH]);
> +		bool step_pkt = READ_ONCE(q->step.in_packets);
> +
> +		WRITE_ONCE(q->step.thresh,
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
> +	if (tb[TCA_DUALPI2_DROP_OVERLOAD])
> +		WRITE_ONCE(q->drop_overload,
> +			   !!nla_get_u8(tb[TCA_DUALPI2_DROP_OVERLOAD]));
> +
> +	if (tb[TCA_DUALPI2_DROP_EARLY])
> +		WRITE_ONCE(q->drop_early,
> +			   !!nla_get_u8(tb[TCA_DUALPI2_DROP_EARLY]));
> +
> +	if (tb[TCA_DUALPI2_C_PROTECTION]) {
> +		u8 wc = nla_get_u8(tb[TCA_DUALPI2_C_PROTECTION]);
> +
> +		dualpi2_calculate_c_protection(sch, q, wc);
> +	}
> +
> +	if (tb[TCA_DUALPI2_ECN_MASK])
> +		WRITE_ONCE(q->ecn_mask,
> +			   nla_get_u8(tb[TCA_DUALPI2_ECN_MASK]));
> +
> +	if (tb[TCA_DUALPI2_SPLIT_GSO])
> +		WRITE_ONCE(q->split_gso,
> +			   !!nla_get_u8(tb[TCA_DUALPI2_SPLIT_GSO]));
> +
> +	old_qlen = qdisc_qlen(sch);
> +	old_backlog = sch->qstats.backlog;
> +	while (qdisc_qlen(sch) > sch->limit ||
> +	       q->memory_used > q->memory_limit) {
> +		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
> +
> +		q->memory_used -= skb->truesize;

The 'memory_limit' is computed above using psched_mtu() which return a
packet length in bytes not including per packet overhead, but
'memory_used' apparently accounts for the skb truesize - that includes
per packet overhead. You should likely update the 'memory_limit' algebra
to take in account per packet overhead. Rule of thumb is doubling the
packet length.

Cheers,

Paolo


