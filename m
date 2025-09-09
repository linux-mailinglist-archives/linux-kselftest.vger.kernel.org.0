Return-Path: <linux-kselftest+bounces-41025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE98B4A503
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF394E3070
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D40724677C;
	Tue,  9 Sep 2025 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1072uyz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043C24467E;
	Tue,  9 Sep 2025 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405962; cv=none; b=ZHMGkNafH27nNZUSHPC0PPLoDf2RsoTht4DkIlQbDlSlBfjU5dzP/dGHOll0L9VarsRVpNyF495CBHgj2O8swUpQKyJfMwq1VKBcMZmS+dfvgkWZNZ3EIcSmN1E09CU6vioBiWzHLzjqN8HfhSEbWnP/C2a8BCfWF82Yxww4e8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405962; c=relaxed/simple;
	bh=nD90sKwF8gyPa039GEFe5g2Io4AL5mKPqiSnf6DWlP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdA8SzIy92wrNnByoFZAh2QlmNfRz0TDOzyXOQqyIABQGg5xHJ+QOkkVyO30y2bAEATRBanEUkHa5cS1tRCI5eE+GFCmJSIYGovQUKQITBbVvoFiwvyLkhi6ChSgHPd9Z4KJlzTgO/FFCcoY9xT64/HB4VMB6L5PjIuPRyUVu/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1072uyz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24eb713b2dfso33310025ad.0;
        Tue, 09 Sep 2025 01:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757405960; x=1758010760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esdxZoP7gAjytH32r+ZUCwcKFf+Sv3pwk9SG3Ui+93U=;
        b=Y1072uyznjw1BWVzh9aR0sFv98+oc48Uv+SUEv27yxKS9HS2CGZC+ufobRGUJE8mHu
         DMecGfHJDj0eDDQMBACeAU7ynApcXJw1P9wOURZF0GwkqdSX32zbXXE7s3avhg4jLmhO
         CqsTvV9bPpJcuHC1FVqJ1kBkvnx72Wzhlk98GXruY5G0ICtoDz/NzKi5k628FzHdXvzW
         ycYrFi+XwQvCWU75xpu//Irn3UHrmUn79G580TTsY2QkRnp+h3+pzMcQHGouzcLmOFeF
         4vOp3jcQBxnVl88maP3YTQecQo5QX0wclDfIl63AgDA0F0RL66tqBoy4L7YcNZdyEELz
         fFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405960; x=1758010760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esdxZoP7gAjytH32r+ZUCwcKFf+Sv3pwk9SG3Ui+93U=;
        b=IkEjXkmX1iZCmpGl/bVXsfNqZkTtggV9gRRRk+2PoxyDvAWMngYAajkjgH7w9ME3xl
         eWIHAZJw/CnJ5zTokMwzC9AdIK9jp0LpcCStoJcgLTc6mz9VY/GDhoh9s1g+zdftikpe
         RZAtm1nJ2IKlDKGFCQQOQyONbzYk3A9ViMn0bKI1ZjrXOLJhjXo1KZ7a6dsK4AjDcMY2
         B1IaaTvMnEGui/cCNAO2VyUAgKDXKjU4PoyUsLj/Ab/PqmCxfWCGfXHDZUUwKFlu56bi
         7eW7GtkXnEcjeTJd9ypBW8qVuhKF8zLORRo8WJ7JJI8zom7BjvCWfekXFchAxa7jnAZm
         hy8w==
X-Forwarded-Encrypted: i=1; AJvYcCXtH+xzvgGSjktfPOPhQaKWtl1KguZWWmkUzUO+A4HhvOHnUQ8402wC/YGW1yr9fkOUkNPUOq8aTEiJ4s9kido=@vger.kernel.org
X-Gm-Message-State: AOJu0YydvBEIg4Ann5gfgr27bgn0s8fR1mL7DQJCGq9gHWDy9sMnSfI/
	ACUuKKKqqHmgfLJ231zCUTGuYUu6vtIk9WCFk0PNfJCzCXfeA0D8PedU8sX9AkzHKo0=
