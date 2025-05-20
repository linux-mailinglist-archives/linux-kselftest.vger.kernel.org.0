Return-Path: <linux-kselftest+bounces-33396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80F7ABD756
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 13:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B55D4A299C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 11:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9B32673B5;
	Tue, 20 May 2025 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsJqa5pG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDF114F9FB
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741712; cv=none; b=nWkLiQ6/ACSTzLZ6uaWB9FkrTrkPWZYxn2l0myQS10R34of67u+7Y/+9uj7gKSFmqsxD1+EXOkny+poW1hHpGiPF0nhvB/z/DTMiUgT5kfDreKwIRcdnD4CB+rfK49LkEgFQzd10YMceT0nX38/W+jjuUshofnQGt+3nlswM1Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741712; c=relaxed/simple;
	bh=rQ9nuQ96Iibk24HlloVC1HIIF9nw6Z88jPXRCvT7ocU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oPYrvqh/RO3jnrpFGccYJlAYNu19NUg3S1VnTG941i/xx4OYdDyEMPg65ZBShPNlab2w3wAH7p5dULltE5dDek3FknmVCwskQQNaXrIj9GE8tmZe70A3u89GSvX9xLTm8/YAWYkIoNI2wvbm2LzJLqlKdxwnAeWz1rgtr1JucYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsJqa5pG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747741709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jXOr/YGgLdkSLnG0lGNZrIL8GJmfF7oYFFM4NepCMWg=;
	b=EsJqa5pGLmUlJPzk5XfQ3U5Zz/0bEmr2WVGlWVqTRDB8kGp1EZJIj7FG/wm7sNDOhHxa+d
	GaWSdRtLOMM+xEoNYA41yZXUoqw3ZG8OaI160WSikVkmNcAihdTvj5o/x0g2A9oNKf8lFy
	KrYDSmVjDxSLL+k7kww+L/g44IW7MaY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-bigI8_j-Mjq02nOvQ5nKUw-1; Tue, 20 May 2025 07:48:28 -0400
X-MC-Unique: bigI8_j-Mjq02nOvQ5nKUw-1
X-Mimecast-MFC-AGG-ID: bigI8_j-Mjq02nOvQ5nKUw_1747741707
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-445135eb689so17488085e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 04:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747741707; x=1748346507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXOr/YGgLdkSLnG0lGNZrIL8GJmfF7oYFFM4NepCMWg=;
        b=hVJVoeyKcfbV/X5AS0GzRXywmV4CZAksDBQ6fWJiMGJ0o4VKZWte8rem7mfcpXQbXA
         p5W883URNmkGoqo9rBxuElwliLAp4rHJhWoXDzeGAJtaC8duPP2is6Tz9IG41oH6zKuB
         gjfPXXJu3Zi0g4AAl6CJg95BRqLf1eSqMS8wi+w/3qVqkewAVWd6dX6oAmf0jTy0r981
         2D1yhOAo69SkWq8s7tPWWNbjVpEh3rJX58pc5PSrMtdH0IfDpPrB+7d4Q+9xr0StI1rJ
         JZ6BsqYfRm1zZ4gY6sO6xNpfQAylDTFiHGXIsXBwj2uBIOYDxbwe9TfmFpPbmAD0kxL+
         w9rg==
X-Forwarded-Encrypted: i=1; AJvYcCVWNEDAc4SIBjEFYJse+WCxIw2BS0bmiB516L1bVU//jcure/hGAua8ovjABpuYHRcCkHXOd2tsaf6bGBGDEQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV4rZU9mFjZROKRgy98G/M55SwFQCt02iu+YDOuqAYFVTW63ax
	kLvAAwsZWqsYKZTNvGJdCNZ/tpGK72XSwfV57vLLQwUAYX/KXKw38gqYFz8/c5dW0HojZNLlgZQ
	kou9OeSrE8F4SYVX9pLx9TCEWwvadiuE5fJlSI5wesJa/sjXrqX7RhOWyrEpdc7YtxBVh8A==
X-Gm-Gg: ASbGncuB86++hoL7/hp8V4TYxAUOPBXvM2VidyIf/g5Wv3ji8ZzBMh3HBQ1MFMwE8vT
	v1x+q/L3obx2k/DFS0OLpoGsxNCeokcPJdBRQ5Q/7Xn1nxhItXeDlGUKSW3M4oN8lsUg1TAK10x
	UI9nVe8CkFHnk4RPDoWMGigatvuPgt1LdIDjmcvvLxrbz0iNIiNtBDjGz0lMcNGSZrj2RLAQEI3
	9r+dxGgJUddpguOxkHmuGIUAZtHp1Na2YZcaMAEg7IHGMKJq4ZlaZqChnaubv3vYxo4Tb04Zn6Y
	1wQK898zvLZxek8e1JU=
X-Received: by 2002:a05:600c:3114:b0:43c:fa24:8721 with SMTP id 5b1f17b1804b1-442fd6445bdmr168066015e9.17.1747741707141;
        Tue, 20 May 2025 04:48:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnOjEw44gC4sY9CJQhd2ildDF8FCvRzA2nnAw5uM1/xzK/4E023+uiNX8t5NUMMfWBhbl/Yg==
X-Received: by 2002:a05:600c:3114:b0:43c:fa24:8721 with SMTP id 5b1f17b1804b1-442fd6445bdmr168065655e9.17.1747741706704;
        Tue, 20 May 2025 04:48:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710::f39? ([2a0d:3344:244f:5710::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb56sm27251695e9.27.2025.05.20.04.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 04:48:26 -0700 (PDT)
Message-ID: <468e63af-7049-4c1e-a64d-fdbfa2b45855@redhat.com>
Date: Tue, 20 May 2025 13:48:23 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 net-next 1/5] sched: Struct definition and parsing of
 dualpi2 qdisc
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
 <20250516000201.18008-2-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250516000201.18008-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/25 2:01 AM, chia-yu.chang@nokia-bell-labs.com wrote:
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
> +	delta = ((s64)qdelay - q->pi2_target) * q->pi2_alpha;
> +	delta += ((s64)qdelay - q->last_qdelay) * q->pi2_beta;

The abov code is confusing. What do you intend to obtain with the
explicit cast? the '+' left operand will be converted implicitly to
unsigned as C integer implicit conversion rules.

> +	if (delta > 0) {
> +		new_prob = __scale_delta(delta) + q->pi2_prob;
> +		if (new_prob < q->pi2_prob)
> +			new_prob = MAX_PROB;
> +	} else {
> +		new_prob = q->pi2_prob - __scale_delta(~delta + 1);
> +		if (new_prob > q->pi2_prob)
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
> +static u32 get_memory_limit(struct Qdisc *sch, u32 limit)
> +{
> +	/* Apply rule of thumb, i.e., doubling the packet length,
> +	 * to further include per packet overhead in memory_limit.
> +	 */
> +	u64 memlim = mul_u32_u32(limit, 2 * psched_mtu(qdisc_dev(sch)));
> +
> +	if (upper_32_bits(memlim))
> +		return 0xffffffff;

Pleas use U32_MAX.

[...]
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

As per commit 2d3cbfd6d54a2c39ce3244f33f85c595844bd7b8, the above should be:

		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);

/P


