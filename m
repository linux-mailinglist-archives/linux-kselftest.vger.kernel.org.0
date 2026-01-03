Return-Path: <linux-kselftest+bounces-48103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B55DACEF974
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 01:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCBD43023532
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 00:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63D2275114;
	Sat,  3 Jan 2026 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VMa2pHWY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA002517AC
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Jan 2026 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401144; cv=none; b=GcO0Gmoq2AI+IPzDzTpmwhhz3d4nk21Gh3SVklrhgqM0HmfJWL+gAawjZSNlNe6oqva/FjSO90E26vU0P1EyFfysEqTODnHDUa+6JHJQVVPXRsAEXF3sdKDv+J4vU4f5XqjRi7epWSS1IuOhFl8h3Tk8DPmfKETI2cxjrQ8FWDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401144; c=relaxed/simple;
	bh=IPYY2wbBuXA+AcMOcnbpgxkjyrfpEhzCMqJgIVN4z+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3VPcIzPsoXGlIFoLQiUFtZQMzzlCVgMi+6MArko+xvyZMqrM3GErb/Qrlt0AabIiq+o+2n4S/KwlgjjYI8nSK9xoAQBWOx/BhT1JOpeT3DT/Peg59TPsoso4knm88rHbSSIyi/lNWyoTfhviEeFVqEgSzK+ALnsyEup5n5JR/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VMa2pHWY; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a0a8c2e822so32806345ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 16:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401136; x=1768005936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NX8hqML+byNHp2sVVzUNGB3O5iFG2jebjBWHWIKuGfk=;
        b=VMa2pHWYJ/53JYvsbEUFjJFCmyVeDe/IaCD5kfgi6oOJgUywj0WOXUuve+Jhpca7HE
         hXbBhs6URsmCNjZSW/fVB2uW3jwQEc2v7fgm4O/tRrD2fby/WKmN1+anWotpg4YdSPtB
         EMRIs0opsPswtgEFVSUy1l49OUs2tFGxPgmAtKphJjFDHwChGSfP70o6U3L+Ak1ADPt3
         YMK9cU8/pIpsUHxvjpsqHlprQJoSLkG5x71m0S/mFX4MWTqW4fZYdQQYdZ6mmaQXoaX5
         OhcAbFR7uUMjySMsw6RmaTZ/+bDen9ZD/K113JsGPSdFLtom+dwMoAB9yIHWi+s/UieN
         SL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401136; x=1768005936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NX8hqML+byNHp2sVVzUNGB3O5iFG2jebjBWHWIKuGfk=;
        b=v0//H0QDXQElxsMCONorve+M4sG3wAp1E9DBdzQHn7d8yJ7uigGvvfSJyTdxX9ZyPh
         SIa4jYBVMH8wGGa0quW22U+vnBLTs8ge8zhm38eVRd5XLepeu5wnkFX8DJgm4L5lT0wa
         EeN9stsU+/HJTFObqjUxGj29PujshuL/08/fP9QD9NDslwFahVw/LB/zQTKrPQmyZ/lV
         hFfP1GxNzk4osh857DLFqAqtgtdGsXQozmN7ehZw0A/NMW9VuqGjBIWgt9qMkeeTIkEq
         Ly//jkTT/hyu6NzCAUPGfYmSIu5IH8h/dSbUV62k+tFpemo+2k2UGGtNcbZa41EJXBHO
         Ixiw==
X-Forwarded-Encrypted: i=1; AJvYcCXUl77Ipi/UEC32RstOSxrTTA/T9nDuRGr7N1ZSgM2Rl5qhWZN1Elwzk3m4sr2l14VMFIt0prNT8kpc5HrGz+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBT26Cvw5cZiOpDNYoTx3BjeV82CAfdwfDlpuJ5jJPOemAIMy
	pGONVK8AuGE6l/GGTQhQ09HsVDB+kvKW6ro1xsxD+Bv9T3ihbQeCMIjKDW6AoB23lhSsadPSQl0
	bybynywkCBbZ3Twk9Meic7qvc929KoT68ZFNw
