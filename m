Return-Path: <linux-kselftest+bounces-41906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDB4B87EB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 07:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EEF67C66E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 05:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2817523E33D;
	Fri, 19 Sep 2025 05:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3LuL2so"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870E2E40E
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 05:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758260190; cv=none; b=X8ZpFSPJ33hK0ov2N99rQWnEJOdTIo4+kVy9Y5gb9IT/GeluSW9UCJdT9bLzJLqRRO+v28UwOcfkTzxij1UFQ7sahl95lVa3YrGxHP6W7o4qNlDPBK5VrvWgox9OFkANA7URbfYyRDOS74PN1JqQnlSdHSitrfMHET8WZEVi4Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758260190; c=relaxed/simple;
	bh=bur78PqNFJfhzmMKFQIz35smWwxMkCCTkooN4tN23do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uWOdGa/Hp157TADHKg4trVFrlHUtefsTFOARvzYZpyzQ6pajXgI7Wiy3dJVdICgWg48XnAl+tPvN0EOchJs8wMQx1PB0IUcSbJwpPDKwGYafQrlbkJu/PkC1jOhaJL5lWzcfhQXivK9I4X2ZP1yEaWSirJsY1AjqMdkgY3JKgy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3LuL2so; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77716518125so985682b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 22:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758260188; x=1758864988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BfckRLT7OJTCgxiIi4g65qOHRrFeyMOObMvj0q6CVWA=;
        b=A3LuL2soa27JVebTCnYkepaymwkKlwcgolLhFVsWHhbM1Y/dNBpSzQKU8BbpC/JkzZ
         2JzHRdyqNXGc2ekJGa1+74S6MZlcwj9BoToUOwtC/hWRP8WOtEd2YID6dvHnVzGorGJx
         4ccy5PjJOh5Ex4ePTUQgZBV0Nb3EILqBN+5uHQklyKTMa3QyzLuhBPuNfILi/+FyZCYx
         elAByrjz5vZlgNZupc0GmhvnzFiTVfV0LZiTInvHJexIEeOu0laFv9E9uyqAx3eiwzgD
         CLBIT6R55+qXEgI70z+audJL5sQyyiQ+PhQj8rxmOEql+Xs25nfspqny88BRyUS4GKG6
         Ln+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758260188; x=1758864988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfckRLT7OJTCgxiIi4g65qOHRrFeyMOObMvj0q6CVWA=;
        b=woCrnlJGL4fBldAEXkQdTY554OoU33q3Grde5d3qHNabQa599O/jPlWZagyQYj+ZOq
         rWQ7bwkwWIoCpsURDAysbIV0N59SrrfgHEOB2fweA95ryWBW5iJ1VMvANxdJguGSaYvU
         MSMElCPGlgInYSe2f7ZA7V490O3a+5suOkvAolqVcttxVc3J4MxxNMM8zfIRdyNRGjuf
         rVjduyfLYDJWzlQaTY1Fy5jquNYMYTEM9N2Vxak3tyQZ081tBd+EAiokHVVyiID+i1nG
         vSZnDbH0zCPxQ1d9sbd++eQC0Mbh7zh2Aqn2KHZjeqsS9f6oC4oyBXdd2JOnB7AkoOaH
         paow==
X-Forwarded-Encrypted: i=1; AJvYcCX8jmwB5G+kgGJh+LkaQFOTw2I52z197c7/QVApVbdLTmwP3GOSiF2D0FZRzOyVGDlxqZUNCWp3LpfdmYSERo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoxiv34gKh3PqjT8AWs5/JQA7D6aC0kRvf89OuuY5l9CQbXxD1
	g8N0k3wMTeomkrn+p18UnbfBxHNkDlp91FOqs4/4idYN7NnH/FIZ26J1
