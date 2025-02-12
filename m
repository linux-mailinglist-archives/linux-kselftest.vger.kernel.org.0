Return-Path: <linux-kselftest+bounces-26440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A6DA31AE6
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 01:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA09168607
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 00:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6E68493;
	Wed, 12 Feb 2025 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rE4hAMbI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADC217993;
	Wed, 12 Feb 2025 00:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321841; cv=fail; b=rcrSsJthkXJ0aRJ/NWmCWgfEvmIEeBciCkZMm2jPdtacRuAo6ZkAdYE4l9yxqT4kuixP+eeVlOGl5hGp52C6VND+U9+7UM8AHMD/JVhXSAofI3XwDi87alUr9PW7VptXutXg7C59dnQTz2/nqb8UJmTrAuHVvRD3BjL8snXQVms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321841; c=relaxed/simple;
	bh=YBZ3CgZGPpVXyznQhDGyMHNftf+7084r2bWmSkCbPbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dBHRaOOSir3CdD8PyiSCGmf3kTmNW9tuF/NuYfb5GCq0Fx19TpDc4s4T6dmYUPJcnq7QLotDjcnu0enbLR7QncEM9f89JX39+gPwsWlY65i8eeibZpJVcuBXNg8S72fDXh43erdgAqbr52fbKyz9kpgJuqPXq+4Cx6sn7MBdPG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rE4hAMbI; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuph8pN7K26dL4uIY+UB8kYjYJPIHrvYXK9W5FWVlTcl+WeQPAKtI0G3Vh+mXh0MDqliCX2rE1w1mSzYLTzEojKJN1sDPaeu6PXMtngRD1FXAS4Td58fWh9DYWthOkcjaSLwjVjhGKV7Xv8SosNzC0YeGvx01FECA09w0lGDh4IRj1lWcx1JTffpsC6M751p6mx+mcXo77vxNyaOfttMTwxv5aLUwBfE1t1jbxgi1I+YueUif64gUs8AmdeG7JS+00BurKGDdYTdTHSLX7VibuaevHAI+AbOzI1ikGUEJjrzT37tbAurkTcJWF/tQ3R1SojRHAvBeLBsFLm16Zz2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiOx7rM44Y55PHYqRJXFNrWgBHBsLyAKFBkpiLEgXdI=;
 b=YKT/CqegmstG7V2EoKWALT5Ws8GAeadavLVNOTP/nLhpB/soiFDUxH3w/Uu9c9kcfIDMIy9VYEq2BF1IC86ZM9EMbLWQM0gUfCIRm+bAakqXfRps1Kj10563xQ30lJz5d7qnKfGA0luY/A4z1cHG/EhALjLfDGmmfTdag3ZccBdtvfhVGh+YkoF2WMHNGvqSuUjcm28tUdHIVwwceNQl2HmhGUYp4sXNoUQG/v7+wxsaIah95/GKb544sMZWzChnLIOs/jC93pN0NiepJgYKL/ckKQ/I3x0UBAxmZGSi9KxXInHCDVRtdzQkPYJzTAQr7suUQtQQv/vPleEh6Iri5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiOx7rM44Y55PHYqRJXFNrWgBHBsLyAKFBkpiLEgXdI=;
 b=rE4hAMbIUW0IXlGgz5BjWwJZfF8IfYDJd8dB/RSBYXMgJWf8w19atV6BnqMbhECTZPNEdxOZS9X5yArKF2AzQInt+j1xOTxQpgbGmdwUthFdpFlA1KnQKh6RnRyGoikgWnPIi5SeTBLjHq2jV/A3kFrvcXJj74RBUx6FeH9voCE5+JOxoeVeOheLh4Swq6IkwTtY7SYKOWqJraegJvkcAIyyOR+BYuCy7rRvJ+IlEPbKewANhiBMS/rq3brWnph6Gt34GNAvqnpkPq8koRsKOyUps7KovKVWrcQdQHVeXaOmHQsIttqrcyy6ZF4oq0JHxrUULCUHTUQq4Pjt5EE3wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.16; Wed, 12 Feb 2025 00:57:16 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 00:57:15 +0000
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
Date: Tue, 11 Feb 2025 19:57:09 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <3BC99886-609B-4820-B65D-FCA2E11A02F3@nvidia.com>
In-Reply-To: <20250211155034.268962-2-ziy@nvidia.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
 <20250211155034.268962-2-ziy@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:a03:331::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f85193-78c6-4130-c7a8-08dd4b003139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GgQv2CjCn4kZJpsP4GPcWFUOMaNszhEsgL9MVSIUbO7RRq8Ldf1gZrgx/CG+?=
 =?us-ascii?Q?1uBvT0KLQzW8Vm28qdgQEKZ7KhsKsDuXYhPM57p8MVZDDRLSTLcuGiPmDLnY?=
 =?us-ascii?Q?gaVBsGt/FFDGj66v7F+Fg4mXYN8EZBWsRA3xQDFkrOjhQ87a9iPddKOToV3c?=
 =?us-ascii?Q?bb8rQ6XV1YWTdgSl4GsbooyEcqPIX1sMy+5+E0ybwwi6S7ljfw4vst/UuOGz?=
 =?us-ascii?Q?I475s9w55KRD5nOCipnk/c6w7P0LLdnIqjl/kUBH78Z32lFZIHehan7matjS?=
 =?us-ascii?Q?Gk9YhESFBBvrZ5qjGlcQNYB3GYEhs4YVNZxXW2EKZyrbJvxIGcTivg3m1B0a?=
 =?us-ascii?Q?MhjhvLHbFS9NkYfTbDcRCrXSzjKzeQP7RwSoBwmepQTiYgdsYSqVhPbSiztg?=
 =?us-ascii?Q?ChIPhxcHxYYRHs0MkHV22LwgmtrH78m0Xo8kJ7gAf4FDHVjGZMyeELi7u+cm?=
 =?us-ascii?Q?S/AAau0oQ0u1z30SH3l86lCAdDTpFuIERzH1/tWP+k7ADVj7GFMnUme/y0rd?=
 =?us-ascii?Q?vV3ORgmLR4/P0Qai/PPeVCf8VVlwEAdbL15cwX2Vj1SQpF440v3EQClvHQV9?=
 =?us-ascii?Q?dE+WpKOkEZMAx25tATsn7/jiQsya1CHmvgzvhtVhT0tzQy8zquQMvw/bvHJy?=
 =?us-ascii?Q?PYSmPg3zMtyUryHcQLe0zLCHrQ6HvyEwYBDRvmR2/jPkTJIUlwNnCjAMxISf?=
 =?us-ascii?Q?6NX1SGOEPh7oJ7/Aw7TQAQGfMsZAdNAtDk5X/vuhv/M5dltnsOrmkpT6oIwJ?=
 =?us-ascii?Q?HmuekZsaZYZZ82QY/RJXgDe51OPehORVd2JrmH7L5NAzHERIhi/nzX634Y9r?=
 =?us-ascii?Q?MmH3oqO9bhQbHdv5qbR82pBYhyOQqWWH6koyUDTcQdJ9p29ITvYVbKbGnsIF?=
 =?us-ascii?Q?WMKI+RpgtM/WNOpZ3oFnx4VJ1/qeRn7kKIOclxG9unHfn9vzjqI8Zu8GufdQ?=
 =?us-ascii?Q?8erXsQmFsOT9KvONzxavBPI2dwsWqK0eMfg6RlVpw4yCtSw+QeONKd7nH7ym?=
 =?us-ascii?Q?zoy0dpn5yvo50tu0I9jOHm2oNYTOoCzgx8/aW/V0OrLg4WYHo3tul7qDsRw8?=
 =?us-ascii?Q?aadyUMqvQQ3dQvwMtL79xC2AjAbZfdEBAvQg6vc/zjhq7dH20fF0Hq7/ixeI?=
 =?us-ascii?Q?mBvujJZDL4QQt+/SM5+z4N5JRkgxks00kGeUvVGaVGcJDVxRXFJIIkpA9GSN?=
 =?us-ascii?Q?B6Rp4hwJqZ6ptKQ4rEw8eBkdxzjKdjG9RkqJ3FU2o0Vv3lFEv8F63IPhjwNA?=
 =?us-ascii?Q?nGyv9Ge36rhpq2d6AWJhmJ1xHxl284ck4BzLTVrCs00JlHz7pWRhn4BuV9N2?=
 =?us-ascii?Q?DV57CRv/uGWeBQeU2qBH0nS2qE7VSmVhlgcnyi3QOSdH9NEdA/h+JS53Rv30?=
 =?us-ascii?Q?gfbyt8ibBO5t0SI0LzQ6P4k5tRQ2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hvz48XVzw3lXj9gx7cVo0UtWNV+sy0wMcU3koI156EhzDtWEdvoNGy0olIdb?=
 =?us-ascii?Q?X4Wnw61OdfomJg4CSrm/RNZx3wTUZ0fSToEM+UY3dbkno3PT/0nONwHKGG0y?=
 =?us-ascii?Q?6NFKOQqY/VkCmEijw6WBSmz82Ea8kwMMrrbpB/mgaicvPlol2S2HhGfFz2Qy?=
 =?us-ascii?Q?U1Z5q/YAEqolzDXRCbC8JogRWyjcnMy0zR57mOAUG6Pb+WnquL8JYQfwz5qC?=
 =?us-ascii?Q?N5dKP6vIWauOTl+/eniHLK5i4abqIaEu6k3mP/Z2S+oEBjshqpqMleBoPwbZ?=
 =?us-ascii?Q?S5YoTXH9lgGxyXfwYQtq2qsYGpkSONmTQPhav6opao4+PtZDALWU1I58K826?=
 =?us-ascii?Q?dcky6cjGT4dporNZcGge+Zf1zev2I/n7LL45BnogycmHeFf7PkyCZt+KflM8?=
 =?us-ascii?Q?AJPf3w4ciKyxUMfUVHa+zwc31Klf9CXdn/dajQLTyy5VV1uJjG5bkJ+yZIgr?=
 =?us-ascii?Q?BSEgPuutqEhVYhNQjYlITyw4F3m+2+UNP/bK+IskokO12ek9nma+eO9u/1p+?=
 =?us-ascii?Q?gWP0vRuPKlbLZhMQujpi4dhll+GjqZr5UTiQYLj2aMigVAJH4r0Qj5fxhxcc?=
 =?us-ascii?Q?0KOva0c7aXMf0nm2Xh/MTZ7jTtOPK0/joi//XVU7aWj7d/1ncmgd4I8NYfs1?=
 =?us-ascii?Q?SdbPX1J79S7KWpIp78UFA/MkrBwOixTanGJbbzzVhrQlUlWcLpt+b5B/81Dw?=
 =?us-ascii?Q?oeu1ZI4pT+BvKUnxORbthx/jmhsU53J8MssqbwrQBXsRCDg55VB6ju4/xamX?=
 =?us-ascii?Q?7Us/KaNQrHS27RUOoMaF1ZaI1qifFnO2bO0zzKc+qfjNsYoiXBbPQYpGJQMv?=
 =?us-ascii?Q?moYd/4cAzjl07WXLzxV7bn2btEDgE41cJmxiAnZJ27iTgLfoP4g43GXoQuuw?=
 =?us-ascii?Q?FvP8ePuu1vFI3FHULK+NjFN82Q0Qa4MDasd1NxNJs1DZbCNJWSb88Vc34Imn?=
 =?us-ascii?Q?UkhBOQsJtU234T/UpakiGiJRJ+gaf1LvWXNOT7AayB1GlIfjqBHTUafI0/47?=
 =?us-ascii?Q?JJnpYQGO/9iHQ5JLaaLz4jx4sirm4rMkYjFzA22DdWYg89eN3hOvhBk+Wi5+?=
 =?us-ascii?Q?3h4r1ifdqNoVwilfdcdH4mVRZmlljBPzs7X4QHCaTUd7NB9ZnALVGzvppfRT?=
 =?us-ascii?Q?ywyvMqCxCnV1ZFBh9A+LddOCtLItnpW/MqSK+41o5O1If9kOTFaBQCmeOZhZ?=
 =?us-ascii?Q?edTXgxQ6JHB0UZeh9MCi8wSSTEaz+zwb+76K6o6YUw9VJFkgkjolsuZ7DjRL?=
 =?us-ascii?Q?KKNBeACSCCJHZ2IoOvVNOiuA/7K2k3fafJFvptaNmydw6cfLVmBkEmIA5ctl?=
 =?us-ascii?Q?awveGUrX0gtlQ7zETP7RQ6LYxuYWqmbhLvbHRZBdOjwLxURsW+ToSui/aEoG?=
 =?us-ascii?Q?BOIC2yCFFnQVQ6ZksXDHp8SvD/kM48jIbOXBTET6wFJc0cDcFnZVkgr/PPyP?=
 =?us-ascii?Q?ZMrYLBxCciC4uBFtVo3ML62sfiLDuhWL8Jpv8CvNRzIsYQvSCebNK2O1xqEU?=
 =?us-ascii?Q?vrMegrphh4K7yQjMC5pP12ASZEuU7VDD2aIN/Bi5y0yd4CKd9mfFw3npsFJI?=
 =?us-ascii?Q?yhMwwybGK/FGjvbTxEuO2RZA8InA0l4+ee19mr9f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f85193-78c6-4130-c7a8-08dd4b003139
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 00:57:15.5415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rG0jkplEcSA3sqIzodItrRm4Y6ewRHNX3EVvzFPrxOapvvKJiDCfedrgkAerhEc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794

