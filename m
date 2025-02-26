Return-Path: <linux-kselftest+bounces-27663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32395A46CE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 22:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946303AFAF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EE825D523;
	Wed, 26 Feb 2025 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BNp4HE2u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6E25B69B;
	Wed, 26 Feb 2025 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603658; cv=fail; b=j7DyiGxqb+FvBkmidA30KgfcM0jJGd0F6rqt5tm1pvNS0MQBOfTR5UZn646YWDRAIXU0IyaNXHZab00uw4zxH8qvzmdy1ODt18tJ8RM/5nTfh8wtSCSY7fC3r7At5LqPSTJdBKoINmxZvZdYvmvme2G2CP5t6uLQwVa9Y/LZqFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603658; c=relaxed/simple;
	bh=d6XPL6ID//oandK2vA2xMXuU8DNgWr3LTiwDd7X8wHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GmZMLY38xIzf/Dfy0/rqgMFVcVTxyA3c6ywu7xo2Do/3cm5tmpwAKo/AZzGnM+4wyp4JwWyQuCvke9rMbV1N8cUc4j7azo9/i6w4pkCFH5Dstv5i/AsvuhYcrQ4ENvMADV+H9pR4j6/kiePdSIaSx4sqqii37xIqPXBXaXJCo/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BNp4HE2u; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVBUd34XvBFH09M7Zv4o5b5JUYZ8Gm2R9D4ybpK8DrxDQ0ixYxDNcZMF2YPWj0d1ctuf8IvBTn4HJ9EszcbVQiVTCDUwM3t+X1JoYYPVCxMREOWs/Rfs8P6FKtKrU4LWbFPkPXLL09EPKV1rApScapkrApUdRj6LfbMFGSbNi5qDqoIVHvePbMYOcQ6hjL55h0yjzXlF1k+IvHxh/Qw4p7aeBQj1Ri9V9A2jxpxlo5upZxoJ7LOb7ZohkFxkTZ8LAr2OURH1QbEgAxw3XOjgMe4f81RJIcfEPHQks+Lr5Od0vXE7VRkmcQr22KfyWxORT5ZMEse4Fp9O4TVG1QCM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVB3sAbOYuU/dEFZpxWeEKONWQpJMbcUuFfvNBZyBsI=;
 b=L7DFs09xNgjT1fifIxL2CThRtE/W6YKekrVWhajMcdB4OIEJexXP7lrIwmoTJTkUvJzRhQkmPYexQO1CuCFFaPchkb7IhharNSN2PsqvqyTG9XvX9hoLM8JSbjj0JboGSGhLgzPa+l/00xlkDttleObECochNjhA9nmXqkbe13fmkE/u4J6SuBvKa40zNWluD5nVFQyx6pZdb/rUD77+921rQ+cwmQCOpDXjhsMTOMN3W8D3JBZmE8hWui4KmqLFbnJq/1qX6WHWqYizLaDWOVtDnQT3LEfLN5i/8ZxyC8nyeb/B8IkwFLiNxb+pj4YwrCMZp1dBavYzey/UhVlyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVB3sAbOYuU/dEFZpxWeEKONWQpJMbcUuFfvNBZyBsI=;
 b=BNp4HE2uIPTsZtY3L7BN/x6qzX2GRntVD/46x51K2TH9iCnaGWFOr5MhyfTOfILzHCsEPFSpAY+Oi/l9frpCE/DfGlBdO2aBMQpWr+TOHMbZ2vzUfsShaTHBN5Lb37lMptmY41yDyBkTikIyBBY43t2oqZQTpKLoXsUO6RWiqWvvO0TUJOcJlklALT9HH7LZMSFMtDaSSLQuGMQbpVeModQ26wFwdzZEizYYuvzcAMfpVBgVCrimnspUzm04PLL242GRtRaIKcjtooz0l5h7Ew2dUHN98ELCOIJoqIzpaOr3EuRNlEz0UKIGUdxiaSAfSYHlMeeqfdRKCthy1NUP8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Wed, 26 Feb 2025 21:00:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 21:00:44 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v9 4/8] mm/huge_memory: add buddy allocator like (non-uniform) folio_split()
