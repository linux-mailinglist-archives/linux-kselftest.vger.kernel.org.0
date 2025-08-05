Return-Path: <linux-kselftest+bounces-38337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C21B1BC14
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 23:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9761D7AF251
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41BF2BE627;
	Tue,  5 Aug 2025 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRVTfOw4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181452BDC1C;
	Tue,  5 Aug 2025 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430569; cv=none; b=gZ3F42yZVXEFDktfKxOVeAkTdt4GzKAjUWfU3l1XSPPmIdOILmFnzm9BT1UgCP+yUfZ4kszIERfnP0zi2wEaWDMlha3fl/7pM84Y6ylu8UrdzX9zJcIuVHfH+pogckE8we9kMjBuykGteTqeJcnr99AJUQ1mcHEG+nTGyFFth+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430569; c=relaxed/simple;
	bh=yE/DV+Fa+l53UFcKqQnpm7tvRiqGrYmy2+67mIwjIOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mt9vTPvXVYHDPhCI5YPBW4mSvQ+w7BMVmhvoMpSBq4HvknQ4FXhnnSV12mIXhcf/t318tQNE00nTdzGJJ24YX4mlulVNeCig2wbefsK599baKZ3IjY29Rvx0D9NDoJ/+NmMBeO/aAoHr/0uQ1i5y6qXg5teAzWWQzfxIwP/qG3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRVTfOw4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31f02b6cd37so4960706a91.1;
        Tue, 05 Aug 2025 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430567; x=1755035367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YF1xl+BFznimsCJZAMsIsfYFMKtmpYiJtkLDu4zq/fg=;
        b=mRVTfOw44LKiqU2TD9y7c3tsxtfhaxoZ/qqNlPlj9AeGgIVo1sKxqe0BC29lR6ahTi
         QDVVNOrzp5WEhct4594mM79tWf9ncjECv5kjvVd43zNxJa3o/Xz7SULwmE6XsmesN2jh
         MTWek/Rgf+htm4wYyPJpmc3rmTltoj1SYdFEQzIdkuMaTYF8FhpSjr1whmwLhxMAHN93
         L49Exfu4vLL0a/Mrlv3fpbJbSX85DS7LwSZiGSvhFwGvnyIE9rQFE88hDKNSOVqKxCd3
         FjcBqb2GvFto6oz+D1VOop+8NLSd2LHIY9CZJFc2Vls25kN3DsiliBWao10h6TNfqHEf
         RWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430567; x=1755035367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YF1xl+BFznimsCJZAMsIsfYFMKtmpYiJtkLDu4zq/fg=;
        b=L+8cbGTjt4D/kBkOUiEXXAooPsvZh9sZaDBdTMIb+ytwTqk39cAj7IgF4/b93qI6Rp
         2rZKIj0zwbwuOzToQc5H+zGnUg9xpnsoI1e1vxnYVjDhdSekJnQorDwED1MAaDB173xe
         K3HHsWm83bRnlFmd5jRY8ZIPHgSEXzB9LiiNQww4JVkCCB+Ux0RG6Cxm/NovEavidMZ+
         xaCWvUzm0tMrJtll9NyhsSerzHqsnl4W9EU+sSiViWiFBzYtpsse2h9a+WdYvWhXkTK3
         JKR7IboryfthvRRgAn/pcNTF7QtlsW1a6LT143a/ddg2jYsGtkjxgJSbzPdFc+06NZER
         Mx8g==
