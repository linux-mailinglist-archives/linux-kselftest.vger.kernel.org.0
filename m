Return-Path: <linux-kselftest+bounces-6112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EE28766B3
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 15:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD611F23A5E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926A7208CE;
	Fri,  8 Mar 2024 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wULQIMkC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C15200C1;
	Fri,  8 Mar 2024 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909392; cv=none; b=EiGRPzsCALXav1UuCeL4OrBejYjFcjSmWrBEK6l2aKmcihwZnCgIkx3yKwEcyfLOE3j12J0Km96qW9/3i+kQbzlO2J5nI4dbL+Tbw4UaDRkKzl/oqC+sOAHdsSfwDYvf/gysBni1KDXTJDC8/U6JPkaQF8Z8X07F/0xu9LqRahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909392; c=relaxed/simple;
	bh=WY/qS/ckGhQLvKky6SlRpqOjuzNXZYS0fZnkGAFszI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4J1q1cWoJdEODfchvBfvd7zQzON0r3Xd3zg+KAyvj6jSXwL6+ccDMv/NcIUf9UNz4/pUT16hNOydoHp2GrWl8RR9GCl9kTNKq2Su9tzhW08otvLUcZu2hN0DuoJC2Zg/Iz3HVpzKB8vWY2d8PWPBiVfrSYM/Xln4xOK05XtHJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wULQIMkC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709909389;
	bh=WY/qS/ckGhQLvKky6SlRpqOjuzNXZYS0fZnkGAFszI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wULQIMkCxXx4EE5m3lJFejVUnirWj/2tNP5kGhXXhKYnP2NAe3v/zVr2ixIxRu79m
	 opjUYf4gVvC84wdh1Gz/MImANci1fObGdhWJL8m7UjTVhrgaCCg8Cm+KwEjQFCEdWU
	 JjcNUK7u57x8/TSrsnXHz7DsVxoKk6ajslWyOpBZx8jcEBtmMDXOxAyvECgq2fG2SF
	 V52ppxHKFUcg+kfuDKoArsdU02zJrUPw0GnDapG2qc/4ZJusX4WzJXX0AAs7N4qswp
	 eXu1bWzbJ9aWg6o3ra61WKtlvQht6EcYSc0idHRtMobjRkENC9FNGW0IcpVvnbh1r+
	 0AOHTS4J4W3mQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0599337820F1;
	Fri,  8 Mar 2024 14:49:47 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	shuah@kernel.org
Cc: dan.carpenter@linaro.org,
	broonie@kernel.org,
	groeck@chromium.org,
	kernel@collabora.com,
	kernelci@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	robh+dt@kernel.org,
	saravanak@google.com,
	davidgow@google.com,
	Tim.Bird@sony.com,
	dianders@chromium.org,
	Laura Nao <laura.nao@collabora.com>
Subject: [RFC PATCH v2 2/2] kselftest: Add test to detect unprobed devices on ACPI platforms
Date: Fri,  8 Mar 2024 15:49:33 +0100
Message-Id: <20240308144933.337107-3-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240308144933.337107-1-laura.nao@collabora.com>
References: <20240308144933.337107-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new kselftest that tests whether devices declared in the ACPI
namespace and supported by the kernel are correctly bound
to a driver.

The test traverses the ACPI sysfs tree to get a list of all the devices
defined in the ACPI namespace and verifies whether the physical devices
linked to each ACPI object are bound to a driver.
The test relies on two lists to skip devices not expected to be bound
to a driver:
- List generated by the acpi-extract-ids script: includes the ACPI IDs
  matched by a driver
- Manual list of ignored IDs: includes the ID of devices that may be
  discovered only via the platform firmware and that don't require a
  driver or cannot be represented as platform devices

