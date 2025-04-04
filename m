Return-Path: <linux-kselftest+bounces-30087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FD3A7B38A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 02:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5526188BCB0
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 00:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257501FDA9D;
	Fri,  4 Apr 2025 00:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="al1GFeeZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3951FCF65
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Apr 2025 00:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725182; cv=none; b=fQGNg2CUkPvGX7W2QQMYIcwzWlbUcQHGUD/o+1M8fBm33lhRmo96XfIhlL9gNLNIiCzK8MmQuxdAzKouLD7w7X/MH5acGDTH2CIYPNagdx8U+RGQv678tHyAZtC1f+Kwbo2yrz1d/M4JVSLwARtJkcOV4zNju0dRLZd2qEjhxmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725182; c=relaxed/simple;
	bh=NVrp4DjqC049trdyXt38Fs5xStbQxpopEnQiUHv5S8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=efn7QyNe6Xes7UF9pekrlmv3nt7kjQN0S+oAH78CwXsWWoFEfb0plfK3XuGjj2HI1SEZbZAahF5ubm3JgamNO7mHDXbpnXSka+Tn2s0V3oVot746QN7GhYVi+mgvpjVwjgoorPa2EIj3GAJzr+q08BHvOPMK4gir1sGraiDCyGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=al1GFeeZ; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-2cc57330163so820112fac.2
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Apr 2025 17:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743725176; x=1744329976; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9NjCpQwdS/tjRu+ZH35wWGlybNLC0F+tRieyOazwc9U=;
        b=al1GFeeZj9v4r4PR9OCn45DrPdk7SWt/s39oh5q4l/dSDQ83xdjg9ZfaPWF6r0U7KR
         ip+/OaHg4Wj0hlRGtQaEDC1zPqZm6/WaE/72fZDA5o38WCE7UThA6+g1BjHrYm7N82Ar
         sgVXeMPI7oaTaqkht0AqzeCRPznVI967CQGL8dPD55kLHt0xP46Jm0hmEw1vQflsHwiS
         GJ3WgBFE0y9SQ5s7nWT6CPy8Fi/CjiDhYfDZAI4gRRAw46SG3X/vG0V+VhEJekMTvgVB
         6sp874qAFsUQEBb7xUEn5Pi52ITa4QgR6WFK2FZB4EuuckluSMR/X/NlQX7bOFufqslw
         txOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743725176; x=1744329976;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NjCpQwdS/tjRu+ZH35wWGlybNLC0F+tRieyOazwc9U=;
        b=f45wm+JxReTvzzPec0nHu4QkTNpG2SMYGrUbOuqafweWUAMM0vVGMJ5D4RaK1NUmri
         3Zf5mivWgH4HTeVGj0XLMWWM7v8dRqHoFgrQhCHySDvgmqXVj1Abh5uX3KXFdDFy58jz
         zrpm/U4o9V3CzLDGXQaj41pjbx/QnfJ62cQ3xA+S49GHKQe96kiRU9O4351CL9hxsmw3
         ySJbRyoLPmJcned1rXNnpR6ox76lyLO7Pp6FTgA3NFKDQyLPCYyFwpoB0ZHMK8uWqhcE
         /XT0q184TEh5cFQGWuqS8CGIeqQQhwbkXXg5bixwzoYuXC4BnO88yQugYiYPNzCD3KQK
         YyfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCjjr7yGR7Kf3sUVf1FK4YL1l5uxvdQ0S9NcKnUzsYveo8R7Pyz4n///dvckmUq4786tJQvLkgRLwspwSlY2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYxHYxWiyGqCL7rBASgAcgcG7S3N9tYhMBpGAOJgEbTACwj5pa
	JfAr3oe47sxg13knRQb53xrQrU77pTPYQjOqrfkxsZJzdPZKyP6GIrxSKoZZhWaRC2oafJRTjBC
	Fg3P09jNW+MIFW3Dex/HLhv8vJxDHbWSl
