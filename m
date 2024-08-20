Return-Path: <linux-kselftest+bounces-15735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A791F957A88
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 02:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5941C23202
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 00:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499A579F3;
	Tue, 20 Aug 2024 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPale/26"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9804C66;
	Tue, 20 Aug 2024 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724114541; cv=none; b=rC0eZOiSgFNZk86FNxmXvYQTHlWlFskGG8Yt3hec16hLRtXURPVW0Pmo6iF29ATCD1uloaKyBzYSfkAkVlC4KRopjh5l+XyEzhTo06jMsxtd/o2FeceKtM9M1Y4Df3rIp4FEDJ/KsQL8AbjpNLzEHkFmO7V8FXgf/HgJCeJfZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724114541; c=relaxed/simple;
	bh=uI60EPTqcDOH8DZKni2Q9Q2X21j+zwocMTpdUUh697E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cG4gPRRmuL7dv9+nkHdriyZFHP49doP+FsIZl9Dk1HBKupQWxz1VCwFVlhHr70Zdi56Dcm4evwjPg9vZyeOguAXP73PBBTjAnBgzpec+8NNIvnerCBkQExKJ++WqgfQSS7DkN9fLkV0u6/7d3CJs6hEZJMN3p9DHKIflcqrb9q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPale/26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEC9C32782;
	Tue, 20 Aug 2024 00:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724114540;
	bh=uI60EPTqcDOH8DZKni2Q9Q2X21j+zwocMTpdUUh697E=;
	h=From:To:Cc:Subject:Date:From;
	b=lPale/266zZ5Z5hLN/ElpnlS5kd2hViCO9yePE+XTdx3J6AHuEsF6AFzOFjPjETA5
	 nPlsJj7Wf10YVUPxAdkMB72osnN+vZWI+JUWH5ZWDPaGGZRZt/zc7Tqqn8TC0yGvy8
	 x7HMySjzHEED/6goJynzMTi42nAuY2RxnqJo5HdcZKYopljiip5/HH2yiJ/9jZsELC
	 JijJFvI3FcV1nVretzcwkccG4fz56TIiSWxjBt99Ed2ShyWCu5ExHQClBr4Id/Imw7
	 geEqKlBJWJ8uikRISNg4yzKGVS7qKDcS17SPrAtz0I+JBh9ZRmRMNeOejOkGG9qvRw
	 C3vN4TSFWbjOQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Ido Schimmel <idosch@idosch.org>
Subject: [PATCH net-next v2] selftests: net: add helper for checking if nettest is available
Date: Mon, 19 Aug 2024 17:42:17 -0700
Message-ID: <20240820004217.1087392-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few tests check if nettest exists in the $PATH before adding
$PWD to $PATH and re-checking. They don't discard stderr on
the first check (and nettest is built as part of selftests,
so it's pretty normal for it to not be available in system $PATH).
This leads to output noise:

  which: no nettest in (/home/virtme/tools/fs/bin:/home/virtme/tools/fs/sbin:/home/virtme/tools/fs/usr/bin:/home/virtme/tools/fs/usr/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin)

Add a common helper for the check which does silence stderr.

There is another small functional change hiding here, because pmtu.sh
and fib_rule_tests.sh used to return from the test case rather than
completely exit. Building nettest is not hard, there should be no need
to maintain the ability to selectively skip cases in its absence.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fold in the changes from Ido
v1: https://lore.kernel.org/20240817183848.658443-1-kuba@kernel.org

CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
CC: Ido Schimmel <idosch@idosch.org>
---
 tools/testing/selftests/net/fcnal-test.sh     |  9 +----
 tools/testing/selftests/net/fib_rule_tests.sh | 37 +------------------
 tools/testing/selftests/net/lib.sh            | 15 ++++++++
 tools/testing/selftests/net/pmtu.sh           |  8 +---
 tools/testing/selftests/net/settings          |  1 +
 .../selftests/net/unicast_extensions.sh       |  9 +----
 .../selftests/net/vrf_route_leaking.sh        |  3 +-
 7 files changed, 23 insertions(+), 59 deletions(-)

diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index 386ebd829df5..899dbad0104b 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -4304,14 +4304,7 @@ elif [ "$TESTS" = "ipv6" ]; then
 	TESTS="$TESTS_IPV6"
 fi
 
-# nettest can be run from PATH or from same directory as this selftest
-if ! which nettest >/dev/null; then
-	PATH=$PWD:$PATH
-	if ! which nettest >/dev/null; then
-		echo "'nettest' command not found; skipping tests"
-		exit $ksft_skip
-	fi
-fi
+check_gen_prog "nettest"
 
 declare -i nfail=0
 declare -i nsuccess=0
diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 89034c5b69dc..53c5c1ad437e 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -51,31 +51,6 @@ log_test()
 	fi
 }
 
