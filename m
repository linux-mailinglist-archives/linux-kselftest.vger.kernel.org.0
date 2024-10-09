Return-Path: <linux-kselftest+bounces-19344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE289969A5
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 14:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4811F23B28
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 12:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85030192D80;
	Wed,  9 Oct 2024 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aLK7JcAb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68CA192B96;
	Wed,  9 Oct 2024 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475817; cv=fail; b=cPAYMFNvVWMFud8ii537msLGCKGv5m7yz4mEfuVQAT3l9YX0b4k29FXay20mBq5QvjUaDFMqgNQm5ln6m/uVTXOggsmm+dmtMCSFUosUpFQDKVhEHWfHwi0QiHvib1JR1bsmM7AFHxwv68NBufOUH66hV7JMKlJyGB5llWQQ2P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475817; c=relaxed/simple;
	bh=QmP4JnLTev14VFwGS4zTXKTeNR1iLxBEnCTfB5mvUkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjeGOaPMJOsTSt9up4dOEOSJWyz06BnUjzEgnj87ux2MQ5RYFZLZAw13xLxXTnGklkKRzYA32J3b6+GISxkogyTOxurbKHyGWJ3UXHAdx1TeZO/qDVDHBuolvTPLBojOCansuk2G0THkSUhLzMTm9oP9K4QoBuL/EspZGPro2K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aLK7JcAb; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaE4Ba0GaZMkCBiNQSVUVlRzDDR0kZsuDL2zeL52WSZcexmPlBK5oHqw4BA8Bx+JcIU0k6os3KsxA5pf9maupanN7vwjk0onEENQtbqTRfUFaJXIvUgxAyGi9mVEmv7WYk7H0diifE3lJZCt1y7hUOJtxIy0nP4hjLJiHRUufNoElHk87f15NWHFw5tcl64VHp/LzMK99yB14xV2xMrHFVQjRJCyF1jyPw37y1an3ZeQWVkvnCc3sJxcKPULmcFTZoyNuwK9+hIQYE0D/QkDT/tI6Phy4NU4ga+WwJSQp6RWaxFGYIrH0syYNF4+j/Jxp5dFMvDxHT2Wv67HKATHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE4tiSQAFHiQC4a395xfqzFWq0VymUTdBw+LHLe9G9o=;
 b=FNF4ZWuncOtugKNvhcSzOMikKeXXZOjm6BN7bSZU/mcWQnZpAf4RLcp8TRHNrvXRJmD3YAgG7OWJffKUrRaH2Qu0yC5OIqoYfWtyRww5hs95jwof/mNtqzztFCOceh4F6WdBIfi+BAX5zjfKNgRv1N25xj8WvzCjkW7ZE0P1OJDeh8NPEs/0F6ihjzPu+j43FuK0cjOHHlaAwh5pllW/K0FnsKaBJlfBLS4/Gg6ZOyIoHLUcstw8sBm+yxmpJTcBtFGUDNqNmKDpnQTVOMSBDVobvsfXsAX39VTLtH65NHRNfo+C6PwcbpSXCY1extmDktyhG8HR2UIzePF5Zt+qqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE4tiSQAFHiQC4a395xfqzFWq0VymUTdBw+LHLe9G9o=;
 b=aLK7JcAbGQgXZOzOLmOJn8SMVV5olyGGc3HdaDF6HkFkkHu70S4cy2WsziDMjmMoJZFaSsIhqqId9rC+zwy0QOL5S379FylOA1eGyCv0BiFSdMxZYC2V8V2dZimwc+12X3usnkb2jO7espjPT3eHao+xMlcBQOykhSzl4LEKp5oGKYl97PTijJYFO9dXfsbOkZ5+qMTKVOWDFTChKavMUHdhd7/i67vH2nj6jJUm7huYfmZ/VBiA55gb4AO3TosbncS+5M2LyV9BQZ7aIVTeTl2STLYQLP/SYyLOTA0goQrsmeo/6BnCU/hQMBhvwRu5lvuzevZQEkQTPpSWIqILiA==
Received: from CH0PR03CA0449.namprd03.prod.outlook.com (2603:10b6:610:10e::25)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 12:10:07 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::f3) by CH0PR03CA0449.outlook.office365.com
 (2603:10b6:610:10e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 12:10:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 12:10:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:09:57 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:09:51 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 06/10] selftests: ETS: Use defer for test cleanup
