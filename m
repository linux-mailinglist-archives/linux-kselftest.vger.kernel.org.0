Return-Path: <linux-kselftest+bounces-21216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B905E9B7BB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 14:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8F51C20A99
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 13:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E078D195FF1;
	Thu, 31 Oct 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eHbysi8e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177491C6B8;
	Thu, 31 Oct 2024 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381431; cv=fail; b=drAwFbF9ZezZ4DmWOeYPZ0EH5KhsI8wV+8RVmjpqw6aJnQXKUzToISin320o8irWnHlrlKRuDe9Q2Ujl2PAIGD8Adsdd6LjO2YA5gnsAlWF3amx2383s3q7JAhZh39kkh6vW/z8/LgCCPnbIgsCNLfYOTMRf/DmynGmS70sDCTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381431; c=relaxed/simple;
	bh=K9oKbElIz4JRbjg9u/+qVy26nn+RtoQY37Ey09FDfWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k+OJG0Ye3rnujjLTTYDVa7mRHPtK4NnctPx0l4rIRBKyl3Dqqbjy+0pEZ2/ocLKy8MEwLNVxD7rcVST7eo8cRpZCw7txHy+XQxe3noxsL42bb04OOE6yuUxjm88JNlTu2vPxTFhs/P3nza6K+AuvmWLqm583zw6VxWhk//MZe5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eHbysi8e; arc=fail smtp.client-ip=40.107.101.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eELcUy9CK4xXpoCeq2baioeR/CVyAN17LKRj4IgEUvnBpCv4xPRe//FoZnb5LRPPPeevKQ1cEsfrTWxJoTtpRuW2TjAsYHr8kTMpQBbcznbVw7v2VvLRxXGUOsrO6NKeT5KwT4NXAtnBc6A/LbSUZMyLcQo5rCVELwDfDLRbdteQ8/f6ZvaZN6j24+14pWw3SQKKyAAxt5yc7B5cCSyC+e10VyHIsXzuQhMgWFctodVLBsBERjo6wuInjUKey7kd5qZwzQmbFRonUpDhNvq9z7gGAVFY0HGKjPeVigg6cAxMwMANG+yj2qYVSKdFNBxXHeZnCI0uSUaQ4tuhnEGsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqga48FKvh/DMeFTPpXC68qiiqT79WO3X3I1louPmAc=;
 b=qIlyhWtRsVEz7noa6s5PCvOFl7rOEzht3rPvLrOR5AreLhnAMKX9dh1MNovE1J8JkXteDrBOke8mzsucum3AenGEwYPEU1JRuPsT0lk7PJ5aOK/KyTAhQBnLxWrY5OTyzw0vVOw3hY4AZPq8Vt5UXIkYSTHub02+F7YEMNZHTes0MB4sZdLPw+pcLHfD4FYbePcdanypd2B9FIxR4dX+yKZJkncYKfZrNgwvOuvoigDu9XaEc9rEvCEIh2omXpTEATkr7GTfiGnMjuZXHNxiDRopxxedhEQ3MV8+cKWZ2fql+AmTbWPRAQMS8n05nhqXxxZ5jKc4rzBKAt2bI8Rcuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqga48FKvh/DMeFTPpXC68qiiqT79WO3X3I1louPmAc=;
 b=eHbysi8exKjUUyvjDyuf61MseSmW4Dxitx9C183SRzZRvNg1TeMNA7xUYLYXq324O1XRqn64yccqRFh5hCtcStFYVxkBC5v8g+P+TBOjigkaCM99F5oPz3hcm7YVgAxX59Po7t9gqTeWZzUzfA3Y06L3CcyMxR+2bNrA/Kts8tTUNujhQj2UJXWsSG6ZaIPBja4XxiKQ4TIorMl5kX8eHJH8cPOhnPbs2eM5kVOzUNDbz3ycwUibMlSefGOeEOx03k0TieSxesLlcUtd2+DuE88/bpBOJ1QEOySgF1X85wBhAMjj3REsVrYZSKU/yhxCg47+11Bh6ifrKPlAdEuAzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Thu, 31 Oct
 2024 13:30:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 13:30:26 +0000
Date: Thu, 31 Oct 2024 10:30:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 06/10] iommufd/viommu: Add iommufd_viommu_find_dev
 helper
