Return-Path: <linux-kselftest+bounces-33728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D15E9AC2C5F
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE397BBEB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16C022F16E;
	Fri, 23 May 2025 23:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u660tKJH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C671D229B38
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043077; cv=none; b=erpTwfnTDxY/vJo1vV09h72CZZT9+xPbymLO1alxRAXRqAK6Uo7DfbN2fWLk+8HahbN3sHJC+MyMAJFVOfy6moi0GUBqcd6VlcKXIESsXkinbrDJOpGSmnVCrV4NlpiyRJrR/c5ybjce0oZOR12Ub7JJwrLNXgHfJm2+1lahqBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043077; c=relaxed/simple;
	bh=V6y4Z3il5pkbZW3kvHSiHu1maiMBrnHrERRkgL7kBq4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dW52FsVqlIxBiZLa/uSI/ELVTze9ZlA0Srcse1VFkB9rlZ6cnN8jXawkfUjaWd0L32gihOdztCKH4hJSKGyjhOm4dmBYVOzqPNZz7cj+4wWfiUYTNgnzoF6S/e5Osw9maMf6gs/ckOLeBf0K9T5l4sA9E2utlG8hCujdClint4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u660tKJH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ed0017688so377151a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043072; x=1748647872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0hym13EB2jEzPzAvfGU/pnzl8+6u9GycwL6e33A1UGk=;
        b=u660tKJH/c5EgN1qJQg41R8xHQnhZG7BBGqzjjJW3CirN5IQbfIZeN0icWEZBbAbBU
         pix9G6NIPunxkMZRia7K9S07BAfH/zThn5J28yxkErWRxsDVl03arj6VSACV/ZgF1sb6
         a5ysxAmx2SEE9FTxdQeOUzoP8I3JWi/UpfZgIZUk/qUf87vpVqIcUIrOR8Cdgqeqg1MT
         TUq3TZEzFe5kUklOffzxE5CyXaQYGEYWaKwXASkMwysotdJ5gKBeYP0X+7oc1/m5VU7H
         qhVl99pLPYcTs4uQGktQs60aYGphIWaM1G3oiRacdn9d8WKQwXp3HlJSvu/cejM4/FuR
         vv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043072; x=1748647872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hym13EB2jEzPzAvfGU/pnzl8+6u9GycwL6e33A1UGk=;
        b=sSZZBEUkHIQ4B+44Co6yR27JvYu+XjvVvhNkfUnnizm2NjpFKwhjfDQFF0pvkkSz+D
         0B7lhyOeo7UuMLQGTE47XTIMFjigqFlzvm5UgnWO0LH41Z+Z3UctrELACRVuKysS6/7R
         2BK5zL8A7AQAaQTgQM6b7QpYCfz2dnDprZMtfk71y/PYeWIR+QTK7lWk/bF7b8xYUaVC
         Jm0InjH0RqexnJ+DL3nDFYAPIuzuQfoRZReqWokPPUsqrd/re/1qjfpCr1V+boQXMG76
         0uLCDWaTNy9Nvj9hyqXP3mXljQ/nKASWcAgey57TphP7jb7kq4uq3D8LitDRVaIWdtY/
         TIqg==
X-Forwarded-Encrypted: i=1; AJvYcCX8EJ3GqRvoiWSvLxRL5U7VPsmxfY5r9BX88pWQOlUzg0FSWtbMm3atQevEwe4BOjvSI3OsOBNlhcCzlS6rh/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmroFEDzzgyAaj038ByJfgnbsNUB7HvVtPeLcGoHWVJ/Iteufo
	wlh9jS/HtjeCMJ5BnCMdLCDunm4nQDJrPKeRF0x68hO32rDLYwZFn3lD+y70AQrfdVk0hg6A15a
	JzYoGON9nzWLzlg==
X-Google-Smtp-Source: AGHT+IETLd5XFVQbklzgkagzTnQNtyAeaa6wV1F90VSfKA26TlAQJipkBn0k6MgW4PQB6exb9CZ4O3xxDogoWg==
X-Received: from pjbdb11.prod.google.com ([2002:a17:90a:d64b:b0:2ff:84e6:b2bd])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d60e:b0:30c:540b:9ba with SMTP id 98e67ed59e1d1-3110f0f9b4cmr1682015a91.10.1748043072300;
 Fri, 23 May 2025 16:31:12 -0700 (PDT)
