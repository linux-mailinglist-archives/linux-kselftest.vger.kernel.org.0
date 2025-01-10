Return-Path: <linux-kselftest+bounces-24275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8BDA09ED7
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 00:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 035397A4437
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 23:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07B822259D;
	Fri, 10 Jan 2025 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hygXwz/O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093EE222565;
	Fri, 10 Jan 2025 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736553036; cv=fail; b=b3GA9qSq1MGIgKRGR8xxKoQEwCc2a6nduqlg1ytFx1Wyib+MRMtUXBiBQgX3s9TY6pITd3TDuF0wFlvCcwTzoJMxmz/N4PJLQ9M1qZYM1HZncDROr4vIGAlJ9pm5wqRwcsOsfYsQ4HGqvqdN/8vK3PKqqL2HdKxcP6RPyp6naaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736553036; c=relaxed/simple;
	bh=esWLMzERUib3vTOMCE//NFV5elf0NJgsiaysRMBT/78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F5K3X+yG95Sd/IFFY6K1v3Pw8UI0SLMbz+2zDIxT7YL7WYEoYFBcW4KQUkRZf4jymrIDmM/SLbyRUXEEvXSMTRAMU9/X5/KNL52gVlqUMsRZQISHThd/ilmceh+X6pPqjX5RtrZIRAT5OjIb6WFjoilecU8Xq+zPNWqzks12Q38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hygXwz/O; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nx2Q5Goik3BEWnXlqLYtOTHFVsqmpW2DSN/T6mlU0yG5b/gGvQmU+D4qMCnc2V6e8kwN7Hw1Jv5gZyd9SBLc7azPeE/d0+h2WM9CPLJE+bS9+h/WvV5UudhUoxdPRenRkiQV34mPSOs1HqxRHfKUkNEi3dKzfUoBcEHN4MZk4EAvRwf5guKXtzJ5oQ+DLgQeB0cWBTQJtqpgv/1ltrsPMJFUqg9FnTMr2p7d0S6lclZ6/ld+ldZqV5BPJtkQOVDY249YCXoc9lYcnAXjXhzUqUCDM6hWPDG4hSoA5Qia1KLHSQvUWzdNGabQZiRR1omHVo5+41IZGrbIfLLUFIbpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfFaXkc7nFaNyA3q+5TZEaKsKDeeXOUpsxgXCw4KiV4=;
 b=F6O5xgnkMnIji933GqL9+cGi1rlbvK5MtMQzmxhBq4qhY8n9B8ir7lROiwTTLGLKEw/aUOcp/7KEePtXU3nwZWrCTNM4ccEx1Vhr14gDPrIlyh/LvDRPQDKTLPGo5163bBm4IcHfiQbfa5dpBIFDnjw7FV2klURyalFk0GHEUfrHrOb+SOLBtVeUANdX6RgyGZ/AApBnV70Pe+AE4TMwmMEskpIlNIyME65uyseGKTuo5dYJSlk8z/iV+DGk97h/lnt/zsBInXphDXM+wRf9dZelVGWaksJMP8sUE3oOQulAlC87KnC6j0R8skqVUiso/nwi5NX8Hbyn0TEGar+AIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfFaXkc7nFaNyA3q+5TZEaKsKDeeXOUpsxgXCw4KiV4=;
 b=hygXwz/OAqsTLP44JJgFSOTYmBkkJGFzs/SjJIu56WxzIAreY73yEkqYrNmh01fxmcSdg6rqAixewxt/DZ6qvl2b2ncoz/bF95XYXWI1xrIqe1Mm1VjRaTYy44TWahyQjODXh9PCMBUHtsV9ScmwBXLiIhK1cyGu9kGuOEpZWN364WqW5C8UIXkeVjrd8dOUcZqUSl7RtH3dV3fIadwUt4svmp1RDnQtX4HoI5aHw52h422oIKZ9ZsUD9AQG86RtNpMwT/ra83A+SMR/C8ekYCbb1aYjjyMPDLwzD3OJ2qE0X0GJH9GyyECRRvQy6tZZhVvDktccNe4vO5c5gmbs0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7753.namprd12.prod.outlook.com (2603:10b6:930:93::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.11; Fri, 10 Jan 2025 23:50:32 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 23:50:32 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Alexander Zhu <alexlzhu@fb.com>,
	Usama Arif <usamaarif642@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 2/2] selftests/mm: add tests for splitting pmd THPs to all lower orders.
