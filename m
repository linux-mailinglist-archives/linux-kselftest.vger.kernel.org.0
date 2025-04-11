Return-Path: <linux-kselftest+bounces-30506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C4DA85446
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775E59A7EB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 06:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9D427E1DF;
	Fri, 11 Apr 2025 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uBatZkBw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE0227D77E;
	Fri, 11 Apr 2025 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353512; cv=fail; b=CNMISKOLuEgtd9siAON921y5VAUXw0/ro85G1KgBYQbiKYWIqX8E0I4OvdkupiJg8+5fuNHskCAVNVtemavb2M4ouLBhLG6x6/Q0Byu36tk47QDrXSBWnPRookokWDIR9qKG8CSStNE/1cUhuUWpCxBx3EG4PajpnW/FOoUYHfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353512; c=relaxed/simple;
	bh=+0uRN3R/mzCTmXuqInq4Go5cgXmd5Co0AryALVglaDc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvZfJJkR+AkJAvK9vdZnmsPx9PUkNDXcivFeLUSxVJQ5YU6GSA3PYQ/FjfIPLrrLKBugroF2aduw6XBgBNcIAKIExz3KDuoV4HQfy35zk0BFP7AZ3MgGaRnZU2sHVJKelPefGLk3cuyjjYEgmCSoyeXH3VsoYbKdo8Qa5aENsn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uBatZkBw; arc=fail smtp.client-ip=40.107.101.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C94K3S2EpGg0RWLMoTy/rSXGhFXte/APkRG5ia70Qs0w22VspxNwBmPw2zx+mX8bYiavXORINUHmSh9rac6QOJSpF1voJfNOnBUc2kTD76P/GwG9GGnxgekZR8dOT9rO9e/OkNRvy4fyj3hfIJErgOnkRErUQ+91L9VUGreurxraYCRR25pAYrR2jSZxg3HjqHT157vLPabIgkvFFSQM/jY2+SizRabkIY8J2Zxg24T5eXUryxfCrmA6iBb4+3JI0/HeDP8EU5gqMQdQpcJN3yRKP0hZ8ohCS21CXZBZLUM10OLzB6O94bMPEkndAXA5nNqEXHigs6eomXPxIREyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rb4dE93GBXOPqFQyMkv7i7yt20JqCEkXJ1wa1LFTUs=;
 b=TD1L0LqPPW5KqOKrdX77SOspx7Ah/PU0d5e+Mbjen8yhflzYBwXkrqYPwTvxnuvnaPhUhT7/g1F1PbBCowm7wEwK/i++vvB8ujEo/mzPMqAjFqJZmsLTJqvdovRctiNzwJqVUa9PVPyNRnC2ZWYTP7VLf7cAErTcurfdlaPu0wmV0/Xmk/wK7SCFna86640/UE7CP81nevMkDUE9DwtBTTCIGEf24pU6BV/x2j2A9rVC5/NXoob9InWFRUA6wPUYuvGXPKl0l9YLxFj2KjWxJnUClY/dXLoTQ/Hjtxgihh8Oi4E/c+hskpU3e5uWLRJQ9M8/tOD4IyNfXNLbX3OZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rb4dE93GBXOPqFQyMkv7i7yt20JqCEkXJ1wa1LFTUs=;
 b=uBatZkBwKUhl6xmWoYG9gNt189KXxtRgFXYz9V4NlzxuuQKgWigGAavHbcIqkMs/2gDnbKpLpMceB7O+7tlxzJAauW3rO2EBZGO9xDMcL8LGrltjMh5tzOMZDjDjyTQbx8CyM0YXU+WeYIZdCwm1G9vLUE3HCarCC0uINTr06DcxYDCpQhDumLpop72Cp982ToxlpX3znp5wMAAGcDK1g8lBIiIA9cx7ii6whtFn7kei235ICVMmff5mhNvfoW1m202QS4douAiepbvBIG3TLGQo28m8CNT7uuTFR3hOiMOvyx0cmAs5iu6xLo76DoVmY3xHjSUf+VIVZGk5QXhLfA==
Received: from SJ0PR05CA0068.namprd05.prod.outlook.com (2603:10b6:a03:332::13)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 06:38:26 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::d5) by SJ0PR05CA0068.outlook.office365.com
 (2603:10b6:a03:332::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.9 via Frontend Transport; Fri,
 11 Apr 2025 06:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 06:38:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 23:38:15 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 23:38:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 23:38:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<praan@google.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <jsnitsel@redhat.com>, <mshavit@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH v1 05/16] iommufd/selftest: Support user_data in mock_viommu_alloc
