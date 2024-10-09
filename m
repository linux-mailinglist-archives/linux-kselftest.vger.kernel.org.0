Return-Path: <linux-kselftest+bounces-19362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAF19971E3
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7721C22E3E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7501A2630;
	Wed,  9 Oct 2024 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RLdkKt/Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A73198848;
	Wed,  9 Oct 2024 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491938; cv=fail; b=f+pgrovatWlWAnpNW1q0frDtPdnEup2DScMOHfqTMi9ym60fWY9mcUSvyV8mu12dnFrtmYEQsaTnSJ+RV+hfwdEa71GLca8dYlIaqKZX/V5WgvIqFgWCsZIYcBfoYtvEEUZI01ZN+qz8lZkyQmU5F8pmBdjgBuJR2mKJCSB7NLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491938; c=relaxed/simple;
	bh=SApE3GCPqZH/uCSe7e8gMULELbo5ambvaKWTYB9Ut8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAQfwQNz7JboGWAaR3sGpIWxNoncv41Y/foke8FdamlCHXZyB6uqySh7ohQdZHe5YXkEINZilmJY4eW8RsFLmpox92oFcHNZNHbKAUf0GMdQrw1rK3btBYoWgUoAaqZgdzKIwJNuDRwktcsM9MtBPwfl17OZma+docGWy7OQlz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RLdkKt/Z; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qxz1dcNC73w4zAy2vVmx0MDkj+tSBvnu/aVfOjqG23/6IoWc4LDLBAfFynjTIsGjdxce/hLkiVXTMJny9ihTpg0SnmIREgBdX+RfeeU8rwIYb+XelCxulEeTmiuaihlzcazagMf2J0Ap9nPt5kJc+/vSL6TCdykkoF3GxzW4WLlXSgKnkVWFOaMkLaZ18ysxuei0BtRoD7SIMvBA/Ft+dVG4lGrOa9GVy382/JypxNW3gbr6jfx7JqHOTodxmeoOIzk+FhJkfZBRyFt0h3EaOefzzogCbckTUMoZz5L991OX0m6B2ZR0+yUi4BnVEMaKlA+2shjDQr59eo+heFfCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfnVr/P2CXVIefuACEBeVcPO0aBfVXfViEe3Kdtg3LA=;
 b=E+Xu44IGIP/dNDHgIDE5EfUSnEfvEnUdUUIdUlqNcJTYQOZycOEEJWFYnSPWdaCOpb2VCZw6nD+Fa76VweccozPCqBbLg8S61RnOwS4D9MDphYB5SqIAEGyCThrQ9YGS1ITlhscTGo2ajmH3XL84FjfIT7T+QFWh8STUxsctlNxVwpBNId1PuofnYqZTH23WsfjvCpCH/IcAo+YONzZPkXJOB9+2LvwZTkYQF8wkw78/bbGL9A5f8BTfZCsfgA8nsI0HU+INdtXrY7Cs9tWZFtVrm9IU2wYM02g2nJWNBDh9xX1RAviSc7rEXxHlb8njODk7RmSmQSlUvdSl++k/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfnVr/P2CXVIefuACEBeVcPO0aBfVXfViEe3Kdtg3LA=;
 b=RLdkKt/Z2DojCqu6COuNzRGPqQ8QS/oaBMFDFlKZQp+lWe74MUnkVoBF0a1EkIbL8EnvktXndATGFbaqFnQ9vLe0ZUQifsBihW/tB4oHCvyXJHpMqLdkI8Oj4C1pQlUjEmomveCkrSFP8VPar7r+J6WKGRqCdE7bBfhGCsQhriJ+Yiy5jePN9EwbXhxeBMjo8U8hzieaww9vQWA38KrderW69HWpt8i8QI9bPGcm3Z6iFCaD4M02yis0lVXOilpEj1Hk6C/qXqS9HIEGf1A5Pu3Vqh+svq2cP/SCa5e3EJn4g3j6GvjyWw+6AKV3ViWbrbpHRyM93P9wqWDiNP6rRA==
Received: from DM6PR04CA0018.namprd04.prod.outlook.com (2603:10b6:5:334::23)
 by SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 16:38:50 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::35) by DM6PR04CA0018.outlook.office365.com
 (2603:10b6:5:334::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:38:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:38:42 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:38:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:38:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v3 02/11] iommufd: Rename _iommufd_object_alloc to iommufd_object_alloc_elm
