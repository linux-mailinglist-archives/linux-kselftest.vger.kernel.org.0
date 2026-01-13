Return-Path: <linux-kselftest+bounces-48865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0BD1986C
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9CBA3032E83
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB842877D6;
	Tue, 13 Jan 2026 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYEGakPf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NA6fF/E4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF272BD587
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315061; cv=none; b=obnwHU4ruIilGR8RiEjpVwRHUiYDtNPsvWHcHngy8hjyuhkv57G1o6u2YANJEP+z+XkHBxm5BMFDnpX0cyvZtgikD6s+AksfYzQkiahZCEDvzDU3CxngN8GANVt8U1aeobTeY8l1hJTm8HVbzrpQzkX+pWK8o6Q40LeKWIdlPFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315061; c=relaxed/simple;
	bh=8QjpqEJnYo/4LScb3POebj1pmYD3CicBXaB9btTpVLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OP7tYiMwAwRpsF1/HqN+/yS1bbXUbi6igOKf6E1y7QwxqZ8dCfID1dlmSjMBANAtxBWmKtfuggFszJmF93Kd9GFjTogEUodCfOz+ZgXY7rlmMOotTJwsh2C3XTdinHD2OSi7VhBegcbENB3FjQOBOZAN7eq8x7wTfeqtIx16tjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IYEGakPf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NA6fF/E4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768315057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n8SCil7q16tJQdxoPX+/vVVnxDgbO8Fm248LXUftvnU=;
	b=IYEGakPfFltWZTiiLmPzhQgJoliTib1wwaEXt1B39/MTBa1Kw4DZpfs4zZfIiTFomRUYse
	yi/QUNlLxFYT92Fj1kOaU1+NBVTA2eExPN4/D2+3slHu3O/yyBJgNtakidihTnLUbBnPsg
	Ua6nkSI1Y8jUtISR6lydhZNQk62Y8nQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-Ncm8TmtvP62VycHWBDHXAQ-1; Tue, 13 Jan 2026 09:37:33 -0500
X-MC-Unique: Ncm8TmtvP62VycHWBDHXAQ-1
X-Mimecast-MFC-AGG-ID: Ncm8TmtvP62VycHWBDHXAQ_1768315052
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fcf10280so5739041f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 06:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768315052; x=1768919852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n8SCil7q16tJQdxoPX+/vVVnxDgbO8Fm248LXUftvnU=;
        b=NA6fF/E4pJFvyofiDqTxr+sh+Q7iyq9/XxWXQLdkw3IXs2PlDP/Yih+qrVAVLnSxTR
         ybiyYr0xDeP42nDt78YL1c7bmGFpfaS7mbyJ9GXNT/wl7tks6BOGTkcP8X96Zaj4Ylaf
         3GFuucnUTdTlv0yq3pGC5t3FZXrhrvln65U6IVQbAkIeUtM6EnOoK0cKmlIDh6zAW1Wn
         vl6lLlub3xYL4RGVS63rLfStBK5b3/EMXssmdpFluNqPvI+ZhJRWb+pbwzGHzBMn1Afb
         /BM5nTOIacIsVQkQaZtV5aZZtxwC6O+omgrxBZsTFJ+Kwka5ke5Acsr4+uIRGFk8OjyI
         URgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768315052; x=1768919852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8SCil7q16tJQdxoPX+/vVVnxDgbO8Fm248LXUftvnU=;
        b=iZK6FgNklaY1g6j4TFRtmF5gpX1fBeUitHOE02DZCT/Nm5WfCWz3KYF9j2PEa1Yq3/
         SOTiC4DX+c/66TlSK/Jv2i599nTH1wBKm0ND3DaAx6PB0e7aYMYC4OYxoUCwdiZCowiM
         xZqE6XLLKFMvytFrGhP1k7DBq7ALE3bhDmiUjriqw7H0cL6/6i3e7B6bmv1V4qXCBVj4
         JV2PnqUCGGWXhikDkb6a9k9BEAYdBZEFJi1MFsLMZSAV0wpIL95/Au4OcdvZ8ZnoTigc
         ZK7i16rrTzeO0pdnYNJqagvxMMDgT/D7okc08H+qZPoVwbw2MYsCe61aDe31yXtobgst
         D7aA==
