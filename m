Return-Path: <linux-kselftest+bounces-35524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD623AE2663
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E656A1898FB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B814256C76;
	Fri, 20 Jun 2025 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YyS7Ua1A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67727256C9C
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461709; cv=none; b=hp1+XPtuaTW0S1uPstvlZqvZNGqqo81lrHQF8iBLuLUB8+iHhti2rBnETYWSDkZcJnTpEp+ssfaXSfEUfDviATfkc09hWTmCo4swjyKOXLXONBGoGenzEhTOc0hLY8HsuI09mOJENymL6t1pVmcbKEaF19hINhQSSny9iXLC0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461709; c=relaxed/simple;
	bh=K7kbKR9fUIwFnENUMqMU2vZmWcLlp4D0v7vSrVcWIiQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cuk5XLn8CZqWcRpOI6zNGzyOvDJg6WIBHoWrJriZytT/SAirCwTQMzy7H98vC3VvtR1nXDuwGTdsvGTO/TUmxdZAEl1/bxzppInmPKnMI7O//l5pQ0WiXoHUChtK5g61Jir8tyUAFPlcNQ2mW18TTjF3nYxZ0p6I7FbiXF+m7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YyS7Ua1A; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31220ecc586so2142700a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461708; x=1751066508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RSiQGPS9Xn4YswkvAOpbEg4WRbb4hskNlQSbFhd3qcs=;
        b=YyS7Ua1A3yFoiARM8KaslPLTXagdFgCbuoFfZBNXZkPgYwDjujSpDwrv5bDd7913+L
         hzVjuuSgUJJWnqjJMnAudRA/Rq1cGUN3MQTo4LwTLYa2K0+z7sVcMpHOC9qpVsefgdqv
         Czr4sBue8reGapv+7+8sXIpNyMuK8uvRGkd72wswpFixIm9lJrVce+wGAQMGaCVwGtnN
         jFmKBzJalHhm+ehWEomTNkaKi2RcKJoi+v8nh+nKg8snOmZ8UeqzP23NrVzILg4f8yvl
         q3u5rVYR9K8QTuzMdgCWkqlbu3bX1stFRAnp0H17ZDFA9APq/6f2piv94m44sSuQayMu
         hnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461708; x=1751066508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSiQGPS9Xn4YswkvAOpbEg4WRbb4hskNlQSbFhd3qcs=;
        b=xTgv/XGsd3p4Vc5rXPxLOYhZlQiTBz1C+o3Xp3/giaBaTycFJlyEAnMvL7uEl3CYvA
         TdM11y6hqLNeKF62e3/BHGUy0S+PfCuN6NQ7kIYkzamT/7lLmE1faKpxsPhdwE5Hi3tJ
         W+HS2bPBXc7Z1FnwlCheQ5Vi+N5HEnUbpKOXVc9keu9eTxfJ1NvlR5I7euXfWnYqwZEO
         HjaIFu695le1gdZ03G8mUXl4plIfDauekNQ1tK3jrWtzbkFLveLFkZpH7DYMsrom2i9Q
         VFPSk+ORTjtoaIm++Ch1HnZdvk/Ktm1wHRy3l4Ag0GgoA4I+/lHr/kvZl2wGFdZwV6al
         QHcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0BEvi36pK4JRirNnd/6VvE91vQ+g0vuz1D7dVnEbU8/HA3Sjtiv1EPHskqL/l11mcX68lLcVW7nXzadvzflI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdhp+vXzJwjMm/4mI69ruPVo/at7dgLsULTUku99/tvbc+QnHF
	L7Vr5KrTsvR1irMZ5HjDLA2/OvcXld9dFO1tpWkKtOzw3ntALtEA1njgpW7qQIte/H67+ZBQiwi
	iKc/yZhtK8NxKwg==
X-Google-Smtp-Source: AGHT+IE/ka3t2Q1ehYkQd6rvfjXJk/WmPWxUuZ9alfMYV42/oeKpNboRPRnM/KTjdhbNO90BAJK25hfq83uyRA==
X-Received: from pjbpx16.prod.google.com ([2002:a17:90b:2710:b0:312:dd5:aa09])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7c6:b0:313:27cc:69cd with SMTP id 98e67ed59e1d1-3159d648873mr8922373a91.12.1750461707916;
 Fri, 20 Jun 2025 16:21:47 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:28 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-31-dmatlack@google.com>
Subject: [PATCH 30/33] vfio: selftests: Add a script to help with running VFIO selftests
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Introduce run.sh, a script to help with running VFIO selftests. The
script is intended to be used for both humans manually running VFIO
selftests, and to incorporate into test automation where VFIO selftests
may run alongside other tests. As such the script aims to be hermetic,
returning the system to the state it was before the test started.

The script takes as input the BDF of a device to use and a command to
run (typically the command would be a VFIO selftest). e.g.

  $ ./run.sh -d 0000:6a:01.0 ./vfio_pci_device_test

 or

  $ ./run.sh -d 0000:6a:01.0 -- ./vfio_pci_device_test

The script then handles unbinding device 0000:6a:01.0 from its current
driver, binding it to vfio-pci, running the test, unbinding from
vfio-pci, and binding back to the original driver.

