Return-Path: <linux-kselftest+bounces-33099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC5AB8D8B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF061BC7420
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 17:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5D7258CED;
	Thu, 15 May 2025 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="diVcsRtk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74182550CF;
	Thu, 15 May 2025 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329548; cv=fail; b=F1idjzPVwCU9AOH2C1SsG/NY6hi7O8N+4d+6TGPDzWgfoawdidH6n+x6wGIgR0c7db1295ZdmFxDSOHNfhPuKUOhpYZlnIsFSKeocCUxm6QpGvMqd2sFMyKIhKRXXdnDraeYEssuk/AdLxE4yPWuF28WNi8wyIcDQeJcwUEW3Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329548; c=relaxed/simple;
	bh=Jwv708KaIKNV3GLzBR9pMzrVyG2evjwuNwatawNFSbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kxHvpBXyxYBamtk3G7TdUdzB1oSH3ZxiTnvwAX+3Z9kY7KJ2ksMtMomW6cz4FeaHykwbgfTw37k1FhCq3AmXc0W5DKDDb8p+s1IMG9K6H6LkWzWoDQfg5Guljzah81GFcMDNwM+qsurwDUdaNmFSkQ6iqzdUXwEs64UsuKdGeuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=diVcsRtk; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6J1WpDYcvjWm1X8Z9pryBUGC6fbyfoG1uUXSD6LokLXibsonblFPG6GIOmKpnZvy5JrpBvbqef0fu+bE9SecmqoJ9nQjcchpHTNJMWKRuS9vLlap+fFf2hMi3oqDgZ2ud58VidjvjyP444RQcvHMvIHRWMrWiN6Q8c6LlAdGsUzilvm57yBwVZZT/ODh0Am3N/yvE7SMJ9ejM01VTJ/ZfitEDR0xKwSelHbUT8R8Tx757x0oZZgtTlYVzxcWCxY2LvxcrfNt+9PsbWSQ6cL5eCMPmVqSlySDhX2igZe9WLXZP8YBrSO0Aml/b634DV9fS3LxfWl7wNENzdDMBicRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRzeyaS8AoAsaxUY1CP+0Hr6uJirnreeFjzgvAs1MQM=;
 b=RDeXT0+vBJDGDlPVAFnH+gxYodj5S2EFI2Fg8tFGQtZZm/WlgZW1bhLAIE33BImqmB6LKMQ0QgtHq5ynN+y99CYtmkXwXytuDuzsOHoeIf8FfAplNgfnSXLr68JMG72WO2rHlz3HSxrUE+A2ofvT5wz7n5da7rc9+igb8L2z1dfarfgZGeUofmQ1pD1390v38NlltqL232k0jF4dr6oZqTmc4peAMjgMwJlKBEJliRDm8M9ZMWRlIM/rpUjkO+BdszA//2kUVnxrcCuR9tfpsPVbsl8biqbcSz/J1MpBBADlY2ya08grTiOj3kpUncqRhgfmg/t+S3FuX+Tm9r1KOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRzeyaS8AoAsaxUY1CP+0Hr6uJirnreeFjzgvAs1MQM=;
 b=diVcsRtk/6TSUs/WXGAHxo76ocLNiLdqnbne8J9eERTQYsx0dbdZkRcfZHjnZs3ztoEu/RMfz203EyibxCOYOc8yuvA8JfJGzxEVaaA1JuS1X7hR9bs0LEMu3YoYTnX/vq9mekQjqiJaqekAlnM3hlAAUQTxLpDonS304XUAKhARRA/jOHjiu1Cnlp66ZpF65+Rwrzj7a/jguI3T+zYZBMJY6/TLh044paPUi1vj7EMhTgKy4qd354CaC6oEvG05ZUT+QwOlkrIFheS3Xi2mhKJcHF9dMA86pTR5R9VacyD32O587HLKJtUtNZZ4vauVJ5B+kUV6m9CfOrOTMQawJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Thu, 15 May
 2025 17:19:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 17:19:04 +0000
