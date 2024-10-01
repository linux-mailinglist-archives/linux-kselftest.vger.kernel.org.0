Return-Path: <linux-kselftest+bounces-18806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9304298C57D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 20:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECBE284E7F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE1E1CC8B0;
	Tue,  1 Oct 2024 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dBRI2p4y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E4B1DFCB;
	Tue,  1 Oct 2024 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808036; cv=fail; b=qhLOhXhp6I7SSmDRzK25RKSuKgY8CTFHdM0Mh6RdOSoVo7eMogjwaaMvcfy/UXjNhyfbtxIPHVKdXZiiK/l8MMm7yqnTPgnEBucQKqi4p42msyCvuE/D8oeA+AOkYSFMYbdfBWg2Br1vfac2i+Rvm3EXEXKFTVbaoPq23s25Vw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808036; c=relaxed/simple;
	bh=dHiu3hksUeo9iLx9L8TIXKZ/9RAd/pLPtJ26MnVXiyI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvCQCGNoE8DE9ctLXj1hHlttkpPm/1i3N0+6Up5Zd0CMiqzDIqxa8EIN43C1J8krahGvaJlv1Z9eXpF1SwiksKIwNrATqdIsxrWm+M73YjXg8vNg4AwRWdKHAyl0Rjkez9f32ieO58JcOke9c7FkfFiFSJKZM9b9GmkwmirT9Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dBRI2p4y; arc=fail smtp.client-ip=40.107.102.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXFZFj2ukff3QiUtoUpp4HIQ6grUJ9lLD533xh8igpVWi32ymrMk03i2BLuGsK19D/5H89sq7Fi187zBIVCfrJ+FejOaVs3tY85tNsPNXtdAibeO87/Oh4RnNiRrq51Oid/KykE1VmgqJPO26KIExWG3nrzqSUYwAsyyKOtWeyd/wqnC1G+E9kVVUIEmmh1kF7jz5+ETOYkIFJCl2ZpDMyLbJriC7/w1Ddp0jsrli+f9R8RVyV+3HRfZSkV02vRb92/4u3tAD6uH2nDY4hkLObkCRcrdeTyRERu7JQgTM+fN1VZrjc2mi5etESNf0IN3KZPNyQ8IUKTPKcEuvTG6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eP3kCR9GfbUqtT0S/7jkH5Nstx02AnSdqAmYqvFRIg0=;
 b=sIRu0R9gfiPKdPyQm/i70gyZmfbHIH+fN0vTmFssMQ0AmJdFQDQSIR6LK9hZKFq+rxE39Sqf5p615ueDDqI2If4OIblXDiMsA30zZNcBP0SrdmZtSkZvNGTYGvFJGU3K2ysYWdcUPQ00aDNTk+FkOWby9FAlBajwDUluVKiFi+/5yCopRsFKTP8kXf5EPuzaxSBNjHyTb7g7o0gnTluO0MXsIcNVWGMw76BOWl10w5Mwc7gsVPPAtS4UJh4Rp4Gl8mh+1VMFpk2gACcyzjTZc8OYa2axxBprGbY4N1VUeJvI80j2xQmNkwqD05wD1Xz+wjY2o8ROmyCCMCbpHPZTHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eP3kCR9GfbUqtT0S/7jkH5Nstx02AnSdqAmYqvFRIg0=;
 b=dBRI2p4yE0jDqGbEPWZRDgsEJMtWK/wBLAiZaKJGYFfiI2ee+yezTTi7zPMbo4btIhCxleLJp1mP/yCKdT3ohgyUfmtjTs1K88lTefv4hkSFTlkRUGflKTxvExZIhh0vM/9g1BzJWkCSlej5yUMASGwqlc9B0TEWkieY5XZ7+EoQ1GhO9jnNaWWx3GB6i2cnmgxhdNqoMoB9HHXIIPPTeLldMzwhhXsZRXv61LJl378lUrfvDKs0QfW49rMK0NYsN1UVuMRNGd+qoRdHpQL/nWHVKWvuNaS0Cl5TpUHsGbisIX6oGX+K8+SxL6+pIdPOvL/H3JVPQXIDWTmBI9j+uQ==
