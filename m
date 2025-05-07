Return-Path: <linux-kselftest+bounces-32621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E070BAAEE28
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 23:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BEE16D115
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 21:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD441290DB5;
	Wed,  7 May 2025 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JPIiDyTy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C761728C842
	for <linux-kselftest@vger.kernel.org>; Wed,  7 May 2025 21:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746654598; cv=none; b=gAXLTyco2qF7yX7JyusuJ4DILWAA7BSLJOncZl484wgYm4F/MXQApWWXqmi8hTVWQ04YEXrDtL8piW7YfEKOJZcteaxEzwvMGlWUPwlVyv7NPYs0GXIsqQlWh30+zE1saI3cSOFTrPB/9NnOJIycOvx2ObP8ClwJi2A60df1yl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746654598; c=relaxed/simple;
	bh=ZFZzaNjc/Bh/B/zGxaeX/c2BowDzwJq9cPWBUjqaEfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RmQMjYw4NNXtwd8688hE842vbR4agY9WnSNz7xmxt0FrJ5NVWO91k08uSrPB9mXhGXgqN47fAplxwn9y+Z1JOXslomJMa49t/vS4IzUAKJ0hbGAwbs11R7HNo553lZXhU7SlAm8BaU2J6nhO9P7R4GdrX22wkOapdby4mXqR6io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JPIiDyTy; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-7c54b651310so43133085a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 May 2025 14:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746654590; x=1747259390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6jsT17doysjLFUBKUcJOOjgeMgVhqwCmFUlPQdYH70=;
        b=JPIiDyTyoaF3L67K0uz2xE10tLJ/vH+AWrZhHyOfeOEnJwdKm+TAgae8GUO7qPdjt5
         e/wyINiLb5vol6e+nTx+n19bP7tXB9mUTb6AXPYweMGy4TyxpUiWBK0A8I58mQFKl0Mj
         sFBEE0VS5XMbGwgWWq8i1ydPobIEgtCjUPSb/K36nz4VgXVJicirp1YgGKr0kvyWg0B6
         7M6fDSlnngZHIZlDv6pNuJj3eAEeeOaPVOxBAKsYP6CL1PMUcSunqatEMghIvzCClhrL
         PfEfwzRDp8rshEZjk/GEl499xQLssLG8CSzQ1JUZV3Vb3UFoXo+YgGC9vULt2Egg24JO
         dwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746654590; x=1747259390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6jsT17doysjLFUBKUcJOOjgeMgVhqwCmFUlPQdYH70=;
        b=hT9pDxj433N931jk0aaI/wd1gQgxP3PQ0E2eHQUE8EIJj+qZ4KX1yeHKGk9j70crWK
         iRve1Kf4aJdc1uSzyRiw2rjr3863Cim4GRHNJA9bJA9az78FIx/aTIhD4VDw/2ulSF4G
         BQdVPFb9w9yF5dhDsY5bEPNiEBCcuOqx4y7va8dDXWbGsa0JTlteCRDnpA8uGa9pV1AJ
         kScJZNrm2H3wccep/NUf+zVvFcUZhYQVGr64AGyMPQTeoWyoVSFryiHqWDUXZwQf5WNt
         E926h3I0Fbcx9Ux2HgR9yA+SWYosljTLNZbj2yHGu2uWicZ6Ca4ZWgUvwuykWxc7HXBt
         cinQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxZC8eqpKcC11obXvI6i9HTfU7XQGVMso2dxoXbRHoAInTKJ2z/9tsQ36Gn/igOqQ6t9Wqfvbgb0TM/y2JNgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxADlD7jUXk9GZAQPgY+LaxHTuEB4Vt9Xh+RZBCDJsAns3lcAXU
	EeiJIMEvBGJ1vkE2YMsZoSA28PD6LW+Y3gmohiWHiEZ9V6FY/RmClT0qqM9C1MFKomVmdAFuhvQ
	iv0di2rhCVyoXxlFlzG5il4kylNO37Hyx
