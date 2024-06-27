Return-Path: <linux-kselftest+bounces-12861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AC891A9CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80432284429
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1FB19885B;
	Thu, 27 Jun 2024 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gczdeiNf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A51514EE;
	Thu, 27 Jun 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499825; cv=fail; b=RscF1Z2eGDwdA+DWSYsvZ9zT2cYvhdqdoeiclsBxjuKAItLwaTG7XXoqaDAFHm94PPU9apWDHmQrletrMKvtz5897kK9aBwsSuKdXbPLPdd13lWVQ+6u4c+B5yuAyFZi0uL0EnNxeYfIYlnOPtiVBaBRHR0BCdQ/Rfe7UFVwKek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499825; c=relaxed/simple;
	bh=3BiBV6z3cZVF8huW0vjaKRGbRfsyIaJlYAqZ2timINA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1fthqPxK6cc7RspHdC4v7AEja265s57JeE3YLYj4jmbe3mo9KTWQ3VFmvx6bp5kFBtPltSG4A5mLuCUvAmCOBwph/XB2h67WjJ2DjeudrliscAObfxTtxgkaP0jCYHbks8MXtNjIsn5rQ0MTYkDmlVpriD5sxZKefjVU8Uugbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gczdeiNf; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxhYHr1FWwdRoV/ELkLw3yngWoumwozwNbGXz1j508+OwHB8jmGMFOR2lJwQ9bDbFInRezdhn1CgQDdjqiofLBSAqsZ1sb5O0t07uMrb9BlXax+N1+evSnzRcDhOQPykaRLlHKQU5s00r9hnkAvbQKnrVQJxthlUJ7WK5CBK4KiBcAhVz2WQfwkl0XdDdMxHLFDN/x5SAckAymcUVI3/npuw2YddmHJwV3ZUYqYDcRfS64nvPjNqJ80SCZAPgaVjwhkap0zHDKMcXD7E8MleuLvI6XLTfqZKHyFhKX9c1fZNFnPklcby2ZjIEpFEDI9SmgGJJl0NcaTUEQ4X923RAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+Ja5Q7JldMDAIgiy+s7yGatQJaSNmspwBWVPgmTcAs=;
 b=cLOgR36Aye2kTD0n2sj30/AGnAAj0sRsIOL52Hq82XRHfzHe0eDPZk1EUTUPcd04GwhHNk7JVObLnSapNd3nS9dY8wNbp4Y/uFExCepKwkzHjTnYKd9KU3nJF9eGPgNtZN1AgX+NfF5h8e70X1JnMCYi/iQZ5+gXESDLBp07OGG/mzCbWskSi7mxa67Xc7vnyzymGPk3v2Qj40LAYlx4r6cFJ7n3guwxDE9LQcWb57CTGppv7RfWdjRqVPQhHHP58Q7zvECCep2CrcbYQunBbqWNMXZwZu0xxhtdrv+QEXvjMtm/UMjo7+BmcDPveYioo+XLUu8IcpZC/Dp5V/0q/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+Ja5Q7JldMDAIgiy+s7yGatQJaSNmspwBWVPgmTcAs=;
 b=gczdeiNfY4HxeX8aSmIxSKU+hgUSkGaan24qLpD6MyJLCo7M+Xp4tDSZjfzKeGfazlHkZB0VNH04M9YymkgJDmoxAYcIniV/5+tDZt1xZgC+AY/BMtfDe3S5DlpMMzQIOZQoU4ShIbOiRNjkjdaCPbIZievAr4aIe26ZL6VPty0stXGm4YpN9MoeDKKpEIyoSivKxsppyyD8jO53/GKjwyQ0dpFMrXxq6e7JWbD4ZuXK8GWGUIZjCyYN51JoU1EwZchcT9CpxG0zFoW37YRxsGbGvZtScBdCW/dCQPGeCSbV+okE6hyvpx1jZF9P0DZizjDdKP4mljId8ZZu4JxtRQ==
