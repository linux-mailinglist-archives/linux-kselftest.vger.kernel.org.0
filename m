Return-Path: <linux-kselftest+bounces-32455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C127CAAAF92
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 05:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E123AEE5D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 03:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BCB2FB459;
	Mon,  5 May 2025 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKnAnOnu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EA63839BD;
	Mon,  5 May 2025 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486595; cv=none; b=VaeEL2TlfEelpfTNaiV6XMP6iABzWLjyUnx+SUlo7WaZVJICbz/pWGcBj/SzCo21H90u8JGG1yUK7BiyT5Dns2M3gR4uDTaKAauKtwvbDipd+X1HnPONBCYKGyFz3ZimCg1CTXvgn3tI9pgPPnDH3tOO2KooIakd1bB/q4rpdE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486595; c=relaxed/simple;
	bh=QPwr0a3hI3hIBTqtzqqTs2xwxaxhRKIl4wXz72iYB9Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hZhB/sJt5tQwL7t/keUL+9E0SuaF7UNEESdcxlpCpJacr21oftkNiwXCAJnjvQqZNZCqEpQmkIEXFNR/FrWpDs3Mnir3pUASD2Li0ssSUdb+uq/A+Zm++UDIOF5Y4RaKk/+66AzTvM9ze2mejqExOYQDAhJSWZeP8f1drXVCK8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKnAnOnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A634C4CEE4;
	Mon,  5 May 2025 23:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486594;
	bh=QPwr0a3hI3hIBTqtzqqTs2xwxaxhRKIl4wXz72iYB9Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:References:From;
	b=GKnAnOnucxWQgZQ5PShIrRAhiNOaQJ81ED86k2XW0QUQCL34viuFPDxoXsEnTNrLN
	 NaIepN75L7XsBxepBVytaXxJEPdmlnm453u3CalZ3bNqaP9GOX6pg/1yddWDh+ihN+
	 eUoSMioHWUBLxJMco5wWfPGlJBkOCgUvyz2rI512D2QGs+H54EZCuH/JbF5emS3mFT
	 uNuBWEe58jaN/6bs32q/Ss4MD9G+POw4ykvWwgEb2+Waji0yaIbSZync2xEA0MiL7K
	 yT8eb4lqi7L9x0ogAB69rHJacHUJH/T2gXETxPL3YfiHy221I1eeSoWNmEyj8+DNwQ
	 A5C/EYMcUCB4A==
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>
Date: Tue, 6 May 2025 02:09:49 +0300 (EEST)
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
Subject: Re: [PATCH v5 net-next 07/15] tcp: allow embedding leftover into
 option padding
In-Reply-To: <2067a9f7-eba4-476d-a095-3d6301e14830@redhat.com>
Message-ID: <7e64bedf-2da2-2deb-2712-f338474720e7@kernel.org>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com> <20250422153602.54787-8-chia-yu.chang@nokia-bell-labs.com> <2067a9f7-eba4-476d-a095-3d6301e14830@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 29 Apr 2025, Paolo Abeni wrote:

> On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > @@ -709,6 +709,8 @@ static __be32 *process_tcp_ao_options(struct tcp_sock *tp,
> >  	return ptr;
> >  }
> >  
> > +#define NOP_LEFTOVER	((TCPOPT_NOP << 8) | TCPOPT_NOP)
> > +
> >  /* Write previously computed TCP options to the packet.
> >   *
> >   * Beware: Something in the Internet is very sensitive to the ordering of
> > @@ -727,8 +729,10 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
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
> > @@ -763,17 +767,22 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
> >  	}
> >  
> >  	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
> > -		*ptr++ = htonl((TCPOPT_NOP << 24) |
> > -			       (TCPOPT_NOP << 16) |
> > +		*ptr++ = htonl((leftover_bytes << 16) |
> >  			       (TCPOPT_SACK_PERM << 8) |
> >  			       TCPOLEN_SACK_PERM);
> > +		leftover_bytes = NOP_LEFTOVER;
> 
> Why? isn't leftover_bytes already == NOP_LEFTOVER?
> 
> >  	}
> >  
> >  	if (unlikely(OPTION_WSCALE & options)) {
> > -		*ptr++ = htonl((TCPOPT_NOP << 24) |
> > +		u8 highbyte = TCPOPT_NOP;
> > +
> > +		if (unlikely(leftover_size == 1))
> 
> How can the above conditional be true?
> 
> > +			highbyte = leftover_bytes >> 8;
> > +		*ptr++ = htonl((highbyte << 24) |
> >  			       (TCPOPT_WINDOW << 16) |
> >  			       (TCPOLEN_WINDOW << 8) |
> >  			       opts->ws);
> > +		leftover_bytes = NOP_LEFTOVER;
> 
> Why? isn't leftover_bytes already == NOP_LEFTOVER?
> 
> >  	}
> >  
> >  	if (unlikely(opts->num_sack_blocks)) {
> > @@ -781,8 +790,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
> >  			tp->duplicate_sack : tp->selective_acks;
> >  		int this_sack;
> >  
> > -		*ptr++ = htonl((TCPOPT_NOP  << 24) |
> > -			       (TCPOPT_NOP  << 16) |
> > +		*ptr++ = htonl((leftover_bytes << 16) |
> >  			       (TCPOPT_SACK <<  8) |
> >  			       (TCPOLEN_SACK_BASE + (opts->num_sack_blocks *
> >  						     TCPOLEN_SACK_PERBLOCK)));
> > @@ -794,6 +802,10 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
> >  		}
> >  
> >  		tp->rx_opt.dsack = 0;
> > +	} else if (unlikely(leftover_bytes != NOP_LEFTOVER)) {
> 
> I really feel like I'm missing some code chunk, but I don't see any
> possible value for leftover_bytes other than NOP_LEFTOVER

Hi,
   
I split it this way to keep the generic part of the leftover mechanism in
own patch separate from AccECN option change itself (as you did later
discover). This is among the most convoluted parts in the entire AccECN
patch series so it seemed wise to split it as small as I could. Having
those non-sensical looking assigns here were to avoid code churn in the
latter patch. The changelog could have stated that clearly though (my
fault from years back).


-- 
 i.