X-Gm-Gg: ASbGnctuwxfk95nniIT1gF5B0Gb0UEdSdDHypbZnag0Vt/9ozyZ/5tMKpRzvMpbmwcx
	0FWx6p/mDH6J2fQaJoMXTbpDolarlVyoAlATGRwWtBmSwZAqXekIDIaolvlNZGoERnaSn5Ont95
	irra+SC40MdPB8Qzl2aCHiYRR+mr65s3X2UN6l9qRfT3J9AzP2wCTfPl1EmV7TgoBeFa0M5UeMQ
	4BhfRenf7YGQnvr+c377pzasi23Tq4lg5++nms7+QHXfBNMXEcoaK0ZdTi80rURS+X3iWK324y2
	PdFyZaYCmqp73SMrFNsHeJVwAlmPMhsC9U+D0R0/vl+Q4m4Ckw==
X-Google-Smtp-Source: AGHT+IFY4wl8A7fEgE8kS7XG+IgLVHaRQP+Ag5LCoHv0zujATUqUo2EfdxbmMOYDJ8/49At+0DUloTYzFAAM
X-Received: by 2002:a05:6871:a00a:b0:2b3:55b3:e38 with SMTP id 586e51a60fabf-2cc9e659f3fmr793513fac.21.1743725176235;
        Thu, 03 Apr 2025 17:06:16 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2cc84b2034bsm371531fac.32.2025.04.03.17.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 17:06:16 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7CC58340166;
	Thu,  3 Apr 2025 18:06:14 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 3E99CE41794; Thu,  3 Apr 2025 18:06:14 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Thu, 03 Apr 2025 18:05:57 -0600
Subject: [PATCH v3] ublk: improve detection and handling of ublk server
 exit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-ublk_timeout-v3-1-aa09f76c7451@purestorage.com>
X-B4-Tracking: v=1; b=H4sIAGQi72cC/3XM0QqCMBTG8VeRXbc4OzrDrnyPiHDzqKN0sukox
 HdvehMUXf4/+H4L8+QMeXZOFuYoGG/sECM9JEx31dASN3VshoASUpR8Vo/7bTI92XniCnJVKCm
 0LASLl9FRY547d7nG7oyfrHvtehDb+gcKggPHHBsQKKqTqstxdrSdq5aO2vZs4wJ+iAzwi0AuO
 GaF0lJiCgC/xLqub2/c4jzxAAAA
X-Change-ID: 20250325-ublk_timeout-b06b9b51c591
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

There are currently two ways in which ublk server exit is detected by
ublk_drv:

1. uring_cmd cancellation. If there are any outstanding uring_cmds which
   have not been completed to the ublk server when it exits, io_uring
   calls the uring_cmd callback with a special cancellation flag as the
   issuing task is exiting.
2. I/O timeout. This is needed in addition to the above to handle the
   "saturated queue" case, when all I/Os for a given queue are in the
   ublk server, and therefore there are no outstanding uring_cmds to
   cancel when the ublk server exits.

There are a couple of issues with this approach:

- It is complex and inelegant to have two methods to detect the same
  condition
- The second method detects ublk server exit only after a long delay
  (~30s, the default timeout assigned by the block layer). This delays
  the nosrv behavior from kicking in and potential subsequent recovery
  of the device.

The second issue is brought to light with the new test_generic_04. It
fails before this fix:

selftests: ublk: test_generic_04.sh
dev id is 0
dd: error writing '/dev/ublkb0': Input/output error
1+0 records in
0+0 records out
0 bytes copied, 30.0611 s, 0.0 kB/s
DEAD
dd took 31 seconds to exit (>= 5s tolerance)!
generic_04 : [FAIL]

Fix this by instead detecting and handling ublk server exit in the
character file release callback. This has several advantages:

- This one place can handle both saturated and unsaturated queues. Thus,
  it replaces both preexisting methods of detecting ublk server exit.
- It runs quickly on ublk server exit - there is no 30s delay.
- It starts the process of removing task references in ublk_drv. This is
  needed if we want to relax restrictions in the driver like letting
  only one thread serve each queue

There is also the disadvantage that the character file release callback
can also be triggered by intentional close of the file, which is a
significant behavior change. Preexisting ublk servers (libublksrv) are
dependent on the ability to open/close the file multiple times. To
address this, only transition to a nosrv state if the file is released
while the ublk device is live. This allows for programs to open/close
the file multiple times during setup. It is still a behavior change if a
ublk server decides to close/reopen the file while the device is LIVE
(i.e. while it is responsible for serving I/O), but that would be highly
unusual. This behavior is in line with what is done by FUSE, which is
very similar to ublk in that a userspace daemon is providing services
traditionally provided by the kernel.

With this change in, the new test (and all other selftests, and all
ublksrv tests) pass:

