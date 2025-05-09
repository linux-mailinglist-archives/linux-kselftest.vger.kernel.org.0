Return-Path: <linux-kselftest+bounces-32706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33850AB084A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086F3167323
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B554A244678;
	Fri,  9 May 2025 03:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g/OrNTjP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB09243958;
	Fri,  9 May 2025 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759812; cv=fail; b=ZQfCjM9y31jeELyyNoZtQOKHdYSYMTqTnrDBiQz8vEnHYIYxbuFRz2qVeoWY3zedkK2ca4Arll/ODpCLtxxE9fIX4lJTAovPjUEvbZr/k8vxciJ1UgwKSClNYLOg+laV9Gdbte3ptLSvnbRgnEj/7JMVCG411rK6eZFBp+/TTq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759812; c=relaxed/simple;
	bh=8xffzRa9VnmoUmzBon2uEOrG6G51T4j8TBEnKiVrqJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHOSoff1hvRaMHbIChnEA2ak/jdzv9i6dVdqgD5AgwpPN/+xYBGsVG5kqir4EZopykbx1PWYp7mMGqU5xUAqP+UgGpvYIzlGYiFiYWd+UOMAeMJeSuRmMgroVNk0uwJr+OFtvItq/uIkCCv0u1OWcRvNCsG+4duqwHYANjtoYak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g/OrNTjP; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXlfgNX79ZBD+fkU1U964hF7laRb02UFf/ggH76OwHphfZEpWTDGLPA73Ucqif16q/gwcNaJqS/F8a13dl0l/4f4Ge6YIvOnBCNm/Y6fK+WTs6R/x3uMNU27+t7IPcDyvsQeF+tJzP6bYzXGgXWCsQf/oo6i9KFCSvCvYrMWM4xMPXjfg54QElN5C1mpkZ4jYxC+THyXDpguAj637YuOs/pwW0q0rDDVlyluglA/MVG2IBdRcDL0uETNM5KxwbzkHiaaciXt2jNvvEQEtc1/qn/VFs6KngU5T8A1HqreECA8GQb34vj7BhqcNEmBST9gcZeciC35TtXHzWNv+880EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JzjpwTivsLNcX5B3CPY1/1i15yDxNbMqo2IM1DCtjk=;
 b=rcxGCSOh9KU/fDzJjbR5p3PP+wSSerBSytWSIQAVNqAYvFLZXap4JXOWBJki8iftEGeOBOo8uVoqcLN9dR5Ge+DXdYc8B1S48ruf38o8oOiDEQHI9wgIrXxvAqUAh/3EyToaApczyjKd7IhxifoCmevoHVfNjGvKwtpwI31Z/mXvbxVVLmHyyJ6cTQHUhSv/rDIQaOzx93ck5hbGPmSdz04k5Ua90B26RbgtFipjJwn3cFX7rALnIoMxIpJCsbU7PirMf6hyX/i5GZnX9rb4GYoGIfj+1aaXbQUkchDGDaJd8yeniTqi0OZZWxjBUhZ0NiWLisvHPnJZakS2LlJHoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JzjpwTivsLNcX5B3CPY1/1i15yDxNbMqo2IM1DCtjk=;
 b=g/OrNTjPysoxvgiCJpBSjeXaY+oHJTqDuxkN4ZXbi8EXUg6H044iYPLA1iB+FElf9nWrNoAtDVBruDKmu+atqtwtcse9267zcGTiIHNdM8HDb0qFwsHbkcRF66broztIyGfsG6x7VvVPeiOwlZj2IRXOvR6q6VydLhMsMDkP1kNoI87v/cJmFb/yzVzvRknYRvX0IXbxKl9KcBcy6F00731i2qR5jLIBJdxBV/yfb7y6uLQc2v0RL5xCyJrrQusLODHEvJnnTB1cBbMVJqC2lJ+M4No99t7X2a6DKpDbyEKjUQn4ZbyhmlWBphwM8Y4/i185ceETjEmBXybvDNUFow==
