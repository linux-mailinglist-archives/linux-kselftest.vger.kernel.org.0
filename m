Return-Path: <linux-kselftest+bounces-17997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB5E97941C
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 03:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419E61F2345D
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 01:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEDB184E;
	Sun, 15 Sep 2024 01:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Z0kb3VaP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F353A7
	for <linux-kselftest@vger.kernel.org>; Sun, 15 Sep 2024 01:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726363198; cv=none; b=rjuAexQ5S4gxx5TcSe/DCkpGQc5qbLbcQ3nAbVR6JHcb5PMueumb0R1D1hV5NtkI2/t30+i10NYBOgqJwWgHix42OWfCTpW8Xwf+lrPOH1+i5qWKxJkQJemC4OhFz6mbRLTHybILV5cMRgCUhWnY+0AwHVTP4hamTprRT4n9HFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726363198; c=relaxed/simple;
	bh=xKAQjQfEXzGVSgAW6KjLXs1ZmXqmjpJWYhD2AKwH81w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=YcNOVcjT7ZNYzBbEJe1oL3vTJ6kgwefJzPCctPtWEGAUI3RW9lkMuLlz1DP6GNTj14FwoovaAMqnn/2sCjtjy4rVZ/MdgbwvgH/dgHkfCL0BcfyOUO8VErdLw05Z1mp6y3WStn9emXMkqfYcEAdfNfT4o/fA733XCT1F3OlwQBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Z0kb3VaP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-206b9455460so25846635ad.0
        for <linux-kselftest@vger.kernel.org>; Sat, 14 Sep 2024 18:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363196; x=1726967996; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+abuVJ6BOsm0J5HlDpKBrW4vbDWaVftBJtrI/m0/jU0=;
        b=Z0kb3VaPrV+Pt+Pz6QsCVsmrKFZq3RpraNDM3oAn33u+QcKXAkKjczXoaZOwB+n24h
         IniBst43dxGdVYJaU4Kc7OZKWDPdl4vdqs6spD4hFd9Sc8KX/VSuFPiCPU1Mxnoc3fgm
         gQNnLwdp6G6gZ69NhbenX7uI1jfbrQ8FOPId1TO8jMWHi/26aEsHGV5zvMOjjkOGIKDd
         0HoOxfgpPEHPDPioFP7DWsa99UmRTOAeeEtKknTQ5JW4Dj4ILdJdYILtGsHyS5SK5Zm0
         yt+D5kiNXJhfsd7jDliBffMLli7odUVks6qcIyCYlJZcSv5FKsGUkTWk4Urzx/Xx+DUe
         Ii7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726363196; x=1726967996;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+abuVJ6BOsm0J5HlDpKBrW4vbDWaVftBJtrI/m0/jU0=;
        b=lkoyB0K1HpANBiJi7TjH/60G9KpOsKuRbWaoV5B9vwJ7IBkoixhqFxI9iGjp6T8BJz
         yMZvBHCbkOAQNdOHM2+vBKjXy66n70WIx4DyAckLvrgpYkm0NCSAme93g3z8CEAaEyoa
         5Rk+jF7tfjyWA4dcg39Tn8F7jCbsTKA/2MnANy0gMBtuSR/+11Upn45hm+tMt3jWIsz1
         nedR19VAPjluHlHZWr64sfUhkW9OoNSt76i7q3KscsE0SceAJt/FqKvV45/q7Taqm2m8
         2t95Z/wKSE3Mg2kkkdV8fiXdtHcOiDdjrWypTInrINu4RbFnbOCDOLOx5KrITeSySO53
         IpOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLRuUV+w+3Ok7fWiIw0CGOKZyZQ06Ky+urKgXC5h4Jx+YdoSMr83WOMbpZegHlcTqOXE5Tqf0cnXbM7Dn4ahg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi+2+lD6qMFBBSZRN2EbqH02nAzTztVV/9VBgXi9oMEufdbpxD
	dTtFZ16+JPFe8za7I2Y+nUcdw57333moFXZc38EAyyuowY8QI3zWvhgRJ/YmgQk=
X-Google-Smtp-Source: AGHT+IE1i3eg5lF77b/VqpPShWujILyuOG1U3fn7zxi8mIz+yCiQ1vTyuvQ6/4Ws73CpDcw3dhmsPQ==
X-Received: by 2002:a17:902:da8a:b0:206:b5b8:25dd with SMTP id d9443c01a7336-2076e5f80ecmr186906355ad.23.1726363195647;
        Sat, 14 Sep 2024 18:19:55 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2079472fb5csm14765945ad.252.2024.09.14.18.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:19:55 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:17:45 +0900
Subject: [PATCH RFC v3 6/9] tun: Introduce virtio-net hash reporting
 feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-rss-v3-6-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
In-Reply-To: <20240915-rss-v3-0-c630015db082@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

Allow the guest to reuse the hash value to make receive steering
consistent between the host and guest, and to save hash computation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 Documentation/networking/tuntap.rst |   7 ++
 drivers/net/Kconfig                 |   1 +
 drivers/net/tun.c                   | 146 +++++++++++++++++++++++++++++++-----
 include/uapi/linux/if_tun.h         |  44 +++++++++++
 4 files changed, 180 insertions(+), 18 deletions(-)

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
index 9d93ab9ee58f..b8fcd71becac 100644
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
+	struct tun_vnet_hash_container __rcu *vnet_hash;
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
 
