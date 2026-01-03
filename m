Return-Path: <linux-kselftest+bounces-48102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3393CCEF97D
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 01:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A60E3011F8A
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 00:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8459723BCE3;
	Sat,  3 Jan 2026 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CfvfZnk7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBD424728F
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Jan 2026 00:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401144; cv=none; b=S4PNpy5G26MgS8PvhVMmgsd2kMzgd9vlqadJEBBJUS5kCl5oiUYCaKzEi4ZGPAhkHR0nlC5f/vLpJfBhXxjGBmEWx2rLKne/LFiE+11zHXcSsLrhXxFTWK0pMXZKgX291jPPyF+f/c3FIOmYHkH4ywpYPJ5oYjxcZgPgvpyM/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401144; c=relaxed/simple;
	bh=f8EP+bPK1MvqaUPNHimhlYSpt7ZjD3QQvEFMsrXub80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnHCWZbD/4AIMlOqj8/6S/q71F1hAKDp3XvOecnLeyXyhbEyrGU9I2raij//QxPPRPWkZiT/876Sq0+8DnIGU/BoV9cZReqwazwajCrm975NpI0jlKWlaTbIgSRg0go4/CkiWRpWwBMW2dvOf1z6Uieiu6Xiq9Sq2xuieQqyLFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CfvfZnk7; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-29f2d829667so24024245ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 16:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401135; x=1768005935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0K5vEftPdYiPKum60OYL4RUxMxughkX0Uvdp3aFS+SM=;
        b=CfvfZnk7bDH+nJOM3yZl+8AArxpZJjt4FBqpkgGh4t+bMwCc4prAWHorbgZTTW66qD
         ZvGDoCc+E7RPs4KT0KzRJKjtc4y5I8tah4Dre1RmM8GA8vNTiWNOHkVHTtLPOt6rMiNG
         14TFufkdcscqvyWkbW3RdKx/mKfPUiTzSl9DHFNwuEkNAa3v33SGTNUl8/gzDJ6q3az5
         IgOF3ZwQmfhrHOtoIFHjGlWyLVQDaY+mvvIdmBd/LOmgHsdf0RXsOtvokcF1z5ZjxQrl
         YsGpyhpjpNk0uLI+silil1op+2UxFBKmFzq+QaJ9DMGGoF+TgkNTGLPigG2M2Byn45xc
         u9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401135; x=1768005935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0K5vEftPdYiPKum60OYL4RUxMxughkX0Uvdp3aFS+SM=;
        b=XtMyuq/58rvBv4dF2WpcnIlTwg4Gie4/tGoy/LdsWI++lVw3m8+p4+0ibq9kajYa44
         AkqZBT5GByzPKL7rqOl5z/2WsR7HHYATdgYX3FJ8HZlBa4t0JFPot5x095oMFD8i3t42
         pcYq62LXvBiGSUPczqmb2WJdsEdEdzBykWb4qzJHMkIOCZ7uB0QXMLdKFkeM9eYZNITN
         uJ7H47soeXuIZ9q5mBSLfcLf6J0VtdbRV0o1Z8y0wYnhh202a3KfgA1EfFXEH+5Jz6Pe
         kzCtLeIZiYQ6mWnDEiUAjNXQW9luBS9k4Qq5oqW9H0cQYRhdxQ1lduHwXRIV4NxEQ1+R
         ECNA==
X-Forwarded-Encrypted: i=1; AJvYcCW2BIarsuxm47Z9DmChiFHZpKi3BMYmqUC5yMuQiUfozO/QTdyKHOOC+lGwZHaMowzlPz+3fTlWQyvQ1F/L+VM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0uzZ3QD7bdqfL9c2urb0rRuc199h6JILbnpTNV5dDZEbAgMs9
	kUE3XhrjC/udHnKOToq8jdUPSeyfwYiQuJxVGmOuAnD4B7FXDtvwywZJw8sjfnh7QcB4cPJc9Vt
	Feo8hu4xDWZgNqZTZYtdw+wDbgqwy4SKozH0wjncxi+hz+nBXw8j6
