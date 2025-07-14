Return-Path: <linux-kselftest+bounces-37261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E37B041BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 16:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8084A23E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5E425743E;
	Mon, 14 Jul 2025 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xz+mAqg5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834911CBA
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503553; cv=none; b=FOGZrvNEcPl58w+7nxh1GgPXrdQleCY+K9WV1BTa6P0shpR4m3jwReOTGyAWk+qyxVHiqH5VLjpBkiqDzymD1i/e/ZPuMwNsarfLzeYTAfb8KkIR7v7XKkA/Kvf/cPrGjXKowfKgZoU4i2ms8oedMJVOrBW2oLGe/uKzaSxOVWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503553; c=relaxed/simple;
	bh=D2Shg9wiVYkET3gKkKNW+4ySokqdmq1tWoJefiMv2gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oOGJYgt1FGeTyHFnZmpRJc2rhWTIT9RoYdIb+GK4UQE/S1XtTlEQJx3eefHUOMDErg7+1XpyEixEpCXKZyhD5k2gWd2j2B+yctgNW/lBncB5s2c66adBMhv3yEVEDj3MihOq6eHB9g/GaZH98RAH4rUJkJzo4IEhTcZPcix9Y2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xz+mAqg5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752503548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGD1KU8sFNPJUcSBHbtbleDSQjiotSa+EZbqlJ6lMfw=;
	b=Xz+mAqg5LAefsBvCLOYcGjIuSAblZ4iYcYPN3yAPA4VLld3gs39QQkVyz5BCnsOqCbm7t+
	bqbKODPyBCNPNVMImhOygsqOL1hPpTrvUvNXcl+bDlM0+t7SjJDD2a+9K/1sSIZaUzILng
	irBksxdOYcKgtPRF0NWwOtcqjQ3qqGw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-makBMzSbPyiZnMfrLj1XUA-1; Mon, 14 Jul 2025 10:32:26 -0400
X-MC-Unique: makBMzSbPyiZnMfrLj1XUA-1
X-Mimecast-MFC-AGG-ID: makBMzSbPyiZnMfrLj1XUA_1752503545
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45600d19a2aso17824685e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 07:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752503545; x=1753108345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGD1KU8sFNPJUcSBHbtbleDSQjiotSa+EZbqlJ6lMfw=;
        b=PI5h24tfhQGY/78e4sv8Yr9MQRWWgNbRv81F4WpFG+J2u/5Zm9VBkr4hB9uj7eY7dj
         yXr7JwTto+49HgwjuIH0L1tM8TE/t+oZm92oNANryESNI3Kfc65q0v/s/aFUPR2aH7s0
         cJ1xWtbW5dmXHOHoQd8nb6fmHQMatJ/fFfgtIgfpqgd+91Pn9on438HAdBCOIkhTPVDr
         8KH9upuAiIWFufL5XJgEQ8dUy7Ve5Va0BRJdEN9OMrbTWBJqoUFf57+/oulqcwVgjthr
         grfP5ov5T9p7XYH0GUZmnPkgOM/4T/NkWFzygFXbDopiDxDtNwHiYhwKw4MSB1RyEXWr
         nsxg==
X-Forwarded-Encrypted: i=1; AJvYcCXwPAW3YeVrXcl3GExz0V4GU1mJ7hjzNikUUA6wKuybnkkaMT2E/CTqWNkX2Z3pcdXdQe2otAu1YlFNFeGT2bA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3aho2kXCKNFzj7CqfLbwB0+cP75GDBPNmtbH2nQsB9SEz9rUw
	SQJkYuZ2XenoEEpXKI8MHOrNyobGsEaAo7XNrw4vjzAC2jLiBlE9xkFxmgrd534pzu3pkPtZnCf
	9SMhs6ZyGCOtCRWESZeLm/gDtCZcRJmsCkxoADt7V+yRi3LA24/jzaagPHJwvwDaaevw0pg==
