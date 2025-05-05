Return-Path: <linux-kselftest+bounces-32398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B91BBAA98AE
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6BE17D011
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945F826B2C8;
	Mon,  5 May 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sJuFbJEn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98742698AE;
	Mon,  5 May 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462016; cv=fail; b=NMZz+bqkwoY7Kfe+TXhOI0pXU9odEqjw1Ag36rFfwKPBUy+ECiZyszdh0N0svXx8UzDuqiutYwDCx8GgfhiUgjrT9R5FW1gJ3oxrFkIH1yQTzVPhJpH3hsNYAb1HMWzVnnyYEaZ4QjUh0szJw3bVP7ZywBK9rWFsBFTLnvivd2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462016; c=relaxed/simple;
	bh=gs428rUVoiqGHYQu/HWyZoiYVLOPQGxccjQz/zkzOZg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=je6uI1sJ7EBb4/tk8HJkswjZNIBYVnqfHgm8hhNonF6ND8vVAEYG1thBEfZmhJPDTI+VnoSMI7qkSEgCLk7Xo5IBeIEt9CHe2yPpMsqIQdtF+36rfGQHqnTyESUUQ4lHF+1o2B11uf4gbpYe9+0xN742e83fdcQ9ms4tQbL5W2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sJuFbJEn; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rh1e+TIfz5pFqv3PTI3JqkMhGszrNsVXTIN+GwVjV0lnybMS7xPSShQYup59bSpt8veQsmVzJLFHhTEWsXIinNpPx9L/SmXVql0D9bzIcYCtPZg2pJWs4HW061rjUgjyzWdEe4Y1Y6P4c0Ls06+JJ1vCsJIDCW9gAkZhPetJ47scSDOvdRvnimKtvUNva9qivlzXEJK4S/arkoM9VU75fQlWTroUto52EtzOSsa6cu5q+YSvah/Hu+SuwmBMY2jo0NA3E4K2/ty4udQ/X6raTDCh2VnFMRMJzwmHiE74Lqa1svO57bBXIOj2bPF2J/UEuD6cL7Wd3yKbBx9BOnlFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEkgr2WLus37bkgsE6QPbcXvCej8msqRGTM41rNeirE=;
 b=iPw1aeCFYBxVzPYyaBjchSWpYvACbS3QmLJk17DMYtOtQSPItwhLgf4lUZ0Yus3dhFDMweE4+2EAWHlyzlnunoSk80HAZnqY1oLtX6CpUb6n1D9pnwkvWzhnBPVgkvT704O98vpCPhm0pETlTHH5s2O90F+CjRf/y6CVd9l5KLCG+O61Leyc9cmhBpjxC1soDzcFRl7H+ev+Te3K3vc9gQKPxu/slBF4xbzRnZIbfFMGzS9uWtg76UzlhCUhRUjxL5eix4EF++suS1Foib4KEoF/TVLzWOr2cBpYCySzIOrmwxB94fMd09yMycPGKSQuyZde0Mfc5JRjZLWhDgVAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEkgr2WLus37bkgsE6QPbcXvCej8msqRGTM41rNeirE=;
 b=sJuFbJEnrk+wO3Trt30QHgIiQs/pQHZJVwRISA9ewQd7QHPTvVYTgujLduETIQyQGTpHBlmt6FqA16DHd70oBkOZycxMWrzkf6ubMX95g5/fsI7HoceIGNl1R7/f7saylz05XYCkjhpqNnvr2gLi0u41F45dEXk7jqGdv/ppNhh7+bvMbdmM9GF5OE6YjlhaSKgF5k0v4No1m66w8xHrQfMXQLfCBqPZio+ODnCPTKOLalmyMd8XZWZkPb3X29mb8enxe3r79ybUFc+YRj88UuRlfeR/Ea5VTHD+Ho+4zb0bSYEJXZkETZex3DJA6U+8Y/Fy9XCqJVuHlfNh0bVU9w==
