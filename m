Return-Path: <linux-kselftest+bounces-1237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A64B8067F8
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 08:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA36BB2129C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 07:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199F214F87;
	Wed,  6 Dec 2023 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVz29lA1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6184C135;
	Tue,  5 Dec 2023 23:08:32 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-58dd3528497so4322866eaf.3;
        Tue, 05 Dec 2023 23:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701846511; x=1702451311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SD31dRZWa1burEJJ998uANZqw/GCS1Ksad779oGXsJ4=;
        b=DVz29lA11X+iQbjsSXzOJUlSbgG+STyKO94c9SL6TxleZX4oTkHoJcNyQFxVDBDLF3
         RDLc2sDcvu2tWGJxox+I/X7Hprjj6FmOkRTpAkBOguHpIMG9rvkfmkGddoIiPpkVdmZD
         oOlN+MFcLcXDmadFBPqMJRtxjRq1UfN4e/0Iss7vHSI1DGJ0eYlwuXhv4sOuJQXAbOLz
         Huq7XhWsWbLxFXLFZpH0Efk5hDmEaQGyJLo+jSDccE55Qw/K3bPAlSSeWdluXbsi9s/5
         NlL8pjh74a/UQSYShzSxbcl0Wo94KJ53O4eeFZEYWhVl3V3ynXcivJdQYiQ9ApbIkqFP
         k4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846511; x=1702451311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SD31dRZWa1burEJJ998uANZqw/GCS1Ksad779oGXsJ4=;
        b=Ye6AztCk+vnYv14FSfUp3U1kWPP9JrITYxQyLaPzAO0OA+K+i6VIYlL9mczSSwPx3c
         gqKGYz9K3FqhuN4sYwgGSJiUwJ3EqqG1J5GJvCn/yBnBTRrMkWrbNeVXKH1UVy8F3+zW
         3LBiSn52wrLmu08PkQXzfkfCF7gW5AYlbXnsB4P5/ZgWuaOXztXs7J465MeyeExZuKhI
         rD54ajjx/FlJYeb0v6X+ZnmNQgtAzpNiPwql9Xnl+Vs7lZo0jrjU0XVHEXnHNbf3dffg
         Wkv4oj4ky+MB7WD62QnaquMnIZOvHdO8QoAWJUPCbmtCLRLN9JUKBXxj4VeMiR6AnvoI
         CNnA==
X-Gm-Message-State: AOJu0YxYqlpG+NGBfooegDhhuOnU5zpTjzf5/A5SMHv1J+pWahYUWiJE
	yIQFbq2B9MBU98KyPhW+xtnrTW0YI57B5rU9
X-Google-Smtp-Source: AGHT+IGZhO4hzKWBsVwUWiOPrgjohYIYkfemvYVHuP8kZNuIDhIn7UaDu1xmSnIPhFJx9lzmyFJxrg==
X-Received: by 2002:a05:6358:5e14:b0:170:73a:e17e with SMTP id q20-20020a0563585e1400b00170073ae17emr492160rwn.4.1701846510957;
        Tue, 05 Dec 2023 23:08:30 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b005b529d633b7sm10184212pgh.14.2023.12.05.23.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:08:30 -0800 (PST)
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
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vladimir Nikishkin <vladimir@nikishkin.pw>,
	Roopa Prabhu <roopa@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 5/9] selftests/net: convert test_vxlan_under_vrf.sh to run it in unique namespace
Date: Wed,  6 Dec 2023 15:07:57 +0800
Message-ID: <20231206070801.1691247-6-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206070801.1691247-1-liuhangbin@gmail.com>
References: <20231206070801.1691247-1-liuhangbin@gmail.com>
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

Acked-by: David Ahern <dsahern@kernel.org>
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
2.43.0


