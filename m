Return-Path: <linux-kselftest+bounces-43700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E48ABF94D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1823C5E0719
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512E82D97B8;
	Tue, 21 Oct 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfqXNf4K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA0B2BEC22
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090428; cv=none; b=nkxLZ1qfX7Aa4kauMsqKNsOrC9s/PuK6oQv1V4l4pqJvD5eGFFbVsMoOqd6Udr3TrEa/a5DZCQm28o7Je5F5xOGPwvKzFCSHAQ/8sTKikuDKIpn1W5332v7se9KoxHij0KtzHk+yv8Ayaik7Jgv7pVIJSFF7fnePbfw9IePFJUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090428; c=relaxed/simple;
	bh=K7K94rKvWTIzHY+qdRUWp611m4kTE9R26xFksOdXz/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5dgAQ+DS8H5ZXwWi//d3ieqZgO+casG8ZZcIwR/fRh2hPEJNvxtc/KrccIJCvYaAsuKKfDW5A20VbXmZagoAr0gYdzGrBos2o8JqLgHvpMKIddAldH7KFS3kbWX1aZCYad67iv6YY9iNOhz5G5w5IHtASAxXbJgNfVV1wcvAvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfqXNf4K; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b58445361e8so347924a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090424; x=1761695224; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KJsmAxJEMJpeWSL0BwDVZk3RWnsnJFLrlQXVYpzX98=;
        b=XfqXNf4K6DI686KK23iYiyX0kIJtKB4wvPJ/TIN9rBi9ya9PkONLtXxdQAPVEDEsrz
         mLqwkp6H9Q1AcV/YWj8NL3c3NZkAZ6jyP1hj0jF82O+l+z4RX7msKgI/hEdlWC1fry7B
         LBMiU8gw+xVMzXR7OY7oGYxCUGL0EulWjdi8RQnRtC/Mf+M/7yAYX4BFtLM23T5TazdY
         eFDrmx8I4aXYByoH8zYM4bvffGuCVwPhCO7acsW+BcM34oGiTOtPWxdTSDkMjfNOMrK9
         HdJOfoUxg5eX10adH5C3BLQSXd+viu2da8zHG9vqn3r7WExhOgIEnDyN/DsIa11DDa9J
         5V1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090424; x=1761695224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KJsmAxJEMJpeWSL0BwDVZk3RWnsnJFLrlQXVYpzX98=;
        b=qwsBcs9fi6VDvb538rObr0FDkLFQSZEz+Ykmup8X0KNM0kxjbHYF0paGiCT9DzZXKx
         yLod3vKB6keicQwShbbEo1ToeDnxbwO4bO0qbHpwZfmUSs61ZDRcNRhNReMIzGO0O45/
         vxNNZOlLj/57sIJx2yvgbYCorFABB8LmK/kzHDQEtMrjQY6uqNIMpjrhlAhLB76uNK0E
         XxhWYXrzv/3G2GbM9vc0PTZbGsSWMwDrSdeXsReIh3ZfhN6jPU6khc8qX96fFVj2TdI5
         7yjH5I/uhRqGMu04TAplYBxfo9SUtnz5LS4m5pIS6akg8HMCo3yW/rlEmo9zc9+ClQyA
         tlcw==
X-Forwarded-Encrypted: i=1; AJvYcCU9qBsRF84WXYmq/cUZIdOu6HES3RRiltG91TaRSKUjY8IZLyXYDI4Z6FA+nQ6+BdaLUZzAO/oGiRY0DnIedvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlsliAMEDIiOOuKhudwOmczQ5atZZC3vaEZrmvvrhPlLpTOBaV
	jzQhyf9yrz7o68hiJdWOBHsUueA2B/m3f+VgCGFmyW58tjQRlvMoCNkd
X-Gm-Gg: ASbGncvC2pSIveJZvh8oU5C+ZSWjjIUQZq/AHlOVUAqeNKfMM2dXFe0X8WggOpCFXK/
	GhAqa+bMwExL6sey78M4cJtWq2zGRAX0QKuPE7SICu4ft4tToBS7s1Z2z3gYLgcBMbuGv9JOsU3
	bUcGGe5ZqcCrtbvEZu4k2swmlV0/FlidVsKtF+GVrGalkOhTBbn47xT+7WEwxrD7UiBMiaG9zQ+
	vqoGWLYgm9wnaYgJrf9zZcPVOPOV0hRx80G6FdNi4f1xNX3ExfoClUTBzlxIBG94p4eQG+D0Fsn
	Q4tjmgHPT0i1EZ7WeGV6vGtjA//6Zz0BNWkaPVarq6OaR75TbRfY1Aec5RyiFJsD0ANPP6joCT7
	Xdf/lt+jJ1u1/gp7p+cwie3F21OKEis1EIqCc3VO0NVcte78aBUQ1keV8FWm2qEJu4Yi4zrMPyg
	==
