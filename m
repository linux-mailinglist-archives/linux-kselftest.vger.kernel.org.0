Return-Path: <linux-kselftest+bounces-25563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8427A25726
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 11:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1173A6519
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75047201027;
	Mon,  3 Feb 2025 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="i3OJpTQj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XBbAbb19"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4222200BA9;
	Mon,  3 Feb 2025 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738579365; cv=none; b=qhU/9Wn+SvFAl+aqt3OH+LuH9HnGtjhgy6GFIA0NS1jjBp0jXYVXIXHl3LjfVwREZi2YBTrTt1M6og/OLKpbJR87a3wGY9pfq6L0MY0z/zvm7hsqtzfF9rp2Nan/XCVlVnEd01BZch3NdhMCptFhzLp2ZeEV+NfnhAxOiOP+BP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738579365; c=relaxed/simple;
	bh=DE0gpgZ/ub5j8RsbC2DPJtJRNTHqAI4+w2AwsfWDt5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u30cbifIaWzRF/liw0YG4Nrm3VkgAMZbXSHoZKToutWmVB0+CSzkRUx1FmrkHsCcMfO98Txyb72pwUTJqmUBcTZvWQOnEYEFHaFi7YPs/B/N6A12bYXNMh7us4zxZ1nbUoBHoBuddxsoZqIcn4hZhXBsfP7sa6KRz4+RYCr5hLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=i3OJpTQj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XBbAbb19; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9318F1140117;
	Mon,  3 Feb 2025 05:42:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 03 Feb 2025 05:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1738579360; x=
	1738665760; bh=JrDZIg8kl++bbOSrXKc1PpuOQBd9Gmv1sfuYiaw2UXU=; b=i
	3OJpTQjS8RCKrE2bEDhlG0fTLNivCgiHcMILQRyU+iGFD0DJSJOcyNUp2nE2rtSu
	5wnMwJq3qSIaDT2+LCW8zqzEyIgWDA2y6mIK9784liTDSsMSlrsfop4FRsvD6v+p
	i6aAjPJHBnKti1z0YHYnh57Fg7H5JceNv9909WXK5sVQHVkVjb8iECwqDjayZxnu
	b+7chuejVmPo6Q2EmSivhKtzc1Y7gf84P3mTt7fyjE0Q/GhcQB4ainmoCOIq+0LX
	SVA0b3idzNiQgJGatELJvHSfx6jfyDY3DX8+jvxKBN9r889+Ac4zFtGBHsYDBm3J
	+yfaXFpUXKyJ/kKOnZPTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738579360; x=1738665760; bh=JrDZIg8kl++bbOSrXKc1PpuOQBd9Gmv1sfu
	Yiaw2UXU=; b=XBbAbb19RzkbDVzLhuX7IAQ1TmFqRGLtiax6cTka+ObmSI8+7/g
	osq+pizI6nZ4lC4hM0vKVM5VUm/xaptP4sz7VZeh8ROeGRiyi9MnfUs8IukTc7rp
	PuuIBkL2szkpajawzBvPhFFOfySJJS+pkIVM5gL0E//l5kKst6odhJfEOzl5OMpw
	HTv4S1QSZU6JpaGmR1fr6OeYzA3ec24y1MkYXhHKNIMtKgpcGU1smn/IROkERNNa
	uO43fdlK/XJPY6CSy2ez25rh6bbLmqt9X6447QDzZXRvUfANJiFsio/Fe2CeOHk+
	K5Pjy1ZgVWcVtea0xVgKM8fPTCsCRt3U3VA==
X-ME-Sender: <xms:oJ2gZxFkZm2iE-kXdbKddA-QEqRU4m4p1l3qXEjMJ0QyjBdD3xLXfg>
    <xme:oJ2gZ2X9IdhgvWnHTpydNZbiT2lcM4Z-RGkURhYzYTReYmJu8OyPD7K6A1H0BDT0k
    zZG11cWCANJBXizfAo>
X-ME-Received: <xmr:oJ2gZzL6nbaumGrjVIFmQ_8Dl7oe6VDDMjTkDMZBiEAuVzn1jySkKj9lZycd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefh
    keegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtoh
    hnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:oJ2gZ3HfB_cDs3Jh-XjhAhQGO2gOVnY0mGMyH0wfWJj_3QArm6xQ2w>
    <xmx:oJ2gZ3VtiXelJeVQ85MLyDrMwfZ_-2hqFP4IhcuxATiZulCAvQY8qQ>
    <xmx:oJ2gZyNVnTzFHUnLgKLE2TunybV2Z0q6ALFcf-260fRnW2RtV1cKSA>
    <xmx:oJ2gZ21DXHLFYl8RhgmmauR2cjSveTgh0u8moL_VIf8vvRklSXoiAg>
    <xmx:oJ2gZ0Vn9jui7dshc_ugS_ycbSXhS22_zbWLLwZvdqgDY61tsW-cru6Q>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 05:42:39 -0500 (EST)
Date: Mon, 3 Feb 2025 11:42:38 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
Message-ID: <Z6CdniZssuNPPqVu@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net>
 <Z5_6pC-zsVzukJs3@hog>
 <4a539c83-f436-4b1e-9707-64c05dcfdbd2@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a539c83-f436-4b1e-9707-64c05dcfdbd2@openvpn.net>

2025-02-03, 10:46:19 +0100, Antonio Quartulli wrote:
> On 03/02/2025 00:07, Sabrina Dubroca wrote:
> > 2025-01-13, 10:31:39 +0100, Antonio Quartulli wrote:
> > > +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > > +				       "unexpected remote IP address for non UDP socket");
> > > +		sockfd_put(sock);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	ovpn_sock = ovpn_socket_new(sock, peer);
> > > +	if (IS_ERR(ovpn_sock)) {
> > > +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > > +				       "cannot encapsulate socket: %ld",
> > > +				       PTR_ERR(ovpn_sock));
> > > +		sockfd_put(sock);
> > > +		return -ENOTSOCK;
> > 
> > Maybe s/-ENOTSOCK/PTR_ERR(ovpn_sock)/ ?
> > Overwriting ovpn_socket_new's -EBUSY etc with -ENOTSOCK is a bit
> > misleading to the caller.
> 
> This is the error code that userspace will see.
> Returning -EBUSY/-EALREADY for a socket error from the PEER_NEW call would
> be too vague IMHO (the user wouldn't know this is coming from the socket
> processing subroutine).
> 
> Hence the decision to explicitly return -ENOSOCK (something's wrong with the
> socket you passed) and then send the underling error in the ERR_MSG (which
> the user can inspect if he wants to learn more about what exactly went
> wrong).
> Doesn't it make sense?

Right, it doesn't matter that much as long as the user can see the
message in the extack. Error codes will always be imprecise. I find
"Not a socket" a bit inappropriate in this case ("what do you mean
it's not a socket, of course it is"), but I can live with it. In the
end the problem is what data ends up in bug reports from users
(whatever the userspace program prints), and what help developers get
from the kernel (the extack).

-- 
Sabrina

