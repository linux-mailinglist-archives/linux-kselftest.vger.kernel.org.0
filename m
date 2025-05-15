Return-Path: <linux-kselftest+bounces-33088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD07BAB8CC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6087B052B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D853A229B17;
	Thu, 15 May 2025 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wi3DqMHD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DD972638;
	Thu, 15 May 2025 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327644; cv=fail; b=kbf8i+cGt+8z7OtZ3VycYOKfCdtp5z5hVyJN7DIXPcqlocK0V8n3+PlcojTTL52597U2pKGcPAOsoKOLftaEkKWWVj8xHTr7acTnyDkUbLzks2zp5FbHytXdrRRyXRpS3+azsPnxi9Ki3ns4fjmYy8VGuTjzyYzHWXbJZkKanG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327644; c=relaxed/simple;
	bh=tY0Vo7D4Yy5a8w+hK08WtzkhsOaqZmnCX7XtRXGnjtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kHMD3bSCLhftMQnddw2V/l/mMzo1K1kMemx6unHFM3POp5qSDQhQMnrvi87Cc/O1zX9K3llUZRArfQyRD3XK0wS9gCPyZvhUrABZf7nSun+8TaLkt31UYXzyNpYJ7fawwWTr7spxsSB/zxnxWlJtzQMN2S8MhTbl1zF+1Q8+2co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wi3DqMHD; arc=fail smtp.client-ip=40.107.101.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqxyU45NISjcUWaLpRPGQfKwbJDHZ7QtIWDPSZNvDTE0VeIs02r78GwxRU4i1dKRDWBdSixTBwPgaFsyhiBpKscUatVdMKiVy3EkXmcCCnEo2SfbZrwGqHG0LqNXLTG8pxZAbs+SbXS+mTlZFjwlneJ58lMm64IjKdYbuCir3w7sPVivmWTKuvKGRgb5GBMqIcOulkMu8YsmTIOETYquc/F3SXa29mAoXaM8tT4RainXl/mNuegCiCVCio5Qlkt8nNb4optVIcL8W2mKNkC7XBtupzRpTGUVFeT7Qw+b4lmC1rOpA2NrVyO4tiQNGZn/rJsPWJi1yiGHAmgd+HGdDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfQuei2Z0RFwluYeUAJy/9Iezd1d5yn5Z1TJSR51We4=;
 b=nHtNOv2AyRhbOJajidQm0M1pPFsVKkh6N6+8sqTa9vyAmI0KGmm6H4kATd7juTl8kLAVb79iYNAAAzdrcwOms72HgBF6smqRaNg17NhK0X7heWR+o9O3XYmXfcaThOPXfqCO9yalqY5BjK1M5JAtvgqgXeBY+mfh4NsMFMDRJ7JOzxq19e6rzSJhr9GSukvlKjr5V61J9Zbqs/ni3TaRryRj3WsWutndI/ik8cKppeu3e+ipLLtq3l7wiU6rFD4tGO2eCHsLZsbMlLxIVfaPR6qX70skhtIxaWOmyuG4+/JK9omD83f2s04LTPeArE5w0lZbfci+yeUsckKDlKFEEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfQuei2Z0RFwluYeUAJy/9Iezd1d5yn5Z1TJSR51We4=;
 b=Wi3DqMHDeeem/OTf+IHoqjKOmbK2JQbOkKLakWS3sXlPa/NcUw61q3ykq0TRfXTB5lijiJofH5s5i6eH4Xf2oqmXVUci/BROM+nfsb6hyu/tTx8IX7tcR6Y5vcf6MJjtaiLN4OFXbKpSogqszoKiJquPN6IEeeKvwzuRV1LRgoxzG1QLQ+HRPxwnU/Ob3/N8WHNgbJqQgJ7yaqfG6kcVKIYimQ9ec4B77WzlFfbt+ZtRotFhbvr9mA2MNrMq1stOx8hWpnqnoLOK1vuFEsq3MXjgoIDriAtYnWd+wzLp0IfPKHkyIrJpLjwCaZ/MDDM0wCMQZtwkWG/QHPnkbmYE1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 16:47:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 16:47:18 +0000
