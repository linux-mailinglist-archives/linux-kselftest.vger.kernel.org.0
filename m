Return-Path: <linux-kselftest+bounces-32415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83954AA9A8F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D374189E6C5
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90B926B094;
	Mon,  5 May 2025 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a37RnQsT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EAA17C98;
	Mon,  5 May 2025 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466268; cv=fail; b=fCEevF8aW+QAjz83pUYVvvC/U7dFHby0rUqK1KYGDMuNto5ArpqiL1sUBnkHtP+XNjvZYpY2osxJMBM9LIRx6DRvgnRw7PMRV2Zg/w1TEzep1GF3/nqu7ODmS+O4tMjTjjPSo3SYQZwJMUWSlmLKDJJjrc5SIXS5pcI4sSoTJlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466268; c=relaxed/simple;
	bh=pGBIpaEY+QtP3yigZ5XZZkgvhu0n4SEGjItkIJTevwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DELiG09RtST/p1yEpyQ8tpVVKv1ZB5dvMx1DCURvMJYOQiuOk8o5buMfDKEN38ca7e+btxDrf02pQv3h01edldeDV8ORZdg/vrw81pKPbS5yw5QDqLFDhKcftWu4U7gF4guGpgheOlosBkSYDYcZNg08fzKqJXNA/2F60asODPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a37RnQsT; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTjg1DixC9W2XjkO/LwQQyxalSXjIn22Eg/QzDQoJwfiPL87Ygh72GPoogTnv4g+Wo9UqqqL0qHwwSkamv1qYzQUK3ETzK6AvD9WklIGe1vFq0kOSsSWgLX+4QqqN36jpBOZCC5b1SR/+HnHQn5QvqXhgFAOCnADYtWSGS/uXHWXu/in28or19PoFd+hdePZcBVChCviBpJnBhDskRBVm3D6yB+3yO+wnQUStqJH+L45WKnnYAHDb3spoXBRNptS36LYkSvrjFDVolTAJyhDfFB0tB80kUPFfLimTt13Yc+LmgKtiXa+0ZoBVgh5xeibOGh59/p3d9azjeD9MOcPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVf/MSmc7m/gVg1yeZbN4Yn2QmUUhSFm8cgxS/569wo=;
 b=ta2zyTi2xhPkVsqDUtXJW1idWcaHovR9NQB6RsvhsWXNpbTsGdoFzSPwMtg3U9ZyYZ9Bza6fTxA89+JZEH0wgeP0nIbvHePXg5VbA6IdQ2RJGGg+s9Zy/EA4EmrhgA0JyUBth2WEGNEaxGE+KH1ujcK2t/MPeAkw+Ir4EUlScWNcujwDvWa8fp04PntUfGy6nSqbRZEX8PSwE+gNDCcS+R/lsymdBqz9rE+XX+bdh2VfEUQGC+lEcmbVrX+2mxTg602LTvCECu/Aiu/HsmdwUQ5L23vs8RyHAGX+DZZWU03SoEp4P899+L8exw0S1xOTLhSoywd0hnJwhGC0ViKpVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVf/MSmc7m/gVg1yeZbN4Yn2QmUUhSFm8cgxS/569wo=;
 b=a37RnQsTLEpvCZ7V6iGPNPW9IMymfttl6OhI3iF/wfbvpfPNM90nEIEV12muKJQAheFjzXvWiIQEs+X1CkadD7uXNPsCf5nr+Bh7xzPDj50tSf7t07SBuFtJ3skjeIjb5AVIkgxjGBcNnpgF9y9X+pY54Khq0ZnIt1L+eKlNkU8GrmMKZ2tLmfiBMLyn0BSleZCnZssCKp2f9yGLkQY0i6B94AYcRQQ38HbtUV5cseLiHDqsLSFd08XuxMQ2f/NMUIJuA8OSj1oFQSPlLQJBS1zqTmO19H7R5a2/pd83JrCCrlzpB6raFMASRFuvZI1u5lB2WbjkbJb+qhDLda3rmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 17:31:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 17:31:02 +0000
