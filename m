Return-Path: <linux-kselftest+bounces-40258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 898F6B3B7D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 11:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54FF61B23DCF
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 09:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B74F305065;
	Fri, 29 Aug 2025 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnWjxyPi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0C30497C;
	Fri, 29 Aug 2025 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461299; cv=none; b=dJ5/kn9HQzt0i2khfa7UPXDfbgwWjkJDQeL50s33YRVB57XE3q8yD9sHnGU3ye85PN4UATcWfgtnps4M+XzVyr97HCZgWDB6uGg+BLTzZwTBnxjg2lVzi5PyjIbV5JKc1QnuAl5AgktpFsl3N1GLkJ+LMM6d3Zeb/SBDESKCZk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461299; c=relaxed/simple;
	bh=LvKMJecvv6fCl08ak6wcz+usML93SEKeGztEfvaXXos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTJkY/YgixxBizgPP5ubxTl0ntURQJVTnlc61w454A/KKXf19Vfjgxd/D+YwsaTh7T7dfjSzfb0pk+REbXB4gQ57bjeM6JslF/eE7UWbLRabm8rcBhIyGT6dbY5lgv/WCdkte0Y1VjYj4kROIzJ8LRkTX5+uxNz9oZCeqYN6Y4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnWjxyPi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-770530175b2so1526387b3a.3;
        Fri, 29 Aug 2025 02:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756461297; x=1757066097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ROTQkSqqAop+hXmMAfGEDF4zfkGUQT7wlA8Dp+fSV8=;
        b=DnWjxyPiGTpa7MBk0fW4953RqgiO3xKyhCeUWAq6foJ8Tuw13b6OTAISlR7cgKOn1T
         krYeqohI4Bucx72DUZLfZtfZ87Z9tcoYvUoSO2ojzdn/0GAU1xqaVq4g653twdWyb9+s
         o4SiltwY8B/jNkVt8vHEQL61Pll+vBRYg6mHUzU2xIbSnRpdyHlguIY0nteJSSCloKiY
         Nl9jcn80Y4HJzEQzfpzqJcGnq7QLrRzgYAvmSg194oAkJ+3MlRwwutBNA3U4R93k2qdp
         p43As/zisNaVwxDg6cIngACV+tURqRuWp46VkrTofHpfR2x2RBKyFrOtDKfmfweXNlav
         g4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756461297; x=1757066097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ROTQkSqqAop+hXmMAfGEDF4zfkGUQT7wlA8Dp+fSV8=;
        b=lmNhjQUUMcJCUlF6K2SOHxiVXGK9Fx+WKdSyP9cGIfhjMrFlIrGdV2AzK5WrBNvQxY
         HUrggdtdBBkrhIqINm6kfBoDYVq6nIYNrKQ1HKr3OMoJ9qj0MYYXJM29RdoiT+nOoWVL
         r55rAl0NmXAF4lAiJyTTc3Zgp5GmVUMn/nvZCYQftGI7WnefEziq2fOtoOUdJh/aNqZz
         8c93jPXaBe5zlup/usDqk0d5XmmMZ4Fs1KrFftJkEcE7H8c8qIlR+GzgwJ9A7Fl1gCtH
         8KEajh5gLnJSqzlUqgY3jGCorFXPYDyfK8L/J8rzG0RT2wmehfxFtuUWZqIu1tIjKSkH
         rfwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHUfVQj7BsEETWN0ptsGlwtEp8mJtXsqNG0Xk+hmkRPpfpJpIArm2yf36oduwVwBg2y1d2vWiXxQVvcwtM0Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YywxYEhZ17HsiIsNpU5QiqPnaL35sc+YEyjy6t8qluF5iZu1oW9
	cRIlLCDWMdwnYog/h5ok0tyA1vy3o92U3gFEb2muVfyLUIp1lbF/2+WL2FLqxOwO+dc=
X-Gm-Gg: ASbGncsHA08iTpYnpFsZMQgDbA0D9fus8lpFqSSFuTGlw4Jpz4x0Y82n8sGuuUiPRDx
	PPZh6t+MXzEuBhkiLQ82/w6NMEqLJBAz9VPTez3vQasTYntXKtz02DCcVVtL/eiKhvReWl9dOHG
	UTSqkfQUh0K61+ZrDhOtLEU+KfW/AzQlaAIZaf0x8NvYqMXaHPR4mLuHW84NXx4KdYo7prbLvLU
	kADr+KQDjznXdfQ+M2ZrRL1Bs3krGWNcyZT/KUla0w68JF4dpEknY9s/Uzu73QTPmwriE1RbBep
	eWImwxokrW0AVWDecy//HnrQmZCv8KJF8Sg9/2y3/cYX1+xPzKTZfIIzsgtCy9OFw2JzkcscFiJ
	rbISmD4EGgbjg7c3A+IPKurRYU4mQ2sWbY4Z+1CMEAg==
X-Google-Smtp-Source: AGHT+IHPK9Bc23mRLIWDN8ntFsoHqmmVHrlhufQQPo1gBiSEBJ0d2KH8HKBIuohVwn//FgkmThDgxw==
X-Received: by 2002:a05:6a20:3d1a:b0:240:167f:eb88 with SMTP id adf61e73a8af0-24340dc847dmr38266596637.41.1756461296924;
        Fri, 29 Aug 2025 02:54:56 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd347db1fsm1751528a12.47.2025.08.29.02.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 02:54:56 -0700 (PDT)
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
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 2/5] bonding: use common function to compute the features
Date: Fri, 29 Aug 2025 09:54:27 +0000
Message-ID: <20250829095430.443891-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829095430.443891-1-liuhangbin@gmail.com>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
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
index 257333c88710..ec098a52ef75 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1540,97 +1540,6 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
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
@@ -2370,7 +2279,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 
 	bond->slave_cnt++;
-	bond_compute_features(bond);
+	netdev_compute_features_from_lowers(bond->dev);
 	bond_set_carrier(bond);
 
 	/* Needs to be called before bond_select_active_slave(), which will
@@ -2622,7 +2531,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 		call_netdevice_notifiers(NETDEV_RELEASE, bond->dev);
 	}
 
-	bond_compute_features(bond);
+	netdev_compute_features_from_lowers(bond->dev);
 	if (!(bond_dev->features & NETIF_F_VLAN_CHALLENGED) &&
 	    (old_features & NETIF_F_VLAN_CHALLENGED))
 		slave_info(bond_dev, slave_dev, "last VLAN challenged slave left bond - VLAN blocking is removed\n");
@@ -4126,7 +4035,7 @@ static int bond_slave_netdev_event(unsigned long event,
 	case NETDEV_FEAT_CHANGE:
 		if (!bond->notifier_ctx) {
 			bond->notifier_ctx = true;
-			bond_compute_features(bond);
+			netdev_compute_features_from_lowers(bond->dev);
 			bond->notifier_ctx = false;
 		}
 		break;
@@ -6109,7 +6018,7 @@ void bond_setup(struct net_device *bond_dev)
 	 * capable
 	 */
 
-	bond_dev->hw_features = BOND_VLAN_FEATURES |
+	bond_dev->hw_features = VIRTUAL_DEV_VLAN_FEATURES |
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER |
 				NETIF_F_HW_VLAN_STAG_RX |
-- 
2.50.1


