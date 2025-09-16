Return-Path: <linux-kselftest+bounces-41635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E87FBB7E3DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A251C0412F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 23:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB8A2F5302;
	Tue, 16 Sep 2025 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLNy5qKi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AEB2F39C1
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066240; cv=none; b=ZrHXFPJtHImJmJjG8v9uyanBWkKvBIbNQ6sRzDIZittIyNP5I7bf73attdu5kbNPTkA3qBtHENnHDk//C+d7h7OWXPUUoW8ODfnpXRTpUwBWJe3V/GV3zgcetzFhlbDKndzKViA5hMzNCk4Qn24y4xWEA3ySKNcLgTBqFusj+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066240; c=relaxed/simple;
	bh=9Wny9EveYUKuOodiYR//AaIkSgCmI3lCDOCST2vOIoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bRSMc4ToKhD6gt8NIMgjSRtw6ln5ORIq8UYIAJLmmoACV4Fq4o3IQziqUnA+7k11VMYziJwdFLpwtH8aQdfaY4Z9yi2phITMRyGnEUvTphGdJ/XjNlHJz5S2WJ6rn+cNESsfXaT6gt1Yu6mHUxNiSTTPXMIrBQ/vDZF9ufpvqNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLNy5qKi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-267fac63459so5079605ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 16:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066237; x=1758671037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xznpXjSPg14L8u6GPVNf9rVdoH0mv1cEtj7GXHqOaxM=;
        b=gLNy5qKixvDygboO/M8qQ0zHZJAdHwwntcYJdmg4aCnb5nu30Vph6f7mKvTeU6wdux
         BVCfrKfVZlZQNvIRFZ9aldxDb4EJztv8yKRT3skDroj4APXMI2Dp+tHLuGUdD1HdWqQA
         PXhGOasafU3Y5uCQEWknro263trHXduupzfLpg/OBD/5O3sSwipnfUIJYB2FD35sY6kp
         SUyez05tf7vY6jbq2f2vKQ6iPKhHHmRoEdoLOx1Z8JTfuhvzYVtySk9x2XdXsQU0XOYU
         LhVQbRUH+dkwF+Mp6hJ6eB8pjA9UHkEPz1nOT+8rJtu93+IK7bzU1uV7yH7kpkoGDPJy
         BO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066237; x=1758671037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xznpXjSPg14L8u6GPVNf9rVdoH0mv1cEtj7GXHqOaxM=;
        b=tcCGsTLPMVVO/L5ljpL1IpqTgQ0FImJY3XxRB6IwOG6N7RHxE31ymdRpFNidNLZWHX
         rfdjanHd8t0T6s2SL/A46jJziS5+FulYK6hFTqDCzTW44a9pnICOwvhEAjE3uxNmXFHn
         5640HOSK/IfWs9O1V6YBkmzkB7RKcwgId0t63X8970tHJ/R3uGZk9CjrrT9l5zOv5SWx
         yEKb1yp4s/LKhnDRqmWgf2Usocd/nF9gLR0AVwg26HR5kcRRR0CBWee25WBw/+doRc9H
         TEGx1IcCNbWFnXKTZlrlY9YusfBdGie0KmV8f5Rnkah1kw2dBk8P1oxrXuH74pISlhz7
         lyQg==
X-Forwarded-Encrypted: i=1; AJvYcCVLKPbIgTQP3UI3UuDmCnC065mmbp+Tgps9fiJVUCiSqBT8vOfLuSTrAY+soYt6KQXSCUFi0nUMCUQm08KN86s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMns+USSMV54udnRsfuUr/BNlPW9fcUwS9hVZxnWJUyNwHEQHe
	Lq650ECymgIysw6b0xDqMQ3i0+x8aUL2TzM3CIbZdNbbmennfQGJXbq1
