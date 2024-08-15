Return-Path: <linux-kselftest+bounces-15461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7085D953DE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 01:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF351F264D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 23:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E7E14D6F9;
	Thu, 15 Aug 2024 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cCmGEDAm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063FB370;
	Thu, 15 Aug 2024 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723764258; cv=fail; b=tdwQ0CDmztcZvRuu8eKZXICysFI48dF7yfyTznA2+Fq1GcojHlMCX1HaSyrg1luqvK2I8TsXTjkYdK911KWGzutj33QSApZKjaddY0/xVZWjHX8JURQ3vBWI12MlyAjac3PtiulYnKfXVAvAreaxSa2unMbB9yVQ9/mBf+wcZws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723764258; c=relaxed/simple;
	bh=1jM6dEfkoPvBS38Y7JTiu/x0r56Cihk5Q9ATakZZ2o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oGA+kdMHqz1Qx5q77o8LWFZMBgDcSSwdS+v/zEVQ3QTAPURv60wMky89JE/fttA3oNSM54Pb9YJJWj3N0xEKvgdL+sN+hn1uWbRzfa0/aRvnZfpfExA3F+I/i313+qzf9Ui8fFSqnmV75/pmo7D3+kymFWLNf6dQb/r+8x2BLN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cCmGEDAm; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsT5k8Hoel760fAoZ6BxofNaepglJyX9VE8MzKGVESI1vcwMCvODTukQDK65s3PwhMHl2AQpt3bPmQ2mLW/oHxIAPeTRZuAjhJD7xc3SSyVqAywyK86YJDu0SdR7qgQINh0DjCgW+Cw7Fkaf17GLb1NbvTcNHYL9pr8qHvEtIVhzG0kVFQqysRXa6+qi/igX/NCAwNiwSJRe3lT/yg0PJs5xeAZCvqsfiP64h5VW6RcDSSOJ1Ja4/WzV28dkLSU28DRB4c3Ugrm9CEtX9Vsc+RlQyYmfh6HLg5W3n2TBeCbtWAn/S6hx7slBIHuXgXSTHR8qIgwIYbvnnk4u+YH7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roQmdI36FNu6sOH3bdUBZo0TEiXgerMdltnOCpxQZNE=;
 b=UPHo693o0RtbCeH1K6Qf62PRFx+voVaZ6l1MnZn5kgCWnYcniKKDF/APmuNLk7HZOVvxFbgaQtozMN0IRiKV7uytva3Q6ywb5bCG0ZrjZPPSm1z9GVMUFBW0VHskEk41o3ql4NDpKp/+aMbj+s/WvF2oH1yDnX8sLyNRcKKquzxxST11bnG4uBliWalV3x8og3ErAtX/eDWH7j2l+V74PRnUM/xh5V8X6D55zne32Ta0XMcrJIxVIVfs4gRWd0Mc3xFQrtb1FarelJ/K/i5FgtTqaYQOUWLoZeayB5LULNygGwAvSBC3u0CvZxAE58Mh5zXRGH1Q56AjIYAH4BRtsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roQmdI36FNu6sOH3bdUBZo0TEiXgerMdltnOCpxQZNE=;
 b=cCmGEDAmhOgrpOzymoGOe3pH4FUp/ofOCwDNZyspc7qNkAIJGcOvwX++9WePY2gkfUUpOWRgcKeMEWmZSWbpG+ecZ9dk7Fxp5vmX+IT8JbSJyUr+ngQZTLRloQmv+0yu88FK6SVdL4Tmc3qlJsBekfi1MAJ85HizQ7KVKNCYanegmhZoicY8MwnLjQhJ6A3OeaatE6ejwgYLadWo9lBhBcK4bTaxSxQ1LC0ry9RjS4tWwvyG0Z0v89G1wPDFpf1VYl54TSnTjFYbO1LH/1SqIIzaL0HkOumVsl+vN6OnYQAjNBU+biRUOOxW9idrrqi4LWJFOgsrPVGDhDGbyiibew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 23:24:07 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 23:24:07 +0000
Date: Thu, 15 Aug 2024 20:24:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 08/16] iommufd/viommu: Add IOMMU_VIOMMU_INVALIDATE
 ioctl
