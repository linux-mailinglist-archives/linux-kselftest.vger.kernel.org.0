Return-Path: <linux-kselftest+bounces-20439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C459AC021
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 09:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10AF31C211CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 07:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566BC153801;
	Wed, 23 Oct 2024 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G6krWYzK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0451547EF;
	Wed, 23 Oct 2024 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668161; cv=fail; b=fq0JfFqnGf+h/DY0HpiANJj9+26KgBMiIRNtF1/PwhHHOgk3UHolb4Q7pLY6Q6GoCQhk9S0Ta9LqawqTkeNKcSDqiWdGclwExBgoIeFuOP1JB7B/MTNdIvCHi5Ys5DtV/LAMY/YX3X+8ucMC/J9fRTbricK7BakBmKUY3R5S7xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668161; c=relaxed/simple;
	bh=/dCFw/GM2+5xkiw+yyKb+YZG2Zif2asbaTZ5wbjt5FQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCcPkqtx9sRLiggfLxqbbGdZfEDxvUFnU9UdMN+rmlRjMNAaou5WSGuHyB1J/JwGv17sTF6BhQS93fTKfRsX9Qw9mKdgPo2WT+Zuz6Nmievcqg0uIZd4lOnWttGiMJU8adeB/bIL4zifGQVaYo4MSBQa5T2cxOsReep+0ZFRZCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G6krWYzK; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxynW0yd9uKlnA2G7347GgKGze66LusGwFQneColv+bb58LtfnybiNTadl0zIQiG7mnhBTLtBTJrplNnXJy9QfUeWBViyPnTf1nkQSLsxE3kjASteaKYi05wdMWAK8lW+ym8yz9AuBRZ2W+cq9an0NYF/7hEXwwb99Ojh+6APFacDj6UfL4g12p0xHa4T7jMDCsUV0KvFRIQv0HQEgkQf1Vno05ZbB/LeGLOzgS1DY0D8mB7tZLhZfaeWpY8ZQEpdHtncnYY8d9nOZ0UNWzfY8vFt8q5EgCXqr1Bnv+3xsibxiWsjbgHP6gg3QOMGt4fp82De7oMz03kBJTW7zh/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cc6h/YzzQqgj6jEa/pB+5U8cxgBjKfQcfixAXu5zEpQ=;
 b=W43Gt9xy1DH3KQL03o/OyAYtt6GXGA/46WKyLmOIzFeUeADU1zkA9Wph42mCerj2gSvNsmGT0+1KxSFuwdA1geEY5mTvYwj6edGAdpyWLtCvFANmse+2IzActpVQPWHFBYMz+UqGibW0bEeIUlrVIopCo1vR+9KlG/wuGSM0Z4z7dqwiuFP6vo+eSmpFowfm7ChACyzjzD8AHo9IQ2/a9DsUFeMkBm25D5pWKUiS8EAoXhXcHCoegb62ySSpSv6rNND2IQVmuqE+Zakz0kRZDQQyMk3SPcxGeDXoOcOcqfysF/xd4N0S58svDjil//ambIL4DXPSBiZS/lWhyJcvTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cc6h/YzzQqgj6jEa/pB+5U8cxgBjKfQcfixAXu5zEpQ=;
 b=G6krWYzK1Fe1f7j1ZCi3otqxPyICOLsBzt/H5/5IUiq8nhK+wy8hCY0jgd6GnfRKZLPkGkNqXcHzVHEak8eymNXL7USDIvX1DAWA8LyDsamylHa3xQqehO5uUeacz4NoKkC7Xc04eZAU/Pzu82s+SRq5fYP0E26VTeR8Jcp1Ms2MRZ8cKReTS3VnOEYH+Dgzqj0iDPPajfSuqA4f0y5URb/Mse7oef4HAgA6h8Zmd39Ug8QBpHNJJCae6zikVaZPo5HC/BmAxoqNooASMdzGFoxff3uHbVFBZXZPu84y9Nx7wrVdp/HxQ1bq/zJOoHtIo5YxLV3xBKzOqZEiwvvqGA==
Received: from CH2PR08CA0004.namprd08.prod.outlook.com (2603:10b6:610:5a::14)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 07:22:33 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::e7) by CH2PR08CA0004.outlook.office365.com
 (2603:10b6:610:5a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.30 via Frontend
 Transport; Wed, 23 Oct 2024 07:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 07:22:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Oct
 2024 00:22:18 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Oct
 2024 00:22:18 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 23 Oct 2024 00:22:17 -0700
Date: Wed, 23 Oct 2024 00:22:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 04/10] iommufd/viommu: Allow drivers to control
 vdev_id lifecycle
