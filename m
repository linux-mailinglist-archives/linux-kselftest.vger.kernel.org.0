Return-Path: <linux-kselftest+bounces-17772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A806F975D9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 01:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DD31F23125
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 23:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6674185B61;
	Wed, 11 Sep 2024 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nS7V2OXO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576A02F30;
	Wed, 11 Sep 2024 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726096269; cv=fail; b=YqVkRm/Tp8upgn5OZulHhzlwZuLbAAODYF6iUjqri8ebznEp4yA/QQeY+Lerwe8aD5QqC2C9DFQwcm12p5Y9SU9q/uQIhOdneKuIgcNmQlk8lvKpuCqn8Duju6JieyJ2psIMECoIom6yGV/rquMzwpprHCgntGyrkdIXSQwcNcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726096269; c=relaxed/simple;
	bh=TVoSEceCTcr6AbxpwFE/Kgy6mYFmhooJNeoiO8Xg5v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hPfHMixEOV1GLvZElhAV12qwfr0mv1tqF9LDx3J9M5A4ZoGymTZv4rfxDeyi5+3622oZEiUNpZoxRABc5NLXbtPDLn9XTAFbM0ZOJIefG0hteSG8SASl5oeTbvgi7Irc/QslgwCG+d+x2OtWvvj4zadgDU7KgW0Ord01rXxxjXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nS7V2OXO; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thXYvIFY6VULVj+MQy8t14NMA49s83nEc0uQKon2jagCCQipRy3hs9o1JDfXGjcYb8/gzvzToAAnBWAH+dnc1RKH45h+UQPrDYiQlA1AGvj53cUB1G3S3iyTWkakvQTYEuasitj7xx0fbGYTbzrffmBTR0vPSaeuYiYiAf6yWJNTEcBIIb2e6AdxgU6esdirBQlWZODAPmTvXm1dSXOVKl2XBkp63LRGtNFhibEMN9PXF/6lXme9jcgZ7PJmkQ/23fixoqwGa9Ui+di10HJ9Yys+4xiHhFwhntOFLvleXq3jPUkzZXCrqqV2Bw4iCJ3Bua9VHxxsr50a5AJ+8soMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwdybH+0u71gR6wb+2rwJCGVEVo7moC/RrPGAXOl4HQ=;
 b=iOkTyVMWXeqlOFjpHVP/EKQ+vO3pCBtoFamrMMye5XSKYFaLWXHu/hqgPQuHBmbap0cd40rdvErS5ucZJi5A+vI4uvvh+x5PCQn4uLXM+Tk64ALyaKQXu3bCrwdbOReW7RmIg4/HTHbpeiGaq6eWQ5MZxywwW5FH6KGv0j324cRtC6hh6JpPWKINKZBLNir8TurVi6il5A6gu0sachPg/7jfFIAIAuedifqzF1VKulAg5tAkOqhm39bx6R9yamT+hikmG9jB4gAWm6+ZDlVgPwKeVU6g0mUnlTLIeAPxhVULUEzXiyEEww294YAxkqSqwQdj5xGK4bBfIvccqqXydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwdybH+0u71gR6wb+2rwJCGVEVo7moC/RrPGAXOl4HQ=;
 b=nS7V2OXOH+lYYW1zL3+oJMWASVkyhAH+8IvTqn8AYUiOx/AJBSXqsCZEbBSjhZTNESEeSy2fo2koZdmhEBO9hXIU4Nnzj5h6n1TVILnUbrVnEn643uLmDJyDFYkEhRUvoFj9mQNn8WmZqk1xS1ngAj61Qheshe/+ucp54Klklz85YzGddFGUZTcDtPbQ5+t952GkXr+KI3C37k5otTgs4FDT7FmelhHL5IoIK2oQQz+5b9cba6oT9WnTE17VASrPOd/F3siEMrLhVj91jRbmVmdsisPxUR3xpo+kTwbjPKJ67gQbMHYxC0WCyB98bxBO3kHIBCPoxVtQ3w/zW3Zy8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 23:11:05 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%5]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 23:11:05 +0000