X-Gm-Gg: AY/fxX5BQEZKVYZ9kxOfzLvSVCtG2OpUm2eY+tIvZtCUhoXYFW81Jpb9R5FYKeLFB6K
	9ThmwV6J8y9wwroDHklSY5ZAKe0uKF6GmH19NfHkOWazhAob+MvYHPk/O2oDS5Et41I0rz/Kgff
	XPAkRhJxzCQWH+QcUixDRyq7YGfkRpVT/uW1WPQAOwPZkp6LrFMzpC69ANQpEKr01bkgN2iExJa
	Ry1tsABN9F2GO7hria6WuB/CaB6231d4YMMDmEQwstfEDtHWOvMlu/E8adFrs5AV/j3H/srcwtL
	iL/5itK2Yd80gIU3fxFwEps3SEXTFoe8pkT5eOL6/44OQ7XtCgXWnkT4/m8wY19LsvpEqibekr0
	vw8ttBanJdtimA8OQpjEsOvSxpr55tVEoOuaHpb061g==
X-Google-Smtp-Source: AGHT+IGFp1rfzMZd54gQEwvR6JR/KMIfQSjHvp//5kWVIwoBUSWm6YqEABbH/jnQwcJteCU0TCgSQiFmBw9r
X-Received: by 2002:a05:6a20:486:b0:366:5c4a:c482 with SMTP id adf61e73a8af0-376aca60577mr30292837637.8.1767401135928;
        Fri, 02 Jan 2026 16:45:35 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c1e7bf52e1csm2459238a12.13.2026.01.02.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:35 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5E94E341D2E;
	Fri,  2 Jan 2026 17:45:35 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 55ADDE43D1D; Fri,  2 Jan 2026 17:45:34 -0700 (MST)
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
Subject: [PATCH v2 14/19] selftests: ublk: add kublk support for integrity params
Date: Fri,  2 Jan 2026 17:45:24 -0700
Message-ID: <20260103004529.1582405-15-csander@purestorage.com>
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

Add integrity param command line arguments to kublk. Plumb these to
struct ublk_params for the null and fault_inject targets, as they don't
need to actually read or write the integrity data. Forbid the integrity
params for loop or stripe until the integrity data copy is implemented.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/fault_inject.c |  1 +
 tools/testing/selftests/ublk/file_backed.c  |  4 ++
 tools/testing/selftests/ublk/kublk.c        | 48 +++++++++++++++++++++
 tools/testing/selftests/ublk/kublk.h        | 21 +++++++++
 tools/testing/selftests/ublk/null.c         |  1 +
 tools/testing/selftests/ublk/stripe.c       |  4 ++
 6 files changed, 79 insertions(+)

diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
index b227bd78b252..3b897f69c014 100644
--- a/tools/testing/selftests/ublk/fault_inject.c
+++ b/tools/testing/selftests/ublk/fault_inject.c
@@ -31,10 +31,11 @@ static int ublk_fault_inject_tgt_init(const struct dev_ctx *ctx,
 			.io_min_shift		= 9,
 			.max_sectors		= info->max_io_buf_bytes >> 9,
 			.dev_sectors		= dev_size >> 9,
 		},
 	};
+	ublk_set_integrity_params(ctx, &dev->tgt.params);
 
 	dev->private_data = (void *)(unsigned long)(ctx->fault_inject.delay_us * 1000);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 269d5f124e06..c14ce6608696 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -156,10 +156,14 @@ static int ublk_loop_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 
 	if (ctx->auto_zc_fallback) {
 		ublk_err("%s: not support auto_zc_fallback\n", __func__);
 		return -EINVAL;
 	}
+	if (ctx->metadata_size) {
+		ublk_err("%s: integrity not supported\n", __func__);
+		return -EINVAL;
+	}
 
 	ret = backing_file_tgt_init(dev);
 	if (ret)
 		return ret;
 
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 261095f19c93..6ff110d0dcae 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1,10 +1,12 @@
 /* SPDX-License-Identifier: MIT */
 /*
  * Description: uring_cmd based ublk
  */
 