X-Gm-Gg: ASbGncsqZPTfHtBR032qPjbi2nTAXqBGPAxy/qKrwJh8Zz0VNVNPKxvfwYKEoqHNWTL
	l5Dilm903YIa81Wog2H+8T5SqE15ZthXZ2gohQQI2GqlgwLsZOxX0EmjHs23vsrvb6pWxqEbNgC
	zj0NzI93mHTanbjyJ4hyTnCCQRXc7gDNptGGRkF7PFE6/hb/DLvJXWmbFnAdX5naVzpaVWuu1lN
	H2HDdikPoXG/xwuQ8y84ykJOqUucuvidWTzzYjjZ47OuCtOXAcy5GifDaExTnpweyV4sU7LNsdN
	rBhfUIH9wfGS5U4/KVZNAj3A0s0GEDEkuhqCs3Eol2AbSwUzlvxuMKOwlNPv5e9k1lKw4pvHK1F
	15I90UEK1iPFj+FVfQxHmMgNtxEBrH8W3t2qSsYfYUQ==
X-Google-Smtp-Source: AGHT+IFwOrrxesvgvBWcJf0KyhES3l8qDZLMzgbs4XACx0ClTF2TcW0WVIJ6QKUa7SDIA7xVgWof7g==
X-Received: by 2002:a17:903:3d06:b0:258:2476:77db with SMTP id d9443c01a7336-25824767953mr46733305ad.42.1757405959684;
        Tue, 09 Sep 2025 01:19:19 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7ecd9cafsm174370575ad.83.2025.09.09.01.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:19:19 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 2/5] bonding: use common function to compute the features
Date: Tue,  9 Sep 2025 08:18:49 +0000
Message-ID: <20250909081853.398190-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250909081853.398190-1-liuhangbin@gmail.com>
References: <20250909081853.398190-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new functon netdev_compute_features_from_lowers() to compute the
bonding features.

Note that bond_compute_features() currently uses bond_for_each_slave()
to traverse the lower devices list, and that is just a macro wrapper of
netdev_for_each_lower_private(). We use similar helper
netdev_for_each_lower_dev() in netdev_compute_features_from_lowers() to
iterate the slave device, as there is not need to get the private data.

No functional change intended.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 99 ++-------------------------------
 1 file changed, 4 insertions(+), 95 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f25c2d2c9181..e14da8237f71 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1468,97 +1468,6 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 	return features;
 }
 
