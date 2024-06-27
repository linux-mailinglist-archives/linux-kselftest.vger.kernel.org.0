Return-Path: <linux-kselftest+bounces-12865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B291A9D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78F51C22AC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 14:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C824198E70;
	Thu, 27 Jun 2024 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gC3eTjTo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CE4198A1A;
	Thu, 27 Jun 2024 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499848; cv=fail; b=ExFL6MfWQj35o8EkqXkZ1LqKNLyt3Rb/L6tAEpolsIBbyqWqrkTB9AYDdoCC55m9CGbBzjy5nTkLKLjywu0n2nTgN7imIe9Q1oo1UX2+kt/2DX471KeH20fAINmc/sJTtQAJkKJm+jxO9zEJhjB6Wq/MhREXIH8VQwSizYF2Aro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499848; c=relaxed/simple;
	bh=95QWJggfc1+MVRJg2bprzXGymzj+FlxgRnERcaWZaB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBrotBPler9FEQ/QxB7yfoxlyCKTyGQYzwmv7hDKGWhl/v3m6qyZGutTgLEudvbvjMcx1xNFM2v5ahJGVTbccozMKfnNKPsUn4lhX/AkkCVOcY/mHQh5vV1tIWISf7mLqENEnJwX0Fu86NQaa6Rqvm39nY0vxNMpPgJHJyZBHpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gC3eTjTo; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RANPbZxdt44TeiYdtpOdX0hH606mpKNfGLmHTZo45lhBJICa/oIZvYIj2su7WlEKwAAeSqOEB2plNm589/4q6M2UcpvPzQbJOv+jTXQiZpM1OSHol99I3InCghcHdX2x3uxxcA1v06SvlmXksU3RolATOSJPLLu8TFEYN71t+VQoZaMh2DDfNTVEke1e910dw8vMTVda9XtGqZPnIbMB76h4v3zBePY139ISHeg8e9PVbnSGIFondABJ/MuDn8EH0NWZ3wDkOMYfFjFrY+cDt3kD1pfnqmwxZnRHBkQ8oZp1oD87UrzDAi7lOQg4gyg39BPsnuK1AF3fE48osgkFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0714QI4kdTfxP4nDjNXsrBm81ba4vXmDfC3Tb0tH8g=;
 b=NfeLmafxlLci5BC23B7xVSBHaaWTz6SoN3OZzHXlYtoSCFrAu6DaQoj8hXnFBtDufaLoMtzMRnBX52re5XQ4b2YcY5hCAq/kQlXBdNW3INNE2YQwaOQfowSu9X54Kv+6KPyi4NSTM6TjxyxOICraZ6gBx1z/DAxGLAL21HBbYXI+iYq53RZVtqRIYGttoxIezv4AvqtWeO2sMSL7m1fR7hnBVoiPr+YGlUD0+0tWv8fmcb09hngHGrgWaleDqI0ack6ahndk4qpn32x/4twGwpmJDcCB0XQIkw/QaTgBLjBuUrMNfJy3Dth4VhvfdQ2+so2V8x5q7obghb5qNUGi5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0714QI4kdTfxP4nDjNXsrBm81ba4vXmDfC3Tb0tH8g=;
 b=gC3eTjTowaz9cWnV6BWgtjxIOWrraFLMtW1UqTOUAxsFatmoqJP4TKn0XAWmViAy+NuQ/cSe+4IVyttDRTo1fzCp9sDN1E2EeoMu3whyY0lvknIqQw6jpyknGIJyQ1pdTU2SD8iYwdyJBd+XfTqVTrSf8cCaq74V3zeo9rbVBkj0WkllF/OF8mySvNEKQDzSZuIStL/OjYKGca3W440p6RtKjMjrKrhmj95odhfbCQBgUZNyQrNij8w3IpYXPRx7o1TqZEpTYvHIboANrO+YDKsyZvFlGs+L4YZqenPO7pG5bpEcounNaXMlxVNzEekHdP8txxVafmkuWqxwAC4oCQ==
Received: from CH2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:610:20::26)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 27 Jun
 2024 14:50:37 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::52) by CH2PR07CA0013.outlook.office365.com
 (2603:10b6:610:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 14:50:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:50:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:50:17 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:50:12 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Danielle Ratson <danieller@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 09/12] selftests: mirror_gre_lag_lacp: Drop unnecessary code
