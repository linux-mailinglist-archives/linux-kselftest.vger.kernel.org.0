Return-Path: <linux-kselftest+bounces-47936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE90ECDAEA1
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 01:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2C173039774
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 00:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1084E21ABAC;
	Wed, 24 Dec 2025 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnXzcWtl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B71F9F7A
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Dec 2025 00:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536141; cv=none; b=Y7tB0RYY/a9TK6su2od/MOL3UbKcunEbxglcV3bKFjTJL0WpNBNU5kEdEGzdHnUBFCQaShgHCo0F6OhKHzcVM+i6VkULSebbvtDg+Vq0006Ss+iTXEct3QfJLnIAYp/DKh4xI6VhKrzj+Kf+kOSXDZokPod5L8avo16Kh8qk4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536141; c=relaxed/simple;
	bh=vD964Lj1wPSOw/16ssWykcRPX0KDwrhlz4wvw7+NTyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OsUI42s77baAXQa759P29wOtyHuXCPRCIcMgPjWS1WQDcKcQxQAOV/dFZ9+P+M2rtOGgulkCsdQ2ZJVbLUrQa5fqTRPecuco+hEQYLDEctj0WSVICLbifGWtaQ1g52qQKxCDHm13tavpGz7yHZjRDmzWEIYol2kw+idby3IEhnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnXzcWtl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso8610399b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 16:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536138; x=1767140938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=YnXzcWtl9Pl43vI8tnxEnoOGUMS7QaGspcRV0eAgN4pw2e7MarPyYCeaJ+/ndqjgoX
         vBSYXsiZeJHpmA5X0HGHHWpjdHSSTETBvBpGhGS1k39K5KZNeZJr0EkuvUv/iTJKF2ng
         tRxFjZxVLqgCeOZ1xHPJeVLetUq23uBhvl0idV01SaMqUYLW9u1S5t67wLm92I9P5KzH
         3eV3brW09Yh1fbTuoy+KxkCXGNO8cLVFBNGE78yhP/rJbsmGwUJ34xeikHlMwDZq//Gx
         81FFhA8/jmLRDVZsyVT/oqBnul/mBUh2pFZBzxxcQstS4aXR4fWLcMsUxT72tprT3YQk
         W9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536138; x=1767140938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=kyibgFyZ7OW5SPXBDsZo5xo6CqNqPMgm+1UCGkcfjmZfomxZ4TyweIWo7BJ7tatKyM
         +0SmWmOLG3n+ZAMrw7+l4C9bTYlNZG1PDsmN3ZG2h/T09nb/JVBnaFXv0LrHnV0dtZ9K
         aYTqaW6H2xAIxRfT30RxiAEekG/eU2JxXOyS/JdkewVj1g9oYkZZfKsKSlN22dzTOfX5
         kpgbcs1+b+nPU+8NjSdYznqOEw9yC1n+vVh17JCT4lXU80JRAzhcY6U8f+gkqypohgtw
         kBd0m/8HA3Kx8SQaNaJtFT/IXpnHoG+p2/P0qu9MOO0tvmKyGC9RZw/ieQlL2P3stUml
         JNlA==
X-Forwarded-Encrypted: i=1; AJvYcCVmqJEAb8YL8UwwCn5EPQLNL73cv3n1+2xLXpOV7u0WfuLHJEnqGMB0SjpWpkE5WHtqVPTNbvPAbAlf6lXUVqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYHlvXhmBT/67JdGhvGzzP6p9gQg52iOLsHJ3y33txLUeXup7V
	f4fsubW4m3ITmLt8hsssf6bj+nP4UhK1km4WOSfTjcXIsxdoFICN3bfl
X-Gm-Gg: AY/fxX6pbYcuwdT+sxOD0iLw7qq1I9i14axey6btNtKLKJy8aNS5Rq9ZC9sEfhLh8PA
	NkQOKkYLPfM/4ZOOwCSgCtVONaT7KLlMoWBXaZTMnaXlpVf39HHIJlnu4oRiJIoSC6jC3eT52j/
	6PiRTiK2sTz7DIH29VsDrb3ZH4mYNU20ux5/S0U2VW34jymrBep/nFgvq1O1iI+j0hk0ZMfaTCk
	x8Ybpt4kOx8aJsztcUGzWLErMLaM2RxIEgGrfveRHp7z8Nued9Jy4PI0UlDuclYDMgjEJQ7we2q
	oSDErEWo8CIAB6DZTnmdNldG698fn+qVAmQqvQCLFpktObV5PEjF3tRqCwrb8F4RjQ8pLwENAev
	b8SX/118Auxb+Cmud5bGRaGnMbvGLGrbd48VznL8fnSyUODS6FCU1eaNNkqlmxSUPqFWH4gJZlP
	gr2jkkZhzt12akPe9Bw2o=
X-Google-Smtp-Source: AGHT+IFdIc/UDuq+YWFWwYE+rGSg4T/7sFob5YN3Yow0dtG/wPBVPu2NKHMvyvYhCHAoi2nwyYlnEw==
X-Received: by 2002:a05:6a00:418a:b0:7e8:450c:619b with SMTP id d2e1a72fcca58-7ff66a6d701mr13217930b3a.50.1766536138262;
        Tue, 23 Dec 2025 16:28:58 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a93ab3csm14729340b3a.7.2025.12.23.16.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:28:57 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:37 -0800
Subject: [PATCH RFC net-next v13 03/13] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-3-9d6db8e7c80b@meta.com>
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

Associate reply packets with the sending socket. When vsock must reply
with an RST packet and there exists a sending socket (e.g., for
loopback), setting the skb owner to the socket correctly handles
reference counting between the skb and sk (i.e., the sk stays alive
until the skb is freed).

This allows the net namespace to be used for socket lookups for the
duration of the reply skb's lifetime, preventing race conditions between
the namespace lifecycle and vsock socket search using the namespace
pointer.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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
index fdb8f5b3fa60..718be9f33274 100644
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


