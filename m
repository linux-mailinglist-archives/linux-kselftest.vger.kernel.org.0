Return-Path: <linux-kselftest+bounces-40125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C18AB38FED
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 02:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9C31B28BE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6E22185BC;
	Thu, 28 Aug 2025 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYb0gIMz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD61F4CBE;
	Thu, 28 Aug 2025 00:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341102; cv=none; b=ZfIFoHcAnkqcx15jyLn3TQ7qLc4Z/FX6rZY4FqLcLIApXiG/WuN3fEEKNNcP30/J14FDFlhBGuJnn5maqCWP1UUpPLEcdDy3q5UBe1Ej2P6ZbJ+fT+v8tIgJ+etuu9g2ZZGLQDxGTL1jytXeRrKlLDN5DeADeSNkH2KjL/VN4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341102; c=relaxed/simple;
	bh=wWdrwUKBUFrtXAHqJcDXxHi/oozKFw1YoDZbNfv/RMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sCpweLJNRym4ze/80px6E0XMccZQWualX284atbCni/NGIdWgnng5Bl0lcEl4JoI+Y5j4XqMHhzwL7f4K/PPvYKLnB6zzopJxfTcrPTDMh2uDqA4fJXsnN/n+Epy7jtJrGT9U/dw+sONNck+/nQQKs6olus3nKicE+XvPCn/ic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYb0gIMz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-771ff6f117aso422223b3a.2;
        Wed, 27 Aug 2025 17:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341099; x=1756945899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WW/LcIFNDDwwwBQxgjHA336bZBssQi49MeEngdLV2Cg=;
        b=gYb0gIMzp84BgcKXhkx0wNMW9vBYWaOnMAFx8CAfChFldKXrxl9z0HsplZWOwJvogE
         hIgQaAod+/wGJVib5rPQRSpQQWkoECdzMRYq5OVxnC8Pz3VAz6oLYc8A5Dd/R8tSr+DF
         nuQkOVThPkVokNCARgHbTHJCNDbkghW2Rlcmc7DHQyxqixhN83F88H8XD1AhVRAt2o1B
         WCAfgWBRm9Q1sznNhS4nVjZZIys4zSCygysYg6SmZ68N2TUn/Qc4y/x3BbTDyWpZnzNk
         iDw8M6AaZcGdECkbTpZqbEFjH6vXh42JPTKdBwnFqJRC89ooCSBAKa239LKQw7M/M819
         0Ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341099; x=1756945899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WW/LcIFNDDwwwBQxgjHA336bZBssQi49MeEngdLV2Cg=;
        b=FL7oA32sFkOReeMBBSNJeIneR86zkkuNe6nMa9LVBtQtcBc5sw3bhXYL+dy9xs8mkp
         q4rB8cE5dcPy74vGdWaCOUxwaQKCDcRiTDP/LJmkxzrMNK9aZqXsgXNUBFJ/t0eJJ2ZQ
         tUpqeOCEBDsjXHBJVVSECaxiUcxGBDLHAQE2hy8LBlg5OpJvz1xO4H5lq5OjPYurlDXV
         axCKRuZ9UfT3eN9qRzu+6XD0srS+Rq2K67C9UGPepXOZgOc9SDPG9lN2d3vcvySXufKt
         6jld27x9wtkPqINAXzMOmVxRqf4O0UkB9/K6t/ZtcYLstkjri2b/LqpOVaF9uIS2HnB5
         UDqA==
X-Forwarded-Encrypted: i=1; AJvYcCU9+4gppIloOh8EbA4qHOuIfVKgN4toD3F7r6nlr4Hiai4PyJwkrO9j7k/JYa6er7OLvsh5LLE47I5iaN2x@vger.kernel.org, AJvYcCV0JW/oTwAu/rwb3buBpo6nxfLXfP77eJgcj8vJIEYBMOp0fG845VbpM4Qm+Fg5u95FfVA=@vger.kernel.org, AJvYcCV4fVOoHDdlkZoTnMduUuBTyHIa07H/dfgWKLLPwXXFA87xXq45TvfMzjh7HhZPGupBJ82efWew@vger.kernel.org, AJvYcCXGnZlqgPrhlKytZGuo5HEXVv+mi7499sDNUD2Lg2Pt41reku2uZSEHehei7n8IJv1P25as0V7caYzdUBKj2M7y@vger.kernel.org, AJvYcCXsVwopwYl9tXMn6uS/FcgWlv2kVS4ywEhAIl1DKTaRoJx6rrU8cAUdEVVWiazICmFsrOulNboAy+w3Roht@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt11wlF+TgQBsPbOhX2O2HaqYGS3SKsG9JlF73pdhBIv4v/DYX
	emYvFt5Y34t7lHEAQZ/g6VXXpMqJyFjbQGUtuR/MOrDGjBIJSZHlOb6P
