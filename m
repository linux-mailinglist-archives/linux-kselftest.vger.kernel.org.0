Return-Path: <linux-kselftest+bounces-39241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 623FCB2B0C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 20:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D9D3ACFBE
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 18:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D116274676;
	Mon, 18 Aug 2025 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dGUeUph4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B367C2741B5;
	Mon, 18 Aug 2025 18:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542800; cv=fail; b=TTye65ATRtB5D+Zndc3CUkkgUMGGIT0oK2n79D9ReSnF6GtNyd7rATSMakpLx6tj3PP0J8KYXWqk/saUJKVXaJ2xwcrS162bry8VWvyCV599G01H+SLUNvd0mgH4iZs+Pz8QkTLM+zQvKbxG+gt2vxR/sGPMp13U31ZbgREvcnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542800; c=relaxed/simple;
	bh=OSrmX1dFWyVPsQ7U63PDz9DbpgA9CjM50MNsyy1sj7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JyZsTeX1E/VHmrpJAksAofOs80o4BC4ZNcsaJ96SWhI5SvzsY1wF4xKbup5kwLYH+eWfUBkU2Y/wfkMATOV18NN2okym+v8VFE2BGLGg+EzzmTTnUi0FZpO8HwluSsThECEhcQOV5PwerNek+it2Ua7QRwtPoy3H+aEWhLcC1jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dGUeUph4; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBULLZ3RZzuxGLlWhYbZLjB7I37AMshqeS2hQ2R2o0Sz47b4qoarYfB9n6GLMF3eU4owJotlAuRsu5KTicy5FHikHXW5A7oePAGCTDmTQUJSn0Meq4eBxr9UuURTyKaT9ge8PqCo9hs4erzWgbs2Z+oRl0phWwA4ig8HVmLbY0HYkqqixnUdahDiDsLNz8j4g9k2iDwRKmSYefhBRFSpLAPXlyr2QhIh0Q805Va+i2eKoepdgvtKjvs9WoCICsB3PoPddvuR24vqJQYfYLRjQVAMd5C4HkOz56ytpMnXnSzvRhuCihof4zwQh47jl1ymUGTfsFUeXXIaWPE2Z+H6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyBDzZHJMj7ZNuMYJqlbI4vqpC1avENAnu58C0shrvY=;
 b=yTctsHwaUJu9+agd5zX0dLmYAynV7ZEgCtWSb6Lh/pFVU0sKisKeguQvYWqZli+VNCtodAqAaMBjP2DJQdOL3W0X2TxjZtmodGRfre37vmHMniN+Kwuzftdn9+JBgv4ncmpU4QwBGXB1QPpi9Bde0R9vQTHJ9XlbWe7puyhj9+O+hVG4R6g5IlOT+/KDa6/t5InTWke2sd0sXxY6K7xZTTYV2vD3OW4MLyhZuVeBt1l2mmHE5Fo0CiNmd0VYz6Wn+/XMBZ9Q6vyOvuAjn8azc42eBC5mDDOm9tbTP2+3p2dj1QTZm+iRiidstlW0bM0bHjI/glux3tw2Y/rL1iB7UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyBDzZHJMj7ZNuMYJqlbI4vqpC1avENAnu58C0shrvY=;
 b=dGUeUph4kg8ukGOoTUrQvPnvdGZa0dahk58cI+qPHuIhuzHMOQbbOV5BzfvoiLKH9byB7esdmcwoJxsbRZISin29gjGJ6HlLIMisEvLfXmba+zJU48hxgpvZN7d+3LEB7MGVc03gadogWiKFEqysSmuybokmW+DpDM8rGfoZX6HJ97ehZiArr02qkBLMrPHtSBV3zwcTysv/D3iohtAjDqg3TP5FJpJPv22Gk3Rs6LeiMoi8G0telKc87h5GqW/JcIBMiKreu+hnbaih0bwCGqPBygWHdTfaYsYsWl7KF1JE1+WqvmBcBieEb9iVYgbhtDe+6AcAdbYa0V4HQVBetA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 18:46:33 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Mon, 18 Aug 2025
 18:46:33 +0000
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
Subject: [PATCH v5 4/5] selftests/mm: add check_after_split_folio_orders() helper.
Date: Mon, 18 Aug 2025 14:46:21 -0400
Message-ID: <20250818184622.1521620-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818184622.1521620-1-ziy@nvidia.com>
References: <20250818184622.1521620-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:408:e8::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: 9871179f-bcd3-4732-3646-08ddde878dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ViLN/wysaVomLq2YZyPSHAubObNze1XxUU8reAeorTSvUmPfQDaTiiwgk3UL?=
 =?us-ascii?Q?J2phttpHPS1fOFRLop3NiajRmBgmOweeOsu1qNo1+OedJtSHhf1xV6vowNu+?=
 =?us-ascii?Q?voCcvFGcUOsGahtm06pBnYgQPtHZSK1o1qZi6FOKzPxf96kcv3R+P9HT2Z1E?=
 =?us-ascii?Q?doZC8rFrFQmpfH1Q/IUS3l9ElrA4no/QMZQ34+QujLaDW+0mW5RSFWb6gNIO?=
 =?us-ascii?Q?QfW5KDWW5oQWi+/JE7niHE8ugTJJmP7msihK4BPo+HE5baIBUoOtu08in8ar?=
 =?us-ascii?Q?mzkSBX/ATYihjJB7GA2Aa4HpQjhwXo049EfuTuo+hs8rye5i1T2+ul6irb5p?=
 =?us-ascii?Q?kxlEd5tZIohuXtKlyClVIZKND310J44mmZx/mPgvT6aMm1p/8HZzcCjur11q?=
 =?us-ascii?Q?MHBfJRSxUdG49u43gwf1CemvXQvSKakSbo33p9OTQ3Gg/6QM5SwJC+rBKxqR?=
 =?us-ascii?Q?NYdkI9Qa9gIZRRZd1nhR7/rgY793T9O1Zoqpy0hl7tHRjKVY2Eq5z1ipCGzW?=
 =?us-ascii?Q?+KeOxcKqWpoUTiZq2A/BVyU4FSPo167UZY2cBZ1Sf416q9R+jtxZ+8jBvki5?=
 =?us-ascii?Q?PPfbm3VcbYOUtX5tAMhRjD6EJuOQGPWYiGghv8mhchMoyiidj0gZlwS64UGn?=
 =?us-ascii?Q?QXAC/GcjkWGYOeHEp2XUAtnDJdt0tM02OWJc/+do4aYE4NXfnXpTcY8p97FG?=
 =?us-ascii?Q?JnYcgGytYGMH7wLh3paZoa3lFN/LiMYn6FkDhwCQ5UdiAJMUo0/9/YCiqweH?=
 =?us-ascii?Q?UqoPX7LuZb2cYZ5RUOzI+8OZ8Wz+0TUzXJT/cVKo7DA19OwxvVAzRcmz43gN?=
 =?us-ascii?Q?L/m45TWJ075+O5/6F/hbklu9OyrQNy4CWE3HmnVY7G19AeEu+o60h/DWZ7wh?=
 =?us-ascii?Q?tvY1GJ1SLfAIlrEWjb2upDfhB20MBTBcpuDsjns5YNvUc0fFr60ZncXnySWy?=
 =?us-ascii?Q?dlH1yR7+86VFaD6GbxiKI8sqtPJ3y4VBjpa3OoWlUh1rye2zOWmT/Dw69p7/?=
 =?us-ascii?Q?AsgyQX630rWOQAZmL0B8ooDfFyzAZzCS9Y1db9lFDoWhsjE5k08MUjiKlqx9?=
 =?us-ascii?Q?htBA1twaEjEv13rmjlDFMBTWCeKIYSFvg3f4oi5s3V6VGO3DU1plXk5H5RRT?=
 =?us-ascii?Q?CfxNVWIpxBYk1ynJmzYX1tjj+ka7/cxtnoJj0GSMwiQXEASvRY6sXOK8qV/T?=
 =?us-ascii?Q?RINd0FT4lKy41ikF3Q0Ny0hzrfqZswIoCnkriRvfUyP4JT0qoXciqMgFD/po?=
 =?us-ascii?Q?EnDMUI5byOoeeEk50UY+aTy0U58rjCamWQ5iwInBqvqNvLkEVmYN+7/11ovS?=
 =?us-ascii?Q?GvOaZnbrbGrCERKqz14aBU7k9ddZeTDpBpbQV2GXNQZGkcaYMgkk707aGSPb?=
 =?us-ascii?Q?VZxU7psFwba9ankkzsurnD1UiX1oS55NJ9OYPba8OxjbbpFVUSq0439y2CyG?=
 =?us-ascii?Q?2t3leZJaX4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JICedGh0i0c+sur2xIIpd4LVJ6A/gZXgCFdhY/jEHBXOffLWwVguSNyHCH5d?=
 =?us-ascii?Q?Pynkdlh1ruaW99tilCJrBGYr26hx/1MOxkXmXDgnNLUOfalpmh0mCg3d6Z+P?=
 =?us-ascii?Q?/OoJwkpoakdjE/7xAEq8MOCRzi/vn0hIxXTubpkDmMinaesMAHw2NVn3p4kP?=
 =?us-ascii?Q?0DRGAr3Or2AKqtU0dm1Gb150JCanXjG/4I0hlGnJwrYwJyK+5blRVczPs/MN?=
 =?us-ascii?Q?kEwSj9IvSDGo0gz0aUXZWhM3MmFng/ashim+SauQtvaZyjT124PxihYtFoMm?=
 =?us-ascii?Q?L/t7hWhnrsI7vJSDY1+c+eB+DIr4qox9PvzvKVLyYmr+FAwnJwyG9vXpKEmh?=
 =?us-ascii?Q?cDEPU1xga+l2TWDDgO7fB/xnQRm/EnEr6BauGnxHlCC+gXo/qvCyz4FKsxzY?=
 =?us-ascii?Q?aOLAWXftSA7Gw//B1Q7jsqH5XnMoB+8AbIBKvvB51ytJB27gXjfX1GzlC0Cd?=
 =?us-ascii?Q?JgwgE54SkQFtbvrsU48qPnswtOSsRCFDoCSmIAzgiIRV8Jms3sy+0v+v6OMA?=
 =?us-ascii?Q?v2OjW8aSdAUAiQUhBRFbzhyK0HRz2atYxsOvMc05DrYbA7OoS7ZMFkeCbzfJ?=
 =?us-ascii?Q?k+8DyIfHpnitThwK+ofyjTBhiUVjsZoybS98eEL6c+zuxH0kF7W2M4Locxyz?=
 =?us-ascii?Q?tMCgKub/9KSFxCkklp7rI8hxGw6wCtmpdyv8cPm5b9/ftSHRriXduHCUG1TK?=
 =?us-ascii?Q?lP9nOLSfxiD3IxhT9CJDbPAj1IhKcWUY45dcReg8Afzd9zWV5mXSthYAmuaF?=
 =?us-ascii?Q?NQem2srrFqbJFZAom0kmKVjPmKvE/7J3J9yVcTtFkCo1XSlGWMohGhHeC1e2?=
 =?us-ascii?Q?F5vS+QAx2MHYBiPqlGe/RW3WuU5gre8uGiaDVitnrWnEKtY+qVQ330mSBINR?=
 =?us-ascii?Q?2peQQzZcyJGGfMWTjTB07CeTk5GKPFbkhXW4ySOEZFmQ1yNUwY5apij01sHG?=
 =?us-ascii?Q?gUAg2OZ2LTK41McuNO8v9hRcR4Ox8t4q9nUAk8sBibJnY1WBcEj4CwPwlBTG?=
 =?us-ascii?Q?eomww4t2/hP5hg9qX4a4a7RXBAPmalB0uoV11G5v5yRwZyRTZ1nZwOTbsbPS?=
 =?us-ascii?Q?apDDuaq0oEwicZKw5e4CQRtrH2WsnTRf3cI36362fCJolTYttU12HBAW7pYU?=
 =?us-ascii?Q?EVcN+82jX1MNfkeYwk6WhIXmKkcW2LSW4MBO8SMtpQnbpVy744RuT85zHduI?=
 =?us-ascii?Q?FhhazjBdpy2k5y6RCKn/IaU3XXLpjgHsR0CFjI8LXIJ7+a5oOjrjRSj8+cER?=
 =?us-ascii?Q?oW7E4BbjXVvJdjedee/E4Q87GX/JF7gmX64lkQHAoiH058dDfYtEUkLcBb/Y?=
 =?us-ascii?Q?jBQ6pIRWT5YpovY0cWA1nX+5/PnmoIulJ1hHANCSRCGfXDg8JN/kIzNAkByw?=
 =?us-ascii?Q?+rDdcYZZhOyKl5dSgOoYmVB3+dUqJkfcz+1r1nDx07V6O3uYk78AU+sEwMhK?=
 =?us-ascii?Q?AJ8Ta/3zoVNhQJRcHxh/RLfbJJn3jVeea8K17ehgkIHOFm1v05edX16yqiXY?=
 =?us-ascii?Q?cZrndsLo1XcCXpe5CuGXtYjUpDl6VB0nAS9HcV9qczG6SVW4X0MLu0PlT+I4?=
 =?us-ascii?Q?ZV11XKHMTQfgx+IkcpfSfSvk8Kwq7mIwKp2oc+kN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9871179f-bcd3-4732-3646-08ddde878dca
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:46:33.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2YGVF67Dyy0tGa1Du6OdknkSuJIaDa4Wp47sNhhJKK1FBQ752nosku+RJEiumRq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342

