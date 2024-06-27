Return-Path: <linux-kselftest+bounces-12864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3E491A9D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85EDDB272B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 14:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DE1198A31;
	Thu, 27 Jun 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pPIvX5hg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D50B198A1A;
	Thu, 27 Jun 2024 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499843; cv=fail; b=qvBGNCxzrG28ZMDfTjoBu5D+7gFXgMTRu9szWw7H7EyZKemauWkoC8m+vwsWmfqbh2upqOrmX3LL0ham9pAqN+AIrDf7P/zh8WwwIyvYW1lKNOXrFO3BqGtpkvkVythNSPc9IxgdKDxA4piSZ/aD1I6H039MN6bg4sg9OL+nH0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499843; c=relaxed/simple;
	bh=XdSwYFx6Zj63miu+x2NoH5DKXPAPvSTUoiRk+Qg4Tqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cu4Tr2ZaCyCiF3gVjOCe/97PbQ6qi0BLBTCj9/aCLMEFRQWHtNXRIXNDqWW4P5nixtiIIuON4XVh9adXZf4drJOQTx08y8Oxpf2ftDzOIA9Zt2khfIBwsOQpzyTFdU1inrnCBpsA7H2etZcH/txRGF7foL70aCWB8quUMCdsgNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pPIvX5hg; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpGZoagByPiKLXvurhiijyfPSpeVy9OV9okBO8cUMVYmIgtYfPCv9WOUrXhFbpD5Lwwmja6dOU+EinG4AeJ8ofKW5oT444xCfaFOkqjMLX1ZIfGv9goJqVPIYT8nkZkhXgmqVm0ktx5Xl+jw9quCUmU7GilePdCOrHuAYbzzPAf9H7fWCvbZdk1EDGePj3mhyECCeOSjUkNd8tbHNYoyj2RSWwLve9u6tU8fPk8mdvKi/T15AmasmWtj3I7qVB8VaaSxhJAClwW3Jj8fg5PPLWgi+9/chLAJtnO8XDE0+4vC6qN9Nmw6Ji81XLkJ2IzUGczvs7G8jcujg/BMPmZ8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sCvBz6sOlEF3baMVIn++BDjoVMVRxM1yAIlgQ8lGLk=;
 b=ArSwGcZ7LLxJw+mU934VRf3XUlshaUgyON8omhff5T/TN8sDk/qYQcRgM5d1+D9mTF6N2+0HD06nfRxkgOdirgBF50y1ADUEY4kyMRpLCBJuxp3ezej1598r4zoRtJ1aRF2vWzNBYvOzSEUR8kJXtgTHwcBBtlL0wdNKNLVdn8qXAA5xe1yS/A5CUo2VBid+asVikCebXG25tjeIQhQXzegLhSwOFa+BWUftzvTHLCzvuFDLm7OrLHIyHy95OTaE1kbPlkI4Z6kyDAr0XprcW8Az+t4rnPZQEsNPdPcFTrI10c2+jjqMrW/IMDZPhpqnsb2yJYWvopPI6zu/BHqNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sCvBz6sOlEF3baMVIn++BDjoVMVRxM1yAIlgQ8lGLk=;
 b=pPIvX5hgmgYvn4QlFMSRVBI6TH+vhPzZoVRH1D1wpSd1H4Rem+Zjt0GMWAykHc0CENT3brbD9afLCPnZWw3j3aUjBmzGRMniWcOX++1iVrXm+zTQj6t7WGqusLSc05NBDpZcBpHR2/HhETFxNyMbWDTg4mVMdl92hbKZMUdIYsOBZnMOOsvMVAIyOOfir4oG7gugrsN+52KVxXsBIjTPlPYABeHUpqUaob8dVHoDmIwcQuVAaSZan5kQRkj5vYxcBYfOT6G9q/5kcyLNAGAYyK021lVMnOEDDVlHebhIFlXXDRy9uxZvbM4ElwxfYb/SMKP/1U0Bg9i90TLpPKR3QQ==
Received: from BYAPR02CA0071.namprd02.prod.outlook.com (2603:10b6:a03:54::48)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Thu, 27 Jun
 2024 14:50:38 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::95) by BYAPR02CA0071.outlook.office365.com
 (2603:10b6:a03:54::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 14:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:50:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:50:23 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:50:17 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Danielle Ratson <danieller@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 10/12] selftests: libs: Drop slow_path_trap_install()/_uninstall()
