Return-Path: <linux-kselftest+bounces-43699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BC027BF94C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 415E434C9FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389482D47F3;
	Tue, 21 Oct 2025 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQdYE0pe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC04280A20
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090427; cv=none; b=asMxzUPyWqvaLQOcyC5/COV5Tjlg9oA8OLV0V2r9X5XL3RAWCo7uayFQSVcHXgbcyfiqNIMMOfUrBoSa/EpdeaFGY9zBr1MuddF803q/By9HzZcPJZ+TgJNX0mwmjbvLkg0QVWakXXqdeyi8qmt3DBolTkiYJ7Iif4th+anSDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090427; c=relaxed/simple;
	bh=GtyaFuzJJX8jfKCqFonp4Cj4tskZ5I+JWcBskB+9s6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q3c+zgtmir0Uz+X9hbB2EG+VerBRbtiKiYZC2UbivvIrdr9xKRrq9wmJgLmpgA0QsY/qqgYMl0FQeG+aazAl2fsDq9k8YQUENEJnP0INd/A4WBnNJqTPfECV8id8cqGAZwy2Uj0lXkJHvENwTtAEo3D+FcOu7LhqIAI6E5KsJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQdYE0pe; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2909448641eso4563595ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090423; x=1761695223; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVT8/vbk2Dwkc2btDL18ryDEaCXcT4l9KMvPSWvGOYI=;
        b=HQdYE0peEkwwBgT3joT+Hj6jW9n7wEahkVcTGxc7OMUIClo1ft7LwUnM9n2ve9pT8J
         U8l1LCHuo6w6e78F0DXNnARiFYAwBoSMJ9kP0OOQuoFzjCXs457HjGD3944kBmutj0YG
         PpzE1UrOL+WJB526YVGyXfhRY/01NM2po12Km6DhnvCYNrCNRyIPekdAnAAu6jEuJBSW
         gCEp28Vzrk9eZ9wHnuAza7S1XrDFH1WXAUlsjwlNWsQMcQFmq2P6ECj1BmONQM1rvPvb
         FlPJmu+s5QD4q9M4xyNRYUpYKcDhga03QZriC1TbLVfk6g1u7RcPBiWKhhwoFNXpoiZ8
         Ac0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090423; x=1761695223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVT8/vbk2Dwkc2btDL18ryDEaCXcT4l9KMvPSWvGOYI=;
        b=jYBxPjPWcDxqeUTXW4RH6sYi9LotFzVP+HZqnA7VSnMcuyqVDgxiwqPyElu9SDPZV5
         KT4sdnVH6oZFcYnhwiGyGPE99NYoQcGYinML/ooCTml/D1D6Th8mQ4GL2I9Kc7UGoa2Y
         MYQaCM4eQYx1sMd9h0HngTcPhK5x69FyTGveij9LTCuDcZpBjBgvHNsfEZmC67o92zuT
         aA0GOgQ17J6ymF79mR1oxuRNSMLyodiFiiuJ3ck8k+85b+or9otHBCUS8s8keu+nsAeH
         BL4wY0e21BztLeA7+5nF+gfpvacoVlHXf+ApGTWZjPFQqG+qdl1q/J12fSF/T4sDP0as
         Jkyw==
X-Forwarded-Encrypted: i=1; AJvYcCXDWtn8vrZgCB0iNI7I3H/A3uatc7KXoihbNewww1SZIUrfczX5V7tDwtxPfVZv3DYjy8lLKIC0O7W7UL/s14Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCxl+Zj2rB2wtnwjbFHn+NDG/xIbOGxeInYx80GOcwIZOGbAq
	3Oo91vFWbXySkRPPZKSFcoIDWnMMFt0q912RQu+GIXMY0X7InzT8T5HU
X-Gm-Gg: ASbGncsG44SAHyfObGJkfT+A9gMws8428fMTct69JIZAHZfuU+q9MHXHqHi8C0eDjPH
	Dj35z3+voYG51RCF3qE9dRXvjkn7U6qIYqPHHnJihkkF0WhEXvqCAF4sT895P6bv6zyGiENNLNN
	tnzgNMSBEmp5EixDoi2OyRFHmKSz7yVi9/M6qgg3ilrFhymXRXGtPWDTvikToPzeBuFTB2sk0Q6
	OPejICK0w0muyLd9ZfI2kDCosDFNFLgAzhLvumJWCJPWG5wyBYWXbTMcI9OwnZJ3iuywh0a6l35
	TUS1BHEj+QpzIFX1X853KBImDd/kxLUsW87UYGLASu+BcwonW3C5zCSrjOqPR3hxl3DxG9mk6Uq
	qP0hWHmipGgCQb9Fs+9fZxWzqb9Qehc+NkM21V/NaWfpxKjGsVZ9hKW+fqjUUAN09nKqfflWOHw
	==