X-Gm-Gg: ASbGncv5tb7BG/E+q48ORhPl0vxt77i2INwWaat7jyF1BnfHm/L0CIxo1DPBzs7yEbi
	n8dlNz6JRXLy++0TkvAs0R4aXTtTDmYPcITsYS19XLta+z43nDTzUPyX6emKhF4TDsSfaDK/DHy
	erd78lpr/1+jxWs3ZK1BBwMxAVUW/g6OB0f6GvqrU0CYPUMtJgiScyd+ZkVAbLdeueANTndKFOx
	hW7ruekc6n2ZuyVBaYjf/eQ8ZrIY/y1YOis+Yelw2JVRubzvJxvYBsOf0r0JHpByoedh8FX5bU2
	Kp5CpPczh4F9/RRmPID9e+Rvg5VUptnUd+QbXxS9FFg=
X-Received: by 2002:a05:600c:c176:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-454ec263d7cmr97272285e9.20.1752503544781;
        Mon, 14 Jul 2025 07:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDqtqpXfxIzSlI6jl0FMnFo64VbI1ICPI5atHbMGBa01OvZMbXirZbtZS7pc3Ed9lpvPQOIw==
X-Received: by 2002:a05:600c:c176:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-454ec263d7cmr97271575e9.20.1752503544153;
        Mon, 14 Jul 2025 07:32:24 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd474a9csm133909225e9.16.2025.07.14.07.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:32:23 -0700 (PDT)
Message-ID: <0ddc5daf-adb4-4d97-9e8e-e60fdf9a007f@redhat.com>
Date: Mon, 14 Jul 2025 16:32:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 11/15] tcp: accecn: AccECN option
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-12-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-12-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> +/* Maps AccECN option field #nr to IP ECN field ECT/CE bits */
> +static inline unsigned int tcp_accecn_optfield_to_ecnfield(unsigned int option,
> +							   bool order)
> +{
> +	u8 tmp;
> +
> +	/* Below is modified from Table 5 of the AccECN spec to explain
> +	 * how the ECN fields are mapped baed on two input arguemnts:
> +	 * +=======================================+=======================+
> +	 * |                                       |  order=0  |  order=1  |
> +	 * ++======================================+===========+===========+
> +	 * | 1st field in AccECN option (option=0) |   ECT(0)  |   ECT(1)  |
> +	 * | 2nd field in AccECN option (option=1) |    CE     |    CE     |
> +	 * | 3rd field in AccECN option (option=2) |   ECT(1)  |   ECT(0)  |
> +	 * +=======================================+===========+===========+
> +	 */
> +
> +	option = order ? 2 - option : option;
> +	tmp = option + 2;
> +
> +	return (tmp + (tmp >> 2)) & INET_ECN_MASK;

Possibly/likely computing the above with an explicit static array lookup
would be simpler and more clear.

> +}
> +
> +/* Handles AccECN option ECT and CE 24-bit byte counters update into
> + * the u32 value in tcp_sock. As we're processing TCP options, it is
> + * safe to access from - 1.
> + */
> +static inline s32 tcp_update_ecn_bytes(u32 *cnt, const char *from,
> +				       u32 init_offset)
> +{
> +	u32 truncated = (get_unaligned_be32(from - 1) - init_offset) &
> +			0xFFFFFFU;
> +	u32 delta = (truncated - *cnt) & 0xFFFFFFU;
> +
> +	/* If delta has the highest bit set (24th bit) indicating
> +	 * negative, sign extend to correct an estimation using
> +	 * sign_extend32(delta, 24 - 1)
> +	 */
> +	delta = sign_extend32(delta, 23);

I'm under the impression that delta could be simply:

	delta = (truncated - *cnt)

What am I missing?

> +/* Returns true if the byte counters can be used */
> +static bool tcp_accecn_process_option(struct tcp_sock *tp,
> +				      const struct sk_buff *skb,
> +				      u32 delivered_bytes, int flag)
> +{
> +	u8 estimate_ecnfield = tp->est_ecnfield;
> +	bool ambiguous_ecn_bytes_incr = false;
> +	bool first_changed = false;
> +	unsigned int optlen;
> +	bool order1, res;
> +	unsigned int i;
> +	u8 *ptr;
> +
> +	if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
> +		if (estimate_ecnfield) {
> +			u8 ecnfield = estimate_ecnfield - 1;
> +
> +			tp->delivered_ecn_bytes[ecnfield] += delivered_bytes;
> +			return true;
> +		}
> +		return false;
> +	}
> +
> +	ptr = skb_transport_header(skb) + tp->rx_opt.accecn;
> +	optlen = ptr[1] - 2;
> +	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);

