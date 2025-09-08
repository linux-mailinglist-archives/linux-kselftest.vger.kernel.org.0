Return-Path: <linux-kselftest+bounces-40988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4ACB49ABC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 22:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C163BB9BF
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 20:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0192D7DE9;
	Mon,  8 Sep 2025 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6In0G51"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B561A9FAC;
	Mon,  8 Sep 2025 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362224; cv=none; b=PzsblePurerEzXy+ELGLQknjvQsnbHur8hnw9wMzaIYp29oVH279NL9YpoIu1pgCpdzKZ6/dQ7X3sHc1ka27ZEN2XooCcuT1iH2X5urfLqMydxUPSjquXufa+oxDWDcgUWxV0AY1xjc8C8RMXuYGBiTSZpDvW6Y/DY30JcXpXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362224; c=relaxed/simple;
	bh=ZgyiEoPgoIUXXdCjAD8svP/xjoH2RVIvO/gTkTSBKac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hoaGcNL7ApaffEOS9APT4Dev+etg2CGAJNeTwNuD2CdB84dFuCrs/hSbLPyDMOjEUeQamkQYu5/VBYc9JqFcfLT4tLyin5emaiSfBNE0k2OAwi9PYfdACcqjrwDq+1i/Egv6fczUrzTRAQ3OSvjFXKTlMxH1jauJC7LmZhVXevk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6In0G51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9196EC4CEF1;
	Mon,  8 Sep 2025 20:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757362223;
	bh=ZgyiEoPgoIUXXdCjAD8svP/xjoH2RVIvO/gTkTSBKac=;
	h=From:To:Cc:Subject:Date:From;
	b=c6In0G51td4A7NVKgWs8XjVMgMeHcg5G+exIREUwuPigwmgb0/6kjd+iSjqmgml2w
	 69AgCjR5VgGee+umiBz+rID+QazZlqLyvAjvS0tsun6lEwf0kFc+rP7oMQRX7EHpTf
	 KT6U13KmVpdAWjWtQk4VqUWGKlN1CLiZOQqWYC8/kdtFHawpf8XoS6Zhie6twlKOGG
	 Aqb9FoUvtRVIV2ATtZ46kQRcui1BjUOwt2wvXw/DzcUjSpCcrzfNnx8XZ684IPDF9E
	 jbRWWYH4EeuVFfp/HjkdVeHuo/Lm9cIxR9G8tpQNADjuSiSNV5b9FOmd8z3oh+UiX5
	 b5mEsRe/Ci5gg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next v2] selftests: net: run groups from fcnal-test in parallel
Date: Mon,  8 Sep 2025 13:10:21 -0700
Message-ID: <20250908201021.270681-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fcnal-test.sh takes almost hour and a half to finish.
The tests are already grouped into ipv4, ipv6 and other.
Run those groups separately.

Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: no changes, previous posting had a trivial Makefile conflict
v1: https://lore.kernel.org/20250907012116.3315344-2-kuba@kernel.org
---
 tools/testing/selftests/net/Makefile       | 4 +++-
 tools/testing/selftests/net/fcnal-ipv4.sh  | 2 ++
 tools/testing/selftests/net/fcnal-ipv6.sh  | 2 ++
 tools/testing/selftests/net/fcnal-other.sh | 2 ++
 tools/testing/selftests/net/fcnal-test.sh  | 3 +++
 5 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/fcnal-ipv4.sh
 create mode 100755 tools/testing/selftests/net/fcnal-ipv6.sh
 create mode 100755 tools/testing/selftests/net/fcnal-other.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 8c860782f9cd..8270f747ffbc 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -8,11 +8,12 @@ CFLAGS += -I../
 
 TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh \
 	      rtnetlink.sh xfrm_policy.sh
+TEST_PROGS += fcnal-ipv4.sh fcnal-ipv6.sh fcnal-other.sh
 TEST_PROGS += fib_tests.sh fib-onlink-tests.sh pmtu.sh udpgso.sh ip_defrag.sh
 TEST_PROGS += udpgso_bench.sh fib_rule_tests.sh msg_zerocopy.sh psock_snd.sh
 TEST_PROGS += udpgro_bench.sh udpgro.sh test_vxlan_under_vrf.sh reuseport_addr_any.sh
 TEST_PROGS += test_vxlan_fdb_changelink.sh so_txtime.sh ipv6_flowlabel.sh
-TEST_PROGS += tcp_fastopen_backup_key.sh fcnal-test.sh l2tp.sh traceroute.sh
+TEST_PROGS += tcp_fastopen_backup_key.sh l2tp.sh traceroute.sh
 TEST_PROGS += fin_ack_lat.sh fib_nexthop_multiprefix.sh fib_nexthops.sh fib_nexthop_nongw.sh
 TEST_PROGS += altnames.sh icmp.sh icmp_redirect.sh ip6_gre_headroom.sh
 TEST_PROGS += route_localnet.sh
@@ -127,6 +128,7 @@ TEST_GEN_FILES += $(YNL_GEN_FILES)
 TEST_GEN_PROGS += $(YNL_GEN_PROGS)
 
 TEST_FILES := settings
+TEST_FILES += fcnal-test.sh
 TEST_FILES += in_netns.sh lib.sh setup_loopback.sh setup_veth.sh
 
 TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
diff --git a/tools/testing/selftests/net/fcnal-ipv4.sh b/tools/testing/selftests/net/fcnal-ipv4.sh
new file mode 100755
index 000000000000..82f9c867c3e8
--- /dev/null
+++ b/tools/testing/selftests/net/fcnal-ipv4.sh
@@ -0,0 +1,2 @@
+#!/bin/sh
+./fcnal-test.sh -t ipv4
diff --git a/tools/testing/selftests/net/fcnal-ipv6.sh b/tools/testing/selftests/net/fcnal-ipv6.sh
new file mode 100755
index 000000000000..ab1fc7aa3caf
--- /dev/null
+++ b/tools/testing/selftests/net/fcnal-ipv6.sh
@@ -0,0 +1,2 @@
+#!/bin/sh
+./fcnal-test.sh -t ipv6
diff --git a/tools/testing/selftests/net/fcnal-other.sh b/tools/testing/selftests/net/fcnal-other.sh
new file mode 100755
index 000000000000..a840cf80b32e
--- /dev/null
+++ b/tools/testing/selftests/net/fcnal-other.sh
@@ -0,0 +1,2 @@
+#!/bin/sh
+./fcnal-test.sh -t other
diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index 0e3304d37fd0..49d85d267925 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -4272,6 +4272,7 @@ EOF
 TESTS_IPV4="ipv4_ping ipv4_tcp ipv4_udp ipv4_bind ipv4_runtime ipv4_netfilter"
 TESTS_IPV6="ipv6_ping ipv6_tcp ipv6_udp ipv6_bind ipv6_runtime ipv6_netfilter"
 TESTS_OTHER="use_cases"
+# note: each TEST_ group needs a dedicated runner, e.g. fcnal-ipv4.sh
 
 PAUSE_ON_FAIL=no
 PAUSE=no
@@ -4302,6 +4303,8 @@ elif [ "$TESTS" = "ipv4" ]; then
 	TESTS="$TESTS_IPV4"
 elif [ "$TESTS" = "ipv6" ]; then
 	TESTS="$TESTS_IPV6"
+elif [ "$TESTS" = "other" ]; then
+	TESTS="$TESTS_OTHER"
 fi
 
 check_gen_prog "nettest"
-- 
2.51.0


