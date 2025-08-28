Return-Path: <linux-kselftest+bounces-40127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E44DB38FF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 02:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DB4463E02
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289A622A808;
	Thu, 28 Aug 2025 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWfW5Rnx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAA721CA02;
	Thu, 28 Aug 2025 00:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341105; cv=none; b=NILtGbkCy9n5b2L0xRvWk9rgiISBf6WqZ1j8QzgDwZtnTYRKGPcMKeCGePTpRRGUQq36q/v2a+TheZWK1itUz4ZEMu/qLnx9pXK1XKPJLi4OaHjuaq8zwKy0SIFq/HaZ/9vgbzxsR6E5BXRD69KK4FUX80hyULnoIeBddWo8PjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341105; c=relaxed/simple;
	bh=1GJOYUbLkSVUFuavBj8tOYipR+NhigVATpZKUWUhpl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gECl6c4hOwc7P4E1AQsOZyza8+db3UBLk5Q2x0G/+QFlSznQoyKXj8pR41x9MreJvldrt+U9VjWP9inAHQmG8puScZo5yTO4EwwM1En2YMIkV+Yrfx0xC7bWPHlhvW2ybtDcJQd0KV+lQeavMQ1gFP2gzG74o+M+E3nLLdsP2Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWfW5Rnx; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b475dfb4f42so343513a12.0;
        Wed, 27 Aug 2025 17:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341103; x=1756945903; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=saysWBU4M7zZK6muNIPjMH0cBIXV8HIpOLa1ReuiyVc=;
        b=ZWfW5Rnx2hXoqvHUejKPcEyGRxay0H3jWRxEYqwWWelahI63PRtIxaILYpeRAEmBx4
         SN8hBW6U445ldyvVq1yHnIHqWfF0x33pKrrwiId5tZ5WrBpBTpG0Rf9V7IFBPDT0Tb2D
         b8MEOu/oKNVis69wTzrhUpgt9tABrjM5bUSOvCV1UbdVwHaUS+2TrPuryugZValX2Sti
         rAJwgqiKSZtxFwyU6V8TTXVIRLcgCVnDp7DerBtO44/2L/HAPcqgxZRaifOe/osGoI8H
         vtyhIxdwXV35GtWrzKt6i04ERJ/V2ur/l/oeQdXruR5+c/NnR+9y9c6YgSXETmRUNmO5
         lVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341103; x=1756945903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saysWBU4M7zZK6muNIPjMH0cBIXV8HIpOLa1ReuiyVc=;
        b=YLovJO72huaEZPmfjdom6DGjzrJZYNwm0I9xLHr+iewAX4N2cBy5tkjDo7G7yLpme0
         SwBJRRgOE+u5imox99ZB8mTn64mb3UPdWv+sHFbJNgLU9SwG4WRTwDStp7LBjZyVJipe
         p4vVPmsSqi3NlRSr4k5z2xseHZfGFz+54hOgfbEMOsp/kQNpJ7bIZYwJGZNyjb8CWl6M
         hODWkPXfmqDNYJoqj9QVKST5K/GwyKFYUxE3WdWd8JuAnY/okjkM0VgcSHCaUA6tYh2k
         c80bmViwywRshQ9pVwchqoYWbC5DUwZ2F+an/zVlmS48KbBOGZjCP+wzxXzTrcjY26Wl
         UjLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyYtG8tOYkq7WgA6a8S5L7xq5WS78QsssDevihUXNRwzbe2tIVYv6JQgryFnLBA+qP4r0=@vger.kernel.org, AJvYcCV6glG25x74WcZKZ/lcEefmj595v5AccQmibAzrlfAwbGswZaTz4OiR+AbQqhjBlkd04qV9wYu2@vger.kernel.org, AJvYcCVPbtdbeI6zJP9RkyO6c8c1nu39E5X0j9GlFKTlCJxwA65B/Q2T5TZzKRLxqznyzdUi3KadPDDsxAOXAJOGKenb@vger.kernel.org, AJvYcCVxpT1sm723z3WQiF2DDwFdvgtLjlMpX0NiacN2o3XJSO+TH0SkHJMJEzobW35tOD/Bn3O7HqYugLFlUsNm@vger.kernel.org, AJvYcCW/px9FUVYr6C1MI+HWTNe5q+08JYWArls6ZVe0FCODzR3oKJcjm09gj6TNqpFam2aaJm48CeP0KEX+f7lZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwGRjTIqqiBpmutK3GDmiCD6yPqGmwqchsgFUpbKaYdZJ2N+l9N
	qJQh0WmMEhvyHMvzr9AhYB9eknVZ3nKW6XePeaIpvp2uTe3rKFnpK06g
