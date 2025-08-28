Return-Path: <linux-kselftest+bounces-40126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1643AB38FF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 02:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A1E1B28B0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE897221F1C;
	Thu, 28 Aug 2025 00:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2fUZxqa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36B286344;
	Thu, 28 Aug 2025 00:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341103; cv=none; b=AhHmc76qU/2cb9GJ4P3zIw9yzaHumLiRKVGdlZuQ9lUIiEse7RWPEqVi3RmC02gDAn5iw09YUZPqSXsaHT0EM9O1b32rvjgOdSp1I01VyxirApwu5EN5aiTBdDaVpIFoFTWj18FQxRV7HFdGi6IQJ/eW8h/wc1YDzfeQVyTGRFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341103; c=relaxed/simple;
	bh=XcqxKWbcR9R+GFEDVaS469hmzOI/5gU8TKoZ33SLMAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ikpFBx0UHyeKxZkpkUBLx6UatHAxqyOcvJlcvKTF1QRhJlhLlYJoJo0Js7BKB9Mb+vLQ92G8ef7NibwNio7tx0Nm9T7eDDG5mnkoPxCrJT5KWy3VsLxJE3GctwjfHzwqM/JuQJcmLhbJQJ8pAUBYlOtSBEndbw12YTw8Q55G+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2fUZxqa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445805aa2eso3899935ad.1;
        Wed, 27 Aug 2025 17:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341101; x=1756945901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNMRyhXc58NJQADKxcGV3IzP2b9a+EmxeUKj/JoKFFQ=;
        b=J2fUZxqaMFPm9bM1qszbCewCQwmEXwxxWzYIoMMFltClMBJRcVeHCHGnh+zs0RGFKi
         WwTQVnUxThCHyp3EBEGNdfg+D1/43tqAP8gY4wZNqRNJdSTEM4ACsWkSV8MHWcMeTRep
         301/dhai2pOf7eHUR2UJ+L0TdV1Au2h1AgSxOAgQU34jVkbQoCp+AlH6d40RmorVR92X
         Oowf7IT4MIOVPv9bnwtn4p+8/Ps8aZg5zqT8KU/0pB0jGWF86f4GJluaQ3EkQ5cVtJvp
         UupNtqqkZi6+j257FpZw20+QzLdHlbBiH4pAE8dTL6dd09r5a9i56mlRE42EZXoGhsXJ
         diAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341101; x=1756945901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNMRyhXc58NJQADKxcGV3IzP2b9a+EmxeUKj/JoKFFQ=;
        b=ix1Ci77/CIb2n7DX52lV/L2Qdxfta3a3Ewt5xJYG2n+Jgi7B2FLXeB21dB4hI4Ib1K
         UTmDLzYHKEoNIJxmF9T3Ot/GP+q3j7N4tHTrfWBideG8QOOaon/xVm9+uAPEyD9O/NZH
         b+wGHal6JaJdtMfdp6K1rshBJQy8vJrsptXi+TiFbEsCbn+rqZJ/efQ+Zv3YXbIu2UU7
         /pWjdB6zrLCt92DP14fhHW0Rsf6o41z9Ce6qvl1Uef9qUzEkXbtdh5v0LegdHJZh2Sj5
         h3zmJDKGDH5Vl1y3h1AL54lwBQIexbKVPrDNfMp2OJBLhPmWIr0gFuvKFUndoPWIgowD
         uZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Ox+nVMaiEA2NKfMuTLORBycx37l8G5SFlkpYacWK8jKkYeB7RJc1IQ3w/B//KPL3UI06pFTJ7Zw+7ngPrHzB@vger.kernel.org, AJvYcCUJ6zJLOykZofNMMP2irdVP2iS/MNSpb+NUk7fJqWXJNg1iKUYTMvVXDyTKHsNuRJyq0Mh+Hq+dB8PLOvYt@vger.kernel.org, AJvYcCVatihEfsjI6usrBw1fd/Rz0kD3FZULWSr1dORsPDNrivdt6hcUOkGdE8KtpSZjjBZMV2CtEOyjzSE/2Z7R@vger.kernel.org, AJvYcCVjskY0FLwEC32GqxXvWF+cgsrpZc+IQZjr9+4AeClC1yXYv2udl1e9FlbIYBJy8tUYbPmHX4V6@vger.kernel.org, AJvYcCXEiwdMEJYvV9lgVmyL6/smb2kbuDMnOH+uGzBzpDDPSmXIE94dsMUnjE0ib2NLKNVMdXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5D8V0ayCZIQvUNERebS0e7mNQr8mK9QCZdqvjrbhyvQxUHznN
	TMaPCK8AdTpGpHqOlrIUF01l3CcjJN4G7jtMv4tlc0VO9GIsi8sbqinf
