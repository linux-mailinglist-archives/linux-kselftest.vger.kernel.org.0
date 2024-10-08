Return-Path: <linux-kselftest+bounces-19210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1B8994018
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 09:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91472897AF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 07:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8108D1E9092;
	Tue,  8 Oct 2024 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="UcKqRZ8d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5691E7679
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370520; cv=none; b=cRqm2TFgVVYm1C00YJ0wBd3FSqElKrOXicHmpYeC4n+X9ZirpNraJ7Jz+z6NJEKaFmj5iI8A6xnsa2q7R8tPLvia+9S9V7hhGx2mqIOYxoyWNwLaOwZ/+QaW4KIeni9KWiqr9BDUVEtY2HWhmVoQfyzsE6LDHMJ3qqzqH8t1Ai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370520; c=relaxed/simple;
	bh=a2kJWMkExNcWI86WBUBDvEgxTbAIgHqREo5GyuUxwxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=rNQ1D0KIPWT+Lx6UBI0JMMIXHySeoLy15/nQr69vKo4F0yA/8yjiH1uChhZt0vnVHrq+yO7aNZ6VOkCMJCQ0Z0N0VRilz4M2kzqpFu83e0SjYueEHBGhbKjOeIex/CYB1FDbOA3S7RCr2aSGIaXUxm+2HoHERjf1nQEiAkChosc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=UcKqRZ8d; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e0a74ce880so4425922a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2024 23:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370517; x=1728975317; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMICLru6rQUo+AXF2Kzpb/5yEpgekpzMnpJa+eP1zWw=;
        b=UcKqRZ8dA4kSIjO0wInbuSeyTMCmdnRvfmhxoVg204bz7GwkbViO9X7QyvZ+OQKHpz
         30xW6VUY7X0dufxVLzf6hvipFvzqrFNXe0vkvY2jLV6bjDrEDmwY7YhVHxpbtCUrw73Q
         90JM5LpwwbKeO7beaGEnoF7CGKyQmfT2LXrp3I+IMt34iSmtN50Pzj55B0QOoLtECUve
         zbPzbVU4hJZS6Wd1S8guYWOUqpxnWYYvf40gfufUB51YpAfczUO652TeAQvCrPXyQ4es
         h+zvK6j12zDLgtrST+eDIQ+Oy0TfQC3gkstzpvFm1cf01KNz0bkKkLxzdVWIGIBlgBWy
         R7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370517; x=1728975317;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMICLru6rQUo+AXF2Kzpb/5yEpgekpzMnpJa+eP1zWw=;
        b=liTooUpz2d2ceZVdbdWra1h+pizUkVVXuG932WGqVQWMLI6muEiqCgGkIhrthfJOZb
         BIEWuI3sBGx6xgE/OMFs53DShDR7+9SscA2JMFixeUyXKLHu5GdjxXop47n5tFlajxNl
         IkiDMIY39Tcqnoqny83v9bxkb47Nl0FSh95J/YFMm/bt6W86Srcy/jOlNtSpcpsMsnMD
         MkpQne4OW1Um8a92JHK9LqxgwdG2yak41b9d4mbiTBc8fpDqqU1McMJINwvWxPnrYJTc
         7Pi4fZ6UM0QlPuHGywfXt6z+TUsMahNAX6Lq9HjUcyA9cNLokHWzGSXsSEnVyzEebGt/
         Mq8w==
X-Forwarded-Encrypted: i=1; AJvYcCUXYtxiiyZnbofq35nc+lfhj/GxBODNZ94jlRhGZhaBon2acjionF6eD4Dm8It+u0uXq7MN1jO12Y9iU1ifnhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNO01G6VODY6/wCvUVLCu7gEQ7ytVqGT41TX/EV2YSI8VeTEhW
	NPBTn1ruS/Nlld2HaIsA0WvfCk1XPqf+HsZfmRqNN+OEUF7ABFQW6kowCVZXlwk=
X-Google-Smtp-Source: AGHT+IETqq/o8/WlMy63jHtkq90XEyz6WGiwMczZkwAe+xKo1XNx2mzQ+14/sRBXM7EDAH5EvS0xjw==
X-Received: by 2002:a17:90b:4ac4:b0:2d8:ca33:42a5 with SMTP id 98e67ed59e1d1-2e1e6367493mr15217131a91.40.1728370516975;
        Mon, 07 Oct 2024 23:55:16 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e2848d28f4sm751907a91.24.2024.10.07.23.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:55:16 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 08 Oct 2024 15:54:27 +0900
