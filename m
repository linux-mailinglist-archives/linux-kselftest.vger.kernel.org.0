Return-Path: <linux-kselftest+bounces-12856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A62491A9C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A05B22778
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 14:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA353195803;
	Thu, 27 Jun 2024 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mM+V40o6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C5819;
	Thu, 27 Jun 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499793; cv=fail; b=p+hHHUUc5CJMEh+8MA+SPYsEadX3O4dOSKRjfL28O3MbfRJmXqpKWFI+fQ1OtSEHz8gv+x1gunBb3KTltCDBQp5KIUoJdGBPicWTDW7eDW1Cwox8JREIvXP2t6WfznuQetyS3+hB+Q3dXUCM8QtTixP22zxpeo+y6a8NL51GAug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499793; c=relaxed/simple;
	bh=HttYceEmGB0RHPsT/MOScZEBJs8TMMmL19YUUXGXqYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHq3Sjzo/VtgJzVBgMUWeoSiquKmwICVk1pF9SHrSsgYtqcCoWjZrL/EsnHByEEN5rBq2mBNDLovJbHDtYqfDC7+SiKbsRpRhgN8KFfSsro9DNxxlDvIrNbSWqo4rUQsIQ0zkoNHCFVLjFmkv4AWgM4ql+ku82z0hmRbK23lWxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mM+V40o6; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzGlehJV7ezBwJDnfsQt46o+mt4E5L1OdSbkHF4NZGIJfIjLRxtboLXDEV9Y4MdASr1/HBe3FYqPG2LifWckTJp2iJfNNcC1rAjlQ79oZzeUnw3eWO+IDJGh4M05sMvtAOqF8FyWI1ocjoNE8Oh8mVcsqkhik5tEq0YGTMHoNnMWKxsbHvnFycCm9AiJ0tzak+B1vC4AtnAXyq2Ag02c3h3hNxsIB3eKON0gA8sOcyUCy/k8K3q3bVNohJNnql9QUTjb+GGoefeHd9g57VL6fZeKs2MBKPz8a514w3C6Pu7EMGQwt3gMix4zPOYcVdojoQdrY0XXptvlIIeVFAV2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1sliNlEGVsslmGaGwS9pzD6PsTx9kUstHmpLC41xRk=;
 b=ivrdzsrBTlcUgrBFKyY31h8whqhlJmFEP2ceX83PKXf9HBfuiijwh5zvLbHcEesWwRIFHOwNlPp6oabca+zvLim04yP48JQKMp380wGa0BIpdlyq32vsdP2e/lLNStV1HDE1fhP6vIMV5HvvckSCNwsIkjEa1wD+qreXu2PFGJt2zUk8IHrFRUAWOh6DKk7RLfllv3LoByuTjvDyrivz5SXVYhNwFfxMvgUWgkIdVA2nVtOXJ8289X73wHMcZKoO9xqDgURyouXXXTr52ebukM3df+Ktac7pYRlgg/AOeJsGDWs/cDEp4B+971UBd5I1NCrXcvbijslNtbuhD0fP3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1sliNlEGVsslmGaGwS9pzD6PsTx9kUstHmpLC41xRk=;
 b=mM+V40o6Wfv4drAkJLZNY4HSPKmCp35R9yG1db+RiAVogO1N+pS9gANqEKKfbAUwvTdOSnak+4NvARgFyIzmi+GBZNJ8g0CW0PiuBxfJVLvXT65oBSfTnMUjH/30A/+jVf+Z38HzrG3f+uij/fBWua4pIPbecvZzcPQfIZZwwF9d+ZiQiaKffkxyYOy1HiZTWSuIWxEWgFK1HGikJ1NUydNFKCTtYOHeLiSqeAihKYOxrZlPlP5iTmGDx1IGoOKMnKPKBEFMGtVZ3WwMy42kq53nTiHQMC7E+hL1j/S4qlda+FRzwcFMCdgAGO8wWZ9hmO3S/8mnLYydOoueCvDW0Q==
