Return-Path: <linux-kselftest+bounces-46185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D499C776B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 06:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97A744E8103
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 05:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBEB2F7AB5;
	Fri, 21 Nov 2025 05:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrEmk+td"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C482F49E9
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 05:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703896; cv=none; b=CBWzT2cclPGQ0B7eM1iVPFAnNQVqUUz3TPl9BG4a5UaDLSmyJsyUojSmoAQQhX2gddaF+R/PKwfEZdyJu+zegj9VJLXj+8/mLBejDkc2kOv4JE45PeszWxJIxZuN2EYJqUtwEpNbXJVWrKpulJwGFAgyawq52sKj7ZR/cyeqdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703896; c=relaxed/simple;
	bh=CjcLpHwGga4LyyQ0NozEIEHYSPs4uhSwRwqDFMYEs4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l5DP2Zh/efkgeuFJICI+yV6dT/SfA5VkqZK+Vx8Tdko4bXt6cXsgpRdEsoajYMFAezbMXYf6pBZk8t/V8LSApzJ56oQhXDTLHTXfb/vziGZWuD/C5CaA4P0ySLe0y6iNnuYTYfYQdHq1SLt5iyBJVTt4FmP1jlxrsijRZVs5Ko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrEmk+td; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso1453263b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 21:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703892; x=1764308692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQIl+zFDLzyhVKkIGBH4UnCndViQqDg/y1dV5YKjZiE=;
        b=QrEmk+td//m/5uXdo/E6GdPmrMb77/ZHImkk9UHwJaOVzwHfaF1vUPUib1Fvnjjct1
         NfAYGNZ1X3LwNVt3m+j6EiEe2htTL5fM71DOKFNvP4+ZX0yqp5figRzB2brk+ec1qh/V
         NDWib9Rj4FHxyFgcnCNRIw4f3r95MHq92Kye3qDx/MLszYSjT1UDdOqttWK8uUsS7RmW
         ZBPpDzQKmtZzWtaeL4EMnSNGlxogmYALebiSwyFrWPncy+1+L2ZCn6PeklLEgKqSjoFn
         xWq3fWxl0B8uDwNXcJ8iZKy7jQQWUT/je9VZjpzDL64a8Z89fPnUZ6Q8hlnj4tam2cqj
         ZykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703892; x=1764308692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WQIl+zFDLzyhVKkIGBH4UnCndViQqDg/y1dV5YKjZiE=;
        b=p0Rs6nLfVnexjxcuh/ljqTtNfzKMEHnsNtpOA+Dc/XTJ1srfWJ4rb44QpGxV94VbbH
         8l00eK+rRN+9tI8NQSF48ApGSJ8qv7RBjRgWEXP38fla5ZtNHuzeTenY2YhzZbfbjPaZ
         TW8iDxNoNLekf6JbYWr58mHG8ThtZN/hnkwL+v9b8xujgtQ4wTFq8T8WFHYwnUggSWE3
         qLOoGfenM4mkgg8FrbQm67I00vvQwC13ARhrsXu+0owBjcfm/TT2CExAm7GI4N3RLvq9
         /5rWZ6xRPzyO75pWLiCfiqSfBU9gtj86VKgu6eypz9BxbKw4JKc09AX33BzGNZ68F6zM
         tjqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdRJuxz/c9rfP1pTuw91MsTqz+jH2JjWbHltkYbfoFCD1HGht4AD9d8cqAJFsyOK2+4N9g6wGkjkG6DsJJ2M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHTuiJbn6afq+cYzECUSqUW4a6TSdq/3OQZgVkiI0FdCliNhkB
	DPT/DNBza8YyfymCQd6AmeWSPQ6G6y/BraJxCvaUY3tHnSWIlH0sYprhpK8xV6fB
