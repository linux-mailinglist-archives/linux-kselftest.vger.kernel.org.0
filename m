Return-Path: <linux-kselftest+bounces-48250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A9DCF628F
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C67433044C2B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBD3241663;
	Tue,  6 Jan 2026 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SGberfAT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C07533D6
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661097; cv=none; b=ZnjzCyvIktX5ofmo34Bt02cp/A82lDlv9cDpbwh4Gmlx8JxT52piF0aOeThmELamYm0c6PyOQyiz3TF2P+ZDBSE9K70scgX70WDyOoh7b+MnvYzrsUenvzkNjvQFvctlc1OMMY8Qm/V4aTbI1yWtyV0a+Ik7WfPsRb4dH92c38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661097; c=relaxed/simple;
	bh=K+Ly1Ox8dRBx9GbJxCSicuUIIRFKVZFbpf4vc/s24uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QS5A1Lo8A9lAjbRjrvyFD657tU9fqB6H9wQ3P/uoj8Bz/3vBwCXBYki+eMbW4uJfd6cGSXitRKQfjXxcQTPnmO413tfVVbkSYO2gHCNwf5Va+u3NXY0hxsEuRGlE7eckSn5LsHazkSmPm3Lw3vyFfurr53+AHl9CcxFuSDMPXPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SGberfAT; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-6465a88d296so67926d50.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661091; x=1768265891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOZvbvdmmZEZqcMiM5wY1+jFl0qTfwGtww3RZ6M2ty0=;
        b=SGberfAT3rzrXB8lX0bPSnp44daPXJ9/yQ5KFH5jswcWXxl+E4MCAPmNLBQdXLAzNx
         j7aBLAMOHpppDSbb0FbLQv5M2n5i1tUk8fRq3aGXHjktPFPsx4CWbZo8RI4+7elCJJFT
         15Ybxp7v46c/J+Z7cgmei5DFnnvCURJOuGdNeOHkRHACGFekNsW1f4dsVtDO7aXOGHbP
         Up3Z4KRIS85pqfVcGSj0uc4mEjddBqXQ1Akn6hq9aoSPa1q2YaL10KV71YiIObmgNJDC
         pmv9K1+JtO4cgaV8hgJ7YEvUmurA5hdWY2g0mKrykbudLqXtREkA1JqS+sH7JqhvY+QE
         P4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661091; x=1768265891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qOZvbvdmmZEZqcMiM5wY1+jFl0qTfwGtww3RZ6M2ty0=;
        b=c3t1dnCpnFnsB+xOl0e+ueDqxoI2SNjyeckVr3vEwe2ruT9PmahpNZh32vQfIkceJW
         4dqWiFo3pSHyX/MQ5Cb6lphlAoXlwhT9/loAHKzd5Fq31YG6Q4bC6psN9l8GEcxb4q2y
         4t16w+l5fEDnOEiznyRswFQQp7Uf/ZJqlv4P7/thRFxlvURJXJirVBuM5xQSbzBnLy7C
         oa94Cs7cw+52kRpTLFUfd5n5Kd8XPPKOVr9StApn0+O4r3+52iUgiPmdbgYAAG2rAwoG
         7k3h/ShbbwS5cx6JhYfhzQFI8X2BR/l/PjyYXrkme4F0nxhBrdi4kDC621VNWn2c50G+
         Aibw==
X-Forwarded-Encrypted: i=1; AJvYcCWe/bYBKZJXdrg4howUTDKvTeTeotAgn29CdTENi4Kh8HtCuVXu5PVwwOxwtL7NAVkJUkil5Xb6sZX/pmmyLFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMCjrz9dS+FSXnHl2Dr280ZCApMZkOJbVk993D9OMNtEqwYuBb
	GvpbajT9ZsaZnnF0kIjpH5wVdHmXVcn24/+Sv5Yj/kcE9nI5VOoeYRv5IyfXqbSTfdsI3ZHLQA7
	OxKqn1sIQi0CTAgK6Fp9M9uaShhMA62R4anEV
X-Gm-Gg: AY/fxX42QRGB2I3HPKpMrQsdTlQ5sh5seZabi9vQmpHF0hV20VslpjhDjoQl7YueV1G
	MO2Tj8nlCXlXodYltXgS0X3YexJ3AfdmT2+AA+hL8suihvrBuqoLkYPKCOOhvViPUnm6D7NmuWM
	pXNLj5bYLf8rK1WRFd7ysjMxUOsbnZWNhOnIRgcB3GaYkeuWGvFJ/O9feHHDiKI1+yHn04ICf0/
	KQNkXN/slq3xZVoqyHFwNkY8pW/9pMCDt/h1lJyuvEJgaGgxeRJO9M6np5lfFfLLds+6dpZS+x+
	Zim2uKL2fEYupoe18RmkICtmKTI6Z6gK+UXO2esnItgj7+jmN4fCxYHbFcF3NS1WCOypH6pI4ul
	tqQTPAfDRBua78Nayj2aYRJF+vhaNU0AH19Mx6BfZBw==
