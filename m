Return-Path: <linux-kselftest+bounces-34064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54208AC9309
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 18:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38924A49DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 16:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35027238149;
	Fri, 30 May 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bndxmcso"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6552367D2;
	Fri, 30 May 2025 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621283; cv=fail; b=m9c1/Lowb0q0wsTjmvXg4s8lwpVNAoFEv78sKeoKcZZmA+6f3fxb9BiZ33rDJULAa0nF8k4OH4FwT6livpooLT/fB4ijzzpC8pT140hPnCmPhk7nhOsug5zbhR7QEfrsv0AqCVMsFsXun98wIOc1pKdi0WBKL2GBVzttMOJdtfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621283; c=relaxed/simple;
	bh=8rDVHvqc6jbkbktbKFm4s22U82V34bxn1oGXRH9zKWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AtGaa822q8EbH6zRynNUaRtAp9waeSvv6MIm/btUPRX27GeNF3HOovoqOaKfox9zS7XkFjDLFGYjLWL/Yd+a86Cj/sOg4yDpoJTi+4gl4Uy85LxGjZo+ROG/gPuISf+e6icZJH1z5bR2vh7tm6pI5dECAJXsskfI7xl9Odv2CEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bndxmcso; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWhwxkxm/MdWPcYeXRzf7XtlYFf+TU2pR0s4OZJ6VaHuG8EhEWMd7bi41cllIgaZeuxy4MOUJ+MfBxsoDCras0B/9Be8WOy+ODv3hywr4tVxcOPIJ1piarnbd+DiMHjBZvlRAHZ2Sn4OzHoaWfW6WDjOwtehEdYuWCiYtEw5vaEn0vj+iuPUrXrPXFEpmq7gwRi9HbqLC8tdq8lLzySHAuVmd7SQaTt8ViE+ZR07g8Zg6IQoLolVX71KEV2dq2h5nzunyFZtQZZUjz6+3ndHcq98fpa+k1JACmGhLNNsitIRgl7FDPzOrUmkpWv23Vbl+2MLhFtV1ervN67iVksOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XMe+gYMSpoxIwtiIcSDIDH82espNK8OGnmEfvtx7Fw=;
 b=goSeOqfCVgD+WqeFZD+cld2dGN1nGHAcmKA5o578EffM0EfBe4D7NFvBfLm5Xe01dxEqDR66l9g7CkHrlpuJpEXmLbvTna4Zs32+3nLnSNiObYXTaVSiqPx9Oh/jJYMgzyTDPyVE/O6+wzuO582L5h+/0RGRsI0s9zfMzjpkGYH718lR2OIO5g7xQJ/sR7oLNhQ+eX7OUBgXq2zWIBmpPM6labGnnlXfhmMwmlYyf4m/zQQRzghAAlvRLYdx0StKE/JIKP6Bb4pjJ+5VV1Qz44a2Bibl64rDtJukD1JDX1iFzBsTXiu3N+FXmI9hp6hPy1z/f0+ewhAhYb5UyBUp0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XMe+gYMSpoxIwtiIcSDIDH82espNK8OGnmEfvtx7Fw=;
 b=bndxmcsoEJkP+Wn3j1LO6/UGtQiCHu+yY/nbls/0Xj0q2YzDqG5vTv2xUST7Rq6kctMWOHiZgGHeV3NZ7+ifH3wRCRxhfYNqvL6ROKR36vH4T3c0P+YD91qsRSZSWgZ6yWkHegJ0Tr5PmzrTmUe01BCa173I/hfGmLMnJ7Wvc96eqPbhRfvwcJB4xlGM3+1GqRDTkqqbwG2rdENbyLwZN5N5MYarsg3kFGLEOsax/w1i0/B9v7s6dgHjIQptKAQLc2d7mf4uUBygR8YkqeQGvtx7vAkeCvX6ySQs7bhn6DqNcA51VFKPI3Q4WJ2CWjSytM/mqXOhz80JG5XeMjCS1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Fri, 30 May
 2025 16:07:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 16:07:54 +0000
Date: Fri, 30 May 2025 13:07:53 -0300
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
Subject: Re: [PATCH v5 13/29] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE
 and its related struct
