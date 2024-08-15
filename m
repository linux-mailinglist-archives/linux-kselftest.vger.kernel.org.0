Return-Path: <linux-kselftest+bounces-15445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97779953B0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 21:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46E71C21969
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 19:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997887E107;
	Thu, 15 Aug 2024 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k4/tGpHV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE18762EF;
	Thu, 15 Aug 2024 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751199; cv=fail; b=AAQs9qpnJGWvaCIHVp8yY50QIiUO53fxbZzdZvyz7FG8fy/BbvyyIo5ilsIta9F4DtQU85ku9dWED+O7U7RSQK+bib1huoPSpKffP3oRW/8dw7wz0FVLK1oQ0E3s0Ny8Vf8rAloEdghHkEGBn36LRZEX6XS/m36LETU7kbUgQBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751199; c=relaxed/simple;
	bh=B25L6mU5oC5F2u0y2FpmgUu9Eaba3GjaJkTyo+f5VAM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtKWxaIAbaeaQcrJSGFLBce1J+vcRxjUhjc7mRzRmFIeuV3UBaqBmP98PQjTFZ4J9zJUsPwV/D9GFzeUPPU7awV2ecfj6Jmonzc7ggfqy03ZKRLtvIEcWDOLqQu1hrF0FrJY5Ac215k/j/4pmy/by87SHi81XpFvf4lvbHGVolQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k4/tGpHV; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzBbwGKkM1Pat1Co/uilDZ/p0pBMUsl8+CQNbwwQSvOyogRxjuRFgfiyJPXSgqohHnGP0zznRpRXqA7u6BmCvFQF0Iu9RI8BDeTKtLYFoDDbfQAMgOu2tHIeqWcl1TIZxSItlnGep/XBmcgF9T2wrF5+O47jD1paH31qAO0A7QZn6yE8HnNxakN51EMVrb/3/advGibUpxKJVCIhDOkkqkN8cE9ekUoOgRK2aA4H5iRlLgYYxxp8PonBzXqoAlxcKaPhBPBDYK0Fv8rPkXKklibkPYB7JBomjVFNfJrc9S3f6dEZZBrTfrkJQVa+u6dBg03aD/F0tGJr3u35INPKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mJJTagV3E78d09mxEd9kJiYGT75xf3qZBlweux0Ank=;
 b=gSyZl3gGUcLLtrryvosdoPo0x0t3zi0n3G7myr2/UdBY8nNEP/MBKPGfyWCNZ2MpAwY4r8VLqibVzIHhKVDksLsy43WJfejFeJWrnwK7dhErDEpbWUpJVI/YrHV0p/MuW9dVaYU6eZwhdsoq9LTXBD2/FIFUNOUBJu7rRaDCT8HBWHUlhHM6eWXEvOcr38YJB6Od2YGMVIM266s6+7qJ3tsZEEWicuLKEX5u/6K5aFDyj23fA30fvmvZed/b6CSrbfFBDdGvi8Lu1Z/TsSLEWVu9kyipugGXPXmR1+8aiaxfy1/3aSexdGB6+jYeknahL/itRrzGecPZaAHr59Rm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mJJTagV3E78d09mxEd9kJiYGT75xf3qZBlweux0Ank=;
 b=k4/tGpHV34JFCqD5YAkQdDUm2HOVpqB2GR7e69p8owqzw7vqNFGQ6/e9QlBSGVJEOMN4WnX3DaO4g/g6yAZKzSjsmniOY+Fd7g3+rFaN78uasBQyskavwU52QnlxppB3+yo6+gfeqpBC+xEaxQdb1voU9zecx4m8dwz99rsMRCBZ1wVt+1w3fMpskG4TqBPfDH48Ea6tVU4wIDCZDYzEtZqaUWQPURq+2v8CwqcUnTCWBDekCR8Hy0O2lDKag4Gdh1DqQrCt9fCzroZ1f2S3AysHPOeGU3pX0OsoYIKko+QsltGWa71CQIe/qCtk5w31BZChMyCMJI+jFvESF+pPNA==
