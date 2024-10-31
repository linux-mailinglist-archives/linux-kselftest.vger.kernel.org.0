Return-Path: <linux-kselftest+bounces-21235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59D29B80AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 17:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3D71C21545
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 16:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0391BD027;
	Thu, 31 Oct 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZHO+K/gF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B51A0B00;
	Thu, 31 Oct 2024 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393837; cv=fail; b=arEaRKE5bzvHpsMjl4byr2s07HRfEk8M8AhX43DHrZK8s0xmNc1Dd0CMknuv5TLh98FazWxHMO2EKeIn2mdpWvcNnKH/sumTYgl4sZzm46ftcAWrjVdAnT/Xog+ygrS6TFzLmMlVG7g9baOTszBRaPkbdIx/O21X7BLtlg6qMmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393837; c=relaxed/simple;
	bh=unFttWI4DEk0MM+JhcLuob1Po71CZCchKoIQKVT5TEE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krhKf41y0gjmHXg6lNU4LmwJF6j7QJ94lc30AsLsYf2hFF8jjeKXrF6AGBU/5fyRze92yHbijvO9nuRb0SWTg8O3WTZMVoc86dpaFsOJgT2HmOzW9yvljDLropX1KZZ0jEnJkeFwMhbY5wEnVX2AZpLTQRhn9raYh05aojjtleg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZHO+K/gF; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lA5cg8kXioGjWMCg9G58PHL/Ds4ecvYoMb6n91d41cTc+46EDSaQcMDDFXim79St0vVg5r4YS74O+MhI9bNq2K6Cpon0+KKsS2iM+/6JBGob7CvN4xzJX6LPM8N1uxpIqj/z99b6lxTUsW2xax/f15tyuxdgng6zc9vCt4A/DOFqvKRQc85Olc+KTSJl150yxGIvDmhpT5Rj4BBoClPwxqkO5ESeJKxbSXyJvsqqFRvRTIdB1FOWDc7DbArhDYEN5TLLEDDervCBVKxIb2dy1CXbYgpOLtHdPYzs6CU6iQNrBQGel293pIR0/X/cs9imyC6SGuacGfJwaIXDT0O40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/zgTRqnfyTABe5pkrdp7qkrFYTmkGlLayG1OKAsCE0=;
 b=lIbrIzzMB5zOyd2g99hIQk2BTBuXbM6Ws+x4ZgVHLSg5cX58xMM95jFSIwlni18K+yNATfq82i9tO3cKWmCPNVXAK1ZEVyQma5DzrkaQ2DeKt3Keq3Fdb5xKwRC8Ykdsu8LIQChKQNELMWt7wpxVcwoWV10TneW+5AzSAdpuR8FH03A9GLX1QpbpYMcYcKZGg1aIcxqRjPofSw6jdbxx8AXFuS/9s9tDnj7d07Y/Rqe3xKFLEMNn9xL5+r7ETeTuew+BWe3CzcqpHW5gPR43dVgIYa/nE5fqbR3KMonjdsV6OF+yAcbeEG8n0+J2vypwm9tgNIYFLN2omw8lGwFowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/zgTRqnfyTABe5pkrdp7qkrFYTmkGlLayG1OKAsCE0=;
 b=ZHO+K/gFpkSpTGvee2SmbR7xrPM2RWgJHc8sboaq9YRBRE8bWkxTUWGQiOwJcj0dMQXJ/to/jPB5z6yV4w1ErJgBNmCHOwqjjYbX/qZWxFxr4fdfmT2LF3ndlvuVYqG/dsCb0bXM/yZhnzNMzN9c1PhTHJHB80cBs4IjurxRGLqsN+YfcWaRta47MUIk8ksXStz4A1MIqChWnToISsNP9aPfIi8211VSBZ9iMo9RH9xovZGIYJ0XXHHjegG/Ax1Cz0rjtTa3wd41TLd43dI01sPPTICKJ00Ybl0SPCT25zN9nGuAxZqySJa58cIKUuIUrXNEWQBGNdrv+IvYqXR+vQ==