Date: Wed, 26 Feb 2025 16:00:27 -0500
Message-ID: <20250226210032.2044041-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226210032.2044041-1-ziy@nvidia.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:207:3c::41) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: b776afac-6376-4b4e-c949-08dd56a8a2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oMx+9qZqLwhVwphNuKthc9PEMgXGoN+d4Y7uWXOxNmS5OEs9a07HjvkhPUpw?=
 =?us-ascii?Q?GNcIF2jgsIykxDxf27KBr2y74RnogrghMwP2xK6/DzBZjcxgDrTz1/8+4DX3?=
 =?us-ascii?Q?zfWZhOZoMN7eSkh4jm3bsVI0M+5F67z5jrPl80LYMYPveblm660N/x1k7G+2?=
 =?us-ascii?Q?eWqNlXxqs2uBUDgWhN+INOQpfw+jE8XrmkJuf4mqoE/uGSujun1M97CrQVjx?=
 =?us-ascii?Q?nj81ric1HQTpVrsUstev/jXmXcL5gGXBw0wBqGNX127fIUX1cPoJxvoTE5yG?=
 =?us-ascii?Q?XRyID9hmlZv+RHiYINNWP0ACY3w5lhG66lZiiLl9DdF8W3lS6dz2IGq0z6yN?=
 =?us-ascii?Q?Z9sVWClZsVZBO2Ah3xmcruuaC5R8dFTWUyi77/9RKOD9f94rBGfoIrF5uou7?=
 =?us-ascii?Q?+FzcJje4fHa0RbY89fP+sZdi24lpWwlRpowd1tKap0HlJsa5IUhqut088Ldu?=
 =?us-ascii?Q?b5jS9gUroHPtW6uzsIlw56GQ8ORDqs5JWDHlIAkkJ1XEc57fu29gRJrflLLa?=
 =?us-ascii?Q?FN333fvQcEDu5oAgKh56gAEBXC0AFCPVonyMeo//T8qQuiJwBkMCneG14AKs?=
 =?us-ascii?Q?YhJsgM3i+uUkgjH4vAqtiOQfO6Ys3jhrzK8gCPOm+Z1umhTgbAHIIkQgLCEt?=
 =?us-ascii?Q?FM+vlv+anLI2z77Nqp2dsTswsWEozNEtzkiGFqcxHENlGTP/eO+f9GRWyWfq?=
 =?us-ascii?Q?GQvYT2J5ntMFl8yRSqnAhCe+2WZ4BWEJcsKkjeo8Fj6dCwU81MvCKp4SRmqx?=
 =?us-ascii?Q?oazkBQ2MRzwVtTSTQX2/PAWeskv0gvsQJwvRIXkwuYW1FeJP8YMvZPzGf+Uf?=
 =?us-ascii?Q?a19dQB5b326sAzJdQHRRhE63fFu4SFS6Mp+0PIq/fJCiQwFdE/U9wS2hQsbw?=
 =?us-ascii?Q?kTfO5hHnfMGddVRPM1lkpFtqX60PObT1lYGwMCcHz3rOeiX+EvmIwqNJilpR?=
 =?us-ascii?Q?PThL8rERmQtM3BCwF0xkap5VMStdRKZ4P3niYpIremxntAvzT/m0kd8lHbY6?=
 =?us-ascii?Q?fdvmW3x/ndyJ6soGnPAKfQu4NxFWRjxsKSpMa4t863XryVXtksdSqijsbnY1?=
 =?us-ascii?Q?wwbeiaU6xJccD7rRfXO2Anv1UkJcBSmVH043zSe1gEmrSIS+HS8IQhvlQvW3?=
 =?us-ascii?Q?ZgdvhPDEd3989fXEh5Nk1wAiRoWR1DIA+Q3XqHhrWmmc3hQclhfDjcm9PIEa?=
 =?us-ascii?Q?Hp/Zlul9eQOdLPLcqSP0EHFHg59kxhSoks3kil7EwEYHLwRW5RaX3KzYd4cs?=
 =?us-ascii?Q?1Mqx4a07mjJleDtLjIcn7b4QYtKAHpOZo3HE1X0YXNAa3Onx8kIxo4uS1Cvx?=
 =?us-ascii?Q?v14ZuZMauos2RYfM0zwh6elNnR4iqpHU/JT2lll1Q9NlNTBssB1QwRGgt8mx?=
 =?us-ascii?Q?E8jZj/MbimMgP4uPoSXIVzJv94Yk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c+x2UxngrpSGo18N9Cf5arICziaP9Tv5Q4hJCufzhf4IZVLYGMplqeYAhon7?=
 =?us-ascii?Q?l8do/bB1XdGZbiYIc7UDz+KmMz/UWl9S+sJrDx7ZaAHP/8b5+qIN0b7LWk9e?=
 =?us-ascii?Q?/yJAaXXZuURweHUZqFSV9Wm5TP+H9KiUiPN+AeBFUrkqLDuMUkpLBxCRxdQj?=
 =?us-ascii?Q?ra9p+BDDIJ5cKzSv4g6BOz0NvaN5vaAJFfjGUYvq2RalosCodni3R97uwgSJ?=
 =?us-ascii?Q?1a6qnkMsUvfeLTZ/5fhtt6kOy1cVV5uxALPXZIJUgV4zcS2NRECto39T8/x2?=
 =?us-ascii?Q?BPf1Dn4AT/wL8eBxI4+tbxebR/wGIBItQY8EhBDRVfaw909mOffTGdBXh3hN?=
 =?us-ascii?Q?LhqgQ38hANa8itOg34BvdwAJZnO+8VYYr9URY3z5diCkb/8RAqicA5zBX4xr?=
 =?us-ascii?Q?QiPWCFMv4IKYaAGwPeT6SY0mbO2Hy/xVxxSyBGrNsTWzep6EmUAgPZJVvqdG?=
 =?us-ascii?Q?JWOKmCaC0NFRuSSHTuRE+dx+yZErQyclaUW5gIyAsJgtwqgAkIy94OL/rbpT?=
 =?us-ascii?Q?BBcEMEpARxGfmuhKPe8qDZ9U0lSPrHqTb/M2ODf7xJBJR2eweRS4RLm6gs9i?=
 =?us-ascii?Q?5gcu/Z/dfIhTyQUgEpxPpAKGZhM835qmMsC20KdrAn9xEoodPUQXb0KxVKSW?=
 =?us-ascii?Q?zs9dbmpKekMwoOUfbDZiy0jeTkLmbUcBidRjEur9XOlSqjjiRXxWjy9kQsFl?=
 =?us-ascii?Q?AAcR1f3vFwbuB6wFKwBYugmP/TgoGUvstRwRv8ezGdtsO9pPApMuUw6lL82B?=
 =?us-ascii?Q?++FNDScgyLJ3FORAB9f3a4RC2c1B+4L86kNJzPCV/451Db3EblzlYcvfHnaX?=
 =?us-ascii?Q?id56yDLNp6FIkgOW/dZtWCdL4wHkGwQ5yJuADzqI5s5bKMTeeLXCEoaih8M0?=
 =?us-ascii?Q?e/LUSNW8JT5qjTAesnFZ7XaqwbLJPBJP3j0mGIaHxBprmbxJd9+6KNK/8FBd?=
 =?us-ascii?Q?SnLaFYLwqopKDcC3ZTBOXdaU4uEPqab6Qtunct7So787MoKHl50PUIpXV2gk?=
 =?us-ascii?Q?rKGObptY+jb8K5d2xfPHpFIdFljqwUmB9nQcOeNiCRpEIABsey4pahbCpHW2?=
 =?us-ascii?Q?307B6pgjdFXGQsxZ65sd0eag+jVke84uQJXBPbTROH1cOvfCauR3g2/RWlTE?=
 =?us-ascii?Q?dL7OQJiEXBtHjz6dAAeZUThi8d5Qqvipd/MjmmoAfOWueqnxPr0mFyvRseO3?=
 =?us-ascii?Q?1dc19hu4oNjFBq+hGgX3Hb2gOjcdFKhOnbEQCZ6bwgLLx/GPLDpa3stLl3Gq?=
 =?us-ascii?Q?3E6SIH33QxTbYeBg7DUANK+cZLSMZlaCzqVmNlNHepeZABBajvufEJCE1kwU?=
 =?us-ascii?Q?v5f9QtjXC7dKj54Q0Dd809UIcRtyfZn1J6DT9k/Ln6k39LAKYFfdGH7x9y5q?=
 =?us-ascii?Q?bcFWn6c6k14Js8K7RYGBIgqzxXZprhpYRUZSkAN0pXIN3eR/nK9qxm1ZiwBs?=
 =?us-ascii?Q?Gt7XZzONGM7dNcsuoFvyndpO/L7xcE6oJcDT2NrEVMx3Y/ufvqP0NMtHcERJ?=
 =?us-ascii?Q?2e0jdRd9IG8f8/B9Cv/TcKADT1RkC3llTN/+fKU4gD0cA22lA2I8udr5vlDm?=
 =?us-ascii?Q?Xc7369cg2XfGU5/pgWrBxJunBM/hGS5AYeGZCEce?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b776afac-6376-4b4e-c949-08dd56a8a2e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:00:44.5846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcc5Zy61sgTGU+yYzUmTRzRwc6GsUUrr0uppm9h/qGo/2jenxdJNMOJWjtGyObnh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614

