Return-Path: <linux-kselftest+bounces-1005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B968019CA
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 03:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD044B20F49
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 02:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28301FA2;
	Sat,  2 Dec 2023 02:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDVRIcXt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A549D;
	Fri,  1 Dec 2023 18:01:30 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-35cd70d7735so9738115ab.0;
        Fri, 01 Dec 2023 18:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701482489; x=1702087289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVG40bGflvJHp7vRz1Prh667sBO5unojLrnIR6K/YlM=;
        b=LDVRIcXtE0F9E/EZ3qnx8RfpTWhxk/gbx4SMXaHQKQo2QYwAzOL4/gU3AcaB4gAgBV
         /gkSvJdwrmrWNX940iYjIDMMAu85/yWyv16naHVj6NvkNHMYmRYnotTDVmyWpQIhzgkG
         Xjx+CDb+fQefBRcv2KwLevb6ujEgy1ACdVCGu3jG7OJPejRIU1kWafsUB6OEdHfb/dGE
         3eEE886wxzeQn7vaME6HulVR/N1CikyG9hA/DiCTFoKMYI4YY5UoRqSgVdTbcu4RlQ9U
         FONbDYUq59vgcFIF2EAIvc2CqwKcv8WTLTEhzqf/Uu4eO89X4QDaewN0o+p8n/B3kw6J
         m4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701482489; x=1702087289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVG40bGflvJHp7vRz1Prh667sBO5unojLrnIR6K/YlM=;
        b=FwkNcuNk7v0WTv4VnIojAJlEfenIxuNsZJlkrLdO/Glof3+Tu0a0RqCOk1yb1Godxe
         FrExtiBAoi/nX0lvV01+EfHuPtBfa6Q4FE61COohk4It61FcW5DUDYubyw/fLkYy4CsM
         Uz1I9QfilJc+7bNhDl0gQZ+WCZlWCGHpGtRKraD1+3TPDEBb+yUXnJ/iIxs4aZ/LbA8F
         gRloMvdq/H82WJIZ4uDgo7wUTMEHr57IYUjHemWMrrk4Lisjmkqy+UPsVbXxiPKaM4TD
         cMpL9W6aWCIA06lybIx43/TVXGgKY0LeUSMB/w/gKIHUy2idK7R70GotRVLmbKD90odG
         TYfw==
X-Gm-Message-State: AOJu0Yx175oP5wOhj9xUBBFvxIvAX7iRttYk3A5QQJHSZAWMjLr7yZGK
	lU6SMiwSDp5LJ3O3rlaFoGxB+xKBm971eRt2
X-Google-Smtp-Source: AGHT+IGibArqUE+LOHro3cGFgAGWA30oXnUAkU67pA95GAQt4Pnyq+YAEh8eVXBFM9jVjAj6tc8igQ==
X-Received: by 2002:a05:6e02:1b04:b0:35d:3ac4:b7cb with SMTP id i4-20020a056e021b0400b0035d3ac4b7cbmr689929ilv.19.1701482488806;
        Fri, 01 Dec 2023 18:01:28 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001b3bf8001a9sm3993034plf.48.2023.12.01.18.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 18:01:28 -0800 (PST)
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
	Petr Machata <petrm@nvidia.com>,
	James Prestwood <prestwoj@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	James Chapman <jchapman@katalix.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 02/14] selftests/net: convert arp_ndisc_evict_nocarrier.sh to run it in unique namespace
Date: Sat,  2 Dec 2023 10:00:58 +0800
Message-ID: <20231202020110.362433-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202020110.362433-1-liuhangbin@gmail.com>
References: <20231202020110.362433-1-liuhangbin@gmail.com>
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

Acked-by: David Ahern <dsahern@kernel.org>
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
2.43.0


