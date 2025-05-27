Return-Path: <linux-kselftest+bounces-33898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A907AC5D8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 01:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E293B89E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 23:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D601721C163;
	Tue, 27 May 2025 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GoHx0+Ck"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426F2192EC
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748386904; cv=none; b=YVy581DCwYgkHZkvEOY9su1vFSSTPcbM5Zr3fJPLol64SW04KgrGn/5ZaeZO6riIZysWKXhL29WF6N8YmJqhcrq4GW82hEzgyJ6CP/3OtySEg29fiWSjTQm/CL8xnWPPYYWnvEo+g/sSeV/XGuXi73ef3Kkc6bdNJ4Je+oqgMtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748386904; c=relaxed/simple;
	bh=qES60JSu/K+yFwLFZmy82U9Uxk4M4qim1oGumvvu1dA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jh8TsvOWnYbMI3cZEQdvEfQOyfUh0QykuJtQEu7/mFVniRLzl7ePuMKDbMy5UVP2JjuaF+Ew0RNaRYmtrCuR0fiCaYvn7cstmjQpGIYf3BfWL60ALn7YuEeLPU5klRytU3B6qnv5z8n1WKe37ZH35bbj7DOmCx2U5oYEUOmrRZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GoHx0+Ck; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-6ff4faf858cso26110027b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 16:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748386898; x=1748991698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EU8NQz7DPnBwqdqYXyfetLnAiIrM1dPCrBk0SlQjiRs=;
        b=GoHx0+CkNXFOqh23Xd5TcZr+WSCKO8TjGYfCX1Nn7n6EGXgdpT/eg84iZhbF8xlYZH
         khCBP3Pv/0vCXBxRjjoohFz6gF8jNdB5BqFgAHP2iQOpB4ko8fvrzTMZH4SVltdxv5aN
         mVz4/aKE4fAjlCic7J22MmmElEmK9GqMpUWdkWcrEXg9F8M/y+QeyafmtE+C57kHdKfd
         SR0Ow6eOImvRL9mPpEJMEhmK6TZqja9MQ9KzGTHra6y4GrBN+QaLPOcn2prHI6cQOxmE
         XR/Q93DMC6aSfFE+lqZ1uUVMkM7/qBCHP5p/BSHgd2u51V5HNpSBxBSGYADJ+aHKmS8D
         Ykdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748386898; x=1748991698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EU8NQz7DPnBwqdqYXyfetLnAiIrM1dPCrBk0SlQjiRs=;
        b=Nte4AzA/1D78kSHN0uWjumcgC2E8r4bhH2pn0FTDhmJPuI0KxaZ2/PjOOpdatOOaww
         4a78gKQvao6NapIZkB2wLKtv7gfPuntImW6Tgf1k7ZIqDwoOAyQVTQbgY8135Okh5jQc
         r9c1bJkm0H42rCEtkUFYUJjnTQmSqx0dE0aicUXwiVuscCk6dJXNZ1fs/31q0JjmwdxU
         4VPWbEgkaImg0RERjH5KAHIQqGqQReUFxDMnvRFycYxZjRZiOf+3yx29YYViTL9r6Xcd
         d/PjZpcVWYqQVfG5Yp0kegs43zSiQdceMYBTr5s0FWQAvKx+e49UfKdvuhGWZ1EpshGO
         VpMw==
X-Forwarded-Encrypted: i=1; AJvYcCUWvU02YsO9wlvGOhKsfFTueaOvJ/1eodGMy7B/umepobMUvLNSBk0i4blv3wVoRetbtF1DJQq+s03ZNCJcs+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOpJxeSAfYddlOcbBI9povEd3uKBd65fFDiXkjaWFRuH26mH46
	wLbWxGbsS6en1optNY9biqUPOdMpquR8pcDBACSiqAH0L2iFJ9KnEXn+heorG/08eKuv87/t4wm
	GzwnaqskkYnv42EGKzLsVMf+RCSL8ZcVHHQLuVSgxjkhP/icbC5e/
X-Gm-Gg: ASbGnctdIe00DKHOWWfLV95VfLu7lnvPsTjIb6iS0fnrNQJTWY1nrsrGrr0kxRj6Q3y
	brA/A9MNtIDDPrTYN0EhaHw7JxfoeoDCuDLMv4YkBLmnmtHU2jT23mWwJy1AAwxbA6mF/y7om63
	FjxT1DSUCcT6Dm3tYGJ0sRi33KXp9e5O/hHFCDUChRuuUbuW4geIH3qVrShVvSMzVys9za/1b0w
	qFy0CjrG/pBwwudNwLgO242zVmYZqFy56hAdBBIVncPXDvFs+tSlZQWh2pUFE3tK+CxomU9c3EQ
	Z+LeCEHi/3L4dyZx7CM0Kd/IXsfkBwU=