X-Gm-Gg: ASbGncvED3tE4iLJggcI8BdbF8wA4hJW7njVict46hiRPOHt1zfWF+oFSjd1d18yRq6
	Ar+WSTaUS1uYDlGRi8BGpGw9F7MtlGHQl5OKu+o8tzEF2X9eFzRo23mBIVp7ALUj7HLxdjgkoCI
	aizcOfxpbeETFiGeGztK4iIapZfojhVjdUI6P2ROG5lwNzSwt+hRmlQFHPwT4vm8okCMZz2hI1g
	JNF/3nkWLlem3vFNrB17reLw/eIvDI/R68lUf5F0RUBoy7mo0pcCTTrzpOg95wDkn4dnL6vPfwm
	PnEWXK0tb+fg8oSBySqDCKC53CG7NDKLPm1jbU70XB1CXajNCL0fg3+kn5IWojDnuK46yEl7e8+
	wPkP0UXK2b3ISV5wT+qXPRzaPYW2PJ/4=
X-Google-Smtp-Source: AGHT+IGgEOkn91Dg5X4PgnpAYAK6sltdoKTmbUSmUOQXkvL2vD/GIGzT/HGBTqnu8s5A/IqxmQFqpw==
X-Received: by 2002:a17:902:e84f:b0:264:f3ed:ee2c with SMTP id d9443c01a7336-268119b2af4mr1220725ad.12.1758066237368;
        Tue, 16 Sep 2025 16:43:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267f4d286aesm14613895ad.63.2025.09.16.16.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:43:56 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 16 Sep 2025 16:43:48 -0700
Subject: [PATCH net-next v6 4/9] vsock/loopback: add netns support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-vsock-vmtest-v6-4-064d2eb0c89d@meta.com>
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

Add NS support to vsock loopback. Sockets in a global mode netns
communicate with each other, regardless of namespace. Sockets in a local
mode netns may only communicate with other sockets within the same
namespace.

Use pernet_ops to install a vsock_loopback for every namespace that is
created (to be used if local mode is enabled).

Retroactively call init/exit on every namespace when the vsock_loopback
module is loaded in order to initialize the per-ns device.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v6:
- init pernet ops for vsock_loopback module
- vsock_loopback: add space in struct to clarify lock protection
- do proper cleanup/unregister on vsock_loopback_exit()
- vsock_loopback: use virtio_vsock_skb_net()

Changes in v5:
- add callbacks code to avoid reverse dependency
- add logic for handling vsock_loopback setup for already existing
  namespaces
---
 include/net/af_vsock.h         |  1 +
 include/net/netns/vsock.h      |  6 +++
 net/vmw_vsock/vsock_loopback.c | 98 ++++++++++++++++++++++++++++++++++++++----
 3 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 628e35ae9d00..5180b7dbb6d6 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -320,4 +320,5 @@ static inline bool vsock_net_check_mode(struct vsock_sock *vsk, struct net *net,
 
 	return orig_net_mode == VSOCK_NET_MODE_GLOBAL && vsk->orig_net_mode == VSOCK_NET_MODE_GLOBAL;
 }
+
 #endif /* __AF_VSOCK_H__ */
diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
index d4593c0b8dc4..a32d546793a2 100644
--- a/include/net/netns/vsock.h
+++ b/include/net/netns/vsock.h
@@ -9,6 +9,8 @@ enum vsock_net_mode {
 	VSOCK_NET_MODE_LOCAL,
 };
 
+struct vsock_loopback;
+
 struct netns_vsock {
 	struct ctl_table_header *vsock_hdr;
 	spinlock_t lock;
@@ -16,5 +18,9 @@ struct netns_vsock {
 	/* protected by lock */
 	enum vsock_net_mode mode;
 	bool written;
+
+#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
+	struct vsock_loopback *loopback;
+#endif
 };
 #endif /* __NET_NET_NAMESPACE_VSOCK_H */
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 1b2fab73e0d0..134e0619de07 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -28,8 +28,16 @@ static u32 vsock_loopback_get_local_cid(void)
 
 static int vsock_loopback_send_pkt(struct sk_buff *skb)
 {
-	struct vsock_loopback *vsock = &the_vsock_loopback;
+	struct vsock_loopback *vsock;
 	int len = skb->len;
+	struct net *net;
+
+	net = virtio_vsock_skb_net(skb);
+
+	if (net && net->vsock.mode == VSOCK_NET_MODE_LOCAL)
+		vsock = net->vsock.loopback;
+	else
+		vsock = &the_vsock_loopback;
 
 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
 	queue_work(vsock->workqueue, &vsock->pkt_work);
@@ -134,27 +142,99 @@ static void vsock_loopback_work(struct work_struct *work)
 	}
 }
 
