Return-Path: <linux-kselftest+bounces-19166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFBC993346
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 366BEB2667B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEF01DB52D;
	Mon,  7 Oct 2024 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DQ0p76g8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D741DB378;
	Mon,  7 Oct 2024 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318547; cv=fail; b=IUDl7AUHj+DvtFmTqZ8Phk6aVQg6NRLT3fHTX7Sr8s+BMluCs7idw2y8BKhqx9aXnmb+oDEvrOyIb2FisWebNA64pe9r4DPxC/jGBcB05DlgkpNYWZuHUZVeSM4BMDaFLD1fP7kYA3NeEjpsi7KCM3pL/TnkID+FyDFEP5yN3+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318547; c=relaxed/simple;
	bh=CejQ5fR3tewGYyf3yY6A6HPDBCFaB3tf4rQkJydCQho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/pS5Wl/JDONkmfs4Cki3bvYURZyASlPrbMLdc3PsNENMUJdQJbPpYbpz9jQZdkHqD4Vs5//iX0hRbcxzFLiVxksJCP3qm5ZBBlH7c5vy5rLK+T+j323fDCUCMh7wbFt6u3i9iPU/57aJdZTUKpVr+pkv9ASK52YLID/dlky3so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DQ0p76g8; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOkloP18kchtBseH91iRVZvNJFkVmtQIqEGk5DaExsTQs4BPN82Of4NrD+vobbA+qRqX7yFtML8F6AQ/pBp2lsEdpDpYiBYHycGGR+a6t/4in4VDOTICi1tAlOBU0dzctq3VYinseLiPV3jMc+uO4FLUvJVAkwjJvjFRoavaCJQpNRBG15OjjgPicE93NHgEmrb+LuuiHOsdzllYHV0oj9tlCfNR2FIkZFn6quD3aRZXj+e3L+IzQgEKvlOlyThz38BV+HcmKCsRLZg3PDTjn99D1afluPn7wAsnkKwJrGUBYlG4Qc1J6WJo4vtXH6N/5i4gBYMT9AonFIktHB/Peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHPKeTu7TWkxAaRcGkQGbmIAZqux0w27Z5XzMEZ3KRQ=;
 b=SBgfcqzQzJKC5MDCbluMdlcPmObZnkR86+BDFLF59kM4TbDQ724zbDQr8Q/JozKAg5WqK37C3uJ3tTNMInaguhl/Ie3P7ucu03kXQ/Tqem2aWEKSDx65xBw+ekitPcjVIUsyhr9qDYsDs8gZSnoyFui7uD5n6nd2rpHxyvSgPFtbjehZouIMsmyNx2yrCNgjgQQ4X+e7E01D4wlUtTmeDg8rlmMqdPQ06XCNmdHtQZdKEsGhPc559h7cQJlq8y1uPNfRlgG8viescKWCkhBZxSVeXQTPdqlxSFPdqxPu/2jN1EDcJzn0LEg73dJGgFi9zIm8dLJ4Go5Fnuop6me0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHPKeTu7TWkxAaRcGkQGbmIAZqux0w27Z5XzMEZ3KRQ=;
 b=DQ0p76g8WQHWrYBrPloB+sclZXRkTn98F1q9YEAsDt1d1kJnrdp+/GYiM38lFkQfqkO3FA2y3cx2KWlULyJyhnVBKCrREEpp69JfP3xK63Bctap+9oH/JjsDr5Nik3e9VV2HW1BP0DAXgV07wkZUoAxR24eIeYNkRzhGf85Te0ozIMqjqXlyX3rtZFzDqxv2sT+1O4cycATX0uD0LqfJPeVNliyPcJsJwZs9pD0U4lJWyLZvCb7cTjLnQzZClOE0Jge+krcrwEDzwW95gZnkSKavqXKrkZs0IbmA2z0bqJv+SvY1QCnyUpIR1lvSwHEGcixk2F6A44zN2TLYSOcX6g==
Received: from MN2PR02CA0006.namprd02.prod.outlook.com (2603:10b6:208:fc::19)
 by PH7PR12MB6933.namprd12.prod.outlook.com (2603:10b6:510:1b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 16:29:00 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:fc:cafe::d8) by MN2PR02CA0006.outlook.office365.com
 (2603:10b6:208:fc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 16:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 16:28:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 09:28:43 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 09:28:38 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 3/5] selftests: mlxsw: sch_red_core: Sleep before querying queue depth