Received: from SJ0PR03CA0219.namprd03.prod.outlook.com (2603:10b6:a03:39f::14)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Fri, 9 May
 2025 03:03:23 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::53) by SJ0PR03CA0219.outlook.office365.com
 (2603:10b6:a03:39f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Fri,
 9 May 2025 03:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:14 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:11 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v4 07/23] iommufd/selftest: Support user_data in mock_viommu_alloc
Date: Thu, 8 May 2025 20:02:28 -0700
Message-ID: <7cc29f0d3617f464c108f730a3f611d1154e8cbf.1746757630.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746757630.git.nicolinc@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|MW6PR12MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: ba03f665-1374-4f0e-2bbd-08dd8ea60fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G9VR6wJtuK8XTWa9xvVveifPJ05y+q2xqgTQKt/dDBTOBE4x8d79GueVYOVS?=
 =?us-ascii?Q?TmtNd3yUVxG/IJcfiPxY6XtiovtrsRfVGuB1rgmRDOv8tNap1ay/QAX3eIth?=
 =?us-ascii?Q?CpgxVkU8LtRDzRjokVOnqe+bXxePlUyqqN6jSUz66L874IgXHn6hBbTNaWxr?=
 =?us-ascii?Q?dggbSV5yrzWbQWZmsU0BekQCeO5GOdmlNHTL3gfUm89qNoflC7hR1tRsLo7m?=
 =?us-ascii?Q?wpUBf/oRLz1ULcy7Ar7TV4DeBJv+r7bz9qx23ZzUp8fLc5DFHEwCk4Ln9OI6?=
 =?us-ascii?Q?jtaayLlhM4R4i5c/5KlH+4YzQtdhAihc0cZIwkqz5hGgt91B9mRlrAXgteHL?=
 =?us-ascii?Q?nbhLyFVF0TDlWTcz5hTNaEYLN7+8ZHZ7ZyIXVIE4QxpHrr5/O9ahShCj/9aP?=
 =?us-ascii?Q?uxUs4sjlp0SX4gbbI56784DMeRdk9GC6g1A3WmZvFsdw1IUcsLzRqeSjdgJy?=
 =?us-ascii?Q?bzdGL4R9irwEoQ7FF+ryl53UvsAKOa3lyQGiI8NAfAvF0rpnzfDfS7dxdlvr?=
 =?us-ascii?Q?s2gnJdMzlnD7p/at+ap67T4/BC3VoFXAbnW/aIE4LkF5A1ZrTssDgAOzJZQJ?=
 =?us-ascii?Q?kmerkwT2K9RKh81b4Jo95SeJtA28xHjHsmCJWDva1CVaPioT5Vx/Fkjfrd/l?=
 =?us-ascii?Q?KSd/pqEpwa3piEP9IZaUdBqlgg1kQDekZr9sFBZrRAFKaKTkCZLv8pDJY5tQ?=
 =?us-ascii?Q?sgmRVJhr17sxdXtZs6HIPmduhoCJTjF05G0NabfF/8ugyO738JGNX+JTlbZM?=
 =?us-ascii?Q?Ja8Efi6ype+TNS2e2hyi0izjB3yFg3Jko5hmbsJ8tEPCEzThpjVUrpNqHdXc?=
 =?us-ascii?Q?8u8mtSqKtNVqBEAa4NZx2gK1BgSZiOkvJ3fCSOwL3Unf78kmVnYBeu+lpXh5?=
 =?us-ascii?Q?n5NiC+Qy4b1JqzuaGFgxVpY/08vxlE82IWVxP1sDHa/yM8YN+sWjkJPEqwkE?=
 =?us-ascii?Q?jQkRkXwPCGA5+0w/WYHTiZenAS530Szrr1bcYUoahquTfelkohRPBQsmYaW7?=
 =?us-ascii?Q?Q0ttUWDTMEbXdZgxWZBeSuRh5SONCfi/miSr1ims+z/WbXgoF0TYJBoYGNVh?=
 =?us-ascii?Q?PeTD5QUVYfaGcd1AtnqM1mTFHqseIziHxM28kMZ8uK+iJffb1sQoTAaJtDRJ?=
 =?us-ascii?Q?QONod/4AkeV94UeyaR6o4KF4ayx1lXzcxg9P8r7b0hV6sxSj1EtoqzkbXu4i?=
 =?us-ascii?Q?o65odT+99A7Ml4a+vMO4+pM7p8bbOXZClSGSdeiFgkh+wC0mS60BbqmHcSFH?=
 =?us-ascii?Q?fBxY/bDoGb+KEQg4ToJxxD2Uf+dB6Axa5h6fyR+oI6GRlcPnQ+8x0130ipv/?=
 =?us-ascii?Q?GxPqcYEYPPgW2W8lVbCo92hb6fwofKHvoIDvqY5850wKxiGqlKknnQer1hxa?=
 =?us-ascii?Q?4S33llzVa2zuYiOG++8+l5wF1tpVZKJbvTZW/Gwt13Dx6RTsXa3geHBUHZbc?=
 =?us-ascii?Q?MPbQl2ptBsxrzICkMpDe7DF4u8Td8EBTdsCIWb3I2+N02MsLuM0nfFT1thjO?=
 =?us-ascii?Q?pU4jLQbfFk+OHvNpqzb/ku6KoM/74x6YdFru?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:23.3972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba03f665-1374-4f0e-2bbd-08dd8ea60fa6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898

