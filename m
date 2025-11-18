Return-Path: <linux-kselftest+bounces-45813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79726C66EE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 03:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34D304E994B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 02:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3CB326D74;
	Tue, 18 Nov 2025 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qv3Rs1ej"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659651991D2
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431236; cv=none; b=bq1HtusaUCq/Oa/v+0oInJfsC6ndy8VPkqHeEangF/V86CFedJ7NaW67tfBJLPd+jZyU/PZ3FfltfLxniBmpkISRqOH/jXtEwuf/dQBmi4zQ9bpCSjhJkqE1PCIBTEiVmbmuHgsd3KbqscWOZ47IjxByQVLju4Zhwtj1paQmxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431236; c=relaxed/simple;
	bh=lpQTojzEs/okUQ7fOYuYhyqIVXbB/fT4DFlfWpvIxXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lBEPgb+QQyMvCmcWEpBcb32hnlV4fErv0hhkQnXCOjicjhmmWaaHd1iFUwSnd9qFnZ8K3ITGDJ460RRL5zcx37/5atfKvt9AGdXKDZ0BKGzR1/qEwnTRR7TYodTzAcbpE1cb2QyFV4TWuGUir1qwvbPcUKK/2mIYNGEXD29nDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qv3Rs1ej; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29516a36affso58102205ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 18:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431232; x=1764036032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8aIeeKxPnyywiO1EfP9zuyICRurfwXKu8QSv7CunkI=;
        b=Qv3Rs1ejm4e1zyADitkycTjvUdHJGK9REhexfrwC299QF+bfpM3MM5jX16fhMF1T84
         34bIv24RhMzzZNSB8208zcr1R6jDDbZCzdyyS/N88ssoVyePN/Os3O+MtfHiCe3D6n2J
         0LCUwYchWlPL7PiyWFlZQMndoS+SIqonoF6qWXt8rWA99bPK+7mMLnMuh/8yKQKlzjxr
         7ZDT5hlIv09dQ9t/K2OVTVk/Nv1tHVr1iWqNhd+Kz8gAy/3gkOcx/8TqtHez18VKIc7K
         wfNGx5vJxaIMi9yL6Y4y0ocYk4Nz3htw3XYz8n7foXvz/s/67nCkXwi2OClDtU61+WUz
         uZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431232; x=1764036032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b8aIeeKxPnyywiO1EfP9zuyICRurfwXKu8QSv7CunkI=;
        b=agvLVVzTri1z7VbQsR1sZ2fUuJp6yxJed/Q9QBr0gR/BIlpPfiIhFK2Qhs/oQwHNIQ
         EnA5N58i+9S9B2ytgGAc+5pNKNSqIShB04vj3QYjiVXTDJ3v7r0JFIMumqWpYiuXq8Jk
         nGBVvCcceAvJawolkBoZkjCnjSWPKRHG2mj4jahliVNf4BO8Af/FILiHbJo/itZQG+Kk
         Bw4m+dWA6/VLyFjJ70aSKWcvewym/vSMQMNpLqOP/bjm6uzBo8MglONMXte2JDJYdUa+
         58wn766CfOHjsZjL10Cp4Gzu6SU1BjXhxkNkAi0cQgnho6qI3lbZH9Mtc3VkS/EZpK4u
         n3/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdamonSeNPMwxpgXUgaSKR0VyaQBxqLo88ba/j/SCrK59ISO4j+LKj/yQXLL7KOg1yxAGsBrdVlVpJFr9ypM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygQFO48IAOLqLJLfSgq9orOMgOoTIMXBSA93xRYZN9iToVJ/GT
	GlOiPAKzMmxFt1fpGbREp3aP4e/dPfHJCYME4LkWKJjrG7QrIT9fcMGt
