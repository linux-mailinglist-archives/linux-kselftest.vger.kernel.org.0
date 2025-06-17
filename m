Return-Path: <linux-kselftest+bounces-35232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73160ADDB99
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 20:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 167AF7A8585
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 18:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9BA2EF9AF;
	Tue, 17 Jun 2025 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZZWVsmr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15BA2EF9A5;
	Tue, 17 Jun 2025 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750185839; cv=none; b=PnlGIX2UU7jf6a3lMzttSbED2GnIojWDpjZpLpJh8WEQfI0OaRDZYZ+caukrTczi/D1R2Ue8Sp4KPGXt9UBeCGDZuLtvOTaEahiTlfc82jvBIOjymAiAHOHrA4b6eXa2nwjhCTHCXyxOxs8zvJgdOEkiYoORJT5jdlMJ3wgXzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750185839; c=relaxed/simple;
	bh=TaPi+/xL2M0k+f/vwOvZjYivCZgzk02KqvR7YFJhZQQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LnSo18e6K5/k/i6YkPsm75Gr79kKBfQjPnQCJoY1PSf78qsgFerKYoZOCJdOh8bV3+GwsKRO0uZiZa2Oe7MgIRd/xMY50i36KwGWcGpmHeYJg65Fy1Y78xaFYPGv7K6seIP1GKEiG6DmiojtD17KdAU9sx85m328EXCLKRUPP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZZWVsmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB336C4CEED;
	Tue, 17 Jun 2025 18:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750185838;
	bh=TaPi+/xL2M0k+f/vwOvZjYivCZgzk02KqvR7YFJhZQQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:References:From;
	b=TZZWVsmr4jefRxmrA6tyJcLp9cmgIrjuypuGxijfYcY8pfbspjVAGp2SNPKEKriYM
	 0bB7U/PTcgQCZ+FmiMB2zAHJZIWTXQeTRm9ed5R7Sh1Z9f3bdxSs1A2CmhpmcOjXpQ
	 UW3ncRstX2ZCZeTpgTC52/wWoSpvBxzwOkg3TULAaSOIqCriDyXQbE16AJbd/UgJUU
	 XO5c+Bi6EbSU+s/FliZUAQX6kLQpbyoOC+Mt+GSexEM+XRsRjFFt5pxbQJWJIcYNFz
	 KSRppxDFXFjkXlnSwDDJyS+0YpqSWAjhDsSVnSCzpOnBvlGUXz6VdpeJzlw49H+8vB
	 4nUiz55trwE9Q==
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>
Date: Tue, 17 Jun 2025 21:43:53 +0300 (EEST)
To: Paolo Abeni <pabeni@redhat.com>
cc: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, 
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
Subject: Re: [PATCH v8 net-next 09/15] tcp: accecn: AccECN option
In-Reply-To: <d652445f-3637-44bf-ac92-483e9a323a49@redhat.com>
Message-ID: <9f9a06d9-55f2-d5bb-72f2-883b994c0c2b@kernel.org>
References: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com> <20250610125314.18557-10-chia-yu.chang@nokia-bell-labs.com> <d652445f-3637-44bf-ac92-483e9a323a49@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 17 Jun 2025, Paolo Abeni wrote:

