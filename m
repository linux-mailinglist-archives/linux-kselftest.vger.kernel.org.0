Return-Path: <linux-kselftest+bounces-48839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F543D16A81
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 06:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2221D3019BFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 05:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9643330BB8A;
	Tue, 13 Jan 2026 05:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4Px619S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8230301477
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 05:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768280922; cv=none; b=IKTbnIKQ1rqovMcCSa11LAXX5kab90R5wPsW1qNul8/MNt+2AdUrxi+0ZEGDxz78P+sVIJoCd9pZFH2Xv24q2wh5Xfvd8WLJ1aXjqA7d+66/eg7HuZKXQBBhYqMcIkYYcFhyWgz9kPEe5H8I+i/174bESAGWvDrKi9e0EvPjXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768280922; c=relaxed/simple;
	bh=6cs0YXM+a493xsWlEabGfQaFmc2MbPVz/iabffLgCjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7KNcgQlxaAO9DS3ThoyJhNyNAT5wDLCh2qGB2Yj3dog6Q5uCDvdP/BrDEhm2k2Si7ZaJ7kUe9qSwbcF5xSIjaYc7+HcqvEGGFToOab9y4/qc9q603t1DHwDjUbV5egaKoYbi+2sTdcR4dwo6LLJi+AcSB3GQH5bGFm+10DDk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4Px619S; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88a2f2e5445so87165186d6.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 21:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768280919; x=1768885719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3IKURwKGnxX6HNHsWoaQpKhqbdpfY8FvNlLLS35mCU=;
        b=V4Px619SK9uCwx2n8kRubPB6T82B7H78bcrvSB1EVJG5kNLQnSQyReLYdXyOKlwmiq
         cQsKlMxnYf72I5v7biBIkjjNIsoqCJW5p7zaR1FDGQhaEqlrjg++/cF2+i6qX0SCjMeP
         HKsBEIV1SDb9GJ37SJRWZGL5yFBdICE9b41E5pmM9E1eTItNeyU/+TEgEERqkIbWuNne
         gu95GPWCwKC4SS15SJCOtdx88RRMkNsci5h9MH9Zu3dcwmScZM287aV296M6pCA62hA+
         2ptMoA0yEJzrf3oiGjTFyCdtIQPoX9p8FuVZUCn8Cq9LRDZjOBNykFGZOQGyJ7u4s/0A
         1KyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768280919; x=1768885719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q3IKURwKGnxX6HNHsWoaQpKhqbdpfY8FvNlLLS35mCU=;
        b=Ey4nyvFpYLV+u+nnheFrVFoexJAHa2/pPHj9TVhLiR9UfLbL08aEo4pC5jOGQCzcMg
         gfBOQzjYrtdY141JCaa0apppUGuDAzKOELf1Y7drAJFmRhma9y91AzWG+pn6586N/aLc
         qHXG2S8WG81z7AO5CockTiXREfCUI5u1b7cKd2BpfW3cohQfAykvYjrUgPC01NOn1o83
         23nRRz7jw0PyQ79SGrOe5qHmT5RJ0J4WnjYKc4ZOq77CJxUFi3VH7ER5AkRYuTTLYNni
         R0TL97Gl7SZQ84lVQ/jD0SOUXUQMX/rWCRJs3L2tmunQ1XyqSaEOsxV38TjTalsmWNBt
         ewpg==
X-Forwarded-Encrypted: i=1; AJvYcCVrEF4uePBl9skzjOwgnohb8QCSkRG7UVsJ5WIh88ZQDK9qhx9yaU4v7hPq71tM/Mo/K/BybhEbWHlW71hIB/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9PtsyyV41jPTmiM/oqN+94C5S48bntbkkW96Tl0bzy4qvKSmy
	7khKjv28+UX2RenvBCfx/rBoZkQy2hxNg10kRVFuGHBUfR0OI6BLf0ENQOEcfw==
