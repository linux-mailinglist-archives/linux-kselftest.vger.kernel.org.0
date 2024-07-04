Return-Path: <linux-kselftest+bounces-13173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38EA927076
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459641F25016
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 07:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A6D1A2546;
	Thu,  4 Jul 2024 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qbIthqmn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76541A0AF5;
	Thu,  4 Jul 2024 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077927; cv=fail; b=dnX5VWR79EEVjIJZMwi6+1QjuGbL51nEyj0hxJOb9t+hnm9lnAJ5i7eqiQmd9HN4b8aD4U7Fr/0rt+qCBzWlTMqrymjW4Q+BmrYQbSSXQW3gu7SCivGuQCLdpkFnGsCtsWXi2WtI565ndUki0Woe3csAkeKjdiIqc6rQcoWfBAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077927; c=relaxed/simple;
	bh=p+PJupmuoDhNmvW8qc3bY15h8zhzVVX0bDoh75u5Xng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rk2p61h+ySFtIV66umjel7J2JucCWNM1jkO+VopTIlmfGx5Ih+zoGvIPQGmPGrPTKR9rPldXfriWtmI5fmQAy28tNLDuNpJ0iizvuON4r9b4ZBU0outabycXit7sH/P5+an0VkMcp7184XexZ6A/K9mkHFizE6JsClMohlVtizk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qbIthqmn; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWNqD3NWwQzx3wlf4i47gwnoFbT2ugVD18gLXlfwGeZQjhrltHbq8GxQ35zgclLS/XtCGGHZEL/uG4VsTIVk1mQ3MPZuLOo/yF3KjdAjHgtvvjoDIRAGJqBFGFXsjjhXekTR+N9GL+Mx9vLXneVnjIQEi3u/AZ4m1/QXeFRigWR7azzA6GcIXKjQDRy7X84M8UAfRTBUVojP0V6n0Tg3I2LTS/GiRiBeN4oqN2k8z1c5WEfofrMaAZ98j3imqL+oOvn3kuJ6t3/IGwAxctKDy/R8knkiNNw3MnkzOIwvXZ30iQhiWNX5Sty3nqhJt0uIEGpokldj27vvXGbqwpcjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63Wjs5b1chJ/8HD6wi57kzak7hjwZLpjsmt8nRaBgb0=;
 b=SZPUNj3NOPriFUDnJAtD1ZT3VQ8kiOVQaJR0CCu1ScE/lB0kRDbxFa8f7QOFT41jRr+0O/+Gz+rsWhn/Lns7PuUUgQ5nDK4jsg7PA/zoSeSlEN3LOLKBlap3JbyMK4QaXvPMwek1ALNRVUdKxQmOxbGTlf0sNTQknPswXuTJKvADr4k/sOHzxiUQ8dWNTbmHrxDm1qNGyk6CuFYqL0eRAYLlIaazmQRqqbSfEfyy+F8l3XiQeb5czxW5gko1ICWQ24DjxvyiEiJvz2ZD5bCYPpGTeE5PesFp4pSyvqwFbUEHRuk/MQ0XZYJDUJWmByp1v9FlWRJdZ1FIuqabuM4iHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63Wjs5b1chJ/8HD6wi57kzak7hjwZLpjsmt8nRaBgb0=;
 b=qbIthqmnKYOP70+hIIiHjeB8iRVqB4O9qGacrUoe4z0SCsRVoDYSSmrNjm+z/yZtf22fnqeabYhH9Opjz+BmWTQamtP7oq7SGJm+kQrB7D7QG79UcLXHuzaqdQc8a90LjYj3VHcFiskeP9wBYkIo/t66yB/9xtTZ9Xn2JCDwYAhcLA7cutJFT2SF3+asEtEEEDYZMUYa8P6ectjc391ZsIiO45lSynoqe2a/DIOKT9wSQxupZMsi7LTuB9hpOGEtIBTnJdlQ68DUCR8/MCnOMGyOe65FVzYS9U3Zdfesh3UnCSVveXezOy9yOfxBUxVLfdSVsSg/UqYczDqQ7LaMMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Thu, 4 Jul
 2024 07:25:21 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 07:25:21 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: angquan yu <angquan21@gmail.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	x86@kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 2/7] selftests: x86: test_FISTTP: use fisttps instead of ambiguous fisttp