Received: from CH0PR04CA0057.namprd04.prod.outlook.com (2603:10b6:610:77::32)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 14:49:48 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::b1) by CH0PR04CA0057.outlook.office365.com
 (2603:10b6:610:77::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 14:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:49:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:49:30 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:49:24 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Danielle Ratson <danieller@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 01/12] selftests: libs: Expand "$@" where possible
Date: Thu, 27 Jun 2024 16:48:38 +0200
Message-ID: <0072d6f7b0c128f9f12b3770a0a5ed3c20b0f17f.1719497773.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: bea1ebc6-13af-4014-8bfd-08dc96b863c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ir3mHGsF7khEZNxG9dt+6oBvRZW132txjx0q8Aypbwaz+0hzB8+ZH3lHt3Zm?=
 =?us-ascii?Q?ryimaitSpG/qSaKoNBIj0mx4srTF7waP19JDmWabHE9/akfUoVlzK2WDnh6p?=
 =?us-ascii?Q?IlTSr8f6IUsfFwqpQoj1PW9Pq/XEOes9+065a+AqwpDFFDRoWVNiJjEx/5QB?=
 =?us-ascii?Q?QnI6YqqNFVzFR8ot5qMC2pH3Xb4UD6VLeBqBeCPxfBWVw3WesSO+a7xgok1f?=
 =?us-ascii?Q?H68MO8xFu8naqsRAYqHlTdEO9lEbjarA0v3wnDa/932VWdsooX0Tc+DI4VB/?=
 =?us-ascii?Q?WCAB76XOQLLJDx2BCvibQNDGI5suUgfGrN2r1Vh1r5E5JUnY3ychnqgIOGsR?=
 =?us-ascii?Q?83VqFi+ajbq5MLEX0XzplnOf7xZHNikiWLLemwUq5wVNBN67w3UrOqGig0lT?=
 =?us-ascii?Q?lMyrU77YlfA477ixPs6MX/b4g3V67LZLZI4TP0HbqaCzQxt7Gxjhw6OKANFS?=
 =?us-ascii?Q?pzl2dHnWcX0bgAnod7+SfAwW8lcEaA4tfj2Kpuq9NnqtVvKdrM1oIz37prcS?=
 =?us-ascii?Q?2pRuu2KNT9A0+C1E8280PC2bK+mtmv/JrxC+58EeuARF5XPtS33+LRJbyGs7?=
 =?us-ascii?Q?Sms7SNM7jyj3pLAX0xNgf25TMAg76d3rVrVQH3weuiaMrqT+6bLOMqTyZnWO?=
 =?us-ascii?Q?bUaaqHDcgWY7ZlV3IIyVnoKh2ibv5/imSUL0MMYgwTfyJ2MBjTuLsg9GA7/q?=
 =?us-ascii?Q?KalHeJyGCJ2GFSePoAE+IbauxgyLbgxe7LVo/DoawwaH1xl29aaCIqbfncno?=
 =?us-ascii?Q?4rEYvpv5ckMHunOqX5Nal3tK4NxcgXjmYXjinWwlqqtP40w90uxBLazEdWx4?=
 =?us-ascii?Q?N1counVYN4wKMLbteXwlyhu/5TipAlhxF+aLu3UK9an0dO2MhOTSU0QjRsMq?=
 =?us-ascii?Q?+MxUivvAPxaIboZWiteQMQwNZDelsQsrWejOXH93DFeb2fpBp51jQZ9At+ul?=
 =?us-ascii?Q?AFJ+6elA4Vx4aSkt/e42mI0xYN97mDTHAsp2wJgilHnjR0A7c1GilBWunxog?=
 =?us-ascii?Q?lk0ZMmvg4clbBh28hX4eIfL1rLYHi2DvbVfujQV6ZQzBLU5QgWPagNmXsuhf?=
 =?us-ascii?Q?NwF8FYTUVU9FHStndPtwXi6m2Zzwgo4nLueo7/jD+tXS6fUCUNaG5ueaxyja?=
 =?us-ascii?Q?xvUOg0EEDNfNlzx2wnH4UzwpKh/piG8XhdORx2uOxBkWTh3qmk8aMUf9iADf?=
 =?us-ascii?Q?30iIsiOTeRIxtAjXh2Lgnn078fqv4T7s25mQ/EzZuOIiJAKZWDa3czV7iKdt?=
 =?us-ascii?Q?Zjp34zNhB8PlEmdFj3B75evHkOwE9X8p2sayH/vYYT1C97BFKp1OAaervCJn?=
 =?us-ascii?Q?mXDB8ALjlKg4tqEUSG4pOYdP8A5HTGCRvJFSzVLpRT/a4fmtyQZoWe9Zo8KH?=
 =?us-ascii?Q?UCePLb1YfCtU4lcz7hLxFqMUyEkPKIdJ1xZCbOBr9SBabbXDb6lyY1Z0RSWK?=
 =?us-ascii?Q?8tHhnv8Nh+m4Svl5K7flgkl0F5HZuNjU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:49:47.0295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea1ebc6-13af-4014-8bfd-08dc96b863c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917

