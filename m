Return-Path: <linux-kselftest+bounces-45900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 457B5C6B174
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 19:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F2124E0348
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48EA2DC348;
	Tue, 18 Nov 2025 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoFZVyxW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="evV/cxnh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4DA2D7DEA
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489052; cv=none; b=BniS5GFVAdH1N135+plTbv/yBC9vooNutXpiTTNVjtMTvv61M47nqFdZ8FhbYEuAICOtKtULuNpznREye38ut3nXANEpMGtHMZkMAROgSkvOj1061oAQoDxJefMNo+GZem0lRm8DtovXm6brzdMsxHOf3OjTDZHHb7JSkQQkEq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489052; c=relaxed/simple;
	bh=s+cwPXsVLSNo1ubmatgKVj1SDIBuFfEsEXm/mCHspCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dr9GsExNTx0NV/gD58QJkhhKT32kddriWw5MCTlM7g2eEisB4yb5Qly2+ZdZM6Bli+7DPavRVU5H/kJu8IKlTjdmRMD5y5WWpi96xBpEMScZQIoUYQED2Uuze8mVjSJ3ecR4vxRAqArXoTUtTh9zPnPLY73j+kDO0MMa6Op6J9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BoFZVyxW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=evV/cxnh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ySMhDYrMZ/Xx4AMvhjc7dxlay0zt2DHzPjG22vBPrHE=;
	b=BoFZVyxWo7IEYZavxrC88qL3AdkZaVTDnYmw6ND/SGy678sz5QRtTcNq3RhzUSwU92oZiy
	e2mEvH0QuPwoZEl9Ab+gs5xo8kfp6svewNFykADrexoso782JU/haIr4+KWzj42NMR0Apn
	PYFJe2YwOhbAH2ZmFg+bDAvummpRCpc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-JjRnLhayPniFt4o9zCgqHg-1; Tue, 18 Nov 2025 13:04:06 -0500
X-MC-Unique: JjRnLhayPniFt4o9zCgqHg-1
X-Mimecast-MFC-AGG-ID: JjRnLhayPniFt4o9zCgqHg_1763489045
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so13219975e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 10:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763489045; x=1764093845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySMhDYrMZ/Xx4AMvhjc7dxlay0zt2DHzPjG22vBPrHE=;
        b=evV/cxnheMWoOirQOpUw+X+GXIklPNKjJ/xchSPLDp/xDkAYSeU5X0Na9+CWP7v2HG
         pOgARW7PeCV0nmNSUDYbNtGPK5bCfWcZEIdrp+dAW9wMxG1Xy6Sz42aQc2o3SqM7JpFF
         FhmkUEgZxm5JI76mSYpHYJp9LMEzg/r2rTyhvgDBDg4x51ejnL/My/Wa6Qu0rz46DnvL
         nBgi3ZNqpsN5EasuyNAtFiqhDx9j3ViMk7wU+ePAmRBJ3WgnbeuwvGT46rQ7MU1YRhSB
         +WMxWWkN9yaPLf8PEphQ13lmKpRB5Eo+bkjMRDJRtqdOiL80no2t6fJnPDL1eo/usS1r
         /e0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489045; x=1764093845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySMhDYrMZ/Xx4AMvhjc7dxlay0zt2DHzPjG22vBPrHE=;
        b=kToHqdPP61uOz+UmQ7EYfrd1mAq3DiSySq5eQa/G6XSWdZCZOUiQBw+U6k1GTZGYIy
         OS2bYcocwF6OqHgYBR2m2vQD3p0KKrwX6j+irK8hV5c+x6B1KDV5HbU4N6z9t/2lwYEl
         BETNxVwVnnwTXixQ7bEdclpug1XKs14g1AV+la4L9j91fpc19Z7raV/hyMpFI7WBhrvF
         FH6Z0fZtfr6abEGDvyk0PTABpIYbhyUiSNkxrdKr5BM5b+mkw9Tb0qNXBeDt3IC+RB3A
         ZX1qECiBtFKO+ujkamF9wZp2kl9RQunnR+9LSqbooNod7gOvjV7FJrEBqVQ6H37hGAGX
         ODMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4Dy2on4tamZkQPN7qHzdQwSyZ0SHFbbvVdfn3aa+SNfBiA/nOH3bvYx0Vr0OCg6lbr3UsffHB/LVw6zihda0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeATq50WtuJbtwHZ4Y7fxr+HBxZronG6GIULMQMDFLAJpGhinI
	G3dHqLjOYjOyFCO44MqWhti9yX3PVHqyIlQBtVMs80/lsOaZkw1VeqOuH9zXE08sTln1wMXS2zA
	hI0ZN+COmntxw3HiU21caY9zzQxMiQDpwV0W7uPCuQZXMLqothpZegdtrbaBj20+scIQjHQ==
