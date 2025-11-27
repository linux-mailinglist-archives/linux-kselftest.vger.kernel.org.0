Return-Path: <linux-kselftest+bounces-46651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8BAC8EBDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 15:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AA43349B9C
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 14:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28009330324;
	Thu, 27 Nov 2025 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmObj2Nh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rKTqZdPg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0BF21D5B0
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764253551; cv=none; b=ntX6rPZLyCWsrEJqy4z9+U8wsZU0qUnl154TE6eNWApYO5AseJ12coT0answJyFqnx9OWBh3B+UmJiDRcewA7SjqOU04B/rvuILRWU9Yw2HcNTFJXejcxQM6rS3T0sokCaxDz21czWWnVvm1h833g4Bx6eWiyXfzXC059HmCAxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764253551; c=relaxed/simple;
	bh=EGhMT2nY/iOxMyApjQtN1JJ+YUrlMzFpYOmZJcJ1K8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRBdIGpvK++4Yl8qGJiz+1LCP2cSCm7cpigTLTHk2LyEDSLuBfB0jqryYtz5pK5O3LBsuOSFCUPwfm/w3gyobF2eYrU8EbpWVrK72F18GUJ1Q93l4aPDzMOomQPGTTGLAMRUEBOJFkgBIR6fk/BT5aM7FXeocld6UBgKv7sv6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TmObj2Nh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rKTqZdPg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764253547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NHQ+9Pm89RgrWAppLMIXiBi3c3xBW6b+7b2ZUFvefHQ=;
	b=TmObj2NhxOl//U8kJiXr6dsPdfCXoPawSFx9v4raGC4X+gKe5QGwWDX7F5jE82KhPXSIG9
	oZln8qro3CmKsQTB9WmpgtXxFpt7n6jPFq8PsPvEeJYmOC2KB3fWVZ0IEwkIZzOpNxqLem
	yt2mxB/j9pN9ZQxz2TneU9L3jSt0/Qg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-7TKtyikpMeGFR2Db1-cYmA-1; Thu, 27 Nov 2025 09:25:46 -0500
X-MC-Unique: 7TKtyikpMeGFR2Db1-cYmA-1
X-Mimecast-MFC-AGG-ID: 7TKtyikpMeGFR2Db1-cYmA_1764253545
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477a1e2b372so5925095e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 06:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764253545; x=1764858345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHQ+9Pm89RgrWAppLMIXiBi3c3xBW6b+7b2ZUFvefHQ=;
        b=rKTqZdPghw6Nei207G1kcOabcTMvbNnug7jQtDBNMfGDf0wkW0YcIJ4gfF2OIlfEcj
         5cXfGbOKrXNGDd8bb02ZXsJSdy4FCpqUUNS3kENkqq4U+OT2n9xuvgYz3shqPa1zXgNP
         C7bKHyXaKT+KykM6MLXOjVfkP7yf0z1meKUbRLgQMFLUxnwz2dhWmoeWubEKCoo7uK0u
         jGL1eFBFP183p9F3f6yM9Mrzml3u8ss9Ac/M8C1pDQ5IYk8uCX5qIkUgU8YlkAQj8FzA
         T/MIsv27M1BdcrKznRi5y8BM38/EHBuNV8IypopKV+isV4/BPY09w4i8QnPzN5uuY61x
         LaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764253545; x=1764858345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHQ+9Pm89RgrWAppLMIXiBi3c3xBW6b+7b2ZUFvefHQ=;
        b=LejQ8kvGK/CLJiMtj7ILcsE2Hi0tyCFHIvxEwzoz/i6PkuMdQ4GRoAwXLGbcAzPk3E
         JoLOGjtbdAtvYZj6+W+9aNJEEjnKjuugWuVXT58LmpFezMbY3zfw/4k2GryisvXYRZbJ
         rnJB/2UxRUX2Pb1ZJxyAIPYeCEMXSC/VRxTMDduKR71mDlz4BIyWTOPIBGpSFJVe2ad5
         pUl6OWtX9I1SvUsXV/ywoU6XjEFKVwzLfYxl5326cI0mWxegLXnAU/oiBzhgFO3rYVSw
         KSkCl9kYijmZHwcH15yYn3BmVFcDTWTogvKQ1VYSuvqhsDLgEudbNQQe8oyc+PdGBfML
         nZGA==
