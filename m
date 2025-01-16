Return-Path: <linux-kselftest+bounces-24682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90474A143CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 22:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6AB188DE70
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 21:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AD9242276;
	Thu, 16 Jan 2025 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R/1mNyhL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9553242259;
	Thu, 16 Jan 2025 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061868; cv=fail; b=kxLU77vklHJS9WKwblfTRMTT90WlhjXgSW+wfou1O1JrFdtlFdEWjOoGA3/MhCCyGaBcdcakyhC7TNK0Je/e91GtLA7BFv1QvsH5rH+lARm9fKKChDsvv8cRAK4FRQcpxuZP3fZwiZDzsKDjpCn4ju5sut0qII+9ddNJfzTxy44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061868; c=relaxed/simple;
	bh=7kOMxMCtgxyC78YXkWiNo3lxtgLDDr2eNzDnfpmJDBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bA8Kn11I79o51uqClFeQT1UewPBxRkJNOOu2juuYhJK+9rP2ssTps0Rs5MQMg9Iuot2sr5k0qjEEsQwBv9wee2CGKBBesvMSN6X4tjbcfZF51npZgcZIo7CtD0qIeLAQF/xuS4/2VSUwIRG+BjnwmnRgjDkpr4jCQ/L7sEf8HTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R/1mNyhL; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ay7lUGLeRWvTh1PkT045t0eatNce96z/x2VWfYKRPtWJMY6HedwxCOK/i9DOLBxlzXnlVkKiVo0R7nk9Kp6HJXHa6IkmXYgBmQzE4bDPC+uPzEDPyNYZkwzx2ek+7h+FnwVc7EiNDnBC+XIkF2DnZjVLRuNdMQsmmRH0XQ2I1pOWC6vnJx+RvE+HB2hM+LerAvbBfnQL/TT34UAjua+ISkye2OVAdNPjS47hCutdE+994HR0v9A5sDjZ3UY0H7WtywZRUSBkbvpJMGjF9h0Wj3FSOpSZmg6dOKdJ7YfV2aGMxaI2R9nDoJd4C3NoJjF7+bLPcsYgW0GJu4pVVZOTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nL+wY28kI76n9e+G1XMx3CKgrNgqEsGZq21/wECx+Fo=;
 b=skRYi/DTQBlWY5h5JGrdoMbxJOvKciNxXoHy+/tGqHFzPEITMWYPcO1UfsuqWw0QATh9s2n5DYKPavRYZ0kKKE/56iIh42mzDLikmllcXP7JULKd/hNrVza2NhOe0CB2blxYoIzMR2Ip+mQQy6qzN0Bm82CQMwyFVqjvK6aS2P9c6e8cv4WRSJgblKWWy9XmujYYehphqqyEy/xBzPVkLVRyfLQi4JAAnDERq5GwXGb0N5whqYFNQx1y/Ie5xQvTrxDIOFdtftm2wwtLlISJ3C3E/AtGcr2wih5l6z2Hu+kwkTV4v6VPDDo7rbFApk5T+2OoDE+DRBCnYx2cXd129w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nL+wY28kI76n9e+G1XMx3CKgrNgqEsGZq21/wECx+Fo=;
 b=R/1mNyhLHlAginPplFUBV61BKTlwGDMNLNgh0wubYcwV3t3Kkbba8a8YBYTkBKQ4Uk354tlP6NTTFKWrgu53Nq/OXFkcj2tEfNQlWfGAD2x7UOh9A9VpEjP3jP4umK24IRlHQrK1iYdfaFG5uGA28QfNYq6FWE2JHlsjAVHNSZQMqhyU4yG+pRdc6gsGa+/yCU/RPOmWQwfWPL2ZoZIo0DGi42cZWyVU1glFECPLjeDT934upF7W1ynNq2HDk9/AHzIoe2OnAic8loEr9uGqRhPGZOMZCOeNmIogUJ92SGt1V2G921GYQp+J+RUbx7ie/wbX8MauzPfeHWswur23lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.15; Thu, 16 Jan
 2025 21:11:00 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 21:11:00 +0000
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
Subject: [PATCH v5 06/10] mm/huge_memory: add buddy allocator like folio_split()
Date: Thu, 16 Jan 2025 16:10:38 -0500
Message-ID: <20250116211042.741543-7-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116211042.741543-1-ziy@nvidia.com>
References: <20250116211042.741543-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:408:ee::11) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e6b3a8-889c-463b-0a4b-08dd367246e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZIyvVs2kQg+k0BtVNPjo9mJ42tklWxeKXQ/cMAImukdBXLplvFCKIXb2ubCQ?=
 =?us-ascii?Q?I5gDUldu55Zb8z8npn3NRFMqsuO2vPr4bD08IrPzfXatMorKvp2gx9osU1PQ?=
 =?us-ascii?Q?w6GqByl23F9lD1c8ccBl/Hfw6Utp7lvJlyXb/jiC3mE7QzOKwTkCOWZ13b0K?=
 =?us-ascii?Q?vSwqm7Gz+Buyl7Zpah0op9Elq/4CSSBDvtzNUENVLYFtFrZMQCfPdU2tkLp/?=
 =?us-ascii?Q?8ktUt4bJnT7755jdLo+dCQAO/T5ikN7OgtI+z7kml3wrlbAXjFpeisu3ggrl?=
 =?us-ascii?Q?hx77Rwou39yV78Zr6G6xh93RhwflqsrKxaGFZbUknvW+X0J0GRqY1/zJ4BYm?=
 =?us-ascii?Q?WkBnbV+gN8HCjDD6+O3ZHFNhmP7m44UFBlo1gtwV1QAJkvDbWzrwpJCssmAU?=
 =?us-ascii?Q?fiC+0IKglEqo0AA+S4u3fz9OX6sHo731vQvnodQz6EHb/ItdmRa55TDJB96b?=
 =?us-ascii?Q?8VVwM5N1/Oq0dCnbofE/ckNSZwM0m1jdVrpKn3/jNzda+lKjvFItPGnCBnYN?=
 =?us-ascii?Q?E/MhzC76eSYL+/iDcSGFK77d8DC8vTi4E1riPZV46rHeJHdTige6tvpYqNMY?=
 =?us-ascii?Q?ELu8gEcXkB43B+JogaGJBIAEqLzilSiE/9pXXCiQT5yXCTE5+CSg515HgGBu?=
 =?us-ascii?Q?6e+2C3worY2MHX3d9ondmwgBEXnwhl8OnI3omnsrF7RXP8UG5zbrZmxBe3V3?=
 =?us-ascii?Q?DjJPHmuckJ3SvmTDN9WafiUV46wLDRgwwIinCL1sdBQEs/Bd7f8STYJSgoSD?=
 =?us-ascii?Q?mNOdWpGiLS1awev8D0i+yC7MsymO4e3a2jhOJSfnWZ+4ViGJNImnPKkJjJHM?=
 =?us-ascii?Q?KtaToyoULH47LlOGD3WyiqtD5kJETrOOSNr6G+ZUQMthcTKou49r5KRgTlKf?=
 =?us-ascii?Q?1Z+SkVaPQ4Gt4HraHxm56L1WTvbpnjrPDE4gyrswlZbsFXziegBwO0YrgWV5?=
 =?us-ascii?Q?xNhH0TBlaxpXhYTkBVqrQ7hY8zK1rRGI+pnRnEN3j+DVx8ccqF21RdFivV2X?=
 =?us-ascii?Q?y4BEu5uqfDcdQMTBKfFhKMrazFLrh+22nv99y1PkSKqKVDUhCDAhUvUDV3Ng?=
 =?us-ascii?Q?0VKHMBRg0iCokXmLDmVBINmCeqFPa7EpMG7ufZXqC0Z2eLTfb9xghPE1JHmW?=
 =?us-ascii?Q?4cH+8DF7WJ7OzmFq7mRGX20/10vCrLujmgVCXsanAl9Yfsh80fNLqhN9moUW?=
 =?us-ascii?Q?iY8SJzbYsS9GHCiMeJUm74q1gIkEc+tJwwlHlh0BXFu6SXWPeKqN0Kg5g8/s?=
 =?us-ascii?Q?gy43oRqxWnArFu6dJVjj3jke/HvbAGA8PVlbNscau7tdwq6jT17JzDTV1QUl?=
 =?us-ascii?Q?r5QRXqELPMvNH1OHv9sZRIKQ1yKH8wb6ftQsntdVXaTlvvE+4R7aBRoP8KYJ?=
 =?us-ascii?Q?pp1MoQZryyMTNsn0ASMqL1oluTz1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H6zJzgpUHKBHy94nHFVv1WvHU98VOJrvjF3CAP/v6rs6E+OTbc3dPukIFJra?=
 =?us-ascii?Q?iG+l/GvghpCOJP7ywyArHDkAwO2/Dn2SpwzOmNTLH8ywjtg3k0iBey+xXlz8?=
 =?us-ascii?Q?GRFviqS4ZypakirakwO5Zj2t8j3faF7qpnzrbvRIpJkS5MkW2jGTa/GLWJ9v?=
 =?us-ascii?Q?s9fSShBbNBGGKGocxmF8cBmkCsJhmnDUuJ1WUeL9dR2DLTVdRQCBRBKtKM1e?=
 =?us-ascii?Q?J2m8kTCBi5OfGQTLa1MlGH6TyPc0su/WyDBan4kpa8jJNWr/ctLfCG9clzux?=
 =?us-ascii?Q?dNNsjngFQwU1QzCjSUKr/viYAqLTjJ6CcUGFO+yhyGeyIt6Y2eBPouCX4OW4?=
 =?us-ascii?Q?ww+H1x+Ni2lHafgRJLXjVeBqo+mFbD4M/vPA78UDF1YbBMVVXn1ADUByRSHn?=
 =?us-ascii?Q?sp6w+rhj+QkSvAUEkPj9OGNZ3thuwW5VWE3+1NMfMEQI2wfRrOsk+ZP/jLTz?=
 =?us-ascii?Q?W3bnqADWBzvNAuVGSU8SgGqoTekUmkiCP4E5RJwimnr3uuDvYsIrQm8AGHrZ?=
 =?us-ascii?Q?l0Ebyi/MMWQK8tWgpzXASwLCZ5QZ+P+oh35i0bLLech1OJf8aZv1H4yCtDFf?=
 =?us-ascii?Q?rxR5imVxpihpSDGZAdD0CRGn037ml2oCzMqO/qc0g/pu2TK2B+Bh4xIk2MsQ?=
 =?us-ascii?Q?9N3cXzzwX2StRzjCr0u5RbJCoyUw6U4VSHiaCXIfzMlDEKZv6MPXBuOpxrC1?=
 =?us-ascii?Q?ly65XcD1pGzgyW3Fr0dHd0FoILoplKZ0aNYMhsm6reSetsHYjRG4+JUvPUGf?=
 =?us-ascii?Q?Yj1RysVRTJ0zsTCQNykzCzRLCcl4WlO9kQcPk9nWg2Y2Mxc9UK+xGnfe4hMy?=
 =?us-ascii?Q?d9sh4uhLE7hkzDyJqWUd6ooGRxgWJ5CyVRtDXH31zHF3T07ZWZAlcm4qXzcl?=
 =?us-ascii?Q?+FmUVffa38Q+1B/SldyeURpLQVx0rHkTm8Bemnq7JPHZxK8dIeSjTyjfz2yw?=
 =?us-ascii?Q?DraR5+QGp76rVwvaAcPBAXDhgsfDySjkoTW+cyBBThYrviEAv6aI+zSemIfo?=
 =?us-ascii?Q?23vRWqRxBrKW1IJnB4+rrkNRwVE4L0omi0VFPn3iuDUxa9aUIY5XwCGkiWpT?=
 =?us-ascii?Q?Miu2Yor3gZJWcQ8rg9cOETmlkCov7o9bKaVAH1COERA6B/TJG+ZdA2pArqzY?=
 =?us-ascii?Q?8dSUqwQzR1JlkQIRNGB/RP3IgGrAmrWZwvy7rWFuFUCpvmwDdu7KQ4sHuzpn?=
 =?us-ascii?Q?od4kxXlybFblSeFDGtGv/18VRm6VTKMeH6ph+9Kj9vRFcKNueCgbGs2fNGyS?=
 =?us-ascii?Q?pmbmZZ4aZvHsFLjPu0iH5oo8Z9AHnxtU/5kWpedUbcJl4JjB6iURGQyaawye?=
 =?us-ascii?Q?vfveF8F5OCeQkI//vfJYAhJbLvgNPVX+/FlYZJ0kfLLLTewdE4zwII9pSETf?=
 =?us-ascii?Q?hweDkpeAgLzp7ePg6R9Mi8AuEQmjgzryegFaGtH201/2Os0H2LtFiiBx5lPD?=
 =?us-ascii?Q?6u9F+EDuaFmgY3S0vaI5FsnL5FmownyWawJmevFhr6y3rOoeo9SdFzuvRO+Y?=
 =?us-ascii?Q?hLBf3PwAWttiQWfDkSVPruqX7dMBCNjDmk1j53K+8qMSzQjxa3pIxiykhdfS?=
 =?us-ascii?Q?SatIwbJqHcZcq5nPnEt/ln8d4UVgSqxcoPBc8tmD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e6b3a8-889c-463b-0a4b-08dd367246e3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:11:00.1005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: em1+x8C4SFFz/yyuD8jhgd0irSpTwR5G0K665SkkIHG6MQ3Yholj7IB1QPn1gAKE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

