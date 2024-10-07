Return-Path: <linux-kselftest+bounces-19164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EC299333F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95561C21763
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 16:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44761DB959;
	Mon,  7 Oct 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h9JiKW0c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2321DB92E;
	Mon,  7 Oct 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318536; cv=fail; b=V06Q5V5/wNVKhyQTx3UPkliE3N5grVE1btYbXtHjnju4LuUWm/LQNOa85Iqxy+tASODXHnz9ZzbT7ZAxL+XUytJcHB6Ob8R7ErkcJPq8ctFhZRNMkCiqa7xb/0+93xVuXyQ0ZmDMrHH2u43x7BTxL/utu8kBDcE2oFBKtI9ROjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318536; c=relaxed/simple;
	bh=MYv59dkjoziianeMsXYeay0TT6SUZQsse+/RXI86AOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfYnwRLS1T34wYPOC97P+m/qg0dlZXDToUqyfrkT5SmCEUej1GKpi0x2CyOC3FpD454Jrck8bH50x6u8PK2VQosGo46WLZKaPLpf68jAGW5ZiTdUdO0j0j7/mQ5Pst4R1zgPrFxc2WBGSbuR9Rq9bV9cDpDZkdtjRTNKHSOgb5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h9JiKW0c; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UK/iBsIiqg971XcZAjnz7WgD9M4xKyVA53UkYkBtnS4UBTaDHoH+EP5P5xwWUzxqitWA7r5XM29t8Q3rw3v0AhaoG468RZ4BY3BvrxIm3BZDRejHTFoFOQTVwXhyRzDXIH+JuwmU9LoN7bpHGGlgCLB/IRCZ6B9j4Qdm7Tu0qhP8+QX9Rr65b1bJlAxhXZcCMl8rA9ndVx5XXwrkhTl3VgHHOo+UEvicb3eUG0/I7nCt6bQOAHJ52Z3slPmXDOCiz9jzSsJQIXK1aLY5BEDKOp6Im6FH5/XF59lZesnAEaRjGmOLkXfVdtyESLTmZLJv1TAuogyT9O24MCv0DWwKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JksvwnYpkQqZdxP8ANOhbgMdbERTbVHUTMV1ZA5+KeM=;
 b=XXxhZPjb/hwN7JkgMpWyFhHJQ4f4mA6PgV1yiXBH8vfuuICe5OOL4k9zeQd5Now7Qf3lX6p2ANP9658rrcy2HBwxAiPIXpexRMUbWMPdih2wehr5OMqiGe4Q58nTmR/bBNQMvaVuv+gI0hxkDidJ1ZZFCzun0PdD7BP0IyEIAT2D1UCd29dauhGBMUoag+0UIR2NPjBSmuTdvwIZQwdxULHxNFy+1NXBXFe+JOmWNczOAvQw6yJntozAjl2WfLBhp8MP5aNRIijGUxE2ptFOUuOa4hdTmr27myEcJ12dXvbnq1nWiCXgEHkIZSlqAgVrQ2K74LQgkJ+GfgloP3gsSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JksvwnYpkQqZdxP8ANOhbgMdbERTbVHUTMV1ZA5+KeM=;
 b=h9JiKW0cnH7R+lOXpipAt6zJWK86mJw8/2XDqDxgSPh+GwMrgzgNlPzaG5QmGMqkE4qz2Zq/x/RZcs/d1K3UTH+S0F8BJTE7zgBPurTcgkspnD0vR8Re7wXeSRB/s1ACINMcGcbDQzDKCWmCeUZhE0BFAc/5zkN1b9RMSymeErHlX7sCWwajeh/5I6rkSGzNEPH4FqjLUVqB+toEUd6J9nQzyJzjyT1YxNCHdWs6ZIzO/kejq9kvLOFXB23HIvY/LFBy+BvEutgcXJz0fQ0a3BHYO0z3mSwvlPAeY/Dl/lI4l0J0JUFzO07NCjaVZet+TUr9CPX8gMO1iCoPBh2aqQ==
Received: from BLAPR03CA0105.namprd03.prod.outlook.com (2603:10b6:208:32a::20)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 16:28:51 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::d7) by BLAPR03CA0105.outlook.office365.com
 (2603:10b6:208:32a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21 via Frontend
 Transport; Mon, 7 Oct 2024 16:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 16:28:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 09:28:33 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 09:28:29 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/5] selftests: mlxsw: sch_red_ets: Increase required backlog