selftests: ublk: test_generic_04.sh
dev id is 0
dd: error writing '/dev/ublkb0': Input/output error
1+0 records in
0+0 records out
0 bytes copied, 0.0376731 s, 0.0 kB/s
DEAD
generic_04 : [PASS]

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v3:
- Quiesce queue earlier to avoid concurrent cancellation and "normal"
  completion of io_uring cmds (Ming Lei)
- Fix del_gendisk hang, found by test_stress_02
- Remove unnecessary parameters in fault_inject target (Ming Lei)
- Fix delay implementation to have separate per-I/O delay instead of
  blocking the whole thread (Ming Lei)
- Add delay_us to docs
- Link to v2: https://lore.kernel.org/r/20250402-ublk_timeout-v2-1-249bc5523000@purestorage.com

Changes in v2:
- Leave null ublk selftests target untouched, instead create new
  fault_inject target for injecting per-I/O delay (Ming Lei)
- Allow multiple open/close of ublk character device with some
  restrictions
- Drop patches which made it in separately at https://lore.kernel.org/r/20250401-ublk_selftests-v1-1-98129c9bc8bb@purestorage.com
- Consolidate more nosrv logic in ublk character device release, and
  associated code cleanup
- Link to v1: https://lore.kernel.org/r/20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com
---
 drivers/block/ublk_drv.c                        | 228 +++++++++---------------
 tools/testing/selftests/ublk/Makefile           |   4 +-
 tools/testing/selftests/ublk/fault_inject.c     |  72 ++++++++
 tools/testing/selftests/ublk/kublk.c            |   6 +-
 tools/testing/selftests/ublk/kublk.h            |   4 +
 tools/testing/selftests/ublk/test_generic_04.sh |  43 +++++
 6 files changed, 215 insertions(+), 142 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2fd05c1bd30b03343cb6f357f8c08dd92ff47af9..73baa9d22ccafb00723defa755a0b3aab7238934 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -162,7 +162,6 @@ struct ublk_queue {
 
 	bool force_abort;
 	bool timeout;
-	bool canceling;
 	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
 	unsigned short nr_io_ready;	/* how many ios setup */
 	spinlock_t		cancel_lock;
@@ -199,8 +198,6 @@ struct ublk_device {
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
 	unsigned int		nr_privileged_daemon;
-
-	struct work_struct	nosrv_work;
 };
 
 /* header of ublk_params */
@@ -209,8 +206,9 @@ struct ublk_params_header {
 	__u32	types;
 };
 
-static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
-
+static void ublk_stop_dev_unlocked(struct ublk_device *ub);
+static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
+static void __ublk_quiesce_dev(struct ublk_device *ub);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		struct ublk_queue *ubq, int tag, size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
@@ -1314,8 +1312,6 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 {
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
-	unsigned int nr_inflight = 0;
-	int i;
 
 	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
 		if (!ubq->timeout) {
@@ -1326,26 +1322,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 		return BLK_EH_DONE;
 	}
 
-	if (!ubq_daemon_is_dying(ubq))
-		return BLK_EH_RESET_TIMER;
-
-	for (i = 0; i < ubq->q_depth; i++) {
-		struct ublk_io *io = &ubq->ios[i];
-
-		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
-			nr_inflight++;
-	}
-
-	/* cancelable uring_cmd can't help us if all commands are in-flight */
-	if (nr_inflight == ubq->q_depth) {
-		struct ublk_device *ub = ubq->dev;
-
-		if (ublk_abort_requests(ub, ubq)) {
-			schedule_work(&ub->nosrv_work);
-		}
-		return BLK_EH_DONE;
-	}
-
 	return BLK_EH_RESET_TIMER;
 }
 
@@ -1356,19 +1332,16 @@ static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq)
 	if (unlikely(ubq->fail_io))
 		return BLK_STS_TARGET;
 
-	/* With recovery feature enabled, force_abort is set in
-	 * ublk_stop_dev() before calling del_gendisk(). We have to
-	 * abort all requeued and new rqs here to let del_gendisk()
-	 * move on. Besides, we cannot not call io_uring_cmd_complete_in_task()
-	 * to avoid UAF on io_uring ctx.
+	/*
+	 * force_abort is set in ublk_stop_dev() before calling
+	 * del_gendisk(). We have to abort all requeued and new rqs here
+	 * to let del_gendisk() move on. Besides, we cannot not call
+	 * io_uring_cmd_complete_in_task() to avoid UAF on io_uring ctx.
 	 *
 	 * Note: force_abort is guaranteed to be seen because it is set
 	 * before request queue is unqiuesced.
 	 */