Date: Thu,  4 Jul 2024 00:24:26 -0700
Message-ID: <20240704072431.111640-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704072431.111640-1-jhubbard@nvidia.com>
References: <20240704072431.111640-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e26f6a4-462e-45cf-78e8-08dc9bfa76cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZLrb2NdW54bASPxJ23u26rgNSC0oK1inyfR23sv0iA5WIrf0v8ou/z7yVUYY?=
 =?us-ascii?Q?U7sBmRtrnPGi/DOkgKQXT1JyLmAf123AC2aBKheOvAWFFsjNMIz78NQyKb/r?=
 =?us-ascii?Q?j+JtXxB1SxjBXeARdDbu1YId5m0xUa5WSQcF+hL5OmDgl5flNXYVY+odXg+n?=
 =?us-ascii?Q?XMKNJ/6uMQURp23C/BenvzKrjRj6oq1TOauMpSYYjTBdGO5fxd1iOHjBHcQ6?=
 =?us-ascii?Q?TIzNPBudbO48E9m+qafZC7W2z29ULPUp1WvlMEKvMF2fTXLYlw6JdN61G3jf?=
 =?us-ascii?Q?X0TopWFHa1n0w+E1pCTZUF1kTeq/JNeCa/MIqIcIy/czIee/aKABH0w2pGIM?=
 =?us-ascii?Q?ebaC/XkenJO+aRn9o16YUvWZ0FPgCoQk3JgWT4PyfKsIcmC7Epkf4l2+krFb?=
 =?us-ascii?Q?UBT636GcJ4Ku4KYcMWZuoHj2rX6it6Q/AWfqYZXExg8l27w5SxMsFQVbqNO8?=
 =?us-ascii?Q?DupDIj1zSUunhE9ciWTdqIHfiYsS1dyEEzZEcrAVVlo/BgSpVDo7wXfiTJOj?=
 =?us-ascii?Q?X6S+TTKByyJKYwAu8kJeWCE/ED94AIKMmXtS3tq/kn8Yi1wDmzMi6ruze3QC?=
 =?us-ascii?Q?GCVrLE+oorm+8yoYSr41Eu4W4F920EI/tr5Tj3BE+bhIf9Downj5fKNQiBq4?=
 =?us-ascii?Q?R7zL8MZv0jjNLillyiwNxlTjKqGc3QQNpm7H280+ZUJn92GcvVBcmGas0ERE?=
 =?us-ascii?Q?OAcNaNsNcOCBrvWZjZ5liYIbybWxmDdSEp3AAtuMCt9M+3bgO69tOD8dV1Xj?=
 =?us-ascii?Q?Duq8PgBHRo4c9X/X45NE9Y303wVw4aCznr5zyY7pAd7ySgbUXEG0JbthwcQC?=
 =?us-ascii?Q?rtiB3rXiQuqVUaPt+2sPrkRhdWS/PinQTTjt9AP2pE5FNNH4fu1jJ3zxBG+Z?=
 =?us-ascii?Q?fTNx8eTK9lZ94DvjMWrVsndwFunDvCzTt58BXGs6DtmIRJh3A9ytuiR3xePC?=
 =?us-ascii?Q?QXwdMpM/p0fxT+zVJtfVcrRe2OEk/dauOObSdvdJqSm4G0xir0IDbEO+/j6Q?=
 =?us-ascii?Q?yB9mqZg7ela8JcLiphrxYlfWp9VciLUCTZO3GlzYvyfDVaC//5K0wUJTk4Lv?=
 =?us-ascii?Q?mmxELTOtY0bmoC0fIYw/7b6k8xxDp8M5DQcXmf+H39o46xqX1CRFRvmKt4j6?=
 =?us-ascii?Q?HGXOR/lhfbVHe0vVddjcn2NqCToeFZXJCiZW7aOL7cOft+R2CD9yFTeaL4rV?=
 =?us-ascii?Q?MthehB7kalnhewxSr7747oiDa0RncI8drE1UORkj6DFQoFLDBOxULZPNmA0p?=
 =?us-ascii?Q?rjo0EfQMhfowX8ttrI3vTNK8bUdnm9eSqOv7iYHghzqTQfWcY6zVRQRVkKPs?=
 =?us-ascii?Q?5UE2kzjff9GIeujnLrDkZBJMXM+e9/6VR//Djku8kz8nMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sa+v4MDqXVruaaIYVc6YAqwX6jqrGB9Y1TsDTicEMGkdX/HnQAPnsWxydIEm?=
 =?us-ascii?Q?+CIYuGemEMAjVOjxyG4yCG9eGMjrRh7jQUX4qgLqkxOexK4NmeCvcnVO5wfG?=
 =?us-ascii?Q?Y2onctIpyFRSl25qlkGNKMzpISwcs1yWHCHeo0HqVV0wjmypdp2qzUblaYS/?=
 =?us-ascii?Q?GOJoflLSkAL3hW5c8DEAXKAgdxbaFnRmtXNU17MBRpu4TCJa2JyNRsf8jFcd?=
 =?us-ascii?Q?psIW7gWBUZ2RD2A3CkI0CF26AXhj9TvZRkbYwTG/K32d0nSX9AtOmhc0skBA?=
 =?us-ascii?Q?c+qPveDspDz4fwl7NqjliSPeeGrVbUt9vuONZMuVyLx3+HtK4KFX0GtNF4ti?=
 =?us-ascii?Q?q4CAf6AUKtDflOWqw+1mosOGciG9Yvar0OO3+utlH/Nog68AIzf2LxaSgKE3?=
 =?us-ascii?Q?antWXSgmTxU6UaM7xOpQHSIekoboQMmILHGk1seuAdzS75Fpkjz/yvLb/LZw?=
 =?us-ascii?Q?mevP2NDjjyUyjLIUP2/qGhy9lyiIb267qkDkfXbtSmB1XlR6dsfVZ83Q4cnM?=
 =?us-ascii?Q?iJCkC4yhbLJeZiZ2F6QA2scCXtshMVmUTXbS3VTvO7t/a58B2tAbVNX6YPO7?=
 =?us-ascii?Q?hz1Z296W4SsZV30l5nyPmEtPDjvmE8KkDi+2cULM1nR0epX67GCf9cTMWTiQ?=
 =?us-ascii?Q?ZgEN/WSgwEcaY3NoCxR7B1bj6RELDBecq0SKf23ABTBzfld89eFU5vNpbbtH?=
 =?us-ascii?Q?W7LfuauUt74KUGg84iEw4YeW+E9jxs6PK4hHoXwJcG4jikv+uaFZnWW9TjGI?=
 =?us-ascii?Q?DhzE4KNY3Kl4QTUa0rmSNvs0rPTJl9tkI6QYANpw6TmRbrUJaxyE6N8XAEJU?=
 =?us-ascii?Q?1H2cal2slrUViDfaONic9B6BZCADJAw1UOWy2t5jrw2a2Se82D60beoB62qT?=
 =?us-ascii?Q?/HGMK4Rfd4RorQ+QXqRyLrFEO4xflaTZ1MGhZVX/bYj4f9mR1QhVneL4UnIF?=
 =?us-ascii?Q?Ejx8qGfsDPL/bp0QW0NS9b0CCPYEk9Ua6Nk5Crkp/Q52PEK3/chdsCd8gf50?=
 =?us-ascii?Q?+1pRDLCLVoZh0grbr13FBPrc/cdEA6JACH7n6Dwb1HQSQ1Q4cSsvmDBjY1bd?=
 =?us-ascii?Q?KtoKDoRcRk5yZqVnmkYm1vftBlGK+4PSL26rUeC/qi4AuUnGde8CordVlp8R?=
 =?us-ascii?Q?1yoLxq+qGon64ml94RVlfe6NkW+1MowobbkArF02pa1kN0Nr/t2NlvLdol2p?=
 =?us-ascii?Q?MxN/UWHds6Px3wniPU6C9z0yaE5mz+dektyn05nQ2vnfDfxbj2SvoT73wzow?=
 =?us-ascii?Q?fUv1yzsrPkKlcye7jjtSKFR+7WlCurTpQP/rgnGz0U4tVkbPQDvEYlvv1xPt?=
 =?us-ascii?Q?y+KJK2Dm2jwPh8X9D7zdWxW2Sb/5+tQwz6qSvbp61ZQAUFlDbHmL7spoIPW+?=
 =?us-ascii?Q?XZVzFp1eGNpnUX0l5yyx1LXSLyj+hvKrwkWncKVQw3Zd+olj5MnSAj6g7pa2?=
 =?us-ascii?Q?jqSjZ+FSjudMXqu1Sotm6E/CHNav1ths4e/iOWalzCImkj+ytoCP8391oYJn?=
 =?us-ascii?Q?oxQnZtW7jrYmWzv9IvOCLSwu2icijJUFwvxIk87j3cTtC3ZgqSveDuRxFkZT?=
 =?us-ascii?Q?vfcGdnb+LYSmThXX9CXtXO112YcWNBBqs4MjiOUPXE9w3t6OjDAs8O3049F4?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e26f6a4-462e-45cf-78e8-08dc9bfa76cc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 07:25:21.7539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDQXK13TR+qKNd8IBOIVl/nAHf9fm43RQqKoaO7Z3P9lrHLI0LwcxqNXZgdLY2u6p9SNLugS0kQi4dzo0c2TBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610

