Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD03390012
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 May 2021 13:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhEYLft (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 May 2021 07:35:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48730 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhEYLfo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 May 2021 07:35:44 -0400
Received: from mail-ua1-f69.google.com ([209.85.222.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1llVKA-0006Ff-3D
        for linux-kselftest@vger.kernel.org; Tue, 25 May 2021 11:34:14 +0000
Received: by mail-ua1-f69.google.com with SMTP id i33-20020ab042240000b029020adb6e9ffcso12957324uai.23
        for <linux-kselftest@vger.kernel.org>; Tue, 25 May 2021 04:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7rIaofavGNEqfIibmzamqskjFip+N6lJ41eQFHhg2AM=;
        b=pFlTgNB3WLM6JV5sqvE6Z/zFbt1AvhoXpMFOIFwQ/eE7MNgTCyqjuBbjpthawpUrpe
         Huxf/5mnQ5UQwmJ6MVXkhfq2PZuG4AxNIlu7o84dqOIEpn+E1egQTPNs1GE83UhkckVe
         PgWc0zosM7RFudKOGnMcv5WQogvmkDM6UJ0tEFSIZAV9VFpwvQ0ZBQD8SOYOkqvgmibI
         UMaV2AnBTxQE3Gts2ymhpHCNb6PZMME+L86cb1ZAeiSMcxds4TzfeYNhSlfe5CZRpqhc
         q6AzhplQNQkVT9IQ3SYt2qBJXv08NLWQYsq7/DF0ENcKuTo8BRP6VKR00aRqklOPyxTb
         zo8w==
X-Gm-Message-State: AOAM530oOe0aVw2AbdoD/Z8SGc/S3q1NLJXusmfus2IhHcr5h7iz6TKA
        6ohvVRlvT4V18aJFFuhAEulh3hZO8zzPEIIXHV2qP1aHvHnsIdp1ORUtiX/YK75U1By0kq4tba3
        kIXdJFIrN3q1KwJxD8ovLIa1GeeSF3xGiFN9p+F8AouDk
X-Received: by 2002:a17:902:b609:b029:ec:e80d:7ebd with SMTP id b9-20020a170902b609b02900ece80d7ebdmr30559113pls.75.1621942442132;
        Tue, 25 May 2021 04:34:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVZL4Bgsnvhe80S322lSueZ45OMyQZy9desrrGcrLKVWqDOQQUo/OzpPB9Mlqu5sgVeMwZVQ==
X-Received: by 2002:a17:902:b609:b029:ec:e80d:7ebd with SMTP id b9-20020a170902b609b02900ece80d7ebdmr30559075pls.75.1621942441760;
        Tue, 25 May 2021 04:34:01 -0700 (PDT)
Received: from localhost.localdomain (223-136-150-121.emome-ip.hinet.net. [223.136.150.121])
        by smtp.gmail.com with ESMTPSA id o17sm7892872pgj.25.2021.05.25.04.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 04:34:01 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     po-hsu.lin@canonical.com, shuah@kernel.org,
        skhan@linuxfoundation.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, nikolay@nvidia.com,
        gnault@redhat.com, vladimir.oltean@nxp.com, idosch@nvidia.com,
        baowen.zheng@corigine.com, danieller@nvidia.com, petrm@nvidia.com
Subject: [PATCHv2] selftests: Use kselftest skip code for skipped tests
Date:   Tue, 25 May 2021 19:33:16 +0800
Message-Id: <20210525113316.25416-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are several test cases still using exit 0 when they need to be
skipped. Use kselftest framework skip code instead so it can help us
to distinguish the proper return status.

Criterion to filter out what should be fixed in selftests directory:
  grep -r "exit 0" -B1 | grep -i skip

This change might cause some false-positives if people are running
these test scripts directly and only checking their return codes,
which will change from 0 to 4. However I think the impact should be
small as most of our scripts here are already using this skip code.
And there will be no such issue if running them with the kselftest
framework.

V2: router_mpath_nh.sh and outer_mpath_nh_res.sh sources lib.sh,
there is no need to assign ksft_skip value in these two.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/bpf/test_bpftool_build.sh             | 5 ++++-
 tools/testing/selftests/bpf/test_xdp_meta.sh                  | 5 ++++-
 tools/testing/selftests/bpf/test_xdp_vlan.sh                  | 7 +++++--
 tools/testing/selftests/net/fcnal-test.sh                     | 5 ++++-
 tools/testing/selftests/net/fib_rule_tests.sh                 | 7 +++++--
 tools/testing/selftests/net/forwarding/lib.sh                 | 5 ++++-
 tools/testing/selftests/net/forwarding/router_mpath_nh.sh     | 2 +-
 tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh | 2 +-
 tools/testing/selftests/net/run_afpackettests                 | 5 ++++-
 tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh        | 9 ++++++---
 tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh        | 9 ++++++---
 tools/testing/selftests/net/unicast_extensions.sh             | 5 ++++-
 tools/testing/selftests/net/vrf_strict_mode_test.sh           | 9 ++++++---
 tools/testing/selftests/ptp/phc.sh                            | 7 +++++--
 tools/testing/selftests/vm/charge_reserved_hugetlb.sh         | 5 ++++-
 tools/testing/selftests/vm/hugetlb_reparenting_test.sh        | 5 ++++-
 16 files changed, 67 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_bpftool_build.sh b/tools/testing/selftests/bpf/test_bpftool_build.sh
index ac349a5..b6fab1e 100755
--- a/tools/testing/selftests/bpf/test_bpftool_build.sh
+++ b/tools/testing/selftests/bpf/test_bpftool_build.sh
@@ -1,6 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 case $1 in
 	-h|--help)
 		echo -e "$0 [-j <n>]"
@@ -22,7 +25,7 @@ KDIR_ROOT_DIR=$(realpath $PWD/$SCRIPT_REL_DIR/../../../../)
 cd $KDIR_ROOT_DIR
 if [ ! -e tools/bpf/bpftool/Makefile ]; then
 	echo -e "skip:    bpftool files not found!\n"
-	exit 0
+	exit $ksft_skip
 fi
 
 ERROR=0
diff --git a/tools/testing/selftests/bpf/test_xdp_meta.sh b/tools/testing/selftests/bpf/test_xdp_meta.sh
index 637fcf4..fd3f218 100755
--- a/tools/testing/selftests/bpf/test_xdp_meta.sh
+++ b/tools/testing/selftests/bpf/test_xdp_meta.sh
@@ -1,5 +1,8 @@
 #!/bin/sh
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 cleanup()
 {
 	if [ "$?" = "0" ]; then
@@ -17,7 +20,7 @@ cleanup()
 ip link set dev lo xdp off 2>/dev/null > /dev/null
 if [ $? -ne 0 ];then
 	echo "selftests: [SKIP] Could not run test without the ip xdp support"
-	exit 0
+	exit $ksft_skip
 fi
 set -e
 
diff --git a/tools/testing/selftests/bpf/test_xdp_vlan.sh b/tools/testing/selftests/bpf/test_xdp_vlan.sh
index bb8b0da..1aa7404 100755
--- a/tools/testing/selftests/bpf/test_xdp_vlan.sh
+++ b/tools/testing/selftests/bpf/test_xdp_vlan.sh
@@ -2,6 +2,9 @@
 # SPDX-License-Identifier: GPL-2.0
 # Author: Jesper Dangaard Brouer <hawk@kernel.org>
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 # Allow wrapper scripts to name test
 if [ -z "$TESTNAME" ]; then
     TESTNAME=xdp_vlan
@@ -94,7 +97,7 @@ while true; do
 	    -h | --help )
 		usage;
 		echo "selftests: $TESTNAME [SKIP] usage help info requested"
-		exit 0
+		exit $ksft_skip
 		;;
 	    * )
 		shift
@@ -117,7 +120,7 @@ fi
 ip link set dev lo xdpgeneric off 2>/dev/null > /dev/null
 if [ $? -ne 0 ]; then
 	echo "selftests: $TESTNAME [SKIP] need ip xdp support"
-	exit 0
+	exit $ksft_skip
 fi
 
 # Interactive mode likely require us to cleanup netns
diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index a8ad928..9074e25 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -37,6 +37,9 @@
 #
 # server / client nomenclature relative to ns-A
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 VERBOSE=0
 
 NSA_DEV=eth1
@@ -3946,7 +3949,7 @@ fi
 which nettest >/dev/null
 if [ $? -ne 0 ]; then
 	echo "'nettest' command not found; skipping tests"
-	exit 0
+	exit $ksft_skip
 fi
 
 declare -i nfail=0
diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index a93e6b6..43ea840 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -3,6 +3,9 @@
 
 # This test is for checking IPv4 and IPv6 FIB rules API
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 ret=0
 
 PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
@@ -238,12 +241,12 @@ run_fibrule_tests()
 
 if [ "$(id -u)" -ne 0 ];then
 	echo "SKIP: Need root privileges"
-	exit 0
+	exit $ksft_skip
 fi
 
 if [ ! -x "$(command -v ip)" ]; then
 	echo "SKIP: Could not run test without ip tool"
-	exit 0
+	exit $ksft_skip
 fi
 
 # start clean
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 42e28c9..eed9f08 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -4,6 +4,9 @@
 ##############################################################################
 # Defines
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 # Can be overridden by the configuration file.
 PING=${PING:=ping}
 PING6=${PING6:=ping6}
@@ -121,7 +124,7 @@ check_ethtool_lanes_support()
 
 if [[ "$(id -u)" -ne 0 ]]; then
 	echo "SKIP: need root privileges"
-	exit 0
+	exit $ksft_skip
 fi
 
 if [[ "$CHECK_TC" = "yes" ]]; then
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
index 76efb1f..a0d612e 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
@@ -411,7 +411,7 @@ ping_ipv6()
 ip nexthop ls >/dev/null 2>&1
 if [ $? -ne 0 ]; then
 	echo "Nexthop objects not supported; skipping tests"
-	exit 0
+	exit $ksft_skip
 fi
 
 trap cleanup EXIT
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
index 4898dd4..cb08ffe 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
@@ -386,7 +386,7 @@ ping_ipv6()
 ip nexthop ls >/dev/null 2>&1
 if [ $? -ne 0 ]; then
 	echo "Nexthop objects not supported; skipping tests"
-	exit 0
+	exit $ksft_skip
 fi
 
 trap cleanup EXIT
diff --git a/tools/testing/selftests/net/run_afpackettests b/tools/testing/selftests/net/run_afpackettests
index 8b42e8b..a59cb6a 100755
--- a/tools/testing/selftests/net/run_afpackettests
+++ b/tools/testing/selftests/net/run_afpackettests
@@ -1,9 +1,12 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 if [ $(id -u) != 0 ]; then
 	echo $msg must be run as root >&2
-	exit 0
+	exit $ksft_skip
 fi
 
 ret=0
diff --git a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
index ad7a9fc..1003119 100755
--- a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
@@ -163,6 +163,9 @@
 # +---------------------------------------------------+
 #
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 readonly LOCALSID_TABLE_ID=90
 readonly IPv6_RT_NETWORK=fd00
 readonly IPv4_HS_NETWORK=10.0.0
@@ -464,18 +467,18 @@ host_vpn_isolation_tests()
 
 if [ "$(id -u)" -ne 0 ];then
 	echo "SKIP: Need root privileges"
-	exit 0
+	exit $ksft_skip
 fi
 
 if [ ! -x "$(command -v ip)" ]; then
 	echo "SKIP: Could not run test without ip tool"
-	exit 0
+	exit $ksft_skip
 fi
 
 modprobe vrf &>/dev/null
 if [ ! -e /proc/sys/net/vrf/strict_mode ]; then
         echo "SKIP: vrf sysctl does not exist"
-        exit 0
+        exit $ksft_skip
 fi
 
 cleanup &>/dev/null
diff --git a/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
index 68708f5..b9b06ef 100755
--- a/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
@@ -164,6 +164,9 @@
 # +---------------------------------------------------+
 #
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 readonly LOCALSID_TABLE_ID=90
 readonly IPv6_RT_NETWORK=fd00
 readonly IPv6_HS_NETWORK=cafe
@@ -472,18 +475,18 @@ host_vpn_isolation_tests()
 
 if [ "$(id -u)" -ne 0 ];then
 	echo "SKIP: Need root privileges"
-	exit 0
+	exit $ksft_skip
 fi
 
 if [ ! -x "$(command -v ip)" ]; then
 	echo "SKIP: Could not run test without ip tool"
-	exit 0
+	exit $ksft_skip
 fi
 
 modprobe vrf &>/dev/null
 if [ ! -e /proc/sys/net/vrf/strict_mode ]; then
         echo "SKIP: vrf sysctl does not exist"
-        exit 0
+        exit $ksft_skip
 fi
 
 cleanup &>/dev/null
diff --git a/tools/testing/selftests/net/unicast_extensions.sh b/tools/testing/selftests/net/unicast_extensions.sh
index dbf0421..728e4d5 100755
--- a/tools/testing/selftests/net/unicast_extensions.sh
+++ b/tools/testing/selftests/net/unicast_extensions.sh
@@ -28,12 +28,15 @@
 # These tests provide an easy way to flip the expected result of any
 # of these behaviors for testing kernel patches that change them.
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 # nettest can be run from PATH or from same directory as this selftest
 if ! which nettest >/dev/null; then
 	PATH=$PWD:$PATH
 	if ! which nettest >/dev/null; then
 		echo "'nettest' command not found; skipping tests"
-		exit 0
+		exit $ksft_skip
 	fi
 fi
 
diff --git a/tools/testing/selftests/net/vrf_strict_mode_test.sh b/tools/testing/selftests/net/vrf_strict_mode_test.sh
index 18b982d..865d53c 100755
--- a/tools/testing/selftests/net/vrf_strict_mode_test.sh
+++ b/tools/testing/selftests/net/vrf_strict_mode_test.sh
@@ -3,6 +3,9 @@
 
 # This test is designed for testing the new VRF strict_mode functionality.
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 ret=0
 
 # identifies the "init" network namespace which is often called root network
@@ -371,18 +374,18 @@ vrf_strict_mode_check_support()
 
 if [ "$(id -u)" -ne 0 ];then
 	echo "SKIP: Need root privileges"
-	exit 0
+	exit $ksft_skip
 fi
 
 if [ ! -x "$(command -v ip)" ]; then
 	echo "SKIP: Could not run test without ip tool"
-	exit 0
+	exit $ksft_skip
 fi
 
 modprobe vrf &>/dev/null
 if [ ! -e /proc/sys/net/vrf/strict_mode ]; then
 	echo "SKIP: vrf sysctl does not exist"
-	exit 0
+	exit $ksft_skip
 fi
 
 cleanup &> /dev/null
diff --git a/tools/testing/selftests/ptp/phc.sh b/tools/testing/selftests/ptp/phc.sh
index ac6e5a6..ca3c844c 100755
--- a/tools/testing/selftests/ptp/phc.sh
+++ b/tools/testing/selftests/ptp/phc.sh
@@ -1,6 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 ALL_TESTS="
 	settime
 	adjtime
@@ -13,12 +16,12 @@ DEV=$1
 
 if [[ "$(id -u)" -ne 0 ]]; then
 	echo "SKIP: need root privileges"
-	exit 0
+	exit $ksft_skip
 fi
 
 if [[ "$DEV" == "" ]]; then
 	echo "SKIP: PTP device not provided"
-	exit 0
+	exit $ksft_skip
 fi
 
 require_command()
diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
index 18d3368..fe8fcfb 100644
--- a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -1,11 +1,14 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 set -e
 
 if [[ $(id -u) -ne 0 ]]; then
   echo "This test must be run as root. Skipping..."
-  exit 0
+  exit $ksft_skip
 fi
 
 fault_limit_file=limit_in_bytes
diff --git a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
index d11d1fe..4a9a3af 100644
--- a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
@@ -1,11 +1,14 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 set -e
 
 if [[ $(id -u) -ne 0 ]]; then
   echo "This test must be run as root. Skipping..."
-  exit 0
+  exit $ksft_skip
 fi
 
 usage_file=usage_in_bytes
-- 
2.7.4

