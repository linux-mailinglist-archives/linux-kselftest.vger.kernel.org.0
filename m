Return-Path: <linux-kselftest+bounces-47521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ACACB96DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 18:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18A5C30C44D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC63D2E7BC0;
	Fri, 12 Dec 2025 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TdjZ4mrZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52022D7D27
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765559835; cv=none; b=uGLLgeQ7YxctO6apm1FazzXunjTZtHBdoSlvniCwJTYEjPkoUYWuUtMxg9sLe+06JpUPbAYtnZQ8xWKcvkPXq+EBYlaBsKROOwY2udwuolPb7RTUy6OJU/77XfDkLOncjNweWTrT3XhzTF2aPMgmO1F2lSxEYwSENP3WstvWbd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765559835; c=relaxed/simple;
	bh=caTAQpgh+X4ZpNyyMAM/TEMWro2kQrWFU3FikG62sB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qy8o2gwxfSqJtJcL6HpKTiavVZkYVJLVCMOfxd+o0itbs53U6tHmKKwtB3SA2uLRPCRKVQ6K8b3w6FNqKZT4FurTtTWhGiyzjWUznqQL5V3XvMh+KzsJfikmArI+6xxcRn+CaGgwtWo0a4ZIG1VTTDZx4KYxaOlNv3O8Qh5PkwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TdjZ4mrZ; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-29f2d829667so1270055ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 09:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765559831; x=1766164631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJkrjtWt8tg1UlZG0whiJ8Js6OX17UUxfoijWx05xpE=;
        b=TdjZ4mrZIWtRMezCKrNMZ1r0/7kMfQBpIXccCEzT2k3dF5Gqc6fi1ND4GZQpnERPnG
         JvdDkTirwc0eY8PSDRU+icS2zyK3MCfYsc7V6xZKmX71aUkQyAtw9qB1JsFI0tMGKzIF
         I1apcOV10A5YkQP1TiQ5J+c4lSQAwqzouaFuligoMeQ2gV0e1Zq6eew/iyI9S8mqhGZb
         22sw0O5+Ong7lTKl55hXtaVHWjmT019yT5nqgyZj8Q5rM55T0NcgrAB2DbHH29V3b4PW
         z9AVJZLdMmNH4UfzHbypJygbGd5fDfmOXAaBIUhVIL7ZlsxZeuU3s6CTp6QQNuW8u6vs
         iOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765559831; x=1766164631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wJkrjtWt8tg1UlZG0whiJ8Js6OX17UUxfoijWx05xpE=;
        b=MNLJStDDw2xT1/Fp/KtFQjoxYAfDZWzooJEfmXRL/Bl5q2e373ICE7UIc5+3HJRhbV
         NZdiDhpQDlD7l2sAbdkxJhMYcZ7wp3rp0nsVxaAm/oOreS4OQ+VRQ/ymK1UPW3/YU+Rd
         USMyhA/ch8R6l/bWsYTWFeR1fXsUWh5eSAGKWNkuhTCLZD3geOfB69ICeFreKrpQpBaS
         JvaR3yxRTTPEZm1dDkz0jjaC4+BMKPzfV2JaJK0DRYDk9qWvUI8fbPSYaYhQ6JSSD40w
         oQd1VoLnG8CawB0j9QP5/WzR9lQL7koOh5ci9TlUS7lGSVP3uiFz2UJUcVBemSzuFwhP
         /36Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtx3GD71Ru9tSVFalWs2pzz6jWv6qJmHLs1w97tqtbizWUVptgX67gRSAc6WvO8WBf8FiQ1IkyQZAo80q9d3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPIcRyF5oEd1VdlO49LPTtSDiwnt9VtSfwAujLHeHoelmqMpXB
	HemueoRXJVpcFkIH9MJh6lCch6CKTeVz8ZlHS735F8iuHPRjg5BoKUCmgpunACWfcm+fmH0HK4w
	Zc1ErEnJeXbFvmJipxv/xWDnCkp9qSKATXzaIY+xHmpzx0TOlvaxW
X-Gm-Gg: AY/fxX71WRkgqEBzUyJn2HJ6ODFj7FaQ3e9j63QSUR4+skiNz3QByGcI6RBvMVaqElq
	4uCi3531EKLFO0VYB+nIZTDdKC2sEVitLw+LtIGTgqxEZEq67T5ZZQvIzlWnmy9DlHHPSPYrmAl
	PA3L8X43BW6fP1wgFg5Akx7UvmXi9hpR/0yU9Ofs/B/jAtqF9sHpMQeWcAqqgDERl74S1IuzxDH
	o4OhqvXjxGTbH141OX8BOFE1j28rzdyvtVrIOUy0h6jxvk4ud5DQVXu5SuMBzXMFdHjMYy9if3l
	KVWBlJGExfygDmbjc3M2QDzVKDhqmE6RtV/CoaPq5BlQHamwqvHDeWI+j7FwZkQLLwQ329/baJN
	nMOSnwZ1Pf3J7Tkd5ps0wx+UtrIU=
X-Google-Smtp-Source: AGHT+IFJ1GUZ3zmhMWmiVdh2barweJoIDrDdZVhEKQI9IfIoy3Skf6Q+Q0nnC05JxyFRtimaqOYT2cExBqPx
X-Received: by 2002:a05:7022:ec0b:b0:11a:c044:ec44 with SMTP id a92af1059eb24-11f34873681mr1111693c88.0.1765559830571;
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-11f2e2fe356sm1027197c88.5.2025.12.12.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0BAAD3404B4;
	Fri, 12 Dec 2025 10:17:10 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 096E9E4232B; Fri, 12 Dec 2025 10:17:10 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 8/9] selftests: ublk: add support for user copy to kublk
Date: Fri, 12 Dec 2025 10:17:06 -0700
Message-ID: <20251212171707.1876250-9-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212171707.1876250-1-csander@purestorage.com>
References: <20251212171707.1876250-1-csander@purestorage.com>
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
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
index 4dd02cb083ba..185ba553686a 100644
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
index 6e8f381f3481..8a83b90ec603 100644
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
 
@@ -403,10 +409,15 @@ static inline bool ublk_queue_use_auto_zc(const struct ublk_queue *q)
 static inline bool ublk_queue_auto_zc_fallback(const struct ublk_queue *q)
 {
 	return !!(q->flags & UBLKS_Q_AUTO_BUF_REG_FALLBACK);
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