X-Gm-Gg: ASbGncsKs3wdE5OUxWwWul1jlBcPmPDqYSBw17hyvLYqaN+rutFFTRR5wKYTs6EORyd
	k10+jQz3bLDqnjpwTK7aFkLjyn/tsidenKBZNO40u5x1k2rVX70suN/9vA9QPfKnQDyXKnjwB9e
	2AhsO4uMTj4TYKwuxvAg7/B0ROXbLSY5UCIfEZyOmPzoyVvk/YkARqPYpIp8nMjiLMTufYkQkZD
	l/gYzpHBPmqPRnE0y+GdsXRHasO8sAsjzWo+ENjV8FNSckrtLErS7kb+zOcoCGCdfPtPUzxkcNg
	l7kI7EgauIr+6lxlQ80xzmwPBOTgGksoICGKmUMnku50RExJKy8o6OK0E2+AS0P0jH0abxJ59CA
	llVr7yVrJU9kTQQCWKZ1QhATJ7WMpcLc=
X-Google-Smtp-Source: AGHT+IFjSJ3lNQyXihNLyzpDRLaKGYXU6ozW/kmFwiBYAHcnoyr5/NLuHTzQ3rWReb04ry+yDvDZSA==
X-Received: by 2002:a17:903:1ae4:b0:245:f7f3:6760 with SMTP id d9443c01a7336-2462efb1aa9mr236094525ad.55.1756341100823;
        Wed, 27 Aug 2025 17:31:40 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668880260sm132633545ad.128.2025.08.27.17.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 17:31:39 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 27 Aug 2025 17:31:33 -0700
Subject: [PATCH net-next v5 5/9] vsock/virtio: add netns to virtio
 transport common
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-vsock-vmtest-v5-5-0ba580bede5b@meta.com>
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

Add support to the virtio-vsock common code for passing around net
namespace pointers (tx and rx). The series still requires vhost/virtio
transport support to be added by future patches.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport_common.c | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index c547cda7196b..ce6d15eede9c 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -184,6 +184,7 @@ struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
+	struct net *net;
 	u32 pkt_len;
 	u16 type;
 	u16 op;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9b3aa4f0395d..7b566c8f8082 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -314,6 +314,8 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 					 info->flags,
 					 zcopy);
 
+	virtio_vsock_skb_set_net(skb, info->net);
+
 	return skb;
 out:
 	kfree_skb(skb);
@@ -525,6 +527,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1065,6 +1068,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_REQUEST,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1080,6 +1084,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 			 (mode & SEND_SHUTDOWN ?
 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1106,6 +1111,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 		.msg = msg,
 		.pkt_len = len,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1143,6 +1149,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.reply = !!skb,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
@@ -1163,6 +1170,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+		.net = virtio_vsock_skb_net(skb),
 	};
 	struct sk_buff *reply;
 
@@ -1463,6 +1471,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 		.remote_port = le32_to_cpu(hdr->src_port),
 		.reply = true,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1577,6 +1586,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct net *net = virtio_vsock_skb_net(skb);
 	struct sockaddr_vm src, dst;
 	struct vsock_sock *vsk;
 	struct sock *sk;
@@ -1604,9 +1614,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket(&src, &dst, vsock_global_dummy_net());
+	sk = vsock_find_connected_socket(&src, &dst, net);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst, vsock_global_dummy_net());
+		sk = vsock_find_bound_socket(&dst, net);
 		if (!sk) {
 			(void)virtio_transport_reset_no_sock(t, skb);
 			goto free_pkt;

-- 
2.47.3