@@ -322,10 +332,17 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 	if (get_user(be, argp))
 		return -EFAULT;
 
-	if (be)
+	if (be) {
+		struct tun_vnet_hash_container *vnet_hash = rtnl_dereference(tun->vnet_hash);
+
+		if (!(tun->flags & TUN_VNET_LE) &&
+		    vnet_hash && (vnet_hash->flags & TUN_VNET_HASH_REPORT))
+			return -EBUSY;
+
 		tun->flags |= TUN_VNET_BE;
-	else
+	} else {
 		tun->flags &= ~TUN_VNET_BE;
+	}
 
 	return 0;
 }
@@ -522,14 +539,20 @@ static inline void tun_flow_save_rps_rxhash(struct tun_flow_entry *e, u32 hash)
  * the userspace application move between processors, we may get a
  * different rxq no. here.
  */
-static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
+static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb,
+				   const struct tun_vnet_hash_container *vnet_hash)
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
@@ -538,6 +561,16 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 		txq = reciprocal_scale(txq, numqueues);
 	}
 
+	if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_REPORT)) {
+		ext = skb_ext_add(skb, SKB_EXT_TUN_VNET_HASH);
+		if (ext) {
+			u32 types = vnet_hash->common.types;
+
+			ext->report = virtio_net_hash_report(types, keys.basic);
+			ext->value = skb->l4_hash ? skb->hash : txq;
+		}
+	}
+
 	return txq;
 }
 
@@ -565,10 +598,13 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
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
+		ret = tun_automq_select_queue(tun, skb, vnet_hash);
+	}
 	rcu_read_unlock();
 
 	return ret;
@@ -2120,33 +2156,63 @@ static ssize_t tun_put_user(struct tun_struct *tun,
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
+			struct virtio_net_hash hash = {
+				.value = ext->value,
+				.report = ext->report,
+			};
+
+			vnet_hdr_content_sz = sizeof(vnet_hdr.hdr_v1_hash);
+			ret = virtio_net_hdr_v1_hash_from_skb(skb,
+							      &vnet_hdr.hdr_v1_hash,
+							      true,
+							      vlan_hlen,
+							      &hash);
+		} else {
+			vnet_hdr_content_sz = sizeof(struct virtio_net_hdr);
+			ret = virtio_net_hdr_from_skb(skb,
+						      &vnet_hdr.hdr,
+						      tun_is_little_endian(tun),
+						      true,
+						      vlan_hlen);
+		}
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
@@ -3094,6 +3160,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	int le;
 	int ret;
 	bool do_notify = false;
+	struct tun_vnet_hash vnet_hash_common;
+	struct tun_vnet_hash_container *vnet_hash;
 
 	if (cmd == TUNSETIFF || cmd == TUNSETQUEUE ||
 	    (_IOC_TYPE(cmd) == SOCK_IOC_TYPE && cmd != SIOCGSKNS)) {
@@ -3115,6 +3183,9 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 		return open_related_ns(&net->ns, get_net_ns);
+	} else if (cmd == TUNGETVNETHASHCAP) {
+		return copy_to_user(argp, &tun_vnet_hash_cap, sizeof(tun_vnet_hash_cap)) ?
+		       -EFAULT : 0;
 	}
 
 	rtnl_lock();
@@ -3314,6 +3385,13 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			break;
 		}
 
+		vnet_hash = rtnl_dereference(tun->vnet_hash);
+		if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_REPORT) &&
+		    vnet_hdr_sz < (int)sizeof(struct virtio_net_hdr_v1_hash)) {
+			ret = -EBUSY;
+			break;
+		}
+
 		tun->vnet_hdr_sz = vnet_hdr_sz;
 		break;
 
@@ -3328,10 +3406,18 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			ret = -EFAULT;
 			break;
 		}
-		if (le)
+		if (le) {
 			tun->flags |= TUN_VNET_LE;
-		else
+		} else {
+			vnet_hash = rtnl_dereference(tun->vnet_hash);
+			if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_REPORT) &&
+			    !tun_legacy_is_little_endian(tun)) {
+				ret = -EBUSY;
+				break;
+			}
+
 			tun->flags &= ~TUN_VNET_LE;
+		}
 		break;
 
 	case TUNGETVNETBE:
@@ -3396,6 +3482,30 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = open_related_ns(&net->ns, get_net_ns);
 		break;
 
+	case TUNSETVNETHASH:
+		if (copy_from_user(&vnet_hash_common, argp, sizeof(vnet_hash_common))) {
+			ret = -EFAULT;
+			break;
+		}
+		argp = (struct tun_vnet_hash __user *)argp + 1;
+
+		if ((vnet_hash_common.flags & TUN_VNET_HASH_REPORT) &&
+		    (tun->vnet_hdr_sz < sizeof(struct virtio_net_hdr_v1_hash) ||
+		     !tun_is_little_endian(tun))) {
+			ret = -EBUSY;
+			break;
+		}
+
+		vnet_hash = kmalloc(sizeof(vnet_hash->common), GFP_KERNEL);
+		if (!vnet_hash) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		vnet_hash->common = vnet_hash_common;
+		kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(tun->vnet_hash, vnet_hash));
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


