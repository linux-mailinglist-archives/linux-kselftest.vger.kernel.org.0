Return-Path: <linux-kselftest+bounces-35151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A05ADBD34
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 00:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851393A3094
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 22:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB672264AF;
	Mon, 16 Jun 2025 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gkE1CYQR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755312264A0;
	Mon, 16 Jun 2025 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750114009; cv=fail; b=nuM8r96BvcB6DiKDxOHwenD8WI4XFWMywccnTItrlCPxbD+SMoVaOVo0R9VoFQgVhcB97C7JxRscZFvp5+IPjJCwT85SyjuLuBGRDj+D3MnbmrqzPhMs1yuc3zL1lu8IsP041trE1m7iL5LRWPzksvi23k+lOiNB3HtPogduebI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750114009; c=relaxed/simple;
	bh=hdTrJhLJVMh2KQIGcZuHGZXR1qhXlGlWJuZTJh7RUh4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8z9qnTmnL65+mQovX5ZicRcu7JzSmyegzgtuJ563JdLlbYWRYSSiSE6SzfG6U8g0FhJ+QWoAkboG5LoqmtnFVM93oyeetINLvIg7GFZj2n9R0x6T7nxxi6yHEqSr1SOclMP+AlQ6x+zrFXSPxhYFSvbI+cwClwiEaCEH+1Ms4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gkE1CYQR; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKrIH+T6gDkWczSwyl/R1ARV1yYYalg/E5gp3PNbZH99Ib0cCRldf0Jp1Wahukf1FXFngBnzkTFqMCZge/i8ZCrseJA7K5B3w5FAbvDwZY8XFE/04WflroD0512xBCoERk5VlZHiLjZ9uejYCMkFKeeQz/0RFe9v4s82ZdDYz9f63Ct18qcfPg7G62+wpFT8D95oCUtfqoOZaOpq+6Lfp2yqPyHKzR50ZRd8ePtALStAQv2PYnA1oAHGyhA+UuEtn5WdHOJ1Dhy3SU3KDTv0cQdpgfcu4bSs8D6OmWXGHEqb45KNyw+T51M/cKwroZjPd6g0cUBplgiABBZtIN5Rgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dka0KWrG4msQDu+KPBbL0UErKvp06FwU+IPZ8VJw4dE=;
 b=Tw3xLN4CBcJf7lyVtqhxcjF7R+gviz7Hw3nWbbBjrWpPwbug9jFJOUaytRmaih5bBZWK/S5Paq0vgBKXhFC1rV3l3ibQFKKvYO9pdKmfwZJr+y7HGHYgZUyJxus4huMvTmK8SYUnNymMJ7ndXvUystcoaElucaTYOki8YnRn+9qoP6mQGPGxWQLYO0+rq3Zye/lkKfcdn3jHMiVlbE4o8W3HXKHP9DTx+PWyjIVme4a4YtFeHbnQ3tE+fxf2bAarnb2WZo3iU9Ij0F+ZoWeHLQert04YpFIediv62U7fspwBH1/Vf+ineFWB/+JwzTdaXcS/seQ1SfesqXbNFibQew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dka0KWrG4msQDu+KPBbL0UErKvp06FwU+IPZ8VJw4dE=;
 b=gkE1CYQRf6zNHxA2bTliAK58rpctUsKtE80SYzWasRu3gHp4t8xoTDhLSAPG2MnzbK4THZt2MgMNuYB17zTSkjBgAlKMh9BSJf3q5Cf0U0zYC1zs9mdvKJN68Nv3Ys6gmRGFfw+zhmqQmoKN6x2cx2H6Zyk98USSq1OXSSfax+YLewJlZ6IFzmTNxPs1OkkK1w9+5se0x517rOOPlJrS16YTFRbJqxq8FFNmuLTfu2sppM2lyuDoZsHsoMURC0VSR6C9miSieYXlFgvqNvoQVKZSYC50abXq0bC63tRO3unYlUyrDg/4oJ/SGxz/mTJq7b1H6bYw2COmT0kUeBqM3g==
Received: from CH0PR03CA0342.namprd03.prod.outlook.com (2603:10b6:610:11a::16)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 22:46:43 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:11a:cafe::18) by CH0PR03CA0342.outlook.office365.com
 (2603:10b6:610:11a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.21 via Frontend Transport; Mon,
 16 Jun 2025 22:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.0 via Frontend Transport; Mon, 16 Jun 2025 22:46:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 15:46:29 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 15:46:22 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v3 14/15] selftests: forwarding: adf_mcd_start(): Allow configuring custom interfaces