Received: from SJ2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:a03:505::13)
 by SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 16:20:09 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::52) by SJ2PR07CA0012.outlook.office365.com
 (2603:10b6:a03:505::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Mon,
 5 May 2025 16:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 16:20:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 May 2025
 09:19:53 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by drhqmail201.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 5 May
 2025 09:19:53 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 5 May
 2025 09:19:51 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 5 May 2025 09:19:50 -0700
Date: Mon, 5 May 2025 09:19:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<corbet@lwn.net>, <will@kernel.org>, <bagasdotme@gmail.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<jsnitsel@redhat.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <mshavit@google.com>, <praan@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 08/22] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <aBjlJA1ZClRHftdD@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <d44272c153e7596c3cef716044de3dc6c2a8254a.1745646960.git.nicolinc@nvidia.com>
 <376566b4-6c13-45ad-b1e5-8cfe2de437bc@linux.intel.com>
 <aA+92fNNbDI3Qowk@Asurada-Nvidia>
 <20250505150109.GH2260709@nvidia.com>
 <aBjc1ny0Zs7K7gDX@nvidia.com>
 <20250505155505.GK2260709@nvidia.com>
 <aBjhUL5/n79cJ17f@nvidia.com>
 <20250505160554.GL2260709@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250505160554.GL2260709@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 933fbcf9-d899-4488-6414-08dd8bf0b453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7n+Ewda8xvVijUV9ayu6gYwJojAZU58NR8X48dFm9lTLcJYxu05v9IaTfbqc?=
 =?us-ascii?Q?fheH9dgnmyL0XuyiEEG4sHnAd2U6g8ZM58F+T7iUAr468ivhWIv4BMBkGJWA?=
 =?us-ascii?Q?lDwpPd/6VIP3BRjF+EjENupIFTK35Dt8aUwzLNYnrNS4opIoiMAAvGjcey0h?=
 =?us-ascii?Q?eXfX18rHpi36M+F3QWOr1DXaoSFQcXQ+bCNiBe7tF+ZLxzPBdILyFhH2lPgH?=
 =?us-ascii?Q?g4TAhiXUsO8ZlwJpMX9PxL9iaoWZblreqi9BE99DAP98aipaFWj9hYxxh/rO?=
 =?us-ascii?Q?mD4BRNSr3KdPfJqpjuvjSczV85T2fb1C6E9V/KGTHYSKq4nLhb0q2JXKfZt6?=
 =?us-ascii?Q?ace/QxleeJ13jrCCOe91Baj4V8dl05ayo4WdY9/R1BX7CNrlfuprLE+IzU9Q?=
 =?us-ascii?Q?DgLTAuoHD1/DNx2KZ/+J4iG91Yof26naGarTIRyPc9poISSMPLXUB845VJ6L?=
 =?us-ascii?Q?olRdYWsnRcteHFKxNS8maoPuv61Aa+E6sFkg5Pooii1gdIWgBakoWFkk45Pd?=
 =?us-ascii?Q?9o2x9QBtow1M4KCKW6nlXaQfBraHhL+X43p3gjMuvKUiJjwJp5igm/Uc7Fm+?=
 =?us-ascii?Q?vvE5OwhQM5eKYmERLFm93m1osNEVAlf2BlzGp4BwkwSwcQhlC+nCoTBzKYA8?=
 =?us-ascii?Q?R0WRB6ZTIqUrZVx64RZZHPu7YAV8yVhW3zGFUJic47qVZReiPig5M9xPmlgt?=
 =?us-ascii?Q?BJ5QW6jM98+p2Z/c4CacSxVVPVH7ak4XnSOcxDZ8CYvL3uj390yVKdyMJVI+?=
 =?us-ascii?Q?RJ/QlP61QtdMCzKlX++2Lb1KrlCM7sgfIpWrxUlkH4/ugSfoag4d7FFMjVCv?=
 =?us-ascii?Q?jTH79ZGd2E1IJOn/VpGoms2RQSzQiML5YJY52xGTd92G4crum45+Uq/xtOW+?=
 =?us-ascii?Q?GvaBYwC/YxLmRFD+wkjPh7GjBOV9NfSMztVOKjRH1AM76exJSqixsHHeOCGi?=
 =?us-ascii?Q?AKC0wQoUGh2mg5RjrRUzY69hxb5Xzc6GNLrGSbcrHiGflijj2IrUWSpBL5fU?=
 =?us-ascii?Q?VyaGn6/wHRL/OhgiROXlHAsnJ6k7l3T6wN+RrXCSGalJvk04lUPYvDvqY6mv?=
 =?us-ascii?Q?Vt5a0y8BRBjaGTiRMlzUxl+XqCvhD6WkEbyLW7iRfdm1lSrvagaMsrCMonuL?=
 =?us-ascii?Q?xIKppl5mLqWePVvvkonloDFG30sm573d6cwefAyJ8vspUj4ZCW9Ayszu7OXg?=
 =?us-ascii?Q?BNPlJUT7LqgILYlqDLjLZlTPzzYYtRfA/vdspHzyxQhLGSKgJySuQfGlTC1R?=
 =?us-ascii?Q?ZZCh3qO3w00HZTp29CNcOkbq/rjZ3Ka74gJLmzGD7YSc/kNY1tvlTTE5bP5J?=
 =?us-ascii?Q?UYKQPmCxnGGDOZttRWX9HdnefbMcckUBhfCgGJKtC9sTiZsVh6cUmpiREyb8?=
 =?us-ascii?Q?SrnyJL21Qt09pjRs4bLp3SXY3aS+0AMl2FqqZR5vuD98vRHJ4OvOduQPRGoE?=
 =?us-ascii?Q?6T9JGbPuqAUKY8vXK76EUMRsyHdUSsPq15wZjNjjxHOFNsZ5HniZ2PCvhB80?=
 =?us-ascii?Q?XP8MMLUtjuYKW6iYkzZeov3FH0NTfEFZ1YDg?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 16:20:09.0043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 933fbcf9-d899-4488-6414-08dd8bf0b453
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248

