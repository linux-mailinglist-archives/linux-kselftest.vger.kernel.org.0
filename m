Return-Path: <linux-kselftest+bounces-19209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50371994011
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 09:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0E0289627
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 07:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F741E884F;
	Tue,  8 Oct 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="f5+LxzEf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BFD1E8836
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370513; cv=none; b=uosLm00gluZpwSYgmKAbNiemF/0U4SmhbkXSYBT8VJhG9PubRj3+bPC5DKKn3B41LwC1NU5xSp6HmB3N9rSH9bzm7hI42IeZpNHmvZV1beuUezT4S37x0ObJUnkDOwNWHgq9jacMxRD5edbEliSWu0hRazgOvYKIEJfvkz3aUQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370513; c=relaxed/simple;
	bh=R0ayEEoH7zV14w05caZenXZ/4uRpgQ5UGzQNu6e7X4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=qbDp+56fy7Pi4o1vRW4r93fH3s2LNw/SlIU0BUMu1bOAnKQNXHNXsT+veeqMwmuiT80L1psSI02ttqJo1z5Lv56kU5rjsay+U0A3RXZrRbDTm53fwFOExp/yXUC+TB1NRG092ZcLwhlpWw0FaSaBFwroi6mFGl6qZIglCzgKShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=f5+LxzEf; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso3848398a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2024 23:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370511; x=1728975311; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DA2oj7H5OVZ6lSTog1r2qmjn4a38P1HWbQEDFGyFaSY=;
        b=f5+LxzEfoJMk++7P9MQTmhqWJJJCpIxVZMm6Fdfb5RPB8U8Q0xETLsTMb+gHJtI5BW
         hpWRKUmAl7HkRm2WfYhteRkeVlDMSD6bZYeti5d+p7uOArO8vZPllnFAw3XtbxkPnRd6
         MPQuB2vTDhPMJS+4e+rta/AgRF+W+1Hy7napIDTP4gLXIxODgU1MPj4ts7RWSoLugrek
         TuJ1P6L40JyVC/AWXZ0IpHaDkCyJFlRCiqzV/zhg9c8WwS7tQEdHqlvZdJgW+uDsTNF6
         Gd7T1iWEQmO+KdSJBjoSiW9erIE6VNwS6fS7MkYyD5VZpbrAJcCOAnjbp/Jo2Ov5yw8u
         yKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370511; x=1728975311;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DA2oj7H5OVZ6lSTog1r2qmjn4a38P1HWbQEDFGyFaSY=;
        b=YtPtbCK37PA9FtVzu/DwDxseWrV6Q/xrYyn++AuOZA6A+N5c0/ODdEVVFxHvN161pn
         bP7h2Mh9nWKhTrrL/TAsfFl42nF5hPDmSlgJdPwTCtbqVgYbaN2ST0QwgWABiqxsjipZ
         Cr/xNqM4deuwT1eaN+4g/ywdxtFIpDiJdHEU5sZoSQz5Yx8e1Uh99j9dcjQU7ZXSRXyb
         U/S6A5GoQPae/oUk1uousnEtT5wHcfQczb5myLdOfVjIsjVRnfIAhL0spr346wpedecY
         ER0H7OL1qI3OtDQpfWpW2cr8hnWzNxI6uupC3UB3Fu5gBEqKGVUtmH1XYBGKoIabj1ZJ
         ZXAA==
X-Forwarded-Encrypted: i=1; AJvYcCXJlre7bLIW8y5VDWaWSrocexqn3yFKYTD8zHnYWjScwm87dFSVWZ9c7cZ0a5DyRmgiJpEU+HjG9YGtg482vKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZYnBlq1zjIIYmwAwhwc2JwSv7Gr+u8JALQFT10Bjx3RccI9VX
	AHXAiLpFkBfGhHhUnsghUvUbhTdpTf0l2f44FwM94SaQj7n8TqY4uhSINAvrSUk=
