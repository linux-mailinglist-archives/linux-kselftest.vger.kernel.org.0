Return-Path: <linux-kselftest+bounces-18282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC70898417A
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 11:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098BE1C234C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 09:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8255E17D340;
	Tue, 24 Sep 2024 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="3Kf8QxFf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E93817BED2
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168491; cv=none; b=kf3wIlUiVKH92aMNkqfMA4QINOkxLGsBaURYPWvYxQJftXIB9z+xSgwXz2Cyf9zGeGd/6k0kSKeaAkKY6frJWS9V2QX5EgxpAcRXCa90E94xaR7ZootbJWLnw+AZ36XFM9jlAnkgSNVXIhpgLC/Zr55+08mvtG/a7srx5qw9j7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168491; c=relaxed/simple;
	bh=oV1JUkP8W1vYe9S7wWIQJD4ympP3jMhWLs2iFcdTwzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=SpaYFfye/PX4Hd7JPXfD/IgZIEmTKr2SBimn7lNhQBovrPhHowl5onPcfjGRtlbPtP7Gw+ydg+D3Pret5mMfx4MbokAFclcQuOIGi373Nw7XkrC2uhe0NpmSvVWx4bB4a4X0dlQ3An939A32+QovdVQYJo/baaFCH1ubyU5C6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=3Kf8QxFf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a843bef98so710310366b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 02:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727168488; x=1727773288; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Om/3wu4kS687ZdFV0+xHRhdMwLbgwny48pP3LqMtoo=;
        b=3Kf8QxFfR9qPypajMdaXoxOmDk4kIhNL4WKaun2XscswINf+FK447gTvi0kcDS+9hW
         bE7veGGYqNeSCXXp8OlK/80nKt/BPUlHhd18IxfWRiBDT8og5GLA66aH8quIij812sym
         j2sI/wRx+H2VzC+w2KNL6vg1yWkREtZhBBUd25un+N3qurBodYAlu1hjljRbGjHSK7k7
         ZNujZPasN57G27CZl5q/o/aw/ceXgMxffax+6ZILVXH5IFIXMTN4HWcV09uRQxlpDAY4
         xlDu/0WJeVYikBGn6PQyqcbllEX7jgdP0SUUJKPH9f+LClMFwZ92StQeBWr8NFwOog4c
         IzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168488; x=1727773288;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Om/3wu4kS687ZdFV0+xHRhdMwLbgwny48pP3LqMtoo=;
        b=AHDfJHG7wtkVubM1RDIeXITK4U1mz4TUC5mpFX3K/xwWSRRue/3mIpFMGyYPgHnZj9
         /BZiIIqH9YQa6mglokIo9ut1bztmhdZc6+lsVZQMOxys/32WBYxliuAm46dPvu7I0cBc
         NaJRI6OBwHCLPjMOFTxh5uTbh4p1nEdLabcoeasK9O3coqtMJyYVc11+dO6XQSAvLE5N
         2VGPA0zr86IxvQQmhuFE4ZN31Pvz9KRMr9CxtSuATXUrVooWIkzXtnX/DtoDRi81vv63
         x4S8cGP5T6KFiKsuSsvFd/6ieAf9gYUHN7T+PuAbcBynUidqcwC8drvpV1hZscwsoUv7
         gjTg==
X-Forwarded-Encrypted: i=1; AJvYcCUYOTdFtnctl3kr93s0EYlXDgvOFh1t9wLJQJafuesXJePEKRewFv2Zj8pXCtgc6rVODQS7BNZVO2a60eB1G+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlbPPD93UCmTWOd66AR7pxl3z+FDsTPHxvCYKiAc4208FjBj20
	8inWY/Gav5Dt3ZZcotM7suHG4wBfPjzaaGzjmOZ07k+EI26SOVZRv+ofIb/NgKhuQhtoCih87yf
	Rd9sqsvDG
X-Google-Smtp-Source: AGHT+IHs03bJZmwoKWOU8mAuHuG6wZ42PI14gDUKn/VRNPY8OWcO6YXdGtf+F+s8OwpND/dwpJC7yA==
X-Received: by 2002:a17:906:dace:b0:a91:158f:6692 with SMTP id a640c23a62f3a-a91158f6847mr376252166b.62.1727168487389;
        Tue, 24 Sep 2024 02:01:27 -0700 (PDT)
