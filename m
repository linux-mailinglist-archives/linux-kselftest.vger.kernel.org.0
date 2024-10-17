Return-Path: <linux-kselftest+bounces-20042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEF89A2DA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 21:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ED7DB20EAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B07121D2AF;
	Thu, 17 Oct 2024 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tDIkGY3d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5E227385;
	Thu, 17 Oct 2024 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192820; cv=fail; b=o3tsN9MmCpVjeS3Qpi8T04h/75oP9PffClNlP0ae6zE7pvaut/W3+diVd+zXWxz2yoJDQlzSR3pz+ByUyaFICY6yt7dCjln7cJ+qBQq0rllpjp4GcU8UUmfZjfgUPR7BoICssLq9Mr1DFBmOev78xMkAtrUVXhe2X6pTfcXL2tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192820; c=relaxed/simple;
	bh=39QLOOk0PauvPGbDrcGdBAZ89EHgcfuO1o1JmFwd9PI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIpNnVmo6yaWkxZwm6n41BpcVpknIOx+SMr83wsUIP71DGGUv8G39aH+1eOTc8f/o71Tp5M+Cn4AykI+pClDEmn8Jn+Nyjqg63SJARmur5Ri0JIgwYWlJIs+HabZIEArxLMrpPwrxhRcjIeYQ8ev4pNH/pY3dlCqEkGWSMBwn/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tDIkGY3d; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BK1PQ2yDlChmAJOKnrJifflxJHDA0hQY4GXAEzvWZpkBJIUtx4QzGADYbuCjll67yUPWljy0x4NagI4Zy5O3v1QD0o5sUFNkSDn/n5po49vpKNex3F72yuADRtkkz9S+U2EZLq0Soikc5Ax+H4tzRh8ZE3cIHcnZPh7QXil+htyok8XJJXyjU7Vcg1C4D5ivwkT4lPaxIT5LPV40Sdg+2d8/F/ED2fcrOeeolG1wv5MmRg+TKKayLIVwSuJ68weeyLPOCOn6ywKM68oI/WbzauHjB1jXMstGki4EZtJMBnwXmLqYGnZZx21JKjYsz6ZF02AfkGQ5VNBtEiTvhmVVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyOjfKRlUA2hVYAAnb8g3LGuJmXVc4UqgXzFEPv5bMs=;
 b=jbaG2bKUvU+2RiiaZZTu8fKvngjwfgI1jjB32R0rWsrCMrYbZzNgDaLdvhJj7rZ3uDe4C8bXEZdJxemlE6IbDspjYFFQ8e8N4PBy6PcMz+TDHZPSN/rhS4+vXM83pGetFiFc+GMvPLPJ6r5Pxsx04Fn/O7hfqMss4GTf+dZ4CbZrN8dyBRckS65vyam+iiJeqyypaGoPB0itOLNB+nIV60vE217wcqhBTD+9Pfgl0T90YPnagIuksKa7xejboVoKtBBHHMyOgQpGn19tDFJ9uJIoI0r8Jdm+bE6uUUd9FTJNOW5P8ddXgbkaXJDgj22bHrKX9+H28CTqEJYNgQS9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyOjfKRlUA2hVYAAnb8g3LGuJmXVc4UqgXzFEPv5bMs=;
 b=tDIkGY3duvYcp0GNA5g8SZEuLV6ls142dE4Z5am6yj0HQHe9sEhNzedACxJOOeuKxSshrTQ71FKDjPTh/OPc1mPj8RAtHq+EnkXF5rhoUvpR7htt96KdjCM6c6RCZPFTPmamyDTCKPvFmjG8qACLqP9Bi6FqByj9zVqiiw7EuVbGCAPwoKkn+JXiaWaF3DFM56ObbXRuzyHzOUhxldildaZxJ/Icnmv7JEdeovL/m1vSjqeFDS450UT8eUvT96nBLP4tfoyFpTJyTAVMDK/9UXd4RGuG422OIY9HYrdEyeGGzR1L+77N3zKePPWC7KYG7TTOA0Y3/L5mUePLlgoveg==
Received: from BY3PR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:39b::18)
 by PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 17 Oct
 2024 19:20:05 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::b6) by BY3PR05CA0043.outlook.office365.com
 (2603:10b6:a03:39b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.8 via Frontend
 Transport; Thu, 17 Oct 2024 19:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 19:20:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 12:19:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Oct 2024 12:19:56 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Oct 2024 12:19:55 -0700
Date: Thu, 17 Oct 2024 12:19:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 00/16] cover-letter: iommufd: Add vIOMMU
 infrastructure (Part-2: vDEVICE)
