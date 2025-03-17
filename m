Return-Path: <linux-kselftest+bounces-29211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 633E9A64B6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 12:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824C018912CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6925823BD1F;
	Mon, 17 Mar 2025 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Tqy/NZ61"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA57623BCFF
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209121; cv=none; b=nEfVD8o2gYVyoFnDG9G40z45WLWJ0qFDIKrbcQh6F5U2F8kxz0QpJYho86czwhbxcV6w6N2ajHlc1Xa2YPmqY8R7hWv0k2aZzLicGFoIWMbWnRmxI2o+CJ+TAqAmoWCTfhDp2WC2s4RrozHlMH9bV5WevZ4kmrUtq5ucoAN6DSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209121; c=relaxed/simple;
	bh=fAsNygmBH4vEFfwnr1O256Ehqy/tj24JUzQEngxqzTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=bNTuss7wd4ROmhMXDZ2OciDPuw2hOEeLG2ym2bagcGjSKXxC/W6YH1HfyhvWRd4WUFiwpvTNYDP2oiDFhbRkpwjEfgLnOtopiItR6diP984p1G8Zw1+vgVGE5eTOHIuzuHrrUAa945EjyBSA06ryegMRZS1y7+a0o0eb7NiU2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Tqy/NZ61; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223594b3c6dso82148205ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 03:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742209119; x=1742813919; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEx1oB+WR7O6v2TIINfyTS8xxjNqfeRuV0OaAnQT/3s=;
        b=Tqy/NZ61rI7ApMk1xalcVcd0wmH7ifXVgMH9+3JmaJxwYApsTu+p904ABYNA/eMGyR
         GCadMhcYlulL0HIcKtojDyCV5UYEYG8zaEbAbxAVlTmIDkqDyDiGWxUSPNdskTDA6nT4
         vSPhUH3uLdj1qK8lMrNi1SulCvNEsZyoDwODiWpM+K5ZdCXlhrpNLDsH2UnCOxbJ54iz
         8bcuOCT4Upfr9RUuy02tYp1UekDuvmh/mZWHa8VB9PkEpSsXpitmg+m8Cf8wBwN0zd0Q
         a9yUCoOkHtianBCk+PorQwfrkfbKMjnTtZW6c5tYb9MEkBzBO0VVDrc4xTk7cM6EL6bE
         duMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209119; x=1742813919;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEx1oB+WR7O6v2TIINfyTS8xxjNqfeRuV0OaAnQT/3s=;
        b=AK60ULhB0owrP++zpXHuAk04eD/mRmuPHKRss1Nh96sPpyXhEd/JrL7uJxgSjCtRzW
         PtBrdrVUe3OBwDb9wzeIcJslCPiHW3gkBVrikXPnqycx4H6yzUOSEoX+sg5xMVM4L61N
         ZEZly/UNcqn7hwjOmWMfNpwVfJj/PSVsPheNZwP9B3ZSAA2k45DcspivfYZYFKKLUcMd
         aWCnKVa4o93n2LWHcyO9gp2k6vRHg5W7giWDILO6DITj2Wan757glLZBqCZ0vFVr98Qf
         /rGzaZ1xlOw6ONDhOuoICbe/wj19EzkEqT/toaC75H2UV7KjGQ2wKk642Ji4gU69VI8Y
         rO3w==
X-Forwarded-Encrypted: i=1; AJvYcCWbT1yQ52Wykm1BIHar0dbtjuYncWXWoiSuIsvbPJFVKGNAI9CFB7H2umms6A1eK3tUiUJOKYqZAer2isJMjJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1xLd73MaL6VXWp2NtNXJscACrjMq/dM0/VFrpCUl15WNZAOz2
	4ViHz58gCVMZfltiTOMc6TQSeWNA9oUKwfUZ9GvFhc5dPe4yWj75iaM1c4ODJJg=
