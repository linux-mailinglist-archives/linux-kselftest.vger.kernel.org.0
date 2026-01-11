Return-Path: <linux-kselftest+bounces-48673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF00D0E189
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 07:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B104F30109B1
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 06:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9DB22AE65;
	Sun, 11 Jan 2026 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBkVDWOr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="p8NgQd9H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3594E136672
	for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768112991; cv=none; b=hiOlc3w8/ujJi2nYjU2G2CXIrkK7IAOl5CsmwGcIGNm7c4w86ufAv3oWPRCoiNmSPah3izLjNSKRQB3eDS90xZT/PqS15KO5bhGfZfzwooPwqjL2M4x2wayO5adhI7IYWonhyTnZDcgpxvULbdv587PTD9q61rfRa437IIlF3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768112991; c=relaxed/simple;
	bh=jBqzGAPrybDMcPA1sSp012FV6F6PScUrNqkxyjb03ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWes3mSfYTkc1fBApi7t9BBVgK0tCbvm+zHZOpOV9MeDEwwYazFsJ+ZaDDqFm9L0E+bsd29ZawlLI1DNshk5DFAYjz4WEgyUux2zXdQgILfsA0/S/JwOwsG5RyltBQWiYi01D3LTyj1tC8MRsJEBXXqEjUrNiZQVrc5lIIDjBfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBkVDWOr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=p8NgQd9H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768112988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IqILrVCS9tDmtote2rLypfKXBmD+4YEAa7AMdCllKvk=;
	b=iBkVDWOrRHHjJB0qQDDqckm3A84yFVXVylmivPMy8oMXDOp26r1xSN35av7HUTviPq6eEv
	mx2gOeDfs2A8D4lI52uM1HOpYhxIWF/xfUkA99UlCFyK+Gj0ZnUhJpb0Be2CHStK3xhVE1
	COgMrNufD2pL+rzt1naYFfKPDUSyEnI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-Q5Yhh0h4Nx6RIW0Tty1ZQg-1; Sun, 11 Jan 2026 01:29:46 -0500
X-MC-Unique: Q5Yhh0h4Nx6RIW0Tty1ZQg-1
X-Mimecast-MFC-AGG-ID: Q5Yhh0h4Nx6RIW0Tty1ZQg_1768112985
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4792bd2c290so62913275e9.1
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jan 2026 22:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768112985; x=1768717785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IqILrVCS9tDmtote2rLypfKXBmD+4YEAa7AMdCllKvk=;
        b=p8NgQd9HGXpY9tfzvtBtlmAr8X0/KkDCiIA8LJgW/K75S/uiKhGYamGXqeGCuz+n8z
         Y9Bj9NScYgIC/p/LBTdMFOW9E/1EJ8euS4ont8QvhV0emJQhpkQXYfiKq3RimmZsCA4g
         6b6P32+/OmwCv1v881/O/eHg2dYwmtKphp6c1Z4KqddLIj45qlAgL7AvfA9ZgwW5QGWe
         cMgfyZFi7R3c3uGrSoTU/NoSF4cUuAiA9lMEia2b3r8Yi4UitJMnQDJ5v+a/Xu14jHK3
         r0xquq3M9SDHDTi5Hs6YjGyiANb5FRUNt2/edX4I+i3IIGuFRNje2dfmpjS9Nbyfb74c
         UiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768112985; x=1768717785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqILrVCS9tDmtote2rLypfKXBmD+4YEAa7AMdCllKvk=;
        b=k+sVEXty9H/ko7pnVEvJp4Q0e7iO3cFUUQbR9ip17hSNNQXAQluEXO8VLS8mK+VW2a
         vXHmddalp0mY1UkhasfgiBGKKfO/3HEzuQm1uNTJDfFvv1ogQ6x4QCmQUbvLuHSYA9On
         jRrhq/OQZ4m6ALowQkv8XFvHgQQJJGSe9wbDlU8ECR4mWcPChfONeVdCEsWIHRgduJDm
         +FKacgAORbb2N19cgRsxkEQXvqIrrHplFMD9Dn3XTObb+rm3sAhztZ5pMFAwIkeL7MNL
         8FACXJR0PCTN39YwAMAW9dJKZVV60fPx2HG5SvvoQpOdX6Jz2Rn+pbHJssm0xzSFvRXu
         a4yQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+ktj/js12jKCJ0xz1liRCPTxlZelqtvROIkvTukPVMqTVTw7JNJ1y+ceGzn5G+EOC3+LnwyRUBHEaifWgASI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvcaeZ6Y74gaZjZ7SGvhqg9N1/P4hHJXLkzzLRKn7i3+M20+Nq
	i505FlBMpR7x8XhUzvHT3H6wl/dUBrV+5+Ikely/dtLPQSsT0lROJNuRIblBZVMB8S5Dgxi8HfP
	GMR6P4leVwZv26Rip4I7lV7EjzLKUUBWG1/JkhLgF0qCaeeZ5ZmzIRgS8E26z6qeH4fNDqg==
