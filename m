Return-Path: <linux-kselftest+bounces-22748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F61B9E1F64
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 15:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7490416723F
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438711F6684;
	Tue,  3 Dec 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NynRPKFE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8BF1F4704;
	Tue,  3 Dec 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236471; cv=fail; b=HejtQxegdkbOxfXQnC6fSPxKEud/NKBygnEXwaAvB8sRlTWGbxjkNoTh84lJ4JbYwakkqxNnZLi0Gm6ioo/gDQClLVsfb2hjxh3ks44xzXFr2mTgC2M8Sa0HaAnAfhJCI1VSsWi4YHEEIdiZWr0qiW/QIxkAyI3tNCm658xvFmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236471; c=relaxed/simple;
	bh=RUmjpS00KQPThj9efFSMqJlPjLPKYyp632VyEJwERTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgDWw3T5+CrreMuu3cdb+in4icT+FPtkpbTxvmz+tC+YIJREz2NNR/DgAxmPs1r5PGCO00o67gKlJbVHEOG1eizRg7v43yw2FxmfVwX1xNzchEcR/q5xyBWdvGKlltik8VdgcoGKXUM3/dwp2fJRvyVqgm2DTsLj2Yl3Vy7PVeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NynRPKFE; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6mwe1CckCOnb9OG+xb8aoTiy313rHwlngCEztfmT4AP8YpCMFXOCBejtxaBXSpLrLzy3UbMEHE0HB3cdL8Z9v/90Z5hfK7vTWoNwj785mlPJAoqzPHRyeLpSMLNv+Wi7/nKOFBEAVCpzIZQ5l6vv+0cvmd+3tjliRD01QrJe9Ofze/djGe8EFZTLaRmUdWXgVgsdHqcXfGvcZj1GBXUiIMUcSEP5z6yt7bOtjjjcNsixBNujeXSH6AFuHq/G7eVydGNxeKll1lwt7MAlRekVcWxNpB+d0sKXrDJnt75cASEK9/cFwJEKxhJLTSkp1wU4ED8CLEBI/HMW9HYui1tbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iemher0mO6qrlOQ5kx+Fwf3R18yaGpgpyBN2/v8lXvg=;
 b=nbPEJoeRgQgVKoglvxU5qJlsK3I8CpLLp2bRlWs4+7/2nLK2j2BmyMuRR3ARKu30itmyYU5I1hqfSZOWp8qG2GfGn66/oOBGCNyn/JTkEedJIhoJ9IS9ionTdfuEN6vsOaP2C7T2ipfQEIsLFL+gxZ1nqV0KKsP8EM1dQzhHY9s40Eemyku8PMHDSK8o7lxP+BO++bcQq3UtKSlcOWESrA/fUtvkAktDA08bajaT6WjkYJXtejNAuk7LzHb22Z9RQCSHp67xRh81oJ5ObIZuSEpR9whV56AQ8BRDbV1QWHDn3j5Y3Cy0ogBXt/boA9TGys5RTdc5WoRFr1azxSu59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iemher0mO6qrlOQ5kx+Fwf3R18yaGpgpyBN2/v8lXvg=;
 b=NynRPKFEISn1RRJXqbmWt5rVDfo4IY8X20a0AnURXS/DsY7XRfTluizxI3GDEF/S2sXGzPSXYxileoKvhzkq1Em/Hb5nAdpCJDdSlWYJ+FIzyQqkr2juKqie7LGrW0FHyAzUkMrQjQ1/rIUmxrCEqvJtBCqWOQfCmvxFcGhdWjt9o/6XyyFKR3NPXg5OqTK3vCrPL+o0LrYvy2M5BTcMNmz9vPko1p252jn5HPG9dgI4OQWlO/eGMGHSsdXDsADNCbgISSexMezudRYo0JzroGFvpVHmJTIY9NR/6t5AtoH/Zf6ATmeK72BI8mo1m9RIraUGkTEqfLDDI+BlVkQpyQ==
Received: from SJ0PR03CA0149.namprd03.prod.outlook.com (2603:10b6:a03:33c::34)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 14:34:24 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:33c:cafe::b4) by SJ0PR03CA0149.outlook.office365.com
 (2603:10b6:a03:33c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 14:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 14:34:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:34:07 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:34:01 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v1 10/11] selftests: net: lib: Add several autodefer helpers