In some functions, argument-forwarding through "$@" without listing the
individual arguments explicitly is fundamental to the operation of a
function. E.g. xfail_on_veth() should be able to run various tests in the
fail-to-xfail regime, and usage of "$@" is appropriate as an abstraction
mechanism. For functions such as simple_if_init(), $@ is a handy way to
pass an array.

In other functions, it's merely a mechanism to save some typing, which
however ends up obscuring the real arguments and makes life hard for those
that end up reading the code.

This patch adds some of the implicit function arguments and correspondingly
expands $@'s. In several cases this will come in handy as following patches
adjust the parameter lists.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 67 ++++++++++++++++---
 .../net/forwarding/mirror_gre_flower.sh       | 13 +++-
 .../net/forwarding/mirror_gre_lib.sh          | 63 ++++++++++++++---
 .../selftests/net/forwarding/mirror_lib.sh    | 63 ++++++++++++++---
 4 files changed, 176 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 9086d2015296..df7cacb29160 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1257,22 +1257,34 @@ __icmp_capture_add_del()
 
 icmp_capture_install()
 {
-	__icmp_capture_add_del add 100 "" "$@"
+	local tundev=$1; shift
+	local filter=$1; shift
+
+	__icmp_capture_add_del add 100 "" "$tundev" "$filter"
 }
 
 icmp_capture_uninstall()
 {
-	__icmp_capture_add_del del 100 "" "$@"
+	local tundev=$1; shift
+	local filter=$1; shift
+
+	__icmp_capture_add_del del 100 "" "$tundev" "$filter"
 }
 
 icmp6_capture_install()
 {
-	__icmp_capture_add_del add 100 v6 "$@"
+	local tundev=$1; shift
+	local filter=$1; shift
+
+	__icmp_capture_add_del add 100 v6 "$tundev" "$filter"
 }
 
 icmp6_capture_uninstall()
 {
-	__icmp_capture_add_del del 100 v6 "$@"
+	local tundev=$1; shift
+	local filter=$1; shift
+
+	__icmp_capture_add_del del 100 v6 "$tundev" "$filter"
 }
 
 __vlan_capture_add_del()
@@ -1290,12 +1302,18 @@ __vlan_capture_add_del()
 
 vlan_capture_install()
 {
-	__vlan_capture_add_del add 100 "$@"
+	local dev=$1; shift
+	local filter=$1; shift
+
+	__vlan_capture_add_del add 100 "$dev" "$filter"
 }
 
 vlan_capture_uninstall()
 {
-	__vlan_capture_add_del del 100 "$@"
+	local dev=$1; shift
+	local filter=$1; shift
+
+	__vlan_capture_add_del del 100 "$dev" "$filter"
 }
 
 __dscp_capture_add_del()