X-Google-Smtp-Source: AGHT+IH/PdPnRx/AzUAEXbpjOGjVmc/RfKcOPN1NNNnBFyBJ/p3nDKSCwUMJJzzYWLwu0D/gF10UIw==
X-Received: by 2002:a05:6a20:c916:b0:1d2:e8d8:dd46 with SMTP id adf61e73a8af0-1d6dfa33c7fmr23701211637.15.1728370511203;
        Mon, 07 Oct 2024 23:55:11 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71df0cbbac6sm5466931b3a.39.2024.10.07.23.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:55:10 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 08 Oct 2024 15:54:26 +0900
Subject: [PATCH RFC v5 06/10] tun: Introduce virtio-net hash reporting
 feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-rss-v5-6-f3cf68df005d@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
In-Reply-To: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
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

Allow the guest to reuse the hash value to make receive steering
consistent between the host and guest, and to save hash computation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 Documentation/networking/tuntap.rst |   7 +++
 drivers/net/Kconfig                 |   1 +
 drivers/net/tap.c                   |  45 ++++++++++++++--
 drivers/net/tun.c                   |  46 ++++++++++++----
 drivers/net/tun_vnet.h              | 102 +++++++++++++++++++++++++++++++-----
 include/linux/if_tap.h              |   2 +
 include/uapi/linux/if_tun.h         |  48 +++++++++++++++++
 7 files changed, 223 insertions(+), 28 deletions(-)

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
index 9920b3a68ed1..e2a7bd703550 100644
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
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 9a34ceed0c2c..5e2fbe63ca47 100644
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
@@ -198,15 +209,32 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
 	int numvtaps = READ_ONCE(tap->numvtaps);
 	__u32 rxq;
 
+	*tap_add_hash(skb) = (struct virtio_net_hash) { .report = VIRTIO_NET_HASH_REPORT_NONE };
+
 	if (!numvtaps)
 		goto out;
 
 	if (numvtaps == 1)
 		goto single;
 
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
+		tun_vnet_hash_report(&tap->vnet_hash, skb, &keys_basic, rxq, tap_add_hash);
 		queue = rcu_dereference(tap->taps[rxq % numvtaps]);
 		goto out;
 	}
@@ -713,15 +741,16 @@ static ssize_t tap_put_user(struct tap_queue *q,
 	int total;
 
 	if (q->flags & IFF_VNET_HDR) {
-		struct virtio_net_hdr vnet_hdr;
+		struct virtio_net_hdr_v1_hash vnet_hdr;
 
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
-		ret = tun_vnet_hdr_from_skb(q->flags, NULL, skb, &vnet_hdr);
+		ret = tun_vnet_hdr_from_skb(vnet_hdr_len, q->flags, NULL, skb,
+					    tap_find_hash, &vnet_hdr);
 		if (ret < 0)
 			goto done;
 
-		ret = tun_vnet_hdr_put(vnet_hdr_len, iter, &vnet_hdr);
+		ret = tun_vnet_hdr_put(vnet_hdr_len, iter, &vnet_hdr, ret);
 		if (ret < 0)
 			goto done;
 	}
@@ -1025,7 +1054,13 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 		return ret;
 
 	default:
-		return tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags, cmd, sp);
+		rtnl_lock();
+		tap = rtnl_dereference(q->tap);
+		ret = tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags,
+				     tap ? &tap->vnet_hash : NULL, -EINVAL,
+				     cmd, sp);
+		rtnl_unlock();
+		return ret;
 	}
 }
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dd8799d19518..27308417b834 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -209,6 +209,7 @@ struct tun_struct {
 	struct bpf_prog __rcu *xdp_prog;
 	struct tun_prog __rcu *steering_prog;
 	struct tun_prog __rcu *filter_prog;
+	struct tun_vnet_hash vnet_hash;
 	struct ethtool_link_ksettings link_ksettings;
 	/* init args */
 	struct file *file;
@@ -451,6 +452,16 @@ static inline void tun_flow_save_rps_rxhash(struct tun_flow_entry *e, u32 hash)
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
@@ -459,12 +470,17 @@ static inline void tun_flow_save_rps_rxhash(struct tun_flow_entry *e, u32 hash)
  */
 static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
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
@@ -473,6 +489,13 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 		txq = reciprocal_scale(txq, numqueues);
 	}
 