Date: Mon, 7 Oct 2024 18:26:07 +0200
Message-ID: <321dcf8b3e9a1f0766429c8cf3e3f1746f1bc375.1728316370.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728316370.git.petrm@nvidia.com>
References: <cover.1728316370.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|PH7PR12MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: 40bb49ec-3351-41ef-0e63-08dce6ed259a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xRfk51OvHEmFe0IPxD3qGpeNG6/AsCdmQkqv7ew7vQ3kYLH4FOh2BxZFbu5n?=
 =?us-ascii?Q?cGjJTi5YDKCrFinFvWlFrt+tZxhppwvYmy+Fyo5VVIcAl4OmZgjIy0ldcu5G?=
 =?us-ascii?Q?vAxFSbNBjwwIQJH8QSWdSvJ9flatX+weQwigKtzTL9nGW1eCobnleaQJAkSw?=
 =?us-ascii?Q?L+5endj90PE4MurF4HHHMJWKPw+FMQjc9e7xk0KIcEO7kMrPkBzdCJzZDviD?=
 =?us-ascii?Q?mZTSwvMHpg7FqOMK7Gw5tUHzrJwQ47PCw+x21gKrrCxY04Rf0ISJbdobe0Ii?=
 =?us-ascii?Q?uOnhq/8zS1Mq67ACihLaH9ElVJwIvBsPfDiyD8ngtm3LySIAA41dSntFGglo?=
 =?us-ascii?Q?1nqs1vt1tdWhXObjzF4aXlRoDMohFU7u2zBmfhD4rXSYHcaJXxvak/kzwvTR?=
 =?us-ascii?Q?zKNh+BEKYdbQLyHEoUQsmW8Gap7sUkPvvQFLmtndOwxH6KE3+ao0SGyujt/u?=
 =?us-ascii?Q?/i/mepwOrE5PGWo2FUNtIctIcPOYCetTNYhGc30L67ydVc8bnLeRrKTnWbjc?=
 =?us-ascii?Q?J4KQfJn0sZgINJCuv+QAfIeLvsY3N5xtwVfINCFLAm8Ew9azusFSj+BhT0FV?=
 =?us-ascii?Q?KMoD8uOLqzAkEXZ2+rjML+b5nCj7OQcp9eyqOlHrVgKPfFckSc569Agd6pVg?=
 =?us-ascii?Q?9qb7kwjCJRulwHjyHnALSFUdbNu8JtC9r/eKh127pKGA28tC/dk4ePWppbU2?=
 =?us-ascii?Q?JxVu8+nqf9TG6/dCm9uSdCD5FDm0iHu2ZbVS31tPHZ/0NYPK8b2UyoJPMrc5?=
 =?us-ascii?Q?9rlEtkzg9N0N5y/u04posrtCR7N60XaA/4ZRQHuS6zqe3TS6Xligh8RX0yS9?=
 =?us-ascii?Q?gWTt5oh2WUy1lAg2PzQvyJCeJqI7RvN6EChMoqrRJp35HctA67Wy51aN8dSa?=
 =?us-ascii?Q?tvuS10Sy0VHPyO0EFheR2k7Fn1C3F8khP0WrDFMcrpK7J+GHfMWXsZFv1NZd?=
 =?us-ascii?Q?ikTcv1l5D44r6ta9tUt0gVyK/Cp1rCtGURaFd+cLV95vqAt26TxFSDgCrXdR?=
 =?us-ascii?Q?7iCUuYhbAaRFOX0GURAw5YZZ34MoDB0FHgtQODcnej6oi1sWOM6Dtur3rpwH?=
 =?us-ascii?Q?OS8aeCeZsfuaMmxeiPLy9rP5005CVn3eMG6QC3nq4El/WtBInmrvY+YjWoPA?=
 =?us-ascii?Q?zqRrZLMkZpkr58jNU72i01pF/sjyX47pE1y0NEnmdVD97ApwzpEYlbbebNso?=
 =?us-ascii?Q?+LIpg0wBYOTeIAzaPnnvqBsTqfZtOLshS7BnCqwKeUSEOEBv6WSj7E4i6IYY?=
 =?us-ascii?Q?T4dT/pf1wEgtn0q5uLoiBvI84ywWCPvieFt7lMkuxwHjgPWWXKLYLYcMJApO?=
 =?us-ascii?Q?HyHmDKgJeuA6xpRj1bpqHHHD3YAeL41q2tz19yZYDakVYxAd34at2AOd+SpB?=
 =?us-ascii?Q?1XSkYvo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:28:59.0071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bb49ec-3351-41ef-0e63-08dce6ed259a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6933

The qdisc stats are taken from the port's periodic HW stats, which are
updated once a second. We try to accommodate the latency by using busywait
in build_backlog().

The issue in that seems to be that when do_mark_test() builds the backlog,
it makes the decision whether to send more packets based on the first
instance of the queue depth stat exceeding the current value, when in fact
more traffic is on the way and the queue depth would increase further. This
leads to failures in TC 1 of mark-mirror test, where we see the following
failure:

TEST: TC 0: marked packets mirror'd                                 [ OK ]
TEST: TC 1: marked packets mirror'd                                 [FAIL]
        Spurious packets (1680 -> 2290) observed without buffer pressure

Fix by waiting for the full second before reading the queue depth for the
first time, to make sure it reflects all in-flight traffic.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
---
 tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
index a25a15eb6d31..b1ff395b3880 100644
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
@@ -372,6 +372,7 @@ build_backlog()
 	local i=0
 
 	while :; do
+		sleep 1
 		local cur=$(busywait 1100 until_counter_is "> $cur" \
 					    get_qdisc_backlog $vlan)
 		local diff=$((size - cur))
-- 
2.45.0


