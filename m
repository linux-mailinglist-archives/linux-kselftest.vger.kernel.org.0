Return-Path: <linux-kselftest+bounces-42679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 071B3BB452E
	for <lists+linux-kselftest@lfdr.de>; Thu, 02 Oct 2025 17:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44095325879
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Oct 2025 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38291EA7FF;
	Thu,  2 Oct 2025 15:26:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915DE1C862C
	for <linux-kselftest@vger.kernel.org>; Thu,  2 Oct 2025 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418808; cv=none; b=O7GM5Gmqk3aoeKs11rzgvqfvsvnWB1IrE+S1B1cp5oGIhxsa60K2lt9If1H94ULtHt2dh99NXARdysxE+g9O+hGDXVXu1UeVFn8+2mlljXTDe4kC0wOYT3uunEplIetFTVHZ9f5gtbwYFiKWR8j2n5VZpSHG6p7i2Ebmt3179jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418808; c=relaxed/simple;
	bh=+Wr2JHLDAdqSQOdJXgdj0aLxFpj+xU56ZnNePILVH1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lI9X6M8BK3+yxmfrxU6LzHrUk5PNA95Q5xkU0SH5iJEoZb0jObFGx+KYq2ax1Xk02CDUfmLtlBUhnW5JcaC7s1eiJ1H2LsQE3NUt2H9OlV7+E9TAem58zPVYZ1GLTEclJtDF3VTHXG4rYXgxlGslSWOvSByEVpTEsCC2r6ZzuYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so227929166b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Oct 2025 08:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759418804; x=1760023604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQtdUQWucLO0DCJsaLkokI5pGITgscy1HOM+9oBHcHM=;
        b=npBaCoaWLqcU7Ia1mLDARpGqDqsGflwbVEvwP2+4LyW1IWqykTLkaCn/z4SaaR+0F+
         ozUOyF9xAWymooefTJf72hZe7UnG80rda4NxJWxvGjm7ZFysvxTTkvfez49Vk8KStb0o
         OKtiEqhNVs19Ex7rY04K0lTAarb+X7RB/o66JkOU31Kxd3UVcbwsv2mE9h6Nv+0H5+07
         Qjk7S/BP1vAP69p5aX39p+OoLrU4hw7O/sQlZIRkx7TgiGCmmI8zevyht3ODSz6cauCT
         MxOHTa38xoN9yR5StaGJXgoIE7/AcgRECnJtQ8HjPOapE4MoYKGuYOPKJE4uv/qHpJmN
         Diew==
X-Forwarded-Encrypted: i=1; AJvYcCVQm3yGthvlIw/kbki2+m5oBW0MwaJPy0SSyPPEvokqO1FhLxResJUcphcM3TzAwHj0bgUZt7p+1iGZ5P7rEoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyufpSt4ZFSn5wzkRlYd5Hn7Zn86VH27rW7ybcsjwyWfyjLvvE1
	7/KxqzxrIkawoJtREA2He0DZSyo1vPCJol6Xpvm38YKz2rM98zhRt0I+
X-Gm-Gg: ASbGncsOFpchvp0+qOtoPAeQcZWUu+OsCKx90YTzJFjeVhjGj/Qfm0b0sUa+6sjkd3o
	fSzeZb4MQsmjhOsmDuzo0f03tMmdey3zjUMzrloYkNEDSxkXZozxkLlOWqEfFUt/bFfdz7wbNuM
	Ximg5kUouPNhT4m/4XjwIdHaPN5qqGI73vQ9SMdAGIpLrx1tFKGSLjHDD53OY+26ZoX4BuweNgE
	hmKgkpgrfT1g2uRkCXMoDz1U7BBYo6g+KuF1Q9sMR9GIB7P+5l64ag0wof3QG53fWHI8wV9QOyL
	0/OOBA8G9su1wHa8M/HYwBhoLSiV/SfvmK/3NcNyLjRgdExGQaPxmypnvYUpvOSHBUesXOw0M6f
	KVCwZvIqyd+YDSBA/0Vk0l+rboQATWEwOjJwmEHHjHjD+f6w=
X-Google-Smtp-Source: AGHT+IEVmG9H+TlJ1ZzoqVnIhnhEwG6cD6EP4xCjqOwLody3wdin4IVdMCnuils1S0EyiXJS2OJ2Eg==
X-Received: by 2002:a17:907:25c5:b0:b41:e675:95cd with SMTP id a640c23a62f3a-b46e4b8ec0emr979506866b.13.1759418803742;
        Thu, 02 Oct 2025 08:26:43 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a177c62sm225916966b.91.2025.10.02.08.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:26:43 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Oct 2025 08:26:28 -0700
