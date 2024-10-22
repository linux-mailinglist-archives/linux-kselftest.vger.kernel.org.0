Return-Path: <linux-kselftest+bounces-20355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3B39A94CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991C61F2245B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14061E260F;
	Tue, 22 Oct 2024 00:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jKEVBxop"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE4A77112;
	Tue, 22 Oct 2024 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556459; cv=fail; b=cnjtXuPlZRNSuN+nMAFj5qge4d8PkPAa9caRxApOuLnc/7eRn45InenLvauBbX9PBfaaSROi/E4VmMvOXsDf/hKCX+clcTWcCOGpRCmOK1qYorPDAfUUNCvkUwDjQqtBeM0UEq+WbhtSpHc572D3xs2aAgYtrY/pdGwTjESrvCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556459; c=relaxed/simple;
	bh=TwiLL1Nm0csORTbYWXzMd4J+IvnS5W3k90pmrHFhI5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXLoDyxBIic90k/1nI/K7NkyvhOQk/18NZ7cIitfejcclVH5qrkGqwdVKW/9ETP7YnuM1YxCZxWJyhn4A8MSn5EoJbcTZR0Dsp+kS5Pmu73eZ7m1NqIsI08acEH1n32CTncy8gxAENS2eCCdr6wxAio+ddHwRR2dSSwKA7H3dqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jKEVBxop; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ew5IJxsXy/xIRB2k/m7KoUgq5bYSoapoG5DCmN2Z+oj8Acl86ExZjhI1IIanULxPh6owuHlGLbtecsAR/vYN5ZJDlqw966M0KqW+MZW6Ll1GY8ec5+7c9GqEAkmYv+07tklOJ2I9jWpd+iPRTaBddSS16AR2MhE6l4asuH7rjULX09TVzNHj3QAWw/fjvHhoyNivTG6thDbp84+nRTkGvmc2TcUell43c2cmyPVkP4vQy0z5hsZa9BqVaAuTQea6109g0e8MLm5r5QTFo3Ecp2YrurQSRlHVvbqt4fR5dA63FC4KPIto7sP+yBs+oehl5huRlM6Q3WV7IWlKSqH54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbsA2m98T3pNucsZDzhx6Qsfim74k5Um+RCGSXdg/cQ=;
 b=GNUqqBK8luiSoJgfFdD62Kr9gJBnXtSd91BERfPVWIUWarqPHOyYbXL/haBFrSRXzoylEpKePMyJPdkSNJ+mNgeZEKWa7QsJR3A2pUlPBN9BNfVViOs3rnq5h3hoMblTuRyfzSnrrFdcyPHgWavK23wCRSCeqp+Y79lK/wZtoX6kDXcqapWG0HCKgL+kv4ydT9+Glum3tD3WUi1DmUgJJZexKxRgN8q9CZTwHFee9wENBblRQzep/Afz1s/l3HhoYbJHO0r79/vnJ8K2EXH9f+1O6zuUCC/fQixqVnCt+Se0LZmBs6hFqJE6mdK19mW0DUZIGr+aXayulnWexW/Ntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbsA2m98T3pNucsZDzhx6Qsfim74k5Um+RCGSXdg/cQ=;
 b=jKEVBxopD0O8KEUbd7kHyYUI1NFe2TqH+f31+4iKqkKtq1zmqItDZZdcFKIt3AZ6MqFSvLaIRzC/IC+cRLEpIN79L6HEv3piLocQwEBObzwk6NmMb6ANO+9eP6ca1x+WYsMg36wt3ueHSmCN9xXpwSBaxjfeCTvq7xc/fJ+k/oAOLVa6p86byWj0KOqCtbc9Zns66VblMVNTRdR1pP1hgx97cjQlenwOtMr3vj7gy8MCvhY1omq0mNLtTnyZVWlj6z9p3YaaWKPHCEh72wPcOEn0lWaJRO6UKTi6LMUcfvITxvNE/dL6VITHMhQTYrccZbnK+4D2cbnQtK6oMcPBlg==
Received: from CH2PR18CA0040.namprd18.prod.outlook.com (2603:10b6:610:55::20)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Tue, 22 Oct
 2024 00:20:53 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::61) by CH2PR18CA0040.outlook.office365.com
 (2603:10b6:610:55::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:39 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v4 08/14] iommufd/viommu: Add vdev_to_dev helper
