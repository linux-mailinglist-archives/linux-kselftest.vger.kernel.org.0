Return-Path: <linux-kselftest+bounces-21554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D49BF9C2
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 00:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3165283D5B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 23:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E854020E01B;
	Wed,  6 Nov 2024 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ysiyjitY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W1vDD9yR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3049920D51C;
	Wed,  6 Nov 2024 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934843; cv=none; b=jQ1i4HolFchfWcHHQ6PP/mdA6mhU1b+zfYO40dcxJG2bJtewAAvlfkQ0KMULL4LkV2zv7qBqX8Btb1tQSIZoIYWplY2EbabuENs94fYXCvObJEYLqmEUYabfW8h3c8mpxBC5KsvARPqPfJGxtutMqnnGNkZDiZAlptG9tUD6pHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934843; c=relaxed/simple;
	bh=PzEKRaKnwG9+SFgt5c72LwJPgZhALhjfxLegVqSmEjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9lvc/+NoFPSVUuNLRsecLxsHWltNbLigWLyh4spJmwlnNGdF/esk0J+upq+94OeZmy6OxxFgkqqAfBo5TzbYISNlthtaIhenE32cUwbGfB4gpXtRsbyNGxE+65Vqq5gwOQM9jCSMiUCkAiNQaBvaP04gkShmEFS0BnIPl4PLS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ysiyjitY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W1vDD9yR; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 4F92D1D402E2;
	Wed,  6 Nov 2024 18:14:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 06 Nov 2024 18:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730934841; x=
	1730938441; bh=+vJXCnsZXFDib3W0Q9I0z7UGpSz8I7CpxDTNpx3UhsQ=; b=y
	siyjitYaAkEJFEI1g6MHlLR3zIoBG4zyQg5JrgQ0pn+befD6RUUYGbx448uogJsV
	JYCiS2H274BdTzNxTSapiCXnXY8h2P1E4je9WmJQ/c2fjwELxJKPhtargjDTYM5o
	VXMAf1f5TiWUULYhbd0NUKvIqwx8hVkyTOZiPS9d4bNtuj0CCgY6t302a2ikAZdy
	h/TRI+LhMtGcod9DYvOYJEE/DFGU49/pxZgPZU8cQ6DbbW2xJlkOcSJiRU6dPjRv
	jdS7kdUNi/ctxXJuoFY159ysqQ9C0zl+Ae/83tbNHEfdfpVlNDGdsdaY74rmEZyk
	LhjFiVo7E1r3z2C4q00Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730934841; x=1730938441; bh=+
	vJXCnsZXFDib3W0Q9I0z7UGpSz8I7CpxDTNpx3UhsQ=; b=W1vDD9yR8DCCDeux2
	aXfwVHr1fCeX5jsSR0d4FDDWsYHB7L6e4IJrqNQJha/Pdf0Tyh+RDTKmL796eLjs
	z/ZbmTwaSy8awiGEEwG+dAPnF1/40kJ6yKKkAzpUufD5vuUU+1FxMPKIvKd6oWUW
	4XqGV0pnHldO5QZcfRUkupaGi/u8H6Gw1iK3F9mpebGUHXx81dIeJgrCOnzGXiTu
	b8R1h5zjXTro3d987dC/IxC6W07Wek5fNG1utdX3GlCHwoOJO5xxEoHS2mXmBHSC
	RJNOOeEPlLeTURVyDxK09uHgoCI/usxn5lGvufnfQfAEbg0O8xR9DCc6O+CMAmw+
	Y/JqA==
X-ME-Sender: <xms:OPgrZwQGKaOgfHlipxL2un4lxbVR5nBdvq9h6hAq1Te-12hLiKdKKg>
    <xme:OPgrZ9xDhZ_bjiPRGNFtO8hPiIrTXTjCStto7kQHFxwP3O3tojL0JPWXgfqHJOgfO
    7VE8utiR4jlDCfnsfU>
