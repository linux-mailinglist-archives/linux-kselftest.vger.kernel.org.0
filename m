Return-Path: <linux-kselftest+bounces-15437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7289539B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 20:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CFE287EDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18073548E1;
	Thu, 15 Aug 2024 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RRtO1vCU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A393BBC1;
	Thu, 15 Aug 2024 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745485; cv=fail; b=GLu3SrT+fE1oqXsfiEtwNRsfD0aaa13BsRpHddTaFYMAS9VSlrpC/OLIo9f8Q8sDL1pKnR6OOjDz+yfvyEQxA70br4EmkE7zuXa+JcsPKQiCSBdzgoD9eoioy+PMTBTPESV8Gb4POiPEJ4R6hfxrl9WogxQfCA5UlcL3g3zSAec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745485; c=relaxed/simple;
	bh=QjVn8eeMReZN6akDCznebNwV8yfYDXpK+CzOhC5RSII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XKIyFc0Ewn4nib2p6++d2FRQpeGjOnEFocd1ggVBR29pxOetYWcb+tnbfYERAxyh6CjEtz6EWuheg7wG0xgRC+6jCbcC811atIttyxpg2cFsnc5s8d9Kjittz6Cs18cOgGVuKBM+sNjOqAcAw5WVqD25c+jGEitaT/mPNhAmSSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RRtO1vCU; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6OzDxWodDL5XAW+0WTUErRpGnNKldsgFLXEYDWLspmh7W0GwoZNda5OaAZ8s6HqNlTzcdoHxXQwSwaCr6Qo+kRVml2VmFfRVaQKZST6iQlEYcPBx7X7VAYKddUw97aW2lg9NZ3g8uGDIIFRKa/UBBHs6uvVzQZgdaWCXIVRe1I8HScOFgyrip13NxXudwgmMr1qPpmkRGORD3nx7dMP5uqSElxFvkNQVdXCc5OTqA2JEWw3QRuvxDWNnjMtPGdMfHUHbxdT2gSDLP60S6LWJTV9vo1FZVZ6fZERjZSWr9mauRQEWcCxEaEPGUyPdbh6lfQKVpGU3dfzMRPZImMylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IBQ2DU8zDuSFS8OF+o+iC6xVL8gc9VJglGq1l8Qlfk=;
 b=VwhlYk0revrhugeyK7MWyMramtVwK9Tv0xFeS8vwE23l4OhP6t6zhmsBeeyj2d9zt4nZMf4edelXBaGno6uefsgG3CTKt5nRjLC1q8i6V+KqyyGJasYe6xeUwXFeK5WDlI4VvMru530c/2GInYz8DbXXBm1vFGd1O1a6Zp/Ie2jcv4l2G8uXVDxyRN7IjE6RY1kGbxBK60QHrz2yqBvRq3mL4BmPW8gXmliq5ZgXEdQeqMHs8UX2wCNMKP014qwm4TstKIy229fGj/bQs3mTTgxeq6VJ1DiP6/P+u4FfsPDOZDQGLNnKN3mTCXhbrNkuBUzH3NT4aJH+8oYBb9sEKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IBQ2DU8zDuSFS8OF+o+iC6xVL8gc9VJglGq1l8Qlfk=;
 b=RRtO1vCUgPrFPDtjUi6LDlOcgRDCf/ZQE77psHaIHKIcSV9ozO+icmtzENDLA7Mpt/XuzuTG8orpJeV+iiShzMrp6MKlhfETPEBYi9YT5+SqvbUq1SnFOEk4L2NhuMgRT7OJYAcUIfocSoVFzuKAALJVLTe3HRrYJhOnxy92QMFg2enzva9TtbSvytWeGfd3lS00gCpLjS1E1lUU2l/202pV1A+tDav4Vj8DL2tqwQ3/A8haE0QGlwmFNvWRCDvWNhi3ylfiv1EV5jkw4xp9LpYH+hx0+PYSfYWIT6+dHwEcMeWWRpdKep+QgDEhoWn+uZYZmgPdmEqJPJj4ehgGMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 18:11:20 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 18:11:19 +0000
