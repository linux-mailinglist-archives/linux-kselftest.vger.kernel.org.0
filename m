Return-Path: <linux-kselftest+bounces-48479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D3206D02287
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 11:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 285573007C16
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 10:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBF242AC95;
	Thu,  8 Jan 2026 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MkaV3Y+5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B6C42A10B
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864010; cv=none; b=AO+prVITaXwQdVsP6flridLn8z3DjCHQMV/4qqtbYfEjMP7qIX+kB20hEEna9PcoXIYiRhz4JfodzgTrwNDfRl+SCzN432tb+K8SYwoZW2TCuK9VaPDboYmiWpm3iE4HDa+fvysvZB1XOfvIfLBzm/P7caYuRY4sEudsQE/3vEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864010; c=relaxed/simple;
	bh=1aDaPI2v4Zeo3O7crQSGBiyCnNWXJlIc6pmuFCCIr2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9qMVOjKFXh5p6NX8A60SPLKlD4EmfiallSNvCcJuThUhtEuhyMictbvyUI2bJyBwUp/YEiWsiJTtWaxrM9Wu1SqdIL72jP3jEV5tmttyT398q1yjKWoHkSdg7QSL7eK1M8Y7x7unFsXcWCUvOUX0lEEkWZnXyY4/pRM87cwGz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MkaV3Y+5; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a31d7107faso2152735ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863998; x=1768468798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaTLRDW4Ok0YQzJQSdBnJS8VxZrTaE64GOqPLwd4Ilc=;
        b=MkaV3Y+53v5MSqIJ18b/X+HkU+ZUsCyvrP+tJLpAEDJaNnJ8dIv/Dwwr2E9pkl0HSp
         xx3OIIkflJbJYuNugqmNeylb8mfIAFHqsxGUxMypZ9hurizBOXOBCQVvcVHLuqYBqBNx
         eiMDXVeBTMFMX5kujBQBk7xBjyxx5+ghIi7TfbGC8+6PXL4SwYSHyW3YRI1J6OX+dxyy
         BdWBz0G/QZiB3j+ecgtX5TtUTa+z/FvgiW7nrrrK0vWmTCkQm94eXLdZVSwCXyic8Ozd
         wS1jLUkse8u7GFTeMq78QcJOkIji2JZbGlR5vD6z3KB0OqCNzNEW8qQE6s7EnCuywsXv
         keRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863998; x=1768468798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UaTLRDW4Ok0YQzJQSdBnJS8VxZrTaE64GOqPLwd4Ilc=;
        b=Dl+YrgMNQF2RfHn3ZQ9zt2OYRXv0xi5hkf114VYKHi1zvajz9MU4MUSo3cfqn9Du/6
         TqPXild8ENUrsyGdr1flU7RMpaNdI08wBz2Xrsz2JgdtOVcd6gmoQCs8PgbOM0iaGSoN
         CkGivVkcF9lk070vGLjSkQgEkgxuiPJvtucezKgsSU1KAcJdFV4EJMTEc0ehYtJighyb
         nbbq3chTF7j/+Qq1WEeLLFSPu5CEuaO1zA/SEOfaw6quKcXCPfHwaxr4rQ8DN173vo4J
         5LXpQGr3QPKAjE75/L87v5K5zAJRyeJMLdprbWrSVI5ZmIIu8bLJj5H30ijqafaIHKXc
         ZXyw==
X-Forwarded-Encrypted: i=1; AJvYcCWC2ODG2WlJ4MAktQCB8xgpPcb8PvOZPZFLxAGo7IiCHvDZdFN5iz6MgaWf/lBs9GjcOID87dUU/mQ8W0OI7qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs56bcU7bqzW48aRHlf1ivbMAeLi2Gn04ZADwa/CJW2nWAkQbN
	7VVhKfB4hpsDXU9c+3z1Zbm3rjM7D+a222mgeHuNZGRsfHI/0HRSeAZWIT05P4gfSktuEJGchJW
	IlpeJ8WZr1Vye50tTq2LG1l1Bq3I8E+36XkbjBYgd7q1KPGHu14q5
X-Gm-Gg: AY/fxX4yyNONJlg91GNxDV2sMcGsZKkfndtq3WBdOzG6FOS1/feMllgm7LHjrMsD+vS
	eejXcBM27xCtBdJiW68xM8Vv3u5oOlPzdvWCdaclSufdvIrJQi8/gELZ0lP4kHEJK9QYrS2rmva
	6FVq8pY05RDdULm4yMUDGSdLeaSSdukr3l+4tjRZLsvWLtVLxvtED4wdt6yYkiuemNMZkhftibN
	RxZzBAaFCDQxqvLlYWmJA8av9G7670me7EtA2Pv6SBXlGQb9TlabmoZDdC9E+wMG1Vgvn+S3oVP
	WJDS53Mi909SRsw3N4/oJH7VrKw1PVIYJUPqoew4TZ4Lh1hhSwv79yEnkMDRIdtsL7irAMuWkKJ
	9to5C+Omh03L2ENSJV3KrMg5OCig=
