Return-Path: <linux-kselftest+bounces-47948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E70CDB277
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 03:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 674D23005F24
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 02:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC0E23817F;
	Wed, 24 Dec 2025 02:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTQj1gfP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56946247291
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Dec 2025 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766542781; cv=none; b=FqppLevuUIjxBt5y58pRAPZzUQ/lR6WgyAlzeXzSSv2T6AmKlT3w5Hpa/UI4phNfIkrkbyBskWvmCIzOvouJkSvg2SDhnahh4WpCNjUuDIyfPMEd4cqiUeSaFh6hdwrIS1PY3d9JrsW22LGzDZLFonIOeuJV61jEAlCrOndaJHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766542781; c=relaxed/simple;
	bh=3FrsW13cAwNUAm/r/nnmzxJwetGMwGrLhrXxpzISERQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o8rDYqDtzM28ot8tBbNXy0YW+KWqojzjqPy91rqyDzufAdc3McUq1YbntAWUitjISy3Bh40VBMS/HpfvvIENgMiPgAwbl+NJK4qbTL17edsZARTo+5orS/oYvY7eIhnFMmhc2vld5uB3eA3uKmY2qvudWKEdQEbQcGDSXd1nr8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTQj1gfP; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b2627269d5so598142985a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 18:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766542777; x=1767147577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSxW9WZjj15PPjFoTta3+E19Ydm0LprZYJxAd920uos=;
        b=jTQj1gfPnALqlRivP5jJ6qtYQHcGDrjkhZyKNo+GuY+D0k2PC/XzmfRuKR3te141lV
         nXf+Lrlx8mfaoBsTy4QDeDpTxUZUGJKjpjdaeHKF5krNSKqgqah3CLwySksdbATo6XYU
         iMfEoKpANhWCWnyupgiYrEsUisXB7IpyuajVeidc+fIiwgzwngdVSKWUxVfXt+5Bo1YK
         pzBVAhtvpFbICgfPATin2RyhOOPjlimDUGIR+DB85CyY40tdAjSObnd+Jh0gLwbbnuCj
         lQz3sYE1/XUvjaHpHXDx3//AQDiBACQAiZ159OH1iGUyvKuuqR78sq5mRygJLXqbHHmw
         bO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766542777; x=1767147577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fSxW9WZjj15PPjFoTta3+E19Ydm0LprZYJxAd920uos=;
        b=iPvso1dXALNzzLx58WH7MP4ASQQ5v8ZH9BwBDAVJqQ4Afzk4qIc2wCRTcEM/9zzUQZ
         rUjo+j9iyd/E7RW84qy/79c4FsGP82q1OVwLzSupxl+xM1CfW8utmpY7g48FhNbOpn3r
         n/WOXm+gTFhyZgajil+Drdvtl7BhrERdFbYo7YRZDP04P1GZ9kM5QCmPMtDnPXEN8QRb
         +JSOFkvo5sEoONIBNlMZRbOGSyEh31rCsfvIFt6upmFbJQUD+7E7OspvFAEh+4Impp/Y
         RvJC2a3u6vGz7rgPbdiwbXF4CDbBxPXpTvkzvoFTG+P7jWJY92b5AaHwUAvqH1bLS9j6
         qTKA==
X-Forwarded-Encrypted: i=1; AJvYcCWdTcGkUpcQ95RwWNvMpIJmMvoISpJhy+bPq9s3+A7P+wRH7N2QfVhN1SNf/qcuOPsEanNl+/WWHvisSFLmvZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVW5PLa5n5ZZWqCeAfMXVrw/gBIWAI80GRhtA/zH7F+6Tqr03h
	QbSZMoppyDFHojRbIw5B2HTX3hDm/shlH5e4ddeE6LHtPDREfdshcmsp
X-Gm-Gg: AY/fxX6jWMjJ2EuNdTnFVVkQ+IfVz3DU80Mf/5CAgVgF1cyGFiqtsm8vju6aYJyInji
	xkxwcNO880a60Obow/H0Q4pS3MCQYs3yqC3eBwgd9pmS82x6ZfpVe/QdwnztLRc5FtYYYGxA15d
	QJoEkxwU5OJAir8O0BRO9YnSOVrTNHMCX+4Lwh1KSSv4OWSF2ps/p5yhYa+ir+BWtCxS5ty/aRs
	43ebKl7IF3gMwXz+u5i7BJ0dFRoUBMt64ncpoUVow6LyW6v10n8RDoNVcyG5wCaqx5mMVTyb07D
	tJqrumnCBRj72E/e2LrQMAV0C/doTjORXItFE7KTL5QToteUqMNlv/8PUHU1Du0K7JsLMhPA1NL
	GAyoPZw380ifkA7xC9kIII1cNg/uOv+9uHk3cUsI+gsBeeuLJf6lk8gNkh/bzlWXeo6Uy0h68A0
	QMC40cqlgXBrTFBJorb+0opE5mz3KFjg==
