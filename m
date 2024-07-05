Return-Path: <linux-kselftest+bounces-13252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0604D928DF9
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 21:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF981F222FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 19:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B6313AD13;
	Fri,  5 Jul 2024 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U/GWGnaf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFCA176AAC;
	Fri,  5 Jul 2024 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720209473; cv=fail; b=ViNkrb0k+8gsFgrvkjcfZzxtX7jumIksiR/U7Q2YX4bN0BWzhXS/NJzXJPtEIy3iQsdOB7nTH1Ko6kqiPdgNKSNkE/R/1QbbNywhvJL6qWRB9gJMQ0lpVcoSWkqX1fidRT3cIt45J33JxAOFBYdai0kV3X1KFf7xnglZNUYtXYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720209473; c=relaxed/simple;
	bh=KgOM7gYWdvykwtpnFzEWnvL7HJnkby8RThmqgqTn9qE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RVxeFfV+GkgitI91zQCd4HFG1v0YVxp2mS86Y7T01VHpZeCYKhr+7eX+tim82lX028AlKsPmzyhFMcUyr2EDwzj6ZbbI3hJz97K4/ZapJELChx5nlns6IKHWvbTPaO9yaQv2zMhv8nID7/58lSvaNo2GzgCHurGuxpTJozSpvRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U/GWGnaf; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh8pSckblvCmiJewPVSp6lTZXxUyxDsCnMBvmg4oMTsh+n+jbegBvftbh/1HXlgIt9Kr1vACTcx7xvTK2cnNLphS4Bgg12Fe57E4JQad0wTXG4IA2KkqUytUbyhCvSDaDZ9kCZdwU6+jqD/4t16K2lqjm7kK5CbwCUtw3h09JXXCSyLhMsF5Wk8zLaCEINJw+ecEaB1bncheXuMHU9chSrMreBZLvHuFD1H11j0KYaiJCfjp58sxy1jc6M5lN8n6Wv70U4N8qWFCyeCKwvpHq2Svo7I3rJ4yhxN6E19M4UMSC9u9mKixj6HdE6MykWtvhUntbiv0/22503fT5vqc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uy3HvZstF6narTciXqOd0rXy7Fy5qz6rGmUEyvSVGc=;
 b=LvEIU/egW600f7PNkeUlt4bMKYHCgkEAyBIQMYWcGfYmxco18WD1LgwWyqgcil/TidDtbikn5F+JOAwtbjPWbzjUjgiBzCmjVZESud2D+bAHIZWihLA1+3b0jH/F/hqYszDelAvKLN0K8zl0zpKGKGDhEbvuMRZyC3CnuMiPHhAwD1TkIJClyjRnvJTfWw29d3IoQIBirT83Fdj7I3QaiXWh8sKpogC9Nexnf8TacqbG8YGQBL888kirTjL0gww/dQwlxokVDRKl4Qh//NPs1IRZMGFUQZ6fnuM4ahAvLzC+VNsnzyyvqnB4QAeg36U9eS/F5Y7qnX20qESy09/cLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uy3HvZstF6narTciXqOd0rXy7Fy5qz6rGmUEyvSVGc=;
 b=U/GWGnafAmT6cOPmUOF9EWJTWO3ak7e2m+mY4/D5T5LxKI/9qQzIComDJWWKJcXOwPGI0y5PDHXw1jB5JyPZTXZbOEwID8j/vuP4VamL5indORxBsrr8qNj/aMRZXvrjNsSovU421YTPx71+I/C8RahgfhUzeM2NJxBk1T7deiuUGktlXQ2y1ER8D8cbUBriyqfcWA290CaW/saI+mKjlXNdjVcSDkNYMOFWCq1iJ2uxcbRoTDfzOhH+44V8RRCDTO3b2X51CTxwfSiZVk0pLrLX2KiADYjHz4YIzwPPbML4BF/R3GknmCwNKA1jH3HZgZSwzo+s+EvDuOYCN0cnDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 19:57:49 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 19:57:49 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Andy Lutomirski <luto@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v5 2/3] selftests/vDSO: remove partially duplicated "all:" target in Makefile
