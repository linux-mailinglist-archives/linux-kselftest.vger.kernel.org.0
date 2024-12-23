Return-Path: <linux-kselftest+bounces-23740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB56C9FB4AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 20:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573F41652CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 19:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCE11B87FC;
	Mon, 23 Dec 2024 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JZVlryKx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C242E161328;
	Mon, 23 Dec 2024 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734982188; cv=fail; b=VS12nzJqlK09sCdSErMPAraUBIIpvnDVSpOy4Cr0TtQ2vLbjmmw+byqbabsT0hhodM7iecQbcw6TYvb4qDp88kwgKgnDuQZDl6zQLsb66XojaEU2JAB07XeREUZAbQABsByulwHxK4a1YDiI4lThnhqs+FUplUpYiJqhOqFGzGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734982188; c=relaxed/simple;
	bh=nL64+LXl6gs00dDndPE2TpPww8Y4zNii/J9B0bwnrjc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA6n8Wshf1tHz1FOtRKZdkfAvxhCskGZ6ZbN8V16trBF69byXO6CrPm43n1XCMvZDvSPaETsGnvJ15BhEUsAa/HjAOj4O/D1cCjRxGCwbqhMmNkkWWBXgR0zk8tplibXaCIE2DUuYb8pXL+6WMEdS4rO/D7Otub0OcyC6vifGbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JZVlryKx; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIXFhmjuty85WgskRnqbZKTIZMoGuYWvHM+2c9iTM0MqnDOSX18nrBNu+qiaA/zDwQICgrXkCqe8DdatrVj465IxZD5vZIg8R8atPKd+7oDiaNdTuHHH6alfb0/XfIEkFRGEgfYISKfbG+7UgnTPsQLBwcIxySa9m08/slmTGkLuuGUpMddA0QTETckHp+uDyJ9JEVwrMlC8D5ig2Np/CUJ87oYz8VXQHhgWcyWT0UKcKrAmmktjVFDNLYVWCCYOopWf8hMWzaNgjhTejmYMhd8VmP75Y8Y+fbd78jBHDkOpeqfj5liSiN7JJXJFUWbWPokmwFb+hvfghaLTl7OdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qQP0GIfJkTKzYcHu5Vh46avbdd6+BW3oWoh8j+zoKc=;
 b=j28XGuyoG1kHTGP9vNIMP6DtUK6PWkhZ0bPKOhA+sN+pbxrCaFZIQPfVK3UNkIsPAsAYSLzz8AenvNgS935b1vHcFV98WctJMeJbX+VFkKNsTjTzeCTLk21g4nWuMpZn95I99j4AMQKZLmKLjXrDz2zkm9zFFQyiRpn5NkLjc5JizvxcgJpOEKFtpjXekuVAyD29NPXpcU/cp40DSSCWtFidcuXohfEAPVw4G2280chvJafv5sop+Kp5BECoYyDtx9cIcgatZvrICobjJMAX9TmXZrcvC8MJD3htDi9MZqaFzIU/oBpbIQPtRSBYK1suexBZ1j0rEfSvDZ1tmiyHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qQP0GIfJkTKzYcHu5Vh46avbdd6+BW3oWoh8j+zoKc=;
 b=JZVlryKxceW81bI7MFUgb8n2Ia6zeEPd2vOSB8mkwA9NJtbxqpC7wME2RVXYG/PsR8t/WiZw8ZR4TPNWI6rHR5Iy5LmKOdUIfygs+3Z8f+Ub4OlRQkoLT4w9h5eJveYao3Rq0J570hgGbcaP1IZYw/p46IrpfJp7gRi17e3tu9juzD6qXiXO3C7CwNlVYqqrBaF+KXuTEjUKL6oZXVgoXjE42p3Aj48qHskTywxmYHZHTB13Tx0pgLtcI1CR4iD5hu16Canp4b56KEXNBsyJbWZxRpWJnCApFEoRYXveCLSBj0B5pdX9qgklffodQf2RC3it+Rlo+L8CTjgNF01QuA==
