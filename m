Return-Path: <linux-kselftest+bounces-28331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D90FEA50BCF
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 20:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056F6189518F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 19:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE825252910;
	Wed,  5 Mar 2025 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e0QnEGXX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50142512D9;
	Wed,  5 Mar 2025 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203959; cv=fail; b=GQUZREjUb7k+4c8B+bztcjUVmRFn/Nqk1gVac6JVK3rCnXAJPev+iNnzJye2yJdWmwbS0R/Zn9HXOIU2iBup7PX+rLvoNQ+DopgYPhpVfJtp7Sn+nxCT5k+ntY4oVwQLl29i5HFx6Eq5gZnFTHt94NmoFy3eIHQsdWVgmp3JG6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203959; c=relaxed/simple;
	bh=hftiWghKfdNF3/XKNLTA6DebwK5O4oYxaYshVLjefbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rbhYmNGwhIqC25u54wziwoSuB2ogCmwpPOksRJOHIJu+5uvBRbCaDjXyWE6AoAF9KOTivLe0w9x/jAg1PshOKrg/lXWEUSihro74dtiSllG3hxEYPlJfONVAeVf3f2ORTrqk575ndVrz5gHzSNN0/kDao9qvaVu9LMCpJaP4bj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e0QnEGXX; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXh97coZqds3hIvjXoJ6axyjlfU6BZH95iyQ2PeSJqo6EmN+HnEYH+K7NuJnGCtjlW0L3piTlsO6K6f9Mz61oSpzSRXHjE3HFBwrbMZR/pyDW63RyRKFGyFRXZsTaLCs9g4lo4qhgttf3aauY+IjqKZHZy0OXX2wpOgVDYxDhLQ8kn/elRJV48AoBfCGyGGEdbSb81Ox4+XVqG0OO9IGQRll96G2I2WA7P6j29ItPXXJK1E7HbB0bEmtf2j2OoZMnGzVrfcf2PiSC+lorZQ+UOT0frW2XHupcX+HeUIKvQHo7oHkgkyPKjBSwtbFybWVKVZFfgziuRfJosMfYTVH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtlYbt92Fg7Wcd8LttyOLmhaTEOcLNlDgVnJuBai4Zw=;
 b=qLrVwKPOSj9ytv25RMikTg5TCGk2Z7yQVF+HNwx7ebowmCdddFpPeBNjpRa0t3gv12gn8BBBbbLnz45hZDJupankIxyig+a49g4TIzMfALEmN82niRxBfZpo/Rj9Xr2Eqb+3F1K/1aVKjlxOHBOUw26DX23yM4m/8K96aX2EE1sBDbswtMm9ONnlXquc/GOC+GIKqaeWbK+s8hB14ZVLesQVSq0rU+/fOeiqDu7dcdegOGtVMDfAcj7bjG2uaeInnJFo002743PtN1mODd+3eaEofIZmrECLSwmGm+EAIUC+bFIJx/1JvRS/3Mu1hiXi/J8jglXWq3mKDt6xx+y0Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtlYbt92Fg7Wcd8LttyOLmhaTEOcLNlDgVnJuBai4Zw=;
 b=e0QnEGXX8GB0nUe/LvqRCftzrvUa9T8GhOF029i6lG7Mlqp+BY2hlW7FjYQfptf5hWxIw8K5FX8hc55LSqxMUM0QG5Gy4gW1x+hOxeCUALmcJFx9IdE1L0JfqyBpVsexloWVCLgbNCg4RYpyfyc3Jnlrau+FeidIlz/2Uwq8vWmBhYhb+H3imkaYeG16OPFqaDzS76WE+Sus3XBT6D5TlvSo+AP4AmvDycI1FYc1hT6OaQNwJLffBzYihJ73+QGc/sDVdyftBn59aMJ0MO+G1M2XYGr2d9M0Bxsp9qhMywN8/f2EVqgnECnL/WICx1Dk32CZ+UIds5d2oWAxuqT7lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Wed, 5 Mar 2025 19:45:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 19:45:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Wed, 05 Mar 2025 14:45:49 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <FB1376C8-E0AD-40CE-BDE8-AF9269EA68CC@nvidia.com>
