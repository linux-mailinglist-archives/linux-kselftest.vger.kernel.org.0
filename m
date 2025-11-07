Return-Path: <linux-kselftest+bounces-45098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FA2C40412
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 15:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CD33BE029
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDEA329C77;
	Fri,  7 Nov 2025 14:04:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD52A322A22
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524254; cv=none; b=NCbArwcjI0NyDG20KcI+RqRHUaesBZnrRgYYxv95NhpjuCtkRojUAfvcDRJ4qWeyRt1rfe1oD/r96Q+Ex+FsXL9XY8VCvSGEKbCXpag/GKh4VVN51P/jW6OP5isHQeAkjBIXl6fdL/EBYJMxI7vM6bxM3ji19L3GvVxX0Phfdcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524254; c=relaxed/simple;
	bh=ppaiO2Vs9XmORt4JYnm3iemeeYLzNd4bUeRDRmB7wM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I6+AuY0gsWiDspdWwiQrbreASoTTXDIwK4qtiWECCvi9afXkHsrinfry4i6gMFamEFbvvZuiqU7jMMX8vUHNftT8utS9lFmXsbM7StoFWCVZtIIF2pKDmRa2ezEffJxsIhP2MuMajkJv+njyyk/dfG2obZNr4BDjpmPnx8di0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7260435287so114218766b.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 06:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762524250; x=1763129050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=52JMUM1NA5qpPdeke3vKvkZnbklvpx7bMGO4OFGhD3Y=;
        b=ANRqEdLVjilsPpezX0yh43wl9HXe9W4xytHwGUbEOBMgrU4j2PiWRv1ag9oViDiiwm
         tDKR/ZFDJDlxMYBgjWzEMefE+kGtIjjfQJ9hnYpjxawyT5tWQQlFt0qa3x3dPMCL3RDX
         1n+eq6UDVP/pbFH+B8C1dS2j1/kkqTxqBQVrIvS1ZlT7MV/FPy/u/t0sMoC4Avq/aUtz
         GbYD9Rj+iocbqW9GV9fgfaXj85wz/3UI0ax2KRK2jL9AkbUkSI92EXPE8FmPH1A/sDC7
         5NNEZdeKgHHwZyTU4SQPSuQjnVw3fHFCFjDdrSdpk9jmvfg45Ps2v4iR0/6C3ACCxoK0
         MR9w==
X-Forwarded-Encrypted: i=1; AJvYcCWv3XjO68Yg8xqpjMhWGhgH207CcXbGKJtPC9she8WBpEWUl6VNct6vWiKIlie1C/7I2UOW/P0h4+jm555wlIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfpJuDNLpdn7sOD7xCQIydkPWB9QZJ1B2SNVFIiYo8nbJm2NpY
	tnh4uzS3aYiy+vtzuv4B9KmlU0PweLkWdm/8vWgCUv8nvyTD7hvfrxNQ
X-Gm-Gg: ASbGncumBIOUEmUhePJqeXr0SSPoC3NjDp39mCzivuiIrvhCjjUP77zn4xG6SDM6QlX
	4qgHz78FAepF64i8sfp7hMJFEEEIFG2mZQ5A/ul+stP4UBQSPcvqfLHPnAFD4W8zPnp9PspjU7D
	IjKRjbRz3iX3l4Pp5LfyI3pdT9IP8yek2PCrxABf0xzSEPHaoE9asoX3ea9Idsl5w4yFRwtdS/8
	csIDWeH4g5L6MFsVb1Gdckd79FfWpvkMVgIz8cuvdJGTtUxBOoKB8z17Wo/6D45f9sldAGNzGWZ
	dcLjcXK8yA2+QRQgKvlJy7Rm0OftslNWZZ2RjRpiXh/7WI8WPpDaRMZcdWeCSoYB+W6xTm/xmxM
	Znpn8xd6j0/sNAxwQdHDOViIMtnkxnehryBuT9SvczqMHSK2anhV27HNVwqD3hjM=
X-Google-Smtp-Source: AGHT+IG3wKM86n9BZU4n1wsKqdRiu106DCX4fnn/hh7aH2pH57GSnN0utmPt7Y+edi9BbCwgU4k9NQ==
X-Received: by 2002:a17:907:2d91:b0:b72:7c52:8e9b with SMTP id a640c23a62f3a-b72c078a0d3mr377454066b.15.1762524249496;
        Fri, 07 Nov 2025 06:04:09 -0800 (PST)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf40768fsm248211266b.23.2025.11.07.06.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:04:09 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 07 Nov 2025 06:03:40 -0800