Message-ID: <20250530160753.GD233377@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <580a36f629402506d232052ddd20ef21ec91d5bc.1747537752.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <580a36f629402506d232052ddd20ef21ec91d5bc.1747537752.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:408:141::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: 39edca38-5860-40a7-cc91-08dd9f9422ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xhbAuWqT4C2dAt3rQ1moSrYgHoDBsJSBWfLB0Ce3qgt4NKWuTE1YZSZbs/fS?=
 =?us-ascii?Q?HrPQaNbsMaiWv4s51j3mlsukio46/DxiARACME2K6XYieJmTvSVQet3vWisX?=
 =?us-ascii?Q?1uxeaLppEWtrj3MoyRM8A5oz9VbBRv8VKGJBzqp8za8jtqe8JLWVFm1p7CnQ?=
 =?us-ascii?Q?CnlMKxiZJdsS7vkLfNC0JHo1QDRLfN+vkl1bD4WEZxrXn4EjAO7ygvf494r3?=
 =?us-ascii?Q?pXXfHrOM5MvH9uiI6g+4Nxa1k+Pjf9mAgTd9wF09JwJfcHKIQQ5n/ZK6g9C1?=
 =?us-ascii?Q?mjqCfFRzkcsu0k+lXtgJW/xbXzdBA3MHcWnVV5iBvS1NUFUXP5tSF1EFQoeA?=
 =?us-ascii?Q?NmJqS+lit5y4T4q4HaPGCjcVTcsjLYF82yty5z5zhEnnaS3CFznOB5dhNRp9?=
 =?us-ascii?Q?rEhXrslTPwbgOg3nC2/IX33vtVfUFvg2H14J4nZW3Er9//7N4HWB1kCn5H2D?=
 =?us-ascii?Q?rdqF1yntgcULr591DF5CDHewnq5+QzrapgO0ayzw6Wa6pl+hqSuJSwDp++mJ?=
 =?us-ascii?Q?eSf66bYS3hQc5BXa36UNuCJAyTV9bc2V4wm9wpyS8TNbSRalbhTCsSX1kWuH?=
 =?us-ascii?Q?4CKCd412FuJX65jHCSp3+ZOIuKFzDDeCFvM9LjlxkgRnq2QdMSOH/+spSPyq?=
 =?us-ascii?Q?l21nlv3B5BGU5HC/hpa/RD1FZmAFvTRxicshaSDFCifXmyBeaTJ/y6JUXSvk?=
 =?us-ascii?Q?9xNIvRhko8ZtK3N712p88rVrEFSePWAPfZMNx5omSbh6NxjQnmgv7PL8+ptS?=
 =?us-ascii?Q?36e4Hj4miygcppalPrADw14l7R9gZtbeiUYkxtkATTN3pv+ESW/H2ejrwtyD?=
 =?us-ascii?Q?1fJlSs9yJBS9JHfilI2X2luJvIryCIfBge6+sUhF/wVORKySowSTnkZ0OiAr?=
 =?us-ascii?Q?9XhhDQRnOHvTLO+2aR7FDn8ZKQxSAQUf4MBdlYxtW51WNIitKVQz1NxVVOSy?=
 =?us-ascii?Q?6Ol7/pCHI3yyC005XBZ/MOYzEA0oVcSpI/qRa+v430XwRHPFOpDCIM6kJGXs?=
 =?us-ascii?Q?QlAgAk20KkUDIidGFOx1rA3Rhm2oRta31QVbeftEcRKq+DGNaWc92NIZDAYh?=
 =?us-ascii?Q?k4p80U7z5LXL9FDGycbz7f25kb7cD7OtpojvER33jbMP2mqXeikcNEUZMZbA?=
 =?us-ascii?Q?3RC1Z4afLhMYr7HDxi/EZAKeze6DhnvISGkJkvBvYuwgThyruZ1lB9zBrtZ/?=
 =?us-ascii?Q?C6JpONzkF1VD2dQDGrJXtBdjVK4p8Woylgfe1WP9TvuPMAkKItDJeTOhoB/T?=
 =?us-ascii?Q?FhBZnCbul59+mL+piURRzFt3yV9sZiHo4NgRR2C/wHUC8jW+XtYhxRi+nffJ?=
 =?us-ascii?Q?abUu+eLJpR9hS1hk2wNUB48Xw1rzVqmT5GIcIBCZYR+IX1zPwgA7LMJ0iR1w?=
 =?us-ascii?Q?AR5wOXayF66605iUT+I7hdUIC7VAxPAeAAKi4cK4Ix/Dop85r66Ee72wxqIF?=
 =?us-ascii?Q?WbCJQVSiQPk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zr+/lDkZmzjdeprSHQs8SL4uD5GauTycyJpQOVNqqVP6RHeB0qlYpjvA6QtY?=
 =?us-ascii?Q?qHLLQUaEAhFPoomRHQ4UazU91IoWIFMg+fjySv4DoOjebJuYZImZ6yOnRVSk?=
 =?us-ascii?Q?K5aEudg7NDHy+onnancW2nNk2YzBc7ExIyS+r8oK0YegecX3TM51G9AIEXYr?=
 =?us-ascii?Q?VBSlt8h+AiMg+f6z92OXvL92lHa+BqqVKZDfJDT0hnLOUSTjsNn/uiaqI71L?=
 =?us-ascii?Q?n+9OKlZbOmDaJkZt4qlgxgKWRSkwMOKKIoK7zn6yY/e3TB4+4+0wp8Bkhlla?=
 =?us-ascii?Q?EClLSD49+JdrJzqSDLbgAwaCV955WJmeF4Yt8LaKPsbveZYgvFSSiZR5LSfY?=
 =?us-ascii?Q?qhjCSgwtBUud+49WXIqZw2g6CyYJZxZlGSjEZhn7m8Vsq7a4X7yA5RFKuzmo?=
 =?us-ascii?Q?Sm34q0nxwB5MpQhGANYmXrZwr81FdDjL9Nt61vaQVy3ZJg2bHNXEXMTKTehW?=
 =?us-ascii?Q?kDgX7zztJm9PmSyRsP5A+fqVAeMojSvzCWo0xTLvnGpt3ajZIW2x65xnUjg3?=
 =?us-ascii?Q?tHnLqy5xnmoy14xND8G5oYjqKT46vbcUTpU3geJIUuPJbV1p+NiAgfaVy1cr?=
 =?us-ascii?Q?RKa7F1CoRKtDHElrDGvt1wmRXp2QklAu8edxZBqM4uvwNBALFsq9d1fY0ELQ?=
 =?us-ascii?Q?eVI1zbhrN7AHSEfi/I6rsL9WaP2YLUadlZR+gp0Fli6VCV9bnsf7+3wwI5jn?=
 =?us-ascii?Q?7PTXCssrrWe8pL6fkfojNJLOC3o+nVClehV+3ysgYtxmWdEa7/DIeLZ4l3Tq?=
 =?us-ascii?Q?Ulsnpr3RL02dDahxt/fgkEna2QA8cgBakLBR41znU1AipiEOro/iw8Zo9rj7?=
 =?us-ascii?Q?j775Ah8GImuDG1bJjV0FNcPuejv97BQGf7i/R8seBPIL5LHeYy0aCJ7mfWx/?=
 =?us-ascii?Q?Xf7qUs29K6Z+BOsIG8kINgxvL98n6Ojh3J3W6qjYiufE8ahvpQRwxvJjhCzX?=
 =?us-ascii?Q?jjcaWzz4OWo1aVpEvX5E6KH688Q353MDFGtALCG8CcLslNuhIW0LDR3G/M+j?=
 =?us-ascii?Q?nWaWHKsB9yTde4qlRMcD9WI/1y7xO1usk+7cNQXa23c5qE05V9ctKQ9j995X?=
 =?us-ascii?Q?57SpBFk4hfYE8Vn0zXDloXD+qMKPhFBaMFWiRQKXRgCWl2zfP6+/Sad/s+su?=
 =?us-ascii?Q?Y0Ss0PruUSD7w9g0tdi56R4ArHvty9eGSIs8s6OOT2J33qxosdk7ai3cGVVW?=
 =?us-ascii?Q?4w3UaOqNaaTSPs7wXOj9AjODajOC2n+2AhPUXKn/Iba8x/c4NWBSCkGwgYof?=
 =?us-ascii?Q?JPKtf4wtP2DBLGYYLmhz8LkejY8kBg1KC6L6zrEFBxehrgXH924FbxmdSo2L?=
 =?us-ascii?Q?gane8mfSDp5/WyIi2MqcTENfp9mdNyRWho0haPxvDCe4IwdW0lbAIHk1txNQ?=
 =?us-ascii?Q?SxSfHNCscIJVCeuXqqXeymU0qxPwYb1EVv9oq61rMFVhXgB2ofGxHRq4tQRy?=
 =?us-ascii?Q?3QsLwV9P0A0ww/zzBRikPCelT9HN1ojqE8LjxktSuV7064SWHs5ypW/3Sss4?=
 =?us-ascii?Q?Hsnil8SPz87oHFvLRuktTJqNSlHVAhhc4eXQ0Zn6X8MldLrO8/BfSf4KGOqr?=
 =?us-ascii?Q?UkY0jwkre3dj/iAPz2w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39edca38-5860-40a7-cc91-08dd9f9422ee
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 16:07:54.8619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Opur+jK6UiC8x2nhgW6CX19kQShO/y0zPeMk4JwoICm0uyB6zkuGmW8tq4WOb/CD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209

