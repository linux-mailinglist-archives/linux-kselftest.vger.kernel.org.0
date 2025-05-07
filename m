Return-Path: <linux-kselftest+bounces-32617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A64AAEE18
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 23:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390D99E2860
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 21:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41F228D857;
	Wed,  7 May 2025 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DmRrc4TS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586A628B3F3
	for <linux-kselftest@vger.kernel.org>; Wed,  7 May 2025 21:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746654596; cv=none; b=DEVCHmQBajlnqLhHDjn2jqDO1b5WZSHlb4Q/A2dVXkgbdqbH8AVl/96szxKGuZ4LsGLA4+6A4ygRBkn/crQUEjOMYwpPaaP8ZZr7yvMwxSueE5nlOLsXCjYsvHIB4I63nPKM07dAy+OwqG7l5dIwodEiUvhdowMcVKMdbs64IDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746654596; c=relaxed/simple;
	bh=p82rtXEqtPAT//3mUAyzMdi5IlecWkE6T7u24BTBi98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kyq+AQ68NUXnr4w5oI4WYqJTpyuU7PP9Kx81UTxaFZrbOrbyZOnKNLpKi5UUeotfaPtDzCpLag5Fzfruqj0lmQRFQ0dDtpq/VWWWtdRj63WGWWAK2jApO0g1ZB3cQKytn2GhPJs2wNvq7kNh+pgDLr2KSEHXw+uiL0Vl1GoKYuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DmRrc4TS; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3d57143ee39so2244585ab.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 May 2025 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746654590; x=1747259390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMZ6sJ2kg+mvxYh4Fsbx3GouBX6X+YmBsl+sNdNc8p8=;
        b=DmRrc4TSubKxU/mDtVAVe+LoGN2wIu87uMMnV7L5z9a6IMbnqgtU1OmLKVg3eWpYs/
         8OUE4ZyOatEywi0JepipdChhWvXyBpHn7qGq4gHaXz22INpqBtrYj90NtLbMSRBY8X9r
         3W0fv+gXdUaf51PPYcsE5CjYn98tLkvQ4DMgrjKY0gIm0Wtpz/5Gp+I2DsPY6jzMgkAB
         6E8khaB39FWbbXSPd4953t285rzdi8COaeATvgHeaz00KsTLWXPImZaQI10a6NbIUG4/
         Ka3M0LbyspRkwN9IFZ811tl8peWol1pYXGyY0YQW5q5XIX7z3NltP+iOripf3jKr1PhC
         tVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746654590; x=1747259390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMZ6sJ2kg+mvxYh4Fsbx3GouBX6X+YmBsl+sNdNc8p8=;
        b=apzniPBK5R4G6yPw2GoeaC00ypxC+OHSnbwMegGWyiKkSuu4g4bRM2gGOV0/ofR+PH
         WagJuVI6oj0dBAUcYVC+5EVd0G6TPzmsxbbNqVUhJd9UTdRriI5bV/n3uYAV0GzeJYBh
         wUknyB3gU6mUZpi73iZxBimMELkLiujOfjybORGYZKEiRPO/fZbX9dJnsn8sLPCoxuaf
         O1F3zNpQRtDtPNY66KQgcDa+fmeUxF1zmTVoPgej02ps8IoPv0wP8qlOizzu5maClxq5
         QANDRUO/hsQJvQe0jFxelh18/KmxqmgUlnwGxSdgdRAFPeo/J1zoiO1I2xtmYL+UtnAH
         JQ0A==
X-Forwarded-Encrypted: i=1; AJvYcCWeAkKteVSKyDar/dbgLMCbH0Ui1j0K8ajHxMqEN55CKV730w8UDpaHSiak3fSHwepuGj2DpuY5bHFman281w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXgYixb5oDBkOJVxP+IxgqwQwTP4D3PPssNrworYnBeKEdfgc+
	gkWZVyKrb/q0ut+k4CmEBzZS2nEbDXG3qbUF9YNTDiwQuXG+TgsAY0FAzEEB/emGTiJ6QSncrIf
	YdX8vrk4ElXd9uH6JHfsiWTVFP/u8LE/X
X-Gm-Gg: ASbGncseymd9NGEP8LI/VV08e3DSvWpUJz5bB2xZlNVaCfDmBc3WJS2X8Ub3s3evij1
	fP7O8FJ8spRHbrM+DLxBiSqyF5nSmolBq1oXk7I0FTsW+5FcLVKtRAKPzgJyhxz0mjwgbwHQfvI
	jiVK3uPtbmIYDmNRMhlAQIpPsdqS4Ie56j11C8FIJ5Cf5URtaoWCiXx+9tR4Duss1F8R2NbD6zf
	tnvYPLjJ0t8rIoK4sTyEORAZnQ9tsNtr5pAIsVNPZxj8sbwGvHEltP+cP/xdPL8VgNJL3GSWUJ+
	wRuPkQNI1dri1AOgrTBIrgoHOc3QsWB4lletLaWwhvmM4Q==