From: Muhammad Usama Anjum <usama.anjum@collabora.com>

Use fisttps instead of fisttp to specify correctly that the output
variable is of size short.

test_FISTTP.c:28:3: error: ambiguous instructions require an explicit suffix (could be 'fisttps', or 'fisttpl')
   28 |         "       fisttp  res16""\n"
      |          ^
<inline asm>:3:2: note: instantiated into assembly here
    3 |         fisttp  res16
      |         ^

...followed by three more cases of the same warning for other lines.

[jh: removed a bit of duplication from the warnings report, above, and
     fixed a typo in the title]

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/test_FISTTP.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/x86/test_FISTTP.c b/tools/testing/selftests/x86/test_FISTTP.c
index 09789c0ce3e9..b9ae9d8cebcb 100644
--- a/tools/testing/selftests/x86/test_FISTTP.c
+++ b/tools/testing/selftests/x86/test_FISTTP.c
@@ -25,7 +25,7 @@ int test(void)
 	feclearexcept(FE_DIVBYZERO|FE_INEXACT|FE_INVALID|FE_OVERFLOW|FE_UNDERFLOW);
 	asm volatile ("\n"
 	"	fld1""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fld1""\n"
 	"	fisttpl	res32""\n"
 	"	fld1""\n"
@@ -45,7 +45,7 @@ int test(void)
 	feclearexcept(FE_DIVBYZERO|FE_INEXACT|FE_INVALID|FE_OVERFLOW|FE_UNDERFLOW);
 	asm volatile ("\n"
 	"	fldpi""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fldpi""\n"
 	"	fisttpl	res32""\n"
 	"	fldpi""\n"
@@ -66,7 +66,7 @@ int test(void)
 	asm volatile ("\n"
 	"	fldpi""\n"
 	"	fchs""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fldpi""\n"
 	"	fchs""\n"
 	"	fisttpl	res32""\n"
@@ -88,7 +88,7 @@ int test(void)
 	feclearexcept(FE_DIVBYZERO|FE_INEXACT|FE_INVALID|FE_OVERFLOW|FE_UNDERFLOW);
 	asm volatile ("\n"
 	"	fldln2""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fldln2""\n"
 	"	fisttpl	res32""\n"
 	"	fldln2""\n"
-- 
2.45.2