X-Gm-Gg: ASbGnctWSjplGaAZQRFutqS5+c4m8omjK5fWOodaNn6EJTyfbVVibo5macM6nfSV5E0
	71OCAT9dR79VQ6HWokC8TX/p5Yxg6xMUYv2JsIyb8cM5we7wAWsaSpYeX/b5aG5cg0Nd25ugVI/
	nBTC5Q426Z09WdMoDOtcZbuVIBmD+G0dYtVPP+87pM+lwEwmSnBU/tpbbQNNGKsTGYCwxEPc8Rk
	5KG/+CtLtluUEKZq9Z4oiBPgnKDSLDQf8i9McuBsmJUoJZZb44tEtfgDx7q6N8fJpjaDA1+Otjv
	ap0MVol/qP7l9qlFyosiH4B5RDCiFA1VnlGBJxEJJQ7fq5gg90kwnfvIJWTYUfN9C+XPahPZ9nK
	vkWbI/mOJrXxjSByl3fJNtEY8I5V33A2V2maTt3btFdvRfpZMTEOmTt0NcAzfW8ECdIlOd8Qw8J
	vRvkh7ClYZ2GIk6xbsV6ViX4JuWxip9A==
X-Google-Smtp-Source: AGHT+IEHmBNUyCr2KMzTRAxhCHe8PSGg7JbvyE+tA+5mFWQt/cL+HpXx1aqCFqLSixWw77QaJWBR1Q==
X-Received: by 2002:a05:6a00:2d02:b0:7a2:882b:61b7 with SMTP id d2e1a72fcca58-7c58eb01a7fmr1237254b3a.32.1763703892295;
        Thu, 20 Nov 2025 21:44:52 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed789f19sm4655079b3a.28.2025.11.20.21.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:44:51 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:34 -0800
Subject: [PATCH net-next v11 02/13] vsock: add netns to vsock core
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-2-55cbc80249a7@meta.com>
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

Add netns logic to vsock core. Additionally, modify transport hook
prototypes to be used by later transport-specific patches (e.g.,
*_seqpacket_allow()).

Namespaces are supported primarily by changing socket lookup functions
(e.g., vsock_find_connected_socket()) to take into account the socket
namespace and the namespace mode before considering a candidate socket a
"match".

This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode that
accepts the "global" or "local" mode strings.

Add netns functionality (initialization, passing to transports, procfs,
etc...) to the af_vsock socket layer. Later patches that add netns
support to transports depend on this patch.

seqpacket_allow() callbacks are modified to take a vsk so that transport
implementations can inspect sock_net(sk) and vsk->net_mode when performing
lookups (e.g., vhost does this in its future netns patch). Because the
API change affects all transports, it seemed more appropriate to make
this internal API change in the "vsock core" patch then in the "vhost"
patch.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v10:
- add file-level comment about what happens to sockets/devices
  when the namespace mode changes (Stefano)
- change the 'if (write)' boolean in vsock_net_mode_string() to
  if (!write), this simplifies a later patch which adds "goto"
  for mutex unlocking on function exit.

Changes in v9:
- remove virtio_vsock_alloc_rx_skb() (Stefano)
- remove vsock_global_dummy_net, not needed as net=NULL +
  net_mode=VSOCK_NET_MODE_GLOBAL achieves identical result

Changes in v7:
- hv_sock: fix hyperv build error
- explain why vhost does not use the dummy
- explain usage of __vsock_global_dummy_net
- explain why VSOCK_NET_MODE_STR_MAX is 8 characters
- use switch-case in vsock_net_mode_string()
- avoid changing transports as much as possible
- add vsock_find_{bound,connected}_socket_net()
- rename `vsock_hdr` to `sysctl_hdr`
- add virtio_vsock_alloc_linear_skb() wrapper for setting dummy net and
  global mode for virtio-vsock, move skb->cb zero-ing into wrapper
- explain seqpacket_allow() change
- move net setting to __vsock_create() instead of vsock_create() so
  that child sockets also have their net assigned upon accept()

Changes in v6:
- unregister sysctl ops in vsock_exit()
- af_vsock: clarify description of CID behavior
- af_vsock: fix buf vs buffer naming, and length checking
- af_vsock: fix length checking w/ correct ctl_table->maxlen