X-Gm-Gg: ASbGnct/E1sB4eJG5k+oNIeLt+rTJ54Uk7C3OHTX9m/ZJ/09BkbOVGsh03XGMSAvTuZ
	O4DFhCAHOdsVWQcIC2XJiOqOP/z2jo0iXFmrQ8z+/xg0KwcAgSdIgExSZQDodZ439uA3Mr2vTHB
	9PdQITXi1WV6BXL7RAj4dLoHwb/N8lja0W3B2qKQN0WZjpHdT5OP8uNsPcNsEKLZKGrb2zdOzbv
	cXYmXCInoiK2v4RqOJjAdeGRIImS/GlLl1wpulTx47JPnhkxLdPYF/ntmLkPELzipxAir/66XQ9
	q/nC8ZZammTZbFyZYR2V6ZE4UDu80QMzdagh2Qg35WfxN7QjmdRmm2CRsF26Ts6bbGpyyjFv678
	Z64uAMYLMSFFaSN75yc/svq2gwz2OwMS36QAbN0VrJkyr5ztpPJF1KlgE+bcDArvOTEr2HNcpad
	9ek1hbwDZpmaMQTaxnXsBT
X-Google-Smtp-Source: AGHT+IEmB0prY00kHOsKXykH548IXaPXxfppFbbvu13bbSYlmmT/BQ2oYwszeiiVDOoywMQR5St25A==
X-Received: by 2002:a17:903:1c5:b0:295:5945:2920 with SMTP id d9443c01a7336-2986a72c2dfmr169951025ad.34.1763431232086;
        Mon, 17 Nov 2025 18:00:32 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0d68sm155537775ad.61.2025.11.17.18.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:00:31 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 17 Nov 2025 18:00:26 -0800
Subject: [PATCH net-next v10 03/11] vsock: reject bad VSOCK_NET_MODE_LOCAL
 configuration for G2H
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-vsock-vmtest-v10-3-df08f165bf3e@meta.com>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
In-Reply-To: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
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
 linux-kselftest@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reject setting VSOCK_NET_MODE_LOCAL with -EOPNOTSUPP if a G2H transport
is operational. Additionally, reject G2H transport registration if there
already exists a namespace in local mode.

G2H sockets break in local mode because the G2H transports don't support
namespacing yet. The current approach is to coerce packets coming out of
G2H transports into VSOCK_NET_MODE_GLOBAL mode, but it is not possible
to coerce sockets in the same way because it cannot be deduced which
transport will be used by the socket. Specifically, when bound to
VMADDR_CID_ANY in a nested VM (both G2H and H2G available), it is not
until a packet is received and matched to the bound socket that we
assign the transport. This presents a chicken-and-egg problem, because
we need the namespace to lookup the socket and resolve the transport,
but we need the transport to know how to use the namespace during
lookup.

For that reason, this patch prevents VSOCK_NET_MODE_LOCAL from being
used on systems that support G2H, even nested systems that also have H2G
transports.

Local mode is blocked based on detecting the presence of G2H devices
(when possible, as hyperv is special). This means that a host kernel
with G2H support compiled in (or has the module loaded), will still
support local mode if there is no G2H (e.g., virtio-vsock) device
detected. This enables using the same kernel in the host and in the
guest, as we do in kselftest.

Systems with only namespace-aware transports (vhost-vsock, loopback) can
still use both VSOCK_NET_MODE_GLOBAL and VSOCK_NET_MODE_LOCAL modes as
intended.

Add supports_local_mode() transport callback to indicate
transport-specific local mode support.

These restrictions can be lifted in a future patch series when G2H
transports gain namespace support.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v10:
- move this patch before any transports bring online namespacing (Stefano)
- move vsock_net_mode_string into critical section (Stefano)
- add ->supports_local_mode() callback to transports (Stefano)
---
 drivers/vhost/vsock.c            |  6 +++++
 include/net/af_vsock.h           |  5 ++++
 net/vmw_vsock/af_vsock.c         | 50 ++++++++++++++++++++++++++++++++++------
 net/vmw_vsock/hyperv_transport.c |  6 +++++
 net/vmw_vsock/virtio_transport.c | 13 +++++++++++
 net/vmw_vsock/vmci_transport.c   |  7 ++++++
 net/vmw_vsock/vsock_loopback.c   |  6 +++++
 7 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 2c937a2df83b..c8319cd1c232 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -64,6 +64,11 @@ static u32 vhost_transport_get_local_cid(void)
 	return VHOST_VSOCK_DEFAULT_HOST_CID;
 }
 