X-Gm-Gg: ASbGncsMFxzR7B1TWuyC9laYIwTJ+4+b4LvqnXHDF5rb5zEwTab1zNS3kBn0xiIEsIz
	U7jPlxX3YRxo3aQESeSYHYnohpdCccnDYta1bv/a3NdTzZ6CxZhqb4VNhdQpXthFvm/5SgLKE8m
	+Rqn2VXphSbbxPxBzyYJEI5ggkv2QJJOkHgSnaOGTxoq1hKL6BaudUX/NWhBUY4TP9NfJaEtW1l
	9U110miGvzkwRhQBMq6ICsWYB3JpEwOpZfJgi2o4tPbx9Ihiad9a/ckDRMiUhar3f7TIcEunr9v
	QPqOI+i5eNoq6dBhOe9En920Ej9IXOtfKXJywuIYqYqoyWPYxlSwI/tP6Rs9Sl2R3CUw3qLAVwL
	Pt6ZnH7yJOdudPeuG9iB5
X-Google-Smtp-Source: AGHT+IFKdbFnw9poUFr+kYVT0cwCfnfmVv/oxnRCgfFdvBFZZP6G4plqa6FPpGcS35Ongi0a99gCnA==
X-Received: by 2002:a17:90b:2ccf:b0:321:4765:a423 with SMTP id 98e67ed59e1d1-32515eadd16mr26985871a91.6.1756341102437;
        Wed, 27 Aug 2025 17:31:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327aafa8e3bsm485779a91.0.2025.08.27.17.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 17:31:41 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 27 Aug 2025 17:31:34 -0700
Subject: [PATCH net-next v5 6/9] vhost/vsock: add netns support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-vsock-vmtest-v5-6-0ba580bede5b@meta.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
In-Reply-To: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the ability to isolate vsock flows using namespaces.

The VM, via the vhost_vsock struct, inherits its namespace from the
process that opens the vhost-vsock device. vhost_vsock lookup functions
are modified to take into account the mode (e.g., if CIDs are matching
but modes don't align, then return NULL).

vhost_vsock now acquires a reference to the namespace.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v5:
- respect pid namespaces when assigning namespace to vhost_vsock
---
 drivers/vhost/vsock.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 34adf0cf9124..f7405bb27aab 100644
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
@@ -67,7 +69,7 @@ static u32 vhost_transport_get_local_cid(void)
 /* Callers that dereference the return value must hold vhost_vsock_mutex or the
  * RCU read lock.
  */
-static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
+static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
 {
 	struct vhost_vsock *vsock;
 
@@ -78,9 +80,8 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
 		if (other_cid == 0)
 			continue;
 
-		if (other_cid == guest_cid)
+		if (other_cid == guest_cid && vsock_net_check_mode(net, vsock->net))
 			return vsock;
-
 	}
 
 	return NULL;
@@ -272,13 +273,14 @@ static int
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
@@ -305,7 +307,7 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
+	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk_vsock(vsk)));
 	if (!vsock)
 		goto out;
 
@@ -462,11 +464,12 @@ static struct virtio_transport vhost_transport = {
 
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
+	struct net *net = sock_net(sk_vsock(vsk));
 	struct vhost_vsock *vsock;
 	bool seqpacket_allow = false;
 
 	rcu_read_lock();
-	vsock = vhost_vsock_get(remote_cid);
+	vsock = vhost_vsock_get(remote_cid, net);
 
 	if (vsock)
 		seqpacket_allow = vsock->seqpacket_allow;
@@ -526,6 +529,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 			continue;
 		}
 
+		virtio_vsock_skb_set_net(skb, vsock->net);
 		total_len += sizeof(*hdr) + skb->len;
 
 		/* Deliver to monitoring devices all received packets */
@@ -652,10 +656,14 @@ static void vhost_vsock_free(struct vhost_vsock *vsock)
 
 static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 {
+
 	struct vhost_virtqueue **vqs;
 	struct vhost_vsock *vsock;
+	struct net *net;
 	int ret;
 
+	net = current->nsproxy->net_ns;
+
 	/* This struct is large and allocation could fail, fall back to vmalloc
 	 * if there is no other way.
 	 */
@@ -669,6 +677,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
+	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 
@@ -708,7 +717,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	 */
 
 	/* If the peer is still valid, no need to reset connection */
-	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
+	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk)))
 		return;
 
 	/* If the close timeout is pending, let it expire.  This avoids races
@@ -753,6 +762,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
 
 	vhost_dev_cleanup(&vsock->dev);
+	put_net_track(vsock->net, &vsock->ns_tracker);
 	kfree(vsock->dev.vqs);
 	vhost_vsock_free(vsock);
 	return 0;
@@ -779,7 +789,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 
 	/* Refuse if CID is already in use */
 	mutex_lock(&vhost_vsock_mutex);
-	other = vhost_vsock_get(guest_cid);
+	other = vhost_vsock_get(guest_cid, vsock->net);
 	if (other && other != vsock) {
 		mutex_unlock(&vhost_vsock_mutex);
 		return -EADDRINUSE;

-- 
2.47.3