On 11 Feb 2025, at 10:50, Zi Yan wrote:

> It is a preparation patch for non-uniform folio split, which always split
> a folio into half iteratively, and minimal xarray entry split.
>
> Currently, xas_split_alloc() and xas_split() always split all slots from a
> multi-index entry. They cost the same number of xa_node as the to-be-split
> slots. For example, to split an order-9 entry, which takes 2^(9-6)=8
> slots, assuming XA_CHUNK_SHIFT is 6 (!CONFIG_BASE_SMALL), 8 xa_node are
> needed. Instead xas_try_split() is intended to be used iteratively to split
> the order-9 entry into 2 order-8 entries, then split one order-8 entry,
> based on the given index, to 2 order-7 entries, ..., and split one order-1
> entry to 2 order-0 entries. When splitting the order-6 entry and a new
> xa_node is needed, xas_try_split() will try to allocate one if possible.
> As a result, xas_try_split() would only need one xa_node instead of 8.
>
> When a new xa_node is needed during the split, xas_try_split() can try to
> allocate one but no more. -ENOMEM will be return if a node cannot be
> allocated. -EINVAL will be return if a sibling node is split or
> cascade split happens, where two or more new nodes are needed, and these
> are not supported by xas_try_split().
>
> xas_split_alloc() and xas_split() split an order-9 to order-0:
>
>          ---------------------------------
>          |   |   |   |   |   |   |   |   |
>          | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>          |   |   |   |   |   |   |   |   |
>          ---------------------------------
>            |   |                   |   |
>      -------   ---               ---   -------
>      |           |     ...       |           |
>      V           V               V           V
> ----------- -----------     ----------- -----------
> | xa_node | | xa_node | ... | xa_node | | xa_node |
> ----------- -----------     ----------- -----------
>
> xas_try_split() splits an order-9 to order-0:
>    ---------------------------------
>    |   |   |   |   |   |   |   |   |
>    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>    |   |   |   |   |   |   |   |   |
>    ---------------------------------
>      |
>      |
>      V
> -----------
> | xa_node |
> -----------
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  Documentation/core-api/xarray.rst |  14 ++-
>  include/linux/xarray.h            |   7 ++
>  lib/test_xarray.c                 |  47 +++++++++++
>  lib/xarray.c                      | 136 ++++++++++++++++++++++++++----
>  tools/testing/radix-tree/Makefile |   1 +
>  5 files changed, 188 insertions(+), 17 deletions(-)

Hi Andrew,

Do you mind folding the diff below to this one? I changed the function
name but forgot the one in the xarray test. Thanks.

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


Best Regards,
Yan, Zi