folio_split() splits a large folio in the same way as buddy allocator
splits a large free page for allocation.  The purpose is to minimize the
number of folios after the split.  For example, if user wants to free the
3rd subpage in a order-9 folio, folio_split() will split the order-9 folio
as:

O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon,
since anon folio does not support order-1 yet.
-----------------------------------------------------------------
|   |   |   |   |     |   |       |                             |
|O-0|O-0|O-0|O-0| O-2 |...|  O-7  |             O-8             |
|   |   |   |   |     |   |       |                             |
-----------------------------------------------------------------

O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecache
---------------------------------------------------------------
|     |   |   |     |   |       |                             |
| O-1 |O-0|O-0| O-2 |...|  O-7  |             O-8             |
|     |   |   |     |   |       |                             |
---------------------------------------------------------------

It generates fewer folios (i.e., 11 or 10) than existing page split
approach, which splits the order-9 to 512 order-0 folios.  It also reduces
the number of new xa_node needed during a pagecache folio split from 8 to
1, potentially decreasing the folio split failure rate due to memory
constraints.

folio_split() and existing split_huge_page_to_list_to_order() share the
folio unmapping and remapping code in __folio_split() and the common
backend split code in __split_unmapped_folio() using uniform_split
variable to distinguish their operations.

uniform_split_supported() and non_uniform_split_supported() are added to
factor out check code and will be used outside __folio_split() in the
following commit.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Kairui Song <kasong@tencent.com>
---
 mm/huge_memory.c | 160 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 123 insertions(+), 37 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4c79f54566d4..0e45937c0d91 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3847,12 +3847,85 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