When run.sh runs the provided test, it does so by appending the BDF as
the last parameter. For example:

  $ ./run.sh -d 0000:6a:01.0 -- echo hello

Results in the following being printed to stdout:

  hello 0000:6a:01.0

The script also supports a mode where it can break out into a shell so
that multiple tests can be run manually.

  $ ./run.sh -d 0000:6a:01.0 -s
  $ echo $VFIO_SELFTESTS_BDF
  $ ./vfio_pci_device_test
  $ exit

Choosing which device to use is up to the user.

In the future this script should be extensible to tests that want to use
multiple devices. The script can support accepting -d BDF multiple times
and parse them into an array, setup all the devices, pass the list of
BDFs to the test, and then cleanup all the devices.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile |   1 +
 tools/testing/selftests/vfio/run.sh   | 109 ++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100755 tools/testing/selftests/vfio/run.sh

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index ee09c027ade5..324ba0175a33 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -3,6 +3,7 @@ TEST_GEN_PROGS += vfio_dma_mapping_test
 TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_driver_test
+TEST_PROGS_EXTENDED := run.sh
 include ../lib.mk
 include lib/libvfio.mk
 
diff --git a/tools/testing/selftests/vfio/run.sh b/tools/testing/selftests/vfio/run.sh
new file mode 100755
index 000000000000..0476b6d7adc3
--- /dev/null
+++ b/tools/testing/selftests/vfio/run.sh
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# Global variables initialized in main() and then used during cleanup() when
+# the script exits.
+declare DEVICE_BDF
+declare NEW_DRIVER
+declare OLD_DRIVER
+declare OLD_NUMVFS
+declare DRIVER_OVERRIDE
+
+function write_to() {
+	# Unfortunately set -x does not show redirects so use echo to manually
+	# tell the user what commands are being run.
+	echo "+ echo \"${2}\" > ${1}"
+	echo "${2}" > ${1}
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
+function set_driver_override() {
+	write_to /sys/bus/pci/devices/${1}/driver_override ${2}
+}
+
+function clear_driver_override() {
+	set_driver_override ${1} ""
+}
+
+function cleanup() {
+	if [ "${NEW_DRIVER}"      ]; then unbind ${DEVICE_BDF} ${NEW_DRIVER} ; fi
+	if [ "${DRIVER_OVERRIDE}" ]; then clear_driver_override ${DEVICE_BDF} ; fi
+	if [ "${OLD_DRIVER}"      ]; then bind ${DEVICE_BDF} ${OLD_DRIVER} ; fi
+	if [ "${OLD_NUMVFS}"      ]; then set_sriov_numvfs ${DEVICE_BDF} ${OLD_NUMVFS} ; fi
+}
+
+function usage() {
+	echo "usage: $0 [-d segment:bus:device.function] [-s] [-h] [cmd ...]" >&2
+	echo >&2
+	echo "  -d: The BDF of the device to use for the test (required)" >&2
+	echo "  -h: Show this help message" >&2
+	echo "  -s: Drop into a shell rather than running a command" >&2
+	echo >&2
+	echo "   cmd: The command to run and arguments to pass to it." >&2
+	echo "        Required when not using -s. The SBDF will be " >&2
+	echo "        appended to the argument list." >&2
+	exit 1
+}
+
+function main() {
+	local shell
+
+	while getopts "d:hs" opt; do
+		case $opt in
+			d) DEVICE_BDF="$OPTARG" ;;
+			s) shell=true ;;
+			*) usage ;;
+		esac
+	done
+
+	# Shift past all optional arguments.
+	shift $((OPTIND - 1))
+
+	# Check that the user passed in the command to run.
+	[ ! "${shell}" ] && [ $# = 0 ] && usage
+
+	# Check that the user passed in a BDF.
+	[ "${DEVICE_BDF}" ] || usage
+
+	trap cleanup EXIT
+	set -e
+
+	test -d /sys/bus/pci/devices/${DEVICE_BDF}
+
+	if [ -f /sys/bus/pci/devices/${DEVICE_BDF}/sriov_numvfs ]; then
+		OLD_NUMVFS=$(cat /sys/bus/pci/devices/${DEVICE_BDF}/sriov_numvfs)
+		set_sriov_numvfs ${DEVICE_BDF} 0
+	fi
+
+	if [ -L /sys/bus/pci/devices/${DEVICE_BDF}/driver ]; then
+		OLD_DRIVER=$(basename $(readlink -m /sys/bus/pci/devices/${DEVICE_BDF}/driver))
+		unbind ${DEVICE_BDF} ${OLD_DRIVER}
+	fi
+
+	set_driver_override ${DEVICE_BDF} vfio-pci
+	DRIVER_OVERRIDE=true
+
+	bind ${DEVICE_BDF} vfio-pci
+	NEW_DRIVER=vfio-pci
+
+	echo
+	if [ "${shell}" ]; then
+		echo "Dropping into ${SHELL} with VFIO_SELFTESTS_BDF=${DEVICE_BDF}"
+		VFIO_SELFTESTS_BDF=${DEVICE_BDF} ${SHELL}
+	else
+		"$@" ${DEVICE_BDF}
+	fi
+	echo
+}
+
+main "$@"
-- 
2.50.0.rc2.701.gf1e915cc24-goog