In-Reply-To: <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
 <20250226210032.2044041-3-ziy@nvidia.com>
 <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7ce0fa-3907-4dc7-a1fe-08dd5c1e5755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jPplYyCMjdj2WhY7bXW2WdJeBGJO/SKKoBzyPa3gT9b86M113F/MnjuJK4h/?=
 =?us-ascii?Q?1iCOWgiUgosTUsKayCb8V6UwRQgJ7GuAsJWzP16Dizw7qxIdM0MJYx0wVMP+?=
 =?us-ascii?Q?eXmXEeLdW41hlnEwdh+poIrKH7y2mX0hc9fhakg56F62SAsV31CqX2wXlbK+?=
 =?us-ascii?Q?CK8M+5oaYuBc9Fj0avU9uh85e3uY7owrxbbQAkaDlJT8oUSz6Rqk3evcAuVB?=
 =?us-ascii?Q?zeSYYfic9l9V+73WmGURqvqa58PXcrIL3irzuqn89vUuEIQV5F0qyIQssksl?=
 =?us-ascii?Q?hkG2H5BIzpIBSmRmyPYn+4fltuX3i6S6NQZ7CIN3cXgA8Q9Mi5QudfAyuc7b?=
 =?us-ascii?Q?KVJ6E1dzxS0svyoF54d/zKK+iUviaAHxCAF98xKZCzGfv2yU5RLYrwvEZybi?=
 =?us-ascii?Q?20ZzVk6C6s2OUu6EF7nf/zgUSf70L/nO9VFqr867kLlmjveA3SjIl57Gac0e?=
 =?us-ascii?Q?zZDcTf/o5v2XEyCMvE+24pQ9LAMabvmn1eMlfgmx06VcYbf6v+1JyuiQw0zf?=
 =?us-ascii?Q?e2R4i+BP/0lKRRaSkHxWOJKI72xirVV41bB7FmHcUxYIXuoqlr87e9KzEXBy?=
 =?us-ascii?Q?mdRnJ9lyZ4gmbmMQqsSVT65Stu+sSaoeidrqEuaMflDrL2/nlgVKeggbsaRt?=
 =?us-ascii?Q?rbXNMHHlBT9a3gy/WBxIAKf4AseaUXgWn9hI0nN4HnhwIqqG5kmGDsrTzuwQ?=
 =?us-ascii?Q?NfB1e6kA2AzvCNQ8umufVa1DvHt6DR0362eiER5X3z0kSqShleOevZkr2qWu?=
 =?us-ascii?Q?jj+S0pfNER59HXe0di0AgIn8hwFxLBvGF1qmnVvTgCmfCJVuulYQ2Q/38XZj?=
 =?us-ascii?Q?0d4gY3wauFiltuj+DtguG8I2fq8+ysBuOhCr1bBuiL1y12ST+jJ7bI99n7gw?=
 =?us-ascii?Q?OLw2EOeoNH3qRxaw+T/ebNuc4sxzVBJpXX+jHfCuSXw+KOQog7cuo1pBA4iV?=
 =?us-ascii?Q?Jw+g78U+hvVFJKG2JDwIdu8Y085mVHo513jVhhrKdLk2FZDtnunlAWBUhmo/?=
 =?us-ascii?Q?aYSiBL++uH16XA9OcFNS9HTrcZMI6q8FGrhlj9kqPKHPuziAtM5FCWpwhxWi?=
 =?us-ascii?Q?XZhqUg+Y5aarJYBp2NcXqPQ4dsKBURBN1IhOrwbCtOF3GFjZdveNTqSz7fG8?=
 =?us-ascii?Q?DCs1PaBsvb5/LBmomW8VKFtObIrjc7Xkuzrs5T4z6bsQ0r22NrU3xeSiFDrw?=
 =?us-ascii?Q?78yl7QhNyoZeFCW/DrCd80Sj0EJzVrkt2zUM3fT3QnJ/cSw90s8+3MZs5H+m?=
 =?us-ascii?Q?bs8Mb8bM7rlJSF8iOjTSc7RaS403L8/wOa6rf25mJ6Rq+oQw+1T8j5pEDtbU?=
 =?us-ascii?Q?EO6ITrs2ef2SrXvna62gVmytiCFOMgNLyU0ZQEgDoW0LGl5quid1OhfQcO2o?=
 =?us-ascii?Q?5mM1YOlClgJL+UwExdHJVtvWt/+2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ypCUe36yX1MfF/exhiHnes419b1YecDMf78RSsSNlETEwoIVqpZQZSK3DvNs?=
 =?us-ascii?Q?kj57/qKE1yU9DAjTUSnXvEJBSS5w3fb6CcOv7giQ1obMIno84LJfjjYM1Pq5?=
 =?us-ascii?Q?evWE+RutXPJWrnTLLQaaQgjqn9oHBQdcIM34zu45xEMhGiSPb/LMhWVc0kd8?=
 =?us-ascii?Q?euauIu10PHn7RcxiI3jijYw6X+Y5DYJ4vJuHxztcqEjCal/GGvRBOwrBz0SI?=
 =?us-ascii?Q?obRBoAt2cpsQHFp0/UUFr7n3K2h4FSL3bW2WiSY7bi+0SsKDRrL5VEF7bmB+?=
 =?us-ascii?Q?DormsunKIijCosQfFwr28wWO6+6PmtNkdBt/5XXvJb6dQpdVswD2BtYjfozj?=
 =?us-ascii?Q?JR5HqJt2cuIi6R0vGwTi/gptbhFsmK4glpB0rgFiAWrGeOJHtjML2nWiZDrG?=
 =?us-ascii?Q?GpMv3arAyX5zFMKwa/xd5OEL2OW1y4kw+pJJVprKO+SO7y/Eahn/x9bw70Iu?=
 =?us-ascii?Q?B+Rouk1b6sfIU9Qa923vT5xPvsofwFpchpYvHYW4dwVG2Z2mU2ITBsdO0o/f?=
 =?us-ascii?Q?pf2gG+pzHltMSHjOqKHrqun+BUnh5BKap/mkL/LqKsORudo3DZaQNZKQcLzo?=
 =?us-ascii?Q?rpQA/lDAmk4amb11AQ8EWg/KyVYtF3CZtHjIt/fvv3OKIcMxt1HLaP6gs1uv?=
 =?us-ascii?Q?Q/3OBRd/CabtlLyiLKbq+fGkCom7H6tRhkwHoSgI/XZVUcX2YT3wcih+vQv9?=
 =?us-ascii?Q?Rp5RzZBrVVnoFrp6StN3/XwVHFUYj2UJDtVZ1M8KlGDltjfWX+KfALH9LqwW?=
 =?us-ascii?Q?UyOEKBPc+6rHvgSk6qIhrW6ORWIIQjO2U3/i6E3G3siP5xN5ZQapmZ6bWIDY?=
 =?us-ascii?Q?nvwPXku7Y9qlSu5bW5PneHjGWvxGeMC9VS4ZkNtl5REDRFfb0VNkXQlfHwp9?=
 =?us-ascii?Q?Rwr7UIfz9yWPNr60+3xNOal0eZhkCwMcJjLaLEHFbWt5Kwi183Urue9WqbeZ?=
 =?us-ascii?Q?HaxxKyXKB9BRmP+vJsqcdG9H6Z7yfjN+6lzo6cAGZLBoBIcRVfsmyI4a1Xrf?=
 =?us-ascii?Q?v7eiNnmycLIy4QsLSVcUZKmKVypdooXRbRpXwJ1R1Ibw7jaczoDpLz0gNi3+?=
 =?us-ascii?Q?QNudYymeyVBcSAQMS1ZOCznPlVo+RsH7KgjxmP5u6x7/lA/Sgtsrygk7AshV?=
 =?us-ascii?Q?ON69MabiWRyrwJTOgo+sVX0p0uKXEX4PazGrgkdgVTB79eDnidKlyc+0K3Dp?=
 =?us-ascii?Q?pUZBO8EO/HnAONCP0uHYcCZCl2BbXQvoFIz5fVpbZmHgw0TO7i93Go8x9yDk?=
 =?us-ascii?Q?swWbr0iMRpk1+wai6DZEe6uyf+Q+iFTFYoxKHzBkhKsJ3YrmvnmxPKKF0/hx?=
 =?us-ascii?Q?T1+Md6wodY8FxvlRZUFWmzHigutCIxkwYrdMnKRtaOrU/lWUJ5DobK6WOrmQ?=
 =?us-ascii?Q?XUgIjjnFUnzLFu6LGrZhR1gl9xEwZaCx4FH3+hM9z+QGmEo2bU57I4CxuVM2?=
 =?us-ascii?Q?xcK2qecGba8NfLv8D88LN2Mt1kCaOYzwzeW+8A1Gl0Kol0kZTJk8V0CZXzW4?=
 =?us-ascii?Q?ar47HikT0YhKONyBqcEgGhgGfr9ePppZ9AVkQhinwjOoZzedgIKh+WFNukua?=
 =?us-ascii?Q?ZY7CwzsuAnBSnbV0+Wk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7ce0fa-3907-4dc7-a1fe-08dd5c1e5755
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:45:54.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcAUgNxTxpcw7T4ul6EYxf+3LAH0+lkbAs2XYWzygMvVBx3RfnlPjyPjneZocuSv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270

