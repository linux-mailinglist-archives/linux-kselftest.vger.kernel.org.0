Return-Path: <linux-kselftest+bounces-27273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16634A409B9
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 16:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC4D17B04B
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3CA20AF98;
	Sat, 22 Feb 2025 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pF541rCg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DBC1EB18D;
	Sat, 22 Feb 2025 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239693; cv=fail; b=HZKAyLfs0b0QtPZIP05Wv9TiH7vYkVP38RZEmk1QuUIyq6vXmpQoQgN7IicnH0AZlYxcZ1vRTkFqbSb3axcoaiG+2B02y7fnI/TuL+p4H0tFT8i/Y4z6o7pGOat838Cc5RTYl9ytDctMBsb3PqS6y/igL98NVMJlVvzoo7KiLqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239693; c=relaxed/simple;
	bh=kVrz+MvECzAbASkTEFIv8fdMz/RTFXFgVA0aNTTz7vo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1AQ5obB6eSFWprTxh/5TQLgwS+xfFmsv/nUZ75Omdum5Eq0fKAMc502DOfvfZycpfDmB2jT3p9GeYXDTvKlW4X1JWrS9P+QRzoHZXxtdsGiTaWCioVC6I7/IMTgdGwtQC/SNofl3mOpDkoHOU9AvsusRelMwpMV2rHtBOxyWn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pF541rCg; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QurQlHusOr+z6JojbcS8PM2BYkXdBY3eLjEzWxdw7FptD+FiU2y8h1C5H6f2CrsI4GK8EHoOI66T2n0YBBy5iof4NSVPBbqLUn29DApC/bTLxPrAAGYR0GMZEHbYlMq5WvuAWEdS8F5NEnFecQKOKE+wdIlDdWrpVTq9TPcp9LZXBB8tC1hEJSF05YTEskR8t5k9pwrug9PJNTOzWgVuJiKT2XrLu1SE/yLTAF3E3lxfMt1TZxqnGcWOeujod8pioR3JmAyhKcUgY6Ufs1vhIvIMyPtyGytJ0jykoAibxFU+cYejJ37x+2WCaKEYQa9r//IRZ6FviVLn6COr60OaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tw4qgaYTVo7fierWbBA1KTeU3/d+xuBv3gNMSYwFWs0=;
 b=Y+Wgee3LnxBgdrYP8SrXoOeBWBlKu767olYboW4zr4pRvT5nI4eGAKBlg7aZqXICdvd3qf6JjFlVlAlnCnT0jnaqw95mJEntMAPnCrcSV1TouPmMppLVdZewmuIPZ+dSUnEgzgFtgMMGjAohgn7ZNdgHQHuIxg5VF2mbg3Ui6f+Fi2IYqIPaLbUZ3EUjp7olDgwOaum2pTBNpZNBiTknmvt2VYJORigXv8EN8wuwwAiee2gIzgoBX3lmH3Od6PH6BAwjg8CJP9MNEW8SO9RA75fyNCr+rEu5mE72AcfG1ie+g0qQc/cvF7+OZ75zACXKiX1QlG8fHUGyyz7uN7olnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw4qgaYTVo7fierWbBA1KTeU3/d+xuBv3gNMSYwFWs0=;
 b=pF541rCgmRli1x7i5u8IfpBprFApaPZYJLU9UphMKh7ucd5RrgYe20i1Sp6vWo96RXj9PrFDZ6IiLgojqbEquQPURvpJBowGGAtZhNUOQU9Ty+X3Xt3UW1YPZW8GdBTZhmzf7hcjwKINtk0WvuuLcgOdEx3JIHjQFf4ipfCIYQKc2iyhUT5Q3/cNoJdTgj9noQ3yBYTPf5oax5nlI6J8jxXavOTMg2fEOgscBK6cQmpXbrQVFZSPMkLVbtKfoINX6t0VRFPue+HDttbc1k90o9a1CwA5cc2dUhunavZELZbjcD0ip5IbYZXlWT4MYTvzpFIdtkCRUR8tihpP52PA5A==
