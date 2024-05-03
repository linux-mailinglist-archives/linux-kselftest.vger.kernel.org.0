Return-Path: <linux-kselftest+bounces-9308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B790F8BA564
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 04:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65638282F00
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 02:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63BF14F62;
	Fri,  3 May 2024 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oQnakwLw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14F57CBF;
	Fri,  3 May 2024 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714703536; cv=fail; b=LGvwXJ9JHkTO72ST20EJi7jH7t+KhaVknmgI9GvIgbeD2IsgYlSferCi3EMplZW27p/khBdBPvBTTte0ULdAXVVBvbv5G1jQ1xD0z5XeOLJpari0Cgix0NiYVJJ1CE6BxylxwTHI2iIb6oCW7j1H86h0DBZ8oJLJsI4VksLN0y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714703536; c=relaxed/simple;
	bh=fqqE/VkxJ8SzEXx4uQcG7Ye+u4OlMWicHrS6ifpJwGU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e45u+ghiKWriw5x4YpDWKbgfnHrVtTp9TNAtmi9oqfIqf7C8aBodIXMenaCpMaGpzypH39d59+sNdPNLKwVR/LJkO3q/Jre+SDb7AZffoSlHpp+aY8ewxvCBoX9HL2sexK32ota23J/M3O54xhC8gBtXxsCv9ghLLWPfC2Fbxgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oQnakwLw; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ey3VpzU/UCg/zrfrw4SXRZ/It+DW7FzGPuBL6ZGvGO65qDsfZA2n1QPFSgYfoM90b5yWZ68z5BbOhrQqUl1c1K4gFhFAaGPAFMocdvLgaaqdnyVD5SoiwRnrQ77DXCmL7cvHrc+WaQt2lYsqsKswzcFVAoduo6LZQZdknbPxmaopE8r6s24s+si4QKw4vUbyqrh4vd77t1Pdq0m0fYy4CjQtJMk7QuDLKDS+NwE0V3abYYeqLvKzfssiiZl16HTvzIe3Bp5gmKphNt6xp1OpcyrLGmothU18gNZ4+8f3ny2y8SVQg/0kAx73UdcZlaKUMjXxAbk+T/5TezTxm0vtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soo+zhRBM6cBLzZ+I5T/E2J3L+AnLMNAHJwZzQXiK90=;
 b=HVnBLzbjnEySR/ETy49g6VPJ5ROaNHYHI+balxZhIfVVfvYL3Zbw5virrXFCZ2jnoCn1SqJZwhb+/il95YjT4w7iS1J8Ih+YLCqucz99Ak0M+8eZSm+dY1vACS6a9GlUTjg8hOiatRUqUJYWv8knjB/oZPjXtMbrFQ3XGjrrUNRdJYhSjr5VTVQKm44TK8Q99pY3Ed0AgW2BQGnjZKEYXtvV0c+11jqDN+dUsjd0swimmDEdvWbm7yskuJlDVYKuiou6b8eTrni3X8c2vVeKk2sN6BUC1Y4Dzn7kQa8ROUt4hiJ149rEpYYJSXpB8g+YEjDAbbO6sIK2K2VEWbSyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soo+zhRBM6cBLzZ+I5T/E2J3L+AnLMNAHJwZzQXiK90=;
 b=oQnakwLwlavvLpyeLkn3twYtZRAO6w8qiPkhvdWuHWzLGn1w2QuEBEUlUnU8HcxBh5jc+wfrx0AanMTIplthxRUyC2GKNe3Irm7lJYFfvLeiIFnvhU7eiKKCSU/QW89tCHKeoTIq1WFudktGrubP5mYj72IlS+r7by1hpwNAY36OaWxl5rMcnrmEJfsAeFoWdGTEC3MDOub/WV6GZ9wCfRcveU9koqaqYN7X38vQiu0sInoQcMHH+aJ/HgpJuNxhalL7wctcwB+qsdJubfWavYwj1ZUoq+3/ferL1osz+EMFHiSD+aUVpxvTAvnI3UiHdwtSj2H01sdsFHvoE0plNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 02:32:11 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 02:32:11 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] selftests/resctrl: fix clang build warnings related to abs(), labs() calls
