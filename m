Return-Path: <linux-kselftest+bounces-36785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DCBAFDCE7
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 03:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6A21BC7EC6
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 01:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1FD1624DF;
	Wed,  9 Jul 2025 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jnjmwIwj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12674153BD9;
	Wed,  9 Jul 2025 01:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024506; cv=fail; b=rrbP3hF0p8tVkaT3Mx9EW/b7pzcgQKUodXGk3kbnKDIZs3VWf0wm8ABRaLskqWNoxoaEYcwCzo9X73DPKfm346s2Up495RxSKVZFFaFG1PLaLwVEr1mWIcot17NJ5P0K4a4/SJ6EYk9lnIAapVBJgmbtwqR7cPuCFe+Cib0jsTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024506; c=relaxed/simple;
	bh=bc6ae+JXfucVVVfMqMC4OeunCVz7IyZBbf9Oe7sZ9Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SyfZMM4Cl7sKzLD7eHWYIuZtqOz4l+tYH7KuRncNMkm98oW+xgaDotJeAPuTc9OHv7fixw6663dVWbp/+xZZG4h1DhdCIPZQ3rodPlGcsenuWVIVyoQdld/UAs+8Je8EqPKT27s38/gfpHvGx0ypUopyI8YxVRPpTk6fHvnM05c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jnjmwIwj; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T19nCQ51ysHkaScAgTN5KPv5CZje2PwN9QQbkz8BRHO0j/SVLDm7vO2IsGInyj06UyPwI+QNGbktDP28Ol7NSZpzyOFH8Muz4v/GrLOSXELYx0X1luipJH8oYoLLifZoDEPJo2aW33Hdry6e7v5FgypKcwkLOf4bTSc0mB9uLKaCSITYoNzaDNrCieal8V5+ZWs8dtKGaJcmSmfzRp7q/80D3g+tOVMgwQNZCJg4g2gdAsNP0t0YHzOh3J52NL/mYhdWqEKJ3lTmOFJgVAHCfyJsvw5opIeeMeVLE8xryVKpaM0klOcdMqcb2NGExsIXHEQdB4Weo2Pm56LPso96mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/E/MtqtIuNF/2MqebBZEVCC2LuljNwfx47Y65r6SSU=;
 b=acGGBZZZRCvp2vmd6lWeWDlm6CMnutb5n9vbgcVdftYs0vZ0OpgV4kOHYIvg/v68IRJJLx3Z5RBHA1qOEvfVf5/27tRwxY1NcBGbXJ34BBr9NyX0GUnSce/pgwULAmC6mTCxeAWyrmXHvSkeK9503pOUap+LOA96+z+8PB0QHb34STDOoHU9IYZHh+BNH7DUbqV1/VosNyylRQDnbveINj6gXiXmd8FQWYhSDDsDt+8cRfzTUHcgG9DCvtyMG1AeooGB5byYZheQlvKgJppMRGGdwObDspGF5uGcOin3xEytZINbldRdinkYizw+/XIhGkLyc2K5CiNbj/tUZ5bGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/E/MtqtIuNF/2MqebBZEVCC2LuljNwfx47Y65r6SSU=;
 b=jnjmwIwj20Mazy4Q63HHzWioqaqA6uSo0LAs2KGfcL7aEPkf6R49nKNxYAAl/IupycVRcceMoGmcWMJlF2YAWfxZrN12TUnS4oR0R9maguAAjQerYrDHvfIuyrYXDx0sL+IMUjlTjyWwUKdipmKBdGcX6Q0i7R3lD/v2BGaYTHIIQHqlw1QMxbtuULW1m3eBKoVWg7qmiLgbTKGpog1Ya1hxv6/SIjg/1fDhNmB3V6jKL9695Ubp1gaUTb+HRsTucoeXD4wExkUZ+Dbiu5X0bp8B5e2NvEHlEx951gECnJbnB6fj0ix0KB/g0rhmWsDv8no0rh8wEYWulayfk0zYtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Wed, 9 Jul 2025 01:28:22 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 01:28:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/mm: fix split_huge_page_test for folio_split() tests.
