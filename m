Return-Path: <linux-kselftest+bounces-17286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3416096DF56
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58ACE1C21B42
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8758519F49E;
	Thu,  5 Sep 2024 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J5vA7fRx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0225819D897;
	Thu,  5 Sep 2024 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552867; cv=fail; b=SbIjssVoTYjK+gD9/HEGcMUniXmL+vM8g99CUrq1aWIq6r/MoobtbF850Z1Cmq9Q8+ApzWMuq+QEoJHlbuQRdd2VmHGHfQw1mnoxn7moIFWPtHo17DbN/TAXWQ5RcLxDFHu2VVswWtzgYj6I+/IHEHCw/sC4V6CvuWajZS/nyLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552867; c=relaxed/simple;
	bh=0Rx6uj2cq4ewYJOdij2+EAlmTTph2pzH+dm2noX57tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XIZJ7LMLG13aoI+yzoQ39eVItUcezehUsn8wCQQgqRuAsUkGaLXnUuUaHW3LWIJSFDAV4Wg17l/ZStfzv5Y45A26Tyw/UEe2s9RrEJyQ79565BhAakimWilHMgJtYJP8ETY2jWTDt5+cM82j+5kk8782iJNwLb+UL7U0xy0XNo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J5vA7fRx; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3kJrEQeZe6jmhNPx2aRRdJGDnPwIeb6VyIitaJ9GnMR8fqwopBKLhtyaj85Nnhm7OQWHwGTn2n68BB9gqsCI9PrlLnvrZF1KZEihe3MXp+TbJpPkU++dc23ruX7TIEzd9lFqKNcVA1dXrPL6ycT7/WkONA3CCbGiYOR+Tvv2HYnHOBuQCjYAq8DDyKjXxpzUd5i0lARQXmN+UHrhMOXBKTqnU+QkhbCbNqw654oKvl0RktR56Hs9cbfth642b74E09GEVoj2sJfjDCty2DhhFkCTCWZaY41PPvALLMttXhe5/1XqeFdoofNjt4Ixc3yAtzYUS/SLdT60xU1Jt9L7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4x47YiHQClrrgGAXyv5WVCSDg14kl0zTss90yMS3pr0=;
 b=WE30JTbdEn05+9zC37KkY138cGH3GWZdprVR53vpBGSjLlcziDgcNsVDiUO+5p8/r7E4qrN7df6puNX/ePkDw7fbTVD/6b4Qgy9HeQZUVHcdnX+oUM8zLPcXunf7crTKiBMLUk5mFG1zKF3ZqGWZeADh0MFzfYRhESEye/yf0dUrXbQTSGeKz7utewmFTK10zt0gIbQgF9HC3eGF146FnffxjImCQQYS1pvTfPtMxHbGVBXgS0hYX5BBGPeWVV2eO8OsXkf9anxXSC9qVlmlWD6rAw+15R7Vuqp1m0mCEH+BEmN9V4WsBZYHU3PxXYb1z8OFad88N86YM5WYUCMRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4x47YiHQClrrgGAXyv5WVCSDg14kl0zTss90yMS3pr0=;
 b=J5vA7fRxhd5/qYOZCDo5v2+sWLNZVnmMxcPgG07db/La7ZGTb9PTbfjlw67TGcWSTOxAv5JMdKpZ64+KBH1u1g0YqUw0tHkSwubb1mJEamIz8aAomeDUw13C8vOReGVvoM8Y2uI2Kv2eLW5vip16rrszbFkf6riAe9Bmq2vzKrYRQ1FLJwSCQ/ZyhLcJCCgNIMdz1g51EkJsNP1xLgqaQmqHPvyIxR/+07ciBGFy6oP7Vhdef22OH0HGw2t7gPqtClkEPZN8K530kToyogiwR8KoiTmTSp0jQ/VHx4M311pHQDZoBOpQTzCnxczLyLAUPvLqxhaQraGnEi9ox9b8sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 5 Sep
 2024 16:14:16 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 16:14:16 +0000
Date: Thu, 5 Sep 2024 13:14:15 -0300
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
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 10/19] iommufd/viommu: Add vdev_id helpers for IOMMU
 drivers
