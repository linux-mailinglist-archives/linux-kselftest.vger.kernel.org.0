Return-Path: <linux-kselftest+bounces-39238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2D6B2B0BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 20:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4441E1B638D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 18:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836DF2727E4;
	Mon, 18 Aug 2025 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aTcypXch"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F204424BD04;
	Mon, 18 Aug 2025 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542792; cv=fail; b=MWOdcoVcDyL6pUHmnwGNtSfKeNcDzbpQOmdqE2AsbEaI/3p/f/Xb/KzSxvMWuOUDyiAgDPftRjgBYd6HGKz3scH5k8kHsgD7DTmI37a7YWMOHjvtTOI8zhfnsJQYYwSdk6mxlj2e5U5FYHesUTFTLBw6lfh8HPyVRnlE4Gx4wlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542792; c=relaxed/simple;
	bh=JdEjoaW74bAEHMxxvZN6YEaSxMfNoZZOU40/dgKRO7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QxTg5moYl2uHEZprCRXcLcan4Ph3fkAA/qzotXyscKlE1T5EsPDWA0nrmFU2+YcWcpWO4yHdAlB4bXE1Vcmsq2FqYQ6KsrqmPTifT3XSrftECEy4RXSZaMPfbTQTX5ePYpKzXHu/sn4xjBUmsRDUmNgTA9/gZ7gIepury3RaH2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aTcypXch; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7UjuiZ1/xZhYXCpNTzV3Hi3j/iiS3f3iEpLnfHHt4FyvRArsSS1hlBoTTk1Q6CD7EgWYXKcTtaKXN1H8FTxdvQmpBPt0SlaLl/I6WaGRBnOnPDjFIJDBhQp27KBfAJOMGScAvkY/O053QHlJoKr5a+jLi0ib3lSEZEuULrt8SHPho15j3dDjv2O14avyw40pMseDx1zFLqpTyoPo7GZgP9IFhXguUvc1/W+rF/dPRQFI6I9osd5gZSzZJjH92HqXpXeB8AM4UfG/CbnM03ddYDdh0YY454ugPFdr3K5iOMwb7RMmbEp+v8KVZeQhAhowi2ppkDN2XnVR9i/Pe1DgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m20OjFZYeOwycuVn8HX293tF3ivcm3fsGIruEV+rQ9U=;
 b=Nn4k/qo5t1pyOJ/H5A/QUWHzGsjCOwrB8yvMT+EY7yD9pCYzoZc5yJEXfN3j/odMU+q8kMuKiuuYflCZNzTM5oG02cuv3Uh3x+BHgzO8PF2GkfZiz3g1mS5S4bgx1Q4ucoO4O2X47h8rk0hphaCbs10/GGX7SM7Ha8CF12eZMiQ7Pf+v5CDJcGswmwmqJB+1cBXED5kdTofm1OftedTWO8H16StmD06zrmYSGuPBgQTpdYmaYEOX+s3br1odq6RPuN0bpqHpZLjCMRkimsbLgaY84/PHRB5MArXgsTqzzlo4dzEtfJBl7GN8ccUkQCRpgWz8c6OHG6QoWphImzAiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m20OjFZYeOwycuVn8HX293tF3ivcm3fsGIruEV+rQ9U=;
 b=aTcypXchXMPCZiNHmDAaVP4A44PTF+fwcgli0qZH1J/J7d8JuLDYl9FmLkLQ1/o4pwr0e2EXBlCASzFCIVa2gc7w3vrFs1WubVgQMaHm+0EXWIBhtUt5F51Auka9qhzTSZDUZLsX5EQMe5jsBg08EubHdn/Ccn8NWSuSX5hm31og68u72Y+jxGrb5VdwYR8MuNB38098I7Z0owh1PYLnHJQr3SPII1bFKinZX0ONqLpigDUWAfaEcjylwXpdrZeIhtoL6rYFgafIV1V6+QFH3FKaURyAtsXLIk5II8sIrrMWQatpDDvAp2KjSCCuP5x6KdTV2Nl4mUNAPP6UtOixxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 18:46:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Mon, 18 Aug 2025
 18:46:28 +0000
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
	linux-kselftest@vger.kernel.org,
	Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH v5 1/5] mm/huge_memory: add new_order and offset to split_huge_pages*() pr_debug.
