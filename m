Return-Path: <linux-kselftest+bounces-18283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A8E984183
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 11:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2903E1C234B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 09:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF35183087;
	Tue, 24 Sep 2024 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Yolsy7Ae"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C8517C9F9
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168494; cv=none; b=YkC5m98o518lZoEuaq9yKFPbCKZYVWcUeTM36MRx8gXlj6S/G1FolH8DYDnM6kKotG/ux441ZmzJ1Nhy2d858fKZedcqNSoVipsn33PzUv22uXmnKEFOFtu4h+YJH8/un3CDXUUMMZLRrsEM83SxdEVO0/9QbCukHjmYmQyh0cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168494; c=relaxed/simple;
	bh=BqiOF36eGEzK1kC4qfdF9HSccFKNzNFy1wd25a7fw8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=feh6y4vXRrLqFoT1yiqU7HnH4vLI0ZhXKG3dJEBcQ2x9elxDJFt+Zlka0hbnUfDGt8UCRcyXmyHhgGzLjpf8Od/88eDgpc2oPStQnNscnAqrmmplycDJ0dMOaAZL3W4WWNLT3YzND+2TpJDxMUIB7p2o1l2YbFGfknBr36LmMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Yolsy7Ae; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5365928acd0so1481636e87.2
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727168491; x=1727773291; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6RBR4ATFwa2DujiC7hD9cms582pJp14NlPm8BLwampE=;
        b=Yolsy7Aem6lnBT4qR0LKd96+BKO7CMSscNUUy14Iv9O3X+A0ixs53koF23fur5fAcB
         Kgmbayy+ishsCI0Qs1sgZAx2990iSRa/mP7gNw/iLGjvJt6YEB45KpleJ781uB9I6ly2
         djl9PXxaeZ6ovG7heFIPF6vQzaxEVm0ZZDcSMWdfCUwSgPux1xlZUEqXKMaFShYzj3TV
         A2YtSSLGm841mCR//7mr74etumoktzr6FjqzoPlxDFZkRVgSyB6TFnRvQpYJDi7V2O6E
         dxvbYD2dDlm5kbhNbbEnFEPLoXOosn2OMSN5VVo9MRiGHfgcjsaGLcgK0HLfwm5nnzNm
         f05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168491; x=1727773291;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RBR4ATFwa2DujiC7hD9cms582pJp14NlPm8BLwampE=;
        b=O/vWTVgNP6BMXwczNc/dRkIdhIYs2bHwAjSbKqO0HPGyEiwfvB5LE/jECM5WMdLghv
         lU33pGU6C7Y6dxmS/XNnr0aJBIqo3n7pDUoFzSfVtm99XRGUSCRdc2Q/R5CiOAcNwO25
         vZxB99xhJyjBSodvKNPVjAkzIvT3rXq9Nrt/QMP5wztb2RNun/MI9me7MFaWHl0Iunf5
         //kHHh6yQfDLMX1sXMnu9HZgWwfKOpBHSyqlEdhRYtXFrKomRGNKKpGPLlzfvDokkBWM
         rmj8z4o6yjX6bMis1MhW0FIcNXAH5eFz8S/oIxKnALYDZvjQ4typBomcUl5bxqJbi4CM
         KYFg==
X-Forwarded-Encrypted: i=1; AJvYcCUeq9ty1ZXH/IVgTw0FHc60OTTdwv/UA9ZaA/0YsplHXm2rmteRjJEMP7ONm0qXx46bTo7Qp9WybW/LBTl/EAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH+Kr2d+N8IUUFsZTpVlDalIjd5RF7rXeaBsxzm1RNy8GR7Xf/
	okeHXLjAY+7btkW7tWcnXGbP6t1mkNkXjy2FDny5fcX48qA61p/aR7iRJF9uik6EuuXfTyyH6Lh
	UD6N9qVqE
X-Google-Smtp-Source: AGHT+IGnxbsfjWUZgFFSmmowMsSKYMIW4hkUUB3O/HwRE13GAq+t2XHXYFNBXuQ3/HO9v4TxEfO7kw==
X-Received: by 2002:a05:6512:3f15:b0:533:efaf:ab26 with SMTP id 2adb3069b0e04-536ad182603mr7210150e87.36.1727168490499;
        Tue, 24 Sep 2024 02:01:30 -0700 (PDT)
