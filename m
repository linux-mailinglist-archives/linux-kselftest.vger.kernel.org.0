Return-Path: <linux-kselftest+bounces-37548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D36B09D7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 10:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D3EA86987
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 08:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC80293454;
	Fri, 18 Jul 2025 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MeZO+D2U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1355292B47;
	Fri, 18 Jul 2025 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826443; cv=fail; b=HnIkv7r83a/eTv2Kua2Myolb0YyBqWNnt6SThfGwWcB+69JhYsnHqDxDq+slyuf2cQtcdtzP50EygoUS7xS2bGG9twunsWzpZvrmYiNS4yoVAh6K2oBjRhhb1Uo+RWapfc5xgkUHTmQ+vFRbVtXL3uDO+aJJ/wi+TDwMZVRDfsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826443; c=relaxed/simple;
	bh=sK8rCVZWVknncI/GRJFuplBG4djM97aDQpUZ5IyzCu8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vaea60gV63y4rboWsTDybOXShzie8HiBTIbKAuKSoxuWA9lkcNXXWpN/QQQkWLhuqyTVqLDRh9N306EnVquRTI3QD20NWV2cE7Bk8f/I9oXpjVmzhsLnTa+TDmbivbiQ9AALEoTINiVpucTVM4CdFbvxsQP59ZbOVIwmddxkbXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MeZO+D2U; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH8dSOLQwEWAYu5/7LHe2FRNuQL/U5b0FRQ/5EYonHbHorNHG6tcwvRoZtL1YAa6MIgnc9j3xki8B/5FgBxBIAongwdR9qnNvDzWaYbc/I1Qy5vZoKTio/vkhIzK+MgVQS4zqAuK36EUtK/n2qQlkwzmNz9thl4zk++2vsR2acq+CNnSUzob0fOYKxke5U5KOmwTmFwhh7gESRepcSHTKimE//kH8ZnxvvtX1mEzjIq8cQ0q3SpXlHAUP8SIiug86vpsO1IFDbSoftYPg/uWWfLi26oCKNvSJ0Ohocg3hmggs3nDzN2Glv0A5ZCWC65yggnMJ5P/OFcFoN9yQF9rsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04ldxSKN46ab16CBg5TVIQ4IxwlIxYn11kzB87AMbqM=;
 b=GuPXT0ec/0ylnGPPKwNUW0ZKzkQm+CDfF3RqGK9WF8NbL5xJ2B4nXmpu+meXsvMSN7tRjnwhTeT67AwsTeO45zouRPaXoIsZsKPwl1iRAbYk62HQTIeVNwMyk9wliSL08uVzxUmqzh1O8G2kRgTmLcXTEtKEdsXXlusjtdFzua7z/7mDefd5XPnJ8yW9yfOjZXKY/C/4wgvgP2XS6ZdsdAGbDFp9eIXpGrx9DUFCoMOJXjFYFfZFyiRbLoiBe8wWzNA88xdvA3LoD4cD2bUWfqQN+zkDnmALDmyBiRab4lZMfJ1J502uwdZSY44rlPoBqH4q805y2MM5RudekLruFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04ldxSKN46ab16CBg5TVIQ4IxwlIxYn11kzB87AMbqM=;
 b=MeZO+D2UTzUux8nb52LDhbWJjAKRmonb5A6h6Ga32aMFbgbZxcL5nMseDixcViVFrpiI85HmoYgbGPszsEfLMxxnPYJyumvAeCsFxPY37C+YTuNTwAZuVeYDSdWAFT0MzGDwQ57mE8Rb5bxA4jPkuHVYF0Eg1yapsVCyyhPEeb1p8RE1P/+86IIAjEHuRpUqW7zubh5o2jyyb8p8iSu22UccWz+fvjDvUNwyKNemcqOCEbKUtNT36ko0Io7C2wRh20BVcDg/wddfjnT5RcDgIOGlR86s2NsNRLXDmjcMYD2JssMa9OzWokVOtDvXcbi9gxcxu3WauCgdWLms6q9lLg==
