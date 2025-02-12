Return-Path: <linux-kselftest+bounces-26442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AE2A31B8A
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 02:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F8B1887300
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 01:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F036B4D599;
	Wed, 12 Feb 2025 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fsxVHp+8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34054A50;
	Wed, 12 Feb 2025 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325073; cv=fail; b=UOCnF02+ZbCY024ExDWyvGuqcBSK6ooq2+IFn11pp6kOA6I+rb3cpi53dBjkgvTq+58WmiYsNsiVmZJIijtaSjEQusJKSHJ/g8nY7bfLKiW1oehj63Q30RGqY2ddlro1tBACA5kLh72DrHDWGkCqbVfP1j7uP0t6KV4ayk6GcMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325073; c=relaxed/simple;
	bh=lw1Qhc653DDc5gAVf78JvweMJTvQWp4uBM9zV6uR9Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ugrm0tjCt11GjFAqBfXkNzpc3YGCnsH4/EmhwQDiEor8ND+i6xZb5OPS6Q19aPNmfb+FeNgPfR0xo6KgMny9DppX3SUJF1iD7M303L3a8IhPMgqN1qWg0LuD1xVOYI91nU7x4KFSWcpf+aA0XK+UVo37MZkuf5+IML7v7/FoOR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fsxVHp+8; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWlgLO0sjBij4Z7/AK8CFGx2vOAGrNAh2aPWoP3HwJ7B9jzSU4ayiFiwoTK9C9TA29eby7IjpI8jQWSOYuBzQ8MhtLAUd7ENnmbrWQIV7IZuvLxiTrtRHNzeK4389/4GOaeoPHGCGwjPmpcDLUaroOGwQ62a35V3K6ukZIm3bboXrxLIJkJOBLqjcbg6LPu0Ka4gN7eKuWMgl5iDAFKum6YY/8wGhBhykp2A1hk0RQR9lvFc1zaWtALKaGnjMpVNindjNhmHhynKsw3QQzBh9229vVTat0vdsTAnd21iMOiAsLJxlCnGoebFJJnkEr6NhwNrtFrKi3m9cvK7SWrrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icOTs3gNug4s4nxkcIWmdMC0o5IgkqJlddzs6K99jLw=;
 b=xjs0MoDA9lebDtun7naXaJysrKn7RHAc4XPVaAGkvihZSQTaNTXj5GMMGytil0GsXv9gpQWweBaF+rOwqZt+i750KY24eaiLqyyO72zm3NMyqe+2n8VxyqUDZPIGAtexYXSgPZbDQpbp7UwKId+R5ei+zx2z8z5P1HpygrUyzKzLn9ivg04N1awOKbpw4ROA0KlPFeBUOxkpttNSo9lDgjzLgM2FY5UZ9cjpf6Pp/6GY4F11vnnx6xVXmDduUKUEJjFHNxl0IgyHW9Lk0Zk7+gQYb5A4pY8a0ABefl6jW62001cyADewu51Ef6IfHu3gO+YRyTZKcDV689xD8Cw//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icOTs3gNug4s4nxkcIWmdMC0o5IgkqJlddzs6K99jLw=;
 b=fsxVHp+8DRl3IP9ze1ZpvVTfl6xQCA2vSw+QJM7AP7c3keN/mshQNS2fQzg+z9LI420pK6xvgn8KCB48m7Z6tBIl4eCxmUcswmfv2UA6Ti0+3dKDpg3LJiF0FP+a5rovOf7thpn3+7j1atc6fldmwZWvpTl4POuDnlntpExNaVvQApvIR8DcKltnn1mhguzy6d3kYTn5jGYWEmnAKLJTGVmC75kRj3fuE07wCVKybE61z4KLGKw4UD9SWE5H/e/OevKlbvTUtRDDJi39xWs22qvwUudBWXJS+2ZhdpB6J+aJZxYcpbUlmPvJBhNjzNWvtXfIPe4Xzsl/enwq/oHdgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.12; Wed, 12 Feb
 2025 01:51:09 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 01:51:09 +0000
From: Zi Yan <ziy@nvidia.com>
To: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v7 1/8] xarray: add xas_try_split() to split a multi-index
 entry.
