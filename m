Return-Path: <linux-kselftest+bounces-10742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFBF8D0EE3
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 23:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839092821F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 21:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D954CB4B;
	Mon, 27 May 2024 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BkXI0ZpZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1873417E907;
	Mon, 27 May 2024 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843670; cv=fail; b=GDZ/pRWJEx/ZdemfhySuq+CYME/53OOScX7hmNnXhurOibmRxfI8A+pd/oLd+T3g3Uh7H8aldNCUuCRZFN6Hp2CFTvEFA0MwQY+/e4ekaCK6PoMYYxTTViTzu0YVRSVQMXetESIq1Sk2f19uF1lahkh+vdhHEfDp6yBqiA77biE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843670; c=relaxed/simple;
	bh=2tpMA44GpZVD4BBg2uv/zijRwNQM8ebJXKRISAlvouw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WcvREy4LFMjcdLoHtZFHx34etyAqy0wElRGTA2JNmEnKHNZrAEaUbf/pf6JE9TOvEhQSfT5X6SvBglDyt6gRWg4MySi6y8Pv+YWIK90PGAWtaRJe3pHW+yViKiwdY3YUZqeICVgpamn8UWB/0m9B5A5Kfy6ayuVlgx71QVHaYIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BkXI0ZpZ; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8/HpZCabgzQZNfx8fGqcQvR2Pr392N7oLPXvOkVtjEEB/NQTb4HJca4uYJZ03AoPs394q7GWdXIs9WfO0U+PwSmvhlqkUpGpzhXo/h515NQUHkqOyzeUHWuHqovqD3P2lUe1jtv4MqydU0g/n5bN9QGzJqQQEVi5+gceM86/q+Nl+Gmg0zWt1DzGxcJ7k9PwZ+ktHqJ0NeDXWjXS4Wg3aRL9mYEYMkpNHNbkulEpuC2vuI6ZZUmISDcapjG9AonYnMB1mmCfM5Oh02M+GTyCO0ByWnSZ1ffeiqISqVFVugeObCWuzjOSl/xcmwI6RGDfZ8N5vS1w2+BJeyiuBe3VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXR33Wqh6ofv9ferASJQe4YXHj4eMz31yyl9MvtfjRs=;
 b=nD9axwcK41l9OsTh7ZgaR+MNvkRCWeW9V+59TKLbn2Zx2wghQaxvvvHIO4m7qT52o/wIWV/oYA7R8siAo5yx5PIeeMKn+XAEtxP916rYeK2/nWlcHtussURWP9Qn+A6oCRL6w65oSoixT/bD6bDKUB4ISYw3J5Wx6O7Vq9ijA7N9wSY95VPajSK4gxGrkEgy+rRAdVovadfQMx+35WPLbuled8/I+3yu7OnUczyQtz7E2WaBALZV8T6HQZ9SHash55qNsC1R5bBdZle63Nb8WZjcya8a/BeLuBeO1GaK4G/+O7UOXYnWgkWFwSSZ0hwHgwQHFuh9BX38ZsKQMrMt2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXR33Wqh6ofv9ferASJQe4YXHj4eMz31yyl9MvtfjRs=;
 b=BkXI0ZpZAdSbZizpuTurPCBIXossIKJ/OeGDDUa9KzLCR0LBE3y6ZNp025VaMYrL+QJtOSeTfYHAICAUgBWyBiyuFX/S6V8PdiiUNOMi9V26DetHjLr+kGsNItvCuJ+yCgvmQUL9j6nwklKHuPV/9G05gW5ygmGUVD7jvwgPiSswOZWSI6FjTO0/wL6FsDR01NVjQ546rrPb7Hxb5xsrbTD+vW7lQOQQCSQ+aPusd4v/iAQ09he3ljclk8PL8k/BzdYze1D9yvXxCIEmQgpXjkp7RcvHfeMNBp9p490c4fCqOk9wqi8YDTSPIoWLhi1Mb9bKv7YTXnaTaYimzMWlnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL3PR12MB6620.namprd12.prod.outlook.com (2603:10b6:208:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 21:01:05 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 21:01:05 +0000
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
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	x86@kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/6] selftests/x86: fix build errors and warnings found via clang
Date: Mon, 27 May 2024 14:00:36 -0700
Message-ID: <20240527210042.220315-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:334::16) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BL3PR12MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 217482e9-cf57-4fba-e754-08dc7e901fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zlgFwkxFOmOoKmy9EamO4TBfIq+M5G4p7JYS7A+436Kjt2TzLxzKeLPH1Tbl?=
 =?us-ascii?Q?dklV4O0CY13wvkZTnIMmmwJviA+L9ZKx23FeIESCx7GjCMXgGUwmsSy9hbZV?=
 =?us-ascii?Q?rm0SJz0gH2IoyBRNyBMBnY64SKNLMN5j8vUd/ykv066V/Z6FAUHExt4HESTz?=
 =?us-ascii?Q?kx4gg5VvQBwd/QK7aGQffCR0fAPOi4EfGulfZq1UmFSjh3lcaF7O8KfOpj1d?=
 =?us-ascii?Q?W8o0AMwUr4etXGs/JzSog4UJq63CPFBiMC/c3yfe5mZHJbM4rHgSQkN5LvZs?=
 =?us-ascii?Q?MhmXpUiCjFpnfcoDcTK7fw1bgghFgHoskA2QDOZthYc6aiUtW14hL55OupWn?=
 =?us-ascii?Q?mHnTAdsvZetvdg9O+a1fY9b02npIVtdlkxGQcISg7Ovwcgjb+St1bxzmZxQ9?=
 =?us-ascii?Q?BRZCuu2CV5zRmGuS5/7F0QNuAoM3NQgSG92oMllzy5mzSOfW8BnfdqyrhB+g?=
 =?us-ascii?Q?8TZhGoP1rOozpbubWIHYfkahPZK7WzfeMCXWHcX9Hz1xef2fydSVZWF9WZw6?=
 =?us-ascii?Q?9gZsCg/sQslYWq9vO37ocKP11WMhlArue1QuUjjCZiEgLxl6Z9WeM3Dy/8mT?=
 =?us-ascii?Q?SofkBW1thfCC9FmnKajVhfRhgyScK46HCH5aucTzJRSXoxaFjsyhPUJwR8Wo?=
 =?us-ascii?Q?7iPal8tRr5q8sVdeqmS2Id4jHfYkNw5SSHjUvlEYiAbLHgDbP7PYlmGpV65n?=
 =?us-ascii?Q?ufhLdhe3Dkv/8LBDZHv12IkwrSQYyq+6sf0FClIZxvx4tIjwC6EoQiJRrI+O?=
 =?us-ascii?Q?s5t6qlYbKJiuIdmNrHR2eKj7jwafm3BeWR9NJNL6U+jnpmXE/t4+Ec5cuMja?=
 =?us-ascii?Q?Rb0Uigyrvo8UpvXPfjDZUOfPawnspvjyVuDG54g5WuWPxUZG65DZNYloFFKD?=
 =?us-ascii?Q?XSujq62t082uCBsM9L9rllHRH+s1kDheeG3gUV1Xq0UUKka8B+UzFWLBYAdk?=
 =?us-ascii?Q?XH8JoQ3D/5AJoq8/cWv5iuZU/bXtgEAiiUg9MLYNbdTYtXEeasjQQ8H4Aiv+?=
 =?us-ascii?Q?uHRMfz6Gmpds7DK4kYUFmJW5yr0IhnwzfIvcqoCSjGMQ5yfnuNRZYyd/kaM1?=
 =?us-ascii?Q?KqlFqHvO/L2wlImrbLSN2pLwNT7dG5TDjMxRuUc2zrbYmyoS0+SZZYxZq4IN?=
 =?us-ascii?Q?XkWV4pfBtN+Ax1sUmNYeIH6dZglwRVZLm1lFroCtUZIe+CIkJgfM2ULuFb0N?=
 =?us-ascii?Q?VUgI9tbPDJDg6JSi7JRY1/TRbBniKmXFQ2MaMmSQEoCbKNEd1diBFcZNcxlS?=
 =?us-ascii?Q?RrAQdVeVytWQ9L4QWz69lfSVN457vzabiTc6kH+Lzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9OmLYT4kgT6fBhh8ZbmDi9kCPYswv0QSgbtP/SmKwMYN8Q9aBNCVbbWfXlxU?=
 =?us-ascii?Q?i6si06SH1y1+DTYLnYpGjcVZgtrAqu60XeCl5CbiYgZ0I5cyt7HtLejVJ/md?=
 =?us-ascii?Q?4lFfcdpPLXeBf37N5eNcc1HFrprHGdCf4wlY1AdUocBHJuLgb+mF0idduaso?=
 =?us-ascii?Q?4hg0/98/zP71mQVv7qyt7CKm6278RtB9aLZiAYFqrSZxvHDJiQF0QBeg1hpD?=
 =?us-ascii?Q?ja1tqV3yk2h1VYPzMZqTmXbOwLftGhjP3K4UyN1+g6jJWlRJMWjKSEnqsAgq?=
 =?us-ascii?Q?ep67AN/tMXb2Qf3XX1nIytV1MpOJNutUSvVSz4hXM6HgbcOIo4JsVOWiCP9e?=
 =?us-ascii?Q?gs5+rBFhZYzfLzfpbKzu6nTQ+6U2Cc6Ggh0KLLRR8y8sXDfINsGjKIJWg13/?=
 =?us-ascii?Q?yCbpss4FzEJouovZIEbm0h9HjcLoRfTghTW/+UqXNXt/IcrTT7xfgVUe/Agz?=
 =?us-ascii?Q?mzCWjhVeJ1RiJQxRgjUICi5JRmTTGRAbm2znxJmMIBOY127LfkrSVpBjT0ro?=
 =?us-ascii?Q?g+qJpDbKJwCpAl6m0o8dkkZ7CU0GerzYt/uXAF1nX+rZQWHPlFfcILn8rmk1?=
 =?us-ascii?Q?jaI4dWe4gAmgR0xUCJUHElqbb0GXhnJvqY68TtwwiVq1rhKjv1ToEar7KhrY?=
 =?us-ascii?Q?SahZpnipv4esY0vQPSkCO/OwE/aaRIN9GhoZbEnjfX39ThwA4NlNc+CjkLOb?=
 =?us-ascii?Q?KqzJQJ8hVVMFezij6+HwUC7aEGLzt1UfSxpTBMtG1by9tut5lV5NnLNkxRaG?=
 =?us-ascii?Q?ooEMPc29gdEfE2zZlSM5URLudKAEVoscr3T0woHWDToWCnWz8TKtrBXNYZxF?=
 =?us-ascii?Q?PFKS42sooHdocJZKdysvpjKt/0KueeUU99OVTjQmDP+hwhx15y81mXYi4bIx?=
 =?us-ascii?Q?0Kimxx/2ttJsCUzPTETd4ljMG3cOtfvkAAuJNrzDA6Oh00smwXk6NOJEbPPI?=
 =?us-ascii?Q?h/SfRDypdr9W3AHtmSafIr6R34xPvd/0S4qWPbNAGU59L2yAuX7yU080rpzE?=
 =?us-ascii?Q?TEAdHqfcq+rNjGxEyJYSu/aK1mm0JAwieNNsLEsVzwmRKMmvJr5QyYbpnN02?=
 =?us-ascii?Q?xUOUzq5udgQ6lhJQwTBSN1YRupuW82kQVKH4FyFbAubTQjk094AXjLe7GWWZ?=
 =?us-ascii?Q?WyLT150Gjh2tnj529DTzcZoEz/d7edFw+lRhbcBZWi0vjWpxEq/TtS3w5VP6?=
 =?us-ascii?Q?+PVvNO7RGEEDJWi2l+1vg+EmkjI6wfoykHHG1sOdhL86McJmdoG37pnHSds8?=
 =?us-ascii?Q?8SrNhge20YNGVXQwEbzy86c2fmmaYlTw3mxQ9z6CtKoHXJ5skoKiRJbhHDbi?=
 =?us-ascii?Q?xJ2zc2tnvwCyh0x1rPbdiebYp3jd19eVh21iM9Zc2QgVG5+aWQN0pARr8a/s?=
 =?us-ascii?Q?oP+9SGRgRNlms0booi573khAiCV7hf7k5eiOD4H4mMC9IyUXveyGFPjXhKQn?=
 =?us-ascii?Q?UMegkxKplBK/SN86MFnSC8Lvh++jxUJNLaa3rP1//cHT5CiZX4loh8GixfPP?=
 =?us-ascii?Q?VjiC0G/Pw9rEguZ+Ymrk/fSxtJqDqhP/L9mydAgmuM+wW1tK6Gc4L3o2qywO?=
 =?us-ascii?Q?9dWIZHj4F6YNctC3BA7W4InTQgQR6pNZ4AO+bJ9mCd0E2CQNEXISFlfq9qha?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217482e9-cf57-4fba-e754-08dc7e901fc2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 21:01:05.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2r38Ef7WnZ0wWlDJBz1oYuc6h65ebUkyaWDdkTXjS7E9H3DnQxzZap6VKPUUHSj9XAQZVE6GxikJOqbWuLXMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6620