The test also examines the sysfs attributes of the target device objects
linked by physical_node* to exclude other devices that should not be
bound to a driver. This includes:
- Devices not assigned to any subsystem
- Devices that are linked to other devices
- Class devices
- Specific PCI bridges that do not require a driver

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/acpi/.gitignore       |   1 +
 tools/testing/selftests/acpi/Makefile         |  21 +++
 tools/testing/selftests/acpi/id_ignore_list   |   3 +
 .../selftests/acpi/test_unprobed_devices.sh   | 138 ++++++++++++++++++
 6 files changed, 165 insertions(+)
 create mode 100644 tools/testing/selftests/acpi/.gitignore
 create mode 100644 tools/testing/selftests/acpi/Makefile
 create mode 100644 tools/testing/selftests/acpi/id_ignore_list
 create mode 100755 tools/testing/selftests/acpi/test_unprobed_devices.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 8333ead448c4..1f58949c9e51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -294,6 +294,7 @@ F:	include/linux/fwnode.h
 F:	include/linux/fw_table.h
 F:	lib/fw_table.c
 F:	scripts/acpi/acpi-extract-ids
+F:	tools/testing/selftests/acpi/
 F:	tools/power/acpi/
 
 ACPI APEI
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index e1504833654d..3107301ea4f3 100644
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
index 000000000000..3c520e8a1962
--- /dev/null
+++ b/tools/testing/selftests/acpi/.gitignore
@@ -0,0 +1 @@
+id_list
diff --git a/tools/testing/selftests/acpi/Makefile b/tools/testing/selftests/acpi/Makefile
new file mode 100644
index 000000000000..b80d4fb797ac
--- /dev/null
+++ b/tools/testing/selftests/acpi/Makefile
@@ -0,0 +1,21 @@
+PY3 = $(shell which python3 2>/dev/null)
+
+ifneq ($(PY3),)
+
+TEST_PROGS := test_unprobed_devices.sh
+TEST_GEN_FILES := id_list
+TEST_FILES := id_ignore_list
+
+include ../lib.mk
+
+$(OUTPUT)/id_list:
+	$(top_srcdir)/scripts/acpi/acpi-extract-ids -d $(top_srcdir) > $@
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
diff --git a/tools/testing/selftests/acpi/id_ignore_list b/tools/testing/selftests/acpi/id_ignore_list
new file mode 100644
index 000000000000..86ddf4b0a55a
--- /dev/null
+++ b/tools/testing/selftests/acpi/id_ignore_list
@@ -0,0 +1,3 @@
+PNP0A05
+PNP0A06
+ACPI0004
\ No newline at end of file
diff --git a/tools/testing/selftests/acpi/test_unprobed_devices.sh b/tools/testing/selftests/acpi/test_unprobed_devices.sh
new file mode 100755
index 000000000000..23e52833c475
--- /dev/null
+++ b/tools/testing/selftests/acpi/test_unprobed_devices.sh
@@ -0,0 +1,138 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2023 Collabora Ltd
+#
+# Inspired by the tools/testing/selftests/dt/test_unprobed_devices.sh
+# script, adapted for the ACPI use case.
+#
+# This script checks whether devices declared in the ACPI namespace and
+# supported by the kernel are correctly bound to a driver.
+#
+# To do this, two lists are used:
+# * a list of ACPI IDs matched by existing drivers
+# * a list of IDs that should be ignored
+#
+
+DIR="$(dirname "$(readlink -f "$0")")"
+
+KTAP_HELPERS="${DIR}/../kselftest/ktap_helpers.sh"
+if ! source "$KTAP_HELPERS"; then
+	exit 4
+fi
+
+ACPI_SYSTEM_DIR="/sys/devices/LNXSYSTM:00"
+ID_IGNORE_LIST="${DIR}"/id_ignore_list
+ID_LIST="${DIR}"/id_list
+
+PCI_CLASS_BRIDGE_HOST="0x0600"
+PCI_CLASS_BRIDGE_ISA="0x0601"
+
+ktap_print_header
+
+if [[ ! -d "${ACPI_SYSTEM_DIR}" ]]; then
+	ktap_skip_all "${ACPI_SYSTEM_DIR} doesn't exist."
+	exit "${KSFT_SKIP}"
+fi
+
+# The ACPI specification mandates that ACPI objects representing devices on
+# non-enumerable and enumerable busses contain a _HID or an _ADR
+# identification object respectively. Get a list of devices of both types,
+# by searching the ACPI sysfs subtree for directories containing a hid or
+# adr attribute.
+supp_dev_paths=$(while IFS=$'\n' read -r dev_path; do
+	if [ ! -f "${dev_path}"/hid ] && [ ! -f "${dev_path}"/adr ]; then
+		continue
+	fi
+
+	# Check if the device is present, enabled, and functioning properly
+	status="${dev_path}/status"
+	if [ -f "${status}" ]; then
+		status_hex=$(($(cat "${status}")))
+
+		if [ $((status_hex & 1)) -eq 0 ] ||
+			[ $((status_hex >> 1 & 1)) -eq 0 ] ||
+			[ $((status_hex >> 3 & 1)) -eq 0 ]; then
+			continue
+		fi
+	fi
+
+	if [ -n "$(find -L "${dev_path}" -maxdepth 1 -name "physical_node*" -print -quit)" ]; then
+		for node in "${dev_path}"/physical_node*; do
+			# Ignore devices without a subsystem, devices that link to
+			# other devices, and class devices
+			if [ ! -d "${node}/subsystem" ] ||
+				[ -d "${node}/device" ] ||
+				[[ "$(readlink -f "${node}/subsystem")" == /sys/class/* ]]; then
+				continue
+			fi
+
+			echo "${node}"
+		done
+	fi
+done < <(find ${ACPI_SYSTEM_DIR} -name uevent -exec dirname {} \;))
+
+supp_dev_paths_num=$(echo "${supp_dev_paths}" | wc -w)
+ktap_set_plan "${supp_dev_paths_num}"
+
+# Iterate over ACPI devices
+for dev_path in ${supp_dev_paths}; do
+	if [ -f "${dev_path}/firmware_node/path" ]; then
+		acpi_path="$(<"${dev_path}"/firmware_node/path)"
+	fi
+
+	dev_link=$(readlink -f "${dev_path}")
+	desc="${acpi_path}-${dev_link#/sys/devices/}"
+
+	if [ -f "${dev_path}/firmware_node/hid" ]; then
+		hid="$(<"${dev_path}"/firmware_node/hid)"
+
+		if [ -f "${dev_path}/firmware_node/modalias" ]; then
+			modalias=$(<"${dev_path}/firmware_node/modalias")
+			cid=$(echo "${modalias}" | cut -d':' -f3)
+
+			# Skip devices with ignored HID/CID
+			if ignored_id=$(grep -i "${hid}" "${ID_IGNORE_LIST}" ||
+				{ [ -n "${cid}" ] && grep -i "${cid}" "${ID_IGNORE_LIST}"; }); then
+				ktap_print_msg "ID ${ignored_id} ignored [SKIP]"
+				ktap_test_skip "${desc}"
+				continue
+			fi
+			# Skip devices with unsupported HID/CID
+			if [[ "${hid}" != LNX* ]] && ! grep -x -q -i "${hid}" "${ID_LIST}"; then
+				if [ -z "${cid}" ] || ! grep -x -q -i "${cid}" "${ID_LIST}"; then
+					ktap_print_msg "no match for ${hid}${cid:+:${cid}} found \
+						in the supported IDs list [SKIP]"
+					ktap_test_skip "${desc}"
+					continue
+				fi
+			fi
+		fi
+	fi
+
+	# Skip bridges that don't require a driver
+	if [ -f "${dev_path}/class" ]; then
+		class=$(<"${dev_path}"/class)
+		if [[ ${class} == ${PCI_CLASS_BRIDGE_HOST}* ]] ||
+			[[ ${class} == ${PCI_CLASS_BRIDGE_ISA}* ]]; then
+			ktap_print_msg "device linked to ${desc} does not require a driver [SKIP]"
+			ktap_test_skip "${desc}"
+			continue
+		fi
+	fi
+
+	# Search for the driver in both the device folder and the companion's folder
+	if [ -d "${dev_path}/driver" ] || [ -d "${dev_path}/firmware_node/driver" ]; then
+		ktap_test_pass "${desc}"
+	# Skip char devices
+	elif [ -f "${dev_path}/dev" ]; then
+		ktap_print_msg "${desc} is a char device [SKIP]"
+		ktap_test_skip "${desc}"
+		continue
+	else
+		ktap_test_fail "${desc}"
+	fi
+
+done
+
+ktap_finished
-- 
2.30.2


