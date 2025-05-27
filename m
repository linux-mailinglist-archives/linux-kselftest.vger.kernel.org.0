Return-Path: <linux-kselftest+bounces-33891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E25AC5D79
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 01:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E7C3A5F2A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 23:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7CC2192FB;
	Tue, 27 May 2025 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="O1opTv1r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9605215F6C
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748386900; cv=none; b=JvOE2uc3JJ//ALaYpVMWKTnHwgoKT0454T7OPx28TS4QnwJvrHe3PrHyXN6BP/rJ82bUN4b9bg350L/waR/aWrFISTUCGo2pYvVlTY1fd54Vo8i7DQ1Rf/EllyqIkx+oLQRLL7RQ5t3ja/L6vtr99ZQhn3a37p7T9SclOpVa494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748386900; c=relaxed/simple;
	bh=EKaGxiLerpvAhaoj/Bkw2+Qa/D3Fb5aNXt+5i9rRtAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vGe0c19UiDIjSRkW7qq6MQjApSxaflOssPFTsbjkp0IdLX+Sv1jzJY8pemn6AyktqYElJ+pOl2MUs7k/z9KZBJEb+wH97/KIVD7uQKVzgvKjhk0DwdNKvYj6yap6SZUZpyTRcmAHBnu00Fo5CbD0KDi8a/ydfsThvkUPNe0TKXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=O1opTv1r; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-234ade5a819so10036505ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 16:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748386897; x=1748991697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s61w6nBl3jhK5oE1Pz/G6m687SNZu5Nj6nJhmHdEi4Y=;
        b=O1opTv1rmY4/cbKJhoPN3MI/RrIOBddeSNqdh9nkGQ4cEITkISvI/VmZvSIuHSeCVm
         OdscQs6XDjckCA1HF+CK5kjhPCDnFrkMbzBQ/lGqyeeoKuAL+AeJp/dNz7HVVhg5IY+y
         0vaJwRVZ//g0YbXqWf1lVaqEEbZQdgTuV6z9h0I91KrxnRzPEq7raPUStIwp3OvNgZrB
         vd2OGA39NB2mfCLUC+9xWutaHB4i/RZy1dLgQcKR2PmQ/+6m+NvpHOiwCNQ2hvq+1evo
         fqXiqqv+7ZnD2JeahPUeqE9tbygLUWD6KFEuWeCzeDt9nYUtlzK2J5fOWnPwXII8mzgJ
         xK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748386897; x=1748991697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s61w6nBl3jhK5oE1Pz/G6m687SNZu5Nj6nJhmHdEi4Y=;
        b=Zpxb4VciW+OinJftNdN+D3/PNU05t2FsPJMWEpwsznFhVM/SOX7+FD0YibrKXCZZ2M
         lT2jLd3YWJHWSZRM1yGCZj2MFUkNVGh1ycF2b3bznYwclG0vdMEBbR1YuGNftm5R6O4x
         yhrFwSwiql/H6KPXvNbfjPnJ6yUcg3Kkj1KkfCZHTZ9jrgr9myggsZTtLsGrwaIQ2WVj
         o59jM9LiEwmSuVSWTjiY+VCxcw5KozIFSmqPCb6tANhXDo1hROkicB6auxsioj9Uzh5J
         eIDix5Kyi5W4keeJsR9/lqB+dyI7TKJDyheD2oZ7gL2pqllaKoFElteYS9sGfLds35RK
         XZag==
X-Forwarded-Encrypted: i=1; AJvYcCWsj+V34kCS/f3f3FJiAdVJSC/CgMkYICt3h+Nt2IegNK8FahqyOlbOBeuYTm9/arryPGYFISTQor3HSkrDR9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVl2O7mcHlwtlk/Ievfk3mV1cJkvU3l8+5DGjh57st1KUgZHZM
	xO9plB6jbJMC8FvS1dtjojMQB0irIIWnp4dPjIjkwLhMPrE04dZESt6SlOMX6h+bpMkmdbYYQ74
	QC37Z8jYw+ygDQvxt9mTztLIRO0ajADqLp4Nb
