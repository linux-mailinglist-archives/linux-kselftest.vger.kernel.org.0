Return-Path: <linux-kselftest+bounces-5291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD9085FBE5
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 16:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B6E1C225C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 15:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29C3148FFF;
	Thu, 22 Feb 2024 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iwxjdq+w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC991474C2;
	Thu, 22 Feb 2024 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614645; cv=none; b=S9lyq2AsUCx3a5ri+CJ2zmTJ7oLH0VSHTMvPdQoYb18HQHOtApfXNDpcIL0aUCTFQqtO1i2aURNopt39mrQZxxuJIJRBoLsLjiSAp10mzyBjdErQxM9nSAl0yrHewHOR/N8M//TbL6PU14yd8gtTWidz3tmD6/PRLxSdsY/gWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614645; c=relaxed/simple;
	bh=7Wt2UToczihewYYVHGzb+LT1rEJylSZasxhmqlYMo1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aOh6awgEUoYbK1NFLerBRgKHheLiV6tmZXjjWj7s902MP16up6lplhlFzteENJDtOpS+UAjnhSPSAuguUt+KPJGmx7zWDe502lgXvZTq8nl/A88u5Uq/SoGIzyul9opIr5VqQliijwyUC3G+POhxONiltYxq4vKlSHDs7v0CN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iwxjdq+w; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708614641;
	bh=7Wt2UToczihewYYVHGzb+LT1rEJylSZasxhmqlYMo1I=;
	h=From:To:Cc:Subject:Date:From;
	b=iwxjdq+wHLTj6JK+b7v8AhdO4O5LyEMvW0za0cYyocNPBC5fRic+lY0wYF4z4DS2o
	 2PJoXhVMb4E0PQv7278fFRoZTT/c7328+mibPhzuD8lNyWtn8LoBOHbPPtCHcIqzJ5
	 rvpmq9ik7KqasSlvVgt9pkvvk+YNBF4T/d4D9YHdEKNTxGnzG1jCdbEGlJQe01mxdx
	 gGtil0Pnyeq1ZoxFHZOgOcJF7rx0i+34320X4AWKpNic2WC+os9FYsFPOuYY5m1zYI
	 va5t9ygDE+wU/oQ14wiXohGVxDc54jmTgAeyzD+xmKuroaviNl8QTK4p1AzSwlb+zg
	 vKsVqS1hB/OCw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C5CF637820D4;
	Thu, 22 Feb 2024 15:10:40 +0000 (UTC)
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
	Sergio Gonzalez Collado <sergio.collado@gmail.com>
Subject: [PATCH v2] kselftest: Add basic test for probing the rust sample modules
Date: Thu, 22 Feb 2024 16:10:09 +0100
Message-Id: <20240222151009.461264-1-laura.nao@collabora.com>
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
Changes in v2:
- Added missing SPDX line
- Edited test_probe_samples.sh script to use the common KTAP helpers file
---
 MAINTAINERS                                   |  1 +
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/rust/Makefile         |  4 ++
 .../selftests/rust/test_probe_samples.sh      | 42 +++++++++++++++++++
 4 files changed, 48 insertions(+)
 create mode 100644 tools/testing/selftests/rust/Makefile
 create mode 100755 tools/testing/selftests/rust/test_probe_samples.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index c1a18af3593a..5f62904c80bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19207,6 +19207,7 @@ F:	Documentation/rust/
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
diff --git a/tools/testing/selftests/rust/test_probe_samples.sh b/tools/testing/selftests/rust/test_probe_samples.sh
new file mode 100755
index 000000000000..6fcc2cd83d89
--- /dev/null
+++ b/tools/testing/selftests/rust/test_probe_samples.sh
@@ -0,0 +1,42 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2023 Collabora Ltd
+#
+# This script tests whether the rust sample modules can
+# be added and removed correctly.
+#
+
+DIR="$(dirname "$(readlink -f "$0")")"
+
+source "${DIR}"/../kselftest/ktap_helpers.sh
+
+rust_sample_modules=("rust_minimal" "rust_print")
+
+KSFT_PASS=0
+KSFT_FAIL=1
+KSFT_SKIP=4
+
+ret="${KSFT_PASS}"
+
+ktap_print_header
+
+ktap_set_plan "${#rust_sample_modules[@]}"
+
+for sample in "${rust_sample_modules[@]}"; do
+    if ! /sbin/modprobe -n -q "$sample"; then
+        ktap_test_skip "module $sample is not found in /lib/modules/$(uname -r)"
+        continue
+    fi
+
+    if /sbin/modprobe -q "$sample"; then
+        /sbin/modprobe -q -r "$sample"
+        ktap_test_pass "$sample"
+    else
+        ret="${KSFT_FAIL}"
+        ktap_test_fail "$sample"
+    fi
+done
+
+ktap_print_totals
+exit "${ret}"
-- 
2.30.2


