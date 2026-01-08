Return-Path: <linux-kselftest+bounces-48481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE7DD020B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 11:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22831308E994
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 09:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC5C42AC9A;
	Thu,  8 Jan 2026 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZVYgPZqL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028542A595
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864011; cv=none; b=NQUZW2CYD+aDc0BW52HibLtHqgydJODnHggLTh8MLBdCeG8v5/yMLtM5ukzRkJhk6BEIzfsMvGWME278726pcHASijWAm1sOXRtptpnkmLS5q5anTQmJKa/+RkBfK7++QAifhclyfJ/kGMSu4yGPn2yJWh3PgZU+9e1fB1DT3Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864011; c=relaxed/simple;
	bh=1YUiZE9DU5V1hrRSlfFjaGipyAY5B04IHg4vpE+wq1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhIipp2O8z+H/kHwtzF1EElLkYkao/1nJACZ5IVbsxfTI3LCwHXQBkzlY2aXfngSnIUax/dh3vwXLd8U5PGeQdTaNsEEZp+vPNTi2JiTatjUeRFD/n5YTednhIkY6jLGTFwe5d1KrP5gA9TwTDqvelw1UiylfxNlEBp/8blHmvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZVYgPZqL; arc=none smtp.client-ip=74.125.82.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dl1-f99.google.com with SMTP id a92af1059eb24-12055b489e0so227526c88.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863996; x=1768468796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUdqZxPNG/dxsQ2jTx6CQeYv/8NBzY3PHz5WVrKVkRI=;
        b=ZVYgPZqLX3ehhBUmn/LZ3jTarX9k3lq7zU4J/YqPY79SyHq7gMu2778avEFCTHmkIF
         anbhwGqtYFAnDc8cPyWeFC+TXjFWIxn3pnEwFUlkGBeX0ReOvPle7lR84nqp780sceNm
         mkGLsGSKv7DkWagfq32grzbMYOq19L8r1JkVhRhAknDZ4exizWrwFftRx/b0SQ9tS91C
         9t8CZ2CrVuwx/ACz8idCHEF28F9VBwv2t8nN+u3GKHdbG1KhO9NHlYGDG3IlfU6nAs12
         fy/USdjtLImvt7JUts2iPIZ48R807GPxzsE/3d6VxJDcHFh0sq+Q8AW5xZ8RoXj36KzN
         KvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863996; x=1768468796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xUdqZxPNG/dxsQ2jTx6CQeYv/8NBzY3PHz5WVrKVkRI=;
        b=BPLAnYJppdj95FylsKJHWcKWEVEFS6Wm5PglrR25YLOpBT+ROxgSld6DNNod3yJrxc
         KcPfgJtq7PgMQLlCz83dN5Rg7De3fNSsOlQf1CfeSc8k3yPIqBuBsm0Z/L0tddzY5uqn
         yC98KqfyJGX+F43WhRZnKGQbXibIzCLTds5xk9ZVIoh4Unqmx1s4JpExerdG1LYLl1y3
         io42Nju3eU3jNGRIKp6rlUYpuDgJWXa+PPFnIaJxHuZCxak/g8XrVQBz6Ffa+1UVBF65
         NHMLFvRfaPtVwbVgb2KOdSJ5BmmguBYfUOS2b4z1MTiQ7TMtqJFRq893TP+3J4zDyE/Y
         PqMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/tiy/BXV7V80mYNeYVkUTPuEXQ4ZxtLdJUrc/nRXDcReb1KCj3ZAPcAXRHtJS/are1rot3eUDYpdbju/TJ4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPUWXfRGpQ2FeK2NjAMZMFXjFcqSfGrQUNOvz+AGTl0phK85IM
	kCXsv/vFI4C+OWKlq/Tj6/5opnf7CR64PwSSlVjLPoab3hG1bqwbNRsQaRoAnVj4fVZG1SA5f7b
	yoPhVRMtFCp0I8e0+KF2fuS92pYA+ES/H8qs1