X-Google-Smtp-Source: AGHT+IFCrufQGCbNqmEJ7tzIn5lW6dCh+SlfvQIPR+toK95JiZPUcURBDL/+GeryRebw/OetDSF4kg==
X-Received: by 2002:a17:903:249:b0:267:44e6:11d6 with SMTP id d9443c01a7336-292ffba4632mr17882415ad.6.1761090423876;
        Tue, 21 Oct 2025 16:47:03 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcf06sm121037085ad.24.2025.10.21.16.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:03 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:48 -0700
Subject: [PATCH net-next v7 05/26] vsock/loopback: add netns support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-5-0661b7b6f081@meta.com>
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
Changes in v7:
- drop for_each_net() init/exit, drop net_rwsem, the pernet registration
  handles this automatically and race-free
- flush workqueue before destruction, purge pkt list
- remember net_mode instead of current net mode
- keep space after INIT_WORK()
- change vsock_loopback in netns_vsock to ->priv void ptr
- rename `orig_net_mode` to `net_mode`
- remove useless comment
- protect `register_pernet_subsys()` with `net_rwsem`
- do cleanup before releasing `net_rwsem` when failure happens
- call `unregister_pernet_subsys()` in `vsock_loopback_exit()`
- call `vsock_loopback_deinit_vsock()` in `vsock_loopback_exit()`

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
 include/net/netns/vsock.h      |  2 +
 net/vmw_vsock/vsock_loopback.c | 85 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
index c9a438ad52f2..9d0d8e2fbc37 100644
--- a/include/net/netns/vsock.h
+++ b/include/net/netns/vsock.h
@@ -16,5 +16,7 @@ struct netns_vsock {
 	/* protected by lock */
 	enum vsock_net_mode mode;
 	bool mode_locked;
+
+	void *priv;
 };
 #endif /* __NET_NET_NAMESPACE_VSOCK_H */
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index a8f218f0c5a3..474083d4cfcb 100644
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
+	if (virtio_vsock_skb_net_mode(skb) == VSOCK_NET_MODE_LOCAL)
+		vsock = (struct vsock_loopback *)net->vsock.priv;
+	else
+		vsock = &the_vsock_loopback;
 
 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
 	queue_work(vsock->workqueue, &vsock->pkt_work);
@@ -134,11 +142,8 @@ static void vsock_loopback_work(struct work_struct *work)
 	}
 }
 
-static int __init vsock_loopback_init(void)
+static int vsock_loopback_init_vsock(struct vsock_loopback *vsock)
 {
-	struct vsock_loopback *vsock = &the_vsock_loopback;
-	int ret;
-
 	vsock->workqueue = alloc_workqueue("vsock-loopback", WQ_PERCPU, 0);
 	if (!vsock->workqueue)
 		return -ENOMEM;
@@ -146,15 +151,73 @@ static int __init vsock_loopback_init(void)
 	skb_queue_head_init(&vsock->pkt_queue);
 	INIT_WORK(&vsock->pkt_work, vsock_loopback_work);
 
+	return 0;
+}
+
+static void vsock_loopback_deinit_vsock(struct vsock_loopback *vsock)
+{
+	if (vsock->workqueue) {
+		flush_work(&vsock->pkt_work);
+		virtio_vsock_skb_queue_purge(&vsock->pkt_queue);
+		destroy_workqueue(vsock->workqueue);
+		vsock->workqueue = NULL;
+	}
+}
+
+static int vsock_loopback_init_net(struct net *net)
+{
+	int ret;
+
+	net->vsock.priv = kzalloc(sizeof(struct vsock_loopback), GFP_KERNEL);
+	if (!net->vsock.priv)
+		return -ENOMEM;
+
+	ret = vsock_loopback_init_vsock((struct vsock_loopback *)net->vsock.priv);
+	if (ret < 0) {
+		kfree(net->vsock.priv);
+		net->vsock.priv = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static void vsock_loopback_exit_net(struct net *net)
+{
+	vsock_loopback_deinit_vsock(net->vsock.priv);
+	kfree(net->vsock.priv);
+	net->vsock.priv = NULL;
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
 	ret = vsock_core_register(&loopback_transport.transport,
 				  VSOCK_TRANSPORT_F_LOCAL);
 	if (ret)
-		goto out_wq;
+		goto out_unregister_pernet_subsys;
 
 	return 0;
 
-out_wq:
-	destroy_workqueue(vsock->workqueue);
+out_unregister_pernet_subsys:
+	unregister_pernet_subsys(&vsock_loopback_net_ops);
+out_deinit_vsock:
+	vsock_loopback_deinit_vsock(vsock);
 	return ret;
 }
 
@@ -164,11 +227,9 @@ static void __exit vsock_loopback_exit(void)
 
 	vsock_core_unregister(&loopback_transport.transport);
 
-	flush_work(&vsock->pkt_work);
-
-	virtio_vsock_skb_queue_purge(&vsock->pkt_queue);
+	unregister_pernet_subsys(&vsock_loopback_net_ops);
 
-	destroy_workqueue(vsock->workqueue);
+	vsock_loopback_deinit_vsock(vsock);
 }
 
 module_init(vsock_loopback_init);

-- 
2.47.3


