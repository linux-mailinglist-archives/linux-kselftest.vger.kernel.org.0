Return-Path: <linux-kselftest+bounces-15098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2229394D8D7
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 01:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952C91F21B00
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 23:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E8E166317;
	Fri,  9 Aug 2024 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XpAck1Q2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE9B2232A;
	Fri,  9 Aug 2024 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244498; cv=fail; b=urPAa6OeOF+O3W5USMXHjdzsCrgMr/bTiDfjLRE6i9uBGhalbUNd3bkXzZFV3VZLVdExbwl656O6HNUnmNAthJi60Qe6eyhGfg/hEqcBY/40LScgF10kfjP9KQOcqaQIcLMs3q6VOHHsVoqJ6F3GlBEQXG71PA5iywUEw0suZJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244498; c=relaxed/simple;
	bh=IrkQrhfbWjoqgrjIdErk5tuDLnekXOgtaPoHFn3qdsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z4nqE2lJ/XhRmkeTwVvAM1uKlInV5ShXckBV2H5r+VIuHCpgBSev9EVUwIw35U42+3vIGGzrh49gWC5+BGVEjFeAkKzryYUXc9KB9myoiq3oxbd4DflIJdh2q4K58L4Je7RPrkVKHIQrPFPDCYYLmxI+qUQbisK2gTjzGhC59F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XpAck1Q2; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxraW1/x5Kcysvklu4K4+aCL3r9MNHiOV2QkgeuoZOu2xMCosG4YVrISB/XUQZshEr4/t+tGa7K3kSTckkWJBbWhltUcEJ+L1CgR1XiEApAtZSSSBiR+McWtNquvYLI3eHCV5tull3Wg2Iq/TadyAopfUZldmk2tCDjKlBmakuosLCkmTb/L8Xcg8s5pRkI8HhuPPMpG2PhvHpzH8YgUgYowx5qYD5uuwi+qQM8f77ZoN6nDw7qiEyS66qwL3F62PxzVGIZLrCVtKgIhmiR5Quy33MSrzAjlee+wXld0Iw0qY1A+vypsn73isWH7TuvvVbmBtjx1E0No50MARa/1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJKDBHmmm3lVAD7bUX3aUlIUIxRpuF+6HLbBhNMOtGI=;
 b=Vnn6NaOoEnv9wjOLBaaUYOM67R5kxvIYjfGjFN1fTRpbeAg3deXtZZJpc5mk+0uOTo0CRgbp+KHqr7IaUUb2EKLeioylwpeDM1gLrGReL0dru1JoE5n37oWhrq2bPOPY7/EE9hDvco+rODy5QuVnK7g5vENRuEOUsX+mlTIpSOyidVcr3vK7njHwLksGcqV+2dFyKRe1h2YeN6yqVNbwxb39nyD07IaqRZKrKGnabslSWuSzHqwf6VuZdcePEcrunfywSC8q1kFEVlvS80uE1tJ1Zl3cIrHAS7KifD25lpgj233YACvy7Fw7HMv1kNqWPJkPdTmCMo1z4iWHj/Ms6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJKDBHmmm3lVAD7bUX3aUlIUIxRpuF+6HLbBhNMOtGI=;
 b=XpAck1Q2M3dbgAI/+lCKL8QSFzcBJ9K/zJsDk4jdAeJDD6EZtFKQK6BmBEj/1+gWu/Xm6MroKt56CubILD+cl+eRo6pRq7UIpD68Mbm7dWpYgZ9wtd6Kb/2cQlKjFCveq9IvYg343l8+tveJLH7lNFU7TD30WtwcZL1IVdE5C+3+DEu73248gBAKM/CN03cV1SbkggyIJ61Qstg0Wu6YZEZT4M3URrMxlPukjDkvidWzH9TTGTAEvYEm5MYWsUfp3g+v3rcY5u82Hxehc6T51xMAdyPmdFwZERYk7Wg/Qr0MKw2xiW5GC7QJPL5Ihp39nnwE0xzum2xDuWQDP9oH2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by PH7PR12MB6786.namprd12.prod.outlook.com (2603:10b6:510:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 23:01:22 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 23:01:22 +0000
Date: Fri, 9 Aug 2024 20:01:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
Message-ID: <20240809230120.GN8378@nvidia.com>
References: <cover.1722644866.git.nicolinc@nvidia.com>
 <b1b8ff9c716f22f524be0313ad12e5c6d10f5bd4.1722644866.git.nicolinc@nvidia.com>
 <BN9PR11MB5276E59FBD67B1119B3E2A858CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6da4f216-594b-4c51-848c-86e281402820@arm.com>
 <ZrVN05VylFq8lK4q@Asurada-Nvidia>
 <BN9PR11MB5276D9387CB50D58E4A7585F8CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D9387CB50D58E4A7585F8CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0119.namprd02.prod.outlook.com
 (2603:10b6:208:35::24) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|PH7PR12MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: bef31c88-5262-49b9-8acd-08dcb8c73013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J5SVfpb04tlWNCKd+aG6DA49uLAtd4e4nhx+CEwa2MHBK5t08f0t36ikbBmv?=
 =?us-ascii?Q?MNIeK+fDrgFyUBaaPwBTeFXOEfnbwR0pK4OspheTZ6kxutk7ekzgUHLrdRhb?=
 =?us-ascii?Q?mTWgU9WBIs+BDJ+rKIxEz8K8i5H64gO3qP3HaWq3Pfj3Pln73CxYIRO+P7fZ?=
 =?us-ascii?Q?TSvgCVgxQ2dzLCv//Of0XcStmfAOW3X3FB0RU8O3nHU0av2Sq+pMI36LwnIo?=
 =?us-ascii?Q?P5k4oAi/5ImWVjltSJJenY31YZhTWOl89gOfavH+pb1u1tsRdTkTMJA3Lug9?=
 =?us-ascii?Q?7hflA3V/80Qu/Rmrm4HzQBnnTnr9q7djYuQ3d8fHdz0aUbA6zo4cZiOJUDGI?=
 =?us-ascii?Q?eC/4bz814bRHVxWA298PJz9QCvs3M92gmYfinplJQ0GpMGqcD7l/A2jgxun3?=
 =?us-ascii?Q?BdNeLOjku0MGhJqjEYlMWoKTal/QQ0jWTu0ZEQrLvRKssk7cbvMHpDBZNbbv?=
 =?us-ascii?Q?Osd6SQQQ8f9fdVyYrnxU2sTKxSjPC7FYjLvu298zonuWScsikzj1iUfLHMKI?=
 =?us-ascii?Q?6Qc4ZduNBv/Hf8VMbxijSNUU9ZtBKCtwtgDF1fioSBmqqaUfCT37Tfn9VpXo?=
 =?us-ascii?Q?qujZ8vAhlt0vAdToFUkbAbVFlkXC4ZWFW1uGJR6pZI5m/0tvmNsCLTHB6V5m?=
 =?us-ascii?Q?ARqEslZ0cDHg6qtM2sgyk8uMtNi2Fp1PT5mw5c7JyrDKelq8s2cMC3LZI778?=
 =?us-ascii?Q?eJstL3srJcXiN2OWr1ZLIRSzND8jCvozbB8gLwR9IfaqKFDTv/1aVmzNSFtq?=
 =?us-ascii?Q?nl9trXanbHhSZgkyqWOX/2inkRMYlDAQamnyIKGPianUZX310JE7PfIUG1nA?=
 =?us-ascii?Q?p5DMwyHLG910O/NgabGrI1TEENo3WJcE2Q11GXY5l4HQhQyXEtKNXiIZcM/d?=
 =?us-ascii?Q?TpsgsrVUkCJ70zYuzjyqlnMgjUOpf8mXmSL1Ih9R4p0HLFkQnwi3CurQM5o+?=
 =?us-ascii?Q?If8wJiVpLLeUBRNCb0RKJLhI1HxqASqiSQvc8WUUj1et169OTVq9rBNHiZ/M?=
 =?us-ascii?Q?UaAH0x/CVEq/d4+dQTF022tHwSpD8GXm86JKt3IkIYBRMu5KVT3TvjqAq0W0?=
 =?us-ascii?Q?wh4GRAZHU97eL1a317ECT2a4LViE31zfDswRkiZH+xUGoIiYGYdaeQaE5hNm?=
 =?us-ascii?Q?UmArKnYQfhbr8yxZBSevON7t1WnYe9EqzL/hCbn7g3GLPJM/dlu5EVkvl9Fr?=
 =?us-ascii?Q?A300++WQc2UnGWyGAZKyIwA9YHPiWdX+UwG3G42PGHljYr/sQyBems/t9JZH?=
 =?us-ascii?Q?W2pGO8m7jE2BTjzp75bwrRMiZzjOQItkYXKqxfFNzDwcHpSi2T65bqAHBCl3?=
 =?us-ascii?Q?dw4celcR4F0QFJpiKnFXMz3CQ5nqT4MX3YPouO6KXRN/2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZH/uvjwLETapvs8vPI1qexFYaR/+mzC+Ao9yPse8kqBE7jz3qhswANpru753?=
 =?us-ascii?Q?yNW0KdSUM0PTtnyAgT4SdHj6m+DP6dKAqnxlzhutzDKnkMKiA66lwXtGu2qf?=
 =?us-ascii?Q?JDCzGbOBw8SIkZuzfzt9zj0ZjYmrF9n4JNJaEKT5Wdmy2ZlcAryZOg6drgRJ?=
 =?us-ascii?Q?KaoACgRZ1lsmV0Rcn/q0HI5hYSxwTyFwOpRhmNyEA94pXW+7rVqygVP68GMb?=
 =?us-ascii?Q?YI0Bb7ab27H9kt88N77bnV1B5mIsVf+oUL2rRg4fNh1OfyCrV20CtDERl6Yw?=
 =?us-ascii?Q?O4NkNywv71LxOxDwMO9+QkbPLX0FfzeIj66ggElox7jnZqSE9dM0MYonjF1e?=
 =?us-ascii?Q?kloTyRkHvey+yaSGY71XmUOkQ+WK2voPH3E3lF12cH8a5T+qgELT/s8HDysm?=
 =?us-ascii?Q?IjWByBsjoiHhRSUqk1VcJHVriZ+JHSBrluHj5IXBz/5PGYnlElohGj+//PYg?=
 =?us-ascii?Q?5HrT5nqeAWOlykHJfkKPbIbmsDxQHs9chVFwuugWBw4CCsq/pAKPNOXEam5F?=
 =?us-ascii?Q?fj3ueJIfrTOYmZEWNdaiqKI3P5dhw8ec7VO8hZmPA4jqCfDrWBVfF3LJEncA?=
 =?us-ascii?Q?8wGFe9xl2Uc2bDiikRyAB/rC+4PKkXc5849R/SL1M7gUtYiEuKOQy0JU2+yW?=
 =?us-ascii?Q?S4x9eUe+3YjhbRSOaL6TWrmj+p4GNu5bQQFylVR8KShxeA6e79OjzeZMebG4?=
 =?us-ascii?Q?5R3eBgitNvCWea9Dg808bBeRhLBsf2f1RIt/z36TcIXSZfaLmHaPjYxQkAuU?=
 =?us-ascii?Q?Y7Xxq+DkTGFv8SaTnaarJ5J9acziP2qqS2RuE45R0pPBM4x1eHTkmm99+dR1?=
 =?us-ascii?Q?xPykN/vYcfn4iDPzFGUsNn9Jete6CUp2llWeqUrokO48PcDQ+CKYcgNGb4pO?=
 =?us-ascii?Q?OrcKmGYR2A6Ui2q8aNQyFdPT63B6ZTgElqgLkCyDbjd0Pr0+istl5MYS2Gxs?=
 =?us-ascii?Q?rCArYZuMCblX25jcU9KPoWyaRt6FNI3jUdNLcwsa3chaTRM66A1RyPi+ex/U?=
 =?us-ascii?Q?c8emlOqfQNkY833e/FgU6qdwyfxMmrszIYUN3TEaM7VAt2glIteS66aoFum/?=
 =?us-ascii?Q?Ntaj0yA9QuOkYWlInRAUTt5tb/6nIcRO/k0r4N7AejdJCcCMDLyEU7p9IcvR?=
 =?us-ascii?Q?aPe5VGBsWJxk5LawNlw9Uy7cawgxvkdoqzfm0pCmvrB3DQq0TtEbnMchHRd/?=
 =?us-ascii?Q?1b+cj3KoAZc0RMS0V3WlNX3jYNFLm4wknOapSfCYsIjB9+2i8PSWGjDneJSE?=
 =?us-ascii?Q?1WL5dXxCz3k9vIU9MsQMeSAhG7g145013DnoCZTpS+qUpoA03A+jp2++nAQB?=
 =?us-ascii?Q?pDEsj4llw7kTlvOX7eTRIfXx3eguVqkIx11tfiZugplTdmsQmksEgydeBLTJ?=
 =?us-ascii?Q?fFhSqrlFxcs9yv1XDrzSRSMcu1NQ0WqGSDFKZeCRgDA55YhNJdSfpBcU1vHP?=
 =?us-ascii?Q?/puvY/l/nK7B8uQjeANATP5BTnQoQXyMuJVpEI5ZCLf4Q5/SHIv0RgkbQqaA?=
 =?us-ascii?Q?46/8lW6O2jswDIwPUTJ9PHMu9w/w2/LxXA6pD+BWugz1j58+Mbu/cDHUamqE?=
 =?us-ascii?Q?SM7Nd61DNEUcIzmllAI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef31c88-5262-49b9-8acd-08dcb8c73013
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 23:01:22.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3V0QVRMN2AzaeOpuA4EtdcEJ+y7+96LqCayQRPYzzbn/v2eWQTse9UnMR517p6F+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6786

On Fri, Aug 09, 2024 at 08:00:34AM +0000, Tian, Kevin wrote:

> > - IOMMUFD should provide VMM a way to tell the gPA (or directly +
> >   GITS_TRANSLATER?). Then kernel should do the stage-2 mapping. I
> >   have talked to Jason about this a while ago, and we have a few
> >   thoughts how to implement it. But eventually, I think we still
> >   can't avoid a middle man like msi_cookie to associate the gPA in
> >   IOMMUFD to PA in irqchip?
> 
> Probably a new IOMMU_DMA_MSI_COOKIE_USER type which uses
> GPA (passed in in ALLOC_HWPT for a nested_parent type) as IOVA
> in iommu_dma_get_msi_page()?

To get the ITS page into the iommufd I suspect we'd add a new iommufd ioctl:

struct iommu_ioas_map_msi_window {
	__u32 size;
	__u32 flags;
	__u32 ioas_id;
	__u32 __reserved;
	__s32 kvm_device_fd;
	__u32 kvm_device_type; // == KVM_DEV_TYPE_ARM_VGIC_ITS for safety
	__aligned_u64 device_args; // ??
	__aligned_u64 length;
	__aligned_u64 iova;
};

Where kvm_device_fd would be the KVM_DEV_TYPE_ARM_VGIC_ITS (?) device
(or the RISCV version).

This would let us get the ITS physical address from the GIC driver and
put it into the S2 at IOVA while relying on KVM to authorize and
locate the correct PA for whatever is going on here.

Jason