Date: Thu, 15 May 2025 14:19:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v4 17/23] iommu/arm-smmu-v3-iommufd: Add vsmmu_alloc impl
 op
Message-ID: <20250515171902.GO382960@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <80465bf197e1920a4c763244fab7577614c34700.1746757630.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80465bf197e1920a4c763244fab7577614c34700.1746757630.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YQBPR0101CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d24bc3d-ff93-496b-271b-08dd93d49778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WHeDIDSQNrCmES5tMo/pPdIYya5axN0NCK8Nvd30zD4TGbsLHHIqtlTIc+2P?=
 =?us-ascii?Q?2/DDbEfWB4k3BaDwAsPu7iEso9UjX8AHDr/8Oqd/gaNE3U6UL4bDEkvIVD2J?=
 =?us-ascii?Q?KBdMqNajdWFXz+0pAsnKWUnVgYVoEdCMtPoJfL743TB5h54kCpPJ6BzekSMA?=
 =?us-ascii?Q?DgAejRV3exlKq8nLlJ055FE9g6YzViHGRqFgKXVa6dvJSHxmxoYIldXFTuQY?=
 =?us-ascii?Q?BnLpqxdug/7Mj2XPewI1lAO2qb/aOdJefH2g1ayD5/5PZCuMjUMIXL4LP2VC?=
 =?us-ascii?Q?5RDe86uGTN85SFxSBS7ujB3NVG7Qc8PxQ2QFP/UZ69gj2hJgRSY4xiMClqJd?=
 =?us-ascii?Q?Y62Hz5Fc+NW6RZ8z17IQbt2qf7RmpOJWRfn0V60moSlFyaynplcr22EiYriI?=
 =?us-ascii?Q?M+5Anw1na4Cngp05eu+OiXQ4BtAr2SU4vryBn7COoslvD+yjzGb1rH/Aie66?=
 =?us-ascii?Q?wZoVzzuCgkbYZglbD8StlggwNVUUV4s9n5sD5qWz5lvuB0hjuviStCnWvpFG?=
 =?us-ascii?Q?dgo/mbmTfxJaonWNDnwhqkLpnUggT/9+ucLLZk8pAsOPFMiNwYZ397p9On8x?=
 =?us-ascii?Q?DOiR1QPrLGCjfOUpBpoZm72PVPoxi+OwA/5k9MmKq6THAmX40rO4rsCtHvlv?=
 =?us-ascii?Q?UTSum6HIPZBAwzrb9LWcn5TsFqm4skV1ejpIQORHgcBAQGH/U9xcTkW4+8AK?=
 =?us-ascii?Q?D+hRtr0bf1Xx1DzGEVsdFKPAuhNXduJRBNNkLadU8IreTcwakrzWB5NkkNhS?=
 =?us-ascii?Q?QMM7FScKOTlEpJO2udw7Ffrdf28vB7kokdNzsYhkDkM2iCsY3JOtgdY3Q7NX?=
 =?us-ascii?Q?feeTT9YMm1wiaOxJpAC65HVtKqW0q2xMcGQF6wJhwV7s4A2hcQFA54mMzTuE?=
 =?us-ascii?Q?p30uPM6OeJEaNt/q/9OwNUourWrA0ZZllCDxOclbxjO6A2fqp9jHl3wUXRgD?=
 =?us-ascii?Q?0jNeRRI1r0xpJCobtrO1nqpPyzn9uprxm0EEhjFX036X7hJp0fLrHvOHJw5P?=
 =?us-ascii?Q?ekdgRJSQKOumZKVzmvJWOh1cJdPx9PNF9tkfSjs1ohAApZs1hdsUDQx9BVLg?=
 =?us-ascii?Q?sJI0cvJM+ujiydU371d7/CMMHHS/CZjnSUiY1sp+Yxkg8+c8SAGcbvSMxwNN?=
 =?us-ascii?Q?i1yTEwFYHueXm5vIQe/kSuQsFyTkPD+5wuPlF/ujk/w5t8D0CLOg1WvkLOCQ?=
 =?us-ascii?Q?0rJGAjyoyc1UWwSs346qH/qlArCtOM4XZarLZBKgE4aaXLPWxBFSv5r9I14K?=
 =?us-ascii?Q?rFVcvnPfNADqYm2+qL8xwNubTfpRfWdVYQql91XZPf1Lbzq6Oe5fiTcqI/dD?=
 =?us-ascii?Q?cxfjjYUtvuzTVxck7SWdbeZgVjOg5Pwd623o29xBsFBsSpgscSVc8giO6Qm9?=
 =?us-ascii?Q?l7wKPROEVP7xkSciN6YnIfosCBUEgX0hehkx4HGnK3+NaSlpxe78zVlVdF6/?=
 =?us-ascii?Q?TsrfH1TMLn0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cw6hbt7gfklcTOEWz0s9raUoyFAK105wwO5xzhAxzLQeGIzVuOhqO6fDSRSW?=
 =?us-ascii?Q?PymJlZHlFQHwp9Q3xrpumMEXy579uuWwPN5Sayk1lDC3YDaDHJevp1YrpB0e?=
 =?us-ascii?Q?9Gaw8s+p7gUgqxaT6MTocnIt9jhABvQpNX4lbvSxcuRSdrJib9OF8Jhx4u55?=
 =?us-ascii?Q?Sacm/Bv8Wn4wZB3Bgda4KWvQOMj/MLyEo3uPLv4BnGPeQrE+u6u6JGzZEZhc?=
 =?us-ascii?Q?wO89UjMJjQu9Z8m5iy4qe9qOxjky7t7oUyO75lQ2ed92YgkMMPYpc+8eSIjZ?=
 =?us-ascii?Q?edTogmDoF2e9IQ3vJDjx756ALQFCgjJ2Syko8+pNL5pAVzdsP56JHkCFceDD?=
 =?us-ascii?Q?S3tmXB6KzW1JdvJbM4LnPjwSKnxvIDzC6VggTuKsjlz71omrUfp48J5YVuGw?=
 =?us-ascii?Q?289cEXwX+Y+0NXA6RGY7rG/qo0sHxo2TTKHDy4QGeLdrFDCWc/6fT4+2l3N9?=
 =?us-ascii?Q?Ur3bJeonmxOCTzaduG0Ma6tcqYAQz6U3GOJK09UwYXe7SEyfYfzl8xqMsBoh?=
 =?us-ascii?Q?i4XPGRSWn4bhDtEG7mHewx0jj9V0nLfCpb7qBIuOciu5abFiUnwwd0DvxHri?=
 =?us-ascii?Q?0PAfQpr724HwRXlwX8vXIKmJ4BZMpwAjH3mD1Klz0VC+l0ZqIn6msYYqjKQI?=
 =?us-ascii?Q?w69u460xlg43curs2y3gNp+RtmTvl4beStRiBN7e0poQuE7GS5GWr3y03mq8?=
 =?us-ascii?Q?SrU6j/SYa7T0bvJaZbmFBdQOXKDUZBCTDQtWzHpGnu1Z97zvWp/x1m3ZiqFk?=
 =?us-ascii?Q?DC/j+tIqhkz0WyE/me+/NP2bqy+DNPRubUu46lFU8BJ58t3y1qUZ6BFMIniq?=
 =?us-ascii?Q?E5fNosCXl22NxMuo7QQC/+qXPraNEt6KBXYwEQUnaPFOKxiqBbCOF399wIEX?=
 =?us-ascii?Q?UL4cUSAlXAE4y/MjMevh7gMlppnx/HtMGab6iuFcJrBEDQ81nHgHTgzE/TXF?=
 =?us-ascii?Q?d2+VJ+BfilSUaoDzwDQm3p/R1kbE44HeWrvRBwH0fxfGqcyM8/E5PQ7Abf7u?=
 =?us-ascii?Q?gRQTy3AFwE5TdzmAUfRi7ozqALIS2+OM4gHr2CgLLVhIuuLMXU6bXXAFz8aQ?=
 =?us-ascii?Q?381LQ5hVtjR5t6FIe96TYzTSdvAtGZaO1yqKpWiFlieQ4wlYaTyffnrELE+8?=
 =?us-ascii?Q?uKUFRbINvhhJmUtzpHLvCQ7cxREj6ic68/QTynfa0W7wo4uRAnYtFgWHgoQE?=
 =?us-ascii?Q?NSpkQPv7LL97tDm8alCvxZgB3qSCHD072KgHGf9iq+p8YTZV09Bn6moVnnJb?=
 =?us-ascii?Q?cP5r75a+1tFJQAhwUp4PFBdSr5xovJZ82oAmwDNlYt/LNNH8oip9a8XPTeSr?=
 =?us-ascii?Q?CcvfyHU62Zn/fDv99CZ4b0GYa557hr3pZtB4r2bf8bkIADo4nDR6F0Idyg8G?=
 =?us-ascii?Q?BfAZQ0OubKHyEntdRtap+mCA38As0RghXNh2xXsFxHWWk1hWGOl9GTQsWPNb?=
 =?us-ascii?Q?UlEFgfP9WyqENQO5c+k4/0x34kc5atZAmnr1FG3TS/ePlkbaBB3mDPYM67Yy?=
 =?us-ascii?Q?n6VAQMu2H9QHxH7Q18s0bG1ZEGrWARM/sCFKoNwDJF9+X2kaDUDBBlExbH7y?=
 =?us-ascii?Q?o2WkMSnLxNob5t6x/DEBjRSOWwQgNlk1pwn/QGrx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d24bc3d-ff93-496b-271b-08dd93d49778
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 17:19:04.1733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNPPeiI5yVvGf3dvTtbKqnaN0cBLRc44wWqJCdMfCRvn8giEA3TG1JLWcs78m6SG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253

