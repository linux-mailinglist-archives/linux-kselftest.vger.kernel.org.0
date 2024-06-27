Return-Path: <linux-kselftest+bounces-12863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1482991A9D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861FD1F226A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA063198A29;
	Thu, 27 Jun 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sF8hLz0P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6E199240;
	Thu, 27 Jun 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499835; cv=fail; b=H9hllQJE8yfoxXI1pMSa0Us1S0ulTa29/NzUMZRV5cuLqR+kM1O6vUrKvJnpnl5zN9kCb88Skmy96fim5bvL6LaWmWgaT1ug1rO3y8swhRlesLwnXMGkkBYciDQue0dM0tZCAbQMod1uaSLsNn5q0uGa7VrXHU8GPYgKS9fV9zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499835; c=relaxed/simple;
	bh=6AScj6W+fnSZEJFWnrMEwtgF29LpByLPRMcn0e8QKbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyGwAshvNLOyQmYIflUYqBdCdZ7fWvQuYib8sQzD0nOL7h12aAuQ9s+mTxyw1kQqyaHCJ2iXxuVbjCsPFJaT8xkzKzZLATz1D3Fp2wCohsDzazLraDRFyHIIaree2wh3m61beIj6iYuah1z/HKr9Rlh08ajTLCx3mQCk05rAAH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sF8hLz0P; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yezexam3KTejNJSiilHWHbEYSWBsvfkjslV7QF6cZfNSSQp/4EprdN4mvvg1JJkGXy/nedS5TVB0NgJUN8NIxBgWjThPcFN0rYOXn2crN8UJabkcSNiRUgPURo5cI8skvOdytNOY7cinzpzKuL2DWgPyIM7uj/H+GSk4o0q91vKKiAFU423mpJmhsNNi7dVqW5Yr+wT8la2l0fvzl7cN0yAmvlq72E3vNxHJjCnUM9SAaBGjOCDAvUsyoMFo5hlPZXUx3zQslWO8lHTVjUh8uo5qpE44Ze6MOfsPnvXH4HB+MwKG91rk1vDyBI4w3DezfIwFIsG+W58JSSyNed5jag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNRvR5Iv7INnN/fS8zZ0uOIGcQ414ESGwBYcW/MQ2lg=;
 b=By/gORN6UpbRrryudWwJORVY2pJ3QCVBFgLplK1oK4q7SVfB2lHW+h4veIwEy1rBJpD8r1zu6DnqNiu52QcoZfETssjwIK373DVKiloaugIZCGgF8MFjDSYLD+ukC8S7vODbJtHM+ITPcdo+XxcsTkmLxZtmEDiO64EQxnwPBxNt2RZBNX266m5iobBQm2GSRrZm8S6ybE21mxrS14RSksR0n4rMR24DtHMYCklK0wFIzSpj9v34UnfW9JOk+dD1V5KaMbKLT5eqqwyHk4CiBryurD/V/A9yvcaTXHooDtOFVTt/VBM2oAY2gfJky26Y/+k4nESv4Aqjq0Bkg9BdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNRvR5Iv7INnN/fS8zZ0uOIGcQ414ESGwBYcW/MQ2lg=;
 b=sF8hLz0PMmHlu5oCYIvbMBNP8RZYYncf74LsRBEEWPQAIdUfYrbNwstSI3I6QiP6mjMmPny1vdkp8twbP1K1isDyovvfiXLyP0besb6H4sveZnmMQ1kDFCdbY+vBSgHkH3yboM8+xRWd+hmYdzlIZKnXPPl9l7fUt+rTIPXuxlY8VALLsPUMSX3oj9lykvwhcnQh7f90UTEAbTZNxgTBi/UwrXL2QPNzh8ca6c7+BWCsQLtZ/jjmtvPJNNQfSK5G1HzRsrJFasL8kLmAq/6Y9Phvf0DDGd6ZhLVz6ce6Nj5/QES4G+U6ndDZ8OY4+vuDWIxxeu5Q62p5m9lv5b3vJA==
Received: from CH0PR03CA0112.namprd03.prod.outlook.com (2603:10b6:610:cd::27)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.33; Thu, 27 Jun
 2024 14:50:31 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::2a) by CH0PR03CA0112.outlook.office365.com
 (2603:10b6:610:cd::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 14:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:50:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:50:11 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:50:06 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Danielle Ratson <danieller@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 08/12] selftests: mlxsw: mirror_gre: Simplify
