Return-Path: <linux-kselftest+bounces-48089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD8BCEF920
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 01:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C0603014D86
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 00:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2673324DCE5;
	Sat,  3 Jan 2026 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="S+oOYJQU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0E4226CFE
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Jan 2026 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401138; cv=none; b=sXzHncmueuChtIb/DKrgFMQboIzVpH18iCsx9HjTY5klcR1kSjhALAQQdAjVh90afZSUFLV1m3etPpPB2NsvxJaScoRVG5bkZgHJuC48i3ufdBiXXLbrE7Ap7/CspM35pusiBaGnFgYA5w535UTJ6XOR2J+/bH3Ozy3tVS56ZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401138; c=relaxed/simple;
	bh=fTJhuC6H0dNBq3FX1co7NhfO2FVWInl52pOu9PDumX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rU4v89/R1V3MHg7pEEsWxqe4PIe1rv+6WsCxplHUgcHt4F9y7ZS1z4OXJ9rAwKCpB71uEp1ftV3G2A8QmxY28uDxK26Ls6mIDWE4cIC/xF9+1pXhbMQyeURSS0sZSvcbIlBUSIKeEIFEHU8q5q49i8zbvpHuhFKBQLWq0I+nwFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=S+oOYJQU; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-64477ac6363so1067072d50.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 16:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401133; x=1768005933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUye211JIBiRnZQOddGEfx1ZXqYyficSfLxDXccUr6A=;
        b=S+oOYJQUFq3bFq/1ToZhr7LYqluM3fRh4Y+iN0tcWEUMrSd9sDy9JTijWna8YR6Lnq
         DSPsJYhyKDvQokttgibDqVJLwj31zrpfcr33pk7ljaGWGoQuqKGa9feAxgVrKpATMtZr
         aGGDI/SFng/HTIuHBjdTIWKBpKFGJLamDTgSfVcs1HG1SaXPbwdgeJoCeJZfCtdZeKot
         489+zwh3vYASa6PpgpC+7a02pzOnveXW5MAl1bZ5lnjL3CVFhp6w/Up9K7xLrAG9K+Tk
         ahNJ9zOoxmQ4PjzeI6dTSswrsTxFBxJKbhdjRB73hTzjWDd/avQ8JDaTHxlqD1j5aNcL
         58yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401133; x=1768005933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vUye211JIBiRnZQOddGEfx1ZXqYyficSfLxDXccUr6A=;
        b=ZQSv2GSBymNdnCgw4ryrDaTP32fZZ+y5Pdxbxil4IfSbTjIkt6wfpF4dgZW5JWbFFQ
         vG3TXpSYNrv5sjOogWCWYpWSPCOKNTuQhfU7FFpfiX+GbtAloF/TaTFFKJGimvOc5SYc
         LX0FfvNxEIWz2/jM41yehQvyXD2vPj1iqho7O/vxKlCj7Rt3Bqv4ManZX8jssVFsDDgS
         Wi5AgtKf645Zz8PnbZvS/y6CxaxXDi0rhIM4wT4tdZ1ni9LXKhP55vIGIgJIzBtdqyOm
         5KcJshP5K1EbMn2TZMRNOQ0a8P+AeSmBzJSsF4Pf8xTRBvD+EGJsqpqHnl2+9giWYlnH
         ZaJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ8+Xgm82j/Z7+wZlWHZZT1OVRTzz5FgYM9TJWRAN1hwUMsfusQ1bBgjsddYTSgdjTu3WzGkZExSk0tNiMabE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJuBqJuVAgXl7GZMplnHl9LZxbTNDQ6WVdVkZ3s09qGu4w0qr
	0HM6jZwYijqZBY6IiLR9rURU5G2/25exUkqXSpByk4GFwcet7/inRXsMuCkSZsSrUZG0nJS/OWE
	ngqhKTZ/3xGb1Id0tVlDqw4G5zVRcirEzv0oMR5c6960JBsOhh5/Z
