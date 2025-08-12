Return-Path: <linux-kselftest+bounces-38788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DCCB22CAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 18:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148597BA246
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF942F658D;
	Tue, 12 Aug 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CkrzWkoe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7B62F657F;
	Tue, 12 Aug 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014143; cv=fail; b=oXyeor80V2VYYMj8G+eV6jZ4ouO2rhJukwVWCu7L2beh4WlhgW7kN5z8M/POo9pRRgXnWg4Mjixb7Og6eotb1caXzlkZHKXtzA0ZMotOMF0anrEl/+8UQd3t83oqLLMDUO14JLnW53Xhumt53aU4kqM++W2UroVKjjWqG/LkLrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014143; c=relaxed/simple;
	bh=i+6/AV27vaWELB5m5rLq2Um3Z2EfHWw+gt/zlsKeMKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O8INXoRPKLZkbap5ql1Ckh6YWFAQdiATXOydBqTFGRucyVnXerfanr/2h/ec+6pdwJH9MjBpN+ryLS+JymtRBtUbALksb5V1D5pXntVxz67INhrGWj6UbR8XtZ37SD+irLui0QEcp3NHFnRVms1IfAWbVs/yKNmnTtLEPQ4Exxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CkrzWkoe; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2QE9aep2dknTtM5Y2Qfg1DJtjLDqflXlQPVYxBogEHUgjSy3Z0w7l4Ozne+1HYcMzhU2VUB1t0NQJmRiKTwnvMHuw5c9XiZ1ycyHYGF/adEIMkBNJVNVRfU/8gXhMtJ9w5omFwgTFwCw6dPpoNX1otOhO3gOkSBze2lkwkhLEjz8Y3FszwV8cDZCyxg1VNNs7t76irK0opn4TO8Hta0NBvLzR/mfnIOgPnHBbA6hR0ItapQtO7e+ZbFbefTvZ8Rfsk02h3+rUNT4cTuMqmYQvQ5lDBvJR09OzXxiqP/vuIpDGm6IB79tuzq4nPou3NGJUpI5Z72wfxl49QB1UXgPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CqXEQKKle0iqTEjvC8PrOPweXjobzLwhZAxzGE3zOA=;
 b=m1NmSqAxYRH1eULjrFesx5F7/N566YFOvTzs2/nsKOGfxttuQldW6dOsQ0v4i1Z8mNxAp8g6o/VP90INKlpzRiWWyd4Tzu7lV0n/lyqMQntkHriuuJwSYtuYT2Y5lSvDIxTddvhYInkeFT0zL3407dvaeHHVuejMCiMyfr/aVDW0pmzL4MgXyJcIMXFrBf4D2ojhQvXiUxuB5zc67NXZTYgcD+a57Ejs2Y+5QbIjcfE0pHUHoKCHUp8ulwAgCc7AYu0aMXwbhlppF/0E3gpVZrKbIw2Cmp1QahpW+Eo0jX4iqXewRo93K/1evgTN1crJRVoiPoGKTjaN1eGCv6KlRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CqXEQKKle0iqTEjvC8PrOPweXjobzLwhZAxzGE3zOA=;
 b=CkrzWkoexwQCDO8n6TmPYrk9jxAXC1vh3xBVgyAjhX30p5Ru6MklROp7EVJaG38pQdKqPRvM2RKHGU778Cdv4c1XhqNDiGcjCcam0NjWvELwpH2C2gyOGfAfr7pGLfWijJY7PJ2MTDxyINiCcr7k2Qu64NoU/e5Svfv1h+Xg7IbLr/e1Kpkm/RdcHARb0Jvy1oTXRtPXyIQUiWpbf4+wRPOLyt7Zf2k3a39LKTeBIcfxhE3dHMH0pf2Z2udBCKLLc38zjHs0jIvmo8iCHQBDT6+sdfH1yZ5nFgVE7amZTwCOdR1TPD2sxfQzRgu5f+DL6rhFeYNnk3lnHoCHjXnZvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Tue, 12 Aug 2025 15:55:33 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Tue, 12 Aug 2025
 15:55:33 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>,
	wang lian <lianux.mm@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 3/4] selftests/mm: reimplement is_backed_by_thp() with more precise check
