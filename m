Return-Path: <linux-kselftest+bounces-44543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBA0C26327
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 17:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA81189639C
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7212E2F9D83;
	Fri, 31 Oct 2025 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KanD9zsR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D42E22BA;
	Fri, 31 Oct 2025 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928948; cv=fail; b=o/l5pW504MkBOa623FhIaV2p5MaMPetk/zDZ65EBYjGYyGFwIPzRfoFx4NqBksMljU0t6kEK/mK32n5NFh0uYpyApk8WIGEtgaIzaKP6TvsIHGu3B1H/1UJPyWQmonBUJd7SNyuU6mMAdShPon9JJYyTdc86xatt/fir2QwRI2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928948; c=relaxed/simple;
	bh=9bu77+WNZQ610JahBZBWyjtAcaQo0NlkJfSHjI2ITnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TPt899UVEL7vVnWJTHiAi5x4LxQdl4H1hLrgXPd0GLMvdVBXjQ/puqbKGBUCDVOmNekv8Rbo7SFpE3yVSVyl0vEI3+JUgg1PvAfaa/ttQvqrMlqY4zHO/KVnooDNEfXoDRfWpHmTLiSKN1W20cdOxyQJnNeBu5Ymf3o7iNCApQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KanD9zsR; arc=fail smtp.client-ip=40.93.198.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwpaAZ7CTTZXqIHmBOPYJhal+w4DYBQbYkzu/jMUSAB5/3z8t/v7UpOzXGacmmK5YoZI8HgRvMrcntHq3U+hZvzEhFHcSsP6py3Nxee/xa2En03HZxpg2nsBCYg5caz6pVdMsFzqzxGK90NMxWV2ik467dCoVCN7UWNOs16vr8Qgp+LvL/KCrr9Q1FbRA9qBvfPAnrB31uIGMIIf56tD70qJwM/nfePKk8V/llI9aLm6yfwoRQ6AKPuXPXq3/hL0+cg9YLs9rT2qVq9fkG1C/sUM76N2QYrtRGUA9FYvajhHF2RiPAUtBvQETDGQAGi3MKFgtaEEkeKMWVIdKYl/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpG5e3hh/hxOuUiJ1ijqolbYie5lSuXgzd+2BDZonS4=;
 b=wVbAoCp2QK/4cEV6LH+bz2Q/Egb6EAiWQ+OuMh6N8FlExrO8LSTiFpmnURXZ9CmKLgfl61UOyKHtmUQ6LMhcAKbNa0YXddCAl7zdVA8n2RNlpkAKi/nsmHQymFPGmw4Bd9U5IneGHO8Ebpu2wHR2tzDUr7TgqKt79wRLr6Gw3k/5EutgyOf6+zwDnqbbq4J5c9spjhkgzn/zDtWIgo/eUfVGwMCWFB2k3TWiRIP1XActnmpg8GiNbDIYNbbF+n+juSDoOpLp9yvK5HzbVuUjWNLszKlcxt5Vy2haJOPsKX5RTwtgCmDmX63r7LOIBsK810anhzSWM16naD45H6iLXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpG5e3hh/hxOuUiJ1ijqolbYie5lSuXgzd+2BDZonS4=;
 b=KanD9zsRSVci3CgILM/iwvnU3NWo2nj6L+p47Y428gRylYl2/B+FGSX8h+z8WZy0ziBEId6pPSCD9bqUzcTIioNaku0ajchLtv5/a5Nn6ASx4ZVx1v6VU0QQKAiamnW2AeGURzRLdAJ4Vm+YcP90YpEQ6UFLT+LOXiqBGQ0pCcD8p6IhfeYCdJ14ADhPvkRHAJv4BgDvuAhq2fNUO/3/cymyb0yMbcZi/ZExWw0JVvviWYqH9/jfpkGyJbofC/ihV6M2RIML503Qu1HoptoJ/dQNEm75AfBxFaa16ZMGrAkZLdz+uGk2sP8ebtSuxt7SyKQyJ1wttqpDCQ49mCVB0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 16:42:18 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 16:42:18 +0000
Date: Fri, 31 Oct 2025 13:42:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v7 12/15] iommupt: Add the x86 64 bit page table format
Message-ID: <20251031164217.GA1112305@nvidia.com>
References: <12-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
 <5122fcd6-ec67-4508-87c7-9a9e688f01ff@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5122fcd6-ec67-4508-87c7-9a9e688f01ff@amd.com>
