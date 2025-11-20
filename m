Return-Path: <linux-kselftest+bounces-46046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 116A1C71C69
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 03:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 121262980A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 02:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACE728C5B1;
	Thu, 20 Nov 2025 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID31Bu94"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0322882D6;
	Thu, 20 Nov 2025 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604648; cv=none; b=aE9v2C4mg4cu7oDK+pJI/MYiMTd9pQ7xPFynreDNJuePetpQ1JuL76CTVZ8ubImQI2tauHJAPi7g1dLcJk0mdF/sZl9ptvoIhMKyfVnOyDHlJmoMGubuMMHZ95GuMLLWzIzWJxhVI42QvE3W5OGzpdo/QX/qfaV6aBRP8SqUCho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604648; c=relaxed/simple;
	bh=fQjR72c7Ysvtw/WrZPXQIGFvmQoSrRslJattzUJigsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3MDQ0q7DB8pzlfpgoP/GMDgvS7YYCzCXRXX62M9F6S+h97j1+Qie2zxkiO7lxlVSVZO5UHa7eFUTIIpnVDSOdxQSAr7eDYOOlHdPf7lR9hPsPPPiqt13FIqT+ptkIY55MZekegc75/ao5337AeJ7sH3dE9pAn364ZgBil0/kpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ID31Bu94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F2FC4CEF5;
	Thu, 20 Nov 2025 02:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763604647;
	bh=fQjR72c7Ysvtw/WrZPXQIGFvmQoSrRslJattzUJigsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ID31Bu94ZJSkGhEpNV65PI8666WnVpEDqJxan8FS2zeLLdGyPU8HCuHKjuTFRtg/B
	 W2FGa0v5ySuAiBt3d9nhtyhn7OciMMuj0Bzc/WCpVSJi0DPS+1C4kait/ixQCyTNQH
	 lHdIHReLlZffHDx5cJKZIFFJnq1S7mt6KwkU0wcMXD6GCsl6OLLAIn8X0DQGpb+9Jx
	 FSL45yw8mCx6jqlZwyEz3xu/MnLReZOxM5eazNaGjNNmYWPwxTEsNu6XpuutJgLfLC
	 6stsIFjdcJmL9p2zImcjrXHDXAjs2RM5klBTaPL6BALGVATd/rL6BBpuNBxffoP+p4
	 dCnWO2ZJJFT3A==
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
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 09/12] selftests: drv-net: add a Python version of the GRO test
Date: Wed, 19 Nov 2025 18:10:21 -0800
Message-ID: <20251120021024.2944527-10-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120021024.2944527-1-kuba@kernel.org>
References: <20251120021024.2944527-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite the existing gro.sh test in Python. The conversion
not exact, the changes are related to integrating the test
with our "remote endpoint" paradigm. The test now reads
the IP addresses from the user config. It resolves the MAC
address (including running over Layer 3 networks).

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - restore the comment about retries
 - move MTU changes to _setup() to handle all the config related
   stuff in that function
v2: https://lore.kernel.org/20251118215126.2225826-10-kuba@kernel.org
 - fix typo I -> It
v1: https://lore.kernel.org/20251117205810.1617533-10-kuba@kernel.org
---
 tools/testing/selftests/drivers/net/Makefile |   2 +-
 tools/testing/selftests/drivers/net/gro.c    |   3 +
 tools/testing/selftests/drivers/net/gro.py   | 164 +++++++++++++++++++
 tools/testing/selftests/drivers/net/gro.sh   | 105 ------------
 4 files changed, 168 insertions(+), 106 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/gro.py
 delete mode 100755 tools/testing/selftests/drivers/net/gro.sh

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 7083a8707c4e..f5c71d993750 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -11,7 +11,7 @@ TEST_GEN_FILES := \
 # end of TEST_GEN_FILES
 
 TEST_PROGS := \
-	gro.sh \
+	gro.py \
 	hds.py \
 	napi_id.py \
 	napi_threaded.py \
diff --git a/tools/testing/selftests/drivers/net/gro.c b/tools/testing/selftests/drivers/net/gro.c
index 9b9be0cf8f7f..995b492f5bcb 100644
--- a/tools/testing/selftests/drivers/net/gro.c
+++ b/tools/testing/selftests/drivers/net/gro.c
@@ -58,6 +58,7 @@
 #include <unistd.h>
 
 #include "../../kselftest.h"
+#include "../../net/lib/ksft.h"
 
 #define DPORT 8000
 #define SPORT 1500
@@ -1127,6 +1128,8 @@ static void gro_receiver(void)
 	set_timeout(rxfd);
 	bind_packetsocket(rxfd);
 
