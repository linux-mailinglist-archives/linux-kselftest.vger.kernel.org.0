Return-Path: <linux-kselftest+bounces-34018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F01AC8569
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 01:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A918F9E0FD6
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 23:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80EA25A355;
	Thu, 29 May 2025 23:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HVM4EM5o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33082580F3
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562461; cv=none; b=SwkKXMFdL6NRm39iSai5XVncz+e7PpQzz9L6Ww2Gkmdz0qb1FJP9Rfu6thXjbt0vBz1Lp4wSgHcEorFjqF471SwUiPu33AFZaNZpjbL8lYzDKYJPN8/AiRCSQ01KHaC8Xjsf9hoC/q6S8d/8wNcWgcWy6Q6zBg+hscmw/US1l3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562461; c=relaxed/simple;
	bh=KFzR2R0oE+f8Zx4hoiyK9LWJS5zkAw4p1aYmlL54wbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qP3PGpMbUFCO9jokdgshFl+VM6RXM0rKMppCZWELBR2mvrOoBs71FBfckvVD7QTF8w5RYziuIBFNFa0lLOBbhdjlZ33JDD1YCU0AKkVQaaqpJD97tsQEzgv0vl92r1tbPWsJ+EcKgpYg2xGubYvUqraH6Kej0tIJ2giU1wAt04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HVM4EM5o; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2347012f81fso19619465ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 16:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748562456; x=1749167256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpDwixmcLhBwd2X2YXKWEWGwjdFqClV/mbfesZkbLZ4=;
        b=HVM4EM5o3m5NnyEnDtFVv851YsRsOYFOfvZ5S1meTMdIU7rIo79NCE6BVgQbbJqLw3
         PIVBnT2YWC8n/NNFeclz3BHE/1/apz4YPqNxoAsg59bmNnoWMAnJdiuMwsretwYUcKHU
         fffqBc4ghupzcLgrSnVVUAhzC3XvvZ7fJkZuD8R/OHn5unKdzJvMy6X5QZhhzcUFyPrY
         2dy6o8JtHfaA5SrkN4fSMkpGbhwb7HfotO9us3pei2LYmngGYe4hRGvc3EttEkLEBIeH
         +t+m0wCV4CrvC62wKOnlhZiXOPWYXG/VW579qtgzAgNuF0QbBDJUELhIvhwZ+YkPaTcU
         nCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562456; x=1749167256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpDwixmcLhBwd2X2YXKWEWGwjdFqClV/mbfesZkbLZ4=;
        b=Csz/YIyMHJXrCHZcnrpThDRTTUr+32/JZw1xAagip50aZ7jvRW0UcJIk1c32pGXhvX
         IPDhWn3yUybvZlkPn2ENwzkGz2qq718XSOCQmczxT2uVqdEwCc6d9FyKZbegl5FVgAfF
         uQ/dWJU+xxZwLNc9RIVsGV4HEPsMzk6PbvkZZlF4S+U6iDEG86nARopWLTOSmDlItceh
         grLdDcbUeCQduaRFgVwjOePFTj9GKcdg7rBmyMYsVb+3Hs+73ZT4SU3+k2X3Rb+P0dy+
         kbIMEXhk6zv9t9Xy3ROA4p2T88RCZty0j80CUIg1N4SfRKKMZtXUUOx1tdigu3hMIBPM
         lX9w==
X-Forwarded-Encrypted: i=1; AJvYcCUy4QYxmHEQObw2ZJvGbJy6ywtOIzEHcIZdF+HPO8MqQUccpqmii2LqrbzQLXmmp+b05EH+Lw68ic4/AEhbRCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO+Zd06MDdRW01tkIz/xEfPmsnhK5VFD3ryVWRxTqmgzjecXav
	8G6/IdumvzrMNJaPokwZuDGUBhvGlKEdE4gwpx4X+vUiepNiayacyM68+JejgT6n7v/GKc5PChi
	+TBM0p1OTtG9AQ5fH9EjpjNo40n1IWWo+8039PnSPR/snUwqGHg/b
X-Gm-Gg: ASbGnct1SdmYKOKWq38KyTydQRR5ScgTFaav9bAXqyTP23WaOW1k5Io6OR4kZci+aYB
	PKoqI0F84njzfDYwGQ1rrXVweoH8LCoAE3sX/+bHLHsY0iINAOeBGZsn5TXLMZz7IoBH8h9mhYo
	z9Hw4lV/QAO6N7Z8XTh0pYlfV1BBqcL1C6zoV3Aa6eQFjuGRvQDStCl0QQQlTie7JmcPcJbxY+M
	s2pqFxNY7EvWZVMk6XcM6Vd2NjTxjx7k9REZ3dGZEGoLKqT26Mit8hiLRGAy60nPjGV1UNDOyHP
	AmoBBY72wm1MY6r0+nveIxva5nWNx7M2e5t8GmOl0w==
