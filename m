Return-Path: <linux-kselftest+bounces-1238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 806B08067FB
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 08:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A511F21700
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 07:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815C514290;
	Wed,  6 Dec 2023 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHy7I4uB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5CC135;
	Tue,  5 Dec 2023 23:08:37 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ce939ecfc2so199292b3a.2;
        Tue, 05 Dec 2023 23:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701846516; x=1702451316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3s0v0tmm7rZttm9Kjd91xFnoqznbWUBuQgcCzQ3DAqg=;
        b=bHy7I4uBGVe6NWM7oy6DnBp7V2DfgD7hhyjEHSJ8kcYQTl9tXjUDnObu3GFKII+fwx
         XoBHWV/gAWSJ+k8PVheQfXlg+GK+NO3IExiJRBqMAwW4hcA7aEV0DlI0D7hS/Awkz0v5
         CBTMUKrUYsLyiSigyPhdtkM0MdMKqN3RmP/MBC7WKXOTMZWsv6q89dnSCbnxAzgcLm3x
         0+fUZO8VLMazLhjEL79r7uyWTEQCfKwWkk4nK+FRM2tlL3DmTTPvfJNEjh7mWoIJr//e
         FTUajHvotIH6x5Pa3WCqracpERusmfRFcEkZTjJYAE54XplSeti3RtRCTvgz6CoOBfPz
         Odhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846516; x=1702451316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3s0v0tmm7rZttm9Kjd91xFnoqznbWUBuQgcCzQ3DAqg=;
        b=hFslpxLce3sbR4sLZ5nc/eaXMmHBrWvsZ7H0ZUTeAq1Xgk7XukyJTQLUmownJu6/VG
         JoMIV5oDWs+TiQcR5fw/N3Fou9mHmXQweZnKTgMKBzi4QcWAaJ00u7Agu7s0EINU6qqI
         0d8ajNefUUWifZXAOT3KsVE97xO6rI2wtlzvkisMLqc8zATZp1PafR8bZCL0XrFvG2cs
         cuNwKIvIQu5Gy44evH3LojWtIxMSn1bNN7vagsoon/ZBIhoWktZjD+yLiKOJBsQ12eKZ
         4e63P+HEE/k+gAMF3QX+OClhLkEc4QaKOyYOeU4++cr4xlCiuZDOvofNb+XseuaSRK/e
         cWKw==
X-Gm-Message-State: AOJu0YzVLV31wqDeSztNo7DNF+2pPWyeiF7WScBzpiU0MUk6Gts1J3J2
	PhqzBN+6b/ZJqtd7hdNEJTtBT3Nu2HnhZ5AP
X-Google-Smtp-Source: AGHT+IGykCzPIfYaeFDr3wETdIk2ii1ZagYVQq7HMCBI/L4ShfgLbir53p4w/NFdf2rmZntr14bYZw==
X-Received: by 2002:a05:6a00:3311:b0:6ce:2731:a08d with SMTP id cq17-20020a056a00331100b006ce2731a08dmr482817pfb.60.1701846515547;
        Tue, 05 Dec 2023 23:08:35 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b005b529d633b7sm10184212pgh.14.2023.12.05.23.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:08:35 -0800 (PST)
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
Subject: [PATCH net-next 6/9] selftests/net: convert test_vxlan_vnifiltering.sh to run it in unique namespace
Date: Wed,  6 Dec 2023 15:07:58 +0800
Message-ID: <20231206070801.1691247-7-liuhangbin@gmail.com>
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

]# ./test_vxlan_vnifiltering.sh
    TEST: Create traditional vxlan device                               [ OK ]
    TEST: Cannot create vnifilter device without external flag          [ OK ]
    TEST: Creating external vxlan device with vnifilter flag            [ OK ]
...
    TEST: VM connectivity over traditional vxlan (ipv6 default rdst)    [ OK ]
    TEST: VM connectivity over metadata nonfiltering vxlan (ipv4 default rdst)  [ OK ]

Tests passed:  27
Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/net/test_vxlan_vnifiltering.sh  | 154 +++++++++++-------
 1 file changed, 95 insertions(+), 59 deletions(-)

