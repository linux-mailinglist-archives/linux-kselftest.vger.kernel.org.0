Return-Path: <linux-kselftest+bounces-33229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47582ABA4DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 22:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13871B65395
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 20:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAFB22F74E;
	Fri, 16 May 2025 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hIMUSyyz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAE922D4F6;
	Fri, 16 May 2025 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747429012; cv=fail; b=WAX+W0GUQ9cE3RfmsMqimUindGeKWR4hAinQ+wbPGSD7rO3N5alKI0FSIgyvH+mJrp4GXD/GW+x/VL2YtTaVp74dyx8Nt3BSBd5CO+Q4cVkCvzmI7g0I6kScyE6kP+iJ6YumrtB+IPSffsb1rGJgGhDdr+wHHhKlSrGPK9GatLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747429012; c=relaxed/simple;
	bh=BDRHNYq0hyDR+PJ/UdR/p+UxWNmSDEY63JpujWklTmI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4E9Sejzl7Uf6Ti2NyIH+CoexeNDY7Yk7NXc0S/dSVD+y6SmdnaYcU2TL/79M1wKuN3JMLnibEBHi06VCMuriGQsqziF057Jrrn78tiJBCl06hHSvbDsjBnf7E+SikJAR74OXVQ4HueIh91ev1xZjgKLzGCvxwrhVV8dNnTB7sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hIMUSyyz; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTBPnfQABK9KYFzxvpUDcLBJv6Lmv2QADxXlcgvOWdT3B/BAb3aslQwg7coxtlUcQLwqHbxrmTq1By7vXxsNjSlqjHTDy2P22PdBHwZWyEVW0MElmZuC7DGxk2HAoWicf3Qw1VxXqkjVjg71xIISebcivBV9jyM33WN0f9vWIEkbxol0RCpk12aPqgD02y+NNoDCznmCNIWuqmZu3advCMdepGutaNWYQQxqPpqBDgREcPVttR291I1Z80T39pB/e2SJnM2teZ3ztEISf0XRFz++Nr0cr38J+HW/i2QUFRQmgY/Xp5Ol3cQjZGMNJ2K5omBrt/0gU/uvSA+R2Xgbfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ib9YpOGAxlT5cfoMaxoAmRBUWBZE5ODfyr3A5eYPTKI=;
 b=N11jUjFTRzIFJRNdIzAiXJohx4cEUWkeYgL81GZ0tArs/W1ByiXECp0KrMufwmKI7JppJEOz3IquFYH9P6hB0hs5MFUdLg9GCavaKkgABHcczGwwanM/UfTZYvHkGXcjAsW0cj11bRZV3HLMeXupR8t5JMvGPD8UX5y8nz8Jtdx1aggc1sreFZkmJskFDLcZDPGvtPM0dre1+nc0NX+O8SNMjdS5IohYpcqvYgRg9L8ToLTNGhI0ivfHqvYz28kj2d1wL0qLqEeHM7Avl7cyGY5Coh+RkFzh65rpzfGx+4nYmXNbtOp+/SQ2wRKaNUm9QOeYSQv0eGqBPuPkHP+OCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ib9YpOGAxlT5cfoMaxoAmRBUWBZE5ODfyr3A5eYPTKI=;
 b=hIMUSyyz8rnbPwGDVvoBrd0lf9VMyP2BHQQWRUOVHA2cUS1/H2bN5lGmJyH2waEPgXvPqku45busGyRBtI8icVoYuNSzkMmlPv13XHDD9SzWHHZmx5XvHnKozCH/d9RTxt8Lb6qNlVR3PpVY637osyqQxZX0UxQe7ec9RmpzCWOuOvpUbcMSNTaImW+kghoFxmQmh9PoUvF+sfXKKabf2mKTOiddKkN3GeqGU+Gc9gGYQxPQpH1GxK1A0MypkyEZPA2J8oCbINynuihhNo4EIeFq6xZT/lXlykhHM3b5V3T+7VVC5KO6Zu6tx9BW5VzXNO90hQMLV3HUl1uL4NbCWw==
