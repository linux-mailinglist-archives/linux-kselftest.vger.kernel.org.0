Return-Path: <linux-kselftest+bounces-43795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F4DBFE104
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 21:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B593A8BB2
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 19:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C99F34FF75;
	Wed, 22 Oct 2025 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcJPH5qo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EC534CFD5
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161866; cv=none; b=Dr9kl7ZKirLOVmM3sI+SO6YALcew7MMfGPRT3mjrkrdtJgOyQxHd8K87GaHfjo5R9XixO4jJ7iI1axDEfu5KXuFB8XQolK10Ymiiz97ErggpnQ+Om0VqWjqSf7yhetRwRcDq7hgrVUS/NDQskfE2T2uEUj293viwGJVAbgvzuBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161866; c=relaxed/simple;
	bh=1ZcH+freiTc2BFHIA9kvuajmkkOkrkAeOn1kUnv1tlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpw5ZrhFyPB/xF+UC6fVR8o5GCzBTUfYjfzi06qnUqUwlom5rtrMg+uANV/dKI1ebKl9x9zfCkHL9FZSqBtnUK1m5qy94kT1IRmKW6UqCoMsdr6Kdb9kPqmUAs8IwE6c+3k5elrdVe9GoMwxqbCNQ4txNSyPaVA9a0pNwPu2Bu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcJPH5qo; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-784807fa38dso66858347b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761161863; x=1761766663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=536/HhY62MdF/LWmTEl7+XnkY5ekoqPvcMB/TqmnVQ0=;
        b=BcJPH5qoVj/TjMbvAaIl2FC9uL3y4S0Fhwxq0dKU53BDPgE484GE+Di80PqRGNXSRu
         ML7oVp5yhfSGMByeAImoxe5H4bJDjN9S6uup4Lonk1/9DK202Nl4I4WGFwwEByg67nN8
         dLpctDJ7ts4NJZJYPsOuP6MZAeKdnQJItQ+s/SAwGGB1ktUtB13CQKpkOyrdcjBHTdwE
         o6aTO+xcjTlJfTOuxFY3v8atPt8SLjXgs9pHSxZhLHYNF/TV7cAXyo8h59Mqx5vhgHEW
         ZqgqenyBOb0bxa/23VwSw/OCQJPpGU9VQebganGk0IbDFBZxwzsOfZmi729l1XRSEnWD
         5xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761161863; x=1761766663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=536/HhY62MdF/LWmTEl7+XnkY5ekoqPvcMB/TqmnVQ0=;
        b=K8/pOHCaemBs/qjroYaWG1cKD3qN8YH1JY6WOufQoYmxo3wH8d2ytXZGePw1cu68qW
         rst3Fk2VU/qxMvHa3eTdJfwQTDnt+Vk2qFaBiKSeKf0LlkbFZUcmoDrLCTI1Mtvd5nlL
         yyC4IjAoRQ83/zSVUoU26JAtU/FRuGd66dKCYvcXO2yiGSlpDNVayJCmcUKjL5PmY17F
         GFvkDO+H1VLcwUYDrdyginqwQowNDyaCdY2HbVxCKTZZcZFKI79Oe2zVgEJ4f0iD0CcR
         PpAaSsm6rWbuhfZmyLsmydbpIh4Ov5gEFR6c41NvXmf6K5ygCMJCzGxJAIUob/aP3ISH
         fYJg==
X-Forwarded-Encrypted: i=1; AJvYcCWFfdtSnFGObrURWltXkAeC6ultxPfDF5nucawy6WN8kOuv/ywBQgitqsTa3PrxXWDpTp5C244GTdCKPDaS2XI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/rVgfFMMuemRnnkc+B6hXyT65eE6IJEiCayJnD84EATxKGnHd
	aQ6pKrEMwye+RD3oX3e7uR+/qbLECLLqLxF2QY1USGBLIJIzf0AhlIj2
X-Gm-Gg: ASbGncuShgFGfka1cXK6WtVbNOdgLfHxprv/mDe9m3EIrvoZDCAZG1YyKUvmJgFUNNP
	jnIXR2lcyy+ugG4eNRbWuRT9auzXbSUtqu8rR+bMzyfJ3fGOldWULHT5w/4nIlfNjg3B9Y2redm
	01CFwAdG0Fyj9jpUoPX12lV+E7rhm6k2zMRr2Fg48tZ3A+mJJEqqjNefWHjAKjVvDPIrgCWLiBE
	OGOdoYphgtNai8f5+F9EAJYcD5RH7gWObumSAjxO3o/rohne8vnwl/OCU5UCY4P/m0699TUWh94
	Sw8GPWWaYMntxuGWFj9y1qmeULYKTzm99CbjlL3DbJoBBLxZg0OUu+lhZssfg4UqbAgU7G6LY5g
	x3Mttw0rO0xTYltwUM089VwFhS0kA7PYr8kcfmGrHE/8xCGn6g8GECUkL1XGLvecHjdHjf7KUYj
	DuDDLN+qh1kRWH8EVaZwrl
