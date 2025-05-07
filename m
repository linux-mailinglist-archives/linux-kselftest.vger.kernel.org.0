Return-Path: <linux-kselftest+bounces-32615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6507AAEE16
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 23:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2FED5221BD
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 21:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8AC28F93E;
	Wed,  7 May 2025 21:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="G+rpuUPL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533B280A57
	for <linux-kselftest@vger.kernel.org>; Wed,  7 May 2025 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746654594; cv=none; b=jjR3aAkitu49ld0SrjxAgmyADvALYCkfFnnKsjx4AoyvGvTp+SJLdYRo75EnG8ZImTW6U/SJJaomFyb/ZbJPsAA2obZJBFg7jzcCzvkV4j+yNFqa8y4Tjdl7o76VL6BjnqfPQWCkSViRE2UiRrntdfhwJfDpHb618ECfeXW10nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746654594; c=relaxed/simple;
	bh=D1cVAokwmZuQgiCyVSlWySGsG80QVl3UpmWcwv6AuD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OVpS0aQ1u1tcH6tn13CDm1zNBcJt0HZ8hItZHbQdCrI75b03UY6iYo10f+80LF038ZqACcQCTZYIINbei58mBa6q+8bDurA2+HAHZo76nulmVXoInVOWtXp1tTjciTSWYL5hMAnVv6KSi/fMXpWvwl4GgygzYEjQLSK2AOoXTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=G+rpuUPL; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-30a509649e3so322773a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 07 May 2025 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746654590; x=1747259390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uo3rcPLb6pcskl/ZtvGETJtCS5bmUi6jivJUjqtcmpo=;
        b=G+rpuUPL04uE75qv9+r2HsQLFXWmmajhJR3hgKiEksNBs2s0IFqmoxQXmGYWzgEKVP
         vUAP1fx+Lse0/cEa8gkyLXsMyXKlcLkyuZ50cLXsvJis4sjAo8qThNSGfGPKsGOeapEu
         xShja6RCv9Is3m6h9O4mUsYwa0ABLhkZsJfa+/HH/sL07k+1G5iKDtPxQ3TKFEaIpcUg
         lBm/8z6XGju2LiCvy30coyy7Bf5PYfhJFt2uZ1KvaCVpv4RBcTjBHggIrcaGXIkaT3/0
         ZMaBgn6PtN5wXs3wP4TOtlPHLvWH9/Ciz/nCyuvcTXHEMqMcnoJEBIx5oDWzZxG/eeG3
         HwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746654590; x=1747259390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uo3rcPLb6pcskl/ZtvGETJtCS5bmUi6jivJUjqtcmpo=;
        b=Dw9xiXFTjtmOeZspf1Ca8GzaW1qiHujcdyBPIrLCi6sfRrw+OoxZvRMXXT+lE1ghVj
         oWv4jfjVsl9xvh6oXE35+xaIjB3CV5KKZHMB6Zh3/Qsc4VM71tSkdkHY6lANakUdRBKY
         5pU6OvWtHjiLUamat5iZnX5e03exurvUz8jZOMO6LgAeht2PJt/+YltEQw6pKxWI19Cc
         zNGJPrXgC1f5LIWD1ReWZWBQICOBmjNeJ8/RpC8CV6kDtgIoS2qoXTk5wZPEdY09XrLa
         Aj71EyBQ/rErG67dm4//EOC4cidvxx8tUMfIg93c+XBMJ4ta8qbH0pZxuq5LprlZRXyC
         y6Ag==
X-Forwarded-Encrypted: i=1; AJvYcCX4sFNdfvNBIY4NgPOwrBINCwjx3HP6DdQOOCw1WqEua4gBc4E6T4kj6VfrbSUDktN2KKXLv+B9RmDQla7ygQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4qUQbE0teKrL5Em+UYMO3QpCoZMrkO7T1yFvc6FzOIGbjoVpA
	+7ZuG75uuhj/msY8LLI+fRTppImAWYkgHozxOoVw5s5IyTBH1iHgdJ00v+G/dV4XvHtxHRxDFdP
	Dv1TlCSz2PV6OTPHmMFMEr4rANBWcjJUn
