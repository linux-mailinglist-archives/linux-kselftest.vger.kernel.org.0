Return-Path: <linux-kselftest+bounces-16453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C971F961517
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0671F23F5F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806C11D6DC1;
	Tue, 27 Aug 2024 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h9b4BuvP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819CC1D67B2;
	Tue, 27 Aug 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778188; cv=fail; b=CQIe6N8si6GgaVPshIB3K8bVk5GHFwxqJYDjHBHU1TpsyizVRsJuioeNy+Zjc6EEGVLt2jkXHeLGDv6ODpuWANLFlpz8I42xCqYWRCvO9BiQLw9QenR/yzaHVDaTU3VSgEJ2VYn+VKLU2GRhhX4s/BU2nqTU6Rv7qUC72bR/jGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778188; c=relaxed/simple;
	bh=XBWUaalCeamsmPkm3BBzRZl6UeR1IzpwyM36pH2JK0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIOO/YarbJtNDnO50kIAl3MerHQ2K5NpuYaUeItq7iJraiXsYfUQUF2DbA7mXGyjhHU5UczVOJb8pIWuBM8e11E4C5mVk17WYjsWd1YZs4+TwynbmKeQ+eZquacMJZtCyF5iJF2lnZL3eA4glzQWDJdSbBhOfiQ/O9Fhjrr6aGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h9b4BuvP; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2YqaXJ1uZiP8vb2WZbVSV9xqU1gUdlW/9wRO5PrrdFGU4G0y6MgNropBkeUS4ppqfIAor2s4uVtaFoUWR5BWYMdh0R2pX6+c4oxeqc1oF0IhW7mEV9lE74BR0icUJvBZCS6uxLquHMi+V999Cj9rd9p/dKWYcHbf1acrHtwEgbPgAzyKR9YzP99vlaKwNkB8AEeLfRfJRTca7vHS4KUPogX4S0TJLabeMawCjrNOIHnHAQJUzQJfWkRRYuovl0clYZFONBM0CY1xn14nn7zJg+EpaWpDBj2Dui/D88ikq0QQ0YLuug3/tfZoLSNb1jKszpANsCc6GozlAwVu3EtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwmixdpYdExmjE4reTF8pmlfMGjG5l7D+jesZo8PH8w=;
 b=hfDdk9dO33AkpjeNmSucAwka9CZOtDLo+CZA6HVjw8bk+gs5N2WEjyqrMMZadFuL4KB2CpgXKj7Q6a+amOcf38NlRGz9bWgl5N046A1tC4BateOPiLVajkX7xY3KUBbhuRq9OtSnCLCj2d6ApV9Sk6zvvbrTM1yhwbuVHYGGL82E/rmb/PWrzwTCxt4LVSWmQaTZttprxQmlGobR+VZUIKRh9AXP/8SLv0oLYLtYgCaqMUQkzEHDHT3zfBbMJqEIcmxLhd1nsxI2JLf1XTmvu+l2fe865LZheJKMFOAo5lHWzEEEtvS0VSCn4MYwIZ4sh8fHRRs93mWLgJaGn7U1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwmixdpYdExmjE4reTF8pmlfMGjG5l7D+jesZo8PH8w=;
 b=h9b4BuvPN2EGD220cDA0icw34Xo6UvnyU+UnLPwhgOQeVWMfW+8Gngt+oV0epZHQbCUwY2bjziZBZ6CgnjysufYtJQGBYmNwHwWElo2OohmI4ELUUkBFfZ9/Q5tM2MCXLTA5ZIDl6jF/vJW5PuHOKrc+RNhCAG0ANm+GV7KLBsdMZql/XtJ+KXKJ0e0NI8/EM+DLrHLzDAKd5auWUpqODs5HSEYPwAwynKWHMZYgkIzzUpslLFtgl+5GcFI8ejmuetEDvEItfNnIf5hGD/eSyo8iUzVdhSfA2k9spAuy8RagXN4WHiZksOoMhXE1COsqdtkcZAzQ8nOvR1gO0dXGoA==
