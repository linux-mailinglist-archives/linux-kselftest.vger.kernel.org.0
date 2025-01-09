Return-Path: <linux-kselftest+bounces-24104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C27A06ECE
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 08:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD998188936B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 07:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83623215077;
	Thu,  9 Jan 2025 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="GHBH9hnS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B272147FD
	for <linux-kselftest@vger.kernel.org>; Thu,  9 Jan 2025 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406873; cv=none; b=K9535MXsNsgpb6lkWY0oZSB4DkhUOfI+8H2ufMDCs1/6KRbIkxiHraBclH2DxCNWvbDr8sa5MfAnamw9Rehj/2vg7l/GtFa+/QzOXgeYT1iA9wOcM7DEJpkkFN/iuJctbVrxC6phCPzaT5+pH/OLNL6IKqKCi9+bG/Wjir0t6X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406873; c=relaxed/simple;
	bh=MpQggsHwcr3quFNH02GbFNFIU0odd3AYM9S/xEZ/LNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=XKm/9HBcKPaRgraCOYQYPWEjIOAbta9kTE7Ks3egmfQSYE01EFwsxMC9jl9WuOGc4GTf6QtsyWjzqWkwR7O3MRuoDRqbEkuCUh/RRkUapmfckWdl9mgIfFn7jIIzLwtcaOZN1w17nOLGVpHGsMRmvZbJuHYxoyBDvoKefT6MZTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=GHBH9hnS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2167141dfa1so10075605ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 23:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736406869; x=1737011669; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qq9olBgFYF/pH2ygQjYpyQkp0lSYfuRIO4vuFqVZVzg=;
        b=GHBH9hnSCUSdvJFQ1tSmW1GdzvWqzoG9BoXHeY9aaBt6eHPikCxH9iQVLVtCP3yl12
         YxVQeyxIGFqoCasButDzS4buXTAd+vJfyrYgjEcgnTiSxF9eelfJ+D9/eInbclVocrW6
         e0r5yPX77Kk3WtP7jUO9qbttNz8ZvuEakwqK29WMpGPtmYD1ER7CsDcbUS/m3EOaYHy/
         cYhfnbc/38tUB9DOqc4/Z7r/MVn2Ffih1HHUCdh4SSRe5/PA0nEdetvyJy10XUWbsTHM
         NRnEv7gwOBxVNXUG5CNIqM/8de92Wa9By4EIBogIxmLoKnfhZNSpFNc8nARIy94oaV0A
         afJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736406869; x=1737011669;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qq9olBgFYF/pH2ygQjYpyQkp0lSYfuRIO4vuFqVZVzg=;
        b=Ow4FjHVNsNymrPxZpGYFGlTXP92I8l3jBZo3LbBE8/eVGK+lYUwSV00VasvPwYY9OJ
         RnZef0pRls4yjjNLh4LvRfbulBiXQiV91L1EZzhQmrEL3xZYhMCvXorNt2F7UeaTpEo5
         SKRch0g4TBdbl4tIk3OSldnmxRoMEV+Nd58AAOt8QOs6bWJeGLJRtHQoOX9leYBIds/t
         IrLPXxEHBeOMXgJxHJK0gnjNGApwFEJ0duycWHXytdCCA/3flZclTi9WTjp4ZuVAxz4G
         prSP3339DLUsx3yqKxv1I/Y8owh/3hb0CzyxpHfNpBUlrJPSN0QFigJJVOhNDegn8acp
         eP4A==
X-Forwarded-Encrypted: i=1; AJvYcCWJjc/a89Vg+7xmQMSzlN3lKX3aHuESHqARF9RVxlziE5dW7lEO/WBvB6ljXVJlAcqZPUoYN/FtNDkRAksJvio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6TNPMi/N5M0GqBl6D+HxGS/BMumzMxBevb3UkBcaSvCkqZZZS
	YbacyqoYEFGJyS1IcHj8S+Ap4PuWiLyDRDAh3+lQObWU2NuqPPQP4VJRLyd/eNw=
