Return-Path: <linux-kselftest+bounces-48253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2371BCF6256
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B1AF3009D75
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B86623B628;
	Tue,  6 Jan 2026 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MjI/Ujfr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BBC22D781
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661099; cv=none; b=Q28mzLwWyOi9RRXPLyKR1zg4U2htGkgODnwOhAxtsLEeAZ7fFGRphT/fSkrvboCgDu7N/wdTpdpQNuiHkeTce7PvpENq3kCmpRKreyDUiM89VQ8FPGRIXi/SHP+gXYmT17RXSo/TIoIMkclPDQ5/6M3jiZbzB/JdSzu8qfvFlbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661099; c=relaxed/simple;
	bh=QxssRt2K7/arHhwAENIHPr/xs0l3C9sgNhJ+s1tkF+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSPMYrw0i9mepH2VPxgyKXaPSORwxK65zl2Edq9+hysn68xNVhVMmaJSRt399fwcRpICDBR8wT1pApv1SSVKOSlWhrzJzFt7VWQO8JA3270x/L9dcfUjHzgm2joyUC/PT59B0+VOLHhvSFRhfjsxn8OTSG0ogm03M4jSa469zb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MjI/Ujfr; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-4ed824da05aso106341cf.3
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661092; x=1768265892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tY6pKUQ5Qn3DxRwxGDGPj6r/MLXemuiieYvUhI1zlzM=;
        b=MjI/UjfrUlbaELqYEmKXoImGQYp8AmKATB26fT2jP+kRJK1SvgNdsMvfIMDrp6IOA3
         IA5OjW4mGiVIK+/IBXzx+rrAIvoeAlHeVGhvi8xcD2oEqdRLgx90/m+UlkH4aYQ080sp
         SjeWArG0OUgk3VK+lbp1a9QE2A+QFsPqoqa+jgdYpbDyaImlso5wigNHtpUMyzqPwPrF
         cn09AoGfhE4g4mcJ21Ad+J2e6XpbP6X2x2UsVdZN7cnkQHSuYgQLmWWS7q5tEG/OFYSw
         ulJCasY7c9wqP07zuqhZ0c9l7X9godFYCQsQqa7RC/DK98mwYoWX1AColgThv35jtakf
         BdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661092; x=1768265892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tY6pKUQ5Qn3DxRwxGDGPj6r/MLXemuiieYvUhI1zlzM=;
        b=rskxT6gpiM5VRU4+IOiSP0UjNYufbP2ynrPB4L4pgjrd0aU3PzWK7iq9L2EKRg+CY5
         EImfu1gImTnwQwIZVbqctExBWrs/3MmpENJXPMbS7eZ6Y89obl1eWpBl160H64kUU4en
         GxjIq7mUA+Zyusw2fHZOzjkP6zsNigQFsPsjxEabi6hkLDIxJ9gtOKOpd0s2UnsCxmsf
         oOYUWFkl4PMeB2UZpleUfjvSUFb16DPnI03lzaQ0D6fGPqzHUYcCLm+znw0UwRqqoVGE
         Z/+jz8ukjHD6ePvF3BP1qgLeUIY+TnSOpUoUGlqIJG+DlogQ2zY+xBaOTKn+lLAc/a68
         HWzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo9palOzn7f8031q8VaMYpfErZqwaCgfOQpYEUcfDYrLDdScwsLU+g4TD+PILLQFYxy42xizjw0LoA5ggxpUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH6J4aNssulNbThSB8TFwIgu+8pPuOGqCjG2jC6pMMbdm3I6nn
	eu1yqlIb9Xx8jq2AFrR/GyXIEDaUMnsPp1tTvjolIbR44Zmx3xOVVfeIkgYOOiUKoYR0XGIZP5F
	oa9xBYrsg48nnyWZQxggIoo9T+/GVnDAuMuAEOwSyOiO+n/xJLXdq
X-Gm-Gg: AY/fxX5VcswMxDjkWkuAvzZ7NxfX0717TDZ3sad43+2xQLzATDZCJOMbZbYehbPckFa
	w1enRvDx5Y52YDj56Oc7A+ZvnDwdAnYQ8Vq7DH7e8rZLpi1Mo+XVJ/WrRIVhx8p+mnaBX3T803O
	nzrNXvTJF0EBte9MQJomXR05iGFFGoYunyfX+Zy7Otp+aCXDUfZsTzHyZTqZC6by4zr32NMLqQo
	++OnbL0k0aatAnWg4MN0j8+J5phSCZhKj6BR8DCMcSIHG9AAkdNtlllILbly7ZSsinuLqhEXRtV
	4hsjHiPbgbQCduHhO2xUCE23WnbvJvbslUwdAh4esYdpPB3VwsFBQOvoOGPshErGISxdfdvBmje
	Kj/a0lYMgvTa4HDecUQGEgtjj+Co=
X-Google-Smtp-Source: AGHT+IE3+qV6lMsdT+LdWxtRiwsIoi9qcTbvHyfusqkNl2ZgxSujSJyFfgl/w7QZTFvWDx8SUOCfZjNlVnWi
X-Received: by 2002:a05:622a:1344:b0:4f3:616f:150 with SMTP id d75a77b69052e-4ffa759af60mr16305621cf.0.1767661091737;
        Mon, 05 Jan 2026 16:58:11 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4ffa8d7f1adsm268321cf.2.2026.01.05.16.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:11 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CA1CF34084D;
	Mon,  5 Jan 2026 17:58:10 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BC8ADE44554; Mon,  5 Jan 2026 17:58:10 -0700 (MST)
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
Subject: [PATCH v3 15/19] selftests: ublk: implement integrity user copy in kublk
Date: Mon,  5 Jan 2026 17:57:47 -0700
Message-ID: <20260106005752.3784925-16-csander@purestorage.com>
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
index 6ff110d0dcae..dfba808657b1 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -415,12 +415,14 @@ static void ublk_queue_deinit(struct ublk_queue *q)
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
@@ -432,23 +434,25 @@ static void ublk_thread_deinit(struct ublk_thread *t)
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
@@ -460,15 +464,27 @@ static int ublk_queue_init(struct ublk_queue *q, unsigned long long extra_flags)
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
@@ -607,17 +623,17 @@ static void ublk_user_copy(const struct ublk_io *io, __u8 match_ublk_op)
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
@@ -626,10 +642,24 @@ static void ublk_user_copy(const struct ublk_io *io, __u8 match_ublk_op)
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
+	off += UBLKSRV_IO_INTEGRITY_FLAG;
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
@@ -1012,11 +1042,12 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 
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