Date: Thu, 10 Apr 2025 23:37:44 -0700
Message-ID: <05aa9acfafa0d92f76c9394d49a9a5c7b29ae94a.1744353300.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744353300.git.nicolinc@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 2439f184-b72d-4353-84e2-08dd78c37701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V6BFbwTngqIw0r9I4IRiiWwHU3Q/XDczivDomxlP3v5vxSc9K/OukauRfYQg?=
 =?us-ascii?Q?4NJPu5mMxqNbXMc4L42CZCAHaG/CSaXkHhdnB+Jhyyfx8zPNKtJmx4s/pcWO?=
 =?us-ascii?Q?SLUmrq90VilI0jIZGt9xjbrfcBTuW3B9MUC59OKzHEX1/mxgScp1aBjLWEZS?=
 =?us-ascii?Q?s8rGz8Btnu0VtSwvOutCEAu8OGKduApUe9F1VP79WOK7PRE8JC1LL6eXM7Sm?=
 =?us-ascii?Q?WcF5y4yMCEbHV7fQTWtYZvOOJV3ebBeOxs2P1F6qoZrsTtnn54YwawOoSno4?=
 =?us-ascii?Q?ChvqlN+gpLb0XA5z0nwYS5efaqdmfjddginiID/ZiZVP9VYqj10Cx6Ha8YnK?=
 =?us-ascii?Q?I1nUF8twf1DiJTF2hFzIXzLQUYdwtRkzi1/Drqv+502+JkjAlUPhCgj1c0UK?=
 =?us-ascii?Q?VnssfVzhfBIYethfipFBxtYcD19MQf/YLpB9X+a5LHTCnt3W/zLNwrFHqAzL?=
 =?us-ascii?Q?s0g2a8KMkohBL74i+m6DNA7HJXbRZBC1U6mHWrUYSlcqJlQ3g7e2pp5LBNhz?=
 =?us-ascii?Q?OFeT43zfpPBovDRER8iz/WAV1tRNOnFAFyyQ4n0JNUAz97+rq4xh3QVBriE1?=
 =?us-ascii?Q?xKUQcajdGJHafzPNfJm3ZVvm5eYFr18tAhmpg79Vzfz9mDRyjMVwBBHil7Aj?=
 =?us-ascii?Q?ndNLkhvecrhu0whI8ZMI33ytFUxV8A5XVpreO3sFcnAYmralNfGaOmV9Zp4Q?=
 =?us-ascii?Q?pVARRExbyj6LvABx5P6IwsdKRgw0QE4q41EeUb6mlfqtLgKd2aUVrBYd9Rv1?=
 =?us-ascii?Q?CkhI5EBrbCp0/g3AokmD2cRozk3AzY2oafRTrnJwb5+YPJhw89pnTRXmVRcD?=
 =?us-ascii?Q?RRQw4WczvQyS9a0TCy0k4s7ehc3D5dimcZZcIwvpXxXgIkPBQ/J1LI0zdHxt?=
 =?us-ascii?Q?STcfAN2x/vjWYp9OWv8JYvb5LjIJ2p9dLJ8NFMN5n9JP1sAHrNmYfgPERVxl?=
 =?us-ascii?Q?Gz00pDX9FgV/b006LhgKlvePxLtZrptU1wE0dd5T2Q3E4LlkhpfEQ97WEjHK?=
 =?us-ascii?Q?473CvRLE4W5p9LkjzOP1oNhtqkZwDhfPVbYYpLbsAU9CU9WrleH7hwqeW/SD?=
 =?us-ascii?Q?5+WthnY3VJX0pmds7HdpzOSoXBwluGcJzkHqhtx5klgjJDAm7PzLDdTXJ2Is?=
 =?us-ascii?Q?ZW7xmKw6cu/8DnMJFZFaCLYhloBXyFNBHngl0jHhLeesuKXXOQ1lMEmd+xFG?=
 =?us-ascii?Q?a0cnX7BnuFQeFdrBbo3rcGbG4bg8u5OgIA2Vwd1xhba+wDcG8iDwezAisc9j?=
 =?us-ascii?Q?RxuOaayykMo/xRTL4A1qHpD98DSdedbcjy50Zwm8zbzXgm7FnOP2i29Rz1hg?=
 =?us-ascii?Q?N98k4DFfPmLpupsaarIkJkFjWq+lqoVJuBak37K5nhK6bmxZv2cGZE/og8Vp?=
 =?us-ascii?Q?JmBChLEpLXNGXd5BvV0zb26w9U5evA5DT3t21QVvwmu43j9D4MvOFeL6Txdd?=
 =?us-ascii?Q?uEimJosMbr7GX8t5d+nGK8UnUiT4Dj8yeOIqU4Sn8JmkYkgXuJ/2bZ6ujNLZ?=
 =?us-ascii?Q?SkFp5IYn54lyDmFm9uOcqnQbfbQMN12UpoVm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:38:26.6241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2439f184-b72d-4353-84e2-08dd78c37701
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970

Add a simple user_data for an input-to-output loopback test.

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
index 8b8ba4fb91cd..b04bd2fbc53d 100644
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
+			iommufd_struct_destroy(ictx, mock_viommu, core);
+			return ERR_PTR(rc);
+		}
+	}
+
 	refcount_inc(&mock_iommu->users);
 	return &mock_viommu->core;
 }
-- 
2.43.0


