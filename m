Return-Path: <linux-kselftest+bounces-17276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD9196DEEA
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876C11F23323
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABC71991AE;
	Thu,  5 Sep 2024 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tux3kWSQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84E684D3E;
	Thu,  5 Sep 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551590; cv=fail; b=G+aTU4jkvayh919/ucS/Itu7PePWg1i0fGC3n+0n76XcthM4GM3iRRHmR8haiwJKcgueqyz+lhJfynHL0RPNmCb3XMAf/oSEizU5HvUFl+ixfQN3TUOQfRDMaM2vVYn+a/r+sf4or7T8cS7RTpwPlx39i9H1VwBEe4PN7Xoi37E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551590; c=relaxed/simple;
	bh=x4CS4h0eJhPPr2UxQlM3hEsW3jZHXX+oaoXuZ6A+i/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qk95Eql2Ra4nnCjX3nf+G0mq+IRktPe9WT/JCIaXLWr9PyWUqDvbT5kjBNwRMr98kIgfdnA8HwMKuHSfadCTgGyPHeO5jaRQ9qSLbegUzm097c7W8iRpVZ7GxoRXC0qQyVxf7CJl5mfeUH5moQJ5RJxC+kauHt3kuXvTj0a3JeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tux3kWSQ; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pg6KUx4swXVmI33r2ZhuCWWABQWy/oXs11GTJ1fmm/n3+do/4HVQYPBXO8+NuKXpZ6P9k1SgJR9rgyT/cbD9nfa72XihiNinrPidksWv+xpqDvyE+BzTHRbAomI59ncmbjzKW6MJy94ZfarCwRcTxFAiG7WuzMBuOcUDB1giGlBI/x02vqZX1Yhz0x/bngeW9OSUOwmAB+xLC1JTKTM0XxUSCsF+3QuMDwraTdVXDOrAlaURM6plb4MDm/TXblp1jx7+cJrer9rcvG3HyKtwbcaDcSDe0hnoVZbPtd9sKk16Io8nPqhJBFSiJG1RNSDj1nxkqREGEuEa0Z5eHMKHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUNOWT7Qo26UoquIyc+XwPMmzmeIsBNOMZKLU+jwVz0=;
 b=TcziaqdpQ8C/LOkCNCsP4y7QCO1wkyC9JDIH2r6+tohoUhePcnv6vTImqw9/gxLgOFGZ5NP5jUEkzQzYlrhyyi8pnGRAN+/0apE16mVcsvPBgu5IFCkbfRO7B/4qiL52Eq0c0B07h3RaLHSvgTjv6ZTMQbQb707dL8uUF+0EupZDPwJviFw/VbGUlljrkxk6uZbfT3T2ucdZqnXVvdiuM9hRQ6AwYYx/stuEmcQId/lSSs07mGbMdICWrflLppXxpLiVh/q9K6+TM3NdbvcXz8QuuEXRXl3XikuMgi4qVZPWO8iaA3iEp9970ztdIFk2pUuvklChezdDhEpLur0l/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUNOWT7Qo26UoquIyc+XwPMmzmeIsBNOMZKLU+jwVz0=;
 b=Tux3kWSQ3eM1aa8JN3WsvjunVWyWFn4gs5FVliQ4muPFABln97/CALqxmk8LjL+w/2s5dn/QFauNLxy0q8TnmDbmSAfHk+nF7wpNnfCq2icOlOz82mhbKgYWT4JC9/CeIZlUEIukv7qhjCA3RRVy6ye8Rbwd/z1A0Y6jGrDTnKpTR6f1KHw240i+Vun8OZxXskhcCtLfJ2Ie1csp0jeWuUOqbUdxAJNnJ/pBvU0nCQthcJJeTCd/ha85rKUupLqka6chGXnwbIyeGdUIvHTvdcB6ekm/ykScPpH4d+aA2rckhAT8Pc5WWLIEWkjwKQrSrzdMvIhBukxsal64GN2vLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 5 Sep
 2024 15:53:04 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:53:03 +0000
