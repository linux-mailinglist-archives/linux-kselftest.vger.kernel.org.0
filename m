Return-Path: <linux-kselftest+bounces-22876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B8B9E5B90
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 17:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62ADF162EF1
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 16:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F38E21D5B3;
	Thu,  5 Dec 2024 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O5CANHGj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D51DD87C;
	Thu,  5 Dec 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416731; cv=fail; b=PUFylGk0fYZl/V/YKQCJIXXj2w4J53jYqHnJSkBSNgGdYJqh34cFF/yz5o0DnutB/0u55BHvI6aZq1WTzlYAQkUJjkbtZc24MfSkwS3hCMQL1KDwXN454SCEvtuutFvewxF0QjQ2RrTkJUF5OfZji98gDpxNg6QI3wzAY93ho0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416731; c=relaxed/simple;
	bh=N5E3GPHmBVlh3noRkuLOyBDLWaLBIZ+A8HA82kKqEXw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o+Nn6nBtIyJ9Hb5iwLUZ/1h7s1Cb3bsoPJohVomeyuyEptDI/pa/XX2sIW6gEG2au1lVi7DqIN6JHppseLsofRDnKF+VS8Sa4KUe1LkGBh/0uZziPc63HMsy2GOBgxUB78YuruxNfSWcvh/CSbnOGmCQIWt0CNelDFKe0nPRVDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O5CANHGj; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEcl338ur2ReoSCYI8n8b7tyeankYUZxl1ri8/iwQAJN96b4ymWBI8hIlVA2Wp/PRJPxgF5UZHAhLvkt9Qk6HsdYoVSkhE+i6WhNdQSh1xqHtITiyG4uo2L9sTtx7A4uXTTCk+WcjYOqazKjuprPmY/CRCQYcDFGJJapdARSiBspR3INvwRDSMvo3/CGbBrDurjmbz5r6lFVrKPpFmRDUuqruGDcsnB2zLTGrEqRbm/QtVKJq+1xTcpPDm0LC/hRCb+El0LzuX2B1A1DdMblYZXFaDjTdcFgSPJLm7EwBRYy12K5NDxtnTicc8hAPltb2GuAJDkVmjxkonf+nfxArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U6SvTf0DBiaMuGT2ESZdvK7omjEOPwASJTqXse8mMQ=;
 b=eaU7DrsnzsUBdRJIF1Bp4fxNe57npo3P3LXi6GBG4GijvjnF90IgiuYqrIda2McHrckh+EP7lvFYj0RVi3L9eJEfKv0MCAe1H11pFebCHOdSVLoGzwY+fblEkQQow2w/texEtePoX8csCR+qytT6qK1vMeolB7KuxHeTzPgEuV0jmQdIRyPTPg8ax6K11Vip2e2WFhNea/1OujA7ayYd7fUaxf30LAAmzovJ6P6l6xZAaOV7zA8No/ky/Dg3a3Ho8Y7HjWKJ3Qpov7ppQxHIenFtVlWsn2GmM+fkz8tt8/rK40a9UgmQIVCqmWN17ITYgIT0YznAyaOsadg2yQ9Yzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1U6SvTf0DBiaMuGT2ESZdvK7omjEOPwASJTqXse8mMQ=;
 b=O5CANHGjNPztyouYn8bwa1attvmAYtFky+C+rn1g5OBnTtTz1ALjxRea9yuDQ9Zyh00Zd4AZzvtQuM6DrMk0yiF2CNpCrtrjwKfUQu1B+pq2O3Aai/yDxDZY9qP9xM36EYhNWL0uldQ0pc3cpqsmuLOARcLrKehPLuXsAoJgi5l/K9WKxpuDzuJG49wVWKw/2olDYKEbwW2NWWatXXigRBOX5lR/ftfMMYjycTVROFCDcYcnp1WbGfr2CpL6WNgcAFGtS0Sh+KGcaXqocEpVkO04mo240LnttHaWEyX87VmJYP1HfnLz4e7NMymgwJp9Le5tFxIAHWYkVOVfBIpVDw==
Received: from MN2PR16CA0039.namprd16.prod.outlook.com (2603:10b6:208:234::8)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 16:38:45 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::d) by MN2PR16CA0039.outlook.office365.com
 (2603:10b6:208:234::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 16:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 16:38:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 08:38:29 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 08:38:24 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, "Shuah
 Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 0/3] selftests: mlxsw: Add few fixes for sharedbuffer test