diff --git a/tools/testing/selftests/net/test_vxlan_vnifiltering.sh b/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
index 8c3ac0a72545..6127a78ee988 100755
--- a/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
+++ b/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
@@ -78,10 +78,8 @@
 #
 #
 # This test tests the new vxlan vnifiltering api
-
+source lib.sh
 ret=0
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
 
 # all tests in this script. Can be overridden with -t option
 TESTS="
@@ -148,18 +146,18 @@ run_cmd()
 }
 
 check_hv_connectivity() {
-	ip netns exec hv-1 ping -c 1 -W 1 $1 &>/dev/null
+	ip netns exec $hv_1 ping -c 1 -W 1 $1 &>/dev/null
 	sleep 1
-	ip netns exec hv-1 ping -c 1 -W 1 $2 &>/dev/null
+	ip netns exec $hv_1 ping -c 1 -W 1 $2 &>/dev/null
 
 	return $?
 }
 
 check_vm_connectivity() {
-	run_cmd "ip netns exec vm-11 ping -c 1 -W 1 10.0.10.12"
+	run_cmd "ip netns exec $vm_11 ping -c 1 -W 1 10.0.10.12"
 	log_test $? 0 "VM connectivity over $1 (ipv4 default rdst)"
 
-	run_cmd "ip netns exec vm-21 ping -c 1 -W 1 10.0.10.22"
+	run_cmd "ip netns exec $vm_21 ping -c 1 -W 1 10.0.10.22"
 	log_test $? 0 "VM connectivity over $1 (ipv6 default rdst)"
 }
 
@@ -167,26 +165,23 @@ cleanup() {
 	ip link del veth-hv-1 2>/dev/null || true
 	ip link del vethhv-11 vethhv-12 vethhv-21 vethhv-22 2>/dev/null || true
 
-	for ns in hv-1 hv-2 vm-11 vm-21 vm-12 vm-22 vm-31 vm-32; do
-		ip netns del $ns 2>/dev/null || true
-	done
+	cleanup_ns $hv_1 $hv_2 $vm_11 $vm_21 $vm_12 $vm_22 $vm_31 $vm_32
 }
 
 trap cleanup EXIT
 
 setup-hv-networking() {
-	hv=$1
+	id=$1
 	local1=$2
 	mask1=$3
 	local2=$4
 	mask2=$5
 
-	ip netns add hv-$hv
-	ip link set veth-hv-$hv netns hv-$hv
-	ip -netns hv-$hv link set veth-hv-$hv name veth0
-	ip -netns hv-$hv addr add $local1/$mask1 dev veth0
-	ip -netns hv-$hv addr add $local2/$mask2 dev veth0
-	ip -netns hv-$hv link set veth0 up
+	ip link set veth-hv-$id netns ${hv[$id]}
+	ip -netns ${hv[$id]} link set veth-hv-$id name veth0
+	ip -netns ${hv[$id]} addr add $local1/$mask1 dev veth0
+	ip -netns ${hv[$id]} addr add $local2/$mask2 dev veth0
+	ip -netns ${hv[$id]} link set veth0 up
 }
 
 # Setups a "VM" simulated by a netns an a veth pair
