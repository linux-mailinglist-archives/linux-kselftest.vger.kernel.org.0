Return-Path: <linux-kselftest+bounces-19349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567C1996A08
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 14:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EA528757D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 12:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABB2192B6B;
	Wed,  9 Oct 2024 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Su4VTRAg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5EE191F82;
	Wed,  9 Oct 2024 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477082; cv=fail; b=gdKrj7l3qIOq+UidZwejrShZ+5n4c9+whqC/7y8o4DdCNk/n5oWreuksOXyqlzpXvWPmEk1yZXDGxAMKEvcaCpMesmPCP6aQjA8UaXpXQJrnpuKdRHZzlyGkI8ClylElXCzTUQtkve32r9ldLT741xJ9NKnkJ8WQijwxa4o6ZtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477082; c=relaxed/simple;
	bh=14ObNfEC7FsCHsG0MJoJC2eTDKFr1oY+daAzx1Kqhns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZfCRib18Fiz/c+kmxqbJt+sYiTvW2bbfQAbTBqRs4tcgsFHiipQsrcS6t3rDqksPUUFEo5gV2EIBihoYbPtFgSPp4U9L7XqnJ35Ss+PQw+ji32OmpHVYDlahfpHg87cu0r0UV70CLtXLxHBL0YVtc8KrirGqZVuFrFZ2SipcbpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Su4VTRAg; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZbRAisb+bcyW8FUG5pHV+WzbMRapITvIg7kNCMT+R1hyr29LJqRy3D66FUkMxwl7KEO17rqf254e2aR6hycXls7YdskFAEc37J/oHjHoPL3v1guFtJ8LmLHPjTk9RdwqhfbpkapHZTxTa19Fk4+t+LhxUblytjCiYFxFDkz03PXWI2fejg/9oynwAmNWvSw0TUBzifUrLEOTekIFsihYcGQgRle0WrQaKt3xnnn4aWhYk8SCC3fwdpvTtqfWV3Bz2BS/KFXooLbLs7jJQjbP4sg99Y0oYS9JNT5a5RbS60HTGECZcuR96Mx4Mbni94nFcIk0zwD91AwfSXjnqX/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+CbsK4y6cgegEQ0ZUeimvZo8WKVr3o0uDmxAZjKSB8=;
 b=JjaxRONFJMaVoASXNB/ARXHi6Rt9x5vUJ8pS5+xKw5hOrIeqTTvrD0qmBKxhePAwvs7lwaRmyq7QmGmFSpGyJXrpb3QOTBMO0plGhlHexAyAfyzrjzMzQkoLKAVReqRUshDdLkKR3jqTxahjaN4CktvqW0kKMszRRLAMnKyhaETrHAE0TJQVNegT6v5M3cELKZVVUnb8O/rTEDifApL5AVw845tWrX52c/XK5z1Nmz0Cfvy7/w3P5MA7xbqbiSmXZvbDzBqr0dT5y8+PvpBIysy4Yl5gB8U/AryoGuvdQ1ZcRkSyzDDVcfkozeM4WSKk1wBa2yiWLTvnbC2+3khR+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+CbsK4y6cgegEQ0ZUeimvZo8WKVr3o0uDmxAZjKSB8=;
 b=Su4VTRAgb60iDa0hj2INcHdVdmwCYKw6F9yS5MIRaJU08CusV5ECBJDBdepw4z89AJcMHT73Vs3+Qg4C1rxp3Bgdu3+GXOyNUG/aX+BqTASvXg0n5M496ymJU2bouM3dSCImFnyadN2XLSmV+w4MRFIA1oxo3YdvO9SO5G2Bo/eWrQKP8A11cnqqBaT1nyjYvGi4EfhM2Medz+tNxk/y5lpt8+j+2f0fc4P1rsk8QKNPLZ40Pj6pxm6xl9/AWY72VNPm0Xi6iYikC1RXjD2jFoqef/QehJND9QJ6YWTSgwm8FJmO4A051jGfeNjra9sCrnZgIFjzSnL4YHE7+L1dsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 12:31:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 12:31:17 +0000
