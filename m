Return-Path: <linux-kselftest+bounces-39033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3680B2763D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 04:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9758AC0F73
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 02:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430FD29ACDE;
	Fri, 15 Aug 2025 02:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A56OLIvu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D0F274FD5;
	Fri, 15 Aug 2025 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225585; cv=fail; b=W6NjZ0pq4U/BLN5/yeedaQSoeWyjA8HtrR+Cmi1L9QCurm3JQPR9mHyDJh7jZigs1juZ+79tQPa6qp66c9dmcPNjI8wGt0UGNdoGlsuV7aibVvguEtsqyp9f2pNVuhV1mfcR4MTPprJqSE+c7zx6ydBoMLHgdzwAa3vfYU4lXaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225585; c=relaxed/simple;
	bh=D9lEPvUyPEbk/t4LlB+eNO7oWDXeAZikj+RS96JcxjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRZAzvf9OX7AU4URDX4g79Ds0aa19GptT6ZCx1MIRQHgp+YxqTs2eTffVgjC67FvpHmHhPz5UnTyrz8vya6UGvkkiYaAkBaQRwyn7lYwp4yC0CXRv6vYR6uUsXCE0uBrnhZk8IE0+DQ5JEkQ4zocQl4hZ2ezbIf4VRA3UtwdnG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A56OLIvu; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejI5YGvE/Kn2QBXveWk+mCWuxeJ/R98HvhNl2k9X72/HbwFembd3ry+maPT3k4iMF2Sh0rqckPFOq/qFYMJLGcyqtDM1oOvFeQQqpzUaeqlXUg9vX7wSIeBuzF5k4Wea8FyDtKqG4JRq82wu9auACeLWcsJ+xXqM0oaZLFtGKrlcuIxMjH2UT9RgrQNNhq/8ND/zPCVeyblzCcThnyZxUx9C8PUCyjiKzbH8ZHvKFtAUHhS18mk3PefC9U2oT8rAI7/tRIM7hUxohXnUM38yL+YKKhBbjfOFn7LOV07L8mwqodFif+BODlzn3Au1pFNqe/yCr/Z96pCWfTK9EEE32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3Nv6QYq3hEmgjLaysO9MKN4vx+xGxG4ASEVQbXzzI8=;
 b=EY50rh4XmblYojsW94TQm4D1c1FLrHsBa6gEcmEko6oIFH4SFmqLSbXdYdvrsnnSArFcdpidn+Sxxs45DEwumbtc6OR3SgXZfwwqYSHQuceXvLYefBRvSqq0qyL4dYYiu/sdPWAZtpLonpOPsB65xhgSYHKJhAJgqvBy/+Id0J1iIIiVpUMxfFRxMUPe65Fy29vNqX+wQtiWwxOIno3zTu34VZnQXkOi9Q2Yk0PIOJgyHMlSB8n0adCWDH5qYZ/cYBodAfj2WP5hiwnvTFNV3RKovbYfPKtx8COb+wLvsBAn2+UcoWx4juHprfNB1q8+DyEToeJmmhY9Sl13IlEs3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3Nv6QYq3hEmgjLaysO9MKN4vx+xGxG4ASEVQbXzzI8=;
 b=A56OLIvu+rC0OHTsqhPHDod87zabCwRUDp6a2ZHPb8yGrvcTdoqPoXe5SVcliF5dswTQsAZD+k+THS7TRKAM6St+ZcFtRHiG90hZUgTp3ERBPE+Ll7DB33igtXnjzt58R2twcTV8ILT9x9W6VFUcMxTlXahkHdMC32OzV0X6Q1vRdJf0OAnWnbvoa1Jtjch2IrJzPAq1+VeDC3tbag6zyP9qVF1u5TAdPCs+ebyQtbPSp3C464wB48nK0GvTBy9wczmkNuZfaKnCdRl19q7rHD3h1YqmI7AImHskfLiqOlJWsX5U9mmrai0qDJt1LOZga8CL2OCiqBEp30OG0BQvWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Fri, 15 Aug
 2025 02:39:37 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 02:39:37 +0000
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
Subject: [PATCH v4 1/5] mm/huge_memory: add new_order and offset to split_huge_pages*() pr_debug.
Date: Thu, 14 Aug 2025 22:39:10 -0400
Message-ID: <20250815023915.1394655-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815023915.1394655-1-ziy@nvidia.com>
References: <20250815023915.1394655-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: d934b360-d5a2-41d4-75ae-08dddba4fa05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?stZTXiB7gwEEl+tSA0MagkAA827/GgGNATZiB7YpYCXcKcwd/Sn9cxlhEEV6?=
 =?us-ascii?Q?9bxM93N7PwcrB69WvJ03ZnK9RCtXVPd6WYV3D46jPn3qEaKLqUiSKidKxq6P?=
 =?us-ascii?Q?yURLhCoLwqPLCAxK4vBryAxMF/0owfVuK7SMMpmgBz+guYGCX1MKHq0v7kLC?=
 =?us-ascii?Q?m2InJDxCFkj66+hAFGNaKgehnzhvGjJf6weD+YsaQ6ylOZDjDHt0kPiIOTYo?=
 =?us-ascii?Q?amI3L9uxjKi6DjwZi9rVHhsGP9CsM3Ov8xS7pl6tPCFpzkkTQqvlGg5igATd?=
 =?us-ascii?Q?uHuF0gSMUd/g86XxDxpHQJDufiOfnlnWgFFlSZq5aeedSTJH3Y/JMxNUZfSA?=
 =?us-ascii?Q?LFgIfDlzmvfFzQB5lv0esitsNCg1Zjf5vVPqiadFtglmhH6cvtjFp2+eR3nF?=
 =?us-ascii?Q?MgsgUKJFd5V/F4RaMsp3hwqUYcvFoGy8jLPa1lE3aFSWvZnxBrOkS38Wzxws?=
 =?us-ascii?Q?Q4u0utxsh4x2dBlll90MO9mbAvbOVVsfHSzELOdsSySE920RmpMMlU0xq7lL?=
 =?us-ascii?Q?LDSTgVhM2959sOfxoE4ujzk0UJcF6YWAD7OV7jvxTsGTPMIlMUBKFVk6g5so?=
 =?us-ascii?Q?8kxwIzEZRMcP6wP1qb9vHW1N8ed9br3QgYVoWUMav4mXpZWTwuAv7q4yrPEb?=
 =?us-ascii?Q?M129HsJ5nOl20Auw4wJUR82uf+j6O2Vl0Qwlm2URUxfF0vjtUwf9sKdMzA3m?=
 =?us-ascii?Q?BwVULUdLb+GqhbIBqYBs7tpFoSiLPELqfWmZcRxxHiZMRyfAb6Djipiql/6X?=
 =?us-ascii?Q?1NJyU5Br4OOLqqLaFjgZ6PjdE57MbpvSJ4A4rc1GuRWSwgqcp4+tzHpB2hXR?=
 =?us-ascii?Q?ymor2HEW4GB8EWe8dCN1qdfPlq8Jl9zJxst2EMVzlQaD6LL41rLYvJrwu2CZ?=
 =?us-ascii?Q?j96UQMetRzsWtndKJ9c3y4zLCrSeDgvLtEP1FmgqDuUS3AJqnixCFBxyWsYT?=
 =?us-ascii?Q?PJX82njM2pzn4rYgJl84NfBkWkMedjQ6iiXlxqSK3XdhBOHw7gvFk6R2F2Xx?=
 =?us-ascii?Q?Wd8irSjXzSFS+VhFTToYuvX+SlijgprM50cfnaxqXD6XPR+iosTQE8DSoutW?=
 =?us-ascii?Q?0CJx7wUmSCqPy/mZ6GNJwRya02vxsxL7tQZ/Ht7EkLqHBbCRwGI8irHnG50e?=
 =?us-ascii?Q?3bDaoXmClAaBYsmUNfJ0Wm2plNPiwv2QcxtTPT8DcgMUiLYMnhcwCwGq/fnT?=
 =?us-ascii?Q?vMN4CffhcqdtN9HPhHz7kJHPvvAAHKu8KWTMl6eRUOLcZ3WnBGHaAQX6WDut?=
 =?us-ascii?Q?HqhdH0tWP/nT1Ke24FCnPc4XpKpRE4RVsNzU4gruzUsasKEasZwuD08KhjOz?=
 =?us-ascii?Q?xq7UwwSKYUHDBiY8gnOv4txESCEEf9K0h1DeMksPiD5QEhlRBIrzW1zj9uzW?=
 =?us-ascii?Q?mDTMb0H0E/DsxPlCOT4xNtgYaQcHlO9aY+F9oLgKcpc7uHwKL/tHIZIfsVa5?=
 =?us-ascii?Q?Nuh5SFvLV/0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hFgfGmnfWuRl4IOq12sCevXnjw1flkvwhdNPFS1Jc1Fup6fnKnGQON/X+shv?=
 =?us-ascii?Q?WYUeFtZYkpytTN36wK/EBMtjbO4n/ASec9W23PpkWjDDMPTENrwjU6XIbaNv?=
 =?us-ascii?Q?6bc0LDjcpPjjIuZ4aRBgY/DvAsTGudD1vWcn9NHx4eoiz4mcKWB56qNJp1vG?=
 =?us-ascii?Q?ml7KZr+9H72GpARejnmdl8C9mekOpfjeUtvRmgHLdZACzvyn/sBfmlps48WN?=
 =?us-ascii?Q?btPRPrKAKCeRP3UUek/UEmdKJf7mbEaseVL62ZdSRbpKkbqXevOPsiyS0mSR?=
 =?us-ascii?Q?Heh0Y10O6hTesxHno1LmRmvJuTZc9EvKWDQED80lDTVhOLgrUVA2z+W13Rcu?=
 =?us-ascii?Q?J5WztFhRyAZoteBw56ugPqs93fXJjh/SKTQR4wUj+/I5un4NiRmvlNKojTVC?=
 =?us-ascii?Q?uQKslIOdBQx9MF1lhnuJMz2GKaBlibxzceV8PgcjUXoiWvDupxr4G9po/fqq?=
 =?us-ascii?Q?cPruEkPQsw85XPQY1UTlkxrT9eOjwXRi6DLc4V8CdzA1KF7mC7MOWP8BMpBi?=
 =?us-ascii?Q?GGIoY1aZ1G6i+L9vDQcxWi/Ii8j22b1SC6ofDx7FTbOYGbbMbMQa2vUJuOB7?=
 =?us-ascii?Q?cEJrJlH8cXsoESjbJdSHpccKMIf6HiIJC6EHcOjz8px9+inTCRwYKWlJTW08?=
 =?us-ascii?Q?xHQVgnUL3SdtynH+yXNc8N+e+CdIGbEk47Ez0f1LR56Iz4TYFAOjMo88isIZ?=
 =?us-ascii?Q?+koPQpjNI4Q/luNRTZEuej0bw+nCjd5hYKCF74lxnwfO5l79b3ShsSQ68U1R?=
 =?us-ascii?Q?5LA8PyBaqTZJpYSHXkdxjD7d9D/BgZKS+Y8zNzy6KpkBTO5yEPqAY/njs8Sk?=
 =?us-ascii?Q?OEuFtFmkBaeOl7ulCdXZc+y8Sl1xk19zllFZbXZq8kjDixtyHBodrjKUMzh/?=
 =?us-ascii?Q?UHbfheza4fcQt2cAWo514h+nZmAK1vqO0YdvX4hX+2yA2TlqhQ9zHypqUxjH?=
 =?us-ascii?Q?k+gd3hT4VyUfvn1vBZ7XK0ZKUvodPAF6QfagzKWjcFMvrIVcHhVY4M60HWpo?=
 =?us-ascii?Q?HacB004PRX75ujV7RrzSuTQYcB7oV0DTnWVJbS2vweIOPvCMHgtKSoZY/N0e?=
 =?us-ascii?Q?XCeuHmXqbXHGacp+YN36SJCFpS1d1WfAy6b11oxk1qX7XinyLg1evK8ECbf0?=
 =?us-ascii?Q?ysk+hKpBa1b4HxTJdj2Glr4JKfBW41kxlO7Hr2TA3xkUF9m+9NKHXr95/6xJ?=
 =?us-ascii?Q?Ckd2fRLL3QDfDwohIUZtE3He6mJlo9AlWBv2Rp3ejRmfg06V9DrohvopUbQs?=
 =?us-ascii?Q?i73uLCVljKhaAaPI2iLK0mWv5PhVk/zs6f8tsgmptN7aZ+FbT/rSgdk14+fb?=
 =?us-ascii?Q?doHWnGExvLaUlN+32UsUjPbn+iSEsSRWQcE2JrKyVvKFknB6nE6yyuaTaSRC?=
 =?us-ascii?Q?6i86OsdcI8mdcKc9f31g8mzc7nrwO9f7nZUguY8uSf2huK3ZwbBpAkWehRrq?=
 =?us-ascii?Q?/QGM6BK7fJAe9FDVoUD88d3z/hY2GXRtB81WYv/80HV/oADqgX1l9AhwRSjR?=
 =?us-ascii?Q?f/oeI/yLPRk/7bF3RX7hL+09WZX33HmYbp1NIj4M/nfAwtfa/h71flf8gF/C?=
 =?us-ascii?Q?5U4S/j83vIkK+LwebhkMEZlPMQhxQq/PRBa7pHta?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d934b360-d5a2-41d4-75ae-08dddba4fa05
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:39:37.3406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSTmaCNGAzvNnNicr7ejsCo5OuWznIjvItORs/ZtA9SQNNVki/8SN0+Ko+8boSOa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226

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
index a2f476e7419a..6df1ed0cef5c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4319,8 +4319,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		goto out;
 	}
 
-	pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx]\n",
-		 pid, vaddr_start, vaddr_end);
+	pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx], new_order: %u, in_folio_offset: %ld\n",
+		 pid, vaddr_start, vaddr_end, new_order, in_folio_offset);
 
 	mmap_read_lock(mm);
 	/*
@@ -4430,8 +4430,8 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
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