> On 6/10/25 2:53 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > @@ -294,6 +295,9 @@ struct tcp_sock {
> >  		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
> >  	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
> >  		unused2:4;
> > +	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
> > +		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
> 
> It's unclear to me why you didn't use the 4 bits avail in 'unused2',
> instead of adding more fragmented bitfields.
> 
> [...]
> > +/* Returns true if the byte counters can be used */
> > +static bool tcp_accecn_process_option(struct tcp_sock *tp,
> > +				      const struct sk_buff *skb,
> > +				      u32 delivered_bytes, int flag)
> > +{
> > +	u8 estimate_ecnfield = tp->est_ecnfield;
> > +	bool ambiguous_ecn_bytes_incr = false;
> > +	bool first_changed = false;
> > +	unsigned int optlen;
> > +	bool order1, res;
> > +	unsigned int i;
> > +	u8 *ptr;
> > +
> > +	if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
> > +		if (estimate_ecnfield) {
> > +			u8 ecnfield = estimate_ecnfield - 1;
> > +
> > +			tp->delivered_ecn_bytes[ecnfield] += delivered_bytes;
> > +			return true;
> > +		}
> > +		return false;
> > +	}
> > +
> > +	ptr = skb_transport_header(skb) + tp->rx_opt.accecn;
> > +	optlen = ptr[1] - 2;
> > +	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);
> > +	order1 = (ptr[0] == TCPOPT_ACCECN1);
> > +	ptr += 2;
> > +
> > +	res = !!estimate_ecnfield;
> > +	for (i = 0; i < 3; i++) {
> > +		if (optlen < TCPOLEN_ACCECN_PERFIELD)
> > +			continue;
> 
> Why continuing the loop if nothing could be done? possbly just 'break;'

Indeed, it should be break. I might have suggested converting it to 
continue without thinking too much (when reversing the logic due to deep 
indentation level).

-- 
 i.

> > +
> > +		u32 init_offset;
> > +		u8 ecnfield;
> > +		s32 delta;
> > +		u32 *cnt;
> 
> Please don't mix variables definition and code. Move the definition at
> the beginning of the block.
> 
> [...]
> > @@ -4236,6 +4375,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
> >  	if (tcp_ecn_mode_accecn(tp))
> >  		ecn_count = tcp_accecn_process(sk, skb,
> >  					       tp->delivered - delivered,
> > +					       sack_state.delivered_bytes,
> >  					       &flag);
> >  
> >  	tcp_in_ack_event(sk, flag);
> > @@ -4275,6 +4415,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
> >  	if (tcp_ecn_mode_accecn(tp))
> >  		ecn_count = tcp_accecn_process(sk, skb,
> >  					       tp->delivered - delivered,
> > +					       sack_state.delivered_bytes,
> >  					       &flag);
> 
> The two above chunks suggest you could move more code into
> tcp_accecn_process()
> 
> >  	tcp_in_ack_event(sk, flag);
> >  	/* If data was DSACKed, see if we can undo a cwnd reduction. */
> > @@ -4402,6 +4543,7 @@ void tcp_parse_options(const struct net *net,
> >  
> >  	ptr = (const unsigned char *)(th + 1);
> >  	opt_rx->saw_tstamp = 0;
> > +	opt_rx->accecn = 0;
> >  	opt_rx->saw_unknown = 0;
> >  
> >  	while (length > 0) {
> > @@ -4493,6 +4635,12 @@ void tcp_parse_options(const struct net *net,
> >  					ptr, th->syn, foc, false);
> >  				break;
> >  
> > +			case TCPOPT_ACCECN0:
> > +			case TCPOPT_ACCECN1:
> > +				/* Save offset of AccECN option in TCP header */
> > +				opt_rx->accecn = (ptr - 2) - (__u8 *)th;
> > +				break;
> > +
> >  			case TCPOPT_EXP:
> >  				/* Fast Open option shares code 254 using a
> >  				 * 16 bits magic number.
> > @@ -4553,11 +4701,14 @@ static bool tcp_fast_parse_options(const struct net *net,
> >  	 */
> >  	if (th->doff == (sizeof(*th) / 4)) {
> >  		tp->rx_opt.saw_tstamp = 0;
> > +		tp->rx_opt.accecn = 0;
> >  		return false;
> >  	} else if (tp->rx_opt.tstamp_ok &&
> >  		   th->doff == ((sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) / 4)) {
> > -		if (tcp_parse_aligned_timestamp(tp, th))
> > +		if (tcp_parse_aligned_timestamp(tp, th)) {
> > +			tp->rx_opt.accecn = 0;
> >  			return true;
> > +		}
> >  	}
> >  
> >  	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL);
> > @@ -6166,8 +6317,12 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
> >  		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
> >  					      0xfU);
> >  
> > -		if (payload_len > 0)
> > +		if (payload_len > 0) {
> > +			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
> >  			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
> > +			tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
> > +						  minlen);
> > +		}
> >  	}
> >  }
> >  
> > @@ -6387,6 +6542,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
> >  	 */
> >  
> >  	tp->rx_opt.saw_tstamp = 0;
> > +	tp->rx_opt.accecn = 0;
> >  
> >  	/*	pred_flags is 0xS?10 << 16 + snd_wnd
> >  	 *	if header_prediction is to be made
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index c5b93802d7c0..387cf8994202 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -3450,6 +3450,7 @@ static void __net_init tcp_set_hashinfo(struct net *net)
> >  static int __net_init tcp_sk_init(struct net *net)
> >  {
> >  	net->ipv4.sysctl_tcp_ecn = TCP_ECN_IN_ECN_OUT_NOECN;
> > +	net->ipv4.sysctl_tcp_ecn_option = TCP_ECN_OPTION_FULL;
> >  	net->ipv4.sysctl_tcp_ecn_fallback = 1;
> >  
> >  	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 78e78bca0db9..8869e49c07ec 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -492,6 +492,7 @@ static inline bool tcp_urg_mode(const struct tcp_sock *tp)
> >  #define OPTION_SMC		BIT(9)
> >  #define OPTION_MPTCP		BIT(10)
> >  #define OPTION_AO		BIT(11)
> > +#define OPTION_ACCECN		BIT(12)
> >  
> >  static void smc_options_write(__be32 *ptr, u16 *options)
> >  {
> > @@ -513,12 +514,14 @@ struct tcp_out_options {
> >  	u16 mss;		/* 0 to disable */
> >  	u8 ws;			/* window scale, 0 to disable */
> >  	u8 num_sack_blocks;	/* number of SACK blocks to include */
> > +	u8 num_accecn_fields;	/* number of AccECN fields needed */
> >  	u8 hash_size;		/* bytes in hash_location */
> >  	u8 bpf_opt_len;		/* length of BPF hdr option */
> >  	__u8 *hash_location;	/* temporary pointer, overloaded */
> >  	__u32 tsval, tsecr;	/* need to include OPTION_TS */
> >  	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
> >  	struct mptcp_out_options mptcp;
> > +	u32 *ecn_bytes;		/* AccECN ECT/CE byte counters */
> 
> This uncoditionally adds 16 bytes to out_options, bringing it to a 64
> bytes size with MPTCP disabled. I guess that adding another field will
> make the zeroing of out_options visible in perf report.
> 
> You can probably avoid adding `ecn_bytes` including instead an
> additional bit telling tcp_options_write to fetch the bytes from
> tp->received_ecn_bytes or zeroing them.
> 
> >  };
> >  
> >  static void mptcp_options_write(struct tcphdr *th, __be32 *ptr,
> > @@ -710,6 +713,8 @@ static __be32 *process_tcp_ao_options(struct tcp_sock *tp,
> >  	return ptr;
> >  }
> >  
> > +#define NOP_LEFTOVER	((TCPOPT_NOP << 8) | TCPOPT_NOP)
> > +
> >  /* Write previously computed TCP options to the packet.
> >   *
> >   * Beware: Something in the Internet is very sensitive to the ordering of
> > @@ -728,8 +733,10 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
> >  			      struct tcp_out_options *opts,
> >  			      struct tcp_key *key)
> >  {
> > +	u16 leftover_bytes = NOP_LEFTOVER;      /* replace next NOPs if avail */
> >  	__be32 *ptr = (__be32 *)(th + 1);
> >  	u16 options = opts->options;	/* mungable copy */
> > +	int leftover_size = 2;
> >  
> >  	if (tcp_key_is_md5(key)) {
> >  		*ptr++ = htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
> > @@ -763,18 +770,65 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
> >  		*ptr++ = htonl(opts->tsecr);
> >  	}
> >  
> > +	if (OPTION_ACCECN & options) {
> > +		const u8 ect0_idx = INET_ECN_ECT_0 - 1;
> > +		const u8 ect1_idx = INET_ECN_ECT_1 - 1;
> > +		const u8 ce_idx = INET_ECN_CE - 1;
> > +		u32 e0b;
> > +		u32 e1b;
> > +		u32 ceb;
> > +		u8 len;
> > +
> > +		e0b = opts->ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_INIT_OFFSET;
> > +		e1b = opts->ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_INIT_OFFSET;
> > +		ceb = opts->ecn_bytes[ce_idx] + TCP_ACCECN_CEB_INIT_OFFSET;
> > +		len = TCPOLEN_ACCECN_BASE +
> > +		      opts->num_accecn_fields * TCPOLEN_ACCECN_PERFIELD;
> > +
> > +		if (opts->num_accecn_fields == 2) {
> > +			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
> > +				       ((e1b >> 8) & 0xffff));
> > +			*ptr++ = htonl(((e1b & 0xff) << 24) |
> > +				       (ceb & 0xffffff));
> > +		} else if (opts->num_accecn_fields == 1) {
> > +			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
> > +				       ((e1b >> 8) & 0xffff));
> > +			leftover_bytes = ((e1b & 0xff) << 8) |
> > +					 TCPOPT_NOP;
> > +			leftover_size = 1;
> > +		} else if (opts->num_accecn_fields == 0) {
> > +			leftover_bytes = (TCPOPT_ACCECN1 << 8) | len;
> > +			leftover_size = 2;
> > +		} else if (opts->num_accecn_fields == 3) {
> > +			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
> > +				       ((e1b >> 8) & 0xffff));
> > +			*ptr++ = htonl(((e1b & 0xff) << 24) |
> > +				       (ceb & 0xffffff));
> > +			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
> > +				       TCPOPT_NOP);
> > +		}
> > +		if (tp)
> > +			tp->accecn_minlen = 0;
> > +	}
> > +
> >  	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
> > -		*ptr++ = htonl((TCPOPT_NOP << 24) |
> > -			       (TCPOPT_NOP << 16) |
> > +		*ptr++ = htonl((leftover_bytes << 16) |
> >  			       (TCPOPT_SACK_PERM << 8) |
> >  			       TCPOLEN_SACK_PERM);
> > +		leftover_bytes = NOP_LEFTOVER;
> > +		leftover_size = 2;
> >  	}
> >  
> >  	if (unlikely(OPTION_WSCALE & options)) {
> > -		*ptr++ = htonl((TCPOPT_NOP << 24) |
> > +		u8 highbyte = TCPOPT_NOP;
> > +
> > +		if (unlikely(leftover_size == 1))
> > +			highbyte = leftover_bytes >> 8;
> > +		*ptr++ = htonl((highbyte << 24) |
> >  			       (TCPOPT_WINDOW << 16) |
> >  			       (TCPOLEN_WINDOW << 8) |
> >  			       opts->ws);
> > +		leftover_bytes = NOP_LEFTOVER;
> 
> This bloks looks inconsistent. AFAICS if leftover_size == 1, such a byte
> will be consumed, but the leftover size will be left unmodified.
> 
> >  	}
> >  
> >  	if (unlikely(opts->num_sack_blocks)) {
> > @@ -782,8 +836,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
> >  			tp->duplicate_sack : tp->selective_acks;
> >  		int this_sack;
> >  
> > -		*ptr++ = htonl((TCPOPT_NOP  << 24) |
> > -			       (TCPOPT_NOP  << 16) |
> > +		*ptr++ = htonl((leftover_bytes << 16) |
> >  			       (TCPOPT_SACK <<  8) |
> >  			       (TCPOLEN_SACK_BASE + (opts->num_sack_blocks *
> >  						     TCPOLEN_SACK_PERBLOCK)));
> 
> Here leftover_size/bytes are consumed and not updated, which should be
> safe as they will not be used later in this function, but looks
> inconsistent.
> 
> The whole options handling looks very fragile to me. I really would
> prefer something simpler (i.e. just use the avail space if any) if that
> would work.
> 
> > @@ -957,6 +1068,17 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
> >  		}
> >  	}
> >  
> > +	/* Simultaneous open SYN/ACK needs AccECN option but not SYN */
> > +	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
> > +		     tcp_ecn_mode_accecn(tp) &&
> > +		     sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
> > +		     remaining >= TCPOLEN_ACCECN_BASE)) {
> > +		u32 saving = tcp_synack_options_combine_saving(opts);
> > +
> > +		opts->ecn_bytes = synack_ecn_bytes;
> > +		remaining -= tcp_options_fit_accecn(opts, 0, remaining, saving);
> > +	}
> > +
> >  	bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts, &remaining);
> >  
> >  	return MAX_TCP_OPTION_SPACE - remaining;
> 
> [...]
> > @@ -1036,6 +1159,14 @@ static unsigned int tcp_synack_options(const struct sock *sk,
> >  
> >  	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
> >  
> > +	if (treq->accecn_ok && sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
> > +	    remaining >= TCPOLEN_ACCECN_BASE) {
> > +		u32 saving = tcp_synack_options_combine_saving(opts);
> > +
> > +		opts->ecn_bytes = synack_ecn_bytes;
> > +		remaining -= tcp_options_fit_accecn(opts, 0, remaining, saving);
> > +	}
> > +
> >  	bpf_skops_hdr_opt_len((struct sock *)sk, skb, req, syn_skb,
> >  			      synack_type, opts, &remaining);
> >  
> 
> The similarities of the above 2 chuncks hints you could move more code
> into tcp_options_fit_accecn().
> 
> /P
> 
> 