Received: from localhost ([193.32.29.227])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5c5cf4d77d9sm535632a12.94.2024.09.24.02.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:01:29 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 24 Sep 2024 11:01:12 +0200
Subject: [PATCH RFC v4 7/9] tun: Introduce virtio-net RSS
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-rss-v4-7-84e932ec0e6c@daynix.com>
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
 drivers/net/tun.c           | 158 ++++++++++++++++++++++++++++++++++++++------
 include/uapi/linux/if_tun.h |  27 ++++++++
 2 files changed, 163 insertions(+), 22 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 986e4a5bf04d..680eb4561a7f 100644
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
@@ -214,7 +217,7 @@ struct tun_struct {
 	struct bpf_prog __rcu *xdp_prog;
 	struct tun_prog __rcu *steering_prog;
 	struct tun_prog __rcu *filter_prog;
-	struct tun_vnet_hash vnet_hash;
+	struct tun_vnet_hash_container __rcu *vnet_hash;
 	struct ethtool_link_ksettings link_ksettings;
 	/* init args */
 	struct file *file;
@@ -227,7 +230,7 @@ struct veth {
 };
 
 static const struct tun_vnet_hash tun_vnet_hash_cap = {
-	.flags = TUN_VNET_HASH_REPORT,
+	.flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
 	.types = VIRTIO_NET_SUPPORTED_HASH_TYPES
 };
 
@@ -333,8 +336,10 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 		return -EFAULT;
 
 	if (be) {
+		struct tun_vnet_hash_container *vnet_hash = rtnl_dereference(tun->vnet_hash);
+
 		if (!(tun->flags & TUN_VNET_LE) &&
-		    (tun->vnet_hash.flags & TUN_VNET_HASH_REPORT))
+		    vnet_hash && (vnet_hash->flags & TUN_VNET_HASH_REPORT))
 			return -EBUSY;
 
 		tun->flags |= TUN_VNET_BE;
@@ -537,7 +542,8 @@ static inline void tun_flow_save_rps_rxhash(struct tun_flow_entry *e, u32 hash)
  * the userspace application move between processors, we may get a
  * different rxq no. here.
  */
-static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
+static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb,
+				   const struct tun_vnet_hash_container *vnet_hash)
 {
 	struct tun_vnet_hash_ext *ext;
 	struct flow_keys keys;
@@ -558,10 +564,10 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 		txq = reciprocal_scale(txq, numqueues);
 	}
 
-	if (tun->vnet_hash.flags & TUN_VNET_HASH_REPORT) {
+	if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_REPORT)) {
 		ext = skb_ext_add(skb, SKB_EXT_TUN_VNET_HASH);
 		if (ext) {
-			u32 types = tun->vnet_hash.types;
+			u32 types = vnet_hash->common.types;
 
 			ext->report = virtio_net_hash_report(types, keys.basic);
 			ext->value = skb->l4_hash ? skb->hash : txq;
@@ -588,6 +594,37 @@ static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
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
+	virtio_net_hash_rss(skb, vnet_hash->common.types, vnet_hash->rss_key, &hash);
+
+	if (!hash.report)
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
@@ -595,10 +632,16 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
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
+			ret = tun_vnet_rss_select_queue(tun, skb, vnet_hash);
+		else
+			ret = tun_automq_select_queue(tun, skb, vnet_hash);
+	}
 	rcu_read_unlock();
 
 	return ret;
@@ -2376,6 +2419,9 @@ static void tun_free_netdev(struct net_device *dev)
 	security_tun_dev_free_security(tun->security);
 	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
 	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
+	rtnl_lock();
+	kfree_rcu_mightsleep(rtnl_dereference(tun->vnet_hash));
+	rtnl_unlock();
 }
 
 static void tun_setup(struct net_device *dev)
@@ -3074,13 +3120,9 @@ static int tun_set_queue(struct file *file, struct ifreq *ifr)
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
@@ -3146,10 +3188,12 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	int ifindex;
 	int sndbuf;
 	int vnet_hdr_sz;
+	int fd;
 	int le;
 	int ret;
 	bool do_notify = false;
-	struct tun_vnet_hash vnet_hash;
+	struct tun_vnet_hash vnet_hash_common;
+	struct tun_vnet_hash_container *vnet_hash;
 
 	if (cmd == TUNSETIFF || cmd == TUNSETQUEUE ||
 	    (_IOC_TYPE(cmd) == SOCK_IOC_TYPE && cmd != SIOCGSKNS)) {
@@ -3373,7 +3417,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			break;
 		}
 
-		if (tun->vnet_hash.flags & TUN_VNET_HASH_REPORT &&
+		vnet_hash = rtnl_dereference(tun->vnet_hash);
+		if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_REPORT) &&
 		    vnet_hdr_sz < (int)sizeof(struct virtio_net_hdr_v1_hash)) {
 			ret = -EBUSY;
 			break;
@@ -3396,7 +3441,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		if (le) {
 			tun->flags |= TUN_VNET_LE;
 		} else {
-			if (tun->vnet_hash.flags & TUN_VNET_HASH_REPORT &&
+			vnet_hash = rtnl_dereference(tun->vnet_hash);
+			if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_REPORT) &&
 			    !tun_legacy_is_little_endian(tun)) {
 				ret = -EBUSY;
 				break;
@@ -3446,11 +3492,27 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
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
@@ -3469,20 +3531,72 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	case TUNSETVNETHASH:
-		if (copy_from_user(&vnet_hash, argp, sizeof(vnet_hash))) {
+		if (copy_from_user(&vnet_hash_common, argp, sizeof(vnet_hash_common))) {
 			ret = -EFAULT;
 			break;
 		}
 		argp = (struct tun_vnet_hash __user *)argp + 1;
 
-		if ((vnet_hash.flags & TUN_VNET_HASH_REPORT) &&
+		if ((vnet_hash_common.flags & TUN_VNET_HASH_REPORT) &&
 		    (tun->vnet_hdr_sz < sizeof(struct virtio_net_hdr_v1_hash) ||
 		     !tun_is_little_endian(tun))) {
 			ret = -EBUSY;
 			break;
 		}
 
-		tun->vnet_hash = vnet_hash;
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
+			size = struct_size(vnet_hash, rss_indirection_table,
+					   (size_t)rss.indirection_table_mask + 1);
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
+		}
+
+		vnet_hash->common = vnet_hash_common;
+		kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(tun->vnet_hash, vnet_hash));
 		break;
 
 	default:
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