+#include "linux/ublk_cmd.h"
+#include <linux/fs.h>
 #include "kublk.h"
 
 #define MAX_NR_TGT_ARG 	64
 
 unsigned int ublk_dbg_mask = UBLK_LOG;
@@ -1548,10 +1550,12 @@ static void __cmd_create_help(char *exe, bool recovery)
 	printf("%s %s -t [null|loop|stripe|fault_inject] [-q nr_queues] [-d depth] [-n dev_id]\n",
 			exe, recovery ? "recover" : "add");
 	printf("\t[--foreground] [--quiet] [-z] [--auto_zc] [--auto_zc_fallback] [--debug_mask mask] [-r 0|1] [-g] [-u]\n");
 	printf("\t[-e 0|1 ] [-i 0|1] [--no_ublk_fixed_fd]\n");
 	printf("\t[--nthreads threads] [--per_io_tasks]\n");
+	printf("\t[--integrity_capable] [--integrity_reftag] [--metadata_size SIZE] "
+		 "[--pi_offset OFFSET] [--csum_type ip|t10dif|nvme] [--tag_size SIZE]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
 	printf("\tdefault: nthreads=nr_queues");
 
 	for (i = 0; i < ARRAY_SIZE(tgt_ops_list); i++) {
@@ -1611,20 +1615,27 @@ int main(int argc, char *argv[])
 		{ "user_copy",		0,	NULL, 'u'},
 		{ "size",		1,	NULL, 's'},
 		{ "nthreads",		1,	NULL,  0 },
 		{ "per_io_tasks",	0,	NULL,  0 },
 		{ "no_ublk_fixed_fd",	0,	NULL,  0 },
+		{ "integrity_capable",	0,	NULL,  0 },
+		{ "integrity_reftag",	0,	NULL,  0 },
+		{ "metadata_size",	1,	NULL,  0 },
+		{ "pi_offset",		1,	NULL,  0 },
+		{ "csum_type",		1,	NULL,  0 },
+		{ "tag_size",		1,	NULL,  0 },
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
 	int option_idx, opt;
 	const char *cmd = argv[1];
 	struct dev_ctx ctx = {
 		.queue_depth	=	128,
 		.nr_hw_queues	=	2,
 		.dev_id		=	-1,
 		.tgt_type	=	"unknown",
+		.csum_type	=	LBMD_PI_CSUM_NONE,
 	};
 	int ret = -EINVAL, i;
 	int tgt_argc = 1;
 	char *tgt_argv[MAX_NR_TGT_ARG] = { NULL };
 	int value;
@@ -1695,10 +1706,32 @@ int main(int argc, char *argv[])
 				ctx.nthreads = strtol(optarg, NULL, 10);
 			if (!strcmp(longopts[option_idx].name, "per_io_tasks"))
 				ctx.per_io_tasks = 1;
 			if (!strcmp(longopts[option_idx].name, "no_ublk_fixed_fd"))
 				ctx.no_ublk_fixed_fd = 1;
+			if (!strcmp(longopts[option_idx].name, "integrity_capable"))
+				ctx.integrity_flags |= LBMD_PI_CAP_INTEGRITY;
+			if (!strcmp(longopts[option_idx].name, "integrity_reftag"))
+				ctx.integrity_flags |= LBMD_PI_CAP_REFTAG;
+			if (!strcmp(longopts[option_idx].name, "metadata_size"))
+				ctx.metadata_size = strtoul(optarg, NULL, 0);
+			if (!strcmp(longopts[option_idx].name, "pi_offset"))
+				ctx.pi_offset = strtoul(optarg, NULL, 0);
+			if (!strcmp(longopts[option_idx].name, "csum_type")) {
+				if (!strcmp(optarg, "ip")) {
+					ctx.csum_type = LBMD_PI_CSUM_IP;
+				} else if (!strcmp(optarg, "t10dif")) {
+					ctx.csum_type = LBMD_PI_CSUM_CRC16_T10DIF;
+				} else if (!strcmp(optarg, "nvme")) {
+					ctx.csum_type = LBMD_PI_CSUM_CRC64_NVME;
+				} else {
+					ublk_err("invalid csum_type: %s\n", optarg);
+					return -EINVAL;
+				}
+			}
+			if (!strcmp(longopts[option_idx].name, "tag_size"))
+				ctx.tag_size = strtoul(optarg, NULL, 0);
 			break;
 		case '?':
 			/*
 			 * target requires every option must have argument
 			 */
@@ -1737,10 +1770,25 @@ int main(int argc, char *argv[])
 	    ctx.auto_zc_fallback > 1) {
 		fprintf(stderr, "too many data copy modes specified\n");
 		return -EINVAL;
 	}
 
+	if (ctx.metadata_size) {
+		if (!(ctx.flags & UBLK_F_USER_COPY)) {
+			ublk_err("integrity requires user_copy\n");
+			return -EINVAL;
+		}
+
+		ctx.flags |= UBLK_F_INTEGRITY;
+	} else if (ctx.integrity_flags ||
+		   ctx.pi_offset ||
+		   ctx.csum_type != LBMD_PI_CSUM_NONE ||
+		   ctx.tag_size) {
+		ublk_err("integrity parameters require metadata_size\n");
+		return -EINVAL;
+	}
+
 	i = optind;
 	while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
 		ctx.files[ctx.nr_files++] = argv[i++];
 	}
 
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 8a83b90ec603..d00f2b465cdf 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -76,10 +76,15 @@ struct dev_ctx {
 	unsigned int	fg:1;
 	unsigned int	recovery:1;
 	unsigned int	auto_zc_fallback:1;
 	unsigned int	per_io_tasks:1;
 	unsigned int	no_ublk_fixed_fd:1;
+	__u32 integrity_flags;
+	__u8 metadata_size;
+	__u8 pi_offset;
+	__u8 csum_type;
+	__u8 tag_size;
 
 	int _evtfd;
 	int _shmid;
 
 	/* built from shmem, only for ublk_dump_dev() */
@@ -200,10 +205,26 @@ struct ublk_dev {
 	void *private_data;
 };
 
 extern int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io);
 
