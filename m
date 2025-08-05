Return-Path: <linux-kselftest+bounces-38333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01F9B1BBFD
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 23:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8A3D7AF37A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2532C29B8CF;
	Tue,  5 Aug 2025 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOX4Y6My"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6993429ACFD;
	Tue,  5 Aug 2025 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430563; cv=none; b=N/zcuzBG6q6RpVxVrXHfamQkmaDHZKz039QE9DLO6vAGKerpw6CTQAYpsJ2msVzs7SZjAIjUzn9Inj+ybhOG95cfjlp8ggawtHKSP9XFzYi4XEKLOvxKeytu+LVv/eG0E47uvccu5EbKQhJ8BnSAnrPH4udy51Iti2Sv+xzDUMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430563; c=relaxed/simple;
	bh=4nOiUR2yclelPvjzHls90OB1HWOtZ8j4Fd2CwpbPgy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjH82assKEdswV3ZwPjWdqZxjDU3IUDbox6SYeWgTBrNuVxuqEgU6WNy6HC5FaW62eGq7cIFvRoaVeNi7siorsJL9IlsdtwrX+u+ki7brGuWfN3S1WhqLDIfcxiTFqUW8uTxAkkpqOyHKGoI3tGgcupUF81V9uBXDiRGUpu/Obg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOX4Y6My; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso4346293b3a.3;
        Tue, 05 Aug 2025 14:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430561; x=1755035361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIzbPe6n99JFgKHn/5BXgj7yzYZCxe9bDEHL/cgVeVU=;
        b=lOX4Y6MyaDBVriGnepT0V5AeuhB8XZbc7nnsEMXzWanaywuBjOol3av0sU2kK56i/V
         0WQ/4kYAr9KldqvYQSllR/Rh7oFBQHm4T7Z8s9iBlgsJv9DWb+LHJVC56x3q7rV1SkiU
         m1Q77eEmIuxhUVKB76JbaYd4M7FOPUfHyi5aflIQApfgrAflqS6AddglJDcZr7pblbQ5
         9iI5V7+3f/5IAi3HnDpo/NBOzqnu+99iy/carTih7Qv9cuXSgTZVuzpyx3bJFpn27kGd
         VOXdJwzMH+i+kFW/wuSe30K+TPQYBr2qU2IgCdPv4xlGtD1cbI6rrA5IlAW9S121f5A3
         zvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430561; x=1755035361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIzbPe6n99JFgKHn/5BXgj7yzYZCxe9bDEHL/cgVeVU=;
        b=nh2edPrYTqXJHdskFej+wPOV4KR7AAWopq8lSFt/l+vJQsFu2fDSnReFTjxoVBeYvh
         UGn/GCrUY/IIv7lnpFMdbsO89W0IkdajaVuLCcyHaxgJO/Uwq5P0LzdoUn9uWtNqCWUq
         YY57NSMOMi6Tw26gWk7HwlWzlUTjaPVc14Kd3pYNWjmK/Tf/4bQvCv4I4tYwlI116f7K
         ouY3gprBGvSnP3EXEwEzO7lBnHobJlfB5294Yi4sNx63UTSedy8lvf2SxIeUb1Its6Kv
         iNMLIen9KP4Ww6kmyee+5tR24khATtqxMFEZwU//ffVO5Xx9zchtj13V9K4SHUjC4udj
         NZ3g==
X-Forwarded-Encrypted: i=1; AJvYcCU2URjAQ4jQ87AEg8FzojoSGUB8Iy5uz+M4GKv6wHoHSa1ODlO0NchONW4S0hYI28+AwAxZIlhspkYXjer7@vger.kernel.org, AJvYcCUDG1Ql4Tbvqjl1XCPQgaJ+Y4+0LTOUz9QBZBvuKkBGVOTonSbuSXPPnLQQZtK4bwnWtY7SVCk/gpvRYmQx@vger.kernel.org, AJvYcCVwJQ/eVwvfAK7na37yM0lhuV3OAY02VuiH/OA2YV1W623+46R0YHcR1LdX/wRHJEJBt61gbHFI@vger.kernel.org, AJvYcCWT8CTrTt5vWjSyY2ARoWG394Cf9RRG54aIgy1uvfQmKMUtB+TIGFgbgZPyK/afCoQZptA=@vger.kernel.org, AJvYcCXUxOsVzdJsevgR5zHjFIFICQhHE+srlu15KWq1EJ6Yomb3RCDjUONPKrmNdCUAY+/EdXC9Q3Tut3MhBHHQ4wLM@vger.kernel.org
X-Gm-Message-State: AOJu0YwkStgfT/iXQzOWoXByvhmbEdLGO4xlOpjPpVeJXaG2V31e7RHp
	xPzNx2DK9rWZci9Xl/XGPeChO2XUcYsjUWgFCnzcZPqAUoYTRSZ3uc/P
X-Gm-Gg: ASbGnctNKZnhTrI+N9e6NmhSIWfYC95KISeZwm3ynxa0Eotg8CbaEv3HfHWNiBgVVwv
	xRapN6K1Qc2wC5v47y8GcGbSHR8dMVc4bVUX78kkSw73hYFfzX1tXyTuJ6J1LJLBtNTdjZkzOy1
	JFUtvDcde2FHCP+wRlcDPcxa5aMgTlUxFvB1Uyn5vyY0xTRMHPHLQbl/DWfaCeI8fYaVvT+VsaI
	azXD/AG/c6oockkAncA6/F5wQuQX1CN3w6UNWGbunvsNmYtA8UPxgqxGlFJTvE3ZUzVqt88oQrc
	9n1bJqMH0Ix3kb5JrooE5f2xVYQqUwADbRH7kYwFt3vLLc5jnyh1DCbWZnJqq3LgxjRVl4QUazZ
	QNVvHEmM+wv5bt6g/fd78
X-Google-Smtp-Source: AGHT+IH30GOU7ALtk6a4Qu69GWLu4nFmm7a9hAyqteGUmf/zmxX9XY6X82MDI/g8fCQ810jQb8Mvgg==
X-Received: by 2002:a17:902:e850:b0:235:e942:cb9e with SMTP id d9443c01a7336-242a0a765f6mr3164885ad.9.1754430560589;
        Tue, 05 Aug 2025 14:49:20 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef67aesm142920695ad.6.2025.08.05.14.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:19 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:13 -0700
Subject: [PATCH RFC net-next v4 05/12] vhost/vsock: add netns support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-5-059ec51ab111@meta.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
In-Reply-To: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
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
2.47.3