Date: Wed, 9 Oct 2024 14:06:24 +0200
Message-ID: <d0ed0c88e3b5bd479fbc1592352cf029ed1f18bf.1728473602.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728473602.git.petrm@nvidia.com>
References: <cover.1728473602.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 41399f9b-b815-4f5f-88a3-08dce85b50e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?trvOJDeecgIgGA4btrKqfj6Z2L8GuknJuKyfjBYJ0ZvWhohFSoukW0xVv9Y/?=
 =?us-ascii?Q?I8GFPiIJLiPVg2j6vEreAh/g6Lhyw+uVnC62f08OTGmrkx8vish2FXit+xMq?=
 =?us-ascii?Q?zajDjS0+TUvWSwXPGkDKGLgT7XNKj9U3XEjYSwEjzyAuO2jIvYE6AgV+DhQr?=
 =?us-ascii?Q?ZLZbR3XNbe27evzvGCiH8udKCYax5uA++ZsLFaCtpZCYc5G7lN+tGQeqkNy5?=
 =?us-ascii?Q?44dis4H0dBx/+exhe9VWUz+98ITJQ9zD9ADLAJUE+e/Ag6s829Hm5xyapI57?=
 =?us-ascii?Q?l4akyy3gCRHcGRRLilty8hjaaRDebaG4Q9SqzTpvxRng+bXLwrLSPouvGEwT?=
 =?us-ascii?Q?U/ldu3hQTQd18SoNrLrM8TZ+yHmQlWC53RahWJyC+Bih+Xg41+ggwlxbg0N6?=
 =?us-ascii?Q?3bb3nZ5Ay8WY7CsYlCbP2Cn8vjVpQ6uwcWJmviWjU0EALnw80ul71X7Y/48c?=
 =?us-ascii?Q?IA+MsombJ1IFArg536uWPVZiTWYgO6PfjDiJ46RySbdfVS7TJseBNJvGLkMy?=
 =?us-ascii?Q?p1GqhQSFrn/4nSSLNzz7O7dRF/lg01RxvQwjJenjQDYT19MlH0y0f+fZrvFW?=
 =?us-ascii?Q?sPcwXX/eM4Tvz1qb6cXoVPjrS9dQ0jIp7qfb4dqiUSKSaB1AcXQPTpl0VQQw?=
 =?us-ascii?Q?Ne9DZ39aGmnZzBulztxDJh+VMeEiO57QyIN0f1s2moiLbX+JP/mgwyQOn3Jh?=
 =?us-ascii?Q?nut4FaN7P+8RfyFdbSp1qjmOtI7iU1jSSCOob18hZc3bLa3Eh+v7ZNzTJXoL?=
 =?us-ascii?Q?mGVpvowaPhkWN+TRBCrH1uvfSVxBiJYGbY0kOWLKFANN2mJxTUHSP+k7d18m?=
 =?us-ascii?Q?gerL1IUdx0BCL2KAw/PZEwNm5j6aAIoAdD7Tfiw9ulB+zsE+T95HO38cLjZ+?=
 =?us-ascii?Q?FDFFGeSjii4o56cIdYeoguSrcUSYN6FimN4VoUsw7nSJ0X0wG+PmUq3e/V81?=
 =?us-ascii?Q?qNUTLgBQbz62ezWmKZyhLrDs2lYOkVwDAttTjzlIIyC5ohd1ZA8B8Odd7qVK?=
 =?us-ascii?Q?MFTdvacugoGEFjWvVehc3tl0lTeedrRq8saRyXc9qmw8CpnIHKTxPhMK3NBb?=
 =?us-ascii?Q?UMitXyfaz1ioIEQr4ckFfLUuAQ5LARG77kyPucG2ZVF6ma0nzemhQ2dxylT9?=
 =?us-ascii?Q?cRyTCGJDwn2Ms532y6hIqj85nDF5PFtYl6He2GqwuAT74la9ffD5gjJHOolH?=
 =?us-ascii?Q?3r2cE8QO0Q1emQzyWvQiUHfEM6OjyRxIlKD9/TiPH+hMN7P8KJG1glxX9FnZ?=
 =?us-ascii?Q?WYsccLJeuoHfqZyBil7MkW1n/3y7PmERvjHjHhKo3ddebEwVbwK4535YSbzX?=
 =?us-ascii?Q?5MySVQdCQr13auerXVaxW+q5Qyh9j8ARto/KAZs+27mJqV02TNS7rlwwsxKZ?=
 =?us-ascii?Q?XVk8XYc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:10:07.5118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41399f9b-b815-4f5f-88a3-08dce85b50e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