X-Forwarded-Encrypted: i=1; AJvYcCVt4N9Ty4xqjNkpRu85YerIePH8Odjwjw1EaNZLlH1lxH21J1Aaba9HNUB8gq343FLUvPQosjM3odROjWtMSfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8cXNaZV3qL/mW2IY7cbSE/89TeGBfSzQrJi/mtvcplMyYlgC5
	0MPRNQSm4GpPTD0rxXezG7rA4heHQN8yJ+cRW6UvGgissZnumyQ0pqqQqa1MnDOh4Xm+p8Vg1d/
	BbjdJg04F2sXwAhI5lAS8M9xmSQQL1hYKjLRnV4r7KfAFHMv7+peomconG+xPprOa5Te7MA==
X-Gm-Gg: AY/fxX7oWRXiun4F84W2Wvrl70IEboXT6Wm4aLcKAiyRnFbucDi3/MJdpUKUgkJcfcH
	Gfdme2bH+5rFki/ug+TtwWNw6jw+cyFfaMTU+my54Tt2thEeyCLtqZw7iTeLxnWdyv0LhcxyEtl
	SPDZAkXCqxjshDFFm156w1xpdMbzplczD9cKovWRRxJfs6siAGcYa2TPpBnDtYyUrEr3ea5VknW
	7By1EcCSRaNJelB8jbYvAH6QURgkZy221kvzi80+ebLTtd++Hh7GQkssW3efE9v8192OwA0bJy5
	OmEq/jR+jfHb9doIOj5MS8Fk1yyXwmcuKEjPK5ZKK7CsTdDXFAdyo+uHpwkY2x7caySZOwZpTK/
	b35WyP+E0CQ5/d4wD4g97aTrXfsaBaLwDfvtWdXp0vwL0oFB/Eyj6439a0AHsug==
X-Received: by 2002:a05:6000:184a:b0:430:ff8b:fdc2 with SMTP id ffacd0b85a97d-432c37a9a6amr24119728f8f.60.1768315052129;
        Tue, 13 Jan 2026 06:37:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGknzi1UD2kir/L6wBVN0poxd1x0XCsqFLSw1ykkXaA8c8oq7C7vLmvj4scOG5aVrDp4sjK0A==
X-Received: by 2002:a05:6000:184a:b0:430:ff8b:fdc2 with SMTP id ffacd0b85a97d-432c37a9a6amr24119683f8f.60.1768315051382;
        Tue, 13 Jan 2026 06:37:31 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm45113015f8f.8.2026.01.13.06.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:37:30 -0800 (PST)
Date: Tue, 13 Jan 2026 15:37:15 +0100
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v14 01/12] vsock: add netns to vsock core
Message-ID: <aWYrwU__c895PymJ@sgarzare-redhat>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-1-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260112-vsock-vmtest-v14-1-a5c332db3e2b@meta.com>