-check_nettest()
-{
-	if which nettest > /dev/null 2>&1; then
-		return 0
-	fi
-
-	# Add the selftest directory to PATH if not already done
-	if [ "${SELFTEST_PATH}" = "" ]; then
-		SELFTEST_PATH="$(dirname $0)"
-		PATH="${PATH}:${SELFTEST_PATH}"
-
-		# Now retry with the new path
-		if which nettest > /dev/null 2>&1; then
-			return 0
-		fi
-
-		if [ "${ret}" -eq 0 ]; then
-			ret="${ksft_skip}"
-		fi
-		echo "nettest not found (try 'make -C ${SELFTEST_PATH} nettest')"
-	fi
-
-	return 1
-}
-
 setup()
 {
 	set -e
@@ -317,11 +292,6 @@ fib_rule6_connect_test()
 	echo
 	echo "IPv6 FIB rule connect tests"
 
-	if ! check_nettest; then
-		echo "SKIP: Could not run test without nettest tool"
-		return
-	fi
-
 	setup_peer
 	$IP -6 rule add dsfield 0x04 table $RTABLE_PEER
 
@@ -516,11 +486,6 @@ fib_rule4_connect_test()
 	echo
 	echo "IPv4 FIB rule connect tests"
 
-	if ! check_nettest; then
-		echo "SKIP: Could not run test without nettest tool"
-		return
-	fi
-
 	setup_peer
 	$IP -4 rule add dsfield 0x04 table $RTABLE_PEER
 
@@ -584,6 +549,8 @@ if [ ! -x "$(command -v ip)" ]; then
 	exit $ksft_skip
 fi
 
+check_gen_prog "nettest"
+
 # start clean
 cleanup &> /dev/null
 setup
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 8ee4489238ca..be8707bfb46e 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -125,6 +125,21 @@ slowwait_for_counter()
 	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
 }
 
+# Check for existence of tools which are built as part of selftests
+# but may also already exist in $PATH
+check_gen_prog()
+{
+	local prog_name=$1; shift
+
+	if ! which $prog_name >/dev/null 2>/dev/null; then
+		PATH=$PWD:$PATH
+		if ! which $prog_name >/dev/null; then
+			echo "'$prog_name' command not found; skipping tests"
+			exit $ksft_skip
+		fi
+	fi
+}
+
 remove_ns_list()
 {
 	local item=$1
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 24a50622406c..569bce8b6383 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -681,13 +681,7 @@ setup_xfrm() {
 }
 
 setup_nettest_xfrm() {
-	if ! which nettest >/dev/null; then
-		PATH=$PWD:$PATH
-		if ! which nettest >/dev/null; then
-			echo "'nettest' command not found; skipping tests"
-			return 1
-		fi
-	fi
+	check_gen_prog "nettest"
 
 	[ ${1} -eq 6 ] && proto="-6" || proto=""
 	port=${2}
diff --git a/tools/testing/selftests/net/settings b/tools/testing/selftests/net/settings
index ed8418e8217a..a38764182822 100644
--- a/tools/testing/selftests/net/settings
+++ b/tools/testing/selftests/net/settings
@@ -1 +1,2 @@
 timeout=3600
+profile=1
diff --git a/tools/testing/selftests/net/unicast_extensions.sh b/tools/testing/selftests/net/unicast_extensions.sh
index f52aa5f7da52..3e751234ccfe 100755
--- a/tools/testing/selftests/net/unicast_extensions.sh
+++ b/tools/testing/selftests/net/unicast_extensions.sh
@@ -30,14 +30,7 @@
 
 source lib.sh
 
-# nettest can be run from PATH or from same directory as this selftest
-if ! which nettest >/dev/null; then
-	PATH=$PWD:$PATH
-	if ! which nettest >/dev/null; then
-		echo "'nettest' command not found; skipping tests"
-		exit $ksft_skip
-	fi
-fi
+check_gen_prog "nettest"
 
 result=0
 
diff --git a/tools/testing/selftests/net/vrf_route_leaking.sh b/tools/testing/selftests/net/vrf_route_leaking.sh
index 152171fb1fc8..e9c2f71da207 100755
--- a/tools/testing/selftests/net/vrf_route_leaking.sh
+++ b/tools/testing/selftests/net/vrf_route_leaking.sh
@@ -59,7 +59,6 @@
 # while it is forwarded between different vrfs.
 
 source lib.sh
-PATH=$PWD:$PWD/tools/testing/selftests/net:$PATH
 VERBOSE=0
 PAUSE_ON_FAIL=no
 DEFAULT_TTYPE=sym
@@ -636,6 +635,8 @@ EOF
 # Some systems don't have a ping6 binary anymore
 command -v ping6 > /dev/null 2>&1 && ping6=$(command -v ping6) || ping6=$(command -v ping)
 
+check_gen_prog "nettest"
+
 TESTS_IPV4="ipv4_ping_ttl ipv4_traceroute ipv4_ping_frag ipv4_ping_local ipv4_tcp_local
 ipv4_udp_local ipv4_ping_ttl_asym ipv4_traceroute_asym"
 TESTS_IPV6="ipv6_ping_ttl ipv6_traceroute ipv6_ping_local ipv6_tcp_local ipv6_udp_local
-- 
2.46.0


