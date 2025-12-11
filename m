Return-Path: <linux-kselftest+bounces-47382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D41CB4BB3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 06:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5A5C3001618
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 05:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9069D2882B4;
	Thu, 11 Dec 2025 05:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AGGnHxE2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D80E22F74A
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765430197; cv=none; b=DGxF4BvOFIf2+reXqcu/n3ksgkzV065/FsxwPB+plT5tINbsYaRSrAY1mJgC7oAXaq1GTXKcQiZC/zYbwZJCvs56AVfpLmquzpY2kAIoPyoU56hyKban06QYwDOww0mRfuRJOFLlBYB27D4FHKWVNlPbLhgwO3uphF7c7VRvnkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765430197; c=relaxed/simple;
	bh=H8+lM69iv5qCmRMMluYOvti1KXWYY1Kk4tnxl2GjLh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvswERTFDqBtN9DHJiT+mIIfRGTgB+m1uSOOk1T5N7r1qq8r5ytsdMcd3hUUqvF1VeiUFr57vZGJy41O7KZasfY9GrTFjL/kSOB+QHOtRCa1/ucQvorhN9Xa8UI6spbLSE5boiZAqMa0tj4IQ/kc/atpEWOgSfOPqyXaNzuiL1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AGGnHxE2; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-349e7fe50c3so97726a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 21:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765430193; x=1766034993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCjPwdDIC2dmLc08xrPilw3BWqBvNUC2kT6efTWfh3M=;
        b=AGGnHxE2lyLkB4DgO02Mn5QANLlkFvvK8gJZwgttzAC1j/nYZTS1KCUT4FJCpUKotj
         QKvKXe2hR7lVWTunLgY3KKD6Ry9E3PGpsUx/8OP6mDRyLfl8UN5QWImrqnZIojfnhHOb
         z1QVfBB4iFGMWS3AUVp6WZVb6GmBQEDKQEqknc6h9E+HJW2Bb/78YYg+EZo9wdKpVypo
         pqd47Mrmh9pJpfjhEe8sN5lYIQEg66uGBxE/CKVIsb7yGYgFTs6Sxa90vqJYgJ1EKLQC
         czCRmkCWZ9OpJ45b6G+NEDJ7sZfSlwDOz8Vr8HVYQ3LrSzXFjSSxrsXb1qLDkKjjQXxU
         lQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765430193; x=1766034993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KCjPwdDIC2dmLc08xrPilw3BWqBvNUC2kT6efTWfh3M=;
        b=Nhf3J9yxS2GwR+XdH7KFMIT/zsB9kcLp1WwIKdY8qkLxgwOB7m5j3LsONDHkunjKtj
         a977v4x+W7r7Qelq40VZLd3b+b123tlP9ga6Rc8oEhAUqFajubsE5U6lZcNaHUQURodv
         /12eSbKPs93ebnYoe4nszezqdb6G2eFuR/4oKcqYI49brI4HRl/G+Xm5kgDD5b68WzIK
         LPcl0NIB14sIei55T0IaOoRvQEUm15hnjkGQrfshARJublb4ZPK/vLWl48yT08aFK7rD
         VlIA33btEYjlTJNoBLprpPJltSAOuM/X5iWs/l+hN/KZgnw5RQx8UMicwvADnzVLSQ0m
         rirw==
X-Forwarded-Encrypted: i=1; AJvYcCUrp4pZzEqSDeGNSvlixStfVFo9VRQ53IvgtVXY3ZFm46tLJ7bsG1C0Lzg+csI6nv8L588aVr+uPGqhIYbJhmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziVpF/sg47UXyI0VcbFT6/rzWaKjQ82Xwe4hYkUd8AqgP1PZXk
	b+ijknvhbA28wvzCpE2MeSxnhettGfFpTtoZRQZxlvESP1h5D+aVCCcqRa5u5SEgCeoXGbv5Qyp
	KRLDutHFTmGMxewnzUQgU/tXhTH4B/tF/mT3v