Received: from CH0PR04CA0054.namprd04.prod.outlook.com (2603:10b6:610:77::29)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 14:50:18 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::1f) by CH0PR04CA0054.outlook.office365.com
 (2603:10b6:610:77::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 14:50:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:50:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:50:00 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:49:54 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Danielle Ratson <danieller@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 06/12] selftests: mirror: mirror_test(): Allow exact count of packets
Date: Thu, 27 Jun 2024 16:48:43 +0200
Message-ID: <bbfa9e1f6a6aeaa15a03d4e824e7f2c960446053.1719497773.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1719497773.git.petrm@nvidia.com>
References: <cover.1719497773.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: a401c448-5f77-421c-1a81-08dc96b87669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y7Iz+9YipxK2yPYO9KVBdCK/skBIbSOR5EjjyGcu0QFKGJKDhPg0BpgNYE4J?=
 =?us-ascii?Q?z+4JTl5Ny4gRRKNJcVKhUHgvDoAf4Z7cwik2H2dTIEKxw2MSgywhcFoHYe13?=
 =?us-ascii?Q?ZxbFCIgF4i19jG62FfbMb3tnhLWQB1/+7JKuyK2kURv7FoLTgR1ZxRZVRdDF?=
 =?us-ascii?Q?VVZOdnIxITtVT/64+ddA+4G2jB1NfbMXXWUXtk89mk6IMRyrnmI71NvXVhap?=
 =?us-ascii?Q?bECKcUviW6dnKXKqGOGNkN4YWcNZjCc+K5EIc1KZX04ltwySZLkDRt2OCkKe?=
 =?us-ascii?Q?NIFnSXquESiGVJt2O4unrSt0IhNQmXg4QR3WrQYxmI2J67CcBC4MVhqKJibm?=
 =?us-ascii?Q?VWAeVehxx4jm4prNj8HC8jnCpN9ZcjiRMtUBncieZs1qY6voM7+SXcMfVYDP?=
 =?us-ascii?Q?hIbVELIk0LMCEIeZb29CyT1IvckgaMn2Wm6NRRx/ZSXCE3q/lJksNzSzsw/Z?=
 =?us-ascii?Q?HJ9FmmvaISMXnBsgQd5SFv20cQaSoLrFZEEJsZRmV9gTRUpqKEwsAIgh8jcy?=
 =?us-ascii?Q?L97t6r5MWwc5jr04Wh7YcMI8zSggWfBai6NGBNjJtU21vEtPTQK+jwxYskli?=
 =?us-ascii?Q?WEXCPkFU2SAZwZkuHcw6daHSudOIjGlZQTjFiot12mzULdK4S4tSc72Gy11J?=
 =?us-ascii?Q?zLucMmINaAsvqmAWPGuGQ35mM4q+Ym4mqlk2/hmWAVFhzz9n+G6MdTwuN7YI?=
 =?us-ascii?Q?4dCnFQDH7/jdJSpdlnTmMYlATvly+MBH8nV3Pl6wENQuVzLCJvRwPEpH6G8e?=
 =?us-ascii?Q?UNPB1Nb6MkkFUdDOiGeyap07VA/QccQhHUnoQf07967htZOJyy/PCICyDZoT?=
 =?us-ascii?Q?vQhH1CrNPOd039j1nzQkaFkgv59DyKp+NdqYEi2J7ZWzDnNOPndjLyN61yRj?=
 =?us-ascii?Q?LN855eRlaH7CGm6Cg2Tlv3FAIKWuh3h1fOk5mb3uh3fEy5l6MzjWgVnsnsf0?=
 =?us-ascii?Q?x9yM4OK5YkQqnDF5sJw1Jxr/xLdzJliCDdiNxggZbUJKSUCJxPADhbeH70T/?=
 =?us-ascii?Q?M2hcNKdmuT6oOTeTugxA2wumiwOYUZRkIJtaOJz/WRYWD4SdPMAdUpRQBSus?=
 =?us-ascii?Q?0hI7rARqy6J2mQ8anudi1ugBI9Iz2nKNhfEhmGkJVZvjD+4kF7Nxcxzbse23?=
 =?us-ascii?Q?Bwqm4M9MXfwsxYjttBwbmxu6cu0sNxZe0d4xgjf+87Q4vjYkI1ffIAAohGJw?=
 =?us-ascii?Q?ief6Gv1fXtNN4zpWK7QvLWky/SfS2Wq6nL+30lEY43XzCQBbHHNzE8Uq9Vk8?=
 =?us-ascii?Q?RPKrtnRCdAb9R4w3V6Y4UXcQ2RJtxYmUpf4Go/VTg0Xqn6o9thzwwUbx+nGc?=
 =?us-ascii?Q?6SLhZkIZrsPf/O84WHGK8E35fIRsxkxQx8qMk0WWw23cLY14FdVG6f4j2NyU?=
 =?us-ascii?Q?awhujMRdwvA++X/3VckzB4p1aKRfaLlBvKNZNk9AKximWElYOECTWneNNMmB?=
 =?us-ascii?Q?WMSVuvrGEGfJDUTyyf0FX059xjOlcbgt?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:50:18.2953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a401c448-5f77-421c-1a81-08dc96b87669
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759

