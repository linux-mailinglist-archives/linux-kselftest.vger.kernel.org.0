Return-Path: <linux-kselftest+bounces-43113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5920BD8111
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 10:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB3144F9601
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC89830215F;
	Tue, 14 Oct 2025 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0U8vhkV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EEE2BFC9B
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428959; cv=none; b=RX0scsTMqjFE63Jjaw8XYybbUzWD2ft9CkF+m+tmuxGV5SLKMOzClx2Oc41XBS+tsJ9BmU79ZbKbUO/sAO8g4ptaBoxjnl12sTJUVjydWI2LWlud7e8DmqrLwJJngoU7sHt+cDv1RzkMdjy/IYZuUqYf8l+4ENWTxpTFlkIY5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428959; c=relaxed/simple;
	bh=8dTxGOgQN7TatfYGs89HXqTVV1dfXFxVLm/rqIOGmqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0N/O9WoXF8CD3MsekSPHCv80dJA4JnRAp/sJCv9W5bjTWuQBQ1U9SH9aa04060L8K5ZEDx6FkSz8BQFLGX11L1y7fRd1sqToPJ9Cvu1GsSXenSVS5ZIDYBJdx/aWj3UtqnZZSmDk0JFs2hs+Hec3JFssj7CS0rFBbP8lSKstX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0U8vhkV; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so4493234a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 01:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760428958; x=1761033758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWnH+cC42+c5SizK69CiWCx74af0EbDcIh1zp6haGLQ=;
        b=B0U8vhkVTsZHKfGQc6vnQAFpclzBDXEjx+ywfqd08W2i0KiL08hRG9EylU5i3lY9LE
         Bq8es+vI2PACTE5ebTkAhss3dInMIOl9bXfH6B2i8vI7BzmzZkIn9E0JyPM3UhCWGxYz
         0gPO2IFl04Kc/kSq3T61hvazkCKBSp4rPj/EwYhtcK/qF/JdVR6taOxZWjfcJSDcTV3W
         E05SQgLMTgNVBo4F3mxvPXKOQ3VgJvrvEcbTTKHrXyHnxs3KIa7LIFr32UL850l9irIA
         L0ZJKEFUk8NidzEDwvZEPwWIeETz9DJV3maRUpKy7h63FYrrmjgYuaa7NVSFimnTMmXU
         YyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428958; x=1761033758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWnH+cC42+c5SizK69CiWCx74af0EbDcIh1zp6haGLQ=;
        b=KjWBg1sMTb2p/1vSO6dhupTUL7pT6B94ToaHkyNkW02Z/M69emO8L6tQ/SUJ9NAlmt
         wU6ycR5nax1NqY7B8gnGqU2fsLgAbdvxVrRdDSmPi/V4kra60ftCfVpxvQ8JQuf1l9Ki
         J3rTV57CoJIQN/GM6vHFu+KTQEej9xtbMhT6i7CHBhFd4j0/G2ftd2+NmgWjClFc1Hk6
         plNvCWRsNurFFe28pRxcyHJtuKeyVgSN1b5fXrGMku1wvzgS7ETimXshoVcFopwio6qZ
         pu7zMz7VmRltgQyINwabFVSuMWwKj/GTYKqEeyaQe8r+Bgtvt2hgHgUQaO9ifcVsh6fn
         TaiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbRYwZO0RwxCXE5Hop1obI1tZJodBzXA8VJ5wUh4jGk9s6S9ifFZ7k9Q8jJBhF/YUnmeX5yrp/bFGcTrx9nJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ+eNHdryr11OFZJUvxwsw2aCxF1mVnOzHhcSaT96A5Ddt/f5E
	km/88eKgYRgRIGUtON9r5mOFHPvKE6TsDTmNL1cR8uFn10kHcr/aBp9G
X-Gm-Gg: ASbGnctVB/vLDp1BNULrOvjI/X+qrWuNX3F9iHYOu0yj219gu7BZ7EDzBZr/rmP85UZ
	iL+asHsWhLdkJTduywNJ4YOU0zPJ8cTYU8hN70GgxFwAxKQYkZp+g7FGCdCyLI/Y1nqOc06F/GG
	IEW5ZsB39Sg96mXjMin6SNwLH/4YLKr0dtKzRoF3+EzeaBmbhA5yoSic4u2+IbkXeHYPJDmTP0z
	1qUcP75iW2C4oFHocL+XXsaauNYWSn8EO+Yc8A73WZ+4Wk/YpeELrl84L2cIRa+stMdzE9Joe8d
	L7c81XUx1FuijGLijB8hna2zqpDVLBoJqwnIZ6Ys8g/pInxeXEVPmlYX6jD4o8nLWkahZHaeHW0
	nwQVowmmm5yuiZtw7lebp2fuyODpC3QvgOMWO6zLCqw7ekA==