+static inline void ublk_set_integrity_params(const struct dev_ctx *ctx,
+					     struct ublk_params *params)
+{
+	if (!ctx->metadata_size)
+		return;
+
+	params->types |= UBLK_PARAM_TYPE_INTEGRITY;
+	params->integrity = (struct ublk_param_integrity) {
+		.flags = ctx->integrity_flags,
+		.interval_exp = params->basic.logical_bs_shift,
+		.metadata_size = ctx->metadata_size,
+		.pi_offset = ctx->pi_offset,
+		.csum_type = ctx->csum_type,
+		.tag_size = ctx->tag_size,
+	};
+}
 
 static inline int ublk_io_auto_zc_fallback(const struct ublksrv_io_desc *iod)
 {
 	return !!(iod->op_flags & UBLK_IO_F_NEED_REG_BUF);
 }
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index 280043f6b689..3aa162f08476 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -34,10 +34,11 @@ static int ublk_null_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 			.seg_boundary_mask 	= 4095,
 			.max_segment_size 	= 32 << 10,
 			.max_segments 		= 32,
 		},
 	};
+	ublk_set_integrity_params(ctx, &dev->tgt.params);
 
 	if (info->flags & UBLK_F_SUPPORT_ZERO_COPY)
 		dev->tgt.sq_depth = dev->tgt.cq_depth = 2 * info->queue_depth;
 	return 0;
 }
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index fd412e1f01c0..d4aaf3351d71 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -296,10 +296,14 @@ static int ublk_stripe_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 
 	if (ctx->auto_zc_fallback) {
 		ublk_err("%s: not support auto_zc_fallback\n", __func__);
 		return -EINVAL;
 	}
+	if (ctx->metadata_size) {
+		ublk_err("%s: integrity not supported\n", __func__);
+		return -EINVAL;
+	}
 
 	if ((chunk_size & (chunk_size - 1)) || !chunk_size) {
 		ublk_err("invalid chunk size %u\n", chunk_size);
 		return -EINVAL;
 	}
-- 
2.45.2


