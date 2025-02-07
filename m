Return-Path: <linux-kselftest+bounces-25948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D6BA2B7B8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 02:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FFB18877E2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 01:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F1D4D5AB;
	Fri,  7 Feb 2025 01:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="N7OpDhCI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="df66N7m+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111082417EF;
	Fri,  7 Feb 2025 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738891180; cv=none; b=Fju8NGulFso+XAy3+/+iiBEZI9NrRYZVT3EWw8cNIMc4cgnQkzPG0h5D0TCfFDsNtMh80QHuZQAtV7XF+7xf5R5NNlklBaALwvYxkR/uygCSRO1RLfNNb8i29J1PKRJ6+yzF4Y6DPv1735MqT1Qu1T5y2a8jzU1QMYJUn/wiD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738891180; c=relaxed/simple;
	bh=KN6mFjpaqTVBw7J+oEKnqle3KzOzbwQRqtAiVjvxZiA=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=cPhiIOyseoV5QuZqBPFX0XPJSHVr+9BIQ1gumsh9uSTjTYcEEiICeOyj3rJOA6eQkXzj2m3hH4/iVtR9+LvHyzrn/uFqpkYZtPCbDGx9rPVzyBP/PF5n7EvK96Jw9URW0m9md5223VV+YPnTKAokvTuk7B05BVFrnx7BBgpgsi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=N7OpDhCI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=df66N7m+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F037E1140217;
	Thu,  6 Feb 2025 20:19:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 06 Feb 2025 20:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1738891176; x=1738977576; bh=nM5RR7pVDpPRZWTwREsGw
	zpq8Pw6RX8jNoRT+vRn0tE=; b=N7OpDhCIXK5uHXT/xymgQ9g8YeW13I9BEBZ9g
	uPbzc+GmvpyvEs7AmuloiVeoC8vhPNdV6Jjacfj88zSIaW1EZ51UulhMZZTnz8m6
	15XVmdvALO4ZJcXtXrZbg6igk55FE4tHL4a4kkHKOveuDO8CLSuz3Zo9r1IlFDyo
	MmXgEp9pWx6Azuas+c2wi+KuZzIcbnoPPI810Xr4tZyWNNhl42uxvt7Rh3lhEXFj
	sxTegQhVnJxRue2VvYhHf/S9EEwLbE5sECvIztfPylFcPlatJOra+j7XH1TNa1ir
	ROVTcCdjhUu0zTa5BhXHwu2RS1+FamRUxkyuXo69geoB7X2Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738891176; x=1738977576; bh=nM5RR7pVDpPRZWTwREsGwzpq8Pw6RX8jNoR
	T+vRn0tE=; b=df66N7m+bqR9HJ0VIYLH3uoC8fzk/c4i04ara7vRbUrScMRd7+3
	5ikfobG1iykN5bJ/eBM3yeFkz6VE84F19Ho5GlT2sA+RcMpXabwHST2DU+g1P3c9
	J47C92GGHJ2bxKKrqF5m2pfxhr8bjRcSedp3Nocil6CKrQlQH2Zb6OkDRy6u/Rl1
	NVWoSCLEPRtTkTrbPsBfrRFUxw6PshV9156ZKxZ6uv9U6pj/BhsR5jhsUdvzPu3B
	9m6Ew2D3rGKqa3eG6k4sUAu6kDnCb0Uvn1OJSDqv3gFgyr2WmjOs6Qeqap8mty6a
	GVTuXOlFJGc7MgFph/qmpQmF0ROi94POP7w==
X-ME-Sender: <xms:qF-lZ84iFZrW9tb-KW9H4ldlnFAVabJqovzws6kFxVP1PbTebDMlFw>
    <xme:qF-lZ94BI5pN-msy4r0gdZts-spE_Q_l4KaNK1K5dScqPDMwUmjZXGlCuycfzm7F5
    PN-bK4d9IBtNRMvNdc>
X-ME-Received: <xmr:qF-lZ7eXnUgVtK2gxypF1EwG65BzUVMPxLYoNtROoc_u2bvvT9VEhTKJCyyutOY32GZWQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhfogggtgfffkfesthhqredtredt
    vdenucfhrhhomheplfgrhicugghoshgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrd
    hnvghtqeenucggtffrrghtthgvrhhnpeeifedvleefleejveethfefieduueeivdefieev
    leffuddvveeftdehffffteefffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgspghrtghpthht
    ohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrgiiohhrsegslhgrtg
    hkfigrlhhlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtghomhdprhgtphhtth
    hopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmshes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgv
    fidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepsghorhhishhpsehnvhhiug
    hirgdrtghomh
