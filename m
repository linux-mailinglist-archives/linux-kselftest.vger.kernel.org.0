Return-Path: <linux-kselftest+bounces-40617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF43B4092A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 17:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7858201715
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 15:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310BF322DCB;
	Tue,  2 Sep 2025 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/dYheyT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC9131E0EE
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827568; cv=none; b=taw8Lt5vayBGgJX18+nbUOg205Iux7AC2biYasefbyLtLdBAYethLxiXet+3ZvSFSUDceNUG7+Obpue0xHE9LiwI9LAHUdaD4deqPfukoS/KQ2+ifEyhydJKaI7EtIGTPgX753haN4OVaoYzTGa+5ytnprgnx9dw3yMozNm2Bco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827568; c=relaxed/simple;
	bh=zXwrtmAX87LSm+i8ChpBHpSU7gTWZISp461mWc0I9Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qO/0tdC33975EehCIb9HVpHDZKWnS5ikHNmsF3aFo3bG0qQ027pqsNs5L/ljgdESH8sBGXNOf4MZS4879tNjWBd3298vHeSo0CyaoXFLM1U6giE3s1bLNMqkE4ciPN1CW1Upp2ErmYFxZVwk+qi5UPLSbwAQSEK7YbemFf03ew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/dYheyT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756827564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMvTm0hcd/yzzzGO2cHnnLOUYCpJcneduElaAP0F4oI=;
	b=d/dYheyTcq59s5QXA8m7HPsjCFN5TQM58iaLw8yzW0niUi5Inv5qWCXbQU9UgMINwFwXbY
	z8lVd1LjETijclEayEa7C6+f1s7CtMWz9ZUlpMv0PHtv61GSttZI5FMFX/a0v6CSG8Y0Q4
	/1Jy0JKVykKfJcEaBnJxKoVVC5F9eW8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-NICgTLcHNhmR2YLqgD1qqQ-1; Tue, 02 Sep 2025 11:39:23 -0400
X-MC-Unique: NICgTLcHNhmR2YLqgD1qqQ-1
X-Mimecast-MFC-AGG-ID: NICgTLcHNhmR2YLqgD1qqQ_1756827563
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b345aff439so25219191cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 08:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827563; x=1757432363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMvTm0hcd/yzzzGO2cHnnLOUYCpJcneduElaAP0F4oI=;
        b=MwZEJsVgyj0YZnToHm5ZB5dorjOM5uRv+/5NVolBbUFLRH2Hkf8Bq9exWbwb1HEY+9
         QSDguwEjGeBB/Or6FL6bnPRfpVhWeEMfGTjzRyUsTtGq/OG0r6NsMmB6HBdFC7CF1oHQ
         m9jlD9nimst1I2Oyk30RqJy7/ogYt4fpGFpXNFQh0JyOKlpva//XYhwrIFO7E5D/UGg3
         pQol4Bx7w58qkSGpejU9bT6yGUQ5VExweiKmW4XhZBXaLO8j9AR89mw4KdZxeg5dWzgv
         hLgvjTdFoAUjuP0/ZiGHm7r9I6IxfqB7GDmkpYuctlxfWt112eGml8slAiqMCw6EHgRA
         6fWw==
X-Forwarded-Encrypted: i=1; AJvYcCVS0LyXjyG5dejAVglv1T8w9Nh3CS+zFFHr4674oRdntDo1fBK/3cUesaB0eclWGJyew24yix+fYQNWVHx+b9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfoEUkuEDegU6wCIoND2jgjX4s8iUbEMkKS3t21qpxj3GawS6g
	Nz8jO5jQclTVkxF8xzKAsk/YXV2umQLUfhL0gYE96qxRp/0OKsHlN83oJ/xSUN2ypXhoEOnyKNs
	+TQG9aiqLOWkS5EYtant5sh/0aqH7x5HKe5Kuhx/yE5voKjeXv5o4LlYDreqHIowngxMpaQ==