Date: Thu, 27 Jun 2024 16:48:47 +0200
Message-ID: <914df583a21daadc04ba8fc9dccc45de3435bcf9.1719497773.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d0ab74-ecaa-4ab4-ab8c-08dc96b8821d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3JUm/RAr6LBFgPQmfaKZRVABRMpEG451kf0kFsr2zbm4NRGs+f2aZ6rcB+Np?=
 =?us-ascii?Q?icuR5pMLMp9+Uh/74+LOOQ9sdIWBRQm9r+louaIZ/zIngFjnbx6B3MXnZHOn?=
 =?us-ascii?Q?gG5M6QUFEDUa5k3cyZQJNuLLZMa5kOqU/v4rIS2NWc2T4nbqR8mc0BqLB08k?=
 =?us-ascii?Q?D269IyoqhErXqvL2WRcjq3uIjRHxah5kzXVJn1ntVjGI86e5kFLXFc5c/M3Y?=
 =?us-ascii?Q?0MHvW1l409ENSXn/0F5Cs03rA/kt79WE941WLB6bWPbX4Bu4sBwO8vc/hxj3?=
 =?us-ascii?Q?0hihP6AKVgxqo8mvse/YUVmJ8Dfhj3ft0ejV7baKYrBRQ6YWWy15aoKDohg1?=
 =?us-ascii?Q?d48dhr0/EgiVBtkRT0zQOghRIf4ebZMwW0IV7AaL6tIlcLzMxMv1RAA0Qz9C?=
 =?us-ascii?Q?ffsA3MXygOl/Kxnooc6CnTrmoBELmliX257cVjIys/EPeXZvkuvhyFJKu0Zu?=
 =?us-ascii?Q?BMVJ9g9HVPGm4CUIElq2EtHYovZmhDl4JCKpTfGCs/QN0WucMTh3jrwACHiK?=
 =?us-ascii?Q?/DJsdw+0E78i0eSdFDoh49jXqxe42vwl3gWfyAsVoyZn21GvuQ2Pk4gT5Q7T?=
 =?us-ascii?Q?fY/N4vLr9+M6CMTrKEiuTz58xLQ9atXXAKOkbS7+slisd2rcVUcEJ1KF/1Hw?=
 =?us-ascii?Q?mBA13yXutG3lfnti728j6nT4giSIevaQT9WSU1yI76PKiA4tT/Z3iNAnC/Ct?=
 =?us-ascii?Q?uGi43cd0YZPy+LriVVak36MwrJDSrCzpMsnW5e5yjVxsRq3sxcVPH+V1o0X8?=
 =?us-ascii?Q?23kgaLTG6ee2b4KlWQC4PaymEjh9BLXDXwqdf+eg4Gn28PIs4w3OcdcMAQqO?=
 =?us-ascii?Q?PNyYhF4RPysHQkj2cihptShxsptt5hzKrcwAOyFTZqCbyrNUhsucQ5XUJ50f?=
 =?us-ascii?Q?jqplxrxOhd7inyePMZy4SQPxiyX1+k8GZQFaiWUGFyRlPn97TgkS9ovE69YU?=
 =?us-ascii?Q?XVfN9pVWDSygtDhqZw4JlHqqZ2iskKHZnM234bnfnAxyIaeqdbu6/LfbUFZX?=
 =?us-ascii?Q?xUN/9toHxyN18jY5/O5uhkHJpd9trXPC7S66n8s5jyosMnLLlvg13mLwoV2/?=
 =?us-ascii?Q?KkwkKffcn/ko7fK90I6F5k9TWhh4CTLkMFDs7SkglukkLiGf86YoqQlstoNO?=
 =?us-ascii?Q?GgNy4BsBE5rpKmyYWdybl8nbppVOa8yDtqT7eOxsuP/VX4TeK1rb8JHBRMVG?=
 =?us-ascii?Q?OxrEn85cJPxCAfE4DBqaNKsw6R4zoaTrWunoLZWybz+oT2OBEPS701S9/fNa?=
 =?us-ascii?Q?UWqAoRCBQj9m/M8KJwJDcY5jrM5LY2GGTDe6MgrpWY6IsJUNM6EBO2x8gSwU?=
 =?us-ascii?Q?8NOkugNsIOKNcieCYgCRQN2lb8TNS42Kq1VYDLG0jRgIwA4H2W3K4/5zaVg4?=
 =?us-ascii?Q?us+ihHJOA43v+x6urbFiyjVrcHekhy/Nl6ya5sSxa09f740bbumsP56B69Qg?=
 =?us-ascii?Q?O3H3iQC+Vb9HtpvQAxPzn/rnkJvpaSBH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:50:38.0742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d0ab74-ecaa-4ab4-ab8c-08dc96b8821d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708

These functions are not used anymore.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index df7cacb29160..ff96bb7535ff 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1225,22 +1225,6 @@ trap_uninstall()
 	tc filter del dev $dev $direction pref 1 flower
 }
 
-slow_path_trap_install()
-{
-	# For slow-path testing, we need to install a trap to get to
-	# slow path the packets that would otherwise be switched in HW.
-	if [ "${tcflags/skip_hw}" != "$tcflags" ]; then
-		trap_install "$@"
-	fi
-}
-
-slow_path_trap_uninstall()
-{
-	if [ "${tcflags/skip_hw}" != "$tcflags" ]; then
-		trap_uninstall "$@"
-	fi
-}
-
 __icmp_capture_add_del()
 {
 	local add_del=$1; shift
-- 
2.45.0


