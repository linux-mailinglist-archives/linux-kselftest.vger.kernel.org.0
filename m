Return-Path: <linux-kselftest+bounces-43114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79986BD8123
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 10:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D8A94F9F67
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7821230F93D;
	Tue, 14 Oct 2025 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi362HIB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1D330F924
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428967; cv=none; b=tt3+pU6bBaeFzosoOHi0cL3WQKnGKpx1ohWm6TxIsNbHgfG+4uH/QSbt4qA0ePORMlSLg3Za4uUDxgwwEaDpbuYDVxd1XYeSGtdil8TBNwTp4RtzErJtwwsmyVPwefj6rX1y0dIdEkyWGH72rgvn6iwBDyDk0124pfMKlYtwD0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428967; c=relaxed/simple;
	bh=ii+CgokO79ILxVFZG72I/AThFDGSQaZy7MH6v2mPnB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKb/IVpm4dAXU5XBIaPZmUNqIGBMP+3oLyMsDB6sUOJB3p9EmEgMDpnMQh+QUnLIT61QIR+hrOcHpJB65krnFeOjQVV9Z+cM4xkeT2AMWfzfcd3BS5Qtk4qu3eR6W4n2oDRx/5Ev668TIVDR/R5k4o4sT9U7t3BSpqrr1VV+6Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi362HIB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f343231fcso3076396b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 01:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760428965; x=1761033765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHNcv9pTQXDC3e5Z3Ktz2JVad9X9+xNmKOZAFwSRrUU=;
        b=bi362HIBJL7H9o8iJbQft3oEUSAG5ncYmhViiVAeKW6DdChzMUeoR7g/U8jD1Djiyv
         2sr1VL4tl2Vc3vkC4BCU5bAjmqkXdln2uNe4JhKX8LitE8UFYGUDJTxFrPbqZu21F1h7
         slwQGCBihACae3seHNz+netwMeLXcq3c1h9BdX2IvRIbtVkwLiIvp3o/CIZcuhAOfx7g
         uavIjAt6rSynwv2fneGvg2tIs5DQ9BpGz8OnuxgsQKdnDXY3PfZVzXgkKcPFadCeU8P9
         d+9OuwV4s7vbVxKZO6uLYLFdLjsg/DeGeF3V32lCSlh5DMhqIj+drH0X4siVPilrev0r
         n3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428965; x=1761033765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHNcv9pTQXDC3e5Z3Ktz2JVad9X9+xNmKOZAFwSRrUU=;
        b=YuoJz0RxwLvI0ioQ1EztrmKy0aSyfJxVYtwx2PXG8XuFMeaJYwboVHwWQagEgGlD8G
         bbapgGIkLX5szn9C/BB3LGKuUXYW+zwXpjsuwr2Krzg4tZw75IcgFSbAN/7xwClvU/A3
         hcKQk7/SVJSnPwpTHaUM1WWBeMN2uhvY/orymEzbumgQHm1EcgCb6F+iz+2q9QBYJJM9
         YnxBiJM2sejRnUn+kzHmUcDWo2uhbK/e3J5rzrAOYxGpxUqNmhJp+Enk/JWmi5t8xKu4
         5epRFmGzmI4c+OGH4ZWpYHhKb0XC8sV97DjA7zQMmYvmXslIUNCKxseF4QytGx0etSVN
         OQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCHgKdB893US/E+S2v9t5np6ylB/7srknYgiIB+M7lXru6eidf7oBlklB1fPXPStfC1ZCDbPnCMrmjNuYX7b0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUqGpW9OHfFabXdCbC4hkGDBdZBtnvPH9zYsnMv+izBxFDJdHn
	DCtXAJOkPgSK7OZp47/Dhw8txdxXs2GSXJ6LXEeerVd3/eI/LlFTaG/e
X-Gm-Gg: ASbGncuhn9Jd6ds3awSWN1SPi5zXlBvsYfl9T02wdJNXCEg2N3bm8KfeVWohMCBLg4Y
	kVc2BAcdHLVIitUBZL1LNaxL0vE+kqrNa4qlOx6cTHJnLbDoCJOApb5/W/dFyyC7/Q3XBtr13ot
	n1KxQgq6r/CuLQwwJ72w3BrwdOVb4/JzI1FgcvlJjbLNlxrXDEevs7UG5ccn2dD66jUtLZ1Tsof
	KiNkPIwuRXXgNnAVr8TJBkUIKVuXTxYE92IiqF/SyMjlgPeQ2FDLmYMVpDxW8lrrSJvfZO+uGMv
	1+fQFJdbAi+09sMgAYDZk7/xDR0z1Q1yST3ygYc354eK9TCuQ4ut7MKG0kiTyBD5v7htTHJtjV6
	51qw02NdnUtCEsjDUMv34EP11mY769ZFYvVTRWU+VseTAwl0SMLso91Ap
X-Google-Smtp-Source: AGHT+IHhQNVbwqtX76FTn1yokD9QiIWL92xadhhSbKMe7+jaBPQN7bXiQcYBuRWE7hMxzhtBFCs1Qg==
X-Received: by 2002:a05:6a20:918e:b0:261:f6d2:e733 with SMTP id adf61e73a8af0-32da817d154mr33377589637.16.1760428965021;
        Tue, 14 Oct 2025 01:02:45 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626407c4sm14648210a91.6.2025.10.14.01.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:02:44 -0700 (PDT)
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
Subject: [PATCHv4 net-next 2/4] bonding: use common function to compute the features
Date: Tue, 14 Oct 2025 08:02:15 +0000
Message-ID: <20251014080217.47988-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014080217.47988-1-liuhangbin@gmail.com>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
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
index 4da619210c1f..3b78984e5912 100644
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
@@ -2273,7 +2182,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 
 	bond->slave_cnt++;
-	bond_compute_features(bond);
+	netdev_compute_features_from_lowers(bond->dev, true);
 	bond_set_carrier(bond);
 
 	/* Needs to be called before bond_select_active_slave(), which will
@@ -2525,7 +2434,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 		call_netdevice_notifiers(NETDEV_RELEASE, bond->dev);
 	}
 
-	bond_compute_features(bond);
+	netdev_compute_features_from_lowers(bond->dev, true);
 	if (!(bond_dev->features & NETIF_F_VLAN_CHALLENGED) &&
 	    (old_features & NETIF_F_VLAN_CHALLENGED))
 		slave_info(bond_dev, slave_dev, "last VLAN challenged slave left bond - VLAN blocking is removed\n");
@@ -4028,7 +3937,7 @@ static int bond_slave_netdev_event(unsigned long event,
 	case NETDEV_FEAT_CHANGE:
 		if (!bond->notifier_ctx) {
 			bond->notifier_ctx = true;
-			bond_compute_features(bond);
+			netdev_compute_features_from_lowers(bond->dev, true);
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