X-Gm-Gg: ASbGncuoZsAx68kekW4wC4gp8XWFSpZEq9ymzi2fGr0veAgSV6B6W4LvFe4w2wwh5yK
	NbXLs6bRTA5jNJvwDIY8jmWfXdBpgruJUxESXkmxlEWUTHRoZ/vtDdtuVq6+fZ2Iwc3K5wWXlOy
	xOJMRuVcuk4UDXJ/HqXnrxMxznFHXG+mWiQb2zF38V6jMsDT4K00UsO08X5lnZYwQpBeGLW3veK
	d/q/+Ps3kLphGDUTluoZVhb25iU+gMuoWX0j7xbden2yBsIYDm1ALR89VNVqNBXvEb3iIod+lLe
	/k8RLqi/DELpYRvHorbQiJcG2tgMGiG+hz0zKkjLOo5Y+qD2lB0Z/3N+r4XrSPxRVhYjn8ZJ5Wl
	JkRy4N6EC+e/OYr0N
X-Received: by 2002:a05:622a:4207:b0:4b3:6e2:ecd with SMTP id d75a77b69052e-4b31d89e5e1mr130880401cf.2.1756827562380;
        Tue, 02 Sep 2025 08:39:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRmG/UbhG8IDruKlGlPvPBO+NRjUNwrBQTk1fryJ0CINjxXSxLmcBF5M/TYvm+v5fg/d/y4A==
X-Received: by 2002:a05:622a:4207:b0:4b3:6e2:ecd with SMTP id d75a77b69052e-4b31d89e5e1mr130879941cf.2.1756827561736;
        Tue, 02 Sep 2025 08:39:21 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-93.business.telecomitalia.it. [87.12.185.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b34618d3b5sm13731531cf.2.2025.09.02.08.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:39:21 -0700 (PDT)
Date: Tue, 2 Sep 2025 17:39:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 3/9] vsock: add netns to vsock core
Message-ID: <gncp3ynz3inufzex64sla2ia3stjsen2n3hwhfuykdhmpuuegu@7hk5q2hjfxkv>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
 <20250827-vsock-vmtest-v5-3-0ba580bede5b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250827-vsock-vmtest-v5-3-0ba580bede5b@meta.com>