X-Gm-Gg: ASbGncsV9HC3hSne6jlJdQLtsHPMIJGZa1EA/AVExZSlbUGUYwSDfeESjfkFq09j0vG
	tZi4Jv/Abxa/N1AIRrfkixv7U9Hxhk6Pxm4gZDr9OFvUR7DmwidZH/Txf/fZQAfzL+DdRElCBwo
	6f+9uRJCs1TdxkKmlCitqFUB8efcCXtNzBvX0SUY0f9tCPFmqzc1qL83GKez9XTM/3hhLh9GSKK
	vKVQcPd+MZ9+BAIsF3xKLXfzQrKRYKBRHYONOq8LTpwA6JN+e+9UmJK/fH+UyhXqanBvHslqyy4
	c/sVJ9CXlQ6tU2iFP7HxS9wEVZ8xiUZKuN3iTg2Wz8K4KQ==
X-Google-Smtp-Source: AGHT+IFtRb8fmMFsClHK9escN84wsH3bXyB8H0d/HOqK/juAohiLcfQobEpHHljaIMLBtRT8C96u6WOTdLPt
X-Received: by 2002:a17:90b:38c6:b0:2f5:88bb:118 with SMTP id 98e67ed59e1d1-30aac21f342mr6148609a91.22.1746654590016;
        Wed, 07 May 2025 14:49:50 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22e797f5ec0sm605785ad.38.2025.05.07.14.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 14:49:50 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 441BB340405;
	Wed,  7 May 2025 15:49:49 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 34610E401BF; Wed,  7 May 2025 15:49:49 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 07 May 2025 15:49:35 -0600
Subject: [PATCH v6 1/8] ublk: have a per-io daemon instead of a per-queue
 daemon
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-ublk_task_per_io-v6-1-a2a298783c01@purestorage.com>
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
Imbalanced load can then be balanced across all ublk server threads as
follows:

- specifying the new UBLK_F_RR_TAGS flag when creating the ublk device,
  to ensure round-robin tag allocation
- having the ublk server threads issue FETCH_REQs in a round-robin
  manner. As a small toy example, consider a system with a single ublk
  device having 2 queues, each of depth 4. A ublk server having 4
  threads could issue its FETCH_REQs against this device as follows
  (where each entry is the qid,tag pair that the FETCH_REQ targets):

  ublk server thread:	T0	T1	T2	T3
			0,0	0,1	0,2	0,3
			1,3	1,0	1,1	1,2

The combination of these two changes allow a ublk server to balance
load. For example, suppose a program quickly issues 4 I/Os concurrently.
Before this change, all 4 I/Os would have had to be serviced by the same
thread, and that thread may become a bottleneck. With this change, those
4 I/Os would get tags 0-3 for the same queue, and would thus spread out
evenly over all the ublk server threads. Peak bandwidth in CPU-limited
workloads under imbalanced load thus will increase.

The UBLK_F_RR_TAGS flag is also added as a feature, so that ublk servers
can essentially test for the presence of this patch and tailor their
behavior accordingly.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c      | 82 ++++++++++++++++++++++---------------------
 include/uapi/linux/ublk_cmd.h |  8 +++++
 2 files changed, 50 insertions(+), 40 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index cb612151e9a1de7630c49a2b78d278e005d52856..ff5beab32220ea96a1e15ab26c02f4883a6c3d6e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -66,7 +66,8 @@
 		| UBLK_F_USER_COPY \
 		| UBLK_F_ZONED \
 		| UBLK_F_USER_RECOVERY_FAIL_IO \
-		| UBLK_F_UPDATE_SIZE)
+		| UBLK_F_UPDATE_SIZE \
+		| UBLK_F_RR_TAGS)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
@@ -148,6 +149,8 @@ struct ublk_io {
 		/* valid if UBLK_IO_FLAG_OWNED_BY_SRV is set */
 		struct request *req;
 	};
