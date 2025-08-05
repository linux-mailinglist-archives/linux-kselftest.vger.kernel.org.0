Return-Path: <linux-kselftest+bounces-38331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D76CB1BBF2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 23:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CBA1893043
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303FB29A9D3;
	Tue,  5 Aug 2025 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiBAjR5f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D71628BAA6;
	Tue,  5 Aug 2025 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430560; cv=none; b=c5O2Ud5srK0r8vtUgC0n7YdVSj5IyUrCvmzyY09zKe5E0wOoeB4Phtq0M5GRYk7pma8xtdxaA+nPIMa1EA3gyGVgy78JjeMl1gNZAWV/bTkL8i0RWC2rI6Q/nzRVpUZcEqTDe7+e6HvYAVHKbbByiySFenQK1vBHzOOBCzxOzfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430560; c=relaxed/simple;
	bh=3gl4ZBbJ/p4i+XTyhNL9thZZ7fOtHU1zUlQvt4jU12k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b2DgpGgnarIqqlGh2VMlhiDGXbE8Y1aO5uI05OQNGYKDUZM++JduJLc5zy8v7Ch7Tz+FBPLMkkE9ADJ40sFrA8vi/Dn5yBSr5eQ4kNN0+DuVuqwLLqbaDt+FklkEjKOqnmQw9FOOfBSdV1dMMZZ2lkB24YiZxKBEYMPh76c8Vqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiBAjR5f; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4239091facso3064444a12.0;
        Tue, 05 Aug 2025 14:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430557; x=1755035357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=la1KUk0k8/W2nKzb/83NwhbfEgOVD6+Egvu6G0RFz1Y=;
        b=RiBAjR5fbeqhSz6ogam/BAFSBxPQGKSd2Ubg/4UtQqQul6uuy0sAYaSwuN74ndAfR2
         lD7DZD9R+LKLCvvetVJE+uLtwZ3STsTqGsqwlYs/9OEjqtmQpnF34tpQTsTQDmjFmYd5
         oh2nit87ounOVdXsP8toWhCwFiANhisyqbNqDS9xemkc/uwYURTgaUcMuBQt1LpZL5zf
         4mqjg8O6s/ycGChHXBGc4LPiMCRebGpjLNLUPn6SWip6u8YgKZZg+oJvAD0VJOW3cPcu
         uBii266zPy8QZOvI2W3ybN3aK2cv68tHc9XLz+cHsxvjOfLoIRs7U+u2bTREgt3xQH5u
         o7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430557; x=1755035357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=la1KUk0k8/W2nKzb/83NwhbfEgOVD6+Egvu6G0RFz1Y=;
        b=T5oTSVoAgiuMXUqVfJ2b55cFE8UKsxky9OqJ6GFA0I9miH6DlMMxRxkwrBqApQGY47
         ro6prK3+cMratDRCj0qu5/Irp8x+crifnkMFVUDKBDWXPHZyCkoIscpRqks8ZIH0mBqc
         LJsFFhwInAl0oZViimN3T2uIWHzVGTI48TnCQnIWGYDwP5sQF7RfBDNM+FK9dOxq6xPU
         YNFTM28cq5D002LO0/0dMTWZFwdkVxqfQCU9G3sktuiAqayiZXmWswhpa/a1yA+3iIJM
         Oei+U0EBHWhLvcs/hWm1VMzaiBzQ8iObfu6JZurj5LX56U+SBQ1pj8K8Akbn9YnTWhDK
         J+4w==
