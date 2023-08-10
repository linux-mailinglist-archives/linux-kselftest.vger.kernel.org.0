Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3F177821A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 22:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjHJUYc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 16:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbjHJUY1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 16:24:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A6C2136;
        Thu, 10 Aug 2023 13:24:26 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D1CB66607237;
        Thu, 10 Aug 2023 21:24:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691699065;
        bh=dbK8sqVnzBOlOzUBAaN2yohYQfmSrnWeR3s6Om57BdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dl20LqSp9vDKF3cb97AHuK0zEtiJ9O00IS3Zg6xIv9eBFSohEAvKfo8cH/B24qeLv
         xrQBmX51L73/y9k5qJ5skKCh5TOxC2uaVN5L6/ylOsNAHl4U42yRIOn6+jsO6T1jOs
         aq0lBwHotXc4kVn+UFA8ZSdV8j1TZpMW93BxaEKu9Qz5uS8DMaWIN0+i+GmhGvWMWo
         sPYRe6xiiES1cq70bFZBgNGIRQPo6QqUNn7ORiWQffyuTlqE0jNAVVoD+QskNrnc4t
         KdYwKwz81JaRTv/VjhFjV0UD9OGDzA1uzBBkwg/vNGZZh2sgH/nv2//4yy881U24ES
         BYFoCOkal2iEg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     cocci@inria.fr, Mark Brown <broonie@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernelci@lists.linux.dev, Julia Lawall <Julia.Lawall@inria.fr>,
        Bjorn Andersson <andersson@kernel.org>, kernel@collabora.com,
        Guenter Roeck <groeck@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 2/2] kselftest: Add Devicetree unprobed devices test
Date:   Thu, 10 Aug 2023 16:23:51 -0400
Message-ID: <20230810202413.1780286-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810202413.1780286-1-nfraprado@collabora.com>
References: <20230810202413.1780286-1-nfraprado@collabora.com>
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
ignored. The first is automatically generated from a script that parses
the kernel source using Coccinelle, and will be run as part of building
this test, therefore Coccinelle is a build-time dependency for this
test. The list of compatibles to ignore is a hand-crafted list to
capture the few exceptions of compatibles that are expected to match a
driver but not be bound to it.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/dt/.gitignore         |  1 +
 tools/testing/selftests/dt/Makefile           | 17 ++++++
 .../selftests/dt/compatible_ignore_list       |  3 +
 .../selftests/dt/test_unprobed_devices.sh     | 58 +++++++++++++++++++
 5 files changed, 80 insertions(+)
 create mode 100644 tools/testing/selftests/dt/.gitignore
 create mode 100644 tools/testing/selftests/dt/Makefile
 create mode 100644 tools/testing/selftests/dt/compatible_ignore_list
 create mode 100755 tools/testing/selftests/dt/test_unprobed_devices.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8dca8acdb671..2fe992ca9294 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -16,6 +16,7 @@ TARGETS += drivers/dma-buf
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
index 000000000000..fa5f3c12a659
--- /dev/null
+++ b/tools/testing/selftests/dt/Makefile
@@ -0,0 +1,17 @@
+COCCI = $(shell which spatch 2>/dev/null)
+
+ifneq ($(COCCI),)
+TEST_PROGS := test_unprobed_devices.sh
+TEST_GEN_FILES := compatible_list
+TEST_FILES := compatible_ignore_list
+
+include ../lib.mk
+
+$(OUTPUT)/compatible_list:
+	cd $(top_srcdir) && ./scripts/dtc/extract-matchable-dt-compatibles > $(OUTPUT)/compatible_list
+
+else
+
+all:
+
+endif
diff --git a/tools/testing/selftests/dt/compatible_ignore_list b/tools/testing/selftests/dt/compatible_ignore_list
new file mode 100644
index 000000000000..5d7fc6229428
--- /dev/null
+++ b/tools/testing/selftests/dt/compatible_ignore_list
@@ -0,0 +1,3 @@
+fixed-factor-clock
+fixed-clock
+simple-mfd
diff --git a/tools/testing/selftests/dt/test_unprobed_devices.sh b/tools/testing/selftests/dt/test_unprobed_devices.sh
new file mode 100755
index 000000000000..4741bedefd1f
--- /dev/null
+++ b/tools/testing/selftests/dt/test_unprobed_devices.sh
@@ -0,0 +1,58 @@
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
+PDT=/proc/device-tree/
+COMPAT_LIST=compatible_list
+IGNORE_LIST=compatible_ignore_list
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
+retval=0
+for node in ${nodes_compatible}; do
+	if ! echo "${nodes_dev_bound}" | grep -E -q "(^| )${node}( |\$)"; then
+		compatibles=$(tr '\000' '\n' < "${PDT}"/"${node}"/compatible)
+
+		for compatible in ${compatibles}; do
+			if grep -x -q "${compatible}" "$IGNORE_LIST"; then
+				echo "DEBUG: Ignoring " "${node}"
+				continue
+			fi
+
+			if grep -x -q "${compatible}" "$COMPAT_LIST"; then
+				echo "BROKEN: " "${node}"
+				retval=1
+				continue 2
+			fi
+		done
+		echo "DEBUG: Skipping " "${node}"
+	fi
+done
+
+exit $retval
-- 
2.41.0