Message-ID: <ZxikJwzq8rLPgtmS@Asurada-Nvidia>
References: <cover.1724777091.git.nicolinc@nvidia.com>
 <3ab48d4978318938911d91833654b296947668ad.1724777091.git.nicolinc@nvidia.com>
 <20240905180119.GY1358970@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240905180119.GY1358970@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: a445fd23-dabe-4ef4-9d62-08dcf33375e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iy38ArqFaE8WWs88SZGglWrn89mY84Ebr8yT5dsHiUHWQ5SFPxZzdNgCvrhg?=
 =?us-ascii?Q?rUpmmy35uvRLS6uNCICVQRzZubWP2U1OEKwiSiKNIvgHn+ADS56/sP3kMkDS?=
 =?us-ascii?Q?GfKfbK124D3/Nwt4RsBFpmQMzygRdZLKn6NF80dxF1ibrVDHjvDOmWlCXei+?=
 =?us-ascii?Q?1p70HglNJPYLCHDyBlyoYPNioIbvjG3XXus6tn0hIdeVR3rvoHoNTyH69XBn?=
 =?us-ascii?Q?ekNUHSrgh5FcSan7N3HzSbalG5tySc9be62uv3OTLGdVdRcF9Qwh3th5X0Tz?=
 =?us-ascii?Q?Ne2Yf2Bx1CS3ysqM6a0kQdqbB4Y0V6V60Fuh6+v94FOjaBHYsS+maop2N1Us?=
 =?us-ascii?Q?T6PrvcnSqAyKWEog9ykc4YNruMcY3HFvK5hSVY5ND8Oy+BKllshuOhFryxbg?=
 =?us-ascii?Q?KoqngCyvOxTeadTrE9nGbov3m8wq+M4gwfhVQePHT5WzAicjEX123W6bPnZr?=
 =?us-ascii?Q?tIK8npiAaj/KKXG3xGzW2Pox9yHDpvKS9s8CHjfL6k54OJZ6ipR36ad+mPbF?=
 =?us-ascii?Q?7NMDak3Hd1lMlb54mzXLb/WwV4kaQSJl6kTYR/EAJ+VsKhHlgmOt/JUB/7HR?=
 =?us-ascii?Q?/e0Sxie4/yOUrE2wkJLD0oQk1Y37OSHC6+5vmAVIOHcqiALQoel5bkbl6Btc?=
 =?us-ascii?Q?ntZYX2y/qWBDekM/VDA3uRnUejNJ0+2lP2uHspmvmdCx5cvuKb2xWtpUesvF?=
 =?us-ascii?Q?GH7x6HYpaE5nsIuMBfvY5Ixw4OcX3hollBF1lpWGo/7gZGh17txhqMqj5c4K?=
 =?us-ascii?Q?gN5M08sA0PHnHvUZ9XoRIsLVsFUdty9v9lF8cIKLPv42LM33rszHfLmLz6uN?=
 =?us-ascii?Q?7rU9zOc/RitQfHgNHzo/mG/pJ8c4S+tGocgQnRXv0rn0kURc5CENtTlxi+2G?=
 =?us-ascii?Q?9QFl99nbYO2Fk4OzHtmI9ikDNOzx2BXgh5Vc6Wb68oxzvP3frOW0Va5Opkv0?=
 =?us-ascii?Q?4LTIbTdeI11A6BNiFoy9D4OnzMLbloK4nIw2LHauo3atVJDES/JSqb2NcTYm?=
 =?us-ascii?Q?dK7ObKGMrMQ4aq247tEPnVr1ybt/Tj5lDTmCMJISaDeyOaIxgCoEw5vFZKTe?=
 =?us-ascii?Q?3OXq/vdONqagV0iGdPUO8HJj7jconC932ELfyhaTRphjnt/rZWWDVorcjc+Q?=
 =?us-ascii?Q?AgrpUasFjMkeWetNE1b0IMZpq6QFQDpO7r1PDQWFr/oosNJ15vAYbp/EDiDy?=
 =?us-ascii?Q?8i6TvqInIuY2CuJj+ZbanfIgvoupMzFjnwcdqC06oRzOHTFi00aCo/D0n5dZ?=
 =?us-ascii?Q?P3RH/l2Mt9DKTZBAUFRPh5NQ1J4ZIhYjiNUgWumYreZztZj0IKJRwrD8NKZW?=
 =?us-ascii?Q?1YbhY6e0s79MzI5CxhKPUORt3ZIhXq0BzSLNoDNviGshhDLBxNvDWZ6KTyEe?=
 =?us-ascii?Q?XMLBHhIL0yy3BrjDNlNiXUKytEobD4viKUehHW8gQCWTDQGHTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 07:22:32.4872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a445fd23-dabe-4ef4-9d62-08dcf33375e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249

