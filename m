Return-Path: <linux-kselftest+bounces-46187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4B8C776A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 06:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 76A1E2CA25
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 05:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF162FB97E;
	Fri, 21 Nov 2025 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LihFDLWO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F52F5A2B
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703897; cv=none; b=T3wUM6gud5CgsEeo4ENvksl1ICslh370A9ggAaeew7A/8r24+azdhfQrlYJBy0St2h8RdSZS16tWgcdktGI6hO4GeRbsohvzqjvuQkY7Xgpf9FIv7y7xjgwP/4yQ7CSYaWJqREdfdcKNFuPek1ut33OGk6xrGLcDJOGtTgdt/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703897; c=relaxed/simple;
	bh=uEfXdeSVANLUa6rVejsVaXrIRmYS9OcD1C0m/NXBtP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V/h8JyEtir4K6/bpzpk/bKGVqY7KkWFxwX96tVf94qmbCo1yVQaVU4BWVFj8Ld9PBtllB1LnU2FCghaRxgYvJG0LpOd6svABRo9s6TnMnp6Ra4esmxlrPqsJlvTt7438BS4ecwU9W1aiSRVuK0P+qQS1B8Kxaj4cbhlenZwvnwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LihFDLWO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343dd5aa6e7so1712686a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 21:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703893; x=1764308693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odLLOhtwYmzSqbG24AKMnQi3WKDhrK2QPqqiED54J4I=;
        b=LihFDLWO/Akg2GQLms7m1Zn8/6oDtQunGH9tYRAa6wqKZg17V77oz96ISBNs3ieI1N
         LRe+fpD3PRp2XwQYPijeOttEFeG84NFdbymDW45K55QNYwJKeL9TSw6gBHGnG4MX1Xmn
         1CkEa4zmYSRT1mHJvq+BTexeOGv0T+kWn+JhJbaHC5ntMkJNvYzkeDKhvwnRwqQ1V2ha
         jw8HL0rd+RffQZFNykYWbtzyA7WEjLAXVRCs1aJ0Ue4GPZd2I7QXz/OB7jFLSOqeKKIE
         L/BNbB8/SxPe1PtGtDxxmeVBToqtkgivC9vvFy+uSnLLfL6oDGXd2FX1YUGPhy14sLRk
         Qdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703893; x=1764308693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=odLLOhtwYmzSqbG24AKMnQi3WKDhrK2QPqqiED54J4I=;
        b=hU4cNfSooRCm43n/m1eF/STTQnQjxQ7Nk+/LqUwXJ+J80eXz9Ra4OpSdiovV1X+RT0
         JdxCo5d9CmhvKNZ+w7PuRCBBzVk8liMisWmcVNBlN870kbCpNb0Xo0ymUpPLzH0P9Jyq
         LWaqGEX0mtvM0KlNETAvyC3EqWgB5NNqsfpqJgqAG+viXbGh4VZoP5knMU/1sSbJuqbz
         lH9/DyRFT0ZCzhSTydi0cB5BjsKeSeIHDN859SwP13HGjXPKhVboEW/qXy97ncHeL+17
         X+8lJh7Ys0J6No4+g0jawwJmxS3tK59wDaCbJJMYI9PPYKkuEn+sOBL6iqTky3kwUnQf
         TIzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDmCgdjdolABpms+59VKdfOOUFztbJwpFQFmGcGX6Tt5xpCzrxtn+yLnkXeBW9OKfVOCgbbyq64BW2DKR+eRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDTZL5GIqvhvmcWn04xyz6QkJ+P5Q0cq4YYVFgKQzMimTxbov
	7gGh28weLPDMjQhjdoYOhXH+JRPTVNJw2RFp4lTwUVB1PeZXtfvcK+tp
X-Gm-Gg: ASbGncvvFBfm4uR7CeOi8sDVyN5SlvYBQeGeIV9ZwN5AQ136ftFQ29QmoJcbdjJSNyn
	hLmmnPGy44/T+5HQA03VWB0vA9GbXQmRBVdOFEIdC4YoTF740mUzhib+dfnbQOqBXYW0AqjH8iU
	hBzKaTa1ClelA8mmcdFZspou+MO6WJjgOKypl4mpcvd4tpf9WGDcDkNRirL9RYuV0t5QlMBEEKC
	ILOAfizBfQoLj5y14hnypMZV+1i5zpxQtRd2rkI166oCl+GuNCGautzROlnHM/WS9uCW8WAD/vh
	B0ClwHjahXHE474ww32ya1ZCa3AXnPdTj9Vlal0M1bOUbS91HNasS39J5uB8KxZkpzeVaWuEPZU
	Om7yGCaYRM+qt9/nJQYV5uVzn2JcdxxbBeQC9kS3CZAhniGx+NFfEmZkzjB4JQviptR8Sq+YVB6
	c99p+EEBl7k11OCaJ1Kl4=
X-Google-Smtp-Source: AGHT+IEO5g5+wAXGn3n7vGiB6yvUY7bPn1d4X+FB4X8ZXWt5BzrBvDjejtFbJoFDNynTDw1Ei5KFMQ==
X-Received: by 2002:a17:90b:1c85:b0:32e:38b0:15f4 with SMTP id 98e67ed59e1d1-34733e46dc6mr1512838a91.7.1763703893331;
        Thu, 20 Nov 2025 21:44:53 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34726696bb2sm4398523a91.3.2025.11.20.21.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:44:53 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:35 -0800
