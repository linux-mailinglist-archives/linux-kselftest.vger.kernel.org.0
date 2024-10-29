Return-Path: <linux-kselftest+bounces-20999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC569B5236
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 19:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7E91F246AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 18:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD9B206E65;
	Tue, 29 Oct 2024 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="howAgKlA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE58205E14;
	Tue, 29 Oct 2024 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228166; cv=fail; b=IRE9y8Y9mWG16ebT5eYjROCVYG/ZT5xpg6bfw9ZaVev/SUHx58E5pO3LYMuyMoQximQD77yY3NuxGbXi+LCSjEKqsHYEsYIvv25So7fnur8Y4ZrGT47BE/fLJSX0646d7Xg6DAoIm0yfxOC1OVPSZnoC8Ayxy2+GjM+x+j2ZLXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228166; c=relaxed/simple;
	bh=MSgE0WsduLjlifX85aiL6WIrpxtPvWBW5nFPfEUvjqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=If9dkcrCiDOOOq6r8CBqMXtX8tn8DwPRYPb1rj9rb6A5RRQ9jL/zhJ0EE8OuinNtyTOzB1AykoC7CPTbfqiHq21Slt/05F6v9NQcsZ7eH/ldJMSeH7bRjXpWLUoT5uUWJdNnH68Dv8R9pf+M42yg1uwSaWFc0szq45joOTdlL2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=howAgKlA; arc=fail smtp.client-ip=40.107.212.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kok6E6P3n2csZBvDqOuIn4Yk8nFRLO1iItQ2Kbo4ux40Ayfl6VSmXNBylNhMS6GiLOWwls4tGkIAl+Y+dIQtwjnsKmNwm97ixK03wrvIc5xCo/ZDPwjGaYzV01fouR4SyrhmP/oDQxTL1Pf4M+iMllXBH0sOWSfgoM/bfAx7y4ZnKwAIJ7I6VuyR839nJcnL/Pgv5I9CdFCfIppXrXoYGiITLw70KqA666xdPCReRgP7ILGwcczPw0UlO/uGGprW94YjsXPNktKas+6dBN4CEAjKrHiaUTDZFwTSbKEsf+zs8eSHHXTr9Cxil/jYHo1olqsaMxiU1W/ZHMXGdGCm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiOB2wltWHCN0fjGbJT/S58hg7bcU1SfsLOXajfWGjQ=;
 b=jIB4uwTBS9JmfWNa9Y4BVXUD/tFTi/p+q3xEAj96nDgNnlCZlqan8o22lxBC6b194XsWRTWRU4K/X3auPp1aUHkksJrJDNgqVsm/CmNjopkr+JTkShYcBipFaq0Or1TvWiRVfG58KHrWJzKe5Gk3o9nqmVl1O4z86W8fcuDu/ROFhU2Gy60W+LF4Drj+wQoeBtg+6vK7lvOZjJvt6x5AHIKtHOQdPldcSY45rBRppbmUyS1hyNnFSlSZNsNA5t3rBebzQftxfvkFr+Gz3TVPbnDLVJGKhaIR1Hr3BPEmIkKSXHDmVeVF1RYqfHYH8ur0i9jn95aZMgUhDJUCISaCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiOB2wltWHCN0fjGbJT/S58hg7bcU1SfsLOXajfWGjQ=;
 b=howAgKlAHu69Z9Lj//2LVubzxVUbLJHwvJSjncUNlYor8lJpSTXwjSbJHBUD4sy3aobxmu7l12WB6u6bxwmY2DJ/73kAcHVdOM6gEjrEqYvN5vWOQYMKqf9eunMyI7C326/pcPAmy8++5WGxxnEF1ceMDZDV6xEOQB86/hHUwp3lgpNYzxDnV1vqND+FHoT3f7xjhHJY+tqzxEpsPV2zxF7Vg+EojJCHV8gW+LtAcoOs4LQVStI5ll2KsG40ZOdjpCmHViYA3aeeFqswGlPIc5ZC6ihTEpbCxdquOX9qizZjygKltf1oYlxpFW6jLe53TeoLwrGkq12aWYxjHMEg+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 18:55:59 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 18:55:59 +0000