X-Google-Smtp-Source: AGHT+IGYbi8ogzRt0rfT3w7cbk4NGI6oUYGnuR0yEq1AIRmedSlfeRJenAraivQu7TSxjwkdAacjLt1JQOC7
X-Received: by 2002:a17:902:ce03:b0:2a0:ccee:b356 with SMTP id d9443c01a7336-2a3ee4252f2mr39375565ad.1.1767863998032;
        Thu, 08 Jan 2026 01:19:58 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cc4ab4sm8606025ad.44.2026.01.08.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:58 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7767C34223B;
	Thu,  8 Jan 2026 02:19:57 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 72926E42F2C; Thu,  8 Jan 2026 02:19:57 -0700 (MST)
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
Subject: [PATCH v4 17/19] selftests: ublk: add integrity data support to loop target
Date: Thu,  8 Jan 2026 02:19:45 -0700
Message-ID: <20260108091948.1099139-18-csander@purestorage.com>
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

To perform and end-to-end test of integrity information through a ublk
device, we need to actually store it somewhere and retrieve it. Add this
support to kublk's loop target. It uses a second backing file for the
integrity data corresponding to the data stored in the first file.
The integrity file is initialized with byte 0xFF, which ensures the app
and reference tags are set to the "escape" pattern to disable the
bio-integrity-auto guard and reftag checks until the blocks are written.
The integrity file is opened without O_DIRECT since it will be accessed
at sub-block granularity. Each incoming read/write results in a pair of
reads/writes, one to the data file, and one to the integrity file. If
either backing I/O fails, the error is propagated to the ublk request.
If both backing I/Os read/write some bytes, the ublk request is
completed with the smaller of the number of blocks accessed by each I/O.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/file_backed.c | 92 +++++++++++++++++-----
 1 file changed, 74 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index db4c176a4f28..c3ce5ff72422 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -33,48 +33,62 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	unsigned ublk_op = ublksrv_get_op(iod);
 	unsigned zc = ublk_queue_use_zc(q);
 	unsigned auto_zc = ublk_queue_use_auto_zc(q);
 	enum io_uring_op op = ublk_to_uring_op(iod, zc | auto_zc);
 	struct ublk_io *io = ublk_get_io(q, tag);
+	__u64 offset = iod->start_sector << 9;
+	__u32 len = iod->nr_sectors << 9;
 	struct io_uring_sqe *sqe[3];
 	void *addr = io->buf_addr;
 
+	if (iod->op_flags & UBLK_IO_F_INTEGRITY) {
+		ublk_io_alloc_sqes(t, sqe, 1);
+		/* Use second backing file for integrity data */
+		io_uring_prep_rw(op, sqe[0], ublk_get_registered_fd(q, 2),
+				 io->integrity_buf,
+				 ublk_integrity_len(q, len),
+				 ublk_integrity_len(q, offset));
+		sqe[0]->flags = IOSQE_FIXED_FILE;
+		/* tgt_data = 1 indicates integrity I/O */
+		sqe[0]->user_data = build_user_data(tag, ublk_op, 1, q->q_id, 1);
+	}
+
 	if (!zc || auto_zc) {
 		ublk_io_alloc_sqes(t, sqe, 1);
 		if (!sqe[0])
 			return -ENOMEM;
 
 		io_uring_prep_rw(op, sqe[0], ublk_get_registered_fd(q, 1) /*fds[1]*/,
 				addr,
-				iod->nr_sectors << 9,
-				iod->start_sector << 9);
+				len,
+				offset);
 		if (auto_zc)
 			sqe[0]->buf_index = tag;
 		io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
 		/* bit63 marks us as tgt io */
 		sqe[0]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
-		return 1;
+		return !!(iod->op_flags & UBLK_IO_F_INTEGRITY) + 1;
 	}
 
 	ublk_io_alloc_sqes(t, sqe, 3);
 
 	io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, io->buf_index);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 	sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
 
 	io_uring_prep_rw(op, sqe[1], ublk_get_registered_fd(q, 1) /*fds[1]*/, 0,
-		iod->nr_sectors << 9,
-		iod->start_sector << 9);
+			len,
+			offset);
 	sqe[1]->buf_index = tag;
 	sqe[1]->flags |= IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
 	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 
 	io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, io->buf_index);
 	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