Changes in v5:
- vsock_global_net() -> vsock_global_dummy_net()
- update comments for new uAPI
- use /proc/sys/net/vsock/ns_mode instead of /proc/net/vsock_ns_mode
- add prototype changes so patch remains compilable
---
 drivers/vhost/vsock.c            |   6 +-
 include/net/af_vsock.h           |   9 +-
 net/vmw_vsock/af_vsock.c         | 258 ++++++++++++++++++++++++++++++++++++---
 net/vmw_vsock/virtio_transport.c |   6 +-
 net/vmw_vsock/vsock_loopback.c   |   6 +-
 5 files changed, 261 insertions(+), 24 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ae01457ea2cd..69074656263d 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -404,7 +404,8 @@ static bool vhost_transport_msgzerocopy_allow(void)
 	return true;
 }
 
-static bool vhost_transport_seqpacket_allow(u32 remote_cid);
+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
+					    u32 remote_cid);
 
 static struct virtio_transport vhost_transport = {
 	.transport = {
@@ -460,7 +461,8 @@ static struct virtio_transport vhost_transport = {
 	.send_pkt = vhost_transport_send_pkt,
 };
 
-static bool vhost_transport_seqpacket_allow(u32 remote_cid)
+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
+					    u32 remote_cid)
 {
 	struct vhost_vsock *vsock;
 	bool seqpacket_allow = false;
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 9b5bdd083b6f..59d97a143204 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -145,7 +145,7 @@ struct vsock_transport {
 				     int flags);
 	int (*seqpacket_enqueue)(struct vsock_sock *vsk, struct msghdr *msg,
 				 size_t len);
-	bool (*seqpacket_allow)(u32 remote_cid);
+	bool (*seqpacket_allow)(struct vsock_sock *vsk, u32 remote_cid);
 	u32 (*seqpacket_has_data)(struct vsock_sock *vsk);
 
 	/* Notification. */
@@ -218,6 +218,13 @@ void vsock_remove_connected(struct vsock_sock *vsk);
 struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
 struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 					 struct sockaddr_vm *dst);
+struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr,
+					 struct net *net,
+					 enum vsock_net_mode net_mode);
+struct sock *vsock_find_connected_socket_net(struct sockaddr_vm *src,
+					     struct sockaddr_vm *dst,
+					     struct net *net,
+					     enum vsock_net_mode net_mode);
 void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index adcba1b7bf74..243c0d588682 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -83,6 +83,38 @@
  *   TCP_ESTABLISHED - connected
  *   TCP_CLOSING - disconnecting
  *   TCP_LISTEN - listening
+ *
+ * - Namespaces in vsock support two different modes configured
+ *   through /proc/sys/net/vsock/ns_mode. The modes are "local" and "global".
+ *   Each mode defines how the namespace interacts with CIDs.
+ *   /proc/sys/net/vsock/ns_mode is write-once, so that it may be configured
+ *   and locked down by a namespace manager. The default is "global". The mode
+ *   is set per-namespace.
+ *
+ *   The modes affect the allocation and accessibility of CIDs as follows:
+ *
+ *   - global - access and allocation are all system-wide
+ *      - all CID allocation from global namespaces draw from the same
+ *        system-wide pool.
+ *      - if one global namespace has already allocated some CID, another
+ *        global namespace will not be able to allocate the same CID.
+ *      - global mode AF_VSOCK sockets can reach any VM or socket in any global
+ *        namespace, they are not contained to only their own namespace.
+ *      - AF_VSOCK sockets in a global mode namespace cannot reach VMs or
+ *        sockets in any local mode namespace.
+ *   - local - access and allocation are contained within the namespace
+ *     - CID allocation draws only from a private pool local only to the
+ *       namespace, and does not affect the CIDs available for allocation in any
+ *       other namespace (global or local).
+ *     - VMs in a local namespace do not collide with CIDs in any other local
+ *       namespace or any global namespace. For example, if a VM in a local mode
+ *       namespace is given CID 10, then CID 10 is still available for
+ *       allocation in any other namespace, but not in the same namespace.
+ *     - AF_VSOCK sockets in a local mode namespace can connect only to VMs or
+ *       other sockets within their own namespace.
+ *   - when a socket or device is initialized in a namespace with mode
+ *     global, it will stay in global mode even if the namespace later
+ *     changes to local.
  */
 
 #include <linux/compat.h>
@@ -100,6 +132,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/net.h>
+#include <linux/proc_fs.h>
 #include <linux/poll.h>
 #include <linux/random.h>
 #include <linux/skbuff.h>
