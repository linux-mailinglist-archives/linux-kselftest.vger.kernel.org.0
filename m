Return-Path: <linux-kselftest+bounces-19163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE0799333A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38468282E47
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727ED1DB369;
	Mon,  7 Oct 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XHCKuoqJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB91D47AC;
	Mon,  7 Oct 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318533; cv=fail; b=N8JIR4oRoW+CIbvYmo7HaLvXq9nP5kxZyxGMfsQXjR7xIMwmcdbPoqkopdB18923Nu3WLpg6nRiejlagVlhDtXenbFY6BaJk5buYsYXf230DCVcGQOi0H4Nj4xzfgsWCtfj3wfTpeJT1tkwA1SMfdrL38dEMV/8Ju8Ub4jedRCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318533; c=relaxed/simple;
	bh=SLC9zxoIvBSMSQE5ZbZ2b7Tub0c7SXTi5d8X9sYEN4Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CnlMPqcJi9/YyqpSy1M1P4XpHwfOULzYQ9/EgUju165y5LYck+uI8WRp2MhG/L7tB2TxQKEVrozuF6MJ0RFmgEDz2VbdfN083JCtwk+LyYawqH/607E7FoR7pp6XLN6GcOnuIO0XjyFV9MTFqmsGL49EINBNjqsW5KylczQAnGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XHCKuoqJ; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=betLKSHnaz4VFrG4TIc3sIfM6jQ+w5wVYB14a2MPLwkpVMau57mhH7bzgBIL498QRX41oKbtu0jGZCLexF1/E5CI+DLAdnVjzb5NbcsSsQKMN8iwDtTkocdiXrp+SBHbyStTPLDd327GIMWCZtinl+hojCHPl0h+1iPdMHtrGzT+bJ8tU72UnCV/l0X145nLAI5GQoxzGbmieW6sCcE+d6DvfqlLzybSg4YBA+FGkVDahQFP4qZcQjOYJg4Rhi2GmXpjej2oLx3+LSptfJt7RI5Deemv2OygxLdLy9Ll7foIBylWTfyI7u0Ag0MCdesSgYlRGInJeaCBGhvaeFZgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3cBun74uiRxHTROqDA2TxWKWTHwm/t/cv4+LGpWqGk=;
 b=u1mPRItcvNzHEukFjlYhKvp852GC9MNDjAqw3Itz8myR22/ZSV+ckZMJlJ9s8Y8KtIIl0nsnEAFq6rnm8JVPgLK+u4UG3tYh8lyHoyEIBLwQscfY2/NyGNfGWbgWYVdgXea60y5kDseOsMV2iCbk2jl4vRe6Y4gtsqH6TOo12RwZ3i/YBsuoKHaZzMmSWe2Qy5lTn5Ia2qJoBf4qYxUkKc+IIZdri4CCgYP907PpqHQIjStjYtP360UaofRfO6nPAI9NIxBzkkqQS1MUW5oGzjqUh0kg6A/HxFF5dlguoPNqkXZPcMIQza3dEJ0V60x1CGisD89O8plKvtV+CONgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3cBun74uiRxHTROqDA2TxWKWTHwm/t/cv4+LGpWqGk=;
 b=XHCKuoqJvVP1NZ23Wo6Gsv8dW3x9EvZC/rHO24Ixm3u1SvddFX4KRknI8+9kF0uPTxuA8bS5i6c9vPq7WDCSU7SK+Zaea0x377yxKeJsh6hnuSIIcZ/LSgeA57yYM06c4jz6csY+ml4ZGmdoATtHw5RW3riCOiWrWfntsuXoCMNlazrL2XWbFRafAhTeMWNixXo8+OFFPRBeI7VQJsq+IzIK5QbBDGrRGj79ChGkYoOKyTkjdhwDC3KgrNXbsUjGTG7pNcfCt4ppHcVDBeHTR+xsodN0f9Zu2PUzbVxpIdOfNwxPYoIcvm2HaL3VdCJAB7efo3Lnk0jekdwc5NQmuw==
Received: from BN0PR03CA0058.namprd03.prod.outlook.com (2603:10b6:408:e7::33)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 16:28:48 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::4b) by BN0PR03CA0058.outlook.office365.com
 (2603:10b6:408:e7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Mon, 7 Oct 2024 16:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 16:28:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 09:28:28 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 09:28:24 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/5] selftests: mlxsw: Stabilize RED tests
