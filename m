Return-Path: <linux-kselftest+bounces-674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23397FAE6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 00:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E652816E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 23:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E969049F80;
	Mon, 27 Nov 2023 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n2p++2b+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C5B1B8;
	Mon, 27 Nov 2023 15:36:12 -0800 (PST)
Received: from notapiano.myfiosgateway.com (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id A4CA56607286;
	Mon, 27 Nov 2023 23:36:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701128171;
	bh=uszfqMsRyEw54/XQFNZxt8fdYO5WUerKHy+2zOlCCgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2p++2b+KtXB0WF15oFP3ygUdj8gd69ZgSggXl1cbnsTZZJyY6igjbC+Ujwfr53i7
	 Ufo1jzKmoinwhvsbOPGLkW+3gdhiWSwnfxKh6A/EzNpBYlbfjzNk7B348gYRhbyPz8
	 gW7mGRlLrwsaGjdRILs/m+Y36uEqUNhNGUb7ZgrRUUxt0taN5xIRc53f+jUCZeBliL
	 LjXy9S4OxsR3OZ4SxMO/PNEOi5ughBjb+wWAdIcsnse5WajqbWSBO7+edpq1LmgYzl
	 BjxK5scWjK+CZMgFrRsZ4+ATPWMLZccNBkwoDTqZktQSQUwHHAfLeO0VRM5RIzMwOr
	 ZohhinjpSkCAg==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Saravana Kannan <saravanak@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	kernelci@lists.linux.dev,
	David Gow <davidgow@google.com>,
	Guenter Roeck <groeck@chromium.org>,
	linux-kselftest@vger.kernel.org,
	linux-usb@vger.kernel.org,
	kernel@collabora.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Tim Bird <Tim.Bird@sony.com>,
	linux-pci@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	devicetree@vger.kernel.org,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/2] kselftest: Add test to verify probe of devices from discoverable busses
Date: Mon, 27 Nov 2023 18:34:06 -0500
Message-ID: <20231127233558.868365-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231127233558.868365-1-nfraprado@collabora.com>
References: <20231127233558.868365-1-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new test to verify that a list of expected devices on a given
platform have been successfully probed by a driver.

Add a new test to verify that all expected devices from discoverable
busses (ie USB, PCI) have been successfully instantiated and probed by a
driver.

The per-platform list of expected devices is selected from the ones
under the boards/ directory based on compatible.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

(no changes since v1)

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/devices/.gitignore    |   1 +
 tools/testing/selftests/devices/Makefile      |   8 +
 .../devices/test_discoverable_devices.sh      | 160 ++++++++++++++++++
 4 files changed, 170 insertions(+)
 create mode 100644 tools/testing/selftests/devices/.gitignore
 create mode 100644 tools/testing/selftests/devices/Makefile
 create mode 100755 tools/testing/selftests/devices/test_discoverable_devices.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 3b2061d1c1a5..7f5088006c3c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -13,6 +13,7 @@ TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += damon
+TARGETS += devices
 TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
 TARGETS += drivers/s390x/uvdevice