X-Gm-Gg: AY/fxX5rBf/k/BfocBvO2yMDeMROl6QriIE0p/WmuMPA24mWSG2XdU+Xrcgw2K3peIf
	wGZU4V+GNpGRgAHENZ4oJMj5+cTIMkW6NaRFiBwEnH0suFl2WMSjjzURxwOeRbw1ULZaHeFXUU0
	h8rU0iZMamjhdU9JTOFvAaG22a+Z0RsPfdL384oUyB96Q7kPM76vbLS0hTzWl9VQ9YNqgUuzF2l
	Zk7zUN9GccIZgFpmWZjsTDySxinc8UcvIckwnzldionjbM1WKnSxGaTyD0jTJYOOz1R/i0YaQZy
	VltIYeB3m+E2KXUv4O2Ot+/2A9xElyI+PGRfXW/wstVuUyGhEqD/npMAaSMtN2Oogx6Q2OPT7mi
	nVWGxnZz2x2+BWLtM8Is8bPZLRO6VHBhTMNz5wbi1C1avgZSnUXQL6DBYV3A2FCGAbZ6t4CKZew
	UFUBjvrXKs1n0DwzD1Dj8=
X-Google-Smtp-Source: AGHT+IE+MRPt4JHCgnxxwqAITgEZtdpswlUUO9Q+Zv4fW5kCom+rcBBb/o8iSuNjefs5H4pDPBnDTQ==
X-Received: by 2002:a05:690c:4b07:b0:78d:6dac:e903 with SMTP id 00721157ae682-790b56f472dmr169174697b3.60.1768273978973;
        Mon, 12 Jan 2026 19:12:58 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa553738sm76571187b3.8.2026.01.12.19.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:12:58 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:12 -0800
Subject: [PATCH net-next v14 03/12] vsock: add netns support to virtio
 transports
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-3-a5c332db3e2b@meta.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
In-Reply-To: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add netns support to loopback and vhost. Keep netns disabled for
virtio-vsock, but add necessary changes to comply with common API
updates.

This is the patch in the series when vhost-vsock namespaces actually
come online.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v14:
- fixed merge conflicts in drivers/vhost/vsock.c

Changes in v13:
- do not store or pass the mode around now that net->vsock.mode is
  immutable
- move virtio_transport_stream_allow() into virtio_transport.c
  because virtio is the only caller now

Changes in v12:
- change seqpacket_allow() and stream_allow() to return true for
  loopback and vhost (Stefano)

Changes in v11:
- reorder with the skb ownership patch for loopback (Stefano)
- toggle vhost_transport_supports_local_mode() to true

Changes in v10:
- Splitting patches complicates the series with meaningless placeholder
  values that eventually get replaced anyway, so to avoid that this
  patch combines into one. Links to previous patches here:
  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-3-852787a37bed@meta.com/
  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-6-852787a37bed@meta.com/
  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-7-852787a37bed@meta.com/
- remove placeholder values (Stefano)
- update comment describe net/net_mode for
  virtio_transport_reset_no_sock()
---
 drivers/vhost/vsock.c                   | 38 ++++++++++++++++-------
 include/linux/virtio_vsock.h            |  5 +--
 net/vmw_vsock/virtio_transport.c        | 13 ++++++--
 net/vmw_vsock/virtio_transport_common.c | 54 +++++++++++++++++++--------------
 net/vmw_vsock/vsock_loopback.c          | 14 +++++++--
 5 files changed, 84 insertions(+), 40 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 647ded6f6ea5..488d7fa6e4ec 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -48,6 +48,8 @@ static DEFINE_READ_MOSTLY_HASHTABLE(vhost_vsock_hash, 8);
 struct vhost_vsock {
 	struct vhost_dev dev;
 	struct vhost_virtqueue vqs[2];
+	struct net *net;
+	netns_tracker ns_tracker;
 
 	/* Link to global vhost_vsock_hash, writes use vhost_vsock_mutex */
 	struct hlist_node hash;
@@ -69,7 +71,7 @@ static u32 vhost_transport_get_local_cid(void)
 /* Callers must be in an RCU read section or hold the vhost_vsock_mutex.
  * The return value can only be dereferenced while within the section.
  */
-static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
+static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
 {
 	struct vhost_vsock *vsock;
 
@@ -81,9 +83,9 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
 		if (other_cid == 0)
 			continue;
 
-		if (other_cid == guest_cid)
+		if (other_cid == guest_cid &&
+		    vsock_net_check_mode(net, vsock->net))
 			return vsock;
-
 	}
 
 	return NULL;
@@ -272,7 +274,7 @@ static void vhost_transport_send_pkt_work(struct vhost_work *work)
 }
 
 static int