Received: from BN9PR03CA0520.namprd03.prod.outlook.com (2603:10b6:408:131::15)
 by CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Mon, 23 Dec
 2024 19:29:39 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::4e) by BN9PR03CA0520.outlook.office365.com
 (2603:10b6:408:131::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.20 via Frontend Transport; Mon,
 23 Dec 2024 19:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.12 via Frontend Transport; Mon, 23 Dec 2024 19:29:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Dec
 2024 11:29:20 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Dec
 2024 11:29:19 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 23 Dec 2024 11:29:17 -0800
Date: Mon, 23 Dec 2024 11:29:15 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v3 07/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id
 helper
Message-ID: <Z2m6CxUQgORFfoaG@Asurada-Nvidia>
References: <cover.1734477608.git.nicolinc@nvidia.com>
 <21d7e63b97d81d0acf9127418a67efe386787261.1734477608.git.nicolinc@nvidia.com>
 <56c65e50-5890-42af-85b7-85f8a1bf5cf5@linux.intel.com>
 <Z2OpylDlhLXoo3dt@Asurada-Nvidia>
 <74bc9dbe-3420-4f0c-9e32-db49327a723d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <74bc9dbe-3420-4f0c-9e32-db49327a723d@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|CYYPR12MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: a2dcdfb2-95a6-4212-ebc5-08dd23882406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fW945A6mMtATdhin2xqIYXp/w9AXn/uXoHZXzQp9jJdkST85uSMaLEMvTalx?=
 =?us-ascii?Q?wsh4aSpDCO2/+X/sT4mdM7f0tZ+ce3VOkdWRVrh5WoQs1cRvYcHbw3Eg9wuO?=
 =?us-ascii?Q?qumQ/wPuS8dsVOBN87am5AVgNg3OkIrUtDCqj/8ar2Dk1v25mSHDUPD93Tw7?=
 =?us-ascii?Q?VDbm/Hk9gdmfwh65NF2CufFUzW96j5KYTrn/M8+qN8oWngjiMCpdDW1xxWZA?=
 =?us-ascii?Q?8ZCgqw99gNou6LzgS16VvSkwOytS1S3x4a62DJEl2rudw0NjDL3V9mgS0KWI?=
 =?us-ascii?Q?o2d7b/twKlpWHkJFUF9De5HF2JaUa6nRRcLutcGEvchGrrU8jahq/qu9tPGR?=
 =?us-ascii?Q?Uqsrn2v3dtCAaQ5Iaoi9K/8mpB53mOfXKHoGDZiFx92VMXItOXI+1jRJ8/Cd?=
 =?us-ascii?Q?RMRI/rnBm5NT6bR2qm5zCRwrxKq1zdEJCMXeREbO7aAS/7xImXV3PN9Iu7G4?=
 =?us-ascii?Q?rEZvspazXsl8SIrkmsWeGvI++aI7JIWs5f+5yNZG9uyyK3j6k/HmBoZt/ISz?=
 =?us-ascii?Q?MpQn5F5G4OywRMTOh/cWB7GlcUrByzNsJDCGIzUarBstO4P+9W8HtAivCPGf?=
 =?us-ascii?Q?9DE13rw1pZWrNWn6iq7U/oYkOpKwYcBlHLQOAxIBoCxmYQT0DHUU/uV5rzM7?=
 =?us-ascii?Q?scZ5cb+7LltHD2aPvD/gdAYBesUvg6tYn9SxBsubA78Wv7U5Sl3LP4iU3AEY?=
 =?us-ascii?Q?S0loBzEYKH0Ta6lw2SRhtfLGwVD5scTfphGbdYsBWRJYVmAAS3z4u3GXsiJv?=
 =?us-ascii?Q?ub2zR3uG5sb+lc2Bh59+RmfNdxbc3o4ujKDfItjgzpoYAPwAQUI10ukIkziV?=
 =?us-ascii?Q?ycU2uD0qVpu65YLJnSM1aHNA9jwguZQMLkiKvOhvyyajl/yRBLPuS0MBNDev?=
 =?us-ascii?Q?jvPj29xSmFqQt+bWeClek5mAFJMDu+yTmRpKo2JS+9T7OV3/e6pj1TLhCx+H?=
 =?us-ascii?Q?gD+zbIFmMkc1sIEXCyf2Hs2o6WoRa1SBNP1JQQqCoQNTbmMhQKfwMTQC5tcc?=
 =?us-ascii?Q?tJy77yHsRXpP5jvV7LM/gR+mq8wuBYU7F8dM3Y8h9cIbNbuIV9/ecMn2QAZR?=
 =?us-ascii?Q?JEPUHS74Fg5EW55Sm0UGcbPNPqVepQn4B/fk2h5lPfvjb/cpMmgFVZ6mkuwL?=
 =?us-ascii?Q?AiB5+w2vLBfWvNhzsJzt9dmOgT+RFQd10dtsJ+jQWO/pnwV7AMqGYa3zNGHs?=
 =?us-ascii?Q?IcTKHFesaHHcaFo/JS5a+C3XiwNq9JflF+fc1OUGBQEQaV5gWm/o6W0XRbUO?=
 =?us-ascii?Q?647PmgK1xguR09g1XiaBginqnXoyLcQGLs8acW5Do6VMLGxW7TVbVHlhpdh0?=
 =?us-ascii?Q?ztDKabcWcfZsr/p/DPFSI3ZI16r551eTgMlTLwkNcJKUthw2gvxijI7qu9Yn?=
 =?us-ascii?Q?vs6NCzEQYHBNevPhoM8qbr91SaCUwLmrJb5py+Xy8tIbISNsnBWU6oCxKB19?=
 =?us-ascii?Q?9dx9nMUA79QSrjbJrZt70wR52GRBn+oGmUGVS3YUbphGSjORQycOZiJVTmqC?=
 =?us-ascii?Q?26bCqrMRStgzBwY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 19:29:38.1404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dcdfb2-95a6-4212-ebc5-08dd23882406
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963

On Mon, Dec 23, 2024 at 10:28:32AM +0800, Baolu Lu wrote:
> On 12/19/24 13:06, Nicolin Chen wrote:
> > On Thu, Dec 19, 2024 at 10:05:53AM +0800, Baolu Lu wrote:
> > > On 12/18/24 13:00, Nicolin Chen wrote:
> > > > This is a reverse search v.s. iommufd_viommu_find_dev, as drivers may want
> > > > to convert a struct device pointer (physical) to its virtual device ID for
> > > > an event injection to the user space VM.
> > > > 
> > > > Again, this avoids exposing more core structures to the drivers, than the
> > > > iommufd_viommu alone.
> > > > 
> > > > Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> > > > ---
> > > >    include/linux/iommufd.h        |  8 ++++++++
> > > >    drivers/iommu/iommufd/driver.c | 20 ++++++++++++++++++++
> > > >    2 files changed, 28 insertions(+)
> > > > 
> > > > diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> > > > index b082676c9e43..ac1f1897d290 100644
> > > > --- a/include/linux/iommufd.h
> > > > +++ b/include/linux/iommufd.h
> > > > @@ -190,6 +190,8 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
> > > >    					     enum iommufd_object_type type);
> > > >    struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
> > > >    				       unsigned long vdev_id);
> > > > +unsigned long iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
> > > > +					 struct device *dev);
> > > Hi Nicolin,
> > > 
> > > This series overall looks good to me. But I have a question that might
> > > be irrelevant to this series itself.
> > > 
> > > The iommufd provides both IOMMUFD_OBJ_DEVICE and IOMMUFD_OBJ_VDEVICE
> > > objects. What is the essential difference between these two from
> > > userspace's perspective?
> > A quick answer is an IOMMUFD_OBJ_DEVICE being a host physical
> > device and an IOMMUFD_OBJ_VDEVICE being an IOMMUFD_OBJ_DEVICE
> > related to IOMMUFD_OBJ_VIOMMU. Two of them can be seen in two
> > different layers. May refer to this graph:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/
> > Documentation/userspace-api/iommufd.rst?h=v6.13-rc3#n150
> > 
> > > And, which object ID should the IOMMU device
> > > driver provide when reporting other events in the future?
> > > 
> > > Currently, the IOMMUFD uAPI reports IOMMUFD_OBJ_DEVICE in the page
> > > fault message, and IOMMUFD_OBJ_VDEVICE (if I understand it correctly) in
> > > the vIRQ message. It will be more future-proof if this could be defined
> > > clearly.
> > A vIRQ is actually reported per-vIOMMU in this design. Although
> > in the this series the SMMU driver seems to report a per-device
> > vIRQ, it internally converts the vDEVICE to a virtual device ID
> > and packs the virtual device ID into a per-vIOMMU event:
> > 
> > +/**
> > + * struct iommu_virq_arm_smmuv3 - ARM SMMUv3 Virtual IRQ
> > + *                                (IOMMU_VIRQ_TYPE_ARM_SMMUV3)
> > + * @evt: 256-bit ARM SMMUv3 Event record, little-endian.
> > + *       (Refer to "7.3 Event records" in SMMUv3 HW Spec)
> > + *
> > + * StreamID field reports a virtual device ID. To receive a virtual IRQ for a
> > + * device, a vDEVICE must be allocated via IOMMU_VDEVICE_ALLOC.
> > + */
> > +struct iommu_virq_arm_smmuv3 {
> > +	__aligned_le64 evt[4];
> >   };
> 
> Thanks for the explanation. Maybe I am a bit over-considering here.
> 
> Initially, my understanding is to report a virtual device ID when the
> object originates from a vIOMMU, and an iommufd device ID otherwise.
> 
> However, considering page fault scenarios, which are self-contained but
> linked to a hardware page table (hwpt), introduces ambiguity. Hwpt can
> be created with or without a vIOMMU. This raises the question: should
> the page fault message always report the iommufd device ID, or should
> the reporting depend on whether the hwpt was created from a vIOMMU?

As you mentioned, HWPT itself can report IO page faults regardless
of vIOMMU-based or not, i.e. it should just work fine with a HWPT-
based model or a vIOMMU-based model.

On the other hand, I think vIRQ can be seen as just a supplementary
pathway to report non-HWPT faults, e.g. in arm-smmu-v3's interrupt
handler, the logic is:
    if (pri_is_supported && fault_is_iopgfault)
        report via hwpt->fault;
    else if (virq_is_registered && fault_is_virq)
        report via virq;
    else
        print an unhandled irq;

Thanks
Nicolin