Date: Tue,  8 Jul 2025 21:27:59 -0400
Message-ID: <20250709012800.3225727-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: be1156bb-8a90-4876-e05a-08ddbe87e452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fAU6QmUMDfoy/qcD3FGpp5E9kQv5nXLNYUQmwOahdgQmUeMaGgCZRfP+/da2?=
 =?us-ascii?Q?SREIGc+RinKul/uQTWeouB9M9VTxqQgQkEw9w5c17UmP4p+nJIa2IcoPh+nS?=
 =?us-ascii?Q?Tk9LbqPXDaaugCXinePfoSv4vxxeuwfnKDkfA3jSCfPaZJLSwMIP4owsxsND?=
 =?us-ascii?Q?I9fM2QiuCJTntyfi5zlhOJb5oBSjdnyEA7rvnK6Dr7siaIAZXLuyhrF6HtF/?=
 =?us-ascii?Q?wcQHGLttqgrPuuHeyMFWN6EQhvL7mK+vQcaPlTJ1SctPZKAA941EDlr0Q/Ni?=
 =?us-ascii?Q?eyTkh63U/btczY0o7gjXqlaia7LT8LZnwX7yAhhetFuSM2+02Kmq8CEtgNH7?=
 =?us-ascii?Q?QI8lNDccHVYnG0EhVYFaoCBH04LqeO2igVcLYO1vkdc52BfvyKW4nq1ZIxu0?=
 =?us-ascii?Q?Q6PBuMNUEUDvxr8rpKzcfsz1MIbyWRbSwC3RyevXEeI4eoDuLdZnoSy9woXg?=
 =?us-ascii?Q?tZVmfqOiRBGkQDBgrVTMlExl/SPcPHLzHJnErj2Nx+pbG86+FB+R367lgy9V?=
 =?us-ascii?Q?HJjQp/U3ngpF/i7IZUR/KaI/gR54otSNbUi1aeB8nYlCTe/8MCX2wseznjha?=
 =?us-ascii?Q?X8C+KV0oFHUEtB6zHVbB4PqbGbyVyv0pGPeiwjSkcWf684qD9ooCZcnyDokw?=
 =?us-ascii?Q?KRMhO84hca+eLhuETz5bJraFvSzXQngW+etL9RbhWX0fXXmP1J+F5tVm4YRH?=
 =?us-ascii?Q?tQlBkxN7LErNAMMT9+N1Zjm7Yi8kIBlVhZdz4CP6TEGXK8I5az7sFvuPZLJt?=
 =?us-ascii?Q?RBnDkQiu/8z1pGB+ExNZ4+A40fk72DiMrfhpTwiODlI9s2eaheooAGN13N4/?=
 =?us-ascii?Q?hiYwQjTTa+ZsFS3ixv+MFMwBpCy3U2T0ipIPzIx1w6vgiTWcWEM29jKl1qen?=
 =?us-ascii?Q?ZFuERo7+IWdaK/I0EWdAkmC9lgHVWTE4Zh1Ev4FvzngYU92mIhU3wC3vILo9?=
 =?us-ascii?Q?Ue7X0YzObc8LR89A1pbQlIJpkifyf/Gw00usbMCWVYgIqwEFEMB5k2Vr9Imh?=
 =?us-ascii?Q?wfwnCJe4Q/hYH1IJM/LAudgPOsOtD8c3tDnd5b4AhvWq6qd7Dg8ezoOUT7Bf?=
 =?us-ascii?Q?PylBPOGlx3zVyWb7OAIaL51TLB+zS2NwhvJFbIkLU51DscilzICSctkgwI4U?=
 =?us-ascii?Q?Flhv9mugzGM14KWZGfTLWwUMjBTqM3n23t4d51gIoB8iwCmoer+6ep1krNoO?=
 =?us-ascii?Q?ge/0+A8OhOj8wWQeskkKFr4Av2ayspgA+WCvs1CfAnrLVVJr2gZNYl5CkxIb?=
 =?us-ascii?Q?1zcIA3z5w6XIygLmNJZmTiVoIw1qrTsQGjaRxYfns2L8ckuGIlepT0OoVk45?=
 =?us-ascii?Q?MDnC6Ywbtj83QhSvJqjTalh9x8BnnFOs1OuHgwn7M7Xr+S2OILMA/HiG7luN?=
 =?us-ascii?Q?i+R7ETvUdEa3udpPoGGm0FU6Fvzs+EoGA7ypXVfqEEkexArWXsTq3lX0qHAZ?=
 =?us-ascii?Q?2OBEP9CiI6w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eApW+tq2M6knhh23fspZKL4+nPtnRpW41dZ6DithSoHgCQ27jJUOZjfl2leR?=
 =?us-ascii?Q?GvEAeWvJ8ALFHr7h45rYioEmgk8GhHHJ9t0NnXM0iH60h0ZNMbgwuzXcrr9g?=
 =?us-ascii?Q?ojrGk6yIKk2hgBYoJ4T2QsZS1cILkCNjyDiG32ayBNo42xtqYX6+306uR+ya?=
 =?us-ascii?Q?ACVcC71QG11Y6mN13OeWgdcOST5ZrZnkpCyq9h06XTY9Um3SQGonak5OWDyR?=
 =?us-ascii?Q?oCNEbgVUc0EUz/YP5oBV60lEpNTeUb+gR+UfiKzjPs6rP7n93iTe3t9VOgKg?=
 =?us-ascii?Q?WaWsZg3usc4OimqRG9GXngz5eSGCZ+nhcry99otCwxi7/RVQSkV+ngfflv1J?=
 =?us-ascii?Q?nxbz3JM442v8agjt7M8LEul2aLgrVDfG5bRKQuXhThJqb+NT1fKz6eD4w2eO?=
 =?us-ascii?Q?F4M2uLyb4/sZ6PVvY2YgrIli3LHtaJnRh3eJDwgxkd1mDsi+NEOKV7PrlCr1?=
 =?us-ascii?Q?wuxi5mWKcD6QtmMq/XRmo7aRc/uT31bEt3P3WCexiSFylDVg/Ukkty4GfX0N?=
 =?us-ascii?Q?iVu904+C3G0pztHDS4jXmKW9K2z1OT0Ja5Fp9t499licMAFRSVa69s0Fy1iO?=
 =?us-ascii?Q?SgRVYWab5TbrCzp6ex1rIWKbT7UeduTWhNUmaL6w+cR0nuYWChKqRU6EGPFV?=
 =?us-ascii?Q?ArgMrQcCnwImQ/4/M4/EFfJLB8WR//xtn4vZ/2oGR/FEaNEFFvZRkAmA+URa?=
 =?us-ascii?Q?ujWyG/V+bb6bRiEHPx/v1TybsJSyOF0HkbzaR7aO5eCUeb5za54/Hu1vmIEv?=
 =?us-ascii?Q?wAK7pkd+kuQj6JUa8fAq7uDRv8HKr3tZ7Tj0iF2V6b3C8NtgE4XV42BPmdvq?=
 =?us-ascii?Q?GrgcECdHOxPXOv4mV4qh4APhrxnu5ydlBXKESHaSVaTxAIZzVljV5AAKbU/v?=
 =?us-ascii?Q?CnO0HplbsdePvBqXBU+Tc/AmSczRNPizIhmFJ7tkDSPdNZbsFQ8ruikFZ37f?=
 =?us-ascii?Q?a6cuKV0il/dNGuG7UL4IHBiqRZ1pvMFtX1peVulvA/tcmldejnwfVRC20y8t?=
 =?us-ascii?Q?w3CZ+0Vn1ge/AqRveDWNbFXc1Xw+7neXaRz9QIleLYsI3+WtDLowr1zRdSk/?=
 =?us-ascii?Q?vWFgBAsSnWEqB//4ATc41XMbkuklArtrpoB0OpUn6+PqGoWQQ/2gSuXRsbno?=
 =?us-ascii?Q?JfwNgb2JK8bZCHwFtcN3eWhkNQp+JGqJw/CQOP9kdU9iW2cnh9H1KlEEJMTr?=
 =?us-ascii?Q?vQtNgaoCA38Vqw79hRmxKU6xiJunpRLuJlq2jAhTB4FJCGdtRo1JE50VUGY2?=
 =?us-ascii?Q?zNqVcKS4OMvkJAiHUc7cJ3cHETM9XCQfjLD3etdnZEsq0pC4YfTgqJQgiNbb?=
 =?us-ascii?Q?QFcqrQ9kLTpSm8UJg/BFc9f3ex2byowGuBaftD2z6tdc8NmnP6MJTEAHPObF?=
 =?us-ascii?Q?uWhulPtkGS8wru3XcuxPrTolXGf+Mo2H7RXZFhKr41Rpcx8wHvM36ptmyfPZ?=
 =?us-ascii?Q?AQk9nVC8MiKVAyW29F8wayRDJ1uvjRwpzMkIlPpsTJA8U56dHzbvLnVUtIKO?=
 =?us-ascii?Q?ywDy5Vf6/gNJZ7Yst9GI/oRCl4LMlABvDZnwKpOfQz2upTAU5dihJvJdbQR/?=
 =?us-ascii?Q?y/Ny21lFa4LIJhmxwgvN8Ubf7OOgbSzxBrvJxkUf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1156bb-8a90-4876-e05a-08ddbe87e452
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 01:28:21.8006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wjUokKpDJf//nNEA3kK+E2sssy0dhNPyLg+igagUYEn2DPRk/Xtm0PT5DbL1AD5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072

PID_FMT does not have an offset field, so folio_split() tests are not
performed. Add PID_FMT_OFFSET with an offset field and use it to perform
folio_split() tests.

Fixes: 80a5c494c89f ("selftests/mm: add tests for folio_split(), buddy allocator like split")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 tools/testing/selftests/mm/split_huge_page_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index aa7400ed0e99..f0d9c035641d 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -31,6 +31,7 @@ uint64_t pmd_pagesize;
 #define INPUT_MAX 80
 
 #define PID_FMT "%d,0x%lx,0x%lx,%d"
+#define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
 #define PATH_FMT "%s,0x%lx,0x%lx,%d"
 
 #define PFN_MASK     ((1UL<<55)-1)
@@ -483,7 +484,7 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
 		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
 			      (uint64_t)addr + fd_size, order);
 	else
-		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
+		write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)addr,
 			      (uint64_t)addr + fd_size, order, offset);
 
 	for (i = 0; i < fd_size; i++)
-- 
2.47.2


