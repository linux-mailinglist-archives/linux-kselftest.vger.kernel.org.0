Return-Path: <linux-kselftest+bounces-24287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B2CA0A088
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 04:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FB33AB234
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 03:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0310518E379;
	Sat, 11 Jan 2025 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KcgnARqV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F7B18CC08;
	Sat, 11 Jan 2025 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736566389; cv=fail; b=cSTaVwaUqHREXayaSxytgoxCzihngIl+F8XnToCc4KQR00jy74Wbp4UR38zNr+1+D2wks9rr29fxIrIwhCEPNFU7LElk71J72gF0Pr4zukzVewH6iotoxZkdncLxdFH7ZHnC02lbo7VbTSVtlMKvWyB1KqXhU4Odmbh1U8iyuHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736566389; c=relaxed/simple;
	bh=J4wSRN+kfrsEoNm8dj4Y5BZnuXkrGXloGrqHYwqGSzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAR9WQQJYwsoAzOycuWsPgiQ5IUmpvHoKA0non0KbrDKmIxuXxZEnUKlXM3/idjbT554D4FP1SxgN2/aAmckOHgY4g/ZdE+CdXeZo93MRoCp289nTFxiaHkgv63m2jI9IO9d+uMXlLkmVO4eYL7DSGcBOv8p3Yacgkp81+BG1uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KcgnARqV; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EST58m5Tim6AwYrulFPF7cbEzyhGUKPw1faggBcsnxX3FUvDNNSwxcvCmG+YEa/rZSIftBKlnSm+dwi2B+s1PG6q8tKlnrcP0vU9myVNnmu15TYKwbkW1uhXN4M2O4s5ugndo0Qt5/AQJzw+jKwDGi5n7PPlV01sNGftnxLID/QbvpbPA/lZX+kOCOoI+wxe3OgcCp+VfBtP3k1ErgmPA4XXTzamNqeHy2e3rXEdht3F+VogMfVA1E45C5j73eg279fWLjZkeSGy/VSVcDlO63Yt+TkYV/mNv6EHg9JPZ9gmqFhWbZLjDXe7Wvcst8EhvpYrAISI9FuDZRYTdGIHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WvwtyZ+REcccF8by7VyJMP0jEy+6+HITe0N8vPF0YQ=;
 b=ZpXHfhGypDgkUhy1FCU7TVl9DkvlNnb9ApX5TU6+dfYv+qi+d3CrzoCiVyHeXJ3dN74e70WI1BfZ0wnFF6WMdk2a1F6+k5+mQVk3ZYUE+ybsTRaUbTDggjPpJSbAtOK2gImK2ke/a7Kcn6ioTzCJ0iBFsinCgEd1zjRTVOwM5ygOrd3yPmwWjdorX+BHazRgIcBxlGftLitry99/ZmzYQEhhKfCjS2HH+VDO5Tg0WwOcRwWNnucKMpYPai8NK20KK+XVL//HY/ToVRCWSlCG09mkvOsMCQSkLyw3NlsZmyqGVVqJBveq4WiXcyc8q6X80dmolYSyZqJ9CWQL1RrOOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WvwtyZ+REcccF8by7VyJMP0jEy+6+HITe0N8vPF0YQ=;
 b=KcgnARqVRDUER2bkTyd1wvmDGYJ0OM98S4FlLGroFkVFCMvsKsltyxAT3PS0zHJxDrcdxN+LnU7KkUPwntTlYTZg3INExelWqLgBdwnake7fVh7SNYIBrvu6nlGlxBbPcJUQEQyXg+k2g/S87aOj+Mcb9p5ziHnOrkwevrZo+nbxyUcEjzZdEb4U16e86JwQ5y51OvTo4iLBcUZJYKSFPhQcVX66QLFQoZRIznhb/QdGwEfqyzN6/1GLbru6d/l5hbkVw4s2V7hyEHU5G/XhM3+T8Ec78RKaFkcdbeHIoURAotHU9fFcFrpR+D9HaH/NxcUp+g7gxiXVzbst8kNuAw==
