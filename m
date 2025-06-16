Return-Path: <linux-kselftest+bounces-35080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E86ADB3B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A6918912C0
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 14:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1E725A33A;
	Mon, 16 Jun 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NONX9Zqt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2FD205E25;
	Mon, 16 Jun 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083558; cv=fail; b=ah2L7UlN1V5MH7frBgLOE2wYuC/xhOSfO82DurNHckF2cVJtO3JZgBQ0X1aGiEBQL/3ISl3lrQJD/EnQi3lIzIKzTQKjIUmSj3gfZUyX8MBnwJH4TjyAA2oB4KFRS5mZH6fj9P/93Tn9abQPVfOELTlygxOSSMmhxygUdu2CwNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083558; c=relaxed/simple;
	bh=EC8baE4Jf18sk/i7oA5soynPFaNmz7ReYoO+z/JmYPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B049+2vGDlweYOah+ZGQ+uJABS5LDsTqkO4jilgy1zl3Tt0DAdPqaHlUEOaBhnl9Mzz29gdyGgQsmynI3Gg6lSOjKFMS/8w7cu3pXzDKoMFTcub3joW+Gs5VnEJMTXGve7lIXJ7/8C/eClE80TFZgkCmN1UvtvOpYbFzB9JcI0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NONX9Zqt; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVFnGTpVkFjw2M2O1HbKnt931dOvnI9MAkMgL/2Dk4Np5vGf+92brVrwDfgy7raZyBzbjwHWdo9GztMNSREVHpxoKImzr16SDDOfS299ucN++DOdcsGQghIZ/cFTJQcTqQi5kMBEn3Xg29b/PaG4n4nBtLA30SCVI8Go3hVG32MF/N2d/o9bZeSHCvVA1GGFQSMO96D5cq9klDzi074lT5FOU8t8lNI+YPbRS9bga8Hhg3EmjfNtUSKTc1BNKTC1b/8g3UcZzF75YMFZEy2C9Ok5+oDxb0X81osLvpy60QylKjot9lSLgmwxNVvea6eJUPgWfy2RxMPbCHEzI9MnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzN3mfTuKadhGPj1abtgISkEJbHZcfaLlFm9R+vUuws=;
 b=E7ume8XQ5xKOooxCd3A8LtOhB+MBD2Mnv7CjuinTkoOXI1ZI/MYk0P35s5uzr6ywpUgwBbflcPDMZqOti+/rv2kbYa1nAZ8QMvnDCmsBAJFOdZGT22ExHhq2rKDvGUpfDT51Alie682x4FhG5+Vxe41JT/yVaIoGmFNMgGjKwiaMjLJnm54MPQEclBCq+QvMDNFn6l0gB/98s54sgBFJ1myHcqdWhT1HU3Tqe03C+C0rJFLLUHs+u00fzsvqVPkyemILur4wkPG8D3RlnMW2E9xukNoUNn0iWsBAeWieSmp16N4/B48daH8w5Y6LTCk9dbEubSEkd17ZKDOcHQ682g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzN3mfTuKadhGPj1abtgISkEJbHZcfaLlFm9R+vUuws=;
 b=NONX9Zqt0BiJKuBmb+6VFV6BSDaYh4IhSxdmWIEM2mYZvnPhsIGAbsDioYDqatp6XIayOspx4o6FzKuq56GCQwvKo2NwE3bgym1VvyrsvB4+9CdWsyzGKpCw5/CtVM/t5yHPCApumdHq/byTpL+zz5ijbgYpXOO8j/LKfC4KyITH/E3eIdoMSxaWFHjQVfyFOlmbb/Gk/ZTt1kIyvSacu4gSTOCVIbmFgm0fAJpGSwbrIuUp1gvwikKxzU1pDfqkI4Clw7FRaN3YDp9EXn27QH+NHMfB9drxmDGU7WilLZ7cxMowLcN7zBqMJKQgeCM1GKhsKcdfYt4mIGd2PpO7hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Mon, 16 Jun
 2025 14:19:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 14:19:12 +0000
Date: Mon, 16 Jun 2025 11:19:11 -0300
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
Subject: Re: [PATCH v6 19/25] iommu/arm-smmu-v3-iommufd: Add vsmmu_size/type
 and vsmmu_init impl ops
