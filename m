Return-Path: <linux-kselftest+bounces-32507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F44DAAC4A5
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 14:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545831BA430A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 12:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26E127FD64;
	Tue,  6 May 2025 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KPV76opz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5527FB39;
	Tue,  6 May 2025 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746535951; cv=fail; b=aoTN1mBmoTjtrI5kmb4PwMFZWWQlbsfkSBaZwEyzR/KPQEDOE8c4BhqKoRkQ9ve0uObPNZqbFuTzzUB3ExdBCC2nAxuC8WLAPd37XvKW2MisegOnyf9bHXlI7yrT6ynDJNvuxEd/xWn0Ufg8NrYhs5s5y9T5eEXIhUfHGB7C+C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746535951; c=relaxed/simple;
	bh=/MvP7KDvy4sJTw8gQos6mlhafABRV6zTde34IBisDN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=obDllE6JqKN0h6kncGpOAVHCu1GJAMyw0UN/TDEYbiOG3JlQoR9vhS/RDiVU34I7GU+AneO34+xItwUWv4OEOMc1L0kznTMygj0DNz8PyVnO9JITS0k50oVcWZyKoRsaXQ8Oajcln+1iY8GDQXFB6A3YSio4TNFOblAYvpnKO5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KPV76opz; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwnoTCA6heRFcZiTE48edKJ+BWSp78pXsZY1YggdxAayrxQ+oWabcpERR+hyT6SNLj0DoxwSZTfselyJKFRZArK+67ephiD6GJztlb4XSeMS1Ux0b6MbqkTN0KZC51A0eczgAErRUidy+6XjRalZ8eiU6uTNWZffYEM/f9vIHnABZIr/464K/YVAFp/x/sbez2NzoER+W8QQdMgYiCvxnpWsaCwBWi4CEXmXfUuKZsFnGIV0a35VsS/jBDih7aLITbmPqwfKX/sz3jtPnf9EB56JxGkCuhzN9Tbgzq2FIGQptLipmGEjzJycm5h5Ie+e9FzOx1ks+xpmRCHLgFU1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MvP7KDvy4sJTw8gQos6mlhafABRV6zTde34IBisDN8=;
 b=ngWPueSRqYl07R3hZkEhqpVGQzbm8oDJfkgV0dBmXb2E9qkOyU1auMBXn+fL9UtIXQSPZ7McFcONDe6SbKIZv7kE9/NmzpMIN67WAiRYuXoDZC2rn2j39pwIjp0aEqC8PSktUvgzfE6VZ0fG6b5nwDIiE3bGQ0c54Xs0kctjboPA6QQN7z+cGfRiwxgn26EDkD52B9/wgbU/h065ucE6tQH/quGFi8SGLbvLfHoyuF/55eMH5a0ZZ7B0+pU7rUJCG6Fqdwg/N5oYuKnSN96JWo4cNzdKpLfH72kVas3tFJ7sZ3137vp2C8YZHiZRR//uab9n9zcE+t3kZtMFDAQk0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MvP7KDvy4sJTw8gQos6mlhafABRV6zTde34IBisDN8=;
 b=KPV76opzGG7f31cFZ4aCVexBn59iRmOaYhPDJPqY0gI5lzEu/o4BMl6Or9mpECTaI8hmFDEg3LyGEmIzWWE1c06lLO5wyWBT2j0TU83F8NJA2On5PxWWl7jGe9Sx8u3n2kAnthoQM7ze0R2HS+S/YSuCnYEgNI7Z3+TYAprs7m90fYWrfgLErmkyWpSqCtmMarO8iV443iRmmltN1hQjDA555r2sRip9aixWX+R7F7pbkujB8t5vXaa872ELVrE/XOzmMMLbRGos2M+gkhU3nj2Ube4/DXHlWvMaRMtnpl3WBAxJ+YurKC7aW2ubD1nwwIPimFJDJBfoJ6aSvoDUYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA5PPFDC35F96D4.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Tue, 6 May
 2025 12:52:23 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 12:52:23 +0000