X-Google-Smtp-Source: AGHT+IGsla5uQbo7baJpMMbqxDNWNN5X/yyfI2WtWFNCLvR6MbNErjTDjVu0GTw7Flf8fecDXkXlBA==
X-Received: by 2002:a17:903:37c3:b0:25c:43f7:7e40 with SMTP id d9443c01a7336-292ffbd13afmr20146345ad.10.1761090422531;
        Tue, 21 Oct 2025 16:47:02 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5c0bsm120140175ad.69.2025.10.21.16.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:02 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:47 -0700
Subject: [PATCH net-next v7 04/26] vsock: add netns to vsock core
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-4-0661b7b6f081@meta.com>
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

Add netns logic to vsock core. Additionally, modify transport hook
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

The transports (besides vhost) are modified to use the global dummy,
which makes them behave as if always in the global namespace. Vhost is
an exception because it inherits its namespace from the process that
opens the vhost device.

Add netns functionality (initialization, passing to transports, procfs,
etc...) to the af_vsock socket layer. Later patches that add netns
support to transports depend on this patch.

seqpacket_allow() callbacks are modified to take a vsk so that transport
implementations can inspect sock_net(sk) and vsk->net_mode when performing
lookups (e.g., vhost does this in its future netns patch). Because the
API change affects all transports, it seemed more appropriate to make
this internal API change in the "vsock core" patch then in the "vhost"
patch.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
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
 drivers/vhost/vsock.c            |   4 +-
 include/linux/virtio_vsock.h     |  21 ++++
 include/net/af_vsock.h           |  14 ++-
 net/vmw_vsock/af_vsock.c         | 264 ++++++++++++++++++++++++++++++++++++---
 net/vmw_vsock/virtio_transport.c |   7 +-
 net/vmw_vsock/vsock_loopback.c   |   4 +-
 6 files changed, 288 insertions(+), 26 deletions(-)

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
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 7f334a32133c..29290395054c 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -153,6 +153,27 @@ static inline void virtio_vsock_skb_set_net_mode(struct sk_buff *skb,
 	VIRTIO_VSOCK_SKB_CB(skb)->net_mode = net_mode;
 }
 
