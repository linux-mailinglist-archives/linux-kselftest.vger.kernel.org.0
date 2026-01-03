Return-Path: <linux-kselftest+bounces-48090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 019F5CEF91D
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 01:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12EB73014DE9
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 00:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6486F256C8D;
	Sat,  3 Jan 2026 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fM4h2r1Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816F5238176
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Jan 2026 00:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401138; cv=none; b=ZKQR8uV4Vb9JvyHdy9Fxi5yoNo2Nhk9JP8ElbC3G/KlU3lcMwet/6ZjucMMawWlLY9F3MKx7PGrQ4Yzy6XUDUmyRz8hBDgdA0yaOQ8mQsCXAuKEcEl4MUxrJc/EM4/llT7Pk+7CH4AFHn2v5G1JxA/1oTAWDcyEHcsBTWcBCnyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401138; c=relaxed/simple;
	bh=gZdfTxZk5VaNifciQtGbLhQujcMObhkbytoMuzp9Q8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3DUyQFAB63TXXp+MgJFbRw/Y+Q9VoCbY6ewf4sEfXHffKWbqgegTNTkc9ilOrdscIMgmriJeuyp1iGSA1c1LfTPyuH1AG/+Qet+db1FcGZXy+wx2fgZixl70FJ7DJnxI6oFEgj3H5mmX24hGqgUG4xZHvOysLH/t3Tvxx6vlco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fM4h2r1Y; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a110548f10so44335235ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 16:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401134; x=1768005934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K93ipimKyaXS6w3F3nTrbjfIYkiy6EMTwAT5DBS8tQg=;
        b=fM4h2r1Y+nBo6GJi7lOfp0/thNX96ILy3aoeYclWJ4RWeK7jMHvtjgi0e/f1CbRwO5
         c+JvBvZjBRmoKQa5V5Dh6QXpddEy3MjpIg78+YJ9lhXefREBn4DElmMeWGpX3Rl1SoxP
         EA8e2VuIxVUcj3outUkPAPDtZ4S9Th6SghAAF7FC6IuFjEpZ0eAh+91jWS3OwDNalgE/
         5A4yYwLmp3/eQ5jiflCY5VV8N+f4++ctS07Ux5HL4sWKXXtS3XEps8+q/EAztMBrjAMm
         Y4cck98u19GFSq3WYAujaKxjjpQ73WylPG1KgwXh2cMhP4CZxql8vb3Tgfh6iXcX+QPf
         FiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401134; x=1768005934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K93ipimKyaXS6w3F3nTrbjfIYkiy6EMTwAT5DBS8tQg=;
        b=S9StZxv9BUJeeK9vZfbIcCbqV1V673LnRaHH4IH70pqk3p8cubbbGrAIWzdkkA9C68
         7eEEypUj5e+nNU2e8vtzDEB6NXmuaHHC+zcsoZhzzg/9cWTbqZ8Vnne3V9ILtyVjQK6q
         ZNbvqEqit7fkzhvU+CsSZUw5T3unpbZUNjsIBhl7nrMLtC1pCuWr869Rhb+lUTVkkO3k
         giBJqCf0Y9EFl4QVVNP8HZdHQK1D+Y6sRlHE6PrOwc5XfIKRp0PP2wm+ZrmevisUKDXK
         Ea9omppeta7OD02MOW5nE3Cfs4QkbyTFeQeq0l46/rx+Bto7Kxx52kIl9CZZEoaihN41
         FEXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw3aeTTe2vkXNYIxFGqze6a98gyEELh+Uyl2n2vl/LKlHVD/eTScQMRhz/zc0vg8drMqqlCX4dkEq8ZIvpkUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQeRgKrtq8nWMV0DG2TD+sim94ziRDUGIFKLB6sTR9jjXVB/rw
	pK5lR2m6F+ffl9dE3IA86jv4QNfO5qsW6ZQECi4TpWt5zkDxHSCONyIKI1yc8RfzMs2Faec5c9s
	w4rnherWZgNrJ6P7P96jxfFsT/oxyN0k+VEwd
