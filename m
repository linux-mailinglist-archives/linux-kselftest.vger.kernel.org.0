Return-Path: <linux-kselftest+bounces-42396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D81BA0EAB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E5738241C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CD3314A6E;
	Thu, 25 Sep 2025 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qtbGECtx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F43148A3;
	Thu, 25 Sep 2025 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821665; cv=fail; b=ftAokVGM6AdB6bBbmdHrEZXOnzPgHfDJ1TIEnN/gqbuvXLT5exVdGXUr8FzgCSa1G63gg+ORV/ONhBxAh+BZFVJ92z+HFocAEZ8CCDzOmybueGVEpmWCKYpUKXcY2Rt48XlU7jLPXaFdNlWnpQphEKG/kGDsNdU6Vk8KohIEG8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821665; c=relaxed/simple;
	bh=Y63ILqMN8bCFl5eFIIDWV8efaVo67niZT8zp1cG3jiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLHfpC/WW72Rk8r8coSoMX9mZ607FtJdiPyWbDFuO8wpsA62cnCWCaqx/p1QUeQ0GYe9pdE50HADExPNMcxUSEts2kBfeN34sNKS6ymkAyEmOTrTUsHoJ/DddnTDB1xOnXUS9cSELn4BACmBZrx6D4S/q29yW4K24ErcVOnYm6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qtbGECtx; arc=fail smtp.client-ip=52.101.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEBT5Gdr42NG9vUU7uOBSDEzAyHQZkBy9UI08J7x3mb6kR5AChmg7KYCzpnKWZybbwH+0oY/YYebwsK9apFybR/Wyne25ITh/mfxzqXCuVd2L1nPlPLIq0AxS2fC79neX1hsvhk6FJmkqsQ+EKRjVxz3pllRNTj605dbOuf5jojDNdE+gTaS2DfgcDL6KddPz62IE7aDPBpwFIU0G5uAn4fxYzvAnmhCLXCM+lfjqG0wGbrTKDUa1zfzSMlCXzdylsZGHn9qOLmtFVQEr6U+EInmIcy8T6p8ewXAwhRpP60XG3Q6kXH57JYfHFNruj8DfBAGJlfhsHmAhFLnP6Tgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O33iMKUV5/dHNxxJbpjQl1tv3s8mUVHUFWfu1WeU1Ek=;
 b=bUDQXrGzqG2pzbtkWG34ohUtRcrqXqnAp09tW//o+XSyosfWkvNGMQpVqtxpfuxrar6szCZHcYlr3LoxJ5kHcygVA2MSNP4aKCCrELKwhdNuBad1MM4vDCk8AFRcDKlrkw/KkawJ+C8p3bxbeb2e0H10Cv3YMFGajS8ZsnGRCFakaG7uV0fBhsXHcBhhT0tFmm0+4OdvtY9DvN/SJ3+Bng9VQEsxMuRgKvPEv0bbHPIeJgsr5tJv3RzMJ5lbPLK8orpMeIohwXRsTycOOFyQepIYLK8qGdgLxPMGDzbJDpHWJpicmQb53VRtHPbJleWhQmyBm/GQ41+DmTTBnzqtNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O33iMKUV5/dHNxxJbpjQl1tv3s8mUVHUFWfu1WeU1Ek=;
 b=qtbGECtxWSjdmVe8kGOBmDmYjlBDOP5tBrTw9mOgQv1ePA3SGUozgG1QBeKtJxNlmKYPOY/nenXkDX5vocF3ntqB94UV4yd8+uOIkwkgmk4p0VxYpphK4cJRk6NcuykB8ARJ6JhYKphGLwQtHbmKCFVXULn69dOCe0jGXE57um6zvykUOxOwxhhoPe1UYkXhDadejZIYTAiCO9nfpPcW9YdpBNXVaQlnATR9wJn4g/8yGB/+YtqHPGc4jquAtUUmKJTwdazYBkH/IZw/eXLOaOZZwYKpk7+TtlFW9i0SYKV3EG9NSMekT62TqW7Hl9/2ETHfrMmAM9AOdPi4FiXYIg==
