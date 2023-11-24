Return-Path: <linux-kselftest+bounces-531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD8D7F6FBE
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB358B2130E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23702171B6;
	Fri, 24 Nov 2023 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9g3gysO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46000D7E;
	Fri, 24 Nov 2023 01:29:58 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cfa168faefso4597435ad.3;
        Fri, 24 Nov 2023 01:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818197; x=1701422997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPUPjf4oeCqLfDJ4yqPxsCyC+4K8z49lEnpXaytYLkA=;
        b=B9g3gysO5kEbYJMNGCXuDGC4aDPHjvCL/VeTO3z0XbekIMconvmdIniV3l5cZiiVeW
         sBHOmbgw5Uamz6liHKinLXjcfkFcFd1J2SS37bQ+m3/NJ2pHgRk24ULq3MEBd6v50zOm
         9Lz8U2XGhZQYf5l4xSLpy8fPdk+j+glPih/fgugWpodWzqKnjdlJfwsx/FzOK8gIZcRP
         pO0qoIRxGCvJXGqco+WcMpLVxMxMj/vf0c+ufcuFj/j9vzjpI92WZ/+zsR9FlpJW/NT4
         9qwhwIxnZvJqyIBjljbkxgMl/dlnbTZflyPffjtxb+Thg0fncqGv/y4fwVkkJdNgbD0P
         AffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818197; x=1701422997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPUPjf4oeCqLfDJ4yqPxsCyC+4K8z49lEnpXaytYLkA=;
        b=wq7Tw7ZliJ9VJuy6+A9cguAOmKOafdp3YFK5s2PeIZZKaLYIL32fZOi4gOHgync2sT
         F0Q/ASc/tnbK4PbR68UR4zNkIySlvph+4UupJRs+IO7fu193Q1xI4PmyquMnEvJCC6FQ
         w2kPDHOuB9qWHWekaHwnBI7oWSAh6TmEN2kpJnao2Axfu5rNLB6v2zqqbRTTVFkIMN0E
         jIn+Da7nw6uhpWpnFJ7FzoVY+DTURsKV3ui9VvlkM8ih5KpNptsZkIJ0PfKWt+nsEAAH
         2tV7Finfaxz0kjHCttMGa/gh4YBuyZQLet064XJMnZxyphH/bBH//N5VS1KSgKqGwxXH
         o7sA==
X-Gm-Message-State: AOJu0Yx5hh8K422Fa08g4vAji0D/3AHSPqI9m6PTmxIboiZOIH4sst4D
	mZYt1PW9fA65MVpKkwrxQ24sfB92Z4FCNh99
X-Google-Smtp-Source: AGHT+IE8+9KJC8THodPCZC2qq+nuobGXHdA0ESy6OSISkqIsHzXItAelMDZmA+FF58D/OxOnl6KDxA==
X-Received: by 2002:a17:902:b487:b0:1cf:8c97:e587 with SMTP id y7-20020a170902b48700b001cf8c97e587mr1671858plr.53.1700818197306;
        Fri, 24 Nov 2023 01:29:57 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:29:56 -0800 (PST)
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
Subject: [PATCH net-next 29/38] selftests/net: convert test_vxlan_under_vrf.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:27 +0800
Message-ID: <20231124092736.3673263-30-liuhangbin@gmail.com>
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

]# ./test_vxlan_under_vrf.sh
Checking HV connectivity                                           [ OK ]
Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
Check VM connectivity through VXLAN (underlay in a VRF)            [ OK ]

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/net/test_vxlan_under_vrf.sh     | 70 ++++++++++---------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/net/test_vxlan_under_vrf.sh b/tools/testing/selftests/net/test_vxlan_under_vrf.sh
index 1fd1250ebc66..ae8fbe3f0779 100755
--- a/tools/testing/selftests/net/test_vxlan_under_vrf.sh
+++ b/tools/testing/selftests/net/test_vxlan_under_vrf.sh
@@ -43,15 +43,14 @@
 # This tests both the connectivity between vm-1 and vm-2, and that the underlay
 # can be moved in and out of the vrf by unsetting and setting veth0's master.
 
+source lib.sh
 set -e
 
 cleanup() {
     ip link del veth-hv-1 2>/dev/null || true
     ip link del veth-tap 2>/dev/null || true
 
-    for ns in hv-1 hv-2 vm-1 vm-2; do
-        ip netns del $ns 2>/dev/null || true
-    done
+    cleanup_ns $hv_1 $hv_2 $vm_1 $vm_2
 }
 
 # Clean start
@@ -60,72 +59,75 @@ cleanup &> /dev/null
 [[ $1 == "clean" ]] && exit 0
 
 trap cleanup EXIT