X-Gm-Gg: AY/fxX7Phnb/0HpVv8bV0YohRHcxDkwe3YFhLjKuOCnjnuznXX8nVPw5kx/W3ZQokbt
	mtqANSInuYzb7m3c6ylKxWOmORZubHL3cAT5KtTsObK4FcCBEdPU2sLV25CB3qAW6C97GGJS5O3
	VJ54vIS/P9U4q2/VDYUQZ/zpS9SVrpL20LEJ6rknX6eByIaoaVIN/t5gw2My9f4C0mm8co6CDPC
	lUXOCG51l2otesgDcaBfepuragO3HpoE2dqpwyJZdsB21ReU7OLWE8b004QpLliYhi8Yrigh399
	sRZBccpGczJWzok+vidHNj3Au3/uHKq/zVgLlx9NUPf/8+J5GrERVjteKhXerBKQypHCqsSQpMn
	tbA3y9Z+JqOgoG35d7w6mxXsWQYVtSTw=
X-Received: by 2002:a05:600c:8b2c:b0:47d:3690:7490 with SMTP id 5b1f17b1804b1-47d84b1849emr174581125e9.9.1768112985397;
        Sat, 10 Jan 2026 22:29:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGe7rEsXMZNMyBjemsPoyMhuDSMeJztwBU0aSiQDzL5RwbDPn81SkbLht2mUJ8G8HVblfB0mQ==
X-Received: by 2002:a05:600c:8b2c:b0:47d:3690:7490 with SMTP id 5b1f17b1804b1-47d84b1849emr174580685e9.9.1768112984747;
        Sat, 10 Jan 2026 22:29:44 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f69dsm287672195e9.1.2026.01.10.22.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 22:29:44 -0800 (PST)
Date: Sun, 11 Jan 2026 01:29:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 01/13] vsock: add per-net vsock NS mode
 state
Message-ID: <20260111012612-mutt-send-email-mst@kernel.org>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <20251223-vsock-vmtest-v13-1-9d6db8e7c80b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223-vsock-vmtest-v13-1-9d6db8e7c80b@meta.com>

On Tue, Dec 23, 2025 at 04:28:35PM -0800, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add the per-net vsock NS mode state. This only adds the structure for
> holding the mode and some of the functions for setting/getting and
> checking the mode, but does not integrate the functionality yet.
> 
> Future patches add the uAPI and transport-specific usage of these
> structures and helpers.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>


I do not much like splitting out functionality like this,
myself - there's little to no docs and one can't figure out
whether this code does what it is  supposed to do without
reading the next patch.

I would just squash this with that one.

If you are splitting functionality along some API lines,
you need detailed docs so one can review implementation
separately from use.


