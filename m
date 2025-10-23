Return-Path: <linux-kselftest+bounces-43951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F04C02F3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EAE3B1463
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B696934C994;
	Thu, 23 Oct 2025 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfjEVeHs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B29734C14D
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244097; cv=none; b=rh7EawbFG6GXcT5oTwbWvEuZM0v0/b73M9qB8yz1DGsz+YJeIOjuDfr3iUEdQh6QLz30+zDfY8IEC1aMK8mcb0zbqwAr4DRoBC8EmrzxcafzDvfvomKEv9Q76Q6uZPO9erz0PilHlakjXtSEPfOdiOC5X/ZVlEVviteXum7m1Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244097; c=relaxed/simple;
	bh=LTNf3zO088KcCuJY5DwlnqiVNrOCKFiVyhJKNJE5MP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lwdDF34k5poVoCCG8OJNr8gpZOF9hGMeTJ3ugcqkaIIaEQm56sI3LSEjYAsaJBeSy64zOQMxei0rldYqJt1XkhS8HAB+D4jJjPBNJLahZoeAuSzTn32ZJMxsLzAs4PLfQGlB9ZeBBQnBq/euUU3FwqDr+z05QHfCO3qW/bKVTGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfjEVeHs; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7811a02316bso892223b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244091; x=1761848891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oi6EltuDjrHL40/sPKeBo5GOQD3+wZV32ZLMdcfyakU=;
        b=YfjEVeHsuZ65u2Sj5Fvwglv32W6Wkez8ZScPWTnJGHSdW3WjwEFwjcWhj6dyoVOtnm
         dpajQATX7DRUa1fTp+iMZQ8mqTMcvSgCZDfrFNnmeoxDMNF1B73MOK9bCGtbxLaAnMMp
         04kFDK4DiY1/eCdmtA7iuIKp4SaqZXWlLx33MIFZO5Nc/FKIG3DWsbPFsn+b3k82tdLJ
         YHmXazaQp4/B46x5GHvLr56OQ8PWE9jKYfi8Xp5QCEKcziLvzUyvTIonySFyWqi3kJds
         MCXN/J5sOU7tOe8dnpo38wKyPhbddk8CbZqnj/veTd1NH5O14HusArY4ovnf9Baw0soX
         qrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244091; x=1761848891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oi6EltuDjrHL40/sPKeBo5GOQD3+wZV32ZLMdcfyakU=;
        b=b3AdR2PKUJnTAodSQvhv9LgEFvuZqFxtOwip9qkChbqGxSdhAIKAjWbYH+whlONWa3
         1OU0uyDRdBAYF/4dnXOPjmqrLcy6kthsw6vz/65WFrw5wB8zVzl7qvrEU57dEDIecIDW
         SfNQnIs7fSv+o/dLlhXlofV3Fr3BKZELJKI6Ri2Zr4rKHO3miBU6r0wBKTFw0fNaNdHq
         QqouLJlw2i9IzlspBPMgkmdvxJMgG6kFHShXabMEsSrwp1cQGJ4/U9Kwt39/yN0com24
         80o5LTj92PAhaBAYRIEKwvu6QZnkHqDkOCf98+KbQc/kgO4sMAjKSLA8AsTv3BcPhnm9
         Q1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUL7dnYVmV8dUl2kM9vu8lbKpQufq9lfGDMRJTNP30bSqX66srUpnegUJqf35KA55iztl/CboWIrOvoud30PR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxtLd5UCs4tA9GtfQPxYPnCF/i+fKN3DSFJTcZ72ZBGU8Z7jCC
	f9GYzxuVEi+71w+6sp1rmSZ4KFwATRVySbUAmyr7KuMk9J0HvIWGa3zx
X-Gm-Gg: ASbGncuNxy5Fj2jga6Mw8PXsaIC15QYM+G762865dbbFzq6Yn1Wwli70QtGijHajG2U
	rqJi2ySHwvvWgdR/I3D2IIzPozmb0mxSTPa8WKLL0q/ErKLs2CihWcXHTXSr4NLYimhHfLud5nZ
	zWowC8v5RreMdVAf0jyyjat0RWkE4dASusgdMF+CerS/MNPWRAb4zWBEp6KweAm15afVIduT4U1
	2C7qVkp1HFQoJPhNg8tg7dO6UwRlrEN+7w1H4rIYPbHILNC+pyKukHgFudVAaBaOp1LZFqjlB4s
	W48lBquHyfn0Rrw+aWspKKtbBZSn905cIJIqjK9wycAWczm8D5amS6+zRIgIJtgoOXEE3x9J0f7
	kIXCrux38DhyuMwH9nyJvEgsBVGbnGi5lm1l7Dv1rPzVu90P9XHl/+2DFV9ujfVMn1z5t/p9aii
	3VtW/QKyp7n+74AlkIzQ==
X-Google-Smtp-Source: AGHT+IEELjFHyyABUDK0LWZlqB6sz5BNRvODMd0egUzV54kNQXVCm7c3MiRl9+V7BDlFPN8LAFPFTg==
X-Received: by 2002:a17:902:e88e:b0:25c:76f1:b024 with SMTP id d9443c01a7336-290c9ceeadcmr331021865ad.25.1761244090770;
        Thu, 23 Oct 2025 11:28:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223e3154sm6489960a91.9.2025.10.23.11.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:10 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:46 -0700
Subject: [PATCH net-next v8 07/14] vhost/vsock: add netns support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-7-dea984d02bb0@meta.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
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
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the ability to isolate vhost-vsock flows using namespaces.

