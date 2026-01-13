Return-Path: <linux-kselftest+bounces-48838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEC0D16A7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 06:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CDE13019B50
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 05:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB36301477;
	Tue, 13 Jan 2026 05:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcTMp7w3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338A121D585
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 05:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768280884; cv=none; b=tZIPJZYqSHCEYwrh5XG0QL6ddawmIwvzCcAiZPJDPAe8q9sB6RmgORsKqv1e7ukHMpfyHLLbPmn2tgP4IIRV+/RdrfRCMauI8Rp9ZPh/D3GiH4mQ5fgCFst+vFIx/lpJ5RBPUJgT0vIC3PvXx7iril7pBoJ6DtlTbjeCgZbE5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768280884; c=relaxed/simple;
	bh=xHtnIgqs3vze4140hxG8bTd9/9LAQAqZnX41h8vUJWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fB1af97AiD9KB/u0/BI5dV/v4k/SPunqXw/xvEBOFqM1RZcrBWsPMzqaDZ9cQTIsd827X27b2uYxcPq4cLk20OlEdXVW3tyFOixwcCsBXe1SuSRMiLMoMAxAkq/e9va088gizd3GzlOq4jmsVdbXSXCLHNXwD6kESzB+GnfyL5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcTMp7w3; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-11f1fb91996so11804960c88.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 21:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768280881; x=1768885681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSO57OwG5eniOhR1EKTYkXsID/hSq6h5q6L3BXT/21o=;
        b=UcTMp7w3juMFu9B5PNlzOaYfDA8GGPEg17TYlbiUHL/cwOSQ3disvB7/kvB3GObNQV
         jiwKpH4Ht9goRnFXJFtSvOcqxgrMCM78VjGE80VeBuvAOm+5Qtr/E+fGNj4ZcHeamg6D
         Jsg/KeahQ16dKNDm1RpsOMRRgCTfUy1ykn90cMLvJ/zWzoYsU16mSO45Vf2HtsHRgTMD
         1jClLg28zoVGegIkwQRpesblyPs3t9ucQNQ1IXq03eyXx9DEW3SC/Qa/pOl/nTrAmmUg
         ZzpFuUur7JvI5Ppf4QefG7HmkK3N2ylkRsCNwyOIIBFroORulEJmSTYrAS3foZP1ASDt
         0QeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768280881; x=1768885681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xSO57OwG5eniOhR1EKTYkXsID/hSq6h5q6L3BXT/21o=;
        b=GiKdpoh0nsK0aj71zDaXqLTQ3mfDmBfGAOh1pgvYtBy/y4T0n8Brnm5aVSNiNYCC9J
         qBO2KlKL41Jg3hveRu3HHj5u2NIrVdgZin3hORJG9/KULOyh2hbcWsS07OrixpjezogH
         8qyKveFUmzy7IrjyvUtszqLpLVu8kw/Jgc9XDpb6aEDHTDyeSJ/qoDHkxn4CRSWrmbcD
         dgdl3BaRDehLAOqNMhP39+wUl5Bfiz7OYUv7x9QPhwTRwAV/AQvY2DC/6nAwwb/7bwKs
         FWcEsupbQTlu5BfWK/QyDZ3qofqtNnJZ/zD5qGA9BpXNwODqjYHShxUiEnveSLOc82zq
         JXzw==
X-Forwarded-Encrypted: i=1; AJvYcCVEpoJQgQ/LhUvVAWG20C84d99dLO4pC6A6tQLhQBC5gFFlyCjZyoPUfKHXPga0etCPou+nbEtc2ANYFR+CFTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCGafq2sVgPnp/ebTOG4iun8MQOt1WS1JqSMl3ZF7g4wrN93fX
	Hm27sT6XEpOO1PdElABLhPgkH3lXCjh99CB1bst58QP4e2Z49JKlNRC6eqHXoQ==