Received: from localhost ([193.32.29.227])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a93930c8a98sm60206466b.124.2024.09.24.02.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:01:26 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 24 Sep 2024 11:01:11 +0200
Subject: [PATCH RFC v4 6/9] tun: Introduce virtio-net hash reporting
 feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-rss-v4-6-84e932ec0e6c@daynix.com>
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
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
 drivers/net/tun.c                   | 117 +++++++++++++++++++++++++++++++-----
 include/uapi/linux/if_tun.h         |  44 ++++++++++++++
 4 files changed, 155 insertions(+), 14 deletions(-)

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
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9d93ab9ee58f..986e4a5bf04d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -173,6 +173,10 @@ struct tun_prog {
 	struct bpf_prog *prog;
 };
 
+struct tun_vnet_hash_container {
+	struct tun_vnet_hash common;
+};
+
 /* Since the socket were moved to tun_file, to preserve the behavior of persist
  * device, socket filter, sndbuf and vnet header size were restore when the
  * file were attached to a persist device.
@@ -210,6 +214,7 @@ struct tun_struct {
 	struct bpf_prog __rcu *xdp_prog;
 	struct tun_prog __rcu *steering_prog;
 	struct tun_prog __rcu *filter_prog;
+	struct tun_vnet_hash vnet_hash;
 	struct ethtool_link_ksettings link_ksettings;
 	/* init args */
 	struct file *file;
@@ -221,6 +226,11 @@ struct veth {
 	__be16 h_vlan_TCI;
 };
 
+static const struct tun_vnet_hash tun_vnet_hash_cap = {
+	.flags = TUN_VNET_HASH_REPORT,
+	.types = VIRTIO_NET_SUPPORTED_HASH_TYPES
+};
+
 static void tun_flow_init(struct tun_struct *tun);
 static void tun_flow_uninit(struct tun_struct *tun);
 
@@ -322,10 +332,15 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 	if (get_user(be, argp))
 		return -EFAULT;
 
-	if (be)
+	if (be) {
+		if (!(tun->flags & TUN_VNET_LE) &&
+		    (tun->vnet_hash.flags & TUN_VNET_HASH_REPORT))
+			return -EBUSY;
+
 		tun->flags |= TUN_VNET_BE;
-	else
+	} else {
 		tun->flags &= ~TUN_VNET_BE;
+	}
 
 	return 0;
 }
@@ -524,12 +539,17 @@ static inline void tun_flow_save_rps_rxhash(struct tun_flow_entry *e, u32 hash)
  */
 static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 {
+	struct tun_vnet_hash_ext *ext;
+	struct flow_keys keys;
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
@@ -538,6 +558,16 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 		txq = reciprocal_scale(txq, numqueues);
 	}
 
+	if (tun->vnet_hash.flags & TUN_VNET_HASH_REPORT) {
+		ext = skb_ext_add(skb, SKB_EXT_TUN_VNET_HASH);
+		if (ext) {
+			u32 types = tun->vnet_hash.types;
+
+			ext->report = virtio_net_hash_report(types, keys.basic);
+			ext->value = skb->l4_hash ? skb->hash : txq;
+		}
+	}
+
 	return txq;
 }
 