Date: Wed, 9 Oct 2024 09:31:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Message-ID: <20241009123115.GG1365916@nvidia.com>
References: <ZvRcskGx2u94Vs+R@Asurada-Nvidia>
 <82632802-c55a-4199-b685-8b594a8e7104@intel.com>
 <ZvW+BoovlyJ/wziX@Asurada-Nvidia>
 <ff35efa5-ba7e-4974-94be-59bf794a14e3@intel.com>
 <ZvZRapZlAsEGDIge@Asurada-Nvidia>
 <8440cd72-ced6-4887-b724-ce6a1650db13@intel.com>
 <ZvcZFDqu6Xf5P0Xr@Asurada-Nvidia>
 <380fe58a-934a-4e57-aa18-f4e0841b5fb4@intel.com>
 <ZvsfViW28vF+v6uN@Asurada-Nvidia>
 <e2567891-44dc-48d5-abd0-e3fcfa02a4e6@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2567891-44dc-48d5-abd0-e3fcfa02a4e6@intel.com>
X-ClientProxiedBy: BN0PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:408:142::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea54d2c-0d50-4f08-1359-08dce85e454b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YIC9n4Xb9g/h7pn7OAeLXWSY2SRZvNLu8c8SY3fsvwINImzAhKD8V15/DI9X?=
 =?us-ascii?Q?Q7eSDk2ZkStZEft/qzv0L2/HZQIxvBGWyvI91v/i+pqqaHZa4WCW9JdQRdJi?=
 =?us-ascii?Q?yYyo5F4y1FBN8rpKtJGa02QXz8/wJsaJkdHEydjWkyCSLyOdXpYVZcLnqZ2H?=
 =?us-ascii?Q?AaqQkvAKG+CrjXrT+OmFTa803VoTDIr7T7il/ur6MAnXdMzBoulmIYMRk1f4?=
 =?us-ascii?Q?TFCBVdPdSc+oxSzcdYH7+LfmihfU/yRqMSlMZuwDenLuzpedmVsUUsDLSS1u?=
 =?us-ascii?Q?Ku/i/gw/5mB4A5cGOKGPy8r4cAMdeKRVmsw6GewKQ+lykEF5dssJFASFxNuh?=
 =?us-ascii?Q?+m2z2USOSlQhGtzZ9DpFTs1DByq9j1Z7MNiDJ7w24VSejHeqo4VJgqv1kYeA?=
 =?us-ascii?Q?V+3krzHxM2Y3z62TjxEvYm26inN3mFcYtgeneIlmeRP/mY+e7otyBN+/0rN2?=
 =?us-ascii?Q?HlEQW3lIaNdR/YnzAi6SxgUy5+Ai1oTFS2mpzMDUgdL7nWQLNM39eXcclujm?=
 =?us-ascii?Q?zAKcC7AZmZNJkPdshn9lPInEEVXQ9DwHZbKNBqEARnYSVtZtos9XO3kQ64Nr?=
 =?us-ascii?Q?p7RQM3vZKNm5fzbYBUa/w3LAffUB6wOF1L+H/fOzjv8GG7RLoDYZb3UXSNnB?=
 =?us-ascii?Q?6J8W75L7Ren4XB5mit6xNAW1U8p5PQCWFTzKQQhmwqlB1Aa2UzuRD671y+Z0?=
 =?us-ascii?Q?fX9xnuU/AeD18RrijakJsuTFnEjQGBq87tpf6Go6lBv8+WMw+KYaIy1o3h8H?=
 =?us-ascii?Q?sOTczclEFEPzs9W1c3+B1G7Smk8nZ6Rrxg2roGesPh/V7HsMvNMaAMf2Na/+?=
 =?us-ascii?Q?Et7tCc4ByIgDWmsP1KA6v3mpokWoMg7D8napoHdpQD1m8akyrsosf10eXZYJ?=
 =?us-ascii?Q?6ehuhX15Abd7RVuDpUomTGKTzGxOAjfRa1zYRHXJgOpARfNWfQw87IWSNfJM?=
 =?us-ascii?Q?PbLBSXdlerh98+QdurLcyd2Q5lrPn+nvDfBasWqkozIw1xLn3VE8b9pIdWQt?=
 =?us-ascii?Q?Sp1uXG8+X1DFOe560xOG4UYjy68Nw4PWYUJwdDELkpHTirYI+5O4+p5JCPye?=
 =?us-ascii?Q?LHHhsjPfhJPj5BFrnPZ+o0bGlkwH+0bxrmpHbIZ78vUORoW/WA8h5GfnUeFe?=
 =?us-ascii?Q?TbLUKHs4mD+RwVDVIxJkOXH+6Uzz/bJ1TCb5Ow/q7+Fc/504wSnV5cZRCr43?=
 =?us-ascii?Q?HhXDRb6isY3lYdRJdtZ0KSKG5xNV28HsYqaoof4PiGopO1mNZ5QYY/ZLCs5S?=
 =?us-ascii?Q?U9+KBAPq5WqbmqQ+ziMSjq0IcwmXGukKh/9VtePQeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NWsclOJM08G7xgYBMw3cb3f+TQyzqpHBPU3/WlB4ccc5vhIPOhSb0tgB8mDo?=
 =?us-ascii?Q?bQLQ7iT+Xpf6bkUuDyviS2wuLxHCVFmaHyB/aIka1+vhqNPBP7FLCRtPyhBt?=
 =?us-ascii?Q?qbD36JmFFIZCG497Igyk0r3bnK/lcXMYYq+rH3JeV8QAmO2vr5py4FWGW45a?=
 =?us-ascii?Q?y0zqsNKtbiqfpRUpHVsGxIBkhPkk7bIY+tq21tryWvJEVyyhvDjPeJ/uGiuH?=
 =?us-ascii?Q?7diawErc9+vDCmFXuuweLPQj69/ClrYG7ISDZthxrU/mijxIIc1JY4rUvnOm?=
 =?us-ascii?Q?HXu1sMXiB4tKNDzeBfowSlAkalNHWvKIyT10K8BfWx5e3CZ0GOGQtxtAtnv8?=
 =?us-ascii?Q?uUQQplJqPUaX+IgtMMoSQF71kbem+Ubx6POJ9pKN0OHbIu1gR6AQifBCTPbS?=
 =?us-ascii?Q?RAMtjax8QndUI7xqf37p2BPFQIUzzQzaXtGyTwkaX75Gvtlu+EZxkLVlNMA0?=
 =?us-ascii?Q?e5jjpQ9q8mUHJ5JZmT4N3Q4NeRZmmzVF00gmNoG2sXGXSwKLLWlUFWLAchlH?=
 =?us-ascii?Q?CrX+jvBgzewEK6AaqMv0JL4RwFaNWv7bFh9HPHaDbMvBlmpyTT6zYXa3rvNM?=
 =?us-ascii?Q?Lznbnku6fJ9wJcGH/+OeTqXmKqkwp6HXD0YI39CZgqP7u8P0M5kT17uxS6+9?=
 =?us-ascii?Q?07U7fIz7o6jGQlz8p71KrLdtUPFEMFuBcjzUEZVjKiNlupsASGiWGiCxe0pN?=
 =?us-ascii?Q?WBqyzdhQ/Ce0A4OOe95lTb3lTohNy3aq8By/JudhnU3Wnvvdj7vib2FNAt5z?=
 =?us-ascii?Q?pow6KY9jMj1h2+kTXfp0cRpE6JFk3h9AH1+/RAmLIU/hplscDIH6sVwLgy9w?=
 =?us-ascii?Q?h03KusQoKlD6iulCAXau4KxRnS530hTLFBVTsehVIBPemRYlQ0dlbBh+7w/y?=
 =?us-ascii?Q?kFSkpd+q9dsvbb1AMhl4erLFO0uIWGL94wZ/EnOp6+FguvlTQ7w1OU4XZoM+?=
 =?us-ascii?Q?+0g4Ma1hIm4ZnX3sV34jNE6GjU1lC0YBZ1m2ooX/0dCcru8+vCH8T1wuWg30?=
 =?us-ascii?Q?a3Vt8WIVpWFfbReIleWERIWIT2w6yPaxSb0WUp6VDEgqGdBWxuuUsbLA+O9I?=
 =?us-ascii?Q?YxdbgK01u8LfJie/fr1mX8yeS/vxmRKG0r6PPKYinqOGhTmPmIn1pYmVYaW1?=
 =?us-ascii?Q?1YCs982JDV19EM1+HeSqWWICmwc+ZUHE/eV767iaF/UEVADUrJfhxbgcJxJx?=
 =?us-ascii?Q?BBNmgsPk7HqqR1ayckUAMHOGua2VQYbqZNA8PW/41yyDC4CuBEcJ3sX2kMqr?=
 =?us-ascii?Q?yQ8T/Sql51pJQyY+N0xE7ek+HQi5kE8taylZAhLJtNdI4Tvcs9vB8CPNN6/r?=
 =?us-ascii?Q?NwKJK1lysHoTFmBUrSpneyw+ng+Yot3h0hsmSusexdjJUoKKFv0rGSLWHYTX?=
 =?us-ascii?Q?noffqG5siF3aXFa/PBBBsiT3MEthptt9CW4VT5Q8cGs8PEnOoSjd8q4Vq+lG?=
 =?us-ascii?Q?WL7c3cVVsiBMzYsTxqmzk64ORPCYlnAr8du8GIbnYhADxvuWpyfOtm2eft0p?=
 =?us-ascii?Q?MWss+9WYit5tlt2wtG442cXYPD46tvKRDFtiJ/wSbyDQQsmDM4KTsiXkN2NG?=
 =?us-ascii?Q?n9Lu1NPSjmnoaQKm19k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea54d2c-0d50-4f08-1359-08dce85e454b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:31:16.9469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zy8IPfyzU/as3vfYHUpruZr3/LxPNw9hxTsxLSAtTMgmJOH2oGZiXrCY4Z0RLPK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207