Received: from BN8PR12CA0015.namprd12.prod.outlook.com (2603:10b6:408:60::28)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 16:57:12 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:60:cafe::36) by BN8PR12CA0015.outlook.office365.com
 (2603:10b6:408:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 16:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 16:57:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 09:56:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 09:56:40 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 31 Oct 2024 09:56:39 -0700
Date: Thu, 31 Oct 2024 09:56:37 -0700
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
Subject: Re: [PATCH v6 01/10] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and
 IOMMU_VDEVICE_ALLOC ioctl
Message-ID: <ZyO2xfe95Y1TCaqG@Asurada-Nvidia>
References: <cover.1730313494.git.nicolinc@nvidia.com>
 <19e20e54d41a0c1ab7403264e1016c4b19293135.1730313494.git.nicolinc@nvidia.com>
 <20241031132941.GL10193@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241031132941.GL10193@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a99ad6-3a95-4d00-5b64-08dcf9cd107d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?63HmJa73cB+iWtgsrzXE/RcU3QtILWF6KvYqnIBIkON4cdUGZXiv+KKK+kax?=
 =?us-ascii?Q?0WguyfRoQtjUDsNNXDiGc4LsP4I46UmXEOujE6LzLHu2gCs5rv9GZS5AY19k?=
 =?us-ascii?Q?EbGNLtxqI/zQhRbP5FkqmbumaDxJvAvrQzVeGzUpcJV2tgR8kUoFv0YSC/pE?=
 =?us-ascii?Q?LfMJJnf7qcipkR0WJ1ANL2lnr4Nh+qxRcZ8InDNG867tiJRSh4BNHJvNHY9J?=
 =?us-ascii?Q?M6vNvNIk9rhByadQrnu4nNGonnhORJIS1IqHtA3hDGHYygdDv9rRBmJfSdEF?=
 =?us-ascii?Q?fZjI8s5mP13Ns/uyxJpV/3RzoQauzgmc2LvW48H88H6UC3hLwxTgsujJ0dyp?=
 =?us-ascii?Q?/gmUOnc4Sz/u3ymyNBGERZ1YG2cd501frF9H7Pl8b/uLVQovSo4Kgv/eiuxe?=
 =?us-ascii?Q?G5D7FnQvqiYTlS0Lp/XHCP7Gdu5sv8e2pewjFIsfYOTNiC4V/jiXqJrVsJW3?=
 =?us-ascii?Q?QozvkhUOUilqVszHYdFTjrf2y42AxtIbGtGJg2PBO2F9S62QJ52HQuaWSgct?=
 =?us-ascii?Q?TkfMuLCMEzTYC5CsAlam5xgcjoIs9I4N+GjzL7gA3xG8GTzgl6Xwb4cpyOut?=
 =?us-ascii?Q?3fTFWeftdYOB4BwMfirvXdvj3E3xCncalJCr5cLgFwWXNhlBBYdrOfzz0sI2?=
 =?us-ascii?Q?ECQeWqCKOB/hZug9aCDRIwQghaEiRLqNz4qLE2uqVqMbVj+AbqEzF+edK1JW?=
 =?us-ascii?Q?q4CuFWgFmBHxOf9ACnSD9qj5Ubee76lKJHCSSjBI/hFjzoolwE8M1Su5McIs?=
 =?us-ascii?Q?wRbABORcDQfbpV5r2lN7cBAaNx12fqXJb5ZAQhUwUCv+TrRSAIjGKht7MoXJ?=
 =?us-ascii?Q?p/rxxMAj+Jv+LjPxBB5rvp7Pu3OStiuKc+0noAzwO5qesWIqCrXprlQb5eU+?=
 =?us-ascii?Q?w5yNpnwj295V6Vm7ouAoPkgCNuT7dKFCuaXhJiqA7bEqOhnivRqeeOLeTk1j?=
 =?us-ascii?Q?6GmT9L0ofu7OFHRPlw7H8miaC5YcwRCeLktUejfdU9K12mm1ifCBTlSgYMxx?=
 =?us-ascii?Q?htOOyRYpiq8FfzruaQYuFoI1lgY3HAfTY3X9xK0YegKmb5eT+vIS+5gHl0fh?=
 =?us-ascii?Q?0bEDCnpIBl8gdmULzzRsQ4Ohr4+zZibKPxiAaXEAaNsklhliH1jIOWxiNbfG?=
 =?us-ascii?Q?0b20yOdGiUcQlrRkCePp7vj91r5SAFlyN2jezb9usmckBAFK1v+45FJmBFEx?=
 =?us-ascii?Q?IPx6AK+KU1jQyRIFmILEdsJcmlLWp/LTJ+xceLhNYw4qU0wLplNML1UJIaqr?=
 =?us-ascii?Q?Hwdgk3sjoZ74ImImrwDKdbDzZQ1YZTMlqtub40UNpoSi1uBZlxIIEqhb0Tw7?=
 =?us-ascii?Q?0/7GLbTFdBMubiehiZUFxZ/bVLjIwGZ2xXbA2MarmZgE88O6GVn6C5auiv8C?=
 =?us-ascii?Q?R6wuA285Vr9chBWls6i/T3MCjoHaIyrf6q/+HHL9GcY0RhaC8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:57:11.7999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a99ad6-3a95-4d00-5b64-08dcf9cd107d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836

On Thu, Oct 31, 2024 at 10:29:41AM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 30, 2024 at 02:35:27PM -0700, Nicolin Chen wrote:
> > +void iommufd_vdevice_destroy(struct iommufd_object *obj)
> > +{
> > +	struct iommufd_vdevice *vdev =
> > +		container_of(obj, struct iommufd_vdevice, obj);
> > +	struct iommufd_viommu *viommu = vdev->viommu;
> > +
> > +	/* xa_cmpxchg is okay to fail if alloc returned -EEXIST previously */
> > +	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
> 
> There are crazy races that would cause this not to work. Another
> thread could have successfully destroyed whatever caused EEXIST and
> the successfully registered this same vdev to the same id. Then this
> will wrongly erase the other threads entry.
>
> It would be better to skip the erase directly if the EEXIST unwind is
> being taken.

Hmm, is the "another thread" an alloc() or a destroy()? It doesn't
seem to me that there could be another destroy() on the same object
since this current destroy() is the abort to an unfinalized object.
And it doesn't seem that another alloc() will get the same vdev ptr
since every vdev allocation in the alloc() will be different?

That being said, I think we could play safer with the followings:
-------------------------------------------------------------------
@@ -88,7 +88,6 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
                container_of(obj, struct iommufd_vdevice, obj);
        struct iommufd_viommu *viommu = vdev->viommu;

-       /* xa_cmpxchg is okay to fail if alloc returned -EEXIST previously */
        xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
        refcount_dec(&viommu->obj.users);
        put_device(vdev->dev);
@@ -128,18 +127,19 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
                goto out_put_idev;
        }

+       curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
+       if (curr) {
+               iommufd_object_abort(ucmd->ictx, &vdev->obj);
+               rc = xa_err(curr) ?: -EEXIST;
+               goto out_put_idev;
+       }
+
        vdev->id = virt_id;
        vdev->dev = idev->dev;
        get_device(idev->dev);
        vdev->viommu = viommu;
        refcount_inc(&viommu->obj.users);

-       curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
-       if (curr) {
-               rc = xa_err(curr) ?: -EEXIST;
-               goto out_abort;
-       }
-
        cmd->out_vdevice_id = vdev->obj.id;
        rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
        if (rc)
-------------------------------------------------------------------

Thanks
Nicolin