Date: Mon, 7 Oct 2024 18:26:04 +0200
Message-ID: <cover.1728316370.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.46.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 312e9550-6fb4-45c4-5a46-08dce6ed1f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?43bXGx9BMQ7sLE33HBauQQs6aZhbuKMf+O4kPi4n4wDnsuFrYHkaSHtg7VKE?=
 =?us-ascii?Q?yAQw04lRNNht36Ms1W51n0Mc9qkB+7vr+NGUXrVtOlLzrYerHBwGejdbRmQn?=
 =?us-ascii?Q?XIWEHYjPgyfU9yf1dYww0iV3yhestN4zC80Dm/RT11VVbgeZd8avxaBEKJ07?=
 =?us-ascii?Q?18c/1OgBuPDI7KMxzw3TAzwvmiTL7eBL8Eh80H1gTt3HfFzWxBbneYnZ91PZ?=
 =?us-ascii?Q?9sG8VDIVZGhYDPy/gktbM4ThX0a3g74FxP4nx8k00yawNBcCdXfBC7K8B3nt?=
 =?us-ascii?Q?puHWZRAeZFNdeEiItHUh5jbrHfWhZLTucLmjt485MjE/8THcHM3r66iVPS6v?=
 =?us-ascii?Q?/zu4OPjfMuP+DDoRg5W5l5CoTh/vMfgsh8X6Upe0w13oWXurQ2B3P4MoFQPW?=
 =?us-ascii?Q?b1Cxc7Rne4lDP+k1Lvb30SDmyMfV7UrrJ6KE4xsrFNpDBS0Da5UYGDr/pE7o?=
 =?us-ascii?Q?euZyl/Gt4YYWwv95PEM4F1BZ/ie93RSQXNjLNXDMNYZziFu9LfxcQ5ARBqX3?=
 =?us-ascii?Q?pthsJBimmHRtBSLIYoP1OVH7KwUGK//hisZHPQVhFLrknYfTvCWqnAdWNdDP?=
 =?us-ascii?Q?VwFWKClqCqRrpIx8CBxiudmdNaeouUllCk1MbZXnAFHEZ2fb//bDJquC3uGx?=
 =?us-ascii?Q?+5hNJfet+ez/HPeeBAzwkvBr2bD/9ig1jd+V7Q16tsHAbJ2XHun++norphHo?=
 =?us-ascii?Q?daZCYBV9H97fscRo4Pr5RMszb1TXGoIH7Cxz8gS5VmNesqVauh7XS+twANEK?=
 =?us-ascii?Q?1WyzZL8XSndidthYOWV83ReMypbnMf59Vn1mLEbA6dHwZfWNjqZs5rLjSmtm?=
 =?us-ascii?Q?tBoseOmKWfrPSk68hdnDP3CTo8i4YKfktEn10fUhdqht6mF63QAoz6cnhxfg?=
 =?us-ascii?Q?eCYM+4z5pM66CAHoDJ7bAkYWcehmjjHIguwibpSRJ+cPykPq8nFBJlU/wfpt?=
 =?us-ascii?Q?rmB+xOua1zyXTnp/h+qOHjyowlTOHHOezjUeZjGfN7/w1ZsqbY4Wpc3tb8J3?=
 =?us-ascii?Q?K4sBZXWzMJ/in9btYNNqzN2wAfBUwU7sVle1OZtxKlkG3DfWLc7JOXMA3eg9?=
 =?us-ascii?Q?8ax1P/hUINCfYCw1YeNE7Ei3XHGLJdJjRM+1dH2OJYzqnYlAjU8Ix18NqX0k?=
 =?us-ascii?Q?oObi+DTP/0ojvk6cHR/8DB8NcV0TNAxHcudBIxWv6t5nVPj3HyEqHfdtWO6b?=
 =?us-ascii?Q?IH2c5A3XF1S9B3P1XoeDvg9nXQYv3oybaqRHO/R9olHkXKhXGr351oJjj/XM?=
 =?us-ascii?Q?v0+ihVo6UzB0M1ojqsBp3E9+89c52IAK8md+gjB5lFIVK+lNg2ln4FMp3bEJ?=
 =?us-ascii?Q?4VfwFelQR9ptg4anw/g0shT5B/wW4rYmk97CeEK3vcW05BDjjyo7sXbtUsih?=
 =?us-ascii?Q?0TLTpcZWxYQ3M8Tolhc6a+Mdjpsi?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:28:48.0539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 312e9550-6fb4-45c4-5a46-08dce6ed1f10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690

Tweak the mlxsw-specific RED selftests to increase stability on
Spectrum-3 and Spectrum-4 machines.

Petr Machata (5):
  selftests: mlxsw: sch_red_ets: Increase required backlog
  selftests: mlxsw: sch_red_core: Increase backlog size tolerance
  selftests: mlxsw: sch_red_core: Sleep before querying queue depth
  selftests: mlxsw: sch_red_core: Send more packets for drop tests
  selftests: mlxsw: sch_red_core: Lower TBF rate

 .../drivers/net/mlxsw/sch_red_core.sh         | 28 +++++++++++--------
 .../drivers/net/mlxsw/sch_red_ets.sh          |  8 +++---
 2 files changed, 20 insertions(+), 16 deletions(-)

-- 
2.45.0


