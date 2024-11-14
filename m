Return-Path: <linux-kselftest+bounces-21973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D889C7F49
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 01:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4854F282DFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC748F9DF;
	Thu, 14 Nov 2024 00:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tyIKgADQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CB11799B;
	Thu, 14 Nov 2024 00:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731543552; cv=fail; b=it0MgJERj8gIuKrYvs71iQSWGcYqbmfzfKUHYikBmck1cu1Dlxutoz/5tyWid9Uz88qL7UqY8zJ96g6kMrsLCXVnYJw8x6PlsJlIXusdTMI/BB7P0cpbSYCAiAyJdFq63CabIziv56ubwlJlV1GPjzob5f/uT2xF4DAmuQy74HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731543552; c=relaxed/simple;
	bh=lgwc3P7HtsYYLOmU8NGXUH4ItZ8R2/Pf7maJpIPjxiM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4me9kv8jgiae1gYUVylKjSBE6B8jxuR/mxzFw7TSgn2DijqOSWqNWwW/0sNmBaVOfmgey88eGbB7zpOsb8AEkc9XAcZD12CXTEoA2Ejho22uuFUhPDj/8f1ZTZS+JK8Oo8z+HJIXoTjEqH+gFsuUNVayNp7na+3z76g5DApM/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tyIKgADQ; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQKVknVr3WrGIA+mlES2wD0XQI6bnJK0diqbd6areQvfS/qasudXdzvMSjVqS/nasTZEH/HLxzJsjzY0yq+BPDdhCSCKwJ7hsqn0FB655znk6am1r7oQGeNPW3+nDKK+EKbfOncl+iabc5J4MAp/+iYltYxE4m1iemmhEuE2fkSaejH95sUvcZXjhcDZhpHXwcsD5JsM/Pzhr7BF8ho7rEoY04ycweH94ObqK8HLqxzFUBnOGBROGNsvRSlDwwsSfirQGEbgeEoCCyJUTRIqBX6a7h+h5H/A3vguYE0ak2xwlcBaCXaZKBYhWz+yFYICI1ZVvm3/yxqMBgTt0pEPdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dExGh8cOnMXtY8SKMGXZZfSo74w6NHsY15goafFjvB8=;
 b=Es5nVLsA6A46GYMFXxujOFT0PQb0Uft0UHB5lj9yfHtQBJAF8IdNTAjS30Rph6hOoVmzzJiO0mYxwe+MA0RXLhvI3M496u62ii4WJc5sxrnnlj0RrgIvO7gkmQBPS1fqLbdS8sNBbzGKHzDUr4vzRzDvWYQq5H7cWbVDfW7LXwwzu8uZIGcRehDf631IqcNsWghROSipEhs2s4/uc4QCKhirRhIyENW7hCbSseQnFfXb/NIziq4WmiALFSs4geoqU7V+iAfitMU6xY0Da1iy3mve+mkLxgVyJo9YOVC9ACeRe1geumQKA2ZbzwsANBMYg0AthgVVS0W7O9HK/3kK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dExGh8cOnMXtY8SKMGXZZfSo74w6NHsY15goafFjvB8=;
 b=tyIKgADQFRq0kw2Fj2DfpjV2hS9wghMRrizz1vFvcvJCeRq5fCzSQ1UcYShSc2HWlhNQFfHt3mq3XX3ybFy8QCoQv1m/L7eCTZwJDuleRDSwrWqNATSFVBiQCw+7Knw1ZZSnJINHFeF9iLaxsJZLmZTn768CmDfpKuHhiCVM7svr7qplbOkNbtGeXMUnoR3ej4Q3zoPYKM0niPPwVegyG5DyeAMx1uvGgnFI1rtPdim2LOREm9ShXVsucBJPLDhYOzlEjCwxtJPTlV58pM0sQ1kZnBEKAEpXnWeZ5kTpWCZkMMw6vEh6obdAcbOXCBBpX5eP0j9ID22ry8ioXZbbtw==
Received: from SJ0PR13CA0106.namprd13.prod.outlook.com (2603:10b6:a03:2c5::21)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Thu, 14 Nov
 2024 00:19:08 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::43) by SJ0PR13CA0106.outlook.office365.com
 (2603:10b6:a03:2c5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15 via Frontend
 Transport; Thu, 14 Nov 2024 00:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 00:19:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 16:18:56 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 16:18:56 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 16:18:54 -0800
Date: Wed, 13 Nov 2024 16:18:52 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v7 13/13] Documentation: userspace-api: iommufd: Update
 vIOMMU