X-ME-Received: <xmr:OPgrZ93k5fQ-3Z6yd40jNBvXcfmd66Psyf8pN1iVu6LRM7HiXtuhAK-hfPO5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdefgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhfegveeuhfet
    veeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrghshihsnhgr
    ihhlrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgv
    lhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:OPgrZ0BsILhPzwHlou84vGraNlyRZK99fioiSMENgn7quQkJ9Kc3FQ>
    <xmx:OPgrZ5hbUw6fuu8ks9dikuAzsgfHtwjgMzpRSD6ECAtrjyOxbXHeIA>
    <xmx:OPgrZwosz77YO7VgqNPfqD7tCf4uvFUjOP5Po2gDRpRbxLh8eYVvqQ>
    <xmx:OPgrZ8hNnBeEBnxJQgHohsMjMWQzyl7gxqwfemq5CPkYCXu2ZTZPmw>
    <xmx:OfgrZ8tDZQAC41SrAS_luikHcZlU_7Kc1e3cl-xp2FGJIrBuFKgOUvyT>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 18:14:00 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 3/8] macsec: add some of the lower device's features when offloading
Date: Thu,  7 Nov 2024 00:13:29 +0100
Message-ID: <8b32c3011d269d6f149724e80c1ffe67c9534067.1730929545.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730929545.git.sd@queasysnail.net>
References: <cover.1730929545.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit extends the set of netdevice features supported by macsec
devices when offload is enabled, which increases performance
significantly (for a single TCP stream: 17.5Gbps to 38.5Gbps on my
test machines).

Commit c850240b6c41 ("net: macsec: report real_dev features when HW
offloading is enabled") previously attempted something similar, but
had to be reverted (commit 8bcd560ae878 ("Revert "net: macsec: report
real_dev features when HW offloading is enabled"")) because the set of
features it exposed was too large.

During initialization, all features are set, and they're then removed
via ndo_fix_features (macsec_fix_features). This allows the
offloadable features to be automatically enabled if offloading is
turned on after device creation.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index ee2159282573..bee1e0f95d2a 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2666,6 +2666,8 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
 	macsec_set_head_tail_room(dev);
 	macsec->insert_tx_tag = macsec_needs_tx_tag(macsec, ops);
 
+	netdev_update_features(dev);
+
 	return ret;
 }
 
@@ -3521,6 +3523,10 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 #define MACSEC_FEATURES \
 	(NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST)
 
+#define MACSEC_OFFLOAD_FEATURES \
+	(MACSEC_FEATURES | NETIF_F_GSO_SOFTWARE | NETIF_F_SOFT_FEATURES | \
+	 NETIF_F_LRO | NETIF_F_RXHASH | NETIF_F_CSUM_MASK | NETIF_F_RXCSUM)
+
 static int macsec_dev_init(struct net_device *dev)
 {
 	struct macsec_dev *macsec = macsec_priv(dev);
@@ -3531,7 +3537,10 @@ static int macsec_dev_init(struct net_device *dev)
 	if (err)
 		return err;
 
-	dev->features = real_dev->features & MACSEC_FEATURES;
+	dev->hw_features = real_dev->hw_features & MACSEC_OFFLOAD_FEATURES;
+	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
+
+	dev->features = real_dev->features & MACSEC_OFFLOAD_FEATURES;
 	dev->features |= NETIF_F_GSO_SOFTWARE;
 	dev->lltx = true;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
@@ -3561,8 +3570,12 @@ static netdev_features_t macsec_fix_features(struct net_device *dev,
 {
 	struct macsec_dev *macsec = macsec_priv(dev);
 	struct net_device *real_dev = macsec->real_dev;
+	netdev_features_t mask;
+
+	mask = macsec_is_offloaded(macsec) ? MACSEC_OFFLOAD_FEATURES
+					   : MACSEC_FEATURES;
 
-	features &= (real_dev->features & MACSEC_FEATURES) |
+	features &= (real_dev->features & mask) |
 		    NETIF_F_GSO_SOFTWARE | NETIF_F_SOFT_FEATURES;
 
 	return features;
-- 
2.47.0


