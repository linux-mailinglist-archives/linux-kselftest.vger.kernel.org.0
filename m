Return-Path: <linux-kselftest+bounces-33179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88624AB9D33
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 15:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4843AE6F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 13:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5912F219E0;
	Fri, 16 May 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qu1DsDsf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BE81B808;
	Fri, 16 May 2025 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401921; cv=fail; b=jqVGD6NrZmJ4eXyCmVJMs63fAxQ7p1juh2+xvLRuMTrKgwqhNZUbws/zwRdzCFzeNgP33QTQDywDDWLCH9970nA/au8bzTHZGEPe2h+KuxIGxbsFi1To5rUQQQUDwI3KU2Am8LFNfSyIEUrzIeTLWTVu9jJj6Z/WePQT1oI6ErM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401921; c=relaxed/simple;
	bh=A+Jm1x67EXJi7T13Z6Pxr2tlSo8+UAO3ne8QwtwUt8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u8n2kBsFW+01SzTl3UxMk+/pNzddKjjAY8V3DIt0Vx9zfRWNcUSIyRp27gJO/OMlUSI/pzl6BGO+0wbvjHXPVQ3SyD/VKmCXO4sFtvqzly9o51HaRMtfZqSqh+m534GGmnwUee+UmUBwVu5UolPspWm8XoPdxoEYjLN8NXx482c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qu1DsDsf; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIDe4JiJC758ueZQZRGDMLi37f0M0CXjPpO9KqSA+4gkuhVMW45RPVcddkz0RTWeKSg1NZoIDOKryQPQBAxkBQ79kcTX+IVEJWx8UmEP2qtmBZVoClfdgGuR55wH9w6+cYICrpXCtB8/MZHoOJFvQCVmYpt9Zy0GF29DtT4UCOIel1iSUcoFeVUsLnl4ozE11864YwGH878V4EBIh7rlJiBFDXCjXmMqOZ3KvEkBhWlrhsHml8eANST6lfHhvF956jnzLikWyM2SqsWU9V3Yj86JdqMntyu1nUv2WAfK/MAjNt7kPIj5Wa+v9YrVvTHUna5mFE5C55ptLNwDY2lmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrL/UIkKZ/Tm8bR6+YWMI+VBVckeTQDb1syQUO/pxow=;
 b=H3q8zxovRF2R7kXkNEADBJRBAibrjpLFwErY0NJmUDctGNQQw/3hCu0o2Bd3IFHHTk2HwY9/reVauybfPXIDq3xZ7zvcGWFCiHzEYh8F8s7FgDVIR8KZCzNuvpN8OD7TFkNmlGjute4+ti8v3BD09c/7GNetjoQ5W07+OQsIZPdAUg9Jq4zNllme3T0Cqe9ZNn2JjGri8nGNPO3SvBeTtsj8fQLcCJdx1rUtxXNSbVIr6ynXHPXhrjKhwRKE/AGHmjuS8r/a544z1q19xXtEe0g3g6ccWcvcuKoOPzBUvb5k+B8WiRE0sDqEyurxKPE4uyfNF5E/7QaAh/lGC8hMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrL/UIkKZ/Tm8bR6+YWMI+VBVckeTQDb1syQUO/pxow=;
 b=Qu1DsDsflRdtJw+7bh1tIIyIZh9Py5HIr7H2gvGpxxh7xKjvrhj2rIv05D8ukNSjMbCK5chFajO8BvFbu/Okzfn515NQJoQA1re/ZpK4NEafXuW1QEU30HVbt8kJCmCKeQmofwOYDAy1Xmfs5yXrHLd1UhcC2efpl4i+8cv7gLEamkRSWWDxumGxwvZzA7vJM8nLYt7xR4etCnXX3gp4pdKndAHyo85BeGYbk+JrBSEwIL/pWGbZ1yBopGC00gbQ1I+cX1D9ZfhHzvg/YxZG13IgsOp2Dpq8mCmIc3j9rYeyO+V/zzjZsC8m2j28nU/8wK9MSkGdU903o382bfq8Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 13:25:09 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 13:25:09 +0000