Received: from CH5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:1f1::29)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Sat, 11 Jan
 2025 03:33:03 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::fe) by CH5PR03CA0001.outlook.office365.com
 (2603:10b6:610:1f1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Sat,
 11 Jan 2025 03:33:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Sat, 11 Jan 2025 03:33:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 19:33:01 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 19:33:01 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 19:32:59 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<alex.williamson@redhat.com>
CC: <joro@8bytes.org>, <shuah@kernel.org>, <reinette.chatre@intel.com>,
	<eric.auger@redhat.com>, <yebin10@huawei.com>, <apatel@ventanamicro.com>,
	<shivamurthy.shastri@linutronix.de>, <bhelgaas@google.com>,
	<anna-maria@linutronix.de>, <yury.norov@gmail.com>, <nipun.gupta@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>
Subject: [PATCH RFCv2 06/13] iommufd: Make attach_handle generic
Date: Fri, 10 Jan 2025 19:32:22 -0800
Message-ID: <c708aedc678c63e2466b43ab9d4f8ac876e49aa1.1736550979.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736550979.git.nicolinc@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: a7316e4f-9847-4f9b-a819-08dd31f0a7aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IpUwGwy7fh6a8J+SzFiMsNlx0QnkqY34DeUdsi+ZidqaeZvLP35k5KNYHHhG?=
 =?us-ascii?Q?qplWYaS8EhgvKgWPdnWt2MjEnF8ntTwVlbx/RJylG20vxlNJV4R2neXQdJI/?=
 =?us-ascii?Q?nyxl0ZZxiNbkik9OTmUPgCsz8WVIK3IG44NgKSnogEaTHEvgj+HE/BikMVL9?=
 =?us-ascii?Q?v0fSlzHFbgIRQ4pc7OKqZnMOVPtsMkkIqxj0B8lSLV2BF7xtuS91oMzhJ9bi?=
 =?us-ascii?Q?qgZLnxfVwA9DHaFsHUUnERo3ozXkYzH0E2RW/IXS0gXKwQhrjmu7yCsl7y+d?=
 =?us-ascii?Q?XXhpjbE3dxQNrldqamYSiK4sKlb8Sm6ZJSW77HF+VZJJokbhde6ZIgk1izKy?=
 =?us-ascii?Q?zUf2GnIOWYKfdoAsNLSrHijuLyhHD4g9nanwwICVWz47iljwKeBgA7hHeDOx?=
 =?us-ascii?Q?10TXdUIKdf19zNllo+MtNMa8vnkyyw94/GHoR97EYZpTo4n1h53gAQI+vcuS?=
 =?us-ascii?Q?x0NjzBDGAMhlKnMhJLp4lp0Au+4HQOnKNjo1jhVFqeX3lHJse0RjObGQ2DSI?=
 =?us-ascii?Q?v4q9EaHPE/m/o5gyS+IRutuTLI4zY7OL+ueqUeETRkJcD4MpTT9ve1OJuaFc?=
 =?us-ascii?Q?Oj10e7qjeLGU0H7/gEik0PWww8dPOhmYVaQNyrw/eRSWxMRjnit0WYYvGXxk?=
 =?us-ascii?Q?cwzQoWxwQXJhG6i51Ao4RpE8GEaVt8dCxFOOGO57A3Hipqb0H7LpAC1WtQ/1?=
 =?us-ascii?Q?Ll0CwcNZjAV1+AjRc+oMmga1MzDHFPrDNFjJnQoJMSk4OgtjHSxppYIPz3ZZ?=
 =?us-ascii?Q?lWI9KaSnzpVudXPWLIC4D47KnWy1c/EYuV8xGsZENBuDYB8/ZaBtrNC+P97M?=
 =?us-ascii?Q?gTv97XeLAhQMlDxNnqXTka/yFqZXPQGcVq518dwaRg5mPZ7/HTqx8EYU6ZOU?=
 =?us-ascii?Q?Ernj9sEE0b0tt8G2CpEBqGV9ptch0dZDGD0tZt1BZQxUbpZ4nIwb6wuyzvUY?=
 =?us-ascii?Q?Op+z3USRjyEatNwtA1H7WztO+/8PIe876CsfgQTLWW3JOI4YULrY4PIn7viQ?=
 =?us-ascii?Q?DerwR8URCxIC2igw2+IwvNY49ObT0P7HbCnSE55uPQiO1fNHpwrEQ7pH3VsC?=
 =?us-ascii?Q?BoyJAC9ZyBpqhqt07KX2bKidVdFJD+oJqlZzy6Zl0S3zmbWQTdduZxKwDJbu?=
 =?us-ascii?Q?lvMctJDNPYfxxlQVGco8X4j+5g+fRJ9kyPPsL09KxVYcdbMeAPERGCfqTKfW?=
 =?us-ascii?Q?hfOKzhvgo+OZ8ATXxqqMZMbFub5teOH/xRKORtKaYQ8Q0jD4c3/86PbHf81b?=
 =?us-ascii?Q?0VFKWmeWd0/U8vIaeBKjK6N0XUaAgFk3BQphyMWIQbru6l8CsLk2TmQBeDZm?=
 =?us-ascii?Q?hZHAbV0OvgPBHq4tJSHOZAhstvAGJp5GldcByQtcBZK0ZO88YUgfNLZ3P9sE?=
 =?us-ascii?Q?NG/chfcVGWk7zNR/OSZ4W8LIYQQJcJ8athX1wGgJyTFe8BYgXYiSeFbEM3bk?=
 =?us-ascii?Q?5gyH+l2ifRlWhjMdfdv3l2iCwLh87/ULQikrILADePG8C8InjIEp56KJZtOE?=
 =?us-ascii?Q?oFG88x5Ov6yaKI0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:33:03.0275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7316e4f-9847-4f9b-a819-08dd31f0a7aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905

"attach_handle" was added exclusively for the iommufd_fault_iopf_handler()
used by IOPF/PRI use cases, along with the "fault_data". Now, the iommufd
version of sw_msi function will resue the attach_handle and fault_data for
a non-fault case.

Move the attach_handle part out of the fault.c file to make it generic for
all cases. Simplify the remaining fault specific routine to attach/detach.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  40 +-------
 drivers/iommu/iommufd/device.c          | 105 +++++++++++++++++++++
 drivers/iommu/iommufd/fault.c           | 120 +++---------------------
 3 files changed, 122 insertions(+), 143 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index b6d706cf2c66..063c0a42f54f 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -472,42 +472,12 @@ void iommufd_fault_destroy(struct iommufd_object *obj);
 int iommufd_fault_iopf_handler(struct iopf_group *group);
 
 int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
-				    struct iommufd_device *idev);
+				    struct iommufd_device *idev,
+				    bool enable_iopf);
 void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_device *idev);