Message-ID: <20241031133024.GM10193@nvidia.com>
References: <cover.1730313494.git.nicolinc@nvidia.com>
 <3f0240cf9f2169750d929ecbc8cc658ed5bc3734.1730313494.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f0240cf9f2169750d929ecbc8cc658ed5bc3734.1730313494.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:408:e8::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: ca9bd530-bf91-4cda-d08e-08dcf9b02dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4s2ao0bKZoU8EYrEyS7+sr1FCbf6EfdOSW3wIpeKOa0wgRLNlk9plW7DxqfJ?=
 =?us-ascii?Q?K8t86Bm8bv59Wep5Wrh+epmIGky3y2ozT5f7vYRWdt+9GorgIuNBL71gizPa?=
 =?us-ascii?Q?fbOKhXE10hmBDp5XK2RH3vQq75o4NNI7PmhLU0jg0upeaIc2VSmkMFfVdu+g?=
 =?us-ascii?Q?7sJa1U9XtHFsq1PKA8aLa7p5+0PDtplHnBDeJ75+p6/1Xf+f8Z+JaT1aLFAr?=
 =?us-ascii?Q?35AAv+oyy3thoMnpcHh2FQNPG8HpcO5GN8LfJB9V8Yc7HLTdaNW8i4vP/ejI?=
 =?us-ascii?Q?LeFQY7bIjZbqqojAS3DA+aDKn7iVEiT/KcQpMWgGp22kkGOjB3JKXpBoHVDY?=
 =?us-ascii?Q?tqfZnkqhVx/j8ujnR+I0nGSJv2lZU68MdiFteb8sl0FQ4NWNUGKZzon5s+8N?=
 =?us-ascii?Q?ppI/U3kz+sBD2Oun9yNWLBNDMyrzodOaEyz1dMwuQ5AvGcif4qAboFakd4MC?=
 =?us-ascii?Q?OdVAqnD57CHXQb6MS2innP4rzqvk1wMYnwulPqwMxJ0ImYRi/FHcj4m7zAeD?=
 =?us-ascii?Q?xZQnuwEcJDRazEuOqO1BbOg0SeX3hBz+bJ4plU7tTrJ++Q81ECbpwrAYvnLw?=
 =?us-ascii?Q?OJC+RF70+XSISsWGLfaSbnwD/nfLvweY//hnS2i8SyFW4moNXgLLOu0xqrXV?=
 =?us-ascii?Q?LO+UTeBB/tYBohk0uCwq5WAX+HinQwzbWGxDesjFcObVhrN+RqQnt9IsLtqe?=
 =?us-ascii?Q?5NC9qMhlLbVZK5pXnAD4PxQmkFh6g2kBlWFVLXIbrtEKA5rNxkyoCJI7e69L?=
 =?us-ascii?Q?FA2zwsyr8bVZAy2hMWQx4RkKIPET/2dMp/wFnjD5vQ1piaKOhrKgoCV6uKon?=
 =?us-ascii?Q?E75pfs6tkGDn8N8yKaX1PxKns6cZzl2fSyHo+cgtnGghk6hrborIw2IRbi6x?=
 =?us-ascii?Q?avLYWcSXY7O21g+0rY3LeD4nt1buVESSQbiKU+pwOXVOQtBjLoHLtlqoCctX?=
 =?us-ascii?Q?ckz55eISy3pYn0u4NyZxiEw/6hKKGg4q9L1nfcFntL8ysZxsKBfD8uwrKmL+?=
 =?us-ascii?Q?uOZCVPfj1GaegGASTCY2lzTdYwRZ6IvgwcfNpwicpBdIpStfJuIwMgpRiTxd?=
 =?us-ascii?Q?rJnO2F2s+n5Ns5RoSq8ck5Ky94ITjxrb/DRhrJfmwRopoDKi8Iio7zYBgkAy?=
 =?us-ascii?Q?LKaTasUg6ZEkeuTjfi1KfKUDwoIw0orfgjAzfNItyZWipUmGT7ncxRxwYull?=
 =?us-ascii?Q?hW45ABkbvZraHZkbt+AiZ96bN1XhXdPc/+GDB414cNK3lnLjNFtc6x0pe/bM?=
 =?us-ascii?Q?NWSrA1JsKSxAFZc86n2w6Lh2fku1T57fyglKL4mgdu9qMktYB5GneQxxH3ob?=
 =?us-ascii?Q?CFCd5jug8cmn73eGClhh+M7f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sp6ktlDhWN1uG9zyaHPvqxMOSLRHOUl6YuC+9hWy/2LqhyuxkEVsQrZBkDtu?=
 =?us-ascii?Q?sShcOAQaLGffOLWwSovlxQqRkjo/gY+42sfHUcCdJ1r9QLbf1IA4Kl30bh6V?=
 =?us-ascii?Q?HC8I5ZV8Snew83oGJklZPqxXuhdnXUubCASfLvvaf+fyJLRksd4mwJNd0/7k?=
 =?us-ascii?Q?IPsLqIiG7WQ7/EcZeEvxiKQNHwevRClCPXYg0UCFo4MkvNVRuoQsggR8zQJv?=
 =?us-ascii?Q?zx/7PbXZfLf5XTk4wdcVNC9VglpmxT2qvTPrYFrnoM2gS+rmwVFy/LagHf9d?=
 =?us-ascii?Q?PaACa6ekv0nhtoRDYluauRwnQrxzT6RzIaW0qyrlHN/BJPKswEz4fqsB2Ac4?=
 =?us-ascii?Q?XFM2mmd9YMWb6oDvGgZ8nWwHIGZmpyC2LReQsoftq7bHgEDlI47OXWEaJjbs?=
 =?us-ascii?Q?7aTF6cxjVOs2EfacxhFoPAxtIzCATltPwv9iA5hJuylt/jh7yx2THGmB7/tQ?=
 =?us-ascii?Q?AEM+F4s12pCo0uz73GBoSa3az9WZeOz/69AvSdQM1Pc3UXkRVZ1BKFopfr9s?=
 =?us-ascii?Q?OaGF6Phynax/Ngm585TGR9D8R5m2Vv316otfVr8lwIptxg3fUCji+9OYIGxi?=
 =?us-ascii?Q?vIOvHURcHL3uHufbHbOpOHlRIyadepGP58fYOrum7IiyK4H0/yvQjQEEvX99?=
 =?us-ascii?Q?+VhanV0vOei5vclZZS/nh4GyXNatxPZiqnZrd9vjz5ZXio7SjjGnQN7r6O0C?=
 =?us-ascii?Q?aOAvRuf99HDionuP3bTaMeSHdsyf2lLu8auA67tLH1NRYuQsIRfZeNO/v3OS?=
 =?us-ascii?Q?I1JTy4oDziuAuYXCFjov9TZtc0d2ugH22dPMWi3vZhk+rupvtgJSVcqhQthy?=
 =?us-ascii?Q?8RRJ8BQYrNJWrOtORDGGRqny3J/vumpU13qBgfon3QnPDhV0g4EA4tKsFuNK?=
 =?us-ascii?Q?RomZiCRwH9yHM8p5MYlVumeGiM6hz9NPJWgZAKFQhs06KxcsRzG94nRPQAwK?=
 =?us-ascii?Q?YtVdxAJTf4L30odUEyI9sSH7M7k+JEgrZW2+caZAIuL0DyLBfwpx/XieROwA?=
 =?us-ascii?Q?fbKeKvUGo7X4B/JP87+dpI0HtnOPLGAX/EQOeEHilMo3beGS8oSJ2+sB0DXM?=
 =?us-ascii?Q?okYRgmx9/pjrMFwsTkoreh8F9q2wyvIsXzM1DTPA07DM4kybitiG+NUY/s6d?=
 =?us-ascii?Q?Y2S3FoSQjWJkCwt3rvI/atTto+Ev9+sjJDSvKXlj4A62bJm9hWwrUf5IEfqJ?=
 =?us-ascii?Q?lyBX2KJ1EsXRhl8McgsREBpLi0DCxFLNUv5+g5vzfWBaYwTSNdNn2HlLV1Ul?=
 =?us-ascii?Q?vn/2Hsy97FTx2Ie+tXk/kv1PK36+AZoMUWcpkVk7qvNdEQrh5j3pAoTF0O6q?=
 =?us-ascii?Q?kiUyz3KM3ZuSOlnVXWzX3Srhr5hLmoFtH2+3iZaD0/5klrnlKJQJhOHC07Tu?=
 =?us-ascii?Q?GChCEiRPbIkq05SF6Jkr4TAhyXG77GTf8Mms365kgai5MgDcq0R7yQSr0WRl?=
 =?us-ascii?Q?KV2zCCZQeTMn5Vl8RiBfMC/azZqGAzj+ngGvs6lrZAXAHHWrYvjXfMRYKPYT?=
 =?us-ascii?Q?FPUjI7vlXGqjqYGJAkEpPdNAYBd5vaODa43mi6oDuWiq0zLonKOnOjFaMr8N?=
 =?us-ascii?Q?GV3MBVgrbz/f6R46H7M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9bd530-bf91-4cda-d08e-08dcf9b02dd1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 13:30:25.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6xSfNUDqumCOcgXTFwmLmuHpVIqUPTNwZu3waNRgsuUNt62Q2WZDgHS4/31kXIi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828

On Wed, Oct 30, 2024 at 02:35:32PM -0700, Nicolin Chen wrote:
> This avoids a bigger trouble of exposing struct iommufd_device and struct
> iommufd_vdevice in the public header.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommufd.h        |  8 ++++++++
>  drivers/iommu/iommufd/driver.c | 13 +++++++++++++
>  2 files changed, 21 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