X-Google-Smtp-Source: AGHT+IEIrnMvYN/ldmk1EUyNN2xejJyFNAxIvCJzEPLDb3UeyTRR71WckeP9/ye+RVFU+mgLpfYcMHL+P2WC
X-Received: by 2002:a92:c6cf:0:b0:3d4:3fbf:966e with SMTP id e9e14a558f8ab-3da7392cec4mr44384805ab.14.1746654590270;
        Wed, 07 May 2025 14:49:50 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3da7735ab8fsm807085ab.13.2025.05.07.14.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 14:49:50 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 61804340B8A;
	Wed,  7 May 2025 15:49:49 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 5CD40E40A46; Wed,  7 May 2025 15:49:49 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 07 May 2025 15:49:41 -0600
Subject: [PATCH v6 7/8] selftests: ublk: kublk: decouple ublk_queues from
 ublk server threads
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-ublk_task_per_io-v6-7-a2a298783c01@purestorage.com>
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
In-Reply-To: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Add support in kublk for decoupled ublk_queues and ublk server threads.
kublk now has two modes of operation:

- (preexisting mode) threads and queues are paired 1:1, and each thread
  services all the I/Os of one queue
- (new mode) thread and queue counts are independently configurable.
  threads service I/Os in a way that balances load across threads even
  if load is not balanced over queues. requires passing --round_robin

The new mode of operation is exercised by the new test_generic_08, which
issues I/O against a single queue and verifies that each of the 8 ublk
server threads handles exactly 1/8 of the total I/O count. Under the old
mode of operation (i.e. without --round_robin), all I/O goes to one ublk
server thread, and the test fails.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile              |  1 +
 tools/testing/selftests/ublk/file_backed.c         |  4 +-
 tools/testing/selftests/ublk/kublk.c               | 96 ++++++++++++++++++----
 tools/testing/selftests/ublk/kublk.h               |  3 +
 tools/testing/selftests/ublk/null.c                |  4 +-
 tools/testing/selftests/ublk/stripe.c              |  4 +-
 tools/testing/selftests/ublk/test_generic_08.sh    | 61 ++++++++++++++
 .../selftests/ublk/trace/count_ios_per_tid.bt      |  9 ++
 8 files changed, 160 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index e2e7b1e52a06252f626df5606221d17e3106d0d3..f8579019f0d1f9185df098440611c3b75087073b 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -14,6 +14,7 @@ TEST_PROGS += test_generic_04.sh
 TEST_PROGS += test_generic_05.sh
 TEST_PROGS += test_generic_06.sh
 TEST_PROGS += test_generic_07.sh
+TEST_PROGS += test_generic_08.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 563f11a21604bbf5b9531f69f806d09cdd785960..72e22f54f7fe60d26096ace4eb4001987fbe7b15 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -50,7 +50,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 
 	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 3);
 
-	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
+	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 	sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
@@ -62,7 +62,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 	sqe[1]->flags |= IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
 	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 