Date: Tue, 11 Feb 2025 20:51:06 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <32DDC973-FAF8-48A8-831E-01E2ABA2966B@nvidia.com>
In-Reply-To: <3BC99886-609B-4820-B65D-FCA2E11A02F3@nvidia.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
 <20250211155034.268962-2-ziy@nvidia.com>
 <3BC99886-609B-4820-B65D-FCA2E11A02F3@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad300b5-fc55-418f-6072-08dd4b07b894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ZHqDO8e6cBsVD1PV3SVc4PPTMFpA0pgZG4p85oLSG3d6SMnKrAXWcwmbKkF?=
 =?us-ascii?Q?Sw78Z7xyEDy2eN+JE/aIf0XsNz2RYpSIPrbpC00dUY+DQuQeG1WZdESPdEJd?=
 =?us-ascii?Q?54SQifDHUCQugQqpTpsYY0ZZJA0NMcgLbY1SuJUr0g9stpBqRgYoj97SNLgi?=
 =?us-ascii?Q?DVQ61NWiTvaiUC2E+oHKKpXrypsPROx6RDj/KcqV9sEnezwrA3Hyunyu1mOc?=
 =?us-ascii?Q?RfWBfsPDdRvb11OCfB8t9nuCnp6trxL6FoLcXPUFbpTEpmuicuapKZUV6QI0?=
 =?us-ascii?Q?R07AFjaUTTGqv2ptos0n2Km7QU8gokBF4UeSBq8etfImK/wQE3Or8NNNY07j?=
 =?us-ascii?Q?OjZM8zILrCw2fteiI44sFFmxEuBoD/XSZkLK28XPyuEXQd/EDndpv+uiQpwH?=
 =?us-ascii?Q?TCBZ5cVp06I77HSPH9KhZYQI/VnvZVSwXHbC+mMT5WLZHC1z1vW/9cYojbdo?=
 =?us-ascii?Q?qNgDajJBq/ZJkuwbOrZEaNGnCO+aiKFsyEZoygCv54xOp57z9qgvTwBl+cy4?=
 =?us-ascii?Q?oEC+zoYuWtOGNLSZSTNy18ySEEICiDIGlkx+psV+L69XqVWGT/MuGwwPDn/V?=
 =?us-ascii?Q?9yveVKdMm2WE8bprc/ZOrVXUndqIDmOXTbU32Gtc4OhPnwsErQePIGvGDJb2?=
 =?us-ascii?Q?iUhgUHZ8nVzOYPnnXcyIr+AGTM2oV0OoiNhTmlqiC8C07m3scbHoIXGiFCVF?=
 =?us-ascii?Q?/yADejPqF/CP9P3yoYuSsAfmkrcmot92Y0kDOaibQq7VX1Z88VWJ8FKmTjBl?=
 =?us-ascii?Q?3Me0+0AW/8Cv7mmh8Ym4xtnV1pF2+jGfyQudhVALk+GwtxgiKgaCf0mo40sk?=
 =?us-ascii?Q?ZDZUI+sKKR0li48RwA16nD0dgcdem+Za8JTFD2mSLsY4Jc83eRvsdkmzxlkC?=
 =?us-ascii?Q?/SFxfF17/OrJ7QttxwlGaa8HEHs6EABJiDESlGGf+3zjk+8FYEXkTIH4qOUX?=
 =?us-ascii?Q?73IOzcrCK9t8P+qzlbR4evfuSUu1dGKowwPlZx/UJcuhsU4TTb/qV31aYPNv?=
 =?us-ascii?Q?itoBDR9ewVBM7ZOvo/5mAjxAl/xBXbI9Haa3nUXbt25MCtAiKZsIrBrAMBs5?=
 =?us-ascii?Q?BeMleDEKqBdYvBLkug99gMmuwkoijo2I709qgT/ccJH4PvQweGWCF2hMFmeb?=
 =?us-ascii?Q?3MEJ1I7gsKal4WY9t698wbwc7TnvCngY3qGOFkLXETdZimOVasi2XrhlL9IP?=
 =?us-ascii?Q?OOG+bB5UJJl195JRTNO7MAOI+/mGvMzATsu9+ZLUcQ7enJVpH41vcZ+WZd3n?=
 =?us-ascii?Q?NsQvslyuaJH4OqpuyPSxELzuYkIIDsigZS/b275w/e5WG4Adkm19kkx7Gkoq?=
 =?us-ascii?Q?HtiGIAM5+HunT84Qj96WwA6mLUxdyaNPZWMkQ1qiwrV52EkCEtwP6640DGK9?=
 =?us-ascii?Q?QAqddOI8g1Na3c475ycdsTvK80Hr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LE8e5OT+YNK7CF1KApXNWSR6pxw1RJ1LN+X1aMrYSLx8n8tl4CFwjIj7YtWz?=
 =?us-ascii?Q?pqajFdRfZMnABVoDk0NOzwrdfMVdHCJwi72tYcWxjjpAmil/jmKUoJoMkEKG?=
 =?us-ascii?Q?R57/b14zCk9sCJ4hC4n/mzv5/88nNAO/c0wcL9h8Wn++koj2h52w5cnrewoz?=
 =?us-ascii?Q?jlSCq4Xg4lt13DdJiidkZOqcaydutGLUYaoJMSs2bkd1EkjJDrFmnG9t/fy6?=
 =?us-ascii?Q?MjeVssUq6tJ6uSLOHvaHBxzSJoAO18KTSSOQumN2MyrqCVfzwM4c2TwpPMAM?=
 =?us-ascii?Q?ftywE7d7DP0UoGPgxuvfRcJ/LrWWtevycct1uZHPuAjYLmAozbionvOS8nA9?=
 =?us-ascii?Q?UmLZ1ljln0bZqBlOqPUZQAzmkagrC0/SfC2mjHjz1hoL8Ykl9l6GpnWQftD7?=
 =?us-ascii?Q?yK+pDAMdQQ5U99w6LwAMrViILpPWZbn29QJA5p/Bjr64jYyZ3d3x5+coVVav?=
 =?us-ascii?Q?TucePNbL1/PZs6WNF/xmjvHEh1AVW+FhuVGntFF87AxU/poBfeq+rqc8nel2?=
 =?us-ascii?Q?5vNC6ynzhxSt+bs32KoeygHUa3pFo2vCvhnv7JQunUe4jo8mvWePV5htQVN+?=
 =?us-ascii?Q?ILkBtY229HzEQ2blkwOV4J7hwwh2WrBQOYWbVEiXGFz0q1wok77HOOPHWQzy?=
 =?us-ascii?Q?cXUlXiqnKrwbx+0YXP+dAbyg2GcFRnxWjwJI7leabN3sobk1U6qGHACH6yRB?=
 =?us-ascii?Q?2fiRMjbLEA+zchXPNRU6mvcbxVra5xC5skT0ZArm5NUDEi408hF8stuiZufH?=
 =?us-ascii?Q?8s6vIzwHpJzMMVsBrMY/7sjvdMd6bKKoOXuWCuFGHao1W1VoHryVnFfNLaA6?=
 =?us-ascii?Q?14ECTRkOn07cho4TvYV/uk/lQ9+zf92VYXtEAHaMTACQKUDivtgqImR0JetD?=
 =?us-ascii?Q?VcIpt7h1YMpg8x002gFGnnuQe1oIXDHzIhxjiDqbhDWfeYGhRq2XYDnUEdVl?=
 =?us-ascii?Q?gjJU7atQnPHB6LD30udZzQga7gPS9KIPqzqGAs2f452h25sodWSVYP2cq7SM?=
 =?us-ascii?Q?LaUUZnq6cZONEaskCyQGiXxolTG31ioy0SYjbM0VQOilWSLVG/b7WiwlVwaM?=
 =?us-ascii?Q?6tdXMbqz1CT78xcezNEeLdbWqqblU6BroCQAgNbZw/Qf+X6e6/YaWdvQejeV?=
 =?us-ascii?Q?iejuZHND0Fla5ETBDZe2ZrTzqDEs6EDrpidGhFV6TL6TC34qBZR1WFEfRJku?=
 =?us-ascii?Q?6nbMINsQAq5XXbl3HjS6repGaBE7ou11Rt0CdH186oR40yIchQC3qLCze+L8?=
 =?us-ascii?Q?PKZfXEPFSAVW5Pc0QjTuTZDjj8YXPC2uZ5u9F/mqP3oDCEFW76yNm37+vqZE?=
 =?us-ascii?Q?rqYvMSR2DUj52FVDOtrijRnFGbRKhU1HHGwLuYdNcgEIXB9cWadX1lkmksnD?=
 =?us-ascii?Q?BHY9j58fNvfkq21Di93/e9086SwfesC1kPHdvPFKpyGSvECm1g/FN9AXgjwp?=
 =?us-ascii?Q?pTzUa12+9ln1xQUzk7cTvWaQB1uZ8l2qnE8vVrEjIJN3/zMQJU7dRNRUqF1C?=
 =?us-ascii?Q?uuPwz9iCo0BtD5riSdYPsx11go1Cw8NUp4eWqfqidxPC9BdgmLZqS97XSwXn?=
 =?us-ascii?Q?8fmsIiCXNi8QIe2sdXF0q54MsDWmgRAE3vkaoKpl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad300b5-fc55-418f-6072-08dd4b07b894
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 01:51:09.1401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T95A1LYYV6lQxbuggTRKQ4vLYZPszRId8brs0EFr+LNYWTf5pZQafIEub9/Iv2Ur
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928