The mirroring selftests work by sending ICMP traffic between two hosts.
Along the way, this traffic is mirrored to a gretap netdevice, and counter
taps are then installed strategically along the path of the mirrored
traffic to verify the mirroring took place.

The problem with this is that besides mirroring the primary traffic, any
other service traffic is mirrored as well. At the same time, because the
tests need to work in HW-offloaded scenarios, the ability of the device to
do arbitrary packet inspection should not be taken for granted. Most tests
therefore simply use matchall, one uses flower to match on IP address.

As a result, the selftests are noisy, because besides the primary ICMP
traffic, any amount of other service traffic is mirrored as well.

mirror_test() accommodated this noisiness by giving the counters an
allowance of several packets. But in the previous patch, where possible,
counter taps were changed to match only on an exact ICMP message. At least
in those cases, we can demand an exact number of packets to match.

Where the tap is installed on a connective netdevice, the exact matching is
not practical (though with u32, anything is possible). In those places,
there should still be some leeway -- and probably bigger than before,
because experience shows that these tests are very noisy.

To that end, change mirror_test() so that it can be either called with an
exact number to expect, or with an expression. Where leeway is needed,
adjust callers to pass a ">= 10" instead of mere 10.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/forwarding/mirror_gre_bridge_1q_lag.sh     |  2 +-
 .../selftests/net/forwarding/mirror_gre_changes.sh |  2 +-
 .../selftests/net/forwarding/mirror_gre_lib.sh     |  2 +-
 .../testing/selftests/net/forwarding/mirror_lib.sh | 14 +++++++++-----
 .../selftests/net/forwarding/mirror_vlan.sh        |  2 +-
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh
index c53148b1dc63..b719d24a4ae5 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh
@@ -239,7 +239,7 @@ test_lag_slave()
 	setup_wait_dev $host_dev
 	$ARPING -I br1 192.0.2.130 -qfc 1
 	sleep 2
-	mirror_test vrf-h1 192.0.2.1 192.0.2.18 $host_dev 1 10
+	mirror_test vrf-h1 192.0.2.1 192.0.2.18 $host_dev 1 ">= 10"
 
 	# Test lack of connectivity when both slaves are down.
 	ip link set dev $up_dev down
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
index 3796f4256c9c..b57fb9f069f4 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
@@ -81,7 +81,7 @@ test_span_gre_ttl()
 
 	ip link set dev $tundev type $type ttl 50
 	sleep 2