Date: Tue, 3 Dec 2024 15:30:36 +0100
Message-ID: <ac277b17554c618c4fe70c280155081888b84cae.1733235367.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733235367.git.petrm@nvidia.com>
References: <cover.1733235367.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 90241221-1fa7-43cc-fa98-08dd13a7955a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mpGc8zrvwKSZeLANWT9Xi1FXfRvboijZ8oCRKnj+ZgAePxVMv/Id/OGZ7DcB?=
 =?us-ascii?Q?FTlPCI2OWLF2Eq9KDUP+sa6yvX27PodQ/ORCVK6oIPaJfIng5g65XLocEOla?=
 =?us-ascii?Q?W9AD2Os5PaG4eMbt2Zd/HC0H0JgOExdv3J7K+K/v/IF7lDb7EeXFXDcMerYX?=
 =?us-ascii?Q?SEKl4cZSkPUK7CrfFVpEwvvZa5PmB03rWKWMa9JhSLF8DVKZZx2OAwXREUnb?=
 =?us-ascii?Q?UoO8qEK7+SW2hQH1JSkInIushnrfJk5wf7frFpN3z+soXsqYCPvu+ic0AZQc?=
 =?us-ascii?Q?NPp8H0gNhhjGEJR8FY1wwVXxyuK6w6sEWi8qc/bKMG0SG41SWMqECt8npBz/?=
 =?us-ascii?Q?JIsHPtpvnimRQ7etUMQf3d6iQHipKV+oGzTsmSVPX8TdqXEf8OvLOdG9+tCQ?=
 =?us-ascii?Q?T0zkOeeQfBUs/25nSwPeJAHlIbplFxRGQdIXvHbzoyHgV6j5J5zYGagQiS+w?=
 =?us-ascii?Q?+634h4VifHNNTMBiI/MmliuQzdY4ztzhua4Bc+PoleEej2USEW/u5F0eNk5K?=
 =?us-ascii?Q?J27CJc7WzcCt8GsVrwplVjQxYFf9wQhH95ZRvHMswnE/GznVu7FWOnfujsQc?=
 =?us-ascii?Q?gE7gBBW9dqdCPlY9EfDapPNn28cdA/NfJMo63zap828t0np0vENgjFuagYEm?=
 =?us-ascii?Q?MNnYuPQDyOUELTCyV6CHVwYjOgtKtnHPxGkj0ZN3+N+CP16OcWU8LB1UOIB+?=
 =?us-ascii?Q?Bj91oL1SsHZqIGJnV7j0xF+cRazR0nHGB5qIkTY1X56KVcEfivcJsWYFbAJW?=
 =?us-ascii?Q?L44JuOyHJNAExdU5VXA0m9ZFz4hLUW2fSKcU2VPGIfyibPoQ5jl6KmLx4QHq?=
 =?us-ascii?Q?jjlJ1pAL4y43dUCwdElCGkr3XM5Haal3Og7hKcfS3vSlZ4HHEyqjqHGv/YkZ?=
 =?us-ascii?Q?KilWLtihM0+jn0KN5J15kn7nRhT3HRixTPVniDegrSO316YOK06oq29Ox1uf?=
 =?us-ascii?Q?WZk0yy3n5mcUqlTjNZCvACEWLOz1zY6EuZ1DgppYLBxzttV//s2teYWTW7lh?=
 =?us-ascii?Q?LARohk/1zfca/5nSsz99d6B8U/dxNxGtadZzOQtihPFkYaWoALcjSodHl4zj?=
 =?us-ascii?Q?SL3BdHepBt9Z7TzRiu6+0jg8SndtI1kLKngsb5fXBG1mrAYx92eCvAABkr/O?=
 =?us-ascii?Q?UMG3IQfxvl0GOxiK/qTkgxVG1u34KjsLFHf+QxCsXKsFZtT6L2Yctdqba/kj?=
 =?us-ascii?Q?8E+FmQjBGnaqj+/lEHql4Hvz6dV5hFk70Iv5a3ZP3j0zdJuAN+v+VnT4xT5A?=
 =?us-ascii?Q?Ozk2SkNWD3jtV6oWs5Q7Vsyga+IL132NRU/LyY3fWbT+7yPe/Q6n3wGS795k?=
 =?us-ascii?Q?w8f6DwO4fjhhQe5zCIH1CiOYFE4A1sBe2X90l1I4hDCWAMQW6vtlWgrdCQ2u?=
 =?us-ascii?Q?JkItX44iXg4KNkj1/4GMp4JdBUAPSPjQCy6gse9kpRW3yz54SbqpIjdAXO7k?=
 =?us-ascii?Q?Yf40LNIxeBnZZfvkJEUUwL/cqt0ONfE+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:34:24.1462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90241221-1fa7-43cc-fa98-08dd13a7955a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377

Add ip_link_set_addr(), ip_link_set_up(), ip_addr_add() and ip_route_add()
to the suite of helpers that automatically schedule a corresponding
cleanup.

When setting a new MAC, one needs to remember the old address first. Move
mac_get() from forwarding/ to that end.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/forwarding/lib.sh |  7 ----
 tools/testing/selftests/net/lib.sh            | 39 +++++++++++++++++++
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 7337f398f9cc..1fd40bada694 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -932,13 +932,6 @@ packets_rate()
 	echo $(((t1 - t0) / interval))
 }
 
-mac_get()
-{
-	local if_name=$1
-
-	ip -j link show dev $if_name | jq -r '.[]["address"]'
-}
-
 ether_addr_to_u64()
 {
 	local addr="$1"
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 5ea6537acd2b..2cd5c743b2d9 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -435,6 +435,13 @@ xfail_on_veth()
 	fi
 }
 
+mac_get()
+{
+	local if_name=$1
+
+	ip -j link show dev $if_name | jq -r '.[]["address"]'
+}
+
 kill_process()
 {
 	local pid=$1; shift
@@ -459,3 +466,35 @@ ip_link_set_master()
 	ip link set dev "$member" master "$master"
 	defer ip link set dev "$member" nomaster
 }
+
+ip_link_set_addr()
+{
+	local name=$1; shift
+	local addr=$1; shift
+
+	local old_addr=$(mac_get "$name")
+	ip link set dev "$name" address "$addr"
+	defer ip link set dev "$name" address "$old_addr"
+}
+
+ip_link_set_up()
+{
+	local name=$1; shift
+
+	ip link set dev "$name" up
+	defer ip link set dev "$name" down
+}
+
+ip_addr_add()
+{
+	local name=$1; shift
+
+	ip addr add dev "$name" "$@"
+	defer ip addr del dev "$name" "$@"
+}
+
+ip_route_add()
+{
+	ip route add "$@"
+	defer ip route del "$@"
+}
-- 
2.47.0


