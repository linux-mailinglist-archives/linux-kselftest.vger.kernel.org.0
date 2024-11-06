Return-Path: <linux-kselftest+bounces-21552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805479BF9BD
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 00:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AEB283E66
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 23:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6657320D502;
	Wed,  6 Nov 2024 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="n6vga4Zz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BkOcVq7S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D512E20C486;
	Wed,  6 Nov 2024 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934840; cv=none; b=H1V5iycyjmYbEZ069hBOLc28trSJFY2zx7CFVyMrncBTL/4EO+KudlJGVmWC6m74kMduFFVfnKHsSQL44+BwZ8vCHbEylLQqXCJc3fYuGrP3zkVyFKhdX2whv/4wUgEP88JngN6YVY+uhxUgBnq8DoFR2nR/lqIZc5Xj20gAeC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934840; c=relaxed/simple;
	bh=Jg8DlNLW/4b17xL7jXfLIlYMmo0k6NM4LTyfCHEHfG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBvV8ogcq2bXEH0lyOuBagElfwYMDi943M+MH5Ktpu5K1LHp/TiU19kIyl6j32MJJxb/V50EHBZIf/gRWkq5L9u16rp5j6LDK0Jh5ETplsXUk8mckQaOIPBh30CB7KcjDTn2yEtWmzgX5NgPCPnr3BM7kzRdsHa0fWX8r/hzij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=n6vga4Zz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BkOcVq7S; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id A5C631D402E2;
	Wed,  6 Nov 2024 18:13:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 06 Nov 2024 18:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730934836; x=
	1730938436; bh=LGzjYxQ5oSC7YQ/kl9JMaZyCqYUBuAx9f192esgcnHM=; b=n
	6vga4ZzsIgTlLqwTzrg0X5ZGVL5TZQKd+VZwRGazFSj5rU0S6UPFVha5n9hPXe6e
	nLeE1rWreLHESffX9ojx3kL995PMYEvRb4VmwqhJxA4DyNQr/f1rSon4Ud1I6Jv6
	dfjVOk1sdfPoBhfimQBZxg47UfefzBMqO7GbwWqDABBFRvMlxlIX4F/zuH0cRENH
	8MnnKQcpztAw8hQLquxIFPq+kCSVMLSvf9p60+tpMnEyO4fmbZvhazLpSBf9p3Ae
	mTDfs0xyLhrGzhIlwHl2rBIye+EH0j3tmUcgWhz9O8s6NUicJWukO9h8AI1iNudU
	8Iv6f5MhM3EDLx55Ce7zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730934836; x=1730938436; bh=L
	GzjYxQ5oSC7YQ/kl9JMaZyCqYUBuAx9f192esgcnHM=; b=BkOcVq7S1pzjhhEtt
	KbnxGz3xalA+VqXz2Kp1E9Ohl2wy/W6dqTH/h6gHN1IkIte8wVvltByBYrm0FnOj
	DGz8Gk03Hy7JjwV1ch/Hfxee1f5S4cxcdGEUTZLZ7/R8hFfY0XxNzGqfWHG49dJx
	YGrtfwVy39Pd9QdfCh8OlzI7KKYcD7lkoBxinpOTeoHIWrc2YMso9XwcMOmNvHk/
	k1bxR6pB5kkWTIlZLZR6Jefvue2bfoNSspX9ky9vMBI0cSF0YNj/Nw1aGzW1Mtrq
	Y3SOiJ3JGqguepiQkhZGtUFXQ5PlidYPdJplRONh7KSLO5H3pUZ/UnupZRcv8nRK
	6cRdg==
X-ME-Sender: <xms:NPgrZwZtzVEwVZ48AQWaB987BbbDUKekSPuFH-DmO4HZf_dDr4pPXg>
    <xme:NPgrZ7br6GHn9sywP08bRGgRk9cB27Z8kirDqaK2bIKdqf81E72_2iWTz5jS9kil3
    1a22eLyewcpRCVGi44>
X-ME-Received: <xmr:NPgrZ684GgtGgVKxKhkqls1EgqQEqK0PpsSQH3_1j7ylHOeuhfSF_tQePMOF>
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
X-ME-Proxy: <xmx:NPgrZ6rITpH-p2Wf9uGVquadow1pHqZLKoZNL8MWmL2BhpshO6B5Wg>
    <xmx:NPgrZ7rwz0sk4qTbW4566oR5ujTLyZSvBm-6HW29McJSrLnGJdYWAw>
    <xmx:NPgrZ4Q3L9JpIUTh_uAHt7znNuNJfQyvEoK2XBWEa-fLrhji-vq45w>
    <xmx:NPgrZ7rMSAJhGB-ZQJq-sPfsNpGJO6oIaEhZmrG79nvA8XTV_AwW0g>
    <xmx:NPgrZy2b_vnXQb84yVRGKu4MqG6N_LHSZsB1svfY1KwrePhDaJLJkUBs>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 18:13:55 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 1/8] netdevsim: add more hw_features
Date: Thu,  7 Nov 2024 00:13:27 +0100
Message-ID: <b918dc4dd76410a57f7516a855f66b0a2bd58326.1730929545.git.sd@queasysnail.net>
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

netdevsim currently only set HW_TC in its hw_features, but other
features should also be present to better reflect the behavior of real
HW.

In my macsec offload testing, this ends up as HW_CSUM being missing
from hw_features, so it doesn't stick in wanted_features when offload
is turned off. Then HW_CSUM (and thus TSO, thanks to
netdev_fix_features) is not automatically turned back on when offload
is re-enabled.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/netdevsim/netdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index cad85bb0cf54..0be47fed4efc 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -663,7 +663,11 @@ static void nsim_setup(struct net_device *dev)
 			 NETIF_F_FRAGLIST |
 			 NETIF_F_HW_CSUM |
 			 NETIF_F_TSO;
-	dev->hw_features |= NETIF_F_HW_TC;
+	dev->hw_features |= NETIF_F_HW_TC |
+			    NETIF_F_SG |
+			    NETIF_F_FRAGLIST |
+			    NETIF_F_HW_CSUM |
+			    NETIF_F_TSO;
 	dev->max_mtu = ETH_MAX_MTU;
 	dev->xdp_features = NETDEV_XDP_ACT_HW_OFFLOAD;
 }
-- 
2.47.0


