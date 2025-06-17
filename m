Return-Path: <linux-kselftest+bounces-35171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1661ADC0C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 06:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50EF617409D
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7540925A2DA;
	Tue, 17 Jun 2025 04:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edxAuOoB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F82571A5;
	Tue, 17 Jun 2025 04:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134787; cv=none; b=sBHh8OMX5CxnNuY0RSJKWoabJ1mIAQQye/TjUqRsIISoqbdTgHZzPKe11Ic3sk2b1hZj+eqDQmwYzSaEKMobcRp6aI+RH65HClKyQO2VC2ReJJMUJ/3iHct6T0IQ7/SWRFr5q2TUtUFLLHg715NTgzZ7UuAAz3c+8qIwDAXlQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134787; c=relaxed/simple;
	bh=r7BJdhjaCrqjDtcDL+/xFlmv8Nfpm1btrHOfSVyIAFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jFayv3r7l/XgIK7ha1o3+XNTwObQr8EW5HeZlkB6oSZkutZxxFTFfbzkx/o8hKwYocvddFHb7qQkCrE14tsZpfVdEh+rffZcMhoqya8s0X0LpOkGde5/zFcnQlvj+lt3fSjBumd0rAzDWqSQhUExePf34obRNbTd5tFd3i6DXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edxAuOoB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-73972a54919so4516423b3a.3;
        Mon, 16 Jun 2025 21:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134784; x=1750739584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yfO0tEScEMml231bVy7VytbtLB5e8P7wQZMzjqYWpo=;
        b=edxAuOoBkBcHjnPF2PgmC6I2UluBfeX0RzhsPhY8uGBVwNsXHu+URdFuT/AjZ4/eW8
         zAVnnxFNfKAihc+RMtcEF/IDmiLL8SHEn3JlKH2md3EjUo0+uArvjvUsJXfXdMXG1FJc
         PT39TPKx5ZHMb2qU3ebMEc1GBEBBynHXSGvg84IwC0JUqfEob4F7zxdgWJvMyGCQZPcs
         I6nM1cxHEP8uILddEO1yMIEcPzwYKQ0ih9pTgppVwchdSkbxmtaVEs/7OmA4lBo4vSjs
         n7KLzCw6jF+CfcSm+t122heR+nD/Z/hyVMND+ZiG39F5rcWMIkSEQ1JgCQMnzF9nH0wQ
         1udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134784; x=1750739584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yfO0tEScEMml231bVy7VytbtLB5e8P7wQZMzjqYWpo=;
        b=M3hZCF2ZJ5z+lD9VVQWHFcHrFGQNAO6I4HJP8Qlf76XaZBA/CQyPny4DMEYHDOGPAD
         68yYqewELug59g13n467jIjKSjYw3TUQqUCGYyJqpW++avEAG1iEL8SU/B4PFA5E7aBy
         8CK6CjlJ05c5wrv7h2ZAHN3Tsx1jiHMcrxwJiJg47wg4cM6O4RqSshyN5fvV38uulPbp
         pAoZmoWYnBZ4/Und03uQVGkvPvgHAtLxxiu/YINGQ8Fge1ubaBcbusIJxmOXDCBgRdvj
         Ft6uCyBAkv7kgyy79W0ONNke44H0zbq1+t0sQWcPSKQqU/ZkD0CL+nHiNnpmdruhZfI/
         fYlA==
X-Forwarded-Encrypted: i=1; AJvYcCUl0M+D5fY+oASg3CqwUQcxdXmBVqkKReDDqiGuw6ffVDvkR9I5ScosRW9aUo0NnI3wG9X7rsu4jiE9XBI=@vger.kernel.org, AJvYcCVQLh38o2VYoLijV891/pz8LaBkIN+epNAapoDTahRC01mhIJvGLh9heq82VueuRRbAZ9Gs2bsmoyxUdNXtAMZn@vger.kernel.org, AJvYcCWwD3BJfRzPGNPvhJpzpHP6hgt8jL4HeUwQllhG28ik1rxvlV6ej3TniPYeUGjtZld2go44WFbs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+7VLFCccleB0P9WIkbEAF4AlbkL84GisN6U/z8Ixj5MPWrX+L
	COWFVe7TMJ6qNLH0+imHp+WKgV6qaHyJtngbj7kbwxzOh4lCooWVMCa+xcHGnIAO
X-Gm-Gg: ASbGncu7ReWvgLIR+DVHQxtPQ2jnxNt4unYDC5/1oDGIZImC5qrjkqX0H6rHHgp2142
	H/s2Y/HPH26mwro6xLLp5CW5X2G7i4PppJ2rmNeyWdolbUGWeKq0cwhjjGERCHeD2YUvGi7Ry2s
	hXz2xYLDWZCu/M1UkzyG1/9bQNYziEEUjcRX/Fl0bqQ973btHjtQeef7pIHIixVGjGy+KJyzVY/
	mFbXrgnF/jQICOL49WRRBXwjhWzBMirRhBM0sA87ODExq8Ck36syKt2r0YkBIdvxtLKDQwzZAoM
	RbKAWqdPmPjf7SDQlY8E6PSFB5du8reDbEV2FuFJE6nPwZmowT4cyFIQSR5lMuTxxtWMl/g=
