Return-Path: <linux-kselftest+bounces-48480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1125CD02004
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 11:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7553313F2CC
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 09:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED1342AC9B;
	Thu,  8 Jan 2026 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CzLrUx/r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A342A101
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864010; cv=none; b=SbFeDG/8tB+xH2QCHjb1ZER/Eoj0m18+ALoWFU5r2q2JKbc1yuAe7G1qyqhzGgcHpUW61L0aykvUI6kpuGaTIdoUZiLv+bOzf7DlGMvXBiuQyMsLEkNUoR/UJmMLnBsOB6PLNyo6eO+7P5HxA+RaHmTuswE/sTn5OnKq2+ZgWa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864010; c=relaxed/simple;
	bh=0KvuwatLuW/I7zN8Xl5wgxhrOel9MsjL8LNRUsvNxNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xtp1VNtQ/Ov7as6Proc2mGuaPtW7lCShm4x3Hgr+g306KoDtNRsSiucn4wiTQJkWUGT0DdtgiChh/0ksDeBPClK67xAhsdapvUHQJ4zNRJS0EN/+fDtbjRjTTkssCzNRuiej8D2VElfVrZxrOcO6fqZYlYR/YcR/HeOdHhTchSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CzLrUx/r; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-29f3018dfc3so8220645ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863998; x=1768468798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ybe7DAurEBgUEb5ATlnDDYhL1vOoH3YzFdXhAKpi7Y=;
        b=CzLrUx/r8BEW6esZCx9fTsNpeACo73w6sEPZ+PbWJXG9/fBpgdGToiZD20moV7TQnu
         GESfx36XqY8OVKrh5soCVgpp3JdsJRaO+E4hvMQTdGL3IlKp+MYBX7Znd7ytCZlUmTmK
         g8bSBzdy1hBk/AzKF3u33QBHdO56aDQFCSIWC1J6RrdCeOTECHrl8kSiyzlycdeZEqoS
         6vZetMb7mpCbgiIcPy99Qdj6xjMlpr7PWD6/mRf/1yA1F/oLhn7JRJVVwUdTy30Wyn4i
         WDridH8QNOlyZL8z2QaJvZ1SuVO3vdqD1UbE7retnh810CmyI9DQHQpLG+4LqWP33qyK
         Lg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863998; x=1768468798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ybe7DAurEBgUEb5ATlnDDYhL1vOoH3YzFdXhAKpi7Y=;
        b=tiyTJf7zUXThdVNii1QOfss0BbiBSrcRTmNzZgvU6n7coCnH9x/XO7zNFZKjndaU1A
         Yr0qlV/rGh0MJxIi1tp8ZV9gXPZqS9YuhVAaA46WKpqXDGEVcZE6yEE6XzK0EmPL/fcc
         xaZWul5UaXD7gzq1JiHTjVypFlGT+rD+2Vb0rc13s/Uw/9WOOhxQwjA7uOLtwKczq6Wb
         z0LSnQxSdsZVoEqCiaEGn5Gmg7aVaJWQ0OYR7ucj7t3dxEi9v5C2GNijs3h2anMQKU1V
         kkJdFs0lfDDEs+Hp/JKxZ2Loauf/C0OzpS1om3mM0WnnSh/SGYZsakekCDzpbJQSatCQ
         7l8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPZHp0jgjN+QTPE/AGVju2pQKYVGrvOJCdxo4nQV2bxLjR+OJSwXOWmSm03KzrW5VgxbzbF7bTBRtIN7Pzgo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkpEONKgk4F/SHwxTCertGt5eB1qi2cNTHXQPyFzQmXOi+u+w4
	j/ha9mqDg7GNcUpCBZECEDqS1U69S3Q4Fr4A/b3AWILGYqfc4vET6739jswVa41BUatBm8PgK8i
	G2pQxbCxHeM465J4eXeUpMs6iUq3F2jh2CfNclwVYLspmRRm6+Dh9
X-Gm-Gg: AY/fxX62BxCJcbyaPJqbAe2aPiKjiNwviO2EVVOo3x/1toUfidguGpt+G1OlpLFvuOK
	2EYhRn9AE24p4CpNigpHt8Y7bVYGmPW7iH66pX6M8YX7PD67g3KMpKOWk3CNzWCeihHp+B0V8gH
	FSxamKklm0w6mwJfkyGaaNPiMB6fJICWCuV54i8tiq9b30r1MT45LrJr05/gQ1vTfLEqdK4VARl
	DZrrQ/NN6jSbmr0AWRjOr1cn8Gc9JI+tAtSNRcZumZEGC1x9JWHN1VvSiehJnfNYXZ41xUl0wqi
	hBjKF2A8o/uz8EcXcyDNV3FHU90gzaGNRc7Q4g/pURXTq9XVbbPglAX3oby7JZlhqhQhafRKfax
	UBd50jUKg1sx/NvUruRImk6ApeH0=
