Return-Path: <linux-kselftest+bounces-40330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5453B3C225
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 19:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB203B7F20
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7855340D9B;
	Fri, 29 Aug 2025 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C+GBYFKK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B7338F49;
	Fri, 29 Aug 2025 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756490324; cv=fail; b=VA0NxZ5wS1yADEqN0SrA/0mVHP/HqjRoGEgZTbakZQKmnUJAY6vJ+rl82X4uiEiPr8DWzzJSw1jp0NYwhhwBFTsGdcgU+jchUPzMzex9VvF8dMLEVL3cLE9NNWXeFCmkA491zqbqGVp53WBCewHB72lFvTWjS2DKIXhGyYcRAIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756490324; c=relaxed/simple;
	bh=/L3eUlxckGxRK7jkit6y1Vbtnud9MIAecNtpEQgKHrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EBQ2EMYlORDWUiA9WA1vkX6fTXl7gVA/dfDnRWrw6EfWkQHzR1d2uFdRkOI3Kw6FKMkZWISDxv7VgZg7aPZcEUGDuZ1eHIawDUt6lweN7KbtPwhXeKSGcTRIb1OyEQNMNcagJAAHBZeDraFbgPhe2UGuTT+/Lqm1xFbjwI7+jrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C+GBYFKK; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctKYJ5mCoq+iW6kPACo0lMR9ewSV2TnYs9aXvelycehoyByGLp1F7p3r3j7AbZFSWlghFwIm8Q9EDw6atNPyyMLHZcSTrGtVCrcvtUM6L3Eh5V9+BEwnmIEeMR3LHIgML3kOtiyh+KPdkaJ13nDp02f+SPTV2YEiq5L1N06p/Bsj7EpOI/rdft3KjrsAcuMJyMsATvm9NNfeTzDAx8gtuMtdni4NwCZ3rmfRpi31oe+2K2/sSaIUL1qlpT7i7Hz1Zr1QJIXA9LvXPKQEaIRyCJ21JPsDxlt31pWzUXs7y/bsCr8EAeCf0rInQtxkeGIEQloljCpkIeDy5GJpQIHilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sr4VG/u5fbl1jMX4OAFRYmYbQmmcy7GC2BHdp0xVX6o=;
 b=yWlIBiuCSxGP7TQ3oL7eqPBBxH2TVW/rJEuY7jtrLtwt09r7xSSuPRSBFHiYF6+PMK/FDS1CFe/u/iha8lj4TVNcsMQDB8BCH1bXRVWtE5nbyAwXeoq3v/NjEZMrtnm02CFRBFXvmRPCAUEQSB4kngdbEna9f1ftNhPiRT6K/SyeUPpOseLOVG7pMn1EkCGrZnoQFTCkxSvwMcNQkkeFuSVs+MtPpoblc3yJUQG36AVj6fg0x4guMeESfs5HocTTgRi3nFwFaOSzD2i+vJb5PrQa0mXBEFh+4GR9KfMbXwt6Es26e+nEPmUijdAqIvaAytsu1bWNd0w0cLvG6kJv9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sr4VG/u5fbl1jMX4OAFRYmYbQmmcy7GC2BHdp0xVX6o=;
 b=C+GBYFKKZCY9QZeDEkuw+I3rPTXz2+GNaTNKkBGxvhTDPGjgaWQGEM3akgvB6d2vx/Lm/Lur8mTFb644wOoUBscqrjDNAC+oOwN5bX1neus9kELbYppPVDIYQiw8WHwkJnqtGNCsHx05shnorcUP8P2MTYt5psN04yT09nq0nqleld6WYjMZt60+aPvIQvhw3eOk9kyQet5kaHQezCNVXioN+WWDDymr9GJ3eEpguOOmI/MhoWVUujhK/ve6Vm7npqmL8IG34NShtKDZvQhy173jgKnguLw8sLS4eLaFWJ+yamvwottJzkGiZI5/R6L/yqBNAC/3gAyDOilMciqd1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 17:58:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 17:58:36 +0000
Date: Fri, 29 Aug 2025 14:58:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v4 12/15] iommupt: Add the x86 64 bit page table format
Message-ID: <20250829175834.GD79520@nvidia.com>
References: <12-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
 <adf12245-08c2-4a14-bac9-2cf7a1bf8107@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adf12245-08c2-4a14-bac9-2cf7a1bf8107@infradead.org>
