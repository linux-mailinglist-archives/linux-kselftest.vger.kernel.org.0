Return-Path: <linux-kselftest+bounces-24953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C659A19830
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 19:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF26D7A1D91
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 18:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C39215186;
	Wed, 22 Jan 2025 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="msbVQpet"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0416F21505A;
	Wed, 22 Jan 2025 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737568991; cv=fail; b=ltXcAGHkb3G+xdlih7hQkITOVrmqEa4QZgNMme7+6pWS5lCgsoH4JMXoFMOcGsCqmy+TdMMUtzJo1iVPh2uCdFPyDZTqytR8A7t3PC+E+A+DFMat1ImiLXEHu2JQCByvcvwPUaV9tRMZX2Stm/PS9Cypq3cSOc0QhCLgmKLEbAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737568991; c=relaxed/simple;
	bh=RL6YMxvzCqilqwnQJaN4cVCbmmlDVfYZ4igcLiCPBG4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4b1V76oA+Nd5d8gmz+7YsW1uTMno5YmWI35pqu/SgTv50CaC2KciyGFChQax0k/PPAVGyQfOlqOSt9v3a6WM3JawOCSDCBW91MhaAVT9WRJijdfuEJaPZ2vE/EhnRedfIQKaDzJc/wLFlwb2jzHpqBZlILE2/QCVh/VhcW+g0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=msbVQpet; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/xcnWdKabw/Vt6FSWt2Ockvm4rfUQQTQ32i3+pLF4t0YUieVvvQulVF1mUnTNN8eH3JMDegYFpkxuOklFMM45V78Q24Yn2txy2FtBQizV5FrRv0/X9ZCWu8x9rkfX+VShBzLnGQ7BDRUXe6o8vZzobgtNUDSepoa1ZD/2dexud5hiHN2BnbC8+AX8nongcyf8094MgcYzU0894k7ucQa5Bbbf2baJ6SwwjnAZMUwC5AkGsXoE7WEnZccKYRBehI5uXUqPS0CTGakc23UxigunwO2REubGPqrKoC4Iq3ck2HGuybqSpe4r7csKlUqUs/ELn6MVhOiUNaH2JY9JP9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTZ+cwUXWrpHGqSstEi5Vw24xtpdMMX5NtitBOQCpYw=;
 b=oq6rKLliydeFLoz6VOF7L9sYqjJXY0PRvzYfR52V0YxpvIFG3rt7riYIehJVLlnP1EReQ/USEDU+XXlF5GOUjCxeTXgfTDlOAqnBHhSMjtaxB/foRlhpkgXXg7N/IBcr1mPSuZsTbvotfQunQU/6rV8mAXTKhkNnP3pjJVeh9cDrAYqkG5mVLh/d4O3HIXzJiay92NLn5Tf8tNhVWvu5IPAWnt0IIq2JY0P3vvk5ob7tJSuxUN7CzU6y36GOYXba6WT3E8E3/MC4QuI2MTy3rszrfcsYGXZI3eWG+wNp5LNIrDhbey+vaFLA4tP95AtPAZR1IDHZnrYoG1lF15zwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTZ+cwUXWrpHGqSstEi5Vw24xtpdMMX5NtitBOQCpYw=;
 b=msbVQpetcxO8RFB0GGsDib76jo3BqiXgdSM8nAT36PpvzKTk3ezxQcLTt0ZFv8LhYav0eSE/d8nFeyX+6Jx7rI8gtgs6wRNxvTbNRQwWEsHHc/KVy0uutLiju1kyO91MM6/d4BUmfkQaFLyEqJuDG3arvYCzcSOSIeKP+f+/kuvJcoPDuOurR3YTWRyMmMEbsZWmAydfHYVhopAcPLez7OVEDoAPrD7miVAlVK/3gjovWNYJg1Zy25kuPZfiOtayMYj6ltVjb1pjFoxgcUxCaJmwJKkt16QQQ4S4OasjARa/Nvijcsb5EoDkMBcYVWf0SrH6ixVCriocNjIWks14yA==
