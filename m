Return-Path: <linux-kselftest+bounces-15467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29B7953E47
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 02:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAA01F216A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 00:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE0264D;
	Fri, 16 Aug 2024 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cyR1j3/X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E4372;
	Fri, 16 Aug 2024 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767734; cv=fail; b=Nz5QZhC+EIi2lSxw+BIta0Yfwyku4J8UVAqsHlVWsOJ2dUzZoik/uuCmMn0nebOXSAc+8pSGEtqNEo2re15inyGn9fg7rySppk1z6/UUTRmEPCGt0mU2BypgZJWHNXpYDoRFaKw0V42DWf8fRMdng5RY94YATsqONlq64eHxmeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767734; c=relaxed/simple;
	bh=nUvLjxo9OK902xUamC997MAKMVF/b/EwmrbpLXRF8Ts=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttte2q76Zz3uBo8ssvQz577QsztSmEK72xbyghT+tbQsFycvLh1M5mqwWvjTIHVx3/pZX42MI3P/g4bsGusnVa4ht+hcGOKO8v4+/TgG3RMSKXd/kIhCm5DV0hWjA4E7FKyKH4xbtEYtaoK3DiaO3Qwnbb7EVlxTIHLzR5Uu6qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cyR1j3/X; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVkkamcgv1y/TtIyWjnyIIexgpm9/Wr97ZfzSCLEWdaB6bDdu6D0dDdsQDi2dfz2DFyo2IB5YFeVvlmv/z/qcfRqBX8PRBzauiK0cBCiW9WQPNBF3bbZjlnUC8VGo/R+DdiE7O6yAvU3r/SfypdMAoe4OcYNFRr8jYoHbwZpzZE5r/z4E6OLVe/ZrDovzs0XVH5t9XI/20YguBEK22pRzNf3lTLdGB0b4OQB1ukZnNnFJ1bFirRoh7E7paOJ4FSAZABFAhsoHhSP2Q8FtlLeRs8u+SXbDMmsxxPAH85u1XKpfwf6XoTSEOABnPl6yVp/6nzm0Fk7LtASmtuLm9RYyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5ZVmrt9ySHI6FJ14UHUfS31COSW23/iL5CCT0FqG8Y=;
 b=r74eB8MsXDXu9LDasZ+mEYDQkOQAWG7H2cKFIhHk6d3T3N8nlzcDsi/rHAgfJY+sgztsoS+XSpgITokpMGjeIkn1ezGbqudbsWXqlAgEb+a1XY9UxjSpQQHXzT2CiKOInDGJl9kd8XM+I4vgG3HXeBWWF0RaOoHrVZBenr59SZiIuZ6gTSsfiKzpsywHszeQzS1NecixVCjV31Uc2l2+Oia0pAz1cUBSty5EOcfyC8oQ7QnvOcLTNsNP/GL3Zflj1ujaEuhY7iB7yG26XsOQpmk/fRFnQ18jjNYzUwvLQSCG5DSHTiuezjII7h2luMtz5WTx8gi4Y0iCvOIEtBxYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5ZVmrt9ySHI6FJ14UHUfS31COSW23/iL5CCT0FqG8Y=;
 b=cyR1j3/XtZZGsmkloLeNjfnB1p+cDmLZAEhL3J8PN/LjJs+TB7RctS0Q5ps64IlwR0epIgvYbumLq5O/aDWE9fSdOFNqg2nCQ7TqodKhy74WbNMlfp/Ip9kuIz7bejvBJcOfwHpP64R2ERxv3dOoaSGubgsTnjxUDh8PUtudXGFMg8GDIEM+0b0qdlmedq1JRwhtsdRpv9pLdbfzfRGY33S/facoAcY3aAFDJu6pRO02UBwcRsx7BHRTstk/EU3WVgR+MSTc1mvMfi/YUU2CqoLo8uuvui+GBpUCiAaaxUCmpss8DiPrtVGYZGsOWPXFejRyyjuAmIFAeKsfGpgRHw==
