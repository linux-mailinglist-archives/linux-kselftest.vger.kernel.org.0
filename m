Return-Path: <linux-kselftest+bounces-21245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6589B82A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 19:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2EB21F2252B
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674CF1BC9F3;
	Thu, 31 Oct 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3Sd+ldg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327941E495;
	Thu, 31 Oct 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730399628; cv=fail; b=nkoLr87IDpVcEyIEbXwwFAFsECbAe890SGr7fgNigiXXyAMQUz+LyEMlfWvEEW4i3F/Bp34PM5VP4h3jKbWshtf8N9h3pnaF5BkFDClTZ/KeY7mZ4pCc3cNel3AAo1qgazwImZsynK463eT1cZlJBowzqqAQMmzyC6lsiC/mylk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730399628; c=relaxed/simple;
	bh=AC5R0abFBRS8yWsme8gZPKYV4HebATPq9QQVyM7/KaA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gg9IvXaTomP2g4TWbSxD+sFcsVo6h/aieRaqAiLbkRi2azJ0CFDq3A30AQBiKzbq7JVRXuM4zW9vhV5Di4uq7fAAEXg5PAP4bg3Fpp4pXQJgK5/yMbp4Y6P941W/cXJACX22z5U/V7EMzgyc89ecmLcKp69kRUQI41lJP6MGxnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3Sd+ldg; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUxjwLuOSAPkNS8y3cir1kZxgSGZOPc1EE8AFFNaIA3umLvbQtKQyEOJniFXz3yffUowWZUB0vwihKaOIKpg6cIUm3JL5t4CdJk+//FKmmcEIxFM3jbxOjgOTrqMr32taGI9VOh+s9wMiEi96ncJK9KdI5zpXTQ6MsEE+BpDEYj8qO6+5X3SKzKI9itZVKdS2Jr0RaKFyAqCfIDI+CE2mu/tbqOQj5jLiYLXrNXNG2hpj38rkYAtde6O1oKRrTTN8pFMex5XU4Q1aH2x3AkXLqwme0yCkXuAxmwBgnTE39ZgKaOtl+2d/oDxGuSkB4FtQt2AC2mBxiQLQKOpvGYckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaGtt5UWke7eKLBcn9GJysdUCXPLuMsJR2N2fnRzcT0=;
 b=ZC8oovF0FQUhGgkxz76EmAOqDY1FPCW+Ypb5Jeh2KdtaOn3oD93hkRzahrp71uzKaYYqlXfaYhrFRWXb09/J93R3VnHE/JYFRx0csSBwY7RDaL3FKDC26IxesG1u3i0n/2lTKBzmP9c0mrd8217UTN7UexQvtlnbaMdfDMbCBxfm9v0pUF4MLTjf10cAmGP6LziTqmidMX9O3hn+KqA6BGKS6mIir+aTKT9ayKdVGzncuiQWtZCg/NjXUIeqhlzvrtxZwg6mwMZquhAFp/E7YY29az0I55S+/boD/pi8AuCrru6QnfI1o0PwMXO7vub4N2cYf98kNDXj5TDRHIBlXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaGtt5UWke7eKLBcn9GJysdUCXPLuMsJR2N2fnRzcT0=;
 b=q3Sd+ldgXUGRihb0iUEvrCE0DSPnGmcgBxZR1hBB2P5GJJ6SLLnMCgh8/dtq+Nq/S5wOmcA846o7oYvVY+K7D7zzgQMiCYTnEgI7BhYX3hm/5C/zRylnTS+/7zv1qJR6yWVdlLp1L4r5cJcA8MFernW4CCwyBrcjueTrpjMu9VLXNgBKjxDPPJcXRi4jhmqYuq4hDXec9aRBP+RzRh79ZWAzmZdngqmxmpwd0Q+clt9QGKfV1IGh3c2mmPwqIp6Auw0+1mdhduU2SzkE+osQon+lzPKPbiMKxSJ0qkee/2CWd/hVOuuBQJuPOHL+3KQHha+7HAWPSMQTX6shc4NYsw==
Received: from PH7P220CA0135.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::35)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 18:33:42 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::bf) by PH7P220CA0135.outlook.office365.com
 (2603:10b6:510:327::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Thu, 31 Oct 2024 18:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:33:42 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 11:33:26 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 31 Oct 2024 11:33:25 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 31 Oct 2024 11:33:24 -0700
Date: Thu, 31 Oct 2024 11:33:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v6 12/13] iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test
 coverage