X-ClientProxiedBy: BL0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:91::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4b0ebb-ae3b-4fcc-1928-08dde725accb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mSzg1kAkV1u8udFsZ8OZ1hW/MN0TjHuz2qt8f7+cnsv/zjhd7h3K7IdP2Te9?=
 =?us-ascii?Q?5kJX7T5fEoBz4COE9w1uhCL5iqImjSKUAgacQTHqqYBRQwwWx9GadFTNlIRV?=
 =?us-ascii?Q?J+TmqTT6MtH5QfFg4fNOipoebEy9HUlyjbBoPNgT4UKbXs+wZvZtV81M7GPL?=
 =?us-ascii?Q?a4stD3bMcLs7kwS8tzauNMTtaG6rdnKjzLEOug7DoyXbcNjBWgdKvlJoudbd?=
 =?us-ascii?Q?Pl/YFCpg2eDiF1C7RmAy8hawF/9nxp/cgj9YplzjU3RRP3cipZMh179qUPIo?=
 =?us-ascii?Q?764S9WBLdL0STsWEf57PcN0LxM9SH8PEqfVbJsiG60IKv0dnJ1FwlgBYsMzF?=
 =?us-ascii?Q?kxYijHZE/lEMAsy51t3GLBd4BIMXnh4cWb1Jc3JujE1G56gWnHhk8pfornN4?=
 =?us-ascii?Q?doIl8qFZ/5GSu0r+3omFjC0IxDjAjisxfpZRqZfbxWd5Qm8cZCP8zoVnt0ZR?=
 =?us-ascii?Q?nMJMWSe/cKBVW4ftFvWf/ZceduuttF8ZhUaBB4S82drq030LPzhfhLOFQIet?=
 =?us-ascii?Q?EUlWLC0fiOi2vYYUfKlePK93HD9DLzqXPi6FWHMBEXQcaUkK+AAugCBV+KiM?=
 =?us-ascii?Q?7kASUfnOf+RBAfGyGVF6uEZA650pqxu8BgKy79n/WSkxFvZt4I0d7BUQRrY+?=
 =?us-ascii?Q?j87vYGvI1kV6uLlIpsfcN79+65ktZZoFz7LS1ZQNXpoZdhW679lmOvwT1sJx?=
 =?us-ascii?Q?daKbXp6Sdw31P9Sh6dT+6vWkZmOuIdbB8tNg1QC7fya0IBAsHiW1dTEOBWXd?=
 =?us-ascii?Q?BXkoXc7HmTLlxnkgaqFQTR47DNtXVEzWze471fgUgnxPaBN5uvhkNQP+YEpG?=
 =?us-ascii?Q?lwL/+UD3aZ05z56f8UJ9fw/L62yWLK5C4IBa1Zhb7ostiU9jWX2gDgGm6anH?=
 =?us-ascii?Q?zX+XZtB7LDdPsi9acVmT6vthHZz6cCVshnKjNWiP++9B2FLhtpQITHdlhSCQ?=
 =?us-ascii?Q?Gh7dAFN1zy4HLYJ/JP/vMr2kRK/8xg8aqYnDGhcpeUvlEHnD+C8WCpYlhF7P?=
 =?us-ascii?Q?iv7abKC9f3iQ5sy40VnTn05EGwFzt0vuUW3BTh8u57KSYBrV/CUI6SLeBIx5?=
 =?us-ascii?Q?lm1XhXmBSgwIo9Cw9zgQp7OPlbhsEhPMLZKsQ0V7Af0bFy6vmwxVQ945mA9X?=
 =?us-ascii?Q?TE0qArdNjkZF+yBcpOA5pXuuGlPh5FeP5tGUbk8Aedr8uyEilgDMn7Y/akcI?=
 =?us-ascii?Q?8pAY24ptAqRPPOvdETmNigZK9alz6eyhaZEYLGP6p+TXWOglpNHLp+tF4aGg?=
 =?us-ascii?Q?vji2C6VXuCue9dwxiVqn6mnyNl6rq4XKcB4j8khU8MdVWrBLfERsltq0jihh?=
 =?us-ascii?Q?2rfAXCkHEHYE3juwE6ZXnp0lNGx7dZDrk3mkSOhc0rafoN/8wJ8FOAXbCpOH?=
 =?us-ascii?Q?k3aOCtWxu5vVQ2GABzyj0WuiPW8YUekVYvc9H1fS4Gd5Leiy0i0k7Fbk09ry?=
 =?us-ascii?Q?KUKzsKFmQws=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DD2fWJFaON6hTAaXEWfCZRCQ0r55Vymc9S45FbeiIcLx+DcmBMUQEDH7lIDT?=
 =?us-ascii?Q?N2jwySEH9lHxw1iCRI18nR+0Qy5n8MZmwt29fJnY/WixheHvQQLeC9voBl31?=
 =?us-ascii?Q?6prYFf1Q0Nt1JKuSxiiINO2kwa6zUmR/dkV4gt3w1VHVEwGC2g+iOhPsKCPd?=
 =?us-ascii?Q?RsitY5y5xzLovut7dYWgHtkvH5M9SaXEo0YHd5VgEub4x0FhwL5QsJHGyeFc?=
 =?us-ascii?Q?F5ohvICdSBrrhjf+zykE7xUZXylFqKwFJFaYP2To1EW7pgWyN453a1J/iqLI?=
 =?us-ascii?Q?JCQfsadsXtW6nmGqba3f/e1WRHEfOzEjuRaJw8gOc1W+mI7sI1KquJRWpW8P?=
 =?us-ascii?Q?AiHqMil/04ceWavu9Atg/c3iT/Y+NRbW6wVPlk+Gm7gah4anKDiVfqVZo3zC?=
 =?us-ascii?Q?c7/5lRNPNugZ9JPN8bfnhHw4sOv1mdt3s2W8CT/24k9E5dodNeVIs9kStAe1?=
 =?us-ascii?Q?xnM4OrDwGnCdteChyCS5KIcFvbg1z9YURzgcjNlo1a8vllOaIGwZyn/T1jzu?=
 =?us-ascii?Q?rTJ6xpM580HgT/hzoYcSG80zq0WKSprt4wQS2qX7Njsmx31wKndBKAN4bc4Y?=
 =?us-ascii?Q?htPoKZXLq1KpzajNei3kOGMJBG2sf5nRh4Qe7PjrnX4gb8lFdtJN4ZlrlTHd?=
 =?us-ascii?Q?gA0Hp545gXLvvQ1HujAyj0SPx+Jt/Vhl8nfKOKQvSvqcDCFhAxiK7dTFaJn2?=
 =?us-ascii?Q?UfV1W5psC6NaUPVYalGZhP6G+aAOv1bXcBV6avB9PO7vtKKLlahK5vin1bMb?=
 =?us-ascii?Q?qc/4HDvyG7UVJDCHKF3sPgEY/ShfF/T0Q47KiU4jG6Hou78yw9vfN/+g0jd/?=
 =?us-ascii?Q?j9AdkQKe746qF9uhszX3QtodQ4nsy65ObPHIeqZM+7JFb7QGrVVhBe5mf6Io?=
 =?us-ascii?Q?jPnVMttEV/M5jPzI1R5rq9yN1ZJfpMtfQDspaUshGTvCt0mlwEsFGSUCCtJk?=
 =?us-ascii?Q?lJ26khQOJsXxFwz6O+33tGt3T5kKmOLr5c+t8+cz0HFfE24AefkA5E6VESIZ?=
 =?us-ascii?Q?xf8flV3bPAjIaHIWGz/FoY4rElDeAk85SSWyZPz6qsocTMBtmm6ec1R66g/A?=
 =?us-ascii?Q?A/rQJJEV8nbtDi/6N6bC6OvXAzoHS42lfl0v1nPQAtbuFdF0mNf2B1Xh7Bnr?=
 =?us-ascii?Q?qM/AQs7aj2eQCnWve4DbAWJD9DnDkc0rX9lKsUpMeLJteg0SfYF1vGAo61/8?=
 =?us-ascii?Q?OgKcHIR7axMBzr1s7oWB4HNKIXOu2+CU9pE2Kr7oeBwdEPlc64vKapiaOUBw?=
 =?us-ascii?Q?q2sF0rWf/PmvZXdw/qGyZfhO/3CjGw3WQnC7tmE9htMPug6thkBb3zRi9OvW?=
 =?us-ascii?Q?1dyheVxBmsHg7oMpNmYcVfHOiYeIfW1EVnOnGXv7Y/lgi4XS7k4LpGpUmUsW?=
 =?us-ascii?Q?QPJz+6sdFHMV/4wY5LKvEnk85w0aP+XgdPqlAo7n+IknTYA1w+uhwV52KgtX?=
 =?us-ascii?Q?uAUy+8FVx8OezZBNrZ6gfs+OMeyrMPcsrqrjFuaXkt+3Vbw+sp3d3sPPrsQV?=
 =?us-ascii?Q?MWJf2YBfPGO4DVJ7n2dbWgg+djCwLN8v0iL8/Swl2Lb/yS7+J9ra2AIqJ8Po?=
 =?us-ascii?Q?/2T0kEqVvgsg+K0KBvK9iRM1dYtLrpSVAyzCfnCQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4b0ebb-ae3b-4fcc-1928-08dde725accb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 17:58:36.2972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxA7dYpU5mG369ampLiH7ciBeHlhQL29TT9SgNVTYrGJYfFZP+vkv+nGybspZdW3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180

On Tue, Aug 26, 2025 at 04:38:41PM -0700, Randy Dunlap wrote:
> 
> 
> On 8/26/25 10:18 AM, Jason Gunthorpe wrote:
> > diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
> > index 57dc81060f9f0d..8665a1d4299b7a 100644
> > --- a/drivers/iommu/generic_pt/Kconfig
> > +++ b/drivers/iommu/generic_pt/Kconfig
> > @@ -41,10 +41,21 @@ config IOMMU_PT_AMDV1
> >  
> >  	  Selected automatically by an IOMMU driver that uses this format.
> >  
> > +config IOMMU_PT_X86_64
> > +       tristate "IOMMU page table for x86 64 bit, 4/5 levels"
> 
> 	                                     64-bit,
> and use tab to indent, not spaces.

All fixed thanks

Jason