+setup_ns hv_1 hv_2 vm_1 vm_2
+hv[1]=$hv_1
+hv[2]=$hv_2
+vm[1]=$vm_1
+vm[2]=$vm_2
 
 # Setup "Hypervisors" simulated with netns
 ip link add veth-hv-1 type veth peer name veth-hv-2
 setup-hv-networking() {
-    hv=$1
+    id=$1
 
-    ip netns add hv-$hv
-    ip link set veth-hv-$hv netns hv-$hv
-    ip -netns hv-$hv link set veth-hv-$hv name veth0
+    ip link set veth-hv-$id netns ${hv[$id]}
+    ip -netns ${hv[$id]} link set veth-hv-$id name veth0
 
-    ip -netns hv-$hv link add vrf-underlay type vrf table 1
-    ip -netns hv-$hv link set vrf-underlay up
-    ip -netns hv-$hv addr add 172.16.0.$hv/24 dev veth0
-    ip -netns hv-$hv link set veth0 up
+    ip -netns ${hv[$id]} link add vrf-underlay type vrf table 1
+    ip -netns ${hv[$id]} link set vrf-underlay up
+    ip -netns ${hv[$id]} addr add 172.16.0.$id/24 dev veth0
+    ip -netns ${hv[$id]} link set veth0 up
 
-    ip -netns hv-$hv link add br0 type bridge
-    ip -netns hv-$hv link set br0 up
+    ip -netns ${hv[$id]} link add br0 type bridge
+    ip -netns ${hv[$id]} link set br0 up
 
-    ip -netns hv-$hv link add vxlan0 type vxlan id 10 local 172.16.0.$hv dev veth0 dstport 4789
-    ip -netns hv-$hv link set vxlan0 master br0
-    ip -netns hv-$hv link set vxlan0 up
+    ip -netns ${hv[$id]} link add vxlan0 type vxlan id 10 local 172.16.0.$id dev veth0 dstport 4789
+    ip -netns ${hv[$id]} link set vxlan0 master br0
+    ip -netns ${hv[$id]} link set vxlan0 up
 }
 setup-hv-networking 1
 setup-hv-networking 2
 
 # Check connectivity between HVs by pinging hv-2 from hv-1
 echo -n "Checking HV connectivity                                           "
-ip netns exec hv-1 ping -c 1 -W 1 172.16.0.2 &> /dev/null || (echo "[FAIL]"; false)
+ip netns exec $hv_1 ping -c 1 -W 1 172.16.0.2 &> /dev/null || (echo "[FAIL]"; false)
 echo "[ OK ]"
 
 # Setups a "VM" simulated by a netns an a veth pair
 setup-vm() {
     id=$1
 
-    ip netns add vm-$id
     ip link add veth-tap type veth peer name veth-hv
 
-    ip link set veth-tap netns hv-$id
-    ip -netns hv-$id link set veth-tap master br0
-    ip -netns hv-$id link set veth-tap up
+    ip link set veth-tap netns ${hv[$id]}
+    ip -netns ${hv[$id]} link set veth-tap master br0
+    ip -netns ${hv[$id]} link set veth-tap up
 
     ip link set veth-hv address 02:1d:8d:dd:0c:6$id
 
-    ip link set veth-hv netns vm-$id
-    ip -netns vm-$id addr add 10.0.0.$id/24 dev veth-hv
-    ip -netns vm-$id link set veth-hv up
+    ip link set veth-hv netns ${vm[$id]}
+    ip -netns ${vm[$id]} addr add 10.0.0.$id/24 dev veth-hv
+    ip -netns ${vm[$id]} link set veth-hv up
 }
 setup-vm 1
 setup-vm 2
 
 # Setup VTEP routes to make ARP work
-bridge -netns hv-1 fdb add 00:00:00:00:00:00 dev vxlan0 dst 172.16.0.2 self permanent
-bridge -netns hv-2 fdb add 00:00:00:00:00:00 dev vxlan0 dst 172.16.0.1 self permanent
+bridge -netns $hv_1 fdb add 00:00:00:00:00:00 dev vxlan0 dst 172.16.0.2 self permanent
+bridge -netns $hv_2 fdb add 00:00:00:00:00:00 dev vxlan0 dst 172.16.0.1 self permanent
 
 echo -n "Check VM connectivity through VXLAN (underlay in the default VRF)  "
-ip netns exec vm-1 ping -c 1 -W 1 10.0.0.2 &> /dev/null || (echo "[FAIL]"; false)
+ip netns exec $vm_1 ping -c 1 -W 1 10.0.0.2 &> /dev/null || (echo "[FAIL]"; false)
 echo "[ OK ]"
 
 # Move the underlay to a non-default VRF
-ip -netns hv-1 link set veth0 vrf vrf-underlay
-ip -netns hv-1 link set vxlan0 down
-ip -netns hv-1 link set vxlan0 up
-ip -netns hv-2 link set veth0 vrf vrf-underlay
-ip -netns hv-2 link set vxlan0 down
-ip -netns hv-2 link set vxlan0 up
+ip -netns $hv_1 link set veth0 vrf vrf-underlay
+ip -netns $hv_1 link set vxlan0 down
+ip -netns $hv_1 link set vxlan0 up
+ip -netns $hv_2 link set veth0 vrf vrf-underlay
+ip -netns $hv_2 link set vxlan0 down
+ip -netns $hv_2 link set vxlan0 up
 
 echo -n "Check VM connectivity through VXLAN (underlay in a VRF)            "
-ip netns exec vm-1 ping -c 1 -W 1 10.0.0.2 &> /dev/null || (echo "[FAIL]"; false)
+ip netns exec $vm_1 ping -c 1 -W 1 10.0.0.2 &> /dev/null || (echo "[FAIL]"; false)
 echo "[ OK ]"
-- 
2.41.0


