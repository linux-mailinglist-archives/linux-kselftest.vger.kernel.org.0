Return-Path: <linux-kselftest+bounces-27177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ED6A3F7F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 16:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C876C861A26
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A601E211470;
	Fri, 21 Feb 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T2HBy07p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE41207E1E;
	Fri, 21 Feb 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149993; cv=fail; b=BnGXUKkEBAPpbmP5b2PR7TuJa2DCTaGziH3ND08IaBjwQS4QnJGJmWQfMBKhFmDgwhKwjf8Sei13Jb0gnceoPK0T1PzFFTkP18j0o0HUQMn1sjbhe/cFlUNI22i0aH1V+3l3TyZ0o+8fknrJyqqh6ItsBG/ncZUuVEx8Wj5iLyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149993; c=relaxed/simple;
	bh=n/LLXURAzN9uDeHdVhx57EvzQ3vxyXwFO2ANLsDBhkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VUWAhYnLceMsU+g55+YjCivmLNmnctKjUAU1NMrO1o1DXSni9D5evVYHGE1jz5IqAMmB5DKT/rBOmAbAm4aebGSVI+UhSp/YNUL89lr7+6caDPisFpSaZ+TIMzjhhMRrFxNrE9bmVvwxzexy4RKXUkF7eB5zeAVDu0znDJXysoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T2HBy07p; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QX4RlargMMnNd+8lg8UE/kxo2Pjk/k6BbSJv+jbNSfNrYpL4ONDgEVRHSeERySMVIKLWR2JXSEjsC/F0NXmARPokAay9rB80527yKKcUvXBkdTHo/AVs+cOiIvvoUWVSaB4WEOG0+XuqHDnbtETeefKS+xn9CZTWn7Rqpc6/EXspTd/gYIZjdn6PTTwBkqXCiqfcGRj16tz8sIkloPtVtQMh4n+/ZdVQWmuINuYSlVArRrGsaw/45iLhbrFj4tJgjV7hF1JAEoSLBI/PbL2d6HODOTi+q4feQSmMNwk7bMF6NtAPSreSHHGsuGEYwDwUhcK+xDRQTfshTQwP9TMQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y41S2cj//KY7KuArOLCuS9BDu96vTH/lpdygauqGWY=;
 b=ivUUw+27ihVmD8GZNZyvQqkPdMH2bQ5IwZNxBKkvNlFTbgLHiKd85TVe9tJSFmp24CGBKSyRIlE39bjUrshWoyXzOgmCzEf1+PCIjGQw7sFeEbUVcQnzyEPuwFKkA+u3l+hWc2Q+4aE01ECT43DEZrkrk4ufVzqImapzuxeuHTIFfuk0mj8JUOM/3dVQtAzPrdvnN03UXtInYSScS5b2o9BzgnjOSU6MEbDMnW1UdnxebMn6oIfGIyxvGB5/viVFL4JZgIvpgT1ywukTOFITfwrwS7KLZSBYl4mcmRdzVMgLonjrbZxl/LMli588CV1Em5c/X8Ik+Sg3nJ9HmDzJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y41S2cj//KY7KuArOLCuS9BDu96vTH/lpdygauqGWY=;
 b=T2HBy07piDsVS3RoT2BVXzpXWgLPMjmNlzmKd7GJOkZtsXsm1W566NOYUKQTvmINsR7wENmeQL1MXoPDl7SXc6GbwMuk560xc3iyRpKrcD586K622alSpaBKPfLvGmtx9RtR/xef0SwiGB35pCui3p2yqe9nWHyk1HPJoGUYGzWyXUnMCnNA+M2yW3iL2EyhFSvnTRIV2A8ithgBUIf8Pae+siFyaSNkPMzVAxYc2Zo5XBJgBg1IAYCN7ROqOdRMkpG8XTFPcSUuV1qm0HVGJXGGd3LgWX9ZrRmS7qsq6Nzot4Eb5iN3nXM97vMDJ0N6qe8pNIcATlxanMRF0LEZeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 14:59:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 14:59:48 +0000
Date: Fri, 21 Feb 2025 10:59:47 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, tglx@linutronix.de, maz@kernel.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v2 0/7] iommu: Add MSI mapping support with nested SMMU
 (Part-1 core)
