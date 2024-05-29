Return-Path: <linux-kselftest+bounces-10812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0868D2AD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 04:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B6528254F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 02:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF2115B0E0;
	Wed, 29 May 2024 02:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="trMiOaVx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8499A2AEFD;
	Wed, 29 May 2024 02:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716949786; cv=fail; b=U0OM/xZJimm5OG42d6ton878hQDikSyubm28aGvEG5scD+MJunhaceGBzx2ycxqewMJNz5ZbK+O8cuAgh2rsFyWzesfay6oqYf9ntSylGzS/0izcP++a6C5gkcIaO03TrH4Gj4KJnyl9992TD2ty9W0B2wxvCxSPkDTwkSwAwcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716949786; c=relaxed/simple;
	bh=pnP0GyXq+TiXtfIrfLDTiu3ptFOTcNlQgp/4lD/Noug=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lxpSOqQy+A6Cp4JtTBRWBqcZus1UWYqlJEFTNg++UJ8KbJY6oBCx03o2EJpZMw7t4Vf0LnzKfnS1kRYxDtOt5xyfzCKg4pZXOE+EC7Imj8JTmcf+FNFmms6id4vV75ZSxuQg2bkWCQKstTHZ7v9E1WOzISy00WFp/5iE2QU+b0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=trMiOaVx; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOA02SuiA2v6GyTl7Lm+YUaJXD5zIwy0EDqFh11dXDS5TIqvQVjyB1hP3pCY8ZU/IOSxoaOML1uNjkbqqQ15eT2PI6otIoiqbVdG79JasSGnRE6JJZxtbLpAPg6O7l5vJRzxDqHQAAMerykXickrEEeH4fI5/PD6zfL8n2OmTE795iqqZp0J4gxzxxTC1KuU7kdZxSjPRu1ufHCm2E5ZYNaPsMJRKLfKA7n9Nr36ijP7MMBidhE/7BQjfYddIS+tkJFqefh8ycIpSTsOJLrVa2yqAew/58V+VHdNc0ZmszpDHS3bA/+qSO0pm5x9F+yqwb3MTVTuD2DCow5qO0XSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oj3NjcrnjntiFxcdRJxvUwGDZ7DbxpG82tRdUCAdYE=;
 b=Y5Bny44RR9jY5Q9g+47W7dARxDys3qaSqGIp6Qx/oDOZrZ5mFGn25c9uVkvBqNoz1jN88BJQhC2aY4tol5nT2OV1sM0nZrI/Josd4MFluz6nfUbeO8OQ8QW5ckrKo5R/jziGKSxD1dzGhFgxbiwvui1elycei83dJvoAcdP+8XggRUV3mzqSBaT5McghdQC2nt6ZjNVYoNo9zALY+3Wsbfqtg8mWzQitD/EMhA6Cneju9NlE66MY5wIIj2+F+ATF6OpWV2FdkXVvZE+LSlNEZJH8M+DbFobgQgOsljmRAbEfQfRbFnQ0eoCTbydZ7B+eKvd5pcCWyDm6K/XzavykxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oj3NjcrnjntiFxcdRJxvUwGDZ7DbxpG82tRdUCAdYE=;
 b=trMiOaVxIKAZrx3XBvpVS3UH/51Rohhv7UleZt9/ul1LhQxU7bZx82+lOqvcUbnbL0bMeNmjiuaDWmMCHok6Iq7hW+nGSMR/k4OF/LUvSrtBjR1J+qg7QahghlAlfBlPWHcVHPP+th35TK5yKRNIB98uBc+crVYdGh/m/PLv8TW4vTelqHkf0dxqf/kUIvKaluYUwvK0DJuRiikmMNkrRdQIWDsCe3emnzJ20rt34pNCQ70AX0GyNE+7Hp+LQhHNC8/14abMfeiNMcawhgOL85TUfzOM1uQJHVWmN42mfEAGoCdAY6njz2hvuGJVfKr4btAmOTTDwCj0wli/QQ3mHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 02:29:41 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 02:29:40 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Edward Liaw <edliaw@google.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	"Nysal Jan K . A" <nysal@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/3] selftests/futex: clang-inspired fixes
