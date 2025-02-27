Return-Path: <linux-kselftest+bounces-27704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35389A4740E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 05:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57C0188BFB5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 04:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29FA1F417F;
	Thu, 27 Feb 2025 04:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VALVXiG6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEDC1EA7F3
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 04:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629537; cv=none; b=H+Vvjk+pBRYJdyDPRyyITmzXhBJl6RSsHJFe0DqC/nf3oP6AXjUV4fqe1kfZidXjDdLKH0J1TXOx778pJvKhnmkISQhUKZHwLAp7A7kSvEoJC5u6xxlpBeyqrYnA0L1d9esVKxseIv+RNuE3DRhfRTYbJdCQ4FLOczv7d5+sgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629537; c=relaxed/simple;
	bh=gN836nos7mIuoP7bbWE2UL78Iqz4QtgvY29xyyv1MUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nm7unbTCl7IY5t3zAugtP2PiRJKug30v9WDpeYnpRs0FxohlTkoij3Hcvt1WJRrGAIZ8fUWm0klrPdQA0mckOE4FdacjYY53Ym0nfsJkkbJtk5jAZfIviz8/AyE/y3nsKqb7JJX18NZyx/tY66TbTklNDYscDkUQYW3ACeEVnpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VALVXiG6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe8fdfdd94so1282097a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 20:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740629535; x=1741234335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwhkdvFGGUQ8slu9w7VIDdlvTkfuSHgYe1F/fjEXF9M=;
        b=VALVXiG6VRb8rSOr5A4KOad+jwXEVYrthstcAXpTvqeWQtNWW/KXyV7/LJM5lXXMIw
         TWBF4SJatdxJp4yzKq/4fzMYBRQECwBZbargAyBHX9iU0xahUkDx0jO4gYwpTUThcf6B
         SQQ6CjdsJJAo/jvH47drUAZw06Fa+327aVDO0SCI7fSJXqryfmqoUGuFy+sJLyCcsH4o
         Yu+7CzAT3/GPT+dBnWSRhUHcT6AiEzGQneCdHx0kPKY3hnABdjPVAtob4kx9smtOHQNl
         qpnKK8EJwWVHI93Rwf/TdTCpf0WHYb1EvAQZh/MTnFJBazVk6mA/DqGU7OCNyOhMmr72
         /3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740629535; x=1741234335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwhkdvFGGUQ8slu9w7VIDdlvTkfuSHgYe1F/fjEXF9M=;
        b=MnopT6KX360RQjM+C58OnrposyRQVcrru9VlNzEDlMlKgvXK0r42KsKzzEN+Mk8XmE
         UDPNR4KQbYTwfRzP76J0irX+2yuyz0XUIS0JZjIKyawX3f1I4FZRyaINIWSaH/EynJi3
         PQDiFHZoURNFqxHHH55EWw35A2jfFtJjjxuANYR6bDuC0npDtsiPI9oJsgbJbKj2qSjz
         6/Or9znGr9HuokyMDCOaNzzqtvRAkbul/G5Dd4sy9g6nvSq7YmP4dkdLjNXqdXwiKe6b
         7/RwWEj9EmdVgnm48CmWe9JLHUzdcF2LttY+4fJjc4tUz3/+IOZJ3Cz27q3b2SGIuEYR
         /i2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXEB40UDdXzJjIxbqlUOTuKaGSsAQ6TPy70EUHPa8DX3Iq6ESXlLPFADezeKo73BCc0mdlyEU7L9ckDlC5YyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz18Dk6L+c5M19JBYaM4VinKuHgGm+XoSrCqU1YHyqxzOZ1XnB
	k1WaNT4qKd52RxH5BCkJi2fM1RgOw45mDg+PHv1SmIyfjuU1ydrgfU649BJthwIcYTMyLmzRZ9x
	sM8veR75rZGCqdDhHVwTiHQ==
X-Google-Smtp-Source: AGHT+IH/4RueHONVuGMDfiHkQyoQ8yYY2AJwLJHF/NIJbSz8pwho3TSM8Joo6iBkHJmUYAOUt69hIDhfHF27mc/tGQ==
X-Received: from pjboh8.prod.google.com ([2002:a17:90b:3a48:b0:2fc:2b96:2d4b])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:524f:b0:2ee:863e:9ffc with SMTP id 98e67ed59e1d1-2fe7e33eb33mr8504454a91.21.1740629535189;
 Wed, 26 Feb 2025 20:12:15 -0800 (PST)
Date: Thu, 27 Feb 2025 04:12:03 +0000
In-Reply-To: <20250227041209.2031104-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227041209.2031104-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227041209.2031104-3-almasrymina@google.com>
Subject: [PATCH net-next v6 2/8] net: devmem: TCP tx netlink api
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

From: Stanislav Fomichev <sdf@fomichev.me>

Add bind-tx netlink call to attach dmabuf for TX; queue is not
required, only ifindex and dmabuf fd for attachment.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v3:
- Fix ynl-regen.sh error (Simon).

---
 Documentation/netlink/specs/netdev.yaml | 12 ++++++++++++
 include/uapi/linux/netdev.h             |  1 +
 net/core/netdev-genl-gen.c              | 13 +++++++++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  |  6 ++++++
 tools/include/uapi/linux/netdev.h       |  1 +
 6 files changed, 34 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 36f1152bfac3..e560b05eb528 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -743,6 +743,18 @@ operations:
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
index 7600bf62dbdf..7eb9571786b8 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -219,6 +219,7 @@ enum {
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
+	NETDEV_CMD_BIND_TX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 996ac6a449eb..f27608d6301c 100644
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
index 2b774183d31c..6e5f2de4d947 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -931,6 +931,12 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
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
index 7600bf62dbdf..7eb9571786b8 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -219,6 +219,7 @@ enum {
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
+	NETDEV_CMD_BIND_TX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.48.1.658.g4767266eb4-goog


