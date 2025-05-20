Return-Path: <linux-kselftest+bounces-33403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97442ABD999
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 15:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568E2171F05
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B06245019;
	Tue, 20 May 2025 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EN+AJMA2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451EC244666
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748048; cv=none; b=GLF7Yfgonr0JFTrGBccPzj76KOISzhfiNNBPcUPKrw8xuYG6BrjmYxEpNR4HTrt9KB2UR5wRn0CPVEnZEQZx6GUEF7mfjAaEtMhepvGiEJgszcZPTUll5rU7mCoj+hn8aJKeNvUbAbwJ9CDafpMZ7yB9EXiE/IjY+M+YMJmXUc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748048; c=relaxed/simple;
	bh=kGsoRZoR1371c7S0L+pPmRmiIGpsZ3niGp6ljGzI8UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaKH7419vAe7DuR0+XsNLRDlwnqFEcRvF3a26oxFm9SZCYSFZyyTAF9eX86e2t+5f0TEu9YpMkjlV21rudowmWkmlAYIrlDPlid7Ek7V4/ZyopHeL76k3ToW/ITbkP93bkJPC0k5GiAIsZAQida3aKk1Z+WVJctZhXgsqlMZ6Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EN+AJMA2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747748044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cp+QI/FUEokdJfJNPH+W6NcsfuPlYnlplF6CXE3JP8A=;
	b=EN+AJMA2pr2QDAExOUwgUxWXU9d8HbvTTSEgqWeiWqYGE1Y3yHBVhh7j33q9DdyGS2MxdJ
	HBzACeZQmp3CZoQLSWig3iSZXdNRV+ZqzalAeQ9Vxzdo/KblkmNbazH9W01nld2uwBiGAb
	yc1TtUkv/N+ldszpwWOHZdxTml0CDyU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-PyH2b7jIPk-F2yZ7JiKCFw-1; Tue, 20 May 2025 09:34:03 -0400
X-MC-Unique: PyH2b7jIPk-F2yZ7JiKCFw-1
X-Mimecast-MFC-AGG-ID: PyH2b7jIPk-F2yZ7JiKCFw_1747748042
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a35bf8377fso3765916f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 06:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747748042; x=1748352842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cp+QI/FUEokdJfJNPH+W6NcsfuPlYnlplF6CXE3JP8A=;
        b=jXgNRQUJYwU2ukGSnfJlD3iOJ7khttwxMyrp27JKjZJX3S0jJlq6aclqGDqSZYpgqa
         dpOk6FYioYXy8nqL79tOUl1VP4VMgE9Pc3wo6Bji2e9f8ER5yj+H3q8vZu+2hz/WZSMM
         IL+GyZw9AYmq1QNcalHi5dBO4Pc5kZbT5OtW7axI/MmDOECN/9vqEYzy8b4VZdoK72Fk
         BbgeiYAP2hZyglZKhznoIc9cSyswN2yauLGha/dC5Ii0x++DhENkYzqVUCbHLeQ7xmUr
         xeZ0gjkZoNltpQ/mt9qzll8rqegBFNZKutarENrrlGS4M2EHYAdls2gWwiH5+EwslQIQ
         6aCw==
X-Forwarded-Encrypted: i=1; AJvYcCXh4jSo9D5A1RRNLIsAF8B8LPmHoIX8IjJWbTUrOrKtn1I8Gqt93Dky1ROT2zAU1lAoBSOiry+sBDbrnDjC6VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylSsdRHxP6tWWn1epmuXL79jxVi0MKgHytTaNpatRPTEPDRVgd
	oTYiIKl4XXjzCHdX6Wrx9oZLRKTJrq9dsAMXbeyqz/zwvVHT/rBU3wAJLReFItwckFSIr/TzBF8
	LCJdxUjQI2HyFxfZQnR32Gxq6YgZBHa11oXiLnkxZqf9lfxSkXuk7wIaxCgZNt2nNMcWegw==