-vhost_transport_send_pkt(struct sk_buff *skb)
+vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vhost_vsock *vsock;
@@ -281,7 +283,7 @@ vhost_transport_send_pkt(struct sk_buff *skb)
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid));
+	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid), net);
 	if (!vsock) {
 		rcu_read_unlock();
 		kfree_skb(skb);
@@ -308,7 +310,8 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
+	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid,
+				sock_net(sk_vsock(vsk)));
 	if (!vsock)
 		goto out;
 
@@ -410,6 +413,12 @@ static bool vhost_transport_msgzerocopy_allow(void)
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 					    u32 remote_cid);
 
+static bool
+vhost_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
+{
+	return true;
+}
+
 static struct virtio_transport vhost_transport = {
 	.transport = {
 		.module                   = THIS_MODULE,
@@ -434,7 +443,7 @@ static struct virtio_transport vhost_transport = {
 		.stream_has_space         = virtio_transport_stream_has_space,
 		.stream_rcvhiwat          = virtio_transport_stream_rcvhiwat,
 		.stream_is_active         = virtio_transport_stream_is_active,
-		.stream_allow             = virtio_transport_stream_allow,
+		.stream_allow             = vhost_transport_stream_allow,
 
 		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
 		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
@@ -467,11 +476,12 @@ static struct virtio_transport vhost_transport = {
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 					    u32 remote_cid)
 {
+	struct net *net = sock_net(sk_vsock(vsk));
 	struct vhost_vsock *vsock;
 	bool seqpacket_allow = false;
 
 	rcu_read_lock();
-	vsock = vhost_vsock_get(remote_cid);
+	vsock = vhost_vsock_get(remote_cid, net);
 
 	if (vsock)
 		seqpacket_allow = vsock->seqpacket_allow;
@@ -542,7 +552,8 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
 		    le64_to_cpu(hdr->dst_cid) ==
 		    vhost_transport_get_local_cid())
-			virtio_transport_recv_pkt(&vhost_transport, skb);
+			virtio_transport_recv_pkt(&vhost_transport, skb,
+						  vsock->net);
 		else
 			kfree_skb(skb);
 
@@ -659,6 +670,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 {
 	struct vhost_virtqueue **vqs;
 	struct vhost_vsock *vsock;
+	struct net *net;
 	int ret;
 
 	/* This struct is large and allocation could fail, fall back to vmalloc
@@ -674,6 +686,9 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
+	net = current->nsproxy->net_ns;
+	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
+
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 
@@ -715,7 +730,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	rcu_read_lock();
 
 	/* If the peer is still valid, no need to reset connection */
-	if (vhost_vsock_get(vsk->remote_addr.svm_cid)) {
+	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk))) {
 		rcu_read_unlock();
 		return;
 	}
@@ -764,6 +779,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
 
 	vhost_dev_cleanup(&vsock->dev);
+	put_net_track(vsock->net, &vsock->ns_tracker);
 	kfree(vsock->dev.vqs);
 	vhost_vsock_free(vsock);
 	return 0;
@@ -790,7 +806,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 
 	/* Refuse if CID is already in use */
 	mutex_lock(&vhost_vsock_mutex);
-	other = vhost_vsock_get(guest_cid);
+	other = vhost_vsock_get(guest_cid, vsock->net);
 	if (other && other != vsock) {
 		mutex_unlock(&vhost_vsock_mutex);
 		return -EADDRINUSE;
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 1845e8d4f78d..f91704731057 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -173,6 +173,7 @@ struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
+	struct net *net;
 	u32 pkt_len;
 	u16 type;
 	u16 op;
@@ -185,7 +186,7 @@ struct virtio_transport {
 	struct vsock_transport transport;
 
 	/* Takes ownership of the packet */
-	int (*send_pkt)(struct sk_buff *skb);
+	int (*send_pkt)(struct sk_buff *skb, struct net *net);
 
 	/* Used in MSG_ZEROCOPY mode. Checks, that provided data
 	 * (number of buffers) could be transmitted with zerocopy
@@ -280,7 +281,7 @@ virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
 void virtio_transport_destruct(struct vsock_sock *vsk);
 
 void virtio_transport_recv_pkt(struct virtio_transport *t,
-			       struct sk_buff *skb);
+			       struct sk_buff *skb, struct net *net);
 void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
 void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 37eeefddb48c..22ff5a503070 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -231,7 +231,7 @@ static int virtio_transport_send_skb_fast_path(struct virtio_vsock *vsock, struc
 }
 
 static int
-virtio_transport_send_pkt(struct sk_buff *skb)
+virtio_transport_send_pkt(struct sk_buff *skb, struct net *net)
 {
 	struct virtio_vsock_hdr *hdr;
 	struct virtio_vsock *vsock;
@@ -536,6 +536,11 @@ static bool virtio_transport_msgzerocopy_allow(void)
 	return true;
 }
 
+bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
+{
+	return vsock_net_mode(sock_net(sk_vsock(vsk))) == VSOCK_NET_MODE_GLOBAL;
+}
+
 static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
 					     u32 remote_cid);
 
@@ -665,7 +670,11 @@ static void virtio_transport_rx_work(struct work_struct *work)
 				virtio_vsock_skb_put(skb, payload_len);
 
 			virtio_transport_deliver_tap_pkt(skb);
-			virtio_transport_recv_pkt(&virtio_transport, skb);
+
+			/* Force virtio-transport into global mode since it
+			 * does not yet support local-mode namespacing.
+			 */
+			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
 		}
 	} while (!virtqueue_enable_cb(vq));
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 718be9f33274..c126aa235091 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -413,7 +413,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 
 		virtio_transport_inc_tx_pkt(vvs, skb);
 
-		ret = t_ops->send_pkt(skb);
+		ret = t_ops->send_pkt(skb, info->net);
 		if (ret < 0)
 			break;
 
@@ -527,6 +527,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1043,12 +1044,6 @@ bool virtio_transport_stream_is_active(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_stream_is_active);
 
-bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
-{
-	return vsock_net_mode(sock_net(sk_vsock(vsk))) == VSOCK_NET_MODE_GLOBAL;
-}
-EXPORT_SYMBOL_GPL(virtio_transport_stream_allow);
-
 int virtio_transport_dgram_bind(struct vsock_sock *vsk,
 				struct sockaddr_vm *addr)
 {
@@ -1067,6 +1062,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_REQUEST,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1082,6 +1078,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 			 (mode & SEND_SHUTDOWN ?
 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1108,6 +1105,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 		.msg = msg,
 		.pkt_len = len,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1145,6 +1143,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.reply = !!skb,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
@@ -1156,9 +1155,13 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 
 /* Normally packets are associated with a socket.  There may be no socket if an
  * attempt was made to connect to a socket that does not exist.
+ *
+ * net refers to the namespace of whoever sent the invalid message. For
+ * loopback, this is the namespace of the socket. For vhost, this is the
+ * namespace of the VM (i.e., vhost_vsock).
  */
 static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
-					  struct sk_buff *skb)
+					  struct sk_buff *skb, struct net *net)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct virtio_vsock_pkt_info info = {
@@ -1171,6 +1174,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		 * sock_net(sk) until the reply skb is freed.
 		 */
 		.vsk = vsock_sk(skb->sk),
+
+		/* net is not defined here because we pass it directly to
+		 * t->send_pkt(), instead of relying on
+		 * virtio_transport_send_pkt_info() to pass it. It is not needed
+		 * by virtio_transport_alloc_skb().
+		 */
 	};
 	struct sk_buff *reply;
 
@@ -1189,7 +1198,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 	if (!reply)
 		return -ENOMEM;
 
-	return t->send_pkt(reply);
+	return t->send_pkt(reply, net);
 }
 
 /* This function should be called with sk_lock held and SOCK_DONE set */
@@ -1471,6 +1480,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 		.remote_port = le32_to_cpu(hdr->src_port),
 		.reply = true,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1513,12 +1523,12 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	int ret;
 
 	if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_REQUEST) {
-		virtio_transport_reset_no_sock(t, skb);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
 		return -EINVAL;
 	}
 
 	if (sk_acceptq_is_full(sk)) {
-		virtio_transport_reset_no_sock(t, skb);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
 		return -ENOMEM;
 	}
 
