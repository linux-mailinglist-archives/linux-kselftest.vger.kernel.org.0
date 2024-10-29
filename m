Return-Path: <linux-kselftest+bounces-20965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D044D9B4CA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554C81F2440A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503E61917FE;
	Tue, 29 Oct 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qg2MOYBx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F711191473;
	Tue, 29 Oct 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213687; cv=fail; b=qZ6md6i1A1qqaYlZXdtJOcm5kdQJ0H9Ao57aYqFq7tJIaCf4UqL9158RRyWdDixqUsQL9khZqDenPTYx6jU74XymQqko9CHP73JIOIdVG1FLevLm8O74PAD5se0XBUEreAz2mQLoQ0i9P2RxzMZmT97G7F9pJfhZRytOjRzgljU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213687; c=relaxed/simple;
	bh=cAG/nh6KEhF/3aT2kAe39osBGrANuB6WHFzZv/NUUD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lbXGohjBJfWtXXAK889zZCyO0VjJhwo9MjOHQYWpcUR18NJEETs+mAIt9DrVrCiO/6oC9IoTAT2OFMqsThexwjXI8u+hDWQ7TsavH/5cxJXQAosSJRq+wySF60Pd+w//5FJLs2SWRe6HmvWVqh2BhA0dDVOJK3z3zsBwbOO50kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qg2MOYBx; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StlmFd6YRL4UkiYAgUxEf4FTCDYLcRzJtHWOW/PeVJX5yO8eFuVbLYBJ+d3eBrIajJcUXi2VFj8LwZZu4tiBpZBl4wq6a7Lm1++jI6eGfAziQ7vrgks00pgMDJpBxezBWdB4PNvDwYF4dJwXZx0+57pLUrKObAl3fJ2DqZPf7zlWDDeLpQSQ8Gt88WkbVqOiUYoZI5geRnZSxa2ANs9n3esVCl85vjdh8+CTZpozmhV4h0sD3GdVqnkhA+FB3RykL+8aJ1wIP9pWvb+7IiB+q7sKpMEbIGc/UgsoTGk+2d/c7JrqNKa/5juYDRQ8CFLBQvb3yy8P3zasv1VM1BizfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=954MQIFYfA2JQMytxuXtZxiZV9LQUF91cAYq0LSm0XY=;
 b=yGvoRRg3lttDhWcXH7sULnlkiXU3mW6m1DLPzXR+jGTMDvilKmPDd0RRa7eBnxm9ZNk9MNYTgGRRVAhVRDmuQ2LCUoKXJOq3wDaMGvu4wW4IwwgoD/dT0R126Y5v7dOv69txoVcfT7XGzbB8t63U4+dyNpPzzjo2s8YQB6fWLHuFQChUbNPLw5bE8MhQOXwuLrgMCGH0oEDyPIUljF5Gyh7qUtPaMz+JWmBVfRuU1+D28TJZhV8YhtEZoWLHPKwP13DUkeD9aVUZaZS8jnncU4W9AKW972t67K6GfHCBrUX5iPUq1UY6d7xuGwsfu4T/SDiB+QohS2IEWhVkm3HUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=954MQIFYfA2JQMytxuXtZxiZV9LQUF91cAYq0LSm0XY=;
 b=qg2MOYBxUJnUlpGgQOcAniTnDRtbBRLpYbMaW3AvGizv9loveifz678/emlNX+cJFcTZTuEjO1MpZWd/lv7sX17GvBJ9MeSrFvH5IT0Jdf1FqZRoqNaB17IYMQrG9q7gGa04wv2BKx9H4MO/+ioDoDEsdBDiVw7iiBE0q7OUZn8nlnNRQhvcIrQIsMJ3bpCC9OXPIt6fOcHSC4gj4AgIljT4D78CPGuYY1mzjKf1jENoxVTLUY7O/nlobWAwXjHTOqmctvdQ8P9Rt3MOThP7XQxLfDv9xHNhrOVeV4l71azpGgvaL5NkC+tX83droYqi/mME/s5n3AhDEGRsxsn77g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 14:54:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 14:54:37 +0000