X-Gm-Gg: ASbGncuSMXI6177MhDHKRPA7cbTq1joRkSkP5LQpoY0YcPU6BVUmeynTOjBaWHC2GmD
	ch6E/M+j1HgVKkDtloLf2qP6rKV1XAv5GmX/MKiRVVM5cR4bAUpYvPr/JRH+BDrnTtTBQ5eUPgN
	ENZCOS5gETL9j+XixgkHqxpuBWPkYk9+VYh3t3poDjmf+X7Ad2Kh+e0W+IUzX9zxXkR8oRNs++q
	GK6/SL0N3zPONvOQCFTO4824TX/2WEwf6QQ7frgl1C079NuQg1Oy1LF1li44aNK21R4QzdnVgVb
	XyEApck6J5dXrMfc0vQ=
X-Received: by 2002:a05:6000:4284:b0:3a2:244:67a4 with SMTP id ffacd0b85a97d-3a35ffd2acbmr13405826f8f.43.1747748041817;
        Tue, 20 May 2025 06:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVf3XBSnIKCynv8heDnjUZQ/zUTTrHNAVITFYhp+CZTZ0R5JgwQKvUtIy1raSS5ZBNR1LIiw==
X-Received: by 2002:a05:6000:4284:b0:3a2:244:67a4 with SMTP id ffacd0b85a97d-3a35ffd2acbmr13405778f8f.43.1747748041198;
        Tue, 20 May 2025 06:34:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710::f39? ([2a0d:3344:244f:5710::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a361a81fd8sm15228410f8f.81.2025.05.20.06.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 06:34:00 -0700 (PDT)
Message-ID: <8eae6bfd-c641-4fd4-9642-7fc038a974a2@redhat.com>
Date: Tue, 20 May 2025 15:33:58 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 net-next 3/5] sched: Add enqueue/dequeue of dualpi2
 qdisc
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
Cc: Olga Albisser <olga@albisser.org>,
 Olivier Tilmans <olivier.tilmans@nokia.com>,
 Henrik Steen <henrist@henrist.net>, Bob Briscoe <research@bobbriscoe.net>
References: <20250516000201.18008-1-chia-yu.chang@nokia-bell-labs.com>
 <20250516000201.18008-4-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250516000201.18008-4-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/16/25 2:01 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> 
> DualPI2 provides L4S-type low latency & loss to traffic that uses a
> scalable congestion controller (e.g. TCP-Prague, DCTCP) without
> degrading the performance of 'classic' traffic (e.g. Reno,
> Cubic etc.). It is to be the reference implementation of IETF RFC9332
> DualQ Coupled AQM (https://datatracker.ietf.org/doc/html/rfc9332).
> 
> Note that creating two independent queues cannot meet the goal of
> DualPI2 mentioned in RFC9332: "...to preserve fairness between
> ECN-capable and non-ECN-capable traffic." Further, it could even
> lead to starvation of Classic traffic, which is also inconsistent
> with the requirements in RFC9332: "...although priority MUST be
> bounded in order not to starve Classic traffic." DualPI2 is
> designed to maintain approximate per-flow fairness on L-queue and
> C-queue by forming a single qdisc using the coupling factor and
> scheduler between two queues.
> 
> The qdisc provides two queues called low latency and classic. It
> classifies packets based on the ECN field in the IP headers. By
> default it directs non-ECN and ECT(0) into the classic queue and
> ECT(1) and CE into the low latency queue, as per the IETF spec.
> 
> Each queue runs its own AQM:
> * The classic AQM is called PI2, which is similar to the PIE AQM but
>   more responsive and simpler. Classic traffic requires a decent
>   target queue (default 15ms for Internet deployment) to fully
>   utilize the link and to avoid high drop rates.
> * The low latency AQM is, by default, a very shallow ECN marking
>   threshold (1ms) similar to that used for DCTCP.
> 
> The DualQ isolates the low queuing delay of the Low Latency queue
> from the larger delay of the 'Classic' queue. However, from a
> bandwidth perspective, flows in either queue will share out the link
> capacity as if there was just a single queue. This bandwidth pooling
> effect is achieved by coupling together the drop and ECN-marking
> probabilities of the two AQMs.
> 
> The PI2 AQM has two main parameters in addition to its target delay.
> The integral gain factor alpha is used to slowly correct any persistent
> standing queue error from the target delay, while the proportional gain
> factor beta is used to quickly compensate for queue changes (growth or
> shrinkage). Either alpha and beta are given as a parameter, or they can
> be calculated by tc from alternative typical and maximum RTT parameters.
> 
> Internally, the output of a linear Proportional Integral (PI)
> controller is used for both queues. This output is squared to
> calculate the drop or ECN-marking probability of the classic queue.
> This counterbalances the square-root rate equation of Reno/Cubic,
> which is the trick that balances flow rates across the queues. For
> the ECN-marking probability of the low latency queue, the output of
> the base AQM is multiplied by a coupling factor. This determines the
> balance between the flow rates in each queue. The default setting
> makes the flow rates roughly equal, which should be generally
> applicable.
> 
> If DUALPI2 AQM has detected overload (due to excessive non-responsive
> traffic in either queue), it will switch to signaling congestion
> solely using drop, irrespective of the ECN field. Alternatively, it
> can be configured to limit the drop probability and let the queue
> grow and eventually overflow (like tail-drop).
> 
> GSO splitting in DUALPI2 is configurable from userspace while the
> default behavior is to split gso. When running DUALPI2 at unshaped
> 10gigE with 4 download streams test, splitting gso apart results in
> halving the latency with no loss in throughput:
> 
> Summary of tcp_4down run 'no_split_gso':
>                          avg         median      # data pts
>  Ping (ms) ICMP   :       0.53      0.30 ms         350
>  TCP download avg :    2326.86       N/A Mbits/s    350
>  TCP download sum :    9307.42       N/A Mbits/s    350
>  TCP download::1  :    2672.99   2568.73 Mbits/s    350
>  TCP download::2  :    2586.96   2570.51 Mbits/s    350
>  TCP download::3  :    1786.26   1798.82 Mbits/s    350
>  TCP download::4  :    2261.21   2309.49 Mbits/s    350
> 
> Summart of tcp_4down run 'split_gso':
>                          avg          median      # data pts
>  Ping (ms) ICMP   :       0.22      0.23 ms         350
>  TCP download avg :    2335.02       N/A Mbits/s    350
>  TCP download sum :    9340.09       N/A Mbits/s    350
>  TCP download::1  :    2335.30   2334.22 Mbits/s    350
>  TCP download::2  :    2334.72   2334.20 Mbits/s    350
>  TCP download::3  :    2335.28   2334.58 Mbits/s    350
>  TCP download::4  :    2334.79   2334.39 Mbits/s    350
> 
> A similar result is observed when running DUALPI2 at unshaped 1gigE
> with 1 download stream test:
> 
> Summary of tcp_1down run 'no_split_gso':
>                          avg         median      # data pts
>  Ping (ms) ICMP :         1.13      1.25 ms         350
>  TCP download   :       941.41    941.46 Mbits/s    350
> 
> Summart of tcp_1down run 'split_gso':
>                          avg         median      # data pts
>  Ping (ms) ICMP :         0.51      0.55 ms         350
>  TCP download   :       941.41    941.45 Mbits/s    350
> 
> Additional details can be found in the draft:
>   https://datatracker.ietf.org/doc/html/rfc9332
> 
> Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> Co-developed-by: Olga Albisser <olga@albisser.org>
> Signed-off-by: Olga Albisser <olga@albisser.org>
> Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Co-developed-by: Henrik Steen <henrist@henrist.net>
> Signed-off-by: Henrik Steen <henrist@henrist.net>
> Signed-off-by: Bob Briscoe <research@bobbriscoe.net>
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Dave Taht <dave.taht@gmail.com>
> ---
>  include/net/dropreason-core.h |   6 +
>  net/sched/Kconfig             |  12 +
>  net/sched/Makefile            |   1 +
>  net/sched/sch_dualpi2.c       | 449 ++++++++++++++++++++++++++++++++++
>  4 files changed, 468 insertions(+)
> 
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index bea77934a235..faae9f416e54 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -120,6 +120,7 @@
>  	FN(ARP_PVLAN_DISABLE)		\
>  	FN(MAC_IEEE_MAC_CONTROL)	\
>  	FN(BRIDGE_INGRESS_STP_STATE)	\
> +	FN(DUALPI2_STEP_DROP)		\
>  	FNe(MAX)
>  
>  /**
> @@ -570,6 +571,11 @@ enum skb_drop_reason {
>  	 * ingress bridge port does not allow frames to be forwarded.
>  	 */
>  	SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE,
> +	/**
> +	 * @SKB_DROP_REASON_DUALPI2_STEP_DROP: dropped by the step drop
> +	 * threshold of DualPI2 qdisc.
> +	 */
> +	SKB_DROP_REASON_DUALPI2_STEP_DROP,
>  	/**
>  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>  	 * shouldn't be used as a real 'reason' - only for tracing code gen
> diff --git a/net/sched/Kconfig b/net/sched/Kconfig
> index 9f0b3f943fca..dda66a3590d8 100644
> --- a/net/sched/Kconfig
> +++ b/net/sched/Kconfig
> @@ -415,6 +415,18 @@ config NET_SCH_BPF
>  
>  	  If unsure, say N.
>  
> +config NET_SCH_DUALPI2
> +	tristate "Dual Queue PI Square (DUALPI2) scheduler"
> +	help
> +	  Say Y here if you want to use the Dual Queue Proportional Integral
> +	  Controller Improved with a Square scheduling algorithm.
> +	  For more information, please see https://tools.ietf.org/html/rfc9332
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called sch_dualpi2.
> +
> +	  If unsure, say N.
> +
>  menuconfig NET_SCH_DEFAULT
>  	bool "Allow override default queue discipline"
>  	help
> diff --git a/net/sched/Makefile b/net/sched/Makefile
> index 904d784902d1..5078ea84e6ad 100644
> --- a/net/sched/Makefile
> +++ b/net/sched/Makefile
> @@ -63,6 +63,7 @@ obj-$(CONFIG_NET_SCH_CBS)	+= sch_cbs.o
>  obj-$(CONFIG_NET_SCH_ETF)	+= sch_etf.o
>  obj-$(CONFIG_NET_SCH_TAPRIO)	+= sch_taprio.o
>  obj-$(CONFIG_NET_SCH_BPF)	+= bpf_qdisc.o
> +obj-$(CONFIG_NET_SCH_DUALPI2)	+= sch_dualpi2.o
>  
>  obj-$(CONFIG_NET_CLS_U32)	+= cls_u32.o
>  obj-$(CONFIG_NET_CLS_ROUTE4)	+= cls_route.o
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index 97986c754e47..7ecd7502332c 100644
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -113,8 +113,44 @@ struct dualpi2_sched_data {
>  	u32	step_marks;	/* ECN mark pkt counter due to step AQM */
>  	u32	memory_used;	/* Memory used of both queues */
>  	u32	max_memory_used;/* Maximum used memory */
> +
> +	/* Deferred drop statistics */
> +	u32	deferred_drops_cnt;	/* Packets dropped */
> +	u32	deferred_drops_len;	/* Bytes dropped */
> +};
> +
> +struct dualpi2_skb_cb {
> +	u64 ts;			/* Timestamp at enqueue */
> +	u8 apply_step:1,	/* Can we apply the step threshold */
> +	   classified:2,	/* Packet classification results */
> +	   ect:2;		/* Packet ECT codepoint */
> +};
> +
> +enum dualpi2_classification_results {
> +	DUALPI2_C_CLASSIC	= 0,	/* C-queue */
> +	DUALPI2_C_L4S		= 1,	/* L-queue (scale mark/classic drop) */
> +	DUALPI2_C_LLLL		= 2,	/* L-queue (no drops/marks) */
> +	__DUALPI2_C_MAX			/* Keep last*/
>  };
>  
> +static struct dualpi2_skb_cb *dualpi2_skb_cb(struct sk_buff *skb)
> +{
> +	qdisc_cb_private_validate(skb, sizeof(struct dualpi2_skb_cb));
> +	return (struct dualpi2_skb_cb *)qdisc_skb_cb(skb)->data;
> +}
> +
> +static u64 dualpi2_sojourn_time(struct sk_buff *skb, u64 reference)
> +{
> +	return reference - dualpi2_skb_cb(skb)->ts;
> +}
> +
> +static u64 head_enqueue_time(struct Qdisc *q)
> +{
> +	struct sk_buff *skb = qdisc_peek_head(q);
> +
> +	return skb ? dualpi2_skb_cb(skb)->ts : 0;
> +}
> +
>  static u32 dualpi2_scale_alpha_beta(u32 param)
>  {
>  	u64 tmp = ((u64)param * MAX_PROB >> ALPHA_BETA_SCALING);
> @@ -136,6 +172,25 @@ static ktime_t next_pi2_timeout(struct dualpi2_sched_data *q)
>  	return ktime_add_ns(ktime_get_ns(), q->pi2_tupdate);
>  }
>  
> +static bool skb_is_l4s(struct sk_buff *skb)
> +{
> +	return dualpi2_skb_cb(skb)->classified == DUALPI2_C_L4S;
> +}
> +
> +static bool skb_in_l_queue(struct sk_buff *skb)
> +{
> +	return dualpi2_skb_cb(skb)->classified != DUALPI2_C_CLASSIC;
> +}
> +
> +static bool dualpi2_mark(struct dualpi2_sched_data *q, struct sk_buff *skb)
> +{
> +	if (INET_ECN_set_ce(skb)) {
> +		q->ecn_mark++;
> +		return true;
> +	}
> +	return false;
> +}
> +
>  static void dualpi2_reset_c_protection(struct dualpi2_sched_data *q)
>  {
>  	q->c_protection_credit = q->c_protection_init;
> @@ -155,6 +210,398 @@ static void dualpi2_calculate_c_protection(struct Qdisc *sch,
>  	dualpi2_reset_c_protection(q);
>  }
>  
> +static bool dualpi2_roll(u32 prob)
> +{
> +	return get_random_u32() <= prob;
> +}
> +
> +/* Packets in the C-queue are subject to a marking probability pC, which is the
> + * square of the internal PI probability (i.e., have an overall lower mark/drop
> + * probability). If the qdisc is overloaded, ignore ECT values and only drop.
> + *
> + * Note that this marking scheme is also applied to L4S packets during overload.
> + * Return true if packet dropping is required in C queue
> + */
> +static bool dualpi2_classic_marking(struct dualpi2_sched_data *q,
> +				    struct sk_buff *skb, u32 prob,
> +				    bool overload)
> +{
> +	if (dualpi2_roll(prob) && dualpi2_roll(prob)) {
> +		if (overload || dualpi2_skb_cb(skb)->ect == INET_ECN_NOT_ECT)
> +			return true;
> +		dualpi2_mark(q, skb);
> +	}
> +	return false;
> +}
> +
> +/* Packets in the L-queue are subject to a marking probability pL given by the
> + * internal PI probability scaled by the coupling factor.
> + *
> + * On overload (i.e., @local_l_prob is >= 100%):
> + * - if the qdisc is configured to trade losses to preserve latency (i.e.,
> + *   @q->drop_overload), apply classic drops first before marking.
> + * - otherwise, preserve the "no loss" property of ECN at the cost of queueing
> + *   delay, eventually resulting in taildrop behavior once sch->limit is
> + *   reached.
> + * Return true if packet dropping is required in L queue
> + */
> +static bool dualpi2_scalable_marking(struct dualpi2_sched_data *q,
> +				     struct sk_buff *skb,
> +				     u64 local_l_prob, u32 prob,
> +				     bool overload)
> +{
> +	if (overload) {
> +		/* Apply classic drop */
> +		if (!q->drop_overload ||
> +		    !(dualpi2_roll(prob) && dualpi2_roll(prob)))
> +			goto mark;
> +		return true;
> +	}
> +
> +	/* We can safely cut the upper 32b as overload==false */
> +	if (dualpi2_roll(local_l_prob)) {
> +		/* Non-ECT packets could have classified as L4S by filters. */
> +		if (dualpi2_skb_cb(skb)->ect == INET_ECN_NOT_ECT)
> +			return true;
> +mark:
> +		dualpi2_mark(q, skb);
> +	}
> +	return false;
> +}
> +
> +/* Decide whether a given packet must be dropped (or marked if ECT), according
> + * to the PI2 probability.
> + *
> + * Never mark/drop if we have a standing queue of less than 2 MTUs.
> + */
> +static bool must_drop(struct Qdisc *sch, struct dualpi2_sched_data *q,
> +		      struct sk_buff *skb)
> +{
> +	u64 local_l_prob;
> +	bool overload;
> +	u32 prob;
> +
> +	if (sch->qstats.backlog < 2 * psched_mtu(qdisc_dev(sch)))
> +		return false;
> +
> +	prob = READ_ONCE(q->pi2_prob);
> +	local_l_prob = (u64)prob * q->coupling_factor;
> +	overload = local_l_prob > MAX_PROB;
> +
> +	switch (dualpi2_skb_cb(skb)->classified) {
> +	case DUALPI2_C_CLASSIC:
> +		return dualpi2_classic_marking(q, skb, prob, overload);
> +	case DUALPI2_C_L4S:
> +		return dualpi2_scalable_marking(q, skb, local_l_prob, prob,
> +						overload);
> +	default: /* DUALPI2_C_LLLL */
> +		return false;
> +	}
> +}
> +
> +static void dualpi2_read_ect(struct sk_buff *skb)
> +{
> +	struct dualpi2_skb_cb *cb = dualpi2_skb_cb(skb);
> +	int wlen = skb_network_offset(skb);
> +
> +	switch (skb_protocol(skb, true)) {
> +	case htons(ETH_P_IP):
> +		wlen += sizeof(struct iphdr);
> +		if (!pskb_may_pull(skb, wlen) ||
> +		    skb_try_make_writable(skb, wlen))
> +			goto not_ecn;
> +
> +		cb->ect = ipv4_get_dsfield(ip_hdr(skb)) & INET_ECN_MASK;
> +		break;
> +	case htons(ETH_P_IPV6):
> +		wlen += sizeof(struct ipv6hdr);
> +		if (!pskb_may_pull(skb, wlen) ||
> +		    skb_try_make_writable(skb, wlen))
> +			goto not_ecn;
> +
> +		cb->ect = ipv6_get_dsfield(ipv6_hdr(skb)) & INET_ECN_MASK;
> +		break;
> +	default:
> +		goto not_ecn;
> +	}
> +	return;
> +
> +not_ecn:
> +	/* Non pullable/writable packets can only be dropped hence are
> +	 * classified as not ECT.
> +	 */
> +	cb->ect = INET_ECN_NOT_ECT;
> +}
> +
> +static int dualpi2_skb_classify(struct dualpi2_sched_data *q,
> +				struct sk_buff *skb)
> +{
> +	struct dualpi2_skb_cb *cb = dualpi2_skb_cb(skb);
> +	struct tcf_result res;
> +	struct tcf_proto *fl;
> +	int result;
> +
> +	dualpi2_read_ect(skb);
> +	if (cb->ect & q->ecn_mask) {
> +		cb->classified = DUALPI2_C_L4S;
> +		return NET_XMIT_SUCCESS;
> +	}
> +
> +	if (TC_H_MAJ(skb->priority) == q->sch->handle &&
> +	    TC_H_MIN(skb->priority) < __DUALPI2_C_MAX) {
> +		cb->classified = TC_H_MIN(skb->priority);
> +		return NET_XMIT_SUCCESS;
> +	}
> +
> +	fl = rcu_dereference_bh(q->tcf_filters);
> +	if (!fl) {
> +		cb->classified = DUALPI2_C_CLASSIC;
> +		return NET_XMIT_SUCCESS;
> +	}
> +
> +	result = tcf_classify(skb, NULL, fl, &res, false);
> +	if (result >= 0) {
> +#ifdef CONFIG_NET_CLS_ACT
> +		switch (result) {
> +		case TC_ACT_STOLEN:
> +		case TC_ACT_QUEUED:
> +		case TC_ACT_TRAP:
> +			return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
> +		case TC_ACT_SHOT:
> +			return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> +		}
> +#endif
> +		cb->classified = TC_H_MIN(res.classid) < __DUALPI2_C_MAX ?
> +			TC_H_MIN(res.classid) : DUALPI2_C_CLASSIC;
> +	}
> +	return NET_XMIT_SUCCESS;
> +}
> +
> +static int dualpi2_enqueue_skb(struct sk_buff *skb, struct Qdisc *sch,
> +			       struct sk_buff **to_free)
> +{
> +	struct dualpi2_sched_data *q = qdisc_priv(sch);
> +	struct dualpi2_skb_cb *cb;
> +
> +	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
> +	    unlikely((u64)q->memory_used + skb->truesize > q->memory_limit)) {
> +		qdisc_qstats_overlimit(sch);
> +		if (skb_in_l_queue(skb))
> +			qdisc_qstats_overlimit(q->l_queue);
> +		return qdisc_drop_reason(skb, sch, to_free,
> +					 SKB_DROP_REASON_QDISC_OVERLIMIT);
> +	}
> +
> +	if (q->drop_early && must_drop(sch, q, skb)) {
> +		qdisc_drop_reason(skb, sch, to_free,
> +				  SKB_DROP_REASON_QDISC_OVERLIMIT);

I think it's better to use a different drop reason here or it will be
hard to distinguish between packets dropped here or above.
Possibly SKB_DROP_REASON_QDISC_CONGESTED.

> +		return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> +	}
> +
> +	cb = dualpi2_skb_cb(skb);
> +	cb->ts = ktime_get_ns();
> +	q->memory_used += skb->truesize;
> +	if (q->memory_used > q->max_memory_used)
> +		q->max_memory_used = q->memory_used;
> +
> +	if (qdisc_qlen(sch) > q->maxq)
> +		q->maxq = qdisc_qlen(sch);
> +
> +	if (skb_in_l_queue(skb)) {
> +		/* Only apply the step if a queue is building up */
> +		dualpi2_skb_cb(skb)->apply_step = skb_is_l4s(skb) &&
> +			qdisc_qlen(q->l_queue) >= q->min_qlen_step;
> +		/* Keep the overall qdisc stats consistent */
> +		++sch->q.qlen;
> +		qdisc_qstats_backlog_inc(sch, skb);
> +		++q->packets_in_l;
> +		if (!q->l_head_ts)
> +			q->l_head_ts = cb->ts;

This chunck is very hard to read. Please insert a black line before the
2nd comment and consider introducing an helper to compute the
'apply_step' value.

> +		return qdisc_enqueue_tail(skb, q->l_queue);
> +	}
> +	++q->packets_in_c;
> +	if (!q->c_head_ts)
> +		q->c_head_ts = cb->ts;
> +	return qdisc_enqueue_tail(skb, sch);
> +}
> +
> +/* By default, dualpi2 will split GSO skbs into independent skbs and enqueue
> + * each of those individually. This yields the following benefits, at the
> + * expense of CPU usage:
> + * - Finer-grained AQM actions as the sub-packets of a burst no longer share the
> + *   same fate (e.g., the random mark/drop probability is applied individually)
> + * - Improved precision of the starvation protection/WRR scheduler at dequeue,
> + *   as the size of the dequeued packets will be smaller.
> + */
> +static int dualpi2_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
> +				 struct sk_buff **to_free)
> +{
> +	struct dualpi2_sched_data *q = qdisc_priv(sch);
> +	int err;
> +
> +	err = dualpi2_skb_classify(q, skb);
> +	if (err != NET_XMIT_SUCCESS) {
> +		if (err & __NET_XMIT_BYPASS)
> +			qdisc_qstats_drop(sch);
> +		__qdisc_drop(skb, to_free);
> +		return err;
> +	}
> +
> +	if (q->split_gso && skb_is_gso(skb)) {
> +		netdev_features_t features;
> +		struct sk_buff *nskb, *next;
> +		int cnt, byte_len, orig_len;
> +		int err;
> +
> +		features = netif_skb_features(skb);
> +		nskb = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
> +		if (IS_ERR_OR_NULL(nskb))
> +			return qdisc_drop(skb, sch, to_free);
> +
> +		cnt = 1;
> +		byte_len = 0;
> +		orig_len = qdisc_pkt_len(skb);
> +		skb_list_walk_safe(nskb, nskb, next) {
> +			skb_mark_not_on_list(nskb);
> +			qdisc_skb_cb(nskb)->pkt_len = nskb->len;
> +			dualpi2_skb_cb(nskb)->classified =
> +				dualpi2_skb_cb(skb)->classified;

Possibly just:
			*qdisc_skb_cb(nskb) = *dualpi2_skb_cb(skb);

> +			dualpi2_skb_cb(nskb)->ect = dualpi2_skb_cb(skb)->ect;
> +			err = dualpi2_enqueue_skb(nskb, sch, to_free);
> +			if (err == NET_XMIT_SUCCESS) {
> +				/* Compute the backlog adjustment that needs
> +				 * to be propagated in the qdisc tree to reflect
> +				 * all new skbs successfully enqueued.
> +				 */
> +				++cnt;
> +				byte_len += nskb->len;
> +			}
> +		}
> +		if (err == NET_XMIT_SUCCESS) {
> +			/* The caller will add the original skb stats to its
> +			 * backlog, compensate this.
> +			 */
> +			--cnt;
> +			byte_len -= orig_len;
> +		}
> +		qdisc_tree_reduce_backlog(sch, -cnt, -byte_len);
> +		consume_skb(skb);
> +		return err;

Using the return value from the last enqueue operation is IMHO
inaccurate and confusing. Instead you could return NET_XMIT_SUCCESS if
at least a skb is enqueued successfully, or possibly always
unconditionally NET_XMIT_SUCCESS (will simplify the code a bit)

> +	}
> +	return dualpi2_enqueue_skb(skb, sch, to_free);
> +}
> +
> +/* Select the queue from which the next packet can be dequeued, ensuring that
> + * neither queue can starve the other with a WRR scheduler.
> + *
> + * The sign of the WRR credit determines the next queue, while the size of
> + * the dequeued packet determines the magnitude of the WRR credit change. If
> + * either queue is empty, the WRR credit is kept unchanged.
> + *
> + * As the dequeued packet can be dropped later, the caller has to perform the
> + * qdisc_bstats_update() calls.
> + */
> +static struct sk_buff *dequeue_packet(struct Qdisc *sch,
> +				      struct dualpi2_sched_data *q,
> +				      int *credit_change,
> +				      u64 now)
> +{
> +	struct sk_buff *skb = NULL;
> +	int c_len;
> +
> +	*credit_change = 0;
> +	c_len = qdisc_qlen(sch) - qdisc_qlen(q->l_queue);
> +	if (qdisc_qlen(q->l_queue) && (!c_len || q->c_protection_credit <= 0)) {
> +		skb = __qdisc_dequeue_head(&q->l_queue->q);
> +		WRITE_ONCE(q->l_head_ts, head_enqueue_time(q->l_queue));
> +		if (c_len)
> +			*credit_change = q->c_protection_wc;
> +		qdisc_qstats_backlog_dec(q->l_queue, skb);

Please add an empty line here.

> +		/* Keep the global queue size consistent */
> +		--sch->q.qlen;
> +		q->memory_used -= skb->truesize;
> +	} else if (c_len) {
> +		skb = __qdisc_dequeue_head(&sch->q);
> +		WRITE_ONCE(q->c_head_ts, head_enqueue_time(sch));
> +		if (qdisc_qlen(q->l_queue))
> +			*credit_change = ~((s32)q->c_protection_wl) + 1;
> +		q->memory_used -= skb->truesize;
> +	} else {
> +		dualpi2_reset_c_protection(q);
> +		return NULL;
> +	}
> +	*credit_change *= qdisc_pkt_len(skb);
> +	qdisc_qstats_backlog_dec(sch, skb);
> +	return skb;
> +}
> +
> +static int do_step_aqm(struct dualpi2_sched_data *q, struct sk_buff *skb,
> +		       u64 now)
> +{
> +	u64 qdelay = 0;
> +
> +	if (q->step_in_packets)
> +		qdelay = qdisc_qlen(q->l_queue);
> +	else
> +		qdelay = dualpi2_sojourn_time(skb, now);
> +
> +	if (dualpi2_skb_cb(skb)->apply_step && qdelay > q->step_thresh) {
> +		if (!dualpi2_skb_cb(skb)->ect)
> +			/* Drop this non-ECT packet */
> +			return 1;

Please add brackets and an empty line:

		if (!dualpi2_skb_cb(skb)->ect) {
			/* Drop this non-ECT packet */
			return 1;
		}

		if (dualpi2_mark(q, skb))


/P


