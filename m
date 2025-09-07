Return-Path: <linux-kselftest+bounces-40902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EABB4787A
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 03:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57911694E1
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 01:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4220D12DDA1;
	Sun,  7 Sep 2025 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojML1cjx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00C1DDF7;
	Sun,  7 Sep 2025 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208086; cv=none; b=AMvmWCsljS9sPJdV3BLmKmTvv5d90THTNA2OxeOS7u1QWc/lNn7a26crCbtkF9yyUVrtYCUj3erAC2LAaOmUKI3SAwtsThTh6spxLzQAOJfUyOwyvNdbFrj+WLSVgUL5pjc8DmkLKcS0ezW/EILXF/eeNF3gq0cc9yf6L2y1m0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208086; c=relaxed/simple;
	bh=rtX3oKEEiJXaqHWETBe8kB5dsg2UHl0IvweYcav6NfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uyg8xzcoBNzt8bL966dKsR9lg2SSybxI+3A9k2uakJqj2hElP9vj6Zhwc+X1O479tanJAvrypSDHOdkXQ0o+z8PlIOosZi7ktDYLKl7anOCTn/SRPDk3c8y00xOo1l0+yrdthIMZIUJnu9UZNrX3dLB2vS7M+ffcyyLPMnfZ/Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojML1cjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357C0C4CEFB;
	Sun,  7 Sep 2025 01:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757208085;
	bh=rtX3oKEEiJXaqHWETBe8kB5dsg2UHl0IvweYcav6NfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ojML1cjxV+4OLp77L1R+ovTJM2iA9silR38xXfNYryrJ5lgj9Q2c1OUqEhPjFbIZa
	 qJy9Q4MR6oVIjVsiHQEJ7RazLSKmZ95sSx321t8rdf8ekNu9OWwmiuwNBqEeXHD/uy
	 mTg8lY/9BYPe9lvxzDXs2iusn6v2LWzM4hOdwpcialX+BtWdVJXLyZ9cVmXNcPT6KU
	 +5RlJnOOrX9HoPvvo4L5nZBV4HGBr9Y6Fgcm9mFPXY0L1kZM5B6Gp8+LKBUmtQgYct
	 4+vR6J0kuYgRcNtxgmgSmH3tOcnlJW6/5iDZp/v49/M16A7+WAe1eSqx1Jon+sg+W4
	 FZlU7lI8aVDDA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	dsahern@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] selftests: net: run groups from fcnal-test in parallel
Date: Sat,  6 Sep 2025 18:21:16 -0700
Message-ID: <20250907012116.3315344-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907012116.3315344-1-kuba@kernel.org>
References: <20250907012116.3315344-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
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