@@ -208,21 +203,20 @@ setup-vm() {
 	lastvxlandev=""
 
 	# create bridge
-	ip -netns hv-$hvid link add br$brid type bridge vlan_filtering 1 vlan_default_pvid 0 \
+	ip -netns ${hv[$hvid]} link add br$brid type bridge vlan_filtering 1 vlan_default_pvid 0 \
 		mcast_snooping 0
-	ip -netns hv-$hvid link set br$brid up
+	ip -netns ${hv[$hvid]} link set br$brid up
 
 	# create vm namespace and interfaces and connect to hypervisor
 	# namespace
-	ip netns add vm-$vmid
 	hvvethif="vethhv-$vmid"
 	vmvethif="veth-$vmid"
 	ip link add $hvvethif type veth peer name $vmvethif
-	ip link set $hvvethif netns hv-$hvid
-	ip link set $vmvethif netns vm-$vmid
-	ip -netns hv-$hvid link set $hvvethif up
-	ip -netns vm-$vmid link set $vmvethif up
-	ip -netns hv-$hvid link set $hvvethif master br$brid
+	ip link set $hvvethif netns ${hv[$hvid]}
+	ip link set $vmvethif netns ${vm[$vmid]}
+	ip -netns ${hv[$hvid]} link set $hvvethif up
+	ip -netns ${vm[$vmid]} link set $vmvethif up
+	ip -netns ${hv[$hvid]} link set $hvvethif master br$brid
 
 	# configure VM vlan/vni filtering on hypervisor
 	for vmap in $(echo $vattrs | cut -d "," -f1- --output-delimiter=' ')
@@ -234,9 +228,9 @@ setup-vm() {
 	local vtype=$(echo $vmap | awk -F'-' '{print ($5)}')
 	local port=$(echo $vmap | awk -F'-' '{print ($6)}')
 
-	ip -netns vm-$vmid link add name $vmvethif.$vid link $vmvethif type vlan id $vid
-	ip -netns vm-$vmid addr add 10.0.$vid.$vmid/24 dev $vmvethif.$vid
-	ip -netns vm-$vmid link set $vmvethif.$vid up
+	ip -netns ${vm[$vmid]} link add name $vmvethif.$vid link $vmvethif type vlan id $vid
+	ip -netns ${vm[$vmid]} addr add 10.0.$vid.$vmid/24 dev $vmvethif.$vid
+	ip -netns ${vm[$vmid]} link set $vmvethif.$vid up
 
 	tid=$vid
 	vxlandev="vxlan$brid"
@@ -268,35 +262,35 @@ setup-vm() {
 
 	# create vxlan device
 	if [ "$vxlandev" != "$lastvxlandev" ]; then
-	     ip -netns hv-$hvid link add $vxlandev type vxlan local $localip $vxlandevflags dev veth0 2>/dev/null
-	     ip -netns hv-$hvid link set $vxlandev master br$brid
-	     ip -netns hv-$hvid link set $vxlandev up
+	     ip -netns ${hv[$hvid]} link add $vxlandev type vxlan local $localip $vxlandevflags dev veth0 2>/dev/null
+	     ip -netns ${hv[$hvid]} link set $vxlandev master br$brid
+	     ip -netns ${hv[$hvid]} link set $vxlandev up
 	     lastvxlandev=$vxlandev
 	fi
 
 	# add vlan
-	bridge -netns hv-$hvid vlan add vid $vid dev $hvvethif
-	bridge -netns hv-$hvid vlan add vid $vid pvid dev $vxlandev
+	bridge -netns ${hv[$hvid]} vlan add vid $vid dev $hvvethif
+	bridge -netns ${hv[$hvid]} vlan add vid $vid pvid dev $vxlandev
 
 	# Add bridge vni filter for tx
 	if [[ -n $vtype && $vtype == "metadata" || $vtype == "vnifilter" || $vtype == "vnifilterg" ]]; then
-	   bridge -netns hv-$hvid link set dev $vxlandev vlan_tunnel on
-	   bridge -netns hv-$hvid vlan add dev $vxlandev vid $vid tunnel_info id $tid
+	   bridge -netns ${hv[$hvid]} link set dev $vxlandev vlan_tunnel on
+	   bridge -netns ${hv[$hvid]} vlan add dev $vxlandev vid $vid tunnel_info id $tid
 	fi
 
 	if [[ -n $vtype && $vtype == "metadata" ]]; then
-	   bridge -netns hv-$hvid fdb add 00:00:00:00:00:00 dev $vxlandev \
+	   bridge -netns ${hv[$hvid]} fdb add 00:00:00:00:00:00 dev $vxlandev \
 								src_vni $tid vni $tid dst $group self
 	elif [[ -n $vtype && $vtype == "vnifilter" ]]; then
 	   # Add per vni rx filter with 'bridge vni' api
-	   bridge -netns hv-$hvid vni add dev $vxlandev vni $tid
+	   bridge -netns ${hv[$hvid]} vni add dev $vxlandev vni $tid
 	elif [[ -n $vtype && $vtype == "vnifilterg" ]]; then
 	   # Add per vni group config with 'bridge vni' api
 	   if [ -n "$group" ]; then
 		if [ $mcast -eq 1 ]; then
-			bridge -netns hv-$hvid vni add dev $vxlandev vni $tid group $group
+			bridge -netns ${hv[$hvid]} vni add dev $vxlandev vni $tid group $group
 		else
-			bridge -netns hv-$hvid vni add dev $vxlandev vni $tid remote $group
+			bridge -netns ${hv[$hvid]} vni add dev $vxlandev vni $tid remote $group
 		fi
 	   fi
 	fi
@@ -306,14 +300,14 @@ setup-vm() {
 setup_vnifilter_api()
 {
 	ip link add veth-host type veth peer name veth-testns
-	ip netns add testns
-	ip link set veth-testns netns testns
+	setup_ns testns
+	ip link set veth-testns netns $testns
 }
 
 cleanup_vnifilter_api()
 {
 	ip link del veth-host 2>/dev/null || true
-	ip netns del testns 2>/dev/null || true
+	ip netns del $testns 2>/dev/null || true
 }
 
 # tests vxlan filtering api
@@ -331,52 +325,52 @@ vxlan_vnifilter_api()
 
 	# Duplicate vni test
 	# create non-vnifiltering traditional vni device
-	run_cmd "ip -netns testns link add vxlan100 type vxlan id 100 local $localip dev veth-testns dstport 4789"
+	run_cmd "ip -netns $testns link add vxlan100 type vxlan id 100 local $localip dev veth-testns dstport 4789"
 	log_test $? 0 "Create traditional vxlan device"
 
 	# create vni filtering device
-	run_cmd "ip -netns testns link add vxlan-ext1 type vxlan vnifilter local $localip dev veth-testns dstport 4789"
+	run_cmd "ip -netns $testns link add vxlan-ext1 type vxlan vnifilter local $localip dev veth-testns dstport 4789"
 	log_test $? 1 "Cannot create vnifilter device without external flag"
 
-	run_cmd "ip -netns testns link add vxlan-ext1 type vxlan external vnifilter local $localip dev veth-testns dstport 4789"
+	run_cmd "ip -netns $testns link add vxlan-ext1 type vxlan external vnifilter local $localip dev veth-testns dstport 4789"
 	log_test $? 0 "Creating external vxlan device with vnifilter flag"
 
-	run_cmd "bridge -netns testns vni add dev vxlan-ext1 vni 100"
+	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 100"
 	log_test $? 0 "Cannot set in-use vni id on vnifiltering device"
 
-	run_cmd "bridge -netns testns vni add dev vxlan-ext1 vni 200"
+	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 200"
 	log_test $? 0 "Set new vni id on vnifiltering device"
 
-	run_cmd "ip -netns testns link add vxlan-ext2 type vxlan external vnifilter local $localip dev veth-testns dstport 4789"
+	run_cmd "ip -netns $testns link add vxlan-ext2 type vxlan external vnifilter local $localip dev veth-testns dstport 4789"
 	log_test $? 0 "Create second external vxlan device with vnifilter flag"
 
-	run_cmd "bridge -netns testns vni add dev vxlan-ext2 vni 200"
+	run_cmd "bridge -netns $testns vni add dev vxlan-ext2 vni 200"
 	log_test $? 255 "Cannot set in-use vni id on vnifiltering device"
 
-	run_cmd "bridge -netns testns vni add dev vxlan-ext2 vni 300"
+	run_cmd "bridge -netns $testns vni add dev vxlan-ext2 vni 300"
 	log_test $? 0 "Set new vni id on vnifiltering device"
 
 	# check in bridge vni show
-	run_cmd "bridge -netns testns vni add dev vxlan-ext2 vni 300"
+	run_cmd "bridge -netns $testns vni add dev vxlan-ext2 vni 300"
 	log_test $? 0 "Update vni id on vnifiltering device"
 
-	run_cmd "bridge -netns testns vni add dev vxlan-ext2 vni 400"
+	run_cmd "bridge -netns $testns vni add dev vxlan-ext2 vni 400"
 	log_test $? 0 "Add new vni id on vnifiltering device"
 
 	# add multicast group per vni
-	run_cmd "bridge -netns testns vni add dev vxlan-ext1 vni 200 group $group"
+	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 200 group $group"
 	log_test $? 0 "Set multicast group on existing vni"
 
 	# add multicast group per vni
-	run_cmd "bridge -netns testns vni add dev vxlan-ext2 vni 300 group $group"
+	run_cmd "bridge -netns $testns vni add dev vxlan-ext2 vni 300 group $group"
 	log_test $? 0 "Set multicast group on existing vni"
 
 	# set vnifilter on an existing external vxlan device
-	run_cmd "ip -netns testns link set dev vxlan-ext1 type vxlan external vnifilter"
+	run_cmd "ip -netns $testns link set dev vxlan-ext1 type vxlan external vnifilter"
 	log_test $? 2 "Cannot set vnifilter flag on a device"
 
 	# change vxlan vnifilter flag
-	run_cmd "ip -netns testns link set dev vxlan-ext1 type vxlan external novnifilter"
+	run_cmd "ip -netns $testns link set dev vxlan-ext1 type vxlan external novnifilter"
 	log_test $? 2 "Cannot unset vnifilter flag on a device"
 }
 
@@ -390,12 +384,20 @@ vxlan_vnifilter_datapath()
 	hv1addr2="2002:fee1::1"
 	hv2addr2="2002:fee1::2"
 
+	setup_ns hv_1 hv_2
+	hv[1]=$hv_1
+	hv[2]=$hv_2
 	ip link add veth-hv-1 type veth peer name veth-hv-2
 	setup-hv-networking 1 $hv1addr1 24 $hv1addr2 64 $hv2addr1 $hv2addr2
 	setup-hv-networking 2 $hv2addr1 24 $hv2addr2 64 $hv1addr1 $hv1addr2
 
         check_hv_connectivity hv2addr1 hv2addr2
 
+	setup_ns vm_11 vm_21 vm_12 vm_22
+	vm[11]=$vm_11
+	vm[21]=$vm_21
+	vm[12]=$vm_12
+	vm[22]=$vm_22
 	setup-vm 1 11 1 10-v4-$hv1addr1-$hv2addr1-vnifilter,20-v4-$hv1addr1-$hv2addr1-vnifilter 0
 	setup-vm 1 21 2 10-v6-$hv1addr2-$hv2addr2-vnifilter,20-v6-$hv1addr2-$hv2addr2-vnifilter 0
 
@@ -415,12 +417,20 @@ vxlan_vnifilter_datapath_pervni()
 	hv1addr2="2002:fee1::1"
 	hv2addr2="2002:fee1::2"
 
+	setup_ns hv_1 hv_2
+	hv[1]=$hv_1
+	hv[2]=$hv_2
 	ip link add veth-hv-1 type veth peer name veth-hv-2
 	setup-hv-networking 1 $hv1addr1 24 $hv1addr2 64
 	setup-hv-networking 2 $hv2addr1 24 $hv2addr2 64
 
         check_hv_connectivity hv2addr1 hv2addr2
 
+	setup_ns vm_11 vm_21 vm_12 vm_22
+	vm[11]=$vm_11
+	vm[21]=$vm_21
+	vm[12]=$vm_12
+	vm[22]=$vm_22
 	setup-vm 1 11 1 10-v4-$hv1addr1-$hv2addr1-vnifilterg,20-v4-$hv1addr1-$hv2addr1-vnifilterg 0
 	setup-vm 1 21 2 10-v6-$hv1addr2-$hv2addr2-vnifilterg,20-v6-$hv1addr2-$hv2addr2-vnifilterg 0
 
@@ -440,12 +450,20 @@ vxlan_vnifilter_datapath_mgroup()
         group="239.1.1.100"
         group6="ff07::1"
 
+	setup_ns hv_1 hv_2
+	hv[1]=$hv_1
+	hv[2]=$hv_2
 	ip link add veth-hv-1 type veth peer name veth-hv-2
 	setup-hv-networking 1 $hv1addr1 24 $hv1addr2 64
 	setup-hv-networking 2 $hv2addr1 24 $hv2addr2 64
 
         check_hv_connectivity hv2addr1 hv2addr2
 
+	setup_ns vm_11 vm_21 vm_12 vm_22
+	vm[11]=$vm_11
+	vm[21]=$vm_21
+	vm[12]=$vm_12
+	vm[22]=$vm_22
 	setup-vm 1 11 1 10-v4-$hv1addr1-$group-vnifilter,20-v4-$hv1addr1-$group-vnifilter 1
 	setup-vm 1 21 2 "10-v6-$hv1addr2-$group6-vnifilter,20-v6-$hv1addr2-$group6-vnifilter" 1
 
@@ -464,12 +482,20 @@ vxlan_vnifilter_datapath_mgroup_pervni()
         group="239.1.1.100"
         group6="ff07::1"
 
+	setup_ns hv_1 hv_2
+	hv[1]=$hv_1
+	hv[2]=$hv_2
 	ip link add veth-hv-1 type veth peer name veth-hv-2
 	setup-hv-networking 1 $hv1addr1 24 $hv1addr2 64
 	setup-hv-networking 2 $hv2addr1 24 $hv2addr2 64
 
         check_hv_connectivity hv2addr1 hv2addr2
 
+	setup_ns vm_11 vm_21 vm_12 vm_22
+	vm[11]=$vm_11
+	vm[21]=$vm_21
+	vm[12]=$vm_12
+	vm[22]=$vm_22
 	setup-vm 1 11 1 10-v4-$hv1addr1-$group-vnifilterg,20-v4-$hv1addr1-$group-vnifilterg 1
 	setup-vm 1 21 2 10-v6-$hv1addr2-$group6-vnifilterg,20-v6-$hv1addr2-$group6-vnifilterg 1
 
@@ -486,12 +512,22 @@ vxlan_vnifilter_metadata_and_traditional_mix()
 	hv1addr2="2002:fee1::1"
 	hv2addr2="2002:fee1::2"
 
+	setup_ns hv_1 hv_2
+	hv[1]=$hv_1
+	hv[2]=$hv_2
 	ip link add veth-hv-1 type veth peer name veth-hv-2
 	setup-hv-networking 1 $hv1addr1 24 $hv1addr2 64
 	setup-hv-networking 2 $hv2addr1 24 $hv2addr2 64
 
         check_hv_connectivity hv2addr1 hv2addr2
 
+	setup_ns vm_11 vm_21 vm_31 vm_12 vm_22 vm_32
+	vm[11]=$vm_11
+	vm[21]=$vm_21
+	vm[31]=$vm_31
+	vm[12]=$vm_12
+	vm[22]=$vm_22
+	vm[32]=$vm_32
 	setup-vm 1 11 1 10-v4-$hv1addr1-$hv2addr1-vnifilter,20-v4-$hv1addr1-$hv2addr1-vnifilter 0
 	setup-vm 1 21 2 10-v6-$hv1addr2-$hv2addr2-vnifilter,20-v6-$hv1addr2-$hv2addr2-vnifilter 0
 	setup-vm 1 31 3 30-v4-$hv1addr1-$hv2addr1-default-4790,40-v6-$hv1addr2-$hv2addr2-default-4790,50-v4-$hv1addr1-$hv2addr1-metadata-4791 0
@@ -504,13 +540,13 @@ vxlan_vnifilter_metadata_and_traditional_mix()
         check_vm_connectivity "vnifiltering vxlan pervni remote mix"
 
 	# check VM connectivity over traditional/non-vxlan filtering vxlan devices
-	run_cmd "ip netns exec vm-31 ping -c 1 -W 1 10.0.30.32"
+	run_cmd "ip netns exec $vm_31 ping -c 1 -W 1 10.0.30.32"
         log_test $? 0 "VM connectivity over traditional vxlan (ipv4 default rdst)"
 
-	run_cmd "ip netns exec vm-31 ping -c 1 -W 1 10.0.40.32"
+	run_cmd "ip netns exec $vm_31 ping -c 1 -W 1 10.0.40.32"
         log_test $? 0 "VM connectivity over traditional vxlan (ipv6 default rdst)"
 
-	run_cmd "ip netns exec vm-31 ping -c 1 -W 1 10.0.50.32"
+	run_cmd "ip netns exec $vm_31 ping -c 1 -W 1 10.0.50.32"
         log_test $? 0 "VM connectivity over metadata nonfiltering vxlan (ipv4 default rdst)"
 }
 
-- 
2.43.0