Use the defer framework to schedule cleanups as soon as the command is
executed.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/sch_ets.sh    | 26 +++---
 .../selftests/net/forwarding/sch_ets.sh       |  7 +-
 .../selftests/net/forwarding/sch_ets_core.sh  | 81 +++++++------------
 .../selftests/net/forwarding/sch_ets_tests.sh | 14 ++--
 4 files changed, 50 insertions(+), 78 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_ets.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_ets.sh
index 139175fd03e7..4aaceb6b2b60 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_ets.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_ets.sh
@@ -21,6 +21,7 @@ switch_create()
 	# Create a bottleneck so that the DWRR process can kick in.
 	tc qdisc replace dev $swp2 root handle 3: tbf rate 1gbit \
 		burst 128K limit 1G
+	defer tc qdisc del dev $swp2 root handle 3:
 
 	ets_switch_create
 
@@ -30,16 +31,27 @@ switch_create()
 	# for the DWRR process.
 	devlink_port_pool_th_save $swp1 0
 	devlink_port_pool_th_set $swp1 0 12
+	defer devlink_port_pool_th_restore $swp1 0
+
 	devlink_tc_bind_pool_th_save $swp1 0 ingress
 	devlink_tc_bind_pool_th_set $swp1 0 ingress 0 12
+	defer devlink_tc_bind_pool_th_restore $swp1 0 ingress
+
 	devlink_port_pool_th_save $swp2 4
 	devlink_port_pool_th_set $swp2 4 12
+	defer devlink_port_pool_th_restore $swp2 4
+
 	devlink_tc_bind_pool_th_save $swp2 7 egress
 	devlink_tc_bind_pool_th_set $swp2 7 egress 4 5
+	defer devlink_tc_bind_pool_th_restore $swp2 7 egress
+
 	devlink_tc_bind_pool_th_save $swp2 6 egress
 	devlink_tc_bind_pool_th_set $swp2 6 egress 4 5
+	defer devlink_tc_bind_pool_th_restore $swp2 6 egress
+
 	devlink_tc_bind_pool_th_save $swp2 5 egress
 	devlink_tc_bind_pool_th_set $swp2 5 egress 4 5
+	defer devlink_tc_bind_pool_th_restore $swp2 5 egress
 
 	# Note: sch_ets_core.sh uses VLAN ingress-qos-map to assign packet
 	# priorities at $swp1 based on their 802.1p headers. ingress-qos-map is
@@ -47,20 +59,6 @@ switch_create()
 	# 1:1, which is the mapping currently hard-coded by the driver.
 }
 
-switch_destroy()
-{
-	devlink_tc_bind_pool_th_restore $swp2 5 egress
-	devlink_tc_bind_pool_th_restore $swp2 6 egress
-	devlink_tc_bind_pool_th_restore $swp2 7 egress
-	devlink_port_pool_th_restore $swp2 4
-	devlink_tc_bind_pool_th_restore $swp1 0 ingress
-	devlink_port_pool_th_restore $swp1 0
-
-	ets_switch_destroy
-
-	tc qdisc del dev $swp2 root handle 3:
-}
-
 # Callback from sch_ets_tests.sh
 collect_stats()
 {
diff --git a/tools/testing/selftests/net/forwarding/sch_ets.sh b/tools/testing/selftests/net/forwarding/sch_ets.sh
index e60c8b4818cc..1f6f53e284b5 100755
--- a/tools/testing/selftests/net/forwarding/sch_ets.sh
+++ b/tools/testing/selftests/net/forwarding/sch_ets.sh
@@ -24,15 +24,10 @@ switch_create()
 	# Create a bottleneck so that the DWRR process can kick in.
 	tc qdisc add dev $swp2 root handle 1: tbf \
 	   rate 1Gbit burst 1Mbit latency 100ms
+	defer tc qdisc del dev $swp2 root
 	PARENT="parent 1:"
 }
 
-switch_destroy()
-{
-	ets_switch_destroy
-	tc qdisc del dev $swp2 root
-}
-
 # Callback from sch_ets_tests.sh
 collect_stats()
 {
diff --git a/tools/testing/selftests/net/forwarding/sch_ets_core.sh b/tools/testing/selftests/net/forwarding/sch_ets_core.sh
index f906fcc66572..8f9922c695b0 100644
--- a/tools/testing/selftests/net/forwarding/sch_ets_core.sh
+++ b/tools/testing/selftests/net/forwarding/sch_ets_core.sh
@@ -166,89 +166,78 @@ h1_create()
 	local i;
 
 	simple_if_init $h1
+	defer simple_if_fini $h1
+
 	mtu_set $h1 9900
+	defer mtu_restore $h1
+
 	for i in {0..2}; do
 		vlan_create $h1 1$i v$h1 $(sip $i)/28
+		defer vlan_destroy $h1 1$i
 		ip link set dev $h1.1$i type vlan egress 0:$i
 	done
 }
 
