Return-Path: <linux-kselftest+bounces-39771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB57EB325BC
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 02:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701791CE0468
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 00:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE6011CBA;
	Sat, 23 Aug 2025 00:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="Qkv3HLwc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UJQf4h56"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6FD747F;
	Sat, 23 Aug 2025 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908497; cv=none; b=T91Svrij6GGLblNjlXkaqtiX5sbR6SZKgxV9RIwfNXnE5LBFEmiFgUhKbZnQ3NEYiX29Ztp9/tfK4xDCYVsZlgJjBd9OrCeaSJkQHJd7RFxvK+CpfBdO9yvxyM8dqDPOcnS7ZUyHpgbGsPZr+k8AqraywWPfoGWY589VNMdvhfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908497; c=relaxed/simple;
	bh=LTJGD6JLyAaOd5JQ/zWVo7J6+vS/dumaengn/RMtIpQ=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Z1tBJmT63N6jYmdZV1zQo9z7Xg86qcyBYeXXQHWzUczQpolXBJPyKJgB5/oyB5vNnXScmFV14Ut8OIA4oN0Sok4yqL/0YiOwB6Ojx73iO1KXmOwOYBZw/TDewM3vO5q+COPOl8ZyAvNmTcEQgabuWTjwXIP+ZbmVp1JiTxy2PE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=Qkv3HLwc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UJQf4h56; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 42AD17A00D1;
	Fri, 22 Aug 2025 20:21:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 22 Aug 2025 20:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1755908493; x=1755994893; bh=Agxq40x54mBmQteI3c8NGdyKV8Zc84ga
	mL9f6v24gsM=; b=Qkv3HLwcwUM2R/YlrbCt74hzF/ct0nEQrBM78izlbEzwUJ3/
	cmwf+jObxAvvyE3+n9inhxOit4/dENfyjKSGC5Y3sWxCFHNi98Hb/wtxoYQTADco
	eKhZgHGQ2w4Zk0/EBt8Pzy0iU2yCPgd0fvnW+O3wLLiiE+ZCWcbe11CBmD4e4lfr
	UGyuLk1wtw1V8OhLzitmHOUIAqgNFTNjUihTODjF7cf1tFUS2gZZbA+i/I/km2en
	arFcxG/vDNwPw9eJPXDRKxcbwIHmtkWZSmsIeMKGFKOmHfzknvYjnL1tVISNbLdS
	WzlPtjGDJil6SYfBBcrk7DjvEtnHkchzziomWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755908493; x=
	1755994893; bh=Agxq40x54mBmQteI3c8NGdyKV8Zc84gamL9f6v24gsM=; b=U
	JQf4h56uExYOLPF7uSm1BuJ0l6EuL7Wc3r1T+9SnnmGoZprIJsiPE/7tyXrIZKMS
	ct9UtWw7CigaXgx8aVMqj8Wo15zXhF5PkTskK18jPNWq21RWj0fyNiEOOc6BkYYN
	hqgIqi0RR/+KrbCHnVN+SEHzepsqPdgLQv0UIOUdcdBtl72mdZoRtNldbh2Qr7FZ
	mDbtxBTY71q0jxQwLuCKfthGq9FBPS9UuSHeEhWfhgPpG/Q7qRu6ZsPxWrDbSicn
	Azh0OoZIIZ8BzPwSGdT+AvHh3g4fEUPB2JJf1YuWioJjB63l7om8YXJKwZdtR8AZ
	f9TwAtDr4+SiY5rTl7SKw==
X-ME-Sender: <xms:jAmpaNsaWJtZdvys-ICsIu_kIXpo2aFyGTty1F0JkMcueVmJaOvhAg>
    <xme:jAmpaL_HEj-wmPdO4LESwByqmM-B1nzd3MvHxkVKCM8QbnXho021zgKkxnoIzm5HV
    NewYajeG9VOYK0MQDU>
