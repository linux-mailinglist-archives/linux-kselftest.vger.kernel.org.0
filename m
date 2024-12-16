Return-Path: <linux-kselftest+bounces-23417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5C49F3313
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 15:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334DA1673E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A58E1863F;
	Mon, 16 Dec 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="aM+vlB7q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LL3bWYPF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025FB1EEE0;
	Mon, 16 Dec 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358805; cv=none; b=OwJ2LiYqM6ND6YhtAaSZcFZxDb27M2/68vlMTyuSXC8TyiVthIAT6qnDTIQsizMmGjSf3Ni6XpuJdZurUxYEbzwyZxi4QnIjw9vsNZMWu8Q2YzV8ZAdgDrcCwtHchSWkhoEom7B452U5/C0uxf39JvokHqNiJNsvcUJHYA+9rwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358805; c=relaxed/simple;
	bh=Tweej7hC2L9VaOw7rmTTdv3IYjt7RDJwGMsELhe/dho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6zva1QWzN0j0Nr5oXvLp19jAzJUk+knhex6JFwwl2g41YN7SqzqBW8d1Tno308UnKM2AcVcPZ9jX51WHjW/TOnUAqRR+AiX3Gzg29qdgPaMxpyiZKk9oa5C3pfO0kmJ/kLBd7vpG7HlRnGtcggCZbHe2r8XllfQ+4qkeVWJd5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=aM+vlB7q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LL3bWYPF; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AB3361140164;
	Mon, 16 Dec 2024 09:20:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 16 Dec 2024 09:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1734358800; x=
	1734445200; bh=XGcurLKIDnOqFOPyFDifM0TD7G50AKV8V+HLKIswVfo=; b=a
	M+vlB7qG9+O8XGN3kM8Ol5hOvq4H7BI8MYBZVoORuNDV8I1FcJ7kBOnTY+8eQZRE
	6EJiZARKVqqeemobY/tH9QCt5kv7P8+Vl28183hTXI+7zax6h0ighGqk8YfDe9pv
	TnwUxCBMgW5ivnhWswgVEtenrCK+gmHimQAJR6CrxakVjWAevMMMsVEODuzR+vfN
	dDkjg+C+XFozLdxcOjC3MS2j4vuF5romE6giMjaGRwiNUjwRbtY9spkXBBeneF1g
	5FHPDZHVUobnfdjK4P3r5YTTw6MX+6anQ5WyReXfB75JhI85fH9ek6LVAV6svrrS
	9Vv4JZ9LTKCWZdIQIldiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734358800; x=1734445200; bh=XGcurLKIDnOqFOPyFDifM0TD7G50AKV8V+H
	LKIswVfo=; b=LL3bWYPFSTLqkOxTvA43j6n9YdZnFtWQ7R2iitkjkIQY5Fl4X3R
	yp8LEXHeNBrU6BO9Cx3wPmrzHr1aQi4O9veJKreigEFEAAPv4H3SKKe/5F+Ca9u4
	i0dK+BmFbRZYGliqY1SsM8Ranv2m1Mr4HCYcWe5flpzvcGn75nXurHRz4xcOqYf9
	OMpk7BNQvCclaKhEZHMdZK/9hNCFXvnt8k3/7d9T55C85aHEcSGgkJ6bjBloYt4B
	HriKvtVdVMCirPLuJfxGnZwP3nP5xkrAUYeOLliTWyfq18Gd744G0TkhK8KsZkDQ
	Qjl/uGGcaju6GJSvM9NgndKp4Jmsbizna/Q==
X-ME-Sender: <xms:DzdgZ6fUiDMe9bLeYgxgDRxm6qOhG6srQfBGh7MStXgyUCZVZ_vYzw>
    <xme:DzdgZ0OxOgQ9gdUOuYCXGf05pDYyrRtZhz3-7mna0O85kcQbej_CVLQe3zsl5aJOL
    oYbwVGZYv-2Z3n8660>
X-ME-Received: <xmr:DzdgZ7gDZANjjtJidBMsqCwuDdiWA2D67jOP-b5PlqwFq9blW6y9BNusRBtr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeeg
    teehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnih
    hosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:DzdgZ39RcI-HODQ8lsH5r9DnC5VRd1ItG4tM09Uim66-L03zmPqyqw>
    <xmx:DzdgZ2uRYnvBNCCeen_y0m2R2WBFgA2ajSnBQNCmM9KQ3-_pthsBUQ>
    <xmx:DzdgZ-GoKHH1ilGo131TTK9a_NpAN0IZxqBlAMyulmrUNtTIzfeVbg>
    <xmx:DzdgZ1OfE_asBh2sWZ38DT-Mvionha0SBdQDfr1bqEdKXkhHo70KDQ>
    <xmx:EDdgZ2EmKcCruuqqYMoW1w2w-6CHNVfBcBxyPgz-OQpuMipdgmEJXo5j>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 09:19:59 -0500 (EST)
Date: Mon, 16 Dec 2024 15:19:57 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
	dsahern@kernel.org
Subject: Re: [PATCH net-next v15 11/22] ovpn: implement TCP transport
Message-ID: <Z2A3DW2GeMVzBa4R@hog>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
 <20241211-b4-ovpn-v15-11-314e2cad0618@openvpn.net>
 <Z2AyLOMazyOCDopc@hog>
 <dcb961a8-e0ba-49ea-b1ef-f52439713588@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcb961a8-e0ba-49ea-b1ef-f52439713588@openvpn.net>

2024-12-16, 15:09:17 +0100, Antonio Quartulli wrote:
> On 16/12/2024 14:59, Sabrina Dubroca wrote:
> > 2024-12-11, 22:15:15 +0100, Antonio Quartulli wrote:
> > > +static void ovpn_tcp_close(struct sock *sk, long timeout)
> > > +{
> > > +	struct ovpn_socket *sock;
> > > +
> > > +	rcu_read_lock();
> > 
> > [can't sleep until unlock]
> > 
> > > +	sock = rcu_dereference_sk_user_data(sk);
> > > +
> > > +	strp_stop(&sock->peer->tcp.strp);
> > > +
> > > +	tcp_close(sk, timeout);
> > 
> > 
> >      void tcp_close(struct sock *sk, long timeout)
> >      {
> >      	lock_sock(sk);
> > 
> > but this can sleep.
> 
> Ouch.. I wonder why I have never seen the might_sleep() trigger this, but
> probably that's due to the fact that we hardly hit this cb in the classic
> use case.

Probably. You'd only see it when you close the TCP socket before
detaching (otherwise the close CB is restored to tcp_close), which I
guess ovpn never does.

> 
> > 
> > Is there anything that prevents delaying tcp_close until after
> > ovpn_peer_del and rcu_read_unlock?
> 
> not really.
> 
> > 
> > > +	ovpn_peer_del(sock->peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
> > > +	rcu_read_unlock();
> 
> I will move the tcp_close() here.

Thanks.

-- 
Sabrina

