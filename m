Return-Path: <linux-kselftest+bounces-35700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFF2AE6E06
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 20:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68594A13B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 18:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FF72E6D3E;
	Tue, 24 Jun 2025 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FD9ZsdbQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7772E6D0A;
	Tue, 24 Jun 2025 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788082; cv=fail; b=o3ZdOJ7yvFb5K0EuunpWkoH5/+e2X00ZsCVrvdVwxPbJf3koVgMTpalIf+w9EKddUoPo48IyGw7Z9/qOz/XcBTPQYLgpkiGSjQwSyMA5IMRVgp7ey6/0BI6rPUDP9wyNbE9T6Ql+1Ul2illG/zfW774doxuVGUvPUg6M9xgcYFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788082; c=relaxed/simple;
	bh=04XyxQRRzBQgOjR8cKmgIdi5k3igOXkg/sbPwAYnLgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fymwiMp2WgX6qtEWXZg7AhQlNzurVnJlbFm10+Kn9u0nRc8Q0DoELc2XdZ6GizBIPQLLal9Z3nVpozHU4P2tnNeftBO68WGmYhcwE2ArIKiyLYHIjNhz5iGyWc7TBtggD+qcTZiJrUGNznyQVQlGhOX4N4+ea9IrF/jphG7nWZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FD9ZsdbQ; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gI7RHBZWl121ZIEjikcKcMmYzsl2RoZhMmniC+y+9HtwG68BfzqUPCFguvUEOQG6HvVJgumJ3t/If0GB0AGYHWY8flDAaWQLHy17bb44+Jdf0oQTKUE1qtScdshg7TkubJ+qCBf+2isYGvsGX39WQsPmNeE+ZLIqCHmbYB9EIPYvgD4sOwRYpy2spoeRM+b0SV6xEjLD44Tjrtd3Uu41H5IOWj9Vgh95LJ8DhxjrdANlIkwnOUjHWNJc1gRto0vqTTxeFm+Fd2fCqWBK2f2U7+Lqff+o5r+Gb9Sfp2WzAN/nFAAruMnUBU7yZ0QrE9FACozc0IoArp7zMw4eTBNn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyoNO4gaYX+hc5AQGo86sv7hmN1Ryh0s3yIV8ODIPwI=;
 b=hmnX2qVBHVjT1g6SDQASNTEbk0GGFw9fArmxMTqhbHszLPa7z098EgNaDHKRIeo014p7YJwbKBbKmnElKcnhB9AoZBmFoWm7l6Sb6E83s+i2M2ecET1t+DXz0E8ccnREXFWXBU4v1fVNgiEQ9lJWJl/L8kXozU94ncNofJg4I/9zuI4W5XeokIy797BvUwwtDsg7oVhJez5+sQVxiBtSdsfUTV4OtGuLVkqQ2sFJ8f4JHm0X+e1CU7xTp1MIxnu+cm2RXiyrbPxEpO67Z4xA0+ekO0ZkflhYTkAKirlnLqT2DgDhzFBJF9Wv5iEZIhCdon/PSmeiSDv128MEg4Qx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyoNO4gaYX+hc5AQGo86sv7hmN1Ryh0s3yIV8ODIPwI=;
 b=FD9ZsdbQSdl2l2sRJsJFVu26HmcL6KCvDSJLoTQUmVReZWXFc+1axHu3gvytnE+gDHwCnGMN17IDLik4+JH9hceNcaiJlBDIRsaebBpgx8AzuTFxvV+4PW0Y/R9Zh2Bi6ZHFsuyFM19Xd4qSAukw/7CWWLIzLKMle4znpDozFoiF0HltbwVoY2MwIPXAafRE0v9e2v4FHcioUWwAcvhy+V2WKPxZ2q0OYKXmNIpSJ8+cxBZJzxdYqxSowyt/IjBvOB1PC6IEkMgSgxSRPo7N2eBnXfyWB/O26nwxheBeOewKq224mzEx+vAnTcOlrpfzY86StyDtOIVjmua/M4d7Xw==