Hi,

Just a bunch of build and warnings fixes that show up when
building with clang. Some of these depend on each other, so
I'm sending them as a series.

Changes since the first version:

1) Rebased onto Linux 6.10-rc1

Enjoy!

thanks,
John Hubbard

John Hubbard (6):
  selftests/x86: build test_FISTTP.c with clang
  selftests/x86: build fsgsbase_restore.c with clang
  selftests/x86: build sysret_rip.c with clang
  selftests/x86: avoid -no-pie warnings from clang during compilation
  selftests/x86: remove (or use) unused variables and functions
  selftests/x86: fix printk warnings reported by clang

 tools/testing/selftests/x86/Makefile          | 10 +++++++
 tools/testing/selftests/x86/amx.c             | 16 -----------
 .../testing/selftests/x86/clang_helpers_32.S  | 11 ++++++++
 .../testing/selftests/x86/clang_helpers_64.S  | 28 +++++++++++++++++++
 tools/testing/selftests/x86/fsgsbase.c        |  6 ----
 .../testing/selftests/x86/fsgsbase_restore.c  | 11 ++++----
 tools/testing/selftests/x86/sigreturn.c       |  2 +-
 .../testing/selftests/x86/syscall_arg_fault.c |  1 -
 tools/testing/selftests/x86/sysret_rip.c      | 20 ++++---------
 tools/testing/selftests/x86/test_FISTTP.c     |  8 +++---
 tools/testing/selftests/x86/test_vsyscall.c   | 15 ++++------
 tools/testing/selftests/x86/vdso_restorer.c   |  2 ++
 12 files changed, 72 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/x86/clang_helpers_32.S
 create mode 100644 tools/testing/selftests/x86/clang_helpers_64.S


base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
prerequisite-patch-id: 39d606b9b165077aa1a3a3b0a3b396dba0c20070
-- 
2.45.1


