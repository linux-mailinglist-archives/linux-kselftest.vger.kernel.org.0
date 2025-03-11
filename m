Return-Path: <linux-kselftest+bounces-28750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C291A5C38A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 15:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5CF3B2213
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D4725D55F;
	Tue, 11 Mar 2025 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="mbmcEf27"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B2C25A653;
	Tue, 11 Mar 2025 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702423; cv=none; b=Zj5ugI9sbMyolhzvVZbduYoTx+X/MpZMMTawgXyHrK97SodIgZsGCnpI1WHjqC5bfySVRZdldMRdpWCxSFov5B46nSelKZ8iAhCNhh6AiztBtrsooo89ZLk2CQZJiq8/y7ZO9AOGZKBskczg8MZPjIh+0dQHvSouvEdPZuVh+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702423; c=relaxed/simple;
	bh=YHwJy3GtrtpHb4FhhNowxshdtoJ0AgzqhgiJVohKkoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ix/clOAv4e14EQYKN/zsCRHmGra4xCY8yu/VpaU0kng2GdavHwfxvAp4NTME6W5PlC/iNhqbMdELkl8CTj6C8jmaNIcNIkQqDHURXdE9DkemxrWlnMg6cQ998IL99vfX7fKGXoNuzXPaLEa7ZSNlHIwxNh+v7QIILtxYQ8F2LNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=mbmcEf27; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (unknown [195.29.54.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 585AC200E1C5;
	Tue, 11 Mar 2025 15:13:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 585AC200E1C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741702420;
	bh=jc91zC3P1TijT48kt8gt6oERnK6HY8Csn1YKPi7e9zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mbmcEf27HSDvY74w6IewZsBALexjdY/gJMSpqG2/KATzB1QsVhP7x//ahKsp/Xtda
	 uzCgUbrAQQHXFLOl6dmrzWnSgEd/K7Fl28S1uoIKAroJS9XMBm+SdsZjxNST1JJKlC
	 7nA4lrVdrEBNsAu/r6dcUKSTwuGwf2LW/Gh/2bm4whVHjdWenlUZdBmaINmgGiQPDJ
	 fH1Vxx9o0GV/Mw9hr3L/TxfseWG+JPgl8k+Epwq1U2J0frPv0r951bYsw5B3xXbYtw
	 QdMSPPKFup8RlVJLoa63U6ZJGK+L5ELP7/838+B2Apc0uXHZ4f2GDswVdeL9XJz1uk
	 sqJFrBUnWVkrw==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 7/7] selftests: net: test for lwtunnel dst ref loops
Date: Tue, 11 Mar 2025 15:12:38 +0100
Message-Id: <20250311141238.19862-8-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311141238.19862-1-justin.iurman@uliege.be>
References: <20250311141238.19862-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As recently specified by commit 0ea09cbf8350 ("docs: netdev: add a note
on selftest posting") in net-next, the selftest is therefore shipped in
this series. However, this selftest does not really test this series. It
needs this series to avoid crashing the kernel. What it really tests,
thanks to kmemleak, is what was fixed by the following commits:
- commit c71a192976de ("net: ipv6: fix dst refleaks in rpl, seg6 and
ioam6 lwtunnels")
- commit 92191dd10730 ("net: ipv6: fix dst ref loops in rpl, seg6 and
ioam6 lwtunnels")
- commit c64a0727f9b1 ("net: ipv6: fix dst ref loop on input in seg6
lwt")
- commit 13e55fbaec17 ("net: ipv6: fix dst ref loop on input in rpl
lwt")
- commit 0e7633d7b95b ("net: ipv6: fix dst ref loop in ila lwtunnel")
- commit 5da15a9c11c1 ("net: ipv6: fix missing dst ref drop in ila
lwtunnel")

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   2 +
 .../selftests/net/lwt_dst_cache_ref_loop.sh   | 250 ++++++++++++++++++
 3 files changed, 253 insertions(+)
 create mode 100755 tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 73ee88d6b043..8f32b4f01aee 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -100,6 +100,7 @@ TEST_PROGS += vlan_bridge_binding.sh
 TEST_PROGS += bpf_offload.py
 TEST_PROGS += ipv6_route_update_soft_lockup.sh
 TEST_PROGS += busy_poll_test.sh
+TEST_PROGS += lwt_dst_cache_ref_loop.sh
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller netlink-dumps
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 5b9baf708950..61e5116987f3 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -107,3 +107,5 @@ CONFIG_XFRM_INTERFACE=m
 CONFIG_XFRM_USER=m
 CONFIG_IP_NF_MATCH_RPFILTER=m
 CONFIG_IP6_NF_MATCH_RPFILTER=m
+CONFIG_IPV6_ILA=m
+CONFIG_IPV6_RPL_LWTUNNEL=y
diff --git a/tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh b/tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh
new file mode 100755
index 000000000000..9161f16154a5
--- /dev/null
+++ b/tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh
@@ -0,0 +1,250 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Author: Justin Iurman <justin.iurman@uliege.be>
+#
+# WARNING
+# -------
+# This is just a dummy script that triggers encap cases with possible dst cache
+# reference loops in affected lwt users (see list below). Some cases are
+# pathological configurations for simplicity, others are valid. Overall, we
+# don't want this issue to happen, no matter what. In order to catch any
+# reference loops, kmemleak MUST be used. The results alone are always blindly
+# successful, don't rely on them. Note that the following tests may crash the
+# kernel if the fix to prevent lwtunnel_{input|output|xmit}() reentry loops is
+# not present.
+#
+# Affected lwt users so far (please update accordingly if needed):
+#  - ila_lwt (output only)
+#  - ioam6_iptunnel (output only)
+#  - rpl_iptunnel (both input and output)
+#  - seg6_iptunnel (both input and output)
+
+source lib.sh
+
+check_compatibility()
+{
+  setup_ns tmp_node &>/dev/null
+  if [ $? != 0 ]
+  then
+    echo "SKIP: Cannot create netns."
+    exit $ksft_skip
+  fi
+
+  ip link add name veth0 netns $tmp_node type veth \
+    peer name veth1 netns $tmp_node &>/dev/null
+  local ret=$?
+
+  ip -netns $tmp_node link set veth0 up &>/dev/null
+  ret=$((ret + $?))
+
+  ip -netns $tmp_node link set veth1 up &>/dev/null
+  ret=$((ret + $?))
+
+  if [ $ret != 0 ]
+  then
+    echo "SKIP: Cannot configure links."
+    cleanup_ns $tmp_node
+    exit $ksft_skip
+  fi
+
+  lsmod 2>/dev/null | grep -q "ila"
+  ila_lsmod=$?
+  [ $ila_lsmod != 0 ] && modprobe ila &>/dev/null
+
+  ip -netns $tmp_node route add 2001:db8:1::/64 \
+    encap ila 1:2:3:4 csum-mode no-action ident-type luid hook-type output \
+    dev veth0 &>/dev/null
+
+  ip -netns $tmp_node route add 2001:db8:2::/64 \
+    encap ioam6 trace prealloc type 0x800000 ns 0 size 4 dev veth0 &>/dev/null
+
+  ip -netns $tmp_node route add 2001:db8:3::/64 \
+    encap rpl segs 2001:db8:3::1 dev veth0 &>/dev/null
+
+  ip -netns $tmp_node route add 2001:db8:4::/64 \
+    encap seg6 mode inline segs 2001:db8:4::1 dev veth0 &>/dev/null
+
+  ip -netns $tmp_node -6 route 2>/dev/null | grep -q "encap ila"
+  skip_ila=$?
+
+  ip -netns $tmp_node -6 route 2>/dev/null | grep -q "encap ioam6"
+  skip_ioam6=$?
+
+  ip -netns $tmp_node -6 route 2>/dev/null | grep -q "encap rpl"
+  skip_rpl=$?
+
+  ip -netns $tmp_node -6 route 2>/dev/null | grep -q "encap seg6"
+  skip_seg6=$?
+
+  cleanup_ns $tmp_node
+}
+
+setup()
+{
+  setup_ns alpha beta gamma &>/dev/null
+
+  ip link add name veth-alpha netns $alpha type veth \
+    peer name veth-betaL netns $beta &>/dev/null
+  ip link add name veth-betaR netns $beta type veth \
+    peer name veth-gamma netns $gamma &>/dev/null
+
+  ip -netns $alpha link set veth-alpha name veth0 &>/dev/null
+  ip -netns $beta link set veth-betaL name veth0 &>/dev/null
+  ip -netns $beta link set veth-betaR name veth1 &>/dev/null
+  ip -netns $gamma link set veth-gamma name veth0 &>/dev/null
+
+  ip -netns $alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
+  ip -netns $alpha link set veth0 up &>/dev/null
+  ip -netns $alpha link set lo up &>/dev/null
+  ip -netns $alpha route add 2001:db8:2::/64 \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  ip -netns $beta addr add 2001:db8:1::1/64 dev veth0 &>/dev/null
+  ip -netns $beta addr add 2001:db8:2::1/64 dev veth1 &>/dev/null
+  ip -netns $beta link set veth0 up &>/dev/null
+  ip -netns $beta link set veth1 up &>/dev/null
+  ip -netns $beta link set lo up &>/dev/null
+  ip -netns $beta route del 2001:db8:2::/64
+  ip -netns $beta route add 2001:db8:2::/64 dev veth1
+  ip netns exec $beta sysctl -wq net.ipv6.conf.all.forwarding=1 &>/dev/null
+
+  ip -netns $gamma addr add 2001:db8:2::2/64 dev veth0 &>/dev/null
+  ip -netns $gamma link set veth0 up &>/dev/null
+  ip -netns $gamma link set lo up &>/dev/null
+  ip -netns $gamma route add 2001:db8:1::/64 \
+    via 2001:db8:2::1 dev veth0 &>/dev/null
+
+  sleep 1
+
+  ip netns exec $alpha ping6 -c 5 -W 1 2001:db8:2::2 &>/dev/null
+  if [ $? != 0 ]
+  then
+    echo "SKIP: Setup failed."
+    cleanup
+    exit $ksft_skip
+  fi
+
+  sleep 1
+}
+
+cleanup()
+{
+  cleanup_ns $alpha $beta $gamma
+  [ $ila_lsmod != 0 ] && modprobe -r ila &>/dev/null
+}
+
+run_ila()
+{
+  if [ $skip_ila != 0 ]
+  then
+    echo "SKIP: ila (output)"
+    return
+  fi
+
+  ip -netns $beta route del 2001:db8:2::/64
+
+  ip -netns $beta route add 2001:db8:2:0:0:0:0:2/128 \
+    encap ila 2001:db8:2:0 csum-mode no-action ident-type luid hook-type output \
+    dev veth1 &>/dev/null
+  sleep 1
+
+  echo "TEST: ila (output)"
+  ip netns exec $beta ping6 -c 2 -W 1 2001:db8:2::2 &>/dev/null
+  sleep 1
+
+  ip -netns $beta route del 2001:db8:2:0:0:0:0:2/128
+  ip -netns $beta route add 2001:db8:2::/64 dev veth1
+  sleep 1
+}
+
+run_ioam6()
+{
+  if [ $skip_ioam6 != 0 ]
+  then
+    echo "SKIP: ioam6 (output)"
+    return
+  fi
+
+  ip -netns $beta route change 2001:db8:2::/64 \
+    encap ioam6 trace prealloc type 0x800000 ns 1 size 4 \
+    dev veth1 &>/dev/null
+  sleep 1
+
+  echo "TEST: ioam6 (output)"
+  ip netns exec $beta ping6 -c 2 -W 1 2001:db8:2::2 &>/dev/null
+  sleep 1
+}
+
+run_rpl()
+{
+  if [ $skip_rpl != 0 ]
+  then
+    echo "SKIP: rpl (input)"
+    echo "SKIP: rpl (output)"
+    return
+  fi
+
+  ip -netns $beta route change 2001:db8:2::/64 \
+    encap rpl segs 2001:db8:2::2 \
+    dev veth1 &>/dev/null
+  sleep 1
+
+  echo "TEST: rpl (input)"
+  ip netns exec $alpha ping6 -c 2 -W 1 2001:db8:2::2 &>/dev/null
+  sleep 1
+
+  echo "TEST: rpl (output)"
+  ip netns exec $beta ping6 -c 2 -W 1 2001:db8:2::2 &>/dev/null
+  sleep 1
+}
+
+run_seg6()
+{
+  if [ $skip_seg6 != 0 ]
+  then
+    echo "SKIP: seg6 (input)"
+    echo "SKIP: seg6 (output)"
+    return
+  fi
+
+  ip -netns $beta route change 2001:db8:2::/64 \
+    encap seg6 mode inline segs 2001:db8:2::2 \
+    dev veth1 &>/dev/null
+  sleep 1
+
+  echo "TEST: seg6 (input)"
+  ip netns exec $alpha ping6 -c 2 -W 1 2001:db8:2::2 &>/dev/null
+  sleep 1
+
+  echo "TEST: seg6 (output)"
+  ip netns exec $beta ping6 -c 2 -W 1 2001:db8:2::2 &>/dev/null
+  sleep 1
+}
+
+run()
+{
+  run_ila
+  run_ioam6
+  run_rpl
+  run_seg6
+}
+
+if [ "$(id -u)" -ne 0 ]
+then
+  echo "SKIP: Need root privileges."
+  exit $ksft_skip
+fi
+
+if [ ! -x "$(command -v ip)" ]
+then
+  echo "SKIP: Could not run test without ip tool."
+  exit $ksft_skip
+fi
+
+check_compatibility
+setup
+run
+cleanup
+
+exit $ksft_pass
-- 
2.34.1