Date: Tue, 29 Oct 2024 11:54:36 -0300
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
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 04/13] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <20241029145436.GC209124@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <f24628d774181da6df6e62bfa3376fbcacef8906.1729897352.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f24628d774181da6df6e62bfa3376fbcacef8906.1729897352.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR15CA0032.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::45) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: da78e835-ade5-4bf8-abf4-08dcf8299c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7/cSDGCcyAHDWEXD8bsH38bQzXnrTfkR150CJry+B5Rjvxd1Yq1QVcORU/xV?=
 =?us-ascii?Q?s76Iksk1lGPU9SgSIOkeZ/UGD0HPwmOwREGyVfGCzN1N+hLpDVItnA9YLiLD?=
 =?us-ascii?Q?97hrFWuxt2qq7zj7YmbT9O0ptTKDKvVyxLL8LiF86toXxLWFGlli1nCIq9Fd?=
 =?us-ascii?Q?jI6Any3t6fJEpysH9M9X7oTzA0xc0Y9FZDeTACsMk3PLKEnjOkcQG8dBADF/?=
 =?us-ascii?Q?0njzjLsc0y7ba3NYTh0gCAtVcW3GOJ+ILzcEkA8CCbelsePHw0ObNplMwSV6?=
 =?us-ascii?Q?HUNWNkLfxdRs48nRKlukLRcrgqzaEDaDIWAmgCxYN/GlbYms3nrHrb4QN5yc?=
 =?us-ascii?Q?PgxJynJHf1mPXb2Vt6UDJB53iN+xN2XeU5m0KMSJnp17BamEEl1VfNzZfulO?=
 =?us-ascii?Q?yZl8xc4H4mE/C/tPZLIbSIKN4qp0JLp+ypsCflgVhROruHwyTUZBZcTrcZyL?=
 =?us-ascii?Q?foobcqX5TdpHWfFqTE8ioJgj+Fap8VG47wwU25IIFYp5f/ADMroaEhmH4QkP?=
 =?us-ascii?Q?2spvLy5F2taG5wlWx1UTUL+67BN6R6oUCScvMcHSZM94jj7r/oxN8aIw4im7?=
 =?us-ascii?Q?6sw0xLGLMDDxgQy/txE2VvUrByc8ZSiuokCpPybe6Wa+ekzgNKwg0sig2t6E?=
 =?us-ascii?Q?0BHQjjzg63E6MEkv/vbbhiX4Qa09j0ofqc8+wRyaLnAiL4TDyld/4C5n6zIq?=
 =?us-ascii?Q?RRO7qXimJA54LAN4fv+3ITBYaVCtNjTyEBeQe8hB44ir+shhOiTFOCP/XXfZ?=
 =?us-ascii?Q?saBUxNnnY1/469j70xWjCSfNwuf3hzCEiVZ+fRmDPi9FGfSTT9iaXHEibreZ?=
 =?us-ascii?Q?oofZ/wVofHwq/EDLNYAkFuC86MBYHCPx+eQz41U2Wm2AJ2F4iMMo7uFp8Sr6?=
 =?us-ascii?Q?2nnE8eMsYkzaRc9dkzpApKHRZmwg+Jz37Uj7161j3IoBerOI3Y3ydpTqdE60?=
 =?us-ascii?Q?5LY6ZxK2LzoS2b5FXaEBCgv/LCqjvEuQbv50rjV7DT/xW376mVYDv6NIxwJP?=
 =?us-ascii?Q?ZUdRNtPP2D5un2f1nU2Z3tLDRVIx3mf0q/F8QUanZCe7Wh1x606KVO/DN6Rg?=
 =?us-ascii?Q?sw9S5womtGAVL8DVC7imN+FeyO5vHhRJoyUr3IEFGxgDIbhc6hSh0w+hdEDC?=
 =?us-ascii?Q?ch4VMN28huUA8rHYRvyYJXFvn5C9IP23mvYOASP35rVRlicB46HPT2IHkoS0?=
 =?us-ascii?Q?Q06C4iWTPnD3OPornCXQK36tDpGak2rWU4+0cCwEAHdMfcd9VlzMzrwenX6R?=
 =?us-ascii?Q?aTpPgve3K3U7akFuNSkXUZa/SWlS55LhASAtv2OnbVvzonEqIz5YM/5gEHmt?=
 =?us-ascii?Q?LHnrMrFNuV1yAciyN+QAV26f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4tFHHWwe0VyZEilNWYZBlxMegQN13YxNk/wBdDyl1ThcQ8qiS4wd25DXb429?=
 =?us-ascii?Q?yWmJiySoIhQySoVcQysSFpT1xR9RPQNH1XUiUR3rV+i1qM3EYGLhSRjTejg7?=
 =?us-ascii?Q?w+D0WLe4otbceV/t6pJ7QYD8Cvg9v1C7TjrBrwdxuRCa5CVq44IH+D0veoKD?=
 =?us-ascii?Q?G1lajZ1V9hIAwsJUkPcJ0xj2kbPCG3NAN+ynN+dhSNR3IB2q7M67pbms0uxf?=
 =?us-ascii?Q?2qUAyGrWrawB4cCEVZxuA241AiVxXasOjZYPOR6WU2ZsJ4ZTJFgcFQkHoVXK?=
 =?us-ascii?Q?9JGPnC1h/5mksxBv/1cScupGzXZot1cXAQSR4wV4KEbkIgNLKqqVMGRWdpbV?=
 =?us-ascii?Q?KLvea7US4NWLOkyu4PXN+VVXtQE9QYqdgnKIHI9nfRSGjTS+SEr1wBMkn1KU?=
 =?us-ascii?Q?N7WEbWyLlvIIAPVlWuaJp4/Ahnmd0NgkMMJhOKK0QRemY/+pYDfTM/ih5QJD?=
 =?us-ascii?Q?bD6aGOhg8RF6ps66K3CPyxhE43IQRdwkQFbtozyOXOXAbLnhBbglxH0x+y9L?=
 =?us-ascii?Q?eSG2cgd8lvd05IEHLyuP6X/Jhn5mfZPd4RKIpdcwANBhXB8PE4vqY6q/31Oi?=
 =?us-ascii?Q?KaYCcI/Mce/viGKd1sz7NiEVkTq+ZVIP6DqKShHOlvxTfQmUoKAEUvv3vEVi?=
 =?us-ascii?Q?wq3zt5hifhsfzuiAUowqA3ndCR+g3MsB2UBTuepvMVsWfF5O0vDUlZpT+y4F?=
 =?us-ascii?Q?iuO0WnUQKSzPEJPhJ8LAvkgwitl5eXuU5ha55q3ZApnuTfjD/9wJELUw22B+?=
 =?us-ascii?Q?kZo9O45e+88Yq4exYCAcWUdWDdGrwa3dkVuFUJMEOvQiP3IgopBoxBlVLaR6?=
 =?us-ascii?Q?tG5kE/p1wce9T8mdmyf1npgoH8qTk3MY/0TNRESNEHndbkUnniOO1vwP33g5?=
 =?us-ascii?Q?WaL7moWBUf6Y4JuHxsGyvGUVN0npQm/0BouOMdHRbw2yrh0c78EUeOfYwBNK?=
 =?us-ascii?Q?jrGsaZJZv0ew+qRyZo8Qh7mrSHzXqtJRIrVaLTHniLgVxsJ6SfjQVELB8Hs2?=
 =?us-ascii?Q?pKxKvVcdf91X46A0lYH84mD51N1Cv/Lmecv/BegPX5H9/8tNa8B3+uWAwQ5z?=
 =?us-ascii?Q?LGOEScbmSB8ZhwwyzQVJ9I92AxTId3iGHX+h+3AZK2y4sCvdFF0awHkxv+EX?=
 =?us-ascii?Q?TfDPFppuskrR1lC47ohGBMGalnNgCXTHpVJ2T5LEFgteDFweHV+G1n8sorrK?=
 =?us-ascii?Q?cjkjwB48TAL/0RLXYL3YEWwAH1AIwAyEXQGXA7GHvPvvx1Cu1pGMwQLSDcsP?=
 =?us-ascii?Q?vuoVBTS/VfHavvDPQI8tKXtXKgOFJrI7DpxaZuAkRpZCfi5BS5R1rtErJnd3?=
 =?us-ascii?Q?nkMKCal/qRmBmLqRqmpT8LIGvv5e1D728ozwv0vSYWGGqKp1Tbaf/1r3iLV5?=
 =?us-ascii?Q?GXU8eIgEd6EO1GJt9RqNZGmdTV5jdOrSVOMAe9Xa3wcPKHtgPesjeMxUYIO4?=
 =?us-ascii?Q?OE0RbbUzkg0yq2iepKGdfAP0HjvnRPVxH0J5PkoZd4jC3w4PVB9W4CRNQXbR?=
 =?us-ascii?Q?YzcKOjn5PvXIk5Fzl5JcNORdK+IttSJK1ul3m/Lg6DTrlvpVski02lH0LVy/?=
 =?us-ascii?Q?HCJ3EzBjhgqLgZFZa1Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da78e835-ade5-4bf8-abf4-08dcf8299c06
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 14:54:37.6981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/e+2+8c6FQTEPnvPqFW90GvX4MZZ8Jh8X0ZNANGAsvq4dO++QYWwsekKn9PnwTO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355