Date: Fri,  5 Jul 2024 09:57:35 -1000
Message-Id: <20240705195736.34039-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240705195736.34039-1-jhubbard@nvidia.com>
References: <20240705195736.34039-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::22) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 240d07c8-ab23-4736-d0e4-08dc9d2cbf4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dMciZYzQl/7NSSFQoGTul3pzu4gxJleyfKQ76gKBgc+V3jLlNOq0g7jeDJad?=
 =?us-ascii?Q?//f7LJGjslfoOWoOuRfSMvVDwvK423oFGT1dRm0uqlHc6qNZtEXNh6xYnNh/?=
 =?us-ascii?Q?Es87WdsDcXhLmtQTOP8ANqF84E5GgaevMJ67j7NQkJlazg8kT8UoWal1u1ZY?=
 =?us-ascii?Q?8yi1Ymdzp/XX6MMrO/MmXg1z+aJ7EQ/xrm+Xe6qw/dsy53L7s5TKx2xwo5cp?=
 =?us-ascii?Q?G+L7BdbFtDSLzO5UyOqACdUZBxAe2oM6udPA7Rl3jQKs99oSWFCphYU4ARxy?=
 =?us-ascii?Q?Au3xVc/U1i4S8N1o0k6581RtkT5ZFMET0WSUjKwXYgF7mOKfoxYmhi0Mr/Jc?=
 =?us-ascii?Q?5xyjKZf5VtkSvonLbjRmQiMIb5AklWCL87czxcEFOy7Uxq0CYS1gUw9qoZF3?=
 =?us-ascii?Q?dlaPf1CiOS8VQ12rCRMpllpXX8ELzDvCRygc5+NryFKxJzG/3ABcTPdDXKm7?=
 =?us-ascii?Q?BQZehMIord/82P9ggIepfn0lk04C8DWKOHXXamUSMRxBhOk3M3M8hUpbkqsX?=
 =?us-ascii?Q?TuUhxl37HrM65ywcZZ/XZBFiZQXLUfqhfIJWfWWZW0HkHG7zUWrNbNZUzkR3?=
 =?us-ascii?Q?haSKIAosjWNg91YZI2FNGi7N+M5KD8hBpqfUqtUitdDr35GHirASYuOe8qZ4?=
 =?us-ascii?Q?ebocRU0nsZeWYVrd2FYCa/jMScWIfkjPW20hg7u1vSVOG6p+QejA9bucSG7g?=
 =?us-ascii?Q?4C0KhhxuLNxh5o348az1/ABzPiM99O9ZzTBzSdP9EyShqG/c4G7XwiiSKGRr?=
 =?us-ascii?Q?uaJTsZPql53vC+t+vgkmvAdRq4jZUe6xWm2b2PMr5Tjk4uCFdutqTdlKAlfc?=
 =?us-ascii?Q?OqGu0bu4HKb9Dqumpn/H4AHPv7jJHryI781jdvJifxXB9qFfsR8F5XFxeG0m?=
 =?us-ascii?Q?5kniAVcTU+jqFJ7LWclhbQIW+77T4nMHKO0EWzZ8JuMbFTpRkEmeCr2F/05L?=
 =?us-ascii?Q?R2yDTMEL2IwTI4KJXkoeSda1MWq6JRQm6WbJphUleuQYpRXWU2egweYJljpi?=
 =?us-ascii?Q?OAICvJ+LYqF0Wjyt+EZuYcFlaepOjQR9GXXxOWQfMjp5aSK0lcF0yFdMh70l?=
 =?us-ascii?Q?ic33/4j1KbRN3qhP8VomcYiHKKDzMpabn2TKwfc6797l1+t/+osEm12T5+AM?=
 =?us-ascii?Q?80Z+0SAaJ9xlVVpiQU32CAquTfaIlSQj0RqUTBITeJZJYIsQVTukE3lQYYRf?=
 =?us-ascii?Q?RSKKhafDYfdeaz1xoMIHwCW1Ovdr9+Pt/HJVctqCDnGBYX3YyKcEYFapQpLj?=
 =?us-ascii?Q?6nFMP8ZBcgidgB3Z7HsuRbGV549kMf5hPD3vyBk8PRuwIuHntzZqa6RIk/4e?=
 =?us-ascii?Q?zNl0ZsVlU7hISheCLa8vjcF4gmgbSg7oPgx39t8hGSUB9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5B1ZSCwbKSuUp9AYA8BI171SLXFaJgfEnOF3FXYwojAAEaFmJyx3i2QQem7h?=
 =?us-ascii?Q?sJnUR/GFh+RTvU4m1WaESLjujNS/yfrMhOBijldl/LgaQGUjFEi0kX0y/PHa?=
 =?us-ascii?Q?FrrOyYIFpqL9Y3J5wuTa050sXcSXnFX93AlptuXNuqYp2xc2jP3iGVLTvfPb?=
 =?us-ascii?Q?1PaJRl0gO84+2eZkHctI5KpzPUmxpiN6TI/3C1hLxoO5dMcucpvDIHEw0o6I?=
 =?us-ascii?Q?Tsol1ORQdiC+Drz1jup3Mqb21HzptCV2ovnFuVZhaPNriT9c0haH1PbLKX43?=
 =?us-ascii?Q?C+xSYRyqlp8CortRHURT/FqJ2G3EGCEpxPqmcDyQCJ2Hye0giFLJiR7IfknZ?=
 =?us-ascii?Q?kKVTsLfl1WJuxsJqqUWpxPGWwcTlUjdsUkKg/pgCa1CAm0/97OiE9rwAXg1C?=
 =?us-ascii?Q?JsCP3kHgeqiryGtF52qEydQoeNpo9VonmsLYxTiWlJrkJ96d26bl0speuhjC?=
 =?us-ascii?Q?m/apOOq7h2U7TCIvl1HzlB7u20Xvucp5BdI0rMMFqkpadyAh5bL4prJF8LqS?=
 =?us-ascii?Q?v9VnV4DGz3M1QXoNhytLckrfkaRAFKxo1tVL3nmPGvJSVcrElnUbtvqSk0Ey?=
 =?us-ascii?Q?w9oWc3dyaITVXAUmJXbEDtK9bDzwok6lrtYSGsekYdKEcBYxSA/RmKgkEq7R?=
 =?us-ascii?Q?QGViFsdZQuooE4mlyplR1qSGfvHHRsrKHm3JXYT8oVgPedN+vYKILrfvkTEC?=
 =?us-ascii?Q?2+hHfykcPwnGszyUv/Ki6/QRsPdR2rgjEFbLilW8fGkOJML09Z6hU4Y+jOTK?=
 =?us-ascii?Q?kwzr5GKOoqK3WTEkf1QHkZUmuwKZnwtCHjDtcYzEZqsf66sGi1vlJ33Sf2Xp?=
 =?us-ascii?Q?Qzy0P+ezXEiUEQfW79XOWViH6XE3NjobY0r1Qm7nZzhQeVvQ6KWZQKafV17X?=
 =?us-ascii?Q?KD+N0+WmD65YuAV3zG8kftYfWKVKgBk3mTGdTlm35OguLwMjF5lQnuTZ7+IR?=
 =?us-ascii?Q?mxPLnS3Y5hYMlM0Dir1QY1kg5xEDGaUPvE2+IHcUwM517WglBGoN1k2lhL3V?=
 =?us-ascii?Q?IRztDRODx6OTZs+5z+HBouKeW0AATPe4P+kG5SEgVk/r+1HKmGrX8FtbNsdg?=
 =?us-ascii?Q?JBZcim1vQNwV22nexUdLHv/UVwcyi0IUZtE0qu68PLbF8cE0gyXSi4A/zZKg?=
 =?us-ascii?Q?KmWhk33MGd1X8uq2p6JeEUEK8d5QvjCW5W8s2Q4ilFbKhsW9xlc+BLhZddiV?=
 =?us-ascii?Q?8wYaCKT4NDWQTnPDANvRdfR6Q4JzdiQqjlTOYTB4bJQBgQYh4olux3hY8qD5?=
 =?us-ascii?Q?FgwdWAR/hURbveBA1SImAukyikx4yl0E6LED8wSz7vpKPpbRS+9zjXbaBhBZ?=
 =?us-ascii?Q?kR5eVrL0qAJeK+2Vb+MFll/PkaWieDS4lTwnt8008odJuv+MLmFBuYSYNizf?=
 =?us-ascii?Q?jW2lJRAlZckqXW27iZS3e3oRBL2zlvgTQGkO6oaGc2rP38Xld3sRKwS+twmj?=
 =?us-ascii?Q?sbMDzWHKLerClR62iQ2tFX/43Dvk7G7MZQiRMOMKhW8VMPDtGCqr2cxe1jlF?=
 =?us-ascii?Q?gnmAlhH74Qm3ZQSFhDXB/WfMtuwUg+kqudWkwfS9dBL/5jZa/kmXlnrMt5A8?=
 =?us-ascii?Q?Cgj0QSzydsnW9wCWbGafvjl39XszuMq9YGBfU6k0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240d07c8-ab23-4736-d0e4-08dc9d2cbf4b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 19:57:49.4188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWTjGRe5+agOQ9hr+Rz1eebJRZBRnuJpXhBsojujKzZ8hlSZPrM6pZxMh4WvEbanHxPJXmuTvDjTq1r/i42gew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877