@@ -111,9 +144,18 @@
 #include <linux/workqueue.h>
 #include <net/sock.h>
 #include <net/af_vsock.h>
+#include <net/netns/vsock.h>
 #include <uapi/linux/vm_sockets.h>
 #include <uapi/asm-generic/ioctls.h>
 
+#define VSOCK_NET_MODE_STR_GLOBAL "global"
+#define VSOCK_NET_MODE_STR_LOCAL "local"
+
+/* 6 chars for "global", 1 for null-terminator, and 1 more for '\n'.
+ * The newline is added by proc_dostring() for read operations.
+ */
+#define VSOCK_NET_MODE_STR_MAX 8
+
 static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
 static void vsock_sk_destruct(struct sock *sk);
 static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
@@ -235,33 +277,47 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
 	sock_put(&vsk->sk);
 }
 
-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
+static struct sock *__vsock_find_bound_socket_net(struct sockaddr_vm *addr,
+						  struct net *net,
+						  enum vsock_net_mode net_mode)
 {
 	struct vsock_sock *vsk;
 
 	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
-		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
-			return sk_vsock(vsk);
+		struct sock *sk = sk_vsock(vsk);
+
+		if (vsock_addr_equals_addr(addr, &vsk->local_addr) &&
+		    vsock_net_check_mode(sock_net(sk), vsk->net_mode, net,
+					 net_mode))
+			return sk;
 
 		if (addr->svm_port == vsk->local_addr.svm_port &&
 		    (vsk->local_addr.svm_cid == VMADDR_CID_ANY ||
-		     addr->svm_cid == VMADDR_CID_ANY))
-			return sk_vsock(vsk);
+		     addr->svm_cid == VMADDR_CID_ANY) &&
+		     vsock_net_check_mode(sock_net(sk), vsk->net_mode, net,
+					  net_mode))
+			return sk;
 	}
 
 	return NULL;
 }
 
-static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
-						  struct sockaddr_vm *dst)
+static struct sock *
+__vsock_find_connected_socket_net(struct sockaddr_vm *src,
+				  struct sockaddr_vm *dst, struct net *net,
+				  enum vsock_net_mode net_mode)
 {
 	struct vsock_sock *vsk;
 
 	list_for_each_entry(vsk, vsock_connected_sockets(src, dst),
 			    connected_table) {
+		struct sock *sk = sk_vsock(vsk);
+
 		if (vsock_addr_equals_addr(src, &vsk->remote_addr) &&
-		    dst->svm_port == vsk->local_addr.svm_port) {
-			return sk_vsock(vsk);
+		    dst->svm_port == vsk->local_addr.svm_port &&
+		    vsock_net_check_mode(sock_net(sk), vsk->net_mode, net,
+					 net_mode)) {
+			return sk;
 		}
 	}
 
@@ -304,12 +360,14 @@ void vsock_remove_connected(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(vsock_remove_connected);
 
-struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
+struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr,
+					 struct net *net,
+					 enum vsock_net_mode net_mode)
 {
 	struct sock *sk;
 
 	spin_lock_bh(&vsock_table_lock);
-	sk = __vsock_find_bound_socket(addr);
+	sk = __vsock_find_bound_socket_net(addr, net, net_mode);
 	if (sk)
 		sock_hold(sk);
 
@@ -317,15 +375,23 @@ struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
 
 	return sk;
 }
+EXPORT_SYMBOL_GPL(vsock_find_bound_socket_net);
+
+struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
+{
+	return vsock_find_bound_socket_net(addr, NULL, VSOCK_NET_MODE_GLOBAL);
+}
 EXPORT_SYMBOL_GPL(vsock_find_bound_socket);
 
-struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
-					 struct sockaddr_vm *dst)
+struct sock *vsock_find_connected_socket_net(struct sockaddr_vm *src,
+					     struct sockaddr_vm *dst,
+					     struct net *net,
+					     enum vsock_net_mode net_mode)
 {
 	struct sock *sk;
 
 	spin_lock_bh(&vsock_table_lock);
-	sk = __vsock_find_connected_socket(src, dst);
+	sk = __vsock_find_connected_socket_net(src, dst, net, net_mode);
 	if (sk)
 		sock_hold(sk);
 
@@ -333,6 +399,14 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 
 	return sk;
 }
