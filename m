Return-Path: <linux-kselftest+bounces-11080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802418D6D62
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 03:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0261F22FFE
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 01:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE16A943;
	Sat,  1 Jun 2024 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hUc5l4oM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999B81879;
	Sat,  1 Jun 2024 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206342; cv=fail; b=SCuY2UMDeRrXMSbQJ65CP6ixkwD5l0F7UlslFf/sa0K3JYX7rxE9tFgOGK+k1vt6PxpI/GExYQxHqdKA/7lTbKOYrqi1hnD7hk5WaKVO4HWcMcgYSYd+yFnek9+iQ29kw8e0T7A0F6mACqdmIhAK+Ie1xrEKKC6SD+l4akwRvUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206342; c=relaxed/simple;
	bh=mj97Og7Jj/96BZx060jUHADJEw4nGYkMeSyeMXF1SwE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iBBYh33k4bh6lJnOzVpXK04A3PzQWDJKz6tOaE93cxP8VFoPDseuKQgCcnhxLmdvV2RQ5xZuwi1SbfZefqa3IkvuTCtblbkJctYEtni1WHAULM6iel/B2o0Acm4/FxjDrXupEUepOX4yjpJnOE9+biV4nDUo042F0Uvo+bt4z0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hUc5l4oM; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSlm7zyVceMPOX+bP1o88vJUIGC9NpTKEZQwqSIu67ruCk1i2/Z5eyO/u6tBAUb7F2Ylbof6AKJ+A5HOO1KMQMTPb2AFN3/N0bhJr3WESQ1Gxgu72G5L1wWaMWGTbUUkCPxkDKzR/N7kiwpSOpGViP0SJ4SSuJi7xm+9by2yyVop8AgPdL2el/bjzEYbzcES3H++7ITGD7WhYyvdTdN8ntChfJIypG/Xkp9ShRIJmLORjsKa/WB62p+y5sEeu+IhkQT49zbQw4sHoG0DJ780OjUijArnLyOaE6QytvcPITPTZmIy1SjMm9rC+uo8FCnfNoFsQar/FxoxN6EpnYMvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DPE/RtnAmKE6z1NnEm6h7F+o3mNDtDXZbFghHKFd0A=;
 b=gP132Czx7iMtP/8P4nTqzmlOp4tT9LhO3+kEqX/cfqWkS5DIBlmfn2NAC+neJXHgL6P9N5X5NP/LcyMjh5eykhozhH6r4i63pfz3mn139LBf4rroNhEogxGd3D0cq3zZiJC2EVvBqq5o1xfd9V9w0A+RDk3vx+g+YkO3xpabRe22VFHNrJINDLI/SBXrIrLv9KCXalYHQs61UzQuR3lQYYtE7N/mr6SzWOKNvvfA5XQfXppeFvNbDRMxjf5a2dCDZESF/Rg6KDMw4pSDrc/IismWfiGWNzHeQ/1qG5TJGYd08qFe33v6HzdethzTvZRtwoSR9N64A+UE1n97o1X2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DPE/RtnAmKE6z1NnEm6h7F+o3mNDtDXZbFghHKFd0A=;
 b=hUc5l4oMGFVa/iS6bfCV8d9LPTi+5IokKpGZxxXm3i/68QNoUqjYFo1axN7CyHhPlt4bUvOUKD9/VBr36cjwmjXXsEeI0RLXB9H5s2dW0pFTSYZBorwjeiMDpT4yhwDni+r4QqYu/THoDQDkgvPNLrK6hnyLvPwEUpU8Z4jLphr5/QxIjOPFGwKc6jzvCaH0OXzKWBKzF9PyuebMG0DexvaYYHCsJdi+ggb2gmHr8+bzbQc/Cmb8o6c3US5ZEPVaZPCIDCcw66ZX3ygrwsLdQYr6Avx/GnSdfI2WBD4aVAy6S7PKfnq9c66NaFo9dq3Tlolr2z2l8MXzhgQ9TeENiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Sat, 1 Jun
 2024 01:45:37 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 01:45:36 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Alexey Gladkov <legion@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/2] selftests/openat2, fchmodat2: fix clang build failures
