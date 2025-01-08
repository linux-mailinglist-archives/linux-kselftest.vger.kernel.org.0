Return-Path: <linux-kselftest+bounces-24058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8022FA05A87
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 12:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A3F07A3229
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412CE1FBE89;
	Wed,  8 Jan 2025 11:50:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC71FA8F1;
	Wed,  8 Jan 2025 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337044; cv=none; b=FSd+m6mLxNYiLljqzm09DCBcB7NY07OVgWvBKdsEepyWptQLNx7dyViZBRW9uNApTl7bYJx7SoDo5f6JZgF9wD60tJn1QC0A3RXIVZsKw/AD7ncQ/MK+Iuevc5v4ELD2K/a3V0nlkMWp+RpLWP/L5I2/zpJeGQT5OuSjd04uHPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337044; c=relaxed/simple;
	bh=jHwRkyhF+DGevPBPlLaE1J2ZEHxMKU4Wf9+VZbHGyZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qf3qaKbL19TvHtbr7BE94FIHqDUdUXgfVpHvuYiUxMprAlPIyuqhx+7Yzjt+7VDSSlFumfDSow7qO5pPldjT6Y38CrRVenWnkny4DuMyCsZmllH9rPsdAQrCMqnrEkFB/UVSu+wS8ykJlur21dhzPfnIUK2LUM60BfnehpuX5po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d7e527becaso28188487a12.3;
        Wed, 08 Jan 2025 03:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736337040; x=1736941840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIgG5bbCl3s6OJi/chMCEiXYTN20Hn4cEGL6NbROiN0=;
        b=u16yPUye+TBWfcY762sRyCoGF4uFY+FNSsVcb8fi58f1/8BQhME3Zy/nwd3wbZAFrc
         m68HwOv7NJ0GFXZptg+xWYk8WCwjmCZNg4knE81ccvof7KK4hf6IKXX+R4vv4mVWwKYQ
         mKrBKhkkgMso/VD4I6yxj2JfjOISkeSr3eqTx16cFSv2aJqAaUScFy4eXsnXM2/6NcVr
         zwrN3yfbr4EkxxKGY3hbf9xJonf5sMiNmgh0kMgPkrdKbySUUZbYBP0LIgdCvbHcFqOW
         gM/4UtjtAZIiETPQhMERx4yQ3NNgXigjNgcg8zim0jYfqyCRclPjFlbgiJtX2E/IPnBZ
         /euQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAZSppYALIJxgtDoZBNeVff5GXvTs/4CK73QfxHcOqIsWQgmNJs7lz5msNMIcj5X/6qocHeYCnThTAp2IUjPV/@vger.kernel.org, AJvYcCXHHlr1lsg9RCPrQwrYqkrAW0S5N0txf4TOdv+z3dxcMHUeXmeI0DK3WCjjS/ENWgLfu7ooQ3aWoaxh14E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj4tJO+pRpNqgCZBL4u8luFf2RjwqgR7AHyggXUogLPvIXpLwD
	P47c1LD4s2kRZKtAZFjyFQJOljdLcX3j/wpCa/gR9e3h5VLfJQcBNQudEA==
X-Gm-Gg: ASbGncvj0QR3p52AkHDbt2HmrDofZvcudcBeuDAUpPzLzrEHcqh5fCAuTEZWARIfvNA
	yavrlh9pkOFawIEXpCULC4+i5Tkw3lJJ49Y1EkIz3UqUQgID5xC1rUU/abQyAGuQVNW/cBl7Rft
	LMH4aeMly0qNa4vi/YxEIy0jNhKuG5O2DaeT00gga2B8v12MYbdy8UnsG8Dgs0wv8MjoTR//U7y
	0DnZD2CBk2bFn1xqS4wcJlfOG+IeAoN36SewSJRJax+SJ7U
X-Google-Smtp-Source: AGHT+IFogEnMeqHh46Ja8fjUDUN0Eagv83BtI6z18mVNyNDI9drplgQ4GEvaodPv5yg1YqDOqCSO3g==
X-Received: by 2002:a05:6402:40c1:b0:5d1:1064:326a with SMTP id 4fb4d7f45d1cf-5d972e1c39fmr5528971a12.15.1736337039785;
        Wed, 08 Jan 2025 03:50:39 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aaf69b4540csm1070888266b.159.2025.01.08.03.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 03:50:39 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 08 Jan 2025 03:50:26 -0800