-	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, tag);
+	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
 	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
 	return 2;
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 313689f94cd6361a9a0f4b9257085b2a62bc8b8c..27046bb6a13b99879ad164ff8eaabeba57e17387 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -478,8 +478,11 @@ static int ublk_thread_init(struct ublk_thread *t)
 	}
 
 	if (dev->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY) {
+		unsigned nr_ios = dev->dev_info.queue_depth * dev->dev_info.nr_hw_queues;
+		unsigned max_nr_ios_per_thread = nr_ios / dev->nthreads;
+		max_nr_ios_per_thread += !!(nr_ios % dev->nthreads);
 		ret = io_uring_register_buffers_sparse(
-			&t->ring, dev->dev_info.queue_depth);
+			&t->ring, max_nr_ios_per_thread);
 		if (ret) {
 			ublk_err("ublk dev %d thread %d register spare buffers failed %d",
 					dev->dev_info.dev_id, t->idx, ret);
@@ -612,18 +615,42 @@ int ublk_queue_io_cmd(struct ublk_io *io)
 
 static void ublk_submit_fetch_commands(struct ublk_thread *t)
 {
-	/*
-	 * Service exclusively the queue whose q_id matches our thread
-	 * index. This may change in the future.
-	 */
-	struct ublk_queue *q = &t->dev->q[t->idx];
+	struct ublk_queue *q;
 	struct ublk_io *io;
-	int i = 0;
+	int i = 0, j = 0;
 
-	for (i = 0; i < q->q_depth; i++) {
-		io = &q->ios[i];
-		io->t = t;
-		ublk_queue_io_cmd(io);
+	if (t->dev->dev_info.flags & UBLK_F_RR_TAGS) {
+		/*
+		 * Lexicographically order all the (qid,tag) pairs, with
+		 * qid taking priority, and give this thread every Nth
+		 * entry, where N is the total number of threads. The
+		 * offset is controlled by the thread index. This takes
+		 * load which may be imbalanced across the queues and
+		 * balances it across the threads.
+		 */
+		const struct ublksrv_ctrl_dev_info *dinfo = &t->dev->dev_info;
+		int nr_ios = dinfo->nr_hw_queues * dinfo->queue_depth;
+		for (i = t->idx; i < nr_ios; i += t->dev->nthreads, j++) {
+			int q_id = i / dinfo->queue_depth;
+			int tag = i % dinfo->queue_depth;
+			q = &t->dev->q[q_id];
+			io = &q->ios[tag];
+			io->t = t;
+			io->buf_index = j;
+			ublk_queue_io_cmd(io);
+		}
+	} else {
+		/*
+		 * Service exclusively the queue whose q_id matches our
+		 * thread index.
+		 */
+		struct ublk_queue *q = &t->dev->q[t->idx];
+		for (i = 0; i < q->q_depth; i++) {
+			io = &q->ios[i];
+			io->t = t;
+			io->buf_index = i;
+			ublk_queue_io_cmd(io);
+		}
 	}
 }
 
@@ -778,7 +805,8 @@ static void *ublk_io_handler_fn(void *data)
 		return NULL;
 	}
 	/* IO perf is sensitive with queue pthread affinity on NUMA machine*/
-	ublk_thread_set_sched_affinity(t, info->affinity);
+	if (info->affinity)
+		ublk_thread_set_sched_affinity(t, info->affinity);
 	sem_post(info->ready);
 
 	ublk_dbg(UBLK_DBG_THREAD, "tid %d: ublk dev %d thread %u started\n",
@@ -844,7 +872,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 
 	ublk_dbg(UBLK_DBG_DEV, "%s enter\n", __func__);
 
-	tinfo = calloc(sizeof(struct ublk_thread_info), dinfo->nr_hw_queues);
+	tinfo = calloc(sizeof(struct ublk_thread_info), dev->nthreads);
 	if (!tinfo)
 		return -ENOMEM;
 
@@ -867,17 +895,24 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 				 dinfo->dev_id, i);
 			goto fail;
 		}
+	}
 
+	for (i = 0; i < dev->nthreads; i++) {
 		tinfo[i].dev = dev;
 		tinfo[i].idx = i;
 		tinfo[i].ready = &ready;
-		tinfo[i].affinity = &affinity_buf[i];
+		/*
+		 * If threads are not tied to queues, setting thread
+		 * affinity based on queue affinity makes no sense.
+		 */
+		if (!(dinfo->flags & UBLK_F_RR_TAGS))
+			tinfo[i].affinity = &affinity_buf[i];
 		pthread_create(&dev->threads[i].thread, NULL,
 				ublk_io_handler_fn,
 				&tinfo[i]);
 	}
 
-	for (i = 0; i < dinfo->nr_hw_queues; i++)
+	for (i = 0; i < dev->nthreads; i++)
 		sem_wait(&ready);
 	free(tinfo);
 	free(affinity_buf);
@@ -901,7 +936,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		ublk_send_dev_event(ctx, dev, dev->dev_info.dev_id);
 
 	/* wait until we are terminated */
-	for (i = 0; i < dinfo->nr_hw_queues; i++)
+	for (i = 0; i < dev->nthreads; i++)
 		pthread_join(dev->threads[i].thread, &thread_ret);
  fail:
 	for (i = 0; i < dinfo->nr_hw_queues; i++)
@@ -1011,6 +1046,7 @@ static int ublk_stop_io_daemon(const struct ublk_dev *dev)
 
 static int __cmd_dev_add(const struct dev_ctx *ctx)
 {
+	unsigned nthreads = ctx->nthreads;
 	unsigned nr_queues = ctx->nr_hw_queues;
 	const char *tgt_type = ctx->tgt_type;
 	unsigned depth = ctx->queue_depth;
@@ -1034,6 +1070,23 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 		return -EINVAL;
 	}
 