X-Gm-Gg: AY/fxX7aaHcfr55XHAJ7pwVOvgCJEX/e5PKu1KVNFbl1ybQB/sz1wIfJaG+wBygh25O
	K7rbHsHu4whzrjbsKQHRZQY7sFLld1cpjmqzmgezejzKXFIvZlEug4oqOvybhb4+yxRkiD48bqn
	8E/+c1T+aRRg+kRs/bRh5xELuYRAC1HarYEi4WcGUeyNMINDXcC9A8uoK7LDarejLmW+YRkXOo0
	P1MjZ6NSy2Jf4Hz3cxRyiUkmJqEigVOwMSZXnM1f4BYufUw53+hDgc95bbOUJaBhL0wR8+4wJ6u
	JWHP3YdyUwQH42eSznHFXTRzXNJ3KE4OeXLoUl2zlCcZnAzWiJwA+XehgOwAONu/s+yvO/5hMpx
	psOcNy47mGvVte5uvg8ty54mKsFaa85Opfb9/gY5whQ==
X-Google-Smtp-Source: AGHT+IH8nf8DhaSQgUIqG7NhTB2uslZoNpvSBpi7a9ZC7nWQ5LhOiMMVgrzF2ASWsGMPe0ESj3i9yC3un7y1
X-Received: by 2002:a17:90b:390a:b0:340:e8e4:1166 with SMTP id 98e67ed59e1d1-34a906fa162mr949142a91.5.1765430193445;
        Wed, 10 Dec 2025 21:16:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34a9264c3b2sm100915a91.2.2025.12.10.21.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 21:16:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DAC98341FDC;
	Wed, 10 Dec 2025 22:16:32 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D85B3E41888; Wed, 10 Dec 2025 22:16:32 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 7/8] selftests: ublk: add support for user copy to kublk
Date: Wed, 10 Dec 2025 22:16:02 -0700
Message-ID: <20251211051603.1154841-8-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251211051603.1154841-1-csander@purestorage.com>
References: <20251211051603.1154841-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ublk selftests mock ublk server kublk supports every data copy mode
except user copy. Add support for user copy to kublk, enabled via the
--user_copy (-u) command line argument. On writes, issue pread() calls
to copy the write data into the ublk_io's buffer before dispatching the
write to the target implementation. On reads, issue pwrite() calls to
copy read data from the ublk_io's buffer before committing the request.
Copy in 2 KB chunks to provide some coverage of the offseting logic.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/file_backed.c |  7 +--
 tools/testing/selftests/ublk/kublk.c       | 53 ++++++++++++++++++++--
 tools/testing/selftests/ublk/kublk.h       | 11 +++++
 tools/testing/selftests/ublk/stripe.c      |  2 +-
 4 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index cd9fe69ecce2..269d5f124e06 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -32,12 +32,13 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 {
 	unsigned ublk_op = ublksrv_get_op(iod);
 	unsigned zc = ublk_queue_use_zc(q);
 	unsigned auto_zc = ublk_queue_use_auto_zc(q);
 	enum io_uring_op op = ublk_to_uring_op(iod, zc | auto_zc);
+	struct ublk_io *io = ublk_get_io(q, tag);
 	struct io_uring_sqe *sqe[3];
-	void *addr = (zc | auto_zc) ? NULL : (void *)iod->addr;
+	void *addr = io->buf_addr;
 
 	if (!zc || auto_zc) {
 		ublk_io_alloc_sqes(t, sqe, 1);
 		if (!sqe[0])
 			return -ENOMEM;
@@ -54,11 +55,11 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 		return 1;
 	}
 
 	ublk_io_alloc_sqes(t, sqe, 3);
 
-	io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
+	io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, io->buf_index);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 	sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
 
 	io_uring_prep_rw(op, sqe[1], ublk_get_registered_fd(q, 1) /*fds[1]*/, 0,
@@ -66,11 +67,11 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 		iod->start_sector << 9);
 	sqe[1]->buf_index = tag;
 	sqe[1]->flags |= IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
 	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 
-	io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
+	io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, io->buf_index);
 	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
 	return 2;
 }
 
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 1765c4806523..86443365dcac 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -594,10 +594,42 @@ static void ublk_set_auto_buf_reg(const struct ublk_queue *q,
 		buf.flags = UBLK_AUTO_BUF_REG_FALLBACK;
 
 	sqe->addr = ublk_auto_buf_reg_to_sqe_addr(&buf);
 }
 
