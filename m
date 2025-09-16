Return-Path: <linux-kselftest+bounces-41634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F605B7E3E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37401BC5FFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 23:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3225E2F39DC;
	Tue, 16 Sep 2025 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB4sfwNJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE7D2F28E7
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 23:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066239; cv=none; b=eTiWbr0SIxs1w/g7Pnp2DmxvkLRnklTlKDI9XFouwdVLQtD6zS+uSKkFGFGWNovoYnETV1dkzTYbMOz7/rLqvgDVi8TShBJUGCSszSQRiOlj4JzatRadXG4+A0d9RxNCvvHnyveHTA//YFrsmY9Smcsacl4hRbdx78nezK0WRgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066239; c=relaxed/simple;
	bh=cCZ0k3gZPrNiKGPQFG75e6ZmTzrOXxGRT6BolLyEjaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hrdW//7sD4fYTihThYsWvLz03Lbg35NS/scT7Vwo5PUaAO4qGgTZx+feXn7JES//3uh8pH2GAzYpbEql5jjH6I2i0zwSQLUC6bwoRgc4Gy6GEJPhNkQQH44MWFsnGb0/5xI9hvbly5FJejC7pi5VbE4o7bsawy4FxUtDzzXxT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WB4sfwNJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-776b0100de0so304466b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 16:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066236; x=1758671036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nvqg6WCyfUTNgvIlAPY+rCUqJCQezm1KPFWgjZl14m0=;
        b=WB4sfwNJBiv6qrF4jNseKQ7RoMYQPmJIPsKp9U9qwo03Tqy9WynfuOH37ShamD9MQc
         U25f7aLdcHHQBiVV0hj+KiK0r/dBjwthNCObByGaDIJXfk0AdlRXQTr5uak9RAkeQTb7
         S2gs6vQSs/yP5ljPJ2cJcb0FTFJyAyMD2BJWmnQ8BLlNF2hHuKTQ1fjCj7xk3aLIZPtU
         ydLd1YYuX1ZyMtgAwQ0ZgQuE76RwXcP+fN9LLKql0gqPWYFT94HlOn6Oa8NaI92ns3bc
         o8I0/J6uvBElMM8YrThLcXrXEKYsTVydiIhbD3WDe86Y5hq9vcs/NQdou357C6tCCeSs
         kRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066236; x=1758671036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nvqg6WCyfUTNgvIlAPY+rCUqJCQezm1KPFWgjZl14m0=;
        b=ejRfnOPlrL7Yis7YvVkQWtYKED92lcy+3dnSC1hgniskdu6TdJdvi6olQ1ST9y9TVN
         xXuXKZR+BCgQam4cSjrLOa7DW8hVo24fealQSae2UOQOSKFKA2Bb7jq3/CJqZyri2aQQ
         6pglG7ROb1YTlXMNEGERV3+GCoUYGw9y7/H2rxSZMhBe4N0/kInUABXY0rKHpvtQHYbE
         RdskPCsxsSQXX/s0B7Zo3/KECz7QocqL1IeKe5v089BhNAg3v+e/1jNQ/Jppb//G+Kts
         QvbuSpYxTPQgPoGtIKHf8y+psgKc4m28HLvZnTOMciULvD/kTfGol5CIX0P1rYFbRWGG
         3puA==
X-Forwarded-Encrypted: i=1; AJvYcCWY3TxiNIb1yTE1XAkwQeGDIqNJdvKQZGyuJUjeRzKvDvfeaYTB15Pxn8jHIlG2rpAPmMM8i1xUs57h78nabjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7UpToxhKi3VgktQ5ZCXLxLdAyd69m6efs2ZEAVtiyDWcQWN1H
	vrSXDqCgwCGEqE9gOr0iroXkKbnbGcRpHUDDnuoepap9wc1aUcx3IBZB
