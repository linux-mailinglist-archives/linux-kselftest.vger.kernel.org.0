Return-Path: <linux-kselftest+bounces-23973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94A8A0375F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 06:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12E21622ED
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 05:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E10C78F49;
	Tue,  7 Jan 2025 05:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jOdL9Xrs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F052B647;
	Tue,  7 Jan 2025 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736228020; cv=fail; b=fc89mPpxtqmb8ADf9f+a97FdMwogsQ82RvSw6dmFndlocmaJfLyK70HE1SA0TJGjfwPVQB+9ydq0hVSMYxTRDOXpMb9df5hIWc/Xk4+W/xsUM0j1Q252Zyhp3FBvf4iIF1STCtDh1JP7hpRBJLkCOqpoUTQa1eMsgmSPyMs9hhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736228020; c=relaxed/simple;
	bh=3zdT3JYqDY9QRLJCCI/nsz8SqDMFWxCCkqh9qyNMp8w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzaRAgIEPfRAEldbg41aTYMLvlj4czvsoyzdFttMZBLOOmHo348+jze9nSFNA/lNAQQmSIwgaKsfHsymd6pllPgi7CBwJ87Md7DBh1snILA1QNrNkxHL6D/3WcyAKkA5G2ND/QLWAwK6+m5qdrsoMewCPFEIwaCqFmfmlq+z9zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jOdL9Xrs; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmDJ4IPGxG97JNFbUCdSJkiSgqIOH+OTDWD9Fd+I9sJ01F4GQPGtNfgO0Ta9dcqDCuf8k4ofgi+NgWa1Tf2F3VWq7uV4OKy0NXv8q8/un6xx1JvyLOufTIVpdF9fA0pmw3jJPMDgWN6+5jFknfTovkxyJKbEPbNkny796NndAApoxQfmNxx8AYqaAbjFnwyU/9tsa1bFOAaOdg7R5TWPkutJOao9RWjdVhvmpj7Jyy27hKahcK0sg0IAXKQXFae8P8oWYJJAQp5VcYdFvQ+IaGC4fP3PCJtUXHSu6LvbzXSXwqrRRcePt+iNVd/IRmRaMzCFtZeOiYhsD8vfuRkrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzng9vD8z1aSVeyR/ZW4RQiuyJN+Kp0e1WMzQEPbveo=;
 b=ppyUEBn88a9FJXvfe58T79VTNDXogvaW+WDAHigVyYBQkwgUGdVFfGTcXQcaEA++JCrAtegbBjFrofIo75mdhGU/pCOF++gsJN7LD2ESjlEV4vYkYByxiQS9sDj9f1WWrR8oGnIP8miwGESVo6w8S28TPuCuO70jg9+j+IbLG+xIcPBI1+ExKRPguV/GkSyY6sA/IrOSx8nOrteLNIUyPX2iW6XerOEOgOrttY4q8GyOJdI2sVbllqP1tw/yR97dwgXXVLUh8SezWR/g0JS7pUYsxnnmQ2gDYvfpkTjnEzIk6fscLacIIHukkMpWYQ5re8tqV2otY8RJ6m8VXDR3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzng9vD8z1aSVeyR/ZW4RQiuyJN+Kp0e1WMzQEPbveo=;
 b=jOdL9XrsZGO46Os0eXu/sm8LG7g9SSN+3do57koiGcLdY/fYnpOt/DrxfYU+oRfeW4cVg5R2KhOyUS5HrrnKdZ4NWSL4J8RLJXlUxsSAiEuho7h4e50QUeStuUae80/bYfOWHozwSQY/VbgOp0HnL0dOrNw0U1U9RQS8jGVp8K/87WVn9xtTjnj2LBDWpqUHPyVpAgz4lOBRcbq8t0U6B73dDAHLkLRxovCv6/DkwVEdsPKe6xgouJLbPKfLwWJw00Rw887NYg6e6g9wu8kS6s7U+x44Qd54pPt4RZnZjK8ZF/Rr3OB4mx724ItjPRrZMO3A6IqeSYZjlB7aH2IlLg==
