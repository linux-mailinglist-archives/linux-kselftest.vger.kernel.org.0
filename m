Return-Path: <linux-kselftest+bounces-19984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEE59A2900
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D77FB2A7D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 16:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F611DF981;
	Thu, 17 Oct 2024 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bp21qBcC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77EA1DF75D;
	Thu, 17 Oct 2024 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182848; cv=fail; b=hdyHTcCVoj9GQwfazVc7ghbXyb5ywFZULjr8ybyZOc93RtmA9IZvS/o465P6cm7Vt2Ad1mI7GdeAC7mx8noSPvR2lon9GJsXSHqBFHMkFdEMbgfCOkbb+1aUAo8bqY4uAFfzGBtC29Dfj+dp/ZM8bK5XrEdv4YF4Qdy9UKxM+jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182848; c=relaxed/simple;
	bh=8Dvu1US3ojOJtEy9l5Iz1pMSvKpnxQIGvh3vjCFJyIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZVzbQNDZMqyhqoxayFO311eU6JT1cGHKyHGWIbCJjI9qr2EvehZlPz655w5HHP3vsgkHmegsH3h1fFZU/Y5zF/ujv3s0LZrg4lxUOR95zduSeLSeFSNcCDrHcO0G0w280LaoPVj9pRY+4VbeozXQjFUlM5d0YAeDc0f8LbvCQ+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bp21qBcC; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxqXAzTH9I7ZxXIqI89FDLuJs0rMI6DGfJt242nBmD0aUWGy/W6Ckd9zltaIrTo+xljSpF53gqv1pHuEKxWoMVNa8NoOtie9xt9hBJ4tPhyV+O6FXKZ/HoXmp4gAhBX42EGAvcYE10lEJnZTPtUnP9ddXPSEumLk59L7DvyZ2KwCLqfunADjbm/atQNCRjBp3wbfpMr/mJAdQomqYLtvyAa8JUD2hSjnTGeUSM6EKBuRRN6uie/bF3110tpOLGweaDsYWwX8Fnlcxczrmdwb/Fb1byrpW9dbKxqxcQxWhTRZoKuLBfPFCr6nNDBrkVPHgNwP7JObKqhDKtBB/oX3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8+iEGeVyvDCIOZvzls/AvRrfGhGtphDKuSevvQAoB0=;
 b=kGuLCkmuucO6wELcX2zMiw4zaYUN3c5zXWbXinB1Pu+3naGOR2ZgdVFnR415h5XtwB4uIu5diOpglwi+4klvmwgUfOn/XBxRjv/7F/yvzTXGOmrM/2NZ0b46t+ZqiRF3NC6sY0O7sEMuKbaaTDfFM2Ry+10tILe/gQojMocpkUT3x/RFqFzcTqjHFHYWq2gjIKuh/z5akoL7Tq4R4nKGqL0d5hXJFw1KwNCP7f2grHQYAZcx1qnWYtR5oIo5O1/bD7IH3cz8Ql68ho4SGMVPXLqlw5RBwriMd+PoLfnSkDelgKeDwwJqx5XqMv1n00Q33Nz0rGFZowK27BApIAzwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8+iEGeVyvDCIOZvzls/AvRrfGhGtphDKuSevvQAoB0=;
 b=Bp21qBcCUkp4nbq2kMhv3jXQD0q7XVL5nhgPsto8+RYxoEmb88FXrkhR9gmE+8j2JVGZFvyCVg349LvKk8c9oDU7D0Z3039JPd0FHKTAkKx2xoPuwJof0WbjqID1oin5Se3TBubkSgPyop0KHetZGlaqN7AkIn7/0tovc7F5NPKVYJFF7RJuoFrDxf/bsFj9B9VLdlWMOXrCJSX9nAyO7hKLXm0O6GoP/klUNjlO7N34FNiPyBgVZD91jpid/N4r+4ULG+uhKK/m1t99SB7+P55jgQOe/6iHGOWPDpHfS3OJQRYZHxGGGpxXpX0GmRv0s+WDwkbpcSEvOma4qy8mjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:34:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:34:00 +0000