@@ -1526,13 +1536,13 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	 * Subsequent enqueues would lead to a memory leak.
 	 */
 	if (sk->sk_shutdown == SHUTDOWN_MASK) {
-		virtio_transport_reset_no_sock(t, skb);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
 		return -ESHUTDOWN;
 	}
 
 	child = vsock_create_connected(sk);
 	if (!child) {
-		virtio_transport_reset_no_sock(t, skb);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
 		return -ENOMEM;
 	}
 
@@ -1554,7 +1564,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	 */
 	if (ret || vchild->transport != &t->transport) {
 		release_sock(child);
-		virtio_transport_reset_no_sock(t, skb);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
 		sock_put(child);
 		return ret;
 	}
@@ -1582,7 +1592,7 @@ static bool virtio_transport_valid_type(u16 type)
  * lock.
  */
 void virtio_transport_recv_pkt(struct virtio_transport *t,
-			       struct sk_buff *skb)
+			       struct sk_buff *skb, struct net *net)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct sockaddr_vm src, dst;
@@ -1605,24 +1615,24 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 					le32_to_cpu(hdr->fwd_cnt));
 
 	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
-		(void)virtio_transport_reset_no_sock(t, skb);
+		(void)virtio_transport_reset_no_sock(t, skb, net);
 		goto free_pkt;
 	}
 
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket(&src, &dst);
+	sk = vsock_find_connected_socket_net(&src, &dst, net);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst);
+		sk = vsock_find_bound_socket_net(&dst, net);
 		if (!sk) {
-			(void)virtio_transport_reset_no_sock(t, skb);
+			(void)virtio_transport_reset_no_sock(t, skb, net);
 			goto free_pkt;
 		}
 	}
 
 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
