Return-Path: <linux-kselftest+bounces-21471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 460999BD67D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FA01F2387F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7927C215C6C;
	Tue,  5 Nov 2024 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dL5j0/BT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B89215C50;
	Tue,  5 Nov 2024 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837099; cv=fail; b=Ts6cUCqprB46H6cHmtOax+HDKHfOt1m4taNsFl8JpsoznTkztOSVyBaPaPdaCXr1S+mEEUMvyxONB/Q4TCdxp3swTX0LcTV7x+/g25tP8akeqXK7lJGTP6jjBZA5dZz4F56fuBU6TjAWPBTbeogqp6a8M3s2IcBG7o7eeLIfCEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837099; c=relaxed/simple;
	bh=7sPB15V/w4wInnTmw0ej6hMvg40uSiSj5vrqQcGoylU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXHKjIFgC6rslveu9QFWx2gngatNJvJH8OLj5xpcVRYoOjOgdnvvMxVcrl+v83yIEKMWo9uYwpKWUy0GkQpmCgxZZXzQ2urH3AuL3CGqFSTcT9sPHV1WFmWFcbnGX+JcR1IpASfC/f2+LkKw+6YU3uzl2enkatwnZpt5w0J5ovc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dL5j0/BT; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKZVBpdZNR1drAUf2zOC+Fh+nSdN7IMC0GHe065IJyL1QJj6rKSAlvzQYtdjQWNV3aKoFDBE7hp1FjrPz/XaSLgedavwz8nk+Bb8EL/TsIGrtuYEBNUwECmSq1kHn+/8RO/Lb/YNA6gSK3+brKARYwDwUDVxjKXCe9YxycQPmDBGrbgg0wey3d5GnRloiom5M92mk7HQGkzIQ+E/y1e0/9sZteshP94bi+uEYUHK567bU2dUem/Z6SAsp1pDhTUPvdBjdaHyfT9AV58wJwMybUby86pwAHLidPwnD41KbQWWUXll01dDBTTM30umlziUVPOap0rwNnkzhSARbVBQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2m6/F+JKpnHyzJ1kxenJ++GEDw1KOY8ocDrGh1wzehw=;
 b=ozPwv9Ec1kGNF/j/d9GzdHKlv1qpjFjcwTzookxxb/5sJcblUV8x/EXw4MtgqzCiQ5SaQcG8q5cwv43nGE8LQzQDijzqmpHB6fcTRZ+1GYAPoVIGfjurKC2p1AIzM2ukV9VFnGRCpEI9bLKYyy+G2DnG1MxrUHiIYak+QZK9FuRW3xheOHdGHSKapn3NXLQQG2IeOQlLA3kMqbggGCdKP13MtYs1fgS3uECoRebr2aDx55NJlXLqbqhttbo1E/ehqvEoGcI72vDAkcDCYHAiIpsyZ/mK8NVCTeoABuwRNpBx17tqoPZUOFi/EZzGOPNSTlXBi4HeNEVNK2dwjD5EnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m6/F+JKpnHyzJ1kxenJ++GEDw1KOY8ocDrGh1wzehw=;
 b=dL5j0/BTPD3VBj0+KNEfNbJAuYJZMf2MdBmj7Lvnj1NUoU+p4GH+zJe3Mu2qfZV7PKaQBnFj5ZTM3BANXP9D1WK2OHH8Epg+kBpM5npKDYd1kF8skI9MpNUbiJCdMjGA4+sdltddFOA+PW9/mkWnNqkWCuzzAafCstNG0m/2YdVMf+MnH/hIffYcZ9Ft1Qz6ZvolDhFo1LJxspslm3bF5rZuYdXxmY6JZPcoJjH2P7YpedvO/ON8ep5a3eHQSoHG9zQJeb9FcPXY7JImuYIbtN0k5kY2fy2OzlpUf2fkK5fqoNijuhHZTWtV5S19+ZesANyVGDS7tHfbbBNm0bd7DQ==
