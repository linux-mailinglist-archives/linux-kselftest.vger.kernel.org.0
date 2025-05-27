Return-Path: <linux-kselftest+bounces-33894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D380FAC5D7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 01:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904F117428E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 23:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EF221ABB0;
	Tue, 27 May 2025 23:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Cr8A7qRo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B36F50F
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748386903; cv=none; b=dKku/lfpFAXLTX6V1t6H2UsBzk+R/iZcR/mGY6Gu4w0EOghTd7XvfPzFRFR5C1B2FTKYr7a43SOdhmEUmkl0b9wPSy9qVUjmc0hdyr0gctEE580YQomkpT0aAVVoNU1BCx1L2kcY/K2mEDSC7/7Gg4hDUvH3BVlZIuTydQ6BIkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748386903; c=relaxed/simple;
	bh=Son7h+qaidUty9juIZeHGD3GEp8FAe8XhaNqdQhs7w4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TdTpWYqqcRfHr1R4Xy0IlxMQj3Ur/E+psawGI/OYJ9yAlXkbgzHU0koQ4nHGCLtf+10GWmxcPJliSBu+HuxpIVcLyjtA6MYfZLgiABwoc66reTjnI1y/qZeJqFCxyRpCtmmotZAEZLkqY2RWFurx+BNaW0eAWJqBtMK3fF0guWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Cr8A7qRo; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-7cd0a7b672bso239910685a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748386897; x=1748991697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/gmgUHgf5mpvLiI4y2LM35vgYPNvz/uWksPrF8819I=;
        b=Cr8A7qRo5/4wDCMw6/26LERY3nUSoBbpHXmXx9iUN1bc3ydMGVz1uzKCZM6UIn5GTa
         EYR1fqinaZJC5/sKE0vCv3/z30GGOXTaXkyW7cGtUr2aRE7VHKFe2VUfhaBR0DBKcmUH
         M/GxUzCeajAQs5vbODo70OXYZy/mXgVbZCJgbAiG8Nu5LU5DzRjtZJk5VSxyw3fQjdq/
         Ah2u+A46prNYOUOEbRi2L94IM2HtgdFiz8Z5VpJj4JSdMjeFhzPodfd604qOSMStBrA/
         Q1UyJAXqcMFaz+P+FSUkVD4s4dKjGZb7f6oDedzGVGO9gGSDVSHLqI2HT4mATpcCeY5j
         k5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748386897; x=1748991697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/gmgUHgf5mpvLiI4y2LM35vgYPNvz/uWksPrF8819I=;
        b=EhON80eY8rdHltUrSMb2+QzorVOrZST9Y7vIy0jdb/Qrdy5Pqqq996rIpfz41vyGY5
         gQbv7Qks47WmP1a4EYq6fL4ErnIyE0ZbWNY+SQ1sr/815Coaa2Yub+zpNXyDMmgHp4gE
         iKMSLutX6jyzQw4CSrwLcrwf6lnFQn/hF2dLWIxayTOle/qvPnz6XOium0qvufDRp8Fs
         vZ7OiuewXRpA8mqRsIienEs3LdiY1mWdnzd0av8AxNs9IKvHHPvZX5yoFv4ccyrZn0M+
         h7hH1QhHYLf/5yMgGBLA7MZH84GpsjSxOOw3RL0GiWy7dypJH/V52FHTAOoLXqm6NOZD
         HrhA==
X-Forwarded-Encrypted: i=1; AJvYcCXs1J6KoEwszuJ/MIQLdXou2KQP0JUIOLVOYeGDNh4SJehz7Se4nkzab+lmS/4z/4OCBrSxaXGK1uCwK/TaOx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXIoJP7hE/PzrOXy6V/BVHTrtsrk4wjHdhQALIIpjmF0LJVpC2
	1O9QzjniMx2bmqTPSCu/kgZm/w92eQB7+1gW2QzTnCc2pvKjCss8klsWNorWJUU5nQIoL/i2Spe
	G967/njEX6RBL0KmRMP30RQjqjh/GNlUcWlmc
X-Gm-Gg: ASbGncu5idZr/cI+f6McWTs59f2f+qZ+I1Q0HL/hCzcCa8glNt++wSgrtSRdXsUMaan
	seqxb+4X0NkXpPW8U7caSyV2mmuYo2P99ViUOlrrMgBJ2O0J7cvBbCH0tzaaRvwPhzvrE3CHyYB
	N+pfV/aHy55lOAZbEwzz4ROUCZDGRcYMqFfZIwMZ8n8BYX5Z9md153va7Kg5M5tUxCX2/Jklu/X
	iRfCtl8fuDYgh7XkU4oP4WmJBdHcFdr/k38n2Y5Jh6IFJD9LrJWWV6WHW1TJgZpuwmb3vkb09zs
	dBFiNrqBkJsqIQgHX4VsGTEGEZdmt2eMRe2nQX0TRximvg==
