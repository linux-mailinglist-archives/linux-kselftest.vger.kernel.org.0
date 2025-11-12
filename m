Return-Path: <linux-kselftest+bounces-45380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E2EC50CE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 07:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 212664EBE16
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 06:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75CA2EAB71;
	Wed, 12 Nov 2025 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwkU+ZLE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663C52E1C6F
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930542; cv=none; b=DAbClh9idGque5ut839ZypIMjh1X3by6eGrqGeRYrZF/mtMuAldg4ii2dyWlUuD8mH5VBd5pTFqthlWY+7FYtGhpYbnY2OqmOFAS0toUSNlGxo4VOETbSzuJjer5Pey3mEAxHEANOMe9om8bfmiEfXxErRgjN0Z0YPBRyMHY49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930542; c=relaxed/simple;
	bh=x01zOAmfw1TrdUC/ahrcPJYe2LwU5p3FXdS7P3II6Tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nOqpws3HA+8JDX/yD3XLJDfD8nnUnBHG5fwks5kEMl/Qc59PdRSyd/rnV2RP9u/k0AVKZxkfSVogXaz2PG1/R5IgijhmzS4dW08+Avn31ijorqoo72UTyr7JJxFPkjSxLcbQEFZgiNver3ueo8VXVYIxH6fuUxbziLVk8Azt9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwkU+ZLE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7af6a6f20easo439026b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 22:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930538; x=1763535338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9Muirklsj05QTCD8wUlJjKigqYGBD3rPT3xLRl/wt8=;
        b=SwkU+ZLEqJsAPhHTrSX0XJYcp0yqPKnLh8t8uQmjXSe1ERYv1FS1psTYVun6fYIGhz
         4KguGDXmUdm8Sc+PoPmJGnHotGz0znEEob7g3Z3cKyVmdv5A3IWqzOYf+tB8SLyQgrrK
         +G9zftnVOwMgsc8JCOp92xPn+Rru4zFvUqtnkkfHcuAk1TmuaLa5vJlOHGmXUDxts7i6
         LAJdbEnoYf++g0zd6J48Xy6CSHuG9GVKlUxi0ph2cHFUskau37uXADkz9Ev8oIurGbZB
         ZkpKgjAgWZBkJgaZKjieqhqwF0DWNK/DFWUngV7olKRPT8huDMRA9TyJZcgMYtiFlo90
         xC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930538; x=1763535338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e9Muirklsj05QTCD8wUlJjKigqYGBD3rPT3xLRl/wt8=;
        b=tO1DJjini86yV3PfQuoGeoBEJS9ABjq5zEwDdF26FjIlKk/Zrnjv65o1hEI1HzsmsP
         sMjucgrQU0KPBrNaX7ohdfPKJaQLpBpR5OFu/+tO4Z/iw4341eSEifwZLYAWk/KXVgfu
         dhD8td15A1tisOtk7mPeWnqBtysxmTwCvpX2QWB2BzTDILaCXYGc/gtHoX4CU1jRsX6E
         z1xzd3G8Fc+whGwe4IcpYqKX3ee28Nk0dq4YtqsJJaRer/BEt4TKQUkN4luAlSbgqPCv
         EiLVnHS7yt1aUOCgHHyfRZCFvcSUsqKhPQ+/3LpnsJv8BwKqLGsHzNtRQZFwtoX2WIVR
         h+GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfBiXFzpUAYwOM0Vt5OEf+BU1mANowxUaq//Ge3cNs3BXRKrnsU9rNA+pZGMCoasuL05HaWIRTidiTE3/5C2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW8bsF3NtAgBHOxbMSMw3fEr3iOjLsSkOB8BYnKksY35f8NGsS
	3yaL9clV6WudGzNI4Yi25oed7cKOqk0qZy6szxvkJ0oY7yJnElBXCST3
X-Gm-Gg: ASbGncssweij9gAMyQmIG8Ihb2tYIPraLd73GhhfubQmTycjXooGf3872FatKpTAEBB
	ViIg9M9C6RCdPWWGXzCrOIgZchWgE5w0KX1hMIXIKu7QkED2q/dMVh/zN6a9jmLwOFI+iDdCZCp
	t5KFbB4k+gRSiIraaJz/S2uZC0QtsLaQzA0WawVRz5OlIH4lZ6gMLKc6qafaZnw4X3yQsdWcdBu
	o+3Ak6wneNdZIvSXfh8Wo8Km74nhw1sHffpMaqp0BVoTolQVJmsisF4jizbbeDA6H4Tz24ko5Vk
	UVn3eKY2CqVufHPstNt/nnSCEXCCytE9zSvh3OuqphL954vmVa0MesLr2Pa56lJ3ErEDn20qCdk
	M5VTzt0K6UBl2AD5196KRZ7L7UrM9dL8xd85XGmWUvbDgvkzQPYuvuL7hyBM5YB1Syiu2dZZJ