Received: from CYXPR02CA0071.namprd02.prod.outlook.com (2603:10b6:930:cd::26)
 by MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Fri, 16 Aug
 2024 00:22:09 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:cd:cafe::91) by CYXPR02CA0071.outlook.office365.com
 (2603:10b6:930:cd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 00:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 00:22:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:22:00 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:22:00 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 17:21:59 -0700
Date: Thu, 15 Aug 2024 17:21:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 05/16] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <Zr6bpbc0HZ8xLVZw@Asurada-Nvidia>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <e35a24d4337b985aabbcfe7857cac2186d4f61e9.1723061378.git.nicolinc@nvidia.com>
 <20240815190848.GP2032816@nvidia.com>
 <Zr5bENKAYJTvwEBJ@Asurada-Nvidia>
 <20240815234119.GX2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240815234119.GX2032816@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|MW4PR12MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 710a29a9-1099-4477-ddad-08dcbd8977b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JWukDhvTHKMYewg/U6wykSRjOMtA9wQDeOdomrAwq4D6gwQDijLdYhB7wa1r?=
 =?us-ascii?Q?1TujzlLRj37VZLXcOx6WSpbCbYrp0cR0a2D8yH9pmOZ0Y6SOQ+TGSd8P02AD?=
 =?us-ascii?Q?MkSoXXqylRRUJvMRnTX9LPEPt2r1IgpPUoBvgC9NMwKF4RTfFuTmpxjJaOtD?=
 =?us-ascii?Q?eJ05mEWXh9sF19vC73xbZOdcvIiPQ1BdAgsCQ2pjecBuuyKosjtZjDUimIea?=
 =?us-ascii?Q?fkcgyHjcYaoPHRJ3pKXeTr86pdYy/Y4nZN2qUTWcy0I21iM3eCZt58jVWyBX?=
 =?us-ascii?Q?o4oBaqED9Qsrm5HQ7CBIbKa51gYDVEazbgnvzz7fVSBnjwf2Yq9Zgg9pFbOs?=
 =?us-ascii?Q?uWCbZx5VX3ZpaFzjFCtiL23yG6HcAd3Rzbf27prqtCU+zDt5bLZRg+HP/nhG?=
 =?us-ascii?Q?Oxz7e+mdj4ukko4r4wxer0EtiKaVfV5epFNWFpAwukQQvIagXx/5bfQcKCM+?=
 =?us-ascii?Q?/HBAgVg9qoxOl0Ih5BaNJp0WhrL8g+iq7G5EVe9z+wEwoQ6wBBpKPhphsWID?=
 =?us-ascii?Q?GveSbpGVKlMVlVtQyoh5iSDBClEBfbPRGQ2FIw4C3lsGkIkaP8rSvl9lij0m?=
 =?us-ascii?Q?iw+NtBRBfQcKSke4X3ID/7eFtrHlqxTB9JFnx4emaA2aBEDEibE39LpcTtcj?=
 =?us-ascii?Q?AF3Eoe+J1TSPkBm/J2tlfnt1rxeNNjb9ML4MPEFXQgwTSE54F6IXcr+S69y2?=
 =?us-ascii?Q?0kLBy7ony2N8q4gm+xjLxd5fAohocBuhqEVEqSqUByRsvNj/duHXmRjUS7pT?=
 =?us-ascii?Q?+b5uA2Ym/uFZyPBGqSZ99BpU/Sl3BezVpRnCnZUk90fbrKoJ3yEnJtxUumtb?=
 =?us-ascii?Q?VupHc5RiqGa4zCeb19dWJ1LFyMyGIRG0sb9EoJOIQaFeEtKkjADFp8ubIbqR?=
 =?us-ascii?Q?80rv4AKXBxJ7CkrAY/C55mjxbZn2E1H7hPJ3MwtowHuGHy8t7zk4yjjn4bQp?=
 =?us-ascii?Q?yk3sArFvi2uqIVWERLGjTWCPMyHmN2SImbCJqG9YW5DytgqNK7vgvQshps69?=
 =?us-ascii?Q?zVVQ7r8dg4Hlk9MHWrtw56cPm6B0qy5+U/IYNTvegyLcayi2qNkkSRnwcDDo?=
 =?us-ascii?Q?AtD33y0+AfPupyEteMmlWQOvsjNqcvnv03czQZtU+UK/H9vzMCYHmwoRYzgt?=
 =?us-ascii?Q?l+oIPdJK3s6h/0st88qf0PoaXqXhlZrpYwnoVAfOPZcPktnWARJ+FkrYN2EY?=
 =?us-ascii?Q?NPV7hJt80Aj0nu8I5zDCtUN6QPPw/+SkCTEsmgYyldDd/x38YYbH7ZCLcyad?=
 =?us-ascii?Q?mwF1tk7Upy/PO8wwu8xLXNlykz0SiWw5uJMj4p/jN+zS1X7zjaewW22RitUI?=
 =?us-ascii?Q?dyGVqPJrmGOPhYodu0JkX6C4SwSYmWkwU5NVxoqQEsVSuNR/7ogTmZNjrI/U?=
 =?us-ascii?Q?sNOGSW25f5BKLbjUVueH446JTP1+ZKMNWhIOnVk0J3ZViWS7GdZTQBAX+zUV?=
 =?us-ascii?Q?lkFEN+9uJrctCGPOO7tDKQI+S5L0PPUR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 00:22:09.5381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 710a29a9-1099-4477-ddad-08dcbd8977b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016