X-Google-Smtp-Source: AGHT+IGrXfy7WRHc58IY+hIWfog8kDoAy+7YGN0M1ZowgVuks+5tCsIOan1BwV/kUQTDJBNE+wqE0g==
X-Received: by 2002:a05:6a00:3a04:b0:736:d297:164 with SMTP id d2e1a72fcca58-7489cf6aad9mr16631360b3a.1.1750134784343;
        Mon, 16 Jun 2025 21:33:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffee587sm8066407b3a.16.2025.06.16.21.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:33:03 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:56 -0700
Subject: [PATCH RFC net-next v4 07/11] vhost/vsock: add netns support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-7-bdd1659c33fb@meta.com>
References: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
In-Reply-To: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the ability to isolate vsock flows using namespaces.

The namespace for a VM is inherited from the PID that opened the
vhost-vsock device.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/vhost/vsock.c | 48 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 802153e23073..863419533a3f 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -46,6 +46,8 @@ static DEFINE_READ_MOSTLY_HASHTABLE(vhost_vsock_hash, 8);
 struct vhost_vsock {
 	struct vhost_dev dev;
 	struct vhost_virtqueue vqs[2];
+	struct net *net;
+	netns_tracker ns_tracker;
 
 	/* Link to global vhost_vsock_hash, writes use vhost_vsock_mutex */
 	struct hlist_node hash;
@@ -59,6 +61,22 @@ struct vhost_vsock {
 	bool seqpacket_allow;
 };
 
+static void vhost_vsock_net_set(struct vhost_vsock *vsock, struct net *net)
+{
+	if (net_eq(net, vsock_global_net()))
+		vsock->net = vsock_global_net();
+	else
+		vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
+}
+
+static void vhost_vsock_net_put(struct vhost_vsock *vsock)
+{
+	if (net_eq(vsock->net, vsock_global_net()))
+		return;
+
+	put_net_track(vsock->net, &vsock->ns_tracker);
+}
+
 static u32 vhost_transport_get_local_cid(void)
 {
 	return VHOST_VSOCK_DEFAULT_HOST_CID;
@@ -67,7 +85,7 @@ static u32 vhost_transport_get_local_cid(void)
 /* Callers that dereference the return value must hold vhost_vsock_mutex or the
  * RCU read lock.
  */
-static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
+static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
 {
 	struct vhost_vsock *vsock;
 
@@ -78,9 +96,8 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
 		if (other_cid == 0)
 			continue;
 
-		if (other_cid == guest_cid)
+		if (other_cid == guest_cid && vsock_net_check_mode(net, vsock->net))
 			return vsock;
-
 	}
 
 	return NULL;
@@ -272,13 +289,14 @@ static int
 vhost_transport_send_pkt(struct sk_buff *skb)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct net *net = virtio_vsock_skb_net(skb);
 	struct vhost_vsock *vsock;
 	int len = skb->len;
 
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid));
+	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid), net);
 	if (!vsock) {
 		rcu_read_unlock();
 		kfree_skb(skb);
@@ -305,7 +323,7 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
+	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk_vsock(vsk)));
 	if (!vsock)
 		goto out;
 
@@ -403,7 +421,7 @@ static bool vhost_transport_msgzerocopy_allow(void)
 	return true;
 }
 
-static bool vhost_transport_seqpacket_allow(u32 remote_cid);
+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
 
 static struct virtio_transport vhost_transport = {
 	.transport = {
@@ -459,13 +477,14 @@ static struct virtio_transport vhost_transport = {
 	.send_pkt = vhost_transport_send_pkt,
 };
 
-static bool vhost_transport_seqpacket_allow(u32 remote_cid)
+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
+	struct net *net = sock_net(sk_vsock(vsk));
 	struct vhost_vsock *vsock;
 	bool seqpacket_allow = false;
 
 	rcu_read_lock();
-	vsock = vhost_vsock_get(remote_cid);
+	vsock = vhost_vsock_get(remote_cid, net);
 
 	if (vsock)
 		seqpacket_allow = vsock->seqpacket_allow;
@@ -525,6 +544,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 			continue;
 		}
 
+		virtio_vsock_skb_set_net(skb, vsock->net);
 		total_len += sizeof(*hdr) + skb->len;
 
 		/* Deliver to monitoring devices all received packets */
@@ -651,10 +671,16 @@ static void vhost_vsock_free(struct vhost_vsock *vsock)
 
 static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 {
+
 	struct vhost_virtqueue **vqs;
 	struct vhost_vsock *vsock;
+	struct net *net;
 	int ret;
 
+	net = get_net_ns_by_pid(current->pid);
+	if (IS_ERR(net))
+		return PTR_ERR(net);
+
 	/* This struct is large and allocation could fail, fall back to vmalloc
 	 * if there is no other way.
 	 */
@@ -668,6 +694,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
+	vhost_vsock_net_set(vsock, net);
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 
@@ -707,7 +734,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	 */
 
 	/* If the peer is still valid, no need to reset connection */
-	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
+	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk)))
 		return;
 
 	/* If the close timeout is pending, let it expire.  This avoids races
@@ -752,6 +779,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
 
 	vhost_dev_cleanup(&vsock->dev);
+	vhost_vsock_net_put(vsock);
 	kfree(vsock->dev.vqs);
 	vhost_vsock_free(vsock);
 	return 0;
@@ -778,7 +806,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 
 	/* Refuse if CID is already in use */
 	mutex_lock(&vhost_vsock_mutex);
-	other = vhost_vsock_get(guest_cid);
+	other = vhost_vsock_get(guest_cid, vsock->net);
 	if (other && other != vsock) {
 		mutex_unlock(&vhost_vsock_mutex);
 		return -EADDRINUSE;

-- 
2.47.1