@@ -1655,34 +1673,61 @@ __start_traffic()
 	local sip=$1; shift
 	local dip=$1; shift
 	local dmac=$1; shift
+	local -a mz_args=("$@")
 
 	$MZ $h_in -p $pktsize -A $sip -B $dip -c 0 \
-		-a own -b $dmac -t "$proto" -q "$@" &
+		-a own -b $dmac -t "$proto" -q "${mz_args[@]}" &
 	sleep 1
 }
 
 start_traffic_pktsize()
 {
 	local pktsize=$1; shift
+	local h_in=$1; shift
+	local sip=$1; shift
+	local dip=$1; shift
+	local dmac=$1; shift
+	local -a mz_args=("$@")
 
-	__start_traffic $pktsize udp "$@"
+	__start_traffic $pktsize udp "$h_in" "$sip" "$dip" "$dmac" \
+			"${mz_args[@]}"
 }
 
 start_tcp_traffic_pktsize()
 {
 	local pktsize=$1; shift
+	local h_in=$1; shift
+	local sip=$1; shift
+	local dip=$1; shift
+	local dmac=$1; shift
+	local -a mz_args=("$@")
 
-	__start_traffic $pktsize tcp "$@"
+	__start_traffic $pktsize tcp "$h_in" "$sip" "$dip" "$dmac" \
+			"${mz_args[@]}"
 }
 
 start_traffic()
 {
-	start_traffic_pktsize 8000 "$@"
+	local h_in=$1; shift
+	local sip=$1; shift
+	local dip=$1; shift
+	local dmac=$1; shift
+	local -a mz_args=("$@")
+
+	start_traffic_pktsize 8000 "$h_in" "$sip" "$dip" "$dmac" \
+			      "${mz_args[@]}"
 }
 
 start_tcp_traffic()
 {
-	start_tcp_traffic_pktsize 8000 "$@"
+	local h_in=$1; shift
+	local sip=$1; shift
+	local dip=$1; shift
+	local dmac=$1; shift
+	local -a mz_args=("$@")
+
+	start_tcp_traffic_pktsize 8000 "$h_in" "$sip" "$dip" "$dmac" \
+				  "${mz_args[@]}"
 }
 
 stop_traffic()
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_flower.sh b/tools/testing/selftests/net/forwarding/mirror_gre_flower.sh
index 09389f3b9369..6efdd944f59f 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_flower.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_flower.sh
@@ -64,12 +64,21 @@ cleanup()
 
 test_span_gre_dir_acl()
 {
-	test_span_gre_dir_ips "$@" 192.0.2.3 192.0.2.4
+	local tundev=$1; shift
+	local direction=$1; shift
+	local forward_type=$1; shift
+	local backward_type=$1; shift
+
+	test_span_gre_dir_ips "$tundev" "$direction" "$forward_type" \
+			      "$backward_type" 192.0.2.3 192.0.2.4
 }
 
 fail_test_span_gre_dir_acl()
 {
-	fail_test_span_gre_dir_ips "$@" 192.0.2.3 192.0.2.4
+	local tundev=$1; shift
+	local direction=$1; shift
+
+	fail_test_span_gre_dir_ips "$tundev" "$direction" 192.0.2.3 192.0.2.4
 }
 
 full_test_span_gre_dir_acl()
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
index 0c36546e131e..da2fd028e2e3 100644
--- a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
@@ -5,22 +5,34 @@ source "$net_forwarding_dir/mirror_lib.sh"
 quick_test_span_gre_dir_ips()
 {
 	local tundev=$1; shift
+	local direction=$1; shift
+	local ip1=$1; shift
+	local ip2=$1; shift
 
-	do_test_span_dir_ips 10 h3-$tundev "$@"
+	do_test_span_dir_ips 10 h3-$tundev "$direction" "$ip1" "$ip2"
 }
 
 fail_test_span_gre_dir_ips()
 {
 	local tundev=$1; shift
+	local direction=$1; shift
+	local ip1=$1; shift
+	local ip2=$1; shift
 
-	do_test_span_dir_ips 0 h3-$tundev "$@"
+	do_test_span_dir_ips 0 h3-$tundev "$direction" "$ip1" "$ip2"
 }
 
 test_span_gre_dir_ips()
 {
 	local tundev=$1; shift
+	local direction=$1; shift
+	local forward_type=$1; shift
+	local backward_type=$1; shift
+	local ip1=$1; shift
+	local ip2=$1; shift
 
-	test_span_dir_ips h3-$tundev "$@"
+	test_span_dir_ips h3-$tundev "$direction" "$forward_type" \
+			  "$backward_type" "$ip1" "$ip2"
 }
 
 full_test_span_gre_dir_ips()
