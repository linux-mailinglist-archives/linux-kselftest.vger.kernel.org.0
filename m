Return-Path: <linux-kselftest+bounces-20837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B199E9B3B3C
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 21:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBC82824F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2341E009E;
	Mon, 28 Oct 2024 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kO+q/oKJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421211DF991;
	Mon, 28 Oct 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146783; cv=fail; b=lrMQjmjrZTiXGhjJQSr0cOho0lw8+bmFvh7lLRAEAxsS3MUphRaVEi0IhG9oOhrhQdLvTlT6jOtzmVwnATNkco2CRneX3qV3e6BZ6AQmJF0PAEuZGpqdtyon5NETZYCz7NSrCVo1ukWYQXampHMy9Q77NpqlOA5OazU5ytpEtQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146783; c=relaxed/simple;
	bh=0phIrOmT4SCaWlQRNgIQcxmZWbeJMExZlsLGrn4soe0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ1AuEpQZNDj3CIa6UErsEOxqK301719pqWvAhEC3pNSnMhVPO1DlUppXtuNYZchabJ1k8k3Wa5upnNnzRRHljr4IJsSF6Z4t1gXBd5c7TP+FGCgQcaW4wviqmiCYBmaNkGlunfI01Xt8IFgytVv2E2sPs8b1OkuX8ZhEMxsDAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kO+q/oKJ; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0mDlmnOIhcB2wT0LMah1QNwq2Jg+CCvYyNnsl2G/RXtuWALz0Bv6FHe2f2KlBcm+gJtvh0THHn4gShpO5CSPruC+iPaUq6yvNsVL01sKsdBOfNDENxv7L0nqc7M9h41/nx+8g1pcYb6YKMoAv/DYee34vzxJ7tDEs78GvThCAd+axvY9mLi9vrQjW0Uyog+wPm5qe5qqlhQ5ux9bHQbISSFOAR/qZGnODdgzlp0ye093GiCuEpuWfcF1lnXOjDid/kB7AE1J6mMJpdFvGEdGMfMlh9RRqRZ1y2jT8N9s//95waSepuv1pj5n7htDQf+ks2I6TIvVWHSDQIuRxG9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l085bFXEz7mX3NVXad/6xlstnHoyrhvXCeX72ETTvk=;
 b=I+K9IH65E81v0n0pwfppr6VLVnm6MndpSHYOv37qT38yMPtKqfFgtNDeTGRMQnPWkkFex0cOym9eSXLrGkSqARkWDJtIkzO95gIT3vv7P8UtH+cA0I0zDGDtLgLi33hFH+IrCI2Te80dU/G8WMo0QLOgqIRS6ndBLZPEKSWxHOy01mZcpdghVtz4pbljTWDvJGo+caWeKY5u8H3t54lSiDCvGK5aJ6FARkoDiQuHaUqGzZqDVrc2+Tt7JTJGsckIjTj/W1n9+jVnrUnbCQaqryusnM1elgib9u8um//UnYJx78N4rfb4nqWvmhlIMoNofPGlacv03mBXg2ZnTcEdQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l085bFXEz7mX3NVXad/6xlstnHoyrhvXCeX72ETTvk=;
 b=kO+q/oKJGY5ol/1KJ2IucyTSAoGmlV8IYf/8gqxcLRR+/Bz+MBMtgkfRkRH9z8pXFIfk79gmN+Soccs08+/d/S9FEW6nSCqDqbGL/Q3jFegjWfEaDL2DmyDssDDsvFAKpegx+cQCA1wBJIFLXtDw2Ao1WkIcrkggZ3/P2MQ2CTgQdbkbHN4K0zF4BxlhUyjUZ5s4ZAYxTEV+fwz8RAeJt/O2MFpcxm3zrE2eNVfAdpLJ4qheq0Cmyk52rnpSR1SvtEoW5x6/5RCf2yItrqyXfOXs4tishOa235iwUIc60XE9w8eu1TaY1VBrzV/rEa1r9s6anJGZim7pUsX6l2lbZQ==
