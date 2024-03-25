Return-Path: <linux-kselftest+bounces-6566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A13D88AD23
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 19:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA491C3C7F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755DE131E4B;
	Mon, 25 Mar 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZFgtqkHu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4126131BD8
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388012; cv=fail; b=h+fO5ZirQ+YqM7DfA9N66jjl9bdal3ZQ9rXPwDwTUJugLb9lDYcNMa2FaWVeIKVNGMxHM6cfwQM7Ht18QJOMRosjAIyilse23DmnSRu12MGHkeS8My036GU3Q46Y1U/v30wsMRsW+S1kvKvNgTYE5cM4g0EJoXc7mjs3Ey7mYU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388012; c=relaxed/simple;
	bh=tN077XpbLAOCl7+6y1PdN3Jr14rGpvOOfr/KKZ/A1SY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1ImMBa921MvAkn2lCjqXlUshgDNUMS1SbzrXjhTpXRMh0lmda8HeWkx7cspM2rItB45QEFNg+BR0xJ3StMdyLoXLybjsOJ9Hqh3rcX7bxaYcuSLcUKMb+d/OS0PDKktqZQxjkWfXjsWSXBOEhajnYKSrQhL0aES8DNaq62NWSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZFgtqkHu; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bqfn0PqGVDMqp85bU1lZOzpToS4BVw1hV/YdI67PP5bZ3EQInt2UuzX7iKF0VhBOKewojvMjz8vj/K/R2ZL2f5v5rtGejgEgWUHdV1o/qWumKu+WsGEBUHc0avl3cKoh5zhuzFWRlVfr6wUmLQEXqfQpWKwKTl166kXqFlvju1n7dHrnzGk5hKZ7SpW1t5zuUOdfZ2CPlNhmMkQ8gcRW2TqOJ3edevYEbDV9SviIF5Lk57RVVsRVqh/FgLQXeD1+vtg3NH9FNqALjmczEZXxBK0hCi6cHelQ3A2zQwXswA/y2qs+Tfqt8ML+tXSjxUP8g585h1kt0V4ElBnSN5UheA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ta5/s9/vAt+a2rmB7J9pW1L9/gDNzKRZJ+DkAUkDZBM=;
 b=mjcKFqIv6n/pUHgMnwHeoJYEnsi2/luMxDUpIVFAO+lu61wPOamqf83DBc5zPzVtfEvR613FYcyUfZ5w2aOZfhuO9SZXUJtUPWL6IbJJmozPmRFF/wh+NJKk6zjJwSSQG4/eDFGDZf/AhnJgYSIJdHCKkikIKOlGNf2SHEAdLZjOKJ/ZaDah0JgdzZAWmvvMqbQghzyOJx4EM6sUID/g2TBK/1rxUIwi1SM7hT1yt4W0UQICUuQeWbV0Igw8Csj/u+5SxnRYSYaQgiq1eSOFUsDzjFwooD7M4YXQhHs9jYFamTNj9G1gqi61TQODej+2UkEabw+RvXmkFaR3zicVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta5/s9/vAt+a2rmB7J9pW1L9/gDNzKRZJ+DkAUkDZBM=;
 b=ZFgtqkHuWTZpRqMgpMHpNVjAXuRUjvCwAcSv2tW8Xctz/vgawvWBR6HpOR+ny44phPrQg7DwTakmUACFTM0ozExNIoFDqiZxHIjzl6vU75uLYgl/EsEsrCjy4MQEkBfesn34VdYdeRp4oyHzoapfMdRCLgh1HEEFDKHsJi5vIV20XAt2XxBmqgP96t5FSfaimVAbj3YheA1hy3J72c5gLnerEO9VegqZdQV3pWNrm9K1Wb+jj58KqVi1hMV/AMwot9Zrb7B2PoJMq9JipFPl8ZJLx9ENJTpPXIPNTZKehn19fKZiGYJ0QawUoDQfVXUHzvzYL72y+NFMzeApkQSGRg==