-	mirror_test v$h1 192.0.2.1 192.0.2.2 $h3 77 10
+	mirror_test v$h1 192.0.2.1 192.0.2.2 $h3 77 ">= 10"
 
 	ip link set dev $tundev type $type ttl 100
 	tc filter del dev $h3 ingress pref 77
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
index e49535ce1cdd..cc3a0a3f83ba 100644
--- a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
@@ -76,7 +76,7 @@ full_test_span_gre_dir_vlan_ips()
 	tc filter add dev $h3 ingress pref 77 prot 802.1q \
 		flower $vlan_match \
 		action pass
-	mirror_test v$h1 $ip1 $ip2 $h3 77 10
+	mirror_test v$h1 $ip1 $ip2 $h3 77 '>= 10'
 	tc filter del dev $h3 ingress pref 77
 
 	mirror_uninstall $swp1 $direction
diff --git a/tools/testing/selftests/net/forwarding/mirror_lib.sh b/tools/testing/selftests/net/forwarding/mirror_lib.sh
index 6a0c66d7ba7f..1fc8545da6e0 100644
--- a/tools/testing/selftests/net/forwarding/mirror_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_lib.sh
@@ -44,14 +44,17 @@ mirror_test()
 		local type="icmp echoreq"
 	fi
 
+	if [[ -z ${expect//[[:digit:]]/} ]]; then
+		expect="== $expect"
+	fi
+
 	local t0=$(tc_rule_stats_get $dev $pref)
 	$MZ $proto $vrf_name ${sip:+-A $sip} -B $dip -a own -b bc -q \
 	    -c 10 -d 100msec -t $type
 	sleep 0.5
 	local t1=$(tc_rule_stats_get $dev $pref)
 	local delta=$((t1 - t0))
-	# Tolerate a couple stray extra packets.
-	((expect <= delta && delta <= expect + 2))
+	((delta $expect))
 	check_err $? "Expected to capture $expect packets, got $delta."
 }
 
@@ -146,8 +149,8 @@ do_test_span_vlan_dir_ips()
 	# The traffic is meant for local box anyway, so will be trapped to
 	# kernel.
 	vlan_capture_install $dev "skip_hw vlan_id $vid vlan_ethtype $ul_proto"
-	mirror_test v$h1 $ip1 $ip2 $dev 100 $expect
-	mirror_test v$h2 $ip2 $ip1 $dev 100 $expect
+	mirror_test v$h1 $ip1 $ip2 $dev 100 "$expect"
+	mirror_test v$h2 $ip2 $ip1 $dev 100 "$expect"
 	vlan_capture_uninstall $dev
 }
 
@@ -159,7 +162,8 @@ quick_test_span_vlan_dir_ips()
 	local ip1=$1; shift
 	local ip2=$1; shift
 
-	do_test_span_vlan_dir_ips 10 "$dev" "$vid" "$ul_proto" "$ip1" "$ip2"
+	do_test_span_vlan_dir_ips '>= 10' "$dev" "$vid" "$ul_proto" \
+				  "$ip1" "$ip2"
 }
 
 fail_test_span_vlan_dir_ips()
diff --git a/tools/testing/selftests/net/forwarding/mirror_vlan.sh b/tools/testing/selftests/net/forwarding/mirror_vlan.sh
index 074165f46a9d..bc3297846511 100755
--- a/tools/testing/selftests/net/forwarding/mirror_vlan.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_vlan.sh
@@ -85,7 +85,7 @@ test_tagged_vlan_dir()
 	RET=0
 
 	mirror_install $swp1 $direction $swp3.555 "matchall $tcflags"
-	do_test_span_vlan_dir_ips 10 "$h3.555" 111 ip 192.0.2.17 192.0.2.18
+	do_test_span_vlan_dir_ips '>= 10' "$h3.555" 111 ip 192.0.2.17 192.0.2.18
 	do_test_span_vlan_dir_ips  0 "$h3.555" 555 ip 192.0.2.17 192.0.2.18
 	mirror_uninstall $swp1 $direction
 
-- 
2.45.0