X-Gm-Gg: AY/fxX5fmZzzTEE5dQTGsHAcZA3CYeVC0wyndEf+OMYISOYJhAyvlZXJrLnD6yL82H0
	1zj4YQiUWO/ttLVrjF/zmK6ZmqfFlYmc3XnGFT55XWqem1ggfMXafhqtJas/aC5fSIJRla2vkgz
	GkU+ea2sO1aECW8xRSC/IDTZxj9RrstL/O0Q5Lod2L1uTwzpBFO17sFHHDT7xeG8RXiuY0jFMJe
	NIlW+pzGivJNjIRdBpW+OhQyh2sPJI5F8e8x/BoROJ9iss8u5ROsfs8DmCMbZ0eaRAVqZMAneNw
	iP2OWBRWZkYWjgm6wAmhdwo/DC5gwWmXl/kjcMGZoeNytrmK1wemNJN9yWBYdtsRMuLxp0i5gc2
	NrA9Md9H/cWd1eV3XAmGh5RXDF1s=
X-Google-Smtp-Source: AGHT+IF6PH7wb7P58P06jGSyp4LJxTipfWWCGV1r7JBSKpNx8MXPlVVNEe1WWVX2jKZazQFR2kjMF+hFmvhM
X-Received: by 2002:a05:690e:dcf:b0:646:5127:9cfc with SMTP id 956f58d0204a3-6466a872017mr28609377d50.2.1767401133249;
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78fb451ba6csm20083417b3.25.2026.01.02.16.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5F408341D2E;
	Fri,  2 Jan 2026 17:45:32 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5CCAAE43D1D; Fri,  2 Jan 2026 17:45:32 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 03/19] ublk: support UBLK_PARAM_TYPE_INTEGRITY in device creation
Date: Fri,  2 Jan 2026 17:45:13 -0700
Message-ID: <20260103004529.1582405-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Zhang <stazhang@purestorage.com>

Add a feature flag UBLK_F_INTEGRITY for a ublk server to request
integrity/metadata support when creating a ublk device. The ublk server
can also check for the feature flag on the created device or the result
of UBLK_U_CMD_GET_FEATURES to tell if the ublk driver supports it.
UBLK_F_INTEGRITY requires UBLK_F_USER_COPY, as user copy is the only
data copy mode initially supported for integrity data.
Add UBLK_PARAM_TYPE_INTEGRITY and struct ublk_param_integrity to struct
ublk_params to specify the integrity params of a ublk device.
UBLK_PARAM_TYPE_INTEGRITY requires UBLK_F_INTEGRITY and a nonzero
metadata_size. The LBMD_PI_CAP_* and LBMD_PI_CSUM_* values from the
linux/fs.h UAPI header are used for the flags and csum_type fields.
If the UBLK_PARAM_TYPE_INTEGRITY flag is set, validate the integrity
parameters and apply them to the blk_integrity limits.
The struct ublk_param_integrity validations are based on the checks in
blk_validate_integrity_limits(). Any invalid parameters should be
rejected before being applied to struct blk_integrity.

Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
[csander: drop redundant pi_tuple_size field, use block metadata UAPI
 constants, add param validation]
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c      | 94 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h | 18 +++++++
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8e3da9b2b93a..2f9316febf83 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -42,10 +42,12 @@
 #include <linux/mm.h>
 #include <asm/page.h>
 #include <linux/task_work.h>
 #include <linux/namei.h>
 #include <linux/kref.h>
+#include <linux/blk-integrity.h>
+#include <uapi/linux/fs.h>
 #include <uapi/linux/ublk_cmd.h>
 
 #define UBLK_MINORS		(1U << MINORBITS)
 
 #define UBLK_INVALID_BUF_IDX 	((u16)-1)
@@ -81,11 +83,12 @@
 
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL                                \
 	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
 	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
