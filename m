Return-Path: <linux-kselftest+bounces-26493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E67CA3336D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 00:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB6216381D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 23:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9186209F4F;
	Wed, 12 Feb 2025 23:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="YkDwFj7z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qT5MUOAP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589D82080F1;
	Wed, 12 Feb 2025 23:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403305; cv=none; b=FC3C+BXGVOai+DKawF1QzFTmKuL9ulB1BoBNsUTLI/BIgD7Ut9I5EuLM0Et/C8XK8CCQM7+hwMDdt6VQI7xHMbIUP5rEt1JmwceCFsSHj74VcfaWfotoTdLy8J0pH/QljzmS5ZtaZsk/8eN5opHstv3EpcgGY8CsfHvh0JHA/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403305; c=relaxed/simple;
	bh=K1wrqzeYi3Gta2Ad6p0k5kVGf+FW8XSmOwVIKl5mEw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxd26eu7LPNGkHRRxCuMUrnwMlMKDQxwDJDp9D9TRXEPR2jZz1pAhwzeViSu4EeBeRuvE5rL0XlMZK4ZvkhX7h9E3hxaqVRbcAKoww09VWNj7wFLJZFrZx7pHX+7NTzbETmMhYEZ1MaFStz9psWqj7Te/dNZ2FH5bCN9P7z/gAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=YkDwFj7z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qT5MUOAP; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4019254022D;
	Wed, 12 Feb 2025 18:35:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 12 Feb 2025 18:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739403300; x=
	1739489700; bh=PbkKzlIY/ac5i1RLKAU/cKM5GEAJQeB9Gs1wNfgY110=; b=Y
	kDwFj7zDOgOhJTQFpugxdpcPQFHKHbzX6YwSyo8tGDHlg7aZ5TKFwnE5ZGR7b/em
	CnUBnRa19erEZ9Gz7ZniXw9RbAIr0YlzzP+8uMVEkiYEhnI1U6lvkI6BO8y6lt6A
	cJRv1XuJZwyO9+FbdK9zhOq5JmL3VjCmzO6QrDR07eNFpGSg1SRYA+jpoF9OeF01
	xfStUlw+s6O/3oYD+keo/k56154K3AE6d5pCSpecfj1T7Cgu84vZyPSXnqlfGeVK
	dgGpOOkcfAMEtUwbpszuEffgeJ2TVmsr2x+vacdQIUyyr6zKzBsN1Gz15BZrNvlV
	OK/WZOo68d8+XtXHX6wKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739403300; x=1739489700; bh=PbkKzlIY/ac5i1RLKAU/cKM5GEAJQeB9Gs1
	wNfgY110=; b=qT5MUOAPcxTwVPQ2gsPzH9lGcMAVGzGVzhmrnhon1wWgfiW6I35
	90uz9BBikjS1wlqIqRjbzVKxmMUv/Nl77nPS1B737Ob0cTaCc8bQNqCV3B/mcAQ8
	dl8menE2+CvYJgSb1xFx3+mrZ/tW8afkSA9eNDHLTuKAFvHRlR5QBlUOX1sfq8xn
	iZZsj7Y8ElbJDXxJyniowY0S5dQZHzlKJS/ubzjQX8LeM9XoHFq8Zu8UdWh9LSXt
	/OrjCc//60aPJjEHcONj8EebbogEeg90HmLy8oBDpUl6qd5CZqN1plSJp4TEvxsD
	b2g9V6WDRSBcfFp9jJanZzHh8y/5El0evoQ==
X-ME-Sender: <xms:IzCtZw3rqAx5rxHLwLT_fNIyuLJY-DVAlwc2NkK_Qn3FDfwBavATUQ>
    <xme:IzCtZ7HeC2XUhIzmdKUa3Hm05r8VuL_jy5ffthEXTI3f3egEb--QjLlvuZdn8ogvJ
    _ldaiLtkGtg6OA-owU>
X-ME-Received: <xmr:IzCtZ44vrXCedy-qe1NA6HW21k3xZXkZ4z2i7BxJvCB7JpXbU1gT13FzlG6K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeghedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefh
    keegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtoh
    hnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:IzCtZ50_QtK3CAKotBK-DA6sOj-b2v79EAxn8aIJ8LR2LojkyqH4kA>
    <xmx:IzCtZzHoWxLJ69zRYhF0maXuwsDOHqzACoyLF_iluDLFKHPBmwrkbg>
    <xmx:IzCtZy9_0G9mC0KlOpuRSqC0ZieO-XHc0WCvUu78XjHWOMQdq1wGAg>
    <xmx:IzCtZ4ny-2GZQZ46RSCsaa8mKlmatb5CgPjhWY33R1tID2B0snakbA>
    <xmx:JDCtZ-lX_51eQsIxJ9_Hg7G61JuYSd0Ir82mhK42uWg0W_wg62IZXgtP>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 18:34:59 -0500 (EST)
Date: Thu, 13 Feb 2025 00:34:57 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
	steffen.klassert@secunet.com, antony.antony@secunet.com,
	willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH net-next v19 00/26] Introducing OpenVPN Data Channel
 Offload
Message-ID: <Z60wIRjw5Id1VTal@hog>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>

Hello,

2025-02-11, 01:39:53 +0100, Antonio Quartulli wrote:
> All minor and major reported problems have been finally addressed.
> Big thanks to Sabrina, who took the time to guide me through
> converting the peer socket to an RCU pointer.

Something is off (not sure if it's new to this version): if I use
test-tcp.sh to setup a set of interfaces and peers (I stop the test
just after setup to keep the environment alive), then remove all netns
with "ip -all netns delete", I expect all devices to go away, but they
don't. With debug messages enabled I'm seeing some activity from the
module ("tun0: sending keepalive to peer 3" and so on), and
ovpn_net_uninit/ovpn_priv_free never got called.

[...]
> So there is NO risk of deadlock (and indeed nothing hangs), but I
> couldn't find a way to make the warning go away.

I've spotted another splat on strparser cleanup that looked like an
actual deadlock, but it's not very reproducible. Still looking into
it, but I'm not convinced it's ok to call strp_done (as is done from
ovpn_tcp_socket_detach) while under lock_sock, because AFAIU
cancel_work_sync(&strp->work) may be waiting for a work that needs to
lock the socket (cb.lock in do_strp_work). I guess tcp_tx_work would
have the same problem.

-- 
Sabrina