X-Google-Smtp-Source: AGHT+IHIDl5pym1kHj6cRi0lIcnBXZXkIIhlpSoHFIti7CRxDMD29jNYI8pmlcFO7ukQoVyyP1PQMyAHrinJ
X-Received: by 2002:a05:690e:12c9:b0:644:6ae9:f60b with SMTP id 956f58d0204a3-6470c8289d7mr1103926d50.1.1767661091197;
        Mon, 05 Jan 2026 16:58:11 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6470d8b531csm64665d50.11.2026.01.05.16.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:11 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id EF41D340DAB;
	Mon,  5 Jan 2026 17:58:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E0CDDE44554; Mon,  5 Jan 2026 17:58:09 -0700 (MST)
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
Subject: [PATCH v3 11/19] ublk: optimize ublk_user_copy() on daemon task
Date: Mon,  5 Jan 2026 17:57:43 -0700
Message-ID: <20260106005752.3784925-12-csander@purestorage.com>
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

ublk user copy syscalls may be issued from any task, so they take a
reference count on the struct ublk_io to check whether it is owned by
the ublk server and prevent a concurrent UBLK_IO_COMMIT_AND_FETCH_REQ
from completing the request. However, if the user copy syscall is issued
on the io's daemon task, a concurrent UBLK_IO_COMMIT_AND_FETCH_REQ isn't
possible, so the atomic reference count dance is unnecessary. Check for
UBLK_IO_FLAG_OWNED_BY_SRV to ensure the request is dispatched to the
sever and obtain the request from ublk_io's req field instead of looking
it up on the tagset. Skip the reference count increment and decrement.
Commit 8a8fe42d765b ("ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon
task") made an analogous optimization for ublk zero copy buffer
registration.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4ffafbfcde3c..af9ae828fd82 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -181,11 +181,11 @@ struct ublk_io {
 	/*
 	 * The number of uses of this I/O by the ublk server
 	 * if user copy or zero copy are enabled:
 	 * - UBLK_REFCOUNT_INIT from dispatch to the server
 	 *   until UBLK_IO_COMMIT_AND_FETCH_REQ
-	 * - 1 for each inflight ublk_ch_{read,write}_iter() call
+	 * - 1 for each inflight ublk_ch_{read,write}_iter() call not on task
 	 * - 1 for each io_uring registered buffer not registered on task
 	 * The I/O can only be completed once all references are dropped.
 	 * User copy and buffer registration operations are only permitted
 	 * if the reference count is nonzero.
 	 */
@@ -2689,10 +2689,11 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 	struct ublk_queue *ubq;
 	struct request *req;
 	struct ublk_io *io;
 	unsigned data_len;
 	bool is_integrity;
+	bool on_daemon;
 	size_t buf_off;
 	u16 tag, q_id;
 	ssize_t ret;
 
 	if (!user_backed_iter(iter))
@@ -2715,13 +2716,24 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 
 	if (tag >= ub->dev_info.queue_depth)
 		return -EINVAL;
 
 	io = &ubq->ios[tag];
-	req = __ublk_check_and_get_req(ub, q_id, tag, io);
-	if (!req)
-		return -EINVAL;
+	on_daemon = current == READ_ONCE(io->task);
+	if (on_daemon) {
+		/* On daemon, io can't be completed concurrently, so skip ref */
+		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+			return -EINVAL;
+
+		req = io->req;
+		if (!ublk_rq_has_data(req))
+			return -EINVAL;
+	} else {
+		req = __ublk_check_and_get_req(ub, q_id, tag, io);
+		if (!req)
+			return -EINVAL;
+	}
 
 	if (is_integrity) {
 		struct blk_integrity *bi = &req->q->limits.integrity;
 
 		data_len = bio_integrity_bytes(bi, blk_rq_sectors(req));
@@ -2742,11 +2754,12 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 		ret = ublk_copy_user_integrity(req, buf_off, iter, dir);
 	else
 		ret = ublk_copy_user_pages(req, buf_off, iter, dir);
 
 out:
-	ublk_put_req_ref(io, req);
+	if (!on_daemon)
+		ublk_put_req_ref(io, req);
 	return ret;
 }
 
 static ssize_t ublk_ch_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-- 
2.45.2


