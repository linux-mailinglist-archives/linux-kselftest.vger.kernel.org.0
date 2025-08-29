Return-Path: <linux-kselftest+bounces-40336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE95B3C2D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 21:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA307AA9E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 19:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7CD2367D9;
	Fri, 29 Aug 2025 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AmZyQjcb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44752309B9;
	Fri, 29 Aug 2025 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756494424; cv=fail; b=QecAnT3K5erqCjK7YEeSyYABp9gjaHoITEIOTyWxzWtAL7QUI8q5YWknBkZ53FHxXdRxeVvjQiHP1VkWd+JeAKtjADhAlxD5F2XvLxHsWLY52nHv3jJapeGc70KgmYbj4nWWn5/EKDGEFyNzL7P1RV+NGaB3IfI4kwVXdsBFt/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756494424; c=relaxed/simple;
	bh=mMgilwKASDa4tJrPXQuOxjKwqtm/Skycspk0Szjcm0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cztGO/6QSzzw8m2mLxQLmXfJUDnu4vkq551PxzpVAQZ78rBQQIxdWLMyrhcA2ag2w9tDEU/5StEExNscAOsFltxkKxLWNYpFObFtjqveD9URH5TdrFGeCEkQgNOKsv9IVx9GpGFugZMsTF7TLsPKzKjXXOegJR9+Y47fH6RmXt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AmZyQjcb; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmAz7upeAeMRMyueLpoB6ru+GFxy0bSa+u63t1Iknt6ROV3jiNheFbfkWq7xTxxuo1138dL64QBFSzV3+43eBmU4XaioMCign75wCC8YgDOTVFMHrvdXPQLSzYtQ3X86vhpeNUlHdr6SQbsHhkRESc41Q+ilKtMppMJStWVINEMJ9vGOn27re7uLJ1epQAX3umDEV4vxLNFvVOjMxAJrCMM87wrF9uJKxV9PWVdQ/zUiNQEqMLkaUxzV64v/lYR2ScVobZ3ptBibpQYmbXcaIWUvZx4Fgxifexjus5EPoQ1L1Lvel0Qec+0AHQh8vlrfpEp4JnQM5JSGLLfSKqkUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF8e8+iAXRH/QqThdyS+RS9vJSNcoxW5hKg1HV1OfkU=;
 b=QlI9dCOCfG2BjvohYK2FUDv+kSTSOjifqVmWntpDmYQY8UwZJIFlEYBwziHT1fy2J50CeRrDMP51zMAGsehwX79PzVU5gooL0P5C5fvFvD5B0JZEuRWfZ6pSACIdd8OvVsGn8VABAtVbwBKge7PWOlcGTjfn3OSPMTgHsLmSVK2EO/JQRgyYJanHdUTKS6QZCtM6w3sZCsy6Eh0U9M2ejNGU5PFilkQtxCKv4wSI7/k5lJ0WK+t64vcFHZktKARgUubJr/y24daPwy0FQ9Bc1A63Q8k0a+VkdsqAuM9u11cZ3LziV3hjj7zJjJzTkV0yN4sSepznvLk83N3EFJLRBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF8e8+iAXRH/QqThdyS+RS9vJSNcoxW5hKg1HV1OfkU=;
 b=AmZyQjcbOBlHHDQ/IyEMTRLe9N0r5kbsAJ86/0qgQB9Wjl3hO62YGX8ID7dOOaxGy+CPN70WJYhnKOF5b4r8K1PVdDWtlQ4tYnLiwszIxBSyf3uBYDEHiH59GXNRahDvwzvV5amS0xhfFLSvE4RFIrCt3UOI8MCCjMD5NvdFUKfjcAJ1AmXALYa7l4hmlboAljtW1JO1kuusVQybr3Nu9j3qF6clMhJt988oMprAZX0Ym7s9RWncYxkq4+FVwo64tzDx7rMjgJltZlDimAm5PMgqxZj5oV5Sj2zzp7QESDzInFeJB+67FCqQ/1suLkfOAVU72YhyVvTy1xdDRsFNYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 29 Aug
 2025 19:06:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 19:06:54 +0000
Date: Fri, 29 Aug 2025 16:06:52 -0300
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
Subject: Re: [PATCH v4 04/15] iommupt: Add the AMD IOMMU v1 page table format
Message-ID: <20250829190652.GH79520@nvidia.com>
References: <4-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
 <cfeead98-4344-47e6-ac62-08eaa5f5b318@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfeead98-4344-47e6-ac62-08eaa5f5b318@infradead.org>