Subject: [PATCH net v10 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-netconsole_torture-v10-4-749227b55f63@debian.org>
References: <20251107-netconsole_torture-v10-0-749227b55f63@debian.org>
In-Reply-To: <20251107-netconsole_torture-v10-0-749227b55f63@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=19483; i=leitao@debian.org;
 h=from:subject:message-id; bh=ppaiO2Vs9XmORt4JYnm3iemeeYLzNd4bUeRDRmB7wM4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpDfxStD/rXgevHfANqJqc2pIizKRK9L2vkZGdZ
 tvaXP/jBdCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQ38UgAKCRA1o5Of/Hh3
 bTtoD/oCfoF5PwxMtqhTAYFsKRycbwYvah3vN8E58Ei9jY/fTrEZfscladRDcwch9h4sZRISLbF
 4R/Mu7B42hNFhvO2GnO4qh89DTR4ur+3H5qCQeoic/JhZM6TCiEYHNbFCyXjzj7CC4NTCUG/YPe
 ywde1Wvn9O7seUJmPib8ycQKAJwDWb1DA8BYRZAqiJ6GcIEEZL3Y1VEm4vUYXkZ5YTP2r0c439N
 kociMn+qKw2tQBoZus0DhDm1+KSEf9yf3bn5ozti+RIGyt22DVQoJoEtirvvtAZAin+bP7vCQjj
 YXadTEcbzoejTtc3+1W3Bda7cU42VePsvNHpuJ2C457g1/FsKRsfp+DqrsOWW+cVgxeW/3Khk2h
 /IhBWBuA6nFJi/Z4HkqLtnt6tJERdOROrk4pIvNGIjULoCxY1YuRBh8Caw4Ka2SsqsXSEB1gwGC
 +FoDpbyLhM8Wy+BFW7WdyYhhHNq+8grEDhofBCCephIhJeoAUzxNpU+5zoLDJib1935CD1qajhJ
 SiluOJWkdyrgsV0l1HowuAjMCdqEcW6in1WaY2ZUWXikxklEUYnqOyo+xEJwiMUlUWEqkvNFYgs
 x+mdAgicD+76miAwgK/+HzdVzf0UEtuK9pMrJFovTeVrcJJsXZB5pbT7f4N8Hj/HpVCrY1wahrH
 iqFmMDg4oHOeTEQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patch adds a selftest that verifies netconsole functionality
over bonded network interfaces using netdevsim. It sets up two bonded
interfaces acting as transmit (TX) and receive (RX) ends, placed in
separate network namespaces. The test sends kernel log messages and
verifies that they are properly received on the bonded RX interfaces
with both IPv4 and IPv6, and using basic and extended netconsole
formats.

This patchset aims to test a long-standing netpoll subsystem where
netpoll has multiple users. (in this case netconsole and bonding). A
similar selftest has been discussed in [1] and [2].

This test also tries to enable bonding and netpoll in different order,
just to guarantee that all the possibilities are exercised.

Link: https://lore.kernel.org/all/20250905-netconsole_torture-v3-0-875c7febd316@debian.org/ [1]
Link: https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/ [2]
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../testing/selftests/drivers/net/bonding/Makefile |   2 +
 tools/testing/selftests/drivers/net/bonding/config |   4 +
 .../drivers/net/bonding/netcons_over_bonding.sh    | 361 +++++++++++++++++++++
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  54 ++-
 4 files changed, 414 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 402d4ee84f2e8..6c5c60adb5e85 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -14,6 +14,7 @@ TEST_PROGS := \
 	dev_addr_lists.sh \
 	mode-1-recovery-updelay.sh \
 	mode-2-recovery-updelay.sh \
+	netcons_over_bonding.sh \
 # end of TEST_PROGS
 
 TEST_FILES := \
@@ -24,6 +25,7 @@ TEST_FILES := \
 
 TEST_INCLUDES := \
 	../../../net/lib.sh \
+	../lib/sh/lib_netcons.sh \
 	../../../net/forwarding/lib.sh \
 # end of TEST_INCLUDES
 
diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index 6bb290abd48bf..9914943762234 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -1,5 +1,6 @@
 CONFIG_BONDING=y
 CONFIG_BRIDGE=y
+CONFIG_CONFIGFS_FS=y
 CONFIG_DUMMY=y
 CONFIG_INET_ESP=y
 CONFIG_INET_ESP_OFFLOAD=y
@@ -9,6 +10,9 @@ CONFIG_MACVLAN=y
 CONFIG_NET_ACT_GACT=y
 CONFIG_NET_CLS_FLOWER=y
 CONFIG_NET_CLS_MATCHALL=m
+CONFIG_NETCONSOLE=m
+CONFIG_NETCONSOLE_DYNAMIC=y
+CONFIG_NETCONSOLE_EXTENDED_LOG=y
 CONFIG_NETDEVSIM=m
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NLMON=y
diff --git a/tools/testing/selftests/drivers/net/bonding/netcons_over_bonding.sh b/tools/testing/selftests/drivers/net/bonding/netcons_over_bonding.sh
new file mode 100755
index 0000000000000..477cc9379500a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/netcons_over_bonding.sh
@@ -0,0 +1,361 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# This selftest exercises trying to have multiple netpoll users at the same
+# time.
+#
+# This selftest has multiple smalls test inside, and the goal is to
+# get interfaces with bonding and netconsole in different orders in order
+# to catch any possible issue.
+#
+# The main test composes of four interfaces being created using netdevsim; two
+# of them are bonded to serve as the netconsole's transmit interface. The
+# remaining two interfaces are similarly bonded and assigned to a separate
+# network namespace, which acts as the receive interface, where socat monitors
+# for incoming messages.
+#
+# A netconsole message is then sent to ensure it is properly received across
+# this configuration.
+#
+# Later, run a few other tests, to make sure that bonding and netconsole
+# cannot coexist.
+#
+# The test's objective is to exercise netpoll usage when managed simultaneously
+# by multiple subsystems (netconsole and bonding).
+#
+# Author: Breno Leitao <leitao@debian.org>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/../lib/sh/lib_netcons.sh
+
+modprobe netdevsim 2> /dev/null || true
+modprobe netconsole 2> /dev/null || true
+modprobe bonding 2> /dev/null || true
+modprobe veth 2> /dev/null || true
+
+# The content of kmsg will be save to the following file
+OUTPUT_FILE="/tmp/${TARGET}"
+
+# Check for basic system dependency and exit if not found
+check_for_dependencies
+# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+echo "6 5" > /proc/sys/kernel/printk
+# Remove the namespace, interfaces and netconsole target on exit
+trap cleanup_bond EXIT
+
+FORMAT="extended"
+IP_VERSION="ipv4"
+VETH0="veth"$(( RANDOM % 256))
+VETH1="veth"$((256 +  RANDOM % 256))
+TXNS=""
+RXNS=""
+
+# Create "bond_tx_XX" and "bond_rx_XX" interfaces, and set DSTIF and SRCIF with
+# the bonding interfaces
+function setup_bonding_ifaces() {
+	local RAND=$(( RANDOM % 100 ))
+	BOND_TX_MAIN_IF="bond_tx_$RAND"
+	BOND_RX_MAIN_IF="bond_rx_$RAND"
+
+	# Setup TX
+	if ! ip -n "${TXNS}" link add "${BOND_TX_MAIN_IF}" type bond mode balance-rr
+	then
+		echo "Failed to create bond TX interface. Is CONFIG_BONDING set?" >&2
+		# only clean nsim ifaces and namespace. Nothing else has been
+		# initialized
+		cleanup_bond_nsim
+		trap - EXIT
+		exit "${ksft_skip}"
+	fi
+
+	# create_netdevsim() got the interface up, but it needs to be down
+	# before being enslaved.
+	ip -n "${TXNS}" \
+		link set "${BOND_TX1_SLAVE_IF}" down
+	ip -n "${TXNS}" \
+		link set "${BOND_TX2_SLAVE_IF}" down
+	ip -n "${TXNS}" \
+		link set "${BOND_TX1_SLAVE_IF}" master "${BOND_TX_MAIN_IF}"
+	ip -n "${TXNS}" \
+		link set "${BOND_TX2_SLAVE_IF}" master "${BOND_TX_MAIN_IF}"
+	ip -n "${TXNS}" \
+		link set "${BOND_TX_MAIN_IF}" up
+
+	# Setup RX
+	ip -n "${RXNS}" \
+		link add "${BOND_RX_MAIN_IF}" type bond mode balance-rr
+	ip -n "${RXNS}" \
+		link set "${BOND_RX1_SLAVE_IF}" down
+	ip -n "${RXNS}" \
+		link set "${BOND_RX2_SLAVE_IF}" down
+	ip -n "${RXNS}" \
+		link set "${BOND_RX1_SLAVE_IF}" master "${BOND_RX_MAIN_IF}"
+	ip -n "${RXNS}" \
+		link set "${BOND_RX2_SLAVE_IF}" master "${BOND_RX_MAIN_IF}"
+	ip -n "${RXNS}" \
+		link set "${BOND_RX_MAIN_IF}" up
+
+	export DSTIF="${BOND_RX_MAIN_IF}"
+	export SRCIF="${BOND_TX_MAIN_IF}"
+}
+
+# Create 4 netdevsim interfaces. Two of them will be bound to TX bonding iface
+# and the other two will be bond to the RX interface (on the other namespace)
+function create_ifaces_bond() {
+	BOND_TX1_SLAVE_IF=$(create_netdevsim "${NSIM_BOND_TX_1}" "${TXNS}")
+	BOND_TX2_SLAVE_IF=$(create_netdevsim "${NSIM_BOND_TX_2}" "${TXNS}")
+	BOND_RX1_SLAVE_IF=$(create_netdevsim "${NSIM_BOND_RX_1}" "${RXNS}")
+	BOND_RX2_SLAVE_IF=$(create_netdevsim "${NSIM_BOND_RX_2}" "${RXNS}")
+}
+
+# netdevsim link BOND_TX to BOND_RX interfaces
+function link_ifaces_bond() {
+	local BOND_TX1_SLAVE_IFIDX
+	local BOND_TX2_SLAVE_IFIDX
+	local BOND_RX1_SLAVE_IFIDX
+	local BOND_RX2_SLAVE_IFIDX
+	local TXNS_FD
+	local RXNS_FD
+
+	BOND_TX1_SLAVE_IFIDX=$(ip netns exec "${TXNS}" \
+				cat /sys/class/net/"$BOND_TX1_SLAVE_IF"/ifindex)
+	BOND_TX2_SLAVE_IFIDX=$(ip netns exec "${TXNS}" \
+				cat /sys/class/net/"$BOND_TX2_SLAVE_IF"/ifindex)
+	BOND_RX1_SLAVE_IFIDX=$(ip netns exec "${RXNS}" \
+				cat /sys/class/net/"$BOND_RX1_SLAVE_IF"/ifindex)
+	BOND_RX2_SLAVE_IFIDX=$(ip netns exec "${RXNS}" \
+				cat /sys/class/net/"$BOND_RX2_SLAVE_IF"/ifindex)
+
+	exec {TXNS_FD}</var/run/netns/"${TXNS}"
+	exec {RXNS_FD}</var/run/netns/"${RXNS}"
+
+	# Linking TX ifaces to the RX ones (on the other namespace)
+	echo "${TXNS_FD}:$BOND_TX1_SLAVE_IFIDX $RXNS_FD:$BOND_RX1_SLAVE_IFIDX"  \
+		> "$NSIM_DEV_SYS_LINK"
+	echo "${TXNS_FD}:$BOND_TX2_SLAVE_IFIDX $RXNS_FD:$BOND_RX2_SLAVE_IFIDX"  \
+		> "$NSIM_DEV_SYS_LINK"
+
+	exec {TXNS_FD}<&-
+	exec {RXNS_FD}<&-
+}
+
+function create_all_ifaces() {
+	# setup_ns function is coming from lib.sh
+	setup_ns TXNS RXNS
+	export NAMESPACE="${RXNS}"
+
+	# Create two interfaces for RX and two for TX
+	create_ifaces_bond
+	# Link netlink ifaces
+	link_ifaces_bond
+}
+
+# configure DSTIF and SRCIF IPs
+function configure_ifaces_ips() {
+	local IP_VERSION=${1:-"ipv4"}
+	select_ipv4_or_ipv6 "${IP_VERSION}"
+
+	ip -n "${RXNS}" addr add "${DSTIP}"/24 dev "${DSTIF}"
+	ip -n "${RXNS}" link set "${DSTIF}" up
+
+	ip -n "${TXNS}" addr add "${SRCIP}"/24 dev "${SRCIF}"
+	ip -n "${TXNS}" link set "${SRCIF}" up
+}
+
+function test_enable_netpoll_on_enslaved_iface() {
+	echo 0 > "${NETCONS_PATH}"/enabled
+
+	# At this stage, BOND_TX1_SLAVE_IF is enslaved to BOND_TX_MAIN_IF, and
+	# linked to BOND_RX1_SLAVE_IF inside the namespace.
+	echo "${BOND_TX1_SLAVE_IF}" > "${NETCONS_PATH}"/dev_name
+
+	# This should fail with the following message in dmesg:
+	# netpoll: netconsole: ethX is a slave device, aborting
+	set +e
+	enable_netcons_ns 2> /dev/null
+	set -e
+
+	if [[ $(cat "${NETCONS_PATH}"/enabled) -eq 1 ]]
+	then
+		echo "test failed: Bonding and netpoll cannot co-exists." >&2
+		exit "${ksft_fail}"
+	fi
+}
+
+function test_delete_bond_and_reenable_target() {
+	ip -n "${TXNS}" \
+		link delete "${BOND_TX_MAIN_IF}" type bond
+
+	# BOND_TX1_SLAVE_IF is not attached to a bond interface anymore
+	# netpoll can be plugged in there
+	echo "${BOND_TX1_SLAVE_IF}" > "${NETCONS_PATH}"/dev_name
+
+	# this should work, since the interface is not enslaved
+	enable_netcons_ns
+
+	if [[ $(cat "${NETCONS_PATH}"/enabled) -eq 0 ]]
+	then
+		echo "test failed: Unable to start netpoll on an unbond iface." >&2
+		exit "${ksft_fail}"
+	fi
+}
+
+# Send a netconsole message to the netconsole target
+function test_send_netcons_msg_through_bond_iface() {
+	# Listen for netconsole port inside the namespace and
+	# destination interface
+	listen_port_and_save_to "${OUTPUT_FILE}" "${IP_VERSION}" &
+	# Wait for socat to start and listen to the port.
+	wait_for_port "${RXNS}" "${PORT}" "${IP_VERSION}"
+	# Send the message
+	echo "${MSG}: ${TARGET}" > /dev/kmsg
+	# Wait until socat saves the file to disk
+	busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+	# Make sure the message was received in the dst part
+	# and exit
+	validate_result "${OUTPUT_FILE}" "${FORMAT}"
+	# kill socat in case it is still running
+	pkill_socat
+}
+
+# BOND_TX1_SLAVE_IF has netconsole enabled on it, bind it to BOND_TX_MAIN_IF.
+# Given BOND_TX_MAIN_IF was deleted, recreate it first
+function test_enslave_netcons_enabled_iface {
+	# netconsole got disabled while the interface was down
+	if [[ $(cat "${NETCONS_PATH}"/enabled) -eq 0 ]]
+	then
+		echo "test failed: netconsole expected to be enabled against BOND_TX1_SLAVE_IF" >&2
+		exit "${ksft_fail}"
+	fi
+
+	# recreate the bonding iface. it got deleted by previous
+	# test (test_delete_bond_and_reenable_target)
+	ip -n "${TXNS}" \
+		link add "${BOND_TX_MAIN_IF}" type bond mode balance-rr
+
+	# sub-interface need to be down before attaching to bonding
+	# This will also disable netconsole.
+	ip -n "${TXNS}" \
+		link set "${BOND_TX1_SLAVE_IF}" down
+	ip -n "${TXNS}" \
+		link set "${BOND_TX1_SLAVE_IF}" master "${BOND_TX_MAIN_IF}"
+	ip -n "${TXNS}" \
+		link set "${BOND_TX_MAIN_IF}" up
+
+	# netconsole got disabled while the interface was down
+	if [[ $(cat "${NETCONS_PATH}"/enabled) -eq 1 ]]
+	then
+		echo "test failed: Device is part of a bond iface, cannot have netcons enabled" >&2
+		exit "${ksft_fail}"
+	fi
+}
+
+# Get netconsole enabled on a bonding interface and attach a second
+# sub-interface.
+function test_enslave_iface_to_bond {
+	# BOND_TX_MAIN_IF has only BOND_TX1_SLAVE_IF right now
+	echo "${BOND_TX_MAIN_IF}" > "${NETCONS_PATH}"/dev_name
+	enable_netcons_ns
+
+	# netcons is attached to bond0 and BOND_TX1_SLAVE_IF is
+	# part of BOND_TX_MAIN_IF. Attach BOND_TX2_SLAVE_IF to BOND_TX_MAIN_IF.
+	ip -n "${TXNS}" \
+		link set "${BOND_TX2_SLAVE_IF}" master "${BOND_TX_MAIN_IF}"
+	if [[ $(cat "${NETCONS_PATH}"/enabled) -eq 0 ]]
+	then
+		echo "test failed: Netconsole should be enabled on bonding interface. Failed" >&2
+		exit "${ksft_fail}"
+	fi
+}
+
+function test_enslave_iff_disabled_netpoll_iface {
+	local ret
+
+	# Create two interfaces. veth interfaces it known to have
+	# IFF_DISABLE_NETPOLL set
+	if ! ip link add "${VETH0}" type veth peer name "${VETH1}"
+	then
+		echo "Failed to create veth TX interface. Is CONFIG_VETH set?" >&2
+		exit "${ksft_skip}"
+	fi
+	set +e
+	# This will print RTNETLINK answers: Device or resource busy
+	ip link set "${VETH0}" master "${BOND_TX_MAIN_IF}" 2> /dev/null
+	ret=$?
+	set -e
+	if [[ $ret -eq 0 ]]
+	then
+		echo "test failed: veth interface could not be enslaved"
+		exit "${ksft_fail}"
+	fi
+}
+
+# Given that netconsole picks the current net namespace, we need to enable it
+# from inside the TXNS namespace
+function enable_netcons_ns() {
+	ip netns exec "${TXNS}" sh -c \
+		"mount -t configfs configfs /sys/kernel/config && echo 1 > $NETCONS_PATH/enabled"
+}
+
+####################
+# Tests start here #
+####################
+
+# Create regular interfaces using netdevsim and link them
+create_all_ifaces
+
+# Setup the bonding interfaces
+# BOND_RX_MAIN_IF has BOND_RX{1,2}_SLAVE_IF
+# BOND_TX_MAIN_IF has BOND_TX{1,2}_SLAVE_IF
+setup_bonding_ifaces
+
+# Configure the ips as BOND_RX1_SLAVE_IF and BOND_TX1_SLAVE_IF
+configure_ifaces_ips "${IP_VERSION}"
+
+_create_dynamic_target "${FORMAT}" "${NETCONS_PATH}"
+enable_netcons_ns
+set_user_data
+
+# Test #1 : Create an bonding interface and attach netpoll into
+# the bonding interface. Netconsole/netpoll should work on
+# the bonding interface.
+test_send_netcons_msg_through_bond_iface
+echo "test #1: netpoll on bonding interface worked. Test passed" >&2
+
+# Test #2: Attach netpoll to an enslaved interface
+# Try to attach netpoll to an enslaved sub-interface (while still being part of
+# a bonding interface), which shouldn't be allowed
+test_enable_netpoll_on_enslaved_iface
+echo "test #2: netpoll correctly rejected enslaved interface (expected behavior). Test passed." >&2
+
+# Test #3: Unplug the sub-interface from bond and enable netconsole
+# Detach the interface from a bonding interface and attach netpoll again
+test_delete_bond_and_reenable_target
+echo "test #3: Able to attach to an unbound interface. Test passed." >&2
+
+# Test #4: Enslave a sub-interface that had netconsole enabled
+# Try to enslave an interface that has netconsole/netpoll enabled.
+# Previous test has netconsole enabled in BOND_TX1_SLAVE_IF, try to enslave it
+test_enslave_netcons_enabled_iface
+echo "test #4: Enslaving an interface with netpoll attached. Test passed." >&2
+
+# Test #5: Enslave a sub-interface to a bonding interface
+# Enslave an interface to a bond interface that has netpoll attached
+# At this stage, BOND_TX_MAIN_IF is created and BOND_TX1_SLAVE_IF is part of
+# it. Netconsole is currently disabled
+test_enslave_iface_to_bond
+echo "test #5: Enslaving an interface to bond+netpoll. Test passed." >&2
+
+# Test #6: Enslave a IFF_DISABLE_NETPOLL sub-interface to a bonding interface
+# At this stage, BOND_TX_MAIN_IF has both sub interface and netconsole is
+# enabled. This test will try to enslave an a veth (IFF_DISABLE_NETPOLL) interface
+# and it should fail, with netpoll: veth0 doesn't support polling
+test_enslave_iff_disabled_netpoll_iface
+echo "test #6: Enslaving IFF_DISABLE_NETPOLL ifaces to bond iface is not supported. Test passed." >&2
+
+cleanup_bond
+trap - EXIT
+exit "${EXIT_STATUS}"
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 9b5ef8074440c..87f89fd92f8c1 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -11,9 +11,11 @@ set -euo pipefail
 LIBDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 SRCIF="" # to be populated later
+SRCIP="" # to be populated later
 SRCIP4="192.0.2.1"
 SRCIP6="fc00::1"
 DSTIF="" # to be populated later
+DSTIP="" # to be populated later
 DSTIP4="192.0.2.2"
 DSTIP6="fc00::2"
 
@@ -28,17 +30,23 @@ NETCONS_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
 # NAMESPACE will be populated by setup_ns with a random value
 NAMESPACE=""
 
-# IDs for netdevsim
+# IDs for netdevsim. We either use NSIM_DEV_{1,2}_ID for standard test
+# or NSIM_BOND_{T,R}X_{1,2} for the bonding tests. Not both at the
+# same time.
 NSIM_DEV_1_ID=$((256 + RANDOM % 256))
 NSIM_DEV_2_ID=$((512 + RANDOM % 256))
+NSIM_BOND_TX_1=$((768 + RANDOM % 256))
+NSIM_BOND_TX_2=$((1024 + RANDOM % 256))
+NSIM_BOND_RX_1=$((1280 + RANDOM % 256))
+NSIM_BOND_RX_2=$((1536 + RANDOM % 256))
 NSIM_DEV_SYS_NEW="/sys/bus/netdevsim/new_device"
+NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
 
 # Used to create and delete namespaces
 source "${LIBDIR}"/../../../../net/lib.sh
 
 # Create netdevsim interfaces
 create_ifaces() {
-
 	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_NEW"
 	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_NEW"
 	udevadm settle 2> /dev/null || true
@@ -137,9 +145,6 @@ function _create_dynamic_target() {
 	then
 		echo 1 > "${NCPATH}"/extended
 	fi
-
-	echo 1 > "${NCPATH}"/enabled
-
 }
 
 function create_dynamic_target() {
@@ -147,6 +152,8 @@ function create_dynamic_target() {
 	local NCPATH=${2:-"$NETCONS_PATH"}
 	_create_dynamic_target "${FORMAT}" "${NCPATH}"
 
+	echo 1 > "${NCPATH}"/enabled
+
 	# This will make sure that the kernel was able to
 	# load the netconsole driver configuration. The console message
 	# gets more organized/sequential as well.
@@ -193,14 +200,26 @@ function do_cleanup() {
 	echo "${DEFAULT_PRINTK_VALUES}" > /proc/sys/kernel/printk
 }
 
-function cleanup() {
+function cleanup_netcons() {
 	# delete netconsole dynamic reconfiguration
-	echo 0 > "${NETCONS_PATH}"/enabled
+	# do not fail if the target is already disabled
+	if [[ ! -d "${NETCONS_PATH}" ]]
+	then
+		# in some cases this is called before netcons path is created
+		return
+	fi
+	if [[ $(cat "${NETCONS_PATH}"/enabled) != 0 ]]
+	then
+		echo 0 > "${NETCONS_PATH}"/enabled || true
+	fi
 	# Remove all the keys that got created during the selftest
 	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
 	# Remove the configfs entry
 	rmdir "${NETCONS_PATH}"
+}
 
+function cleanup() {
+	cleanup_netcons
 	do_cleanup
 }
 
@@ -377,3 +396,24 @@ function wait_for_port() {
 	# more frequently on IPv6
 	sleep 1
 }
+
+# Clean up netdevsim ifaces created for bonding test
+function cleanup_bond_nsim() {
+	ip -n "${TXNS}" \
+		link delete "${BOND_TX_MAIN_IF}" type bond || true
+	ip -n "${RXNS}" \
+		link delete "${BOND_RX_MAIN_IF}" type bond || true
+
+	cleanup_netdevsim "$NSIM_BOND_TX_1"
+	cleanup_netdevsim "$NSIM_BOND_TX_2"
+	cleanup_netdevsim "$NSIM_BOND_RX_1"
+	cleanup_netdevsim "$NSIM_BOND_RX_2"
+}
+
+# cleanup tests that use bonding interfaces
+function cleanup_bond() {
+	cleanup_netcons
+	cleanup_bond_nsim
+	cleanup_all_ns
+	ip link delete "${VETH0}" || true
+}

-- 
2.47.3


