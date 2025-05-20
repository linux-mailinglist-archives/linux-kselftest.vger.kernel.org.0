Return-Path: <linux-kselftest+bounces-33397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBD5ABD789
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 13:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5B41BA2A13
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 11:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE042279781;
	Tue, 20 May 2025 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/ts1HLD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B4221C9F2
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742345; cv=none; b=DCWgUZFMINpxZSrwQ4PRlnK8fXW0T7vhymoe1lInVVWOOI9JmK/Mb/3knTCd6on2yTrd+yA7zd5pOeFqFtk5ClpRPzIdGAV0zca88CuMqSDG9gKjwkdRrM7+ou+r0pjYvzbYuZkXs+VzSp5O4Qi0zha1CqAp/0H4fRvLhZI5rcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742345; c=relaxed/simple;
	bh=nXWSIhyU39QRKt6WQ0laW5mj88qmkU/jRLeC/v8jbzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I2IoZz8+crh4TiKEC9QIoH7bAFLKMP2/QzDuwso9vP3EOND0fkTE4lN3EsFk9mv/KphqW23qb+UnxjsitDnlUzoXRLg/czlyfeB/pBmbMzGQhSZ0g6aZGj1yYCjRLGVU4d0Rc3ZNz18e3zMA8wefnDHEpnLDbcZ/YEnwqErsKF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/ts1HLD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747742342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiDrqUHrJ5RRFmJ9shg+DFH2qBY04+xmY0waWetIyb0=;
	b=C/ts1HLDiWJ6J2+0UCQPTQg3zS42yJ4BDKI0Bxf9QSGzzSpTAKLWZDdwhxB9dj6gtdptx5
	T9OHyUpaqznY8wf9rISVuBrZF0ihk0HfpJ4thbZ94StTQuYjnbDdu1Ivr0Lhi3g5rCAyYU
	MCQ7EuBG7CiZudgXu5/kmuzvfpvFwZY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-jVnMGMsEMK2Il_T0uEl7jg-1; Tue, 20 May 2025 07:59:01 -0400
X-MC-Unique: jVnMGMsEMK2Il_T0uEl7jg-1
X-Mimecast-MFC-AGG-ID: jVnMGMsEMK2Il_T0uEl7jg_1747742340
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a362dcc86fso1525402f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 04:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742340; x=1748347140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiDrqUHrJ5RRFmJ9shg+DFH2qBY04+xmY0waWetIyb0=;
        b=Lcc3I0FNWXLIQCq87e8jf9c/fUPkwESYqY9hB8SYWXX1M69ylTlLGCR/bDGRwEH5LO
         801gqz3g0oQa3u7KHVZMEuZmMLZ6MaFhVXzgmhSxI/zHZguKGwqWFX79s7QB9moHODgJ
         hVX6sXvKvzYuxMQWeCCK+GWMbaUxwodprPie+XzlUDKsTMkFIVUGe+mz4yoeDrmG4Hrh
         pWal7WMBLLwfQ6SOn6N9d5OiitQVgLz9uIUQVlEg5kMMEMl1We0YLIolbUO4YGNr8N6F
         xlwic3FxojYa/O6ibkXWt3n8vckzERIznqGilG5wnxTtIbRVLKRQYVke+qDl4R1uPm+/
         ADlg==
X-Forwarded-Encrypted: i=1; AJvYcCWt55OGF3YgDjymL7IACe8hcGNXefB2TRYe/D+a04Xu0dYZ3oCOX32hXa7/TdatzMGKyQo489NET7/I8ObETxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLNNcRWFs54AHc6+MQLyBpOtpjvMWOlC9GlVjfObI1nyjX81S
	5bpShsPO/sl66tCJMr0L1Ms8MAvHnbPlKZ0Wf8NgITdm9q5sAAbijbCtnSdwOWMwBI+BQhzYZnm
	zZZ/L+AariyuuHEnw4Z0ugKP4Ji5Jq2DO45tujiG+w6q7OUJAIbzOQPhYR/E41O66ZSU+Tg==