-	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
+	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT | \
+	 UBLK_PARAM_TYPE_INTEGRITY)
 
 struct ublk_uring_cmd_pdu {
 	/*
 	 * Store requests in same batch temporarily for queuing them to
 	 * daemon context.
@@ -628,10 +631,57 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
 		set_disk_ro(ub->ub_disk, true);
 
 	set_capacity(ub->ub_disk, p->dev_sectors);
 }
 
+static int ublk_integrity_flags(u32 flags)
+{
+	int ret_flags = 0;
+
+	if (flags & LBMD_PI_CAP_INTEGRITY) {
+		flags &= ~LBMD_PI_CAP_INTEGRITY;
+		ret_flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
+	}
+	if (flags & LBMD_PI_CAP_REFTAG) {
+		flags &= ~LBMD_PI_CAP_REFTAG;
+		ret_flags |= BLK_INTEGRITY_REF_TAG;
+	}
+	return flags ? -EINVAL : ret_flags;
+}
+
+static int ublk_integrity_pi_tuple_size(u8 csum_type)
+{
+	switch (csum_type) {
+	case LBMD_PI_CSUM_NONE:
+		return 0;
+	case LBMD_PI_CSUM_IP:
+	case LBMD_PI_CSUM_CRC16_T10DIF:
+		return 8;
+	case LBMD_PI_CSUM_CRC64_NVME:
+		return 16;
+	default:
+		return -EINVAL;
+	}
+}
+
+static enum blk_integrity_checksum ublk_integrity_csum_type(u8 csum_type)
+{
+	switch (csum_type) {
+	case LBMD_PI_CSUM_NONE:
+		return BLK_INTEGRITY_CSUM_NONE;
+	case LBMD_PI_CSUM_IP:
+		return BLK_INTEGRITY_CSUM_IP;
+	case LBMD_PI_CSUM_CRC16_T10DIF:
+		return BLK_INTEGRITY_CSUM_CRC;
+	case LBMD_PI_CSUM_CRC64_NVME:
+		return BLK_INTEGRITY_CSUM_CRC64;
+	default:
+		WARN_ON_ONCE(1);
+		return BLK_INTEGRITY_CSUM_NONE;
+	}
+}
+
 static int ublk_validate_params(const struct ublk_device *ub)
 {
 	/* basic param is the only one which must be set */
 	if (ub->params.types & UBLK_PARAM_TYPE_BASIC) {
 		const struct ublk_param_basic *p = &ub->params.basic;
@@ -690,10 +740,33 @@ static int ublk_validate_params(const struct ublk_device *ub)
 			return -EINVAL;
 		if (p->max_segment_size < UBLK_MIN_SEGMENT_SIZE)
 			return -EINVAL;
 	}
 
+	if (ub->params.types & UBLK_PARAM_TYPE_INTEGRITY) {
+		const struct ublk_param_integrity *p = &ub->params.integrity;
+		int pi_tuple_size = ublk_integrity_pi_tuple_size(p->csum_type);
+		int flags = ublk_integrity_flags(p->flags);
+
+		if (!(ub->dev_info.flags & UBLK_F_INTEGRITY))
+			return -EINVAL;
+		if (flags < 0)
+			return flags;
+		if (pi_tuple_size < 0)
+			return pi_tuple_size;
+		if (!p->metadata_size)
+			return -EINVAL;
+		if (p->csum_type == LBMD_PI_CSUM_NONE &&
+		    (p->flags & LBMD_PI_CAP_REFTAG))
+			return -EINVAL;
+		if (p->pi_offset + pi_tuple_size > p->metadata_size)
+			return -EINVAL;
+		if (p->interval_exp < SECTOR_SHIFT ||
+		    p->interval_exp > ub->params.basic.logical_bs_shift)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
 static void ublk_apply_params(struct ublk_device *ub)
 {
@@ -2941,10 +3014,25 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		lim.seg_boundary_mask = ub->params.seg.seg_boundary_mask;
 		lim.max_segment_size = ub->params.seg.max_segment_size;
 		lim.max_segments = ub->params.seg.max_segments;
 	}
 
+	if (ub->params.types & UBLK_PARAM_TYPE_INTEGRITY) {
+		const struct ublk_param_integrity *p = &ub->params.integrity;
+		int pi_tuple_size = ublk_integrity_pi_tuple_size(p->csum_type);
+
+		lim.integrity = (struct blk_integrity) {
+			.flags = ublk_integrity_flags(p->flags),
+			.csum_type = ublk_integrity_csum_type(p->csum_type),
+			.metadata_size = p->metadata_size,
+			.pi_offset = p->pi_offset,
+			.interval_exp = p->interval_exp,
+			.tag_size = p->tag_size,
+			.pi_tuple_size = pi_tuple_size,
+		};
+	}
+
 	if (wait_for_completion_interruptible(&ub->completion) != 0)
 		return -EINTR;
 
 	if (ub->ublksrv_tgid != ublksrv_pid)
 		return -EINVAL;
@@ -3131,10 +3219,14 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 		if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
 					UBLK_F_AUTO_BUF_REG))
 			return -EINVAL;
 	}
 
