Return-Path: <linux-kselftest+bounces-34024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 513A4AC8572
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 01:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BA8A26B9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 23:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E7325D1F4;
	Thu, 29 May 2025 23:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NJWW3zLZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D0D258CF9
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 23:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562464; cv=none; b=fyNMFgv+PS+zeplygEW2/TjMw1/itFdk8tI7hI/8rzvzXHH83LKXLWA6/um6PazdqOXTSC+U4sJTw9mQO3tt3H1IaW1GitLdUuiw79ibBaj3bXner0PmHl9WmVBhzZKbJzggJ1xHLkGgcQRsVMnbB6iiXHr/ARzXQ9PCo3hbuXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562464; c=relaxed/simple;
	bh=93QFzEjQYW6fQ5JoQ0ynCUVE88LdGxwbXioNe699p6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUTxMIC926U3NzWa744t7avBnpvPWl5krSrjz1e3zx2Y8r+fliRO2OztWNvaes9EilId9/Xdq0LLdbUy/BbkZyLEDecKBs+qq8xsqjFkyFuazzcFnKes9sSuBdQjwiGpC/eQRfM9lszb1U609cL+jdIrvfTPifCX3bZ/bskKIe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NJWW3zLZ; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-6facb09ea08so16865386d6.3
        for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 16:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748562457; x=1749167257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ttLpnGFlUHus7TnM6h8hhD5YVCygB5vLNbE5cXi2bk=;
        b=NJWW3zLZtIefCMLXqFo4XufV9xbauVfjvBA4mX6UFzyyeFthqV6YXnSb6xC3Zl7ZTJ
         4UUCMGgtEGGORNFGiftL1Ydq9wQ0u9ZW1164IUmViC5uPDVyHqI+v+zCKV51ALSXyzAj
         9nRoyd6PLoLB1n4L+x3a3Cx+aNH9pmLMGUO8XSwNR5nQts6HtA7Z2F7n7tDkiSiCew3d
         lSPmj7odzsyWeBhCtYq0pxU5WMCCpOBLt5wfq35oMXHsLfjm+9ZAHdM/8gRXIMswcO46
         j1yp+caoIS73t82Q24tMBeGwxEGUUA3btoGYGyk6fQX5YzvR3BiESpyPIpybanURqj31
         VF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562457; x=1749167257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ttLpnGFlUHus7TnM6h8hhD5YVCygB5vLNbE5cXi2bk=;
        b=m4lo9UzRBQdApXkvfjc+J2CP09fBylFebZzY1ZX7RiYfrI+w6/lYiE8t11khSjDa0O
         5ITYa3CQ8u6X6lqc+DN1FeRTb1/DxOdh6jVgp+CX9ZAGxy08GcXSCTsXoBwAxbO9jL0Y
         cCLFZBsmI+LcMHh+5ZRaO5dVnr/zY+Zg7tVb8W2HAFgd7+jH70WDONk3pYlrwjecMAmJ
         6n72lDt03i1cg9OC1gO9XeyXSUTXnmBttow0SRtqD+ihHAVEKZeIQjMUaQ/krPOXTkCN
         CS1eD7s1z1Mg5GUFeTijn70PRUkbrKNee4U8+r4G56574LL/FwrJNi9nv5robUgd30Hu
         mmyA==
X-Forwarded-Encrypted: i=1; AJvYcCU9y/4n07FHU7R5CfurNvNGxyNbP9NKWWLVSnmb86nF7+cd183gQTdXnT0hERwG3lhabhtlHRY7PWJiIVHoHyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGV9rS1OdZ/Fr4bNiTnKWLGAwYb4HDiCM+MFczgg5R5q7y4Yhc
	iUiiM1b+IQbGRK3+wSzzJZa58tjFCzvsBRxfjbTyM3Z9d40fwZn2Hc4mG3mHdPbgcRT7xyI3y/g
	NsBMsDU6eLamgBejNf7G3mOR5W2/hIjRi+ia7q4n3xPe8XGMH3zF3
X-Gm-Gg: ASbGncsjFwa2N6JBYqMDgFsj4Ckyj1r6drd08OomrJPIqsyJxlQQ+a0ax3SSyKrd1If
	yEVC+D/AEZZYqZP7IrbZHkxspFq5k6l0c0UBQFLKKQIcNUQqQYRpLgAGt7nujUXezowNDt6hGt3
	5N8imiQEMBZh5qleLXLBdTlK7koJQ968PNPMAXaM+X0CLk20KR55oOwcai3uEqcw+a7QoER3fQ/
	X80EXm3HsmeNPQqnGzKzLNxmOi5y1iEDdiadshSx9p0E0RQNm0Z2BdVloN1s+oeOdjxEaU/Iw08
	y6YClQaCh/W1DAy0FI/qjpO7XkMSMBs=