-static int __init vsock_loopback_init(void)
+static int vsock_loopback_init_vsock(struct vsock_loopback *vsock)
 {
-	struct vsock_loopback *vsock = &the_vsock_loopback;
-	int ret;
-
 	vsock->workqueue = alloc_workqueue("vsock-loopback", 0, 0);
 	if (!vsock->workqueue)
 		return -ENOMEM;
 
 	skb_queue_head_init(&vsock->pkt_queue);
 	INIT_WORK(&vsock->pkt_work, vsock_loopback_work);
+	return 0;
+}
+
+static void vsock_loopback_deinit_vsock(struct vsock_loopback *vsock)
+{
+	if (vsock->workqueue)
+		destroy_workqueue(vsock->workqueue);
+}
+
+static int vsock_loopback_init_net(struct net *net)
+{
+	if (WARN_ON_ONCE(net->vsock.loopback))
+		return 0;
+
+	net->vsock.loopback = kmalloc(sizeof(*net->vsock.loopback), GFP_KERNEL);
+	if (!net->vsock.loopback)
+		return -ENOMEM;
+
+	return vsock_loopback_init_vsock(net->vsock.loopback);
+}
+
+static void vsock_loopback_exit_net(struct net *net)
+{
+	if (net->vsock.loopback) {
+		vsock_loopback_deinit_vsock(net->vsock.loopback);
+		kfree(net->vsock.loopback);
+		net->vsock.loopback = NULL;
+	}
+}
+
+static void vsock_loopback_deinit_all(void)
+{
+	struct net *net;
+
+	down_read(&net_rwsem);
+	for_each_net(net)
+		vsock_loopback_exit_net(net);
+	up_read(&net_rwsem);
+}
+
+static struct pernet_operations vsock_loopback_net_ops = {
+	.init = vsock_loopback_init_net,
+	.exit = vsock_loopback_exit_net,
+};
+
+static int __init vsock_loopback_init(void)
+{
+	struct vsock_loopback *vsock = &the_vsock_loopback;
+	struct net *net;
+	int ret;
+
+	ret = vsock_loopback_init_vsock(vsock);
+	if (ret < 0)
+		return ret;
+
+	ret = register_pernet_subsys(&vsock_loopback_net_ops);
+	if (ret < 0)
+		goto out_deinit_vsock;
+
+	/* call callbacks on any net previously created */
+	down_read(&net_rwsem);
+	for_each_net(net) {
+		ret = vsock_loopback_init_net(net);
+		if (ret < 0)
+			break;
+	}
+	up_read(&net_rwsem);
+
+	/* undo any initializations that succeeded */
+	if (ret < 0)
+		goto out_deinit_pernet_vsock;
 
 	ret = vsock_core_register(&loopback_transport.transport,
 				  VSOCK_TRANSPORT_F_LOCAL);
 	if (ret)
-		goto out_wq;
+		goto out_deinit_pernet_vsock;
+
 
 	return 0;
 
-out_wq:
-	destroy_workqueue(vsock->workqueue);
+out_deinit_pernet_vsock:
+	vsock_loopback_deinit_all();
+	unregister_pernet_subsys(&vsock_loopback_net_ops);
+out_deinit_vsock:
+	vsock_loopback_deinit_vsock(vsock);
 	return ret;
 }
 
@@ -164,6 +244,8 @@ static void __exit vsock_loopback_exit(void)
 
 	vsock_core_unregister(&loopback_transport.transport);
 
+	vsock_loopback_deinit_all();
+
 	flush_work(&vsock->pkt_work);
 
 	virtio_vsock_skb_queue_purge(&vsock->pkt_queue);

-- 
2.47.3


