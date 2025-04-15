Return-Path: <linux-kselftest+bounces-30904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D648A8AB6F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 00:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C1A1902F81
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 22:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76132C376F;
	Tue, 15 Apr 2025 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPoTSGJY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0B2C2ACD
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744757283; cv=none; b=GYKCgrirDPydgmIdpMkRCwvwTHpZPLKNimrfJydxZQ4MajdulgQgnszJH3zNf45tnGEnlH6vW6OTomRewwf6rf0QGW1KEfedKhpf1UwSp7Zk70OiLCquK0eKkQ50TjIn/WgaRLwMF5d7siazKbIJMly4Iwo1dFiqJWl62G6UgVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744757283; c=relaxed/simple;
	bh=vYruOn6ZCnt2osQ2RM0NjPvjnHgHAHySGw+k55cYozA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dm4QdvHyvNurIHXJqOTFYs86WgoQNilk4vx4jCPvzg3nlzab4fK3Gsyhh5xq6lofUaVNYLXUc8aWnutXL8SRdjayR6N2w6lB3gwKWWVqm5pBO91w7y7k9n1LOjvGTnF/oquJp0OlrHaLTACQzwWumFfIgJmizpYhWNZ7qwEl7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZPoTSGJY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2240a7aceeaso54450245ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 15:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744757281; x=1745362081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rb37J/NIxlDEqdX2HlDPG648dtVAMv+1ViCWAXb+O10=;
        b=ZPoTSGJYqXw4JwVKX8acJGBOuxAd2xi69ZPnX+AtAyxBSEM1ntsUagjyPjWsvESisN
         kb0CB0DuXjwO6kvlnyN0VHZ/3p30R9X+bDeeUSjUpeS3nRLaQNxHfrLFZiIfDOOBvNJj
         Xi4SX3zaey0x4bTkCi+/Dvb760tuGnAOwEOxw5u7F2A9b+2W8U8y6tgs8ON1RGmerUUO
         xFOY/3yJtsHXO4fvIzv4VVdchtFC/jTw9H690O8Srgu+ueMDWUCrfpTOEk6oqLy8U99q
         rc98z6qweOrYSULD0Ue3s0r7YsWnVZkBEoVJeIegviQoy06Hngym2rHkAgTPBZNOgyJR
         8s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744757281; x=1745362081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rb37J/NIxlDEqdX2HlDPG648dtVAMv+1ViCWAXb+O10=;
        b=ba6RcR4daruzlPuPUHoY3V8HRTFxfI05UkQYsewI2FbgQ4NEKvwYoBIQ8yDgzhKb9v
         9XpIFon+D8Z+r6gJiSKyZbAqH+zpGoa7BLt+9OoNEj7oa5hxvhUnvUulpciXVXkp6TGD
         ovfnhsW0UCiMb3svAa0j/ZqgL0ZwUNnKUN6B6hp/X/oJgi9VZwP+fjHTvWTPE60zIbGz
         ouBIoHcz/tSao6whIWhd7iuLuSeZflA2l2IBae8cD5cI/AyPISWToj9Y38b7tXlD1btv
         1q2SoYekHDv077q7hgWh/BufavbPDbCvk/pGUuZy6TS+kdS4WCBGTfvpUD02logz/pZF
         anBA==
X-Forwarded-Encrypted: i=1; AJvYcCXUfqobpjX73eATKTBp+dHqLTDnNgaoKyquoz3mlRPXx+tSRl+wP2QqIk0Lpogo4K2Sopm32358Kb8/YN+xaFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWdaTnUOH1VnhLQmE7JlmeCgWwV9nmkAK0w24p7fOgUngLBcI7
	o7Oo8LfdCHwn2gm8ePqcxHggML99wdb7tX7Wtkvv11VVM9cegsPW07htm7JaA9X60CLoIs9EOEY
	pinOyF9LJ7NjDEc3eSH9YCA==
X-Google-Smtp-Source: AGHT+IETYt8ZGmmI20ODfaQxy1T5q67/oAiQDigKBP86KcszuEqmb72dzX4sqpwwCRPU7mAYCgS3cXO8MNHptUMRNw==
X-Received: from plgt15.prod.google.com ([2002:a17:902:e84f:b0:223:fb3a:ac08])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2281:b0:216:6283:5a8c with SMTP id d9443c01a7336-22c31a7d30emr10454265ad.39.1744757281567;
 Tue, 15 Apr 2025 15:48:01 -0700 (PDT)
Date: Tue, 15 Apr 2025 22:47:50 +0000
In-Reply-To: <20250415224756.152002-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250415224756.152002-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250415224756.152002-3-almasrymina@google.com>
Subject: [PATCH net-next v8 3/9] net: devmem: TCP tx netlink api
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>
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
index f5e0750ab71d..c0ef6d0d7786 100644
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
   headers: [ "net/netdev_netlink.h"]
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
index 739f7b6506a6..4fc44587f493 100644
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
index 17d39fd64c94..cf3fad74511f 100644
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
index b64c614a00c4..5e42f800dfcf 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -934,6 +934,12 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/* stub */
+int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return 0;
+}
+
 void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
 {
 	INIT_LIST_HEAD(&priv->bindings);
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
2.49.0.777.g153de2bbd5-goog


