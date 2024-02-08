Return-Path: <linux-kselftest+bounces-4357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF7884E59F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 17:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527A31F2837B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 16:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363B8823B6;
	Thu,  8 Feb 2024 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ooRSkGTy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41A80BF0;
	Thu,  8 Feb 2024 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411382; cv=fail; b=q0A72SOAJ539YxJ2mZPHnUgcq+iGiIAxzEnyHMW8rWpaaiVDQdrn9ad7TiDnwVsRFJAKZnIPKN1iBswCXleVMZ5dzKsaGDVSPH9+eCXy5k9X+jykWps1wBiaQS4XIBr0ki91nYzZgkV7GnA4H78qdWP8L09YvFck9ku5OVhoBn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411382; c=relaxed/simple;
	bh=nIePae48Sm/OgSvraCY4yAXS4TUYhAA4PU9N9fwRUts=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DMCs1vnK4r4hE6ckbiR2kaLDE0F7e+muGrNIqX3akuhFJMmuHldy6gPSyTU5nmJ6mt3iZMDmkFcMjGZS/pxmwYQACtbrOU6ySfUXyIGqH4YJ6vFYZaiYxRmQe7A7uLR+x2XL/JDfMVgKrAT7+4uluQ/x1PPUKPGH6Tan30wPbwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ooRSkGTy; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHKClLanO5XVJwfrQH89uzPqxhTg5EY/9kHHGW1mIcFzRYG0vfmw1vCvzAzPeWWvoMJXdEGbNrN1MCoTU6AC9+bzOG1/+7qdfqctYQfxFQP9192Lpz8pBW/XozwNlFA/LTvCciPImevIupM5k9vTrFEnZcvx7s9Jg+6T3TDMYkYWpY+8MUBUrH5X4LYDuk5TDCW4oNUBAl4qkMtpBhmB8g+Wbm/xOWTIuhzAwInIqNEAAsLCtsof14fjQhm/OAOkL3rmL1sV8G6gxN0lGvgLgCefkm6J6W4YOpt36j8v53BZaBnhrW/Tiv1xrAbNT+8ZIhY+tmha/gyRtWVN2XhW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSipZa+I6hYs1k9wZPyPdDrYsOngUOeDqI47n9ynULI=;
 b=HxDhEM61+euyE9lA2F/MDl8KY/irvRQnUuxS6Y+qkmKd7RkzJAhqpZ59hvwj49mU7sO7Z8oYh2t8ReeE+kFOd6z51DbJi80kh+XYAfSFECNHder6BatEUyHwUbijeQh6bDkzp3yu8gav9c23fVDTdn0WmUGa8N7H0WwZteeurERXge+M4QHBjptMx4GmAkXILrFY1h/YMaaGuFCdqI7sev1Q7Gb27zMDOVTsMU7QUE46AC7dIxiftqKQ1yySZY29r1Ke+ll5XW5YxyhHAhkmiYUd9PpuOUE127mEaY4ZrMf0CATdxbkPTSne3DFywykt1aKK6zZWVRv34fRMtLHbgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSipZa+I6hYs1k9wZPyPdDrYsOngUOeDqI47n9ynULI=;
 b=ooRSkGTy9rwZLNW0drpHk/Li6ieb3kwi6FJ1VV/Yp1rIghZHSOwKsTWIPC+Hs9e2iD0fHN+nYFDkOiZdozoteKiYS3EsiUYjlzEaKIi7Rn+3CirdJdSAzsgOnUqzq0seLN1bemC+OAZuOriJfZZB2QO5Wia8M63hTQtrhI8Q6w2xbvyODSL3RrQ/WeTIQDBUyUUoA+dudFauWzUB1DVprMaVFQBvG63rQQMHYHE4N9RdxW0X17nTSVx0bHeHgkPe0j0wwuScqa4wcBC8ywmgg/8jTsOlmbbTOAHkpm6byk6OnkLNMZJRjBcPzncp8R8HlupLx7bMl999DNu664WpnQ==
Received: from BN9PR03CA0338.namprd03.prod.outlook.com (2603:10b6:408:f6::13)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 16:56:14 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::e5) by BN9PR03CA0338.outlook.office365.com
 (2603:10b6:408:f6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42 via Frontend
 Transport; Thu, 8 Feb 2024 16:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 16:56:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 8 Feb 2024
 08:55:57 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 8 Feb 2024 08:55:54 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <shuah@kernel.org>, <petrm@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next] selftests: forwarding: Add missing multicast routing config entries
Date: Thu, 8 Feb 2024 18:55:38 +0200
Message-ID: <20240208165538.1303021-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ea06d6-d446-48aa-ba09-08dc28c6dc09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kx98Rs0UKozf4Xz1tBgUec8vaC0cPdc+ZFyRH/1t3hivt0e1MRZfFWTrbw4wEHnkT76LA6RRvYr8ncLKN9Ws9md4PQxpOS4U560Vu25+sBLznbBGbSoOeR1dVifCtzYmPDOLDTJhj47ijVOoCj5t3W5k4gU2kerbA4oz78rZj7bCEtawIz/I4YPqqztC/kogAUwSLbtZG9ktfe3berW0edGzruUf1qvykxs3/Wkua00BMAEJZIHAks9mm4WJtFEypqSHxPzEj7Jbn1bQRm9xRRNiLLg0FwumHwnp+Smq2kaHpKTlWoyCzMbRJGB1+CvVlln78QVI0zrnp/elKQ8crZaTUxh7QCbpmw/A5bUJv+pxDXRjV2BANi8CmbZ7ub7WvWSjyWV1HouS5GoSP3MFcQwFt9+g0MBQ/L8spw0S0r4rLllJ0LZ+hCoszGOm1K3auueEx+0yzmpcNUKCTJopa4VVEgHQ2T8KaJRVzE/F11M605MLhyFrrizccoQ1/lmVTIy1YBJ72jwKTurKBUL0CtIir51jh+iugOgz59dtrI4X5oRNICG49sruqY0K2qlmnopztavZ007I/lWCxwytEQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(316002)(6666004)(41300700001)(70206006)(70586007)(8936002)(110136005)(8676002)(4326008)(5660300002)(86362001)(2906002)(36756003)(54906003)(82740400003)(356005)(7636003)(478600001)(16526019)(426003)(26005)(66574015)(336012)(107886003)(2616005)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 16:56:13.7997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ea06d6-d446-48aa-ba09-08dc28c6dc09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302

The two tests that make use of multicast routig (router.sh and
router_multicast.sh) are currently failing in the netdev CI because the
kernel is missing multicast routing support.

Fix by adding the required config entries.

Fixes: 6d4efada3b82 ("selftests: forwarding: Add multicast routing test")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
Targeting at net-next because this is where 4acf4e62cd57 ("selftests:
forwarding: Add missing config entries") was applied to, but you can
apply to net as well.
---
 tools/testing/selftests/net/forwarding/config | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/config b/tools/testing/selftests/net/forwarding/config
index ba2343514582..f59083d8c59d 100644
--- a/tools/testing/selftests/net/forwarding/config
+++ b/tools/testing/selftests/net/forwarding/config
@@ -2,7 +2,14 @@ CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
 CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_NET_L3_MASTER_DEV=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_IPV6_MROUTE=y
+CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
 CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_IPV6_PIMSM_V2=y
 CONFIG_NET_VRF=m
 CONFIG_BPF_SYSCALL=y
 CONFIG_CGROUP_BPF=y
-- 
2.43.0


