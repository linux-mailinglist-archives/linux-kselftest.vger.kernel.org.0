Return-Path: <linux-kselftest+bounces-19991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B839A297F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99ACF1C27D00
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 16:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0022E1DF742;
	Thu, 17 Oct 2024 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q/v3BxVZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3D1DED5B;
	Thu, 17 Oct 2024 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183697; cv=fail; b=HPzvIX99xXVGqt6hrGy3Qjt/zHBYVUlagowNtCGpehIelp7T0qfrDPY1j2oqF9j3/e5CGjSOjxQoukKjwV0ADFgn9gsC+qCtV/hjBMjYUX2YuQtJfwnPAyutINfQ3LMArF7mJWrRx2hb365ixZNhEVN7lPqGxfABI0fX01IdK+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183697; c=relaxed/simple;
	bh=rniFYRyHxI7uMcho043QADRr9Y+TyK4HUr/VbrGKaQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jyqu3w6rh7aOQg6MfwjXDAa55Ua3ZGN41SiwASvkTOJfeJrJYIOaWDds8KSPdZaOerTiZjp9XdJCKj9Tw56Y0Womr1ehsinvj+58spiiQiJ4D7cK5x1rTSuTxNFiKcm31s1+h7lZBZApmrFgHZ+E4c18iJmANSWyE+/qXW5R0nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q/v3BxVZ; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPcawz8OBBPRmsuSXuGCEwiOJqY3p4csUygejReP2POm5sH4cihzKqySVeoRE264phiPZuZyD6YGPisSVxwVQ8n3C8o7jETArORWwKm7av3mfjcgXWFkkXtFOmNzPS8qDq9vvScmml0OUKIiHPNCS9K92UAsfgzzxMgEy8DNdkz2OMl3Pf4dPeLikjjzEvVlm9W7z9TP0qGMUpWlSyyVBeEaCn1I0vhjZfWfBPZwp1LxsMf0QSABI3MYP7lKRkqttNw6wvPXFmAndboTW6/vhScEjybYJEb71KHPjk1CLdlOteBHORiPd9B2z7snCJ0lTibJopQYdzxcMuR6qgXLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6llimch7Lm2CMDWK+6nX5MvalR6IMTKfvbnAEgFfTw=;
 b=JvXhFJUlBpXfcrejs7cBmrnmpD23DGtzJB9Wtr35C1e5ZwCXgN+l7OKRMiDEidZiWCAsRqmew7kcs43Arbga0UUUekHkAErNzbw6ebxmI7kL2gq5RUJaWLuYXgRfulobwa0Y/xvOemZowRwVJmTwjNK8ghkxjfZmqOntjEMOrxEv+Rp8ODn7FnUoDAxn+y7ElY7eh7RFz7/K0QIm2TPR54jelU4WcN7G7Qzqu+gU1PJX66YLk11JxLTuHStToHBchJ8CBykJdVKObzV9Z/dpH/Q1JyiinJXsoW9ifc3/9pyxMvxHoAB5tqjyeojbfn3d5OigjtumeGKy5hdUS8k43w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6llimch7Lm2CMDWK+6nX5MvalR6IMTKfvbnAEgFfTw=;
 b=Q/v3BxVZzU4O+VyBO1Pda2Zin60rDA7AKIP8TlsTu8OPippcQ8Z0+1OADbmKuy+t3KkoubbBrNUdIUjSMuefMfZDLpR8rGMz9BO6Ve67NP0lMD5E2aK34ivyWFbRizXE3EmywNnqPMZWFosZibTIycIlF0PBNKbbMWeLUfCa/rPTeRNkthydQEfROdCu2hXPFL6YdZj/FJjtQjTuH6x/rCn34fx7JiA/XJYnJZZHGfwLjalEWq5iOmNG3zIyF3EgUnloLmeIANiDQoU2d0DgcHZ6Te/jJT8HL0o/qMsetRp9sATIvOHoXyq/fJWAleioKTjwqaubqSa3KLiTM0ei7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Thu, 17 Oct
 2024 16:48:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:48:06 +0000
Date: Thu, 17 Oct 2024 13:48:05 -0300
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
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 11/11] iommu/arm-smmu-v3: Add
 IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support
Message-ID: <20241017164805.GG3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <562f2bfae1661e6ff6abdb280faa0dd49df9fbdc.1728491453.git.nicolinc@nvidia.com>
 <ZxE7ILug+SL5eMsl@Asurada-Nvidia>
 <20241017164123.GE3559746@nvidia.com>
 <ZxE+qhw2PDCv8zuM@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxE+qhw2PDCv8zuM@Asurada-Nvidia>
