Return-Path: <linux-kselftest+bounces-19939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237089A1ED0
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 11:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A949A1F268ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6FE1D9586;
	Thu, 17 Oct 2024 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PiuLB1Mq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A021D4150;
	Thu, 17 Oct 2024 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158448; cv=fail; b=dqWlEErtTbj8FL5vQm7ceRO4hksqrWlBBSDuACCmgcrZaN97sS6o4kh5IKsHW5rAJqZ3k+O0Dn+r9LpeoEOMQWc6HlQ+Wy7XOXuoocsmr/CVa/u8yLx113bzLj2zxdP4s7pQJCZfaERpt0Mud2i+DhBQA0CUTNpALZOR+nrdBf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158448; c=relaxed/simple;
	bh=Wj8/eDIkFKqrizBwAIL+rGQ4mBwhFSnEvLRXdt6sRuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pURFqHWtsGTrv6vbBgJTgNEYRFaQt/z8Gi+l3wmgvlKOTGD7Ej2P0qWG+iGXTR5uKNHcnJI5DPuqLOBTUs1dEUCjgMZdO/FavrZO7tBO4P33ik28R4OACU2PYYzzNYZWlkZbQlNaU0/TNalzzF4oOUVNe+/8ywljYuRCrTw2mtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PiuLB1Mq; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5hSSRW25ZNT9m/u0EiuEVnCZxD2mLtDpbf9Wod93lELnVGzOINgPZ5zZwjxvorohk3PKagum8kInBACX1L9QP/1MFbrgJqL2KxD3hl+ELTESQ783zAzx53X1iy57zHOsZXCnidxGV4Ig5PO7YUKsdefDPDRzk6QxNXnmnfk0IxyOqAs1KnbHTYh04IGMBBXNHP4cISLIt4ghWyKplzsCXP0TGss2+H5RFGlV5puZttNsw7x99wyA2MHKUp5CpnHIvqsy2yRUs7ptAvDyIZWE0BTzmqUbaCuNVaeu/w3FLaUQLZOEmBWbw/xw9R03tXJGnq9/SDtJdxuadk7LM2obg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VCQkaVJVw+WAjtwSfv9f7bEjAIvy3jeYEnEyvsHA9E=;
 b=mRu9PFsuxgI/koNo0/u3z5ZWoNOwVcDBN7+kYjpxri2Wks5cDmX/50GSBIk4QSl2S8HmYS2cn/Le6Re39CTM5nwKOFTWQetGRejEUWcjqqd8aqvRlMwmv2Da2sZ+ORp+xUBMWlJWTIBn/5fcdYtKCmhFt5yNq42b/eAYQLhCMiH0heGIBM9ynGKKr5Jrm4aVFe18n2cYSoAUtLhoR5YNI288wPhpScm3/IFrk+ReqgIgobyjvOELCTEmE6ZEjMeKFoNNiDnJKPJ6tiORNPuL6+MUICTDVxT1iWj+xPghMtrwaja3BwN+rZ3yqvHifWDhVcbx+lT4KILnjMtrMKSi+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VCQkaVJVw+WAjtwSfv9f7bEjAIvy3jeYEnEyvsHA9E=;
 b=PiuLB1MqMmwBzs1oqx47VdeSa90MsgbzajpXa6J4rXRiXZBwEDJ97v1a2Is4DUo+o+Yv0Syc9p25kmATA5mAdNkcJ3h927kSFuAtarN+Mo8zmRTNh7qyiZGC9wCA3Gu0tVz19F5acyWjBdU2t1tfLdvOKbAmj+40yBhBEVXOwgInPF252WiFUne/jU8Crn303PUaxmhamkGoF63dlpCVPmePeKuiyVMjv+QEZFeCGUWj+PrjIiiJAtWVOp9Hq04MvIiN4708hk3kfo+aazPl+52OAPgVi7fd26kwsYX+wAC7q907WgjHnrtRLJq20CiWAkMpTnBBZSpBePDyYSaHaw==
Received: from SA1P222CA0151.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::21)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 09:47:16 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::bd) by SA1P222CA0151.outlook.office365.com
 (2603:10b6:806:3c3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 09:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 09:47:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:05 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:46:59 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, Willem de Bruijn <willemb@google.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 02/10] selftests: forwarding: Add a fallback cleanup()