Date: Thu,  2 May 2024 19:32:09 -0700
Message-ID: <20240503023209.80787-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c2ee7e-b568-4e30-35ab-08dc6b193c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8onFU7QxvmG4rLVbdFBXk6Ya11jY335ahaT0iASsOEe1jsQVvVs7Djje5tRc?=
 =?us-ascii?Q?H5Y8Y9j+tWm3OpWuATNHIRunghapWLX2tqRmkPv/HxyjA9BiANU8GHLb/b9n?=
 =?us-ascii?Q?FP7LRGw8nqVJae6Mw5AIfWsAHcALzUW4Npuk274kWWZpd1q3dpmj/wEU3nzC?=
 =?us-ascii?Q?MzjO3L/+wW6pS5Lx/m22c4U04oS85eIZ65bPtWciDSLRPSstzX7faMaoKQcB?=
 =?us-ascii?Q?QgsBKIpPd91C222fD8ePSgJcC97e99rufNCslNlk89lbc7fDW8gdqvb557tT?=
 =?us-ascii?Q?UaFtAAuBbdhSrMfqVzlFIgzntlkOxvfVsL7whhd44irt7y6l6OCwPxSndfKm?=
 =?us-ascii?Q?C+dO/5TAsBulZBvTITR5tClNeNYmmQc99IjOU5OzwFCEvC9yjPBjhZtHiNk5?=
 =?us-ascii?Q?PBVIVRqqZlNmhVuCY7c6Zbf9ju9+c+3aVPcULShngZ57zcERXY25/WnOVWX2?=
 =?us-ascii?Q?uKA8quGYi97an2lSay3b5+QWWgW5RY3OyKBcn/TnpJJleZ8wGMyRr7lkAsY9?=
 =?us-ascii?Q?8UpJ2H3NnAlkEm7c+ThURoB1XBQxyYglFJ9j0YdR29Zo0qwTP7F1wC8ZpNcK?=
 =?us-ascii?Q?/Nn61avWSlIgd1G7YwJiKzHKm1YX98VcllHpc93k7kGX6RgeiSOjnI8VDDAz?=
 =?us-ascii?Q?whmVPjlOSiXGRzgmTcgWLkgNtB3qbqtLnpCwc5a7RQlyjhkfuXFGZK6gr/tb?=
 =?us-ascii?Q?3vdtzuejun5ii3JDF7Gj767pk2aOVH4lbOhT6McOZTRirtz6XSNYkKdGzsK+?=
 =?us-ascii?Q?7CxUAXfpj0gplqypkAWIys50FODpk3c/WgOGZoxHowaTexcO9D+4dd1EmlGt?=
 =?us-ascii?Q?BRFnwLo7kAzmKcgSP9Skwqcgm1Al8djbd+78EnYhd7YraRYDWUQ23Fp243e2?=
 =?us-ascii?Q?NGPljJBm1N5NVBKrafDbkERLQZiK5grRgYeHb9stTaIH5CUsYuP/1oV+o8EG?=
 =?us-ascii?Q?FdeLnSPnxE9I/5E+Um4J99HXEE6QZe8p7IGF1HiX+SuvQ9k5ZemEiRSydPIq?=
 =?us-ascii?Q?qE7G/WLCMbBeCo8Fzoofmp2rPWUuoA1F6bgRyv04EpMfOBJNzDOSWE8W171C?=
 =?us-ascii?Q?qifoFtFJpyj9HUZI2UtdEbm/TLnPHBwkmIO53jIIbtytNIvUhtNNKwn3wE5W?=
 =?us-ascii?Q?p4XByppK1KoNAYCPO6oMtxlVzg4FQkIa7T9AbMRDGGD5KPYnrld7PFR83yx6?=
 =?us-ascii?Q?7z8PFTQMeen2CzAo0z0tJpznuLdZQ2YCYP73djQEaJhqH4UEYKwATKsNHcmX?=
 =?us-ascii?Q?jPw+bVLrGMrLHGxIDEZ6K5lZ/bHEFs3xz+wQIAi0bQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+YU3bHU7CnCsYyB5K2UuTs8sKIgOQG5cZNZEssk2F3FZ8zirHii+piVOrBvw?=
 =?us-ascii?Q?tCs1hxoMF3M7sWuXEIVpyLDy2/sTm2By71PvmDZUyUVXjdgQeUy+sqAzHyUc?=
 =?us-ascii?Q?ErV4OCpm2WP73X+0k6lPXCmg/XcSNBG+x/N8t0IxnwhcwhGFDqG4CzNxoUm8?=
 =?us-ascii?Q?Etza/vItSGXhzCpVy4ZWotjLvD4DG3n0iRLRcBMoGvTazoIsir4xx3jOk+P4?=
 =?us-ascii?Q?wVQrn/J8BKYTJFMqtpw1U2Adx5we9Ryw5sO7sfQ/T4z/jxEnX9ZqBp2r5wv8?=
 =?us-ascii?Q?9VPX5G+vAQNCGBxFSKpRHKTtMJ9azEjoiEFUA3e1ItqtZxzjbQlpriMmicRh?=
 =?us-ascii?Q?a5aO/Ko0v8qeeXiXcEz5wQfrkp9nblDxceVDPPGAyRFstDK1hmQE6q/ZOQpN?=
 =?us-ascii?Q?cOyUxV6Mf5zn10gdoQMdRC6onuQ4nl8wvdOyQ658C1RqZllg7QCwo0dGPekT?=
 =?us-ascii?Q?ccJZydzlHJbDdAnD1Jvxua7iELDz/41SSDc2ays2XLzwFad9u+6fugT4K3Ne?=
 =?us-ascii?Q?LhWoon16yXxhrgssPJnwWbQUhdbcQjffj88mDGHPpLIRhLfcc7vi/e0tllKf?=
 =?us-ascii?Q?WIeKPtLDvr03yZKOhOQlyUjWSL8YaXuz7rPdqc6PacOqr2+3N/Td0PDrQihI?=
 =?us-ascii?Q?TBX3Tgo/Ky4QQAEjLZVfHYzuA7GRYZCaAPQWujD4A9Z+rV30pD5PSAVf9bJr?=
 =?us-ascii?Q?f3aFhJxwmnXuuTwgTSDy9iq0krOzngvr6zhYWZHKhoznJd71j4Ej7h48j5Cu?=
 =?us-ascii?Q?anrfRIKVtUeNbmyK/HFWAKj2lLXKlTy6CFqSZ9d//D62AWOBUIjNkVFHDUWT?=
 =?us-ascii?Q?jmelnXvLD69uKhATEOaSrh588j+yvGzsppUtf9c2IjlCJ49vahGdMi8yNSWb?=
 =?us-ascii?Q?K+8Ugz5tWl8wmVR3ZyLuuryJipryWuLyGtalkTh+JsOIvxPPztazGHcOvMs8?=
 =?us-ascii?Q?sr7za1daVSwz+jv6yMyyn6lUdj+3/loq/eCvqS0BmhXmnZ9CmilqwXtziu+Q?=
 =?us-ascii?Q?1RW2U8iz8JNOGBqb11cFMkwwdr9GGR96ROBbPNSac40NgB/Bu0truzM4rUgK?=
 =?us-ascii?Q?BHnngH8c0mj3EoRyib0byg5z+6ZdZTqaaUaK0WEde/SFGfk9aaGHRIHIzgFo?=
 =?us-ascii?Q?eh0YWykmzyNTTKV+nwtgKb1tc/+tfOf4I9D/Gkz3S8FSc29+B1A6Mjp8S6k+?=
 =?us-ascii?Q?eAududXLXmTeOY9CUSduiSi8AZSW7ZuK4DvDenYrpkGiGpM/QFvO0GThtCQn?=
 =?us-ascii?Q?N7GburKEhF3qrJNG1zzJR3ZsbnHHqcN0glyUGu7zSaNPV0jLdyo2pYmQfv3j?=
 =?us-ascii?Q?MIqu8QrnUMXVUffwWRDckkLaxax7pdelUCBP6aLIyyYU3F7YwASC/meBtZ2I?=
 =?us-ascii?Q?kslNyXdb6MxCUUCTbNB1XtGO2ou5tEa6QtiaGQDlZWLvYy8NULXtFEpnItEJ?=
 =?us-ascii?Q?98VJ7O2PDRImsQayyJWdWsnLSHpQ6f1qqQKXwrqHP4PApkdUlle4QGcSn6Ac?=
 =?us-ascii?Q?47YT21dNz3jTIuDwaQEFJAFje9NgEzIx0yeqPJw7JLzVEgtvv9bmXqKHqh+e?=
 =?us-ascii?Q?hUdMI0wm4wgDWUcEydd961n0k9IX5KZRR1B9os8R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c2ee7e-b568-4e30-35ab-08dc6b193c54
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 02:32:11.1284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPofZ1ooQiU9GDl7wDGPFHzYzQofyAVz9NczSkxhynRYJ+vGQ29FaNEqxQUkwxqzClVZdjbNuCl2jWszC5S5dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Furthermore, for this particular
resctrl directory, my pending fix [2] must also be applied. Once those
fixes are in place, then when building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...two types of warnings occur:

    warning: absolute value function 'abs' given an argument of type
    'long' but has parameter of type 'int' which may cause truncation of
    value

    warning: taking the absolute value of unsigned type 'unsigned long'
    has no effect