Date: Fri, 23 May 2025 23:30:15 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-31-dmatlack@google.com>
Subject: [RFC PATCH 30/33] vfio: selftests: Add a script to help with running
 VFIO selftests
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
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
  ... bind to vfio-pci and launch $SHELL ...
  $ echo $BDF
  0000:6a:01.0
  $ ./vfio_pci_device_test $BDF
  ...
  $ exit
  ... unbind from vfio-pci ...
  $

Choosing which device to use is up to the user.

In the future this script should be extensible to tests that want to use
multiple devices. The script can support accepting -d BDF multiple times
and parse them into an array, setup all the devices, pass the list of
BDFs to the test, and then cleanup all the devices.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile |   1 +
 tools/testing/selftests/vfio/run.sh   | 110 ++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100755 tools/testing/selftests/vfio/run.sh

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 21fb1809035e..2ab86bd930b0 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -3,6 +3,7 @@ TEST_GEN_PROGS_EXTENDED += vfio_dma_mapping_test
 TEST_GEN_PROGS_EXTENDED += vfio_iommufd_setup_test
 TEST_GEN_PROGS_EXTENDED += vfio_pci_device_test
 TEST_GEN_PROGS_EXTENDED += vfio_pci_driver_test
+TEST_PROGS_EXTENDED := run.sh
 include ../lib.mk
 include lib/libvfio.mk
 
diff --git a/tools/testing/selftests/vfio/run.sh b/tools/testing/selftests/vfio/run.sh
new file mode 100755
index 000000000000..b461cc1b2f11
--- /dev/null
+++ b/tools/testing/selftests/vfio/run.sh
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+readonly VFIO_PCI_DRIVER=/sys/bus/pci/drivers/vfio-pci
+
+function bind() {
+	echo "Binding ${1} to ${2}"
+	echo "${1}" > "${2}/bind"
+}
+
+function unbind() {
+	echo "Unbinding ${1} from ${2}"
+	echo "${1}" > "${2}/unbind"
+}
+
+function set_sriov_numvfs() {
+	echo "Setting ${1} sriov_numvfs to ${2}"
+	echo ${2} > /sys/bus/pci/devices/${1}/sriov_numvfs
+}
+
+function add_id() {
+	if echo $(echo ${1} | tr : ' ') > ${2}/new_id 2> /dev/null; then
+		echo "Added ${1} to ${2}"
+		return 0
+	fi
+
+	return 1
+}
+
+function remove_id() {
+	echo "Removing ${1} from ${2}"
+	echo $(echo ${1} | tr : ' ') > ${2}/remove_id
+}
+
+function cleanup() {
+	if [ "${new_driver}" ]; then unbind ${bdf} ${new_driver} ; fi
+	if [ "${new_id}"     ]; then remove_id ${device_id} ${VFIO_PCI_DRIVER} ; fi
+	if [ "${old_driver}" ]; then bind ${bdf} ${old_driver} ; fi
+	if [ "${old_numvfs}" ]; then set_sriov_numvfs ${bdf} ${old_numvfs} ; fi
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
+	while getopts "d:hs" opt; do
+		case $opt in
+			d) bdf="$OPTARG" ;;
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
+	[ "${bdf}" ] || usage
+
+	trap cleanup EXIT
+	set -e
+
+	test -d /sys/bus/pci/devices/${bdf}
+
+	device_id=$(lspci -s ${bdf} -n | cut -d' ' -f3)
+
+	if [ -f /sys/bus/pci/devices/${bdf}/sriov_numvfs ]; then
+		old_numvfs=$(cat /sys/bus/pci/devices/${bdf}/sriov_numvfs)
+		set_sriov_numvfs ${bdf} 0
+	fi
+
+	if [ -L /sys/bus/pci/devices/${bdf}/driver ]; then
+		old_driver=$(readlink -m /sys/bus/pci/devices/${bdf}/driver)
+		unbind ${bdf} ${old_driver}
+	fi
+
+	# Add the device ID to vfio-pci. If it hasn't already been added, this will
+	# succeed and bind the device to vfio-pci. If it has already been added, this
+	# will fail and we have to manually bind the device.
+	if add_id ${device_id} ${VFIO_PCI_DRIVER}; then
+		new_id=true
+	else
+		bind ${bdf} ${VFIO_PCI_DRIVER}
+	fi
+
+	new_driver=${VFIO_PCI_DRIVER}
+
+	echo
+	if [ "${shell}" ]; then
+		echo "Dropping into ${SHELL} with BDF=${bdf}"
+		BDF=${bdf} ${SHELL}
+	else
+		"$@" ${bdf}
+	fi
+	echo
+}
+
+main "$@"
-- 
2.49.0.1151.ga128411c76-goog