Date: Fri, 10 Jan 2025 18:50:28 -0500
Message-ID: <20250110235028.96824-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110235028.96824-1-ziy@nvidia.com>
References: <20250110235028.96824-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:208:23c::30) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db38b0e-e2ab-4b96-3aa9-08dd31d191ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7G5As/19yQQx4Jlupbqo7GvOqqa5r/XIBW/VYuP//+fYvYgLy3tvQHh0N+x?=
 =?us-ascii?Q?RuD29SRFMgY+5Ueqc/hsa1rTJlAxjWOQ5UrPur3CIUbdlebphbcQKlebEAXB?=
 =?us-ascii?Q?qT3iWNikf4RjZDf6NFMWr46Kv64pxUFaj4aA0gqAvgzHUz/jycJZPkWQAUwY?=
 =?us-ascii?Q?BS4od1lyPnybd4c6Mgal6sOT4nbc77d14G1A6KsK9pYYpbeUY8+X059Kn1fU?=
 =?us-ascii?Q?4WcWUkQ6st1SMwi+1YGi5AwKQqcY55LgvClWsW3yQ0y6xb+uQA2bl/KrZ/Gz?=
 =?us-ascii?Q?mFfYep0x3XCkgOErHZwYJF1V40kLMFOS0VC5awXu4tRgyAFfRQ7CxULaWipA?=
 =?us-ascii?Q?19jlEX2cl5wZEKRchyAawszRuNML2Dsnb1hBWUIA/v7b1PG551TVSA9Acbjl?=
 =?us-ascii?Q?zGnrHKQqCH/9FqoOLtgJm36TnCZ72w0srLijkfWqICif38Lm/05HNgp33BjG?=
 =?us-ascii?Q?F16NKGOtutXMUc8xvrR28M1yB8h3A7LqYvfTUhAOE2lDmHJc1BTsSJia2TPd?=
 =?us-ascii?Q?4LbbBOBG6Qn1R77bwFfD0WHuUrVIr76jlg57dgjZJYvEtMsFUpDiOJkuLPj1?=
 =?us-ascii?Q?21gq62f/pw2q4bFnchBJCH1LfUZsbgATxahkPz43tjRbcB6z/QRtAGL5g5QG?=
 =?us-ascii?Q?26ADgJgQ5RCa/E5ZYsG9zoalvxabSf3OfYVXcWJq1wx7nzvD+xDYXvsyCiww?=
 =?us-ascii?Q?LeIJ3BIUEIVTTNchVgwRuUKiJ2mIPiYxcTxj9+0Fhq4HXfdMhk3n/LVZp3zf?=
 =?us-ascii?Q?d9mZfkRcKmEadt8K677vqqX7JtEIXlMOyxKhjZahC+8xN5S4J/r8ZlbzedVp?=
 =?us-ascii?Q?nK/gZEF4tKuPEthxwXWqyffBSplNe5gPQnvDJleRFjEBXm3TGeLEPCiE40xC?=
 =?us-ascii?Q?z+nCsR0YOPZP1vGtJVZ8xEtXnKPFVMD5mXeB2cCBtFpSOkY3wC06VNZYw0JP?=
 =?us-ascii?Q?ygYVXh6qOuhbgxssb/X8xT5mzyOZTwV0t2cC4buvXGFyV3sCtYBgNyk8kwEl?=
 =?us-ascii?Q?meN66aNb9Hgj/vgvRtVJscOx59qqiVsJOQV3ow87AGlgMP2Xlc10r1lSx0rw?=
 =?us-ascii?Q?C1r7sdNCUZ9ZRMeGA8096u1DYQ0nRRQ5twwZ3AUBNbNQE521DlkmYLWZ6c0M?=
 =?us-ascii?Q?NFl1vCam9jwc1ZrKi4tTFt894IREQOPDLl8ik3KrA2MeQ1ysYsTdtFoRkFeV?=
 =?us-ascii?Q?PzDTmUArOT03spLzjgF1rQc0aAWHW7rvjIlcyn2mdaqmawY5bG4r14OSvHKX?=
 =?us-ascii?Q?y7TTSUVB+xnlVOW9/F6Na8EmD5p4dHbZDVmKOZnewn/a8jMrP6Na6+C0sMhe?=
 =?us-ascii?Q?uJlqlNKvT7dfLQTf468frS9GqBELxNrmr+NxLH6fHmLrwEnFxbCWOrIeGMU4?=
 =?us-ascii?Q?xwZikAIUMSt8MSZ8jH2R8iu811qT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RVIoo6lzg+HEYNvtXhC/1MAgPpY01SdPpwvVpK/aByw9JHB7da37PxwaX4RT?=
 =?us-ascii?Q?koail5e1pBqNuyDjKe9d7UkD555WmSzYI1T70/fKOT1bOK3X3IcoNRXXhqeb?=
 =?us-ascii?Q?MQfB9Kj1xPItU6NJnor/mUO4Oygjd2eGQo6SeqGjsuOcW+eDOr4m1wYmCVPh?=
 =?us-ascii?Q?DoU7M2XhmkHGqC9C2ebNDcDS+Tuo0bjI4zPAI9q9yKpnrCQ4Dy/rKKqeyjcL?=
 =?us-ascii?Q?CL6YI2o2tfFox4JJTEot41B/1FawEJMGrwTvmIDLZHjukKQUecUefEheVmCM?=
 =?us-ascii?Q?LUAeu05oegcVZNMF2vqKo8l4+OX6AOvIU+Fict8W0wZNrjVHORLeDe44q9jh?=
 =?us-ascii?Q?PDN6fL2cJsQuPjo6P0UypX4qsfMKgFVidS+GW6DGyoi25A/IED6cSsliL6np?=
 =?us-ascii?Q?6SR9JY0/BViv0ikihzESMg6OAXqoiJtZtttxiK+yNfxu0Nb4z15zLqrVksc+?=
 =?us-ascii?Q?sn9syCkViVYSObyhDeHTrU3GvFbZW68vwDNmlKp+3vnafFCf2m8E4cFX5x4g?=
 =?us-ascii?Q?crj830UblVI+oU+CaLsoSn9G8dY59x0lfCa406ulY9bome9y9x4fTQ9wdOwr?=
 =?us-ascii?Q?Ci1ImqKq6bBngCkL6aqYaDdoBvvi1ttvgs0vyXm41WtqUUPzDtkxKIKtSfg+?=
 =?us-ascii?Q?N2AVvmWAeDjfGw+M8ANTLuExNg2bb2cD6Pk7cYITYJCFSb7MQtcgCoArf+Y7?=
 =?us-ascii?Q?TmPopWGsImWFjk5DT1hMQJkX9M1P58eIThqZObSDQjIIesPSqmi/hnHfASKC?=
 =?us-ascii?Q?1ermiYVMWKlMoLneHqGf7g6Pm5Jr6rz7T9dK4KVJql6Wa30rZal68pSbkaal?=
 =?us-ascii?Q?bS6O2/6BnG5v1H51cvJsa3cdFNW4MD87w7IpnhJy6nNvwtynlbEXxtHAnJ0R?=
 =?us-ascii?Q?/vg0/vsd1QX8zlD40vZP+wJMs+6ux/pjN+JMPSyQQIiFG3DyYzUqHrQATQjZ?=
 =?us-ascii?Q?YDhimA/boUafQ+punscHGlBX1wM48cbFNFEbapWE++iEMOQnVLoURIsuXXKr?=
 =?us-ascii?Q?8PE3TMd73W9B7kQ9QI3JKMZ1ftTVaZ/YEkVbTkO3kmKvJiqG7EaDBHcyrKbi?=
 =?us-ascii?Q?Om3Zv1dUUl717fMGki4gGFgkaZIkqnpV+QcBlvQdlqGjPROMuJoDcx632V5g?=
 =?us-ascii?Q?x6UNx5Y3x7reVl1nk1S6AMiWTD4GZXVyZiSeEQM5DZoacmXBjEsddbDWq/88?=
 =?us-ascii?Q?S/jH5pTjUHh9gO5VV+Po1bdYd7c8nQtGltgBR0RY0Rm7REWCbSHSCS0R7DHz?=
 =?us-ascii?Q?nHVLBg93nF47AWqG8rh0sCp/zlMi5rUZoAENoKK0FGz+K+i+WifSpJPHxkKQ?=
 =?us-ascii?Q?fKyzfjTEUPhSRPk1rlQ/fzEMIlXY+SOoqLhwyNecDHzCNYA5pJmt7ePPissF?=
 =?us-ascii?Q?YMVLd4QxQOVrdcWx5THaZ15g0TOh27ESJ9WrbXxt0TodUijo74b/JvFTm9QB?=
 =?us-ascii?Q?mrVKJsMw0OAvfVYJ7A8qimyLCG0pU+YNen8JJ/1D7TqfGdcM6d+0zAbSKAxG?=
 =?us-ascii?Q?g8cvmTMLkb/BQE2LRC0nVOBVE6uuyVw3UPcYofzKmWqjBHO8VW9UuOTIqljX?=
 =?us-ascii?Q?IoNOGkgj4MeosPzR//b0gzo3jIeC5rHGdqjv1mFz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db38b0e-e2ab-4b96-3aa9-08dd31d191ba
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 23:50:32.0258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIHW6+YpHhLSMBv/foLt/VMWSbZ4KqJPx6h+4FY8M2YqcWVHMzZTvpJb1R+ycFED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7753