X-Gm-Gg: AY/fxX6sWflIRe/krHwB9YaXiHh2lx1mS/EGlMu6h1VasFLECEhqU83FtK/uxXicQ52
	au9PC+QUBnqmljJuPqHkLgnZKs0BPtd1/zqdh8zliUro5iloTwtXFKWO2U9kL3rRJQA8sNzSt7n
	TW5e+8H8vpe6DPUO92rNndHjppxISZp18OxM9CPXjfqSiU8HqP3h4NGpCv+TxA9ZBDIt5OIAX6h
	QeKA7WABwZmPFCNFcZPipu1dgkJZ7aZzuGHa/DEq6b6mpXYtts3+ige4Y58pfn2a8t8pArkJPVw
	gtvRkUcTZZ/h4fKcxjtY+yukHBcjS2PZZWyuC7wgIISam1Fc6ow2tphT3WZLNYZT3AJ0qcprTXS
	VB0fndcxsIF9l1cWveDD4x8gN+TRBHPVtX7v6/TK6umVxPkUrq3dwCBMgC8dLWt1DRil7sfpqJX
	E6TGa0x3PBvw==
X-Google-Smtp-Source: AGHT+IEIazjEFt0KjlYaN86g3m33AhrfVybRtDkNP2tK2+nhijbdQ40AwYF9glvlc73rh/+sfvwxHw==
X-Received: by 2002:a05:690e:1907:b0:63c:ed4b:e53 with SMTP id 956f58d0204a3-64716b73205mr16199421d50.25.1768273977025;
        Mon, 12 Jan 2026 19:12:57 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:57::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa553750sm75817077b3.9.2026.01.12.19.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:12:56 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:10 -0800
Subject: [PATCH net-next v14 01/12] vsock: add netns to vsock core
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-1-a5c332db3e2b@meta.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
In-Reply-To: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
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

Add netns logic to vsock core. Additionally, modify transport hook
prototypes to be used by later transport-specific patches (e.g.,
*_seqpacket_allow()).

Namespaces are supported primarily by changing socket lookup functions
(e.g., vsock_find_connected_socket()) to take into account the socket
namespace and the namespace mode before considering a candidate socket a
"match".

This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode to
report the mode and /proc/sys/net/vsock/child_ns_mode to set the mode
for new namespaces.

Add netns functionality (initialization, passing to transports, procfs,
etc...) to the af_vsock socket layer. Later patches that add netns
support to transports depend on this patch.

dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
modified to take a vsk in order to perform logic on namespace modes. In
future patches, the net will also be used for socket
lookups in these functions.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v14:
- include linux/sysctl.h in af_vsock.c
- squash patch 'vsock: add per-net vsock NS mode state' into this patch
  (prior version can be found here):
  https://lore.kernel.org/all/20251223-vsock-vmtest-v13-1-9d6db8e7c80b@meta.com/)

Changes in v13:
- remove net_mode and replace with direct accesses to net->vsock.mode,
  since this is now immutable.
- update comments about mode behavior and mutability, and sysctl API
- only pass NULL for net when wanting global, instead of net_mode ==
  VSOCK_NET_MODE_GLOBAL. This reflects the new logic
  of vsock_net_check_mode() that only requires net pointers (not
  net_mode).
- refactor sysctl string code into a re-usable function, because
  child_ns_mode and ns_mode both handle the same strings.
- remove redundant vsock_net_init(&init_net) call in module init because
  pernet registration calls the callback on the init_net too

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
 MAINTAINERS                             |   1 +
 drivers/vhost/vsock.c                   |   6 +-
 include/linux/virtio_vsock.h            |   4 +-
 include/net/af_vsock.h                  |  53 +++++-
 include/net/net_namespace.h             |   4 +
 include/net/netns/vsock.h               |  17 ++
 net/vmw_vsock/af_vsock.c                | 297 +++++++++++++++++++++++++++++---
 net/vmw_vsock/hyperv_transport.c        |   7 +-
 net/vmw_vsock/virtio_transport.c        |   9 +-
 net/vmw_vsock/virtio_transport_common.c |   6 +-
 net/vmw_vsock/vmci_transport.c          |  26 ++-
 net/vmw_vsock/vsock_loopback.c          |   8 +-
 12 files changed, 394 insertions(+), 44 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6737aad729d6..f4aa476427c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27522,6 +27522,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
 F:	include/linux/virtio_vsock.h
