Return-Path: <linux-kselftest+bounces-5654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D39D786CE73
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 17:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893221F214A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 16:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBB8156985;
	Thu, 29 Feb 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C/CQefgI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E4D155A35;
	Thu, 29 Feb 2024 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222015; cv=none; b=uN9kvY3uFutmkUTSSdMrhsFEh2xeIJPBgsQrjB5jdDJ6m2zMjoJBcoRcr2cEXeWHrJGnOEpwptIXuitKF7F/o3Cmeh5Z9epT2kdJkNsEtuTvrzHBB/SKzkd7cDS1N0/OBIiLz05Q3oLfOQQcqB9xsOfy8RmD80OcuyzfPYrT7aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222015; c=relaxed/simple;
	bh=eH26C+V3gmZDbyoRlGOTopoefFB8XzOGpUJcXpz1tHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L6dr+duPePUumXOAkoY4OFLGytsbXkeLjDBT+DIUQTR9wi+8/9jj0O7v8MRNoo1yhILQ8TwpUbPhKdhe30Dh+xQ/FkDxrGLVEnygdSL+pY+8j6GunQMNixf/tVjebXKEHg+tBXfY1tzkRypxcJDE+mWDpryCSLv29g/QpBIaQds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C/CQefgI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709222011;
	bh=eH26C+V3gmZDbyoRlGOTopoefFB8XzOGpUJcXpz1tHI=;
	h=From:To:Cc:Subject:Date:From;
	b=C/CQefgI3sOJj7jZTQlDP9R9Zlhn0+WOhFtJex+7xwdoprt+MjgC/v28XSGbBrrIs
	 dbObe7Xp6y/0Lo/0mAukWJoPwEA0EmXqihZj3Ptsz9e5AuAaGGHNApxKqWHT4KzYX/
	 T805pO7GpJeCkMpPv9HhFSrHD/IyTPitYTiwMsJxv1x+E1jHcCkva1hBxKNwCTUqQh
	 DvqhFfaa4XJTEYiI+OEi481B4ScKPQ7XtKxXOycz4opVF5LaLGwSz5/mInIAbBHtx1
	 FZm07Bosc0FNKHL6RrSV/P5038XD+Yb0oeU9sBAGmWBRkkYVF0ysuB93sqqZjexHAK
	 p1KRKEwIJmTCw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0375537810EF;
	Thu, 29 Feb 2024 15:53:29 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	shuah@kernel.org
Cc: usama.anjum@collabora.com,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	kernel@valentinobst.de,
	sergio.collado@gmail.com
Subject: [PATCH v5] kselftest: Add basic test for probing the rust sample modules
Date: Thu, 29 Feb 2024 16:52:35 +0100
Message-Id: <20240229155235.263157-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new basic kselftest that checks if the available rust sample modules
can be added and removed correctly.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
Reviewed-by: Sergio Gonzalez Collado <sergio.collado@gmail.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Depends on:
- https://lore.kernel.org/all/20240102141528.169947-1-laura.nao@collabora.com/T/#u
- https://lore.kernel.org/all/20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com/
Changes in v5:
- Skip the test gracefully when ktap helpers file is missing
- Skip the test when the sample modules are missing
Changes in v4:
- Added config file
Changes in v3:
- Removed useless KSFT_PASS, KSFT_FAIL, KSFT_SKIP constants
- Used ktap_finished to print the results summary and handle the return code
Changes in v2:
- Added missing SPDX line
- Edited test_probe_samples.sh script to use the common KTAP helpers file
---
 MAINTAINERS                                   |  1 +
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/rust/Makefile         |  4 ++
 tools/testing/selftests/rust/config           |  5 +++
 .../selftests/rust/test_probe_samples.sh      | 41 +++++++++++++++++++
 5 files changed, 52 insertions(+)
 create mode 100644 tools/testing/selftests/rust/Makefile
 create mode 100644 tools/testing/selftests/rust/config
 create mode 100755 tools/testing/selftests/rust/test_probe_samples.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index e1475ca38ff2..94e31dac6d2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19231,6 +19231,7 @@ F:	Documentation/rust/
 F:	rust/
 F:	samples/rust/
 F:	scripts/*rust*
+F:	tools/testing/selftests/rust/
 K:	\b(?i:rust)\b
 
 RXRPC SOCKETS (AF_RXRPC)
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f7255969b695..e1504833654d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -80,6 +80,7 @@ TARGETS += riscv
 TARGETS += rlimits
 TARGETS += rseq
 TARGETS += rtc
+TARGETS += rust
 TARGETS += seccomp
 TARGETS += sgx
 TARGETS += sigaltstack
diff --git a/tools/testing/selftests/rust/Makefile b/tools/testing/selftests/rust/Makefile
new file mode 100644
index 000000000000..fce1584d3bc0
--- /dev/null
+++ b/tools/testing/selftests/rust/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_PROGS += test_probe_samples.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/rust/config b/tools/testing/selftests/rust/config
new file mode 100644
index 000000000000..b4002acd40bc
--- /dev/null
+++ b/tools/testing/selftests/rust/config
@@ -0,0 +1,5 @@
+CONFIG_RUST=y
+CONFIG_SAMPLES=y
+CONFIG_SAMPLES_RUST=y
+CONFIG_SAMPLE_RUST_MINIMAL=m
+CONFIG_SAMPLE_RUST_PRINT=m
\ No newline at end of file
diff --git a/tools/testing/selftests/rust/test_probe_samples.sh b/tools/testing/selftests/rust/test_probe_samples.sh
new file mode 100755
index 000000000000..ad0397e4986f
--- /dev/null
+++ b/tools/testing/selftests/rust/test_probe_samples.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2023 Collabora Ltd
+#
+# This script tests whether the rust sample modules can
+# be added and removed correctly.
+#
+DIR="$(dirname "$(readlink -f "$0")")"
+
+KTAP_HELPERS="${DIR}/../kselftest/ktap_helpers.sh"
+if [ -e "$KTAP_HELPERS" ]; then
+    source "$KTAP_HELPERS"
+else
+    echo "$KTAP_HELPERS file not found [SKIP]"
+    exit 4
+fi
+
+rust_sample_modules=("rust_minimal" "rust_print")
+
+ktap_print_header
+
+for sample in "${rust_sample_modules[@]}"; do
+    if ! /sbin/modprobe -n -q "$sample"; then
+        ktap_skip_all "module $sample is not found in /lib/modules/$(uname -r)"
+        exit "$KSFT_SKIP"
+    fi
+done
+
+ktap_set_plan "${#rust_sample_modules[@]}"
+
+for sample in "${rust_sample_modules[@]}"; do
+    if /sbin/modprobe -q "$sample"; then
+        /sbin/modprobe -q -r "$sample"
+        ktap_test_pass "$sample"
+    else
+        ktap_test_fail "$sample"
+    fi
+done
+
+ktap_finished
-- 
2.30.2


