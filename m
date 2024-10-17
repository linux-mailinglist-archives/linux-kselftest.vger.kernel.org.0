Return-Path: <linux-kselftest+bounces-19945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 873C89A1EE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 11:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AA81C211A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EEC1DB956;
	Thu, 17 Oct 2024 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gz+UlybX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490F81D959B;
	Thu, 17 Oct 2024 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158481; cv=fail; b=idDkBI9vHpKTruOBRyFGruq1V8IxKBaEOSXWluDKuR5Qwmh5xbqhJZzEU5AzzwdTrdhir1u6F1lixUCTbf9r1gJHGteVJ6/TSatnbFR9wwlbmT4Z464lTkOvQ24NA0+oliaTrPQxnivy7Kzx0IK/cv+YOkFrFtufl05IRqek4xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158481; c=relaxed/simple;
	bh=rpy+x0vc78lZ4LbaVLMTj0KPKBxawl7m5ERl5vdien8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0YMpqt9tUcDqrzuI93NOE9UQlSDCpzs7qY+g+XFJuai/C2nXHtoxrOdPbpdX8e7xjmdjGdoPbTD9lAhQIX9QuBbA2RMYyqzqNBOsLtA42sPL/dLA+qK6Hl8dtzPIPAEPnz/oISmpUpD2NXljIqm9pdWol4j0qm3kPwV2HPUiXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gz+UlybX; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgeISKrVGKPoolxcEWEjdJ0PBz4i4EDGgssRWaG+DadonGGxABpyNm2oONrdO+VxVi/pVn3up8vNVU3PPHdkTWXl6zH9bxysUxs15vqJN4FypSk5KyPPVTEiu154wVo22NFLBqWtb0PpW8RdBEwoaontZuetxgw3QMfVLIV/03o4UoJk0idTDZ5+eWSh5aC53QXs5jX5u3LP2iTZliy+ket8cBxvw8hH+JNHfL1Hsr46NHsFuvyl6qxxu7WXs8h5yONr0cVBbq/EjjxXply6kTXGceDcxnHvrSfMcqTKZX3WKhDKJIuGosw6H09BZCHGYnFN8oLFEycGh36Ef0ij6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0UuiXORT+ug6c0oBl32NLkP0UqjlEWaC7OnNoaxuUE=;
 b=RoYSqZXcfF+MQcIPJzC6QdL/HI/qv/FLSH8/n5K23uFJMxUBB6hyzfFZX9Vj6RhUI8ga+b+e4lTygMDvjRda/BWrP275pgHv+caLbK3EShHReajRri5bTyLVwLsXoxra0mhjH+4UXugNJcio49Kb4+1QHU9zvW0d8hUjyQJii7kcTa7rURkukc4c5iV6/MXtCjg6El64buizToZ4izLkbNjkvzRs5/COZfpml0zb10+xFVLKhtEcqZ2ukhegVfOaGFcY34BK6xNG1tvg7ruIUCPpZNaGzCQ6iwNJmMRqW8NOo4Dy7PELMRecYNuqvl5TNy1stT9J3v2+Joa733qHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0UuiXORT+ug6c0oBl32NLkP0UqjlEWaC7OnNoaxuUE=;
 b=Gz+UlybXnw9ycCL4p16jkd0fwPUQVCtuNkacVN4vHtOquEzZU6usvBVoshqAVEzQU71sjsHsDfL0cIr07qo5fU3C8Pk53fsf9ScSmtyayoPuG4/0EfSCJLXTYWoOw74boC8Y/UxFfZlMgGtVow/Va9PXcI+mi23NEkI4wlfERau79czPzsnwL81HSliKwnvuB0bg3nmolGWbHeNhsOHfXDtU3f3nioSWNPWyXTjTdCxP/YlQSrWkKhnpA7ew0yaxsyZPODdgzYoG4ByTVIqlpCDjsAk19tI4xBQE921K2klzDbg49Q3fftsXCfalUR2th8HCvaIQ5DvCdRY/rACyIw==