+F:	include/net/netns/vsock.h
 F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 552cfb53498a..647ded6f6ea5 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -407,7 +407,8 @@ static bool vhost_transport_msgzerocopy_allow(void)
 	return true;
 }
 
-static bool vhost_transport_seqpacket_allow(u32 remote_cid);
+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
+					    u32 remote_cid);
 
 static struct virtio_transport vhost_transport = {
 	.transport = {
@@ -463,7 +464,8 @@ static struct virtio_transport vhost_transport = {
 	.send_pkt = vhost_transport_send_pkt,
 };
 
-static bool vhost_transport_seqpacket_allow(u32 remote_cid)
+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
+					    u32 remote_cid)
 {
 	struct vhost_vsock *vsock;
 	bool seqpacket_allow = false;
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
index d40e978126e3..10c2846fcc58 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
+#include <net/netns/vsock.h>
 #include <net/sock.h>
 #include <uapi/linux/vm_sockets.h>
 
@@ -124,7 +125,7 @@ struct vsock_transport {
 			     size_t len, int flags);
 	int (*dgram_enqueue)(struct vsock_sock *, struct sockaddr_vm *,
 			     struct msghdr *, size_t len);
-	bool (*dgram_allow)(u32 cid, u32 port);
+	bool (*dgram_allow)(struct vsock_sock *vsk, u32 cid, u32 port);
 
 	/* STREAM. */
 	/* TODO: stream_bind() */
@@ -136,14 +137,14 @@ struct vsock_transport {
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
@@ -216,6 +217,11 @@ void vsock_remove_connected(struct vsock_sock *vsk);
 struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
 struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 					 struct sockaddr_vm *dst);
+struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr,
+					 struct net *net);
+struct sock *vsock_find_connected_socket_net(struct sockaddr_vm *src,
+					     struct sockaddr_vm *dst,
+					     struct net *net);
 void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
@@ -256,4 +262,45 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
 {
 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
 }
+
+static inline enum vsock_net_mode vsock_net_mode(struct net *net)
+{
+	return READ_ONCE(net->vsock.mode);
+}
+
+static inline void vsock_net_set_child_mode(struct net *net,
+					    enum vsock_net_mode mode)
+{
+	WRITE_ONCE(net->vsock.child_ns_mode, mode);
+}
+
+static inline enum vsock_net_mode vsock_net_child_mode(struct net *net)
+{
+	return READ_ONCE(net->vsock.child_ns_mode);
+}
+
+/* Return true if two namespaces pass the mode rules. Otherwise, return false.
+ *
+ * A NULL namespace is treated as VSOCK_NET_MODE_GLOBAL.
+ *
+ * Read more about modes in the comment header of net/vmw_vsock/af_vsock.c.
+ */
+static inline bool vsock_net_check_mode(struct net *ns0, struct net *ns1)
+{
+	enum vsock_net_mode mode0, mode1;
+
+	/* Any vsocks within the same network namespace are always reachable,
+	 * regardless of the mode.
+	 */
+	if (net_eq(ns0, ns1))
+		return true;
+
+	mode0 = ns0 ? vsock_net_mode(ns0) : VSOCK_NET_MODE_GLOBAL;
+	mode1 = ns1 ? vsock_net_mode(ns1) : VSOCK_NET_MODE_GLOBAL;
+
+	/* Different namespaces are only reachable if they are both
+	 * global mode.
+	 */
+	return mode0 == VSOCK_NET_MODE_GLOBAL && mode0 == mode1;
+}
 #endif /* __AF_VSOCK_H__ */
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index cb664f6e3558..66d3de1d935f 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -37,6 +37,7 @@
 #include <net/netns/smc.h>
 #include <net/netns/bpf.h>
 #include <net/netns/mctp.h>
+#include <net/netns/vsock.h>
 #include <net/net_trackers.h>
 #include <linux/ns_common.h>
 #include <linux/idr.h>
@@ -196,6 +197,9 @@ struct net {
 	/* Move to a better place when the config guard is removed. */
 	struct mutex		rtnl_mutex;
 #endif
+#if IS_ENABLED(CONFIG_VSOCKETS)
+	struct netns_vsock	vsock;
+#endif
 } __randomize_layout;
 
 #include <linux/seq_file_net.h>
diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
new file mode 100644
index 000000000000..e2325e2d6ec5
--- /dev/null
+++ b/include/net/netns/vsock.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_NET_NAMESPACE_VSOCK_H
+#define __NET_NET_NAMESPACE_VSOCK_H
+
+#include <linux/types.h>
+
+enum vsock_net_mode {
+	VSOCK_NET_MODE_GLOBAL,
+	VSOCK_NET_MODE_LOCAL,
+};
+
+struct netns_vsock {
+	struct ctl_table_header *sysctl_hdr;
+	enum vsock_net_mode mode;
+	enum vsock_net_mode child_ns_mode;
+};
+#endif /* __NET_NET_NAMESPACE_VSOCK_H */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index a3505a4dcee0..9d614e4a4fa5 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -83,6 +83,42 @@
  *   TCP_ESTABLISHED - connected
  *   TCP_CLOSING - disconnecting
  *   TCP_LISTEN - listening
+ *
+ * - Namespaces in vsock support two different modes configured
+ *   through /proc/sys/net/vsock/ns_mode. The modes are "local" and "global".
+ *   Each mode defines how the namespace interacts with CIDs.
+ *   /proc/sys/net/vsock/ns_mode is read-only and inherited from the
+ *   parent namespace's /proc/sys/net/vsock/child_ns_mode at creation
+ *   time and is immutable thereafter. The default is "global".
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
  */
 
 #include <linux/compat.h>
@@ -100,20 +136,31 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/net.h>
+#include <linux/proc_fs.h>
 #include <linux/poll.h>
 #include <linux/random.h>
 #include <linux/skbuff.h>
 #include <linux/smp.h>
 #include <linux/socket.h>
 #include <linux/stddef.h>
+#include <linux/sysctl.h>
 #include <linux/unistd.h>
 #include <linux/wait.h>
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
@@ -235,33 +282,42 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
 	sock_put(&vsk->sk);
 }
 