-h1_destroy()
-{
-	local i
-
-	for i in {0..2}; do
-		vlan_destroy $h1 1$i
-	done
-	mtu_restore $h1
-	simple_if_fini $h1
-}
-
 h2_create()
 {
 	local i
 
 	simple_if_init $h2
+	defer simple_if_fini $h2
+
 	mtu_set $h2 9900
+	defer mtu_restore $h2
+
 	for i in {0..2}; do
 		vlan_create $h2 1$i v$h2 $(dip $i)/28
+		defer vlan_destroy $h2 1$i
 	done
 }
 
-h2_destroy()
-{
-	local i
-
-	for i in {0..2}; do
-		vlan_destroy $h2 1$i
-	done
-	mtu_restore $h2
-	simple_if_fini $h2
-}
-
 ets_switch_create()
 {
 	local i
 
 	ip link set dev $swp1 up
+	defer ip link set dev $swp1 down
+
 	mtu_set $swp1 9900
+	defer mtu_restore $swp1
 
 	ip link set dev $swp2 up
+	defer ip link set dev $swp2 down
+
 	mtu_set $swp2 9900
+	defer mtu_restore $swp2
 
 	for i in {0..2}; do
 		vlan_create $swp1 1$i
+		defer vlan_destroy $swp1 1$i
 		ip link set dev $swp1.1$i type vlan ingress 0:0 1:1 2:2
 
 		vlan_create $swp2 1$i
+		defer vlan_destroy $swp2 1$i
 
 		ip link add dev br1$i type bridge
+		defer ip link del dev br1$i
+
 		ip link set dev $swp1.1$i master br1$i
+		defer ip link set dev $swp1.1$i nomaster
+
 		ip link set dev $swp2.1$i master br1$i
+		defer ip link set dev $swp2.1$i nomaster
 
 		ip link set dev br1$i up
+		defer ip link set dev br1$i down
+
 		ip link set dev $swp1.1$i up
+		defer ip link set dev $swp1.1$i down
+
 		ip link set dev $swp2.1$i up
+		defer ip link set dev $swp2.1$i down
 	done
-}
 
-ets_switch_destroy()
-{
-	local i
-
-	ets_delete_qdisc
-
-	for i in {0..2}; do
-		ip link del dev br1$i
-		vlan_destroy $swp2 1$i
-		vlan_destroy $swp1 1$i
-	done
-
-	mtu_restore $swp2
-	ip link set dev $swp2 down
-
-	mtu_restore $swp1
-	ip link set dev $swp1 down
+	defer ets_delete_qdisc
 }
 
 setup_prepare()
@@ -263,23 +252,13 @@ setup_prepare()
 	hut=$h2
 
 	vrf_prepare
+	defer vrf_cleanup
 
 	h1_create
 	h2_create
 	switch_create
 }
 
-cleanup()
-{
-	pre_cleanup
-
-	switch_destroy
-	h2_destroy
-	h1_destroy
-
-	vrf_cleanup
-}
-
 ping_ipv4()
 {
 	ping_test $h1.10 $(dip 0) " vlan 10"
diff --git a/tools/testing/selftests/net/forwarding/sch_ets_tests.sh b/tools/testing/selftests/net/forwarding/sch_ets_tests.sh
index f9d26a7911bb..08240d3e3c87 100644
--- a/tools/testing/selftests/net/forwarding/sch_ets_tests.sh
+++ b/tools/testing/selftests/net/forwarding/sch_ets_tests.sh
@@ -90,6 +90,7 @@ __ets_dwrr_test()
 
 	for stream in ${streams[@]}; do
 		ets_start_traffic $stream
+		defer stop_traffic $!
 	done
 
 	sleep 10
@@ -120,25 +121,24 @@ __ets_dwrr_test()
 				       ${d[0]} ${d[$i]}
 		fi
 	done
-
-	for stream in ${streams[@]}; do
-		stop_traffic
-	done
 }
 
 ets_dwrr_test_012()
 {
-	__ets_dwrr_test 0 1 2
+	in_defer_scope \
+		__ets_dwrr_test 0 1 2
 }
 
 ets_dwrr_test_01()
 {
-	__ets_dwrr_test 0 1
+	in_defer_scope \
+		__ets_dwrr_test 0 1
 }
 
 ets_dwrr_test_12()
 {
-	__ets_dwrr_test 1 2
+	in_defer_scope \
+		__ets_dwrr_test 1 2
 }
 
 ets_qdisc_setup()
-- 
2.45.0