X-Google-Smtp-Source: AGHT+IEVMqSo3kvEwcOIuWZvH9ae6g25u5K+SRDpADhvLa404gSZpymGCaEKl2Gvp0ZLhh5WcAXX/U3TdyL+
X-Received: by 2002:a17:903:1988:b0:2a0:a484:6b86 with SMTP id d9443c01a7336-2a3ee4c13c9mr32066585ad.8.1767863997760;
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cae7d7sm8337595ad.36.2026.01.08.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2EDF9342170;
	Thu,  8 Jan 2026 02:19:57 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 29FD4E42F2C; Thu,  8 Jan 2026 02:19:57 -0700 (MST)
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
Subject: [PATCH v4 15/19] selftests: ublk: implement integrity user copy in kublk
Date: Thu,  8 Jan 2026 02:19:43 -0700
Message-ID: <20260108091948.1099139-16-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If integrity data is enabled for kublk, allocate an integrity buffer for
each I/O. Extend ublk_user_copy() to copy the integrity data between the
ublk request and the integrity buffer if the ublksrv_io_desc indicates
that the request has integrity data.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 41 ++++++++++++++++++++++++----
 tools/testing/selftests/ublk/kublk.h | 14 ++++++++++
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 48e1865b4875..d95937dd6167 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -414,12 +414,14 @@ static void ublk_queue_deinit(struct ublk_queue *q)
 	int nr_ios = q->q_depth;
 
 	if (q->io_cmd_buf)
 		munmap(q->io_cmd_buf, ublk_queue_cmd_buf_sz(q));
 
-	for (i = 0; i < nr_ios; i++)
+	for (i = 0; i < nr_ios; i++) {
 		free(q->ios[i].buf_addr);
+		free(q->ios[i].integrity_buf);
+	}
 }
 
 static void ublk_thread_deinit(struct ublk_thread *t)
 {
 	io_uring_unregister_buffers(&t->ring);
@@ -431,23 +433,25 @@ static void ublk_thread_deinit(struct ublk_thread *t)
 		close(t->ring.ring_fd);
 		t->ring.ring_fd = -1;
 	}
 }
 
-static int ublk_queue_init(struct ublk_queue *q, unsigned long long extra_flags)
+static int ublk_queue_init(struct ublk_queue *q, unsigned long long extra_flags,
+			   __u8 metadata_size)
 {
 	struct ublk_dev *dev = q->dev;
 	int depth = dev->dev_info.queue_depth;
 	int i;
-	int cmd_buf_size, io_buf_size;
+	int cmd_buf_size, io_buf_size, integrity_size;
 	unsigned long off;
 
 	q->tgt_ops = dev->tgt.ops;
 	q->flags = 0;
 	q->q_depth = depth;
 	q->flags = dev->dev_info.flags;
 	q->flags |= extra_flags;
+	q->metadata_size = metadata_size;
 
 	/* Cache fd in queue for fast path access */
 	q->ublk_fd = dev->fds[0];
 
 	cmd_buf_size = ublk_queue_cmd_buf_sz(q);
@@ -459,15 +463,27 @@ static int ublk_queue_init(struct ublk_queue *q, unsigned long long extra_flags)
 				q->dev->dev_info.dev_id, q->q_id);
 		goto fail;
 	}
 
 	io_buf_size = dev->dev_info.max_io_buf_bytes;
