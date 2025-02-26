Return-Path: <linux-kselftest+bounces-27577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF7DA457E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 09:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C8F16CCB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 08:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F34238174;
	Wed, 26 Feb 2025 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3bAOhPV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83A258CFE
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557533; cv=none; b=K4UCdMOLAdTVReGAHJoFX7vZypwE1FsNIyvu0RmQgMKtYAN20R9y/Uie7J1jV5retq2TaLgNlI6zaDX817dHMoVbZV5U9I4UiHPaJQsdnDhxHFQfb8382gK7J3zk9x5AwiQ+lU9Arn28XgQeAGOm7kKN30reWcU5qV/5t4b20tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557533; c=relaxed/simple;
	bh=KTQIcVpG+NvfwQfhbtVzOMZKF2q7yNxpO1mVF8ji1DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEC6XG5gV/RXteyO35kqvUeIFo221H8m60jGI9JCYliIqaUOKfbuzjdcS5eabzFvaFIMm0UO1cVM0Kw5YILDrqKf53Hsjo4uNkbOqSpWnkMaO11zii0zY24dQpRExJ+PFMcd+h/UD0VC3NkHmTQjD+f30KpS4TMkSuUGzm9g/KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3bAOhPV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740557529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcGJD7CDhevqM+sIhpXzjXEtXXGpGS6WC5Mdc4raiFA=;
	b=a3bAOhPVYbmPYA5zkNG2QLoKnLgjrisMlLboQv4SjSoHnpJdAZQi2BfUocBrEFtKyXZjeA
	HtRj4r15X6Dzm1TeYmqrQNVWrVnPuuXYLaTvG41WWmx2Ufn71O3FgX1uj51lXv77L0P5SK
	4nsg2yGaViMZqIH6/gmtByDScZWt5B8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-MSMt3qQzMSKHJYh1_oJVBQ-1; Wed,
 26 Feb 2025 03:12:05 -0500
X-MC-Unique: MSMt3qQzMSKHJYh1_oJVBQ-1
X-Mimecast-MFC-AGG-ID: MSMt3qQzMSKHJYh1_oJVBQ_1740557524
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8C6219560AF;
	Wed, 26 Feb 2025 08:12:03 +0000 (UTC)
Received: from localhost (unknown [10.72.120.27])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0FFA1955BD4;
	Wed, 26 Feb 2025 08:12:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] selftests: ublk: add ublk zero copy test
Date: Wed, 26 Feb 2025 16:11:34 +0800
Message-ID: <20250226081136.2410001-4-ming.lei@redhat.com>
In-Reply-To: <20250226081136.2410001-1-ming.lei@redhat.com>
References: <20250226081136.2410001-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add selftests for covering ublk zero copy feature.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile        |   1 +
 tools/testing/selftests/ublk/kublk.c         | 204 +++++++++++++++++--
 tools/testing/selftests/ublk/test_common.sh  |   8 +
 tools/testing/selftests/ublk/test_loop_03.sh |  32 +++
 4 files changed, 223 insertions(+), 22 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_loop_03.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 270d2bbe232b..7cd4c8b0db4e 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -6,6 +6,7 @@ LDLIBS += -lpthread -lm -luring
 TEST_PROGS := test_null_01.sh
 TEST_PROGS += test_loop_01.sh
 TEST_PROGS += test_loop_02.sh
+TEST_PROGS += test_loop_03.sh
 
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS_EXTENDED = kublk
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index e2469bf225e2..093130c599b4 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -42,6 +42,10 @@
 #define UBLK_MAX_QUEUES                 4
 #define UBLK_QUEUE_DEPTH                128
 
+#define UBLK_IO_TGT_NORMAL       0
+#define UBLK_IO_TGT_ZC_BUF       1
+#define UBLK_IO_TGT_ZC_OP        2
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
 static void ublk_err(const char *fmt, ...)
 {
 	va_list ap;
@@ -212,6 +222,16 @@ static inline void *ublk_get_sqe_cmd(const struct io_uring_sqe *sqe)
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
@@ -488,6 +508,11 @@ static int ublk_queue_cmd_buf_sz(struct ublk_queue *q)
 	return __ublk_queue_cmd_buf_sz(q->q_depth);
 }
 
