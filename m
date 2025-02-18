Return-Path: <linux-kselftest+bounces-26914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5C1A3ACCE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 00:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DB7188B834
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 23:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180041DE880;
	Tue, 18 Feb 2025 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BC4pwUcj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F261DE4D8;
	Tue, 18 Feb 2025 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922630; cv=fail; b=cC8MJk/q+c6cG4xwsk02S25OVr+fXTA64XefLmV+jKZ62BpEiRdN1OPl8axciX8UnSb2ovDBjLEBGiiMxmIGl553rCWp7jx1a4TdyaqN+5feTmmmRPyUbgHKpXMs25POoGrbhRFFBweQXTtj4SSfLqp+XLHrwLz6dTrd6Om9urw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922630; c=relaxed/simple;
	bh=Nzg4xUyhgcUI185/PYI4Mu47OoFDj4ftTMwvA7XDet8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uYrb9S35TNKcGHVE8J96deLloiOIaNIxXr3WoPVdv2jG60l/TDDcaB1ufRpR9m3vG/nw/PZ6NKIIceA+6IRkau9anVjH6V0FGLGjvQWBoTG4EVenqoIHEc5j/oGHybBKzQyvg0p0caMvL7SFIrnXsD7W62pOhm3EH6rQYvIBRX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BC4pwUcj; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnJ/jB9QoK/Z5XQm+6+ytH/COghtAMJzO5HAvnvMdRGMYoKKRDiuE0mNd4Fj8elNjp61GNzj6LSNoNPS1D19B1TIEjJ+4eSCfTu5r0sCdUBt+U5ZbbCBO+ggahuVUnSrZvFMZCRUt5Oq4dOIAhFnKR+AmULpZVZIocor+WwjLcND8fz4DbRF+xZfBgwUrbp6cNvasM1IarpfyIdLfuJM6fiUNaiANj34WK4sWEYkwf7NmAEdO+hTHGQWFkE6/ah7J6kqgAkFoM+QwxuZn9U/lvlF53a4Z+DmE5rJrIxEUrMfWs+M4NqNzCTjFl8vS/WMYxvZJSSn62e6aGlVbI5DAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjJYG5I9oY97IgtR6hgx74fjlKX8/ku946e9EFhfCAQ=;
 b=CXk68jYu5o/gSjlZ32nWk5PykX8NHRAudl/CB4H93jgC2pBGgRHRYLC//yMr7JhjApi+FZyV7jatMkuEI0pCLLX4unxy4XmOF+LYpyaLa5PUonj6AXllFtG+9hSxC+Os6Ks3pohRn6Z6OBE1u79MDYx2jqvsd317THs7vo4vlDemhOtp5wcS3eOgadX5Z15d2Q6NPmXBo6HDQGSyIi5BtL1Cr2Z7TZPZqgtUTYgCjSubx3KK7EFVMJ3r4MnVrrfXyRyqzS0RDHIDkDEcA00GgKg73zBu5rHONSpcpp9uYqTKzykPHiR3JX88hOFMilqWvF6ZIsNo4vEVTzVHzu6+uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjJYG5I9oY97IgtR6hgx74fjlKX8/ku946e9EFhfCAQ=;
 b=BC4pwUcjg4U+SR89Rsz5HTktHxDkt/BLZPvR5dOwtNZDr43OjWvyeMQ5OxqRpDefhfogScp91vD6edM4lf2SIluDERB18G05xVMwbfU4g7tKsyC4um5BpPc1e0YLYgnvOIIJnO3U7OaOj0HRCLVG1Zj6NPNXc1IS3kT/+jUP71IN3/x/dxGK5EQ0p3jqWKgBV0JuOEVlidHxUhyG3QKkPxWDvZjslDJgjvztKBB8bNS6+mwzMTE8Ui1IUEHJqJ0Tm3sIswN1shgNVRrb6fh57UQC/K1L7nLx9t/EXGxeN2u8byJ58LhqXtyYLlaGMOAC2bwwYng82DnvEQZO/TsVMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Tue, 18 Feb 2025 23:50:21 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 23:50:21 +0000
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
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v8 3/8] mm/huge_memory: move folio split common code to __folio_split()
Date: Tue, 18 Feb 2025 18:50:07 -0500
Message-ID: <20250218235012.1542225-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218235012.1542225-1-ziy@nvidia.com>
References: <20250218235012.1542225-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:208:329::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: c45fe844-6d8f-41c3-a9d0-08dd5077016a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ol85hoJoYZFD8U4PJv1qMrxxXqCSPon1/adRoPI/a95yior1EVi/HKHW+snj?=
 =?us-ascii?Q?z+TC7uE98CbikzEAeSW4OqDu37uZX9JRfUYVNSaLERuHL//J/KusOqTyUscQ?=
 =?us-ascii?Q?UvY9foHdrTiH9QveOBTEmpnfOJLlo5koMMPa+W0qjyp9Nxfu8TtIAdGJo1LS?=
 =?us-ascii?Q?5m+uLpg516waMfaCw/T/SHToU9kF3u6kvVUroanxvJWJ82Tc/RQqjNurjEBt?=
 =?us-ascii?Q?nRAsu5VyeIsYPO0uSHiwIvEf9nfPqFN/8I4kJ2iF1FCEwoZYkYCM/oCZAbrQ?=
 =?us-ascii?Q?s8ez0jxgl4iJqTcY9rWdJZSUMoMPV7jIgwOD/ObzhqDhXFD1jMeEv2taKHLT?=
 =?us-ascii?Q?MLXea68S8PpDwxoOaR7SMvzdS8w8BDzJ/yi1M5L/X6pI2SezwukubrU7MohR?=
 =?us-ascii?Q?tqkvmza/GoUquDGJMKN/8KHC+61gv0chIWoyN5vFnhIoDvoMsY7ignWdGTTx?=
 =?us-ascii?Q?foVqmfNTOF8i6jsZafDWyBdxtmsTo6M2Utx84wch6KgbVTmnuo74tDr1Uh3D?=
 =?us-ascii?Q?QGo19NqOgfaOjc7TwS4tei3a2guq0c/dnO9pnhTt7y13IEZwdp7v9qeOyLIm?=
 =?us-ascii?Q?0fPoLM1Z/tgRrKj45G0b9Su2d8Nns7KPjIJRurPhdeI9sBZkhjoSzKLk42CD?=
 =?us-ascii?Q?KgFxCKWgB3c/0wgIwujoyGOxB7Y6YKdEgsr8nsphqVt1RSKA/L6xCiWyCIjE?=
 =?us-ascii?Q?d9P/joOOBe1oGyNC2JFpcohb1+LZQ00mZRs6/+r6X+hqeyEEDd/5YsHen6kS?=
 =?us-ascii?Q?t1eD43r5xCG5drDJQNPkdL6nN5jDcM5xTfkxmv64aOL+guwDX703JxD6I2+f?=
 =?us-ascii?Q?E6hc0+J+CP86BVS6eYCToL/qpVqkwu9liwmF35Zg0Q4fXmXMyu1jS+6w7f3+?=
 =?us-ascii?Q?I5o8fOD5+eeFKqI4wCKz1x7lLZmse7ErVbrsSmxVfnvP720qI+2wcXHIyiEv?=
 =?us-ascii?Q?kWvMLnXeDwmsivFcBY6/4xdX8qo/Nc/cULQ5X+S7JeamDsWqA2ahzbC3T+db?=
 =?us-ascii?Q?fOxoL8sXNY3VNUJ2PmCeheicNyOJDm4eEhiklWaoIuT96sS9kmiK9eSF8iuL?=
 =?us-ascii?Q?qXL9RVF9G/DAw1dAkdqq1pZJAyh1wmlq2JNkjHrMbpYooN3eTDRAMpGxqlbw?=
 =?us-ascii?Q?1tENrMOSj0EOhe/p4XGn6nEzQoH0V7Z68u6BFYQodivkMPkd7O1S0cnkv6u4?=
 =?us-ascii?Q?TX1rRbULDUyP+9ZP4H7VHHP1RxHPB6R9x8SSy9lxFi5UYSqTQW4ioebuCH2N?=
 =?us-ascii?Q?wqXWbGnCl1plSgnCW95W74W+r6QlZ1mqdjiu/bSoisJ/ESRF2kUSynocFdKp?=
 =?us-ascii?Q?i/yoR+5HeblRYU/VKcXC9Tc1iwDS84Zkn8l9OCrGwl8CSaqNuPi6y2VFjt2F?=
 =?us-ascii?Q?onhFK5UZX+VCwzO6W5jas3YHeoIe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9d5iyc+1zTRhGh+Cy5PRNaEwETiaoZQosgTV3HCzjA9m2XER7Y/NTbEhBC5t?=
 =?us-ascii?Q?GhYVFEw+f34kQ2VGBjgc4NKS6dHH8/BA7H1qz0MYVjNwRrfR7mk5cixwrdDz?=
 =?us-ascii?Q?JSvZbYJYJCRHZSZm8aKx8Co8QahZEHDyEPURBUQgcQB53lQ9UWd6x5kAVDYY?=
 =?us-ascii?Q?ERiF/Aca/CNxNQLzr+NF+RGBDIqlbSfzmiHPnsBPWUD2a8JvIQGPV40ox713?=
 =?us-ascii?Q?o/ToBIa7Xldg+LuobczvoeK5FBqCFmm6mCKRk+A+YKevv0YKTKbwE0+tHjUI?=
 =?us-ascii?Q?Qy+X61CFJYVLLG0W57uPBbA2Ku1zQOJuwO9gEogNjCzs+iVpCOvXP0pyjz5J?=
 =?us-ascii?Q?1rjq8UX/EF5mBZfW9oY8Gw1vMDHwAei5cpiLF4ICdZKSEyOVvoFgHbDBhz6Y?=
 =?us-ascii?Q?CQoWcBfrMULj1KUkHSbdU3gRYEJBnmoOdqEwwO00bkKzcWK44gdtVvXXM5Pf?=
 =?us-ascii?Q?W04tY6ugiQ6eFOHfdWMQO1sKpB7CUdzvWWy8QPc5aSF5p0mf9x7Qc6CItLfN?=
 =?us-ascii?Q?0Rp8/+t+fmm/uMyiJ9c5CpVJQ4P0LkBvJ1fQBF0xowuLoau7d1DVxZDS3hE2?=
 =?us-ascii?Q?mH3Wm8apF3zN6N3Jg76vDg2NMEyOkev2jmbKD0bvDmlKbyBjkXpsMdlz03vI?=
 =?us-ascii?Q?/OxsNjxH4JP2TqpnXmPr763u4JxDqBYCiPXQXG2RKcg/13m5DETyy3B0xNy5?=
 =?us-ascii?Q?y6ig1guzlzcgTvuaCvySAkirALF3Y8M2z7ryy+dojIk0rUdCTepQOadcSJq0?=
 =?us-ascii?Q?3KLYLF4Nqk5vyYfi02d1kQvJFYojChlPBvyEXVqdSopsOOvpEZxt5yKtPh61?=
 =?us-ascii?Q?m5kCUG5CgItS3ESEUOwULqRRVOEwF7S/d29eVsNF1yvjwY2ENqds6l/2EoiK?=
 =?us-ascii?Q?xEzCVRNt2SWzwobMTSAda8oF92JzWkxM1ksYbts09cJuqpqO2GaY0blRgMF3?=
 =?us-ascii?Q?Oi+YIV80NjzHl7QxuF5EdZNA7TUEfhnM9BCLpQ3k9cCWm4COxnoo5I1d1bHU?=
 =?us-ascii?Q?+v6o3UnAiPEjcIR/wxHvjL9RagX3a56NoZCQb6Yoy/jjoSPCJm9AyJis4P38?=
 =?us-ascii?Q?M3Ik6pp7IkXp66TknNQV5qSILsJjRmFAF+bLf2In3nw8pOiPlLQ7LWvLkj6N?=
 =?us-ascii?Q?YFcLG/nSjN+A2pVHVpJzgd0CwY7+xCoKHmG+1SJZqNewkh3fr0XYK2BakKBq?=
 =?us-ascii?Q?SmhPOSin8os9iUG/rz+I+3/T/JS733d/L47FBVljEZYHEi32wG3HZ+Ncozyb?=
 =?us-ascii?Q?pUdezGSlmVyDxUYVQu7ciHcoKb4N4lCcDjVhnyzwfhftjkvngI6+euYqZHCo?=
 =?us-ascii?Q?NLEIvNYc24tjEgzz9H7Ev8BV+POnbT4JCojYFte0pkgl/B4Drpn6x91J58tZ?=
 =?us-ascii?Q?US6zKqNkE39rziAJ3jjm2fWm5ADta/yaJ4nWfDWZVq3wXVBmg8a6PahkTpVY?=
 =?us-ascii?Q?lqgej86KrUYvx3yb+1v+F8IwUl7kuFYONMTrNhM3Gx1bEvyHf4v6f2McbZsT?=
 =?us-ascii?Q?cEIah2I8eCY0Zq5ix/liHjR/jCeUv6CSREVW1MV8PfJKNwjmGR3BvP+AG9ei?=
 =?us-ascii?Q?mwCOhDoZ21NaBSkPEQHl4tlwFHNwHt0XOIC90cQd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45fe844-6d8f-41c3-a9d0-08dd5077016a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 23:50:21.2726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFVXM6/CAUhsBczZq9bdKZbddyYPtgYwjztvSqyIEjvld00ac0kfFSj3MtyVBt28
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

