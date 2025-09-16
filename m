Return-Path: <linux-kselftest+bounces-41636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B46B7EC54
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 15:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6BC87B6747
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 23:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320032F6160;
	Tue, 16 Sep 2025 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsIvOElp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1DA2F3C22
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066243; cv=none; b=l7U4OVnKxB3Aybg06doXkS9KJVbtoC/EOBgKa5fKF3a+5CH7DGkei4acgtrqqAxq2DZQABP9Zyv9Cjw68queryYhZPW8qAjQtErqrGomvVs0UDLhjgXii0TS+IPWErSzUgUO927nbVcnB0N0B0o+A5TMohumx2Sf+efqLxJseLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066243; c=relaxed/simple;
	bh=EH9ooYSziv5KhjIFRNdY5bYLFFDgOaXRzl70F+kjAYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tJEmxSd9LPB0BQ7gGL1w7S1KXtF0YBNTdjYyjmWJ1zS4l59KaaQ5pT2zIyfpMPXj1vWkg99E3F5Yi09kZBCzI7wP5r+H8tPv6PeoErC1drwtvXOgg4pcuDYTGPWH6TmtJvKjX+Rob30K92HU0LQq9NZIShhw3YYiYG61Yr1xH8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsIvOElp; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77251d7cca6so5709751b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 16:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066239; x=1758671039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVUMTjnbN6eX5riUEyr4WxlmQzTb3YpJ8a1+nr7efDY=;
        b=RsIvOElp2Gw0bwnNvVCtO5RYXXLSqQXv3+1QCCFE3o58NRCVGzRS05scwKA/bVW18V
         MMuJGgsHHsRfb8GK8Ba0OlbG3BrV5hgX9ahv5ObNLaOodKLMY6iv9lEJml+SbmNSrmim
         JMvXvWvS0XQY2GkZ+LC/oRTBfmTnn2s2KTDS2nZdojgBQHzNSnHHnOZ1xRycoLcXlUs7
         k77RA0CQwh3GE4BvuBM85XOGZflm4nK3+YzjmdHZFmn9KvYh7seKBJVX5ucBi6e60Tm5
         cZLtikKT0x0UbfrCaQ1DzrQgDMTwHMz3dtd0nXFrPwZxcOk+VpbGTToV/iN4KzX46Q7f
         LY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066239; x=1758671039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVUMTjnbN6eX5riUEyr4WxlmQzTb3YpJ8a1+nr7efDY=;
        b=md8TxkZtBdj0udUPssPg4/n1j20wl6fiXMWkWPQwNcGc9UEdncQR6ZFT82WiKE2es0
         1WVYQ0kVJU0beJzV5fBUqWcViPrzqqQXi1cfI8ROcitK5k9I2FVDDcThXQSUGIqkFo35
         BKsLsnCe1H5VnzKhhy4BlJFXr0wPU0IY3pUjRbQUru/ZIYuDQCm6KoUf07BBhBBXrjf/
         yc6KMDDRiFMEdEevupIrfM0ovg2gzFMSVpq5M1Ubmqzv7q1o1qb9J6i5xQuk9lXYpvHI
         TRv+krm0TlWvXchSjurVrbKEVxFBfwbZDSJsxOMs97c3ubUCF0NEscLOg7mz1rhizkHD
         13Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVdQNBMvSKnPtrFbCNh3fcpCspVAbr8N23F0Opf7Ssnnkr3E6Sn/UBTtTDMVCVQ+rjejof2F8O/UuDrhPcPnwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqsuDIG2EaX9vqFWmObyyWcTeXuEnS2LmGHVlL89KAYnUyL1My
	L4IJN/WxAMMB2+Rc6H4ZLivyCjmXEMBspw8lj5xDsVMUKP3WsUxdD1+Q
X-Gm-Gg: ASbGncsxjTYetwXj1oTXVEzznNCW2NrJ8sVTFxNldgnOHlYO86nWLKf2d1FywLtg15k
	G5rV3or/qqAgCJOUlOPq02mq3ARpCnePcf+K9Uv0nfapLngASIMssswyZglgb1wsDyEqFsSveUf
	B4YVdNDUplzzwzvtOi39m2i4V5dkDNdVOs3A3FBLz+io1hLrs0nFgO62kE5QvBibIvDLt2jotKS
	NYtI7CwHHSkvdGLvaFizoG3Ybcl+uDznIbE0Er6LqzaTrlBogWlLpszo0yWTdchguJV1NMZblWy
	9+D/MjFQa5O8URzoestTU4ZTI/Iut5xH4ykSmoaxPu6nUE7GS4Ksn5t+nVEl2uqtMKC76TZrQ7E
	amDRiSwvLuUC1P/K+Lkm96JKibIpL79bmNIdxgXWDag==
X-Google-Smtp-Source: AGHT+IHh73YIhkH04jOcSNkz8qf8UKgUb5SUQdLJktTvor8RNRMCdjI+LaMxqb5RVFwojQ7SBvQpvw==
X-Received: by 2002:a05:6a00:3e1a:b0:772:260f:d7b1 with SMTP id d2e1a72fcca58-77bf8c7796emr66050b3a.16.1758066239010;
        Tue, 16 Sep 2025 16:43:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-776210c4a5bsm11338744b3a.47.2025.09.16.16.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:43:58 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 16 Sep 2025 16:43:49 -0700
Subject: [PATCH net-next v6 5/9] vsock/virtio: add netns to virtio
 transport common
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-vsock-vmtest-v6-5-064d2eb0c89d@meta.com>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
In-Reply-To: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
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

Add support to the virtio-vsock common code for passing around net
namespace pointers (tx and rx). The series still requires vhost/virtio
transport support to be added by future patches.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport_common.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index ea955892488a..165157580cb8 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -196,6 +196,7 @@ struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
+	struct net *net;
 	u32 pkt_len;
 	u16 type;
 	u16 op;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1a9129e33d51..8a08a5103e7c 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -316,6 +316,11 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 					 info->flags,
 					 zcopy);
 
+	virtio_vsock_skb_set_net(skb, info->net);
+
+	if (vsk)
+		virtio_vsock_skb_set_orig_net_mode(skb, vsk->orig_net_mode);
+
 	return skb;
 out:
 	kfree_skb(skb);
@@ -527,6 +532,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1067,6 +1073,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_REQUEST,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1082,6 +1089,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 			 (mode & SEND_SHUTDOWN ?
 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1108,6 +1116,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 		.msg = msg,
 		.pkt_len = len,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1145,6 +1154,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.reply = !!skb,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
@@ -1165,6 +1175,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+		.net = virtio_vsock_skb_net(skb),
 	};
 	struct sk_buff *reply;
 
@@ -1465,6 +1476,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 		.remote_port = le32_to_cpu(hdr->src_port),
 		.reply = true,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1578,7 +1590,9 @@ static bool virtio_transport_valid_type(u16 type)
 void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb)
 {
+	enum vsock_net_mode orig_net_mode = virtio_vsock_skb_orig_net_mode(skb);
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct net *net = virtio_vsock_skb_net(skb);
 	struct sockaddr_vm src, dst;
 	struct vsock_sock *vsk;
 	struct sock *sk;
@@ -1606,9 +1620,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket(&src, &dst, vsock_global_dummy_net());
+	sk = vsock_find_connected_socket(&src, &dst, net, orig_net_mode);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst, vsock_global_dummy_net());
+		sk = vsock_find_bound_socket(&dst, net, orig_net_mode);
 		if (!sk) {
 			(void)virtio_transport_reset_no_sock(t, skb);
 			goto free_pkt;

-- 
2.47.3