+	integrity_size = ublk_integrity_len(q, io_buf_size);
 	for (i = 0; i < q->q_depth; i++) {
 		q->ios[i].buf_addr = NULL;
 		q->ios[i].flags = UBLKS_IO_NEED_FETCH_RQ | UBLKS_IO_FREE;
 		q->ios[i].tag = i;
 
+		if (integrity_size) {
+			q->ios[i].integrity_buf = malloc(integrity_size);
+			if (!q->ios[i].integrity_buf) {
+				ublk_err("ublk dev %d queue %d io %d malloc(%d) failed: %m\n",
+					 dev->dev_info.dev_id, q->q_id, i,
+					 integrity_size);
+				goto fail;
+			}
+		}
+
+
 		if (ublk_queue_no_buf(q))
 			continue;
 
 		if (posix_memalign((void **)&q->ios[i].buf_addr,
 					getpagesize(), io_buf_size)) {
@@ -606,17 +622,17 @@ static void ublk_user_copy(const struct ublk_io *io, __u8 match_ublk_op)
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, io->tag);
 	__u64 off = ublk_user_copy_offset(q->q_id, io->tag);
 	__u8 ublk_op = ublksrv_get_op(iod);
 	__u32 len = iod->nr_sectors << 9;
 	void *addr = io->buf_addr;
+	ssize_t copied;
 
 	if (ublk_op != match_ublk_op)
 		return;
 
 	while (len) {
 		__u32 copy_len = min(len, UBLK_USER_COPY_LEN);
-		ssize_t copied;
 
 		if (ublk_op == UBLK_IO_OP_WRITE)
 			copied = pread(q->ublk_fd, addr, copy_len, off);
 		else if (ublk_op == UBLK_IO_OP_READ)
 			copied = pwrite(q->ublk_fd, addr, copy_len, off);
@@ -625,10 +641,24 @@ static void ublk_user_copy(const struct ublk_io *io, __u8 match_ublk_op)
 		assert(copied == (ssize_t)copy_len);
 		addr += copy_len;
 		off += copy_len;
 		len -= copy_len;
 	}
+
+	if (!(iod->op_flags & UBLK_IO_F_INTEGRITY))
+		return;
+
+	len = ublk_integrity_len(q, iod->nr_sectors << 9);
+	off = ublk_user_copy_offset(q->q_id, io->tag);
+	off |= UBLKSRV_IO_INTEGRITY_FLAG;
+	if (ublk_op == UBLK_IO_OP_WRITE)
+		copied = pread(q->ublk_fd, io->integrity_buf, len, off);
+	else if (ublk_op == UBLK_IO_OP_READ)
+		copied = pwrite(q->ublk_fd, io->integrity_buf, len, off);
+	else
+		assert(0);
+	assert(copied == (ssize_t)len);
 }
 
 int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io)
 {
 	struct ublk_queue *q = ublk_io_to_queue(io);
@@ -1011,11 +1041,12 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 
 	for (i = 0; i < dinfo->nr_hw_queues; i++) {
 		dev->q[i].dev = dev;
 		dev->q[i].q_id = i;
 
-		ret = ublk_queue_init(&dev->q[i], extra_flags);
+		ret = ublk_queue_init(&dev->q[i], extra_flags,
+				      ctx->metadata_size);
 		if (ret) {
 			ublk_err("ublk dev %d queue %d init queue failed\n",
 				 dinfo->dev_id, i);
 			goto fail;
 		}
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index d00f2b465cdf..830b49a7716a 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -110,10 +110,11 @@ struct ublk_ctrl_cmd_data {
 	__u32 len;
 };
 
 struct ublk_io {
 	char *buf_addr;
+	void *integrity_buf;
 
 #define UBLKS_IO_NEED_FETCH_RQ		(1UL << 0)
 #define UBLKS_IO_NEED_COMMIT_RQ_COMP	(1UL << 1)
 #define UBLKS_IO_FREE			(1UL << 2)
 #define UBLKS_IO_NEED_GET_DATA           (1UL << 3)
@@ -173,10 +174,11 @@ struct ublk_queue {
 /* borrow one bit of ublk uapi flags, which may never be used */
 #define UBLKS_Q_AUTO_BUF_REG_FALLBACK	(1ULL << 63)
 #define UBLKS_Q_NO_UBLK_FIXED_FD	(1ULL << 62)
 	__u64 flags;
 	int ublk_fd;	/* cached ublk char device fd */
+	__u8 metadata_size;
 	struct ublk_io ios[UBLK_QUEUE_DEPTH];
 };
 
 struct ublk_thread {
 	struct ublk_dev *dev;
@@ -222,10 +224,22 @@ static inline void ublk_set_integrity_params(const struct dev_ctx *ctx,
 		.csum_type = ctx->csum_type,
 		.tag_size = ctx->tag_size,
 	};
 }
 
+static inline size_t ublk_integrity_len(const struct ublk_queue *q, size_t len)
+{
+	/* All targets currently use interval_exp = logical_bs_shift = 9 */
+	return (len >> 9) * q->metadata_size;
+}
+
+static inline size_t
+ublk_integrity_data_len(const struct ublk_queue *q, size_t integrity_len)
+{
+	return (integrity_len / q->metadata_size) << 9;
+}
+
 static inline int ublk_io_auto_zc_fallback(const struct ublksrv_io_desc *iod)
 {
 	return !!(iod->op_flags & UBLK_IO_F_NEED_REG_BUF);
 }
 
-- 
2.45.2


