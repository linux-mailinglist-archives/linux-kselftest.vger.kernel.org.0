Return-Path: <linux-kselftest+bounces-21555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693C39BF9C5
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 00:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647DC283E4B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 23:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3678720E01D;
	Wed,  6 Nov 2024 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="AzXCI5i1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c3sGc127"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599DB20E007;
	Wed,  6 Nov 2024 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934846; cv=none; b=rR2pcINlL6m5uAuP6g6EHk2H4DUbbEir0+hXkO2zGJCnNGdtYzGkZPuVSxCmXvb4dMYhF6ouK+326oRPjiMKZL9caIZSX86FHGZ/SB1ZeLraQX9aDG66aGZUdszCd9Jy6CoZKiXoZyV51Y8zrs/k4spu/0uOH/VPsIVRQXkLzCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934846; c=relaxed/simple;
	bh=kKq4KLJjKTmKFq6HrrEGgHDZGi7jDEC/6JfZWh4tvS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acTRdxg1QrIod+j/FF9YP05+o2E0UMVxzBDupzhQII5tu//OL41f9Iw4Ag5+RRG0nQlMaOx2lrbZ33s5/0DOg+rdQiRIFnomwz/2SqCejwtD8uK9fwqontfv+EZltZ2KMs3Rr+bN3o9BrXE14+qbatZ6xHnP1RtuEMQk1CadTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=AzXCI5i1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c3sGc127; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 9A6F61D402D4;
	Wed,  6 Nov 2024 18:14:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 06 Nov 2024 18:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730934843; x=
	1730938443; bh=KDUuJiuTJX/7KApKXMYIprNbRPvf5XgGpZUgOUcww84=; b=A
	zXCI5i1npxPgsshAPkdYVHEeUhWdm7Fmj8MX2vpEnpK6rV6xb/ZRWaTmXKP5Zczq
	GVcsPLPE1XHUl7RkHhYK95r/Pf6Tu7O4+9y942TqoRixfvyjEYF+fn6VA+X1HI9p
	fB+Q+ZZq3vKWhsKTEe34eJhq+H7TxojZ/kRPZPbpJLThQa9O3KYGNiWkoyuGC2rL
	cniXCdKqD+SBJ73+qnpoSQ3+t6XoME2o4iEb5UmBIAmC2yDFgzCSSaElu+jaBzfY
	rmWdKZUUw/s5HfhtaLw8Q8J4cdMBR4+DpRkmUEFRePUH8fFcDMTwvbMjAaFXIAZa
	Pr3gNRDjRmJzvnMDg/jYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730934843; x=1730938443; bh=K
	DUuJiuTJX/7KApKXMYIprNbRPvf5XgGpZUgOUcww84=; b=c3sGc127FG461wOw+
	I1LkcvIisXfzLTdzK3v5Eu1ueaMefNsCz+FYsO47j2zd87vzzXgIf/3OyPSiCPCO
	nWqcll8xqp2iuiVySF5lfP8NGKRZZkVk4929z4cAD3a+jMavmuBXTJIpFOnkUTBj
	BNeb1ivRgIqeVyWhtIQO3/F7SVOCAQfi5T7YfXO96EULvqYh2KApdJgQdcZvD8uL
	vFa34u/4INTicj6regASGjZgoFVB8Z6AKZLkLuKmups6Qk3AF7gSxM9FyCpcYuD5
	ER45uIvclZntzo0z6qCCxuYDUBGGIzRGhTyjRnjTjKnV5+XlFNnSBf7X+CnfRdgZ
	8slYw==
X-ME-Sender: <xms:O_grZ1G2WSEon3Udnd35XwCM-InLSsbLQE4N7hmW8UFMkCy3nhHz2A>
    <xme:O_grZ6WCoWWR0Lbi_eYaPfvfOMcfRK6dq7OQmKEVmQoM7MNgEuvzy1yMwefb31f60
    4H58nYZ3f5zbskO8YM>
X-ME-Received: <xmr:O_grZ3I2od7Nid1hplqvxv3gk2jauWz9IgdlLGQwWWh5ODCqIJQzThK8PYLV>
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
X-ME-Proxy: <xmx:O_grZ7EGivOf9ZK7tFWnbmFba-a2-aEoHIznzunGh6Axn4aNgxixsQ>
    <xmx:O_grZ7WjN5m2D2ls_HQEYkvfIG0EkMHLoVeYl-LY5xlrN0Khti5-jQ>
    <xmx:O_grZ2Puh5vkCQ-ZY1iejq5w-jGCahzi8Abn2l3FbkJAsnK9b1hOtQ>
    <xmx:O_grZ60D72juRqP3K4LVU-FfGUw3sNWj0RNlB1U9J0OOM9lQxGHE4Q>
    <xmx:O_grZ4iSzR-jDzXgfNima_wMFKQAmqKqMiHJgpAE_rX_yZc5I-i285N2>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 18:14:02 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 4/8] macsec: clean up local variables in macsec_notify
Date: Thu,  7 Nov 2024 00:13:30 +0100
Message-ID: <9b8996af518fbeb3b7d527feb15d5788495e3108.1730929545.git.sd@queasysnail.net>
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

For all events, we need to loop over the list of secys, so let's move
the common variables out of the switch/case.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index bee1e0f95d2a..e6670e876ff6 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4441,31 +4441,26 @@ static int macsec_notify(struct notifier_block *this, unsigned long event,
 			 void *ptr)
 {
 	struct net_device *real_dev = netdev_notifier_info_to_dev(ptr);
+	struct macsec_rxh_data *rxd;
+	struct macsec_dev *m, *n;
 	LIST_HEAD(head);
 
 	if (!is_macsec_master(real_dev))
 		return NOTIFY_DONE;
 
+	rxd = macsec_data_rtnl(real_dev);
+
 	switch (event) {
 	case NETDEV_DOWN:
 	case NETDEV_UP:
-	case NETDEV_CHANGE: {
-		struct macsec_dev *m, *n;
-		struct macsec_rxh_data *rxd;
-
-		rxd = macsec_data_rtnl(real_dev);
+	case NETDEV_CHANGE:
 		list_for_each_entry_safe(m, n, &rxd->secys, secys) {
 			struct net_device *dev = m->secy.netdev;
 
 			netif_stacked_transfer_operstate(real_dev, dev);
 		}
 		break;
-	}
-	case NETDEV_UNREGISTER: {
-		struct macsec_dev *m, *n;
-		struct macsec_rxh_data *rxd;
-
-		rxd = macsec_data_rtnl(real_dev);
+	case NETDEV_UNREGISTER:
 		list_for_each_entry_safe(m, n, &rxd->secys, secys) {
 			macsec_common_dellink(m->secy.netdev, &head);
 		}
@@ -4475,12 +4470,7 @@ static int macsec_notify(struct notifier_block *this, unsigned long event,
 
 		unregister_netdevice_many(&head);
 		break;
-	}
-	case NETDEV_CHANGEMTU: {
-		struct macsec_dev *m;
-		struct macsec_rxh_data *rxd;
-
-		rxd = macsec_data_rtnl(real_dev);
+	case NETDEV_CHANGEMTU:
 		list_for_each_entry(m, &rxd->secys, secys) {
 			struct net_device *dev = m->secy.netdev;
 			unsigned int mtu = real_dev->mtu - (m->secy.icv_len +
@@ -4490,7 +4480,6 @@ static int macsec_notify(struct notifier_block *this, unsigned long event,
 				dev_set_mtu(dev, mtu);
 		}
 	}
-	}
 
 	return NOTIFY_OK;
 }
-- 
2.47.0


