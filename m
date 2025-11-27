Return-Path: <linux-kselftest+bounces-46610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D56BC8D32B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 08:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0015E4E2973
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9211D325736;
	Thu, 27 Nov 2025 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8dmhVe9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A36B31986D
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229673; cv=none; b=ZKXbA1KaEXMmeACjppSWE/YaBtzKiQFGBfaCT/jhm+d9oDqvKxHc87n1C400Z+DvYnRUip61UNDTUxhqX4ZW5hv+KQmw5Kow+eQeJXe/rm7q3PM7PLymb2oUJf38/qlPdg259aZYC7/YueDtNoBhLTk5IQ0zAdkKB/qwa3fDST8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229673; c=relaxed/simple;
	bh=FIt2oxmgoQb57azIqfEcz6F2qrbhumVCF150+ACSdDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=se+TgY4DMXPY26GRkWauyEuEjzWb+hWF5Y6ubnWcLr+VrMsy4966wT1y1qP2BxDmFyBtaznbHs64kyI2+rnkU4QTs89kZW5cnpzGNJkEQ69vH3naus5nlGdGS1dBTDNbw3FQxCO4B8MYxnqykIdDjpPW+uLDA7aTEkrBrHRXmVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8dmhVe9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297d4a56f97so8824185ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229667; x=1764834467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjmfflkrIQyOb2uIHthf9fdUT5FnOR2WdSUpkaHf4Lw=;
        b=S8dmhVe96YK9XVNIMydo3RnR8Gt4u4efKEsLV51fGmwQEAdIM//boFV1H8/LsVrACm
         4Ejc+aTDiJsZxtJffDMZePlP/AeBdrjLhldUUQF3er8RkAsFInEFp6vEjANkHf/lSYCC
         IKPjciCzw+yRqYWPceysDaYK3rbEnp/96oMhfEjlwbhwxDzfdgX+DAzpo+lvXu4MVWQB
         8lgcxQBnJds2WtaDaqI0NWACEGr0PvpG5Z4K8tIWpgFwzX2PN4nkl58DFYYsfazjtp1L
         +UQ0JT+aBZ5pVmd3uXcEdtpL98BoCp36pTx+rqrX4hfsODcEVbfbBlZcYY1Fkv6vLxcn
         D5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229667; x=1764834467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tjmfflkrIQyOb2uIHthf9fdUT5FnOR2WdSUpkaHf4Lw=;
        b=MBxmQHWmozLT7tTBy9uKngPdT+gdPuNevQYF+e95sthWaAL+gbulPV6bAJwF6TWgoN
         M/pQMVATPn92VSVqnDq2FvZM6m+VxqfJPZnOzbRUCPlntjcOatS6Z9sLgZtL+0s/9ecU
         U+Rr/+R8iQXDVXbSR0lz30ktzPQ6xaZ5LWqW3CWStuWnqvo6wt/J9eb0Y9SY8Hy9e5GS
         uJodpJIAyfriU5MYrhk534Uiu8IPGpNwa8HYgdoPt9YyBb3PEHXHUPMj9OIVWYqAczMi
         5OEHXty995sBGk+fHabxTQtGFWBwDeOFLxmMPUaIj89y3du1Mvrful7lE7lnK33Zd4I7
         PM8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6q06LINHtJiVCFNh1rQm7kYV3gZdhmqc1grT0GBG3IlvxWUSZX3HVTgydhXXHaBQQ07M8K2Up8Hiu8rDb2kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/w8dhFwLyXdIQ3CBSaGCZ7rAsCh0NXotRKXXADUiMRpYMZJh
	Q1rj9PIZiJc4d/0mlr4RaSn4CuQC/gIl6PbNyDQL+KKM1TCusUN095Kp
