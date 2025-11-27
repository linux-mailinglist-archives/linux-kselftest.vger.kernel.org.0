Return-Path: <linux-kselftest+bounces-46608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A88B9C8D301
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 08:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A25184E23F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 07:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFD9324B20;
	Thu, 27 Nov 2025 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzlX5On4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BE2259CB9
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229670; cv=none; b=hLHdeIPQih1GXVyhj7ct5dcYqYmGHCecT41IwnHgGi+Hr+ogGpBYyeXM6z2hTFQqTDI6hjcYRftW1BalWzzamjjVLK+jmcgUwvGSDFOjLRPoViNvruMZJWCOLesn9xFKyuKb8WlRV1EWtNNWDjk0uCQTcQcqal7m0w22GLcRvOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229670; c=relaxed/simple;
	bh=T6s/fX8Bucka31KVWMy17BfL3WMBh4IIsLL1pa/KosM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TYWzfEJif+u6Jtw1DW3tmHDy1NpvRVQrZB2NrUIxaviZaDI1mgFC2W9jmOjsRZzTMMfLUvR3shIxlejMH6NchC7SMltKnxLWF8Bl+kshwmBOSSnTxtE4J4RcN5XmYdTHNqSl1WB8eYO33UcNOpJhDz3qkjMIIMRUZgZclJStgyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzlX5On4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3437ea05540so471152a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229665; x=1764834465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4Npic8zOzVcf89TgGtgLVFqx0Z9GiyZp0YFIxLZfDk=;
        b=RzlX5On4EDv5tFEofQVTTEzhqO/I72HGFEu5GS3uaAnjjrRyx4RFUSoUI4Mv1pr/u/
         fDjCdUjQAbLCOo60NiuhwCcFEcZcNP4mCJySCCqZTJ+nWKqCK3fix5dJbiISRMJv6CJq
         m2xBHePNvXdXEWMGIEGOOn1/R48CIxONnDAto1AXugwGzbl7+MEmPzJTre5Z4tQ7AHki
         vwjw7iAkNN78YSNbQIX39MVW+Rdo7qC61+0gvFbO2bdQMEdV/rqQRCG51ziMQw4mirwH
         RAo6DZupxQPhtWFPju7aYhZC/qS0mk/XwbhagqpilihIBuLc3U2Huod9OWJT7nvk/gvF
         ZMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229665; x=1764834465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U4Npic8zOzVcf89TgGtgLVFqx0Z9GiyZp0YFIxLZfDk=;
        b=DvFq+5OESyP1wBb0VdeVmtwfD9c0wKiM9HYkNL8i1Ms9ZKTEC87kyfuZYLjiItvM5N
         gCpsV4dXCP7/O7jKPPPLs6V15wAFN9AoKM7vM1H/XO8NdwaUc5nPaooxpHBXIbqg6gOR
         ip7YLPDDUqIFQGcDMNKmf1ZTNpJbGNJD7Cpp56w91q9UT5ucA8FT76ZHadfOTSHDBVdu
         IpjhTl64i8l6+TZ6vhzjP8af+95Evwf+wrssgb5m9TuIyMcvBjANQqrNq5lO0lCfLQU1
         kAv7f2LvsnFA6hJtLZCMefM0Di9zgvKYJaF9tcNvirBONyRKE8555Zrwux/OdXsBB1kL
         75IA==
X-Forwarded-Encrypted: i=1; AJvYcCXZm0PwC3B6SPMCjKYcZsIYqPMBqYB3VE7pasfMzQSJnh1HQ390+eT+QwCkMOhhgD/7Fjha6ikHJU8MmHhAkrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw0ZIPw3RWyZMZYW7R2uryZInt6OfL/eojlBIiVWleNIhux0Rx
	5w7D3M+45XCe6aq8S+pf8U0wzxi2S7GNgI7vNVwT7b1rgFHjEo+22l0x
X-Gm-Gg: ASbGncvrJAOcC6LAYyjfAY31dbmFu3vUzoNuYYq3kctZg/XuHtcYoXGeXCJyWeIddrH
	Vq6b+DYFNJ9o2NgggA9snsyiwb6i9/BZnzGnVr8itI7FOmITBj3I/5QBhPR8oQpt7bJh+EkIcsV
	UHJk4BvB+MTGUIva3Lbbo4xGI4AoRxP5EqKs0hFZ/eAwltsdvlIpMu7SIYrrCTudN9K+xQVtYpj
	bzg3oHTKuTdqFvjicwxZj/n2XYDwtnxIBMRDYW7iXXaksqO+Qc8AWjRJcABPWOVXimkDoyx9MMr
	wxbywSqxoRVKWp/8uJJuZ7A9IyNxsQtH4tNq75KOExf+0A0AbQsa9yhZ5CZN1NtdPbMqLFauaUj
	SFWAtU/RzNHhUnmr01yIe+7yzXyocmWnxJxNUBVnRRSoPSmVj1W2EcZuZOkqHmxf2O+QLJ7XlfG
	5hSzOo4m0CMivV+FMfbTPc