On Thu, May 08, 2025 at 08:02:38PM -0700, Nicolin Chen wrote:
> An impl driver might want to allocate its own type of vIOMMU object or the
> standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3 by setting up its own SW/HW bits, as
> the tegra241-cmdqv driver will add IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.
> 
> Add a vsmmu_alloc op and prioritize it in arm_vsmmu_alloc().
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  6 ++++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 17 +++++++++++------
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 6b8f0d20dac3..a5835af72417 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -16,6 +16,7 @@
>  #include <linux/sizes.h>
>  
>  struct arm_smmu_device;
> +struct arm_smmu_domain;
>  
>  /* MMIO registers */
>  #define ARM_SMMU_IDR0			0x0
> @@ -720,6 +721,11 @@ struct arm_smmu_impl_ops {
>  	int (*init_structures)(struct arm_smmu_device *smmu);
>  	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
>  		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
> +	struct arm_vsmmu *(*vsmmu_alloc)(
> +		struct arm_smmu_device *smmu,
> +		struct arm_smmu_domain *smmu_domain, struct iommufd_ctx *ictx,
> +		unsigned int viommu_type,
> +		const struct iommu_user_data *user_data);
>  };

I think you should put the supported viommu type here in the ops
struct and match it here:

> +	/* Prioritize the impl that may support IOMMU_VIOMMU_TYPE_ARM_SMMUV3 */
> +	if (master->smmu->impl_ops && master->smmu->impl_ops->vsmmu_alloc)
> +		vsmmu = master->smmu->impl_ops->vsmmu_alloc(
> +			master->smmu, s2_parent, ictx, viommu_type, user_data);

instead of the EOPNOTSUPP dance. Either the impl_ops supports the
requested viommu as an extension or we are running in the normal mode?

Is there a reason to allocate a different viommu if the userspace does
not enable the implementation specific features?

Jason