Date: Tue, 12 Aug 2025 11:55:11 -0400
Message-ID: <20250812155512.926011-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250812155512.926011-1-ziy@nvidia.com>
References: <20250812155512.926011-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:408:fc::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: b95679cd-9a7f-4878-22fb-08ddd9b8ab6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tAC5ZRG7xNbAjw/EjUG/nClmeMbpkigOiGU/4riFe0kMofKheP4vINNxkxbZ?=
 =?us-ascii?Q?KfDAmB0DwDF4bC8OC6qGCDmQGTnrofjdRQ+wt+QJmN7E0F4phFu6reBmvBel?=
 =?us-ascii?Q?g8tetsXo80qpr5cJj4t62z/pfutQly4Uc6JIEeFCV0HhVvhL63WA5wCTlVfe?=
 =?us-ascii?Q?VRbMpUJ/mFA6pFt0GDfLGhVHAY/N8UZ31p49BadMweW1uq43QuTLlx87UQ2j?=
 =?us-ascii?Q?Rcod4WJhjtSJNXD1N3OGdovhxYAsDdCWp6QmepkUJzpERgJW++54z75Cv8Hb?=
 =?us-ascii?Q?lyD0V3IguPJlzIwmHyTWiZOt8exlTnTT7yLWXAVkwt1/ie/w4xBR72tlTmQj?=
 =?us-ascii?Q?Cl3gVdU7d3/opBbHyrO1Xx3Dz+x4QOYz2lY8ZNP+l1RWHnoQrNtTam5XsJR/?=
 =?us-ascii?Q?+3yHDbCVlLfebw9RYp4eKoAcT4F67vcAAgYzGcOG0Pjf1hk9lhmCWDY0HYgw?=
 =?us-ascii?Q?yXsyFo7jUd2hnkBTDD0qR1Sln+XWBKJNVRr5iviNMPxCnXHEL6QPor7a5E9V?=
 =?us-ascii?Q?zfrVtdzXcwCSUhS5RO0mnqgVqb9rrF+wSYoOCAnJSYz7Y8QrF7dkb86oV5sw?=
 =?us-ascii?Q?ZjeoAU2g8zB/qG3YO6EpHwoomHfgCxDqY5O/iWOQZPEOiK2BGC4nV1edLK1E?=
 =?us-ascii?Q?YQib02h4DH8LAX7xOzhrItBKWocX1ylrLEzqQ8IuVWge61VC/I7xd43vOKjq?=
 =?us-ascii?Q?werlmoUWv9nEkewafPMHHQ2pNDIDJxsHIh27ZUpZFc1FRFXxM4JvwHeB6oLW?=
 =?us-ascii?Q?3+B5HDLSta0vpb488C8UWmjABiIIlET897XgsWLrwALNeG8gcspKMzSKiTIZ?=
 =?us-ascii?Q?iKSO0oMHoUwcd+xp74bxlfmE7caWljrwmsoq3W+y0uVbK2TnH5BLmxfd/mg+?=
 =?us-ascii?Q?ImloNmcaOSKtsNVEYcC2PIUlm6eZeEquuplcD1MffthgtqxcnOTlelqSW1cA?=
 =?us-ascii?Q?2wvu6qCazeLPjVVvXzHR6CXtAgqjg0TpWOJr8AwU6GBa8YpyqnlmVtF2S5HU?=
 =?us-ascii?Q?OLHc0f51J84vnwp14kRcREBmxm8Q885eD6o2oJ3UfATmqd+v6GAFVQgiDpNE?=
 =?us-ascii?Q?MQd3xcSdRPstz0tXGpOTD7xVY5LO0quSt8zeZoHxz4VMYXKMOfwnpDG06G5W?=
 =?us-ascii?Q?ozwikpba4RrEfCBI/K3qaby/epZs9uAPZFqzm2cQrlTk3+hnig7Ur5sK/Dzl?=
 =?us-ascii?Q?LiNyoJxWQRl6LvKqLFzippvtBRblzfICBjDIKesrJN9GRaurgLdE1FyCtpPn?=
 =?us-ascii?Q?WIGMQ23PSuwjVR7RhfQD4NuuoXpPKYW85dQAGA1M2kk0TSnN5VxGOgwyo62b?=
 =?us-ascii?Q?bOA7St/Qlq0hf978sXVuV33LJRtZkygmYxNJLvA2119FhVHkO7y1tbpfV9p9?=
 =?us-ascii?Q?LR8j9/JsDw7h2tDtvPFFMAjMgIO3HpwXWnOWnOrsmYXdNprv6/i+KMeiNG14?=
 =?us-ascii?Q?YhovGd9qrZA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7axYHgwKIRlX8e+l+4yvfoAMvgouryonnZkY/THTYmAU86J0GorDpIhFtcRA?=
 =?us-ascii?Q?veW17ax5xEdunx6CmeaSPQM9n581Y1tM2hJQyys3Ub4dnambwqGV1Ga1WqFP?=
 =?us-ascii?Q?fEm4a6zjkX/gZE+mjcvhDnmHDxtfOeqeRvtyi3VP8KlDUurr9pemnVYPLQ/2?=
 =?us-ascii?Q?hfESwuSztLV3uQa2P3jFgve4doHIqUt6nBb/BGyDxR8RHhmM2JhS74EWkRbl?=
 =?us-ascii?Q?SdaTZmgyMjo7MY8tBMbC99KNq4O2a9q9HsujTvyQLiIx4RU5H8sl4tdTZs7e?=
 =?us-ascii?Q?uD46ZrFZ8DulUsyPuhcArkrrUAb/4p9B8K6DMBREGIA4qNn+xe7gE9ges9XG?=
 =?us-ascii?Q?wyi+CGY+2i24bXRy+CO+gPAq6Ec9Qb+Nf5J4DxxuMkwzQ+TQgtB+yYPu1r+F?=
 =?us-ascii?Q?s/pC2J6+n/bmiCdze/GECN15RZpc0gzfcOgaHmGbJba02/I9R8rgzaCCUDQ/?=
 =?us-ascii?Q?8kqcZ/HJ81OwgRv/fqQbGlEkep5JazIwWBJ95ELU+aadYDNZTbQ66DXVzVJM?=
 =?us-ascii?Q?z4zMg8mffcbuTDmMQzeEjEDcXATEEIE8InEBecb8rgGVbHlpTXDpsjwUQYZ/?=
 =?us-ascii?Q?wyHiI6tMPltm6n5E9xdhM7gILYf2aRPlfe2bCY9/oIo3O2znG4SCcuU7Yiek?=
 =?us-ascii?Q?K/XzWJOcOPtksyO6D6QsvpOqF7Lthbyr6Lkgav03hzFuLPDB7nA0O26bVuir?=
 =?us-ascii?Q?7GeN1G4vr4dDHSTaKiVupT1aaLuQOPP+2otYy0NmMxYXuRFxF6M60B/JIYJX?=
 =?us-ascii?Q?Sk0kFUcGepUltqAu/MzFYWmkLhbZ95UdRSo3jlXC1hxdBS9MXjQ0fcFwQ3zD?=
 =?us-ascii?Q?k/TOyig9DUeAkqx6oAaKnGEifiXRJYgomRYsuUVj/RZhH4WPUVui/DinQyHk?=
 =?us-ascii?Q?4hh/v33Rw/ylJBm1j7e2cftglKTBILxVkcaGYScOSU+tr00bHbQtqqhVNn1F?=
 =?us-ascii?Q?gy5HAA5vHd2zec5IusFmcGL009akyVAZppcpAM4C9wFOgC+DrxVMQK2Y1Ez2?=
 =?us-ascii?Q?XekwbtztL97zJ1wnYEbkffVKn1CcigD46z876us9IDr3hDE0k8cH/xZ5KYW0?=
 =?us-ascii?Q?zU53y0TeJcBDR6VwCPT+Le9ubH8/ERv172FZECEiWn+i23KdvCsT2NUqUwqG?=
 =?us-ascii?Q?2QZ3jvtnIYNczAs7CEhsYgR+kbxsijcAARvJ8UDtYT5xPOe2HHOsYQcgUran?=
 =?us-ascii?Q?mcgRQK/xgpgScFI6Ze1xvVlv7dg/MPz8jyc5KBYsnjk2hxNUwp+RnDPk0mZB?=
 =?us-ascii?Q?H24kNlHKiuK02oo1spIDfSi93/T16jxkIOm4zNMTBTtwbnFbzpnyiJ0huwAn?=
 =?us-ascii?Q?AlMPrPCb6UNVbOAf6OHTq3q2VdnJO27LUPlyDFJKaFS9TsuNH9MXZfz/2pY6?=
 =?us-ascii?Q?4w6Ksn4cSIfWTT3X3fv61wFwBuTgLQkatemfqd7LDq6H6+aHcJdPg7nBt+aS?=
 =?us-ascii?Q?n3HgnCtBigRaK+XS+B7k0vstUzOpn1kCz+jBU5J1omnzQiW9WONCm8E1OWDz?=
 =?us-ascii?Q?uZdUBJqQ2mjdhZH92fj2uTh4Nv+D+DiyIEb8AzieAumq5xo/EC8fmhQSuL4F?=
 =?us-ascii?Q?0E6TFWyJ7FWkMvrpmDim8i23sUyZTDJaNaoLqdL1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95679cd-9a7f-4878-22fb-08ddd9b8ab6d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:55:33.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RmoO4Roj1qD82RNfn0ClUAbgrbqSqQwn3YvnDOpUq4o2s0m5XgzTHCkUNtuYgZ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441

