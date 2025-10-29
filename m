Return-Path: <linux-kselftest+bounces-44322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB46C1C807
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 18:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D33E643FD3
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1DE2848A8;
	Wed, 29 Oct 2025 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKwlFX0U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5B176FB1;
	Wed, 29 Oct 2025 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756572; cv=none; b=NCndAbGp2HBtAbX4tYH5c+v+ajg1bEijTfYbwPbU/y2JT8E/YHmz8u84HS9Jp8njbjE0opBSU7+V3qrpmAnK77n1A4XZwvHSTK8Pr+AhlNPRHi8XmdmCFPtKpS3C8kuaq8gxfczc7WmxLR1TouWq2qbm1Aj90enjnm1jnK/OcjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756572; c=relaxed/simple;
	bh=rhYRhUuBSlENWAjKgfd7BGOH0Spbe/wg1aHymUGStUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n12z4J32THFIiuXFp09etIpUue0iZQgsF8t/P2iw6xoX2Ep8QtjDBYUmRfxbZZWv6KvjtsHPKzfS2vSdByKT++57xb3J1sNMUbU/soXCyucX6OEhsCPxr99uZfvPIVS2embYlbnsWk++Sikj5M0CbGV2hET3UecDUHIeLHxwCc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKwlFX0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A9DC4CEF7;
	Wed, 29 Oct 2025 16:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761756572;
	bh=rhYRhUuBSlENWAjKgfd7BGOH0Spbe/wg1aHymUGStUI=;
	h=From:To:Cc:Subject:Date:From;
	b=EKwlFX0UnTghSaNOJ1dI4HCZhr3cL/96joGsABUYMnIwFdtjD1bVmnyYiNtNM/V7X
	 fvrnFp+MVCGnful8aKg9j8S0y+9q1WhZ6IDrrPZI6Wdcmo05xiN3mTy8UfM65mObi7
	 s2E0TMKbK2s5h+GVjB4pGxAiBV16zSuPCMl5WuB7u4S0/jCWYJnC9+dKyuWxnwsZQ/
	 e70aCSkggdx/zMBLamNd78ujmc7OcAKe3ZlLRYAEHY3xsB538k2J9FIw7sRyjGsMMy
	 xWL1ttlyi42sJ2KcQJIPxxPybC6ZmUGhQo5GQmWmAgDg32zUnMzt3BgCdp5Cnhe9/c
	 kIfuy3qyCfncA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3] selftests: drv-net: replace the nsim ring test with a drv-net one
Date: Wed, 29 Oct 2025 09:49:30 -0700
Message-ID: <20251029164930.2923448-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are trying to move away from netdevsim-only tests and towards
tests which can be run both against netdevsim and real drivers.

Replace the simple bash script we have for checking ethtool -g/-G
on netdevsim with a Python test tweaking those params as well
as channel count.

The new test is not exactly equivalent to the netdevsim one,
but real drivers don't often support random ring sizes,
let alone modifying max values via debugfs.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - let ring sizes fall all the way down to 0
v2: https://lore.kernel.org/20251027192131.2053792-1-kuba@kernel.org
 - add the new test to Makefile and remove the old one
   turns out NIPA checking for Makefile presence was busted
v1: https://lore.kernel.org/20251024215552.1249838-1-kuba@kernel.org

CC: andrew@lunn.ch
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 .../selftests/drivers/net/netdevsim/Makefile  |   1 -
 .../drivers/net/netdevsim/ethtool-ring.sh     |  85 ---------
 .../selftests/drivers/net/ring_reconfig.py    | 167 ++++++++++++++++++
 4 files changed, 168 insertions(+), 86 deletions(-)
 delete mode 100755 tools/testing/selftests/drivers/net/netdevsim/ethtool-ring.sh
 create mode 100755 tools/testing/selftests/drivers/net/ring_reconfig.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 6e41635bd55a..68e0bb603a9d 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -22,6 +22,7 @@ TEST_PROGS := \
 	ping.py \
 	psp.py \
 	queues.py \
+	ring_reconfig.py \
 	shaper.py \
 	stats.py \
 	xdp.py \
diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
index daf51113c827..833abd8e6fdc 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
+++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
@@ -8,7 +8,6 @@ TEST_PROGS := \
 	ethtool-features.sh \
 	ethtool-fec.sh \
 	ethtool-pause.sh \