Subject: [PATCH net v6 4/4] selftest: netcons: add test for netconsole over
 bonded interfaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-netconsole_torture-v6-4-543bf52f6b46@debian.org>
References: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
In-Reply-To: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=19187; i=leitao@debian.org;
 h=from:subject:message-id; bh=+Wr2JHLDAdqSQOdJXgdj0aLxFpj+xU56ZnNePILVH1g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo3pms4sv0tUm7YcpAzRFBCnxXgjt/XLTfthy1L
 bxhTPol5r+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaN6ZrAAKCRA1o5Of/Hh3
 bTNPEACLkAFfwMW7+cSaYlK3bNE2soxKgazao3s/SN9ltyvy/514w1eEqnL5gHE981+nYOGt9Tn
 dJdDglbCcRLkNZ88reiUl/Ev9NJVmezdmriWES46PM24mDYz9NpicyGje8YgshHH/1ZO3pXAtP6
 ifM610uJ236Jzskvx7CUUmfyRoSkr+SMar74qBhPt/v9vzj0GXhiizYqtRiXjKiFEdVfY8/u+VZ
 T7N7oc4u5dQCG8ge8GMWu/1UEYF7hrz/9QGNDGqmTfp3vQASJGR7kClH/1oOAAiieytLWEnb61P
 4+CV4EzESQh75VUskqFIdQcshMrhBa9rlHxpIJimQ0RDKSNeMC+RFxdjSVSHX7e01GWQ+SUtmSX
 s6rWFKQOCROSzQXlVlMWyiHa2YxtdFVcwBi0Q+qGBETM/A3FUJMYKj9GiSQMNRbNx2AntyxmxX/
 ulm9wSFBip0iIGziBhNk772mdu35KT9glxtV9r/K8AsgaS/pccaIk6RspqbAfGjZW2KiTYai75r
 PxzxBN2c8S8gpbgijgB2FPWC4Cb3XcGwNvnpTV0wdnh0GxivsbWNNoqbEUUsOBca5nxn9eujBNL
 1tqm1pt08ZEET0fyy0FF1NmAGoDsqrmLxUOpTyWkLW5YRZmbwnZs5ifFXNC9nUi9DPMUxbsL9Oy
 oGmmYp/6tRD6dsg==
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
---
 tools/testing/selftests/drivers/net/bonding/Makefile                |   2 ++
 tools/testing/selftests/drivers/net/bonding/config                  |   4 ++++
 tools/testing/selftests/drivers/net/bonding/netcons_over_bonding.sh | 221 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh           | 159 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 379 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 2f095cf67d9a0..691e0bef4244c 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -8,6 +8,7 @@ TEST_PROGS := \
 	dev_addr_lists.sh \
 	mode-1-recovery-updelay.sh \
 	mode-2-recovery-updelay.sh \
+	netcons_over_bonding.sh \
 	bond_options.sh \
 	bond-eth-type-change.sh \
 	bond_macvlan_ipvlan.sh \
@@ -21,6 +22,7 @@ TEST_FILES := \
 	bond_topo_3d1c.sh
 
 TEST_INCLUDES := \
+	../lib/sh/lib_netcons.sh \
 	../../../net/forwarding/lib.sh \
 	../../../net/lib.sh
 
diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index e5b7a8db4dfa3..5adc77d3808e1 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -1,5 +1,6 @@
 CONFIG_BONDING=y
 CONFIG_BRIDGE=y
+CONFIG_CONFIGFS_FS=y
 CONFIG_DUMMY=y
 CONFIG_IPV6=y
 CONFIG_MACVLAN=y
@@ -8,6 +9,9 @@ CONFIG_NET_ACT_GACT=y
 CONFIG_NET_CLS_FLOWER=y
 CONFIG_NET_CLS_MATCHALL=m
 CONFIG_NET_SCH_INGRESS=y
+CONFIG_NETCONSOLE=m
+CONFIG_NETCONSOLE_DYNAMIC=y
+CONFIG_NETCONSOLE_EXTENDED_LOG=y
 CONFIG_NLMON=y
 CONFIG_VETH=y
 CONFIG_VLAN_8021Q=m