Received: from BL1PR13CA0327.namprd13.prod.outlook.com (2603:10b6:208:2c1::32)
 by SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 18:40:30 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:208:2c1:cafe::75) by BL1PR13CA0327.outlook.office365.com
 (2603:10b6:208:2c1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 18:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.1 via Frontend Transport; Tue, 1 Oct 2024 18:40:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 11:40:12 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 11:40:12 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 1 Oct 2024 11:40:11 -0700
Date: Tue, 1 Oct 2024 11:40:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Message-ID: <ZvxCCp6OuuCMyw8M@Asurada-Nvidia>
References: <bf95f910-e837-4d79-8218-18d234ece730@intel.com>
 <ZvRcskGx2u94Vs+R@Asurada-Nvidia>
 <82632802-c55a-4199-b685-8b594a8e7104@intel.com>
 <ZvW+BoovlyJ/wziX@Asurada-Nvidia>
 <ff35efa5-ba7e-4974-94be-59bf794a14e3@intel.com>
 <ZvZRapZlAsEGDIge@Asurada-Nvidia>
 <8440cd72-ced6-4887-b724-ce6a1650db13@intel.com>
 <20240927122051.GY9417@nvidia.com>
 <d5fe4c4d-fde9-4d25-a580-0dae63c62ba9@intel.com>
 <20241001134815.GG1365916@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001134815.GG1365916@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|SN7PR12MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: c13dc103-2239-4fe7-4d48-08dce2488686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6HZp8rwpTcNE9qihyXrZvk99HrweR6+JuRxYW4KesYub1RCyZm2F4vCbNNue?=
 =?us-ascii?Q?ybglHRUtreslOqcAiOlFYcL7RUMq/bNIWE0kI887CsWyKIiBXyCBS7scYFHE?=
 =?us-ascii?Q?civVcViEk3L33Vp0b7RbC9BwLL/1VE6jDetRkuMwI/HUdFsbJpbAt5xCmhQS?=
 =?us-ascii?Q?YNdCueu+4sLyfrzKlb+8AdFWajRJ/k6m26kRYrOAEk6oxvxUdgvG4g4PDkBt?=
 =?us-ascii?Q?Amav96050/YQrWwdUVAX9JlMPJAfPxY6hDFVJjrysd60aYDQh4zaJCQPgbBo?=
 =?us-ascii?Q?2Xt/vHPmbLNKjUZfeItR5pVmQkcO3J5o5aXAEIj5jxuX3rGjjQl/bUA+82Jk?=
 =?us-ascii?Q?mO0nDtSAWRhVRqz2xwWYuSWHOyYUrr0YlVU4kJ070/B3U+/L4+aPqUg2uci5?=
 =?us-ascii?Q?MDPQ256Ng7/zXz7jc43UjRXQ4c212UZAJQtRuc+LXnXCd4hwqNMQnlAmgd+S?=
 =?us-ascii?Q?VNpD92oAm9D1/Pe7SQXXmAf2q3a5daoQSOrxmC6d9Ft5jO98K3svBROD7VC+?=
 =?us-ascii?Q?SLu+VhuoE63vEybYtF5LMCvGPbY9WXR/+AYpIURYunR/zUNb1JVfQRMi+bQV?=
 =?us-ascii?Q?gkpaast4XsAmAYV2WsB6n42Oc4olLkXhz/KqThbTkXfDIXMjAtcDk4uU2oTH?=
 =?us-ascii?Q?PMGhS4LjwC3cr9HOgV+1Q15swKgHOuk8t1gii3N3BGZM5UDDgeLpFe38mGmj?=
 =?us-ascii?Q?byHyl2SF5/4ixmin1XOgYvPLaxdd/nYe0u3LKj9Kl6yVAdSNGbQvyPs4PKRR?=
 =?us-ascii?Q?AxhfJcvYNdoqdBqx+Wzr2NyUn8sUaQ5BQG3JMVLnK0ynARwP3L9xtYTQTmh3?=
 =?us-ascii?Q?x2AwNEQE/0xvuBrBlh+H4nb5ghj7EIow0t8eSUfEfS9bNdeZdCOGzTEXUexx?=
 =?us-ascii?Q?VV8KEwTOaDOAsEQWrfRjD98cD/mqRjOEr581hx4Du85NbIxDo3bC9D1dW6UW?=
 =?us-ascii?Q?f1HnjViQ3y6cw88v4wWwOTvBNjKU5e1CAi87NbVu6STVYh0wnzXKGqW6gibP?=
 =?us-ascii?Q?NubezQAg2/rhnEXr1Fr6I+wjyhVKbNRF379L0t7yGkpSv2qnyAJMONawqbyD?=
 =?us-ascii?Q?/U62yAancU6HGP8whKuqLEaj3AnAjNiNc2KC/qkW3Lm62Hsqr5DBXNDfDpBd?=
 =?us-ascii?Q?qQsbMP+kQWPXMMnUy9PUVYVyBlKfB0BYCaosFbuwlc9GbsmHj8nW5wnenoLf?=
 =?us-ascii?Q?koLTjSDyNSsRvCvQmWGOB2SO0cIaVN9BPA8wg7bSuOhjE2cmQVrEsgztXqw8?=
 =?us-ascii?Q?1oUtnF23NXMzAlk+PLXoJo505Lkz/+pgsz2/ABAJ9WabS+ddbfb3+PflYqje?=
 =?us-ascii?Q?kroGKcV7ei3iqasdV45F2+szP2HptudeOKa62YpHHWzL4G4wLrckTmqVAfiK?=
 =?us-ascii?Q?7kdYd0U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:40:30.0364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c13dc103-2239-4fe7-4d48-08dce2488686
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856

On Tue, Oct 01, 2024 at 10:48:15AM -0300, Jason Gunthorpe wrote:
> On Sun, Sep 29, 2024 at 03:19:42PM +0800, Yi Liu wrote:
> > > So their viommu HW concepts come along with a requirement that there
> > > be a fixed translation for the VM, which we model by attaching a S2
> > > HWPT to the VIOMMU object which get's linked into the IOMMU HW as
> > > the translation for the queue memory.
> > 
> > Is the mapping of the S2 be static? or it an be unmapped per userspace?
> 
> In principle it should be dynamic, but I think the vCMDQ stuff will
> struggle to do that

Yea. vCMDQ HW requires a setting of the physical address of the
base address to a queue in the VM's ram space. If the S2 mapping
changes (resulting a different queue location in the physical
memory), VMM should notify the kernel for a HW reconfiguration.

I wonder what all the user cases are, which can cause a shifting
of S2 mappings? VM migration? Any others?

Thanks
Nicolin

