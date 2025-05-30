Return-Path: <linux-kselftest+bounces-34037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57727AC8786
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 06:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BFB27AD317
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 04:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21EE21CA0F;
	Fri, 30 May 2025 04:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="oLEXeZTY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138CB21B9D3
	for <linux-kselftest@vger.kernel.org>; Fri, 30 May 2025 04:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748580654; cv=none; b=SYKdaM9BhHSk1txB5zGdCyoAG4SPnqmknIowSgJ5Z+gaK1I2InBohNtIMPaS1eUcrqNxzS2+SPIBYNmEdA1nQHUY+PmIBK0yfW9LJYh+QdL9D/bFlxFmqCyc4X7lP1+8/ErexV9LR+tRyG+NamqEv50QVFobR9hw5s3w6i9CAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748580654; c=relaxed/simple;
	bh=A8mykslZWwIG4FNXV3Lm1NuXd/xH3TVuhPhWYtSjv/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Y0sVOzKVate1TDh1CUg6U1EsIng3qrDtq7atTqZ29ABgdPb+Y99O9IQe69vHbupcm3TnKwrabj4ZarbX0iaMbspM+tz4ar2zjkbQmrDy7ZlnRqMfRSJoEFDg7Ea5xRPX1uxYUjX/isYRBx469bKhb7dqFsmXCngUeFag0FlevnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=oLEXeZTY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b170c99aa49so1030916a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 21:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748580652; x=1749185452; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G36+4ZP77wTYjNEOu/qcKvp0kJ+h6b0T8zIdMEmaFXg=;
        b=oLEXeZTYALbN8LFRgFP2VADJkzayCKk2AJAAiMe8Y+9o3dr3k02sbXHYqNiqRgq/zH
         rdvVz6aU/2t6VskVJEWfziAExSFExMXqsU6FYsKIDuMdxmhPI44G/f3BgKCcla9ULf02
         zhrpP+7bZXgw2gryH28qJpHV5dKciwrM2o9F7YnWKYa6+/7GsrR10nTybAAftkw/zf09
         A2rD5uZDyqo/NdrMKh47Hq/7DjVM/ETfBa2BWjVEEk8xKaAfZ8kxVhpK/zai5lHuMbVw
         EFXMrzg4bXJgPgE4ZMgBb8bVTpkhQfv0+jobnPHEsN6fqcZmZvmyC8Zu55DxjcBe7bGa
         pjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748580652; x=1749185452;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G36+4ZP77wTYjNEOu/qcKvp0kJ+h6b0T8zIdMEmaFXg=;
        b=Ke55Xi/HR86243ojfuJWSUPPct7bVp2om5E2X/gJwAlgXsO9TYaXZxHL2TtGvFR7aL
         aRDM2BkC7mztNYFi3G97mvQsZ37KpmZ3rwHGPv0knrk4rItu6IZYxg/s4YnDQqXeiwnO
         lmFrVOgebiANTxskDmO7ypOdjy+nsqVQZv1nulwWLp/GGbhsA/AiM/ASXM0Qel8lUkF1
         NMgp9TU2ryxGbkyRXGNwWLLUuO7DhThb+nEEijY+kCywCzm5hix05MVliR9uPcq3A4c7
         t5/3zSmTxuHCO/EYDZ60nDqZ3EuS/sOPGnACIgiW2SzFsJchquCITjsDGDj7K2+cjutd
         R8nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHh/B3Q4aoQLc0mfYgyxM9ta47XpVeuBvtSQUVDbIanDvjjsaT+FZ+rzgKzIvlSmczBkIrNdYNe9AgrmnviiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+KQy9vKVablhIE1iL1urVeB8epu7SEL3x7J8Smq4Ez15KT4Pv
	Wd1794aWrfAsAXUPes4eJsILsA9Vi3Eeb3ozqXmsPGNqdrD0snz9eLOLLnpIipEy7C8=
X-Gm-Gg: ASbGnctqPHmX7gaio0fjnNboTJyTqCyqrTfT2Bp9pD8p9BtttRF4qBoKZA7T7ejafFz
	w0/atO8D521GjoC6j4bZjiQZDr8L1WhZ669Zs8s4jgUlgA0mSVcvkiRoGPL7yuLy3Qea5RhMWYP
	RsLyDUCYpZ1fA7H2b0peLBlQcFHsxyG5mEez+QYRJWO8X6+xJsd1jk6J+kLBAYTLGk3S++P9cu2
	8nR9BLW4ow5roD6DaAqu2or3U6moG6ZP2vw+F3uCxphzmbEI4ecEvXWQGK191wO/1AIaK2ChACH
	bnIMDByfTsyy4MWECXcfi5n3UAnTDLnX9eFiEGn6vUgFgtMX0Toi9Zp+7fpI1hg=