Message-ID: <20240905161415.GS1358970@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6ccdfb27c7aa5a5bb7e153165cf90114cae4687c.1724776335.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ccdfb27c7aa5a5bb7e153165cf90114cae4687c.1724776335.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0098.namprd02.prod.outlook.com
 (2603:10b6:208:51::39) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MN2PR12MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: caab5f9f-9e4a-40d0-2178-08dccdc5c9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gpUUhawHecjUESoyH+JEFUVaPD/cfOiTtaAsE3teK3AVHfLy/Wf65eXOMWa5?=
 =?us-ascii?Q?TMwZ+GuxCYLmoXb1o/8P6iK2ofhrZtTpO9KMDmAJXEyFJHbfS4YfuNirhFEU?=
 =?us-ascii?Q?oWeX+DBQr6V2UtHtX1TNJKEF/kT0/gh7aJkKXt2eFVnjkUSpoEKxRonepGw+?=
 =?us-ascii?Q?nfJV3gxZP2j2WGKeUfDhOA2V+WgPLmCIa9DHbMm4Lywgl9Bm5pqwxNrAoyXy?=
 =?us-ascii?Q?sEOEdeComNw3Uhw2KY9sNMAc7K91xGikM8SvhwJxU3j8STlIMDqY+d0AuG+r?=
 =?us-ascii?Q?IvkNwn8M339b4YJnwodoI/NaXpeShm62Q3rtz/x/+St/+n0ao6zejeQWXGwk?=
 =?us-ascii?Q?tGazoIoNYZu6Cbj5kGWHhqb2JXURqOhfhZa1QoM2y4Q/VWmibWesBEotA6gG?=
 =?us-ascii?Q?B5nu5tuZXKh7Lyz/NLzIKPL830/rQ+ygtyfo0r4pycZc1Zpa5aorLmGfPa+C?=
 =?us-ascii?Q?c1wvSto4blbKylbJy8Hte3Ly1JenS7+KRkxGCmy4jZrvl50VEUpVWnOO5Plb?=
 =?us-ascii?Q?lwmw93scaerQz2+LfcBvtDl9zr5qQupWInFn4UqrnppzmZG5em0fnWs5kawy?=
 =?us-ascii?Q?JBDFimizoeaT8zYyub7mtcQjk2YdjB4BR2dSbzWEH7wLHW4XXx62TTFAQ/ef?=
 =?us-ascii?Q?dbUl8T7yCXn02Hopo/2h6PIb5znsO3CSB6/MLK0GehAQdA5K6BYKq+4KNZx4?=
 =?us-ascii?Q?0c99WiKx1fODRV1VMUukIlnJsKr/b0xZMssa1P0mvUvw0ESuwv7XwSCfTodn?=
 =?us-ascii?Q?lzJ28TwwbydJ0qhJPWhqwTA7CqM1GsLRkbflB8tiyxUXcekVgG3j02zA46dV?=
 =?us-ascii?Q?wHqfnzGsDWpjnBoZiUZORyV+RfXsKAO76LX7nnvoUSaJQnWd3Vknx02TCbNv?=
 =?us-ascii?Q?Adwk5nwmqrH6LdnP5YiesuDfy7NZ3Pna+aT0CQlwWUVNKlUonPr/5U/YK5Hh?=
 =?us-ascii?Q?hT4/WMa4T6/SW2nG4EWV4ciBiib/yJLaxBlzESL5ervkytlET4xKHOR22cgo?=
 =?us-ascii?Q?sIMg/i2pOTN754A0UaBueI9yKYdIDmHXoZXqXRBUGec3gYFrlkEEW2DlmjYk?=
 =?us-ascii?Q?sqovgeB2/BJIQZ9oREtGCqmiB4AOqdG8t/hgMHNGxXS+1T1391MIbJ3pzLR8?=
 =?us-ascii?Q?owNvBfceiSYbeb8/2gR1k+ESktWAYdZFM/awCfIIyR38siPv0oNS9u6LvqfK?=
 =?us-ascii?Q?WuVenBrYpQAwBpEGyshJVoX6McNT6XfmD/j66eiEqXdWo9l8uv8YOqTo6zWp?=
 =?us-ascii?Q?O3luAsD/vsvKq6bg1cMvBRhLq638smqrk1a0PqDlXhwrOjSXEmtOiZG+6Bxp?=
 =?us-ascii?Q?uH47H7IUYh2YxUHsm9Z3+D34MySVFJ9d4xCXWK/98GME7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bImoeL3qYGIAT3RGYoZK9rcisxxv+TLen68vsQLx/vegGuu48mZYnPKzS/pq?=
 =?us-ascii?Q?GoSubp3nT322Lohk/DogJT2a9OKdlaGng8gKOsr/B5bL8OAsnQ3zJo+tTM7q?=
 =?us-ascii?Q?n6Wt9YmpGL3V/EUrqfHlTgHL3beUGWH7oNGpEsT9zKetqrtDODTA3C8KGr8X?=
 =?us-ascii?Q?vT46kgJg/5WvOblNOhMTOfzcTGCA0rTTYynJaYgbbjOwJMC6lrKgYRKYAavj?=
 =?us-ascii?Q?/sgz7F+IVmhxmBs7g70nE/GjMVO1d44WrPfp8Dyj3cybhe8xRZv345MrtV07?=
 =?us-ascii?Q?xFro/vvpnshsYduxv6AmwVq4dPXpCySs+bpVESqZK+CPAl+/x+veTEZZGXfj?=
 =?us-ascii?Q?pMvlnvyQhQ9oZThlungIRs/MYQDTZURPF+lPLif7zQ3v/9mIFvR4IHBBCC6m?=
 =?us-ascii?Q?IAwN/cdEdIp2XQ3FbNrgNOwa7B4Eh3X2FOatWhPFGbjNonEyvpAhCmUAujR8?=
 =?us-ascii?Q?1gKQZ9dXrm9Oy+zq2CTydZvbwcmJPe0NJHUNu8YdIJGA7Ef1vjAACtgrWWjq?=
 =?us-ascii?Q?2xN0SxL1gyNBDwHbtzx0VIVg4dvPVFbb8D1y7POKJtgZYQK7SK1GyV3fJrIC?=
 =?us-ascii?Q?8TwR7xnRzZBzWs1ftTkJH8c2L5yQtU5FXiQ0LLmK++amIeav+NHZwhvf+wZT?=
 =?us-ascii?Q?IUxU/UYiL+FRIaOOHBuiB8NOyX7lIyhLZ4DMVsg2UpbGeIvTf6HrRHI0eSOO?=
 =?us-ascii?Q?7hgPxlDyJrpOWTYn1q5H0ysJfpMpwb8efVnzaM/my9ANoM0UBBuxjhlbSouX?=
 =?us-ascii?Q?TZXZ0Qa8vVJYB9oKeUgOlyIcFkJTJiUd55wchV9+ACrC+KvEcVKVpbX22YMq?=
 =?us-ascii?Q?RpATL9aQnGKian72VHef3Bx8vWSJR6rlR2FN7Z2TV5izD2YVx3+2x6u4Sh3L?=
 =?us-ascii?Q?OqCPA6jju0JgzUNdUL46gv1SJ+FlbJrTWpkRgMDOE07sRNOduVfzS9SVGzae?=
 =?us-ascii?Q?4Qt+odEKQvVGJL6SoCEFwGExPPJs9GAi3hPNVNiat6wrY0Tgg/zUEV1GDq07?=
 =?us-ascii?Q?afAS88zsfTZSa6UgrSy9bKQHQU07f4fkLdC3HfR9zLjHn+vCpWDqm6If2HSq?=
 =?us-ascii?Q?HqTvCO1TYet2UyXhFU6B496baqatj6dxahG7RXCMSApG7EQ6mNkQqQxlze63?=
 =?us-ascii?Q?LZONIz5oiuUt1Tbh/rAZxVgBwfQVyH36DD9lIbV3h+oV1h0J836sN7Z0sb4a?=
 =?us-ascii?Q?AdMeLC91hFULYhRsGOhzYtp3LhKdhm1E3VZfpKJCd1yW/l8S4wgKkaWoW7DM?=
 =?us-ascii?Q?coG+jeNbyT1rgK2Ibc6EkdH8xrEzvlDXwpltNCYl3uZPu/0g8Ltup9jBd74o?=
 =?us-ascii?Q?e8NHSngYfVlX8foVyWhKWKzljBbUMb8ozHI2eUqmWKKY2nCdMvqGcfJpkEC0?=
 =?us-ascii?Q?8oO3K0PgrOcLAS2jBUpCHyMIgS2HGTAUKiLj3O0oLdhHu/HySZqE/bnZXPSF?=
 =?us-ascii?Q?Ln1HQAxw4HRaZCrAaQn79VSU9N+ByIWDxaTw4Eu6ceLeC+BvHVaaMCJ3zsAr?=
 =?us-ascii?Q?3UBnV452Hsrn1jZoh12A4L1zPQSBIlFpBSiPQRrZJMT5VdITbsT9cut4YORz?=
 =?us-ascii?Q?a+f+//oHcQ9cSzVqFqYH/z2X/F+tCOkQOPOeAIBV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caab5f9f-9e4a-40d0-2178-08dccdc5c9f9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:14:16.1780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2j/BnXJTOOykMdpjsGI5/JRwXJ6yp9QZgm3yVvCS4uOBa+pO//ESOI4nKrHObxPv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045