X-Gm-Gg: ASbGncsmyGDGaiE4U2TK03BFIqohahAxzb+X8k06hujOMf+ySRUAwFzOmTgbsZmlZWK
	90Y32gDuZ40QFc9KNZMczL/ybjRmCnwx0YUyy4wJirItKrBSISrcjfMUqK7XyJlgNx9NZ5h7CQJ
	FGnqDFWFpA3BnT51om4n9Es7SiLQ41ZlfJdxeye3JahT6Kzo03u0nF/8vBIwIDnoSG4uNPo1iEo
	KvojtDcRKaVGViLh/nhraMlGEcAhhmrmNrF8eswQZv5FvtWbeRMy0e55bEKfjQ6x/RMuJI3x3K/
	jyqplQxxmSTl7FECmjCth1bZnHjx5s1VlnH9yeBZbE1ztXV7
X-Google-Smtp-Source: AGHT+IHX4HyK1k//tjemW3f4I2XPhHcKoJYNfaunw3BDHkKS92XkMFCdfmRLmOxFS0Kbm0S3BYpFzQ==
X-Received: by 2002:a05:6a21:6f12:b0:1f5:5807:13c7 with SMTP id adf61e73a8af0-1f5c118e6abmr15940192637.17.1742209118936;
        Mon, 17 Mar 2025 03:58:38 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-737115294besm7237748b3a.21.2025.03.17.03.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:58:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 17 Mar 2025 19:57:55 +0900
Subject: [PATCH net-next v11 05/10] tun: Introduce virtio-net hash feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rss-v11-5-4cacca92f31f@daynix.com>
References: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
In-Reply-To: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

Add ioctls and storage required for the virtio-net hash feature to TUN.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/Kconfig    |  1 +
 drivers/net/tun.c      | 54 ++++++++++++++++++++++++++++++++++++++++++--------
 include/linux/skbuff.h |  3 +++
 net/core/skbuff.c      |  4 ++++
 4 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 1fd5acdc73c6..aecfd244dd83 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -395,6 +395,7 @@ config TUN
 	tristate "Universal TUN/TAP device driver support"
 	depends on INET
 	select CRC32
+	select SKB_EXTENSIONS
 	help
 	  TUN/TAP provides packet reception and transmission for user space
 	  programs.  It can be viewed as a simple Point-to-Point or Ethernet
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 03d47799e9bd..b2d74e0ec932 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -209,6 +209,7 @@ struct tun_struct {
 	struct bpf_prog __rcu *xdp_prog;
 	struct tun_prog __rcu *steering_prog;
 	struct tun_prog __rcu *filter_prog;
+	struct tun_vnet_hash_container __rcu *vnet_hash;
 	struct ethtool_link_ksettings link_ksettings;
 	/* init args */
 	struct file *file;
@@ -451,9 +452,14 @@ static inline void tun_flow_save_rps_rxhash(struct tun_flow_entry *e, u32 hash)
 		e->rps_rxhash = hash;
 }
 
+static struct virtio_net_hash *tun_add_hash(struct sk_buff *skb)
+{
+	return skb_ext_add(skb, SKB_EXT_TUN_VNET_HASH);
+}
+
 static const struct virtio_net_hash *tun_find_hash(const struct sk_buff *skb)
 {
-	return NULL;
+	return skb_ext_find(skb, SKB_EXT_TUN_VNET_HASH);
 }
 
 /* We try to identify a flow through its rxhash. The reason that
@@ -462,14 +468,21 @@ static const struct virtio_net_hash *tun_find_hash(const struct sk_buff *skb)
  * the userspace application move between processors, we may get a
  * different rxq no. here.
  */
