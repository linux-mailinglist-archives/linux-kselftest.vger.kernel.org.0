Return-Path: <linux-kselftest+bounces-22862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CF49E53F3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 12:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95E52810A1
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657B1202C59;
	Thu,  5 Dec 2024 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Ycqy5JqT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b0ZNbm/M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3075A126C0A;
	Thu,  5 Dec 2024 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398151; cv=none; b=RILyzKQdftkkoCKWlH6vsZB19inomz1AIRliMQwAPKmEd95TNLHunDu0B868L9S9mud5XVi+zreN7JJbFlo7QKe80EZGd3Y0bEMhmrDpsEMnpmSBZTZpTjIPMkUttI8Zo4Gdop3w2pNuaZcu8sOR+O3KZOYaN+io/qv+r3vOWBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398151; c=relaxed/simple;
	bh=AcZKoyX+fTpzWHOLeqNiGSmun+Txa5OpYZ3E1Dkz6o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL/39o3wAUfhQMUFhrSGOom5y59Cj9VB4KV49deIoD2h7/PkBKpvo9Ynuazmo2cSS19XeT+e8RYRmgiz+R5B/9Jn9wSGPsjgEYAoXihEEaUdrSFByB6e1BI9ue1e2M/CeYbBcM04lHu1vr3FLUIKMGxPmpaNwW4QE07Cbk/NH9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Ycqy5JqT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b0ZNbm/M; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D12931140229;
	Thu,  5 Dec 2024 06:29:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 05 Dec 2024 06:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1733398146; x=
	1733484546; bh=Y1RC3KTbpAMHvcOCgPVnTS9sxRcR1Xs58MefRx36B4Y=; b=Y
	cqy5JqT55G/JDle4Ho2FaWwbrs+q30aG90FHFXJJW0rWKDVtuk1DC09H6zLHPpoR
	RSb1ZO4GjfoC5b5+K/sHPACRNG2zJxl7ub3ely33LiebcDYRuoTC3rNOBWtzH0L8
	wkIdTOG2glY6XNXTdyRdBpxvOY+BwThG9fPt++YZ+41uKG8Ojz4c3r3WX0JLj2vZ
	jYSgj2hLwI2yM/gm1oqjIEvT8CQcqnbcb2eE6ilQgD8bEs+H0/u8WQ4vkQsunOQ9
	ahmk3OxjYa2PFVAHGLPf1Z8cIN/2yQLLES9uciBg+COQjL1DR/HcIUkuMuzm5mhU
	6CYvzTWK/JGYZlJu+cL8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733398146; x=1733484546; bh=Y1RC3KTbpAMHvcOCgPVnTS9sxRcR1Xs58Me
	fRx36B4Y=; b=b0ZNbm/MUw+opgqx4fRsGRGxDMFqdvSErvGcN1x8DgDR5RCN1kZ
	mZi7WqWkiLZJS81/J/QRAFQQ66LbgQeiJhCP3GGXju2wdefc/5f533xgbJzCMybK
	uKn/S+iJiBPkL+wUtcrVyn+76RN21+tNZmUANfNIyGOpTpA8KMxMzKdXJmrbweEN
	2B42XLqqaAl2nXFuTu0e7GChUh74oyN3y7S0DlAjEMnMVW01xK+zmuS5SFOaiS7v
	w6tV/Ezv+zI7Xidy/zBtIZhLuKxVl3tc21lEG0n/IO6/wV3dq8SFldtIyNKnz4M/
	jSFIie/gKDYLSuF7dErjFyyPabxEZBb8w0w==
X-ME-Sender: <xms:gY5RZy_N5M_8QUH_1GLJoXmUD-UmFt1J4XgxAZLPTdNLQnRrt0P4FQ>
    <xme:gY5RZyuzDUYVZ6qMgGAjsnJQt2XTqS9pTRwQkjYcelrpOX9mRtk0dRzvbIDu6zl3L
    78YNsiwRJOhFnwz0yQ>
X-ME-Received: <xmr:gY5RZ4BD0o-_3OJ5O2sjmGgACX4_wslrgnAZZWL9CQsei2ZUw9zFnfs5jw1d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddvjecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:go5RZ6cpD6TMsis6jmn95KfbLydlXi3t3I3caTHcymqEDx856GHSyQ>
    <xmx:go5RZ3OKGO6gyUFM_2yhljPMl2ePpXLet6j9juWXnKZN7RASFwxCTw>
    <xmx:go5RZ0nhwElzxnbDshuyDXzRuBq_sQf6-ClpDJNedL5rsXKvUSNrYg>
    <xmx:go5RZ5sTcSHhyEd5vulgARtR3MAI7Lezky-cK5UUr_lh79OoHd9niA>
    <xmx:go5RZ1twqajDU4AVMN4R5xJm8RAIZ6wFUvZ3pXt7A7BtpnBsqAEImffQ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 06:29:05 -0500 (EST)
Date: Thu, 5 Dec 2024 12:29:03 +0100
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
Subject: Re: [PATCH net-next v4 3/6] tls: add counters for rekey
Message-ID: <Z1GOf3tf1JUkh1Fy@hog>
References: <cover.1731597571.git.sd@queasysnail.net>
 <2f5b01548afb3795fb5f6aace6c2182ab98b9076.1731597571.git.sd@queasysnail.net>
 <20241203195414.5023d276@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203195414.5023d276@kernel.org>

2024-12-03, 19:54:14 -0800, Jakub Kicinski wrote:
> On Thu, 14 Nov 2024 16:50:50 +0100 Sabrina Dubroca wrote:
> > This introduces 4 counters to keep track of key updates:
> > Tls{Rx,Tx}Rekey{Ok,Error}.
> 
> Possibly track detected rekey messages, too? Could help us identify
> when kernel blocks the socket but user space doesn't know how to rekey.

Right, that makes sense. I'll add TlsRxRekeyReceived unless you have a
better name to suggest.

-- 
Sabrina

