Return-Path: <linux-kselftest+bounces-41005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 122FEB49D1E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 00:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5431898A24
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 22:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA64A2EDD74;
	Mon,  8 Sep 2025 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="lTKvbfh/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bgo11MHD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C0C2DCF4C;
	Mon,  8 Sep 2025 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371899; cv=none; b=k0x7jN8EuiTXn3xenG2FUz9jAKmALjDfInulPeSFQxay5cclrCelBPCWB0rL4QBTeE2kAC2JdwuPdX6Dn1fS9WLfXCCP4rNHlIC5TKsHYzNn7lJ8F8K6D5KHRZhok0wfjiJZtzfniib7j6zvdWobiJjixQXk9b42yniKdUfAF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371899; c=relaxed/simple;
	bh=PUQDiQIr5kBg3FsFnfzGhoYijFmfm6QlTxG4268++SM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Ts1g7znMyWjdOKYUvhWOOLVBjFp9Zk+0Dax8KI8kfFYDUgpH4moOBnz47WO1rKhJ8SYsKk6A3aPRemLy0LuPtXxkBLVeQNVx8QN0FX1dCBKRds5AUC4OkkgWudutq3kikAoIhI7jVAYGs05BSVR/zy9ly5g7zlhonj4LrTfWCPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=lTKvbfh/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bgo11MHD; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7CDF87A0094;
	Mon,  8 Sep 2025 18:51:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 08 Sep 2025 18:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1757371895; x=1757458295; bh=hoAxRJyXOMnsB0mKPob0+
	gpsSszdzYC1XPmYnOTPNu8=; b=lTKvbfh/rEbJcaRvNvV5cPVfhbQ+Ftsx6mxXI
	yr3TV7x5z27+Fq82JQ60OmGRuNzBycREOftOCVBjhiaKFIavmPK8HomMteLHrZn3
	Ute922wrtxFrLv1ss2ilBiUK1kYCiis8yYvbEiyeHpYCSiBEwSCB4GBqXWIs/z8e
	QEdzzDa5mfQy4i14fh1+HOxLEOeHo6pYSPbOos0ZZCrvt84DXRt9nQFa7KhMXdSV
	2ZEGAIVKUAfpX4uLmchffIezhECooeA9mxuq+yJ4TAi1Ou2ed0BAD3T2weALFtJw
	4B6jhUVYFBYhMAbNuc6gJyHYikzMr2iyI0b1A0uwcjIqmE1dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757371895; x=1757458295; bh=hoAxRJyXOMnsB0mKPob0+gpsSszdzYC1XPm
	YnOTPNu8=; b=Bgo11MHD/rDihzzrzBdiqywQ2AHkGEubc0a38ycs8UTHykIHRHR
	inW1iIAf0o8fy1BrhsJQob0OS0HTPfR4kIz3Jd87Il/MGSEqR0lKB4+kB0iJDf7U
	493yo19bhFpvcmachV7TfmMeuMxWcNiOXRlno3i6RO4W9AsQe5IkAJc48R0tjCCo
	s71/j4z1F19MWp+f9W6lBjnUiHKJFiNwCX/aoTLhXkkax5JaV903bBotjlBLoJJC
	w9SMVj1siQQgaxqpgltPVLKeuqyk/oR1NfxVlHq6WSm1M6aYAT6SlaTqd6Yw8Fqw
	AQIWl4Hd+qLc/Re8WziFZrcjXjqL6IdMebQ==
X-ME-Sender: <xms:9l2_aNQIBrSLEg_WarMTXmgdKXDMNmM0PY5l9f634-nXVWQPgDM0Pw>
    <xme:9l2_aF9Vu911JZpl9TNDCO4wNgG2i9TVPiVtDQSZNVGbuhdpJBc9l_V3pWTsWyTgn
    GyFmO5iLLsFe7-zKq0>
X-ME-Received: <xmr:9l2_aFgePIqfEumtze3tX9TmB2OUNhU0W5hV7MTZ6EMGvm7XfCywjiNvopYV2xj6dUXYGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvdenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeuffevvddvfedujeefuedugfdtgfdutedtveefieelfffhgffhtdejkefhiedtkeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggp
    rhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhm
    rghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthht
    ohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhluggvrhesuh
    hsrdhisghmrdgtohhm
X-ME-Proxy: <xmx:9l2_aOY0TfCWiHW1avegdRDIbzE6AsOsvul3x7UBN4MN97btVtNboQ>
    <xmx:9l2_aC9nHBmEruyz3JyIMWqoI8uhPmxV676KE4CI7p5LjLYOn-v5Kw>
    <xmx:9l2_aIO_ql0joqj62Qf-WYz4bJpBWOOE0xGqgqtwC_RjYw5KA6U6dQ>
    <xmx:9l2_aHEOhps-BoKO25NI8cyAcg7N8Q_F2xi6YHameEhy3HkkPm8bIg>
    <xmx:912_aF6VotxxHt6zBP7DYY9fgzRQJH2f8w7NADfxBK3ghJyhYmeP-3E7>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 18:51:34 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 4CC279FCB4; Mon,  8 Sep 2025 15:51:33 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 49D669FC6F;
	Mon,  8 Sep 2025 15:51:33 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
    David Wilder <wilder@us.ibm.com>
Subject: Re: [PATCHv2 1/2] bonding: don't set oif to bond dev when getting NS
 target destination
In-reply-to: <20250908062802.392300-1-liuhangbin@gmail.com>
References: <20250908062802.392300-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Mon, 08 Sep 2025 06:28:01 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2850155.1757371893.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Sep 2025 15:51:33 -0700
Message-ID: <2850156.1757371893@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Unlike IPv4, IPv6 routing strictly requires the source address to be vali=
d
>on the outgoing interface. If the NS target is set to a remote VLAN inter=
face,
>and the source address is also configured on a VLAN over a bond interface=
,
>setting the oif to the bond device will fail to retrieve the correct
>destination route.
>
>Fix this by not setting the oif to the bond device when retrieving the NS
>target destination. This allows the correct destination device (the VLAN
>interface) to be determined, so that bond_verify_device_path can return t=
he
>proper VLAN tags for sending NS messages.
>
>Reported-by: David Wilder <wilder@us.ibm.com>
>Closes: https://lore.kernel.org/netdev/aGOKggdfjv0cApTO@fedora/
>Suggested-by: Jay Vosburgh <jv@jvosburgh.net>
>Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Acked-by: Jay Vosburgh <jv@jvosburgh.net>

>---
>
>v2: split the patch into 2 parts, the kernel change and test update (Jay =
Vosburgh)
>
>---
> drivers/net/bonding/bond_main.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 257333c88710..30cf97f4e814 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -3355,7 +3355,6 @@ static void bond_ns_send_all(struct bonding *bond, =
struct slave *slave)
> 		/* Find out through which dev should the packet go */
> 		memset(&fl6, 0, sizeof(struct flowi6));
> 		fl6.daddr =3D targets[i];
>-		fl6.flowi6_oif =3D bond->dev->ifindex;
> =

> 		dst =3D ip6_route_output(dev_net(bond->dev), NULL, &fl6);
> 		if (dst->error) {
>-- =

>2.50.1
>

