Return-Path: <linux-kselftest+bounces-9910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1098C1A14
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 01:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB4EDB2155A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 23:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AFB1304BF;
	Thu,  9 May 2024 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8plW8bn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56008613B;
	Thu,  9 May 2024 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715298955; cv=none; b=M69Q9ofQpSmqZsJr0VevRGNUgs21lqTFI+yIU4Jx+kJ+Fy6qFcvKFneFUEUqBp3rTYajWYH/7fl1qluiVsQuKkGWEAjdIEyyDnxpGM5cDpF+ZtY8GCCaH/Eu/FcwiW+2ab3iXDACFu3d2viGXNbX1qhGtSZ9gdfMl9t6SCt4VGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715298955; c=relaxed/simple;
	bh=BOfSQW2MU0SEzcFjkm90BwxgZ46ysiI9NipUExvnmT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uuy15UvkwVpRDIrG72tcy2xgU9SQFCLJ6QMFbaGFh29JKfe1Eg739lA20sa3MNPaQPNWIP5bAQh/RTapIvrmuRnzBtu43nkpDH/KBK5zhO+BHzqaq3IWX69Rv5ZW3z/kojQ6ZEnFQXATrH0imEdCZCOtCIItH0zIT0l9ak/E8So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8plW8bn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98ADC116B1;
	Thu,  9 May 2024 23:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715298955;
	bh=BOfSQW2MU0SEzcFjkm90BwxgZ46ysiI9NipUExvnmT8=;
	h=From:To:Cc:Subject:Date:From;
	b=B8plW8bnf7bnjrJVAokOpBVjPRn1RiOrZs+8f7d6/sqoMFbC8XaKA9HN0+///0NWn
	 FbtCeoJO4QS8aY28bWP6nrc33wSiLx/XolkAKXGR8LMI96S83dDXief/n2R5IYl8oO
	 YRRbiE3EmBUYD/4q2iktWqXvIQdt/TAGJemd+9N7Bo9tVI26C2FFuWkwnGQoAQdm7n
	 mx1vVFLu+221KK786UFwCNfh7wrjhjPdNh56vHSu51eY7W62HQCn4KJyFNIS7QJ78i
	 s4Cn3P6+CUhSgUSkBoohKOYBDH3pOOSlpMK9l29NoIDtnq0PUAxeBwJLNoP2eA8b4S
	 1jlcyNT3z+HYA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	vladimir.oltean@nxp.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	liuhangbin@gmail.com,
	bpoirier@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net: local_termination: annotate the expected failures
Date: Thu,  9 May 2024 16:55:53 -0700
Message-ID: <20240509235553.5740-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vladimir said when adding this test:

  The bridge driver fares particularly badly [...] mainly because
  it does not implement IFF_UNICAST_FLT.

See commit 90b9566aa5cd ("selftests: forwarding: add a test for
local_termination.sh").

We don't want to hide the known gaps, but having a test which
always fails prevents us from catching regressions. Report
the cases we know may fail as XFAIL.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: vladimir.oltean@nxp.com
CC: shuah@kernel.org
CC: petrm@nvidia.com
CC: liuhangbin@gmail.com
CC: bpoirier@nvidia.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/forwarding/lib.sh |  9 ++++++++
 .../net/forwarding/local_termination.sh       | 21 ++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 3353a1745946..4fe28ab5d8b9 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -605,6 +605,15 @@ log_test_xfail()
 	RET=$ksft_xfail retmsg= log_test "$@"
 }
 
+log_test_xfail()
+{
+	local test_name=$1
+	local opt_str=$2
+
+	printf "TEST: %-60s  [XFAIL]\n" "$test_name $opt_str"
+	return 0
+}
+
 log_info()
 {
 	local msg=$1
diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index c5b0cbc85b3e..4bba9c78db3e 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -73,6 +73,10 @@ check_rcv()
 	local pattern=$3
 	local should_receive=$4
 	local should_fail=
+	local xfail_sw=$5
+
+	local kind=$(ip -j -d link show dev $if_name |
+			 jq -r '.[].linkinfo.info_kind')
 
 	[ $should_receive = true ] && should_fail=0 || should_fail=1
 	RET=0
@@ -81,7 +85,14 @@ check_rcv()
 
 	check_err_fail "$should_fail" "$?" "reception"
 
-	log_test "$if_name: $type"
+	# If not a SW interface, ignore the XFAIL allowance
+	[ "$kind" != veth ] && [ "$kind" != bridge ] && xfail_sw=
+
+	if [ $RET -ne 0 ] && [ "$xfail_sw" == true ]; then
+	    log_test_xfail "$if_name: $type"
+	else
+	    log_test "$if_name: $type"
+	fi
 }
 
 mc_route_prepare()
@@ -157,7 +168,7 @@ run_test()
 
 	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
 		"$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
-		false
+		false true
 
 	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address, promisc" \
 		"$smac > $UNKNOWN_UC_ADDR2, ethertype IPv4 (0x0800)" \
@@ -165,7 +176,7 @@ run_test()
 
 	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address, allmulti" \
 		"$smac > $UNKNOWN_UC_ADDR3, ethertype IPv4 (0x0800)" \
-		false
+		false true
 
 	check_rcv $rcv_if_name "Multicast IPv4 to joined group" \
 		"$smac > $JOINED_MACV4_MC_ADDR, ethertype IPv4 (0x0800)" \
@@ -173,7 +184,7 @@ run_test()
 
 	check_rcv $rcv_if_name "Multicast IPv4 to unknown group" \
 		"$smac > $UNKNOWN_MACV4_MC_ADDR1, ethertype IPv4 (0x0800)" \
-		false
+		false true
 
 	check_rcv $rcv_if_name "Multicast IPv4 to unknown group, promisc" \
 		"$smac > $UNKNOWN_MACV4_MC_ADDR2, ethertype IPv4 (0x0800)" \
@@ -189,7 +200,7 @@ run_test()
 
 	check_rcv $rcv_if_name "Multicast IPv6 to unknown group" \
 		"$smac > $UNKNOWN_MACV6_MC_ADDR1, ethertype IPv6 (0x86dd)" \
-		false
+		false true
 
 	check_rcv $rcv_if_name "Multicast IPv6 to unknown group, promisc" \
 		"$smac > $UNKNOWN_MACV6_MC_ADDR2, ethertype IPv6 (0x86dd)" \
-- 
2.45.0