X-Google-Smtp-Source: AGHT+IFQ3QqdLs9HgrrLJwYU/QHK2PD1NorQ8XNs9ineWxU8yVWwa5XCbjDKb0C9IzmNewXZ+H2/1Q==
X-Received: by 2002:a05:690c:6809:b0:784:8153:c5de with SMTP id 00721157ae682-7848153cefemr138316137b3.35.1761161863165;
        Wed, 22 Oct 2025 12:37:43 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd6cbe09sm308897b3.36.2025.10.22.12.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 12:37:42 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Willem de Bruijn <willemb@google.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 3/5] psp: add stats from psp spec to driver facing api
Date: Wed, 22 Oct 2025 12:37:35 -0700
Message-ID: <20251022193739.1376320-4-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251022193739.1376320-1-daniel.zahka@gmail.com>
References: <20251022193739.1376320-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Provide a driver api for reporting device statistics required by the
"Implementation Requirements" section of the PSP Architecture
Specification. Use a warning to ensure drivers report stats required
by the spec.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 Documentation/netlink/specs/psp.yaml | 55 ++++++++++++++++++++++++++++
 include/net/psp/types.h              | 26 +++++++++++++
 include/uapi/linux/psp.h             |  8 ++++
 net/psp/psp_main.c                   |  3 +-
 net/psp/psp_nl.c                     | 22 ++++++++++-
 5 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index 914148221384..f3a57782d2cf 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -98,6 +98,61 @@ attribute-sets:
           Number of times a socket's Rx got shut down due to using
           a key which went stale (fully rotated out).
           Kernel statistic.
+      -
+        name: rx-packets
+        type: uint
+        doc: |
+          Number of successfully processed and authenticated PSP packets.
+          Device statistic (from the PSP spec).
+      -
+        name: rx-bytes
+        type: uint
+        doc: |
+          Number of successfully authenticated PSP bytes received, counting from
+          the first byte after the IV through the last byte of payload.
+          The fixed initial portion of the PSP header (16 bytes)
+          and the PSP trailer/ICV (16 bytes) are not included in this count.
+          Device statistic (from the PSP spec).
+      -
+        name: rx-auth-fail
+        type: uint
+        doc: |
+          Number of received PSP packets with unsuccessful authentication.
+          Device statistic (from the PSP spec).
+      -
+        name: rx-error
+        type: uint
+        doc: |
+          Number of received PSP packets with length/framing errors.
+          Device statistic (from the PSP spec).
+      -
+        name: rx-bad
+        type: uint
+        doc: |
+          Number of received PSP packets with miscellaneous errors
+          (invalid master key indicated by SPI, unsupported version, etc.)
+          Device statistic (from the PSP spec).
+      -
+        name: tx-packets
+        type: uint
+        doc: |
+          Number of successfully processed PSP packets for transmission.
+          Device statistic (from the PSP spec).
+      -
+        name: tx-bytes
+        type: uint
+        doc: |
+          Number of successfully processed PSP bytes for transmit, counting from
+          the first byte after the IV through the last byte of payload.
+          The fixed initial portion of the PSP header (16 bytes)
+          and the PSP trailer/ICV (16 bytes) are not included in this count.
+          Device statistic (from the PSP spec).
+      -
+        name: tx-error
+        type: uint
+        doc: |
+          Number of PSP packets for transmission with errors.
+          Device statistic (from the PSP spec).
 
 operations:
   list:
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 5b0ccaac3882..1aa3857a85c1 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -150,6 +150,25 @@ struct psp_assoc {
 	u8 drv_data[] __aligned(8);
 };
 
+struct psp_dev_stats {
+	union {
+		struct {
+			u64 rx_packets;
+			u64 rx_bytes;
+			u64 rx_auth_fail;
+			u64 rx_error;
+			u64 rx_bad;
+			u64 tx_packets;
+			u64 tx_bytes;
+			u64 tx_error;
+		};
+		DECLARE_FLEX_ARRAY(u64, required);
+	};
+	char required_end[0];
+
+	/* optional stats would go here */
+};
+
 /**
  * struct psp_dev_ops - netdev driver facing PSP callbacks
  */