Date: Fri, 16 May 2025 10:25:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"bagasdotme@gmail.com" <bagasdotme@gmail.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>,
	"zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: Re: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <20250516132508.GF613512@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
 <20250515160620.GJ382960@nvidia.com>
 <BN9PR11MB52761C3553652A790934129B8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52761C3553652A790934129B8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR14CA0022.namprd14.prod.outlook.com
 (2603:10b6:208:23e::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b0a6de-8d4d-40d1-2f29-08dd947d1456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CSjx59Bj6IKxQPUyb534iRoN8UqQ0lGTAHJx45TP+BWj8hktDtRa2kmCQkyz?=
 =?us-ascii?Q?096uZapFkaj4AYFqPcKjCs2UxeN/RLLYc1+QuSAUVRSF7OxWjZZK6aH18xGw?=
 =?us-ascii?Q?+rIFJP4CpGuGvCjrYvAkGyRnG1u2azbZ5oYc5YYQ1jvDVZyMBryQtg05AAi4?=
 =?us-ascii?Q?xIkLMuJT/UcaF/oXYh73JTtkmaaFRkkXOP/jVYymoceWWXGO2haZChTiKxU6?=
 =?us-ascii?Q?+xpB+1J1a0PKGUKCcO8xXn0/Ebkii/qI0rmzwysXS1jRtzTdXzLS6ytY0+FL?=
 =?us-ascii?Q?H1N6adSZkCwVViD1fU6vJe5Cl6rJOwD+kvxpd99faz/Yd3DaNdDd/h5blsdK?=
 =?us-ascii?Q?Zl9BMvi7GVmrN7HK00WN/6tsrr6eCWuIJmm3i+sVts4J8DGgKZqd0fhWZvv3?=
 =?us-ascii?Q?NzJCLYRFIarN5p/UdiG6p83UMosI10WLt2qnV1xAY1CrW91jIYHy/y/whHzb?=
 =?us-ascii?Q?v6HSs9CD6Wym/XWIXzYMnpwFIaqM/C38fzJ7qIg47YmeHZoMuLDyWt11UTXg?=
 =?us-ascii?Q?3mVk6YG4Tm/92m0snfx2VCV7b8sar5jIYGw13ygLGLKGiYCHgLAwFS/NXFYq?=
 =?us-ascii?Q?dxoOvXOvEVkmCBbRv9G9UXRN4CxKyB45oCmN2Ds5gfJb+jjtG3QxMknMKB4F?=
 =?us-ascii?Q?OvQi+a7r5uM+H5cT9CANHS7drqsZTr0/z4AI8nzRpAF6QTTJLlcr8uTdqnb4?=
 =?us-ascii?Q?04CFNFHVG/5H4gkZYCdsDr0m/MjDNZK4tV6tIs7XTmj1oTuxIkZkOE/3cDIe?=
 =?us-ascii?Q?+cTpFvTtGvRIkUOz1093BsVPdDIatXIc66wcUjKRFn1eWMV3WtdUgkCx3DTI?=
 =?us-ascii?Q?lmq6f5BWvdMyG9JZ0uNpuZJupxmNWC2sD4Ci+DvYIwAWk7SB3omgnvRzUKVQ?=
 =?us-ascii?Q?PsA5AaXOxKfhFPYjjmoU267SXQZGnJZvVJX8q3ErUe03bGC0bujpdBHwpwVS?=
 =?us-ascii?Q?Dj/PkDpUcKdEGL8W3dtSaGPMhYhRD9r5boivOE7eWBwS/4+/Izd94OPumPUY?=
 =?us-ascii?Q?DZfVllmtaVI3s+b/zQLdtdENJP9+nwNfMReVOKrYcLyl4tcs2UJF+LKEGDie?=
 =?us-ascii?Q?uyNJ0kT22ddI3MP75D/6q6gK9ln2/PUKSbKkrQO5R8nOxsV3C9u2Lr0K77dv?=
 =?us-ascii?Q?OWSBLsnhpafgnqNEU9X5brOzEE7VRVT0TSsR4KVIJsd2qcu4su1BAb56CxrM?=
 =?us-ascii?Q?lwN3IqyFtk1wGD+m5YHl++4DS4A6kBhIabSdp9VlLWkDEEpq1A9IsM+hQnU2?=
 =?us-ascii?Q?9Udz2RvMK+QR4XV016vgMrAiA2UNmKf9GFF7RuIywejPJrPUvSiOhDoa+nRq?=
 =?us-ascii?Q?rFi+Fcbk/n35gqbndjFRUdQ+wPNJo1aPuJaVG4Q6er3NygCOrX5TnkqxN54p?=
 =?us-ascii?Q?QBl9imCsHzDufihGfLyQGqNmEOC+GVj3DLeuj5AritlovuOLixMY5ThxwHTu?=
 =?us-ascii?Q?c59OO83l0ow=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SDvNjvd4b+8h2fsjScepa0h80dTx6F8oMBVzHJxI28Zug5JHDeKhyjHLN0Uu?=
 =?us-ascii?Q?qJDp8ubcVerLvr7vjezijtD+Yqo9BAbkD5OejU5vipr4eXFm8+YNr+1UQ/xx?=
 =?us-ascii?Q?j8xr0O+0PLqalm8cA0VYINFlIwKr3+NebNjfR2fhtfmIRHswzgfdW9Hb+5zY?=
 =?us-ascii?Q?p6nb93pXlT6aml9s9nGkQweBa4c7Se1roDfPqaPGL5dmoMWqrjn8pNcW0XFp?=
 =?us-ascii?Q?LxKJgVy4ugEbWRCWEfMKQNdl+qeWgVo9GMJLvGqlDKQe9toJB2HHpsiJaMjp?=
 =?us-ascii?Q?r6Ez72jEonEy+hUfalboUX4aeIe6xhQXttwcTqTMueAS2RPevszW11K1bJ9D?=
 =?us-ascii?Q?TKBdYOJmL7thAHZFW733InIr8i+JvJ+oC+Vg00kbP0CgWTHjYBBdOhD6EV57?=
 =?us-ascii?Q?bLIkyqotN/uNql22eRuE+31YXI0v96yJhyBAQRasOK4syWZdRVllgMD8WiEf?=
 =?us-ascii?Q?DAuQk68CW1fD3kXo+E/8+mBW9YmPYS0qc+DUDtx/bog8fjmVFxd3enYjV4Rt?=
 =?us-ascii?Q?kuYwHEARXmX5kh1HBxN/zL7x+dz39CPDw5iEQLsnIG+wEzl3b7ra48h4yix+?=
 =?us-ascii?Q?mB0DorgaaVi0PJAt9iakvIdNdgrnHekZmrHXruGYGrH30XnlyAYm84YXdOP1?=
 =?us-ascii?Q?pJeoNcfKNJnC5pnxfZhDtpq5gRPbOKgXB9LzRr+00yfWzOhc9hMUPs/QcD1X?=
 =?us-ascii?Q?u8AvGeytANWrXTB0waOEKQFNInzXyWCHJSp+YdCQ7euQGqKgENQ0A0JbQh/F?=
 =?us-ascii?Q?IYigPrbxyRX0KDl+GdplMYU2Vw43jW7XwROHxa/a3vpU3LUCbP1Nz3ZZZtO1?=
 =?us-ascii?Q?PIy+lp+/7upcDqMlNe6GS8babhCGaz6oPysqLD2UZU4u8XAZPr+Zp6WfDhHU?=
 =?us-ascii?Q?axYAWWdKlqeooFU0DiXIeoNVTA3kGv5BozUdDPsyktrOTl4yKIyfUwbaMj0j?=
 =?us-ascii?Q?0UWAmssM6K5CbczHlRU9CJT3sWM2a3RXRkUMAtDOfDg4gEtcyFzyQlUKJASw?=
 =?us-ascii?Q?tgYEqZy4SNR6oGUj3hclujbk8tE75mWf2I6VTTinW35J4wO9IywvlMWHRB1o?=
 =?us-ascii?Q?0BRxwJS3IYUCcbxF2kPmNp/vyC8O1HgyHoDGkBNwSqG7QTUJnk/AxlzAqb56?=
 =?us-ascii?Q?SWGGjObltb+7vhcC3u54cr2rprN93c6OYX6uQqbV8Pocfod078gSPQKIF0KJ?=
 =?us-ascii?Q?k5KllDVaydxeYc2mexuTumlZyBEP2QXUv3KEJYDCDX5cojv0bMBuIAIZpQex?=
 =?us-ascii?Q?zc981cfEQRsgyhk8AsA+gIIG/zzpPyitRli5sGWbdOZhW2RkUhaTyNsR4aZ8?=
 =?us-ascii?Q?gHHsQZ6rBLU+1qUQbJrBDR9r39iweoauamtvTepLOoo4DrEODsVQkfPuiLx1?=
 =?us-ascii?Q?Td8CEyt7Tn9i8vA11gIYEtk1a6bXmOeKcRqRsJ+TBkV/dm1p0cSNsbGR6g6A?=
 =?us-ascii?Q?jSj3YgkjcQzBOnPqiGxNuV1uVVIxzKiX+GgENeI01e7EGPxHyqhxJm0eT+cf?=
 =?us-ascii?Q?mlwCQa/6SaoLiysDU5hOoyJN+XobBEF1DT32JyvDfQCQQ1wlWqjCS94yWJ3i?=
 =?us-ascii?Q?YVP773adWq3ghiKRY5brhOaS9NQ52tq7qWl246Rp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b0a6de-8d4d-40d1-2f29-08dd947d1456
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 13:25:09.1910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aoMYrkEQVzOjAm09tVm00HB164mjlxBP1KDZoG46QTgBZOgavumtgl4dmrwttuV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278

On Fri, May 16, 2025 at 02:42:32AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, May 16, 2025 12:06 AM
> > 
> > Do we have way to make the pinning optional?
> > 
> > As I understand AMD's system the iommu HW itself translates the
> > base_addr through the S2 page table automatically, so it doesn't need
> > pinned memory and physical addresses but just the IOVA.
> > 
> 
> Though using IOVA could eliminate pinning conceptually, implementation
> wise an IOMMU may not tolerate translation errors in its access to guest
> queues with assumption that S2 is pinned.

Yes, but the entire S2 is pinned today. This isn't about transient unmap..

If the VMM decides to unmap the memory, eg with hotunplug or
something, then I'd fully expect the IOMMU to take a fault and forward
the error to the guest. Guest make a mistake to put the queue in
memory that was hot-unplugged.
 
Jason