X-Google-Smtp-Source: AGHT+IE9lKcwl8xH8ZlUGeYGOl2wf0n7obO2POiQTro5WMCjHQ660/Bv7vIKXdZqxjqi/qU4irtWLg==
X-Received: by 2002:a05:6a00:14c9:b0:7aa:a2a8:9808 with SMTP id d2e1a72fcca58-7b7a4af60f8mr1939517b3a.20.1762930537613;
        Tue, 11 Nov 2025 22:55:37 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b73ae09668sm2465327b3a.69.2025.11.11.22.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:37 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:45 -0800
Subject: [PATCH net-next v9 03/14] vsock/virtio: add netns support to
 virtio transport and virtio common
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-3-852787a37bed@meta.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
In-Reply-To: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
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
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Enable network namespace support in the virtio-vsock and common
transport layer.

The changes include:
1. Add a 'net' field to virtio_vsock_pkt_info to carry the namespace
   pointer for outgoing packets.
2. Add 'net' and 'net_mode' to t->send_pkt() and
   virtio_transport_recv_pkt() functions
3. Modify callback functions to accept placeholder values
   (NULL and 0) for net and net_mode. The placeholders will be
   replaced when later patches in this series add namespace support
   to transports.
4. Set virtio-vsock to global mode unconditionally, instead of using
   placeholders. This is done in this patch because virtio-vsock won't
   have any additional changes to choose the net/net_mode, unlike the
   other transports. Same complexity as placeholders.
5. Pass net and net_mode to virtio_transport_reset_no_sock() directly.
   This ensures that the outgoing RST packets are scoped based on the
   namespace of the receiver of the failed request.
6. Pass net and net_mode to socket lookup functions using
   vsock_find_{bound,connected}_socket_net().

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v9:
- include/virtio_vsock.h: send_pkt() cb takes net and net_mode
- virtio_transport reset_no_sock() takes net and net_mode
- vhost-vsock: add placeholders to recv_pkt() for compilation
- loopback: add placeholders to recv_pkt() for compilation
- remove skb->cb net/net_mode usage, pass as arguments to
  t->send_pkt() and virtio_transport_recv_pkt() functions instead.
  Note that skb->cb will still be used by loopback, but only internal
  to loopback and never passing it to virtio common.
- remove virtio_vsock_alloc_rx_skb(), it is not needed after removing
  skb->cb usage.
- pass net and net_mode to virtio_transport_reset_no_sock()

Changes in v8:
- add the virtio_vsock_alloc_rx_skb(), to be in same patch that fields
are read (Stefano)

Changes in v7:
- add comment explaining the !vsk case in virtio_transport_alloc_skb()
---
 drivers/vhost/vsock.c                   |  6 ++--
 include/linux/virtio_vsock.h            |  8 +++--
 net/vmw_vsock/virtio_transport.c        | 10 ++++--
 net/vmw_vsock/virtio_transport_common.c | 57 ++++++++++++++++++++++++---------
 net/vmw_vsock/vsock_loopback.c          |  5 +--
 5 files changed, 62 insertions(+), 24 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 34adf0cf9124..0a0e73405532 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -269,7 +269,8 @@ static void vhost_transport_send_pkt_work(struct vhost_work *work)
 }
 
 static int
-vhost_transport_send_pkt(struct sk_buff *skb)
+vhost_transport_send_pkt(struct sk_buff *skb, struct net *net,
+			 enum vsock_net_mode net_mode)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vhost_vsock *vsock;
@@ -537,7 +538,8 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
 		    le64_to_cpu(hdr->dst_cid) ==
 		    vhost_transport_get_local_cid())
