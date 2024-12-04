Return-Path: <linux-kselftest+bounces-22834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8DD9E3FE2
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 17:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226F2282937
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5B620DD76;
	Wed,  4 Dec 2024 16:41:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259120D4FC;
	Wed,  4 Dec 2024 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330463; cv=none; b=QY8uxap9KJp+IOYvBOWAhG3JNKMuQFSni8t60OkqKJjlSrkF6snuXcj0llnMeOpiqfyo2ALcRnxKJMpFCR5o379C4GiLh56Kcwe2YiJ+fZXY8o1UtSNvDFN33yeKk2HIP1J5RH8V00IgipuHVA5BfcYztoFRyf1pPHqpzbtlXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330463; c=relaxed/simple;
	bh=G+FEqjsvSdAMfldd5nI9dWrnpQcLblC/mjCfA25OZkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tw71bfbla89OU5oOjVTTP4CWQ1O7bxidxM+l7IZF1UB0Nle9/V5xKMuJ3lOJVe2OhYsSPdgjkaII8Vg0qO7YxXj1zlmRXs3ONdu8B3Wor9zGG4VqbRZUKw5QJHLlKRsaiW1ML7dJ/AH+VzDo0YVAwZq64uFzyoxmw7Nqp4H7YZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfddb70965so8728420a12.0;
        Wed, 04 Dec 2024 08:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733330459; x=1733935259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EED6edYc58ZoUVFAXfO05i/aquvxfhSgMV2Jzs4zP+M=;
        b=eYu+yZVFUb2cZW5ht2wl0qIpatd4DAR0ZjgJ5Rif+Re8KWpgCPE80NpZblCrpPp+2f
         mKiMJkr0pUg8i+UtyXWQsAInYm0lOQAe9//agHrLLUQjT5tZgSsvWJ6Ys31WhkQW/pC8
         CaVp2rgFISbYXk+noAe7Un3vnHNWul06AfHz70dByBY3t4+om1P7d6DeBCVHwOffD3I3
         p8ziL3ZVqD12uQkgU2Iet6DcQQUModSNH0cxsS5xJZsvWpJCu0Oin4zgbMKnYHuQlQ5A
         4wgG30AAvihq20Dq06/bAdkGgzJZdO6OYF7WBel/T0aVdAHp0iNjf/oc8UVXTJvjuEvK
         nkKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMKWb9TmiOEg2BsPuYxEkt9E8kTg09uZwwfHkiT/7JCzwZusesQpI1eUHKkHBZUPFz6392mJbT+Jqna+lPHl71@vger.kernel.org, AJvYcCXeF0aX3wNT/tnLn1duLGinCamgC7yAFkGi/TmmNhc/7GrYHsfAKoVD6aSAs0G1ji+k0lFcc5KWxqN2egM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtTHET5zFbjLs025C8JWeKa9Mwm3xKPV4rM5NUoBeJ08tqGQCZ
	eD1yjl9+lrkC6ZRWD5k9ozD9dyolrT6LaR+hnH14wgOuo/uqDy8AVjeTAg==
X-Gm-Gg: ASbGncup8OvcE8sFqPPM6zl2URayW+lwfI4gsPjmN2Ofi9atKjXokk4jsyES+DOH2EB
	WcCFvIrl4o0H5Foqupft1oqInpxPtz7ix1+XHrHmsy171IEgvEwynxuRKSAzJUE5IRioCP6cTXH
	Rf7eA65tEDHAV4C29APFadNQSKQmJvohwxBQ3EhYe2yxthAmXyiMwy6uDb51xBL+vg386PvP/ma
	nOoUTLgNwpRVN8Tq9u+6Xy901OclkIjJHv66Lr0t45PYc4UwJdLce+eRXtQ2QsHfGeAVnUaqz1w
	h5g=
X-Google-Smtp-Source: AGHT+IF1XvdKZE+Lf6LpH7ElP1PAKYpJv6ya+RmcbgwMyuj9BYlOc1/lAv3dkqRnu0MNk71XAgMsIQ==
X-Received: by 2002:a05:6402:26c1:b0:5d0:e3fa:17dd with SMTP id 4fb4d7f45d1cf-5d10cb800e1mr7094272a12.22.1733330459081;
        Wed, 04 Dec 2024 08:40:59 -0800 (PST)
Received: from localhost (fwdproxy-lla-126.fbsv.net. [2a03:2880:30ff:7e::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0c7a2a0c6sm5411002a12.26.2024.12.04.08.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:40:58 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 04 Dec 2024 08:40:43 -0800
Subject: [PATCH net-next 2/4] netconsole: selftest: Split the helpers from
 the selftest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-netcons_overflow_test-v1-2-a85a8d0ace21@debian.org>
References: <20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org>
In-Reply-To: <20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15025; i=leitao@debian.org;
 h=from:subject:message-id; bh=G+FEqjsvSdAMfldd5nI9dWrnpQcLblC/mjCfA25OZkQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnUIYVb7KdwjKK47u5OEDr6GHsJKdt9JdrHO/S+
 c259S6rlRqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ1CGFQAKCRA1o5Of/Hh3
 bR64D/wMd4nODf3XQuYzhcS/zbYYtspIoXNfXh25aq7XpHCtMBtwsx44DMwmtFft7eJf9GnNfuE
 nOy9ruQ+0UFHK79n7xCcWhwHnFcCur+DktdeaqyYYn1rFIKRh7PWD+NnGicCV+fKFftl5OHuYOA
 YkBGYtnOVO6DNzzzDPvXpH3ZHNMg59uy2RrKEDoXxfFvXunN0MJDv5CCPJtzfrTdVY6Iy9gFVSa
 iD4Gj2WpidU5Euxon3djyGx8oPX3hP0zHKtAJdk0FMVFOAJMHcTjC8+Vrar8yYDIcXXtQ2uUO3i
 GBHg/8xLVsjtC/lSzdXofNbnXPN5BphX8S4d43vHIFoAcVxTh4Bs8jZ5RjuMvHfXF9KMQfOVGoO
 wpug67CJScOzDHSuSZMA7TxO+mrc53ueoLc5Y7VtbAEKroPaIgcGdZTNPUkv20ycKfgZvIh7TbZ
 fZf6Sv4Nu3SgMgVZf44DSLCyQN2o6iqaOpOFf/WpF1V63UvWmQYSUddXRQYCWfdPx6J1QEWmzUe
 4pjX4nIZOUsoIxsGE2lQPsvOxEPNewslEwzTo6A2NBhEf+858RsZd/jcRt6NtlG1NSLOglxSF62
 BnNN2K8086l35M5MWZGEYwxpKOGXuadgMZ3sa4Vs1QEn2B5eSL3XRhgizWX1KnWXO2dNC59VQ2J
 DYU30CKCwz5ulHg==
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
---
 MAINTAINERS                                        |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 225 +++++++++++++++++++++
 .../testing/selftests/drivers/net/netcons_basic.sh | 218 +-------------------
 3 files changed, 227 insertions(+), 217 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0456a33ef65792bacb5d305a6384d245844fb743..8af5c9a28e68c4b6a785e2e6b82db20b3cf59822 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16091,6 +16091,7 @@ M:	Breno Leitao <leitao@debian.org>
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