Date: Wed, 9 Oct 2024 09:38:02 -0700
Message-ID: <dbfc718cd3200071765007c7ca0a2ba242181d05.1728491453.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491453.git.nicolinc@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SA1PR12MB8644:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc03546-3d5b-4ae4-ed26-08dce880dac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zn/vizNZOg/6BBtSXEMycYFvHG42dtUSbn9h1JBlWa+Zjdsy3urzAg32qvYR?=
 =?us-ascii?Q?L8MsrJLPCfVOnfhZlfjlNE8YuYXIksZoS3LCVJ3gXBW39TZ8lMKhmSlpYLpP?=
 =?us-ascii?Q?Lyzbhom//5zqZdIy/0ZedeHalz1Zy8L26cHB1x3FvWj4F3PC3yNM/0v2rG6t?=
 =?us-ascii?Q?Zf+ru3Z7vLkxg+UAeJxOKsKWZKy7W8PBo3IeJuLU99Re4sSEoQJhP0Elxl40?=
 =?us-ascii?Q?mIsFsrczwz9ZU+Dujk9Ci20uUne/m/hU12EngGnG56WyPyZ8U3wOe7t1yeXX?=
 =?us-ascii?Q?wXsEy4ntcoQEpvHzA/ZBvcO2HxPof76m4xmIAEvRqvUeXcjtEo+pJXQnamZj?=
 =?us-ascii?Q?ivzKQaiwBti3D3prxTGgcAJpz9GdjKhp3OfoHmhfWa5RnF6EiHCeiGrhLJzU?=
 =?us-ascii?Q?CR5jr/31r7wL/2Hwg0EJsXzFDyZTiS+X6agSbZC6MDUnGe8l4Fw4Zdkb5Afg?=
 =?us-ascii?Q?tM1uH7cJnri+yXUPcKAnIku97xJxQoBDGz/egviCBR+Pz0CNeVkKs4NYFbIA?=
 =?us-ascii?Q?oO3dQB/Fpu6FoUEV7/8Qpj9eoM/w87tu+je+m/l4pVXShv3bDRmW6fIiPAqx?=
 =?us-ascii?Q?bkBbVpCB93HIeHuFTGL5nSj31SsmFEomrj2Xu94qzl3terbQqxA59q22qrf8?=
 =?us-ascii?Q?MfW/GTkCGKt4dDYA2TD7JStY4/x+no5snRFrSEXSnVYLAW9BfscMZFOy7OY4?=
 =?us-ascii?Q?GsOVXvimdaGH1OsRm6mVGkqt85Qk4AWOw2zEe51G85YDvB6OVL+EXbOzZPXW?=
 =?us-ascii?Q?wwossiC9n/wWn2kfkjr4ZjV4qcF2svdx/L3DbKgUAG9dy6mU8FLJpBHNQVWW?=
 =?us-ascii?Q?LaOQgLtGc9eendF5uQNPQk6+k+6WmMpCMejRYIUJslUcv7DygAyGRCXvCMoU?=
 =?us-ascii?Q?GlZcdPAlFZ9dXB4OJSaG0huZmWGmTXnWcH0T3n4cr32vYJ9qUKZM7LBydnE+?=
 =?us-ascii?Q?aQaA/FI2OYJTY3b5T7LvnTMasVfiomQWrKzXA0wCftR8pKYYRBqiTVzsjrXw?=
 =?us-ascii?Q?tP4TYg7gqdXevkoLgZGCwwhMoDRwFQMs2fe+N4ZR0vSoU20NKTvVdMGptEsu?=
 =?us-ascii?Q?rexyh9/nOTEUVug7JL4PFeje0e16YSeozPJgXk8SCkUhmPMz1ORgHnI07SwK?=
 =?us-ascii?Q?RfWTQXoM3LqVLGrNowTlrXEMg8A4dg7ByzeHMIE5WPhnCLPyffSjawF/ESB0?=
 =?us-ascii?Q?CojGmulHA8jdFMI2yUd51DJH1f/V9S4kk1Kq4XVKZTHr4ihXwebuFQl+P0U7?=
 =?us-ascii?Q?DFfS4WyUl0C1mzuxuNji/Q7aqgO01X70nW4yqYlzvSceJU4w174ZmMa53A6W?=
 =?us-ascii?Q?7/v2pYEmA+l6w4HvmgEbphAyabJF6I5p0uN8apyTlWNfgEZh8h879Y9YQ5DK?=
 =?us-ascii?Q?3ZiY+o5/JhD8GnpaXMaY7SdiMyQC?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:38:50.2223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc03546-3d5b-4ae4-ed26-08dce880dac5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644

Currently, the object allocation function calls:
level-0: iommufd_object_alloc()
level-1:     __iommufd_object_alloc()
level-2:         _iommufd_object_alloc()

So the level-1 and level-2 look inverted.

The level-1 allocator is a container_of converter with a pointer sanity,
backing the level-0 allocator. But the level-2 allocator does the actual
object element allocations. Thus, rename the level-2 allocator, so those
two inverted namings would be:

level-0: iommufd_object_alloc()
level-1:     __iommufd_object_alloc()
level-2:         iommufd_object_alloc_elm()

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 8 ++++----
 drivers/iommu/iommufd/main.c            | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 7221f81ae211..f2f3a906eac9 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -217,12 +217,12 @@ iommufd_object_put_and_try_destroy(struct iommufd_ctx *ictx,
 	iommufd_object_remove(ictx, obj, obj->id, 0);
 }
 
-struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
-					     size_t size,
-					     enum iommufd_object_type type);
+struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
+						size_t size,
+						enum iommufd_object_type type);
 
 #define __iommufd_object_alloc(ictx, ptr, type, obj)                           \
-	container_of(_iommufd_object_alloc(                                    \
+	container_of(iommufd_object_alloc_elm(                                 \
 			     ictx,                                             \
 			     sizeof(*(ptr)) + BUILD_BUG_ON_ZERO(               \
 						      offsetof(typeof(*(ptr)), \
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index b5f5d27ee963..28e1ef5666e9 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -29,9 +29,9 @@ struct iommufd_object_ops {
 static const struct iommufd_object_ops iommufd_object_ops[];
 static struct miscdevice vfio_misc_dev;
 
-struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
-					     size_t size,
-					     enum iommufd_object_type type)
+struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
+						size_t size,
+						enum iommufd_object_type type)
 {
 	struct iommufd_object *obj;
 	int rc;
-- 
2.43.0


