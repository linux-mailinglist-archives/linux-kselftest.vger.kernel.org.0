Return-Path: <linux-kselftest+bounces-31895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16FAAA0AE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 13:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C7E1B62567
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 11:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CFB270ED5;
	Tue, 29 Apr 2025 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXzYmNRx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CFE21ABA0
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745927780; cv=none; b=ApF2UdErdwhHpxsLaT7JfApqR71ZDKf13I26e7/Hi6Ey7XcqnzdLws1hLBo305ks9Na2giNiCsFAn/lYnFiTbdUaZaLTLUs2reiwyxkmXn6xtPgyhx4tsTDnZMetys/nIj6nfIWuu4xY1FqS2H6RMTHr2HwZEQrTUq1Z2pt3EQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745927780; c=relaxed/simple;
	bh=A0zmw6w5Ln1uNFh7KT0bElow7mg3PZg/ObRtEdwM93E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ibwcyKplNJut7bRa8LVh/7VN45G3xlNebvyFhp2w/BOJGDny1hhnn9I6+F+mjyk/vo1owExf2yTVn0hC9v/9YfSilj6kEBSknMzPpC2s8wuqnBrWLqei03ifnRawrv90/R+AhtpBjiOKxGZXJ4j+ghFhxmu7eme7/As/i3T51DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXzYmNRx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745927777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxpogNMJwjcGkLRpHZgajtQVqSJUQZRSCcKGwWOzQfo=;
	b=KXzYmNRxm8bhugNoDShQJ9TOpKCgIz8mVu5czfiNqpeoSqZ2Essg6gyChfg8JcXMj5/C/D
	/kiXnglw94MgyxoxoCYXRrypx9XVBy+tDtstfKCYEal22Ym/0j0USP5a3niqXhYpMKa5mk
	2FdwVhwPdzniR31GOqZMZz86FtolLXs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-azkZpzRQO02rLcWppdNC6w-1; Tue, 29 Apr 2025 07:56:16 -0400
X-MC-Unique: azkZpzRQO02rLcWppdNC6w-1
X-Mimecast-MFC-AGG-ID: azkZpzRQO02rLcWppdNC6w_1745927775
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5f05d36993aso5458322a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 04:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745927775; x=1746532575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxpogNMJwjcGkLRpHZgajtQVqSJUQZRSCcKGwWOzQfo=;
        b=DNF54Tj1D4OU+L1Uek8D4O8ZBN3qJy7s49VoTWLhIGo4oy3MkTv0e9xADbFcfBPiWq
         2kd5ygwha9NTPEBchdvHCCjYSD6cOO7J43JBTNQFddU/iicHKd5xcj4PoLkNL29pvo4J
         7ZBSpL4JBUgZtQiJwRQyIBUpTDbnyi1DMISDP/ZqGHPg+Eu+aRLaXPoVeTdfND4etG0D
         3XLB0AnK7ouczMg2WCf9Ob2y/VoqkPHx3kS3CfhjpQty3izdFkyTmdm83mITU3OgiM9S
         OPOW3/iL+kmuUkCvjzwllzI6tO9zCaSQtU7oglO4C9h8tmCch82Xy3OVHSJvOESs7dPe
         FO6g==
X-Forwarded-Encrypted: i=1; AJvYcCX+sfj4xPoGAWuECcX3gvyjBJYvEBrB4praum0llO3EO5ZcB89i5Ge+MxFSTWwQ7IPQzoG/wbCmI8shXcVK7P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQgMfBoZZaklcQX1Lg8cf94/YK37m1k0CXKH4/YKqkEI3IIsX
	kg2YjNjNE5mOBF1hEuwozpKH5/mGnm+hUYOGrmYuI+IfWKjCBC5/k/fvL1CnCPCfCCl+QIvSjzS
	X0A/zAmFyzpKzPr2GMtcBN0/kcfb46xrqatFIH+BGGun/uUFmcRPOpJvtQoEmuW3lsQ==
X-Gm-Gg: ASbGncvF6stcsrUJCjCaYN789v3WKXXPPdEEikb3Jh8g4Yowsfj2h0wcl21IjisQoL/
	P24q+HsX5kF62j39xYmXG5Q5b59Eo/xWw5rqMZVf0BOkm/UeCrSUsxrHIAqsvcP8b538/+y2LFl
	l/oI3vj4n0pnlLaOgkyLIoLuMSj0nrWTIl+VHEMy0eC0mPiF0DUuc+cutkaGBhYAmcIoKviRWZD
	btvHIFK3Zta5T8gc7ZJrk8XC8NCWGsJlSIFOB3z2ZeDGRl0ffoQtkdpb3D2OcUY6+n3ncIRrpvu
	x31b9XD6XdWNIvJaRa7z6Oi/f+LXMrCzpNqoyymrz9GnaN0IDhKUkIVOSzM=
