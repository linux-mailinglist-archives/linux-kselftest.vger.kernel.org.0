Return-Path: <linux-kselftest+bounces-11389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF897900876
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132771C21E0C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A57319AA74;
	Fri,  7 Jun 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lGjR5Mt1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812DF194AC2;
	Fri,  7 Jun 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773313; cv=fail; b=j3YTDkX+239sM6MPawN/zbRovxVoX5+w/o+HPSHDLAlGWpLGNFdUnWebygEQQrOsJDy9Wel5AXYoU8IT8UfLr6caJb9IJduEuFkN41iZNtBejpX4KFOWBUHezrCpkaNsx7wMBM9CYWiS1vITX01nPSZ9LUVc4XObzOc5nBYYFnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773313; c=relaxed/simple;
	bh=lLcb6eaXq4gcg1qgUBqzgE26aNxbx6w8SibCqsqR+Pk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVrmbzx5o6TexMddD36BR9AojHj3q0tUdkjBm4nj3v/tUdfKHEMDI477rffh/nbc0uSmR+jPVmcWgapmHBBA/j43YGBhl83SZp9L5m/3CymakkK/c3rZGy+THFUXGg+QntofVk1gPsdk58U7j5R03Bw/WiF2EilKxotQmiM6Ruo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lGjR5Mt1; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZewGvSYRQK/2mQsEMnChm+TgmP9t3UEj73MUAoOTLMvXKnd/1OWzpqbx1ZiuGNEa+yKd1e8wO2W6lLr6+wlbXNnEUYtufqsqXEtzzYCODVAPMcwG+lpQJyjzP5T4VLPWwEXJ/f2Tbl9bfBcLYDtGjRit61IBlBJmiWIMSyMNdcZ16/YzaqBfcZBGCmLd6ew8JoC+/qZxbPWEW8kSpnShGmfWP6ZUFG4PZfebpZAirmAgU6ajO6+ejdEfeB5eu0aPzJpG5HgkdJzNNpEw9Ertze5Ju5XaV/d7IENE2Z1B2vIfAIbxamB7gupvdKeIldSUNa+ZPwG5ZyBVSw8PMsiaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbanpn7aTaQwvnq1jLYqpIkmKFt2I0F2FxvZYhaOz/I=;
 b=e7loCBPTFVhxwypPrGZFEX0+MXHtzfCt0CzcEboINXWsIbc1ruN3HSeGCm/RUPvopZ+2s7c6ErP1XSjDV4MER9mlU2OMruU46zMsozTE0fZUSV/WlQF65ORyMYlHjJhmlDVfggItXMnKzc1JF5/mEE12lPS+hXGctn7Rv9FKjkttugrPUoxzPbUYEIjh0pAskrlBZt8rdsXS3jM0IPxVYD5C40dzV/GowdE3GzqkYO4DwOIaQ1DdOwxNFTAkUq5gHPLbfuZsswhyA4pFVKVSlZcGVkBGuIwI/x/8BrvQ25mn4va5KpEQVWvZ2jydLrFeJI43n8Q0NAojuY/Sz/icPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbanpn7aTaQwvnq1jLYqpIkmKFt2I0F2FxvZYhaOz/I=;
 b=lGjR5Mt1TVaYLiN+GnsolqvWmpgHEnIjCTiP+hwHBfcRcwrhG0Z54jzhnx4s5tGRLbFyLLYAJJwrW9OgQbRUX4L2Sli4//vnHT1YtXl0lnP8PfpL9oPIcm6qdcb4xTd6bdTaQHjrTzyEn2BfGE2DTjbVLsZivdypwWWU66cE2NozSZf6C0M+7ngOisSz5AX8cVvx4aG3a+XidKAySt3nutk38G50/nfOR5AA8mrBesMv5spzS0aYteYbOLXaZ83k0yo3qo8LxolyHPGiofu3LkYrBwKKnbhogEeIGdgBk+zXmkbm11bv0qAHpFrU+EbWJ6Xj8UkPgIi+TCZI8D4orQ==
Received: from BL0PR02CA0092.namprd02.prod.outlook.com (2603:10b6:208:51::33)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 15:15:08 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::ea) by BL0PR02CA0092.outlook.office365.com
 (2603:10b6:208:51::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.22 via Frontend
 Transport; Fri, 7 Jun 2024 15:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 15:15:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 08:14:49 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 08:14:45 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v2 4/5] selftests: forwarding: lib: Split sysctl_save() out of sysctl_set()