X-Gm-Gg: ASbGncvgVFQC/vXnOP9muy7tJzQrRGyalwAuZ3IpCEHI6lqQsV35U2FlwhI9ogve64c
	2/1fWTFhG9uMrdiZ5HVu8+31/eOF38YNLCYbKyV5DWqhvkibpK2tFS+tTgmYJwQfEjGbn1Dow8E
	i3UcBKGxxkL3Yv9t8+GwFFxYnhaB9mLdH/RQo901qY38JxJkWEk4Pxtn02cCzG1w58LoGYnw4Ut
	6R/aofmL5dOJgxpj1SKVkPwW5zomPFPS8D0Xmr+w1NpNhhZRSJluLIcDr3IWGQTYKdittIxvagx
	TKteWeZGjX4+o3VoTpyQ26rRtzQSd/3TxcBHG/ADkxf9BQ==
X-Google-Smtp-Source: AGHT+IHBgJnJ4t0ZHX1cK5i/ctstGNjkLaCfd1pbaD7diiQqvXBHGlDnwc++pxUSmXvdZ73tM7RbAeZq21nh
X-Received: by 2002:a17:902:e842:b0:22e:4a2e:8ae7 with SMTP id d9443c01a7336-23414f7d0ebmr273932075ad.22.1748386896905;
        Tue, 27 May 2025 16:01:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b2d99e19562sm314a12.12.2025.05.27.16.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 16:01:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 31E01340353;
	Tue, 27 May 2025 17:01:36 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 2E59AE539B9; Tue, 27 May 2025 17:01:36 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 27 May 2025 17:01:27 -0600
Subject: [PATCH v7 4/8] selftests: ublk: kublk: lift queue initialization
 out of thread
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-ublk_task_per_io-v7-4-cbdbaf283baa@purestorage.com>
References: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com>
In-Reply-To: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Currently, each ublk server I/O handler thread initializes its own
queue. However, as we move towards decoupled ublk_queues and ublk server
threads, this model does not make sense anymore, as there will no longer
be a concept of a thread having "its own" queue. So lift queue
initialization out of the per-thread ublk_io_handler_fn and into a loop
in ublk_start_daemon (which runs once for each device).

There is a part of ublk_queue_init (ring initialization) which does
actually need to happen on the thread that will use the ring; that is
separated into a separate ublk_thread_init which is still called by each
I/O handler thread.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 68 +++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 1602cf6f07a02e5dab293b91f301218c38c8f4d9..2d6d163b74483a07066f47fd36781782ce25a16e 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -412,6 +412,17 @@ static void ublk_queue_deinit(struct ublk_queue *q)
 	int i;
 	int nr_ios = q->q_depth;
 
+	if (q->io_cmd_buf)
+		munmap(q->io_cmd_buf, ublk_queue_cmd_buf_sz(q));
+
+	for (i = 0; i < nr_ios; i++)
+		free(q->ios[i].buf_addr);
+}
+
+static void ublk_thread_deinit(struct ublk_queue *q)
+{
+	q->tid = 0;
+
 	io_uring_unregister_buffers(&q->ring);
 
 	io_uring_unregister_ring_fd(&q->ring);
@@ -421,28 +432,20 @@ static void ublk_queue_deinit(struct ublk_queue *q)
 		close(q->ring.ring_fd);
 		q->ring.ring_fd = -1;
 	}
-
-	if (q->io_cmd_buf)
-		munmap(q->io_cmd_buf, ublk_queue_cmd_buf_sz(q));
-
-	for (i = 0; i < nr_ios; i++)
-		free(q->ios[i].buf_addr);
 }
 
 static int ublk_queue_init(struct ublk_queue *q, unsigned extra_flags)
 {
 	struct ublk_dev *dev = q->dev;
 	int depth = dev->dev_info.queue_depth;
-	int i, ret = -1;
+	int i;
 	int cmd_buf_size, io_buf_size;
 	unsigned long off;
-	int ring_depth = dev->tgt.sq_depth, cq_depth = dev->tgt.cq_depth;
 
 	q->tgt_ops = dev->tgt.ops;
 	q->state = 0;
 	q->q_depth = depth;
 	q->cmd_inflight = 0;
-	q->tid = gettid();
 
 	if (dev->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_AUTO_BUF_REG)) {
 		q->state |= UBLKSRV_NO_BUF;
@@ -479,6 +482,22 @@ static int ublk_queue_init(struct ublk_queue *q, unsigned extra_flags)
 		}
 	}
 
