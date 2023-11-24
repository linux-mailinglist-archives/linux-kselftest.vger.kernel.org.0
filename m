Return-Path: <linux-kselftest+bounces-504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753297F6F88
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C67FBB211FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D810D29B;
	Fri, 24 Nov 2023 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCgfVySz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF37D46;
	Fri, 24 Nov 2023 01:28:02 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cf59c07faeso12870105ad.2;
        Fri, 24 Nov 2023 01:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818081; x=1701422881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amdf5W5HZfwxTkR/KEZBnqqDqTHsOv+jX6Lb1e7A47s=;
        b=bCgfVySzmhHnAT/QsDcPBhJ5lECvhS9yK8UpObg5um2BkexybO95hWiZH7nh5UVaoS
         WC0LCRpn2OCKwTRepBvJgcTX34jMSGMgncmJDdFpUjJVNq3etPG2jO0wehe/yAYchgqH
         SdWJRQk8mawuQbIP6Gc9JK2g5oGyNz9A3wIzgDZDzCjp7774H/uDWy8w2p3WK26CxrQT
         ++k1dTBaAXUuiFzppdB65lJkKXPi3zUyKBbS6BTNexohOFOkdBGmdkvXiDWDjzT4NWbH
         J/1rV8A3QqNiRpe8ViTvqEi1VnHre4vzjeTowv6VZqXsuaUX6Jkw77D5fAgZ53dp1q9X
         8H4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818081; x=1701422881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amdf5W5HZfwxTkR/KEZBnqqDqTHsOv+jX6Lb1e7A47s=;
        b=dPgfcQxkFgLdi67mewhMFHQ4PauuttFfeyN//D4DU32B+0qswb0f3/iT+4N/aaKMln
         uMvm6zYq1mOpO72N5WLbnMozJfziJvfCznWYCLOQ5siUhimCmajVObD20+KOjDuEzgdO
         CzQLex/v7ikelnGwTbWB8qIS+MUjOesw69J0RhkrucOJ56OeNpPVTNGOCavyXpOC9UHR
         mAgw63rr7am0BqtoyYAi3wBaLUCCGx1Ahk8SzRt7k7+7TGg05vBIjjwwUotC7GYGhL+4
         NcUrkU5FXPnavzDLn5dXzkl/TtfGfkx9qhG6pumhP5115fYeLrdkkAckwhKEZJebuFSn
         9ZIg==
X-Gm-Message-State: AOJu0YyOM5ntyAUDt99nb8rEyxpvmkdedEHEFiTZJVmvrt0WIiHr745a
	NUO4hjEwFkEl/JzrHvg2lr/n6jgrfUybBXoq
X-Google-Smtp-Source: AGHT+IFDC/mGh2/nQHs1gPwmkbXxniL9q1b0zqu3ZzJQXh6J+HlDABXq2OZY60aTxg7foujdIIE0Nw==
X-Received: by 2002:a17:903:2311:b0:1cc:32df:8eb5 with SMTP id d17-20020a170903231100b001cc32df8eb5mr2275082plh.6.1700818081279;
        Fri, 24 Nov 2023 01:28:01 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:28:00 -0800 (PST)
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
	Guillaume Nault <gnault@redhat.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 02/38] selftests/net: arp_ndisc_evict_nocarrier.sh convert to run test in unique namespace
Date: Fri, 24 Nov 2023 17:27:00 +0800
Message-ID: <20231124092736.3673263-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124092736.3673263-1-liuhangbin@gmail.com>
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

]# ./arp_ndisc_evict_nocarrier.sh
run arp_evict_nocarrier=1 test
ok
run arp_evict_nocarrier=0 test
ok
run all.arp_evict_nocarrier=0 test
ok
run ndisc_evict_nocarrier=1 test
ok
run ndisc_evict_nocarrier=0 test
ok
run all.ndisc_evict_nocarrier=0 test
ok

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../net/arp_ndisc_evict_nocarrier.sh          | 46 +++++++------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/net/arp_ndisc_evict_nocarrier.sh b/tools/testing/selftests/net/arp_ndisc_evict_nocarrier.sh
index 4a110bb01e53..92eb880c52f2 100755
--- a/tools/testing/selftests/net/arp_ndisc_evict_nocarrier.sh
+++ b/tools/testing/selftests/net/arp_ndisc_evict_nocarrier.sh
@@ -12,7 +12,8 @@
 # {arp,ndisc}_evict_nocarrer=0 should still contain the single ARP/ND entry
 #
 
-readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
+source lib.sh
+
 readonly V4_ADDR0=10.0.10.1
 readonly V4_ADDR1=10.0.10.2
 readonly V6_ADDR0=2001:db8:91::1