Received: from CY5PR13CA0093.namprd13.prod.outlook.com (2603:10b6:930:a::28)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 17:02:56 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:930:a:cafe::56) by CY5PR13CA0093.outlook.office365.com
 (2603:10b6:930:a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.16 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:02:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:38 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:38 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:02:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v1 10/10] iommu/arm-smmu-v3: Report virtual IRQ for device in user space
Date: Tue, 27 Aug 2024 10:02:12 -0700
Message-ID: <8b93be1d913f9e227748de2d07e8540ddc2372ab.1724777091.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724777091.git.nicolinc@nvidia.com>
References: <cover.1724777091.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8924ef-8abe-41cf-fc93-08dcc6ba180c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zgqYggyaapJTIVH/PLDs6eYu41EAbuhBXNnyWrOpOopT151OtyUYxzbi9SG5?=
 =?us-ascii?Q?MO6KRhkSQdKh3kv7VLR1ojGmJLP/0NaP8exojuOBWVDmyvSKHaAzwowfMtGt?=
 =?us-ascii?Q?hvJi9YX5GKTd1XorVfui0T/hx5ZPI8jcIF9/2UWuaY107/QjQjKjNexSTS5e?=
 =?us-ascii?Q?MFwHfFyleygomqkxOfRX2MLixgWcUjQSbT2Ibq3Pyu3LJU7ks/ZwhsXTHWXz?=
 =?us-ascii?Q?8putblmoZ/z0xhF/PI8JtBqobtEekBdym/3YZeonX1yX/iIsA9G8jHpgG0JI?=
 =?us-ascii?Q?1rTMzas0T9Ge46TOot2RreFDB/O5dbQ2z6UI6GSeG+ceZrmxeSGJpndgZXC9?=
 =?us-ascii?Q?bpp0hzuDTYQCXIPQ1a89B+4s7/Cuihti2dPET8JLKeM5nMhqewB4MhEFlyL/?=
 =?us-ascii?Q?YQHfy0km1l7oWSc0taE6lxAr9yzle8L505aFzOL4c0WvtyfCICDQpD866ynu?=
 =?us-ascii?Q?Tgi3f8YrODMEgH2Ut25fC9C0upTEKb7r9FfYuyoUOrO8Tswdhfs1zle9jyeo?=
 =?us-ascii?Q?673ddB3BBXRH+Yhg9CRy/RRlwYxEv2qBC6sArxvGXIGDySo4TT42lBIDaF+g?=
 =?us-ascii?Q?0SQzzFDYM1dAbK4C8dfZR2S1E4R3Fo1sEH15WX9Hc+8esLi4gcEirdES0YR5?=
 =?us-ascii?Q?TiDld+uv5apAVkT7lTmlAiwLnsr6MyMHcbPmsyDMSfUMUTN/lDUC8gaMr9//?=
 =?us-ascii?Q?gDOSkxYeN9qi1NPO3f5qQmCYKhM4OsCpY67E+A3FApfN7dDMaZtWoYEYBzjT?=
 =?us-ascii?Q?ELUwTBe4LEntgRnsyfV7Xp2Ksojk4+UJyumNS9QOkYjnOXavzPO+7r4C9RD7?=
 =?us-ascii?Q?Tokg9nn4bvc25kJ6ufudp8/lz9axEP4M4eO5P8l6WRaigCqPADdCOFeyOLzC?=
 =?us-ascii?Q?UY/WZ+iBj6H3yaL4UUDYmW61znvPyyZbKVnPOe9GuQcv+IY1eDDynVFJ7qar?=
 =?us-ascii?Q?k6fUwqKEOzNUnbDN8KMS3/syIAM1OJz0CZldgKtfNaUSZKT1DNM7pK7BgRsp?=
 =?us-ascii?Q?jhXGWRXsKcueIU8on4VbJaJoJnppm6JlFpiJFoG8wDxviswW16OmxTJJHPpL?=
 =?us-ascii?Q?4MXws+i4SlW3+7kFHTb3e3D4goiE00avfCcAHxhkW5cvABnXNHoklZnxAS/w?=
 =?us-ascii?Q?kfwYCk149XG4+uy2JGbhHqIf+/wH30lFAbL3aDx4W0xj/70cTplZqO4viD98?=
 =?us-ascii?Q?bqJCham23ZI9wZZdC5jwbfnGGqtaVNzbDy9eLeNvhFfaoPO/EgsDek9rJVuf?=
 =?us-ascii?Q?4xyA6pokaDn9tLTQ4lTg2MrLh6qIb1z+FeINX/uHpd/zOkVweORSbz8Be3r3?=
 =?us-ascii?Q?eWz5xDIkEACp0UxgcreXLDogNevuFuOItTO/GZqaB4ek9ay44KuA/U/h6B2d?=
 =?us-ascii?Q?FhDOlJJf43oobUf1fsSp4jHr6tws+xRNcsLhYO7wqvzPQ2RpR9lG9jnIhLEF?=
 =?us-ascii?Q?QWVIh5ZyOLJzZaAmg/lJGSyGDHepo7fU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:54.8238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8924ef-8abe-41cf-fc93-08dcc6ba180c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702

