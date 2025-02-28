Return-Path: <linux-kselftest+bounces-27921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E64A49E98
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A6016E7D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA7726FDAF;
	Fri, 28 Feb 2025 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GH0EUJP1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5147F26FD90
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759599; cv=none; b=Ng1JZIfd4f4Drg5chN25BTPgxMi3k0LwwlroNWGO8Qx6DZFDYXTlYMXwzarcE7RIAcJoJRFxY0NzoklonGS+fGZuYpNnHaZFcs8qlxVa/LsZL3PjwQPMir9Bl3oLOD5InO5MUjRyAXXW55HFKwY2pmsVYzbUsi7HfdfYIlaEyZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759599; c=relaxed/simple;
	bh=7nOqJ4e/tDjvOv4MHIu0d3TytFv3sz484oNR/skiKx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AG/GQj4Bts0OX78Ts8si3Stt2qioNT7NrC0StnJ8haPvQSNr7xotRO975ualuoZLwIIK5krDr2tysu18EEVxEl5ppTcWJUYC79GsG/kl+IrBStezslJqOHBCs+ckoAk0vBRAQG4BvtR2M1vT1Yj/McTjwv0Po2EaHo3s1zNXhpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GH0EUJP1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740759596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/hvQSDfuu7cSe0BGMI50uQWM+qngjTHYvkI7ZwwFTgA=;
	b=GH0EUJP1Q/HdZnzQN2aJwyrcV3StF/s+iwrvgyJlJtzpUcq9sfmW8SohFoxTj/OtNgQ1WZ
	nqGEN2l9HHlFqpTzoSMJnMGdQ5N+synFrdiqLu592KhrjnSXb3t3ho+bmatA/whburivgn
	wHdAwgDkYK0+6K7cotfex7yVfAeu8hQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-fdaAZOY3N_e0dLOXxuyGBA-1; Fri,
 28 Feb 2025 11:19:48 -0500
X-MC-Unique: fdaAZOY3N_e0dLOXxuyGBA-1
X-Mimecast-MFC-AGG-ID: fdaAZOY3N_e0dLOXxuyGBA_1740759587
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2DCC1800871;
	Fri, 28 Feb 2025 16:19:47 +0000 (UTC)
Received: from localhost (unknown [10.72.120.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7A0D18009AE;
	Fri, 28 Feb 2025 16:19:46 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 3/3] selftests: ublk: add ublk zero copy test
Date: Sat,  1 Mar 2025 00:19:16 +0800
Message-ID: <20250228161919.2869102-4-ming.lei@redhat.com>
In-Reply-To: <20250228161919.2869102-1-ming.lei@redhat.com>
References: <20250228161919.2869102-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Enable zero copy on file backed target, meantime add one fio test for
covering write verify, another test for mkfs/mount/umount.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile        |   2 +
 tools/testing/selftests/ublk/file_backed.c   | 104 +++++++++++++++----
 tools/testing/selftests/ublk/kublk.c         |  25 ++++-
 tools/testing/selftests/ublk/kublk.h         |  70 +++++++++++++
 tools/testing/selftests/ublk/test_common.sh  |   8 ++
 tools/testing/selftests/ublk/test_loop_03.sh |  33 ++++++
 tools/testing/selftests/ublk/test_loop_04.sh |  22 ++++
 7 files changed, 241 insertions(+), 23 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_loop_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_04.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 7815aaaefc25..555a3ba5b481 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -6,6 +6,8 @@ LDLIBS += -lpthread -lm -luring
 TEST_PROGS := test_null_01.sh
 TEST_PROGS += test_loop_01.sh
 TEST_PROGS += test_loop_02.sh
+TEST_PROGS += test_loop_03.sh
+TEST_PROGS += test_loop_04.sh
 
 TEST_GEN_PROGS_EXTENDED = kublk
 
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 64e0a37746eb..38e68b414962 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -54,48 +54,94 @@ static int backing_file_tgt_init(struct ublk_dev *dev)
 	return 0;
 }
 
