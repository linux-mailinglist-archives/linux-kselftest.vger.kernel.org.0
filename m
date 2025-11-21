Return-Path: <linux-kselftest+bounces-46265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D184C7B424
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C20C3A509C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991B4350A3D;
	Fri, 21 Nov 2025 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ytpkJYrM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6373534DB43
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748884; cv=none; b=jPtOWvq/yMQ19XSNZFpb5MXWsSzuWl1NVQ/0fB5fmI9tEbAIwxTVeOLRTbfHP/rzHIKFjfA+5+q1FA/NHK7vZfgnuoNNE6PenJVHP0INoRUV+NBiotCKuv6rSssqBYwrz7JFNseQoLnp8wBO4bkDxm3sjrzO0tyVYYct05qgmM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748884; c=relaxed/simple;
	bh=NBYuw7yy4LKspTLrTBhSD/VELLAr5jASJVtdtt1JJYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EzVONG9G7fV/CUOIQShGab6Zaq+2K5ClAxk/+2it7KBa++iNdkWTnX+SHwJB1oaML7D1Haxr5Lnd3YrD8tK0jDZJlEp3ekbP/18WvdYTzuefCSuv57rzrb3AGKNXP7bYZDrfPEzHJhWloE64SkjcoBkRool7PnTmqSO1RsJFAnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ytpkJYrM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7c240728e2aso5272416b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763748882; x=1764353682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xrsU5YxTbW8Se8AB1hlByyJWpMN5aJSRnLmBAm6hgM=;
        b=ytpkJYrM3LHafma/GdtfzxOcNAhUaZbZ7uwQvs4I2yidWYS8QGwode09QoHExgjCc4
         wyqztLodyyJpjJovJRqJkDsRBpntCIOMQ/18sITOlh6PxmFoMuXUYeec0QPttbH1pzSs
         N2tIsFzMFNp0InjvRbdZQvTgthKkl9RijCptgoXVnqif4D+4TB/9OwIUosFdActW1q5V
         +8w6092RvXiLgDZEQU7DvneWtOSeCwx8WUKZRWLuV8Iz60Ev8aAa1eRdu4Zv9zFiS6eP
         /JFP7DE8MR5e5CHywGQp0bFoPxSUx+WtK3lOccQPHJGGc7UiMXcFd7n2pUuzrP8JKzYb
         rgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748882; x=1764353682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xrsU5YxTbW8Se8AB1hlByyJWpMN5aJSRnLmBAm6hgM=;
        b=osLBuExV1GUYlp8j7I2B5IDlwpVdT0jH+cOaspdqNOeh32pNP5lVhKu/peYuxL9wY+
         12tAPcSVKZm4AbDJStLvZwEThdDK6n7su91FuX2tBEvqcYgBIbu+hoS3elLoLDtUU9ld
         zEq63YxlRigX3S/fIM+75bA99PIKBUqdLXoNE+CMwxQsRn9Ua3spvds7dSjx+hRlgOso
         mWV50O415mmsFJ3JwGWyYLWDg2BztVsmUZ8e32PZBiPcwICxpPqmzn06jQdX+C+P26XV
         tAJhrvZeyTK6IdntPdFIujMgsmt8euekASzdPkXVxonZPVUpvAV41Rxlk4cs0RuJAj+A
         vhrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj6gp0x5DRjzYGed5xPriJ5p4BhNCpYUF4bd+8vIRlgh9Ew5Zv9uJsGh7feOWIOPrnNSaJuTdTtY1ILxvhJZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfcwLE3cEW6HbmjUFHpK5RFj2G0EBRzmjLdmNnfysMYtFNHIv+
	RTJB2kuZB6qMfyuOUWNqUn7GwgcUPIAMyVlSEf+2mRiTuZoW/v1cOmYYZoQN5iXS75ksWfJEENw
	RwoXhoHaz7cOuTg==