+static bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns)
+{
+	if (folio_test_anon(folio)) {
+		/* order-1 is not supported for anonymous THP. */
+		VM_WARN_ONCE(warns && new_order == 1,
+				"Cannot split to order-1 folio");
+		return new_order != 1;
+	} else if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+	    !mapping_large_folio_support(folio->mapping)) {
+		/*
+		 * No split if the file system does not support large folio.
+		 * Note that we might still have THPs in such mappings due to
+		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
+		 * does not actually support large folios properly.
+		 */
+		VM_WARN_ONCE(warns,
+			"Cannot split file folio to non-0 order");
+		return false;
+	}
+
+	/* Only swapping a whole PMD-mapped folio is supported */
+	if (folio_test_swapcache(folio)) {
+		VM_WARN_ONCE(warns,
+			"Cannot split swapcache folio to non-0 order");
+		return false;
+	}
+
+	return true;
+}
+
+/* See comments in non_uniform_split_supported() */
+static bool uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns)
+{
+	if (folio_test_anon(folio)) {
+		VM_WARN_ONCE(warns && new_order == 1,
+				"Cannot split to order-1 folio");
+		return new_order != 1;
+	} else  if (new_order) {
+		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+		    !mapping_large_folio_support(folio->mapping)) {
+			VM_WARN_ONCE(warns,
+				"Cannot split file folio to non-0 order");
+			return false;
+		}
+	}
+
+	if (new_order && folio_test_swapcache(folio)) {
+		VM_WARN_ONCE(warns,
+			"Cannot split swapcache folio to non-0 order");
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * __folio_split: split a folio at @split_at to a @new_order folio
+ * @folio: folio to split
+ * @new_order: the order of the new folio
+ * @split_at: a page within the new folio
+ * @lock_at: a page within @folio to be left locked to caller
+ * @list: after-split folios will be put on it if non NULL
+ * @uniform_split: perform uniform split or not (non-uniform split)
+ *
+ * It calls __split_unmapped_folio() to perform uniform and non-uniform split.
+ * It is in charge of checking whether the split is supported or not and
+ * preparing @folio for __split_unmapped_folio().
+ *
+ * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
+ * split but not to @new_order, the caller needs to check)
+ */
 static int __folio_split(struct folio *folio, unsigned int new_order,
-		struct page *page, struct list_head *list)
+		struct page *split_at, struct page *lock_at,
+		struct list_head *list, bool uniform_split)
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
-	/* reset xarray order to new order after split */
-	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
+	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	bool is_anon = folio_test_anon(folio);
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
@@ -3864,32 +3937,17 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 
+	if (folio != page_folio(split_at) || folio != page_folio(lock_at))
+		return -EINVAL;
+
 	if (new_order >= folio_order(folio))
 		return -EINVAL;
 