+	keys_basic = (struct flow_keys_basic) {
+		.control = keys.control,
+		.basic = keys.basic
+	};
+	tun_vnet_hash_report(&tun->vnet_hash, skb, &keys_basic, skb->l4_hash ? skb->hash : txq,
+			     tun_add_hash);
+
 	return txq;
 }
 
@@ -1990,10 +2013,8 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
 	size_t total;
 
 	if (tun->flags & IFF_VNET_HDR) {
-		struct virtio_net_hdr gso = { 0 };
-
 		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
-		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
+		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, NULL, 0);
 		if (ret < 0)
 			return ret;
 	}
@@ -2018,7 +2039,6 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	int vlan_offset = 0;
 	int vlan_hlen = 0;
 	int vnet_hdr_sz = 0;
-	int ret;
 
 	if (skb_vlan_tag_present(skb))
 		vlan_hlen = VLAN_HLEN;
@@ -2043,13 +2063,15 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	}
 
 	if (vnet_hdr_sz) {
-		struct virtio_net_hdr gso;
+		struct virtio_net_hdr_v1_hash gso;
+		int ret;
 
-		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
+		ret = tun_vnet_hdr_from_skb(vnet_hdr_sz, tun->flags, tun->dev, skb,
+					    tun_find_hash, &gso);
 		if (ret < 0)
 			goto done;
 
-		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
+		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso, ret);
 		if (ret < 0)
 			goto done;
 	}
@@ -3055,9 +3077,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		goto unlock;
 	}
 
-	ret = -EBADFD;
-	if (!tun)
+	if (!tun) {
+		ret = tun_vnet_ioctl(NULL, NULL, NULL, -EBADFD, cmd, argp);
 		goto unlock;
+	}
 
 	netif_info(tun, drv, tun->dev, "tun_chr_ioctl cmd %u\n", cmd);
 
@@ -3256,7 +3279,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	default:
-		ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags, cmd, argp);
+		ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags,
+				     &tun->vnet_hash, -EINVAL, cmd, argp);
 	}
 
 	if (do_notify)
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index c40bde0fdf8c..589a97dd7d02 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -6,6 +6,9 @@
 #define TUN_VNET_LE 0x80000000
 #define TUN_VNET_BE 0x40000000
 
+typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_buff *);
+typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const struct sk_buff *);
+
 static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
 {
 	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) && (flags & TUN_VNET_BE)) &&
@@ -59,18 +62,31 @@ static inline __virtio16 cpu_to_tun_vnet16(unsigned int flags, u16 val)
 }
 
 static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
-				  unsigned int cmd, int __user *sp)
+				  struct tun_vnet_hash *hash, long fallback,
+				  unsigned int cmd, void __user *argp)
 {
+	static const struct tun_vnet_hash cap = {
+		.flags = TUN_VNET_HASH_REPORT,
+		.types = VIRTIO_NET_SUPPORTED_HASH_TYPES
+	};
+	struct tun_vnet_hash hash_buf;
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
@@ -80,12 +96,18 @@ static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
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
@@ -95,16 +117,56 @@ static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
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
+		if (!hash)
+			return -EBADFD;
+
+		if (copy_from_user(&hash_buf, argp, sizeof(hash_buf)))
+			return -EFAULT;
+
+		*hash = hash_buf;
+		return 0;
+
 	default:
-		return -EINVAL;
+		return fallback;
 	}
 }
 
