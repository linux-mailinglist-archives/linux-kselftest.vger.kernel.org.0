Return-Path: <linux-kselftest+bounces-33092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D804AB8CF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8634178FC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 16:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F27253F1B;
	Thu, 15 May 2025 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UjHV0VP9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5AE253F05;
	Thu, 15 May 2025 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328209; cv=fail; b=OdDJix58cApSibqgwyj6l1y6u5fBFNUbZxfzQNvn2w2ixBKOMJXoxpshTvTr/9SnLVnMUf+TVsXHTTfglRTRgtYYxNHUFXwZT/co0TT2v8MoUxLw+0JWnAhba/AdQiU4cpFXsofNMCT/rUg3uKyt4EIT0Zu1phBiEDEuEUMWboQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328209; c=relaxed/simple;
	bh=626HWBWOu5WVawxyo+2XXE32qX6zhUq35Xymfp0F9qY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a79878KH/HwLGtj7nduXaB9WuHqTu5NHKZuR/o5U8QZz8UVWl3LO0oqb6SDr4YVXOon8+tA2ph0AXLDmql0/+nM8G3JsR02tPmv7n75mYqCK9tsU4cqvCxRLVYLv1UX6v+rO1m5aa/Y+H2xRtDxWwun/voBb420IaME3f5XdS8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UjHV0VP9; arc=fail smtp.client-ip=40.107.95.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ip8oMV0TJ1AUPJZXMACFFfFEm0Dc2GWOQa8xxQGxYsmbqSCLPLeICRB83ni6QsAkoQHiZPHphmXvCF2yAcOQZFbmYKvr6oYvVPkpszPN1eSQUWgWwPyviHQjBMgKcgSwHSDqIhzgoTlc+UutNOnYGsnB2fs8Tonmvf7aXjRnFbFyPiJ62cRbHYG3239IdFWUqM9fc4OroDAEWIR6QXqI0aRTWfy3XlikAIpkbk7STsPxMHGZI3rM9UQu6ERKFvBDJ7IIRk6bOzycPcoXd88YlcGbxzFDztNNyyNnQziMF3Q5O/jqikaMmkbvmRtwl6NbnTvEM3LiRcUF918ARJbHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PgQUoFlW1+3+H1a42tCNbSfRCLA1G71EJ3PxynwEAo=;
 b=t9U9HE/JXFa1bnWBHhGvY5WSjd6hCmRM3xG4QBQZ94OWxA48OXV7y8A56UkK/nFtwKlHOz7rwM+yDUANJt4iuziJq1wpT3vwOxjI6C2i6PeEvPwrn4BqZ4upRdsju3PR2m8gJWT8dYP2qCZHiv3OlyZbIOkQCwrp9mLH51RC3+/QqqoZcxbzCbqqBQopehE9NqpJs/5KU4fhzZzHxkiKvVH6SGZy0vLnlEE1CyuW3tjR8OKN180kVOHbU9MFy2fTWX9if21+zzBKoM+SkQs0qqhtLEUPFCdf7sQT4L6Ad6Fkc7KylhE8iigCpvUrC3LSKGUVcw+3Uo7uXAVcgHOv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PgQUoFlW1+3+H1a42tCNbSfRCLA1G71EJ3PxynwEAo=;
 b=UjHV0VP9Izw1CbHhBTkAdeZD3MgNvWt+tr0oL3Z3SBHklfRTWpDOgJcuLAvvKQlWkwYTa7a5fZNEnVQChjEY3VYObHhFImbvwTOpF2+xe49RQdyQVapCreqNCF9yKgRCu0003jy5kCw5RzoyLL50Nn0mmsIsJdEiHdNVQ/Ym7y1SBYlcaNVCMks+OTJfx6PofOMGIp9w4RhJGPdd312BTrt6CJKRtKKF1i66ZvDf/5uAMyo1uEPnhlfzeaceTiLLAnaaAn9kklmB48IfO1gmpItQMQT6W+A0zhY9NqhhemRNOt0Xxirb09GCdPysOvOCv7sGMHPTCYAhd2KPb7SSfw==
Received: from MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::25)
 by PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 16:56:45 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:8b:cafe::52) by MW4P221CA0020.outlook.office365.com
 (2603:10b6:303:8b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.30 via Frontend Transport; Thu,
 15 May 2025 16:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 16:56:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 09:56:37 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 09:56:37 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 09:56:36 -0700
Date: Thu, 15 May 2025 09:56:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v4 03/23] iommufd/viommu: Allow driver-specific user data
 for a vIOMMU object