X-Gm-Gg: ASbGncu0jmmmDwyhsNGfiKMrj+L4E4euWN6YsmTu9LL/4yGdTDR6yS9IwbWtUQfNAGd
	MeOWY+0B9s1HVuHvfH2gDPUmaKlA1LBohdvI7Q8qszC5P9EW96YIlzdbZblf8MmxV7yoeRCrdyV
	Diw9o4a5xNtS+FvqupL4XJwcMLbdApQKf27kdfUFml8m40xJs5Sgk6X/2x4O2DxMOZ7tpJNbFPy
	KI84+UtfImcW96Xr72v01nZIRuKO/k+uI4x6T9oSCLQ1CZAfsPtyjHG8Xpogue1ffbqA1yZOxU2
	Tg4JSWd+hfUi+J5BDNvSTVxgcPy9DHHhUkxzv6BqUhu0ToylgAFzOJFvgRnzLH71mBs1/qLPxGQ
	llGzW4O+/7SF4beV5oNxBIDI1Ki+cKYL3ZXc1wSxH/ciNrGgt
X-Received: by 2002:a7b:c014:0:b0:477:994b:dbb8 with SMTP id 5b1f17b1804b1-477994bddeemr81418925e9.11.1763489045224;
        Tue, 18 Nov 2025 10:04:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpBG/2sJMbhkzpQOcxnTlmbcbHN4RuL+yQSZxX8aLutRGg8XkylL+hIZNfpXYQY2Dh7dA7sA==
X-Received: by 2002:a7b:c014:0:b0:477:994b:dbb8 with SMTP id 5b1f17b1804b1-477994bddeemr81418715e9.11.1763489044753;
        Tue, 18 Nov 2025 10:04:04 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10142d3sm3864205e9.5.2025.11.18.10.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:04:03 -0800 (PST)
Date: Tue, 18 Nov 2025 19:03:49 +0100
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
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 01/11] vsock: a per-net vsock NS mode state
Message-ID: <7qu24adya4hyiu6enzgflua3nac7o3d4ymrhzksjig54p4vh6n@n4ehmhlbh5wn>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-1-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251117-vsock-vmtest-v10-1-df08f165bf3e@meta.com>

