Return-Path: <linux-kselftest+bounces-32463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA54AAB21B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 06:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD2F17BA35F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 04:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB292336B99;
	Tue,  6 May 2025 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmgBmD6e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9782D5D0C;
	Mon,  5 May 2025 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485676; cv=none; b=UeYDoGizwdwqOvRJoB395FXnthqKBq5bC6XmcjbCRlH55pUdAOp2gP9CAKDBZzm4MtaFCvdyjgbbbJgacWEBX55TuYXH4TMrZfXtXWVOjssPYfnhEpMIUTKGwqORTQmO1qAqrQxaGH4buu4EKeDnKm0jX59YVT9fYZqV0Kq+d4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485676; c=relaxed/simple;
	bh=5TVo7ZSmhgN3LYeiSwaALQnkXbpb+sb65opx3Pb3mHI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iF7pzWJ92adFuMZ4zG3eJppyETHQM5a6q86TfJxqvkgEW5JHALOSO60OUynwXc3mQAHhMoH6b21kepRuQMen4TBcSJPOgPX0Wk6gZyiHEHHf2IX9wx1Bk6LWxGkTxv7xcIdkGoJ9mbyj77zFkjD3p0/deSlwt11idte/krkiUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmgBmD6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF22C4CEED;
	Mon,  5 May 2025 22:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485675;
	bh=5TVo7ZSmhgN3LYeiSwaALQnkXbpb+sb65opx3Pb3mHI=;
	h=From:Date:To:cc:Subject:In-Reply-To:References:From;
	b=cmgBmD6emuuZ1c7FzF7NwT50mtds5sTK43JOzd9jCGaiNdtboGBCZXt0WRTCJoGSA
	 V9ON+syeTz1a24Fs9KG/fUpIK3BkfxFVCA4tV4+Lr68owKqldqgTwHiVk6T9/xvGde
	 8IWAsGMU1GcArtNCbRMyK8FW9Nyg+bJtbri9lqU56PYezHYbmDyEJJ/IfFlEKDfnDi
	 AjH5ehTb9SrnEkW6w/MQaMpi9ElHo2d+ocuztcR7fHu795Gq3M74DGUfV6QX/nn6w3
	 ZIT9TgO+YK64L8LM+mo6iwYnyCVCY/xUifMfWmd6vp8b+jxOGS+tugRQDeauIai6YC
	 jh8ZBPlJxnPcw==
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>
Date: Tue, 6 May 2025 01:54:29 +0300 (EEST)
To: Paolo Abeni <pabeni@redhat.com>
cc: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org, 
    kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
    dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org, 
    stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
    davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch, 
    donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
    shuah@kernel.org, linux-kselftest@vger.kernel.org, ncardwell@google.com, 
    koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
    ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
    cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
    vidhi_goel@apple.com
Subject: Re: [PATCH v5 net-next 09/15] tcp: accecn: AccECN option
In-Reply-To: <d0969c3d-e33c-472e-815d-70b333990b39@redhat.com>
Message-ID: <412724ed-f5a0-9749-8c50-4dd76afd4140@kernel.org>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com> <20250422153602.54787-10-chia-yu.chang@nokia-bell-labs.com> <d0969c3d-e33c-472e-815d-70b333990b39@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 29 Apr 2025, Paolo Abeni wrote:

