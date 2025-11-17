Return-Path: <linux-kselftest+bounces-45791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DD1C662F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74B294ED76C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 20:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA55C34D4E7;
	Mon, 17 Nov 2025 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAKI9sn5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809DB34D4E3;
	Mon, 17 Nov 2025 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413121; cv=none; b=hMcyx1/PbGnDBy0hZE3Pl1yHp1qYWYxMtkD5EPhcw4N4x1zZrWmNDuWrJ5s9YXcCs4K3pcfEbIvhG3yr27jfVt1xPbUAlQdSojKcrk8gsUffq1H4IYUafppeXFflOnkoR1wiYFk++RoAw0Vtc7gX8gXY8UygCFMYESRuHkpPV9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413121; c=relaxed/simple;
	bh=0IBpu4tlNj/zrPQfzv/iM6HJf3NxdKfLBgodHN9HIYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaNtgiLQkY2/6bVwYeCrx5CjLcZPxJ7EuszjgNkh+g729b42BWsRUHNCn3SMRoOkHR9i3NYZAP4wsgJmJ09hcWT2kCUfofbs7LxJwvu+BZBlfgBkx5AqXQSXw9fWZ9LcGgtod5cLZE52jo/zuODg0kd0UuQuxS01ap0Z7srXT5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAKI9sn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E593C2BCB1;
	Mon, 17 Nov 2025 20:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763413121;
	bh=0IBpu4tlNj/zrPQfzv/iM6HJf3NxdKfLBgodHN9HIYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cAKI9sn5l44I3SbJepXN5GTgps856de991NuI4w0hc9Bn+Mby39roNJ0zXnNwJJi3
	 SNtnvaHEG5/Tujlw5eNQaqn52uH+KWscVC3INTQhhgWVm9EzJyRK2/Mj/ISJVXXc3n
	 Ct5F7zQ841EJwXnM5wiAEtsuQe6pZBS9HNqSdOFz/QUObsnGFWPSMHaZx/uuoOeTrT
	 9vnZ1/w8AYmq0toUSOHKMBeboAlEACWJHzALhOUFBGtgixSraI1J0B6ph2G8ZlyqD7
	 GYpgfds+Xy9c98ObgD0WlaYJjpnSahnXUlpGYvkjb5Qh+zYSSScWqI7PZQ1x26dIW8
	 y9MYqUj+Pgb9w==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 10/12] selftests: drv-net: hw: convert the Toeplitz test to Python
Date: Mon, 17 Nov 2025 12:58:08 -0800
Message-ID: <20251117205810.1617533-11-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117205810.1617533-1-kuba@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite the existing toeplitz.sh test in Python. The conversion
is a lot less exact than the GRO one. We use Netlink APIs to
get the device RSS and IRQ information. We expect that the device
has neither RPS nor RFS configure, and set RPS up as part of
the test.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../testing/selftests/drivers/net/hw/Makefile |   3 +-
 .../selftests/drivers/net/hw/toeplitz.c       |   5 +
 .../selftests/drivers/net/hw/toeplitz.py      | 208 ++++++++++++++++++
 .../selftests/drivers/net/hw/toeplitz.sh      | 199 -----------------
 .../drivers/net/hw/toeplitz_client.sh         |  28 ---
 5 files changed, 214 insertions(+), 229 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/toeplitz.py
 delete mode 100755 tools/testing/selftests/drivers/net/hw/toeplitz.sh
 delete mode 100755 tools/testing/selftests/drivers/net/hw/toeplitz_client.sh

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index c9dced8c934a..1760238e9d4f 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -24,14 +24,13 @@ TEST_PROGS = \
 	rss_ctx.py \
 	rss_flow_label.py \
 	rss_input_xfrm.py \
-	toeplitz.sh \
+	toeplitz.py \
 	tso.py \
 	xsk_reconfig.py \
 	#
 
 TEST_FILES := \
 	ethtool_lib.sh \
-	toeplitz_client.sh \
 	#
 
 TEST_INCLUDES := \
diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.c b/tools/testing/selftests/drivers/net/hw/toeplitz.c
index bf74aa25345d..afc5f910b006 100644
--- a/tools/testing/selftests/drivers/net/hw/toeplitz.c
+++ b/tools/testing/selftests/drivers/net/hw/toeplitz.c
@@ -53,6 +53,7 @@
 #include <unistd.h>
 
 #include "../../../kselftest.h"