X-Google-Smtp-Source: AGHT+IHtgBHpjqHOfJPQMdE11TvFAmCGMEgpTH8sJ4AtgUwzT3dUkv9OUYCk/OS7ICE9VnkZDoBWig==
X-Received: by 2002:a17:90b:1c0e:b0:335:2823:3686 with SMTP id 98e67ed59e1d1-33b510ff59bmr29055412a91.2.1760428957619;
        Tue, 14 Oct 2025 01:02:37 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626407c4sm14648210a91.6.2025.10.14.01.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:02:37 -0700 (PDT)
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
Subject: [PATCHv4 net-next 1/4] net: add a common function to compute features from lowers devices
Date: Tue, 14 Oct 2025 08:02:14 +0000
Message-ID: <20251014080217.47988-2-liuhangbin@gmail.com>
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
 include/linux/netdev_features.h | 18 +++++++
 include/linux/netdevice.h       |  1 +
 net/core/dev.c                  | 95 +++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 7a01c518e573..f3fe2d59ea96 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -255,6 +255,24 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 				 NETIF_F_GSO_UDP_TUNNEL |		\
 				 NETIF_F_GSO_UDP_TUNNEL_CSUM)
 
+/* virtual device features */
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
+
 static inline netdev_features_t netdev_base_features(netdev_features_t features)
 {
 	features &= ~NETIF_F_ONE_FOR_ALL;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d1a687444b27..8e28fee247f5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5304,6 +5304,7 @@ static inline netdev_features_t netdev_add_tso_features(netdev_features_t featur
 int __netdev_update_features(struct net_device *dev);
 void netdev_update_features(struct net_device *dev);
 void netdev_change_features(struct net_device *dev);
+void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header);
 
 void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 					struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index a64cef2c537e..54f0e792fbd2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12616,6 +12616,101 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
 }
 EXPORT_SYMBOL(netdev_increment_features);
 
+/**
+ *	netdev_compute_features_from_lowers - compute feature from lowers
+ *	@dev: the upper device
+ *	@update_header: whether to update upper device's header_len/headroom/tailroom
+ *
+ *	Recompute the upper device's feature based on all lower devices.
+ */
+void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header)
+{
+	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
+	netdev_features_t gso_partial_features = VIRTUAL_DEV_GSO_PARTIAL_FEATURES;
+#ifdef CONFIG_XFRM_OFFLOAD
+	netdev_features_t xfrm_features = VIRTUAL_DEV_XFRM_FEATURES;
+#endif
+	netdev_features_t mpls_features = VIRTUAL_DEV_MPLS_FEATURES;
+	netdev_features_t vlan_features = VIRTUAL_DEV_VLAN_FEATURES;
+	netdev_features_t enc_features = VIRTUAL_DEV_ENC_FEATURES;
+	unsigned short max_header_len = ETH_HLEN;
+	unsigned int tso_max_size = TSO_MAX_SIZE;
+	u16 tso_max_segs = TSO_MAX_SEGS;
+	struct net_device *lower_dev;
+	unsigned short max_headroom;
+	unsigned short max_tailroom;
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
+		enc_features = netdev_increment_features(enc_features,
+							 lower_dev->hw_enc_features,
+							 VIRTUAL_DEV_ENC_FEATURES);
+
+#ifdef CONFIG_XFRM_OFFLOAD
+		xfrm_features = netdev_increment_features(xfrm_features,
+							  lower_dev->hw_enc_features,
+							  VIRTUAL_DEV_XFRM_FEATURES);
+#endif
+
+		mpls_features = netdev_increment_features(mpls_features,
+							  lower_dev->mpls_features,
+							  VIRTUAL_DEV_MPLS_FEATURES);
+
+		dst_release_flag &= lower_dev->priv_flags;
+
+		if (update_header) {
+			max_header_len = max_t(unsigned short, max_header_len,
+					lower_dev->hard_header_len);
+			max_headroom = max_t(unsigned short, max_headroom,
+					lower_dev->needed_headroom);
+			max_tailroom = max_t(unsigned short, max_tailroom,
+					lower_dev->needed_tailroom);
+		}
+
+		tso_max_size = min(tso_max_size, lower_dev->tso_max_size);
+		tso_max_segs = min(tso_max_segs, lower_dev->tso_max_segs);
+	}
+
+	dev->gso_partial_features = gso_partial_features;
+	dev->vlan_features = vlan_features;
+	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
+				    NETIF_F_HW_VLAN_CTAG_TX |
+				    NETIF_F_HW_VLAN_STAG_TX;
+#ifdef CONFIG_XFRM_OFFLOAD
+	dev->hw_enc_features |= xfrm_features;
+#endif
+	dev->mpls_features = mpls_features;
+
+	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
+	if ((dev->priv_flags & IFF_XMIT_DST_RELEASE_PERM) &&
+	    dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
+		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
+
+	if (update_header) {
+		dev->hard_header_len = max_header_len;
+		dev->needed_headroom = max_headroom;
+		dev->needed_tailroom = max_tailroom;
+	}
+
+	netif_set_tso_max_segs(dev, tso_max_segs);
+	netif_set_tso_max_size(dev, tso_max_size);
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