and rename it to is_backed_by_folio().

is_backed_by_folio() checks if the given vaddr is backed a folio with
a given order. It does so by:
1. getting the pfn of the vaddr;
2. checking kpageflags of the pfn;

if order is greater than 0:
3. checking kpageflags of the head pfn;
4. checking kpageflags of all tail pfns.

pmd_order is added to split_huge_page_test.c and replaces max_order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       | 67 +++++++++++++------
 tools/testing/selftests/mm/vm_util.c          |  2 +-
 tools/testing/selftests/mm/vm_util.h          |  1 +
 3 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 63ac82f0b9e0..3aaf783f339f 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -25,6 +25,7 @@
 uint64_t pagesize;
 unsigned int pageshift;
 uint64_t pmd_pagesize;
+unsigned int pmd_order;
 
 #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
 #define SMAP_PATH "/proc/self/smaps"
@@ -36,23 +37,48 @@ uint64_t pmd_pagesize;
 
 #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
 
-int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
+int is_backed_by_folio(char *vaddr, int order, int pagemap_fd, int kpageflags_fd)
 {
-	uint64_t paddr;
-	uint64_t page_flags;
+	unsigned long pfn_head;
+	uint64_t pfn_flags;
+	unsigned long pfn;
+	unsigned long i;
 
-	if (pagemap_file) {
-		pread(pagemap_file, &paddr, sizeof(paddr),
-			((long)vaddr >> pageshift) * sizeof(paddr));
+	if (!pagemap_fd || !kpageflags_fd)
+		return 0;
 
-		if (kpageflags_file) {
-			pread(kpageflags_file, &page_flags, sizeof(page_flags),
-				PAGEMAP_PFN(paddr) * sizeof(page_flags));
+	pfn = pagemap_get_pfn(pagemap_fd, vaddr);
 
-			return !!(page_flags & KPF_THP);
-		}
+	if (pfn == -1UL)
+		return 0;
+
+	if (get_pfn_flags(pfn, kpageflags_fd, &pfn_flags))
+		return 0;
+
+	if (!order) {
+		if (pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))
+			return 0;
+		return 1;
 	}
-	return 0;
+
+	if (!(pfn_flags & KPF_THP))
+		return 0;
+
+	pfn_head = pfn & ~((1 << order) - 1);
+
+	if (get_pfn_flags(pfn_head, kpageflags_fd, &pfn_flags))
+		return 0;
+
+	if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD)))
+		return 0;
+
+	for (i = 1; i < (1UL << order) - 1; i++) {
+		if (get_pfn_flags(pfn_head + i, kpageflags_fd, &pfn_flags))
+			return 0;
+		if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL)))
+			return 0;
+	}
+	return 1;
 }
 
 static void write_file(const char *path, const char *buf, size_t buflen)
