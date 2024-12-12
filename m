Return-Path: <linux-kselftest+bounces-23280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A16D9EFE31
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 22:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103CE16A293
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 21:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF991D79A0;
	Thu, 12 Dec 2024 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fAhEfqPh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB791BE251;
	Thu, 12 Dec 2024 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734038908; cv=fail; b=bQ2ROJK/1XVG2PJIZzcEc++BzFz0ze0vSgPLT/Oc10Jc7birZThBYL22YnKXTE+cgzxtn6fRCbgGJK/3wuLaKt8ArpJxldSFwb4Cr68z26Z2Vx7ArOnwybf0NnJ4/VW2ZL6rrhSNCjMkJOelMrj8caa4ujxrPil0yTXoWN7qkRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734038908; c=relaxed/simple;
	bh=WclziJ4tc+Q/imRMTduhyvLNioVMrGI/RKmnOuX4/EI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vfk9Ed9ECKnHwMt9BuilqAMwfUck7eWhCgiwwJ8jTqE5GtF0KFZxG7YxxDPtRMuRUCzREpcRtK6hKyaqNzot0FAKn+3lNW6uJRbh8qPNbQAp7HpoANhMAMVHPw60g2pULsCwleIqiMSkjMdowHKDW7gUyLsu9Zkt3XEiiTBovFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fAhEfqPh; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yU5+nzxQGHn6d9VWllLrJepyRHlSkiJH1TBvbcZGRB3QrRUss6qiK7qp00Lc17W6jIlNFDDA/Y1AjiPLhRVblxGREnbnFiC8YOzXi7nP9GVL16053b8qEUQT3EFRgKFqgvCFUoQzNPJzzRUKWzo/yudokfbPzRlKELFOIGNT3EXb5HczmQ51p1yA2xYxDa9d5KO7/0wp9/HoVElYmwPZN2vCiz14NDz7aPua9cjwyMb8ZA7axxUvVBdf4EafY2sgDLcCDSa9hjZXMkN3R8cI+YXidmLEQJiHtLMsH17ZfCBytgRFzFi4jXqs8L5KqIw6a8GrRdbU8FRcG5Ssbl1rJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydPARcREor40sy81MWPMmAqroHeXpt7SvRqSf2oB5W0=;
 b=vQZ8+XxeDLMmPK2yPBRSGKZfI+wRdtjuYaRYt8CkkvA2olY/r2y1iopZ/wYzFDOYIoiaoRVFh75lqdnBKuh27jVx75ndMZ3uu4Z11VGPdTVWSP625GNuN2qyEpDfR3Ccil8lEvzlo8SVLFPI4IiI/otxgrSSmgkK7eKazZT9vvjVB+HvKkj5/yMaUJaT53kRvtFPBKkYTJpUSrjLPw9PKJ53RPYVdYWfk69ayF6fhmw/001fH/nabYszIJDAQWtAcg1T/poIlp6t32wMMIzmd3xgwCvUUvaf1ucJLo8TM0g+P687Z7CihNkPl5zuL77e3EjEMKTYv1MlH6Z0M3b1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydPARcREor40sy81MWPMmAqroHeXpt7SvRqSf2oB5W0=;
 b=fAhEfqPh7R0vl/1gMCL79+nnTa8eMTmy/DeG62rtjBRaMkeKMJqIqh/LrlaJi37rW1seU8VqwqNThlnXE0nFXVodQuHUpRm78SmY4BEvggLj4UYu1cc6QrcxM55HQe/8TIgWbGEK9hXVchf67wWvFAbktLyhIfzFRaTbYxB69IkwBIphl9/aJ7y9ftBmm057xQRt5ZvnNsNzcBEw4/XAZJonJ4MnWVujqcFjdxYHGgw/aNBWaYXdIh2pQ40JzSFcw5bHlheBC8iUGXdFDuLbIkIiqJ5ucHEE0zi/Ngh8kkYsAMMo84VfPcIUkbNtWsizUfJdCUOVCxx9z/FiBsnYOw==
