Return-Path: <linux-kselftest+bounces-22345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5BE9D39CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 12:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735342833D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967D01A2860;
	Wed, 20 Nov 2024 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ZFaiRStr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a/5nVvYP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB31C1A3056;
	Wed, 20 Nov 2024 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103161; cv=none; b=kIpS+9KleU/Vu+ylEMmj8dSCN91yZJhvAtxkITMam1P53xF6mZeE7+PvhUgeSKeOn6v2Xk2UsTKKOiTfeFPaP7Qn5EbnnX72p7ygdKISwRU7/2fYSJlkLSz+h+B9r9dRgjSqmL3OhnVev3uRVDKa4ah9963+fdFbpU154lEIk+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103161; c=relaxed/simple;
	bh=B6OeqtqWBo0PfpnDBhofjSJ7RM6SDlx6t4i5j2tXE7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIbsbGTDRDII5EebVDzagD1y+rYWocCyOt6uFOIKAj6czv7PkFA0xXIWo0OiwrS9tXB7dz2NNwsVBVxJvctn2ddLyRC7wuyN5mWhVF6n3zgb5Y3JtWWnPJ0OZhzf11DLgfJex64GxKOoJolZnVQ2vjPAMuCYBNd6PNrQfkCSg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ZFaiRStr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a/5nVvYP; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 873891D405F2;
	Wed, 20 Nov 2024 06:45:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 20 Nov 2024 06:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1732103137; x=
	1732106737; bh=r/1fPo+FOJmczrt6BitCLunrDP1g1sSdibRAZT07RXE=; b=Z
	FaiRStrIE7AXybC8Yqv6Xk98aF5qzCE8e+1H9e4Kqn/kACgySb+c0Wtl2QEjY2I9
	mFLNqPuSlzpKWq9QVldY3RIcon1p7nYsLhD+8qSGHc6fukduV+Pjwux5JkK7Dp+r
	7wzPPKxJT92WtMdSmeF5CcRTh2DnzQuUHPF6N6AG+ZfuGpyLeseziCjjVxH5B5uF
	YtnfMTmHhWJziWmH9409Y71Mu/r69TIdOXnbSyCbiGYSjt0EJjTK13OlzQG1M/F5
	8CNBxFcrglbe1t7OFUZ3b4al0xG5i15d3uQd04yKS5k/U0f/x6z3t8VhYaRRdm8T
	RmxLs3DuTVyzQx9vWwsKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732103137; x=1732106737; bh=r/1fPo+FOJmczrt6BitCLunrDP1g1sSdibR
	AZT07RXE=; b=a/5nVvYPgmNnFFL46DWAGeSpTEW5a1PrrwgTnLPLtha3ZOO+Jcw
	7aSbxeyqjchMdd/ojS0bmG1n1ldnUjryZLwopm3gNZjz7OioBhSgM6KgBw2S+4MH
	Aws7QJv7XFvugcTezaAKA0zpxKJ4370I7v9V153vJLiRIAAx9O0PEC/45t95cTXV
	xnEHTCBb9xacnxT2EJbV/wi7F3Qksil8RYR2FQY3ksovkVojTg2J305tJMn7NHn8
	E6Zqv+w66zkLEKrbEXEGg4Z4YFctni0X2+YpiEDZQnPkt9eLaMw06Rjb6EZ/7+i6
	A1/3rne+dj6CJJcLmIu/4rudnBPDKMYPJww==
X-ME-Sender: <xms:4Ms9Z5hIQvSWD9YdKEBwndjC6YWJrUkppyMX6a4T823adK6DY61O6A>
    <xme:4Ms9Z-CUh5FGwpgz8tvggd781VsyMmQHUZEQ3dJAXYOHDY-oehHZOxKgFqo8sQatF
    XbBSBJ50y3tADtJpVw>
X-ME-Received: <xmr:4Ms9Z5H7WzxX2n3IyYr-0p9kgGNQUYJstnpAxSkKmBwCtjf32j5uW1n-RtO2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeeg
    teehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnih
    hosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhu
    nhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4Ms9Z-TOvUMySf7QtRXc-5w5vA8UuMPmLa85H4WJkMXna7d4R1n2Gw>
    <xmx:4Ms9Z2yzJQ5FC0PH0Pyot-j5qntIFyeylk8MWCD3NrQDG53EUi574g>
    <xmx:4Ms9Z04Jt3XaFcN2kSZ6N7FOkgzlUyJ7BNq0kEDsT05w8iOzK8OS8A>
    <xmx:4Ms9Z7yb0Due1OONB-44nDgvxu6nEdRoKyfT9hntBbgfZohLk4GBjA>
    <xmx:4cs9Z1nqtKAI5OOKA2rMpS2nL8Phgx6I6GUNiccKJmekbwJZyr1zzfpr>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 06:45:36 -0500 (EST)
Date: Wed, 20 Nov 2024 12:45:34 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 08/23] ovpn: implement basic TX path (UDP)
Message-ID: <Zz3L3lnmcgbdQDqn@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-8-de4698c73a25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029-b4-ovpn-v11-8-de4698c73a25@openvpn.net>

2024-10-29, 11:47:21 +0100, Antonio Quartulli wrote:
> +static int ovpn_udp4_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
> +			    struct dst_cache *cache, struct sock *sk,
> +			    struct sk_buff *skb)
> +{
[...]
> +	if (unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0, fl.saddr,
> +					RT_SCOPE_HOST))) {
> +		/* we may end up here when the cached address is not usable
> +		 * anymore. In this case we reset address/cache and perform a
> +		 * new look up
> +		 */
> +		fl.saddr = 0;
> +		bind->local.ipv4.s_addr = 0;

Here we're updating bind->local without holding peer->lock, that's
inconsistent with ovpn_peer_update_local_endpoint.

> +static int ovpn_udp6_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
> +			    struct dst_cache *cache, struct sock *sk,
> +			    struct sk_buff *skb)
> +{
[...]
> +	if (unlikely(!ipv6_chk_addr(sock_net(sk), &fl.saddr, NULL, 0))) {
> +		/* we may end up here when the cached address is not usable
> +		 * anymore. In this case we reset address/cache and perform a
> +		 * new look up
> +		 */
> +		fl.saddr = in6addr_any;
> +		bind->local.ipv6 = in6addr_any;

And here as well.

-- 
Sabrina