@@ -233,7 +259,7 @@ void split_pte_mapped_thp(void)
 	thp_size = 0;
 	for (i = 0; i < pagesize * 4; i++)
 		if (i % pagesize == 0 &&
-		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
+		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
 			thp_size++;
 
 	if (thp_size != 4)
@@ -250,7 +276,7 @@ void split_pte_mapped_thp(void)
 			ksft_exit_fail_msg("%ld byte corrupted\n", i);
 
 		if (i % pagesize == 0 &&
-		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
+		    !is_backed_by_folio(&pte_mapped[i], 0, pagemap_fd, kpageflags_fd))
 			thp_size++;
 	}
 
@@ -522,7 +548,6 @@ int main(int argc, char **argv)
 	const char *fs_loc;
 	bool created_tmp;
 	int offset;
-	unsigned int max_order;
 	unsigned int nr_pages;
 	unsigned int tests;
 
@@ -543,28 +568,28 @@ int main(int argc, char **argv)
 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
 
 	nr_pages = pmd_pagesize / pagesize;
-	max_order = GET_ORDER(nr_pages);
-	tests = 2 + (max_order - 1) + (2 * max_order) + (max_order - 1) * 4 + 2;
+	pmd_order = GET_ORDER(nr_pages);
+	tests = 2 + (pmd_order - 1) + (2 * pmd_order) + (pmd_order - 1) * 4 + 2;
 	ksft_set_plan(tests);
 
 	fd_size = 2 * pmd_pagesize;
 
 	split_pmd_zero_pages();
 