X-Google-Smtp-Source: AGHT+IHBtIt9JCJ+DA/JKejK6HYrRdIPxkE/b/YHn1NhW2KqkAfkUoLDYpPZJuOdacv8K8hbgnV1OA==
X-Received: by 2002:a17:90b:2d46:b0:340:bb56:79de with SMTP id 98e67ed59e1d1-34733f4a9c3mr20146201a91.30.1764229664982;
        Wed, 26 Nov 2025 23:47:44 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a7e8b65sm4686924a91.17.2025.11.26.23.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:47:44 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 26 Nov 2025 23:47:31 -0800
Subject: [PATCH net-next v12 02/12] vsock: add netns to vsock core
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-vsock-vmtest-v12-2-257ee21cd5de@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
In-Reply-To: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
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

dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
modified to take a vsk in order to perform logic on namespace modes. In
future patches, the net and net_mode will also be used for socket
lookups in these functions.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v12:
- return true in dgram_allow(), stream_allow(), and seqpacket_allow()
  only if net_mode == VSOCK_NET_MODE_GLOBAL (Stefano)
- document bind(VMADDR_CID_ANY) case in af_vsock.c (Stefano)
- change order of stream_allow() call in vmci so we can pass vsk
  to it

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
 drivers/vhost/vsock.c                   |   9 +-
 include/linux/virtio_vsock.h            |   4 +-
 include/net/af_vsock.h                  |  13 +-
 net/vmw_vsock/af_vsock.c                | 272 +++++++++++++++++++++++++++++---
 net/vmw_vsock/hyperv_transport.c        |   7 +-
 net/vmw_vsock/virtio_transport.c        |   9 +-
 net/vmw_vsock/virtio_transport_common.c |   6 +-
 net/vmw_vsock/vmci_transport.c          |  26 ++-
 net/vmw_vsock/vsock_loopback.c          |   8 +-
 9 files changed, 310 insertions(+), 44 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ae01457ea2cd..83937e1d63fa 100644
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
@@ -460,11 +461,15 @@ static struct virtio_transport vhost_transport = {
 	.send_pkt = vhost_transport_send_pkt,
 };
 
-static bool vhost_transport_seqpacket_allow(u32 remote_cid)
+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
+					    u32 remote_cid)
 {
 	struct vhost_vsock *vsock;
 	bool seqpacket_allow = false;
 
+	if (vsk->net_mode != VSOCK_NET_MODE_GLOBAL)
+		return false;
+
 	rcu_read_lock();
 	vsock = vhost_vsock_get(remote_cid);
 
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0c67543a45c8..1845e8d4f78d 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -256,10 +256,10 @@ void virtio_transport_notify_buffer_size(struct vsock_sock *vsk, u64 *val);
 
 u64 virtio_transport_stream_rcvhiwat(struct vsock_sock *vsk);
 bool virtio_transport_stream_is_active(struct vsock_sock *vsk);
-bool virtio_transport_stream_allow(u32 cid, u32 port);
+bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port);
 int virtio_transport_dgram_bind(struct vsock_sock *vsk,
 				struct sockaddr_vm *addr);
-bool virtio_transport_dgram_allow(u32 cid, u32 port);
+bool virtio_transport_dgram_allow(struct vsock_sock *vsk, u32 cid, u32 port);
 
 int virtio_transport_connect(struct vsock_sock *vsk);
 
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 9b5bdd083b6f..d10e73cd7413 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -126,7 +126,7 @@ struct vsock_transport {
 			     size_t len, int flags);
 	int (*dgram_enqueue)(struct vsock_sock *, struct sockaddr_vm *,
 			     struct msghdr *, size_t len);
-	bool (*dgram_allow)(u32 cid, u32 port);
+	bool (*dgram_allow)(struct vsock_sock *vsk, u32 cid, u32 port);
 
 	/* STREAM. */
 	/* TODO: stream_bind() */
