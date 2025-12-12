Return-Path: <linux-kselftest+bounces-47488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE7DCB7EDC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 06:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2882430680FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 05:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2628630E854;
	Fri, 12 Dec 2025 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="V+v51Hhm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f97.google.com (mail-ej1-f97.google.com [209.85.218.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950BF3002A9
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 05:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516631; cv=none; b=K0O7Q7OkRLyGIU0zEkZmw7xLGFKtIHpJZYQfmAvn801+iLJ80XIyMrgnItR9MqbhYl/woRExXHFVjGBOZTYYO48V30EKxz4h7uzMKvNbnnALnzfORYLDXHykgICuAGBjjpB5o0NoYG+0w8WgUVnfJ1fVzTAqxXkZxofsFki5JyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516631; c=relaxed/simple;
	bh=iQ38AiA8WpaYjXkApiIllny59rXw+JDU7PqgdS0U2h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBYR5JWy2g9vN88LrBWbRau/SYUXwGaDoA+WqioxvbNroZnxceq8tOcawDGaXdKUogIH4skTq3bvRuznHotSJEri4NORr5gEAAWRRsdEP45Y2IZmzRNyf/eNXr5Y+1TXBabE9BP2NzHIYnwMk7n2MVzPo+CNwIlQziScwvDWIwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=V+v51Hhm; arc=none smtp.client-ip=209.85.218.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f97.google.com with SMTP id a640c23a62f3a-b769a872550so11557466b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 21:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765516626; x=1766121426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrOvEFha9jDIV8lCVskD9FwpZK1XYG8QVcTVv9lysko=;
        b=V+v51HhmT387d3EqRwgwsp0ZDEkYVU5MwbPx0xHTZncYhABgqQGmJocUNspoR91DGJ
         CgD06MiSL8HXMvRn3rEcarKPjrN2WwpgQ5AFNAGYM9IT11OCaAJ5OO7nx/aEUxLWI4rf
         MbiTPB03p5Qm+8tDqETuFurR2I9S5dyGGFKYRaBuNll4rxQV1U7aGQNv64Qtxc3vty1z
         5D0knFyJOaieiDtv3F8aP0wkLcK2Cf4yZs9UfCXzQGgvHD+B3TRU3c2Zynr9jFORnxpF
         5BuDChbZNH4KoR9zAWCLXCHymzDuqloT4cBJqBG0pYAMkNXyYEm6WKKNQE0HmaMAjaRw
         +h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516626; x=1766121426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PrOvEFha9jDIV8lCVskD9FwpZK1XYG8QVcTVv9lysko=;
        b=onK50681wSAAdMd74DY8FYdhvI01U7pk09bh7RAnBsok56aldvtFH4wVjSxRFCfdwe
         5EITzlRvqT1kthYMmS/RTxCbDAAcasx7reHvaPWHHXjil5b+w2zjQCykukTo78yEA1zo
         PpLfKB1oyDiOoX1yAHl15iMd1lotiuYq3U6GisQIc4Swk0uklzO4wb/EM6HWcgzyoKUw
         UMJ5HvgYol3MbK/Bn4oJXRLyB2nYYuIg45Fp6YDet457yVYwAaE2mVj2+sz7pOBycppU
         o+7d6RnYOXO1Cq/ZcvcjF309iUH5KugL2QjZisMVnlVJb4hnIbooSjbrpN8ZCs2CtNKR
         UodQ==
X-Forwarded-Encrypted: i=1; AJvYcCX25bFQ0jOa6pWovwxt43K/Is1zhb/lZFgfcIZIfiF5H8U25tmJvEHpH3m7TFfrwnQpSVIqDmo0GKgXOra2MEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzBWELa5jbGUnmjFehTx98RfaNr3kRgLlySpbdn6lNsxB0pqPE
	giHQ55XQhvUjGnHwO3agZrvPmvGxWYr8YRCL/nfe+b57z6jRH3WVuVNflNLqITq63MIXrj5QeeO
	n8K6zq+n4a0WEEjlmjnjKdyGM2Bz+nMQR3w8dHGltD/fU459z9k8B
X-Gm-Gg: AY/fxX5+ZaXQgW7sPyY108VDJSCNLjkOhmlyhvXp1VZ2vhEwoIpBWe3EQdcewb/aaB5
	F1lqUsDQeP43fzDjR/JmrG6MDHik7C/cHJ009lA/aU0raOxgkstYwh3GyRQUf1B7LMBZyqg3/gG
	6/z8ZDliQ9C49xrQIqNCAJMD/YflA9NcfNC89Q2GhVtEf+HKMgS5xPR9S9S2cJZb9P9m8GlLNS+
	wn/bJT+ArOR7nu4o6V4Obvm7dHbt8DnozbjFZcbnK6ibWfNSsdS6tdgbZ2IpkZGF5e2ZSvfg0K+
	62QEPx5gPeddCzXgoVWlwyjNUliz1o4zEj/agCndSzg6rw1yt3X3RfQ5+UCawTPc5TNylLtc2ch
	36tAj4Yu5t6SxfC1IBFkw1Zh9iV8=
X-Google-Smtp-Source: AGHT+IGNE1WUeyfEpE2FCHrU4wx0J7ge9PU3JlPk2VoedJ8eSASl3O4B0r9CJEr4tdkjvhbgb3BWlrErJt5h
X-Received: by 2002:a17:906:f59b:b0:b7a:6e46:d5e3 with SMTP id a640c23a62f3a-b7d23633067mr36903766b.2.1765516625545;
        Thu, 11 Dec 2025 21:17:05 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b7cfa3468fasm87885866b.43.2025.12.11.21.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:17:05 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D551A34225F;
	Thu, 11 Dec 2025 22:17:03 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D2E73E41A2E; Thu, 11 Dec 2025 22:17:03 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 7/8] selftests: ublk: add support for user copy to kublk
Date: Thu, 11 Dec 2025 22:16:57 -0700
Message-ID: <20251212051658.1618543-8-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212051658.1618543-1-csander@purestorage.com>
References: <20251212051658.1618543-1-csander@purestorage.com>
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


