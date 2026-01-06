Return-Path: <linux-kselftest+bounces-48248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A54CF6286
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 372CC30381B5
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF66239E81;
	Tue,  6 Jan 2026 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bwkToi3f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA521FF46
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661096; cv=none; b=AGFXismqTh+z+PQEr5fAIDgMvxv2N8x6K1klQ/2VmVldvdYAYUNCoSVYYk4TKvmQsQhJshI1zHlyA1LeU7jvZrv/pvMTRrj7dhxa3rE8NvC99isdxOYqemO2cbcE9N3FdvmAGUlPn9D5KJSDwFVjOOLwo2nCaFP8xVEcxRkuyis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661096; c=relaxed/simple;
	bh=O2B3nDNTOvA1fCnP/c4U5ok+FRqPgHkTWB1k6b6wlJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amTKSH18rEYgSrUDqQdkHStMgX0HwQdfJqtI53vfxprEzLqPdhMhkvB54i39otdzgpSOZfh5echXChXtD3IL5n+jY8pyp6YjOPkUM+B0tOik/89JUaArKDh/vKyEzJrkX2Or0pCSQ3yqWINZY/gH0n72Np7iyuVLF0QwY3vsAEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bwkToi3f; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-55fe0e48242so11462e0c.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661090; x=1768265890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CNvd1Mx9gekfNSEieO/2PmHTz2A3J9iRZA5969nWLY=;
        b=bwkToi3ffW+XgrVvqlWjfWxLeL9npKDt1fU3v1x7w502dIRkT9XPfWHSc1662qTSGX
         1+eLhvYv0Bx+TBIuo16oT1Mzid9CT/u7eWIANZ5Yk2EaReHQyzUzJNtMo57wa8iBKryK
         LO/rymVyJXv7sb2BIizNDT3RYARCYzM1f6HOTSNzKMJa7tPyjRUZAaz6Etw+8pvrVnK/
         FyoYfEesE0jiPY9QY2yAMlqOi6ub3LrFH0/5vAd1cyra6/TfeTGzTgdN/L3c0kBim0sW
         y8KkeL+npFWW1cy4bc6Nf6Ii0+Xv7Zbd06GoB39Pdev2IvjKBhiGpjkrzm2uoqKUvAUa
         GwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661090; x=1768265890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2CNvd1Mx9gekfNSEieO/2PmHTz2A3J9iRZA5969nWLY=;
        b=vqPPlJ1pbNy3eQzQ47CZ8qQfi9Gp5Qj/iuwY3tfMaI3GW7XTiHlbpUPsaxS8pEhgDM
         qZ0FutmpqQeDV4EjopL2pFSn7j7W2EIavyujbHINWIl/xffZad67k/VYjyZ+K00gNmMT
         YeRYC4MX6q85RCgVsR3ZvAK5afQpGEfBhNOVXTRSiFPP7hkZWHD7b0kTKrnED6BN7c2m
         RrFfz0XM5E9dOGJ6Zf2oO/+0CaX5MFs5U2XAOMk20k6+MLOVofRu7JqtuWjqy1hca7Y4
         BdOGLn4y8KusIou8ub2/M2/cdgv+cMTKdbnMTlEUTCuYSulAPG1mIgDZovDE4DGdqGb4
         xR2g==
X-Forwarded-Encrypted: i=1; AJvYcCW6G3fDzDjJI1pfK14K7wsIuTyOlOgVHOlh6+uaB9TdZKuMaavwEKRWm8RlRG5vGKd16PU9tZ/KEJqJmif6yPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyvWh4mqjG0Gzd1s5kGDEv8QaGWeIWN6dURmAQSKKIKgvYa4Z1
	vjLmqwJfbYlkR9XT/PGOv4bSgC5HKms7vWqdv1X/dmmOb/BbnZ+B19qjLfgXa6hA87T/e2AdK2q
	13MCTGXgJyrBHRN5pRcax9ORrYKWmR+gvyaj55Aj28NCOgUCAtaCr
