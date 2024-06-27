Return-Path: <linux-kselftest+bounces-12859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C349491A9CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82C21C22B1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 14:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF9519922E;
	Thu, 27 Jun 2024 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jSJMWNQc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC273197A76;
	Thu, 27 Jun 2024 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499808; cv=fail; b=KyzMyjZGGbbhP7ugrGSh1iflSaSr2JAlhWrIfn5Z1pbhVRb1UB55hqYDoLBKdoj8czjboMAD1wh/8xN+Pxx4Ho1UlxdMUh1ms4V5fiP3z6jCWItcYfOktZEk9QyyvZXEetklRcxkrjqyVZKxPd+G2NBEGdG7HykDGgyrx4Q1k6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499808; c=relaxed/simple;
	bh=IBt53dQFWK0fsTlitBdBN5neeAw9SH3yL0E2ZGMCtjU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yg5h0zDLKMsajcX009oR+3+S0aSmU5/Uh8G+9tdQcN7bOC2+ZXmVCLMao6SJtnFIp2k+LGDvcQtuaORahdxjyDnD4oCiOtRj9gMU0fH+i4Aux9BQsSisjRGQqeAfiEHh3T56PFTNDHa3ZXr3hB4qQ8P5uW6T4BqZM81EuELgyh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jSJMWNQc; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+JwcJCshiRjVTxouNECLyE+bKLLlYg3/kW+S6MwNHj48ZXbs6PyRyIXXSjxhzWidAueXxAK2+vkdSfuDl4GcupEugp9uoaitD3Ywz5wiCVBX/jGuGa332mmY/N2gbGl1uVA+avQFSAZPAcbGFvZkYYQ95mbfBH74oaJLBx9+zrNX8VVYtXhn1oF1cIpdf9OyKvbobBNICWJGKLi7pEPCXw3ppqQBWuZzqRg9ysxgr4EpOfOjym+EA3NzlfM2/ou0s/e793HfLPCz1auoDv4ZT/0aoqNmnAW+02K8Wj/gN0m1cBIP4jtHll4qPKC3X/oF34qNfXpG4ey8pLMua7nbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHyemR1XBxjhoD+uljJx6z1V9I0KMA+YMdoU67P2a5M=;
 b=Y2a7ShWP5MpvMc+yKHPqE+T7qRtlVK3XZbP0G+s/Ms/JIXcJwx1QMQudB+1trcsHQYQJFHZrB24KeZtQeOkVdI9Zxis2mdfckpZWIuwBwOVg91Nk07a5Q2Wrw6XS46Z4c1NpM+PFvx0tcvWnG2XMhDU4KceXs1VZicBvBq2IwZQnaKJ/RoT029IAZgu4aV73p37tpDJ9obfJ418wONw6DmRd5V8NIYHtBIV4M8YgyT7ZcrDlRTWB4MafbRbGHWTkdaaHTv2kgSj/PfljPdG6HLZE3sPdUCW2GGXPbMOsfmQtM7+M35IAjrpNbX9K3BZPrQcI2krDYIWZ8ZPT91uaZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHyemR1XBxjhoD+uljJx6z1V9I0KMA+YMdoU67P2a5M=;
 b=jSJMWNQcSYAjkUeirualxQktQnGhLAZtnU6MgcicvY0ChRkdJx2vpilA73gPKW5q/ZPkUtHpn9lkcgNc86TeLOUv3nze5ZHeVUYKmvUPIRo984C992fkGxVPVSv1HDadCI8Ww2LIdPKQh7k3xlgDQGz1HJVZTjydkMuxGZSQ6zy00Nbt7GX5wU+Asnp2+y5X4LmiBklzFxMzkYVYyd4G1DaygV2KujwnDknlpQq6BMMNtbH5/YtEtDbLFuBPPrN0TGiDNxBZJwtHivcAE19xBiPa1QEI2iCaBIJa5b2rEklS3IQuyTdZ6TmDocNdto480uyUgAm0iqPTXCVhXJRlCw==
Received: from BY5PR16CA0010.namprd16.prod.outlook.com (2603:10b6:a03:1a0::23)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 14:49:57 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::7) by BY5PR16CA0010.outlook.office365.com
 (2603:10b6:a03:1a0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.20 via Frontend
 Transport; Thu, 27 Jun 2024 14:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:49:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:49:42 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:49:37 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Danielle Ratson <danieller@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 03/12] selftests: lib: tc_rule_stats_get(): Move default to argument definition