X-Gm-Gg: ASbGncuDm8DFvV87OWz1bgR3ncrw+u2cqSc/9AM8hiybD0SXKyLYWxDRw8tO7JtdyS/
	kOZCRm+PXWu9LFGNQB1M36kX4oDFnDdRbTAGZa/eGeNieVxur/1L6KsZ3UwVjQJVt8SDQOvuS/o
	3HsjfOijEhRj0ybXWkqjCH4oUX+aE8aFs8v6fHxa3r2ALM09cHWSEyN6gtr9drl/JCQW+RVyrnC
	mnsmKl/ze8kwnyJvUV4z/gPqv+GDe0oFDQZjN/4TbsPHkyydEreyvYFlVCHjgpoE2Fr8zKgNf/5
	JyluTalVXcFWnhkpBuZuw+5PkdkXLVd6yKoeiyEjx+KEQ/qLR+QrFYvmclQVN0RrgazJ3BJ5JS8
	K2WG/cHg5Y6qAsz1gHb5JVyiCKOgW0g==
X-Google-Smtp-Source: AGHT+IGSExWPEskcHizTltx0J7f1VjJMC3eQFrCPOKE9XGBBWgTB8/tmB+T7Xtpt+C+wG/6b6xS5bQ==
X-Received: by 2002:a05:6a00:13a1:b0:772:3f03:f3f4 with SMTP id d2e1a72fcca58-77e4dbf2d98mr2699895b3a.14.1758260187504;
        Thu, 18 Sep 2025 22:36:27 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb79c05sm4050429b3a.4.2025.09.18.22.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 22:36:25 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Li Shuang <shuali@redhat.com>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] selftests: forwarding: Reorder (ar)ping arguments to obey POSIX getopt
Date: Fri, 19 Sep 2025 13:35:33 +0800
Message-ID: <20250919053538.1106753-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Quoted from musl wiki:

  GNU getopt permutes argv to pull options to the front, ahead of
  non-option arguments. musl and the POSIX standard getopt stop
  processing options at the first non-option argument with no
  permutation.

Thus these scripts stop working on musl since non-option arguments for
tools using getopt() (in this case, (ar)ping) do not always come last.
Fix it by reordering arguments.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v2: https://lore.kernel.org/r/20250906170440.3513399-1-mmyangfl@gmail.com
  - fix (ar)ping only
v1: https://lore.kernel.org/r/20250905173947.3164807-1-mmyangfl@gmail.com
  - fix CI errors

 .../selftests/net/forwarding/custom_multipath_hash.sh     | 2 +-
 .../selftests/net/forwarding/gre_custom_multipath_hash.sh | 2 +-
 .../selftests/net/forwarding/ip6_forward_instats_vrf.sh   | 6 +++---
 .../net/forwarding/ip6gre_custom_multipath_hash.sh        | 2 +-
 tools/testing/selftests/net/forwarding/lib.sh             | 8 ++++----
 .../selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh  | 2 +-
 .../selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh | 4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
index 7d531f7091e6..5dbfab0e23e3 100755
--- a/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
+++ b/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
@@ -226,7 +226,7 @@ send_flowlabel()
 	# Generate 16384 echo requests, each with a random flow label.
 	ip vrf exec v$h1 sh -c \
 		"for _ in {1..16384}; do \
-			$PING6 2001:db8:4::2 -F 0 -c 1 -q >/dev/null 2>&1; \
+			$PING6 -F 0 -c 1 -q 2001:db8:4::2 >/dev/null 2>&1; \
 		done"
 }
 
diff --git a/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
index dda11a4a9450..b4f17a5bbc61 100755
--- a/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
+++ b/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
@@ -321,7 +321,7 @@ send_flowlabel()
 	# Generate 16384 echo requests, each with a random flow label.
 	ip vrf exec v$h1 sh -c \
 		"for _ in {1..16384}; do \
-			$PING6 2001:db8:2::2 -F 0 -c 1 -q >/dev/null 2>&1; \
+			$PING6 -F 0 -c 1 -q 2001:db8:2::2 >/dev/null 2>&1; \
 		done"
 }
 
diff --git a/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh b/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
index 49fa94b53a1c..25036e38043c 100755
--- a/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
+++ b/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
@@ -95,7 +95,7 @@ ipv6_in_too_big_err()
 
 	# Send too big packets
 	ip vrf exec $vrf_name \
-		$PING6 -s 1300 2001:1:2::2 -c 1 -w $PING_TIMEOUT &> /dev/null
+		$PING6 -s 1300 -c 1 -w $PING_TIMEOUT 2001:1:2::2 &> /dev/null
 
 	local t1=$(ipv6_stats_get $rtr1 Ip6InTooBigErrors)
 	test "$((t1 - t0))" -ne 0