+static int ublk_queue_use_zc(const struct ublk_queue *q)
+{
+	return q->state & UBLKSRV_ZC;
+}
+
 static void ublk_queue_deinit(struct ublk_queue *q)
 {
 	int i;
@@ -523,6 +548,11 @@ static int ublk_queue_init(struct ublk_queue *q)
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
@@ -557,6 +587,15 @@ static int ublk_queue_init(struct ublk_queue *q)
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
@@ -717,9 +756,10 @@ static void ublk_handle_cqe(struct io_uring *r,
 		!(q->state & UBLKSRV_QUEUE_STOPPING);
 	struct ublk_io *io;
 
-	ublk_dbg(UBLK_DBG_IO_CMD, "%s: res %d (qid %d tag %u cmd_op %u target %d) stopping %d\n",
+	ublk_dbg(UBLK_DBG_IO_CMD, "%s: res %d (qid %d tag %u cmd_op %u target %d/%d) stopping %d\n",
 			__func__, cqe->res, q->q_id, tag, cmd_op,
 			is_target_io(cqe->user_data),
+			user_data_to_tgt_data(cqe->user_data),
 			(q->state & UBLKSRV_QUEUE_STOPPING));
 
 	/* Don't retrieve io in case of target io */
@@ -1229,6 +1269,61 @@ static int cmd_dev_help(char *exe)
 
 /****************** part 2: target implementation ********************/
 
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
+static struct io_uring_sqe *ublk_queue_alloc_sqe(struct ublk_queue *q)
+{
+	unsigned left = io_uring_sq_space_left(&q->ring);
+
+	if (left < 1)
+		io_uring_submit(&q->ring);
+	return io_uring_get_sqe(&q->ring);
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
+
 static int ublk_null_tgt_init(struct ublk_dev *dev)
 {
 	const struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
@@ -1310,48 +1405,96 @@ static int backing_file_tgt_init(struct ublk_dev *dev)
 	return 0;
 }
 
+static enum io_uring_op ublk_to_uring_op(const struct ublksrv_io_desc *iod, int zc)
+{
+	unsigned ublk_op = ublksrv_get_op(iod);
+
+	if (ublk_op == UBLK_IO_OP_READ)
+		return zc ? IORING_OP_READ_FIXED: IORING_OP_READ;
+	else if (ublk_op == UBLK_IO_OP_WRITE)
+		return zc ? IORING_OP_WRITE_FIXED: IORING_OP_WRITE;
+	else
+		assert(0);
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
-	struct io_uring_sqe *sqe = io_uring_get_sqe(&q->ring);
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
+		/* bit63 marks us as tgt io */
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
@@ -1371,9 +1514,22 @@ static void ublk_loop_io_done(struct ublk_queue *q, int tag,
 		const struct io_uring_cqe *cqe)
 {
 	int cqe_tag = user_data_to_tag(cqe->user_data);
+	unsigned tgt_data = user_data_to_tgt_data(cqe->user_data);
+	int res = cqe->res;
+
+	if (tgt_data == UBLK_IO_TGT_NORMAL)
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
 
@@ -1444,6 +1600,7 @@ int main(int argc, char *argv[])
 		{ "depth",		1,	NULL, 'd' },
 		{ "debug_mask",		1,	NULL,  0  },
 		{ "quiet",		0,	NULL,  0  },
+		{ "zero_copy",          1,      NULL, 'z' },
 		{ 0, 0, 0, 0 }
 	};
 	int option_idx, opt;
@@ -1460,7 +1617,7 @@ int main(int argc, char *argv[])
 		return ret;
 
 	optind = 2;
-	while ((opt = getopt_long(argc, argv, "t:n:d:q:a",
+	while ((opt = getopt_long(argc, argv, "t:n:d:q:a:z",
 				  longopts, &option_idx)) != -1) {
 		switch (opt) {
 		case 'a':
@@ -1479,6 +1636,9 @@ int main(int argc, char *argv[])
 		case 'd':
 			ctx.queue_depth = strtol(optarg, NULL, 10);
 			break;
+		case 'z':
+			ctx.flags |= UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_USER_COPY;
+			break;
 		case 0:
 			if (!strcmp(longopts[option_idx].name, "debug_mask"))
 				ublk_dbg_mask = strtol(optarg, NULL, 16);
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 2b894c7a8e2e..711538a2cbf5 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -101,4 +101,12 @@ _add_ublk_dev() {
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
index 000000000000..3aa98fe5137b
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_loop_03.sh
@@ -0,0 +1,32 @@
+#!/bin/bash
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
-- 
2.47.0