The VM, via the vhost_vsock struct, inherits its namespace from the
process that opens the vhost-vsock device. vhost_vsock lookup functions
are modified to take into account the mode (e.g., if CIDs are matching
but modes don't align, then return NULL).

vhost_vsock now acquires a reference to the namespace.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v7:
- remove the check_global flag of vhost_vsock_get(), that logic was both
  wrong and not necessary, reuse vsock_net_check_mode() instead
- remove 'delete me' comment
Changes in v5:
- respect pid namespaces when assigning namespace to vhost_vsock
---
 drivers/vhost/vsock.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 34adf0cf9124..df6136633cd8 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -46,6 +46,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(vhost_vsock_hash, 8);
 struct vhost_vsock {
 	struct vhost_dev dev;
 	struct vhost_virtqueue vqs[2];
+	struct net *net;
+	netns_tracker ns_tracker;
+
+	/* The ns mode at the time vhost_vsock was created */
+	enum vsock_net_mode net_mode;
 
 	/* Link to global vhost_vsock_hash, writes use vhost_vsock_mutex */
 	struct hlist_node hash;
@@ -67,7 +72,8 @@ static u32 vhost_transport_get_local_cid(void)
 /* Callers that dereference the return value must hold vhost_vsock_mutex or the
  * RCU read lock.
  */
-static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
+static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net,
+					   enum vsock_net_mode mode)
 {
 	struct vhost_vsock *vsock;
 
@@ -78,9 +84,9 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
 		if (other_cid == 0)
 			continue;
 
-		if (other_cid == guest_cid)
+		if (other_cid == guest_cid &&
+		    vsock_net_check_mode(net, mode, vsock->net, vsock->net_mode))
 			return vsock;
-
 	}
 
 	return NULL;
@@ -271,14 +277,16 @@ static void vhost_transport_send_pkt_work(struct vhost_work *work)
 static int
 vhost_transport_send_pkt(struct sk_buff *skb)
 {
+	enum vsock_net_mode mode = virtio_vsock_skb_net_mode(skb);
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct net *net = virtio_vsock_skb_net(skb);
 	struct vhost_vsock *vsock;
 	int len = skb->len;
 
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid));
+	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid), net, mode);
 	if (!vsock) {
 		rcu_read_unlock();
 		kfree_skb(skb);
@@ -305,7 +313,8 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
+	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid,
+				sock_net(sk_vsock(vsk)), vsk->net_mode);
 	if (!vsock)
 		goto out;
 
@@ -327,7 +336,7 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 }
 
 static struct sk_buff *
-vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
+vhost_vsock_alloc_skb(struct vhost_vsock *vsock, struct vhost_virtqueue *vq,
 		      unsigned int out, unsigned int in)
 {
 	struct virtio_vsock_hdr *hdr;
@@ -353,6 +362,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 	if (!skb)
 		return NULL;
 
+	virtio_vsock_skb_set_net(skb, vsock->net);
+	virtio_vsock_skb_set_net_mode(skb, vsock->net_mode);
+
 	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
 
 	hdr = virtio_vsock_hdr(skb);
@@ -462,11 +474,12 @@ static struct virtio_transport vhost_transport = {
 
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
+	struct net *net = sock_net(sk_vsock(vsk));
 	struct vhost_vsock *vsock;
 	bool seqpacket_allow = false;
 
 	rcu_read_lock();
-	vsock = vhost_vsock_get(remote_cid);
+	vsock = vhost_vsock_get(remote_cid, net, vsk->net_mode);
 
 	if (vsock)
 		seqpacket_allow = vsock->seqpacket_allow;
@@ -520,7 +533,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 			break;
 		}
 
-		skb = vhost_vsock_alloc_skb(vq, out, in);
+		skb = vhost_vsock_alloc_skb(vsock, vq, out, in);
 		if (!skb) {
 			vq_err(vq, "Faulted on pkt\n");
 			continue;
@@ -652,8 +665,10 @@ static void vhost_vsock_free(struct vhost_vsock *vsock)
 
 static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 {
+
 	struct vhost_virtqueue **vqs;
 	struct vhost_vsock *vsock;
+	struct net *net;
 	int ret;
 
 	/* This struct is large and allocation could fail, fall back to vmalloc
@@ -669,6 +684,14 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
+	net = current->nsproxy->net_ns;
+	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
+
+	/* Cache the mode of the namespace so that if that netns mode changes,
+	 * the vhost_vsock will continue to function as expected.
+	 */
+	vsock->net_mode = vsock_net_mode(net);
+
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 
@@ -708,7 +731,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	 */
 
 	/* If the peer is still valid, no need to reset connection */
-	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
+	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk), vsk->net_mode))
 		return;
 
 	/* If the close timeout is pending, let it expire.  This avoids races
@@ -753,6 +776,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
 
 	vhost_dev_cleanup(&vsock->dev);
+	put_net_track(vsock->net, &vsock->ns_tracker);
 	kfree(vsock->dev.vqs);
 	vhost_vsock_free(vsock);
 	return 0;
@@ -779,7 +803,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 
 	/* Refuse if CID is already in use */
 	mutex_lock(&vhost_vsock_mutex);
-	other = vhost_vsock_get(guest_cid);
+	other = vhost_vsock_get(guest_cid, vsock->net, vsock->net_mode);
 	if (other && other != vsock) {
 		mutex_unlock(&vhost_vsock_mutex);
 		return -EADDRINUSE;

-- 
2.47.3