On Thu, Aug 15, 2024 at 08:41:19PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2024 at 12:46:24PM -0700, Nicolin Chen wrote:
> > On Thu, Aug 15, 2024 at 04:08:48PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 07, 2024 at 01:10:46PM -0700, Nicolin Chen wrote:
> > > 
> > > > +int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd)
> > > > +{
> > > > +	struct iommu_viommu_set_vdev_id *cmd = ucmd->cmd;
> > > > +	struct iommufd_hwpt_nested *hwpt_nested;
> > > > +	struct iommufd_vdev_id *vdev_id, *curr;
> > > > +	struct iommufd_hw_pagetable *hwpt;
> > > > +	struct iommufd_viommu *viommu;
> > > > +	struct iommufd_device *idev;
> > > > +	int rc = 0;
> > > > +
> > > > +	if (cmd->vdev_id > ULONG_MAX)
> > > > +		return -EINVAL;
> > > > +
> > > > +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> > > > +	if (IS_ERR(idev))
> > > > +		return PTR_ERR(idev);
> > > > +	hwpt = idev->igroup->hwpt;
> > > > +
> > > > +	if (hwpt == NULL || hwpt->obj.type != IOMMUFD_OBJ_HWPT_NESTED) {
> > > > +		rc = -EINVAL;
> > > > +		goto out_put_idev;
> > > > +	}
> > > > +	hwpt_nested = container_of(hwpt, struct iommufd_hwpt_nested, common);
> > > 
> > > This doesn't seem like a necessary check, the attached hwpt can change
> > > after this is established, so this can't be an invariant we enforce.
> > > 
> > > If you want to do 1:1 then somehow directly check if the idev is
> > > already linked to a viommu.
> > 
> > But idev can't link to a viommu without a proxy hwpt_nested?
> 
> Why not? The idev becomes linked to the viommu when the dev id is set

> Unless we are also going to enforce the idev is always attached to a
> nested then I don't think we need to check it here.
> 
> Things will definately not entirely work as expected if the vdev is
> directly attached to the s2 or a blocking, but it won't harm anything.

My view is that, the moment there is a VIOMMU object, that must
be a nested IOMMU case, so there must be a nested hwpt. Blocking
domain would be a hwpt_nested too (vSTE=Abort) as we previously
concluded.

Then, in a nested case, it feels odd that an idev is attached to
an S2 hwpt..

That being said, I think we can still do that with validations:
 If idev->hwpt is nested, compare input viommu v.s idev->hwpt->viommu.
 If idev->hwpt is paging, compare input viommu->hwpt v.s idev->hwpt.

> > the stage-2 only configuration should have an identity hwpt_nested
> > right?
> 
> Yes, that is the right way to use the API
> 
> > > It has to work by having the iommu driver directly access the xarray
> > > and the entirely under the spinlock the iommu driver can translate the
> > > vSID to the pSID and the let go and push the invalidation to HW. No
> > > races.
> > 
> > Maybe the iommufd_viommu_invalidate ioctl handler should hold that
> > xa_lock around the viommu->ops->cache_invalidate, and then add lock
> > assert in iommufd_viommu_find_device?
> 
> That doesn't seem like a great idea, you can't do copy_from_user under
> a spinlock.
> 
> > > xa_lock(&viommu->vdev_ids);
> > > vdev_id = xa_load(&viommu->vdev_ids, cmd->vdev_id);
> > > if (!vdev_id || vdev_id->vdev_id != cmd->vdev_id (????) || vdev_id->dev != idev->dev)
> > >     err
> > > __xa_erase(&viommu->vdev_ids, cmd->vdev_id);
> > > xa_unlock((&viommu->vdev_ids);
> > 
> > I've changed to xa_cmpxchg() in my local tree. Would it be simpler?
> 
> No, that is still not right, you can't take the vdev_id outside the
> lock at all. Even for cmpxchng because the vdev_id could have been
> freed and reallocated by another thread.
> 
> You must combine the validation of the vdev_id with the erase under a
> single critical region.

Yea, we need a wider locker to keep the vdev_id list and its data
pointers unchanged. I'll try the rw semaphore that you suggested
in the other mail.

This complicates things overall especially with the VIRQ that has
involved interrupt context polling vdev_id, where semaphore/mutex
won't fit very well. Perhaps it would need a driver-level bottom
half routine to call those helpers with locks. I am glad that you
noticed the problem early.

Thanks!
Nicolin

