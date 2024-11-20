Return-Path: <linux-kselftest+bounces-22348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71669D3A87
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 13:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913621F23B34
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 12:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF391A0AE9;
	Wed, 20 Nov 2024 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="qY0Bw2k/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HOoQOQtc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8DF1A00EC;
	Wed, 20 Nov 2024 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732105026; cv=none; b=jI+gaB3lF5e4m7CC/oNVDUpp9AJD1b1OD0G634/8XtAEvV9bQRM9dmmVXtvjdtH1zYBbrPiRJVqvvyLCgJEKnLP7EgexOfFjvWJ7+SKH/XFxE/znuieZxKkO3vyi5K5x1J0k7g8TMCJEf8StRtPzDjrR6vXHIsHi+skymvQtzDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732105026; c=relaxed/simple;
	bh=xppnjPqrvhoerBzopeX8R1LH7VW4ackbG9x/TnTFAbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDC88NaNZLHdc6OWepRWV+FSOnN+w5iT8Ibl5gt9/dmPEQdI9epX0jk3+gJqcn22JgEW8DfUM5+Gi6RXLFkfUQEgpwIv/0ixEKJWb5Oux1O2n8/gfLXvZSlrdGx0yCwM18t5HTGeUksLEIQVtGKSdRKwIH77+QSVsHYdp4VJL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=qY0Bw2k/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HOoQOQtc; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 664AC20062C;
	Wed, 20 Nov 2024 07:17:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 20 Nov 2024 07:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1732105022; x=
	1732108622; bh=vZVutuXEb1XYsMhVjUw558rkRrLgw9D1s6JcwZMWDvU=; b=q
	Y0Bw2k/4epLtl0RenkcDDqmdeZ5hkHDuAQSQ8gBFcRgQLRQoeuUu3nzO0jBZoN48
	rRFtjYjC+CkaBabqua3CjDdj24zNjTOrCs/ziJVGKm1fZhzUm+Boep/A78Iv1BYp
	xhCmGVPXfLwOxZFiK6iA0ARsY0qxTxQ9iIYftV+oM9OHTKMMsXKhPPeI+ddjp2bU
	+zVvUTWTdnSm/9R6FtAMU7djuRk6Q+4Li1DD4nb66x70JVsv86AfBNHO0YSsq9pp
	3Z9DcoMhmlnjhG4rO8QEh6252AwffPxCFNNlOh84d1xPplDqCpeR2jC7aKJnsOMf
	adkxBPthp12qm24PVVZeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732105022; x=1732108622; bh=vZVutuXEb1XYsMhVjUw558rkRrLgw9D1s6J
	cwZMWDvU=; b=HOoQOQtchL5TiOTbbAmiGuyzjZzV4d0ygOUnKcDG2Cc+OyhcPD5
	QDrZIuPwgrW16clvUz15HYsBuPMGfVvNlHzvqG78GWo5XvMD8pqKobyxm1+h8XgN
	wUMIMfDqrpcM23sL5w6PmkWNJ/tDbNkZmtZjrn8yTd56TFCroHhoCYRj2MWqnW4Z
	JdVMnsTz/Mytvvcsy5hQHe3mEhv220Tp+dhBMpvVHkX4/saXwpjV77aEyisXhoka
	btDBcMH3/gb0dLIkHRrx9UP/k8BCh3p1yVui/q3MZA+W/Ei53Kp78NeEm9VWWkT/
	1qEnvhjHYlbXonsIIZxsGlcLcEQF8P/dRlw==
X-ME-Sender: <xms:PdM9Z2mdKVAv2XIJPMK60uYWcpDf4qm1Y_c2gx5K33i5PUrZ9OerLA>
    <xme:PdM9Z9135vfv-0UvluHyn1nD3X12NIhOIw9DJhhSvYTGuatQ3rtwLX29OWFyj_sOM
    zgt6S41daczpz9VeNA>
X-ME-Received: <xmr:PdM9Z0rv7bnTEP9iyAx3CkhRe8hX5PVZFO36MHncjJbEl3_zUDDgpWH216sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdefkecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:PdM9Z6nKZvjUTRn67IgSe-JJNfk9WtfgrB5roiiDhJf0tOfXqMDd-A>
    <xmx:PtM9Z03k57tfWNiK_rUPkWPNK3xBgXw9i3T76A_hOgh_R9mtw_HpZA>
    <xmx:PtM9Zxv_uxZ0ruNKS2Mc7z8vRgic6Rr6Fp0u9zfF2WQXMcBm-xnrfg>
    <xmx:PtM9ZwVyv57uSvSxUiPBROdVGTXPPv1n1KcKx5pioKgy_A60a2bRKQ>
    <xmx:PtM9Z1I-f3ZZBgDQ_vH7z-eMWRnm3FY6fDUcBNM0tDolDeJh8mkuJglP>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 07:17:01 -0500 (EST)
Date: Wed, 20 Nov 2024 13:17:00 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 20/23] ovpn: kill key and notify userspace
 in case of IV exhaustion
Message-ID: <Zz3TPLlpEwtAYu3V@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-20-de4698c73a25@openvpn.net>
 <Zyn0aYyPVaaQJg3r@hog>
 <816d8b43-8c19-4a4c-9e37-98a3415848b5@openvpn.net>
 <ZzS3jgNQoDH_0TvK@hog>
 <21330449-fab6-4c0b-a155-84c7419adbcb@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21330449-fab6-4c0b-a155-84c7419adbcb@openvpn.net>

2024-11-14, 11:38:51 +0100, Antonio Quartulli wrote:
> On 13/11/2024 15:28, Sabrina Dubroca wrote:
> > Around that same "which netns" question, ovpn_udp{4,6}_output uses the
> > socket's, but ovpn_nexthop_from_rt{4,6} uses the netdev's.
> 
> I think this is ok, because routing related decision should be taken in the
> netns where the device is, but the transport layer should make decisions
> based on where the socket lives.

Right, thanks for checking.

-- 
Sabrina