Received: from SA9PR13CA0090.namprd13.prod.outlook.com (2603:10b6:806:23::35)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 09:47:53 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::42) by SA9PR13CA0090.outlook.office365.com
 (2603:10b6:806:23::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Thu, 17 Oct 2024 09:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 09:47:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:41 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:36 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, Willem de Bruijn <willemb@google.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 08/10] selftests: mlxsw: qos_ets_strict: Use defer for test cleanup
Date: Thu, 17 Oct 2024 11:45:50 +0200
Message-ID: <5a663c264a066846d1289c0c68df70afd6377d53.1729157566.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729157566.git.petrm@nvidia.com>
References: <cover.1729157566.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 1375f0f5-de93-4231-c799-08dcee90c4f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ubUfzfb/sCvbf0BOtn/som3U19WedIP3GRYKKXNKyj2fH5qIvlEhKUsY+Tia?=
 =?us-ascii?Q?I+Fb1S77++uCH7u4JGO+e+o+rsLe/tyQKtopNBNNNnGQg498BHBCcbeN1m8V?=
 =?us-ascii?Q?/SPgUk3pXunLyWH6h3hi01xa8w79w6fW8INcU1rj3DjJ6LhW5RnoPpucFQP8?=
 =?us-ascii?Q?9CeaXvMZ5H140QOYLvgL1v/MMIACwljSj0tzr+TaHEX9tYtMQ7wYQTorx05w?=
 =?us-ascii?Q?/LAGPhnC38vxUgI+aw19MA4OFw5cuxpLTqgNvugGf8kWm/o9N0Aav9ER95RZ?=
 =?us-ascii?Q?nbwbVJzTb3vEEnzmFlglkXegZaAdrohu3CbCeeQUUMfM0NNRpATHCmHyJwqy?=
 =?us-ascii?Q?1W6JpWKELV0Fjdb65YX85DoKK8Ot3y23punFF+4+k0yO6jRspssv30rkQXo1?=
 =?us-ascii?Q?6OGhV9GZwCm1s4yd8ifGSV987jEIIMEdhHOc/SsBuvAG/Pzu1BKdqKiqAKAQ?=
 =?us-ascii?Q?02cxWNQRrp0KIHr1HvYU7BbdpY1czS5U+KO6RJms0MFRl20Nq8QePweLcCEe?=
 =?us-ascii?Q?muefuf/O6hXzM1wN5euNsbrkLDc2FQ9EX+w4mxnlh7MfRerPYwPTHHjMjR2E?=
 =?us-ascii?Q?8JSYQbxGqAHMCjzxV8rwH9Up+twgaBIwLbxnnHi99XTvOmPCuk99IEELlTHE?=
 =?us-ascii?Q?t0vA9ksSAFUGSnpHj4XKsLdmHDyxCT3r9wJKBjEOSdoFAVoRl7mN+yuIo+Eb?=
 =?us-ascii?Q?twwayUGq2mFGn0nwYklgFt58oP64g0KGNzCAQ5AWztaA39PMpR2xw/2w00CF?=
 =?us-ascii?Q?4WiZSuwRYnT2u8irVYLTdkFWPA6YmNJoO1+gniKN5KYc9cmhTUEIrj+iMqN1?=
 =?us-ascii?Q?xqs7hxV8C6w3P7ybUxcrtkiws6BT8HA7Si0HMWtJgTi4Icwm/i+RCrD5azSq?=
 =?us-ascii?Q?eataddJVVnH3UU8zwRKAJWScTmcMKfAsI1X6ZuaE3NGwfse9P4ZRAG7heWz2?=
 =?us-ascii?Q?ZzPx5DmJGe9dnZJ137Snq4JmOFJSSyBj3VHQUkjZPRy/B3RDE2qubsIRcaJt?=
 =?us-ascii?Q?ZOQDUuxmdfPlBnTCwORE69P9/EJSokudKUvZuCrM1EXSwoIZ37rLJmZtD9n4?=
 =?us-ascii?Q?yqp40bKNDq0vYf/QI14zHWnbe71i1kGmsw2+EVMtiGYdEq1SvwUdKjgzgbdm?=
 =?us-ascii?Q?+Vtnq36LDZBcMemSIetTraz+kfW3rS3CDHtjWzGihiuCfxYozoe+gas/aWOB?=
 =?us-ascii?Q?oq2xVMHiIeLNNr/gnwuPnPHbLTlu3RizW6G2I5NhLRjK2+kqx9XkO1n5D39y?=
 =?us-ascii?Q?Jj7OHFwdIlciCwADCVXwPjxNaqkKm4JQC31A8lhetBYtTpqaRU6d2cvN+fMF?=
 =?us-ascii?Q?Du2oRXhmDLLQARjfs7RJOO9enyP6Wp8Ro4mlbGFGqhDNV4mw1E8AZE7tCcop?=
 =?us-ascii?Q?VjlhAG7UcwLolsVP8TV2F/1RzrGfgYdkaWahI8qKGu7/gfGsRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 09:47:52.5309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1375f0f5-de93-4231-c799-08dcee90c4f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897