X-Forwarded-Encrypted: i=1; AJvYcCUlko1F28qrNlA/L9sE+oVswU8LbLjiKC9Va2KmHq+Xz0l1TGwirXVNMq02vywEFoR1zdUo/cByTqR7T0/0z/Hg@vger.kernel.org, AJvYcCUrO5MUdWy/4wZSoreYZXRyo1PidqhmuYG+rVlwJ8SKSJd+svwCQ6jvYdOQ/YQS1QjT1MiR/5bi@vger.kernel.org, AJvYcCUsa6/g20DSE24kTErlGvATW2jXH8fB/UiNmdGiEQNDsb9a4upCW2N4XjB0l/kKlLlh6soBxqwOYadVovXF@vger.kernel.org, AJvYcCWAsFcB+C3opPLPdmAXmRG/lwGaniaZ/A/CypSTLoTIz40TIiIw0j1m+mgJ98IqEnm4hXA=@vger.kernel.org, AJvYcCX0dhP0yGMGQ3kBDBOgahf/J1FvSzkrgMevy61KMddA9vj9/xDcyKlLuYLlOrcqO7LCSo+id/gHMDlyhHfP@vger.kernel.org
X-Gm-Message-State: AOJu0YzSz2+TNyZW1T2doK69NkErF3/GLkoLL3f+XdbI1vvltAUM8KkB
	tGvPtg23Q0fn6+DsfXhvSrS8ssy3m3mzVYfJHJxT6osPsh5qMs5Mj3AQqhEnqobj
X-Gm-Gg: ASbGncvLizglfNvHsV2Nk5u8L4aOayDDZrneTfPxRQ8utUz4L48d64rl4Z2jW9msTJU
	okhqEE/rBchRgI518sgnB+/KIEXvnYCggJPzy6co2cEf2OfG/qLSC5o0zW5uPNHAR74fRPE7dnJ
	kp1J9Kx8WJ/NS07Zx3ntkDZbunfNQO9dYSn3v6ez3bGD6yr5/Spsdwda6wtqHgn7/g6EZ9VOTwE
	d+cGcV9ReX1JVequ7vjxnFSNkomO7HPIHIPXg9P0YVkguTEnqsN179q2NJqqbmnc5nHBpl0VXoI
	V3wE8VIU7a9vquwijzoWMRXikB2GHFSQvf4mqmAgVv2yYVcnXx1y56UVvNkHoWhbCeBLgZ1KYOT
	vnnC7W8we8+6xkOCNOvGgQzo/CPgra+o=
X-Google-Smtp-Source: AGHT+IEfVsZ7z0J3iBDI4SJdG7CWc4xkYtTen+LMu+0WuCO6AEqPqfq52bXIO6kQje2tU9911dhQQg==
X-Received: by 2002:a17:902:ec92:b0:238:120:134a with SMTP id d9443c01a7336-2429f4380d2mr8804185ad.22.1754430557372;
        Tue, 05 Aug 2025 14:49:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef66efsm140519375ad.32.2025.08.05.14.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:16 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:11 -0700
Subject: [PATCH RFC net-next v4 03/12] vsock: add netns to af_vsock core
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-3-059ec51ab111@meta.com>
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

Add netns functionality (initialization, passing to transports, procfs,
etc...) to the af_vsock socket layer. Later patches that add netns support to
transports depend on this patch.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/af_vsock.h   |  13 +++-
 net/vmw_vsock/af_vsock.c | 198 +++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 194 insertions(+), 17 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d34bf7dbc69a..0c0c351394de 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -144,7 +144,7 @@ struct vsock_transport {
 				     int flags);
 	int (*seqpacket_enqueue)(struct vsock_sock *vsk, struct msghdr *msg,
 				 size_t len);
-	bool (*seqpacket_allow)(u32 remote_cid);
+	bool (*seqpacket_allow)(struct vsock_sock *vsk, u32 remote_cid);
 	u32 (*seqpacket_has_data)(struct vsock_sock *vsk);
 
 	/* Notification. */
@@ -214,9 +214,10 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
 void vsock_insert_connected(struct vsock_sock *vsk);
 void vsock_remove_bound(struct vsock_sock *vsk);
 void vsock_remove_connected(struct vsock_sock *vsk);
-struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
+struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net);
 struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
-					 struct sockaddr_vm *dst);
+					 struct sockaddr_vm *dst,
+					 struct net *net);
 void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
@@ -258,6 +259,12 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
 }
 