X-Gm-Gg: ASbGncuARCd26jTdf3JM5OmvvbqJhEROTweMK4tSbzwK0Z9Ohbxfj7ZhMmhxz1mGJcO
	i77fIzAzyLTWcQuLRkYmUP9OXwoMCF3AZHKPWtUy2xzQD4J0EOuH6N274tPpy4n7oDAe2wrm/c4
	v5wD4+OEvuHKcAMb83MCv2ymoRy03Ip+xVH1Fe0BUr5LMRuSCEDUE+qwEruHi36dRSQvCToRVL1
	CB9BbS8Egma8lXSYKOd/V/Tj/qjcz8i3t+Pird/aIiClOwG26Y428WaTf7GWrZrdA5xwRigGJVI
	AEag712w2FT5a1dC5IVErXOPC3SDnqb+LGmesjAQp+mISQ==
X-Google-Smtp-Source: AGHT+IFoNqe1GKGDGciLt/AJGmYFXZVJHDa+q79fDEXnAtTzrOJDwoRL1Hw8fnNLh7MHppmqDRLnp3lFwCYC
X-Received: by 2002:a05:620a:4591:b0:7c5:fa85:1ac3 with SMTP id af79cd13be357-7caf74061e5mr794141085a.45.1746654590002;
        Wed, 07 May 2025 14:49:50 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-7caf7517fd9sm15048485a.2.2025.05.07.14.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 14:49:49 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 50C683409B2;
	Wed,  7 May 2025 15:49:49 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 477F4E40A46; Wed,  7 May 2025 15:49:49 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 07 May 2025 15:49:38 -0600
Subject: [PATCH v6 4/8] selftests: ublk: kublk: tie sqe allocation to io
 instead of queue
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-ublk_task_per_io-v6-4-a2a298783c01@purestorage.com>
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
In-Reply-To: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

We currently have a helper ublk_queue_alloc_sqes which the ublk targets
use to allocate SQEs for their own operations. However, as we move
towards decoupled ublk_queues and ublk server threads, this helper does
not make sense anymore. SQEs are allocated from rings, and we will have
one ring per thread to avoid locking. Change the SQE allocation helper
to ublk_io_alloc_sqes. Currently this still allocates SQEs from the io's
queue's ring, but when we fully decouple threads and queues, it will
allocate from the io's thread's ring instead.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/fault_inject.c |  2 +-
 tools/testing/selftests/ublk/file_backed.c  |  6 +++---
 tools/testing/selftests/ublk/kublk.c        |  3 ++-
 tools/testing/selftests/ublk/kublk.h        | 11 +++++++----
 tools/testing/selftests/ublk/null.c         |  2 +-
 tools/testing/selftests/ublk/stripe.c       |  4 ++--
 6 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
index 6bc8ee519b483ba6a365dccb03ad389425eefd3b..101c6dad6cf1f6dd45bbc46baa793493b97646bf 100644
--- a/tools/testing/selftests/ublk/fault_inject.c
+++ b/tools/testing/selftests/ublk/fault_inject.c
@@ -41,7 +41,7 @@ static int ublk_fault_inject_queue_io(struct ublk_queue *q, int tag)
 		.tv_nsec = (long long)q->dev->private_data,
 	};
 
