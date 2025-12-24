Return-Path: <linux-kselftest+bounces-47935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BF0CDAE89
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 01:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF607301BEBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 00:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DCC1F3FED;
	Wed, 24 Dec 2025 00:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWh3lOE+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF48194AD7
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Dec 2025 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536138; cv=none; b=fMus0XZuBLHWk4uIVPxw0gkbjFM+XR+IxvcdrlB6tOc4rsEAAw1fDZbfPxhXJi1/2SUxsLJ4ZlHaZCBDkYo4S4ptANANg/q3SYgX3hppauxLnf4O0Uspf9UIOk7/8zlPJKgNOLH/0T3oq9DQ3ToJC/dsdXTx5rZIVS170FiH4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536138; c=relaxed/simple;
	bh=7wDYgNx+BgqVnuE0T2X8agHCrv8JLpc6NaCVH5tP4l0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rcUVxmg1se/W5nwk8TuO4iFllrj95OgGDl3CE0op+qT8Dt2kYAbleIK/VgZ1Vybe+vBHY4yl7pat8AqkBkvixAtk5UWoqfMhWQ02m/WwVp741wgW+Uyiz93KtLIZCgl3WeW4i/86hEVRGVH/sl/aaoTKMMkqieAk5uUIMKbVLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWh3lOE+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso6237621b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 16:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536136; x=1767140936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1idDMvZTSBBVNr5LBgZDXh7c7n41TkvVwZ0J4jmyayA=;
        b=CWh3lOE+nnquhJ6m0WJ/7svTap0DUEs+RT3Knkla5u85yK06YmHw4g3Zpsl57lpQEU
         2FO3AvfWrxmqFrtbIkGYW8jAOOe6atIp8AF40SSipgsbvi73MOUf8OgUAwajLpPPylgN
         37DjAf3PBUTyWV69KYgDl2NEEjXZgfxgmLklrBk2GsUsoSml8yoEvmwhEi8R29wZX3fl
         tjsTRKJjeMQqfNOn9jGPRRQlg1zotuX/Q6YRgIKK4H2ltTK9SV0eto4cpqrEpVIW/XXd
         aQJqNFH5P9aX0FMmAAewYLTRbyZ3jQj7NtGfSYjxuKwyAnwbpLHSb/w1U+26JJRUDTAO
         R35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536136; x=1767140936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1idDMvZTSBBVNr5LBgZDXh7c7n41TkvVwZ0J4jmyayA=;
        b=WlqxC+MsNlFeFjrUTJg+1YZTnGXMLPvNop6/wQnjI6ZT1flEMt4KQ7quHduLe9ju9N
         NkxBHytIPoYCLt4ZS2OIJB172O0tjClCwIXKTIs7mt4Sm/MRL7saCYE/lvXx3EOGpAVc
         iWzNNAId0dZiFJBGqjxHb8b0jxToTLABsp6olmxWQhZl318Xin6WvSjK3ijrrBY0FBoQ
         qd7nYFkqbf1XnnM+CGRVqFa/ADABfZvW5l/uWPCGpVDYYW7uAzRaeZlbslqf9e6WqZej
         K0/Ob6hu42MtUr1YTeotObwWyH+IV0fPUecGR5yYaAXJ0mdAkIlofWa0/K8jdYzhBN53
         MvDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv1ws1SvzN3Hzlei4v8MUMr/zLcKjN7QlQVNwOzLOYD/G7tQ1cQnS2ZscTgtUWzVQVgw7rGPEy91XQdlzklNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+erMqn6p4o/ER9rsejHG+jTtI4/IJXXhFHa057hxtVl4wDjXg
	C//si7ZjRdMGkwWIwozNDnWK23vwhNm4MCUh/HgA5LWHAnYi5h6RlTE4
X-Gm-Gg: AY/fxX46/hsYlwCYxoELh2XH5OI2XsWf3X919SmDNGultp+b5RE56qsqwyx5TC3sANM
	CT3YfwgMasMAphREfob0WoVTSJbAetokBgaRXC9cyer88rHB3Kn5eDFJzc+G2VQiN3kK/htMOpH
	fDrX9qdV+7u2o+/euhGHaaiZLR1Sfhy6wKCe2fz7ARM9he5IJubHQvzwL2SPVyo/7/bX5JqLDyo
	zQDha1wF5is0Irkp8qK0aRLY0L6gdhEyJMtV3+tMetQElc9Pbj0qEhdFba6m8VQ09QkUDHsp7xy
	T2Wo8TtwqZ/YMsMij6McSx0R2GOEu0cPa9Z2P2LMP3Ne4dW/Dna8X7elE5IygtRWMQ72HhXEwRU
	TqrYjMpRg/LIhQNVItekROtKjJN1/ipBj6JKk2IrCJZBZWLA3bXuJ5Dwu6mlORLy7jkO4IB4hmq
	LLUNvxxXwrXyg5RXzfSlg=