+extern struct net __vsock_global_net;
+static inline struct net *vsock_global_net(void)
+{
+	return &__vsock_global_net;
+}
+
 static inline u8 vsock_net_mode(struct net *net)
 {
 	u8 ret;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 218d91e6b32b..c69c2db03162 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -83,6 +83,24 @@
  *   TCP_ESTABLISHED - connected
  *   TCP_CLOSING - disconnecting
  *   TCP_LISTEN - listening
+ *
+ * - Namespaces in vsock support two different modes configured
+ *   through /proc/net/vsock_ns_mode. The modes are "local" and "global".
+ *   Each mode defines how the namespace interacts with CIDs.
+ *   /proc/net/vsock_ns_mode is write-once, so that it may be configured
+ *   by a namespace manager. The default is "global". The mode is set
+ *   per-namespace.
+ *
+ *   The modes affect the allocation and accessibility of CIDs as follows:
+ *   - global - aka fully public
+ *      - CID allocation draws from the public pool
+ *      - AF_VSOCK sockets may reach any CID allocated from the public pool
+ *      - AF_VSOCK sockets may not reach CIDs allocated from private pools
+ *
+ *   - local - aka fully private
+ *     - CID allocation draws only from the private pool, does not affect public pool
+ *     - AF_VSOCK sockets may only reach CIDs from the private pool
+ *     - AF_VSOCK sockets may not reach CIDs allocated from outside the pool
  */
 
 #include <linux/compat.h>
@@ -100,6 +118,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/net.h>
+#include <linux/proc_fs.h>
 #include <linux/poll.h>
 #include <linux/random.h>
 #include <linux/skbuff.h>
@@ -111,6 +130,7 @@
 #include <linux/workqueue.h>
 #include <net/sock.h>
 #include <net/af_vsock.h>
+#include <net/netns/vsock.h>
 #include <uapi/linux/vm_sockets.h>
 #include <uapi/asm-generic/ioctls.h>
 
@@ -149,6 +169,9 @@ static const struct vsock_transport *transport_dgram;
 static const struct vsock_transport *transport_local;
 static DEFINE_MUTEX(vsock_register_mutex);
 
+struct net __vsock_global_net;
+EXPORT_SYMBOL_GPL(__vsock_global_net);
+
 /**** UTILS ****/
 
 /* Each bound VSocket is stored in the bind hash table and each connected
@@ -235,33 +258,42 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
 	sock_put(&vsk->sk);
 }
 
-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
+static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr,
+					      struct net *net)
 {
 	struct vsock_sock *vsk;
 
 	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
+		struct sock *sk = sk_vsock(vsk);
+
 		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
-			return sk_vsock(vsk);
+			if (vsock_net_check_mode(net, sock_net(sk)))
+				return sk;
 
 		if (addr->svm_port == vsk->local_addr.svm_port &&
 		    (vsk->local_addr.svm_cid == VMADDR_CID_ANY ||
-		     addr->svm_cid == VMADDR_CID_ANY))
-			return sk_vsock(vsk);
+		     addr->svm_cid == VMADDR_CID_ANY) &&
+		    vsock_net_check_mode(net, sock_net(sk)))
+				return sk;
 	}
 
 	return NULL;
 }
 
 static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
-						  struct sockaddr_vm *dst)
+						  struct sockaddr_vm *dst,
+						  struct net *net)
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
+		    vsock_net_check_mode(net, sock_net(sk))) {
+			return sk;
 		}
 	}
 
@@ -304,12 +336,12 @@ void vsock_remove_connected(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(vsock_remove_connected);
 
-struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
+struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net)
 {
 	struct sock *sk;
 
 	spin_lock_bh(&vsock_table_lock);
-	sk = __vsock_find_bound_socket(addr);
+	sk = __vsock_find_bound_socket(addr, net);
 	if (sk)
 		sock_hold(sk);
 
@@ -320,12 +352,13 @@ struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
 EXPORT_SYMBOL_GPL(vsock_find_bound_socket);
 
 struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
-					 struct sockaddr_vm *dst)
+					 struct sockaddr_vm *dst,
+					 struct net *net)
 {
 	struct sock *sk;
 
 	spin_lock_bh(&vsock_table_lock);
-	sk = __vsock_find_connected_socket(src, dst);
+	sk = __vsock_find_connected_socket(src, dst, net);
 	if (sk)
 		sock_hold(sk);
 
@@ -528,7 +561,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
-		    !new_transport->seqpacket_allow(remote_cid)) {
+		    !new_transport->seqpacket_allow(vsk, remote_cid)) {
 			module_put(new_transport->module);
 			return -ESOCKTNOSUPPORT;
 		}
@@ -678,6 +711,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 {
 	static u32 port;
 	struct sockaddr_vm new_addr;
+	struct net *net = sock_net(sk_vsock(vsk));
 
 	if (!port)
 		port = get_random_u32_above(LAST_RESERVED_PORT);
@@ -694,7 +728,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 
 			new_addr.svm_port = port++;
 
-			if (!__vsock_find_bound_socket(&new_addr)) {
+			if (!__vsock_find_bound_socket(&new_addr, net)) {
 				found = true;
 				break;
 			}
@@ -711,7 +745,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 			return -EACCES;
 		}
 
-		if (__vsock_find_bound_socket(&new_addr))
+		if (__vsock_find_bound_socket(&new_addr, net))
 			return -EADDRINUSE;
 	}
 
@@ -2645,6 +2679,133 @@ static struct miscdevice vsock_device = {
 	.fops		= &vsock_device_ops,
 };
 
+#define VSOCK_NS_MODE_NAME_MAX 8
+
+static struct ctl_table vsock_table[] = {
+	{
+		.procname	= "vsock_ns_mode",
+		.data		= &init_net.vsock.ns_mode,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dostring
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
+		table[0].data = &net->vsock.ns_mode;
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
+#ifdef CONFIG_PROC_FS
+static int vsock_proc_ns_mode_show(struct seq_file *seq, void *v)
+{
+	struct net *net = seq_file_single_net(seq);
+	const char *p = "invalid";
+
+	spin_lock_bh(&net->vsock.lock);
+	if (net->vsock.ns_mode == VSOCK_NET_MODE_GLOBAL)
+		p = "global";
+	else if (net->vsock.ns_mode == VSOCK_NET_MODE_LOCAL)
+		p = "local";
+	else
+		WARN_ONCE(1, "invalid vsock_ns_mode");
+	spin_unlock_bh(&net->vsock.lock);
+	seq_printf(seq, "%s", p);
+	return 0;
+}
+
+static int vsock_proc_ns_mode_write(struct file *file, char *buf, size_t size)
+{
+	struct seq_file *m = file->private_data;
+	struct net *net = seq_file_single_net(m);
+	size_t len = size - 1;
+	int ret = 0;
+
+	if (!vsock_net_mode_can_set(net))
+		return -EPERM;
+
+	if (!strncmp(buf, "global", len))
+		vsock_net_set_mode(net, VSOCK_NET_MODE_GLOBAL);
+	else if (!strncmp(buf, "local", len))
+		vsock_net_set_mode(net, VSOCK_NET_MODE_LOCAL);
+	else
+		return -EINVAL;
+
+	return ret;
+}
+#endif /* CONFIG_PROC_FS */
+
+static void vsock_net_init(struct net *net)
+{
+	spin_lock_init(&net->vsock.lock);
+	net->vsock.ns_mode = VSOCK_NET_MODE_GLOBAL;
+}
+
+static __net_init int vsock_sysctl_init_net(struct net *net)
+{
+	vsock_net_init(net);
+
+	if (vsock_sysctl_register(net))
+		return -ENOMEM;
+
+#ifdef CONFIG_PROC_FS
+	if (!proc_create_net_single_write("vsock_ns_mode", 0644, net->proc_net,
+					  vsock_proc_ns_mode_show,
+					  vsock_proc_ns_mode_write,
+					  NULL))
+		goto err_sysctl;
+#endif
+
+	return 0;
+
+err_sysctl:
+	vsock_sysctl_unregister(net);
+	return -ENOMEM;
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
@@ -2672,10 +2833,19 @@ static int __init vsock_init(void)
 		goto err_unregister_proto;
 	}
 
+	if (register_pernet_subsys(&vsock_sysctl_ops)) {
+		err = -ENOMEM;
+		goto err_unregister_sock;
+	}
+
+	vsock_net_init(&init_net);
+	vsock_net_init(vsock_global_net());
 	vsock_bpf_build_proto();
 
 	return 0;
 
+err_unregister_sock:
+	sock_unregister(AF_VSOCK);
 err_unregister_proto:
 	proto_unregister(&vsock_proto);
 err_deregister_misc:

-- 
2.47.3