+	/* default to 1:1 threads:queues if nthreads is unspecified */
+	if (nthreads == -1)
+		nthreads = nr_queues;
+
+	if (nthreads > UBLK_MAX_THREADS) {
+		ublk_err("%s: %u is too many threads (max %u)\n",
+				__func__, nthreads, UBLK_MAX_THREADS);
+		return -EINVAL;
+	}
+
+	if (nthreads != nr_queues && !(ctx->flags & UBLK_F_RR_TAGS)) {
+		ublk_err("%s: threads %u must be same as queues %u if "
+			"not using round robin\n",
+			__func__, nthreads, nr_queues);
+		return -EINVAL;
+	}
+
 	dev = ublk_ctrl_init();
 	if (!dev) {
 		ublk_err("%s: can't alloc dev id %d, type %s\n",
@@ -1054,6 +1107,7 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 	info->nr_hw_queues = nr_queues;
 	info->queue_depth = depth;
 	info->flags = ctx->flags;
+	dev->nthreads = nthreads;
 	dev->tgt.ops = ops;
 	dev->tgt.sq_depth = depth;
 	dev->tgt.cq_depth = depth;
@@ -1249,6 +1303,7 @@ static int cmd_dev_get_features(void)
 		[const_ilog2(UBLK_F_USER_COPY)] = "USER_COPY",
 		[const_ilog2(UBLK_F_ZONED)] = "ZONED",
 		[const_ilog2(UBLK_F_USER_RECOVERY_FAIL_IO)] = "RECOVERY_FAIL_IO",
+		[const_ilog2(UBLK_F_RR_TAGS)] = "RR_TAGS",
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -1290,8 +1345,10 @@ static void __cmd_create_help(char *exe, bool recovery)
 			exe, recovery ? "recover" : "add");
 	printf("\t[--foreground] [--quiet] [-z] [--debug_mask mask] [-r 0|1 ] [-g]\n");
 	printf("\t[-e 0|1 ] [-i 0|1]\n");
+	printf("\t[--nthreads threads] [--round_robin]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
+	printf("\tdefault: nthreads=nr_queues");
 
 	for (i = 0; i < sizeof(tgt_ops_list) / sizeof(tgt_ops_list[0]); i++) {
 		const struct ublk_tgt_ops *ops = tgt_ops_list[i];
@@ -1343,6 +1400,8 @@ int main(int argc, char *argv[])
 		{ "recovery_fail_io",	1,	NULL, 'e'},
 		{ "recovery_reissue",	1,	NULL, 'i'},
 		{ "get_data",		1,	NULL, 'g'},
+		{ "nthreads",		1,	NULL,  0 },
+		{ "round_robin",	0,	NULL,  0 },
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1351,6 +1410,7 @@ int main(int argc, char *argv[])
 	struct dev_ctx ctx = {
 		.queue_depth	=	128,
 		.nr_hw_queues	=	2,
+		.nthreads	=	-1,
 		.dev_id		=	-1,
 		.tgt_type	=	"unknown",
 	};
@@ -1411,6 +1471,10 @@ int main(int argc, char *argv[])
 				ublk_dbg_mask = 0;
 			if (!strcmp(longopts[option_idx].name, "foreground"))
 				ctx.fg = 1;
+			if (!strcmp(longopts[option_idx].name, "nthreads"))
+				ctx.nthreads = strtol(optarg, NULL, 10);
+			if (!strcmp(longopts[option_idx].name, "round_robin"))
+				ctx.flags |= UBLK_F_RR_TAGS;
 			break;
 		case '?':
 			/*
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 9eb2207fcebe96d34488d057c881db262b9767b3..c51c01d8be43293fc0760f3b5ebac927afbc1fe3 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -80,6 +80,7 @@ struct dev_ctx {
 	char tgt_type[16];
 	unsigned long flags;
 	unsigned nr_hw_queues;
+	unsigned nthreads;
 	unsigned queue_depth;
 	int dev_id;
 	int nr_files;
@@ -125,6 +126,7 @@ struct ublk_io {
 	struct ublk_queue *q;
 	struct ublk_thread *t;
 	int tag;
+	int buf_index;
 
 	int result;
 
@@ -194,6 +196,7 @@ struct ublk_dev {
 	struct ublksrv_ctrl_dev_info  dev_info;
 	struct ublk_queue q[UBLK_MAX_QUEUES];
 	struct ublk_thread threads[UBLK_MAX_THREADS];
+	unsigned nthreads;
 
 	int fds[MAX_BACK_FILES + 1];	/* fds[0] points to /dev/ublkcN */
 	int nr_fds;
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index 7323fe61212f6041ef5a04758d30e62376ac9c6b..776da92306d8449b5b1ab89375ea4078a7948390 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -50,7 +50,7 @@ static int null_queue_zc_io(struct ublk_queue *q, int tag)
 
 	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 3);
 
-	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
+	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
 	sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
@@ -62,7 +62,7 @@ static int null_queue_zc_io(struct ublk_queue *q, int tag)
 	sqe[1]->len = iod->nr_sectors << 9; 	/* injected result */
 	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 
-	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, tag);
+	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
 	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
 	// buf register is marked as IOSQE_CQE_SKIP_SUCCESS
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index d569f62c9b7b5a6b9d82506c4aaab74b77a10305..4c87dc76712f18acd73834c87081a44fb87b7956 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -139,7 +139,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_
 	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, s->nr + extra);
 
 	if (zc) {
-		io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
+		io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, io->buf_index);
 		sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 		sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