On Thu, Sep 05, 2024 at 03:01:19PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 27, 2024 at 10:02:06AM -0700, Nicolin Chen wrote:
> > The iommufd core provides a lookup helper for an IOMMU driver to find a
> > device pointer by device's per-viommu virtual ID. Yet a driver may need
> > an inverted lookup to find a device's per-viommu virtual ID by a device
> > pointer, e.g. when reporting virtual IRQs/events back to the user space.
> > In this case, it'd be unsafe for iommufd core to do an inverted lookup,
> > as the driver can't track the lifecycle of a viommu object or a vdev_id
> > object.
> > 
> > Meanwhile, some HW can even support virtual device ID lookup by its HW-
> > accelerated virtualization feature. E.g. Tegra241 CMDQV HW supports to
> > execute vanilla guest-issued SMMU commands containing virtual Stream ID
> > but requires software to configure a link between virtual Stream ID and
> > physical Stream ID via HW registers. So not only the iommufd core needs
> > a vdev_id lookup table, drivers will want one too.
> > 
> > Given the two justifications above, it's the best practice to provide a
> > a pair of set_vdev_id/unset_vdev_id ops in the viommu ops, so a driver
> > can implement them to control a vdev_id's lifecycle, and configure the
> > HW properly if required.
> 
> I think the lifecycle rules should be much simpler.
> 
> If a nested domain is attached to a STE/RID/device then the vIOMMU
> affiliated with that nested domain is pinned while the STE is in place
> 
> So the driver only need to provide locking around attach changing the
> STE's vIOMMU vs async operations translating from a STE to a
> vIOMMU. This can be a simple driver lock of some kind, ie a rwlock
> across the STE table.
> 
> Generally that is how all the async events should work, go from the
> STE to the VIOMMU to a iommufd callback to the iommufd event
> queue. iommufd will translate the struct device from the driver to an
> idev_id (or maybe even a vdevid) the same basic way the PRI code works

I am trying to draft something following this, and here is what
it would look like:

------------------------draft---------------------------
struct arm_smmu_master {
	....
+	struct rw_semaphore lock;
+	struct arm_vsmmu *vsmmu;
	....
};

->attach_dev() {
	down_write(&master->lock);
	if (domain->type == IOMMU_DOMAIN_NESTED)
		master->vsmmu = to_smmu_domain(domain)->vsmmu;
	else
		master->vsmmu = NULL;
	up_write(&master->lock);
}

isr() {
	down_read(&master->lock);
	if (master->vsmmu) {
		xa_lock(&master->vsmmu->core.vdevs);
		vdev = iommufd_viommu_dev_to_vdev(&master->vsmmu->core,
						  master->dev);
		if (vdev) {
			struct iommu_virq_arm_smmuv3 virq_data = evt;

			virq_data.evt[0] &= ~EVTQ_0_SID;
			virq_data.evt[0] |= FIELD_PREP(EVTQ_0_SID, vdev->id);
			return iommufd_viommu_report_irq(
					vdev->viommu,
					IOMMU_VIRQ_TYPE_ARM_SMMUV3, &virq_data,
					sizeof(virq_data));
		} else {
			rc = -ENOENT;
		}
		xa_unlock(&master->vsmmu->core.vdevs);
	}
	up_read(&master->lock);
}
--------------------------------------------------------

[Comparison]      | This v1                 | Draft
1. Adds to master | A lock and vdev ptr     | A lock and viommu ptr
2. Set/unset ptr  | In ->vdevice_alloc/free | In all ->attach_dev
3. Do dev_to_vdev | master->vdev->id        | attach_handle?

Both solutions needs a driver-level lock and an extra pointer in
the master structure. And both ISR routines require that driver-
level lock to avoid race against attach_dev v.s. vdev alloc/free.
Overall, taking step.3 into consideration, it seems that letting
master lock&hold the vdev pointer (i.e. this v1) is simpler?

As for the implementation of iommufd_viommu_dev_to_vdev(), I read
the attach_handle part in the PRI code, yet I don't see the lock
that protects the handle returned by iommu_attach_handle_get() in
iommu_report_device_fault/find_fault_handler().

And I see the kdoc of iommu_attach_handle_get() mentioning:
  "Callers are required to synchronize the call of
   iommu_attach_handle_get() with domain attachment
   and detachment. The attach handle can only be used
   during its life cycle."
But the caller iommu_report_device_fault() is an async event that
cannot guarantee the lifecycle. Would you please shed some light?

Thanks
Nicolin