X-Gm-Gg: ASbGncsFOMYNVmXryZXYq3+W8j3y86+RxQ357Eoxg9Mpzm77Vv9B5hG391c870xaaY7
	8UpHiP9S5VGwJdIRkPW3Yp2usr4RlNb40/02ReeyzebD4GJNEZHwiW/bNSxo5BYKVIq05/oI1Le
	AzF3tcSDueK0qe5yN2JHsTjmnxmbiUPnWPBDtGDlqPup6MN+1g65Qpo/KEP9KivZ5n6X59MD91P
	e9XaHGQHz4M2JdfHT4CHw5ynxLl8vBPpWENNgjeRDHdaw5Ivu0j53fEwDrKork5ru3itRDRQ7hs
	91IlBX7OVjIG9i3qaszu6i8LSZ9jW0jWTnZqDv02a4WazX3COwlF4yTmO3ZI6X66ryg55VLFVJ+
	DzjWOH80sKu955T/BtQdv/cNSJfdxs1aPZaesoxCl5+OdukoImVZZPadT2sSvpx8VWVnsTZ62vS
	wVMtdoEk7ZiIGinQ+vyVI=
X-Google-Smtp-Source: AGHT+IGzIj0RBcOTfa1PNXG+NMokMcuP8zx8upgTsaJ9DjkuXxVomM1coxobYxop1zZyF5DYgmD1nw==
X-Received: by 2002:a17:903:1b30:b0:295:4936:d1e9 with SMTP id d9443c01a7336-29b6c574f5fmr244227805ad.36.1764229666887;
        Wed, 26 Nov 2025 23:47:46 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb5442csm8175885ad.85.2025.11.26.23.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:47:46 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 26 Nov 2025 23:47:33 -0800
Subject: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
In-Reply-To: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
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
 Shuah Khan <shuah@kernel.org>
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
come online.  Hence, vhost_transport_supports_local_mode() is switched
to return true.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
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
 drivers/vhost/vsock.c                   | 56 +++++++++++++++++++++--------
 include/linux/virtio_vsock.h            |  8 +++--
 net/vmw_vsock/virtio_transport.c        | 10 ++++--
 net/vmw_vsock/virtio_transport_common.c | 63 ++++++++++++++++++++++++---------
 net/vmw_vsock/vsock_loopback.c          | 19 +++++++---
 5 files changed, 118 insertions(+), 38 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 83937e1d63fa..82cb9ec09e78 100644
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
 
@@ -78,9 +84,10 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
 		if (other_cid == 0)
 			continue;
 
-		if (other_cid == guest_cid)
+		if (other_cid == guest_cid &&
+		    vsock_net_check_mode(net, mode, vsock->net,
+					 vsock->net_mode))
 			return vsock;
-
 	}
 
 	return NULL;
@@ -269,7 +276,8 @@ static void vhost_transport_send_pkt_work(struct vhost_work *work)
 }
 
 static int
-vhost_transport_send_pkt(struct sk_buff *skb)
+vhost_transport_send_pkt(struct sk_buff *skb, struct net *net,
+			 enum vsock_net_mode net_mode)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vhost_vsock *vsock;
@@ -278,7 +286,7 @@ vhost_transport_send_pkt(struct sk_buff *skb)
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid));
+	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid), net, net_mode);
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
 