-	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
-		return BLK_STS_IOERR;
-
-	if (unlikely(ubq->canceling))
+	if (unlikely(ubq->force_abort))
 		return BLK_STS_IOERR;
 
 	/* fill iod to slot in io cmd buffer */
@@ -1391,16 +1364,6 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (res != BLK_STS_OK)
 		return res;
 
-	/*
-	 * ->canceling has to be handled after ->force_abort and ->fail_io
-	 * is dealt with, otherwise this request may not be failed in case
-	 * of recovery, and cause hang when deleting disk
-	 */
-	if (unlikely(ubq->canceling)) {
-		__ublk_abort_rq(ubq, rq);
-		return BLK_STS_OK;
-	}
-
 	ublk_queue_cmd(ubq, rq);
 	return BLK_STS_OK;
 }
@@ -1461,8 +1424,71 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
+	int i;
+
+	mutex_lock(&ub->mutex);
+	/*
+	 * If the device is not live, we will not transition to a nosrv
+	 * state. This protects against:
+	 * - accidental poking of the ublk character device
+	 * - some ublk servers which may open/close the ublk character
+	 *   device during startup
+	 */
+	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
+		goto out;
+
+	/*
+	 * Since we are releasing the ublk character file descriptor, we
+	 * know that there cannot be any concurrent file-related
+	 * activity (e.g. uring_cmds or reads/writes). However, I/O
+	 * might still be getting dispatched. Quiesce that too so that
+	 * we don't need to worry about anything concurrent.
+	 *
+	 * We may have already quiesced the queue if we canceled any
+	 * uring_cmds, so only quiesce if necessary (quiesce is not
+	 * idempotent, it has an internal counter which we need to
+	 * manage carefully).
+	 */
+	if (!blk_queue_quiesced(ub->ub_disk->queue))
+		blk_mq_quiesce_queue(ub->ub_disk->queue);
+
+	/*
+	 * Handle any requests outstanding to the ublk server
+	 */
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		ublk_abort_queue(ub, ublk_get_queue(ub, i));
 
+	/*
+	 * Transition the device to the nosrv state. What exactly this
+	 * means depends on the recovery flags
+	 */
+	if (ublk_nosrv_should_stop_dev(ub)) {
+		/*
+		 * Allow any pending/future I/O to pass through quickly
+		 * with an error. This is needed because del_gendisk
+		 * waits for all pending I/O to complete
+		 */
+		for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+			ublk_get_queue(ub, i)->force_abort = true;
+		blk_mq_unquiesce_queue(ub->ub_disk->queue);
+
+		ublk_stop_dev_unlocked(ub);
+	} else {
+		if (ublk_nosrv_dev_should_queue_io(ub)) {
+			__ublk_quiesce_dev(ub);
+		} else {
+			ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
+			for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+				ublk_get_queue(ub, i)->fail_io = true;
+		}
+
+		/* pair with earlier quiesce */
+		blk_mq_unquiesce_queue(ub->ub_disk->queue);
+	}
+
+out:
 	clear_bit(UB_STATE_OPEN, &ub->state);
+	mutex_unlock(&ub->mutex);
 	return 0;
 }
 
@@ -1556,57 +1582,6 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 	}
 }
 