X-Forwarded-Encrypted: i=1; AJvYcCVdkSGoFGw9isDiJDoDHj5lGTaQtd2DyrnyClqjK6i2ymVS03aqHTmcJYWM4COUNEDy/Pm5NiLPuywhwweRABY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnudhwo/oCQOV3eonHpQCGFbI3rgDB/TD2X5ZMLwdIhlq/mtiQ
	66PWRrY0WBwsqbhFYqqigF5ZiEKrb23/QvT0f2dzWyxvGV8VKAOze7BrxssDUkwb4vqRdnrcga4
	TepFdZ3C7ZC/y/zEq8hhSei4sNShrf1rS7oEIkbNEznsNdPPx/wVP8erKXIdf7Z7+qlzN6g==
X-Gm-Gg: ASbGncsPXKcPzJDI6ycDtgk5+m0rQdErqa9FpBIFG0cuUiFXHw9esITAngpaKOyzY+e
	OZ40JHr7WET9IdtKf+raHRgn/nBYZhuvOn1I53yz0OiEMjjrZTm69n4SjJVlIJ+GnU/Ks1H82aI
	HsGJHOEkwfzas+UXutbr62oDMhP0264ko6FECGksuG0qPOiUEiaEZJ0Rqf4gRRNwxhRxMV4YTDr
	s3KE82iUpFRzGx6hriTBsGrLDgxTmPfhL3rpczkfcyafyu+LuQ1WpA+SDyBabkG2ZHBA0p9e6zu
	sw0YrpTgHlxal5aYDWy+ZdE9hLOYqLZfYJV5zyRiq2c4t10KlddrNEX4yuid+SXpQQ6+BQdX5IO
	jR5YikNA1dbb6Fc7PlTTj/9bPzkSRINwAx+5JFFEoXFN1KgL5vi6M3N3ZoPLHqA==
X-Received: by 2002:a05:600c:1c82:b0:477:73cc:82c3 with SMTP id 5b1f17b1804b1-477c01ee405mr243883225e9.26.1764253544942;
        Thu, 27 Nov 2025 06:25:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+J2RN+F4MfS6i4qF9I5FUb4qWasSxwouYCY8VK82Y+vNgVL3kCvi1PqswXAR6ojmLpEIexQ==
X-Received: by 2002:a05:600c:1c82:b0:477:73cc:82c3 with SMTP id 5b1f17b1804b1-477c01ee405mr243882425e9.26.1764253544175;
        Thu, 27 Nov 2025 06:25:44 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479052b3f5fsm68879635e9.4.2025.11.27.06.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 06:25:43 -0800 (PST)
Date: Thu, 27 Nov 2025 15:25:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v12 02/12] vsock: add netns to vsock core
Message-ID: <hgz3rtpb3lvxzbygye6ziobfujfsl2yefh5t3ghrbbbknr6eis@ypifkm24ygja>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-2-257ee21cd5de@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251126-vsock-vmtest-v12-2-257ee21cd5de@meta.com>

