Return-Path: <linux-kselftest+bounces-35078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A91DADB336
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89551882FF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD69E1D6DB6;
	Mon, 16 Jun 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IIoWl4kr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D41C5D7D;
	Mon, 16 Jun 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083205; cv=fail; b=WojXG3Q6TOGEmxZON6RR/LfkI4QtVYl09o3xd7/rdhi2c4aNYRDkNeN50sTFM1IBRElhk13TQeWOdFyrMbmLlQ2AwAF43KxS9DY6sHCFs57T2XoAb/Ujjo7h3lsuwxueeci+N6CKP5JJafft0Cp8jpvoN/jdSuLxQoYXf+/DmHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083205; c=relaxed/simple;
	bh=t3A/n66pLs71kQTWUII8M0aYqBGD/NkCYkbQ1GDt1YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fd8uVzTOjV0C1MP1m/xUzYgIuWMArqT1fwBwiMPDzFOSSmpHUbaqQbwmuRp0P81vGY7WsU6eabHu6M/EmNfzlSj9qhjon53f/2oBU1c+5txoWhp1GTuM/odXi57pERABL5MvfNIEFHEO04/73XK5c1FmyYJBQbRVw9iubWfosFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IIoWl4kr; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZP5RaiIXlNlIZAm6s3gmpTUEgPWa0Erv+Nh/XuqwFgcGnPMqL+cXDvesCh7vWBV+bWQTnkwzyOqpT7+BICIfr7aKWfTom5KvOR7g3fjSZrXUak14etkMadczJOnatOm4r/wMpKgaLSylAHNPk2XSOmDeidKOxvDKLj1gOWpMX5cjo6kmMbvm2DKZC42w4O1roOp+Y0edtu/ZoPrC7cA6DLby+WqUrxzsN3jR7cMnEtEqTAvRY45QuMNg9ewAjoboCJNUEo5PdsX7XaVB7Ir2KK/KcA1eOyfmmYd6m4p0Vd9PEljeHMJtvbNxf58ZkRmWFroUcQe47+0j9gx7+E76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0RBaRLzGQicfTDNL6Vav6XC7caxzK87TkpkGQKp5E0=;
 b=TWufp22DjuG9rMuu9MiuoNSj43RUvxYK1qnP+lURCdZJ3v3yW5IdaejQTlfLoeyQ3ltiQoatPwFC3eaW/aWrg+B6MF55+/DqwvcnW5Ob8JsE0Tgi8NlnyYedu700+JOhYRdiVyQnKMiOGa/4v2bhMVs4s0+/NaxCOtffS86U0uYcbdZbDZVz4DhwNgm67p+GtxJ3hAwjGy2fMFr7XATBY6Twka8ZRQKLAmlqW9Pxu0L/xy+HcWozi5A9BBbUTnbA8sLz8ACwZ0u+s3UGkBhltn9thfQKtGogYLnPdZ9vsALjTXuSo58XGrSG+LRiHVu8/adzzv5prI6BX1f6EYLneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0RBaRLzGQicfTDNL6Vav6XC7caxzK87TkpkGQKp5E0=;
 b=IIoWl4krJ1dQBFRnkDaUTxQCz6cDb5/XFfBMWF/y5X8Y7fCgzfwgsWwObUVY2f/AyTJPhmHoWz6jR3R52lfLaACQBIKoCrTyu3olWBFcWYdyf2Tgfw1Cu35qiLvHn8mBbKBMOLFhh+GcQ4VxUgMca0pTZuU9LmcM4Buvjt6pxOTuFrfomklykTRnJ5E8JMILWuybn8XHS7Wm5/h6PNKKfwaFEvU/C76yaD655Hw54Ao0nJZWLGB4rapLnQQe8rfQFLHRvzfXhI0YNiHKvUYBy1us3iYYbJdEvfC+ftTEJ5ahHAJg5bhvevBZhzM2Ezxkf1C0MXEsGkoyuU5FibQR+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 14:13:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 14:13:21 +0000
