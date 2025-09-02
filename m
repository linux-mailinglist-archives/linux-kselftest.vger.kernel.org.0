Return-Path: <linux-kselftest+bounces-40515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1935B3F6A0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 09:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8A816F742
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 07:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5612E1EE3;
	Tue,  2 Sep 2025 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2H6fLzZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E563627E07E;
	Tue,  2 Sep 2025 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797994; cv=none; b=bq6lx1dfCU8cZncmUl3KOnQj046WWCgd+mL59qzQTGj4Mp6s5RBEPJuZ6EcnMraNfj/ldiLE0lCCFPw64yRga54xYvEne1a+V4tveXTOyaLXhTCDiEawONKpbSSO2SjkunqzEkycIEqsLxqhkJWA1JiS2iWEplUa4E8W7plkIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797994; c=relaxed/simple;
	bh=f3PQMblOMBCI/1kmTA/vjXSxqmbwI+7PArh10fBY6Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQnTk3UxI2XoqZqpSHLQwDBoW8C2Uc96jinuyVxmI++zxP5R1t+z+wi93DhmrM5IUzR+9qiYfoZoeP76fiZ1xQXVf4OC7aFBm5/bz8werEa1a40Ui5CJ0E1KoGIpgra8VLwEMbDeB8ZzdjWR9sTC5Yd8IsKvpuSVblWLsVNQpsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2H6fLzZ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so4276590a12.0;
        Tue, 02 Sep 2025 00:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756797992; x=1757402792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CroiyAwqZlGYn3SnRc22yfKpEhM9ceyols54ibX4Vh0=;
        b=e2H6fLzZXRSdV+4s3k16TqjOtgESEUK5aHEtK7xLpz4ptw0bgeiHEKAO9ose63th90
         TMOl8ZReyBT+gQAQWzOtHd/0bS837cSfrWVzjY3G915H+fKHVKiXJU4PbmdrB8cRqfIL
         PtWvryMh0KzONjrI4oc5BWJs3VaErR5SiEpLuhP95MSKpslWd28+okVCTUjbjoGn2LKg
         0okptmSyXYEOHn1Z0ML+tf92D9vfUx+xQWXBsOgPlmT82hZGbyXAekxdZ69YZQWTyHOm
         +sdD7cxQ2K5pgUXOjQakcyTFgcmrEufYNlsFm/g5dqE0QDvmhiPqGTCgDxAd0PpkvCKC
         y6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756797992; x=1757402792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CroiyAwqZlGYn3SnRc22yfKpEhM9ceyols54ibX4Vh0=;
        b=sM8RCEppxfrmkdOQ1XVCQcOja4AjutpmZ6aUa6aNRLLFxjHlRJwupb3zegM6staHY7
         HYfVZ4/vJnsEN25mTEFpjPOKyZeBVyX4Y6fzJW9Hn7GjK4m131MyGB9r/4ToPxAEHfKr
         R4KvoXmVgOSzVSoD4vkYbK+6sFS0SPxJC4B4kqJ7EiriVkszaXq07tGmyHU9SB22a2vi
         JG0SR9EK6QgNdpCsLMzc13foCM1loWg94IBc4hlt8hJzMIpAJCPqQMytX9J+F7Qt8Paq
         OsloGwngsadJqPyYmHUJjwaNqWTf86if5NYZ6q9vw0igLSV9S57tjzegFe4wVP9MLk1t
         2SAA==
X-Forwarded-Encrypted: i=1; AJvYcCW5YhtX433QL5GrzU777RGcgWfOEieYTLB7Q7FhDgxF4ghHt4r19z7UvKmibfxxCyVTlvkzpoumJFOa+X20WCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc/furMOgvgHg1XL7VG0ReWGojOyhnUOiCxeo8uLM7hkORNidL
	Qcra3FelllKLwXorUnNTedDYh0DEecnGBz66yliboYuYGQKC4v/I2F1f2KJ2u/2muYk=
X-Gm-Gg: ASbGncudMt6VV9BwfK25qMpxzJUPjMY1qR0r/9Pyw5jCCvrT8lGFXuelMVi3aE4du1J
	rLhNdOwhiNd3Ie3bEYui3Kl8WXm7U1MXcwWOJaXD2A0w58VkQjL3FbYuTgb9DI92Rcu/n4LoMmp
	c1MsvNB3kOvd5S2K33WsMceSPmMUdFL/9Me2dr5Kz1CbizUNtkjhk5XN0C/mbZ+Rok0A5DgODX+
	5vjsMSFOcfRS9JWzk8w2m4W8E8fGfnnUisDzwkGskIYZLnrjEirfPpDuxKxl0etaE1wmMZ8xUQZ
	9J8eHipoTv0WSxiVJlCJoiuLVHppNYFTKkYWvBVGtLXKBgrP0wvlb8Cm1ESV8+ZSJaOPwKkNLqC
	9kLj2D5sofs8WlnIvS3mAzeJgCbxBajsSHZt4oRFSiw==
X-Google-Smtp-Source: AGHT+IFrLsup/zlKl9VPJLG+MwLiZxV8wgI92Vfbd7yMnlWhB00wvnSNTUodtgetR+EuOfYKqbwlrA==
X-Received: by 2002:a17:90b:3d4d:b0:327:be20:cd8a with SMTP id 98e67ed59e1d1-3280d381b25mr15013382a91.17.1756797991765;
        Tue, 02 Sep 2025 00:26:31 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d9347189sm13416648a91.9.2025.09.02.00.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:26:31 -0700 (PDT)
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
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 1/5] net: add a common function to compute features from lowers devices
Date: Tue,  2 Sep 2025 07:25:58 +0000
Message-ID: <20250902072602.361122-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902072602.361122-1-liuhangbin@gmail.com>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
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
 net/core/dev.c            | 76 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

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
index 1d1650d9ecff..5c1c8b016c8e 100644
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
+
+		tso_max_size = min(tso_max_size, lower_dev->tso_max_size);
+		tso_max_segs = min(tso_max_segs, lower_dev->tso_max_segs);
+	}
+
+	dev->gso_partial_features = gso_partial_features;
+	dev->vlan_features = vlan_features;
+#ifdef CONFIG_XFRM_OFFLOAD
+	dev->hw_enc_features |= xfrm_features;
+#endif
+	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
+				    NETIF_F_HW_VLAN_CTAG_TX |
+				    NETIF_F_HW_VLAN_STAG_TX;
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