This is a preparation patch for folio_split().

In the upcoming patch folio_split() will share folio unmapping and
remapping code with split_huge_page_to_list_to_order(), so move the code
to a common function __folio_split() first.

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
---
 mm/huge_memory.c | 107 +++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 385e424252d4..94ed85aadecd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3730,57 +3730,9 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
-/*
- * This function splits a large folio into smaller folios of order @new_order.
- * @page can point to any page of the large folio to split. The split operation
- * does not change the position of @page.
- *
- * Prerequisites:
- *
- * 1) The caller must hold a reference on the @page's owning folio, also known
- *    as the large folio.
- *
- * 2) The large folio must be locked.
- *
- * 3) The folio must not be pinned. Any unexpected folio references, including
- *    GUP pins, will result in the folio not getting split; instead, the caller
- *    will receive an -EAGAIN.
- *
- * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
- *    supported for non-file-backed folios, because folio->_deferred_list, which
- *    is used by partially mapped folios, is stored in subpage 2, but an order-1
- *    folio only has subpages 0 and 1. File-backed order-1 folios are supported,
- *    since they do not use _deferred_list.
- *
- * After splitting, the caller's folio reference will be transferred to @page,
- * resulting in a raised refcount of @page after this call. The other pages may
- * be freed if they are not mapped.
- *
- * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
- *
- * Pages in @new_order will inherit the mapping, flags, and so on from the
- * huge page.
- *
- * Returns 0 if the huge page was split successfully.
- *
- * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP) or if
- * the folio was concurrently removed from the page cache.
- *
- * Returns -EBUSY when trying to split the huge zeropage, if the folio is
- * under writeback, if fs-specific folio metadata cannot currently be
- * released, or if some unexpected race happened (e.g., anon VMA disappeared,
- * truncation).
- *
- * Callers should ensure that the order respects the address space mapping
- * min-order if one is set for non-anonymous folios.
- *
- * Returns -EINVAL when trying to split to an order that is incompatible
- * with the folio. Splitting to order 0 is compatible with all folios.
- */
-int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
-				     unsigned int new_order)
+static int __folio_split(struct folio *folio, unsigned int new_order,
+		struct page *page, struct list_head *list)
 {
-	struct folio *folio = page_folio(page);
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 	/* reset xarray order to new order after split */
 	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
@@ -3990,6 +3942,61 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	return ret;
 }
 