On Mon, Jan 12, 2026 at 07:11:10PM -0800, Bobby Eshleman wrote:
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
>This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode to
>report the mode and /proc/sys/net/vsock/child_ns_mode to set the mode
>for new namespaces.
>
>Add netns functionality (initialization, passing to transports, procfs,
>etc...) to the af_vsock socket layer. Later patches that add netns
>support to transports depend on this patch.
>
>dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
>modified to take a vsk in order to perform logic on namespace modes. In
>future patches, the net will also be used for socket
>lookups in these functions.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v14:
>- include linux/sysctl.h in af_vsock.c
>- squash patch 'vsock: add per-net vsock NS mode state' into this patch
>  (prior version can be found here):
>  https://lore.kernel.org/all/20251223-vsock-vmtest-v13-1-9d6db8e7c80b@meta.com/)
>
>Changes in v13:
>- remove net_mode and replace with direct accesses to net->vsock.mode,
>  since this is now immutable.
>- update comments about mode behavior and mutability, and sysctl API
>- only pass NULL for net when wanting global, instead of net_mode ==
>  VSOCK_NET_MODE_GLOBAL. This reflects the new logic
>  of vsock_net_check_mode() that only requires net pointers (not
>  net_mode).
>- refactor sysctl string code into a re-usable function, because
>  child_ns_mode and ns_mode both handle the same strings.
>- remove redundant vsock_net_init(&init_net) call in module init because
>  pernet registration calls the callback on the init_net too
>
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
> MAINTAINERS                             |   1 +
> drivers/vhost/vsock.c                   |   6 +-
> include/linux/virtio_vsock.h            |   4 +-
> include/net/af_vsock.h                  |  53 +++++-
> include/net/net_namespace.h             |   4 +
> include/net/netns/vsock.h               |  17 ++
> net/vmw_vsock/af_vsock.c                | 297 +++++++++++++++++++++++++++++---
> net/vmw_vsock/hyperv_transport.c        |   7 +-
> net/vmw_vsock/virtio_transport.c        |   9 +-
> net/vmw_vsock/virtio_transport_common.c |   6 +-
> net/vmw_vsock/vmci_transport.c          |  26 ++-
> net/vmw_vsock/vsock_loopback.c          |   8 +-
> 12 files changed, 394 insertions(+), 44 deletions(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 6737aad729d6..f4aa476427c8 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -27522,6 +27522,7 @@ L:	netdev@vger.kernel.org
> S:	Maintained
> F:	drivers/vhost/vsock.c
> F:	include/linux/virtio_vsock.h
>+F:	include/net/netns/vsock.h
> F:	include/uapi/linux/virtio_vsock.h
> F:	net/vmw_vsock/virtio_transport.c
> F:	net/vmw_vsock/virtio_transport_common.c
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 552cfb53498a..647ded6f6ea5 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -407,7 +407,8 @@ static bool vhost_transport_msgzerocopy_allow(void)
> 	return true;
> }
>
>-static bool vhost_transport_seqpacket_allow(u32 remote_cid);
>+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
>+					    u32 remote_cid);
>
> static struct virtio_transport vhost_transport = {
> 	.transport = {
>@@ -463,7 +464,8 @@ static struct virtio_transport vhost_transport = {
> 	.send_pkt = vhost_transport_send_pkt,
> };
>
>-static bool vhost_transport_seqpacket_allow(u32 remote_cid)
>+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
>+					    u32 remote_cid)
> {
> 	struct vhost_vsock *vsock;
> 	bool seqpacket_allow = false;
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
>index d40e978126e3..10c2846fcc58 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -10,6 +10,7 @@
>
> #include <linux/kernel.h>
> #include <linux/workqueue.h>
>+#include <net/netns/vsock.h>
> #include <net/sock.h>
> #include <uapi/linux/vm_sockets.h>
>
>@@ -124,7 +125,7 @@ struct vsock_transport {
> 			     size_t len, int flags);
> 	int (*dgram_enqueue)(struct vsock_sock *, struct sockaddr_vm *,
> 			     struct msghdr *, size_t len);
>-	bool (*dgram_allow)(u32 cid, u32 port);
>+	bool (*dgram_allow)(struct vsock_sock *vsk, u32 cid, u32 port);
>
> 	/* STREAM. */
> 	/* TODO: stream_bind() */
>@@ -136,14 +137,14 @@ struct vsock_transport {
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
>@@ -216,6 +217,11 @@ void vsock_remove_connected(struct vsock_sock *vsk);
> struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
> struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
> 					 struct sockaddr_vm *dst);
>+struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr,
>+					 struct net *net);
>+struct sock *vsock_find_connected_socket_net(struct sockaddr_vm *src,
>+					     struct sockaddr_vm *dst,
>+					     struct net *net);
> void vsock_remove_sock(struct vsock_sock *vsk);
> void vsock_for_each_connected_socket(struct vsock_transport *transport,
> 				     void (*fn)(struct sock *sk));
>@@ -256,4 +262,45 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
> {
> 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
> }
>+
>+static inline enum vsock_net_mode vsock_net_mode(struct net *net)
>+{

What about moving here the check about NULL namespace?
(adding the comment we have later)

I mean just adding a
	if (!net)
		return VSOCK_NET_MODE_GLOBAL;

Or using the ternary operator, as you prefer.


>+	return READ_ONCE(net->vsock.mode);
>+}
>+
>+static inline void vsock_net_set_child_mode(struct net *net,
>+					    enum vsock_net_mode mode)
>+{
>+	WRITE_ONCE(net->vsock.child_ns_mode, mode);
>+}
>+
>+static inline enum vsock_net_mode vsock_net_child_mode(struct net *net)
>+{
>+	return READ_ONCE(net->vsock.child_ns_mode);
>+}
>+
>+/* Return true if two namespaces pass the mode rules. Otherwise, return false.
>+ *
>+ * A NULL namespace is treated as VSOCK_NET_MODE_GLOBAL.
>+ *
>+ * Read more about modes in the comment header of net/vmw_vsock/af_vsock.c.
>+ */
>+static inline bool vsock_net_check_mode(struct net *ns0, struct net *ns1)
>+{
>+	enum vsock_net_mode mode0, mode1;
>+
>+	/* Any vsocks within the same network namespace are always reachable,
>+	 * regardless of the mode.
>+	 */
>+	if (net_eq(ns0, ns1))
>+		return true;
>+
>+	mode0 = ns0 ? vsock_net_mode(ns0) : VSOCK_NET_MODE_GLOBAL;
>+	mode1 = ns1 ? vsock_net_mode(ns1) : VSOCK_NET_MODE_GLOBAL;

So we can avoid duplicating code here and maybe in other places where 
vsock_net_mode() is used.

About them, in all transports we use that in this way:

net/vmw_vsock/hyperv_transport.c:       if (vsock_net_mode(sock_net(sk_vsock(vsk))) != VSOCK_NET_MODE_GLOBAL)
net/vmw_vsock/virtio_transport.c:       return vsock_net_mode(sock_net(sk_vsock(vsk))) == VSOCK_NET_MODE_GLOBAL;
net/vmw_vsock/virtio_transport.c:       if (vsock_net_mode(sock_net(sk_vsock(vsk))) != VSOCK_NET_MODE_GLOBAL)
net/vmw_vsock/vmci_transport.c: if (vsock_net_mode(sock_net(sk_vsock(vsk))) != VSOCK_NET_MODE_GLOBAL)
net/vmw_vsock/vmci_transport.c: if (vsock_net_mode(sock_net(sk_vsock(vsk))) != VSOCK_NET_MODE_GLOBAL)
net/vmw_vsock/vsock_loopback.c: return vsock_net_mode(sock_net(sk_vsock(vsk))) == VSOCK_NET_MODE_GLOBAL;

So, I'm thinking if we should provide some `vsock_net_mode_global(vsk)` 
that can be used there, but not a strong opinion at all.

>+
>+	/* Different namespaces are only reachable if they are both
>+	 * global mode.
>+	 */
>+	return mode0 == VSOCK_NET_MODE_GLOBAL && mode0 == mode1;
>+}
> #endif /* __AF_VSOCK_H__ */
>diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
>index cb664f6e3558..66d3de1d935f 100644
>--- a/include/net/net_namespace.h
>+++ b/include/net/net_namespace.h
>@@ -37,6 +37,7 @@
> #include <net/netns/smc.h>
> #include <net/netns/bpf.h>
> #include <net/netns/mctp.h>
>+#include <net/netns/vsock.h>
> #include <net/net_trackers.h>
> #include <linux/ns_common.h>
> #include <linux/idr.h>
>@@ -196,6 +197,9 @@ struct net {
> 	/* Move to a better place when the config guard is removed. */
> 	struct mutex		rtnl_mutex;
> #endif
>+#if IS_ENABLED(CONFIG_VSOCKETS)
>+	struct netns_vsock	vsock;
>+#endif
> } __randomize_layout;
>
> #include <linux/seq_file_net.h>
>diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>new file mode 100644
>index 000000000000..e2325e2d6ec5
>--- /dev/null
>+++ b/include/net/netns/vsock.h
>@@ -0,0 +1,17 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+#ifndef __NET_NET_NAMESPACE_VSOCK_H
>+#define __NET_NET_NAMESPACE_VSOCK_H
>+
>+#include <linux/types.h>
>+
>+enum vsock_net_mode {
>+	VSOCK_NET_MODE_GLOBAL,
>+	VSOCK_NET_MODE_LOCAL,
>+};
>+
>+struct netns_vsock {
>+	struct ctl_table_header *sysctl_hdr;
>+	enum vsock_net_mode mode;
>+	enum vsock_net_mode child_ns_mode;
>+};
>+#endif /* __NET_NET_NAMESPACE_VSOCK_H */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index a3505a4dcee0..9d614e4a4fa5 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -83,6 +83,42 @@
>  *   TCP_ESTABLISHED - connected
>  *   TCP_CLOSING - disconnecting
>  *   TCP_LISTEN - listening
>+ *
>+ * - Namespaces in vsock support two different modes configured
>+ *   through /proc/sys/net/vsock/ns_mode. The modes are "local" and "global".

IIUC `/proc/sys/net/vsock/ns_mode` is read-only so "two different modes 
configured through /proc/sys/net/vsock/ns_mode" is not really clear IMO.

>+ *   Each mode defines how the namespace interacts with CIDs.
>+ *   /proc/sys/net/vsock/ns_mode is read-only and inherited from the
>+ *   parent namespace's /proc/sys/net/vsock/child_ns_mode at creation
>+ *   time and is immutable thereafter. The default is "global".

Here too, it is not clear to me that child_ns_mode is used to manage new 
children. What do you think about clarifying the situation a little in 
this way:

    * - Namespaces in vsock support two different modes: "local" and "global".
    *   Each mode defines how the namespace interacts with CIDs.
    *   Each namespace exposes two sysctl files:
    *   - /proc/sys/net/vsock/ns_mode (read-only) reports the current namespace's
    *     mode, which is set at namespace creation and immutable thereafter.
    *   - /proc/sys/net/vsock/child_ns_mode (writable) controls what mode future
    *     child namespaces will inherit when created. The default is "global".
    *   Changing child_ns_mode only affects newly created namespaces, not the
    *   current namespace or existing children. At namespace creation, ns_mode
    *   is inherited from the parent's child_ns_mode.

>+ *
>+ *   The modes affect the allocation and accessibility of CIDs as follows:
>+ *
>+ *   - global - access and allocation are all system-wide
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
>  */

So, compared to the previous implementation, now there is no way to 
specify the mode of `init_net` right?

At this point, it will always be global IIUC.

Should we provide something for init_net? Module parameter, kernel 
cmdline. I mean something that can be decided before af_vsock is loaded, 
so we don't have the previous problem of having sockets with different 
modes within the same namespace.

@Paolo any suggestion?

>
> #include <linux/compat.h>
>@@ -100,20 +136,31 @@
> #include <linux/module.h>
> #include <linux/mutex.h>
> #include <linux/net.h>
>+#include <linux/proc_fs.h>
> #include <linux/poll.h>
> #include <linux/random.h>
> #include <linux/skbuff.h>
> #include <linux/smp.h>
> #include <linux/socket.h>
> #include <linux/stddef.h>
>+#include <linux/sysctl.h>
> #include <linux/unistd.h>
> #include <linux/wait.h>
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
>@@ -235,33 +282,42 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
> 	sock_put(&vsk->sk);
> }
>
>-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>+static struct sock *__vsock_find_bound_socket_net(struct sockaddr_vm *addr,
>+						  struct net *net)
> {
> 	struct vsock_sock *vsk;
>
> 	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
>-		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
>-			return sk_vsock(vsk);
>+		struct sock *sk = sk_vsock(vsk);
>+
>+		if (vsock_addr_equals_addr(addr, &vsk->local_addr) &&
>+		    vsock_net_check_mode(sock_net(sk), net))
>+			return sk;
>
> 		if (addr->svm_port == vsk->local_addr.svm_port &&
> 		    (vsk->local_addr.svm_cid == VMADDR_CID_ANY ||
>-		     addr->svm_cid == VMADDR_CID_ANY))
>-			return sk_vsock(vsk);
>+		     addr->svm_cid == VMADDR_CID_ANY) &&
>+		     vsock_net_check_mode(sock_net(sk), net))
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
>+				  struct sockaddr_vm *dst, struct net *net)
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
>+		    vsock_net_check_mode(sock_net(sk), net)) {
>+			return sk;
> 		}
> 	}
>
>@@ -304,12 +360,13 @@ void vsock_remove_connected(struct vsock_sock *vsk)
> }
> EXPORT_SYMBOL_GPL(vsock_remove_connected);
>
>-struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
>+struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr,
>+					 struct net *net)
> {
> 	struct sock *sk;
>
> 	spin_lock_bh(&vsock_table_lock);
>-	sk = __vsock_find_bound_socket(addr);
>+	sk = __vsock_find_bound_socket_net(addr, net);
> 	if (sk)
> 		sock_hold(sk);
>
>@@ -317,15 +374,22 @@ struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
>
> 	return sk;
> }
>+EXPORT_SYMBOL_GPL(vsock_find_bound_socket_net);
>+

