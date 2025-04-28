Return-Path: <linux-kselftest+bounces-31815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1DFA9FA21
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 22:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F4D3B2B86
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 20:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1283B2980DD;
	Mon, 28 Apr 2025 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nNrR5qyG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283FB2980AA;
	Mon, 28 Apr 2025 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745870567; cv=fail; b=LtE8DsgUhCBTxz2OLfgh8wHjwxvIFq+qH0QZe3NKMGjLOWlLDWxXF2sF2FhA1lTqSzpcb0t3XRFJtGMSy9lhIQR1adIK9W8XTTfOHVWR1YResUr9PpbOatse9fi9qYBP/pOAQ5+69X2cRcgSEQfow6OdH+a6Fg4ElhUkQWZNXTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745870567; c=relaxed/simple;
	bh=/9a9u+Y0unDYMiHhgJZtzMRWS/kPxPTNQQUPln2NXhI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3p+xQ60bi7XAzu3PMl9H5c0hJr5/fYxritCuSrNGDSkdF63gMSyohQBYfaMh6r+cSwDkzPhBNs3a3oY6U0XhPwL75itUDKKkK0S5aw0IiGunKWQbUPiEVPs4ZE8ZX0+z+V9DTjj1UoO9qDY3psUi8zryAYyFW9qyznRrBHdtg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nNrR5qyG; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJEoo4HqdaCiyGGb306ZcQYvp4TIAScNXENVdyhiZNTB2Zh78n98GSHKcLk0oaoIaA/9g5fDFF3hvQS8ZctEC0Btel80KidwQ6hRk35Ake3yZG40sVsZ5I4HnafrOzzs3nRTS0yl0VvCU20xkfDYOFgm+EMlGrFoe4Qa8CyJdG+yTEyUHzzb+sUBJOX0YVVNIOFChWp8+LJAxFLxkEGe0hh3pDvYfBkUGexQhe6WjQKxf3Qr///q3gA0SeGL8f/QuQmjWXDx5EKQYK5U8bxooKclngxSyq3RFA8B8p+bmixzFz4GvWX1SYqKox2h1PY5pH4wnqFJNj4mQDz6CWR5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+4jt2aHKM9OQOxWZhzm58mt7UbTuOvn+tJa+Fg30QU=;
 b=njc8YWbMRvB5MPk7+1qAdl1imxNnEoc3o7cyLtUi+CVVU/Csl6iWVUcqj8LNtoW8bFSlF0Oti+DJ08LwVdOPgOVYjl9nAY66FkSz/SQwW6Kgi2Q4DXl8MjAIhRfMijvu3boDtYowfRyMMJohtlp5ssnUXLj8EEn68vT+VHqlYsh/+TauAJd/slxJrdmEMOB6Fm+gN5TB8cXjUrL9q+FP6ZTpDIs0ypFAbRhXLN+8boBN5GLU6XsOhb5KNaPPghCAK34En+MqywrbWE6DTgzOE1j8UmpixZ+06guIOltdZ5tk19u9KO1duh4pMF3b+qJ9yRzEa+VIQAimn1iQBw5kqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+4jt2aHKM9OQOxWZhzm58mt7UbTuOvn+tJa+Fg30QU=;
 b=nNrR5qyGr9uG2SObRjBvb7HiE7wKyfpGGsd5dGRnHWb0hp1b2sP9dsROq6Aza3xL+D7CJH1Qr705hCGudI0DMbeDsKB/bHvYK4Io+69+k6tqzah5VtLc8KoDV9u6jmA9e9aHtvtSgygx8mp8qDpNZtsG7bpF7ZScd1dgv+3BUfn268vaPwotmz+zM0yGSo1MPMFAQppHVtEkFu4qVrC87qz2BUsUsXhfmVJ/SPjEK1ikSpNk6hR06lo24ViszDLe86pTMOyYYJgbEwYUliOB+n647V79EqqCKLDeCAxf+z6iyD2IFd78KmrTWxiogT8B/ca0KnjjPH85Vvm07/5Qlw==