-	if (is_anon) {
-		/* order-1 is not supported for anonymous THP. */
-		if (new_order == 1) {
-			VM_WARN_ONCE(1, "Cannot split to order-1 folio");
-			return -EINVAL;
-		}
-	} else if (new_order) {
-		/*
-		 * No split if the file system does not support large folio.
-		 * Note that we might still have THPs in such mappings due to
-		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
-		 * does not actually support large folios properly.
-		 */
-		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
-		    !mapping_large_folio_support(folio->mapping)) {
-			VM_WARN_ONCE(1,
-				"Cannot split file folio to non-0 order");
-			return -EINVAL;
-		}
-	}
+	if (uniform_split && !uniform_split_supported(folio, new_order, true))
+		return -EINVAL;
 
-	/* Only swapping a whole PMD-mapped folio is supported */
-	if (folio_test_swapcache(folio) && new_order)
+	if (!uniform_split &&
+	    !non_uniform_split_supported(folio, new_order, true))
 		return -EINVAL;
 
 	is_hzp = is_huge_zero_folio(folio);
@@ -3946,10 +4004,13 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			goto out;
 		}
 
-		xas_split_alloc(&xas, folio, folio_order(folio), gfp);
-		if (xas_error(&xas)) {
-			ret = xas_error(&xas);
-			goto out;
+		if (uniform_split) {
+			xas_set_order(&xas, folio->index, new_order);
+			xas_split_alloc(&xas, folio, folio_order(folio), gfp);
+			if (xas_error(&xas)) {
+				ret = xas_error(&xas);
+				goto out;
+			}
 		}
 
 		anon_vma = NULL;
@@ -4014,7 +4075,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		if (mapping) {
 			int nr = folio_nr_pages(folio);
 
-			xas_split(&xas, folio, folio_order(folio));
 			if (folio_test_pmd_mappable(folio) &&
 			    new_order < HPAGE_PMD_ORDER) {
 				if (folio_test_swapbacked(folio)) {
@@ -4028,12 +4088,9 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			}
 		}
 
-		if (is_anon) {
-			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
-			mod_mthp_stat(new_order, MTHP_STAT_NR_ANON, 1 << (order - new_order));
-		}
-		__split_huge_page(page, list, end, new_order);
-		ret = 0;
+		ret = __split_unmapped_folio(folio, new_order,
+				split_at, lock_at, list, end, &xas, mapping,
+				uniform_split);
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:
@@ -4111,7 +4168,36 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 {
 	struct folio *folio = page_folio(page);
 
-	return __folio_split(folio, new_order, page, list);
+	return __folio_split(folio, new_order, &folio->page, page, list, true);
+}
+
+/*
+ * folio_split: split a folio at @split_at to a @new_order folio
+ * @folio: folio to split
+ * @new_order: the order of the new folio
+ * @split_at: a page within the new folio
+ *
+ * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
+ * split but not to @new_order, the caller needs to check)
+ *
+ * It has the same prerequisites and returns as
+ * split_huge_page_to_list_to_order().
+ *
+ * Split a folio at @split_at to a new_order folio, leave the
+ * remaining subpages of the original folio as large as possible. For example,
+ * in the case of splitting an order-9 folio at its third order-3 subpages to
+ * an order-3 folio, there are 2^(9-3)=64 order-3 subpages in the order-9 folio.
+ * After the split, there will be a group of folios with different orders and
+ * the new folio containing @split_at is marked in bracket:
+ * [order-4, {order-3}, order-3, order-5, order-6, order-7, order-8].
+ *
+ * After split, folio is left locked for caller.
+ */
+static int folio_split(struct folio *folio, unsigned int new_order,
+		struct page *split_at, struct list_head *list)
+{
+	return __folio_split(folio, new_order, split_at, &folio->page, list,
+			false);
 }
 
 int min_order_for_split(struct folio *folio)
-- 
2.47.2