Received: from MN2PR02CA0035.namprd02.prod.outlook.com (2603:10b6:208:fc::48)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 20:56:47 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::26) by MN2PR02CA0035.outlook.office365.com
 (2603:10b6:208:fc::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Fri,
 16 May 2025 20:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Fri, 16 May 2025 20:56:47 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 May
 2025 13:56:29 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 16 May
 2025 13:56:29 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 16 May 2025 13:56:28 -0700
Date: Fri, 16 May 2025 13:56:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v4 05/23] iommufd/driver: Let iommufd_viommu_alloc helper
 save ictx to viommu->ictx
Message-ID: <aCemeved47HE6Q2B@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <5288cec9804e7e394be3b7de6b246d8ca9c4792a.1746757630.git.nicolinc@nvidia.com>
 <20250514170637.GE382960@nvidia.com>
 <aCadeeP+Z4s6WzOi@Asurada-Nvidia>
 <20250516132845.GH613512@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250516132845.GH613512@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 22034b7f-6367-430b-5384-08dd94bc2c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QfEru6Kmx/YtUKpKIsNs72iIDgR2o1rcA5Wldk+RxQSz+26hpfkWa09mqyQW?=
 =?us-ascii?Q?zPPrV+pGq64yRX1j2+8Ncyc3tRX0HEmitBRCmAIKU0QzQZ6h1C+Fo08lT9WM?=
 =?us-ascii?Q?ymB6BUQiPfXE9GOWPLIqJwWOk09Zwo6Xd/Vjuq8dReE+LyjnmVJ09h8tWL45?=
 =?us-ascii?Q?ynSepoXlQiVq4QkjTWXoVdKakOS0X+Vx4T4v7iJ9/fO+OiidvwncBG2YRQr9?=
 =?us-ascii?Q?3M2GeB+I2lXbqJYEIjpPELJBzODo/C5h2WZXrdRY8pZR70qMKOqEiPn93uKi?=
 =?us-ascii?Q?lUNwjHmK9vPvhiq/6pXchkzXc+USMp0LERxDyljiFnHgvG6oAuDoovKonCzK?=
 =?us-ascii?Q?dwVa/mWJy5FXSDoJSdZPLFTeqP4yQ74nkc9/vtD1pakdYC6LWlUOkx4IEqa0?=
 =?us-ascii?Q?HEztCrY0+e5TgKQakjWoI4IS0jquU1OF9IUW7FVvOrB59O7j8cIhR6EwSAbs?=
 =?us-ascii?Q?KU/Nzc67bVfBjF8l2admobSzcxxqVHk2uEjEDTDPgrMSZ0M5qROZQs8LPWWg?=
 =?us-ascii?Q?3l8L31piLLGW5VCKVfYNRnUoUrFerbXuJwG1kdz3MseMAjJhCAoP8VldI0Xo?=
 =?us-ascii?Q?OQlxZaXFHBs3kD9KcvFbwD1NtFN3VWSA2Y/WDqsS00G+ULKebCZz1gdKku4F?=
 =?us-ascii?Q?qIv5ZyQ9ziTlRPCjRS9JPnN88X0hmU9Kli1JOMRQEG1Oy3UC2fD1R++CUwbp?=
 =?us-ascii?Q?+lEHWU3sBhawzSEFLWp+B8VhnDJAfMVuzz+emOXPaLZLwbU1t4kZ5PsQQZfR?=
 =?us-ascii?Q?l4U0FTVoEnbwqEhvO44bcGmQS7g80WbLHNIQgZQ38wEQOVYMcT4Ep0H012q0?=
 =?us-ascii?Q?SZfqmXy1171tO16zbShnS5UF+GZEjp0YuAp57w7q8DlRTeWBdFxq59gIsAwh?=
 =?us-ascii?Q?TweGr7KthLEyUJ1arufli3n32V3ECvbSHcWVCpX9x2BmJ81rSWfaT7RlsKMI?=
 =?us-ascii?Q?EMwDwECXzYAy1rMtE7aCGnODNkVnINdCludqg5BDsGnJv3NdxGyyvt74UMT+?=
 =?us-ascii?Q?VOYiYM7E3HMb/a2Hrh4rUoxOlKWkUI2GMnI9mgaRMReuqybqg8Dbjfcr4Si0?=
 =?us-ascii?Q?AuJeoFgXTm30j3jVUOKEgyM4zljLRxSVLQKSbcyutQ2y+7EDncYjYy+Qq1Ql?=
 =?us-ascii?Q?k6BX+9zASmEmlfnl3fFRdJJ2JtHhXcg6aGmcXZ7100/bMyVxdNqgzaFjvZLK?=
 =?us-ascii?Q?uURKlSeht+FbeyPg2TzLmf6ZXaccQOa9l4l42O6RnKu1UhvaOsSgurkx2OVo?=
 =?us-ascii?Q?KsSc+97DWxsQTyEWsKiBxEAYpGIypuELdJhZag0R+FXsROvwCWcIdTehf3X+?=
 =?us-ascii?Q?oWSm4CHh3pZr3BCqyqdxUy7Ofclf78iR98nXyewZPlYoilxp3sC4ANm0DPJr?=
 =?us-ascii?Q?WAaHikYnumHYRKM7kWAt8/mFO/jbzR19TVNuhLwh1ckj9FFMS3HouY9g9aXl?=
 =?us-ascii?Q?6zni13dDK1vLySQbQYvc4OmfPMc4sJ+aPRUmQ8Q67H6Dw8ZUs7Ese1hgR/0r?=
 =?us-ascii?Q?GTAULjMOGRTt/zJXCyQFYskTpZ41qMqHRICl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 20:56:47.1445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22034b7f-6367-430b-5384-08dd94bc2c3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275