Received: from MN2PR04CA0021.namprd04.prod.outlook.com (2603:10b6:208:d4::34)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 5 Nov
 2024 20:04:52 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::cf) by MN2PR04CA0021.outlook.office365.com
 (2603:10b6:208:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26 via Frontend
 Transport; Tue, 5 Nov 2024 20:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:04:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:39 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:39 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:04:37 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: [PATCH v7 01/13] iommufd: Move struct iommufd_object to public iommufd header
Date: Tue, 5 Nov 2024 12:04:17 -0800
Message-ID: <54a43b0768089d690104530754f499ca05ce0074.1730836219.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730836219.git.nicolinc@nvidia.com>
References: <cover.1730836219.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: f3aaf95c-6830-4f77-5e46-08dcfdd51c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rqucFVjrovnH5UtHqSSDvZ0kD00cyO//ACYHKDgioNzdmt+DTCOAoNCAZAGP?=
 =?us-ascii?Q?daXbhns+pyALzgRVXj3FLr1MMNjPPybg1EHoNaubN9SXl4r1/K7nvIZxEpS6?=
 =?us-ascii?Q?634+g8PKHWnkGgEbuvZZBYGEJ0hfl2pq9a/dLHtuyiOvuq1ERHA7atuI1T7p?=
 =?us-ascii?Q?vacx4+ZYVbdJdfg8/yOzkgBJq05Lhy2wniFBcMOE7KsZaedZm3WRyjFhNMA1?=
 =?us-ascii?Q?sPY2EZwgzZJvvDnxTthJ+m6/TY8aANcfcrWhuVO28Uz7BO/WAP3ukbv1uCqE?=
 =?us-ascii?Q?uY5028V9JHfdoCyFsz2AwDFXLRqvxPWl71rrapoUA+35edWkdtSFRZBa8Oyn?=
 =?us-ascii?Q?TJUF8x3ENW7sHmW0qxEgNKsQMp91J4tL4eLZdwRmtGHUuZwR0bHJzlxaBiEi?=
 =?us-ascii?Q?+GfLMgJt3/zsgOZ+trlwKYoWRGraJAYtPeGKgsNH1dEVTEquMQeWzfar5VI7?=
 =?us-ascii?Q?UQvgKkL86wV6FRbB9QWhKi3PA/6rE7CxUYaQSYLZ0vvtPhmfUpPfrMBiwhK5?=
 =?us-ascii?Q?MWmpeyCBp9epSFpWWGZJbB4b41suLNnFbrbRU/HJ8FrSVPN+BzfQuTVWqr9m?=
 =?us-ascii?Q?gMxNRXljmw5Sufb+1HPr5AYfFscXFn982sZWowmxQ9ESw5goszxLqlyzA5oW?=
 =?us-ascii?Q?BuYkP1eHIH+Em8WziPlsUbtRVfdxd9BGHWKD4qIuJzzbkdGo+lp9Q37NdtoD?=
 =?us-ascii?Q?SS19cgDRSBrvEfF3xELMNJ8HFFSow8WC4jT6McRq91LerzoPaBVwJ3h9trh1?=
 =?us-ascii?Q?6G4B/tFvx8UtSVaslfci2jrhRiBwgkD5boW+1IIzf9ijJZpmZ4ZKREsRlBvG?=
 =?us-ascii?Q?IFWmPGYXmUlclT3e3UZ1/noLbHvrI6mU0/XPvIEG6n+SV0NOhl/XOOcfjtN1?=
 =?us-ascii?Q?gNeO2+D2o23cTGuntUbAB/m6T77aXfXsbu0sfpObQRtuAPYGhayJfkTnww8y?=
 =?us-ascii?Q?hhWA6a3z+6uPWDuMByy95b6oFjq8lSE5JC3tmlZbBTMckxp7RWmBnAixCrDb?=
 =?us-ascii?Q?Exu0sAJG0ZOhBHO8raEou5WFDkMF0lN9DVw78YYSUKzygbpl27579+atCtsN?=
 =?us-ascii?Q?mhZq2RAw/4W28tCpx6HF/m7aFJ4r3oSxn2jRFDdTKwKyshTYUNx0F0XGxuHo?=
 =?us-ascii?Q?kV+yPawvVrk0dl9N78cptjHi0h1q8HR/zFfBF1W1+/XuFbjktt8UPw7BPpkD?=
 =?us-ascii?Q?nfHUsek6TyWzzvOW3J8I68FIUq0LMQpH18kWE7HCZ5ZlEd5kCjFzypeeRWKr?=
 =?us-ascii?Q?Jl4SAgOHwFiR0oxp5Q8R4j4RwDtk4OI6LBIXH8fuQvmOEoZj1mCwzxHBZKC5?=
 =?us-ascii?Q?ECkeIhfLBGVbHm7SSipfCvrm5tDp8uceR0FoHHhpiEG1C7ePELWO9heraoJU?=
 =?us-ascii?Q?Bt/ivlNNBsJEOnhWxaNioktOcPCKy76cM4IP3Sjzng/ydL9c2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:04:52.5323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3aaf95c-6830-4f77-5e46-08dcfdd51c72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874

Prepare for an embedded structure design for driver-level iommufd_viommu
objects:
    // include/linux/iommufd.h
    struct iommufd_viommu {
        struct iommufd_object obj;
        ....
    };

    // Some IOMMU driver
    struct iommu_driver_viommu {
        struct iommufd_viommu core;
        ....
    };

It has to expose struct iommufd_object and enum iommufd_object_type from
the core-level private header to the public iommufd header.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 25 +------------------------
 include/linux/iommufd.h                 | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8f3c21a664bd..94cfcab7e9de 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -5,8 +5,8 @@
 #define __IOMMUFD_PRIVATE_H
 
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <linux/iova_bitmap.h>
-#include <linux/refcount.h>
 #include <linux/rwsem.h>
 #include <linux/uaccess.h>
 #include <linux/xarray.h>
@@ -126,29 +126,6 @@ static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
 	return 0;
 }
 
