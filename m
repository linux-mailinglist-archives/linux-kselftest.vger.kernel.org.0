Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7277ADC7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 17:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjIYP6V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 11:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjIYP6U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 11:58:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D62083;
        Mon, 25 Sep 2023 08:58:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:b07:646b:e2:e4be:399f:af39:e0db])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: laura.nao)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 40F08660730F;
        Mon, 25 Sep 2023 16:58:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695657490;
        bh=EEqhOcRvF/DQtqCs/NvE/9iYGwFlvA+3yXcKw/uNJ1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LDYOjgxLNbXIw54fenrFdcQCvwvGY7mnYuayj2hL4NMTFxgAC0gU14bcb2bVq3ESh
         765GV5yygLzr2tVcO/TomhaJbO0nLqmnkGPKxstwoNY7kV4hKvnPsTtgheddykarPR
         QTRk8zhDhS9ZUCFn9iXCu+xApzZTRt1NevLLj/0IJLhI8i0EvyfU9YAbsJZB/QlI/P
         +TXRNekYaRl2ED+W80EWI+w8fnmQ79OtzkOszhpEefdPkME5qfBGrzfEK6OERUwmAC
         N1HnFxbqjjIKUghOr1iOv5GuGNEx48lvkAmwcvuUPne82THfucX8yi90Xvp8j6gl0T
         2awAeHU7PJKRA==
From:   Laura Nao <laura.nao@collabora.com>
To:     rafael@kernel.org, lenb@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kselftest@vger.kernel.org, groeck@chromium.org,
        broonie@kernel.org, robh+dt@kernel.org, kernelci@lists.linux.dev,
        kernel@collabora.com, Laura Nao <laura.nao@collabora.com>
Subject: [RFC PATCH 2/2] kselftest: Add test to detect unprobed devices on ACPI platforms
Date:   Mon, 25 Sep 2023 17:58:06 +0200
Message-Id: <20230925155806.1812249-3-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230925155806.1812249-1-laura.nao@collabora.com>
References: <20230925155806.1812249-1-laura.nao@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add new kselftest that tests whether devices declared in the ACPI
namespace and supported by the kernel are correctly bound
to a driver.

The test runs the acpi-extract-ids script to generate a list
of all the ACPI device IDs present in the kernel sources.
The list is then used as a reference to determine which of the
devices declared in the ACPI namespace are supported by the kernel
and therefore expected to bind to a driver.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 MAINTAINERS                                   |  1 +
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/acpi/.gitignore       |  2 +
 tools/testing/selftests/acpi/Makefile         | 23 ++++++
 .../selftests/acpi/test_unprobed_devices.sh   | 75 +++++++++++++++++++
 5 files changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/acpi/.gitignore
 create mode 100644 tools/testing/selftests/acpi/Makefile
 create mode 100755 tools/testing/selftests/acpi/test_unprobed_devices.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 7540316d82f5..5c83b36f26ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -295,6 +295,7 @@ F:	include/acpi/
 F:	include/linux/acpi.h
 F:	include/linux/fwnode.h
 F:	scripts/acpi/acpi-extract-ids
+F:	tools/testing/selftests/acpi/
 F:	tools/power/acpi/
 
 ACPI APEI
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 11aa8a834794..bb95daf9ae91 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+TARGETS += acpi
 TARGETS += alsa
 TARGETS += amd-pstate
 TARGETS += arm64