Can we document this and the _net version to make it clear to transports 
when using `vsock_find_bound_socket_net()` or 
`vsock_find_bound_socket()`?

>+struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
>+{
>+	return vsock_find_bound_socket_net(addr, NULL);
>+}
> EXPORT_SYMBOL_GPL(vsock_find_bound_socket);
>
>-struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
>-					 struct sockaddr_vm *dst)
>+struct sock *vsock_find_connected_socket_net(struct sockaddr_vm *src,
>+					     struct sockaddr_vm *dst,
>+					     struct net *net)
> {
> 	struct sock *sk;
>
> 	spin_lock_bh(&vsock_table_lock);
>-	sk = __vsock_find_connected_socket(src, dst);
>+	sk = __vsock_find_connected_socket_net(src, dst, net);
> 	if (sk)
> 		sock_hold(sk);
>
>@@ -333,6 +397,13 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
>
> 	return sk;
> }
>+EXPORT_SYMBOL_GPL(vsock_find_connected_socket_net);
>+

Ditto about docuementation.

>+struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
>+					 struct sockaddr_vm *dst)
>+{
>+	return vsock_find_connected_socket_net(src, dst, NULL);
>+}
> EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
>
> void vsock_remove_sock(struct vsock_sock *vsk)
>@@ -528,7 +599,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>
> 	if (sk->sk_type == SOCK_SEQPACKET) {
> 		if (!new_transport->seqpacket_allow ||
>-		    !new_transport->seqpacket_allow(remote_cid)) {
>+		    !new_transport->seqpacket_allow(vsk, remote_cid)) {
> 			module_put(new_transport->module);
> 			return -ESOCKTNOSUPPORT;
> 		}
>@@ -676,6 +747,7 @@ static void vsock_pending_work(struct work_struct *work)
> static int __vsock_bind_connectible(struct vsock_sock *vsk,
> 				    struct sockaddr_vm *addr)
> {
>+	struct net *net = sock_net(sk_vsock(vsk));
> 	static u32 port;
> 	struct sockaddr_vm new_addr;
>
>@@ -695,7 +767,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>
> 			new_addr.svm_port = port++;
>
>-			if (!__vsock_find_bound_socket(&new_addr)) {
>+			if (!__vsock_find_bound_socket_net(&new_addr, net)) {
> 				found = true;
> 				break;
> 			}
>@@ -712,7 +784,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
> 			return -EACCES;
> 		}
>
>-		if (__vsock_find_bound_socket(&new_addr))
>+		if (__vsock_find_bound_socket_net(&new_addr, net))
> 			return -EADDRINUSE;
> 	}
>
>@@ -1314,7 +1386,7 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
> 		goto out;
> 	}
>
>-	if (!transport->dgram_allow(remote_addr->svm_cid,
>+	if (!transport->dgram_allow(vsk, remote_addr->svm_cid,
> 				    remote_addr->svm_port)) {
> 		err = -EINVAL;
> 		goto out;
>@@ -1355,7 +1427,7 @@ static int vsock_dgram_connect(struct socket *sock,
> 	if (err)
> 		goto out;
>
>-	if (!vsk->transport->dgram_allow(remote_addr->svm_cid,
>+	if (!vsk->transport->dgram_allow(vsk, remote_addr->svm_cid,
> 					 remote_addr->svm_port)) {
> 		err = -EINVAL;
> 		goto out;
>@@ -1585,7 +1657,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> 		 * endpoints.
> 		 */
> 		if (!transport ||
>-		    !transport->stream_allow(remote_addr->svm_cid,
>+		    !transport->stream_allow(vsk, remote_addr->svm_cid,
> 					     remote_addr->svm_port)) {
> 			err = -ENETUNREACH;
> 			goto out;
>@@ -2662,6 +2734,183 @@ static struct miscdevice vsock_device = {
> 	.fops		= &vsock_device_ops,
> };
>
>+static int __vsock_net_mode_string(const struct ctl_table *table, int write,
>+				   void *buffer, size_t *lenp, loff_t *ppos,
>+				   enum vsock_net_mode mode,
>+				   enum vsock_net_mode *new_mode)
>+{
>+	char data[VSOCK_NET_MODE_STR_MAX] = {0};
>+	struct ctl_table tmp;
>+	int ret;
>+
>+	if (!table->data || !table->maxlen || !*lenp) {
>+		*lenp = 0;
>+		return 0;
>+	}
>+
>+	tmp = *table;
>+	tmp.data = data;
>+
>+	if (!write) {
>+		const char *p;
>+
>+		switch (mode) {
>+		case VSOCK_NET_MODE_GLOBAL:
>+			p = VSOCK_NET_MODE_STR_GLOBAL;
>+			break;
>+		case VSOCK_NET_MODE_LOCAL:
>+			p = VSOCK_NET_MODE_STR_LOCAL;
>+			break;
>+		default:
>+			WARN_ONCE(true, "netns has invalid vsock mode");
>+			*lenp = 0;
>+			return 0;
>+		}
>+
>+		strscpy(data, p, sizeof(data));
>+		tmp.maxlen = strlen(p);
>+	}
>+
>+	ret = proc_dostring(&tmp, write, buffer, lenp, ppos);

nit:
	if (ret || !write)
		return ret;

>+	if (ret)
>+		return ret;
>+
>+	if (!write)
>+		return 0;
>+
>+	if (*lenp >= sizeof(data))
>+		return -EINVAL;
>+
>+	if (!strncmp(data, VSOCK_NET_MODE_STR_GLOBAL, sizeof(data)))
>+		*new_mode = VSOCK_NET_MODE_GLOBAL;
>+	else if (!strncmp(data, VSOCK_NET_MODE_STR_LOCAL, sizeof(data)))
>+		*new_mode = VSOCK_NET_MODE_LOCAL;
>+	else
>+		return -EINVAL;
>+
>+	return 0;
>+}
>+
>+static int vsock_net_mode_string(const struct ctl_table *table, int write,
>+				 void *buffer, size_t *lenp, loff_t *ppos)
>+{
>+	struct net *net;
>+
>+	if (write)
>+		return -EPERM;
>+
>+	net = current->nsproxy->net_ns;
>+
>+	return __vsock_net_mode_string(table, write, buffer, lenp, ppos,
>+				       vsock_net_mode(net), NULL);
>+}
>+
>+static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
>+				       void *buffer, size_t *lenp, loff_t *ppos)
>+{
>+	enum vsock_net_mode new_mode;
>+	struct net *net;
>+	int ret;
>+
>+	net = current->nsproxy->net_ns;
>+
>+	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
>+				      vsock_net_child_mode(net), &new_mode);
>+	if (ret)
>+		return ret;
>+
>+	if (write)
>+		vsock_net_set_child_mode(net, new_mode);
>+
>+	return 0;
>+}
>+
>+static struct ctl_table vsock_table[] = {
>+	{
>+		.procname	= "ns_mode",
>+		.data		= &init_net.vsock.mode,
>+		.maxlen		= VSOCK_NET_MODE_STR_MAX,
>+		.mode		= 0444,
>+		.proc_handler	= vsock_net_mode_string
>+	},
>+	{
>+		.procname	= "child_ns_mode",
>+		.data		= &init_net.vsock.child_ns_mode,
>+		.maxlen		= VSOCK_NET_MODE_STR_MAX,
>+		.mode		= 0644,
>+		.proc_handler	= vsock_net_child_mode_string
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
>+		table[1].data = &net->vsock.child_ns_mode;
>+	}
>+
>+	net->vsock.sysctl_hdr = register_net_sysctl_sz(net, "net/vsock", table,
>+						       ARRAY_SIZE(vsock_table));
>+	if (!net->vsock.sysctl_hdr)
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
>+	table = net->vsock.sysctl_hdr->ctl_table_arg;
>+	unregister_net_sysctl_table(net->vsock.sysctl_hdr);
>+	if (!net_eq(net, &init_net))
>+		kfree(table);
>+}
>+
>+static void vsock_net_init(struct net *net)
>+{
>+	if (net_eq(net, &init_net))
>+		net->vsock.mode = VSOCK_NET_MODE_GLOBAL;

Right here, I mean, do we always have to use VSOCK_NET_MODE_GLOBAL or 
make it configurable somehow?

The rest LGTM.

Stefano