Date: Thu, 15 Aug 2024 15:11:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 01/16] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <20240815181117.GN2032816@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <536c5e908af3847649d1f4b7050af17d77d8b524.1723061378.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <536c5e908af3847649d1f4b7050af17d77d8b524.1723061378.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0142.namprd02.prod.outlook.com
 (2603:10b6:208:35::47) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4f0820-e41f-45ab-6edb-08dcbd55a9b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BKsKpkTRVHIvHblNEQYZ8Qhq01XVJeh4jDmldjNiN2ykSW5Ril2LLtpgLDdb?=
 =?us-ascii?Q?bs2FEejpatl97fpACsTUvBTQmfrQRi5ySXbu4Hmld6Ibx+AK2a9M80tLAkir?=
 =?us-ascii?Q?ycUdqPDUI7bua0tt/Q+HdavQbKxeElr3Nbf48Ky4/QXttYsy6yasWI8ZH9YA?=
 =?us-ascii?Q?JhJ6EZWS02Dz8HHhMrHdG+Ja1+pmLprhTx2Nsj5nF6bRq7VbTFcCYjlJ1Dih?=
 =?us-ascii?Q?nvGWdK8JZ68xIldt9/4VjfKM+VLKnbzmRAaaI7pNBsp7VVJpROEAVIZkC0ms?=
 =?us-ascii?Q?kR2wWZC1b3rr8MhxiKEmyEQHPJT2J/qyumvmphuwL0GEm/ivA2f2sB3KBi1I?=
 =?us-ascii?Q?SK008wdDjxhcJuiixA7Mv0YZUR6JDnvGrTaZvFZ5ph/8zdmFo/ou4y9g7+5N?=
 =?us-ascii?Q?6T8FwLG0PWaUIN3znXFFfuw5UGUWtYB74mJmGTur6rExqZeW5uhPr7uptnYB?=
 =?us-ascii?Q?+3XGhYSq4Xt+EBADanmDmAFFuOwU0DUrreIjibYQ7MKcV0Sj+vF48NM8i17N?=
 =?us-ascii?Q?gAuSuvBfPB/OYwpplakNe3ROz1j2ztRGIaI6d8+HRAZ3YnxwXDKRoJmizgTd?=
 =?us-ascii?Q?A15Uc30qmxe1cxh3CrkCaubH1dG7c4V/2hkp93hNJxB+xFqH6NepWSZRIp9S?=
 =?us-ascii?Q?hhoLcyzdwKWvLPDMnSQLeV+YuQT0m+BIFCmCNLfGQ3YrXTwMgln/3P0LvdEE?=
 =?us-ascii?Q?J2CdD/jHeM4Z+D3762i3Avor1Mb20nqr3H5hH17K8DyFj6qtqnNwQh77FlJ4?=
 =?us-ascii?Q?COOj9QK9FCyko8T9pqR4IMKcKIAOf97mf9xBa9K9DEe3GtsAF9JJN52FHcGp?=
 =?us-ascii?Q?QxRles2LIJ36Ke3glvUnf+3wuttXe5M0Z/5TK+7KGhNDQIm2evxYPII1Gqqr?=
 =?us-ascii?Q?XzL5WM2WZ0kULCPp/ZB5HSC8dQ6LF2LcNzDnJHIwSCI33oGaG8kYcVKu42wn?=
 =?us-ascii?Q?SwOGm3uKfsrW+lYrrQfwj6U9CDOHBeaVOVKbAY132FboFSwBVKu4XmvDIhN+?=
 =?us-ascii?Q?l8QdTebj3ayXTzic9KZjfYhmgORoXcq9Oam+Inn/Z6yG8a5uJQ5DwPEyAbDQ?=
 =?us-ascii?Q?NiS3ldqSIMSc3XyXvt18+zjz6L0ra1MthwhLDlCTJMQ9Y7DmKBQq4ffXiErP?=
 =?us-ascii?Q?CjX+S822q4i2VaTF/hzPcnL9C2acvqLIEcJAr/uj9HPbkBx9o9JYjfYq3ZuT?=
 =?us-ascii?Q?yEENdBKabnTptND3H9whL6SriHgN0pBIFxAerHg44Lz94Sax62bICkufMKo7?=
 =?us-ascii?Q?G0Svxi5UGE6weZ/FD9yUu+4sQFKvPPdrFd47Tj91l7vYMyvUkuAisJZCGDH1?=
 =?us-ascii?Q?LYOS+r89KbvKxtGeZiEU/8bxhur+JutJS/hX97q1F27baA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0R28/T3DO9hMtQhOGYOeTlKkT0TZqmaAMgLHGFujfmnpiap1QRo/Dvafno9B?=
 =?us-ascii?Q?1OiFzZVD52EFXTK8gIP0TaK5ufS6WPcIDAmYhbZn1atihB96dKBQylSNjzS6?=
 =?us-ascii?Q?7q4bN6XQ8+92JaTPUWRTAyE0+H32NzFT0m3M5E0IbJ+bFwsaVJPZ/DcYHbu0?=
 =?us-ascii?Q?6glss7OTcDTd8oMFulA+KeVC5NYxZtzsN/ZGzEPrPVjQRUWCCAb1sYdXsvoA?=
 =?us-ascii?Q?8ftNg2/HjlasMTUXpf/ua5vkBMAc3FIkC/BPLV+gVX4PBcIJYgJi5cdinunj?=
 =?us-ascii?Q?hm8QQ8UV2fEqrTJhCOkpuWuVMyvC0zSeljw1r9TBIYeDPV03xdyNSEDVYx4O?=
 =?us-ascii?Q?MebYgvdDoi1Ou/syn3vyVnKmeqcyNmuCeDWEh9flsP7+HXMkLLxgdYjRrdCm?=
 =?us-ascii?Q?iIpIiSvpH16uWNgcok3xmM554cvlHyxCqahBNDiUXb5yWgsSyZD2fiQSeJYn?=
 =?us-ascii?Q?W7of0ckPS9PGhqmb+xbYuXvZAVCWNdcdKO7WJQmVBk59HBW/ED92PU3SqpPP?=
 =?us-ascii?Q?ZfB8m8tO9qOcQc2leIJZs2dXHLuNiicm8Y3RMhlsKcuBt/c+BuffO5Qsg658?=
 =?us-ascii?Q?ZValuXqCHeddQYqE8mnOQl8QRglbKldAsPDdTZgaEGJbxM4clRn1to4+DcFa?=
 =?us-ascii?Q?GF3noOA8XsdA6atOVnRlUWW5rdkDG5WZVq0DHBsy08+ICc+cT277vYLb8eIF?=
 =?us-ascii?Q?kkGRAaEOi5bnSluvBHamEEGOSsnMLUhBye9hZIVTBECA0mDfrvIzuQAoWBth?=
 =?us-ascii?Q?6Qkxm9S06XzTAUjDHrQaagvcAi7j++QguGAGkx/2+NrhsPxh09H352ftlH7j?=
 =?us-ascii?Q?zvQtQ1VeVV5D/wXZUdQQpQw2y8nhgl+2rNOz5yidt924ZxJMOnogR0KrrJue?=
 =?us-ascii?Q?loI0XgWPzIyuwbzhQr3e+8FOtGGZ1jmv6vKisP7mCj5QiOaJg0+GUHlV9Zi9?=
 =?us-ascii?Q?huiF8tBzcZ0AyJFBZiXR7u+jsDDTzCReE7+YZsHWvzfHmJJQTWDedLEhRktP?=
 =?us-ascii?Q?bIl+mlntThAR6MIpqI8ZRebMacCMrdzYlcfbJVyfHJc200qRWs0l0twmUOF1?=
 =?us-ascii?Q?gWWKOEleuiQFfebPkQl9/OUzLSBE2RGFTqWXCGjQqfcLrvILecMeeXOlY/i7?=
 =?us-ascii?Q?0Z2tzgBi9rtRsnMf7xWv4X64KWXWzarQ/s32Sem8Wto7I4VdzyTkHA0iN8ht?=
 =?us-ascii?Q?lhRV9tfRKfg8PDcLRq7Ak3Twh0ZQaaJfz/89t3G0Ae5EgiCVkFpsc66l0rLx?=
 =?us-ascii?Q?1OyNZ+FXFfiVsBrmE5iAwA8uMm0BVHg1f3Q8SPQcwld2Yd0og0MsvtnT2/b1?=
 =?us-ascii?Q?oLE+gKcKeMVKJo3JiezCkEcm9RaSR2p/+ggBIHu+eHFUBY3RM9ey9IueXQJ+?=
 =?us-ascii?Q?DZUvvAZNJTlBWH//V50tOc+xp7gIWKSE7B+crpHJjx/Illmgg78qUp6IhxWe?=
 =?us-ascii?Q?Ou/KOMcuRQDGnBiMEoZq82rgYGbawAC8UPLKWu5hj6w/AKtUAo85lyUq/uVN?=
 =?us-ascii?Q?baATWcJ5fcbUKZ+6Fqi/w13IvwQw4WuB0u3U7yfzRVJxJ6d0ggMB3rpSrskR?=
 =?us-ascii?Q?DCdywcgADKQjlm55O6c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4f0820-e41f-45ab-6edb-08dcbd55a9b3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 18:11:19.7957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBZ4aoO26d5YhayqqurhlIXBQf8IrVg36H+LcSERazBMYAt5yhgdzOO8GiiuRzwS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603