Date: Thu, 5 Sep 2024 12:53:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 02/19] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <20240905155302.GM1358970@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR14CA0005.namprd14.prod.outlook.com
 (2603:10b6:208:23e::10) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c931edf-033a-4c1d-a3c9-08dccdc2d361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MfHGusVUDTeVK6PV/35YNsTMk/KYmSi6w/I7NZBA0mZwv54rk1DVfT34ErGb?=
 =?us-ascii?Q?FVWosiqqGl7RnCjTACuaHyPraNjDhTFyQRFmnZi15gnF/6M/tTXq7dKchG1P?=
 =?us-ascii?Q?nxD2n/FnZnQQq4U82mbY164vF8BxuQFRQrCzwQwZq5eplUNPD95PbaeAalK9?=
 =?us-ascii?Q?Mn1P/3xKncnFtkRaXa8apn9yxgzCUTl/6RsHwYkLcJZ2Xtm/cQKIMYT88+kz?=
 =?us-ascii?Q?0SXLo0kGUX3Uuvx9Ker4rCVuBdBnk1sorqcFB8KXrsC2rEjtoMZtUg8BiQSZ?=
 =?us-ascii?Q?7WDYH6GmhziI69SnI+qR1/OLp2t1I+RLH2qMoHMdegbGv2yKhOihiKmhquMU?=
 =?us-ascii?Q?+uoBZOJLfL0+keH/od8WFCTuvfIzQ8Dbb5bTp3jSiJuT2cMimVVSHSh+qBI8?=
 =?us-ascii?Q?ueiG1dkLqjE9pu58yNXsOiq/ImwYHvKX4xkNByAM0lwxQv2yR8RoSMkUWLGm?=
 =?us-ascii?Q?4nZAwzPfSLPCN86+ZwclaT+PeZvpopJXe/6WlkuJAU5JwFpnBtdTnW6bSxEG?=
 =?us-ascii?Q?n/3SVa1Nc8rFJNIlsAL13W9pEbZmd3wsyZsbPfuDTpWBR4DnWIRTl48ytR+B?=
 =?us-ascii?Q?lRKhTFB2Sb5Q9w0AuoocauEo9srEvsLGAnrmCnpFPPgu9FmPqZ5Li/3i2twN?=
 =?us-ascii?Q?SLaV/6XJqXRPeODRt1o5L3zV2nUEGkrUqu4+e5oXnavDHfFEFi0dj4NvOySz?=
 =?us-ascii?Q?crGdD3Nc1SNASkz2dm694wyHao/1wc3J0p2E+vGqw8LIpInNDqbK/Q8tNPtp?=
 =?us-ascii?Q?LYjE1JO7j2CmJYA7NgJhQYmMpGiqAJQ4t434ZXCp2m57fNq8KdqGJpT7Rvnw?=
 =?us-ascii?Q?xJX9fVdVnccd1mTVS4gr47dEWECbLqI/3LUwTTuXZHcc5tJXVc0jYM39x5mV?=
 =?us-ascii?Q?2KLMa6LWvQY+rX+y/KVnmbQcS+qDSCexV6azNKDhT9eyYTuwJ49sKAaI9NQu?=
 =?us-ascii?Q?cnB5X4Z95HDr9k0LmZi4K1phuw2MKp3toWWgqdRZP1ilxQUwy2y+kRuOxKV7?=
 =?us-ascii?Q?17CnqRM8Ja0jV62J198ZlkZiV/+HX5zA2ApxePraF5vq5ocBZdaHLgnpRA+C?=
 =?us-ascii?Q?qOJEFxNygwC8r7hVawVjT9Hqv4J6n/sE+mfoR4/Sb8n4Unp5juRCbchkZY90?=
 =?us-ascii?Q?s0q/dgFItkKqInTAEIsP1GNDFWQWdOgvIYgMd+4et4yzOkWgjAdkuVR4AQD1?=
 =?us-ascii?Q?Lt2q0MmsM45/K6Er8mFK27lcd+xzy1xfSjyrXiKFcyyAxIb324Gl+/JQPK+s?=
 =?us-ascii?Q?UjKEfl8qqN2aUmAFHE8vJAXAebay+U9qJfoZOaurpwIYpO35fAavZ107Y8Zl?=
 =?us-ascii?Q?iBg/rW3Fn7UWutS7fR4bANHwR9yQhHQDSZTblzM9hqbt0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?icr+AtOFwUBaZB0yMe2KdJ3rg04zgL6aeUw/jyh+tT4lHwROJ/BDFRaasSWO?=
 =?us-ascii?Q?VxQuRWLgWlFpRkY/H/ho0Lp13l9/0yr+hiFVrFDVjRdVSFshgFvL9ERMWywn?=
 =?us-ascii?Q?p2dvMVzf+YkcxlegVzg9nOceC1hx/Bi2HSxR2NeXrRByV7gkRD6ki9ad/+je?=
 =?us-ascii?Q?aibN748/seZXy5D+E/OXZ6IQHoojbOBlo9dZSgC4+RPXzYqZX+jI98SgBFep?=
 =?us-ascii?Q?1DQcqzlrsiiqRZjBMwEnK2kDfW//BQU79c6m7sXnbi2UsbX3Jko/dTWFZ9zR?=
 =?us-ascii?Q?5ov7SDy0fH6Jow8lcrn3rGeVckzESlHcb2bPGFWrcF6rc8Zw3rqyGMqZJ7NU?=
 =?us-ascii?Q?xIgzR6Zrcw8WlC1GmYzU1pVNANIOjKPGFpVFhlwem6yPOXSyL/+BGAPEyWD3?=
 =?us-ascii?Q?aj53qAEnH4go8cyMZ87LxHX0cJ9MNYgM4AOMuIs3yj1YLW3m84upexKuc4U5?=
 =?us-ascii?Q?N3x+dc35ye6Uv/9WxS63ySoGxYo3PqDNBhqhUWj0T1pjf2DhYlxYlXu/R8eb?=
 =?us-ascii?Q?eNB4Q8mRPuyFdie5CsSZdpXoiD2uWbZEaxCb3p0CoPXG9I3tg9IvTBeQj3ci?=
 =?us-ascii?Q?pl0JnLYbuIt29uYP0Q1uINkGSgY69/tjV+y7X4q/2eu6/7GKR5JnyJLYzbAe?=
 =?us-ascii?Q?q7t4BJ16Pr5ywLJttyEpyMuoPpVAeCo3bUw1BNU8lqkYmufw0FR+mQmncRJ5?=
 =?us-ascii?Q?ncnuHj8gI3gfZTMVJxcA0PUfKm4HA7455V6WxgPlo/TE+S//zTHtlhKD1pJ2?=
 =?us-ascii?Q?LBvVFjSDp0rKJaFsDnDuSaPjhMf57BHX+IrF+wy+F4LFxvgvBXYpKij0TTmm?=
 =?us-ascii?Q?6SlIeRbCyFhQ/mdLZdKEzkqT0wg+HAcQ19PoINiSBdSSa5ssg0ObmTA4bvLL?=
 =?us-ascii?Q?9IbUBTfUTRkVZyv0HEbKZJ0nBgXFjSgOf8Q3v6p7rB/IwUREH5NnGMCT/qx0?=
 =?us-ascii?Q?ApC3ne4lLyMkc3HGOjxCtGZkYVtNlmmkdo0Umh+mj1ezb53FOonic7s4OGIA?=
 =?us-ascii?Q?3nFF8usBKwXRq+5n5vQHA8bky9MU8hF3EHbPmmP3xt/mcLI6rE8bEReXCYwZ?=
 =?us-ascii?Q?dz4oBAZrddoaWGJ+mp3qgLxhIiYjHGehVhwzcfE1KSf1cknPAqkpv7D4tWlf?=
 =?us-ascii?Q?icCTpohW7HfZJiY55SZ6oQyGakBNbEUjeFhSJh73pJqpYKn/6JGW6ydJY4FC?=
 =?us-ascii?Q?/7hc+Chl6XpKaky/rTxYqDm3gjkjuwCbQ1iWeoMDigN/fJefOSNjs3hJR5+m?=
 =?us-ascii?Q?rUM2pCN3Lcs53SvNbYTQPiXaibsylrXthPYliSR9jstX3CrtOFdmUk8dO2IF?=
 =?us-ascii?Q?dGLsqAgQXADsBIzORaI2uzuW4cnJw7JbZXelpiMJvi/IONRMx8Y3TqfxCxWH?=
 =?us-ascii?Q?0EuERyJXK1VJ0w+zGs/Qzp9r1YGGsUu0zSbMPxotybki6V5OMoI0HL/FGBUT?=
 =?us-ascii?Q?YiIsm+DySvQ59DfdLKvVbkyuPEstk+w1gWPpJwnInmvNw5ZaWkgEmhCDbDqK?=
 =?us-ascii?Q?QAPLysV01vFl1pa+GOgtJH0DsPsjGQcdMrlmEEuyERv8z0pdS+0/QhAJTw8O?=
 =?us-ascii?Q?7BHYRWO7UIWz6siFTPAwnhhVJqHruuWi8Dv1JF5F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c931edf-033a-4c1d-a3c9-08dccdc2d361
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:53:03.4809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCpQz/WNFQdwgSX+D698XV1MzQYP8543riC/SHWvtwYAoxaX+EM5/bIUFsZDuHvK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071

