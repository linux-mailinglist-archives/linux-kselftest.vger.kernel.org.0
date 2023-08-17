Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BDF7801B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 01:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356110AbjHQXgw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 19:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356194AbjHQXgv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 19:36:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFD330D6;
        Thu, 17 Aug 2023 16:36:49 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1895E6606F65;
        Fri, 18 Aug 2023 00:36:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692315408;
        bh=bJX979j7kxO5Jm5jmek5RyQM0H5/ySZgeQ9XD18Us7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jE7P4rrg2ElpbasKSToQsaxSvebmJQr8l1O4cg/XTUncAzVW7I89O7uUNyf/230aE
         +fuaMbM2AMKBQb5/VPk5z3gNW70rMY3NVhHQwQL1vp8CyjnodlT/x+uS39K29g8sx1
         ZimlKKPcamU5Ywqxgu83qEhiXEo8NLTko6+MRs/kyE2/BmohW9RFc+tgt8NktOjHaD
         jNkWEZN2Bsl7Wubtzzocd8pmi/UZ8QSGh86fepVViVJIalooFNboF/KEEy9Pa19ydG
         SPa32MkOe6x/XmV5u9W/hxyDURDh9tfMHIxHNUNbVTWTo4I2PZ5t6G/2HgJWrPnpXc
         c2TetPwmXQTyA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, kernelci@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Bjorn Andersson <andersson@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/3] kselftest: Add new test for detecting unprobed Devicetree devices
Date:   Thu, 17 Aug 2023 19:35:27 -0400
Message-ID: <20230817233635.2306377-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817233635.2306377-1-nfraprado@collabora.com>
References: <20230817233635.2306377-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce a new kselftest to detect devices that were declared in the
Devicetree, and are expected to be probed by a driver, but weren't.

The test uses two lists: a list of compatibles that can match a
Devicetree device to a driver, and a list of compatibles that should be
ignored. The first is automatically generated by the
dt-extract-compatibles script, and is run as part of building this test.
The list of compatibles to ignore is a hand-crafted list to capture the
few exceptions of compatibles that are expected to match a driver but
not be bound to it.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Switched output to be in KTAP format
- Changed Makefile to make use of the dt-extract-compatibles instead of
  the Coccinelle script
- Dropped compatibles from compatible_ignore_list that are now already
  filtered out by extraction script
- Added early exit if /proc/device-tree is not present

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/dt/.gitignore         |  1 +
 tools/testing/selftests/dt/Makefile           | 21 +++++
 .../selftests/dt/compatible_ignore_list       |  1 +
 tools/testing/selftests/dt/ktap_helpers.sh    | 57 +++++++++++++
 .../selftests/dt/test_unprobed_devices.sh     | 79 +++++++++++++++++++
 6 files changed, 160 insertions(+)
 create mode 100644 tools/testing/selftests/dt/.gitignore
 create mode 100644 tools/testing/selftests/dt/Makefile
 create mode 100644 tools/testing/selftests/dt/compatible_ignore_list
 create mode 100644 tools/testing/selftests/dt/ktap_helpers.sh
 create mode 100755 tools/testing/selftests/dt/test_unprobed_devices.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 42806add0114..e8823097698c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -18,6 +18,7 @@ TARGETS += drivers/dma-buf
 TARGETS += drivers/s390x/uvdevice
 TARGETS += drivers/net/bonding
 TARGETS += drivers/net/team