@@ -166,7 +166,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_
 	if (zc) {
 		struct io_uring_sqe *unreg = sqe[s->nr + 1];
 
-		io_uring_prep_buf_unregister(unreg, 0, tag, q->q_id, tag);
+		io_uring_prep_buf_unregister(unreg, 0, tag, q->q_id, io->buf_index);
 		unreg->user_data = build_user_data(
 			tag, ublk_cmd_op_nr(unreg->cmd_op), 0, q->q_id, 1);
 	}
diff --git a/tools/testing/selftests/ublk/test_generic_08.sh b/tools/testing/selftests/ublk/test_generic_08.sh
new file mode 100755
index 0000000000000000000000000000000000000000..8dfb11606610b263810f28ce501aedbed0d87a86
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_08.sh
@@ -0,0 +1,61 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_08"
+ERR_CODE=0
+
+if ! _have_program bpftrace; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "null" "do imbalanced load, it should be balanced over I/O threads"
+
+NTHREADS=8
+dev_id=$(_add_ublk_dev -t null -q 4 -d 16 --nthreads $NTHREADS --round_robin)
+_check_add_dev $TID $?
+
+dev_t=$(_get_disk_dev_t "$dev_id")
+bpftrace trace/count_ios_per_tid.bt "$dev_t" > "$UBLK_TMP" 2>&1 &
+btrace_pid=$!
+sleep 2
+
+if ! kill -0 "$btrace_pid" > /dev/null 2>&1; then
+	_cleanup_test "null"
+	exit "$UBLK_SKIP_CODE"
+fi
+
+# do imbalanced I/O on the ublk device
+# single-threaded because while tags are assigned round-robin, I/O
+# completions can come in any order, and this can cause imperfect
+# balance (in practice, balance is close to perfect, with less than 0.1%
+# error, but prefer perfection/determinism for automated tests)
+# pin to cpu 0 to prevent migration/only target one queue
+IOS_PER_THREAD=1024
+TOTAL_IOS=$(($IOS_PER_THREAD * $NTHREADS))
+taskset -c 0 dd if=/dev/urandom of=/dev/ublkb"${dev_id}" \
+        oflag=direct bs=4k count=${TOTAL_IOS} > /dev/null 2>&1
+ERR_CODE=$?
+kill "$btrace_pid"
+wait
+
+# check for perfectly balanced I/O
+# note that this depends on few things:
+# - $NTHREADS should divide the queue depth
+# - the queue depth should divide $IOS_PER_THREAD
+# - no I/O on the device should happen while the bpftrace script is
+#   running, besides the dd in this script
+# the check below could be made more sophisticated to relax the first
+# two constraints above
+grep '@' < ${UBLK_TMP} | cut -d ' ' -f2 | while read ios; do
+        if [ "${ios}" -ne "${IOS_PER_THREAD}" ]; then
+                echo "imbalanced i/o detected!"
+                cat "$UBLK_TMP"
+                exit 255
+        fi
+done
+ERR_CODE=$?
+
+_cleanup_test "null"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/trace/count_ios_per_tid.bt b/tools/testing/selftests/ublk/trace/count_ios_per_tid.bt
new file mode 100644
index 0000000000000000000000000000000000000000..a62ef428a3dff1db33b128868baa62533d4066aa
--- /dev/null
+++ b/tools/testing/selftests/ublk/trace/count_ios_per_tid.bt
@@ -0,0 +1,9 @@
+/*
+	$1: 	dev_t
+*/
+tracepoint:block:block_rq_complete
+{
+	if ((int64)args.dev == $1 && !strncmp(args.rwbs, "W", 1)) {
+		@[tid] = count();
+	}
+}

-- 
2.34.1


