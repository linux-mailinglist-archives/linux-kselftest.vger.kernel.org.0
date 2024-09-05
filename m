Return-Path: <linux-kselftest+bounces-17299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA01396E0DD
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661301F24E6E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736131A254E;
	Thu,  5 Sep 2024 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bYa98nvd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7019C579;
	Thu,  5 Sep 2024 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556289; cv=fail; b=il7is1b07uBd3QLFT/mtH+2TofGBHx3M10IGxCI4otmPVze24lKCW2gyRFVkppVM6KiScu5fjEAGcrgs3dkZ0bBZk33HimS0kOSZtvTbPKab2Oe2dh7nqjNSk+fqa+zLnsPLW/We/obyUrqfYI2c/kyce3jugq9CLfWP0p93nwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556289; c=relaxed/simple;
	bh=gZn4RSKs+SLe04lYvzkzPJ5/bDXDVRRr0wMEW55gfp4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WG4LM7C1L9mUiUnUawRzwdnw5c86nPatLn8OJP9luJX8soyB0z4ev0/M4hdbJ7Jy+li3rEzW/+pZzSNd2gyTE5pIW8wYsx5zBzIP+lYu8ZmcQLpfUGXD6yBvAtCIkeHAk64cNfSGDK+g6Iak0UgLDl1QclOKl9lriSYwL61yKnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bYa98nvd; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8YA0a5TNvNDQD2edXblCPKVx/lrdb2dxe/hwmNAPynIUHBDa0ZC7hrmxezx9+oi9GGXjj57HWcVuaEsbsID1WukhK2kOsWXpF43iNg8RJkPJaTV3718fPwdR7WoFuChkFnCNtPp0o7sTZ9TW3EU1nvwkeU7TA80F1N8Oai4+MEStVtiKwiHhBYC8WjwWM/BunsjsDljvg0BfT2GqXFuEjsL5z+GyJbW4ofKqz9PkKebjqTbHVI46RMlA70vEe9I6OYCCu1cCeFhaR1vqhFn4iR/Sv51Wtro6b+xmtPiB67aoxPhQHY/1dWxTX2ddHH6jryO9iTn2pkQMGcj1yTskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opKrAvgpAHXyRX1agPlagW3OOLFdYKMr+5zTk2iTeKw=;
 b=QyEG0yWKoPsxgDH0ri/irce75Dj7MYajZu27DOZG66KppoeRzz7D+ckCdRpBdhmsoJtA40Q0hpXG8tcQ+yc6Y3exL5g9nDVPXwcSHmgHKKN+PwK/BmMDnNgyzIgW0AcemTRa7t8GpoNEwfbnOvDcXbPD81iqW0ovqDIU5am2QvRv18hxrzICClQhfhs9gzcxMQmbspKQESO2bXa9YH92BoZ5kkI2htLgfM9WETYCHSItPM45fes1AMlmSKQYLQiFf8TdpUJhWMuZwNUSUctv7ysXhWxNcmngCAobhmYlvm0uQyRdxk2m8VDGHryE4cA+5cFzp+Zy6Mw/2eG4dnhtAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opKrAvgpAHXyRX1agPlagW3OOLFdYKMr+5zTk2iTeKw=;
 b=bYa98nvdpMvlKtK0bTmZsLK0L/J3pKTNCEar98hRrrOogKce7ymkDoVOn1DGI6XVJdnuKP5jydpOHLuL+yvfEpeSs4mcxyj95XvmGQDHAQxHyDDSWafQqAAXk6ycz5y6nNubDQr851F/+dglQNn0M+Cn0NwcURJyzZal9llaSGTbwps1nKvI5FPthW61NNNgsQMdsGzFkyd4noXqw/z09ZO5yjsLfiKuwbXA833md/mc6uc66Dlb75BvDbEDLB+JI0HSdR1bREmFXk6x4AtupI44VXPcjN5HJl2+UU5m2t5l7gzATaNWZyLFTv5QEE3DWNtepZ0bt2XOEfstXXKM0Q==
