Return-Path: <linux-kselftest+bounces-17766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD74975BAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 22:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60102B216E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 20:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CADA1B9B2A;
	Wed, 11 Sep 2024 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BsIM42Ad"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7A7E583;
	Wed, 11 Sep 2024 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086114; cv=fail; b=mbq/S3JNXz2JAAWjGLpMVvjcZeCVvn2jrzJDZKX1/FwZ15eRlKc6DVwKHpxm8BUoZhUkcpzZD/jp56XDmTiz2SxBW9E9ZZWas5yA3wBbfac5d85ViWnMZnf6C+yaqq2svjTBSj44Y/0rJS7tkhQTDyiufXGvqK2+4J7kHOMzdEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086114; c=relaxed/simple;
	bh=gt7p/hzAGhEvB/M87l1La9p1opQQapeuyJVhAzEs/O4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLFwxQcntbu/jUcLPWNFPdMB4gb+KR3UCkY6MS/0iqppTNueNQmt/dioi2NhDujQBKdZisPsyDqPGHwCkGairrkFwmamzwHsH8aMIpXeJT/1bQ4RL1MRMmbV62VQL9SVEReHjDelUV0DU3vNR3NT5kfJIXHdRAhn+W7TiIITrEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BsIM42Ad; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rike6NhGJEVa2Dulyg8El09OsR+0g4qsnWbxNj8lyOJ8hnzuzrvEo4zuiQd4gTsTjf6xujdBQlYZy2VtjXdRyWHnNcNpSseTBtARLULFaD6J4qVKi43BMkVCG2gs9KEdg/KaWxPIazMLAgOTWRUv8z1Ztv+7O94CEZF51D1b6H1VoSTxM2thNtgWjNDtyP9u416K84GrOGsetgxoKZ7AAVQd9wMx/qjSagqzjgs7hrTqsZaM9f8/1z6wpet+Oc7KEA/YPa2BaVGEDovxoxmoBhEGogSfGPhpfczf2mTGQi2Bi6/FkNtcSx1IK5i92rBrqp4vnLAadpwGN6qzuzzz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CarA0ZSskDj8r8nqkYUKiQEQi0qEd3Fjm9kDUbFnTyo=;
 b=B47qXI8CZxbeTRVWAPYqDER1gIME/TW+U7/5HuT8GxlgFDoNoR/sD8YNPRxels7NDDsfrIGYPrSCaJtWqawde++eshIM2Sq1iPZjbR2kiZiR6oJsQlzPq4xMZPbVjVYb9uKIC5Ui+buJiYp3Wrql//njToN6hDz7PKWpNqty9WI2JPv1YTH2oiWxzt/A/SWlm5ea1JXEuAqYvnsONNb8mEFRmYCcM/9/zYzz9owk8TttpAs4jgQbAi6IDrMoyyCEl//7NnUIvxABwB4kOLXy6XuzxdrnSf3w2d8au+91mVQeSrtdes2skdA2YP9SCVb3UtloXISq/2vvHomPtYjg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CarA0ZSskDj8r8nqkYUKiQEQi0qEd3Fjm9kDUbFnTyo=;
 b=BsIM42AdoQwNPsIs0dqU1VMaOFk7uAOSlJuE+nZDyAWfL3dmdyvriqWF5ZhIZFrRR6RB/2+eWxILDRhEeGZlkN3mYW4r8SNeM1mIZqZAvVf7oz0vWW283HZO5D0mgMZTAIsydKsKpqaUFmT1jhu/fxxIi9Fu8Nrl1PG7v9xSXAzshRlcQ7s8hj5/CxESsIFPglb973ZERqRNAslsLxwcgc9TwECQ94GqALzAlXyMnQyCiOcw0WXqW0zwTGOYGVSqLe0aC0HY66yCdgYFNa4CVQXVXKKkIk5+sOoRSRbuIK+vL90LbhCmNDkYG0vGoD3k5DNnjBknRzWb9YsNJSWwfA==