Date: Mon, 21 Oct 2024 17:20:17 -0700
Message-ID: <3eae567a6d674cae144c5fd36cc8eafe84d6a24d.1729555967.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729555967.git.nicolinc@nvidia.com>
References: <cover.1729555967.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 86111bc4-b556-4e0b-dd70-08dcf22f6400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ezx8r/gorELYJmsmQeX6UKtWrmceCZzGOXScV2OR5K/HkEn1ecd/Hh9w1Z+V?=
 =?us-ascii?Q?OG845tkftr7PKIZiP+fIVRVKU3k1SsiSa+9ApfYgg/j3Thndo9msk7N5A5uh?=
 =?us-ascii?Q?LdKkEk+rUNmkzQN5fCkT1dKqGkb49jO5WuUmhb9cVkTOuoynfP7AwoYClx7d?=
 =?us-ascii?Q?tJYlwQ4i34BgullHbiA7boNzQi3fEvN41R4wPxUNlc+7WDd4bkvhWDd7i09P?=
 =?us-ascii?Q?5FNxOGQM+Ue/gFJcBqR3/qoiXiuCKRmiedkmr33jZzm6lAT3h5QIOWrFD7eX?=
 =?us-ascii?Q?dnjf0AViYFIdolCXh66nlIyYIveulB/BlenN5T46CB4XKdi/2N3JEbtwO8rf?=
 =?us-ascii?Q?lif1uV64d+NWPDpEJxnfgZrOU4W2n2/dFPoKNTTwxAiKUBLXAokTbKg37sKw?=
 =?us-ascii?Q?0izLa+rrBfKMXoGybi9qFQaL/epWr3oNbkPsMJe9AjlbAXrvWoc6rCdmUSVV?=
 =?us-ascii?Q?Ck+GPqlwMTOo9TqjLPjd8uPTRcThrTv+JEiU45HDkVFljJ8ktqTajM3PzSi8?=
 =?us-ascii?Q?RiSQzsxKomComQ0Q+yiw7/pCCoZrm3tKODPCaZskg3J2rJHxXEvUC6A16bI/?=
 =?us-ascii?Q?Nj7InJrXF5AvUg/wqWOFHHAcPh7Tmno0um+CybXSpuijKdBjjOfCKTY64B4V?=
 =?us-ascii?Q?Sy9oH1IyqRcxlO3V8vK6VjEi9N9LtiDph6N2prughwuCRN1lnrWd+epPmdwy?=
 =?us-ascii?Q?C8d8sNZqc9q+gr6GvLhJqXar1zJanaYY85D21PHgCaMjxeIWXAXJS2goLGYE?=
 =?us-ascii?Q?jzzkJfhrcbv0quHMqj5Xh2G050V42/KI/CCQafLyEo1a35QPA2ETyGscBsX5?=
 =?us-ascii?Q?3fuQTHoq/YQ0mCChhTIPRzPTwmvjvOyh6HdptoRuByE82S8/6/0CkjRL0orm?=
 =?us-ascii?Q?X/uMML8fMKOJBtNetPNyVl+9zxqUPID7xRXJLPov6ucrypTGfvPV9twYZ338?=
 =?us-ascii?Q?074ldj6FuoaRqd2zdbunNFDRbh+RbLwq39bZhJKSaBNspnUoZyzotomqyEc/?=
 =?us-ascii?Q?78I0tUNqahHKZ3c1StO50ql5tDxYZNtXzNSCqcf7rKpFqGdQlP8cM5prYmRE?=
 =?us-ascii?Q?w6x86FzOShKemnNVGHLie+gul4VSMgKpcOF0H1ZwhNXopIJeMY95IwkvJxur?=
 =?us-ascii?Q?J1A8M3Tnnd1uOVe7RgTSu1Sh8WzXpLJM2fZPJjd1+O16ZP5Qze2FG4ySEgsT?=
 =?us-ascii?Q?alqA4KDBElNcAq5TB4Hqms85FUWBdhhwcM/7okujn7jsopAMqhMU8AnVRtMm?=
 =?us-ascii?Q?xhx20mtuF0jmIklzH5yl7mzpWtv/RFpznLVcwOGNqqe9UhgOLOYIn25Y3Pih?=
 =?us-ascii?Q?ujNtTQ4bS2BI7CPfs2h7blw4qRwLEkPSdx5AhEqlhnXsIt3c8xgazvoxB0dP?=
 =?us-ascii?Q?b+k5wMDyjYqrFasSTKK0HbKHjoC5lja/anWMyN0HTe63XJ0cqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:53.3368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86111bc4-b556-4e0b-dd70-08dcf22f6400
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740

This avoids a bigger trouble of moving the struct iommufd_device to the
public header.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        | 6 ++++++
 drivers/iommu/iommufd/driver.c | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 559f274a26ea..2f4ec6e6df21 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -204,6 +204,7 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type);
+struct device *vdev_to_dev(struct iommufd_vdevice *vdev);
 #else /* !CONFIG_IOMMUFD_DRIVER */
 static inline struct iommufd_object *
 _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
@@ -211,6 +212,11 @@ _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+static inline struct device *vdev_to_dev(struct iommufd_vdevice *vdev)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMUFD_DRIVER */
 
 /*
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index c0876d3f91c7..a5d750d2cfaa 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -36,3 +36,10 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_object_alloc, IOMMUFD);
+
+/* Caller should xa_lock(&viommu->vdevs) to protect the return value */
+struct device *vdev_to_dev(struct iommufd_vdevice *vdev)
+{
+	return vdev ? vdev->idev->dev : NULL;
+}
+EXPORT_SYMBOL_NS_GPL(vdev_to_dev, IOMMUFD);
-- 
2.43.0