+EXPORT_SYMBOL_GPL(vsock_find_connected_socket_net);
+
+struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
+					 struct sockaddr_vm *dst)
+{
+	return vsock_find_connected_socket_net(src, dst,
+					       NULL, VSOCK_NET_MODE_GLOBAL);
+}
 EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
 
 void vsock_remove_sock(struct vsock_sock *vsk)
@@ -528,7 +602,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
-		    !new_transport->seqpacket_allow(remote_cid)) {
+		    !new_transport->seqpacket_allow(vsk, remote_cid)) {
 			module_put(new_transport->module);
 			return -ESOCKTNOSUPPORT;
 		}
@@ -676,6 +750,7 @@ static void vsock_pending_work(struct work_struct *work)
 static int __vsock_bind_connectible(struct vsock_sock *vsk,
 				    struct sockaddr_vm *addr)
 {
+	struct net *net = sock_net(sk_vsock(vsk));
 	static u32 port;
 	struct sockaddr_vm new_addr;
 
@@ -695,7 +770,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 
 			new_addr.svm_port = port++;
 
-			if (!__vsock_find_bound_socket(&new_addr)) {
+			if (!__vsock_find_bound_socket_net(&new_addr, net,
+							   vsk->net_mode)) {
 				found = true;
 				break;
 			}
@@ -712,7 +788,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 			return -EACCES;
 		}
 
-		if (__vsock_find_bound_socket(&new_addr))
+		if (__vsock_find_bound_socket_net(&new_addr, net,
+						  vsk->net_mode))
 			return -EADDRINUSE;
 	}
 
@@ -836,6 +913,8 @@ static struct sock *__vsock_create(struct net *net,
 		vsk->buffer_max_size = VSOCK_DEFAULT_BUFFER_MAX_SIZE;
 	}
 
+	vsk->net_mode = vsock_net_mode(net);
+
 	return sk;
 }
 
@@ -2658,6 +2737,142 @@ static struct miscdevice vsock_device = {
 	.fops		= &vsock_device_ops,
 };
 
