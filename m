Return-Path: <linux-kselftest+bounces-45811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C81FC66E89
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 03:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E20EA29CF8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 02:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC112248B4;
	Tue, 18 Nov 2025 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkJ7Xr8p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D2313E04
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431232; cv=none; b=ZBuUCVyJ7AyJvCqH9vl150TO19Fc0uhoVbahij2Obw+Yk6pDZM7y2UvTd3bZXiDwMqa6hKc3yhEruksvT/SlB2gcrgoAw8gzR1zs1Hv4Xli87URy8Xqkh1UlTg1hD6TaxMngPExBxhDw5VOXYYviK/emkyCgn/bHoPAOuHOWaaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431232; c=relaxed/simple;
	bh=rxQ/1GJhCmCe2AFwaDeo7zZNAc/4zN5ruqTcN3iFTYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H1V6cXSDr2+jqPmaTRrfbB3kehYNkg8WFhUNbEE7o2J6Jdz49y6RzuzLTiW3tepWMSmPcIxwXwm2LvW4/6lKH3dvX0c5wFnAtY5MPsqqgCXiKMKCVp4RSEQ9j3ZHt/S6DlQB7yNVq2aZjHBxK/TiMGmuOGTID5S3RifJYsubdYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkJ7Xr8p; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso4218613a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 18:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431230; x=1764036030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqihfKJRHAENT+vtDuZaHGz1v+/r/9FmzH4WlFsBg7Q=;
        b=hkJ7Xr8pMisnltHjKWCskpOMVJmScPJV1TvUEwICznzrroDM/oe/A1hOdjekvuw/Ep
         v9d0pSVePS6dspYrvpF7rkxSr42Wb5pR5T3R79FzXzzi+0V4QDdEJ6yt7HO8W5oFFTr3
         4bSJH5a/AmB/6uwdkSZhe8Dqb15C8V/VZ0MbwRbfeBFEp7L4e3EROtLOuE1D4yrHUIgL
         dxlXcYU8OeTLNRROAMoNm2CkOg94Qp+UiF9dBzPIhXLgedBG4IQtEGubG0mAfwKkkAOK
         HoSebBbMhIgTzjpl9+bKoVGJ5o1KmyxzPTDCh57ndVxfMIIsftBpTMaTzkIz0Ww6Oj6u
         DWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431230; x=1764036030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NqihfKJRHAENT+vtDuZaHGz1v+/r/9FmzH4WlFsBg7Q=;
        b=h9wsUk/dtyT+fPD4lLkKozBgUA0nKBVbnjhg1xR8OtLZ30HyI90i43Eqa+IZK7VaZ2
         QbbLKo9XhIVNMdA2fsxFMOvBL3Wka78MB+0pMeChyDlbe2aHrI/BwIv5wbQycq+zRRgf
         ystbdpH3uqQZnKh+O2BtPtkmsDs1YhFDzQ//+LNOAwBiRJXlieN6QoCohxJfNegksM8N
         eYq6t8Y29QacvxQbBdnainJVXKThB1hkH7XRlp1N4TyRR+xu+mf4Ky420NaO3Kdxfj5J
         8QraCCY5C93Dls6ku/5E1RqL+ZZGRRJo8cUKQ5KHG/VfIKtKUOnbQ0jhtg9cA37bqTZw
         gpuA==
X-Forwarded-Encrypted: i=1; AJvYcCUpL9puvxl62xd5qLO6Y4iuLhRIqXLk11iWKvhgj4EtDo000dsm6/Jaa8L6jmdZ1JyQTQP+UB9eF5Bp1z04VFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP79ya5jj98jsmULZSKr1FmfhPmRdM7jNZo+qOf2dcob255GuZ
	7lSSlWFlrpwdyHDozKoEQSlZBtc5lslBHuwmb5J9H/cpbO0L+0vyZTm0