> On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > @@ -302,10 +303,13 @@ struct tcp_sock {
> >  	u32	snd_up;		/* Urgent pointer		*/
> >  	u32	delivered;	/* Total data packets delivered incl. rexmits */
> >  	u32	delivered_ce;	/* Like the above but only ECE marked packets */
> > +	u32	delivered_ecn_bytes[3];
> 
> This new fields do not belong to this cacheline group. I'm unsure they
> belong to fast-path at all. Also u32 will wrap-around very soon.
> 
> [...]
> > diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> > index dc8fdc80e16b..74ac8a5d2e00 100644
> > --- a/include/uapi/linux/tcp.h
> > +++ b/include/uapi/linux/tcp.h
> > @@ -298,6 +298,13 @@ struct tcp_info {
> >  	__u32	tcpi_snd_wnd;	     /* peer's advertised receive window after
> >  				      * scaling (bytes)
> >  				      */
> > +	__u32	tcpi_received_ce;    /* # of CE marks received */
> > +	__u32	tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters */
> > +	__u32	tcpi_delivered_e0_bytes;
> > +	__u32	tcpi_delivered_ce_bytes;
> > +	__u32	tcpi_received_e1_bytes;
> > +	__u32	tcpi_received_e0_bytes;
> > +	__u32	tcpi_received_ce_bytes;
> 
> This will break uAPI: new fields must be addded at the end, or must fill
> existing holes. Also u32 set in stone in uAPI for a byte counter looks
> way too small.
> 
> > @@ -5100,7 +5113,7 @@ static void __init tcp_struct_check(void)
> >  	/* 32bit arches with 8byte alignment on u64 fields might need padding
> >  	 * before tcp_clock_cache.
> >  	 */
> > -	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 109 + 7);
> > +	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 122 + 6);
> 
> The above means an additional cacheline in fast-path WRT the current
> status. IMHO should be avoided.
> 
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 5bd7fc9bcf66..41e45b9aff3f 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -70,6 +70,7 @@
> >  #include <linux/sysctl.h>
> >  #include <linux/kernel.h>
> >  #include <linux/prefetch.h>
> > +#include <linux/bitops.h>
> >  #include <net/dst.h>
> >  #include <net/tcp.h>
> >  #include <net/proto_memory.h>
> > @@ -499,6 +500,144 @@ static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp, const struct tcphdr
> >  	return false;
> >  }
> >  
> > +/* Maps IP ECN field ECT/CE code point to AccECN option field number, given
> > + * we are sending fields with Accurate ECN Order 1: ECT(1), CE, ECT(0).
> > + */
> > +static u8 tcp_ecnfield_to_accecn_optfield(u8 ecnfield)
> > +{
> > +	switch (ecnfield) {
> > +	case INET_ECN_NOT_ECT:
> > +		return 0;	/* AccECN does not send counts of NOT_ECT */
> > +	case INET_ECN_ECT_1:
> > +		return 1;
> > +	case INET_ECN_CE:
> > +		return 2;
> > +	case INET_ECN_ECT_0:
> > +		return 3;
> > +	default:
> > +		WARN_ONCE(1, "bad ECN code point: %d\n", ecnfield);
> 
> No WARN_ONCE() above please: either the 'ecnfield' data is masked vs
> INET_ECN_MASK and the WARN_ONCE should not be possible or a remote
> sender can deterministically trigger a WARN() which nowadays will in
> turn raise a CVE...
> 
> [...]
> > +static u32 tcp_accecn_field_init_offset(u8 ecnfield)
> > +{
> > +	switch (ecnfield) {
> > +	case INET_ECN_NOT_ECT:
> > +		return 0;	/* AccECN does not send counts of NOT_ECT */
> > +	case INET_ECN_ECT_1:
> > +		return TCP_ACCECN_E1B_INIT_OFFSET;
> > +	case INET_ECN_CE:
> > +		return TCP_ACCECN_CEB_INIT_OFFSET;
> > +	case INET_ECN_ECT_0:
> > +		return TCP_ACCECN_E0B_INIT_OFFSET;
> > +	default:
> > +		WARN_ONCE(1, "bad ECN code point: %d\n", ecnfield);
> 
> Same as above.
> 
> > +	}
> > +	return 0;
> > +}
> > +
> > +/* Maps AccECN option field #nr to IP ECN field ECT/CE bits */
> > +static unsigned int tcp_accecn_optfield_to_ecnfield(unsigned int optfield,
> > +						    bool order)
> > +{
> > +	u8 tmp;
> > +
> > +	optfield = order ? 2 - optfield : optfield;
> > +	tmp = optfield + 2;
> > +
> > +	return (tmp + (tmp >> 2)) & INET_ECN_MASK;
> > +}
> > +
> > +/* Handles AccECN option ECT and CE 24-bit byte counters update into
> > + * the u32 value in tcp_sock. As we're processing TCP options, it is
> > + * safe to access from - 1.
> > + */
> > +static s32 tcp_update_ecn_bytes(u32 *cnt, const char *from, u32 init_offset)
> > +{
> > +	u32 truncated = (get_unaligned_be32(from - 1) - init_offset) &
> > +			0xFFFFFFU;
> > +	u32 delta = (truncated - *cnt) & 0xFFFFFFU;
> > +
> > +	/* If delta has the highest bit set (24th bit) indicating
> > +	 * negative, sign extend to correct an estimation using
> > +	 * sign_extend32(delta, 24 - 1)
> > +	 */
> > +	delta = sign_extend32(delta, 23);
> > +	*cnt += delta;
> > +	return (s32)delta;
> > +}
> > +
> > +/* Returns true if the byte counters can be used */
> > +static bool tcp_accecn_process_option(struct tcp_sock *tp,
> > +				      const struct sk_buff *skb,
> > +				      u32 delivered_bytes, int flag)
> > +{
> > +	u8 estimate_ecnfield = tp->est_ecnfield;
> > +	bool ambiguous_ecn_bytes_incr = false;
> > +	bool first_changed = false;
> > +	unsigned int optlen;
> > +	unsigned char *ptr;

u8 would we more appropriate type for binary data.

> > +	bool order1, res;
> > +	unsigned int i;
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
> 
> This assumes optlen is greater then 2, but I don't see the relevant
> check.

The options parser should check that, please see the "silly options" 
check.

> Are tcp options present at all?

There is !tp->rx_opt.accecn check above which should ensure we're 
processing only AccECN Option that is present.

> > +	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);
> 
> Please, don't warn for arbitrary wrong data sent from the peer.

If there isn't AccECN option at ptr, there's bug elsewhere in the code 
(in the option parse code). So this is an internal sanity check that 
tp->rx_opt.accecn points to AccECN option for real like it should.

If you still want that removed, no problem but it's should not be 
arbitrary data at this point because the options parsing code should
have validated this condition already, thus WARN_ON_ONCE() seemed 
appropriate to me.

> > +	order1 = (ptr[0] == TCPOPT_ACCECN1);
> > +	ptr += 2;
> > +
> > +	res = !!estimate_ecnfield;
> > +	for (i = 0; i < 3; i++) {
> > +		if (optlen >= TCPOLEN_ACCECN_PERFIELD) {

It's easy to reverse logic here and use continue, which buys one level of 
indentation.

> > +			u32 init_offset;
> > +			u8 ecnfield;
> > +			s32 delta;
> > +			u32 *cnt;
> > +
> > +			ecnfield = tcp_accecn_optfield_to_ecnfield(i, order1);
> > +			init_offset = tcp_accecn_field_init_offset(ecnfield);
> > +			cnt = &tp->delivered_ecn_bytes[ecnfield - 1];
> > +			delta = tcp_update_ecn_bytes(cnt, ptr, init_offset);
> > +			if (delta) {
> > +				if (delta < 0) {
> > +					res = false;
> > +					ambiguous_ecn_bytes_incr = true;
> > +				}
> > +				if (ecnfield != estimate_ecnfield) {
> > +					if (!first_changed) {
> > +						tp->est_ecnfield = ecnfield;
> > +						first_changed = true;
> > +					} else {
> > +						res = false;
> > +						ambiguous_ecn_bytes_incr = true;
> > +					}
> 
> At least 2 indentation levels above the maximum readable.
> 
> [...]
> > @@ -4378,6 +4524,7 @@ void tcp_parse_options(const struct net *net,
> >  
> >  	ptr = (const unsigned char *)(th + 1);
> >  	opt_rx->saw_tstamp = 0;
> > +	opt_rx->accecn = 0;
> >  	opt_rx->saw_unknown = 0;
> 
> It would be good to be able to zero both 'accecn' and 'saw_unknown' with
> a single statement.
> 
> [...]
> > @@ -766,6 +769,47 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
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
> 
> The above chunck and the contents of patch 7 must be in the same patch.
> This split makes the review even harder.
> 
> [...]
> > @@ -1117,6 +1235,17 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
> >  		opts->num_sack_blocks = 0;
> >  	}
> >  
> > +	if (tcp_ecn_mode_accecn(tp) &&
> > +	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
> > +		int saving = opts->num_sack_blocks > 0 ? 2 : 0;
> > +		int remaining = MAX_TCP_OPTION_SPACE - size;
> 
> AFACS the above means tcp_options_fit_accecn() must clear any already
> set options, but apparently it does not do so. Have you tested with
> something adding largish options like mptcp?

This "fitting" for AccEcn option is not to make room for the option but to 
check if AccECN option fits and in what length, and how it can take 
advantage of some nop bytes when available to save option space.

-- 
 i.