+/*
+ * This function splits a large folio into smaller folios of order @new_order.
+ * @page can point to any page of the large folio to split. The split operation
+ * does not change the position of @page.
+ *
+ * Prerequisites:
+ *
+ * 1) The caller must hold a reference on the @page's owning folio, also known
+ *    as the large folio.
+ *
+ * 2) The large folio must be locked.
+ *
+ * 3) The folio must not be pinned. Any unexpected folio references, including
+ *    GUP pins, will result in the folio not getting split; instead, the caller
+ *    will receive an -EAGAIN.
+ *
+ * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
+ *    supported for non-file-backed folios, because folio->_deferred_list, which
+ *    is used by partially mapped folios, is stored in subpage 2, but an order-1
+ *    folio only has subpages 0 and 1. File-backed order-1 folios are supported,
+ *    since they do not use _deferred_list.
+ *
+ * After splitting, the caller's folio reference will be transferred to @page,
+ * resulting in a raised refcount of @page after this call. The other pages may
+ * be freed if they are not mapped.
+ *
+ * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
+ *
+ * Pages in @new_order will inherit the mapping, flags, and so on from the
+ * huge page.
+ *
+ * Returns 0 if the huge page was split successfully.
+ *
+ * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP) or if
+ * the folio was concurrently removed from the page cache.
+ *
+ * Returns -EBUSY when trying to split the huge zeropage, if the folio is
+ * under writeback, if fs-specific folio metadata cannot currently be
+ * released, or if some unexpected race happened (e.g., anon VMA disappeared,
+ * truncation).
+ *
+ * Callers should ensure that the order respects the address space mapping
+ * min-order if one is set for non-anonymous folios.
+ *
+ * Returns -EINVAL when trying to split to an order that is incompatible
+ * with the folio. Splitting to order 0 is compatible with all folios.
+ */
+int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
+				     unsigned int new_order)
+{
+	struct folio *folio = page_folio(page);
+
+	return __folio_split(folio, new_order, page, list);
+}
+
 int min_order_for_split(struct folio *folio)
 {
 	if (folio_test_anon(folio))
-- 
2.47.2