+static bool vhost_transport_supports_local_mode(void)
+{
+	return true;
+}
+
 /* Callers that dereference the return value must hold vhost_vsock_mutex or the
  * RCU read lock.
  */
@@ -412,6 +417,7 @@ static struct virtio_transport vhost_transport = {
 		.module                   = THIS_MODULE,
 
 		.get_local_cid            = vhost_transport_get_local_cid,
+		.supports_local_mode	  = vhost_transport_supports_local_mode,
 
 		.init                     = virtio_transport_do_socket_init,
 		.destruct                 = virtio_transport_destruct,
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 59d97a143204..824d89657d41 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -180,6 +180,11 @@ struct vsock_transport {
 	/* Addressing. */
 	u32 (*get_local_cid)(void);
 
+	/* Return true if this transport supports VSOCK_NET_MODE_LOCAL.
+	 * Otherwise, return false.
+	 */
+	bool (*supports_local_mode)(void);
+
 	/* Read a single skb */
 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 54373ae101c3..7a235bb94437 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -91,6 +91,12 @@
  *   and locked down by a namespace manager. The default is "global". The mode
  *   is set per-namespace.
  *
+ *   Note: LOCAL mode is only supported when using namespace-aware transports
+ *   (vhost-vsock, loopback). If a guest-to-host transport (virtio-vsock,
+ *   hyperv-vsock, vmci-vsock) is loaded, attempts to set LOCAL mode will fail
+ *   with EOPNOTSUPP, as these transports do not support per-namespace
+ *   isolation.
+ *
  *   The modes affect the allocation and accessibility of CIDs as follows:
  *
  *   - global - access and allocation are all system-wide
@@ -2765,17 +2771,30 @@ static int vsock_net_mode_string(const struct ctl_table *table, int write,
 	if (*lenp >= sizeof(data))
 		return -EINVAL;
 
-	if (!strncmp(data, VSOCK_NET_MODE_STR_GLOBAL, sizeof(data)))
+	ret = 0;
+	mutex_lock(&vsock_register_mutex);
+	if (!strncmp(data, VSOCK_NET_MODE_STR_GLOBAL, sizeof(data))) {
 		mode = VSOCK_NET_MODE_GLOBAL;
-	else if (!strncmp(data, VSOCK_NET_MODE_STR_LOCAL, sizeof(data)))
+	} else if (!strncmp(data, VSOCK_NET_MODE_STR_LOCAL, sizeof(data))) {
+		if (transport_g2h && transport_g2h->supports_local_mode &&
+		    !transport_g2h->supports_local_mode()) {
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
 		mode = VSOCK_NET_MODE_LOCAL;
-	else
-		return -EINVAL;
+	} else {
+		ret = -EINVAL;
+		goto out;
+	}
 
-	if (!vsock_net_write_mode(net, mode))
-		return -EPERM;
+	if (!vsock_net_write_mode(net, mode)) {
+		ret = -EPERM;
+		goto out;
+	}
 
-	return 0;
+out:
+	mutex_unlock(&vsock_register_mutex);
+	return ret;
 }
 
 static struct ctl_table vsock_table[] = {
@@ -2916,6 +2935,7 @@ int vsock_core_register(const struct vsock_transport *t, int features)
 {
 	const struct vsock_transport *t_h2g, *t_g2h, *t_dgram, *t_local;
 	int err = mutex_lock_interruptible(&vsock_register_mutex);
+	struct net *net;
 
 	if (err)
 		return err;
@@ -2938,6 +2958,22 @@ int vsock_core_register(const struct vsock_transport *t, int features)
 			err = -EBUSY;
 			goto err_busy;
 		}
+
+		/* G2H sockets break in LOCAL mode namespaces because G2H
+		 * transports don't support them yet. Block registering new G2H
+		 * transports if we already have local mode namespaces on the
+		 * system.
+		 */
+		rcu_read_lock();
+		for_each_net_rcu(net) {
+			if (vsock_net_mode(net) == VSOCK_NET_MODE_LOCAL) {
+				rcu_read_unlock();
+				err = -EOPNOTSUPP;
+				goto err_busy;
+			}
+		}
+		rcu_read_unlock();
+
 		t_g2h = t;
 	}
 
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 432fcbbd14d4..279f04fcd81a 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -833,10 +833,16 @@ int hvs_notify_set_rcvlowat(struct vsock_sock *vsk, int val)
 	return -EOPNOTSUPP;
 }
 
+static bool hvs_supports_local_mode(void)
+{
+	return false;
+}
+
 static struct vsock_transport hvs_transport = {
 	.module                   = THIS_MODULE,
 
 	.get_local_cid            = hvs_get_local_cid,
+	.supports_local_mode      = hvs_supports_local_mode,
 
 	.init                     = hvs_sock_init,
 	.destruct                 = hvs_destruct,
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 5d379ccf3770..e585cb66c6f5 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -94,6 +94,18 @@ static u32 virtio_transport_get_local_cid(void)
 	return ret;
 }
 
+static bool virtio_transport_supports_local_mode(void)
+{
+	struct virtio_vsock *vsock;
+
+	rcu_read_lock();
+	vsock = rcu_dereference(the_virtio_vsock);
+	rcu_read_unlock();
+
+	/* Local mode is supported only when no G2H device is present. */
+	return vsock ? false : true;
+}
+
 /* Caller need to hold vsock->tx_lock on vq */
 static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
 				     struct virtio_vsock *vsock, gfp_t gfp)
@@ -544,6 +556,7 @@ static struct virtio_transport virtio_transport = {
 		.module                   = THIS_MODULE,
 
 		.get_local_cid            = virtio_transport_get_local_cid,
+		.supports_local_mode      = virtio_transport_supports_local_mode,
 
 		.init                     = virtio_transport_do_socket_init,
 		.destruct                 = virtio_transport_destruct,
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 7eccd6708d66..da7c52ad7b2a 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -2033,6 +2033,12 @@ static u32 vmci_transport_get_local_cid(void)
 	return vmci_get_context_id();
 }
 
+static bool vmci_transport_supports_local_mode(void)
+{
+	/* Local mode is supported only when no device is present. */
+	return vmci_transport_get_local_cid() == VMCI_INVALID_ID;
+}
+
 static struct vsock_transport vmci_transport = {
 	.module = THIS_MODULE,
 	.init = vmci_transport_socket_init,
@@ -2062,6 +2068,7 @@ static struct vsock_transport vmci_transport = {
 	.notify_send_post_enqueue = vmci_transport_notify_send_post_enqueue,
 	.shutdown = vmci_transport_shutdown,
 	.get_local_cid = vmci_transport_get_local_cid,
+	.supports_local_mode = vmci_transport_supports_local_mode,
 };
 
 static bool vmci_check_transport(struct vsock_sock *vsk)
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 8722337a4f80..1e25c1a6b43f 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -26,6 +26,11 @@ static u32 vsock_loopback_get_local_cid(void)
 	return VMADDR_CID_LOCAL;
 }
 
+static bool vsock_loopback_supports_local_mode(void)
+{
+	return true;
+}
+
 static int vsock_loopback_send_pkt(struct sk_buff *skb)
 {
 	struct vsock_loopback *vsock = &the_vsock_loopback;
@@ -58,6 +63,7 @@ static struct virtio_transport loopback_transport = {
 		.module                   = THIS_MODULE,
 
 		.get_local_cid            = vsock_loopback_get_local_cid,
+		.supports_local_mode	  = vsock_loopback_supports_local_mode,
 
 		.init                     = virtio_transport_do_socket_init,
 		.destruct                 = virtio_transport_destruct,

-- 
2.47.3


