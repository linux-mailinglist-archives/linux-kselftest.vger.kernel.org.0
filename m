Return-Path: <linux-kselftest+bounces-47523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79813CB96EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 18:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97EF630DF7EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 17:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D292E8E13;
	Fri, 12 Dec 2025 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="M39/LGVY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542712D94B3
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765559836; cv=none; b=rQ4fPtUvt6xJ+ePye46m151pL82CKvDTYmhVSPZO5y8SlhK/XPAc+3XAFmOyaXK7WGXcX7bva4/tk3VDBrhhd2+KfKqxmaH4ZGfZtlOFzJPMxHMWTSxeqq7R7+saQ9mYICppoFCM5EjAr+2gkasAQw1wgIyRzdwyjQEAlrXZCwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765559836; c=relaxed/simple;
	bh=llE0JIIYQL634M/3G9F8RQU6/HFxWG9VLOlfnehN3hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnF/ZtfQWTrsjixYcYqdUpgLXpP2Ty9yr0vKAo91McRODKmcaRN05VvRxCBTubvmaU1yVFexRWRKQv1aXzK8P1pBITX3QA06vRJFJqdHFK+zfiE1/uZFLzSFt00QnxR4InwSRrtQtVwr3+YMyjuZ/UCm693nRheejZByWyJVqfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=M39/LGVY; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-78d64196795so688477b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 09:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765559831; x=1766164631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/Z7l/OOLX/8k3+ZI1rZl85RyeDw72L7I7CsxK9Jg5s=;
        b=M39/LGVYJ49W0pdxmb3P/w7FgVpmVMgCqrnjChFNxSlnXy2eKKNkoHlf20yX9yhDE+
         00NPMUBAjscifX/rSfWzjuRf/zkHHefhOKw7w50AhSYifePOqfL+OYJ4J+jY+swZq0Bv
         idZ+ORze8iECWfs1RpZ1b+U+bUiNvAjlu0/9RL+wS0JMY3frj2m8ut6q1greuki0pBWY
         uJJk3RiA594C8m3n+u9grIHOuTeWlUhLY89Dhl/uyPpcqGG7yCSbNTSQ1HTvFyFDeZRz
         05SY8O5KDn4AKubne/LyHk+ww4ITFObjTxotpgECUm3DxiAn9tOXswFanzPHFWOy6sjF
         Oyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765559831; x=1766164631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h/Z7l/OOLX/8k3+ZI1rZl85RyeDw72L7I7CsxK9Jg5s=;
        b=p+JNQ+pYCS2WYhKdSn4uATuLQzzPcYp6bhK2duszbRHbFMFrVO8hAq7XHQ3zWXy9Vd
         OpZq9KtQFH8zpKmOmQylv7tElnGf3d0Juiii/dEUxAAFax2Ojhe1fJWdjaURqrCmBQdU
         vlQSJZa6UBa14jWHterrSNXHzzpCVxUbNJ4KVP6Pof0Vm8ecqG6rv8NmebDE031nKtbG
         1hNhfH4FV8oHgEis3kFIA021Lb2fSYwH2LvimgSgpKJtp/mUt/kgdBvNRa5q7Kp7SP2x
         UqfdqZOjHuHd3Fonv12wmzDCIeDfwgATOHk/ok8WOV606iona9C26+JnNB616tL9+Nc8
         M7PA==
X-Forwarded-Encrypted: i=1; AJvYcCXf+2EuhijLwVfIczh0dGdHQgIjGbBKbulatVXij44YAhJPn9VIHvzBNXMsWR8uKUGvCaOcSyxtNpwSzP1FRZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrJYRCU6ZS6Whrhia5g4VkSy9Gym6/9CjGG5XUo6dZjGAVoOKv
	SZd3mLGC1iDry8oHP+osMYR9enFGt1yBK8gK1dzzjPg2zxBlctWhYqqj+vFJWl9h+vpY1j07c4G
	P35hQyT4tbsZHfJdR/I1C7UrEDSLxi+Os3tropS27CeXIynp12B4W
X-Gm-Gg: AY/fxX6qOwhkQndioMbVLuGYLMo31PvXK55fLC/cpbGBnq7LJP8q0IvKnilsSys8CZu
	zdYF/Co0tSCwyX220aBTe+S37RDJjhra04brgk11jAxXh6qkGkNvOgNNyWVvtzG3iBo2lNXfPvp
	oLJlG3wTfnH5P1Rr0uu5ztdb8mnFscJa8WSYlps+hB9oobuo2L5Np7xYgDPRFwShFLhZdFfGsYI
	jfsXOh8BSAts1ToenWrWjy2Oo+lSsxnfXAPRut6gPd9tPK/cCFQ8RboEeDplK1EPNGm70RiF7sg
	bRwHuZ5XnUVkYVKignvYw5Ved0CbY+Lgmg/L54PZo/lm75Er/A3bn2FcjMtc7kPQIXjiyREBJA4
	ygdOtj91FZNRthn4g+3Eeu7CkJCo=
X-Google-Smtp-Source: AGHT+IHd+TXPCBhv1un/V2ZO13vV3k8hqTYx5RW3Ne144DrJv+wbC283WrsghZHKDveVuWX1ysPPuwCEM8xZ
X-Received: by 2002:a05:690c:10:b0:78c:d4ce:4138 with SMTP id 00721157ae682-78e66e670dfmr21156037b3.8.1765559831034;
        Fri, 12 Dec 2025 09:17:11 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78e6a454ad8sm2171307b3.29.2025.12.12.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:17:11 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2A9FF34027F;
	Fri, 12 Dec 2025 10:17:10 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 28B4FE4232B; Fri, 12 Dec 2025 10:17:10 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 9/9] selftests: ublk: add user copy test cases
Date: Fri, 12 Dec 2025 10:17:07 -0700
Message-ID: <20251212171707.1876250-10-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212171707.1876250-1-csander@purestorage.com>
References: <20251212171707.1876250-1-csander@purestorage.com>
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
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


