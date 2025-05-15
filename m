Return-Path: <linux-kselftest+bounces-33122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEAEAB8FDA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 21:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2C750573C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C28D25C6FA;
	Thu, 15 May 2025 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mY959XR3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19A191F6C;
	Thu, 15 May 2025 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747336906; cv=fail; b=T4N3McTueIT1QPTFU0408O8sEdde8rZdJovfdMvVOwgx+yo9NfZBBuOhoHpy4lALLI5vQeaS/sG1ptFAT7AFGia3+mg+jEoU49f8/0zzKJ/mwc0fOda1FeI4JL9aTBkOX0lKRZqQKeNTBnhSOmXWWzzULcVgEWOyeAWC/4y1G8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747336906; c=relaxed/simple;
	bh=FPD561I6FZwFpBjT8l3rchhjnA8GedY7OG+JXtW8PMM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lzo9Z/C6gJHVf1I+m0f0HcvqMTErAvJt1aOXlAe+7JDjC7nAhVWfRnbejj+cnPDW0Rut8iq6zgyHK6mCqcmMJOaJQtTfHruBV6cAEFRMKWT/uHwTYlJ0JOIz5NbaFsy82JY4CUBBuJJFiV3AB8B5rq/HLnpVKZO5825TKH1ji7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mY959XR3; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FW1+CURMS4j+rlR6FWc9EPbIhu1Q424gXzUN4BQY6peLvDidUFvNJy0R51BzZYCnqOm9+suOFKEixguxeMDlaHHqX5AzvI/8OsD7iB7Wu8bVtFNbUa7eXvLIBd2KEJ7i5nxcX9r6uaoFvm4+OOzC4tIzrTymCbYdFiYDx+2zGq32B6/2eEFz87uJV2+ktECVFTEhA+yWYvyg94FNTPnuY/ktspre9NH3arBSQH9/W/SXknjFtteYFRP4yypffh7RfagvLP/9Vd0YzPzURk12mEqivAkDjXC8cES2+JYeX6ns3wRc1KnoMuickm/EJjvFw4ktjT/Lmzu/jobku0KJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxRm9Uoux30jQ01+N0re1Krc7k58IIxOgdi4ET0lN3o=;
 b=O3wJKdNqHqVN5JRsvuxEwkXzS8GMytg4UTGsPNZvC1K1BqrR7qv7wZm4n9BKZkWMxJxUpayehFCyDklbJ4TgmVE/jXJ4ZANnJea6hcKDW5Su7jDmOI/HNaFd1MoRxuLBQPGLB3Xq8kZjN93ZEz7K5p/RtABEd6Tls+sEjQBIHd6r3jb22UhHHqam+R80Xwz8ITedHoNoYO96qrT3vPx4QVxvGiQtpYX3qT19rXT63xWM0lQR4RW2rOzeKkFP0LJ3QxK8mBUWwL4JhMvTV51EYuMMOgRZue1rcvS50u9iVjd1pt95ygclL+j6GfIHratfNUjGa048dn7GprBksBYaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxRm9Uoux30jQ01+N0re1Krc7k58IIxOgdi4ET0lN3o=;
 b=mY959XR3HlclgNFT05PbVV55IE1XWYBCBOyDG9MigB9Rm6+BXaOpkQBehZnpflJr9Q3wUGkYizfe6F4xMUgypPPompUGucRsDmxqDZCXsGtaot7FTAv/qqFhD6RyLiux+JLZv/asFZJ9gnYE+RJ6OuDmD1OY3URgKIPBhU124yh4D3wBW+JwN+A+9CXzfKkxB67j+aM+W+HOnDj2Gvl40g08et0xfmz1u2s3C9wBgx7KU6wbvLd7DiLAu2JBlLghx9TOAVcqvs43puim6sOaWHz7onccWtlTFEntHq9ByjPRbH64qbXXTN/Q7OWXcitqZnmIwjA0wCroGVAor9Wt4g==