Received: from PH7P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::22)
 by SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 19:46:31 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::68) by PH7P220CA0005.outlook.office365.com
 (2603:10b6:510:326::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Thu, 15 Aug 2024 19:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 15 Aug 2024 19:46:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 12:46:26 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 15 Aug 2024 12:46:26 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 12:46:25 -0700
Date: Thu, 15 Aug 2024 12:46:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 05/16] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <Zr5bENKAYJTvwEBJ@Asurada-Nvidia>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <e35a24d4337b985aabbcfe7857cac2186d4f61e9.1723061378.git.nicolinc@nvidia.com>
 <20240815190848.GP2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240815190848.GP2032816@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6e6a33-68bb-4123-d13e-08dcbd62f648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z2tHHM3Yg2fSrCJOttB5XgnIPOBEyx7+LWNx1mAyrhNNTJw4cfa+OydZ5bsY?=
 =?us-ascii?Q?ZYy88T9KOkYHO/q18eUHZAMVaUf3h1/Lsv9POO75DDwExYM5RApZ6tGzmovk?=
 =?us-ascii?Q?aflbIvF3aR2JAfRTuH0Nr/n4IhB80Q8svveY5+lXJybM6MSY4En3BYE966At?=
 =?us-ascii?Q?s3emDp6C81aIQLM0MwKfjxQE60870DWVqtwpX77dVLdp8ZXb4xgy+/lHQeLM?=
 =?us-ascii?Q?wga9zsIag4T6aV/fpXb0FNZfLqhlex3jBeZR6e59eT9Z1wJ/pN4pqDsCtGvR?=
 =?us-ascii?Q?wInQc+6EfSc6ewttkt8MW3xnxri2P+QBiQAhwRPxOh4t+eWCtGJCJi9qA923?=
 =?us-ascii?Q?UuXcxtVZ6M9G+McpNAiCgJpD1LqVkCtFwVhGxZ2Jp4tDFxV+7JFuGBe/eASw?=
 =?us-ascii?Q?KHW98SchpL23eWRQFKv/Kpx7rNgt2Hug3CPSARVNEHEUwrAjNLS5vRGIGWQK?=
 =?us-ascii?Q?e62hCEOS9xhogo54UgJb0b7tVjnk0/oy3Qkjo2Ma67oViFY9rFFOKqZxci9D?=
 =?us-ascii?Q?qgu5CtGlKj/zXBEApKwnLX6tfS2ajoudJxzdSwVMUOmzpsaMwRydyrVJoADF?=
 =?us-ascii?Q?mMv8QXu7HVs6Np3E069ciwx6oirL4nLE3e30WpK+19+426GJbq0iPM+i2wXU?=
 =?us-ascii?Q?bPSAUMCvELUTqGxupG+lpOQ7NS6Vd3NgFZsvpUSheiYGKu50wuJhQUiLxYx+?=
 =?us-ascii?Q?xCPguTTCPrciEdntOq3MtW/v30SvC/WQ/+XtG3LXdcN6ij3haeXZ1JflQrO8?=
 =?us-ascii?Q?pi7m6cItGdQPcN6+4dW9Up5qcTgmIgcKLVWq6VG9SP6tabYElckUJsBYfvsW?=
 =?us-ascii?Q?X6p4WOBQC0JwOp/jRpXsyNMIdCp0kBzFhxM4oW3zDSE8cd00i1MN5pxbcNSy?=
 =?us-ascii?Q?+mnvUUEYyA6aLUY6wQaO0Ux7U99IuwY12gSEEfRC+8oNNx9ypSgSRmOuO1QV?=
 =?us-ascii?Q?6sRj2VL626/rD7RSQcGVvZNSkitKOx1YxrPXa94wOpFI/Ns5sKaKXGBMHzz3?=
 =?us-ascii?Q?HCbSV5gmfZVPnNI84/BItuKOJ94tZ4iq8cFD2exRaDCXfLgcfc8Dp5/plML9?=
 =?us-ascii?Q?wv8P+F19ih5VKaR1MbaTcOtfAk6WaG5Wo7TdVUeFhpF9GAv0LHyqHddOAlmS?=
 =?us-ascii?Q?UlkyI8ByqwsHc7FpVkry8qP4JSO8r4rtF6r+npfYpWW2pQpfuVy0t/LanzXh?=
 =?us-ascii?Q?sj/V9SxJGdYiLcmjnQbxnLr7GFBnxDirW7OqpSczasIJuAak7g3tOmLkYFCB?=
 =?us-ascii?Q?s94uLNpTLVv1SXFRC6n2wmCaNwbQtChC5Ufk1sbyy9SVc0AeupRSgFYt+2FX?=
 =?us-ascii?Q?8ES9uC9ry7I5iS8dyJLuwrwJBtnyVe631j49NFclt7O6R85YnIC4E6d1SYzg?=
 =?us-ascii?Q?oJuyBImC4I8kms/AK0yMB0IiTM92nb4jApbM6YrvsVh1zxIQsZjqp9WU/NfN?=
 =?us-ascii?Q?LpTFPcsT+CL7hD2fBw9yneRocw7X6ltx?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 19:46:31.5241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6e6a33-68bb-4123-d13e-08dcbd62f648
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807

