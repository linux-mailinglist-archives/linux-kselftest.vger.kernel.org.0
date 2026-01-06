Return-Path: <linux-kselftest+bounces-48240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB63CF623E
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8729930376A5
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC2C2236FD;
	Tue,  6 Jan 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ipb2AIWr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116CC20E030
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661092; cv=none; b=fON8YaLds2TpxI3Bo65ira/00HT++ZlDAtjRpaowT8E2nZ0wHIqIybjHe1ctkIhWuMTcufl2yceRJuHmk2o0XAXG2kAA+Dv2YprOLPASkc9qCrptA8G+ZaiM7bkULlFjpPTraqtsWdyBex6L0ah4gfSLz7dYnR5hunuBRvU/t2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661092; c=relaxed/simple;
	bh=vAgs0Pbg91ZwroVZstdRfr4cppAGoD8cknKqmAiRQJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaLeVMGrfYAH0nPpHt2L+jTUcn/Cqf84DvNxD+2uGCGeHaGOVjt2M2ksFFSSFosJUVFW78q+S8r0wm5EIal0FLNp6p+fowhu8JpuJwRxUTXKQb5GkOZZFgW73e0rpLbr9fSLMhAdE6/eVtw47yxRRtjvo6FxWoHazaHMs2i5bTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ipb2AIWr; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a355c8b808so632785ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661089; x=1768265889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZFFOl+5oUis+ItVo8RVLDPXcu6iIOTPXjnS3koQ71I=;
        b=Ipb2AIWrC7ZPqccxfKWhnmmK/7mzMrDAXHD8KP9u9zO+1wIaUMhZHQ1P23UxPqjwEm
         AsxcBRI4J6+gpY7C0vsfKJxnqjY9lytb8MoD/hd23XbTDPwijpT4GbE8qLnsBvaqHokL
         IofI8HSAOqNXP65mnlSgOstNmT9Zp+a9txuWKmDw3x7/4os0e1YZ9D0SFeVtzcBvfVZs
         HnfEDVecY//pA3NzwcseYn3x/s8LGEttZ1pyhXLjZv+4DPiVBpqjA6tn0PLY4vSvQd62
         qZrLbrHYm2T+QBKYAnvBAxkgfbahCfnnpGrOUfFWyw4SNZVfxn8ekal5djHe+KbHcbrF
         CPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661089; x=1768265889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oZFFOl+5oUis+ItVo8RVLDPXcu6iIOTPXjnS3koQ71I=;
        b=n9an2Otr8Ax8/W2GR62FyYkH8ot40HfhR5io1gf1QDoHS7AvNugC3zEj7KiPQY/mCs
         TCBwJDvwJlMxGjq9efEYCBTiIKA5xqJss5cpZZzIxGbLmr5LZ7C5ds8F02VdMQo0qpom
         sF6YeOMNEty7T9dUhv8ApN2IJTv6v9T+KBnL3T5g/XPvMl0ZVeQCMzhskD1QyeXDrCU4
         eRtoi7ouvBYS/ZJ2TVvmFB86X5MJhr4SMHG8EV4eu043MofIYH78vz85OijsuLGCiNF6
         DTTK/pJs0CYcZ6B9YnuoMdLl3+HBkDhCsQE6I0oaSRFohw3cHsv2p16fMvxiLjjHcjcr
         bo0g==
X-Forwarded-Encrypted: i=1; AJvYcCXuSZzAgokzMpGG6qIa1ILA09TSP4wrBJp8sIzsONQxywL39bTVtdYRIth+tI/0aJSYLUiBi6TAis1jCC8/DF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc+cGWhxe1MXknQiwKhOF7A8VI6gAu7KGPCs1zGNDJ1OPn+m/v
	1XH1Y73PtUtWB2nRmAE7ZF0BdHYI56Fmvn98GurSD3L7Y+OeAWvbH5pzVWwoY555Uj+JsnJDpCl
	kPsS3PjDVqeexPZgB+nLkgRWrSzZwv1j1QxeEUNp2cNs82j2+dVbQ
X-Gm-Gg: AY/fxX7/gP1rrxWcN6Q+PZGNbvl4/pg1+OPpqEvqNY3oHyDoO+bl4riprdYj2nTihBA
	SBurMyuW0LuXcYCzBb5vsOD3kbs1aPTKJ9F4YR6kW/wVSVNczpFkuev0bQDhXJOMBBDp8v2Qy12
	meG1zwEtUD4msWSeCogT29X4BGCRZTMSMoi27LFtOGuK4XUWRnnFKieb8iyodswXXO0vQfGilZ/
	RhvCVPTe993aSzwgmbGIYfq6rh3JUf+a0iqjjcbkbaSxnExUhxcis/RlD44E2c8owxzKsUjRyuO
	0i+or6oTuUdCRYaWqlU1oYBYHPimI+H0eyPfufE60yjqysJvLqZTnQ3VY8Zj0nQDyWIrTYMOdh+
	FBp272CSgFEf9dIhov5ZKPtayLho=
X-Google-Smtp-Source: AGHT+IFrUOJtYfer73wwyB0WD+vhNOG/VCMgpU/0tt2EWkifRCz9w/wLALaEJb+5css8C4Uh0huvjZsoODA+
X-Received: by 2002:a17:902:e743:b0:29f:2df2:cf49 with SMTP id d9443c01a7336-2a3e2df4b5cmr8812195ad.5.1767661088943;
        Mon, 05 Jan 2026 16:58:08 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3c49d15sm873085ad.14.2026.01.05.16.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:08 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 49E4D340DAB;
	Mon,  5 Jan 2026 17:58:08 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 384A1E44554; Mon,  5 Jan 2026 17:58:08 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 03/19] ublk: support UBLK_PARAM_TYPE_INTEGRITY in device creation
Date: Mon,  5 Jan 2026 17:57:35 -0700
Message-ID: <20260106005752.3784925-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260106005752.3784925-1-csander@purestorage.com>
References: <20260106005752.3784925-1-csander@purestorage.com>
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
index 8e3da9b2b93a..066c6ae062a0 100644
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
+		    p->flags & LBMD_PI_CAP_REFTAG)
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