On Tue, Aug 27, 2024 at 09:59:39AM -0700, Nicolin Chen wrote:
> +/**
> + * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
> + * @size: sizeof(struct iommu_viommu_alloc)
> + * @flags: Must be 0
> + * @type: Type of the virtual IOMMU. Must be defined in enum iommu_viommu_type
> + * @dev_id: The device to allocate this virtual IOMMU for

@dev_id: The device's physical IOMMU will be used to back t he vIOMMU

> + * @hwpt_id: ID of a nesting parent HWPT to associate to

A nesting parent HWPT that will provide translation for an vIOMMU DMA

> + * @out_viommu_id: Output virtual IOMMU ID for the allocated object
> + *
> + * Allocate a virtual IOMMU object that holds a (shared) nesting parent HWPT

Allocate a virtual IOMMU object that represents the underlying
physical IOMMU's virtualization support. The vIOMMU object is a
security isolated slice of the physical IOMMU HW that is unique to a
specific VM. Operations global to the IOMMU are connected to the
vIOMMU, such as:
  - Security namespace for guest owned ID, eg guest controlled cache tags
  - Virtualization of various platforms IDs like RIDs and others
  - direct assigned invalidation queues
  - direct assigned interrupts
  - non-affiliated event reporting
  - Delivery of paravirtualized invalidation

Jason