Subject: [PATCH RFC v5 07/10] tun: Introduce virtio-net RSS
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-rss-v5-7-f3cf68df005d@daynix.com>
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
 drivers/net/tap.c           | 11 +++++-
 drivers/net/tun.c           | 57 ++++++++++++++++++++-------
 drivers/net/tun_vnet.h      | 96 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/if_tap.h      |  4 +-
 include/uapi/linux/if_tun.h | 27 +++++++++++++
 5 files changed, 169 insertions(+), 26 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5e2fbe63ca47..a58b83285af4 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -207,6 +207,7 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
 	 * racing against queue removal.
 	 */
 	int numvtaps = READ_ONCE(tap->numvtaps);
+	struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tap->vnet_hash);
 	__u32 rxq;
 
 	*tap_add_hash(skb) = (struct virtio_net_hash) { .report = VIRTIO_NET_HASH_REPORT_NONE };
@@ -217,6 +218,12 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
 	if (numvtaps == 1)
 		goto single;
 
+	if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
+		rxq = tun_vnet_rss_select_queue(numvtaps, vnet_hash, skb, tap_add_hash);
+		queue = rcu_dereference(tap->taps[rxq]);
+		goto out;
+	}
+
 	if (!skb->l4_hash && !skb->sw_hash) {
 		struct flow_keys keys;
 
@@ -234,7 +241,7 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
 
 	/* Check if we can use flow to select a queue */
 	if (rxq) {
-		tun_vnet_hash_report(&tap->vnet_hash, skb, &keys_basic, rxq, tap_add_hash);
+		tun_vnet_hash_report(vnet_hash, skb, &keys_basic, rxq, tap_add_hash);
 		queue = rcu_dereference(tap->taps[rxq % numvtaps]);
 		goto out;
 	}
@@ -1058,7 +1065,7 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 		tap = rtnl_dereference(q->tap);
 		ret = tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags,
 				     tap ? &tap->vnet_hash : NULL, -EINVAL,
-				     cmd, sp);
+				     true, cmd, sp);
 		rtnl_unlock();
 		return ret;
 	}
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 27308417b834..18528568aed7 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -209,7 +209,7 @@ struct tun_struct {
 	struct bpf_prog __rcu *xdp_prog;
 	struct tun_prog __rcu *steering_prog;
 	struct tun_prog __rcu *filter_prog;
-	struct tun_vnet_hash vnet_hash;
+	struct tun_vnet_hash_container __rcu *vnet_hash;
 	struct ethtool_link_ksettings link_ksettings;
 	/* init args */
 	struct file *file;
@@ -468,7 +468,9 @@ static const struct virtio_net_hash *tun_find_hash(const struct sk_buff *skb)
  * the userspace application move between processors, we may get a
  * different rxq no. here.
  */
-static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
+static u16 tun_automq_select_queue(struct tun_struct *tun,
+				   const struct tun_vnet_hash_container *vnet_hash,
+				   struct sk_buff *skb)
 {
 	struct flow_keys keys;
 	struct flow_keys_basic keys_basic;
@@ -493,7 +495,7 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 		.control = keys.control,
 		.basic = keys.basic
 	};
-	tun_vnet_hash_report(&tun->vnet_hash, skb, &keys_basic, skb->l4_hash ? skb->hash : txq,
+	tun_vnet_hash_report(vnet_hash, skb, &keys_basic, skb->l4_hash ? skb->hash : txq,
 			     tun_add_hash);
 
 	return txq;
@@ -523,10 +525,17 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
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
@@ -2248,6 +2257,9 @@ static void tun_free_netdev(struct net_device *dev)
 	security_tun_dev_free_security(tun->security);
 	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
 	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
+	rtnl_lock();
+	kfree_rcu_mightsleep(rtnl_dereference(tun->vnet_hash));
+	rtnl_unlock();
 }
 
 static void tun_setup(struct net_device *dev)
@@ -2946,13 +2958,9 @@ static int tun_set_queue(struct file *file, struct ifreq *ifr)
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
@@ -3019,6 +3027,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	int sndbuf;
 	int ret;
 	bool do_notify = false;
+	struct tun_vnet_hash_container *vnet_hash;
 
 	if (cmd == TUNSETIFF || cmd == TUNSETQUEUE ||
 	    (_IOC_TYPE(cmd) == SOCK_IOC_TYPE && cmd != SIOCGSKNS)) {
@@ -3078,7 +3087,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	}
 
 	if (!tun) {
-		ret = tun_vnet_ioctl(NULL, NULL, NULL, -EBADFD, cmd, argp);
+		ret = tun_vnet_ioctl(NULL, NULL, NULL, -EBADFD, true, cmd, argp);
 		goto unlock;
 	}
 
@@ -3256,11 +3265,27 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
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
@@ -3280,7 +3305,9 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 
 	default:
 		ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags,
-				     &tun->vnet_hash, -EINVAL, cmd, argp);
+				     &tun->vnet_hash, -EINVAL,
+				     !rtnl_dereference(tun->steering_prog),
+				     cmd, argp);
 	}
 
 	if (do_notify)
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index 589a97dd7d02..f5de4fe9d14e 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -9,6 +9,13 @@
 typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_buff *);
 typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const struct sk_buff *);
 