diff --git a/tools/testing/selftests/drivers/net/bonding/netcons_over_bonding.sh b/tools/testing/selftests/drivers/net/bonding/netcons_over_bonding.sh
new file mode 100755
index 0000000000000..c550c906bf021
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/netcons_over_bonding.sh
@@ -0,0 +1,221 @@
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
+# Later, run a few other tests, to make sure that bonding and netconsole cannot
+# coexist.
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
+
+function create_all_ifaces() {
+	# setup_ns function is coming from lib.sh
+	setup_ns NAMESPACE
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
+	configure_ip
+}
+
+function enable_netpoll_on_enslaved_iface() {
+	echo 0 > "${NETCONS_PATH}"/enabled
+
+	# At this stage, BOND_TX1_SLAVE_IF is enslaved to BOND_TX_MAIN_IF, and
+	# linked to BOND_RX1_SLAVE_IF inside the namespace.
+	echo "${BOND_TX1_SLAVE_IF}" > "${NETCONS_PATH}"/dev_name
+
+	# This should fail with the following message in dmesg:
+	# netpoll: netconsole: ethX is a slave device, aborting
+	set +e
+	echo 1 > "${NETCONS_PATH}"/enabled
+	set -e
+
+	if [[ $(cat "${NETCONS_PATH}"/enabled) -eq 1 ]]
+	then
+		echo "test failed: Bonding and netpoll cannot co-exists." >&2
+		exit "${ksft_fail}"
+	fi
+}
+
+function delete_bond_and_reenable_target() {
+	ip link delete "${BOND_TX_MAIN_IF}" type bond
+
+	# BOND_TX1_SLAVE_IF is not attached to a bond interface anymore
+	# netpoll can be plugged in there
+	echo "${BOND_TX1_SLAVE_IF}" > "${NETCONS_PATH}"/dev_name
+
+	# this should work, since the interface is not enslaved
+	echo 1 > "${NETCONS_PATH}"/enabled
+
+	if [[ $(cat "${NETCONS_PATH}"/enabled) -eq 0 ]]
+	then
+		echo "test failed: Unable to start netpoll on an unbond iface." >&2
+		exit "${ksft_fail}"
+	fi
+}
+
+# Send a netconsole message to the netconsole target
+function send_netcons_msg_through_bond_iface() {
+	# Listen for netconsole port inside the namespace and
+	# destination interface
+	listen_port_and_save_to "${OUTPUT_FILE}" "${IP_VERSION}" &
+	# Wait for socat to start and listen to the port.
+	wait_for_port "${NAMESPACE}" "${PORT}" "${IP_VERSION}"
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
+function enslave_netcons_enabled_iface {
+	# netconsole got disabled while the interface was down
+	if [[ $(cat "${NETCONS_PATH}"/enabled) -eq 0 ]]
+	then
+		echo "test failed: netconsole expected to be enabled against BOND_TX1_SLAVE_IF" >&2
+		exit "${ksft_fail}"
+	fi
+
+	# recreate the bonding iface. it got deleted by previous
+	# test (delete_bond_and_reenable_target)
+	ip link add "${BOND_TX_MAIN_IF}" type bond mode balance-rr
+
+	# sub-interface need to be down before attaching to bonding
+	# This will also disable netconsole.
+	ip link set "${BOND_TX1_SLAVE_IF}" down
+	ip link set "${BOND_TX1_SLAVE_IF}" master "${BOND_TX_MAIN_IF}"
+	ip link set "${BOND_TX_MAIN_IF}" up
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
+function enslave_iface_to_bond {
+	# BOND_TX_MAIN_IF has only BOND_TX1_SLAVE_IF right now
+	echo "${BOND_TX_MAIN_IF}" > "${NETCONS_PATH}"/dev_name
+	echo 1 > "${NETCONS_PATH}"/enabled
+
+	# netcons is attached to bond0 and BOND_TX1_SLAVE_IF is
+	# part of BOND_TX_MAIN_IF. Attach BOND_TX2_SLAVE_IF to BOND_TX_MAIN_IF.
+	ip link set "${BOND_TX2_SLAVE_IF}" master "${BOND_TX_MAIN_IF}"
+	if [[ $(cat "${NETCONS_PATH}"/enabled) -eq 0 ]]
+	then
+		echo "test failed: Netconsole should be enabled on bonding interface. Failed" >&2
+		exit "${ksft_fail}"
+	fi
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
+# First test send a msg through bonding
+export DSTIF="${BOND_RX_MAIN_IF}"
+export SRCIF="${BOND_TX_MAIN_IF}"
+
+# Configure the ips as BOND_RX1_SLAVE_IF and BOND_TX1_SLAVE_IF
+configure_ifaces_ips "${IP_VERSION}"
+create_dynamic_target "${FORMAT}"
+set_user_data
+
+# Test #1 : Create an bonding interface and attach netpoll into
+# the bonding interface. Netconsole/netpoll should work on
+# the bonding interface.
+send_netcons_msg_through_bond_iface
+echo "test #1: netpoll on bonding interface worked. Test passed" >&2
+
+# Test #2: Attach netpoll to an enslaved interface
+# Try to attach netpoll to an enslaved sub-interface (while still being part of
+# a bonding interface), which shouldn't be allowed
+enable_netpoll_on_enslaved_iface
+echo "test #2: netpoll correctly rejected enslaved interface (expected behavior). Test passed." >&2
+
+# Test #3: Unplug the sub-interface from bond and enable netconsole
+# Detach the interface from a bonding interface and attach netpoll again
+delete_bond_and_reenable_target
+echo "test #3: Able to attach to an unbound interface. Test passed." >&2
+
+# Test #4: Enslave a sub-interface that had netconsole enabled
+# Try to enslave an interface that has netconsole/netpoll enabled.
+# Previous test has netconsole enabled in BOND_TX1_SLAVE_IF, try to enslave it
+enslave_netcons_enabled_iface
+echo "test #4: Enslaving an interface with netpoll attached. Test passed." >&2
+
+# Test #5: Enslave a sub-interface to a bonding interface
+# Enslave an interface to a bond interface that has netpoll attached
+# At this stage, BOND_TX_MAIN_IF is created and BOND_TX1_SLAVE_IF is part of
+# it. Netconsole is currently disabled
+enslave_iface_to_bond
+echo "test #5: Enslaving an interface to bond+netpoll. Test passed." >&2
+
+cleanup_bond
+trap - EXIT
+exit "${EXIT_STATUS}"
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 9b5ef8074440c..73f7505726a77 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -28,17 +28,24 @@ NETCONS_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
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
+NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
 
 # Used to create and delete namespaces
 source "${LIBDIR}"/../../../../net/lib.sh
 
 # Create netdevsim interfaces
 create_ifaces() {
-
 	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_NEW"
 	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_NEW"
 	udevadm settle 2> /dev/null || true
@@ -54,7 +61,6 @@ create_ifaces() {
 }
 
 link_ifaces() {
-	local NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
 	local SRCIF_IFIDX=$(cat /sys/class/net/"$SRCIF"/ifindex)
 	local DSTIF_IFIDX=$(cat /sys/class/net/"$DSTIF"/ifindex)
 
@@ -96,6 +102,33 @@ function select_ipv4_or_ipv6()
 	fi
 }
 
+# Create 4 netdevsim interfaces. Two of them will be bound to TX bonding iface
+# and the other two will be bond to the RX interface (on the other namespace)
+function create_ifaces_bond() {
+	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_NEW"
+	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_NEW"
+	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_NEW"
+	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_NEW"
+	udevadm settle 2> /dev/null || true
+
+	local BOND_TX1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_TX_1"
+	local BOND_TX2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_TX_2"
+	local BOND_RX1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_RX_1"
+	local BOND_RX2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_RX_2"
+
+	# TX
+	BOND_TX1_SLAVE_IF=$(find "$BOND_TX1"/net -maxdepth 1 -type d ! \
+		-path "$BOND_TX1"/net -exec basename {} \; | grep -v net)
+	BOND_TX2_SLAVE_IF=$(find "$BOND_TX2"/net -maxdepth 1 -type d ! \
+		-path "$BOND_TX2"/net -exec basename {} \; | grep -v net)
+
+	# RX
+	BOND_RX1_SLAVE_IF=$(find "$BOND_RX1"/net -maxdepth 1 -type d ! \
+		-path "$BOND_RX1"/net -exec basename {} \; | grep -v net)
+	BOND_RX2_SLAVE_IF=$(find "$BOND_RX2"/net -maxdepth 1 -type d ! \
+		-path "$BOND_RX2"/net -exec basename {} \; | grep -v net)
+}
+
 function set_network() {
 	local IP_VERSION=${1:-"ipv4"}
 
@@ -180,8 +213,6 @@ function disable_release_append() {
 }
 
 function do_cleanup() {
-	local NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
-
 	# Delete netdevsim devices
 	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_DEL"
 	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_DEL"
@@ -193,14 +224,26 @@ function do_cleanup() {
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
 
@@ -377,3 +420,105 @@ function wait_for_port() {
 	# more frequently on IPv6
 	sleep 1
 }
+
+# netdevsim link BOND_TX to BOND_RX interfaces
+function link_ifaces_bond() {
+	# local BOND_TX1_SLAVE_IFIDX
+	# local BOND_TX2_SLAVE_IFIDX
+	# local BOND_RX1_SLAVE_IFIDX
+	# local BOND_RX2_SLAVE_IFIDX
+
+	BOND_TX1_SLAVE_IFIDX=$(cat /sys/class/net/"$BOND_TX1_SLAVE_IF"/ifindex)
+	BOND_TX2_SLAVE_IFIDX=$(cat /sys/class/net/"$BOND_TX2_SLAVE_IF"/ifindex)
+	BOND_RX1_SLAVE_IFIDX=$(cat /sys/class/net/"$BOND_RX1_SLAVE_IF"/ifindex)
+	BOND_RX2_SLAVE_IFIDX=$(cat /sys/class/net/"$BOND_RX2_SLAVE_IF"/ifindex)
+
+	exec {NAMESPACE_FD}</var/run/netns/"${NAMESPACE}"
+	exec {INITNS_FD}</proc/self/ns/net
+
+	# Bind the dst interfaces to namespace
+	ip link set "${BOND_RX1_SLAVE_IF}" netns "${NAMESPACE}"
+	ip link set "${BOND_RX2_SLAVE_IF}" netns "${NAMESPACE}"
+
+	# Linking TX ifaces to the RX ones (on the other namespace)
+	echo "${INITNS_FD}:$BOND_TX1_SLAVE_IFIDX $NAMESPACE_FD:$BOND_RX1_SLAVE_IFIDX"  \
+		> "$NSIM_DEV_SYS_LINK"
+	echo "${INITNS_FD}:$BOND_TX2_SLAVE_IFIDX $NAMESPACE_FD:$BOND_RX2_SLAVE_IFIDX"  \
+		> "$NSIM_DEV_SYS_LINK"
+}
+
+# Create "bond_tx_XX" and "bond_rx_XX" interfaces, and set DSTIF and SRCIF with
+# the bonding interfaces
+function setup_bonding_ifaces() {
+	local RAND=$(( RANDOM % 100 ))
+	BOND_TX_MAIN_IF="bond_tx_$RAND"
+	BOND_RX_MAIN_IF="bond_rx_$RAND"
+
+	if ! ip link add "${BOND_TX_MAIN_IF}" type bond mode balance-rr
+	then
+		echo "Failed to create bond TX interface. Is CONFIG_BONDING set?" >&2
+		# only clean nsim ifaces and namespace. Nothing else has been
+		# initialized
+		cleanup_bond_nsim
+		trap - EXIT
+		exit "${ksft_skip}"
+	fi
+	ip link set "${BOND_TX1_SLAVE_IF}" down
+	ip link set "${BOND_TX2_SLAVE_IF}" down
+
+	ip link set "${BOND_TX1_SLAVE_IF}" master "${BOND_TX_MAIN_IF}"
+	ip link set "${BOND_TX2_SLAVE_IF}" master "${BOND_TX_MAIN_IF}"
+	ip link set "${BOND_TX_MAIN_IF}" up
+
+	# now create the RX bonding iface
+	ip netns exec "${NAMESPACE}" \
+		ip link add "${BOND_RX_MAIN_IF}" type bond mode balance-rr
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX1_SLAVE_IF}" down
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX2_SLAVE_IF}" down
+
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX1_SLAVE_IF}" master "${BOND_RX_MAIN_IF}"
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX2_SLAVE_IF}" master "${BOND_RX_MAIN_IF}"
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX_MAIN_IF}" up
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX1_SLAVE_IF}" up
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX2_SLAVE_IF}" up
+
+}
+
+# Clean up netdevsim ifaces created for bonding test
+function cleanup_bond_nsim() {
+	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_DEL"
+	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_DEL"
+	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_DEL"
+	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_DEL"
+	cleanup_all_ns
+}
+
+# cleanup tests that use bonding interfaces
+function cleanup_bond() {
+	cleanup_netcons
+
+	# Delete TX ifaces
+	ip link set "${BOND_TX_MAIN_IF}" down  2> /dev/null || true
+	ip link set "${BOND_TX1_SLAVE_IF}" down || true
+	ip link set "${BOND_TX2_SLAVE_IF}" down || true
+	ip link delete "${BOND_TX_MAIN_IF}" type bond  2> /dev/null || true
+
+	# Delete RX ifaces
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX_MAIN_IF}" down || true
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX1_SLAVE_IF}" down || true
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX2_SLAVE_IF}" down || true
+	ip netns exec "${NAMESPACE}" \
+		ip link delete "${BOND_RX_MAIN_IF}" type bond  || true
+
+	cleanup_bond_nsim
+}

-- 
2.47.3


