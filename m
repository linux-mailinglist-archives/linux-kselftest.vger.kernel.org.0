Return-Path: <linux-kselftest+bounces-45930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E72C6BC82
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 22:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8AE64EDE89
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 21:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9916F31ED8F;
	Tue, 18 Nov 2025 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQLsCOCL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D49230F801;
	Tue, 18 Nov 2025 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502734; cv=none; b=HC/yIvHGpN25ge6Ruxvl0aJGGW7jID+IKVYCFAiQlxUwosTPrrH7BYiOdHKfmIVVVIeNNvoElqYiPx1iHMNyNo2y/bw89wD0K1v/5yr7GrX+T0XbGvTsvYemrMkFl2xdfoHH4Ljc3uu8C1lfnSmSesj6ujtrbzUQpiP0ypwIDM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502734; c=relaxed/simple;
	bh=Glzre0rVJ+ceucmuK0IqptdBvaXhlLhJ4h/pLYOtp64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uy76s3YPomLhOeSE7oa2iYeW+Ox5N9aMZhpowP+x9n1DNqiZAIYH+8fgVvJPeORTtP8pyl1jiEjInWkCTy1yKPXh/JNzY2IeWJCrglQec8tykNSIq/BsbvH2w7766ltSOgXJVkpwRZbRJ+G9Z5IrBEvscGwYVlLavwrfi2aL+HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQLsCOCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C8DC4AF09;
	Tue, 18 Nov 2025 21:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763502734;
	bh=Glzre0rVJ+ceucmuK0IqptdBvaXhlLhJ4h/pLYOtp64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQLsCOCLrk0k/KItS9Mu216ttgyCV9bv6QO+6RO5QVia0udbvFf+wng7gkYGRD5TN
	 i/uGdn50u7SbgIykkfi1nKcnqw+19xtUTkIwkx1bVgF+JsHxdQsaXLolrq/zOuj/RS
	 yf10J5jQ+2VCRN8hMwNOcP8PckP/dyyIn5W+brW3mOp7/7pu3TpUPBWUAzvLly3emT
	 y1/rJnc4PWEr0i+lnLjRRspsx/9vZQ31nIkYmbnNVoGNRKfeS1JY+4wcLvqvAGKdr9
	 8mmIUF7yTK6VEV/zzGrr1Mj6Hm/As1mqbPBZDrrUVogYmvPH+JLVSPRTOMh4ZA15GE
	 PSlV8PEQZTXag==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	krakauer@google.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	matttbe@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 12/12] selftests: net: remove old setup_* scripts
Date: Tue, 18 Nov 2025 13:51:26 -0800
Message-ID: <20251118215126.2225826-13-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118215126.2225826-1-kuba@kernel.org>
References: <20251118215126.2225826-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gro.sh and toeplitz.sh used to source in two setup scripts
depending on whether the test was expected to be run against
veth or a real device. veth testing is replaced by netdevsim
and existing "remote endpoint" support in our Python tests.
Add a script which sets up loopback mode.

The usage is a little bit more complicated than running
the scripts used to be. Testing used to work like this:

  ./../gro.sh -i eth0 ...

now the "setup script" has to be run explicitly:

  NETIF=eth0 ./../ksft_setup_loopback.sh ./../gro.sh

But the functionality itself is retained.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/Makefile      |   3 +-
 .../selftests/net/lib/ksft_setup_loopback.sh  | 111 ++++++++++++++++
 .../selftests/net/lib/setup_loopback.sh       | 120 ------------------
 tools/testing/selftests/net/lib/setup_veth.sh |  45 -------
 4 files changed, 112 insertions(+), 167 deletions(-)
 create mode 100755 tools/testing/selftests/net/lib/ksft_setup_loopback.sh
 delete mode 100644 tools/testing/selftests/net/lib/setup_loopback.sh
 delete mode 100644 tools/testing/selftests/net/lib/setup_veth.sh

diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index c10796933d42..5339f56329e1 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -8,8 +8,7 @@ CFLAGS += -I../../
 TEST_FILES := \
 	../../../../net/ynl \
 	../../../../../Documentation/netlink/specs \
-	setup_loopback.sh \
-	setup_veth.sh \
+	ksft_setup_loopback.sh \
 # end of TEST_FILES
 
 TEST_GEN_FILES := \
diff --git a/tools/testing/selftests/net/lib/ksft_setup_loopback.sh b/tools/testing/selftests/net/lib/ksft_setup_loopback.sh
new file mode 100755
index 000000000000..3defbb1919c5
--- /dev/null
+++ b/tools/testing/selftests/net/lib/ksft_setup_loopback.sh
@@ -0,0 +1,111 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Setup script for running ksft tests over a real interface in loopback mode.
+# This scripts replaces the historical setup_loopback.sh. It puts
+# a (presumably) real hardware interface into loopback mode, creates macvlan
+# interfaces on top and places them in a network namespace for isolation.
+#
+# NETIF env variable must be exported to indicate the real target device.
+# Note that the test will override NETIF with one of the macvlans, the
+# actual ksft test will only see the macvlans.
+#
+# Example use:
+#   export NETIF=eth0
+#   ./net/lib/ksft_setup_loopback.sh ./drivers/net/gro.py
+
+if [ -z "$NETIF" ]; then
+    echo "Error: NETIF variable not set"
+    exit 1
+fi
+if ! [ -d "/sys/class/net/$NETIF" ]; then
+    echo "Error: Can't find $NETIF, invalid netdevice"
+    exit 1
+fi
+
+# Save original settings for cleanup
+readonly FLUSH_PATH="/sys/class/net/${NETIF}/gro_flush_timeout"
+readonly IRQ_PATH="/sys/class/net/${NETIF}/napi_defer_hard_irqs"
+FLUSH_TIMEOUT="$(< "${FLUSH_PATH}")"
+readonly FLUSH_TIMEOUT
+HARD_IRQS="$(< "${IRQ_PATH}")"
+readonly HARD_IRQS
+
+SERVER_NS=$(mktemp -u server-XXXXXXXX)
+readonly SERVER_NS
+CLIENT_NS=$(mktemp -u client-XXXXXXXX)
+readonly CLIENT_NS
+readonly SERVER_MAC="aa:00:00:00:00:02"
+readonly CLIENT_MAC="aa:00:00:00:00:01"
+
+# ksft expects addresses to communicate with remote
+export  LOCAL_V6=2001:db8:1::1
+export REMOTE_V6=2001:db8:1::2
+
+cleanup() {
+    local exit_code=$?
+
+    echo "Cleaning up..."
+
+    # Remove macvlan interfaces and namespaces
+    ip -netns "${SERVER_NS}" link del dev server 2>/dev/null || true
+    ip netns del "${SERVER_NS}" 2>/dev/null || true
+    ip -netns "${CLIENT_NS}" link del dev client 2>/dev/null || true
+    ip netns del "${CLIENT_NS}" 2>/dev/null || true
+
+    # Disable loopback
+    ethtool -K "${NETIF}" loopback off 2>/dev/null || true
+    sleep 1
+
+    echo "${FLUSH_TIMEOUT}" >"${FLUSH_PATH}"
+    echo "${HARD_IRQS}" >"${IRQ_PATH}"
+
+    exit $exit_code
+}
+
+trap cleanup EXIT INT TERM
+
+# Enable loopback mode
+echo "Enabling loopback on ${NETIF}..."
+ethtool -K "${NETIF}" loopback on || {
+    echo "Failed to enable loopback mode"
+    exit 1
+}
+# The interface may need time to get carrier back, but selftests
+# will wait for carrier, so no need to wait / sleep here.
+
+# Use timer on  host to trigger the network stack
+# Also disable device interrupt to not depend on NIC interrupt
+# Reduce test flakiness caused by unexpected interrupts
+echo 100000 >"${FLUSH_PATH}"
+echo 50 >"${IRQ_PATH}"
+
+# Create server namespace with macvlan
+ip netns add "${SERVER_NS}"
+ip link add link "${NETIF}" dev server address "${SERVER_MAC}" type macvlan
+ip link set dev server netns "${SERVER_NS}"
+ip -netns "${SERVER_NS}" link set dev server up
+ip -netns "${SERVER_NS}" addr add $LOCAL_V6/64 dev server
+ip -netns "${SERVER_NS}" link set dev lo up
+
+# Create client namespace with macvlan
+ip netns add "${CLIENT_NS}"
+ip link add link "${NETIF}" dev client address "${CLIENT_MAC}" type macvlan
+ip link set dev client netns "${CLIENT_NS}"
+ip -netns "${CLIENT_NS}" link set dev client up
+ip -netns "${CLIENT_NS}" addr add $REMOTE_V6/64 dev client
+ip -netns "${CLIENT_NS}" link set dev lo up
+
+echo "Setup complete!"
+echo "  Device: ${NETIF}"
+echo "  Server NS: ${SERVER_NS}"
+echo "  Client NS: ${CLIENT_NS}"
+echo ""
+
+# Setup environment variables for tests
+export NETIF=server
+export REMOTE_TYPE=netns
+export REMOTE_ARGS="${CLIENT_NS}"
+
+# Run the command
+ip netns exec "${SERVER_NS}" "$@"
diff --git a/tools/testing/selftests/net/lib/setup_loopback.sh b/tools/testing/selftests/net/lib/setup_loopback.sh
deleted file mode 100644
index 2070b57849de..000000000000
--- a/tools/testing/selftests/net/lib/setup_loopback.sh
+++ /dev/null
@@ -1,120 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-readonly FLUSH_PATH="/sys/class/net/${dev}/gro_flush_timeout"
-readonly IRQ_PATH="/sys/class/net/${dev}/napi_defer_hard_irqs"
-readonly FLUSH_TIMEOUT="$(< ${FLUSH_PATH})"
-readonly HARD_IRQS="$(< ${IRQ_PATH})"
-readonly server_ns=$(mktemp -u server-XXXXXXXX)
-readonly client_ns=$(mktemp -u client-XXXXXXXX)
-
-netdev_check_for_carrier() {
-	local -r dev="$1"
-
-	for i in {1..5}; do
-		carrier="$(cat /sys/class/net/${dev}/carrier)"
-		if [[ "${carrier}" -ne 1 ]] ; then
-			echo "carrier not ready yet..." >&2
-			sleep 1
-		else
-			echo "carrier ready" >&2
-			break
-		fi
-	done
-	echo "${carrier}"
-}
-
-# Assumes that there is no existing ipvlan device on the physical device
-setup_loopback_environment() {
-	local dev="$1"
-
-	# Fail hard if cannot turn on loopback mode for current NIC
-	ethtool -K "${dev}" loopback on || exit 1
-	sleep 1
-
-	# Check for the carrier
-	carrier=$(netdev_check_for_carrier ${dev})
-	if [[ "${carrier}" -ne 1 ]] ; then
-		echo "setup_loopback_environment failed"
-		exit 1
-	fi
-}
-
-setup_macvlan_ns(){
-	local -r link_dev="$1"
-	local -r ns_name="$2"
-	local -r ns_dev="$3"
-	local -r ns_mac="$4"
-	local -r addr="$5"
-
-	ip link add link "${link_dev}" dev "${ns_dev}" \
-		address "${ns_mac}" type macvlan
-	exit_code=$?
-	if [[ "${exit_code}" -ne 0 ]]; then
-		echo "setup_macvlan_ns failed"
-		exit $exit_code
-	fi
-
-	[[ -e /var/run/netns/"${ns_name}" ]] || ip netns add "${ns_name}"
-	ip link set dev "${ns_dev}" netns "${ns_name}"
-	ip -netns "${ns_name}" link set dev "${ns_dev}" up
-	if [[ -n "${addr}" ]]; then
-		ip -netns "${ns_name}" addr add dev "${ns_dev}" "${addr}"
-	fi
-
-	sleep 1
-}
-
-cleanup_macvlan_ns(){
-	while (( $# >= 2 )); do
-		ns_name="$1"
-		ns_dev="$2"
-		ip -netns "${ns_name}" link del dev "${ns_dev}"
-		ip netns del "${ns_name}"
-		shift 2
-	done
-}
-
-cleanup_loopback(){
-	local -r dev="$1"
-
-	ethtool -K "${dev}" loopback off
-	sleep 1
-
-	# Check for the carrier
-	carrier=$(netdev_check_for_carrier ${dev})
-	if [[ "${carrier}" -ne 1 ]] ; then
-		echo "setup_loopback_environment failed"
-		exit 1
-	fi
-}
-
-setup_interrupt() {
-	# Use timer on  host to trigger the network stack
-	# Also disable device interrupt to not depend on NIC interrupt
-	# Reduce test flakiness caused by unexpected interrupts
-	echo 100000 >"${FLUSH_PATH}"
-	echo 50 >"${IRQ_PATH}"
-}
-
-setup_ns() {
-	# Set up server_ns namespace and client_ns namespace
-	setup_macvlan_ns "${dev}" ${server_ns} server "${SERVER_MAC}"
-	setup_macvlan_ns "${dev}" ${client_ns} client "${CLIENT_MAC}"
-}
-
-cleanup_ns() {
-	cleanup_macvlan_ns ${server_ns} server ${client_ns} client
-}
-
-setup() {
-	setup_loopback_environment "${dev}"
-	setup_interrupt
-}
-
-cleanup() {
-	cleanup_loopback "${dev}"
-
-	echo "${FLUSH_TIMEOUT}" >"${FLUSH_PATH}"
-	echo "${HARD_IRQS}" >"${IRQ_PATH}"
-}
diff --git a/tools/testing/selftests/net/lib/setup_veth.sh b/tools/testing/selftests/net/lib/setup_veth.sh
deleted file mode 100644
index 152bf4c65747..000000000000
--- a/tools/testing/selftests/net/lib/setup_veth.sh
+++ /dev/null
@@ -1,45 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-readonly server_ns=$(mktemp -u server-XXXXXXXX)
-readonly client_ns=$(mktemp -u client-XXXXXXXX)
-
-setup_veth_ns() {
-	local -r link_dev="$1"
-	local -r ns_name="$2"
-	local -r ns_dev="$3"
-	local -r ns_mac="$4"
-
-	[[ -e /var/run/netns/"${ns_name}" ]] || ip netns add "${ns_name}"
-	echo 200000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
-	echo 1 > "/sys/class/net/${ns_dev}/napi_defer_hard_irqs"
-	ip link set dev "${ns_dev}" netns "${ns_name}" mtu 65535
-	ip -netns "${ns_name}" link set dev "${ns_dev}" up
-
-	ip netns exec "${ns_name}" ethtool -K "${ns_dev}" gro on tso off
-}
-
-setup_ns() {
-	# Set up server_ns namespace and client_ns namespace
-	ip link add name server type veth peer name client
-
-	setup_veth_ns "${dev}" ${server_ns} server "${SERVER_MAC}"
-	setup_veth_ns "${dev}" ${client_ns} client "${CLIENT_MAC}"
-}
-
-cleanup_ns() {
-	local ns_name
-
-	for ns_name in ${client_ns} ${server_ns}; do
-		[[ -e /var/run/netns/"${ns_name}" ]] && ip netns del "${ns_name}"
-	done
-}
-
-setup() {
-	# no global init setup step needed
-	:
-}
-
-cleanup() {
-	cleanup_ns
-}
-- 
2.51.1


