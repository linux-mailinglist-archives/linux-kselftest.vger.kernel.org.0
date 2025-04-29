Return-Path: <linux-kselftest+bounces-31911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE695AA1476
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 19:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA02924B4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 17:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F64F2475CB;
	Tue, 29 Apr 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sORLEGud"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D21DF73C;
	Tue, 29 Apr 2025 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946656; cv=fail; b=ICCFu5PUYwL03QoBobIhujEFu9JH5zy4j8gOaIpatYqJXCxulCMc7/1CWAdeayFKKc6yPiWue7revTnG278FrjBPOOn+V9XtasF7tlTThMUF//K/jA6AxAiHnk2zPFDpdBoU+Wvhpt9DDVFFXqJeQ1tYq5YzXSeAIY7xpjp10sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946656; c=relaxed/simple;
	bh=3Qm5oojHNGMyDGQe3QFz7Hhhp5HTrhg7CIldgoM2mJE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR/39mil4t74/+loBWuVRM1EX7UU709MHXQcgYQHU+m9pVXo0lXCdEsfbUTX34dFJJfCf6FExGU/OPN1EuMNLyuVcdPOYDVIh3oeAt4leFSg/eEr09Qp8Eu6hfrcy2IeAsBy06mY8cDNbvlgvHZ1KWuigqtFYe57Vk++PV3IAeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sORLEGud; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAPtA37D2HG2n8Fv27VB33FpBdPsGVZ17giWDv1hb4G4QivTwLT2gpC1sGGBSQlUNxJ2otnUP2h2g/kSkvly51hs1rh+CQ3S9aIDWnXLkTdt6qoZlFfdRgJb9IIVh3iWeaLOsFg1blZlt1Y64Ga8Lzq9XumcEOcbD0/xX4E6jZgT/G5T7E/ephjY2bN093ludzVczYFLCUDOlZhshQqqcRFdklARsKILjcNN2dH4t9UQzAXfdT5/o9SRv7nwv379SZjsBCshKSw9P+p8kUqGHI7beFWLLjhjsaPeSVc8u1bbp2VTRHLLzJeDLG2sfX2uM/pKSxQCL7pJnc35Q5EfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xH//tbfB8ZvbQC2Z7CBZ43RpuiqFuQWtDv72Nrv6IMw=;
 b=EaYapucddJRIgIXTcxdM3JeiaXFPRJBv4kGSU2tl6gc1ISMEEXAYe70Gok/mx4mP2vjwRUJMevNpNI7bvQwvQAQw+D4C7sgfuXxmgkxOhAjUmf2LFo/7BBXw1zE4G8HiXfCxjq0X7XZV89EpXduXzlNqiE144xIbNISw2U8A8lUqJ3Z6EO52oNBdje1Dn2aKDq0AhlfLrmyiTqXHirGsVgZJBLlpAS81yPYO28hrH7fIK6EvOpZCrXEV6K7xkbO4N04BpME91AmfXvkVd4H+Voh1GL9eOIRYjRk2P+CUPD54oSBzPWHKCmVztTZBwa+Fz6kjGBunDdFPugRFsonYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH//tbfB8ZvbQC2Z7CBZ43RpuiqFuQWtDv72Nrv6IMw=;
 b=sORLEGudqfCA/CG12jJj84M0WjpdJ8QxVKvaY8BSp7uMG7cirix2PVSb4NEQTc5Y1+xrVUBA3xaAsQGse8PfEv/d1W9aQh3/FNUBzjkck6+93U3y/0c1XI30fzFIWfS0Zcc6caXrj2NbOqRnBYvQd3I721cPPeTald2aDCH34NOXA72RJ5zFWUeI1PpFigqJW1M6KnBEF5qvMFFeWra1o3+WN3rtjlpD9H8r5O4W6tTL4ZQEI7lmv1uhHCuQ6s16MhrhV33DGCmPy83XHgihhL7v+ppRKHwZHK8I0mOfyUWQRDMMduMzd6pO3ssuTRJThT+UkdVnzEee6KEaUJG1uQ==
Received: from BN0PR04CA0171.namprd04.prod.outlook.com (2603:10b6:408:eb::26)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Tue, 29 Apr
 2025 17:10:47 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:eb:cafe::7a) by BN0PR04CA0171.outlook.office365.com
 (2603:10b6:408:eb::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Tue,
 29 Apr 2025 17:10:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.2 via Frontend Transport; Tue, 29 Apr 2025 17:10:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Apr
 2025 10:10:33 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 10:10:32 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 29 Apr 2025 10:10:30 -0700
Date: Tue, 29 Apr 2025 10:10:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 11/22] iommufd: Add for-driver helpers
 iommufd_vcmdq_depend/undepend()
