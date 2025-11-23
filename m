Return-Path: <linux-kselftest+bounces-46350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63299C7E4C6
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 18:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14F4B3498BC
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 17:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3871629A33E;
	Sun, 23 Nov 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UbEbboZW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064982D7DE2;
	Sun, 23 Nov 2025 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763917920; cv=fail; b=Bzs/Xpa/TTzrPbFsEX8OWCSHaEF/OxyonU94X+yF2LvD1ZiQdhTG+M4vnHcL252lfw+UA1Dxn0AVBYKx/ifJ4to3qUaOaPt944Dd/KSkj0MZXQUoT+rRKRulR0KU7ZDyaZcsEVPGY3A1GQFPbo8xIgViO4H4XqDBUAojUppBhAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763917920; c=relaxed/simple;
	bh=NpEbO6YXl8yHtV4jsg5n8SZScIHf/RRkw9vWfWnpzNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Br8R6iw3qgVEP9b+C7QlhgTyYYfVyVfEa0T88wB8wM1i/+Omr7mIR9NDFy8fVgkXIYjiEWVhpNzCSwEqonRQk04RQaqeoeL7Ii9UdEIOPFyq7zE65DCHfzPWG4wFaWDSbtGERZ03JPRrr+FdP9D/DfoaSfYf0SVy7Rk76fSt6FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UbEbboZW; arc=fail smtp.client-ip=40.93.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWS2FNyb0X07krST3YjviCqPZNmoNeQu/tfOglPuLIpa8AFZmag5+0pAMBTQxjhSP0ukoG1EPrPZzJoztAtH2688W4bSqdcxGGDgrM+dSiWqtBW6Lm0Y5JsjcyrehHGNrhvBwaU/U3zMbmWscK7ocHkKoxhb991FHeWOwS8NKvFSJFmhwv+SK7mX6qC1RB5DvzfSVHuZ/gRcY6xsQ0Vzllsoi2vXUAYlWYfMdNv05cOvvOdiDN1PWL5Ba9XetHCwHjOi+r6VTmkOluJkwMVWB9+3xM3ucvSSdierkbaNmKk/GYKao4vI9vOnF7S1OV8hMdR/u/MqOPSexmJ+cOCfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBJzeQA5bvGlmonKlvFCqVfhowdCgo7snDL68MbynOE=;
 b=B19vbic54wLZaDhHuqLdcfhK9nQapTU7OxRuLDhI58tDYkljudGFk3iepatG+eUQM/zMTEBOnjAIdHk91QIxASI99SMeobce+I3toyMU+PwIloe+aIGmL94hNBoy60JahS9F+n/zW2H+QE5BM/qFTgqj6UL/HL9tgtryMfDynslVAIUhF1xyLmxjJF81nXncUCR9F5DaWvg5aBgY/G6IdmdlyYW3aLbzZ9tCTnXyd097gCblL67aEgrgRtrrP8/UAApqRjsFnocYCFYrcMUPHHf2VzeE3hLInttx2atpUQgBkjcQBk8czlLT6ADIJfjxx6zNIaTG5Z39Pf8O2fpGlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBJzeQA5bvGlmonKlvFCqVfhowdCgo7snDL68MbynOE=;
 b=UbEbboZWUHfqhlGxfo/aKnbDaY6pRg/NHBtOtRXi61zjEeZIzwBkUiKWtAfUmx0giJzabiokPMfgQ5AAThG9lK4wFjKNhluBL5gmkAJATB3ilpI6SXu2KBRFSA6jIyOfR7K7RZvSDDSBoGuVxtiKeeIiZdeptQlYXt9PWTo3B/8y9xDN/BQC2f57W6OJ1HEYnAzFRe62RCU4/94uHIokuKxxS1wntyI3VAVmzkzS2LgrM5YMbYYFEtXYvd0IjmgJ6TsBK4P2z6lsFxp++umb+RzIIm349NYJ6KgT1exWM4IK4SGjTlp/FvZWlc7Lpy0RJJSHCP1K13yIH8Q4uHDJYw==
Received: from BN9PR03CA0316.namprd03.prod.outlook.com (2603:10b6:408:112::21)
 by IA4PR12MB9761.namprd12.prod.outlook.com (2603:10b6:208:550::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Sun, 23 Nov
 2025 17:11:53 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::2d) by BN9PR03CA0316.outlook.office365.com
 (2603:10b6:408:112::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Sun,
 23 Nov 2025 17:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 17:11:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 09:11:39 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 09:11:39 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 09:11:35 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V2 1/6] selftests: drv-net: Add devlink_rate_tc_bw.py to TEST_PROGS