+struct tun_vnet_hash_container {
+	struct tun_vnet_hash common;
+	struct tun_vnet_hash_rss rss;
+	u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
+	u16 rss_indirection_table[];
+};
+
 static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
 {
 	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) && (flags & TUN_VNET_BE)) &&
@@ -62,14 +69,16 @@ static inline __virtio16 cpu_to_tun_vnet16(unsigned int flags, u16 val)
 }
 
 static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
-				  struct tun_vnet_hash *hash, long fallback,
+				  struct tun_vnet_hash_container __rcu **hashp,
+				  long fallback, bool can_rss,
 				  unsigned int cmd, void __user *argp)
 {
 	static const struct tun_vnet_hash cap = {
-		.flags = TUN_VNET_HASH_REPORT,
+		.flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
 		.types = VIRTIO_NET_SUPPORTED_HASH_TYPES
 	};
 	struct tun_vnet_hash hash_buf;
+	struct tun_vnet_hash_container *hash;
 	int __user *sp = argp;
 	int s;
 
@@ -132,13 +141,57 @@ static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
 		return copy_to_user(argp, &cap, sizeof(cap)) ? -EFAULT : 0;
 
 	case TUNSETVNETHASH:
-		if (!hash)
+		if (!hashp)
 			return -EBADFD;
 
 		if (copy_from_user(&hash_buf, argp, sizeof(hash_buf)))
 			return -EFAULT;
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
 
-		*hash = hash_buf;
+		hash->common = hash_buf;
+		kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(*hashp, hash));
 		return 0;
 
 	default:
@@ -146,7 +199,7 @@ static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
 	}
 }
 
-static inline void tun_vnet_hash_report(const struct tun_vnet_hash *hash,
+static inline void tun_vnet_hash_report(const struct tun_vnet_hash_container *hash,
 					struct sk_buff *skb,
 					const struct flow_keys_basic *keys,
 					u32 value,
@@ -154,7 +207,7 @@ static inline void tun_vnet_hash_report(const struct tun_vnet_hash *hash,
 {
 	struct virtio_net_hash *report;
 
-	if (!(hash->flags & TUN_VNET_HASH_REPORT))
+	if (!hash || !(hash->common.flags & TUN_VNET_HASH_REPORT))
 		return;
 
 	report = vnet_hash_add(skb);
@@ -162,11 +215,40 @@ static inline void tun_vnet_hash_report(const struct tun_vnet_hash *hash,
 		return;
 
 	*report = (struct virtio_net_hash) {
-		.report = virtio_net_hash_report(hash->types, keys),
+		.report = virtio_net_hash_report(hash->common.types, keys),
 		.value = value
 	};
 }
 
+static inline u16 tun_vnet_rss_select_queue(u32 numqueues,
+					    const struct tun_vnet_hash_container *hash,
+					    struct sk_buff *skb,
+					    tun_vnet_hash_add vnet_hash_add)
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
+
 static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
 				   struct iov_iter *from,
 				   struct virtio_net_hdr *hdr)
diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
index 5bbb343a6dba..7334c46a3f10 100644
--- a/include/linux/if_tap.h
+++ b/include/linux/if_tap.h
@@ -4,7 +4,6 @@
 
 #include <net/sock.h>
 #include <linux/skb_array.h>
-#include <uapi/linux/if_tun.h>
 
 struct file;
 struct socket;
@@ -32,6 +31,7 @@ static inline struct ptr_ring *tap_get_ptr_ring(struct file *f)
 #define MAX_TAP_QUEUES 256
 
 struct tap_queue;
+struct tun_vnet_hash_container;
 
 struct tap_dev {
 	struct net_device	*dev;
@@ -44,7 +44,7 @@ struct tap_dev {
 	int			numqueues;
 	netdev_features_t	tap_features;
 	int			minor;
-	struct tun_vnet_hash	vnet_hash;
+	struct tun_vnet_hash_container __rcu *vnet_hash;
 
 	void (*update_features)(struct tap_dev *tap, netdev_features_t features);
 	void (*count_tx_dropped)(struct tap_dev *tap);
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index d11e79b4e0dc..4887f97500a8 100644
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
  * The %TUN_VNET_HASH_REPORT flag set with this ioctl will be effective only
  * after calling the %TUNSETVNETHDRSZ ioctl with a number greater than or equal
  * to the size of &struct virtio_net_hdr_v1_hash.
@@ -148,6 +156,13 @@ struct tun_filter {
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
@@ -163,4 +178,16 @@ struct tun_vnet_hash {
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
2.46.2


