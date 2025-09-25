Return-Path: <linux-kselftest+bounces-42401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA54BBA0EC0
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72A06C2846
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C1031771B;
	Thu, 25 Sep 2025 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IsbXeZnY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013062.outbound.protection.outlook.com [40.93.196.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA319315D52;
	Thu, 25 Sep 2025 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821697; cv=fail; b=KSKn3zVty03zW/89ha3Ts+lFEiPqUoVlpPBQDMQ4gcIOhMVpH7erHIpTdIeCeuvhy7CF0kwQI/r+uiXKeaGRgLPje58Mp9JkgsHg9JZNdWD1ISUTxf73VjwWV8hoGRJihbSAN+6LP4v2upF07VoE/Gy9XGcu+Fhf8za0T9N2Xyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821697; c=relaxed/simple;
	bh=p0Yx2EfEnQmSDeIkuVoGAWt8rbBG3xQ7rQSqkBcgbZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDQmFn3yXZn+bK36w7pAMGjdI1sGnowXcJ8aw9OmbLU3/vOf07aRe7YyNHQYhzhvrnGzvjGvpBbntIVwQbSBTEUo8xumAo4HwzRujdCxNk7+pks1fuO/ekN5HnYWyFHTkDhbU/AdLRNYHUJ4PnXOjpFYaRaBoeakekmaT4jM1O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IsbXeZnY; arc=fail smtp.client-ip=40.93.196.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsN7ug9u5shL3tY6j7EzHEK7CCdXkSjS1QjYszzPL6OqUWiiXAvUQC38vZzwsb3qowSHwYGvjIEopaNiw3mmzoKuDtsymr9j2s5TX/CxJ+g0WnY9lR8lzN2+209gBZ1Ayu6u/67CQWXin7L+p+ZA8I7AJqd/fAdx4SGXMBVLtFznQJa10Xmla5hIk0b+f97MYKa2CTGSEqVQvQi/jXn7/YC4ivb4tk3HuSljXjiifuoQBhhUlAAzfd71T4OWOsGqOsuSPCQ9tKQyPq+5jRnQ2UgKrcbxXHaV+SwYC1FaCG6iyw3FjmDqNZF5d5M5ecvjgwdIHOpYJykcli6xYz+r8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPyRQJK4GYwH8Vau95XxbcdxmN5c5Jfi5pB71DdGioo=;
 b=IxGrp7lD/qp/pE8/VNJ7nCUCCfy+fl8vwCW9JXXvj3cYm8NV54F+F25deiLERIFc30lJS3kd2hWJFzQJRFT75Gpy/e7copIXy+qKLLXlsm4yY+lpOxV6avAW9JM6ZENI+jwsWH8s3z9p2IwvBm0tFg9CFA3XR1QJ3JI167mA+6/Y/zr6QmNnD22JuYNpxNz+m3tha9PBpcH1xiKm4qeVZZQlq2oD/bUBp7X3iNWh6394+1cH4o7mXnXcVjEHigfX4mY0WkLrhdjXiNp/Pl4npd6XnPEtY6l+MOWXr9GJYP/7nrQPn39I4UycfXp0dV7CG89i7uZYWdWZZByGDy88nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPyRQJK4GYwH8Vau95XxbcdxmN5c5Jfi5pB71DdGioo=;
 b=IsbXeZnYlngo0OFllS+SJuOTrRhC4usgfAugeEgiG1/JdoTGtCc/Fp5ZJSlJpp3lTNi4yLc89KyOUbA4No12nstLcrla2ssWu0PxNDLEPyW3aimAla1XY0bj0/ocUiKbLG50zZq7k6U3Pf8SpxPCSwYUq7e2v3x9jcB8TL4Nk1lVrL9JcaVjIEaC9yBkV2W5XpuLaFBrYD4357klJOxUGhx82+4oOpUui7OFOGz/p8ZCnC8KunM/5xLukmN01imBH+01mfOB9KdGYyP8lBWqXSA3TDns8m5417/0Yyf5Z7TrY/03FDh9ke+28rV+iQCZzGJywyNt/9326iAEz6ycfA==
Received: from CH2PR19CA0014.namprd19.prod.outlook.com (2603:10b6:610:4d::24)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Thu, 25 Sep
 2025 17:34:51 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::a8) by CH2PR19CA0014.outlook.office365.com
 (2603:10b6:610:4d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 17:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 17:34:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 25 Sep
 2025 10:34:34 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 10:34:27 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>,
	"Shuah Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>, Alessandro Zanni <alessandro.zanni87@gmail.com>, "Hangbin
 Liu" <liuhangbin@gmail.com>, David Yang <mmyangfl@gmail.com>, Li Shuang
	<shuali@redhat.com>
Subject: [PATCH net-next 12/13] selftests: forwarding: lib: Add an autodefer variant of forwarding_enable()
Date: Thu, 25 Sep 2025 19:31:55 +0200
Message-ID: <78b752c40069cde21c44dcf4c7b966a76a0eef2c.1758821127.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: f59406e3-3eb9-40ab-41c2-08ddfc59d4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?31paHBUMOfTG7/dcB5b128+4kUtgJtCOwJ4p6GerJNa8PN36miZ+NvX+x6es?=
 =?us-ascii?Q?4h/+6R+JD+UtWK8zb2yn/n63pU4q9zghbzjvxJlhaWNdGwcy/m1JJiH5LRd5?=
 =?us-ascii?Q?dxBce5exJWbXTKhX6gpEiE6YwwPi4ZYjKLmjUOT4XW1aVbFiVC6LiqTEODHx?=
 =?us-ascii?Q?BEjDGXVSy+SSmoX5s9dmZwY0yWBZwx+pPRY4SmMftP6+VP7CG7G16HYWpfAn?=
 =?us-ascii?Q?BYzTTAZ2OH8iFabppsvp2hcxjT1nIyeJHFrUPs+Dk6GBe6Ffy5YhF4cS/Hsk?=
 =?us-ascii?Q?7mpjQLhFj1jcZvWVVWnFbpgAgvPHbUlY1PJtevhStdifO2wrIrJBrNlOoTlk?=
 =?us-ascii?Q?3sJNMCO+vLQ3nHJW22380bin15a8QDWd0EWui4pdnXt5y4Ik59Bs20EGdsVw?=
 =?us-ascii?Q?VRIRoejHmRXzXJB8/0iRHiEe5qcdtyVcDy+GjnCqQG0tl6mPXR1lQm+4GOpb?=
 =?us-ascii?Q?jwIpdERE1fBN9jq/AFpWsQ7c62DBVgbHL8a/csEIJMDuokhDCfKIvn0pe+k6?=
 =?us-ascii?Q?i3xgx74BAYyyWnKOxrcNz6zU3FQVK9Kj1qHsvmYTQTrikOewYUsz+Qmw/fhC?=
 =?us-ascii?Q?7tasXCp3tBBIB7wBNv/wbc7aWKhWwTiYj33lZE6OFhqotLVaRDQPOM25wfW2?=
 =?us-ascii?Q?QUh0oT5s6J8Z2cudsPA5sKTFAgOkgWFKBgcF8RAGGmv2KwRpt1NvJauYWZQI?=
 =?us-ascii?Q?ylcKC7zgv6qMPO6bY9nvrwCiAFZ8V7Kfsyryu6XXN57yTgl7cgiGG7v8xTMq?=
 =?us-ascii?Q?UXkboqUFKyiS4hFVQhSGsk8siorGpCqDARMPuAGKVDgx6do6WfE4Qm9iaxc4?=
 =?us-ascii?Q?lGgIs9+Y1n7Sb4zr+yrpNvxbnFoPFm3T2M/WwoVTiDNOoSwxmFTspsSupU1q?=
 =?us-ascii?Q?vO1qRolzQjMLRw+g/vX8ZWWo9EHyFZS0xh6VGhUhvI6EYCnwmQQGDRo97hfx?=
 =?us-ascii?Q?4ixFRwx1t7sGzJgXsEqJ05z5TyUGAQKQe9g6PKuROI+kjanGfy3rdCDoO9sx?=
 =?us-ascii?Q?slQjIWnP4xVDTuED1nJIRAtlLyYl4uM4U0bgsgpKXgw/7wLTXtkUCkxo1nWS?=
 =?us-ascii?Q?gCiCRWV9F13iFOuFe48TPBMuGzcbPUOV9jmIMAAmn/R4YFaSC4qqmIBcJXP/?=
 =?us-ascii?Q?O0yd1y21mbWhml4VSGx95p7oyySkaJtor5CgAqsx/GtsSscM/+2T7okyivqO?=
 =?us-ascii?Q?mNRQAg8SzzZZzUDOA4ukqkU8dvkDztx/ft8HRPSZ0PjUk91kWYC7vMgkSMnR?=
 =?us-ascii?Q?qyMw0HMMvniNKBn1R6Fqzq2hyd1/qhuV9MWGalFFMsdMidRFuQfzYCvD7EBx?=
 =?us-ascii?Q?6nFX/yThHUcErofJhW7RPZQtgxSIVVm/2mzXSHZVvdInKLW6xB5TWTwRCFNS?=
 =?us-ascii?Q?Y8cVAl7fyTpADhx/00bFpEsONa4G2sNPxKdSRXNwweBCUo56BDmIAqxLEyhB?=
 =?us-ascii?Q?nlA5WBGk7zEBzUwX5Hf5QY9SK+ajBbB40bwApus6928o1UYmp451RaWeiuPS?=
 =?us-ascii?Q?im4G31oiXUPf2XOggskAardD4DhR+MBKtJsVFkewARfaH0pWFOiJBRGgn2oh?=
 =?us-ascii?Q?d1fjxr92hGrpmfwxlzU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:34:50.7810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f59406e3-3eb9-40ab-41c2-08ddfc59d4d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064

Most forwarding tests invoke forwarding_enable() to enable the router and
forwarding_restore() to restore the original configuration. Add a helper,
adf_forwarding_enable(), which is like forwarding_enable(), but takes care
of scheduling the cleanup automatically.

Convert the tests that currently use defer to schedule the cleanup.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
CC: Alessandro Zanni <alessandro.zanni87@gmail.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: David Yang <mmyangfl@gmail.com>
CC: Li Shuang <shuali@redhat.com>

 .../selftests/net/forwarding/bridge_fdb_local_vlan_0.sh     | 4 +---
 tools/testing/selftests/net/forwarding/lib.sh               | 6 ++++++
 .../selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh       | 4 +---
 tools/testing/selftests/net/forwarding/vxlan_reserved.sh    | 4 +---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
index 78b6be513a2d..694de8ba97e4 100755
--- a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
@@ -95,9 +95,7 @@ setup_prepare()
 	h3=${NETIFS[p6]}
 
 	adf_vrf_prepare
-
-	forwarding_enable
-	defer forwarding_restore
+	adf_forwarding_enable
 
 	host_create "$h1" 192.0.2.1/28 2001:db8:1::1/64
 	host_create "$h2" 192.0.2.2/28 2001:db8:1::2/64
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 7d506cf81a32..a9034f0bb58b 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1023,6 +1023,12 @@ forwarding_restore()
 	sysctl_restore net.ipv4.conf.all.forwarding
 }
 
+adf_forwarding_enable()
+{
+	forwarding_enable
+	defer forwarding_restore
+}
+
 declare -A MTU_ORIG
 mtu_set()
 {
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
index 9974a93eb850..6a570d256e07 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
@@ -370,9 +370,7 @@ setup_prepare()
 	h3=${NETIFS[p6]}
 
 	adf_vrf_prepare
-
-	forwarding_enable
-	defer forwarding_restore
+	adf_forwarding_enable
 
 	adf_ip_link_add "v1$h2" type veth peer name "v2$h2"
 	adf_ip_link_add "v1$h3" type veth peer name "v2$h3"
diff --git a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
index 712f3367ee5a..709845123727 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
@@ -87,9 +87,7 @@ setup_prepare()
 	rp2=${NETIFS[p4]}
 
 	adf_vrf_prepare
-
-	forwarding_enable
-	defer forwarding_restore
+	adf_forwarding_enable
 
 	h1_create
 	switch_create
-- 
2.49.0