-	ethtool-ring.sh \
 	fib.sh \
 	fib_notifications.sh \
 	hw_stats_l3.sh \
diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-ring.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-ring.sh
deleted file mode 100755
index c969559ffa7a..000000000000
--- a/tools/testing/selftests/drivers/net/netdevsim/ethtool-ring.sh
+++ /dev/null
@@ -1,85 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0-only
-
-source ethtool-common.sh
-
-function get_value {
-    local query="${SETTINGS_MAP[$1]}"
-
-    echo $(ethtool -g $NSIM_NETDEV | \
-        tail -n +$CURR_SETT_LINE | \
-        awk -F':' -v pattern="$query:" '$0 ~ pattern {gsub(/[\t ]/, "", $2); print $2}')
-}
-
-function update_current_settings {
-    for key in ${!SETTINGS_MAP[@]}; do
-        CURRENT_SETTINGS[$key]=$(get_value $key)
-    done
-    echo ${CURRENT_SETTINGS[@]}
-}
-
-if ! ethtool -h | grep -q set-ring >/dev/null; then
-    echo "SKIP: No --set-ring support in ethtool"
-    exit 4
-fi
-
-NSIM_NETDEV=$(make_netdev)
-
-set -o pipefail
-
-declare -A SETTINGS_MAP=(
-    ["rx"]="RX"
-    ["rx-mini"]="RX Mini"
-    ["rx-jumbo"]="RX Jumbo"
-    ["tx"]="TX"
-)
-
-declare -A EXPECTED_SETTINGS=(
-    ["rx"]=""
-    ["rx-mini"]=""
-    ["rx-jumbo"]=""
-    ["tx"]=""
-)
-
-declare -A CURRENT_SETTINGS=(
-    ["rx"]=""
-    ["rx-mini"]=""
-    ["rx-jumbo"]=""
-    ["tx"]=""
-)
-
-MAX_VALUE=$((RANDOM % $((2**32-1))))
-RING_MAX_LIST=$(ls $NSIM_DEV_DFS/ethtool/ring/)
-
-for ring_max_entry in $RING_MAX_LIST; do
-    echo $MAX_VALUE > $NSIM_DEV_DFS/ethtool/ring/$ring_max_entry
-done
-
-CURR_SETT_LINE=$(ethtool -g $NSIM_NETDEV | grep -i -m1 -n 'Current hardware settings' | cut -f1 -d:)
-
-# populate the expected settings map
-for key in ${!SETTINGS_MAP[@]}; do
-    EXPECTED_SETTINGS[$key]=$(get_value $key)
-done
-
-# test
-for key in ${!SETTINGS_MAP[@]}; do
-    value=$((RANDOM % $MAX_VALUE))
-
-    ethtool -G $NSIM_NETDEV "$key" "$value"
-
-    EXPECTED_SETTINGS[$key]="$value"
-    expected=${EXPECTED_SETTINGS[@]}
-    current=$(update_current_settings)
-
-    check $? "$current" "$expected"
-    set +x
-done
-
-if [ $num_errors -eq 0 ]; then
-    echo "PASSED all $((num_passes)) checks"
-    exit 0
-else
-    echo "FAILED $num_errors/$((num_errors+num_passes)) checks"
-    exit 1
-fi
diff --git a/tools/testing/selftests/drivers/net/ring_reconfig.py b/tools/testing/selftests/drivers/net/ring_reconfig.py
new file mode 100755
index 000000000000..f9530a8b0856
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/ring_reconfig.py
@@ -0,0 +1,167 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Test channel and ring size configuration via ethtool (-L / -G).
+"""
+
+from lib.py import ksft_run, ksft_exit, ksft_pr
+from lib.py import ksft_eq
+from lib.py import NetDrvEpEnv, EthtoolFamily, GenerateTraffic
+from lib.py import defer, NlError
+
+
+def channels(cfg) -> None:
+    """
+    Twiddle channel counts in various combinations of parameters.
+    We're only looking for driver adhering to the requested config
+    if the config is accepted and crashes.
+    """
+    ehdr = {'header':{'dev-index': cfg.ifindex}}
+    chans = cfg.eth.channels_get(ehdr)
+
+    all_keys = ["rx", "tx", "combined"]
+    mixes = [{"combined"}, {"rx", "tx"}, {"rx", "combined"}, {"tx", "combined"},
+             {"rx", "tx", "combined"},]
+
+    # Get the set of keys that device actually supports
+    restore = {}
+    supported = set()
+    for key in all_keys:
+        if key + "-max" in chans:
+            supported.add(key)
+            restore |= {key + "-count": chans[key + "-count"]}
+
+    defer(cfg.eth.channels_set, ehdr | restore)
+
+    def test_config(config):
+        try:
+            cfg.eth.channels_set(ehdr | config)
+            get = cfg.eth.channels_get(ehdr)
+            for k, v in config.items():
+                ksft_eq(get.get(k, 0), v)
+        except NlError as e:
+            failed.append(mix)
+            ksft_pr("Can't set", config, e)
+        else:
+            ksft_pr("Okay", config)
+
+    failed = []
+    for mix in mixes:
+        if not mix.issubset(supported):
+            continue
+
+        # Set all the values in the mix to 1, other supported to 0
+        config = {}
+        for key in all_keys:
+            config[key + "-count"] = 1 if key in mix else 0
+        test_config(config)
+
+    for mix in mixes:
+        if not mix.issubset(supported):
+            continue
+        if mix in failed:
+            continue
+
+        # Set all the values in the mix to max, other supported to 0
+        config = {}
+        for key in all_keys:
+            config[key + "-count"] = chans[key + '-max'] if key in mix else 0
+        test_config(config)
+
+
+def _configure_min_ring_cnt(cfg) -> None:
+    """ Try to configure a single Rx/Tx ring. """
+    ehdr = {'header':{'dev-index': cfg.ifindex}}
+    chans = cfg.eth.channels_get(ehdr)
+
+    all_keys = ["rx-count", "tx-count", "combined-count"]
+    restore = {}
+    config = {}
+    for key in all_keys:
+        if key in chans:
+            restore[key] = chans[key]
+            config[key] = 0
+
+    if chans.get('combined-count', 0) > 1:
+        config['combined-count'] = 1
+    elif chans.get('rx-count', 0) > 1 and chans.get('tx-count', 0) > 1:
+        config['tx-count'] = 1
+        config['rx-count'] = 1
+    else:
+        # looks like we're already on 1 channel
+        return
+
+    cfg.eth.channels_set(ehdr | config)
+    defer(cfg.eth.channels_set, ehdr | restore)
+
+
+def ringparam(cfg) -> None:
+    """
+    Tweak the ringparam configuration. Try to run some traffic over min
+    ring size to make sure it actually functions.
+    """
+    ehdr = {'header':{'dev-index': cfg.ifindex}}
+    rings = cfg.eth.rings_get(ehdr)
+
+    restore = {}
+    maxes = {}
+    params = set()
+    for key in rings.keys():
+        if 'max' in key:
+            param = key[:-4]
+            maxes[param] = rings[key]
+            params.add(param)
+            restore[param] = rings[param]
+
+    defer(cfg.eth.rings_set, ehdr | restore)
+
+    # Speed up the reconfig by configuring just one ring
+    _configure_min_ring_cnt(cfg)
+
+    # Try to reach min on all settings
+    for param in params:
+        val = rings[param]
+        while True:
+            try:
+                cfg.eth.rings_set({'header':{'dev-index': cfg.ifindex},
+                                   param: val // 2})
+                if val == 0:
+                    break
+                val //= 2
+            except NlError:
+                break
+
+        get = cfg.eth.rings_get(ehdr)
+        ksft_eq(get[param], val)
+
+        ksft_pr(f"Reached min for '{param}' at {val} (max {rings[param]})")
+
+    GenerateTraffic(cfg).wait_pkts_and_stop(10000)
+
+    # Try max across all params, if the driver supports large rings
+    # this may OOM so we ignore errors
+    try:
+        ksft_pr("Applying max settings")
+        config = {p: maxes[p] for p in params}
+        cfg.eth.rings_set(ehdr | config)
+    except NlError as e:
+        ksft_pr("Can't set max params", config, e)
+    else:
+        GenerateTraffic(cfg).wait_pkts_and_stop(10000)
+
+
+def main() -> None:
+    """ Ksft boiler plate main """
+
+    with NetDrvEpEnv(__file__) as cfg:
+        cfg.eth = EthtoolFamily()
+
+        ksft_run([channels,
+                  ringparam],
+                 args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.51.0