Received: from BN9PR03CA0624.namprd03.prod.outlook.com (2603:10b6:408:106::29)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.28; Mon, 28 Oct
 2024 20:19:35 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::e5) by BN9PR03CA0624.outlook.office365.com
 (2603:10b6:408:106::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22 via Frontend
 Transport; Mon, 28 Oct 2024 20:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 28 Oct 2024 20:19:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Oct
 2024 13:18:52 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 28 Oct 2024 13:18:52 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 28 Oct 2024 13:18:51 -0700
Date: Mon, 28 Oct 2024 13:18:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com"
	<aik@amd.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 01/13] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and
 IOMMU_VDEVICE_ALLOC ioctl
Message-ID: <Zx/xqlvEBZgmV84d@Asurada-Nvidia>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com>
 <BN9PR11MB52765EED4209A26DC60F138D8C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765EED4209A26DC60F138D8C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bbfe33-d547-4cce-169a-08dcf78dd735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KhXB0R8AK7W4H6z6PegubjgPt8g7VaOZKIn0s8yUHlckmOV52WaZh9DgwoNV?=
 =?us-ascii?Q?hcKMLg8oodLA32VxrFYQ5JELZ3clRnltbqEjsYdI93+yScwXzO8s/wH8HfZf?=
 =?us-ascii?Q?kf14CRmzOwkvrBh0IUTZ6qXls13b6wvKjPyBMAaeKUlaRL2yYEJgMGNnHkVk?=
 =?us-ascii?Q?DmfBF+bizQIwRmKr8zk38LATSIorImbdGdid2KsXFCwZhaOUXMmzhraf594Q?=
 =?us-ascii?Q?72twZz5Tp2hWC+YuM50a9tcivoixLf2yxoA65X6oyzn5ZQ0L9RjG2P7SqW2K?=
 =?us-ascii?Q?AGoZKJpWoJYgNd+ZfxSWrKwfZq0PU0LvROla4iEONy+RxsDfOBywTEpw/bO1?=
 =?us-ascii?Q?vD41toYQcnudkGvpmzp5eRh6oWMUw9y7yKnh3eXu/v2DJNO+S504lOTp1ca3?=
 =?us-ascii?Q?CuTT53AyWcu8jQGa8GktlBtWMxnEO4UuQOWrt99RjE1KZPtR3XxV9E30awnH?=
 =?us-ascii?Q?DX9yFnXccfLhtN4WTCuLGU5Jh02vt3cwgzKhvN4dcMG+6rtDpil+cagRWS1B?=
 =?us-ascii?Q?C77EsT7fQ/KTCG/hvJKJT/UtaIy8K1vLsrlKoDD/Timk/QvOIyE/3/U9TACq?=
 =?us-ascii?Q?xg7Gv3rGJF1YJgRKJ9HysMpdxAZovCxEOXGyXVcEL8PMgvX0m2ukbbO5Sa8x?=
 =?us-ascii?Q?3NRgHu0LY1fy5lfnBQeY8Hs11LF6pVQYxt20R6yCn5L5KycsPd0xEp9WLq/5?=
 =?us-ascii?Q?bwRDlvjMWOPCbBhz1RQQZNMLRrNFFHS33aptQqCIDRqG2wqz0ROaU93HftCW?=
 =?us-ascii?Q?qL4R0LxSkSRQIsZ0m/RM7AY8TFhwdnNIMy7/wvOV0B1QJuCKjXxFMqxgvv9K?=
 =?us-ascii?Q?tlOM3RFi/9EnbZ1K6W3+0q4Dc70qdPKgYumo36cLAyoevsKr3O8PQ/cMlAJi?=
 =?us-ascii?Q?CBWUxGb0FgAHbqaQl1JbwTTSIW1Zmm26KkXMlbgdb8yGeN46ATVWbHlWIVqq?=
 =?us-ascii?Q?hKg7V1rSeSE4C4EyGGeZAv31pyEGP8YV2yh+e8vKoGRIIoxGmUneGz4E3hnL?=
 =?us-ascii?Q?o4hbm+75FCzSryLRWDjYb7OrJduUjTyjdBxpkpKv/oYfkmxN7Hb9Dg7l86jn?=
 =?us-ascii?Q?qObRL5cr0mA1ItbrGlbaLy95YcZ/QhDHx7DruvG+uUd1r1JPpl+dZmuwihwq?=
 =?us-ascii?Q?fOrCbBda9szp6ie9zz60+EVU3whchLb1+fRVgYbGRi3b1iS7MEIAQ5zfF2bf?=
 =?us-ascii?Q?RFhF8iIFtLp4ziEFg75gWMQ7bvKwE41ap0BawaWcFG2O88A/dbOGRowMkblD?=
 =?us-ascii?Q?W7wju/YdQ0FiIXkPVZA2/QEOQ3B99iMguHdUieU/efEB8NpyI8dVMNSj9TeK?=
 =?us-ascii?Q?6KPpayEsETi4QkjXsy88nelUfVRMwXrVT3AFx/utIcYT+Di3nB+hrtJAi8wq?=
 =?us-ascii?Q?sUclx4mZLGRf8mq9dic6Hv//sGt9nkzIp2c19IwqqG/GjDwtNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 20:19:35.0766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bbfe33-d547-4cce-169a-08dcf78dd735
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268

