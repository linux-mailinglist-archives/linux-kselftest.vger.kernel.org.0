Return-Path: <linux-kselftest+bounces-33958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F16AC70A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 20:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E023C4E4AEF
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 18:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BDF20CCFB;
	Wed, 28 May 2025 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SBImEGzM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C4207DE2;
	Wed, 28 May 2025 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748455313; cv=fail; b=pRoDMGa2H+ox3Gz0lOmHxS7ycJD/H8oRry4b5/8iOw+aFaaVrAVYbaeZ4q8a42Pu4C//0lMN2kSyqW0hewa2hbw+IIJHLNkNje0A8c4TMMqQycI4z5xaW7WJnrMt0ZDrpna6awOpkAwGe7v7QFvZnqFuapPia4fr7Sb39cV2MEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748455313; c=relaxed/simple;
	bh=PK5rl/1dte9AJyspm42aurn7n9Gi0dznZQenQKMQCeY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/N4rKPnuOJqtCTGWVV4QHNh0aWVP7TjlCJlilYWRdyzV9O7M8fTosDkSWHHhFyX3aPPnRYbXylohrYx+RoEMwVHs0cB75laGLjFAm4OgVLeo5H3gKQ2ej0fsCt6FJrrB6rjBA3MNwW7cQjRdTsS0utqnN0mNZ+1/xVTQo5ua0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SBImEGzM; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcUyTZ/tSP9FvYk/OwUff9znqc+kfwvKz/cyswszWN6lvNVcFDe3Xq2r8HCtfHGTl4DTT70sVMUEFXE3zmbsyN/U1xfIUauKhtdNogWkzgTMC/nBRnLz+40G6vSqJdPj4+JKiJ1Y+qrDc0bdFJhnV53dTkM6W/Ae8mqLXOHPihIu2+tFysYpvFJhgzMMapiS6kzKtpIrZ4mG14ZFfuaeDRIVEAI4gSNPY2VpWWnJeChCTlzYlnYX1r+7pRlYd3OGFXwQyhS1j7MXDZ+NPuchYXIgXBqopPmlqti8sGVbMeYyf18h2iTwG9NiEMqExsOzxwRtgWnW08ShQdyjo0dbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxShEtpkvRDBUpu0orOGm4w9j8Q+swviZOJ0wA3ng1M=;
 b=AqBNhBLIIrssEh1ejnx/uN0pJWTahmfge+FlH0DyDZMX4geMSP0TYnizyNPTBklCOg3bIH2zkm91djS2MiaFVlJX4GFHBGaa/SnWAdoPcVWgi4hEc+nKeThOeYmK+IIrOeF9ktQs7/3ypnNSZJfX1c8LjeH1BgV9oPOBadUecCXBLi419RLf2l2rpowK8MkP2Khk6fvvHR2NCXtNtbSm1AuuxVkWJlEye9OoiOVabYswHqwb8YZNks8ywB4v1YI9VInlT9b9KsSxK2QLTbJAxsg47GqiggEitG0gUrppktj86nFanbJs5qQa09C6QRE5c5Z0/6c/e/BJTKx1n/9xHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxShEtpkvRDBUpu0orOGm4w9j8Q+swviZOJ0wA3ng1M=;
 b=SBImEGzMVCVBBS7U+JDAlzkUWpGMadVoytiwxRDxSePOc6P8wHOwaak1Q3qpGYTUx+v7E1KaQ2QPlNOL9USrVI5V8zwHq/xRQ1TTIIY6DhLXIR/5tIW/Jwz+ms1KPz/A6LvB/6vdGjyoudsrj2wSJthq91EMGgmRuzaxkJD4hfxI2zpqG7c2ZyDvYv8o6ugnAWkONb0Ch6K9wk/fRVgygjXOFNp1/pHVzXgLEMuuVy0WDHbBrRhp/BODRvfneJuTiYN9iTirCDDWjro3KXRKx1A0nSZsT/tpv4WwDlvg0sXurqzTxlKYP2SlnqOUMBS8HjFT4FFcnbhqdF9ybB1LGQ==
Received: from BY3PR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:254::26)
 by PH7PR12MB9223.namprd12.prod.outlook.com (2603:10b6:510:2f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 18:01:49 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::49) by BY3PR05CA0021.outlook.office365.com
 (2603:10b6:a03:254::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Wed,
 28 May 2025 18:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 18:01:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 May
 2025 11:01:25 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 28 May
 2025 11:01:25 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 28 May 2025 11:01:23 -0700
Date: Wed, 28 May 2025 11:01:22 -0700
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
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 13/29] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE
 and its related struct