On Mon, Nov 17, 2025 at 06:00:24PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add the per-net vsock NS mode state. This only adds the structure for
>holding the mode and some of the functions for setting/getting and
>checking the mode, but does not integrate the functionality yet.
>
>A "net_mode" field is added to vsock_sock to store the mode of the
>namespace when the vsock_sock was created. In order to evaluate
>namespace mode rules we need to know both a) which namespace the
>endpoints are in, and b) what mode that namespace had when the endpoints
>were created. This allows us to handle the changing of modes from global
>to local *after* a socket has been created by remembering that the mode
>was global when the socket was created. If we were to use the current
>net's mode instead, then the lookup would fail and the socket would
>break.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v10:
>- change mode_locked to int (Stefano)
>
>Changes in v9:
>- use xchg(), WRITE_ONCE(), READ_ONCE() for mode and mode_locked (Stefano)
>- clarify mode0/mode1 meaning in vsock_net_check_mode() comment
>- remove spin lock in net->vsock (not used anymore)
>- change mode from u8 to enum vsock_net_mode in vsock_net_write_mode()
>
>Changes in v7:
>- clarify vsock_net_check_mode() comments
>- change to `orig_net_mode == VSOCK_NET_MODE_GLOBAL && orig_net_mode == vsk->orig_net_mode`
>- remove extraneous explanation of `orig_net_mode`
>- rename `written` to `mode_locked`
>- rename `vsock_hdr` to `sysctl_hdr`
>- change `orig_net_mode` to `net_mode`
>- make vsock_net_check_mode() more generic by taking just net pointers
>  and modes, instead of a vsock_sock ptr, for reuse by transports
>  (e.g., vhost_vsock)
>
>Changes in v6:
>- add orig_net_mode to store mode at creation time which will be used to
>  avoid breakage when namespace changes mode during socket/VM lifespan
>
>Changes in v5:
>- use /proc/sys/net/vsock/ns_mode instead of /proc/net/vsock_ns_mode
>- change from net->vsock.ns_mode to net->vsock.mode
>- change vsock_net_set_mode() to vsock_net_write_mode()
>- vsock_net_write_mode() returns bool for write success to avoid
>  need to use vsock_net_mode_can_set()
>- remove vsock_net_mode_can_set()
>---
> MAINTAINERS                 |  1 +
> include/net/af_vsock.h      | 44 ++++++++++++++++++++++++++++++++++++++++++++
> include/net/net_namespace.h |  4 ++++
> include/net/netns/vsock.h   | 17 +++++++++++++++++
> 4 files changed, 66 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 37f4278db851..e1e0e2092d0c 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -27101,6 +27101,7 @@ L:	netdev@vger.kernel.org
> S:	Maintained
> F:	drivers/vhost/vsock.c
> F:	include/linux/virtio_vsock.h
>+F:	include/net/netns/vsock.h
> F:	include/uapi/linux/virtio_vsock.h
> F:	net/vmw_vsock/virtio_transport.c
> F:	net/vmw_vsock/virtio_transport_common.c
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index d40e978126e3..9b5bdd083b6f 100644
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
>@@ -65,6 +66,7 @@ struct vsock_sock {
> 	u32 peer_shutdown;
> 	bool sent_request;
> 	bool ignore_connecting_rst;
>+	enum vsock_net_mode net_mode;
>
> 	/* Protected by lock_sock(sk) */
> 	u64 buffer_size;
>@@ -256,4 +258,46 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
> {
> 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
> }
>+
>+static inline enum vsock_net_mode vsock_net_mode(struct net *net)
>+{
>+	return READ_ONCE(net->vsock.mode);
>+}
>+
>+static inline bool vsock_net_write_mode(struct net *net,
>+					enum vsock_net_mode mode)
>+{
>+	if (xchg(&net->vsock.mode_locked, 1))
>+		return false;
>+
>+	WRITE_ONCE(net->vsock.mode, mode);
>+	return true;
>+}
>+
>+/* Return true if two namespaces and modes pass the mode rules. Otherwise,
>+ * return false.
>+ *
>+ * - ns0 and ns1 are the namespaces being checked.
>+ * - mode0 and mode1 are the vsock namespace modes of ns0 and ns1 at the time
>+ *   the vsock objects were created.
>+ *
>+ * Read more about modes in the comment header of net/vmw_vsock/af_vsock.c.
>+ */
>+static inline bool vsock_net_check_mode(struct net *ns0,
>+					enum vsock_net_mode mode0,
>+					struct net *ns1,
>+					enum vsock_net_mode mode1)
>+{
>+	/* Any vsocks within the same network namespace are always reachable,
>+	 * regardless of the mode.
>+	 */
>+	if (net_eq(ns0, ns1))
>+		return true;
>+
>+	/*
>+	 * If the network namespaces differ, vsocks are only reachable if both
>+	 * were created in VSOCK_NET_MODE_GLOBAL mode.
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
>index 000000000000..c1a5e805949d
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
>+	int mode_locked;
>+};
>+#endif /* __NET_NET_NAMESPACE_VSOCK_H */
>
>-- 
>2.47.3
>