diff --git a/tools/testing/selftests/acpi/.gitignore b/tools/testing/selftests/acpi/.gitignore
new file mode 100644
index 000000000000..2526540468f4
--- /dev/null
+++ b/tools/testing/selftests/acpi/.gitignore
@@ -0,0 +1,2 @@
+supported_id_list
+ktap_helpers.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/acpi/Makefile b/tools/testing/selftests/acpi/Makefile
new file mode 100644
index 000000000000..806e75f15824
--- /dev/null
+++ b/tools/testing/selftests/acpi/Makefile
@@ -0,0 +1,23 @@
+PY3 = $(shell which python3 2>/dev/null)
+
+ifneq ($(PY3),)
+
+TEST_PROGS := test_unprobed_devices.sh
+TEST_GEN_FILES := supported_id_list ktap_helpers.sh
+
+include ../lib.mk
+
+$(OUTPUT)/supported_id_list:
+	$(top_srcdir)/scripts/acpi/acpi-extract-ids $(top_srcdir) > $@
+
+$(OUTPUT)/ktap_helpers.sh:
+	cp $(top_srcdir)/tools/testing/selftests/dt/ktap_helpers.sh $@
+
+else
+
+all: no_py3_warning
+
+no_py3_warning:
+	@echo "Missing python3. This test will be skipped."
+
+endif
\ No newline at end of file
diff --git a/tools/testing/selftests/acpi/test_unprobed_devices.sh b/tools/testing/selftests/acpi/test_unprobed_devices.sh
new file mode 100755
index 000000000000..aa8c62166b4d
--- /dev/null
+++ b/tools/testing/selftests/acpi/test_unprobed_devices.sh
@@ -0,0 +1,75 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2023 Collabora Ltd
+#
+# Inspired by the tools/testing/selftests/dt/test_unprobed_devices.sh
+# script, adapted for the ACPI use case.
+#
+# This script checks whether devices declared in the ACPI namespace
+# and supported by the kernel are correctly bound to a driver.
+#
+# A list of all the ACPI device IDs present in the kernel sources
+# is used as reference to determine which of the devices declared
+# in the ACPI tables are supported.
+#
+
+DIR="$(dirname "$(readlink -f "$0")")"
+
+source "${DIR}"/ktap_helpers.sh
+
+ACPI_SYSTEM_DIR="/sys/devices/LNXSYSTM:00"
+SUPPORTED_ID_LIST="${DIR}"/supported_id_list
+
+KSFT_PASS=0
+KSFT_FAIL=1
+KSFT_SKIP=4
+
+ktap_print_header
+
+if [[ ! -d "${ACPI_SYSTEM_DIR}" ]]; then
+	ktap_skip_all "${ACPI_SYSTEM_DIR} doesn't exist."
+	exit "${KSFT_SKIP}"
+fi
+
+# The ACPI specification mandates that ACPI objects representing devices on
+# non-enumerable and enumerable busses contain a _HID or an _ADR identification
+# object respectively.
+# Get a list of devices of both types, by searching the ACPI sysfs subtree for
+# directories containing a hid or adr attribute.
+supp_dev_paths=$(while IFS=$'\n' read -r dev_path; do
+	if [ ! -f "${dev_path}"/hid ] && [ ! -f "${dev_path}"/adr ]; then
+		continue
+	fi
+
+	if [ -f "${dev_path}"/hid ]; then
+		if ! grep -x -q -i "$(cat "${dev_path}"/hid)" "${SUPPORTED_ID_LIST}"; then
+			continue
+		fi
+	fi
+
+	echo "${dev_path}"
+done < <(find ${ACPI_SYSTEM_DIR} -name uevent -exec dirname {} \;))
+
+supp_dev_paths_num=$(echo "${supp_dev_paths}" | wc -w)
+ktap_set_plan "${supp_dev_paths_num}"
+
+ret="${KSFT_PASS}"
+for dev_path in ${supp_dev_paths}; do
+	desc="$(cat "${dev_path}"/path)"
+	[ -f "${dev_path}"/hid ] && desc+=" $(cat "${dev_path}"/hid)"
+
+	# ACPI device objects might be linked to other objects in the device
+	# hierarchy (e.g. devices on the PCI bus).
+	# In these cases, the driver folder will be in the companion object's sysfs
+	# directory, linked by physical_node.
+	if [ -d "${dev_path}"/physical_node/driver ] || [ -d "${dev_path}"/driver ]; then
+		ktap_test_pass "${desc}"
+	else
+		ret="${KSFT_FAIL}"
+		ktap_test_fail "${desc}"
+	fi
+done
+
+ktap_print_totals
+exit "${ret}"
-- 
2.30.2

