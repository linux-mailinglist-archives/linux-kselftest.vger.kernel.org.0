Return-Path: <linux-kselftest+bounces-33899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963A8AC5D8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 01:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F1F16337D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 23:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0841421C17D;
	Tue, 27 May 2025 23:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OdhNdEtF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8754D2192F4
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748386904; cv=none; b=pHsX8pW/jJxmZv7mGVr9iQ+CKJ0pfw8Q/UwQ5MylIRtxPSAJgt3Gxq1VYbgI4AxeIUxezEMtkRmXJ/B/MYBzYp+9uOnWa5c4k8v3Y/qSo3XuN3OXHZ3jqzWGN6pP2iqAnAjVN9KfoFFF7CvlY4G1iLRwYPjPDgWnIKSxVlfKAT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748386904; c=relaxed/simple;
	bh=X8Ado1Q25BLR49D5j+LiStxjlAVYwh8FwdeM2KHTh24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o6Fc1LcqTv9rrEAOfUtchWKBbC7WKv3m2rs/X1w0Mxg9SIVZtTfzX3HfTftVUTEqJNUT7zrhHKTXc+U9Evjnr/+g0VtwrdbOGQu8PfOtWLYhnwtA+t2DPDVMPMIxKbbtnhtikD+RmCYg8PDF//XSrRDDzak43CnD4VydTQXgs0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OdhNdEtF; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-23461842024so24391615ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 16:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748386899; x=1748991699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CWp8mfQPqAjI37HM5HfHEZX81Cf/O3prxdUw0P2Ulo=;
        b=OdhNdEtF2d449/GLgkyD1wmF1XJGu3oM2Pj7kLFHBZJ6729QS1Aqm8M4XOlJ9Zykuw
         rkm7dj72rX1bv4+SHJgtgWsWQJnEtcR6UrywPXHD4YDBKmgDDe+vXQVm/e2lQeHBhC9q
         CJFtqnDjcStiU8T+QZUP9/H98KhL0PWcY5yR9Gx0+qdQ5e24NV6Wu0OVarkGV41WSnvb
         eQhxg8aziuwhpRPrbYQ3yFj//7oYQOyRjYmHdr73TrbvrEy0rKTMYKon6ZZpZNffeqG6
         VSpTt8MyUVAoSPprN1L3ZZzcFpRoLuReuR9TXNwoQI2j7Rc7fVFnzwiZkgq0cJ0za9Uo
         mt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748386899; x=1748991699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CWp8mfQPqAjI37HM5HfHEZX81Cf/O3prxdUw0P2Ulo=;
        b=hJZvBBN48F6JEj5Yqaj1tHn+ixhoC9AXU/EkN7h/wwhMD1umW3ZkOfI4IYk9BTm1Lq
         pOXDi8PxpCk68E1gGLgvFxbbDW8kGXC90Tv231Jb4JcltVpgGXVRrKGK8sYL3hrg1Oan
         B8Ed4MNzZJCFCkO+i1y/NAuGBrpb8W0PXm4adxxpCLIRnfu9T5vUddyvG8LBO0QJov6B
         TSXPfLBhq5qSL3UwH2cjojzllQhB0ldhx8Bq+kLBUowfWiscCdNjDXK1yWrK2b/6+IeW
         Z7vmq7j2sxD+OHQQLidvzMlnZjT3KxWjH+7/aNgOufF0YHIoeQZp6BExnYAqftmfwHxL
         uDrw==
X-Forwarded-Encrypted: i=1; AJvYcCUYBI65Iy/Yk1n7dj2VGUZj37eLm0gQcjcloCHrnCaXwAaZ73Uofbr8z/P4eO2KMopumutdFK0BRix2lF0Hbfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEgxdNKvDLQZmXqrHdhHHZB96Ml848V/Qu6jsPZ8awiB6FhH18
	5ETArBp0iER7y+fKL9SzV5bNZHYxdribWPen5nCwHYT2ivUWwuqUZB4CNtamnvFp14a87T/s+Tu
	eWyZpKwVkuVxpo03aGikJZwXLlzn+qyvWmwSU
X-Gm-Gg: ASbGncvIA4bnE5h7LZmMZjdbVlx5WuGQrmZ45RYVp3QDY4uA+brDvHNjExspna/dBm1
	h1G9rcdWWq3wGOdSjnrtm66JiFDtcdkFKiwD2lshJ3oSshYq43ltbX8Ot0sMReVJevK3mzcl+eZ
	DZvatzKzrnPtam3JqCn6A138tq/gQerqve53oeo7x82RnLG0Tt6e+s7GJ82RDd4IgdZNBv0fFEr
	l37zTR3jQ+UP2meeShRzzJvBHlwxDwNdAibdHfHcm9vfawQ1sI8NfVtDeIgRYj1Q6evMcmI+sq3
	XT95aT4HrQr4qT4QiwYO3s5QxFOANKbcQc/W2+TKUuS9WQ==