Date: Thu, 17 Oct 2024 13:33:59 -0300
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
Subject: Re: [PATCH v3 03/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Message-ID: <20241017163359.GB3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:408:fe::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d15bf79-ad93-427f-8bb6-08dceec98118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vA7+Zr56LvKrZmxTB/rsy91CHcqZ91EFijwzLWy9VZ1ZIRrBgAvt5uKYLHL1?=
 =?us-ascii?Q?ctFBKrKayP5OtI0xCaz3xZ5GHsekvA4v4/3etS8pH1YpCndD0eMp5tSKXi1P?=
 =?us-ascii?Q?zHo6zKJuzfaW48qLUe+Re/dmCdrNxpUAInFYfooLSWk6N6FNpxqBKVAldsVZ?=
 =?us-ascii?Q?OgFCgXPdpyAdUYr7TlV9Y8Dd89B8I3SLdnoOqL4hFiTHdhS4qSh3rMeZbhov?=
 =?us-ascii?Q?Eh4+tcLKeHwKyLGQoXuBJLZ1QNlNwjOKaHl5zfwX0Y+kjBx6WEgszQAgcqNb?=
 =?us-ascii?Q?R2cKLOrrjwdIIG/p6VbHAFNqxK/Nt6wOd32EhD87NrIJbT+DXdbCAO7QaCW3?=
 =?us-ascii?Q?j7nKEtfXTuAYmHsZgC1CHGzlybndlBkbrg01pDaAzyibkW2Ng+F/363ENOYv?=
 =?us-ascii?Q?JgrN7Ah5l5Epv90TrQcr5SunxKI9AFS5tnOHtybVYSR7pbrSU1XFS5t1LK2r?=
 =?us-ascii?Q?tUFU2qvoe6S3nlm5LNRxDYv0vLJgMMavlLZ8d/V2z0RLOllJA/SGx6SSAyyP?=
 =?us-ascii?Q?Z3CbPd0GXKKSYt6HU1YtTQX6BRuJHajTPKafN9ZFQlIrHcqywJWHorzn6Jnu?=
 =?us-ascii?Q?dBYY6uVqg7w2QrlUGZtk2l+FMjN4kS/ZBlOlDHbSaMzx3iMRfMJba+pJJt1U?=
 =?us-ascii?Q?h3jUaCNOqYeXxMx20UccQH9OqXG5CeydwAZzMNsCA+GJD4/Ip6HkXzNk6jSz?=
 =?us-ascii?Q?TegBPdgn2gXr0eFimAoRQrTg3IOaY97QlcBMedDp6sbDEUwqVSuT+qIbBVv5?=
 =?us-ascii?Q?Lb9xKeQ6Xvp7oEHYsjHCv6QtDKKCiZOhR4v1gvxvyDDqWXt/CvJBSF+lr/qc?=
 =?us-ascii?Q?POhujbq69MJAcdMyWFO9IaaeZ/nNYIxTYRr6v+/TaqHR0Rvf3Gz5OXPB9jfU?=
 =?us-ascii?Q?uevk64gqm2Y47YgQhGmgGhO5P12V56C0romfL6oHVT7sSOK1l5W2bWiG/EfY?=
 =?us-ascii?Q?1U0z+F9XHGT4CybVQ3NhgSvvhsXl+fOpAOhMbq9g2ypeB9sjD9Mxh//gUbZ4?=
 =?us-ascii?Q?lu8FrxNhwjSKZWOkMqfDBrg2Hx9JnYXxPoe4Srvd4yqJIlXZW0LIV4EpEeY7?=
 =?us-ascii?Q?E1GJTtYi6/hTxQsl7P9pIraDEXyOLNAuNT/sHuhr+pLaN7w5BpQQD1f2ecM6?=
 =?us-ascii?Q?RXourV+LewVG3qJjgAADJXnXnwzO4uEcH6D83tBmN7prr89RcAtKRJF3Kk+2?=
 =?us-ascii?Q?XvGbjUsHgq91g3zSxHM4WTTdsfCCRwvhtSK5UnKHLwfDlNie6zKgjbKwi4kq?=
 =?us-ascii?Q?KO/m8w1sw4aR5xe29fYxyz9auVTU9Q7Ytud1SAheVwVaNrc8/soN9P4+oKl3?=
 =?us-ascii?Q?MMjrm/iPaF44KCdCv6Zs7zo3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fjJK376h3nMj/Y7dOH8QiS8zK6BibMgYKF8SuMOdaWW6xbydFVZCAphnFn3z?=
 =?us-ascii?Q?LYgzlkihglAGWqfmNh/PyPvl/Rr59UUPDGGkf8H6CnV9M5QrFO1dhDoGeCCR?=
 =?us-ascii?Q?4FZjBcJA7AXuyUEBDxEOq5GrL6DphfqdO62GI8txfADoblZw8JNyr8+baPoo?=
 =?us-ascii?Q?ZSSSXFbKzfBaiiCt5CDqJzj0Qn/QNLbvIqI7wqJs7giNbvDvuuuZGr/tthpm?=
 =?us-ascii?Q?CT4tut2NvROq3INQZNJoGh6JQ8gU7YWDhBBuqNCHuRSQ5hDg6NXHnOyZHU7S?=
 =?us-ascii?Q?eGilPWIpAHG6ioYXLeT/LM26U4b+0/IJ/1kbLeSOMHJXbCyGQKRAi95vdnrS?=
 =?us-ascii?Q?FHuZtni9sIq+ezoNH6RIDO2MVagarlpDQRmcJvTKVjTG+i8OzL5U/C9I2LL3?=
 =?us-ascii?Q?SLzD1DIqTUre3sZubqTTRzIoB1jlpB06Rmk0OzT6DqP22AxFcz+BUfJ9+aYN?=
 =?us-ascii?Q?R1YkDCnPC9blCfiB4Tdmw0wefU8VcvO3vy8XJNej9H9qxjXIfqDERF+6gczn?=
 =?us-ascii?Q?HOur+ZM3JfP0xYQbamB3ghSVeqfNL7ikjpp5nWNyM9G6BuzaDex1gYCjIwnb?=
 =?us-ascii?Q?m3TOImROUVJTWIXmA7+lTqHRxRVnWyxkLZTUxRotYwYUe4Y/o1zNwUwK4lV0?=
 =?us-ascii?Q?vAtRb2V9VlJlOTV8jyasIrugxUsBMI1f0xAocer85ArYjPw41YKyofgxWp0L?=
 =?us-ascii?Q?HVNx2S00tgDTdlBx6yGupCtCx/rqQL+Hkfr4qCKAGsNogspFYyiF2+nHI7rp?=
 =?us-ascii?Q?XhXoeNL03n+WgYUZDBREKTAU4CHcIw3BIJXPsG7O+6re9oZCpT2w9LJDIHKo?=
 =?us-ascii?Q?cFARVYhO+tgscNoyNxuEe+qemeS+vn16wVot/6wsXe/h/5K5RmqmwhvBFpAe?=
 =?us-ascii?Q?A6UFzUrrkpifIIYEzXSsgPWPzhZKvQguwQmGW8bz9j7TA5RQCfbn75qASUAq?=
 =?us-ascii?Q?dofqeukN+2mnZttvO/UANt42VsClBSYSn7Tm/kKoL5cEhga95btbzejzu3/k?=
 =?us-ascii?Q?ELZG6A4GFmgXijWP0CQh6UR1G+MqTgYce0yC3sm9CBERXB6PXaJQ0PaJXMH4?=
 =?us-ascii?Q?Y0cawiLerd5ZyRzxRckrbJX2yXZYpl+BK4JaFOBVE4iRsOh2OvysueFs6vPu?=
 =?us-ascii?Q?Xq+88LMLrtDLB1mRc728SHb3iMlQQv75HU1SjCuj+Z1+jfX60d7mPQIAcXU6?=
 =?us-ascii?Q?3LK/tJKWZqZyZVxJEC26pS2IYpBl43HTfNQvnyHpLswihetfrXuN3qTmT/Fn?=
 =?us-ascii?Q?XeEYuyHcxyt+CSBxz3TfJ+gzv0+Go4VGPaHetgeDVInygkantxI7egLBfWN1?=
 =?us-ascii?Q?ODeukMZU/DiIo0VabOftAszEOugq7U8fS69ore1ldr6c4f1xBJ0VIYC0sK7I?=
 =?us-ascii?Q?pP2zlrMtmCKPU+MPJdejcOhp3+cWtZPbFo5TVjfKyYJKcsmbg7A1LaGiGef/?=
 =?us-ascii?Q?v3Y6UTtRQS5B01YFN55q6z795ElqaYbgFPGQHoT4gOkNyUiICh7l8XgcINQR?=
 =?us-ascii?Q?x2SsymmiAym+MGe0FzuyNJpGKnTbjnrGNHfWRPwfXFYEN91yBQrPuNvge45/?=
 =?us-ascii?Q?tvsDCJN0q7OseAfHuF0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d15bf79-ad93-427f-8bb6-08dceec98118
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:34:00.3051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LToA7Db6x8TqggK0xgBNb+pDlnlxpArow9ltMUp7xGrkaZ6YAF53yHK3Lo8sYUXE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574

On Wed, Oct 09, 2024 at 09:38:03AM -0700, Nicolin Chen wrote:
> +	struct iommufd_viommu *(*viommu_alloc)(struct iommu_device *iommu_dev,
> +					       struct iommu_domain *domain,

Let's call this parent_domain ie nesting parent

> +/*
> + * Helpers for IOMMU driver to allocate driver structures that will be freed by
> + * the iommufd core. Yet, a driver is responsible for its own
> struct cleanup.

'own struct cleanup via the free callback'

> diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
> new file mode 100644
> index 000000000000..c1731f080d6b
> --- /dev/null
> +++ b/drivers/iommu/iommufd/viommu_api.c

Let's call this file driver.c to match CONFIG_IOMMUFD_DRIVER

> +struct iommufd_viommu *
> +__iommufd_viommu_alloc(struct iommufd_ctx *ictx, size_t size,
> +		       const struct iommufd_viommu_ops *ops)
> +{
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_object *obj;
> +
> +	if (WARN_ON(size < sizeof(*viommu)))
> +		return ERR_PTR(-EINVAL);

The macro does this already

> +	obj = iommufd_object_alloc_elm(ictx, size, IOMMUFD_OBJ_VIOMMU);
> +	if (IS_ERR(obj))
> +		return ERR_CAST(obj);
> +	viommu = container_of(obj, struct iommufd_viommu, obj);

And this too..

> +	if (ops)
> +		viommu->ops = ops;

No need for an if...

It could just be in the macro which is a bit appealing given we want
this linked into the drivers..

/*
 * Helpers for IOMMU driver to allocate driver structures that will be freed by
 * the iommufd core. The free op will be called prior to freeing the memory.
 */
#define iommufd_viommu_alloc(ictx, drv_struct, member, viommu_ops)            \
	({                                                                    \
		struct drv_struct *ret;                                       \
                                                                              \
		static_assert(                                                \
			__same_type(struct iommufd_viommu,                    \
				    ((struct drv_struct *)NULL)->member));    \
		static_assert(offsetof(struct drv_struct, member.obj) == 0);  \
		ret = (struct drv_struct *)iommufd_object_alloc_elm(          \
			ictx, sizeof(struct drv_struct), IOMMUFD_OBJ_VIOMMU); \
		ret->member.ops = viommu_ops;                                 \
		ret;                                                          \
	})

Jason