X-Google-Smtp-Source: AGHT+IF+JXhCtFUI7qIQoWLQaSp7IslKBmx1r2vGs1hjp44ssVnCEbbybY4kaM+WQWqB2rfGGO71/R3O8mVk
X-Received: by 2002:a17:902:f652:b0:234:f580:9ed with SMTP id d9443c01a7336-235390e41b7mr1149165ad.21.1748562455933;
        Thu, 29 May 2025 16:47:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-23506d37f6csm1336845ad.83.2025.05.29.16.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 16:47:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 223603404BD;
	Thu, 29 May 2025 17:47:35 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id D603DE4133B; Thu, 29 May 2025 17:47:34 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Thu, 29 May 2025 17:47:17 -0600
Subject: [PATCH v8 8/9] selftests: ublk: add stress test for per io daemons
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-ublk_task_per_io-v8-8-e9d3b119336a@purestorage.com>
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

Add a new test_stress_06 for the per io daemons feature. This is just a
copy of test_stress_01 with the per_io_tasks flag added, with varying
amounts of nthreads. This test is able to reproduce a panic which was
caught manually during development [1]; in the current version of this
patch set, it passes.

Note that this commit also makes all stress tests using the
run_io_and_remove helper more stressful by additionally exercising the
batch submit (queue_rqs) path.

[1] https://lore.kernel.org/linux-block/aDgwGoGCEpwd1mFY@fedora/

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile          |  1 +
 tools/testing/selftests/ublk/test_common.sh    |  5 ++++
 tools/testing/selftests/ublk/test_stress_06.sh | 36 ++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 5d7f4ecfb81612f919a89eb442f948d6bfafe225..1fb1a95d452c2e9a7ed78cb8b12be2b759074e11 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -38,6 +38,7 @@ TEST_PROGS += test_stress_02.sh
 TEST_PROGS += test_stress_03.sh
 TEST_PROGS += test_stress_04.sh
 TEST_PROGS += test_stress_05.sh
+TEST_PROGS += test_stress_06.sh
 
 TEST_GEN_PROGS_EXTENDED = kublk
 
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 0145569ee7e9a45b41898c2c789842b4c8380f18..8a4dbd09feb0a885ec7539f1a285ed6f437fe3ab 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -278,6 +278,11 @@ __run_io_and_remove()
 	fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio \
 		--rw=randrw --norandommap --iodepth=256 --size="${size}" --numjobs="$(nproc)" \
 		--runtime=20 --time_based > /dev/null 2>&1 &
+	fio --name=batchjob --filename=/dev/ublkb"${dev_id}" --ioengine=io_uring \
+		--rw=randrw --norandommap --iodepth=256 --size="${size}" \
+		--numjobs="$(nproc)" --runtime=20 --time_based \
+		--iodepth_batch_submit=32 --iodepth_batch_complete_min=32 \
+		--force_async=7 > /dev/null 2>&1 &
 	sleep 2
 	if [ "${kill_server}" = "yes" ]; then
 		local state
diff --git a/tools/testing/selftests/ublk/test_stress_06.sh b/tools/testing/selftests/ublk/test_stress_06.sh
new file mode 100755
index 0000000000000000000000000000000000000000..3aee8521032e3962b8b070cda8eb295b01e7b124
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stress_06.sh
@@ -0,0 +1,36 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+TID="stress_06"
+ERR_CODE=0
+
+ublk_io_and_remove()
+{
+	run_io_and_remove "$@"
+	ERR_CODE=$?
+	if [ ${ERR_CODE} -ne 0 ]; then
+		echo "$TID failure: $*"
+		_show_result $TID $ERR_CODE
+	fi
+}
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "stress" "run IO and remove device with per_io_tasks"
+
+_create_backfile 0 256M
+_create_backfile 1 128M
+_create_backfile 2 128M
+
+ublk_io_and_remove 8G -t null -q 4 --nthreads 5 --per_io_tasks &
+ublk_io_and_remove 256M -t loop -q 4 --nthreads 3 --per_io_tasks \
+        "${UBLK_BACKFILES[0]}" &
+ublk_io_and_remove 256M -t stripe -q 4 --nthreads 4 --per_io_tasks \
+        "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
+_cleanup_test "stress"
+_show_result $TID $ERR_CODE

-- 
2.34.1