Message-ID: <ZyPNc0VhJUrTGZAq@Asurada-Nvidia>
References: <cover.1730313237.git.nicolinc@nvidia.com>
 <8188b47bbee49e071907e1df37a3af269bd840b6.1730313237.git.nicolinc@nvidia.com>
 <20241031131637.GK10193@nvidia.com>
 <ZyOydn+/s6enh1jg@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZyOydn+/s6enh1jg@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|MN2PR12MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: 94bf1a32-fd93-4dd5-a0c9-08dcf9da8bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DuJOHwUzdb2FSrznFbT2l+vcrenBbAPr262kbsWyKYvUvbXFJj9MR9fpGq04?=
 =?us-ascii?Q?seg+P7DpSI+giWta97QKGYeigrgbLm0eMbVZzEfVS0eYMlnzYFN7OdT249kR?=
 =?us-ascii?Q?TY/GfwipvNWI3H+Ll12ob+G+ldLwFhAPU9dNymbg2ReV6dOYIQj2+2tnTuyt?=
 =?us-ascii?Q?PTpYKweR90+AfDLkiT6EQ6yfw0NEM7vVwHDARy2TblAgLim/Hm4YFnfkeyPb?=
 =?us-ascii?Q?OjRLTU7mxmvzRPNiJfmClWJieKM5FDeztOItH3PvkufWjTEhJ6vmJ6Xi6wUj?=
 =?us-ascii?Q?yxky27d5fgXt3tLfm6n3TIiMjFOLwYOeu02iwtbvXKVU5Y6lnCvF6aOAPeSY?=
 =?us-ascii?Q?TbQlsvBNoIeXZXzre0S/jeIMbavgWVB0AOvzvnqj9qbfg0yPYsvVxgM85xPm?=
 =?us-ascii?Q?tl2vYgO9pYkt9zitz0RV5ww9e92qCqXGAnbDeFVQaBubPuaXj8ykIiPnllTi?=
 =?us-ascii?Q?nlWKDqiyYN+Sz0f2E1t6QkMmCNYsGnTmxdLuUp8/QPsFbBbf3HgBZzNH/FUB?=
 =?us-ascii?Q?gfnpVA1Bssue2CkNUI019CzMFYxDX4/WU/C5S2+5eKAqZBZL4Wd3FtkDrsNw?=
 =?us-ascii?Q?zBdlIFZU2Z+94qTdG+uNeXBonNBQEjglUgbihPxt8t9saOtNmI53znH5t8WY?=
 =?us-ascii?Q?g6r+xiqBXQXCoRlFJCwXaMn/cVAEeQL2f23zb47kLfFWvcrvVvFxAHbZn7yo?=
 =?us-ascii?Q?0Nn5OvELKGG/OdtC43NffMsrT9CCS5as0nnVnnghcI25swuQO2+EzlUsMBAr?=
 =?us-ascii?Q?y+YpoYS766f2xSh2re14dvWRsrYoK5xDJepUwtQtw16dn8/aoUe4QQwARAJo?=
 =?us-ascii?Q?97fNnExz88TYbMengTdsXTGn5bGtAQS7mZEZNLKAFcEumARb20QZWt2BJAEG?=
 =?us-ascii?Q?dl4SQql4xrPBfChFUoh6iB9cbi71UUccJJ4yL3z0OcqmrqeXv/qznOn+Jvpi?=
 =?us-ascii?Q?FAGInubu2TOBsYQCrcAI4TKn9DoXQCSJKR+vv84pBO/LgGyVbTcbER8zvP17?=
 =?us-ascii?Q?RKRXerHgMAEKkWMTK0JzM928AI/V40NDs2QYzwKJttvWl6+aDQEljOpOxh0j?=
 =?us-ascii?Q?CSmNABMdVlvcEbvoAYnHdwB8Fylm3OJPEiksG2/TIrWt+Qh9H5K2nQIbceKR?=
 =?us-ascii?Q?rjOcmXHGtFawdtjvuhqahoDAW1MvWXQJftkxYivPeW+XDQEaSmy65fyaj2uk?=
 =?us-ascii?Q?KHZvLGN+R2FWM+oPj+4TdCBD6Xq7Vg9Ik4fgo/sHlqrTsZl9i7dX7WR1V6GX?=
 =?us-ascii?Q?FPYrIuzpGppnIUkA1bGTzzxiIgAaM/KckD3iF3gOEPscmlHsHHktZ5yxrR0r?=
 =?us-ascii?Q?ZGIXtP7VbfORjJwztK7i8yug8aztXVJrPPHC9gFf2aDB14k16i+u/AydyAHm?=
 =?us-ascii?Q?oFz4kM2alBfpkfJ3hkqUKxex2RWjp/iwhcZjVJMhQYzkA5kReA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:33:42.2329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bf1a32-fd93-4dd5-a0c9-08dcf9da8bca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301

