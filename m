Return-Path: <linux-kselftest+bounces-27667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5F2A46CF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 22:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 721097A341E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36FC261365;
	Wed, 26 Feb 2025 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dri2vtaM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F2425E47E;
	Wed, 26 Feb 2025 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603671; cv=fail; b=EphjD1ExtSrlpnLc391d6T9xB0s0cckkCGvbaxjiPFV+q6Ju5VtosRddJl4EAsSyJwHndgG9UqRA1juGaEznz2AERKtNu8ipHXc3njFovkkgCQNnysFFZ0MgI269uQTUrVidtHFsbTQdrVyzkaT1bFVzFMjtNbu9cuXPTwfkeu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603671; c=relaxed/simple;
	bh=jYs708DdXKQyS5N94usQ+368uwc0DMTFKuT7/7FErrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ky+qplwN7iVcckELK93gY8Xl39OFcxwxAH2/1f2OOT0xdpH9hOdTHDr9OaPK3bRRAEx9Ky3/EApSNi0Q4OcedzFImQiNvBCznuVIs+8kvp8UIaRY77q2/IhOnDqPUcD4h994/sl0mGpIZuds/G/lop53TGSOs3DLqzHFZtCt1fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dri2vtaM; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHMRMj6fv+XwcMYmD99mtkDsbbXgaa+Y9QBQSfC13cIbft2HFPGm9IgEPv0zxByT9G21udlXilhSAE39k5zNnAXrUeywrFT0pbp+gPNDMePoFUEjKfgUPawqbbmHN1lHXXO7/gGl7Cb+lgl38W038zZ2jyhCw/h4bEBqC7LIbsAyHSPj8qigU/Ijdy+mQRH63NBGyLpVPnPdFE4lnnQgXemFr92nvhSpF+D3Nxt+deT197YK0M2inIxEuSU+lOqz+itfuAq2068AQxQevspJf3N1L6Uo3QQKWGvaDW6aupqHhQ3W6i9D3jamN/WGmVKC+s4R5HCEmj1m9bcwsQElqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EU/UsANrLIuJHJQZyVRl3KO3Nn3lqvBBpTugjGoZsIE=;
 b=hbNJXQhxV0eEYeIWYb9dkRXDWZXe+3zP8u6DTWWwz1PzZXZj+kB4ZILgylz8FNThxts5IjkgmABvgQDr4CKDXIxu62V6ivgAlmPVx5CXxdcFTo3aot2Cc215ztZfj8pQeBtjn1xnAcn6RYPchbiY/wwVl734vJ0gvgOqYYzSfr+xjcHwtmRFPR8f9Glzw6PhAUSfAhH+5F7G12pgK4CXM6P3qr9CNT0+gZtM7cznYnpOcp6XR/6qSmLXOpq6LvQvhYVyIrtvEfKSMXhohHxRMKcRIZ0BVDZStLYFs8greO40aRcgu47SehZuWlnwfA4VIGJeu3fMZh0lAfFmou3gDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU/UsANrLIuJHJQZyVRl3KO3Nn3lqvBBpTugjGoZsIE=;
 b=Dri2vtaMqQFpkpkwRQM53wwGIO7Q8b6vNz00BXUq0RHDgZWR+yeSgEIhcwg3ypxLn7OO9U5GRV6yNerUFYWf7CGS+PANvUdVsFAdDGaA2psksCbzztbzSvWNEcSFJj3w5KX8z293MpOP6sSnqE0zO2s43qF+EiWRh32DJ/9FLNfIYmE0isSIuqRi0+LKmlOPuxNBeh7NQBQxPSYx7vCdzrU3smLhluPrCP7ZKwsr88n2sG+WjNYeedel47Q/aBGjsy+pvHX3s190yMa8KqV9jTTvSRehqMx06A7w4PAtORAbBy8jTV3co3PhiLn4+T8SnI0PCpK5x9J81H2msNOPVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Wed, 26 Feb 2025 21:00:51 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 21:00:51 +0000
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
Subject: [PATCH v9 8/8] selftests/mm: add tests for folio_split(), buddy allocator like split
Date: Wed, 26 Feb 2025 16:00:31 -0500
Message-ID: <20250226210032.2044041-9-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226210032.2044041-1-ziy@nvidia.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:208:335::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d133c9-ab0c-4319-0fef-08dd56a8a6c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uxLZKk3xw987+UahwoYTGY3Ogc/nlvSqNNiy8V3gXtlusjnsQYg0G34ZfKCb?=
 =?us-ascii?Q?BadBp4Vn9fwDVLjlNpDip+5So+X7K/A5Yv/tpYZPn5HDvqlGhU9BJ66rnLKB?=
 =?us-ascii?Q?63BsNULH6P4RYHRmUGR2UINL5LvLUSsyKMFMwwA4CECcchDsf1tKhUrOXU/F?=
 =?us-ascii?Q?B8BszzeZeMXrMrP402lw8t6pUnw8TekpJXKwgGFwrEw0OLHIfMKNRbfqoE/Y?=
 =?us-ascii?Q?4ix+zOrFcVx88LV5yz5k8Q2B02cWvrGf8hBLOGP+R4vMkSR+GsRAHE5Tl/GY?=
 =?us-ascii?Q?GAABTcBa+fQV18UciwBTB1SilDEL0lO5tf10iRz3RUQxU1fzJW6wHLy0i/EF?=
 =?us-ascii?Q?TGk22eaJhswN4C+hQtiTssDNVqD25PX3gwKDllk+NVFMzz2b4hsNIWzvoUc8?=
 =?us-ascii?Q?1NvmdB7y/DPGtr5H9IlY+QlMVEmliRuyAakfYHVNSuE6rKCfv6w/Hlpk+4BJ?=
 =?us-ascii?Q?CFumx99Wrm/z7JwE+bum0IgI6+lVXmLu8ZQoUkWHX8lAWAMq6RPa3S/0VNlm?=
 =?us-ascii?Q?/MuRtActJcmU9P3BQm2dTf9F8d+m+SNQM4ndNei5iY1RmR0dMR4EMkj0fpiU?=
 =?us-ascii?Q?Qe8XvRt9cpVmLfdBHhM1aZhsAx1ss3tn7rOzXHXMOO+Ctv8EU1JnRqc6nQl8?=
 =?us-ascii?Q?63Z9XUnJFgTI0UXU2SM0a+0PnyqKZCWUBrmTK2F5XC5VY9ZSbBMNdVcQygSQ?=
 =?us-ascii?Q?E3lYaaMkcb3R40RxhkPSKZlL0UZLGaEz/pnfxjpidD6IE4SvrvUqolmDE3n0?=
 =?us-ascii?Q?q7mVfUaxN7ymTJRigu+2AYFw8SBc3UdhfN0dHaPW2UAlaAIvmToBu47fARHZ?=
 =?us-ascii?Q?X2DJ+qclVOek3wrsx/bDxJbJwCj3sGPFCFXsbQ6R6X0wiVGNo4QzJ2lkPoCV?=
 =?us-ascii?Q?OmO6+d/+koMRBxrRTcrWKKHzbpowHjCtl7Xiy/16yHgbMvZllsK1zNXeZyRG?=
 =?us-ascii?Q?LRG619gT4Mr7/tOoovJ6D4r0BENmhme8CSN5MU7YNH7RG6pHw+ldHbm3AsTd?=
 =?us-ascii?Q?hclxmk3Gw7AAMXd8+DlYVd/CooR7v6SvpbGdTvV/j192spAWPER84ejbQoUE?=
 =?us-ascii?Q?C0+4AGFCbKLMHSq8zs5UkoYZywlgBH5olPhIF2EPAagP4eKkZ0WrLKAXYQe8?=
 =?us-ascii?Q?7lP98MAqdjO5R0EmX7jZehRZtMXrfPm7HR6yL1bCqmJsWt1br4kSASH3tg8D?=
 =?us-ascii?Q?EpHC8WRAMJGwPRn3zCXPXJWiVjDFd6qW+fZaArrLlU6vkdK69mi9n+z9ziiJ?=
 =?us-ascii?Q?hXV5uV7FyTUCY9Ze87v/Qv9GfPekDCooPxwkR4jxUadAxN37ZxZM+NqhHGAL?=
 =?us-ascii?Q?KI6rtWrtmQ5aExJ5H1hDkJRN88ltSABhz3Eh8OnUDXgbwNwc/7OPTjsGf3mT?=
 =?us-ascii?Q?48uh1cLGiRPnv7Ypv48dCPTGKvG/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XwA2/eB9R8XlCQ+hOURhDqMeoAaHO49mn3ljPgyPHrvCGa6grlEKFfmVm/nH?=
 =?us-ascii?Q?cs6bRg9rBX6vD7oZk2mwAmK7XtfVDyx+k3FPVykUNJd1n1euBuYwSF3cHQFt?=
 =?us-ascii?Q?qIMxVH6u++5JJbYgp4BUL6153/7lf2QHocPzD97+tCmcHw9Vby+Hnnm3m18b?=
 =?us-ascii?Q?4cUMc+ABoJIle+8X/yicGp3OQ6bs6F/7yLXx1FmIF9QknO4fiVWYPSwElZSb?=
 =?us-ascii?Q?V9TFLIoWAOOw0+MGTfRbO8V6eqdybYTG4W16ewAmYDEKmY+2dxSE5CDOruAE?=
 =?us-ascii?Q?j2oLZsM6bjfsDwg6+bqcMFCeE02oR/NgiE6y34123CUyl8Xr6cYsX4xf/bj/?=
 =?us-ascii?Q?pJAlLaeagyEhefZlQWrMjk5tfEwjxtF3gDwnClEUd+vH8yqyWuckADA3kp78?=
 =?us-ascii?Q?focG4/0wXrSCf99gznjYzDYwrRKfcDCyEUnPnX/RGp4YsC0gJGYXJOtMM4IR?=
 =?us-ascii?Q?PPFaUfYXDa6j1bQ+ItgrOR7m8dKNhC+Uh6fY05oCjRMT9iBpS9NgALwFKe2g?=
 =?us-ascii?Q?KCf+YeywOWYktCDhjbWY9swDj4YTzmxQp6bSFvA+iLvPaRs/uYLaThCH6tUe?=
 =?us-ascii?Q?C84VeNOEuTDnU+Lf3jF2wnlnQqFuvf5atKmC6OAtSyVAwvCGV2o1nf2UrpkP?=
 =?us-ascii?Q?0xiNIrXH4FaKQ/bfLLfX0RhWBT9cZoLZLbZ4/yguXDCEDjLeT6eUtkKld0dX?=
 =?us-ascii?Q?LA4uy9aMPxfvpKyH25LxCKY/vRSrCzvrPPQxjL2FjEtqhIE9hul74xKqb3+l?=
 =?us-ascii?Q?m+iCFfudpL493AVbtMB7voXArS4HM4FfQ13c6BPv+4agl9vKUHuaeIzmWCWA?=
 =?us-ascii?Q?EfLFrI52DGpO+Mi8IWxE4+62YT/Od9ZaIJu669lr1Atz2gi6hozfXSts1hW8?=
 =?us-ascii?Q?15RCjw2ugJxngAv64sR+Zaxk4w2PFCkp/PgnYmdJ69l9fZgxSSTgKH0agWAs?=
 =?us-ascii?Q?GculYZEHWu4FC6+yvWln2zFAXHWWUlPGlG3pqfRxhea1/lj3D62cx8siQzhj?=
 =?us-ascii?Q?wj9vA/KOAD7N4GPnQTPVv4ZpjyUIdl2QQFT5p6ljX3T8rWrTeoQMPm7C5Dj1?=
 =?us-ascii?Q?4ru3PICZa3sblx+9hqunqu55hnpxQnhnxQ375DABk3/3ataHlQwnMdrnTVNC?=
 =?us-ascii?Q?G56WrbjEZK7AlwBlOkmcY3qYJScFpzGkpOQwjS4jC2+/M9VuC1ivzojO9hAH?=
 =?us-ascii?Q?5PDR876yJ0Wqwvnbbw73j5CaUTwSCb+zdNaE7hCV64fErCw/y0N980Yjx+7J?=
 =?us-ascii?Q?I5kBM0raEmGXNNy09uSMoeLEqi/8XecRa/+2bRVi5rzIDPLSJoiXTSi6Qr7k?=
 =?us-ascii?Q?wqkdFhi93hNr8rMcYbXNMgQzwZzoOgCszHCGW6i/lO1cAmzlGh+aHqU4ViMo?=
 =?us-ascii?Q?1zcyjC6UxUw1zjO1Q0SIOL8I2mtABk2m7xlvF+G8oiuSiCnQcKBKxNB1XLHU?=
 =?us-ascii?Q?38hMV3QlTLnInVu6vJRHCGOhgUnkVkhxjByHUmB7gxrZzCkiDBqVdMYOoVPa?=
 =?us-ascii?Q?7Nt7StOeZKMQp3sf1wfyu7YVNAEzigeUmq9laXLKzwvPnvh9OVPWnkB/Hqqz?=
 =?us-ascii?Q?TAOSdd3dRX3M++Hrw3J1VR2+1drnWwql/uLnWCc2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d133c9-ab0c-4319-0fef-08dd56a8a6c8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:00:51.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rr+tuTkW9gT62yXZLQRNMtXbzyQ9tj5v1TbKbyvzCxkqk2unq6WAFX2bd+hVgs9H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614