X-ME-Proxy: <xmx:qF-lZxJv_1QqvaG3_PVHE_tUuOx_8HSSon8COsL3br0CneBccCE7Qw>
    <xmx:qF-lZwI7aOvUq2OyvORL1RP6NqzxJIMl6EIWCZ5l4DgGciJPziEpGA>
    <xmx:qF-lZyyII4POJE9YZVBh6R5sxxCjuAmyPHe0FELvLWFVyVlJu6GfFg>
    <xmx:qF-lZ0IUpuU93ALE4_M2sDDHpZxLi_gHFVvBGvmbCeQDIa4lHPG00A>
    <xmx:qF-lZx4nruX6811yxh_FmcnVygtGCvUc24oT6ItovWu1Cm4yPRxDXN4A>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 20:19:36 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id B13239FD35; Thu,  6 Feb 2025 17:19:34 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id AE1DA9FCB2;
	Thu,  6 Feb 2025 17:19:34 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
    Boris Pismenny <borisp@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
    Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net 1/2] bonding: fix incorrect MAC address setting to
 receive NS messages
In-reply-to: <20250206094600.357420-2-liuhangbin@gmail.com>
References: <20250206094600.357420-1-liuhangbin@gmail.com>
 <20250206094600.357420-2-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Thu, 06 Feb 2025 09:45:59 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <624904.1738891174.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Feb 2025 17:19:34 -0800
Message-ID: <624905.1738891174@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>When validation on the backup slave is enabled, we need to validate the
>Neighbor Solicitation (NS) messages received on the backup slave. To
>receive these messages, the correct destination MAC address must be added
>to the slave. However, the target in bonding is a unicast address, which
>we cannot use directly. Instead, we should first convert it to a
>Solicited-Node Multicast Address and then derive the corresponding MAC
>address.
>
>Fixes: 8eb36164d1a6 ("bonding: add ns target multicast address to slave d=
evice")
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

	I think this now deserves some commentary in the code.  Not
because this function itself is unclear, but because there's the
similarly-named slave_set_ns_maddr() (singular, not plural as in this
patch) that will behave in a subtly different manner after this patch is
applied.

	The "maddrs" version here will convert the provided IPv6 address
to the IPv6 solicited-nodes multicast address (RFC 4291 section 2.7.1)
and thence to the MAC address, via ndisc_mc_map(), whereas the "maddr"
version uses the supplied IPv6 address directly for multicast MAC
address conversion.

	Assuming that I'm following that correctly, I think this
distinction deserves explanation.  And if I'm getting it wrong, then it
definitely deserves some explanation.

	FWIW, functionally, I think it's doing the correct thing.

	-J

>---
> drivers/net/bonding/bond_options.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bon=
d_options.c
>index 327b6ecdc77e..63cf209dcdc9 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -1246,6 +1246,7 @@ static void slave_set_ns_maddrs(struct bonding *bon=
d, struct slave *slave, bool
> {
> 	struct in6_addr *targets =3D bond->params.ns_targets;
> 	char slot_maddr[MAX_ADDR_LEN];
>+	struct in6_addr mcaddr;
> 	int i;
> =

> 	if (!slave_can_set_ns_maddr(bond, slave))
>@@ -1255,7 +1256,8 @@ static void slave_set_ns_maddrs(struct bonding *bon=
d, struct slave *slave, bool
> 		if (ipv6_addr_any(&targets[i]))
> 			break;
> =

>-		if (!ndisc_mc_map(&targets[i], slot_maddr, slave->dev, 0)) {
>+		addrconf_addr_solict_mult(&targets[i], &mcaddr);
>+		if (!ndisc_mc_map(&mcaddr, slot_maddr, slave->dev, 0)) {
> 			if (add)
> 				dev_mc_add(slave->dev, slot_maddr);
> 			else
>-- =

>2.46.0
>

---
	-Jay Vosburgh, jv@jvosburgh.net