On Mon, May 05, 2025 at 01:05:54PM -0300, Jason Gunthorpe wrote:
> On Mon, May 05, 2025 at 09:03:28AM -0700, Nicolin Chen wrote:
> > On Mon, May 05, 2025 at 12:55:05PM -0300, Jason Gunthorpe wrote:
> > > On Mon, May 05, 2025 at 08:44:22AM -0700, Nicolin Chen wrote:
> > > > On Mon, May 05, 2025 at 12:01:09PM -0300, Jason Gunthorpe wrote:
> > > > > On Mon, Apr 28, 2025 at 10:41:45AM -0700, Nicolin Chen wrote:
> > > > > > > I'm uncertain, but perhaps pr_warn_ratelimited() would be a better
> > > > > > > alternative to WARN_ON() here? WARN_ON_ONCE() generates warning messages
> > > > > > > with kernel call traces in the kernel messages, which might lead users
> > > > > > > to believe that something serious has happened in the kernel.
> > > > > > 
> > > > > > We already have similar practice, e.g. iommufd_hwpt_nested_alloc.
> > > > > > 
> > > > > > In my review, a WARN_ON/WARN_ON_ONCE means there is a kernel bug,
> > > > > > which shouldn't occur in the first place and isn't something that
> > > > > 
> > > > > Right, so it should never happen from any ioctl path and syzkaller
> > > > > should never trigger it based on system call randomization
> > > > > 
> > > > > Is that what this achieves?
> > > > 
> > > > The functions would be still used in the kernel path. So, I think
> > > > we need to retain these warnings for that. But given that an ioctl
> > > > could trigger a series of WARN_ONs, WARN_ON_ONCE is something that
> > > > wouldn't bother user space a lot while it provides the kernel path
> > > > enough info to debug.
> > > 
> > > No, it does bother userspace, we must not have ioctl triggerable
> > > WARN_ON at all.
> > 
> > You mean we have to eliminate any WARN_ON in a call path of an
> > ioctl?
> 
> Yes, not one that derives from user information. You can WARN_ON if
> internal kernel structures are corrupted but not if user ioctl
> arguments are bad.
> 
> > We can drop them, just that would mute any kernel bug.
> 
> That maybe the right answer
> 
> > Btw, IIRC, the destroy ioctl could trigger some WARN_ON in the
> > remove() when the object's refcount isn't correctly decreased.
> > Should that be a problem too?
> 
> That is kernel data structures being corrupted.

Oh, then these two WARN_ONs in the unpin() will be only triggered
in the destroy path when the vcmdq kernel structure is corrupted,
because the two inputs are not given directly by a destroy ioctl.

In this case, I think it's similar, so we should retain them, as
they were?

Thanks
Nicolin