On Thu, Aug 15, 2024 at 04:08:48PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 07, 2024 at 01:10:46PM -0700, Nicolin Chen wrote:
> 
> > +int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_viommu_set_vdev_id *cmd = ucmd->cmd;
> > +	struct iommufd_hwpt_nested *hwpt_nested;
> > +	struct iommufd_vdev_id *vdev_id, *curr;
> > +	struct iommufd_hw_pagetable *hwpt;
> > +	struct iommufd_viommu *viommu;
> > +	struct iommufd_device *idev;
> > +	int rc = 0;
> > +
> > +	if (cmd->vdev_id > ULONG_MAX)
> > +		return -EINVAL;
> > +
> > +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> > +	if (IS_ERR(idev))
> > +		return PTR_ERR(idev);
> > +	hwpt = idev->igroup->hwpt;
> > +
> > +	if (hwpt == NULL || hwpt->obj.type != IOMMUFD_OBJ_HWPT_NESTED) {
> > +		rc = -EINVAL;
> > +		goto out_put_idev;
> > +	}
> > +	hwpt_nested = container_of(hwpt, struct iommufd_hwpt_nested, common);
> 
> This doesn't seem like a necessary check, the attached hwpt can change
> after this is established, so this can't be an invariant we enforce.
> 
> If you want to do 1:1 then somehow directly check if the idev is
> already linked to a viommu.

But idev can't link to a viommu without a proxy hwpt_nested? Even
the stage-2 only configuration should have an identity hwpt_nested
right?

> > +static struct device *
> > +iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id)
> > +{
> > +	struct iommufd_vdev_id *vdev_id;
> > +
> > +	xa_lock(&viommu->vdev_ids);
> > +	vdev_id = xa_load(&viommu->vdev_ids, (unsigned long)id);
> > +	xa_unlock(&viommu->vdev_ids);
> 
> This lock doesn't do anything
> 
> > +	if (!vdev_id || vdev_id->vdev_id != id)
> > +		return NULL;
> 
> And this is unlocked
> 
> > +	return vdev_id->dev;
> > +}
> 
> This isn't good.. We can't return the struct device pointer here as
> there is no locking for it anymore. We can't even know it is still
> probed to VFIO anymore.
> 
> It has to work by having the iommu driver directly access the xarray
> and the entirely under the spinlock the iommu driver can translate the
> vSID to the pSID and the let go and push the invalidation to HW. No
> races.

Maybe the iommufd_viommu_invalidate ioctl handler should hold that
xa_lock around the viommu->ops->cache_invalidate, and then add lock
assert in iommufd_viommu_find_device?

> > +int iommufd_viommu_unset_vdev_id(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_viommu_unset_vdev_id *cmd = ucmd->cmd;
> > +	struct iommufd_vdev_id *vdev_id;
> > +	struct iommufd_viommu *viommu;
> > +	struct iommufd_device *idev;
> > +	int rc = 0;
> > +
> > +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> > +	if (IS_ERR(idev))
> > +		return PTR_ERR(idev);
> > +
> > +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> > +	if (IS_ERR(viommu)) {
> > +		rc = PTR_ERR(viommu);
> > +		goto out_put_idev;
> > +	}
> > +
> > +	if (idev->dev != iommufd_viommu_find_device(viommu, cmd->vdev_id)) {
> 
> Swap the order around != to be more kernely

Ack.

> > +		rc = -EINVAL;
> > +		goto out_put_viommu;
> > +	}
> > +
> > +	vdev_id = xa_erase(&viommu->vdev_ids, cmd->vdev_id);
> 
> And this whole thing needs to be done under the xa_lock too.
> 
> xa_lock(&viommu->vdev_ids);
> vdev_id = xa_load(&viommu->vdev_ids, cmd->vdev_id);
> if (!vdev_id || vdev_id->vdev_id != cmd->vdev_id (????) || vdev_id->dev != idev->dev)
>     err
> __xa_erase(&viommu->vdev_ids, cmd->vdev_id);
> xa_unlock((&viommu->vdev_ids);

I've changed to xa_cmpxchg() in my local tree. Would it be simpler?

Thanks
Nicolin