@@ -74,27 +86,55 @@ full_test_span_gre_dir_vlan_ips()
 
 quick_test_span_gre_dir()
 {
-	quick_test_span_gre_dir_ips "$@" 192.0.2.1 192.0.2.2
+	local tundev=$1; shift
+	local direction=$1; shift
+
+	quick_test_span_gre_dir_ips "$tundev" "$direction" 192.0.2.1 192.0.2.2
 }
 
 fail_test_span_gre_dir()
 {
-	fail_test_span_gre_dir_ips "$@" 192.0.2.1 192.0.2.2
+	local tundev=$1; shift
+	local direction=$1; shift
+
+	fail_test_span_gre_dir_ips "$tundev" "$direction" 192.0.2.1 192.0.2.2
 }
 
 test_span_gre_dir()
 {
-	test_span_gre_dir_ips "$@" 192.0.2.1 192.0.2.2
+	local tundev=$1; shift
+	local direction=$1; shift
+	local forward_type=$1; shift
+	local backward_type=$1; shift
+
+	test_span_gre_dir_ips "$tundev" "$direction" "$forward_type" \
+			      "$backward_type" 192.0.2.1 192.0.2.2
 }
 
 full_test_span_gre_dir()
 {
-	full_test_span_gre_dir_ips "$@" 192.0.2.1 192.0.2.2
+	local tundev=$1; shift
+	local direction=$1; shift
+	local forward_type=$1; shift
+	local backward_type=$1; shift
+	local what=$1; shift
+
+	full_test_span_gre_dir_ips "$tundev" "$direction" "$forward_type" \
+				   "$backward_type" "$what" 192.0.2.1 192.0.2.2
 }
 
 full_test_span_gre_dir_vlan()
 {
-	full_test_span_gre_dir_vlan_ips "$@" 192.0.2.1 192.0.2.2
+	local tundev=$1; shift
+	local direction=$1; shift
+	local vlan_match=$1; shift
+	local forward_type=$1; shift
+	local backward_type=$1; shift
+	local what=$1; shift
+
+	full_test_span_gre_dir_vlan_ips "$tundev" "$direction" "$vlan_match" \
+					"$forward_type" "$backward_type" \
+					"$what" 192.0.2.1 192.0.2.2
 }
 
 full_test_span_gre_stp_ips()
@@ -126,5 +166,10 @@ full_test_span_gre_stp_ips()
 
 full_test_span_gre_stp()
 {
-	full_test_span_gre_stp_ips "$@" 192.0.2.1 192.0.2.2
+	local tundev=$1; shift
+	local nbpdev=$1; shift
+	local what=$1; shift
+
+	full_test_span_gre_stp_ips "$tundev" "$nbpdev" "$what" \
+				   192.0.2.1 192.0.2.2
 }
