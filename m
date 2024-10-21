Return-Path: <linux-kselftest+bounces-20259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF92F9A6849
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 14:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6A2280E3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 12:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE701F4731;
	Mon, 21 Oct 2024 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gt2mDGgC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183F1EABBE;
	Mon, 21 Oct 2024 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513375; cv=fail; b=qJiP0K0loQ6TbomiT/19RuBZ9zz90xk6N9C8q3OCzWnQ8Kw7wAuV4as92pvRSqisyU0llVNWZ32fJjEd/efDDO+cHryVYOsBRtr2xlh29e/dOwwHsjXI8BKZyBU/dUT6EYciaS/wF9zpZYTp416f7feY9canMwZpxL/48CTEZKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513375; c=relaxed/simple;
	bh=F2V+khOdgKJGr4WZaHlISccNnZNGsekzOobJvA7hMNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=to/dn7sPMvhRhlZ151CCq1wPaZ6k32IdzE2NCuwmhU7/lQUYe6R/Fv8/zJGJpADj3v4WAsDKKNXFPmUqzrPg0AhSqlIQfF7I/5bM4VU58K3gcjXEmTkjTrBjp+AR/WcALFIslkP6N91cHy9utpp6mYv11+kXmKiF1pL3meCboCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gt2mDGgC; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXx2cEV8ODdRbl+5TtD2PJMs5rdrFRWkPIL6p6QPLRU5SYEx1a8bhB8vnHArN/w4g20eHqtzaOq9+2LN5fmyTYxT4Q6HvqXqe4BTsnirhpAPVRIwFBHKQkzyZmsXS417p2eTw8ihAiIzQ3D7MY+ipUYzgwBNEJUUikUgOQ5Y7ydEhsWSFDe+fObA/KAVSDmoJpBptV9PFm6FC8zZAnAc/ei3uLS2bOfULuNPBNh7CHMfiGp4/IbB862Ho1xLzEJZCSzQq5oQ0nvmE1G/OBTLdjwz2mPlgk31G6HtP6oLh4183VTdvu0HorG5JzSr6WEejddNBPpvXG8XYagShWtmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Izf/jZgKC9jhRHOkeNiDr93EA6Q+tLubdCXHNoo88DY=;
 b=nDSFaMapykNMF5uPm5EiVoADRWzYk1IJafwh95YUGALRooMfRp/f3vk/NqS/DtF+VPPwuGNL8GxDLoZxfcDOUBeAiTL1xmrpk6lkSeTF2EEWh1ocRbUlzMzPhpYT+277aD/VA2IhjJ5eN1bIBEzFJZLHzx2cUPsX/BPqzPvletwUYNShK0Jjfwy31q5qyGXW89abHwsEFyB8PZPeBy3xFEH314Ch1AZVyVSHvJBdwd8N8B0xre+yxfNKF1qwekJURVmX4sDlnBXd46UaCl8MV7Dpl2hrL/gz5+OL5GJrp4elc8iJMhKqMblI2yDo9t7TZVuC0LoN3PjGXEa7rhQQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Izf/jZgKC9jhRHOkeNiDr93EA6Q+tLubdCXHNoo88DY=;
 b=Gt2mDGgCNz3YJOU6z8s5uPAX050cRFO+bFBQCaXgX9kxuJg62x/ohh5dg2APmEXMrK6jfNWTuCfLbnks4u7U5bJZAPYXE76U+YWDRjCNnzpjri7fsFhley0cwfgBhNXUn5gChVtZTKlPkdy9ESbP18F9hh01ePvXx5VK/pMDqL9NDetlW7feTrAl2RWMY22dico6DmPV6Y8+M+2KCswfoM5kR6pCUy/48cp7mKbU9qDAqvUyK04QTnV4LwYTvkp7L9uuhUXfh+x6iv4hV9y+TXzesXqjVJuDz8RD/WbSNxvKuoN2vRTLtCLOMYfPwgWlWvNAELZDLOyHbUVeDC4syA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 12:22:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 12:22:49 +0000