Date: Fri, 7 Jun 2024 17:13:56 +0200
Message-ID: <20240607151357.421181-5-petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607151357.421181-1-petrm@nvidia.com>
References: <20240607151357.421181-1-petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: f064348f-6c1f-49c5-8b52-08dc87049e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?briG6Q014paRMt1zvZ5aeYBPCzhppjejTxGsiDn1dzhJy6+QfCp/leP25V2i?=
 =?us-ascii?Q?vJ2DmG69rs3hkckoyd/I+XPiObTXtG8b3Ih9oiFmRywzsR+CNIKNRuolRCv8?=
 =?us-ascii?Q?ocMvj/jEMaL37HubR++MFQm4ym5AVX/Hc5r/sscGPzVCJxpUHk4ol7qGpuvz?=
 =?us-ascii?Q?Kja8quUXnUEAdXXE57FsTahbEK+Elp1tfyqK3h/B0XXUkX9F75OgsRuquDVv?=
 =?us-ascii?Q?+gP4nnFz9gtNpKghLgd6hgfoUdn6SOqz+bYXK2t8Clf3xjB1mc2Fu8XmCclT?=
 =?us-ascii?Q?dOXa6VONAMzYEKFF+cEt6rLlRoToJ8KfBiDhWvt6n4maK6uS4M6GF2aqdZr0?=
 =?us-ascii?Q?aOoMyWs1NAUor9CfLis8Up0XALgkmZD3D5t0Sf3TZLjmvy0IcKkFQsQSvtRl?=
 =?us-ascii?Q?788bd+VezkWd1hQksAXT+6VsfaDp6AHZECestAz9/RiR1rdEqaHau5jiaabu?=
 =?us-ascii?Q?HrYfzH6Lp8eUAFW0mpUxeG5nGKnAU8wZOsslMoLaT+ooDEKGK6FepFSp/8sr?=
 =?us-ascii?Q?fNXpzMZbxd4DnxYGW0NKViMtzThxnc71NwGVI+d5IWb2ZaAhSkmtRS142fXT?=
 =?us-ascii?Q?dZZqhN8BZLq2ITLJ9KbLEYiWAG8QqHAfcuOOzoOCBRSYOa1vleaxZLK/M+gh?=
 =?us-ascii?Q?gsXHBO0HS/+SAFOb254i0/wcZePopPV1Fd4KWJ5lv/A8uxHHHmcSiBcBvGZR?=
 =?us-ascii?Q?5B4s3K9h5CC0MqFy3gOYOREY0uLCHYRg+gcJhQvhGWWqCN9cn1Yzw2Nq4k5E?=
 =?us-ascii?Q?Y5L2BDtjL19iAwBJ0QAlld9W3kfm0KwfHYVgr5QXy18Ij2lwnPkDiKnQXj6u?=
 =?us-ascii?Q?5EF/vqn3ttMbOX7gvzF1m8j09REKiADkIJAs6/BcuxmH6ehnma5ySp79NoJk?=
 =?us-ascii?Q?Npbl1swKp6rdvxH4NNI9X1y60yhaLrdgS8rAt095JovmoB/6JH0iSxZChsJD?=
 =?us-ascii?Q?FCT6Q7H4HxQ3nIMxSjJdlkhtsbWWPn7cGSkDpTFs5RRKmAFQ/+qMQeGrAmZN?=
 =?us-ascii?Q?IqgQ3ZQrbPvdvGexm2X3mA4ol0jRFLt6N8LIkYqkDmNJK8s5mAXRitEw7e0N?=
 =?us-ascii?Q?UkhyURosXGQd/Tn91nvgFWX8ofP/bVTnzK28gMGMgDP8w2MyasUpPrM8z1xa?=
 =?us-ascii?Q?+AscnoiJoBuZHmjQlDXLHn709HXstfYuCE6WgdZIjXAMka/4dmys+N6Iv6hB?=
 =?us-ascii?Q?hBIlhkPmDfD4PxbVZk1cwc1YMrGsP2jT+0BdltqW6vAGUgJznaAX1pSIIby6?=
 =?us-ascii?Q?REgUpS8GGyzn9IYMVqH1dKyy9OVOv2Bh56vhuA909xgk/L4sBVKMOQx+PsyG?=
 =?us-ascii?Q?2bP4xy0Fcqdyow6HnxviQWVk4rEFwW7Oo6QV4NlCbcy4GgE93sr8jF16KP/r?=
 =?us-ascii?Q?hKnwBTEPxNGABFWwGGBNr9oQ+nNzNGERNBQFT+O7QNcqysAhZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 15:15:08.1034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f064348f-6c1f-49c5-8b52-08dc87049e29
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434

In order to be able to save the current value of a sysctl without changing
it, split the relevant bit out of sysctl_set() into a new helper.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org

Notes:
    v2:
    - New patch.

 tools/testing/selftests/net/forwarding/lib.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index eabbdf00d8ca..9086d2015296 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1134,12 +1134,19 @@ bridge_ageing_time_get()
 }
 
 declare -A SYSCTL_ORIG
+sysctl_save()
+{
+	local key=$1; shift
+
+	SYSCTL_ORIG[$key]=$(sysctl -n $key)
+}
+
 sysctl_set()
 {
 	local key=$1; shift
 	local value=$1; shift
 
-	SYSCTL_ORIG[$key]=$(sysctl -n $key)
+	sysctl_save "$key"
 	sysctl -qw $key="$value"
 }
 
-- 
2.45.0