Kernel already supports splitting a folio to any lower order. Test it.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 tools/testing/selftests/mm/split_huge_page_test.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 128004308233..3d3bc40a268b 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -144,7 +144,7 @@ void split_pmd_zero_pages(void)
 	free(one_page);
 }
 
-void split_pmd_thp(void)
+void split_pmd_thp_to_order(int order)
 {
 	char *one_page;
 	size_t len = 4 * pmd_pagesize;
@@ -164,7 +164,7 @@ void split_pmd_thp(void)
 
 	/* split all THPs */
 	write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
-		(uint64_t)one_page + len, 0);
+		(uint64_t)one_page + len, order);
 
 	for (i = 0; i < len; i++)
 		if (one_page[i] != (char)i)
@@ -174,7 +174,7 @@ void split_pmd_thp(void)
 	if (!check_huge_anon(one_page, 0, pmd_pagesize))
 		ksft_exit_fail_msg("Still AnonHugePages not split\n");
 
-	ksft_test_result_pass("Split huge pages successful\n");
+	ksft_test_result_pass("Split huge pages to order %d successful\n", order);
 	free(one_page);
 }
 
@@ -481,7 +481,7 @@ int main(int argc, char **argv)
 	if (argc > 1)
 		optional_xfs_path = argv[1];
 
-	ksft_set_plan(4+9);
+	ksft_set_plan(1+9+2+9);
 
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
@@ -492,7 +492,10 @@ int main(int argc, char **argv)
 	fd_size = 2 * pmd_pagesize;
 
 	split_pmd_zero_pages();
-	split_pmd_thp();
+
+	for (i = 0; i < 9; i++)
+		split_pmd_thp_to_order(i);
+
 	split_pte_mapped_thp();
 	split_file_backed_thp();
 
-- 
2.45.2


