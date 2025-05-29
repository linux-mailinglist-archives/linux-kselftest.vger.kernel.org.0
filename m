Return-Path: <linux-kselftest+bounces-34019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77EEAC855B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 01:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2144E2BCB
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 23:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C2E25A65B;
	Thu, 29 May 2025 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="J6NqbEEq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BC52586C2
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562461; cv=none; b=iylTDqRMpb5qZNLRhKpkx/utnya+YvUGVUbcHztBh6UIwZDMP/ZFjPbTfUKyIMB9ZPhZ7j9n5MySx4ZRFSyVFFhVpagLwph7AcVPAOkW3eyXs6JnBqIzCYlcpeoXjiplN6piuyNZw/88tKuUOAkBn83zTpXrU5MZJU4Rkwwpt60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562461; c=relaxed/simple;
	bh=EKaGxiLerpvAhaoj/Bkw2+Qa/D3Fb5aNXt+5i9rRtAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nx0dqr88ovBmWqqzkf/SmcSe6FEEAYL9t/dCquqLktgIqfaflrv27xCCw4k5BWYFI4v1fywW67ilsr6MYnMx5n2d8yEForbWGFqE0h0hftxBSDPvGTyln8Vk7+dsiD2EPJ9kekW5QgKEGswua4riJRbKWXZ3LRFXpmwJ0F9UTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=J6NqbEEq; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2345c60507bso10403905ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 16:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748562456; x=1749167256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s61w6nBl3jhK5oE1Pz/G6m687SNZu5Nj6nJhmHdEi4Y=;
        b=J6NqbEEqfCV/e2TwuSm2FZgDHVSu8PygHFYj+ivv/yMPTzFu/9UfydIU5ew3sWQ2Ea
         +fpFOETK6zB1QKPMPKge49JSHZKeGR7U8HSe7Us2J/U/ffBGlBY/H7ylKVvezCO8CCJW
         8qllMcTCC2hDhnnxSlEVPBSRYThkLvJ8Vu2sas2gVTCizRgRJKlOGbKQ5vwmfaXsbUBe
         rEtoupPPi8yba1dk9fVf8PYIc5M8eAT7GbpydYAKJ6nU7uKRYIDUyk3pzhEO+Qtp1rNq
         s7p+35/g1qNM55/OEm/YQK5Eic6l79axX4jF59xsI4RZk6RhbnaeCptSy7N0unXvCrS4
         49pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562456; x=1749167256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s61w6nBl3jhK5oE1Pz/G6m687SNZu5Nj6nJhmHdEi4Y=;
        b=ILm7z8Tk2XZNukebj+Y0vcpCl/aaQBxVxQ2FwRZAxvC5k2g4kKJs9v3uqWW5Po+IKI
         x03wHVh1ImAlztPFCE5NSGAZdQ5fZwSjfsMIGkDAeJFr5djZaJemtSK+OvIj/OcLPUQd
         J24M9/IhEPmhcbjVyELOmsCep3nAmQ+ZMtPDJcJ0iZ8wyODxHWcRv63wu1spdJm7eF7/
         EBVXtHEqU6LvJHwlctwZ8XUrin6XAIu6n4W380/eya8UUJerzcwl33tkiXHxXf7AWcR2
         TEHug0GCZO9pV+OcS/LP02jU6rvlQMG9Zy3A5Zsc1wbl40SBKsEKIfSYMD0ii4yqy2ap
         26bA==
X-Forwarded-Encrypted: i=1; AJvYcCVRQpeHA1FJN5By0hQfpDv6SckUMCCEBSIueJX3umv2yJU7UfPHld/Mupd8uUUkDgIJWFv/C1rfcR3i2Dl1dpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xCmocug7w5WKeN16wSIS01psMHMFH1pyHIMl8aeC4shGSr6s
	5QUPwmyL2RHY7lM3rG+u6WnXQ0f37h9dt7awBl855qLSqUNnpzlwLdJQVn0zO8+juGb/j5dhv6Q
	nAimESpuW0W9RkUvAxAQrfY6g8y30FQImZkeZEX5uX2m/R7uZLH/W
X-Gm-Gg: ASbGncsa+pnwERODXyLFKBK2E7c/pW/nEFDn3O/n5tLu/zkoWuhlnwM53s+g/8A73Gn
	l5s1aWtgml0yYHp9Ax9fZbxo1aEd8Hjst2cecQj+DMwreThdPsAptB0cSqWFKKkqacL24viUbcW
	vGS0kTQlKazn/cS0JICxeCMsPQaX+cwZuzC1jQ2l2HQUaRxtOsEYkJ7WVvDUmM00VxhvlA3t9CF
	MAfKIaeHW7wX12bSCCMis4+V3rYETQGUJ9hhi35Jxcz/S0gVF+ZoFSeSPQFYpVNxvHpAW0GqSg/
	7NQBfpuCXSteURI6701JQr4KZgat3d3ib+fgTAwU1w==
X-Google-Smtp-Source: AGHT+IHI6z1oDZXq/Wb6N1cOpSugl+OZhryJC6WXUS3RUrX6fuPhuH1+sEFgnJr143ydH2kBVfVQFwp9imnn
X-Received: by 2002:a17:902:e806:b0:234:f182:a734 with SMTP id d9443c01a7336-23529a10c9fmr19281925ad.31.1748562455772;
        Thu, 29 May 2025 16:47:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-23506d37ea6sm1393275ad.75.2025.05.29.16.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 16:47:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1F2593403C6;
	Thu, 29 May 2025 17:47:35 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id B9719E40F92; Thu, 29 May 2025 17:47:34 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Thu, 29 May 2025 17:47:13 -0600
Subject: [PATCH v8 4/9] selftests: ublk: kublk: lift queue initialization
 out of thread
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-ublk_task_per_io-v8-4-e9d3b119336a@purestorage.com>
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