Date: Tue, 28 May 2024 19:29:35 -0700
Message-ID: <20240529022938.129624-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:74::37) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9fecc2-2616-44c6-0138-08dc7f873171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5K8cXpXmU7G6xxId3J9aedcYwU/grlnWk5zou9UDwFiEUyQIOZUrYTh9OcUf?=
 =?us-ascii?Q?hQwIl6cWsud0cANTsiTN+3s09JhuwxME5ZLXHkBocQAh9GtoFK71fOGw8uZY?=
 =?us-ascii?Q?7ghYPNrRj9YpoMieBNRRDDGkt8w9I6jpzLP4DXG4najc68WvFWqWVO9ow0IX?=
 =?us-ascii?Q?SstTZs96Lg4LnYOAWghO+I4rg6zy5VLk9sF2oSUzk5uya9OjpMGw6OA2yWiO?=
 =?us-ascii?Q?hkeJJ8lfMtz8SrIVa+jc11N3iEqy0IOcCsTamMOAjOe3bMd+rBPR1LF5OvOZ?=
 =?us-ascii?Q?SXZLA5n6k/IO4DDmOwTt6VV+H9ez/l88LN95V8622kLrB+7NT86hOaUtCFom?=
 =?us-ascii?Q?Q9uwRBeDhh1q1SEdY22I4btv99V/162Q9hByBe2YrkECkAe8VSfBsahnhLhM?=
 =?us-ascii?Q?7ZF6sqFyXgBdcLw9DJUuBpp78Nr3eSEXNRajkHz+xtKaNRXjAVjfdfieKjNh?=
 =?us-ascii?Q?w6zqy1C133uxMKEPXoRuu0ffNMLjA2u1Bv7aMpnOBHke8gHp9Y6xusOuSLt4?=
 =?us-ascii?Q?APjEWx2pxqmlKU6uyppERWk+MjTGBhJU2T7w7xPIFxIV9I/kImyBMfqKGVht?=
 =?us-ascii?Q?AzzZ3kbEAWfLX0wmDZ/o55fmsqCm2ANecWjyeez4lqhZtkhoIBr1pWBnFM0o?=
 =?us-ascii?Q?94oo7UqpPZ1JUrmECBp4H8ZoWSs75gxlv5HgFKHFdTCdKmGYcJYyTDJftBB3?=
 =?us-ascii?Q?jUoqAKJ2Ar/uMH2r064oFTca/LgSwq8JzZafH/dfC7yEGpSSNJiL/sCJoJDJ?=
 =?us-ascii?Q?DaA3CHWQdpKrY6w2YfFEAQrs31sso+JPMScg1BUtiOCEGxjwCGYBNzHfznBJ?=
 =?us-ascii?Q?XC0/pBGdZ7weUnnqrfI95W2BPdsGwCD6QjBzR6qfER9yQuOovWiR89eE5cro?=
 =?us-ascii?Q?AwvJNCAT7kLkvQ40YLsg0H1wKwiePpaLWChodskBy1lkwhPsJlEz9JNEtalx?=
 =?us-ascii?Q?NSTze70MHgqPncPuSKtbU8Y4F39dsDl6BbHXuQYW4qqh++AYPLo7FG/Ox23r?=
 =?us-ascii?Q?p7tvdnNrP2saS2ahrl8RdKjsccwC+3AVHNsC2MRp7qkgeVit/6ThDEg0PEBx?=
 =?us-ascii?Q?DZfrihYQqF+oKt2dunkAjJvubng1tM2ifxEem7TaPoUgvCBSEpvXh2BvlbWh?=
 =?us-ascii?Q?GumWMeamWqyssKQVU4MuDcsXBhiypWIkClMJE3JJZq7iXoerCopgyeY+eHZB?=
 =?us-ascii?Q?JyoriX4lqShf0Mzrre22z6wjQSVmLelRegCZujNk1g6W23bvLWFh9LlmrXNG?=
 =?us-ascii?Q?Zw3aQRM09BEZK1BuWZz8/uBfgzn0n2x+1/oL6M9XQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GodzjU/wl9JdxCfId7eafz6iXgdQ9jsR7nVawiTjOCMppAagiBYhZt82KoIs?=
 =?us-ascii?Q?b0dKaQ86zYpoPNyXSiwEMwlS6ynhz0zvkzR0S3irpf03d+hMtkAEEbyrIYD+?=
 =?us-ascii?Q?pjdBXfM+V3hN2fIzzz3z2Yn9eslCyjsEs8D0n8Bg8tqE8uxrw2qgPf6Qb+Ua?=
 =?us-ascii?Q?xoDYF4gVsDPHGeeKyznZLmmAbL+TcoT7nyGL4jDwbZo4UnPexvFMbTXXSsLr?=
 =?us-ascii?Q?5+GNJ3WJrZV0t1/MsFLWRtjSAUhDXgknpFtO0vf2cRU52eVdxuhL2Xgzb9hQ?=
 =?us-ascii?Q?Sj9Pzw/8aPtmQsBcblH2b8QT01cmUmRyQg+6d106soTuDLOqhmmQWyyZywcg?=
 =?us-ascii?Q?M6jRRGUgcyEDBhe3G4XfxYcmOMLiqVZ2SGFUUiYcYuqDsSAN4ZYcQN62qsP7?=
 =?us-ascii?Q?Xxx+G9f3/D2EZxYiWMXceZQXChrb3tIv2E0OvU9FOTxA9thrDUFj0lYHNyx/?=
 =?us-ascii?Q?UzM56qrZC5+LmtLZTWRFR3qn2n8wZ/DMhnwGd89Po4GWyVEjjDkf+ObIbkwN?=
 =?us-ascii?Q?+9cyIRJ+DX+VOMsYPjN12v9efCdFHz+P44PGDIm+AuL8bl9LjafWm3yHFq5w?=
 =?us-ascii?Q?HpmTH5Bj/h4yAcLNK+ubT8KBJex0w6U9FvAq44SJGL8pBmCuHSlezkVUwEUw?=
 =?us-ascii?Q?N1rsckp62vU3/0Cs1PWNARyNopfW5E4qudwwmcjxhYpqDA3QxPWrJ7WlYrup?=
 =?us-ascii?Q?9H6BNoDikinmgoH0zfLEDdDN0Cpaw5UqFRzVB/khN9gpX5zxRn+YKA+wsNto?=
 =?us-ascii?Q?ySsDIJ4RozQXxAKg3pQFPFc+nUnFeSFU5gWkzWXTU+piSOslO4/wcwvFoCF+?=
 =?us-ascii?Q?5yYpWmbjYZCFUDdjopHrYRqdklPGOn07fHpsRV/c4xHZMk+kGhJX0Hb1HwlX?=
 =?us-ascii?Q?YZju7HILZ2nyTNptqMdrrDpywk0qmfrsAtCMUJ7GHYnfaR6d8n8baDUpUgS/?=
 =?us-ascii?Q?XHkSAskR0+F/xYm5n/Jsg09ajDgXAvJHLpY8lT6OPAkh9vBO8LhUoptOlofF?=
 =?us-ascii?Q?RWsYIJGx0JyYyv2CrwhnN7CfbmsV3FyoVNPC3Q4hd1RhoGS01nS0E5i3z/bj?=
 =?us-ascii?Q?6nnPUUpdtQSE32U8koy3q3wmKFjZUGw9gzzkbafdE9xnJRGLKqL6pdB/VbYl?=
 =?us-ascii?Q?f7YSCCzdNt2HSfyq1QpthiuEKUYbz/NLbnq9ODI+Uua40PDUKUPiWthsraQI?=
 =?us-ascii?Q?HvO7vEMc9UJ7uN8DBFn6APeF7UMbAmC/pWk78JxJXbz2Dsr8LHyUbOi3qG09?=
 =?us-ascii?Q?fm1W4AXAGZv5JFN5+5YbYDZpW6JYdwnUulbKGPKOhTqrcLcgUMeTlKcINre8?=
 =?us-ascii?Q?0VNALCqgC5Ai/KWLiT+obkxVwTyImH5Co9OpMFonThOmnAPwMyhh7MTMHvm5?=
 =?us-ascii?Q?zMGLnptyYIblrvh7Nnf5bpoo3AZEWVinb++fXw6trVZpS0oD93z7MaM7tofe?=
 =?us-ascii?Q?QuWNpjDKLlLLJznV9fBCyjPb4ufslF6SUl+TQa4uxhIb1oI/oBAOqUADE1iw?=
 =?us-ascii?Q?SvmguFrrjOd5PknYpAuLYy8uxJBVkYvFY7RBuI7It9hxdIltWse653bJcqQr?=
 =?us-ascii?Q?TNnYV285CsdfVK9J+5vhSJxud6ky4iLRKvqHXPWB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9fecc2-2616-44c6-0138-08dc7f873171
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 02:29:40.7199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWnI1VQKlEdR+bHnHVJXGt20WBqPwrIS8hhYsnCFwlvh3AwEZGTRYGYRFRaFVl4pTZWMr+nfslrMYYkbXa+4cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725

Hi,

Here's a few fixes that are part of my effort to get all selftests
building cleanly under clang. Plus one that I noticed by inspection.

Changes since the first version:

1) Rebased onto Linux 6.10-rc1
2) Added Reviewed-by's.

...and it turns out that all three patches are still required, on -rc1,
in order to get a clean clang build.

Enjoy!

thanks,
John Hubbard

John Hubbard (3):
  selftests/futex: don't redefine .PHONY targets (all, clean)
  selftests/futex: don't pass a const char* to asprintf(3)
  selftests/futex: pass _GNU_SOURCE without a value to the compiler

 tools/testing/selftests/futex/Makefile                      | 2 --
 tools/testing/selftests/futex/functional/Makefile           | 2 +-
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)


base-commit: e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc
-- 
2.45.1