Received: from CH0PR03CA0404.namprd03.prod.outlook.com (2603:10b6:610:11b::33)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 20:02:36 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::7e) by CH0PR03CA0404.outlook.office365.com
 (2603:10b6:610:11b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Mon,
 28 Apr 2025 20:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 20:02:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Apr
 2025 13:02:20 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 28 Apr
 2025 13:02:19 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Apr 2025 13:02:17 -0700
Date: Mon, 28 Apr 2025 13:02:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <praan@google.com>, <zhangzekun11@huawei.com>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <mochs@nvidia.com>, <alok.a.tiwari@oracle.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Message-ID: <aA/exylmYJhIhEVL@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
 <b0d01609-bdda-49a3-af0c-ca828a9c4cea@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b0d01609-bdda-49a3-af0c-ca828a9c4cea@amd.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: ab83bf12-0bbf-458d-2674-08dd868f9ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eygLkwFwoONFetAiaOlkvRv561Cx0cmGlBj9l1OsDspcpkRbC4mMXFWMzn4w?=
 =?us-ascii?Q?b6+FCX+JEOYra0lJP2UxF2NpJeVUhydzGt4MTy6w0JL9J5FDp+U6Ws6FqXG/?=
 =?us-ascii?Q?fz7gGu52nRDvE7DJl8RCvBg12zNAD2/64Aoz9qqVAffzEGIw1J3grBAWcfCa?=
 =?us-ascii?Q?bLB+5gXjHe9Qigvd4FiNEbvH/2KLX1+AbJ3t5xU/T4/B60ekheugIQjTvYSO?=
 =?us-ascii?Q?grAKJgcKmkHTrZME+Xm4XuI/KcARAL0MiD62E/crQVceYipCGcQO/vKZzZH+?=
 =?us-ascii?Q?oL1SmkOdOapoQaHVQ3CsGxpsNY42VvJWhjmty6Ti9bOi9eQEPOD17Rukl4XL?=
 =?us-ascii?Q?SR2gbW3T3lqR+MZOipDlWJLNLGsHLmL7jv/Lnrn7I747dKaMt59Vt5L/i9gB?=
 =?us-ascii?Q?3Kj8G0/kqv4NFsuwA5Xym2Sh4kkoBY1N5NGUvwY/JlhTcnCZvIqSzqR11gCA?=
 =?us-ascii?Q?/WQgUVYy/UdSVR2qKpKCv7OxjcXKtD9vg1vqKfvpxNdtiFz3oojifbcwcbvU?=
 =?us-ascii?Q?rICfG2YPUflbgQzjm63SnB5TV2XIWqGrLn8s7K9TfnO/pmKaJbGvhV4WByq1?=
 =?us-ascii?Q?e9xOQKkplFLXfIaRTSGsaBEoklBHjBeq5LvcUCHoi9TinHTTRh74GPlgbWd1?=
 =?us-ascii?Q?HWT1YQkBIM/NLyUDBhzUqh+5xh8CKAKrzj70nK8ZgYU3S6JsO3WZwkIj3ig8?=
 =?us-ascii?Q?sFPFCbsM4hw0Kkh0jO5bBiMdIesX3CQFks3LNY2NScqt1fnjQCB4PxXDZOEO?=
 =?us-ascii?Q?uTA6GPu+tz48rmqogxFSF4rkI0wfs4naIfoC4zqE2kL7tI8kElq5cs4eFtYv?=
 =?us-ascii?Q?fJyNAMnfgOc7BxJ+8K1hjEADKWLGKWEgWkPxc9F+M11Ec+PpZYPEtSwhP55t?=
 =?us-ascii?Q?hhnYeVFW2AL4arqZwp8E5QEbn0XlYJ5KtRLg5sph0Vz1yHngHr2RRKlQEchz?=
 =?us-ascii?Q?2OnYXVyezaw7CpESrdWvOGH/BboXDFrDfeVdxGYGrDp43OXqgULF5Lr7upy/?=
 =?us-ascii?Q?Hx03YBsurJz6x+w5BqExWTPB04hZJ3ZoFsik0uPbiUkvlMovL6T3C2XkkdTJ?=
 =?us-ascii?Q?q7WyupTNNhtF5CBsWQSHrMaYCunN2UBUR37U0IH0Y5IPiZ2y7xSPFSAgPG98?=
 =?us-ascii?Q?ap9OkMg32vdqoz+tSSOcrKBhUgp1aD5Lqoz1xASyDTi21pb0lesnFV0viWK7?=
 =?us-ascii?Q?vjYhG2IbexnDf5BgJYinyBEJbuyLyq9vrDO6W5IYDVCzpY9J8P1tc9DvTG2u?=
 =?us-ascii?Q?0iRozBy7gBw6CjK1/Q8yV5gE+YXAIzg2xOrs9RgnKlvWDqtGjpoU7X78iA3H?=
 =?us-ascii?Q?F8SdqOeK88qfjsnplCwGQSyk9WgHe7wAANX2YgRyXYsEvrc7oz4ukt7ed2JQ?=
 =?us-ascii?Q?MqKHncUAGoMwSXc06EhaeNIRJ6m5IGMsJc1vhpZ3BNJtQPzcTSesc6ZCtd6U?=
 =?us-ascii?Q?65HOJ1fuRql3jm4wIwM53rFpsbmNb8ju1lNXwtZ0UvSlRIDiD92Xxj7U8atA?=
 =?us-ascii?Q?XzqQj+IaGthosV5f0s7EkvUmU/7ZZ0z1Xqr/IStW7/npzDFYrG9+GN97Jw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 20:02:35.7139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab83bf12-0bbf-458d-2674-08dd868f9ec7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009

On Mon, Apr 28, 2025 at 05:42:27PM +0530, Vasant Hegde wrote:
> > +/**
> > + * struct iommu_vcmdq_alloc - ioctl(IOMMU_VCMDQ_ALLOC)
> > + * @size: sizeof(struct iommu_vcmdq_alloc)
> > + * @flags: Must be 0
> > + * @viommu_id: Virtual IOMMU ID to associate the virtual command queue with
> > + * @type: One of enum iommu_vcmdq_type
> > + * @index: The logical index to the virtual command queue per virtual IOMMU, for
> > + *         a multi-queue model
> > + * @out_vcmdq_id: The ID of the new virtual command queue
> > + * @addr: Base address of the queue memory in the guest physical address space
> 
> Sorry. I didn't get this part.
> 
> So here `addr` is command queue base address like
>  - NVIDIA's virtual command queue
>  - AMD vIOMMU's command buffer
> 
> .. and it will allocate vcmdq for each buffer type. Is that the correct
> understanding?

Yes. For AMD "vIOMMU", it needs a new type for iommufd vIOMMU:
	IOMMU_VIOMMU_TYPE_AMD_VIOMMU,

For AMD "vIOMMU" command buffer, it needs a new type too:
	IOMMU_VCMDQ_TYPE_AMD_VIOMMU, /* Kdoc it to be Command Buffer */

Then, use IOMMUFD_CMD_VIOMMU_ALLOC ioctl to allocate an vIOMMU
obj, and use IOMMUFD_CMD_VCMDQ_ALLOC ioctl(s) to allocate vCMDQ
objs.

> In case of AMD vIOMMU, buffer base address is programmed in different register
> (ex: MMIO Offset 0008h Command Buffer Base Address Register) and buffer
> enable/disable is done via different register (ex: MMIO Offset 0018h IOMMU
> Control Register). And we need to communicate both to hypervisor. Not sure this
> API can accommodate this as addr seems to be mandatory.

NVIDIA's CMDQV has all three of them too. What we do here is to
let VMM trap the buffer base address (in guest physical address
space) and forward it to kernel using this @addr. Then, kernel
will translate this @addr to host physical address space, and
program the physical address and size to the register.

> [1]
> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf

Thanks for the doc. So, AMD has:

Command Buffer Base Address Register [MMIO Offset 0008h]
"used to program the system physical base address and size of the
 command buffer. The command buffer occupies contiguous physical
 memory starting at the programmed base address, up to the
 programmed size."
Command Buffer Head Pointer Register [MMIO Offset 2000h]
Command Buffer Tail Pointer Register [MMIO Offset 2008h]

IIUIC, AMD should do the same: VMM traps VM's Command Buffer Base
Address register when the guest kernel allocates a command buffer
by programming the VM's Command Buffer Base Address register, to
capture the guest PA and size. Then, VMM allocates a vCMDQ object
(for this command buffer) forwarding its buffer address and size
via @addr and @length to the host kernel. Then, the kernel should
translate the guest PA to host PA to program the HW.

We can see that the Head/Tail registers are in a different MMIO
page (offset by two 4K pages), which is very like NVIDIA CMDQV
that allows VMM to mmap that MMIO page of the Head/Tail registers
for guest OS to directly control the HW (i.e. VMM doesn't trap
these two registers.

When guest OS wants to issue a new command, the guest kernel can
just fill the guest command buffer at the entry that the Head
register points to, and program the Tail register (backed by an
mmap'd MMIO page), then the HW will read the programmed physical
address from the entry (Head) till the entry (Tail) in the guest
command buffer.

> > @@ -170,3 +170,97 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
> >  	iommufd_put_object(ucmd->ictx, &viommu->obj);
> >  	return rc;
> >  }
> > +
> > +void iommufd_vcmdq_destroy(struct iommufd_object *obj)
> > +{
> 
> I didn't understood destroy flow in general. Can you please help me to understand:
> 
> VMM is expected to track all buffers and call this interface?  OR iommufd will
> take care of it? What happens if VM crashes ?

In a normal routine, VMM gets a vCMDQ object ID for each vCMDQ
object it allocated. So, it should track all the IDs and release
them when VM shuts down.

The iommufd core does track all the objects that belong to an
iommufd context (ictx), and automatically release them. But, it
can't resolve certain dependency on other FD, e.g. vEVENTQ and
FAULT QUEUE would return another FD that user space listens to
and must be closed properly to destroy the QUEUE object.

> > +	/* The underlying physical pages must be pinned in the IOAS */
> > +	rc = iopt_pin_pages(&viommu->hwpt->ioas->iopt, cmd->addr, cmd->length,
> > +			    pages, 0);
> 
> Why do we need this? is it not pinned already as part of vfio binding?

I think this could be clearer:
	/*
	 * The underlying physical pages must be pinned to prevent them from
	 * being unmapped (via IOMMUFD_CMD_IOAS_UNMAP) during the life cycle
	 * of the vCMDQ object.
	 */

Thanks
Nicolin

