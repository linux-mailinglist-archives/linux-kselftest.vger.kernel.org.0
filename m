Return-Path: <linux-kselftest+bounces-9442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1728BB85D
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 01:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219021F254A3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 23:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DC484A4F;
	Fri,  3 May 2024 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AYiCfOz8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13E83CCA;
	Fri,  3 May 2024 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779662; cv=fail; b=en9Iu+IEakkx2Biwzy7Y2xNSYw/0XcIdnr6b/dBNQb/yF1/QfcBxo3yzUHk2vHXKnZDqOZChjUwnPNhuFEWlB77jgnPqJEFuW45/KEcQVwaqa71n3yTGt7MYyhH5kqkLSLOqplptj65EZTgHMqKs6F0xbN1I9aOq+Lf+TX4W3JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779662; c=relaxed/simple;
	bh=CA3JJ1amEywF+njdJa3rk0kiCLtEKIoDyH5ZtZll1FU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e6pjD0+qj4cYMTWMvbFx3s/WBMGv3TDcFtbMOMFE7gyYpShYMCakxwY/2MxT6HPnlYniAjZYqHFdGl5BgAn7JuqdzWWvH1uDwMoKt74wIpTNuM8mp99YJt+q+TQCqK+TSz9w0RYGbTaatswyCugOKUenhWVLm1w2YFpOtaGTT54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AYiCfOz8; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMs43ATUtksQAlLvIrdCAG+oXFfdjyAkUYDjMw0rXm6KeVnET6ZTQ7oBonDw+XBTCqfTJO96Ft5+t2MiMHwgiWxxTzRDktENTa9RUq2KF/1m1jLxGxQYFuOWiEwY7Cw515OAdMrZpFrWDS6IIQF45bTljuQrLAwVzTiO3O4HBjSn6h8wampEPX3OYFOVlGxyPz3vazLpNKVbWvPgRb4yCX+2SAw23diXjdtziPfWzcdT9Sl+pF/4sG1we23JRYddN4Fe/Z/l0bGOtszHen1KrHdMLx0FHXwdNb1MDZ9DGhDmxh3NcDAZUs5OmTA92C1Z2Z7PYAExHSBxy2SxhyEm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYR7YRibeFW3Q09+sp5MMyvp05/CHrNNHQqi/wXJRSs=;
 b=N3FRN447v4ZSlaPkBOrvWgb50rV7vio656yGnmg3pJPtVJO3/WAtShYqP7xdlSp5SopAaRMISSFSDus1I6iceEPd6UhpSVf+tBE323EYzHcMxqb8j94wQOwYDHv0hPks7ciB8WfGz+0Ths/gdWss2/lK0siO7WbEq9Qy4aWvXJsFI8BqTzQpGBt57+uGFrVv0zZr6JwXkUE/FkZbBDJPU4wPIPBTE9KfRF6uFyXCPvXyTd0BgJVYEYTy/RTW9rR/9cqdavA1XBOSNhmfG3huX4WL4talUr16ewE6HZvAZJQzmuNmuJWGbROtfh4uuHHzdRgezz8TcDDOgIUuXW56BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYR7YRibeFW3Q09+sp5MMyvp05/CHrNNHQqi/wXJRSs=;
 b=AYiCfOz8d3Buf8cyajLCW0DPGgL4PLKk7q5S7AWIESnOOXDks6FdvM2cxaI5/OmLH8Jh9OelXd9o1dwt5uJXewrWQ5HpqwU4m+tjJ2X9wSEdVxk/maB//yMejSsGu5zvaaza3ihGAYpvsvgEuHGL7cJNKHThkYI9y96v/6p9TMDnMRIK2tXQScTWiII1CEkS8SL/dl1weyikjiDW5JPKXpryOv48Js0Dvv/9gJ27o9mLGw6S/k0+SIERm2TAMJLccRnKeHQGTicAe6OnSNoQLpFEQe3bfielo8LbBgrill5rFKLV1kJRnaEfch08yuQ/c52/w+NvYa8QGf4pQdc5zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 23:40:57 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 23:40:56 +0000
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
Subject: [PATCH v2] selftests/resctrl: fix clang build warnings related to abs(), labs() calls
Date: Fri,  3 May 2024 16:40:51 -0700
Message-ID: <20240503234051.21217-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0075.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::16) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: a3970641-3976-4416-9982-08dc6bca7ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7J+PbXGFTa5ryUyUAesAj85LgJHEqtrt+B+fCRxubb8FbJ4w+FwjhtPletDP?=
 =?us-ascii?Q?rybRL4dAaxyI7or9Kol9io+vKPWCJBHKRtGq5FG5ozm3F9UHDWwQKje0LVlM?=
 =?us-ascii?Q?2qvd4sGgTlf88k+rTLOTydo+FW/vzEoZ7pTCt84SC9YYTHjko0yin878ilGC?=
 =?us-ascii?Q?0LsGkedB/wXByC3yxqK+9idvKtFB2TwrvuZ47lnifXe+1C8neL/x+8XqUNNM?=
 =?us-ascii?Q?rTtuHtn+Pg3R6XFxc1jFQUIvC3YrlCiZJCcWwyjyI5l01H9RF/BvvVuVTQtG?=
 =?us-ascii?Q?LOv70bU7AjwHjQcpQqBVrGkUvQjRligEF3PgdLYO0zNMnhrBa+zFD7vgivEK?=
 =?us-ascii?Q?FDL4Ox9hVg+AyjAK/ssYLTplj/aXFD7gHzrQcho0UUd+3qhVq3OZ4zTmkxdm?=
 =?us-ascii?Q?wS40RQEX9OctA+4zJXv5cHXzgrwqx/j9a+7xdneuNF1EM6ocvZPUslPZQwWp?=
 =?us-ascii?Q?NkdKe83AH8+bj6Av32+cjd0R1X/MaDpNnDMg43lgF37rYBX8MvBFtYDe2zRW?=
 =?us-ascii?Q?1LDswKCMb6JgRatNzx5dmxKtDkp4YCLne1/k25optZzh37+tjhvwdKEpyRxu?=
 =?us-ascii?Q?5QbGKrP5neXz5P289S4dASqEcOMIbXEgYLmAJmnqVmVPMDfOLc+HDXKulAIg?=
 =?us-ascii?Q?d2agNi+hwiqbwi3ZTSIJbIe5Fa09k5oS6Qrm04enxEan6bjmjPYFAVJyi6ya?=
 =?us-ascii?Q?sRun+rQhB8D9NqvMuS1MLesbFEfPx+eHUuHsWBCFmcfeKzf/SYzfK9g+BXz5?=
 =?us-ascii?Q?wZWxCVUGs0AqqADyWPgAGa14gCJN3mxRKgbRP8UL2HXRxLg71Dc0eAYJ3z85?=
 =?us-ascii?Q?FWbRwZkmoc4QSsh2frhMjUEp9BW+6y+QBhMJo+sZfPaXSV/4O1IM3q5GkjEv?=
 =?us-ascii?Q?YGZ+zRSh0nJLyA9c6KbunBZnshFU1PZEFzTlb3Z1fzc+foppLzOdIYHGHsSN?=
 =?us-ascii?Q?6kijugZ/vEav4zlPvroYw1lvNQlA05Fljx7KFZlekOE7Bm3iQdt0bUAbVyd+?=
 =?us-ascii?Q?JyfOdW/jbPe2cajVVxmo//ZFfetrYzlnOfSgeWahocCktUMLcDmI2vaS/IKs?=
 =?us-ascii?Q?F9xWzA14GXBJcBJGAMnsu9BPuJgCNqrRGLkTQgtgUXQNt9bijPYtVN35dsEU?=
 =?us-ascii?Q?W+RMm/HNZRlqtDAIYlUztirL+cQQQ6ja1JhM/Q442V7Zxk6t7WEG4i/ZpF35?=
 =?us-ascii?Q?sJrz4t93QqFMKWOfXXmt2dQiQH9HIJsI4eEb/4d93Xvho+rp6L1ADu4zVx3y?=
 =?us-ascii?Q?PcMVmmqe7NvVEusK7xF/4e/BYqcCjipBUa+ZFiKsTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tVx5FzMtT0SiBxbPbSfKqXAH4nhp8sgMcxWH6gvIAF+8wEnPRMro+jOy+cnl?=
 =?us-ascii?Q?HTM6FPaEXQkyZNQPBbpku21lgzXvFsa2E3eyBXUguXJJ0KXUki70bbAeahUO?=
 =?us-ascii?Q?BwpMOKZSNZsoqiG8hMwQfIIJWhY8LBIb26jQqm6BQ7wkSLm0qxUW9SXi3nac?=
 =?us-ascii?Q?3toEfSlmBZA4cH5Y5EpwKjABG4gA7j9m5e1UYg+aMn108tGa0UY1MRG76iPM?=
 =?us-ascii?Q?zAtA3HzEzn5GdpH6CMgIbqBJet7h47NSJg27+4UvH/XUus3Pzb9pijDB+mIJ?=
 =?us-ascii?Q?OEXSsT73Jn5OkqaP0VwbQS1OLy6nmGEqVQ4dj6vxLqW64z/UMaasnCYWm154?=
 =?us-ascii?Q?8sPuPssJWvDwGZys0IvAp1eCpVDPqX4NE/3PJwgC9w1b/JKlTp9J64cgCFG1?=
 =?us-ascii?Q?ct33cp/M2i1xCAGxJKP7mtXdwWqUHM+FuNk7v1TihI8kIpFKJLXU1bxNhCCQ?=
 =?us-ascii?Q?pBgcCjaJPPw/CGkAFzx0VPico2GbwUj4QdlZ+fs6IqwhiJffH8vDwN48E4bz?=
 =?us-ascii?Q?DecWJHeZYCGUy6mFdDKKiKY8VJK3ReHVnREFHT0p969aeh47PTzWsJRuT23j?=
 =?us-ascii?Q?GkXVYQKNCsJmkyWhszT8jYrOh7/FSSRU70twp8PveVvZzsL+YotUwWckfhPi?=
 =?us-ascii?Q?tVcUS0pGvM2cu9DVUBTHydEYZ1kDPHssEW2M+wcsp/w8jWrgQ1UdyPptGHWY?=
 =?us-ascii?Q?oN1IRYf4Qx9cryRwEM76hSV7+02gxqPFwAQz3UoMNfif10REMJGDuafMg6/b?=
 =?us-ascii?Q?1CC64CEQ8n1KmEPj4OfBgtKLjZk1ZuFsxJ/RrbXJr/zI49gn7eh5j2K3K+vK?=
 =?us-ascii?Q?tiw3XHyxz9eYhm0GGs2eUPBDlJNXnudX3Bz54dKKVRLlP3WIFypPr9pK0Do7?=
 =?us-ascii?Q?Uf4rjTx/PqEZAP5xBGv9zZPPU7g3aAwLJyfoRI8tGAo7mGJoDjcgXIKx8aRf?=
 =?us-ascii?Q?b+b/rRHUndT6gNRd6vePkql2ZHUNxRVVB4poxyEA6Gb0lbrmRclqP5atAZjq?=
 =?us-ascii?Q?8210b/JxACJI+iFqoU4WiaYdChUGRPeXLzHFi0KF1eglunouESNvzLIKPgrX?=
 =?us-ascii?Q?DikFCcfeZlT0WXFRoXsMISHyY++EMkKUiVOWmcd5A2XcLOCTAFpYw4UcI23Y?=
 =?us-ascii?Q?aRN49BKQ880f4ZlS/cNUHl9OZw/geEII0JKWHQFmjemXqEB0g6f66BKURA9l?=
 =?us-ascii?Q?ywj3o+C9pk9LcSaj0YE9JpjYNE7GGpWoA1+5LGK4E4ZXzXo/662Z1P12sr01?=
 =?us-ascii?Q?RTWkRZxPf/52tDXNMlQKgC24+XPCwQK1sugaTZww3sx0KpZw220mE4WeKaO1?=
 =?us-ascii?Q?Z7w+EmX25UTGvLT3ez2t1AWMR0AGSOGRQ4bmv8bUsZ5ohG3d7YZmREMnb/Jh?=
 =?us-ascii?Q?+AJspAX1ozKOB36barfMyFJRZznGESWg//qw8psGExERWTx0Xv/n2H7Vwtt4?=
 =?us-ascii?Q?5mx/HbIXGGc2w1wfPJsnKr82aOKwRvuAG6UGko30xA7OLGEIdSJLy1JYOekn?=
 =?us-ascii?Q?gZtGLYB8h7q2AKr9UHVcxNoNoamsJGzjqNLGl7cBfm/5kqJT6dOlyKSTNlvQ?=
 =?us-ascii?Q?gzBjS/Mqc+l7U1Q56Gx8YFw7sJ1h/ZmX150UFtJ4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3970641-3976-4416-9982-08dc6bca7ad5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 23:40:56.9143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vl/D5geMFB1z40+N5LyHwpWpaYqJF/9lySDPCFk5OyHGHGUWY1jeY113r//5ALNp5YKNqdPxF+BLGSUa4j4VVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341

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