+	ksft_ready();
+
 	memset(correct_payload, 0, sizeof(correct_payload));
 
 	if (strcmp(testname, "data") == 0) {
diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
new file mode 100755
index 000000000000..ba83713bf7b5
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -0,0 +1,164 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+GRO (Generic Receive Offload) conformance tests.
+
+Validates that GRO coalescing works correctly by running the gro
+binary in different configurations and checking for correct packet
+coalescing behavior.
+
+Test cases:
+  - data: Data packets with same size/headers and correct seq numbers coalesce
+  - ack: Pure ACK packets do not coalesce
+  - flags: Packets with PSH, SYN, URG, RST flags do not coalesce
+  - tcp: Packets with incorrect checksum, non-consecutive seqno don't coalesce
+  - ip: Packets with different ECN, TTL, TOS, or IP options don't coalesce
+  - large: Packets larger than GRO_MAX_SIZE don't coalesce
+"""
+
+import os
+from lib.py import ksft_run, ksft_exit, ksft_pr
+from lib.py import NetDrvEpEnv, KsftXfailEx
+from lib.py import cmd, defer, bkg, ip
+from lib.py import ksft_variants
+
+
+def _resolve_dmac(cfg, ipver):
+    """
+    Find the destination MAC address remote host should use to send packets
+    towards the local host. It may be a router / gateway address.
+    """
+
+    attr = "dmac" + ipver
+    # Cache the response across test cases
+    if hasattr(cfg, attr):
+        return getattr(cfg, attr)
+
+    route = ip(f"-{ipver} route get {cfg.addr_v[ipver]}",
+               json=True, host=cfg.remote)[0]
+    gw = route.get("gateway")
+    # Local L2 segment, address directly
+    if not gw:
+        setattr(cfg, attr, cfg.dev['address'])
+        return getattr(cfg, attr)
+
+    # ping to make sure neighbor is resolved,
+    # bind to an interface, for v6 the GW is likely link local
+    cmd(f"ping -c1 -W0 -I{cfg.remote_ifname} {gw}", host=cfg.remote)
+
+    neigh = ip(f"neigh get {gw} dev {cfg.remote_ifname}",
+               json=True, host=cfg.remote)[0]
+    setattr(cfg, attr, neigh['lladdr'])
+    return getattr(cfg, attr)
+
+
+def _write_defer_restore(cfg, path, val, defer_undo=False):
+    with open(path, "r", encoding="utf-8") as fp:
+        orig_val = fp.read().strip()
+        if str(val) == orig_val:
+            return
+    with open(path, "w", encoding="utf-8") as fp:
+        fp.write(val)
+    if defer_undo:
+        defer(_write_defer_restore, cfg, path, orig_val)
+
+
+def _set_mtu_restore(dev, mtu, host):
+    if dev['mtu'] < mtu:
+        ip(f"link set dev {dev['ifname']} mtu {mtu}", host=host)
+        defer(ip, f"link set dev {dev['ifname']} mtu {dev['mtu']}", host=host)
+
+
+def _setup(cfg, test_name):
+    """ Setup hardware loopback mode for GRO testing. """
+
+    if not hasattr(cfg, "bin_remote"):
+        cfg.bin_local = cfg.test_dir / "gro"
+        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
+
+    # "large" test needs at least 4k MTU
+    if test_name == "large":
+        _set_mtu_restore(cfg.dev, 4096, None)
+        _set_mtu_restore(cfg.remote_dev, 4096, cfg.remote)
+
+    flush_path = f"/sys/class/net/{cfg.ifname}/gro_flush_timeout"
+    irq_path = f"/sys/class/net/{cfg.ifname}/napi_defer_hard_irqs"
+
+    _write_defer_restore(cfg, flush_path, "200000", defer_undo=True)
+    _write_defer_restore(cfg, irq_path, "10", defer_undo=True)
+
+    try:
+        # Disable TSO for local tests
+        cfg.require_nsim()  # will raise KsftXfailEx if not running on nsim
+
+        cmd(f"ethtool -K {cfg.ifname} gro on tso off")
+        cmd(f"ethtool -K {cfg.remote_ifname} gro on tso off", host=cfg.remote)
+    except KsftXfailEx:
+        pass
+
+def _gro_variants():
+    """Generator that yields all combinations of protocol and test types."""
+
+    for protocol in ["ipv4", "ipv6", "ipip"]:
+        for test_name in ["data", "ack", "flags", "tcp", "ip", "large"]:
+            yield protocol, test_name
+
+
+@ksft_variants(_gro_variants())
+def test(cfg, protocol, test_name):
+    """Run a single GRO test with retries."""
+
+    ipver = "6" if protocol[-1] == "6" else "4"
+    cfg.require_ipver(ipver)
+
+    _setup(cfg, test_name)
+
+    base_cmd_args = [
+        f"--{protocol}",
+        f"--dmac {_resolve_dmac(cfg, ipver)}",
+        f"--smac {cfg.remote_dev['address']}",
+        f"--daddr {cfg.addr_v[ipver]}",
+        f"--saddr {cfg.remote_addr_v[ipver]}",
+        f"--test {test_name}",
+        "--verbose"
+    ]
+    base_args = " ".join(base_cmd_args)
+
+    # Each test is run 6 times to deflake, because given the receive timing,
+    # not all packets that should coalesce will be considered in the same flow
+    # on every try.
+    max_retries = 6
+    for attempt in range(max_retries):
+        rx_cmd = f"{cfg.bin_local} {base_args} --rx --iface {cfg.ifname}"
+        tx_cmd = f"{cfg.bin_remote} {base_args} --iface {cfg.remote_ifname}"
+
+        fail_now = attempt >= max_retries - 1
+
+        with bkg(rx_cmd, ksft_ready=True, exit_wait=True,
+                 fail=fail_now) as rx_proc:
+            cmd(tx_cmd, host=cfg.remote)
+
+        if rx_proc.ret == 0:
+            return
+
+        ksft_pr(rx_proc.stdout.strip().replace('\n', '\n# '))
+        ksft_pr(rx_proc.stderr.strip().replace('\n', '\n# '))
+
+        if test_name == "large" and os.environ.get("KSFT_MACHINE_SLOW"):
+            ksft_pr(f"Ignoring {protocol}/{test_name} failure due to slow environment")
+            return
+
+        ksft_pr(f"Attempt {attempt + 1}/{max_retries} failed, retrying...")
+
+
+def main() -> None:
+    """ Ksft boiler plate main """
+
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run(cases=[test], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/gro.sh b/tools/testing/selftests/drivers/net/gro.sh
deleted file mode 100755
index bd3cf6d02eda..000000000000
--- a/tools/testing/selftests/drivers/net/gro.sh
+++ /dev/null
@@ -1,105 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-readonly SERVER_MAC="aa:00:00:00:00:02"
-readonly CLIENT_MAC="aa:00:00:00:00:01"
-readonly TESTS=("data" "ack" "flags" "tcp" "ip" "large")
-readonly PROTOS=("ipv4" "ipv6" "ipip")
-dev=""
-test="all"
-proto="ipv4"
-
-run_test() {
-  local server_pid=0
-  local exit_code=0
-  local protocol=$1
-  local test=$2
-  local ARGS=( "--${protocol}" "--dmac" "${SERVER_MAC}" \
-  "--smac" "${CLIENT_MAC}" "--test" "${test}" "--verbose" )
-
-  setup_ns
-  # Each test is run 6 times to deflake, because given the receive timing,
-  # not all packets that should coalesce will be considered in the same flow
-  # on every try.
-  for tries in {1..6}; do
-    # Actual test starts here
-    ip netns exec $server_ns ./gro "${ARGS[@]}" "--rx" "--iface" "server" \
-      1>>log.txt &
-    server_pid=$!
-    sleep 0.5  # to allow for socket init
-    ip netns exec $client_ns ./gro "${ARGS[@]}" "--iface" "client" \
-      1>>log.txt
-    wait "${server_pid}"
-    exit_code=$?
-    if [[ ${test} == "large" && -n "${KSFT_MACHINE_SLOW}" && \
-          ${exit_code} -ne 0 ]]; then
-        echo "Ignoring errors due to slow environment" 1>&2
-        exit_code=0
-    fi
-    if [[ "${exit_code}" -eq 0 ]]; then
-        break;
-    fi
-  done
-  cleanup_ns
-  echo ${exit_code}
-}
-
-run_all_tests() {
-  local failed_tests=()
-  for proto in "${PROTOS[@]}"; do
-    for test in "${TESTS[@]}"; do
-      echo "running test ${proto} ${test}" >&2
-      exit_code=$(run_test $proto $test)
-      if [[ "${exit_code}" -ne 0 ]]; then
-        failed_tests+=("${proto}_${test}")
-      fi;
-    done;
-  done
-  if [[ ${#failed_tests[@]} -ne 0 ]]; then
-    echo "failed tests: ${failed_tests[*]}. \
-    Please see log.txt for more logs"
-    exit 1
-  else
-    echo "All Tests Succeeded!"
-  fi;
-}
-
-usage() {
-  echo "Usage: $0 \
-  [-i <DEV>] \
-  [-t data|ack|flags|tcp|ip|large] \
-  [-p <ipv4|ipv6>]" 1>&2;
-  exit 1;
-}
-
-while getopts "i:t:p:" opt; do
-  case "${opt}" in
-    i)
-      dev="${OPTARG}"
-      ;;
-    t)
-      test="${OPTARG}"
-      ;;
-    p)
-      proto="${OPTARG}"
-      ;;
-    *)
-      usage
-      ;;
-  esac
-done
-
-if [ -n "$dev" ]; then
-	source $(dirname $0)/../../net/lib/setup_loopback.sh
-else
-	source $(dirname $0)/../../net/lib/setup_veth.sh
-fi
-
-setup
-trap cleanup EXIT
-if [[ "${test}" == "all" ]]; then
-  run_all_tests
-else
-  exit_code=$(run_test "${proto}" "${test}")
-  exit $exit_code
-fi;
-- 
2.51.1