-enum iommufd_object_type {
-	IOMMUFD_OBJ_NONE,
-	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
-	IOMMUFD_OBJ_DEVICE,
-	IOMMUFD_OBJ_HWPT_PAGING,
-	IOMMUFD_OBJ_HWPT_NESTED,
-	IOMMUFD_OBJ_IOAS,
-	IOMMUFD_OBJ_ACCESS,
-	IOMMUFD_OBJ_FAULT,
-#ifdef CONFIG_IOMMUFD_TEST
-	IOMMUFD_OBJ_SELFTEST,
-#endif
-	IOMMUFD_OBJ_MAX,
-};
-
-/* Base struct for all objects with a userspace ID handle. */
-struct iommufd_object {
-	refcount_t shortterm_users;
-	refcount_t users;
-	enum iommufd_object_type type;
-	unsigned int id;
-};
-
 static inline bool iommufd_lock_obj(struct iommufd_object *obj)
 {
 	if (!refcount_inc_not_zero(&obj->users))
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 30f832a60ccb..22948dd03d67 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -8,6 +8,7 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/refcount.h>
 #include <linux/types.h>
 
 struct device;
@@ -18,6 +19,29 @@ struct iommufd_ctx;
 struct iommufd_device;
 struct page;
 
+enum iommufd_object_type {
+	IOMMUFD_OBJ_NONE,
+	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
+	IOMMUFD_OBJ_DEVICE,
+	IOMMUFD_OBJ_HWPT_PAGING,
+	IOMMUFD_OBJ_HWPT_NESTED,
+	IOMMUFD_OBJ_IOAS,
+	IOMMUFD_OBJ_ACCESS,
+	IOMMUFD_OBJ_FAULT,
+#ifdef CONFIG_IOMMUFD_TEST
+	IOMMUFD_OBJ_SELFTEST,
+#endif
+	IOMMUFD_OBJ_MAX,
+};
+
+/* Base struct for all objects with a userspace ID handle. */
+struct iommufd_object {
+	refcount_t shortterm_users;
+	refcount_t users;
+	enum iommufd_object_type type;
+	unsigned int id;
+};
+
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 					   struct device *dev, u32 *id);
 void iommufd_device_unbind(struct iommufd_device *idev);
-- 
2.43.0