X-Gm-Gg: ASbGncuUo2e7lkajRuynuMmLORNxuucBvj2/3xnY52K6duw3usSuEEgAl7SoyLgMZjm
	9nIGjQNcmrH+edLuTBsDqJCi6wjJoaLBfJn+DhvWfPFm0KK2f1R5XRFM4oQpHqe7a1gHubVv9fy
	g3R3JyHdhhZpRF2BBhiv8XADksJwcaeJriwiuHW2cJq8HLhr9bNLXGpaJDJ8eKNaAcaDTOMMftM
	wDskck2v+MOrfVT9wx/ZV4WCxWh94ZWvQLNHSFidZgIpIARxATRaz5d+Bs=
X-Google-Smtp-Source: AGHT+IF5rqwmvdGJejjG83zRMUuw2T7inCaslbbkkoui4rFBACLrV1Gs+Os+YPaps2pllaBXHudEvQ==
X-Received: by 2002:a17:902:ecd0:b0:216:3f6e:fabd with SMTP id d9443c01a7336-21a8d647c0fmr31237175ad.7.1736406868935;
        Wed, 08 Jan 2025 23:14:28 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-a31d5047e95sm598113a12.67.2025.01.08.23.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 23:14:28 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 16:13:41 +0900
Subject: [PATCH v6 3/6] tun: Introduce virtio-net hash feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rss-v6-3-b1c90ad708f6@daynix.com>
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
In-Reply-To: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

Hash reporting
--------------

Allow the guest to reuse the hash value to make receive steering
consistent between the host and guest, and to save hash computation.

RSS
---

RSS is a receive steering algorithm that can be negotiated to use with
virtio_net. Conventionally the hash calculation was done by the VMM.
However, computing the hash after the queue was chosen defeats the
purpose of RSS.

Another approach is to use eBPF steering program. This approach has
another downside: it cannot report the calculated hash due to the
restrictive nature of eBPF steering program.

Introduce the code to perform RSS to the kernel in order to overcome
thse challenges. An alternative solution is to extend the eBPF steering
program so that it will be able to report to the userspace, but I didn't
opt for it because extending the current mechanism of eBPF steering
program as is because it relies on legacy context rewriting, and
introducing kfunc-based eBPF will result in non-UAPI dependency while
the other relevant virtualization APIs such as KVM and vhost_net are
UAPIs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 Documentation/networking/tuntap.rst |   7 ++
 drivers/net/Kconfig                 |   1 +
 drivers/net/tap.c                   |  50 ++++++++++-
 drivers/net/tun.c                   |  93 +++++++++++++++-----
 drivers/net/tun_vnet.c              | 167 +++++++++++++++++++++++++++++++++---
 drivers/net/tun_vnet.h              |  33 ++++++-
 include/linux/if_tap.h              |   2 +
 include/linux/skbuff.h              |   3 +
 include/uapi/linux/if_tun.h         |  75 ++++++++++++++++
 net/core/skbuff.c                   |   4 +
 10 files changed, 397 insertions(+), 38 deletions(-)

diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
index 4d7087f727be..86b4ae8caa8a 100644
--- a/Documentation/networking/tuntap.rst
+++ b/Documentation/networking/tuntap.rst
@@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
       return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
   }
 
+3.4 Reference
+-------------
+
+``linux/if_tun.h`` defines the interface described below:
+
+.. kernel-doc:: include/uapi/linux/if_tun.h
+
 Universal TUN/TAP device driver Frequently Asked Question
 =========================================================
 
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 255c8f9f1d7c..f7b0d9a89a71 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -395,6 +395,7 @@ config TUN
 	tristate "Universal TUN/TAP device driver support"
 	depends on INET
 	select CRC32
+	select SKB_EXTENSIONS
 	select TUN_VNET
 	help
 	  TUN/TAP provides packet reception and transmission for user space
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index fe9554ee5b8b..27659df1f96e 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -179,6 +179,16 @@ static void tap_put_queue(struct tap_queue *q)
 	sock_put(&q->sk);
 }
 
