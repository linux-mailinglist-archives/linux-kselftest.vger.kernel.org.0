Return-Path: <linux-kselftest+bounces-34388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F32BACF4EF
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 19:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FCB3AEBCF
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F85927780C;
	Thu,  5 Jun 2025 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lbLiXaFO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF302777F1;
	Thu,  5 Jun 2025 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143102; cv=fail; b=sSCDm0/tNWyiN5OwPQZ5M8IGEO1l1UYjYMUSZNSWF2ToWvfxf9jwPlk2eP+Wah73elsSROp1I8ADgLzJj4OqNTGWWG8eENKcppczpJ//T+G7ywh7sCLf17j3F+v4vyyQ5hzcQ8/Fe5VKeccmqfXCTwkp+kCS5r4KCYaONhmwlHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143102; c=relaxed/simple;
	bh=MNhi40dcc/jq7WUwSjINafDiTVS8LwElfI4X0KwR0/E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qe56bmM9DG9MDNc4f05SlRkhgB6Rnb1xCOvHJAAbPl5xvVFqiK5QwNC4rBTR54pkLirWhHNDG9F3cf7IJ0VQvniZml0f9mGLQh4vLkuVtwdImxqljverF9kp9JYvxnq77j1K1rpuyEZcpI40fXm3IMcbIAJgvsEerg6io9DZCbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lbLiXaFO; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKBvmfMSNNTQ8YS3AATzI82+KRY5T9/ncefc3IazdWzoVp6k3nw38cPcYQHog4v1UCUg1YJx0kFMaLn6v66yA0Uh2dsLR9g5mo5h/W+DKgAphPbxLtNydkeaVcPrnCpD2qdz3+du8nMT1hxCrVH/2EmOFH5VDrWi8ZfIHBSRhRFj7LmDCiaNfYEkxDfRlIgoPWpogkVLFhpi/KsJKBnhzshwjLWKPEV1kO2Mf+8Wu2e8W1jkynrubRNNjcFimpsxEeGVkmZX8tbDavPZ/bnz3Zls5CuQNZ5G9+tNT8q4ne31+9npWXhwVf1dU/9ciyOFpbIWbeKYv/t46pgMRz+AGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UX9kPUP8/yZb2YGv61Znrbu5egff02qnf5J0x3nDwdQ=;
 b=HDgGGk/bZn+Uv0HN1wvuGbarGlJHNRW8oSYk0c0lvSF/GO4ComxDqztXdEjyhMFEGrNOeq1rQDjHg9JdxB6cocILMG8xnJ23om11j0qJMCio8b6CNPXtYSqQFQjQ+4ueonADSsfyvydA79+vGnw5VJQiYUuJfnbsDl6BKp81Cc0AQtG2D/fEQrk254ZiNIo9hckN+qGVu0AiAwfxmscfxWhWojiAdOLeu2KxpyaxlpfKlsJOC3fthp9rM0R+J4Hfpt3i9VbUn+WlsH13yJalz9LJreo8jdjF9hAO51FDWlfnNGg9JCpGy5C2FYangayIE/aykVv22/EirOWtBxQGWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX9kPUP8/yZb2YGv61Znrbu5egff02qnf5J0x3nDwdQ=;
 b=lbLiXaFOg0HhHrXxOdEtVVGzxadJjVLo1kKybjn4agGYUPTa5dsOO0cccm9KmUJZAmmDBWJQUPzsCkk0TH84gOC73vVfhxhLVQyxbEez05z2qVpKdOBvFYOwiMGhWmPj1p+UaShwQY8pNFpWF2mc89IHKSOSknDEpchVpDiR32Xt4hy0AVvw9O3ME1GC7yloSIjuSIsZq4H5w2pTvr0R+Na9Ix8fA7mTlbAUNos2GqZLIzzlC4V1xpG92E6nfBfL95HgQCU7+nIz/u95NTNcst9GHXQ0QWjfUidTHsxIK/7cOyOCOExnhbezXK5++0A3qI4HW2nipUrCLY165Fa+PA==