Message-ID: <aDdPcu50/hfLpRoz@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <580a36f629402506d232052ddd20ef21ec91d5bc.1747537752.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C599F23964E423CCA2738C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aDDslV6ZJpxJNuaG@Asurada-Nvidia>
 <BN9PR11MB52767BB0CA36643D957BD2CC8C67A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52767BB0CA36643D957BD2CC8C67A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|PH7PR12MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: 1255b6ee-4102-4310-b1a3-08dd9e11b7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IpBPmUsFxT0hONmnmAd1KZ31Jru6oUkQrs4+Ta6G9UtEDzy7mmCyO34RjYMI?=
 =?us-ascii?Q?wmts5CimQw5B00QecJz97MQ8HLFAECMnRhzMYE9SIL+MFXY3knv1At/FMPts?=
 =?us-ascii?Q?Z4qcDUsco7SR6KeMrStGDp81Z9niqNQC/ld3ho6uDV6xcpSiJFa9NH1ihdih?=
 =?us-ascii?Q?1OpBwdpP3Pss/43KFFxFeu6dPg7Sv/ZOC11TKrojMe5RVF7RyMxn/owVQkJh?=
 =?us-ascii?Q?uzMwXoSRqKLQg3BghnaU7q05af5RqWSbEwma9H082aFRzYiRkLMk6bFAdOn+?=
 =?us-ascii?Q?ok4B53WU8UP1MzY646bMPWGSjHeGfcpPxuatKyM2pdfr1k7Y+Fi4KNarNjst?=
 =?us-ascii?Q?Y9NQry8FhIy8pYNz5zdpmDaADIeNbBWwPpS4fCI1ioQ5SplWFBnN232Sxb2I?=
 =?us-ascii?Q?jyAHDmp7FNLM4H5A86F4GOl55XlKVGUQwI24RcGu6J7u1oitjEap+iDVWW5Q?=
 =?us-ascii?Q?9ZRfuCJ50HrR8lRIiKhvHsOsEWG5EcTaLvsXbwlZFVpmpcDFX0xaF7I2cPXC?=
 =?us-ascii?Q?76YKbGDJCEWVSFfQk2lbC6fcbuoOnnVHceWOo5xZplGUjhAWt6oPIxQK2eko?=
 =?us-ascii?Q?jlUJSl+/o+jnt+tBl7rVclo0m3UdqPPF5m5tdB81HG+tRZm5voe0Wk/vzv2X?=
 =?us-ascii?Q?/GjksyfaQTFpJB6P9oYTwW5wba+viBB3lVFjb+ylV7NVQJq277wQyodRhH8L?=
 =?us-ascii?Q?3tzMzS3AH7uCt0isZDZ5dYIaaBIUUyhmRBpfbEqXoEwSqCezI7a/U2VsCpDi?=
 =?us-ascii?Q?qV1vCK06ShJiSEBMR3ioeSlsRDoGtZMT+6xWIXzW5viZE0aH/VOtFLYObNQJ?=
 =?us-ascii?Q?lyl/MVF317QLL0983L1hxukNihWFE5Zca0RX6gJCE/xJsiEuK2K8/BxO/2mI?=
 =?us-ascii?Q?3/+erbv2goLtDNFYpkxbJMXXyZvOl04Fgf4Lm052Xc2xXSYpDdjY3szjKBud?=
 =?us-ascii?Q?nwwu31GQl9kkENfTLwTM2zoZQdufmFDcHsY7CJk/wUTkxYHwyqKU6e7yu6Kk?=
 =?us-ascii?Q?gG9VIdhRBGzMivZYgdDre81bUteDXy5aV2zto3kjGWFQ//cBV0DVy3vyiUaO?=
 =?us-ascii?Q?mM2WKRn/ukBss2iee8Gc53qAhGjUUu/ba5EIYWQuvI0iH2K/WzSvF5KH4AMq?=
 =?us-ascii?Q?nV/q30S1Ztyqe2qCJf/E9mO7YAlyDnxVRS3ZVPgz/12PxMsfvlxSOOG/peVW?=
 =?us-ascii?Q?CM/eh9DcC2AQ6AJ6jPbBQNhbEnoMFw7b0ErK3pyvZQIySQvoCA9s88EkM9od?=
 =?us-ascii?Q?jjVhPDtrEdbq31eqd2tyUEmJ0gIHuUM3HvwlFW9JLrnxg4gRi/fqNrHcvJ+t?=
 =?us-ascii?Q?xnrvBC89eCu/l8rQ7iiu4aHbaAm2zBcgwuVhnspCyL6s+mmm47sqgQ3Qy3xo?=
 =?us-ascii?Q?GPrxsIi7LZ0ECQHA2xg4dLfXzm+sPswiKW825CXRbLOWoD07LnU//4JbTbGF?=
 =?us-ascii?Q?0+zVDSYoPgzcFCESVJX3oScmM1rZn0wxLqq5pkB1OSJcuu79OgYMiumvrf8P?=
 =?us-ascii?Q?U/8KT9yNKRsi6quO6LDecjq2FNG3/Oe7+bNs?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 18:01:49.1392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1255b6ee-4102-4310-b1a3-08dd9e11b7d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9223

On Wed, May 28, 2025 at 08:12:41AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, May 24, 2025 5:46 AM
> > 
> > On Fri, May 23, 2025 at 07:55:18AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Sunday, May 18, 2025 11:22 AM
> > > >
> > > > +
> > > > +enum iommufd_viommu_flags {
> > > > +	/*
> > > > +	 * The HW does not go through an address translation table but
> > > > reads the
> > > > +	 * physical address space directly: iommufd core should pin the
> > > > physical
> > > > +	 * pages backing the queue memory that's allocated for the HW
> > > > QUEUE, and
> > > > +	 * ensure those physical pages are contiguous in the physical space.
> > > > +	 */
> > > > +	IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA = 1 << 0,
> > > > +};
> > >
> > > The queue itself doesn't read an address.
> > >
> > > What about 'QUEUE_BASE_PA'?
> > 
> > But the HW queue object represents the HW feature, not the guest
> > queue memory. So, it is accurate to say that it reads an address?
> > 
> > We have this in doc:
> > - IOMMUFD_OBJ_HW_QUEUE, representing a hardware accelerated queue,
> > as a subset
> >   of IOMMU's virtualization features, for the IOMMU HW to directly read or
> > write
> >   the virtual queue memory owned by a guest OS. This HW-acceleration
> > feature can
> >   ...
> > 
> 
> Okay. Then ACCESS_PA means both read/write?

OK. IOMMUFD_VIOMMU_FLAG_HW_QUEUE_ACCESS_PA