+static inline void tun_vnet_hash_report(const struct tun_vnet_hash *hash,
+					struct sk_buff *skb,
+					const struct flow_keys_basic *keys,
+					u32 value,
+					tun_vnet_hash_add vnet_hash_add)
+{
+	struct virtio_net_hash *report;
+
+	if (!(hash->flags & TUN_VNET_HASH_REPORT))
+		return;
+
+	report = vnet_hash_add(skb);
+	if (!report)
+		return;
+
+	*report = (struct virtio_net_hash) {
+		.report = virtio_net_hash_report(hash->types, keys),
+		.value = value
+	};
+}
+
 static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
 				   struct iov_iter *from,
 				   struct virtio_net_hdr *hdr)
@@ -130,15 +192,15 @@ static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
 }
 
 static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
-				   const struct virtio_net_hdr *hdr)
+				   const void *hdr, int content_sz)
 {
 	if (iov_iter_count(iter) < sz)
 		return -EINVAL;
 
-	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
+	if (copy_to_iter(hdr, content_sz, iter) != content_sz)
 		return -EFAULT;
 
-	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
+	if (iov_iter_zero(sz - content_sz, iter) != sz - content_sz)
 		return -EFAULT;
 
 	return 0;
@@ -151,32 +213,48 @@ static inline int tun_vnet_hdr_to_skb(unsigned int flags,
 	return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
 }
 
-static inline int tun_vnet_hdr_from_skb(unsigned int flags,
+static inline int tun_vnet_hdr_from_skb(int sz, unsigned int flags,
 					const struct net_device *dev,
 					const struct sk_buff *skb,
-					struct virtio_net_hdr *hdr)
+					tun_vnet_hash_find vnet_hash_find,
+					struct virtio_net_hdr_v1_hash *hdr)
 {
 	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
+	const struct virtio_net_hash *report = sz < sizeof(struct virtio_net_hdr_v1_hash) ?
+					       NULL : vnet_hash_find(skb);
+	int content_sz;
+
+	if (report) {
+		content_sz = sizeof(struct virtio_net_hdr_v1_hash);
+
+		*hdr = (struct virtio_net_hdr_v1_hash) {
+			.hdr = { .num_buffers = __cpu_to_virtio16(true, 1) },
+			.hash_value = cpu_to_le32(report->value),
+			.hash_report = cpu_to_le16(report->report)
+		};
+	} else {
+		content_sz = sizeof(struct virtio_net_hdr);
+	}
 
-	if (virtio_net_hdr_from_skb(skb, hdr,
+	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
 				    tun_vnet_is_little_endian(flags), true,
 				    vlan_hlen)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
 
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
 
-	return 0;
+	return content_sz;
 }
 
 #endif /* TUN_VNET_H */
diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
index 553552fa635c..5bbb343a6dba 100644
--- a/include/linux/if_tap.h
+++ b/include/linux/if_tap.h
@@ -4,6 +4,7 @@
 
 #include <net/sock.h>
 #include <linux/skb_array.h>
+#include <uapi/linux/if_tun.h>
 
 struct file;
 struct socket;
@@ -43,6 +44,7 @@ struct tap_dev {
 	int			numqueues;
 	netdev_features_t	tap_features;
 	int			minor;
+	struct tun_vnet_hash	vnet_hash;
 
 	void (*update_features)(struct tap_dev *tap, netdev_features_t features);
 	void (*count_tx_dropped)(struct tap_dev *tap);
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 287cdc81c939..d11e79b4e0dc 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -62,6 +62,34 @@
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
@@ -115,4 +143,24 @@ struct tun_filter {
 	__u8   addr[][ETH_ALEN];
 };
 
+/**
+ * define TUN_VNET_HASH_REPORT - Request virtio_net hash reporting for vhost
+ */
+#define TUN_VNET_HASH_REPORT	0x0001
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
 #endif /* _UAPI__IF_TUN_H */

-- 
2.46.2