@@ -22,43 +23,29 @@ ret=0
 
 cleanup_v6()
 {
-    ip netns del me
-    ip netns del peer
+    cleanup_ns ${me} ${peer}
 
     sysctl -w net.ipv6.conf.veth1.ndisc_evict_nocarrier=1 >/dev/null 2>&1
     sysctl -w net.ipv6.conf.all.ndisc_evict_nocarrier=1 >/dev/null 2>&1
 }
 
-create_ns()
-{
-    local n=${1}
-
-    ip netns del ${n} 2>/dev/null
-
-    ip netns add ${n}
-    ip netns set ${n} $((nsid++))
-    ip -netns ${n} link set lo up
-}
-
-
 setup_v6() {
-    create_ns me
-    create_ns peer
+    setup_ns me peer
 
-    IP="ip -netns me"
+    IP="ip -netns ${me}"
 
     $IP li add veth1 type veth peer name veth2
     $IP li set veth1 up
     $IP -6 addr add $V6_ADDR0/64 dev veth1 nodad
-    $IP li set veth2 netns peer up
-    ip -netns peer -6 addr add $V6_ADDR1/64 dev veth2 nodad
+    $IP li set veth2 netns ${peer} up
+    ip -netns ${peer} -6 addr add $V6_ADDR1/64 dev veth2 nodad
 
-    ip netns exec me sysctl -w $1 >/dev/null 2>&1
+    ip netns exec ${me} sysctl -w $1 >/dev/null 2>&1
 
     # Establish an ND cache entry
-    ip netns exec me ping -6 -c1 -Iveth1 $V6_ADDR1 >/dev/null 2>&1
+    ip netns exec ${me} ping -6 -c1 -Iveth1 $V6_ADDR1 >/dev/null 2>&1
     # Should have the veth1 entry in ND table
-    ip netns exec me ip -6 neigh get $V6_ADDR1 dev veth1 >/dev/null 2>&1
+    ip netns exec ${me} ip -6 neigh get $V6_ADDR1 dev veth1 >/dev/null 2>&1
     if [ $? -ne 0 ]; then
         cleanup_v6
         echo "failed"
@@ -66,11 +53,11 @@ setup_v6() {
     fi
 
     # Set veth2 down, which will put veth1 in NOCARRIER state
-    ip netns exec peer ip link set veth2 down
+    ip netns exec ${peer} ip link set veth2 down
 }
 
 setup_v4() {
-    ip netns add "${PEER_NS}"
+    setup_ns PEER_NS
     ip link add name veth0 type veth peer name veth1
     ip link set dev veth0 up
     ip link set dev veth1 netns "${PEER_NS}"
@@ -99,8 +86,7 @@ setup_v4() {
 cleanup_v4() {
     ip neigh flush dev veth0
     ip link del veth0
-    local -r ns="$(ip netns list|grep $PEER_NS)"
-    [ -n "$ns" ] && ip netns del $ns 2>/dev/null
+    cleanup_ns $PEER_NS
 
     sysctl -w net.ipv4.conf.veth0.arp_evict_nocarrier=1 >/dev/null 2>&1
     sysctl -w net.ipv4.conf.all.arp_evict_nocarrier=1 >/dev/null 2>&1
@@ -163,7 +149,7 @@ run_ndisc_evict_nocarrier_enabled() {
 
     setup_v6 "net.ipv6.conf.veth1.ndisc_evict_nocarrier=1"
 
-    ip netns exec me ip -6 neigh get $V6_ADDR1 dev veth1 >/dev/null 2>&1
+    ip netns exec ${me} ip -6 neigh get $V6_ADDR1 dev veth1 >/dev/null 2>&1
 
     if [ $? -eq 0 ];then
         echo "failed"
@@ -180,7 +166,7 @@ run_ndisc_evict_nocarrier_disabled() {
 
     setup_v6 "net.ipv6.conf.veth1.ndisc_evict_nocarrier=0"
 
-    ip netns exec me ip -6 neigh get $V6_ADDR1 dev veth1 >/dev/null 2>&1
+    ip netns exec ${me} ip -6 neigh get $V6_ADDR1 dev veth1 >/dev/null 2>&1
 
     if [ $? -eq 0 ];then
         echo "ok"
@@ -197,7 +183,7 @@ run_ndisc_evict_nocarrier_disabled_all() {
 
     setup_v6 "net.ipv6.conf.all.ndisc_evict_nocarrier=0"
 
-    ip netns exec me ip -6 neigh get $V6_ADDR1 dev veth1 >/dev/null 2>&1
+    ip netns exec ${me} ip -6 neigh get $V6_ADDR1 dev veth1 >/dev/null 2>&1
 
     if [ $? -eq 0 ];then
         echo "ok"
-- 
2.41.0