It splits page cache folios to orders from 0 to 8 at different in-folio
offset.

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
 .../selftests/mm/split_huge_page_test.c       | 34 +++++++++++++++----
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index e0304046b1a0..719c5e2a6624 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -14,6 +14,7 @@
 #include <fcntl.h>
 #include <sys/mman.h>
 #include <sys/mount.h>
+#include <sys/param.h>
 #include <malloc.h>
 #include <stdbool.h>
 #include <time.h>
@@ -456,7 +457,8 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
 	return -1;
 }
 
-void split_thp_in_pagecache_to_order(size_t fd_size, int order, const char *fs_loc)
+void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
+		int order, int offset)
 {
 	int fd;
 	char *addr;
@@ -474,7 +476,12 @@ void split_thp_in_pagecache_to_order(size_t fd_size, int order, const char *fs_l
 		return;
 	err = 0;
 
-	write_debugfs(PID_FMT, getpid(), (uint64_t)addr, (uint64_t)addr + fd_size, order);
+	if (offset == -1)
+		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
+			      (uint64_t)addr + fd_size, order);
+	else
+		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
+			      (uint64_t)addr + fd_size, order, offset);
 
 	for (i = 0; i < fd_size; i++)
 		if (*(addr + i) != (char)i) {
@@ -493,9 +500,15 @@ void split_thp_in_pagecache_to_order(size_t fd_size, int order, const char *fs_l
 	munmap(addr, fd_size);
 	close(fd);
 	unlink(testfile);
-	if (err)
-		ksft_exit_fail_msg("Split PMD-mapped pagecache folio to order %d failed\n", order);
-	ksft_test_result_pass("Split PMD-mapped pagecache folio to order %d passed\n", order);
+	if (offset == -1) {
+		if (err)
+			ksft_exit_fail_msg("Split PMD-mapped pagecache folio to order %d failed\n", order);
+		ksft_test_result_pass("Split PMD-mapped pagecache folio to order %d passed\n", order);
+	} else {
+		if (err)
+			ksft_exit_fail_msg("Split PMD-mapped pagecache folio to order %d at in-folio offset %d failed\n", order, offset);
+		ksft_test_result_pass("Split PMD-mapped pagecache folio to order %d at in-folio offset %d passed\n", order, offset);
+	}
 }
 
 int main(int argc, char **argv)
@@ -506,6 +519,7 @@ int main(int argc, char **argv)
 	char fs_loc_template[] = "/tmp/thp_fs_XXXXXX";
 	const char *fs_loc;
 	bool created_tmp;
+	int offset;
 
 	ksft_print_header();
 
@@ -517,7 +531,7 @@ int main(int argc, char **argv)
 	if (argc > 1)
 		optional_xfs_path = argv[1];
 
-	ksft_set_plan(1+8+1+9+9);
+	ksft_set_plan(1+8+1+9+9+8*4+2);
 
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
@@ -540,7 +554,13 @@ int main(int argc, char **argv)
 	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
 			&fs_loc);
 	for (i = 8; i >= 0; i--)
-		split_thp_in_pagecache_to_order(fd_size, i, fs_loc);
+		split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, -1);
+
+	for (i = 0; i < 9; i++)
+		for (offset = 0;
+		     offset < pmd_pagesize / pagesize;
+		     offset += MAX(pmd_pagesize / pagesize / 4, 1 << i))
+			split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, offset);
 	cleanup_thp_fs(fs_loc, created_tmp);
 
 	ksft_finished();
-- 
2.47.2


