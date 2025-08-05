Return-Path: <linux-kselftest+bounces-38332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB54B1BBF3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 23:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E5A16667C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603E029B22D;
	Tue,  5 Aug 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XY+td+8k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B8829ACCE;
	Tue,  5 Aug 2025 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430562; cv=none; b=rgkv2GJZQpK+z6L4T7thMBw+QZfuqM+6q+nQHKpTftjcxMDf5OPJQq1raIfeI9S2TNeH5DVMVvu77DcrbPUIHHBDmg4KdzolrTzzkL3T/TAItdPWLqHSvMuWAVBVedEPqtspCbPw3V4aFLE9kEvwCBr4izvIqWHaLGjeURNS6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430562; c=relaxed/simple;
	bh=L8+UJORlszErIif6aAL4B/2M4IL1vW1dLWaDie77K18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=le83gEjOhkwQRDHm1FOE7jmd4vrI0DodZQ5Y+2pEL53UrQP/PyLHtL59YQ66f0tET1iyOn+kwuxOTfkla/fXa/AwCdyMQqCh7a9jF6xizzBSVljHvCM6fkkdf1iqB8Fn5PTdkwxo7zOeJAMGxPnzS6yyXosqM0lcS9aWl5+2zQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XY+td+8k; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76bd9d723bfso3928146b3a.1;
        Tue, 05 Aug 2025 14:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430559; x=1755035359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vClpSthvja0ciP4EEb0dS5NFu0AwWPReylpsN3j0yGc=;
        b=XY+td+8kiMSHVC6qBvyGQFKqyro8XhdMzcTEsFHjjZmaERPGWotLNNXnI9s5NJO056
         Ne4LclOCYM9yDzkSyjY2s8OwtVTpOGfv8iOyBwvsdYCKBe3ZGydLpHK8HT+O2JO0dxFj
         XT069WiK6VU43SAbo+KefQvrLMzVhRtBmANTO5rghk+JayL3ClCljw7/+fxX/jdKgf/o
         qD+8kqZf7kwUd7R467WkRQ6lXn9gEIRGptQXIEO8mWIlAme9k4qOLKDXqT2s2geXUEeP
         wIeZUp4Ebr8VzzhRPuUMViqgxY4sXtwQjNq5NGwt/6HDBr7WP0NYPfLrlPpFTb2Wz6Tr
         7GEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430559; x=1755035359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vClpSthvja0ciP4EEb0dS5NFu0AwWPReylpsN3j0yGc=;
        b=CZBMKnjqF3mUcx59i8WvDXSuvCp0KyDu2KGZXiEpwRJMGYPFZX4YgdFFI8tfL1rYte
         q7BSSZEBlcmZP5el0GghrOHagrt1IG+wYl5183mnkPxZzRFgqBSA2kNOCiirYqu0qoC3
         rc8pr/agK/FabD0mykHGnicrQjR2TWGZlkqT99/JuKUc5TX8Dv5HFHPvHjJ0uUWpOdy5
         dZ5slbaIKP/u3r3wYwQR+DhdU6cul7iRiBW5w/7Bp3cxQWL5B/dRJHxuy9r+zpDrI80L
         MaI3aHKb2tg/U028lyRkn3JCwBHms+sU1LpVTOqZhvdAx2psgVAthzGZOi1LomQEMsGD
         1H/A==
X-Forwarded-Encrypted: i=1; AJvYcCULHCgWHAyyECO1lXhPaqenzaGMY+p6BB0YLzoPJZOIy6NUmvL80pmv3+pus9lvE4r3a6udUTO6ebzri7ih@vger.kernel.org, AJvYcCUpEaB/zDQDiPDnCsTz6lJWrie7VSQyjpdFr2UkXz1IrsHCtBIOm2TWc/D3GZpsBwDRxXabmw0+E9BdJWMG@vger.kernel.org, AJvYcCVd8bZRxAsucrmZOY61zSr3DnoFuy0m6uOAkaEaWzTLsPBxidaYKfNTvUymEYYj2euqbtc=@vger.kernel.org, AJvYcCW3Il1QBvGLv9EMcWmYF77P3mclSE2nw+wtWI4zgjSOI0pvPhBmZGS1yhUyozMrsFUhgPCxL0a0@vger.kernel.org, AJvYcCWH9WPspdh9KeILhvPuj1E1EYJxNl8gDYGk/YeAeZUSbhsQmA1HsFKnylw8I4vLFPs1EJ0jmE8RgQIqvFYAgzvA@vger.kernel.org
X-Gm-Message-State: AOJu0YyBc79w/hmZ3+sAXp83udO8cDwhnHd/gNeND/B5IfmBo68BikDI
	Skfwn06DXt69XO/ujvCeWdvGN2Ub7JlxHhyiYsGST2Q5LOKsENDykvCX
