Return-Path: <linux-kselftest+bounces-40257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90583B3B7C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 11:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E160E188B0DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 09:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D0F305070;
	Fri, 29 Aug 2025 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5Ieh4dU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965428369A;
	Fri, 29 Aug 2025 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461292; cv=none; b=iZcspR/7ZgLHn2aBiPx5WQayWuoC+rtqlZhOzTXc0YKFrm+bMvMHaZ0TkVhqG+7V0jQuUGRSfRzt9hrfOG+kVkIMgy/MlbPlVMnkUjFshjQHmD/INf/3vapf1+uSK54ZUDlatmcsrJArefXHEdPW7OgBqq0JGsFzmJjFaOnjRIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461292; c=relaxed/simple;
	bh=ZhlPFja7SlYAPblQqVOmGRc6MDhCNGVIIY7jHIji+MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qc2EI/Txk7meyZDbHO4rWcNHn/gjQNgSZCNHTIqSirqGBWgGRWSSM2jbUQYrOfQ96/X4mojDbHfeVuI1GADMHeljVKlaIAMwwUf1DK2L13+JBxdDYfXz285wnVG95G4ubZ6B/+2fBAdR8TgVoTOrCB8W5gVB6UKypvY6+KKKMGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5Ieh4dU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-771eecebb09so2582434b3a.3;
        Fri, 29 Aug 2025 02:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756461290; x=1757066090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHcc1/G3/bt6bkHV6jdHu2UO9CVcNgvv4eN1WO9eHCI=;
        b=J5Ieh4dU90Hxv8aZ09K5u3Nwj2mnbMokFolfKhdt0uA9EL1gciBrI0P2lmLSsjWfDW
         LUnfJpnJlzX5yj3t+6ji6PwVzsz5g4seUxY3aDQPvtUsoCapY43+EjZBIUyHdQ8npnDG
         hbaz2OBOSs+x5u+JC7p7dErqGwRugi00KNetE0gRGZZVItvnW/UHnA80DYnixViI/VjB
         UIWZIrLvPrYQI2tLGjW1nyYWdt7cJDiAaDopDpDG6yRQWxUKnxnrYp8juAwpAZMnNT11
         lPOtqnlHrBT7S25bqsqhcir5oW204/e7+0fAfPBtN1N+9XuYeTokmsC+3l4RqBWJldXR
         0eZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756461290; x=1757066090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHcc1/G3/bt6bkHV6jdHu2UO9CVcNgvv4eN1WO9eHCI=;
        b=TUEbQgqBzWfv9jnL4Jo4DPWNOqr1ry1nB+dObwiIEd4TohC+Kuh/8w3hpoUZY0+xa1
         zH7unNW6D5S97a0eSMsQkFCGiuXZdiZ8sa5cP0FvSHa7cMUVO7Qh0RDGk0h0BVKJxeof
         FdVhrUC7Pgeo/eG2pzUVLZMcLLICgwsJoMHM+XTBmvZI8+FzjbobOmNs+QIi/4CuVLRT
         UmJch4I9dtqCdwUdsf6NZdjhc30OmAGz9ixsW2H6EMrigYAiNfLCYZed6PHGlALntk7z
         QCTwM8Z65e54i/FEF/j4IJA+L1hiBTKCEUyYuUHfk2igvW3wPwhFeaWYDVGrfsf/dvyJ
         AWWw==
X-Forwarded-Encrypted: i=1; AJvYcCWiWHqFSSSIgzRA9A9V2FWuOdusmLdz2EtWSgkz5pI2hPXeENib53q1rDnxQeKK2mAWetCA6F07OQkeEGa+jms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgCXT777n0aMewPB/MwbCv55Axixn5Y2FhkIrevO1ivIpAFAl6
	QPSORCJB0nyZior0CwGhYl6u/SkpOw2b5OF0Mp/f0JuYGZxDuwy0q3gL4Q21hAHnmmo=
X-Gm-Gg: ASbGnctYEgo11cuf73nJyVyFv2vBvaswY03iEdx6WGFCGsIqX5kfVHGgG41eDCFuebn
	hmkypdl9fJt2216OiUSa6y5Fnzs9rvXsP9+YDQDaRO1UasdqqtGmTdN0N6p+kVe/TmkYtpfBgHG
	lwJ2nLry1xaU5FAIV9UfBpsupKB4QD1xRd7zh3/FFJNlXY0r8oizQxkhCVVkWznsCP6IJSt3xYD
	GxTWJ3pHZ04shFaB2Q8ppZYQzr0w+OTKGvtyuZcwxqYjt0oV+WeqGbf/FBSTPzITO3tmzNuw2yM
	SR9vAEKiNqeL7t2N7RP8Y+AICt8mEblczX2XtniOVUUOKUAVuut56pNWp0rbl7bDrO9+hwvE38y
	A6cly4OiPE/XMdKxa9wj05HQ3hLIUBf5+D82EGYsA+qWVaVwo/+1k
X-Google-Smtp-Source: AGHT+IGb5b20g+ds5+t2jSRo3PBkjPZ0xiu5XnsklcgUgS2IcIeT7FoBwfI/+jjDNvRt4GiKPyM/UA==
X-Received: by 2002:a05:6a20:4c20:b0:243:a20a:3ca5 with SMTP id adf61e73a8af0-243a20a3f30mr10342005637.13.1756461289820;
        Fri, 29 Aug 2025 02:54:49 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd347db1fsm1751528a12.47.2025.08.29.02.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 02:54:49 -0700 (PDT)
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
Subject: [PATCH net-next 1/5] net: add a common function to compute features from lowers devices
Date: Fri, 29 Aug 2025 09:54:26 +0000
Message-ID: <20250829095430.443891-2-liuhangbin@gmail.com>
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