Message-ID: <ZzVB7Fun48rGztuV@Asurada-Nvidia>
References: <cover.1730836219.git.nicolinc@nvidia.com>
 <7e4302064e0d02137c1b1e139342affc0485ed3f.1730836219.git.nicolinc@nvidia.com>
 <f0c45d5b-b8cd-4f75-a9d7-21808f18583d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f0c45d5b-b8cd-4f75-a9d7-21808f18583d@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: 359a2546-aa95-4d21-9bad-08dd0441f480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7MvYgh4ek0g/Hn+//HNO8olkYKB6+BcNiMtwKHvVM9lep4RTX7qe8c+lZtAp?=
 =?us-ascii?Q?LZWL1sXQQPW1GjXW8nBOm0hHmYVDniLPfihTMHFDwToFPYzkMxT/5ZlyXnjs?=
 =?us-ascii?Q?cfLHI7OlE2j3gJAkPvyyA0mjMVMoEVpvGLmnQXTyhoMWasEeyArSta41zMLe?=
 =?us-ascii?Q?e3r/uDUKM5l5uG05waGHixHLvOXexbXpDpkznQZomxGs4eq8cghXrgskOEO4?=
 =?us-ascii?Q?GlFGuhLqKoiqpfh1o75HBgBfoWh4Rd2clRJ853uRsHhDzf4PlVugfB8TXuV6?=
 =?us-ascii?Q?leHrTpikhFUfJXqyUSAqr+eaWKIGq+bMtqZjANywxlwPI2D8qOPy5hleI+Ct?=
 =?us-ascii?Q?rNlWik/SDXNROU5I+qPbsZb+dOR50Xv34pnF7ZEzzfqn2iz8uMojR9lwThvu?=
 =?us-ascii?Q?bHq/J1USrTiXCLMw+/Q+Q3uWagCHBQKQvWqhI7XkKLykNz9JbquZB1UQ9xHZ?=
 =?us-ascii?Q?LCe/nzbAneGQYmeUv3Bv8VJV2rhYoh99ZAIx9GRLDBW+zgmJ8F1pl4RwaQSS?=
 =?us-ascii?Q?DmzFv5/4nK2u1OrBdXOHqsk22126wlLqwQoB0Ri5yFL6IqSRk9g2ccpgGCIt?=
 =?us-ascii?Q?jsQsP6uq9GczJXbjjg2cADwwz98+2Tzh3BYtOintXkIUlqzTJhQtz2zsQyrQ?=
 =?us-ascii?Q?4WhMTbYWTYpvUaKq5xRfHYAvU6FYoKaJgW4UVJcZx6Xyh+2eGrdiQZcj9Ts9?=
 =?us-ascii?Q?xSt0my3h0f0YfmvOfnDafcANGo9u7Xf2Kqk4uHwfJ4Xhx9OQ/foChURF1HAh?=
 =?us-ascii?Q?6Rq0e5sPUyug9GxEgQuSjNJUFh7SxDLx0zWgGzUyNtkMJ2+G5PNag/bHd7PQ?=
 =?us-ascii?Q?3wDylDvdOx2DFvMOzHdlAsdXZYPm07SdQCLPUzM5zsHh1q4RT8Ak/vyqH6Oj?=
 =?us-ascii?Q?7K76oCHOrv4FXx0Atu0IOGvYblIOiGn8hXSOMs+T3U10sV4Ac/gB0XLWOB/l?=
 =?us-ascii?Q?UEMxLHoLFaWi3zy9AdIMAmJ2vj1eAogW/dLU/rta6MHsvkLgFTg71OIJnq5I?=
 =?us-ascii?Q?BMw4Kecc37/DoGmSooTRffl+AgoCptyJmEhXk2ZYRhW0zfgJ2RwpdkWQ4+Gc?=
 =?us-ascii?Q?US16xey9cSQdC9MG0tUoSg3wzFL1P5nLrAObB4CvRvObmFMae689hWCKYiVk?=
 =?us-ascii?Q?BoEuRBoNdG6RJc8VYThpSzIaKH/4eD5zgHnIG9pmQyTJrcjrhMzE8860dyIf?=
 =?us-ascii?Q?NSh25wfRaI7fIfMxl4jQPJsynihg5AwSBSslN0OnCGZkKiAGsU9mFm/7shYc?=
 =?us-ascii?Q?I/bEzq0qeHg0BPWvtq+EAIiO2Fuqzk3ZouCW66XqYINiB+grRcDugOUkhku/?=
 =?us-ascii?Q?1bo5ypy8Llk25hty3e6j7JIJpx+9DBFLg/b83EvRazc6/8ymr8GlZCPhwQ9U?=
 =?us-ascii?Q?usiLQqAwLSQSqxmElv22jaZicURfKxzYcEXbWb79RtU39Q/cuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 00:19:07.7620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 359a2546-aa95-4d21-9bad-08dd0441f480
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384

On Tue, Nov 12, 2024 at 09:15:02PM +0800, Yi Liu wrote:
> On 2024/11/6 04:04, Nicolin Chen wrote:
> > +5. IOMMUFD_OBJ_VIOMMU can be only manually created via the IOMMU_VIOMMU_ALLOC
> > +   uAPI, provided a dev_id (for the device's physical IOMMU to back the vIOMMU)
> > +   and an hwpt_id (to associate the vIOMMU to a nesting parent HWPT_PAGING). The
> > +   iommufd core will link the vIOMMU object to the struct iommu_device that the
> > +   struct device is behind.
> 
> It looks to be reasonable to share the viommu_obj between devices behind
> the same physical IOMMU. This design seems no enforcement for it. So it's
> all up to userspace from what I got. :)

It enforces at the vDEVICE allocation:
	if (viommu->iommu_dev != __iommu_get_iommu_dev(idev->dev)) {
		return -EINVAL;

Yet, assuming you are referring to creating two vIOMMUs per VM for
two devices behind the same IOMMU (?), there is no enforcement..

The suggested way for VMM, just like two devices sharing the same
s2 parent hwpt, is to share the vIOMMU object.

Thanks
Nic