diff --git a/tools/testing/selftests/net/forwarding/mirror_lib.sh b/tools/testing/selftests/net/forwarding/mirror_lib.sh
index 3e8ebeff3019..b5b0a6545d75 100644
--- a/tools/testing/selftests/net/forwarding/mirror_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_lib.sh
@@ -71,12 +71,22 @@ do_test_span_dir_ips()
 
 quick_test_span_dir_ips()
 {
-	do_test_span_dir_ips 10 "$@"
+	local dev=$1; shift
+	local direction=$1; shift
+	local ip1=$1; shift
+	local ip2=$1; shift
+
+	do_test_span_dir_ips 10 "$dev" "$direction" "$ip1" "$ip2"
 }
 
 fail_test_span_dir_ips()
 {
-	do_test_span_dir_ips 0 "$@"
+	local dev=$1; shift
+	local direction=$1; shift
+	local ip1=$1; shift
+	local ip2=$1; shift
+
+	do_test_span_dir_ips 0 "$dev" "$direction" "$ip1" "$ip2"
 }
 
 test_span_dir_ips()
@@ -101,12 +111,21 @@ test_span_dir_ips()
 
 fail_test_span_dir()
 {
-	fail_test_span_dir_ips "$@" 192.0.2.1 192.0.2.2
+	local dev=$1; shift
+	local direction=$1; shift
+
+	fail_test_span_dir_ips "$dev" "$direction" 192.0.2.1 192.0.2.2
 }
 
 test_span_dir()
 {
-	test_span_dir_ips "$@" 192.0.2.1 192.0.2.2
+	local dev=$1; shift
+	local direction=$1; shift
+	local forward_type=$1; shift
+	local backward_type=$1; shift
+
+	test_span_dir_ips "$dev" "$direction" "$forward_type" "$backward_type" \
+			  192.0.2.1 192.0.2.2
 }
 
 do_test_span_vlan_dir_ips()
@@ -130,20 +149,48 @@ do_test_span_vlan_dir_ips()
 
 quick_test_span_vlan_dir_ips()
 {
-	do_test_span_vlan_dir_ips 10 "$@"
+	local dev=$1; shift
+	local vid=$1; shift
+	local direction=$1; shift
+	local ul_proto=$1; shift
+	local ip1=$1; shift
+	local ip2=$1; shift
+
+	do_test_span_vlan_dir_ips 10 "$dev" "$vid" "$direction" "$ul_proto" \
+				  "$ip1" "$ip2"
 }
 
 fail_test_span_vlan_dir_ips()
 {
-	do_test_span_vlan_dir_ips 0 "$@"
+	local dev=$1; shift
+	local vid=$1; shift
+	local direction=$1; shift
+	local ul_proto=$1; shift
+	local ip1=$1; shift
+	local ip2=$1; shift
+
+	do_test_span_vlan_dir_ips 0 "$dev" "$vid" "$direction" "$ul_proto" \
+				  "$ip1" "$ip2"
 }
 
 quick_test_span_vlan_dir()
 {
-	quick_test_span_vlan_dir_ips "$@" 192.0.2.1 192.0.2.2
+	local dev=$1; shift
+	local vid=$1; shift
+	local direction=$1; shift
+	local ul_proto=$1; shift
+
+	quick_test_span_vlan_dir_ips "$dev" "$vid" "$direction" "$ul_proto" \
+				     192.0.2.1 192.0.2.2
 }
 
 fail_test_span_vlan_dir()
 {
-	fail_test_span_vlan_dir_ips "$@" 192.0.2.1 192.0.2.2
+	local dev=$1; shift
+	local vid=$1; shift
+	local direction=$1; shift
+	local ul_proto=$1; shift
+
+	fail_test_span_vlan_dir_ips "$dev" "$vid" "$direction" "$ul_proto" \
+				    192.0.2.1 192.0.2.2
 }
-- 
2.45.0