@@ -131,7 +131,7 @@ ipv6_in_addr_err()
 	# Disable forwarding temporary while sending the packet
 	sysctl -qw net.ipv6.conf.all.forwarding=0
 	ip vrf exec $vrf_name \
-		$PING6 2001:1:2::2 -c 1 -w $PING_TIMEOUT &> /dev/null
+		$PING6 -c 1 -w $PING_TIMEOUT 2001:1:2::2 &> /dev/null
 	sysctl -qw net.ipv6.conf.all.forwarding=1
 
 	local t1=$(ipv6_stats_get $rtr1 Ip6InAddrErrors)
@@ -150,7 +150,7 @@ ipv6_in_discard()
 	# Add a policy to discard
 	ip xfrm policy add dst 2001:1:2::2/128 dir fwd action block
 	ip vrf exec $vrf_name \
-		$PING6 2001:1:2::2 -c 1 -w $PING_TIMEOUT &> /dev/null
+		$PING6 -c 1 -w $PING_TIMEOUT 2001:1:2::2 &> /dev/null
 	ip xfrm policy del dst 2001:1:2::2/128 dir fwd
 
 	local t1=$(ipv6_stats_get $rtr1 Ip6InDiscards)
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
index e28b4a079e52..b24acfa52a3a 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
@@ -323,7 +323,7 @@ send_flowlabel()
 	# Generate 16384 echo requests, each with a random flow label.
 	ip vrf exec v$h1 sh -c \
 		"for _ in {1..16384}; do \
-			$PING6 2001:db8:2::2 -F 0 -c 1 -q >/dev/null 2>&1; \
+			$PING6 -F 0 -c 1 -q 2001:db8:2::2 >/dev/null 2>&1; \
 		done"
 }
 
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 08121cb9dc26..2c252423b326 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1267,8 +1267,8 @@ ping_do()
 
 	vrf_name=$(master_name_get $if_name)
 	ip vrf exec $vrf_name \
-		$PING $args $dip -c $PING_COUNT -i 0.1 \
-		-w $PING_TIMEOUT &> /dev/null
+		$PING $args -c $PING_COUNT -i 0.1 \
+		-w $PING_TIMEOUT $dip &> /dev/null
 }
 
 ping_test()
@@ -1298,8 +1298,8 @@ ping6_do()
 
 	vrf_name=$(master_name_get $if_name)
 	ip vrf exec $vrf_name \
-		$PING6 $args $dip -c $PING_COUNT -i 0.1 \
-		-w $PING_TIMEOUT &> /dev/null
+		$PING6 $args -c $PING_COUNT -i 0.1 \
+		-w $PING_TIMEOUT $dip &> /dev/null
 }
 
 ping6_test()
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh
index a20d22d1df36..8d4ae6c952a1 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh
@@ -238,7 +238,7 @@ test_lag_slave()
 	ip neigh flush dev br1
 	setup_wait_dev $up_dev
 	setup_wait_dev $host_dev
-	$ARPING -I br1 192.0.2.130 -qfc 1
+	$ARPING -I br1 -qfc 1 192.0.2.130
 	sleep 2
 	mirror_test vrf-h1 192.0.2.1 192.0.2.18 $host_dev 1 ">= 10"
 
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh b/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
index 1b902cc579f6..a21c771908b3 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
@@ -196,7 +196,7 @@ test_span_gre_forbidden_egress()
 
 	bridge vlan add dev $swp3 vid 555
 	# Re-prime FDB
-	$ARPING -I br1.555 192.0.2.130 -fqc 1
+	$ARPING -I br1.555 -fqc 1 192.0.2.130
 	sleep 1
 	quick_test_span_gre_dir $tundev
 
@@ -290,7 +290,7 @@ test_span_gre_fdb_roaming()
 
 	bridge fdb del dev $swp2 $h3mac vlan 555 master 2>/dev/null
 	# Re-prime FDB
-	$ARPING -I br1.555 192.0.2.130 -fqc 1
+	$ARPING -I br1.555 -fqc 1 192.0.2.130
 	sleep 1
 	quick_test_span_gre_dir $tundev
 
-- 
2.51.0