X-Gm-Gg: ASbGncvgR0ETszDqKuVTwznnHvREuiDftVRHsWGPIbz0mkItj2EO08+Zk8TGi33Jc5H
	IS5AZVR1fqtwvQ6dG0jsCM/9LibmRsejB++MWndIGdWQ6TMjGzPZJlKwEY0JeHgjjXq4n+Ki/9D
	RLi4F/vHTycKz3a3lccZG1W7TTo8iF3rLi7GY8BNTX1MWZkrz0Kgji4up4TlVETsZ3lVMqzvsdF
	r0H3rMC/Yn9/SVlQAkX+Y/6zThe/Pn4+wIpiCXxVA3OgrwslCr5H/dB++9TyTlJVGdl/QSt0R5G
	ZHH+Iq1u51R3axG5UhIQE5cqtasAbMKHNQqM8Oju9OlgnX2//TUx5ImJswRx+dKmw0fy5xWnMj7
	Go6xhxFEzVCDKsYsrFK8hPs4MFiuI/A==
X-Google-Smtp-Source: AGHT+IEXGEK2G7kXyiczsAodRLU1pih71p06gfVspnbFVCz1eOF0ku+EtnGblEkgSQpDZ6Y2hFEqCg==
X-Received: by 2002:a05:6a20:7d9b:b0:247:55a7:695a with SMTP id adf61e73a8af0-27a2df7cac8mr167917637.15.1758066235644;
        Tue, 16 Sep 2025 16:43:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b17e23sm17370169b3a.55.2025.09.16.16.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:43:54 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 16 Sep 2025 16:43:47 -0700
Subject: [PATCH net-next v6 3/9] vsock: add netns to vsock core
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-vsock-vmtest-v6-3-064d2eb0c89d@meta.com>
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

Add netns to logic to vsock core. Additionally, modify transport hook
prototypes to be used by later transport-specific patches (e.g.,
*_seqpacket_allow()).

Namespaces are supported primarily by changing socket lookup functions
(e.g., vsock_find_connected_socket()) to take into account the socket
namespace and the namespace mode before considering a candidate socket a
"match".

Introduce a dummy namespace struct, __vsock_global_dummy_net, to be
used by transports that do not support namespacing. This dummy always
has mode "global" to preserve previous CID behavior.

This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode that
accepts the "global" or "local" mode strings.

The transports (besides vhost) are modified to use the global dummy.

Add netns functionality (initialization, passing to transports, procfs,
etc...) to the af_vsock socket layer. Later patches that add netns
support to transports depend on this patch.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
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
 drivers/vhost/vsock.c                   |   4 +-
 include/net/af_vsock.h                  |  15 ++-
 net/vmw_vsock/af_vsock.c                | 219 ++++++++++++++++++++++++++++++--
 net/vmw_vsock/hyperv_transport.c        |   2 +-
 net/vmw_vsock/virtio_transport.c        |   6 +-
 net/vmw_vsock/virtio_transport_common.c |   4 +-
 net/vmw_vsock/vmci_transport.c          |   6 +-
 net/vmw_vsock/vsock_loopback.c          |   4 +-
 8 files changed, 234 insertions(+), 26 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ae01457ea2cd..34adf0cf9124 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -404,7 +404,7 @@ static bool vhost_transport_msgzerocopy_allow(void)
 	return true;
 }
 
-static bool vhost_transport_seqpacket_allow(u32 remote_cid);
+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
 
 static struct virtio_transport vhost_transport = {
 	.transport = {
@@ -460,7 +460,7 @@ static struct virtio_transport vhost_transport = {
 	.send_pkt = vhost_transport_send_pkt,
 };
 
-static bool vhost_transport_seqpacket_allow(u32 remote_cid)
+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
 	struct vhost_vsock *vsock;
 	bool seqpacket_allow = false;
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 2857e97699de..628e35ae9d00 100644
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
@@ -215,9 +215,12 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
 void vsock_insert_connected(struct vsock_sock *vsk);
 void vsock_remove_bound(struct vsock_sock *vsk);
 void vsock_remove_connected(struct vsock_sock *vsk);
-struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
+struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net,
+				     enum vsock_net_mode orig_net_mode);
 struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
-					 struct sockaddr_vm *dst);
+					 struct sockaddr_vm *dst,
+					 struct net *net,
+					 enum vsock_net_mode orig_net_mode);
 void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
@@ -259,6 +262,12 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
 }
 