X-Google-Smtp-Source: AGHT+IFblVPyCmWXelSGNZ0zQ4X0Vl3ybQLV4O+MeeOpI8gGJOpIY6K+aKkQyfS8e619HCxJbu13zvEIxK0T
X-Received: by 2002:a17:903:1947:b0:234:c8ec:51b5 with SMTP id d9443c01a7336-234c8ec551cmr9909855ad.53.1748386898635;
        Tue, 27 May 2025 16:01:38 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-234cc135a4dsm111625ad.63.2025.05.27.16.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 16:01:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3EC8534094F;
	Tue, 27 May 2025 17:01:36 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 3C9C7E539B9; Tue, 27 May 2025 17:01:36 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 27 May 2025 17:01:29 -0600
Subject: [PATCH v7 6/8] selftests: ublk: kublk: decouple ublk_queues from
 ublk server threads
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-ublk_task_per_io-v7-6-cbdbaf283baa@purestorage.com>
References: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com>
In-Reply-To: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com>
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
  if load is not balanced over queues.

The default is the preexisting mode. The new mode is activated by
passing the --per_io_tasks flag.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/file_backed.c |   4 +-
 tools/testing/selftests/ublk/kublk.c       | 106 ++++++++++++++++++++++++-----
 tools/testing/selftests/ublk/kublk.h       |   5 ++
 tools/testing/selftests/ublk/null.c        |   6 +-
 tools/testing/selftests/ublk/stripe.c      |   4 +-
 5 files changed, 101 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 922a87108b9f7bae53098e74602c7b1f3e0246bc..cfa59b631693793465f0e6909a6fbe1a364f4523 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -54,7 +54,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 
 	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 3);
 
-	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
+	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 	sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
@@ -66,7 +66,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 	sqe[1]->flags |= IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
 	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 