@@ -407,6 +416,12 @@ static bool vhost_transport_msgzerocopy_allow(void)
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
@@ -431,7 +446,7 @@ static struct virtio_transport vhost_transport = {
 		.stream_has_space         = virtio_transport_stream_has_space,
 		.stream_rcvhiwat          = virtio_transport_stream_rcvhiwat,
 		.stream_is_active         = virtio_transport_stream_is_active,
-		.stream_allow             = virtio_transport_stream_allow,
+		.stream_allow             = vhost_transport_stream_allow,
 
 		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
 		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
@@ -464,14 +479,12 @@ static struct virtio_transport vhost_transport = {
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 					    u32 remote_cid)
 {
+	struct net *net = sock_net(sk_vsock(vsk));
 	struct vhost_vsock *vsock;
 	bool seqpacket_allow = false;
 
-	if (vsk->net_mode != VSOCK_NET_MODE_GLOBAL)
-		return false;
-
 	rcu_read_lock();
-	vsock = vhost_vsock_get(remote_cid);
+	vsock = vhost_vsock_get(remote_cid, net, vsk->net_mode);
 
 	if (vsock)
 		seqpacket_allow = vsock->seqpacket_allow;
@@ -542,7 +555,8 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
 		    le64_to_cpu(hdr->dst_cid) ==
 		    vhost_transport_get_local_cid())
-			virtio_transport_recv_pkt(&vhost_transport, skb);
+			virtio_transport_recv_pkt(&vhost_transport, skb,
+						  vsock->net, vsock->net_mode);
 		else
 			kfree_skb(skb);
 
@@ -659,6 +673,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 {
 	struct vhost_virtqueue **vqs;
 	struct vhost_vsock *vsock;
+	struct net *net;
 	int ret;
 
 	/* This struct is large and allocation could fail, fall back to vmalloc
@@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
+	net = current->nsproxy->net_ns;
+	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
+
+	/* Store the mode of the namespace at the time of creation. If this
+	 * namespace later changes from "global" to "local", we want this vsock
+	 * to continue operating normally and not suddenly break. For that
+	 * reason, we save the mode here and later use it when performing
+	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
+	 */
+	vsock->net_mode = vsock_net_mode(net);
+
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 
@@ -713,7 +739,8 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	 */
 
 	/* If the peer is still valid, no need to reset connection */
-	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
+	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk),
+			    vsk->net_mode))
 		return;
 
 	/* If the close timeout is pending, let it expire.  This avoids races
@@ -758,6 +785,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
 
 	vhost_dev_cleanup(&vsock->dev);
+	put_net_track(vsock->net, &vsock->ns_tracker);
 	kfree(vsock->dev.vqs);
 	vhost_vsock_free(vsock);
 	return 0;
@@ -784,7 +812,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 
 	/* Refuse if CID is already in use */
 	mutex_lock(&vhost_vsock_mutex);
-	other = vhost_vsock_get(guest_cid);
+	other = vhost_vsock_get(guest_cid, vsock->net, vsock->net_mode);
 	if (other && other != vsock) {
 		mutex_unlock(&vhost_vsock_mutex);
 		return -EADDRINUSE;
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 1845e8d4f78d..7ea264dcfff7 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -173,6 +173,8 @@ struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
+	struct net *net;
+	enum vsock_net_mode net_mode;
 	u32 pkt_len;
 	u16 type;
 	u16 op;
@@ -185,7 +187,8 @@ struct virtio_transport {
 	struct vsock_transport transport;
 
 	/* Takes ownership of the packet */
-	int (*send_pkt)(struct sk_buff *skb);
+	int (*send_pkt)(struct sk_buff *skb, struct net *net,
+			enum vsock_net_mode net_mode);
 
 	/* Used in MSG_ZEROCOPY mode. Checks, that provided data
 	 * (number of buffers) could be transmitted with zerocopy
@@ -280,7 +283,8 @@ virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
 void virtio_transport_destruct(struct vsock_sock *vsk);
 
 void virtio_transport_recv_pkt(struct virtio_transport *t,
-			       struct sk_buff *skb);
+			       struct sk_buff *skb, struct net *net,
+			       enum vsock_net_mode net_mode);
 void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
 void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f5123810192d..3ff695740108 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -231,7 +231,8 @@ static int virtio_transport_send_skb_fast_path(struct virtio_vsock *vsock, struc
 }
 
 static int
-virtio_transport_send_pkt(struct sk_buff *skb)
+virtio_transport_send_pkt(struct sk_buff *skb, struct net *net,
+			  enum vsock_net_mode net_mode)
 {
 	struct virtio_vsock_hdr *hdr;
 	struct virtio_vsock *vsock;
@@ -665,7 +666,12 @@ static void virtio_transport_rx_work(struct work_struct *work)
 				virtio_vsock_skb_put(skb, payload_len);
 
 			virtio_transport_deliver_tap_pkt(skb);
-			virtio_transport_recv_pkt(&virtio_transport, skb);
+
+			/* Force virtio-transport into global mode since it
+			 * does not yet support local-mode namespacing.
+			 */
+			virtio_transport_recv_pkt(&virtio_transport, skb,
+						  NULL, VSOCK_NET_MODE_GLOBAL);
 		}
 	} while (!virtqueue_enable_cb(vq));
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index de71e2b3f77e..a818152d8b79 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -413,7 +413,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 
 		virtio_transport_inc_tx_pkt(vvs, skb);
 