X-Gm-Gg: AY/fxX7+ajCeB9EYM0jL1dJ7YV5VBF0wrEXErdUybSjFZnOVL4GqPWOx1LaPFtirFpH
	CK8My8CrsgGjA/YI6ZeUOBKyWKj04dQxbfDkP5BCp/r9HVi6T2gjLwl9UQpxt9TqaYhpLpXD5lX
	JMFjd9Mbytuj2hfrp6ZACNbIBZgxijzi66GVxJ60F6imvcOxdPKjKGlNdx8bNb/WRH+FQpKJFhJ
	XU+c4Dce+9SogZvrV+Q1q/QT/0NV78xWgHIfJ9YFY/QKvxgmjLX/wJP+Uxb/vCh1iFHn9pCmCwD
	ZzAEao6UIRd7m7Nl7Y5g2geYwk//1xIfw9CXnqXWuyHddF1srMlMt2iFngIFPOokZbcWIXYldyi
	drKDTWwj7i2rmbGEJQGBofs+gKkc=
X-Google-Smtp-Source: AGHT+IH8mCx6YKDu+wL7IQQyl+rfNWEG6hhp/rXOGPYtOLg3VYxrjm0M6YCvDU+p9XB1FYaFESnhadRuF0M+
X-Received: by 2002:a05:6122:20a7:b0:559:5ac3:4451 with SMTP id 71dfb90a1353d-5633955dc2bmr276579e0c.3.1767661090697;
        Mon, 05 Jan 2026 16:58:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5633a3b1388sm87798e0c.3.2026.01.05.16.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 514953401CC;
	Mon,  5 Jan 2026 17:58:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 42DBCE44554; Mon,  5 Jan 2026 17:58:09 -0700 (MST)
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
Subject: [PATCH v3 08/19] ublk: move offset check out of __ublk_check_and_get_req()
Date: Mon,  5 Jan 2026 17:57:40 -0700
Message-ID: <20260106005752.3784925-9-csander@purestorage.com>
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

__ublk_check_and_get_req() checks that the passed in offset is within
the data length of the specified ublk request. However, only user copy
(ublk_check_and_get_req()) supports accessing ublk request data at a
nonzero offset. Zero-copy buffer registration (ublk_register_io_buf())
always passes 0 for the offset, so the check is unnecessary. Move the
check from __ublk_check_and_get_req() to ublk_check_and_get_req().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index abb668b460a8..e44ab9981ef4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -253,11 +253,11 @@ struct ublk_params_header {
 
 static void ublk_io_release(void *priv);
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
+		u16 q_id, u16 tag, struct ublk_io *io);
 static inline unsigned int ublk_req_build_flags(struct request *req);
 
 static void ublk_partition_scan_work(struct work_struct *work)
 {
 	struct ublk_device *ub =
@@ -2283,11 +2283,11 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 	int ret;
 
 	if (!ublk_dev_support_zero_copy(ub))
 		return -EINVAL;
 
-	req = __ublk_check_and_get_req(ub, q_id, tag, io, 0);
+	req = __ublk_check_and_get_req(ub, q_id, tag, io);
 	if (!req)
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
 				      issue_flags);
@@ -2577,11 +2577,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 			__func__, cmd_op, tag, ret, io ? io->flags : 0);
 	return ret;
 }
 
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		u16 q_id, u16 tag, struct ublk_io *io, size_t offset)
+		u16 q_id, u16 tag, struct ublk_io *io)
 {
 	struct request *req;
 
 	/*
 	 * can't use io->req in case of concurrent UBLK_IO_COMMIT_AND_FETCH_REQ,
@@ -2598,13 +2598,10 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		goto fail_put;
 
 	if (!ublk_rq_has_data(req))
 		goto fail_put;
 
-	if (offset > blk_rq_bytes(req))
-		goto fail_put;
-
 	return req;
 fail_put:
 	ublk_put_req_ref(io, req);
 	return NULL;
 }
@@ -2682,14 +2679,19 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 
 	if (tag >= ub->dev_info.queue_depth)
 		return -EINVAL;
 
 	io = &ubq->ios[tag];
-	req = __ublk_check_and_get_req(ub, q_id, tag, io, buf_off);
+	req = __ublk_check_and_get_req(ub, q_id, tag, io);
 	if (!req)
 		return -EINVAL;
 
+	if (buf_off > blk_rq_bytes(req)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!ublk_check_ubuf_dir(req, dir)) {
 		ret = -EACCES;
 		goto out;
 	}
 
-- 
2.45.2