Received: from SA1P222CA0054.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::29)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 05:33:31 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::92) by SA1P222CA0054.outlook.office365.com
 (2603:10b6:806:2d0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.19 via Frontend Transport; Tue,
 7 Jan 2025 05:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 05:33:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 21:33:20 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 21:33:20 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 6 Jan 2025 21:33:18 -0800
Date: Mon, 6 Jan 2025 21:33:16 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v4 14/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <Z3y8nO+Cg/Y3TBtj@Asurada-Nvidia>
References: <cover.1735933254.git.nicolinc@nvidia.com>
 <69a46c72e43ed086840be462eef731167d90a9d8.1735933254.git.nicolinc@nvidia.com>
 <585fc99f-c2dc-459c-929a-c7c7631b9caf@linux.intel.com>
 <Z3wk9TvmUhB3/zlk@Asurada-Nvidia>
 <Z3yvZsq77bpnaoAb@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z3yvZsq77bpnaoAb@Asurada-Nvidia>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cc2239-3b4c-487d-c240-08dd2edcd205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nUPA5DzMX8RZQzjouXJ66vNrU9zK+dyYxKMbHx5p/BA+N5FmLJEoH6eKM+Gk?=
 =?us-ascii?Q?J+ckoOENRkKxwYLszKYF++1e/AD8GrHZMlSEDW5cw7g8zwBUWsudrn0red59?=
 =?us-ascii?Q?UuVt/lBdRWvwQz7e7jsfKUrjK1ryTVh5zCN2gm4KtquEJN6UjkzR/k0iKN61?=
 =?us-ascii?Q?35Tq7piEgqR1qZbxrvG2b7K48EGtv1TuIPmsL42DBYFMszsN8p4df7duJcvJ?=
 =?us-ascii?Q?oXs+U3rqFz4gW42X8+B4KoMzlpDxuy98QY1sUAD37eRp3KuspT9j1806FH7f?=
 =?us-ascii?Q?/B8E97hTm1r+zR7ojyKAMIPn3cDTBeCVA72n1Jqx4PifTcI6XMb7Ns4KEaen?=
 =?us-ascii?Q?fo6RskvqA/p1m6BtH++hmiGNNld1L8QhvyxnOqf4LNRrceCBAUVZrv9REL/H?=
 =?us-ascii?Q?wQah+ar6Y/iE7l2YHBXZeSFrbMDwlDVZJHnZor+pOV/YrEonEkE5ifA4sI0e?=
 =?us-ascii?Q?emGUYnKwB9hv2zFcxaozpfAcvhoqGbSK0OBoNSuZrtq29rRDQPPTPq42zFA0?=
 =?us-ascii?Q?LWkA3c9WHEl3I2ew6u2Sh01RFCziqklDJL5KEbx5nWnSE4V0Y80G2MGi5vJi?=
 =?us-ascii?Q?Rubfla6yQ+L2uQoDvT3827WQiUhg2AEl1isQU6KahaFjpkBSX3R6xRT3A2WF?=
 =?us-ascii?Q?bza1eVZCQ2204uR32MBopN0bnqaiLQmu63YDXEdWJEn4pUbhoJB7dEHg3VF7?=
 =?us-ascii?Q?lGViawqcxwC6zqd79KIh04JLOlnpNeTSa+x6Lcde4FZ/iPhUYjc1YhwTtST5?=
 =?us-ascii?Q?LOfyxSl8/ACCg0EdDXTZ7Tgc5ggvLFgmzTDvip2GkE217qxvsmhtLz9UlCY+?=
 =?us-ascii?Q?ULOBEQzXh0P5qokeCr51rv5s5S3P5WabhmO9BkRnro3ET+ac5oA5yYiWyrhl?=
 =?us-ascii?Q?QhnNd/ccJwHtJu/x+XT2nwg55O+D2N2kAlgDKFips9rO0tiQvZfG96HnWEiL?=
 =?us-ascii?Q?Xs2uYT+9mR5vVCWqctkK24zX8EmVFEcLAJfsIO/WvXyBWaXBXqk4bxFjeQeO?=
 =?us-ascii?Q?a/qGyTNvhXRVNlxXZ9t8qPv3wcrmETqRjLavIc8q3t/k9DPSpM0Q6kt7eafA?=
 =?us-ascii?Q?1+ctAUPOpLJvhIIltPLyYrIaFH0AuoS+BDRoRrRu0i63EAYRpmAZrnxBeBPt?=
 =?us-ascii?Q?P6fiYrIvabT+Q8ur4WYhFFzrHbTInR0cCC7G99Hll5zmfb4pAgLdoe5StoTc?=
 =?us-ascii?Q?o8t7eY8BESgXPVCht4QXX6b8XEz3nAMbCtYCw2Y2gdxsjfbVJdiFTqmsptqo?=
 =?us-ascii?Q?OXSG6LCm50i4xYCIOVpX88zbe/Ji7ee94IBCJrK8dOnz2IY+uwXsvnbTcKil?=
 =?us-ascii?Q?WVp4id2x6MslmzB/EnSOauZRv/F52UV0YVWnFkPJoucNYpOLNN8XWqDa6Zu/?=
 =?us-ascii?Q?fEpZBIWKS4UBMsZg4gsOS0JI47BG9Xx4zZEUnrRlkkTC+P+tU3JApkuqkyG/?=
 =?us-ascii?Q?jEPdEHBkUsN8V3Juh5R1e4vsqT/Frxs7swRU9p/8058O+gAQt8org8vaYopu?=
 =?us-ascii?Q?fhMLJuAhp7EFpz8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 05:33:30.6191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cc2239-3b4c-487d-c240-08dd2edcd205
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669

On Mon, Jan 06, 2025 at 08:37:04PM -0800, Nicolin Chen wrote:
> I added something like this. Will send a v5.
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 0c7a5894ba07..348179f3cf2a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -399,9 +399,15 @@ static int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
>  	return ret;
>  }
>  
> +static bool arm_vsmmu_supports_veventq(unsigned int type)
> +{
> +	return type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3;

Oops. Corrected this: IOMMU_VEVENTQ_TYPE_ARM_SMMUV3

And added your bits too:

@@ -83,6 +83,9 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,

        if (!viommu)
                return -ENODEV;
+       if (WARN_ON_ONCE(!viommu->ops || !viommu->ops->supports_veventq ||
+                        !viommu->ops->supports_veventq(type)))
+               return -EOPNOTSUPP;
        if (WARN_ON_ONCE(!data_len || !event_data))
                return -EINVAL;

Thanks!
Nicolin