Subject: [PATCH net-next v3 2/4] netconsole: selftest: Split the helpers
 from the selftest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-netcons_overflow_test-v3-2-3d85eb091bec@debian.org>
References: <20250108-netcons_overflow_test-v3-0-3d85eb091bec@debian.org>
In-Reply-To: <20250108-netcons_overflow_test-v3-0-3d85eb091bec@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15674; i=leitao@debian.org;
 h=from:subject:message-id; bh=jHwRkyhF+DGevPBPlLaE1J2ZEHxMKU4Wf9+VZbHGyZc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnfmaK4vpwBJ4qECEb4RmQFjTcOzW5ESfNU4frH
 JKQSqb/qcqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ35migAKCRA1o5Of/Hh3
 bT6VEACASRQxOLY5jLBPxu6a4aqxS+VhreHfPX7bADnMk+WMqMKNLYSqpqICGNe/tR8XNHVSeUE
 87mqDAgdaGuXBwLRJ+Jl9B4yqvWLH3vhjaIAK3rX51Bgf8SnUJdkoCE6ESot20I7nUOJfeSg55U
 jdxBC+xJDjnZgYgral/Sklm139zMw2m0UgV9JFlcOzqpms4+0smckl/5zuj4vfH5IJVf0Uj+gAG
 yFeW3Wq+dMUcCeutPNeh5g/dnpmB/FTLO2EGitwi3bRfOGndW3p+QQIu2kNKeV8lVl+YY4cvnGP
 pziRS5s1UkEnlOpyEHbN5rj5lwl1iqFuiRHMa+nIknZoF+PglM5NL3Rm58VgyA6VP1aShnmpWZ9
 HP5t+CTLkFIFLKq4Hw80OYNDRw0YztZ6vnMix0vp5Ctq/XQjvUyVLymsjhP22nqiwWLNxDh8Ac4
 xFvyn67cJK3MBtmXtghN8Diosy2EEgbWn2rxmJj1QrrhYLh8l/gESVDk1PNswbwlkNdaQjowWtH
 qwTvTIFywXMCtoAGwM976toVhA3jukm/lufvmLvL91ibVJyy8rn/7+gTwrEAsQI2vtm2OwFiFUg
 EvTS0gW9iaJ+7LT1FkF27/mkkbOAiVmH3jZ/nQ7fOAAakPuLkGQzxLjOIeWeRU6pxKE+xpiVS2P
 UUHnfDqU62H1v6w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Split helper functions from the netconsole basic test into a separate
library file to enable reuse across different netconsole tests. This
change only moves the existing helper functions to lib/sh/lib_netcons.sh
while preserving the same test functionality.

The helpers provide common functions for:
- Setting up network namespaces and interfaces
- Managing netconsole dynamic targets
- Setting user data
- Handling test dependencies
- Cleanup operations

Do not make any change in the code, other than the mechanical
separation.

Signed-off-by: Breno Leitao <leitao@debian.org>
Tested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS                                        |   1 +
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 225 +++++++++++++++++++++
 .../testing/selftests/drivers/net/netcons_basic.sh | 218 +-------------------
 4 files changed, 228 insertions(+), 217 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a685c551faf089f862b5b8e96e3aeab05be97a40..d3cd4b7e48652b7a56873b840fd2ed6e12791008 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16174,6 +16174,7 @@ M:	Breno Leitao <leitao@debian.org>
 S:	Maintained
 F:	Documentation/networking/netconsole.rst
 F:	drivers/net/netconsole.c
