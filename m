Return-Path: <linux-kselftest+bounces-47384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE3CCB4BE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 06:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB1D03014613
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 05:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAB728C864;
	Thu, 11 Dec 2025 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AB/w2X0j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AAF2773CC
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765430198; cv=none; b=d+vdmRxdJjZtXPe6WpHJWFd98t0PZNhbG6M4zKpiYOj8OS/JFmZaU/uRkShdxIsljHIWBUZcwfEu9g22wfcvGALiNGZE8OT4uYaMqRH4JUI5+YLu9TEe/SmQE0Hdwiq5DfsVwtFtlvk8wixO0vVWouGM0ATL6ZPzYytUmDn16SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765430198; c=relaxed/simple;
	bh=yqsFqRraCuU6qLjbv6DFoFf1m8GL0qY6w2CbR8yfHSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrNiiMu1cEEh2nI7SKySKKZariziVZPFDCGg2HwDkNnIj+gonv2CfTDEM3zqPrtcLHcmb8CgOj2sr8V4+pU4Lfbg1bHpbruQiD9xSqFlEsZyyMN9zHBN3/0HCxpY28RMqHeJimiNKxcGuyEh0MlEKv0ldtpMmNKNDXr+tjt18AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AB/w2X0j; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-295395ceda3so1021455ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 21:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765430194; x=1766034994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuNOPxZW7Nye7tVoThWbMH6oZw/ivt2VUKr8V6qrvgM=;
        b=AB/w2X0jWnq6nshCAJWwPsYbG8wlev4oqidvQN1DUBaAE0c5Qhpw7IumthyRne4vJ8
         LzUWOZl9IW0Dqi9bP89gnA+5Km/MPySkCDwqJkIJyzUAix1g6Po2yrC/At7twwRa6Ypf
         vVfGg0XBbj9zkDDj9VwNb8HNkSd2heZBjprbKbhLku4KhxJgI+aqmViR1suVT3+wxPqq
         MEiS/+kprxRju8+0yxz2wDGr2MDVRgWbiRG+aV87iQ2QwaAZ/9RGjRG1kFTLxmsrSE0Q
         WgmDlCf81ZJBaKulqqXkRvYmWCsBngIdwiNPxrcRfDQ7GvTvESdu0v++yZGM1RflJIBa
         2Eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765430194; x=1766034994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SuNOPxZW7Nye7tVoThWbMH6oZw/ivt2VUKr8V6qrvgM=;
        b=ab27HaLZhMSK57mRTX03w/3KD1T/Xc7eAaP36wL4g7MOSKUq1i07HlbcfEvNEWKYzi
         zeGifnp0nqwMAj29MdJZM13EhEZpvOh5Lc9bV1SgnXDzkLc3JX9MpBllo/eJJ0j/vISW
         ZKD+ZIW7bE6KviPVk8X0XPmGePqUrBeGYNCXk7cZ3wLqeTi3N7Wc5cKldrWSgOTQyLL0
         GoCyFoLkMx9uLefzY5bVdYYMFbowvGUbdy+mv4bT+SptkiUMz8NHRCfqEtooW2tknAAB
         h2K5o0MutISt7LKpi8Oleaq/N7MZVtnB2iqvs84kxDy4Z2UGUUFLSILSq8ZlLTFSqM6K
         h9Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWn+FSWRYG+1oud5J+dkmqppSzoZH88GPAo6nw4H2OB2GF7i73pKx27nJGAWbWQxcprxlY6oO09tD4jwB8nWV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmYx3qdGemCzesGAlM6q9tt23ohcdbosd3gnrWS0nDzAKjnLYI
	djHTkP5p/H8MEAy1NP3VUsatiCLYE1kdXpHyLtGnq2tElho5BmipoVeUQszeTfGvNS0Vf+lRJvq
	CBgxwqz6eqA4FiBKLwQ/fhSA2oTy69aJWRbeF
X-Gm-Gg: AY/fxX431eZpZPh9FgIPWcBdHyrPB3SebpYlJ0wYn+39PFQgkdWyufKgpUebQgiC8Q2
	pVhhkVphopYKtY53EKJnSrHjzil00TdJLcj+bQInqt+ZH3ggTuO1g1t4HpvCA9YsV8Ko9GgJDtP
	HzlPUbUin9HHeHtYOljxwYfqs+lcwMYj8uxOokY6fRfl2zZ+uZwNhtd7L3ljbe4uAe2Jdkq3h1I
	k8Ncxz9ThwgbRxsboBURPfYnDNydxI9nEcJ5lAJm1yyxcuIvDDmYylh4K8SlCgfKubC4+RCG58g
	GCZGfunq2Sygi7bBgSSboduUP2tc+nSysMjgOjqiRBrW30jvZyZbdew6vY08iwBFRmcDcx1bgdn
	QEbCLWPjRj9mEzUde9YBtXnA7r0da84H/sceluNcVow==
X-Google-Smtp-Source: AGHT+IGBDOAGzJM4hUb5ptKH/Um9Pge2SQjp4QLIFDY2SRLAV9pNQQv6koiJWCoez/1i8X5zR6Xjd0Gs4fe7
X-Received: by 2002:a17:903:3c24:b0:29d:779c:c0cb with SMTP id d9443c01a7336-29eed191802mr9708775ad.2.1765430193618;
        Wed, 10 Dec 2025 21:16:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29ee9dae906sm2047475ad.62.2025.12.10.21.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 21:16:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 13FDC341D2E;
	Wed, 10 Dec 2025 22:16:33 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 111EFE41888; Wed, 10 Dec 2025 22:16:33 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 8/8] selftests: ublk: add user copy test cases
Date: Wed, 10 Dec 2025 22:16:03 -0700
Message-ID: <20251211051603.1154841-9-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251211051603.1154841-1-csander@purestorage.com>
References: <20251211051603.1154841-1-csander@purestorage.com>
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
- Added test cases to stress_05 ("run IO and remove device with recovery
  enabled") for user copy
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
 .../testing/selftests/ublk/test_stress_05.sh  |  7 ++++
 .../testing/selftests/ublk/test_stress_06.sh  | 39 ++++++++++++++++++
 .../testing/selftests/ublk/test_stress_07.sh  | 39 ++++++++++++++++++
 .../testing/selftests/ublk/test_stripe_05.sh  | 26 ++++++++++++
 .../testing/selftests/ublk/test_stripe_06.sh  | 21 ++++++++++
 10 files changed, 250 insertions(+)
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
diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
index 09b94c36f2ba..cb8203957d1d 100755
--- a/tools/testing/selftests/ublk/test_stress_05.sh
+++ b/tools/testing/selftests/ublk/test_stress_05.sh
@@ -78,7 +78,14 @@ if _have_feature "PER_IO_DAEMON"; then
 	ublk_io_and_remove 256M -t loop -q 4 --nthreads 8 --per_io_tasks -r 1 -i "$reissue" "${UBLK_BACKFILES[0]}" &
 	ublk_io_and_remove 8G -t null -q 4 --nthreads 8 --per_io_tasks -r 1 -i "$reissue"  &
 fi
 wait
 
+for reissue in $(seq 0 1); do
+	ublk_io_and_remove 8G -t null -q 4 -u -r 1 -i "$reissue" &
+	ublk_io_and_remove 256M -t loop -q 4 -u -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
+	ublk_io_and_remove 8G -t null -q 4 -u -r 1 -i "$reissue" &
+	wait
+done
+
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
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