Date: Wed, 11 Sep 2024 20:11:03 -0300
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
Message-ID: <20240911231103.GR58321@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6ccdfb27c7aa5a5bb7e153165cf90114cae4687c.1724776335.git.nicolinc@nvidia.com>
 <20240905161415.GS1358970@nvidia.com>
 <ZtnwG/Kmaf+fZFAv@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtnwG/Kmaf+fZFAv@nvidia.com>
X-ClientProxiedBy: YQBP288CA0021.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::8) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|LV3PR12MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: 972aa42c-3f37-4be7-2663-08dcd2b70313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C6cIYr2k+ZoyPUibJ6cPiSzAiSvPGuvyuNmwBDbfLVnj48TedDi9YWLGcOsS?=
 =?us-ascii?Q?mhU/LPXaBmQ8jcwAlHYnlWg7II28p1tRn+HDzd0wfgTxbzzD/qDYk/YLm1Ai?=
 =?us-ascii?Q?jevYfLOTxYBmVHEx4rJUa/+WcEy8KOeCx4cURGv9cQu8jXNL4Ps1AgrP9ry1?=
 =?us-ascii?Q?5APvQOPrr2Ov2ZNqzz/2h9Lg+MIK03yrzlshbU9l/lvLxwRiq2VI8hov+DDe?=
 =?us-ascii?Q?u8PD6mcH/EzPH4Abyom/eUD1QlIrceoQ1faDI9hmFjmjZqY+aTXoTaQDNcuT?=
 =?us-ascii?Q?i1O/be++2ASgjafpf3xNebVjoOROVki6DzYZFSw3ApLDDe7D9pxMJRUTBo2o?=
 =?us-ascii?Q?QxzAppZEq9eVVzGm7uDQVrxPCl8zZTQCjciFAU+oRgmg9FVNOdbIRwcuw5Ub?=
 =?us-ascii?Q?HaeOfy96OxwnBgdHZDOOjMYYKWGImYhv0kW7F61NwFeN1IloAWaHvLwRIh1H?=
 =?us-ascii?Q?NHUZxmmS+oWR1CH81Oe2wD6XmhmC6QmSBs+EjCSjsJUbau1qO3kOZB+bFK0E?=
 =?us-ascii?Q?vabDEXh4geLIifceIiTZkQJSK3PS9EJaqAv6hUmSvpfFKhcRZBdkvisBr2Te?=
 =?us-ascii?Q?kUWUCs8BjOPTxX8zYWhgVyGmbbKK9q6VWJu5cafoASyruFVj9M8WkvX7KQKf?=
 =?us-ascii?Q?h5dUyPa92j94cOxOQDwr7ii2iuxAWWEzRa7MuhbnLG7fr97qcpjCbCzeiBLW?=
 =?us-ascii?Q?wGmZSHyPfb3ZjsCF3f+Gj2hkpWNuaI3fgkg9/mP4UOB3HPKED/tsuUbVVHWq?=
 =?us-ascii?Q?VIO90nk/ISBwt1NOxsi7Ofm0+LIdA5okTbU8YkZIjEWUTS+DAmPlhqV4UCwO?=
 =?us-ascii?Q?u1Pp95CcrcOgLvPzhT56/449nFqliyEcF3AB0cS3GsppzYFGc0mweWeyoODF?=
 =?us-ascii?Q?lx9uH/dAJhUGvJ0f90wjTJjim0KDJmxW9c0cM/SXlUyLcBrmd0R+y4XLIopy?=
 =?us-ascii?Q?W9Q9lq0IO97q5t3T7QxJ3SX2+icjPWVppAMMjk+nt+kt4bcCskD5hnKScDeX?=
 =?us-ascii?Q?ORQd4bdCVS77je1f1aK3JyRoz2ozidfrdgIkKc9dnFFIfcCA/hRCRtT9YsbC?=
 =?us-ascii?Q?u7uo1n4s+zEoVtO9rspiB1S96W2Qiq5d4kN8uuQqO3Zla+bCfLKb0eaxvZQl?=
 =?us-ascii?Q?tDNty5RUvF41btehJSaPLNCD+UHzOBucPhti8j1bUFuPvx02Nkv+MlAy6xuB?=
 =?us-ascii?Q?BLnFnZy5GUL3IC4HoXVDppL4kwFENjD3rYOJbVG1CRxOH1OlUQgba32VIrd4?=
 =?us-ascii?Q?pMRJAmWZWIev9ObgVZhpvlU88OhmM3pqWJc4TfAMq8kGhdZZWieA0rnl2ENr?=
 =?us-ascii?Q?sKa6nfH3QvbMxOJD/EeziihHl5xz6XrhVk4kzZJPrqt8Ew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DW6rqVAwq1rxvE3zbx524UVienbcH87tW0uyCkziN40RISsS2KrvjhVVKSm+?=
 =?us-ascii?Q?IMovDdApEW1Z6Xi3kJgKqkTN+aALSPZSWUsRyd1csECXyZaMJ0T+sVBXkHq1?=
 =?us-ascii?Q?w2+azJKoomKG/YGPq2nFjtIwhvY/i83SPBVXryBq6zFg3FC6af0fOZnDhWQv?=
 =?us-ascii?Q?DJfcI3WKafx6fozNbU/37pwkwuW5rBbW+UwJp+zdE9UcAoQqpRZ88RmJgGBG?=
 =?us-ascii?Q?7QKgsJeK26BrkxT3NUBqbKHrUS0rC0hHNcA192Yrwyp18/33p8+WEn3NbhL8?=
 =?us-ascii?Q?XQGLTN+/IyZl47PgrhTJ5+13EhlHdnHCWeTUo1AUTLlceW5Rtg5mpCghbf/7?=
 =?us-ascii?Q?6t0iV4q7rmH7O1466JRzuBvCe9ET3WvaZ2LTVWtIq6oVm80yg8Vvbtdonuev?=
 =?us-ascii?Q?RRFQ9R19LRdee/m0zsFSuDhx4O9+AvPH7TcWKcQPaOrSg8Yij6lSZ+wwvj+u?=
 =?us-ascii?Q?LF4jb1FmyJxBM7A+Cq0Fhs8LR8BSMtW8ClmFXunWbGqa+/yx/d7gbglIlvu9?=
 =?us-ascii?Q?+Kd0VqFfvNgWkVYv30sLPEvfZ1FoDi+0+igWRoGV7Tarsx+3+qDP1s7M7P7O?=
 =?us-ascii?Q?PG/Cx5wDy3mxC6mS8xL/Skh2tQVH7sO7cKzbTjmcwm5vCzgSY8Ozff9ehqlV?=
 =?us-ascii?Q?XGHF6JjF+RibiuiWdGUAm9bZzvdTUex9RJ9OT5q/YwePERPYH+/xBZKV/ASG?=
 =?us-ascii?Q?SKcksOzt4y4OrjKuhEvpGL/ub4f8bWXonQ2YZqA47R9f4tsEscksD55DaMAT?=
 =?us-ascii?Q?MbdrOeiEd56KiI7gNTsklIhq77CYGO8lV6/mfzNRUZA0L1IrsBLIXBFeApuU?=
 =?us-ascii?Q?rOK+t/cPti/Jj5WDlxc0TpbaH0qT8XSHjStarpLun/EPrdihxSNfRfYuFcOO?=
 =?us-ascii?Q?kGpEVQjJpJAJFmfHkcpjNUoz8dOX6NK07ZVRyNUz5X5uxqRZPOo1MxawpFLZ?=
 =?us-ascii?Q?QcynJIZN1fhzBiD76CaFrEcB0MpC/u29O//c6gfiXTjyRPr7Wg3Y3o0sK0sw?=
 =?us-ascii?Q?pR8MoxeC2lYYJI+MRPUtMkgJqZgqL//nNDDr63KtAW40DeZauHkcU0yyOv/9?=
 =?us-ascii?Q?AtB8b8hQY4r/RipAABiMiqC1d+Oacgs3zQh6lLQjagKCOMDwkwytXIYhUo6a?=
 =?us-ascii?Q?V01pCsU9c0DBMNNhIfxMO+kUXaoiMSQ2Ftn+ko7TpEyh6vnp8AXi9B81C65h?=
 =?us-ascii?Q?Zn4UiM40TzJ8xY3Tfc4/+AcVjppYHqDRij3Itq2+RSDjgpQCfnyiUBpOyfo3?=
 =?us-ascii?Q?sXC0odypAXCWBxl+7CKgfWvee32RyzsWkmJTTXM1ztEweEeQBaf+jlXJmQb7?=
 =?us-ascii?Q?2iVl/EkqBTqshnb4d0RH8tk1I7FXAcXdz5lq9GhlnagD2dcvUMtVIv6bCRGR?=
 =?us-ascii?Q?MC7SpGcK1Ny+gtJKtMSr0+tNzGXzhuK4v7FLyqYIU4hOCahREAQnWGqeypJR?=
 =?us-ascii?Q?0wy6G3PJBM07FiFLPBQXS0CQUHpx/iqkWlz0cvFj52bAH0LEzwWfjBGi1je7?=
 =?us-ascii?Q?zTtJFOx2zOFQAeKiv9TNrbgm6xhXdoVua9pADuSr50i4lgF2Tu0PQ/0xCu7z?=
 =?us-ascii?Q?DnDL2MkI7G9Yzc9+KhUSYaa+h7togMGoka5rwbqN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972aa42c-3f37-4be7-2663-08dcd2b70313
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 23:11:05.4114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7NbMEOFlwNIxCNx6yP3/rbbFcNQB/8wtGKk3QbTeyLitXIBITGqZ+emdwYZlxp6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143

