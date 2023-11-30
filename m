Return-Path: <linux-kselftest+bounces-864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 925077FE7F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 05:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5ADF1C20D9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 04:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7CF14281;
	Thu, 30 Nov 2023 04:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h60lB6jQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0828C98;
	Wed, 29 Nov 2023 20:01:25 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cdd9c53282so492008b3a.3;
        Wed, 29 Nov 2023 20:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701316884; x=1701921684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4BMHX71E19K9ztiN3KGdXJ/wrhEZNjvAM+grMxCGY0=;
        b=h60lB6jQRC8dmy4rQZHbN/LJw312vCe2oSBkFYxXGHqssfHOp3r/4lbSGnz5p2NgDb
         xgatv4R7Skkc4Iaqy2a5p1iu8Q+23TwijjaIoi0OSP4hdgY2c7oXjHof2P4ueI4yk2WP
         ncSL2t16mK0P5j5ETmsmGL9McT1wUWCOux7PLZSrhaBwqUH6hcYVaa3bpAfHgRXILB2x
         BezzZ4quMIr4HrBjdIcVhQt9/9X4AUya3VIIMGQUepSA45b11fnHJPx9arFHu4LteUJI
         SNJAUKvfr5JcAVMSps88wY68SHJjSa1NptDsCAnvO1qAd830OWOwh8k7Y4gqIX/2e1zw
         S3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701316884; x=1701921684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4BMHX71E19K9ztiN3KGdXJ/wrhEZNjvAM+grMxCGY0=;
        b=V0W02KaISaGocbcX06GtWq4981wnkL6HpTD7ujzwrrvvImDklENdApbtl7UmArCkGV
         znb5VNWIz2SA+iE+MZSAT9k5VSCttx1FkXafhWvK3+ba8XTh0WGwHGcH1lqSePWnMVuq
         RJNFhmD/Wq5ZzcVpk/JJKZAfaYAVAlpMPLMeKDXyvDtNZH++gzIyutGV+NuM2uQq+tzv
         tedPMfH+mo+SJemfebt89g539nluHBWdB4HzBTPUKraPiG0BsH285g5uXWuxIXPkw5eF
         3koqAnKh6DmP27UTcaFUEbI5NXQN9SVSqV97KNqG1kEG/iygqEDePTASbtnHRTF8zo9k
         udGQ==
X-Gm-Message-State: AOJu0YzunLkCTjihDbfgyjW3JrRSMApG5ZPhFjC3ObXN/aEaB+XAh2ji
	4SkVtQs3Pui6PP6NT4fkehZZg0XBONMTUg==
X-Google-Smtp-Source: AGHT+IHMBQCePWVjr2968A7PPxFThn0LQZ43mU+BpJKof5Q1MD+8przRFRwL705+mNvXwh8TbSpQEA==
X-Received: by 2002:a05:6a20:2447:b0:18c:23b0:3b0e with SMTP id t7-20020a056a20244700b0018c23b03b0emr20458135pzc.21.1701316883689;
        Wed, 29 Nov 2023 20:01:23 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm187975pfn.61.2023.11.29.20.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 20:01:23 -0800 (PST)
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
	Francesco Ruggeri <fruggeri@arista.com>,
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 02/14] selftests/net: convert arp_ndisc_evict_nocarrier.sh to run it in unique namespace
Date: Thu, 30 Nov 2023 12:00:53 +0800
Message-ID: <20231130040105.1265779-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130040105.1265779-1-liuhangbin@gmail.com>
References: <20231130040105.1265779-1-liuhangbin@gmail.com>
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
2.41.0