+static int vsock_net_mode_string(const struct ctl_table *table, int write,
+				 void *buffer, size_t *lenp, loff_t *ppos)
+{
+	char data[VSOCK_NET_MODE_STR_MAX] = {0};
+	enum vsock_net_mode mode;
+	struct ctl_table tmp;
+	struct net *net;
+	int ret;
+
+	if (!table->data || !table->maxlen || !*lenp) {
+		*lenp = 0;
+		return 0;
+	}
+
+	net = current->nsproxy->net_ns;
+	tmp = *table;
+	tmp.data = data;
+
+	if (!write) {
+		const char *p;
+
+		mode = vsock_net_mode(net);
+
+		switch (mode) {
+		case VSOCK_NET_MODE_GLOBAL:
+			p = VSOCK_NET_MODE_STR_GLOBAL;
+			break;
+		case VSOCK_NET_MODE_LOCAL:
+			p = VSOCK_NET_MODE_STR_LOCAL;
+			break;
+		default:
+			WARN_ONCE(true, "netns has invalid vsock mode");
+			*lenp = 0;
+			return 0;
+		}
+
+		strscpy(data, p, sizeof(data));
+		tmp.maxlen = strlen(p);
+	}
+
+	ret = proc_dostring(&tmp, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
+
+	if (!write)
+		return 0;
+
+	if (*lenp >= sizeof(data))
+		return -EINVAL;
+
+	if (!strncmp(data, VSOCK_NET_MODE_STR_GLOBAL, sizeof(data)))
+		mode = VSOCK_NET_MODE_GLOBAL;
+	else if (!strncmp(data, VSOCK_NET_MODE_STR_LOCAL, sizeof(data)))
+		mode = VSOCK_NET_MODE_LOCAL;
+	else
+		return -EINVAL;
+
+	if (!vsock_net_write_mode(net, mode))
+		return -EPERM;
+
+	return 0;
+}
+
+static struct ctl_table vsock_table[] = {
+	{
+		.procname	= "ns_mode",
+		.data		= &init_net.vsock.mode,
+		.maxlen		= VSOCK_NET_MODE_STR_MAX,
+		.mode		= 0644,
+		.proc_handler	= vsock_net_mode_string
+	},
+};
+
+static int __net_init vsock_sysctl_register(struct net *net)
+{
+	struct ctl_table *table;
+
+	if (net_eq(net, &init_net)) {
+		table = vsock_table;
+	} else {
+		table = kmemdup(vsock_table, sizeof(vsock_table), GFP_KERNEL);
+		if (!table)
+			goto err_alloc;
+
+		table[0].data = &net->vsock.mode;
+	}
+
+	net->vsock.sysctl_hdr = register_net_sysctl_sz(net, "net/vsock", table,
+						       ARRAY_SIZE(vsock_table));
+	if (!net->vsock.sysctl_hdr)
+		goto err_reg;
+
+	return 0;
+
+err_reg:
+	if (!net_eq(net, &init_net))
+		kfree(table);
+err_alloc:
+	return -ENOMEM;
+}
+
+static void vsock_sysctl_unregister(struct net *net)
+{
+	const struct ctl_table *table;
+
+	table = net->vsock.sysctl_hdr->ctl_table_arg;
+	unregister_net_sysctl_table(net->vsock.sysctl_hdr);
+	if (!net_eq(net, &init_net))
+		kfree(table);
+}
+
+static void vsock_net_init(struct net *net)
+{
+	net->vsock.mode = VSOCK_NET_MODE_GLOBAL;
+}
+
+static __net_init int vsock_sysctl_init_net(struct net *net)
+{
+	vsock_net_init(net);
+
+	if (vsock_sysctl_register(net))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static __net_exit void vsock_sysctl_exit_net(struct net *net)
+{
+	vsock_sysctl_unregister(net);
+}
+
+static struct pernet_operations vsock_sysctl_ops __net_initdata = {
+	.init = vsock_sysctl_init_net,
+	.exit = vsock_sysctl_exit_net,
+};
+
 static int __init vsock_init(void)
 {
 	int err = 0;
@@ -2685,10 +2900,18 @@ static int __init vsock_init(void)
 		goto err_unregister_proto;
 	}
 
+	if (register_pernet_subsys(&vsock_sysctl_ops)) {
+		err = -ENOMEM;
+		goto err_unregister_sock;
+	}
+
+	vsock_net_init(&init_net);
 	vsock_bpf_build_proto();
 
 	return 0;
 
+err_unregister_sock:
+	sock_unregister(AF_VSOCK);
 err_unregister_proto:
 	proto_unregister(&vsock_proto);
 err_deregister_misc:
@@ -2702,6 +2925,7 @@ static void __exit vsock_exit(void)
 	misc_deregister(&vsock_device);
 	sock_unregister(AF_VSOCK);
 	proto_unregister(&vsock_proto);
+	unregister_pernet_subsys(&vsock_sysctl_ops);
 }
 
 const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 8c867023a2e5..d365a4b371d0 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -536,7 +536,8 @@ static bool virtio_transport_msgzerocopy_allow(void)
 	return true;
 }
 
-static bool virtio_transport_seqpacket_allow(u32 remote_cid);
+static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
+					     u32 remote_cid);
 
 static struct virtio_transport virtio_transport = {
 	.transport = {
@@ -593,7 +594,8 @@ static struct virtio_transport virtio_transport = {
 	.can_msgzerocopy = virtio_transport_can_msgzerocopy,
 };
 
-static bool virtio_transport_seqpacket_allow(u32 remote_cid)
+static bool
+virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
 	struct virtio_vsock *vsock;
 	bool seqpacket_allow;
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index bc2ff918b315..8722337a4f80 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -46,7 +46,8 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
 	return 0;
 }
 
-static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
+static bool vsock_loopback_seqpacket_allow(struct vsock_sock *vsk,
+					   u32 remote_cid);
 static bool vsock_loopback_msgzerocopy_allow(void)
 {
 	return true;
@@ -106,7 +107,8 @@ static struct virtio_transport loopback_transport = {
 	.send_pkt = vsock_loopback_send_pkt,
 };
 
-static bool vsock_loopback_seqpacket_allow(u32 remote_cid)
+static bool
+vsock_loopback_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
 	return true;
 }

-- 
2.47.3