The helper gathers a folio order statistics of folios within a virtual
address range and checks it against a given order list. It aims to provide
a more precise folio order check instead of just checking the existence of
PMD folios.

The helper will be used the upcoming commit.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       | 152 ++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 56d1eaf9a860..e24df02420ad 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -97,6 +97,158 @@ static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
 	return false;
 }
 
+static int vaddr_pageflags_get(char *vaddr, int pagemap_fd, int kpageflags_fd,
+		uint64_t *flags)
+{
+	unsigned long pfn;
+
+	pfn = pagemap_get_pfn(pagemap_fd, vaddr);
+
+	/* non-present PFN */
+	if (pfn == -1UL)
+		return 1;
+
+	if (pageflags_get(pfn, kpageflags_fd, flags))
+		return -1;
+
+	return 0;
+}
+
+/*
+ * gather_after_split_folio_orders - scan through [vaddr_start, len) and record
+ * folio orders
+ *
+ * @vaddr_start: start vaddr
+ * @len: range length
+ * @pagemap_fd: file descriptor to /proc/<pid>/pagemap
+ * @kpageflags_fd: file descriptor to /proc/kpageflags
+ * @orders: output folio order array
+ * @nr_orders: folio order array size
+ *
+ * gather_after_split_folio_orders() scan through [vaddr_start, len) and check
+ * all folios within the range and record their orders. All order-0 pages will
+ * be recorded. Non-present vaddr is skipped.
+ *
+ * NOTE: the function is used to check folio orders after a split is performed,
+ * so it assumes [vaddr_start, len) fully maps to after-split folios within that
+ * range.
+ *
+ * Return: 0 - no error, -1 - unhandled cases
+ */
+static int gather_after_split_folio_orders(char *vaddr_start, size_t len,
+		int pagemap_fd, int kpageflags_fd, int orders[], int nr_orders)
+{
+	uint64_t page_flags = 0;
+	int cur_order = -1;
+	char *vaddr;
+
+	if (pagemap_fd == -1 || kpageflags_fd == -1)
+		return -1;
+	if (!orders)
+		return -1;
+	if (nr_orders <= 0)
+		return -1;
+
+	for (vaddr = vaddr_start; vaddr < vaddr_start + len;) {
+		char *next_folio_vaddr;
+		int status;
+
+		status = vaddr_pageflags_get(vaddr, pagemap_fd, kpageflags_fd,
+					&page_flags);
+		if (status < 0)
+			return -1;
+
+		/* skip non present vaddr */
+		if (status == 1) {
+			vaddr += psize();
+			continue;
+		}
+
+		/* all order-0 pages with possible false postive (non folio) */
+		if (!(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
+			orders[0]++;
+			vaddr += psize();
+			continue;
+		}
+
+		/* skip non thp compound pages */
+		if (!(page_flags & KPF_THP)) {
+			vaddr += psize();
+			continue;
+		}
+
+		/* vpn points to part of a THP at this point */
+		if (page_flags & KPF_COMPOUND_HEAD)
+			cur_order = 1;
+		else {
+			vaddr += psize();
+			continue;
+		}
+
+		next_folio_vaddr = vaddr + (1UL << (cur_order + pshift()));
+
+		if (next_folio_vaddr >= vaddr_start + len)
+			break;
+
+		while ((status = vaddr_pageflags_get(next_folio_vaddr,
+						     pagemap_fd, kpageflags_fd,
+						     &page_flags)) >= 0) {
+			/*
+			 * non present vaddr, next compound head page, or
+			 * order-0 page
+			 */
+			if (status == 1 ||
+			    (page_flags & KPF_COMPOUND_HEAD) ||
+			    !(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
+				if (cur_order < nr_orders) {
+					orders[cur_order]++;
+					cur_order = -1;
+					vaddr = next_folio_vaddr;
+				}
+				break;
+			}
+
+			cur_order++;
+			next_folio_vaddr = vaddr + (1UL << (cur_order + pshift()));
+		}
+
+		if (status < 0)
+			return status;
+	}
+	if (cur_order > 0 && cur_order < nr_orders)
+		orders[cur_order]++;
+	return 0;
+}
+
+static int check_after_split_folio_orders(char *vaddr_start, size_t len,
+		int pagemap_fd, int kpageflags_fd, int orders[], int nr_orders)
+{
+	int *vaddr_orders;
+	int status;
+	int i;
+
+	vaddr_orders = (int *)malloc(sizeof(int) * nr_orders);
+
+	if (!vaddr_orders)
+		ksft_exit_fail_msg("Cannot allocate memory for vaddr_orders");
+
+	memset(vaddr_orders, 0, sizeof(int) * nr_orders);
+	status = gather_after_split_folio_orders(vaddr_start, len, pagemap_fd,
+				     kpageflags_fd, vaddr_orders, nr_orders);
+	if (status)
+		ksft_exit_fail_msg("gather folio info failed\n");
+
+	for (i = 0; i < nr_orders; i++)
+		if (vaddr_orders[i] != orders[i]) {
+			ksft_print_msg("order %d: expected: %d got %d\n", i,
+				       orders[i], vaddr_orders[i]);
+			status = -1;
+		}
+
+	free(vaddr_orders);
+	return status;
+}
+
 static void write_file(const char *path, const char *buf, size_t buflen)
 {
 	int fd;
-- 
2.50.1