Aside from the IOPF framework, iommufd provides an additional pathway to
report a hardware event or IRQ, via the VIRQ of VIOMMU infrastructure.

Implement the set/unset_vdev_id viommu ops, to take control of vdev_id's
lifecycle. Lock it properly so the threaded IRQ handler can read out the
viommu pointer and the virtual SID, to call iommufd_viommu_report_irq().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 109 +++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   2 +
 include/uapi/linux/iommufd.h                |  14 +++
 3 files changed, 97 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ad43351145d0..28daa0b253c6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1810,6 +1810,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 {
 	int ret = 0;
 	u32 perm = 0;
+	struct iommu_domain *domain;
 	struct arm_smmu_master *master;
 	bool ssid_valid = evt[0] & EVTQ_0_SSV;
 	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
@@ -1830,41 +1831,59 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 	if (evt[1] & EVTQ_1_S2)
 		return -EFAULT;
 
-	if (!(evt[1] & EVTQ_1_STALL))
-		return -EOPNOTSUPP;
-
-	if (evt[1] & EVTQ_1_RnW)
-		perm |= IOMMU_FAULT_PERM_READ;
-	else
-		perm |= IOMMU_FAULT_PERM_WRITE;
-
-	if (evt[1] & EVTQ_1_InD)
-		perm |= IOMMU_FAULT_PERM_EXEC;
-
-	if (evt[1] & EVTQ_1_PnU)
-		perm |= IOMMU_FAULT_PERM_PRIV;
-
-	flt->type = IOMMU_FAULT_PAGE_REQ;
-	flt->prm = (struct iommu_fault_page_request) {
-		.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
-		.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
-		.perm = perm,
-		.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
-	};
-
-	if (ssid_valid) {
-		flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
-		flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
-	}
-
 	mutex_lock(&smmu->streams_mutex);
 	master = arm_smmu_find_master(smmu, sid);
 	if (!master) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
+	domain = iommu_get_domain_for_dev(master->dev);
+
+	if (evt[1] & EVTQ_1_STALL) {
+		if (evt[1] & EVTQ_1_RnW)
+			perm |= IOMMU_FAULT_PERM_READ;
+		else
+			perm |= IOMMU_FAULT_PERM_WRITE;
+
+		if (evt[1] & EVTQ_1_InD)
+			perm |= IOMMU_FAULT_PERM_EXEC;
+
+		if (evt[1] & EVTQ_1_PnU)
+			perm |= IOMMU_FAULT_PERM_PRIV;
+
+		flt->type = IOMMU_FAULT_PAGE_REQ;
+		flt->prm = (struct iommu_fault_page_request) {
+			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
+			.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
+			.perm = perm,
+			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
+		};
+
+		if (ssid_valid) {
+			flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+			flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
+		}
+
+		iommu_report_device_fault(master->dev, &fault_evt);
+	} else if (domain && domain->type == IOMMU_DOMAIN_NESTED) {
+		mutex_lock(&master->lock);
+		if (master->vdev_id) {
+			struct iommu_virq_arm_smmuv3 virq_data =
+				*(struct iommu_virq_arm_smmuv3 *)evt;
 
-	iommu_report_device_fault(master->dev, &fault_evt);
+			virq_data.evt[0] &= ~EVTQ_0_SID;
+			virq_data.evt[0] |=
+				FIELD_PREP(EVTQ_0_SID, master->vdev_id->id);
+
+			iommufd_viommu_report_irq(master->vdev_id->viommu,
+						  IOMMU_VIRQ_TYPE_ARM_SMMUV3,
+						  &virq_data, sizeof(virq_data));
+		}
+		mutex_unlock(&master->lock);
+	} else {
+		/* Unhandled events should be pinned */
+		ret = -EFAULT;
+	}
 out_unlock:
 	mutex_unlock(&smmu->streams_mutex);
 	return ret;
@@ -3750,6 +3769,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	master->dev = dev;
 	master->smmu = smmu;
+	mutex_init(&master->lock);
 	dev_iommu_priv_set(dev, master);
 
 	ret = arm_smmu_insert_master(smmu, master);
@@ -3802,6 +3822,7 @@ static void arm_smmu_release_device(struct device *dev)
 	arm_smmu_remove_master(master);
 	if (arm_smmu_cdtab_allocated(&master->cd_table))
 		arm_smmu_free_cd_tables(master);
+	mutex_destroy(&master->lock);
 	kfree(master);
 }
 