X-Gm-Gg: AY/fxX6LM50kYzgEUmtb7EsXi9fFYXgY0rB7IX/jbAaiNsu3sH8Qa3E2zAVrVBOwD8s
	lCxPOr0EeV/s2VSjhf8lKntYZC3jqXm4SQ/+KuplwBB7AUKXrSlRQiraQwLfBDgY+iuCjmUPGGu
	anC87L0FDxDw5ZSewMCZeLljtmQF5TR++MXsRJuqQf9LjEwOrJFXTdIjYdtyoC5aKfy/aGwL7Qd
	GcEmfLkRgcyhzwxIkGwZfayCILS5MmarjnpRbXrx9RgRmwq36WZdnutbzoG8zoaU6ij9N8kQJos
	vMbUA4XdoWaS8lLbNs4tUQFon8jFoGb27aNfwg+oSYxi+ZMJ9QXOdINSGApJAnlrikyTZBLjdqu
	VxGo+FIeeSIrj7V6G0XKlAhWXlWc04XbrkLc2N3G/hA==
X-Google-Smtp-Source: AGHT+IHN8Chl16m6gs9Go7rWopGOSzZRPNx1u8wrS5rdJZP07Z15rR2vMP9r2rPgJ3o7t4QwcX/DtHhAq9BK
X-Received: by 2002:a05:7022:238b:b0:119:e56b:c3f1 with SMTP id a92af1059eb24-121f8af2df3mr2828476c88.1.1767863995880;
        Thu, 08 Jan 2026 01:19:55 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-121f243aca8sm1644426c88.2.2026.01.08.01.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:55 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6F22B342224;
	Thu,  8 Jan 2026 02:19:55 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 69B1FE42F2C; Thu,  8 Jan 2026 02:19:55 -0700 (MST)
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
Subject: [PATCH v4 03/19] ublk: support UBLK_PARAM_TYPE_INTEGRITY in device creation
Date: Thu,  8 Jan 2026 02:19:31 -0700
Message-ID: <20260108091948.1099139-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
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
 drivers/block/ublk_drv.c      | 101 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |  19 +++++++
 2 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8e3da9b2b93a..b91b2111f280 100644
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
@@ -313,10 +316,15 @@ static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
 static inline bool ublk_queue_is_zoned(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_ZONED;
 }
 
+static inline bool ublk_dev_support_integrity(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_INTEGRITY;
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 
 struct ublk_zoned_report_desc {
 	__u64 sector;
 	__u32 operation;
@@ -628,10 +636,57 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
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
@@ -690,10 +745,33 @@ static int ublk_validate_params(const struct ublk_device *ub)
 			return -EINVAL;
 		if (p->max_segment_size < UBLK_MIN_SEGMENT_SIZE)
 			return -EINVAL;
 	}
 
+	if (ub->params.types & UBLK_PARAM_TYPE_INTEGRITY) {
+		const struct ublk_param_integrity *p = &ub->params.integrity;
+		int pi_tuple_size = ublk_integrity_pi_tuple_size(p->csum_type);
+		int flags = ublk_integrity_flags(p->flags);
+
+		if (!ublk_dev_support_integrity(ub))
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
@@ -2941,10 +3019,27 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		lim.seg_boundary_mask = ub->params.seg.seg_boundary_mask;
 		lim.max_segment_size = ub->params.seg.max_segment_size;
 		lim.max_segments = ub->params.seg.max_segments;
 	}
 
+	if (ub->params.types & UBLK_PARAM_TYPE_INTEGRITY) {
+		const struct ublk_param_integrity *p = &ub->params.integrity;
+		int pi_tuple_size = ublk_integrity_pi_tuple_size(p->csum_type);
+
+		lim.max_integrity_segments =
+			p->max_integrity_segments ?: USHRT_MAX;
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
@@ -3131,10 +3226,14 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
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
index ec77dabba45b..4c141d7e4710 100644
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
@@ -598,10 +604,21 @@ struct ublk_param_segment {
 	__u32 	max_segment_size;
 	__u16 	max_segments;
 	__u8	pad[2];
 };
 
+struct ublk_param_integrity {
+	__u32	flags; /* LBMD_PI_CAP_* from linux/fs.h */
+	__u16	max_integrity_segments; /* 0 means no limit */
+	__u8	interval_exp;
+	__u8	metadata_size; /* UBLK_PARAM_TYPE_INTEGRITY requires nonzero */
+	__u8	pi_offset;
+	__u8	csum_type; /* LBMD_PI_CSUM_* from linux/fs.h */
+	__u8	tag_size;
+	__u8	pad[5];
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
 	 * SET_PARAMS and GET_PARAMS command, and driver may update len
 	 * if two sides use different version of 'ublk_params', same with
@@ -612,16 +629,18 @@ struct ublk_params {
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