On Wed, Oct 09, 2024 at 03:20:57PM +0800, Yi Liu wrote:
> On 2024/10/1 05:59, Nicolin Chen wrote:
> > On Sun, Sep 29, 2024 at 03:16:55PM +0800, Yi Liu wrote:
> > > > > > I feel these two might act somehow similarly to the two DIDs
> > > > > > during nested translations?
> > > > > 
> > > > > not quite the same. Is it possible that the ASID is the same for stage-1?
> > > > > Intel VT-d side can have the pasid to be the same. Like the gIOVA, all
> > > > > devices use the same ridpasid. Like the scenario I replied to Baolu[1],
> > > > > do er choose to use different DIDs to differentiate the caches for the
> > > > > two devices.
> > > > 
> > > > On ARM, each S1 domain (either a normal stage-1 PASID=0 domain or
> > > > an SVA PASID>0 domain) has a unique ASID.
> > > 
> > > I see. Looks like ASID is not the PASID.
> > 
> > It's not. PASID is called Substream ID in SMMU term. It's used to
> > index the PASID table. For cache invalidations, a PASID (ssid) is
> > for ATC (dev cache) or PASID table entry invalidation only.
> 
> sure. Is there any relationship between PASID and ASID? Per the below
> link, ASID is used to tag the TLB entries of an application. So it's
> used in the SVA case. right?

Unlike Intel and AMD the IOTLB tag is entirely controlled by
software. So the HW will lookup the PASID and retrieve an ASID, then
use that as a cache tag.

Intel and AMD will use the PASID as the cache tag.

As we've talked about several times using the PASID directly as a
cache tag robs the SW of optimization possibilities in some cases.

The extra ASID indirection allows the SW to always tag the same page
table top pointer with the same ASID regardless of what PASID it is
assigned to and guarentee IOTLB sharing.

Jason