Message-ID: <20250221145947.GM50639@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740014950.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:208:335::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b5a1d9-7f0e-4e64-2aa5-08dd528862f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J/yhctzuVXukZqZwaOLy8PhOEPP4V7ImmRZyhn1QD7BOL0VOXJEfRK7sLgss?=
 =?us-ascii?Q?IbsOWx97lXtYjFDTj484XcgtPPgodhyXr0kirJdcPl+Pc+7w1CoTtaSXxS+I?=
 =?us-ascii?Q?w4VHeJVXi/Y3VhbVcKyHlTu+gCoyIg4yuc5y7jN8/z/yKkJQJvN1kjcr3kfx?=
 =?us-ascii?Q?m0OTzBs/qx3KfbIm4ak0lDUesnQckH909jI8aoziTVPSsGwv1HeZDSxpFVvs?=
 =?us-ascii?Q?qELTZDVHosNN/i5Ioqw4P4iZwCemNdpWxsBM7imCNmwtyirk3bdPtiWVueP7?=
 =?us-ascii?Q?CaoH7dfvpNAMI/T5TppWRsXLXaB/EzBQwlAHbmpNLQGrVJO8GmzLfSSLlShE?=
 =?us-ascii?Q?VMaq2tSCvmjRIP82dCXL4xPdj/LRBCIf/kn6/vuqYTJXWf573ghWsjBI02tZ?=
 =?us-ascii?Q?VFYrz8oBpwK9wnHwhDrmt6+4nYgNnkWtLGoPHpE0yLsTGAtPcnmDdvoa1ETS?=
 =?us-ascii?Q?e7P6LNorQ6jfASMUE4miHpo2mun/tI4oCg2FYab0Kr4WjiWKjcnTBSOu2pkT?=
 =?us-ascii?Q?dtoRr/8JKBzsdPpyI0R8GWdDLmmUYOveY86ey2oQ6Zk3DYFT7MyOE7oFQRTU?=
 =?us-ascii?Q?ZG1BsJr+RVZ2admfit/YFvEyj5AnKN0biQBE1d9ZKIAGb0TJwuc4D/4Zf/dC?=
 =?us-ascii?Q?dq5uCPwp92uM4f6SFMcBh4P+lscN89LjbqyFVoeQUYViiArTWNa2J4pTvTUD?=
 =?us-ascii?Q?VYM8NkPcFAhlW3We2ORxBbeTDI/LElgi2N1cg/s+62n4eg1SapyDxSbxJ3II?=
 =?us-ascii?Q?AnIG8k7qN7AQgoMxfXjnnq8lhushjPfHKonWAJPSFWW3Id5rNdAiOYt0o3ah?=
 =?us-ascii?Q?7pUgKbroEqzvCmcnRpNXPQ5wPSjvjmdvXFnNcs/uOLz5mdKZ8rEi8kNqOT/p?=
 =?us-ascii?Q?GGCvhg1ko0RsTLNmtwqGAs+A9tcqm4+wnN8JtLCKD/XLyMtxOwjyDyP0XGm+?=
 =?us-ascii?Q?Zl1TuYaWUh0R1XuHOQEpKG2zf32u2GyCspze127qBguXlk3TGkKfehcFqdqC?=
 =?us-ascii?Q?4BUHdOVHZhXnhQOxmIkGgZd03ubYdArXXM1N1V+tUHQZJ7c1000+kKsfbCs6?=
 =?us-ascii?Q?zyKZVernmI/AaE8vaaNcJQg4iyvcKzktBqj90RVqmGzy9k6gbYK/pFsuREIu?=
 =?us-ascii?Q?8kq0RmyZBXmOeMvlRYxfMpfRSbMwTNlQZOQ5A34NfXqCBuzJsa8aBUZ6QY+c?=
 =?us-ascii?Q?VKxlYJpbNG40TvduafKZVunGTTAvMQuWMbZnmr+eUH2FvS80cCeKKCJI5AGA?=
 =?us-ascii?Q?T10QmkSXvWxXHxfIA5uqCuz2IWUxVOCNKyO+NsDmKaBk3tY2acjJuElsvGkF?=
 =?us-ascii?Q?1M1K9DIKGLjktA1sRnCOR5NKE5hrHcc9JWVVnokKMLHk82Y9QWwj1vH4nQZU?=
 =?us-ascii?Q?S0QPe2hT/WU7SrhMht2gLMvmT4eE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L7Wrwk7evjb9gvj9lrbt/ejqfU4X59gqp54rUQwhZWtmK/DudUWeSAnLQt4u?=
 =?us-ascii?Q?88L45Rz7yvWrW5yXKHebvlX4IhJQKquDU61p5Qfo5ymH3Ba0DZnVc1r9iuvp?=
 =?us-ascii?Q?ncUo4GWs4cqx4v0CeagNlY4J8ETV/tXt1DWOMuQceAQX4/trMkU/3xZ8t3yl?=
 =?us-ascii?Q?GWrFBn37tv5IiGIlTIC1qmAhW8N7xPtn3kozub2VaG0T3W4G9a/SBVAL2Htg?=
 =?us-ascii?Q?Ikse094N/ZrYY/MCyWRg2/bb6nb6aXL+vhAEzjZQELABD6zPBVjo9hPzLA5i?=
 =?us-ascii?Q?VrqzVBVijFCAWbl/oo1eQq113k7sqEsGfCnPAILLmlL76aZXqZeL4K9J7f/o?=
 =?us-ascii?Q?V5E7UqqaZT3pISRLGZTgZJUqtFTv3ihzoBjU50jXo57FaXSKZtFe37jjOXjD?=
 =?us-ascii?Q?1/EqdoBfRnJkw22pvN4QrBARCcX1U7EhtsTmAhs1lKI8I/1+vXqEX/FKvvu+?=
 =?us-ascii?Q?6+g51aQsivZ/1l39S51uw6XOhR2CPyazaxFtnaLBjjfAoNLXx3RaGAkFHc8o?=
 =?us-ascii?Q?yiXZss4uHhbEtU51qlpFLut1bniw2GAPYXG6tiDU9ukmpSVwCsxm6x5BPcoJ?=
 =?us-ascii?Q?ttf5wfKDehZrtUAH3wtFnNKcrBNmDTgH+pZRfSmzD3di52ljzUXSW9rhjEW8?=
 =?us-ascii?Q?phhcEkrdk28t2IYdCvMMyzEOQmBBzKJ54jiiYQtETEzkYFZPtyeY4c1JQj8H?=
 =?us-ascii?Q?V1Y8lCMUeSi8Kz+rHBc0Ty2fPHKBwXc5kE4VLZQnd5erdHd8R6RaM/nnaOk5?=
 =?us-ascii?Q?TgCmqxBcaRuAGHFfQ0SwyheUU9XRK8WpQzAZwPOdlW3NDXZwuLhAimkS39hM?=
 =?us-ascii?Q?SPFSoD/cA/+tI4Zzc4XXokPYfqIEaVVyOkvahtdrDJvtKGPZ3FuwqkXnjtRZ?=
 =?us-ascii?Q?gNq1kKuSlJSDR+wLU+C4QOrtP7Vx1xJS0tOH0qtkQIWgg+AlZBIhfZVXBA5f?=
 =?us-ascii?Q?F5k8+u2vApN8s96BYOPsLMXdYtSQ3+QX8DbN8TCH69nAaXAf7ka5Cfz0RUJh?=
 =?us-ascii?Q?R6T7gDb3QaaO/CsRU6OI/sPE/DOjYFdDEENA4B7MrGqNEQLvSVXuvOc/3eBY?=
 =?us-ascii?Q?+cSKhh5FAVXHV2tV5jpC921UOjOQHhofWpaKlQkwPEDYDuBrPxlzISmZGNNl?=
 =?us-ascii?Q?b+G0f5bI0YtCya2TzaCvKwRKvSIAsfMhkj8VMqXzlgcjWxGtp2+fqDlcK53Y?=
 =?us-ascii?Q?844DTSZ0Jbv1Dprd9Tp9cm9Bu8AvONwWsMR2Gg/BPwl9UF3YnxAohHOlgIw4?=
 =?us-ascii?Q?WRt7qw1/4hHehsOCa4Avo0o9mp5GHwV0n6vnS/86Olon7MrTZJhfpcO+ys39?=
 =?us-ascii?Q?UMM3BRDBhxvcy2+Ze5At5m5p/WIFXKUND4GvHOkozcm8BvUoT+FbrWtllP+Z?=
 =?us-ascii?Q?wU/9BGs5SZTPkMfjNaWuRr+rSFW9IE81xrXHWvkLgrc+BT3deNuNF0ax5FwU?=
 =?us-ascii?Q?+yfR3ZHP5w+FhvSOZ23Xl5ewxwPLfVK4awHgYEOn8A69SoGVrl9lSBWmZCTm?=
 =?us-ascii?Q?Ma+FvA69oWC36NoNdJKBVgUrZqoZyJoEAjV9McQwhHM2SIHd1iHpjA/Pw7vL?=
 =?us-ascii?Q?Njrs19wJM+411xrSUhSQ/RIzN5mIF3tbGnKt0UZ4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b5a1d9-7f0e-4e64-2aa5-08dd528862f7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:59:48.7608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnFq4DcNwADfsWH3GKygQSa23IugZL6nqkqLCBWBUK2Avekg402OW+jDweeGVrvj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921

On Wed, Feb 19, 2025 at 05:31:35PM -0800, Nicolin Chen wrote:
> 
> Jason Gunthorpe (5):
>   genirq/msi: Store the IOMMU IOVA directly in msi_desc instead of
>     iommu_cookie
>   genirq/msi: Refactor iommu_dma_compose_msi_msg()
>   iommu: Make iommu_dma_prepare_msi() into a generic operation
>   irqchip: Have CONFIG_IRQ_MSI_IOMMU be selected by irqchips that need
>     it
>   iommufd: Implement sw_msi support natively
> 
> Nicolin Chen (2):
>   iommu: Turn fault_data to iommufd private pointer

I dropped this patch:

>   iommu: Turn iova_cookie to dma-iommu private pointer

And fixed up the two compilation issues found by building on my x86
config, plus Thomas's language update.

It is headed toward linux-next, give it till monday for a PR to Joerg
just incase there are more randconfig issues.

Thanks,
Jason

