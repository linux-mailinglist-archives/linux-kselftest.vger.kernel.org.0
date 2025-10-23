Return-Path: <linux-kselftest+bounces-43949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31540C02F2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A9C19A7D05
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4CA34DB44;
	Thu, 23 Oct 2025 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYmKKNkB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E234C99A
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244095; cv=none; b=K/ASiYiHB3f0ESgQ1rCpE3nYvOvyVmZoM87GO7+HTW7+Zh0gyaxieDfsWFH0HqBgJsVOynLnXHaAOsnDqhb238LnmOS9nfwAx4E4RI3fKwoSoecpE1IdMZvf3LtK0hcOv9vTyZH9pcKfU//0AWVZQKqKVL08NyF8Nd2Sn0N6uT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244095; c=relaxed/simple;
	bh=2vOt3aqHsLlIKGuCeQI+QOWfaN9kYAWHryQIZjKv6ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KhV6/PPd6mTIp4zfAKN9XGAKXD7cMwJOYbGE1Ki2CXo2xJ9Dk6fwbmz6r/lYBKqGyS5K4LDvAvLipWYYB7X7UNUsnVodwkGZ35Zlz9IOf59iOAR5BNKZb8ZTr9ZCXrSR1Wi/Yn6vRBkyJeenjuwbNMDVOg8d6ioi/VqxdvaOG0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYmKKNkB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27ee41e074dso11541035ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244089; x=1761848889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOnGwOJEogF4rPu54JUeb1SIxyq0svOAnIcOq7OsOBA=;
        b=YYmKKNkBccxWrc8puz4bMInZ7NThXENnsok/JGjbVLPP0r8M06izo0ibpDAD4naTvF
         pmFwEsKRC6s4US6nNejOG08ZhA4/bv3jNDHiH7PAhB6e3eLK8R+dFW6BQpikST4RfM3K
         CrCS5RBe+z/NmiVaN1TSyCBeYGTUxPEOXN9ZvziMTAXJcZQUhx+QZr1cSZvW33DqpNfj
         3DpOiBsvjfHIHgVl5HoL6a3zG7RwaI3dsyL/t18L9TIkEreUYAr4X7S96QJPvU/DtOY/
         E5kqt9vLREJeUl2RdDkdIrHp9xbt8pDg9gJZqtvIWHbcE7HNcTncm0bDkyxbp2wxacNP
         RIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244089; x=1761848889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOnGwOJEogF4rPu54JUeb1SIxyq0svOAnIcOq7OsOBA=;
        b=gd01bauxfXiyU7jEHPuYF1OTYyG9UyHJUMpqt9pqbJosn0Fqpj4hxcT0erkTpd1/tK
         bP7z5GMPybTBa51A04K6VyDgThVEuCA7XCd4Bumd//M/VPTET75dDDbJs8izrrNBgBqG
         a/LoZ1Hopu4NDHHq0gfVZqxmHVrU2JE82P70GaBlE82DtupuB7K5qMqLjBN4qcSFIQH+
         +Ian0pDeCir4D1ThY/Ar56pcAxBu79+cQXTRDtY9L3fDeHHCJqPbSBltv5srjolYWi7W
         vktqAW6qUSpV1log0HSqqNs2qQl1QaP+Kp1EmGaL+XYdDfD5SAUDuG9NQW1EE+qUsWoV
         hfaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbLMpc53EXMqGXAME1wS7yTJC15KIFY1i4LgHQkQFnzunpxpVGaBGQvOUgc6SDjJyDe0EhGVyskaSNNp55PV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVKYGdjy9jNxTV7p+5gg6Ly2deaLACmoX/0zFOSIofwEtr+yKb
	KdYSpQus45z7ViSg4Sl1ttrxfIzt/IgSYHiF4TVzRsI5WyA/jXsYA0pW
X-Gm-Gg: ASbGncudkoUi3Uwff824YIXY8MmUX/FRiJ0mY1P5ZZqLarPeJoIT+ycnod8yuMd8FCX
	D+0X3+EyFs8+VRcBdO+Vux1her2GkuC3dEPopo9ZhjVvdOa/sll9KU2SDpTDLb3fkq5mPFvt0zX
	EqK0Os4GM8JLWkOYS7OROIfyCrg54SIrfX2qxyUFESM9+jsnXBg7dfLRPLLPb3XeBlUeGl1pJIn
	WhIleDsZicwJ3DyWY72hSq9/BlF1GDnPUqwzqrsTPup5kuDgFGsAGTHp/nKfCtQy+kr84TS1zQ9
	A+Awz8VM4Uo2NfKzxHtIop297ytVDHcoC28mpmDL3EqkjaGAKaB+MgHOY17NTAnc6fJpM1olCqO
	cqyi6d/rX3o2Mjuk3Jf65BPZj1JLfY3fdrcpwEBS75hZNx4F0DumtvBPV6DP+NJofMDGORXIr+W
	kcVb7Gkb/1
X-Google-Smtp-Source: AGHT+IFYpBBCCR720vuYSBRzPxT9Qu4/uM6zyCgPCDeVP26zw3QtdfGDA/4zRrKoUcEuv8sd3K898A==
X-Received: by 2002:a17:902:dad0:b0:24c:d0b3:3b20 with SMTP id d9443c01a7336-290ca12180emr327840225ad.37.1761244088774;
        Thu, 23 Oct 2025 11:28:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddec426sm30419245ad.34.2025.10.23.11.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:08 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:44 -0700
Subject: [PATCH net-next v8 05/14] vsock/loopback: add netns support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-5-dea984d02bb0@meta.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
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
X-Mailer: b4 0.14.3

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


