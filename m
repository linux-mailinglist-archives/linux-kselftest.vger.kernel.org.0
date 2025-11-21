Return-Path: <linux-kselftest+bounces-46186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E14DC776AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 06:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3AC1A35E723
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 05:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9BA2FB97A;
	Fri, 21 Nov 2025 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXufHc81"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC652F6920
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703897; cv=none; b=V5Ji8zaX2lZfwe6C7JITZeWY/J/dhrVe+3YvaZBY8eIJ0KwQ9Todshj8+C61ZHDtZGdqNrxZ8u8fxPOoNH6f7m4PeEe1P65WMunwjxH1hzulJk+uxrr0iHYPQByYBlnVU2GionfbtTCXzG5PRzuySZcFPRVYEQtCPpIozuznaYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703897; c=relaxed/simple;
	bh=fsBBb11rRzR4Q5pi4KL2AyZQEMokJCJhZHnuBGJ1xhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r2vA0rgLiTpnqOPoZf37xdQM3ki4UrHIlZQBCKylImD4xPjpYu3xGOlYay+0X06Wj+7VViewUOacpe18N+qhd+UnNba3TBy64s8yrvWr/+d83fatXZ0Wl+y2awXQA1rVg6wXv4AJ7KVnkfT5Zv+TKadcAZdLd8FMk7hXv8JKNp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXufHc81; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297dc3e299bso17335265ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 21:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703895; x=1764308695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eC15iyYiDR+Sm1hgPKilCqyF6DXQAH/mQRgGwIW2dVA=;
        b=MXufHc81htKDHR7hx8nYgiZlT38+9IgO7C4G60UdU10UUhHbf52nM8xsEDkWKCBpXb
         V64BVPkWwlazJqRjDdgCrTU5Y5azVDuXb5NKbB6xFYRJZyyN2KLWy4UwZq2x3m0vvZFv
         FkxAANDMxYd/cX+Ii9bZbVczvZu2mmuAPPk16ZcvuESlysO1/8c88waTD7HrFlX0VQvN
         wRriWddBaOh9akp8C3IIvbPsN/sZj7UxM4Hv+LD6y1fdDh8nc2OMMNvGZhS5JWCD7F01
         Y8wc7K51GjxvujTsz8tt9wFRdfOLeXo2Ga9k/fSrdt9SUkhb1BL64WmtDpvzHDps23VQ
         1L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703895; x=1764308695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eC15iyYiDR+Sm1hgPKilCqyF6DXQAH/mQRgGwIW2dVA=;
        b=d27JABiUxXWmRK1Q0rT98EM1A92ZmRfbXj7X1op/K3Lq+Nd0SNrrbRqXOVUqJi4+Pk
         4/GPAEWYDgxJp0If3ZE4c8X05UFuYKBdxgBVoYIyTq+liwyQL4mITF03RDUnu7YZRjRe
         0XnVTly4tAVoQ5JchLOPaG8SILu481OQVSHBVyLYiwonYE28vPnwTznNiPAPpBqz/Y+q
         McZNmxift4cymZNFyssvFCw9RlhTP5hHq7S7gjYiMZv75eIdyLA3mggwLvd6c72Ha676
         ugfnjV9GhAk2V7nddtZ37yXm+IGU5v1AnYWAJS0n58Q2rDPud4qOUtReYpZbX1AMIwkj
         /T3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxXFuqMkZWdocdU7amQTVZ7Sz8OtcbVnDAAoVoJVAGMAP+7SK5pNpsANSMutT+EvTp+w9GyeArY0WCQ8bat+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGbOE6CoFfMl/oIeOpSG7aLkSsnlR7W/ESg6Jfhp9hrgi2SqT
	gpxzIf3hdSfzkg42qE2FADZhZVCuCkrjhcKhZc7LKPm1NOJBQNFZrTN0
X-Gm-Gg: ASbGncuV4d+DmfAt7r+THT7xhOn+528moqCq9Qb9T08G+cXYXA5JfEnKe8GT6yPBQnx
	fa7YuvPtEmDluKPmS+wo1gwwG+YrITQkz5jZzft+cTUYfYuRivKkzZYAJMXsxbMx+Bl3Z4tU92x
	DMctiSIxB7d2Ovu/6Y3kot3QzT6LhDJRi/7RvlexzwrIZuP2aKh1BvU/LF3AiDlFaI1bwvofILw
	gd5CnroCJaeST4jgRLdR3DBaJeqq48cpP+bHNtUHy62CCmJWUqijszp+XdVO9583cemEjlbcsdR
	Jw5tt6XCpdOS5Sd0GCoRE6tuqGIfD6suRc/QR1NUmgwyiCOPQjOWSF+qUKOCazC6UfVuoYrBwIS
	CmtgCQuv7X3CjGvP9abvDSg7QfAAZ1gCV6QFbp0uQZ9mhVZGH71giGCWkBY03+RYs/edoD7BbbM
	yKgjNWEuBG9kuK6Y/7
X-Google-Smtp-Source: AGHT+IGa+OjNw6ZNUabNVrbiRm1cN34zeqSyarDkZ/uyC1wiDWIlKAxvnZ18+6IgwXZkACrQhhBeIQ==
X-Received: by 2002:a17:903:2acc:b0:298:efa:511f with SMTP id d9443c01a7336-29b6bf3bc9emr17507735ad.39.1763703894492;
        Thu, 20 Nov 2025 21:44:54 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13a870sm44383905ad.34.2025.11.20.21.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:44:54 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:36 -0800
Subject: [PATCH net-next v11 04/13] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-4-55cbc80249a7@meta.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
In-Reply-To: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
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

Associate reply packets with the sending socket. When vsock must reply
with an RST packet and there exists a sending socket (e.g., for
loopback), setting the skb owner to the socket correctly handles
reference counting between the skb and sk (i.e., the sk stays alive
until the skb is freed).

This allows the net namespace to be used for socket lookups for the
duration of the reply skb's lifetime, preventing race conditions between
the namespace lifecycle and vsock socket search using the namespace
pointer.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- move before adding to netns support (Stefano)

Changes in v10:
- break this out into its own patch for easy revert (Stefano)
---
 net/vmw_vsock/virtio_transport_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e..675eb9d83549 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1165,6 +1165,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+
+		/* Set sk owner to socket we are replying to (may be NULL for
+		 * non-loopback). This keeps a reference to the sock and
+		 * sock_net(sk) until the reply skb is freed.
+		 */
+		.vsk = vsock_sk(skb->sk),
 	};
 	struct sk_buff *reply;
 

-- 
2.47.3


