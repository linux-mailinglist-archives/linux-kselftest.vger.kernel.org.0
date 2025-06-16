Return-Path: <linux-kselftest+bounces-35150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF79ADBD2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 00:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC4EF7A10A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 22:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E4F2248BA;
	Mon, 16 Jun 2025 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="orLzvRyK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9ED221275;
	Mon, 16 Jun 2025 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750114006; cv=fail; b=uTZ5RiwZNsrdjLLltipvIU5STARBlK7P9iOx3PCLI3KpbdKx/kzjfIY/rti9xNUb4l2NgoDl/0D+266u2eGIvtqVwEu5r+CY1UfszTwfqA4vxvhN9cI+Va0rWSsl1VNv0svqFgu5XaMHVBmfqeEwaJ1pGvTSMjSHoPx5K/FTuT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750114006; c=relaxed/simple;
	bh=zGRWI1rSaudgHaYVIViIGMa8JCS16ouTXh1bURlO6/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtXKiU3H1Hr1DuAAsnlcbTpUib1dyQejgFNgrh+YM8JhU3iCkYVhv2dLO8K4iXShekK+pKCwsb+pf2DTeVsD5d+vnNaSCqVUAMDyC2nmsiaE1p72oBFimmatrINK30XkYyiDaBaYeAGtH5sO/T79Um6KRO5/SzRLDuom8NZVMBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=orLzvRyK; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTUsuEhOG2j4nSK6XBQBAg0IrxTGa20HbE10jUo2fP8BMNHC9aoCLS39udpCEmi+iAJG1MlRhIB5CWBuI08un0Pc4hTGi7p7mPRxRRzU40+/BXTtTZ4Zohi21yOr1ZiAHC+rcW4i0L7j56Go80djNut0ViHmHzgLt2tv/1zMt24TEC+zkmG8tlHGevz5ALTr2jafMGBB1abWp5osoIhOHIKJPAc7wbsqnWNz1vEMXAdQ1nZfN9VdmCEW8e7CdlREh8Gj5luHXiS0hDw+vKpxtVLY2EbEPyqKasShzxrKdjRKy3uX800np23Kk09IYTe0p/JoPbTTndlW5RWqSGtzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FFsb81HdZQwFpZHUhMo3H8t+CzLSd2RnMvxjTvdaFg=;
 b=HZajFCmzRPk+4hJWklYqq1B1dCkTxFXj7pyofooiBApSk59SI13Idxo6pBC+suQgvd/eiCmceHiTap+MglIFtexgTLqMxUAnCVOjDbqQN2ueEbJ8zbz/zy46iZKKApv/mwYwYUry7PAbPlm37cRohYv1E/LMcGvcUZr7R3jFt7t1/oTim1Yg7vTTSkl2ZHTMYALg7dh1th/llCbfG5cR3+czBdBDNlWFS1S7qyqPyPYX+8KdZSqMUAnOLWa6dY+AKEAqWrn0L+SFl15t/I65UZ+kvx1tDwirGLX47W7R84lTIPkufIzuF5h6gxr/3yVCp7fT4406jhnA+axvkflxHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FFsb81HdZQwFpZHUhMo3H8t+CzLSd2RnMvxjTvdaFg=;
 b=orLzvRyKM9DiEjtIbnHqIUGJqXTQCRss2x2ASyBXsNLKrUjJ1EwBwg8iADiRyl7B/YjyDaPl3ajuQDklivot8m1A7XRwlZmeAajtOsDhZa6Co9uv8BE0eYvCPJM3Ktr/UHxM4GzU6j6J3eZEnCccLQQPY2rk7iEVWmKrgW8YNX8shp0d1J8rsm8ulhZ2ru0TqzQ3mGb2qqQO6vue6EFqvC/ER/AMDnOtEE9akStd4xk9Bv4r2il2Bsr3GvrJBSEkeIq9gPcco21bEp9th+J3egGMxk6L+l0Nc2fibKWuepN21o0g2g0q7J4Gv5S2lFL1R4svnD8qajGtK3JGPrKSUA==
Received: from CH2PR11CA0003.namprd11.prod.outlook.com (2603:10b6:610:54::13)
 by CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 22:46:37 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:54:cafe::4d) by CH2PR11CA0003.outlook.office365.com
 (2603:10b6:610:54::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 22:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.0 via Frontend Transport; Mon, 16 Jun 2025 22:46:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 15:46:22 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 15:46:14 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v3 13/15] selftests: net: lib: Add ip_link_has_flag()
