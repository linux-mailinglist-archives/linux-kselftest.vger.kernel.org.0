Return-Path: <linux-kselftest+bounces-38785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C5EB22CB4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 18:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81301AA2F2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01E22F28FE;
	Tue, 12 Aug 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A7fcJDDd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591862F28ED;
	Tue, 12 Aug 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014132; cv=fail; b=QtgBEh0168GZtpRsP8yEOsyrXc6fTKUhseT7ZIewhMI4G8Eg0Nkpgte11HMPIhnBhZqk1AiWedDYcCClpWMggGc0dR7bhaslfAcu/7+aiBxGUCcCA/KFK0lVeO3+z3jCdGknjgfymsD3RIOc14WHw7ZnJXiJKB2Y6BkK2eUnIfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014132; c=relaxed/simple;
	bh=xgRw6frrwsOrExvfW+RQkF03ldB0YBF38ERhJxW0ASE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DCnTcjODIBLEUPWdDTsvuc2tBHZ747fO/wMp0SxlMDuh6nQJ/utUp59f6gFx5lGOwNDLtavCXMEWHHI7c61OFJt8ldyOB3law4SKiNodfknMkkYEoj20BgS7ePcNKpzIgh+NDPEpRhN0CJTOzmua7tQEi9RABqfazQsNp1dLzQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A7fcJDDd; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+RxBhALc6kOcDQpbW/iLfVsB1Xg2aOm8Pe8muuonGmiERh6Aak3RIFL1PRAyan7hdgXHX6fmRxSs9hclXrfv5ONFQ2K+5V3p3549vUBM9kDuT69sYVQdklOh/1gCtMXXEqBHbcfSKm4o6Kd/g9UFzrd/EfR56hV0ZTishS2DUoGLwJobPgYKSGYS4LvIBPAWUkHDbE5XTShbNBdhSFDimBLe3NmwfnXtJlHScfc0VE8Crqu0pV6DHYxGGtnfC06fhJ9c8jxu8osU/6uDDyu7oxX/MV2P1yByAhJ1AI5OVSMDIQSTL5oD1RcT5n93O9mNE0BnftDbbplkXlnj7x/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lce/zWaafleCaqSlj/8qMgp97Vq8wpP+L7xGlssTHzE=;
 b=OuNo98+7bvT9CPBr1H5Dnoi6xr6fgiW3Orl+j7axUzwXXFvzX1gN8GSlCGHPF+6shoJhxEp98drg4507TAcbkRCrM/YcNcvoBP1ICHalsZoGr1sHQq1bwQRi3K3esw/en1NgJPYyRLun54s7EP1ike32cyu5tjckVgqqxsaAlh9pqR4WmP/QyNWL1hem+wUj2U6v/CnE6aiQAoszBi6l6eORPQiCgerl8WTtw9QKrurKmXMVFbZpKG+ClnYJuet5cooNVShn18pBNsYMxaPzvmKWyxlem+AAIPwvw3zAUfkoyU8A5iplOW1MjBlxIdbCm2DzWqK8MwZmOYR1MZNHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lce/zWaafleCaqSlj/8qMgp97Vq8wpP+L7xGlssTHzE=;
 b=A7fcJDDd1JtHVuKGsFPjZ2It19AoYOBwXj30FYGupwJY5znBUzsd1Gw7nMfkAuLOn96dgRUAeRewyHCf0ObklfZInWBAOH2GK8MOW0r5RSrCu0zhxcBd+kbtePb6wUfbFm2hsz9n0JC4Pred8wp18Y2OA2i7rz99Ks/EL41rEEQTjVJBd5IT/2eFvVDQanvzviCzbdkHtqDemelZOJ+pRILGILG/W3KezoGtxm3D3Pv5vCg2/tX/d2sfIRUGWE6x1dWLRA/43DwyJVmsUTNMamS9Hmk1ahzC0jJfzE9V0PlaNBh8UlS3CydEfvT9XbMuNQnh3V7pfOeuBj7aANJt+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Tue, 12 Aug 2025 15:55:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Tue, 12 Aug 2025
 15:55:28 +0000
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
Subject: [PATCH v3 0/4] Better split_huge_page_test result check
Date: Tue, 12 Aug 2025 11:55:08 -0400
Message-ID: <20250812155512.926011-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:408:fc::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b73b88-f6bc-4bc3-a124-08ddd9b8a875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R3hj//RRNUXEa8J9cBK527tWjjB+5YxMj+nM27M81I4kofRXjBPzKTMNiq8T?=
 =?us-ascii?Q?nJ8i/6xuh0/7fqD1u72T2xd0bwqDBnPpT/nti5Y7j3iFju2wIFZ8A74b/4sU?=
 =?us-ascii?Q?/25H01HTJs0nVNB6bx6u9XgPDwFqyukHO72WPG6N1Pbo0bTZ1oByPC9nsZ3Z?=
 =?us-ascii?Q?W78iwDd4leX1qRfYXiEgIqfqoVnYw7J4UuRSn3ZN6HMZA+mz74WrFUBzdwTy?=
 =?us-ascii?Q?C3frD9DIgBUOhI8u00KROBWwGXYtbkiR5CgjUJuHQrvlo0GlXtfnB1h31vO3?=
 =?us-ascii?Q?d3ejgx9jk0BQvnBzGilhKJGQwZ5oUo/rBnW2YW+hrwY3b067kGWkHVM0xF+t?=
 =?us-ascii?Q?YZwzQ5TfKCxkfVG61Bt+Z2HnogJSugaIPr2nPqCjQXpeb+8S21d0TLAdR2Mx?=
 =?us-ascii?Q?nA+SW+4RmpNJaS6H8IH2/OTX8DTGPOVOjSLIi9f3KiAN1bb4KuGE/j73JDQ8?=
 =?us-ascii?Q?an+9c9ABc5DGRQ1N5d0jPPdc8x19FN0f4e2ePecaiVnBd/0H/lGRufGxF8jo?=
 =?us-ascii?Q?+p/LXI58Foa8spSzCQvoYJ9hOmuSO1yL2AxLH8r2TbMS1nLoNU3WjGt4V5T/?=
 =?us-ascii?Q?1TYMKZtXm1Sad99UJrowgWmSszlEoKjuTuzlKGUP6XNkESyiohb2BFGs7ZYK?=
 =?us-ascii?Q?wjHLiDlwUn2b29e+O4J9eUAG9EoeHnIpAf1TXsNgtIqETjMd33sbNHkKPfxj?=
 =?us-ascii?Q?j/f0gHRYv4ejbSMVW6BmTGl31onj15y9fVeWGFFRdx/5RDnI9mtA7d0baKC0?=
 =?us-ascii?Q?lzH95WtWfafrAr1Nww3sU9oG6mzIcwU0m6aCXLGcCflhYXOEnKP9xHVwPPtg?=
 =?us-ascii?Q?gArUy3dODsP8r8db9TZScU8YbS9CzUzKS6RFcG+Uu5YmTs5YeWeHa2Lso0I5?=
 =?us-ascii?Q?QU/VO/cGcNHxTs6h/5C+vtBy0xJ2q2FJRU4IW8l++H79oQbWzf+T+U6zpx2L?=
 =?us-ascii?Q?OBGkQmyX7N0RfuPo4VWcFOBSfJSdAt72UKTtuGNVC8K3QaC442MoZbzetAxp?=
 =?us-ascii?Q?BsBRt9//of+H+/XoFTdQmjgjJwAH74i7xTBNkr7NQG80QD9EPzsSF8X8kIyM?=
 =?us-ascii?Q?j+K1UDcIeM74KAy6ztwyRI2sEM+X7+N2IIJA+4tuNk9GvcDSHAraGIaO2UX+?=
 =?us-ascii?Q?1/osG8MmZqDE5NbD2Gk4wEEdy68uKCEo0qbcGqVypxVEfDKpblMcXI3n5cw2?=
 =?us-ascii?Q?DMVnwauCfc9+3eNkAuP1L2UUJB6m7ZAq5LsTBL7hE6ObmYC49aRZPGYVGFUG?=
 =?us-ascii?Q?5VSrowMktEq9CJ/CUERwF2WeWwwUhCOo/YHnCzySbBU21FrS1y9UMFgmen/L?=
 =?us-ascii?Q?Td/jaH0KGcHkAy/GWYgHKBAUf7wbCJFyUQEeCHzw6WD/qX/YxoDQ+kPMunIb?=
 =?us-ascii?Q?VQja9Lo1RlQ2AlpZQtSSOd40kJy5kaLel0YRA/RzN9Ert0GkxAfnmyQlbS3d?=
 =?us-ascii?Q?7tGRJuqiaxk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7GTBVJWYhkc7AumKpMgoqecbnDPSNFaSbpk35f2JzeN5ypPPo1t+m+D2hvln?=
 =?us-ascii?Q?P4cyOGBFpv1ZEf1aOQtvJ9f7cWfpNPhnRQmQBHlmifGk1MYG+7CHTTYU1r9K?=
 =?us-ascii?Q?Ws78pO2o2hkcwI0r9ngX9tkCj/z1B7qNZmKdn18StczzEFnP5wbpegyzQEdt?=
 =?us-ascii?Q?fHjgWvy13ARrP4JO3fkwY5g5GzlrLqHf7xdMlm92BPJ55RcidHpT/LIMeaUz?=
 =?us-ascii?Q?QYDccWmM95rdeUcVMZD6xEK7hQKKhmyOtFl5sdKRzsDq+IQ0bIqpZ3gTIv5S?=
 =?us-ascii?Q?khig0gPEOdJ460dUCvrCMyd8NWD29WQxfLHxEPuR8moNCCfWt6vm71c4CdRO?=
 =?us-ascii?Q?kS4eSUMJVgH2HUfPKQhMzb+vtisiWXpiWc9rx+139ck8ObQxHmg+tspmT176?=
 =?us-ascii?Q?4F3OMh5Ayzg91JZse7c5QoKGcy2JonCtrRKjz2wFte4Auh/p/qV6EF+QLMR2?=
 =?us-ascii?Q?U8zBzliq9W97f0KNxsEBsywmskkscLzFPLB174nkliLiMjQFkQgAAVmQi9H2?=
 =?us-ascii?Q?bbFMN2OPvitu5NkZhXnOjY953jupNqPsk8M9+7Fz553QR7IoV/CsUm/uW69l?=
 =?us-ascii?Q?TrWMpTskSV+VOPcyZPzWoLboH8NSU7mVZMXSMyyKqsaTT/zcbjwTYb41VL7O?=
 =?us-ascii?Q?BwNBa9Wc7Y1t23vx/q0y3QNnrsYrTqCJc2oPIXHQTZuBDgCECEPZRWxI/eWQ?=
 =?us-ascii?Q?M4qFr1B7JlqPnI03xwqW+mqPLlXdoa7MAqCsKpf1BgcV/NHmf+wzt2JMCYiq?=
 =?us-ascii?Q?rmYBkNdTCvljqITjvZ1ASoVfZXF0X5bmSnWih7tpMGfYYeB8Wy466n437wJg?=
 =?us-ascii?Q?uMyIsWfi+C3L2DnaLwg7CDv1ca9jLX25vPiwUhwbSafDr9qo5QKULwb2Bgae?=
 =?us-ascii?Q?mYGorHce5HYkhlK2njNR8jxpdbOgiedL3aJpyJQLUN1hZCbdvwYAaekAySKp?=
 =?us-ascii?Q?QHRjoNJDhpswMprzeLnZZwP0B2RhL7Bu1OWIC5U17kyir4fY1cSjL6oaxPh5?=
 =?us-ascii?Q?hqSfcxIZdhObBGqKO4uJoGzZu7DM37ITs9kgYlqLjADdSaCiDQAQdG+IqtW3?=
 =?us-ascii?Q?Kx+EcXpVgehITZgVbY7b5LcNnB+cR7rZ4M3XdlPO46Hw2nOJ5sDPSCSyX9hX?=
 =?us-ascii?Q?1J4heRtXIjDXC5AtaS6iqn1P4LXSJA7tC5pMH3DVhCrpdvJKQE6B1k7iM/hH?=
 =?us-ascii?Q?pTqTr6B/8Fta16p+Ss+t9yS+ArpCG3DImT8PuktItt6sRUwdiH81hfdcca1U?=
 =?us-ascii?Q?kt+KaR5X6hvkODIi5I4Tk4qEoVfyFqref4ifCh8p8CO05zgO3SkZqxxHR9Uh?=
 =?us-ascii?Q?yayxs9Eb5HIV2CP0Dz3BYDZpNDRrSNX+vHAsUS5Q3Qk0MfXrTxge6hgM6nhj?=
 =?us-ascii?Q?YZfL4Cye2vh2XpwlQ3fLrUTLUkRXu/cm5ck8X69cmCkDNhUfkkrFgD4lX76e?=
 =?us-ascii?Q?YZV+OBosQbp1VYjTQeMN1hJhCQFHyg6+88xMojcpqBgXwuk6HEQrZANtK/it?=
 =?us-ascii?Q?egV4zkYhsQGFL5DiGB94vL7TldGP60npB7ZM9/x4rvCRKhFD+w8K2vJgC4YW?=
 =?us-ascii?Q?R8MaGWnUgWerxg2Yzb/ScM2HHRF4hw7SszezGhDC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b73b88-f6bc-4bc3-a124-08ddd9b8a875
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:55:28.1299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XZYa80qWmymJc+AMWcLtmiLQI4NSvqRtr7It8M/7xMjlUC9QHtg5nxmuzG0KxbA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441