X-Received: by 2002:a05:6402:354e:b0:5f8:664c:928a with SMTP id 4fb4d7f45d1cf-5f8664c952amr462047a12.9.1745927774825;
        Tue, 29 Apr 2025 04:56:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Q45LumRPr98BxK7ECFdtw18/jRYYz/jhVNPowK2uHwAgGVCwXMtRmZJ+OCuZrVKWbIDbow==
X-Received: by 2002:a05:6402:354e:b0:5f8:664c:928a with SMTP id 4fb4d7f45d1cf-5f8664c952amr462006a12.9.1745927774387;
        Tue, 29 Apr 2025 04:56:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897? ([2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7016f666fsm7483215a12.45.2025.04.29.04.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 04:56:13 -0700 (PDT)
Message-ID: <d0969c3d-e33c-472e-815d-70b333990b39@redhat.com>
Date: Tue, 29 Apr 2025 13:56:11 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 09/15] tcp: accecn: AccECN option
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org,
 kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
 <20250422153602.54787-10-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422153602.54787-10-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -302,10 +303,13 @@ struct tcp_sock {
>  	u32	snd_up;		/* Urgent pointer		*/
>  	u32	delivered;	/* Total data packets delivered incl. rexmits */
>  	u32	delivered_ce;	/* Like the above but only ECE marked packets */
> +	u32	delivered_ecn_bytes[3];

This new fields do not belong to this cacheline group. I'm unsure they
belong to fast-path at all. Also u32 will wrap-around very soon.

[...]
> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index dc8fdc80e16b..74ac8a5d2e00 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -298,6 +298,13 @@ struct tcp_info {
>  	__u32	tcpi_snd_wnd;	     /* peer's advertised receive window after
>  				      * scaling (bytes)
>  				      */
> +	__u32	tcpi_received_ce;    /* # of CE marks received */
> +	__u32	tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters */
> +	__u32	tcpi_delivered_e0_bytes;
> +	__u32	tcpi_delivered_ce_bytes;
> +	__u32	tcpi_received_e1_bytes;
> +	__u32	tcpi_received_e0_bytes;
> +	__u32	tcpi_received_ce_bytes;

This will break uAPI: new fields must be addded at the end, or must fill
existing holes. Also u32 set in stone in uAPI for a byte counter looks
way too small.

> @@ -5100,7 +5113,7 @@ static void __init tcp_struct_check(void)
>  	/* 32bit arches with 8byte alignment on u64 fields might need padding
>  	 * before tcp_clock_cache.
>  	 */
> -	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 109 + 7);
> +	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 122 + 6);

The above means an additional cacheline in fast-path WRT the current
status. IMHO should be avoided.

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 5bd7fc9bcf66..41e45b9aff3f 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -70,6 +70,7 @@
>  #include <linux/sysctl.h>
>  #include <linux/kernel.h>
>  #include <linux/prefetch.h>
> +#include <linux/bitops.h>
>  #include <net/dst.h>
>  #include <net/tcp.h>
>  #include <net/proto_memory.h>
> @@ -499,6 +500,144 @@ static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp, const struct tcphdr
>  	return false;
>  }
>  
> +/* Maps IP ECN field ECT/CE code point to AccECN option field number, given
> + * we are sending fields with Accurate ECN Order 1: ECT(1), CE, ECT(0).
> + */
> +static u8 tcp_ecnfield_to_accecn_optfield(u8 ecnfield)
> +{
> +	switch (ecnfield) {
> +	case INET_ECN_NOT_ECT:
> +		return 0;	/* AccECN does not send counts of NOT_ECT */
> +	case INET_ECN_ECT_1:
> +		return 1;
> +	case INET_ECN_CE:
> +		return 2;
> +	case INET_ECN_ECT_0:
> +		return 3;
> +	default:
> +		WARN_ONCE(1, "bad ECN code point: %d\n", ecnfield);

No WARN_ONCE() above please: either the 'ecnfield' data is masked vs
INET_ECN_MASK and the WARN_ONCE should not be possible or a remote
sender can deterministically trigger a WARN() which nowadays will in
turn raise a CVE...

[...]
> +static u32 tcp_accecn_field_init_offset(u8 ecnfield)
> +{
> +	switch (ecnfield) {
> +	case INET_ECN_NOT_ECT:
> +		return 0;	/* AccECN does not send counts of NOT_ECT */
> +	case INET_ECN_ECT_1:
> +		return TCP_ACCECN_E1B_INIT_OFFSET;
> +	case INET_ECN_CE:
> +		return TCP_ACCECN_CEB_INIT_OFFSET;
> +	case INET_ECN_ECT_0:
> +		return TCP_ACCECN_E0B_INIT_OFFSET;
> +	default:
> +		WARN_ONCE(1, "bad ECN code point: %d\n", ecnfield);

Same as above.

> +	}
> +	return 0;
> +}
> +
> +/* Maps AccECN option field #nr to IP ECN field ECT/CE bits */
> +static unsigned int tcp_accecn_optfield_to_ecnfield(unsigned int optfield,
> +						    bool order)
> +{
> +	u8 tmp;
> +
> +	optfield = order ? 2 - optfield : optfield;
> +	tmp = optfield + 2;
> +
> +	return (tmp + (tmp >> 2)) & INET_ECN_MASK;
> +}
> +
> +/* Handles AccECN option ECT and CE 24-bit byte counters update into
> + * the u32 value in tcp_sock. As we're processing TCP options, it is
> + * safe to access from - 1.
> + */
> +static s32 tcp_update_ecn_bytes(u32 *cnt, const char *from, u32 init_offset)
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
> +	*cnt += delta;
> +	return (s32)delta;
> +}
> +
> +/* Returns true if the byte counters can be used */
> +static bool tcp_accecn_process_option(struct tcp_sock *tp,
> +				      const struct sk_buff *skb,
> +				      u32 delivered_bytes, int flag)
> +{
> +	u8 estimate_ecnfield = tp->est_ecnfield;
> +	bool ambiguous_ecn_bytes_incr = false;
> +	bool first_changed = false;
> +	unsigned int optlen;
> +	unsigned char *ptr;
> +	bool order1, res;
> +	unsigned int i;
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

This assumes optlen is greater then 2, but I don't see the relevant
check. Are tcp options present at all?

> +	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);

Please, don't warn for arbitrary wrong data sent from the peer.

> +	order1 = (ptr[0] == TCPOPT_ACCECN1);
> +	ptr += 2;
> +
> +	res = !!estimate_ecnfield;
> +	for (i = 0; i < 3; i++) {
> +		if (optlen >= TCPOLEN_ACCECN_PERFIELD) {
> +			u32 init_offset;
> +			u8 ecnfield;
> +			s32 delta;
> +			u32 *cnt;
> +
> +			ecnfield = tcp_accecn_optfield_to_ecnfield(i, order1);
> +			init_offset = tcp_accecn_field_init_offset(ecnfield);
> +			cnt = &tp->delivered_ecn_bytes[ecnfield - 1];
> +			delta = tcp_update_ecn_bytes(cnt, ptr, init_offset);
> +			if (delta) {
> +				if (delta < 0) {
> +					res = false;
> +					ambiguous_ecn_bytes_incr = true;
> +				}
> +				if (ecnfield != estimate_ecnfield) {
> +					if (!first_changed) {
> +						tp->est_ecnfield = ecnfield;
> +						first_changed = true;
> +					} else {
> +						res = false;
> +						ambiguous_ecn_bytes_incr = true;
> +					}

At least 2 indentation levels above the maximum readable.

[...]
> @@ -4378,6 +4524,7 @@ void tcp_parse_options(const struct net *net,
>  
>  	ptr = (const unsigned char *)(th + 1);
>  	opt_rx->saw_tstamp = 0;
> +	opt_rx->accecn = 0;
>  	opt_rx->saw_unknown = 0;

It would be good to be able to zero both 'accecn' and 'saw_unknown' with
a single statement.

[...]
> @@ -766,6 +769,47 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  		*ptr++ = htonl(opts->tsecr);
>  	}
>  
> +	if (OPTION_ACCECN & options) {
> +		const u8 ect0_idx = INET_ECN_ECT_0 - 1;
> +		const u8 ect1_idx = INET_ECN_ECT_1 - 1;
> +		const u8 ce_idx = INET_ECN_CE - 1;
> +		u32 e0b;
> +		u32 e1b;
> +		u32 ceb;
> +		u8 len;
> +
> +		e0b = opts->ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_INIT_OFFSET;
> +		e1b = opts->ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_INIT_OFFSET;
> +		ceb = opts->ecn_bytes[ce_idx] + TCP_ACCECN_CEB_INIT_OFFSET;
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
> +			leftover_bytes = ((e1b & 0xff) << 8) |
> +					 TCPOPT_NOP;
> +			leftover_size = 1;
> +		} else if (opts->num_accecn_fields == 0) {
> +			leftover_bytes = (TCPOPT_ACCECN1 << 8) | len;
> +			leftover_size = 2;
> +		} else if (opts->num_accecn_fields == 3) {
> +			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
> +				       ((e1b >> 8) & 0xffff));
> +			*ptr++ = htonl(((e1b & 0xff) << 24) |
> +				       (ceb & 0xffffff));
> +			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
> +				       TCPOPT_NOP);

The above chunck and the contents of patch 7 must be in the same patch.
This split makes the review even harder.

[...]
> @@ -1117,6 +1235,17 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>  		opts->num_sack_blocks = 0;
>  	}
>  
> +	if (tcp_ecn_mode_accecn(tp) &&
> +	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
> +		int saving = opts->num_sack_blocks > 0 ? 2 : 0;
> +		int remaining = MAX_TCP_OPTION_SPACE - size;

AFACS the above means tcp_options_fit_accecn() must clear any already
set options, but apparently it does not do so. Have you tested with
something adding largish options like mptcp?

/P