X-Google-Smtp-Source: AGHT+IGEoKVWjQvlEBQztN2LsXcTxfvwZkaCujBOiYLFoWDDJ4OZ1o9Irvn0v8iXfsBShaZWmZtyaw==
X-Received: by 2002:a17:902:d4cd:b0:234:f580:9f5 with SMTP id d9443c01a7336-235289c818bmr28919365ad.9.1748580652210;
        Thu, 29 May 2025 21:50:52 -0700 (PDT)
Received: from localhost ([157.82.128.1])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506cd342dsm20124795ad.148.2025.05.29.21.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 21:50:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:50:10 +0900
Subject: [PATCH net-next v12 06/10] tap: Introduce virtio-net hash feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-rss-v12-6-95d8b348de91@daynix.com>
References: <20250530-rss-v12-0-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-0-95d8b348de91@daynix.com>
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

Add ioctls and storage required for the virtio-net hash feature to TAP.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/ipvlan/ipvtap.c |  2 +-
 drivers/net/macvtap.c       |  2 +-
 drivers/net/tap.c           | 72 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/if_tap.h      |  4 ++-
 4 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index 1afc4c47be73..305438abf7ae 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -114,7 +114,7 @@ static void ipvtap_dellink(struct net_device *dev,
 	struct ipvtap_dev *vlan = netdev_priv(dev);
 
 	netdev_rx_handler_unregister(dev);
-	tap_del_queues(&vlan->tap);
+	tap_del(&vlan->tap);
 	ipvlan_link_delete(dev, head);
 }
 
diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
index 29a5929d48e5..e72144d05ef4 100644
--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -122,7 +122,7 @@ static void macvtap_dellink(struct net_device *dev,
 	struct macvtap_dev *vlantap = netdev_priv(dev);
 
 	netdev_rx_handler_unregister(dev);
-	tap_del_queues(&vlantap->tap);
+	tap_del(&vlantap->tap);
 	macvlan_dellink(dev, head);
 }
 
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 25c60ff2d3f2..15f056d7f632 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -49,6 +49,10 @@ struct major_info {
 	struct list_head next;
 };
 
+struct tap_skb_cb {
+	struct virtio_net_hash hash;
+};
+
 #define GOODCOPY_LEN 128
 
 static const struct proto_ops tap_socket_ops;
@@ -179,9 +183,20 @@ static void tap_put_queue(struct tap_queue *q)
 	sock_put(&q->sk);
 }
 
+static struct tap_skb_cb *tap_skb_cb(const struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(struct tap_skb_cb));
+	return (struct tap_skb_cb *)skb->cb;
+}
+
+static struct virtio_net_hash *tap_add_hash(struct sk_buff *skb)
+{
+	return &tap_skb_cb(skb)->hash;
+}
+
 static const struct virtio_net_hash *tap_find_hash(const struct sk_buff *skb)
 {
-	return NULL;
+	return &tap_skb_cb(skb)->hash;
 }
 
 /*
@@ -194,6 +209,7 @@ static const struct virtio_net_hash *tap_find_hash(const struct sk_buff *skb)
 static struct tap_queue *tap_get_queue(struct tap_dev *tap,
 				       struct sk_buff *skb)
 {
+	struct flow_keys_basic keys_basic;
 	struct tap_queue *queue = NULL;
 	/* Access to taps array is protected by rcu, but access to numvtaps
 	 * isn't. Below we use it to lookup a queue, but treat it as a hint
@@ -201,17 +217,47 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
 	 * racing against queue removal.
 	 */
 	int numvtaps = READ_ONCE(tap->numvtaps);
+	struct tun_vnet_hash *vnet_hash = rcu_dereference(tap->vnet_hash);
 	__u32 rxq;
 
+	*tap_skb_cb(skb) = (struct tap_skb_cb) {
+		.hash = { .report = VIRTIO_NET_HASH_REPORT_NONE }
+	};
+
 	if (!numvtaps)
 		goto out;
 
 	if (numvtaps == 1)
 		goto single;
 