Received: from BN9PR03CA0152.namprd03.prod.outlook.com (2603:10b6:408:f4::7)
 by SJ5PPFFA661D690.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 17:34:15 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::82) by BN9PR03CA0152.outlook.office365.com
 (2603:10b6:408:f4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 17:34:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 17:34:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 25 Sep
 2025 10:34:00 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 10:33:52 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>,
	"Shuah Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 06/13] selftests: net: lib: Rename ip_addr_add() to adf_*
Date: Thu, 25 Sep 2025 19:31:49 +0200
Message-ID: <706327a5db660c7f18ba9fbfba7ce913da065e3e.1758821127.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758821127.git.petrm@nvidia.com>
References: <cover.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|SJ5PPFFA661D690:EE_
X-MS-Office365-Filtering-Correlation-Id: 729b05b1-0c30-4707-dfa0-08ddfc59bf2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M/OXDAnNUaIU+uXT/qrspx1it47A8IBA6R/2gvVf/OTowioAO/3bGPdLejJN?=
 =?us-ascii?Q?Qg6DJteb+zN3ozd59EnZifMn6cslzoXMSnJa2uv9O/ODeguLBJO4cRac0KRy?=
 =?us-ascii?Q?+mYnlf9Qh47FeJOx/5/Eg7vwI0zVfFOylW3yTl9hEaogp0FMwPybABeVAlO4?=
 =?us-ascii?Q?qkxT9gdy+fe8HvgkHP0vVcWJEjIjNmc/FmS0qLADMAKqhU5bU9t7NjfqWky7?=
 =?us-ascii?Q?M9gLNB5CsCOo1wA8YVOFAndTilTw64b+zfnBTvIB5e2h3xNcS/TtJz1Gu+Kk?=
 =?us-ascii?Q?LGB/rycwkCHy1DacIouMtw3b2tuGoGpNYiGnEZsJ1FzJ0TwYx0HXAsTp+G4x?=
 =?us-ascii?Q?44v6UvmXsam2jawOrPnhsPwFyySH+mu3yVB8ixCuulUkKNYI1LNEkiDyNZY4?=
 =?us-ascii?Q?+0qhguAMneybADcjr8kHBuJZ9t6XOl513EDP92B+iOUW/rUtNbL/cez62MAb?=
 =?us-ascii?Q?8orkk7d4KbAB14EF07KIWV380xV/qb/3yn/9ED1g6LPgLmf4A9/fVRXRtCOg?=
 =?us-ascii?Q?bG3Bz7NdP9aXOI8SLR7OU8MmW60V7Qjg0r88b/g6nDDTnbdE/pW3+ZvmlR0H?=
 =?us-ascii?Q?3Mt8ieEmHa9yfv3lLx3/HAfbbqvsGHdbNY99VCAXZ8a3OZx8dJDf5hzfO2te?=
 =?us-ascii?Q?7BdZBO2Jub8qqdzXsZi11zh4soB/+ozgrbwd66OxLSX6j2qyZZe/VwSmiJ9e?=
 =?us-ascii?Q?GvPxqaASBpjjMEVt9xvTc5o7zO6QIkaZL/mGFXYy13UsvkrwDAuN4PiMqBMs?=
 =?us-ascii?Q?psSFumqeT2Jv0yJ6GDPipog8t0LYyH84bkLZF0URwcw05SQVrWwKtC2mYZmK?=
 =?us-ascii?Q?g5EROALhjGT+3QTpdNgG6So8TYsXoNFVcLarmVPVy4jCu1MKg75UdKbNB8/7?=
 =?us-ascii?Q?POg7rOLUmEkz3aBjeqw68f+NdWj08BN6m7mqmDMiFM8Z6mv4sIGjxxIS64Ri?=
 =?us-ascii?Q?CazDv4pC9Jb17242FoqtSP/SmtX1Cv2ah+DjNUGT1vPdAwMGx3pUy94zkEJ6?=
 =?us-ascii?Q?qZc0DodYOrgzWZWy9u1zFFisnLJlRGBT+j7qH793A4Ld+rXJzA4tXZj+OlDr?=
 =?us-ascii?Q?4l0qUmOK3glQ5PCVdXximU7r/srI2tjm12Fd5HmQ12MqzJ7ai3TIHA9oJghj?=
 =?us-ascii?Q?LgHnVo8Fl6BKQ5/CbvoGmDf9LzexWgeCEWkdtAO/Yhi1umKX21RcSA8I+h5C?=
 =?us-ascii?Q?Ej8LRKkOnFjZ1HWuVaxPh9Ycyjl/K/KKYMi6cvCt5HgVjncqjM2xTXHVzu2Y?=
 =?us-ascii?Q?czdkAkUQwseT56yGCohC0YRwT62VO16wZ2bW4OTbmlKpvpCygIQHcvhrzxPZ?=
 =?us-ascii?Q?Ci91acmfttl82WK6nsf22gPdRvK12iFL7Sn08k4kUj/FSnQ4MwyErsVJ+IAF?=
 =?us-ascii?Q?VEJnA2rTEGuRgqNr6VSf5RUyNtn1j23heRTgVx8CuQg4WI809OICNyPnf/Sb?=
 =?us-ascii?Q?XSCsBbeEkqKz7jCHMh7G83EU+8+3PtUYjngSkYkWkXgB08pGwEXWuXwUTG6z?=
 =?us-ascii?Q?YjPx7oI77sZhDQo57uZs/D+eQBGVVLD3LaQ4fBX1dIvIcaGUC1dNwM9RlOrn?=
 =?us-ascii?Q?H6AmlMr3epxIQUuGLE8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:34:14.4325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 729b05b1-0c30-4707-dfa0-08ddfc59bf2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFFA661D690

Rename this function to mark it as autodefer.
For details, see the discussion in the cover letter.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/forwarding/bridge_fdb_local_vlan_0.sh |  8 ++---
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh   | 32 +++++++++----------
 .../net/forwarding/vxlan_reserved.sh          |  2 +-
 tools/testing/selftests/net/lib.sh            |  2 +-
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
index 202eee16ac19..868f2fa5f9d2 100755
--- a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
@@ -82,8 +82,8 @@ switch_create()
 
 	adf_ip_link_set_up "$swp2"
 
-	ip_addr_add "$swp3" 192.0.2.17/28
-	ip_addr_add "$swp3" 2001:db8:2::1/64
+	adf_ip_addr_add "$swp3" 192.0.2.17/28
+	adf_ip_addr_add "$swp3" 2001:db8:2::1/64
 	adf_ip_link_set_up "$swp3"
 }
 
