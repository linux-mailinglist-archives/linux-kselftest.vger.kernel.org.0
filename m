Return-Path: <linux-kselftest+bounces-17444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFFF970336
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 18:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEEDBB225DF
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A875715CD77;
	Sat,  7 Sep 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="MTyJAduK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650191537AC;
	Sat,  7 Sep 2024 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725727839; cv=none; b=MtvmUXPDulVjc5Ax88hwRkpz96J50DPi+qNjyb5apR5k/Gop3//vlsNNvMaMvXazuMMp8+ue8csuJoBKCksaEX8gaE8tnYWusoH2mq3G4B0hKqXsmvth5vo1bH0SbifAW2vplauabOX8EEwANwxpMNC2erYCNVbktvVluhna/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725727839; c=relaxed/simple;
	bh=Q71nIbiy+NFnhUPjR/YOxFc4iw6WaaK1nPux1t4I8tI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MWVkR/05OdB+mvRgSyOPYxi/92dT1xy0kpPvoYu935FEP+vNyTGDBHKwhmGSembFFg+Un2lPh5vg5Nk3DX8pcJpZ8DzAnQVGJp5OQSSyHxOD6EnICB7+sdTyHBf2R61sBh96SXcnyLFlCgjI3cv+19o/iQ0jZrj5tk4OpYbP4tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=MTyJAduK; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 854B1200A738;
	Sat,  7 Sep 2024 18:43:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 854B1200A738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1725727381;
	bh=5QJLxRL5oS5Eo/+m/D6Ncrz6HuRQincr3Dj8fwV846o=;
	h=From:To:Cc:Subject:Date:From;
	b=MTyJAduKCcjmcszL6im142i6zIG6zk4uh87HPG/47x4SOUoZ9HK98bVD/qI+9UnPT
	 DjcGDcRUjj9KurPrrTSwtktKteIE+Uz/qI7rCEGMR0LVAocj4B2giPYwAOfXW7M4U/
	 5dRUpre7zGzkDp5AQEz5tXGXbd5Li6l670MP3plVFzFa/JUVS+72J1DIQF4+IZ+wCR
	 sX/93hziIV4swuctImCFX06MGdAP3w9ukBWSh+sZY6wzj29ZBgU5FS4Uww31OsKQYL
	 zNr7cR7A2RixU5JsqGguoNlQPymPPuC4Cv49hymF09/0ogWjnPQor5jwiCnhi1Cxc7
	 nn8W7ueLvUaTw==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next] selftests: net: ioam: add tunsrc support
Date: Sat,  7 Sep 2024 18:42:45 +0200
Message-Id: <20240907164245.89627-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR This patch comes from a discussion we had with Jakub and Paolo.

This patch updates the IOAM selftests to support the new "tunsrc"
feature of IOAM. As a consequence, some changes were required. For
example, the IPv6 header must be accessed to check some fields (i.e.,
the source address for the "tunsrc" feature), which is not possible
AFAIK with IPv6 raw sockets. The latter is currently used with
IPV6_RECVHOPOPTS and was introduced by commit 187bbb6968af ("selftests:
ioam: refactoring to align with the fix") to fix an issue. But, we
really need packet sockets actually... which is one of the changes in
this patch (see the description of the topology at the top of ioam6.sh
for explanations). Another change is that all IPv6 addresses used in the
topology are now based on the documentation prefix (2001:db8::/32).
Also, the tests have been improved and there are now many more of them.
Overall, the script is more robust.

The diff is kind of a mess. Since it's "just" a selftests patch, I
didn't bother having a series of two patches (one to remove it, one to
add the new one back). Let me know if you think it's necessary for
readability.