@@ -138,14 +138,14 @@ struct vsock_transport {
 	s64 (*stream_has_space)(struct vsock_sock *);
 	u64 (*stream_rcvhiwat)(struct vsock_sock *);
 	bool (*stream_is_active)(struct vsock_sock *);
-	bool (*stream_allow)(u32 cid, u32 port);
+	bool (*stream_allow)(struct vsock_sock *vsk, u32 cid, u32 port);
 
 	/* SEQ_PACKET. */
 	ssize_t (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
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
index adcba1b7bf74..6113c22db8dc 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -83,6 +83,46 @@
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
+ *     - sockets bound to VMADDR_CID_ANY in local namespaces will never resolve
+ *       to any transport that is not compatible with local mode. There is no
+ *       error that propagates to the user (as there is for connection attempts)
+ *       because it is possible for some packet to reach this socket from
+ *       a different transport that *does* support local mode. For
+ *       example, virtio-vsock may not support local mode, but the socket
+ *       may still accept a connection from vhost-vsock which does.
+ *
+ *   - when a socket or device is initialized in a namespace with mode
+ *     global, it will stay in global mode even if the namespace later
+ *     changes to local.
  */
 
 #include <linux/compat.h>
@@ -100,6 +140,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/net.h>
+#include <linux/proc_fs.h>
 #include <linux/poll.h>
 #include <linux/random.h>
 #include <linux/skbuff.h>
@@ -111,9 +152,18 @@
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
@@ -235,33 +285,47 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
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
 
@@ -304,12 +368,14 @@ void vsock_remove_connected(struct vsock_sock *vsk)
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
 
@@ -317,15 +383,23 @@ struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
 
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
 
@@ -333,6 +407,14 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 
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
@@ -528,7 +610,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
-		    !new_transport->seqpacket_allow(remote_cid)) {
+		    !new_transport->seqpacket_allow(vsk, remote_cid)) {
 			module_put(new_transport->module);
 			return -ESOCKTNOSUPPORT;
 		}
@@ -676,6 +758,7 @@ static void vsock_pending_work(struct work_struct *work)
 static int __vsock_bind_connectible(struct vsock_sock *vsk,
 				    struct sockaddr_vm *addr)
 {
+	struct net *net = sock_net(sk_vsock(vsk));
 	static u32 port;
 	struct sockaddr_vm new_addr;
 
@@ -695,7 +778,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 
 			new_addr.svm_port = port++;
 
-			if (!__vsock_find_bound_socket(&new_addr)) {
+			if (!__vsock_find_bound_socket_net(&new_addr, net,
+							   vsk->net_mode)) {
 				found = true;
 				break;
 			}
@@ -712,7 +796,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 			return -EACCES;
 		}
 
-		if (__vsock_find_bound_socket(&new_addr))
+		if (__vsock_find_bound_socket_net(&new_addr, net,
+						  vsk->net_mode))
 			return -EADDRINUSE;
 	}
 
@@ -836,6 +921,8 @@ static struct sock *__vsock_create(struct net *net,
 		vsk->buffer_max_size = VSOCK_DEFAULT_BUFFER_MAX_SIZE;
 	}
 
+	vsk->net_mode = vsock_net_mode(net);
+
 	return sk;
 }
 
@@ -1314,7 +1401,7 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out;
 	}
 