-	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, tag);
+	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
 	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
 	return 2;
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 40431a8357a8f74d7d62e271e9090c8708c3ecc5..c91c4b5aa0ff4a0a87c05bc1d9f404d105842e7f 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -505,8 +505,11 @@ static int ublk_thread_init(struct ublk_thread *t)
 	}
 
 	if (dev->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_AUTO_BUF_REG)) {
+		unsigned nr_ios = dev->dev_info.queue_depth * dev->dev_info.nr_hw_queues;
+		unsigned max_nr_ios_per_thread = nr_ios / dev->nthreads;
+		max_nr_ios_per_thread += !!(nr_ios % dev->nthreads);
 		ret = io_uring_register_buffers_sparse(
-			&t->ring, dev->dev_info.queue_depth);
+			&t->ring, max_nr_ios_per_thread);
 		if (ret) {
 			ublk_err("ublk dev %d thread %d register spare buffers failed %d",
 					dev->dev_info.dev_id, t->idx, ret);
@@ -578,7 +581,7 @@ static void ublk_set_auto_buf_reg(const struct ublk_queue *q,
 	if (q->tgt_ops->buf_index)
 		buf.index = q->tgt_ops->buf_index(q, tag);
 	else
-		buf.index = tag;
+		buf.index = q->ios[tag].buf_index;
 
 	if (q->state & UBLKSRV_AUTO_BUF_REG_FALLBACK)
 		buf.flags = UBLK_AUTO_BUF_REG_FALLBACK;
@@ -660,18 +663,44 @@ int ublk_queue_io_cmd(struct ublk_io *io)
 
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
+	if (t->dev->per_io_tasks) {
+		/*
+		 * Lexicographically order all the (qid,tag) pairs, with
+		 * qid taking priority (so (1,0) > (0,1)). Then make
+		 * this thread the daemon for every Nth entry in this
+		 * list (N is the number of threads), starting at this
+		 * thread's index. This ensures that each queue is
+		 * handled by as many ublk server threads as possible,
+		 * so that load that is concentrated on one or a few
+		 * queues can make use of all ublk server threads.
+		 */
+		const struct ublksrv_ctrl_dev_info *dinfo = &t->dev->dev_info;
+		int nr_ios = dinfo->nr_hw_queues * dinfo->queue_depth;
+		for (i = t->idx; i < nr_ios; i += t->dev->nthreads) {
+			int q_id = i / dinfo->queue_depth;
+			int tag = i % dinfo->queue_depth;
+			q = &t->dev->q[q_id];
+			io = &q->ios[tag];
+			io->t = t;
+			io->buf_index = j++;
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
 
@@ -826,7 +855,8 @@ static void *ublk_io_handler_fn(void *data)
 		return NULL;
 	}
 	/* IO perf is sensitive with queue pthread affinity on NUMA machine*/
-	ublk_thread_set_sched_affinity(t, info->affinity);
+	if (info->affinity)
+		ublk_thread_set_sched_affinity(t, info->affinity);
 	sem_post(info->ready);
 
 	ublk_dbg(UBLK_DBG_THREAD, "tid %d: ublk dev %d thread %u started\n",
@@ -893,7 +923,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 
 	ublk_dbg(UBLK_DBG_DEV, "%s enter\n", __func__);
 
-	tinfo = calloc(sizeof(struct ublk_thread_info), dinfo->nr_hw_queues);
+	tinfo = calloc(sizeof(struct ublk_thread_info), dev->nthreads);
 	if (!tinfo)
 		return -ENOMEM;
 
@@ -919,17 +949,29 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 				 dinfo->dev_id, i);
 			goto fail;
 		}
+	}
 
+	for (i = 0; i < dev->nthreads; i++) {
 		tinfo[i].dev = dev;
 		tinfo[i].idx = i;
 		tinfo[i].ready = &ready;
-		tinfo[i].affinity = &affinity_buf[i];
+
+		/*
+		 * If threads are not tied 1:1 to queues, setting thread
+		 * affinity based on queue affinity makes little sense.
+		 * However, thread CPU affinity has significant impact
+		 * on performance, so to compare fairly, we'll still set
+		 * thread CPU affinity based on queue affinity where
+		 * possible.
+		 */
+		if (dev->nthreads == dinfo->nr_hw_queues)
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
@@ -953,7 +995,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		ublk_send_dev_event(ctx, dev, dev->dev_info.dev_id);
 
 	/* wait until we are terminated */
-	for (i = 0; i < dinfo->nr_hw_queues; i++)
+	for (i = 0; i < dev->nthreads; i++)
 		pthread_join(dev->threads[i].thread, &thread_ret);
  fail:
 	for (i = 0; i < dinfo->nr_hw_queues; i++)
@@ -1063,6 +1105,7 @@ static int ublk_stop_io_daemon(const struct ublk_dev *dev)
 
 static int __cmd_dev_add(const struct dev_ctx *ctx)
 {
+	unsigned nthreads = ctx->nthreads;
 	unsigned nr_queues = ctx->nr_hw_queues;
 	const char *tgt_type = ctx->tgt_type;
 	unsigned depth = ctx->queue_depth;
@@ -1086,6 +1129,23 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
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
+	if (nthreads != nr_queues && !ctx->per_io_tasks) {
+		ublk_err("%s: threads %u must be same as queues %u if "
+			"not using per_io_tasks\n",
+			__func__, nthreads, nr_queues);
+		return -EINVAL;
+	}
+
 	dev = ublk_ctrl_init();
 	if (!dev) {
 		ublk_err("%s: can't alloc dev id %d, type %s\n",
@@ -1109,6 +1169,8 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 	if ((features & UBLK_F_QUIESCE) &&
 			(info->flags & UBLK_F_USER_RECOVERY))
 		info->flags |= UBLK_F_QUIESCE;
+	dev->nthreads = nthreads;
+	dev->per_io_tasks = ctx->per_io_tasks;
 	dev->tgt.ops = ops;
 	dev->tgt.sq_depth = depth;
 	dev->tgt.cq_depth = depth;
@@ -1307,6 +1369,7 @@ static int cmd_dev_get_features(void)
 		[const_ilog2(UBLK_F_UPDATE_SIZE)] = "UPDATE_SIZE",
 		[const_ilog2(UBLK_F_AUTO_BUF_REG)] = "AUTO_BUF_REG",
 		[const_ilog2(UBLK_F_QUIESCE)] = "QUIESCE",
+		[const_ilog2(UBLK_F_PER_IO_DAEMON)] = "PER_IO_DAEMON",
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -1401,8 +1464,10 @@ static void __cmd_create_help(char *exe, bool recovery)
 			exe, recovery ? "recover" : "add");
 	printf("\t[--foreground] [--quiet] [-z] [--auto_zc] [--auto_zc_fallback] [--debug_mask mask] [-r 0|1 ] [-g]\n");
 	printf("\t[-e 0|1 ] [-i 0|1]\n");
+	printf("\t[--nthreads threads] [--per_io_tasks]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
+	printf("\tdefault: nthreads=nr_queues");
 
 	for (i = 0; i < sizeof(tgt_ops_list) / sizeof(tgt_ops_list[0]); i++) {
 		const struct ublk_tgt_ops *ops = tgt_ops_list[i];
@@ -1459,6 +1524,8 @@ int main(int argc, char *argv[])
 		{ "auto_zc",		0,	NULL,  0 },
 		{ "auto_zc_fallback", 	0,	NULL,  0 },
 		{ "size",		1,	NULL, 's'},
+		{ "nthreads",		1,	NULL,  0 },
+		{ "per_io_tasks",	0,	NULL,  0 },
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1467,6 +1534,7 @@ int main(int argc, char *argv[])
 	struct dev_ctx ctx = {
 		.queue_depth	=	128,
 		.nr_hw_queues	=	2,
+		.nthreads	=	-1,
 		.dev_id		=	-1,
 		.tgt_type	=	"unknown",
 	};
@@ -1534,6 +1602,10 @@ int main(int argc, char *argv[])
 				ctx.flags |= UBLK_F_AUTO_BUF_REG;
 			if (!strcmp(longopts[option_idx].name, "auto_zc_fallback"))
 				ctx.auto_zc_fallback = 1;
+			if (!strcmp(longopts[option_idx].name, "nthreads"))
+				ctx.nthreads = strtol(optarg, NULL, 10);
+			if (!strcmp(longopts[option_idx].name, "per_io_tasks"))
+				ctx.per_io_tasks = 1;
 			break;
 		case '?':
 			/*
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 3a2ae095bee18633acd5a9c923cfab2d14fe3bff..4cc8103bc49a7a93bbf61986cde8f4e6e1be716d 100644
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
@@ -89,6 +90,7 @@ struct dev_ctx {
 	unsigned int	fg:1;
 	unsigned int	recovery:1;
 	unsigned int	auto_zc_fallback:1;
+	unsigned int	per_io_tasks:1;
 
 	int _evtfd;
 	int _shmid;
@@ -128,6 +130,7 @@ struct ublk_io {
 	unsigned short refs;		/* used by target code only */
 
 	int tag;
+	int buf_index;
 
 	int result;
 
@@ -203,6 +206,8 @@ struct ublk_dev {
 	struct ublksrv_ctrl_dev_info  dev_info;
 	struct ublk_queue q[UBLK_MAX_QUEUES];
 	struct ublk_thread threads[UBLK_MAX_THREADS];
+	unsigned nthreads;
+	unsigned per_io_tasks;
 
 	int fds[MAX_BACK_FILES + 1];	/* fds[0] points to /dev/ublkcN */
 	int nr_fds;
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index 9acc7e0d271b5ae52d6d31587cc5bfb63b19778d..afe0b99d77eec74acae04952a9af5348252bc599 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -62,7 +62,7 @@ static int null_queue_zc_io(struct ublk_queue *q, int tag)
 
 	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 3);
 
-	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
+	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
 	sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
@@ -70,7 +70,7 @@ static int null_queue_zc_io(struct ublk_queue *q, int tag)
 	__setup_nop_io(tag, iod, sqe[1], q->q_id);
 	sqe[1]->flags |= IOSQE_IO_HARDLINK;
 
-	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, tag);
+	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
 	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
 	// buf register is marked as IOSQE_CQE_SKIP_SUCCESS
@@ -136,7 +136,7 @@ static unsigned short ublk_null_buf_index(const struct ublk_queue *q, int tag)
 {
 	if (q->state & UBLKSRV_AUTO_BUF_REG_FALLBACK)
 		return (unsigned short)-1;
-	return tag;
+	return q->ios[tag].buf_index;
 }
 
 const struct ublk_tgt_ops null_tgt_ops = {
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 97079c3121ef8d4edc71891a289dd40658ce3f2a..37d50bbf5f5e86a520efedc9228510f8e1273625 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -141,7 +141,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_
 	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, s->nr + extra);
 
 	if (zc) {
-		io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
+		io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, io->buf_index);
 		sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 		sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
@@ -167,7 +167,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_
 	if (zc) {
 		struct io_uring_sqe *unreg = sqe[s->nr + 1];
 
-		io_uring_prep_buf_unregister(unreg, 0, tag, q->q_id, tag);
+		io_uring_prep_buf_unregister(unreg, 0, tag, q->q_id, io->buf_index);
 		unreg->user_data = build_user_data(
 			tag, ublk_cmd_op_nr(unreg->cmd_op), 0, q->q_id, 1);
 	}

-- 
2.34.1


