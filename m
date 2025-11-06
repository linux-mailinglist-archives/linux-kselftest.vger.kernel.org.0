Return-Path: <linux-kselftest+bounces-44860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6F1C3877E
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 01:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760401889CB4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 00:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125281C3F0C;
	Thu,  6 Nov 2025 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLdvknL5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD47194C96
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 00:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388774; cv=none; b=loQclH1SRE2gJ8GeYeomN5CuZBO9Ei3Hb3orheAWTHqL109WOKF+pewHaTmTI5/YD1vdgAzid6cHJe4npwIhnl3vCCM0VfKRKvcKlSRNZ8QqkojJCfUrYvoTwOeLa+JA8Eg3cAZCexxXDXtMJMuT2N1ymIBUJ3n1Gecv6Ib1cZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388774; c=relaxed/simple;
	bh=4MYN7EAgWnSODODG6A19x6ijHGlK8gmMv8zjON/zh+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sV5wA7xv2E2Y3XSCQ5I0q+loZQwDobvsfHmG5F4ZBnQ7zTSKa8OPw58iYUy0rLbWBUnSnDd1AemPqajpuRmfSB+OVYThoL4qWEgJNxG7qMI4zhuqiOZviH1fgWlG8qNrX12J3khAZos5sXCUX4kQnbh0UL1FAXGwb9KFaLR36Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLdvknL5; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-786943affbaso3647427b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 16:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762388771; x=1762993571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fj6rW30AFi0w9W9uK7Qpyv8PnHs6M2XJTUrrQLC3IC8=;
        b=BLdvknL5PQxwSWGcKz//ajzKsjybP2gL0i6pb0u1PauO8nW3YppEtUE3j//YjRXYus
         4pDmvrKEyzOZZsLnLf4njfKClfuJfPqaCbjEGura/QDOi1LL+OfLBqUB3lYEICU+yUTQ
         M+Itm4Q2I5eyAA0fNHGth3JaW4EWzn92QciUT4x/qjh07sIKJfrc6fzpLeo3iCXw8wN4
         CqulfAGsQ8FjYzWCqJ06CqSI8YR2MZdTt4uzsRbpZRYmWnBWAuO7kFox9UNadWvMCQRM
         oxTiHAjuv/EhV0LlCZ44vanOG7ZYH1j8QcLOPSu7fxlu+vx6MOGaZYRaBmkRQPXgkFFR
         /MAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762388771; x=1762993571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fj6rW30AFi0w9W9uK7Qpyv8PnHs6M2XJTUrrQLC3IC8=;
        b=Q4FJmqv9PMbpOpSEINCoT4bK1V5T1YupsB1zRe1eq6RXfcKzo0c8l4ufdtRPjS5lIT
         1J0TVrTxuCfiae0JaXv6yG3xO08doqJIhY9/6SRPhcWAkh5hqbYXbrLzay4VcomP2qAV
         RaoMNUeSYkWbg8nDSAF7c/D2SNsyZteG96hJsciilRG67YEdcx4x+hTQwkA8weAVaxx6
         Ap6Ay9XT5jC7Knc0ATnYMqRKQiawVc+FEEB+V5gLRg8srQvrDMVOeQwwig/s0zXS/QSC
         ZRmfHUpil9pddjPI2Y+mmHP25Z0RFvsWyKGakOp3q81nsfQpwjaDynN39S32cZ3D0+9U
         VuCg==
X-Forwarded-Encrypted: i=1; AJvYcCUHQrI1cZWjx/K7ZnnaqLz5tsK2R1EZHt5Tn1rBZJ7qVRq2fzhra+7r9/hshv13k65mHaL8uZ9soExkJPLPaxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyie3zRBP+6ZlfbwiNcG1chsKPpSjV1ioLbOlBXUpwKMWBP8zR8
	5j2IKmXzlezsOfnQpJhkr3jQPoBgo7VLvCssmyy/ZpUkv/eNm12jzSXl
X-Gm-Gg: ASbGncsmJQXfmn0xOgIj8SMrQgmYBWzH/q4JeL+SURfEbjbduhnxOktkixpPHNcUxxr
	OMklBTPpL5r4PtH3+C52asw4D3TYcaObynN5WFT1DcGaLojWKYlshzQ+pOQ09m85xvYr/hrj5z9
	5J3gsBdTqLdC31PiPbdV2VczMexVSny+wKDYUS654wUTscCgNKPBNWKojS1uDfBDWN8EWjaDUk0
	lOlhk/0SaT0MjK/J3nBAHZZ2YejyBlhVe4BqV5/h3bE0gRF64j9XWhc3Izmqf2KACYr0l14C8iF
	L9s/QtWsaKb6zzKTr4ERWTJg6odeLlW4zLYOwnPHAhAFCRJQwE/onEGu4lACGO54SWdMp/wAIpm
	kddgVV9ae+yg6lPJlJ9iOwjatZDG8ji+io5jEZneAUj/kQ/RJqWUpC3H3B/KwaoHBDsNCVJnF0l
	tHL4M26RbILw==