+F:	tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
 F:	tools/testing/selftests/drivers/net/netcons_basic.sh
 
 NETDEVSIM
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 0fec8f9801ad4d94d99ab6d0acaea6e2e7b2894d..dafff5d7fe88c82a1d27aa49faca728b52435ebc 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 TEST_INCLUDES := $(wildcard lib/py/*.py) \
+		 $(wildcard lib/sh/*.sh) \
 		 ../../net/net_helper.sh \
 		 ../../net/lib.sh \
 
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
new file mode 100644
index 0000000000000000000000000000000000000000..fdd45a3468f17449eeb66d9a808b7a3b2107e47c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -0,0 +1,225 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This file contains functions and helpers to support the netconsole
+# selftests
+#
+# Author: Breno Leitao <leitao@debian.org>
+
+set -euo pipefail
+
+LIBDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+SRCIF="" # to be populated later
+SRCIP=192.0.2.1
+DSTIF="" # to be populated later
+DSTIP=192.0.2.2
+
+PORT="6666"
+MSG="netconsole selftest"
+USERDATA_KEY="key"
+USERDATA_VALUE="value"
+TARGET=$(mktemp -u netcons_XXXXX)
+DEFAULT_PRINTK_VALUES=$(cat /proc/sys/kernel/printk)
+NETCONS_CONFIGFS="/sys/kernel/config/netconsole"
+NETCONS_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
+KEY_PATH="${NETCONS_PATH}/userdata/${USERDATA_KEY}"
+# NAMESPACE will be populated by setup_ns with a random value
+NAMESPACE=""
+
+# IDs for netdevsim
+NSIM_DEV_1_ID=$((256 + RANDOM % 256))
+NSIM_DEV_2_ID=$((512 + RANDOM % 256))
+NSIM_DEV_SYS_NEW="/sys/bus/netdevsim/new_device"
+
+# Used to create and delete namespaces
+source "${LIBDIR}"/../../../../net/lib.sh
+source "${LIBDIR}"/../../../../net/net_helper.sh
+
+# Create netdevsim interfaces
+create_ifaces() {
+
+	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_NEW"
+	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_NEW"
+	udevadm settle 2> /dev/null || true
+
+	local NSIM1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_DEV_1_ID"
+	local NSIM2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_DEV_2_ID"
+
+	# These are global variables
+	SRCIF=$(find "$NSIM1"/net -maxdepth 1 -type d ! \
+		-path "$NSIM1"/net -exec basename {} \;)
+	DSTIF=$(find "$NSIM2"/net -maxdepth 1 -type d ! \
+		-path "$NSIM2"/net -exec basename {} \;)
+}
+
+link_ifaces() {
+	local NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
+	local SRCIF_IFIDX=$(cat /sys/class/net/"$SRCIF"/ifindex)
+	local DSTIF_IFIDX=$(cat /sys/class/net/"$DSTIF"/ifindex)
+
+	exec {NAMESPACE_FD}</var/run/netns/"${NAMESPACE}"
+	exec {INITNS_FD}</proc/self/ns/net
+
+	# Bind the dst interface to namespace
+	ip link set "${DSTIF}" netns "${NAMESPACE}"
+
+	# Linking one device to the other one (on the other namespace}
+	if ! echo "${INITNS_FD}:$SRCIF_IFIDX $NAMESPACE_FD:$DSTIF_IFIDX"  > $NSIM_DEV_SYS_LINK
+	then
+		echo "linking netdevsim1 with netdevsim2 should succeed"
+		cleanup
+		exit "${ksft_skip}"
+	fi
+}
+
+function configure_ip() {
+	# Configure the IPs for both interfaces
+	ip netns exec "${NAMESPACE}" ip addr add "${DSTIP}"/24 dev "${DSTIF}"
+	ip netns exec "${NAMESPACE}" ip link set "${DSTIF}" up
+
+	ip addr add "${SRCIP}"/24 dev "${SRCIF}"
+	ip link set "${SRCIF}" up
+}
+
+function set_network() {
+	# setup_ns function is coming from lib.sh
+	setup_ns NAMESPACE
+
+	# Create both interfaces, and assign the destination to a different
+	# namespace
+	create_ifaces
+
+	# Link both interfaces back to back
+	link_ifaces
+
+	configure_ip
+}
+
+function create_dynamic_target() {
+	DSTMAC=$(ip netns exec "${NAMESPACE}" \
+		 ip link show "${DSTIF}" | awk '/ether/ {print $2}')
+
+	# Create a dynamic target
+	mkdir "${NETCONS_PATH}"
+
+	echo "${DSTIP}" > "${NETCONS_PATH}"/remote_ip
+	echo "${SRCIP}" > "${NETCONS_PATH}"/local_ip
+	echo "${DSTMAC}" > "${NETCONS_PATH}"/remote_mac
+	echo "${SRCIF}" > "${NETCONS_PATH}"/dev_name
+
+	echo 1 > "${NETCONS_PATH}"/enabled
+}
+
+function cleanup() {
+	local NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
+
+	# delete netconsole dynamic reconfiguration
+	echo 0 > "${NETCONS_PATH}"/enabled
+	# Remove key
+	rmdir "${KEY_PATH}"
+	# Remove the configfs entry
+	rmdir "${NETCONS_PATH}"
+
+	# Delete netdevsim devices
+	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_DEL"
+	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_DEL"
+
+	# this is coming from lib.sh
+	cleanup_all_ns
+
+	# Restoring printk configurations
+	echo "${DEFAULT_PRINTK_VALUES}" > /proc/sys/kernel/printk
+}
+
+function set_user_data() {
+	if [[ ! -d "${NETCONS_PATH}""/userdata" ]]
+	then
+		echo "Userdata path not available in ${NETCONS_PATH}/userdata"
+		exit "${ksft_skip}"
+	fi
+
+	mkdir -p "${KEY_PATH}"
+	VALUE_PATH="${KEY_PATH}""/value"
+	echo "${USERDATA_VALUE}" > "${VALUE_PATH}"
+}
+
+function listen_port_and_save_to() {
+	local OUTPUT=${1}
+	# Just wait for 2 seconds
+	timeout 2 ip netns exec "${NAMESPACE}" \
+		socat UDP-LISTEN:"${PORT}",fork "${OUTPUT}"
+}
+
+function validate_result() {
+	local TMPFILENAME="$1"
+
+	# TMPFILENAME will contain something like:
+	# 6.11.1-0_fbk0_rc13_509_g30d75cea12f7,13,1822,115075213798,-;netconsole selftest: netcons_gtJHM
+	#  key=value
+
+	# Check if the file exists
+	if [ ! -f "$TMPFILENAME" ]; then
+		echo "FAIL: File was not generated." >&2
+		exit "${ksft_fail}"
+	fi
+
+	if ! grep -q "${MSG}" "${TMPFILENAME}"; then
+		echo "FAIL: ${MSG} not found in ${TMPFILENAME}" >&2
+		cat "${TMPFILENAME}" >&2
+		exit "${ksft_fail}"
+	fi
+
+	if ! grep -q "${USERDATA_KEY}=${USERDATA_VALUE}" "${TMPFILENAME}"; then
+		echo "FAIL: ${USERDATA_KEY}=${USERDATA_VALUE} not found in ${TMPFILENAME}" >&2
+		cat "${TMPFILENAME}" >&2
+		exit "${ksft_fail}"
+	fi
+
+	# Delete the file once it is validated, otherwise keep it
+	# for debugging purposes
+	rm "${TMPFILENAME}"
+	exit "${ksft_pass}"
+}
+
+function check_for_dependencies() {
+	if [ "$(id -u)" -ne 0 ]; then
+		echo "This test must be run as root" >&2
+		exit "${ksft_skip}"
+	fi
+
+	if ! which socat > /dev/null ; then
+		echo "SKIP: socat(1) is not available" >&2
+		exit "${ksft_skip}"
+	fi
+
+	if ! which ip > /dev/null ; then
+		echo "SKIP: ip(1) is not available" >&2
+		exit "${ksft_skip}"
+	fi
+
+	if ! which udevadm > /dev/null ; then
+		echo "SKIP: udevadm(1) is not available" >&2
+		exit "${ksft_skip}"
+	fi
+
+	if [ ! -f "${NSIM_DEV_SYS_NEW}" ]; then
+		echo "SKIP: file ${NSIM_DEV_SYS_NEW} does not exist. Check if CONFIG_NETDEVSIM is enabled" >&2
+		exit "${ksft_skip}"
+	fi
+
+	if [ ! -d "${NETCONS_CONFIGFS}" ]; then
+		echo "SKIP: directory ${NETCONS_CONFIGFS} does not exist. Check if NETCONSOLE_DYNAMIC is enabled" >&2
+		exit "${ksft_skip}"
+	fi
+
+	if ip link show "${DSTIF}" 2> /dev/null; then
+		echo "SKIP: interface ${DSTIF} exists in the system. Not overwriting it." >&2
+		exit "${ksft_skip}"
+	fi
+
+	if ip addr list | grep -E "inet.*(${SRCIP}|${DSTIP})" 2> /dev/null; then
+		echo "SKIP: IPs already in use. Skipping it" >&2
+		exit "${ksft_skip}"
+	fi
+}
diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
index b175f4d966e5056ddb62e335f212c03e55f50fb0..fe765da498e845d7be1fd09551363224d40ded65 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -18,224 +18,8 @@ set -euo pipefail
 
 SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
-# Simple script to test dynamic targets in netconsole
-SRCIF="" # to be populated later
-SRCIP=192.0.2.1
-DSTIF="" # to be populated later
-DSTIP=192.0.2.2
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
 
-PORT="6666"
-MSG="netconsole selftest"
-USERDATA_KEY="key"
-USERDATA_VALUE="value"
-TARGET=$(mktemp -u netcons_XXXXX)
-DEFAULT_PRINTK_VALUES=$(cat /proc/sys/kernel/printk)
-NETCONS_CONFIGFS="/sys/kernel/config/netconsole"
-NETCONS_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
-KEY_PATH="${NETCONS_PATH}/userdata/${USERDATA_KEY}"
-# NAMESPACE will be populated by setup_ns with a random value
-NAMESPACE=""
-
-# IDs for netdevsim
-NSIM_DEV_1_ID=$((256 + RANDOM % 256))
-NSIM_DEV_2_ID=$((512 + RANDOM % 256))
-NSIM_DEV_SYS_NEW="/sys/bus/netdevsim/new_device"
-
-# Used to create and delete namespaces
-source "${SCRIPTDIR}"/../../net/lib.sh
-source "${SCRIPTDIR}"/../../net/net_helper.sh
-
-# Create netdevsim interfaces
-create_ifaces() {
-
-	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_NEW"
-	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_NEW"
-	udevadm settle 2> /dev/null || true
-
-	local NSIM1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_DEV_1_ID"
-	local NSIM2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_DEV_2_ID"
-
-	# These are global variables
-	SRCIF=$(find "$NSIM1"/net -maxdepth 1 -type d ! \
-		-path "$NSIM1"/net -exec basename {} \;)
-	DSTIF=$(find "$NSIM2"/net -maxdepth 1 -type d ! \
-		-path "$NSIM2"/net -exec basename {} \;)
-}
-
-link_ifaces() {
-	local NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
-	local SRCIF_IFIDX=$(cat /sys/class/net/"$SRCIF"/ifindex)
-	local DSTIF_IFIDX=$(cat /sys/class/net/"$DSTIF"/ifindex)
-
-	exec {NAMESPACE_FD}</var/run/netns/"${NAMESPACE}"
-	exec {INITNS_FD}</proc/self/ns/net
-
-	# Bind the dst interface to namespace
-	ip link set "${DSTIF}" netns "${NAMESPACE}"
-
-	# Linking one device to the other one (on the other namespace}
-	if ! echo "${INITNS_FD}:$SRCIF_IFIDX $NAMESPACE_FD:$DSTIF_IFIDX"  > $NSIM_DEV_SYS_LINK
-	then
-		echo "linking netdevsim1 with netdevsim2 should succeed"
-		cleanup
-		exit "${ksft_skip}"
-	fi
-}
-
-function configure_ip() {
-	# Configure the IPs for both interfaces
-	ip netns exec "${NAMESPACE}" ip addr add "${DSTIP}"/24 dev "${DSTIF}"
-	ip netns exec "${NAMESPACE}" ip link set "${DSTIF}" up
-
-	ip addr add "${SRCIP}"/24 dev "${SRCIF}"
-	ip link set "${SRCIF}" up
-}
-
-function set_network() {
-	# setup_ns function is coming from lib.sh
-	setup_ns NAMESPACE
-
-	# Create both interfaces, and assign the destination to a different
-	# namespace
-	create_ifaces
-
-	# Link both interfaces back to back
-	link_ifaces
-
-	configure_ip
-}
-
-function create_dynamic_target() {
-	DSTMAC=$(ip netns exec "${NAMESPACE}" \
-		 ip link show "${DSTIF}" | awk '/ether/ {print $2}')
-
-	# Create a dynamic target
-	mkdir "${NETCONS_PATH}"
-
-	echo "${DSTIP}" > "${NETCONS_PATH}"/remote_ip
-	echo "${SRCIP}" > "${NETCONS_PATH}"/local_ip
-	echo "${DSTMAC}" > "${NETCONS_PATH}"/remote_mac
-	echo "${SRCIF}" > "${NETCONS_PATH}"/dev_name
-
-	echo 1 > "${NETCONS_PATH}"/enabled
-}
-
-function cleanup() {
-	local NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
-
-	# delete netconsole dynamic reconfiguration
-	echo 0 > "${NETCONS_PATH}"/enabled
-	# Remove key
-	rmdir "${KEY_PATH}"
-	# Remove the configfs entry
-	rmdir "${NETCONS_PATH}"
-
-	# Delete netdevsim devices
-	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_DEL"
-	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_DEL"
-
-	# this is coming from lib.sh
-	cleanup_all_ns
-
-	# Restoring printk configurations
-	echo "${DEFAULT_PRINTK_VALUES}" > /proc/sys/kernel/printk
-}
-
-function set_user_data() {
-	if [[ ! -d "${NETCONS_PATH}""/userdata" ]]
-	then
-		echo "Userdata path not available in ${NETCONS_PATH}/userdata"
-		exit "${ksft_skip}"
-	fi
-
-	mkdir -p "${KEY_PATH}"
-	VALUE_PATH="${KEY_PATH}""/value"
-	echo "${USERDATA_VALUE}" > "${VALUE_PATH}"
-}
-
-function listen_port_and_save_to() {
-	local OUTPUT=${1}
-	# Just wait for 2 seconds
-	timeout 2 ip netns exec "${NAMESPACE}" \
-		socat UDP-LISTEN:"${PORT}",fork "${OUTPUT}"
-}
-
-function validate_result() {
-	local TMPFILENAME="$1"
-
-	# TMPFILENAME will contain something like:
-	# 6.11.1-0_fbk0_rc13_509_g30d75cea12f7,13,1822,115075213798,-;netconsole selftest: netcons_gtJHM
-	#  key=value
-
-	# Check if the file exists
-	if [ ! -f "$TMPFILENAME" ]; then
-		echo "FAIL: File was not generated." >&2
-		exit "${ksft_fail}"
-	fi
-
-	if ! grep -q "${MSG}" "${TMPFILENAME}"; then
-		echo "FAIL: ${MSG} not found in ${TMPFILENAME}" >&2
-		cat "${TMPFILENAME}" >&2
-		exit "${ksft_fail}"
-	fi
-
-	if ! grep -q "${USERDATA_KEY}=${USERDATA_VALUE}" "${TMPFILENAME}"; then
-		echo "FAIL: ${USERDATA_KEY}=${USERDATA_VALUE} not found in ${TMPFILENAME}" >&2
-		cat "${TMPFILENAME}" >&2
-		exit "${ksft_fail}"
-	fi
-
-	# Delete the file once it is validated, otherwise keep it
-	# for debugging purposes
-	rm "${TMPFILENAME}"
-	exit "${ksft_pass}"
-}
-
-function check_for_dependencies() {
-	if [ "$(id -u)" -ne 0 ]; then
-		echo "This test must be run as root" >&2
-		exit "${ksft_skip}"
-	fi
-
-	if ! which socat > /dev/null ; then
-		echo "SKIP: socat(1) is not available" >&2
-		exit "${ksft_skip}"
-	fi
-
-	if ! which ip > /dev/null ; then
-		echo "SKIP: ip(1) is not available" >&2
-		exit "${ksft_skip}"
-	fi
-
-	if ! which udevadm > /dev/null ; then
-		echo "SKIP: udevadm(1) is not available" >&2
-		exit "${ksft_skip}"
-	fi
-
-	if [ ! -f "${NSIM_DEV_SYS_NEW}" ]; then
-		echo "SKIP: file ${NSIM_DEV_SYS_NEW} does not exist. Check if CONFIG_NETDEVSIM is enabled" >&2
-		exit "${ksft_skip}"
-	fi
-
-	if [ ! -d "${NETCONS_CONFIGFS}" ]; then
-		echo "SKIP: directory ${NETCONS_CONFIGFS} does not exist. Check if NETCONSOLE_DYNAMIC is enabled" >&2
-		exit "${ksft_skip}"
-	fi
-
-	if ip link show "${DSTIF}" 2> /dev/null; then
-		echo "SKIP: interface ${DSTIF} exists in the system. Not overwriting it." >&2
-		exit "${ksft_skip}"
-	fi
-
-	if ip addr list | grep -E "inet.*(${SRCIP}|${DSTIP})" 2> /dev/null; then
-		echo "SKIP: IPs already in use. Skipping it" >&2
-		exit "${ksft_skip}"
-	fi
-}
-
-# ========== #
-# Start here #
-# ========== #
 modprobe netdevsim 2> /dev/null || true
 modprobe netconsole 2> /dev/null || true
 

-- 
2.43.5