Subject: [PATCH net-next v11 03/13] vsock: reject bad VSOCK_NET_MODE_LOCAL
 configuration for G2H
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-3-55cbc80249a7@meta.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
In-Reply-To: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
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
Changes in v11:
- vhost_transport_supports_local_mode() returns false to keep things
  disabled until support comes online (Stefano)
- add comment above supports_local_mode() cb to clarify (Stefano)
- Remove redundant `ret = 0` initialization in vsock_net_mode_string()
  (Stefano)
- Refactor vsock_net_mode_string() to separate parsing from validation
  (Stefano)
- vmci returns false for supports_local_mode(), with comment

Changes in v10:
- move this patch before any transports bring online namespacing (Stefano)
- move vsock_net_mode_string into critical section (Stefano)
- add ->supports_local_mode() callback to transports (Stefano)
---
 drivers/vhost/vsock.c            |  6 ++++++
 include/net/af_vsock.h           | 11 +++++++++++
 net/vmw_vsock/af_vsock.c         | 32 ++++++++++++++++++++++++++++++++
 net/vmw_vsock/hyperv_transport.c |  6 ++++++
 net/vmw_vsock/virtio_transport.c | 13 +++++++++++++
 net/vmw_vsock/vmci_transport.c   | 12 ++++++++++++
 net/vmw_vsock/vsock_loopback.c   |  6 ++++++
 7 files changed, 86 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 69074656263d..4e3856aa2479 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -64,6 +64,11 @@ static u32 vhost_transport_get_local_cid(void)
 	return VHOST_VSOCK_DEFAULT_HOST_CID;
 }
 
+static bool vhost_transport_supports_local_mode(void)
+{
+	return false;
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
index 59d97a143204..e24ef1d9fe02 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -180,6 +180,17 @@ struct vsock_transport {
 	/* Addressing. */
 	u32 (*get_local_cid)(void);
 
+	/* Return true if the transport is compatible with
+	 * VSOCK_NET_MODE_LOCAL. Otherwise, return false.
+	 *
+	 * Transports should return false if they lack local-mode namespace
+	 * support (e.g., G2H transports like hyperv-vsock and vmci-vsock).
+	 * virtio-vsock returns true only if no device is present in order to
+	 * enable local mode in nested scenarios in which virtio-vsock is
+	 * loaded or built-in, but nonetheless unusable by sockets.
+	 */
+	bool (*supports_local_mode)(void);
+
 	/* Read a single skb */
 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 243c0d588682..120adb9dad9f 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -91,6 +91,12 @@
  *   and locked down by a namespace manager. The default is "global". The mode
  *   is set per-namespace.
  *
+ *   Note: LOCAL mode is only supported when using namespace-aware transports
+ *   (vhost-vsock, loopback). If a guest-to-host transport (virtio-vsock,
+ *   hyperv-vsock, vmci-vsock) is operational, attempts to set LOCAL mode will
+ *   fail with EOPNOTSUPP, as these transports do not support per-namespace
+ *   isolation.
+ *
  *   The modes affect the allocation and accessibility of CIDs as follows:
  *
  *   - global - access and allocation are all system-wide
@@ -2794,6 +2800,15 @@ static int vsock_net_mode_string(const struct ctl_table *table, int write,
 	else
 		return -EINVAL;
 
+	mutex_lock(&vsock_register_mutex);
+	if (mode == VSOCK_NET_MODE_LOCAL &&
+	    transport_g2h && transport_g2h->supports_local_mode &&
+	    !transport_g2h->supports_local_mode()) {
+		mutex_unlock(&vsock_register_mutex);
+		return -EOPNOTSUPP;
+	}
+	mutex_unlock(&vsock_register_mutex);
+
 	if (!vsock_net_write_mode(net, mode))
 		return -EPERM;
 
@@ -2938,6 +2953,7 @@ int vsock_core_register(const struct vsock_transport *t, int features)
 {
 	const struct vsock_transport *t_h2g, *t_g2h, *t_dgram, *t_local;
 	int err = mutex_lock_interruptible(&vsock_register_mutex);
+	struct net *net;
 
 	if (err)
 		return err;
@@ -2960,6 +2976,22 @@ int vsock_core_register(const struct vsock_transport *t, int features)
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
index d365a4b371d0..af4fbce0baab 100644
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
index 7eccd6708d66..e392d3d1fd90 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -2033,6 +2033,17 @@ static u32 vmci_transport_get_local_cid(void)
 	return vmci_get_context_id();
 }
 
+static bool vmci_transport_supports_local_mode(void)
+{
+	/* Local mode is not yet compatible with vmci because there is no clear
+	 * mechanism yet for attaching a namespace to a VM, or for handling the
+	 * namespacing for when neither H2G or G2H is registered (as is the
+	 * case for MODULE_ALIAS_NETPROTO(PF_VSOCK) loading. To simplify, we
+	 * keep local mode off for now.
+	 */
+	return false;
+}
+
 static struct vsock_transport vmci_transport = {
 	.module = THIS_MODULE,
 	.init = vmci_transport_socket_init,
@@ -2062,6 +2073,7 @@ static struct vsock_transport vmci_transport = {
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