@@ -2120,33 +2150,58 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	}
 
 	if (vnet_hdr_sz) {
-		struct virtio_net_hdr gso;
+		struct tun_vnet_hash_ext *ext;
+		size_t vnet_hdr_content_sz = sizeof(struct virtio_net_hdr);
+		union {
+			struct virtio_net_hdr hdr;
+			struct virtio_net_hdr_v1_hash hdr_v1_hash;
+		} vnet_hdr;
+		int ret;
 
 		if (iov_iter_count(iter) < vnet_hdr_sz)
 			return -EINVAL;
 
-		if (virtio_net_hdr_from_skb(skb, &gso,
-					    tun_is_little_endian(tun), true,
-					    vlan_hlen)) {
+		ext = vnet_hdr_sz < sizeof(vnet_hdr.hdr_v1_hash) ?
+		      NULL : skb_ext_find(skb, SKB_EXT_TUN_VNET_HASH);
+
+		if (ext) {
+			vnet_hdr_content_sz = sizeof(vnet_hdr.hdr_v1_hash);
+			memset(&vnet_hdr, 0, vnet_hdr_content_sz);
+			vnet_hdr.hdr_v1_hash.hdr.num_buffers = __cpu_to_virtio16(true, 1);
+			vnet_hdr.hdr_v1_hash.hash_value = cpu_to_le32(ext->value);
+			vnet_hdr.hdr_v1_hash.hash_report = cpu_to_le16(ext->report);
+		} else {
+			vnet_hdr_content_sz = sizeof(struct virtio_net_hdr);
+		}
+
+		ret = virtio_net_hdr_from_skb(skb,
+					      &vnet_hdr.hdr,
+					      tun_is_little_endian(tun),
+					      true,
+					      vlan_hlen);
+
+		if (ret) {
 			struct skb_shared_info *sinfo = skb_shinfo(skb);
 
 			if (net_ratelimit()) {
 				netdev_err(tun->dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
-					   sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
-					   tun16_to_cpu(tun, gso.hdr_len));
+					   sinfo->gso_type,
+					   tun16_to_cpu(tun, vnet_hdr.hdr.gso_size),
+					   tun16_to_cpu(tun, vnet_hdr.hdr.hdr_len));
 				print_hex_dump(KERN_ERR, "tun: ",
 					       DUMP_PREFIX_NONE,
 					       16, 1, skb->head,
-					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
+					       min(tun16_to_cpu(tun, vnet_hdr.hdr.hdr_len), 64),
+					       true);
 			}
 			WARN_ON_ONCE(1);
 			return -EINVAL;
 		}
 
-		if (copy_to_iter(&gso, sizeof(gso), iter) != sizeof(gso))
+		if (copy_to_iter(&vnet_hdr, vnet_hdr_content_sz, iter) != vnet_hdr_content_sz)
 			return -EFAULT;
 
-		iov_iter_zero(vnet_hdr_sz - sizeof(gso), iter);
+		iov_iter_zero(vnet_hdr_sz - vnet_hdr_content_sz, iter);
 	}
 
 	if (vlan_hlen) {
@@ -3094,6 +3149,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	int le;
 	int ret;
 	bool do_notify = false;
+	struct tun_vnet_hash vnet_hash;
 
 	if (cmd == TUNSETIFF || cmd == TUNSETQUEUE ||
 	    (_IOC_TYPE(cmd) == SOCK_IOC_TYPE && cmd != SIOCGSKNS)) {
@@ -3115,6 +3171,9 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 		return open_related_ns(&net->ns, get_net_ns);
+	} else if (cmd == TUNGETVNETHASHCAP) {
+		return copy_to_user(argp, &tun_vnet_hash_cap, sizeof(tun_vnet_hash_cap)) ?
+		       -EFAULT : 0;
 	}
 
 	rtnl_lock();
@@ -3314,6 +3373,12 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			break;
 		}
 
+		if (tun->vnet_hash.flags & TUN_VNET_HASH_REPORT &&
+		    vnet_hdr_sz < (int)sizeof(struct virtio_net_hdr_v1_hash)) {
+			ret = -EBUSY;
+			break;
+		}
+
 		tun->vnet_hdr_sz = vnet_hdr_sz;
 		break;
 
@@ -3328,10 +3393,17 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			ret = -EFAULT;
 			break;
 		}
-		if (le)
+		if (le) {
 			tun->flags |= TUN_VNET_LE;
-		else
+		} else {
+			if (tun->vnet_hash.flags & TUN_VNET_HASH_REPORT &&
+			    !tun_legacy_is_little_endian(tun)) {
+				ret = -EBUSY;
+				break;
+			}
+
 			tun->flags &= ~TUN_VNET_LE;
+		}
 		break;
 
 	case TUNGETVNETBE:
@@ -3396,6 +3468,23 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = open_related_ns(&net->ns, get_net_ns);
 		break;
 
+	case TUNSETVNETHASH:
+		if (copy_from_user(&vnet_hash, argp, sizeof(vnet_hash))) {
+			ret = -EFAULT;
+			break;
+		}
+		argp = (struct tun_vnet_hash __user *)argp + 1;
+
+		if ((vnet_hash.flags & TUN_VNET_HASH_REPORT) &&
+		    (tun->vnet_hdr_sz < sizeof(struct virtio_net_hdr_v1_hash) ||
+		     !tun_is_little_endian(tun))) {
+			ret = -EBUSY;
+			break;
+		}
+
+		tun->vnet_hash = vnet_hash;
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 287cdc81c939..1561e8ce0a0a 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -62,6 +62,30 @@
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
+ * %TUNSETVNETHDRSZ ioctl must be called with a number greater than or equal to
+ * the size of &struct virtio_net_hdr_v1_hash before calling this ioctl with
+ * %TUN_VNET_HASH_REPORT.
+ *
+ * The virtio_net header must be configured as little-endian before calling this
+ * ioctl with %TUN_VNET_HASH_REPORT.
+ *
+ * This ioctl currently has no effect on XDP packets.
+ */
+#define TUNSETVNETHASH _IOW('T', 229, struct tun_vnet_hash)
+
 /* TUNSETIFF ifr flags */
 #define IFF_TUN		0x0001
 #define IFF_TAP		0x0002
@@ -115,4 +139,24 @@ struct tun_filter {
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
2.46.0