Date: Thu, 5 Dec 2024 17:35:58 +0100
Message-ID: <cover.1733414773.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a2064c1-1efa-41f6-a8b0-08dd154b495b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n/2vt/MiVcZb4Yf9/0qfAvxUCVIW0QSKUnxLsXFqqtBG6ub1s4BoFLC+Xbik?=
 =?us-ascii?Q?9/12encVJn9JJ+UwV/elz3rLDm/75WfUnDoa1BQzwm+B79/y3QWS4M8R1zjR?=
 =?us-ascii?Q?FL8kR6x+IklvN3lT4+oC9BG2dYN73Eh1W9vBX+BFDo1Qmh82ZsA/2Xm2YiXL?=
 =?us-ascii?Q?LnaX0xTnnwIRQb3mhFORfJy9FBZVyBmJ+P4i2tUYKpBu38DSURPKPDqpdCVe?=
 =?us-ascii?Q?sQvu1+BWH8PDk4VbiCT04y7j44M1YFUS9DjWR5/Sthsk/o/wWaCXYrDwYqdp?=
 =?us-ascii?Q?1obedjBSGm49HoyYFZLCjFzTSMQu316Gye9CjOvF1S80/Z0hjwT+M3AFo8yR?=
 =?us-ascii?Q?pydNRihsH5YgGU3ogUuvN3jRDxLISebvvjfBgSrnACDG08Wezw1edBg2M6lH?=
 =?us-ascii?Q?gv4W2AqojcIvW9V7ZtlMJn+FHuxwIylbX1OF2wEzrTWy+oB+4rynfDilMIqS?=
 =?us-ascii?Q?Caak8d19pfDTdum7b9zb1Qozi4+1+MUnefZ1sEY2LDT8wtrOSScMVh7qmthi?=
 =?us-ascii?Q?+F3AyiZzFr7YX2wfs4G2sf9fxqPzR9APVbu9iSL1eYWpMA8NiF+tv+TQiEwf?=
 =?us-ascii?Q?68QKVzJJr7dhfFCAZ9s3IZws668ZuLPN1CIy1UpSzCdgQep6Q7KJBFzjDTva?=
 =?us-ascii?Q?Q1P+b23G93JLAsKmLSX5C0FfViobpuQ0BPxgsyFVDqYUsFYQLryfoCDQFt91?=
 =?us-ascii?Q?4CFhzE+ZUnDrFIvGpb/BtRr/e02XO+fyvwhU9jVZHGxFdiNfrRUyU/TuC9qA?=
 =?us-ascii?Q?MuMaaH8jNLCLnN8tLs2X+NX7BW6ALfl3cHCgL0m/oO1dNiGeSHPVKxYWMXv6?=
 =?us-ascii?Q?ALOhdcwtDdlI8+1icPAUdKzBPQmPOs7JM4PVY1QDNP/N0nV9wsdU9+niRorX?=
 =?us-ascii?Q?9zQgttn6iq3eBpk8t5qkDCTGrIkQF8uKwPZIRDVRi93MZ8mTvyKqVEM/Urmj?=
 =?us-ascii?Q?+a9oQMp47DVGsCg66RGWctYuUwje62JZ8RsXqJzRDAaXtGxJ+bsDgn/qm/IF?=
 =?us-ascii?Q?N+afKvgj6VfZUkmLad6oM+Ysk6lxbitbqdoyaFbBaBV1RIzw4yg25/D0/uNC?=
 =?us-ascii?Q?RRAghlL+IJn3Ae14O6oEzrg0U4jMZRx0esc/XcPLjqRUnLOVFrdVSuB8uWY8?=
 =?us-ascii?Q?TJTjn+VYqCM/z+xMLixltE47Wkx7VWjDCFaF4NTx+GEzyWMqNcr7qyrL/uee?=
 =?us-ascii?Q?U89WMEXMMctDVSudy8YWuRxm/KAzSxQsHNBq6qhdvEOJcilNxe86Ht+kQICW?=
 =?us-ascii?Q?NhJQWahBr5MYnO/u1Cp2rKqJtMAYRZQkrlb9ofUztIvA3O8UdPV2B+ng8mFo?=
 =?us-ascii?Q?7nuIWHYfeEl5QynEX9HEGiJaLYCLnLYrqqsm7L+cv7gF+PsxjEjOu1LJT02y?=
 =?us-ascii?Q?JdLM1zj9MPiCJNhw2FZVm5qrrl7pv2vRbbnVffZbE9mQoFyLxUf/LFT9Hv05?=
 =?us-ascii?Q?FvuGgHp1zeNNZFImX8OdpawbhkECoD77?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 16:38:45.1921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2064c1-1efa-41f6-a8b0-08dd154b495b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295

Danielle Ratson writes:

Currently, the sharedbuffer test fails sometimes because it is reading a
maximum occupancy that is larger than expected on some different cases.

This is happening because the test assumes that the packet it is sending
is the only packet being passed to the device.

In addition, some duplications on one hand, and redundant test cases on
the other hand, were found in the test.

Add egress filters on h1 and h2 that will guarantee that the packets in
the buffer are sent in the test, and remove the redundant test cases.

Danielle Ratson (3):
  selftests: mlxsw: sharedbuffer: Remove h1 ingress test case
  selftests: mlxsw: sharedbuffer: Remove duplicate test cases
  selftests: mlxsw: sharedbuffer: Ensure no extra packets are counted

 .../drivers/net/mlxsw/sharedbuffer.sh         | 55 ++++++++++++++-----
 1 file changed, 40 insertions(+), 15 deletions(-)

-- 
2.47.0