On Wed, Aug 07, 2024 at 01:10:42PM -0700, Nicolin Chen wrote:

> +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_viommu_alloc *cmd = ucmd->cmd;
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_device *idev;
> +	int rc;
> +
> +	if (cmd->flags)
> +		return -EOPNOTSUPP;
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +
> +	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> +	if (IS_ERR(hwpt_paging)) {
> +		rc = PTR_ERR(hwpt_paging);
> +		goto out_put_idev;
> +	}
> +
> +	if (!hwpt_paging->nest_parent) {
> +		rc = -EINVAL;
> +		goto out_put_hwpt;
> +	}
> +
> +	if (cmd->type != IOMMU_VIOMMU_TYPE_DEFAULT) {
> +		rc = -EOPNOTSUPP;
> +		goto out_put_hwpt;
> +	}
> +
> +	viommu = iommufd_object_alloc(ucmd->ictx, viommu, IOMMUFD_OBJ_VIOMMU);
> +	if (IS_ERR(viommu)) {
> +		rc = PTR_ERR(viommu);
> +		goto out_put_hwpt;
> +	}
> +
> +	viommu->type = cmd->type;
> +	viommu->ictx = ucmd->ictx;
> +	viommu->hwpt = hwpt_paging;
> +	viommu->iommu_dev = idev->dev->iommu->iommu_dev;

Pedantically this is troublesome because we don't have any lifetime
control on this pointer. 

iommu unplug is fairly troubled on real HW, but the selftest does do
it.

At least for this series the value isn't used so lets remove it.

I don't have an easy solution in mind though later as surely we will
need this when we start to create more iommu bound objects. I'm pretty
sure syzkaller would eventually find such a UAF using the iommufd
selftest framework.

Jason