@@ -3937,6 +3958,36 @@ static int arm_smmu_def_domain_type(struct device *dev)
 	return 0;
 }
 
+static struct iommufd_vdev_id *
+arm_smmu_viommu_set_vdev_id(struct iommufd_viommu *viommu, struct device *dev,
+			    u64 id)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct iommufd_vdev_id *vdev_id;
+
+	vdev_id = kzalloc(sizeof(*vdev_id), GFP_KERNEL);
+	if (!vdev_id)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_lock(&master->lock);
+	master->vdev_id = vdev_id;
+	mutex_unlock(&master->lock);
+
+	return vdev_id;
+}
+
+static void arm_smmu_viommu_unset_vdev_id(struct iommufd_vdev_id *vdev_id)
+{
+	struct device *dev = iommufd_vdev_id_to_dev(vdev_id);
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	mutex_lock(&master->lock);
+	master->vdev_id = NULL;
+	mutex_unlock(&master->lock);
+
+	/* IOMMUFD core frees the memory of vdev_id */
+}
+
 static int arm_smmu_viommu_cache_invalidate(struct iommufd_viommu *viommu,
 					    struct iommu_user_data_array *array)
 {
@@ -3977,6 +4028,8 @@ static struct iommu_ops arm_smmu_ops = {
 		.iova_to_phys		= arm_smmu_iova_to_phys,
 		.free			= arm_smmu_domain_free_paging,
 		.default_viommu_ops = &(const struct iommufd_viommu_ops) {
+			.set_vdev_id = arm_smmu_viommu_set_vdev_id,
+			.unset_vdev_id = arm_smmu_viommu_unset_vdev_id,
 			.cache_invalidate = arm_smmu_viommu_cache_invalidate,
 		}
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6930810b85cb..5d20a67683e6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -788,6 +788,8 @@ struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
 	struct arm_smmu_stream		*streams;
+	struct mutex			lock;
+	struct iommufd_vdev_id		*vdev_id;
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index f9ec07efed8d..1dc2c0b05af7 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -956,9 +956,23 @@ struct iommu_viommu_unset_vdev_id {
 /**
  * enum iommu_virq_type - Virtual IRQ Type
  * @IOMMU_VIRQ_TYPE_NONE: INVALID type
+ * @IOMMU_VIRQ_TYPE_ARM_SMMUV3: ARM SMMUv3 Virtual Event
  */
 enum iommu_virq_type {
 	IOMMU_VIRQ_TYPE_NONE = 0,
+	IOMMU_VIRQ_TYPE_ARM_SMMUV3 = 1,
+};
+
+/**
+ * struct iommu_virq_arm_smmuv3 - ARM SMMUv3 Virtual IRQ
+ *                                (IOMMU_VIRQ_TYPE_ARM_SMMUV3)
+ * @evt: 256-bit ARM SMMUv3 Event record, little-endian.
+ *
+ * StreamID field reports a virtual device ID. To receive a virtual IRQ for a
+ * device, it must set its virtual device ID via IOMMU_VIOMMU_SET_VDEV_ID.
+ */
+struct iommu_virq_arm_smmuv3 {
+	__aligned_u64 evt[4];
 };
 
 /**
-- 
2.43.0


