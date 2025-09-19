Return-Path: <linux-kselftest+bounces-41979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B355B8AEE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 20:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B643BA04C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 18:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F0723BD13;
	Fri, 19 Sep 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OysI1JDp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E3C481B1;
	Fri, 19 Sep 2025 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306925; cv=fail; b=Y0YbBAORLDgVJPbytvVbjcsgeVXmLFiewCCpWfJhI+bfmx3wj8k/vDIMH9w3bTiuxXWymRVV0AeFk/jWxmgKTlto2t6dtQFJV2HKSZ4tKA2hBjJpcglR/kMf4zeM9S7/JGSIGHQ3aEBQbb3FqL4AcBPYYLME1UVfAXdOvW870o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306925; c=relaxed/simple;
	bh=2Wsjp1TqCpy/N2OdRn1JIOHVLdQDF3IkBC1pgj8+uPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kuq5dY+ivxXC2Zju5j3s2D4qi+/jZROatNAXUnIa6QKJV8fqRx3mUvQ8OHvkwnPTLv2kD5AH9wxYDBxYHUoSyuIprA7bgNnJH2mzWn48OvPI96VmOUHx5ApEIGpGdAnuUoi1ai7YXFG2QZJ5Z1GaX3X91JnALq0MD7AlqnItqFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OysI1JDp; arc=fail smtp.client-ip=40.93.198.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9ucins5JyyCfhpASSXob6/JYPeQZvUnMpiaz2/N9oo0bBURmjm0qwSuL1puSC+t1XfGAcCJCaeZkNL9tiU5ltkJiy/SzL29+LRpZiyMhKSp8XwbCEw5EfYjX7mpRpGMbtEo9+QzBp2jdCeLT0be8ed0F638YFNj32qPChDTAWe+3jPyyKcClNSNfsKjvXov3ROD8BGZwpQL1qJe/bNCEazqNxiZ/pz+rw2e6jyCNtC7DD2MnCeJ5hrFK3RWmE8smNIToocvXSlSvMz41VG96wyANnGdwlhKzGIKUyN2KllKnwrKfThkNriGnSLx2cU3/WRwvt9tmGLcgF50GyQ08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGK2bkQbHWBeFYHfttbwIL14yyWSFaBi/+O9OPL4ZaY=;
 b=ulBRilqwuNEaQf5ExNKPo+Ro34MJ054Vc+szy1hwKeEiOuwSL5hHBhNZPm2Qk+S3DCtAmlzKp0vNXEmNVsA72HBvhzAYFCppaWNfU25hw2CJJHCVTmTDH4axAEO3E7+YxqndqGrsf3bVfNIH0NDrc78lNZCXgc8oxn4qxd97jlQwIYrD2fCo7gVNs7JJ8LQ2GYApCl1w79w7e/AwPjuXri2oD5xLC0ZHPtPueMYbDyKaQkiV15/gT3r7x1jL+lmRpPC90WS4iv/gew26x8FqTmu35El57Nz+k1q7IuxomYw06UqGn/+AMoiO2tLk1e1esCAxFlZU7GVMJx3onTqVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGK2bkQbHWBeFYHfttbwIL14yyWSFaBi/+O9OPL4ZaY=;
 b=OysI1JDpTiDVoJeHlD3Rrytu3IHbNmeMbN42WbH1/A5rMLeoHABSjxdVT+s/R94YPQONZ4xKrVyc1TabWLazXZuaIHL+fwy8zxcVUTQCllk3iq5spP66e4N83gGBWpi/0GTTwV+wVMXGhNOQRDrsk126rfHhvx1XiTebSXDrNduR46LD+udzlncW1itRkAGaui2UhoNSyx1s5Cl2Z/t+VfsVRmH05JyJ1ugSf6PujLtcQLkgs37bzT64n3zI6oa4RvUcNyGwb/hf/dRjAsKXy7SMDv+eei/MkJpXkbxADbzp9Z5WiM7LcyBgfYl9PtqaYNVi72lqAflQIDG1YrNo1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 18:35:21 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 18:35:21 +0000
