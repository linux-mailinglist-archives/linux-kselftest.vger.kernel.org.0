Return-Path: <linux-kselftest+bounces-2025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 356AA81491B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43F01F23689
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA482E622;
	Fri, 15 Dec 2023 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YnPDEDkr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271A12DF9F;
	Fri, 15 Dec 2023 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702646504;
	bh=4G/ylAHrmIAiXwxQVYFSIowpnOIBt/Wfr3j3WfEtRUU=;
	h=From:To:Cc:Subject:Date:From;
	b=YnPDEDkrlJK7uYBS/6sBOX9Sq6M4kPspArbh3gJ1DCzE5snGquYyg8kL2N0wPJTIw
	 fiTSc1auL6Mrn8O2QSBOPSrPMlWxBPf3jPNuJbUHnsdPH5LR5bJkAMKTJj98edmWX9
	 EQqNJ96HR/xd+mS1metDTIAz8ApaO54MSSCWRBUMHLACpKU6Iw9zbEmgX/C2M2uUD6
	 Ka2QLagjNJUVVWlZdvyNKeYZbdyvMuTDpoOCOe+h8LDAWuMSvS3ZfdInZv9Fra5DMT
	 DWv23iNxo1LIz1bliPL+B02uMNNhgwFwrVGJGcpUs6RFo72wEdK1GJ2QEpL+Wta5w7
	 KxPiiRV5qPhPg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1AC1D3781FB2;
	Fri, 15 Dec 2023 13:21:43 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH] kselftest: Add basic test for probing the rust sample modules
Date: Fri, 15 Dec 2023 14:21:32 +0100
Message-Id: <20231215132132.169628-1-laura.nao@collabora.com>
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
---
 MAINTAINERS                                   |  1 +
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/rust/.gitignore       |  1 +
 tools/testing/selftests/rust/Makefile         |  8 ++++
 .../selftests/rust/test_probe_samples.sh      | 42 +++++++++++++++++++
 5 files changed, 53 insertions(+)
 create mode 100644 tools/testing/selftests/rust/.gitignore
 create mode 100644 tools/testing/selftests/rust/Makefile
 create mode 100755 tools/testing/selftests/rust/test_probe_samples.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index e2c6187a3ac8..acf283a5d2c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18847,6 +18847,7 @@ F:	Documentation/rust/
 F:	rust/
 F:	samples/rust/
 F:	scripts/*rust*
+F:	tools/testing/selftests/rust/
 K:	\b(?i:rust)\b
 
 RXRPC SOCKETS (AF_RXRPC)
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 3b2061d1c1a5..26140426c849 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -74,6 +74,7 @@ TARGETS += riscv
 TARGETS += rlimits
 TARGETS += rseq
 TARGETS += rtc
+TARGETS += rust
 TARGETS += seccomp
 TARGETS += sgx
 TARGETS += sigaltstack
diff --git a/tools/testing/selftests/rust/.gitignore b/tools/testing/selftests/rust/.gitignore
new file mode 100644
index 000000000000..e3c5c04d1b19
--- /dev/null
+++ b/tools/testing/selftests/rust/.gitignore
@@ -0,0 +1 @@
+ktap_helpers.sh
diff --git a/tools/testing/selftests/rust/Makefile b/tools/testing/selftests/rust/Makefile
new file mode 100644
index 000000000000..ccaa50f35b5b
--- /dev/null
+++ b/tools/testing/selftests/rust/Makefile
@@ -0,0 +1,8 @@
+
+TEST_PROGS += test_probe_samples.sh
+TEST_GEN_FILES := ktap_helpers.sh
+
+include ../lib.mk
+
+$(OUTPUT)/ktap_helpers.sh:
+	cp $(top_srcdir)/tools/testing/selftests/dt/ktap_helpers.sh $@
diff --git a/tools/testing/selftests/rust/test_probe_samples.sh b/tools/testing/selftests/rust/test_probe_samples.sh
new file mode 100755
index 000000000000..a46550543f73
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
+source "${DIR}"/ktap_helpers.sh
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