Use the defer framework to schedule cleanups as soon as the command is
executed.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../drivers/net/mlxsw/qos_ets_strict.sh       | 167 +++++++++---------
 1 file changed, 85 insertions(+), 82 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh
index fee74f215cec..d5b6f2cc9a29 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh
@@ -58,65 +58,62 @@ source qos_lib.sh
 h1_create()
 {
 	simple_if_init $h1
+	defer simple_if_fini $h1
+
 	mtu_set $h1 10000
+	defer mtu_restore $h1
 
 	vlan_create $h1 111 v$h1 192.0.2.33/28
+	defer vlan_destroy $h1 111
 	ip link set dev $h1.111 type vlan egress-qos-map 0:1
 }
 
-h1_destroy()
-{
-	vlan_destroy $h1 111
-
-	mtu_restore $h1
-	simple_if_fini $h1
-}
-
 h2_create()
 {
 	simple_if_init $h2
+	defer simple_if_fini $h2
+
 	mtu_set $h2 10000
+	defer mtu_restore $h2
 
 	vlan_create $h2 222 v$h2 192.0.2.65/28
+	defer vlan_destroy $h2 222
 	ip link set dev $h2.222 type vlan egress-qos-map 0:2
 }
 
-h2_destroy()
-{
-	vlan_destroy $h2 222
-
-	mtu_restore $h2
-	simple_if_fini $h2
-}
-
 h3_create()
 {
 	simple_if_init $h3
+	defer simple_if_fini $h3
+
 	mtu_set $h3 10000
+	defer mtu_restore $h3
 
 	vlan_create $h3 111 v$h3 192.0.2.34/28
+	defer vlan_destroy $h3 111
+
 	vlan_create $h3 222 v$h3 192.0.2.66/28
-}
-
-h3_destroy()
-{
-	vlan_destroy $h3 222
-	vlan_destroy $h3 111
-
-	mtu_restore $h3
-	simple_if_fini $h3
+	defer vlan_destroy $h3 222
 }
 
 switch_create()
 {
 	ip link set dev $swp1 up
+	defer ip link set dev $swp1 down
+
 	mtu_set $swp1 10000
+	defer mtu_restore $swp1
 
 	ip link set dev $swp2 up
+	defer ip link set dev $swp2 down
+
 	mtu_set $swp2 10000
+	defer mtu_restore $swp2
 
 	# prio n -> TC n, strict scheduling
 	lldptool -T -i $swp3 -V ETS-CFG up2tc=0:0,1:1,2:2,3:3,4:4,5:5,6:6,7:7
+	defer lldptool -T -i $swp3 -V ETS-CFG up2tc=0:0,1:0,2:0,3:0,4:0,5:0,6:0,7:0
+
 	lldptool -T -i $swp3 -V ETS-CFG tsa=$(
 			)"0:strict,"$(
 			)"1:strict,"$(
@@ -129,85 +126,90 @@ switch_create()
 	sleep 1
 
 	ip link set dev $swp3 up
+	defer ip link set dev $swp3 down
+
 	mtu_set $swp3 10000
+	defer mtu_restore $swp3
+
 	tc qdisc replace dev $swp3 root handle 101: tbf rate 1gbit \
 		burst 128K limit 1G
+	defer tc qdisc del dev $swp3 root handle 101:
 
 	vlan_create $swp1 111
+	defer vlan_destroy $swp1 111
+
 	vlan_create $swp2 222
+	defer vlan_destroy $swp2 222
+
 	vlan_create $swp3 111
+	defer vlan_destroy $swp3 111
+
 	vlan_create $swp3 222
+	defer vlan_destroy $swp3 222
 
 	ip link add name br111 type bridge vlan_filtering 0
+	defer ip link del dev br111
 	ip link set dev br111 addrgenmode none
+
 	ip link set dev br111 up
+	defer ip link set dev br111 down
+
 	ip link set dev $swp1.111 master br111
+	defer ip link set dev $swp1.111 nomaster
+
 	ip link set dev $swp3.111 master br111
+	defer ip link set dev $swp3.111 nomaster
 
 	ip link add name br222 type bridge vlan_filtering 0
+	defer ip link del dev br222
 	ip link set dev br222 addrgenmode none
+
 	ip link set dev br222 up
+	defer ip link set dev br222 down
+
 	ip link set dev $swp2.222 master br222
+	defer ip link set dev $swp2.222 nomaster
+
 	ip link set dev $swp3.222 master br222
+	defer ip link set dev $swp3.222 nomaster
 
 	# Make sure that ingress quotas are smaller than egress so that there is
 	# room for both streams of traffic to be admitted to shared buffer.
 	devlink_pool_size_thtype_save 0
 	devlink_pool_size_thtype_set 0 dynamic 10000000
+	defer devlink_pool_size_thtype_restore 0
+
 	devlink_pool_size_thtype_save 4
 	devlink_pool_size_thtype_set 4 dynamic 10000000
+	defer devlink_pool_size_thtype_restore 4
 
 	devlink_port_pool_th_save $swp1 0
 	devlink_port_pool_th_set $swp1 0 6
+	defer devlink_port_pool_th_restore $swp1 0
+
 	devlink_tc_bind_pool_th_save $swp1 1 ingress
 	devlink_tc_bind_pool_th_set $swp1 1 ingress 0 6
+	defer devlink_tc_bind_pool_th_restore $swp1 1 ingress
 
 	devlink_port_pool_th_save $swp2 0
 	devlink_port_pool_th_set $swp2 0 6
+	defer devlink_port_pool_th_restore $swp2 0
+
 	devlink_tc_bind_pool_th_save $swp2 2 ingress
 	devlink_tc_bind_pool_th_set $swp2 2 ingress 0 6
+	defer devlink_tc_bind_pool_th_restore $swp2 2 ingress
 
 	devlink_tc_bind_pool_th_save $swp3 1 egress
 	devlink_tc_bind_pool_th_set $swp3 1 egress 4 7
+	defer devlink_tc_bind_pool_th_restore $swp3 1 egress
+
 	devlink_tc_bind_pool_th_save $swp3 2 egress
 	devlink_tc_bind_pool_th_set $swp3 2 egress 4 7
+	defer devlink_tc_bind_pool_th_restore $swp3 2 egress
+
 	devlink_port_pool_th_save $swp3 4
 	devlink_port_pool_th_set $swp3 4 7
-}
-
-switch_destroy()
-{
-	devlink_port_pool_th_restore $swp3 4
-	devlink_tc_bind_pool_th_restore $swp3 2 egress
-	devlink_tc_bind_pool_th_restore $swp3 1 egress
-
-	devlink_tc_bind_pool_th_restore $swp2 2 ingress
-	devlink_port_pool_th_restore $swp2 0
-
-	devlink_tc_bind_pool_th_restore $swp1 1 ingress
-	devlink_port_pool_th_restore $swp1 0
-
-	devlink_pool_size_thtype_restore 4
-	devlink_pool_size_thtype_restore 0
-
-	ip link del dev br222
-	ip link del dev br111
-
-	vlan_destroy $swp3 222
-	vlan_destroy $swp3 111
-	vlan_destroy $swp2 222
-	vlan_destroy $swp1 111
-
-	tc qdisc del dev $swp3 root handle 101:
-	mtu_restore $swp3
-	ip link set dev $swp3 down
-	lldptool -T -i $swp3 -V ETS-CFG up2tc=0:0,1:0,2:0,3:0,4:0,5:0,6:0,7:0
-
-	mtu_restore $swp2
-	ip link set dev $swp2 down
-
-	mtu_restore $swp1
-	ip link set dev $swp1 down
+	defer devlink_port_pool_th_restore $swp3 4
 }
 
 setup_prepare()
@@ -224,6 +226,7 @@ setup_prepare()
 	h3mac=$(mac_get $h3)
 
 	vrf_prepare
+	defer vrf_cleanup
 
 	h1_create
 	h2_create
@@ -231,18 +234,6 @@ setup_prepare()
 	switch_create
 }
 