Message-ID: <20240815232405.GU2032816@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <59ad8c075bfa9de7098fd79a30b51d1f53d61a94.1723061378.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59ad8c075bfa9de7098fd79a30b51d1f53d61a94.1723061378.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::31) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a15ad3-c86d-4574-1ae7-08dcbd815c18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bxhExlw+kBBt3vlx+9jVu2uXw7wx2Sdw+cMvUUUO1ZZ2AaTNwbnLVG+tPbY6?=
 =?us-ascii?Q?FsSfSrKhIGilY6tO3zObVJTPCbfxvj2G4wfmMPNIFRYruQ4tBkZci4EUeSzo?=
 =?us-ascii?Q?RJfRMN0lqn/Ro6W96uNz+cP/ZOXf9LBwvucoKAI5vBwbMdnQkzOjzYuBtvPm?=
 =?us-ascii?Q?pU3ZXvEFJVhXAD6VhDS3yAvRNyVb54RowQaO9P2dg0pEbvsgJcnR8v5IZNOW?=
 =?us-ascii?Q?K7WsJjONmc2LP9P+zwKtIkq7bDtPkMP+KeZkqg4fbhmEX1DC+lzpM/X8bYfV?=
 =?us-ascii?Q?dqpqUzz8aA/NzJg2PiQhGqm09hvYSQSIXIlUAuz8KWWy/Bd6x9rhcvb6NFV0?=
 =?us-ascii?Q?HfvL21Rc8vCr1O+SCSBpBeFgwD8t0RHc8q9BjE31BGhejsmWfc8ewSiO6snT?=
 =?us-ascii?Q?Z0AMA2i+z9NcMQN641LhHE0RwA1Cc9FUFuF1TKrXe92c+Fz92sS2XDi8BfcG?=
 =?us-ascii?Q?u1cMfFKzkisW3hmW9OOqBoPbqfnFbozbEOLLnYc/vopR2GpDcr+b6c8aoKut?=
 =?us-ascii?Q?nhnMBhlOuIZcVx2e27FcgMamhe8QWc+XbG1QR+CCYiVka1BH+uGbm2Inkd75?=
 =?us-ascii?Q?TwQxEiYHa4ObDvRvB4rG/r2E3d9sLOt84AX+JDaq6kGFUyYnRN0UyQSTDCTU?=
 =?us-ascii?Q?UfEHUx4AjQKvbLRDYas9yBfgVn04Zgt8jKDW+2D7Aji/PBudF8oexDBzqMtT?=
 =?us-ascii?Q?RdALPb922YIrNTfEjrm1YgHrGJtoRRSomAsaMj5LZX1YuJAbzF17z5KeW8sZ?=
 =?us-ascii?Q?11Jnmk9iNrNAoX58yfaIH2ArNmHuJOlp2OMYd4Ycv3gXvU95ZUyR2Vq2rkFa?=
 =?us-ascii?Q?PVJC1hDDRgHDDWAMgKT2GO5ObIqxfRZ1yb4nhRAWluhmFgbRaOTlNd0PLp8a?=
 =?us-ascii?Q?OJrfdA4JHHro3x3DXfvARv/tCDs5VkG3nsEojvUM8LjQ90rcRBI8M3ABVOeZ?=
 =?us-ascii?Q?a91tdD9tMzN3gEGUwTeTr3M9UVcNFLg1tDmIoCSgPh7KIhlvE5fyzDZJzckt?=
 =?us-ascii?Q?1P4WO9mMqNTbxB3zwgSCTKWGYQGwsW0p7W5bRYDHZkSyfJe2Zv+UONFwbMc0?=
 =?us-ascii?Q?TicrGlDstt7rJtd0Tis5OrAFlVgSo0G/ed/L3qZeP0snFxwhbFrl8zvxcwjt?=
 =?us-ascii?Q?VJgM2DYPUDV6atakqfg0jmDVM3qv+T4XCG5rhPWPDrt3IXxlOIBF10pbHdjk?=
 =?us-ascii?Q?sUQ2W/DiMZdP/5JraTOQg4OQMVFELtMlNA70AsotERG7ltXB2x7uze1JpES+?=
 =?us-ascii?Q?1+l2AstgKHndshIHh8Eod6cNUoT0IRut7vzCKRMMxtyHR1x5xhUZ4Fev2n1Z?=
 =?us-ascii?Q?zTpDZfe9yXg3xHjBn/0bsEYuERGfvpUdgPAXd32mrYJujg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pq/wW7gXRllnBobUrRr3Ehvpav0YnF8IAHojBHRv+UgrnSYiHUBWzd398No5?=
 =?us-ascii?Q?TZsXErlU/kXzm7h/IpbDyE/2wix5kxxX2sUsdNaWkwxNkoaDoPPuuu+aDB6R?=
 =?us-ascii?Q?KMPxPJN73KfwPx0HpegWanj4V5V6/cSfe/GjR1vf17VmuY+whbBkPVLb5BBB?=
 =?us-ascii?Q?nubBsD0U6PcpQFi33POeTy6EittX5jgvr0O8Utepy9djLA6eYGJImD0vYzSh?=
 =?us-ascii?Q?M+2t58Q4MVAkXi4Tc7Qer7madsMZy6S/qzSqIBMVdxAjIJJhBs58btV3cI8d?=
 =?us-ascii?Q?q+bybPUG/meiKR+nDMwY/wfu3a5tUDVFaPVlmDBZjtbDFUg7u6hMgxK5wo2r?=
 =?us-ascii?Q?u+a2bb3B0Vo9wrus0NJHHKhiwbltRpCpNPmsLk2ftxOz/DTMX689x0i8oZ3D?=
 =?us-ascii?Q?b+2iOIxo61UmGnQIdlgQS9IwMMTWTDlMdZSgoHDDyYKyHT5Miu96ddIbo5I2?=
 =?us-ascii?Q?YXz8XgIlARASRvgFoNmqFGnH5nHP4AGKd+of3b/LcCsnPL7Y18G+mDjBx7hR?=
 =?us-ascii?Q?UYcOhCdoayMdsGwPL/KaAbhX3wkjTxobc5hPDJ1Q0w6ayXrcnBxbm21m+baA?=
 =?us-ascii?Q?rdqLI2o+8m1mOBd99vLlhonCYE/X7sPCx2i3a6Nq04uI5TgUJqabbg8GZtMf?=
 =?us-ascii?Q?2ol8CgSdm/8pYjZ0vS765YcjySx9APmkHOSBebwKmli7gkiBO1aEePUgTvVx?=
 =?us-ascii?Q?ck11A2f8jZ8SepzZlw5M1GQamCUkUvFIVD3n27AYlNX+4iPcsy3+lVORbFG3?=
 =?us-ascii?Q?HAq1+t7baFDPCO46mrbSvJtijHsOOkQliu3rx/sMV/6KkwxfkWfaLBh/+Pb+?=
 =?us-ascii?Q?vukd3hnRu1WQmuSkepVX3C2L+x6GR7q/dczqpeUwlGvEIbzZT6yEOEcJ8d2X?=
 =?us-ascii?Q?em0Ux0ZVGziRV/rtiXtYK3J1D6dElAMX6yQRQ7B3kzqY5ocid1+T2H+WCBa4?=
 =?us-ascii?Q?sp8KnT6Ap4hwgg4A1mGpAmPEuXcflFyBGxVMrHNCK8NBnrGB1zYYg4r10bGs?=
 =?us-ascii?Q?ZaYM6wSENCkQD1wIwu+Tr6MJPIlo2fub19NA+kH/+A3Ua61CxLUFPC4xInp7?=
 =?us-ascii?Q?crXu3eqyTqCx7N9NGyvNWJUvWg2LYPUcecVqSvd+XdUoTPAK+hXCPhkj6WJb?=
 =?us-ascii?Q?8ox2Ykq6IEnhaG0b3x3J+Nqa9EMHOOesLFct80SkvmsaZHoJyr/f1MKHWdx4?=
 =?us-ascii?Q?D8gXbxF81V3C047LnRv0JxNqPIXDc3FsmdVSxEptePTZf+Gt1ps4kn7kZkVR?=
 =?us-ascii?Q?5DZx5rUj/Qyd4Lvl2dMCMJvZmJzMkCCIGuM9pZzh1gz4ZgkaX+1xZZPF5IdU?=
 =?us-ascii?Q?Q1zeUdJi3fX9gy5i/WQNc9wvL5eguyrCdfO7K36TKKk3111JlaMqtkLwnsns?=
 =?us-ascii?Q?8IiMtg1++S1DcwkXYlji685irUsHYX5KG+uTVRqs2HnSp53mNKghpve39Unu?=
 =?us-ascii?Q?Fqo/yxq6HJxS3STo4hLeAl9I7bLwMco+wNjQEiG9VooVCa6K+PJkSJwRfHSp?=
 =?us-ascii?Q?XeyCddGg0gfabeqGon+9BX462sygN2kSP1p4veCytpObAcRDuVEd0fHsYFA6?=
 =?us-ascii?Q?UqRqUfGWspgLz3TK+NQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a15ad3-c86d-4574-1ae7-08dcbd815c18
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 23:24:07.4437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0LN+tf16eFx+uTQnAQ/nKAae/irFnkDaT2beEk/pWHliwaoofYGRZ1LPnjRsO8p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009