On 4 Mar 2025, at 6:49, Hugh Dickins wrote:

> On Wed, 26 Feb 2025, Zi Yan wrote:
>
>> This is a preparation patch, both added functions are not used yet.
>>
>> The added __split_unmapped_folio() is able to split a folio with its
>> mapping removed in two manners: 1) uniform split (the existing way), and
>> 2) buddy allocator like split.
>>
>> The added __split_folio_to_order() can split a folio into any lower order.
>> For uniform split, __split_unmapped_folio() calls it once to split the
>> given folio to the new order.  For buddy allocator split,
>> __split_unmapped_folio() calls it (folio_order - new_order) times and each
>> time splits the folio containing the given page to one lower order.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> Sorry, I'm tired and don't really want to be writing this yet, but the
> migrate "hotfix" has tipped my hand, and I need to get this out to you
> before more days pass.
>
> I'd been unable to complete even a single iteration of my "kernel builds
> on huge tmpfs while swapping to SSD" testing during this current 6.14-rc
> mm.git cycle (6.14-rc itself fine) - until the last week, when some
> important fixes have come in, so I'm no longer getting I/O errors from
> ext4-on-loop0-on-huge-tmpfs, and "Huh VM_FAULT_OOM leaked" warnings: good.
>
> But I still can't get beyond a few iterations, a few minutes: there's
> some corruption of user data, which usually manifests as a kernel build
> failing because fixdep couldn't find some truncated-on-the-left pathname.
>
> While it definitely bisected to your folio_split() series, it's quite
> possible that you're merely exposing an existing bug to wider use.
>
> I've spent the last few days trying to track this down, but still not
> succeeded: I'm still getting much the same corruption.  But have been
> folding in various fixes as I found them, even though they have not
> solved the main problem at all.  I'll return to trying to debug the
> corruption "tomorrow".
>
> I think (might be wrong, I'm in a rush) my mods are all to this
> "add two new (not yet used) functions for folio_split()" patch:
> please merge them in if you agree.
>
> 1. From source inspection, it looks like a folio_set_order() was missed.

Actually no. folio_set_order(folio, new_order) is called multiple times
in the for loop above. It is duplicated but not missing.

>
> 2. Why is swapcache only checked when folio_test_anon? I can see that
>    you've just copied that over from the old __split_huge_page(), but
>    it seems wrong to me here and there - I guess a relic from before
>    shmem could swap out a huge page.

Yes, it is a relic, but it is still right before I change another relic
in __folio_split() or split_huge_page_to_list_to_order() from mainline,
if (!mapping) { ret = -EBUSY; goto out; }. It excludes the shmem in swap
cache case. I probably will leave it as is in my next folio_split() version
to avoid adding more potential bugs, but will come back later in another
patch.


Best Regards,
Yan, Zi