Received: from CY8PR02CA0012.namprd02.prod.outlook.com (2603:10b6:930:4d::22)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 17:11:23 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:4d:cafe::e1) by CY8PR02CA0012.outlook.office365.com
 (2603:10b6:930:4d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Thu, 5 Sep 2024 17:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 17:11:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 10:11:01 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 10:11:00 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Sep 2024 10:10:44 -0700
Date: Thu, 5 Sep 2024 10:10:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 02/19] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <ZtnmDvhVVKeE4Z/u@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
 <20240905155302.GM1358970@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240905155302.GM1358970@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 7466ef78-dfe6-483f-a53d-08dccdcdc3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rB22HN+0Dh0xNALzAnnGgyLcujf8ib/SyJiZnUJMv2+zr1LG3h58DDTwzKBm?=
 =?us-ascii?Q?JuK8e+KTv4QBsyUuId+mXvCF/PSOqTaMnm6TKJtWX4R3EGwQ9SvYRU/MU+Yj?=
 =?us-ascii?Q?D7fswUhlRWTQA2Qy6UscOoBCMJYoPJ7p3DZQVPbo7Jhb4+JdzgXTKUVQBKAY?=
 =?us-ascii?Q?gN0UfRB9G9F1XRnbfnGUjiYLqM9KmmR7lxgrQe3WN9KSE/WaL7jmCOrqpmdi?=
 =?us-ascii?Q?zBG53/UwNvn9k8Ifd0a6PMqPrZWuU37KnN/PT7YqT9yQLqPV5q/cg35T01Ce?=
 =?us-ascii?Q?HDRr9Ki/F5X8JQVR9EoNREQqqeaKU4b/HbboUnLN8OgU0Kr3k0ionoD0jNT8?=
 =?us-ascii?Q?m+TiAuzRo659+50gIGV2ZI2d+dhs4tQTT6k6bWcjm1LEmC3N9JvyJO1I4MVl?=
 =?us-ascii?Q?X86aVHYUIYmrGZKATRxyXleKHaBBP8Cq45bLGT4V6rMqIXwyuKXamkNrilAZ?=
 =?us-ascii?Q?dSSgfJZWCAfDDjmdXU+SkB5PtzUKME3GeJIgdSXWbuhPfphyFbexOU9YsNE0?=
 =?us-ascii?Q?JavLtYCEFacHB6FQM0TfGVXSno1AkXCv/guv5fn3RbyfkvhOA+0fB+lBhXEs?=
 =?us-ascii?Q?d5IOqhZNn5ClXItzlqmFGNHr/VkApunqirsG0KhulnTu22vzT2vNmFSPzWf7?=
 =?us-ascii?Q?+YgqJEqQLMfxRaXcDIPi4/NqCJhxvDH6xkgcI2rCuJX8tTXxOYN/AzLliGyx?=
 =?us-ascii?Q?fJn0KQDNj1mEvtdPn2obcHmE1zythLILzNXiQ7Y/pvOtvx+S2zyJv9Ye14ZO?=
 =?us-ascii?Q?yz9i+ksys+up6Vx5FnFtIvkEZ3noQq8ks5dFPg/jQkd11MpmhrcOhWWTPRdk?=
 =?us-ascii?Q?dl6TPqGuvcycawIXTagKuJJMojhlTuMjH0Gq5yPy+T8wAazAZ3YxHQtawOEE?=
 =?us-ascii?Q?R0YTP1RjQtBWs4Zp2tvYQjFQSM5HU+qEl1bx/9XV/mMSpxAJBiOCYTC4+aMq?=
 =?us-ascii?Q?RfsOwLfx0KWs/CncfuS5pJX03emNwm6oNl+lvcOU2YM4qPk8BZvCX4OjRjd7?=
 =?us-ascii?Q?HUKWMh3/1geGUXrRICLGR9HNSg7fXpsmNf83isRB1hARVdbcAY12lWnyjTkr?=
 =?us-ascii?Q?4107ELkO1ua5KqoqnUzl6N9MPu5fHgtYgbgCp9qe3RTj3rVdUjcgg+WiLcIe?=
 =?us-ascii?Q?c8oiHqcZFJ+oIMDNoBwiLx8LDCZMhurCd8qvhRmxEsJaDSshXGLnF28uePmH?=
 =?us-ascii?Q?fF8RxzW1UdiIuM2mg+2coIAorAo52AckwKY3LiqHB02/AGjeDCGFhboAiZgh?=
 =?us-ascii?Q?M11zI4mzitnUbmnrPPfqsNYa6aH+XQa8mRqygFob1AUn3/33tLi8115stA8H?=
 =?us-ascii?Q?wycRxdF9Bv5cp3KsvKkFjXtrYg92cipYJxoJwmjbE+AD33lT0X+2iV/MsxpV?=
 =?us-ascii?Q?vsU8fkzJHUPWUNuRAp4jgrwwLoPwGjwCKUZDWupot1qcHEK71pYVCQ9xYZ0o?=
 =?us-ascii?Q?AyHFRvB9Hgzk5FwvfUJYJdv+tC3t0l1i?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 17:11:21.6041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7466ef78-dfe6-483f-a53d-08dccdcdc3d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948

On Thu, Sep 05, 2024 at 12:53:02PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 27, 2024 at 09:59:39AM -0700, Nicolin Chen wrote:
> > +/**
> > + * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
> > + * @size: sizeof(struct iommu_viommu_alloc)
> > + * @flags: Must be 0
> > + * @type: Type of the virtual IOMMU. Must be defined in enum iommu_viommu_type
> > + * @dev_id: The device to allocate this virtual IOMMU for
> 
> @dev_id: The device's physical IOMMU will be used to back t he vIOMMU
> 
> > + * @hwpt_id: ID of a nesting parent HWPT to associate to
> 
> A nesting parent HWPT that will provide translation for an vIOMMU DMA
>
> > + * @out_viommu_id: Output virtual IOMMU ID for the allocated object
> > + *
> > + * Allocate a virtual IOMMU object that holds a (shared) nesting parent HWPT
> 
> Allocate a virtual IOMMU object that represents the underlying
> physical IOMMU's virtualization support. The vIOMMU object is a
> security isolated slice of the physical IOMMU HW that is unique to a
> specific VM. Operations global to the IOMMU are connected to the
> vIOMMU, such as:
>   - Security namespace for guest owned ID, eg guest controlled cache tags
>   - Virtualization of various platforms IDs like RIDs and others
>   - direct assigned invalidation queues
>   - direct assigned interrupts
>   - non-affiliated event reporting
>   - Delivery of paravirtualized invalidation

Ack.

Looks like you prefer using "vIOMMU" v.s. "VIOMMU"? I would go
through all the patches (QEMU including) to keep that aligned.

Thanks
Nicolin