+#include "../../../net/lib/ksft.h"
 
 #define TOEPLITZ_KEY_MIN_LEN	40
 #define TOEPLITZ_KEY_MAX_LEN	60
@@ -576,6 +577,10 @@ int main(int argc, char **argv)
 		fd_sink = setup_sink();
 
 	setup_rings();
+
+	/* Signal to test framework that we're ready to receive */
+	ksft_ready();
+
 	process_rings();
 	cleanup_rings();
 
diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.py b/tools/testing/selftests/drivers/net/hw/toeplitz.py
new file mode 100755
index 000000000000..34476c431e39
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/toeplitz.py
@@ -0,0 +1,208 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Toeplitz Rx hashing test:
+ - rxhash (the hash value calculation itself);
+ - RSS mapping from rxhash to rx queue;
+ - RPS mapping from rxhash to cpu.
+"""
+
+import glob
+import os
+import socket
+from lib.py import ksft_run, ksft_exit, ksft_pr
+from lib.py import NetDrvEpEnv, EthtoolFamily, NetdevFamily
+from lib.py import cmd, bkg, rand_port, defer
+from lib.py import ksft_in
+from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx, KsftFailEx
+
+
+def _check_rps_and_rfs_not_configured(cfg):
+    """Verify that RPS is not already configured."""
+
+    for rps_file in glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*/rps_cpus"):
+        with open(rps_file, "r", encoding="utf-8") as fp:
+            val = fp.read().strip()
+            if set(val) - {"0", ","}:
+                raise KsftSkipEx(f"RPS already configured on {rps_file}: {val}")
+
+    rfs_file = "/proc/sys/net/core/rps_sock_flow_entries"
+    with open(rfs_file, "r", encoding="utf-8") as fp:
+        val = fp.read().strip()
+        if val != "0":
+            raise KsftSkipEx(f"RFS already configured {rfs_file}: {val}")
+
+
+def _get_rss_key(cfg):
+    """
+    Read the RSS key from the device.
+    Return a string in the traditional %02x:%02x:%02x:.. format.
+    """
+
+    rss = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+    return ':'.join(f'{b:02x}' for b in rss["hkey"])
+
+
+def _get_cpu_for_irq(irq):
+    with open(f"/proc/irq/{irq}/smp_affinity_list", "r",
+              encoding="utf-8") as fp:
+        data = fp.read().strip()
+        if "," in data or "-" in data:
+            raise KsftFailEx(f"IRQ{irq} is not mapped to a single core: {data}")
+        return int(data)
+
+
+def _get_irq_cpus(cfg):
+    """
+    Read the list of IRQs for the device Rx queues.
+    """
+    queues = cfg.netnl.queue_get({"ifindex": cfg.ifindex}, dump=True)
+    napis = cfg.netnl.napi_get({"ifindex": cfg.ifindex}, dump=True)
+
+    # Remap into ID-based dicts
+    napis = {n["id"]: n for n in napis}
+    queues = {f"{q['type']}{q['id']}": q for q in queues}
+
+    cpus = []
+    for rx in range(9999):
+        name = f"rx{rx}"
+        if name not in queues:
+            break
+        cpus.append(_get_cpu_for_irq(napis[queues[name]["napi-id"]]["irq"]))
+
+    return cpus
+
+
+def _get_unused_cpus(cfg, count=2):
+    """
+    Get CPUs that are not used by Rx queues.
+    Returns a list of at least 'count' CPU numbers.
+    """
+
+    # Get CPUs used by Rx queues
+    rx_cpus = set(_get_irq_cpus(cfg))
+
+    # Get total number of CPUs
+    num_cpus = os.cpu_count()
+
+    # Find unused CPUs
+    unused_cpus = [cpu for cpu in range(num_cpus) if cpu not in rx_cpus]
+
+    if len(unused_cpus) < count:
+        raise KsftSkipEx(f"Need at {count} CPUs not used by Rx queues, found {len(unused_cpus)}")
+
+    return unused_cpus[:count]
+
+
+def _configure_rps(cfg, rps_cpus):
+    """Configure RPS for all Rx queues."""
+
+    mask = 0
+    for cpu in rps_cpus:
+        mask |= (1 << cpu)
+    mask = hex(mask)[2:]
+
+    # Set RPS bitmap for all rx queues
+    for rps_file in glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*/rps_cpus"):
+        cmd(f"echo {mask} > {rps_file}", shell=True)
+
+    return mask
+
+
+def _send_traffic(cfg, proto_flag, ipver, port):
+    """Send 20 packets of requested type."""
+
+    # Determine protocol and IP version for socat
+    if proto_flag == "-u":
+        proto = "UDP"
+    else:
+        proto = "TCP"
+
+    baddr = f"[{cfg.addr_v['6']}]" if ipver == "6" else cfg.addr_v["4"]
+
+    # Run socat in a loop to send traffic periodically
+    # Use sh -c with a loop similar to toeplitz_client.sh
+    socat_cmd = f"""
+    for i in `seq 20`; do
+        echo "msg $i" | socat -{ipver} -t 0.1 - {proto}:{baddr}:{port};
+        sleep 0.001;
+    done
+    """
+
+    cmd(socat_cmd, shell=True, host=cfg.remote)
+
+
+def _test_variants():
+    for grp in ["", "rss", "rps"]:
+        for l4 in ["tcp", "udp"]:
+            for l3 in ["4", "6"]:
+                name = f"{l4}_ipv{l3}"
+                if grp:
+                    name = f"{grp}_{name}"
+                yield KsftNamedVariant(name, "-" + l4[0], l3, grp)
+
+
+@ksft_variants(_test_variants())
+def test(cfg, proto_flag, ipver, grp):
+    """Run a single toeplitz test."""
+
+    cfg.require_ipver(ipver)
+
+    # Check that rxhash is enabled
+    ksft_in("receive-hashing: on", cmd(f"ethtool -k {cfg.ifname}").stdout)
+
+    port = rand_port(socket.SOCK_DGRAM)
+    key = _get_rss_key(cfg)
+
+    toeplitz_path = cfg.test_dir / "toeplitz"
+    rx_cmd = [
+        str(toeplitz_path),
+        "-" + ipver,
+        proto_flag,
+        "-d", str(port),
+        "-i", cfg.ifname,
+        "-k", key,
+        "-T", "1000",
+        "-s",
+        "-v"
+    ]
+
+    if grp:
+        _check_rps_and_rfs_not_configured(cfg)
+    if grp == "rss":
+        irq_cpus = ",".join([str(x) for x in _get_irq_cpus(cfg)])
+        rx_cmd += ["-C", irq_cpus]
+        ksft_pr(f"RSS using CPUs: {irq_cpus}")
+    elif grp == "rps":
+        # Get CPUs not used by Rx queues and configure them for RPS
+        rps_cpus = _get_unused_cpus(cfg, count=2)
+        rps_mask = _configure_rps(cfg, rps_cpus)
+        defer(_configure_rps, cfg, [])
+        rx_cmd += ["-r", rps_mask]
+        ksft_pr(f"RPS using CPUs: {rps_cpus}, mask: {rps_mask}")
+
+    # Run rx in background, it will exit once it has seen enough packets
+    with bkg(" ".join(rx_cmd), ksft_ready=True, exit_wait=True) as rx_proc:
+        while rx_proc.proc.poll() is None:
+            _send_traffic(cfg, proto_flag, ipver, port)
+
+    # Check rx result
+    ksft_pr("Receiver output:")
+    ksft_pr(rx_proc.stdout.strip().replace('\n', '\n# '))
+    if rx_proc.stderr:
+        ksft_pr(rx_proc.stderr.strip().replace('\n', '\n# '))
+
+
+def main() -> None:
+    """Ksft boilerplate main."""
+
+    with NetDrvEpEnv(__file__) as cfg:
+        cfg.ethnl = EthtoolFamily()
+        cfg.netnl = NetdevFamily()
+        ksft_run(cases=[test], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.sh b/tools/testing/selftests/drivers/net/hw/toeplitz.sh
deleted file mode 100755
index d236b666dd3b..000000000000
--- a/tools/testing/selftests/drivers/net/hw/toeplitz.sh
+++ /dev/null
@@ -1,199 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# extended toeplitz test: test rxhash plus, optionally, either (1) rss mapping
-# from rxhash to rx queue ('-rss') or (2) rps mapping from rxhash to cpu
-# ('-rps <rps_map>')
-#
-# irq-pattern-prefix can be derived from /sys/kernel/irq/*/action,
-# which is a driver-specific encoding.
-#
-# invoke as ./toeplitz.sh (-i <iface>) -u|-t -4|-6 \
-# [(-rss -irq_prefix <irq-pattern-prefix>)|(-rps <rps_map>)]
-
-source $(dirname $0)/../../../net/lib/setup_loopback.sh
-readonly SERVER_IP4="192.168.1.200/24"
-readonly SERVER_IP6="fda8::1/64"
-readonly SERVER_MAC="aa:00:00:00:00:02"
-
-readonly CLIENT_IP4="192.168.1.100/24"
-readonly CLIENT_IP6="fda8::2/64"
-readonly CLIENT_MAC="aa:00:00:00:00:01"
-
-PORT=8000
-KEY="$(</proc/sys/net/core/netdev_rss_key)"
-TEST_RSS=false
-RPS_MAP=""
-PROTO_FLAG=""
-IP_FLAG=""
-DEV="eth0"
-
-# Return the number of rxqs among which RSS is configured to spread packets.
-# This is determined by reading the RSS indirection table using ethtool.
-get_rss_cfg_num_rxqs() {
-	echo $(ethtool -x "${DEV}" |
-		grep -E [[:space:]]+[0-9]+:[[:space:]]+ |
-		cut -d: -f2- |
-		awk '{$1=$1};1' |
-		tr ' ' '\n' |
-		sort -u |
-		wc -l)
-}
-
-# Return a list of the receive irq handler cpus.
-# The list is ordered by the irqs, so first rxq-0 cpu, then rxq-1 cpu, etc.
-# Reads /sys/kernel/irq/ in order, so algorithm depends on
-# irq_{rxq-0} < irq_{rxq-1}, etc.
-get_rx_irq_cpus() {
-	CPUS=""
-	# sort so that irq 2 is read before irq 10
-	SORTED_IRQS=$(for i in /sys/kernel/irq/*; do echo $i; done | sort -V)
-	# Consider only as many queues as RSS actually uses. We assume that
-	# if RSS_CFG_NUM_RXQS=N, then RSS uses rxqs 0-(N-1).
-	RSS_CFG_NUM_RXQS=$(get_rss_cfg_num_rxqs)
-	RXQ_COUNT=0
-
-	for i in ${SORTED_IRQS}
-	do
-		[[ "${RXQ_COUNT}" -lt "${RSS_CFG_NUM_RXQS}" ]] || break
-		# lookup relevant IRQs by action name
-		[[ -e "$i/actions" ]] || continue
-		cat "$i/actions" | grep -q "${IRQ_PATTERN}" || continue
-		irqname=$(<"$i/actions")
-
-		# does the IRQ get called
-		irqcount=$(cat "$i/per_cpu_count" | tr -d '0,')
-		[[ -n "${irqcount}" ]] || continue
-
-		# lookup CPU
-		irq=$(basename "$i")
-		cpu=$(cat "/proc/irq/$irq/smp_affinity_list")
-
-		if [[ -z "${CPUS}" ]]; then
-			CPUS="${cpu}"
-		else
-			CPUS="${CPUS},${cpu}"
-		fi
-		RXQ_COUNT=$((RXQ_COUNT+1))
-	done
-
-	echo "${CPUS}"
-}
-
-get_disable_rfs_cmd() {
-	echo "echo 0 > /proc/sys/net/core/rps_sock_flow_entries;"
-}
-
-get_set_rps_bitmaps_cmd() {
-	CMD=""
-	for i in /sys/class/net/${DEV}/queues/rx-*/rps_cpus
-	do
-		CMD="${CMD} echo $1 > ${i};"
-	done
-
-	echo "${CMD}"
-}
-
-get_disable_rps_cmd() {
-	echo "$(get_set_rps_bitmaps_cmd 0)"
-}
-
-die() {
-	echo "$1"
-	exit 1
-}
-
-check_nic_rxhash_enabled() {
-	local -r pattern="receive-hashing:\ on"
-
-	ethtool -k "${DEV}" | grep -q "${pattern}" || die "rxhash must be enabled"
-}
-
-parse_opts() {
-	local prog=$0
-	shift 1
-
-	while [[ "$1" =~ "-" ]]; do
-		if [[ "$1" = "-irq_prefix" ]]; then
-			shift
-			IRQ_PATTERN="^$1-[0-9]*$"
-		elif [[ "$1" = "-u" || "$1" = "-t" ]]; then
-			PROTO_FLAG="$1"
-		elif [[ "$1" = "-4" ]]; then
-			IP_FLAG="$1"
-			SERVER_IP="${SERVER_IP4}"
-			CLIENT_IP="${CLIENT_IP4}"
-		elif [[ "$1" = "-6" ]]; then
-			IP_FLAG="$1"
-			SERVER_IP="${SERVER_IP6}"
-			CLIENT_IP="${CLIENT_IP6}"
-		elif [[ "$1" = "-rss" ]]; then
-			TEST_RSS=true
-		elif [[ "$1" = "-rps" ]]; then
-			shift
-			RPS_MAP="$1"
-		elif [[ "$1" = "-i" ]]; then
-			shift
-			DEV="$1"
-		else
-			die "Usage: ${prog} (-i <iface>) -u|-t -4|-6 \
-			     [(-rss -irq_prefix <irq-pattern-prefix>)|(-rps <rps_map>)]"
-		fi
-		shift
-	done
-}
-
-setup() {
-	setup_loopback_environment "${DEV}"
-
-	# Set up server_ns namespace and client_ns namespace
-	setup_macvlan_ns "${DEV}" $server_ns server \
-	"${SERVER_MAC}" "${SERVER_IP}"
-	setup_macvlan_ns "${DEV}" $client_ns client \
-	"${CLIENT_MAC}" "${CLIENT_IP}"
-}
-
-cleanup() {
-	cleanup_macvlan_ns $server_ns server $client_ns client
-	cleanup_loopback "${DEV}"
-}
-
-parse_opts $0 $@
-
-setup
-trap cleanup EXIT
-
-check_nic_rxhash_enabled
-
-# Actual test starts here
-if [[ "${TEST_RSS}" = true ]]; then
-	# RPS/RFS must be disabled because they move packets between cpus,
-	# which breaks the PACKET_FANOUT_CPU identification of RSS decisions.
-	eval "$(get_disable_rfs_cmd) $(get_disable_rps_cmd)" \
-	  ip netns exec $server_ns ./toeplitz "${IP_FLAG}" "${PROTO_FLAG}" \
-	  -d "${PORT}" -i "${DEV}" -k "${KEY}" -T 1000 \
-	  -C "$(get_rx_irq_cpus)" -s -v &
-elif [[ ! -z "${RPS_MAP}" ]]; then
-	eval "$(get_disable_rfs_cmd) $(get_set_rps_bitmaps_cmd ${RPS_MAP})" \
-	  ip netns exec $server_ns ./toeplitz "${IP_FLAG}" "${PROTO_FLAG}" \
-	  -d "${PORT}" -i "${DEV}" -k "${KEY}" -T 1000 \
-	  -r "0x${RPS_MAP}" -s -v &
-else
-	ip netns exec $server_ns ./toeplitz "${IP_FLAG}" "${PROTO_FLAG}" \
-	  -d "${PORT}" -i "${DEV}" -k "${KEY}" -T 1000 -s -v &
-fi
-
-server_pid=$!
-
-ip netns exec $client_ns ./toeplitz_client.sh "${PROTO_FLAG}" \
-  "${IP_FLAG}" "${SERVER_IP%%/*}" "${PORT}" &
-
-client_pid=$!
-
-wait "${server_pid}"
-exit_code=$?
-kill -9 "${client_pid}"
-if [[ "${exit_code}" -eq 0 ]]; then
-	echo "Test Succeeded!"
-fi
-exit "${exit_code}"
diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz_client.sh b/tools/testing/selftests/drivers/net/hw/toeplitz_client.sh
deleted file mode 100755
index 2fef34f4aba1..000000000000
--- a/tools/testing/selftests/drivers/net/hw/toeplitz_client.sh
+++ /dev/null
@@ -1,28 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# A simple program for generating traffic for the toeplitz test.
-#
-# This program sends packets periodically for, conservatively, 20 seconds. The
-# intent is for the calling program to kill this program once it is no longer
-# needed, rather than waiting for the 20 second expiration.
-
-send_traffic() {
-	expiration=$((SECONDS+20))
-	while [[ "${SECONDS}" -lt "${expiration}" ]]
-	do
-		if [[ "${PROTO}" == "-u" ]]; then
-			echo "msg $i" | nc "${IPVER}" -u -w 0 "${ADDR}" "${PORT}"
-		else
-			echo "msg $i" | nc "${IPVER}" -w 0 "${ADDR}" "${PORT}"
-		fi
-		sleep 0.001
-	done
-}
-
-PROTO=$1
-IPVER=$2
-ADDR=$3
-PORT=$4
-
-send_traffic
-- 
2.51.1


