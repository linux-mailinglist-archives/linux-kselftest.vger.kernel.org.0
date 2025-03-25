Return-Path: <linux-kselftest+bounces-29791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8E6A70CC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 23:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9987018994B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E440026A0A6;
	Tue, 25 Mar 2025 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QH0tAUN2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA4269CE0
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941210; cv=none; b=iD4IXPwQ4EcGDiaMRfDSS/sfQDNCAo+3KeQJDxuYgno7daWEnpzWAr903aw018nF7zXayCxdofcf+v1dim++GVPlTj7FaOIfy41OB9kZkwLy/tENjB9q6sD42XTWi+diMEX9o8eHx0tAU/VQSxkscttD/vGPw1Hiv18NJl0xa08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941210; c=relaxed/simple;
	bh=VnRKEjV5fgREpKRGVGNI6L0g4QT2kfv1l9/9qhyTYqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQ4UYh4Q+/oyj1YDPwoXfUSjVmPbicRCnDcsMgf8/w5Ynte/lKE2IWs54wvDB6E3mleqEerfWL20R07U89G1s5uTr/aw37KvUfHp7ZV4uh2vybr23tdM+5FfFlGy60FU4P1YSSHOSlXWopVzyxN96H37GDLx7dSCqsSIa72gDuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QH0tAUN2; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2255003f4c6so119651875ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 15:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742941207; x=1743546007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBZ53h6ZU14UiZLA0LHkEbBlfHC5/MQY5hy1wIXp1Ec=;
        b=QH0tAUN2t8sicEa1ce7JcX093Ou0GD4qJq9F8IR6Yb9wCasXl9PsdGTOTOsZw2qUVH
         DYrMbBEdcs1AW7MgF0C7cfyC+uBAb0aBuBIBHnJJ5DsbWnYruNTOfAb+X14ncoO5+vDK
         t524NE/82c2mQsk5dZF/0uVfK4H1ezl/eSTfSnPqYHKBvGFI/JYhwn+pdu+nWKfftgAa
         L5jggEdRofii+2wgY94aM/+7T9/pkQX0jLedaWfqVNKO5HBXueGthYZ0vCtRngBr/Lp1
         kPhlB8zTmVrK9t/JeELiebaUi/pJnoooD8Hf7JN/f7cdFfhlF7jowUEbIrbjn12d5FTR
         FFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941207; x=1743546007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBZ53h6ZU14UiZLA0LHkEbBlfHC5/MQY5hy1wIXp1Ec=;
        b=GJyZFTobvBY0UXHsguLBkzcYIVGsfs9yj5zp1PQmejRS4Chuw6v8EIH1p1u+t+86BQ
         QeGPRME65ZH3jyX1+XlDOT6e+wAFYbLv8O1IAsFcCl3p6ucbAPYoQikPfjPyFcivOcje
         ipNhknfW8C+bRIcRlgtg7Tmp4R5hR+JUEh0WgcGxj+iEPIEtyRtsYxVSdwitvh7nuAfO
         UNTqmztEbdmNhQuVDc1mgzM0RnlkA5zQ8IFg+DZNwtEzAMuQIeBSEOdK2RH6WsajD13R
         nW83rqipmnaGBMtzVyXZum6HlmXGdFCNhd2nKQpqx4elKkqCV3IK1LIECWSPwUp2PqwW
         HEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCVWw2QxxWJ2eRusG0D/5Kupl0CLvSjTUrg3zwlQdCNoTmKcgfRCd48Xm/pHP/wzIaufz3BfvEfZkZRekygo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP2XSDMoy+lQmbcChwLNn0pQdg0c0/qFAeh3EA/HjFYi6lbade
	9k6fcZxTqe+VBZSkoPUzlaB1OmYPWGYyYau8WWS5ROxorUCzHFj6QysSf1Dn6KmLA1x+caFMIUE
	G3zsEr/wlmrV+xjuzpQr693M712hopX0n9Sp3uCWpn5KC3YD1
X-Gm-Gg: ASbGnctD1PyVNxzwqjgbCYm6ZOhtOdLwcuVeXzHkH3HuKSuONS7A7btcTT13kxtexBV
	4udnMQgQFU9g/a2+yIc7qFoQpDM/W5y0fdAcAXYGRWFd9KOnpm4fR/fUV/j3rKiXrREDdyw12Y+
	/Pr8eTpr0CxsVJT6jvDvilKtvjC7jaDlgurbiWIQ+/tyRVkN26IiwvL5S3naAuk1+LmPfC6jKnf
	fry9zKPZKEmqONNm0M23AwPaHdS8z9kvLfiQNSmeojONrBRoBSnGIpt+eOsMTkPnkMEBmSE4gOk
	n/+7XPNHOwvD8BtkTFsCLzHWrPnS0CScu9o=
X-Google-Smtp-Source: AGHT+IEUsc32nzs+uGub+z1eOKyD8JdjmiwIR/NhfIWNK3pQ3aECuV9tRQ9xvqaMxg5cu2AbcTNwWnrcFz8o
X-Received: by 2002:a05:6a21:2798:b0:1fe:90c5:7cfe with SMTP id adf61e73a8af0-1fe90c57f31mr2947084637.6.1742941207176;
        Tue, 25 Mar 2025 15:20:07 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-af8a27d47cesm206293a12.2.2025.03.25.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 15:20:07 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5F52134071F;
	Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 559BEE415C9; Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 25 Mar 2025 16:19:34 -0600
Subject: [PATCH 4/4] ublk: improve handling of saturated queues when ublk
 server exits
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-ublk_timeout-v1-4-262f0121a7bd@purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
In-Reply-To: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
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