-/* Must be called when queue is frozen */
-static bool ublk_mark_queue_canceling(struct ublk_queue *ubq)
-{
-	bool canceled;
-
-	spin_lock(&ubq->cancel_lock);
-	canceled = ubq->canceling;
-	if (!canceled)
-		ubq->canceling = true;
-	spin_unlock(&ubq->cancel_lock);
-
-	return canceled;
-}
-
-static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
-{
-	bool was_canceled = ubq->canceling;
-	struct gendisk *disk;
-
-	if (was_canceled)
-		return false;
-
-	spin_lock(&ub->lock);
-	disk = ub->ub_disk;
-	if (disk)
-		get_device(disk_to_dev(disk));
-	spin_unlock(&ub->lock);
-
-	/* Our disk has been dead */
-	if (!disk)
-		return false;
-
-	/*
-	 * Now we are serialized with ublk_queue_rq()
-	 *
-	 * Make sure that ubq->canceling is set when queue is frozen,
-	 * because ublk_queue_rq() has to rely on this flag for avoiding to
-	 * touch completed uring_cmd
-	 */
-	blk_mq_quiesce_queue(disk->queue);
-	was_canceled = ublk_mark_queue_canceling(ubq);
-	if (!was_canceled) {
-		/* abort queue is for making forward progress */
-		ublk_abort_queue(ub, ubq);
-	}
-	blk_mq_unquiesce_queue(disk->queue);
-	put_device(disk_to_dev(disk));
-
-	return !was_canceled;
-}
-
 static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
 		unsigned int issue_flags)
 {
@@ -1634,9 +1609,8 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
+	struct ublk_device *ub = ubq->dev;
 	struct task_struct *task;
-	struct ublk_device *ub;
-	bool need_schedule;
 	struct ublk_io *io;
 
 	if (WARN_ON_ONCE(!ubq))
@@ -1649,16 +1623,20 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	if (WARN_ON_ONCE(task && task != ubq->ubq_daemon))
 		return;
 
-	ub = ubq->dev;
-	need_schedule = ublk_abort_requests(ub, ubq);
+	/*
+	 * We could be the first to notice that the ublk server is dying
+	 * here. If we are, quiesce the queue to eliminate concurrent
+	 * "normal" io_uring cmd completions in the I/O submission path.
+	 */
+	mutex_lock(&ub->mutex);
+	if (ub->dev_info.state == UBLK_S_DEV_LIVE &&
+	    !blk_queue_quiesced(ub->ub_disk->queue))
+		blk_mq_quiesce_queue(ub->ub_disk->queue);
+	mutex_unlock(&ub->mutex);
 
 	io = &ubq->ios[pdu->tag];
 	WARN_ON_ONCE(io->cmd != cmd);
 	ublk_cancel_cmd(ubq, io, issue_flags);
-
-	if (need_schedule) {
-		schedule_work(&ub->nosrv_work);
-	}
 }
 
 static inline bool ublk_queue_ready(struct ublk_queue *ubq)
@@ -1756,13 +1734,13 @@ static struct gendisk *ublk_detach_disk(struct ublk_device *ub)
 	return disk;
 }
 
-static void ublk_stop_dev(struct ublk_device *ub)
+static void ublk_stop_dev_unlocked(struct ublk_device *ub)
+	__must_hold(&ub->mutex)
 {
 	struct gendisk *disk;
 
-	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
-		goto unlock;
+		return;
 	if (ublk_nosrv_dev_should_queue_io(ub)) {
 		if (ub->dev_info.state == UBLK_S_DEV_LIVE)
 			__ublk_quiesce_dev(ub);
@@ -1771,38 +1749,12 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	del_gendisk(ub->ub_disk);
 	disk = ublk_detach_disk(ub);
 	put_disk(disk);
- unlock:
-	mutex_unlock(&ub->mutex);
-	ublk_cancel_dev(ub);
 }
 
-static void ublk_nosrv_work(struct work_struct *work)
+static void ublk_stop_dev(struct ublk_device *ub)
 {
-	struct ublk_device *ub =
-		container_of(work, struct ublk_device, nosrv_work);
-	int i;
-
-	if (ublk_nosrv_should_stop_dev(ub)) {
-		ublk_stop_dev(ub);
-		return;
-	}
-
 	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
-		goto unlock;
-
-	if (ublk_nosrv_dev_should_queue_io(ub)) {
-		__ublk_quiesce_dev(ub);
-	} else {
-		blk_mq_quiesce_queue(ub->ub_disk->queue);
-		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
-		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-			ublk_get_queue(ub, i)->fail_io = true;
-		}
-		blk_mq_unquiesce_queue(ub->ub_disk->queue);
-	}
-
- unlock:
+	ublk_stop_dev_unlocked(ub);
 	mutex_unlock(&ub->mutex);
 	ublk_cancel_dev(ub);
 }
@@ -2388,7 +2340,6 @@ static void ublk_remove(struct ublk_device *ub)
 	bool unprivileged;
 
 	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->nosrv_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
 	unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
 	ublk_put_device(ub);
@@ -2675,7 +2626,6 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		goto out_unlock;
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->lock);
-	INIT_WORK(&ub->nosrv_work, ublk_nosrv_work);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
 	if (ret < 0)
