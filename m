Return-Path: <linux-kselftest+bounces-31180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7323DA93E54
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 21:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4924D8E15E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 19:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BA022DF84;
	Fri, 18 Apr 2025 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+Guq4Hd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E014221B9CD;
	Fri, 18 Apr 2025 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745004920; cv=none; b=NMuH8N8rJ3c4dccSE827yDvO+W3aucRPAzeXC5Ob2fXTUP4V082KKSiQduZ0SeovcuCXKLmDYTXEMrjiqBuCgrEelhVgDNhM6sY5GW1wI1A+Gp1bzqJe/LHAc6+9b+7KeND3DQn4ptBf+7IMB1qRcfBWJnwCtsUQwyMrANmG9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745004920; c=relaxed/simple;
	bh=vqFTFt0YdGYWN8vJdkEKbxx2rEmZzIS+iVRiY+3yqbA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X/fBnj2XObodHFV3BExMhxHC1o+1s5bzmMRJQlsaX47Y9IhyNkLhPUbzcBEpwehU9mjrAfuvezQlifddS71jI83VevXAAKQ8O+tR5dxSu+ckB/7lqBmxrtk4H68FgYEeabCdB+eJgiWMZymbA1lhR/FfME0xy4oiJTXrpUmEhik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+Guq4Hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3408FC4CEE2;
	Fri, 18 Apr 2025 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745004919;
	bh=vqFTFt0YdGYWN8vJdkEKbxx2rEmZzIS+iVRiY+3yqbA=;
	h=From:Date:To:cc:Subject:In-Reply-To:References:From;
	b=t+Guq4HdbFUo9uT75wS5MjZjkC3Sw3cOGuDQdPVem3HUypF9TPKt9aTC/HkNc6W7y
	 7c5vdu8roXMQSijR8tG9LSDG7Eg8ubRoNLLLYodxUh8CZFtiyjNRWZrM3O7CC2Lfwb
	 +WR7LFSy5KbsS5cQcnS5ZNmGCbEj2FsKAaxdNHCfPeCTyiviwLITVLjDqlqr5rNfO8
	 YDqdfr2PVB1MT88gqbsH4ACSPnumDlI8xPCwTpT1oCerPSZ1hMoKZxW2PHc2CrQwH0
	 popJOmX4YEoBS1hteJW8V5faCmjXOOJvz03JigPoQxyV7mWbtHBVXVbEr+W/6LyL6o
	 f6Byy6CPguHgQ==
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>
Date: Fri, 18 Apr 2025 22:35:14 +0300 (EEST)
To: Simon Horman <horms@kernel.org>
cc: chia-yu.chang@nokia-bell-labs.com, dsahern@kernel.org, kuniyu@amazon.com, 
    bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
    pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org, 
    stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
    davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch, 
    donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
    shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
    ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
    g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
    mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
    Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v4 net-next 09/15] tcp: accecn: AccECN option
In-Reply-To: <20250418183138.GE2676982@horms.kernel.org>
Message-ID: <8b6f580b-d682-91f7-f958-1806ee6e8bbe@kernel.org>
References: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com> <20250417230029.21905-10-chia-yu.chang@nokia-bell-labs.com> <20250418183138.GE2676982@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 18 Apr 2025, Simon Horman wrote:

> On Fri, Apr 18, 2025 at 01:00:23AM +0200, chia-yu.chang@nokia-bell-labs.com wrote:
> 
> ...
> 
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> 
> ...
> 
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
> > +		}
> > +		if (tp)
> > +			tp->accecn_minlen = 0;
> 
> Hi,
> 
> I'm sorry if this is a false positive: Smatch flags that here we assume
> that tp might be NULL, while elsewhere in this function tp is dereferenced
> unconditionally. So my question is, can tp be NULL here?

Hi Simon,

Thanks for taking look!

This looks a false positive. It's because tcp_options_write() is shared by 
the handshake and established connections. A direct caller from the 
handshake path passes NULL as tp:

	tcp_options_write(th, NULL, tcp_rsk(req), &opts, &key);

The thing that smatch doesn't know is that some TCP options are not going 
to be present during handshake. Those code paths that only deal with 
options that are for an established connection can assume full sk/tp has 
been already instantiated so they don't need to check tp. In addition, 
some funcs tcp_options_write() calls to make the opposite check by 
checking tcprsk instead but it has the same effect.

-- 
 i.

> > +	}
> > +
> >  	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
> >  		*ptr++ = htonl((leftover_bytes << 16) |
> >  			       (TCPOPT_SACK_PERM << 8) |
> 
> ...
> 