Received: from BN8PR04CA0064.namprd04.prod.outlook.com (2603:10b6:408:d4::38)
 by CY8PR12MB7361.namprd12.prod.outlook.com (2603:10b6:930:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 18 Jul
 2025 08:13:57 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::9e) by BN8PR04CA0064.outlook.office365.com
 (2603:10b6:408:d4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 08:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 08:13:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Jul
 2025 01:13:48 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Jul 2025 01:13:48 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 18 Jul 2025 01:13:47 -0700
Date: Fri, 18 Jul 2025 01:13:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, <linux-kselftest@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Will Deacon
	<will@kernel.org>, Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, <patches@lists.linux.dev>,
	<stable@vger.kernel.org>,
	<syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com>, Yi Liu
	<yi.l.liu@intel.com>
Subject: Re: [PATCH 2/2] iommufd/selftest: Test reserved regions near
 ULONG_MAX
Message-ID: <aHoCOnOAlwpoiDNe@Asurada-Nvidia>
References: <0-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
 <2-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
 <aHm1WRAGgk/6HZMC@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aHm1WRAGgk/6HZMC@Asurada-Nvidia>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CY8PR12MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: f003877f-8327-49b1-e5ea-08ddc5d30b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wbSmx0Z+E0FucA73AUkg8QsWyG9/zD9CvldLuJhZ1VI76WRWj+L1XrCKPfc4?=
 =?us-ascii?Q?ek7KGeg453BxJ8N6h6Uz+gWHhnhVRaGg3IOJKOtp+NeY9acDDkkFelNbRhMU?=
 =?us-ascii?Q?Jycg7x3eqqlRMGUgzTqgYOjXf+VqWoLT5PLiRkrqOqv8F2WtsUkIg3K5c53V?=
 =?us-ascii?Q?jKwEPDmwQzmeFuv/U9Swd1Nw1iEefEDZkQ3hOdI8Oi/Zhhpmf0m7bZDH+juX?=
 =?us-ascii?Q?44u8l2dUmzfl2QwWUuRcaWfyrLZ9Ql4xLrp4vxx7LHlBawLtHrop7tUBUydu?=
 =?us-ascii?Q?jJLrQT/RPuWkQ5IkqGkoHSacqhmkZr4SZbygupkWTG2FxVSJIhOZi1RbpQxQ?=
 =?us-ascii?Q?GecWpO7Z5CzEqbCKTlp+EJAY9ThyhSkp9Cfe7zGhpx3AEwFV4czGK+JoveMw?=
 =?us-ascii?Q?CF+cbn4IQ/FPm5XDysL6rDZ6BOjLoZt4y1386oTx6c7x3L82NaafrdW119EM?=
 =?us-ascii?Q?kUPmOP+yNhAr8743ALy1NWTK43Tf4BWNLUw31/XUMc0MyMrnIkFDBWxTH+6O?=
 =?us-ascii?Q?/HMbuODW5pYE9623ebZekDyFnercFT+qkT5B3eZnzH2g6N5Xc0B5aar2m2s7?=
 =?us-ascii?Q?6DjEt47RCzIcZKom1e+egV/y3kFOnoZ5yTq549Bo1rRMLhJ1SaEEu59KUHGk?=
 =?us-ascii?Q?tkOX6DkWwc8UGqLLtzmTE3zMYdtoLSee9K4fyqeY5+8LreeJNLmz3M23RhrS?=
 =?us-ascii?Q?hhbvc/PuvsSN7qOeBWDFV9fhEyGP6qhBdjPkhb3yAV0Zn3060XnK5QOUIOzu?=
 =?us-ascii?Q?jDMDUYrnD+RiKWV6z2FNmyV09zQhgD485363YhWaYjkudtaBATt0V7ISup1U?=
 =?us-ascii?Q?WS+Aih2Navj8E3dHWjvB0CKb7eyJB288082elxsgfF4Kll/7/5KTzwLtmB9p?=
 =?us-ascii?Q?xE8wmm7KLFp7rhLBI1etwHa7YSru4Aq2pwbT6hSjSZQafpPuRYG3NDD5D/Fi?=
 =?us-ascii?Q?Npjq95FlJ7FccAKPRcJrBvIMRcRaaZzqWMtKAhfeEUTy/wZPKqWL4aX3MAQf?=
 =?us-ascii?Q?cnijINYn9HveCXFeSPG3lbqfXWPi1qggt3LaRlGpEgBQFwdPQdPgxJTB7x9Q?=
 =?us-ascii?Q?Namk/j1g7rz6/WpB+AWBrJEhXd+RCJss5QTbCVc7ZyCQUCJmQfmp9PhMaj3v?=
 =?us-ascii?Q?NIS0KXK/ERFXUG1banOXAUMuTDrbqlwDPEMbwRRj1DD3YD8Kk+trZCIX5mke?=
 =?us-ascii?Q?Yl6DlsLcf5M/kxWb6VOGqLiVwJ6siqA1jdutWetI9cROfYIiRhN/3zznxQjO?=
 =?us-ascii?Q?MGH0VfcNlp/IEF5hc0IgmS871lxHwdTHWtJJ1ripCcuA6XZ5X8JBlxyphGQn?=
 =?us-ascii?Q?dJgPOkQtmB3orl2bE6kyfXFylFGUXNv+AjCt6d4Ztm2C7bBrHi/3Fv491Q33?=
 =?us-ascii?Q?mPw4eTJJd8D7ADBOwfhd+2JJb6GwOTLDmtLJ2y1GAgQR9TuJC+2IZ01yQORs?=
 =?us-ascii?Q?3gOjwoZVD7bAl9SlpvL2UGy3NfYbF8oeTsM145iEXoO6mBce4TC09oCVjToD?=
 =?us-ascii?Q?p0WroAa0mS0z9uoX3gY61jqwrlUcXQse6wXS?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 08:13:57.5892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f003877f-8327-49b1-e5ea-08ddc5d30b77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7361

On Thu, Jul 17, 2025 at 07:45:51PM -0700, Nicolin Chen wrote:
> On Thu, Jul 17, 2025 at 04:15:09PM -0300, Jason Gunthorpe wrote:
> 
> > +TEST_F(iommufd_ioas, reserved_overflow)
> > +{
> > +	struct iommu_test_cmd test_cmd = {
> > +		.size = sizeof(test_cmd),
> > +		.op = IOMMU_TEST_OP_ADD_RESERVED,
> > +		.id = self->ioas_id,
> > +		.add_reserved = { .start = 6,
> > +				  .length = 0xffffffffffff8001 },
> > +	};
> > +	__u64 iova;
> > +
> > +	ASSERT_EQ(0,
> > +		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
> > +			&test_cmd));
> > +	test_err_ioctl_ioas_map(ENOSPC, buffer, 0x5000, &iova);
> 
> When:
> PAGE_SIZE=SZ_64K = 0x10000
> MOCK_PAGE_SIZE = PAGE_SIZE / 2 = 0x8000
> 
> This likely fails the alignment test, returning -EINVAL instead:
> 
> # iommufd.c:988:reserved_overflow:Expected 28 (28) == errno (22)
> # reserved_overflow: Test failed
> #          FAIL  iommufd_ioas.mock_domain_limit.reserved_overflow
> 
> So, I think we'd have to pick a number aligned to MOCK_PAGE_SIZE?
> e.g. changing to 0x18000 for example can pass.

I realized that we can't change the number as it won't reproduce
on PAGE_SIZE=4K. So, perhaps it should just SKIP other page sizes
than 4K.

Thanks
Nicolin