X-Gm-Gg: AY/fxX46JSKK0IkEQgb5V+lHKsOsmeVDuzQdObQV8lcqrYK/qWA1DoJNrCxieDc8Wgh
	+0wXjar/VlgDlMvxOm75pEOSt+JPuUCoopZ3gCyKUUCLVSWdawhFkCX/g9Ez6b1WwSEW2PdivbM
	hjbiWQ2KVVKU+KVfsMnXONkG1sR0kPo5k//ck3uxQHOjN2z2KggiLt0gfDFkDlaTP8ZsJJsnE7m
	pm6VVivuwbvPAoe3rzmQ7XUEk7V7TRUKdX5d6zYEbE4oG8HrdgJO7bIcuLClnZ6v9knuStLpP4Q
	uQpMNJNZJ/66nrycTKnci8YxLHU+nc2MsfJc7iPDGFWddxifSsVVuo+vt7xxPA20TdhdARMjOuf
	/10UsbAtvoskVfIotIlitxRsuzqY=
X-Google-Smtp-Source: AGHT+IHcX+CRfh1yJ1dtOuSX3HDSSImX9jo+Oulvfyxwk7ticvfgzH1fRPZhYJFZLxwgd2hA8WknWNn4BYl9
X-Received: by 2002:a17:902:c405:b0:297:df7c:ed32 with SMTP id d9443c01a7336-2a2f1f7c269mr304827635ad.0.1767401135319;
        Fri, 02 Jan 2026 16:45:35 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a2f3d1c1f5sm48601045ad.49.2026.01.02.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:35 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C0943341FDC;
	Fri,  2 Jan 2026 17:45:34 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BE7F3E4426F; Fri,  2 Jan 2026 17:45:34 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 17/19] selftests: ublk: add integrity data support to loop target
Date: Fri,  2 Jan 2026 17:45:27 -0700
Message-ID: <20260103004529.1582405-18-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To perform and end-to-end test of integrity information through a ublk
device, we need to actually store it somewhere and retrieve it. Add this
support to kublk's loop target. It uses a second backing file for the
integrity data corresponding to the data stored in the first file.
The integrity file is opened without O_DIRECT since it will be accessed
at sub-block granularity. Each incoming read/write results in a pair of
reads/writes, one to the data file, and one to the integrity file. If
either backing I/O fails, the error is propagated to the ublk request.
If both backing I/Os read/write some bytes, the ublk request is
completed with the smaller of the number of blocks accessed by each I/O.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/file_backed.c | 63 +++++++++++++++-------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index db4c176a4f28..b8aacaa928a4 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -33,48 +33,62 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	unsigned ublk_op = ublksrv_get_op(iod);
 	unsigned zc = ublk_queue_use_zc(q);
 	unsigned auto_zc = ublk_queue_use_auto_zc(q);
 	enum io_uring_op op = ublk_to_uring_op(iod, zc | auto_zc);
 	struct ublk_io *io = ublk_get_io(q, tag);
+	__u64 offset = iod->start_sector << 9;
+	__u32 len = iod->nr_sectors << 9;
 	struct io_uring_sqe *sqe[3];
 	void *addr = io->buf_addr;
 
+	if (iod->op_flags & UBLK_IO_F_INTEGRITY) {
+		ublk_io_alloc_sqes(t, sqe, 1);
+		/* Use second backing file for integrity data */
+		io_uring_prep_rw(op, sqe[0], ublk_get_registered_fd(q, 2),
+				 io->integrity_buf,
+				 ublk_integrity_len(q, len),
+				 ublk_integrity_len(q, offset));
+		sqe[0]->flags = IOSQE_FIXED_FILE;
+		/* tgt_data = 1 indicates integrity I/O */
+		sqe[0]->user_data = build_user_data(tag, ublk_op, 1, q->q_id, 1);
+	}
+
 	if (!zc || auto_zc) {
 		ublk_io_alloc_sqes(t, sqe, 1);
 		if (!sqe[0])
 			return -ENOMEM;
 
 		io_uring_prep_rw(op, sqe[0], ublk_get_registered_fd(q, 1) /*fds[1]*/,
 				addr,
-				iod->nr_sectors << 9,
-				iod->start_sector << 9);
+				len,
+				offset);
 		if (auto_zc)
 			sqe[0]->buf_index = tag;
 		io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
 		/* bit63 marks us as tgt io */
 		sqe[0]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