On Wed, Nov 26, 2025 at 11:47:31PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add netns logic to vsock core. Additionally, modify transport hook
>prototypes to be used by later transport-specific patches (e.g.,
>*_seqpacket_allow()).
>
>Namespaces are supported primarily by changing socket lookup functions
>(e.g., vsock_find_connected_socket()) to take into account the socket
>namespace and the namespace mode before considering a candidate socket a
>"match".
>
>This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode that
>accepts the "global" or "local" mode strings.
>
>Add netns functionality (initialization, passing to transports, procfs,
>etc...) to the af_vsock socket layer. Later patches that add netns
>support to transports depend on this patch.
>
>dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
>modified to take a vsk in order to perform logic on namespace modes. In
>future patches, the net and net_mode will also be used for socket
>lookups in these functions.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v12:
>- return true in dgram_allow(), stream_allow(), and seqpacket_allow()
>  only if net_mode == VSOCK_NET_MODE_GLOBAL (Stefano)
>- document bind(VMADDR_CID_ANY) case in af_vsock.c (Stefano)
>- change order of stream_allow() call in vmci so we can pass vsk
>  to it
>
>Changes in v10:
>- add file-level comment about what happens to sockets/devices
>  when the namespace mode changes (Stefano)
>- change the 'if (write)' boolean in vsock_net_mode_string() to
>  if (!write), this simplifies a later patch which adds "goto"
>  for mutex unlocking on function exit.
>
>Changes in v9:
>- remove virtio_vsock_alloc_rx_skb() (Stefano)
>- remove vsock_global_dummy_net, not needed as net=NULL +
>  net_mode=VSOCK_NET_MODE_GLOBAL achieves identical result
>
>Changes in v7:
>- hv_sock: fix hyperv build error
>- explain why vhost does not use the dummy
>- explain usage of __vsock_global_dummy_net
>- explain why VSOCK_NET_MODE_STR_MAX is 8 characters
>- use switch-case in vsock_net_mode_string()
>- avoid changing transports as much as possible
>- add vsock_find_{bound,connected}_socket_net()
>- rename `vsock_hdr` to `sysctl_hdr`
>- add virtio_vsock_alloc_linear_skb() wrapper for setting dummy net and
>  global mode for virtio-vsock, move skb->cb zero-ing into wrapper
>- explain seqpacket_allow() change
>- move net setting to __vsock_create() instead of vsock_create() so
>  that child sockets also have their net assigned upon accept()
>
>Changes in v6:
>- unregister sysctl ops in vsock_exit()
>- af_vsock: clarify description of CID behavior
>- af_vsock: fix buf vs buffer naming, and length checking
>- af_vsock: fix length checking w/ correct ctl_table->maxlen
>
>Changes in v5:
>- vsock_global_net() -> vsock_global_dummy_net()
>- update comments for new uAPI
>- use /proc/sys/net/vsock/ns_mode instead of /proc/net/vsock_ns_mode
>- add prototype changes so patch remains compilable
>---
> drivers/vhost/vsock.c                   |   9 +-
> include/linux/virtio_vsock.h            |   4 +-
> include/net/af_vsock.h                  |  13 +-
> net/vmw_vsock/af_vsock.c                | 272 +++++++++++++++++++++++++++++---
> net/vmw_vsock/hyperv_transport.c        |   7 +-
> net/vmw_vsock/virtio_transport.c        |   9 +-
> net/vmw_vsock/virtio_transport_common.c |   6 +-
> net/vmw_vsock/vmci_transport.c          |  26 ++-
> net/vmw_vsock/vsock_loopback.c          |   8 +-
> 9 files changed, 310 insertions(+), 44 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index ae01457ea2cd..83937e1d63fa 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -404,7 +404,8 @@ static bool vhost_transport_msgzerocopy_allow(void)
> 	return true;
> }
>
>-static bool vhost_transport_seqpacket_allow(u32 remote_cid);
>+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
>+					    u32 remote_cid);
>
> static struct virtio_transport vhost_transport = {
> 	.transport = {
>@@ -460,11 +461,15 @@ static struct virtio_transport vhost_transport = {
> 	.send_pkt = vhost_transport_send_pkt,
> };
>
>-static bool vhost_transport_seqpacket_allow(u32 remote_cid)
>+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
>+					    u32 remote_cid)
> {
> 	struct vhost_vsock *vsock;
> 	bool seqpacket_allow = false;
>
>+	if (vsk->net_mode != VSOCK_NET_MODE_GLOBAL)
>+		return false;
>+
> 	rcu_read_lock();
> 	vsock = vhost_vsock_get(remote_cid);
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 0c67543a45c8..1845e8d4f78d 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -256,10 +256,10 @@ void virtio_transport_notify_buffer_size(struct vsock_sock *vsk, u64 *val);
>
> u64 virtio_transport_stream_rcvhiwat(struct vsock_sock *vsk);
> bool virtio_transport_stream_is_active(struct vsock_sock *vsk);
>-bool virtio_transport_stream_allow(u32 cid, u32 port);
>+bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port);
> int virtio_transport_dgram_bind(struct vsock_sock *vsk,
> 				struct sockaddr_vm *addr);
>-bool virtio_transport_dgram_allow(u32 cid, u32 port);
>+bool virtio_transport_dgram_allow(struct vsock_sock *vsk, u32 cid, u32 port);
>
> int virtio_transport_connect(struct vsock_sock *vsk);
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 9b5bdd083b6f..d10e73cd7413 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -126,7 +126,7 @@ struct vsock_transport {
> 			     size_t len, int flags);
> 	int (*dgram_enqueue)(struct vsock_sock *, struct sockaddr_vm *,
> 			     struct msghdr *, size_t len);
>-	bool (*dgram_allow)(u32 cid, u32 port);
>+	bool (*dgram_allow)(struct vsock_sock *vsk, u32 cid, u32 port);
>
> 	/* STREAM. */
> 	/* TODO: stream_bind() */
>@@ -138,14 +138,14 @@ struct vsock_transport {
> 	s64 (*stream_has_space)(struct vsock_sock *);
> 	u64 (*stream_rcvhiwat)(struct vsock_sock *);
> 	bool (*stream_is_active)(struct vsock_sock *);
>-	bool (*stream_allow)(u32 cid, u32 port);
>+	bool (*stream_allow)(struct vsock_sock *vsk, u32 cid, u32 port);
>
> 	/* SEQ_PACKET. */
> 	ssize_t (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
> 				     int flags);
> 	int (*seqpacket_enqueue)(struct vsock_sock *vsk, struct msghdr *msg,
> 				 size_t len);
>-	bool (*seqpacket_allow)(u32 remote_cid);
>+	bool (*seqpacket_allow)(struct vsock_sock *vsk, u32 remote_cid);
> 	u32 (*seqpacket_has_data)(struct vsock_sock *vsk);
>
> 	/* Notification. */
>@@ -218,6 +218,13 @@ void vsock_remove_connected(struct vsock_sock *vsk);
> struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
> struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
> 					 struct sockaddr_vm *dst);
>+struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr,
>+					 struct net *net,
>+					 enum vsock_net_mode net_mode);
>+struct sock *vsock_find_connected_socket_net(struct sockaddr_vm *src,
>+					     struct sockaddr_vm *dst,
>+					     struct net *net,
>+					     enum vsock_net_mode net_mode);
> void vsock_remove_sock(struct vsock_sock *vsk);
> void vsock_for_each_connected_socket(struct vsock_transport *transport,
> 				     void (*fn)(struct sock *sk));
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index adcba1b7bf74..6113c22db8dc 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -83,6 +83,46 @@
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
>+ *
>+ *   - global - access and allocation are all system-wide