On Tue, Aug 27, 2024 at 09:59:47AM -0700, Nicolin Chen wrote:
> Driver can call the iommufd_viommu_find_device() to find a device pointer
> using its per-viommu virtual ID. The returned device must be protected by
> the pair of iommufd_viommu_lock/unlock_vdev_id() function.
> 
> Put these three functions into a new viommu_api file, to build it with the
> IOMMUFD_DRIVER config.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/Makefile     |  2 +-
>  drivers/iommu/iommufd/viommu_api.c | 39 ++++++++++++++++++++++++++++++
>  include/linux/iommufd.h            | 16 ++++++++++++
>  3 files changed, 56 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/iommufd/viommu_api.c

I still think this is better to just share the struct content with the
driver, eventually we want to do this anyhow as the driver will
want to use container_of() techniques to reach its private data.

> +/*
> + * Find a device attached to an VIOMMU object using a virtual device ID that was
> + * set via an IOMMUFD_CMD_VIOMMU_SET_VDEV_ID. Callers of this function must call
> + * iommufd_viommu_lock_vdev_id() prior and iommufd_viommu_unlock_vdev_id() after
> + *
> + * Return device or NULL.
> + */
> +struct device *iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id)
> +{
> +	struct iommufd_vdev_id *vdev_id;
> +
> +	lockdep_assert_held(&viommu->vdev_ids_rwsem);
> +
> +	xa_lock(&viommu->vdev_ids);
> +	vdev_id = xa_load(&viommu->vdev_ids, (unsigned long)id);
> +	xa_unlock(&viommu->vdev_ids);

No need for this lock, xa_load is rcu safe against concurrent writer

Jason

