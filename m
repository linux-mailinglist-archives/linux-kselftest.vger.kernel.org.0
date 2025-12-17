Return-Path: <linux-kselftest+bounces-47648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D21CCC6102
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 06:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF8823017CA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 05:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA452D3A6A;
	Wed, 17 Dec 2025 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bh3R4Mzn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2292882C5
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949722; cv=none; b=Qy3/93Mcemimp/+FvYLmXyva0bUsQ2xmzqz2d/5vKHxvDHBum11dfV432n0Ud7VOaCn3pA72SgSYviqOFO13DQTrsszekC8Qy916i0bksyOW2k9pByD/UBbng6o3vKnWtMEq3rgVfCUjicYv6NpgZd7TYoTkmEgxfJRUYQO9U0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949722; c=relaxed/simple;
	bh=f8EP+bPK1MvqaUPNHimhlYSpt7ZjD3QQvEFMsrXub80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfNvFdiPYgkURPCJ5aApbJbSvB9xzD4tdf1M0RE4j/mPrbys+ZTPGgm+X7k7krTAUrY1y13/9llcjLNREqCPp7+GNqQoQxhdVBOG/NOrVbsUxBd26dY5VW238mzAOFtnNlG9IaJD8HjgKDmPbEP4RMYLG1mATBtIMCWQSHgfyB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bh3R4Mzn; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-34b3f61fd0cso553780a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 21:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949714; x=1766554514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0K5vEftPdYiPKum60OYL4RUxMxughkX0Uvdp3aFS+SM=;
        b=bh3R4MznsX4HN2sSwUeUQoF8SG4fShGPMt4lCeGDziENdlf4sfmVtFZS6vwmXpxFum
         v094S6KXgE2NXNo0d61hiXTLLia/8cCnXF9Q2B8Z2QTPz4HP/TJQ4xXA0gdltFkC1uP2
         gVASd5oaqiaLARNd0/rtKfPlzo1FgI1COjau9sw5qf9Ej8VHD75fsD9mvgJxgVAtOSRk
         ipjZ+0c2C7oBqGsKllxmwXvZD2CzKDJ+wDwVfe3PNHPW7Vh8N0vreiwaP0x5IZ4kaTCB
         Fn5nNbvgSQz/CjwWmQYWguX0dOIE/wNSoglxRn9TawzFejrZ8ntjDegmwGS54lqeB+L+
         EJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949714; x=1766554514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0K5vEftPdYiPKum60OYL4RUxMxughkX0Uvdp3aFS+SM=;
        b=Z4Hw/7ZFqrmaDWiY+NDrqhnT54vjtCD+xfAiYamIhWmIxKu5jKUSgnaEPe5ZZrP3Yg
         fiaAm7iCrW06CHVRYOOewa80y8lU7uoQx81NzcrVWPpWCGIp+w9p60rENcfEJwdS7Bpa
         u2hwpZzwYVe08nNxVfnVltXZ2Dz3d1p9RyxcaOxCCX8udTZLNk9GwJbhkkSsOV5gAyZo
         rdtshgu18Xnaap79soTVNCrTFylF+SuxQcx9ZWZwR5keSMkIFX5yYZpLttHPA6qsPSy0
         bYkY7kAkcbvSmtDpdiLtUW4i2Vs6ziwIza3WhV89YOausVcOXTEboVhT5mkAjibCJzTy
         kzxw==
X-Forwarded-Encrypted: i=1; AJvYcCVweFktjIXLzbiKJa0LIfeJvjmCXGr9UF8HrvTSOMZXp/OTb07sKSGr1kYAmRS5G/Ng9HHrEc4i3yw7pNdcbTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2fqvp3xI2UVHQdOuRR7CXFdL12y2T8iDvupZninUAR+Xd+Gfb
	uZ4dsdiRe77frZRclLugcP9XqdCkgwT2rF/tRcbNcEAN3oB27BiCaYj6bjmeVGa6dfJ+FtgSWWy
	5p/ezc4g/EUUry02xHNjn5cuC+ndscG6AqE9LUGUtO4C2UfQEgoYv
X-Gm-Gg: AY/fxX7tTN/kgdZY33tWBzKcuvgOw/UCBOGsBIhDmmZabMuhagyWAsqgH5lNbCRfXU9
	Lma6M2a5au+5CKQLTGr+sek+R04ruk8MJXMvv7U1o4Fv7ky9Uq6/jVQEOPjEv5rgMr9TWMcz7/c
	sLb8XmFcUOu+IheC3ykDyCM35dqrMro/nRICEa/5s4enIpTCpWlG36V8YNvXOlKNqUQlHF6N0lk
	Gbdq4Bd1IeCehNzuEF5+1W8lpxqTrCVtr4QwmKmTMWJgux810H0+P3Dw/OYNs1aFgiVUt5ELcfi
	hwR/JbHRMWidL8cNan4sZbtyXuHJfyW8J1zd5dexnYMvL38dpPgLoSO55aSMZE+8YJ93IXzxELV
	jbucE0q+Hk6u0RRVVA1jHu1o/Tfo=
X-Google-Smtp-Source: AGHT+IF3QWWDircA2HU2nyaFINqIKymyhDZzCc1uZwJse38kkaHRBo2S1/CTHo+jeLRwwK8DtAAmlCsojSBS
X-Received: by 2002:a05:7022:fa2:b0:11b:862d:8031 with SMTP id a92af1059eb24-11f34874285mr7166802c88.0.1765949713871;
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-11f2e151243sm3230598c88.0.2025.12.16.21.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 863CE34225B;
	Tue, 16 Dec 2025 22:35:13 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 84110E41A08; Tue, 16 Dec 2025 22:35:13 -0700 (MST)
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
Subject: [PATCH 18/20] selftests: ublk: add integrity data support to loop target
Date: Tue, 16 Dec 2025 22:34:52 -0700
Message-ID: <20251217053455.281509-19-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
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