Date: Thu, 27 Jun 2024 16:48:40 +0200
Message-ID: <18d1da8cf474d76e7934d06c546a22e6561392b3.1719497773.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: fba73336-6792-40df-faf2-08dc96b86a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dw2oYCJCus6XPVM0L0el63ltScoQyuBhcMijOgBb99e1iTueoT1JAW56M++M?=
 =?us-ascii?Q?W+fDsZg+teaHpMl8JWlbx6jWLMcaO8380htFRECrTjmMO70xlcofa5c7kXF6?=
 =?us-ascii?Q?zlWcl3bhcDT6MQ2Qh7t8c6SvhUQoh871UF75kShv7uIBCq8yqAyFRJMM8QHY?=
 =?us-ascii?Q?z/S7SnYn2BSvkhMTCa13Jv6on9YX4fyV/xEBXLL4hmCX9P6opwfYuyAqMDbq?=
 =?us-ascii?Q?eUinaaJEPidbXNzkWnFix48FDK3gzgUcBgEr/fO3WIzMHGQdEftiyiS1G9j1?=
 =?us-ascii?Q?tF3GHx9Slqhb+TCyuEmIBL4QNMpHe0oD7K0COzUPP9PlIz/9pBoOnbJh3pdr?=
 =?us-ascii?Q?tbk0uqLAS9sEr9Mo9XPDyx2q3bgzqYqhdSLRRNtDQYUXKcjfb+uAHU2lsG0n?=
 =?us-ascii?Q?RDTneKf7BUTACijENQLIaVLgaoVFDFDoAag71p5LXDScMuOrMbtTnBHyhjCI?=
 =?us-ascii?Q?nDoSIdhXX4F9eYomqg06vXai/KoHtQMy0ctvubnI5954JJ1KU7EW5v/Zng5d?=
 =?us-ascii?Q?mHy/eM+FtnGHmSHGpJakNyANW2RU/0T7FS74av8PDGq4vuWUCLNj22Oup7k5?=
 =?us-ascii?Q?dqyZl/4odAUXzNyRx6OBZEUS2KhkSPBjikm6hjXsUNIBASkVU/WcnCaQM8L4?=
 =?us-ascii?Q?xopR638jaZESjSeyxQw01mGz4zVkC7bv1YlQxbOlHR3SZxIZPE4G7xCZa6YZ?=
 =?us-ascii?Q?M1tljghC7vwLuZDzI3nPEg5M1hj6j4p45iRu8C/aYdicwSWfnWH5HJPosvXW?=
 =?us-ascii?Q?EmBZP2E81XbIG0eQH4j+Bbx/VnUBo6qssFjdeW/7FzBDm5j/+FCJbFua6Xc6?=
 =?us-ascii?Q?1V0qtAQU+8bgMcm7Uj8eO7uPmTwub+hRED6kidb1DRJ5ck89kngJ+RgT1Hex?=
 =?us-ascii?Q?QEKFobDW65SjDDiLyeKuSyv3g5sVqdAu19DB3ELMnTMh2WXfo+gY1bHSodqb?=
 =?us-ascii?Q?o92iehcwM+6yU41GTSBqTHlzJOfD+wBCKblnVQqd4xdNl3UA+pQDwOcm+Y45?=
 =?us-ascii?Q?smR4MpOTcla8Ys4wnFOMeHl6ozLBDQsO1vgzxdw7LpBZ7O74D2r3P/cydbJl?=
 =?us-ascii?Q?TqeGbMmQyFq+mRPgnLR3QS1AWGopkEkFk56cNMWryY6WMrSrIfqgvC3t3lDC?=
 =?us-ascii?Q?qk/evij0ORH6nbQdPQ+VYFPX9XiHDOg8EjDO7213YGIe5HOjkuadnoI+nbUJ?=
 =?us-ascii?Q?owrolyxXDHglAi80W01g3r8ENCkkSjWL8CZTxbMOGeAYSO9gGh8UVB08RC+J?=
 =?us-ascii?Q?V6ltxewLl3DY04QbgoeZavdv49/BDB9hAEIklY+MsuaNSyB4mmEV/HyRWahu?=
 =?us-ascii?Q?lNP+oD7DLQPHPiYtgHHZEIrY1B2T/OJWUP2AJa0eqc/OFXiFJEpVdcqSwzsW?=
 =?us-ascii?Q?0L3tnPmZXD9rWp3M9HRVsOcAvV22+hLvbm3hGNYSHtHOQU8KVvgryZOtVNJZ?=
 =?us-ascii?Q?hxGst6i4nIcTlPSlyEODic5Jj4UZ+jn5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:49:57.7651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fba73336-6792-40df-faf2-08dc96b86a16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914

The argument $dir has a fallback value of "ingress". Move the fallback from
the usage site to the argument definition block to make the fact clearer.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 tools/testing/selftests/net/lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 915f319bcc8b..d0219032f773 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -199,10 +199,10 @@ tc_rule_stats_get()
 {
 	local dev=$1; shift
 	local pref=$1; shift
-	local dir=$1; shift
+	local dir=${1:-ingress}; shift
 	local selector=${1:-.packets}; shift
 
-	tc -j -s filter show dev $dev ${dir:-ingress} pref $pref \
+	tc -j -s filter show dev $dev $dir pref $pref \
 	    | jq ".[1].options.actions[].stats$selector"
 }
 
-- 
2.45.0