Date: Sun, 23 Nov 2025 19:10:10 +0200
Message-ID: <20251123171015.3188514-2-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251123171015.3188514-1-cjubran@nvidia.com>
References: <20251123171015.3188514-1-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|IA4PR12MB9761:EE_
X-MS-Office365-Filtering-Correlation-Id: 388f02d0-4778-4757-e6c8-08de2ab3660d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uesVaTzs+ju6DLnW3/ZQFqwJE0E+e1pZg9mrxegS4CKt/VKyS3RirBXfOjNI?=
 =?us-ascii?Q?X4jSsVSqxgefKDzBVXZJCKsWDokgDwwMM5fpGgLCkZqneP4kFDJsHoXgohNx?=
 =?us-ascii?Q?fwwB/bpoERBwC6svvX6jf+LU+JkhFacCUpuPJHpnKuafAYrG0HL1B6becrYQ?=
 =?us-ascii?Q?j6zLKvlafGMjNPpz1zzPhnEncwzyw3rLyUp4sRTw51aM8/+zkrnFIGecPwPP?=
 =?us-ascii?Q?CVeUx7dpvBVWyX2M48D3TQTWY87qZ/D2J4gWe22iywWqipPQEPsfIqiWiSze?=
 =?us-ascii?Q?JVdEW2qwAzMXF264vbJOK0Em0IPYmXObRITxikcIIlxTa0fue4lGqnl1YDhU?=
 =?us-ascii?Q?zQoO5YTWFw9imhWU9pEXBFFqZjCcapDZYJUzqM43bGBuQ5/Nmb17Jt3Ov+pa?=
 =?us-ascii?Q?fKFbzW5odtjLR7InRN1ntA4Wp3/A0lMBmeLgu2PFoCfph1bjFWWqLxNwMUU0?=
 =?us-ascii?Q?uid4dWX/rsbFwxCgrKPfTU9/7wDuw8VR51QWvtljFp3I3NOh6uFqASSAbGkV?=
 =?us-ascii?Q?plyXWntojbP+3S7m1zpdEJLALjP1YtZZnDe3qFGQxxch+489CWSQHA/I9Jxp?=
 =?us-ascii?Q?qntstw7X6rbrGvbULElSzP10mGQ43ZaAEubw94ss8ghf8izsLfO75B0GqLyj?=
 =?us-ascii?Q?r2o8NTHfsVxYEcvgwg6bhlfekgmxVGofpkmrCAS39ypEcdup00vIF/4cX6z8?=
 =?us-ascii?Q?rbAqm1VlC9m58KvyLbzDxxD58Jn4euioYznSujcTktuwH3zEt/px8FwSUI08?=
 =?us-ascii?Q?Qp2uGlwbVYDiJhFZo1Zh9TmtNzAHi/LyImtasG6OeUovERVsq2qH4N9ulKXI?=
 =?us-ascii?Q?1VypmuDt5AS3cm9cCVP1xLsMIVS/MIZoFAi9PIeQ218m/sNeOkUaqzgfyvck?=
 =?us-ascii?Q?lp9zJYS7RevTWUJ3XZ8MxZa0bAe4INB4o1jMvJTPBOo3Gi+xjbTgCU9sjZ0s?=
 =?us-ascii?Q?jnYiRr8omqDneUgC2tVraZxPROSIJVncIouyTbBoE6XJ2wy0zc/BMB713shi?=
 =?us-ascii?Q?W/IZh7f9d1q7W3Xlakzu/gnCH6GpdB1jDHsHrHy3ZC2Mk4f0oPHN6we66Qdp?=
 =?us-ascii?Q?A38v8lAfGo3PsRJAiswc2DxEWyMyPfIbQgyX0PDIaqei62xZdvknC3DXybNH?=
 =?us-ascii?Q?/qvL7+7l7M9gZuem+j0ocPYjUDd31vEl33XbluAYJDhJZGpjzsgLNx6/4fjK?=
 =?us-ascii?Q?IpywgcKk9G2kd8GF+Na4splWKKkyZpciXQdTa//YlA+uZY2O3Hiq6c16I80s?=
 =?us-ascii?Q?sujx+PL6a6CrJteZOubmJiMbL9KIBwDN949H1Ia022aylkadxWXShF/IsIO5?=
 =?us-ascii?Q?ND1q4nwRTR8q7mSx0TK2N1M3C8HdR3nclyvCBZwNoEphtBYbfmiln4i4xAv3?=
 =?us-ascii?Q?yP/ef+q/33Poha3sC8D8LnLwg7nqpMyH20er3d6iwTJCeqD8D2g9+rl/YAOM?=
 =?us-ascii?Q?BJw5nMjLYiL5Scd/dDkCnaxzHGNAbdWuDMGUXI6Hpb0TQz5L/5Y70K6i6OzL?=
 =?us-ascii?Q?STkyZGw1kNAj/gRTdFTg8vetM2D2Ponp6s3MXt93enBSadGJaGOBHV5/aRBL?=
 =?us-ascii?Q?kkJWaNWOI2CyIAR+dV0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 17:11:53.0862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388f02d0-4778-4757-e6c8-08de2ab3660d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9761

This makes devlink_rate_tc_bw.py present in the Makefile under the same
directory.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 8133d1a0051c..f89004e99bb7 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -5,6 +5,7 @@ TEST_GEN_FILES = iou-zcrx
 TEST_PROGS = \
 	csum.py \
 	devlink_port_split.py \
+	devlink_rate_tc_bw.py \
 	devmem.py \
 	ethtool.sh \
 	ethtool_extended_state.sh \
-- 
2.38.1


