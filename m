Return-Path: <linux-kselftest+bounces-18086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E1197B29F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 18:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE61B28FD4
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 16:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B2317BEB6;
	Tue, 17 Sep 2024 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Btj9KYxV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C291915ECDF
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Sep 2024 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589182; cv=none; b=Mkk87l+z4ErsSOWv4yPGvQObCqZxAFaNiofXh25n1RpscuyQVnBzbxIWXPGgyXzeHH4H2wkqO6z1UYdm6g1xe7u3elVoXvYp/zZqSQfAaA/kEPmxPSkJIXVuuZzv8dJGQ3sdIAc46J6WFVlCUObSoOMlur5ehREKELGr6/cBuTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589182; c=relaxed/simple;
	bh=32AEDX9cCv9RsZHT9wdTvhGXqMlN0xLTW5QkFMjL/4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn+5JLEuHyKech4mRzsnMrWaMuacHtClNwPGUzDXaUtgAylkssnHXl1HZRxevGZIX15SIqAaI9JrvKMOulsFMxJI6tw/ucpZ/ST+9uVHF2ILYw6ODuEIjqczlRKVBrUx49i1zgd7HcLtXYD+CvxCo8eeta1aROKwXlZOPApkA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Btj9KYxV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-375e5c12042so3222091f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Sep 2024 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1726589178; x=1727193978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C3wWVmY11x7twX+QLzZLt+655E3mj9zAVsD71Ldt/Ac=;
        b=Btj9KYxVw2j9NpKleB/T4folXDUm1hDLKUOF5p0UP0rZmRW2zo9kKiUcb4zFCbI0HH
         6DSW1IUTCDDH6VWtfXz0WH3NhmVcbyV/iVYT0lXpFgiysn5nRfnPokS8WJZJ1bpuldDJ
         usBcdZhn6U3VR6hG//rwzv6qNn1mlhSUP1mMZmGEECdbnLyPQvbY+Zg2oQ4o2RZKI2pj
         mLOXrXarn9A8BBN95HQTDi/FNFBlTSHIXTg5vXCW36ggChLGOrR0cDzqkQYrimAVoBwK
         TWbSSy8B5M46b/bGT6pj3puG6ytURDoRQ2hNtmFxWgUzNOVW22NSRdS/dG4l6Xo295gp
         pykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726589178; x=1727193978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3wWVmY11x7twX+QLzZLt+655E3mj9zAVsD71Ldt/Ac=;
        b=taUm0pkIM7GMWvwXE65v4dGSftRrexylXNCnq3PZPNQnVfuFeEiZxKGW8lrCDC3daD
         44lZQxM1RMhdrg+kX9iqJf0gRlz4vSRbDYfKcSGeg07wXPOiSpYE2MZl3TBaq4S3+vpe
         iREcWbKFFl0OUdxJwdp/vXyNEgsf9Fwbg+tE5cii1I1BoivBdK5BAddBWZ/441FPHAxk
         wi/JuujKPb0QYxF+u49AU4xr6VpXpPmvo8k/bfGKVFgXPvkBLVuTg4tlTYqea+4l1Gzc
         6gedq6cKjd6HAb9h/osTc85H+fXGWYY4kojqXT3Ia/jpVjTPUqM2BrIRNcsf+UORqLgz
         JAjg==
X-Forwarded-Encrypted: i=1; AJvYcCX7Efy2RRQfGS7eo5GyIaebuOvpFkhz80zuvw0PxWy7FTNyccfUHWA/uAtQDX8wMZ+ZKqIg/scnYPsokptvlOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9ElR4e8Z/IWa93QC9XSuccWDDsCc5eGp6AKp+tJVAjRLrnbQ
	2sYCo7+FPgk6jDWvtpJ718du6xWVbS+K3PSa3aAXY6lzbOg4FZkIeZK29oSnzGQ=
X-Google-Smtp-Source: AGHT+IFBa6LORWITRw1wV+KPnnRiX0GK6peQ486VSUGuguJIiXw3h4Apf2WbrzFK92EDTfdpTnDLRA==
X-Received: by 2002:adf:a45d:0:b0:374:c847:848 with SMTP id ffacd0b85a97d-378c2d5a70dmr9566997f8f.36.1726589177899;
        Tue, 17 Sep 2024 09:06:17 -0700 (PDT)
Received: from GHGHG14 ([2a09:bac5:50ca:432::6b:83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7800138sm9857539f8f.68.2024.09.17.09.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 09:06:17 -0700 (PDT)
Date: Tue, 17 Sep 2024 17:06:14 +0100
From: Tiago Lam <tiagolam@cloudflare.com>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>, kernel-team@cloudflare.com
Subject: Re: [RFC PATCH 2/3] ipv6: Run a reverse sk_lookup on sendmsg.
Message-ID: <Zumo9rNztx4PJgRP@GHGHG14>
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
 <20240913-reverse-sk-lookup-v1-2-e721ea003d4c@cloudflare.com>
 <20240914085950.GC12935@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914085950.GC12935@kernel.org>

On Sat, Sep 14, 2024 at 09:59:50AM +0100, Simon Horman wrote:
> On Fri, Sep 13, 2024 at 10:39:20AM +0100, Tiago Lam wrote:
> > This follows the same rationale provided for the ipv4 counterpart, where
> > it now runs a reverse socket lookup when source addresses and/or ports
> > are changed, on sendmsg, to check whether egress traffic should be
> > allowed to go through or not.
> > 
> > As with ipv4, the ipv6 sendmsg path is also extended here to support the
> > IPV6_ORIGDSTADDR ancilliary message to be able to specify a source
> 
> Hi Tiago Lam,
> 
> Some minor nits from my side.
> 
> ancilliary -> ancillary
> 
> Likewise in patch 3/3.
> Flagged by checkpatch.pl --codespell
> 
> > address/port.
> > 
> > Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
> > ---
> >  net/ipv6/datagram.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  net/ipv6/udp.c      |  8 ++++--
> >  2 files changed, 82 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> > index fff78496803d..4214dda1c320 100644
> > --- a/net/ipv6/datagram.c
> > +++ b/net/ipv6/datagram.c
> > @@ -756,6 +756,27 @@ void ip6_datagram_recv_ctl(struct sock *sk, struct msghdr *msg,
> >  }
> >  EXPORT_SYMBOL_GPL(ip6_datagram_recv_ctl);
> >  
> > +static inline bool reverse_sk_lookup(struct flowi6 *fl6, struct sock *sk,
> > +				     struct in6_addr *saddr, __be16 sport)
> > +{
> > +	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
> > +	    (saddr && sport) &&
> > +	    (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, saddr) || inet_sk(sk)->inet_sport != sport)) {
> 
> Please consider, where it can trivially be achieved, limiting Networking
> code to 80 columns wide.
> 
> Checkpatch can be run with a flag to check for this.
> 

Thanks for the hints here, I've addressed these and will include the
changes into the next revision. I use b4 which takes care of some of
this checks, but I'll make sure I change my settings to use
`--max-line-length=80` as well.

Tiago.

