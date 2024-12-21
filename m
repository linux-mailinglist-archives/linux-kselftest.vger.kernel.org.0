Return-Path: <linux-kselftest+bounces-23708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47FA9F9D8B
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 01:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C8F16BF0E
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 00:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7EA25776;
	Sat, 21 Dec 2024 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMmmx2vv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E9E83CDA
	for <linux-kselftest@vger.kernel.org>; Sat, 21 Dec 2024 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734742303; cv=none; b=LqgWnx6EI9mrLcJGOBgy53knkFwg8/TlLqRYkVmPAcQusYMULfR6H8HzIsMEpZqE9WeUG3zT9XAvBC9ukTyW23WMehtTVhIU3n7mnIofyFH/vqTF2t+5hcLamq/0LKS/XbBlVU9yvkzhyx0Ksw4G+9cHheZ8MxrrFUSqeY84omg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734742303; c=relaxed/simple;
	bh=QHTemyqKq7eQ6aluLDUFi/rI+VpPUt8hVCo9T/ySwTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ue4L8Zsc9Or/ZYTDwhNPEUV27Be7efBojzyKCgelL6w8A82HfdqiAPI6uIYNEZdz6bf/ZWeYoC4Ou0Z5u+LpbkNc3hhz1ps0UtsRTkwgf/InJJZmcCxjNh5HwvYfxvIci6WGTo4ZVgNKXjY0DGX5dQs5ZgEt5m5HwapMBORNhRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EMmmx2vv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f2a9743093so2201921a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 16:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734742300; x=1735347100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJ6NozhFSUXmkJr/9AfmzkA62BmshCZz/WJgAAj7Dl0=;
        b=EMmmx2vvjYQvDwSF0cF57JoZ34xf0ZL5Hew7JTRb8YSyMb076VTSWNiEClF45stpZR
         S1naaK5n7CaOmTF/h9rw9trRHV2kRb+sIK6ae7PL5ibQpXOpUijNB+IilmP9nLz5tvZw
         QcUpqptZ/Bl5osdIZCff1txm7DDc3hVzZr7Wzq6lGqhCebxrA2BCnqMAxPKVZxw+RpTC
         7nNVnpXhF/yMx6pWVE/tvZCGsBdkkCTsGdItXs4hWky+jmgKKNa7emHugbTPt4XDYC0P
         XmdciYwgeoM5NonzTeVZxiTNqC+ueg7vYwgR1RZDzLzcm9tmkX2eDd4LINq2YJw+NYeA
         Nmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734742300; x=1735347100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJ6NozhFSUXmkJr/9AfmzkA62BmshCZz/WJgAAj7Dl0=;
        b=UG+UIjxTkxrCj/Mf1gH5wn8oiTvnok96aSl/iW++JlHyMCbeunUTl+gi36f4FiZ9P1
         lZQTt+vmAgaKIbWs9JSMm4R6Tgo2eHUxzqYc2zGCETiYaJlDs/bdfHBZXoDzRvgPIqt+
         tb8nRO8TA8eb2vcG/NTqwClo0FHn3m9Gf980xR9f+THQQqT3NOXJ5hIxQFeE3YekrnpK
         WV8XXVb8Dngn0n1VxwuhQ3+wM5jH1jLvul3Pmw8OwvN72BXwcUmN74f/Jr2L1BqQUmGP
         g/ZQfW9O6woZGJbAccWYfvHBJUIJMVk84OeeJRO4wCFZcumUO9WsGpF7f/Iy/G6TBAlU
         j5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM90WvAeK6izColIsdo2ErQOhJE4zduxVh040nmZXDTJQ8aT0v2Wc2Wn2LLC/Sc7WGdD1OSbKUk1h8t8qyeRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBq4KZKkJWxmlNErnPyzmB+uUZTLkJIcTFVeuVVqzKNJh28akE
	MTfZyiAkkEDVFb7lOi3k4G8awO/mhg20ciz9KzPahqPU9n7wSIDGhAEgReUy+koLNVtFFqHyy0q
	5Ba7QoFWSehHbPokM64OHXA==
X-Google-Smtp-Source: AGHT+IECenOfrqMdD4y/BkZI8Rt/o8P2W8JHtAIr7xge1JhM22ZDFK4i9b8sLtz0qSwXRtkNrZAnVUepMo8t46ZczQ==
X-Received: from pjbsm15.prod.google.com ([2002:a17:90b:2e4f:b0:2ea:9d23:79a0])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:54cb:b0:2ee:96a5:721e with SMTP id 98e67ed59e1d1-2f452e1cacamr9375996a91.12.1734742300328;
 Fri, 20 Dec 2024 16:51:40 -0800 (PST)
Date: Sat, 21 Dec 2024 00:42:35 +0000
In-Reply-To: <20241221004236.2629280-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241221004236.2629280-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241221004236.2629280-5-almasrymina@google.com>
Subject: [PATCH RFC net-next v1 4/5] net: devmem TCP tx netlink api
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"

From: Stanislav Fomichev <sdf@fomichev.me>

Add bind-tx netlink call to attach dmabuf for TX; queue is not
required, only ifindex and dmabuf fd for attachment.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 Documentation/netlink/specs/netdev.yaml | 12 ++++++++++++
 include/uapi/linux/netdev.h             |  1 +
 net/core/netdev-genl-gen.c              | 13 +++++++++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  |  6 ++++++
 tools/include/uapi/linux/netdev.h       |  1 +
 6 files changed, 34 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index cbb544bd6c84..93f4333e7bc6 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -711,6 +711,18 @@ operations:
             - defer-hard-irqs
             - gro-flush-timeout
             - irq-suspend-timeout
+    -
+      name: bind-tx
+      doc: Bind dmabuf to netdev for TX
+      attribute-set: dmabuf
+      do:
+        request:
+          attributes:
+            - ifindex
+            - fd
+        reply:
+          attributes:
+            - id
 
 kernel-family:
   headers: [ "linux/list.h"]
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index e4be227d3ad6..04364ef5edbe 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -203,6 +203,7 @@ enum {
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
+	NETDEV_CMD_BIND_TX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index a89cbd8d87c3..581b6b9935a5 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -99,6 +99,12 @@ static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_IRQ_SUSPE
 	[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] = { .type = NLA_UINT, },
 };
 
+/* NETDEV_CMD_BIND_TX - do */
+static const struct nla_policy netdev_bind_tx_nl_policy[NETDEV_A_DMABUF_FD + 1] = {
+	[NETDEV_A_DMABUF_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_DMABUF_FD] = { .type = NLA_U32, },
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -190,6 +196,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NETDEV_CMD_BIND_TX,
+		.doit		= netdev_nl_bind_tx_doit,
+		.policy		= netdev_bind_tx_nl_policy,
+		.maxattr	= NETDEV_A_DMABUF_FD,
+		.flags		= GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index e09dd7539ff2..c1fed66e92b9 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -34,6 +34,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 				struct netlink_callback *cb);
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info);
+int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 2d3ae0cd3ad2..00d3d5851487 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -907,6 +907,12 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/* stub */
+int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return 0;
+}
+
 void netdev_nl_sock_priv_init(struct list_head *priv)
 {
 	INIT_LIST_HEAD(priv);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index e4be227d3ad6..04364ef5edbe 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -203,6 +203,7 @@ enum {
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
+	NETDEV_CMD_BIND_TX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.47.1.613.gc27f4b7a9f-goog