Date: Tue, 29 Oct 2024 15:55:58 -0300
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
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 03/13] iommufd: Add iommufd_verify_unfinalized_object
Message-ID: <20241029185558.GZ6956@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <e99946ea0128370349373c94339d465397946137.1729897352.git.nicolinc@nvidia.com>
 <20241029144907.GB209124@nvidia.com>
 <ZyEKvcpgUsS1nCEg@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyEKvcpgUsS1nCEg@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0445.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: a971ddc2-7ec8-4d80-54b6-08dcf84b53bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EiFngKcl//n1iL+47ODS+o+rQY35O7cKRBqh9sL/umQiwYX89NGgb9HBzyVg?=
 =?us-ascii?Q?9lz9Lzs3M0qJ6eiQjXS1sDJDM5KRX99YmFcUF9GCV0g5WO9DDh7VHaLecHYR?=
 =?us-ascii?Q?c2A0C0Xmu8ZljD/54VVeXCV13Mv1/YSZetXQCoYC5uWIK1M3uJUpTOD3ZCqy?=
 =?us-ascii?Q?RiDrBpGRnj6pJNGBpqjt/mqT00StASTwqKnO03PXlA3wmLss4SuaIRcyKgS1?=
 =?us-ascii?Q?pQnHrNgTS0xi6ZcSI1qg74MYuEy5Yi59v8lDWHbfN0nMjoj51bIYh4yc5kr8?=
 =?us-ascii?Q?uxCeCUYIrvNgVNQM4jTjkOtFsPFdj0JtrNwux1u4/9OebUm/X9MWuyH7rCsf?=
 =?us-ascii?Q?t5fFkRWDx3rVaxPM/A4PmpcxH1zCYkBgvEi0/dbHPRi+ldluY58NsI//jNh3?=
 =?us-ascii?Q?QSPcPN43ISIinhzMJHRPPjN0lWe+XD+TNTpSat1ZPtoy2Qw9otp+8Vr6CgMc?=
 =?us-ascii?Q?GQRZGpbEQAGJiqPoeg5QgXtYUSBrAG5CsmQpRmNRFji4xEpgHYCvbSEgXzKk?=
 =?us-ascii?Q?tUm5T4f3MnofVI/lz69fMdrx5QkKhQsjfuiFC5XwP4+s8X+zOvmKtAGpI0sm?=
 =?us-ascii?Q?EXOEC93CR+rgmeQUUJSbhsy91qkNXRNViayUSHdFhsDtGYTSqeU1/6TnPkqm?=
 =?us-ascii?Q?FmReuNtl/cKBE8Ntb/HWbNv4AN0DjvC0crlqR0UpxI2CCfdzexLqtNzfU8XF?=
 =?us-ascii?Q?FdLFAiyM3fffzIF+hmjGnkOzh89tnHn+/t7r/IzYAeWomGyQ+gDEtrIC+nsc?=
 =?us-ascii?Q?pgtDSNrSGxbhCQu6gULIqLnKvlphcwsivwztnagQEPOsziIs/c1kRyHrjras?=
 =?us-ascii?Q?pVnXt3jQrll53AbgGH6AMsSCqJlxRfmXOKSfsw4FUa3tJqWE1+hiYNnnp1Gv?=
 =?us-ascii?Q?mSKYSicSPXbfs530OPMTvsIDtFDFUlzlF1oJKo645dJx/SiI+MMlANBV6hvI?=
 =?us-ascii?Q?ZZcMyAM4WbYN1e3qSoM2yQeOeyana8XJPaODEcu5PYBH4CubsGu2SynCECTR?=
 =?us-ascii?Q?HInXsZuEMzXzQbXrdCY5ToEqfgPTfGY9Xfc8UzNW7XeN2rCxKAJKVjZb8lyW?=
 =?us-ascii?Q?1PpEmh3zzF37E7irt1ehrnQlolSzrNCJ+fN2PvppF0h7pgig3gcPipKuz6vh?=
 =?us-ascii?Q?VcubRfLUGxQwy79Pbh814s5+uGhbq7Y3wRNHl9LFnXeDCjPMM27m6eqxXdMy?=
 =?us-ascii?Q?eK2rpYBdmFTSIdjg2R7WDjK4O9FLFhRbGnlMT3QxA/bqrSdt0kGY9eJy7Q2b?=
 =?us-ascii?Q?q8iKLVtSXbs+a1LWFeYhQvtD4r9dVs1jObNC19J0jDWrbWEWkJOx3tH2AiUv?=
 =?us-ascii?Q?MqjFszxoc+4bTURDKmET3ZZJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HbpfqU5t0hLNI1PWuPfEozp8oc02GMZ4kEZrTYbImUeGyYLfOooZLJovVkr0?=
 =?us-ascii?Q?wgV8yuFtUxIOl62lBoDXOKTVRZvTsT5zP9Hk8y0pDkICWLJTVEexKuB8tzLv?=
 =?us-ascii?Q?/Wb55U9xS3GcA42ZA3/g3hZZ1xrpTLAq/JLdasAlt6GqRNaZf+oAeFKzrY1K?=
 =?us-ascii?Q?AMkwBJm296pXwo8qwLGNbJRPwLqN0vCG6KsU1H05bXJq0Tu5wH8kXcMSsdiG?=
 =?us-ascii?Q?tjzDYjgS2TaFGlePCaCD3ThwfGjLuKG5wtsJbu+oPO42VbPILOwKOBsWHwdJ?=
 =?us-ascii?Q?2pfhJNWHvUBEfL/FhzvqP8UtwXeTZOpjojE/AeZNW/2LBXHe883sMyJErzLX?=
 =?us-ascii?Q?scQ6+q3ZJ9wOXnYFXfP8OA9Tnt7/uyw/ylB48K3OHLhavjznBdUoYOwiPz59?=
 =?us-ascii?Q?bgbaTlWRN7545UpsS2IH21ZCNMgIG64gGWucLFX+22NQdn6NsaonP2it+TU4?=
 =?us-ascii?Q?6tMOS3jHE5WNdKih5sMLnVM09o19A3Qfzm0PGlwRpTSvt5iY4kAQB46ER1EI?=
 =?us-ascii?Q?08MKOv49O3CArUQCbEx3RyJ0/ZFTulTIP3/vOxD81ErIupel2d6UWipjV2KR?=
 =?us-ascii?Q?NRyLRrTLNRZHnZcf/UsikWXbE7qm2gblLwWpYXvB7wbabmat4z0A0Z6PcaLG?=
 =?us-ascii?Q?xA4l7saMGlKDc6KSGc5avd39ej6EflCqU+/SRMtL8P2xFuiRBwLmvFm/vt9O?=
 =?us-ascii?Q?DItpqXhPL4Tfc9qNUXlfCY/gplpGnLgrBF/Iwpb+z3BckDQnuF3gkswXu3Q4?=
 =?us-ascii?Q?ltcpL7q6e2+W+JiE7oGxOUqGvU8MrrdelYfaNDjJpvqleTdoVEopTf7QA8dV?=
 =?us-ascii?Q?G23FizILhpHwpOjahQnsS6bv4d9ZL261Lom/usgGInIQnah3N8ZhldAscTIs?=
 =?us-ascii?Q?r1PyPletpRATXCsvNugoeW0Nr/NHFxDc3ZL+ATOX1siGiV/Zu3KFQAizfE4S?=
 =?us-ascii?Q?ii+F4MKSntea8mujltI9KiTy6SJyNjm4hT/nD19RcfEKyHRl3ASO8+yMxTuV?=
 =?us-ascii?Q?Ah5NpioAYC7yw0ze/6LdoWStXiqrlR1WjgnRLN/paBaFyMXSeOySHkvZL1Kw?=
 =?us-ascii?Q?QcyJaCFacnbFiCarNXk9YcaBkKax2zjW4xdiLoEJxkLyIGNfCbbfERqjY68m?=
 =?us-ascii?Q?FR8WvO04UArtXccp8Elsvz/j7qLcI2pNonLkf//+orSpW0lSoiYPrMmuKShJ?=
 =?us-ascii?Q?8XhjLMVWC4opODDNr2uTWlsZt6fe+51HXXg6ta6cWwSuqQMoifC/mwrUunH7?=
 =?us-ascii?Q?rjxjz8F+ofpxYfHIaDdFfFIdglzA5pvmpXVF62L1PEqcbRA+ONYCDuKWY+Mj?=
 =?us-ascii?Q?Rd7XPlrG67/zGphE8Xt+n5hbuaylQa36WAO2zURw76QGf3/0U8uNXeOKjLJ0?=
 =?us-ascii?Q?nn8GXdQNskaCs+g1o8WfGCzNW+2bqgI68BLKRRzPjy69lNKqDNd/X8Gx3nS6?=
 =?us-ascii?Q?u7sdgHR4rsSVj8aTAqGdD0yIKMQBLgXCS/3g9dlyglBGkWNjVshKGFvFdlkw?=
 =?us-ascii?Q?GhlV1nl78EzVq8JvYnnsCXV1/Ii9pg1/ZDqyTWV77SGu3gTusONE/kmJFn7n?=
 =?us-ascii?Q?rtL44Brfu2YA9SfNcoE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a971ddc2-7ec8-4d80-54b6-08dcf84b53bf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 18:55:59.2746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8x/B0slRZQiaw/N4D+TW2J+ENlmC6+470DZx3K4y46uYydmDhwkgVYV3Al/ym9zZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739

