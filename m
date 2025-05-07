Return-Path: <linux-kselftest+bounces-32556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71B8AAD85B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 09:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAAD1BA06CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4341220687;
	Wed,  7 May 2025 07:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tjql6ROr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0164414;
	Wed,  7 May 2025 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603507; cv=fail; b=VfBIrerd/s2347g28RErMTeEMn/jgCq0Ldzpqnig07/jfYkotHfmBg2MomFWVyZNbjJexDLlrq4xrWBiPm/Yg47TyUtZszv2glUT5Sh3XOQrzcqa2Xm6IpuXtX0mCRLpxZWMuZr+h3E6Omgaiv5CZHPZ71wruz0l4d/mKEMgmHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603507; c=relaxed/simple;
	bh=Xnz7188/Yj+Jri9UOZ/GOpeg00zU34u5/D6DmuX8IBc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGP8MQ8r9Ze9gaOnLE7mbAsGtkCz6YaUIWiKiZFEt8EDFY2JxDpe+HzVJaEwErxqH0B46mJw9553qXabBua9zKwGQYoNxnHAixJAC8sMB7VtyT1csRcBwW0D4WBWze0+6OBkmJbuQQDZK9njjKYMIas9kovzRLQr9Jrcr00n054=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tjql6ROr; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leSuRo8W+5QS2zQB5A3Sb9RyY6m5QjUwv3F5th461RJ2AoZrx0TGJMmPUYri2TGauf5vq5LgDyGaHAG4YCf7kVJkcQA7tezW2LSruDPG/FqjEFqsf9odS1OUnRxBAPP/zmU9kwFfHRyrvtVB7EMv8Lw/mKXOtDStyC8XK/4xabfYi93s3bDLit5NChea0UmUvnmyFay1V+dMcRgvd6sUjtAg8whxPFjmTVfyBIP7mnglSpirhng81e16tKvJXVVK+Kceb4piP34HaBZjYAMq0Z9/omxpItT1cnOqzTKyYycvF19xw7DlMnxdLygl6eivXpDs6XlE7187IC/Kju2z5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPQFxXQn20TUhU6Nv+YOKHYkTlNYUCRLunhoyC7+Obs=;
 b=c/6i4DPZWc54CWjWo/de9YmaXrU9U1hbYL5abqQ1sdLyStXVO6l75ffCi4NaOLDhV4bprOx336xHsB6Z2gAw123W+XJ98Yu9yKOJk/BNjTrXKWlh94EFxsATv4PCxhYaG+0uG7qLSoyliVWYXVt9XO8jlCfifMD4mjAZ7IsLDci4YUkijzmg+jGgqo9rPnNesm07U4EUku1vBSyx8GMhQisetsKion0vis648p2uGaGt+gheew4UJ9Zuj5qp8jWnQDc9aR5u3pyOKXM9Xtp3sgZBkCizXHEHt4Elom3QftJAePpHuTVB0dV7t0BMZdiINAyw2pSXBHjS8K6zi1llNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPQFxXQn20TUhU6Nv+YOKHYkTlNYUCRLunhoyC7+Obs=;
 b=tjql6ROrqb2xcz3NDGtyWLHd96KsXlGcPfOM7fMf5mTxHme9kHkpJHXAcGEuf8h2jbrE7m/QsOvmY4F2SmQbloUCrbw6q5x35zhNV2buMuPpLQGOf81yPVACg+TA7nlOUuptS0szw1U6l1mCsh3PazbacXkST2EYUYGyfciigx7VPkeg6K36Pn1WFUZXrABTH+mL9NFYvToNi/kbQx+Hnnno4FR2XTPcQuuYPwL95oWcPASSDB4XAXCzwaUW2u4AOcRg7Ot4PP4KCG9g1rXrXTn+AFStTYf+i3bku0y/x0Y9wm5JuynCHlavFLp77UYE5Tang7+d4Xz/rerxgWFhzQ==
