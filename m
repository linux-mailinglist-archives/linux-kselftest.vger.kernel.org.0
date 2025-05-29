Return-Path: <linux-kselftest+bounces-34017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B710AC8553
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 01:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B95917E4D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 23:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6311B25487E;
	Thu, 29 May 2025 23:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="X776cgSJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD50F2586CA
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562460; cv=none; b=a+RRQosHBlO9XI0+Xs8f+aJYE3gQhNvlunLPku56kuf//5+LG48vMHly1KN7KPXbW4Z5RYbpq4YHVd03G4PcfB1YZSDkTzY+OHzaIKt8svrdmOdvG9r27ORc0sZlLsFLW5tADIHO3mR1dGMZfzAJn5LSrPQqyAGJZ5Ym1ATQkp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562460; c=relaxed/simple;
	bh=hWqXUNlNuCK4Q9YECTnc4oZEdF/T5ZS69mLdCUdnR9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TpTB3OqtzpbLTZz+ifucsUMMw0TADqVWgp2GYQ+ImgmPi/MXZihaF/Vpe+kFkln41wrfjprCxOMzDQJ7XAzaQ838BPYghBufTD5uo7VzqKhsg4zxzVQJZGYfB6rQdC/4Hq2m5XCoiR6ZUnYpfH1uvkqJ9v7+Br5uYTQfGIiFlz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=X776cgSJ; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-742c9563fd9so1191063b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 16:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748562456; x=1749167256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KO7Q0brn+mC3exSfhPb/P6TLoGZgT0VFbz2UZUHX24=;
        b=X776cgSJn8vE4PHUSyxF9l6kLIarXX+xUfn65/TQ3eCdLvBDZ2fLHLFb5Y4QSJ46tf
         JjCtBW9dSkaUetb9xk0En3c9ZL9yg9Ih5UsQ7Jj9HxtY0he2Cw/4cu+Ui1ZmwxJX0U59
         w0F9zUBzRglZfPGEALCGRnoOL+k/XhGzyy1YmFowbgKfiV2ZTdhD/Q35SbY69lkB2P6P
         aO4Q6iNne/Py1e749LZLtGzeVsC7f6RgFuDQ64Voib0byqeLSQYXpJRTDtqV7RbdmMyl
         q5FeyL1X02pXb2J5dNeYYA9vz0p6TitzC0thUoy1ydibCE9jQ4mlPv4h08VbJqqo6bG2
         Ko6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562456; x=1749167256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KO7Q0brn+mC3exSfhPb/P6TLoGZgT0VFbz2UZUHX24=;
        b=PQHcNr+RZ51wd85hKe5mEzgNqT/tCvckCIMDGDjfIQqUs78pDuYImthbjLD3FVbVYL
         snc/dj5zBpA+bQJ7KTQPtMVVPITDUY6vekUm9M0yQsjHsoOeNj86I684WmnTwb188kDN
         pVZuax/AEX0CBGf+N/t+dDFAkXzExEaTxrpT6bET/esg6p5fGcxrPxHvGwpzT7X1IlTU
         ZyXJSROt9EijzxoHnIXEeebg3j8WwYC1mndaIFs2L0Dtf6Si+kiih0rZb2DqPrUvg5UE
         Sj49C7UPjJkLdAJ2y0WY2Joro6DsCMjtUdt3Bde8lmmwVU4wpTPnSdemdpS2bGMHkSzz
         jVjA==
X-Forwarded-Encrypted: i=1; AJvYcCUjrP5XgdnVEnXu5BC6AHTGF/gEH7+0+NLdq6NIWDXr1OzloJvLwJ0PAJd47BvUOgGYzCAc/i1eIMG9zsNR3rI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+JL1KlqnGbQTkHx7Lp0QqrCy8ep7a3aHlIPgrtjtJLu+9ALe
	6aRiK1qZ5mbV7XqU4UD/ZgWPvqjGWv8E0U1aO1fAI9Sy6ObWxVLXg0B1M8TaLVqvWyzIYqsPa+5
	ybgdvN/4W8NqcDzYat7HoDQ3TTFnndXMscdQXFmwgUN9GTMEy3OeT
X-Gm-Gg: ASbGncujZRtl2Oi++3ITW3kW6cxJcDqaLG1g0r+aNnCT5qAPHctFVEYUwYLBlbFxlkn
	A7NCJoqkDBiBfcAQoMSExWl7ZHcBTwZoimPV0qS1gM7LEsRHsZE8wsFEAvUyLoMd55dxTvIXzFU
	2zVlI0f8QY8xEoAx2gqluXuh5zw94qFnzy1F35A9OyjHo/51IMte0Jal9ysaplieZRn6oEyyqg0
	RYUmqostmnhJIO6igRyWU8xAWVTf+5KmEFD6HAL981TCHs7kSDb1/UQfUsyzZ7dvM8M4v/OGUES
	SSZE/E+N0VPlAWo54ProFAblrXG9sxM=
X-Google-Smtp-Source: AGHT+IEVqCT71N1/Q+KrUmCm+XL7nnU0aydRCAtAINblHTXxONLwNimmkTv57RfCjnGkfUgbWsSkkU7b/J9f
X-Received: by 2002:a05:6a21:7a43:b0:1f5:769a:a4be with SMTP id adf61e73a8af0-21ae00c96f9mr329848637.36.1748562455858;
        Thu, 29 May 2025 16:47:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-747afe97a9dsm128814b3a.4.2025.05.29.16.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 16:47:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1F599340442;
	Thu, 29 May 2025 17:47:35 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id B25E9E40F95; Thu, 29 May 2025 17:47:34 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Thu, 29 May 2025 17:47:12 -0600