+static inline struct sk_buff *
+virtio_vsock_alloc_rx_skb(unsigned int size, gfp_t mask)
+{
+	struct sk_buff *skb;
+
+	skb = virtio_vsock_alloc_linear_skb(size, mask);
+	if (!skb)
+		return NULL;
+
+	memset(skb->head, 0, VIRTIO_VSOCK_SKB_HEADROOM);
+
+	/* virtio-vsock does not yet support namespaces, so on receive
+	 * we force legacy namespace behavior using the global dummy net
+	 * and global net mode.
+	 */
+	virtio_vsock_skb_set_net(skb, vsock_global_dummy_net());
+	virtio_vsock_skb_set_net_mode(skb, VSOCK_NET_MODE_GLOBAL);
+
+	return skb;
+}
+
 /* Dimension the RX SKB so that the entire thing fits exactly into
  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
  * rounding up to the next page order and also means that we
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index a1053d3668cf..30e65f677550 100644
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
@@ -218,6 +218,12 @@ void vsock_remove_connected(struct vsock_sock *vsk);
 struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
 struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 					 struct sockaddr_vm *dst);
+struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr, struct net *net,
+					 enum vsock_net_mode net_mode);
+struct sock *vsock_find_connected_socket_net(struct sockaddr_vm *src,
+					     struct sockaddr_vm *dst,
+					     struct net *net,
+					     enum vsock_net_mode net_mode);
 void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
@@ -259,6 +265,12 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
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
index 4c2db6cca557..656a78810c68 100644
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
+ *
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
@@ -111,9 +141,18 @@
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
@@ -149,6 +188,15 @@ static const struct vsock_transport *transport_dgram;
 static const struct vsock_transport *transport_local;
 static DEFINE_MUTEX(vsock_register_mutex);
 
+/* This net is used only for transports that do support namespaces. It is never
+ * registered with the namespace subsystem and always has
+ * VSOCK_NET_MODE_GLOBAL. Pass this net to the net lookup functions (e.g.,
+ * vsock_find_bound_socket_net()) when you want to force global-mode or the
+ * same behavior as before namespaces were supported.
+ */
+struct net __vsock_global_dummy_net;
+EXPORT_SYMBOL_GPL(__vsock_global_dummy_net);
+
 /**** UTILS ****/
 
 /* Each bound VSocket is stored in the bind hash table and each connected
@@ -235,33 +283,44 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
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
+		    vsock_net_check_mode(sock_net(sk), vsk->net_mode, net, net_mode))
+			return sk;
 
 		if (addr->svm_port == vsk->local_addr.svm_port &&
 		    (vsk->local_addr.svm_cid == VMADDR_CID_ANY ||
-		     addr->svm_cid == VMADDR_CID_ANY))
-			return sk_vsock(vsk);
+		     addr->svm_cid == VMADDR_CID_ANY) &&
+		     vsock_net_check_mode(sock_net(sk), vsk->net_mode, net, net_mode))
+			return sk;
 	}
 
 	return NULL;
 }
 
-static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
-						  struct sockaddr_vm *dst)
+static struct sock *__vsock_find_connected_socket_net(struct sockaddr_vm *src,
+						      struct sockaddr_vm *dst,
+						      struct net *net,
+						      enum vsock_net_mode net_mode)
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
+		    vsock_net_check_mode(sock_net(sk), vsk->net_mode, net, net_mode)) {
+			return sk;
 		}
 	}
 
@@ -304,12 +363,14 @@ void vsock_remove_connected(struct vsock_sock *vsk)
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
 
@@ -317,15 +378,24 @@ struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
 
 	return sk;
 }
+EXPORT_SYMBOL_GPL(vsock_find_bound_socket_net);
+
+struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
+{
+	return vsock_find_bound_socket_net(addr, vsock_global_dummy_net(),
+					   VSOCK_NET_MODE_GLOBAL);
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
 
@@ -333,6 +403,15 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 
 	return sk;
 }
+EXPORT_SYMBOL_GPL(vsock_find_connected_socket_net);
+
+struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
+					 struct sockaddr_vm *dst)
+{
+	return vsock_find_connected_socket_net(src, dst,
+					       vsock_global_dummy_net(),
+					       VSOCK_NET_MODE_GLOBAL);
+}
 EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
 
 void vsock_remove_sock(struct vsock_sock *vsk)
@@ -528,7 +607,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
-		    !new_transport->seqpacket_allow(remote_cid)) {
+		    !new_transport->seqpacket_allow(vsk, remote_cid)) {
 			module_put(new_transport->module);
 			return -ESOCKTNOSUPPORT;
 		}
@@ -676,6 +755,7 @@ static void vsock_pending_work(struct work_struct *work)
 static int __vsock_bind_connectible(struct vsock_sock *vsk,
 				    struct sockaddr_vm *addr)
 {
+	struct net *net = sock_net(sk_vsock(vsk));
 	static u32 port;
 	struct sockaddr_vm new_addr;
 
@@ -695,7 +775,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 
 			new_addr.svm_port = port++;
 
-			if (!__vsock_find_bound_socket(&new_addr)) {
+			if (!__vsock_find_bound_socket_net(&new_addr, net,
+							   vsk->net_mode)) {
 				found = true;
 				break;
 			}
@@ -712,7 +793,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 			return -EACCES;
 		}
 
-		if (__vsock_find_bound_socket(&new_addr))
+		if (__vsock_find_bound_socket_net(&new_addr, net,
+						  vsk->net_mode))
 			return -EADDRINUSE;
 	}
 
@@ -836,6 +918,8 @@ static struct sock *__vsock_create(struct net *net,
 		vsk->buffer_max_size = VSOCK_DEFAULT_BUFFER_MAX_SIZE;
 	}
 
+	vsk->net_mode = vsock_net_mode(net);
+
 	return sk;
 }
 
@@ -2636,6 +2720,142 @@ static struct miscdevice vsock_device = {
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
@@ -2663,10 +2883,19 @@ static int __init vsock_init(void)
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
@@ -2680,6 +2909,7 @@ static void __exit vsock_exit(void)
 	misc_deregister(&vsock_device);
 	sock_unregister(AF_VSOCK);
 	proto_unregister(&vsock_proto);
+	unregister_pernet_subsys(&vsock_sysctl_ops);
 }
 
 const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 8c867023a2e5..6abec6b9b5bc 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -316,11 +316,10 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
 	vq = vsock->vqs[VSOCK_VQ_RX];
 
 	do {
-		skb = virtio_vsock_alloc_linear_skb(total_len, GFP_KERNEL);
+		skb = virtio_vsock_alloc_rx_skb(total_len, GFP_KERNEL);
 		if (!skb)
 			break;
 
-		memset(skb->head, 0, VIRTIO_VSOCK_SKB_HEADROOM);
 		sg_init_one(&pkt, virtio_vsock_hdr(skb), total_len);
 		p = &pkt;
 		ret = virtqueue_add_sgs(vq, &p, 0, 1, skb, GFP_KERNEL);
@@ -536,7 +535,7 @@ static bool virtio_transport_msgzerocopy_allow(void)
 	return true;
 }
 
-static bool virtio_transport_seqpacket_allow(u32 remote_cid);
+static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
 
 static struct virtio_transport virtio_transport = {
 	.transport = {
@@ -593,7 +592,7 @@ static struct virtio_transport virtio_transport = {
 	.can_msgzerocopy = virtio_transport_can_msgzerocopy,
 };
 
-static bool virtio_transport_seqpacket_allow(u32 remote_cid)
+static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
 	struct virtio_vsock *vsock;
 	bool seqpacket_allow;
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index bc2ff918b315..a8f218f0c5a3 100644
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