X-Google-Smtp-Source: AGHT+IFd96N1i6KBCPgwJ1ZlpPO4h3KM1C5JXjcijWdVhov2mqlFxNZ0RWVo/TyA1Jzn1oz5eRPLshSECEVU
X-Received: by 2002:ac8:5c82:0:b0:477:5d12:aa4d with SMTP id d75a77b69052e-49f47a0947fmr229001021cf.39.1748386897149;
        Tue, 27 May 2025 16:01:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4a2f925b2dbsm185121cf.3.2025.05.27.16.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 16:01:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2FDA2340245;
	Tue, 27 May 2025 17:01:36 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 22FA5E539BB; Tue, 27 May 2025 17:01:36 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 27 May 2025 17:01:24 -0600
Subject: [PATCH v7 1/8] ublk: have a per-io daemon instead of a per-queue
 daemon
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-ublk_task_per_io-v7-1-cbdbaf283baa@purestorage.com>
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

Currently, ublk_drv associates to each hardware queue (hctx) a unique
task (called the queue's ubq_daemon) which is allowed to issue
COMMIT_AND_FETCH commands against the hctx. If any other task attempts
to do so, the command fails immediately with EINVAL. When considered
together with the block layer architecture, the result is that for each
CPU C on the system, there is a unique ublk server thread which is
allowed to handle I/O submitted on CPU C. This can lead to suboptimal
performance under imbalanced load generation. For an extreme example,
suppose all the load is generated on CPUs mapping to a single ublk
server thread. Then that thread may be fully utilized and become the
bottleneck in the system, while other ublk server threads are totally
idle.

This issue can also be addressed directly in the ublk server without
kernel support by having threads dequeue I/Os and pass them around to
ensure even load. But this solution requires inter-thread communication
at least twice for each I/O (submission and completion), which is
generally a bad pattern for performance. The problem gets even worse
with zero copy, as more inter-thread communication would be required to
have the buffer register/unregister calls to come from the correct
thread.

Therefore, address this issue in ublk_drv by allowing each I/O to have
its own daemon task. Two I/Os in the same queue are now allowed to be
serviced by different daemon tasks - this was not possible before.
Imbalanced load can then be balanced across all ublk server threads by
having the ublk server threads issue FETCH_REQs in a round-robin manner.
As a small toy example, consider a system with a single ublk device
having 2 queues, each of depth 4. A ublk server having 4 threads could
issue its FETCH_REQs against this device as follows (where each entry is
the qid,tag pair that the FETCH_REQ targets):

ublk server thread:	T0	T1	T2	T3
			0,0	0,1	0,2	0,3
			1,3	1,0	1,1	1,2

This setup allows for load that is concentrated on one hctx/ublk_queue
to be spread out across all ublk server threads, alleviating the issue
described above.

Add the new UBLK_F_PER_IO_DAEMON feature to ublk_drv, which ublk servers
can use to essentially test for the presence of this change and tailor
their behavior accordingly.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c      | 108 +++++++++++++++++++++---------------------
 include/uapi/linux/ublk_cmd.h |   9 ++++
 2 files changed, 64 insertions(+), 53 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1b47341962d095830a02e07418815f633fa9ed8a..60d4a0251339dd0a56760e9c582d394c8b386661 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -69,7 +69,8 @@
 		| UBLK_F_USER_RECOVERY_FAIL_IO \
 		| UBLK_F_UPDATE_SIZE \
 		| UBLK_F_AUTO_BUF_REG \
-		| UBLK_F_QUIESCE)
+		| UBLK_F_QUIESCE \
+		| UBLK_F_PER_IO_DAEMON)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
@@ -166,6 +167,8 @@ struct ublk_io {
 		/* valid if UBLK_IO_FLAG_OWNED_BY_SRV is set */
 		struct request *req;
 	};
