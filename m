Return-Path: <linux-kselftest+bounces-31811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06E4A9F8FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 20:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC703A9123
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4777F296145;
	Mon, 28 Apr 2025 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gOdIjK2D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF86626F478;
	Mon, 28 Apr 2025 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866737; cv=fail; b=TpvBnQaUjd/XVmsLry+8krGl397FHHDzSCYzuNAfVe7nlAGLNjlXqvDVwk+MEq2ElwsrzS1VXI+k4EmR1g59nhQDjpOsN2eC2OaaG0gPgEKKcNVHhOC+MXIA5ubllGwardELD99QuY6ULGo5Zjys16sxMAw3pCyxvstIMdQpVgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866737; c=relaxed/simple;
	bh=6Rcw+Z3pAPJ/5sFkPFayB37Uy5r+hkQ34xqD06iolk0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+F3kQ/wJQ5XEW3q9y10qFSNreE7UMPQ7M+bBv+sGOOW3YQFGTSA6bwJmHYdkqFXyqfc14uCeuBf04QhZ5k6DX4sy5qn46LQdqlMm7Wc/tNSZghOa88ztZhyrH7zOBlKvx37hFRBX7DYYHqMsCZV8c9HFjKgomOXs3hdxET5R10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gOdIjK2D; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4+C35GFg2a2VngNKS8duTOUoi6JP7KDh8Nm1VX0j6Wv0OKJk1cMIaiee20YZI25nnQTzBlrpjRfaHv/Qd2M6bZ7Ip17TRv3HzXaH+o1gOf6SzUl7nYdjZbOTLdIvvWssPxk2/ZMShXt1gjWn4X01fwtCb8ajGTwJNa6STT552H57l6T+5+G2yDAlwYAbBi/HvqMg9rDJje1Pvsg5shv4v6QFqDmfCsesfkhiGmEem5yaWGZWJbyUF4KysH5vFuYa/vQXhK7Li0YOHB3EeLbZfIgPskVyT4jbLONpKwvpm2i0HTXwXjU0zeMEhCdN+AoLw3dvWTX6j3aBjXi7Nwv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tWACRV41wVnve2FZvUmFcDo6E/puNFtzF3f1VthyD8=;
 b=wPVxPDUppiPzc+5UfVK04HfLKyOdjhox+1IQq8uavHK3HSLnPqysbBMdW5CE9AjQoO/gWkVZzjlF466QugXaR0Tgj6Sowuf3hNdSSUwMrp6NZCJAhXFLXRHHyNiTESiglIdMc7lnhso/0WUOjgBhScGY4SPdQfX/hpx7pgMPBoHQ0QVssOTmukzIE9yNkrz7gaMqOKKU6Nst97P0Xuy9I8H4pErKaouuttltv6Muw1Yx8mBOYVRTfjS6czDskwac+5emfkV9Uu3HYWXhiIICrqN65l0AwrWgoBQTHnmFAht19/V1HLjqyqiWnhy+KAWrrfYPnhMbllYMrTIAImZ+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tWACRV41wVnve2FZvUmFcDo6E/puNFtzF3f1VthyD8=;
 b=gOdIjK2DZ016MFCNfGefR+wXehFhnqrsvTN7xj+ynY7hCOZrNk/U+HzoSV/6ZWGSxG2CU+K7gVV/wcFyzcm4VEVOppGRdpezed9fKXCio7V7/uIAkUVnsFQwzDs1kmicfwciJYQ8D5SdfpKnfTekt36wNiN8gKmNpKSIh2DPJ4NCAc4bmllV+8z28RQMWK2fJP7RZOXDHjkjX5IPrmK3t+WTlwsiFPp4SQbCkIf1TFw2LxbzO3IcE4N6ZVPlUunEKJxdqg8LecWdImrBMmvfAm2AFJCu0DWM2GIrKu2tc302bqKioCdFG/U9igmHxF5KbXZT9AElbrpemQOuJoBPeA==