Add a simple user_data for an input-to-output loopback test.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 13 +++++++++++++
 drivers/iommu/iommufd/selftest.c     | 19 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 1cd7e8394129..fbf9ecb35a13 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -227,6 +227,19 @@ struct iommu_hwpt_invalidate_selftest {
 
 #define IOMMU_VIOMMU_TYPE_SELFTEST 0xdeadbeef
 
+/**
+ * struct iommu_viommu_selftest - vIOMMU data for Mock driver
+ *                                (IOMMU_VIOMMU_TYPE_SELFTEST)
+ * @in_data: Input random data from user space
+ * @out_data: Output data (matching @in_data) to user space
+ *
+ * Simply set @out_data=@in_data for a loopback test
+ */
+struct iommu_viommu_selftest {
+	__u32 in_data;
+	__u32 out_data;
+};
+
 /* Should not be equal to any defined value in enum iommu_viommu_invalidate_data_type */
 #define IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST 0xdeadbeef
 #define IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST_INVALID 0xdadbeef
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 8b8ba4fb91cd..033345f81df9 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -740,16 +740,35 @@ mock_viommu_alloc(struct device *dev, struct iommu_domain *domain,
 {
 	struct mock_iommu_device *mock_iommu =
 		iommu_get_iommu_dev(dev, struct mock_iommu_device, iommu_dev);
+	struct iommu_viommu_selftest data;
 	struct mock_viommu *mock_viommu;
+	int rc;
 
 	if (viommu_type != IOMMU_VIOMMU_TYPE_SELFTEST)
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (user_data) {
+		rc = iommu_copy_struct_from_user(
+			&data, user_data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
+		if (rc)
+			return ERR_PTR(rc);
+	}
+
 	mock_viommu = iommufd_viommu_alloc(ictx, struct mock_viommu, core,
 					   &mock_viommu_ops);
 	if (IS_ERR(mock_viommu))
 		return ERR_CAST(mock_viommu);
 
+	if (user_data) {
+		data.out_data = data.in_data;
+		rc = iommu_copy_struct_to_user(
+			user_data, &data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
+		if (rc) {
+			iommufd_struct_destroy(mock_viommu, core);
+			return ERR_PTR(rc);
+		}
+	}
+
 	refcount_inc(&mock_iommu->users);
 	return &mock_viommu->core;
 }
-- 
2.43.0


