Return-Path: <linux-kselftest+bounces-35169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B7AADC0B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 06:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4663E17400C
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE4325484B;
	Tue, 17 Jun 2025 04:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmV98+NX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A3624EF6B;
	Tue, 17 Jun 2025 04:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134783; cv=none; b=iYyVB873fNKf3qCN4BRl1glUplHZSxjRDNr/YrXrgDJRdXHWmyNzgKfCWaXSRYrtu8aSxYsYlXbx1171tGGkKghXCwsHzU+pKsQ/tK38F1s01xFvzbESEjIEg9fvvKdklDFdiKuLeGkJs2zcD0hm5yFSosuh+wBROv8nk5SVTgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134783; c=relaxed/simple;
	bh=C2DFwzYQkx3LlkCAj/rIaEhjFwqc4O2MM49+/ldj++M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pzVhStYTS4vfgM95e7IE5VKZJh9WM8FiRPWj/I65mlDikpm+Deg7OOAyEQNuxHbWzPy3ebUjXD0Tdzbkf8YQL+ivDvxTaKoHwNwQ+DrSx3X3wbR5Isp5+5RzpDjmoSC8iqgvpoHLyckHBHB/HvxGTTdpsyP1QKtMzpyqp5hwk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmV98+NX; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so5537492a12.0;
        Mon, 16 Jun 2025 21:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134781; x=1750739581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=766yZkjmtJVFokYGwUZYaUubgjfKbmEBUpgRSzrrEqU=;
        b=CmV98+NXJx04yBTrEcrJ503tVvznJKpO6moe/F4Xm0Go2OLr5WCPGd+g31GWXtV8W4
         ayyzis+G0OWxGCyYIbjwPiRglTVw67eIWW0oL6vrsGHYqO3ZKSHJJTomY8h++jYdg581
         6AlFjBsD8Y5htr2ZDUgiGkH8+mXxJ59d2SQPo4enCzcSmahA+Cws1P0Bgsd6Es1/Wpim
         4q51gAMmMnH18NdcUp4EYPvmMZ/9pTHcqJNWUNET2rDDflGJB0Yys0HCdAIepGEOZCJf
         MvFNYpkwubMKn8wBf55C0Wh0FnhwAQLPdHSvowAgnpsRw++9vnhDxUz3Huxg5TsbFr+S
         iGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134781; x=1750739581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=766yZkjmtJVFokYGwUZYaUubgjfKbmEBUpgRSzrrEqU=;
        b=AnRGqMo3tHsIQc+tw4FafOPqBbXzAwUyHi88sxfFFgdr2PxI1PLBJ6v86OJsXgCCly
         O4VZDYgiEPDOl1SED3X0zjD4VrOEK6wmtB8ZER+o5ZyhqA/1X1msi1ZAaaq6mubLYbi5
         d4Y1nPDbCBIYFr/BMA1gMkuadQatgVtVB8NLCqvniw4oBSQ2TOIDHrv47Up3qlbruBGT
         YW8BYOsgUAqv3MQKv0TsJsJzxULmMAUweidpG6DNofJJ4ESAJiYNsnREuaHIzSSEBG7J
         +1YCuK46ZkS+Dwj3MBRR6yOsUvmYE2HQFWmS8GWjxFPJ9f05AwUw5WbylPJdhmRhJFqg
         6UuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEkyA9AKYdm6ZWXnZdGDTfMus6yvxOnx+ghGIS5BK1H5VlF98sutQu5+MVUV5UO84nH+ykASjJe/yxs9v6jAzs@vger.kernel.org, AJvYcCVTfQJV2el7I4cGv8tHIxnzVFwcLpRdO7FNVSjnihdYFqW1kbKEnCqNRCuzXoESG2L+vZwTjWtL@vger.kernel.org, AJvYcCWuDT9+HQMlUsjuS4KPH+fIFGzlSFYyVryhJqGG+vwzxnlFLXJoLurxdtWoNEJnXl4j342XFtQIxntS9e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW93ifuyXXecVnsvZrUG/zWltnhf6EyI3l7t/UF7RQH01Cl8IJ
	pxR04jlSViXOYgNi1pNUCJiHFCRacvJ7FK8bkw9uedNbJaL7DTqG9fWkg+HNEfNo