-	for (i = 0; i < max_order; i++)
+	for (i = 0; i < pmd_order; i++)
 		if (i != 1)
 			split_pmd_thp_to_order(i);
 
 	split_pte_mapped_thp();
-	for (i = 0; i < max_order; i++)
+	for (i = 0; i < pmd_order; i++)
 		split_file_backed_thp(i);
 
 	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
 			&fs_loc);
-	for (i = max_order - 1; i >= 0; i--)
+	for (i = pmd_order - 1; i >= 0; i--)
 		split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, -1);
 
-	for (i = 0; i < max_order; i++)
+	for (i = 0; i < pmd_order; i++)
 		for (offset = 0;
 		     offset < nr_pages;
 		     offset += MAX(nr_pages / 4, 1 << i))
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 4d952d1bc96d..193ba1a1a3cc 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -338,7 +338,7 @@ int detect_hugetlb_page_sizes(size_t sizes[], int max)
 	return count;
 }
 
-static int get_pfn_flags(unsigned long pfn, int kpageflags_fd, uint64_t *flags)
+int get_pfn_flags(unsigned long pfn, int kpageflags_fd, uint64_t *flags)
 {
 	size_t count;
 
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 02e3f1e7065b..148b792cff0f 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -92,6 +92,7 @@ unsigned long default_huge_page_size(void);
 int detect_hugetlb_page_sizes(size_t sizes[], int max);
 int check_folio_orders(char *vaddr_start, size_t len, int pagemap_file,
 			int kpageflags_file, int orders[], int nr_orders);
+int get_pfn_flags(unsigned long pfn, int kpageflags_fd, uint64_t *flags);
 
 int uffd_register(int uffd, void *addr, uint64_t len,
 		  bool miss, bool wp, bool minor);
-- 
2.47.2