-	return 2;
+	return !!(iod->op_flags & UBLK_IO_F_INTEGRITY) + 2;
 }
 
 static int loop_queue_tgt_io(struct ublk_thread *t, struct ublk_queue *q, int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
@@ -117,29 +131,55 @@ static void ublk_loop_io_done(struct ublk_thread *t, struct ublk_queue *q,
 {
 	unsigned tag = user_data_to_tag(cqe->user_data);
 	unsigned op = user_data_to_op(cqe->user_data);
 	struct ublk_io *io = ublk_get_io(q, tag);
 
-	if (cqe->res < 0 || op != ublk_cmd_op_nr(UBLK_U_IO_UNREGISTER_IO_BUF)) {
-		if (!io->result)
-			io->result = cqe->res;
-		if (cqe->res < 0)
-			ublk_err("%s: io failed op %x user_data %lx\n",
-					__func__, op, cqe->user_data);
+	if (cqe->res < 0) {
+		io->result = cqe->res;
+		ublk_err("%s: io failed op %x user_data %lx\n",
+				__func__, op, cqe->user_data);
+	} else if (op != ublk_cmd_op_nr(UBLK_U_IO_UNREGISTER_IO_BUF)) {
+		__s32 data_len = user_data_to_tgt_data(cqe->user_data)
+			? ublk_integrity_data_len(q, cqe->res)
+			: cqe->res;
+
+		if (!io->result || data_len < io->result)
+			io->result = data_len;
 	}
 
 	/* buffer register op is IOSQE_CQE_SKIP_SUCCESS */
 	if (op == ublk_cmd_op_nr(UBLK_U_IO_REGISTER_IO_BUF))
 		io->tgt_ios += 1;
 
 	if (ublk_completed_tgt_io(t, q, tag))
 		ublk_complete_io(t, q, tag, io->result);
 }
 
+static int ublk_loop_memset_file(int fd, __u8 byte, size_t len)
+{
+	off_t offset = 0;
+	__u8 buf[4096];
+
+	memset(buf, byte, sizeof(buf));
+	while (len) {
+		int ret = pwrite(fd, buf, min(len, sizeof(buf)), offset);
+
+		if (ret < 0)
+			return -errno;
+		if (!ret)
+			return -EIO;
+
+		len -= ret;
+		offset += ret;
+	}
+	return 0;
+}
+
 static int ublk_loop_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 {
 	unsigned long long bytes;
+	unsigned long blocks;
 	int ret;
 	struct ublk_params p = {
 		.types = UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DMA_ALIGN,
 		.basic = {
 			.attrs = UBLK_ATTR_VOLATILE_CACHE,
@@ -152,27 +192,43 @@ static int ublk_loop_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		.dma = {
 			.alignment = 511,
 		},
 	};
 
+	ublk_set_integrity_params(ctx, &p);
 	if (ctx->auto_zc_fallback) {
 		ublk_err("%s: not support auto_zc_fallback\n", __func__);
 		return -EINVAL;
 	}
-	if (ctx->metadata_size) {
-		ublk_err("%s: integrity not supported\n", __func__);
-		return -EINVAL;
-	}
 
+	/* Use O_DIRECT only for data file */
 	ret = backing_file_tgt_init(dev, 1);
 	if (ret)
 		return ret;
 
-	if (dev->tgt.nr_backing_files != 1)
+	/* Expect a second file for integrity data */
+	if (dev->tgt.nr_backing_files != 1 + !!ctx->metadata_size)
 		return -EINVAL;
 
-	bytes = dev->tgt.backing_file_size[0];
+	blocks = dev->tgt.backing_file_size[0] >> p.basic.logical_bs_shift;
+	if (ctx->metadata_size) {
+		unsigned long metadata_blocks =
+			dev->tgt.backing_file_size[1] / ctx->metadata_size;
+		unsigned long integrity_len;
+
+		/* Ensure both data and integrity data fit in backing files */
+		blocks = min(blocks, metadata_blocks);
+		integrity_len = blocks * ctx->metadata_size;
+		/*
+		 * Initialize PI app tag and ref tag to 0xFF
+		 * to disable bio-integrity-auto checks
+		 */
+		ret = ublk_loop_memset_file(dev->fds[2], 0xFF, integrity_len);
+		if (ret)
+			return ret;
+	}
+	bytes = blocks << p.basic.logical_bs_shift;
 	dev->tgt.dev_size = bytes;
 	p.basic.dev_sectors = bytes >> 9;
 	dev->tgt.params = p;
 
 	return 0;
-- 
2.45.2