On Wed, Aug 07, 2024 at 01:10:49PM -0700, Nicolin Chen wrote:
> @@ -946,4 +947,40 @@ struct iommu_viommu_unset_vdev_id {
>  	__aligned_u64 vdev_id;
>  };
>  #define IOMMU_VIOMMU_UNSET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID)
> +
> +/**
> + * enum iommu_viommu_invalidate_data_type - VIOMMU Cache Invalidate Data Type
> + * @IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3: Invalidation data for ARM SMMUv3
> + */
> +enum iommu_viommu_invalidate_data_type {
> +	IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
> +};

=1 here I think. Lets try to avoid 0 for the types..

And this shouldn't be in this patch

But also we can probably just use reuse enum iommu_hwpt_invalidate_data_type
here?

> +struct iommu_viommu_invalidate {
> +	__u32 size;
> +	__u32 viommu_id;
> +	__aligned_u64 data_uptr;
> +	__u32 data_type;
> +	__u32 entry_len;
> +	__u32 entry_num;
> +	__u32 __reserved;
> +};
> +#define IOMMU_VIOMMU_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_INVALIDATE)

I wonder if we should use IOMMU_HWPT_INVALIDATE? the hwpt_id can tell
which mode it is in. The ioctl becomes badly named but these have
identical arguments.

Jason

