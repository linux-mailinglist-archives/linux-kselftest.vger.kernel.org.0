Return-Path: <linux-kselftest+bounces-32019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BC2AA44AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 10:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A29173BCA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 08:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1B620FAB4;
	Wed, 30 Apr 2025 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s30esJZJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7BB1E9B23;
	Wed, 30 Apr 2025 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000133; cv=fail; b=LS8J0cUmRdobUBKHQFX2IA/moMi1Ca/gZ8mOA1CSDGAWfJucETH1jdRQ3DWRGt8HFazsIkHgSQoSgCjbZgx/Uh0BwhrMBL6fokFoHZIt55aajr6Gi8cGGVEYwZLQdfaUbzNEIvE+nkXJUV7JRr8QoanhlTNdvt6p2PexUWz25Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000133; c=relaxed/simple;
	bh=41kqCo9OPsBLmqQCPvj1mwNqmDoXMu/7cLPuNBKkofk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndADeBafoiiunGRzyCOJNsl3vCqYfky1mnB/7ALzoRyEq80LuRPhSHM1tKdnB7Jr8Zc3Sp/K2K6VRj86pVldcoa+J6OSk8/G9DrpjUdWzloMuaQFGZWjVOWTK8pEnJ7PEkgoO2G4H1uDKU66Ts/XfHX4n7iinVvBtmzn5JMWc2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s30esJZJ; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj11sHfPUFsl+Bg1gpPPzO0gV9+vIsu313rghF8BNxw052E3jj3YyTRX/UeE3IdXW9j3wYx5mkGmvVtzHCFbgDMLaY96HwR3bjQzuP9QRVdjMeKJr+EKBNKjYtKsbe8wXkmZCD7y/vLl36RZ8hWBUCRXRNnukkJdCyl7xZNyAjCOcA9ofZanoqPsWx2CHQ0fw4p9NlC+SKD8aPMabs/S6EymFbYVrZ4d+Z+6oqxSY+zupu6cl0NL1Ryqs/oY2EtEfV05aEdlOuQv/TefXrIjiwhPIak4WX1cJSwMhkFvTULXLc/3s0rpjXeErYqNuyZ6624rGDIANIZAUYult1J1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAB7RlcS5TQd1fDlp4I/1yO5reiRgBbxBRTGiWpy/90=;
 b=BWzMaBjNFoolfBVuEXkC0qeQx+DdjeDYqKtKIjPWcjeE41OXGsPUvKy5p7+6ocqUPfHAns/ZhZzsbgrVUN4xqaTL1vhE2xw7oLMzY7kyBvJXKxVImtNBQabLMhMmAsTuTsOyu5mUrjNVSkjIBSAYCVX3VmCv70kO/vCMK6fZR25XdCDbV12fxXikxUXzPaNLp91VWfa7USSxjNHsmATIsFXCcrh3G0/dkBH+8KEL4BZgl4sfOVrQ/ZYnT6MLNrth1FTuSLdJbx/1sDUTKqLpp4pitrgKnCVCuV9bvKozZepJBRbP5zLIes29kTt/UkOWlMD90usLEb8O+MiGF1XMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAB7RlcS5TQd1fDlp4I/1yO5reiRgBbxBRTGiWpy/90=;
 b=s30esJZJBs+fWjE1oOH5uANMxiHgUXCWyePTmkX1+Dtph5RH5M11q6ahp4DX16bL935P4EPyRWCuw6dOLmyovpMF4VMLzAWSh4Gts5Z9No+fapzdIDVTKEjrG6vvG7suMdTQXfiYWBbcVWA0zzSHyWrtzU0dzVtVEY1K9AcBxzWq+LyGd+krxXsL1/I0HkVnhb0ScCohQSALa13B8fe1D0k6ANwhsow0AuhpHi2LVvz1ja3VCGXrR/h5ch6q2q6cydZrR96j6SGLgiM9piHgA9pZXJM8ftiJyoxnU8qBjQgYs3pMSYfvhos8vsagrPGbw+qf3w/BxoXG6EC98cyqng==