-		return 1;
+		return !!(iod->op_flags & UBLK_IO_F_INTEGRITY) + 1;
 	}
 
 	ublk_io_alloc_sqes(t, sqe, 3);
 
 	io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, io->buf_index);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 	sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
 
 	io_uring_prep_rw(op, sqe[1], ublk_get_registered_fd(q, 1) /*fds[1]*/, 0,
-		iod->nr_sectors << 9,
-		iod->start_sector << 9);
+			len,
+			offset);
 	sqe[1]->buf_index = tag;
 	sqe[1]->flags |= IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
 	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 
 	io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, io->buf_index);
 	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
-	return 2;
+	return !!(iod->op_flags & UBLK_IO_F_INTEGRITY) + 2;
 }
 
 static int loop_queue_tgt_io(struct ublk_thread *t, struct ublk_queue *q, int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
@@ -117,16 +131,21 @@ static void ublk_loop_io_done(struct ublk_thread *t, struct ublk_queue *q,
 {
 	unsigned tag = user_data_to_tag(cqe->user_data);
 	unsigned op = user_data_to_op(cqe->user_data);
 	struct ublk_io *io = ublk_get_io(q, tag);
 
-	if (cqe->res < 0 || op != ublk_cmd_op_nr(UBLK_U_IO_UNREGISTER_IO_BUF)) {
-		if (!io->result)
-			io->result = cqe->res;
-		if (cqe->res < 0)
-			ublk_err("%s: io failed op %x user_data %lx\n",
-					__func__, op, cqe->user_data);
+	if (cqe->res < 0) {
+		io->result = cqe->res;
+		ublk_err("%s: io failed op %x user_data %lx\n",
+				__func__, op, cqe->user_data);
+	} else if (op != ublk_cmd_op_nr(UBLK_U_IO_UNREGISTER_IO_BUF)) {
+		__s32 data_len = user_data_to_tgt_data(cqe->user_data)
+			? ublk_integrity_data_len(q, cqe->res)
+			: cqe->res;
+
+		if (!io->result || data_len < io->result)
+			io->result = data_len;
 	}
 
 	/* buffer register op is IOSQE_CQE_SKIP_SUCCESS */
 	if (op == ublk_cmd_op_nr(UBLK_U_IO_REGISTER_IO_BUF))
 		io->tgt_ios += 1;
@@ -136,10 +155,11 @@ static void ublk_loop_io_done(struct ublk_thread *t, struct ublk_queue *q,
 }
 
 static int ublk_loop_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 {
 	unsigned long long bytes;
+	unsigned long blocks;
 	int ret;
 	struct ublk_params p = {
 		.types = UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DMA_ALIGN,
 		.basic = {
 			.attrs = UBLK_ATTR_VOLATILE_CACHE,
@@ -152,27 +172,34 @@ static int ublk_loop_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		.dma = {
 			.alignment = 511,
 		},
 	};
 
+	ublk_set_integrity_params(ctx, &p);
 	if (ctx->auto_zc_fallback) {
 		ublk_err("%s: not support auto_zc_fallback\n", __func__);
 		return -EINVAL;
 	}
-	if (ctx->metadata_size) {
-		ublk_err("%s: integrity not supported\n", __func__);
-		return -EINVAL;
-	}
 
+	/* Use O_DIRECT only for data file */
 	ret = backing_file_tgt_init(dev, 1);
 	if (ret)
 		return ret;
 
-	if (dev->tgt.nr_backing_files != 1)
+	/* Expect a second file for integrity data */
+	if (dev->tgt.nr_backing_files != 1 + !!ctx->metadata_size)
 		return -EINVAL;
 
-	bytes = dev->tgt.backing_file_size[0];
+	blocks = dev->tgt.backing_file_size[0] >> p.basic.logical_bs_shift;
+	if (ctx->metadata_size) {
+		unsigned long metadata_blocks =
+			dev->tgt.backing_file_size[1] / ctx->metadata_size;
+
+		/* Ensure both data and integrity data fit in backing files */
+		blocks = min(blocks, metadata_blocks);
+	}
+	bytes = blocks << p.basic.logical_bs_shift;
 	dev->tgt.dev_size = bytes;
 	p.basic.dev_sectors = bytes >> 9;
 	dev->tgt.params = p;
 
 	return 0;
-- 
2.45.2