X-Google-Smtp-Source: AGHT+IFf9PGpVgIYi53KgiXyi1OO/xQjeYSDD1E1/gFj625d4hHvxV/oBQyq3/8jVDfT3E7MmlVH9w==
X-Received: by 2002:a05:6a00:8013:b0:7e8:4471:ae61 with SMTP id d2e1a72fcca58-7ff67654e35mr13734006b3a.45.1766536136203;
        Tue, 23 Dec 2025 16:28:56 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e8947a1sm14718466b3a.67.2025.12.23.16.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:28:55 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:35 -0800
Subject: [PATCH RFC net-next v13 01/13] vsock: add per-net vsock NS mode
 state
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-1-9d6db8e7c80b@meta.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
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

Add the per-net vsock NS mode state. This only adds the structure for
holding the mode and some of the functions for setting/getting and
checking the mode, but does not integrate the functionality yet.

Future patches add the uAPI and transport-specific usage of these
structures and helpers.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v13:
- remove net_mode because net->vsock.mode becomes immutable, no need to
  save the mode when vsocks are created.
- add the new helpers for child_ns_mode to support ns_mode inheriting
  the mode from child_ns_mode.
- because ns_mode is immutable and child_ns_mode can be changed multiple
  times, remove the write-once lock.
- simplify vsock_net_check_mode() to no longer take mode arguments since
  the mode can be accessed via the net pointers without fear of the mode
  changing.
- add logic in vsock_net_check_mode() to infer VSOCK_NET_MODE_GLOBAL
  from NULL namespaces in order to allow only net pointers to be passed
  to vsock_net_check_mode(), while still allowing namespace-unaware
  transports to force global mode.

Changes in v10:
- change mode_locked to int (Stefano)

Changes in v9:
- use xchg(), WRITE_ONCE(), READ_ONCE() for mode and mode_locked (Stefano)
- clarify mode0/mode1 meaning in vsock_net_check_mode() comment
- remove spin lock in net->vsock (not used anymore)
- change mode from u8 to enum vsock_net_mode in vsock_net_write_mode()

Changes in v7:
- clarify vsock_net_check_mode() comments
- change to `orig_net_mode == VSOCK_NET_MODE_GLOBAL && orig_net_mode == vsk->orig_net_mode`
- remove extraneous explanation of `orig_net_mode`
- rename `written` to `mode_locked`
- rename `vsock_hdr` to `sysctl_hdr`
- change `orig_net_mode` to `net_mode`
- make vsock_net_check_mode() more generic by taking just net pointers
  and modes, instead of a vsock_sock ptr, for reuse by transports
  (e.g., vhost_vsock)

Changes in v6:
- add orig_net_mode to store mode at creation time which will be used to
  avoid breakage when namespace changes mode during socket/VM lifespan

Changes in v5:
- use /proc/sys/net/vsock/ns_mode instead of /proc/net/vsock_ns_mode
- change from net->vsock.ns_mode to net->vsock.mode
- change vsock_net_set_mode() to vsock_net_write_mode()
- vsock_net_write_mode() returns bool for write success to avoid
  need to use vsock_net_mode_can_set()
- remove vsock_net_mode_can_set()
---
 MAINTAINERS                 |  1 +
 include/net/af_vsock.h      | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/net/net_namespace.h |  4 ++++
 include/net/netns/vsock.h   | 17 +++++++++++++++++
 4 files changed, 64 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 454b8ed119e9..38d24e5a957c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27516,6 +27516,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
 F:	include/linux/virtio_vsock.h
+F:	include/net/netns/vsock.h
 F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d40e978126e3..6f5bc9dbefa5 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
+#include <net/netns/vsock.h>
 #include <net/sock.h>
 #include <uapi/linux/vm_sockets.h>
 
@@ -256,4 +257,45 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
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

-- 
2.47.3