X-Google-Smtp-Source: AGHT+IFT+ve15tPMOtktemqaYLdkPZKyfIGmNFcraFbIwoa9ZtFkAPaFtcrSy/91uQAoV84ue8AEJZoorplg
X-Received: by 2002:a05:690c:f94:b0:70d:ecdd:9bd3 with SMTP id 00721157ae682-70e2dace404mr189430147b3.27.1748386898062;
        Tue, 27 May 2025 16:01:38 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-70ed5eabbe4sm164437b3.63.2025.05.27.16.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 16:01:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 63CF4340245;
	Tue, 27 May 2025 17:01:37 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 21DA9E401C2; Tue, 27 May 2025 17:01:36 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 27 May 2025 17:01:25 -0600
Subject: [PATCH v7 2/8] selftests: ublk: kublk: plumb q_id in io_uring
 user_data
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-ublk_task_per_io-v7-2-cbdbaf283baa@purestorage.com>
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

Currently, when we process CQEs, we know which ublk_queue we are working
on because we know which ring we are working on, and ublk_queues and
rings are in 1:1 correspondence. However, as we decouple ublk_queues
from ublk server threads, ublk_queues and rings will no longer be in 1:1
correspondence - each ublk server thread will have a ring, and each
thread may issue commands against more than one ublk_queue. So in order
to know which ublk_queue a CQE refers to, plumb that information in the
associated SQE's user_data.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/fault_inject.c |  2 +-
 tools/testing/selftests/ublk/file_backed.c  | 10 +++++-----
 tools/testing/selftests/ublk/kublk.c        | 17 +++++++++--------
 tools/testing/selftests/ublk/kublk.h        | 17 +++++++++++++----
 tools/testing/selftests/ublk/null.c         | 12 ++++++------
 tools/testing/selftests/ublk/stripe.c       |  9 +++++----
 6 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
index 5421774d7867cb5b0edd96dc702a4f85a75f9e6f..5deff76327b270d2d2d4553c394d95bf27ce8d7e 100644
--- a/tools/testing/selftests/ublk/fault_inject.c
+++ b/tools/testing/selftests/ublk/fault_inject.c
@@ -48,7 +48,7 @@ static int ublk_fault_inject_queue_io(struct ublk_queue *q, int tag)
 
 	ublk_queue_alloc_sqes(q, &sqe, 1);
 	io_uring_prep_timeout(sqe, &ts, 1, 0);
-	sqe->user_data = build_user_data(tag, ublksrv_get_op(iod), 0, 1);
+	sqe->user_data = build_user_data(tag, ublksrv_get_op(iod), 0, q->q_id, 1);
 
 	ublk_queued_tgt_io(q, tag, 1);
 
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 509842df9beefa494a4130f5fb23fb022d7fa326..0e86123e309c77ad946eaca33a8f4680b688cd41 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -22,7 +22,7 @@ static int loop_queue_flush_io(struct ublk_queue *q, const struct ublksrv_io_des
 	io_uring_prep_fsync(sqe[0], 1 /*fds[1]*/, IORING_FSYNC_DATASYNC);
 	io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
 	/* bit63 marks us as tgt io */
-	sqe[0]->user_data = build_user_data(tag, ublk_op, 0, 1);
+	sqe[0]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 	return 1;
 }
 
@@ -48,7 +48,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 			sqe[0]->buf_index = tag;
 		io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
 		/* bit63 marks us as tgt io */
-		sqe[0]->user_data = build_user_data(tag, ublk_op, 0, 1);
+		sqe[0]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 		return 1;
 	}
 
@@ -57,17 +57,17 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 	sqe[0]->user_data = build_user_data(tag,
-			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, 1);
+			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
 
 	io_uring_prep_rw(op, sqe[1], 1 /*fds[1]*/, 0,
 		iod->nr_sectors << 9,
 		iod->start_sector << 9);
 	sqe[1]->buf_index = tag;
 	sqe[1]->flags |= IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
-	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, 1);
+	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 
 	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, tag);