X-ClientProxiedBy: BN0PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:408:ea::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 31634fa4-90ef-4a46-2482-08dceecb7921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7KrzV6L8/f2gam50cqEAMpRxFi4QaFrpMRdsKfutL4GsoGJmkgfQbupm4KWz?=
 =?us-ascii?Q?/4BSH+G9JHlCPK/b1ZvL1G29D9tmQKf5tUq5AShrLysO+t4GJyCJXQwp74ZT?=
 =?us-ascii?Q?XkcpkukcnswkfWqwCmnP8BhH5qAsoexGmprWFRtW+Wb91fMawVkNy4YjDxWt?=
 =?us-ascii?Q?TkGt1mhYM9k1skInInf3lu1GwbIYEKrKzf04TEIjxxnpntCzlsFp5y1XgOcX?=
 =?us-ascii?Q?RMwhsp4HmCrKFFavXeVLLANapyUh02Wv5fKpBe17VPtnujUYOFivhrf+814e?=
 =?us-ascii?Q?/bOUVS9/s/snv/2So84q54AYRR4LEjPtw81vfZLZ8hzoZO5TLSZE0rWLLJ7v?=
 =?us-ascii?Q?/hVNGPXCX7blOPsVxxf7rfzsjsv3Vi/j4vl005scnpZdfAeEPl6AGdHPEjUr?=
 =?us-ascii?Q?NXIIY4W+29g/0M3BLH59cRFs9l+hW042Qa+ZeAJtr7D/UgD1FClV2mO+9vEX?=
 =?us-ascii?Q?xa248Q22JifIM/8w/q/Pi2fGEFsaTU23Kf4Zx54rqthXH82RTt6i/wroKStd?=
 =?us-ascii?Q?2uputrpwmsl9iZoDnx7NikM144oRYsPhUCsbHEYdasZyH/rk8o6k3XcKLh9L?=
 =?us-ascii?Q?FdBAm6/X1xaFqYj/NUnm/ztoEIPsSn9JPq+5ns4Pnn4oJLpZVbFCFDpP18EH?=
 =?us-ascii?Q?w6i5KXQ+Z5OItE/xz8mBj3FgFXNVWK7fQbKV3eqVyMIL5BZ7/NUZs0yQObY3?=
 =?us-ascii?Q?KYGqhWGFEWjw17rUFgDfATqjKY5HPnmamgp8GaAyq01TGTnDUQ9Uu3JF3HsK?=
 =?us-ascii?Q?Binue4DiyNZxRQu2lWLrHm9taxYG4QqSDE2AtaH/+iDYeN3Hkycsd4LFIC+q?=
 =?us-ascii?Q?gCtl/xksIr6n1IlPEsOf9CDmUjY3XvgCxHRosPVXTbvQqErV8f7Q0GQkgoll?=
 =?us-ascii?Q?RNturALDKfe3cfx/VrvTWfp8hhlB8kmAe+3M0Ro2NEQGBeLRwGFYxv02e4J3?=
 =?us-ascii?Q?ANe2FqTtv4xZa9r9flL1A0gPH9O7+IV9UJZdJzGi6ZdAttgVkpkp2Dyi1yDs?=
 =?us-ascii?Q?/cQx5Exk8/SeorPjQvgiK2auOfz3Ru6Gfu/SI55CN5hT1fZlc5olY0GrSBx7?=
 =?us-ascii?Q?QvOqvXRi0bZkWLrZuYHtFO2REd3soB/8B11DmNYPKZxgrTmsnL61nmn+IqsM?=
 =?us-ascii?Q?1SzQXI6vCFVXIRnMNzHvla42Jdsz5GayaLZgqNO80HbQ+J4jHoBIrJcHep81?=
 =?us-ascii?Q?K3+rKtS+uj1zLUpGDDwwADURKKiBWEr9veF3Ipxpal+AniWCIPAn3G7m1g5m?=
 =?us-ascii?Q?zWPgeAHFjuwOAz5UMZHxclZQ7C4Y+zJBAgIew9+9/jkE3Dqc/ju9lXLouDGJ?=
 =?us-ascii?Q?gwI5KrW9j2CfYMMDzschPfu3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lp6FBxFOGcehYXqHIrGKZMAl+5r/DdcBTk75qIF+kywhvE8JF1pftmJXd8ok?=
 =?us-ascii?Q?j2byM2E/IJWknrnjxmRg4+cuW836kX9vZY7QRsDKFj8F0GFXlkmkMoZ3RN3P?=
 =?us-ascii?Q?8ZzZPZHB54xN8nv81+794Nua4Kf1hKvY4Rc/a7LWglwP5gOmkXZp0Xnd8fbi?=
 =?us-ascii?Q?wXm9Uk75C/jmOIpUzE4LGy1qJD1JDsy89D7o0RqipuJqgtMMm7FU92OU0jQ7?=
 =?us-ascii?Q?ZHxS1CHtf2BHvJCnpolDG2+1DFsfi6S1/b1cxqaZCNiHQM/LwjbUuBIP5kKe?=
 =?us-ascii?Q?p/0jVNhIvFlhpT3K9HGD1UWvYU9GHZ5J5LFqXXHmPdHPo363JPeZEXX4gFL5?=
 =?us-ascii?Q?P1fpOkLc/Fg7ng75lA8hIXtF7+SW77XAHAikiJ8EzI+1tFxleg7EX2kAw0Pv?=
 =?us-ascii?Q?xE0k/62LLRvnM7G7JW0euo6uGhnHtvD4JwDzuDCqM3jE+lyUWrcMPt42hday?=
 =?us-ascii?Q?ce2cjZJsYElifQLn/jtaTQAkFAt7oWZE1jq0NsZMfLSLxQbrLH73gjOse/9W?=
 =?us-ascii?Q?TBB6wCIAiGSZQln2sYLQmjp2V/+53r29j4IX5zII4K6oAfNC0x/S3jEIDfqD?=
 =?us-ascii?Q?Xvi8MDG33T2qfh3CXq3e1Utnr3rLermzcP1LtRqeqTZOJAOqPB3GYHF9Xihv?=
 =?us-ascii?Q?6ttDMYcdPo7pr1X4q9B16o8Newz/Epw5/MC4O6xrfRhZwHkxcs1to9aUV20Z?=
 =?us-ascii?Q?d7n9Ihdilty8EsobZS4b0C37QbBgFov/pLFWZOsqNu+ngJwsJGwaU+uIktLr?=
 =?us-ascii?Q?pblAlAP9cCKxwaeeRWn9raRbuF6BlJ73om/2NKBSnJeIY1xRAYdCpTgteazt?=
 =?us-ascii?Q?80qdRYKr4k/tBg7bj68sUgauaGYHT+8nyIdE6PPL1g2svj1tgHS/wOCvH95i?=
 =?us-ascii?Q?rcw5bobqRRi53Jm2CAtHYQTP51d7V+B3X4/xPWeXDCPNPnAd0HlE7T2MAB5P?=
 =?us-ascii?Q?DyEt/0pcqHohakVUOVrj/f8TPcPs7ZgCIEvrofCGradzNYygXPgmxDhUW2ep?=
 =?us-ascii?Q?kCc/xNn6DBnmumv+PuxO6OozR5Em16jp3ugmWC6M+5zJm/h7fMnahzn5iatE?=
 =?us-ascii?Q?TYBPXFzMYe9V1Fppo+5id8IPvLkYQ+n/PbCzWOMdE+FfIi63ldjSIdEVLtAC?=
 =?us-ascii?Q?K5c5/8wTaFtGSQy53c6uD6oH1HOXxpBzJnomU0XZFw7rx6gmFmCq1NrJPCBW?=
 =?us-ascii?Q?GQmwAge1LG59I1Wg6TBammW4c9ie5DnNa60ylakjjsdmoSoIFTrlsUed8pZv?=
 =?us-ascii?Q?ZVHqOotC8L0oMqyHGrzQ6IVH+hsu69Jt9tQpkkJ1UCGPuS9gM4vdDbjQSCgy?=
 =?us-ascii?Q?epSi42GTjzwpqvfOVCa1xQVYjmElo/HW8rWTzGo/iKQwQjYRdolutSjxwUWN?=
 =?us-ascii?Q?Lw2P5YYvFVWXCC6bk9u83VBC5yOh0UejJQHB9GVfMUOtBK5zKWES+BLpv7zS?=
 =?us-ascii?Q?f6QrE4/BMiuLTo8vOoyOO8L1dNWF4jE/OheF8NHr00r8T8ZbIR6URrNAsXK8?=
 =?us-ascii?Q?ADgHWZvOUOKs19AyZZrjlCC9BnD2IjjM0TZxOgakF1T1/0U0Nf2gwTRsXgAn?=
 =?us-ascii?Q?PVv4YXI78SCuwakX/ts=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31634fa4-90ef-4a46-2482-08dceecb7921
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:48:05.9327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuR5Yr2sIo2XXslTAngQfuMndgthQkRO8Jk8Qyhvlob77sijtbtrFm3/fASnyAJg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795

