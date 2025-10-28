Return-Path: <linux-kselftest+bounces-44158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2960C1220E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 01:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A75C64EEAA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 00:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A51222582;
	Tue, 28 Oct 2025 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hL+x3IQs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877907FBAC
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609627; cv=none; b=WUmCiDkqcR1hatB0D9joFiS5l1xPRFZJ6Ng9zDTaQty7rcEh+zCI/XNOHRDfeQlfA1z7u+NaJnPcQdO/IMrPbagxhtlWU9GDoGjMrQGM88rpm1M/NGGNmoTKHz+aDKcmrmE97C0KakiNn7ioSQHST3shj4Zj9R+dXB+kNxub0aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609627; c=relaxed/simple;
	bh=wpjBIJ6UQ1SC2AMlricidu0TF3ztCZv3T7Z+LEo/Juk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5ExZMlOQyGrObWz4cZ1FLEch1dE3+yPt6w9AyGGekS87nrYXJFj2ZRwy/8SmwKROdooqjm8npA9yrDvS214HJvDt3hhYtQohJNW12BjjOij8EFJ4Pbewk9tF1uKIR/ATfdO3CHM4e7UFQ+AkJbllRov9+ByrbEpApsQjS1NfSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hL+x3IQs; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78617e96ae1so6063727b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 17:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761609624; x=1762214424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdcFP1QaTsuTtBulUqx+7dg8/rJFCvHWDJDP1RMUy/E=;
        b=hL+x3IQs87sfJiHmHGrx/RlLsIkv0XGwd4vPsRUVSYPcfb+gBXyfk/LTa67ay5yTHk
         ZoOMRr8kD0Tli/xCM6i+FHZ6qlroUUjiUxueAMWBxfwe01+mKYVQ+ExzuuJfzcGL3vAB
         UcFeyLORKswXbt9HdI2bpXM9fEYru6kHd8+9vUqH9+URwf8HcvbI7ZHKpMH1Lbd3/ZGf
         AIk+09kPFCkrZh7PuMcBev9iqBY4JB7Rmjnjo5awpk5STnjgKPmDNkA39QkHI6rcGJa9
         4GishBuSS8u5kaBrkO06SDiGiJBm9EeIt+UQgldBeIYYzkYqISPk1ds4C/xrfdnJbL4w
         f3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761609624; x=1762214424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdcFP1QaTsuTtBulUqx+7dg8/rJFCvHWDJDP1RMUy/E=;
        b=J0l4zBsRoZiUQ9zjuSo+yoHlnfNoLfUL1l85MQhBYjGmFjwvJcMp7jRbfR/WShJ2Mi
         UEcmMdziqvQ/xCK0u4nz8C7nbyHgN/jU/I8Y0CkBc8ATuMxtz6ga6aXAc466QQ586Oxt
         lS0HP6nkJcMI8bUBpHBAiX8SKjXtYI+sWEyE+k2JImnxg4I/TYWfA1YjLFJA9T1pWQBs
         OWm3GFZ0KvyFNXE6o01W1pPehBVcsIbzAfCTYR2DYfu7AP0WiTh8IwWuSRNsDbJq4FBi
         9QmfCKLCwn1vx1/cUu2czEIQmoqXnAAKWyazD6yU5u4jUNjaCYSbIKYCZ+XTwg29PTN+
         jDCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjxFKGF6bY0jNPdNH01VhqxeqeGSYKUBfMrem6ojekDhWyUG32SF+GzM8TKobefXMOx+OxQjAtzG5uinDif2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2TRNtksU288HvjMLgBNBupg1CKCl94Y0j6CpMUvF36KGvBCSf
	NInEsurhjvEvJ6BPlz5rx2KOfELPodJUQz0tqjgmyphOC5h4VoD7bXx5
X-Gm-Gg: ASbGnctePvdTrtSPZw7EXhm1h2lBsdTBbFehA7KM2J7FsWzcEqkeBlA8/N1hQGJuvzC
	685+ka9iNmRDBjMO1M1WVzXZebP0MDFSJB1XOdWMaqz41/as2Su7chshBYayPL7eHPPZA0mmj3B
	tsTCkFNkzgxSiL3MpzX+U1yx9BDLNavHaLLZW5hzG5YhZx8MhXR7Qn70CYQrfb3PKI3DvecjHMu
	ki/2xhaoi/YrkCGtYPOx358OFZfSIOpF2Cxs+dBnDFSNqVDdJziDMzBLcsjoDKd5Vk1PjMN5VrJ
	6kBQmDFoaWNqacQ5MSEKuEthO1h2y0bapGPnwZBuNhbUc2rX9U7PSOIlW6oBYSI/mBsy4MeKJZT
	v5rXroio13bShrr2vIRMcPCD7XQNdvlULrkzxI+aYyPYeH3rD40ZcN0p4ECb80SMWr3bYrDoq0V
	zCvjIMQ53eaQ==
X-Google-Smtp-Source: AGHT+IGTW9A3v/Un7T75YSG+S6IX+bvGqsBHmZHbWNg2qRPduaM2qSRvFpbhNfTaxccwAUm5TJ/LXw==
X-Received: by 2002:a05:690c:b05:b0:784:ab8d:4b97 with SMTP id 00721157ae682-786183b0968mr16539847b3.58.1761609624295;
        Mon, 27 Oct 2025 17:00:24 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:49::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed196a0dsm23152787b3.27.2025.10.27.17.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:00:23 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/5] psp: add stats from psp spec to driver facing api
Date: Mon, 27 Oct 2025 17:00:14 -0700
Message-ID: <20251028000018.3869664-4-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028000018.3869664-1-daniel.zahka@gmail.com>
References: <20251028000018.3869664-1-daniel.zahka@gmail.com>
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
index f990cccbe99c..1bace9731d3c 100644
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