X-Google-Smtp-Source: AGHT+IFIX5BeME7Rt9gMBL5YuP6nIaO/M1fvkPVIfZhb8ixuJWg0WSknC2PSsvUktD+1Rnl5nQyi6UGSXC5yfw==
X-Received: from pfbdf10.prod.google.com ([2002:a05:6a00:470a:b0:7a9:ce34:8e4b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1ad2:b0:7a2:7237:79ff with SMTP id d2e1a72fcca58-7c58c4a4fe3mr3572247b3a.7.1763748881662;
 Fri, 21 Nov 2025 10:14:41 -0800 (PST)
Date: Fri, 21 Nov 2025 18:14:13 +0000
In-Reply-To: <20251121181429.1421717-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121181429.1421717-3-dmatlack@google.com>
Subject: [PATCH v3 02/18] vfio: selftests: Split run.sh into separate scripts
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Split run.sh into separate scripts (setup.sh, run.sh, cleanup.sh) to
enable multi-device testing, and prepare for VFIO selftests
automatically detecting which devices to use for testing by storing
device metadata on the filesystem.

 - setup.sh takes one or more BDFs as arguments and sets up each device.
   Metadata about each device is stored on the filesystem in the
   directory:

	   ${TMPDIR:-/tmp}/vfio-selftests-devices

   Within this directory is a directory for each BDF, and then files in
   those directories that cleanup.sh uses to cleanup the device.

 - run.sh runs a selftest by passing it the BDFs of all set up devices.

 - cleanup.sh takes zero or more BDFs as arguments and cleans up each
   device. If no BDFs are provided, it cleans up all devices.

This split enables multi-device testing by allowing multiple BDFs to be
set up and passed into tests:

For example:

  $ tools/testing/selftests/vfio/scripts/setup.sh <BDF1> <BDF2>
  $ tools/testing/selftests/vfio/scripts/setup.sh <BDF3>
  $ tools/testing/selftests/vfio/scripts/run.sh echo
  <BDF1> <BDF2> <BDF3>
  $ tools/testing/selftests/vfio/scripts/cleanup.sh

In the future, VFIO selftests can automatically detect set up devices by
inspecting ${TMPDIR:-/tmp}/vfio-selftests-devices. This will avoid the
need for the run.sh script.

Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   3 +
 .../testing/selftests/vfio/scripts/cleanup.sh |  41 +++++++
 tools/testing/selftests/vfio/scripts/lib.sh   |  42 +++++++
 tools/testing/selftests/vfio/scripts/run.sh   | 105 +-----------------
 tools/testing/selftests/vfio/scripts/setup.sh |  48 ++++++++
 5 files changed, 140 insertions(+), 99 deletions(-)
 create mode 100755 tools/testing/selftests/vfio/scripts/cleanup.sh
 create mode 100755 tools/testing/selftests/vfio/scripts/lib.sh
 create mode 100755 tools/testing/selftests/vfio/scripts/setup.sh

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index ad7fa4071c20..a29f99395206 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -4,7 +4,10 @@ TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_driver_test
 
+TEST_FILES += scripts/cleanup.sh
+TEST_FILES += scripts/lib.sh
 TEST_FILES += scripts/run.sh
+TEST_FILES += scripts/setup.sh
 
 include ../lib.mk
 include lib/libvfio.mk
diff --git a/tools/testing/selftests/vfio/scripts/cleanup.sh b/tools/testing/selftests/vfio/scripts/cleanup.sh
new file mode 100755
index 000000000000..69c922d8aafb
--- /dev/null
+++ b/tools/testing/selftests/vfio/scripts/cleanup.sh
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+source $(dirname -- "${BASH_SOURCE[0]}")/lib.sh
+
+function cleanup_devices() {
+	local device_bdf
+	local device_dir
+
+	for device_bdf in "$@"; do
+		device_dir=${DEVICES_DIR}/${device_bdf}
+
+		if [ -f ${device_dir}/vfio-pci ]; then
+			unbind ${device_bdf} vfio-pci
+		fi
+
+		if [ -f ${device_dir}/driver_override ]; then
+			clear_driver_override ${device_bdf}
+		fi
+
+		if [ -f ${device_dir}/driver ]; then
+			bind ${device_bdf} $(cat ${device_dir}/driver)
+		fi
+
+		if [ -f ${device_dir}/sriov_numvfs ]; then
+			set_sriov_numvfs ${device_bdf} $(cat ${device_dir}/sriov_numvfs)
+		fi
+
+		rm -rf ${device_dir}
+	done
+}
+
+function main() {
+	if [ $# = 0 ]; then
+		cleanup_devices $(ls ${DEVICES_DIR})
+		rmdir ${DEVICES_DIR}
+	else
+		cleanup_devices "$@"
+	fi
+}
+
+main "$@"
diff --git a/tools/testing/selftests/vfio/scripts/lib.sh b/tools/testing/selftests/vfio/scripts/lib.sh
new file mode 100755
index 000000000000..9f05f29c7b86
--- /dev/null
+++ b/tools/testing/selftests/vfio/scripts/lib.sh
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+readonly DEVICES_DIR="${TMPDIR:-/tmp}/vfio-selftests-devices"
+
+function write_to() {
+	# Unfortunately set -x does not show redirects so use echo to manually
+	# tell the user what commands are being run.
+	echo "+ echo \"${2}\" > ${1}"
+	echo "${2}" > ${1}
+}
+
+function get_driver() {
+	if [ -L /sys/bus/pci/devices/${1}/driver ]; then
+		basename $(readlink -m /sys/bus/pci/devices/${1}/driver)
+	fi
+}
+
+function bind() {
+	write_to /sys/bus/pci/drivers/${2}/bind ${1}
+}
+
+function unbind() {
+	write_to /sys/bus/pci/drivers/${2}/unbind ${1}
+}
+
+function set_sriov_numvfs() {
+	write_to /sys/bus/pci/devices/${1}/sriov_numvfs ${2}
+}
+
+function get_sriov_numvfs() {
+	if [ -f /sys/bus/pci/devices/${1}/sriov_numvfs ]; then
+		cat /sys/bus/pci/devices/${1}/sriov_numvfs
+	fi
+}
+
+function set_driver_override() {
+	write_to /sys/bus/pci/devices/${1}/driver_override ${2}
+}
+
+function clear_driver_override() {
+	set_driver_override ${1} ""
+}
diff --git a/tools/testing/selftests/vfio/scripts/run.sh b/tools/testing/selftests/vfio/scripts/run.sh
index 0476b6d7adc3..91fd38f9f6f6 100755
--- a/tools/testing/selftests/vfio/scripts/run.sh
+++ b/tools/testing/selftests/vfio/scripts/run.sh
@@ -1,109 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-# Global variables initialized in main() and then used during cleanup() when
-# the script exits.
-declare DEVICE_BDF
-declare NEW_DRIVER
-declare OLD_DRIVER
-declare OLD_NUMVFS
-declare DRIVER_OVERRIDE
-
-function write_to() {
-	# Unfortunately set -x does not show redirects so use echo to manually
-	# tell the user what commands are being run.
-	echo "+ echo \"${2}\" > ${1}"
-	echo "${2}" > ${1}
-}
-
-function bind() {
-	write_to /sys/bus/pci/drivers/${2}/bind ${1}
-}
-
-function unbind() {
-	write_to /sys/bus/pci/drivers/${2}/unbind ${1}
-}
-
-function set_sriov_numvfs() {
-	write_to /sys/bus/pci/devices/${1}/sriov_numvfs ${2}
-}
-
-function set_driver_override() {
-	write_to /sys/bus/pci/devices/${1}/driver_override ${2}
-}
-
-function clear_driver_override() {
-	set_driver_override ${1} ""
-}
-
-function cleanup() {
-	if [ "${NEW_DRIVER}"      ]; then unbind ${DEVICE_BDF} ${NEW_DRIVER} ; fi
-	if [ "${DRIVER_OVERRIDE}" ]; then clear_driver_override ${DEVICE_BDF} ; fi
-	if [ "${OLD_DRIVER}"      ]; then bind ${DEVICE_BDF} ${OLD_DRIVER} ; fi
-	if [ "${OLD_NUMVFS}"      ]; then set_sriov_numvfs ${DEVICE_BDF} ${OLD_NUMVFS} ; fi
-}
-
-function usage() {
-	echo "usage: $0 [-d segment:bus:device.function] [-s] [-h] [cmd ...]" >&2
-	echo >&2
-	echo "  -d: The BDF of the device to use for the test (required)" >&2
-	echo "  -h: Show this help message" >&2
-	echo "  -s: Drop into a shell rather than running a command" >&2
-	echo >&2
-	echo "   cmd: The command to run and arguments to pass to it." >&2
-	echo "        Required when not using -s. The SBDF will be " >&2
-	echo "        appended to the argument list." >&2
-	exit 1
-}
+source $(dirname -- "${BASH_SOURCE[0]}")/lib.sh
 
 function main() {
-	local shell
-
-	while getopts "d:hs" opt; do
-		case $opt in
-			d) DEVICE_BDF="$OPTARG" ;;
-			s) shell=true ;;
-			*) usage ;;
-		esac
-	done
-
-	# Shift past all optional arguments.
-	shift $((OPTIND - 1))
-
-	# Check that the user passed in the command to run.
-	[ ! "${shell}" ] && [ $# = 0 ] && usage
-
-	# Check that the user passed in a BDF.
-	[ "${DEVICE_BDF}" ] || usage
-
-	trap cleanup EXIT
-	set -e
+	local device_bdfs=$(ls ${DEVICES_DIR})
 
-	test -d /sys/bus/pci/devices/${DEVICE_BDF}
-
-	if [ -f /sys/bus/pci/devices/${DEVICE_BDF}/sriov_numvfs ]; then
-		OLD_NUMVFS=$(cat /sys/bus/pci/devices/${DEVICE_BDF}/sriov_numvfs)
-		set_sriov_numvfs ${DEVICE_BDF} 0
-	fi
-
-	if [ -L /sys/bus/pci/devices/${DEVICE_BDF}/driver ]; then
-		OLD_DRIVER=$(basename $(readlink -m /sys/bus/pci/devices/${DEVICE_BDF}/driver))
-		unbind ${DEVICE_BDF} ${OLD_DRIVER}
+	if [ -z "${device_bdfs}" ]; then
+		echo "No devices found, skipping."
+		exit 4
 	fi
 
-	set_driver_override ${DEVICE_BDF} vfio-pci
-	DRIVER_OVERRIDE=true
-
-	bind ${DEVICE_BDF} vfio-pci
-	NEW_DRIVER=vfio-pci
-
-	echo
-	if [ "${shell}" ]; then
-		echo "Dropping into ${SHELL} with VFIO_SELFTESTS_BDF=${DEVICE_BDF}"
-		VFIO_SELFTESTS_BDF=${DEVICE_BDF} ${SHELL}
-	else
-		"$@" ${DEVICE_BDF}
-	fi
-	echo
+	"$@" ${device_bdfs}
 }
 
 main "$@"
diff --git a/tools/testing/selftests/vfio/scripts/setup.sh b/tools/testing/selftests/vfio/scripts/setup.sh
new file mode 100755
index 000000000000..49a499e51cbe
--- /dev/null
+++ b/tools/testing/selftests/vfio/scripts/setup.sh
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+set -e
+
+source $(dirname -- "${BASH_SOURCE[0]}")/lib.sh
+
+function main() {
+	local device_bdf
+	local device_dir
+	local numvfs
+	local driver
+
+	if [ $# = 0 ]; then
+		echo "usage: $0 segment:bus:device.function ..." >&2
+		exit 1
+	fi
+
+	for device_bdf in "$@"; do
+		test -d /sys/bus/pci/devices/${device_bdf}
+
+		device_dir=${DEVICES_DIR}/${device_bdf}
+		if [ -d "${device_dir}" ]; then
+			echo "${device_bdf} has already been set up, exiting."
+			exit 0
+		fi
+
+		mkdir -p ${device_dir}
+
+		numvfs=$(get_sriov_numvfs ${device_bdf})
+		if [ "${numvfs}" ]; then
+			set_sriov_numvfs ${device_bdf} 0
+			echo ${numvfs} > ${device_dir}/sriov_numvfs
+		fi
+
+		driver=$(get_driver ${device_bdf})
+		if [ "${driver}" ]; then
+			unbind ${device_bdf} ${driver}
+			echo ${driver} > ${device_dir}/driver
+		fi
+
+		set_driver_override ${device_bdf} vfio-pci
+		touch ${device_dir}/driver_override
+
+		bind ${device_bdf} vfio-pci
+		touch ${device_dir}/vfio-pci
+	done
+}
+
+main "$@"
-- 
2.52.0.rc2.455.g230fcf2819-goog


