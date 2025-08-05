Return-Path: <linux-kselftest+bounces-38329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF0B1BBE3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 23:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098703B589F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87261260565;
	Tue,  5 Aug 2025 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh81nYVt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77A6238140;
	Tue,  5 Aug 2025 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430556; cv=none; b=PAxHhhTHxhsFeBPQC457Ve42r/ocon/D69brexT6IqXHA75qdIGUqe5wyECNIrtjoz8eX/eLyYR72X+N8uAGblvPJAevC+xztZsfVjJ6AKdMQG1X5g1nhmYhwr4tXluiFYhYDuNw7/GqxuV7l3eL2/ShTzSiiDyas22Lw42fFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430556; c=relaxed/simple;
	bh=fx/j12c7X1avNwUI/3xCv2xqKheT5FfFmdObHtz3nVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qu8g7bGTW9A3EMw12UhjUavCcLt+3nH+3XK+Ht8oQkJZiv9lF7dlvOfsQnDkF8w+6C5mCJTW343iCPBEg6e5IHJ9Ghl+5Up1eGPeRLQZITSZZiK0DOeWWdSbqkbOv7HQz/oU6eUpmZ4XFa4S7TB9F5gzujDNj1wEcplETIQP/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh81nYVt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76be8e4b59aso3180976b3a.1;
        Tue, 05 Aug 2025 14:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430554; x=1755035354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gx5ceqh/7qvQN6L4QFmi/M9LWu27g5Sp9j8Lv00Y7aY=;
        b=Lh81nYVtt0EEuZaabk0hiFQBONjwGzNczDucDM4W44ERIGmC3LR6jnnrBOZ0wFy7/B
         Ep5xVKrsJ8XKrkU8e2fBUiGQWUdVEB1LANWsgozBX6uApQTGZMWU95Bem/vFIoIt2ONv
         2UK+mUznDe0h2Ory/pDpSbFkB2cVcnwTgzpcjt4y4sgILa9mWVKQUNIfB2dgrupkAig7
         I2tiqVoReuxID3sov8G+mCVv95AtCgEw/KNS2QL24SOaXml5d/t7azpOjV/I3+ztLXmx
         VdII8Cee3ttnI+Zled6IXS6t9m/wESu70Dv0gC4NBTebmokVvG+GcMJObmeDVFXL+to8
         /6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430554; x=1755035354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gx5ceqh/7qvQN6L4QFmi/M9LWu27g5Sp9j8Lv00Y7aY=;
        b=g6a0ZUmMrgqIqoDUXN6n2FmtzD58sehnAeUe7686F6ZYuma2w95xwnmIDdDkZPcDh7
         0CkpBQ1EF/TgX2QnQEZtW7lvR9qdqPTjXYyaxKCUFlimLOpnz37C1BOE1J4OHz7OJn2a
         qambUAloNCFfJX5ILGhkgQbvU+A/I7yul6c0BXKMDFFFSYqguKwupUb5zWRBV58ynPGG
         mwiQSs9+GQCAsYY2rgvUSHTGuu7cq8GyzFUJjjQHf8PaP1RD7avNgayCoonB3uF3er7i
         G2o/52lr2qCkvDeygJaw6dHd6L9NsTbTwf18zHSNLvoXG7cJhtTcxY3RIikGDgwHc/c7
         keNA==
X-Forwarded-Encrypted: i=1; AJvYcCUtKQynRu4REuNlsnnWXzYHV89CwaYNQE672/LCgTsYNa+IXMnclXpVmX8ih+wGqUZxRcc/J+tMXqwvEcrPsidv@vger.kernel.org, AJvYcCUuE8q7vC5T8o2W0qvuTpcqkQ2hnbuFUBGzMDnnjHEmmwmq2ukAQtajnsPxsrxCMhXkrpw=@vger.kernel.org, AJvYcCVkZ3dZsoeLC/9AiEQOi2NQkgznqU+k7iKwqwtZ+hgNp04efUivDHw/AKQgT1DCQ39zFAWb1hkQgWUuYpOD@vger.kernel.org, AJvYcCWwLnc34GKDueOsXcggNNhqMI+I8qtOdNQuP2s9MyztO7AKz44IfCqMdgeYxD2ORXHkjpJGPghL@vger.kernel.org, AJvYcCXVjv/wlKI6IuPacPhjQhIzYaM4PEpGhFA8aza0RNAKVDxu/c7XXk4SpetqtsaBi3xqiLoJhMwNnIGSLhGh@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvr7zz6H0VnYhQN+ht8Uze0rZfcFHg9jETkhI9mLiwLfLGNbNw
	6PcytW5woL8INd2/wu3aQPfQ+9PRUSrXoMIo0qPOZTzZ/yA+G78qdtKi