X-Gm-Gg: ASbGncuhFfNP/hwDJqrpTF1Zpt0wDfEmlDhi7Ged+acp1saEzCFtpWWLLN46AEPmdZZ
	fpNbFpsDezca+OabIKWLNGA2W0j0nj4iSa6UC6H84rebwMCZZXFHfS6nfN7yz24zA2CYpJwuylp
	C2+mTh8UWOQ6Nsy72EbOvUKgQSdwzKRx+UPQIjxulyT5Khu6trjxA/TjhtXmQ1nHlz5zYdDf3mD
	IJbaCXu/qEo10UT+cvgV9+JIPSt08duOz3wWU45wOpCw6wZ6LvR9Q/GPgBE42HjFKtzCvrvCr92
	sCuzP1QumDICsuzOq5c/E4ahMlDGqk1UINWgXBhXa1b9uRaKX5rrzWPXYyQ+whPq8qoWhvdF5mD
	hgBOkC37Uxavz+7cVXWryrP5qx+L5D0kyYyM5BwYj0/WcyrwfD8bAVs+thYGxOsAtrHYYT7aN0/
	C1rBQYLcvFbbgXqGOKz79S6fXu3EuQwQ==
X-Google-Smtp-Source: AGHT+IEbZw6qRSUc9CAVQ8dKc8ULj7Y+j+jbzDDMbNJuCyLL/Q1LuCfTO0BI6N2AF9S1ioRpA4NGpw==
X-Received: by 2002:a17:90b:3b45:b0:33e:1acc:1799 with SMTP id 98e67ed59e1d1-343f9edf47dmr16628668a91.14.1763431229421;
        Mon, 17 Nov 2025 18:00:29 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456513f0eesm11147308a91.7.2025.11.17.18.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:00:29 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 17 Nov 2025 18:00:24 -0800
Subject: [PATCH net-next v10 01/11] vsock: a per-net vsock NS mode state
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-vsock-vmtest-v10-1-df08f165bf3e@meta.com>
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

Add the per-net vsock NS mode state. This only adds the structure for
holding the mode and some of the functions for setting/getting and
checking the mode, but does not integrate the functionality yet.

A "net_mode" field is added to vsock_sock to store the mode of the
namespace when the vsock_sock was created. In order to evaluate
namespace mode rules we need to know both a) which namespace the
endpoints are in, and b) what mode that namespace had when the endpoints
were created. This allows us to handle the changing of modes from global
to local *after* a socket has been created by remembering that the mode
was global when the socket was created. If we were to use the current
net's mode instead, then the lookup would fail and the socket would
break.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
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
 include/net/af_vsock.h      | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/net/net_namespace.h |  4 ++++
 include/net/netns/vsock.h   | 17 +++++++++++++++++
 4 files changed, 66 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37f4278db851..e1e0e2092d0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27101,6 +27101,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
 F:	include/linux/virtio_vsock.h
+F:	include/net/netns/vsock.h
 F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d40e978126e3..9b5bdd083b6f 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
+#include <net/netns/vsock.h>
 #include <net/sock.h>
 #include <uapi/linux/vm_sockets.h>
 
@@ -65,6 +66,7 @@ struct vsock_sock {
 	u32 peer_shutdown;
 	bool sent_request;
 	bool ignore_connecting_rst;
+	enum vsock_net_mode net_mode;
 
 	/* Protected by lock_sock(sk) */
 	u64 buffer_size;
@@ -256,4 +258,46 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
 {
 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
 }
+
+static inline enum vsock_net_mode vsock_net_mode(struct net *net)
+{
+	return READ_ONCE(net->vsock.mode);
+}
+
+static inline bool vsock_net_write_mode(struct net *net,
+					enum vsock_net_mode mode)
+{
+	if (xchg(&net->vsock.mode_locked, 1))
+		return false;
+
+	WRITE_ONCE(net->vsock.mode, mode);
+	return true;
+}
+
+/* Return true if two namespaces and modes pass the mode rules. Otherwise,
+ * return false.
+ *
+ * - ns0 and ns1 are the namespaces being checked.
+ * - mode0 and mode1 are the vsock namespace modes of ns0 and ns1 at the time
+ *   the vsock objects were created.
+ *
+ * Read more about modes in the comment header of net/vmw_vsock/af_vsock.c.
+ */
+static inline bool vsock_net_check_mode(struct net *ns0,
+					enum vsock_net_mode mode0,
+					struct net *ns1,
+					enum vsock_net_mode mode1)
+{
+	/* Any vsocks within the same network namespace are always reachable,
+	 * regardless of the mode.
+	 */
+	if (net_eq(ns0, ns1))
+		return true;
+
+	/*
+	 * If the network namespaces differ, vsocks are only reachable if both
+	 * were created in VSOCK_NET_MODE_GLOBAL mode.
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
index 000000000000..c1a5e805949d
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
+	int mode_locked;
+};
+#endif /* __NET_NET_NAMESPACE_VSOCK_H */

-- 
2.47.3