Likely/possibly:

	if (WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1))
		return false;

> +	order1 = (ptr[0] == TCPOPT_ACCECN1);
> +	ptr += 2;
> +
> +	res = !!estimate_ecnfield;
> +	for (i = 0; i < 3; i++) {
> +		u32 init_offset;
> +		u8 ecnfield;
> +		s32 delta;
> +		u32 *cnt;
> +
> +		if (optlen < TCPOLEN_ACCECN_PERFIELD)
> +			break;
> +
> +		ecnfield = tcp_accecn_optfield_to_ecnfield(i, order1);
> +		init_offset = tcp_accecn_field_init_offset(ecnfield);
> +		cnt = &tp->delivered_ecn_bytes[ecnfield - 1];
> +		delta = tcp_update_ecn_bytes(cnt, ptr, init_offset);
> +		if (delta && delta < 0) {
> +			res = false;
> +			ambiguous_ecn_bytes_incr = true;
> +		}
> +		if (delta && ecnfield != estimate_ecnfield) {
> +			if (!first_changed) {
> +				tp->est_ecnfield = ecnfield;
> +				first_changed = true;
> +			} else {
> +				res = false;
> +				ambiguous_ecn_bytes_incr = true;
> +			}
> +		}
> +
> +		optlen -= TCPOLEN_ACCECN_PERFIELD;
> +		ptr += TCPOLEN_ACCECN_PERFIELD;
> +	}
> +	if (ambiguous_ecn_bytes_incr)
> +		tp->est_ecnfield = 0;
> +
> +	return res;
> +}
> +
>  static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
>  {
>  	tp->delivered_ce += ecn_count;
> @@ -400,7 +467,8 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
>  
>  /* Returns the ECN CE delta */
>  static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
> -				u32 delivered_pkts, int flag)
> +				u32 delivered_pkts, u32 delivered_bytes,
> +				int flag)
>  {
>  	const struct tcphdr *th = tcp_hdr(skb);
>  	struct tcp_sock *tp = tcp_sk(sk);
> @@ -411,6 +479,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
>  	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
>  		return 0;
>  
> +	tcp_accecn_process_option(tp, skb, delivered_bytes, flag);
> +
>  	if (!(flag & FLAG_SLOWPATH)) {
>  		/* AccECN counter might overflow on large ACKs */
>  		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
> @@ -436,12 +506,14 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
>  }
>  
>  static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
> -			      u32 delivered_pkts, int *flag)
> +			      u32 delivered_pkts, u32 delivered_bytes,
> +			      int *flag)
>  {
>  	struct tcp_sock *tp = tcp_sk(sk);
>  	u32 delta;
>  
> -	delta = __tcp_accecn_process(sk, skb, delivered_pkts, *flag);
> +	delta = __tcp_accecn_process(sk, skb, delivered_pkts,
> +				     delivered_bytes, *flag);
>  	if (delta > 0) {
>  		tcp_count_delivered_ce(tp, delta);
>  		*flag |= FLAG_ECE;
> @@ -3973,6 +4045,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
>  	if (tcp_ecn_mode_accecn(tp))
>  		ecn_count = tcp_accecn_process(sk, skb,
>  					       tp->delivered - delivered,
> +					       sack_state.delivered_bytes,
>  					       &flag);
>  
>  	tcp_in_ack_event(sk, flag);
> @@ -4012,6 +4085,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
>  	if (tcp_ecn_mode_accecn(tp))
>  		ecn_count = tcp_accecn_process(sk, skb,
>  					       tp->delivered - delivered,
> +					       sack_state.delivered_bytes,
>  					       &flag);
>  	tcp_in_ack_event(sk, flag);
>  	/* If data was DSACKed, see if we can undo a cwnd reduction. */
> @@ -4139,6 +4213,7 @@ void tcp_parse_options(const struct net *net,
>  
>  	ptr = (const unsigned char *)(th + 1);
>  	opt_rx->saw_tstamp = 0;
> +	opt_rx->accecn = 0;
>  	opt_rx->saw_unknown = 0;
>  
>  	while (length > 0) {
> @@ -4230,6 +4305,12 @@ void tcp_parse_options(const struct net *net,
>  					ptr, th->syn, foc, false);
>  				break;
>  
> +			case TCPOPT_ACCECN0:
> +			case TCPOPT_ACCECN1:
> +				/* Save offset of AccECN option in TCP header */
> +				opt_rx->accecn = (ptr - 2) - (__u8 *)th;
> +				break;
> +
>  			case TCPOPT_EXP:
>  				/* Fast Open option shares code 254 using a
>  				 * 16 bits magic number.
> @@ -4290,11 +4371,14 @@ static bool tcp_fast_parse_options(const struct net *net,
>  	 */
>  	if (th->doff == (sizeof(*th) / 4)) {
>  		tp->rx_opt.saw_tstamp = 0;
> +		tp->rx_opt.accecn = 0;
>  		return false;
>  	} else if (tp->rx_opt.tstamp_ok &&
>  		   th->doff == ((sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) / 4)) {
> -		if (tcp_parse_aligned_timestamp(tp, th))
> +		if (tcp_parse_aligned_timestamp(tp, th)) {
> +			tp->rx_opt.accecn = 0;
>  			return true;
> +		}
>  	}
>  
>  	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL);
> @@ -6094,6 +6178,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
>  	 */
>  
>  	tp->rx_opt.saw_tstamp = 0;
> +	tp->rx_opt.accecn = 0;
>  
>  	/*	pred_flags is 0xS?10 << 16 + snd_wnd
>  	 *	if header_prediction is to be made
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index b95e4ed227cb..1da7c5e4da32 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3451,6 +3451,7 @@ static void __net_init tcp_set_hashinfo(struct net *net)
>  static int __net_init tcp_sk_init(struct net *net)
>  {
>  	net->ipv4.sysctl_tcp_ecn = TCP_ECN_IN_ECN_OUT_NOECN;
> +	net->ipv4.sysctl_tcp_ecn_option = TCP_ACCECN_OPTION_FULL;
>  	net->ipv4.sysctl_tcp_ecn_fallback = 1;
>  
>  	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index d98a1a17eb52..2169fd28594e 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -385,6 +385,7 @@ static inline bool tcp_urg_mode(const struct tcp_sock *tp)
>  #define OPTION_SMC		BIT(9)
>  #define OPTION_MPTCP		BIT(10)
>  #define OPTION_AO		BIT(11)
> +#define OPTION_ACCECN		BIT(12)
>  
>  static void smc_options_write(__be32 *ptr, u16 *options)
>  {
> @@ -406,6 +407,8 @@ struct tcp_out_options {
>  	u16 mss;		/* 0 to disable */
>  	u8 ws;			/* window scale, 0 to disable */
>  	u8 num_sack_blocks;	/* number of SACK blocks to include */
> +	u8 num_accecn_fields:7,	/* number of AccECN fields needed */
> +	   use_synack_ecn_bytes:1; /* Use synack_ecn_bytes or not */
>  	u8 hash_size;		/* bytes in hash_location */
>  	u8 bpf_opt_len;		/* length of BPF hdr option */
>  	__u8 *hash_location;	/* temporary pointer, overloaded */
> @@ -621,6 +624,8 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  			      struct tcp_out_options *opts,
>  			      struct tcp_key *key)
>  {
> +	u8 leftover_highbyte = TCPOPT_NOP; /* replace 1st NOP if avail */
> +	u8 leftover_lowbyte = TCPOPT_NOP;  /* replace 2nd NOP in succession */
>  	__be32 *ptr = (__be32 *)(th + 1);
>  	u16 options = opts->options;	/* mungable copy */
>  
> @@ -656,15 +661,79 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  		*ptr++ = htonl(opts->tsecr);
>  	}
>  
> +	if (OPTION_ACCECN & options) {
> +		/* Initial values for AccECN option, ordered is based on ECN field bits
> +		 * similar to received_ecn_bytes. Used for SYN/ACK AccECN option.
> +		 */
> +		static u32 synack_ecn_bytes[3] = { 0, 0, 0 };

I think this does not address Eric's concern on v9 WRT global variable,
as every CPU will still touch the same memory while accessing the above
array.

> +		const u8 ect0_idx = INET_ECN_ECT_0 - 1;
> +		const u8 ect1_idx = INET_ECN_ECT_1 - 1;
> +		const u8 ce_idx = INET_ECN_CE - 1;
> +		u32 e0b;
> +		u32 e1b;
> +		u32 ceb;
> +		u8 len;
> +
> +		if (opts->use_synack_ecn_bytes) {
> +			e0b = synack_ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_INIT_OFFSET;
> +			e1b = synack_ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_INIT_OFFSET;
> +			ceb = synack_ecn_bytes[ce_idx] + TCP_ACCECN_CEB_INIT_OFFSET;

On the flip side I don't see such array modified here, not in later
patches?!? If so you could make it const and a global variable would be ok.



> +		} else {
> +			e0b = tp->received_ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_INIT_OFFSET;
> +			e1b = tp->received_ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_INIT_OFFSET;
> +			ceb = tp->received_ecn_bytes[ce_idx] + TCP_ACCECN_CEB_INIT_OFFSET;
> +		}

Also it looks like the above two blocks could be condensed to something
alike:

		const u32 *ecn_bytes = opts->use_synack_ecn_bytes ?
					synack_ecn_bytes :
					tp->received_ecn_bytes;

		e0b = ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_INIT_OFFSET;
		e1b = ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_INIT_OFFSET;
		ceb = ecn_bytes[ce_idx] + TCP_ACCECN_CEB_INIT_OFFSET;

> +
> +		len = TCPOLEN_ACCECN_BASE +
> +		      opts->num_accecn_fields * TCPOLEN_ACCECN_PERFIELD;
> +
> +		if (opts->num_accecn_fields == 2) {
> +			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
> +				       ((e1b >> 8) & 0xffff));
> +			*ptr++ = htonl(((e1b & 0xff) << 24) |
> +				       (ceb & 0xffffff));
> +		} else if (opts->num_accecn_fields == 1) {
> +			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
> +				       ((e1b >> 8) & 0xffff));
> +			leftover_highbyte = e1b & 0xff;
> +			leftover_lowbyte = TCPOPT_NOP;
> +		} else if (opts->num_accecn_fields == 0) {
> +			leftover_highbyte = TCPOPT_ACCECN1;
> +			leftover_lowbyte = len;
> +		} else if (opts->num_accecn_fields == 3) {
> +			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
> +				       ((e1b >> 8) & 0xffff));
> +			*ptr++ = htonl(((e1b & 0xff) << 24) |
> +				       (ceb & 0xffffff));
> +			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
> +				       TCPOPT_NOP);
> +		}
> +		if (tp)
> +			tp->accecn_minlen = 0;
> +	}
> +
>  	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
> -		*ptr++ = htonl((TCPOPT_NOP << 24) |
> -			       (TCPOPT_NOP << 16) |
> +		*ptr++ = htonl((leftover_highbyte << 24) |
> +			       (leftover_lowbyte << 16) |
>  			       (TCPOPT_SACK_PERM << 8) |
>  			       TCPOLEN_SACK_PERM);
> +		leftover_highbyte = TCPOPT_NOP;
> +		leftover_lowbyte = TCPOPT_NOP;
>  	}
>  
>  	if (unlikely(OPTION_WSCALE & options)) {
> -		*ptr++ = htonl((TCPOPT_NOP << 24) |
> +		u8 highbyte = TCPOPT_NOP;
> +
> +		/* Do not split the leftover 2-byte to fit into a single
> +		 * NOP, i.e., replace this NOP only when 1 byte is leftover
> +		 * within leftover_highbyte.
> +		 */
> +		if (unlikely(leftover_highbyte != TCPOPT_NOP &&
> +			     leftover_lowbyte == TCPOPT_NOP)) {
> +			highbyte = leftover_highbyte;
> +			leftover_highbyte = TCPOPT_NOP;
> +		}
> +		*ptr++ = htonl((highbyte << 24) |
>  			       (TCPOPT_WINDOW << 16) |
>  			       (TCPOLEN_WINDOW << 8) |
>  			       opts->ws);
> @@ -675,11 +744,13 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  			tp->duplicate_sack : tp->selective_acks;
>  		int this_sack;
>  
> -		*ptr++ = htonl((TCPOPT_NOP  << 24) |
> -			       (TCPOPT_NOP  << 16) |
> +		*ptr++ = htonl((leftover_highbyte << 24) |
> +			       (leftover_lowbyte << 16) |
>  			       (TCPOPT_SACK <<  8) |
>  			       (TCPOLEN_SACK_BASE + (opts->num_sack_blocks *
>  						     TCPOLEN_SACK_PERBLOCK)));
> +		leftover_highbyte = TCPOPT_NOP;
> +		leftover_lowbyte = TCPOPT_NOP;
>  
>  		for (this_sack = 0; this_sack < opts->num_sack_blocks;
>  		     ++this_sack) {
> @@ -688,6 +759,14 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  		}
>  
>  		tp->rx_opt.dsack = 0;
> +	} else if (unlikely(leftover_highbyte != TCPOPT_NOP ||
> +			    leftover_lowbyte != TCPOPT_NOP)) {
> +		*ptr++ = htonl((leftover_highbyte << 24) |
> +			       (leftover_lowbyte << 16) |
> +			       (TCPOPT_NOP << 8) |
> +			       TCPOPT_NOP);
> +		leftover_highbyte = TCPOPT_NOP;
> +		leftover_lowbyte = TCPOPT_NOP;
>  	}
>  
>  	if (unlikely(OPTION_FAST_OPEN_COOKIE & options)) {
> @@ -768,6 +847,59 @@ static void mptcp_set_option_cond(const struct request_sock *req,
>  	}
>  }
>  
> +static u32 tcp_synack_options_combine_saving(struct tcp_out_options *opts)
> +{
> +	/* How much there's room for combining with the alignment padding? */
> +	if ((opts->options & (OPTION_SACK_ADVERTISE | OPTION_TS)) ==
> +	    OPTION_SACK_ADVERTISE)
> +		return 2;
> +	else if (opts->options & OPTION_WSCALE)
> +		return 1;
> +	return 0;
> +}
> +
> +/* Calculates how long AccECN option will fit to @remaining option space.
> + *
> + * AccECN option can sometimes replace NOPs used for alignment of other
> + * TCP options (up to @max_combine_saving available).
> + *
> + * Only solutions with at least @required AccECN fields are accepted.
> + *
> + * Returns: The size of the AccECN option excluding space repurposed from
> + * the alignment of the other options.
> + */
> +static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
> +				  int remaining)
> +{
> +	int size = TCP_ACCECN_MAXSIZE;
> +	int max_combine_saving;
> +
> +	if (opts->use_synack_ecn_bytes)
> +		max_combine_saving = tcp_synack_options_combine_saving(opts);
> +	else
> +		max_combine_saving = opts->num_sack_blocks > 0 ? 2 : 0;
> +	opts->num_accecn_fields = TCP_ACCECN_NUMFIELDS;
> +	while (opts->num_accecn_fields >= required) {
> +		int leftover_size = size & 0x3;
> +		/* Pad to dword if cannot combine */
> +		if (leftover_size > max_combine_saving)
> +			leftover_size = -((4 - leftover_size) & 0x3);

I *think* that with the above you mean something alike:

			size = ALIGN(size, 4);
			leftover_size = 0

?

The used code looks quite obscure to me.

/P


