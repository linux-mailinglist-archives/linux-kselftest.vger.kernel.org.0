Return-Path: <linux-kselftest+bounces-27038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D707A3CF25
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 03:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B254E7A7394
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 02:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3A41E2858;
	Thu, 20 Feb 2025 02:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MF3Z2Vbx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3A1DF749
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 02:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017374; cv=none; b=fuf6BDdR7+iD83MXGhIS1j93wvmHvj0e/MEpErinEEM4dzuo+8vc7qukexuW456CPiAWOUsak+IfoVkqYn7SxW3nrK1kr9RMNU4UZT+Z6a1EhgcszUAr9FYoUlnxn/5kH5yW0Q6CYb/RlXPxNpci8f5VMViddkWyUBQYPUn1Dhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017374; c=relaxed/simple;
	bh=yrZLNnExJxovnUdP+p9+TWBfjC0FJjXK8+7R08yWg8A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bfXqIz+nioPUBbr7WEkUV8od5o0peviOyIpdHNNst0zUajOo1hLGFPwnQPLFQ/b2tF52VP7KD0ILo1hUV/65AnKpdi/M2yw3o/YaftsaXgmnsxzpBs5bJji3zyYyUVB/BdtxAtF6nOgTh4Kqkqh3+NnkXTV6FdpWtWWxLNKfwPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MF3Z2Vbx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220ff7d7b67so8153635ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 18:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740017371; x=1740622171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqtBs71AQ1fXytwcggDtxu27G/HnTgPlNN4begvh5Pw=;
        b=MF3Z2VbxSO2nxZfrhNLHe8uLD7Kj+2mvwd5GhbxRG4acgLPf73fcpOhL4GMxhr84sS
         eGtyHprEQolJDYUG/Z3dYwLX4Iiyp3mk+DCe2eC5H+eEEr4wCdH8jcroNfvr1rvw/8oq
         5tO8sbA7FtBT0ycd771ujTp2ytbCHtS5FieeTz6x6e3ZjNQVE+LPO1aDUMaorLk1edlb
         YmRC3ov1O3ZqRcxu3ndxguw+7P4Tz1b0WwpNG+H0OuSNnvn8g0HGYvgPzZYy4nm1rTnH
         e6kxdIar8V1wKeSlATSCclddWfdDYpybZSPk08yelQPk22XzOGMtAcZ61ykdCDVQCN2m
         6h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740017371; x=1740622171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqtBs71AQ1fXytwcggDtxu27G/HnTgPlNN4begvh5Pw=;
        b=kw1OH57cwDUYTJc5NDYbx8wTL2sFv+LVQUqT4C5An+dKwSj+xGKxg3cNRtrAXP1eAF
         34SqWpd7pkWU47qMm5dRa56xZ0LAFcOqDGuXvO0aG/jyBgybxZ0T+I1Vg84efN22GUv6
         hqaIiv8KixE+FslbW9kGzIDrq1t7t88nz0ZnJ/34Eycuzeem2G8JlcJZiXLHbhUN99BY
         gmXLUjvXpu1E7k763dmFil7cpiN7/OxVZ5LBftoesDS7xrvxJ4gdvJi3cc32XdYpvJQ7
         7hnY/khb1mOmxQppbtCkfgzzHN5CArrCe+Jv85sVFsq6vgM4k0hpBONLrIBkoHLUZ89Q
         iqlw==
X-Forwarded-Encrypted: i=1; AJvYcCX2LE+eHut+EcPv1z+F4zEzJqo/rFrD7gl9RZ5TXF6I0DLuLAqtQULptfMiYVIdLtW9l3VMt4tXG6v5xjd3esQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoxyUwkM4Q5vhWirA7oDxgNRYIGti8ntqPJIALaYQxQXkLoO1P
	JUcyyevbp2tcbSB4A4klCTjNupzAfFHihZe1NaJj+rFEaJxNgjr+OMA+eLmFWm+XaiLT4fkgyQP
	8qUzSF/J7bnJ86szjCcn1IQ==
X-Google-Smtp-Source: AGHT+IFn1g88SI+wrdiAJ0YpCgRsTA/V0ytuOY7Zv6OeUzLOT3etpr7SPdmkn/51N/sBBJUmhnJLyO9fltZLHVilIg==
X-Received: from pfblc1.prod.google.com ([2002:a05:6a00:4f41:b0:731:43c2:88e3])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:62c1:b0:1ee:a914:1d64 with SMTP id adf61e73a8af0-1eee5d694aamr1202693637.28.1740017370945;
 Wed, 19 Feb 2025 18:09:30 -0800 (PST)
Date: Thu, 20 Feb 2025 02:09:11 +0000
In-Reply-To: <20250220020914.895431-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220020914.895431-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220020914.895431-7-almasrymina@google.com>
Subject: [PATCH net-next v4 6/9] net: enable driver support for netmem TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
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

---

v4:
- New patch
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 Documentation/networking/netdev-features.rst  |  5 +++++
 Documentation/networking/netmem.rst           | 14 +++++++++++--
 include/linux/netdevice.h                     |  2 ++
 include/net/netmem.h                          | 20 +++++++++++++++++++
 5 files changed, 40 insertions(+), 2 deletions(-)

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
index 7de21ddb5412..43054d44c407 100644
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
 
@@ -77,3 +77,13 @@ Driver Requirements
    that purpose, but be mindful that some netmem types might have longer
    circulation times, such as when userspace holds a reference in zerocopy
    scenarios.
+
+Driver TX Requirements
+======================
+
+1. Driver should use netmem_dma_unmap_page_attrs() in lieu of
+   dma_unmap_page[_attrs](), and netmem_dma_unmap_addr_set() in lieu of
+   dma_unmap_addr_set(). The netmem variants will handle netmems that should
+   not be dma-unmapped by the driver, such as dma-buf netmems.
+
+2. Driver should declare support by setting `netdev->netmem_tx = true`
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index fccc03cd2164..d8cfd5d69ddf 100644
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
2.48.1.601.g30ceb7b040-goog