Received: from CH0P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::9)
 by PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 18:03:04 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::7) by CH0P221CA0025.outlook.office365.com
 (2603:10b6:610:11d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Wed,
 22 Jan 2025 18:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 18:03:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 Jan
 2025 10:02:49 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 Jan
 2025 10:02:48 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 22 Jan 2025 10:02:44 -0800
Date: Wed, 22 Jan 2025 10:02:42 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <Z5Eywl1o9pdYyuQO@nvidia.com>
References: <Z4rVg1Xg5TCiFlSb@nvidia.com>
 <20250120181854.GQ5556@nvidia.com>
 <Z463eXfgNArCOfPn@nvidia.com>
 <20250121183611.GY5556@nvidia.com>
 <Z4/7pGx6F1mpAUuV@nvidia.com>
 <20250121200924.GZ5556@nvidia.com>
 <Z5ALWFVTOSC/8+ji@nvidia.com>
 <20250121211404.GB5556@nvidia.com>
 <Z5AUNVHzJPATVqAY@nvidia.com>
 <Z5Cmvfp4JW9vmMTP@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z5Cmvfp4JW9vmMTP@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c5d57d-4773-492d-dba1-08dd3b0f0444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hga3VJJN5upovQ/1eEFLKGBUQ4JzI17j1py3zwkxebb0rIw3G6/PsnZ61nUK?=
 =?us-ascii?Q?NFn1lo+jGkUIJJd4Uy5l3AJRmeC5iQI8mmFl8pz1ZkRVdtXSA71GTL49zL6n?=
 =?us-ascii?Q?ScnH8towIY1UZT7tsV+Hr5Q5hC/ludSd09iV11vyhIsKkciYce/iw0H0kdyG?=
 =?us-ascii?Q?cOzdaKvXR6vrvGQNCRDrMRyIbchSgTrtZ6delQQC+d9pFYuTkT7w0Jd2SXLF?=
 =?us-ascii?Q?w3NLttrHD1rIkZ9AvNFDIazQE3QDI9Uv7kxw38Xl9QbM6pL2qZ3JnK0ShX20?=
 =?us-ascii?Q?K1u6aBsbIL2l+bRK8nYRGpXU7BSLNB5IPZNqzg+KoFNYa8I5i2XgamEZA5nJ?=
 =?us-ascii?Q?QWQiIOzW7cK2//ja7RcVrAdnpMStkWawkDHR3O1RSUW/MdsKX+/2hV0xmW9q?=
 =?us-ascii?Q?IzbSPCpSTqNKuh8BjoMV/KXR0gbjeJ1O/VyhZWN4QiaTl7u2EAFMKj5SCp4w?=
 =?us-ascii?Q?bzvocvsmrPwOMztCoRuqVOn2onMGxiymSxdi4XfshD9DqSb5m+M5k5+xXEKY?=
 =?us-ascii?Q?N775HRFb3VEYBMY9kvNgSHoJSqPsDX+yQ2QtytEnIYCMs0TftRE974XLnLg9?=
 =?us-ascii?Q?JFkQTplgDBsc+gqcqSwqQt8KMVChETmHdIg1wVgOciRbWsPWQQcfZWYWKGH7?=
 =?us-ascii?Q?1zDO7EqMCkm+H2x40AwFRAJok6B3iJkS1nmqhDmVZ9H26zzmc0Gm7BUaQPiA?=
 =?us-ascii?Q?My0280Tk2la4DCUQg8BAuYGVEvIRAe1sgCjHgsGaNSHC2hgd7R0lTg0MW2kL?=
 =?us-ascii?Q?ybSOdYR98m7TMOEnsRhHuLCZ07oFfkM5MkgRHaEcTYVlbA2zDyemNpibAlYm?=
 =?us-ascii?Q?BldKXXVhGA9Lz65Y1HMiEzC3o8Sf9C4IDXBC8+b+EjdtOjIg+XYnuHMa+RS7?=
 =?us-ascii?Q?HYkDC3BmxHUf4dVZ4T632uY0yFLf3FnYeX4lstr4dNvnkzNeA+5UjhqOCYFp?=
 =?us-ascii?Q?1qmd9slwmQPSvOwxdB1QeUoFF1bgL5nvluYMZC521pAqc6pX9szPaCgEY9Bk?=
 =?us-ascii?Q?Iyv0KrJ7ycX25QyOADDBFoTV3EJNTmaAT4Y1NlxTsLb01pxKbHYUXQSOCKC8?=
 =?us-ascii?Q?TKLgZUPBsAs2Xt0tEMPkWodhe5nvoByQ1JHbth57LWLhQfd4Q5jePnLlbsCE?=
 =?us-ascii?Q?e9zkp1LvWelydQ4+YxOqw6K7iZdPFUdqDSHqveSc6j/AKGMsMK4rHJtciybY?=
 =?us-ascii?Q?VRU7/9o/u/f8K+J7QSMHskCTpu9Pka4A8Xu49nBHOxUx3RaMN6zQJ1X64shv?=
 =?us-ascii?Q?/UiZfERZLY81k83nq85zZpuaLW1fjne9opRoNiXRwTFqkKwqpAk7F/HOFfjb?=
 =?us-ascii?Q?YUbPAuDMCubX0rXyzJRb0/SOtQSMHUdJUtv9XZ9a1kTwRxm5DhxeO7LsI2y6?=
 =?us-ascii?Q?7Ysgxb+RH1fR9Bneh3nwLds5DVfX/wAxVO8yKxbBP5JfHEeIQTrQGQmLGk8k?=
 =?us-ascii?Q?eQvbx55gfvPCeRz2raYDRqrBK2GoWw4QFWqRbsvfjwIT+YfNNMrBZ2e+hkcM?=
 =?us-ascii?Q?zvHJkRFUVDQXhoc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 18:03:03.6929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c5d57d-4773-492d-dba1-08dd3b0f0444
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127

On Wed, Jan 22, 2025 at 12:05:27AM -0800, Nicolin Chen wrote:
> On Tue, Jan 21, 2025 at 01:40:13PM -0800, Nicolin Chen wrote:
> > On Tue, Jan 21, 2025 at 05:14:04PM -0400, Jason Gunthorpe wrote:
> > > Since we don't hold the spinlock the whole time there is a race where
> > > we could pull the overflow off and then another entry could be pushed
> > > while we do the copy_to_user.
> > 
> > I see. I'll be careful around that. I can imagine that one tricky
> > thing can be to restore the overflow node back to the list when a
> > copy_to_user fails..
> 
> Hmm, it gets trickier because the overflow node is a preallocated
> single node per vEVENTQ. We must not only check list_empty for its
> restore, but also protect the overflow->header.sequence from races
> between atomic_inc and copy_to_user. However, we can't use a mutex
> because copy_to_user might DOS...
> 
> A simple solution could be to just duplicate overflow nodes, each
> of which contains a different sequence, like a regular vEVENT node.
> This certainly changes the uAPI for read(). Though the duplication
> of overflow nodes doesn't sound optimal, it's acceptable since the
> duplicated nodes would have been regular vEVENT nodes if there was
> no overflow (i.e. no extra overhead)?

Ah, didn't think clearly last night.. We can't simply add overflow
nodes either for rate/memory limit reason that you concerned about
in the other email. On the other hand, though certainly not being
ideal, indulging the race at the sequence index might not be that
harmful, compared to the extreme of the other case..

I'll give another thought today if there's some other way out.

Thanks
Nicolin