X-Gm-Gg: AY/fxX4zENmc4zoKWT43urkEd4x/vPv5KXBKud1O6hgdNuSG2p6lka5FwoGjFLRP+A5
	3UfT7fszxZlhyMKlINuYVzqNvKotPrw3QclrIfQKrBLzD3W5R7ukSUv5jPknJPMdqa0fK+giFEM
	0cepPvD1rFffauTCrna5gFyCZTvJMg6gG3XK64AEAqpJtYoigSoB1fjz5zCJ1eXMfKPmfjudWk/
	tbB6+5ztkXG8KpQci+ADmJK4yyHc/Ra37YVyVU+NbjraMiLBAaZI6wqp1lL3+/lCrvgiGCUW3gn
	66Sslz6Oxum2EmcrS+g780SzFH2ZubY2jJq1zu10cJT/XwVbIfqlydELw63oAhnKDdJlio+tzNK
	cmEL80iRQiBMDVacbXMn3Fe0CGezTZ/ZcegKr7ZZPQA==
X-Google-Smtp-Source: AGHT+IHBmS6K1J76/7U1o+5EfKCLNr5VBY8ZE1oDAMOqu9UGnI/oFXwHEJioMfZeokHhXfBgobMdAGQ3DvRf
X-Received: by 2002:a05:7022:264a:b0:11b:862d:8031 with SMTP id a92af1059eb24-121721380fcmr16129514c88.0.1767401133910;
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12172439a90sm8664373c88.0.2026.01.02.16.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 736E93402EE;
	Fri,  2 Jan 2026 17:45:33 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 70398E4426F; Fri,  2 Jan 2026 17:45:33 -0700 (MST)
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
Subject: [PATCH v2 09/19] ublk: implement integrity user copy
Date: Fri,  2 Jan 2026 17:45:19 -0700
Message-ID: <20260103004529.1582405-10-csander@purestorage.com>
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

From: Stanley Zhang <stazhang@purestorage.com>

Add a function ublk_copy_user_integrity() to copy integrity information
between a request and a user iov_iter. This mirrors the existing
ublk_copy_user_pages() but operates on request integrity data instead of
regular data. Check UBLKSRV_IO_INTEGRITY_FLAG in iocb->ki_pos in
ublk_user_copy() to choose between copying data or integrity data.

Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
[csander: change offset units from data bytes to integrity data bytes,
 test UBLKSRV_IO_INTEGRITY_FLAG after subtracting UBLKSRV_IO_BUF_OFFSET,
 fix CONFIG_BLK_DEV_INTEGRITY=n build,
 rebase on ublk user copy refactor]
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c      | 52 +++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  4 +++
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3149d705cb9a..82b193d63583 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -646,10 +646,15 @@ static inline unsigned ublk_pos_to_tag(loff_t pos)
 {
 	return ((pos - UBLKSRV_IO_BUF_OFFSET) >> UBLK_TAG_OFF) &
 		UBLK_TAG_BITS_MASK;
 }
 
+static inline bool ublk_pos_is_integrity(loff_t pos)
+{
+	return !!((pos - UBLKSRV_IO_BUF_OFFSET) & UBLKSRV_IO_INTEGRITY_FLAG);
+}
+
 static void ublk_dev_param_basic_apply(struct ublk_device *ub)
 {
 	const struct ublk_param_basic *p = &ub->params.basic;
 
 	if (p->attrs & UBLK_ATTR_READ_ONLY)
@@ -1072,10 +1077,37 @@ static size_t ublk_copy_user_pages(const struct request *req,
 			break;
 	}
 	return done;
 }
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static size_t ublk_copy_user_integrity(const struct request *req,
+		unsigned offset, struct iov_iter *uiter, int dir)
+{
+	size_t done = 0;
+	struct bio *bio = req->bio;
+	struct bvec_iter iter;
+	struct bio_vec iv;
+
+	if (!blk_integrity_rq(req))
+		return 0;
+
+	bio_for_each_integrity_vec(iv, bio, iter) {
+		if (!ublk_copy_user_bvec(&iv, &offset, uiter, dir, &done))
+			break;
+	}
+
+	return done;
+}
+#else /* #ifdef CONFIG_BLK_DEV_INTEGRITY */
+static size_t ublk_copy_user_integrity(const struct request *req,
+		unsigned offset, struct iov_iter *uiter, int dir)
+{
+	return 0;
+}
+#endif /* #ifdef CONFIG_BLK_DEV_INTEGRITY */
+
 static inline bool ublk_need_map_req(const struct request *req)
 {
 	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_WRITE;
 }
 