+TARGETS += dt
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += fchmodat2
diff --git a/tools/testing/selftests/dt/.gitignore b/tools/testing/selftests/dt/.gitignore
new file mode 100644
index 000000000000..f6476c9f2884
--- /dev/null
+++ b/tools/testing/selftests/dt/.gitignore
@@ -0,0 +1 @@
+compatible_list
diff --git a/tools/testing/selftests/dt/Makefile b/tools/testing/selftests/dt/Makefile
new file mode 100644
index 000000000000..62dc00ee4978
--- /dev/null
+++ b/tools/testing/selftests/dt/Makefile
@@ -0,0 +1,21 @@
+PY3 = $(shell which python3 2>/dev/null)
+
+ifneq ($(PY3),)
+
+TEST_PROGS := test_unprobed_devices.sh
+TEST_GEN_FILES := compatible_list
+TEST_FILES := compatible_ignore_list ktap_helpers.sh
+
+include ../lib.mk
+
+$(OUTPUT)/compatible_list:
+	$(top_srcdir)/scripts/dtc/dt-extract-compatibles -d $(top_srcdir) > $@
+
+else
+
+all: no_py3_warning
+
+no_py3_warning:
+	@echo "Missing python3. This test will be skipped."
+
+endif
diff --git a/tools/testing/selftests/dt/compatible_ignore_list b/tools/testing/selftests/dt/compatible_ignore_list
new file mode 100644
index 000000000000..1323903feca9
--- /dev/null
+++ b/tools/testing/selftests/dt/compatible_ignore_list
@@ -0,0 +1 @@
+simple-mfd
diff --git a/tools/testing/selftests/dt/ktap_helpers.sh b/tools/testing/selftests/dt/ktap_helpers.sh
new file mode 100644
index 000000000000..27e89a31e602
--- /dev/null
+++ b/tools/testing/selftests/dt/ktap_helpers.sh
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2023 Collabora Ltd
+#
+# Helpers for outputting in KTAP format
+#
+KTAP_TESTNO=1
+
+ktap_print_header() {
+	echo "TAP version 13"
+}
+
+ktap_set_plan() {
+	num_tests="$1"
+
+	echo "1..$num_tests"
+}
+
+ktap_skip_all() {
+	echo -n "1..0 # SKIP "
+	echo $@
+}
+
+__ktap_test() {
+	result="$1"
+	description="$2"
+	directive="$3" # optional
+
+	local directive_str=
+	[[ ! -z "$directive" ]] && directive_str="# $directive"
+
+	echo $result $KTAP_TESTNO $description $directive_str
+
+	KTAP_TESTNO=$((KTAP_TESTNO+1))
+}
+
+ktap_test_pass() {
+	description="$1"
+
+	result="ok"
+	__ktap_test "$result" "$description"
+}
+
+ktap_test_skip() {
+	description="$1"
+
+	result="ok"
+	directive="SKIP"
+	__ktap_test "$result" "$description" "$directive"
+}
+
+ktap_test_fail() {
+	description="$1"
+
+	result="not ok"
+	__ktap_test "$result" "$description"
+}
diff --git a/tools/testing/selftests/dt/test_unprobed_devices.sh b/tools/testing/selftests/dt/test_unprobed_devices.sh
new file mode 100755
index 000000000000..b523767cdbfb
--- /dev/null
+++ b/tools/testing/selftests/dt/test_unprobed_devices.sh
@@ -0,0 +1,79 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2023 Collabora Ltd
+#
+# Based on Frank Rowand's dt_stat script.
+#
+# This script tests for devices that were declared on the Devicetree and are
+# expected to bind to a driver, but didn't.
+#
+# To achieve this, two lists are used:
+# * a list of the compatibles that can be matched by a Devicetree node
+# * a list of compatibles that should be ignored
+#
+
+DIR="$(dirname $(readlink -f "$0"))"
+
+source "${DIR}"/ktap_helpers.sh
+
+PDT=/proc/device-tree/
+COMPAT_LIST="${DIR}"/compatible_list
+IGNORE_LIST="${DIR}"/compatible_ignore_list
+
+KSFT_PASS=0
+KSFT_FAIL=1
+KSFT_SKIP=4
+
+ktap_print_header
+
+if [[ ! -d "${PDT}" ]]; then
+	ktap_skip_all "${PDT} doesn't exist."
+	exit "${KSFT_SKIP}"
+fi
+
+nodes_compatible=$(
+	for node_compat in $(find ${PDT} -name compatible); do
+		node=$(dirname "${node_compat}")
+		# Check if node is available
+		[[ -e "${node}"/status && $(tr -d '\000' < "${node}"/status) != "okay" ]] && continue
+		echo "${node}" | sed -e 's|\/proc\/device-tree||'
+	done | sort
+	)
+
+nodes_dev_bound=$(
+	IFS=$'\n'
+	for uevent in $(find /sys/devices -name uevent); do
+		if [[ -d "$(dirname "${uevent}")"/driver ]]; then
+			grep '^OF_FULLNAME=' "${uevent}" | sed -e 's|OF_FULLNAME=||'
+		fi
+	done
+	)
+
+num_tests=$(echo ${nodes_compatible} | wc -w)
+ktap_set_plan "${num_tests}"
+
+retval="${KSFT_PASS}"
+for node in ${nodes_compatible}; do
+	if ! echo "${nodes_dev_bound}" | grep -E -q "(^| )${node}( |\$)"; then
+		compatibles=$(tr '\000' '\n' < "${PDT}"/"${node}"/compatible)
+
+		for compatible in ${compatibles}; do
+			if grep -x -q "${compatible}" "${IGNORE_LIST}"; then
+				continue
+			fi
+
+			if grep -x -q "${compatible}" "${COMPAT_LIST}"; then
+				ktap_test_fail "${node}"
+				retval="${KSFT_FAIL}"
+				continue 2
+			fi
+		done
+		ktap_test_skip "${node}"
+	else
+		ktap_test_pass "${node}"
+	fi
+
+done
+
+exit "${retval}"
-- 
2.41.0