@@ -115,8 +115,8 @@ adf_bridge_configure()
 {
 	local dev
 
-	ip_addr_add br 192.0.2.3/28
-	ip_addr_add br 2001:db8:1::3/64
+	adf_ip_addr_add br 192.0.2.3/28
+	adf_ip_addr_add br 2001:db8:1::3/64
 
 	bridge_vlan_add dev br vid 1 pvid untagged self
 	bridge_vlan_add dev br vid 2 self
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
index 20366c61944e..091833541b06 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
@@ -124,11 +124,11 @@ h1_create()
 
 	adf_ip_link_add "$h1.10" master "v$h1" link "$h1" type vlan id 10
 	adf_ip_link_set_up "$h1.10"
-	ip_addr_add "$h1.10" 192.0.2.1/28
+	adf_ip_addr_add "$h1.10" 192.0.2.1/28
 
 	adf_ip_link_add "$h1.20" master "v$h1" link "$h1" type vlan id 20
 	adf_ip_link_set_up "$h1.20"
-	ip_addr_add "$h1.20" 2001:db8:1::1/64
+	adf_ip_addr_add "$h1.20" 2001:db8:1::1/64
 }
 
 install_capture()
@@ -216,8 +216,8 @@ switch_create()
 
 	# IPMR
 	adf_ip_link_add "$IPMR" up type dummy
-	ip_addr_add "$IPMR" 192.0.2.100/28
-	ip_addr_add "$IPMR" 2001:db8:4::1/64
+	adf_ip_addr_add "$IPMR" 192.0.2.100/28
+	adf_ip_addr_add "$IPMR" 2001:db8:4::1/64
 
 	# $swp1
 	adf_ip_link_set_up "$swp1"
@@ -227,13 +227,13 @@ switch_create()
 
 	# $swp2
 	adf_ip_link_set_up "$swp2"
-	ip_addr_add "$swp2" 192.0.2.33/28
-	ip_addr_add "$swp2" 2001:db8:2::1/64
+	adf_ip_addr_add "$swp2" 192.0.2.33/28
+	adf_ip_addr_add "$swp2" 2001:db8:2::1/64
 
 	# $swp3
 	adf_ip_link_set_up "$swp3"