Message-ID: <20250616141911.GI1174925@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <fec2ae84501938503d892ebe80ae332604c57b6c.1749884998.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fec2ae84501938503d892ebe80ae332604c57b6c.1749884998.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT3PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 77dc02fb-8d75-4605-105d-08ddace0c470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l9X+AIgG0hNWMn3/mpmv5mGb07ByLi77VGp1HLp+ApBBdBQeOEcIoSc2VzkQ?=
 =?us-ascii?Q?LzRDYkXJQLdhgcCXI3p7UrFvU748T2zV9uDuuGSQpat5SnBtpYZqGSf/91vx?=
 =?us-ascii?Q?t329cOnoo1DR0Ox2cdgURU4a0fgc1M63FzoJCUJb+uHqHJO+OwC1flXE7wpN?=
 =?us-ascii?Q?SQNKrBd3+PKPHmzQb7Krhdz7ggekCFIEo4zSnrnt4J846w8TD5/RfHb9xAAu?=
 =?us-ascii?Q?v2raz/6pqgj5AfVq9x63OA8NquuoNX3Tz+sfk3BgZ+SN2JyU9crHr95ll3TT?=
 =?us-ascii?Q?ervoUzfS7NMKhDTRqWZPh9Tvl+y64pieZrup41wjk/YXe2JQtgswbgdeSGW/?=
 =?us-ascii?Q?34g0CeFqnP/9/eHD6g5rr3xTMPF5r4faAIGGLhJEpQk8xAmvg65Cxq9fCF8l?=
 =?us-ascii?Q?UXjYkuZE7/WqYw6tvdXFPPKXb6sGAW7f8cnfUzZlhjFxk4s5hnEXmhBRioST?=
 =?us-ascii?Q?D6KB5TOWLxhsV6jyW0C40M9lrsorLFPs5R6vgWy3iEzgMzL8kfrae0UQICSU?=
 =?us-ascii?Q?xk/5Vhdq3+1esTq/vjN1Gpr0QyzKRqOhhQgQTfB5P+tq7yo2keyHV97ovCAF?=
 =?us-ascii?Q?OHJfnJzeWL8wSPtbIqVa/v/oiO0qaqf8p+ohIUp6liCiknG8LBOriGgiyj82?=
 =?us-ascii?Q?NT6Fzrd+I4zNCb8ttEWJXr2+oirgWHlSHSc7zrWCyR1LVE1I22cR4s301Sma?=
 =?us-ascii?Q?96wJ3Alk3CSAeoLiib+k83EQGckSeHG3CGch8xXU5BZXBcB4nNHUCQOdFW1j?=
 =?us-ascii?Q?2FGSP+xNcRDVtFtzvt3PgJfU5RW0IMNJ/se6L7Ydk8qHuNHND261j/K40tq6?=
 =?us-ascii?Q?LgZbgCbyfzQz9qckaWZxbn94Ee8FILMItpEeo0hv0LxXr+uBQQpgc+RfL8x/?=
 =?us-ascii?Q?Tkw/SVWdq24Bqbq0TiyAGki7WKgAUnCo2c4l2WY/rAA1QCDLdap8PRy8mn0u?=
 =?us-ascii?Q?9rzUZF/3Grf3KtMBz+x25mwttx7oF51jTTDyrK7sZQVhhAyMtwdkA3usZm7y?=
 =?us-ascii?Q?a9Di/uHURuqE4Z25+QR2yDubOtvFCbMh/jxefvXfA+2HWb6e5FTy/KHA9dUJ?=
 =?us-ascii?Q?pNnL/0ksBzFb3BI/0J7I67V2WCHXxOiSwsxsNj781RmmF9MP0CJtAMWOrPX+?=
 =?us-ascii?Q?cThYuJjDcXoT4V+eogqMWRo7N1s2E2xiISQn3tRWRxcg2htyU6cO4k7mJPdJ?=
 =?us-ascii?Q?vEPiUl3CyW1kKVySzJ2LIp16mfh1i58WFbCcGhmmS6v5wQnaYvUfdXavESGT?=
 =?us-ascii?Q?qovoVXufFPE+u6lVT8M/EGMMi1neLeCBJpFFUylMyT6UeyDqOUVXalIiRstu?=
 =?us-ascii?Q?vp3U7LdFhOnwiOM3zcowcDxM4T6oq4kXJAbVOCjr7nT+hD/J8gCXQYHwd6bt?=
 =?us-ascii?Q?yRYFjidopR1vLar3Y6AazdSA0bvGtxyfH5CIvB4f6sqlr1LVrQm4vLGcHdNi?=
 =?us-ascii?Q?j/QTBy0BIZE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xXf+0YIIZtSvlgNtscl+dU95db70kEKaO39pB0BwWJJi0OlJERi5mm82PFXK?=
 =?us-ascii?Q?7tctDcKzi0OMEjSLXiuxFQJZUhNDx1QyDC6Ee7WLNBtfXDZBim/Bjt51DLIr?=
 =?us-ascii?Q?rh7Jpf46LN3uXNrv25g16I4xx8Rx0IgwLcGBD+GgXz9tCA8KbX9lTs+Nv+kR?=
 =?us-ascii?Q?B2uVdcaosISsa7lWNaGYvkxdexX0CtvxBXkehSEJGCijB036c+9d/TMzH+Z8?=
 =?us-ascii?Q?h5UwQtrCgdAzvO4xl7hD06ELyUyScR/b9hJrxGCdyu0XtwnbyydsMU8ytQHf?=
 =?us-ascii?Q?/PD6mho59e7+8eLSTvoWYlHkLJt22JNhXEsxwHunDxIMXXL6LlnZWsEItVUF?=
 =?us-ascii?Q?kaHUzrYPfkJWKB3rrCvI5M2PD/lqIjmy7yfEsPfrYWCuSzk7ovBPFMdcujUE?=
 =?us-ascii?Q?E/hEzUuZN/W8biIQihba9o+Gok/kt6RW2e9I3Nsr06joAPaS39Tzwn9gXuek?=
 =?us-ascii?Q?BRVES/EZNKLDgInnZmAF0QCRQuDAyWJ6Xnqofztp0xNy6nf4tAJsgAbUmcf3?=
 =?us-ascii?Q?DsAa3zS9jrS4wd1nnPGG1/0EMWcWNJI4FFkCtts1sefO6JVFn/cLiBeoym2u?=
 =?us-ascii?Q?E0OrtoO5CZ5uu/ZD7pkGnOspl/Mp3EF5hWFrY9Mmxtb1cwhm3lIlJUT6PRgW?=
 =?us-ascii?Q?PV7tJoehhZWrNItvyG3O65F4k/l3fhs6dzyPk68h385Yspsq8ywXzgOzyF6p?=
 =?us-ascii?Q?LM/VUDtc/UI/KgoPbC/CuGcEgJ4UjkRzO6hpqp+6Y3SoYA6hUnsZi6I8JJ3q?=
 =?us-ascii?Q?dhuoanXW3fi/9AGeLwyIPFU4n1hhI78z+xVQGW5ULM3Z5zoAprozWGEOW1Au?=
 =?us-ascii?Q?YHJEmM/YBv5bmjzuK/Ip8nxApnJE5df+96KSbWlzE85VYRnithluVDsDsni5?=
 =?us-ascii?Q?U38FFxso1UAY2uViuPogjAzS391ZoJ4aKeMHxgnBADuQdnJvBTib0MyjaGRj?=
 =?us-ascii?Q?opMUePsKXNbv7VLd/justXmmZbso26bhiz9f9grMGPPaoZ1DuHQEyd5W4suY?=
 =?us-ascii?Q?h6v1S032aTcqFt/7P2mo/po2c/jn7MKFhKPpT+mHkorgoYitwhXZAsd+E7gl?=
 =?us-ascii?Q?w7JxxahCeYAQWFCq2SfEt5C7c69EU7WSuwJezCqhDeEI3Y3WgPhBa+0hsz0q?=
 =?us-ascii?Q?4hc6THi0gqfjR5DXM82ANC+ntGd/+XWnzevOOucKdnuiA9P5xZrnNoluDcfp?=
 =?us-ascii?Q?Cvb7by/+Dy3D/lgUIAhbefm14RKElEXiQDk8bk8E+EuDIKEzljS82Qf2KjdS?=
 =?us-ascii?Q?ez2eI+vZxGMIzXgjv6/jTH0jHAYiQfUHVxPC+ESgx3VShkTMCVXOnawrmMF7?=
 =?us-ascii?Q?a2JOHMtD65wk0aeCFoNiUtHUhfT91J5ZfER3+r+Xf2rOLvCUUkctOkkDVP9W?=
 =?us-ascii?Q?zgmWNabaFxD5S/UyavydE65tk/RzKpnSrWgFQRbiIqBo59q2Lrfcw1jqtImt?=
 =?us-ascii?Q?pLMKNikvylEOgrVcUCCl6wUXRD3zw3Clb0gOydD36lLJi9ppY0BrnvFlGdgu?=
 =?us-ascii?Q?EafmHFgz1bzz+77SwoIPVNprRKyWbCjY1G2CWr/ER9Tnxef3KQMgHND/YUfm?=
 =?us-ascii?Q?tkDjg5AT3LR7kqXr8lNtuENbDI+mjpEGb4qe3ImW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dc02fb-8d75-4605-105d-08ddace0c470
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:19:12.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOAuCvYy5hL49GkEX3T/11tyz2M19yk2sEb5O2EsDtaNf+HhtjpbAJtopT7KK3/1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716

On Sat, Jun 14, 2025 at 12:14:44AM -0700, Nicolin Chen wrote:
> An impl driver might want to allocate its own type of vIOMMU object or the
> standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3 by setting up its own SW/HW bits, as
> the tegra241-cmdqv driver will add IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.
> 
> Add vsmmu_size/type and vsmmu_init to struct arm_smmu_impl_ops. Prioritize
> them in arm_smmu_get_viommu_size() and arm_vsmmu_init().
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 5 +++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 8 ++++++++
>  2 files changed, 13 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