Received: from PH7P220CA0129.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::23)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 15:54:42 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::91) by PH7P220CA0129.outlook.office365.com
 (2603:10b6:510:327::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Sat,
 22 Feb 2025 15:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 15:54:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 07:54:26 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Feb
 2025 07:54:26 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 22 Feb 2025 07:54:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v7 07/14] iommufd/viommu: Add iommufd_viommu_report_event helper
Date: Sat, 22 Feb 2025 07:54:04 -0800
Message-ID: <c1d6974f3e61fdf94ca43ec5e3e6abcef97d31fc.1740238876.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740238876.git.nicolinc@nvidia.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: a3dd821d-2726-44b0-e5f4-08dd5359385e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fFn2E05hw2JQ3tvjOo5fCDRTawmP0DCAW16x7oO0W1MBEfoizjhPgSfBbtY+?=
 =?us-ascii?Q?7gKAkK30+oCXsUy5t+qUt/U/xpagW5XrSIgqFU0qASC9v42ZRnlNk3T6nJLW?=
 =?us-ascii?Q?JjnTXlLKlEyXTGIMlZehGyzfBmKn96DxI7ZgQQ3YjSKDvx9BgiiyRLTltzln?=
 =?us-ascii?Q?bPdEaYr2AcsBK1emI5Sr4E5Ep4iFnDvByzhfdpnaEF7FnUD7Ch8QDWVdxD1q?=
 =?us-ascii?Q?ZEhMPzAL3nBuZEhgnRwAZv6u4dHUlheh4cHly0F3OU/I80TqzWKsh+tNS2rA?=
 =?us-ascii?Q?JWYaOkAgYKbkAjIbkG+/vE4ULQminWv6p4oUrR9oCkzBuMUF0r8PDhxcqe98?=
 =?us-ascii?Q?Og1IrkRSGamgkY9U4bEF6x2E3wNOCAmCn7owy9CT2IzdV6/yy0zbxx4e3Vva?=
 =?us-ascii?Q?4iQafK/fNV7iBfx6CMzEMG01wJ2fEr1XQ22c1CsdinAlhCfurXk0aalE/5qw?=
 =?us-ascii?Q?+Ih7pjEoaj7Hl+/cdAS9smNxqrmyz8ICcvXplXBPAdNsla6leb31v7dQ16PY?=
 =?us-ascii?Q?XDZHlbOPkXJQ1e0iTjtfnrmbkSw+STsmbAReoYyJpQCz61m3tvRh3/dgPdAE?=
 =?us-ascii?Q?kKyqA7NoZ6114muAEa/BNgsezWLJnMFTrwwRdpbQWU+X71f9Sry5GZ2sWpFE?=
 =?us-ascii?Q?BQLCBqj3pV8M1xIXjE39ZDFiGsU4VadPs2Us5J9aqWnTy0DkguwFwrDQwrix?=
 =?us-ascii?Q?a5vORoC1HtVqoBUONIYmSmed0E9W7aJH9PhyxDg1tlRGZ+7P1LqYdBN6Ouht?=
 =?us-ascii?Q?Y0ABsr8jk4UypWonyLtZRzKfp74FSDz51SE18bshG/Sv3pdRPZTWnJ82qgtw?=
 =?us-ascii?Q?qJZ/q6Vq124BJYP3DmD7vS0tAQ0xHsXCzFFpIMOZitvK8cJ0hW1anKoyvWE/?=
 =?us-ascii?Q?WRDCUzIjEhCC73hDDr8FCJDkOLSBFCrhApT1f7MOudCCCwbMcjc9ptmtyzoC?=
 =?us-ascii?Q?46CH+YKiLbW5p9mZ9GEH0gtqJqVIrumrPwcufT3TsLxDMCMdCwdl42+JFWty?=
 =?us-ascii?Q?Y6zmr0w87sDtzcCygMH/UDD71eb+pnrQgdjg+3QHTpo53CsDqDh5lOpAmSyp?=
 =?us-ascii?Q?FivBDm1PhG4fzcM6LlmWXRu6Z0foR8s7n9JdaZOko7giQKQlqRAhsex0qi7G?=
 =?us-ascii?Q?y39fY42wv7rW02HNxAT4E+DeI+JZ800QPPaBcvxFkJmyDL1Q0VIj8cAcC19Y?=
 =?us-ascii?Q?qRn5WHflu/jI6w7Fbqe+vzHmS/6QHf9ubSAqQ6mF5+a1xN8B4LSpIhWRZTNu?=
 =?us-ascii?Q?1DU4xaipEfaDPDeH1MMAoTJrp5HkO66pqP9QwztZTYOv2u7oSeECc5JvTFf7?=
 =?us-ascii?Q?6Xo27UxLUTSz9pwOI9pXcFunGQ2ezq1YRxtz2JJdVsbFH+fWSiaK2KX0MBGF?=
 =?us-ascii?Q?06psZd3BsIhXOvf7XD/n0XIVIlOP15VQRoLbmL8z2/2FFqS6pMPOcV4Glq9O?=
 =?us-ascii?Q?ogASv4eF87+sj/gWQ9WsfheUy0TfgvR9DrGeX8i58MJ+PHgBF6mKQfBfN7I/?=
 =?us-ascii?Q?HIbuBdB9EYy1T4A=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 15:54:41.8010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3dd821d-2726-44b0-e5f4-08dd5359385e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237