Date: Thu, 27 Jun 2024 16:48:45 +0200
Message-ID: <218b4ba7961a0f26e1dcadf0a8eb93468542552a.1719497773.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: ada6a732-830d-4247-7f70-08dc96b87e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2rE6mCMvI3+J+ZzXA4k0lgfkexts2qcBuBvCeegBUXs+9S15zeev7P2FFZwM?=
 =?us-ascii?Q?E5mEDcI/YquB3RulwHJwx39+i4oSKXj5NwEXZkV4LW53bw5qJWE+TjJ31icv?=
 =?us-ascii?Q?RJBil6B/QixT8Oa/y1U/azTTZ+twTFJFXaRVCkD53nypRn35Pc0Csn0b4Ogu?=
 =?us-ascii?Q?urlKvV9H2j56OwSIHfhgOgXRW9KpWAr6tZyYaAD18dXT7AZ7HgkaAbL0QIQf?=
 =?us-ascii?Q?k7hNV0cYtIurOIpAhF6pbkUu4Gd7Do8YoVczxrhU2aOfIjPYxOM2bAymOtrb?=
 =?us-ascii?Q?/7rYaI64SKUx2XqK5Bc9np7kR5YObV/jkwiLE+xk2U3vQhvWHcKrUvnEv/Op?=
 =?us-ascii?Q?VGD0itJnAKb42/coY8AjYUKIcwcG22g5J/AWlfpJsHvanEEGT99XA8JTKGxF?=
 =?us-ascii?Q?R2lKivpLNbiGIuN/P7lQWKw59XNhJgS/+kLlWFfE3z2cWcmenbqpscT1neDa?=
 =?us-ascii?Q?e0PtmoxBupLQHuuSv4x+ea66j0AIR93ULBDjPdwe/9mZEusnT4nmAV8nMYKX?=
 =?us-ascii?Q?Kv8R0mcYZqZWLqtoru+wOgUE54AcjSo5h+wG56Z/4DOmjkNUVyR7zTPbQERE?=
 =?us-ascii?Q?Fekt6MNrQYk67vl8D87+oXo13pPGsMmrMA85/K86Eoc8PimM/fso19Yjn6fO?=
 =?us-ascii?Q?UwtMq33Al84fe5GS2bRaApPwYoVf/DX67HAQXLpR4JFGfzXIcn++qwlEMFlb?=
 =?us-ascii?Q?VfpA7TwLALPg3h/uQqjw4lFgP+XZO7k/53GGKuFCVXqg8HYAsl1pB1pAGDHs?=
 =?us-ascii?Q?DhZzNjoYq3hFIuHFG+SDT/vqeabrAtnj84zscL8/NhyhHtnt9nhF+Aiu043N?=
 =?us-ascii?Q?IicctFF/GB5nBRZj6kNDmIrEV1brMyPS3mIxtI+LZsEol7GrQyjxW97AWwUr?=
 =?us-ascii?Q?C6DBYen/oLUR6zkbqIPuzAaJ6jgvpIDMtPJDj8k9aE0LFAprn+SzD/ajXRWm?=
 =?us-ascii?Q?4idUvfE/m3wqxcCRSEUstQ4On9dPHnj0bDws0XPsFPKwseEPBc3tIT3eyAB0?=
 =?us-ascii?Q?pDn1ZWEUJXKxmqjxkkPox3jCvs6tVRVRhpDFj7xo3kkkfk3fvR1Ue0vrBQj7?=
 =?us-ascii?Q?2vXbK7lVdWgAgwT+ZeTAKcn8auGo2gd2KCDwLwnRWHH7FNDSc9qjKurbLGng?=
 =?us-ascii?Q?D/ZiG/bxkAOExnBweQS30JeroCK1Ea+aTs8XNV8QPHJ7GOFxGNFDPhBrA/Dx?=
 =?us-ascii?Q?nJhm81oOKaUUUeR27e4ZzmoKmceZl6EATK6NCmeby5/rm2vpxwMAjsKTtaEb?=
 =?us-ascii?Q?7THTHzOxCOiXlbwK/0pbzvPxYRPGlcuQZfyIKRAfXULYupa8V50wJFTtpxoy?=
 =?us-ascii?Q?S2sLhWhYnmsabt3HsDhcDQ05nGOYHfqZJCd/+n1zI62vYKNobS1GrdStOOgF?=
 =?us-ascii?Q?88RcZpc58JtPmnQwMqR+tiB2CV8ShwXwzg3HU96pUCIzRaL69QhKAfjyblHz?=
 =?us-ascii?Q?AnMTqQt3nak8M+sGVSd0yaCw3GQ4JwGE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:50:31.1404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ada6a732-830d-4247-7f70-08dc96b87e13
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070

After the previous patch, the function test_span_failable() is always
called with should_fail=1. Drop the argument and streamline the code.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/mirror_gre.sh   | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/mirror_gre.sh b/tools/testing/selftests/drivers/net/mlxsw/mirror_gre.sh
index 8cf06fcd724c..b9326baeb43e 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/mirror_gre.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/mirror_gre.sh
@@ -150,34 +150,27 @@ test_span_gre_tos_fixed()
 
 test_span_failable()
 {
-	local should_fail=$1; shift
 	local tundev=$1; shift
 	local what=$1; shift
 
 	RET=0
 
 	mirror_install $swp1 ingress $tundev "matchall"
-	if ((should_fail)); then
-	    fail_test_span_gre_dir  $tundev
-	else
-	    quick_test_span_gre_dir $tundev
-	fi
+	fail_test_span_gre_dir  $tundev
 	mirror_uninstall $swp1 ingress
 
-	log_test "$what: should_fail=$should_fail"
+	log_test "fail $what"
 }
 
 test_failable()
 {
-	local should_fail=$1; shift
-
-	test_span_failable $should_fail gt6-key "mirror to keyful gretap"
-	test_span_failable $should_fail gt6-soft "mirror to gretap w/ soft underlay"
+	test_span_failable gt6-key "mirror to keyful gretap"
+	test_span_failable gt6-soft "mirror to gretap w/ soft underlay"
 }
 
 test_hw()
 {
-	test_failable 1
+	test_failable
 
 	test_span_gre_tos_fixed gt4 gretap "mirror to gretap"
 	test_span_gre_tos_fixed gt6 ip6gretap "mirror to ip6gretap"
-- 
2.45.0