Received: from BN9PR03CA0691.namprd03.prod.outlook.com (2603:10b6:408:ef::6)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.37; Thu, 5 Jun
 2025 17:04:57 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::63) by BN9PR03CA0691.outlook.office365.com
 (2603:10b6:408:ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 5 Jun 2025 17:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 17:04:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Jun 2025
 10:04:39 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 5 Jun
 2025 10:04:38 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 5 Jun 2025 10:04:36 -0700
Date: Thu, 5 Jun 2025 10:04:35 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 10/29] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <aEHOI522eucrOZyI@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <49f7143c1b513049fd8158278a11d9f8b6c837d3.1747537752.git.nicolinc@nvidia.com>
 <20250528171754.GY61950@nvidia.com>
 <aEEY28ZXH+NqiE+T@Asurada-Nvidia>
 <20250605151648.GD19710@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250605151648.GD19710@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4238b6-a9a1-4952-8136-08dda453197b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?plp2PCo+dNST6/wPQi56NMcqr/eWDv2kDmU2L7b15KFFIO5rsRKDJEJ25KMl?=
 =?us-ascii?Q?hit9VorG1ZDAfsmVwXt8iwyOiZc2uU+/C5ugXbLuGiC4TUjsWv67ubehwEpX?=
 =?us-ascii?Q?RUc1r53NNGk1kRcq00U2asSXZehc9CfUnUURF3qUXCYEex3XrjRH24mWQNmg?=
 =?us-ascii?Q?wpnhTkun/ujHQsSX2nC/mJodkOF0HgVIk18Zh/ivtl4d4vbDBn5cCxPPRkLJ?=
 =?us-ascii?Q?l0OH6bRkQVk52D19gIIFV5KyCVaevt1irrPfpbow5coCpVtKrxNov75P0bO3?=
 =?us-ascii?Q?YhEECuRSEU2ttiRZ6hEO/pc90FdZhbDanwx/YAnUXlpUDkDL4ad0nnMEz3pR?=
 =?us-ascii?Q?rsGOGgm8W9CjBSV30A4nETNwbBUKEgTKhCwtHEOA+/qtMxwspPu0OGxk8WqU?=
 =?us-ascii?Q?jble9k2QwgW5Z0vu1YwtrJLgGn67Mi0OGWV87Fie+JxYDQRuWvMEtbw4ditu?=
 =?us-ascii?Q?Npu7U8H5TTtZr6mVTMKjeyV5js7wocX83+ebCbPipwo2akc0Jyf+Tk+gnV6O?=
 =?us-ascii?Q?ilNKduo+r8OslfshIQ5IaiB3euCswNnyDOcrNsb+sM8gQx4nuKUehJu6gdtR?=
 =?us-ascii?Q?yhXOPovP1GpevBTQiSPggtwaggEyhSp4iZKxyv0bxpbxbLUKhx3AXje+nmSE?=
 =?us-ascii?Q?CdbXq6qzVIsRPx8lPY0mG29cjab6tIgj9zx6utZ0kezv3dINDgt4E1ItYpnh?=
 =?us-ascii?Q?lV56ky3hdnUHuI9cK/FwN6nYV4Q0WKRap2s2BSDrSfHHEvruTO3A04+mmYUv?=
 =?us-ascii?Q?bgBq9RlgclIH2rV/TE2LlK2njOGXOvKj20bUkIEv9ISrfuVK/+gvncX2pHUm?=
 =?us-ascii?Q?J+bJfF8lgAa4RYvu/Qo2sEQNO7G09rlIg9uwKmED37LJFL8L8fS8YV6aEosP?=
 =?us-ascii?Q?0agI8cyKZcSeBzTt8hyv7IlXIAbUxSYrLhFBL3+NM4fCDJXs4t0V2LDZMzUq?=
 =?us-ascii?Q?mWqW3RxR2xI6HTPDsBBJj917wl1CaF3JMmKNpRBDxGLo0wbPsfLbAya7uy0p?=
 =?us-ascii?Q?Hfd1PvBE2tFT5HB+Pu7OpQ21gOrIaiZY4yqN2L7UeuH0c31KOBXap9/ChEwO?=
 =?us-ascii?Q?fIrExcEU4XzHWdqJPNhi0MrGl63iixraxpslvywLsNsjJQJ2Lj1hKZm9NRta?=
 =?us-ascii?Q?J3jNkOdAQVc2kDcNUxRBXikTTr+70GjkEio8a/+NXRGExzgmzuhxL5c0g1Qv?=
 =?us-ascii?Q?w1PYjFFc/g2h7GRLdYrzolW2zPevwTsoYWVqrebTqBZhT5Bw4sx00IhdoGQx?=
 =?us-ascii?Q?21e1dFm5a+3eRuXg2SwkAhmFi9vHvuw6kV2RpHi3vk5juRI/0o37WVbC8sqG?=
 =?us-ascii?Q?ErQj20fSBgiEc5h9aGU9Qg5/sGlOxm1rDVvg+UYwUSUT8K5WGbjfwBj0TW6l?=
 =?us-ascii?Q?nA/ODZ5eZYlltJpO0SbgAew/s2SkoHfK+VBmHAY5evhXYWyBMGdTF6T3AJp1?=
 =?us-ascii?Q?5gSxLSzDjsCSEJYgE3mGdBYpJjtOSx9On31fLLl0Wv689gSndH7q6qwDPwtd?=
 =?us-ascii?Q?VlPVhbwHaIgb1ON4SRgZWwSWv3oaJZ/ahHfo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 17:04:57.1196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4238b6-a9a1-4952-8136-08dda453197b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451

On Thu, Jun 05, 2025 at 12:16:48PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 04, 2025 at 09:11:07PM -0700, Nicolin Chen wrote:
> 
> > I found the entire ictx would be locked by iommufd_access_create(),
> > then the release fop couldn't even get invoked to destroy objects.
> 
> Yes, that makes sense..
> 
> It looks to me like you can safely leave ictx as NULL instead of
> adding a flag? That would be nicer than leaving a unrefcounted
> pointer floating around..

Hmm, there are a few iommufd_get_object calls using access->ictx
in iommufd_access_attach() and iommufd_access_destroy().

We could have a set of internal access APIs to leave access->ictx
as NULL, as an internal caller has an ictx to pass in. It's going
to be a larger change though..

Thanks
Nicolin