Received: from BLAPR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:32b::15)
 by DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Wed, 30 Apr
 2025 08:02:09 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::a9) by BLAPR03CA0010.outlook.office365.com
 (2603:10b6:208:32b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 30 Apr 2025 08:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 08:02:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Apr
 2025 01:01:59 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 01:01:59 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 30 Apr 2025 01:01:57 -0700
Date: Wed, 30 Apr 2025 01:01:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
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
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Message-ID: <aBHY8wOmpMOxelE/@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
 <b0d01609-bdda-49a3-af0c-ca828a9c4cea@amd.com>
 <aA/exylmYJhIhEVL@Asurada-Nvidia>
 <b8338b47-6fbf-44ac-9b99-3555997c9f36@amd.com>
 <aBB1gLfahnLmn0N1@Asurada-Nvidia>
 <a3860aed-5b6b-4e68-a8fd-1a6ee28ba022@amd.com>
 <aBEI+T7P+hV8Y6tU@Asurada-Nvidia>
 <7c813df6-e37d-47ae-9b5a-b8735c865626@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7c813df6-e37d-47ae-9b5a-b8735c865626@amd.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8c3e13-45df-4f02-1e89-08dd87bd4ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vwbV5/hLSv+in3riSOYPtwZJnrqhj+mhENDHkS8ij0XQYtWD49vuxC2Uu4jF?=
 =?us-ascii?Q?WBxQBTMzSMnh2SuCuDB41fThXJXpY7dwnBjLgLnvIFIMlcbEOrBdyo553wGY?=
 =?us-ascii?Q?Bw05+y15rbJTzx9004NkvYxPAio5vskAXQsmee7FhUB4w0FQbdS+6n99THON?=
 =?us-ascii?Q?6stYbnBUPfPSJjPBVBf9e1CmCwDGgNGEMAqsdWqqTEZ6KGJuiO1LdjXIC5TG?=
 =?us-ascii?Q?cQdAYr9gdcDUItKGbbB/oVqX0Oeky2aH2rsqUyl5A78qs9Of3qxpLgGaQI6d?=
 =?us-ascii?Q?X3thacDnLXi5DP7BAzbc5tDXcnLcMP2CwiRKDydY7Ns+c8tz01szvWiGIkkY?=
 =?us-ascii?Q?6+IC5rO7ZG+V8obSj9RnR1gkDnipDpfLMXD9MujPjNBwh8VX6FdApWvfPHnr?=
 =?us-ascii?Q?vx+nCasmlAHo3lc/GonuQFySqaSelPY1jjeMJFWd6zhVvYKUNgy23er/KkRU?=
 =?us-ascii?Q?Xn2IG0SgMyK5HY9rv8sTER2pS/CLLqEgIyAOKMqJQStTN14eggMf5jm026nT?=
 =?us-ascii?Q?r7WpYBA3LlD8SGmBiQh6/F8F6jfY4Kyi8JZdULJB4AeK986nHZ5vp/YRDiX0?=
 =?us-ascii?Q?IfJmPOG2EFuiesdsrH/+Inf7/UkJ2JGYkYQnlWCOjOsrZEDcF1eFxfjLQ3SP?=
 =?us-ascii?Q?YgzwTKWo9D5ut5zDrx1g8/nqYc4c842mAaNBs389mWFcVUbqs3vB9u8N8gY7?=
 =?us-ascii?Q?ckQFpOn29HJ/MwH6vqo3i037voGaacQwAzbRfEU6Urck13slI7pF5AY+KBM+?=
 =?us-ascii?Q?byfE+wV+aVAMm7MMWGipMRV8RCnypEv4iT+jQo4PfQvdfvhYqwdMsVGvBIiP?=
 =?us-ascii?Q?Hwq9jjiahc/LoZfWLO3CxfEwsz5rpFclAM+IOxSHVl1TMebTr71vqSUVxilv?=
 =?us-ascii?Q?joRrsQmi/4E9vhHY7xbnMN/M/udSt6+wl/+jGzMTjYht+StEz0szsdBC2d93?=
 =?us-ascii?Q?fABcxpsTQxAdAQLmwGVGoI9WWRYi5cAt2b+2SXocUC6Aj6aUKNLo6uhlRpz3?=
 =?us-ascii?Q?SIRax1VuMwyz1Jb8q9pN75wLn8MlH6Ja+s2ps3Hs5MbwYe4MbwwHeYTjW1Pv?=
 =?us-ascii?Q?3E9el12IepE1723VMbR6zYX869WKZcGtfBbX8SbHbVFi/5EnH7/vErPnbQON?=
 =?us-ascii?Q?ukEFc/tn3lv04BxTBea6pUtRFw14cIPsoxVUAAJ9FQt6ojyJEmdRVVm7N+2p?=
 =?us-ascii?Q?PTVEIshl6bb6eFDUKo4qUDK20oylm2TluoPO5U6vo3h5V9XoCBk6yIfurFYS?=
 =?us-ascii?Q?hCnhHq5RW4uWFaLbZmAncQl7kEufm/Lm67Y70Px5LopONhwLYcZT8HZSHCDi?=
 =?us-ascii?Q?O8D/gX6wzaDoh3eH4lMqqWvOZr3zDySSNHecoSjRxVEEoWEdcr3uuykksQUe?=
 =?us-ascii?Q?vBc5zWlAEx+qqX6Hmc8GthHXno8qUXGbbEzyPCQ8eEda9tuLQ3Th2sZ/10DP?=
 =?us-ascii?Q?hfpJTP57ltnVQxP7rKLt4Pj6Kh8RcwPCu68/Egzygf7+IWlZLMVF6+U+lRrB?=
 =?us-ascii?Q?0I/6g63BqI+FiZhLi4qlxnzwH30x1nxX5/Ek?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:02:09.2794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8c3e13-45df-4f02-1e89-08dd87bd4ea7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D

On Wed, Apr 30, 2025 at 09:52:09AM +0530, Vasant Hegde wrote:
> >>> Will the hardware replace the physical device ID in the event with
> >>> the virtual device ID when injecting the event to a guest event/PPR
> >>> queue? 
> >>> If so, yea, I think you can define them separately using the> vCMDQ
> >> infrastructures:
> >>>  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_CMDBUF
> >>>  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_EVENTLOG
> >>>  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_PPRLOG
> >>> (@Kevin @Jason Hmm, in this case we might want to revert the naming
> >>>  "vCMDQ" back to "vQEUEUE", once Vasant confirms.)
> > 
> > I think I should rename IOMMUFD_OBJ_VCMDQ back to IOMMUFD_OBJ_VQUEUE
> > since the same object fits three types of queue now in the AMD case.
> 
> Makes sense.
> 
> AMD architecture supports 5 buffers. In practice we have not implemented event
> log  B / PPR Log B in Linux.
>   Command buffer
>   Event Log A / B
>   PPR Log A / B

I think those A/B should be dual buffers of the same type?

Anyway, I have renamed all the core "vCMDQ" back to "vQUEUE" in my
local branch. Will send v3 in the next days.

Thanks
Nicolin