-int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
-				     struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_hw_pagetable *old);
-
-static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
-					     struct iommufd_device *idev)
-{
-	if (hwpt->fault)
-		return iommufd_fault_domain_attach_dev(hwpt, idev);
-
-	return iommu_attach_group(hwpt->domain, idev->igroup->group);
-}
-
-static inline void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
-					      struct iommufd_device *idev)
-{
-	if (hwpt->fault) {
-		iommufd_fault_domain_detach_dev(hwpt, idev);
-		return;
-	}
-
-	iommu_detach_group(hwpt->domain, idev->igroup->group);
-}
-
-static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
-					      struct iommufd_hw_pagetable *hwpt,
-					      struct iommufd_hw_pagetable *old)
-{
-	if (old->fault || hwpt->fault)
-		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
-
-	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
-}
+				     struct iommufd_device *idev,
+				     struct iommufd_attach_handle *handle,
+				     bool disable_iopf);
 
 static inline struct iommufd_viommu *
 iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index dfd0898fb6c1..38b31b652147 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -352,6 +352,111 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 	return 0;
 }
 
+/* The device attach/detach/replace helpers for attach_handle */
+
+static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
+				      struct iommufd_device *idev)
+{
+	struct iommufd_attach_handle *handle;
+	int rc;
+
+	if (hwpt->fault) {
+		rc = iommufd_fault_domain_attach_dev(hwpt, idev, true);
+		if (rc)
+			return rc;
+	}
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle) {
+		rc = -ENOMEM;
+		goto out_fault_detach;
+	}
+
+	handle->idev = idev;
+	rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
+				       &handle->handle);
+	if (rc)
+		goto out_free_handle;
+
+	return 0;
+
+out_free_handle:
+	kfree(handle);
+	handle = NULL;
+out_fault_detach:
+	if (hwpt->fault)
+		iommufd_fault_domain_detach_dev(hwpt, idev, handle, true);
+	return rc;
+}
+
+static struct iommufd_attach_handle *
+iommufd_device_get_attach_handle(struct iommufd_device *idev)
+{
+	struct iommu_attach_handle *handle;
+
+	handle =
+		iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
+	if (IS_ERR(handle))
+		return NULL;
+	return to_iommufd_handle(handle);
+}
+
+static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
+				       struct iommufd_device *idev)
+{
+	struct iommufd_attach_handle *handle;
+
+	handle = iommufd_device_get_attach_handle(idev);
+	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
+	if (hwpt->fault)
+		iommufd_fault_domain_detach_dev(hwpt, idev, handle, true);
+	kfree(handle);
+}
+
+static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
+				       struct iommufd_hw_pagetable *hwpt,
+				       struct iommufd_hw_pagetable *old)
+{
+	struct iommufd_attach_handle *old_handle =
+		iommufd_device_get_attach_handle(idev);
+	struct iommufd_attach_handle *handle;
+	int rc;
+
+	if (hwpt->fault) {
+		rc = iommufd_fault_domain_attach_dev(hwpt, idev, !old->fault);
+		if (rc)
+			return rc;
+	}
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle) {
+		rc = -ENOMEM;
+		goto out_fault_detach;
+	}
+
+	handle->idev = idev;
+	rc = iommu_replace_group_handle(idev->igroup->group, hwpt->domain,
+					&handle->handle);
+	if (rc)
+		goto out_free_handle;
+
+	if (old->fault)
+		iommufd_fault_domain_detach_dev(old, idev, old_handle,
+						!hwpt->fault);
+	kfree(old_handle);
+
+	return 0;
+
+out_free_handle:
+	kfree(handle);
+	handle = NULL;
+out_fault_detach:
+	if (hwpt->fault)
+		iommufd_fault_domain_detach_dev(hwpt, idev, handle,
+						!old->fault);
+	return rc;
+}
+
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 06aa83a75e94..1d9bd3024b57 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -60,42 +60,17 @@ static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
 	mutex_unlock(&idev->iopf_lock);
 }
 
