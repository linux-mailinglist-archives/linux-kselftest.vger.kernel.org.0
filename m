Return-Path: <linux-kselftest+bounces-43701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE41CBF94EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C78C24F7E73
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2153E24677D;
	Tue, 21 Oct 2025 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksSNl8rS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC772D46DD
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090429; cv=none; b=rB0hEdvlhcYpI0NtSYuo9yPF0KZjap8zjqgbZ13rt7sT9K8pxedu8SWXg4hrUevxVRLkygYV83y6aFzhW8XOcUQ4Swp5/SZ52s7hWgcF/mes7j7RTTpQsulfB/O9O/UQQETLP5oKyVPrmlYMQgPnpK8bXBZJdM6Y6tt1AKQHDiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090429; c=relaxed/simple;
	bh=vT+Tq/xDspn4kgfcPG0WM13a7POPaOaQ9NQCIKNs450=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBVYCSVBB8VcugNs33swcM+RkaqcPHDO5W8krsJPyz56JD7x5wMAmGi+hyDC7bKLhrfcyORtiVDLec96QRbiOGDfNkwbJpEPUP9pEakujJ5HaH20C2Y8d9W39so1ilfNAeJbvAMdGwMm5HJrC4vypAJOg8Groi/Yq/BMAsWbOd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksSNl8rS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27eec33b737so93164885ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090425; x=1761695225; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXXMjozyE7G9hxBpLov8fPEzcD6yFRLl/EC2MbvXbp0=;
        b=ksSNl8rSs/x7+c5KO2kvCG4tGr4iz0ROYTQHCJYtDGQoA67UShXZfx/CjhCjSqcYsi
         JjlnmeqlvsTXGB2B0ww71VvrjQxBUlmjYtGa3jcJHSths5a/G5nmQWy1BwN2KNdivGR9
         oluKd6K5sbwclGGjE3g+o9ND92rKghvD22owOdpIZ5DC8JAqrx+W6eggE2I845+EQZNY
         s9Krzjo294mBKNv1ZbxmTthON7OIEvIPYJUgup2EvozvDRLrx4y+pjX7ytxKoguWqudo
         5rJkaP5wdyr96ykf6OpeRhLkGqbJDmNJg/ZRKDMnzNH+QcBOnNqUHlp8a6A5RHBDjmHQ
         8sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090425; x=1761695225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXXMjozyE7G9hxBpLov8fPEzcD6yFRLl/EC2MbvXbp0=;
        b=V8X62kus/jYRgUOxreIsY3M6/pgM1+qpFXLsb3bYUvpPi5t7OxRCg3VIOhB2QfsXpT
         Sx75+9+v7/CqtKid9WNcHBFfRM3i28K8jv8KnbzLukxzh2VzytNbgR/IW5u87DlSrofk
         32RnjFsDKr3EnhTIkcIr38rLibNtrSjsp1Or0zN9V+DK+hDF9hJ43naA+sHxSE/pt/5q
         FjW0Z9IJJYuiRPf5uIbIMkSGRPjPApdkyGuV1b7M87PCSICzcGA+B9UjO+lWy/WrWf7N
         Fdhe0knHQJpxLNpWqGdlWiGl16nLzMx1GjCwtul5i7aBjVE43zgxYW9zpymBj+0cp6zx
         t5+g==
X-Forwarded-Encrypted: i=1; AJvYcCUVkC+VT2bVBC8ZgmsoBrZYeQnZtBZm9m/xPjwyGlZ+sA3kfBYjJ1T1AWk4s9GHxMfaTfAWlD1AcdC7+Rj+G6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/ouWp8wLQoW+g9oPzTlOHTqg08XiV8FPwuIUtDJE5ldevXSS
	+ORyTV7d9vCAoB03Kb08Zu+4gxzSmraAxagmRHDII5Aeu3Q8F+LcmOKv
X-Gm-Gg: ASbGncvn1LabK01ZitWcyB28l5UlJv5OroQzftOz/JMs9YxCdcotzpfJ8Cxl9UI59YG
	lMeTrJv4DkecfsCVJcOHAU+yO6xtAxYViFWY8ou9uEpUdzU8vmyOEqVxHg+35zLgsU0OWF9HDH3
	iX24yGl175eJ8Zue2VV9DLirWo8Lr13EA8uiMkcOZCfmyGbf2neF3CSVJYJi/eP721dXzkefLxx
	r2c6Bwx+nhD+U6u3wYlj8jgsCdD5BbFSt+xO6JWbNTzRxoHpasszEfII7g3x52ooBG8+/FPzptU
	JITgM2hyn46kT7tgWXFQbBuNhEjI5XWWSe4UNfyMXwSun1Qnjnp4bYrAi9ecigF3e3xZo3xJQKm
	jm5kxIHb7mePK+EMhn4RU6dXEBOqiyVULh792wlM/kamZhDiqklOHkpRc4E9ivzGYf3Mnpu0Np5
	2qHjDpWPg7
X-Google-Smtp-Source: AGHT+IGisn1W6av3z2asOwJINc4Pm13WD84loloJNSHettssMRmm84ISrxessn3f1FRQqEXghoDjxg==
X-Received: by 2002:a17:902:d584:b0:290:bd1b:cb3d with SMTP id d9443c01a7336-290c9ce67c0mr235162115ad.27.1761090424797;
        Tue, 21 Oct 2025 16:47:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472197desm120682725ad.115.2025.10.21.16.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:04 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:49 -0700
Subject: [PATCH net-next v7 06/26] vsock/virtio: add netns to virtio
 transport common
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-6-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
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
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add support to the virtio-vsock common code for passing around net
namespace pointers (tx and rx). The series still requires vhost/virtio
transport support to be added by future patches.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v7:
- add comment explaining the !vsk case in virtio_transport_alloc_skb()
---
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport_common.c | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 29290395054c..f90646f82993 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -217,6 +217,7 @@ struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
+	struct net *net;
 	u32 pkt_len;
 	u16 type;
 	u16 op;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e..b8e52c71920a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -316,6 +316,15 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 					 info->flags,
 					 zcopy);
 
+	/*
+	 * If there is no corresponding socket, then we don't have a
+	 * corresponding namespace. This only happens For VIRTIO_VSOCK_OP_RST.
+	 */
+	if (vsk) {
+		virtio_vsock_skb_set_net(skb, info->net);
+		virtio_vsock_skb_set_net_mode(skb, vsk->net_mode);
+	}
+
 	return skb;
 out:
 	kfree_skb(skb);
@@ -527,6 +536,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1067,6 +1077,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_REQUEST,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1082,6 +1093,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 			 (mode & SEND_SHUTDOWN ?
 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1108,6 +1120,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 		.msg = msg,
 		.pkt_len = len,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1145,6 +1158,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.reply = !!skb,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
@@ -1465,6 +1479,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 		.remote_port = le32_to_cpu(hdr->src_port),
 		.reply = true,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1578,7 +1593,9 @@ static bool virtio_transport_valid_type(u16 type)
 void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb)
 {
+	enum vsock_net_mode net_mode = virtio_vsock_skb_net_mode(skb);
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct net *net = virtio_vsock_skb_net(skb);
 	struct sockaddr_vm src, dst;
 	struct vsock_sock *vsk;
 	struct sock *sk;
@@ -1606,9 +1623,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket(&src, &dst);
+	sk = vsock_find_connected_socket_net(&src, &dst, net, net_mode);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst);
+		sk = vsock_find_bound_socket_net(&dst, net, net_mode);
 		if (!sk) {
 			(void)virtio_transport_reset_no_sock(t, skb);
 			goto free_pkt;

-- 
2.47.3


