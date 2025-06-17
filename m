Return-Path: <linux-kselftest+bounces-35170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F582ADC0C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 06:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A6E87A995A
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5847256C81;
	Tue, 17 Jun 2025 04:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGq1VRcG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4B25486B;
	Tue, 17 Jun 2025 04:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134785; cv=none; b=ji/gml0Qm5/Z/6nxAH7Dkp9C3DtqW3nzDPaAlweW0b+JTNGn4Tvt+CvKQ4B7fxxAr3MDDXjGBs/hboku9TkYCYciePE2jz6FvnfIIkWhAI2xcQxLhAlBh5sKXPoOzIxdZabCyC3TiXb1GJC2cemp+dpbdcYMtrXSD5f3PU2dp/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134785; c=relaxed/simple;
	bh=rWN+0kzz66BwYpbXVApft3NajZyjUkLvELDV5jgoh9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CNktMfZ/70dCBCnMpAP01VMcJLnc7IGIDIMB1/VHeQgIYzwBaSTmui2GHeYwbWuLs3Rc+Vm84LRN4/sauUdODCPcsRUHflRRWHTF0Fz0342Mw83PL9DYwLEUEG8zids98rf2iZ83oM2tHNdqBRVEeXsnhcz+TsSqpdLrDUwTWJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGq1VRcG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234bfe37cccso66827575ad.0;
        Mon, 16 Jun 2025 21:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134782; x=1750739582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LclXjvFFmEwW0GFpupYPppfQlsjXKq5ckw5t+NfgedU=;
        b=SGq1VRcGGrGai3J2m0H4gj9ibeVi96xeFqFBHvesMLp3B/qPn/+44Z+giVWn4TDFoj
         RapwXpDJ86Le7iL3O8out8saWUygrYDOXGtvLR44YLJnQ5KpCaRIyuLMf2O9o75XV3fB
         FXmwX4RADSFI8vG1ZKujNdbsu8G5LZJ1Ocim7hgjEzrhQOHnF0KKR6tsdpYcVZgWxDrh
         CPHdX8YVMzaXMieamUs++EK4LVMeKAnbDIYSNvPmyTpVPDIfNkHS1GcD9jeimQaLwECa
         jmt0MtrXCr4VXmcz0At9qZC/7xG0Zlwxln7nCOPXFRAZbv85kmfwVITfl3Mg+/j3O4aM
         kroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134782; x=1750739582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LclXjvFFmEwW0GFpupYPppfQlsjXKq5ckw5t+NfgedU=;
        b=m+wXS4Uk6wTtV/rxyFtGpHK8KpbtRU5oqSy1KDJi2Qt8Bl/dMbFHACmWHZF1wZKSja
         E1L5xKiXp5cTUxUW2BP+Xh58kxoUUjkdz+/uvHF5zHXc0+zAT9MQ7AOyb95ESprp9/y+
         PekLT2D3IpMBoE/hSMqc79a35mn1A7L5sBzIsYSSHvnFJHwtZc+9f7Ob02Ul/2zl/RhK
         HPGgoETL+FXF3qnB/Z3JyDkrOM3DPJBWpaTEGNUr+75nqXO7bYWehEgjSbOKXi/L4JS6
         vLi4EzNOxW0hfshfD5pKJVJ4D7TyLKujohOvGSi5vDVNHYtOjGLHpnTkz7OKQMOYdzd/
         E7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVhfHfncZymVH1pPwOlxQNvk211n0INw8Mvq1V3F3Y+SQgGYzzhxdbT4Ta4Ky4IaZey6gQuB6UPoLD8y4blKa0k@vger.kernel.org, AJvYcCW1TdBRUvem8i8Kq7emwZzqF1X6fERVYQzERQwntBUmD47+ihF8p3Qqr/henSJHTPy86CetxHCrsYwpESo=@vger.kernel.org, AJvYcCWbCxhACVqRxnAJzQSAvNJbIj0VqzZTRxClppjc1on+nfirzZLxIuyfzSulshJYaGxfG5NMIgRb@vger.kernel.org
X-Gm-Message-State: AOJu0YxrOZF169EZXKdccMxuWeOUrL/KFqW54Ex1MrB4s5INt+abPtd6
	j+mQuh9ujYrv7+jBkDuQqNLkQhhpfK+eBUUETrVinI4Lefo3RbBichJ3eBI6Nt24
X-Gm-Gg: ASbGnctGx9oq4W4Lr+qATA2oTPENiriGW4bc2R1JmBm246Z+b0KReCvp2MvZN85zBjF
	9b/MriMxst5OR6r4P3SmVC1yVwOsF0KO1OM23Hg1L1VfwA2r+NhsX9Sg+1G/5ZsqSmNDbxPoe+8
	RpoltT/PE/dW/4NqExzfr7CNYH1znDbODr9ZiVWWaf+c+3fXlngEhHUeoWhd/wa5TW1VFEnxXO2
	Wv3Erw6O9kL2sxr7mCT1iLpMdEEwM0r617LkDFNlP/bLsf8LZY8Q+G5AbLdNU+uuDqqV5f7JWaf
	wyZ/72+cQ/4HQHXYX1RFblLEoOh65suNyFRWvdPtR/LTTp9VhQo+McyaIwQ7mh8hoSI3VKs=
X-Google-Smtp-Source: AGHT+IFfHIKMTehJBbHbzXm+VgitB5C8K3/zKbjZaoAyzCeAaD3PR/+OGHYbSxWh4cZBh7ugMRypPw==
X-Received: by 2002:a17:902:ce8d:b0:235:f3df:bbff with SMTP id d9443c01a7336-2366b00163dmr182222645ad.4.1750134782256;
        Mon, 16 Jun 2025 21:33:02 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313fcae18e1sm1521189a91.0.2025.06.16.21.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:33:01 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:55 -0700
Subject: [PATCH RFC net-next v4 06/11] virtio-vsock: add netns to common
 code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-6-bdd1659c33fb@meta.com>
References: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
In-Reply-To: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add support to the virtio common code for passing around net namespace
pointers (tx and rx). The series still requires non-common transport
support to be added by future patches.

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
2.47.1