X-ClientProxiedBy: BL0PR1501CA0004.namprd15.prod.outlook.com
 (2603:10b6:207:17::17) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: eba4c883-c35e-4dd1-bfb9-08de189c7440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BRvC1FiL440/EwdWOFhfo6DM0QIV+ZcCVD10YvUDYlXtPKLDnI541rjAcxCF?=
 =?us-ascii?Q?JAsHJIAWSiuaaywJAKck764YxsXTJCptN3F1xJTy7aF3uUBZpgCEVmsQLKED?=
 =?us-ascii?Q?dV7y/x2qNvzFp8vXYHgVtjmgJaxMn5cS7aAgMAq/jEgKJxbuW1pdeP9MWjkv?=
 =?us-ascii?Q?Wj+/2ZngErnMGgDjflVt9QVRmOc0qHktAinoidikZeCIidVpG9QKSRq9yNI0?=
 =?us-ascii?Q?elwZOe2caJkNT2HK1ByjjBbJTpmw5FaqikZala7gQzL1oO6oDzskm084hFB6?=
 =?us-ascii?Q?gDlx346335LrGTHWLJeNAtUgQXoxOreqCBtMpsobehT0mxNXMNt9R6JGEm+J?=
 =?us-ascii?Q?XMADstamB+unv3PP9SXFLgZia3zKHINNlVZmwtj67kp7R0GauKAdBU/sn+o3?=
 =?us-ascii?Q?7VrI8r+7YVdVcGCwTvD2AuqarMVbxQSxA2xpG4t1+dbD9Inl9GiOEew6ykYb?=
 =?us-ascii?Q?2gPxd6B/U1ydsaOBSGGGSx54T/04xFKShy9RLMqdwYZXu5faVlsTxq+genG/?=
 =?us-ascii?Q?XR6tuDeUWx4FJnlJHiFhhm1H9S6IEtRK1PssNAFrIJtZb5TfmNbpco2fsqTU?=
 =?us-ascii?Q?lFYN1tJCjrusJxDCtQ25+iEFM2mAxhszZAJK4wocmSfX6KtDnPaxmYHWxIpK?=
 =?us-ascii?Q?xE9DVFLsuE+Bk5R/T4iKbnKqSapctq7UmdaYEguNefE1oNENpmP8iqkSlS7K?=
 =?us-ascii?Q?+Sb33ctp/0pYVcSN1AMtl1geHh7QZFpVwvnrBSa/BJRifGgCuhRS8iSAX1mV?=
 =?us-ascii?Q?e4lv2OTkxkwsC41+jY4P7DueQjXO79gZAz5EKyHiPxSdFQEL0bmuDomKRklc?=
 =?us-ascii?Q?punf7kQSxUs69lGnb0E1gRCqLsfbTG8eaCD10BLM0Gfm1j0FjuwtLHlI7M4J?=
 =?us-ascii?Q?uJwFuHQ69IIeOJf3yVGN36HgVG03y69s3RQquWXgwsF/fE4eRmLvv7Se2iyO?=
 =?us-ascii?Q?O4t17q4gILmCn8RH4je4UWH9Ut9YpG3yIni3mlmqibMfgRWiX/zuvSjDKQeY?=
 =?us-ascii?Q?hkhRQDtWehHgkyr56CWFV8JANxZ2AxuuErPxSzB1ewKcNjDRf2UVGiRA/BOZ?=
 =?us-ascii?Q?+eCHPhWorp5Ko+Op3omT/goC7eIXJQqQx8Z0JN5HQXSZiAVKM6s7bzEKehtU?=
 =?us-ascii?Q?/QiI8vJTeEpsLaGxLZshfhu4h5Fo0H/jGkex6XukzTRELEK/rWKyg7GaY+vO?=
 =?us-ascii?Q?e4YxLQHWyyh1kW7Lys4gqHPX7x72PAIyWkykB/IT7UEH6rFIMGNv65O5Odez?=
 =?us-ascii?Q?69x8vn67XgH1g3jWMKtraEKxqzXB2EWFt2cgFlwaa6E+eZu5Zd1cz8/W/UMb?=
 =?us-ascii?Q?+i9wTWOx5xwEzQBLXaAgbyb8SZLGRW55uItvyF0ogQX7Xh5SurLNgXdCGJH1?=
 =?us-ascii?Q?Ew/k5D9rcuPLVA/VUSJ4WmSP6FRRaU+atl8pPmFUZvE09PoUXNdfS2ftcLSk?=
 =?us-ascii?Q?9YlG2POHmrge2WL65b0+/ta35rEPnqOE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yHEGli/delE9XGUDC2PWyEhSQw7ksuy21BWdO+yGRNs3skv6s2S++/0qdvXS?=
 =?us-ascii?Q?crVzOaCE9hBL4breG8VNNMUXElOHEnJ6HXtUCAyhdv3Kq/PvwtohJ/Ck2j5v?=
 =?us-ascii?Q?MiwVEak3OQ0ytUzIvJzh5xSYoNgQjjX6bwrNyznf0OxoIVaTmnoWctXtuYZw?=
 =?us-ascii?Q?2W/8hch18zbbCTAIMWqa0Oypy8lcjWqN3VbcV1t01fR9Lopn4bRHlUn8v7Yf?=
 =?us-ascii?Q?RHF0Jj1fwK1e4qzhIYfvSZmgaubuY3PAS8ZX7TLUyLV7Ypn7auvsvLKkug83?=
 =?us-ascii?Q?Fgmraw/+bTVn2q43hZLwcLMNCBFqBGetSDzpNG6/0jqRl+V/wMYdjUt1rdmL?=
 =?us-ascii?Q?uAugarImj6eetBKJ8GyibstceSqvl/QrtA3mW3bAmtuXo693KB4R2+RaiTrq?=
 =?us-ascii?Q?5/OvHdv+OO/sDfM06LbKicmuDf3abfgioex/qnhnusB6Yj86uC0+q9euqmEH?=
 =?us-ascii?Q?qsCHkLFfSJNislI9aAc2Xp4viOZjKS9Vk07wzSCnRFj+8aeyrUnD3Tr4YlBT?=
 =?us-ascii?Q?wlLFaoFpguxPm6PWEI+mQVE8+qYIG6FqlAy1rCZZOFIliRvEd+d347g02VcP?=
 =?us-ascii?Q?eAgPzQlyeAoFiBsyHCS+KwF5i1SP9kE1E2OHanPw9SXeWRrekemdjFRseSEQ?=
 =?us-ascii?Q?vtIYLn9XJX7OCCAOZmAjGFFGXWZRsds/SGB/GlbGGgR+DQHVilLmLEphWJuA?=
 =?us-ascii?Q?M9sUTMkPIBUDwz7seksZe087+B9g3ZImrnJRTW4ZyCDnLOBQnj6WQ4/7E9mc?=
 =?us-ascii?Q?GKGXNz8kKGciI5Oa7h6Km/2wPN1xfYE4RUs0ZTjf+wJ7War9oJp7hJf7tQp4?=
 =?us-ascii?Q?Vj8Xh0UPmXYrRs2FB/nySQdWfYCmNmExMrbkovRMEzSR2eIcKnCTdBxvHYEY?=
 =?us-ascii?Q?vlpxMChs1LL8JIpCMzjpPYRhyWcsUdAsnQQ9Wt1g5IPlcXulzU50CTcimfG2?=
 =?us-ascii?Q?s3pe3zMiXMvXkMqWMWelIgbbVAV9my410S9sU/ZcIXAveeG/RBtgLNf7y1bs?=
 =?us-ascii?Q?octsJfUe1qu7C6TabzVT2aZ7pnrOHaANfHJ61dzAj6JEMxsD+MfSWz+q/PI7?=
 =?us-ascii?Q?W4z5OS0i1tvDNapJRFmU/x4U/rOdcAU5vvZYtaWsWgebKjuhEBglUd12Odrg?=
 =?us-ascii?Q?2P5u0M51w07zr6bJhVLR/VrpfyFggvM7dM70kopEOzFXz4qHQpJYJISjRYNz?=
 =?us-ascii?Q?95GznArR/lj075lnfJZ6sX9wK/SBw57qL/HbQipcRxRRjCdHIIUi2xAzVGbA?=
 =?us-ascii?Q?CkNLY37X4e+flMujE/h0j6QcDJ2NF7zV36XoKBukEPaXtN5mltzEX/mYjyLJ?=
 =?us-ascii?Q?rQlDTrz2qgB99LLTOJoSwI52yqzDQ3Y/q9jCLMHHOOe8drYCkV5ZDhD+3dFR?=
 =?us-ascii?Q?jdN0rh38hQ7zWUdOUM4xsBLBo2idjy8NEr0S24ngDCfQwVIxivFsEcIfzJpt?=
 =?us-ascii?Q?X4qCxxK7ySDxLQAPJxPTTnZJPeQ04JYUuhSLjS54M/98VL600H6ZEOT1v2DX?=
 =?us-ascii?Q?iC3tj7LshpeRbRvKf5yVlYK81pnGOWEJ6hNbEvJoTXICdMqT/6raRGdNlIjd?=
 =?us-ascii?Q?CQWPBnGivaZ16Vtb8Ok=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba4c883-c35e-4dd1-bfb9-08de189c7440
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:42:18.0022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOx0XkE+EqibLavXd2I+G2vXE65OkIiHtvCIbsh5j0Zf5RbAT234w3rXQfJbWi2X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093

On Fri, Oct 31, 2025 at 03:21:38PM +0530, Vasant Hegde wrote:
> > +#define common_to_x86_64_pt(common_ptr) \
> > +	container_of_const(common_ptr, struct pt_x86_64, common)
> > +#define to_x86_64_pt(pts) common_to_x86_64_pt((pts)->range->common)
> 
> Unused macros?

Yes, I removed this and the amd one

Thanks for the all the work on this, I think we are in good shape now!

Jason