On Mon, Oct 28, 2024 at 03:11:32AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, October 26, 2024 7:51 AM
> >
> > +
> > +/**
> > + * struct iommu_vdevice_alloc - ioctl(IOMMU_VDEVICE_ALLOC)
> > + * @size: sizeof(struct iommu_vdevice_alloc)
> > + * @viommu_id: vIOMMU ID to associate with the virtual device
> > + * @dev_id: The pyhsical device to allocate a virtual instance on the
> > vIOMMU
> 
> s/pyhsical/physical/, or just say 'iommufd device"

Ack for "physical", aligning with other @dev_id lines.

> > +
> > +int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
> > +{
> > +     struct iommu_vdevice_alloc *cmd = ucmd->cmd;
> > +     struct iommufd_vdevice *vdev, *curr;
> > +     struct iommufd_viommu *viommu;
> > +     struct iommufd_device *idev;
> > +     u64 virt_id = cmd->virt_id;
> > +     int rc = 0;
> > +
> > +     if (virt_id > ULONG_MAX)
> > +             return -EINVAL;
> > +
> > +     viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> > +     if (IS_ERR(viommu))
> > +             return PTR_ERR(viommu);
> > +
> > +     idev = iommufd_get_device(ucmd, cmd->dev_id);
> > +     if (IS_ERR(idev)) {
> > +             rc = PTR_ERR(idev);
> > +             goto out_put_viommu;
> > +     }
> > +
> > +     mutex_lock(&idev->igroup->lock);
> > +     if (idev->vdev) {
> > +             rc = -EEXIST;
> > +             goto out_unlock_igroup;
> > +     }
> > +
> > +     vdev = iommufd_object_alloc(ucmd->ictx, vdev,
> > IOMMUFD_OBJ_VDEVICE);
> > +     if (IS_ERR(vdev)) {
> > +             rc = PTR_ERR(vdev);
> > +             goto out_unlock_igroup;
> > +     }
> > +
> 
> also need to check that the device and the viommu are associated
> to a same physical iommu.

Ack. Will add this prior to mutex_lock(&idev->igroup->lock);

+       if (viommu->iommu_dev != __iommu_get_iommu_dev(idev->dev)) {
+               rc = -EINVAL;
+               goto out_put_idev;
+       }

Thanks!
Nicolin