Date: Tue, 6 May 2025 09:52:22 -0300
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
Message-ID: <20250506125222.GW2260709@nvidia.com>
References: <aBE38GwvGBnpRNLc@google.com>
 <aBE47aySzDp2lsAz@Asurada-Nvidia>
 <aBE800DsAOOZ4ybv@google.com>
 <aBE/CD4Ilbydnmud@Asurada-Nvidia>
 <aBFGCxcTh54pecsk@google.com>
 <aBFIsYg+ITU8RvTT@Asurada-Nvidia>
 <20250505165552.GN2260709@nvidia.com>
 <aBj1Av6Xaj8flMN+@nvidia.com>
 <20250505173101.GT2260709@nvidia.com>
 <aBkWoH23VysYake3@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBkWoH23VysYake3@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0672.namprd03.prod.outlook.com
 (2603:10b6:408:10e::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA5PPFDC35F96D4:EE_
X-MS-Office365-Filtering-Correlation-Id: 5476d4ca-3a8a-4fa1-6149-08dd8c9cd879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dy/v/4pKBf6sp8WCqJDhzP1pcQPBSHiDik7mUrip3rJmcXz1XgCIRigD3QV0?=
 =?us-ascii?Q?T50Hh5bCpPgbJBLbXMm56t0zE4Gpc144al7PzZqW8uGK4VVpIzuuZfWCVkj9?=
 =?us-ascii?Q?zmEa7564H2FcCIbfHQDYr+jncdGGEwGq5H961gN5ZjuL6zBuTSWbrz4kLIoh?=
 =?us-ascii?Q?k2LWrG8wzWtyRCKCOZ3WBW1z/1t60ZIujfz3W8NE5g2kDIvBJUf7nSw+AENX?=
 =?us-ascii?Q?xB4qB89W+m90GgrBAys7a8AOL4liquI6vOX8lAxHkRYHCDdozgNAd4iEvBn7?=
 =?us-ascii?Q?QefY+QjNNkn/gsBbz/3RrN9IIOyYYe/ZStybZYv5rkbOaGn8YtdkBP+pu8p8?=
 =?us-ascii?Q?IOuSP1Fjdz70dZCLbk92vbmMMridl1jirfPjmt6eeap9qTD2PopVzYA8TVxT?=
 =?us-ascii?Q?CnpwhiMqX5tNKsEi5b4+rMuWQbKZSsdIQv2AbBSXeyjPdiThhAakPL27QoI4?=
 =?us-ascii?Q?j0SnnRh1Hf2zYv/bnyLn5pqTyqhoESGLWnIETuxj+35/vfL3wSwlFCbbyTSt?=
 =?us-ascii?Q?q8+GDSBEaOjijLZoP6HOUYH8YPPqq9UEd2k09deIxc3Qql++n9FpX8JTSQmt?=
 =?us-ascii?Q?JZHf4G4l7HNKURyrH+utUosSsjUfCp8aJYzBdyF+NPHa1Hg0d9tHQteKZjBK?=
 =?us-ascii?Q?9UeeXrdDdmSIcYdpZyCVnzBmWawBr/e9mub9dA1gP8mEd8YAVaSzaAwnErqK?=
 =?us-ascii?Q?NWyjT19nobGmry4MFfNdZj/3n5V5LEZWskPFT36nMDjafaIOF4b5nw909pYL?=
 =?us-ascii?Q?zCwyPpl8ZPvUn+4vegU5WTjeimwb7T8vyL8l/0m+hS//Mt+zuifZp9yi38YI?=
 =?us-ascii?Q?bPevkJuNyDPk01fMjPicof/ltb1heU+UtNCYrUul+f1eZKofL+uVbnXbnhTy?=
 =?us-ascii?Q?aDwKMGytQZRmDoTlPglP/RwWTONoH97T/vta0VFgEZ1U8UCX2yfMk5UeOiOh?=
 =?us-ascii?Q?9Qx0p3KXFNDAkTeM+gg+9fYweLw5LDPhNvnD2QxoKro0EMQ4LXKeWv/JG/aI?=
 =?us-ascii?Q?hnlvsv5Ir+x7Nod85qFeKVyNCI1EXxPJ0Tu9pL9QD8gB5toSDO/FObFqhQCA?=
 =?us-ascii?Q?gC/UoQMtyfwEefsEHHd89cUMZc6LzxROtjE7UvHsfXS5Q2OeKs+rqJVaHaLZ?=
 =?us-ascii?Q?stsBdfROt+xRp8aarQ4Z7f4TyhfKsXEBW3ugp0vHsF24YKKtNpr/ZCqmLbeB?=
 =?us-ascii?Q?QDSkqfv65xSKZ20SNcDzE5DR9haQYjyRJHJsXPjKDYbi9FFlv05xQLX8UhpD?=
 =?us-ascii?Q?4WKOmxYus4pOlHOjwvy2H8kyubpS+nShcUetQBiKAS2ZkKRhgJqZmz+yx8Sm?=
 =?us-ascii?Q?eog4WRgxoIgEmxgB9lNKOng6MsILHV5Fvl9fe7Bj8+v9gzaUrCjmQkQ/XvUL?=
 =?us-ascii?Q?Div3sv1E5ZpNwHAJq6sId174LGlJxtuxNpnlVqfovzMp/9RJaMlipewbLRbV?=
 =?us-ascii?Q?RL8CaGhENus=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TSRbRRdCVLRaTU0Nk4tf8U8wlHpidhZ8Rnm6ncptcdjo46sTsO2vXVSLHi0z?=
 =?us-ascii?Q?cJXnY85rydQPRdJujmB9c0DBcSYkTHf52KxNOz4WRDAY+OcXwGKZ4bVh7iR+?=
 =?us-ascii?Q?QM6UuzpMXP/+78ZV2iUunSokhCyGHzpXJkeXT+L7z6qLe/3QYtfvhi/OfHME?=
 =?us-ascii?Q?qqT3nZjnW4FjBCa1Q5FzWVCOqMbt5ihapSawz3v3Oc+s8EvU1ziuXassrk8N?=
 =?us-ascii?Q?J8VCr1SnIpDWanWWoe+EvsrxiMKZppSGLYwAfVqR7j8j/ib+AfXcQjgwBy3b?=
 =?us-ascii?Q?ydRlQQ09VdsW5V+w0jRIh8ykVltsM9WrsDjmtR/u7xUnuHSWWLAEIB3BtlWe?=
 =?us-ascii?Q?lbDokzbE8MTZ2EJAsFC9hKTUkmpB0ihwDKjR+Nm/EHAotSd5PZtaqEEseSgM?=
 =?us-ascii?Q?gYayGVqMKJv9/R77Eig08ZwyUxt0TKgTuWxKf0H1nQ8iXCyCOWxonDNs0ats?=
 =?us-ascii?Q?KsSBy1uICu2KlK/Hh6tfX/PozdK/3gZqRriKHYTV7eoI1WA3gi9ql5xZR2Op?=
 =?us-ascii?Q?NiGY2TkS3I/RvvZBSM5NTlS1pLm2XgEGF8VG9gvBSam4X+24rtipmEY8HSXE?=
 =?us-ascii?Q?gEKRWCirmdfbN3XQSpeARMV2fbiihGfotowqdj54wl6qK7HyASWTwd4kySyF?=
 =?us-ascii?Q?NqpgHtYy2S2xlso40lF68erP1NkOXx3GwkGzNzocsnAfeoGhc3KeyNG12F0E?=
 =?us-ascii?Q?zSp/syDSGycbjlNvPpQisDftZghdoPLdzpQ7bZnpZR3+JgLmW4NA9GPmSQyh?=
 =?us-ascii?Q?WflRFwu2CzBT1ZooMN0ybnsK4kWpIgFOwbnzSip84lUpJODS+HL6wnHrWBMG?=
 =?us-ascii?Q?JjXgAzUOE7X7LB+V1QVXS0z3wbnGQkGYRCzkyRNP+0+qivpWvWj5fwIX5fFs?=
 =?us-ascii?Q?eJhFGpkMv219kQsEa/v8y5pszoFO6dQe+7B/IEMR+kN/L6imaSM7LG4A2KrY?=
 =?us-ascii?Q?o0CtKywOBYI0rZ2kO3OtxoVVl9Q9kwZgzQq80o4dtEoFqOv6a7C5uvzxili0?=
 =?us-ascii?Q?LlkDiahW6sFjww2rklGyYNDbkIjg6tnH5LgntJH/2jzGBIbSw7IWPmkDF0w6?=
 =?us-ascii?Q?q0ujv0MS4OaWUDYZtC1WXIahpNNVZl2cTKT7p5Hhr6LnD4Yog3Q1uOX7fx1W?=
 =?us-ascii?Q?+fjl0LYHE1rVSHS0PgekDfSW3qbhRJYoinb/IbMtxfJ0cT6IH3ojXAV38rXw?=
 =?us-ascii?Q?QhMhB/P7jZwasUbRUVP4LZA70ojua0RnO8buA2qzOccnTU0ynKKkuNTzFvsi?=
 =?us-ascii?Q?Lsaw8jOenEarmPWE1m/6U1XnPlUVkTnlfLi9VNhoxf3d9MRl8EvNaBJrb0/7?=
 =?us-ascii?Q?4SuIVN9fTvaBRd8WVgkBJXLKQRDYQogHPcyUXxkSrPpwK1f75STXarblonqW?=
 =?us-ascii?Q?XvLvv8MN883yR8GzVru27G85dSxL9YBajWvW7gJL1a/UvrALTv2nkdjs9V5P?=
 =?us-ascii?Q?RjFYB3/EOKX8feYfecsqmEfKg6YoUGzccja9I50G3q3v2XuGVKc83uPIflI6?=
 =?us-ascii?Q?E02Wd/DXgEcC7unnqLrkMOCGrmeA7K5gDvVoC4kAI3Me79KR8QE5suade1LX?=
 =?us-ascii?Q?nzLlrzfmbX7WxA9yKOoJ7FTHsCybW18/tPQfUgCH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5476d4ca-3a8a-4fa1-6149-08dd8c9cd879
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:52:23.2875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fy3VwAqgOh/KDeAbPXLzs9RIDNpyYCX/TiQinR1Q4f0qRkRXpyv3oL9oWuy6fctO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFDC35F96D4

On Mon, May 05, 2025 at 12:50:56PM -0700, Nicolin Chen wrote:

> I wanted to ask: what should we pass in to the "entry"? An mmap
> structure that hold the pfn range? Or just pfn_start?

Some kind of struct telling you what is behind that pfn range so you
can invoke the right driver callback and retun the right pfns..

> With that being said, it seems that I have been misusing the
> mtree data structure, treating it as an xarray. In your very
> first email suggesting the mmap design, where you mentioned
> "xarray" first and "maple tree" following. So, I thought they
> can be used in the similar way, especially after reading this:
> https://lwn.net/Articles/846175/

This job requires a range based datastructure. Meaning you insert PFNs
A->B and then a lookup would search for any intersection with A->B.

In maple tree you can do this rather directly since it is inherently
range based.

In xarray you can do it with the multi-order feature or you can do it
by replicating the entry across the whole range.

Jason