b) Change to use signed integer data types, in places where subtraction
   is used (and could end up with negative values).

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
[2] https://lore.kernel.org/all/20240503021712.78601-1-jhubbard@nvidia.com/

Cc: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi Reinette,

This v2 includes a fix for the bugs that you pointed out (thanks!) in v1.

I kept the changes to signed integers minimal: only what is required in
order to get a clean clang build.

thanks,
John Hubbard

 tools/testing/selftests/resctrl/cmt_test.c | 12 ++++++------
 tools/testing/selftests/resctrl/mba_test.c |  4 ++--
 tools/testing/selftests/resctrl/mbm_test.c |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index a81f91222a89..af33abd1cca7 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -29,22 +29,22 @@ static int cmt_setup(const struct resctrl_test *test,
 	return 0;
 }
 
-static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
-			     unsigned long cache_span, unsigned long max_diff,
-			     unsigned long max_diff_percent, unsigned long num_of_runs,
+static int show_results_info(long sum_llc_val, int no_of_bits,
+			     long cache_span, long max_diff,
+			     long max_diff_percent, long num_of_runs,
 			     bool platform)
 {
-	unsigned long avg_llc_val = 0;
+	long avg_llc_val = 0;
 	float diff_percent;
 	long avg_diff = 0;
 	int ret;
 
 	avg_llc_val = sum_llc_val / num_of_runs;
-	avg_diff = (long)abs(cache_span - avg_llc_val);
+	avg_diff = labs(cache_span - avg_llc_val);
 	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
 
 	ret = platform && abs((int)diff_percent) > max_diff_percent &&
-	      abs(avg_diff) > max_diff;
+	      labs(avg_diff) > max_diff;
 
 	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
 		       ret ? "Fail:" : "Pass:", max_diff_percent);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7946e32e85c8..707b07687249 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -60,8 +60,8 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 	/* Memory bandwidth from 100% down to 10% */
 	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
 	     allocation++) {
-		unsigned long avg_bw_imc, avg_bw_resc;
-		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
+		long avg_bw_imc, avg_bw_resc;
+		long sum_bw_imc = 0, sum_bw_resc = 0;
 		int avg_diff_per;
 		float avg_diff;
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index d67ffa3ec63a..30af15020731 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -17,8 +17,8 @@
 static int
 show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
 {
-	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
-	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
+	long avg_bw_imc = 0, avg_bw_resc = 0;
+	long sum_bw_imc = 0, sum_bw_resc = 0;
 	int runs, ret, avg_diff_per;
 	float avg_diff = 0;
 

base-commit: ddb4c3f25b7b95df3d6932db0b379d768a6ebdf7
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
prerequisite-patch-id: 8d96c4b8c3ed6d9ea2588ef7f594ae0f9f83c279
-- 
2.45.0