Date: Fri, 19 Sep 2025 15:35:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
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
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 05/15] iommupt: Add iova_to_phys op
Message-ID: <20250919183518.GG2132010@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <5-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB5276A792314370662660E5098C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A792314370662660E5098C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: DS7PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::20) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 251bb0c8-c9eb-4923-d564-08ddf7ab49f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TkqKNyZ/r0p7hiltWkGZBuTmQ9Ct2KNgQDxIcs7RapTfkweYd1MIwM0dV4Vk?=
 =?us-ascii?Q?8YeObP4RLIgufHI6bW2Jqim8ufKsSNdLM/QgILbxjApzEwhrIPYcxnv/Qiwq?=
 =?us-ascii?Q?QWEGJad2yoTMlpmaI2QgNXXd2F3KrM5P5BOH3b9UNiqPV3zYCNCX5XNDGUBz?=
 =?us-ascii?Q?pLe5DK5qreQbjLzBH2krhYw/O03vJowcA2OuSJiY2wNFYiIU6AZ1aVg0xOOD?=
 =?us-ascii?Q?aWwLFpCaBvMLumOJau6CCQ4tu9dQxJeKz+rNn/HseKXrHdN57qkX5BiHcTDn?=
 =?us-ascii?Q?kqnvfoUbNlE6u6m22g1NxxiFauIva7WSSdTXUDagiN9H6+X81lK/kTsQ3E2q?=
 =?us-ascii?Q?bN+sAWTjTNQbNCKfQKQ1bs1niQU3GyBeXw6WX21PPjK6WbQwJgStx67JbrWZ?=
 =?us-ascii?Q?Ljhxs6sFabWImpvNBvMvCXD43yd3Eh8SEeMgBrNGBwJo8US859neDAbfjlLM?=
 =?us-ascii?Q?fN6oeO5I0tJil0PUqbe/cVkl94MmDBpJYJShl1X+8C55ws3uOPwzxow5Vs9t?=
 =?us-ascii?Q?IOrUSROU0u/nx5L079MS3iU6mb/eozWdeqXla12bMdwhS+qZIqVRbgx0YtjC?=
 =?us-ascii?Q?LScCqX+dHyCaD6TAlQaQXKgm1HRslVC3AiP1kqcxnxPolFbVem877tiwVRY9?=
 =?us-ascii?Q?OPyF8pjRoChejY86l8g4qHll5eF4DN03BwIzAjJ0NpRAJS6F0iy2Bq0mpMMp?=
 =?us-ascii?Q?CWCPSa5ZxNOsRwLZu8F9CzfYODoRm3ZzImildlzC/ABiUKHYTebkDq6kVWNm?=
 =?us-ascii?Q?URWE9/LhjiU5FBnkAhzgKb022E1NVlqDpkjpwyrC0wd4mkUa0975YzjX+fAs?=
 =?us-ascii?Q?7m4bzT2YjQhoxmQwyR/L5wWvUyAPl2+kx9gg1nKiO6TAFLBmKcEhjcNkqxEy?=
 =?us-ascii?Q?X6Sho/BFSQybHgwGsCWEHBE+gn0F3f60uXZfwH/eYmJekAASIiJvCqUbxjjc?=
 =?us-ascii?Q?VxZO9aQr/jaI/zmTDXi0y/1zQAhmo84oNGzb4uDosyyg/5bVfX3BftNseOSi?=
 =?us-ascii?Q?a/CwQKscu15bd2p1F7KMcauR/ZfFCsTvCoDltObS1QkoXNj5H1lx1IyqyapM?=
 =?us-ascii?Q?4I7enKttuDMbYwWmkLwzOdQ9UoACbypa7tOQeERiO2F3MOXrdafaIY93fDPN?=
 =?us-ascii?Q?BpeS/B4i1NiyKKNhpkDbA+NLSrug7k2oqGFKNUWDhwPVwyYDN3tdb4GRMKgl?=
 =?us-ascii?Q?O895BVQs3s7RyM2E8kgbWqCoG/my0EhiCGeHYY+YiKgrw5mwCiIBw9uw3G7g?=
 =?us-ascii?Q?5MfzsyxjbYJ4c269Od8AiGMv3ztJHudsU5VdLgu6RbDwlYbReGay+aOchbp9?=
 =?us-ascii?Q?TbDzX7LSMkdUcMORmgR5ZHLvhh11KmbIJbV60+AO4LfkLL0HAE1lYQgW4hgC?=
 =?us-ascii?Q?MojuEGMasg9Xnn/2c7iKWrahWNP4b6obxcJdQxicgPPKQ2pt7Q32NpjYHjeF?=
 =?us-ascii?Q?dYHae5edWK8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BsUQWJCpqDMqtHnaNtd9w3wIqTeYNOmXGp8VAewSRb/o4HoP0aA4V86dljIa?=
 =?us-ascii?Q?NUpSMIGzcvHqW7EohEEDJIdpBkxL24+QuQpcjNDfboERdrJ+MEHe8h9OJJpr?=
 =?us-ascii?Q?bPqjYwsWBsJo/rA/J2PNf+P1uNDLXxiQpYUxvCDMdPA7CaQeMcMdyEMOi8bP?=
 =?us-ascii?Q?eBcP2fyKaYeYvHTU9rU6YVn0hvkg3OLVJ851MEhLFfV0+FOCX1FJ1jm9mjdv?=
 =?us-ascii?Q?WTtSxV0e2iLQOlj64Pvs+yOafS0kEEAzC6skFpq2t5hSw4TfwYCz3PEEtwrP?=
 =?us-ascii?Q?ss9oKSj8RY0EuTnNB0i+kftQ1jTwZdgCbM70CpFbHUmdzS7/L9NZW5TkRTcW?=
 =?us-ascii?Q?gOfxA8fHufjtbfgI1dTPEa3lD4BrenNu6H3cPBAd/L7ekAWcrNN1vV5/XGf4?=
 =?us-ascii?Q?GLQuc7vJ8GiSrp94h8gIgbZuFgDAc44/5SDyVItYnWefKIzi8egYgtpWWzoY?=
 =?us-ascii?Q?t7ZNs/3lXNE6v4E5TrzjRLH3Sim7RjbKa7PLtdbX88CBrJqfPhRruza+ZXM/?=
 =?us-ascii?Q?ps6RjGYgEx54AiwiHQC9JqSUldkW5hrcIE4NZ4XAPrBnkSpy3uRZNTmBNlIP?=
 =?us-ascii?Q?styEUnkf/AKH2H0cKOo7QTXmFJXjFYbG8+xwZVQZeQ/QQjCjQU3QkYDhrkTu?=
 =?us-ascii?Q?tDde8wXqd4k4J0YnozIN8BdOkn+LHbmyCoiJDPrjSdPUtFvArpvEHAr8+bIp?=
 =?us-ascii?Q?tFdZt0QXD6/zQjrwujk0id1cgrIrwJCstwI9/TBJ+fhznBtymFhtyrGaT48F?=
 =?us-ascii?Q?ixnnpGTjcjIZ0Zqb835tx30GccZYLiNIjHEMVDsMvhlVpNU69U7ooXwwL9zF?=
 =?us-ascii?Q?DvhwBLTQqLsPGUmRbfq2swetSvpskWUko9okEjQajNlw2l6jK2fvvlpYNLss?=
 =?us-ascii?Q?y9vzHrGqIIXdWY+EfvkMuGlis0StRgqw/I3MF8IwVx5SSpzY5x0hrz+4+781?=
 =?us-ascii?Q?8HeZ8w4NNXvD5g8xJfgXFYdvQdrCDFLkbID6sFie0hv9DqpyNZMh56nXMGFe?=
 =?us-ascii?Q?XJsHmUUdUfioovdGeLwA1z7Wlb4rtBv8YBUKDoHh59AkW+lqKmftJLXVCvOC?=
 =?us-ascii?Q?/mVVSLzIbELXg5i7EoHKiJaaRCWobuEl1OT90fF4XRQHK4b6sWQMBH15IK16?=
 =?us-ascii?Q?b1wvouAbY6MhNdmLdLs38dV2TI4Ai4wBh14ZJ17ZdAUNphucpHlZ44BqsBn5?=
 =?us-ascii?Q?Fkrez7PPWWnPzK7InEmwoCmVq93sI3LzNxICDzz209nkjNA/nhHjRfDQ0IIk?=
 =?us-ascii?Q?INxr6TK/VlhLO78/I4qh7B8v1ZDwmsxTfI9ybY7V52nqKiZcesYFBJMV4wAg?=
 =?us-ascii?Q?T3AmbQiXSWmE1lJCLF/PUJ95WIcyVinJsdoioYe1J9m1htW8Yj1RUd8gh6Ou?=
 =?us-ascii?Q?9ZczqKi2xMpwFedQsIZ1Ax1y0otx8TFa/GCdO9ed/QUhkjsB7Rf40tJFMXjB?=
 =?us-ascii?Q?Tm4CM3R5ob40UP+QoONbS6JpvrWdJwWb2jemuhUNnHhx0i9mH8pBU73hdLWP?=
 =?us-ascii?Q?QFjmcBF+7TI3nRjHGAb8A3jrEFqRlHHfYU1SQ3f+eZdY3Cf3h4eZbt6o1jvv?=
 =?us-ascii?Q?Y1Y/LAkRlH2uvj7KQeKu62Fx34dKGpeA2FFBOKdc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251bb0c8-c9eb-4923-d564-08ddf7ab49f8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 18:35:21.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9TNc78b5fWmiSMcTEcyV8pJYMIQH/BPUj+rhYPuMMVthMkWOUdtMgvQkgdQ0OJN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654

On Thu, Sep 18, 2025 at 07:08:39AM +0000, Tian, Kevin wrote:
> > +/*
> > + * Some APIs use unsigned long some use dma_addr_t as the type. Dispatch
> > to the
> > + * correct validation based on the type.
> 
> "Some APIs use unsigned long, while others use..."

OK

> > +#define PT_IOMMU_CHECK_DOMAIN(s, pt_iommu_memb, domain_memb)
> > \
> > +	static_assert(offsetof(s, pt_iommu_memb.domain) ==   \
> > +		      offsetof(s, domain_memb))
> > 
> 
> not belong to this patch

I moved it to patch 3 "basic structure"

Thanks,
Jason