X-ClientProxiedBy: SA1P222CA0105.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: eec1d54b-1e3a-45a2-e5d7-08dde72f3781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ui0wBr2PX3e3hluz/zyo5VrM/JphjXfMDCG66Es2WY88ZZ4j7KEG9kX1usmx?=
 =?us-ascii?Q?sHVipbq81G4skyqZ0VA02HWerdxCtyVsV5S6Ji8XaCRJ6peduLLswINYeqzl?=
 =?us-ascii?Q?sTTv1cyLhOthKKe/iDbYbVFxXP42NyT+yLStQ9mtAKreV7eAfibo8U6R/pW7?=
 =?us-ascii?Q?oSvxar9W+6ObUQSB5mEo35WewMuCALVP+v0idf3gD1EeL0pfJ4gC6BmPa4l5?=
 =?us-ascii?Q?GrD8anSm3w4ogKPzb0G1Ko5+NWctxAXfd8gfEf1o0erUUhFIyBQfsjRkac1F?=
 =?us-ascii?Q?eKfDBYWIwewCdsSxjl400qgb2IspUqEAXNlh4zqpFxvHdPJ+Gta7zoHv+zKQ?=
 =?us-ascii?Q?NQWsUiVw8jpSgQdHB00VQ6bLoWQuj/FNBi6wbtjG8dIxt2Ji8PixS62Vs3Yp?=
 =?us-ascii?Q?4g0d9o3MLYAVmbzgk2FEAtenHvOr+069GqecSrTiTmmrQ35kB3wYlqLVnUzV?=
 =?us-ascii?Q?g2d87kF6moJ8pCm7C1xc7vFhE3uCYAJX40Jj9ReLMfxUHFVm7FUKdwcX85a1?=
 =?us-ascii?Q?HJhkA84o4mVKz3bClzeqnCS2nUw3nyoalmwExwykC0e8PsPpkzFaKhynDNp+?=
 =?us-ascii?Q?aX2Zt4Jp3QilUQoGwmhJVMNn4yzJv0jOLn5oaetfDWUvR6IHw95XZor5NcrH?=
 =?us-ascii?Q?pJt9GmJ120+gbf5UIwIJfB9kblU9jQVz9RyhPmHU4Z2XEgZrAHkXjbmy89Pl?=
 =?us-ascii?Q?LBnaS39G3857oPPL3tmUjyaxuyavSqKTnN5q2qUxZUsEcWN+oSJ4SvSqjXQq?=
 =?us-ascii?Q?DaMUmFIsWROvVLPPHmPbFVFm0JsqBqEI7AKlThio4XGBRMNDttuQoqx+hZsh?=
 =?us-ascii?Q?5ke+uaGvQbBtSy8ekLm8wnxAtIebR89BTWuDIlpljngEL3qPcwZLbEUauTtQ?=
 =?us-ascii?Q?dEi6TiLqTcSk5FHsFm6YTzdfCOF7i7pR8MmNIQrc/LSFvDHz9KfBKRretmxX?=
 =?us-ascii?Q?dWUTwpAMaTY2EQ2iKSEK2tk1IA5NxF+bH2pOLppaL7s8e//0xQzZC21cOlQA?=
 =?us-ascii?Q?TTIAt7eKlnuIKZwjQa5YxIHqZe942gefjsePszHsmYGpBt2BT29Y0KHcKAWb?=
 =?us-ascii?Q?AMF+z0JnphDZnJe1UqQUcHmAxWaJSsuQK+fuL/31tfKW3VpK85i749hE2AxG?=
 =?us-ascii?Q?N+2E1dCQ1R9O3ZJN9buLNJGeX2tovn6xd/1WacK0EPZ+O9aX2qF/OsayVP0s?=
 =?us-ascii?Q?1sJm1VK8WGHRw/RArpof4Q8av4dv5wYsWNhUd6otg7akf2+jXh8nhFAHCR3F?=
 =?us-ascii?Q?qCm84jiMl34oQ+J+a6CQwuM309Lk1oXX1eX41s7ro69apKU+/fkdA67XA3tc?=
 =?us-ascii?Q?ReJZXxJOKGiSONvYFiYuYvQG0mu6b6LCBPBK0eAQSHZsd1gUety37JoNcPeI?=
 =?us-ascii?Q?UrF48sZgCoq4S4rGEjh/LBK8Cvo6227TeP0P4vLlkg/YCJxtzKSp7e5GsJ7M?=
 =?us-ascii?Q?XbZWNN0ZpgI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qgufyom6nRy2c9Mqa0PaJ075Lc9vkfMM0eiOMAFgmZnP58iAvlbosRDZOH36?=
 =?us-ascii?Q?VwNO07g83yIdiBwEJdqfkgLQgAaOJ/9bmQ7pG3q5qH1UHfdTt9C45ZT7msZy?=
 =?us-ascii?Q?OsUDLRYSfV0RNCyLX7lo4q3vOX9YL1EtYwSGvsYAGdBFsXCDAhTnWdbnpXT4?=
 =?us-ascii?Q?4bMS7ft6MYbeMOgttZCOEtiC6VRhCFKPkf3upvajSySjGIECsAmbYafSt2Xt?=
 =?us-ascii?Q?qsao88yLYiFPgYUhXj3DdVSBNSSTEPZrncmAk9dexwuMUsvVo31gjj2zUYjn?=
 =?us-ascii?Q?QnURsFg80XNNFG45TGxd6h+2OJ6DYIYMlFfMfxkR2+I6kLz3quSUxeyTQtmm?=
 =?us-ascii?Q?VY92s371RvAQuJLL+HL12NNz0nuVzjnQ4ALcBWolQPm0jniKnZBkhLwOAVg2?=
 =?us-ascii?Q?JFLHu8W0DpobOBDoW3GOWxXtMelIWANTwZ4P0tdF9caKZHYmvaLEoGpnx0x6?=
 =?us-ascii?Q?c+YscEw+FtY3eb7Tuh/yWvYBBIMtZr+BJG7T0eSJ4iyEurKrW7zoXbfJsKbg?=
 =?us-ascii?Q?gh1hFCDRKQwZcsU9aoq/npuN4CqoXxKGuX5fZydXWB2L35Cyw4jT2MJDa5W5?=
 =?us-ascii?Q?232FZoGTaDMkzfsWa/BnjBREZLnfLWYL1rmhA/2iIU/e2+l9PDOwUCzE8v8H?=
 =?us-ascii?Q?OdDUWp2YYe8l/DBmyTkCEaewTWl7zfJ7i8eH2WHxccBA2kih30yf9E6qOCiS?=
 =?us-ascii?Q?yAdwLylXnvyXUxE64SsRLtMRh9ggvQTXjohYhKCsdkTwr75+mBrxHnjvCfLD?=
 =?us-ascii?Q?nHHfJ2wYITcIA8NHwKzRcyeTJHjRNAY/2T/p+uY/6/kf/d22++Viw70hs6EN?=
 =?us-ascii?Q?/WQH31hkY7nKJHC0RoL0faG/NtewrCAd73t4Oj/SbY3oCZWaBodXBM4aCh2P?=
 =?us-ascii?Q?EvuTByLO/eZiMqpDE2/rwjpbcalcYe3hyYA26QlJcxcUFQr8/HUo7WA/bwyr?=
 =?us-ascii?Q?Kts9c57e0FB+BVLKQ6VPkQB9S2o4Qm3zKPdA3/2o2fSC6MhaKVdzgnTqwLq4?=
 =?us-ascii?Q?2ZFXSb05aa0g1AvhdPHjzPz/bNpwmOQZcgRqJKKS9JH/WkAHSvP3m+Mqn9pH?=
 =?us-ascii?Q?GEAjrWZRIgMCSoIgruC6NlHVQ080ivm77ySA29EhXfhjTJjssWakYYeU7Q5B?=
 =?us-ascii?Q?RPijKQNf+Jb3RDwgNJ87N6w0dqnkbXG/HufLoU/QL6s6FPea8qgE29zKIfuV?=
 =?us-ascii?Q?JwjFwp9KTnzIb0233JETZcN9nwtoNaZdfyyUczvn2fEUfCibig14Lncjapz0?=
 =?us-ascii?Q?0pE07NH2loZhxqmGmdreMvwlzYUUbdnCCTX8vu462tcKKSHFemEYIJX6Kk8d?=
 =?us-ascii?Q?3F5NMRnPrr4w+oszsgLQeQPATiqp/D7uKQwMTUvUGcf35gsQU+VGESDImg7c?=
 =?us-ascii?Q?9vTSLVFI7+2u7fWX6fG6mbonECr+CMxraZRY6/XAqPsUuh0dfBiTgtKBcoLW?=
 =?us-ascii?Q?lDchi1Ybs4dPqziYGiM7iVFoeHk+cZCJZEDugKD8UA6Q/qFfreCTOPq63T4w?=
 =?us-ascii?Q?grhRmi39Wpp/W05HnRTadEW9GKod7B0tnWaKJSlaRNvANa8h4BC/gNwzwRnh?=
 =?us-ascii?Q?xpaFNSNxWKWE+xKdCX2Y0RHZi4x4x600XXkGo0PW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec1d54b-1e3a-45a2-e5d7-08dde72f3781
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 19:06:53.9546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibbspcI9wTl2xxJINyLDmGQiExNyGcFG/DohzLU3BOcdYk1Y7YX6mZjP55ETfpOa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706

On Tue, Aug 26, 2025 at 05:03:39PM -0700, Randy Dunlap wrote:
> 
> 
> On 8/26/25 10:18 AM, Jason Gunthorpe wrote:
> > diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
> > index c35ddc7c827e92..1867e8d74b4be9 100644
> > --- a/drivers/iommu/generic_pt/Kconfig
> > +++ b/drivers/iommu/generic_pt/Kconfig
> > @@ -29,4 +29,16 @@ config IOMMU_PT
> >  	  IOMMU_PT provides an implementation of the page table operations
> >  	  related struct iommu_domain using GENERIC_PT to abstract the page
> >  	  table format.
> > +
> > +if IOMMU_PT
> > +config IOMMU_PT_AMDV1
> > +	tristate "IOMMU page table for 64 bit AMD IOMMU v1"
> 
> 	                               64-bit

Fixed them, thanks

Jason