Received: from PH7P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::22)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Wed, 11 Sep
 2024 20:21:49 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::55) by PH7P223CA0001.outlook.office365.com
 (2603:10b6:510:338::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Wed, 11 Sep 2024 20:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 20:21:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 13:21:27 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 13:21:27 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 13:21:23 -0700
Date: Wed, 11 Sep 2024 13:21:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Message-ID: <ZuH7wwvZWT1FpHWG@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <BL1PR11MB5271EF54689B9666360A0F188C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFB06X7ZTg6ZhWT@nvidia.com>
 <BN9PR11MB5276554A016C2A54C41C64808C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZuFJh8t62LKi3FJY@nvidia.com>
 <BN9PR11MB52768D6E30FF5CFD66B2ABAE8C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768D6E30FF5CFD66B2ABAE8C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d3c61e-7eb8-4aa4-ce6f-08dcd29f5dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XGn28aORv0QDw18GGNGvhTV+b77jnZ7E8ZbyVQv4o0UgoAWu4A2BxfW4hpnW?=
 =?us-ascii?Q?WZKQ++CBV49UGIxt/WwcSVZfiyNSO5tdPphBX+B0QECANm7rzcjJIPWAXFPu?=
 =?us-ascii?Q?gcz5X3SY+3TY10D7igw3KQudCuw938lQov7PNIf7u4hjzPnvE84ALnnlRcPr?=
 =?us-ascii?Q?fdkqZuUnCIKLuI7FppTHndPvey1PXaJ+XQTmaXQgaeAud1GCGXVrovsOrk+L?=
 =?us-ascii?Q?96lJEbKrZPHv0Kk0VO2XkYyGbAAHBOv214Qc1LoHtU0CZAKD1xPPaqBuQnIF?=
 =?us-ascii?Q?dcHJ3I/pKPpV4nrkTZgfTn4KZe/tVM5aSXC1Qbp+M4Awa9VubcetjMTYP6gz?=
 =?us-ascii?Q?bpOjG3tyZSrtJJnWr0awC4mApuiwoBWTjEc9WpWFYXsEiswecaUpZD2tbIUG?=
 =?us-ascii?Q?9Uny0oNGL/uf5GdfAqSYwUEqVZegHyPmWaNrBjm4Ha/xsAfL8YfsDch0Mqkg?=
 =?us-ascii?Q?dOx2Y1t+ujusghJ70RRrt7Dg2zBJAFCthrpus5jgdCUIyv65xeuIMBc6Vw+V?=
 =?us-ascii?Q?J1cUmfxihZpQj7BgZ0qwqkt17PEjc1VwknAqdNb4hiPiKseWvRWEmlya3zV3?=
 =?us-ascii?Q?UGpbzo3x4ABvNt2CLHoVYXMegIeTkpP2WSH+xF9az/TnHptc7HsgifUK64dr?=
 =?us-ascii?Q?Kb4+ZelCYWRvsbUsDwFrrSA8ns/G8wk5G7bLWjsFDwLjgAAhTfoxbVq4aHxF?=
 =?us-ascii?Q?A+w59fcjE2YVEhQOFwhIyU/TALWH4PCpKZEp1d24QRJELCuX6jIAmnGGQn+x?=
 =?us-ascii?Q?KIHtyAOvzpzh7e7RuEKKEyn4SukG/nMAhtFVxY7Ga/uetcDCQNrFSzD5XJBW?=
 =?us-ascii?Q?QRRQskzpCZbBqiluq6u/GaXID+SH59yiY4/v6IiknbRF8T1D1IeQLM9aGiV7?=
 =?us-ascii?Q?cyPU4lrv9DSXw6Chrv/WNwl0dW+4TFewwLTGx6xBa3tNq0SQ5pOHnFZQCWdv?=
 =?us-ascii?Q?kJK2Y7v804c8I4A3euTQYZDZhJ0h1brFakcoBv2lVvpuU0JumUQKEcaL6qvO?=
 =?us-ascii?Q?eb9k3/5rgX9As1NyfleglDi74ay24XOOZhqB90qo7uS/7z4V6uSdxhq5MB4m?=
 =?us-ascii?Q?8dmCWVFxMvbCMGEvoTzvaxqiSvUBEIWjVnxwGjUuIORy54x3yxEgui/7C4rH?=
 =?us-ascii?Q?k09HhdKVGraHtzux4cl69LBZCU/yi39kkuuIwkY0CvKm+mmnTTKO55LvKzmF?=
 =?us-ascii?Q?i1A0BxrHrv3UA/YRQhf1cKUiO6+IhE9QRUB+sFY4KrWunM6nMWopV1N50RaS?=
 =?us-ascii?Q?68Qkm1Q7tTYcg7OfFxWW5olPHtFgKG40wmMvNaufktosW7tiarK2ZWvG8uN6?=
 =?us-ascii?Q?EMPUZVdJaig1DjZQrLrXlokttN0EVZNM0YCF4s3rIYlnaTKLC7na60VThNdS?=
 =?us-ascii?Q?4WoozaFG0y3XRI2ZVXrFHGbinOrqJN81wlATSyvZrKlUBNkleM84EsR9cpKY?=
 =?us-ascii?Q?JJTcFc/3NNQrJ0Pu14cfPqnru4+P6VhA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 20:21:49.3354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d3c61e-7eb8-4aa4-ce6f-08dcd29f5dc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255

On Wed, Sep 11, 2024 at 08:08:04AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, September 11, 2024 3:41 PM
> >
> > On Wed, Sep 11, 2024 at 07:18:10AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Wednesday, September 11, 2024 3:08 PM
> > > >
> > > > On Wed, Sep 11, 2024 at 06:12:21AM +0000, Tian, Kevin wrote:
> > > > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > > > Sent: Wednesday, August 28, 2024 1:00 AM
> > > > > >
> > > > > > stage-2 IO pagetable. Each VIOMMU then just need to only allocate its
> > > > own
> > > > > > VMID to attach the shared stage-2 IO pagetable to the physical IOMMU:
> > > > >
> > > > > this reads like 'VMID' is a virtual ID allocated by vIOMMU. But from the
> > > > > entire context it actually means the physical 'VMID' allocated on the
> > > > > associated physical IOMMU, correct?
> > > >
> > > > Quoting Jason's narratives, a VMID is a "Security namespace for
> > > > guest owned ID". The allocation, using SMMU as an example, should
> > >
> > > the VMID alone is not a namespace. It's one ID to tag another namespace.
> > >
> > > > be a part of vIOMMU instance allocation in the host SMMU driver.
> > > > Then, this VMID will be used to mark the cache tags. So, it is
> > > > still a software allocated ID, while HW would use it too.
> > > >
> > >
> > > VMIDs are physical resource belonging to the host SMMU driver.
> >
> > Yes. Just the lifecycle of a VMID is controlled by a vIOMMU, i.e.
> > the guest.
> >
> > > but I got your original point that it's each vIOMMU gets an unique VMID
> > > from the host SMMU driver, not exactly that each vIOMMU maintains
> > > its own VMID namespace. that'd be a different concept.
> >
> > What's a VMID namespace actually? Please educate me :)
> >
> 
> I meant the 16bit VMID pool under each SMMU.

I see. Makes sense now.

Thanks
Nicolin

