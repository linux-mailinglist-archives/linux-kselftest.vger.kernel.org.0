Return-Path: <linux-kselftest+bounces-47639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2924BCC60EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 06:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16B25303A094
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 05:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C795F29992A;
	Wed, 17 Dec 2025 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Er87W86U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260AD23FC5A
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949717; cv=none; b=Y2FvY0UvKKRSkp6HPcUL0K2Ry9jWfwGXgpGeFLvuYSrUvEu28pnNRyi5HnLCpf/gw2ZbYkPWaJo6YedBTxxwTdN27ZUFP/Ij6tvDH/jtWz/mYkostWJiJ0jdDKUzFs+fVgKY5e23cByhteR4VZ8TleJiHasDZqcCbWonpcarp5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949717; c=relaxed/simple;
	bh=OOXWaan+k6PBqwTEL0czF4iDFHJndZaTqnCQr/uI6ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TncY70XSImDMBUOspqVaMLYfcgLsvOFfn57lx5VHr4olOqE8A+ui5KNg2s0qCrmhEim0wJ7IYhvkeyGc5L/1S+ZZA5Ncsd1PIJ3KhdlSVJPGwIDjYZhYcR2GQelqN5DcRq0X87RhvXvmNRrBo1q49hG3c/YepUOboxlugwlx63s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Er87W86U; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a110548f10so5594735ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 21:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949713; x=1766554513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zznngbs4m93+ngp43rYp7bEDz3TrzVx/RV2H/1Phn2Q=;
        b=Er87W86UM8z/X9zbNW7fYHRB+B2bN4VCWKFhHAqLHrDcYU00NbhkixN+n0nFJ9oXNh
         2ZiMEXDTi6/L8ileOqOOD1yyltgTdoRtHkJbI7K9Yse/YrYATUcy1Og8ODu68AkTPV0H
         A3/LZegmaPeUUIiNSVKHR4l7wxM/yZ5xbHGvQoWFqyM39lRAeydP2wczlEAM/m3zDygz
         13oCx3b0uH26EtPU6+81lSaDOuJoeP1rH3O5gWXeZnC9doYqFdAEnElQUd4SXz2SojEL
         QL6Y7jk+c3xqvAJPK3GYbGIEv+NwQod8LP4rUBXL7PMS2yC8esKNbufHjseFZ601alPo
         tDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949713; x=1766554513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zznngbs4m93+ngp43rYp7bEDz3TrzVx/RV2H/1Phn2Q=;
        b=H5MWitplhxDmhQCq7dK5QEtUuEplwwAbSZ1ZhHviPVUcumFjdacMOu6xcBJ1MEIzjw
         dGN5vyC5pnCZPaVAslGdyrk4+fcWn4/IX3lbyxNPr+H44kvkc0r3tGISyzcnT5oTdXex
         OKG4ZDlzgSuykIZBf3d0d4hXCAey6RJeqNRXqpw1PFFmnBrOUALR8XkBfyY8uMu7zFcH
         V8jRyCAC1vPgX4eUriwa8WFB13kzIXWkulOOhDcP2lFCXi+eHY4kiSwEJuipOn2qy2gT
         B8SFPhzrWfWLI1bkcaKHRh1a/hFCxYxFw4sMvxuw5y/lp8IZ3E2twVcum55ZW3s6tDqp
         dhaA==
X-Forwarded-Encrypted: i=1; AJvYcCU3EPiZ16qDSkUkYoAIhh0yui9q8Ew5FLwIeLSJ/BTOnHfls3JbDWsDF+gFY3o6X9RiPcYtECWkAKlg1Mlv5uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJEI6nnChjeM9GiQOrTfEtKFzx6SS+zqY6KQsJZ5hSvjsCmtWk
	eSXwZGwXKf7WgA1F3zPlrRJBuH8qaVK2cFBtlVn7mauS2x1ulHw7cG5ZffZnt3Ss5U5HTiVS7Bi
	dH+YAXvPDuDkf2hCToa3aKE2BL13YAcaTh9AK
X-Gm-Gg: AY/fxX5Vwkv9G2EeA7dtoaTRNjiQmbhy7MmXXJp+LjbSZJt9ghFUvFBBi3/26ZmgY7c
	66NKnNH0aa5ZM0W9rnBme6xSfdoOvjp9q8BUTlGibtALqm/XHx6/6njXA8Jan0TELX+Ax7+YDPW
	FwMdV7Bvruq6dhcM5/Wl7b857ecqSzg2cdVo8Lj6m8GTMuaUepgmnl5L6eiAhU0ZOSqdXwm8O6R
	bZ58SJ9ew74YArvG3oXaWP9wo3EWS2oi7eopqQWYXhLCPv2kPBywkzwN33U3ygfiCq5tUUfx8YV
	lsviwofDaTh4xTS1EmiTw5MlnF8n2mJh8/RcnVF5ff9TcN6OkonpAsucPUh4uE2vImwd71fs9oQ
	5GJMt00VWPucjkRjF6BQD6jaZgmCZ652+tFD65Juk2A==
X-Google-Smtp-Source: AGHT+IFIoOpuRg1q9EuTG0Nc8t8lYQNrZq3x8IAXv8KiSuUg/NK/XNf2ZmAO0r6Gx/3SMpY6lnMAk35MnOeS
X-Received: by 2002:a05:7301:d0a:b0:2ae:5b8c:324a with SMTP id 5a478bee46e88-2ae5b8c395emr709246eec.4.1765949712622;
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2ac3c13d622sm2020103eec.0.2025.12.16.21.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0EC2A342237;
	Tue, 16 Dec 2025 22:35:12 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 0CA87E41A08; Tue, 16 Dec 2025 22:35:12 -0700 (MST)
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
Subject: [PATCH 06/20] ublk: support UBLK_PARAM_TYPE_INTEGRITY in device creation
Date: Tue, 16 Dec 2025 22:34:40 -0700
Message-ID: <20251217053455.281509-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Zhang <stazhang@purestorage.com>

If the UBLK_PARAM_TYPE_INTEGRITY flag is set, validate the integrity
parameters and apply them to the blk_integrity limits.
UBLK_PARAM_TYPE_INTEGRITY requires CONFIG_BLK_DEV_INTEGRITY=y,
UBLK_F_USER_COPY, and metadata_size > 0. Reuse the block metadata ioctl
LBMD_PI_CAP_* and LBMD_PI_CSUM_* constants from the linux/fs.h UAPI
header for the flags and csum_type field values.
The struct ublk_param_integrity validations are based on the checks in
blk_validate_integrity_limits(). Any invalid parameters should be
rejected before being applied to struct blk_integrity.

Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
[csander: add param validation]
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 92 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4da5d8ff1e1d..2893a9172220 100644
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
@@ -613,10 +616,57 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
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
@@ -675,10 +725,35 @@ static int ublk_validate_params(const struct ublk_device *ub)
 			return -EINVAL;
 		if (p->max_segment_size < UBLK_MIN_SEGMENT_SIZE)
 			return -EINVAL;
 	}
 
+	if (ub->params.types & UBLK_PARAM_TYPE_INTEGRITY) {
+		const struct ublk_param_integrity *p = &ub->params.integrity;
+		int pi_tuple_size = ublk_integrity_pi_tuple_size(p->csum_type);
+		int flags = ublk_integrity_flags(p->flags);
+
+		if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
+			return -EINVAL;
+		if (!ublk_dev_support_user_copy(ub))
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
@@ -2901,10 +2976,25 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
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
-- 
2.45.2


