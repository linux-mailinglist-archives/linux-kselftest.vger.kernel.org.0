Return-Path: <linux-kselftest+bounces-27708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4660A47428
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 05:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597813AE505
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 04:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA1B2222A3;
	Thu, 27 Feb 2025 04:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CN45aJTM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9396B2080C5
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 04:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629545; cv=none; b=rdqDINQ7FrCje4D0Y8mQYHo9pmh94VDxG/aFWS2d3Q3zIrXGzd65MxTtT0x7fKpZpV6qS/x9MCEpRl55E7kBj31klKofqHhIDAicISkvce2vRfKz8XM5ut8EjduQNVC4ayb+UVzBdv/UXH2RiDoBHG7bqEl3rPhF0VVReFmTuP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629545; c=relaxed/simple;
	bh=6zZjhg68/iYJBRB4m3XZfkrP8wJihUvJUf0RzhlSaaI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SL8RdFzTBrIxNUlNZE9DPrGqkYeYMBlyn6YI2g7mggTNGL6IiGq65nxoVlIJBGIfJuI18tcnbl+tnSYm0rcqOa0hrVh96HowO19j6UAifg63vX4qBeQJ8MAxMXMWWQZztPymSYftfH2nzEEh5MuEEszj2nwj8OTh8e/RHsR2Rxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CN45aJTM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220d9d98ea6so15563625ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 20:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740629540; x=1741234340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zbf1n5nMrGgkEm8OKJmH1KH6YQxHSldVAhZv8jgHSII=;
        b=CN45aJTM+YIjTM7yZZ2vCAUBpeFc9QIBvxmHGnOffTn7BPtL7bfHsYRvSxOaMXKFBG
         w208vf8WQ9lPM4iARqt3APMHfVo1d04PthFJ6wO5Ko9zEKQU39KsRnNm/HDR7eYFXpa5
         NmwgCY8znCDRjG/ah6DaW3QZ0Xm66aWJss95RG5R6oK2nN57MLCN1q1CheVzUJXxAUTu
         4YtbS7nfMf6rQ0Pyh3n8n8ogCML+xtnCmJsIrMu4LDTbVC+KOR9ui6LVSvANl7cFW0/1
         lkgdgPA+zodau8LWc/X1Z4nwautgrvUCEdb9sQ2w+6FxCM8rqYqSADmXp4GEryyl7wGP
         peQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740629540; x=1741234340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zbf1n5nMrGgkEm8OKJmH1KH6YQxHSldVAhZv8jgHSII=;
        b=wREm+iIUb/KLnLNmRyUjE6BynsL4wiKjrYg/PNtHYdS/yDF03zMWMo56pb1cSihVfp
         7eSuMdmsCkrSFu3lSm2ZNFgo9snupWjqIu52nMB3SEoAzuFYWg1QHR0BVAK3LwqrG4dz
         uM9Zu8mamkDYTOinQVf593Q1umwYN5rCzaOVjVgmnvT2ekadDIg+KAPK4rRs4BkBo0LQ
         +J14NuveXP+J84OWhhb61QbsDaG/Qbww/Rae65uHjnG17+NEFBS2ws7XNubjW4HVuWCb
         A3KGf//7PJtlufePE7oLqpJpILtKXF6cCgfBie3qn/PIof3uY42Md8h2xbKmd9v9FOwc
         oR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdBXgIgHzkkm2F7Cz8BeAtO+PIU3QaKd/zNrNr5L67ibyt6/TLDjLXxBJrXI83wCnurtKJb5xk1Ur3zC7k8ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9tRqCW8rCt1vO0atPjK0jTP2dWBCJMPvmR1y0Be9o2aFidlmN
	rXkvX3lMok4FH10lYXm3tf5B0B9+4vQ9H2PvMLKjYDfQwclG5a6CbPUkHFR48IOUS303bgCgjFa
	lOMqGov4azibuef0DoRFGOQ==
X-Google-Smtp-Source: AGHT+IGDKy2giXtpgwmEdeX2eF65rox8vmx9oiPEONB7TDDjKbzKlZJQAqoYxBHtqGROwp8XHqTNhyRilESKagNMkg==
X-Received: from pfbfb34.prod.google.com ([2002:a05:6a00:2da2:b0:730:7485:6b59])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e05:b0:724:59e0:5d22 with SMTP id d2e1a72fcca58-734791b7657mr16917355b3a.20.1740629540276;
 Wed, 26 Feb 2025 20:12:20 -0800 (PST)
Date: Thu, 27 Feb 2025 04:12:06 +0000
In-Reply-To: <20250227041209.2031104-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227041209.2031104-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227041209.2031104-6-almasrymina@google.com>
Subject: [PATCH net-next v6 5/8] net: enable driver support for netmem TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Drivers need to make sure not to pass netmem dma-addrs to the
dma-mapping API in order to support netmem TX.

Add helpers and netmem_dma_*() helpers that enables special handling of
netmem dma-addrs that drivers can use.

Document in netmem.rst what drivers need to do to support netmem TX.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v5:
- Fix netmet TX documentation (Stan).