X-Google-Smtp-Source: AGHT+IEdx8HRP6xsgBEjUmO2DeV6senhWXHAUMEoAVUkT+kS0XOIeb0eXf3BUdYuH6T+VAeDasj1/HNEISGu
X-Received: by 2002:a05:6214:1948:b0:6fa:c054:1628 with SMTP id 6a1803df08f44-6fad1952e3amr1063796d6.23.1748562457042;
        Thu, 29 May 2025 16:47:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6fac6f25b62sm1245406d6.44.2025.05.29.16.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 16:47:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2B179340686;
	Thu, 29 May 2025 17:47:35 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id AC686E40148; Thu, 29 May 2025 17:47:34 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Thu, 29 May 2025 17:47:10 -0600
Subject: [PATCH v8 1/9] ublk: have a per-io daemon instead of a per-queue
 daemon
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-ublk_task_per_io-v8-1-e9d3b119336a@purestorage.com>
References: <20250529-ublk_task_per_io-v8-0-e9d3b119336a@purestorage.com>
In-Reply-To: <20250529-ublk_task_per_io-v8-0-e9d3b119336a@purestorage.com>
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
 drivers/block/ublk_drv.c      | 111 +++++++++++++++++++++---------------------
 include/uapi/linux/ublk_cmd.h |   9 ++++
 2 files changed, 65 insertions(+), 55 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1b47341962d095830a02e07418815f633fa9ed8a..ea42bb6ad5b3c9e0e70a856f2f7f8706c56eb89f 100644
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
@@ -1330,24 +1326,22 @@ static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct request *rq = pdu->req_list;
-	struct ublk_queue *ubq = pdu->ubq;
 	struct request *next;
 
 	do {
 		next = rq->rq_next;
 		rq->rq_next = NULL;
-		ublk_dispatch_req(ubq, rq, issue_flags);
+		ublk_dispatch_req(rq->mq_hctx->driver_data, rq, issue_flags);
 		rq = next;
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
@@ -1355,13 +1349,10 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
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
 
@@ -1429,24 +1420,25 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
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
+	if (!rq_list_empty(&submit_list))
+		ublk_queue_cmd_list(io, &submit_list);
 	*rqlist = requeue_list;
 }
 
@@ -1474,17 +1466,6 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
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
 
@@ -1495,6 +1476,17 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
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
 
@@ -1516,7 +1508,7 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
 
-	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
+	/* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
 	ub->mm = NULL;
 	ub->nr_queues_ready = 0;
 	ub->nr_privileged_daemon = 0;
@@ -1783,6 +1775,7 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
 	struct task_struct *task;
+	struct ublk_io *io;
 
 	if (WARN_ON_ONCE(!ubq))
 		return;
@@ -1791,13 +1784,14 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
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
 
@@ -1930,8 +1924,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 {
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
-		ubq->ubq_daemon = current;
-		get_task_struct(ubq->ubq_daemon);
 		ub->nr_queues_ready++;
 
 		if (capable(CAP_SYS_ADMIN))
@@ -2084,6 +2076,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 	}
 
 	ublk_fill_io_cmd(io, cmd, buf_addr);
+	WRITE_ONCE(io->task, get_task_struct(current));
 	ublk_mark_io_ready(ub, ubq);
 out:
 	mutex_unlock(&ub->mutex);
@@ -2179,6 +2172,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       const struct ublksrv_io_cmd *ub_cmd)
 {
 	struct ublk_device *ub = cmd->file->private_data;
+	struct task_struct *task;
 	struct ublk_queue *ubq;
 	struct ublk_io *io;
 	u32 cmd_op = cmd->cmd_op;
@@ -2193,13 +2187,14 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
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
@@ -2449,9 +2444,14 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
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
@@ -2923,7 +2923,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	ub->dev_info.flags &= UBLK_F_ALL;
 
 	ub->dev_info.flags |= UBLK_F_CMD_IOCTL_ENCODE |
-		UBLK_F_URING_CMD_COMP_IN_TASK;
+		UBLK_F_URING_CMD_COMP_IN_TASK |
+		UBLK_F_PER_IO_DAEMON;
 
 	/* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
 	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
@@ -3188,14 +3189,14 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
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


