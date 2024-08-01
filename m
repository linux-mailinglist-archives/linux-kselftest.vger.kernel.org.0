Return-Path: <linux-kselftest+bounces-14663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 447F5945080
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 18:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86AA1F23544
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD621B4C2D;
	Thu,  1 Aug 2024 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jjaTL77R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB44A1B29CF;
	Thu,  1 Aug 2024 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529521; cv=fail; b=Bz/2XOPetTvvrdRSCagVShyVh0m9Wl+Qh7jQlQ+UIPw0HgyQiyaFy3GBAm96wpvPgpabiGD58EyLd8TJ6fUGA7FellG1jYPJ8P7mpIfAJz06eI2kuYZ3F6n9mkpIEQDNM7P0D3IH5esebHuFV2l2oAgLFf0/SZPCPKxMoSK0iY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529521; c=relaxed/simple;
	bh=RctU0eA9+EmIV37pfQ+scxV3pTzhUncIt1BoXc9SG+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkMst4aBXH/fbhNM24yqr4W/t7SDJa8mfOqHq2TshArK1pXMojfnGYZP/dXtCrNsrmuAWvoiG5Ciq7Xc+tCt0kny3jbmu2Zc13iewH8KK6de3AETtPZADaHra595pMl6IPJhX6YfvpNdgSj6/nli5DQp7sbMtsNRsBlmblfvMF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jjaTL77R; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAEgoJhyN/3FNfBfBye8eZ7h8k8ibsEQfe4GHeppAlFiq3AM0kzPFUWAKLm9npO/4awrk+6wIAViMSlnr8A9n4DCdtON+7i46R/ZeCta5mfmIx8FIuqQl/Pr9sZ9clomNgaKD8PhnTZ75kqcZ48RnlolSMQne3T+7IROjbdW5qL5zuse5zfhshjSDRiwwfsn+rPpZ3mh//R6h7w2H6FSe64e9G7hXzxnI94g1dAjX+Gd8G+P8lR4h5feqASHwpSRNKTO4GFtQ0r13LfJN3nsJW/ywi4Ibp3uzKgoRfp8A/k/lqlO1vE5Aq41g95ddHeQvT+YmzroPASFw1bELvXeLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=as/eyFV872lUs3tUkcz7+AWGmcQqG4oDcQ0HkUo2mdE=;
 b=cP9aa7tM3JmkcQHZYF4PGdO8icQleHiuuWEWhAD1A9UwVEqfbSyiSeVM462qVeJgpgGmE243zINNcD2Si3c6P6LjsE8y6ZGfJPXVEZfC+d9sh69Q577xgrXLjE59VtKDYxI6kQ0c8mc5vBj4wNfgD0BDXTu7QZ7XNhF0UgTTQuxetTgT169HfPObSUPz1uII+xvR0OIOT3hrh1TLrab4zdd8zVjUVbRpzNNm+G36N+usaQASEeHnDVTLTtNY78XlkcvWzv9UBDQGL0ETlH6Yj6QwXcBiv5u6/pJVcxx9ZbI20aCtkaLn1o1M8wb6IJb5V6yBV7j/w41hM1jHdiny5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as/eyFV872lUs3tUkcz7+AWGmcQqG4oDcQ0HkUo2mdE=;
 b=jjaTL77RlpMbQpGjwtT+BUyUyO440gugawHXI8sPpJLj6WqIrUKJqo9mV07w2gcGMH7NDm6DCQl84w348e9mG2nfuEbiLm7VqCoaWt88bxO2WbihnVLkCrIT6OGEJLjueV0ZvPYY8Zn22HpSMcoQK4WWXSnXKrN/LC2MStd4JkdZIsA5Y4UbWghHmsP4N/EKXNrNMrCE/EF+BFlegZX9fkKr4olz3Kc2RwJ/0Vq54fIAkHO1a+4NpfV1e1HSKAKpByELN5+XCx91m3Stqvt4NEFbfphxtukdoczjQERXAnOSQMJmciUYX+xDB8hJlExMrXyFQ12Aybfy8ZyTj2kflQ==
Received: from SJ0PR13CA0130.namprd13.prod.outlook.com (2603:10b6:a03:2c6::15)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.23; Thu, 1 Aug 2024 16:25:16 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::6e) by SJ0PR13CA0130.outlook.office365.com
 (2603:10b6:a03:2c6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.7 via Frontend
 Transport; Thu, 1 Aug 2024 16:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 16:25:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 09:25:02 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 09:24:57 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 5/6] selftests: router_mpath_nh_res: Test 16-bit next hop weights
