Return-Path: <linux-kselftest+bounces-27722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE13A477F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 09:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF71188F097
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 08:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83521227EBF;
	Thu, 27 Feb 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6vCLNf8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B90227E93;
	Thu, 27 Feb 2025 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645478; cv=none; b=Q/q4HeQif9VIop6TVIy8pn1ms5/AbpeAzNVyUbLihXv7hAnszdsaru1wZ+z7wRc63iQitL4nengW+fr6tH71vPbGe9IuDwdXrOTEaCyxmqxseojxZ2+RahrL0jplbF3rn2Hz4+KEDkoaRF/hD//cYenLjD0ZWfsfKlaQfbEPHpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645478; c=relaxed/simple;
	bh=T8X6+cqBtkuVAKk3pMtV/Lw9jdJyonPED+PmS4Rf4Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LouqayzwwGVZIXnLuu+LOb65mp9afLf69oakLM4NLXywCYs5+UVnmfsghY2qPlhwHnpQgkqHNOQwfM/RsvrDGH0t84zJBQ+YGPkeCXdrp+9/cgXk/E31M0AJ4WODMtd7vnBYuP9+fgWn0GHxTc3Qso8sIWI0ZXPc1gapk51WsAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6vCLNf8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22128b7d587so11540815ad.3;
        Thu, 27 Feb 2025 00:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740645476; x=1741250276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXNNlRe00B5Yrlgkz+ksjLu5J1m0nU9Z2RqZlLitG9s=;
        b=j6vCLNf8RAI14rMBhSmfZOdwTYA0Yi4TuYc1hNSGIilmkK7bXHmqaJ6riIELBlP2c0
         DBC/NBaiZ8jOssW2b0l91NombdgASMjm0sKZJyWu4uUrSnBXfmVSoo126Pm9bF/B+WRz
         DOE6cvDOsWOG8t3CptO4+WSTDjKid4T8BIaeriZk5G9ElXn/kyFwP0z50RzRczcJ0aNb
         5Rt0Xo6k53mvPYgwWLQUwU2IUrIzIWatcMrLy8bxrGQmZqrzPU1EqaasGWK8loF8JUxC
         5BPZuEaabXuNSNK0xHHYyVdKviTi/GhEHfzpJe/mV0nz+ljg85WXTxzBFpMrybQJc6wV
         upmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740645476; x=1741250276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXNNlRe00B5Yrlgkz+ksjLu5J1m0nU9Z2RqZlLitG9s=;
        b=Ox2RE15RK94HikDOK1/Wrn8vIXrB3/R4ymCey59AA8KHQ/yClfgD8o9YJz6SUrVLvk
         cjLJO+9MOuNbvXV1y+i8mqmeEySd/C3JKu1wb7B5/KuU69HIp2OyWbvYYUO485PZYDaI
         29hgxaox8Nh08yrP4XrDZKepHfAR5iw/Vye4fBG7hxUCYDqd4KLi4oE5TzmLniKwFDye
         TCxgIK51u5JlYu1zlLY3aBnsPRRw/EHweaxImsbVsXUvbfJYybdxvsCExHSOg+gYv8ef
         jDJc5NIOvMA/qNwk+6K784dXb11MEQ/sJkiXCiSTKws7x0xFXfraaIGzraNDBwJ8f9bl
         7dmg==
X-Forwarded-Encrypted: i=1; AJvYcCUAkaj58DIMvYPRd4z9kD+TIbrufCuVC/nByB4UlSijR7jY5rc9W6aYdgz6t3Ea18aUo4T0EdKWOuYk7wk=@vger.kernel.org, AJvYcCV61pGbjsF2zePAsgRUfnU7avER0OmNkIy/0406Z8Arnl2DoXJbcTrmcZ7JwGae4n+OjHlyESKWTdnPuTCQUqHZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwUCyWxARgEmDIxP2D8jpC4l4BSV2wcy//mSOg3uxQvL5LUx+Y2
	ll9DvV8RMZOx2G5xIHvP8p9erDdd4CFbGK3PS8mWdBsii6JDhp/EMpQ70I46EGfd9Q==