On Thu, Oct 31, 2024 at 09:38:17AM -0700, Nicolin Chen wrote:
> On Thu, Oct 31, 2024 at 10:16:37AM -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 30, 2024 at 02:34:38PM -0700, Nicolin Chen wrote:
> > > +FIXTURE_SETUP(iommufd_viommu)
...
> > > +		EXPECT_ERRNO(EBUSY,
> > > +			     _test_ioctl_destroy(self->fd, self->hwpt_id));
> > 
> > There shouldn't be testing in the FIXTURE_SETUP, it should just do
> > enough to setup the fixture. negative tests/etc should be in their own
> > function
> 
> OK. I'll make a change by moving all EXPECT_ERRNOs to a TEST_F.

Will squash the followings into this patch in v7:

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 4fc5185fca0dc..bad11f65b63dd 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2424,42 +2424,21 @@ FIXTURE_SETUP(iommufd_viommu)
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_id, NULL,
 				     &self->device_id);
 
-		/* Negative test -- invalid hwpt */
-		test_err_viommu_alloc(ENOENT, self->device_id, self->hwpt_id,
-				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
-
-		/* Negative test -- not a nesting parent hwpt */
-		test_cmd_hwpt_alloc(self->device_id, self->ioas_id, 0,
-				    &self->hwpt_id);
-		test_err_viommu_alloc(EINVAL, self->device_id, self->hwpt_id,
-				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
-		test_ioctl_destroy(self->hwpt_id);
-
 		/* Allocate a nesting parent hwpt */
 		test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
 				    IOMMU_HWPT_ALLOC_NEST_PARENT,
 				    &self->hwpt_id);
-		/* Negative test -- unsupported viommu type */
-		test_err_viommu_alloc(EOPNOTSUPP, self->device_id,
-				      self->hwpt_id, 0xdead, NULL);
 
 		/* Allocate a vIOMMU taking refcount of the parent hwpt */
 		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
 				      IOMMU_VIOMMU_TYPE_SELFTEST,
 				      &self->viommu_id);
-		EXPECT_ERRNO(EBUSY,
-			     _test_ioctl_destroy(self->fd, self->hwpt_id));
 
 		/* Allocate a regular nested hwpt */
 		test_cmd_hwpt_alloc_nested(self->device_id, self->viommu_id, 0,
 					   &self->nested_hwpt_id,
 					   IOMMU_HWPT_DATA_SELFTEST, &data,
 					   sizeof(data));
-		EXPECT_ERRNO(EBUSY,
-			     _test_ioctl_destroy(self->fd, self->viommu_id));
-	} else {
-		test_err_viommu_alloc(ENOENT, self->device_id, self->hwpt_id,
-				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
 	}
 }
 
@@ -2482,6 +2461,36 @@ TEST_F(iommufd_viommu, viommu_auto_destroy)
 {
 }
 
+TEST_F(iommufd_viommu, viommu_negative_tests)
+{
+	uint32_t device_id = self->device_id;
+	uint32_t ioas_id = self->ioas_id;
+	uint32_t hwpt_id;
+
+	if (self->device_id) {
+		/* Negative test -- invalid hwpt (hwpt_id=0) */
+		test_err_viommu_alloc(ENOENT, device_id, 0,
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
+
+		/* Negative test -- not a nesting parent hwpt */
+		test_cmd_hwpt_alloc(device_id, ioas_id, 0, &hwpt_id);
+		test_err_viommu_alloc(EINVAL, device_id, hwpt_id,
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
+		test_ioctl_destroy(hwpt_id);
+
+		/* Negative test -- unsupported viommu type */
+		test_err_viommu_alloc(EOPNOTSUPP, device_id, self->hwpt_id,
+				      0xdead, NULL);
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, self->hwpt_id));
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, self->viommu_id));
+	} else {
+		test_err_viommu_alloc(ENOENT, self->device_id, self->hwpt_id,
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
+	}
+}
+
 TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
 {
 	struct iommu_hwpt_selftest data = {