folio_split() splits a large folio in the same way as buddy allocator
splits a large free page for allocation. The purpose is to minimize the
number of folios after the split. For example, if user wants to free the
3rd subpage in a order-9 folio, folio_split() will split the order-9 folio
as:
O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon
O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecache
Since anon folio does not support order-1 yet.

It generates fewer folios than existing page split approach, which splits
the order-9 to 512 order-0 folios.

folio_split() and existing split_huge_page_to_list_to_order() share
the folio unmapping and remapping code in __folio_split() and the common
backend split code in __split_unmapped_folio() using
uniform_split variable to distinguish their operations.

uniform_split_supported() and non_uniform_split_supported() are added
to factor out check code and will be used outside __folio_split() in the
following commit.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 134 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 97 insertions(+), 37 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6c0089a0bcdb..d9f5ca61d78c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3738,12 +3738,68 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
+static bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns)
+{
+	/* order-1 is not supported for anonymous THP. */
+	if (folio_test_anon(folio) && new_order == 1) {
+		VM_WARN_ONCE(warns, "Cannot split to order-1 folio");
+		return false;
+	}
+
+	/*
+	 * No split if the file system does not support large folio.
+	 * Note that we might still have THPs in such mappings due to
+	 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
+	 * does not actually support large folios properly.
+	 */
+	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+	    !mapping_large_folio_support(folio->mapping)) {
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
+	if (folio_test_anon(folio) && new_order == 1) {
+		VM_WARN_ONCE(warns, "Cannot split to order-1 folio");
+		return false;
+	}
+
+	if (new_order) {
+		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+		    !mapping_large_folio_support(folio->mapping)) {
+			VM_WARN_ONCE(warns,
+				"Cannot split file folio to non-0 order");
+			return false;
+		}
+		if (folio_test_swapcache(folio)) {
+			VM_WARN_ONCE(warns,
+				"Cannot split swapcache folio to non-0 order");
+			return false;
+		}
+	}
+	return true;
+}
+
 static int __folio_split(struct folio *folio, unsigned int new_order,
-		struct page *page, struct list_head *list)
+		struct page *page, struct list_head *list, bool uniform_split)
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
-	/* reset xarray order to new order after split */
-	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
+	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	bool is_anon = folio_test_anon(folio);
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
@@ -3758,29 +3814,11 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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
@@ -3837,10 +3875,13 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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
@@ -3905,7 +3946,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		if (mapping) {
 			int nr = folio_nr_pages(folio);
 
-			xas_split(&xas, folio, folio_order(folio));
 			if (folio_test_pmd_mappable(folio) &&
 			    new_order < HPAGE_PMD_ORDER) {
 				if (folio_test_swapbacked(folio)) {
@@ -3919,12 +3959,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			}
 		}
 
-		if (is_anon) {
-			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
-			mod_mthp_stat(new_order, MTHP_STAT_NR_ANON, 1 << (order - new_order));
-		}
-		__split_huge_page(page, list, end, new_order);
-		ret = 0;
+		ret = __split_unmapped_folio(page_folio(page), new_order,
+				page, list, end, &xas, mapping, uniform_split);
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:
@@ -4002,7 +4038,31 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 {
 	struct folio *folio = page_folio(page);
 
-	return __folio_split(folio, new_order, page, list);
+	return __folio_split(folio, new_order, page, list, true);
+}
+
+/*
+ * folio_split: split a folio at offset_in_new_order to a new_order folio
+ * @folio: folio to split
+ * @new_order: the order of the new folio
+ * @page: a page within the new folio
+ *
+ * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
+ * split but not to @new_order, the caller needs to check)
+ *
+ * Split a folio at offset_in_new_order to a new_order folio, leave the
+ * remaining subpages of the original folio as large as possible. For example,
+ * split an order-9 folio at its third order-3 subpages to an order-3 folio.
+ * There are 2^6=64 order-3 subpages in an order-9 folio and the result will be
+ * a set of folios with different order and the new folio is in bracket:
+ * [order-4, {order-3}, order-3, order-5, order-6, order-7, order-8].
+ *
+ * After split, folio is left locked for caller.
+ */
+int folio_split(struct folio *folio, unsigned int new_order,
+		struct page *page, struct list_head *list)
+{
+	return __folio_split(folio, new_order, page, list, false);
 }
 
 int min_order_for_split(struct folio *folio)
-- 
2.45.2