Some high level virtual drivers need to compute features from lower
devices. But each has their own implementations and may lost some
feature compute. Let's use one common function to compute features
for kinds of these devices.

The new helper uses the current bond implementation as the reference
one, as the latter already handles all the relevant aspects: netdev
features, TSO limits and dst retention.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 include/linux/netdevice.h | 19 ++++++++++
 net/core/dev.c            | 79 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f3a3b761abfb..42742a47f2c6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5279,6 +5279,25 @@ int __netdev_update_features(struct net_device *dev);
 void netdev_update_features(struct net_device *dev);
 void netdev_change_features(struct net_device *dev);
 
+/* netdevice features */
+#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
+					 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
+					 NETIF_F_GSO_ENCAP_ALL | \
+					 NETIF_F_HIGHDMA | NETIF_F_LRO)
+
+#define VIRTUAL_DEV_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
+					 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
+					 NETIF_F_GSO_PARTIAL)
+
+#define VIRTUAL_DEV_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
+					 NETIF_F_GSO_SOFTWARE)
+
+#define VIRTUAL_DEV_XFRM_FEATURES	(NETIF_F_HW_ESP | NETIF_F_HW_ESP_TX_CSUM | \
+					 NETIF_F_GSO_ESP)
+
+#define VIRTUAL_DEV_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
+void netdev_compute_features_from_lowers(struct net_device *dev);
+
 void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 					struct net_device *dev);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 1d1650d9ecff..fcad2a9f6b65 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12577,6 +12577,85 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
 }
 EXPORT_SYMBOL(netdev_increment_features);
 
+/**
+ *	netdev_compute_features_from_lowers - compute feature from lowers
+ *	@dev: the upper device
+ *
+ *	Recompute the upper device's feature based on all lower devices.
+ */
+void netdev_compute_features_from_lowers(struct net_device *dev)
+{
+	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
+	netdev_features_t gso_partial_features = VIRTUAL_DEV_GSO_PARTIAL_FEATURES;
+#ifdef CONFIG_XFRM_OFFLOAD
+	netdev_features_t xfrm_features  = VIRTUAL_DEV_XFRM_FEATURES;
+#endif
+	netdev_features_t mpls_features  = VIRTUAL_DEV_MPLS_FEATURES;
+	netdev_features_t vlan_features = VIRTUAL_DEV_VLAN_FEATURES;
+	netdev_features_t enc_features  = VIRTUAL_DEV_ENC_FEATURES;
+	unsigned short max_hard_header_len = ETH_HLEN;
+	unsigned int tso_max_size = TSO_MAX_SIZE;
+	u16 tso_max_segs = TSO_MAX_SEGS;
+	struct net_device *lower_dev;
+	struct list_head *iter;
+
+	mpls_features = netdev_base_features(mpls_features);
+	vlan_features = netdev_base_features(vlan_features);
+	enc_features = netdev_base_features(enc_features);
+
+	netdev_for_each_lower_dev(dev, lower_dev, iter) {
+		gso_partial_features = netdev_increment_features(gso_partial_features,
+								 lower_dev->gso_partial_features,
+								 VIRTUAL_DEV_GSO_PARTIAL_FEATURES);
+
+		vlan_features = netdev_increment_features(vlan_features,
+							  lower_dev->vlan_features,
+							  VIRTUAL_DEV_VLAN_FEATURES);
+
+#ifdef CONFIG_XFRM_OFFLOAD
+		xfrm_features = netdev_increment_features(xfrm_features,
+							  lower_dev->hw_enc_features,
+							  VIRTUAL_DEV_XFRM_FEATURES);
+#endif
+
+		enc_features = netdev_increment_features(enc_features,
+							 lower_dev->hw_enc_features,
+							 VIRTUAL_DEV_ENC_FEATURES);
+
+		mpls_features = netdev_increment_features(mpls_features,
+							  lower_dev->mpls_features,
+							  VIRTUAL_DEV_MPLS_FEATURES);
+
+		dst_release_flag &= lower_dev->priv_flags;
+		if (lower_dev->hard_header_len > max_hard_header_len)
+			max_hard_header_len = lower_dev->hard_header_len;
+
+		tso_max_size = min(tso_max_size, lower_dev->tso_max_size);
+		tso_max_segs = min(tso_max_segs, lower_dev->tso_max_segs);
+	}
+
+	dev->gso_partial_features = gso_partial_features;
+	dev->hard_header_len = max_hard_header_len;
+	dev->vlan_features = vlan_features;
+	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
+				    NETIF_F_HW_VLAN_CTAG_TX |
+				    NETIF_F_HW_VLAN_STAG_TX;
+#ifdef CONFIG_XFRM_OFFLOAD
+	dev->hw_enc_features |= xfrm_features;
+#endif
+	dev->mpls_features = mpls_features;
+	netif_set_tso_max_segs(dev, tso_max_segs);
+	netif_set_tso_max_size(dev, tso_max_size);
+
+	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
+	if ((dev->priv_flags & IFF_XMIT_DST_RELEASE_PERM) &&
+	    dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
+		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
+
+	netdev_change_features(dev);
+}
+EXPORT_SYMBOL(netdev_compute_features_from_lowers);
+
 static struct hlist_head * __net_init netdev_create_hash(void)
 {
 	int i;
-- 
2.50.1