+	if (vnet_hash) {
+		if (vnet_hash->rss) {
+			rxq = tun_vnet_rss_select_queue(numvtaps, vnet_hash, skb, tap_add_hash);
+			queue = rcu_dereference(tap->taps[rxq]);
+			goto out;
+		}
+
+		if (!skb->l4_hash && !skb->sw_hash) {
+			struct flow_keys keys;
+
+			skb_flow_dissect_flow_keys(skb, &keys, FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
+			rxq = flow_hash_from_keys(&keys);
+			keys_basic = (struct flow_keys_basic) {
+				.control = keys.control,
+				.basic = keys.basic
+			};
+		} else {
+			skb_flow_dissect_flow_keys_basic(NULL, skb, &keys_basic, NULL, 0, 0, 0,
+							 FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
+			rxq = skb->hash;
+		}
+	} else {
+		rxq = skb_get_hash(skb);
+	}
+
 	/* Check if we can use flow to select a queue */
-	rxq = skb_get_hash(skb);
 	if (rxq) {
+		tun_vnet_hash_report(vnet_hash, skb, &keys_basic, rxq, tap_add_hash);
 		queue = rcu_dereference(tap->taps[rxq % numvtaps]);
 		goto out;
 	}
@@ -234,10 +280,10 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
 
 /*
  * The net_device is going away, give up the reference
- * that it holds on all queues and safely set the pointer
- * from the queues to NULL.
+ * that it holds on all queues, safely set the pointer
+ * from the queues to NULL, and free vnet_hash.
  */
-void tap_del_queues(struct tap_dev *tap)
+void tap_del(struct tap_dev *tap)
 {
 	struct tap_queue *q, *tmp;
 
@@ -254,8 +300,10 @@ void tap_del_queues(struct tap_dev *tap)
 	BUG_ON(tap->numqueues);
 	/* guarantee that any future tap_set_queue will fail */
 	tap->numvtaps = MAX_TAP_QUEUES;
+
+	kfree_rcu_mightsleep(rtnl_dereference(tap->vnet_hash));
 }
-EXPORT_SYMBOL_GPL(tap_del_queues);
+EXPORT_SYMBOL_GPL(tap_del);
 
 rx_handler_result_t tap_handle_frame(struct sk_buff **pskb)
 {
@@ -998,6 +1046,18 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 		rtnl_unlock();
 		return ret;
 
+	case TUNGETVNETHASHTYPES:
+		return tun_vnet_ioctl_gethashtypes(argp);
+
+	case TUNSETVNETREPORTINGAUTOMQ:
+	case TUNSETVNETREPORTINGRSS:
+	case TUNSETVNETRSS:
+		rtnl_lock();
+		tap = rtnl_dereference(q->tap);
+		ret = tap ? tun_vnet_ioctl_sethash(&tap->vnet_hash, cmd, argp) : -EBADFD;
+		rtnl_unlock();
+		return ret;
+
 	case SIOCGIFHWADDR:
 		rtnl_lock();
 		tap = tap_get_tap_dev(q);
diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
index 553552fa635c..6647a7a9e956 100644
--- a/include/linux/if_tap.h
+++ b/include/linux/if_tap.h
@@ -31,6 +31,7 @@ static inline struct ptr_ring *tap_get_ptr_ring(struct file *f)
 #define MAX_TAP_QUEUES 256
 
 struct tap_queue;
+struct tun_vnet_hash;
 
 struct tap_dev {
 	struct net_device	*dev;
@@ -43,6 +44,7 @@ struct tap_dev {
 	int			numqueues;
 	netdev_features_t	tap_features;
 	int			minor;
+	struct tun_vnet_hash __rcu *vnet_hash;
 
 	void (*update_features)(struct tap_dev *tap, netdev_features_t features);
 	void (*count_tx_dropped)(struct tap_dev *tap);
@@ -74,7 +76,7 @@ struct tap_queue {
 };
 
 rx_handler_result_t tap_handle_frame(struct sk_buff **pskb);
-void tap_del_queues(struct tap_dev *tap);
+void tap_del(struct tap_dev *tap);
 int tap_get_minor(dev_t major, struct tap_dev *tap);
 void tap_free_minor(dev_t major, struct tap_dev *tap);
 int tap_queue_resize(struct tap_dev *tap);

-- 
2.49.0


