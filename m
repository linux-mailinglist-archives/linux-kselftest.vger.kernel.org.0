Return-Path: <linux-kselftest+bounces-22760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D37AF9E270F
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 17:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA79F162D65
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088A41F8AC1;
	Tue,  3 Dec 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="QyT1FJ2U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lnJjani1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D21F890F;
	Tue,  3 Dec 2024 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242617; cv=none; b=Ll0yAA27QYAzZpboVADlzItG/Ix4t773FZGJLXpS43hFb/9hwecxYbhqc5BdIQMQHOS3+Upc6FPDpBzA3PHn6gCbilyUwtmsFWvNaHbULURYDe+DYFZfCF/2rA7RQHgeEuOx/PcSNXMhDrXXL4FndocelrenA7gnavCBGNwT/2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242617; c=relaxed/simple;
	bh=8bO7rPiHqGcj8rgFexgowDvFuLShceURQRePFZyB4cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cn+b1zQcfB7j1I7D/Jw27SFNAoIHoJ/Al/9Ga901TY/xDEEdXThaUAoy5wtZAvq/cOqVSwD2GJ+Q9sUvFkjmPmQwotQ2iABG7SL1Ce2RvCm/TeXkgO6I9HWYdNbq2K4kbn/4w8Ad3H8prraBAq+YLs1lgEWjoideL/QpbUT/KPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=QyT1FJ2U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lnJjani1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id DF70613806F4;
	Tue,  3 Dec 2024 11:16:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 03 Dec 2024 11:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1733242614; x=
	1733329014; bh=soA7+8FQO1KKs3kc6J6D1x22RsRkfzIXVBpqgSVfyn4=; b=Q
	yT1FJ2UB006TGQDLzfz6pxPOKKgVCVDna6/mBbqeOoMd7TEc0FpWOpq5gNC3k4wY
	BRs+jfIEwj1HWvjV7o+vURqytprp/zp0CQEDgtpdxAk5IlxPEj5sQiYKrh4FRjs7
	gFEzWB/NvygoIRvtxQgxfH0CCQTK0Ff++1OAmldSPYazSvMoYTeBrnT3if1oHnu0
	/4oDg9frneTebCJnJiNFMln3PRCFTYYmg9fLjRVXq0SFMBXcif6ExHOQUhbwflqX
	kh1ABS/Sg4w8ndYTPbzuExKIvggmzF4wai4FH5my7oyl6riIXEutY+6LioTIPYuI
	D8qknvWExZACPxUSXbTIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733242614; x=1733329014; bh=soA7+8FQO1KKs3kc6J6D1x22RsRkfzIXVBp
	qgSVfyn4=; b=lnJjani1FdFQAz8Xah20ibLcD/8VizGfvnmzn3JPIwHu8FwdG6O
	RtgDNJV5ZR7cLv0107ZfO3jciLxLJUlM6m2uegQ1AqSX8HzOBPumGF2iJNVP0nvP
	6Th9+N7QuhOXsxHtwKdAhkUL1jVmF6tBA6clq7ulAFHjwsSZqG4l4CxUw3/6k1tt
	aZ8Hx6CuKOixmXSFEvHfNODFHesH+j1sDAUA3e1FXvcgJUakfKJupxOnqbzBiaP9
	iQUwYd1Zv7FDXEWvIPXehgUVQhxfm9Te2uYm8GccbvNyoR3w6/JajYglGyXUNvZQ
	F6Y691xUk818ZuBpYtlbXdgLGzgO4uj2vGw==
X-ME-Sender: <xms:9i5PZ4YIiorGXqMXrMZ1_F-agbNPBPV08BIbcWB9ua9JLgVllDessw>
    <xme:9i5PZzYh7FfyCF1lrI7D-HbUfOU5qla6qsC_dky2sv_Yw8cqvAQzKWAkTYbbVE3G_
    HHlrbgv2Sdp10smd4Q>
X-ME-Received: <xmr:9i5PZy8Aif6W9tv3ORcBNUhzTLK3VyVtVn3ytzJs25oKHky4M0-scOs6pGAm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieefgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeeg
    teehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepvhhfvgguohhrvghnkhhosehnohhvvghkrdhruhdprhgtph
    htthhopehfkhhrvghniigvlhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhunhhi
    hihusegrmhgriihonhdrtghomhdprhgtphhtthhopegrphhoohhrvhhkohesrghmrgiioh
    hnrdgtohhmpdhrtghpthhtohepsghorhhishhpsehnvhhiughirgdrtghomhdprhgtphht
    thhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhope
    hshhhurghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9i5PZyq6tqjeqf-Sl__ztL-Pg_Trmgl-x3G85uwlgQIfxQQwNBqiiQ>
    <xmx:9i5PZzrECkia_IjbGcVRGvFvrr1o1eG6g-aBFVjNE8EcGF3A__pjUw>
    <xmx:9i5PZwRFQAvT3TuUXMb1oOhFmWokWtFHU9hBzwAW5Fj3c2cCcaXpxw>
    <xmx:9i5PZzqMrBJ0fRm_xgbCcGTuedOocInlvczLPc-oESvLXmjkSr_kBg>
    <xmx:9i5PZ854wzJTkG-feuTQiFVUf9MGQ_47jbk8Df5y-nvtGqyX5PpAs7xv>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 11:16:53 -0500 (EST)
Date: Tue, 3 Dec 2024 17:16:52 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>,
	Frantisek Krenzelok <fkrenzel@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Apoorv Kothari <apoorvko@amazon.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v4 0/6] tls: implement key updates for TLS1.3
Message-ID: <Z08u9FoNOeEbWSM_@hog>
References: <cover.1731597571.git.sd@queasysnail.net>
 <20241118194158.493e11ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118194158.493e11ec@kernel.org>

Hey Jakub,

2024-11-18, 19:41:58 -0800, Jakub Kicinski wrote:
> On Thu, 14 Nov 2024 16:50:47 +0100 Sabrina Dubroca wrote:
> > This adds support for receiving KeyUpdate messages (RFC 8446, 4.6.3
> > [1]). A sender transmits a KeyUpdate message and then changes its TX
> > key. The receiver should react by updating its RX key before
> > processing the next message.
> 
> Will review tomorrow/Wednesday but I haven't gotten to this in time 
> for 6.13, sorry :(

Is this still on your todo list, or do you want me to resend? No
problem either way.

-- 
Sabrina