Date: Mon, 7 Oct 2024 18:26:05 +0200
Message-ID: <0821fb3aa8bb6a6c0d3000baab04995517c9a0cc.1728316370.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: d082bb94-d3c3-456d-7932-08dce6ed20d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NEElubuhv4DwtFHYARG9c8xkWSIqSjkGoiKAtF6fEckzRKL2lcQrVund9MX1?=
 =?us-ascii?Q?L0Rmwr7QJWBH2NhQHhIK19rKl5Uo4iD1k/aoq3BfsaZypMfSgyW3W7/2icru?=
 =?us-ascii?Q?GoILfAdm2rL4F3yA82ZEuuUOB9TqTLsm7d5jKNj425cOJ3eX9ta7mcuM6IlR?=
 =?us-ascii?Q?FjVmwzoRepgXDp7X6S+z3nI/9AFmEVYJrknAK+doobp9F9Rxaz6umhciSvjM?=
 =?us-ascii?Q?R1TjhMWO7RQfh1pJI/lLbuIJKfO+amNe2DzfVv2VHomglb8uLW0adl5SH0l8?=
 =?us-ascii?Q?hbovG6OEmi5D7CB8RGjQDcWho1Y+PSfFm04zgw4er4Gfr1/FnQXjdGMAY7Yq?=
 =?us-ascii?Q?RDkxCVrsW7VdjUf1E54LypTZS+pOfJBB7Z7tGiwlkFLNegKSWFU/oHsvbnVM?=
 =?us-ascii?Q?DKvmrz6ovSHxFoWyepyVHCaigtp7VDbpiOzI+nQv5LJJdxN9wpL24ljO8MTb?=
 =?us-ascii?Q?6bQvGc7DRbw4qCvIRa8eQFhHD7UjLPxh3ja9Yoj4//bNHkCKwYiHshfvpyOh?=
 =?us-ascii?Q?qBeg2JtgnrAfrVclRUoGtMi0utNhE/cJrBOSkHuKYiNVT/wMxe60UkRyfLLq?=
 =?us-ascii?Q?uPvAEO0OKJMDSNQTDy4VNZn9VQNlTQtqS2TfgojUUS2zmhmok/NsSydwvnod?=
 =?us-ascii?Q?loZvUJxca/oUkc+A0afwdnoMNhHfl9ssGIkOT2q4z4k76xS2GWOHI2nbDPSD?=
 =?us-ascii?Q?2gKAPQJfkF6H7X0g5LLUFAYiO9SyXlbkC4D79owuBC0HMR9roRyGE5zlgOnA?=
 =?us-ascii?Q?dv0hWlG53ORVHmrP3iEmhyTrm2qsumg/HU7+FwHeof7YodoV/gV+736OHwvY?=
 =?us-ascii?Q?nKV75AZ+1cUGGdV1HLYJq88myC8deVOUPBvwUfeMaN6IynrtSjOGa6pkvNhF?=
 =?us-ascii?Q?fOQbNYx4q0P7XYfHpjSADQq22bzynFZv8e8KLTvXIZIeMlGbIuPoC6VK5zpk?=
 =?us-ascii?Q?/Fzma3diUIzKVz6TkIS9R3h56jqpA2K3lTb61YKRAdojiPPslxH5TuKNdraQ?=
 =?us-ascii?Q?IM8AMjv5nVF3fL6dY3GDswOq25+PoLGS+Hp/ahOKe+I+gLC/1GNndRKKlFuE?=
 =?us-ascii?Q?p89DsHx6302rX6l+lR5NUyJcw+69BYE8keze3ZSBf/RQwsLhXpdiwKtRHsMx?=
 =?us-ascii?Q?CZmM9MX8I3emNG5RKdcUR9Xs/7Sl9b2rQ9m3TqioDP/EN2BLo59wvBjJwW8G?=
 =?us-ascii?Q?UigK0/dlBWRONAOjJf7llUv9SbiV0uOUPfmcdXO/F6ry3aIPOwU2bkUGWn9U?=
 =?us-ascii?Q?P9sbOxwhAB7bcBfHGiMYesI1YZvQsvMLQiV3oNKnC3xDcMkseqo88q5oP5vl?=
 =?us-ascii?Q?kFGlJ51Q/92DIIK/+HjkerHMbqQHyWS8RWsVkUg0f9515DyuxLswbnDP68XS?=
 =?us-ascii?Q?0KZIRcQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:28:50.9569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d082bb94-d3c3-456d-7932-08dce6ed20d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287

Backlog fluctuates on Spectrum-4 much more than on <4. Increasing the
desired backlog seems to help, as the constant fluctuations do not overlap
into the territory where packets are marked.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
---
 tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh
index 8ecddafa79b3..576067b207a8 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh
@@ -20,8 +20,8 @@ source sch_red_core.sh
 # $BACKLOG2 are far enough not to overlap, so that we can assume that if we do
 # see (do not see) marking, it is actually due to the configuration of that one
 # TC, and not due to configuration of the other TC leaking over.
-BACKLOG1=200000
-BACKLOG2=500000
+BACKLOG1=400000
+BACKLOG2=1000000
 
 install_root_qdisc()
 {
@@ -35,7 +35,7 @@ install_qdisc_tc0()
 
 	tc qdisc add dev $swp3 parent 10:8 handle 108: red \
 	   limit 1000000 min $BACKLOG1 max $((BACKLOG1 + 1)) \
-	   probability 1.0 avpkt 8000 burst 38 "${args[@]}"
+	   probability 1.0 avpkt 8000 burst 51 "${args[@]}"
 }
 
 install_qdisc_tc1()
@@ -44,7 +44,7 @@ install_qdisc_tc1()
 
 	tc qdisc add dev $swp3 parent 10:7 handle 107: red \
 	   limit 1000000 min $BACKLOG2 max $((BACKLOG2 + 1)) \
-	   probability 1.0 avpkt 8000 burst 63 "${args[@]}"
+	   probability 1.0 avpkt 8000 burst 126 "${args[@]}"
 }
 
 install_qdisc()
-- 
2.45.0