-cleanup()
-{
-	pre_cleanup
-
-	switch_destroy
-	h3_destroy
-	h2_destroy
-	h1_destroy
-
-	vrf_cleanup
-}
-
 ping_ipv4()
 {
 	ping_test $h1 192.0.2.34 " from H1"
@@ -261,21 +252,38 @@ rel()
 	"
 }
 
+__run_hi_measure_rate()
+{
+	local what=$1; shift
+	local -a uc_rate
+
+	start_traffic $h2.222 192.0.2.65 192.0.2.66 $h3mac
+	defer stop_traffic $!
+
+	uc_rate=($(measure_rate $swp2 $h3 rx_octets_prio_2 "$what"))
+	check_err $? "Could not get high enough $what ingress rate"
+
+	echo ${uc_rate[@]}
+}
+
+run_hi_measure_rate()
+{
+	in_defer_scope __run_hi_measure_rate "$@"
+}
+
 test_ets_strict()
 {
 	RET=0
 
 	# Run high-prio traffic on its own.
-	start_traffic $h2.222 192.0.2.65 192.0.2.66 $h3mac
 	local -a rate_2
-	rate_2=($(measure_rate $swp2 $h3 rx_octets_prio_2 "prio 2"))
-	check_err $? "Could not get high enough prio-2 ingress rate"
+	rate_2=($(run_hi_measure_rate "prio 2"))
 	local rate_2_in=${rate_2[0]}
 	local rate_2_eg=${rate_2[1]}
-	stop_traffic # $h2.222
 
 	# Start low-prio stream.
 	start_traffic $h1.111 192.0.2.33 192.0.2.34 $h3mac
+	defer stop_traffic $!
 
 	local -a rate_1
 	rate_1=($(measure_rate $swp1 $h3 rx_octets_prio_1 "prio 1"))
@@ -290,14 +298,9 @@ test_ets_strict()
 	check_err $(bc <<< "$rel21 > 105")
 
 	# Start the high-prio stream--now both streams run.
-	start_traffic $h2.222 192.0.2.65 192.0.2.66 $h3mac
-	rate_3=($(measure_rate $swp2 $h3 rx_octets_prio_2 "prio 2 w/ 1"))
-	check_err $? "Could not get high enough prio-2 ingress rate with prio-1"
+	rate_3=($(run_hi_measure_rate "prio 2+1"))
 	local rate_3_in=${rate_3[0]}
 	local rate_3_eg=${rate_3[1]}
-	stop_traffic # $h2.222
-
-	stop_traffic # $h1.111
 
 	# High-prio should have about the same throughput whether or not
 	# low-prio is in the system.
-- 
2.45.0