@@ -2686,10 +2718,12 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 {
 	struct ublk_device *ub = iocb->ki_filp->private_data;
 	struct ublk_queue *ubq;
 	struct request *req;
 	struct ublk_io *io;
+	unsigned data_len;
+	bool is_integrity;
 	size_t buf_off;
 	u16 tag, q_id;
 	ssize_t ret;
 
 	if (!user_backed_iter(iter))
@@ -2699,10 +2733,11 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 		return -EACCES;
 
 	tag = ublk_pos_to_tag(iocb->ki_pos);
 	q_id = ublk_pos_to_hwq(iocb->ki_pos);
 	buf_off = ublk_pos_to_buf_off(iocb->ki_pos);
+	is_integrity = ublk_pos_is_integrity(iocb->ki_pos);
 
 	if (q_id >= ub->dev_info.nr_hw_queues)
 		return -EINVAL;
 
 	ubq = ublk_get_queue(ub, q_id);
@@ -2715,21 +2750,31 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 	io = &ubq->ios[tag];
 	req = __ublk_check_and_get_req(ub, q_id, tag, io);
 	if (!req)
 		return -EINVAL;
 
-	if (buf_off > blk_rq_bytes(req)) {
+	if (is_integrity) {
+		struct blk_integrity *bi = &req->q->limits.integrity;
+
+		data_len = bio_integrity_bytes(bi, blk_rq_sectors(req));
+	} else {
+		data_len = blk_rq_bytes(req);
+	}
+	if (buf_off > data_len) {
 		ret = -EINVAL;
 		goto out;
 	}
 
 	if (!ublk_check_ubuf_dir(req, dir)) {
 		ret = -EACCES;
 		goto out;
 	}
 
-	ret = ublk_copy_user_pages(req, buf_off, iter, dir);
+	if (is_integrity)
+		ret = ublk_copy_user_integrity(req, buf_off, iter, dir);
+	else
+		ret = ublk_copy_user_pages(req, buf_off, iter, dir);
 
 out:
 	ublk_put_req_ref(io, req);
 	return ret;
 }
@@ -3963,11 +4008,12 @@ static struct miscdevice ublk_misc = {
 static int __init ublk_init(void)
 {
 	int ret;
 
 	BUILD_BUG_ON((u64)UBLKSRV_IO_BUF_OFFSET +
-			UBLKSRV_IO_BUF_TOTAL_SIZE < UBLKSRV_IO_BUF_OFFSET);
+			UBLKSRV_IO_BUF_TOTAL_SIZE +
+			UBLKSRV_IO_INTEGRITY_FLAG < UBLKSRV_IO_BUF_OFFSET);
 	BUILD_BUG_ON(sizeof(struct ublk_auto_buf_reg) != 8);
 
 	init_waitqueue_head(&ublk_idr_wq);
 
 	ret = misc_register(&ublk_misc);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index a22de3fc5447..87262f5c054b 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -132,10 +132,14 @@
 #define UBLK_MAX_NR_QUEUES	(1U << UBLK_QID_BITS)
 
 #define UBLKSRV_IO_BUF_TOTAL_BITS	(UBLK_QID_OFF + UBLK_QID_BITS)
 #define UBLKSRV_IO_BUF_TOTAL_SIZE	(1ULL << UBLKSRV_IO_BUF_TOTAL_BITS)
 
+/* Copy to/from request integrity buffer instead of data buffer */
+#define UBLK_INTEGRITY_FLAG_OFF UBLKSRV_IO_BUF_TOTAL_BITS
+#define UBLKSRV_IO_INTEGRITY_FLAG (1ULL << UBLK_INTEGRITY_FLAG_OFF)
+
 /*
  * ublk server can register data buffers for incoming I/O requests with a sparse
  * io_uring buffer table. The request buffer can then be used as the data buffer
  * for io_uring operations via the fixed buffer index.
  * Note that the ublk server can never directly access the request data memory.
-- 
2.45.2