X-Forwarded-Encrypted: i=1; AJvYcCUXQYknJLz7shgQZTOQ2N0sbIKKYXE+kd5hTmgLZUQYm1yv4TYynWXXCegHejnaQ3nuEno3OD8S@vger.kernel.org, AJvYcCVJmEG055sTbGoT0+EInXJ5NlV0MGLOYQkyfg6lE0YBtmnvKW+uLw0g36W18XFIqMxoYnxpOOtei95gVJI+@vger.kernel.org, AJvYcCVKumO4wco1BwwlDAO+IlNwrYhWVcL82Ktt8uL5PwUJlFb5C2cVjsM5AGoSAFXRcpI8rNnGfwoKbhegY4ztDMhg@vger.kernel.org, AJvYcCVQyYblhuYyYFBwqF+u6R+egUJSllezhpZZ4IWd9Uy4hxBiNacnIy4xUW6wQ5jma/3dbT/jP9vMTHH/QvDZ@vger.kernel.org, AJvYcCXQRPKIlUHWIZcqFPsvBImZlEIer95tKNiZTPKu8BmHuBwUwgK/shKGPqmdDXRyMzkOuzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVSCuNGObShXgWLB75Ui/QWEILIbJYOzhq1xHQsQAvFvcwe9uW
	1g8frKcfRojvsADYcOI9JmAxpODrT07W2i2eViiWVXXQpbrOLh5X11Xm
X-Gm-Gg: ASbGnctK9du2EALmsGtX2tkDqd6sOHoz2SkbrW2noiXXtCqgu0gu5tgG4zBth234acD
	5lq2Vn0qNxRTsOR+jkidFMvSym1iNNCq579M88yD2bJ+RiF3GsdtiEq4JosDaRt1Dit5DmBEpU0
	KBhxLN9cGbmqTnJcSyH3A+T0/yWxTwxP+bsRmDgMG3coKxnCQYvmn4Gj3Rwe9/vcps+zxN8X4+K
	tZBDjp8floLiIUaLDDZ7jqmAUarElinV29uLE1p6nUeNxBAm1LeXKdHx9skEfA2IdM8RNY/T29G
	oe3bJfTRc/19qHwpTKll0C86bYgsRDpj29pn78rz+ELhnah1DbLXzmnjptYC7vO4llcKL06CwSM
	S/rK66he7ekME2aQxarqNIqNL9t/syw==
X-Google-Smtp-Source: AGHT+IHCmjITq2EcgeFufDBMLSAU8t8naXO7KFWocNSlYPDmL+mvWgkr7b7AJS9sPJlmK72xrdsQOg==
X-Received: by 2002:a17:90b:4b:b0:31f:1db2:69b1 with SMTP id 98e67ed59e1d1-32167552daamr393375a91.18.1754430567204;
        Tue, 05 Aug 2025 14:49:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da5719sm17878352a91.6.2025.08.05.14.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:26 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:17 -0700
Subject: [PATCH RFC net-next v4 09/12] vsock/loopback: add netns support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-9-059ec51ab111@meta.com>
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

Add NS support to vsock loopback. Sockets in a global mode netns
communicate with each other, regardless of namespace. Sockets in a local
mode netns may only communicate with other sockets within the same
namespace.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/af_vsock.h         |  4 +++
 include/net/netns/vsock.h      |  3 +++
 net/vmw_vsock/af_vsock.c       |  8 +++++-
 net/vmw_vsock/vsock_loopback.c | 59 +++++++++++++++++++++++++++++++++++-------
 4 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 0c0c351394de..aefff6e102e7 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -305,4 +305,8 @@ static inline bool vsock_net_check_mode(struct net *n1, struct net *n2)
 	       (vsock_net_mode(n1) == VSOCK_NET_MODE_GLOBAL &&
 		vsock_net_mode(n2) == VSOCK_NET_MODE_GLOBAL);
 }
+
+int vsock_loopback_init_net(struct net *net);
+void vsock_loopback_exit_net(struct net *net);
+
 #endif /* __AF_VSOCK_H__ */
diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
index 0bad4652815c..4420346e10a8 100644
--- a/include/net/netns/vsock.h
+++ b/include/net/netns/vsock.h
@@ -7,6 +7,8 @@
 #define VSOCK_NET_MODE_GLOBAL	1
 #define VSOCK_NET_MODE_LOCAL	(1 << 1)
 