-			virtio_transport_recv_pkt(&vhost_transport, skb);
+			virtio_transport_recv_pkt(&vhost_transport, skb, NULL,
+						  0);
 		else
 			kfree_skb(skb);
 
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0c67543a45c8..5ed6136a4ed4 100644
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
index f92f23be3f59..9395fd875823 100644
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
@@ -660,7 +661,12 @@ static void virtio_transport_rx_work(struct work_struct *work)
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
index dcc8a1d5851e..f4e09cb1567c 100644
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
@@ -1156,15 +1166,27 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 
 /* Normally packets are associated with a socket.  There may be no socket if an
  * attempt was made to connect to a socket that does not exist.
+ *
+ * net and net_mode refer to the net and mode of the receiving device (e.g.,
+ * vhost_vsock). For loopback, they refer to the sending socket net/mode. This
+ * way the RST packet is sent back to the same namespace as the bad request.
  */
 static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
-					  struct sk_buff *skb)
+					  struct sk_buff *skb, struct net *net,
+					  enum vsock_net_mode net_mode)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+
+		/* net or net_mode are not defined here because we pass
+		 * net and net_mode directly to t->send_pkt(), instead of
+		 * relying on virtio_transport_send_pkt_info() to pass them to
+		 * t->send_pkt(). They are not needed by
+		 * virtio_transport_alloc_skb().
+		 */
 	};
 	struct sk_buff *reply;
 
@@ -1183,7 +1205,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 	if (!reply)
 		return -ENOMEM;
 
-	return t->send_pkt(reply);
+	return t->send_pkt(reply, net, net_mode);
 }
 
 /* This function should be called with sk_lock held and SOCK_DONE set */
@@ -1465,6 +1487,8 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 		.remote_port = le32_to_cpu(hdr->src_port),
 		.reply = true,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
+		.net_mode = vsk->net_mode,
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1507,12 +1531,12 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	int ret;
 
 	if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_REQUEST) {
-		virtio_transport_reset_no_sock(t, skb);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk), vsk->net_mode);
 		return -EINVAL;
 	}
 
 	if (sk_acceptq_is_full(sk)) {
-		virtio_transport_reset_no_sock(t, skb);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk), vsk->net_mode);
 		return -ENOMEM;
 	}
 
@@ -1520,13 +1544,13 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	 * Subsequent enqueues would lead to a memory leak.
 	 */
 	if (sk->sk_shutdown == SHUTDOWN_MASK) {
-		virtio_transport_reset_no_sock(t, skb);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk), vsk->net_mode);
 		return -ESHUTDOWN;
 	}
 
 	child = vsock_create_connected(sk);
 	if (!child) {
-		virtio_transport_reset_no_sock(t, skb);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk), vsk->net_mode);
 		return -ENOMEM;
 	}
 
@@ -1548,7 +1572,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	 */
 	if (ret || vchild->transport != &t->transport) {
 		release_sock(child);
-		virtio_transport_reset_no_sock(t, skb);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk), vsk->net_mode);
 		sock_put(child);
 		return ret;
 	}
@@ -1576,7 +1600,8 @@ static bool virtio_transport_valid_type(u16 type)
  * lock.
  */
 void virtio_transport_recv_pkt(struct virtio_transport *t,
-			       struct sk_buff *skb)
+			       struct sk_buff *skb, struct net *net,
+			       enum vsock_net_mode net_mode)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct sockaddr_vm src, dst;
@@ -1599,24 +1624,24 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
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
+			(void)virtio_transport_reset_no_sock(t, skb, net, net_mode);
 			goto free_pkt;
 		}
 	}
 
 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
-		(void)virtio_transport_reset_no_sock(t, skb);
+		(void)virtio_transport_reset_no_sock(t, skb, net, net_mode);
 		sock_put(sk);
 		goto free_pkt;
 	}
@@ -1635,7 +1660,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
 	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
-		(void)virtio_transport_reset_no_sock(t, skb);
+		(void)virtio_transport_reset_no_sock(t, skb, net, net_mode);
 		release_sock(sk);
 		sock_put(sk);
 		goto free_pkt;
@@ -1667,7 +1692,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		kfree_skb(skb);
 		break;
 	default:
-		(void)virtio_transport_reset_no_sock(t, skb);
+		(void)virtio_transport_reset_no_sock(t, skb, net, net_mode);
 		kfree_skb(skb);
 		break;
 	}
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index a8f218f0c5a3..d3ac056663ea 100644
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
@@ -130,7 +131,7 @@ static void vsock_loopback_work(struct work_struct *work)
 		 */
 		virtio_transport_consume_skb_sent(skb, false);
 		virtio_transport_deliver_tap_pkt(skb);
-		virtio_transport_recv_pkt(&loopback_transport, skb);
+		virtio_transport_recv_pkt(&loopback_transport, skb, NULL, 0);
 	}
 }
 

-- 
2.47.3