Date: Mon, 21 Oct 2024 09:22:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 03/16] iommufd/viommu: Add IOMMU_VDEVICE_ALLOC ioctl
Message-ID: <20241021122248.GQ3559746@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
 <df942c216c0e5d1740ba5add73375becf0713dfd.1728491532.git.nicolinc@nvidia.com>
 <20241017185230.GS3559746@nvidia.com>
 <ZxRgBq3wPy6xHUbb@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxRgBq3wPy6xHUbb@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:408:f4::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: d65a140e-e130-48fa-65ab-08dcf1cb13e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1IMuoa/Cr0cQqjO78qCogAAqG1pnV4MiNnPHEmiPAiJnT8OQXF/9ojEyprqK?=
 =?us-ascii?Q?sAMzWY8kTkUH8S+sn/8zBEbwjjIL6RXQGW8JlNMOtNvCtQJjN4PffY79gGYr?=
 =?us-ascii?Q?4TpXb1lud3vMVhlyF0CfMt164+t/fr5B+HfuvdNz9wH8CFzMaqqi1Tv4j0C0?=
 =?us-ascii?Q?kceuZuxKOdD9sX3bedKg7eDwDkrTHlhebSQKhUqSBZp0QxLm53GGGm8psyh1?=
 =?us-ascii?Q?0yUoCcD2giUo0+ZPDteyVXBD4LUHwxk7Ec8CdQAjaOTpex9/qA1sWliQBT0/?=
 =?us-ascii?Q?6cSlR1LLD76Pm13ah3a4+PL3T7XF62aUT0j3HHoQ6cdUosnHD61BGnPxjo5f?=
 =?us-ascii?Q?O9IRfyG5AJl/95vK1cPMETjpvi04EEQzWJftaislt+qBw+Nv28jOsYiMA8AH?=
 =?us-ascii?Q?IyN7H3+g2/m8BqPTHqEVkEmDspLK9so/n21eOm1gEawwmV0n8FpEV737Kn6e?=
 =?us-ascii?Q?h9g9/35v1Agc/qdUVVPoGil2gT4qlxUWu3KASYv0hNVbYLe2EY21FWO1U37V?=
 =?us-ascii?Q?IvGH77NxbPZI/R0qX8tFndSeGYjzVhrbcCS8DeEvuY1b5kTOx6UkJSNXiirp?=
 =?us-ascii?Q?CtHr6pttCwI1d8HqwgOCDDwPdH8s7cYg3my0yG5YvzoHnjIVKZmxsEYTTj31?=
 =?us-ascii?Q?OrH67QFygboU+6HP0gRZnX60bKjMHMq2a1fuysXLCfG6/suZ6rwXkP/OJ64X?=
 =?us-ascii?Q?cPn8Euk1oWW5/bAxV3zR2EDmVadSvDcNHx3zQaUIXL29hLM7+/L99SWIjhhf?=
 =?us-ascii?Q?eSmuNFqlfaoiXRJ1WYLhDuHygJ0eYFNIQeIAUVsDCfjApHB8Dr7yhNpvY2pd?=
 =?us-ascii?Q?yfmk7zUDBb8nPgjeKEH2dXXpg7riuSji9PWNJXuHKw4gDAzd5pfWX+8sPUlm?=
 =?us-ascii?Q?Np6qdra28il3RBb9pYPN/bc8JwGnnCjoU2YifJf5V7GRoW211hvouCvVXyT3?=
 =?us-ascii?Q?PH2sYNpZlbXwFsNfGZhxAcSMHwd52mCR3Xl7W9G3ECcawrEtGfBFcyNIz6VY?=
 =?us-ascii?Q?TR0vrzkkWBtdqiJlwRNPzeoSeE4lgwbtMQJS8BiVk/ZHeDCOpRU2ywqrcKir?=
 =?us-ascii?Q?PrvernQ6IcJqwr+sBrLv9MyiO+6mwu/9oF/z2AvhBb1UI3h7+oXATdu91T0h?=
 =?us-ascii?Q?G8MSEYxr4OHDpOjWeg1HB/FD5dkPWkBD6aogHi/gg570wnNyKvTTptShzAwQ?=
 =?us-ascii?Q?puWawm8tJ3cRE6ofdtaZZC80p2giUUA0//zXwNQkBXd+2AfWUscs+6B7//sV?=
 =?us-ascii?Q?w0LlimJZ9hyZTze5k5/PWcIyQVlAM+zC+8V1WmOINMRiKkSZywhve6WveBFb?=
 =?us-ascii?Q?V89CNfF4hJ/yDvZ8dPyM4adN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Biw1nCxvGwhI1jy7Dk8ZQct4i8EFF/hfaBmJaQzfzaY8rnWHWoDHeptoED2p?=
 =?us-ascii?Q?/ZtL1LpfWOhPH9vZqZfkzyAjWjO9qSaZllIPPUddGBAJwPcL4Vf8PUfWwkU1?=
 =?us-ascii?Q?jOQpl1KJqQVaEto5AOtZPf0+6AcjdfGw305WzMhbYEuZh7qFsW88Bq2TrIah?=
 =?us-ascii?Q?W2xPyR1obwJMJ7uPT2ser1SDvKgfEyG7NYxBIR1AubaSRU7BF2GnMq06GXZU?=
 =?us-ascii?Q?FepUNgUV5RntmO+6CVVAhK3TVzJmZRaFdq18KWxjQhHITr9b1cDFjhOrd2WI?=
 =?us-ascii?Q?4dcE8gTN+HjJLYIVEuEfwHWqRd5/Oq/kTTbC2ksgrEC9jPcipCFzBf7PMQ5g?=
 =?us-ascii?Q?eaEVX7ne1SNHNNAEgE/KuEzLufBSUkNiO8gfBWMYgZRUBANB/NfVsvGtKDzk?=
 =?us-ascii?Q?VhmcxRLoVGGkSBv1yEsEXlKD1CERWsBjUoHxKQoZI8eqCD31I9ND/q45pt0N?=
 =?us-ascii?Q?2yP9kfT4Ou8Im7CRFUPisJ5qScTNSCcEpoUnPBDCXTJFs3GuWAhzsbQFmPuc?=
 =?us-ascii?Q?UFGhURewoPDGrT00uqDOMEEaU6XrAoWVOoy2hQBnIF6/F57lWlmXPVo+Uy85?=
 =?us-ascii?Q?W9vYvlMBbONeQXwdP2k4uSS6Hp/4i6t1n4tDjeba5ju1jkDPk6NOcQwXre+K?=
 =?us-ascii?Q?cNqm/s0AiL5LwumCXd09KIxaLFjUYQIBXZuKfH2oLvx+ir5R/zFaUCVWFjBt?=
 =?us-ascii?Q?d8KzMAkS4notehFxh4yOIfQq9rJzRW6v+Aw615UMiIOhvKnYx5PXAaptb18+?=
 =?us-ascii?Q?nx/7bMljPo+HuymfTiUN/SKhuWDLP+dd9JnC49cT/GczPHhM4A1SlBUZvR+e?=
 =?us-ascii?Q?U9DJjYJV+gnN5SqowxczcvMLgCTjqIvJoTNeH5RFwCrUB0H1yL4eJq6pQnoB?=
 =?us-ascii?Q?twMzz6bj5J1tBOol2loQ88EacKw34Bv91aI7KH/kAToHSGI/SB4sAwlSOXyy?=
 =?us-ascii?Q?aoVUlbvHUbDGjtYCYDKGivD36bx0lmyEe4W4XWFvmcaXxXHHOM2UhuxwigMY?=
 =?us-ascii?Q?mZa/xmGsiyh7InPKqwmvaTUScT3wzVFJBOgM0z/oBhHyo5NTtFmMYtNwMy4i?=
 =?us-ascii?Q?GWoaX2YR2UtOx8N7OwnWHS7UTy2mjMpWKRZJGO1ud39NClrJ7C+8/8cGtKCl?=
 =?us-ascii?Q?fCU0Kghakm7vgiNrtsxMmKDr2eOMs2zWEnVjnDUtfmZT5ZC/sdE+XUmi280q?=
 =?us-ascii?Q?KrDoEFaN8SdFdC4xNNma5Uu5m/1zDNpsN3ubP12QRYhP2kCfTWMOD63Lxl9/?=
 =?us-ascii?Q?uBipz0WczyBpGCjZw3NP8e7Y9fy24VkMjsla4nxR8ePOdk0kUKBw+5A/woGY?=
 =?us-ascii?Q?JkBm1BeeUZBKJhhxKfCuTka9ECo275egXuB1KgZoL5wjoSA8oWBVtRymzC64?=
 =?us-ascii?Q?NoKq4v7K4EfgLVHt0dkqTzcmw2fxVS4yW44HPiJRrNUu+DZ2HweyEJ/bXqQo?=
 =?us-ascii?Q?HHJ9vqz9yxpiUpD9dzZCbrZu/RXgF2f3RjZy4m+QrFdBmvP0u41tWbzm2Uhp?=
 =?us-ascii?Q?Oh2PhdrgNaxIn9zs1hzWCNKGaoz8Ej6Vdrw4xiUfSefh2dHdTqYCWkiGNH9c?=
 =?us-ascii?Q?BR03Mg+GN47DgCSE3Wc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65a140e-e130-48fa-65ab-08dcf1cb13e4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 12:22:49.5944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70MpcpljNV3H+PEFSwKiiWqxusr5VQiQHC3sg25aXOEEj38y82B4aMwRwRXgTLnA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7901