Received: from CH0PR03CA0314.namprd03.prod.outlook.com (2603:10b6:610:118::29)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 24 Jun
 2025 18:01:18 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::d9) by CH0PR03CA0314.outlook.office365.com
 (2603:10b6:610:118::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 18:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 18:01:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 24 Jun
 2025 11:01:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 24 Jun
 2025 11:00:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 24 Jun 2025 11:00:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <shuah@kernel.org>, <joao.m.martins@oracle.com>,
	<steven.sistare@oracle.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thomas.weissschuh@linutronix.de>
Subject: [PATCH rc v2 3/4] iommufd/selftest: Add asserts testing global mfd
Date: Tue, 24 Jun 2025 11:00:47 -0700
Message-ID: <94bdc11d2b6d5db337b1361c5e5fce0ed494bb40.1750787928.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750787928.git.nicolinc@nvidia.com>
References: <cover.1750787928.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: c93a3696-08b9-4e1e-89d8-08ddb3491eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZwuBzFT/GytY/cocdRlvG8rhKRkj4MdtBCQqp+ZJSMOvxBF7JOGCkwxMxxPr?=
 =?us-ascii?Q?u0kz7QR093VpvMi3WsybeY0kPtGzpiEvMhk/FK2jt/ZsftLCRu7A4EYVPt+y?=
 =?us-ascii?Q?5oBLaMcqb+KrLCbZuswwzVhbKEAbKvX5Z+FWjWoLXpAnHH+HJMubleUfuLjO?=
 =?us-ascii?Q?4uC4u32HoTIpiRX6fiz4PTvYZdnGiRDldsgb7HIdR56fz2aiovewgrV4H4kh?=
 =?us-ascii?Q?lmF1asRClT8764Eop36V9xoP79FxxJlGAyyKiI2MXDi0So08uSKG5WJLOrdH?=
 =?us-ascii?Q?XMP+MuqizXVW5EFWgLmIV0X5hzIb5GAid/RZWbVjX9G0qS8LXOO5GUe8kEml?=
 =?us-ascii?Q?3nPCDD4uMT4QMDk1ceMvXnKcrD9NAhtSlI7R5EOkMxSFwsd4QS1wLLNLE7FJ?=
 =?us-ascii?Q?4XvXJOU0c5GB2mlvqQPJHyeQoTy0N1FGK86ofBCIozg9GnPab+qZdr3Tld+s?=
 =?us-ascii?Q?9g7LKqfOex2cpH7kvUFW6b/LsOp/3qh++RtVMAIC4IgRs+GXpLIAb66fN2Xd?=
 =?us-ascii?Q?sPLsoUT1zHz+i/jBepe02Vw1h8zB/67GEKQKZ1e+wKNnCQlaYFP+PKqq3b60?=
 =?us-ascii?Q?nK5JiRH1323/OAkepR6/C7LGcDzN6MCTUm+pYZGmN8awQGPgsIH5KLyqjzPe?=
 =?us-ascii?Q?VdTqfaiUpiOssh09uH9wMKnkPR75M0HUnTzBXygYJRi3s1jwIx6Mq8RSgOIr?=
 =?us-ascii?Q?AEnO8F8UgJE/zLtkPvM8gU1Ony5nDdEVyk2kN0bTDGuttNVSVeGjqfJHzt3M?=
 =?us-ascii?Q?DP9vRv9qkgAkaq9byEleA3ukn9FXiNe+77K+KKiKrhHgjX0A1Ug+SMFLvarN?=
 =?us-ascii?Q?JAaXBVGG54KNRhw6rGDr5XOx2uKVhq0Yh4KihoZHh/axn7S7U24oWPJlcK7C?=
 =?us-ascii?Q?guwkhUXqv0aUQi8guhdoLB+5vRbVGFG7xnzOQtglCjifvCALzbKjzYqE2YkU?=
 =?us-ascii?Q?l0d5O6jH214Jf0eIAMHzH3YTmaVCjT6SYOkf46RlSFnZaMi7SpuGpsHPP5WL?=
 =?us-ascii?Q?4qXyT5iwodnjwPrkslRxScEPKuNQGNTpPg4kbYdc8xT0uV+pso77CGvJSJRx?=
 =?us-ascii?Q?cyzIgHm5fLmppACt7NWZnPerUPxFq725Ike7Gr9fwgvPtljqNG9iE6MNV9gf?=
 =?us-ascii?Q?t/p3MYgeOb+UTaGsFFIbBFaKcLrsQi0uMTi8f2ypcAF1JstYTrGWXlbmKE5g?=
 =?us-ascii?Q?EFQZgfj8NouzKaw9ZJPfQNriksEz92RuXUY+sswQxdCGo5PcdB+z4NwG/RMS?=
 =?us-ascii?Q?BVNMW7SxYdayL1Y3U2+TMKbw3gaFy2gG9FqvJrxOfVFQY0jY89fUDSE0xRBO?=
 =?us-ascii?Q?nV0B8FtBTNxh8qJtER0DXdsGWvnzMTzcCe3xHRIoXSzRydoonyNyghEIeppI?=
 =?us-ascii?Q?48vocxq6PjI+n65dplr9Y2kBX9dOQGkWjNuj/xq2v0NTk7SSUwNAg8Zvw2Kp?=
 =?us-ascii?Q?3PYP1aDoY2u2qvesWVyGlr4sJ/91fWkOJYK+mGtj3kF0lJ1Ezx6Bzq9S0pOg?=
 =?us-ascii?Q?MC2WRysAf6fiHMLT7xpplDxUMJm8OKtSKsTP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 18:01:18.4775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c93a3696-08b9-4e1e-89d8-08ddb3491eba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336

The mfd and mfd_buffer will be used in the tests directly without an extra
check. Test them in setup_sizes() to ensure they are safe to use.

Fixes: 0bcceb1f51c7 ("iommufd: Selftest coverage for IOMMU_IOAS_MAP_FILE")
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index e7eb11a94034..e61218c0537f 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -54,6 +54,8 @@ static __attribute__((constructor)) void setup_sizes(void)
 
 	mfd_buffer = memfd_mmap(BUFFER_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
 				&mfd);
+	assert(mfd_buffer != MAP_FAILED);
+	assert(mfd > 0);
 }
 
 FIXTURE(iommufd)
-- 
2.43.0