X-Gm-Gg: ASbGnct0Ij6eu2OfJRl8lb5eyL2uamH+pJJcrFflD9RBbr2pjwBe6EncuSkJzuaE0cU
	SDmo50bad9KuPrP1v32T1UXNr6bxf1iT/J20awNXsNJ4D3bvyKgu5hRZ8KlKieDU02/YblmAR1G
	snsERdsVVWhynQxK0HK9SvrXvXpErUgsFYFAtvL4dec/bVSht2q15HLAzbSLGYckZf9TbeSZyvD
	M4PKygnrneqrjSbPgQ720Tuy7lp/jGyJdmg3aR0LMeWMsGVUPgS5R1ZSH2zz3CAPkMyyevCWHf1
	cmbm9uYT7n3E0wn+VESq6qpp7bXE2y4yB3aLp4qNFeJubWMTi+kI9TtDhGf0nfr8h+EhY+ZsE9Q
	GiFNbIsfI+9jh+45N6/8=
X-Google-Smtp-Source: AGHT+IEM+7ah9OnFP8VaGRZ5rhV8vXufNMLrUwoiWelHwq+LhOlK9tECYmajZTfLn97xMBqRGxMpVQ==
X-Received: by 2002:a17:902:d4c9:b0:23f:dc56:66e2 with SMTP id d9443c01a7336-242a0b60289mr2909435ad.38.1754430554146;
        Tue, 05 Aug 2025 14:49:14 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef83f3sm141034935ad.28.2025.08.05.14.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:13 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:09 -0700
Subject: [PATCH RFC net-next v4 01/12] vsock: a per-net vsock NS mode state
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-1-059ec51ab111@meta.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
In-Reply-To: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the per-net vsock NS mode state. This only adds the structure for
holding the mode necessary and some of the definitions, but does not
integrate the functionality yet.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 MAINTAINERS                 |  1 +
 include/net/af_vsock.h      | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/net/net_namespace.h |  4 ++++
 include/net/netns/vsock.h   | 18 ++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1bc1698bc5ae..76905fc1c1d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26208,6 +26208,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
 F:	include/linux/virtio_vsock.h
+F:	include/net/netns/vsock.h
 F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d40e978126e3..d34bf7dbc69a 100644
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
+static inline u8 vsock_net_mode(struct net *net)
+{
+	u8 ret;
+
+	spin_lock_bh(&net->vsock.lock);
+	ret = net->vsock.ns_mode;
+	spin_unlock_bh(&net->vsock.lock);
+	return ret;
+}
+
+static inline void vsock_net_set_mode(struct net *net, u8 mode)
+{
+	spin_lock_bh(&net->vsock.lock);
+	net->vsock.ns_mode = mode;
+	net->vsock.written = true;
+	spin_unlock_bh(&net->vsock.lock);
+}
+
+/* Return true if mode has already been written once. Otherwise, return false. */
+static inline bool vsock_net_mode_can_set(struct net *net)
+{
+	bool ret;
+
+	spin_lock_bh(&net->vsock.lock);
+	ret = !net->vsock.written;
+	spin_unlock_bh(&net->vsock.lock);
+
+	return ret;
+}
+
+/* Return true if vsock net mode check passes. Otherwise, return false.
+ *
+ * Read more about modes in comment header of net/vmw_vsock/af_vsock.c.
+ */
+static inline bool vsock_net_check_mode(struct net *n1, struct net *n2)
+{
+	return net_eq(n1, n2) ||
+	       (vsock_net_mode(n1) == VSOCK_NET_MODE_GLOBAL &&
+		vsock_net_mode(n2) == VSOCK_NET_MODE_GLOBAL);
+}
 #endif /* __AF_VSOCK_H__ */
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 025a7574b275..005c0da4fb62 100644
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
index 000000000000..0bad4652815c
--- /dev/null
+++ b/include/net/netns/vsock.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_NET_NAMESPACE_VSOCK_H
+#define __NET_NET_NAMESPACE_VSOCK_H
+
+#include <linux/types.h>
+
+#define VSOCK_NET_MODE_GLOBAL	1
+#define VSOCK_NET_MODE_LOCAL	(1 << 1)
+
+struct netns_vsock {
+	struct ctl_table_header *vsock_hdr;
+	spinlock_t lock;
+
+	/* protected by lock */
+	u8 ns_mode;
+	bool written;
+};
+#endif /* __NET_NET_NAMESPACE_VSOCK_H */

-- 
2.47.3