-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
+static struct sock *__vsock_find_bound_socket_net(struct sockaddr_vm *addr,
+						  struct net *net)
 {
 	struct vsock_sock *vsk;
 
 	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
-		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
-			return sk_vsock(vsk);
+		struct sock *sk = sk_vsock(vsk);
+
+		if (vsock_addr_equals_addr(addr, &vsk->local_addr) &&
+		    vsock_net_check_mode(sock_net(sk), net))
+			return sk;
 
 		if (addr->svm_port == vsk->local_addr.svm_port &&
 		    (vsk->local_addr.svm_cid == VMADDR_CID_ANY ||
-		     addr->svm_cid == VMADDR_CID_ANY))
-			return sk_vsock(vsk);
+		     addr->svm_cid == VMADDR_CID_ANY) &&
+		     vsock_net_check_mode(sock_net(sk), net))
+			return sk;
 	}
 
 	return NULL;
 }
 
-static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
-						  struct sockaddr_vm *dst)
+static struct sock *
+__vsock_find_connected_socket_net(struct sockaddr_vm *src,
+				  struct sockaddr_vm *dst, struct net *net)
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
+		    vsock_net_check_mode(sock_net(sk), net)) {
+			return sk;
 		}
 	}
 
@@ -304,12 +360,13 @@ void vsock_remove_connected(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(vsock_remove_connected);
 
-struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
+struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr,
+					 struct net *net)
 {
 	struct sock *sk;
 
 	spin_lock_bh(&vsock_table_lock);
-	sk = __vsock_find_bound_socket(addr);
+	sk = __vsock_find_bound_socket_net(addr, net);
 	if (sk)
 		sock_hold(sk);
 
@@ -317,15 +374,22 @@ struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
 
 	return sk;
 }
+EXPORT_SYMBOL_GPL(vsock_find_bound_socket_net);
+
+struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
+{
+	return vsock_find_bound_socket_net(addr, NULL);
+}
 EXPORT_SYMBOL_GPL(vsock_find_bound_socket);
 
-struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
-					 struct sockaddr_vm *dst)
+struct sock *vsock_find_connected_socket_net(struct sockaddr_vm *src,
+					     struct sockaddr_vm *dst,
+					     struct net *net)
 {
 	struct sock *sk;
 
 	spin_lock_bh(&vsock_table_lock);
-	sk = __vsock_find_connected_socket(src, dst);
+	sk = __vsock_find_connected_socket_net(src, dst, net);
 	if (sk)
 		sock_hold(sk);
 
@@ -333,6 +397,13 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 
 	return sk;
 }
+EXPORT_SYMBOL_GPL(vsock_find_connected_socket_net);
+
+struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
+					 struct sockaddr_vm *dst)
+{
+	return vsock_find_connected_socket_net(src, dst, NULL);
+}
 EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
 
 void vsock_remove_sock(struct vsock_sock *vsk)
@@ -528,7 +599,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
-		    !new_transport->seqpacket_allow(remote_cid)) {
+		    !new_transport->seqpacket_allow(vsk, remote_cid)) {
 			module_put(new_transport->module);
 			return -ESOCKTNOSUPPORT;
 		}
@@ -676,6 +747,7 @@ static void vsock_pending_work(struct work_struct *work)
 static int __vsock_bind_connectible(struct vsock_sock *vsk,
 				    struct sockaddr_vm *addr)
 {
+	struct net *net = sock_net(sk_vsock(vsk));
 	static u32 port;
 	struct sockaddr_vm new_addr;
 
@@ -695,7 +767,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 
 			new_addr.svm_port = port++;
 
-			if (!__vsock_find_bound_socket(&new_addr)) {
+			if (!__vsock_find_bound_socket_net(&new_addr, net)) {
 				found = true;
 				break;
 			}
@@ -712,7 +784,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 			return -EACCES;
 		}
 
-		if (__vsock_find_bound_socket(&new_addr))
+		if (__vsock_find_bound_socket_net(&new_addr, net))
 			return -EADDRINUSE;
 	}
 
@@ -1314,7 +1386,7 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out;
 	}
 