> ---
> Changes in v13:
> - remove net_mode because net->vsock.mode becomes immutable, no need to
>   save the mode when vsocks are created.
> - add the new helpers for child_ns_mode to support ns_mode inheriting
>   the mode from child_ns_mode.
> - because ns_mode is immutable and child_ns_mode can be changed multiple
>   times, remove the write-once lock.
> - simplify vsock_net_check_mode() to no longer take mode arguments since
>   the mode can be accessed via the net pointers without fear of the mode
>   changing.
> - add logic in vsock_net_check_mode() to infer VSOCK_NET_MODE_GLOBAL
>   from NULL namespaces in order to allow only net pointers to be passed
>   to vsock_net_check_mode(), while still allowing namespace-unaware
>   transports to force global mode.
> 
> Changes in v10:
> - change mode_locked to int (Stefano)
> 
> Changes in v9:
> - use xchg(), WRITE_ONCE(), READ_ONCE() for mode and mode_locked (Stefano)
> - clarify mode0/mode1 meaning in vsock_net_check_mode() comment
> - remove spin lock in net->vsock (not used anymore)
> - change mode from u8 to enum vsock_net_mode in vsock_net_write_mode()
> 
> Changes in v7:
> - clarify vsock_net_check_mode() comments
> - change to `orig_net_mode == VSOCK_NET_MODE_GLOBAL && orig_net_mode == vsk->orig_net_mode`
> - remove extraneous explanation of `orig_net_mode`
> - rename `written` to `mode_locked`
> - rename `vsock_hdr` to `sysctl_hdr`
> - change `orig_net_mode` to `net_mode`
> - make vsock_net_check_mode() more generic by taking just net pointers
>   and modes, instead of a vsock_sock ptr, for reuse by transports
>   (e.g., vhost_vsock)
> 
> Changes in v6:
> - add orig_net_mode to store mode at creation time which will be used to
>   avoid breakage when namespace changes mode during socket/VM lifespan
> 
> Changes in v5:
> - use /proc/sys/net/vsock/ns_mode instead of /proc/net/vsock_ns_mode
> - change from net->vsock.ns_mode to net->vsock.mode
> - change vsock_net_set_mode() to vsock_net_write_mode()
> - vsock_net_write_mode() returns bool for write success to avoid
>   need to use vsock_net_mode_can_set()
> - remove vsock_net_mode_can_set()
> ---
>  MAINTAINERS                 |  1 +
>  include/net/af_vsock.h      | 42 ++++++++++++++++++++++++++++++++++++++++++
>  include/net/net_namespace.h |  4 ++++
>  include/net/netns/vsock.h   | 17 +++++++++++++++++
>  4 files changed, 64 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 454b8ed119e9..38d24e5a957c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27516,6 +27516,7 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/vhost/vsock.c
>  F:	include/linux/virtio_vsock.h
> +F:	include/net/netns/vsock.h
>  F:	include/uapi/linux/virtio_vsock.h
>  F:	net/vmw_vsock/virtio_transport.c
>  F:	net/vmw_vsock/virtio_transport_common.c
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index d40e978126e3..6f5bc9dbefa5 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -10,6 +10,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/workqueue.h>
> +#include <net/netns/vsock.h>
>  #include <net/sock.h>
>  #include <uapi/linux/vm_sockets.h>
>  
> @@ -256,4 +257,45 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
>  {
>  	return t->msgzerocopy_allow && t->msgzerocopy_allow();
>  }
> +
> +static inline enum vsock_net_mode vsock_net_mode(struct net *net)
> +{
> +	return READ_ONCE(net->vsock.mode);
> +}
> +
> +static inline void vsock_net_set_child_mode(struct net *net,
> +					    enum vsock_net_mode mode)
> +{
> +	WRITE_ONCE(net->vsock.child_ns_mode, mode);
> +}
> +
> +static inline enum vsock_net_mode vsock_net_child_mode(struct net *net)
> +{
> +	return READ_ONCE(net->vsock.child_ns_mode);
> +}
> +
> +/* Return true if two namespaces pass the mode rules. Otherwise, return false.
> + *
> + * A NULL namespace is treated as VSOCK_NET_MODE_GLOBAL.
> + *
> + * Read more about modes in the comment header of net/vmw_vsock/af_vsock.c.
> + */
> +static inline bool vsock_net_check_mode(struct net *ns0, struct net *ns1)
> +{
> +	enum vsock_net_mode mode0, mode1;
> +
> +	/* Any vsocks within the same network namespace are always reachable,
> +	 * regardless of the mode.
> +	 */
> +	if (net_eq(ns0, ns1))
> +		return true;
> +
> +	mode0 = ns0 ? vsock_net_mode(ns0) : VSOCK_NET_MODE_GLOBAL;
> +	mode1 = ns1 ? vsock_net_mode(ns1) : VSOCK_NET_MODE_GLOBAL;
> +
> +	/* Different namespaces are only reachable if they are both
> +	 * global mode.
> +	 */
> +	return mode0 == VSOCK_NET_MODE_GLOBAL && mode0 == mode1;
> +}
>  #endif /* __AF_VSOCK_H__ */
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index cb664f6e3558..66d3de1d935f 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -37,6 +37,7 @@
>  #include <net/netns/smc.h>
>  #include <net/netns/bpf.h>
>  #include <net/netns/mctp.h>
> +#include <net/netns/vsock.h>
>  #include <net/net_trackers.h>
>  #include <linux/ns_common.h>
>  #include <linux/idr.h>
> @@ -196,6 +197,9 @@ struct net {
>  	/* Move to a better place when the config guard is removed. */
>  	struct mutex		rtnl_mutex;
>  #endif
> +#if IS_ENABLED(CONFIG_VSOCKETS)
> +	struct netns_vsock	vsock;
> +#endif
>  } __randomize_layout;
>  
>  #include <linux/seq_file_net.h>
> diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
> new file mode 100644
> index 000000000000..e2325e2d6ec5
> --- /dev/null
> +++ b/include/net/netns/vsock.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __NET_NET_NAMESPACE_VSOCK_H
> +#define __NET_NET_NAMESPACE_VSOCK_H
> +
> +#include <linux/types.h>
> +
> +enum vsock_net_mode {
> +	VSOCK_NET_MODE_GLOBAL,
> +	VSOCK_NET_MODE_LOCAL,
> +};
> +
> +struct netns_vsock {
> +	struct ctl_table_header *sysctl_hdr;
> +	enum vsock_net_mode mode;
> +	enum vsock_net_mode child_ns_mode;
> +};
> +#endif /* __NET_NET_NAMESPACE_VSOCK_H */
> 
> -- 
> 2.47.3