-	ip_addr_add "$swp3" 192.0.2.65/28
-	ip_addr_add "$swp3" 2001:db8:3::1/64
+	adf_ip_addr_add "$swp3" 192.0.2.65/28
+	adf_ip_addr_add "$swp3" 2001:db8:3::1/64
 }
 
 vx_create()
@@ -291,8 +291,8 @@ ns_init_common()
 
 	# v2$h2 / v2$h3
 	adf_ip_link_set_up "$if_in"
-	ip_addr_add "$if_in" "$ipv4_in"
-	ip_addr_add "$if_in" "$ipv6_in"
+	adf_ip_addr_add "$if_in" "$ipv4_in"
+	adf_ip_addr_add "$if_in" "$ipv6_in"
 
 	# br1
 	adf_ip_link_add br1 type bridge vlan_filtering 1 \
@@ -317,12 +317,12 @@ ns_init_common()
 	# w2.10
 	adf_ip_link_add w2.10 master vw2 link w2 type vlan id 10
 	adf_ip_link_set_up w2.10
-	ip_addr_add w2.10 "$ipv4_host"
+	adf_ip_addr_add w2.10 "$ipv4_host"
 
 	# w2.20
 	adf_ip_link_add w2.20 master vw2 link w2 type vlan id 20
 	adf_ip_link_set_up w2.20
-	ip_addr_add w2.20 "$ipv6_host"
+	adf_ip_addr_add w2.20 "$ipv6_host"
 }
 export -f ns_init_common
 
@@ -720,7 +720,7 @@ ipv4_mcroute_fdb_oif0_sep()
 {
 	adf_install_sg_sep
 
-	ip_addr_add lo 192.0.2.120/28
+	adf_ip_addr_add lo 192.0.2.120/28
 	vx10_create_wait local 192.0.2.120 group "$GROUP4" dev "$IPMR" mcroute
 	bridge fdb del dev vx10 00:00:00:00:00:00
 	bridge fdb add dev vx10 00:00:00:00:00:00 self static dst "$GROUP4"
@@ -731,7 +731,7 @@ ipv4_mcroute_fdb_oif0_sep_rx()
 {
 	adf_install_sg_sep_rx lo
 
-	ip_addr_add lo 192.0.2.120/28
+	adf_ip_addr_add lo 192.0.2.120/28
 	vx10_create_wait local 192.0.2.120 group "$GROUP4" dev "$IPMR" mcroute
 	bridge fdb del dev vx10 00:00:00:00:00:00
 	bridge fdb add dev vx10 00:00:00:00:00:00 self static dst "$GROUP4"
@@ -742,7 +742,7 @@ ipv4_mcroute_fdb_sep_rx()
 {
 	adf_install_sg_sep_rx lo
 
-	ip_addr_add lo 192.0.2.120/28
+	adf_ip_addr_add lo 192.0.2.120/28
 	vx10_create_wait local 192.0.2.120 group "$GROUP4" dev "$IPMR" mcroute
 	bridge fdb del dev vx10 00:00:00:00:00:00
 	bridge fdb add \
@@ -754,7 +754,7 @@ ipv6_mcroute_fdb_sep_rx()
 {
 	adf_install_sg_sep_rx "X$IPMR"
 
-	ip_addr_add "X$IPMR" 2001:db8:5::1/64
+	adf_ip_addr_add "X$IPMR" 2001:db8:5::1/64
 	vx20_create_wait local 2001:db8:5::1 group "$GROUP6" dev "$IPMR" mcroute
 	bridge -6 fdb del dev vx20 00:00:00:00:00:00
 	bridge -6 fdb add dev vx20 00:00:00:00:00:00 \
diff --git a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
index c7d17fff9575..a726a9a9eb65 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
@@ -67,7 +67,7 @@ switch_create()
 	adf_ip_link_set_up br1
 
 	adf_ip_link_set_up $rp1
-	ip_addr_add $rp1 192.0.2.17/28
+	adf_ip_addr_add $rp1 192.0.2.17/28
 	ip_route_add 192.0.2.32/28 nexthop via 192.0.2.18
 
 	adf_ip_link_set_master $swp1 br1
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 98c62ff4bccf..70331c3baa47 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -605,7 +605,7 @@ adf_ip_link_set_down()
 	fi
 }
 
-ip_addr_add()
+adf_ip_addr_add()
 {
 	local name=$1; shift
 
-- 
2.49.0