+	return 0;
+ fail:
+	ublk_queue_deinit(q);
+	ublk_err("ublk dev %d queue %d failed\n",
+			dev->dev_info.dev_id, q->q_id);
+	return -ENOMEM;
+}
+
+static int ublk_thread_init(struct ublk_queue *q)
+{
+	struct ublk_dev *dev = q->dev;
+	int ring_depth = dev->tgt.sq_depth, cq_depth = dev->tgt.cq_depth;
+	int ret;
+
+	q->tid = gettid();
+
 	ret = ublk_setup_ring(&q->ring, ring_depth, cq_depth,
 			IORING_SETUP_COOP_TASKRUN |
 			IORING_SETUP_SINGLE_ISSUER |
@@ -508,9 +527,9 @@ static int ublk_queue_init(struct ublk_queue *q, unsigned extra_flags)
 	}
 
 	return 0;
- fail:
-	ublk_queue_deinit(q);
-	ublk_err("ublk dev %d queue %d failed\n",
+fail:
+	ublk_thread_deinit(q);
+	ublk_err("ublk dev %d queue %d thread init failed\n",
 			dev->dev_info.dev_id, q->q_id);
 	return -ENOMEM;
 }
@@ -778,7 +797,6 @@ struct ublk_queue_info {
 	struct ublk_queue 	*q;
 	sem_t 			*queue_sem;
 	cpu_set_t 		*affinity;
-	unsigned char 		auto_zc_fallback;
 };
 
 static void *ublk_io_handler_fn(void *data)
@@ -786,15 +804,11 @@ static void *ublk_io_handler_fn(void *data)
 	struct ublk_queue_info *info = data;
 	struct ublk_queue *q = info->q;
 	int dev_id = q->dev->dev_info.dev_id;
-	unsigned extra_flags = 0;
 	int ret;
 
-	if (info->auto_zc_fallback)
-		extra_flags = UBLKSRV_AUTO_BUF_REG_FALLBACK;
-
-	ret = ublk_queue_init(q, extra_flags);
+	ret = ublk_thread_init(q);
 	if (ret) {
-		ublk_err("ublk dev %d queue %d init queue failed\n",
+		ublk_err("ublk dev %d queue %d thread init failed\n",
 				dev_id, q->q_id);
 		return NULL;
 	}
@@ -813,7 +827,7 @@ static void *ublk_io_handler_fn(void *data)
 	} while (1);
 
 	ublk_dbg(UBLK_DBG_QUEUE, "ublk dev %d queue %d exited\n", dev_id, q->q_id);
-	ublk_queue_deinit(q);
+	ublk_thread_deinit(q);
 	return NULL;
 }
 
@@ -857,6 +871,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 {
 	const struct ublksrv_ctrl_dev_info *dinfo = &dev->dev_info;
 	struct ublk_queue_info *qinfo;
+	unsigned extra_flags = 0;
 	cpu_set_t *affinity_buf;
 	void *thread_ret;
 	sem_t queue_sem;
@@ -878,14 +893,23 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	if (ret)
 		return ret;
 
+	if (ctx->auto_zc_fallback)
+		extra_flags = UBLKSRV_AUTO_BUF_REG_FALLBACK;
+
 	for (i = 0; i < dinfo->nr_hw_queues; i++) {
 		dev->q[i].dev = dev;
 		dev->q[i].q_id = i;
 
+		ret = ublk_queue_init(&dev->q[i], extra_flags);
+		if (ret) {
+			ublk_err("ublk dev %d queue %d init queue failed\n",
+				 dinfo->dev_id, i);
+			goto fail;
+		}
+
 		qinfo[i].q = &dev->q[i];
 		qinfo[i].queue_sem = &queue_sem;
 		qinfo[i].affinity = &affinity_buf[i];
-		qinfo[i].auto_zc_fallback = ctx->auto_zc_fallback;
 		pthread_create(&dev->q[i].thread, NULL,
 				ublk_io_handler_fn,
 				&qinfo[i]);
@@ -918,6 +942,8 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	for (i = 0; i < dinfo->nr_hw_queues; i++)
 		pthread_join(dev->q[i].thread, &thread_ret);
  fail:
+	for (i = 0; i < dinfo->nr_hw_queues; i++)
+		ublk_queue_deinit(&dev->q[i]);
 	ublk_dev_unprep(dev);
 	ublk_dbg(UBLK_DBG_DEV, "%s exit\n", __func__);
 

-- 
2.34.1