This patchset uses kpageflags to get after-split folio orders for a better
split_huge_page_test result check[1]. The added gather_folio_orders() scans
through a VPN range and collects the numbers of folios at different orders.
check_folio_orders() compares the result of gather_folio_orders() to
a given list of numbers of different orders.

This patchset also added new order and in folio offset to the split huge
page debugfs's pr_debug()s;

Changelog
===
From V2[3]:
1. Added two missing free()s in check_folio_orders().
2. Reimplemented is_backed_by_thp() to use kpageflags to get precise
   folio order information and renamed it to is_backed_by_folio() in new
   Patch 3.
3. Renamed *_file to *_fd in Patch 2.
4. Indentation fixes.
5. Fixed vaddr stepping issue in gather_folio_orders() when a compound
   tail page is encountered.
6. Used pmd_order in place of max_order in split_huge_page_test.c.
7. Documented gather_folio_orders().

From V1[2]:
1. Dropped split_huge_pages_pid() for loop step change to avoid messing
   up with PTE-mapped THP handling. split_huge_page_test.c is changed to
   perform split at [addr, addr + pagesize) range to limit one
   folio_split() per folio.
2. Moved pr_debug changes in Patch 2 to Patch 1.
3. Moved KPF_* to vm_util.h and used PAGEMAP_PFN instead of local PFN_MASK.
4. Used pagemap_get_pfn() helper.
5. Used char *vaddr and size_t len as inputs to gather_folio_orders() and
   check_folio_orders() instead of vpn and nr_pages.
6. Removed variable length variables and used malloc instead.

[1] https://lore.kernel.org/linux-mm/e2f32bdb-e4a4-447c-867c-31405cbba151@redhat.com/
[2] https://lore.kernel.org/linux-mm/20250806022045.342824-1-ziy@nvidia.com/
[3] https://lore.kernel.org/linux-mm/20250808190144.797076-1-ziy@nvidia.com/

Zi Yan (4):
  mm/huge_memory: add new_order and offset to split_huge_pages*()
    pr_debug.
  selftests/mm: add check_folio_orders() helper.
  selftests/mm: reimplement is_backed_by_thp() with more precise check
  selftests/mm: check after-split folio orders in split_huge_page_test.

 mm/huge_memory.c                              |   8 +-
 .../selftests/mm/split_huge_page_test.c       | 154 +++++++++++-----
 tools/testing/selftests/mm/vm_util.c          | 173 ++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h          |   8 +
 4 files changed, 292 insertions(+), 51 deletions(-)

-- 
2.47.2