+extern struct net __vsock_global_dummy_net;
+static inline struct net *vsock_global_dummy_net(void)
+{
+	return &__vsock_global_dummy_net;
+}
+
 static inline enum vsock_net_mode vsock_net_mode(struct net *net)
 {
 	enum vsock_net_mode ret;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 0538948d5fd9..c78aba9cd20e 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -83,6 +83,35 @@
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
+
+ *   - global - access and allocation are all system-wide
+ *      - all CID allocation from global namespaces draw from the same
+ *        system-wide pool
+ *      - if one global namespace has already allocated some CID, another
+ *        global namespace will not be able to allocate the same CID
+ *      - global mode AF_VSOCK sockets can reach any VM or socket in any global
+ *        namespace, they are not contained to only their own namespace
+ *      - AF_VSOCK sockets in a global mode namespace cannot reach VMs or
+ *        sockets in any local mode namespace
+ *   - local - access and allocation are contained within the namespace
+ *     - CID allocation draws only from a private pool local only to the
+ *       namespace, and does not affect the CIDs available for allocation in any
+ *       other namespace (global or local)
+ *     - VMs in a local namespace do not collide with CIDs in any other local
+ *       namespace or any global namespace. For example, if a VM in a local mode
+ *       namespace is given CID 10, then CID 10 is still available for
+ *       allocation in any other namespace, but not in the same namespace
+ *     - AF_VSOCK sockets in a local mode namespace can connect only to VMs or
+ *       other sockets within their own namespace.
  */
 
 #include <linux/compat.h>
@@ -100,6 +129,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/net.h>
+#include <linux/proc_fs.h>
 #include <linux/poll.h>
 #include <linux/random.h>
 #include <linux/skbuff.h>
@@ -111,9 +141,14 @@
 #include <linux/workqueue.h>
 #include <net/sock.h>
 #include <net/af_vsock.h>
+#include <net/netns/vsock.h>
 #include <uapi/linux/vm_sockets.h>
 #include <uapi/asm-generic/ioctls.h>
 
+#define VSOCK_NET_MODE_STR_GLOBAL "global"
+#define VSOCK_NET_MODE_STR_LOCAL "local"
+#define VSOCK_NET_MODE_STR_MAX 8
+
 static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
 static void vsock_sk_destruct(struct sock *sk);
 static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
@@ -149,6 +184,9 @@ static const struct vsock_transport *transport_dgram;
 static const struct vsock_transport *transport_local;
 static DEFINE_MUTEX(vsock_register_mutex);
 
+struct net __vsock_global_dummy_net;
+EXPORT_SYMBOL_GPL(__vsock_global_dummy_net);
+
 /**** UTILS ****/
 
 /* Each bound VSocket is stored in the bind hash table and each connected
@@ -235,17 +273,21 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
 	sock_put(&vsk->sk);
 }
 
-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
+static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr,
+					      struct net *net,
+					      enum vsock_net_mode orig_net_mode)
 {
 	struct vsock_sock *vsk;
 
 	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
-		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
+		if (vsock_addr_equals_addr(addr, &vsk->local_addr) &&
+		    vsock_net_check_mode(vsk, net, orig_net_mode))
 			return sk_vsock(vsk);
 
 		if (addr->svm_port == vsk->local_addr.svm_port &&
 		    (vsk->local_addr.svm_cid == VMADDR_CID_ANY ||
-		     addr->svm_cid == VMADDR_CID_ANY))
+		     addr->svm_cid == VMADDR_CID_ANY) &&
+		     vsock_net_check_mode(vsk, net, orig_net_mode))
 			return sk_vsock(vsk);
 	}
 
@@ -253,14 +295,17 @@ static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
 }
 
 static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
-						  struct sockaddr_vm *dst)
+						  struct sockaddr_vm *dst,
+						  struct net *net,
+						  enum vsock_net_mode orig_net_mode)
 {
 	struct vsock_sock *vsk;
 
 	list_for_each_entry(vsk, vsock_connected_sockets(src, dst),
 			    connected_table) {
 		if (vsock_addr_equals_addr(src, &vsk->remote_addr) &&
-		    dst->svm_port == vsk->local_addr.svm_port) {
+		    dst->svm_port == vsk->local_addr.svm_port &&
+		    vsock_net_check_mode(vsk, net, orig_net_mode)) {
 			return sk_vsock(vsk);
 		}
 	}
@@ -304,12 +349,13 @@ void vsock_remove_connected(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(vsock_remove_connected);
 
-struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
+struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net,
+				     enum vsock_net_mode orig_net_mode)
 {
 	struct sock *sk;
 
 	spin_lock_bh(&vsock_table_lock);
-	sk = __vsock_find_bound_socket(addr);
+	sk = __vsock_find_bound_socket(addr, net, orig_net_mode);
 	if (sk)
 		sock_hold(sk);
 
@@ -320,12 +366,14 @@ struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
 EXPORT_SYMBOL_GPL(vsock_find_bound_socket);
 
 struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
-					 struct sockaddr_vm *dst)
+					 struct sockaddr_vm *dst,
+					 struct net *net,
+					 enum vsock_net_mode orig_net_mode)
 {
 	struct sock *sk;
 
 	spin_lock_bh(&vsock_table_lock);
-	sk = __vsock_find_connected_socket(src, dst);
+	sk = __vsock_find_connected_socket(src, dst, net, orig_net_mode);
 	if (sk)
 		sock_hold(sk);
 
@@ -528,7 +576,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
-		    !new_transport->seqpacket_allow(remote_cid)) {
+		    !new_transport->seqpacket_allow(vsk, remote_cid)) {
 			module_put(new_transport->module);
 			return -ESOCKTNOSUPPORT;
 		}
@@ -676,6 +724,7 @@ static void vsock_pending_work(struct work_struct *work)
 static int __vsock_bind_connectible(struct vsock_sock *vsk,
 				    struct sockaddr_vm *addr)
 {
+	struct net *net = sock_net(sk_vsock(vsk));
 	static u32 port;
 	struct sockaddr_vm new_addr;
 
@@ -695,7 +744,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 
 			new_addr.svm_port = port++;
 
-			if (!__vsock_find_bound_socket(&new_addr)) {
+			if (!__vsock_find_bound_socket(&new_addr, net,
+						       vsk->orig_net_mode)) {
 				found = true;
 				break;
 			}
@@ -712,7 +762,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 			return -EACCES;
 		}
 
-		if (__vsock_find_bound_socket(&new_addr))
+		if (__vsock_find_bound_socket(&new_addr, net,
+					      vsk->orig_net_mode))
 			return -EADDRINUSE;
 	}
 
@@ -2552,6 +2603,7 @@ static int vsock_create(struct net *net, struct socket *sock,
 		return -ENOMEM;
 
 	vsk = vsock_sk(sk);
+	vsk->orig_net_mode = vsock_net_mode(net);
 
 	if (sock->type == SOCK_DGRAM) {
 		ret = vsock_assign_transport(vsk, NULL);
@@ -2636,6 +2688,139 @@ static struct miscdevice vsock_device = {
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
+		if (mode == VSOCK_NET_MODE_GLOBAL) {
+			p = VSOCK_NET_MODE_STR_GLOBAL;
+		} else if (mode == VSOCK_NET_MODE_LOCAL) {
+			p = VSOCK_NET_MODE_STR_LOCAL;
+		} else {
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
+	if (write) {
+		if (*lenp >= sizeof(data))
+			return -EINVAL;
+
+		if (!strncmp(data, VSOCK_NET_MODE_STR_GLOBAL, sizeof(data)))
+			mode = VSOCK_NET_MODE_GLOBAL;
+		else if (!strncmp(data, VSOCK_NET_MODE_STR_LOCAL, sizeof(data)))
+			mode = VSOCK_NET_MODE_LOCAL;
+		else
+			return -EINVAL;
+
+		if (!vsock_net_write_mode(net, mode))
+			return -EPERM;
+	}
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
+	net->vsock.vsock_hdr = register_net_sysctl_sz(net, "net/vsock", table,
+						      ARRAY_SIZE(vsock_table));
+	if (!net->vsock.vsock_hdr)
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
+	table = net->vsock.vsock_hdr->ctl_table_arg;
+	unregister_net_sysctl_table(net->vsock.vsock_hdr);
+	if (!net_eq(net, &init_net))
+		kfree(table);
+}
+
+static void vsock_net_init(struct net *net)
+{
+	spin_lock_init(&net->vsock.lock);
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
@@ -2663,10 +2848,19 @@ static int __init vsock_init(void)
 		goto err_unregister_proto;
 	}
 
+	if (register_pernet_subsys(&vsock_sysctl_ops)) {
+		err = -ENOMEM;
+		goto err_unregister_sock;
+	}
+
+	vsock_net_init(&init_net);
+	vsock_net_init(vsock_global_dummy_net());
 	vsock_bpf_build_proto();
 
 	return 0;
 
+err_unregister_sock:
+	sock_unregister(AF_VSOCK);
 err_unregister_proto:
 	proto_unregister(&vsock_proto);
 err_deregister_misc:
@@ -2680,6 +2874,7 @@ static void __exit vsock_exit(void)
 	misc_deregister(&vsock_device);
 	sock_unregister(AF_VSOCK);
 	proto_unregister(&vsock_proto);
+	unregister_pernet_subsys(&vsock_sysctl_ops);
 }
 
 const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 432fcbbd14d4..79bc55eeecb3 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -313,7 +313,7 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 		return;
 
 	hvs_addr_init(&addr, conn_from_host ? if_type : if_instance);
-	sk = vsock_find_bound_socket(&addr);
+	sk = vsock_find_bound_socket(&addr, vsock_global_dummy_net());
 	if (!sk)
 		return;
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index b6569b0ca2bb..4626ba0428ef 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -536,7 +536,7 @@ static bool virtio_transport_msgzerocopy_allow(void)
 	return true;
 }
 
-static bool virtio_transport_seqpacket_allow(u32 remote_cid);
+static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
 
 static struct virtio_transport virtio_transport = {
 	.transport = {
@@ -593,7 +593,7 @@ static struct virtio_transport virtio_transport = {
 	.can_msgzerocopy = virtio_transport_can_msgzerocopy,
 };
 
-static bool virtio_transport_seqpacket_allow(u32 remote_cid)
+static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
 	struct virtio_vsock *vsock;
 	bool seqpacket_allow;
@@ -659,6 +659,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			if (payload_len)
 				virtio_vsock_skb_put(skb, payload_len);
 
+			virtio_vsock_skb_set_net(skb, vsock_global_dummy_net());
+			virtio_vsock_skb_set_orig_net_mode(skb, VSOCK_NET_MODE_GLOBAL);
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
 		}
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e..1a9129e33d51 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1606,9 +1606,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket(&src, &dst);
+	sk = vsock_find_connected_socket(&src, &dst, vsock_global_dummy_net());
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst);
+		sk = vsock_find_bound_socket(&dst, vsock_global_dummy_net());
 		if (!sk) {
 			(void)virtio_transport_reset_no_sock(t, skb);
 			goto free_pkt;
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 7eccd6708d66..aa0cd2efe561 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -703,9 +703,11 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 	vsock_addr_init(&src, pkt->dg.src.context, pkt->src_port);
 	vsock_addr_init(&dst, pkt->dg.dst.context, pkt->dst_port);
 
-	sk = vsock_find_connected_socket(&src, &dst);
+	sk = vsock_find_connected_socket(&src, &dst, vsock_global_dummy_net(),
+					 VSOCK_NET_MODE_GLOBAL);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst);
+		sk = vsock_find_bound_socket(&dst, vsock_global_dummy_net(),
+					     VSOCK_NET_MODE_GLOBAL);
 		if (!sk) {
 			/* We could not find a socket for this specified
 			 * address.  If this packet is a RST, we just drop it.
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 6e78927a598e..1b2fab73e0d0 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -46,7 +46,7 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
 	return 0;
 }
 
-static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
+static bool vsock_loopback_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
 static bool vsock_loopback_msgzerocopy_allow(void)
 {
 	return true;
@@ -106,7 +106,7 @@ static struct virtio_transport loopback_transport = {
 	.send_pkt = vsock_loopback_send_pkt,
 };
 
-static bool vsock_loopback_seqpacket_allow(u32 remote_cid)
+static bool vsock_loopback_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
 	return true;
 }

-- 
2.47.3


