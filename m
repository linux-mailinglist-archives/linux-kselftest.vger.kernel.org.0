Return-Path: <linux-kselftest+bounces-38786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C87DEB22CA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 18:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C0C7A72CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618D92F290D;
	Tue, 12 Aug 2025 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bwBC5uY3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA892F28FF;
	Tue, 12 Aug 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014134; cv=fail; b=J/mnXzDpFiefSLAZRjbiOmBAjAs4YTABAHhLwPzkcehsD37f3PWbziXOLjk+91BUzv610pfQjPDYASQUpyErfa2/xHFmmCnsz0DXRc1CVBr+ALIDLMOe1FYAUViJ/VOHswfbHwOG0GIEHUdHapA05wkGTQvu2GE5jouAtZ5hWQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014134; c=relaxed/simple;
	bh=4O1oV5hG3ToRsxKdShlHQOapNdt/Z5F4/YQFZwVDeow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UmSQKbBkG7GX8IviFxXxLb+0vVr3AOQZPbB+Fnml6IPMxo1PZVfVdrZYA2oxmucs0M5+oI8ur2ewOIPqLkTQfmPBaerZDIL6ZW6+YubfcErhEZlK2waRNNImW2qFwmGHGvQ5eglUPpt0rBUtgUDZBKCpFdFsmJVWkZWJ5uXcEec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bwBC5uY3; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5e2V6C56vLz5OFiVODuqtOgGg58NQv878DAUsLpenvE6vtVkkHSAi6pUcX/Qbv6BKRCAeP1xP+jMxS0r+ON5pyFkfe97XE69G92ixjsS1WU/KlDrUJcowJj9UOzABMFV9O3+b0Q0wI8VSR4N4V1FyBvteBq3PnWWmYh0Aolm9k01WSBnrXkr+DzOTO/aaWVaU6VslIBZR4B7F2ZqUJci6aWIcDwMlkaaIplrK75LBtsbAUNMEW2gKmQ+EdL6rVnKNEaLk2qg6Aj936l/wHsjVw2PjPRgVjzENMU2acZR/GSB1xjPtkU0jd7BStkHLJGCUTuosbdci4WETehXpt1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49ZSpr/I8MWI8XUZKPEYSzl/XhTN6mjiL7yiL7QZf9k=;
 b=AIT+7CJWBxPCaJKowP/JzLG+6FBBlrZa1DE5Cfif50Z/nVG68tFi4aLg/KrsRxMKjkRWgLOCXF5KuhbfDcowmt61BZixBqYyLthTgvH5kTc7nplEfnKze/BwyhMyD4kZqPWijJ6bEzYtXBBmwlEox1PF4u4DsE2s0OgtxRkyPG/LxvO0DGsHgpOaNNhagVJ6UalnWS1SzwcEvoJFtbvUiRrbjJIsbFz2ki8SNoD0ZzaGdDW6oOC67Nk+Bn5u88y8tRz84UJEZYTlttjYhuZFMtmPCdtMgk37akligqbUmFZ4/BeW2iQRKQDAcsYcV/aCME08L7kgrnztfCiKWCqHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49ZSpr/I8MWI8XUZKPEYSzl/XhTN6mjiL7yiL7QZf9k=;
 b=bwBC5uY3i1QJMfxhTs+/FM8wHu7gRgrWyyppynrSDbV2YnHQFq0fyqOKiXABFpc81EQce7+twFnpFB5dEjc1xM0oU44VQI7ZKXcYIpDeCLQJjJDm9gIyhLxK7Ilz6FhmQM5EwdazdspHGyaCPMdBQaocmKBGtGsjH0X/u65uEWPzv0R/L7uCyWa72Ipp0mYl13Z0K+SdD4LPxlZ7r+uvNd7/8177pNmpZ1n7qRGNydAQWiMjdWMkGQQ0xcHFHgEBL+IVqG0NG8h2PfUSQQpgWyGlAZhmJE7vltFb98uXRI4M9lljUUyc3V6yDDpATzG35e6B4ir8SBnp8T05wpfKTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Tue, 12 Aug 2025 15:55:30 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Tue, 12 Aug 2025
 15:55:30 +0000
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
Subject: [PATCH v3 1/4] mm/huge_memory: add new_order and offset to split_huge_pages*() pr_debug.
Date: Tue, 12 Aug 2025 11:55:09 -0400
Message-ID: <20250812155512.926011-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250812155512.926011-1-ziy@nvidia.com>
References: <20250812155512.926011-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:408:fc::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe31b83-7335-4cee-7839-08ddd9b8a97b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kmzlg0au49/cyx3puc0nOSMMpi0wo0VVsX7e+sseniQD3OaoT8QeerQogcoF?=
 =?us-ascii?Q?QgT7UW3fmgRIJNV3LW4C7qCgU74fpFToXX6zopzsrBQSzYr0HRbuUZhY+H7y?=
 =?us-ascii?Q?4W44rwlV54H3PLuFDUWHU1Qi45jGJ6T68X8l8EDBBpDkeVjzgjhw1Pza6L0j?=
 =?us-ascii?Q?j/CVOxp2GWM23KWmmSpeJlptWD90UI+5+Oxr2kWvLaO2DWcCv3LDNUFa8KP9?=
 =?us-ascii?Q?/sy365P/n2s8qwdee2YQujVd6zt/+Z1jD0jdpaKwukZtBLoF9zb+q268uvi3?=
 =?us-ascii?Q?XIalTvYBdNOHNFzORW8/90jkjAoEoO78Kctn257LDCpzSdEIO9Nq0c6JloGL?=
 =?us-ascii?Q?IOLb9VbdIPEeY9VLE/ba07lBlANYIWVnpeGTtDXop4NoKnIsjyoCu1eRndIZ?=
 =?us-ascii?Q?1h7oCgkKDQuRqadiA53FwoLv3Bn1OoZA5cdqB8tWgijCeGl5LAZhKwpogRtG?=
 =?us-ascii?Q?EWDClJSdi4jU1I/BA9XuocMdUqVL2PA8DrNeTYw9gG+JacBYhjwWFd+hDopf?=
 =?us-ascii?Q?Lr3kHHD2s0kc6n/aBUH9nxphml24w8L7QSE6IlULoZudfiol0xhtoDLle+WJ?=
 =?us-ascii?Q?y52JoLvi991c55qSDrztVVQTUNew/0y2uMP2+9yCcnOuFb7cZd+IbHcuhiCi?=
 =?us-ascii?Q?uQVPy/wo/xUHyGYloMf+YF+k5mDDM2kAm17hKL8jVlHTcBC8oYn+KQbR/azR?=
 =?us-ascii?Q?m6VWIqbmsz5OokucooIk1QwCwWRJYGD2QwjwssMl3AsNcoSS0TPNKxkiXZJR?=
 =?us-ascii?Q?cMIxdFOrXLYwZsAxtkN3oDLO5Ga+CzV8U0mdUC9NVgj8WWxboWkilCeVtJS3?=
 =?us-ascii?Q?0akeJPv07xaNG+dJ1fNv9DnYRiFisAVosZ7K2O8NyrB1GzpucZaNOhnWzPNQ?=
 =?us-ascii?Q?h/rtuctIssBC/ClWqyiKCQ7e4yKVasq3RVh+bdN7srexSc/3Wf9AzKy2hm/v?=
 =?us-ascii?Q?8q6MISpaS1fuAST3BP9B/1p0vH2ulIIJMu6vy/guwWIYFYobVS86ScphoEjI?=
 =?us-ascii?Q?0jMKFoPE0uGjF+WpaYOmjotZaR5FAKnk8Zw1xPKlY4Dr8x/u8J7ZmQBAXU/P?=
 =?us-ascii?Q?DuhJHgaA95cVMBjj0S3+nK+PTveLl0ydE6SFLcj0x8gyFyo+F/mF6w2DvUwJ?=
 =?us-ascii?Q?R4T2mHDBTpxuuGdBKzpyEsV93+iHrIQl2B1M13oUdN+nhJYugPor+2HRe0bn?=
 =?us-ascii?Q?oApDtW/8B+8nQYIM8pvMTjwWGdDYQkbwaLJhb4ciiWdDdTAGhA1WewcUgoJr?=
 =?us-ascii?Q?/ViL3mEJXAw5VgxIG5mIevifY6j63Y1Hk/LkJ69PT953hmKoabY9QdkII9CM?=
 =?us-ascii?Q?yN9L6ibaVdYmQ1Z0M5DNPQ4Re2d9jPt7mBKMdZc8mvHPsdf/AtPbsxRlxMcX?=
 =?us-ascii?Q?5JfsqcWkaZya80ZNXVrsD2V+0sbdtRI7BZksf1V3hz8CpQsuDMLpGbK7sv7H?=
 =?us-ascii?Q?OGXc13Hewik=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZbDAxyMivNU3x8ixFjtYgtKCSeR1KuH4UdzRX2UJjimub87TNhIUDMbXuPU3?=
 =?us-ascii?Q?7xnSsu8VGozXvrf85rxDJ8O7+zFIwMSvM9qzQjQn1GWDbT68bC+zRCDV0+b5?=
 =?us-ascii?Q?J0c1IlsB/eaFZh72/Mu8vxb1vZIiUuSAbTsjRseONr8iBVzTDHFnCl6YV+Py?=
 =?us-ascii?Q?+kcQN4YMxoWk5+My9ZKxKv4Gt/AASU8/9OSiyvnmkDnBU/HJljwxb16jAS53?=
 =?us-ascii?Q?qhTaP+VYxXifLCbWeBuep2R0WGCpvIC7oEPs88zEwtFrA67zM8IWD5xuv1EZ?=
 =?us-ascii?Q?X+ije46mSMCs0gNGxTMnQjyKK29V+puixrV787Y8jzX6dHAH0tbiWD17URgx?=
 =?us-ascii?Q?ANzz1/4Tm7Elb1Lu3vWCXRUCTXO+cB7qPMXl+/qXBeGBRIm3j4qm4jJFHYhm?=
 =?us-ascii?Q?jiKEak3c4ikPslRystf1lIEAP5195Gze2q2VPXqkdGQuAkg7oXwHDNaJtrVO?=
 =?us-ascii?Q?q5Brx00l5VWN53Jpqu8476awvl22UhY39GpjqbI2JTgGtz/4N906u6sXkLtE?=
 =?us-ascii?Q?EvLH3Tapn86LKuwZ/scQc70VO90u2eulDr1A4jD7lZmd8uj+j+hr/UW2dGOq?=
 =?us-ascii?Q?0xgg+XakJskIUCDbF+zU9DxJobt1ai6rq75g773y50u2I60XA1VRW4QmHLET?=
 =?us-ascii?Q?1357rb886Z0rwqy6S08TETDezDy6vP6+7iC7IKmWQeKz9Z9rXJKc9XjYNLA0?=
 =?us-ascii?Q?DV6JFfTa/Sjn1Qq5GoeuXzHw3WanF+I4t1X9WdaQhLwKg7ZI2Bpwz99Rfosn?=
 =?us-ascii?Q?GjourSK8vu7gmFFwH/5AP32lCRCVHeZnwsCk2Fq0Sk2YrJ7KsWCaq9vowS29?=
 =?us-ascii?Q?OEKuW8IL1Z+CrVIJ7UqxjkyMk9T277PddLPpt14xTB9fuyu0dxim1HyZevo2?=
 =?us-ascii?Q?UAB2isAmikGC45exZU1mbeKTokUO8CnrpfSLNBkQ3Z+bJBXKAk1GTd8kH1Vb?=
 =?us-ascii?Q?0BlMQ20vIIP/PXrhW3+bQ4qQdAz8JwHybdxNRIBgRekT+2xIrsqPYZ4RKcCu?=
 =?us-ascii?Q?SOfKwOM0E1H+011jvO8GMFjEhFsSQ8rHwsJj+3zrMBg92edjUdwIzHL6keyp?=
 =?us-ascii?Q?afen/kSN5U+CONpJXnpbaiEBNGfZuhc9fIEvNZAHvVeJgnEUu8lyg+mWCQly?=
 =?us-ascii?Q?2x+oeA6D+NvH+vCif0DbiOFAhzfsWOshciNOFo/72Nh1SqMnUhYoUYoYvoIy?=
 =?us-ascii?Q?jkGR2sfLLJqWNAIFLPjk1zsAJ6MCek2IwXi06LJ+N7GzJ9tAGKpu8SsdYaT+?=
 =?us-ascii?Q?EQMbQSjqqcmHt8aTkVa3umPIJszrQP0OGKMEW4aEGo4IRtw1yzA9THOiJ5NS?=
 =?us-ascii?Q?f/hNUXU6n0mfCXrWYDZPL0JA9uCnwvHWYinXIcV2hH38RcOHqHJ9H1Q3+rpg?=
 =?us-ascii?Q?g+dSytX8ZGanY5E0YKgjvd/sRc3NDicf4b7q7TCdeXwYnPYTWMY0v70rW+GU?=
 =?us-ascii?Q?orp6I4CEc/GAr/yHZZLaohB7VQYabEEZRj1P3Ps1UM/koP3mRUEJJhSMifyF?=
 =?us-ascii?Q?XpqljWqBqd57wZnAZA0qibvjgLKu5+liup9Gb+Zk0JMj++RFzEURb7hky0Fa?=
 =?us-ascii?Q?z5Efi4G+5nCrRUPfkCj3kK5//+nO+xuJEg7C8+IC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe31b83-7335-4cee-7839-08ddd9b8a97b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:55:29.9683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bja5+Hk1Vpuh8WYQxQiBme48nCcI7bUiqe3SHq3w8+PFbhoBEWDcoIMwl2/QZ9AH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441

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
index b8bb078a1a34..22dc727d1d27 100644
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
2.47.2