-	if (!transport->dgram_allow(remote_addr->svm_cid,
+	if (!transport->dgram_allow(vsk, remote_addr->svm_cid,
 				    remote_addr->svm_port)) {
 		err = -EINVAL;
 		goto out;
@@ -1355,7 +1427,7 @@ static int vsock_dgram_connect(struct socket *sock,
 	if (err)
 		goto out;
 
-	if (!vsk->transport->dgram_allow(remote_addr->svm_cid,
+	if (!vsk->transport->dgram_allow(vsk, remote_addr->svm_cid,
 					 remote_addr->svm_port)) {
 		err = -EINVAL;
 		goto out;
@@ -1585,7 +1657,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		 * endpoints.
 		 */
 		if (!transport ||
-		    !transport->stream_allow(remote_addr->svm_cid,
+		    !transport->stream_allow(vsk, remote_addr->svm_cid,
 					     remote_addr->svm_port)) {
 			err = -ENETUNREACH;
 			goto out;
@@ -2662,6 +2734,183 @@ static struct miscdevice vsock_device = {
 	.fops		= &vsock_device_ops,
 };
 
+static int __vsock_net_mode_string(const struct ctl_table *table, int write,
+				   void *buffer, size_t *lenp, loff_t *ppos,
+				   enum vsock_net_mode mode,
+				   enum vsock_net_mode *new_mode)
+{
+	char data[VSOCK_NET_MODE_STR_MAX] = {0};
+	struct ctl_table tmp;
+	int ret;
+
+	if (!table->data || !table->maxlen || !*lenp) {
+		*lenp = 0;
+		return 0;
+	}
+
+	tmp = *table;
+	tmp.data = data;
+
+	if (!write) {
+		const char *p;
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
+		*new_mode = VSOCK_NET_MODE_GLOBAL;
+	else if (!strncmp(data, VSOCK_NET_MODE_STR_LOCAL, sizeof(data)))
+		*new_mode = VSOCK_NET_MODE_LOCAL;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int vsock_net_mode_string(const struct ctl_table *table, int write,
+				 void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct net *net;
+
+	if (write)
+		return -EPERM;
+
+	net = current->nsproxy->net_ns;
+
+	return __vsock_net_mode_string(table, write, buffer, lenp, ppos,
+				       vsock_net_mode(net), NULL);
+}
+
+static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
+				       void *buffer, size_t *lenp, loff_t *ppos)
+{
+	enum vsock_net_mode new_mode;
+	struct net *net;
+	int ret;
+
+	net = current->nsproxy->net_ns;
+
+	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
+				      vsock_net_child_mode(net), &new_mode);
+	if (ret)
+		return ret;
+
+	if (write)
+		vsock_net_set_child_mode(net, new_mode);
+
+	return 0;
+}
+
+static struct ctl_table vsock_table[] = {
+	{
+		.procname	= "ns_mode",
+		.data		= &init_net.vsock.mode,
+		.maxlen		= VSOCK_NET_MODE_STR_MAX,
+		.mode		= 0444,
+		.proc_handler	= vsock_net_mode_string
+	},
+	{
+		.procname	= "child_ns_mode",
+		.data		= &init_net.vsock.child_ns_mode,
+		.maxlen		= VSOCK_NET_MODE_STR_MAX,
+		.mode		= 0644,
+		.proc_handler	= vsock_net_child_mode_string
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
+		table[1].data = &net->vsock.child_ns_mode;
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
+	if (net_eq(net, &init_net))
+		net->vsock.mode = VSOCK_NET_MODE_GLOBAL;
+	else
+		net->vsock.mode = vsock_net_child_mode(current->nsproxy->net_ns);
+
+	net->vsock.child_ns_mode = VSOCK_NET_MODE_GLOBAL;
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
@@ -2689,10 +2938,17 @@ static int __init vsock_init(void)
 		goto err_unregister_proto;
 	}
 
+	if (register_pernet_subsys(&vsock_sysctl_ops)) {
+		err = -ENOMEM;
+		goto err_unregister_sock;
+	}
+
 	vsock_bpf_build_proto();
 
 	return 0;
 
+err_unregister_sock:
+	sock_unregister(AF_VSOCK);
 err_unregister_proto:
 	proto_unregister(&vsock_proto);
 err_deregister_misc:
@@ -2706,6 +2962,7 @@ static void __exit vsock_exit(void)
 	misc_deregister(&vsock_device);
 	sock_unregister(AF_VSOCK);
 	proto_unregister(&vsock_proto);
+	unregister_pernet_subsys(&vsock_sysctl_ops);
 }
 
 const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 432fcbbd14d4..4d6d7807f152 100644
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
+	if (vsock_net_mode(sock_net(sk_vsock(vsk))) != VSOCK_NET_MODE_GLOBAL)
+		return false;
+
 	if (cid == VMADDR_CID_HOST)
 		return true;
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 8c867023a2e5..37eeefddb48c 100644
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
 
+	if (vsock_net_mode(sock_net(sk_vsock(vsk))) != VSOCK_NET_MODE_GLOBAL)
+		return false;
+
 	seqpacket_allow = false;
 	rcu_read_lock();
 	vsock = rcu_dereference(the_virtio_vsock);
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e..fdb8f5b3fa60 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1043,9 +1043,9 @@ bool virtio_transport_stream_is_active(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_stream_is_active);
 
-bool virtio_transport_stream_allow(u32 cid, u32 port)
+bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 {
-	return true;
+	return vsock_net_mode(sock_net(sk_vsock(vsk))) == VSOCK_NET_MODE_GLOBAL;
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
index 7eccd6708d66..d5ce39ea5a1b 100644
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
 
+	if (vsock_net_mode(sock_net(sk_vsock(vsk))) != VSOCK_NET_MODE_GLOBAL)
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
+	if (vsock_net_mode(sock_net(sk_vsock(vsk))) != VSOCK_NET_MODE_GLOBAL)
+		return false;
+
 	if (cid == VMADDR_CID_HYPERVISOR) {
 		/* Registrations of PBRPC Servers do not modify VMX/Hypervisor
 		 * state and are allowed.
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index bc2ff918b315..378a96dcb666 100644
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
+	return vsock_net_mode(sock_net(sk_vsock(vsk))) == VSOCK_NET_MODE_GLOBAL;
 }
 
 static void vsock_loopback_work(struct work_struct *work)

-- 
2.47.3