+static struct virtio_net_hash *tap_add_hash(struct sk_buff *skb)
+{
+	return (struct virtio_net_hash *)skb->cb;
+}
+
+static const struct virtio_net_hash *tap_find_hash(const struct sk_buff *skb)
+{
+	return (const struct virtio_net_hash *)skb->cb;
+}
+
 /*
  * Select a queue based on the rxq of the device on which this packet
  * arrived. If the incoming device is not mq, calculate a flow hash
@@ -189,6 +199,7 @@ static void tap_put_queue(struct tap_queue *q)
 static struct tap_queue *tap_get_queue(struct tap_dev *tap,
 				       struct sk_buff *skb)
 {
+	struct flow_keys_basic keys_basic;
 	struct tap_queue *queue = NULL;
 	/* Access to taps array is protected by rcu, but access to numvtaps
 	 * isn't. Below we use it to lookup a queue, but treat it as a hint
@@ -196,17 +207,41 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
 	 * racing against queue removal.
 	 */
 	int numvtaps = READ_ONCE(tap->numvtaps);
+	struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tap->vnet_hash);
 	__u32 rxq;
 
+	*tap_add_hash(skb) = (struct virtio_net_hash) { .report = VIRTIO_NET_HASH_REPORT_NONE };
+
 	if (!numvtaps)
 		goto out;
 
 	if (numvtaps == 1)
 		goto single;
 
+	if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
+		rxq = tun_vnet_rss_select_queue(numvtaps, vnet_hash, skb, tap_add_hash);
+		queue = rcu_dereference(tap->taps[rxq]);
+		goto out;
+	}
+
+	if (!skb->l4_hash && !skb->sw_hash) {
+		struct flow_keys keys;
+
+		skb_flow_dissect_flow_keys(skb, &keys, FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
+		rxq = flow_hash_from_keys(&keys);
+		keys_basic = (struct flow_keys_basic) {
+			.control = keys.control,
+			.basic = keys.basic
+		};
+	} else {
+		skb_flow_dissect_flow_keys_basic(NULL, skb, &keys_basic, NULL, 0, 0, 0,
+						 FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
+		rxq = skb->hash;
+	}
+
 	/* Check if we can use flow to select a queue */
-	rxq = skb_get_hash(skb);
 	if (rxq) {
+		tun_vnet_hash_report(vnet_hash, skb, &keys_basic, rxq, tap_add_hash);
 		queue = rcu_dereference(tap->taps[rxq % numvtaps]);
 		goto out;
 	}
@@ -713,11 +748,12 @@ static ssize_t tap_put_user(struct tap_queue *q,
 	int total;
 
 	if (q->flags & IFF_VNET_HDR) {
-		struct virtio_net_hdr_v1 vnet_hdr;
+		struct virtio_net_hdr_v1_hash vnet_hdr;
 
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
-		ret = tun_vnet_hdr_from_skb(q->flags, NULL, skb, &vnet_hdr);
+		ret = tun_vnet_hdr_from_skb(vnet_hdr_len, q->flags, NULL, skb,
+					    tap_find_hash, &vnet_hdr);
 		if (ret < 0)
 			goto done;
 
@@ -1025,7 +1061,13 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 		return ret;
 
 	default:
-		return tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags, cmd, sp);
+		rtnl_lock();
+		tap = rtnl_dereference(q->tap);
+		ret = tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags,
+				     tap ? &tap->vnet_hash : NULL, -EINVAL,
+				     true, cmd, sp);
+		rtnl_unlock();
+		return ret;
 	}
 }
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index f211d0580887..efdbd2f65100 100644
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
@@ -451,20 +452,37 @@ static inline void tun_flow_save_rps_rxhash(struct tun_flow_entry *e, u32 hash)
 		e->rps_rxhash = hash;
 }
 