+/* Copy in pieces to test the buffer offset logic */
+#define UBLK_USER_COPY_LEN 2048
+
+static void ublk_user_copy(const struct ublk_io *io, __u8 match_ublk_op)
+{
+	const struct ublk_queue *q = ublk_io_to_queue(io);
+	const struct ublksrv_io_desc *iod = ublk_get_iod(q, io->tag);
+	__u64 off = ublk_user_copy_offset(q->q_id, io->tag);
+	__u8 ublk_op = ublksrv_get_op(iod);
+	__u32 len = iod->nr_sectors << 9;
+	void *addr = io->buf_addr;
+
+	if (ublk_op != match_ublk_op)
+		return;
+
+	while (len) {
+		__u32 copy_len = min(len, UBLK_USER_COPY_LEN);
+		ssize_t copied;
+
+		if (ublk_op == UBLK_IO_OP_WRITE)
+			copied = pread(q->ublk_fd, addr, copy_len, off);
+		else if (ublk_op == UBLK_IO_OP_READ)
+			copied = pwrite(q->ublk_fd, addr, copy_len, off);
+		else
+			assert(0);
+		assert(copied == (ssize_t)copy_len);
+		addr += copy_len;
+		off += copy_len;
+		len -= copy_len;
+	}
+}
+
 int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io)
 {
 	struct ublk_queue *q = ublk_io_to_queue(io);
 	struct ublksrv_io_cmd *cmd;
 	struct io_uring_sqe *sqe[1];
@@ -616,13 +648,16 @@ int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io)
 		(UBLKS_IO_NEED_FETCH_RQ | UBLKS_IO_NEED_COMMIT_RQ_COMP | UBLKS_IO_NEED_GET_DATA)))
 		return 0;
 
 	if (io->flags & UBLKS_IO_NEED_GET_DATA)
 		cmd_op = UBLK_U_IO_NEED_GET_DATA;
-	else if (io->flags & UBLKS_IO_NEED_COMMIT_RQ_COMP)
+	else if (io->flags & UBLKS_IO_NEED_COMMIT_RQ_COMP) {
+		if (ublk_queue_use_user_copy(q))
+			ublk_user_copy(io, UBLK_IO_OP_READ);
+
 		cmd_op = UBLK_U_IO_COMMIT_AND_FETCH_REQ;
-	else if (io->flags & UBLKS_IO_NEED_FETCH_RQ)
+	} else if (io->flags & UBLKS_IO_NEED_FETCH_RQ)
 		cmd_op = UBLK_U_IO_FETCH_REQ;
 
 	if (io_uring_sq_space_left(&t->ring) < 1)
 		io_uring_submit(&t->ring);
 
@@ -647,11 +682,11 @@ int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io)
 	else
 		sqe[0]->flags	= IOSQE_FIXED_FILE;
 	sqe[0]->rw_flags	= 0;
 	cmd->tag	= io->tag;
 	cmd->q_id	= q->q_id;
-	if (!ublk_queue_no_buf(q))
+	if (!ublk_queue_no_buf(q) && !ublk_queue_use_user_copy(q))
 		cmd->addr	= (__u64) (uintptr_t) io->buf_addr;
 	else
 		cmd->addr	= 0;
 
 	if (ublk_queue_use_auto_zc(q))