Note: this patch needs this [1] iproute2-next patch to be merged
(waiting for David to do so, should be done soon).

  [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=884653

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 tools/testing/selftests/net/ioam6.sh       | 1832 +++++++++++++++-----
 tools/testing/selftests/net/ioam6_parser.c | 1087 ++++++++----
 2 files changed, 2129 insertions(+), 790 deletions(-)

diff --git a/tools/testing/selftests/net/ioam6.sh b/tools/testing/selftests/net/ioam6.sh
index 12491850ae98..845c26dd01a9 100755
--- a/tools/testing/selftests/net/ioam6.sh
+++ b/tools/testing/selftests/net/ioam6.sh
@@ -3,119 +3,106 @@
 #
 # Author: Justin Iurman <justin.iurman@uliege.be>
 #
-# This script evaluates the IOAM insertion for IPv6 by checking the IOAM data
-# consistency directly inside packets on the receiver side. Tests are divided
-# into three categories: OUTPUT (evaluates the IOAM processing by the sender),
-# INPUT (evaluates the IOAM processing by a receiver) and GLOBAL (evaluates
-# wider use cases that do not fall into the other two categories). Both OUTPUT
-# and INPUT tests only use a two-node topology (alpha and beta), while GLOBAL
-# tests use the entire three-node topology (alpha, beta, gamma). Each test is
-# documented inside its own handler in the code below.
+# This script evaluates IOAM for IPv6 by checking local IOAM configurations and
+# IOAM data inside packets. There are three categories of tests: LOCAL, OUTPUT,
+# and INPUT. The former (LOCAL) checks all IOAM related configurations locally
+# without sending packets. OUTPUT tests verify the processing of an IOAM
+# encapsulating node, while INPUT tests verify the processing of an IOAM transit
+# node. Both OUTPUT and INPUT tests send packets. Each test is documented inside
+# its own handler.
 #
-# An IOAM domain is configured from Alpha to Gamma but not on the reverse path.
-# When either Beta or Gamma is the destination (depending on the test category),
-# Alpha adds an IOAM option (Pre-allocated Trace) inside a Hop-by-hop.
+# The topology used for OUTPUT and INPUT tests is made of three nodes:
+# - Alpha (the IOAM encapsulating node)
+# - Beta  (the IOAM transit node)
+# - Gamma (the receiver) **
 #
+# An IOAM domain is configured from Alpha to Beta, but not on the reverse path.
+# Alpha adds an IOAM option (Pre-allocated Trace) inside a Hop-by-hop.
 #
-#            +-------------------+            +-------------------+
-#            |                   |            |                   |
-#            |    Alpha netns    |            |    Gamma netns    |
-#            |                   |            |                   |
-#            |  +-------------+  |            |  +-------------+  |
-#            |  |    veth0    |  |            |  |    veth0    |  |
-#            |  |  db01::2/64 |  |            |  |  db02::2/64 |  |
-#            |  +-------------+  |            |  +-------------+  |
-#            |         .         |            |         .         |
-#            +-------------------+            +-------------------+
-#                      .                                .
-#                      .                                .
-#                      .                                .
-#            +----------------------------------------------------+
-#            |         .                                .         |
-#            |  +-------------+                  +-------------+  |
-#            |  |    veth0    |                  |    veth1    |  |
-#            |  |  db01::1/64 | ................ |  db02::1/64 |  |
-#            |  +-------------+                  +-------------+  |
-#            |                                                    |
-#            |                      Beta netns                    |
-#            |                                                    |
-#            +----------------------------------------------------+
+# ** Gamma is required because ioam6_parser.c uses a packet socket and we need
+#    to see IOAM data inserted by the very last node (Beta), which would happen
+#    _after_ we get a copy of the packet on Beta. Note that using an
+#    IPv6 raw socket with IPV6_RECVHOPOPTS on Beta would not be enough: we also
+#    need to access the IPv6 header to check some fields (e.g., source and
+#    destination addresses), which is not possible in that case. As a
+#    consequence, we need Gamma as a receiver to run ioam6_parser.c which uses a
+#    packet socket.
 #
 #
+#         +-----------------------+          +-----------------------+
+#         |                       |          |                       |
+#         |      Alpha netns      |          |      Gamma netns      |
+#         |                       |          |                       |
+#         | +-------------------+ |          | +-------------------+ |
+#         | |       veth0       | |          | |       veth0       | |
+#         | | 2001:db8:1::2/64  | |          | | 2001:db8:2::2/64  | |
+#         | +-------------------+ |          | +-------------------+ |
+#         |           .           |          |           .           |
+#         +-----------.-----------+          +-----------.-----------+
+#                     .                                  .
+#                     .                                  .
+#                     .                                  .
+#         +-----------.----------------------------------.-----------+
+#         |           .                                  .           |
+#         | +-------------------+              +-------------------+ |
+#         | |       veth0       |              |       veth1       | |
+#         | | 2001:db8:1::1/64  | ............ | 2001:db8:2::1/64  | |
+#         | +-------------------+              +-------------------+ |
+#         |                                                          |
+#         |                        Beta netns                        |
+#         |                                                          |
+#         +----------------------------------------------------------+
 #
-#        =============================================================
-#        |                Alpha - IOAM configuration                 |
-#        +===========================================================+
-#        | Node ID             | 1                                   |
-#        +-----------------------------------------------------------+
-#        | Node Wide ID        | 11111111                            |
-#        +-----------------------------------------------------------+
-#        | Ingress ID          | 0xffff (default value)              |
-#        +-----------------------------------------------------------+
-#        | Ingress Wide ID     | 0xffffffff (default value)          |
-#        +-----------------------------------------------------------+
-#        | Egress ID           | 101                                 |
-#        +-----------------------------------------------------------+
-#        | Egress Wide ID      | 101101                              |
-#        +-----------------------------------------------------------+
-#        | Namespace Data      | 0xdeadbee0                          |
-#        +-----------------------------------------------------------+
-#        | Namespace Wide Data | 0xcafec0caf00dc0de                  |
-#        +-----------------------------------------------------------+
-#        | Schema ID           | 777                                 |
-#        +-----------------------------------------------------------+
-#        | Schema Data         | something that will be 4n-aligned   |
-#        +-----------------------------------------------------------+
 #
 #
-#        =============================================================
-#        |                 Beta - IOAM configuration                 |
-#        +===========================================================+
-#        | Node ID             | 2                                   |
-#        +-----------------------------------------------------------+
-#        | Node Wide ID        | 22222222                            |
-#        +-----------------------------------------------------------+
-#        | Ingress ID          | 201                                 |
-#        +-----------------------------------------------------------+
-#        | Ingress Wide ID     | 201201                              |
-#        +-----------------------------------------------------------+
-#        | Egress ID           | 202                                 |
-#        +-----------------------------------------------------------+
-#        | Egress Wide ID      | 202202                              |
-#        +-----------------------------------------------------------+
-#        | Namespace Data      | 0xdeadbee1                          |
-#        +-----------------------------------------------------------+
-#        | Namespace Wide Data | 0xcafec0caf11dc0de                  |
-#        +-----------------------------------------------------------+
-#        | Schema ID           | 666                                 |
-#        +-----------------------------------------------------------+
-#        | Schema Data         | Hello there -Obi                    |
-#        +-----------------------------------------------------------+
+#         +==========================================================+
+#         |                Alpha - IOAM configuration                |
+#         +=====================+====================================+
+#         | Node ID             | 1                                  |
+#         +---------------------+------------------------------------+
+#         | Node Wide ID        | 11111111                           |
+#         +---------------------+------------------------------------+
+#         | Ingress ID          | 0xffff (default value)             |
+#         +---------------------+------------------------------------+
+#         | Ingress Wide ID     | 0xffffffff (default value)         |
+#         +---------------------+------------------------------------+
+#         | Egress ID           | 101                                |
+#         +---------------------+------------------------------------+
+#         | Egress Wide ID      | 101101                             |
+#         +---------------------+------------------------------------+
+#         | Namespace Data      | 0xdeadbeef                         |
+#         +---------------------+------------------------------------+
+#         | Namespace Wide Data | 0xcafec0caf00dc0de                 |
+#         +---------------------+------------------------------------+
+#         | Schema ID           | 777                                |
+#         +---------------------+------------------------------------+
+#         | Schema Data         | something that will be 4n-aligned  |
+#         +---------------------+------------------------------------+
 #
 #
-#        =============================================================
-#        |                Gamma - IOAM configuration                 |
-#        +===========================================================+
-#        | Node ID             | 3                                   |
-#        +-----------------------------------------------------------+
-#        | Node Wide ID        | 33333333                            |
-#        +-----------------------------------------------------------+
-#        | Ingress ID          | 301                                 |
-#        +-----------------------------------------------------------+
-#        | Ingress Wide ID     | 301301                              |
-#        +-----------------------------------------------------------+
-#        | Egress ID           | 0xffff (default value)              |
-#        +-----------------------------------------------------------+
-#        | Egress Wide ID      | 0xffffffff (default value)          |
-#        +-----------------------------------------------------------+
-#        | Namespace Data      | 0xdeadbee2                          |
-#        +-----------------------------------------------------------+
-#        | Namespace Wide Data | 0xcafec0caf22dc0de                  |
-#        +-----------------------------------------------------------+
-#        | Schema ID           | 0xffffff (= None)                   |
-#        +-----------------------------------------------------------+
-#        | Schema Data         |                                     |
-#        +-----------------------------------------------------------+
+#         +==========================================================+
+#         |                 Beta - IOAM configuration                |
+#         +=====================+====================================+
+#         | Node ID             | 2                                  |
+#         +---------------------+------------------------------------+
+#         | Node Wide ID        | 22222222                           |
+#         +---------------------+------------------------------------+
+#         | Ingress ID          | 201                                |
+#         +---------------------+------------------------------------+
+#         | Ingress Wide ID     | 201201                             |
+#         +---------------------+------------------------------------+
+#         | Egress ID           | 202                                |
+#         +---------------------+------------------------------------+
+#         | Egress Wide ID      | 202202                             |
+#         +---------------------+------------------------------------+
+#         | Namespace Data      | 0xffffffff (default value)         |
+#         +---------------------+------------------------------------+
+#         | Namespace Wide Data | 0xffffffffffffffff (default value) |
+#         +---------------------+------------------------------------+
+#         | Schema ID           | 0xffffff (= None)                  |
+#         +---------------------+------------------------------------+
+#         | Schema Data         |                                    |
+#         +---------------------+------------------------------------+
 
 source lib.sh
 
@@ -128,64 +115,69 @@ source lib.sh
 ################################################################################
 
 ALPHA=(
-	1					# ID
-	11111111				# Wide ID
-	0xffff					# Ingress ID
-	0xffffffff				# Ingress Wide ID
-	101					# Egress ID
-	101101					# Egress Wide ID
-	0xdeadbee0				# Namespace Data
-	0xcafec0caf00dc0de			# Namespace Wide Data
-	777					# Schema ID (0xffffff = None)
-	"something that will be 4n-aligned"	# Schema Data
+  1                                    # ID
+  11111111                             # Wide ID
+  0xffff                               # Ingress ID (default value)
+  0xffffffff                           # Ingress Wide ID (default value)
+  101                                  # Egress ID
+  101101                               # Egress Wide ID
+  0xdeadbeef                           # Namespace Data
+  0xcafec0caf00dc0de                   # Namespace Wide Data
+  777                                  # Schema ID
+  "something that will be 4n-aligned"  # Schema Data
 )
 
 BETA=(
-	2
-	22222222
-	201
-	201201
-	202
-	202202
-	0xdeadbee1
-	0xcafec0caf11dc0de
-	666
-	"Hello there -Obi"
+  2                                    # ID
+  22222222                             # Wide ID
+  201                                  # Ingress ID
+  201201                               # Ingress Wide ID
+  202                                  # Egress ID
+  202202                               # Egress Wide ID
+  0xffffffff                           # Namespace Data (empty value)
+  0xffffffffffffffff                   # Namespace Wide Data (empty value)
+  0xffffff                             # Schema ID (empty value)
+  ""                                   # Schema Data (empty value)
 )
 
-GAMMA=(
-	3
-	33333333
-	301
-	301301
-	0xffff
-	0xffffffff
-	0xdeadbee2
-	0xcafec0caf22dc0de
-	0xffffff
-	""
-)
+TESTS_LOCAL="
+  local_sysctl_ioam_id
+  local_sysctl_ioam_id_wide
+  local_sysctl_ioam_intf_id
+  local_sysctl_ioam_intf_id_wide
+  local_sysctl_ioam_intf_enabled
+  local_ioam_namespace
+  local_ioam_schema
+  local_ioam_schema_namespace
+  local_route_ns
+  local_route_tunsrc
+  local_route_tundst
+  local_route_trace_type
+  local_route_trace_size
+  local_route_trace_type_bits
+  local_route_trace_size_values
+"
 
 TESTS_OUTPUT="
-	out_undef_ns
-	out_no_room
-	out_bits
-	out_full_supp_trace
+  output_undef_ns
+  output_no_room
+  output_no_room_oss
+  output_bits
+  output_sizes
+  output_full_supp_trace
 "
 
 TESTS_INPUT="
-	in_undef_ns
-	in_no_room
-	in_oflag
-	in_bits
-	in_full_supp_trace
+  input_undef_ns
+  input_no_room
+  input_no_room_oss
+  input_disabled
+  input_oflag
+  input_bits
+  input_sizes
+  input_full_supp_trace
 "
 
-TESTS_GLOBAL="
-	fwd_full_supp_trace
-"
-
-
 ################################################################################
 #                                                                              #
 #                                   LIBRARY                                    #
@@ -194,66 +186,64 @@ TESTS_GLOBAL="
 
 check_kernel_compatibility()
 {
-  setup_ns ioam_tmp_node
-  ip link add name veth0 netns $ioam_tmp_node type veth \
-         peer name veth1 netns $ioam_tmp_node
+  setup_ns ioam_tmp_node &>/dev/null
+  local ret=$?
 
-  ip -netns $ioam_tmp_node link set veth0 up
-  ip -netns $ioam_tmp_node link set veth1 up
+  ip link add name veth0 netns $ioam_tmp_node type veth \
+    peer name veth1 netns $ioam_tmp_node &>/dev/null
+  ret=$((ret + $?))
 
-  ip -netns $ioam_tmp_node ioam namespace add 0
-  ns_ad=$?
+  ip -netns $ioam_tmp_node link set veth0 up &>/dev/null
+  ret=$((ret + $?))
 
-  ip -netns $ioam_tmp_node ioam namespace show | grep -q "namespace 0"
-  ns_sh=$?
+  ip -netns $ioam_tmp_node link set veth1 up &>/dev/null
+  ret=$((ret + $?))
 
-  if [[ $ns_ad != 0 || $ns_sh != 0 ]]
+  if [ $ret != 0 ]
   then
-    echo "SKIP: kernel version probably too old, missing ioam support"
-    ip link del veth0 2>/dev/null || true
-    cleanup_ns $ioam_tmp_node || true
+    echo "SKIP: Setup failed."
+    cleanup_ns $ioam_tmp_node
     exit $ksft_skip
   fi
 
-  ip -netns $ioam_tmp_node route add db02::/64 encap ioam6 mode inline \
-         trace prealloc type 0x800000 ns 0 size 4 dev veth0
-  tr_ad=$?
+  ip -netns $ioam_tmp_node route add 2001:db8:2::/64 \
+    encap ioam6 trace prealloc type 0x800000 ns 0 size 4 dev veth0 &>/dev/null
+  ret=$?
 
-  ip -netns $ioam_tmp_node -6 route | grep -q "encap ioam6"
-  tr_sh=$?
+  ip -netns $ioam_tmp_node -6 route 2>/dev/null | grep -q "encap ioam6"
+  ret=$((ret + $?))
 
-  if [[ $tr_ad != 0 || $tr_sh != 0 ]]
+  if [ $ret != 0 ]
   then
-    echo "SKIP: cannot attach an ioam trace to a route, did you compile" \
-         "without CONFIG_IPV6_IOAM6_LWTUNNEL?"
-    ip link del veth0 2>/dev/null || true
-    cleanup_ns $ioam_tmp_node || true
+    echo "SKIP: Cannot attach an IOAM trace to a route. Was your kernel" \
+         "compiled without CONFIG_IPV6_IOAM6_LWTUNNEL? Are you running an" \
+         "old kernel? Are you using an old version of iproute2?"
+    cleanup_ns $ioam_tmp_node
     exit $ksft_skip
   fi
 
-  ip link del veth0 2>/dev/null || true
-  cleanup_ns $ioam_tmp_node || true
+  cleanup_ns $ioam_tmp_node
 
-  lsmod | grep -q "ip6_tunnel"
+  lsmod 2>/dev/null | grep -q "ip6_tunnel"
   ip6tnl_loaded=$?
 
-  if [ $ip6tnl_loaded = 0 ]
+  if [ $ip6tnl_loaded == 0 ]
   then
     encap_tests=0
   else
     modprobe ip6_tunnel &>/dev/null
-    lsmod | grep -q "ip6_tunnel"
+    lsmod 2>/dev/null | grep -q "ip6_tunnel"
     encap_tests=$?
 
     if [ $encap_tests != 0 ]
     then
-      ip a | grep -q "ip6tnl0"
+      ip a 2>/dev/null | grep -q "ip6tnl0"
       encap_tests=$?
 
       if [ $encap_tests != 0 ]
       then
         echo "Note: ip6_tunnel not found neither as a module nor inside the" \
-             "kernel, tests that require it (encap mode) will be omitted"
+             "kernel. Any tests that require it will be skipped."
       fi
     fi
   fi
@@ -261,477 +251,1400 @@ check_kernel_compatibility()
 
 cleanup()
 {
-  ip link del ioam-veth-alpha 2>/dev/null || true
-  ip link del ioam-veth-gamma 2>/dev/null || true
-
-  cleanup_ns $ioam_node_alpha $ioam_node_beta $ioam_node_gamma || true
+  cleanup_ns $ioam_node_alpha $ioam_node_beta $ioam_node_gamma
 
   if [ $ip6tnl_loaded != 0 ]
   then
-    modprobe -r ip6_tunnel 2>/dev/null || true
+    modprobe -r ip6_tunnel &>/dev/null
   fi
 }
 
 setup()
 {
-  setup_ns ioam_node_alpha ioam_node_beta ioam_node_gamma
+  setup_ns ioam_node_alpha ioam_node_beta ioam_node_gamma &>/dev/null
 
   ip link add name ioam-veth-alpha netns $ioam_node_alpha type veth \
-         peer name ioam-veth-betaL netns $ioam_node_beta
+    peer name ioam-veth-betaL netns $ioam_node_beta &>/dev/null
   ip link add name ioam-veth-betaR netns $ioam_node_beta type veth \
-         peer name ioam-veth-gamma netns $ioam_node_gamma
-
-  ip -netns $ioam_node_alpha link set ioam-veth-alpha name veth0
-  ip -netns $ioam_node_beta link set ioam-veth-betaL name veth0
-  ip -netns $ioam_node_beta link set ioam-veth-betaR name veth1
-  ip -netns $ioam_node_gamma link set ioam-veth-gamma name veth0
-
-  ip -netns $ioam_node_alpha addr add db01::2/64 dev veth0
-  ip -netns $ioam_node_alpha link set veth0 up
-  ip -netns $ioam_node_alpha link set lo up
-  ip -netns $ioam_node_alpha route add db02::/64 via db01::1 dev veth0
-  ip -netns $ioam_node_alpha route del db01::/64
-  ip -netns $ioam_node_alpha route add db01::/64 dev veth0
-
-  ip -netns $ioam_node_beta addr add db01::1/64 dev veth0
-  ip -netns $ioam_node_beta addr add db02::1/64 dev veth1
-  ip -netns $ioam_node_beta link set veth0 up
-  ip -netns $ioam_node_beta link set veth1 up
-  ip -netns $ioam_node_beta link set lo up
-
-  ip -netns $ioam_node_gamma addr add db02::2/64 dev veth0
-  ip -netns $ioam_node_gamma link set veth0 up
-  ip -netns $ioam_node_gamma link set lo up
-  ip -netns $ioam_node_gamma route add db01::/64 via db02::1 dev veth0
-
-  # - IOAM config -
-  ip netns exec $ioam_node_alpha sysctl -wq net.ipv6.ioam6_id=${ALPHA[0]}
-  ip netns exec $ioam_node_alpha sysctl -wq net.ipv6.ioam6_id_wide=${ALPHA[1]}
-  ip netns exec $ioam_node_alpha sysctl -wq net.ipv6.conf.veth0.ioam6_id=${ALPHA[4]}
-  ip netns exec $ioam_node_alpha sysctl -wq net.ipv6.conf.veth0.ioam6_id_wide=${ALPHA[5]}
-  ip -netns $ioam_node_alpha ioam namespace add 123 data ${ALPHA[6]} wide ${ALPHA[7]}
-  ip -netns $ioam_node_alpha ioam schema add ${ALPHA[8]} "${ALPHA[9]}"
-  ip -netns $ioam_node_alpha ioam namespace set 123 schema ${ALPHA[8]}
-
-  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.conf.all.forwarding=1
-  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.ioam6_id=${BETA[0]}
-  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.ioam6_id_wide=${BETA[1]}
-  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=1
-  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.conf.veth0.ioam6_id=${BETA[2]}
-  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.conf.veth0.ioam6_id_wide=${BETA[3]}
-  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.conf.veth1.ioam6_id=${BETA[4]}
-  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.conf.veth1.ioam6_id_wide=${BETA[5]}
-  ip -netns $ioam_node_beta ioam namespace add 123 data ${BETA[6]} wide ${BETA[7]}
-  ip -netns $ioam_node_beta ioam schema add ${BETA[8]} "${BETA[9]}"
-  ip -netns $ioam_node_beta ioam namespace set 123 schema ${BETA[8]}
-
-  ip netns exec $ioam_node_gamma sysctl -wq net.ipv6.ioam6_id=${GAMMA[0]}
-  ip netns exec $ioam_node_gamma sysctl -wq net.ipv6.ioam6_id_wide=${GAMMA[1]}
-  ip netns exec $ioam_node_gamma sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=1
-  ip netns exec $ioam_node_gamma sysctl -wq net.ipv6.conf.veth0.ioam6_id=${GAMMA[2]}
-  ip netns exec $ioam_node_gamma sysctl -wq net.ipv6.conf.veth0.ioam6_id_wide=${GAMMA[3]}
-  ip -netns $ioam_node_gamma ioam namespace add 123 data ${GAMMA[6]} wide ${GAMMA[7]}
+    peer name ioam-veth-gamma netns $ioam_node_gamma &>/dev/null
+
+  ip -netns $ioam_node_alpha link set ioam-veth-alpha name veth0 &>/dev/null
+  ip -netns $ioam_node_beta link set ioam-veth-betaL name veth0 &>/dev/null
+  ip -netns $ioam_node_beta link set ioam-veth-betaR name veth1 &>/dev/null
+  ip -netns $ioam_node_gamma link set ioam-veth-gamma name veth0 &>/dev/null
+
+  ip -netns $ioam_node_alpha addr add 2001:db8:1::50/64 dev veth0 &>/dev/null
+  ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
+  ip -netns $ioam_node_alpha link set veth0 up &>/dev/null
+  ip -netns $ioam_node_alpha link set lo up &>/dev/null
+  ip -netns $ioam_node_alpha route add 2001:db8:2::/64 \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  ip -netns $ioam_node_beta addr add 2001:db8:1::1/64 dev veth0 &>/dev/null
+  ip -netns $ioam_node_beta addr add 2001:db8:2::1/64 dev veth1 &>/dev/null
+  ip -netns $ioam_node_beta link set veth0 up &>/dev/null
+  ip -netns $ioam_node_beta link set veth1 up &>/dev/null
+  ip -netns $ioam_node_beta link set lo up &>/dev/null
+
+  ip -netns $ioam_node_gamma addr add 2001:db8:2::2/64 dev veth0 &>/dev/null
+  ip -netns $ioam_node_gamma link set veth0 up &>/dev/null
+  ip -netns $ioam_node_gamma link set lo up &>/dev/null
+  ip -netns $ioam_node_gamma route add 2001:db8:1::/64 \
+    via 2001:db8:2::1 dev veth0 &>/dev/null
+
+  # - Alpha: IOAM config -
+  ip netns exec $ioam_node_alpha \
+    sysctl -wq net.ipv6.ioam6_id=${ALPHA[0]} &>/dev/null
+  ip netns exec $ioam_node_alpha \
+    sysctl -wq net.ipv6.ioam6_id_wide=${ALPHA[1]} &>/dev/null
+  ip netns exec $ioam_node_alpha \
+    sysctl -wq net.ipv6.conf.veth0.ioam6_id=${ALPHA[4]} &>/dev/null
+  ip netns exec $ioam_node_alpha \
+    sysctl -wq net.ipv6.conf.veth0.ioam6_id_wide=${ALPHA[5]} &>/dev/null
+  ip -netns $ioam_node_alpha \
+    ioam namespace add 123 data ${ALPHA[6]} wide ${ALPHA[7]} &>/dev/null
+  ip -netns $ioam_node_alpha \
+    ioam schema add ${ALPHA[8]} "${ALPHA[9]}" &>/dev/null
+  ip -netns $ioam_node_alpha \
+    ioam namespace set 123 schema ${ALPHA[8]} &>/dev/null
+
+  # - Beta: IOAM config -
+  ip netns exec $ioam_node_beta \
+    sysctl -wq net.ipv6.conf.all.forwarding=1 &>/dev/null
+  ip netns exec $ioam_node_beta \
+    sysctl -wq net.ipv6.ioam6_id=${BETA[0]} &>/dev/null
+  ip netns exec $ioam_node_beta \
+    sysctl -wq net.ipv6.ioam6_id_wide=${BETA[1]} &>/dev/null
+  ip netns exec $ioam_node_beta \
+    sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=1 &>/dev/null
+  ip netns exec $ioam_node_beta \
+    sysctl -wq net.ipv6.conf.veth0.ioam6_id=${BETA[2]} &>/dev/null
+  ip netns exec $ioam_node_beta \
+    sysctl -wq net.ipv6.conf.veth0.ioam6_id_wide=${BETA[3]} &>/dev/null
+  ip netns exec $ioam_node_beta \
+    sysctl -wq net.ipv6.conf.veth1.ioam6_id=${BETA[4]} &>/dev/null
+  ip netns exec $ioam_node_beta \
+    sysctl -wq net.ipv6.conf.veth1.ioam6_id_wide=${BETA[5]} &>/dev/null
+  ip -netns $ioam_node_beta ioam namespace add 123 &>/dev/null
 
   sleep 1
 
-  ip netns exec $ioam_node_alpha ping6 -c 5 -W 1 db02::2 &>/dev/null
+  ip netns exec $ioam_node_alpha ping6 -c 5 -W 1 2001:db8:2::2 &>/dev/null
   if [ $? != 0 ]
   then
-    echo "Setup FAILED"
-    cleanup &>/dev/null
-    exit 0
+    echo "SKIP: Setup failed."
+    cleanup
+    exit $ksft_skip
   fi
 }
 
 log_test_passed()
 {
-  local desc=$1
-  printf "TEST: %-60s  [ OK ]\n" "${desc}"
+  printf " - TEST: %-57s  [ OK ]\n" "$1"
+  npassed=$((npassed+1))
 }
 
-log_test_failed()
+log_test_skipped()
 {
-  local desc=$1
-  printf "TEST: %-60s  [FAIL]\n" "${desc}"
+  printf " - TEST: %-57s  [SKIP]\n" "$1"
+  nskipped=$((nskipped+1))
 }
 
-log_results()
+log_test_failed()
 {
-  echo "- Tests passed: ${npassed}"
-  echo "- Tests failed: ${nfailed}"
+  printf " - TEST: %-57s  [FAIL]\n" "$1"
+  nfailed=$((nfailed+1))
 }
 
 run_test()
 {
   local name=$1
   local desc=$2
-  local node_src=$3
-  local node_dst=$4
-  local ip6_dst=$5
-  local trace_type=$6
-  local ioam_ns=$7
-  local type=$8
-
-  ip netns exec $node_dst ./ioam6_parser $name $trace_type $ioam_ns $type &
+  local ip6_src=$3
+  local trace_type=$4
+  local trace_size=$5
+  local ioam_ns=$6
+  local type=$7
+
+  ip netns exec $ioam_node_gamma \
+    ./ioam6_parser veth0 $name $ip6_src 2001:db8:2::2 \
+                   $trace_type $trace_size $ioam_ns $type &
   local spid=$!
   sleep 0.1
 
-  ip netns exec $node_src ping6 -t 64 -c 1 -W 1 $ip6_dst &>/dev/null
+  ip netns exec $ioam_node_alpha ping6 -t 64 -c 1 -W 1 2001:db8:2::2 &>/dev/null
   if [ $? != 0 ]
   then
-    nfailed=$((nfailed+1))
     log_test_failed "${desc}"
     kill -2 $spid &>/dev/null
   else
     wait $spid
-    if [ $? = 0 ]
-    then
-      npassed=$((npassed+1))
-      log_test_passed "${desc}"
-    else
-      nfailed=$((nfailed+1))
-      log_test_failed "${desc}"
-    fi
+    [ $? == 0 ] && log_test_passed "${desc}" || log_test_failed "${desc}"
   fi
 }
 
 run()
 {
+  local test
+
+  echo
+  printf "+"
+  printf "%0.s-" {1..72}
+  printf "+"
+  echo
+  printf "| %-28s LOCAL tests %-29s |"
   echo
-  printf "%0.s-" {1..74}
+  printf "+"
+  printf "%0.s-" {1..72}
+  printf "+"
   echo
-  echo "OUTPUT tests"
-  printf "%0.s-" {1..74}
+
+  echo
+  echo "Global config"
+  for test in $TESTS_LOCAL
+  do
+    $test
+  done
+
+  echo
+  echo "Inline mode"
+  for test in $TESTS_LOCAL
+  do
+    $test "inline"
+  done
+
+  echo
+  echo "Encap mode"
+  for test in $TESTS_LOCAL
+  do
+    $test "encap"
+  done
+
+  echo
+  printf "+"
+  printf "%0.s-" {1..72}
+  printf "+"
+  echo
+  printf "| %-28s OUTPUT tests %-28s |"
+  echo
+  printf "+"
+  printf "%0.s-" {1..72}
+  printf "+"
   echo
 
   # set OUTPUT settings
-  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=0
+  ip netns exec $ioam_node_beta \
+    sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=0 &>/dev/null
 
-  for t in $TESTS_OUTPUT
+  echo
+  echo "Inline mode"
+  for test in $TESTS_OUTPUT
   do
-    $t "inline"
-    [ $encap_tests = 0 ] && $t "encap"
+    $test "inline"
   done
 
-  # clean OUTPUT settings
-  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=1
-  ip -netns $ioam_node_alpha route change db01::/64 dev veth0
+  echo
+  echo "Encap mode"
+  for test in $TESTS_OUTPUT
+  do
+    $test "encap"
+  done
 
+  echo
+  echo "Encap mode (with tunsrc)"
+  for test in $TESTS_OUTPUT
+  do
+    $test "encap" "tunsrc"
+  done
+
+  # clean OUTPUT settings
+  ip netns exec $ioam_node_beta \
+    sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=1 &>/dev/null
 
   echo
-  printf "%0.s-" {1..74}
+  printf "+"
+  printf "%0.s-" {1..72}
+  printf "+"
   echo
-  echo "INPUT tests"
-  printf "%0.s-" {1..74}
+  printf "| %-28s INPUT tests %-29s |"
+  echo
+  printf "+"
+  printf "%0.s-" {1..72}
+  printf "+"
   echo
 
   # set INPUT settings
-  ip -netns $ioam_node_alpha ioam namespace del 123
+  ip -netns $ioam_node_alpha ioam namespace del 123 &>/dev/null
 
-  for t in $TESTS_INPUT
+  echo
+  echo "Inline mode"
+  for test in $TESTS_INPUT
   do
-    $t "inline"
-    [ $encap_tests = 0 ] && $t "encap"
+    $test "inline"
+  done
+
+  echo
+  echo "Encap mode"
+  for test in $TESTS_INPUT
+  do
+    $test "encap"
   done
 
   # clean INPUT settings
-  ip -netns $ioam_node_alpha ioam namespace add 123 \
-         data ${ALPHA[6]} wide ${ALPHA[7]}
-  ip -netns $ioam_node_alpha ioam namespace set 123 schema ${ALPHA[8]}
-  ip -netns $ioam_node_alpha route change db01::/64 dev veth0
+  ip -netns $ioam_node_alpha \
+    ioam namespace add 123 data ${ALPHA[6]} wide ${ALPHA[7]} &>/dev/null
+  ip -netns $ioam_node_alpha \
+    ioam namespace set 123 schema ${ALPHA[8]} &>/dev/null
 
   echo
-  printf "%0.s-" {1..74}
+  printf "+"
+  printf "%0.s-" {1..72}
+  printf "+"
   echo
-  echo "GLOBAL tests"
-  printf "%0.s-" {1..74}
+  printf "| %-30s Results %-31s |"
+  echo
+  printf "+"
+  printf "%0.s-" {1..72}
+  printf "+"
   echo
 
-  for t in $TESTS_GLOBAL
-  do
-    $t "inline"
-    [ $encap_tests = 0 ] && $t "encap"
-  done
-
   echo
-  log_results
+  echo "- Passed:  ${npassed}"
+  echo "- Skipped: ${nskipped}"
+  echo "- Failed:  ${nfailed}"
+  echo
 }
 
 bit2type=(
   0x800000 0x400000 0x200000 0x100000 0x080000 0x040000 0x020000 0x010000
   0x008000 0x004000 0x002000 0x001000 0x000800 0x000400 0x000200 0x000100
-  0x000080 0x000040 0x000020 0x000010 0x000008 0x000004 0x000002
+  0x000080 0x000040 0x000020 0x000010 0x000008 0x000004 0x000002 0x000001
 )
-bit2size=( 4 4 4 4 4 4 4 4 8 8 8 4 4 4 4 4 4 4 4 4 4 4 4 )
+bit2size=( 4 4 4 4 4 4 4 4 8 8 8 4 4 4 4 4 4 4 4 4 4 4 4 0 )
 
 
 ################################################################################
 #                                                                              #
-#                              OUTPUT tests                                    #
+#                                 LOCAL tests                                  #
 #                                                                              #
-#   Two nodes (sender/receiver), IOAM disabled on ingress for the receiver.    #
 ################################################################################
 
-out_undef_ns()
+local_sysctl_ioam_id()
+{
+  ##############################################################################
+  # Make sure the sysctl "net.ipv6.ioam6_id" works as expected.                #
+  ##############################################################################
+  local desc="Sysctl net.ipv6.ioam6_id"
+
+  [ ! -z $1 ] && return
+
+  ip netns exec $ioam_node_alpha \
+    sysctl net.ipv6.ioam6_id 2>/dev/null | grep -wq ${ALPHA[0]}
+
+  [ $? == 0 ] && log_test_passed "${desc}" || log_test_failed "${desc}"
+}
+
+local_sysctl_ioam_id_wide()
 {
   ##############################################################################
-  # Make sure that the encap node won't fill the trace if the chosen IOAM      #
-  # namespace is not configured locally.                                       #
+  # Make sure the sysctl "net.ipv6.ioam6_id_wide" works as expected.           #
   ##############################################################################
-  local desc="Unknown IOAM namespace"
+  local desc="Sysctl net.ipv6.ioam6_id_wide"
 
-  [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
+  [ ! -z $1 ] && return
 
-  ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
-         trace prealloc type 0x800000 ns 0 size 4 dev veth0
+  ip netns exec $ioam_node_alpha \
+    sysctl net.ipv6.ioam6_id_wide 2>/dev/null | grep -wq ${ALPHA[1]}
 
-  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::1 0x800000 0 $1
+  [ $? == 0 ] && log_test_passed "${desc}" || log_test_failed "${desc}"
+}
 
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
+local_sysctl_ioam_intf_id()
+{
+  ##############################################################################
+  # Make sure the sysctl "net.ipv6.conf.XX.ioam6_id" works as expected.        #
+  ##############################################################################
+  local desc="Sysctl net.ipv6.conf.XX.ioam6_id"
+
+  [ ! -z $1 ] && return
+
+  ip netns exec $ioam_node_alpha \
+    sysctl net.ipv6.conf.veth0.ioam6_id 2>/dev/null | grep -wq ${ALPHA[4]}
+
+  [ $? == 0 ] && log_test_passed "${desc}" || log_test_failed "${desc}"
 }
 
-out_no_room()
+local_sysctl_ioam_intf_id_wide()
 {
   ##############################################################################
-  # Make sure that the encap node won't fill the trace and will set the        #
-  # Overflow flag since there is no room enough for its data.                  #
+  # Make sure the sysctl "net.ipv6.conf.XX.ioam6_id_wide" works as expected.   #
   ##############################################################################
-  local desc="Missing trace room"
+  local desc="Sysctl net.ipv6.conf.XX.ioam6_id_wide"
+
+  [ ! -z $1 ] && return
+
+  ip netns exec $ioam_node_alpha \
+    sysctl net.ipv6.conf.veth0.ioam6_id_wide 2>/dev/null | grep -wq ${ALPHA[5]}
+
+  [ $? == 0 ] && log_test_passed "${desc}" || log_test_failed "${desc}"
+}
 
-  [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
+local_sysctl_ioam_intf_enabled()
+{
+  ##############################################################################
+  # Make sure the sysctl "net.ipv6.conf.XX.ioam6_enabled" works as expected.   #
+  ##############################################################################
+  local desc="Sysctl net.ipv6.conf.XX.ioam6_enabled"
 
-  ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
-         trace prealloc type 0xc00000 ns 123 size 4 dev veth0
+  [ ! -z $1 ] && return
 
-  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::1 0xc00000 123 $1
+  ip netns exec $ioam_node_beta \
+    sysctl net.ipv6.conf.veth0.ioam6_enabled 2>/dev/null | grep -wq 1
 
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
+  [ $? == 0 ] && log_test_passed "${desc}" || log_test_failed "${desc}"
 }
 
-out_bits()
+local_ioam_namespace()
 {
   ##############################################################################
-  # Make sure that, for each trace type bit, the encap node will either:       #
-  #  (i)  fill the trace with its data when it is a supported bit              #
-  #  (ii) not fill the trace with its data when it is an unsupported bit       #
+  # Make sure the creation of an IOAM Namespace works as expected.             #
   ##############################################################################
-  local desc="Trace type with bit <n> only"
+  local desc="Create an IOAM Namespace"
 
-  local tmp=${bit2size[22]}
-  bit2size[22]=$(( $tmp + ${#ALPHA[9]} + ((4 - (${#ALPHA[9]} % 4)) % 4) ))
+  [ ! -z $1 ] && return
 
-  [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
+  ip -netns $ioam_node_alpha \
+    ioam namespace show 2>/dev/null | grep -wq 123
+  local ret=$?
 
-  for i in {0..22}
-  do
-    ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
-           trace prealloc type ${bit2type[$i]} ns 123 size ${bit2size[$i]} \
-           dev veth0 &>/dev/null
+  ip -netns $ioam_node_alpha \
+    ioam namespace show 2>/dev/null | grep -wq ${ALPHA[6]}
+  ret=$((ret + $?))
 
-    local cmd_res=$?
-    local descr="${desc/<n>/$i}"
+  ip -netns $ioam_node_alpha \
+    ioam namespace show 2>/dev/null | grep -wq ${ALPHA[7]}
+  ret=$((ret + $?))
+
+  [ $ret == 0 ] && log_test_passed "${desc}" || log_test_failed "${desc}"
+}
+
+local_ioam_schema()
+{
+  ##############################################################################
+  # Make sure the creation of an IOAM Schema works as expected.                #
+  ##############################################################################
+  local desc="Create an IOAM Schema"
+
+  [ ! -z $1 ] && return
+
+  ip -netns $ioam_node_alpha \
+    ioam schema show 2>/dev/null | grep -wq ${ALPHA[8]}
+  local ret=$?
+
+  local sc_data=$(
+    for i in `seq 0 $((${#ALPHA[9]}-1))`
+    do
+      chr=${ALPHA[9]:i:1}
+      printf "%x " "'${chr}"
+    done
+  )
+
+  ip -netns $ioam_node_alpha \
+    ioam schema show 2>/dev/null | grep -q "$sc_data"
+  ret=$((ret + $?))
+
+  [ $ret == 0 ] && log_test_passed "${desc}" || log_test_failed "${desc}"
+}
+
+local_ioam_schema_namespace()
+{
+  ##############################################################################
+  # Make sure the binding of a Schema to a Namespace works as expected.        #
+  ##############################################################################
+  local desc="Bind an IOAM Schema to an IOAM Namespace"
+
+  [ ! -z $1 ] && return
+
+  ip -netns $ioam_node_alpha \
+    ioam namespace show 2>/dev/null | grep -wq ${ALPHA[8]}
+  local ret=$?
+
+  ip -netns $ioam_node_alpha \
+    ioam schema show 2>/dev/null | grep -wq 123
+  ret=$((ret + $?))
+
+  [ $ret == 0 ] && log_test_passed "${desc}" || log_test_failed "${desc}"
+}
+
+local_route_ns()
+{
+  ##############################################################################
+  # Make sure the Namespace-ID is always provided, whatever the mode.          #
+  ##############################################################################
+  local desc="Mandatory Namespace-ID"
+  local mode
+
+  [ -z $1 ] && return
+
+  [ "$1" == "encap" ] && mode="$1 tundst 2001:db8:2::2" || mode="$1"
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type 0x800000 size 4 \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+  local ret1=$?
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type 0x800000 ns 0 size 4 \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+  local ret2=$?
+
+  [[ $ret1 == 0 || $ret2 != 0 ]] && log_test_failed "${desc}" \
+                                 || log_test_passed "${desc}"
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+}
+
+local_route_tunsrc()
+{
+  ##############################################################################
+  # Make sure the Tunnel Source is only (and possibly) used with encap mode.   #
+  ##############################################################################
+  local desc
+  local mode
+  local mode_tunsrc
 
-    if [[ $i -ge 12 && $i -le 21 ]]
+  [ -z $1 ] && return
+
+  if [ "$1" == "encap" ]
+  then
+    desc="Optional Tunnel Source"
+    mode="$1 tundst 2001:db8:2::2"
+    mode_tunsrc="$1 tunsrc 2001:db8:1::50 tundst 2001:db8:2::2"
+  else
+    desc="Unneeded Tunnel Source"
+    mode="$1"
+    mode_tunsrc="$1 tunsrc 2001:db8:1::50"
+  fi
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type 0x800000 ns 0 size 4 \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+  local ret1=$?
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode_tunsrc trace prealloc type 0x800000 ns 0 size 4 \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+  local ret2=$?
+
+  if [ "$1" == "encap" ]
+  then
+    [[ $ret1 != 0 || $ret2 != 0 ]] && log_test_failed "${desc}" \
+                                   || log_test_passed "${desc}"
+  else
+    [[ $ret1 != 0 || $ret2 == 0 ]] && log_test_failed "${desc}" \
+                                   || log_test_passed "${desc}"
+  fi
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+}
+
+local_route_tundst()
+{
+  ##############################################################################
+  # Make sure the Tunnel Destination is only (and always) used with encap mode.#
+  ##############################################################################
+  local desc
+
+  [ -z $1 ] && return
+
+  [ "$1" == "encap" ] && desc="Mandatory Tunnel Destination" \
+                     || desc="Unneeded Tunnel Destination"
+
+  local mode="$1"
+  local mode_tundst="$1 tundst 2001:db8:2::2"
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type 0x800000 ns 0 size 4 \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+  local ret1=$?
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode_tundst trace prealloc type 0x800000 ns 0 size 4 \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+  local ret2=$?
+
+  if [ "$1" == "encap" ]
+  then
+    [[ $ret1 == 0 || $ret2 != 0 ]] && log_test_failed "${desc}" \
+                                   || log_test_passed "${desc}"
+  else
+    [[ $ret1 != 0 || $ret2 == 0 ]] && log_test_failed "${desc}" \
+                                   || log_test_passed "${desc}"
+  fi
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+}
+
+local_route_trace_type()
+{
+  ##############################################################################
+  # Make sure the Trace Type is always provided, whatever the mode.            #
+  ##############################################################################
+  local desc="Mandatory Trace Type"
+  local mode
+
+  [ -z $1 ] && return
+
+  [ "$1" == "encap" ] && mode="$1 tundst 2001:db8:2::2" || mode="$1"
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc ns 0 size 4 \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+  local ret1=$?
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type 0x800000 ns 0 size 4 \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+  local ret2=$?
+
+  [[ $ret1 == 0 || $ret2 != 0 ]] && log_test_failed "${desc}" \
+                                 || log_test_passed "${desc}"
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+}
+
+local_route_trace_size()
+{
+  ##############################################################################
+  # Make sure the Trace Size is always provided, whatever the mode.            #
+  ##############################################################################
+  local desc="Mandatory Trace Size"
+  local mode
+
+  [ -z $1 ] && return
+
+  [ "$1" == "encap" ] && mode="$1 tundst 2001:db8:2::2" || mode="$1"
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type 0x800000 ns 0 \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+  local ret1=$?
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type 0x800000 ns 0 size 4 \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+  local ret2=$?
+
+  [[ $ret1 == 0 || $ret2 != 0 ]] && log_test_failed "${desc}" \
+                                 || log_test_passed "${desc}"
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+}
+
+local_route_trace_type_bits()
+{
+  ##############################################################################
+  # Make sure only allowed bits (0-11 and 22) are accepted.                    #
+  ##############################################################################
+  local desc="Trace Type bits"
+  local mode
+
+  [ -z $1 ] && return
+
+  [ "$1" == "encap" ] && mode="$1 tundst 2001:db8:2::2" || mode="$1"
+
+  local i
+  for i in {0..23}
+  do
+    ip -netns $ioam_node_alpha \
+      route change 2001:db8:2::/64 \
+      encap ioam6 mode $mode trace prealloc type ${bit2type[$i]} ns 0 size 4 \
+      via 2001:db8:1::1 dev veth0 &>/dev/null
+
+    if [[ ($? == 0 && (($i -ge 12 && $i -le 21) || $i == 23)) ||
+          ($? != 0 && (($i -ge 0 && $i -le 11) || $i == 22)) ]]
     then
-      if [ $cmd_res != 0 ]
-      then
-        npassed=$((npassed+1))
-        log_test_passed "$descr ($1 mode)"
-      else
-        nfailed=$((nfailed+1))
-        log_test_failed "$descr ($1 mode)"
-      fi
-    else
-	run_test "out_bit$i" "$descr ($1 mode)" $ioam_node_alpha \
-           $ioam_node_beta db01::1 ${bit2type[$i]} 123 $1
+      local err=1
+      break
     fi
   done
 
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
+  [ -z $err ] && log_test_passed "${desc}" || log_test_failed "${desc}"
 
-  bit2size[22]=$tmp
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
 }
 
-out_full_supp_trace()
+local_route_trace_size_values()
 {
   ##############################################################################
-  # Make sure that the encap node will correctly fill a full trace. Be careful,#
-  # "full trace" here does NOT mean all bits (only supported ones).            #
+  # Make sure only allowed sizes (multiples of four in [4,244]) are accepted.  #
   ##############################################################################
-  local desc="Full supported trace"
+  local desc="Trace Size values"
+  local mode
 
-  [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
+  [ -z $1 ] && return
 
-  ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
-         trace prealloc type 0xfff002 ns 123 size 100 dev veth0
+  [ "$1" == "encap" ] && mode="$1 tundst 2001:db8:2::2" || mode="$1"
 
-  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::1 0xfff002 123 $1
+  # we also try the next multiple of four after the MAX to check it's refused
+  local i
+  for i in {0..248}
+  do
+    ip -netns $ioam_node_alpha \
+      route change 2001:db8:2::/64 \
+      encap ioam6 mode $mode trace prealloc type 0x800000 ns 0 size $i \
+      via 2001:db8:1::1 dev veth0 &>/dev/null
 
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
+    if [[ ($? == 0 && ($i == 0 || $i == 248 || $(( $i % 4 )) != 0)) ||
+          ($? != 0 && $i != 0 && $i != 248 && $(( $i % 4 )) == 0) ]]
+    then
+      local err=1
+      break
+    fi
+  done
+
+  [ -z $err ] && log_test_passed "${desc}" || log_test_failed "${desc}"
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
 }
 
 
 ################################################################################
 #                                                                              #
-#                               INPUT tests                                    #
+#                                 OUTPUT tests                                 #
 #                                                                              #
-#     Two nodes (sender/receiver), the sender MUST NOT fill the trace upon     #
-#     insertion -> the IOAM namespace configured on the sender is removed      #
-#     and is used in the inserted trace to force the sender not to fill it.    #
 ################################################################################
 
-in_undef_ns()
+output_undef_ns()
 {
   ##############################################################################
-  # Make sure that the receiving node won't fill the trace if the related IOAM #
-  # namespace is not configured locally.                                       #
+  # Make sure an IOAM encapsulating node does NOT fill the trace when the      #
+  # corresponding IOAM Namespace-ID is not configured locally.                 #
   ##############################################################################
-  local desc="Unknown IOAM namespace"
+  local desc="Unknown IOAM Namespace-ID"
+  local ns=0
+  local tr_type=0x800000
+  local tr_size=4
+  local mode="$1"
+  local saddr="2001:db8:1::2"
+
+  if [ "$1" == "encap" ]
+  then
+    if [ $encap_tests != 0 ]
+    then
+      log_test_skipped "${desc}"
+      return
+    fi
+
+    if [ "$2" == "tunsrc" ]
+    then
+      saddr="2001:db8:1::50"
+      mode+=" tunsrc 2001:db8:1::50"
+    fi
+
+    mode+=" tundst 2001:db8:2::2"
+    ip -netns $ioam_node_gamma link set ip6tnl0 up &>/dev/null
+  fi
 
-  [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type $tr_type ns $ns size $tr_size \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
 
-  ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
-         trace prealloc type 0x800000 ns 0 size 4 dev veth0
+  if [ $? == 0 ]
+  then
+    run_test ${FUNCNAME[0]} "${desc}" $saddr $tr_type $tr_size $ns $1
+  else
+    log_test_failed "${desc}"
+  fi
 
-  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::1 0x800000 0 $1
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
 
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
+  [ "$1" == "encap" ] && ip -netns $ioam_node_gamma \
+    link set ip6tnl0 down &>/dev/null
 }
 
-in_no_room()
+output_no_room()
 {
   ##############################################################################
-  # Make sure that the receiving node won't fill the trace and will set the    #
-  # Overflow flag if there is no room enough for its data.                     #
+  # Make sure an IOAM encapsulating node does NOT fill the trace AND sets the  #
+  # Overflow flag when there is not enough room for its data.                  #
   ##############################################################################
-  local desc="Missing trace room"
+  local desc="Missing room for data"
+  local ns=123
+  local tr_type=0xc00000
+  local tr_size=4
+  local mode="$1"
+  local saddr="2001:db8:1::2"
+
+  if [ "$1" == "encap" ]
+  then
+    if [ $encap_tests != 0 ]
+    then
+      log_test_skipped "${desc}"
+      return
+    fi
 
-  [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
+    if [ "$2" == "tunsrc" ]
+    then
+      saddr="2001:db8:1::50"
+      mode+=" tunsrc 2001:db8:1::50"
+    fi
 
-  ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
-         trace prealloc type 0xc00000 ns 123 size 4 dev veth0
+    mode+=" tundst 2001:db8:2::2"
+    ip -netns $ioam_node_gamma link set ip6tnl0 up &>/dev/null
+  fi
 
-  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::1 0xc00000 123 $1
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type $tr_type ns $ns size $tr_size \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
 
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
+  if [ $? == 0 ]
+  then
+    run_test ${FUNCNAME[0]} "${desc}" $saddr $tr_type $tr_size $ns $1
+  else
+    log_test_failed "${desc}"
+  fi
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  [ "$1" == "encap" ] && ip -netns $ioam_node_gamma \
+    link set ip6tnl0 down &>/dev/null
 }
 
-in_bits()
+output_no_room_oss()
 {
   ##############################################################################
-  # Make sure that, for each trace type bit, the receiving node will either:   #
-  #  (i)  fill the trace with its data when it is a supported bit              #
-  #  (ii) not fill the trace with its data when it is an unsupported bit       #
+  # Make sure an IOAM encapsulating node does NOT fill the trace AND sets the  #
+  # Overflow flag when there is not enough room for the Opaque State Snapshot. #
   ##############################################################################
-  local desc="Trace type with bit <n> only"
+  local desc="Missing room for Opaque State Snapshot"
+  local ns=123
+  local tr_type=0x000002
+  local tr_size=4
+  local mode="$1"
+  local saddr="2001:db8:1::2"
+
+  if [ "$1" == "encap" ]
+  then
+    if [ $encap_tests != 0 ]
+    then
+      log_test_skipped "${desc}"
+      return
+    fi
 
-  local tmp=${bit2size[22]}
-  bit2size[22]=$(( $tmp + ${#BETA[9]} + ((4 - (${#BETA[9]} % 4)) % 4) ))
+    if [ "$2" == "tunsrc" ]
+    then
+      saddr="2001:db8:1::50"
+      mode+=" tunsrc 2001:db8:1::50"
+    fi
+
+    mode+=" tundst 2001:db8:2::2"
+    ip -netns $ioam_node_gamma link set ip6tnl0 up &>/dev/null
+  fi
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type $tr_type ns $ns size $tr_size \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  if [ $? == 0 ]
+  then
+    run_test ${FUNCNAME[0]} "${desc}" $saddr $tr_type $tr_size $ns $1
+  else
+    log_test_failed "${desc}"
+  fi
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  [ "$1" == "encap" ] && ip -netns $ioam_node_gamma \
+    link set ip6tnl0 down &>/dev/null
+}
+
+output_bits()
+{
+  ##############################################################################
+  # Make sure an IOAM encapsulating node implements all supported bits by      #
+  # checking it correctly fills the trace with its data.                       #
+  ##############################################################################
+  local desc="Trace Type with supported bit <n> only"
+  local ns=123
+  local mode="$1"
+  local saddr="2001:db8:1::2"
 
-  [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
+  if [ "$1" == "encap" ]
+  then
+    if [ "$2" == "tunsrc" ]
+    then
+      saddr="2001:db8:1::50"
+      mode+=" tunsrc 2001:db8:1::50"
+    fi
+
+    mode+=" tundst 2001:db8:2::2"
+    ip -netns $ioam_node_gamma link set ip6tnl0 up &>/dev/null
+  fi
+
+  local tmp=${bit2size[22]}
+  bit2size[22]=$(( $tmp + ${#ALPHA[9]} + ((4 - (${#ALPHA[9]} % 4)) % 4) ))
 
+  local i
   for i in {0..11} {22..22}
   do
-    ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
-           trace prealloc type ${bit2type[$i]} ns 123 size ${bit2size[$i]} \
-           dev veth0
+    local descr="${desc/<n>/$i}"
+
+    if [[ "$1" == "encap" && $encap_tests != 0 ]]
+    then
+      log_test_skipped "${descr}"
+      continue
+    fi
 
-    run_test "in_bit$i" "${desc/<n>/$i} ($1 mode)" $ioam_node_alpha \
-           $ioam_node_beta db01::1 ${bit2type[$i]} 123 $1
+    ip -netns $ioam_node_alpha \
+      route change 2001:db8:2::/64 \
+      encap ioam6 mode $mode trace prealloc \
+      type ${bit2type[$i]} ns $ns size ${bit2size[$i]} \
+      via 2001:db8:1::1 dev veth0 &>/dev/null
+
+    if [ $? == 0 ]
+    then
+      run_test "output_bit$i" "${descr}" $saddr \
+        ${bit2type[$i]} ${bit2size[$i]} $ns $1
+    else
+      log_test_failed "${descr}"
+    fi
   done
 
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  [ "$1" == "encap" ] && ip -netns $ioam_node_gamma \
+    link set ip6tnl0 down &>/dev/null
 
   bit2size[22]=$tmp
 }
 
-in_oflag()
+output_sizes()
 {
   ##############################################################################
-  # Make sure that the receiving node won't fill the trace since the Overflow  #
-  # flag is set.                                                               #
+  # Make sure an IOAM encapsulating node allocates supported sizes correctly.  #
   ##############################################################################
-  local desc="Overflow flag is set"
+  local desc="Trace Size of <n> bytes"
+  local ns=0
+  local tr_type=0x800000
+  local mode="$1"
+  local saddr="2001:db8:1::2"
 
-  # Exception:
-  #   Here, we need the sender to set the Overflow flag. For that, we will add
-  #   back the IOAM namespace that was previously configured on the sender.
-  ip -netns $ioam_node_alpha ioam namespace add 123
+  if [ "$1" == "encap" ]
+  then
+    if [ "$2" == "tunsrc" ]
+    then
+      saddr="2001:db8:1::50"
+      mode+=" tunsrc 2001:db8:1::50"
+    fi
 
-  [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
+    mode+=" tundst 2001:db8:2::2"
+    ip -netns $ioam_node_gamma link set ip6tnl0 up &>/dev/null
+  fi
 
-  ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
-         trace prealloc type 0xc00000 ns 123 size 4 dev veth0
+  local i
+  for i in $(seq 4 4 244)
+  do
+    local descr="${desc/<n>/$i}"
 
-  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::1 0xc00000 123 $1
+    if [[ "$1" == "encap" && $encap_tests != 0 ]]
+    then
+      log_test_skipped "${descr}"
+      continue
+    fi
 
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
+    ip -netns $ioam_node_alpha \
+      route change 2001:db8:2::/64 \
+      encap ioam6 mode $mode trace prealloc type $tr_type ns $ns size $i \
+      via 2001:db8:1::1 dev veth0 &>/dev/null
 
-  # And we clean the exception for this test to get things back to normal for
-  # other INPUT tests
-  ip -netns $ioam_node_alpha ioam namespace del 123
+    if [ $? == 0 ]
+    then
+      run_test "output_size$i" "${descr}" $saddr $tr_type $i $ns $1
+    else
+      log_test_failed "${descr}"
+    fi
+  done
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  [ "$1" == "encap" ] && ip -netns $ioam_node_gamma \
+    link set ip6tnl0 down &>/dev/null
 }
 
-in_full_supp_trace()
+output_full_supp_trace()
 {
   ##############################################################################
-  # Make sure that the receiving node will correctly fill a full trace. Be     #
-  # careful, "full trace" here does NOT mean all bits (only supported ones).   #
+  # Make sure an IOAM encapsulating node correctly fills a trace when all      #
+  # supported bits are set.                                                    #
   ##############################################################################
   local desc="Full supported trace"
+  local ns=123
+  local tr_type=0xfff002
+  local tr_size
+  local mode="$1"
+  local saddr="2001:db8:1::2"
 
-  [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
+  if [ "$1" == "encap" ]
+  then
+    if [ $encap_tests != 0 ]
+    then
+      log_test_skipped "${desc}"
+      return
+    fi
 
-  ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
-         trace prealloc type 0xfff002 ns 123 size 80 dev veth0
+    if [ "$2" == "tunsrc" ]
+    then
+      saddr="2001:db8:1::50"
+      mode+=" tunsrc 2001:db8:1::50"
+    fi
 
-  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::1 0xfff002 123 $1
+    mode+=" tundst 2001:db8:2::2"
+    ip -netns $ioam_node_gamma link set ip6tnl0 up &>/dev/null
+  fi
 
-  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
+  local i
+  tr_size=$(( ${#ALPHA[9]} + ((4 - (${#ALPHA[9]} % 4)) % 4) ))
+  for i in {0..11} {22..22}
+  do
+    tr_size=$((tr_size + bit2size[$i]))
+  done
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type $tr_type ns $ns size $tr_size \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  if [ $? == 0 ]
+  then
+    run_test ${FUNCNAME[0]} "${desc}" $saddr $tr_type $tr_size $ns $1
+  else
+    log_test_failed "${desc}"
+  fi
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  [ "$1" == "encap" ] && ip -netns $ioam_node_gamma \
+    link set ip6tnl0 down &>/dev/null
 }
 
 
 ################################################################################
 #                                                                              #
-#                              GLOBAL tests                                    #
+#                                 INPUT tests                                  #
 #                                                                              #
-#   Three nodes (sender/router/receiver), IOAM fully enabled on every node.    #
 ################################################################################
 
-fwd_full_supp_trace()
+input_undef_ns()
+{
+  ##############################################################################
+  # Make sure an IOAM node does NOT fill the trace when the corresponding IOAM #
+  # Namespace-ID is not configured locally.                                    #
+  ##############################################################################
+  local desc="Unknown IOAM Namespace-ID"
+  local ns=0
+  local tr_type=0x800000
+  local tr_size=4
+  local mode="$1"
+
+  if [ "$1" == "encap" ]
+  then
+    if [ $encap_tests != 0 ]
+    then
+      log_test_skipped "${desc}"
+      return
+    fi
+
+    mode+=" tundst 2001:db8:2::2"
+    ip -netns $ioam_node_gamma link set ip6tnl0 up &>/dev/null
+  fi
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type $tr_type ns $ns size $tr_size \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  if [ $? == 0 ]
+  then
+    run_test ${FUNCNAME[0]} "${desc}" 2001:db8:1::2 $tr_type $tr_size $ns $1
+  else
+    log_test_failed "${desc}"
+  fi
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  [ "$1" == "encap" ] && ip -netns $ioam_node_gamma \
+    link set ip6tnl0 down &>/dev/null
+}
+
+input_no_room()
+{
+  ##############################################################################
+  # Make sure an IOAM node does NOT fill the trace AND sets the Overflow flag  #
+  # when there is not enough room for its data.                                #
+  ##############################################################################
+  local desc="Missing room for data"
+  local ns=123
+  local tr_type=0xc00000
+  local tr_size=4
+  local mode="$1"
+
+  if [ "$1" == "encap" ]
+  then
+    if [ $encap_tests != 0 ]
+    then
+      log_test_skipped "${desc}"
+      return
+    fi
+
+    mode+=" tundst 2001:db8:2::2"
+    ip -netns $ioam_node_gamma link set ip6tnl0 up &>/dev/null
+  fi
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type $tr_type ns $ns size $tr_size \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  if [ $? == 0 ]
+  then
+    run_test ${FUNCNAME[0]} "${desc}" 2001:db8:1::2 $tr_type $tr_size $ns $1
+  else
+    log_test_failed "${desc}"
+  fi
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  [ "$1" == "encap" ] && ip -netns $ioam_node_gamma \
+    link set ip6tnl0 down &>/dev/null
+}
+
+input_no_room_oss()
+{
+  ##############################################################################
+  # Make sure an IOAM node does NOT fill the trace AND sets the Overflow flag  #
+  # when there is not enough room for the Opaque State Snapshot.               #
+  ##############################################################################
+  local desc="Missing room for Opaque State Snapshot"
+  local ns=123
+  local tr_type=0x000002
+  local tr_size=4
+  local mode="$1"
+
+  if [ "$1" == "encap" ]
+  then
+    if [ $encap_tests != 0 ]
+    then
+      log_test_skipped "${desc}"
+      return
+    fi
+
+    mode+=" tundst 2001:db8:2::2"
+    ip -netns $ioam_node_gamma link set ip6tnl0 up &>/dev/null
+  fi
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type $tr_type ns $ns size $tr_size \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  if [ $? == 0 ]
+  then
+    run_test ${FUNCNAME[0]} "${desc}" 2001:db8:1::2 $tr_type $tr_size $ns $1
+  else
+    log_test_failed "${desc}"
+  fi
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  [ "$1" == "encap" ] && ip -netns $ioam_node_gamma \
+    link set ip6tnl0 down &>/dev/null
+}
+
+input_disabled()
+{
+  ##############################################################################
+  # Make sure an IOAM node does NOT fill the trace when IOAM is not enabled on #
+  # the corresponding (ingress) interface.                                     #
+  ##############################################################################
+  local desc="IOAM disabled on ingress interface"
+  local ns=123
+  local tr_type=0x800000
+  local tr_size=4
+  local mode="$1"
+
+  if [ "$1" == "encap" ]
+  then
+    if [ $encap_tests != 0 ]
+    then
+      log_test_skipped "${desc}"
+      return
+    fi
+
+    mode+=" tundst 2001:db8:2::2"
+    ip -netns $ioam_node_gamma link set ip6tnl0 up &>/dev/null
+  fi
+
+  # Exception: disable IOAM on ingress interface
+  ip netns exec $ioam_node_beta \
+    sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=0 &>/dev/null
+  local ret=$?
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type $tr_type ns $ns size $tr_size \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+  ret=$((ret + $?))
+
+  if [ $ret == 0 ]
+  then
+    run_test ${FUNCNAME[0]} "${desc}" 2001:db8:1::2 $tr_type $tr_size $ns $1
+  else
+    log_test_failed "${desc}"
+  fi
+
+  # Clean Exception
+  ip netns exec $ioam_node_beta \
+    sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=1 &>/dev/null
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  [ "$1" == "encap" ] && ip -netns $ioam_node_gamma \
+    link set ip6tnl0 down &>/dev/null
+}
+
+input_oflag()
+{
+  ##############################################################################
+  # Make sure an IOAM node does NOT fill the trace when the Overflow flag is   #
+  # set.                                                                       #
+  ##############################################################################
+  local desc="Overflow flag is set"
+  local ns=123
+  local tr_type=0xc00000
+  local tr_size=4
+  local mode="$1"
+
+  if [ "$1" == "encap" ]
+  then
+    if [ $encap_tests != 0 ]
+    then
+      log_test_skipped "${desc}"
+      return
+    fi
+
+    mode+=" tundst 2001:db8:2::2"
+    ip -netns $ioam_node_gamma link set ip6tnl0 up &>/dev/null
+  fi
+
+  # Exception:
+  #   Here, we need the sender to set the Overflow flag. For that, we will add
+  #   back the IOAM namespace that was previously configured on the sender.
+  ip -netns $ioam_node_alpha ioam namespace add 123 &>/dev/null
+  local ret=$?
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type $tr_type ns $ns size $tr_size \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+  ret=$((ret + $?))
+
+  if [ $ret == 0 ]
+  then
+    run_test ${FUNCNAME[0]} "${desc}" 2001:db8:1::2 $tr_type $tr_size $ns $1
+  else
+    log_test_failed "${desc}"
+  fi
+
+  # Clean Exception
+  ip -netns $ioam_node_alpha ioam namespace del 123 &>/dev/null
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  [ "$1" == "encap" ] && ip -netns $ioam_node_gamma \
+    link set ip6tnl0 down &>/dev/null
+}
+
+input_bits()
+{
+  ##############################################################################
+  # Make sure an IOAM node implements all supported bits by checking it        #
+  # correctly fills the trace with its data.                                   #
+  ##############################################################################
+  local desc="Trace Type with supported bit <n> only"
+  local ns=123
+  local mode="$1"
+
+  if [ "$1" == "encap" ]
+  then
+    mode+=" tundst 2001:db8:2::2"
+    ip -netns $ioam_node_gamma link set ip6tnl0 up &>/dev/null
+  fi
+
+  local tmp=${bit2size[22]}
+  bit2size[22]=$(( $tmp + ${#BETA[9]} + ((4 - (${#BETA[9]} % 4)) % 4) ))
+
+  local i
+  for i in {0..11} {22..22}
+  do
+    local descr="${desc/<n>/$i}"
+
+    if [[ "$1" == "encap" && $encap_tests != 0 ]]
+    then
+      log_test_skipped "${descr}"
+      continue
+    fi
+
+    ip -netns $ioam_node_alpha \
+      route change 2001:db8:2::/64 \
+      encap ioam6 mode $mode trace prealloc \
+      type ${bit2type[$i]} ns $ns size ${bit2size[$i]} \
+      via 2001:db8:1::1 dev veth0 &>/dev/null
+
+    if [ $? == 0 ]
+    then
+      run_test "input_bit$i" "${descr}" 2001:db8:1::2 \
+        ${bit2type[$i]} ${bit2size[$i]} $ns $1
+    else
+      log_test_failed "${descr}"
+    fi
+  done
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  [ "$1" == "encap" ] && ip -netns $ioam_node_gamma \
+    link set ip6tnl0 down &>/dev/null
+
+  bit2size[22]=$tmp
+}
+
+input_sizes()
 {
   ##############################################################################
-  # Make sure that all three nodes correctly filled the full supported trace   #
-  # by checking that the trace data is consistent with the predefined config.  #
+  # Make sure an IOAM node handles all supported sizes correctly.              #
   ##############################################################################
-  local desc="Forward - Full supported trace"
+  local desc="Trace Size of <n> bytes"
+  local ns=123
+  local tr_type=0x800000
+  local mode="$1"
+
+  if [ "$1" == "encap" ]
+  then
+    mode+=" tundst 2001:db8:2::2"
+    ip -netns $ioam_node_gamma link set ip6tnl0 up &>/dev/null
+  fi
 
-  [ "$1" = "encap" ] && mode="$1 tundst db02::2" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns $ioam_node_gamma link set ip6tnl0 up
+  local i
+  for i in $(seq 4 4 244)
+  do
+    local descr="${desc/<n>/$i}"
 
-  ip -netns $ioam_node_alpha route change db02::/64 encap ioam6 mode $mode \
-         trace prealloc type 0xfff002 ns 123 size 244 via db01::1 dev veth0
+    if [[ "$1" == "encap" && $encap_tests != 0 ]]
+    then
+      log_test_skipped "${descr}"
+      continue
+    fi
 
-  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_gamma \
-         db02::2 0xfff002 123 $1
+    ip -netns $ioam_node_alpha \
+      route change 2001:db8:2::/64 \
+      encap ioam6 mode $mode trace prealloc type $tr_type ns $ns size $i \
+      via 2001:db8:1::1 dev veth0 &>/dev/null
 
-  [ "$1" = "encap" ] && ip -netns $ioam_node_gamma link set ip6tnl0 down
+    if [ $? == 0 ]
+    then
+      run_test "input_size$i" "${descr}" 2001:db8:1::2 $tr_type $i $ns $1
+    else
+      log_test_failed "${descr}"
+    fi
+  done
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  [ "$1" == "encap" ] && ip -netns $ioam_node_gamma \
+    link set ip6tnl0 down &>/dev/null
+}
+
+input_full_supp_trace()
+{
+  ##############################################################################
+  # Make sure an IOAM node correctly fills a trace when all supported bits are #
+  # set.                                                                       #
+  ##############################################################################
+  local desc="Full supported trace"
+  local ns=123
+  local tr_type=0xfff002
+  local tr_size
+  local mode="$1"
+
+  if [ "$1" == "encap" ]
+  then
+    if [ $encap_tests != 0 ]
+    then
+      log_test_skipped "${desc}"
+      return
+    fi
+
+    mode+=" tundst 2001:db8:2::2"
+    ip -netns $ioam_node_gamma link set ip6tnl0 up &>/dev/null
+  fi
+
+  local i
+  tr_size=$(( ${#BETA[9]} + ((4 - (${#BETA[9]} % 4)) % 4) ))
+  for i in {0..11} {22..22}
+  do
+    tr_size=$((tr_size + bit2size[$i]))
+  done
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 \
+    encap ioam6 mode $mode trace prealloc type $tr_type ns $ns size $tr_size \
+    via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  if [ $? == 0 ]
+  then
+    run_test ${FUNCNAME[0]} "${desc}" 2001:db8:1::2 $tr_type $tr_size $ns $1
+  else
+    log_test_failed "${desc}"
+  fi
+
+  ip -netns $ioam_node_alpha \
+    route change 2001:db8:2::/64 via 2001:db8:1::1 dev veth0 &>/dev/null
+
+  [ "$1" == "encap" ] && ip -netns $ioam_node_gamma \
+    link set ip6tnl0 down &>/dev/null
 }
 
 
@@ -742,30 +1655,29 @@ fwd_full_supp_trace()
 ################################################################################
 
 npassed=0
+nskipped=0
 nfailed=0
 
 if [ "$(id -u)" -ne 0 ]
 then
-  echo "SKIP: Need root privileges"
+  echo "SKIP: Need root privileges."
   exit $ksft_skip
 fi
 
 if [ ! -x "$(command -v ip)" ]
 then
-  echo "SKIP: Could not run test without ip tool"
-  exit $ksft_skip
-fi
-
-ip ioam &>/dev/null
-if [ $? = 1 ]
-then
-  echo "SKIP: iproute2 too old, missing ioam command"
+  echo "SKIP: Could not run test without ip tool."
   exit $ksft_skip
 fi
 
 check_kernel_compatibility
-
-cleanup &>/dev/null
 setup
 run
-cleanup &>/dev/null
+cleanup
+
+if [ $nfailed != 0 ]
+then
+  exit $ksft_fail
+fi
+
+exit $ksft_pass
diff --git a/tools/testing/selftests/net/ioam6_parser.c b/tools/testing/selftests/net/ioam6_parser.c
index 895e5bb5044b..de4b5c9e8a74 100644
--- a/tools/testing/selftests/net/ioam6_parser.c
+++ b/tools/testing/selftests/net/ioam6_parser.c
@@ -8,8 +8,10 @@
 #include <errno.h>
 #include <limits.h>
 #include <linux/const.h>
+#include <linux/if_ether.h>
 #include <linux/ioam6.h>
 #include <linux/ipv6.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
@@ -40,7 +42,7 @@ static struct ioam_config node1 = {
 	.egr_id = 101,
 	.ingr_wide = 0xffffffff, /* default value */
 	.egr_wide = 101101,
-	.ns_data = 0xdeadbee0,
+	.ns_data = 0xdeadbeef,
 	.ns_wide = 0xcafec0caf00dc0de,
 	.sc_id = 777,
 	.sc_data = "something that will be 4n-aligned",
@@ -54,33 +56,22 @@ static struct ioam_config node2 = {
 	.egr_id = 202,
 	.ingr_wide = 201201,
 	.egr_wide = 202202,
-	.ns_data = 0xdeadbee1,
-	.ns_wide = 0xcafec0caf11dc0de,
-	.sc_id = 666,
-	.sc_data = "Hello there -Obi",
-	.hlim = 63,
-};
-
-static struct ioam_config node3 = {
-	.id = 3,
-	.wide = 33333333,
-	.ingr_id = 301,
-	.egr_id = 0xffff, /* default value */
-	.ingr_wide = 301301,
-	.egr_wide = 0xffffffff, /* default value */
-	.ns_data = 0xdeadbee2,
-	.ns_wide = 0xcafec0caf22dc0de,
+	.ns_data = 0xffffffff, /* default value */
+	.ns_wide = 0xffffffffffffffff, /* default value */
 	.sc_id = 0xffffff, /* default value */
 	.sc_data = NULL,
-	.hlim = 62,
+	.hlim = 63,
 };
 
 enum {
 	/**********
 	 * OUTPUT *
 	 **********/
+	__TEST_OUT_MIN,
+
 	TEST_OUT_UNDEF_NS,
 	TEST_OUT_NO_ROOM,
+	TEST_OUT_NO_ROOM_OSS,
 	TEST_OUT_BIT0,
 	TEST_OUT_BIT1,
 	TEST_OUT_BIT2,
@@ -94,13 +85,80 @@ enum {
 	TEST_OUT_BIT10,
 	TEST_OUT_BIT11,
 	TEST_OUT_BIT22,
+	TEST_OUT_SIZE4,
+	TEST_OUT_SIZE8,
+	TEST_OUT_SIZE12,
+	TEST_OUT_SIZE16,
+	TEST_OUT_SIZE20,
+	TEST_OUT_SIZE24,
+	TEST_OUT_SIZE28,
+	TEST_OUT_SIZE32,
+	TEST_OUT_SIZE36,
+	TEST_OUT_SIZE40,
+	TEST_OUT_SIZE44,
+	TEST_OUT_SIZE48,
+	TEST_OUT_SIZE52,
+	TEST_OUT_SIZE56,
+	TEST_OUT_SIZE60,
+	TEST_OUT_SIZE64,
+	TEST_OUT_SIZE68,
+	TEST_OUT_SIZE72,
+	TEST_OUT_SIZE76,
+	TEST_OUT_SIZE80,
+	TEST_OUT_SIZE84,
+	TEST_OUT_SIZE88,
+	TEST_OUT_SIZE92,
+	TEST_OUT_SIZE96,
+	TEST_OUT_SIZE100,
+	TEST_OUT_SIZE104,
+	TEST_OUT_SIZE108,
+	TEST_OUT_SIZE112,
+	TEST_OUT_SIZE116,
+	TEST_OUT_SIZE120,
+	TEST_OUT_SIZE124,
+	TEST_OUT_SIZE128,
+	TEST_OUT_SIZE132,
+	TEST_OUT_SIZE136,
+	TEST_OUT_SIZE140,
+	TEST_OUT_SIZE144,
+	TEST_OUT_SIZE148,
+	TEST_OUT_SIZE152,
+	TEST_OUT_SIZE156,
+	TEST_OUT_SIZE160,
+	TEST_OUT_SIZE164,
+	TEST_OUT_SIZE168,
+	TEST_OUT_SIZE172,
+	TEST_OUT_SIZE176,
+	TEST_OUT_SIZE180,
+	TEST_OUT_SIZE184,
+	TEST_OUT_SIZE188,
+	TEST_OUT_SIZE192,
+	TEST_OUT_SIZE196,
+	TEST_OUT_SIZE200,
+	TEST_OUT_SIZE204,
+	TEST_OUT_SIZE208,
+	TEST_OUT_SIZE212,
+	TEST_OUT_SIZE216,
+	TEST_OUT_SIZE220,
+	TEST_OUT_SIZE224,
+	TEST_OUT_SIZE228,
+	TEST_OUT_SIZE232,
+	TEST_OUT_SIZE236,
+	TEST_OUT_SIZE240,
+	TEST_OUT_SIZE244,
 	TEST_OUT_FULL_SUPP_TRACE,
 
+	__TEST_OUT_MAX,
+
 	/*********
 	 * INPUT *
 	 *********/
+	__TEST_IN_MIN,
+
 	TEST_IN_UNDEF_NS,
 	TEST_IN_NO_ROOM,
+	TEST_IN_NO_ROOM_OSS,
+	TEST_IN_DISABLED,
 	TEST_IN_OFLAG,
 	TEST_IN_BIT0,
 	TEST_IN_BIT1,
@@ -115,36 +173,107 @@ enum {
 	TEST_IN_BIT10,
 	TEST_IN_BIT11,
 	TEST_IN_BIT22,
+	TEST_IN_SIZE4,
+	TEST_IN_SIZE8,
+	TEST_IN_SIZE12,
+	TEST_IN_SIZE16,
+	TEST_IN_SIZE20,
+	TEST_IN_SIZE24,
+	TEST_IN_SIZE28,
+	TEST_IN_SIZE32,
+	TEST_IN_SIZE36,
+	TEST_IN_SIZE40,
+	TEST_IN_SIZE44,
+	TEST_IN_SIZE48,
+	TEST_IN_SIZE52,
+	TEST_IN_SIZE56,
+	TEST_IN_SIZE60,
+	TEST_IN_SIZE64,
+	TEST_IN_SIZE68,
+	TEST_IN_SIZE72,
+	TEST_IN_SIZE76,
+	TEST_IN_SIZE80,
+	TEST_IN_SIZE84,
+	TEST_IN_SIZE88,
+	TEST_IN_SIZE92,
+	TEST_IN_SIZE96,
+	TEST_IN_SIZE100,
+	TEST_IN_SIZE104,
+	TEST_IN_SIZE108,
+	TEST_IN_SIZE112,
+	TEST_IN_SIZE116,
+	TEST_IN_SIZE120,
+	TEST_IN_SIZE124,
+	TEST_IN_SIZE128,
+	TEST_IN_SIZE132,
+	TEST_IN_SIZE136,
+	TEST_IN_SIZE140,
+	TEST_IN_SIZE144,
+	TEST_IN_SIZE148,
+	TEST_IN_SIZE152,
+	TEST_IN_SIZE156,
+	TEST_IN_SIZE160,
+	TEST_IN_SIZE164,
+	TEST_IN_SIZE168,
+	TEST_IN_SIZE172,
+	TEST_IN_SIZE176,
+	TEST_IN_SIZE180,
+	TEST_IN_SIZE184,
+	TEST_IN_SIZE188,
+	TEST_IN_SIZE192,
+	TEST_IN_SIZE196,
+	TEST_IN_SIZE200,
+	TEST_IN_SIZE204,
+	TEST_IN_SIZE208,
+	TEST_IN_SIZE212,
+	TEST_IN_SIZE216,
+	TEST_IN_SIZE220,
+	TEST_IN_SIZE224,
+	TEST_IN_SIZE228,
+	TEST_IN_SIZE232,
+	TEST_IN_SIZE236,
+	TEST_IN_SIZE240,
+	TEST_IN_SIZE244,
 	TEST_IN_FULL_SUPP_TRACE,
 
-	/**********
-	 * GLOBAL *
-	 **********/
-	TEST_FWD_FULL_SUPP_TRACE,
+	__TEST_IN_MAX,
 
 	__TEST_MAX,
 };
 
-static int check_ioam_header(int tid, struct ioam6_trace_hdr *ioam6h,
-			     __u32 trace_type, __u16 ioam_ns)
+static int check_header(int tid, struct ioam6_trace_hdr *trace,
+			__u32 trace_type, __u8 trace_size, __u16 ioam_ns)
 {
-	if (__be16_to_cpu(ioam6h->namespace_id) != ioam_ns ||
-	    __be32_to_cpu(ioam6h->type_be32) != (trace_type << 8))
+	if (__be16_to_cpu(trace->namespace_id) != ioam_ns ||
+	    __be32_to_cpu(trace->type_be32) != (trace_type << 8))
 		return 1;
 
 	switch (tid) {
 	case TEST_OUT_UNDEF_NS:
 	case TEST_IN_UNDEF_NS:
-		return ioam6h->overflow ||
-		       ioam6h->nodelen != 1 ||
-		       ioam6h->remlen != 1;
+	case TEST_IN_DISABLED:
+		return trace->overflow == 1 ||
+		       trace->nodelen != 1 ||
+		       trace->remlen != 1;
 
 	case TEST_OUT_NO_ROOM:
 	case TEST_IN_NO_ROOM:
 	case TEST_IN_OFLAG:
-		return !ioam6h->overflow ||
-		       ioam6h->nodelen != 2 ||
-		       ioam6h->remlen != 1;
+		return trace->overflow == 0 ||
+		       trace->nodelen != 2 ||
+		       trace->remlen != 1;
+
+	case TEST_OUT_NO_ROOM_OSS:
+		return trace->overflow == 0 ||
+		       trace->nodelen != 0 ||
+		       trace->remlen != 1;
+
+	case TEST_IN_NO_ROOM_OSS:
+	case TEST_OUT_BIT22:
+	case TEST_IN_BIT22:
+		return trace->overflow == 1 ||
+		       trace->nodelen != 0 ||
+		       trace->remlen != 0;
 
 	case TEST_OUT_BIT0:
 	case TEST_IN_BIT0:
@@ -164,9 +293,9 @@ static int check_ioam_header(int tid, struct ioam6_trace_hdr *ioam6h,
 	case TEST_IN_BIT7:
 	case TEST_OUT_BIT11:
 	case TEST_IN_BIT11:
-		return ioam6h->overflow ||
-		       ioam6h->nodelen != 1 ||
-		       ioam6h->remlen;
+		return trace->overflow == 1 ||
+		       trace->nodelen != 1 ||
+		       trace->remlen != 0;
 
 	case TEST_OUT_BIT8:
 	case TEST_IN_BIT8:
@@ -174,22 +303,145 @@ static int check_ioam_header(int tid, struct ioam6_trace_hdr *ioam6h,
 	case TEST_IN_BIT9:
 	case TEST_OUT_BIT10:
 	case TEST_IN_BIT10:
-		return ioam6h->overflow ||
-		       ioam6h->nodelen != 2 ||
-		       ioam6h->remlen;
-
-	case TEST_OUT_BIT22:
-	case TEST_IN_BIT22:
-		return ioam6h->overflow ||
-		       ioam6h->nodelen ||
-		       ioam6h->remlen;
+		return trace->overflow == 1 ||
+		       trace->nodelen != 2 ||
+		       trace->remlen != 0;
+
+	case TEST_OUT_SIZE4:
+	case TEST_OUT_SIZE8:
+	case TEST_OUT_SIZE12:
+	case TEST_OUT_SIZE16:
+	case TEST_OUT_SIZE20:
+	case TEST_OUT_SIZE24:
+	case TEST_OUT_SIZE28:
+	case TEST_OUT_SIZE32:
+	case TEST_OUT_SIZE36:
+	case TEST_OUT_SIZE40:
+	case TEST_OUT_SIZE44:
+	case TEST_OUT_SIZE48:
+	case TEST_OUT_SIZE52:
+	case TEST_OUT_SIZE56:
+	case TEST_OUT_SIZE60:
+	case TEST_OUT_SIZE64:
+	case TEST_OUT_SIZE68:
+	case TEST_OUT_SIZE72:
+	case TEST_OUT_SIZE76:
+	case TEST_OUT_SIZE80:
+	case TEST_OUT_SIZE84:
+	case TEST_OUT_SIZE88:
+	case TEST_OUT_SIZE92:
+	case TEST_OUT_SIZE96:
+	case TEST_OUT_SIZE100:
+	case TEST_OUT_SIZE104:
+	case TEST_OUT_SIZE108:
+	case TEST_OUT_SIZE112:
+	case TEST_OUT_SIZE116:
+	case TEST_OUT_SIZE120:
+	case TEST_OUT_SIZE124:
+	case TEST_OUT_SIZE128:
+	case TEST_OUT_SIZE132:
+	case TEST_OUT_SIZE136:
+	case TEST_OUT_SIZE140:
+	case TEST_OUT_SIZE144:
+	case TEST_OUT_SIZE148:
+	case TEST_OUT_SIZE152:
+	case TEST_OUT_SIZE156:
+	case TEST_OUT_SIZE160:
+	case TEST_OUT_SIZE164:
+	case TEST_OUT_SIZE168:
+	case TEST_OUT_SIZE172:
+	case TEST_OUT_SIZE176:
+	case TEST_OUT_SIZE180:
+	case TEST_OUT_SIZE184:
+	case TEST_OUT_SIZE188:
+	case TEST_OUT_SIZE192:
+	case TEST_OUT_SIZE196:
+	case TEST_OUT_SIZE200:
+	case TEST_OUT_SIZE204:
+	case TEST_OUT_SIZE208:
+	case TEST_OUT_SIZE212:
+	case TEST_OUT_SIZE216:
+	case TEST_OUT_SIZE220:
+	case TEST_OUT_SIZE224:
+	case TEST_OUT_SIZE228:
+	case TEST_OUT_SIZE232:
+	case TEST_OUT_SIZE236:
+	case TEST_OUT_SIZE240:
+	case TEST_OUT_SIZE244:
+		return trace->overflow == 1 ||
+		       trace->nodelen != 1 ||
+		       trace->remlen != trace_size / 4;
+
+	case TEST_IN_SIZE4:
+	case TEST_IN_SIZE8:
+	case TEST_IN_SIZE12:
+	case TEST_IN_SIZE16:
+	case TEST_IN_SIZE20:
+	case TEST_IN_SIZE24:
+	case TEST_IN_SIZE28:
+	case TEST_IN_SIZE32:
+	case TEST_IN_SIZE36:
+	case TEST_IN_SIZE40:
+	case TEST_IN_SIZE44:
+	case TEST_IN_SIZE48:
+	case TEST_IN_SIZE52:
+	case TEST_IN_SIZE56:
+	case TEST_IN_SIZE60:
+	case TEST_IN_SIZE64:
+	case TEST_IN_SIZE68:
+	case TEST_IN_SIZE72:
+	case TEST_IN_SIZE76:
+	case TEST_IN_SIZE80:
+	case TEST_IN_SIZE84:
+	case TEST_IN_SIZE88:
+	case TEST_IN_SIZE92:
+	case TEST_IN_SIZE96:
+	case TEST_IN_SIZE100:
+	case TEST_IN_SIZE104:
+	case TEST_IN_SIZE108:
+	case TEST_IN_SIZE112:
+	case TEST_IN_SIZE116:
+	case TEST_IN_SIZE120:
+	case TEST_IN_SIZE124:
+	case TEST_IN_SIZE128:
+	case TEST_IN_SIZE132:
+	case TEST_IN_SIZE136:
+	case TEST_IN_SIZE140:
+	case TEST_IN_SIZE144:
+	case TEST_IN_SIZE148:
+	case TEST_IN_SIZE152:
+	case TEST_IN_SIZE156:
+	case TEST_IN_SIZE160:
+	case TEST_IN_SIZE164:
+	case TEST_IN_SIZE168:
+	case TEST_IN_SIZE172:
+	case TEST_IN_SIZE176:
+	case TEST_IN_SIZE180:
+	case TEST_IN_SIZE184:
+	case TEST_IN_SIZE188:
+	case TEST_IN_SIZE192:
+	case TEST_IN_SIZE196:
+	case TEST_IN_SIZE200:
+	case TEST_IN_SIZE204:
+	case TEST_IN_SIZE208:
+	case TEST_IN_SIZE212:
+	case TEST_IN_SIZE216:
+	case TEST_IN_SIZE220:
+	case TEST_IN_SIZE224:
+	case TEST_IN_SIZE228:
+	case TEST_IN_SIZE232:
+	case TEST_IN_SIZE236:
+	case TEST_IN_SIZE240:
+	case TEST_IN_SIZE244:
+		return trace->overflow == 1 ||
+		       trace->nodelen != 1 ||
+		       trace->remlen != (trace_size / 4) - trace->nodelen;
 
 	case TEST_OUT_FULL_SUPP_TRACE:
 	case TEST_IN_FULL_SUPP_TRACE:
-	case TEST_FWD_FULL_SUPP_TRACE:
-		return ioam6h->overflow ||
-		       ioam6h->nodelen != 15 ||
-		       ioam6h->remlen;
+		return trace->overflow == 1 ||
+		       trace->nodelen != 15 ||
+		       trace->remlen != 0;
 
 	default:
 		break;
@@ -198,167 +450,137 @@ static int check_ioam_header(int tid, struct ioam6_trace_hdr *ioam6h,
 	return 1;
 }
 
-static int check_ioam6_data(__u8 **p, struct ioam6_trace_hdr *ioam6h,
-			    const struct ioam_config cnf)
+static int check_data(struct ioam6_trace_hdr *trace, __u8 trace_size,
+		      const struct ioam_config cnf, bool is_output)
 {
-	unsigned int len;
+	unsigned int len, i;
 	__u8 aligned;
 	__u64 raw64;
 	__u32 raw32;
+	__u8 *p;
 
-	if (ioam6h->type.bit0) {
-		raw32 = __be32_to_cpu(*((__u32 *)*p));
-		if (cnf.hlim != (raw32 >> 24) || cnf.id != (raw32 & 0xffffff))
-			return 1;
-		*p += sizeof(__u32);
-	}
-
-	if (ioam6h->type.bit1) {
-		raw32 = __be32_to_cpu(*((__u32 *)*p));
-		if (cnf.ingr_id != (raw32 >> 16) ||
-		    cnf.egr_id != (raw32 & 0xffff))
-			return 1;
-		*p += sizeof(__u32);
-	}
-
-	if (ioam6h->type.bit2)
-		*p += sizeof(__u32);
-
-	if (ioam6h->type.bit3)
-		*p += sizeof(__u32);
-
-	if (ioam6h->type.bit4) {
-		if (__be32_to_cpu(*((__u32 *)*p)) != 0xffffffff)
-			return 1;
-		*p += sizeof(__u32);
-	}
-
-	if (ioam6h->type.bit5) {
-		if (__be32_to_cpu(*((__u32 *)*p)) != cnf.ns_data)
-			return 1;
-		*p += sizeof(__u32);
-	}
-
-	if (ioam6h->type.bit6)
-		*p += sizeof(__u32);
+	if (trace->type.bit12 | trace->type.bit13 | trace->type.bit14 |
+	    trace->type.bit15 | trace->type.bit16 | trace->type.bit17 |
+	    trace->type.bit18 | trace->type.bit19 | trace->type.bit20 |
+	    trace->type.bit21 | trace->type.bit23)
+		return 1;
 
-	if (ioam6h->type.bit7) {
-		if (__be32_to_cpu(*((__u32 *)*p)) != 0xffffffff)
+	for (i = 0; i < trace->remlen * 4; i++) {
+		if (trace->data[i] != 0)
 			return 1;
-		*p += sizeof(__u32);
 	}
 
-	if (ioam6h->type.bit8) {
-		raw64 = __be64_to_cpu(*((__u64 *)*p));
-		if (cnf.hlim != (raw64 >> 56) ||
-		    cnf.wide != (raw64 & 0xffffffffffffff))
-			return 1;
-		*p += sizeof(__u64);
-	}
+	if (trace->remlen * 4 == trace_size)
+		return 0;
 
-	if (ioam6h->type.bit9) {
-		if (__be32_to_cpu(*((__u32 *)*p)) != cnf.ingr_wide)
-			return 1;
-		*p += sizeof(__u32);
+	p = trace->data + trace->remlen * 4;
 
-		if (__be32_to_cpu(*((__u32 *)*p)) != cnf.egr_wide)
+	if (trace->type.bit0) {
+		raw32 = __be32_to_cpu(*((__u32 *)p));
+		if (cnf.hlim != (raw32 >> 24) || cnf.id != (raw32 & 0xffffff))
 			return 1;
-		*p += sizeof(__u32);
+		p += sizeof(__u32);
 	}
 
-	if (ioam6h->type.bit10) {
-		if (__be64_to_cpu(*((__u64 *)*p)) != cnf.ns_wide)
+	if (trace->type.bit1) {
+		raw32 = __be32_to_cpu(*((__u32 *)p));
+		if (cnf.ingr_id != (raw32 >> 16) ||
+		    cnf.egr_id != (raw32 & 0xffff))
 			return 1;
-		*p += sizeof(__u64);
+		p += sizeof(__u32);
 	}
 
-	if (ioam6h->type.bit11) {
-		if (__be32_to_cpu(*((__u32 *)*p)) != 0xffffffff)
+	if (trace->type.bit2) {
+		raw32 = __be32_to_cpu(*((__u32 *)p));
+		if ((is_output && raw32 != 0xffffffff) ||
+		    (!is_output && (raw32 == 0 || raw32 == 0xffffffff)))
 			return 1;
-		*p += sizeof(__u32);
+		p += sizeof(__u32);
 	}
 
-	if (ioam6h->type.bit12) {
-		if (__be32_to_cpu(*((__u32 *)*p)) != 0xffffffff)
+	if (trace->type.bit3) {
+		raw32 = __be32_to_cpu(*((__u32 *)p));
+		if ((is_output && raw32 != 0xffffffff) ||
+		    (!is_output && (raw32 == 0 || raw32 == 0xffffffff)))
 			return 1;
-		*p += sizeof(__u32);
+		p += sizeof(__u32);
 	}
 
-	if (ioam6h->type.bit13) {
-		if (__be32_to_cpu(*((__u32 *)*p)) != 0xffffffff)
+	if (trace->type.bit4) {
+		if (__be32_to_cpu(*((__u32 *)p)) != 0xffffffff)
 			return 1;
-		*p += sizeof(__u32);
+		p += sizeof(__u32);
 	}
 
-	if (ioam6h->type.bit14) {
-		if (__be32_to_cpu(*((__u32 *)*p)) != 0xffffffff)
+	if (trace->type.bit5) {
+		if (__be32_to_cpu(*((__u32 *)p)) != cnf.ns_data)
 			return 1;
-		*p += sizeof(__u32);
+		p += sizeof(__u32);
 	}
 
-	if (ioam6h->type.bit15) {
-		if (__be32_to_cpu(*((__u32 *)*p)) != 0xffffffff)
+	if (trace->type.bit6) {
+		if (__be32_to_cpu(*((__u32 *)p)) == 0xffffffff)
 			return 1;
-		*p += sizeof(__u32);
+		p += sizeof(__u32);
 	}
 
-	if (ioam6h->type.bit16) {
-		if (__be32_to_cpu(*((__u32 *)*p)) != 0xffffffff)
+	if (trace->type.bit7) {
+		if (__be32_to_cpu(*((__u32 *)p)) != 0xffffffff)
 			return 1;
-		*p += sizeof(__u32);
+		p += sizeof(__u32);
 	}
 
-	if (ioam6h->type.bit17) {
-		if (__be32_to_cpu(*((__u32 *)*p)) != 0xffffffff)
+	if (trace->type.bit8) {
+		raw64 = __be64_to_cpu(*((__u64 *)p));
+		if (cnf.hlim != (raw64 >> 56) ||
+		    cnf.wide != (raw64 & 0xffffffffffffff))
 			return 1;
-		*p += sizeof(__u32);
+		p += sizeof(__u64);
 	}
 
-	if (ioam6h->type.bit18) {
-		if (__be32_to_cpu(*((__u32 *)*p)) != 0xffffffff)
+	if (trace->type.bit9) {
+		if (__be32_to_cpu(*((__u32 *)p)) != cnf.ingr_wide)
 			return 1;
-		*p += sizeof(__u32);
-	}
+		p += sizeof(__u32);
 
-	if (ioam6h->type.bit19) {
-		if (__be32_to_cpu(*((__u32 *)*p)) != 0xffffffff)
+		if (__be32_to_cpu(*((__u32 *)p)) != cnf.egr_wide)
 			return 1;
-		*p += sizeof(__u32);
+		p += sizeof(__u32);
 	}
 
-	if (ioam6h->type.bit20) {
-		if (__be32_to_cpu(*((__u32 *)*p)) != 0xffffffff)
+	if (trace->type.bit10) {
+		if (__be64_to_cpu(*((__u64 *)p)) != cnf.ns_wide)
 			return 1;
-		*p += sizeof(__u32);
+		p += sizeof(__u64);
 	}
 
-	if (ioam6h->type.bit21) {
-		if (__be32_to_cpu(*((__u32 *)*p)) != 0xffffffff)
+	if (trace->type.bit11) {
+		if (__be32_to_cpu(*((__u32 *)p)) != 0xffffffff)
 			return 1;
-		*p += sizeof(__u32);
+		p += sizeof(__u32);
 	}
 
-	if (ioam6h->type.bit22) {
+	if (trace->type.bit22) {
 		len = cnf.sc_data ? strlen(cnf.sc_data) : 0;
 		aligned = cnf.sc_data ? __ALIGN_KERNEL(len, 4) : 0;
 
-		raw32 = __be32_to_cpu(*((__u32 *)*p));
+		raw32 = __be32_to_cpu(*((__u32 *)p));
 		if (aligned != (raw32 >> 24) * 4 ||
 		    cnf.sc_id != (raw32 & 0xffffff))
 			return 1;
-		*p += sizeof(__u32);
+		p += sizeof(__u32);
 
 		if (cnf.sc_data) {
-			if (strncmp((char *)*p, cnf.sc_data, len))
+			if (strncmp((char *)p, cnf.sc_data, len))
 				return 1;
 
-			*p += len;
+			p += len;
 			aligned -= len;
 
 			while (aligned--) {
-				if (**p != '\0')
+				if (*p != '\0')
 					return 1;
-				*p += sizeof(__u8);
+				p += sizeof(__u8);
 			}
 		}
 	}
@@ -366,151 +588,351 @@ static int check_ioam6_data(__u8 **p, struct ioam6_trace_hdr *ioam6h,
 	return 0;
 }
 
-static int check_ioam_header_and_data(int tid, struct ioam6_trace_hdr *ioam6h,
-				      __u32 trace_type, __u16 ioam_ns)
+static int check_ioam_trace(int tid, struct ioam6_trace_hdr *trace,
+			    __u32 trace_type, __u8 trace_size, __u16 ioam_ns)
 {
-	__u8 *p;
-
-	if (check_ioam_header(tid, ioam6h, trace_type, ioam_ns))
+	if (check_header(tid, trace, trace_type, trace_size, ioam_ns))
 		return 1;
 
-	p = ioam6h->data + ioam6h->remlen * 4;
-
-	switch (tid) {
-	case TEST_OUT_BIT0:
-	case TEST_OUT_BIT1:
-	case TEST_OUT_BIT2:
-	case TEST_OUT_BIT3:
-	case TEST_OUT_BIT4:
-	case TEST_OUT_BIT5:
-	case TEST_OUT_BIT6:
-	case TEST_OUT_BIT7:
-	case TEST_OUT_BIT8:
-	case TEST_OUT_BIT9:
-	case TEST_OUT_BIT10:
-	case TEST_OUT_BIT11:
-	case TEST_OUT_BIT22:
-	case TEST_OUT_FULL_SUPP_TRACE:
-		return check_ioam6_data(&p, ioam6h, node1);
-
-	case TEST_IN_BIT0:
-	case TEST_IN_BIT1:
-	case TEST_IN_BIT2:
-	case TEST_IN_BIT3:
-	case TEST_IN_BIT4:
-	case TEST_IN_BIT5:
-	case TEST_IN_BIT6:
-	case TEST_IN_BIT7:
-	case TEST_IN_BIT8:
-	case TEST_IN_BIT9:
-	case TEST_IN_BIT10:
-	case TEST_IN_BIT11:
-	case TEST_IN_BIT22:
-	case TEST_IN_FULL_SUPP_TRACE:
-	{
-		__u32 tmp32 = node2.egr_wide;
-		__u16 tmp16 = node2.egr_id;
-		int res;
-
-		node2.egr_id = 0xffff;
-		node2.egr_wide = 0xffffffff;
+	if (tid > __TEST_OUT_MIN && tid < __TEST_OUT_MAX)
+		return check_data(trace, trace_size, node1, true);
 
-		res = check_ioam6_data(&p, ioam6h, node2);
-
-		node2.egr_id = tmp16;
-		node2.egr_wide = tmp32;
-
-		return res;
-	}
-
-	case TEST_FWD_FULL_SUPP_TRACE:
-		if (check_ioam6_data(&p, ioam6h, node3))
-			return 1;
-		if (check_ioam6_data(&p, ioam6h, node2))
-			return 1;
-		return check_ioam6_data(&p, ioam6h, node1);
-
-	default:
-		break;
-	}
+	if (tid > __TEST_IN_MIN && tid < __TEST_IN_MAX)
+		return check_data(trace, trace_size, node2, false);
 
 	return 1;
 }
 
 static int str2id(const char *tname)
 {
-	if (!strcmp("out_undef_ns", tname))
+	if (!strcmp("output_undef_ns", tname))
 		return TEST_OUT_UNDEF_NS;
-	if (!strcmp("out_no_room", tname))
+	if (!strcmp("output_no_room", tname))
 		return TEST_OUT_NO_ROOM;
-	if (!strcmp("out_bit0", tname))
+	if (!strcmp("output_no_room_oss", tname))
+		return TEST_OUT_NO_ROOM_OSS;
+	if (!strcmp("output_bit0", tname))
 		return TEST_OUT_BIT0;
-	if (!strcmp("out_bit1", tname))
+	if (!strcmp("output_bit1", tname))
 		return TEST_OUT_BIT1;
-	if (!strcmp("out_bit2", tname))
+	if (!strcmp("output_bit2", tname))
 		return TEST_OUT_BIT2;
-	if (!strcmp("out_bit3", tname))
+	if (!strcmp("output_bit3", tname))
 		return TEST_OUT_BIT3;
-	if (!strcmp("out_bit4", tname))
+	if (!strcmp("output_bit4", tname))
 		return TEST_OUT_BIT4;
-	if (!strcmp("out_bit5", tname))
+	if (!strcmp("output_bit5", tname))
 		return TEST_OUT_BIT5;
-	if (!strcmp("out_bit6", tname))
+	if (!strcmp("output_bit6", tname))
 		return TEST_OUT_BIT6;
-	if (!strcmp("out_bit7", tname))
+	if (!strcmp("output_bit7", tname))
 		return TEST_OUT_BIT7;
-	if (!strcmp("out_bit8", tname))
+	if (!strcmp("output_bit8", tname))
 		return TEST_OUT_BIT8;
-	if (!strcmp("out_bit9", tname))
+	if (!strcmp("output_bit9", tname))
 		return TEST_OUT_BIT9;
-	if (!strcmp("out_bit10", tname))
+	if (!strcmp("output_bit10", tname))
 		return TEST_OUT_BIT10;
-	if (!strcmp("out_bit11", tname))
+	if (!strcmp("output_bit11", tname))
 		return TEST_OUT_BIT11;
-	if (!strcmp("out_bit22", tname))
+	if (!strcmp("output_bit22", tname))
 		return TEST_OUT_BIT22;
-	if (!strcmp("out_full_supp_trace", tname))
+	if (!strcmp("output_size4", tname))
+		return TEST_OUT_SIZE4;
+	if (!strcmp("output_size8", tname))
+		return TEST_OUT_SIZE8;
+	if (!strcmp("output_size12", tname))
+		return TEST_OUT_SIZE12;
+	if (!strcmp("output_size16", tname))
+		return TEST_OUT_SIZE16;
+	if (!strcmp("output_size20", tname))
+		return TEST_OUT_SIZE20;
+	if (!strcmp("output_size24", tname))
+		return TEST_OUT_SIZE24;
+	if (!strcmp("output_size28", tname))
+		return TEST_OUT_SIZE28;
+	if (!strcmp("output_size32", tname))
+		return TEST_OUT_SIZE32;
+	if (!strcmp("output_size36", tname))
+		return TEST_OUT_SIZE36;
+	if (!strcmp("output_size40", tname))
+		return TEST_OUT_SIZE40;
+	if (!strcmp("output_size44", tname))
+		return TEST_OUT_SIZE44;
+	if (!strcmp("output_size48", tname))
+		return TEST_OUT_SIZE48;
+	if (!strcmp("output_size52", tname))
+		return TEST_OUT_SIZE52;
+	if (!strcmp("output_size56", tname))
+		return TEST_OUT_SIZE56;
+	if (!strcmp("output_size60", tname))
+		return TEST_OUT_SIZE60;
+	if (!strcmp("output_size64", tname))
+		return TEST_OUT_SIZE64;
+	if (!strcmp("output_size68", tname))
+		return TEST_OUT_SIZE68;
+	if (!strcmp("output_size72", tname))
+		return TEST_OUT_SIZE72;
+	if (!strcmp("output_size76", tname))
+		return TEST_OUT_SIZE76;
+	if (!strcmp("output_size80", tname))
+		return TEST_OUT_SIZE80;
+	if (!strcmp("output_size84", tname))
+		return TEST_OUT_SIZE84;
+	if (!strcmp("output_size88", tname))
+		return TEST_OUT_SIZE88;
+	if (!strcmp("output_size92", tname))
+		return TEST_OUT_SIZE92;
+	if (!strcmp("output_size96", tname))
+		return TEST_OUT_SIZE96;
+	if (!strcmp("output_size100", tname))
+		return TEST_OUT_SIZE100;
+	if (!strcmp("output_size104", tname))
+		return TEST_OUT_SIZE104;
+	if (!strcmp("output_size108", tname))
+		return TEST_OUT_SIZE108;
+	if (!strcmp("output_size112", tname))
+		return TEST_OUT_SIZE112;
+	if (!strcmp("output_size116", tname))
+		return TEST_OUT_SIZE116;
+	if (!strcmp("output_size120", tname))
+		return TEST_OUT_SIZE120;
+	if (!strcmp("output_size124", tname))
+		return TEST_OUT_SIZE124;
+	if (!strcmp("output_size128", tname))
+		return TEST_OUT_SIZE128;
+	if (!strcmp("output_size132", tname))
+		return TEST_OUT_SIZE132;
+	if (!strcmp("output_size136", tname))
+		return TEST_OUT_SIZE136;
+	if (!strcmp("output_size140", tname))
+		return TEST_OUT_SIZE140;
+	if (!strcmp("output_size144", tname))
+		return TEST_OUT_SIZE144;
+	if (!strcmp("output_size148", tname))
+		return TEST_OUT_SIZE148;
+	if (!strcmp("output_size152", tname))
+		return TEST_OUT_SIZE152;
+	if (!strcmp("output_size156", tname))
+		return TEST_OUT_SIZE156;
+	if (!strcmp("output_size160", tname))
+		return TEST_OUT_SIZE160;
+	if (!strcmp("output_size164", tname))
+		return TEST_OUT_SIZE164;
+	if (!strcmp("output_size168", tname))
+		return TEST_OUT_SIZE168;
+	if (!strcmp("output_size172", tname))
+		return TEST_OUT_SIZE172;
+	if (!strcmp("output_size176", tname))
+		return TEST_OUT_SIZE176;
+	if (!strcmp("output_size180", tname))
+		return TEST_OUT_SIZE180;
+	if (!strcmp("output_size184", tname))
+		return TEST_OUT_SIZE184;
+	if (!strcmp("output_size188", tname))
+		return TEST_OUT_SIZE188;
+	if (!strcmp("output_size192", tname))
+		return TEST_OUT_SIZE192;
+	if (!strcmp("output_size196", tname))
+		return TEST_OUT_SIZE196;
+	if (!strcmp("output_size200", tname))
+		return TEST_OUT_SIZE200;
+	if (!strcmp("output_size204", tname))
+		return TEST_OUT_SIZE204;
+	if (!strcmp("output_size208", tname))
+		return TEST_OUT_SIZE208;
+	if (!strcmp("output_size212", tname))
+		return TEST_OUT_SIZE212;
+	if (!strcmp("output_size216", tname))
+		return TEST_OUT_SIZE216;
+	if (!strcmp("output_size220", tname))
+		return TEST_OUT_SIZE220;
+	if (!strcmp("output_size224", tname))
+		return TEST_OUT_SIZE224;
+	if (!strcmp("output_size228", tname))
+		return TEST_OUT_SIZE228;
+	if (!strcmp("output_size232", tname))
+		return TEST_OUT_SIZE232;
+	if (!strcmp("output_size236", tname))
+		return TEST_OUT_SIZE236;
+	if (!strcmp("output_size240", tname))
+		return TEST_OUT_SIZE240;
+	if (!strcmp("output_size244", tname))
+		return TEST_OUT_SIZE244;
+	if (!strcmp("output_full_supp_trace", tname))
 		return TEST_OUT_FULL_SUPP_TRACE;
-	if (!strcmp("in_undef_ns", tname))
+	if (!strcmp("input_undef_ns", tname))
 		return TEST_IN_UNDEF_NS;
-	if (!strcmp("in_no_room", tname))
+	if (!strcmp("input_no_room", tname))
 		return TEST_IN_NO_ROOM;
-	if (!strcmp("in_oflag", tname))
+	if (!strcmp("input_no_room_oss", tname))
+		return TEST_IN_NO_ROOM_OSS;
+	if (!strcmp("input_disabled", tname))
+		return TEST_IN_DISABLED;
+	if (!strcmp("input_oflag", tname))
 		return TEST_IN_OFLAG;
-	if (!strcmp("in_bit0", tname))
+	if (!strcmp("input_bit0", tname))
 		return TEST_IN_BIT0;
-	if (!strcmp("in_bit1", tname))
+	if (!strcmp("input_bit1", tname))
 		return TEST_IN_BIT1;
-	if (!strcmp("in_bit2", tname))
+	if (!strcmp("input_bit2", tname))
 		return TEST_IN_BIT2;
-	if (!strcmp("in_bit3", tname))
+	if (!strcmp("input_bit3", tname))
 		return TEST_IN_BIT3;
-	if (!strcmp("in_bit4", tname))
+	if (!strcmp("input_bit4", tname))
 		return TEST_IN_BIT4;
-	if (!strcmp("in_bit5", tname))
+	if (!strcmp("input_bit5", tname))
 		return TEST_IN_BIT5;
-	if (!strcmp("in_bit6", tname))
+	if (!strcmp("input_bit6", tname))
 		return TEST_IN_BIT6;
-	if (!strcmp("in_bit7", tname))
+	if (!strcmp("input_bit7", tname))
 		return TEST_IN_BIT7;
-	if (!strcmp("in_bit8", tname))
+	if (!strcmp("input_bit8", tname))
 		return TEST_IN_BIT8;
-	if (!strcmp("in_bit9", tname))
+	if (!strcmp("input_bit9", tname))
 		return TEST_IN_BIT9;
-	if (!strcmp("in_bit10", tname))
+	if (!strcmp("input_bit10", tname))
 		return TEST_IN_BIT10;
-	if (!strcmp("in_bit11", tname))
+	if (!strcmp("input_bit11", tname))
 		return TEST_IN_BIT11;
-	if (!strcmp("in_bit22", tname))
+	if (!strcmp("input_bit22", tname))
 		return TEST_IN_BIT22;
-	if (!strcmp("in_full_supp_trace", tname))
+	if (!strcmp("input_size4", tname))
+		return TEST_IN_SIZE4;
+	if (!strcmp("input_size8", tname))
+		return TEST_IN_SIZE8;
+	if (!strcmp("input_size12", tname))
+		return TEST_IN_SIZE12;
+	if (!strcmp("input_size16", tname))
+		return TEST_IN_SIZE16;
+	if (!strcmp("input_size20", tname))
+		return TEST_IN_SIZE20;
+	if (!strcmp("input_size24", tname))
+		return TEST_IN_SIZE24;
+	if (!strcmp("input_size28", tname))
+		return TEST_IN_SIZE28;
+	if (!strcmp("input_size32", tname))
+		return TEST_IN_SIZE32;
+	if (!strcmp("input_size36", tname))
+		return TEST_IN_SIZE36;
+	if (!strcmp("input_size40", tname))
+		return TEST_IN_SIZE40;
+	if (!strcmp("input_size44", tname))
+		return TEST_IN_SIZE44;
+	if (!strcmp("input_size48", tname))
+		return TEST_IN_SIZE48;
+	if (!strcmp("input_size52", tname))
+		return TEST_IN_SIZE52;
+	if (!strcmp("input_size56", tname))
+		return TEST_IN_SIZE56;
+	if (!strcmp("input_size60", tname))
+		return TEST_IN_SIZE60;
+	if (!strcmp("input_size64", tname))
+		return TEST_IN_SIZE64;
+	if (!strcmp("input_size68", tname))
+		return TEST_IN_SIZE68;
+	if (!strcmp("input_size72", tname))
+		return TEST_IN_SIZE72;
+	if (!strcmp("input_size76", tname))
+		return TEST_IN_SIZE76;
+	if (!strcmp("input_size80", tname))
+		return TEST_IN_SIZE80;
+	if (!strcmp("input_size84", tname))
+		return TEST_IN_SIZE84;
+	if (!strcmp("input_size88", tname))
+		return TEST_IN_SIZE88;
+	if (!strcmp("input_size92", tname))
+		return TEST_IN_SIZE92;
+	if (!strcmp("input_size96", tname))
+		return TEST_IN_SIZE96;
+	if (!strcmp("input_size100", tname))
+		return TEST_IN_SIZE100;
+	if (!strcmp("input_size104", tname))
+		return TEST_IN_SIZE104;
+	if (!strcmp("input_size108", tname))
+		return TEST_IN_SIZE108;
+	if (!strcmp("input_size112", tname))
+		return TEST_IN_SIZE112;
+	if (!strcmp("input_size116", tname))
+		return TEST_IN_SIZE116;
+	if (!strcmp("input_size120", tname))
+		return TEST_IN_SIZE120;
+	if (!strcmp("input_size124", tname))
+		return TEST_IN_SIZE124;
+	if (!strcmp("input_size128", tname))
+		return TEST_IN_SIZE128;
+	if (!strcmp("input_size132", tname))
+		return TEST_IN_SIZE132;
+	if (!strcmp("input_size136", tname))
+		return TEST_IN_SIZE136;
+	if (!strcmp("input_size140", tname))
+		return TEST_IN_SIZE140;
+	if (!strcmp("input_size144", tname))
+		return TEST_IN_SIZE144;
+	if (!strcmp("input_size148", tname))
+		return TEST_IN_SIZE148;
+	if (!strcmp("input_size152", tname))
+		return TEST_IN_SIZE152;
+	if (!strcmp("input_size156", tname))
+		return TEST_IN_SIZE156;
+	if (!strcmp("input_size160", tname))
+		return TEST_IN_SIZE160;
+	if (!strcmp("input_size164", tname))
+		return TEST_IN_SIZE164;
+	if (!strcmp("input_size168", tname))
+		return TEST_IN_SIZE168;
+	if (!strcmp("input_size172", tname))
+		return TEST_IN_SIZE172;
+	if (!strcmp("input_size176", tname))
+		return TEST_IN_SIZE176;
+	if (!strcmp("input_size180", tname))
+		return TEST_IN_SIZE180;
+	if (!strcmp("input_size184", tname))
+		return TEST_IN_SIZE184;
+	if (!strcmp("input_size188", tname))
+		return TEST_IN_SIZE188;
+	if (!strcmp("input_size192", tname))
+		return TEST_IN_SIZE192;
+	if (!strcmp("input_size196", tname))
+		return TEST_IN_SIZE196;
+	if (!strcmp("input_size200", tname))
+		return TEST_IN_SIZE200;
+	if (!strcmp("input_size204", tname))
+		return TEST_IN_SIZE204;
+	if (!strcmp("input_size208", tname))
+		return TEST_IN_SIZE208;
+	if (!strcmp("input_size212", tname))
+		return TEST_IN_SIZE212;
+	if (!strcmp("input_size216", tname))
+		return TEST_IN_SIZE216;
+	if (!strcmp("input_size220", tname))
+		return TEST_IN_SIZE220;
+	if (!strcmp("input_size224", tname))
+		return TEST_IN_SIZE224;
+	if (!strcmp("input_size228", tname))
+		return TEST_IN_SIZE228;
+	if (!strcmp("input_size232", tname))
+		return TEST_IN_SIZE232;
+	if (!strcmp("input_size236", tname))
+		return TEST_IN_SIZE236;
+	if (!strcmp("input_size240", tname))
+		return TEST_IN_SIZE240;
+	if (!strcmp("input_size244", tname))
+		return TEST_IN_SIZE244;
+	if (!strcmp("input_full_supp_trace", tname))
 		return TEST_IN_FULL_SUPP_TRACE;
-	if (!strcmp("fwd_full_supp_trace", tname))
-		return TEST_FWD_FULL_SUPP_TRACE;
 
 	return -1;
 }
 
+static int ipv6_addr_equal(const struct in6_addr *a1, const struct in6_addr *a2)
+{
+	return ((a1->s6_addr32[0] ^ a2->s6_addr32[0]) |
+		(a1->s6_addr32[1] ^ a2->s6_addr32[1]) |
+		(a1->s6_addr32[2] ^ a2->s6_addr32[2]) |
+		(a1->s6_addr32[3] ^ a2->s6_addr32[3])) == 0;
+}
+
 static int get_u32(__u32 *val, const char *arg, int base)
 {
 	unsigned long res;
@@ -555,119 +977,124 @@ static int get_u16(__u16 *val, const char *arg, int base)
 	return 0;
 }
 
-static int (*func[__TEST_MAX])(int, struct ioam6_trace_hdr *, __u32, __u16) = {
-	[TEST_OUT_UNDEF_NS]		= check_ioam_header,
-	[TEST_OUT_NO_ROOM]		= check_ioam_header,
-	[TEST_OUT_BIT0]		= check_ioam_header_and_data,
-	[TEST_OUT_BIT1]		= check_ioam_header_and_data,
-	[TEST_OUT_BIT2]		= check_ioam_header_and_data,
-	[TEST_OUT_BIT3]		= check_ioam_header_and_data,
-	[TEST_OUT_BIT4]		= check_ioam_header_and_data,
-	[TEST_OUT_BIT5]		= check_ioam_header_and_data,
-	[TEST_OUT_BIT6]		= check_ioam_header_and_data,
-	[TEST_OUT_BIT7]		= check_ioam_header_and_data,
-	[TEST_OUT_BIT8]		= check_ioam_header_and_data,
-	[TEST_OUT_BIT9]		= check_ioam_header_and_data,
-	[TEST_OUT_BIT10]		= check_ioam_header_and_data,
-	[TEST_OUT_BIT11]		= check_ioam_header_and_data,
-	[TEST_OUT_BIT22]		= check_ioam_header_and_data,
-	[TEST_OUT_FULL_SUPP_TRACE]	= check_ioam_header_and_data,
-	[TEST_IN_UNDEF_NS]		= check_ioam_header,
-	[TEST_IN_NO_ROOM]		= check_ioam_header,
-	[TEST_IN_OFLAG]		= check_ioam_header,
-	[TEST_IN_BIT0]			= check_ioam_header_and_data,
-	[TEST_IN_BIT1]			= check_ioam_header_and_data,
-	[TEST_IN_BIT2]			= check_ioam_header_and_data,
-	[TEST_IN_BIT3]			= check_ioam_header_and_data,
-	[TEST_IN_BIT4]			= check_ioam_header_and_data,
-	[TEST_IN_BIT5]			= check_ioam_header_and_data,
-	[TEST_IN_BIT6]			= check_ioam_header_and_data,
-	[TEST_IN_BIT7]			= check_ioam_header_and_data,
-	[TEST_IN_BIT8]			= check_ioam_header_and_data,
-	[TEST_IN_BIT9]			= check_ioam_header_and_data,
-	[TEST_IN_BIT10]		= check_ioam_header_and_data,
-	[TEST_IN_BIT11]		= check_ioam_header_and_data,
-	[TEST_IN_BIT22]		= check_ioam_header_and_data,
-	[TEST_IN_FULL_SUPP_TRACE]	= check_ioam_header_and_data,
-	[TEST_FWD_FULL_SUPP_TRACE]	= check_ioam_header_and_data,
-};
+static int get_u8(__u8 *val, const char *arg, int base)
+{
+	unsigned long res;
+	char *ptr;
+
+	if (!arg || !*arg)
+		return -1;
+	res = strtoul(arg, &ptr, base);
+
+	if (!ptr || ptr == arg || *ptr)
+		return -1;
+
+	if (res == ULONG_MAX && errno == ERANGE)
+		return -1;
+
+	if (res > 0xFFUL)
+		return -1;
+
+	*val = res;
+	return 0;
+}
 
 int main(int argc, char **argv)
 {
-	int fd, size, hoplen, tid, ret = 1, on = 1;
-	struct ioam6_hdr *opt;
-	struct cmsghdr *cmsg;
-	struct msghdr msg;
-	struct iovec iov;
-	__u8 buffer[512];
+	__u8 buffer[512], *ptr, nexthdr, tr_size;
+	struct ioam6_trace_hdr *trace;
+	unsigned int hoplen, ret = 1;
+	struct ipv6_hopopt_hdr *hbh;
+	int fd, size, testname_id;
+	struct in6_addr src, dst;
+	struct ioam6_hdr *ioam6;
+	struct timeval timeout;
+	struct ipv6hdr *ipv6;
 	__u32 tr_type;
 	__u16 ioam_ns;
-	__u8 *ptr;
 
-	if (argc != 5)
+	if (argc != 9)
 		goto out;
 
-	tid = str2id(argv[1]);
-	if (tid < 0 || !func[tid])
-		goto out;
+	testname_id = str2id(argv[2]);
 
-	if (get_u32(&tr_type, argv[2], 16) ||
-	    get_u16(&ioam_ns, argv[3], 0))
+	if (testname_id < 0 ||
+	    inet_pton(AF_INET6, argv[3], &src) != 1 ||
+	    inet_pton(AF_INET6, argv[4], &dst) != 1 ||
+	    get_u32(&tr_type, argv[5], 16) ||
+	    get_u8(&tr_size, argv[6], 0) ||
+	    get_u16(&ioam_ns, argv[7], 0))
 		goto out;
 
-	fd = socket(PF_INET6, SOCK_RAW,
-		    !strcmp(argv[4], "encap") ? IPPROTO_IPV6 : IPPROTO_ICMPV6);
+	nexthdr = (!strcmp(argv[8], "encap") ? IPPROTO_IPV6 : IPPROTO_ICMPV6);
+
+	hoplen = sizeof(*hbh);
+	hoplen += 2; // 2-byte padding for alignment
+	hoplen += sizeof(*ioam6); // IOAM option header
+	hoplen += sizeof(*trace); // IOAM trace header
+	hoplen += tr_size; // IOAM trace size
+	hoplen += (tr_size % 8); // optional padding
+
+	fd = socket(AF_PACKET, SOCK_DGRAM, __cpu_to_be16(ETH_P_IPV6));
 	if (fd < 0)
 		goto out;
 
-	setsockopt(fd, IPPROTO_IPV6, IPV6_RECVHOPOPTS,  &on, sizeof(on));
+	if (setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE,
+		       argv[1], strlen(argv[1])))
+		goto close;
 
-	iov.iov_len = 1;
-	iov.iov_base = malloc(CMSG_SPACE(sizeof(buffer)));
-	if (!iov.iov_base)
+	timeout.tv_sec = 1;
+	timeout.tv_usec = 0;
+	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO,
+		       (const char *)&timeout, sizeof(timeout)))
 		goto close;
 recv:
-	memset(&msg, 0, sizeof(msg));
-	msg.msg_iov = &iov;
-	msg.msg_iovlen = 1;
-	msg.msg_control = buffer;
-	msg.msg_controllen = CMSG_SPACE(sizeof(buffer));
-
-	size = recvmsg(fd, &msg, 0);
+	size = recv(fd, buffer, sizeof(buffer), 0);
 	if (size <= 0)
 		goto close;
 
-	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
-		if (cmsg->cmsg_level != IPPROTO_IPV6 ||
-		    cmsg->cmsg_type != IPV6_HOPOPTS ||
-		    cmsg->cmsg_len < sizeof(struct ipv6_hopopt_hdr))
-			continue;
+	ipv6 = (struct ipv6hdr *)buffer;
+
+	/* Skip packets that do not have the expected src/dst address or that
+	 * do not have a Hop-by-hop.
+	 */
+	if (!ipv6_addr_equal(&ipv6->saddr, &src) ||
+	    !ipv6_addr_equal(&ipv6->daddr, &dst) ||
+	    ipv6->nexthdr != IPPROTO_HOPOPTS)
+		goto recv;
+
+	/* Check Hbh's Next Header and Size. */
+	hbh = (struct ipv6_hopopt_hdr *)(buffer + sizeof(*ipv6));
+	if (hbh->nexthdr != nexthdr || hbh->hdrlen != (hoplen >> 3) - 1)
+		goto close;
 
-		ptr = (__u8 *)CMSG_DATA(cmsg);
+	/* Check we have a 2-byte padding for alignment. */
+	ptr = (__u8 *)hbh + sizeof(*hbh);
+	if (ptr[0] != IPV6_TLV_PADN && ptr[1] != 0)
+		goto close;
 
-		hoplen = (ptr[1] + 1) << 3;
-		ptr += sizeof(struct ipv6_hopopt_hdr);
+	/* Check we now have the IOAM option. */
+	ptr += 2;
+	if (ptr[0] != IPV6_TLV_IOAM)
+		goto close;
 
-		while (hoplen > 0) {
-			opt = (struct ioam6_hdr *)ptr;
+	/* Check its size and the IOAM option type. */
+	ioam6 = (struct ioam6_hdr *)ptr;
+	if (ioam6->opt_len != sizeof(*ioam6) - 2 + sizeof(*trace) + tr_size ||
+	    ioam6->type != IOAM6_TYPE_PREALLOC)
+		goto close;
 
-			if (opt->opt_type == IPV6_TLV_IOAM &&
-			    opt->type == IOAM6_TYPE_PREALLOC) {
-				ptr += sizeof(*opt);
-				ret = func[tid](tid,
-						(struct ioam6_trace_hdr *)ptr,
-						tr_type, ioam_ns);
-				goto close;
-			}
+	trace = (struct ioam6_trace_hdr *)(ptr + sizeof(*ioam6));
 
-			ptr += opt->opt_len + 2;
-			hoplen -= opt->opt_len + 2;
-		}
-	}
+	/* Check the trailing 4-byte padding (potentially). */
+	ptr = (__u8 *)trace + sizeof(*trace) + tr_size;
+	if (tr_size % 8 && ptr[0] != IPV6_TLV_PADN && ptr[1] != 2 &&
+	    ptr[2] != 0 && ptr[3] != 0)
+		goto close;
 
-	goto recv;
+	/* Check the IOAM header and data. */
+	ret = check_ioam_trace(testname_id, trace, tr_type, tr_size, ioam_ns);
 close:
-	free(iov.iov_base);
 	close(fd);
 out:
 	return ret;
-- 
2.34.1


