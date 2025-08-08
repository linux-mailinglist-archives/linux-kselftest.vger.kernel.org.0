Return-Path: <linux-kselftest+bounces-38610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A526B1EEA8
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 21:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044525A2C1C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 19:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9EA2874E8;
	Fri,  8 Aug 2025 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XG9S38vY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC721D3F2;
	Fri,  8 Aug 2025 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679727; cv=fail; b=DFNnaYJFSQYrMdTQCp0g6wKi+NADWIHzLA3dh28sb3Ng5SCUUZ7v+rEOH6c65dVB54wPMRm5XoOnl3O5GBsecpqtgVPvFsthPHp64AbN4iyP/fIc2rAEkfSLB92XuUIwN9CLA7WmgM+rEuK0JxJsRB5cuiUq6I93bK1Lyqa2ut8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679727; c=relaxed/simple;
	bh=jm2d6pdMudpiK8supF1a4QCSUePqSPgCkCQh6wU69rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fq5/SZhnOm0/ceOr8c+Z7qeCUh/AGm/2Do5kduI/aMeewZkdJP03GA9b3TCAjz9Knm92SuTMhaVn0s/tYBh9axXd9p4il+/zeNrn7kW4irDVhBBwQyEKMTc0y4sMchIRN5jlX+qvyh9t9hlhf6LXp9kW8RRZ27GHzBcsQAefbxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XG9S38vY; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oX9eDaNuprTv41rLTqouIdRU0G0HtxyAjKSin1Wm5sTIPB89SI+xgV0ziLWCXQHLuuWRAFma0y759R+x9m4KnqFs4xwDCYLIJ72ezmXNHJFAckzz1MGJ+q+F7gCIM9lqMlhwqrRwdhdtoVx7VbfuJ7TVn/+3eYj2a1nCVbBqXdWEHivoTmXzFjBEMKffXtgL4N37HEGHKINacYV1UVo6Wbki9Ec4Nw8OXEDAdegFYvJanV00RHW5BGM9TFIDYxK/CSFEgRImmfwk8s64eNz+A7JFbuhGUpb46dVFOEk3cNHw2qfLRpCQ5KwTeNrxcORPbUJET6fPCMg8E+R9mQ4HtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BU/0/098FYpDzyumkB8zy6z2q3b1Qql8NNosUbp8CAY=;
 b=jV5Uvpzs3oATjtcEShtgegeZ3cMvbIk00zsAP1sTFvF57g//iPKHI3nBf28GdW8SRuVpyQjjTlaCJ1pmQ0Ots4U0AYHjdD7s5X/LFXoLVV4zndzGnm1XHlPhzO1obDcIPTR7gSsVC2YV6IsMl7pn4MhjiCRyxffvrXhOaNWezsPTW+3ydjp/VlQC5dH1EAogWjwjr/5NVGqFfvr87zJ4OCTo2RwIKu6Z1AlPlYOJCMndAlq8SDSqL8qrNimdhrZFlK/Qwft9jXvz0Tt/27DYs42jk+CK4o86yoajSuukFXwr6j+sw2bjWvWNoNUWVxgCIaTexJBNS5CErqz4ypVjIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU/0/098FYpDzyumkB8zy6z2q3b1Qql8NNosUbp8CAY=;
 b=XG9S38vYDtdd4/mPfKD+eyAxZ1agknkVJglttxiQsb2eav27eGrevIigNuZjrsJRgkykqYRxkfr+o/mt8pLcHC0gai+2cAbmiE8nSAkD4P9y58K6nMZYVqJROwY1uSXzVeZw20qKVCwN7DfZ9KMBZvvISdGfOwNDhU4GfbFqK/4LtIbUfLExVbTC8xcn34b7Kzrg/bAEy6gKk19ClCPcSDiM+Q9hYU0gikyN3MsTadDXFsWX5djWkGXte2iTzT8Arm0n3Sq4uWJOvVdzH2HcbM5fHqGzgdB6PYlT9fL5VFJ8beXxO29Nfyx+qpMgEzDO07Aq+RkpR1GQjW1xvyD+YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 19:01:58 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 19:01:58 +0000
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
Subject: [PATCH v2 1/3] mm/huge_memory: add new_order and offset to split_huge_pages*() pr_debug.
Date: Fri,  8 Aug 2025 15:01:42 -0400
Message-ID: <20250808190144.797076-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808190144.797076-1-ziy@nvidia.com>
References: <20250808190144.797076-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:36e::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: fc86aadd-7154-422f-b458-08ddd6ae0c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4vSdGKaXrScvAugOnbLuvls/OVeSqW6R5xGlEhc1X3tIQs+2xoInHFCYOgSI?=
 =?us-ascii?Q?2y3GYscBWn/xDHc/BRmD2qkhtlb16wqB1E8YBavIbyHiZ9QztU0/ph2+NkNx?=
 =?us-ascii?Q?EuDANaemCY9oq1dQ3apMQYtCvcODXI8h/BOKaUcEsCGj4iR8gQeZC5V+hirF?=
 =?us-ascii?Q?YAoUVMHM4IgOo7syXsg4WkbF3gjsHXEZ193TBV67yfZcGm73duo0WW5JSEmR?=
 =?us-ascii?Q?aKBOIYX74wlTOgVPRZ6CSdE/SujqUa0AbqPPvbnqD9IzwOew9evS+TdD14wm?=
 =?us-ascii?Q?KLFmYNOtD4jjSdA7Oby1W44TRixwq00EfVEDiItNoU4zJQEzPqBJgdwn75vg?=
 =?us-ascii?Q?RUMcb1Z2CPc3q/zZCOngORC2fubK0ZIPbZmzzcvANgcsRW69ZfcSoNKRQchg?=
 =?us-ascii?Q?jaBPETeRgBfCVpB/xhrw9UAPglx79kISwTOGkXhPCY+Q1th2/kShlh/RRJRV?=
 =?us-ascii?Q?DG1EBjzvMBR0x7HaWovDdLwdFs14tsaWexIAOlYXABLpW4WJcpMjIsPEiua8?=
 =?us-ascii?Q?N2pjIk/priPJa3FG3T6cYGAlINSPR3zbdEPGgTSBCReWFcTCC+EmRNEccMlk?=
 =?us-ascii?Q?rBkYwKGWSWNDAwfWzg9ptIcgCSh0kLyirFDLXMS1pXl5o1G+QsIfLlmhmLWT?=
 =?us-ascii?Q?PkMzz+wiUCoN4UvNdm5PxOw05EUNZNrt7Hy54r/MaQ81NJM5Wzn4EqDqAioB?=
 =?us-ascii?Q?/kkNcxFGDLruM6QpIEKmRn0nqZ+6trDwZvWbNDbQzptpLsG5cV4KqwiRFlcT?=
 =?us-ascii?Q?dl5Z57FkPdbwXEPMU05gu7bJ0OizdY59FMB+cnCXHtAML0vgmsxKJvQCyouM?=
 =?us-ascii?Q?cPRbVQwZFjDvXx+b34P6H2smck/NRRTdhE6uAvuh8ou44eK7xFaOzww5W/gT?=
 =?us-ascii?Q?oV/LdGW1/xRWU1lRuxnJDwJ0jDTkiDvGKlTiS/Z5Z7BrCet2yL9O9mMZnsKk?=
 =?us-ascii?Q?qQsxYpeKA+q8fZruZYEoRGrOrBvY21nZ0ouxw8R1HZyHTG1+Tc4i7ZG0CsP3?=
 =?us-ascii?Q?OxqaV9HZKoNE/th+EVufp4oQ62RcNPyE8qPxYqRsKXqJQk7WZjgAxuLBEIET?=
 =?us-ascii?Q?fcjN70oCNWPUMSb7XtZ3qM7hhRhJ6vnL82Pli5yTNqWUbiIzVsdXoIoLxki2?=
 =?us-ascii?Q?lsVB9nl3v5YzU3g/Wx5Cj8XIaLfRr8MRQET+ag15/abj9wGA6hKuQNdUzjSu?=
 =?us-ascii?Q?aoKmNf/aK6rwsH+1FPfDnernrg9WV2Dyft5xHPKks14rgKU46JpGVkx7xHog?=
 =?us-ascii?Q?8rKvtoc1sfQDl+j6PNWkmuDw3N6xsUlTW2MpdILckS9oTmxkyL0+Dq8lfMVg?=
 =?us-ascii?Q?z9zCNqE7L0sSG2wf4JkFJ+ihXNNvWZXm75icbVZ09vf1udwq60Qvxz5jIFai?=
 =?us-ascii?Q?aQjbH0FlTIcuk+RkrIANZIO1/JyPb5gpPVYug4hH/vqvd6Dyve4aBvHfG0ZQ?=
 =?us-ascii?Q?74gbKlRZTPk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FJpR9381qMxhJq6w7uOSEcUTAtTdnBGt1gNrRQryixttgGxXuSMHWqO5Rp6h?=
 =?us-ascii?Q?lxas8bRskcvXbPeniVWg8YahKpH8S7oLO7Ay2Kt0kxPGeU6jRDAtKdTsRjt5?=
 =?us-ascii?Q?6zmfG20W/lQog+tBuFm8KBtrHf0cIxO8zA6smqA/SX0znDRj7eyvhfMo27A9?=
 =?us-ascii?Q?7N2PWLhDrJKH9wn3LgKYibzylghNAiZNkFxQru08lT+9ntRM1tqeS2GgMU+E?=
 =?us-ascii?Q?bzduBptCRxWXxC89g8+kxp3dx61TzLrnGHEd3N46pACOSi3G0Sx0gHiJeFsI?=
 =?us-ascii?Q?4fdM8g4KWj1Iu0Xlpbx4SMX1jPoVBy2bn6X/QdYtFExVhqnysz80O4YRAqj/?=
 =?us-ascii?Q?8Eo32p8XiiGiS5SHTU8WHYFgGYPDCIIh4MDABgez0xzKbyt0pJ1FppghorDG?=
 =?us-ascii?Q?sfi2iuFYtMHainM7op3uW61bGVOXwOqLogt2lFPtSegbpR3GkO5ADXm5SPVk?=
 =?us-ascii?Q?ePlsrunJD7ThxBW+lxsW25kYT1hjYJzVqdHPYSLmOWO3z0RstoeDzxnCfocB?=
 =?us-ascii?Q?WLvLm9DtYeUdZRqmJ2dT/cRioruwpTh3o+SXmESID6IDxzXXBwCM4AoUkVhv?=
 =?us-ascii?Q?0MgS18WTe5ufdy7sUsplyKm43xzsJ9tfdNXrePNK7Qfpp7O+JCE2BcDoGR5m?=
 =?us-ascii?Q?TsER231jm5bqHe+8qY4z1zMB8PRMs0ne9D1LNXe6ZfG2RpAZAbmuwKH7dx4q?=
 =?us-ascii?Q?Uctd7KoxmyxcDWSNOSUkuCE3utJEffhzvpFnLi23agmbykv72EOIW/kSx+Sf?=
 =?us-ascii?Q?RtY9iu3f5s1yDYUOP7BPOQvg7UZoKh7kwq3FWUKFnBsoTMqvn1jaQU8LJF08?=
 =?us-ascii?Q?TN8LxhOfH6VbdP1p/49LMjliBFPuxNMxrYraV3cVZzwX+syhl7ACijCvRWJO?=
 =?us-ascii?Q?SF6Ib1VXpHdmpZh/BIw5FGli5eVfHLtqXAoXx2pTOKv5bI+bpZXV0sPjbhjL?=
 =?us-ascii?Q?x2R+dGjUMFHJeZZbzsBcNlmghBSDKhBlUP24ckKy1TuOxNqFUe3YRs+JWtUb?=
 =?us-ascii?Q?3bNrPutoKRyQ9MgD/saJzGHYdOUjFSUBbo9Z6ze2hyzpnvsfjbOfOc//QTwb?=
 =?us-ascii?Q?8WOeEAQB9hGax2DJ2Kuuppj5mqi0g1FHM8JM6+YTgeo8miqxYDlkaU2632Xc?=
 =?us-ascii?Q?v+S9q5s0pZU/r/b5MaXtyXLrrSMFq+MRhMoVAxMlw9LM6NlhSgPj/XKOzq4d?=
 =?us-ascii?Q?cZ9Fr40G2GIFouh0O2kddD4MYaaoLyuM33GFpLHpqOsqKJErLecAcC+M7Zmd?=
 =?us-ascii?Q?fD317NbIuo93wQc4vpl6QlmgeRSFg322KRvVjK1mFWzH+Rfsox2bDV3aWaQv?=
 =?us-ascii?Q?Cg6/qIlZcYaF0FL7DtTSdDPJRA6c482wrNH1At110IaOLCgKHHAZIlv9A54z?=
 =?us-ascii?Q?UK81DGx5Lh68IIGWKNA4NGRS0gLfmk5FtvzLXujZGs8+3CYqiG0OBbR3eLFT?=
 =?us-ascii?Q?0l7SY+zV320BKPs30qpb2GU3OF1V/0S/b5BU1/xGQgrXb6rA2yOVgzfcnTMN?=
 =?us-ascii?Q?Od9VSgKn1el4eCsnPjel0ohDS17A/dVtwuMo8JistT6vvF3mleBPZkU8VM+u?=
 =?us-ascii?Q?ylxEMSFnbL1OZjWz8XAkhW56E2wWfZ5OrP2lWjeJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc86aadd-7154-422f-b458-08ddd6ae0c7f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 19:01:58.0084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDxb6zlHMek8x7mXEsMUmaIheFqoZqIODnVGjzaBuTqmwup9303kDJU6M48gEQRD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090

They are useful information for debugging split huge page tests.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2b4ea5a2ce7d..ebf875928bac 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4327,8 +4327,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		goto out;
 	}
 
-	pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx]\n",
-		 pid, vaddr_start, vaddr_end);
+	pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx], new_order: %u, in_folio_offset: %ld\n",
+		 pid, vaddr_start, vaddr_end, new_order, in_folio_offset);
 
 	mmap_read_lock(mm);
 	/*
@@ -4438,8 +4438,8 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 	if (IS_ERR(candidate))
 		goto out;
 
-	pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx - 0x%lx]\n",
-		 file_path, off_start, off_end);
+	pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx - 0x%lx], new_order: %u, in_folio_offset: %ld\n",
+		 file_path, off_start, off_end, new_order, in_folio_offset);
 
 	mapping = candidate->f_mapping;
 	min_order = mapping_min_folio_order(mapping);
-- 
2.47.2