-static int __fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_device *idev)
-{
-	struct iommufd_attach_handle *handle;
-	int ret;
-
-	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-	if (!handle)
-		return -ENOMEM;
-
-	handle->idev = idev;
-	ret = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
-					&handle->handle);
-	if (ret)
-		kfree(handle);
-
-	return ret;
-}
-
 int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
-				    struct iommufd_device *idev)
+				    struct iommufd_device *idev,
+				    bool enable_iopf)
 {
-	int ret;
+	int rc = 0;
 
 	if (!hwpt->fault)
 		return -EINVAL;
-
-	ret = iommufd_fault_iopf_enable(idev);
-	if (ret)
-		return ret;
-
-	ret = __fault_domain_attach_dev(hwpt, idev);
-	if (ret)
-		iommufd_fault_iopf_disable(idev);
-
-	return ret;
+	if (enable_iopf)
+		rc = iommufd_fault_iopf_enable(idev);
+	return rc;
 }
 
 static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
@@ -127,86 +102,15 @@ static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 	mutex_unlock(&fault->mutex);
 }
 
-static struct iommufd_attach_handle *
-iommufd_device_get_attach_handle(struct iommufd_device *idev)
-{
-	struct iommu_attach_handle *handle;
-
-	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
-	if (IS_ERR(handle))
-		return NULL;
-
-	return to_iommufd_handle(handle);
-}
-
 void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_device *idev)
+				     struct iommufd_device *idev,
+				     struct iommufd_attach_handle *handle,
+				     bool disable_iopf)
 {
-	struct iommufd_attach_handle *handle;
-
-	handle = iommufd_device_get_attach_handle(idev);
-	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
-	iommufd_auto_response_faults(hwpt, handle);
-	iommufd_fault_iopf_disable(idev);
-	kfree(handle);
-}
-
-static int __fault_domain_replace_dev(struct iommufd_device *idev,
-				      struct iommufd_hw_pagetable *hwpt,
-				      struct iommufd_hw_pagetable *old)
-{
-	struct iommufd_attach_handle *handle, *curr = NULL;
-	int ret;
-
-	if (old->fault)
-		curr = iommufd_device_get_attach_handle(idev);
-
-	if (hwpt->fault) {
-		handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-		if (!handle)
-			return -ENOMEM;
-
-		handle->idev = idev;
-		ret = iommu_replace_group_handle(idev->igroup->group,
-						 hwpt->domain, &handle->handle);
-	} else {
-		ret = iommu_replace_group_handle(idev->igroup->group,
-						 hwpt->domain, NULL);
-	}
-
-	if (!ret && curr) {
-		iommufd_auto_response_faults(old, curr);
-		kfree(curr);
-	}
-
-	return ret;
-}
-
-int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
-				     struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_hw_pagetable *old)
-{
-	bool iopf_off = !hwpt->fault && old->fault;
-	bool iopf_on = hwpt->fault && !old->fault;
-	int ret;
-
-	if (iopf_on) {
-		ret = iommufd_fault_iopf_enable(idev);
-		if (ret)
-			return ret;
-	}
-
-	ret = __fault_domain_replace_dev(idev, hwpt, old);
-	if (ret) {
-		if (iopf_on)
-			iommufd_fault_iopf_disable(idev);
-		return ret;
-	}
-
-	if (iopf_off)
+	if (handle)
+		iommufd_auto_response_faults(hwpt, handle);
+	if (disable_iopf)
 		iommufd_fault_iopf_disable(idev);
-
-	return 0;
 }
 
 void iommufd_fault_destroy(struct iommufd_object *obj)
-- 
2.43.0