Date: Tue, 17 Jun 2025 00:44:21 +0200
Message-ID: <e1eb174a411f9d24735d095984c731d1d4a5a592.1750113335.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750113335.git.petrm@nvidia.com>
References: <cover.1750113335.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|CY8PR12MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6ce8d6-2a46-434c-c1b4-08ddad27a68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p9rt5Wrmu3xGM8bVW090Y+fbPl8xtFmQivmv/vbXgubZkj9sZEgzjio34wXK?=
 =?us-ascii?Q?R5w/+11BE9/nqmHExgxvI9MopuUBrqvh/Cx1mxkRl88j5btFqyK3CXC2MWS2?=
 =?us-ascii?Q?C+AvANeBU6mMzj/gdKuvmMW3KKb/Bc5JAJMhpAtiUos3ZaKLGcs4BclBCp1t?=
 =?us-ascii?Q?RxsTVxkah0Mae/dtl71NpaGbwYtxgXK4QxsEVFAcHxTsUpPJKicuN42Sl7a8?=
 =?us-ascii?Q?kKQvp9Z7kRpEOPIV/cXyfddZ9q9SAfXQn970+QFSYaicHsNZFSfo/vVnIhZZ?=
 =?us-ascii?Q?Ghtse/aPb6FU9J/niK6GVBSaagLqKNRm8IPCxIDjKfGN4h8idFXZk2ZIK/5O?=
 =?us-ascii?Q?kdZor8bceuLOL18MDGaTDPBq54s4vWKNpBeTpFrunrwn8C1Uvpe0GkrHoHRE?=
 =?us-ascii?Q?bdiwHm+3+5GImdat1nf9ggLQyiuSPgIfw/HKZT02FYdcs2L7ZulWgKEndpgO?=
 =?us-ascii?Q?iIjqFrmCkyZeoXLXyRtnHuQznyX4K5wr5zSpa3pdhiWLyGpr4vkrPJPhcZK5?=
 =?us-ascii?Q?uSvUHtGomxHvN8+KTNYfEL8CfctSOo93UXEnqY1cmeTgfJdxVI07Yitnml1i?=
 =?us-ascii?Q?+e6Uq8ucIdjFWeewm06obVl90iAM1nJ65vVKJH9fph9fwdLw6Cs7mxmZqmh8?=
 =?us-ascii?Q?1fEgxIFxP6OA/JYk3iY1W5d3IZULSM74x+opeIDgmDT0r7TJVGQXZ0UioJO7?=
 =?us-ascii?Q?CjwfQyTB6OALxb8gDYOFcI3p6zRUzUc4mILNobvi+pUbHoWSxcpLr6EfDOEv?=
 =?us-ascii?Q?HvvqNLnedxAPEaYWL+hiqbbnCIyX5IEVoZJh4gqQ1l4nxIIg4aO4lP9yy79x?=
 =?us-ascii?Q?MuZetjXnBKd6T+ZN73PAmxUcPU8Haq66yQvhfbZFV4jR1MWPGWlV1aYe54Ki?=
 =?us-ascii?Q?5gu23JrFqaGsXj/EJC8RGijXAPvnV/gGmU4DxACU77vr5GCxGK4pD4B+aAj+?=
 =?us-ascii?Q?hZ1EsEQkhDpCjay4wmjqAzjxRmYBgJXQvQSPFlE6lm1sN215+2LMDF5+LcTB?=
 =?us-ascii?Q?TMWlwkxdoh+nC6R5+x2l7nkQq0aQTfQpJh4IDM5m44EkGJH407eE+l2QdiUF?=
 =?us-ascii?Q?Hn8OShnIxyt/h8zGlVs4jM7p3TQj2SxKGBAz2L+FWExufwCSQ1KwMyBQ45vi?=
 =?us-ascii?Q?yCRBkUfSE+/1cRBus2O43jQOniiNFK5IA4zs6UG/cQqHwvVzVBMtIKYvt8VQ?=
 =?us-ascii?Q?+DLNiC9kGo8ekSpOfcC+eCMUHh/9MGiZ+LrjtdDO0dm1F2j3LfbhX+0fIB8k?=
 =?us-ascii?Q?uHkvV0Nmm9USeQYklZOrzsw1Vdpnl1OhAKYxmh0gLxsFJg5CY3THMGtLYHJL?=
 =?us-ascii?Q?cm4Kcmr1jvDnMhWopNGYhrl5E0SYw8Y9p+PO34+89uYwLhHn+4CbC0h7TT/x?=
 =?us-ascii?Q?l9I/U2cl+p28MtFMyBRtH0JJwaywuXlPdvWh8UHgvAtxwVo+AFV17ccrnBBb?=
 =?us-ascii?Q?/BaCKPgp7xtqfOvgv57eXSsqkK8/nK7GoKbXiaN4JJQjsHEX2SM22Q5/18/w?=
 =?us-ascii?Q?BMilxZgRYOV+nQ9IIFnr/hAa61CVr8qXov5/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:46:36.4607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6ce8d6-2a46-434c-c1b4-08ddad27a68a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490

Add a helper to determine whether a given netdevice has a given flag.

Rewrite ip_link_is_up() in terms of the new helper.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/lib.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 006fdadcc4b9..ff0dbe23e8e0 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -547,13 +547,19 @@ ip_link_set_addr()
 	defer ip link set dev "$name" address "$old_addr"
 }
 
-ip_link_is_up()
+ip_link_has_flag()
 {
 	local name=$1; shift
+	local flag=$1; shift
 
 	local state=$(ip -j link show "$name" |
-		      jq -r '(.[].flags[] | select(. == "UP")) // "DOWN"')
-	[[ $state == "UP" ]]
+		      jq --arg flag "$flag" 'any(.[].flags.[]; . == $flag)')
+	[[ $state == true ]]
+}
+
+ip_link_is_up()
+{
+	ip_link_has_flag "$1" UP
 }
 
 ip_link_set_up()
-- 
2.49.0


