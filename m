Return-Path: <linux-kselftest+bounces-47489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A65C2CB7EDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 06:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70FB630719AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 05:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81E830E0D1;
	Fri, 12 Dec 2025 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Lq72N7Tw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f98.google.com (mail-ed1-f98.google.com [209.85.208.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381030DEA3
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 05:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516631; cv=none; b=NOu3qyt0H+cUbVB7UgIYVCcR09/f7D/n5ZniUsOYoIhN1szRBkYzIIImoJUBedEQ1kCxdrojEjnybZFl3K8jhbXP/C6nnIpm0xwMqYopPA3p0lyJieuEgmnDm4sq4I/jur2p3BDtQZF9l4SzRbnth/a+OYu0hS/Mvu2kpwFUuYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516631; c=relaxed/simple;
	bh=NfeLk77tFZmiD9XTisSqHimNCv3ZQEKRAlp4nkzBxoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8bbmshBR9PnXOWwWO5z1d0e98edmEcUutM9MSyvLuCepj1k+jcvehSz9FdElSW5BmlskbnukPC3egSy3dNTC6T9UR5UHmm+LxdsbgmWODjIau3PmZgAJW+Wo9XFXhIo2B5zGNJsNOR8rSDuv12gfWd7xbpOyXiIUMcieK2ZNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Lq72N7Tw; arc=none smtp.client-ip=209.85.208.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f98.google.com with SMTP id 4fb4d7f45d1cf-64981647564so145854a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 21:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765516626; x=1766121426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aozRi9go2wj0syw2Rd2V+7GuC9C7Iw+1DFrkNVNbCsI=;
        b=Lq72N7TwT/BbPU5uh0WSM5G6jVvMu7neySMmShx92qKwe7Hs4RD+3zFgLO6iRzmKji
         mvUMeuBm+lctx27RF/eLE94qmncQpRyKs66zSYoBsRYTqyo7f/PbD8WqNbLKbjxf3TXl
         JmyBZr/aFmpFgo38L8RTz5tWriPzWEWyuTrrARMUSJgLZT2lnpQXFz2FVsd1H9ru4F9C
         PjPgJXCUCzku1Qge4+XK5hRh4Y7zxQkXI2b5AZpxPTIbwY9FDZexLzy5sRFeB1IOC03h
         TZicBxMzrHQNlAnmupm3FAbQnFxv/JxXsJqKZi5XQcM0Ktg05jsPtQCca9jFNpxGedy1
         tBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516626; x=1766121426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aozRi9go2wj0syw2Rd2V+7GuC9C7Iw+1DFrkNVNbCsI=;
        b=X73fP6Q7TfbGxllfO8qzyz4dwqvHyPPqm4hlmGAIV5tF5rM7TQTl9/bAWo+c3mzxFc
         rUGE0ioyYsB5oTBYMw7Yj9heUpi3Xsz06gGcU5hyp4+DMq68BSEuwNdsO6yNJvKXXk66
         Iq++MIg2rx2BMJDahv69Ktuus0/1bsvxdMkLxunA2+TQqAydWyWPJz1L9c8qotDkgi0b
         vZfiDKWAAgcKDrjNjOChHQ9ucNv+l3MNj0uCF3KGbW9Llp6bbayY3O4xKOAs/WfsR+kI
         j6YgsG5HuHQcCLZWGvFzM23Vi3pwN3IAsLSsk/SjwQplNokiavOFxL38NIV3P70jRpQb
         uPcw==
X-Forwarded-Encrypted: i=1; AJvYcCWpLSmsMM7aCFqea8fgMDCxTqQGXegUHhOKhBPNrseDaOsiTrbSW8NqwQplCXFGYGqVR69yg4GqFIE3VZlGEOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd6pJNUIZyj3TSR5qWKQqdB1JNuNXZZHjGIN/oh4BevTDQO+Xz
	bYlFOpeVxMUb2MpRXomRZwpW6si8pbkhlReSRfPs9/JBQIhbMwDN/J56ozf+M7e6UPlcxaOEGvQ
	skZ4gg4XlBvumZkSt3K79o6a9wjtZ1ClYUX+yfNI61jY6bFgcv56e
X-Gm-Gg: AY/fxX41yKbL7atj/KBwNio6P5TnA3q8j4eLdG5/A6bVUpLjfMPY+kGsgOKbi/L1jJg
	OxbVxMAp7zWtSbybivH3VYIFGhBkH5I0gzv2rrG37fn4QXtmATbltt4FS/R2zTf9YkrvJI6ipvx
	2gVHakmINsciEEybrqhlKcg9FjUH1IwXTDYZWlNVxxVfrvmrDy5mAZji2ppJfmeWlbCIJREuR8z
	vKlkG5Xis5fSqNeqMUX0J7uMPqpNu5b0t1fcuk2s3/nLYzR/+YKo97zZLtkUxMHBcOK+ilNX4Kv
	17ZNtBoLNxhmP3LRdetuP9vOOQYMEY1yX7XI94fH8ZJBi7ZzpcUvuGOmd7jWSmcjr/3QAMTrn3I
	nHNRvWFApsOnqQi8iyUtFeBpAGq0=
X-Google-Smtp-Source: AGHT+IFDnLhneNzVMY6p4fz/ZDKfHKmk/av5FXNTC8AM0Gpnr2TTsEKk4xqoki49Ggq9Fc64fzspX7DdbP79
X-Received: by 2002:a17:907:3da7:b0:b73:4445:85a8 with SMTP id a640c23a62f3a-b7d23a8caf0mr37655266b.8.1765516625776;
        Thu, 11 Dec 2025 21:17:05 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b7cfa3456ffsm88038666b.44.2025.12.11.21.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:17:05 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6102434079F;
	Thu, 11 Dec 2025 22:17:04 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5E166E41A2E; Thu, 11 Dec 2025 22:17:04 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 8/8] selftests: ublk: add user copy test cases
Date: Thu, 11 Dec 2025 22:16:58 -0700
Message-ID: <20251212051658.1618543-9-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212051658.1618543-1-csander@purestorage.com>
References: <20251212051658.1618543-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ublk selftests cover every data copy mode except user copy. Add
tests for user copy based on the existing test suite:
- generic_14 ("basic recover function verification (user copy)") based
  on generic_04 and generic_05
- null_03 ("basic IO test with user copy") based on null_01 and null_02
- loop_06 ("write and verify over user copy") based on loop_01 and
  loop_03
- loop_07 ("mkfs & mount & umount with user copy") based on loop_02 and
  loop_04
- stripe_05 ("write and verify test on user copy") based on stripe_03
- stripe_06 ("mkfs & mount & umount on user copy") based on stripe_02
  and stripe_04
- stress_06 ("run IO and remove device (user copy)") based on stress_01
  and stress_03
- stress_07 ("run IO and kill ublk server (user copy)") based on
  stress_02 and stress_04

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile         |  8 ++++
 .../testing/selftests/ublk/test_generic_14.sh | 40 +++++++++++++++++++
 tools/testing/selftests/ublk/test_loop_06.sh  | 25 ++++++++++++
 tools/testing/selftests/ublk/test_loop_07.sh  | 21 ++++++++++
 tools/testing/selftests/ublk/test_null_03.sh  | 24 +++++++++++
 .../testing/selftests/ublk/test_stress_06.sh  | 39 ++++++++++++++++++
 .../testing/selftests/ublk/test_stress_07.sh  | 39 ++++++++++++++++++
 .../testing/selftests/ublk/test_stripe_05.sh  | 26 ++++++++++++
 .../testing/selftests/ublk/test_stripe_06.sh  | 21 ++++++++++
 9 files changed, 243 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_generic_14.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_06.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_07.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_06.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_07.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_05.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_06.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 770269efe42a..837977b62417 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -19,28 +19,36 @@ TEST_PROGS += test_generic_08.sh
 TEST_PROGS += test_generic_09.sh
 TEST_PROGS += test_generic_10.sh
 TEST_PROGS += test_generic_11.sh
 TEST_PROGS += test_generic_12.sh
 TEST_PROGS += test_generic_13.sh
+TEST_PROGS += test_generic_14.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
+TEST_PROGS += test_null_03.sh
 TEST_PROGS += test_loop_01.sh
 TEST_PROGS += test_loop_02.sh
 TEST_PROGS += test_loop_03.sh
 TEST_PROGS += test_loop_04.sh
 TEST_PROGS += test_loop_05.sh
+TEST_PROGS += test_loop_06.sh
+TEST_PROGS += test_loop_07.sh
 TEST_PROGS += test_stripe_01.sh
 TEST_PROGS += test_stripe_02.sh
 TEST_PROGS += test_stripe_03.sh
 TEST_PROGS += test_stripe_04.sh
+TEST_PROGS += test_stripe_05.sh
+TEST_PROGS += test_stripe_06.sh
 
 TEST_PROGS += test_stress_01.sh
 TEST_PROGS += test_stress_02.sh
 TEST_PROGS += test_stress_03.sh
 TEST_PROGS += test_stress_04.sh
 TEST_PROGS += test_stress_05.sh
+TEST_PROGS += test_stress_06.sh
+TEST_PROGS += test_stress_07.sh
 
 TEST_GEN_PROGS_EXTENDED = kublk
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/ublk/test_generic_14.sh b/tools/testing/selftests/ublk/test_generic_14.sh
new file mode 100755
index 000000000000..cd9b44b97c24
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_14.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_14"
+ERR_CODE=0
+
+ublk_run_recover_test()
+{
+	run_io_and_recover 256M "kill_daemon" "$@"
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
+_prep_test "recover" "basic recover function verification (user copy)"
+
+_create_backfile 0 256M
+_create_backfile 1 128M
+_create_backfile 2 128M
+
+ublk_run_recover_test -t null -q 2 -r 1 -u &
+ublk_run_recover_test -t loop -q 2 -r 1 -u "${UBLK_BACKFILES[0]}" &
+ublk_run_recover_test -t stripe -q 2 -r 1 -u "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
+ublk_run_recover_test -t null -q 2 -r 1 -u -i 1 &
+ublk_run_recover_test -t loop -q 2 -r 1 -u -i 1 "${UBLK_BACKFILES[0]}" &
+ublk_run_recover_test -t stripe -q 2 -r 1 -u -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
+_cleanup_test "recover"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_06.sh b/tools/testing/selftests/ublk/test_loop_06.sh
new file mode 100755
index 000000000000..1d1a8a725502
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_loop_06.sh
@@ -0,0 +1,25 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="loop_06"
+ERR_CODE=0
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "loop" "write and verify over user copy"
+
+_create_backfile 0 256M
+dev_id=$(_add_ublk_dev -t loop -u "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
+
+# run fio over the ublk disk
+_run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
+ERR_CODE=$?
+
+_cleanup_test "loop"
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_07.sh b/tools/testing/selftests/ublk/test_loop_07.sh
new file mode 100755
index 000000000000..493f3fb611a5
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_loop_07.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="loop_07"
+ERR_CODE=0
+
+_prep_test "loop" "mkfs & mount & umount with user copy"
+
+_create_backfile 0 256M
+
+dev_id=$(_add_ublk_dev -t loop -u "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
+
+_mkfs_mount_test /dev/ublkb"${dev_id}"
+ERR_CODE=$?
+
+_cleanup_test "loop"
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_null_03.sh b/tools/testing/selftests/ublk/test_null_03.sh
new file mode 100755
index 000000000000..0051067b4686
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_null_03.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="null_03"
+ERR_CODE=0
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "null" "basic IO test with user copy"
+
+dev_id=$(_add_ublk_dev -t null -u)
+_check_add_dev $TID $?
+
+# run fio over the two disks
+fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
+ERR_CODE=$?
+
+_cleanup_test "null"
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_06.sh b/tools/testing/selftests/ublk/test_stress_06.sh
new file mode 100755
index 000000000000..37188ec2e1f7
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stress_06.sh
@@ -0,0 +1,39 @@
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
+_prep_test "stress" "run IO and remove device (user copy)"
+
+_create_backfile 0 256M
+_create_backfile 1 128M
+_create_backfile 2 128M
+
+ublk_io_and_remove 8G -t null -q 4 -u &
+ublk_io_and_remove 256M -t loop -q 4 -u "${UBLK_BACKFILES[0]}" &
+ublk_io_and_remove 256M -t stripe -q 4 -u "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
+ublk_io_and_remove 8G -t null -q 4 -u --nthreads 8 --per_io_tasks &
+ublk_io_and_remove 256M -t loop -q 4 -u --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
+ublk_io_and_remove 256M -t stripe -q 4 -u --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
+_cleanup_test "stress"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_07.sh b/tools/testing/selftests/ublk/test_stress_07.sh
new file mode 100755
index 000000000000..fb061fc26d36
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stress_07.sh
@@ -0,0 +1,39 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+TID="stress_07"
+ERR_CODE=0
+
+ublk_io_and_kill_daemon()
+{
+	run_io_and_kill_daemon "$@"
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
+_prep_test "stress" "run IO and kill ublk server (user copy)"
+
+_create_backfile 0 256M
+_create_backfile 1 128M
+_create_backfile 2 128M
+
+ublk_io_and_kill_daemon 8G -t null -q 4 -u --no_ublk_fixed_fd &
+ublk_io_and_kill_daemon 256M -t loop -q 4 -u --no_ublk_fixed_fd "${UBLK_BACKFILES[0]}" &
+ublk_io_and_kill_daemon 256M -t stripe -q 4 -u "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
+ublk_io_and_kill_daemon 8G -t null -q 4 -u --nthreads 8 --per_io_tasks &
+ublk_io_and_kill_daemon 256M -t loop -q 4 -u --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
+ublk_io_and_kill_daemon 256M -t stripe -q 4 -u --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
+_cleanup_test "stress"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stripe_05.sh b/tools/testing/selftests/ublk/test_stripe_05.sh
new file mode 100755
index 000000000000..05d71951d710
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stripe_05.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="stripe_05"
+ERR_CODE=0
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "stripe" "write and verify test on user copy"
+
+_create_backfile 0 256M
+_create_backfile 1 256M
+
+dev_id=$(_add_ublk_dev -t stripe -q 2 -u "${UBLK_BACKFILES[0]}" "${UBLK_BACKFILES[1]}")
+_check_add_dev $TID $?
+
+# run fio over the ublk disk
+_run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=512M
+ERR_CODE=$?
+
+_cleanup_test "stripe"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stripe_06.sh b/tools/testing/selftests/ublk/test_stripe_06.sh
new file mode 100755
index 000000000000..d06cac7626e2
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stripe_06.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="stripe_06"
+ERR_CODE=0
+
+_prep_test "stripe" "mkfs & mount & umount on user copy"
+
+_create_backfile 0 256M
+_create_backfile 1 256M
+
+dev_id=$(_add_ublk_dev -t stripe -u -q 2 "${UBLK_BACKFILES[0]}" "${UBLK_BACKFILES[1]}")
+_check_add_dev $TID $?
+
+_mkfs_mount_test /dev/ublkb"${dev_id}"
+ERR_CODE=$?
+
+_cleanup_test "stripe"
+_show_result $TID $ERR_CODE
-- 
2.45.2