-		ret = t_ops->send_pkt(skb);
+		ret = t_ops->send_pkt(skb, info->net, info->net_mode);
 		if (ret < 0)
 			break;
 
@@ -527,6 +527,8 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
+		.net_mode = vsk->net_mode,
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1067,6 +1069,8 @@ int virtio_transport_connect(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_REQUEST,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
+		.net_mode = vsk->net_mode,
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1082,6 +1086,8 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 			 (mode & SEND_SHUTDOWN ?
 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
+		.net_mode = vsk->net_mode,
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1108,6 +1114,8 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 		.msg = msg,
 		.pkt_len = len,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
+		.net_mode = vsk->net_mode,
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1145,6 +1153,8 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.reply = !!skb,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
+		.net_mode = vsk->net_mode,
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
@@ -1156,9 +1166,14 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 
 /* Normally packets are associated with a socket.  There may be no socket if an
  * attempt was made to connect to a socket that does not exist.
+ *
+ * net and net_mode refer to the namespace of whoever sent the invalid message.
+ * For loopback, this is the namespace of the socket. For vhost, this is the
+ * namespace of the VM (i.e., vhost_vsock).
  */
 static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
-					  struct sk_buff *skb)
+					  struct sk_buff *skb, struct net *net,
+					  enum vsock_net_mode net_mode)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct virtio_vsock_pkt_info info = {
@@ -1171,6 +1186,13 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		 * sock_net(sk) until the reply skb is freed.
 		 */
 		.vsk = vsock_sk(skb->sk),
+
+		/* net or net_mode are not defined here because we pass
+		 * net and net_mode directly to t->send_pkt(), instead of
+		 * relying on virtio_transport_send_pkt_info() to pass them to
+		 * t->send_pkt(). They are not needed by
+		 * virtio_transport_alloc_skb().
+		 */
 	};
 	struct sk_buff *reply;
 
@@ -1189,7 +1211,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 	if (!reply)
 		return -ENOMEM;
 
-	return t->send_pkt(reply);
+	return t->send_pkt(reply, net, net_mode);
 }
 
 /* This function should be called with sk_lock held and SOCK_DONE set */
@@ -1471,6 +1493,8 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 		.remote_port = le32_to_cpu(hdr->src_port),
 		.reply = true,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
+		.net_mode = vsk->net_mode,
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1513,12 +1537,14 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	int ret;
 
 	if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_REQUEST) {
-		virtio_transport_reset_no_sock(t, skb);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk),
+					       vsk->net_mode);
 		return -EINVAL;
 	}
 
 	if (sk_acceptq_is_full(sk)) {
-		virtio_transport_reset_no_sock(t, skb);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk),
+					       vsk->net_mode);
 		return -ENOMEM;
 	}
 
@@ -1526,13 +1552,15 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	 * Subsequent enqueues would lead to a memory leak.
 	 */
 	if (sk->sk_shutdown == SHUTDOWN_MASK) {
-		virtio_transport_reset_no_sock(t, skb);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk),
+					       vsk->net_mode);
 		return -ESHUTDOWN;
 	}
 
 	child = vsock_create_connected(sk);
 	if (!child) {
-		virtio_transport_reset_no_sock(t, skb);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk),
+					       vsk->net_mode);
 		return -ENOMEM;
 	}
 