On Wed, Aug 27, 2025 at 05:31:31PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add netns to logic to vsock core. Additionally, modify transport hook
>prototypes to be used by later transport-specific patches (e.g.,
>*_seqpacket_allow()).
>
>Namespaces are supported primarily by changing socket lookup functions
>(e.g., vsock_find_connected_socket()) to take into account the socket
>namespace and the namespace mode before considering a candidate socket a
>"match".
>
>Introduce a dummy namespace struct, __vsock_global_dummy_net, to be
>used by transports that do not support namespacing. This dummy always
>has mode "global" to preserve previous CID behavior.
>
>This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode that
>accepts the "global" or "local" mode strings.
>
>The transports (besides vhost) are modified to use the global dummy.
>
>Add netns functionality (initialization, passing to transports, procfs,
>etc...) to the af_vsock socket layer. Later patches that add netns
>support to transports depend on this patch.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>
>---
>Changes in v5:
>- vsock_global_net() -> vsock_global_dummy_net()
>- update comments for new uAPI
>- use /proc/sys/net/vsock/ns_mode instead of /proc/net/vsock_ns_mode
>- add prototype changes so patch remains compilable
>---
> drivers/vhost/vsock.c                   |   4 +-
> include/net/af_vsock.h                  |  13 +-
> net/vmw_vsock/af_vsock.c                | 202 +++++++++++++++++++++++++++++---
> net/vmw_vsock/hyperv_transport.c        |   2 +-
> net/vmw_vsock/virtio_transport.c        |   5 +-
> net/vmw_vsock/virtio_transport_common.c |   4 +-
> net/vmw_vsock/vmci_transport.c          |   4 +-
> net/vmw_vsock/vsock_loopback.c          |   4 +-
> 8 files changed, 210 insertions(+), 28 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index ae01457ea2cd..34adf0cf9124 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -404,7 +404,7 @@ static bool vhost_transport_msgzerocopy_allow(void)
> 	return true;
> }
>
>-static bool vhost_transport_seqpacket_allow(u32 remote_cid);
>+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
>
> static struct virtio_transport vhost_transport = {
> 	.transport = {
>@@ -460,7 +460,7 @@ static struct virtio_transport vhost_transport = {
> 	.send_pkt = vhost_transport_send_pkt,
> };
>
>-static bool vhost_transport_seqpacket_allow(u32 remote_cid)
>+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> {
> 	struct vhost_vsock *vsock;
> 	bool seqpacket_allow = false;
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 5707514c30b6..83f873174ba3 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -144,7 +144,7 @@ struct vsock_transport {
> 				     int flags);
> 	int (*seqpacket_enqueue)(struct vsock_sock *vsk, struct msghdr *msg,
> 				 size_t len);
>-	bool (*seqpacket_allow)(u32 remote_cid);
>+	bool (*seqpacket_allow)(struct vsock_sock *vsk, u32 remote_cid);
> 	u32 (*seqpacket_has_data)(struct vsock_sock *vsk);
>
> 	/* Notification. */
>@@ -214,9 +214,10 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
> void vsock_insert_connected(struct vsock_sock *vsk);
> void vsock_remove_bound(struct vsock_sock *vsk);
> void vsock_remove_connected(struct vsock_sock *vsk);
>-struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
>+struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net);
> struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
>-					 struct sockaddr_vm *dst);
>+					 struct sockaddr_vm *dst,
>+					 struct net *net);
> void vsock_remove_sock(struct vsock_sock *vsk);
> void vsock_for_each_connected_socket(struct vsock_transport 
> *transport,
> 				     void (*fn)(struct sock *sk));
>@@ -258,6 +259,12 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
> 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
> }
>
>+extern struct net __vsock_global_dummy_net;
>+static inline struct net *vsock_global_dummy_net(void)
>+{
>+	return &__vsock_global_dummy_net;
>+}
>+
> static inline u8 vsock_net_mode(struct net *net)
> {
> 	enum vsock_net_mode ret;
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 0538948d5fd9..68a8875c8106 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -83,6 +83,24 @@
>  *   TCP_ESTABLISHED - connected
>  *   TCP_CLOSING - disconnecting
>  *   TCP_LISTEN - listening
>+ *
>+ * - Namespaces in vsock support two different modes configured
>+ *   through /proc/sys/net/vsock/ns_mode. The modes are "local" and "global".
>+ *   Each mode defines how the namespace interacts with CIDs.
>+ *   /proc/sys/net/vsock/ns_mode is write-once, so that it may be configured
>+ *   and locked down by a namespace manager. The default is "global". The mode
>+ *   is set per-namespace.
>+ *
>+ *   The modes affect the allocation and accessibility of CIDs as follows:
>+ *   - global - aka fully public
>+ *      - CID allocation draws from the public pool
>+ *      - AF_VSOCK sockets may reach any CID allocated from the public pool
>+ *      - AF_VSOCK sockets may not reach CIDs allocated from private 
>pools

Should we define what public and private pools are?

What I found difficult to understand was the allocation of CIDs, meaning 
I had to reread it two or three times to perhaps understand it.

IIUC, netns with mode=global can only allocate public CIDs, while netns 
with mode=local can only allocate private CIDs, right?

Perhaps we should first better define how CIDs are allocated and then 
explain the interaction between them.

>+ *
>+ *   - local - aka fully private
>+ *     - CID allocation draws only from the private pool, does not affect public pool
>+ *     - AF_VSOCK sockets may only reach CIDs from the private pool
>+ *     - AF_VSOCK sockets may not reach CIDs allocated from outside the pool

Why using "may" ? I mean, can be cases when this is not true?

>  */
>
> #include <linux/compat.h>
>@@ -100,6 +118,7 @@
> #include <linux/module.h>
> #include <linux/mutex.h>
> #include <linux/net.h>
>+#include <linux/proc_fs.h>
> #include <linux/poll.h>
> #include <linux/random.h>
> #include <linux/skbuff.h>
>@@ -111,6 +130,7 @@
> #include <linux/workqueue.h>
> #include <net/sock.h>
> #include <net/af_vsock.h>
>+#include <net/netns/vsock.h>
> #include <uapi/linux/vm_sockets.h>
> #include <uapi/asm-generic/ioctls.h>
>
>@@ -149,6 +169,9 @@ static const struct vsock_transport *transport_dgram;
> static const struct vsock_transport *transport_local;
> static DEFINE_MUTEX(vsock_register_mutex);
>
>+struct net __vsock_global_dummy_net;
>+EXPORT_SYMBOL_GPL(__vsock_global_dummy_net);
>+
> /**** UTILS ****/
>
> /* Each bound VSocket is stored in the bind hash table and each connected
>@@ -235,33 +258,42 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
> 	sock_put(&vsk->sk);
> }
>
>-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>+static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr,
>+					      struct net *net)
> {
> 	struct vsock_sock *vsk;
>
> 	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
>+		struct sock *sk = sk_vsock(vsk);
>+
> 		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
>-			return sk_vsock(vsk);
>+			if (vsock_net_check_mode(net, sock_net(sk)))
>+				return sk;
>
> 		if (addr->svm_port == vsk->local_addr.svm_port &&
> 		    (vsk->local_addr.svm_cid == VMADDR_CID_ANY ||
>-		     addr->svm_cid == VMADDR_CID_ANY))
>-			return sk_vsock(vsk);
>+		     addr->svm_cid == VMADDR_CID_ANY) &&
>+		     vsock_net_check_mode(net, sock_net(sk)))
>+				return sk;
> 	}
>
> 	return NULL;
> }
>
> static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
>-						  struct sockaddr_vm *dst)
>+						  struct sockaddr_vm *dst,
>+						  struct net *net)
> {
> 	struct vsock_sock *vsk;
>
> 	list_for_each_entry(vsk, vsock_connected_sockets(src, dst),
> 			    connected_table) {
>+		struct sock *sk = sk_vsock(vsk);
>+
> 		if (vsock_addr_equals_addr(src, &vsk->remote_addr) &&
>-		    dst->svm_port == vsk->local_addr.svm_port) {
>-			return sk_vsock(vsk);
>+		    dst->svm_port == vsk->local_addr.svm_port &&
>+		    vsock_net_check_mode(net, sock_net(sk))) {
>+			return sk;
> 		}
> 	}
>
>@@ -304,12 +336,12 @@ void vsock_remove_connected(struct vsock_sock *vsk)
> }
> EXPORT_SYMBOL_GPL(vsock_remove_connected);
>
>-struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
>+struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net)
> {
> 	struct sock *sk;
>
> 	spin_lock_bh(&vsock_table_lock);
>-	sk = __vsock_find_bound_socket(addr);
>+	sk = __vsock_find_bound_socket(addr, net);
> 	if (sk)
> 		sock_hold(sk);
>
>@@ -320,12 +352,13 @@ struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
> EXPORT_SYMBOL_GPL(vsock_find_bound_socket);
>
> struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
>-					 struct sockaddr_vm *dst)
>+					 struct sockaddr_vm *dst,
>+					 struct net *net)
> {
> 	struct sock *sk;
>
> 	spin_lock_bh(&vsock_table_lock);
>-	sk = __vsock_find_connected_socket(src, dst);
>+	sk = __vsock_find_connected_socket(src, dst, net);
> 	if (sk)
> 		sock_hold(sk);
>
>@@ -528,7 +561,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>
> 	if (sk->sk_type == SOCK_SEQPACKET) {
> 		if (!new_transport->seqpacket_allow ||
>-		    !new_transport->seqpacket_allow(remote_cid)) {
>+		    !new_transport->seqpacket_allow(vsk, remote_cid)) {
> 			module_put(new_transport->module);
> 			return -ESOCKTNOSUPPORT;
> 		}
>@@ -678,6 +711,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
> {
> 	static u32 port;
> 	struct sockaddr_vm new_addr;
>+	struct net *net = sock_net(sk_vsock(vsk));
>
> 	if (!port)
> 		port = get_random_u32_above(LAST_RESERVED_PORT);
>@@ -695,7 +729,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>
> 			new_addr.svm_port = port++;
>
>-			if (!__vsock_find_bound_socket(&new_addr)) {
>+			if (!__vsock_find_bound_socket(&new_addr, net)) {
> 				found = true;
> 				break;
> 			}
>@@ -712,7 +746,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
> 			return -EACCES;
> 		}
>
>-		if (__vsock_find_bound_socket(&new_addr))
>+		if (__vsock_find_bound_socket(&new_addr, net))
> 			return -EADDRINUSE;
> 	}
>
>@@ -2636,6 +2670,137 @@ static struct miscdevice vsock_device = {
> 	.fops		= &vsock_device_ops,
> };
>
>+#define VSOCK_NET_MODE_STRING_MAX 7
>+
>+static int vsock_net_mode_string(const struct ctl_table *table, int write,
>+				 void *buffer, size_t *lenp, loff_t *ppos)
>+{
>+	char buf[VSOCK_NET_MODE_STRING_MAX] = {0};

Can we change `buf` name?

I find it confusing to have both a `buffer` variable and a `buf` 
variable in the same function.

>+	enum vsock_net_mode mode;
>+	struct ctl_table tmp;
>+	struct net *net;
>+	const char *p;

Can we move `p` declaration in the `if (!write) {` block?

>+	int ret;
>+
>+	if (!table->data || !table->maxlen || !*lenp) {
>+		*lenp = 0;
>+		return 0;
>+	}
>+
>+	net = current->nsproxy->net_ns;
>+	tmp = *table;
>+	tmp.data = buf;
>+
>+	if (!write) {
>+		mode = vsock_net_mode(net);
>+
>+		if (mode == VSOCK_NET_MODE_GLOBAL) {
>+			p = "global";
>+		} else if (mode == VSOCK_NET_MODE_LOCAL) {
>+			p = "local";
>+		} else {
>+			WARN_ONCE(true, "netns has invalid vsock mode");
>+			*lenp = 0;
>+			return 0;
>+		}
>+
>+		strscpy(buf, p, sizeof(buf));
>+		tmp.maxlen = strlen(p);
>+	}
>+
>+	ret = proc_dostring(&tmp, write, buffer, lenp, ppos);
>+	if (ret)
>+		return ret;
>+
>+	if (write) {
>+		if (!strncmp(buffer, "global", 6))

Are we sure that the `buffer` is at least 6 bytes long and 
NULL-terminated?

Maybe we can just check that `lenp <= sizeof(buf)`...

Should we add macros for "global" and "local" ?


>+			mode = VSOCK_NET_MODE_GLOBAL;
>+		else if (!strncmp(buffer, "local", 5))
>+			mode = VSOCK_NET_MODE_LOCAL;
>+		else
>+			return -EINVAL;
>+
>+		if (!vsock_net_write_mode(net, mode))
>+			return -EPERM;
>+	}
>+
>+	return 0;
>+}
>+
>+static struct ctl_table vsock_table[] = {
>+	{
>+		.procname	= "ns_mode",
>+		.data		= &init_net.vsock.mode,
>+		.maxlen		= sizeof(u8),
>+		.mode		= 0644,
>+		.proc_handler	= vsock_net_mode_string
>+	},
>+};
>+
>+static int __net_init vsock_sysctl_register(struct net *net)
>+{
>+	struct ctl_table *table;
>+
>+	if (net_eq(net, &init_net)) {
>+		table = vsock_table;
>+	} else {
>+		table = kmemdup(vsock_table, sizeof(vsock_table), GFP_KERNEL);
>+		if (!table)
>+			goto err_alloc;
>+
>+		table[0].data = &net->vsock.mode;
>+	}
>+
>+	net->vsock.vsock_hdr = register_net_sysctl_sz(net, "net/vsock", table,
>+						      ARRAY_SIZE(vsock_table));
>+	if (!net->vsock.vsock_hdr)
>+		goto err_reg;
>+
>+	return 0;
>+
>+err_reg:
>+	if (!net_eq(net, &init_net))
>+		kfree(table);
>+err_alloc:
>+	return -ENOMEM;
>+}
>+
>+static void vsock_sysctl_unregister(struct net *net)
>+{
>+	const struct ctl_table *table;
>+
>+	table = net->vsock.vsock_hdr->ctl_table_arg;
>+	unregister_net_sysctl_table(net->vsock.vsock_hdr);
>+	if (!net_eq(net, &init_net))
>+		kfree(table);
>+}
>+
>+static void vsock_net_init(struct net *net)
>+{
>+	spin_lock_init(&net->vsock.lock);
>+	net->vsock.mode = VSOCK_NET_MODE_GLOBAL;
>+}
>+
>+static __net_init int vsock_sysctl_init_net(struct net *net)
>+{
>+	vsock_net_init(net);
>+
>+	if (vsock_sysctl_register(net))
>+		return -ENOMEM;
>+
>+	return 0;
>+}
>+
>+static __net_exit void vsock_sysctl_exit_net(struct net *net)
>+{
>+	vsock_sysctl_unregister(net);
>+}
>+
>+static struct pernet_operations vsock_sysctl_ops __net_initdata = {
>+	.init = vsock_sysctl_init_net,
>+	.exit = vsock_sysctl_exit_net,
>+};
>+
> static int __init vsock_init(void)
> {
> 	int err = 0;
>@@ -2663,10 +2828,19 @@ static int __init vsock_init(void)
> 		goto err_unregister_proto;
> 	}
>
>+	if (register_pernet_subsys(&vsock_sysctl_ops)) {
>+		err = -ENOMEM;
>+		goto err_unregister_sock;
>+	}
>+
>+	vsock_net_init(&init_net);
>+	vsock_net_init(vsock_global_dummy_net());
> 	vsock_bpf_build_proto();
>
> 	return 0;
>
>+err_unregister_sock:
>+	sock_unregister(AF_VSOCK);
> err_unregister_proto:
> 	proto_unregister(&vsock_proto);
> err_deregister_misc:
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 432fcbbd14d4..79bc55eeecb3 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -313,7 +313,7 @@ static void hvs_open_connection(struct vmbus_channel *chan)
> 		return;
>
> 	hvs_addr_init(&addr, conn_from_host ? if_type : if_instance);
>-	sk = vsock_find_bound_socket(&addr);
>+	sk = vsock_find_bound_socket(&addr, vsock_global_dummy_net());
> 	if (!sk)
> 		return;
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index b6569b0ca2bb..af3e924fcc31 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -536,7 +536,7 @@ static bool virtio_transport_msgzerocopy_allow(void)
> 	return true;
> }
>
>-static bool virtio_transport_seqpacket_allow(u32 remote_cid);
>+static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
>
> static struct virtio_transport virtio_transport = {
> 	.transport = {
>@@ -593,7 +593,7 @@ static struct virtio_transport virtio_transport = {
> 	.can_msgzerocopy = virtio_transport_can_msgzerocopy,
> };
>
>-static bool virtio_transport_seqpacket_allow(u32 remote_cid)
>+static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> {
> 	struct virtio_vsock *vsock;
> 	bool seqpacket_allow;
>@@ -659,6 +659,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 			if (payload_len)
> 				virtio_vsock_skb_put(skb, payload_len);
>
>+			virtio_vsock_skb_set_net(skb, vsock_global_dummy_net());
> 			virtio_transport_deliver_tap_pkt(skb);
> 			virtio_transport_recv_pkt(&virtio_transport, skb);
> 		}
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index fe92e5fa95b4..9b3aa4f0395d 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1604,9 +1604,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 	/* The socket must be in connected or bound table
> 	 * otherwise send reset back
> 	 */
>-	sk = vsock_find_connected_socket(&src, &dst);
>+	sk = vsock_find_connected_socket(&src, &dst, vsock_global_dummy_net());
> 	if (!sk) {
>-		sk = vsock_find_bound_socket(&dst);
>+		sk = vsock_find_bound_socket(&dst, vsock_global_dummy_net());
> 		if (!sk) {
> 			(void)virtio_transport_reset_no_sock(t, skb);
> 			goto free_pkt;
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 7eccd6708d66..fd600ad77d73 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -703,9 +703,9 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
> 	vsock_addr_init(&src, pkt->dg.src.context, pkt->src_port);
> 	vsock_addr_init(&dst, pkt->dg.dst.context, pkt->dst_port);
>
>-	sk = vsock_find_connected_socket(&src, &dst);
>+	sk = vsock_find_connected_socket(&src, &dst, vsock_global_dummy_net());
> 	if (!sk) {
>-		sk = vsock_find_bound_socket(&dst);
>+		sk = vsock_find_bound_socket(&dst, vsock_global_dummy_net());
> 		if (!sk) {
> 			/* We could not find a socket for this specified
> 			 * address.  If this packet is a RST, we just drop it.
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 6e78927a598e..1b2fab73e0d0 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -46,7 +46,7 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
> 	return 0;
> }
>
>-static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
>+static bool vsock_loopback_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
> static bool vsock_loopback_msgzerocopy_allow(void)
> {
> 	return true;
>@@ -106,7 +106,7 @@ static struct virtio_transport loopback_transport = {
> 	.send_pkt = vsock_loopback_send_pkt,
> };
>
>-static bool vsock_loopback_seqpacket_allow(u32 remote_cid)
>+static bool vsock_loopback_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> {
> 	return true;
> }
>
>-- 
>2.47.3
>