diff --git a/tools/testing/selftests/devices/.gitignore b/tools/testing/selftests/devices/.gitignore
new file mode 100644
index 000000000000..e3c5c04d1b19
--- /dev/null
+++ b/tools/testing/selftests/devices/.gitignore
@@ -0,0 +1 @@
+ktap_helpers.sh
diff --git a/tools/testing/selftests/devices/Makefile b/tools/testing/selftests/devices/Makefile
new file mode 100644
index 000000000000..ff2fdc8fc5e2
--- /dev/null
+++ b/tools/testing/selftests/devices/Makefile
@@ -0,0 +1,8 @@
+TEST_PROGS := test_discoverable_devices.sh
+TEST_GEN_FILES := ktap_helpers.sh
+TEST_FILES := boards
+
+include ../lib.mk
+
+$(OUTPUT)/ktap_helpers.sh:
+	cp ../dt/ktap_helpers.sh $@
diff --git a/tools/testing/selftests/devices/test_discoverable_devices.sh b/tools/testing/selftests/devices/test_discoverable_devices.sh
new file mode 100755
index 000000000000..82bad5ba7081
--- /dev/null
+++ b/tools/testing/selftests/devices/test_discoverable_devices.sh
@@ -0,0 +1,160 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2023 Collabora Ltd
+#
+# This script tests for presence and driver binding of devices from discoverable
+# busses (ie USB, PCI).
+#
+# The per-platform list of devices to be tested is stored inside the boards/
+# directory and chosen based on compatible. Each line of the file follows the
+# following format:
+#
+#   usb|pci test_name number_of_matches field=value [ field=value ... ]
+#
+# The available match fields vary by bus. The field-value match pairs for a
+# device can be retrieved from the device's modalias attribute in sysfs.
+#
+
+DIR="$(dirname $(readlink -f "$0"))"
+
+source "${DIR}"/ktap_helpers.sh
+
+KSFT_FAIL=1
+KSFT_SKIP=4
+
+retval=0
+
+match()
+{
+	FILE="$1"
+	ID="$2"
+
+	[ ! -f "$FILE" ] && return 1
+	[ "$ID" = "" ] && return 0
+	grep -q "$ID" "$FILE" || return 1
+	return 0
+}
+
+usb()
+{
+	name="$1"
+	count="$2"
+	shift 2
+
+	for arg in $@; do
+		[[ "$arg" =~ ^v= ]] && v="${arg#v=}"
+		[[ "$arg" =~ ^p= ]] && p="${arg#p=}"
+		[[ "$arg" =~ ^d= ]] && d="${arg#d=}"
+		[[ "$arg" =~ ^dc= ]] && dc="${arg#dc=}"
+		[[ "$arg" =~ ^dsc= ]] && dsc="${arg#dsc=}"
+		[[ "$arg" =~ ^dp= ]] && dp="${arg#dp=}"
+		[[ "$arg" =~ ^ic= ]] && ic="${arg#ic=}"
+		[[ "$arg" =~ ^isc= ]] && isc="${arg#isc=}"
+		[[ "$arg" =~ ^ip= ]] && ip="${arg#ip=}"
+		[[ "$arg" =~ ^in= ]] && in="${arg#in=}"
+	done
+
+	cur_count=0
+
+	for dev in $(find /sys/bus/usb/devices -maxdepth 1); do
+		match "$dev"/idVendor "$v" || continue
+		match "$dev"/idProduct "$p" || continue
+		match "$dev"/bcdDevice "$d" || continue
+		match "$dev"/bDeviceClass "$dc" || continue
+		match "$dev"/bDeviceSubClass "$dsc" || continue
+		match "$dev"/bDeviceProtocol "$dp" || continue
+
+		# Matched device. Now search through interfaces
+		for intf in $(find "$dev"/ -maxdepth 1 -type d); do
+			match "$intf"/bInterfaceClass "$ic" || continue
+			match "$intf"/bInterfaceSubClass "$isc" || continue
+			match "$intf"/bInterfaceProtocol "$ip" || continue
+			match "$intf"/bInterfaceNumber "$in" || continue
+
+			# Matched interface. Add to count if it was probed by driver.
+			[ -d "$intf"/driver ] && cur_count=$((cur_count+1))
+		done
+	done
+
+	if [ "$cur_count" -eq "$count" ]; then
+		ktap_test_pass usb."$name"
+	else
+		ktap_test_fail usb."$name"
+		retval="$KSFT_FAIL"
+	fi
+}
+
+pci()
+{
+	name="$1"
+	count="$2"
+	shift 2
+
+	for arg in $@; do
+		[[ "$arg" =~ ^v= ]] && v="${arg#v=}"
+		[[ "$arg" =~ ^d= ]] && d="${arg#d=}"
+		[[ "$arg" =~ ^sv= ]] && sv="${arg#sv=}"
+		[[ "$arg" =~ ^sd= ]] && sd="${arg#sd=}"
+		[[ "$arg" =~ ^bc= ]] && bc="${arg#bc=}"
+		[[ "$arg" =~ ^sc= ]] && sc="${arg#sc=}"
+		[[ "$arg" =~ ^i= ]] && i="${arg#i=}"
+	done
+
+	cur_count=0
+
+	for dev in $(find /sys/bus/pci/devices -maxdepth 1); do
+		match "$dev"/vendor "$v" || continue
+		match "$dev"/device "$d" || continue
+		match "$dev"/subsystem_vendor "$sv" || continue
+		match "$dev"/subsystem_device "$sd" || continue
+
+		[ -z "$bc" ] && bc='..'
+		[ -z "$sc" ] && sc='..'
+		[ -z "$i" ] && i='..'
+		match "$dev/"class "$bc$sc$i" || continue
+
+		# Matched device. Add to count if it was probed by driver.
+		[ -d "$dev"/driver ] && cur_count=$((cur_count+1))
+	done
+
+	if [ "$cur_count" -eq "$count" ]; then
+		ktap_test_pass pci."$name"
+	else
+		ktap_test_fail pci."$name"
+		retval="$KSFT_FAIL"
+	fi
+}
+
+ktap_print_header
+
+plat_compatible=/proc/device-tree/compatible
+
+if [ ! -f "$plat_compatible" ]; then
+	ktap_skip_all "No board compatible available"
+	exit "$KSFT_SKIP"
+fi
+
+compatibles=$(tr '\000' '\n' < "$plat_compatible")
+
+for compatible in $compatibles; do
+	if [ -f boards/"$compatible" ]; then
+		board_file=boards/"$compatible"
+		break
+	fi
+done
+
+if [ -z "$board_file" ]; then
+	ktap_skip_all "No matching board file found"
+	exit "$KSFT_SKIP"
+fi
+
+echo "# Using board file: " "$board_file"
+
+num_tests=$(grep -E "^(usb|pci)" "$board_file" | wc -l)
+ktap_set_plan "$num_tests"
+
+source "$board_file"
+
+ktap_print_totals
+exit "${retval}"
-- 
2.42.1


