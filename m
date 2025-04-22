Return-Path: <linux-kselftest+bounces-31330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A8A9727C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 18:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8E818995FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F18228BAA2;
	Tue, 22 Apr 2025 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjLMOyso"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA6529CE8;
	Tue, 22 Apr 2025 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339006; cv=none; b=SKRbaBxUAizLCY/GTShDX7VmB3HXPSFPTBGKA2+hkm4RVM590lg+v2R0Jl6yWCl7g1gSHUiP2pFxwr0go05OIUFIoRBkKlZ2EWuwC4YU9XEnWbaleQUZf3wIsBilBGyEZVeKKbyTO6vWLbvbQka0z+wxLXB5Qy0NfiqHwzCiVQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339006; c=relaxed/simple;
	bh=el03+wkT7G2QcB+cYa9PQdWkqikPRn2Ydhr4BlWOGIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBTw5opXXeJJ6l8/KrZG0lV0ipAPaTkp5QcHpg8Yv2sBPXqkHr6GffLVgcbEazTs66i0wCFvsRUmCb1jd/BoLSO3AyCnIc5qD3aZwJfJOSSyyL8/cFEFqafWDH5TdvOuOvVtMKut8NoQveaxrUv6gZ+ke7J6BgCluOGeNlEwLS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjLMOyso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4D0C4CEED;
	Tue, 22 Apr 2025 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745339005;
	bh=el03+wkT7G2QcB+cYa9PQdWkqikPRn2Ydhr4BlWOGIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UjLMOysolSc4V48hMrcN7AaQ+UhnfJEZiE6TH3niXOQApWPf0Kb8URGZSy18MZ6cY
	 /ikHU7gEI7qqrvd9+ixLIOmppJINTxmNRpHWXXN2AGlZvhN4Z189aXQaf4AbNONkog
	 Pbx7FXMAwfyO9OTWUeh4+NJuCIvbNrkXuF9XkNKAbJVuQ6jatWnZRnyxhqkmTPXlyn
	 sXSjUTBwjKT0Sw2e4GPoDP2YX39IwBDdFB8gyzVMt+gyJ7sMe4dancoq0EolH5lu6H
	 TvMTTdq4ReFQ1OCEbb/ZJ/BDZOZRgUmgULQBqMgsgT3kp1fNoyLkPle3C94QXeZVvA
	 e6AR1oH/d2LjA==
Date: Tue, 22 Apr 2025 17:23:18 +0100
From: Simon Horman <horms@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ij@kernel.org>
Cc: chia-yu.chang@nokia-bell-labs.com, dsahern@kernel.org,
	kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
	dave.taht@gmail.com, pabeni@redhat.com, jhs@mojatatu.com,
	kuba@kernel.org, stephen@networkplumber.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
	ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Subject: Re: [PATCH v4 net-next 09/15] tcp: accecn: AccECN option
Message-ID: <20250422162318.GI2843373@horms.kernel.org>
References: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
 <20250417230029.21905-10-chia-yu.chang@nokia-bell-labs.com>
 <20250418183138.GE2676982@horms.kernel.org>
 <8b6f580b-d682-91f7-f958-1806ee6e8bbe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b6f580b-d682-91f7-f958-1806ee6e8bbe@kernel.org>

On Fri, Apr 18, 2025 at 10:35:14PM +0300, Ilpo Järvinen wrote:
> On Fri, 18 Apr 2025, Simon Horman wrote:
> 
> > On Fri, Apr 18, 2025 at 01:00:23AM +0200, chia-yu.chang@nokia-bell-labs.com wrote:
> > 
> > ...
> > 
> > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > 
> > ...
> > 
> > > @@ -766,6 +769,47 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
> > >  		*ptr++ = htonl(opts->tsecr);
> > >  	}
> > >  
> > > +	if (OPTION_ACCECN & options) {
> > > +		const u8 ect0_idx = INET_ECN_ECT_0 - 1;
> > > +		const u8 ect1_idx = INET_ECN_ECT_1 - 1;
> > > +		const u8 ce_idx = INET_ECN_CE - 1;
> > > +		u32 e0b;
> > > +		u32 e1b;
> > > +		u32 ceb;
> > > +		u8 len;
> > > +
> > > +		e0b = opts->ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_INIT_OFFSET;
> > > +		e1b = opts->ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_INIT_OFFSET;
> > > +		ceb = opts->ecn_bytes[ce_idx] + TCP_ACCECN_CEB_INIT_OFFSET;
> > > +		len = TCPOLEN_ACCECN_BASE +
> > > +		      opts->num_accecn_fields * TCPOLEN_ACCECN_PERFIELD;
> > > +
> > > +		if (opts->num_accecn_fields == 2) {
> > > +			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
> > > +				       ((e1b >> 8) & 0xffff));
> > > +			*ptr++ = htonl(((e1b & 0xff) << 24) |
> > > +				       (ceb & 0xffffff));
> > > +		} else if (opts->num_accecn_fields == 1) {
> > > +			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
> > > +				       ((e1b >> 8) & 0xffff));
> > > +			leftover_bytes = ((e1b & 0xff) << 8) |
> > > +					 TCPOPT_NOP;
> > > +			leftover_size = 1;
> > > +		} else if (opts->num_accecn_fields == 0) {
> > > +			leftover_bytes = (TCPOPT_ACCECN1 << 8) | len;
> > > +			leftover_size = 2;
> > > +		} else if (opts->num_accecn_fields == 3) {
> > > +			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
> > > +				       ((e1b >> 8) & 0xffff));
> > > +			*ptr++ = htonl(((e1b & 0xff) << 24) |
> > > +				       (ceb & 0xffffff));
> > > +			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
> > > +				       TCPOPT_NOP);
> > > +		}
> > > +		if (tp)
> > > +			tp->accecn_minlen = 0;
> > 
> > Hi,
> > 
> > I'm sorry if this is a false positive: Smatch flags that here we assume
> > that tp might be NULL, while elsewhere in this function tp is dereferenced
> > unconditionally. So my question is, can tp be NULL here?
> 
> Hi Simon,
> 
> Thanks for taking look!
> 
> This looks a false positive. It's because tcp_options_write() is shared by 
> the handshake and established connections. A direct caller from the 
> handshake path passes NULL as tp:
> 
> 	tcp_options_write(th, NULL, tcp_rsk(req), &opts, &key);
> 
> The thing that smatch doesn't know is that some TCP options are not going 
> to be present during handshake. Those code paths that only deal with 
> options that are for an established connection can assume full sk/tp has 
> been already instantiated so they don't need to check tp. In addition, 
> some funcs tcp_options_write() calls to make the opposite check by 
> checking tcprsk instead but it has the same effect.

Thanks for checking, I appreciate you clarifying this.

