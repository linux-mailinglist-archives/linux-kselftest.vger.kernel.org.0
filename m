Return-Path: <linux-kselftest+bounces-48256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 420B8CF62A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FCF3305F673
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B033625A2A4;
	Tue,  6 Jan 2026 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aCEEN3Jf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840020E030
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661099; cv=none; b=ueX4oKoCUKTKM5a84QM4xwykZ15kR1UgSdbO4icy2BaXZb/kwBjidfLwsGOte69d9vv++FhvGqhR8ZN7WBMAET4uEG1TSySmjS2GnULKgjUrM4tZVouowl1+FxO+gtpwt/0R/ZXqOf4nkm2MZvkxzZn4hF+ZWoYRhBx95PRWcLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661099; c=relaxed/simple;
	bh=f8EP+bPK1MvqaUPNHimhlYSpt7ZjD3QQvEFMsrXub80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IITefIw5UHuZJM4FcZdmckYN8Hdv0j9IWRhtP8lNp8LwJP8G4uUY2QLnXFbTLZWcapHoO4gs+9bHKgU7bVdN4H2V98anxK31rTRFq+g8Rn9hjYPuk1vmOk++t4uBvWQHoE7SVz0b0vudrLTXYHBBXubc9VA9LwAM2G0ni4kdXOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aCEEN3Jf; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-29f08b909aeso1204315ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661092; x=1768265892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0K5vEftPdYiPKum60OYL4RUxMxughkX0Uvdp3aFS+SM=;
        b=aCEEN3Jfpnfaoz/bhk1xZ3Jps+gYQ7SYddOwmTaD+03+EUd6PtbbjuCPBumAiErIku
         a8W+gIxjl2xabja9TU+9KRYQjD4YIHRJft68ApBq218GlaOVYdbTAftul6oAxMDQ7JHj
         VNmdh/6JpKoEwfQBrUB9rlZk3VUWs7iV2lpchSOx8d31EcUejdoILUkDrFe9yF8vthSI
         q24kptbhAzjVe7bJoSO7rmhNYf+3oS49hX0kIRgpeV3OG/pWW3Mu+RjTXzG+bg5KsOFr
         1OsifoQqZ/O+VAJehehxmrJMoj4qDS4Pxui1WsR16egu7Ykxvbp7H2ZI28JCgO54gKMA
         TL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661092; x=1768265892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0K5vEftPdYiPKum60OYL4RUxMxughkX0Uvdp3aFS+SM=;
        b=sIdinagw4GGQXTy90ozuL+SROJslJCERUTdjhCP7KnRJfMed7KjbJ2aJxD1BoUQblg
         VkH6aEivhtMs0N57hU9CAbx/fj7rld+iePVUQ75B91DkfZC0umNnrFDnP1pjWul0b3Q9
         t/VBionY7krU5ty34/g8MpnW0UC9eH+gMHGZjg7KRisXqveSyN8CdrsrUrKnDr+5s1eF
         7X9OAZuYM2qREBeuszxfcCUx4l7cR13n8Ivg5YCjz2Q4lPeIZe/cWE/TtNvBmhXtP3YS
         VLPw1gBwutkGBGZvkN2M+ygnwE8WtZkQpfL/WwVCkEb1Xu8JGZla1HK7Z2QGEwPxl3Dj
         n7OA==
X-Forwarded-Encrypted: i=1; AJvYcCXb4l5fq+GNTRltuPRDleV9tqeK1pC+45qqqqTw8v+7IZGhMiDkGB7l3KMPSWrp2VOz145N3UmBcT7Mi9N5jqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcGPemzLb7PHCOclkz9QfzVKnpddLLTFwZpZWusc6LCSDe5tBJ
	H0tW266igaNwN6kSxQxC/y//9Yg48zZTMWOKN9khCdKMSFANjCEc7Rfno/F9ZdAZUgV9hHUpPzw
	A1P852fU+gy/3XdvcMlHcNX+OwyHrzn9ifzsjtLpq2kcwXvz4C054
X-Gm-Gg: AY/fxX6EYATQ2XZFDUSE++JNKPvK1vDg1oYvGFSSI2DhIYsEyiYepYOQjuqQYZar+ts
	0KArK5TIfxTkTAyCdZhog0XrmbI6ap/B64egXFUWW4r/SsUnvv6zBF2HFN5JEqpkrF7Atc06Z9G
	s8YueGRVdXOj+WUUXfHS7PEQXXO96uGSZgnLUOq5VLv9yk4KLutKOJNJfkyjuiBm3Z4ql0nmrHb
	vv/kT2rXp5rP8vHCiaP7LiLpjHWYq5TT3DynePpK0mkkkmoX6uJLOkVyllF0aSPH4PA4xv0zpt5
	kRI8GfcjlAhxcZp2ntzyDEQy8FayqvC9yp6ek3x+2lgnxvXP5/Xr9wH0OaWfvb6inD+qmqGgU2U
	SrtS8iL7mXbjYJxCF9KjcQiXq1OI=
X-Google-Smtp-Source: AGHT+IEwy3xNj8bx514efu2NZrTdyRXI4rGnHiIIY0NgXLyLfCfNZnpOeahDtpiWh9+nlqkwyb1pWtp8Ofe8
X-Received: by 2002:a17:903:1b6c:b0:2a0:d07a:bb2f with SMTP id d9443c01a7336-2a3e2d944aemr9298545ad.3.1767661091749;
        Mon, 05 Jan 2026 16:58:11 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cae722sm892915ad.29.2026.01.05.16.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:11 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3E993340960;
	Mon,  5 Jan 2026 17:58:11 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 306D5E44554; Mon,  5 Jan 2026 17:58:11 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 17/19] selftests: ublk: add integrity data support to loop target
Date: Mon,  5 Jan 2026 17:57:49 -0700
Message-ID: <20260106005752.3784925-18-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260106005752.3784925-1-csander@purestorage.com>
References: <20260106005752.3784925-1-csander@purestorage.com>
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