-		(void)virtio_transport_reset_no_sock(t, skb);
+		(void)virtio_transport_reset_no_sock(t, skb, net);
 		sock_put(sk);
 		goto free_pkt;
 	}
@@ -1641,7 +1651,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
 	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
-		(void)virtio_transport_reset_no_sock(t, skb);
+		(void)virtio_transport_reset_no_sock(t, skb, net);
 		release_sock(sk);
 		sock_put(sk);
 		goto free_pkt;
@@ -1673,7 +1683,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		kfree_skb(skb);
 		break;
 	default:
-		(void)virtio_transport_reset_no_sock(t, skb);
+		(void)virtio_transport_reset_no_sock(t, skb, net);
 		kfree_skb(skb);
 		break;
 	}
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 378a96dcb666..dbd4d81e0acb 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -26,7 +26,7 @@ static u32 vsock_loopback_get_local_cid(void)
 	return VMADDR_CID_LOCAL;
 }
 
-static int vsock_loopback_send_pkt(struct sk_buff *skb)
+static int vsock_loopback_send_pkt(struct sk_buff *skb, struct net *net)
 {
 	struct vsock_loopback *vsock = &the_vsock_loopback;
 	int len = skb->len;
@@ -48,6 +48,13 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
 
 static bool vsock_loopback_seqpacket_allow(struct vsock_sock *vsk,
 					   u32 remote_cid);
+
+static bool vsock_loopback_stream_allow(struct vsock_sock *vsk, u32 cid,
+					u32 port)
+{
+	return true;
+}
+
 static bool vsock_loopback_msgzerocopy_allow(void)
 {
 	return true;
@@ -77,7 +84,7 @@ static struct virtio_transport loopback_transport = {
 		.stream_has_space         = virtio_transport_stream_has_space,
 		.stream_rcvhiwat          = virtio_transport_stream_rcvhiwat,
 		.stream_is_active         = virtio_transport_stream_is_active,
-		.stream_allow             = virtio_transport_stream_allow,
+		.stream_allow             = vsock_loopback_stream_allow,
 
 		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
 		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
@@ -132,7 +139,8 @@ static void vsock_loopback_work(struct work_struct *work)
 		 */
 		virtio_transport_consume_skb_sent(skb, false);
 		virtio_transport_deliver_tap_pkt(skb);
-		virtio_transport_recv_pkt(&loopback_transport, skb);
+		virtio_transport_recv_pkt(&loopback_transport, skb,
+					  sock_net(skb->sk));
 	}
 }
 

-- 
2.47.3