v4:
- New patch
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 Documentation/networking/netdev-features.rst  |  5 ++++
 Documentation/networking/netmem.rst           | 23 +++++++++++++++++--
 include/linux/netdevice.h                     |  2 ++
 include/net/netmem.h                          | 20 ++++++++++++++++
 5 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 15e31ece675f..e3043b033647 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -10,6 +10,7 @@ Type                                Name                        fastpath_tx_acce
 =================================== =========================== =================== =================== ===================================================================================
 unsigned_long:32                    priv_flags                  read_mostly                             __dev_queue_xmit(tx)
 unsigned_long:1                     lltx                        read_mostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(tx)
+unsigned long:1			    netmem_tx:1;	        read_mostly
 char                                name[16]
 struct netdev_name_node*            name_node
 struct dev_ifalias*                 ifalias
diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
index 5014f7cc1398..02bd7536fc0c 100644
--- a/Documentation/networking/netdev-features.rst
+++ b/Documentation/networking/netdev-features.rst
@@ -188,3 +188,8 @@ Redundancy) frames from one port to another in hardware.
 This should be set for devices which duplicate outgoing HSR (High-availability
 Seamless Redundancy) or PRP (Parallel Redundancy Protocol) tags automatically
 frames in hardware.
+
+* netmem-tx
+
+This should be set for devices which support netmem TX. See
+Documentation/networking/netmem.rst
diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
index 7de21ddb5412..b63aded46337 100644
--- a/Documentation/networking/netmem.rst
+++ b/Documentation/networking/netmem.rst
@@ -19,8 +19,8 @@ Benefits of Netmem :
 * Simplified Development: Drivers interact with a consistent API,
   regardless of the underlying memory implementation.
 
-Driver Requirements
-===================
+Driver RX Requirements
+======================
 
 1. The driver must support page_pool.
 
@@ -77,3 +77,22 @@ Driver Requirements
    that purpose, but be mindful that some netmem types might have longer
    circulation times, such as when userspace holds a reference in zerocopy
    scenarios.
+
+Driver TX Requirements
+======================
+
+1. The Driver must not pass the netmem dma_addr to any of the dma-mapping APIs
+   directly. This is because netmem dma_addrs may come from a source like
+   dma-buf that is not compatible with the dma-mapping APIs.
+
+   Helpers like netmem_dma_unmap_page_attrs() & netmem_dma_unmap_addr_set()
+   should be used in lieu of dma_unmap_page[_attrs](), dma_unmap_addr_set().
+   The netmem variants will handle netmem dma_addrs correctly regardless of the
+   source, delegating to the dma-mapping APIs when appropriate.
+
+   Not all dma-mapping APIs have netmem equivalents at the moment. If your
+   driver relies on a missing netmem API, feel free to add and propose to
+   netdev@, or reach out to the maintainers and/or almasrymina@google.com for
+   help adding the netmem API.
+
+2. Driver should declare support by setting `netdev->netmem_tx = true`
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9a387d456592..22d9621633a0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1753,6 +1753,7 @@ enum netdev_reg_state {
  *	@lltx:		device supports lockless Tx. Deprecated for real HW
  *			drivers. Mainly used by logical interfaces, such as
  *			bonding and tunnels
+ *	@netmem_tx:	device support netmem_tx.
  *
  *	@name:	This is the first field of the "visible" part of this structure
  *		(i.e. as seen by users in the "Space.c" file).  It is the name
@@ -2061,6 +2062,7 @@ struct net_device {
 	struct_group(priv_flags_fast,
 		unsigned long		priv_flags:32;
 		unsigned long		lltx:1;
+		unsigned long		netmem_tx:1;
 	);
 	const struct net_device_ops *netdev_ops;
 	const struct header_ops *header_ops;
diff --git a/include/net/netmem.h b/include/net/netmem.h
index a2148ffb203d..1fb39ad63290 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -8,6 +8,7 @@
 #ifndef _NET_NETMEM_H
 #define _NET_NETMEM_H
 
+#include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <net/net_debug.h>
 
@@ -267,4 +268,23 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
 void get_netmem(netmem_ref netmem);
 void put_netmem(netmem_ref netmem);
 
+#define netmem_dma_unmap_addr_set(NETMEM, PTR, ADDR_NAME, VAL)   \
+	do {                                                     \
+		if (!netmem_is_net_iov(NETMEM))                  \
+			dma_unmap_addr_set(PTR, ADDR_NAME, VAL); \
+		else                                             \
+			dma_unmap_addr_set(PTR, ADDR_NAME, 0);   \
+	} while (0)
+
+static inline void netmem_dma_unmap_page_attrs(struct device *dev,
+					       dma_addr_t addr, size_t size,
+					       enum dma_data_direction dir,
+					       unsigned long attrs)
+{
+	if (!addr)
+		return;
+
+	dma_unmap_page_attrs(dev, addr, size, dir, attrs);
+}
+
 #endif /* _NET_NETMEM_H */
-- 
2.48.1.658.g4767266eb4-goog