There were a couple of errors here:

1. TEST_GEN_PROGS was incorrectly prepending $(OUTPUT) to each program
to be built. However, lib.mk already does that because it assumes "bare"
program names are passed in, so this ended up creating
$(OUTPUT)/$(OUTPUT)/file.c, which of course won't work as intended.

2. lib.mk was included before TEST_GEN_PROGS was set, which led to
lib.mk's "all:" target not seeing anything to rebuild.

So nothing worked, which caused the author to force things by creating
an "all:" target locally--while still including ../lib.mk.

Fix all of this by including ../lib.mk at the right place, and removing
the $(OUTPUT) prefix to the programs to be built, and removing the
duplicate "all:" target.

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vDSO/Makefile | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index d53a4d8008f9..209ede5de208 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -1,16 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
-include ../lib.mk
-
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
-TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday $(OUTPUT)/vdso_test_getcpu
-TEST_GEN_PROGS += $(OUTPUT)/vdso_test_abi
-TEST_GEN_PROGS += $(OUTPUT)/vdso_test_clock_getres
+TEST_GEN_PROGS := vdso_test_gettimeofday
+TEST_GEN_PROGS += vdso_test_getcpu
+TEST_GEN_PROGS += vdso_test_abi
+TEST_GEN_PROGS += vdso_test_clock_getres
 ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
-TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
+TEST_GEN_PROGS += vdso_standalone_test_x86
 endif
-TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
+TEST_GEN_PROGS += vdso_test_correctness
 
 CFLAGS := -std=gnu99
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
@@ -19,7 +18,7 @@ ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
 endif
 
-all: $(TEST_GEN_PROGS)
+include ../lib.mk
 $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
-- 
2.40.1


