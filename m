Return-Path: <linux-kselftest+bounces-48254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CECCF6259
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6CB9300E624
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88096223702;
	Tue,  6 Jan 2026 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EviorJaS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8580520296E
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661099; cv=none; b=hcE3QXYmFp9Z85OsJarvABAf8Xbm+TKe+sMkPKCIKe7WfrG0rfRJJcvCnFbXcwb1BVd8kObwqRdP17JYyhcwwVsFDEh7+iZKKuTLqr9Pj66hGwDs1TaZmrP+dHU80+f5SesHJJw0Cx1GHOklUEZjSbu74r+yEg+Gq/oQLH9ozhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661099; c=relaxed/simple;
	bh=IPYY2wbBuXA+AcMOcnbpgxkjyrfpEhzCMqJgIVN4z+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqo8kRiQUKtJq7/oI0tz9Y3Ce0xh8zBjYbuvCs+xqjJ+WZNWAfmCIuabo3KqdZrmJkHsPbJpN6VYDsW5/OoD5xwKeWKkZA94TtsB3EoWu+63S0JoJ4/Eoo14cUrWOyaWD+SFwsjkclnpS8XUe2XcEfdbP9a6Hw0RKcRs2hTI+hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EviorJaS; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a08cb5e30eso1067895ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661091; x=1768265891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NX8hqML+byNHp2sVVzUNGB3O5iFG2jebjBWHWIKuGfk=;
        b=EviorJaSbL4AWfTneOLYMoSIrOz0z7EMnJPw6SJcjJC5EpAd+4bRaB9Y1q4cBCCykj
         osM0fGrJYN1ASX2jZDUmfNg1hPy9xYi02IPpYTVreVUtgp1YdLlSE2fjKccROqNOg5uS
         KDcBfR8nvd868+yyJ0qtHiMTbYqaaBNAi6ZhszYOcraKqxKyipiBJIIy9bR8MazRntZa
         k1wMpDMkz3Z/8wG0uaxK4Hs+1QyGAHVyK+bWL3oUwAEMPdJ1GYuFjLm+nR914Z77nutV
         tvijYXmkdAcfy6Ko2XnncHzTYwTV6HbbFSyEx8vayiwcBapiFIYndp02jS8MQvdmxViD
         heRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661091; x=1768265891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NX8hqML+byNHp2sVVzUNGB3O5iFG2jebjBWHWIKuGfk=;
        b=H1RSVWwMCrM/ScM1BkGyG9GHB7HaPl/wGlcBfM85i9qBcES9WmbXd4H++HawbYVkoV
         BE/5keF4B2N7DAdhybj/Bhb8y19a7qSkMsPH9Rk/AF58WpMUak4BQhz4jC8h8qIpD9Ft
         TgSjocjutj5Y/Kju8AaWULmJ/jt7R6ErOkDUNLZHlDJVZ4lEuOzIt/x7fJojxkDfELaN
         urV4OAfEmvYzTNN1K8phNXblR8pxd+Yw1eQu3yaIQLLxXDysGOhcVZbYoatNlPhCfBp5
         cq9cWRxG7JeE2uFxw05QImQbVOCSc60Iqtp6uPoc+J+UupRk6c26ZC9phi7+vSEDiM9x
         ru3g==
X-Forwarded-Encrypted: i=1; AJvYcCUMpfl6uXNlxKeb4bwhlfOku1RI6QNs0sNHS6xhVdxzHhWqQZPTNeY8yqRIlhffEPM3mC61ChcBYnm6feqCglo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9nk13nB7Wg9k+/N1SzuUc9chVasKSl6GceFJUcsuCOb5zmMQy
	t3QnopYrBc5JyrNblkddgGi/BShmZyi3bbRJP2ip9ltkZHtjTzAwwzcErnfhSWc5QK6NxUu/pJ+
	ioKRAWkxAnNuQwQiLRODIt/NCcCUJCBFKV833UnCgmErYt1SW3+Oc
X-Gm-Gg: AY/fxX4mCB0WQmqgGRVU2ichZ62jQJYz6nUzOSZCjb+Zqt4UTwLf2acFPm1DKjNkaHE
	lRXUtQ1Pzb+l/V++GXYCT01kNZO3qp0xA9b1TTNskKoOcsQtd4BJ6Uz2A+ll4OFF+uM3FhTVZSM
	OaiIzF20Q0VRcE8g/Lju17Q7Kd3bVaR61E0gJk8tGZDhzvARoisZS6EvlWILZ8suY8SNP6TRI1M
	kV7OZfXZSUyVCf9cyR5xc1tcEt4VSo6FA/DKrG4EM/oK0bzZt+VhAuCj1V2fWXxcyW9zFPIr7r4
	CMmM5W2uMzaTARip2CyPdiDQEvAoTiTFxFXg0XASoqstHj99NcEcw8V883LAWKc1bHsi4keTEIQ
	uRxBYWhjks98Alyf9kqUilZJz33k=
X-Google-Smtp-Source: AGHT+IGlHpEYfGJHu8asvierliF9q40rmYqcq5c54pYGpogElQsRG/6gDNPISUZ0Zx29y2klQIH9vI5bX7Hv
X-Received: by 2002:a17:902:e743:b0:29f:2df2:cf49 with SMTP id d9443c01a7336-2a3e2df4b5cmr8812695ad.5.1767661091023;
        Mon, 05 Jan 2026 16:58:11 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3c3bd5bsm841955ad.13.2026.01.05.16.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:11 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9852F341D2E;
	Mon,  5 Jan 2026 17:58:10 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 89D8BE44554; Mon,  5 Jan 2026 17:58:10 -0700 (MST)
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
Subject: [PATCH v3 14/19] selftests: ublk: add kublk support for integrity params
Date: Mon,  5 Jan 2026 17:57:46 -0700
Message-ID: <20260106005752.3784925-15-csander@purestorage.com>
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