On Fri, Oct 25, 2024 at 04:49:44PM -0700, Nicolin Chen wrote:
> +void iommufd_viommu_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_viommu *viommu =
> +		container_of(obj, struct iommufd_viommu, obj);
> +
> +	if (viommu->ops && viommu->ops->free)
> +		viommu->ops->free(viommu);

Ops can't be null and free can't be null, that would mean there is a
memory leak.

> +	refcount_dec(&viommu->hwpt->common.obj.users);

Don't touch viommu after freeing it

Did you run selftests with kasn?

> +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_viommu_alloc *cmd = ucmd->cmd;
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_device *idev;
> +	const struct iommu_ops *ops;
> +	int rc;
> +
> +	if (cmd->flags || cmd->type == IOMMU_VIOMMU_TYPE_DEFAULT)
> +		return -EOPNOTSUPP;
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +
> +	ops = dev_iommu_ops(idev->dev);
> +	if (!ops->viommu_alloc) {
> +		rc = -EOPNOTSUPP;
> +		goto out_put_idev;
> +	}
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
> +	viommu = ops->viommu_alloc(idev->dev, hwpt_paging->common.domain,
> +				   ucmd->ictx, cmd->type);
> +	if (IS_ERR(viommu)) {
> +		rc = PTR_ERR(viommu);
> +		goto out_put_hwpt;
> +	}

Check that ops and ops->free are valid here with a WARN_ON

> +	rc = iommufd_verify_unfinalized_object(ucmd->ictx, &viommu->obj);
> +	if (rc) {
> +		kfree(viommu);
> +		goto out_put_hwpt;
> +	}
> +
> +	viommu->type = cmd->type;
> +	viommu->ictx = ucmd->ictx;
> +	viommu->hwpt = hwpt_paging;
> +	/*
> +	 * It is the most likely case that a physical IOMMU is unpluggable. A
> +	 * pluggable IOMMU instance (if exists) is responsible for refcounting
> +	 * on its own.
> +	 */
> +	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
> +
> +	refcount_inc(&viommu->hwpt->common.obj.users);

Put this line right after the one storing to viommu_>hwpt

Jason

