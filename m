Return-Path: <linux-kselftest+bounces-27034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A67A3CF0F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 03:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF6516E575
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 02:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683DA1D63D2;
	Thu, 20 Feb 2025 02:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hEXq0IyW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180C31D514B
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 02:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017367; cv=none; b=q+MUREm8fugHrZsTchEfmpOsNxkWJ6xh4U3sg1UEutFKnW7EZuF/N1bFwlIlrB+9bZbSQPDmGugJAC2UCw+6vpzhMUl6qINyL4QXXo0IVDmmJU422a3806bdTBoIDhDv3wBEc4LJ4gtMoBlouzZyGhkzg4izatGhichJb2/z3xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017367; c=relaxed/simple;
	bh=wv/Nl/0TTuCuSzX9uge87xPhddp3iWORdXEDTuKUoaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uzaHLVuUMA8fCmgu5zCuP3eh4pc3ojvM2P0vg2dLXYi09ltOGRs3M70hDVeQdewaH0MyrJIwdqQ3McZ3KTYqmfLzRqqrJFfgOg4Ala3I1IfphURlnDVfz3DUqemWCwxWyD9L+Ka/rgvpPFIFohtnEHxQ+afJCdMLj+wajZ49X44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hEXq0IyW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220cd43c75aso12473215ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 18:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740017364; x=1740622164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q07ZPpGlxJD57O2WL3mxnzOyUUhqTVa6xALP0zRrY7w=;
        b=hEXq0IyWvIl1FjfDQaTIw1gJwYUcxfI/MMl3tBBB21XEwyYJmCA5uSz8+HT7kpLYsO
         csu6jA2j6phUM2xL1sTZxlJgdi/u6v+ObLCT2M7VuKxJxT7QO7gqv7p0n9hL68dH5AAs
         F9ErIdb0VlfHh3PmEad3+uyqC/kfowajdZff4kczjoB+ZxpOdlK16LjosllQCeeEo1P8
         N2JeTOtn38QCsw6IeMSg73hN4vYZt2fKZtC+mrkUzoDj1pCcedzkJ6NazTtC/Xo9QvDq
         5Pg/HYqgLlEq6pX8i1WKYCVdCNlk81xlV8n+eYaChLQlRQ3KndmDxkWREzxBJmW3/gCe
         beLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740017364; x=1740622164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q07ZPpGlxJD57O2WL3mxnzOyUUhqTVa6xALP0zRrY7w=;
        b=W+d8rf19uKYLbxO4PK/qgQpYXW1iPKGglrUxdSEwSVq1noJx7Ql20TTTk/uJdGQdYY
         p941LuTMv4HfrUVOv41tYNvRvVqOjIoBszXFSMpJtvmB8O4izZf3PIiHiZZJ40YEKsXS
         pjJqT+S21laBXyKq+xb/xWXGcQ4WDhtTHp6xn18dd7mOENEGBh0m+K6nn7GyQlj8BStf
         0YB9jpXQdhRMu1zJfZGXihfXO27liw2gRfJHcnlcF+EprzbspCIFmCaaceeaZm6ORusk
         pof2jYL1gf4QRwH0ca+6s7YZLb8iyf8D6Fh3emNI5PjH2Ql7gBbREqVCe34I8Y1Wi728
         qsIw==
X-Forwarded-Encrypted: i=1; AJvYcCWOk31ZMESqOpLiXrWM+nixPbA3JYAkVSRsSVQ9DGujxWmCmPvCgJYy4r2Qa6mcm8oKtkz5kVTtD5AUq0d4qRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycr4XdTG98hDdSz/fHUuCMOW5Q7G907h7mEYymDBVjXOgapdcM
	YI8QBUvUEII3g4c//JRUO053kysimSXpGnRaH45fzoeR5wNVJsWm+P68jy6bwz7CUo055erIXtS
	dsAG54uy35gB9Ase9FT5JoQ==
X-Google-Smtp-Source: AGHT+IGor0R9LeqETB1vktgkLfZglF28he79PoEeU9oNKftoaSUt6owPZhDmQ7APNsMa2/gZBH6jr+0UQACvRDYBbA==
X-Received: from plblq5.prod.google.com ([2002:a17:903:1445:b0:216:25a2:2ecf])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db10:b0:220:e7d8:a8a6 with SMTP id d9443c01a7336-221709892e6mr88623765ad.27.1740017364391;
 Wed, 19 Feb 2025 18:09:24 -0800 (PST)
Date: Thu, 20 Feb 2025 02:09:07 +0000
In-Reply-To: <20250220020914.895431-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220020914.895431-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220020914.895431-3-almasrymina@google.com>
Subject: [PATCH net-next v4 2/9] net: devmem: TCP tx netlink api
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
index 766b82005d18..aa8c289c254e 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -739,6 +739,18 @@ operations:
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
index 4e82f3871473..a3ce02b55b5f 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -216,6 +216,7 @@ enum {
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
index c92fba65b20d..73420edd3f1f 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -929,6 +929,12 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
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
index 4e82f3871473..a3ce02b55b5f 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -216,6 +216,7 @@ enum {
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
+	NETDEV_CMD_BIND_TX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.48.1.601.g30ceb7b040-goog