@@ -188,6 +207,13 @@ struct psp_dev_ops {
 	 * Remove an association from the device.
 	 */
 	void (*tx_key_del)(struct psp_dev *psd, struct psp_assoc *pas);
+
+	/**
+	 * @get_stats: get statistics from the device
+	 * Stats required by the spec must be maintained and filled in.
+	 * Stats must be filled in member-by-member, never memset the struct.
+	 */
+	void (*get_stats)(struct psp_dev *psd, struct psp_dev_stats *stats);
 };
 
 #endif /* __NET_PSP_H */
diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
index 31592760ad79..d8449c043ba1 100644
--- a/include/uapi/linux/psp.h
+++ b/include/uapi/linux/psp.h
@@ -49,6 +49,14 @@ enum {
 	PSP_A_STATS_DEV_ID = 1,
 	PSP_A_STATS_KEY_ROTATIONS,
 	PSP_A_STATS_STALE_EVENTS,
+	PSP_A_STATS_RX_PACKETS,
+	PSP_A_STATS_RX_BYTES,
+	PSP_A_STATS_RX_AUTH_FAIL,
+	PSP_A_STATS_RX_ERROR,
+	PSP_A_STATS_RX_BAD,
+	PSP_A_STATS_TX_PACKETS,
+	PSP_A_STATS_TX_BYTES,
+	PSP_A_STATS_TX_ERROR,
 
 	__PSP_A_STATS_MAX,
 	PSP_A_STATS_MAX = (__PSP_A_STATS_MAX - 1)
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 481aaf0fc9fc..a8534124f626 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -60,7 +60,8 @@ psp_dev_create(struct net_device *netdev,
 		    !psd_ops->key_rotate ||
 		    !psd_ops->rx_spi_alloc ||
 		    !psd_ops->tx_key_add ||
-		    !psd_ops->tx_key_del))
+		    !psd_ops->tx_key_del ||
+		    !psd_ops->get_stats))
 		return ERR_PTR(-EINVAL);
 
 	psd = kzalloc(sizeof(*psd), GFP_KERNEL);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 094da52e357e..9fe683c952f9 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/ethtool.h>
 #include <linux/skbuff.h>
 #include <linux/xarray.h>
 #include <net/genetlink.h>
@@ -509,7 +510,18 @@ static int
 psp_nl_stats_fill(struct psp_dev *psd, struct sk_buff *rsp,
 		  const struct genl_info *info)
 {
+	const unsigned int required_cnt = offsetof(struct psp_dev_stats,
+						   required_end) / sizeof(u64);
+	struct psp_dev_stats stats;
 	void *hdr;
+	int i;
+
+	memset(&stats, 0xff, sizeof(stats));
+	psd->ops->get_stats(psd, &stats);
+
+	for (i = 0; i < required_cnt; i++)
+		if (WARN_ON_ONCE(stats.required[i] == ETHTOOL_STAT_NOT_SET))
+			return -EOPNOTSUPP;
 
 	hdr = genlmsg_iput(rsp, info);
 	if (!hdr)
@@ -518,7 +530,15 @@ psp_nl_stats_fill(struct psp_dev *psd, struct sk_buff *rsp,
 	if (nla_put_u32(rsp, PSP_A_STATS_DEV_ID, psd->id) ||
 	    nla_put_uint(rsp, PSP_A_STATS_KEY_ROTATIONS,
 			 psd->stats.rotations) ||
-	    nla_put_uint(rsp, PSP_A_STATS_STALE_EVENTS, psd->stats.stales))
+	    nla_put_uint(rsp, PSP_A_STATS_STALE_EVENTS, psd->stats.stales) ||
+	    nla_put_uint(rsp, PSP_A_STATS_RX_PACKETS, stats.rx_packets) ||
+	    nla_put_uint(rsp, PSP_A_STATS_RX_BYTES, stats.rx_bytes) ||
+	    nla_put_uint(rsp, PSP_A_STATS_RX_AUTH_FAIL, stats.rx_auth_fail) ||
+	    nla_put_uint(rsp, PSP_A_STATS_RX_ERROR, stats.rx_error) ||
+	    nla_put_uint(rsp, PSP_A_STATS_RX_BAD, stats.rx_bad) ||
+	    nla_put_uint(rsp, PSP_A_STATS_TX_PACKETS, stats.tx_packets) ||
+	    nla_put_uint(rsp, PSP_A_STATS_TX_BYTES, stats.tx_bytes) ||
+	    nla_put_uint(rsp, PSP_A_STATS_TX_ERROR, stats.tx_error))
 		goto err_cancel_msg;
 
 	genlmsg_end(rsp, hdr);
-- 
2.47.3


