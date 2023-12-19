Return-Path: <linux-kselftest+bounces-2187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4FF8184CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 10:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F3E1F26932
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 09:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9BF13FF6;
	Tue, 19 Dec 2023 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYcgkx28"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9778F14A9F;
	Tue, 19 Dec 2023 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d3954833a5so2775157b3a.3;
        Tue, 19 Dec 2023 01:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702979376; x=1703584176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5kGCgDBMgBlf/oLmtC8e2e3YQ6iRyG34FFcH/fAsC4=;
        b=hYcgkx28E5x/cO1tGIO0GA8bPEr6s9Ix4ONJdKZqS9fPMnf6E9RpQ9ybN7Ytt+lz/w
         16g7DI1ff3++Boh1JmHxoQo/x70T4xuPDxItwdLYfEJAK4mK0+LFBuK+5Af3a18UMsNR
         jm7zGqx0WrkUJiSFKtHaWjPNsGIxSP1MyzUq8pS3a22gSU53m43yVa7aG6vQ1Tpq2bQG
         1JWO/Fr3UhhLDwhFMo0EGMq7ADhIehJXgd4a59EhvTgxVdmGMZrHHGsaRZI30Vi3ti7K
         vUPI2MulbHSlYxZP895ZemIRmNoVrpj+iWLdT0vRse91YekZ5p8RpPh15zHTou43TZ0v
         oZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702979376; x=1703584176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5kGCgDBMgBlf/oLmtC8e2e3YQ6iRyG34FFcH/fAsC4=;
        b=HBM2ZT5dQcvGsZIfkcUVCjXnMJXa5Ys2tvgtYBFDQBFnr+ZPGAgZlTW7RYMxx7y4nA
         3gshHOcy/nzcNx0Y0jgQ/cFWyQGWlWxYvHeX7DQFOpU4CabFi+KIz0DAWbIFAIHitLZ/
         wk4PzspooM1dwcv+9Wwl7iVdUmDH1sPY38yfgvZTUS0QiK0Jq7rQGTgYEblByKi6D1P+
         L/6y8TG9z/YqcXPMNdZib1qNfrvOqEr/Db8brGJs26Dl9B2oxor+i60agUl69sohVSLX
         1uMdqFkX2Vbxo8Pf7f2Mcfs7bk8DfKpd3Mw5fZvuCD9Xbs+LFEG6+Awat5iEe95DnQbt
         7/aw==
X-Gm-Message-State: AOJu0Yx+f4xfn0G5j91ClKP/uwYGtuUaPA0U6/F3JLS9RtgD7+OmS3/m
	IxZdFlp1VnJxQG2wo4V2lbhfcQlvjbCj0sdl9TQ=
X-Google-Smtp-Source: AGHT+IHlPR4OYY9EHJbVcSsCypxECgNmnIxizgkRH7gXm1xISdwQ56xQebroX6+H5ER+HKhzy6Zzzg==
X-Received: by 2002:a05:6a21:27a9:b0:191:60f5:2a9 with SMTP id rn41-20020a056a2127a900b0019160f502a9mr14762216pzb.80.1702979376362;
        Tue, 19 Dec 2023 01:49:36 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ds17-20020a17090b08d100b0028b21d24ba6sm1076276pjb.15.2023.12.19.01.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:49:35 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Florian Westphal <fw@strlen.de>,
	Martin KaFai Lau <kafai@fb.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 7/8] selftests/net: convert pmtu.sh to run it in unique namespace
Date: Tue, 19 Dec 2023 17:48:55 +0800
Message-ID: <20231219094856.1740079-8-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219094856.1740079-1-liuhangbin@gmail.com>
References: <20231219094856.1740079-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pmtu test use /bin/sh, so we need to source ./lib.sh instead of lib.sh
Here is the test result after conversion.

 # ./pmtu.sh
 TEST: ipv4: PMTU exceptions                                         [ OK ]
 TEST: ipv4: PMTU exceptions - nexthop objects                       [ OK ]
 TEST: ipv6: PMTU exceptions                                         [ OK ]
 TEST: ipv6: PMTU exceptions - nexthop objects                       [ OK ]
 ...
 TEST: ipv4: list and flush cached exceptions - nexthop objects      [ OK ]
 TEST: ipv6: list and flush cached exceptions                        [ OK ]
 TEST: ipv6: list and flush cached exceptions - nexthop objects      [ OK ]
 TEST: ipv4: PMTU exception w/route replace                          [ OK ]
 TEST: ipv4: PMTU exception w/route replace - nexthop objects        [ OK ]
 TEST: ipv6: PMTU exception w/route replace                          [ OK ]
 TEST: ipv6: PMTU exception w/route replace - nexthop objects        [ OK ]

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/pmtu.sh | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index b3b2dc5a630c..175d3d1d773b 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -198,8 +198,7 @@
 # - pmtu_ipv6_route_change
 #	Same as above but with IPv6
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+source ./lib.sh
 
 PAUSE_ON_FAIL=no
 VERBOSE=0
@@ -268,16 +267,6 @@ tests="
 	pmtu_ipv4_route_change		ipv4: PMTU exception w/route replace	1
 	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1"
 
-NS_A="ns-A"
-NS_B="ns-B"
-NS_C="ns-C"
-NS_R1="ns-R1"
-NS_R2="ns-R2"
-ns_a="ip netns exec ${NS_A}"
-ns_b="ip netns exec ${NS_B}"
-ns_c="ip netns exec ${NS_C}"
-ns_r1="ip netns exec ${NS_R1}"
-ns_r2="ip netns exec ${NS_R2}"
 # Addressing and routing for tests with routers: four network segments, with
 # index SEGMENT between 1 and 4, a common prefix (PREFIX4 or PREFIX6) and an
 # identifier ID, which is 1 for hosts (A and B), 2 for routers (R1 and R2).
@@ -543,13 +532,17 @@ setup_ip6ip6() {
 }
 
 setup_namespaces() {
+	setup_ns NS_A NS_B NS_C NS_R1 NS_R2
 	for n in ${NS_A} ${NS_B} ${NS_C} ${NS_R1} ${NS_R2}; do
-		ip netns add ${n} || return 1
-
 		# Disable DAD, so that we don't have to wait to use the
 		# configured IPv6 addresses
 		ip netns exec ${n} sysctl -q net/ipv6/conf/default/accept_dad=0
 	done
+	ns_a="ip netns exec ${NS_A}"
+	ns_b="ip netns exec ${NS_B}"
+	ns_c="ip netns exec ${NS_C}"
+	ns_r1="ip netns exec ${NS_R1}"
+	ns_r2="ip netns exec ${NS_R2}"
 }
 
 setup_veth() {
@@ -839,7 +832,7 @@ setup_bridge() {
 	run_cmd ${ns_a} ip link set br0 up
 
 	run_cmd ${ns_c} ip link add veth_C-A type veth peer name veth_A-C
-	run_cmd ${ns_c} ip link set veth_A-C netns ns-A
+	run_cmd ${ns_c} ip link set veth_A-C netns ${NS_A}
 
 	run_cmd ${ns_a} ip link set veth_A-C up
 	run_cmd ${ns_c} ip link set veth_C-A up
@@ -944,9 +937,7 @@ cleanup() {
 	done
 	socat_pids=
 
-	for n in ${NS_A} ${NS_B} ${NS_C} ${NS_R1} ${NS_R2}; do
-		ip netns del ${n} 2> /dev/null
-	done
+	cleanup_all_ns
 
 	ip link del veth_A-C			2>/dev/null
 	ip link del veth_A-R1			2>/dev/null
-- 
2.43.0