Date: Thu, 1 Aug 2024 18:24:01 +0200
Message-ID: <cb261100217b15061d9dd0f0bcb06a0ffe00e968.1722519021.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722519021.git.petrm@nvidia.com>
References: <cover.1722519021.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: fd720628-362e-4883-c5fb-08dcb2468712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dR16R2R0VzXRjMu0jPes+/qN2V2zsCpSyAFbBHmeUw+jK6sVI9S9JmrA0mVf?=
 =?us-ascii?Q?eY98f2jcC70HAuDv9JJrzAa5hinBlOI16CNrAs6T9RbotownxnL1Z4vvNPrC?=
 =?us-ascii?Q?egiu9QunCq/kjZM+m5vmWEwOtHN+xZ89IwiGzGWIjRV/tpRzKr9v2Lg3Vf8H?=
 =?us-ascii?Q?3RRCxDIaRA3w6xkb8MkhEzgjwl0tlsH4+CZ7ksEBGW+KUapO/YvEdL6K8wqR?=
 =?us-ascii?Q?BeQOMr3VhX6cgyf4qbtuXKaOHsmLoSTrRsgixUVjU9tOGTA0Td2UJ82+N/8i?=
 =?us-ascii?Q?10zo6zq1KNhKnHRrbLUy9e7JyzEliA9zplu4mN/SvKAf+5mZOMvkgIbiSpit?=
 =?us-ascii?Q?DqTuAuEean2DS+pupfBp/R+ORK1rSvT6djOasmoWMycq6oMyyZunG4PrYozA?=
 =?us-ascii?Q?fm1ObCTFnyg0tpAK1zDMP5FFj0t6w1G7ssuOIu8bGbSK47dvIwDoSh+uHpjp?=
 =?us-ascii?Q?L1DDw+rxxoSJMSehDJwbWvEweJP0b3JoNmE4ZKNEAxCg+STZMTEZ2i+oBzJk?=
 =?us-ascii?Q?rur68su1pPfm5Zr0bhxZ6yq4+m+hr6Dq8aClQHUMYnhIj/yOCwIP5uhCtEvi?=
 =?us-ascii?Q?b4fyuNLi6pzYeoUmKzx6Ka5zJYOUVNonFnQGwGeyt81xD7Qonoe9upbFlpPN?=
 =?us-ascii?Q?/P+fUx90ZBdS412rrUfMJVR9msxs7afZZdWhs3yEd54e3M6RaKqHLu3wsHUd?=
 =?us-ascii?Q?o7ehycBqi2EY8VQOiImyrn8qhygTlrv9t41BvzlABht/gQGe7IgCajXiAzq4?=
 =?us-ascii?Q?9XK/kXqgtzF5nfRtxMeQlTrrHEf7qqQ1YY5RvCPv3Ijza2mvz0lO9EmxgMYe?=
 =?us-ascii?Q?dN6KfRMDhrugTIs6Y4/I/O4MGEvpZSbZU2GhgUzMQPp4WEcZ1sO0w/6sFdsd?=
 =?us-ascii?Q?SThWHJ11c7QlW6iGn9SZkpyfQETboyYXrC74IA5TJjnRloC5Xy72brM+DwL4?=
 =?us-ascii?Q?WEXYHsBX8oDhdpQPWdmU9pR2GaibwqXg6Bjd0QUj4V3a04pD8IUEDQ96ojFW?=
 =?us-ascii?Q?QJiIpmKPoFh3cKu4hN4xjJg6TRJAq5AmZ2xIu9Mjaaal27oY0LRkk9liv3p2?=
 =?us-ascii?Q?tdWoUIv/XQ7nMV1aFrhfV/7WdWHOtymWdHdFqSvsIVirVi4Pf/fcMuW202Ob?=
 =?us-ascii?Q?LMR29R8D5vmHQWPrTNXBPvhDsTvamcNfBiH4r+KJuu0sjWfLYpeNZ0g4OqnJ?=
 =?us-ascii?Q?+ic4cp3GqirG95TfnyEy1i3QJNghJ8h42qhK6E+ejUXdx0VImS6yM3DcOJtj?=
 =?us-ascii?Q?Ef6T/WCkgg00Lx5nqsY5uOhLJ53BjgrGR+QBUppKFBTv9fxtqEzkFreHlIZ7?=
 =?us-ascii?Q?OKaePl3PleSwr4l3iN7S3dNfqsOZWXiEkP7hS4JwM9UpZ7x+i0/gySxvSOtO?=
 =?us-ascii?Q?r2rLWDOhtRLj8biUul4V9ClvClVGU4U0LH0Ju96BjR0kggRTe1tnbc682/bs?=
 =?us-ascii?Q?Y6Eg9oT4iyeGTZXO0KtzjhLotEUTRDJW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:25:16.2439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd720628-362e-4883-c5fb-08dcb2468712
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344