The second method detects ublk server exit only after a long delay
(~30s, the default timeout assigned by the block layer). Any
applications using the ublk device will be left hanging for these 30s
before seeing an error/knowing anything went wrong. This problem is
illustrated by running the new test_generic_02 against a ublk_drv which
doesn't have the fix:

selftests: ublk: test_generic_02.sh
dev id is 0
dd: error writing '/dev/ublkb0': Input/output error
1+0 records in
0+0 records out
0 bytes copied, 30.0611 s, 0.0 kB/s
DEAD
dd took 31 seconds to exit (>= 5s tolerance)!
generic_02 : [FAIL]

Fix this by instead handling the saturated queue case in the ublk
character file release callback. This happens during ublk server exit
and handles the issue much more quickly than an I/O timeout:

selftests: ublk: test_generic_02.sh
dev id is 0
dd: error writing '/dev/ublkb0': Input/output error
1+0 records in
0+0 records out
0 bytes copied, 0.0376731 s, 0.0 kB/s
DEAD
generic_02 : [PASS]

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c                        | 40 +++++++++++------------
 tools/testing/selftests/ublk/Makefile           |  1 +
 tools/testing/selftests/ublk/kublk.c            |  3 ++
 tools/testing/selftests/ublk/kublk.h            |  3 ++
 tools/testing/selftests/ublk/null.c             |  4 +++
 tools/testing/selftests/ublk/test_generic_02.sh | 43 +++++++++++++++++++++++++
 6 files changed, 72 insertions(+), 22 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c060da409ed8a888b7e414c9065efd2cbd6d57d7..1816b2cac01056dc9d01455759594af43c5f78d6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1247,8 +1247,6 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 {
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
-	unsigned int nr_inflight = 0;
-	int i;
 
 	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
 		if (!ubq->timeout) {
@@ -1259,26 +1257,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
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
 
@@ -1351,6 +1329,24 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
+	bool need_schedule = false;
+	int i;
+
+	/*
+	 * Error out any requests outstanding to the ublk server. This
+	 * may have happened already (via uring_cmd cancellation), in
+	 * which case it is not harmful to repeat. But uring_cmd
+	 * cancellation does not handle queues which are fully saturated
+	 * (all requests in ublk server), because from the kernel's POV,
+	 * there are no outstanding uring_cmds to cancel. This code
+	 * handles such queues.
+	 */
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		need_schedule |= ublk_abort_requests(ub, ublk_get_queue(ub, i));
+
+	if (need_schedule)
+		schedule_work(&ub->nosrv_work);
 
 	clear_bit(UB_STATE_OPEN, &ub->state);
 	return 0;
diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 7817afe290053853ce31d28a8f4bbca570c3046c..dcc514b6d8f6e485597320636ab111a17b7e5448 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -4,6 +4,7 @@ CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)
 LDLIBS += -lpthread -lm -luring
 
 TEST_PROGS := test_generic_01.sh
+TEST_PROGS := test_generic_02.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 064a5bb6f12f35892065b8dfacb6f57f6fc16aee..e883cd0f9e330eb15da5a00f6085343333a9355d 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1065,6 +1065,7 @@ int main(int argc, char *argv[])
 		{ "zero_copy",          0,      NULL, 'z' },
 		{ "foreground",		0,	NULL,  0  },
 		{ "chunk_size", 	1,	NULL,  0  },
+		{ "delay_us",		1,	NULL,  0  },
 		{ 0, 0, 0, 0 }
 	};
 	int option_idx, opt;
@@ -1113,6 +1114,8 @@ int main(int argc, char *argv[])
 				ctx.fg = 1;
 			if (!strcmp(longopts[option_idx].name, "chunk_size"))
 				ctx.chunk_size = strtol(optarg, NULL, 10);
+			if (!strcmp(longopts[option_idx].name, "delay_us"))
+				ctx.delay_us = strtoul(optarg, NULL, 10);
 		}
 	}
 
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index f31a5c4d4143e28f13d4cd98d611e37f93b0c25a..6414d482ea3986a9d1973f04a1832d6fe16231bf 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -67,6 +67,9 @@ struct dev_ctx {
 	unsigned int	all:1;
 	unsigned int	fg:1;
 
+	/* null */
+	unsigned long	delay_us;
+
 	/* stripe */
 	unsigned int    chunk_size;
 
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index 899875ff50feadbd734fbbf1f8fad1f19abd1e8f..8bf58e540f1bffc8361450484a6dc484e815378c 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -30,6 +30,8 @@ static int ublk_null_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 
 	if (info->flags & UBLK_F_SUPPORT_ZERO_COPY)
 		dev->tgt.sq_depth = dev->tgt.cq_depth = 2 * info->queue_depth;
+
+	dev->private_data = (void *)ctx->delay_us;
 	return 0;
 }
 
@@ -88,6 +90,8 @@ static int ublk_null_queue_io(struct ublk_queue *q, int tag)
 	int zc = ublk_queue_use_zc(q);
 	int queued;
 
+	usleep((unsigned long)q->dev->private_data);
+
 	if (!zc) {
 		ublk_complete_io(q, tag, iod->nr_sectors << 9);
 		return 0;
diff --git a/tools/testing/selftests/ublk/test_generic_02.sh b/tools/testing/selftests/ublk/test_generic_02.sh
new file mode 100755
index 0000000000000000000000000000000000000000..bc73a17923517ace9590698d82b084fd8d885371
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_02.sh
@@ -0,0 +1,43 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_02"
+ERR_CODE=0
+
+_prep_test "null" "fast cleanup when all I/Os of one hctx are in server"
+
+# configure ublk server to sleep 2s before completing each I/O
+dev_id=$(_add_ublk_dev -t null -q 1 -d 1 --delay_us 2000000)
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
+_cleanup_test "null"
+_show_result $TID $ERR_CODE

-- 
2.34.1


