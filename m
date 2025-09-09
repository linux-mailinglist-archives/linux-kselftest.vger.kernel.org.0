Return-Path: <linux-kselftest+bounces-41024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8F1B4A500
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3111170E59
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB152522A1;
	Tue,  9 Sep 2025 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wik0dfcl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1B25228B;
	Tue,  9 Sep 2025 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405955; cv=none; b=i+jPwbqYvAxVMa8nR09xC16f9DzBT5OaEBgX+FiBeQ6GUx9ntmU52n3j0klOolJOfMsEMo6HiPkjd6uk5WQTlYPMKVE0e7VClwdI5JQVfrHVT/Nz0YQZQNPoTUYs1k9jxXCVya/Zes1fLSusVcjQMlXqeOTKOhDAVBEErwHWHXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405955; c=relaxed/simple;
	bh=j9uzMiWQ9i8oNm7SVhehG296FimdKTYFtu78yRIc8L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILcP6yvPVmBtHm03/gignnBm7L/R9ponotZ2dnsDDo4+3ldEbVGKO/SfmOyAI/vvTM7kWYuNOwaZDehgEcxSmGHNQznoS3dHde93545g1pGx48h7hyaJggPNkKXoS80J0xEOBRbzAJpKZF+f7Mx1M1dJC/E3pWv7u5z+GxYaTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wik0dfcl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24cdd95c422so30129435ad.0;
        Tue, 09 Sep 2025 01:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757405952; x=1758010752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfNKMf4RuK81Pvpwv+IqFYeA9QD0DkyoE3T3rPSdArw=;
        b=Wik0dfcll2qOrSJUEeGPRCTWLVOsq9qdio6y3LQ+PJT8IwLF0QdYq748/HrTJ1081+
         uUT4TXi7+VIX/oUMnLJ5Y1FWWKuqdfkuDKTAl4u7L0TZ0f+tYcLPS2nZJ0Bv2OcBLaFl
         Iolq2o7TzQXJNLlGA4lvXAzm6jCcb0YnHT4uoqnN5JWFdqn1hENyMDzvdTc478mh1yoI
         Jii422eW6mS69oxcGJblEjeGVXfeD93tHrpmy46YxERCi9Bf1yjNHx2gb/hnxSZRr15k
         HiBJ1WHo8IlwAn1i5308b+B2zyTyvhWMj3rJruGHcImZtHGDuCjJhgXHydIn/5b/NvTS
         g0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405952; x=1758010752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfNKMf4RuK81Pvpwv+IqFYeA9QD0DkyoE3T3rPSdArw=;
        b=tfzw1oDXllHTn8yDZcOBPRL3nE+rzfEmCu85VWGaTNRiiSdNzBQw2y3OnBZM2HVedK
         EtFr46i1pE4xZ9XsftYBnMmOyEHpDXUtUN9N/X4MR+3N7z6uLBdsukgslQALGZoCPzZS
         GORSBoUxIvF95UueiizoFw+YeczmXv8JDpzc/OAMMmHEn/mx2+nJJwgyaMjIx1yeIDd1
         SvsPE6iEnA6ddSOO9nbipTHe5Hos09tm0ijISE5uIjxXrxsd3XKsKYzQTY64JI3Kcvt3
         kKDIsWzS8ipLqCtC216a4/CSLNOxfYDQ5HcXgHkkvLBBe/P39X7w/9uFt8VdGDY+3KI8
         omAg==
X-Forwarded-Encrypted: i=1; AJvYcCW+oFANdOhhJ7PqCdaTrdwlavIqwRS9QIN5sulVbXvkK7Z8RTL1oBxnQt4EIUhhwMHwTBs1chu5knqVsZXeg3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1GPq+qDtOgleSYchxUmnAhqDr2542v10E7vWssI7tAGm/nENS
	wIR+8hur8HakLwlhI4Vr3WKNRCQASPfVvXpkymXZimlGrP/o+Vll2tzR+VaMppLn44o=
X-Gm-Gg: ASbGncs8+lbn5sQ9vjbe9t7edzC8GOOmYlmpdaASXFyYG8zx0/kXLdZwkRZnHUcBR56
	39XJHWq9GRbatqDGNM1vV0z/IeiKDrNnoBBytOoZB+xJu/a8erSCyeKn+n44VYuqPro45TsrI6D
	NTRRJyZc+CZ06L5D0s8pKAVRcLnPH8ikvMhXoB8GKoYagbk9THjc8hjOZSUat0SNALOW55BLACK
	i32xu9CxxWvFXWGDVRfhVav0GQO3kKjzbghY+L9X9LNlmF+BOmUWdFifgUsyYobrYZ7/5LabO+1
	oIBoK9Z7arkGvtf4q5JCeiIW+oS5nsUIaWUfMnLeDmu2QzG23ExU+Dh4ElstASpyrGstLYp+wah
	n14U3moB8InMIn4Q7Hqg+f54/dfR68CBakUre/CaNKQ==
X-Google-Smtp-Source: AGHT+IG3wWhULUg7cjG5ZMLOkjDiJJnJ7RgVLHfoSVIKy0TH5IMemt6fmLOLROVCMPi2VeAKbVQBgg==
X-Received: by 2002:a17:903:1904:b0:249:3efa:3c99 with SMTP id d9443c01a7336-251751e9acbmr111314845ad.61.1757405952281;
        Tue, 09 Sep 2025 01:19:12 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7ecd9cafsm174370575ad.83.2025.09.09.01.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:19:11 -0700 (PDT)
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
Subject: [PATCHv3 net-next 1/5] net: add a common function to compute features from lowers devices
Date: Tue,  9 Sep 2025 08:18:48 +0000
Message-ID: <20250909081853.398190-2-liuhangbin@gmail.com>
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
 include/linux/netdev_features.h | 18 ++++++++
 include/linux/netdevice.h       |  1 +
 net/core/dev.c                  | 76 +++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

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
index f3a3b761abfb..c0df0594fca1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5278,6 +5278,7 @@ static inline netdev_features_t netdev_add_tso_features(netdev_features_t featur
 int __netdev_update_features(struct net_device *dev);
 void netdev_update_features(struct net_device *dev);
 void netdev_change_features(struct net_device *dev);
+void netdev_compute_features_from_lowers(struct net_device *dev);
 
 void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 					struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index 1d1650d9ecff..7173b3b579a6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12577,6 +12577,82 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
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


