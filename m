Return-Path: <linux-kselftest+bounces-17998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE27F979422
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 03:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E339285444
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 01:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8711DFED;
	Sun, 15 Sep 2024 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="y5DQFx3y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2F91CA8D
	for <linux-kselftest@vger.kernel.org>; Sun, 15 Sep 2024 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726363209; cv=none; b=lUmvb3lx1hAyxYotahPOKysVOXQbqFn6jwsKDMtmm7Iov1UGCHEz3MPvU4/NKqvyLHh7hhfMACN7asGe5xSpZ3AGVKfqMyfj0fpUHRqWGIxHmmAi8iCHIJaN/Nkufej5wb8oNtHnA8x+9QRPITmoNHo4QacfwMcAZkP1MDEthgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726363209; c=relaxed/simple;
	bh=WmBSaC/QSbjobyoahXyzvbyjUk5hRznJbyxtyhVOrGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=cAbh0OyowvjfilVnzLgF/OoZxHyOn4NJHmJ1QvsBjJOwqi+wz2nKx9fPZbCtsyY4Xqpd7FoPZi1z0TDTG0qnoXg5fgPxSZdAtVf6qfRHr8a0pTWtnsccorYAaEEFTUb96eXPEZfYhoTPVR3DdLR1IxDmYmsbvo+21eU5Qm88SI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=y5DQFx3y; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d88c5d76eeso1507810a91.2
        for <linux-kselftest@vger.kernel.org>; Sat, 14 Sep 2024 18:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363207; x=1726968007; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYyQLQOeFQUpiZoKosJFqYZWB+Aa4MJVtAn2xVSJv2M=;
        b=y5DQFx3y/TgLLufOMaV+l5kgEveh27DCPr/TfcX/4Rpcs+JRbKeu8Op8kzUXmUdP6D
         8oW+g8HmjcjPZLmxpJE2DMmNWX55G1JwsHS8aqbB5KGq3LdiS0WkDM5HUMJIrreVLb39
         lrWK6MGgWK3UZ5dC0Pd9H5gxI4agKtWxACCN0Wvi5KFvyGY6zG3zfjruKZUdwidoaRqb
         EqfHoEPjlYcEqIqefd9+m9A0Fgc4M7EEijeYsqcZXIntBU8Ns9JHK2cG22LoFBeOClpP
         VL5eNO2UBxkD5m5o6vuMIoe3FActhlPDKp4rXxj4oxkmBW91k9FGZR7MxWcCDnCXROet
         p0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726363207; x=1726968007;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYyQLQOeFQUpiZoKosJFqYZWB+Aa4MJVtAn2xVSJv2M=;
        b=TotcwHec21zCyv0j1oOf5Ll0ddP3gIaJzEYj1EzcjvFqoekCN5YhPC2c2F0CDlzOZO
         VFPLYDP3WL2SGbBTM+dKTF59OYB4zSSTAOe/2farPYkizFdzXHKZ2vjn/XIzGodSqDDi
         wNGaGWYzRfqXcZaA2Da6ZF3p1RKUVlTqeitC0hZNvig0g7721OyviapgtgXTparMsaYu
         ikQV4EqgsAaoGbBKvoX2IYJo5yPu8oPCzn5dG6nCUp8If5QpbUVtV3kLI3iKVOgrvEuK
         gZy+mEj3j9OT1LQPrYDV6+fzYRKdzYUDFLLbILcd8jkKhxo/5zDzHlnBVYFINFahOVbk
         UHqg==
X-Forwarded-Encrypted: i=1; AJvYcCVaHnjhqenNasF8M9MlnTLZT2xiXizhLoQ3rCKRKIw8b5t3CLO/agg8GU3efe4H+E11NYKDNb23bpJGarE2W9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8J/9XdSl2sHOFkH1wBe7FaAXW4h1U2K/VQ0sqZO2Yij6Pr9Rq
	9tyeeazqdUwYsncp1Agf1AqNckYhx9RAzXJAgaDvbzd9p9RioBS9g4KkV4e3cxM=
X-Google-Smtp-Source: AGHT+IGyUfC3/ABtY9/wIl+W6Qg+BNPReG5FAyawSqjluEKUCPEWa7sstjTnvfK0g1w76208slgCjQ==
X-Received: by 2002:a17:90b:3ec1:b0:2d8:ebef:547 with SMTP id 98e67ed59e1d1-2dbb9f08b33mr9461616a91.35.1726363207168;
        Sat, 14 Sep 2024 18:20:07 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2dbcfcbadd0sm2227646a91.11.2024.09.14.18.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:20:06 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:17:46 +0900