+struct vsock_loopback;
+
 struct netns_vsock {
 	struct ctl_table_header *vsock_hdr;
 	spinlock_t lock;
@@ -14,5 +16,6 @@ struct netns_vsock {
 	/* protected by lock */
 	u8 ns_mode;
 	bool written;
+	struct vsock_loopback *loopback;
 };
 #endif /* __NET_NET_NAMESPACE_VSOCK_H */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index c69c2db03162..5689ce7d5843 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2778,9 +2778,12 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
 {
 	vsock_net_init(net);
 
-	if (vsock_sysctl_register(net))
+	if (vsock_loopback_init_net(net))
 		return -ENOMEM;
 
+	if (vsock_sysctl_register(net))
+		goto err_loopback;
+
 #ifdef CONFIG_PROC_FS
 	if (!proc_create_net_single_write("vsock_ns_mode", 0644, net->proc_net,
 					  vsock_proc_ns_mode_show,
@@ -2793,12 +2796,15 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
 
 err_sysctl:
 	vsock_sysctl_unregister(net);
+err_loopback:
+	vsock_loopback_exit_net(net);
 	return -ENOMEM;
 }
 
 static __net_exit void vsock_sysctl_exit_net(struct net *net)
 {
 	vsock_sysctl_unregister(net);
+	vsock_loopback_exit_net(net);
 }
 
 static struct pernet_operations vsock_sysctl_ops __net_initdata = {
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 6e78927a598e..4fc07e3a1d2b 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -28,8 +28,19 @@ static u32 vsock_loopback_get_local_cid(void)
 
 static int vsock_loopback_send_pkt(struct sk_buff *skb)
 {
-	struct vsock_loopback *vsock = &the_vsock_loopback;
+	struct vsock_loopback *vsock;
 	int len = skb->len;
+	struct net *net;
+
+	if (skb->sk)
+		net = sock_net(skb->sk);
+	else
+		net = NULL;
+
+	if (net && net->vsock.ns_mode == VSOCK_NET_MODE_LOCAL)
+		vsock = net->vsock.loopback;
+	else
+		vsock = &the_vsock_loopback;
 
 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
 	queue_work(vsock->workqueue, &vsock->pkt_work);
@@ -46,7 +57,7 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
 	return 0;
 }
 
-static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
+static bool vsock_loopback_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
 static bool vsock_loopback_msgzerocopy_allow(void)
 {
 	return true;
@@ -106,7 +117,7 @@ static struct virtio_transport loopback_transport = {
 	.send_pkt = vsock_loopback_send_pkt,
 };
 
-static bool vsock_loopback_seqpacket_allow(u32 remote_cid)
+static bool vsock_loopback_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
 	return true;
 }
@@ -134,27 +145,55 @@ static void vsock_loopback_work(struct work_struct *work)
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
+	destroy_workqueue(vsock->workqueue);
+}
+
+int vsock_loopback_init_net(struct net *net)
+{
+	net->vsock.loopback = kmalloc(GFP_KERNEL, sizeof(struct vsock_loopback));
+	if (!net->vsock.loopback)
+		return -ENOMEM;
+
+	return vsock_loopback_init_vsock(net->vsock.loopback);
+}
+
+void vsock_loopback_exit_net(struct net *net)
+{
+	vsock_loopback_deinit_vsock(net->vsock.loopback);
+	kfree(net->vsock.loopback);
+}
+
+static int __init vsock_loopback_init(void)
+{
+	struct vsock_loopback *vsock = &the_vsock_loopback;
+	int ret;
+
+	ret = vsock_loopback_init_vsock(vsock);
+	if (ret < 0)
+		return ret;
 
 	ret = vsock_core_register(&loopback_transport.transport,
 				  VSOCK_TRANSPORT_F_LOCAL);
 	if (ret)
-		goto out_wq;
+		goto out_deinit;
 
 	return 0;
 
-out_wq:
-	destroy_workqueue(vsock->workqueue);
+out_deinit:
+	vsock_loopback_deinit_vsock(vsock);
 	return ret;
 }
 

-- 
2.47.3


