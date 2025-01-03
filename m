Return-Path: <linux-kselftest+bounces-23865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF689A0098E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 13:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AF51880121
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 12:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0AE1FA8CE;
	Fri,  3 Jan 2025 12:58:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8691FA851;
	Fri,  3 Jan 2025 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735909101; cv=none; b=n6uZ3fFx7JUZ9Rlls/U6V2aVaQlDi1TSdk+4PQvCtTKzJKsEgrp+JMn5UDBk3nN0qbsFzv6aLItG6aZevtOU1uYqDJfWFJkADaGnooqOgtztYIU8Pj90U0gIWsSBaRN4P7Df5mAXveYx6/2ompxsOG6e7d0esQKvq49KRjPkS8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735909101; c=relaxed/simple;
	bh=R5xlwxCKn/F7IvCMwgHk7EyMF3VZxWWE6+/IKLQCU+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRCOcBU+sE4rDdxoaFSS/UJdAZ2QViTXypgJgOOcsoI5jv9tPySlvjHhAzbOmm9G7e9fyqVp06Sd7e5CU0HhUNUUOwzopD6LAXYcNdpPG+VrTqie6XZwzoBGgbF1kvZdIqwrxSU2wrlAyXwwPPrvpOeM6o2OtSuBvsZjmsIblPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3e829ff44so24470920a12.0;
        Fri, 03 Jan 2025 04:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735909097; x=1736513897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLR1sIMsxgbYbIJKRO+GpBe/DPp2Ji7L8BTReXkxRVw=;
        b=OqHZUYOQUVm6qIol9OwcOswMeUhdz4SRjkBh99SVHNWBtyRgzu4/BxVnCTqkcKNr65
         Xj/2GbJwi4/3FqHfzsiVx7/K6HlI1NhLAKnre2FGwAn0cTJQ327HW5W9+AhPZzqgCQ30
         6UEjsP49q1dySbbOWhdOOzJlzXfI8OCx+5AiO+XZJ37UeQOCIPY10IXMK3nhSh9tZBm8
         /PdwGIw05cazY96uxtHB+VUor7k7swxyWOivpvoy5jC6rwTf7sSmve59hVMbsWw2+x1A
         OkIYpdt9ARsH/OUJUienxuU5z8hX4dMUeJlOKxN+4FuNcLVLhNad6C2e8WDEp2nC+BVM
         O2CA==
X-Forwarded-Encrypted: i=1; AJvYcCURpMtxaVXBFSz+0BFQnuhQdqBTwWHXhw638cJ1GhO9AYrQ8UBVeEg5XTeMdb7tTZ/Zbwr9PtM7c+Mqsu7Lvgrj@vger.kernel.org, AJvYcCUlHEHXbWLwlCIav/cMjitlVxJ0tKdpH3f5bll6D6OgPgoT/jZcH6vafo/HovSQNVLENkEcIBjjSAL8XdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcd6E5cK/3MM2DzPGfChxotBRm+A5LDvDR1RQY+uXrO7io021j
	uafNVRo9pvqhlx95H6rVXXUCKA+8PtcYoPcoKxjGggUBz/AVR970MAIHQw==
X-Gm-Gg: ASbGnctZ3CRnadPbvETTSrp8YFNrPSzTE9o5eG6mkqRiDZVC3c8mzmkmIQtubMPob5Z
	Vi/18TH94fn04VjELWqTYEtff8dK0XokO1HjkwiT2e6FrjPcDK5wnG9Bv+JT5M1kMb05tHQNkT7
	ylvFm1RC9KRSGecOpPJln+0jcAKEkaNs3mGI9xBb6OzUBESDc0FkeCvt8IQbmkRCG6wolPqel40
	7kD34pTDpO9dn202XMMt8PdY+c6HdRm8/BfGs7DKiDUPsFe
X-Google-Smtp-Source: AGHT+IGJU4zYDJQGt0B7+v5OT2o3D+Y2ur5Bw4LoaWM/yDOqjZLZDCe/Oyv2BQKwR06y+CCILXuaag==
X-Received: by 2002:a17:907:1b83:b0:aae:cf50:5605 with SMTP id a640c23a62f3a-aaecf50562bmr2618581366b.19.1735909096474;
        Fri, 03 Jan 2025 04:58:16 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aaf5d43429bsm558892966b.154.2025.01.03.04.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 04:58:15 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 03 Jan 2025 04:57:50 -0800
Subject: [PATCH net-next v2 2/4] netconsole: selftest: Split the helpers
 from the selftest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-netcons_overflow_test-v2-2-a49f9be64c21@debian.org>
References: <20250103-netcons_overflow_test-v2-0-a49f9be64c21@debian.org>
In-Reply-To: <20250103-netcons_overflow_test-v2-0-a49f9be64c21@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15115; i=leitao@debian.org;
 h=from:subject:message-id; bh=R5xlwxCKn/F7IvCMwgHk7EyMF3VZxWWE6+/IKLQCU+I=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnd97hjJ5rpunrmtlVexvs69Tvrf1JS7L58TF3m
 oHm++vwtuOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ3fe4QAKCRA1o5Of/Hh3
 bT68EACMeU2MmijIoJindvROAW+UYlTIlG5KNp2uselXg9kMlx2TiCh9m3/Rv2t+bzT/THUYKSi
 p7m+EHRRVWZYSGeCpe/1epmerXExWVPH1sFOSwRMAWjIBJZsVIYKNFHNxv5lj6SpS6WL9CKGyAm
 3VpquhT8jeaTg1z0xhgzHLUaPAPy28Zlita3teEjZVZU0JN8CFv8VmWJCohbj4UX1WtmgDpAqfQ
 VTKO6XCv/B27oKBQjQigf6t78a4AL+CSrlZECrqvJj2HMMhOjv2fGDNX21icZ6uIkEou6gI8Pc3
 zgB+psK0hS/gQPziJzwsvb+BxNwViAV9zidwvam2045Wa3r752PL/F+sXLntCxWc5mUkeVNlc2c
 inTT7GckoxDZItnTGh/TJH/A/RpZCEx3FCYFs3pChJ2pSfZ2uVx8r5pl9QzmusV06pcDP8wxcNr
 G9g+eVsjL9ebiqzdaAPNR0ewcZQwRm3WTt+/8bUZ+w+stZuYsDquzQRn7vAeyl5OLntKo+qF0iy
 6dqJnkedtD7zIAbHy4LFRtjKkvjqwja4aQ4n2B61wojqzN768n3LkoPPJUTriIceJxsek6m6uk2
 xmKdhjWsoJpSTiGBTWdUVlmTaKI91205fzvJqpl7u8J4p3I0WWTeKzQLYx3wzrA/4uTOMX9WwtO
 a2xERpOQ1cPwgRQ==
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
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 225 +++++++++++++++++++++
 .../testing/selftests/drivers/net/netcons_basic.sh | 218 +-------------------
 3 files changed, 227 insertions(+), 217 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1579124ef426b8f2e066462e90e6c8e4d068f01e..d7af1c38dbab0c1ac253ced11a07ee7422c75c0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16174,6 +16174,7 @@ M:	Breno Leitao <leitao@debian.org>
 S:	Maintained
 F:	Documentation/networking/netconsole.rst
 F:	drivers/net/netconsole.c
+F:	tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
 F:	tools/testing/selftests/drivers/net/netcons_basic.sh
 
 NETDEVSIM
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