-	ublk_queue_alloc_sqes(q, &sqe, 1);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), &sqe, 1);
 	io_uring_prep_timeout(sqe, &ts, 1, 0);
 	sqe->user_data = build_user_data(tag, ublksrv_get_op(iod), 0, q->q_id, 1);
 
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 69991ac7a0a947acba7b23ac89348936a3fcef75..563f11a21604bbf5b9531f69f806d09cdd785960 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -18,7 +18,7 @@ static int loop_queue_flush_io(struct ublk_queue *q, const struct ublksrv_io_des
 	unsigned ublk_op = ublksrv_get_op(iod);
 	struct io_uring_sqe *sqe[1];
 
-	ublk_queue_alloc_sqes(q, sqe, 1);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
 	io_uring_prep_fsync(sqe[0], 1 /*fds[1]*/, IORING_FSYNC_DATASYNC);
 	io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
 	/* bit63 marks us as tgt io */
@@ -34,7 +34,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 	struct io_uring_sqe *sqe[3];
 
 	if (!zc) {
-		ublk_queue_alloc_sqes(q, sqe, 1);
+		ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
 		if (!sqe[0])
 			return -ENOMEM;
 
@@ -48,7 +48,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 		return 1;
 	}
 
-	ublk_queue_alloc_sqes(q, sqe, 3);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 3);
 
 	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index d0eaf06fadbbb00c0549bba0a08f1be23baa2359..7b3af98546803134dd7f959c40408cefda7cd45c 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -439,6 +439,7 @@ static int ublk_queue_init(struct ublk_queue *q)
 	for (i = 0; i < q->q_depth; i++) {
 		q->ios[i].buf_addr = NULL;
 		q->ios[i].flags = UBLKSRV_NEED_FETCH_RQ | UBLKSRV_IO_FREE;
+		q->ios[i].q = q;
 
 		if (q->state & UBLKSRV_NO_BUF)
 			continue;
@@ -554,7 +555,7 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
 	if (io_uring_sq_space_left(&q->ring) < 1)
 		io_uring_submit(&q->ring);
 
-	ublk_queue_alloc_sqes(q, sqe, 1);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
 	if (!sqe[0]) {
 		ublk_err("%s: run out of sqe %d, tag %d\n",
 				__func__, q->q_id, tag);
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 34f92bb2c64d0ddc7690b2654613e0c77b2b8121..7c912116606429215af7dbc2a8ce6b40ef89bfbd 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -119,6 +119,8 @@ struct ublk_io {
 	unsigned short flags;
 	unsigned short refs;		/* used by target code only */
 
+	struct ublk_queue *q;
+
 	int result;
 
 	unsigned short tgt_ios;
@@ -267,17 +269,18 @@ static inline void ublk_dbg(int level, const char *fmt, ...)
 	}
 }
 
-static inline int ublk_queue_alloc_sqes(struct ublk_queue *q,
+static inline int ublk_io_alloc_sqes(struct ublk_io *io,
 		struct io_uring_sqe *sqes[], int nr_sqes)
 {
-	unsigned left = io_uring_sq_space_left(&q->ring);
+	struct io_uring *ring = &io->q->ring;
+	unsigned left = io_uring_sq_space_left(ring);
 	int i;
 
 	if (left < nr_sqes)
-		io_uring_submit(&q->ring);
+		io_uring_submit(ring);
 
 	for (i = 0; i < nr_sqes; i++) {
-		sqes[i] = io_uring_get_sqe(&q->ring);
+		sqes[i] = io_uring_get_sqe(ring);
 		if (!sqes[i])
 			return i;
 	}
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index 8e8e3c27329bf3fa7aeaaef2150bfbe4b22fcd94..7323fe61212f6041ef5a04758d30e62376ac9c6b 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -48,7 +48,7 @@ static int null_queue_zc_io(struct ublk_queue *q, int tag)
 	unsigned ublk_op = ublksrv_get_op(iod);
 	struct io_uring_sqe *sqe[3];
 
-	ublk_queue_alloc_sqes(q, sqe, 3);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 3);
 
 	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
 	sqe[0]->user_data = build_user_data(tag,
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 057d3132aa0d556c649f502a7d738be03207c1f3..d569f62c9b7b5a6b9d82506c4aaab74b77a10305 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -136,7 +136,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_
 	io->private_data = s;
 	calculate_stripe_array(conf, iod, s);
 
-	ublk_queue_alloc_sqes(q, sqe, s->nr + extra);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, s->nr + extra);
 
 	if (zc) {
 		io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
@@ -181,7 +181,7 @@ static int handle_flush(struct ublk_queue *q, const struct ublksrv_io_desc *iod,
 	struct io_uring_sqe *sqe[NR_STRIPE];
 	int i;
 
-	ublk_queue_alloc_sqes(q, sqe, conf->nr_files);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, conf->nr_files);
 	for (i = 0; i < conf->nr_files; i++) {
 		io_uring_prep_fsync(sqe[i], i + 1, IORING_FSYNC_DATASYNC);
 		io_uring_sqe_set_flags(sqe[i], IOSQE_FIXED_FILE);

-- 
2.34.1


