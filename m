Return-Path: <linux-kselftest+bounces-10087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8BB8C2E74
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 03:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A0FFB21EB9
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 01:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04929EEA9;
	Sat, 11 May 2024 01:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaDxAK+o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E16AB8;
	Sat, 11 May 2024 01:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715391161; cv=none; b=Qa7BjnZ6PSso6tF3AYQiqREIICFY15RYFDKFaHFfaGjaEHd40aHdV9fWN0JtN2Hqaq9YOpKZSZzzF6hWDuLcfrrY5VIwm4PDe3guC81SWwOsS6GftFroz1rZ9fvfNGTc65pcSKxLKr4goIO2iN2CBUcPgutXvaY2mvXvCHmRNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715391161; c=relaxed/simple;
	bh=HXNAUk8KaLORbUdTkeXxMvO5IapPVvsxzWrRDTV3Ho4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6KG3gMppZeN/C5m2Bx3gzcvDV1kAjelY0RVU/Sh94TYz8yhHOgyuEw0jDg9hUOCxD8A4/dtkHW09nxHCwevawNRYi8kxnyxrKa/wOS9VNn5ZrOTP4kHYyT+pEwN+uVO0zs/lAJ+y8/TwhW5/MNDMbkNF7RsGYKyOzq4qrHBcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaDxAK+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221F8C113CC;
	Sat, 11 May 2024 01:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715391160;
	bh=HXNAUk8KaLORbUdTkeXxMvO5IapPVvsxzWrRDTV3Ho4=;
	h=From:To:Cc:Subject:Date:From;
	b=UaDxAK+oUgyImZRIcmaGVxcogZQkDUnbJyFnJgEaJLWTcmYAjzcdxf9w9n6rUc1+t
	 4EBsTVdbMC/6aj66ixuFAaW3q0CulXKtoneqm+Vg7+Jtp7f8D5iwl7rWSgJwwNTkc2
	 a5uue12+PD6kodmd8KWDloY12rwyvriWfh1DCQKCy/r+7/z7JgWHaZlW/b4uQ+O0D9
	 wws0+MPJ3K5foeVUpHhb6xtGk7JYDyFuYO7S5/j3kKdHaNTXe9POfNzb9AY9Cklkbo
	 9XHxvRhuNkEMcf3I7g40JGPzMcbSHzb7EFu42gVdMgx4tEVNJ+sZ/YovCUobr17vCs
	 oFD8GTr2/kYcQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2] selftests: net: local_termination: annotate the expected failures
Date: Fri, 10 May 2024 18:32:36 -0700
Message-ID: <20240511013236.383368-1-kuba@kernel.org>
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

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: liuhangbin@gmail.com
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org

v2:
 - remove duplicated log_test_xfail
v1: https://lore.kernel.org/all/20240509235553.5740-1-kuba@kernel.org/
---
 .../net/forwarding/local_termination.sh       | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

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