Received: from SJ0PR13CA0131.namprd13.prod.outlook.com (2603:10b6:a03:2c6::16)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 21:28:22 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::a7) by SJ0PR13CA0131.outlook.office365.com
 (2603:10b6:a03:2c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 21:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 21:28:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 13:28:11 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 13:28:11 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 13:28:10 -0800
Date: Thu, 12 Dec 2024 13:28:08 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: Re: [PATCH v2 11/13] Documentation: userspace-api: iommufd: Update
 EVENTQ_IOPF and EVENTQ_VIRQ
Message-ID: <Z1tVaIdD4lAjpP8e@Asurada-Nvidia>
References: <cover.1733263737.git.nicolinc@nvidia.com>
 <a5025cbbd16f9c12dcaae7a14868419f17ce1d16.1733263737.git.nicolinc@nvidia.com>
 <BN9PR11MB5276E09D5F2206804A7C15968C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E09D5F2206804A7C15968C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SA3PR12MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: 33668690-262c-4d15-9f57-08dd1af3e7b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3shIGpO4jzzoKIliVRCq3++r0lvL+b1UB0UxcYsqTz5a37UZSgPh+wq8F8LT?=
 =?us-ascii?Q?2UntGsl1D5ugD6MTs3L9GkmOHwKfdydMZ46n1MAxb4HH0tgTtEABHyCDO/pI?=
 =?us-ascii?Q?YsXINAAECUuIwZYFKZFy/dJYeHUDhhDmx8ErDVOA5DuShmqgd1Z4Cy7BUeCp?=
 =?us-ascii?Q?zkIH1d+tXbRN4+pVoMeLGF35PBLcT3euInPFWnAVNxgFTUXGJP+5CPqwbGx9?=
 =?us-ascii?Q?HlKh/yDZrw8tZs3mGVfOiNhLEc2Xzo5riYpNHSSLvO4FpQxRikLqFDAwA+Af?=
 =?us-ascii?Q?H50GDAJCappXAbNukRp/SEFkNeNBFEvE0yJ2Azv/tiK07MYNclKxXFnIGuHl?=
 =?us-ascii?Q?eT6W4ldSGgyNeSgUiNXSGJIsdwHxKtZpudcC/OYJZ0CcLuqAQAKwnkDp7MI/?=
 =?us-ascii?Q?xUGQMh6TvCRf6GLYPWwj6xaUKvBpubcdL/wEU4RDa/rbQykrK0eaS6pSwv9Z?=
 =?us-ascii?Q?pke6gb0xUAJgVLUbC4yHAbSqGoSDSLFiVNLufyExwTBGoKbB6oWmeTsciw5B?=
 =?us-ascii?Q?u6hJfwoAk6q3M4fKUDlNddQNqZiTTjMK7iVtZzUVcYbyhw5eU2Sfh3RQbaZd?=
 =?us-ascii?Q?GxIDbP8DQAvakPQR9HW+3SPznb0UKEPfnpRDCZC/f4i7+sHwiC7K3G/r8TlF?=
 =?us-ascii?Q?GQuH6B6idKGuOmxVSYv2F4ooz5HMDHybFMC5gqrwQYMuZdAym1cQPrNLFt3m?=
 =?us-ascii?Q?Ni4BRge9GXEq7h9M3mxGdfnspSC8tyTvlJnQl+fA35J2SFoLjoAIvPvd/Q6S?=
 =?us-ascii?Q?9kx081ERbIr9vti3PBglCU0AMsLR2z3ZH3n5FALJwPc13i7eeIib7MkVhRAZ?=
 =?us-ascii?Q?1Rw/QH3ILFI3cR7GoqS1e5pDTRqCtjB1S+O2E7ysSSxQjdXd2Zf/9/Flt/Xz?=
 =?us-ascii?Q?/uc6lD/Noh4t9/YaRUYFGb3lXGLRnRZ6EUYim5oI3eTsC6qM8JKPfBy1bS07?=
 =?us-ascii?Q?OF9S8DP0Kf96zIBh2dJrYn7zrOjdNrzVgcd4aq4JF/+/DGunCjwfqtOVC8lr?=
 =?us-ascii?Q?/se5UPjvv61GTrCFaSz/LFv9w/L+NdGg/VcoQwpUMZSahLyu4TwDUvQ4a8+h?=
 =?us-ascii?Q?hiHFGYqBbpoU45rLLsHkLp3CRGAH9YjrSJWnk9P2FQPJod9POiPqXeBrpKMF?=
 =?us-ascii?Q?KyrloYdtAOly94OPOjTtY2WOf9fEsCs+/W163Z8ND+hBS8+Qjh6/6l5k8Zo0?=
 =?us-ascii?Q?fwYPPyqJducy6y4OmFVArXCgFiqFS/3D+WuawSzp6ZVoLMNrAEt4mXJ1KrmL?=
 =?us-ascii?Q?LhmZbpEdDUKXlOhhWPnhpgM4Y20Odzof337e4UaVNS9XyZkwEzCrER7HdxmA?=
 =?us-ascii?Q?QKCaJnsMsFXSCj7RFSzRkSIGYoYLnbWUTJLXMCFuUjiW+TxsNkPrQ0rYyOXn?=
 =?us-ascii?Q?FtQtlMlokyGJ6nQm7uP6rtGhro8a7VHBHTZge89UiwOiPY1M8nLXZXUQTqeH?=
 =?us-ascii?Q?f5qZlDXniSp391iNdQrDTFLgBiNaCQul?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:28:22.1715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33668690-262c-4d15-9f57-08dd1af3e7b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976

On Wed, Dec 11, 2024 at 08:11:03AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, December 4, 2024 6:10 AM
> > 
> > With the introduction of the new objects, update the doc to reflect that.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  Documentation/userspace-api/iommufd.rst | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/Documentation/userspace-api/iommufd.rst
> > b/Documentation/userspace-api/iommufd.rst
> > index 70289d6815d2..798520d9344d 100644
> > --- a/Documentation/userspace-api/iommufd.rst
> > +++ b/Documentation/userspace-api/iommufd.rst
> > @@ -63,6 +63,14 @@ Following IOMMUFD objects are exposed to userspace:
> >    space usually has mappings from guest-level I/O virtual addresses to guest-
> >    level physical addresses.
> > 
> > +- IOMMUFD_OBJ_EVENTQ_IOPF, representing a software queue for an
> > HWPT_NESTED
> 
> now it can be used on paging hwpt too

Oh, that's why it's in the common path in the hwpt allocator...

Seems that we are missing its selftest coverage for paging hwpt?

> > +  reporting IO Page Fault using the IOMMU HW's PRI (Page Request
> > Interface).
> > +  This queue object provides user space an FD to poll the page fault events
> > +  and also to respond to those events. An EVENTQ_IOPF object must be
> > created
> > +  first to get a fault_id that could be then used to allocate an HWPT_NESTED
> > +  via the IOMMU_HWPT_ALLOC command setting
> > IOMMU_HWPT_FAULT_ID_VALID set in
> > +  its flags field.
> > +
> >  - IOMMUFD_OBJ_VIOMMU, representing a slice of the physical IOMMU
> > instance,
> >    passed to or shared with a VM. It may be some HW-accelerated
> > virtualization
> >    features and some SW resources used by the VM. For examples:
> > @@ -109,6 +117,15 @@ Following IOMMUFD objects are exposed to
> > userspace:
> >    vIOMMU, which is a separate ioctl call from attaching the same device to an
> >    HWPT_PAGING that the vIOMMU holds.
> > 
> > +- IOMMUFD_OBJ_EVENTQ_VIRQ, representing a software queue for
> > IOMMUFD_OBJ_VIOMMU
> > +  reporting its non-affiliated events, such as translation faults occurred to a
> 
> non-affiliated is only mentioned here. It's not a standard term in this
> area. Sticking to the later examples in 'such as' is straightforward.

OK.

> > +  nested stage-1 and HW-specific events/irqs e.g. events to invalidation
> > queues
> > +  that are assigned to VMs via vIOMMUs. This queue object provides user
> 
> vcmdq is not supported yet. add it later.

Ack.

Thanks
Nic