Add tests that exercise full 16 bits of NH weight.

Like in the previous patch, omit the 255:65535 test when KSFT_MACHINE_SLOW.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/forwarding/router_mpath_nh_res.sh     | 56 ++++++++++++++++---
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
index bd35fe8be9aa..88ddae05b39d 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
@@ -40,6 +40,7 @@ ALL_TESTS="
 	ping_ipv4
 	ping_ipv6
 	multipath_test
+	multipath16_test
 	nh_stats_test_v4
 	nh_stats_test_v6
 "
@@ -228,9 +229,11 @@ routing_nh_obj()
 
 multipath4_test()
 {
-	local desc="$1"
-	local weight_rp12=$2
-	local weight_rp13=$3
+	local desc=$1; shift
+	local weight_rp12=$1; shift
+	local weight_rp13=$1; shift
+	local ports=${1-sp=1024,dp=0-32768}; shift
+
 	local t0_rp12 t0_rp13 t1_rp12 t1_rp13
 	local packets_rp12 packets_rp13
 
@@ -243,7 +246,7 @@ multipath4_test()
 	t0_rp13=$(link_stats_tx_packets_get $rp13)
 
 	ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
-		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+		-d $MZ_DELAY -t udp "$ports"
 	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
@@ -259,9 +262,11 @@ multipath4_test()
 
 multipath6_l4_test()
 {
-	local desc="$1"
-	local weight_rp12=$2
-	local weight_rp13=$3
+	local desc=$1; shift
+	local weight_rp12=$1; shift
+	local weight_rp13=$1; shift
+	local ports=${1-sp=1024,dp=0-32768}; shift
+
 	local t0_rp12 t0_rp13 t1_rp12 t1_rp13
 	local packets_rp12 packets_rp13
 
@@ -274,7 +279,7 @@ multipath6_l4_test()
 	t0_rp13=$(link_stats_tx_packets_get $rp13)
 
 	$MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
-		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+		-d $MZ_DELAY -t udp "$ports"
 	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
@@ -373,6 +378,41 @@ multipath_test()
 	ip nexthop replace id 106 group 104,1/105,1 type resilient
 }
 
+multipath16_test()
+{
+	check_nhgw16 104 || return
+
+	log_info "Running 16-bit IPv4 multipath tests"
+	ip nexthop replace id 103 group 101/102 type resilient idle_timer 0
+
+	ip nexthop replace id 103 group 101,65535/102,65535 type resilient
+	multipath4_test "65535:65535" 65535 65535
+
+	ip nexthop replace id 103 group 101,128/102,512 type resilient
+	multipath4_test "128:512" 128 512
+
+	ip nexthop replace id 103 group 101,255/102,65535 type resilient
+	omit_on_slow \
+		multipath4_test "255:65535" 255 65535 sp=1024-1026,dp=0-65535
+
+	ip nexthop replace id 103 group 101,1/102,1 type resilient
+
+	log_info "Running 16-bit IPv6 L4 hash multipath tests"
+	ip nexthop replace id 106 group 104/105 type resilient idle_timer 0
+
+	ip nexthop replace id 106 group 104,65535/105,65535 type resilient
+	multipath6_l4_test "65535:65535" 65535 65535
+
+	ip nexthop replace id 106 group 104,128/105,512 type resilient
+	multipath6_l4_test "128:512" 128 512
+
+	ip nexthop replace id 106 group 104,255/105,65535 type resilient
+	omit_on_slow \
+		multipath6_l4_test "255:65535" 255 65535 sp=1024-1026,dp=0-65535
+
+	ip nexthop replace id 106 group 104,1/105,1 type resilient
+}
+
 nh_stats_test_v4()
 {
 	__nh_stats_test_v4 resilient
-- 
2.45.0