Date: Thu, 27 Jun 2024 16:48:46 +0200
Message-ID: <9779daebb3b84320e5fa7c767ce9a2bf51e18a42.1719497773.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: 97aa578b-e764-4677-32b7-08dc96b88198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qp79hMkDSIqRxEeq9CxKDanN/AKsni76CKFEa3HIxORPg4vTGMnu2FJwZuMT?=
 =?us-ascii?Q?FjUzAEcrgtCBR8PyA/ILb6ZlEajbv97pf6l9KmOnOH0ptBG1yo9Gd80s/vTX?=
 =?us-ascii?Q?GWL+V6y1LDHQb0CpeD4bUe4LAgY665sur4gn+2f992wj1kiM7ua8qmhTfFRU?=
 =?us-ascii?Q?3h1JZBB10Uh0LUI3TqMu7iiVZIbTQtJU1kB5849AYuXceciseYl2OvIwqZef?=
 =?us-ascii?Q?890NLyH4qHQ7PHVEati+9jILmVgJ4frHTFCdEdLJNf/9SbXOHMlz4zepRXph?=
 =?us-ascii?Q?5JrnsEAsgn29wIPWJBpah3HwnSvkNOVR4lM6CVEQMWpGG/rHbsYXjKLS4nfv?=
 =?us-ascii?Q?pFfoJxEDOdcFEAYtgsV84zUC5aHyxDmz14iu1muUUffa7L3cRPkA/yqlQzC5?=
 =?us-ascii?Q?rSxFIbLtl4tm/7L+2xbwerXH7dk9zOTfRRyynXZ74Q/8PJo0VzHLkgsvpSmx?=
 =?us-ascii?Q?u1FIgK0sdhgFeS4sIMle40GYH7acxzULxKzxgOut8ISwQziltktZCzrzeo70?=
 =?us-ascii?Q?hLGMR/Dvp+AtqELp6d8GqFNxY/9wEbmh7rC9miygA2BW+sv26zHeLFO5pMrO?=
 =?us-ascii?Q?wDcwM4C25eBvS9bquBzlyDbQ4tsARFCaOGLXZXm2XeRNkRCyPHjf/dhXxDN4?=
 =?us-ascii?Q?eUOWe5grNMUJM5myuQQtcQ71cVVq1bhX/CAjEYg2YwwtUVB0+cMR7fefO9G5?=
 =?us-ascii?Q?9IcXAu/YmtOCmHGMU0NhbFoEGLU7U1U6jXw+GT/XgjV4+9Ywr+ameWgTOCtG?=
 =?us-ascii?Q?lYlbLkaRAARR7P1ZocMUNYUIX0yp60IPMtPaonuue8WJtSxqnQ+dp/xmJtf4?=
 =?us-ascii?Q?eOZjLfMZ628yV1KGOqBEeB3AZ2WWoqUZuh93Q8hvUlzofYEpDInXstkv8IEd?=
 =?us-ascii?Q?kUrgbgdOS07qqC4RUvB0jGkMneSFxkonGHnq+LV92kCKSDqVRfaSQ0n68p8/?=
 =?us-ascii?Q?Tw7+mg9XlCM3iU2TvilGBBICogj9x/3RV1R3M1rFIiTW6RC/DH5q1IWBCnxv?=
 =?us-ascii?Q?If2uFsM5id15IjNgQkHKyS+zDUc/q8ZzA4nGSuxVxN4SrAAYzN1cTMVwYG2V?=
 =?us-ascii?Q?vPV9wGjX4Nt8qUFcdzjwX39l1I1KCArxK201IQZJ7vrEFoNibNVV92jdTHmN?=
 =?us-ascii?Q?wTOnC1xJh1K26C0/t2p6mGppannJ0xsTubFIQYYDCbQuZsc3U1O5wKpmz0Rd?=
 =?us-ascii?Q?/TgEGbLMnpVIBdTIosqGawApEgC2gowRgxRITbRzENPypRAVrQwnh83kkg2j?=
 =?us-ascii?Q?M7RCSJnoDaKnTXRxeuvJjStQq7aBpKIKneBc6pVhwOc2aWhPeWIWWSfrgkXK?=
 =?us-ascii?Q?u47urp3/UxHSBksn7n/2NY8i11UcrnkANPjCjtOeuls1xPevYBKnZJZJX7/m?=
 =?us-ascii?Q?OIvxXiHHS4Ztm1Vo08zKzgO3tQm/WJ1A0PoIYhSNB9gZdJwgq8M8C2IgBgsd?=
 =?us-ascii?Q?ti+Qkwjzfa5EFEVtUpzsykVsqKrDr7Yl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:50:37.0589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97aa578b-e764-4677-32b7-08dc96b88198
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213

The selftest does not use functions from mirror_gre_lib, ditch the import.

It does not use arping either, so drop the require_command as well.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh b/tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh
index 1e4f0887724d..1261e6f46e34 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh
@@ -56,9 +56,6 @@ ALL_TESTS="
 NUM_NETIFS=6
 source lib.sh
 source mirror_lib.sh
-source mirror_gre_lib.sh
-
-require_command $ARPING
 
 vlan_host_create()
 {
-- 
2.45.0