X-Google-Smtp-Source: AGHT+IFS2iWAxEnztB5To7sq/L7ysBy9qfC2JiggfaKdL+MGbkE7IAtmPDihj9rg7WJDwBFUgndIyQ==
X-Received: by 2002:a05:690c:8d14:b0:784:8b82:98d2 with SMTP id 00721157ae682-786a4213583mr42199497b3.70.1762388770706;
        Wed, 05 Nov 2025 16:26:10 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b159b666sm3400747b3.39.2025.11.05.16.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:26:10 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 1/5] psp: report basic stats from the core
Date: Wed,  5 Nov 2025 16:26:02 -0800
Message-ID: <20251106002608.1578518-2-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106002608.1578518-1-daniel.zahka@gmail.com>
References: <20251106002608.1578518-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Track and report stats common to all psp devices from the core. A
'stale-event' is when the core marks the rx state of an active
psp_assoc as incapable of authenticating psp encapsulated data.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v2:
    - don't return skb->len from psp_nl_get_stats_dumpit() on success and
      EMSGSIZE

 Documentation/netlink/specs/psp.yaml | 40 +++++++++++++++
 include/net/psp/types.h              |  9 ++++
 include/uapi/linux/psp.h             | 10 ++++
 net/psp/psp-nl-gen.c                 | 19 +++++++
 net/psp/psp-nl-gen.h                 |  2 +
 net/psp/psp_nl.c                     | 74 ++++++++++++++++++++++++++++
 net/psp/psp_sock.c                   |  4 +-
 7 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index 944429e5c9a8..914148221384 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -76,6 +76,28 @@ attribute-sets:
         name: spi
         doc: Security Parameters Index (SPI) of the association.
         type: u32
+  -
+    name: stats
+    attributes:
+      -
+        name: dev-id
+        doc: PSP device ID.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: key-rotations
+        type: uint
+        doc: |
+          Number of key rotations during the lifetime of the device.
+          Kernel statistic.
+      -
+        name: stale-events
+        type: uint
+        doc: |
+          Number of times a socket's Rx got shut down due to using
+          a key which went stale (fully rotated out).
+          Kernel statistic.
 
 operations:
   list:
@@ -177,6 +199,24 @@ operations:
         pre: psp-assoc-device-get-locked
         post: psp-device-unlock
 