+
+	struct task_struct *task;
 };
 
 struct ublk_queue {
@@ -173,11 +176,9 @@ struct ublk_queue {
 	int q_depth;
 
 	unsigned long flags;
-	struct task_struct	*ubq_daemon;
 	struct ublksrv_io_desc *io_cmd_buf;
 
 	bool force_abort;
-	bool timeout;
 	bool canceling;
 	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
 	unsigned short nr_io_ready;	/* how many ios setup */
@@ -1099,11 +1100,6 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 	return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
 }
 
-static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
-{
-	return !ubq->ubq_daemon || ubq->ubq_daemon->flags & PF_EXITING;
-}
-
 /* todo: handle partial completion */
 static inline void __ublk_complete_rq(struct request *req)
 {
@@ -1275,13 +1271,13 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 	/*
 	 * Task is exiting if either:
 	 *
-	 * (1) current != ubq_daemon.
+	 * (1) current != io->task.
 	 * io_uring_cmd_complete_in_task() tries to run task_work
-	 * in a workqueue if ubq_daemon(cmd's task) is PF_EXITING.
+	 * in a workqueue if cmd's task is PF_EXITING.
 	 *
 	 * (2) current->flags & PF_EXITING.
 	 */
-	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
+	if (unlikely(current != io->task || current->flags & PF_EXITING)) {
 		__ublk_abort_rq(ubq, req);
 		return;
 	}
@@ -1341,13 +1337,12 @@ static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
 	} while (rq);
 }
 
-static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
+static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
 {
-	struct request *rq = rq_list_peek(l);
-	struct io_uring_cmd *cmd = ubq->ios[rq->tag].cmd;
+	struct io_uring_cmd *cmd = io->cmd;
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 
-	pdu->req_list = rq;
+	pdu->req_list = rq_list_peek(l);
 	rq_list_init(l);
 	io_uring_cmd_complete_in_task(cmd, ublk_cmd_list_tw_cb);
 }
@@ -1355,13 +1350,10 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 {
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
+	struct ublk_io *io = &ubq->ios[rq->tag];
 
 	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
-		if (!ubq->timeout) {
-			send_sig(SIGKILL, ubq->ubq_daemon, 0);
-			ubq->timeout = true;
-		}
-
+		send_sig(SIGKILL, io->task, 0);
 		return BLK_EH_DONE;
 	}
 
@@ -1429,24 +1421,25 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
 {
 	struct rq_list requeue_list = { };
 	struct rq_list submit_list = { };
-	struct ublk_queue *ubq = NULL;
+	struct ublk_io *io = NULL;
 	struct request *req;
 
 	while ((req = rq_list_pop(rqlist))) {
 		struct ublk_queue *this_q = req->mq_hctx->driver_data;
+		struct ublk_io *this_io = &this_q->ios[req->tag];
 
-		if (ubq && ubq != this_q && !rq_list_empty(&submit_list))
-			ublk_queue_cmd_list(ubq, &submit_list);
-		ubq = this_q;
+		if (io && io->task != this_io->task && !rq_list_empty(&submit_list))
+			ublk_queue_cmd_list(io, &submit_list);
+		io = this_io;
 
-		if (ublk_prep_req(ubq, req, true) == BLK_STS_OK)
+		if (ublk_prep_req(this_q, req, true) == BLK_STS_OK)
 			rq_list_add_tail(&submit_list, req);
 		else
 			rq_list_add_tail(&requeue_list, req);
 	}
 
-	if (ubq && !rq_list_empty(&submit_list))
-		ublk_queue_cmd_list(ubq, &submit_list);
+	if (io && !rq_list_empty(&submit_list))
+		ublk_queue_cmd_list(io, &submit_list);
 	*rqlist = requeue_list;
 }
 
@@ -1474,17 +1467,6 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 	/* All old ioucmds have to be completed */
 	ubq->nr_io_ready = 0;
 
-	/*
-	 * old daemon is PF_EXITING, put it now
-	 *
-	 * It could be NULL in case of closing one quisced device.
-	 */
-	if (ubq->ubq_daemon)
-		put_task_struct(ubq->ubq_daemon);
-	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
-	ubq->ubq_daemon = NULL;
-	ubq->timeout = false;
-
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
 
@@ -1495,6 +1477,17 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 		io->flags &= UBLK_IO_FLAG_CANCELED;
 		io->cmd = NULL;
 		io->addr = 0;
+
+		/*
+		 * old task is PF_EXITING, put it now
+		 *
+		 * It could be NULL in case of closing one quiesced
+		 * device.
+		 */
+		if (io->task) {
+			put_task_struct(io->task);
+			io->task = NULL;
+		}
 	}
 }
 
@@ -1516,7 +1509,7 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
 