On Thu, Oct 17, 2024 at 09:43:22AM -0700, Nicolin Chen wrote:
> On Thu, Oct 17, 2024 at 01:41:23PM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 17, 2024 at 09:28:16AM -0700, Nicolin Chen wrote:
> > > On Wed, Oct 09, 2024 at 09:38:11AM -0700, Nicolin Chen wrote:
> > > > Add a new driver-type for ARM SMMUv3 to enum iommu_viommu_type. Implement
> > > > the viommu_alloc op with an arm_vsmmu_alloc function. As an initial step,
> > > > copy the VMID from s2_parent. A later cleanup series is required to move
> > > > the VMID allocation out of the stage-2 domain allocation routine to this.
> > > > 
> > > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > > ---
> > > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 18 ++++++++++++++
> > > >  include/uapi/linux/iommufd.h                  |  2 ++
> > > >  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 24 +++++++++++++++++++
> > > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 +
> > > >  4 files changed, 45 insertions(+)
> > > 
> > > I squashed the following changes to this commit (will be in v4).
> > > It replaces nested_domain->s2_parent with nested_domain->vsmmu
> > 
> > Err, do we want to make a viommu a hard requirement to use nesting? Is
> > that what is happening here?
> 
> For SMMUv3 driver, we have to make it a hard requirement since the
> invalidation can be only done with a vIOMMU, right?

Oh, right yes, OK

Jason