Date: Thu, 15 May 2025 13:47:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v4 14/23] iommufd: Add mmap interface
Message-ID: <20250515164717.GL382960@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <ee9ee287264fd75eb4fc64a63f20d03e9ba18161.1746757630.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee9ee287264fd75eb4fc64a63f20d03e9ba18161.1746757630.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YQBPR01CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8a3dcb-f9bb-482f-91a2-08dd93d027b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mo/uiqJlNnIrKylN++KoONADaIFolukQNmR/44IT++kxMxBJtD9eyoSXC1uU?=
 =?us-ascii?Q?Mlos4oJzQqSj6sSViU1+akFiqXIy0DS4E4OV+lnkEPS/dwMtO40UowuT5Eby?=
 =?us-ascii?Q?VV7CAZa2rvZrI2xTxu5/WoKaRw2N6gdSCqsjFZr5qY4R0vKfiv04O5Xeh3Uk?=
 =?us-ascii?Q?mVZp+PSyzon6UZRPeBiWOWL7pZrBiy7kLAAJwzCVX08rGmp8BUWxBokJvRpC?=
 =?us-ascii?Q?mfIcoNCExkEN24i70k68yYkn/o9+gqS5BfuehUCBS75R4L0RBKsGCRmno80+?=
 =?us-ascii?Q?9xDyy1rX/1ZwameEPtIQ8m+Zl+4TGcyGEyvY2haCBHcKfOAXHoupewf1+tgK?=
 =?us-ascii?Q?Eu6CI8cIcSZ7Gx4jNOSP90SLeSAL+YMu3Iwh8RaJwwyfu2vpDswq6h416k6D?=
 =?us-ascii?Q?OVt4MXA05hE44EtQMWz7eCRpLQPnYl5bB0XNGLVS6MpbKa+6jkxpOgzVDrbZ?=
 =?us-ascii?Q?nHJ3KfqEiy0kPpbYBjT386XgEm5bshDmOYWFjnuuwoz37LDLTKEziA1Rr0Dw?=
 =?us-ascii?Q?IxskKX9CTTxbq9IU1jnbpQ41+oJAF5SZzuOITa1+79JH7XMmBRhGhKP/A5ZO?=
 =?us-ascii?Q?EQHW1+iY4L/xCBIwx0HM2N/r0V2RIu8g2Z6Y+LdJXaOoQaOYRjuiETya96yi?=
 =?us-ascii?Q?y24VHoNj29Ov9o8m57B7XMX78nUoNlYaeQT5bw3NkYMK0eLRPXYV+vb7LBeU?=
 =?us-ascii?Q?qj8uYf5UtYkL/Nf0LznKncuK6oeCvl8dB9agA+0sCPmRjq7inOWSurYBp20P?=
 =?us-ascii?Q?oC78L+W/IhqXZlaz5g6jyhBwAqYn6YPeYL/OIFtxmExWFFmuaBYToygJK91Y?=
 =?us-ascii?Q?XFfWhO1nGcPAZZdJbTO7FIxdigror077L9RxcuiIo1rDhtj4rgdSWM1ziC3G?=
 =?us-ascii?Q?zERWPTn1CqTy36wccHjxd/3k7jqKiPuYmpyZ1w5z0czaukCt9v28GRbT1fZv?=
 =?us-ascii?Q?ex8cyZW3e3XCNrnjDuZjedSOINWQK2v+0xnifnd+ZmhvwkTH3o7XOr4iF/zU?=
 =?us-ascii?Q?PkXWP9vG6FyfaSKF3VSUsV2/adV4BvCPXjTVRFUh5zV8T8o5N3REG5zOzNA2?=
 =?us-ascii?Q?5vf1SEA+WnnMJMJAs2BjG2A8caO63Gg6SGVo29ccq6qCdfCtzgTBz4sMsdFu?=
 =?us-ascii?Q?aPJdIgsEctMWHtHn0ICH3kUrSzc0OMEEZySb7itMGaX609RPWyvU6sOi6lUE?=
 =?us-ascii?Q?XFXHgzsCyCWh+mEJrp+AJz96klghNjHEarh/LMNoYEVFYlVg+7Ia8k9okQ4o?=
 =?us-ascii?Q?3ynTJC4DpwVLBWU82L9fGRDNmQTlVZm8INCI7+cbIv6VEpvt+jLCITI2JELI?=
 =?us-ascii?Q?zMu5mAo304u+/4bjy+vMe5YWOwsfKH4HM6oIssi23Dw4tQEpuPC5IBD3KrjM?=
 =?us-ascii?Q?+RsYOifQgCq+uZFkGIzNO6vN90lxImGhpffX7DwNmfaomCeEUKTrHi1F2AcR?=
 =?us-ascii?Q?Bg+BHbKfuiI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RXZLH4lVqoz7TdHtnLSDdkz97RRtnlj96yk+ycJft/LGx3f7N0zQAhOyiqkA?=
 =?us-ascii?Q?bT1dXzFcP2UGAi+M1SO/f7Je+k5zkQvDA8uBcEI9pVbgKXSPBEOQRpvgDW/c?=
 =?us-ascii?Q?NS4xpe3xBv5ST+ozfaJEARQcasTu91x+lyW/GLlRanBMNxWDDNfeh+297Cmh?=
 =?us-ascii?Q?J2b2bijz4wCg8T6SuKgmtyVVBqcH/4FCEfjBIJvFoiP75OavuOVZtl1HrLVR?=
 =?us-ascii?Q?5YSpP4Z+aaqqn/bWpHZ1rWf8Se+kZ5VVrYeRe9CdD97MIYFN/HVMcC+sw0KE?=
 =?us-ascii?Q?JDSjXWaG68P/K7HsX0Tr/PTehncRb9cdZStdCSV935bN7OO3DTI2AWVXWc88?=
 =?us-ascii?Q?+QdBnMpFW5ZvpmOWMx99vRnS0HNzqKCSALIybWmghwkKAz6evGFQERO79EdO?=
 =?us-ascii?Q?t6yPtU6Va2dHDCi2ue+LIhkwQHgRw8NZK8k1T7cXDesihWnb8hOn6g4x12xD?=
 =?us-ascii?Q?teL55nHXXtwKjITSAuE2MpogUjWaFOqoHCfHKQ+fAxnfbukj5OyPKH9qCoAU?=
 =?us-ascii?Q?nlCfJMaAmyvpM77cOTNkOWb+iIcV/q8HnikOtHQ5WypFvmlzs7i+3bEIE9v+?=
 =?us-ascii?Q?p0iGk4KCoEMkVGTTM33w9C03p6kwDapoOWvM9LXpXwKh4NhqF6SpDaSCRBJL?=
 =?us-ascii?Q?NHBiTymd/pe+EzHikvxH61zLKh4UGWXEP824jICN4ysm0GxafzcDnmrXh7tm?=
 =?us-ascii?Q?L200zJnyWJRSrkziGYdT/p6qKXQi6Of85iC0voOgFPdYJkXiFmtPzNypU3ln?=
 =?us-ascii?Q?JvLe7L3H2cUMD1YD1r8dCxzvSXtJki1ELxPF3SQbT6EfNbnrxR+sHZmkhnie?=
 =?us-ascii?Q?K1F45O+hPeK70fiPNkGSRgc9UEb26u/E3y+pnxJ9Nxhhtz+xM4DMmZcaGOjb?=
 =?us-ascii?Q?+ck/42GoV02nxWM8OIgsbYN4tTS7xDEEcKFTOVM5Kf7XlhpCUZREC2DMqfo1?=
 =?us-ascii?Q?RDJoM9zs+kURcjP8Zn2TNMuvtF+Tod5JFthTVKlDzwewG6nE+3l1Fd6bons2?=
 =?us-ascii?Q?Yn6xwWUcIknBiyLg8+7SH84uLZmHo61A0cTl4zaEzRBJSFiQIxVG4RC06X0r?=
 =?us-ascii?Q?QgGSu8OOomFLBVNtE2LydYTZlTISN/9a8yBKUPkY2xqwpbE3rhf9CSkfvNat?=
 =?us-ascii?Q?+GULAD2WY/HSqlEAA9Prdr7WlAByZ0sfl/IPtGlO9yHegv/ixEould+KR28k?=
 =?us-ascii?Q?NXe42SxHl7Ndbks445aku48SfAFmDD7GUPLT1xTRNQk9UhUsXA7t8/IM5v2P?=
 =?us-ascii?Q?4jVS0/008y1qt4np7tUzLy5eNW96vuja+9bw1pLJno8OgZV9kYQpOfy67mSf?=
 =?us-ascii?Q?ZKPWGZ9HBp/R8XBmB9U0VJYK4u4gVkqSTy9P//usKmy2mYjRjDr0hFMpFwq4?=
 =?us-ascii?Q?MAugPL1Vzu3jeD+cAv2sb8fCJUWNFq/kBFKkEUrHFahUicFGnNjkQsQ6eH2+?=
 =?us-ascii?Q?/ikihyg5/pObdM4z6gJDMjh+PWtiAGJTijZvXvKoOpgjKDAB0NaVnFkLgOF0?=
 =?us-ascii?Q?Xfciqyu6DCrNm9osyJmYKbx0EmstZ3DhmkdmEad8uZ/+wPjf9Y1eWJz9zBIR?=
 =?us-ascii?Q?GSeW1VXXAUnZSODrV+FpoQefreh5mZAULK2TeL2A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8a3dcb-f9bb-482f-91a2-08dd93d027b3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:47:18.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMvVG386epqFCYl80o++Wi16JOH2YSIWEn4xS8senE0NNLO2GgwydzCPV42DUx/U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030