-	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, 1);
+	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
 	return 2;
 }
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index b5131a000795d6a8d589bd7ade6cce4216dbe182..c3bb52953936134b7ddcf4632b57fdeb57d2d45e 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -627,7 +627,7 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
 	if (q->state & UBLKSRV_AUTO_BUF_REG)
 		ublk_set_auto_buf_reg(q, sqe[0], tag);
 
-	user_data = build_user_data(tag, _IOC_NR(cmd_op), 0, 0);
+	user_data = build_user_data(tag, _IOC_NR(cmd_op), 0, q->q_id, 0);
 	io_uring_sqe_set_data64(sqe[0], user_data);
 
 	io->flags = 0;
@@ -673,10 +673,11 @@ static inline void ublksrv_handle_tgt_cqe(struct ublk_queue *q,
 		q->tgt_ops->tgt_io_done(q, tag, cqe);
 }
 
-static void ublk_handle_cqe(struct io_uring *r,
+static void ublk_handle_cqe(struct ublk_dev *dev,
 		struct io_uring_cqe *cqe, void *data)
 {
-	struct ublk_queue *q = container_of(r, struct ublk_queue, ring);
+	unsigned q_id = user_data_to_q_id(cqe->user_data);
+	struct ublk_queue *q = &dev->q[q_id];
 	unsigned tag = user_data_to_tag(cqe->user_data);
 	unsigned cmd_op = user_data_to_op(cqe->user_data);
 	int fetch = (cqe->res != UBLK_IO_RES_ABORT) &&
@@ -727,17 +728,17 @@ static void ublk_handle_cqe(struct io_uring *r,
 	}
 }
 
-static int ublk_reap_events_uring(struct io_uring *r)
+static int ublk_reap_events_uring(struct ublk_queue *q)
 {
 	struct io_uring_cqe *cqe;
 	unsigned head;
 	int count = 0;
 
-	io_uring_for_each_cqe(r, head, cqe) {
-		ublk_handle_cqe(r, cqe, NULL);
+	io_uring_for_each_cqe(&q->ring, head, cqe) {
+		ublk_handle_cqe(q->dev, cqe, NULL);
 		count += 1;
 	}
-	io_uring_cq_advance(r, count);
+	io_uring_cq_advance(&q->ring, count);
 
 	return count;
 }
@@ -756,7 +757,7 @@ static int ublk_process_io(struct ublk_queue *q)
 		return -ENODEV;
 
 	ret = io_uring_submit_and_wait(&q->ring, 1);
-	reapped = ublk_reap_events_uring(&q->ring);
+	reapped = ublk_reap_events_uring(q);
 
 	ublk_dbg(UBLK_DBG_QUEUE, "submit result %d, reapped %d stop %d idle %d\n",
 			ret, reapped, (q->state & UBLKSRV_QUEUE_STOPPING),
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index e34508bf5798b539f0290e21b37b591dc5689f59..424e5d96775fe97b20ad8d5537e468477041ca04 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -49,7 +49,8 @@
 #define UBLKSRV_IO_IDLE_SECS		20
 
 #define UBLK_IO_MAX_BYTES               (1 << 20)
-#define UBLK_MAX_QUEUES                 32
+#define UBLK_MAX_QUEUES_SHIFT		5
+#define UBLK_MAX_QUEUES                 (1 << UBLK_MAX_QUEUES_SHIFT)
 #define UBLK_QUEUE_DEPTH                1024
 
 #define UBLK_DBG_DEV            (1U << 0)
@@ -225,11 +226,14 @@ static inline int is_target_io(__u64 user_data)
 }
 
 static inline __u64 build_user_data(unsigned tag, unsigned op,
-		unsigned tgt_data, unsigned is_target_io)
+		unsigned tgt_data, unsigned q_id, unsigned is_target_io)
 {
-	assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16));
+	/* we only have 7 bits to encode q_id */
+	_Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
+	assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16) && !(q_id >> 7));
 
-	return tag | (op << 16) | (tgt_data << 24) | (__u64)is_target_io << 63;
+	return tag | (op << 16) | (tgt_data << 24) |
+		(__u64)q_id << 56 | (__u64)is_target_io << 63;
 }
 
 static inline unsigned int user_data_to_tag(__u64 user_data)
@@ -247,6 +251,11 @@ static inline unsigned int user_data_to_tgt_data(__u64 user_data)
 	return (user_data >> 24) & 0xffff;
 }
 