X-Gm-Gg: ASbGncsNnvh/EuEp5itkak8Ahseh3sIaZjkNyGdM+fExrEs8nHePgEtiIpVTsukEfS9
	W4bs+Pc0DS5lvJWhzKgh2Bl/b+E9Rv5BMkK6b5yTGM6w2EgV1gBYeLmZTpaPrqdDK7M51J7s+Al
	vo6P2NzonGAO1yAfEAKnNMGJy/VRHUtTZrozPV8eBgjrZeYbzthjwGS4ZkC5uWlFp+9FmcP5K1d
	Rro3Cxpni+mW7a8LOz8jd/3VahXMnNeoYKgXY08K6i+k+67rdIM6RIGluzkcilba4zWen2OZLox
	GfCoHJ55EYYwdl6Cw4rep5pnjDC06qsAqQYqIsTzP3jbFA==
X-Google-Smtp-Source: AGHT+IE9g1k1J1aSFbOxI42GtcRei7NddL0y/dP1DxtBvyOZVI9s4rWOGpcf81eLLdEvF2Tj+SajEg==
X-Received: by 2002:a17:903:41ca:b0:21f:988d:5758 with SMTP id d9443c01a7336-223200ed5a1mr108803755ad.35.1740645475776;
        Thu, 27 Feb 2025 00:37:55 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003ec7esm966796b3a.153.2025.02.27.00.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:37:55 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Jarod Wilson <jarod@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 2/3] bonding: fix xfrm offload feature setup on active-backup mode
Date: Thu, 27 Feb 2025 08:37:16 +0000
Message-ID: <20250227083717.4307-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250227083717.4307-1-liuhangbin@gmail.com>
References: <20250227083717.4307-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The active-backup bonding mode supports XFRM ESP offload. However, when
a bond is added using command like `ip link add bond0 type bond mode 1
miimon 100`, the `ethtool -k` command shows that the XFRM ESP offload is
disabled. This occurs because, in bond_newlink(), we change bond link
first and register bond device later. So the XFRM feature update in
bond_option_mode_set() is not called as the bond device is not yet
registered, leading to the offload feature not being set successfully.

To resolve this issue, we can modify the code order in bond_newlink() to
ensure that the bond device is registered first before changing the bond
link parameters. This change will allow the XFRM ESP offload feature to be
correctly enabled.

Fixes: 007ab5345545 ("bonding: fix feature flag setting at init time")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c    |  2 +-
 drivers/net/bonding/bond_netlink.c | 16 +++++++++-------
 include/net/bonding.h              |  1 +
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 683bf1221caf..65e4b5d599e6 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4401,7 +4401,7 @@ void bond_work_init_all(struct bonding *bond)
 	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
 }
 
-static void bond_work_cancel_all(struct bonding *bond)
+void bond_work_cancel_all(struct bonding *bond)
 {
 	cancel_delayed_work_sync(&bond->mii_work);
 	cancel_delayed_work_sync(&bond->arp_work);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 2a6a424806aa..ed16af6db557 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -568,18 +568,20 @@ static int bond_newlink(struct net *src_net, struct net_device *bond_dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
+	struct bonding *bond = netdev_priv(bond_dev);
 	int err;
 
-	err = bond_changelink(bond_dev, tb, data, extack);
-	if (err < 0)
+	err = register_netdevice(bond_dev);
+	if (err)
 		return err;
 
-	err = register_netdevice(bond_dev);
-	if (!err) {
-		struct bonding *bond = netdev_priv(bond_dev);
+	netif_carrier_off(bond_dev);
+	bond_work_init_all(bond);
 
-		netif_carrier_off(bond_dev);
-		bond_work_init_all(bond);
+	err = bond_changelink(bond_dev, tb, data, extack);
+	if (err) {
+		bond_work_cancel_all(bond);
+		unregister_netdevice(bond_dev);
 	}
 
 	return err;
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 8bb5f016969f..e5e005cd2e17 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -707,6 +707,7 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave);
 void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay);
 void bond_work_init_all(struct bonding *bond);
+void bond_work_cancel_all(struct bonding *bond);
 
 #ifdef CONFIG_PROC_FS
 void bond_create_proc_entry(struct bonding *bond);
-- 
2.46.0