@@ -1554,7 +1582,8 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	 */
 	if (ret || vchild->transport != &t->transport) {
 		release_sock(child);
-		virtio_transport_reset_no_sock(t, skb);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk),
+					       vsk->net_mode);
 		sock_put(child);
 		return ret;
 	}
@@ -1582,7 +1611,8 @@ static bool virtio_transport_valid_type(u16 type)
  * lock.
  */
 void virtio_transport_recv_pkt(struct virtio_transport *t,
-			       struct sk_buff *skb)
+			       struct sk_buff *skb, struct net *net,
+			       enum vsock_net_mode net_mode)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct sockaddr_vm src, dst;
@@ -1605,24 +1635,25 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 					le32_to_cpu(hdr->fwd_cnt));
 
 	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
-		(void)virtio_transport_reset_no_sock(t, skb);
+		(void)virtio_transport_reset_no_sock(t, skb, net, net_mode);
 		goto free_pkt;
 	}
 
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket(&src, &dst);
+	sk = vsock_find_connected_socket_net(&src, &dst, net, net_mode);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst);
+		sk = vsock_find_bound_socket_net(&dst, net, net_mode);
 		if (!sk) {
-			(void)virtio_transport_reset_no_sock(t, skb);
+			(void)virtio_transport_reset_no_sock(t, skb, net,
+							     net_mode);
 			goto free_pkt;
 		}
 	}
 
 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
-		(void)virtio_transport_reset_no_sock(t, skb);
+		(void)virtio_transport_reset_no_sock(t, skb, net, net_mode);
 		sock_put(sk);
 		goto free_pkt;
 	}
@@ -1641,7 +1672,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
 	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
-		(void)virtio_transport_reset_no_sock(t, skb);
+		(void)virtio_transport_reset_no_sock(t, skb, net, net_mode);
 		release_sock(sk);
 		sock_put(sk);
 		goto free_pkt;
@@ -1673,7 +1704,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		kfree_skb(skb);
 		break;
 	default:
-		(void)virtio_transport_reset_no_sock(t, skb);
+		(void)virtio_transport_reset_no_sock(t, skb, net, net_mode);
 		kfree_skb(skb);
 		break;
 	}
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index afad27cf533a..aef44d1631c3 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -26,7 +26,8 @@ static u32 vsock_loopback_get_local_cid(void)
 	return VMADDR_CID_LOCAL;
 }
 
-static int vsock_loopback_send_pkt(struct sk_buff *skb)
+static int vsock_loopback_send_pkt(struct sk_buff *skb, struct net *net,
+				   enum vsock_net_mode net_mode)
 {
 	struct vsock_loopback *vsock = &the_vsock_loopback;
 	int len = skb->len;
@@ -48,6 +49,13 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
 
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
@@ -77,7 +85,7 @@ static struct virtio_transport loopback_transport = {
 		.stream_has_space         = virtio_transport_stream_has_space,
 		.stream_rcvhiwat          = virtio_transport_stream_rcvhiwat,
 		.stream_is_active         = virtio_transport_stream_is_active,
-		.stream_allow             = virtio_transport_stream_allow,
+		.stream_allow             = vsock_loopback_stream_allow,
 
 		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
 		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
@@ -110,7 +118,7 @@ static struct virtio_transport loopback_transport = {
 static bool
 vsock_loopback_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
-	return vsk->net_mode == VSOCK_NET_MODE_GLOBAL;
+	return true;
 }
 
 static void vsock_loopback_work(struct work_struct *work)
@@ -132,7 +140,10 @@ static void vsock_loopback_work(struct work_struct *work)
 		 */
 		virtio_transport_consume_skb_sent(skb, false);
 		virtio_transport_deliver_tap_pkt(skb);
-		virtio_transport_recv_pkt(&loopback_transport, skb);
+
+		virtio_transport_recv_pkt(&loopback_transport, skb,
+					  sock_net(skb->sk),
+					  vsock_sk(skb->sk)->net_mode);
 	}
 }
 

-- 
2.47.3