@@ -2807,7 +2757,6 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
 static int ublk_ctrl_stop_dev(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->nosrv_work);
 	return 0;
 }
 
@@ -2927,7 +2876,6 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
 	ubq->ubq_daemon = NULL;
 	ubq->timeout = false;
-	ubq->canceling = false;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index c7781efea0f33c02f340f90f547d3a37c1d1b8a0..afee027cccdd1b8f13f1cb9a90a3348cd54b18bc 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -6,6 +6,7 @@ LDLIBS += -lpthread -lm -luring
 TEST_PROGS := test_generic_01.sh
 TEST_PROGS += test_generic_02.sh
 TEST_PROGS += test_generic_03.sh
+TEST_PROGS += test_generic_04.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
@@ -26,7 +27,8 @@ TEST_GEN_PROGS_EXTENDED = kublk
 
 include ../lib.mk
 
-$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe.c
+$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe.c \
+	fault_inject.c
 
 check:
 	shellcheck -x -f gcc *.sh
diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
new file mode 100644
index 0000000000000000000000000000000000000000..3a8574e6a73767b1f9d0d81c62c7dbf28d2445d0
--- /dev/null
+++ b/tools/testing/selftests/ublk/fault_inject.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Fault injection ublk target. Hack this up however you like for
+ * testing specific behaviors of ublk_drv. Currently is a null target
+ * with a configurable delay before completing each I/O. This delay can
+ * be used to test ublk_drv's handling of I/O outstanding to the ublk
+ * server when it dies.
+ */
+
+#include "kublk.h"
+
+static int ublk_fault_inject_tgt_init(const struct dev_ctx *ctx,
+				      struct ublk_dev *dev)
+{
+	const struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
+	unsigned long dev_size = 250UL << 30;
+
+	dev->tgt.dev_size = dev_size;
+	dev->tgt.params = (struct ublk_params) {
+		.types = UBLK_PARAM_TYPE_BASIC,
+		.basic = {
+			.logical_bs_shift	= 9,
+			.physical_bs_shift	= 12,
+			.io_opt_shift		= 12,
+			.io_min_shift		= 9,
+			.max_sectors		= info->max_io_buf_bytes >> 9,
+			.dev_sectors		= dev_size >> 9,
+		},
+	};
+
+	dev->private_data = (void *)(ctx->delay_us * 1000);
+	return 0;
+}
+
+static int ublk_fault_inject_queue_io(struct ublk_queue *q, int tag)
+{
+	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+	struct io_uring_sqe *sqe;
+	struct __kernel_timespec ts = {
+		.tv_nsec = (long long)q->dev->private_data,
+	};
+
+	ublk_queue_alloc_sqes(q, &sqe, 1);
+	io_uring_prep_timeout(sqe, &ts, 1, 0);
+	sqe->user_data = build_user_data(tag, ublksrv_get_op(iod), 0, 1);
+
+	ublk_queued_tgt_io(q, tag, 1);
+
+	return 0;
+}
+
+static void ublk_fault_inject_tgt_io_done(struct ublk_queue *q, int tag,
+					  const struct io_uring_cqe *cqe)
+{
+	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+
+	if (cqe->res != -ETIME)
+		ublk_err("%s: unexpected cqe res %d\n", __func__, cqe->res);
+
+	if (ublk_completed_tgt_io(q, tag))
+		ublk_complete_io(q, tag, iod->nr_sectors << 9);
+	else
+		ublk_err("%s: io not complete after 1 cqe\n", __func__);
+}
+
+const struct ublk_tgt_ops fault_inject_tgt_ops = {
+	.name = "fault_inject",
+	.init_tgt = ublk_fault_inject_tgt_init,
+	.queue_io = ublk_fault_inject_queue_io,
+	.tgt_io_done = ublk_fault_inject_tgt_io_done,
+};
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 91c282bc767449a418cce7fc816dc8e9fc732d6a..b741d91b2288b19d450ad22a045b014da18c3f8d 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -10,6 +10,7 @@ static const struct ublk_tgt_ops *tgt_ops_list[] = {
 	&null_tgt_ops,
 	&loop_tgt_ops,
 	&stripe_tgt_ops,
+	&fault_inject_tgt_ops,
 };
 
 static const struct ublk_tgt_ops *ublk_find_tgt(const char *name)
