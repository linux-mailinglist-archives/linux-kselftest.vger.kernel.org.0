Return-Path: <linux-kselftest+bounces-5297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E5885FE15
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 17:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1024828647D
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E6F151CDC;
	Thu, 22 Feb 2024 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ojW/Q3wB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FED1474BA;
	Thu, 22 Feb 2024 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619388; cv=none; b=FcvF/eRZzHfu8STjg9C4+RBJLfPdZ6IpKh5bNYMmoeHtQahnRI0JE3wBD7B3Az9bLU5Yh3nlFkHeVy/XXpbBdlGXTYfl04HZ29uKc/Tg9nkisNB5OuUJMNdqWai5Qd/eDEmAFi0ZHG7afJZiYVC8yZLb5bhKIBvWCBhaTZggx8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619388; c=relaxed/simple;
	bh=XDPa4zEJuUAt2gJOYf0ufxuZ/t7zjS1SdbdV9RQRBKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eEQ3zKDj98+eL0oVJQIgUW4v3a6lv46+7TjKFUNHuXW4Ei1LOr8v+pZ4m/vGqDNnJeyC8z4D3H+K9xIId+XNQ33o2tW0WoPCG5Air7SqE7bfNXzTorzgWlvsHEaqu+EnLstLje6Nc/sq2kTg45BuwyHa9amihLk2oSrRIb6qOy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ojW/Q3wB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708619384;
	bh=XDPa4zEJuUAt2gJOYf0ufxuZ/t7zjS1SdbdV9RQRBKE=;
	h=From:To:Cc:Subject:Date:From;
	b=ojW/Q3wBZe+6AcTn4kNEFGzh4qGJp2fuVg0gVnJ+IlLotYBuHjvjLp4Cyjjr1JYX1
	 FIrFhOAeHTwuync8gLKW7pCiD79kishmeAKpWKUzLITp1DR1du6FhNrgWp433OQRbt
	 bshAIZiTvix2xDJE/3N62w4jvLuzcOCMOEWHa7xrrUdHMgo6S/34fkt6LoH1uarZon
	 TiAT5pT2o/UI5hOp+N//O2NwdZ6Tw2NScPSRpg/anSeTE9lLqQEHRiyXcvMRbU+qyD
	 JZEO1Puq3gnohoMpSoZO5lvooRHHPaNfe5E0COJCqrMnFKQc/wFIhp7dGlSDAGn/2y
	 FeWsJCdH26/wQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 21A9937820D7;
	Thu, 22 Feb 2024 16:29:43 +0000 (UTC)
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
	Sergio Gonzalez Collado <sergio.collado@gmail.com>
Subject: [PATCH v3] kselftest: Add basic test for probing the rust sample modules
Date: Thu, 22 Feb 2024 17:29:13 +0100
Message-Id: <20240222162913.498197-1-laura.nao@collabora.com>
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
Changes in v3:
- Removed useless KSFT_PASS, KSFT_FAIL, KSFT_SKIP constants
- Used ktap_finished to print the results summary and handle the return code
Changes in v2:
- Added missing SPDX line
- Edited test_probe_samples.sh script to use the common KTAP helpers file
---
 MAINTAINERS                                   |  1 +
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/rust/Makefile         |  4 +++
 .../selftests/rust/test_probe_samples.sh      | 34 +++++++++++++++++++
 4 files changed, 40 insertions(+)
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
index 000000000000..389d180f14a5
--- /dev/null
+++ b/tools/testing/selftests/rust/test_probe_samples.sh
@@ -0,0 +1,34 @@
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
+        ktap_test_fail "$sample"
+    fi
+done
+
+ktap_finished
-- 
2.30.2