X-Gm-Gg: ASbGncv6WnR1HWm3bSBAdTTW8N+F9nVRhHcAxN23pO12Dd93gTwfgtnRldqENLUfPQh
	smkpcEb8Fq3WMV08I1jyvGjH4N3e2bRA30NLKEzyhPqLhNbk9xQ1yFCkL/UnQE6Vpbri6gpfjn/
	rIiQM95qAEuALwK7oMTNqBOcLDxXLRCAOaEha1bU/9CQIozrSvu1LCnKfzvOfc1h6LNvfQhIwue
	8P6CP4iAGcvqhEEQ1YvA1YEFNC3pQIgpqMLglXauPXu8KD+CsR4j6RR4teiiBvWh4kDDg2n8yEB
	vAQQnPGoX4g/JBT5hpWlOEaKBCn4NcIFamQx54kyTAqjK92S7qjMjLnroHNnaP0X2QrOJTKNHwl
	VOiThrxxIGjlhWTUTaMQ=
X-Google-Smtp-Source: AGHT+IFemEU14RdHINRSlJUhUtiloPBD7tDAK4YxiClFU/SXgCt09YzlEQTv5tt9KahYIXPzz+S2+w==
X-Received: by 2002:a05:6a00:3e0b:b0:772:bb4:a1c8 with SMTP id d2e1a72fcca58-7720bb4a740mr3714892b3a.23.1756341099057;
        Wed, 27 Aug 2025 17:31:39 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771fbbc3bb0sm5435234b3a.66.2025.08.27.17.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 17:31:38 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 27 Aug 2025 17:31:32 -0700
Subject: [PATCH net-next v5 4/9] vsock/loopback: add netns support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-vsock-vmtest-v5-4-0ba580bede5b@meta.com>
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

Add NS support to vsock loopback. Sockets in a global mode netns
communicate with each other, regardless of namespace. Sockets in a local
mode netns may only communicate with other sockets within the same
namespace.

Add callbacks for transport to hook into the initialization and exit of
net namespaces.

The transport's init hook will be called once per netns init. Likewise
for exit.

When a set of init/exit callbacks is registered, the init callback is
called on each already existing namespace.

Only one callback registration is supported for now. Currently
vsock_loopback is the only user.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v5:
- add callbacks code to avoid reverse dependency
- add logic for handling vsock_loopback setup for already existing
  namespaces
---
 include/net/af_vsock.h         |  34 +++++++++++++
 include/net/netns/vsock.h      |   5 ++
 net/vmw_vsock/af_vsock.c       | 110 +++++++++++++++++++++++++++++++++++++++++
 net/vmw_vsock/vsock_loopback.c |  72 ++++++++++++++++++++++++---
 4 files changed, 213 insertions(+), 8 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 83f873174ba3..9333a98b9a1e 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -305,4 +305,38 @@ static inline bool vsock_net_check_mode(struct net *n1, struct net *n2)
 	       (vsock_net_mode(n1) == VSOCK_NET_MODE_GLOBAL &&
 		vsock_net_mode(n2) == VSOCK_NET_MODE_GLOBAL);
 }
+
+struct vsock_net_callbacks {
+	int (*init)(struct net *net);
+	void (*exit)(struct net *net);
+	struct module *owner;
+};
+
+#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
+
+#define vsock_register_net_callbacks(__init, __exit) \
+	__vsock_register_net_callbacks((__init), (__exit), THIS_MODULE)
+
+int __vsock_register_net_callbacks(int (*init)(struct net *net),
+				   void (*exit)(struct net *net),
+				   struct module *owner);
+void vsock_unregister_net_callbacks(void);
+
+#else
+
+#define vsock_register_net_callbacks(__init, __exit) do { } while (0)
+
+static inline int __vsock_register_net_callbacks(int (*init)(struct net *net),
+						 void (*exit)(struct net *net),
+						 struct module *owner)
+{
+	return 0;
+}
+
+static inline void vsock_unregister_net_callbacks(void) {}
+static inline int vsock_net_call_init(struct net *net) { return 0; }
+static inline void vsock_net_call_exit(struct net *net) {}
+
+#endif /* CONFIG_VSOCKETS_LOOPBACK */
+
 #endif /* __AF_VSOCK_H__ */
diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
index d4593c0b8dc4..08d9a933c540 100644
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
@@ -16,5 +18,8 @@ struct netns_vsock {
 	/* protected by lock */
 	enum vsock_net_mode mode;
 	bool written;
+#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
+	struct vsock_loopback *loopback;
+#endif
 };
 #endif /* __NET_NET_NAMESPACE_VSOCK_H */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 68a8875c8106..5a73d9e1a96f 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -134,6 +134,9 @@
 #include <uapi/linux/vm_sockets.h>
 #include <uapi/asm-generic/ioctls.h>
 
+static struct vsock_net_callbacks vsock_net_callbacks;
+static DEFINE_MUTEX(vsock_net_callbacks_lock);
+
 static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
 static void vsock_sk_destruct(struct sock *sk);
 static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
@@ -2781,6 +2784,49 @@ static void vsock_net_init(struct net *net)
 	net->vsock.mode = VSOCK_NET_MODE_GLOBAL;
 }
 
