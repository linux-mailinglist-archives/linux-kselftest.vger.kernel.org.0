Return-Path: <linux-kselftest+bounces-29346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9CCA672A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 12:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD3319A5B5F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 11:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F0C2080E8;
	Tue, 18 Mar 2025 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mQlCXjun"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C998F208983;
	Tue, 18 Mar 2025 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297102; cv=fail; b=KRb3L6JtXtUlw7tKdAQVuaqz3bfjwuv3bd6ivC58W4ntG0k3VvUDoKiCO7fgPl+zp6tDhD4NNAMjQqTBfXR7l2etG6tbWKERp8qFSqQshFgZBIGbhANMgo8RoeS+9qWyJvux6R3qngqy5QB3o0zq29l9kkCXz8ZnpF3Mdj5P6/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297102; c=relaxed/simple;
	bh=86y4D9O6WfU6swepFwKhUQ+UkqlgF3UsEBKQMaZLHW0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jAW8bh3mbD9DJmXVjNpU1nt/DF4xQdzc5URL9kQCwq+9BaINcz/C5LOaHilsPB5NHnSFlWo9KlW8H9Fw/8g2CL2wJCxEXXRW+V6FEZkLXGxvN1nJbFYPRFQ6b8X9jKTiFkLRXUZo/ghXE6ouQdzj7z5GI2Z3mfhV3uuOyF2ziRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mQlCXjun; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mvy46HmgWyHoVyWlWs8fpZ+qZ1WWGMjGX6+F6PRm9glfP77x/QzazH5pHkG4HAcALSaDgLO1UtF+r0JvB4GmJeQJTpFB0Rr/wvY6xBEpmuYHwqt2fAdoHbBM4Mk0hDlXNcMZHYXL0kKNtUkk72Zj82AmYIW/3nkbYMr0aYVzYxVAxvK32VXr84jZIsrNGLz7ODAALM7uc2JBjuw72PuHa1qyPt1A7x4tRWAYYBEf4fa5P4TnT0xUM9P8IY08z/B4CsO/H3NPcWLKIJcP0pSz4t0oLOXrFqbbqbhB1xloTHNGppV/Ho7/lg3fzWwaSegRPIdmO/IdQAbahstXWitUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9lDruemLlewWwSITxDmVUl80lEQkCkZ8ObnUUB8cmY=;
 b=Oq/MiXce407lRZ+m3tJJuj7t7zw4RINjFKI8Of3uIfQmP+p2mELCHP2EAX3cv+p56GNiV2o5hcy6v6Di+jHvgF2YKq1T8jyn+ZRpEa9RRV60jOKTOOqa3AWdezBoVewUd625DRfK86zwbFw7k2RAMqqDmbcKllYDj6NF/i+u71qNkEmNnH3iRfSnuysq+OZtVjHHuO9xFZo6FLyKfhEfCysEWMiHeXlv/sS57mMXQeFV97glEiVQWvyIOan0h7Ljx3wx7vPOa+rvNyk27rAT4UAxBN+5G9wNaZEMreNPdi0cccJ0H98c67N1eojdmLB1thg65k92uKLpuFpYl2Rzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9lDruemLlewWwSITxDmVUl80lEQkCkZ8ObnUUB8cmY=;
 b=mQlCXjunJDtc73sy1hAH7Uha2B9nbKppHGqGcLY5SbBIz0u/yp2Y2Hv00M5TYr61Kd7wKj2vSRlKGVpIGLqtFwzo1cgnV4W9Clwf3tA3+5q9V7SGeh7K7hV1fHlwmyVeEGTzH4+YwrW/7Uah65Gtngsiz5mrQ3cAahzUC0fIg8smSIvFzRnkkHuypw4+AcU5NGr2y5dz99YLntYIL1+OSO7DPYsVtHPrUIuRHHk1BwXrZ31cM1njgZ186GkFNDLwWbUN7CIUyuQ8Q9HbvOgvK+5rQCD4zvYd8mAsxP7vBMXVcUZlYiC1mZsYG1p8ygCGB+QE0mOvq8Wje/Vw+NwXEg==
Received: from BN8PR03CA0031.namprd03.prod.outlook.com (2603:10b6:408:94::44)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 11:24:56 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:94:cafe::b7) by BN8PR03CA0031.outlook.office365.com
 (2603:10b6:408:94::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 11:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 11:24:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 04:24:44 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 04:24:44 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 18
 Mar 2025 04:24:41 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net-next] selftests: drv-net: rss_ctx: Don't assume indirection table is present