On Thu, May 08, 2025 at 08:02:35PM -0700, Nicolin Chen wrote:
> +int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
> +			phys_addr_t base, size_t length, unsigned long *offset)
> +{
> +	struct iommufd_mmap *immap;
> +	unsigned long startp;
> +	int num_pfns, rc;
> +
> +	if (WARN_ON_ONCE(!offset))
> +		return -EINVAL;

We don't need checks like this, just let it oops

> +	if (!PAGE_ALIGNED(base))
> +		return -EINVAL;
> +	if (!length || !PAGE_ALIGNED(length))
> +		return -EINVAL;
> +	num_pfns = length >> PAGE_SHIFT;
> +
> +	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
> +	if (!immap)
> +		return -ENOMEM;
> +	immap->owner = owner;
> +	immap->base_pfn = base >> PAGE_SHIFT;

'base' is a confusing name for the mmio address. Call it mmio_pfn or something

> +static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct iommufd_ctx *ictx = filp->private_data;
> +	size_t length = vma->vm_end - vma->vm_start;
> +	struct iommufd_mmap *immap;
> +	int rc;
> +
> +	if (!PAGE_ALIGNED(length))
> +		return -EINVAL;
> +	if (!(vma->vm_flags & VM_SHARED))
> +		return -EINVAL;
> +	if (vma->vm_flags & VM_EXEC)
> +		return -EPERM;
> +
> +	/* vma->vm_pgoff carries an index to an mtree entry (immap) */
> +	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
> +	if (!immap)
> +		return -ENXIO;
> +	if (length >> PAGE_SHIFT != immap->num_pfns)
> +		return -ENXIO;

This needs to validate that vm_pgoff is at the start of the immap or
num_pfns is the wrong thing to validate length against.

length >> PAGE_SHIFT will truncate non-zero bits which will not check
it properly.

> +	vma->vm_pgoff = 0;
> +	vma->vm_private_data = immap;
> +	vma->vm_ops = &iommufd_vma_ops;
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP | VM_IO);

remap_pfn_range already sets these vm_flags

> +	rc = remap_pfn_range(vma, vma->vm_start, immap->base_pfn, length,
> +			     vma->vm_page_prot);

This shoudl be io_remap_pfn_range() if it is mmio

> +	if (!rc) /* vm_ops.open won't be called for mmap itself. */
> +		refcount_inc(&immap->owner->users);
> +	return rc;

Success oriented flow

Jason