Date: Tue, 17 Jun 2025 00:44:22 +0200
Message-ID: <2e8d83297985933be4850f2b9f296b3c27110388.1750113335.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c722da-44c9-4ce7-acba-08ddad27aa8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5jO3wIIXkesI+RPae0q7E1U0qdcruzDb2BFfnmen6/l4L4dusijM6LRs2xYs?=
 =?us-ascii?Q?kiLdtsErweWRzISljXUQ1sS6mj3o5P8ZTOS6tQUVxudOGdlVKt8IFcww0NOF?=
 =?us-ascii?Q?tXn1+zZh6njUw9wTBVve2GR25CeS2bxPojwmh5dmTpeEhobi9/bnZYzbITof?=
 =?us-ascii?Q?CN8YsJ+tCsss2/WmSz+N9QpXHFmtCZLsPlpwkLLboVV92YPNIT4gzSMGwVTK?=
 =?us-ascii?Q?/CrbgH0sA5pR9cT3LrGs7n/4jn/kIT7febdP9uuTRSoYMSPU9XjUr28ASR9h?=
 =?us-ascii?Q?EdAAbFBuyPjEGx/8u0sO0RLe51G8r4WIAlfsbWPc19H7QfIkOcvO0vGMy6Ua?=
 =?us-ascii?Q?/BFIzV5KgklCTfebi5mqBEDzAA3qkNpaXCcvslzYUII8s4AJuHZ9eeTrNhLp?=
 =?us-ascii?Q?/dLVHFbzGSUDzijKkibg9YFL/GtEkYY2RcjIfl73m/FqMABwjNsj7rv55TEG?=
 =?us-ascii?Q?LZALXPdo2zB8+GEJ4nodcIJAAeX2X2eZ6Kg9Dk7Ii+4pyzhNPC6fAXwteaAw?=
 =?us-ascii?Q?U/OXN/0gqP4NbgnitmmmFy7qPBLL++kOEyzavga8ixbZzpXpYtc3HHyFW3+m?=
 =?us-ascii?Q?MaMlD4N4QJ7EzW2TN5KSnyUIwq1suVXk4ZukcWyi8jMG3Vbh+90EnFlqUrcx?=
 =?us-ascii?Q?spxkX3HNMUdDn9NuNhy72wMDhu1DXJOc32sn21jGhnk4POzH9P4XM2UsDn4Y?=
 =?us-ascii?Q?AmkUE0L4sqHmYCUMULh/6IfRHAAQ+f89y8HqksuRo9xwXoblr4fN13DeY0Me?=
 =?us-ascii?Q?RCOYGhHOf5tV6WBVZ4JTv7CkQhjKJugO+O88M7bf9Id27zqOocC1KcIM1rg7?=
 =?us-ascii?Q?Aep/ivahRHI4K+H6V/dVwCkQwj5TQExCwREQDtE7WdAjbrfFeiFUWyAHQtlF?=
 =?us-ascii?Q?z+eJ2TLXjEED/zlQovcNhwXx8Ste/EAZY+t9nelv8MXYt5c8JXKwXxRp9viW?=
 =?us-ascii?Q?tmwTXhbkCxIUYUXP5QsT+5hY4nGP9S/YR/oU20z7m9G8GYlrL+gCDtrOVG66?=
 =?us-ascii?Q?XZyKztpSm9Rb92vWlrcCTu4NsjTwA4bCuKxk2hAWaLzwZ882xpXCjpcP9k7e?=
 =?us-ascii?Q?lHs2lZKhskYrZ/s8jWIy5t5dUlIXHMz9Eb8m2G3h9MKEGoSF46UxXHglvePI?=
 =?us-ascii?Q?ujGTdMcEsgR6cs0u3RGfPeCahqdEECtexqJiesGxwinVRjhpMD4kyFlW+Ww1?=
 =?us-ascii?Q?RmeNRtreMhEI+e1pvTp11AHesgp1TndTD5BEv1n0jh9etBJX8+ct2l+rfmTJ?=
 =?us-ascii?Q?cthFj8FWvDNEaba+aWeFejtrfzjy3rw1b8UeI+uym8ZzL0/NpdMrf5TubxUi?=
 =?us-ascii?Q?yjINdO6hDbik8xw8xYUSHgcuK1caLhnvSICW7mV6OI//K0B/NyhJbga3CLfE?=
 =?us-ascii?Q?Xs/b0PIZK3+3iKvzVUqmgEoYWpoItYwRIPNTSD6ReVwAf9MwwkfoSsI9RBsN?=
 =?us-ascii?Q?nVi/g87xD5TwJpheun+zmy5zK7GrJQX1Z59H64EOsInGUcnIfKGXnmsxypyZ?=
 =?us-ascii?Q?D1Wdl/riQPrgRUUq3F/LoBSI3dj3i3uEGbU7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:46:43.1853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c722da-44c9-4ce7-acba-08ddad27aa8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574

Tests may wish to add other interfaces to listen on. Notably locally
generated traffic uses dummy interfaces. The multicast daemon needs to know
about these so that it allows forming rules that involve these interfaces,
and so that net.ipv4.conf.X.mc_forwarding is set for the interfaces.

To that end, allow passing in a list of interfaces to configure in addition
to all the physical ones.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
    v2:
    - Adjust as per shellcheck citations
    - Retain Nik's R-b, the changes were very minor.
    
---
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/forwarding/lib.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 253847372062..83ee6a07e072 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1760,9 +1760,12 @@ mc_send()
 
 adf_mcd_start()
 {
+	local ifs=("$@")
+
 	local table_name="$MCD_TABLE_NAME"
 	local smcroutedir
 	local pid
+	local if
 	local i
 
 	check_command "$MCD" || return 1
@@ -1776,6 +1779,16 @@ adf_mcd_start()
 			"$smcroutedir/$table_name.conf"
 	done
 
+	for if in "${ifs[@]}"; do
+		if ! ip_link_has_flag "$if" MULTICAST; then
+			ip link set dev "$if" multicast on
+			defer ip link set dev "$if" multicast off
+		fi
+
+		echo "phyint $if enable" >> \
+			"$smcroutedir/$table_name.conf"
+	done
+
 	"$MCD" -N -I "$table_name" -f "$smcroutedir/$table_name.conf" \
 		-P "$smcroutedir/$table_name.pid"
 	busywait "$BUSYWAIT_TIMEOUT" test -e "$smcroutedir/$table_name.pid"
-- 
2.49.0