Date: Tue, 18 Mar 2025 13:24:26 +0200
Message-ID: <20250318112426.386651-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cd19bf-59ab-459c-81e5-08dd660f8294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SYSoMqEHm0ChKoXlXMOXu7QpKTx7drCM+Mb6YKiE5c00i9x2E12/gxoDQOzo?=
 =?us-ascii?Q?AaUW1XZQ9L4kO6dRoh9cFYxKq+wPRavkRG6cscHsLey91ByuQFlJhWZUxiHP?=
 =?us-ascii?Q?eHiYfJhMCv2jm7/AglQFgQeBaVniBozHY/9rmMW3k1T0FxvquDjBpLGrDp7J?=
 =?us-ascii?Q?PnCMTiJ4QMUGHhszvSnME+hiSxBvcK7BHa5g3lgPneatzMmGHr3uMX/9k+9j?=
 =?us-ascii?Q?ajJX/DoP4BSvtIhOo7E5cILVaaqHcbF3dWB3dBChOT80dnfL7SZF+1VMz0fR?=
 =?us-ascii?Q?7xLxPf4P2aS+alB8O1wbiDhApCvBKCWqF06tWUaKNMRTFsBdFE6PfbGYi+hV?=
 =?us-ascii?Q?hnnt4aOMlEoQBANQbJpXK10s3pwNIo7i28EEsSsrfzlZWkZ1Qp8jQNUVorkK?=
 =?us-ascii?Q?XpIpRNXTjRxLRUNi0deU2cqReUcAaPmDsWoKRFm0x9j5EoD6+hU6PQScpfGN?=
 =?us-ascii?Q?b57KUfcHI0a5L95C3oHN9S6rPEDoeyEByNZfbRu6B3brHEl9G7CDD9hzXbBZ?=
 =?us-ascii?Q?IZp+qIuzn0o6ha1DdimlSmlfgdCAAINqzpdQD8vH1Tc0j02YiMU8YhtOfiYH?=
 =?us-ascii?Q?jlS60tpFaqSplcYCO2gxSDUaLj+WUe17LAdvsh80uLQYt0AVMReTP6tKJ2t6?=
 =?us-ascii?Q?rlWC6hQ0Aw8vNI2RkoutRzLA7zRdyEQA4M7TKiwfPQLpbOX3SJN8faNkEVD2?=
 =?us-ascii?Q?ChCqJ8ufCsUfEzUEYgeZYi5wibChZc8py2WsLvJ+8quV29T0Tj2+GCbDXx9R?=
 =?us-ascii?Q?C+DhDUnmB8pEMkm7wkT5qPoPLC/+tt2rq+JbqE7Ms3WAxmvfUAiWd1mdceii?=
 =?us-ascii?Q?BZNpB/2jY0p54N++fFMZQAHISVERJdCKAVZVHo7Zsk7eVOChmgxHgOa+qfEA?=
 =?us-ascii?Q?rX7gw68vvwLQMNOdYufi2kVUgDvMJGiE+ys6NpRcvhGb8xwO5ejW89qdTTVw?=
 =?us-ascii?Q?3uRb6Gw6ucCAhxXG0QwY2a/zHUGre8DAGNAtlG9iwecbJqtojtETejZtbHXr?=
 =?us-ascii?Q?t+HMoyorp4d4dZs99awOfYjYLyTkVWqOiyuhmWd341r1q0VwWOAlwwfCCvzy?=
 =?us-ascii?Q?ByXHhx/bf1zDFHh+5ddgSY98bGXnfNhsb5opcYnGcaXhc09us/4CNSsyhPy8?=
 =?us-ascii?Q?w9cK8QDeXygFSphR2Np0vGCfQ1mzjFj4B48rqR+qt0D4GcCB18DVZJnVWeGx?=
 =?us-ascii?Q?SvDirm6dWUr9qSLtAxpmf68AS18G8Uf8I+14NfCixXOyxTMxv1sSjSDShQvt?=
 =?us-ascii?Q?sI11MDV8pRK1RlUih7kcD1q310052O4OdFCLX97UD59Uh498RICJc6Qsz+dl?=
 =?us-ascii?Q?X3fX1LAOBdUN9Tjj0zTPZiP0LJU2oDjaAmwj3OKyEiva44J0BfhlakVk71OQ?=
 =?us-ascii?Q?h6SsV8h4f5wAuiw1GxAxl+D61Dlq5iVllXSttDSmIeERqsXbl26lpyyXXu3F?=
 =?us-ascii?Q?5PklWWe8Nz5R+C/C/ePik/+dwS4gGRJVcL/iKzJsRQsUYBF8iRJd6D7ODsUH?=
 =?us-ascii?Q?P8uEaZJYq5RN7wA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 11:24:55.5760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cd19bf-59ab-459c-81e5-08dd660f8294
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

The test_rss_context_dump() test assumes the indirection table is always
supported, which is not true for all drivers, e.g., virtio_net when
VIRTIO_NET_F_RSS is disabled.

Skip the check if 'indir' is not present.

Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index d6e69d7d5e43..ca60ae325c22 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -392,7 +392,7 @@ def test_rss_context_dump(cfg):
 
     # Sanity-check the results
     for data in ctxs:
-        ksft_ne(set(data['indir']), {0}, "indir table is all zero")
+        ksft_ne(set(data.get('indir', [1])), {0}, "indir table is all zero")
         ksft_ne(set(data.get('hkey', [1])), {0}, "key is all zero")
 
         # More specific checks
-- 
2.40.1