X-Gm-Gg: ASbGncuy//OrWtEMuri3PQlK1Ph8xBdflqHK0iqZsvxn4LjuR/4+uNpIGbSjVWK3zkQ
	hhj+/1539HFeVP4RRFi19gxztBmH5GUXMKh3DldZ5qsJ1xdPbEXQGtulNOI35g9f6Nzehdg50yd
	hRSkHzh8IAWB9SwPEvh8A+GLlauBw6j0TtYZtgpVJzZvSG6MB/aqB6wa0oU+FEOMsw17yInVuwp
	8qVHpW7glu0TFi0ycrtM8POrTwiXFSNtd6144FOgQkvOG2PnrvTAnBxq5haqQdP6ndk300QrDrQ
	YaPnb4AO5u3vZTN6CtUavI633YNJxplSBmaSLD9+u/h1fQUqb/DT7uVb6NtwSW6VEC/rz9jrJFx
	bvjLK6Hu1dCl3P4Qjq2s=
X-Google-Smtp-Source: AGHT+IHIXvB6uOXF9tZ4IgyXPs/ln/7LW82JyFWlXgNyNXaIj2h0hXCpxPlYbwZ9V7Lb/cFmKcuy3w==
X-Received: by 2002:a17:902:f60c:b0:240:2145:e51d with SMTP id d9443c01a7336-2429f625afemr8254875ad.31.1754430559091;
        Tue, 05 Aug 2025 14:49:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89769c1sm143611275ad.77.2025.08.05.14.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:18 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:12 -0700
Subject: [PATCH RFC net-next v4 04/12] vsock/virtio: add netns to virtio
 transport common
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-4-059ec51ab111@meta.com>
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

Add support to the virtio-vsock common code for passing around net
namespace pointers (tx and rx). The series still requires vhost/virtio
transport support to be added by future patches.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport_common.c | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 93edc1e798a5..81355f84b76c 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -160,6 +160,7 @@ struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
+	struct net *net;
 	u32 pkt_len;
 	u16 type;
 	u16 op;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1b5d9896edae..310f2e92c527 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -313,6 +313,8 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 					 info->flags,
 					 zcopy);
 
+	virtio_vsock_skb_set_net(skb, info->net);
+
 	return skb;
 out:
 	kfree_skb(skb);
@@ -524,6 +526,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1064,6 +1067,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_REQUEST,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1079,6 +1083,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 			 (mode & SEND_SHUTDOWN ?
 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1105,6 +1110,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 		.msg = msg,
 		.pkt_len = len,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1142,6 +1148,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.reply = !!skb,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
@@ -1162,6 +1169,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+		.net = virtio_vsock_skb_net(skb),
 	};
 	struct sk_buff *reply;
 
@@ -1462,6 +1470,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 		.remote_port = le32_to_cpu(hdr->src_port),
 		.reply = true,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1576,6 +1585,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct net *net = virtio_vsock_skb_net(skb);
 	struct sockaddr_vm src, dst;
 	struct vsock_sock *vsk;
 	struct sock *sk;
@@ -1603,9 +1613,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket(&src, &dst);
+	sk = vsock_find_connected_socket(&src, &dst, net);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst);
+		sk = vsock_find_bound_socket(&dst, net);
 		if (!sk) {
 			(void)virtio_transport_reset_no_sock(t, skb);
 			goto free_pkt;

-- 
2.47.3