+    -
+      name: get-stats
+      doc: Get device statistics.
+      attribute-set: stats
+      do:
+        request:
+          attributes:
+            - dev-id
+        reply: &stats-all
+          attributes:
+            - dev-id
+            - key-rotations
+            - stale-events
+        pre: psp-device-get-locked
+        post: psp-device-unlock
+      dump:
+        reply: *stats-all
+
 mcast-groups:
   list:
     -
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 31cee64b7c86..5b0ccaac3882 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -59,6 +59,10 @@ struct psp_dev_config {
  *			device key
  * @stale_assocs:	associations which use a rotated out key
  *
+ * @stats:	statistics maintained by the core
+ * @stats.rotations:	See stats attr key-rotations
+ * @stats.stales:	See stats attr stale-events
+ *
  * @rcu:	RCU head for freeing the structure
  */
 struct psp_dev {
@@ -81,6 +85,11 @@ struct psp_dev {
 	struct list_head prev_assocs;
 	struct list_head stale_assocs;
 
+	struct {
+		unsigned long rotations;
+		unsigned long stales;
+	} stats;
+
 	struct rcu_head rcu;
 };
 
diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
index 607c42c39ba5..31592760ad79 100644
--- a/include/uapi/linux/psp.h
+++ b/include/uapi/linux/psp.h
@@ -45,6 +45,15 @@ enum {
 	PSP_A_KEYS_MAX = (__PSP_A_KEYS_MAX - 1)
 };
 
+enum {
+	PSP_A_STATS_DEV_ID = 1,
+	PSP_A_STATS_KEY_ROTATIONS,
+	PSP_A_STATS_STALE_EVENTS,
+
+	__PSP_A_STATS_MAX,
+	PSP_A_STATS_MAX = (__PSP_A_STATS_MAX - 1)
+};
+
 enum {
 	PSP_CMD_DEV_GET = 1,
 	PSP_CMD_DEV_ADD_NTF,
@@ -55,6 +64,7 @@ enum {
 	PSP_CMD_KEY_ROTATE_NTF,
 	PSP_CMD_RX_ASSOC,
 	PSP_CMD_TX_ASSOC,
+	PSP_CMD_GET_STATS,
 
 	__PSP_CMD_MAX,
 	PSP_CMD_MAX = (__PSP_CMD_MAX - 1)
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 9fdd6f831803..73f8b06d66f0 100644
--- a/net/psp/psp-nl-gen.c
+++ b/net/psp/psp-nl-gen.c
@@ -47,6 +47,11 @@ static const struct nla_policy psp_tx_assoc_nl_policy[PSP_A_ASSOC_SOCK_FD + 1] =
 	[PSP_A_ASSOC_SOCK_FD] = { .type = NLA_U32, },
 };
 
+/* PSP_CMD_GET_STATS - do */
+static const struct nla_policy psp_get_stats_nl_policy[PSP_A_STATS_DEV_ID + 1] = {
+	[PSP_A_STATS_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
+};
+
 /* Ops table for psp */
 static const struct genl_split_ops psp_nl_ops[] = {
 	{
@@ -99,6 +104,20 @@ static const struct genl_split_ops psp_nl_ops[] = {
 		.maxattr	= PSP_A_ASSOC_SOCK_FD,
 		.flags		= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= PSP_CMD_GET_STATS,
+		.pre_doit	= psp_device_get_locked,
+		.doit		= psp_nl_get_stats_doit,
+		.post_doit	= psp_device_unlock,
+		.policy		= psp_get_stats_nl_policy,
+		.maxattr	= PSP_A_STATS_DEV_ID,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= PSP_CMD_GET_STATS,
+		.dumpit	= psp_nl_get_stats_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
 };
 
 static const struct genl_multicast_group psp_nl_mcgrps[] = {
diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
index 25268ed11fb5..5bc3b5d5a53e 100644
--- a/net/psp/psp-nl-gen.h
+++ b/net/psp/psp-nl-gen.h
@@ -28,6 +28,8 @@ int psp_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_rx_assoc_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_tx_assoc_doit(struct sk_buff *skb, struct genl_info *info);
+int psp_nl_get_stats_doit(struct sk_buff *skb, struct genl_info *info);
+int psp_nl_get_stats_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 
 enum {
 	PSP_NLGRP_MGMT,
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 8aaca62744c3..f990cccbe99c 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -262,6 +262,7 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info)
 		     psd->generation & ~PSP_GEN_VALID_MASK);
 
 	psp_assocs_key_rotated(psd);
+	psd->stats.rotations++;
 
 	nlmsg_end(ntf, (struct nlmsghdr *)ntf->data);
 	genlmsg_multicast_netns(&psp_nl_family, dev_net(psd->main_netdev), ntf,
@@ -503,3 +504,76 @@ int psp_nl_tx_assoc_doit(struct sk_buff *skb, struct genl_info *info)
 	nlmsg_free(rsp);
 	return err;
 }
+
+static int
+psp_nl_stats_fill(struct psp_dev *psd, struct sk_buff *rsp,
+		  const struct genl_info *info)
+{
+	void *hdr;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(rsp, PSP_A_STATS_DEV_ID, psd->id) ||
+	    nla_put_uint(rsp, PSP_A_STATS_KEY_ROTATIONS,
+			 psd->stats.rotations) ||
+	    nla_put_uint(rsp, PSP_A_STATS_STALE_EVENTS, psd->stats.stales))
+		goto err_cancel_msg;
+
+	genlmsg_end(rsp, hdr);
+	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(rsp, hdr);
+	return -EMSGSIZE;
+}
+
+int psp_nl_get_stats_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct psp_dev *psd = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int err;
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	err = psp_nl_stats_fill(psd, rsp, info);
+	if (err)
+		goto err_free_msg;
+
+	return genlmsg_reply(rsp, info);
+
+err_free_msg:
+	nlmsg_free(rsp);
+	return err;
+}
+
+static int
+psp_nl_stats_get_dumpit_one(struct sk_buff *rsp, struct netlink_callback *cb,
+			    struct psp_dev *psd)
+{
+	if (psp_dev_check_access(psd, sock_net(rsp->sk)))
+		return 0;
+
+	return psp_nl_stats_fill(psd, rsp, genl_info_dump(cb));
+}
+
+int psp_nl_get_stats_dumpit(struct sk_buff *rsp, struct netlink_callback *cb)
+{
+	struct psp_dev *psd;
+	int err = 0;
+
+	mutex_lock(&psp_devs_lock);
+	xa_for_each_start(&psp_devs, cb->args[0], psd, cb->args[0]) {
+		mutex_lock(&psd->lock);
+		err = psp_nl_stats_get_dumpit_one(rsp, cb, psd);
+		mutex_unlock(&psd->lock);
+		if (err)
+			break;
+	}
+	mutex_unlock(&psp_devs_lock);
+
+	return err;
+}
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index a931d825d1cc..f785672b7df6 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -253,8 +253,10 @@ void psp_assocs_key_rotated(struct psp_dev *psd)
 	/* Mark the stale associations as invalid, they will no longer
 	 * be able to Rx any traffic.
 	 */
-	list_for_each_entry_safe(pas, next, &psd->prev_assocs, assocs_list)
+	list_for_each_entry_safe(pas, next, &psd->prev_assocs, assocs_list) {
 		pas->generation |= ~PSP_GEN_VALID_MASK;
+		psd->stats.stales++;
+	}
 	list_splice_init(&psd->prev_assocs, &psd->stale_assocs);
 	list_splice_init(&psd->active_assocs, &psd->prev_assocs);
 
-- 
2.47.3