Date: Thu, 17 Oct 2024 11:45:44 +0200
Message-ID: <5204bce5de00855aae83bc66d8d6bc7b93a035ce.1729157566.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729157566.git.petrm@nvidia.com>
References: <cover.1729157566.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f32c6ed-28c4-4a20-dda5-08dcee90af35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wUas1+QTWHcxK+Tk4lttmClvFiECsyX2PGkA+BLbqYSo0keC09hkG5MSAlWo?=
 =?us-ascii?Q?l9ULdKb/ATmvy/Q4egUA5t3zUHrV0h5a85OnhNhuWEG01WllRCob+Jl6vhA5?=
 =?us-ascii?Q?nhtXv0us7MTPs0HguII4KUhzCgoaYgt1EPDonoMUn255M4YLlf5bseQHzseI?=
 =?us-ascii?Q?MWKiW/ItujqX+KGMKKPXShfrd2jMWoV3qiJa9BbUNwzu4w/Ove/3HHxt/jEQ?=
 =?us-ascii?Q?V1BPaVfQEOxfuNJ/Ix++QUwWzdBWKPZnfnmZavHe+x+dJf2XMWthtS9xNqOl?=
 =?us-ascii?Q?1eyWb+HyBydUt7L1RffuzDXsMfXpiWrMvGm6+FoXiNyOncIzQd7HDgdrHjtE?=
 =?us-ascii?Q?zKhnx4BIHC7ZLTpd8qrnfy+MEt5HlKDHEog6mi3eMjCNhBPJ2U5/xstLA5TD?=
 =?us-ascii?Q?a3PX6YOvllTGe6U+LZ93GMXWs4ltHoJ7YkqQr9G9DGTys6T1FslKtBfqKylb?=
 =?us-ascii?Q?q/an9z0oC1zU59ivpVhRjKxLiYOlWwsyQs5U4KkTznaZrvnynkv7IesyVR+G?=
 =?us-ascii?Q?38gVIpvP2sd3kpTrZqVe+ed2bGWTeYvXc6ZUvZ8JS80YgqqFpLTxHtvDHrJf?=
 =?us-ascii?Q?e4YjPVxhee1SKiV8rrtSxU4xTFqA6k0sEh6m4oQy53XTfSDI/f5V7pRSW5SQ?=
 =?us-ascii?Q?KgQKQvUhxYILvCeyCvXV3f1aqiLGcv5jS3qOL3wJGlUsCKjpO2rMeHL7OuSd?=
 =?us-ascii?Q?p802bwMKTWXhIBLqS/aKlpY8I4ducEha3UdQ3htTle3YCnZ1yd7en3Oa8R7y?=
 =?us-ascii?Q?WIRVAmr712/TW/VwOsUfVmRWaMHJWnMzWuvqKJKFt+VtQBTM7xhYU6Xge0Z7?=
 =?us-ascii?Q?+lJH/tTdptNQshKRSi+ReorXN7wpyko2a1kpZ5D5wE1Ehh3TvSGAhQzkGz7a?=
 =?us-ascii?Q?MRS8TAFCHcLBmEdUHtpWdaOxwsdM7oX98E/HzLWKh82AivhufgD4y5TxGzUZ?=
 =?us-ascii?Q?sn9hBNBYmRfG+2xTQscUeZX2LGEbBD31LcnoTdB7Sdtmgx6i/nDaZJDwHXEy?=
 =?us-ascii?Q?JcZ0B51213OEP3rQbuUtz2M5IV1GMZx+6NrKSKr1oOgt9PSQ14uC7jiuINvb?=
 =?us-ascii?Q?o9F2cRiaCi0fHgbzaIa6tEnB7uTAOaecSofHwEkvRXuN5xfhzWqf/Fw7pdco?=
 =?us-ascii?Q?nzFStBnSbGnyek6DmFoTkOV8AA27RZU9a/3xw7u1vCSCGOzz3o/REWom0o6S?=
 =?us-ascii?Q?45NEFfu+yoCLEmyzDU2OOTlNrwD9madwsztibSlYEiW98zbLL915/o4JE4Cu?=
 =?us-ascii?Q?cu6okiVyy3sH5MuXUPxJobp7eNjjX23MFqqRB5mpKmrRnJHbXnYc0CQpRTqd?=
 =?us-ascii?Q?LeQ3Pf1A/VQnVqqsXrh1UYCNGHzDtK+yC8Cl97ZeQEnj3L9OObRu0FqOZ+k0?=
 =?us-ascii?Q?tNJir1hXGjnF9aQhPTGpJzLlY8v6abms1JfWTUetjApv7QnsVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 09:47:16.1074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f32c6ed-28c4-4a20-dda5-08dcee90af35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874

Consistent use of defers obviates the need for a separate test-specific
cleanup function -- everything is just taken care of in defers. So in this
patch, introduce a cleanup() helper in the forwarding lib.sh, which calls
just pre_cleanup() and defer_scopes_cleanup(). Selftests are obviously
still free to override the function.

Since pre_cleanup() is too entangled with forwarding-specific minutia, the
function cannot currently be in net/lib.sh.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index d24b6af7ebfa..76e6d7698caf 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1408,6 +1408,12 @@ tests_run()
 	done
 }
 
+cleanup()
+{
+	pre_cleanup
+	defer_scopes_cleanup
+}
+
 multipath_eval()
 {
 	local desc="$1"
-- 
2.45.0