On Tue, Oct 29, 2024 at 09:18:05AM -0700, Nicolin Chen wrote:
> On Tue, Oct 29, 2024 at 11:49:07AM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 25, 2024 at 04:49:43PM -0700, Nicolin Chen wrote:
> > > To support driver-allocated vIOMMU objects, it's suggested to call the
> > > allocator helper in IOMMU dirvers. However, there is no guarantee that
> > > drivers will all use it and allocate objects properly.
> > > 
> > > Add a helper for iommufd core to verify if an unfinalized object is at
> > > least reserved in the ictx.
> > 
> > I don't think we need this..
> > 
> > iommufd_object_finalize() already does:
> > 
> > 	old = xa_store(&ictx->objects, obj->id, obj, GFP_KERNEL);
> > 	/* obj->id was returned from xa_alloc() so the xa_store() cannot fail */
> > 	WARN_ON(old);
> 
> It feels unsafe to carry on the iommufd_viommu_alloc_ioctl() until
> iommufd_object_finalize() as the function would touch the returned
> faulty viommu pointer? E.g. what if the viommu has an even smaller
> size than struct iommufd_viommu?

This is Linux just because the output came from a driver doesn't mean
we have to validate it somehow. It is reasonable to be helpful and
detect driver bugs, but if the driver is buggy it is still OK to
crash.

So you don't *have* to check any of this, if the driver didn't use the
right function to allocate the memory then it will go bad pretty fast.

Improving the xa_store() is something that will detect more kinds of
bugs everywhere, so seems more worthwhile

> I think we'd need the same change in iommufd_object_abort() too.

Makes sense

Jason