Subject: [PATCH v8 3/9] selftests: ublk: kublk: tie sqe allocation to io
 instead of queue
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-ublk_task_per_io-v8-3-e9d3b119336a@purestorage.com>
References: <20250529-ublk_task_per_io-v8-0-e9d3b119336a@purestorage.com>
In-Reply-To: <20250529-ublk_task_per_io-v8-0-e9d3b119336a@purestorage.com>
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/fault_inject.c |  2 +-
 tools/testing/selftests/ublk/file_backed.c  |  6 +++---
 tools/testing/selftests/ublk/kublk.c        |  2 +-
 tools/testing/selftests/ublk/kublk.h        | 16 ++++++++++++----
 tools/testing/selftests/ublk/null.c         |  4 ++--
 tools/testing/selftests/ublk/stripe.c       |  4 ++--
 6 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
index 5deff76327b270d2d2d4553c394d95bf27ce8d7e..6e60f7d9712593403ac5547334c86967f0eab8d3 100644
--- a/tools/testing/selftests/ublk/fault_inject.c
+++ b/tools/testing/selftests/ublk/fault_inject.c
@@ -46,7 +46,7 @@ static int ublk_fault_inject_queue_io(struct ublk_queue *q, int tag)
 		.tv_nsec = (long long)q->dev->private_data,
 	};
 
-	ublk_queue_alloc_sqes(q, &sqe, 1);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), &sqe, 1);
 	io_uring_prep_timeout(sqe, &ts, 1, 0);
 	sqe->user_data = build_user_data(tag, ublksrv_get_op(iod), 0, q->q_id, 1);
 
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 0e86123e309c77ad946eaca33a8f4680b688cd41..922a87108b9f7bae53098e74602c7b1f3e0246bc 100644
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
@@ -36,7 +36,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 	void *addr = (zc | auto_zc) ? NULL : (void *)iod->addr;
 
 	if (!zc || auto_zc) {
-		ublk_queue_alloc_sqes(q, sqe, 1);
+		ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
 		if (!sqe[0])
 			return -ENOMEM;
 
@@ -52,7 +52,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 		return 1;
 	}
 
-	ublk_queue_alloc_sqes(q, sqe, 3);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 3);
 
 	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index c3bb52953936134b7ddcf4632b57fdeb57d2d45e..1602cf6f07a02e5dab293b91f301218c38c8f4d9 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -599,7 +599,7 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
 	if (io_uring_sq_space_left(&q->ring) < 1)
 		io_uring_submit(&q->ring);
 
-	ublk_queue_alloc_sqes(q, sqe, 1);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
 	if (!sqe[0]) {
 		ublk_err("%s: run out of sqe %d, tag %d\n",
 				__func__, q->q_id, tag);
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 424e5d96775fe97b20ad8d5537e468477041ca04..64da26725fe1d840b4c61df38206fb3eecd06c22 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -124,6 +124,8 @@ struct ublk_io {
 	unsigned short flags;
 	unsigned short refs;		/* used by target code only */
 
+	int tag;
+
 	int result;
 
 	unsigned short tgt_ios;
@@ -289,17 +291,23 @@ static inline void ublk_dbg(int level, const char *fmt, ...)
 	}
 }
 
-static inline int ublk_queue_alloc_sqes(struct ublk_queue *q,
+static inline struct ublk_queue *ublk_io_to_queue(const struct ublk_io *io)
+{
+	return container_of(io, struct ublk_queue, ios[io->tag]);
+}
+
+static inline int ublk_io_alloc_sqes(struct ublk_io *io,
 		struct io_uring_sqe *sqes[], int nr_sqes)
 {
-	unsigned left = io_uring_sq_space_left(&q->ring);
+	struct io_uring *ring = &ublk_io_to_queue(io)->ring;
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
index c415bf839e87ba35bc87da523a32745584ee2ae4..9acc7e0d271b5ae52d6d31587cc5bfb63b19778d 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -60,7 +60,7 @@ static int null_queue_zc_io(struct ublk_queue *q, int tag)
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 	struct io_uring_sqe *sqe[3];
 
-	ublk_queue_alloc_sqes(q, sqe, 3);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 3);
 
 	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
 	sqe[0]->user_data = build_user_data(tag,
@@ -82,7 +82,7 @@ static int null_queue_auto_zc_io(struct ublk_queue *q, int tag)
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 	struct io_uring_sqe *sqe[1];
 
-	ublk_queue_alloc_sqes(q, sqe, 1);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
 	__setup_nop_io(tag, iod, sqe[0], q->q_id);
 	return 1;
 }
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 4fc45f42b02ecfe063d88d78644ffc142e122942..97079c3121ef8d4edc71891a289dd40658ce3f2a 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -138,7 +138,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_
 	io->private_data = s;
 	calculate_stripe_array(conf, iod, s, base);
 
-	ublk_queue_alloc_sqes(q, sqe, s->nr + extra);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, s->nr + extra);
 
 	if (zc) {
 		io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
@@ -182,7 +182,7 @@ static int handle_flush(struct ublk_queue *q, const struct ublksrv_io_desc *iod,
 	struct io_uring_sqe *sqe[NR_STRIPE];
 	int i;
 
-	ublk_queue_alloc_sqes(q, sqe, conf->nr_files);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, conf->nr_files);
 	for (i = 0; i < conf->nr_files; i++) {
 		io_uring_prep_fsync(sqe[i], i + 1, IORING_FSYNC_DATASYNC);
 		io_uring_sqe_set_flags(sqe[i], IOSQE_FIXED_FILE);

-- 
2.34.1