On Fri, May 16, 2025 at 10:28:45AM -0300, Jason Gunthorpe wrote:
> On Thu, May 15, 2025 at 07:05:45PM -0700, Nicolin Chen wrote:
> 
> > Otherwise, they would be something like:
> > 	// in my_viommu_alloc()
> > 	my_viommu = iommufd_viommu_alloc(ucmd, ...);
> > 	iommufd_viommu_alloc_mmap(ucmd->ictx, my_viommu, ...);
> > 	iommufd_viommu_destroy_mmap(ucmd->ictx, my_viommu, ...);
> > 	// in my_viommu_destory()
> > 	iommufd_viommu_destroy_mmap(my_viommu->ictx, my_viommu ...);
> 
> Yes, this is how the other objects work..
> 
> > That being said, I ended up doing something more in this patch
> > for the ucmd rework and Kevin's comments:
> > 
> > diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> > index 98fe5a49c9606..ddd144031af5d 100644
> > --- a/drivers/iommu/iommufd/iommufd_private.h
> > +++ b/drivers/iommu/iommufd/iommufd_private.h
> > @@ -136,14 +136,6 @@ int iopt_pin_pages(struct io_pagetable *iopt, unsigned long iova,
> >  void iopt_unpin_pages(struct io_pagetable *iopt, unsigned long iova,
> >  		      unsigned long length);
> >  
> > -struct iommufd_ucmd {
> > -	struct iommufd_ctx *ictx;
> > -	void __user *ubuffer;
> > -	u32 user_size;
> > -	void *cmd;
> > -	struct iommufd_object *alloced_obj;
> > -};
> 
> You don't need to move this unless you are using inlines. Just use a
> forward declaration.

Since we forward ucmd now, ictx is in the ucmd so we need this
structure for:

-		if (!IS_ERR(ret))                                              \
+		if (!IS_ERR(ret)) {                                            \
 			ret->member.ops = viommu_ops;                          \
+			ret->member.ictx = ucmd->ictx;                         \
+		}                                                              \

Or, we could have a smaller:

#define ucmd_to_ictx(ucmd) (struct iommufd_ctx *)(ucmd)

and add a line of comments in struct iommufd_ucmd:

 struct iommufd_ucmd {
-	struct iommufd_ctx *ictx;
+	struct iommufd_ctx *ictx; /* Do not move; must be the first member */
 	void __user *ubuffer;
 	u32 user_size;
 	void *cmd;
 	struct iommufd_object *alloced_obj;
 };

Thanks
Nicolin