+static struct virtio_net_hash *tun_add_hash(struct sk_buff *skb)
+{
+	return skb_ext_add(skb, SKB_EXT_TUN_VNET_HASH);
+}
+
+static const struct virtio_net_hash *tun_find_hash(const struct sk_buff *skb)
+{
+	return skb_ext_find(skb, SKB_EXT_TUN_VNET_HASH);
+}
+
 /* We try to identify a flow through its rxhash. The reason that
  * we do not check rxq no. is because some cards(e.g 82599), chooses
  * the rxq based on the txq where the last packet of the flow comes. As
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
@@ -473,6 +491,13 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
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
 
@@ -500,10 +525,17 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 	u16 ret;
 
 	rcu_read_lock();
-	if (rcu_dereference(tun->steering_prog))
+	if (rcu_dereference(tun->steering_prog)) {
 		ret = tun_ebpf_select_queue(tun, skb);
-	else
-		ret = tun_automq_select_queue(tun, skb);
+	} else {
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
@@ -1991,8 +2023,8 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
 	size_t total;
 
 	if (tun->flags & IFF_VNET_HDR) {
-		struct virtio_net_hdr_v1 gso = {
-			.num_buffers = __virtio16_to_cpu(true, 1)
+		struct virtio_net_hdr_v1_hash gso = {
+			.hdr = { .num_buffers = __virtio16_to_cpu(true, 1) }
 		};
 
 		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
@@ -2021,7 +2053,6 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	int vlan_offset = 0;
 	int vlan_hlen = 0;
 	int vnet_hdr_sz = 0;
-	int ret;
 
 	if (skb_vlan_tag_present(skb))
 		vlan_hlen = VLAN_HLEN;
@@ -2046,9 +2077,11 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	}
 
 	if (vnet_hdr_sz) {
-		struct virtio_net_hdr_v1 gso;
+		struct virtio_net_hdr_v1_hash gso;
+		int ret;
 
-		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
+		ret = tun_vnet_hdr_from_skb(vnet_hdr_sz, tun->flags, tun->dev,
+					    skb, tun_find_hash, &gso);
 		if (ret < 0)
 			goto done;
 
@@ -2229,6 +2262,9 @@ static void tun_free_netdev(struct net_device *dev)
 	security_tun_dev_free_security(tun->security);
 	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
 	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
+	rtnl_lock();
+	kfree_rcu_mightsleep(rtnl_dereference(tun->vnet_hash));
+	rtnl_unlock();
 }
 
 static void tun_setup(struct net_device *dev)
@@ -2927,13 +2963,9 @@ static int tun_set_queue(struct file *file, struct ifreq *ifr)
 }
 
 static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
-			void __user *data)
+			int fd)
 {
 	struct bpf_prog *prog;
-	int fd;
-
-	if (copy_from_user(&fd, data, sizeof(fd)))
-		return -EFAULT;
 
 	if (fd == -1) {
 		prog = NULL;
@@ -3000,6 +3032,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	int sndbuf;
 	int ret;
 	bool do_notify = false;
+	struct tun_vnet_hash_container *vnet_hash;
 
 	if (cmd == TUNSETIFF || cmd == TUNSETQUEUE ||
 	    (_IOC_TYPE(cmd) == SOCK_IOC_TYPE && cmd != SIOCGSKNS)) {
@@ -3058,9 +3091,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		goto unlock;
 	}
 
-	ret = -EBADFD;
-	if (!tun)
+	if (!tun) {
+		ret = tun_vnet_ioctl(NULL, NULL, NULL, -EBADFD, true, cmd, argp);
 		goto unlock;
+	}
 
 	netif_info(tun, drv, tun->dev, "tun_chr_ioctl cmd %u\n", cmd);
 
@@ -3236,11 +3270,27 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	case TUNSETSTEERINGEBPF:
-		ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
+		if (get_user(ret, (int __user *)argp)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		vnet_hash = rtnl_dereference(tun->vnet_hash);
+		if (ret != -1 && vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
+			ret = -EBUSY;
+			break;
+		}
+
+		ret = tun_set_ebpf(tun, &tun->steering_prog, ret);
 		break;
 
 	case TUNSETFILTEREBPF:
-		ret = tun_set_ebpf(tun, &tun->filter_prog, argp);
+		if (get_user(ret, (int __user *)argp)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = tun_set_ebpf(tun, &tun->filter_prog, ret);
 		break;
 
 	case TUNSETCARRIER:
@@ -3259,7 +3309,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	default:
-		ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags, cmd, argp);
+		ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags,
+				     &tun->vnet_hash, -EINVAL,
+				     !rtnl_dereference(tun->steering_prog),
+				     cmd, argp);
 	}
 
 	if (do_notify)
diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
index a7a7989fae56..d36ca3b23265 100644
--- a/drivers/net/tun_vnet.c
+++ b/drivers/net/tun_vnet.c
@@ -58,18 +58,33 @@ static __virtio16 cpu_to_tun_vnet16(unsigned int flags, u16 val)
 }
 
 long tun_vnet_ioctl(int *sz, unsigned int *flags,
-		    unsigned int cmd, int __user *sp)
+		    struct tun_vnet_hash_container __rcu **hashp,
+		    long fallback, bool can_rss,
+		    unsigned int cmd, void __user *argp)
 {
+	static const struct tun_vnet_hash cap = {
+		.flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
+		.types = VIRTIO_NET_SUPPORTED_HASH_TYPES
+	};
+	struct tun_vnet_hash hash_buf;
+	struct tun_vnet_hash_container *hash;
+	int __user *sp = argp;
 	int s;
 
 	switch (cmd) {
 	case TUNGETVNETHDRSZ:
+		if (!sz)
+			return -EBADFD;
+
 		s = *sz;
 		if (put_user(s, sp))
 			return -EFAULT;
 		return 0;
 
 	case TUNSETVNETHDRSZ:
+		if (!sz)
+			return -EBADFD;
+
 		if (get_user(s, sp))
 			return -EFAULT;
 		if (s < (int)sizeof(struct virtio_net_hdr))
@@ -79,12 +94,18 @@ long tun_vnet_ioctl(int *sz, unsigned int *flags,
 		return 0;
 
 	case TUNGETVNETLE:
+		if (!flags)
+			return -EBADFD;
+
 		s = !!(*flags & TUN_VNET_LE);
 		if (put_user(s, sp))
 			return -EFAULT;
 		return 0;
 
 	case TUNSETVNETLE:
+		if (!flags)
+			return -EBADFD;
+
 		if (get_user(s, sp))
 			return -EFAULT;
 		if (s)
@@ -94,17 +115,132 @@ long tun_vnet_ioctl(int *sz, unsigned int *flags,
 		return 0;
 
 	case TUNGETVNETBE:
+		if (!flags)
+			return -EBADFD;
+
 		return tun_vnet_get_be(*flags, sp);
 
 	case TUNSETVNETBE:
+		if (!flags)
+			return -EBADFD;
+
 		return tun_vnet_set_be(flags, sp);
 
+	case TUNGETVNETHASHCAP:
+		return copy_to_user(argp, &cap, sizeof(cap)) ? -EFAULT : 0;
+
+	case TUNSETVNETHASH:
+		if (!hashp)
+			return -EBADFD;
+
+		if (copy_from_user(&hash_buf, argp, sizeof(hash_buf)))
+			return -EFAULT;
+		argp = (struct tun_vnet_hash __user *)argp + 1;
+
+		if (hash_buf.flags & TUN_VNET_HASH_RSS) {
+			struct tun_vnet_hash_rss rss;
+			size_t indirection_table_size;
+			size_t key_size;
+			size_t size;
+
+			if (!can_rss)
+				return -EBUSY;
+
+			if (copy_from_user(&rss, argp, sizeof(rss)))
+				return -EFAULT;
+			argp = (struct tun_vnet_hash_rss __user *)argp + 1;
+
+			indirection_table_size = ((size_t)rss.indirection_table_mask + 1) * 2;
+			key_size = virtio_net_hash_key_length(hash_buf.types);
+			size = struct_size(hash, rss_indirection_table,
+					   (size_t)rss.indirection_table_mask + 1);
+
+			hash = kmalloc(size, GFP_KERNEL);
+			if (!hash)
+				return -ENOMEM;
+
+			if (copy_from_user(hash->rss_indirection_table,
+					   argp, indirection_table_size)) {
+				kfree(hash);
+				return -EFAULT;
+			}
+			argp = (u16 __user *)argp + rss.indirection_table_mask + 1;
+
+			if (copy_from_user(hash->rss_key, argp, key_size)) {
+				kfree(hash);
+				return -EFAULT;
+			}
+
+			virtio_net_toeplitz_convert_key(hash->rss_key, key_size);
+			hash->rss = rss;
+		} else {
+			hash = kmalloc(sizeof(hash->common), GFP_KERNEL);
+			if (!hash)
+				return -ENOMEM;
+		}
+
+		hash->common = hash_buf;
+		kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(*hashp, hash));
+		return 0;
+
 	default:
-		return -EINVAL;
+		return fallback;
 	}
 }
 EXPORT_SYMBOL_GPL(tun_vnet_ioctl);
 
+void tun_vnet_hash_report(const struct tun_vnet_hash_container *hash,
+			  struct sk_buff *skb,
+			  const struct flow_keys_basic *keys,
+			  u32 value,
+			  tun_vnet_hash_add vnet_hash_add)
+{
+	struct virtio_net_hash *report;
+
+	if (!hash || !(hash->common.flags & TUN_VNET_HASH_REPORT))
+		return;
+
+	report = vnet_hash_add(skb);
+	if (!report)
+		return;
+
+	*report = (struct virtio_net_hash) {
+		.report = virtio_net_hash_report(hash->common.types, keys),
+		.value = value
+	};
+}
+EXPORT_SYMBOL_GPL(tun_vnet_hash_report);
+
+u16 tun_vnet_rss_select_queue(u32 numqueues,
+			      const struct tun_vnet_hash_container *hash,
+			      struct sk_buff *skb,
+			      tun_vnet_hash_add vnet_hash_add)
+{
+	struct virtio_net_hash *report;
+	struct virtio_net_hash ret;
+	u16 txq, index;
+
+	if (!numqueues)
+		return 0;
+
+	virtio_net_hash_rss(skb, hash->common.types, hash->rss_key, &ret);
+
+	if (!ret.report)
+		return hash->rss.unclassified_queue % numqueues;
+
+	if (hash->common.flags & TUN_VNET_HASH_REPORT) {
+		report = vnet_hash_add(skb);
+		if (report)
+			*report = ret;
+	}
+
+	index = ret.value & hash->rss.indirection_table_mask;
+	txq = READ_ONCE(hash->rss_indirection_table[index]);
+
+	return txq % numqueues;
+}
+EXPORT_SYMBOL_GPL(tun_vnet_rss_select_queue);
+
 int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
 		     struct virtio_net_hdr *hdr)
 {
@@ -130,7 +266,7 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
 EXPORT_SYMBOL_GPL(tun_vnet_hdr_get);
 
 int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
-		     const struct virtio_net_hdr_v1 *hdr)
+		     const struct virtio_net_hdr_v1_hash *hdr)
 {
 	int content_sz = MIN(sizeof(*hdr), sz);
 
@@ -154,11 +290,24 @@ int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(tun_vnet_hdr_to_skb);
 
-int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
+int tun_vnet_hdr_from_skb(int sz, unsigned int flags,
+			  const struct net_device *dev,
 			  const struct sk_buff *skb,
-			  struct virtio_net_hdr_v1 *hdr)
+			  tun_vnet_hash_find vnet_hash_find,
+			  struct virtio_net_hdr_v1_hash *hdr)
 {
 	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
+	const struct virtio_net_hash *report = sz < sizeof(struct virtio_net_hdr_v1_hash) ?
+					       NULL : vnet_hash_find(skb);
+
+	*hdr = (struct virtio_net_hdr_v1_hash) {
+		.hdr = { .num_buffers = __cpu_to_virtio16(true, 1) }
+	};
+
+	if (report) {
+		hdr->hash_value = cpu_to_le32(report->value);
+		hdr->hash_report = cpu_to_le16(report->report);
+	}
 
 	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
 				    tun_vnet_is_little_endian(flags), true,
@@ -167,19 +316,17 @@ int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
 
 		if (net_ratelimit()) {
 			netdev_err(dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
-				   sinfo->gso_type, tun_vnet16_to_cpu(flags, hdr->gso_size),
-				   tun_vnet16_to_cpu(flags, hdr->hdr_len));
+				   sinfo->gso_type, tun_vnet16_to_cpu(flags, hdr->hdr.gso_size),
+				   tun_vnet16_to_cpu(flags, hdr->hdr.hdr_len));
 			print_hex_dump(KERN_ERR, "tun: ",
 				       DUMP_PREFIX_NONE,
 				       16, 1, skb->head,
-				       min(tun_vnet16_to_cpu(flags, hdr->hdr_len), 64), true);
+				       min(tun_vnet16_to_cpu(flags, hdr->hdr.hdr_len), 64), true);
 		}
 		WARN_ON_ONCE(1);
 		return -EINVAL;
 	}
 
-	hdr->num_buffers = 1;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tun_vnet_hdr_from_skb);
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index d8fd94094227..046fb051d089 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -5,20 +5,45 @@
 #include <linux/if_tun.h>
 #include <linux/virtio_net.h>
 
+typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_buff *);
+typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const struct sk_buff *);
+
+struct tun_vnet_hash_container {
+	struct tun_vnet_hash common;
+	struct tun_vnet_hash_rss rss;
+	u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
+	u16 rss_indirection_table[];
+};
+
 long tun_vnet_ioctl(int *sz, unsigned int *flags,
-		    unsigned int cmd, int __user *sp);
+		    struct tun_vnet_hash_container __rcu **hashp,
+		    long fallback, bool can_rss,
+		    unsigned int cmd, void __user *argp);
+
+void tun_vnet_hash_report(const struct tun_vnet_hash_container *hash,
+			  struct sk_buff *skb,
+			  const struct flow_keys_basic *keys,
+			  u32 value,
+			  tun_vnet_hash_add vnet_hash_add);
+
+u16 tun_vnet_rss_select_queue(u32 numqueues,
+			      const struct tun_vnet_hash_container *hash,
+			      struct sk_buff *skb,
+			      tun_vnet_hash_add vnet_hash_add);
 
 int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
 		     struct virtio_net_hdr *hdr);
 
 int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
-		     const struct virtio_net_hdr_v1 *hdr);
+		     const struct virtio_net_hdr_v1_hash *hdr);
 
 int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
 			const struct virtio_net_hdr *hdr);
 
-int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
+int tun_vnet_hdr_from_skb(int sz, unsigned int flags,
+			  const struct net_device *dev,
 			  const struct sk_buff *skb,
-			  struct virtio_net_hdr_v1 *hdr);
+			  tun_vnet_hash_find vnet_hash_find,
+			  struct virtio_net_hdr_v1_hash *hdr);
 
 #endif /* TUN_VNET_H */
diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
index 553552fa635c..7334c46a3f10 100644
--- a/include/linux/if_tap.h
+++ b/include/linux/if_tap.h
@@ -31,6 +31,7 @@ static inline struct ptr_ring *tap_get_ptr_ring(struct file *f)
 #define MAX_TAP_QUEUES 256
 
 struct tap_queue;
+struct tun_vnet_hash_container;
 
 struct tap_dev {
 	struct net_device	*dev;
@@ -43,6 +44,7 @@ struct tap_dev {
 	int			numqueues;
 	netdev_features_t	tap_features;
 	int			minor;
+	struct tun_vnet_hash_container __rcu *vnet_hash;
 
 	void (*update_features)(struct tap_dev *tap, netdev_features_t features);
 	void (*count_tx_dropped)(struct tap_dev *tap);
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 58009fa66102..73214f1a378e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4813,6 +4813,9 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	SKB_EXT_MCTP,
+#endif
+#if IS_ENABLED(CONFIG_TUN)
+	SKB_EXT_TUN_VNET_HASH,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 287cdc81c939..4887f97500a8 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -62,6 +62,42 @@
 #define TUNSETCARRIER _IOW('T', 226, int)
 #define TUNGETDEVNETNS _IO('T', 227)
 
+/**
+ * define TUNGETVNETHASHCAP - ioctl to get virtio_net hashing capability.
+ *
+ * The argument is a pointer to &struct tun_vnet_hash which will store the
+ * maximal virtio_net hashing configuration.
+ */
+#define TUNGETVNETHASHCAP _IOR('T', 228, struct tun_vnet_hash)
+
+/**
+ * define TUNSETVNETHASH - ioctl to configure virtio_net hashing
+ *
+ * The argument is a pointer to &struct tun_vnet_hash.
+ *
+ * The argument is a pointer to the compound of the following in order if
+ * %TUN_VNET_HASH_RSS is set:
+ *
+ * 1. &struct tun_vnet_hash
+ * 2. &struct tun_vnet_hash_rss
+ * 3. Indirection table
+ * 4. Key
+ *
+ * The %TUN_VNET_HASH_REPORT flag set with this ioctl will be effective only
+ * after calling the %TUNSETVNETHDRSZ ioctl with a number greater than or equal
+ * to the size of &struct virtio_net_hdr_v1_hash.
+ *
+ * The members added to the legacy header by %TUN_VNET_HASH_REPORT flag will
+ * always be little-endian.
+ *
+ * This ioctl results in %EBADFD if the underlying device is deleted. It affects
+ * all queues attached to the same device.
+ *
+ * This ioctl currently has no effect on XDP packets and packets with
+ * queue_mapping set by TC.
+ */
+#define TUNSETVNETHASH _IOW('T', 229, struct tun_vnet_hash)
+
 /* TUNSETIFF ifr flags */
 #define IFF_TUN		0x0001
 #define IFF_TAP		0x0002
@@ -115,4 +151,43 @@ struct tun_filter {
 	__u8   addr[][ETH_ALEN];
 };
 
+/**
+ * define TUN_VNET_HASH_REPORT - Request virtio_net hash reporting for vhost
+ */
+#define TUN_VNET_HASH_REPORT	0x0001
+
+/**
+ * define TUN_VNET_HASH_RSS - Request virtio_net RSS
+ *
+ * This is mutually exclusive with eBPF steering program.
+ */
+#define TUN_VNET_HASH_RSS	0x0002
+
+/**
+ * struct tun_vnet_hash - virtio_net hashing configuration
+ * @flags:
+ *		Bitmask consists of %TUN_VNET_HASH_REPORT and %TUN_VNET_HASH_RSS
+ * @pad:
+ *		Should be filled with zero before passing to %TUNSETVNETHASH
+ * @types:
+ *		Bitmask of allowed hash types
+ */
+struct tun_vnet_hash {
+	__u16 flags;
+	__u8 pad[2];
+	__u32 types;
+};
+
+/**
+ * struct tun_vnet_hash_rss - virtio_net RSS configuration
+ * @indirection_table_mask:
+ *		Bitmask to be applied to the indirection table index
+ * @unclassified_queue:
+ *		The index of the queue to place unclassified packets in
+ */
+struct tun_vnet_hash_rss {
+	__u16 indirection_table_mask;
+	__u16 unclassified_queue;
+};
+
 #endif /* _UAPI__IF_TUN_H */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6841e61a6bd0..97b22833905d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -64,6 +64,7 @@
 #include <linux/mpls.h>
 #include <linux/kcov.h>
 #include <linux/iov_iter.h>
+#include <linux/virtio_net.h>
 
 #include <net/protocol.h>
 #include <net/dst.h>
@@ -5059,6 +5060,9 @@ static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	[SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
 #endif
+#if IS_ENABLED(CONFIG_TUN)
+	[SKB_EXT_TUN_VNET_HASH] = SKB_EXT_CHUNKSIZEOF(struct virtio_net_hash),
+#endif
 };
 
 static __always_inline unsigned int skb_ext_total_length(void)

-- 
2.47.1


