Return-Path: <linux-kselftest+bounces-33070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA86EAB822C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 11:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A26189E356
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 09:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A5228D840;
	Thu, 15 May 2025 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnVWn63R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC0028C2AC
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300340; cv=none; b=eEaFrsLXlDyj4ZR0IBeAsSFV93azmWR6lBXRb2LIHAlhauC4pYEW2ZMaFi9zRGnLIS5a7AymSh8DHYYCYMhHYjp5Tyk7zhTdj50x9GNjUTEL5gdg4yj2GFYnyJByJGZZx0CvJgIhrPKhmhSNmEcFCsDpWgJFCpE+2pIVOBA18Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300340; c=relaxed/simple;
	bh=RA9nLwK6/alawMD5J+NXXSL+zo7g1Cuz4qcEHn5WolY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Oq1l3TuL3xDHinQuizpwc4H9DLvMgqcuXXyDS1XS24/qcgG/M+Cg9zHytiS/nfV4A2wy6X6YxewbF/IwKQhxm/7rSZXMiGCtD9n/LMATiWvZ4QU/NzoNnrDaJP7qKyM3If+fxKdZtukWohYSp7HpyRyNF9IwvyIQgEe5n31DKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnVWn63R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747300337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8KYXv9ogRxM0KU1YvuwgsQGVbUDa4BKsgudT+y/Rbg=;
	b=cnVWn63R1kKCZfiu/gXkS4ozCgtHf8LgZeg4VOK9AHSEnNl/7ygTj3kbmxdGRZXEPULFK3
	gfI4HTpDigCfO39SXGYEahCXe8rpYZfzBAF/4z6S1mn/KcrcOo7eX4lsusW8r2tU27mpcg
	v7+5KEROxfukXwPSBAWOPRluwlLUL6Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-fc0aft2PNKyx0DX2wDhVAg-1; Thu, 15 May 2025 05:12:16 -0400
X-MC-Unique: fc0aft2PNKyx0DX2wDhVAg-1
X-Mimecast-MFC-AGG-ID: fc0aft2PNKyx0DX2wDhVAg_1747300335
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cec217977so4191585e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 02:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747300335; x=1747905135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8KYXv9ogRxM0KU1YvuwgsQGVbUDa4BKsgudT+y/Rbg=;
        b=ijWA6cPALFFJGqJCzZmlVBQnbbPR3cgsNrSqhEcUfWl+Sd25Oa7sD/5q8kpLpH/zBI
         5XQNJb797oYNy/p4TPLkqC7g46CD7znR/9CSyTQIY9J4KuRPTjHBHQZbns9UvHekwad9
         N8BxP2Xp61iBRBlJeXO798+gZD+F0Qz1/4UoXOsKViRfw1XOEuitb3kc8+lghCwrFrtW
         5BRAE1/jzpRKv3c5bX93HVTtAbxyPbLlMrT64J7/KfAEd2vIRB1xS1vezQPwwsmFO5ux
         Ysas6KV26k0PqKlTKyAddOiCXf8C9F2HBGay1x7tAy1F6GT8n6qp6IT+h25OGh4/G0Jq
         t1Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXjqL2Om0s5jm4NexHlbaibQ3ZvwUKS+CwYl3uoDLtjeRUD1jy5ZocRIQCT70Gs06EAJRSwvC5xQTOdH7QwOd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqcHsDAgXV0qEXRVMtrEgK7YVKKbb4/vLbt90CLCL+PYNHZcvN
	70Bn5u9whdw3SAkMPPFTQZbJ1nItF3heabNpyyPbYKX4LN6K2FX1AcoBKeQ0uu07TbWIpWzonAx
	fjKgq5bJmX74dwNhtizQlMUuwz236kO4wPu1GoaFOvhbXSOSOQt1rmKUfrEB25c33gQ==
X-Gm-Gg: ASbGnctiubNSBM/HpnR1TU3nN39tCyhScUntsy3ffbhcMbvHs1KxugaOqyZFuNuztoX
	xRNDq5OgJbZ5BFddF+CGm8amFZ9vDvsZlBhNIHphMknOxGGHSpv0dfv/58bIyNdMO9lzLCIiEFu
	Ao20qC0/OoHHhyIISi2A5iNKVHVPGU5KIaSxZTuSjKAfpixRHyUifR4dczJm5Q6+u+XD/srxp0e
	V3Yvqtq3bIP8SvbFRObeBxEAktye/RDCTy4cIEDvWmvF+XCkM2E06wDXLRKihOoUeZFNdDJIEG/
	vsnJmDxrjIs8FcGyrsLnMLxXoMHitscZM6t4golU7lY47epQT1kBlg1JRfs=
X-Received: by 2002:a05:600c:8289:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-442f96ebbdcmr15921075e9.14.1747300335015;
        Thu, 15 May 2025 02:12:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaCOX8jT6/mMSfs/FjxHZ9iVGZIEpZLEhXsHogKCkLctbgoCgpQLfhvOyRaInQFF1YSoo4ow==
X-Received: by 2002:a05:600c:8289:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-442f96ebbdcmr15920695e9.14.1747300334652;
        Thu, 15 May 2025 02:12:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2440:8010:8dec:ae04:7daa:497f? ([2a0d:3344:2440:8010:8dec:ae04:7daa:497f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3979355sm62726755e9.37.2025.05.15.02.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 02:12:14 -0700 (PDT)
Message-ID: <40b83649-a254-40b4-a8aa-33cc3c7b4157@redhat.com>
Date: Thu, 15 May 2025 11:12:12 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 net-next 2/5] sched: Dump configuration and statistics
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
References: <20250509214801.37306-1-chia-yu.chang@nokia-bell-labs.com>
 <20250509214801.37306-3-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250509214801.37306-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 11:47 PM, chia-yu.chang@nokia-bell-labs.com wrote:
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
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/uapi/linux/pkt_sched.h | 15 ++++++
>  net/sched/sch_dualpi2.c        | 86 ++++++++++++++++++++++++++++++++++
>  2 files changed, 101 insertions(+)
> 
> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
> index f897819b1624..bc248fd49f6f 100644
> --- a/include/uapi/linux/pkt_sched.h
> +++ b/include/uapi/linux/pkt_sched.h
> @@ -1263,4 +1263,19 @@ enum {
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
> index 4bc75c0b3436..81e238b5aaa9 100644
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
> @@ -440,6 +448,82 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
>  	return 0;
>  }
>  
> +static u32 convert_ns_to_usec(u64 ns)
> +{
> +	do_div(ns, NSEC_PER_USEC);
> +	return ns;
> +}
> +
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
> +	u64 qc, ql;
> +
> +	get_queue_delays(q, &qc, &ql);
> +	st.delay_l = convert_ns_to_usec(ql);
> +	st.delay_c = convert_ns_to_usec(qc);

Both delay_l and delay_c are u32. AFAICS, on pathological situations
both could overrun.

/P