Similar to iommu_report_device_fault, this allows IOMMU drivers to report
vIOMMU events from threaded IRQ handlers to user space hypervisors.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        | 11 ++++++++
 drivers/iommu/iommufd/driver.c | 48 ++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 05cb393aff0a..60eff9272551 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -11,6 +11,7 @@
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
+#include <uapi/linux/iommufd.h>
 
 struct device;
 struct file;
@@ -192,6 +193,9 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 			       struct device *dev, unsigned long *vdev_id);
+int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
+				enum iommu_veventq_type type, void *event_data,
+				size_t data_len);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE */
 static inline struct iommufd_object *
 _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
@@ -212,6 +216,13 @@ static inline int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 {
 	return -ENOENT;
 }
+
+static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
+					      enum iommu_veventq_type type,
+					      void *event_data, size_t data_len)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_IOMMUFD_DRIVER_CORE */
 
 /*
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index f132b98fb899..75b365561c16 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -73,5 +73,53 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_get_vdev_id, "IOMMUFD");
 
+/*
+ * Typically called in driver's threaded IRQ handler.
+ * The @type and @event_data must be defined in include/uapi/linux/iommufd.h
+ */
+int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
+				enum iommu_veventq_type type, void *event_data,
+				size_t data_len)
+{
+	struct iommufd_veventq *veventq;
+	struct iommufd_vevent *vevent;
+	int rc = 0;
+
+	if (WARN_ON_ONCE(!data_len || !event_data))
+		return -EINVAL;
+
+	down_read(&viommu->veventqs_rwsem);
+
+	veventq = iommufd_viommu_find_veventq(viommu, type);
+	if (!veventq) {
+		rc = -EOPNOTSUPP;
+		goto out_unlock_veventqs;
+	}
+
+	spin_lock(&veventq->common.lock);
+	if (veventq->num_events == veventq->depth) {
+		vevent = &veventq->lost_events_header;
+		goto out_set_header;
+	}
+
+	vevent = kmalloc(struct_size(vevent, event_data, data_len), GFP_ATOMIC);
+	if (!vevent) {
+		rc = -ENOMEM;
+		vevent = &veventq->lost_events_header;
+		goto out_set_header;
+	}
+	memcpy(vevent->event_data, event_data, data_len);
+	vevent->data_len = data_len;
+	veventq->num_events++;
+
+out_set_header:
+	iommufd_vevent_handler(veventq, vevent);
+	spin_unlock(&veventq->common.lock);
+out_unlock_veventqs:
+	up_read(&viommu->veventqs_rwsem);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_viommu_report_event, "IOMMUFD");
+
 MODULE_DESCRIPTION("iommufd code shared with builtin modules");
 MODULE_LICENSE("GPL");
-- 
2.43.0