On Sat, Oct 19, 2024 at 06:42:30PM -0700, Nicolin Chen wrote:
> > But be mindful of this abort, it doesn't want to be inside the lock if
> > it also gets the lock.. fail_nth should be updated to cover these new
> > ioctls to look for tricky things like that
> 
> I added an abort() beside destroy():
> 
> +void iommufd_vdevice_abort(struct iommufd_object *obj)
> +{
> +       struct iommufd_vdevice *old, *vdev =
> +               container_of(obj, struct iommufd_vdevice, obj);
> +       struct iommufd_viommu *viommu = vdev->viommu;
> +       struct iommufd_device *idev = vdev->idev;
> +
> +       lockdep_assert_not_held(&idev->igroup->lock);

???

> +
> +       if (viommu->ops && viommu->ops->vdevice_free)
> +               viommu->ops->vdevice_free(vdev);
> +
> +       old = xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
> +       if (old)
> +               WARN_ON(old != vdev);
> +
> +       refcount_dec(&viommu->obj.users);
> +       refcount_dec(&idev->obj.users);
> +       idev->vdev = NULL;
> +}
> +
> +void iommufd_vdevice_destroy(struct iommufd_object *obj)
> +{
> +       struct iommufd_vdevice *vdev =
> +               container_of(obj, struct iommufd_vdevice, obj);
> +
> +       mutex_lock(&vdev->idev->igroup->lock);
> +       iommufd_vdevice_abort(obj);

When we get it here??

Jason