Received: from SJ2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:a03:505::13)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 18:58:51 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::75) by SJ2PR07CA0012.outlook.office365.com
 (2603:10b6:a03:505::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Mon,
 28 Apr 2025 18:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 18:58:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Apr
 2025 11:58:32 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 28 Apr
 2025 11:58:32 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Apr 2025 11:58:29 -0700
Date: Mon, 28 Apr 2025 11:58:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <praan@google.com>, <zhangzekun11@huawei.com>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <mochs@nvidia.com>, <alok.a.tiwari@oracle.com>,
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Message-ID: <aA/P02wgX27/EjBS@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
 <dcfd9bfc-44db-4fd8-a49c-0c96c68f6b88@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dcfd9bfc-44db-4fd8-a49c-0c96c68f6b88@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0883be-9871-4256-9fab-08dd8686b691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uVGanoWR5SHipaoNY2YVkpbjnP7em7L+mNEJMZv5gUI3UGv7/+FCZ+uUizs1?=
 =?us-ascii?Q?xPKA9oITd+mlYfHfWwGiHrBoiMwmLdFNYiDbjdO28bfDB66m9H4bJJTke1gH?=
 =?us-ascii?Q?OOQnXKo0jBuvdOLr2FBwuzn6Kkks5Ehpyk+uQLANVj5srlOykvIOQrHftBD2?=
 =?us-ascii?Q?KZ4+Y+bvgxlqxWjmevvXaaBfuHd/AoRk5YvSKnACpX5MLZaZXAmrWaEfpbWB?=
 =?us-ascii?Q?W0nORFAwVCr6mtygdQ+7GCQg1Egjl0e32jm4KCl8gV5G6WSosMZmMW8rKzqo?=
 =?us-ascii?Q?r0fYOO6J06rRv1aM3UOhUmpKWoIObtFmEUdP5ObEu6/Qu3vpDhDzDCPjHBvV?=
 =?us-ascii?Q?M17A9b1o35/2hDkIRkOaHyaMVfH9rToY7BdgOZK9yng/Ut8696JiY2X5P+DU?=
 =?us-ascii?Q?+aVgSXAKvZZ+shbl/1Mb3YGtwY+HhyToFM7R7cTQmTFsu6ki5/R9M1ztV1gY?=
 =?us-ascii?Q?h2AWr4d7sLkXmfEXqshStUiC4Zv8feHrGhij3kVybA6keZYBrvJsjlrAUcrN?=
 =?us-ascii?Q?JPjZwD9bzvedzTnC/DIw1Aw6dMwhYBVt+6wzBV1yk7/P9bn3gHZAuh0kxkR5?=
 =?us-ascii?Q?pSRfaocVpbpqEl9LUrnvZN/NDNk+qZ/YKhBo7iAx900Y7e82p8Bju3aBt4Zq?=
 =?us-ascii?Q?AxmH5IdiRsWlsZ+7mJT9Woj49cq4mYdJCJwjs2VARMTgk8CUPKn+zde1o2Aa?=
 =?us-ascii?Q?/e+gaZTryySispcbRHaFRSDnd1lMtRhlNZYIxc1pyWWq++RHbBw7h0/xMx+m?=
 =?us-ascii?Q?hyDyE8Koxoiknz3AaI3c8xo8PGiXhrSriqxAw0gVLSjj0gI1m8+Hmve6dtLf?=
 =?us-ascii?Q?GxRIVZ08Q9skwbkqNmGHTSnryePMV3hM2AiDDI3+GaB0uTFfWSIMs361I3Fs?=
 =?us-ascii?Q?pK7n6mA58NOWAyFmRVzq28b9fBOivfEMGDqapFbWWCzLVsivR0Bb8qTLZ3Ri?=
 =?us-ascii?Q?o2DLJpMBSDSOe826d8hwDrvfjb2v04CvL1a+c7HZpNXPD5QpKYH491RgF3s6?=
 =?us-ascii?Q?aAstI2k9Qn0CBMm3Cu2o/yOcIxsoWlDFjty6SaggeiWV1ovUkfG8VG1FnCJK?=
 =?us-ascii?Q?qZ9vmEttSZoMveAGPkTCfvicXoDZ/qHmv+Ua7h81xxXuvK265tjosVkeFyC/?=
 =?us-ascii?Q?pO/8dg1O9uEIRnKXy539XOlMaoPaEYxxroxXPHk2g81iPzxl6gSopww+88/Q?=
 =?us-ascii?Q?/L9/WRn3Ii+KGJKrE2eE4HVPq3PwF0ClfQ/VlGW6EqR8STHB2Qg2MTmpMXnO?=
 =?us-ascii?Q?gbj0vHds6n+fwjbxkMsovk5JKcA8fv1SNfALqB+Ltvik3bkZsf5pyvxtMpAn?=
 =?us-ascii?Q?CyPmhXQ1XLPATahm6RQ2SQbWlDsiso5Nf0blVAC0aeVMfSwwiEOcC5iyjjou?=
 =?us-ascii?Q?TsOKhmXJnj+YWy3QaeK8N2cElWj4G2MhqwA97Rxz70lDyxmk6VGPZCimORkX?=
 =?us-ascii?Q?ivptJDQpfwIAQMJ911563HcvOmYD7xhriEitP3zMA/S7zJmkWlkRsUw3G8H3?=
 =?us-ascii?Q?IwU0CoznDGVG4fKm7Ft4l5266cm7Wud7cMMY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 18:58:50.2234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0883be-9871-4256-9fab-08dd8686b691
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863

On Mon, Apr 28, 2025 at 09:32:04AM +0800, Baolu Lu wrote:
> On 4/26/25 13:58, Nicolin Chen wrote:
> > +int iommufd_vcmdq_alloc_ioctl(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_vcmdq_alloc *cmd = ucmd->cmd;
> > +	struct iommufd_viommu *viommu;
> > +	struct iommufd_vcmdq *vcmdq;
> > +	struct page **pages;
> > +	int max_npages, i;
> > +	dma_addr_t end;
> > +	int rc;
> > +
> > +	if (cmd->flags || cmd->type == IOMMU_VCMDQ_TYPE_DEFAULT)
> 
> I don't follow the check of 'cmd->type == IOMMU_VCMDQ_TYPE_DEFAULT'
> here. My understanding is that it states that "other values of type are
> not supported". If so, shouldn't it be,
> 
> 	if (cmd->flags || cmd->type != IOMMU_VCMDQ_TYPE_DEFAULT)
> 
> ?

No. Only other (new) types will be supported. We have this:
"* @IOMMU_VCMDQ_TYPE_DEFAULT: Reserved for future use"
which means driver should define a new type.

We have the same DEFAULT type in vIOMMU/vEVENTQ allocators by
the way.

Thanks
Nicolin