-	if (!transport->dgram_allow(remote_addr->svm_cid,
+	if (!transport->dgram_allow(vsk, remote_addr->svm_cid,
 				    remote_addr->svm_port)) {
 		err = -EINVAL;
 		goto out;
@@ -1355,7 +1442,7 @@ static int vsock_dgram_connect(struct socket *sock,
 	if (err)
 		goto out;
 
-	if (!vsk->transport->dgram_allow(remote_addr->svm_cid,
+	if (!vsk->transport->dgram_allow(vsk, remote_addr->svm_cid,
 					 remote_addr->svm_port)) {
 		err = -EINVAL;
 		goto out;
@@ -1585,7 +1672,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		 * endpoints.
 		 */
 		if (!transport ||
-		    !transport->stream_allow(remote_addr->svm_cid,
+		    !transport->stream_allow(vsk, remote_addr->svm_cid,
 					     remote_addr->svm_port)) {
 			err = -ENETUNREACH;
 			goto out;
@@ -2658,6 +2745,142 @@ static struct miscdevice vsock_device = {
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
@@ -2685,10 +2908,18 @@ static int __init vsock_init(void)
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
@@ -2702,6 +2933,7 @@ static void __exit vsock_exit(void)
 	misc_deregister(&vsock_device);
 	sock_unregister(AF_VSOCK);
 	proto_unregister(&vsock_proto);
+	unregister_pernet_subsys(&vsock_sysctl_ops);
 }
 
 const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 432fcbbd14d4..b2ade188c8c7 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -570,7 +570,7 @@ static int hvs_dgram_enqueue(struct vsock_sock *vsk,
 	return -EOPNOTSUPP;
 }
 
-static bool hvs_dgram_allow(u32 cid, u32 port)
+static bool hvs_dgram_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 {
 	return false;
 }
@@ -745,8 +745,11 @@ static bool hvs_stream_is_active(struct vsock_sock *vsk)
 	return hvs->chan != NULL;
 }
 
-static bool hvs_stream_allow(u32 cid, u32 port)
+static bool hvs_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 {
+	if (vsk->net_mode != VSOCK_NET_MODE_GLOBAL)
+		return false;
+
 	if (cid == VMADDR_CID_HOST)
 		return true;
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 8c867023a2e5..f5123810192d 100644
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
@@ -593,11 +594,15 @@ static struct virtio_transport virtio_transport = {
 	.can_msgzerocopy = virtio_transport_can_msgzerocopy,
 };
 
-static bool virtio_transport_seqpacket_allow(u32 remote_cid)
+static bool
+virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
 	struct virtio_vsock *vsock;
 	bool seqpacket_allow;
 
+	if (vsk->net_mode != VSOCK_NET_MODE_GLOBAL)
+		return false;
+
 	seqpacket_allow = false;
 	rcu_read_lock();
 	vsock = rcu_dereference(the_virtio_vsock);
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e..e6391eb7cc1b 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1043,9 +1043,9 @@ bool virtio_transport_stream_is_active(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_stream_is_active);
 
-bool virtio_transport_stream_allow(u32 cid, u32 port)
+bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 {
-	return true;
+	return vsk->net_mode == VSOCK_NET_MODE_GLOBAL;
 }
 EXPORT_SYMBOL_GPL(virtio_transport_stream_allow);
 
@@ -1056,7 +1056,7 @@ int virtio_transport_dgram_bind(struct vsock_sock *vsk,
 }
 EXPORT_SYMBOL_GPL(virtio_transport_dgram_bind);
 
-bool virtio_transport_dgram_allow(u32 cid, u32 port)
+bool virtio_transport_dgram_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 {
 	return false;
 }
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 7eccd6708d66..0ce44dc11708 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -646,13 +646,17 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
 	return VMCI_SUCCESS;
 }
 
-static bool vmci_transport_stream_allow(u32 cid, u32 port)
+static bool vmci_transport_stream_allow(struct vsock_sock *vsk, u32 cid,
+					u32 port)
 {
 	static const u32 non_socket_contexts[] = {
 		VMADDR_CID_LOCAL,
 	};
 	int i;
 
+	if (vsk->net_mode != VSOCK_NET_MODE_GLOBAL)
+		return false;
+
 	BUILD_BUG_ON(sizeof(cid) != sizeof(*non_socket_contexts));
 
 	for (i = 0; i < ARRAY_SIZE(non_socket_contexts); i++) {
@@ -682,12 +686,10 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 	err = VMCI_SUCCESS;
 	bh_process_pkt = false;
 
-	/* Ignore incoming packets from contexts without sockets, or resources
-	 * that aren't vsock implementations.
+	/* Ignore incoming packets from resources that aren't vsock
+	 * implementations.
 	 */
-
-	if (!vmci_transport_stream_allow(dg->src.context, -1)
-	    || vmci_transport_peer_rid(dg->src.context) != dg->src.resource)
+	if (vmci_transport_peer_rid(dg->src.context) != dg->src.resource)
 		return VMCI_ERROR_NO_ACCESS;
 
 	if (VMCI_DG_SIZE(dg) < sizeof(*pkt))
@@ -749,6 +751,12 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 		goto out;
 	}
 
+	/* Ignore incoming packets from contexts without sockets. */
+	if (!vmci_transport_stream_allow(vsk, dg->src.context, -1)) {
+		err = VMCI_ERROR_NO_ACCESS;
+		goto out;
+	}
+
 	/* We do most everything in a work queue, but let's fast path the
 	 * notification of reads and writes to help data transfer performance.
 	 * We can only do this if there is no process context code executing
@@ -1784,8 +1792,12 @@ static int vmci_transport_dgram_dequeue(struct vsock_sock *vsk,
 	return err;
 }
 
-static bool vmci_transport_dgram_allow(u32 cid, u32 port)
+static bool vmci_transport_dgram_allow(struct vsock_sock *vsk, u32 cid,
+				       u32 port)
 {
+	if (vsk->net_mode != VSOCK_NET_MODE_GLOBAL)
+		return false;
+
 	if (cid == VMADDR_CID_HYPERVISOR) {
 		/* Registrations of PBRPC Servers do not modify VMX/Hypervisor
 		 * state and are allowed.
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index bc2ff918b315..afad27cf533a 100644
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
@@ -106,9 +107,10 @@ static struct virtio_transport loopback_transport = {
 	.send_pkt = vsock_loopback_send_pkt,
 };
 
-static bool vsock_loopback_seqpacket_allow(u32 remote_cid)
+static bool
+vsock_loopback_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
-	return true;
+	return vsk->net_mode == VSOCK_NET_MODE_GLOBAL;
 }
 
 static void vsock_loopback_work(struct work_struct *work)

-- 
2.47.3