On 11 Feb 2025, at 19:57, Zi Yan wrote:

> On 11 Feb 2025, at 10:50, Zi Yan wrote:
>
>> It is a preparation patch for non-uniform folio split, which always split
>> a folio into half iteratively, and minimal xarray entry split.
>>
>> Currently, xas_split_alloc() and xas_split() always split all slots from a
>> multi-index entry. They cost the same number of xa_node as the to-be-split
>> slots. For example, to split an order-9 entry, which takes 2^(9-6)=8
>> slots, assuming XA_CHUNK_SHIFT is 6 (!CONFIG_BASE_SMALL), 8 xa_node are
>> needed. Instead xas_try_split() is intended to be used iteratively to split
>> the order-9 entry into 2 order-8 entries, then split one order-8 entry,
>> based on the given index, to 2 order-7 entries, ..., and split one order-1
>> entry to 2 order-0 entries. When splitting the order-6 entry and a new
>> xa_node is needed, xas_try_split() will try to allocate one if possible.
>> As a result, xas_try_split() would only need one xa_node instead of 8.
>>
>> When a new xa_node is needed during the split, xas_try_split() can try to
>> allocate one but no more. -ENOMEM will be return if a node cannot be
>> allocated. -EINVAL will be return if a sibling node is split or
>> cascade split happens, where two or more new nodes are needed, and these
>> are not supported by xas_try_split().
>>
>> xas_split_alloc() and xas_split() split an order-9 to order-0:
>>
>>          ---------------------------------
>>          |   |   |   |   |   |   |   |   |
>>          | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>>          |   |   |   |   |   |   |   |   |
>>          ---------------------------------
>>            |   |                   |   |
>>      -------   ---               ---   -------
>>      |           |     ...       |           |
>>      V           V               V           V
>> ----------- -----------     ----------- -----------
>> | xa_node | | xa_node | ... | xa_node | | xa_node |
>> ----------- -----------     ----------- -----------
>>
>> xas_try_split() splits an order-9 to order-0:
>>    ---------------------------------
>>    |   |   |   |   |   |   |   |   |
>>    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>>    |   |   |   |   |   |   |   |   |
>>    ---------------------------------
>>      |
>>      |
>>      V
>> -----------
>> | xa_node |
>> -----------
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  Documentation/core-api/xarray.rst |  14 ++-
>>  include/linux/xarray.h            |   7 ++
>>  lib/test_xarray.c                 |  47 +++++++++++
>>  lib/xarray.c                      | 136 ++++++++++++++++++++++++++----
>>  tools/testing/radix-tree/Makefile |   1 +
>>  5 files changed, 188 insertions(+), 17 deletions(-)
>
> Hi Andrew,
>
> Do you mind folding the diff below to this one? I changed the function
> name but forgot the one in the xarray test. Thanks.

From bdf3b10f2ebcd09898ba7a277ac7107c25b8c71b Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Tue, 11 Feb 2025 20:48:55 -0500
Subject: [PATCH] correct the function name.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 lib/test_xarray.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 598ca38a2f5b..cc2dd325158f 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1868,7 +1868,7 @@ static void check_split_2(struct xarray *xa, unsigned long index,
 	xa_set_mark(xa, index, XA_MARK_1);

 	xas_lock(&xas);
-	xas_try_halve(&xas, xa, order, GFP_KERNEL);
+	xas_try_split(&xas, xa, order, GFP_KERNEL);
 	if (((new_order / XA_CHUNK_SHIFT) < (order / XA_CHUNK_SHIFT)) &&
 	    new_order < order - 1) {
 		XA_BUG_ON(xa, !xas_error(&xas) || xas_error(&xas) != -EINVAL);
-- 
2.47.2



Best Regards,
Yan, Zi