On Thu, Sep 05, 2024 at 10:53:31AM -0700, Nicolin Chen wrote:
> On Thu, Sep 05, 2024 at 01:14:15PM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 27, 2024 at 09:59:47AM -0700, Nicolin Chen wrote:
> > > Driver can call the iommufd_viommu_find_device() to find a device pointer
> > > using its per-viommu virtual ID. The returned device must be protected by
> > > the pair of iommufd_viommu_lock/unlock_vdev_id() function.
> > > 
> > > Put these three functions into a new viommu_api file, to build it with the
> > > IOMMUFD_DRIVER config.
> > > 
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > ---
> > >  drivers/iommu/iommufd/Makefile     |  2 +-
> > >  drivers/iommu/iommufd/viommu_api.c | 39 ++++++++++++++++++++++++++++++
> > >  include/linux/iommufd.h            | 16 ++++++++++++
> > >  3 files changed, 56 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/iommu/iommufd/viommu_api.c
> > 
> > I still think this is better to just share the struct content with the
> > driver, eventually we want to do this anyhow as the driver will
> > want to use container_of() techniques to reach its private data.
> 
> In my mind, exposing everything to the driver is something that
> we have to (for driver-managed structures) v.s. we want to...
> Even in that case, a driver actually only need to know the size
> of the core structure, without touching what's inside(?).
> 
> I am a bit worried that drivers would abuse the content in the
> core-level structure.. Providing a set of API would encourage
> them to keep the core structure intact, hopefully..

This is always a tension in the kernel. If the core apis can be nice
and tidy then it is a reasonable direction

But here I think we've cross some threshold where the APIs are
complex, want to be inlined and really we just want to expose data not
APIs to drivers.

> > No need for this lock, xa_load is rcu safe against concurrent writer
> 
> I see iommufd's device.c and main.c grab xa_lock before xa_load?

That is not to protect the xa_load, it is to protect the lifetime of
pointer it returns

Jason