@@ -749,10 +784,14 @@ static void ublk_handle_uring_cmd(struct ublk_thread *t,
 		io->flags &= ~UBLKS_IO_NEED_FETCH_RQ;
 	}
 
 	if (cqe->res == UBLK_IO_RES_OK) {
 		assert(tag < q->q_depth);
+
+		if (ublk_queue_use_user_copy(q))
+			ublk_user_copy(io, UBLK_IO_OP_WRITE);
+
 		if (q->tgt_ops->queue_io)
 			q->tgt_ops->queue_io(t, q, tag);
 	} else if (cqe->res == UBLK_IO_RES_NEED_GET_DATA) {
 		io->flags |= UBLKS_IO_NEED_GET_DATA | UBLKS_IO_FREE;
 		ublk_queue_io_cmd(t, io);
@@ -1505,11 +1544,11 @@ static void __cmd_create_help(char *exe, bool recovery)
 {
 	int i;
 
 	printf("%s %s -t [null|loop|stripe|fault_inject] [-q nr_queues] [-d depth] [-n dev_id]\n",
 			exe, recovery ? "recover" : "add");
-	printf("\t[--foreground] [--quiet] [-z] [--auto_zc] [--auto_zc_fallback] [--debug_mask mask] [-r 0|1 ] [-g]\n");
+	printf("\t[--foreground] [--quiet] [-z] [--auto_zc] [--auto_zc_fallback] [--debug_mask mask] [-r 0|1] [-g] [-u]\n");
 	printf("\t[-e 0|1 ] [-i 0|1] [--no_ublk_fixed_fd]\n");
 	printf("\t[--nthreads threads] [--per_io_tasks]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
 	printf("\tdefault: nthreads=nr_queues");
@@ -1566,10 +1605,11 @@ int main(int argc, char *argv[])
 		{ "recovery_fail_io",	1,	NULL, 'e'},
 		{ "recovery_reissue",	1,	NULL, 'i'},
 		{ "get_data",		1,	NULL, 'g'},
 		{ "auto_zc",		0,	NULL,  0 },
 		{ "auto_zc_fallback", 	0,	NULL,  0 },
+		{ "user_copy",		0,	NULL, 'u'},
 		{ "size",		1,	NULL, 's'},
 		{ "nthreads",		1,	NULL,  0 },
 		{ "per_io_tasks",	0,	NULL,  0 },
 		{ "no_ublk_fixed_fd",	0,	NULL,  0 },
 		{ 0, 0, 0, 0 }
@@ -1591,11 +1631,11 @@ int main(int argc, char *argv[])
 	if (argc == 1)
 		return ret;
 
 	opterr = 0;
 	optind = 2;
-	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:s:gaz",
+	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:s:gazu",
 				  longopts, &option_idx)) != -1) {
 		switch (opt) {
 		case 'a':
 			ctx.all = 1;
 			break;
@@ -1631,10 +1671,13 @@ int main(int argc, char *argv[])
 				ctx.flags |= UBLK_F_USER_RECOVERY | UBLK_F_USER_RECOVERY_REISSUE;
 			break;
 		case 'g':
 			ctx.flags |= UBLK_F_NEED_GET_DATA;
 			break;
+		case 'u':
+			ctx.flags |= UBLK_F_USER_COPY;
+			break;
 		case 's':
 			ctx.size = strtoull(optarg, NULL, 10);
 			break;
 		case 0:
 			if (!strcmp(longopts[option_idx].name, "debug_mask"))
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index fe42705c6d42..fda72e19ef09 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -206,10 +206,16 @@ extern int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io);
 static inline int ublk_io_auto_zc_fallback(const struct ublksrv_io_desc *iod)
 {
 	return !!(iod->op_flags & UBLK_IO_F_NEED_REG_BUF);
 }
 
+static inline __u64 ublk_user_copy_offset(unsigned q_id, unsigned tag)
+{
+	return UBLKSRV_IO_BUF_OFFSET +
+	       ((__u64)q_id << UBLK_QID_OFF | (__u64)tag << UBLK_TAG_OFF);
+}
+
 static inline int is_target_io(__u64 user_data)
 {
 	return (user_data & (1ULL << 63)) != 0;
 }
 
@@ -403,10 +409,15 @@ static inline int ublk_queue_use_auto_zc(const struct ublk_queue *q)
 static inline int ublk_queue_auto_zc_fallback(const struct ublk_queue *q)
 {
 	return q->flags & UBLKS_Q_AUTO_BUF_REG_FALLBACK;
 }
 
+static inline bool ublk_queue_use_user_copy(const struct ublk_queue *q)
+{
+	return !!(q->flags & UBLK_F_USER_COPY);
+}
+
 static inline int ublk_queue_no_buf(const struct ublk_queue *q)
 {
 	return ublk_queue_use_zc(q) || ublk_queue_use_auto_zc(q);
 }
 
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 791fa8dc1651..fd412e1f01c0 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -132,11 +132,11 @@ static int stripe_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	enum io_uring_op op = stripe_to_uring_op(iod, zc | auto_zc);
 	struct io_uring_sqe *sqe[NR_STRIPE];
 	struct stripe_array *s = alloc_stripe_array(conf, iod);
 	struct ublk_io *io = ublk_get_io(q, tag);
 	int i, extra = zc ? 2 : 0;
-	void *base = (zc | auto_zc) ? NULL : (void *)iod->addr;
+	void *base = io->buf_addr;
 
 	io->private_data = s;
 	calculate_stripe_array(conf, iod, s, base);
 
 	ublk_io_alloc_sqes(t, sqe, s->nr + extra);
-- 
2.45.2