Date: Mon, 18 Aug 2025 14:46:18 -0400
Message-ID: <20250818184622.1521620-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818184622.1521620-1-ziy@nvidia.com>
References: <20250818184622.1521620-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0048.namprd04.prod.outlook.com
 (2603:10b6:408:e8::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b310a5-05f7-4eea-a9c6-08ddde878a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oYRQB31UH7y4lqz5K1EF3Y7B/FZauX1lZAcTMNWtuHgTMGh2UhHzcvf10HWs?=
 =?us-ascii?Q?au/WRun12K5b98izWN4fW8SF32tSACixG1yZhT8o00M2RiSU2BrexWoTSOn6?=
 =?us-ascii?Q?B0CqgNAA2sV5jko7mGWvJhpA9FjzlnJ5dpcq7imUtd8IwleDMGwK/XmUpP3+?=
 =?us-ascii?Q?J3WzMLAZePutCFTkC+1eV3ImY6N+PhIE/CRvnD3F35Jq/rayoQFAkyjIIerZ?=
 =?us-ascii?Q?sD+3VRwT93T5nesMfOUEQXgRZrIZsthvhkPurR0YZKmkwgWLpPVDCJoKmYgQ?=
 =?us-ascii?Q?s1JscINp+nZFnvoJUKlH+IB9EZIo0MEYtP/RyLGMcvvkixXtia15iKLmnmfG?=
 =?us-ascii?Q?wR3KkYFPBYYkIR7v/tAKSmXEUybIEnyhluZabbwEhGft10hQVwleVYq/tJZB?=
 =?us-ascii?Q?LE1k9caYzxMTdtvEpBc7XLWcRE2Y3EWKuRaGtzxEwMCjL6nXYpHOjBQaxrbt?=
 =?us-ascii?Q?2g2oD0XiQw+YtNsKr0iHkI+IXA+cduj835kXFhsHyC/EXohTw1VLZm6FoYud?=
 =?us-ascii?Q?13eyTpCPMBXcovLqxa4ejZVN9/QlpzfJZBawQCPDJ48sMDGSP34XwZXk/cDw?=
 =?us-ascii?Q?nJRUqou8h1PY5SqcyPTy8hDLmapGGvExBUjLKIRHlf3EweQa5cfZXVZXiPrW?=
 =?us-ascii?Q?LVoWGAUegEn+3HUusJNGKe6a0ERC+hBtVrW0vbNkIWLnt9gI2AsdMUBwOhaq?=
 =?us-ascii?Q?0FIbZ4Fy9jT/Y37OBPDDZn+ofK+4aHLGABsqsCSv88PkWUFHidQCc6wgP7sX?=
 =?us-ascii?Q?7tHQNlyCGa9m5kHCqzqgnTmg02DEpEVehaGYqLnvHNd91aVYyrH7eeKaucBQ?=
 =?us-ascii?Q?mgmxJQVi1CeUqnGxE3wywv5+hbSW0ajngRrOGuXowlqk1+5bukyrFfs+SA45?=
 =?us-ascii?Q?9zIhY1z6GLCb5ROaBisBlZZqKGr3feHb3jCWRZUW6b1VMwuQLCaGHmjimOj4?=
 =?us-ascii?Q?quF8HLnch+gJtrhgxvJ4npscIBVPv9GqbpGgEmQe8jA0YOldf/+z+GDXR0ml?=
 =?us-ascii?Q?mFfLEQI3/ekGH5DV6skoXf29DepU9xCAP2F5IDk4FzpvdtjNK+dw8vpNJo2a?=
 =?us-ascii?Q?n74KoYKATMoxN3E21l9U87AKbrMk+x3aahgkGkzfkrGbJGzCVpU0t7fYhfVX?=
 =?us-ascii?Q?3uE7UAkT6yeYzq/Kv/o/cjzEKTiA/t7jwNxeGRNBuN0el6geCZjmHPBD3okz?=
 =?us-ascii?Q?3DbBLuFWQr3wOtMTg57TNttIqG89XtgpAxeuwOOzeohLs3IFYXCIIgmxc9rw?=
 =?us-ascii?Q?fkh8JADkQ7ugrq4QjhFliniKc+/cJwNoMbCpxBT/GulcRrtcLmCiM3w3PsAK?=
 =?us-ascii?Q?Yfy02yhhz7oYlY7ko9xapBVGqVPdVOPSRsSaCW9RxYqKjhoNuL7n6tpat4h7?=
 =?us-ascii?Q?nFX9VMCaHykWmj37XLdeHcfTKZTmP3B4HgLt1TkqexLrrin+nw2v9lalotZK?=
 =?us-ascii?Q?y3UeOQYxbuQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?758pSkuQrBhzeaGfLivuoPaix/DPP0pnJ9PEdPtZrqdiFrJknjsdIgem/TSh?=
 =?us-ascii?Q?0Wif19mqU50gUsfJ297Ec/kySC/J3KNXgzJI0eUodk65kQlNivHAux/brGAX?=
 =?us-ascii?Q?q5NfKRCX5j33v1tIFB9goICgj1DDu+MdfU2khYKfNxZFjyv/VCJcO3IT3B/J?=
 =?us-ascii?Q?PfwF1cKO1ZWys+AutlM0kRG1p+CbK/E1+unMYHHyTBe74a9FWpTvGlnqh3F4?=
 =?us-ascii?Q?o5xKgF/R34by810MyH1xatmk4EpjTgSC8ueLURxVEifzg2OQ64FG5Awo8JkA?=
 =?us-ascii?Q?TJMIR5JtEMUTWeY4yD140D7GSYkEQsOypZqk/BiAxvayyUIk0yQOiLScLGaS?=
 =?us-ascii?Q?6HCk31lAoCVMDQmWXEGavoS7VgLvFl2FfHEweyB2ziJyyA8upRrJaFrAxupa?=
 =?us-ascii?Q?jBqbVl1MgLTRahnW2edFboNSkMwYkaj/VGqm/zPUXpydubEQOkFEMLcoyGTy?=
 =?us-ascii?Q?1R2mFyBRd10m3EfPHK6r304rQzZ3x6q1DrdGqGupsxVcA+FSX4cwqvlblyNx?=
 =?us-ascii?Q?gxKzC7PZdZuDRM1MaRCMx5ztKiy9suCvTciiqKIHlHwCf77HZB88BASR/+IM?=
 =?us-ascii?Q?692RrI+ADka7285zJ8xhm0GXNb55YGQ8fMkrsa/YzR/9IiCKulE6ufxMe8J0?=
 =?us-ascii?Q?NR6G4WRuxWXzzoOHJVWiZl64ArLwXfidOFz45lQTXXLnN8ezo6m/j2FEQ9Tp?=
 =?us-ascii?Q?Kdfbu90xa5fgOZXftF4CNSzjd9U9PhyVmLizGzrEq+GlN+iBzGjS7JCaMCCu?=
 =?us-ascii?Q?Eb/R2oDWQapvdQGPMW0iBirYUCwhxxQk4EhWRbKAD7VXVrZK8uPwnNhnvJgH?=
 =?us-ascii?Q?ubga7aCq8+z2viaopkMb5v56E0gUDj/Ubm6nj2ikYN4qJ0x1cXZsj46YwENH?=
 =?us-ascii?Q?oby7dvrN8aRaq/nTaTcgghTq8ZR4bNI4Py1DQeZc5qnOmFQFLlTN3Ym5sNpD?=
 =?us-ascii?Q?psN2bGTYMwK8aPdJe/uWiDz0Ml1yuWaIkhtfYi5SeFxbHqgYMdpwg/PEVU3Z?=
 =?us-ascii?Q?u0gu/VNsJ3046OWER5aPf2xWUFKw6ruBzSpHzIWkq/JSJzvDR2wnYTg4orD5?=
 =?us-ascii?Q?oIjTw9u3P2Uk3D2WCr4cNSd7S/XkcotFa3uOJJ0+ailo9ReS0JVPqj5S+oia?=
 =?us-ascii?Q?aMS8npNocoWG7dsw4lO+4lgFkg0LhRi4WUgGXMviTVotHcZV05BtkTtiJsYh?=
 =?us-ascii?Q?jQB2LVati3/rIZZg0QjW/YNCOXNdCwSBVPP56ivgPvNOtyWyUjbdBRIkRXKB?=
 =?us-ascii?Q?lqXY7sTsWIJCsKuGo843748tpPNumDkA/3ghcqCYpjEea9YXloBsyHsjfQMI?=
 =?us-ascii?Q?4Nwt03wNAvDHbhru3lgYkUXs36luE0osnwZpvE5Is0Td6y+cBMoiT20PMUUR?=
 =?us-ascii?Q?BngWjb/bosIpeqxPy30cHNwH3v/xRWrfFWVchuUoPu0jRTJOFgAu7tlBwEqa?=
 =?us-ascii?Q?z9qEBm62GLf70FD1AeraOvb0xdbk4AZ14az99uxpK3OJNqTD4h6rrOr7mgDP?=
 =?us-ascii?Q?0sUBAac0UnnrfewbR3wFMnnuo1pB/QSoj6AF1ALxAVaUBIC4h9X7SAnrnQDu?=
 =?us-ascii?Q?HQ6HKjx0gchVXdtF5n1S6tWAlA3X6aHLSctIPI3I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b310a5-05f7-4eea-a9c6-08ddde878a77
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:46:28.2658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wcYbTlQjFaMT1BWjJaw/NSNF9cqpDMOzgcG/bfl0lFyvLHI52nR2uxpkda3UEVq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342

They are useful information for debugging split huge page tests.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Donet Tom <donettom@linux.ibm.com>
Reviewed-by: wang lian <lianux.mm@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index aac5f0a2cb54..2a47cd3bb649 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4320,8 +4320,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		goto out;
 	}
 
-	pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx]\n",
-		 pid, vaddr_start, vaddr_end);
+	pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx], new_order: %u, in_folio_offset: %ld\n",
+		 pid, vaddr_start, vaddr_end, new_order, in_folio_offset);
 
 	mmap_read_lock(mm);
 	/*
@@ -4431,8 +4431,8 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 	if (IS_ERR(candidate))
 		goto out;
 
-	pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx - 0x%lx]\n",
-		 file_path, off_start, off_end);
+	pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx - 0x%lx], new_order: %u, in_folio_offset: %ld\n",
+		 file_path, off_start, off_end, new_order, in_folio_offset);
 
 	mapping = candidate->f_mapping;
 	min_order = mapping_min_folio_order(mapping);
-- 
2.50.1