Received: from DM6PR06CA0037.namprd06.prod.outlook.com (2603:10b6:5:54::14) by
 MN6PR12MB8491.namprd12.prod.outlook.com (2603:10b6:208:46f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 19:21:40 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::ec) by DM6PR06CA0037.outlook.office365.com
 (2603:10b6:5:54::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Thu,
 15 May 2025 19:21:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 19:21:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 12:21:20 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 15 May
 2025 12:21:20 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 12:21:18 -0700
Date: Thu, 15 May 2025 12:21:17 -0700
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
Subject: Re: [PATCH v4 18/23] iommu/arm-smmu-v3-iommufd: Support
 implementation-defined hw_info
Message-ID: <aCY+rXsygxjHYRhK@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f70cdcc21df7cf07ae1da02aba8a5aa932718a25.1746757630.git.nicolinc@nvidia.com>
 <20250515171706.GN382960@nvidia.com>
 <aCY31VOs62/OAaca@Asurada-Nvidia>
 <20250515185629.GS382960@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515185629.GS382960@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|MN6PR12MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ceaf26f-b6a1-40ad-f994-08dd93e5b832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D3I6p7Mb0Dy+5FjF32ZpJB5eWDH6xpBPKPYczpzetyggT5wR5Drk23OHGn8e?=
 =?us-ascii?Q?Xs11p6vSdZZk+KRZsq87f8ISPetqNwj3uz0YIZudvxZxSd6eJHXD4qNnS7Nm?=
 =?us-ascii?Q?pmnWKT2/rIFxLSe21FU783RxLFzJJ5DhKA+AENDIj3+PWTaw4IgTo5Nlr2d7?=
 =?us-ascii?Q?IWcNMzdXbXA1567VXiPsz6Wl9k1kiLVi9BvEac6e6aHtQjX8tMhumjWPVHGv?=
 =?us-ascii?Q?1GH/eLI/xQpZipRV3gdvqVk+FSung1nPfjbJMs71AwbBIdpJ8lsiUuwbbkok?=
 =?us-ascii?Q?QWvOHzEze7N4eDy+HPp74KUoYNryWlVYm7OAUd/6r3kPndqK9dH3xzA5kOS3?=
 =?us-ascii?Q?953rixjFkc+RPzr+aIDRa5HWk/Fz0XrltPJRIY5dLLdTOnIALXAMU/A41ieP?=
 =?us-ascii?Q?gTQ6FbLaU1DxusapYeo4ij5nPa7pnZ0jo8QRgBiffSxlaADXNSr65bgH0C1B?=
 =?us-ascii?Q?srUJUyJq/gCFNnRueXtkJCUHt/m+Hvn3kvq5IeA7kIm3QeDGu6G3Vdu8tj4B?=
 =?us-ascii?Q?KHcbksD74gtAk8jVa+z4iQfGmxnX5kSWDAiLw5vBUZaSzffyDI0EgulxAOGz?=
 =?us-ascii?Q?PNZa7yvCyIpWK1r4RZk0akHTly5Rx+i6lfAwemN4kSHBW3Mjj1DVBxW15kKG?=
 =?us-ascii?Q?wjkNvlu12HxJdBuiXzmqjRJiKtl7bpcaTSoISrCAbDjClUIkAIlKzSXMQ4xm?=
 =?us-ascii?Q?1WXgOgIIzjz52Jtcfm2rhH/sevyiAgAalR9urwCrxotaGZyeX4qO2616UtWc?=
 =?us-ascii?Q?JxL0detmoIeSHu2BMlXs3LJrtmCPXU3kj7U60F2F1i4OOlRMGou8XtmpKZEp?=
 =?us-ascii?Q?ucvS4XE4Mr5y7beELcw3ieWlUyvxnw/T7O72mb+iIr97EUKEOLWDnp1JMTUA?=
 =?us-ascii?Q?/+mjA887ZbesGxSmgqnvR0l99qIJZhM+yFa8uBjmy7OFJ5bO8jQOELVpXkaq?=
 =?us-ascii?Q?KWDpgSqW6cx33DHVL82HrlipyxgMxCwK1gFprSxS9JEJIO+TNfrHeVXxetRt?=
 =?us-ascii?Q?iY7pfrDEndDToZg5KruyIa86NehLDt6mxc8wWHbagQrbFWdUKV1nZ5+/oglK?=
 =?us-ascii?Q?RBahgXe8uruNQ0PCAegUXAsHLpWafoGBqTf9C8TmR3hV4GLqcycJz/vUeYOX?=
 =?us-ascii?Q?JPaQu5BjlO5jEFObf92M0AYYnaGyTo5Vu6ecND/GOKW3UwPPS0yH6EzNQD2G?=
 =?us-ascii?Q?K2aYajjwpBa8UkfZbwPv0Uu7hfkHom3z4v7dPcThOR6J9Nm6MPGAozf/ARMn?=
 =?us-ascii?Q?3HOcdlIdd2Rd5cB7JmMJEHFKFrXrtxXKaftZykWuTvHtJxJ2ZlULylOoPm/6?=
 =?us-ascii?Q?HB/MhiLgt2CoIM5iZDSgW2KsB87oCoaNsw1hwV6tfTYf1ShSM6ACtGDcc5Ca?=
 =?us-ascii?Q?cKppXq0mXP5kiYRzyG9M2atzTyqFHnEcJauglKLbwc499dKSqEyJq7P7lpVM?=
 =?us-ascii?Q?HKSlzOd8K6J9zMIqCdWvzhy2qNOnkBvEGUWVHv0B0iPYBg9Urx+9CXvDhQnA?=
 =?us-ascii?Q?Br5UnkS4vMdP/gVd9inSHc0nrxAkD+EuS09p?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 19:21:40.2130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ceaf26f-b6a1-40ad-f994-08dd93e5b832
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8491

On Thu, May 15, 2025 at 03:56:29PM -0300, Jason Gunthorpe wrote:
> On Thu, May 15, 2025 at 11:52:05AM -0700, Nicolin Chen wrote:
> > On Thu, May 15, 2025 at 02:17:06PM -0300, Jason Gunthorpe wrote:
> > > On Thu, May 08, 2025 at 08:02:39PM -0700, Nicolin Chen wrote:
> > Should the first call return out_data_type=CMDQV while returning
> > the arm_smmu_v3 hw_info data? Otherwise, VMM wouldn't know what
> > to set in the input sub_data_type of the 2nd ioctl?
> 
> No, either set a flag in the smmu_v3 hw_info, as you were doing here,
> or just have the vmm probe it. Given the VMM is likely to be told to
> run in vCMDQ mode on the command line try-and-fail doesn't sound so
> bad.
> 
> And I guess we don't need a "sub type" just a "requested type" where 0
> means return the best one and non-zero means return a specific one or
> fail with EOPNOTSUPP.

OK. I think this would work:
hw_info (req_type=0)     => out_data_type=SMMU_V3, flags=HAS_CMDQV
hw_info (req_type=CMDQV) => out_data_type=CMDQV,   flags=0

Or, would it be simpler by having a sub_data_uptr:
hw_info => out_data_type=SMMU_V3, sub_data_type=CMDQV,
           data_uptr=iommu_hw_info_arm_smmuv3,
	   sub_data_uptr=iommu_hw_info_tegra241_cmdqv
?

Thanks
Nicolin