@@ -1041,7 +1042,7 @@ static int cmd_dev_get_features(void)
 
 static int cmd_dev_help(char *exe)
 {
-	printf("%s add -t [null|loop] [-q nr_queues] [-d depth] [-n dev_id] [backfile1] [backfile2] ...\n", exe);
+	printf("%s add -t [null|loop|stripe|fault_inject] [-q nr_queues] [-d depth] [-n dev_id] [--delay_us delay] [backfile1] [backfile2] ...\n", exe);
 	printf("\t default: nr_queues=2(max 4), depth=128(max 128), dev_id=-1(auto allocation)\n");
 	printf("%s del [-n dev_id] -a \n", exe);
 	printf("\t -a delete all devices -n delete specified device\n");
@@ -1064,6 +1065,7 @@ int main(int argc, char *argv[])
 		{ "zero_copy",          0,      NULL, 'z' },
 		{ "foreground",		0,	NULL,  0  },
 		{ "chunk_size", 	1,	NULL,  0  },
+		{ "delay_us",		1,	NULL,  0  },
 		{ 0, 0, 0, 0 }
 	};
 	int option_idx, opt;
@@ -1112,6 +1114,8 @@ int main(int argc, char *argv[])
 				ctx.fg = 1;
 			if (!strcmp(longopts[option_idx].name, "chunk_size"))
 				ctx.chunk_size = strtol(optarg, NULL, 10);
+			if (!strcmp(longopts[option_idx].name, "delay_us"))
+				ctx.delay_us = strtoll(optarg, NULL, 10);
 		}
 	}
 
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 760ff8ffb8107037a19a8fb7ab408818845e010d..a1a8a802fb43f0fe9272f33c8a3161e9316a5507 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -70,6 +70,9 @@ struct dev_ctx {
 	/* stripe */
 	unsigned int    chunk_size;
 
+	/* fault_inject */
+	long long	delay_us;
+
 	int _evtfd;
 };
 
@@ -357,6 +360,7 @@ static inline int ublk_queue_use_zc(const struct ublk_queue *q)
 extern const struct ublk_tgt_ops null_tgt_ops;
 extern const struct ublk_tgt_ops loop_tgt_ops;
 extern const struct ublk_tgt_ops stripe_tgt_ops;
+extern const struct ublk_tgt_ops fault_inject_tgt_ops;
 
 void backing_file_tgt_deinit(struct ublk_dev *dev);
 int backing_file_tgt_init(struct ublk_dev *dev);
diff --git a/tools/testing/selftests/ublk/test_generic_04.sh b/tools/testing/selftests/ublk/test_generic_04.sh
new file mode 100755
index 0000000000000000000000000000000000000000..48af48164aa444d8ac6a58fef1743d2a16a56a14
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_04.sh
@@ -0,0 +1,43 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_04"
+ERR_CODE=0
+
+_prep_test "fault_inject" "fast cleanup when all I/Os of one hctx are in server"
+
+# configure ublk server to sleep 2s before completing each I/O
+dev_id=$(_add_ublk_dev -t fault_inject -q 2 -d 1 --delay_us 2000000)
+_check_add_dev $TID $?
+
+echo "dev id is ${dev_id}"
+
+STARTTIME=${SECONDS}
+
+dd if=/dev/urandom of=/dev/ublkb${dev_id} oflag=direct bs=4k count=1 &
+dd_pid=$!
+
+__ublk_kill_daemon ${dev_id} "DEAD"
+
+wait $dd_pid
+dd_exitcode=$?
+
+ENDTIME=${SECONDS}
+ELAPSED=$(($ENDTIME - $STARTTIME))
+
+# assert that dd sees an error and exits quickly after ublk server is
+# killed. previously this relied on seeing an I/O timeout and so would
+# take ~30s
+if [ $dd_exitcode -eq 0 ]; then
+        echo "dd unexpectedly exited successfully!"
+        ERR_CODE=255
+fi
+if [ $ELAPSED -ge 5 ]; then
+        echo "dd took $ELAPSED seconds to exit (>= 5s tolerance)!"
+        ERR_CODE=255
+fi
+
+_cleanup_test "fault_inject"
+_show_result $TID $ERR_CODE

---
base-commit: 710e2c687a16b28a873a282517a85faf02a8b7cc
change-id: 20250325-ublk_timeout-b06b9b51c591

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