nit: maybe we should mention that this mode is primarily for backward 
compatibility, since it's the way how vsock worked before netns support.

(We can fix later eventually with a followup patch)

>+ *      - all CID allocation from global namespaces draw from the same
>+ *        system-wide pool.
>+ *      - if one global namespace has already allocated some CID, another
>+ *        global namespace will not be able to allocate the same CID.
>+ *      - global mode AF_VSOCK sockets can reach any VM or socket in any global
>+ *        namespace, they are not contained to only their own namespace.
>+ *      - AF_VSOCK sockets in a global mode namespace cannot reach VMs or
>+ *        sockets in any local mode namespace.
>+ *   - local - access and allocation are contained within the namespace
>+ *     - CID allocation draws only from a private pool local only to the
>+ *       namespace, and does not affect the CIDs available for allocation in any
>+ *       other namespace (global or local).
>+ *     - VMs in a local namespace do not collide with CIDs in any other local
>+ *       namespace or any global namespace. For example, if a VM in a local mode
>+ *       namespace is given CID 10, then CID 10 is still available for
>+ *       allocation in any other namespace, but not in the same namespace.
>+ *     - AF_VSOCK sockets in a local mode namespace can connect only to VMs or
>+ *       other sockets within their own namespace.
>+ *     - sockets bound to VMADDR_CID_ANY in local namespaces will never resolve
>+ *       to any transport that is not compatible with local mode. There is no
>+ *       error that propagates to the user (as there is for connection attempts)
>+ *       because it is possible for some packet to reach this socket from
>+ *       a different transport that *does* support local mode. For
>+ *       example, virtio-vsock may not support local mode, but the socket
>+ *       may still accept a connection from vhost-vsock which does.
>+ *
>+ *   - when a socket or device is initialized in a namespace with mode
>+ *     global, it will stay in global mode even if the namespace later
>+ *     changes to local.
>  */
>
> #include <linux/compat.h>
>@@ -100,6 +140,7 @@
> #include <linux/module.h>
> #include <linux/mutex.h>
> #include <linux/net.h>
>+#include <linux/proc_fs.h>
> #include <linux/poll.h>
> #include <linux/random.h>
> #include <linux/skbuff.h>
>@@ -111,9 +152,18 @@
> #include <linux/workqueue.h>
> #include <net/sock.h>
> #include <net/af_vsock.h>
>+#include <net/netns/vsock.h>
> #include <uapi/linux/vm_sockets.h>
> #include <uapi/asm-generic/ioctls.h>
>
>+#define VSOCK_NET_MODE_STR_GLOBAL "global"
>+#define VSOCK_NET_MODE_STR_LOCAL "local"
>+
>+/* 6 chars for "global", 1 for null-terminator, and 1 more for '\n'.
>+ * The newline is added by proc_dostring() for read operations.
>+ */
>+#define VSOCK_NET_MODE_STR_MAX 8
>+
> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
> static void vsock_sk_destruct(struct sock *sk);
> static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
>@@ -235,33 +285,47 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
> 	sock_put(&vsk->sk);
> }
>
>-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>+static struct sock *__vsock_find_bound_socket_net(struct sockaddr_vm *addr,
>+						  struct net *net,
>+						  enum vsock_net_mode net_mode)
> {
> 	struct vsock_sock *vsk;
>
> 	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
>-		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
>-			return sk_vsock(vsk);
>+		struct sock *sk = sk_vsock(vsk);
>+
>+		if (vsock_addr_equals_addr(addr, &vsk->local_addr) &&
>+		    vsock_net_check_mode(sock_net(sk), vsk->net_mode, net,
>+					 net_mode))
>+			return sk;
>
> 		if (addr->svm_port == vsk->local_addr.svm_port &&
> 		    (vsk->local_addr.svm_cid == VMADDR_CID_ANY ||
>-		     addr->svm_cid == VMADDR_CID_ANY))
>-			return sk_vsock(vsk);
>+		     addr->svm_cid == VMADDR_CID_ANY) &&
>+		     vsock_net_check_mode(sock_net(sk), vsk->net_mode, net,
>+					  net_mode))
>+			return sk;
> 	}
>
> 	return NULL;
> }
>
>-static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
>-						  struct sockaddr_vm *dst)
>+static struct sock *
>+__vsock_find_connected_socket_net(struct sockaddr_vm *src,
>+				  struct sockaddr_vm *dst, struct net *net,
>+				  enum vsock_net_mode net_mode)
> {
> 	struct vsock_sock *vsk;
>
> 	list_for_each_entry(vsk, vsock_connected_s)ckets(src, dst),
> 			    connected_table) {
>+		struct sock *sk = sk_vsock(vsk);
>+
> 		if (vsock_addr_equals_addr(src, &vsk->remote_addr) &&
>-		    dst->svm_port == vsk->local_addr.svm_port) {
>-			return sk_vsock(vsk);
>+		    dst->svm_port == vsk->local_addr.svm_port &&
>+		    vsock_net_check_mode(sock_net(sk), vsk->net_mode, net,
>+					 net_mode)) {
>+			return sk;
> 		}
> 	}
>
>@@ -304,12 +368,14 @@ void vsock_remove_connected(struct vsock_sock *vsk)
> }
> EXPORT_SYMBOL_GPL(vsock_remove_connected);
>
>-struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
>+struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr,
>+					 struct net *net,
>+					 enum vsock_net_mode net_mode)
> {
> 	struct sock *sk;
>
> 	spin_lock_bh(&vsock_table_lock);
>-	sk = __vsock_find_bound_socket(addr);
>+	sk = __vsock_find_bound_socket_net(addr, net, net_mode);
> 	if (sk)
> 		sock_hold(sk);
>
>@@ -317,15 +383,23 @@ struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
>
> 	return sk;
> }
>+EXPORT_SYMBOL_GPL(vsock_find_bound_socket_net);
>+
>+struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
>+{
>+	return vsock_find_bound_socket_net(addr, NULL, VSOCK_NET_MODE_GLOBAL);

The patch LGTM, my last doubt now is if here (and in 
vsock_find_connected_socket() ) we should use `init_net`.

In practice, this is the namespace (NULL) and mode (GLOBAL) used by 
transports that do not support namespaces.

So here we are making them belong to no namespace, so they can only 
reach global ones. When any namespace, including `init_net`, switches to 
local, it can no longer be reached by transports that do not support 
local namespaces, because in practice we still do not have a way to 
associate a device (in the case of drivers) with a specific namespace.  
Right?

If I get it right, it can makes sense, but I'd like an ack from net 
maintainers to be sure we are doing the right things.

Also I think we should have a comment on top of this function to make it 
clear that should be used only by transport that doesn't support 
namespace, and the reason why we used NULL and GLOBAL. Plus a comment on 
top of this file (near where we described local vs global) to clarify 
the status of this.

That said, if next week net-next will close, I think we can send a 
follow-up patch just for those comments, so:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>+}
> EXPORT_SYMBOL_GPL(vsock_find_bound_socket);
>
>-struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
>-					 struct sockaddr_vm *dst)
>+struct sock *vsock_find_connected_socket_net(struct sockaddr_vm *src,
>+					     struct sockaddr_vm *dst,
>+					     struct net *net,
>+					     enum vsock_net_mode net_mode)
> {
> 	struct sock *sk;
>
> 	spin_lock_bh(&vsock_table_lock);
>-	sk = __vsock_find_connected_socket(src, dst);
>+	sk = __vsock_find_connected_socket_net(src, dst, net, net_mode);
> 	if (sk)
> 		sock_hold(sk);
>
>@@ -333,6 +407,14 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
>
> 	return sk;
> }
>+EXPORT_SYMBOL_GPL(vsock_find_connected_socket_net);
>+
>+struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
>+					 struct sockaddr_vm *dst)
>+{
>+	return vsock_find_connected_socket_net(src, dst,
>+					       NULL, VSOCK_NET_MODE_GLOBAL);
>+}
> EXPORT_SYMBOL_GPL(vsock_find_connected_socket);