-static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
+static u16 tun_automq_select_queue(struct tun_struct *tun,
+				   const struct tun_vnet_hash_container *vnet_hash,
+				   struct sk_buff *skb)
 {
+	struct flow_keys keys;
+	struct flow_keys_basic keys_basic;
 	struct tun_flow_entry *e;
 	u32 txq, numqueues;
 
 	numqueues = READ_ONCE(tun->numqueues);
 
-	txq = __skb_get_hash_symmetric(skb);
+	memset(&keys, 0, sizeof(keys));
+	skb_flow_dissect(skb, &flow_keys_dissector_symmetric, &keys, 0);
+
+	txq = flow_hash_from_keys(&keys);
 	e = tun_flow_find(&tun->flows[tun_hashfn(txq)], txq);
 	if (e) {
 		tun_flow_save_rps_rxhash(e, txq);
@@ -478,6 +491,13 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 		txq = reciprocal_scale(txq, numqueues);
 	}
 
+	keys_basic = (struct flow_keys_basic) {
+		.control = keys.control,
+		.basic = keys.basic
+	};
+	tun_vnet_hash_report(vnet_hash, skb, &keys_basic, skb->l4_hash ? skb->hash : txq,
+			     tun_add_hash);
+
 	return txq;
 }
 
@@ -513,8 +533,15 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 	u16 ret;
 
 	rcu_read_lock();
-	if (!tun_ebpf_select_queue(tun, skb, &ret))
-		ret = tun_automq_select_queue(tun, skb);
+	if (!tun_ebpf_select_queue(tun, skb, &ret)) {
+		struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tun->vnet_hash);
+
+		if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS))
+			ret = tun_vnet_rss_select_queue(READ_ONCE(tun->numqueues), vnet_hash,
+							skb, tun_add_hash);
+		else
+			ret = tun_automq_select_queue(tun, vnet_hash, skb);
+	}
 	rcu_read_unlock();
 
 	return ret;
@@ -2235,6 +2262,7 @@ static void tun_free_netdev(struct net_device *dev)
 	security_tun_dev_free_security(tun->security);
 	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
 	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
+	kfree_rcu_mightsleep(rcu_access_pointer(tun->vnet_hash));
 }
 
 static void tun_setup(struct net_device *dev)
@@ -3014,16 +3042,22 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	} else {
 		memset(&ifr, 0, sizeof(ifr));
 	}
-	if (cmd == TUNGETFEATURES) {
+	switch (cmd) {
+	case TUNGETFEATURES:
 		/* Currently this just means: "what IFF flags are valid?".
 		 * This is needed because we never checked for invalid flags on
 		 * TUNSETIFF.
 		 */
 		return put_user(IFF_TUN | IFF_TAP | IFF_NO_CARRIER |
 				TUN_FEATURES, (unsigned int __user*)argp);
-	} else if (cmd == TUNSETQUEUE) {
+
+	case TUNSETQUEUE:
 		return tun_set_queue(file, &ifr);
-	} else if (cmd == SIOCGSKNS) {
+
+	case TUNGETVNETHASHCAP:
+		return tun_vnet_ioctl_gethashcap(argp);
+
+	case SIOCGSKNS:
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 		return open_related_ns(&net->ns, get_net_ns);
@@ -3264,6 +3298,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = open_related_ns(&net->ns, get_net_ns);
 		break;
 
+	case TUNSETVNETHASH:
+		ret = tun_vnet_ioctl_sethash(&tun->vnet_hash, argp);
+		break;
+
 	default:
 		ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags, cmd, argp);
 		break;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274a..cdd793f1c360 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4842,6 +4842,9 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	SKB_EXT_MCTP,
+#endif
+#if IS_ENABLED(CONFIG_TUN)
+	SKB_EXT_TUN_VNET_HASH,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7b03b64fdcb2..aa2a091b649f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -64,6 +64,7 @@
 #include <linux/mpls.h>
 #include <linux/kcov.h>
 #include <linux/iov_iter.h>
+#include <linux/virtio_net.h>
 
 #include <net/protocol.h>
 #include <net/dst.h>
@@ -4969,6 +4970,9 @@ static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	[SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
 #endif
+#if IS_ENABLED(CONFIG_TUN)
+	[SKB_EXT_TUN_VNET_HASH] = SKB_EXT_CHUNKSIZEOF(struct virtio_net_hash),
+#endif
 };
 
 static __always_inline unsigned int skb_ext_total_length(void)

-- 
2.48.1