X-Google-Smtp-Source: AGHT+IGjK8rJGe7UP8nCcqY9JoiVT1VEcE498zodT6Y5hCManvFWTxc/M2D1CWJpwDzvLUJI8J1FCw==
X-Received: by 2002:a17:903:120b:b0:294:def6:5961 with SMTP id d9443c01a7336-2a2f2840071mr143178055ad.45.1766536139566;
        Tue, 23 Dec 2025 16:28:59 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d77566sm138767285ad.97.2025.12.23.16.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:28:59 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:38 -0800
Subject: [PATCH RFC net-next v13 04/13] vsock: add netns support to virtio
 transports
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-4-9d6db8e7c80b@meta.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
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
 drivers/vhost/vsock.c                   | 41 ++++++++++++++++---------
 include/linux/virtio_vsock.h            |  5 +--
 net/vmw_vsock/virtio_transport.c        | 13 ++++++--
 net/vmw_vsock/virtio_transport_common.c | 54 +++++++++++++++++++--------------
 net/vmw_vsock/vsock_loopback.c          | 14 +++++++--
 5 files changed, 84 insertions(+), 43 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 8eca59fd1afb..d939cac2b52e 100644
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
 /* Callers that dereference the return value must hold vhost_vsock_mutex or the
  * RCU read lock.
  */
-static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
+static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
 {
 	struct vhost_vsock *vsock;
 
@@ -80,9 +82,9 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
 		if (other_cid == 0)
 			continue;
 
-		if (other_cid == guest_cid)
+		if (other_cid == guest_cid &&
+		    vsock_net_check_mode(net, vsock->net))
 			return vsock;
-
 	}
 
 	return NULL;
@@ -271,7 +273,7 @@ static void vhost_transport_send_pkt_work(struct vhost_work *work)
 }
 
 static int
-vhost_transport_send_pkt(struct sk_buff *skb)
+vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vhost_vsock *vsock;
@@ -280,7 +282,7 @@ vhost_transport_send_pkt(struct sk_buff *skb)
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid));
+	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid), net);
 	if (!vsock) {
 		rcu_read_unlock();
 		kfree_skb(skb);
@@ -307,7 +309,8 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
+	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid,
+				sock_net(sk_vsock(vsk)));
 	if (!vsock)
 		goto out;
 
@@ -409,6 +412,12 @@ static bool vhost_transport_msgzerocopy_allow(void)
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
@@ -433,7 +442,7 @@ static struct virtio_transport vhost_transport = {
 		.stream_has_space         = virtio_transport_stream_has_space,
 		.stream_rcvhiwat          = virtio_transport_stream_rcvhiwat,
 		.stream_is_active         = virtio_transport_stream_is_active,
-		.stream_allow             = virtio_transport_stream_allow,
+		.stream_allow             = vhost_transport_stream_allow,
 
 		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
 		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
@@ -466,14 +475,12 @@ static struct virtio_transport vhost_transport = {
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 					    u32 remote_cid)
 {
+	struct net *net = sock_net(sk_vsock(vsk));
 	struct vhost_vsock *vsock;
 	bool seqpacket_allow = false;
 
-	if (vsock_net_mode(sock_net(sk_vsock(vsk))) != VSOCK_NET_MODE_GLOBAL)
-		return false;
-
 	rcu_read_lock();
-	vsock = vhost_vsock_get(remote_cid);
+	vsock = vhost_vsock_get(remote_cid, net);
 
 	if (vsock)
 		seqpacket_allow = vsock->seqpacket_allow;
@@ -544,7 +551,8 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
 		    le64_to_cpu(hdr->dst_cid) ==
 		    vhost_transport_get_local_cid())
-			virtio_transport_recv_pkt(&vhost_transport, skb);
+			virtio_transport_recv_pkt(&vhost_transport, skb,
+						  vsock->net);
 		else
 			kfree_skb(skb);
 
@@ -661,6 +669,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 {
 	struct vhost_virtqueue **vqs;
 	struct vhost_vsock *vsock;
+	struct net *net;
 	int ret;
 
 	/* This struct is large and allocation could fail, fall back to vmalloc
@@ -676,6 +685,9 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
+	net = current->nsproxy->net_ns;
+	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
+
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 
@@ -715,7 +727,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	 */
 
 	/* If the peer is still valid, no need to reset connection */
-	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
+	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk)))
 		return;
 
 	/* If the close timeout is pending, let it expire.  This avoids races
@@ -760,6 +772,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
 
 	vhost_dev_cleanup(&vsock->dev);
+	put_net_track(vsock->net, &vsock->ns_tracker);
 	kfree(vsock->dev.vqs);
 	vhost_vsock_free(vsock);
 	return 0;
@@ -786,7 +799,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 
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