X-ME-Received: <xmr:jAmpaP13h6t_2iJMq7dTWxt-8v8ARiOqOG98zjtix427oLjWbO55-Kcy05y33xsz-cK5ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieehudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertdejnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepgeefgffhgffhhfejgfevkefhueekvefftefhgfdtuddtfeffueehleegleeiuefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrghdprhgtph
    htthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheplhhiuhhh
    rghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhn
    rdgthhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:jAmpaIhyUIt4kDmdgu_ZCef66D0gJCIuwND-9VmnLg1o3zVakVf3lQ>
    <xmx:jAmpaHZy8W-90cheywsy2y5OlGkCtIrFzicr06Jr5ICqj2WEH9rxXg>
    <xmx:jAmpaMXhW-yeJD1g-v-jOluwkpSMCzKtG9I_sNsbuxLwTUeOM5AZzA>
    <xmx:jAmpaHG-_4w2CppPXq461KDa-5Z2_Db1S2J2TdvRLjp7FzKy16wuMA>
    <xmx:jQmpaDUr5PyxvYW1378QmU5eQ1aog1QS3lXLPOnZnrw28xm0qUjH4Jbu>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 20:21:32 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id D11CD9FCA6; Fri, 22 Aug 2025 17:21:30 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id CDECE9FC83;
	Fri, 22 Aug 2025 17:21:30 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
    linux-kselftest@vger.kernel.org, Qiuling Ren <qren@redhat.com>
Subject: Re: [PATCH net 1/2] bonding: set random address only when slaves already exist
In-reply-to: <20250820091009.393785-1-liuhangbin@gmail.com>
References: <20250820091009.393785-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Wed, 20 Aug 2025 09:10:08 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Aug 2025 17:21:30 -0700
Message-ID: <1546564.1755908490@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Commit 5c3bf6cba791 ("bonding: assign random address if device address is
>same as bond") fixed an issue where, after releasing the first slave and
>re-adding it to the bond with fail_over_mac=3Dfollow, both the active and
>backup slaves could end up with duplicate MAC addresses. To avoid this,
>the new slave was assigned a random address.
>
>However, if this happens when adding the very first slave, the bond=E2=80=
=99s
>hardware address is set to match the slave=E2=80=99s. Later, during the
>fail_over_mac=3Dfollow check, the slave=E2=80=99s MAC is randomized becaus=
e it
>naturally matches the bond, which is incorrect.

	The description here seems confusing to me; what does "this"
refer to?  I don't understand the sequence of events that lead to the
issue being fixed here.

	I wonder if there's another bug somewhere, since nominally when
releasing the last interface in the bond, __bond_release_one() should
randomize the bond's MAC address, so it shouldn't match when adding (or
re-adding ?) the first interface to the bond.

	-J

>The issue is normally hidden since the first slave usually becomes the
>active one, which restores the bond's MAC address. However, if another
>slave is selected as the initial active interface, the issue becomes visib=
le.
>
>Fix this by assigning a random address only when slaves already exist in
>the bond.
>
>Fixes: 5c3bf6cba791 ("bonding: assign random address if device address is =
same as bond")
>Reported-by: Qiuling Ren <qren@redhat.com>
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>---
> drivers/net/bonding/bond_main.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_ma=
in.c
>index 257333c88710..8832bc9f107b 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2132,6 +2132,7 @@ int bond_enslave(struct net_device *bond_dev, struct=
 net_device *slave_dev,
> 		memcpy(ss.__data, bond_dev->dev_addr, bond_dev->addr_len);
> 	} else if (bond->params.fail_over_mac =3D=3D BOND_FOM_FOLLOW &&
> 		   BOND_MODE(bond) =3D=3D BOND_MODE_ACTIVEBACKUP &&
>+		   bond_has_slaves(bond) &&
> 		   memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_dev->addr_len) =
=3D=3D 0) {
> 		/* Set slave to random address to avoid duplicate mac
> 		 * address in later fail over.
>--=20
>2.50.1
>

---
	-Jay Vosburgh, jv@jvosburgh.net