Date: Mon, 5 May 2025 14:31:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <20250505173101.GT2260709@nvidia.com>
References: <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <aBE1gUz9y415EuBQ@google.com>
 <aBE38GwvGBnpRNLc@google.com>
 <aBE47aySzDp2lsAz@Asurada-Nvidia>
 <aBE800DsAOOZ4ybv@google.com>
 <aBE/CD4Ilbydnmud@Asurada-Nvidia>
 <aBFGCxcTh54pecsk@google.com>
 <aBFIsYg+ITU8RvTT@Asurada-Nvidia>
 <20250505165552.GN2260709@nvidia.com>
 <aBj1Av6Xaj8flMN+@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBj1Av6Xaj8flMN+@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 828fd92a-8584-48c5-86c3-08dd8bfa9b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nJpufhwYeCO2MmkD3CKQWZ3rSxHbO4M4amUCMbb8/9LKilG5c2bgnpl7j9sS?=
 =?us-ascii?Q?lYZ8eDwUhFJTm14Uwu+Le8l7PmhB12ut4ZbeOQbvfJW36za8+v6ALpp2Bcr/?=
 =?us-ascii?Q?X3XH0Zee6c7XVGt1JMXP64CguueWWrA38oGyje06TsO4xlVk3s9kYwmnPdYT?=
 =?us-ascii?Q?ALfPaHhp90p/ffNe/3Vk/q9NAMs/2GHjZoU54sLZyusYS12u8vSk6KwJszw/?=
 =?us-ascii?Q?/Lb/od/6zCI0H0C4nfK4YZZtcOI91yOOEbAsGfa0/+LSFvdosnVjBn9W8O8p?=
 =?us-ascii?Q?ELaQkCLMJgCyiSmkhts6qaGAOewLLAhcpMWiMVYfVeiXIQnBSMYsJIfdaEcI?=
 =?us-ascii?Q?Ode6067dF0vBEMZlNWUlG/W80dt3rLPGqMt98LQpWQUmaB7EcDCeAkRR/Vgq?=
 =?us-ascii?Q?bu/VuyUmh1vZDNfkGQOTtYKtklB5ESUmZnLIMI3kiME/yKWKv1PcxvuxbA51?=
 =?us-ascii?Q?mipNOMMWI/ZwfiR7dTdFV85hUdzNSpgyLvtIep6QnETjfUSH7lYZYxJbhwF+?=
 =?us-ascii?Q?yQPDI/KPn/BZM7Z9bmrTaZrdzKdbrhlb+zrQEb31Ui6ivyjS4k8JANBXPJRW?=
 =?us-ascii?Q?Wf22kV4uJvIs07sy0HX639CB1hdSuQq7rNS4KhwHlEiA/R7pGGxDEhc7PVlY?=
 =?us-ascii?Q?yDFEomCKdjJRMDfwXTWb+O83yp+Z+UTuVU2Wg+pn1Rw3+O6b0UHZm8sMLjDp?=
 =?us-ascii?Q?B0CEyFXQHQ56Nk/Am1fcnw5BedkftVxuxifWqnTakNouk94t8SeTnu7KppSe?=
 =?us-ascii?Q?CEnBVeOlbQQfLtyPQeBVE+VP0ImY8duzIuKLgtjOSAYypBRtsWT3YLFqEjVg?=
 =?us-ascii?Q?60VXkd8wdfpQwrSe7x9nZjABkf2yn+PovDp9w3syZH4KAvbudYDGPBfYudDc?=
 =?us-ascii?Q?W7sGtWwElepXBx9zxVJctJmFLvZ2DsyiBmJ/fgk3X6HL2IdxdwrvJZtPjWl3?=
 =?us-ascii?Q?VjrL2FEbiUZOBBNfdjqz6ZPRfV43Zr8zBBoFMyH7QDDzveWgOWsCESt4IOv7?=
 =?us-ascii?Q?NqmOEdmfOtgkJQFbgwFKQZskHkT+BI8Jr/lLT1s4ezeuiOx5Imnp9UQkLi4I?=
 =?us-ascii?Q?J62qpYJCie5iEsUFEeTC0HMSxJFZdzXoPOxI9+RKUXr6sh7zSjV5GWDcV0Z+?=
 =?us-ascii?Q?6CtE9qoOyPQi2IJRhvjeW0vQTwwKHzTtloOYIZpLkAbkqLTOzUYuS/o7QnOk?=
 =?us-ascii?Q?uFtw80YaUwW+dD/T6HAYxxLeGCpfTPQsSChNLKNEvTugdSrV+TEdPnQMYWB5?=
 =?us-ascii?Q?AmqAHuKANy5e4/4XE7ATAOEGlFe6vXLjGADXABCVBNdDT5tk3NFDSP49yRbb?=
 =?us-ascii?Q?f7G8ud6kwabP0jPYKhJdZxPHckV+D6cJ0s+kODZtcGHJhf2hSTM26kZzRwhn?=
 =?us-ascii?Q?vyLtJn3DcKjYdNqGBHufsNhOnP9DVsOnA8yzzKATtttCM8ITclh3XkHm+7+P?=
 =?us-ascii?Q?HAdOdA9k73I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mkYdE6ZTODURbhwSgJCuEh23MJ0m7/lOF4HmI3tYP0opG39tvR6bOKbHCpnC?=
 =?us-ascii?Q?1SWKyyJGndyCVDq3owX48q/fFYGjKkgMmUXMI6BnUsiNQzq5PzZxPtD6zMpp?=
 =?us-ascii?Q?O8J7G+nq55NXl1tjehzTzTkVAenvRLCP/1I3i8qsXkiSFAbYRb8dpCoxbiGX?=
 =?us-ascii?Q?Bv1Ju5VPl5TbeIyk8qeVo7BZo5C2bGbhCAUyrDqUSOVBfRWxGwxr9Ts1WIRX?=
 =?us-ascii?Q?3Zy8EjWe96uCdToYmmSZvI/rZlVzUPNv+x3DXZhVGcBdKiXed0jkAfzR/vf5?=
 =?us-ascii?Q?5FZWTvN4dwSDUnkaUJ6qYUu4P0N4qzO/e3bwjMHcqAb5/fIYTkjaeLSy8aQ8?=
 =?us-ascii?Q?MIqnE5X8/B5EV6BGrsRDNgTmLxOtqz041bZm6y0eq1y49KLtUsT23qTgFryI?=
 =?us-ascii?Q?8z8ILQgp1LcSd8Um0L3F54UsbVBxxHV/lDdl/2tCvN+vTS4treVN8X9DzaDN?=
 =?us-ascii?Q?5gFqmrYKH7jCHbbrGYqxAWnCXBJSyS6IyvbCW+5HNrr/lu5ypTMHkR2F5RBg?=
 =?us-ascii?Q?ekfa9QM+CLo2z1+QZcA4zsYJQju1vxIu3AYL4dk+u8GKlk4ic1y0vkCS5vQf?=
 =?us-ascii?Q?LrsZkLxCrEJdG8y3zndE1uoAUzvY+eR2JmKrMybGyZt3Cejhjk08ddMKUtsm?=
 =?us-ascii?Q?sra3xjDWnJbnxR10MZTuPL9yNSsYgT+bQm3aZiD3yT4guXy/Hb6BdPnDdZ3o?=
 =?us-ascii?Q?lStZDc39dO9cu1oXDvy27NXlQR7BQYEcdJj7jcVzrCsx7yDA0ykI6IPeI74B?=
 =?us-ascii?Q?zc4eZp/zhe75C96t1E3UrvZQ5h9Yq+dpGu/Ik6BoeFH7953uWJFqMK/32OCn?=
 =?us-ascii?Q?Gp/LlRyPdi+yMYgSuhRrKnR/o8tvUPkvtDhkdZ0oXFR7Vtw7TRKeXhJw14yY?=
 =?us-ascii?Q?1ly2T7/2mXYG8rdvtPIiTqjBOvLaZUaoAyqX1yzC2i6AsSlK8nYeXdrBnMR8?=
 =?us-ascii?Q?peGbGu2d+/Vew6rh+HzNnwar49xw/xcdTtPOLUrGT54NzYD2QsX9yNK0tlkD?=
 =?us-ascii?Q?BIOkFF7tbS2qG5oTcZ4zsQoypi9JmhTwB7D86oGvGNXZ2kqjk/G1dd44MXFB?=
 =?us-ascii?Q?R8+DkOrvihbjEzojrD3DBZf0ZYaZcUS70LarTCcRTcnIwLmodOodsaIgs0/E?=
 =?us-ascii?Q?8e4c7u4vxOIsnbmWst/pMzFcPLY08ww8yQ3y4fT9E2PJNQ83Ktmm8IUPNWha?=
 =?us-ascii?Q?CKhWKUw9iNwnLhMTcE+LaR4XwYU4R1SIrA7Szkq/ky0V8P+slgd8LkFv/Nsg?=
 =?us-ascii?Q?lstmlln17f6PaGjtSdfkQKehmXp/2RIy6KKtdfKV9zaDNqh+QExKa8PEigGh?=
 =?us-ascii?Q?0IXolMcLbuKrtI+3grJQ0egwWnN3nk4R/5Kgz3eNj7MEApLU3VZMNVGWN2Vx?=
 =?us-ascii?Q?/lZo29h/QsLoIYu0jTcIXw+8pEc8w3OwOeS+r/vA0IiRMZWrQz5cPBlQlM1C?=
 =?us-ascii?Q?L0Eir2ngCCLXmG9mPLqoYSqdqEnSJ9NBMXj7SMollq0ZmKEPrniPWnUg6ZzU?=
 =?us-ascii?Q?OsqNWBmWsUN4EDWB65ME58iSprXofseKx08uMRktmshTdRjcIphufiKeYB27?=
 =?us-ascii?Q?1/eR2ALGMPflhey/cJoMafrODX6db4drpR27ZL2J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828fd92a-8584-48c5-86c3-08dd8bfa9b8c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 17:31:02.6415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjOCaKj8ubU7JzeHcmvNLwnlSglesJITtZThL1ffQYA/TsxuU4rUTshnkdFGrpQU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361

On Mon, May 05, 2025 at 10:27:30AM -0700, Nicolin Chen wrote:
> > So when calling mtree_alloc_range:
> > 
> > int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
> > 		void *entry, unsigned long size, unsigned long min,
> > 		unsigned long max, gfp_t gfp)
> > 
> > size should be the number of PFNs this mmap is going to use, which is
> > not sizeof() anything
> > 
> > min should be 0 and max should be uh.. U32_MAX >> PAGE_SHIFT
> > IIRC.. There is a different limit for pgof fon 32 bit mmap()
> 
> Should the startp (input) be the pfn_start (i.e. pgoff)?

pfn_start/pgoff is the output of the allocation, it is not an input.

> In this case, it would return startp as the ID, which will
> be further returned to the user space. So, basically user
> space know the pfn range, v.s being given an mmap cookie?

Userspace is given the pgoff to pass to mmap as a cookie, it doesn't
know anything about it beyond that passing that pgoff will get the
mmap it should get. Userspace must also know how big the mmap is.

The pgoffs should all be allocated from non-overlapping ranges as
though they were bytes in a file so that the mmaps are all
disjoint. This makes debugging easier and the API saner.

There is no "id" here..

Jason