X-Gm-Gg: ASbGncuKyF6WZFauytEMKjkNoWynRpvYd5S+bJAry32qxXJQPZ2rB0UEIcb9LXyprTf
	KLZV174kJB3VgJdq7C6mMOxluGym4VO1/ECwwjw3icagWOsPv9wLZ4v9uvoR5lKtUP0Y7DZj65f
	JFMWGdidvmmxDoE3NJNYyLRVnRCMHKqRd6t3+Py28YGK/SrTiBl/+gxMoOgQiuuhivC0CDcx3Lg
	FO8kqW6aO69VOI+t17OOUAOlogq5HbekPWU91EXqpWJoPWAMhjhANjfx4EoHPDIaidmtcp0g/kr
	JE/jIg0kT5xki4ViAG0=
X-Received: by 2002:a5d:5846:0:b0:3a3:6ac3:fae2 with SMTP id ffacd0b85a97d-3a36ac3fd1dmr8011203f8f.4.1747742340302;
        Tue, 20 May 2025 04:59:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYfPr30NAX1g8x8Lo/HkiGqx5uMKfUlxTT6/hqjHQ+Vbin1NVN6yBQP3+UXU+zD3oY0eItGQ==
X-Received: by 2002:a5d:5846:0:b0:3a3:6ac3:fae2 with SMTP id ffacd0b85a97d-3a36ac3fd1dmr8011156f8f.4.1747742339775;
        Tue, 20 May 2025 04:58:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710::f39? ([2a0d:3344:244f:5710::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a365bc0b5esm12478708f8f.9.2025.05.20.04.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 04:58:59 -0700 (PDT)
Message-ID: <2454d982-feaf-49b5-8a17-a79c66cba5b6@redhat.com>
Date: Tue, 20 May 2025 13:58:57 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 net-next 2/5] sched: Dump configuration and statistics
 of dualpi2 qdisc
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org,
 donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250516000201.18008-1-chia-yu.chang@nokia-bell-labs.com>
 <20250516000201.18008-3-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250516000201.18008-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/25 2:01 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> The configuration and statistics dump of the DualPI2 Qdisc provides
> information related to both queues, such as packet numbers and queuing
> delays in the L-queue and C-queue, as well as general information such as
> probability value, WRR credits, memory usage, packet marking counters, max
> queue size, etc.
> 
> The following patch includes enqueue/dequeue for DualPI2.
> 
> v16:
> - Update convert_ns_to_usec() to avoid overflow

The changelog should come after the SoB and a '---' separator.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/uapi/linux/pkt_sched.h | 15 ++++++
>  net/sched/sch_dualpi2.c        | 89 ++++++++++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+)
> 
> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
> index ae8af0e8d479..a7243f32ff0f 100644
> --- a/include/uapi/linux/pkt_sched.h
> +++ b/include/uapi/linux/pkt_sched.h
> @@ -1264,4 +1264,19 @@ enum {
>  
>  #define TCA_DUALPI2_MAX   (__TCA_DUALPI2_MAX - 1)
>  
> +struct tc_dualpi2_xstats {
> +	__u32 prob;		/* current probability */
> +	__u32 delay_c;		/* current delay in C queue */
> +	__u32 delay_l;		/* current delay in L queue */
> +	__u32 packets_in_c;	/* number of packets enqueued in C queue */
> +	__u32 packets_in_l;	/* number of packets enqueued in L queue */
> +	__u32 maxq;		/* maximum queue size */
> +	__u32 ecn_mark;		/* packets marked with ecn*/
> +	__u32 step_marks;	/* ECN marks due to the step AQM */
> +	__s32 credit;		/* current c_protection credit */
> +	__u32 memory_used;	/* Memory used of both queues */
> +	__u32 max_memory_used;	/* Maximum used memory */
> +	__u32 memory_limit;	/* Memory limit of both queues */
> +};
> +
>  #endif
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index ffdfb7803e1f..97986c754e47 100644
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -123,6 +123,14 @@ static u32 dualpi2_scale_alpha_beta(u32 param)
>  	return tmp;
>  }
>  
> +static u32 dualpi2_unscale_alpha_beta(u32 param)
> +{
> +	u64 tmp = ((u64)param * NSEC_PER_SEC << ALPHA_BETA_SCALING);
> +
> +	do_div(tmp, MAX_PROB);
> +	return tmp;
> +}
> +
>  static ktime_t next_pi2_timeout(struct dualpi2_sched_data *q)
>  {
>  	return ktime_add_ns(ktime_get_ns(), q->pi2_tupdate);
> @@ -223,6 +231,15 @@ static u32 convert_us_to_nsec(u32 us)
>  		return lower_32_bits(ns);
>  }
>  
> +static u32 convert_ns_to_usec(u64 ns)
> +{
> +	do_div(ns, NSEC_PER_USEC);
> +	if (upper_32_bits(ns))
> +		return 0xffffffff;

U32_MAX

> +	else
> +		return lower_32_bits(ns);
> +}
> +
>  static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
>  {
>  	struct dualpi2_sched_data *q = from_timer(q, timer, pi2_timer);
> @@ -458,6 +475,76 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
>  	return 0;
>  }
>  
> +static int dualpi2_dump(struct Qdisc *sch, struct sk_buff *skb)
> +{
> +	struct dualpi2_sched_data *q = qdisc_priv(sch);
> +	struct nlattr *opts;
> +
> +	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
> +	if (!opts)
> +		goto nla_put_failure;
> +
> +	if (nla_put_u32(skb, TCA_DUALPI2_LIMIT, READ_ONCE(sch->limit)) ||
> +	    nla_put_u32(skb, TCA_DUALPI2_MEMORY_LIMIT,
> +			READ_ONCE(q->memory_limit)) ||
> +	    nla_put_u32(skb, TCA_DUALPI2_TARGET,
> +			convert_ns_to_usec(READ_ONCE(q->pi2_target))) ||
> +	    nla_put_u32(skb, TCA_DUALPI2_TUPDATE,
> +			convert_ns_to_usec(READ_ONCE(q->pi2_tupdate))) ||
> +	    nla_put_u32(skb, TCA_DUALPI2_ALPHA,
> +			dualpi2_unscale_alpha_beta(READ_ONCE(q->pi2_alpha))) ||
> +	    nla_put_u32(skb, TCA_DUALPI2_BETA,
> +			dualpi2_unscale_alpha_beta(READ_ONCE(q->pi2_beta))) ||
> +	    nla_put_u32(skb, TCA_DUALPI2_STEP_THRESH,
> +			READ_ONCE(q->step_in_packets) ?
> +			READ_ONCE(q->step_thresh) :
> +			convert_ns_to_usec(READ_ONCE(q->step_thresh))) ||
> +	    nla_put_u32(skb, TCA_DUALPI2_MIN_QLEN_STEP,
> +			READ_ONCE(q->min_qlen_step)) ||
> +	    nla_put_u8(skb, TCA_DUALPI2_COUPLING,
> +		       READ_ONCE(q->coupling_factor)) ||
> +	    nla_put_u8(skb, TCA_DUALPI2_DROP_OVERLOAD,
> +		       READ_ONCE(q->drop_overload)) ||
> +	    (READ_ONCE(q->step_in_packets) &&
> +	     nla_put_flag(skb, TCA_DUALPI2_STEP_PACKETS)) ||
> +	    nla_put_u8(skb, TCA_DUALPI2_DROP_EARLY,
> +		       READ_ONCE(q->drop_early)) ||
> +	    nla_put_u8(skb, TCA_DUALPI2_C_PROTECTION,
> +		       READ_ONCE(q->c_protection_wc)) ||
> +	    nla_put_u8(skb, TCA_DUALPI2_ECN_MASK, READ_ONCE(q->ecn_mask)) ||
> +	    nla_put_u8(skb, TCA_DUALPI2_SPLIT_GSO, READ_ONCE(q->split_gso)))
> +		goto nla_put_failure;
> +
> +	return nla_nest_end(skb, opts);
> +
> +nla_put_failure:
> +	nla_nest_cancel(skb, opts);
> +	return -1;
> +}
> +
> +static int dualpi2_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
> +{
> +	struct dualpi2_sched_data *q = qdisc_priv(sch);
> +	struct tc_dualpi2_xstats st = {
> +		.prob			= READ_ONCE(q->pi2_prob),
> +		.packets_in_c		= q->packets_in_c,
> +		.packets_in_l		= q->packets_in_l,
> +		.maxq			= q->maxq,
> +		.ecn_mark		= q->ecn_mark,
> +		.credit			= q->c_protection_credit,
> +		.step_marks		= q->step_marks,
> +		.memory_used		= q->memory_used,
> +		.max_memory_used	= q->max_memory_used,
> +		.memory_limit		= q->memory_limit,
> +	};

I *think* you either need READ_ONCE() annotation for the above lockless
read, or add a  sch_tree_lock(sch)/sch_tree_unlock(sch) pair.

/P


