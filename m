Return-Path: <linux-kselftest+bounces-48487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF325D01D3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 10:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 767DF3019BD0
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 09:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E282242A59C;
	Thu,  8 Jan 2026 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="adsC1LLB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14E642A599
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864015; cv=none; b=Ppog3+B//Ktux3tDS6OM5nUAla8Xhbt3jyybjwEOYMoWkgAovFu2q+NyFcvqHB0jYHg13Y0cQ3Sl5GSKkZ2PABX+iIYmsF1V9UMZV+gf0DHCvmEIEC614demgcBo+6edf1E1NevIORCk9cfOBbDtYoC0Vi8XhNTzpwnZQcCskak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864015; c=relaxed/simple;
	bh=xgtyTxMZAaL9bjES1PaZTg5hebA/tNgiXa+iVHKOXrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFlESsR9fgkGywQ00VEf2tXZGByABzGRr4HbnFY6vSk2vhTWE2ghQvQqESsWH2LyOzGp7qEoBUfxhBiqvIuErcPWoNFA7zIeKBOGVXe7OJTZnVb3lDdydFBHVVJiyV3sd2et6Zo/pq1hfmtkNIdcltVabUzz/lcmWEZ14Hi+FX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=adsC1LLB; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a3051bc432so2656705ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863998; x=1768468798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kN/zF2F9cM5nMNj7XE1NnSYPJWB5JTkF02bVLuO6a9M=;
        b=adsC1LLB/Q/kpUEjHcw+W/aXNysLn52Pvt6sln60NT69V2sgAn2xGf9qikLcROa10r
         3RNLKhhttWTQ4v/hAAw1MZIq9xdOqP4ez1g4Yw2DL+28FvBbWX3kgxE3LAIu043KMo9Z
         oJQM+Pei7ku2uRAlkB7uvj25tGSfsnsVl7XvNkGbytMeEvazkGIE+6wbSkuNEhc4i/d3
         3Kk7Uz7+zzTInL3nV03WZ27fQMfUH2lv55ZhyceapU3tX2k9QrdHPRIlPkSWctE5NTEh
         zRA+4rilPTMnR6bdHI8W7hJ9R1DN82PBHgAT9C8EnFdlCE4zfy1bqacSC+n/d4qxmWiK
         ENzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863998; x=1768468798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kN/zF2F9cM5nMNj7XE1NnSYPJWB5JTkF02bVLuO6a9M=;
        b=mzvN7RNNS1WWjDKKdvY0x61mjF3RHBfeAg3Qn3p99deh4txQv2kzdxnqLmkir2dOtC
         pN5AtwfuDtFVCx9KVeW12201U4axgCSlL/355emiBpaiGG6zLWfFS1bnIKyA9oK11K0a
         PkAXcH+5laBIcIqn1MBi37p1AX3i3pZLSLEGjDZS2M8v5NEWSZOZ+TSGKiyq6ZHt7CJB
         GvvduLMXDPvJrKJ5dMHsfJUfamNfly6BrVjRxtA4/PjdojozRP7opJ8rXKSdNI2CfiST
         5v7U384CncHSsDELclVtrbM2Ma8tZpgG3gDlRBFVvSyX8I1XDg8BzPDbFZjhY3EjHnUy
         sXLw==
X-Forwarded-Encrypted: i=1; AJvYcCVfkqBW8XZfkZsffXX/nTSNV2z0wVlc4BNoCBJ3k8jyG1usIFNSlhTr7Lj+aOSid+ccip0t37kkX4Q0wSfS11Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzge71toRjeka84WTm9AMF5yPgm7F5AdLIiFmsW0bSk09yp075r
	YJztmxZw30Mx1EXcbayaGsoWAuNE2a3zDkh5nSHHeDHnDR8tUBfyeMhoIa9W6VARf1XOxn5nOIq
	gWCGH2sqRBSTHik1lLqe4V1tkme1d+9cV1YJf
X-Gm-Gg: AY/fxX68aj5mez1Jwq4wNnSy9UyGwfaRzZpXv1poDwmwUl+XKN+dsjY9EfzcX1PdPxu
	rEHAoINXH2wbchAEp4q8CenwyOsH1gqfJRUm/NZSgllcn4GzycDbp+vqOvqqlU2OCxOnh3FHNq+
	iuFqi0kpCO85arGNo0mBDAqfH96bjHnQ9K7r8gV6QRcxr+nbJxBmhlmUF1P3nCDpSRsTy7Svbxw
	N7u7/HsrEawMNB8AHRxzf6lvMtoLwfgI/mCIebI4jxjAkPZ+mPRJUvU4dn1gMFhRT3j/CHBdeDG
	uVOncqMtJDZRWGAhrZrXQOhoUanWPBp9MrmyOx9RMt4s42C6hpCJW5TRWTeU5ML1k8R5ltFf8XD
	peR/YpAvDGQt4XWCCG27XXzzCJQl3bvooATJ1bO438w==
X-Google-Smtp-Source: AGHT+IHQQkRqvfAKHBQgsu1wvJxxV6F/ICuG/z10KRJvZVXEgx1lCKlR4l/oITOrYacaeYrtlKP5LOIiajI8
X-Received: by 2002:a17:902:ce92:b0:2a0:8963:c13e with SMTP id d9443c01a7336-2a3ee4a834amr38900105ad.7.1767863997617;
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cc4c12sm8483385ad.45.2026.01.08.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0EB2B342224;
	Thu,  8 Jan 2026 02:19:57 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 09A46E42F2C; Thu,  8 Jan 2026 02:19:57 -0700 (MST)
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
Subject: [PATCH v4 14/19] selftests: ublk: add kublk support for integrity params
Date: Thu,  8 Jan 2026 02:19:42 -0700
Message-ID: <20260108091948.1099139-15-csander@purestorage.com>
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

Add integrity param command line arguments to kublk. Plumb these to
struct ublk_params for the null and fault_inject targets, as they don't
need to actually read or write the integrity data. Forbid the integrity
params for loop or stripe until the integrity data copy is implemented.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/fault_inject.c |  1 +
 tools/testing/selftests/ublk/file_backed.c  |  4 ++
 tools/testing/selftests/ublk/kublk.c        | 47 +++++++++++++++++++++
 tools/testing/selftests/ublk/kublk.h        | 21 +++++++++
 tools/testing/selftests/ublk/null.c         |  1 +
 tools/testing/selftests/ublk/stripe.c       |  4 ++
 6 files changed, 78 insertions(+)

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
index 261095f19c93..48e1865b4875 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1,10 +1,11 @@
 /* SPDX-License-Identifier: MIT */
 /*
  * Description: uring_cmd based ublk
  */
 
+#include <linux/fs.h>
 #include "kublk.h"
 
 #define MAX_NR_TGT_ARG 	64
 
 unsigned int ublk_dbg_mask = UBLK_LOG;
@@ -1548,10 +1549,12 @@ static void __cmd_create_help(char *exe, bool recovery)
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
@@ -1611,20 +1614,27 @@ int main(int argc, char *argv[])
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
@@ -1695,10 +1705,32 @@ int main(int argc, char *argv[])
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
@@ -1737,10 +1769,25 @@ int main(int argc, char *argv[])
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