Subject: [PATCH RFC v3 7/9] tun: Introduce virtio-net RSS
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-rss-v3-7-c630015db082@daynix.com>
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
 drivers/net/tun.c           | 119 +++++++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/if_tun.h |  27 ++++++++++
 2 files changed, 133 insertions(+), 13 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b8fcd71becac..5a429b391144 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -175,6 +175,9 @@ struct tun_prog {
 
 struct tun_vnet_hash_container {
 	struct tun_vnet_hash common;
+	struct tun_vnet_hash_rss rss;
+	__be32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
+	u16 rss_indirection_table[];
 };
 
 /* Since the socket were moved to tun_file, to preserve the behavior of persist
@@ -227,7 +230,7 @@ struct veth {
 };
 
 static const struct tun_vnet_hash tun_vnet_hash_cap = {
-	.flags = TUN_VNET_HASH_REPORT,
+	.flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
 	.types = VIRTIO_NET_SUPPORTED_HASH_TYPES
 };
 
@@ -591,6 +594,36 @@ static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 	return ret % numqueues;
 }
 
+static u16 tun_vnet_rss_select_queue(struct tun_struct *tun,
+				     struct sk_buff *skb,
+				     const struct tun_vnet_hash_container *vnet_hash)
+{
+	struct tun_vnet_hash_ext *ext;
+	struct virtio_net_hash hash;
+	u32 numqueues = READ_ONCE(tun->numqueues);
+	u16 txq, index;
+
+	if (!numqueues)
+		return 0;
+
+	if (!virtio_net_hash_rss(skb, vnet_hash->common.types, vnet_hash->rss_key,
+				 &hash))
+		return vnet_hash->rss.unclassified_queue % numqueues;
+
+	if (vnet_hash->common.flags & TUN_VNET_HASH_REPORT) {
+		ext = skb_ext_add(skb, SKB_EXT_TUN_VNET_HASH);
+		if (ext) {
+			ext->value = hash.value;
+			ext->report = hash.report;
+		}
+	}
+
+	index = hash.value & vnet_hash->rss.indirection_table_mask;
+	txq = READ_ONCE(vnet_hash->rss_indirection_table[index]);
+
+	return txq % numqueues;
+}
+
 static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 			    struct net_device *sb_dev)
 {
@@ -603,7 +636,10 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 	} else {
 		struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tun->vnet_hash);
 
-		ret = tun_automq_select_queue(tun, skb, vnet_hash);
+		if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS))
+			ret = tun_vnet_rss_select_queue(tun, skb, vnet_hash);
+		else
+			ret = tun_automq_select_queue(tun, skb, vnet_hash);
 	}
 	rcu_read_unlock();
 
@@ -3085,13 +3121,9 @@ static int tun_set_queue(struct file *file, struct ifreq *ifr)
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
@@ -3157,6 +3189,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	int ifindex;
 	int sndbuf;
 	int vnet_hdr_sz;
+	int fd;
 	int le;
 	int ret;
 	bool do_notify = false;
@@ -3460,11 +3493,27 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	case TUNSETSTEERINGEBPF:
-		ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
+		if (get_user(fd, (int __user *)argp)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		vnet_hash = rtnl_dereference(tun->vnet_hash);
+		if (fd != -1 && vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
+			ret = -EBUSY;
+			break;
+		}
+
+		ret = tun_set_ebpf(tun, &tun->steering_prog, fd);
 		break;
 
 	case TUNSETFILTEREBPF:
-		ret = tun_set_ebpf(tun, &tun->filter_prog, argp);
+		if (get_user(fd, (int __user *)argp)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = tun_set_ebpf(tun, &tun->filter_prog, fd);
 		break;
 
 	case TUNSETCARRIER:
@@ -3496,10 +3545,54 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			break;
 		}
 
-		vnet_hash = kmalloc(sizeof(vnet_hash->common), GFP_KERNEL);
-		if (!vnet_hash) {
-			ret = -ENOMEM;
-			break;
+		if (vnet_hash_common.flags & TUN_VNET_HASH_RSS) {
+			struct tun_vnet_hash_rss rss;
+			size_t indirection_table_size;
+			size_t key_size;
+			size_t size;
+
+			if (tun->steering_prog) {
+				ret = -EBUSY;
+				break;
+			}
+
+			if (copy_from_user(&rss, argp, sizeof(rss))) {
+				ret = -EFAULT;
+				break;
+			}
+			argp = (struct tun_vnet_hash_rss __user *)argp + 1;
+
+			indirection_table_size = ((size_t)rss.indirection_table_mask + 1) * 2;
+			key_size = virtio_net_hash_key_length(vnet_hash_common.types);
+			size = sizeof(*vnet_hash) + indirection_table_size + key_size;
+
+			vnet_hash = kmalloc(size, GFP_KERNEL);
+			if (!vnet_hash) {
+				ret = -ENOMEM;
+				break;
+			}
+
+			if (copy_from_user(vnet_hash->rss_indirection_table,
+					   argp, indirection_table_size)) {
+				kfree(vnet_hash);
+				ret = -EFAULT;
+				break;
+			}
+			argp = (u16 __user *)argp + rss.indirection_table_mask + 1;
+
+			if (copy_from_user(vnet_hash->rss_key, argp, key_size)) {
+				kfree(vnet_hash);
+				ret = -EFAULT;
+				break;
+			}
+
+			vnet_hash->rss = rss;
+		} else {
+			vnet_hash = kmalloc(sizeof(vnet_hash->common), GFP_KERNEL);
+			if (!vnet_hash) {
+				ret = -ENOMEM;
+				break;
+			}
 		}
 
 		vnet_hash->common = vnet_hash_common;
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 1561e8ce0a0a..1c130409db5d 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -75,6 +75,14 @@
  *
  * The argument is a pointer to &struct tun_vnet_hash.
  *
+ * The argument is a pointer to the compound of the following in order if
+ * %TUN_VNET_HASH_RSS is set:
+ *
+ * 1. &struct tun_vnet_hash
+ * 2. &struct tun_vnet_hash_rss
+ * 3. Indirection table
+ * 4. Key
+ *
  * %TUNSETVNETHDRSZ ioctl must be called with a number greater than or equal to
  * the size of &struct virtio_net_hdr_v1_hash before calling this ioctl with
  * %TUN_VNET_HASH_REPORT.
@@ -144,6 +152,13 @@ struct tun_filter {
  */
 #define TUN_VNET_HASH_REPORT	0x0001
 
+/**
+ * define TUN_VNET_HASH_RSS - Request virtio_net RSS
+ *
+ * This is mutually exclusive with eBPF steering program.
+ */
+#define TUN_VNET_HASH_RSS	0x0002
+
 /**
  * struct tun_vnet_hash - virtio_net hashing configuration
  * @flags:
@@ -159,4 +174,16 @@ struct tun_vnet_hash {
 	__u32 types;
 };
 
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

-- 
2.46.0