-	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
+	/* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
 	ub->mm = NULL;
 	ub->nr_queues_ready = 0;
 	ub->nr_privileged_daemon = 0;
@@ -1783,6 +1776,7 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
 	struct task_struct *task;
+	struct ublk_io *io;
 
 	if (WARN_ON_ONCE(!ubq))
 		return;
@@ -1791,13 +1785,14 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 		return;
 
 	task = io_uring_cmd_get_task(cmd);
-	if (WARN_ON_ONCE(task && task != ubq->ubq_daemon))
+	io = &ubq->ios[pdu->tag];
+	if (WARN_ON_ONCE(task && task != io->task))
 		return;
 
 	if (!ubq->canceling)
 		ublk_start_cancel(ubq);
 
-	WARN_ON_ONCE(ubq->ios[pdu->tag].cmd != cmd);
+	WARN_ON_ONCE(io->cmd != cmd);
 	ublk_cancel_cmd(ubq, pdu->tag, issue_flags);
 }
 
@@ -1930,8 +1925,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 {
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
-		ubq->ubq_daemon = current;
-		get_task_struct(ubq->ubq_daemon);
 		ub->nr_queues_ready++;
 
 		if (capable(CAP_SYS_ADMIN))
@@ -2084,6 +2077,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 	}
 
 	ublk_fill_io_cmd(io, cmd, buf_addr);
+	WRITE_ONCE(io->task, get_task_struct(current));
 	ublk_mark_io_ready(ub, ubq);
 out:
 	mutex_unlock(&ub->mutex);
@@ -2179,6 +2173,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       const struct ublksrv_io_cmd *ub_cmd)
 {
 	struct ublk_device *ub = cmd->file->private_data;
+	struct task_struct *task;
 	struct ublk_queue *ubq;
 	struct ublk_io *io;
 	u32 cmd_op = cmd->cmd_op;
@@ -2193,13 +2188,14 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		goto out;
 
 	ubq = ublk_get_queue(ub, ub_cmd->q_id);
-	if (ubq->ubq_daemon && ubq->ubq_daemon != current)
-		goto out;
 
 	if (tag >= ubq->q_depth)
 		goto out;
 
 	io = &ubq->ios[tag];
+	task = READ_ONCE(io->task);
+	if (task && task != current)
+		goto out;
 
 	/* there is pending io cmd, something must be wrong */
 	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
@@ -2449,9 +2445,14 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 {
 	int size = ublk_queue_cmd_buf_size(ub, q_id);
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
+	int i;
+
+	for (i = 0; i < ubq->q_depth; i++) {
+		struct ublk_io *io = &ubq->ios[i];
+		if (io->task)
+			put_task_struct(io->task);
+	}
 
-	if (ubq->ubq_daemon)
-		put_task_struct(ubq->ubq_daemon);
 	if (ubq->io_cmd_buf)
 		free_pages((unsigned long)ubq->io_cmd_buf, get_order(size));
 }
@@ -2923,7 +2924,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	ub->dev_info.flags &= UBLK_F_ALL;
 
 	ub->dev_info.flags |= UBLK_F_CMD_IOCTL_ENCODE |
-		UBLK_F_URING_CMD_COMP_IN_TASK;
+		UBLK_F_URING_CMD_COMP_IN_TASK |
+		UBLK_F_PER_IO_DAEMON;
 
 	/* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
 	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
@@ -3188,14 +3190,14 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	int ublksrv_pid = (int)header->data[0];
 	int ret = -EINVAL;
 
-	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
-			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
-	/* wait until new ubq_daemon sending all FETCH_REQ */
+	pr_devel("%s: Waiting for all FETCH_REQs, dev id %d...\n", __func__,
+		 header->dev_id);
+
 	if (wait_for_completion_interruptible(&ub->completion))
 		return -EINTR;
 
-	pr_devel("%s: All new ubq_daemons(nr: %d) are ready, dev id %d\n",
-			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
+	pr_devel("%s: All FETCH_REQs received, dev id %d\n", __func__,
+		 header->dev_id);
 
 	mutex_lock(&ub->mutex);
 	if (ublk_nosrv_should_stop_dev(ub))
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 56c7e3fc666fc578a545d15a9767e58f3a4a2f3b..77d9d6af46da878cf30df6e3e31758a6f8f61afa 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -272,6 +272,15 @@
  */
 #define UBLK_F_QUIESCE		(1ULL << 12)
 
+/*
+ * If this feature is set, ublk_drv supports each (qid,tag) pair having
+ * its own independent daemon task that is responsible for handling it.
+ * If it is not set, daemons are per-queue instead, so for two pairs
+ * (qid1,tag1) and (qid2,tag2), if qid1 == qid2, then the same task must
+ * be responsible for handling (qid1,tag1) and (qid2,tag2).
+ */
+#define UBLK_F_PER_IO_DAEMON (1ULL << 13)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1

-- 
2.34.1