On Sat, May 17, 2025 at 08:21:30PM -0700, Nicolin Chen wrote:
>  struct iommufd_viommu_ops {
> +	u32 flags;
>  	void (*destroy)(struct iommufd_viommu *viommu);
>  	struct iommu_domain *(*alloc_domain_nested)(
>  		struct iommufd_viommu *viommu, u32 flags,
> @@ -171,6 +200,10 @@ struct iommufd_viommu_ops {
>  						 struct device *dev,
>  						 u64 virt_id);
>  	void (*vdevice_destroy)(struct iommufd_vdevice *vdev);
> +	struct iommufd_hw_queue *(*hw_queue_alloc)(
> +		struct iommufd_ucmd *ucmd, struct iommufd_viommu *viommu,
> +		unsigned int type, u32 index, u64 base_addr, size_t length);

I think it would better to have two function pointers here than the flags:

 +	struct iommufd_hw_queue *(*hw_queue_alloc)(
 +		struct iommufd_ucmd *ucmd, struct iommufd_viommu *viommu,
 +		unsigned int type, u32 index, u64 s2_iova, size_t length);


 +	struct iommufd_hw_queue *(*hw_queue_alloc_phys)(
 +		struct iommufd_ucmd *ucmd, struct iommufd_viommu *viommu,
 +		unsigned int type, u32 index, phys_addr_t phys, size_t length);

Jason