+	/* User copy is required to access integrity buffer */
+	if (info.flags & UBLK_F_INTEGRITY && !(info.flags & UBLK_F_USER_COPY))
+		return -EINVAL;
+
 	/* the created device is always owned by current user */
 	ublk_store_owner_uid_gid(&info.owner_uid, &info.owner_gid);
 
 	if (header->dev_id != info.dev_id) {
 		pr_warn("%s: dev id not match %u %u\n",
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index ec77dabba45b..a54c47832fa2 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -309,10 +309,16 @@
  * the I/O's daemon task. The q_id and tag of the registered buffer are required
  * in UBLK_U_IO_UNREGISTER_IO_BUF's ublksrv_io_cmd.
  */
 #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
 
+/*
+ * ublk device supports requests with integrity/metadata buffer.
+ * Requires UBLK_F_USER_COPY.
+ */
+#define UBLK_F_INTEGRITY (1ULL << 16)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
 #define UBLK_S_DEV_QUIESCED	2
 #define UBLK_S_DEV_FAIL_IO 	3
@@ -598,10 +604,20 @@ struct ublk_param_segment {
 	__u32 	max_segment_size;
 	__u16 	max_segments;
 	__u8	pad[2];
 };
 
+struct ublk_param_integrity {
+	__u32	flags; /* LBMD_PI_CAP_* from linux/fs.h */
+	__u8	interval_exp;
+	__u8	metadata_size; /* UBLK_PARAM_TYPE_INTEGRITY requires nonzero */
+	__u8	pi_offset;
+	__u8	csum_type; /* LBMD_PI_CSUM_* from linux/fs.h */
+	__u8	tag_size;
+	__u8	pad[7];
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
 	 * SET_PARAMS and GET_PARAMS command, and driver may update len
 	 * if two sides use different version of 'ublk_params', same with
@@ -612,16 +628,18 @@ struct ublk_params {
 #define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
 #define UBLK_PARAM_TYPE_DEVT            (1 << 2)
 #define UBLK_PARAM_TYPE_ZONED           (1 << 3)
 #define UBLK_PARAM_TYPE_DMA_ALIGN       (1 << 4)
 #define UBLK_PARAM_TYPE_SEGMENT         (1 << 5)
+#define UBLK_PARAM_TYPE_INTEGRITY       (1 << 6) /* requires UBLK_F_INTEGRITY */
 	__u32	types;			/* types of parameter included */
 
 	struct ublk_param_basic		basic;
 	struct ublk_param_discard	discard;
 	struct ublk_param_devt		devt;
 	struct ublk_param_zoned	zoned;
 	struct ublk_param_dma_align	dma;
 	struct ublk_param_segment	seg;
+	struct ublk_param_integrity	integrity;
 };
 
 #endif
-- 
2.45.2