-#define BOND_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
-				 NETIF_F_GSO_ENCAP_ALL | \
-				 NETIF_F_HIGHDMA | NETIF_F_LRO)
-
-#define BOND_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
-				 NETIF_F_GSO_PARTIAL)
-
-#define BOND_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_GSO_SOFTWARE)
-
-#define BOND_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
-
-
-static void bond_compute_features(struct bonding *bond)
-{
-	netdev_features_t gso_partial_features = BOND_GSO_PARTIAL_FEATURES;
-	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
-					IFF_XMIT_DST_RELEASE_PERM;
-	netdev_features_t vlan_features = BOND_VLAN_FEATURES;
-	netdev_features_t enc_features  = BOND_ENC_FEATURES;
-#ifdef CONFIG_XFRM_OFFLOAD
-	netdev_features_t xfrm_features  = BOND_XFRM_FEATURES;
-#endif /* CONFIG_XFRM_OFFLOAD */
-	netdev_features_t mpls_features  = BOND_MPLS_FEATURES;
-	struct net_device *bond_dev = bond->dev;
-	struct list_head *iter;
-	struct slave *slave;
-	unsigned short max_hard_header_len = ETH_HLEN;
-	unsigned int tso_max_size = TSO_MAX_SIZE;
-	u16 tso_max_segs = TSO_MAX_SEGS;
-
-	if (!bond_has_slaves(bond))
-		goto done;
-
-	vlan_features = netdev_base_features(vlan_features);
-	mpls_features = netdev_base_features(mpls_features);
-
-	bond_for_each_slave(bond, slave, iter) {
-		vlan_features = netdev_increment_features(vlan_features,
-			slave->dev->vlan_features, BOND_VLAN_FEATURES);
-
-		enc_features = netdev_increment_features(enc_features,
-							 slave->dev->hw_enc_features,
-							 BOND_ENC_FEATURES);
-
-#ifdef CONFIG_XFRM_OFFLOAD
-		xfrm_features = netdev_increment_features(xfrm_features,
-							  slave->dev->hw_enc_features,
-							  BOND_XFRM_FEATURES);
-#endif /* CONFIG_XFRM_OFFLOAD */
-
-		gso_partial_features = netdev_increment_features(gso_partial_features,
-								 slave->dev->gso_partial_features,
-								 BOND_GSO_PARTIAL_FEATURES);
-
-		mpls_features = netdev_increment_features(mpls_features,
-							  slave->dev->mpls_features,
-							  BOND_MPLS_FEATURES);
-
-		dst_release_flag &= slave->dev->priv_flags;
-		if (slave->dev->hard_header_len > max_hard_header_len)
-			max_hard_header_len = slave->dev->hard_header_len;
-
-		tso_max_size = min(tso_max_size, slave->dev->tso_max_size);
-		tso_max_segs = min(tso_max_segs, slave->dev->tso_max_segs);
-	}
-	bond_dev->hard_header_len = max_hard_header_len;
-
-done:
-	bond_dev->gso_partial_features = gso_partial_features;
-	bond_dev->vlan_features = vlan_features;
-	bond_dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
-				    NETIF_F_HW_VLAN_CTAG_TX |
-				    NETIF_F_HW_VLAN_STAG_TX;
-#ifdef CONFIG_XFRM_OFFLOAD
-	bond_dev->hw_enc_features |= xfrm_features;
-#endif /* CONFIG_XFRM_OFFLOAD */
-	bond_dev->mpls_features = mpls_features;
-	netif_set_tso_max_segs(bond_dev, tso_max_segs);
-	netif_set_tso_max_size(bond_dev, tso_max_size);
-
-	bond_dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
-	if ((bond_dev->priv_flags & IFF_XMIT_DST_RELEASE_PERM) &&
-	    dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
-		bond_dev->priv_flags |= IFF_XMIT_DST_RELEASE;
-
-	netdev_change_features(bond_dev);
-}
-
 static void bond_setup_by_slave(struct net_device *bond_dev,
 				struct net_device *slave_dev)
 {
@@ -2272,7 +2181,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 
 	bond->slave_cnt++;
-	bond_compute_features(bond);
+	netdev_compute_features_from_lowers(bond->dev);
 	bond_set_carrier(bond);
 
 	/* Needs to be called before bond_select_active_slave(), which will
@@ -2524,7 +2433,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 		call_netdevice_notifiers(NETDEV_RELEASE, bond->dev);
 	}
 
-	bond_compute_features(bond);
+	netdev_compute_features_from_lowers(bond->dev);
 	if (!(bond_dev->features & NETIF_F_VLAN_CHALLENGED) &&
 	    (old_features & NETIF_F_VLAN_CHALLENGED))
 		slave_info(bond_dev, slave_dev, "last VLAN challenged slave left bond - VLAN blocking is removed\n");
@@ -4028,7 +3937,7 @@ static int bond_slave_netdev_event(unsigned long event,
 	case NETDEV_FEAT_CHANGE:
 		if (!bond->notifier_ctx) {
 			bond->notifier_ctx = true;
-			bond_compute_features(bond);
+			netdev_compute_features_from_lowers(bond->dev);
 			bond->notifier_ctx = false;
 		}
 		break;
@@ -6011,7 +5920,7 @@ void bond_setup(struct net_device *bond_dev)
 	 * capable
 	 */
 
-	bond_dev->hw_features = BOND_VLAN_FEATURES |
+	bond_dev->hw_features = VIRTUAL_DEV_VLAN_FEATURES |
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER |
 				NETIF_F_HW_VLAN_STAG_RX |
-- 
2.50.1