Received: from BL1P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::28)
 by CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 07:38:19 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::20) by BL1P221CA0008.outlook.office365.com
 (2603:10b6:208:2c5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Wed,
 7 May 2025 07:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 07:38:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 May 2025
 00:38:02 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 00:38:04 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 7 May 2025 00:38:00 -0700
Date: Wed, 7 May 2025 00:37:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>,
	"bagasdotme@gmail.com" <bagasdotme@gmail.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jsnitsel@redhat.com"
	<jsnitsel@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Message-ID: <aBsN1ZDr+jJJ5EG0@nvidia.com>
References: <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
 <b0d01609-bdda-49a3-af0c-ca828a9c4cea@amd.com>
 <aA/exylmYJhIhEVL@Asurada-Nvidia>
 <b8338b47-6fbf-44ac-9b99-3555997c9f36@amd.com>
 <aBB1gLfahnLmn0N1@Asurada-Nvidia>
 <a3860aed-5b6b-4e68-a8fd-1a6ee28ba022@amd.com>
 <aBEI+T7P+hV8Y6tU@Asurada-Nvidia>
 <BN9PR11MB5276A00FDB2685B394FB9D4D8C892@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aBptQO9VBnO2AG9V@nvidia.com>
 <BN9PR11MB527651D1ED8E6CA4677FD7678C88A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527651D1ED8E6CA4677FD7678C88A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|CY8PR12MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f6a253-e7da-4ee1-b68b-08dd8d3a22da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ropV7QlDQ/gAInfBOYt0Jaz3Aa/hCtPIl3t7Ralu7bHuWwMAQYwaHzAS3/br?=
 =?us-ascii?Q?H9amBI/qz6QAduAGh/1DB7ZbVdjdKLseATvbr6/vdBN4Gx8GCEfKlXslYl5F?=
 =?us-ascii?Q?bGVAL52rt5Cma3udCmMBqDhcU85ImDBrUxI2tr/vFNb8SrJ9lwYtL43hm/vS?=
 =?us-ascii?Q?hB5U/vRUhZ4232hwHz6J9Jl5mE4oPPQk7BoJqZrrh3Z59C7GybZAPDf4A2I2?=
 =?us-ascii?Q?VTTaYzbHo8ajcQZ/SBDojVIDVMfQha9SgGGf1obZXBm/C5qYPfk+xOUdqmX1?=
 =?us-ascii?Q?P0EbQoGbwcMcXNVaXKdNZFemD04MGk+JNZTTmHzZbCJNwiv/kzR5HVzTFNPx?=
 =?us-ascii?Q?QVb/J73CyValO8n7euO6GbKIjovolO/aqKuVVphV9PNkzUhNMrbELjjL+Q1t?=
 =?us-ascii?Q?4Q46dTPyXH1EeNOMp9Opkv9ua7MAPVibfO0/a4xCHEURbUPMz2HwfgUqZn/x?=
 =?us-ascii?Q?thECWl8AzT1RUND5+ePQi/BSwKCTntwsCULcf1+eZbrn2yG9MkzW/UOJeICG?=
 =?us-ascii?Q?Mi2IvIvQKE+3U0nm0yGoVGztw4klQj2tBtkxtMiVzEm48JSrzkhVxaEqdv6W?=
 =?us-ascii?Q?W4fwQM6ageL3ODrYRX4d02m7VAYJuAMrnpEWYJFsBocnQgRUeUtGZUi+daF2?=
 =?us-ascii?Q?B8jLg3ylmw6QrxR48oC4CXyKCY9PMcUHFK2ht6hgrjaeie5TWfwmsPAB4I95?=
 =?us-ascii?Q?vah8sQh6/z+Ue+CPvQJL3yZxZZ52kjm8yvX/KPT4WN4B2Y3Wjc/CRH4n+XTh?=
 =?us-ascii?Q?Em+Fj9s9Qyec6+w7gLFiHHmdlZ1uAhunnMaKfusGVjAmCXzNzX1ZHTY1S9RE?=
 =?us-ascii?Q?nh4zyOGurWdfpBhY9VPHlgtcQic1WWcz9Rxc2sn2x3UUux+V3s6BPpUumJ2t?=
 =?us-ascii?Q?a2R8lYgmzWepaDkUTA3XmFIXx6+Gl3GZTtcey5VOLtmIn9Szlp2Aec/Ss2vp?=
 =?us-ascii?Q?6LGp79FKbj4w2AGMo+9JDpzc8qff2RrDoNAV12N5t3JyFh8eFrvyJbaOIezm?=
 =?us-ascii?Q?6jBuytdNYNCWO5m8wq4s9b9I7nGTZxSkto7K7tyUjDyQtZnGEsl+skEQ+UVI?=
 =?us-ascii?Q?jLH/bUScuh+PXBHbr297uNDcmaJdc7Qg9N+HX5otNZoq84Nkg9gaVwIBkjpQ?=
 =?us-ascii?Q?OJsmWDqz+b+6iHftrO8zidL4jmQxIXEnXYs+j0DJzx/k5VGqJAI87rk/Tbke?=
 =?us-ascii?Q?7TS5KR+8WfSG8xGpBu7pTHcumCiERYC+OyRV+LfVvTHuPgtaK/iCqsZbaFA2?=
 =?us-ascii?Q?KjIrf0HNi/J5xMKdLE2xt+UWPwYB8vF1p9MbsQX15N7GGQ+/06tPrS6r1KGF?=
 =?us-ascii?Q?t014XZNck0kMr9EYmvsyjYlrVLJfNbyw8Ky7u8/hynX6i2flTk+DBlXzlLYj?=
 =?us-ascii?Q?v/jK0yJZ3QLQovc56BZ3HQjbjaMY/06AIyJbryww6JXTJM+grL1WfVeAzpwi?=
 =?us-ascii?Q?UbnJfs4yjv9GDwgPCACZqRK/w+L710cebt2CGd6LHSt+lQvau9YpbStK62gr?=
 =?us-ascii?Q?1lMwuqcrCiWUfVJ86T2JaL38LpDqXAJtOdP5?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 07:38:18.7031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f6a253-e7da-4ee1-b68b-08dd8d3a22da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122

On Wed, May 07, 2025 at 07:25:41AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, May 7, 2025 4:13 AM
> > 
> > On Tue, May 06, 2025 at 09:25:59AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Wednesday, April 30, 2025 1:15 AM
> > > >
> > > > On Tue, Apr 29, 2025 at 03:52:48PM +0530, Vasant Hegde wrote:
> > > > > On 4/29/2025 12:15 PM, Nicolin Chen wrote:
> > > > > > On Tue, Apr 29, 2025 at 11:04:06AM +0530, Vasant Hegde wrote:
> > > > > >
> > > > > > Will the hardware replace the physical device ID in the event with
> > > > > > the virtual device ID when injecting the event to a guest event/PPR
> > > > > > queue?
> > > > > > If so, yea, I think you can define them separately using the> vCMDQ
> > > > > infrastructures:
> > > > > >  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_CMDBUF
> > > > > >  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_EVENTLOG
> > > > > >  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_PPRLOG
> > > > > > (@Kevin @Jason Hmm, in this case we might want to revert the
> > naming
> > > > > >  "vCMDQ" back to "vQEUEUE", once Vasant confirms.)
> > > >
> > > > I think I should rename IOMMUFD_OBJ_VCMDQ back to
> > > > IOMMUFD_OBJ_VQUEUE
> > > > since the same object fits three types of queue now in the AMD case.
> > > >
> > > > Or any better naming suggestion?
> > > >
> > >
> > > What about IOMMUFD_OBJ_HQUEUE to differentiate from other
> > > pure software queue structs? 'H" stands for direct hw access to
> > > the queue object.
> > 
> > I think it make some sense. There has been a concern of mine that
> > some day we might need vQUEUE to deal with some non-HW-acced case,
> > given "vQUEUE" is named much wider than what it actually supports.
> > 
> > Also, vEVENTQ and FAULT_QUEUE fit into the "QUEUE" category too..
> > 
> > Though "hQUEUE" would break the naming pattern that we have, 
> 
> what is the naming pattern here?

vIOMMU, vDEVICE, vEVENTQ, vCMDQ

Thanks
Nicolin