Date: Fri, 31 May 2024 18:45:32 -0700
Message-ID: <20240601014534.268360-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ca25d0-57da-4ade-4b54-08dc81dc8897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ZwonbHz/ELD0jcEScCJcuAs7lAs9dhe5fovNI/BxRAX+sIRV82PrKKYptYJ?=
 =?us-ascii?Q?m0ssJRysmMluebAc9tKttoDCXsG/bxo3NGtOa2w41BeFAaAK1ru2bMeTE45h?=
 =?us-ascii?Q?hPRsIKzwJ53BDE+fooCe3Dt29dyHtpudcYVlzbInVtTcs+EgGrEk0qkD3DFa?=
 =?us-ascii?Q?NyCeLOvsNh8oR+IbCvVcG8XFBwNZvHwPk7pDPojwaY68V+dRWfp7R7LksOdW?=
 =?us-ascii?Q?GUSbzhMwlPh5TIWT1k4Bagy6Zw1DbeoDa3mH33URz8hpTbW84HVRhUbCDoV/?=
 =?us-ascii?Q?lW1sMLEDFaOh+Dr2upM2Mlh04HHd3bpPY3SBTyMqZsXYccXiAGbf+XAwOj3M?=
 =?us-ascii?Q?4aQU66spoH0oT8EHPP+2lyGR0eSs+LnM3rX4H9xb443DOTaKO7MjvXigGT9+?=
 =?us-ascii?Q?5o6YsOwxkPTGtuPeuEs0z25mx80gChsk7BsNpVAttJEVSFBbTB0sMweGOOyu?=
 =?us-ascii?Q?uk2f12G7+CP4iNi3MsOY1HzI7zJbHmgEbsUHHXqZXGwUFBa0ia9QcGj4c2pu?=
 =?us-ascii?Q?ZRsNkNYRitjnjrdWUDYvxe1FQkbbLeugZUzT/dYuPtP4XvbKXk7g5Jn1u/WF?=
 =?us-ascii?Q?n2XAKnP+sBS6hmokofcLIVwEFFFDI/Wyk3vvkAemu0SCT+TQYUPpKjkgZ+YC?=
 =?us-ascii?Q?Ew/SF0wjyWRdlB/wag34kyqyVqNk6bPWODudt5PlOD/qwyliEAu6WNenF9JM?=
 =?us-ascii?Q?p1ToKtgdIqhy6oMtrgNrp4r5lysgo37xUsWELlEDqFZxHPegYyJajdY9vNIo?=
 =?us-ascii?Q?yx8oWajxm1NbtdRUYkztN5XP6fffA7vRal/U3BlSa4R2NTe5CqpXJXivzUZi?=
 =?us-ascii?Q?WtB21g+LHV5HwhTwWi9i52/xIFzNT0zFvdBL2gisAWk4l860w+pNfG76DiNb?=
 =?us-ascii?Q?ugtFlcALEuXb95jhCv7yb2jT+ijk4WKyHxLnygzWGJHg8P6/QOHnin+OsdSG?=
 =?us-ascii?Q?Er5Z/OrqpMmFLs0MIMdJ1B46CZBp1ErYXGG6RjJBBmvEMvV310F+PLn66C/O?=
 =?us-ascii?Q?7flB724qnL3kPvOddefJ7ej63QHTDuGarIREbRHo+eQRTr8IukZlo/ON7WSf?=
 =?us-ascii?Q?acIPIUVx71HxgW4mzIIO5EwVJ0934m8aQRfY8dZHJKWB7LNLbUhGl3UdU3M7?=
 =?us-ascii?Q?aDeE+Vvyz29Br61dM/wx1yUHYP9ysIMvMGy3D+fBW/MviCrW9r2EdPvBquBH?=
 =?us-ascii?Q?7fkcGsEvVk2JOOOAbfXczPS2odM0SbHbaJx4WkL4tzp7ZcUG7fjrWarmToGp?=
 =?us-ascii?Q?iLaRUAQWvaes5Dt9b6I/5tQgHmvJowbAsFcV9yQozqsUdZ+P0I7XAdagq6w3?=
 =?us-ascii?Q?Pg0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bzGK9NMaLFT3ygmBA9P9TMpDKNFcy8xxV57cdLn5W+uhQd+sXLa8Ww0Vnecb?=
 =?us-ascii?Q?X0AFRYn2QeRDmsx33xZaj9Jz/N34svRiMrtvSY1OPGTHfAI8lb4M5J+gi3lw?=
 =?us-ascii?Q?oZzb9GUUSDINmEIC9JHD1CaW+ERQZvlyD+XmuOwmgjPnK5gXAuM1/affw/fM?=
 =?us-ascii?Q?ypgJwMeCLNkuCgK72D/HyT5yWux1DH8W+xITkjlbpU0ustJd/lUiCDaDxzd7?=
 =?us-ascii?Q?eBSpf2YRs2Qyydzt2g58W0Hiv4g81iTApeJT+qMWHJP9oaOF1WA2B54yk7rE?=
 =?us-ascii?Q?dVRV6INTj2SVBBohlXWrp4SDKhWodCO/0YBNIwVKtMMqAuasYGUjwMZrYVnu?=
 =?us-ascii?Q?mMV9xJslkjzX7rfwNhVfxIIm21ibOTR8/zZYai6U/HqFlxrUy7vSJka9rtOI?=
 =?us-ascii?Q?VijpyCp1cCreL+f8mwDKfbutrWw4R0GQmaQvIDYmGXLDZzt2wLTmsMV8OkBr?=
 =?us-ascii?Q?6xO82oPU0CP7HgyYDwd8nNskH9e7YeWOyXBXbom5jZ+tzF7fyDYnB6Vf09lJ?=
 =?us-ascii?Q?piN4Br+irKA6J5iHONye8bRnADf3SPyMmK/uTBe4XcegVtKQd9+WyFsHqD97?=
 =?us-ascii?Q?9ygvC7Eb3MT8hqsczkX0M6dHjzXACSAcsvhiZuneM2wA6FPa3/euDbFYEeWr?=
 =?us-ascii?Q?yWeXhzW0YNXD35DeZ79G/Yl21Rs0/xN9YrNnIx/ayeTjJylN50TKC1mTJiMs?=
 =?us-ascii?Q?q7ljrzoGZQRDaPXOZ+zgYjfxi6CvKL+VXI/f3muwAweF1DpPcqHXCDrOiu3u?=
 =?us-ascii?Q?dmeUG6J7UVscR1qtYqMYJlpwWyZ61l2WVSX84dwmAVt+uAfd6c62PAXNpd7R?=
 =?us-ascii?Q?FiX2nWnwhxMQTUvenbaOClh79C4sh4XgRGSuojWf8DUktGXRHh7GGlC4AS4e?=
 =?us-ascii?Q?RTm6Hb+IS5TKvE1CrF7Aq+e/IC/wsKMggoTvzNuUCh1EX0BZDsvvMou5CsFi?=
 =?us-ascii?Q?N1fGo8dv8A6+oeM6zWWcM4qgeEGy7jPc4UF5DiEP4hOL28UI556dUY3Isd0A?=
 =?us-ascii?Q?LFNHsb8S26cann2FJnuI6d/4WVDlAPAdn4CQ0nxatXsUOO8s3PkoEiZc17uT?=
 =?us-ascii?Q?OEcjDRqdZlRdF3gdd67UscDpD03kKDiVDP3I44T62wgduNT6vOyRyQKrJUJn?=
 =?us-ascii?Q?ePkdT7+IFotZ545qk0j2sOFIxj9kBfliobare6M8EYpUiMwUE0jspxQ1D2th?=
 =?us-ascii?Q?5hNx7Y2t8qsbLU+0UolGj4YekY2dQF5Q3pI2sIDMtYhRGs0jR3lSHSCVhX/6?=
 =?us-ascii?Q?f4G593udEVKKLTDuKoNq+hJ3dgtQ8ssyojRwW1j602u8EbOo/xSGAAG5Wpce?=
 =?us-ascii?Q?pVK+E7DdXhj/LW0TKBUgvY2mkW6v5ff65P+N096kfQo8a7Vog7o/AWESgaRC?=
 =?us-ascii?Q?lyq6jZijQZi4W00+bs1xLW1ixGY1hSTPa22AmwrQd4tbpv8HNfRbww37tvzo?=
 =?us-ascii?Q?vDVtiEO8Ed9ziAJ7qWdjhtkLJzd8y6VuQye8kvvPcqmOiSS4oI3g276j/Toc?=
 =?us-ascii?Q?GnNiz6Hy0d5+05er97JFfHOCAooJb5Ow68Kg8kZOYcRHUkU6I/LOtebe0E09?=
 =?us-ascii?Q?nfFKBeKqBMLFbfZoDg7c7J4TGyGZnN6ytl5o+OYm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ca25d0-57da-4ade-4b54-08dc81dc8897
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 01:45:36.4973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znJL8h1S0vAqK2Yj4eHA735P6LAcHm8AbvZ+HjkuTWlTXjBZZjrAVkteNpKgXgeFWxLmiCiQuzOHmFb/upgEQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931

These two subsystems require very similar fixes, so I'm sending them
out together.

Changes since the first version:

1) Rebased onto Linux 6.10-rc1.

2) Added a Reviewed-by tag from Ryan Roberts. See [1] for that.

Related work: I've sent a separate fix that allows "make CC=clang" to
work in addition to "make LLVM=1" [2].

[1] https://lore.kernel.org/518dd1e3-e31a-41c3-b488-9b75a64b6c8a@arm.com
[2] https://lore.kernel.org/20240531183751.100541-2-jhubbard@nvidia.com

John Hubbard (2):
  selftests/openat2: fix clang build failures: -static-libasan,
    LOCAL_HDRS
  selftests/fchmodat2: fix clang build failure due to -static-libasan

 tools/testing/selftests/fchmodat2/Makefile | 11 ++++++++++-
 tools/testing/selftests/openat2/Makefile   | 14 ++++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)


base-commit: cc8ed4d0a8486c7472cd72ec3c19957e509dc68c
-- 
2.45.1