Message-ID: <aBEIBKdjuecVHgpU@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <a25c9454c17663f9e79b37bc2908bf3a99856be6.1745646960.git.nicolinc@nvidia.com>
 <aBDIpz7w8wxIn_AF@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aBDIpz7w8wxIn_AF@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d970dde-838e-42d9-25f8-08dd8740c8a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cpJ6GwYTmxqcWzqVV9pMy+n9hLpHKru4eML91WqCZDwatEmIGSXcuFq+RMSK?=
 =?us-ascii?Q?H2LGxbP+eklnY3udutrOAOW1fGKaaIiI1HQjBziKE+xvheHW4EyUJrf//qFC?=
 =?us-ascii?Q?bV+KXYRemhSt24Mz/AvirCMi2k/ija9eks4iLAY6QwR2Mbyyo8chFNi/xQIG?=
 =?us-ascii?Q?ChG/o6gn7zSCNHL+l/ahMuJhzv/Eupiz7QeDbNyHklYCCSC1Pw5dyi/dXXyz?=
 =?us-ascii?Q?leaZH9M6C3KMfwWaaqS8DZBxJhQ9i8+D5OoBUhLnbI/jga5a+VR4CaUm4ABk?=
 =?us-ascii?Q?/Y45vaeydC8hy6UU7ODSAwuCHWs3g8n/WC8rcGQA60lMU3DpdmK8X01rGD7u?=
 =?us-ascii?Q?1mMbQr4eHmoWaYXi3zA0o8nVG1fMZCpfsIgujyPk15fP0qjckd+Yl1zAQ1nI?=
 =?us-ascii?Q?0VhuJ66nknA7OmxwlpdCrG+MPKMJ65q7tbD2/+ZM/Y+lEdSQe9wolVNiQsNn?=
 =?us-ascii?Q?dQT/pcWwFFVNYkRQozVjSSABy2P5MccS7U84UMOEPUgS4TdcAy/3661DqcQa?=
 =?us-ascii?Q?btbRP4K6mgQnV7z1ZpDBr8evVvdkO6O6H0oTYuw7f4liQ/ZEBDWqVv20RMU2?=
 =?us-ascii?Q?Z9XmZX0Yix7sz1MXxWDE29Zkt+FviFS6AlwXuQnFtDvUciLBwisHlwRw2l2i?=
 =?us-ascii?Q?1W/kPVMOdwQDGY9+RxSaKzDB1hYM6TG6rEb7gnqgpNJ+N/PRQCMDspiw0h/1?=
 =?us-ascii?Q?vF9Ii/c2udyO/dLxPHoc9cfE01YQR+kLM7jbZApLhJZnLKduqxvbhyxkjv4b?=
 =?us-ascii?Q?bI1ebEGQIfuXHdear7lbmmB8zk5tBWMwd44RRfOYqi65SlzW/XvNyC8szceP?=
 =?us-ascii?Q?x84cbacf6CnLx63Rhx2mgwhWYp9xLxQl/9nTsmSXv4Ee9gFnyXiQJsKW+9E0?=
 =?us-ascii?Q?wj+d6pav6judJ4Hl7yJ0R8Y312X/mDR99ahPvrFplENLK+U8bMiZ/7vKI/Ng?=
 =?us-ascii?Q?VFjQv19c/ySSpzopwTZFJXsMMxvQSLsBM4EkSlCyuFwDxvd59LtpPzlgvflB?=
 =?us-ascii?Q?Uj+hvY3OGhS8BNOSpeiWAQNf2e/RDS7IK2WGus7UKkaNFiDV8wYsOQtT4KBH?=
 =?us-ascii?Q?RenK+NxWD9ztzA+kbD6+KUIgfLXmm1CI1amxNpuTmmy/Fpc7gnBRJfv7G97Y?=
 =?us-ascii?Q?FhBUk2vcqu+pvoYFh37dPk+kFQK4IXEZWg9Kp2M109MU4tNS+WG7MnQ4SrDS?=
 =?us-ascii?Q?AmXlxKYcJPK8Au10oHRz+ib6FMz2EU0pmO1K55tMJoGfe+Sj1NDvDoNrRokb?=
 =?us-ascii?Q?0/Bsb1ZHGuHa1Dfz4Zqf5nt175rysamu9XN4dslcI+pkjPE7smBHh/LIFcrV?=
 =?us-ascii?Q?QRwmiGMlqCKF8ojF4jKWGnkgU8Jo0wmXsu1ND+lncw7L+6cX1IWXkkVNJC9A?=
 =?us-ascii?Q?MXEUfD9mbEG2ZU9cMCf8ZmPwghOM3DsnDoIhexNPY8YvD8XbwIC6dV8zGPKJ?=
 =?us-ascii?Q?NIIREMomObprfeKum4DcOr0DYZV+7JTOAsTBicQsQMcIHgasJHsGU8ZM8Yob?=
 =?us-ascii?Q?Tl7+D1XNO9d+0cS2pnaTa4KTmAPyyzXw28rK?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 17:10:46.8461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d970dde-838e-42d9-25f8-08dd8740c8a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192

On Tue, Apr 29, 2025 at 12:40:07PM +0000, Pranjal Shrivastava wrote:
> On Fri, Apr 25, 2025 at 10:58:06PM -0700, Nicolin Chen wrote:
> >  /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
> >  struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
> >  				       unsigned long vdev_id)
> 
> If I'm getting this right, I think we are setting up dependencies like:
> vcmdq[2] -> vcmdq[1] -> vcmdq[0] based on refcounts of each object,
> which ensures that the unmaps happen in descending order..

Yes.

> If that's right, Is it fair to have iommufd_vcmdq_depend/undepend in the
> core code itself? Since it's a driver-level limitation, I think we
> should just have iommufd_object_depend/undepend in the core code and the
> iommufd_vcmdq_depend/undepend can move into the CMDQV driver?

The moment we added iommufd_object_depend/undepend, we already had
a blur boundary here since we had no choice to handle in the driver
but to ask core for help.

The iommufd_vcmdq_depend/undepend is just a pair of macros to help
validating the structure inputs that are core defined. It is quite
fair to put next to the raw functions. I also had the notes on top
of the raw functions suggesting callers to use the macros instead.

Thanks
Nicolin