+static inline unsigned int user_data_to_q_id(__u64 user_data)
+{
+	return (user_data >> 56) & 0x7f;
+}
+
 static inline unsigned short ublk_cmd_op_nr(unsigned int op)
 {
 	return _IOC_NR(op);
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index 44aca31cf2b05861b9378b5e2b38971754aabe3e..c415bf839e87ba35bc87da523a32745584ee2ae4 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -43,7 +43,7 @@ static int ublk_null_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 }
 
 static void __setup_nop_io(int tag, const struct ublksrv_io_desc *iod,
-		struct io_uring_sqe *sqe)
+		struct io_uring_sqe *sqe, int q_id)
 {
 	unsigned ublk_op = ublksrv_get_op(iod);
 
@@ -52,7 +52,7 @@ static void __setup_nop_io(int tag, const struct ublksrv_io_desc *iod,
 	sqe->flags |= IOSQE_FIXED_FILE;
 	sqe->rw_flags = IORING_NOP_FIXED_BUFFER | IORING_NOP_INJECT_RESULT;
 	sqe->len = iod->nr_sectors << 9; 	/* injected result */
-	sqe->user_data = build_user_data(tag, ublk_op, 0, 1);
+	sqe->user_data = build_user_data(tag, ublk_op, 0, q_id, 1);
 }
 
 static int null_queue_zc_io(struct ublk_queue *q, int tag)
@@ -64,14 +64,14 @@ static int null_queue_zc_io(struct ublk_queue *q, int tag)
 
 	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
 	sqe[0]->user_data = build_user_data(tag,
-			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, 1);
+			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 
-	__setup_nop_io(tag, iod, sqe[1]);
+	__setup_nop_io(tag, iod, sqe[1], q->q_id);
 	sqe[1]->flags |= IOSQE_IO_HARDLINK;
 
 	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, tag);
-	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, 1);
+	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
 	// buf register is marked as IOSQE_CQE_SKIP_SUCCESS
 	return 2;
@@ -83,7 +83,7 @@ static int null_queue_auto_zc_io(struct ublk_queue *q, int tag)
 	struct io_uring_sqe *sqe[1];
 
 	ublk_queue_alloc_sqes(q, sqe, 1);
-	__setup_nop_io(tag, iod, sqe[0]);
+	__setup_nop_io(tag, iod, sqe[0], q->q_id);
 	return 1;
 }
 
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 404a143bf3d69599aea3d7119e9ba50d6d739ba8..4fc45f42b02ecfe063d88d78644ffc142e122942 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -144,7 +144,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_
 		io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
 		sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 		sqe[0]->user_data = build_user_data(tag,
-			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, 1);
+			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
 	}
 
 	for (i = zc; i < s->nr + extra - zc; i++) {
@@ -162,13 +162,14 @@ static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_
 				sqe[i]->flags |= IOSQE_IO_HARDLINK;
 		}
 		/* bit63 marks us as tgt io */
-		sqe[i]->user_data = build_user_data(tag, ublksrv_get_op(iod), i - zc, 1);
+		sqe[i]->user_data = build_user_data(tag, ublksrv_get_op(iod), i - zc, q->q_id, 1);
 	}
 	if (zc) {
 		struct io_uring_sqe *unreg = sqe[s->nr + 1];
 
 		io_uring_prep_buf_unregister(unreg, 0, tag, q->q_id, tag);
-		unreg->user_data = build_user_data(tag, ublk_cmd_op_nr(unreg->cmd_op), 0, 1);
+		unreg->user_data = build_user_data(
+			tag, ublk_cmd_op_nr(unreg->cmd_op), 0, q->q_id, 1);
 	}
 
 	/* register buffer is skip_success */
@@ -185,7 +186,7 @@ static int handle_flush(struct ublk_queue *q, const struct ublksrv_io_desc *iod,
 	for (i = 0; i < conf->nr_files; i++) {
 		io_uring_prep_fsync(sqe[i], i + 1, IORING_FSYNC_DATASYNC);
 		io_uring_sqe_set_flags(sqe[i], IOSQE_FIXED_FILE);
-		sqe[i]->user_data = build_user_data(tag, UBLK_IO_OP_FLUSH, 0, 1);
+		sqe[i]->user_data = build_user_data(tag, UBLK_IO_OP_FLUSH, 0, q->q_id, 1);
 	}
 	return conf->nr_files;
 }

-- 
2.34.1