Message-ID: <ZxFjWf8TTSbbHWS2@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <cover.1728491532.git.nicolinc@nvidia.com>
 <20241017191416.GZ3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241017191416.GZ3559746@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|PH7PR12MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5aa45a-0825-4244-466c-08dceee0b4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u79as413nnGcvlKLdSdHdC/7wEZOAICacHzvQCpy9IOFbAjpDgUafculocUS?=
 =?us-ascii?Q?cVUID/TKpod2zkRVWTHATgdIa3kvS59jcHPt9KutK4xNYgExKkj183wsh2No?=
 =?us-ascii?Q?Msoda7TRVMteaVho9DeQXNvWv1yhbwD6/at3hRI1fmQXmvLiOYNxxs8zJP71?=
 =?us-ascii?Q?XXefIGbHvx3En02oM+mDpgb94YF4gT1YtGHjT3BbleOVRuU8VX7DFImAYFul?=
 =?us-ascii?Q?qwwBa+1nHvKxHfpLVtdKnK/K6jXm4hVVo6EbjXLE2egAcASKkfv669Z0Eec2?=
 =?us-ascii?Q?vC48csdwGOLhNnnh8fwqhC6wG0PbsQRIG3q5W8lZDchp1jsbJArAJWYdizU+?=
 =?us-ascii?Q?RVaH3QxFdHJqNZVEY3uXAgoCKD3ayjx+LU+iqpPJNRUIiyOxDtTY4smj5ZEG?=
 =?us-ascii?Q?WYqz4g1QX2ipWfDGW4luT9CNg/u7K/QQm1cjtuZqZnrGhcyKVGP9yBO9JEdR?=
 =?us-ascii?Q?W0UfisbHzkNM+4wW/JUfd1u4Fq0XG3GPG37iFrCTPtvMB3CkJfcrIRq1KY1J?=
 =?us-ascii?Q?BdWoayHG4iAoB2nEKiahYZxtbMO4pXlwe6YS76pFasndaHnt3R7wmEVNtZDj?=
 =?us-ascii?Q?HsKiZrA4UZ+gl9kQSbA7BzilvTtBHJnPkD9CuJe2Z27IgosQswyDnUdDYG5w?=
 =?us-ascii?Q?Q1UO85MtVaC7Z8KAAluJp7Tqr6UIVAwF/7NKCK0HkapnNA7G+IOIf2aOYeVp?=
 =?us-ascii?Q?V8eUycuiwakXCokfWzVdD5XtXhHtLqT0OSvGpCOIL6zKA12/Cv6S0HN2ayKL?=
 =?us-ascii?Q?n0MVMbbKulPkzOXXIz10k6XDvhsI2/3siY0+vVDFzOLDhRml5HVgN39su07z?=
 =?us-ascii?Q?OFUrCEfaZ5RMoo7D+QsMSFG9jikbjdBuNTFy9sZL2ajSkgU8OMteNP0fJ8cE?=
 =?us-ascii?Q?0qDwbXDo3GV/RmapFMmonwtvTvyn1/N+to0xgLwziEvMqHwpT9EXIJ9g92Ok?=
 =?us-ascii?Q?ZHfT5uELpiPHITH6CY2PPpmVIy53Up5zcdbyOqVfXJtHB5yN3ihaoXIZAkH9?=
 =?us-ascii?Q?w2glqLCqvr4NFg7E9wqPrjA2CIyRq7hWpcFNab2BFZxRW1SufJKzA7UDNkPf?=
 =?us-ascii?Q?8PhnG01MxrazRa0/PSvyKPrk/WtlATVuV7iaT/zDCpT6DXTwGeLmAZ6h/cUk?=
 =?us-ascii?Q?g1FFH0sItOmG5rs4U6dKkZKabDq4gV99zeptqVOMBYpWxMrxFJYGDzeuvZgP?=
 =?us-ascii?Q?TI7JVhWfEWXF65reDKG6fjPFZww+DXpeHyK6J9WKgAPJPhlgtFRNQNUZlesL?=
 =?us-ascii?Q?eDB/iE82ZQ2OziY+SHtaDyYYqfwtITvbSCx6PBbsrLtm4uS5fBC2VXDI+dlN?=
 =?us-ascii?Q?7vwjvgC2TJMBwn5Om+tFNbOKZBlOT6PM4ys+q0UBgElRBHHXz4eby1tId2K8?=
 =?us-ascii?Q?68ws1F4hWGPLZoLLwCvcXIKV6hkoYV19YhQ2VNKhVIsdjZ2gyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:20:05.5735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5aa45a-0825-4244-466c-08dceee0b4f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859

On Thu, Oct 17, 2024 at 04:14:16PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 09, 2024 at 09:38:12AM -0700, Nicolin Chen wrote:
> > Following the previous vIOMMU series, this adds another vDEVICE structure,
> > representing the association from an iommufd_device to an iommufd_viommu.
> > This gives the whole architecture a new "v" layer:
> 
> Don't thread series together like this with reply-to, it breaks b4 and
> other tools ability to tell them apart.. Just post them separately
> normally.

Yea, I didn't expect a single git-send-mail would thread them
together. Will do separately next time.

Thanks
Nicolin