+
+	struct task_struct *task;
 };
 
 struct ublk_queue {
@@ -155,11 +158,9 @@ struct ublk_queue {
 	int q_depth;
 
 	unsigned long flags;
-	struct task_struct	*ubq_daemon;
 	struct ublksrv_io_desc *io_cmd_buf;
 
 	bool force_abort;
-	bool timeout;
 	bool canceling;
 	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
 	unsigned short nr_io_ready;	/* how many ios setup */
@@ -1069,11 +1070,6 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
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
@@ -1207,13 +1203,13 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
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
@@ -1286,13 +1282,10 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
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
 
@@ -1405,17 +1398,6 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
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
 
@@ -1426,6 +1408,17 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
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
 
@@ -1447,7 +1440,7 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
 
-	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
+	/* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
 	ub->mm = NULL;
 	ub->nr_queues_ready = 0;
 	ub->nr_privileged_daemon = 0;
@@ -1722,7 +1715,7 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 		return;
 
 	task = io_uring_cmd_get_task(cmd);
-	if (WARN_ON_ONCE(task && task != ubq->ubq_daemon))
+	if (WARN_ON_ONCE(task && task != ubq->ios[pdu->tag].task))
 		return;
 
 	if (!ubq->canceling)
@@ -1861,8 +1854,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 {
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
-		ubq->ubq_daemon = current;
-		get_task_struct(ubq->ubq_daemon);
 		ub->nr_queues_ready++;
 
 		if (capable(CAP_SYS_ADMIN))
@@ -1995,6 +1986,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 	}
 
 	ublk_fill_io_cmd(io, cmd, buf_addr);
+	WRITE_ONCE(io->task, get_task_struct(current));
 	ublk_mark_io_ready(ub, ubq);
 out:
 	mutex_unlock(&ub->mutex);
@@ -2062,6 +2054,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       const struct ublksrv_io_cmd *ub_cmd)
 {
 	struct ublk_device *ub = cmd->file->private_data;
+	struct task_struct *task;
 	struct ublk_queue *ubq;
 	struct ublk_io *io;
 	u32 cmd_op = cmd->cmd_op;
@@ -2076,13 +2069,14 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
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
@@ -2332,9 +2326,15 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 {
 	int size = ublk_queue_cmd_buf_size(ub, q_id);
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
+	struct ublk_io *io;
+	int i;
+
+	for (i = 0; i < ubq->q_depth; i++) {
+		io = &ubq->ios[i];
+		if (io->task)
+			put_task_struct(io->task);
+	}
 
-	if (ubq->ubq_daemon)
-		put_task_struct(ubq->ubq_daemon);
 	if (ubq->io_cmd_buf)
 		free_pages((unsigned long)ubq->io_cmd_buf, get_order(size));
 }
@@ -2487,6 +2487,8 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 	ub->tag_set.numa_node = NUMA_NO_NODE;
 	ub->tag_set.cmd_size = sizeof(struct ublk_rq_data);
 	ub->tag_set.driver_data = ub;
+	if (ub->dev_info.flags & UBLK_F_RR_TAGS)
+		ub->tag_set.flags |= BLK_MQ_F_TAG_RR;
 	return blk_mq_alloc_tag_set(&ub->tag_set);
 }
 
@@ -3062,14 +3064,14 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
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
index be5c6c6b16e098838a2bf790e588b79656defdda..3ba8f26d60bc70ade95b4f4d5990157af2bd5b2e 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -219,6 +219,14 @@
  */
 #define UBLK_F_UPDATE_SIZE		 (1ULL << 10)
 
+/*
+ * Force tags to be allocated round-robin on each queue. If ublk server
+ * threads also issue FETCH_REQs against the queues in a round-robin
+ * manner, load can be balanced across all threads even if it is issued
+ * to the queues in an imbalanced way.
+ */
+#define UBLK_F_RR_TAGS (1ULL << 11)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1

-- 
2.34.1