Fix these by:

a) using labs() in place of abs(), when long integers are involved, and

b) don't call labs() unnecessarily.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
[2] https://lore.kernel.org/all/20240503021712.78601-1-jhubbard@nvidia.com/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/resctrl/cmt_test.c | 4 ++--
 tools/testing/selftests/resctrl/mba_test.c | 2 +-
 tools/testing/selftests/resctrl/mbm_test.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index a81f91222a89..05a241519ae8 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -40,11 +40,11 @@ static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
 	int ret;
 
 	avg_llc_val = sum_llc_val / num_of_runs;
-	avg_diff = (long)abs(cache_span - avg_llc_val);
+	avg_diff = (long)(cache_span - avg_llc_val);
 	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
 
 	ret = platform && abs((int)diff_percent) > max_diff_percent &&
-	      abs(avg_diff) > max_diff;
+	      labs(avg_diff) > max_diff;
 
 	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
 		       ret ? "Fail:" : "Pass:", max_diff_percent);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7946e32e85c8..673b2bb800f7 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -77,7 +77,7 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 
 		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
 		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
-		avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
+		avg_diff = (float)(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
 		avg_diff_per = (int)(avg_diff * 100);
 
 		ksft_print_msg("%s Check MBA diff within %d%% for schemata %u\n",
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index d67ffa3ec63a..c873793d016d 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -33,7 +33,7 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
 
 	avg_bw_imc = sum_bw_imc / 4;
 	avg_bw_resc = sum_bw_resc / 4;
-	avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
+	avg_diff = (float)(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
 	avg_diff_per = (int)(avg_diff * 100);
 
 	ret = avg_diff_per > MAX_DIFF_PERCENT;

base-commit: f03359bca01bf4372cf2c118cd9a987a5951b1c8
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
prerequisite-patch-id: 8d96c4b8c3ed6d9ea2588ef7f594ae0f9f83c279
-- 
2.45.0