+static enum io_uring_op ublk_to_uring_op(const struct ublksrv_io_desc *iod, int zc)
+{
+	unsigned ublk_op = ublksrv_get_op(iod);
+
+	if (ublk_op == UBLK_IO_OP_READ)
+		return zc ? IORING_OP_READ_FIXED : IORING_OP_READ;
+	else if (ublk_op == UBLK_IO_OP_WRITE)
+		return zc ? IORING_OP_WRITE_FIXED : IORING_OP_WRITE;
+	assert(0);
+}
+
+static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_desc *iod, int tag)
+{
+	int zc = ublk_queue_use_zc(q);
+	enum io_uring_op op = ublk_to_uring_op(iod, zc);
+	struct io_uring_sqe *reg;
+	struct io_uring_sqe *rw;
+	struct io_uring_sqe *ureg;
+
+	if (!zc) {
+		rw = ublk_queue_alloc_sqe(q);
+		if (!rw)
+			return -ENOMEM;
+
+		io_uring_prep_rw(op, rw, 1 /*fds[1]*/,
+				(void *)iod->addr,
+				iod->nr_sectors << 9,
+				iod->start_sector << 9);
+		io_uring_sqe_set_flags(rw, IOSQE_FIXED_FILE);
+		q->io_inflight++;
+		/* bit63 marks us as tgt io */
+		rw->user_data = build_user_data(tag, op, UBLK_IO_TGT_NORMAL, 1);
+		return 0;
+	}
+
+	ublk_queue_alloc_sqe3(q, &reg, &rw, &ureg);
+
+	io_uring_prep_buf_register(reg, 0, tag, q->q_id, tag);
+	reg->user_data = build_user_data(tag, 0xfe, 1, 1);
+	reg->flags |= IOSQE_CQE_SKIP_SUCCESS;
+	reg->flags |= IOSQE_IO_LINK;
+
+	io_uring_prep_rw(op, rw, 1 /*fds[1]*/, 0,
+		iod->nr_sectors << 9,
+		iod->start_sector << 9);
+	rw->buf_index = tag;
+	rw->flags |= IOSQE_FIXED_FILE;
+	rw->flags |= IOSQE_IO_LINK;
+	rw->user_data = build_user_data(tag, op, UBLK_IO_TGT_ZC_OP, 1);
+	q->io_inflight++;
+
+	io_uring_prep_buf_unregister(ureg, 0, tag, q->q_id, tag);
+	ureg->user_data = build_user_data(tag, 0xff, UBLK_IO_TGT_ZC_BUF, 1);
+	q->io_inflight++;
+
+	return 0;
+}
+
 static int loop_queue_tgt_io(struct ublk_queue *q, int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
-	struct io_uring_sqe *sqe = ublk_queue_alloc_sqe(q);
 	unsigned ublk_op = ublksrv_get_op(iod);
-
-	if (!sqe)
-		return -ENOMEM;
+	struct io_uring_sqe *sqe;
 
 	switch (ublk_op) {
 	case UBLK_IO_OP_FLUSH:
+		sqe = ublk_queue_alloc_sqe(q);
+		if (!sqe)
+			return -ENOMEM;
 		io_uring_prep_sync_file_range(sqe, 1 /*fds[1]*/,
 				iod->nr_sectors << 9,
 				iod->start_sector << 9,
 				IORING_FSYNC_DATASYNC);
 		io_uring_sqe_set_flags(sqe, IOSQE_FIXED_FILE);
+		q->io_inflight++;
+		sqe->user_data = build_user_data(tag, ublk_op, UBLK_IO_TGT_NORMAL, 1);
 		break;
 	case UBLK_IO_OP_WRITE_ZEROES:
 	case UBLK_IO_OP_DISCARD:
 		return -ENOTSUP;
 	case UBLK_IO_OP_READ:
-		io_uring_prep_read(sqe, 1 /*fds[1]*/,
-				(void *)iod->addr,
-				iod->nr_sectors << 9,
-				iod->start_sector << 9);
-		io_uring_sqe_set_flags(sqe, IOSQE_FIXED_FILE);
-		break;
 	case UBLK_IO_OP_WRITE:
-		io_uring_prep_write(sqe, 1 /*fds[1]*/,
-				(void *)iod->addr,
-				iod->nr_sectors << 9,
-				iod->start_sector << 9);
-		io_uring_sqe_set_flags(sqe, IOSQE_FIXED_FILE);
+		loop_queue_tgt_rw_io(q, iod, tag);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	q->io_inflight++;
-	/* bit63 marks us as tgt io */
-	sqe->user_data = build_user_data(tag, ublk_op, 0, 1);
-
 	ublk_dbg(UBLK_DBG_IO, "%s: tag %d ublk io %x %llx %u\n", __func__, tag,
 			iod->op_flags, iod->start_sector, iod->nr_sectors << 9);
 	return 1;
@@ -115,9 +161,22 @@ static void ublk_loop_io_done(struct ublk_queue *q, int tag,
 		const struct io_uring_cqe *cqe)
 {
 	int cqe_tag = user_data_to_tag(cqe->user_data);
+	unsigned tgt_data = user_data_to_tgt_data(cqe->user_data);
+	int res = cqe->res;
+
+	if (res < 0 || tgt_data == UBLK_IO_TGT_NORMAL)
+		goto complete;
 
+	if (tgt_data == UBLK_IO_TGT_ZC_OP) {
+		ublk_set_io_res(q, tag, cqe->res);
+		goto exit;
+	}
+	assert(tgt_data == UBLK_IO_TGT_ZC_BUF);
+	res = ublk_get_io_res(q, tag);
+complete:
 	assert(tag == cqe_tag);
-	ublk_complete_io(q, tag, cqe->res);
+	ublk_complete_io(q, tag, res);
+exit:
 	q->io_inflight--;
 }
 
@@ -126,7 +185,7 @@ static int ublk_loop_tgt_init(struct ublk_dev *dev)
 	unsigned long long bytes;
 	int ret;
 	struct ublk_params p = {
-		.types = UBLK_PARAM_TYPE_BASIC,
+		.types = UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DMA_ALIGN,
 		.basic = {
 			.logical_bs_shift	= 9,
 			.physical_bs_shift	= 12,
@@ -134,6 +193,9 @@ static int ublk_loop_tgt_init(struct ublk_dev *dev)
 			.io_min_shift	= 9,
 			.max_sectors = dev->dev_info.max_io_buf_bytes >> 9,
 		},
+		.dma = {
+			.alignment = 511,
+		},
 	};
 
 	assert(dev->tgt.nr_backing_files == 1);
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index f7b9ede17bb3..b65bdaf7e281 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -282,6 +282,8 @@ static void ublk_queue_deinit(struct ublk_queue *q)
 	int i;
 	int nr_ios = q->q_depth;
 
+	io_uring_unregister_buffers(&q->ring);
+
 	io_uring_unregister_ring_fd(&q->ring);
 
 	if (q->ring.ring_fd > 0) {
@@ -312,6 +314,11 @@ static int ublk_queue_init(struct ublk_queue *q)
 	q->cmd_inflight = 0;
 	q->tid = gettid();
 
+	if (dev->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY) {
+		q->state |= UBLKSRV_NO_BUF;
+		q->state |= UBLKSRV_ZC;
+	}
+
 	cmd_buf_size = ublk_queue_cmd_buf_sz(q);
 	off = UBLKSRV_CMD_BUF_OFFSET + q->q_id * ublk_queue_max_cmd_buf_sz();
 	q->io_cmd_buf = (char *)mmap(0, cmd_buf_size, PROT_READ,
@@ -346,6 +353,15 @@ static int ublk_queue_init(struct ublk_queue *q)
 		goto fail;
 	}
 
+	if (dev->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY) {
+		ret = io_uring_register_buffers_sparse(&q->ring, q->q_depth);
+		if (ret) {
+			ublk_err("ublk dev %d queue %d register spare buffers failed %d",
+					dev->dev_info.dev_id, q->q_id, ret);
+			goto fail;
+		}
+	}
+
 	io_uring_register_ring_fd(&q->ring);
 
 	ret = io_uring_register_files(&q->ring, dev->fds, dev->nr_fds);
@@ -502,9 +518,10 @@ static void ublk_handle_cqe(struct io_uring *r,
 		ublk_err("%s: res %d userdata %llx queue state %x\n", __func__,
 				cqe->res, cqe->user_data, q->state);
 
-	ublk_dbg(UBLK_DBG_IO_CMD, "%s: res %d (qid %d tag %u cmd_op %u target %d) stopping %d\n",
+	ublk_dbg(UBLK_DBG_IO_CMD, "%s: res %d (qid %d tag %u cmd_op %u target %d/%d) stopping %d\n",
 			__func__, cqe->res, q->q_id, tag, cmd_op,
 			is_target_io(cqe->user_data),
+			user_data_to_tgt_data(cqe->user_data),
 			(q->state & UBLKSRV_QUEUE_STOPPING));
 
 	/* Don't retrieve io in case of target io */
@@ -1022,6 +1039,7 @@ int main(int argc, char *argv[])
 		{ "depth",		1,	NULL, 'd' },
 		{ "debug_mask",		1,	NULL,  0  },
 		{ "quiet",		0,	NULL,  0  },
+		{ "zero_copy",          1,      NULL, 'z' },
 		{ 0, 0, 0, 0 }
 	};
 	int option_idx, opt;
@@ -1038,7 +1056,7 @@ int main(int argc, char *argv[])
 		return ret;
 
 	optind = 2;
-	while ((opt = getopt_long(argc, argv, "t:n:d:q:a",
+	while ((opt = getopt_long(argc, argv, "t:n:d:q:a:z",
 				  longopts, &option_idx)) != -1) {
 		switch (opt) {
 		case 'a':
@@ -1057,6 +1075,9 @@ int main(int argc, char *argv[])
 		case 'd':
 			ctx.queue_depth = strtol(optarg, NULL, 10);
 			break;
+		case 'z':
+			ctx.flags |= UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_USER_COPY;
+			break;
 		case 0:
 			if (!strcmp(longopts[option_idx].name, "debug_mask"))
 				ublk_dbg_mask = strtol(optarg, NULL, 16);
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index d71c6c3767a9..8e43aebf7dfc 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -42,6 +42,10 @@
 #define UBLK_MAX_QUEUES                 4
 #define UBLK_QUEUE_DEPTH                128
 
+#define UBLK_IO_TGT_NORMAL 		0
+#define UBLK_IO_TGT_ZC_BUF 		1
+#define UBLK_IO_TGT_ZC_OP 		2
+
 #define UBLK_DBG_DEV            (1U << 0)
 #define UBLK_DBG_QUEUE          (1U << 1)
 #define UBLK_DBG_IO_CMD         (1U << 2)
@@ -124,6 +128,7 @@ struct ublk_queue {
 #define UBLKSRV_QUEUE_STOPPING	(1U << 0)
 #define UBLKSRV_QUEUE_IDLE	(1U << 1)
 #define UBLKSRV_NO_BUF		(1U << 2)
+#define UBLKSRV_ZC		(1U << 3)
 	unsigned state;
 	pid_t tid;
 	pthread_t thread;
@@ -180,6 +185,11 @@ static inline unsigned int user_data_to_op(__u64 user_data)
 	return (user_data >> 16) & 0xff;
 }
 
+static inline unsigned int user_data_to_tgt_data(__u64 user_data)
+{
+	return (user_data >> 24) & 0xffff;
+}
+
 static inline void ublk_err(const char *fmt, ...)
 {
 	va_list ap;
@@ -217,11 +227,66 @@ static inline struct io_uring_sqe *ublk_queue_alloc_sqe(struct ublk_queue *q)
 	return io_uring_get_sqe(&q->ring);
 }
 
+static inline void ublk_queue_alloc_sqe3(struct ublk_queue *q,
+		struct io_uring_sqe **sqe1, struct io_uring_sqe **sqe2,
+		struct io_uring_sqe **sqe3)
+{
+	struct io_uring *r = &q->ring;
+	unsigned left = io_uring_sq_space_left(r);
+
+	if (left < 3)
+		io_uring_submit(r);
+
+	*sqe1 = io_uring_get_sqe(r);
+	*sqe2 = io_uring_get_sqe(r);
+	*sqe3 = io_uring_get_sqe(r);
+}
+
+static inline void io_uring_prep_buf_register(struct io_uring_sqe *sqe,
+		int dev_fd, int tag, int q_id, __u64 index)
+{
+	struct ublksrv_io_cmd *cmd = (struct ublksrv_io_cmd *)sqe->cmd;
+
+	io_uring_prep_read(sqe, dev_fd, 0, 0, 0);
+	sqe->opcode		= IORING_OP_URING_CMD;
+	sqe->flags		|= IOSQE_FIXED_FILE;
+	sqe->cmd_op		= UBLK_U_IO_REGISTER_IO_BUF;
+
+	cmd->tag		= tag;
+	cmd->addr		= index;
+	cmd->q_id		= q_id;
+}
+
+static inline void io_uring_prep_buf_unregister(struct io_uring_sqe *sqe,
+		int dev_fd, int tag, int q_id, __u64 index)
+{
+	struct ublksrv_io_cmd *cmd = (struct ublksrv_io_cmd *)sqe->cmd;
+
+	io_uring_prep_read(sqe, dev_fd, 0, 0, 0);
+	sqe->opcode		= IORING_OP_URING_CMD;
+	sqe->flags		|= IOSQE_FIXED_FILE;
+	sqe->cmd_op		= UBLK_U_IO_UNREGISTER_IO_BUF;
+
+	cmd->tag		= tag;
+	cmd->addr		= index;
+	cmd->q_id		= q_id;
+}
+
 static inline void *ublk_get_sqe_cmd(const struct io_uring_sqe *sqe)
 {
 	return (void *)&sqe->cmd;
 }
 
+static inline void ublk_set_io_res(struct ublk_queue *q, int tag, int res)
+{
+	q->ios[tag].result = res;
+}
+
+static inline int ublk_get_io_res(const struct ublk_queue *q, unsigned tag)
+{
+	return q->ios[tag].result;
+}
+
 static inline void ublk_mark_io_done(struct ublk_io *io, int res)
 {
 	io->flags |= (UBLKSRV_NEED_COMMIT_RQ_COMP | UBLKSRV_IO_FREE);
@@ -250,6 +315,11 @@ static inline int ublk_complete_io(struct ublk_queue *q, unsigned tag, int res)
 	return ublk_queue_io_cmd(q, io, tag);
 }
 
+static inline int ublk_queue_use_zc(const struct ublk_queue *q)
+{
+	return q->state & UBLKSRV_ZC;
+}
+
 extern const struct ublk_tgt_ops null_tgt_ops;
 extern const struct ublk_tgt_ops loop_tgt_ops;
 
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index ad40c1511f41..304f22ffda58 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -102,4 +102,12 @@ _add_ublk_dev() {
 	echo ${dev_id}
 }
 
+_have_feature()
+{
+	if  $UBLK_PROG "features" | grep $1 > /dev/null 2>&1; then
+		return 0
+	fi
+	return 1
+}
+
 export UBLK_PROG=$(pwd)/kublk
diff --git a/tools/testing/selftests/ublk/test_loop_03.sh b/tools/testing/selftests/ublk/test_loop_03.sh
new file mode 100755
index 000000000000..e781ac6db6b4
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_loop_03.sh
@@ -0,0 +1,33 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. test_common.sh
+
+TID="loop_03"
+ERR_CODE=0
+
+_have_feature "ZERO_COPY" || exit 4
+
+_prep_test "loop" "write and verify over zero copy"
+
+backfile_0=`_create_backfile 256M`
+
+dev_id=`_add_ublk_dev -t loop $backfile_0 -z`
+
+# run fio over the ublk disk
+fio --name=write_and_verify \
+    --filename=/dev/ublkb${dev_id} \
+    --ioengine=libaio --iodepth=64 \
+    --rw=write \
+    --size=256M \
+    --direct=1 \
+    --verify=crc32c \
+    --do_verify=1 \
+    --bs=4k > /dev/null 2>&1
+ERR_CODE=$?
+
+_cleanup_test ${dev_id} "loop"
+
+_remove_backfile $backfile_0
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_04.sh b/tools/testing/selftests/ublk/test_loop_04.sh
new file mode 100755
index 000000000000..6ab67247c809
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_loop_04.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. test_common.sh
+
+TID="loop_04"
+ERR_CODE=0
+
+_prep_test "loop" "mkfs & mount & umount with zero copy"
+
+backfile_0=`_create_backfile 256M`
+
+dev_id=`_add_ublk_dev -t loop -z $backfile_0`
+
+_mkfs_mount_test /dev/ublkb${dev_id}
+ERR_CODE=$?
+
+_cleanup_test ${dev_id} "loop"
+
+_remove_backfile $backfile_0
+
+_show_result $TID $ERR_CODE
-- 
2.47.0