Received: from SJ0PR03CA0209.namprd03.prod.outlook.com (2603:10b6:a03:2ef::34)
 by PH8PR12MB6748.namprd12.prod.outlook.com (2603:10b6:510:1c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 17:33:26 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::82) by SJ0PR03CA0209.outlook.office365.com
 (2603:10b6:a03:2ef::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37 via Frontend
 Transport; Mon, 25 Mar 2024 17:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 17:33:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 10:33:11 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 10:33:05 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <nbu-linux-internal@nvidia.com>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: [RFC PATCH net-next mlxsw 13/14] selftests: forwarding: router_mpath_nh_lib: Don't skip, xfail on veth
Date: Mon, 25 Mar 2024 18:29:20 +0100
Message-ID: <85c7ef7f4f5d796c0ec8ce0a9f1dfdbca2c0d279.1711385796.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711385795.git.petrm@nvidia.com>
References: <cover.1711385795.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|PH8PR12MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: ee09b38d-7447-4446-f76a-08dc4cf1add2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VDQiyYUUo7u0ZiyEj/VuZYET7h3BcdaLupfIVvQUVKslCFuEfpLV11HPBRTbn2OJol/2rXvdg91/WESuC0Iqpgaihb6j2YgcAGS2MUh3qg46mxdeUKKChARmRcT2jhA65F3jlQtgLzIISG70+Xxdx5cNb8i1MtH2WZpDwaejcOooFcFCa/8FA0aeJifd9DjbppikR5eC9nCnW75pIlDDFYI1QzV8m6bTMYc1+rwn9AiajAufNfVETQOv3a2O+dcynk4n10kgsFLmGydSPSfdKDNo35P1vpybplJJ7hidrsLW9n+J2mHRssh62Bi2Wd7kYIHNurRgrcl6vx2VCgOG1Xnwz0fR+wV/yhsIzZDdMGd9/KhbzoE8QKKDpwqUABOIijzcxfZ9i4hbb+FvRWtN4kcSMnhtB3ld/FEdB2TBvilymoLNSDZuOHXnGWix5j5Ox9lnoEpeYTYqu6+vSy972e5eBxc6s7xrP8nU3XJv+in7r0PakB6eY4Eh3aYvdUTvR7hTJvXFkoMFKg1ZmWQ69RMa72XyrCmzdIw64/fJjNQjU/3VJG8W3vbmA6iLDg0VD0t3xgNUhnnZTgJsEPhHKZawZd04SzC7x9HLHm5MugR10rB+I0oQFQXCPYJx1tT/Is5hFEteLgzoeRoBu0xx5ZHIWikIXIdZPqESYpWl76KT4L1HSQfpsGOepltiqOxMgEbvMMVKaE8Wi35pfz3B3tzltXfCWYF7qthQVqZ8ScaZfOHGzStdrVI+FFJ9E2nE
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 17:33:26.6568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee09b38d-7447-4446-f76a-08dc4cf1add2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6748

When the NH group stats tests are currently run on a veth topology, the
HW-stats leg of each test is SKIP'ped. But kernel networking CI interprets
skips as a sign that tooling is missing, and prompts maintainer
investigation. Lack of capability to pass a test should be expressed as
XFAIL.

Selftests that require HW should normally be put in drivers/net/hw, but
doing so for the NH counter selftests would just lead to a lot of
duplicity.

So instead, introduce a helper, xfail_on_veth(), which can be used to mark
selftests that should XFAIL instead of FAILing when run on a veth topology.
On non-veth topology, they don't do anything.

Use the helper in the HW-stats part of router_mpath_nh_lib selftest.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh      | 14 ++++++++++++++
 .../net/forwarding/router_mpath_nh_lib.sh          | 12 +-----------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index cc32bf11739b..6291723580d7 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -459,6 +459,20 @@ xfail_on_slow()
 	fi
 }
 
+xfail_on_veth()
+{
+	local dev=$1; shift
+	local kind
+
+	kind=$(ip -j -d link show dev $dev |
+			jq -r '.[].linkinfo.info_kind')
+	if [[ $kind = veth ]]; then
+		FAIL_TO_XFAIL=yes "$@"
+	else
+		"$@"
+	fi
+}
+
 log_test_result()
 {
 	local test_name=$1; shift
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
index b2d2c6cecc01..2903294d8bca 100644
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
@@ -56,21 +56,12 @@ nh_stats_test_dispatch_swhw()
 	local group_id=$1; shift
 	local mz="$@"
 
-	local used
-
 	nh_stats_do_test "$what" "$nh1_id" "$nh2_id" "$group_id" \
 			 nh_stats_get "${mz[@]}"
 
-	used=$(ip -s -j -d nexthop show id $group_id |
-		   jq '.[].hw_stats.used')
-	kind=$(ip -j -d link show dev $rp11 |
-		   jq -r '.[].linkinfo.info_kind')
-	if [[ $used == true ]]; then
+	xfail_on_veth $rp11 \
 		nh_stats_do_test "HW $what" "$nh1_id" "$nh2_id" "$group_id" \
 				 nh_stats_get_hw "${mz[@]}"
-	elif [[ $kind == veth ]]; then
-		log_test_xfail "HW stats not offloaded on veth topology"
-	fi
 }
 
 nh_stats_test_dispatch()
@@ -83,7 +74,6 @@ nh_stats_test_dispatch()
 	local mz="$@"
 
 	local enabled
-	local kind
 
 	if ! ip nexthop help 2>&1 | grep -q hw_stats; then
 		log_test_skip "NH stats test: ip doesn't support HW stats"
-- 
2.43.0


