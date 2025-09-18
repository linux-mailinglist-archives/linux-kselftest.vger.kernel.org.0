Return-Path: <linux-kselftest+bounces-41804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97406B83037
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 07:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F98E1C0843A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 05:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FD928B3E2;
	Thu, 18 Sep 2025 05:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g1Jzk95B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010019.outbound.protection.outlook.com [52.101.193.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F2427C162
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 05:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758173330; cv=fail; b=SdrYH54WFsAwkUNZ8PmbEn4j14P1+F6r/ZYxqJJQA5RAjfXpcWGGxCX0VsVoafCUkHayses+D6/Cq1pu4+DUUAfK8UMGA7lwfb8KVtEw66xAjQCDhPS9YFenAlJj9Y7rMHCcFSG7EQ7jDCMlYbk8TYzChyzFfIJU0ea2sCqKdkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758173330; c=relaxed/simple;
	bh=9wVa0E4CPyue6lRyTPrAXf90U9BAgiNfGGjcfr1+fc8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sr5QNCZ9S/sdGfXH9XZdi3UxqWgmERestgqxnde+1hyvuBcNy6p4RJu2SD/lDonvAghawsJ2N4YdhC+7H4FFw45uXoF1zJ86qfpwt8P6lC3U0004sFS/dmIOfMgIfSvkV/+VCVatQv7sygHFpS3UXmxjJEhHHVSfNeW/tHsSmD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g1Jzk95B; arc=fail smtp.client-ip=52.101.193.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jD9MMKROf+AsXyPEtsuu5D/ydYgruFXVxKy+OfkutFOs5rbZW7u96lOcKpj3qP6D8AgAEJ2sn+Tr+HTwHkocGme27R68vmVCKIZO7kaL43VPYpdt5Yr7hZj1nGPTg9uD56SzQSXyNwRArjX5vvgf4xkzUzs1VgfRDJv4Bafdg0hJOlDeJQfVjjY5gPuuyxzWcYqUMvWvtLolmnYt3BmUu9khDVasIn0p7/S6RS2Z4TTm1CQ8MgxyqDP4HHm6qcv0KbZO47UKdCjObpyYEJH2IlcdopP/vLCM3ENRbd4hxw0HH/O5+jDD4UzTEx357zwRjyZJi+VzSQJU/1up4m2WEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYONMk0Vto1BDnRVXITjwvN40xL6Ggryz1TnTMI77DE=;
 b=YO5IGzH1T6EioCIx9rA5B2lAsk02NoI8egAjwQ6SWY/eTEixyMweu5TXrih6Dl8ioThrAvWgPs1mdwZEFxIyZOnXr8GnpFKMdzFMj56zW/iHz7cgyTDgrqT7ait/r0n2JcYWkgaMLguuhdZLx4rtCYYIbbkcTb63SKVX4MLgdfzg4Q8xxFxdl4pk1PdIjB3vz7K3wXJ/8xJeg8SOxeWarKGU+7BGgYn5bNFsnbrK1h0CA6hcWIHhlzamlqJ3pTHDIuzdJYgUgnJDPJKYENovJTSQEVx36+7BMufntq7hasl4ljEvCfZNEwLgfa+8+NAaVtIo86oDPWRlDrRt0aFkaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYONMk0Vto1BDnRVXITjwvN40xL6Ggryz1TnTMI77DE=;
 b=g1Jzk95BK5Y+efwza7oR6bkoi8bTNnqCk+es4PMg4t21xMi1U3r9qaAEiZ0szcCOzaIz2dsO/LoiPYblakRoo1gTTG5PwMzpqC4hgn4i+JB4dS/Eg6IJ1fIUVbe0tRUVCxiEn73gkUw4GU/usn9OqytUzgeAEC6o/wtD5b9brOh4bswOuQ8SAIDWvmlM/yGwrfcYtHAsl5HcTaj6uRcOVpBSZcm0YG1bIdXApYSHt8SlDwOsCenQsj35g6n1t/pu5R9MXEnC+ZbhQtwGWYeYRUg9CPeklh+YIqdBhli0sql/6VK///lBE8x890sRUd2RPY+DBroRlWB0aW4mhOL9Qg==
Received: from BYAPR08CA0015.namprd08.prod.outlook.com (2603:10b6:a03:100::28)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 05:28:42 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::a0) by BYAPR08CA0015.outlook.office365.com
 (2603:10b6:a03:100::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 05:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 05:28:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 17 Sep
 2025 22:28:29 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 22:28:28 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 17 Sep 2025 22:28:27 -0700
Date: Wed, 17 Sep 2025 22:28:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, <linux-kselftest@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Will Deacon
	<will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	<patches@lists.linux.dev>,
	<syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com>
Subject: Re: [PATCH 3/3] iommufd/selftest: Update the fail_nth limit
Message-ID: <aMuYeveG3M1Ek5ef@Asurada-Nvidia>
References: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
 <3-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f73b4f-92fb-4bd2-00e5-08ddf6743aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xzNgytgj1i2zYD+maP8laWsaQT1IM24ignmX6E7RsODvEIABOdYCWrfxbdXA?=
 =?us-ascii?Q?vzoDZPjTaYgBvUccGLe/7abE6fydyU462hBZwzyJsiK8pNJkhv6RC/XaTWXG?=
 =?us-ascii?Q?cVXDLers/TKNrcYxFH1oYFrIfXUD7P0Szn76zSiGD6W7/mSoN8StlA2q1u8x?=
 =?us-ascii?Q?aPWmvD6FzJvdJ2Xoi3XJ+hFlJs6ug0hW/vknBWLTABs+nDbEhjZPtMrDNVIc?=
 =?us-ascii?Q?7FehUlEm92fIJREa27Gn6tQHdorxbdfe0v7RHOPZ7tVM+pk+/hn7OYU5aYHM?=
 =?us-ascii?Q?4ec/IGhWbsfJtVvB/OEB+m+7PUYXgo/Ii5pMigfLfLLTdwFTIIfHhoy6kFlt?=
 =?us-ascii?Q?UzMx67uqsBZIoArXTA9GX/zlilUKEvhmRPUM6vp6VBL3Z+pm8Dn0/juIlPSk?=
 =?us-ascii?Q?2IJOEBxvdV1818+5Ykl4o/sUmNCAMvO3TUDEAzkFlUZaTL6blphVs2FvSjNZ?=
 =?us-ascii?Q?Lw3l8p2JR6vYg7D+n/FGLSVp65p9fsDYfCa+UxUtvAPEuVHf6O0EUGaCAv2E?=
 =?us-ascii?Q?kq7Jb2U0Lkpc3C5hdQPh9V5kot49tv636Pw15thluEQG5dT91AVpXeV1bT22?=
 =?us-ascii?Q?nst40NCMdjXZElJbNiG/ifkX6zxZ1VeA1Xg3e/ci5HK7rFIgQWIc+PJRxadj?=
 =?us-ascii?Q?JhAdbJvycdCTCk7cxZnWNM/O9uqECIY/02b/viZzmcu1i3pEVxyLemtxk7Gb?=
 =?us-ascii?Q?K4uJYzELNk/MLFHEK7PVgN1KKbyfKsAATUys4c6w4lepW5XALRtuDF7Cy90k?=
 =?us-ascii?Q?juv14FS7G63UPUUpEidYPlGurrAm2bSQBsG+88CXq7jxo6/JNYuK3Zs8pHdb?=
 =?us-ascii?Q?9OqjYy4lhvWw2asmqn6gIabU9WJMgcAzvc51BhnGMfbMRwSfakAMXd7jA4pm?=
 =?us-ascii?Q?NjG7izIGnr5Z/HaxvwIjaGX44KJOXkGXm96MZMJ9UBY8Q9pJU9A/ei7aJ2Hw?=
 =?us-ascii?Q?58lU9ocZHLQnAqgdNRZVwZPE/3L0riRgU1330+w8FAEv+y4+ynfscizLax6X?=
 =?us-ascii?Q?jZ6C56cg7UQCxZBumHmPcYCmskBMC6clmP5UEPWeEgpyPaSbaJ41/V64ZMrQ?=
 =?us-ascii?Q?pWHJQD0QR9dS4EzaVTi/IA8J14Xak+5zFMoPly5cbY+txf5wGxsTmxwvIxA7?=
 =?us-ascii?Q?UFRJYH2JOQayUysyBjS3TK9euSyj1wlKSIuiFhkI0O/K2S8U2k7xAxRSKa6Q?=
 =?us-ascii?Q?c4vsHTr4I9/uY6oKIBnT8ywBhYFCgiKkAYPqj2gfyOPwresT6aiMfPq1twqT?=
 =?us-ascii?Q?9ThiKNzVgYwW+Au8bpfWvLlOAQQT5sNeLY7+6ZVrjuqfkE5ULiOqmUyMgL3g?=
 =?us-ascii?Q?ZCv2I2wZR9kitXnirYwwTBH8+2omMVcmQXG6646E/zFkrlv7sObnQlyuKFQE?=
 =?us-ascii?Q?Wu2bxGc/mSyATsrEJKAUBpRRtsBye0jmKX86+uRLFrjByA0AWwQK0rYv85rP?=
 =?us-ascii?Q?q8ARoVPT0yhONypFUKsGXxtP45dcSMennzQLEqajl9xI3gS2haR9ggCO47zu?=
 =?us-ascii?Q?cN4PtYbBVmr5Fkfl2DtYt5Shsu282dwUE6RI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 05:28:41.6745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f73b4f-92fb-4bd2-00e5-08ddf6743aa6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259

On Wed, Sep 17, 2025 at 05:01:49PM -0300, Jason Gunthorpe wrote:
> There are more failure conditions now so 400 iterations is not enough pass
> them all, up it to 1000. The limit exists so it doesn't infinite loop.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