X-Gm-Gg: ASbGncuz51MwmPP+meYoPwxUIZ8TfK6TKMXK0jMGsrqW4aemcKX2YuWNZlJI/c6yZ85
	iwoKduNtN3peZB+G/VSAAqsLR+L5qOvmwe6y9O81sIP/wC2mw6YZJXofZoT4WDkXNPTh5mu43fL
	q4JoNTjZY1cLBQqBw+IvbfwmVrIRyrn2EwdHdfYIE6jtFO5z0u5+jAaRs8aA2ibtjtHaYJzFBLa
	aU6ongy1QhE6FrYJxhp5Qq9sP0VJLvlS1bGYPP3Nhi2Mv6emqNyb522CeDwgwGL4ziSHusXycIg
	uKMdmaISZ3H5edkw4774Hlzg4IBfWjIEukgWYaEsjHfN5u3tQ65/4QiKTIfS
X-Google-Smtp-Source: AGHT+IFnAeXzmju7Py/fE7DyF8/XrQUnHqGnGTjriiZFbWFtT/1tQFw/Aok20Q9u9KjfqDRCmdgjIw==
X-Received: by 2002:a05:6a21:4d8c:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-21fbd55112fmr17425755637.20.1750134780605;
        Mon, 16 Jun 2025 21:33:00 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1639fadsm6560268a12.11.2025.06.16.21.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:32:59 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:54 -0700
Subject: [PATCH RFC net-next v4 05/11] vsock: add common code for vsock NS
 support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-5-bdd1659c33fb@meta.com>
References: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
In-Reply-To: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add NS functionality (initialization, passing to transports, procfs,
etc...) to the vsock socket layer. Later patches that add NS support to
transports will depend on this patch.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/af_vsock.h   |   7 +-
 net/vmw_vsock/af_vsock.c | 203 +++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 193 insertions(+), 17 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index e0b9e6732d53..1ba1c30b625d 100644
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
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2e7a3034e965..bec7e7aae956 100644
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
 
@@ -513,7 +546,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
-		    !new_transport->seqpacket_allow(remote_cid)) {
+		    !new_transport->seqpacket_allow(vsk, remote_cid)) {
 			module_put(new_transport->module);
 			return -ESOCKTNOSUPPORT;
 		}
@@ -644,6 +677,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 {
 	static u32 port;
 	struct sockaddr_vm new_addr;
+	struct net *net = sock_net(sk_vsock(vsk));
 
 	if (!port)
 		port = get_random_u32_above(LAST_RESERVED_PORT);
@@ -660,7 +694,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 
 			new_addr.svm_port = port++;
 
-			if (!__vsock_find_bound_socket(&new_addr)) {
+			if (!__vsock_find_bound_socket(&new_addr, net)) {
 				found = true;
 				break;
 			}
@@ -677,7 +711,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 			return -EACCES;
 		}
 
-		if (__vsock_find_bound_socket(&new_addr))
+		if (__vsock_find_bound_socket(&new_addr, net))
 			return -EADDRINUSE;
 	}
 
@@ -2588,6 +2622,138 @@ static struct miscdevice vsock_device = {
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
+	if (net->vsock.ns_mode & VSOCK_NS_MODE_GLOBAL)
+		p = "global";
+	else if (net->vsock.ns_mode & VSOCK_NS_MODE_LOCAL)
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
+	u8 mode;
+
+	if (!vsock_net_mode_can_set(net))
+		return -EPERM;
+
+	mode = 0;
+	if (!strncmp(buf, "global", len))
+		mode |= VSOCK_NS_MODE_GLOBAL;
+	else if (!strncmp(buf, "local", len))
+		mode |= VSOCK_NS_MODE_LOCAL;
+	else
+		return -EINVAL;
+
+	vsock_net_set_mode(net, mode);
+
+	return ret;
+}
+#endif /* CONFIG_PROC_FS */
+
+static void vsock_net_init(struct net *net)
+{
+	spin_lock_init(&net->vsock.lock);
+	net->vsock.ns_mode = VSOCK_NS_MODE_GLOBAL;
+}
+
+static __net_init int vsock_sysctl_init_net(struct net *net)
+{
+	vsock_net_init(net);
+
+	if (vsock_sysctl_register(net))
+		goto out;
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
+out:
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
@@ -2615,10 +2781,19 @@ static int __init vsock_init(void)
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
2.47.1