Date: Mon, 16 Jun 2025 11:13:19 -0300
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
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v6 13/25] iommufd: Add mmap interface
Message-ID: <20250616141319.GG1174925@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <c9929e0c9ec6f3f6348cd0c399d6fdfa9f35f973.1749884998.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9929e0c9ec6f3f6348cd0c399d6fdfa9f35f973.1749884998.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT3PR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: d685bd95-2b19-465a-64ee-08ddacdff2aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rq8tUzl8RX7XVKDPYgCC+a0rm0umlzLHdSyrHI+fhgSl65YQ08GmheK0q4oP?=
 =?us-ascii?Q?AMi7AzhK2ITrVKL//RZYYLcwJXTYwF19shsntdAnmg3K7ni2Rv37qKWCxvl2?=
 =?us-ascii?Q?6txdVgzkNOn6x1guhB0jRKbD06FVMBCaF3uGCNz2dHyfKWAdW6FguST7/+Xc?=
 =?us-ascii?Q?UaKtZ1zG/qrKWuVFjvKT4OEa15e9/1G97KPUliMhIxVcDfQsJVFcsQ8xgNT/?=
 =?us-ascii?Q?xSHUry+Q0B2XmDMJj58ehI0OBLBJ/nkkz6jxUyZYplYJTHgrcfFve/2PhYmp?=
 =?us-ascii?Q?9EeIEuZy8wuCL4SxKAUUbD7rk8mjS4nBYFhPAz+dUng5Sq6RpgYVRbeI3ObP?=
 =?us-ascii?Q?yMn1jksw09zxNCR8XJVUzd5HObSYlj8jNjI+kWuL7aSVh8AtsBrawb9+XHdR?=
 =?us-ascii?Q?h2mJrxLL+7ZyLpHQreWVFUOncbLRJUZjR2HUsOGQzyGxi477VOdJ+tExGQYm?=
 =?us-ascii?Q?Cxj3sYP3BfODEwafstzoUIwbY2h0N7k/IdE1Bw4XTAlPpe3/wSWQZUaOqd9w?=
 =?us-ascii?Q?4nHFmHUi63RXpJ+KMbM9DaQV7n1YKspomR1S/7Bu3v/kpq4vBXvKlye7PqEJ?=
 =?us-ascii?Q?ZPrutXgIqaHjo9N9MUmhUwL/ImVBp13OxWCcIB29l8LWZUbffIAWqrmMCqJt?=
 =?us-ascii?Q?hk+t24SZMt121eBpgiZMlauTofpGn7Gh5s5AOz6s6HlsTe2RKUPgOXgJya2R?=
 =?us-ascii?Q?24AV/KQPdm5t5aqUPOG4YXiYCflMiFzcZKRTD2Ru4u1bn1DGtzGqGgkSWkGB?=
 =?us-ascii?Q?lANehdcEQ3J0Flg/QgHeMFvo83ca4AW+/WisZVd7lIIJ7x/i+tUMZlAN9OV+?=
 =?us-ascii?Q?cdJb0qSSYNh1WwVYQH0H9NEhdwhReqDitH2Nw17okQemh9toOJkm/nj4LgFp?=
 =?us-ascii?Q?0dzY09H/AULZQ6V6s1uK9YH17fjk+xwcGGnnsd17AAxqXflkY18ltORCTuCp?=
 =?us-ascii?Q?Xi0gyi1zd2MfVJ1GIEGsM9m+OlprEatWbyFJ+dLUGX3A9B/q3evmvLBOBRIS?=
 =?us-ascii?Q?YBxPOxWI1IYed7g2yy2QPPRHnmsXlzK+l25sZ4Rs8z+t1bIkuras3TYn0ipp?=
 =?us-ascii?Q?s+r5dXOjDF5P154Htf+0NuCmISwAt2UZ2XpP2ukoxi7pYXtXgnV5CTMw/prh?=
 =?us-ascii?Q?UiebbA+oTv7Z51Y/HCvQxMe+xFgdhubuR0f5s27MELopAc80bH9WymfTJvqY?=
 =?us-ascii?Q?/Gy8FdcPkEIWzlgiTto3Qd70c5r3rXId6elN6hyh92uvTlnU1QrTOswOUAGs?=
 =?us-ascii?Q?oVTgBoeLx7CqEcdtAUfxCL2YlaFGPJ7x+PLXFG2jdgMjgZcItzy8Zf6crlp4?=
 =?us-ascii?Q?cd9M7JJKUp0yFyCfkOW+OppWPQH7LrjBkVssfTm61vpRgHrlZK041Dw0L4ov?=
 =?us-ascii?Q?fenyoNyZwUxxAAuLXNs1bgeid4Lo+31IAZ0a0j5nJWEEFFXxaslBc7CjaRVM?=
 =?us-ascii?Q?2frWbQNCNVA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LLhP/k6u32FjoWb7AUdFX/qyytIgQpIvesj5xckFFu81leoy0MdVv26np77v?=
 =?us-ascii?Q?+iY5/uhBuyZX8ZCTdo3R60hwJpqTkwpHUx50xSss/twn1GIYoEtfBxUN4t6Y?=
 =?us-ascii?Q?9yKRXN5B53nw5njKos1e15WIwxvQdCNxcWms5XTfI8XQIR5W3OMd5iGYPOj1?=
 =?us-ascii?Q?blMJZkVmPIc0lbWQ0KuEEv4BkfgExo3FkYCcxzAyx5NMkPBPlpXQpAvubfYN?=
 =?us-ascii?Q?3YiWhFEh69DpS/+0n2JGWtzsz+Yc/zG2IjC/aRH6plBeTD6PQ9GoKe4e+KEK?=
 =?us-ascii?Q?gyyk8eUYmU7Sg5allb2mBBCOJ5TZ1st0acJKOdn0KaHb5Nyk7egBxTjUrbDs?=
 =?us-ascii?Q?VNqezB1JlkkudIhGhImlML6Hs+nT8X6VA3T0I7AuI8qrTiwA6d9qzEhNEzYB?=
 =?us-ascii?Q?PXl7FAPc65xGmMWiLtssMxV50UbLh4EMcuxqpyk2FSUPprLDbxQIW/whMpZe?=
 =?us-ascii?Q?uoVuDswLNDxn4SFc3pbRk4/19EPWHcIh8zPXNQvOUbyywU2VyY2/CW+C4dNX?=
 =?us-ascii?Q?YRB1DmYxlmeb//3acBaXmM5XsW/HF6uEizwsLF+5OxiR42RoneHzUDBnbtB4?=
 =?us-ascii?Q?ytPerkn7NLzTAMWGlCCs+FVwh4ZglrnUIwrCJaHn9WuowIsFV0zMN6Trqn+y?=
 =?us-ascii?Q?4IlxJNbvMcCmWbc+nc7Fteb46nRmkItyyLE7qyWuSWe6Ny/yRkcnjfyZVv6e?=
 =?us-ascii?Q?NQDLLhz0AcTsNvsEhJwQplM+JHrNATYHI6ri+OD7UAm4+HOGp2FdGy9IeTN9?=
 =?us-ascii?Q?4XxQgMgaHs12d27j2dUPeowiGEn8qZieLngZCKAFA7qJrB0nCLxmiNO4A6dV?=
 =?us-ascii?Q?CrcEZonzSVgZIsyn7Ji2RqpfsZCfxEh+RgmafjztrNFDm21al0MDEyAaje0n?=
 =?us-ascii?Q?ZrmvcYDxIyKJmJWibKDuEDCTg1YdOnMF5wddLc8DZM3ZL+5MDD8JUxmi+o89?=
 =?us-ascii?Q?OshIE1oaly1olygZyIZQ2t6yfHTFfXvY2d6ZT8WM31Jd0TE1nZXOoyIc5Rnz?=
 =?us-ascii?Q?2vYj1o5RL8WCjImUTxwEWjl0Gy0ivO2Dc5Wczo6k/CF/AHmNHw+5iwbDBGMi?=
 =?us-ascii?Q?pYfYZHSa4ljQNxMRx1C5+7MJYpGCHdF20YlsKV1jIO2+S4VrjAFQiaSzLVZB?=
 =?us-ascii?Q?wXHnPYupxOKWfWTJtoIS5jotb+Sx9L3yfY4wd8E/4LGxpxl6cLqxMUoHkUvA?=
 =?us-ascii?Q?ut6Sr0oiGB8baWOEJ/ToICRKfa6rxBWDQj4oQNf+wF2G47wzAAGGC9OQdxUz?=
 =?us-ascii?Q?yiXH67cpmoBAiEmvB9iCN/zw2iKBRWcaAy2B2OzrzKdwzs6E28aT1jZPOkBN?=
 =?us-ascii?Q?iQ8zqEBppPO5ck/9hPpBPEzAe+p6gt26oWcDrl70Jbwfry40n3i+m3KAUSqt?=
 =?us-ascii?Q?VgLzf8Lz215T701w9gyDT7EiZ9ct4EbmDcwiJcfP1EI/qWDuVM29bWvfUT37?=
 =?us-ascii?Q?L5SUUFqqtM5RKEZ4MHwnJ85xXIPIUn4IJtf5e31pNjBji9ulX2P0V6/6hyv3?=
 =?us-ascii?Q?nfAO/3JBM85R33sexcqUv+4iVxt6V6GgOIOFoPFo2Ex5402YPEdyaB6tAQva?=
 =?us-ascii?Q?xi8euRVCkioF4X7c2KeeaZWjKu8bQ/nbDwcyojZo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d685bd95-2b19-465a-64ee-08ddacdff2aa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:13:20.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWLeTei9eaHP72AmUR3tyskFjXG1+rmQNTsU9705mK6cAPca506r9ENNLtiHk9X1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605

On Sat, Jun 14, 2025 at 12:14:38AM -0700, Nicolin Chen wrote:

> +/* Entry for iommufd_ctx::mt_mmap */
> +struct iommufd_mmap {
> +	struct iommufd_object *owner;
> +
> +	/* Allocated start position in mt_mmap tree */
> +	unsigned long startp;

pgoff_t, looks like this is already in PAGE_SIZE units.

> +	/* Physical range for io_remap_pfn_range() */
> +	unsigned long mmio_pfn;

physaddr_t and maybe don't use pfn?

> +	unsigned long num_pfns;

size_t

Rest looks OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