Message-ID: <aCYcwstCkyGI32QM@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <86b279e902a3fe624ca9261b84f378d62c5049e8.1746757630.git.nicolinc@nvidia.com>
 <BN9PR11MB527638DE22441D662B6C81EF8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527638DE22441D662B6C81EF8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|PH0PR12MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b61b96-2bd1-4e34-e2df-08dd93d179c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FMjJeXsbdkMCR1lgB4D4kK6MuGd46kICphFVDYGydl49Cb/69PYyOXPpilbP?=
 =?us-ascii?Q?sHK51cSSRocihKWJVZ9MIqcZrOS+YVnzPf0sl6V8x4lCjxPRFi+R8oU2iJbG?=
 =?us-ascii?Q?tLiD2E8hBHuPye4GeCkbkIint3PWlzw4Bl78XWwAVezTMN23udjWO1gAvSir?=
 =?us-ascii?Q?hOQea1Mb3teOX9bNGrnMnfYwL7W8T5+oZwTDd1KQ3g81B0t7Js7++0Qe+ld6?=
 =?us-ascii?Q?bO7zehjGr6gXLhUiWHNnfU45LYvt0v6qeg6CEFMgMJgCyHHC7G/sh+GL7FFW?=
 =?us-ascii?Q?OafRoVclrXBsG3j5rhdQxDJsE91C3ZgKqw66x7wGZoMjk8WVxGR7czlidfTv?=
 =?us-ascii?Q?1LSs8E2u9yxMndMqmUNu1xgETrPssZE5FNK5jMAHmxcni2tRMpFb6O0RvrgW?=
 =?us-ascii?Q?53EY9U6amLC6nFyWTq3RRHej1MoDPYtWZZtrqbJlev3F1UKyCSEz5urKbIXB?=
 =?us-ascii?Q?rEDXoHTD8MPPBI6TB6ky4tynnqgvjRKXVVtVCGVQQo9FbVSlz3QBRy4A6mjI?=
 =?us-ascii?Q?IZagliF3TGpGZzIrxDxBiRDdYmzBEVWry8fpiITupNKjhQUo/KYH+KfuxIb7?=
 =?us-ascii?Q?zCTHPSGRu3ozOqLQ6o783dZKBfxLWkA8jIg73RGzwk4thwGjDvtYV++FsO2G?=
 =?us-ascii?Q?2Uj6eII9fTw5zFZFilE6NtoDkMxOq8DtOE4bhBFahQ+r4Wbj9DS9HMv2ub6W?=
 =?us-ascii?Q?73ryToNHekkEQa9IKRX/6XGD4bZYF8SBsxyYwBaTiOZODhj4WNiysR/FUquB?=
 =?us-ascii?Q?3elmChSgTQJz7Lhao4CtAHJoIPs3TI35CyA9o5f1I1cudSuw8sR6qLZUkodt?=
 =?us-ascii?Q?3a1xTrzqHe5GoQB61vKiIHoi9MbIKRTN4Hk9JV+4CdH/VXzgCeu8MOXHh1cL?=
 =?us-ascii?Q?zJdKVxegIbcIJwlRRyezs89+m6xGnk1rzVwOTohbxVGw/oKSElq8a52+L0ng?=
 =?us-ascii?Q?hb0LwwN2w4m5ndmPquDK01koViSB7ZFzWDyzPeIbwSYU8PJy8nRlM/efwr7q?=
 =?us-ascii?Q?X+Qm+k82vsKCW6mcOAU8Rix3BrD2zbT2uS/CHW7zbqaD8rmuJNEbp/RIpWGO?=
 =?us-ascii?Q?fjMY2h2O+IOwkkz61lAehpnGGJUHk0Fn3vm0/1LIExcosT9BuS+NE8Yo0ym6?=
 =?us-ascii?Q?rDTGt4awXUYWt6NSiVShnqCKiWXgGZ9jRQVRrFYftwO2RrAnhBY2gRSjOQgU?=
 =?us-ascii?Q?zZ0+5gDJeILrbVwhGkTuFwKdy/R1mUbV75hvAL/CkL9sWUMb18Rrt45xyV0c?=
 =?us-ascii?Q?ylQFt01xATmSr6gZVEV13LVP3kme875jR4DA5aFgy3fM3FOti8K3BAwhLI3S?=
 =?us-ascii?Q?KP0Go3gb3s8kABrkw0qupP7lJhmZsgc+yjydB1+o+M9i6wD+0ZdiB5FyC/dN?=
 =?us-ascii?Q?9ZoRhf51CtdIMXp3rFs8YDT8nIttrou73auUnyGT1HbUdMD7z+uXXDMhQm+J?=
 =?us-ascii?Q?H8JxYf+KDVcZ59ObZlWKcNWSASjsu8W1I155K40WCh5vFXusmC5BAU4DOZLu?=
 =?us-ascii?Q?mQuQ0GFU7sUxB/8m93YO6VYmqBuriBP5O3/h?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:56:45.5766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b61b96-2bd1-4e34-e2df-08dd93d179c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077

On Thu, May 15, 2025 at 05:45:40AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, May 9, 2025 11:02 AM
> > 
> > + * @data_len: Length of the type specific data
> > + * @__reserved: Must be 0
> > + * @data_uptr: User pointer to an array of driver-specific virtual IOMMU
> > data
> 
> I don't think there is 'an array'.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Ah, copy-n-paste mistake. Will fix.

Thanks!
Nicolin