+#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
+static int vsock_net_call_init(struct net *net)
+{
+	struct vsock_net_callbacks *cbs;
+	int ret;
+
+	mutex_lock(&vsock_net_callbacks_lock);
+	cbs = &vsock_net_callbacks;
+
+	ret = 0;
+	if (!cbs->owner)
+		goto out;
+
+	if (try_module_get(cbs->owner)) {
+		ret = cbs->init(net);
+		module_put(cbs->owner);
+	}
+
+out:
+	mutex_unlock(&vsock_net_callbacks_lock);
+	return ret;
+}
+
+static void vsock_net_call_exit(struct net *net)
+{
+	struct vsock_net_callbacks *cbs;
+
+	mutex_lock(&vsock_net_callbacks_lock);
+	cbs = &vsock_net_callbacks;
+
+	if (!cbs->owner)
+		goto out;
+
+	if (try_module_get(cbs->owner)) {
+		cbs->exit(net);
+		module_put(cbs->owner);
+	}
+
+out:
+	mutex_unlock(&vsock_net_callbacks_lock);
+}
+#endif /* CONFIG_VSOCKETS_LOOPBACK */
+
 static __net_init int vsock_sysctl_init_net(struct net *net)
 {
 	vsock_net_init(net);
@@ -2788,12 +2834,20 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
 	if (vsock_sysctl_register(net))
 		return -ENOMEM;
 
+	if (vsock_net_call_init(net) < 0)
+		goto err_sysctl;
+
 	return 0;
+
+err_sysctl:
+	vsock_sysctl_unregister(net);
+	return -ENOMEM;
 }
 
 static __net_exit void vsock_sysctl_exit_net(struct net *net)
 {
 	vsock_sysctl_unregister(net);
+	vsock_net_call_exit(net);
 }
 
 static struct pernet_operations vsock_sysctl_ops __net_initdata = {
@@ -2938,6 +2992,62 @@ void vsock_core_unregister(const struct vsock_transport *t)
 }
 EXPORT_SYMBOL_GPL(vsock_core_unregister);
 
+#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
+int __vsock_register_net_callbacks(int (*init)(struct net *net),
+				   void (*exit)(struct net *net),
+				   struct module *owner)
+{
+	struct vsock_net_callbacks *cbs;
+	struct net *net;
+	int ret = 0;
+
+	mutex_lock(&vsock_net_callbacks_lock);
+
+	cbs = &vsock_net_callbacks;
+	cbs->init = init;
+	cbs->exit = exit;
+	cbs->owner = owner;
+
+	/* call callbacks on any net previously created */
+	down_read(&net_rwsem);
+
+	if (try_module_get(cbs->owner)) {
+		for_each_net(net) {
+			ret = cbs->init(net);
+			if (ret < 0)
+				break;
+		}
+
+		if (ret < 0)
+			for_each_net(net)
+				cbs->exit(net);
+
+		module_put(cbs->owner);
+	}
+
+	up_read(&net_rwsem);
+	mutex_unlock(&vsock_net_callbacks_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__vsock_register_net_callbacks);
+
+void vsock_unregister_net_callbacks(void)
+{
+	struct vsock_net_callbacks *cbs;
+
+	mutex_lock(&vsock_net_callbacks_lock);
+
+	cbs = &vsock_net_callbacks;
+	cbs->init = NULL;
+	cbs->exit = NULL;
+	cbs->owner = NULL;
+
+	mutex_unlock(&vsock_net_callbacks_lock);
+}
+EXPORT_SYMBOL_GPL(vsock_unregister_net_callbacks);
+#endif /* CONFIG_VSOCKETS_LOOPBACK */
+
 module_init(vsock_init);
 module_exit(vsock_exit);
 
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 1b2fab73e0d0..f16d21711cb0 100644
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
+	if (net && net->vsock.mode == VSOCK_NET_MODE_LOCAL)
+		vsock = net->vsock.loopback;
+	else
+		vsock = &the_vsock_loopback;
 
 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
 	queue_work(vsock->workqueue, &vsock->pkt_work);
@@ -134,27 +145,72 @@ static void vsock_loopback_work(struct work_struct *work)
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
+/* called with vsock_net_callbacks lock held */
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
+/* called with vsock_net_callbacks lock held */
+static void vsock_loopback_exit_net(struct net *net)
+{
+	if (net->vsock.loopback) {
+		vsock_loopback_deinit_vsock(net->vsock.loopback);
+		kfree(net->vsock.loopback);
+	}
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
+
+	ret = vsock_register_net_callbacks(vsock_loopback_init_net,
+					   vsock_loopback_exit_net);
+	if (ret < 0)
+		goto out_deinit_vsock;
 
 	ret = vsock_core_register(&loopback_transport.transport,
 				  VSOCK_TRANSPORT_F_LOCAL);
 	if (ret)
-		goto out_wq;
+		goto out_unregister_net;
+
 
 	return 0;
 
-out_wq:
-	destroy_workqueue(vsock->workqueue);
+out_unregister_net:
+	vsock_unregister_net_callbacks();
+
+out_deinit_vsock:
+	vsock_loopback_deinit_vsock(vsock);
 	return ret;
 }
 

-- 
2.47.3


