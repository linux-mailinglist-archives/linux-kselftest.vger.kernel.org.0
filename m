Return-Path: <linux-kselftest+bounces-13158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F1B926DE0
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 05:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9491F262F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 03:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5758617C67;
	Thu,  4 Jul 2024 03:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dh/aJWs7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E88175B1;
	Thu,  4 Jul 2024 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062302; cv=fail; b=SKCu/8759HqnmGJk10jZqHc36XHgSTrkdZNaleUaby/1iQ2itopIknHIE+A/80ZGrrPLjjvipDzyXzv5pKQDv2jojI8ZOFvAp0AVHdG16T7Pcb50OYj5cmnBEmHDNxYcB5bnLX6eD45Ok2vKF09qoGKiC5w4sj40qgnXbE572MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062302; c=relaxed/simple;
	bh=Y27pLsL95pF5m2g2dnAabz/YovuOmtTZu8puMSd2kuo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Grcvoi7ob1lPsN33U34hBWmyAl+7PFEDTR51Kju1XVnrx0/2jkah+xecjCp4ywv6sXZPexKQXTJscqoVQTRW4ek08Gc8VmBjThUMfmwFVbLs+fgpwj+JEm0PULqqvnVeyScdaNgC7GDvZjcwnddtaOmxrb7V6lNtG/gvJCXJJtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dh/aJWs7; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOJG2WZOzu5PMnkuBOBj6qJpmMxHet72dwd6q/GOHzxihEB1ryEj0p8ucNEUBtrn+t0ArY5Zp7mfh7XDPEnQ/CVArVeIcGq1ZU4lQ2LfxJqWzjPt+5lj+jNcRNVL5nHnzWhCMSWG9L+lK9x27W80F55s70+pTXmWik9o01kFvB4OOPGbQCBt/BoCNmtpp2F+/lK60NJ6HSfPMFmUSeVLLP6334nvIk13+a/oMAJvXrMz8yJIj82zZwgnZyr4+sNGJUrrF6pGnKPZ7rMNrRZK/nY4OhF4zIBeIQhjNMsQitXWQjZ3ryx8LFyhmRGXjeZANVtaC2t322I92DUZEoYvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFHbl9D8qMr45+ALzdp7g4/7E5Z5bh9wmzW8XnZrKDM=;
 b=O9x8buH2u3EKYJYCZyp6xjABC57FjSMW26EPWQwMkNzkU7nsdB2q73gzSiQRSc3kpy/pe0Dp3bM+R6t0JcaFayl164Gv7c9TzbXDUeaDmicejANrbmGcsuG13qbQMq+tPoXcImTkOU1x0JjT9+a0dAK9SDRvkz9foStGIjaa1cXvpDeW9ir3A5yDv7o1K9KqWD4lAIgG6rY6rRuty/m1G0XvGwU5n2uXPlUB19WjyPLgzu/PHWCeah5Lszmr4TVslE4gNg74A0bn8jQmLs4RjlKQ2MBZZtzCS2ZkGccZuVbgpG25S4eB0EdccHUZu3p1eHnLvW/vvECBwxY1eT7SBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFHbl9D8qMr45+ALzdp7g4/7E5Z5bh9wmzW8XnZrKDM=;
 b=Dh/aJWs7EjUr0OHegp1/71W7HXKCKQvCL2ciu8N0bFVzT7OOymxO5sFw04nuTqCa99/+yhmOZIJpDn8hTf8pKMjp0Hc3LDC4TmXe5+xkqXhKhNTebrnb+x/US5hnrfISB2PoK6xGojBR6Q50quR8tGfeeybLEkkS96E8OFTsYxQDgWt1IlCkxLLb3sahqrRaFW6opcORAyRAu4AhQ0CpDOLuNTslLjM75gGK6/5bZdKnA24PT/fERi5I04BZm5JXrXLI1bdEiaKkVuWGqbvwkeAXKtEfGAam4xiBLshL9TPvpYJXL89qWsjLZcEYYeoGvNEp/jWs8gEC2mT0yV/t/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 03:04:56 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 03:04:54 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Justin Stitt <justinstitt@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH] selftests: introduce and use SELFTESTS_CC_IS_CLANG instead of LLVM
Date: Wed,  3 Jul 2024 20:04:52 -0700
Message-ID: <20240704030452.88793-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::12) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de357b5-0bb1-45eb-4586-08dc9bd61447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0QQdzPrVCWDtAmi/v63eQbP7Hc3G6qLWjo0IiZxnwCg+kNw6YUdY1CJiEl7W?=
 =?us-ascii?Q?vcIG0Y77id/is8hnTh6ALZ25wb/7cpAMG4dNHXQt1La8th22W5Vfqfsx3CvO?=
 =?us-ascii?Q?j6nJbqp+8VYLnmxuF3cz5ez85GRUNnFXCfSHplanskwDRsXXjYpb34u/gXPr?=
 =?us-ascii?Q?mE1BsTRbZXc4Ak64+C5wf7HFvs8+EG2M2KoiKl4W23MVkWFXhY+M/mCOf93f?=
 =?us-ascii?Q?VR8ogh2DBtZK+BD/zmmb6cguTaKWtctlufb3B11sGiCBA0ND67kQ1JPWbPm0?=
 =?us-ascii?Q?VkYx/ar3dlgAqD96mOne8PBZyuysU4qKYHeuQMmqfylQ8zhp4HZ0GmmgUk7i?=
 =?us-ascii?Q?wA1f1AjN5gjvxxIhJCzXytbsOV15ov8NbV0orEzhxGW3o8okIR2Ae9j2RXpi?=
 =?us-ascii?Q?6XzQaHpm0YR+jMl1Xfv9376EJXoIU8dAtXpYoauFRjGBr63WcQqc2/CGYVvG?=
 =?us-ascii?Q?CnoXNrx0r8aIEqE4gjaR6asmqfcfWmnhajJ6pin6M4mEGkfN05zdmmMEjA3x?=
 =?us-ascii?Q?ZIjNLfGklrQPn3HRNcD5FMr+9vzfbEfx/LsZNL/DJN5c7kPQWRCPB//tMfH6?=
 =?us-ascii?Q?lzvMBWwVoH+I1Xym2tVMEZ/qB7l5ZqOvc+JAOIa0TaLuf2lAMFn2uulKYZKX?=
 =?us-ascii?Q?CrwXdXxD4lQAwEpae/w7V4igBuSiSTXbfUvZAIWbjumksOfeN9HpPTUjKwr3?=
 =?us-ascii?Q?LqZg8OSj+UKXp7SpfSePLuYmRjPI1ea0zWVvsgRv7IKYn5r7wh5rGwZG4kOU?=
 =?us-ascii?Q?vE0M/YmVrxpDXvGd8xRjw0Jn8YHsJ3HefJjnSu5648+zvqQPo8u6Ft0FBMZc?=
 =?us-ascii?Q?kDtSYXvBLwXIVTaKE66EuGfcGfM5mi69pW70nEpCN22l5gdVyNxQEsACg8KJ?=
 =?us-ascii?Q?iTK/RAjwd1IwNsewY95I/cxlpHmEcJxCP9c2CIpp72vzJKiN41CQytXqg9fb?=
 =?us-ascii?Q?Id7oNXN/Ynthhx0QCTD3QnD52AU5cHC00GfmXCj3RgvSPqnIdXzuuAZ2iv0O?=
 =?us-ascii?Q?wbRYmDJSni8Lxwh1IMFUny2XwkN1GnkJqES746/Q54Kgue/kl2Gub5j5W3V7?=
 =?us-ascii?Q?54VZGOOJhIe1dDjI3MJhgb4fAkdNQ9/sLVuSaJ5L/PtoKbdJsU+yKz3oHEJ1?=
 =?us-ascii?Q?i0zuaQ5G+QyWozGStBwC6hyotDspNr8Ev/Bd/b7ZiwX8XcoIA5c2QRAjDRmk?=
 =?us-ascii?Q?FB/2V0nAdIt2Pe7Hes8UuHpb1UG4hl6GOA/R2ytBbpKGnJ8ujPM4ksV2j/Sg?=
 =?us-ascii?Q?iN7JT3AFNOpeys3R34aswkbMwnFGlwKwladiF8nFR8MIDkOrxHITuly9ikFa?=
 =?us-ascii?Q?uJViz/7LVj2p4O/BGG/6WqlgW54cMsr9Vhuvoi+HrvHn3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QTVQviBEdXx0tkepIQzSvmnTqOw7FmGWHK1lN3dMSwCUqACo+FcBcobR8WT2?=
 =?us-ascii?Q?9PDogRNMgsDC2VtZxYd+1QeHrD5qk8ts7Gh2uMEbjHhq9R6YGYbaavI4wyfu?=
 =?us-ascii?Q?ieEgrYViS9bngUXhy+Xup0ipINEGvvriLr9sEUBnXyNKiSbFhlJVHPA264n2?=
 =?us-ascii?Q?G7bQUIUk9f853Y2nXp9bVxwJ5+k7W+5GbOz3kEGQsIH49DexZ30y5ffa9Vri?=
 =?us-ascii?Q?hKUSaU+Q7kW6haWaUQgL6l4pzkPTA8jo1l7XOv5CQyyaUBKGnz05cENLRevi?=
 =?us-ascii?Q?O5xC2zUQXMWf7kiNfi50neAkybkrCberzRi0+5sOujrPl9Ckb5xVrKfTA4dz?=
 =?us-ascii?Q?Gcr2yTOsBL/b6rjaoAjVlrpI1z4bWT/uxbhFA/Bhh31kTwFC+RighsgKwuy8?=
 =?us-ascii?Q?o2JLYPAvm/fdraW1DHaiW673cMEf+2YR/fDau8qUA2nkCfGfEwi6MvUuzWvU?=
 =?us-ascii?Q?UXB5YmPeB7rco0FVoso70A4bsHKlpNY92ZcbXLfpUZ066F9kgxTo3gH5fW85?=
 =?us-ascii?Q?4lC9kPMfVkJvbUWCKbQSkcoju8GlVqSyYgGhxPkq9+NQ+Q4Y/vtybFeiZaU7?=
 =?us-ascii?Q?Qr94ecIbXRUy4fvZ3VK/4acSUYil2soiAUYkzJfs0e668+WDVkZ47US7Fema?=
 =?us-ascii?Q?mWRYoIzXvAtr39wIAn8vZFV8cNIAJq2fuGsi4N3U74eI8tfU6xSffg8zysXW?=
 =?us-ascii?Q?goe5EV8S0VMK4tdKkaARO9/uo4B7TNaLiwTpAMjVQeCUY5Vj86bhju0a1e7w?=
 =?us-ascii?Q?/HUO4jaoWf92foN2nmO51uM+1645TRbrzDnnSxYmJw/LCOug9DG2mfyZA3JP?=
 =?us-ascii?Q?czbokVVrtqNEclgos0gpQAQpdszCSUd4+42DM5jsPCeKqUgKl0X4Xe1ZbKt2?=
 =?us-ascii?Q?Suz8lVVHhyLYcwP7LfLk9HQkiD5LI3PTJdJzxIRP/dXHOo5uzz3cz44ep2Ba?=
 =?us-ascii?Q?WTuuxz44W0b4rS1985ZQuvJrQOcLvxrOqworspyZbQjCR9qEtWYvbn4ZOeOd?=
 =?us-ascii?Q?IyiRcSeX2Utun4S18arIYaALv0rEvwvNIJ2kfdAdtZ49YlzD0mW3jUWPBEcI?=
 =?us-ascii?Q?0EyWC31viEf8WGhWvZuVid4Kxce9QcTdeCjDl8ZFowHdh5zReej301vDzv9R?=
 =?us-ascii?Q?tYwJa+y3cbBUcxL5J/B90iEUKZIV2PRPEP+aF+jDrzz3w8aFU5FhWSYFIqKo?=
 =?us-ascii?Q?/KjQFIJvepus99NxPWwntBtqyHlnsTJ2G7JlmOyUf592mQasZxPg+VbA8RAc?=
 =?us-ascii?Q?WTSCcAhMkz8PXyQPzvYDpd8UU255C96h6trzB2D1OIwbAJBXUoxEclOG6tGU?=
 =?us-ascii?Q?57dhuiaXn6eoPHJ8EAw4xIZ8Ll6x5QcIVX+VsR1hN3JKjBuUA0lj+5PAwayR?=
 =?us-ascii?Q?z72+h0C4wF1qe78MKlsGlYOolQ1bVyoLoQE5d9zW5JUJvAoNJIRkgNLONHif?=
 =?us-ascii?Q?exR7Jo9ynaWQ0ZK9QyQS2vYAr+jDhxd9mtUh9+MDL7uDvFAUK3Ou4bLnNuUd?=
 =?us-ascii?Q?lE+tcO93Bm0aEJD7O3GfFNYlz+KYGuJ+IfA68noGuZU3V2Fske1L1rjUA3+c?=
 =?us-ascii?Q?Ovmtx8sokngIUDajPB+ja2rKmQLTRz+TJ2/BBxna?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de357b5-0bb1-45eb-4586-08dc9bd61447
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 03:04:54.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7m8pOUazEg049CzYtlLomiE07UEU0k2tuwPAgN+1clXFR37Ak3eqGNAEfwdeQPHgfuKR3uaBMKlgxZaU1/zAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228

Current practice in the selftests Makefiles is to use $(LLVM) as a way
to decide if clang is being used as the compiler (and/or the linker
front end). Unfortunately, this does not cover all of the use cases:

1) CC could have been set within selftests/lib.mk, by inferring it from
LLVM==1, or

2) CC could have been set externally, such as when cross compiling.

Solution: In order to allow subsystem selftests to more accurately
control clang-specific behavior, such as compiler options, provide a new
Makefile variable: SELFTESTS_CC_IS_CLANG. If $(CC) contains an
invocation of clang in any form, then SELFTESTS_CC_IS_CLANG will be
non-empty.

SELFTESTS_CC_IS_CLANG does not specify which linker is being used.
However, it can still help with linker options, because $(CC) is often
used to do both the compile and link steps (often in the same step).

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

If this looks reasonable, I'll break it up into separate patches and
post it as a non-RFC.

thanks,
John Hubbard

 tools/testing/selftests/bpf/Makefile       |  2 +-
 tools/testing/selftests/fchmodat2/Makefile | 12 +++++++-----
 tools/testing/selftests/hid/Makefile       |  2 +-
 tools/testing/selftests/lib.mk             | 15 +++++++++++++++
 tools/testing/selftests/openat2/Makefile   | 16 +++++++++-------
 5 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index dd49c1d23a60..6b924297ab71 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -55,7 +55,7 @@ progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
 progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
 progs/test_global_func9.c-CFLAGS := -fno-strict-aliasing
 
-ifneq ($(LLVM),)
+ifeq ($(SELFTESTS_CC_IS_CLANG),)
 # Silence some warnings when compiled with clang
 CFLAGS += -Wno-unused-command-line-argument
 endif
diff --git a/tools/testing/selftests/fchmodat2/Makefile b/tools/testing/selftests/fchmodat2/Makefile
index 4373cea79b79..d00b01be5d96 100644
--- a/tools/testing/selftests/fchmodat2/Makefile
+++ b/tools/testing/selftests/fchmodat2/Makefile
@@ -2,14 +2,16 @@
 
 CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined $(KHDR_INCLUDES)
 
+TEST_GEN_PROGS := fchmodat2_test
+
+include ../lib.mk
+
 # gcc requires -static-libasan in order to ensure that Address Sanitizer's
 # library is the first one loaded. However, clang already statically links the
 # Address Sanitizer if -fsanitize is specified. Therefore, simply omit
 # -static-libasan for clang builds.
-ifeq ($(LLVM),)
+# This check must be done after including ../lib.mk, in order to pick up the
+# correct value of SELFTESTS_CC_IS_CLANG.
+ifeq ($(SELFTESTS_CC_IS_CLANG),)
     CFLAGS += -static-libasan
 endif
-
-TEST_GEN_PROGS := fchmodat2_test
-
-include ../lib.mk
diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 2b5ea18bde38..734a53dc8ad9 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -27,7 +27,7 @@ CFLAGS += -I$(OUTPUT)/tools/include
 LDLIBS += -lelf -lz -lrt -lpthread
 
 # Silence some warnings when compiled with clang
-ifneq ($(LLVM),)
+ifeq ($(SELFTESTS_CC_IS_CLANG),)
 CFLAGS += -Wno-unused-command-line-argument
 endif
 
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 429535816dbd..f321ad5a1d0c 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -43,6 +43,21 @@ else
 CC := $(CROSS_COMPILE)gcc
 endif # LLVM
 
+# SELFTESTS_CC_IS_CLANG allows subsystem selftests to more accurately control
+# clang-specific behavior, such as compiler options. If CC is an invocation of
+# clang in any form, then SELFTESTS_CC_IS_CLANG will be non-empty. Notes:
+#
+# 1) CC could have been set above, by inferring it from LLVM==1, or externally,
+# from the CC shell environment variable.
+#
+# 2) SELFTESTS_CC_IS_CLANG does not specify which linker is being used. However,
+#    it can still help with linker options, if clang or gcc is used for the
+#    linker front end.
+SELFTESTS_CC_IS_CLANG :=
+ifeq ($(findstring clang,$(CC)),clang)
+    SELFTESTS_CC_IS_CLANG := 1
+endif
+
 ifeq (0,$(MAKELEVEL))
     ifeq ($(OUTPUT),)
 	OUTPUT := $(shell pwd)
diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
index 185dc76ebb5f..7acb85a8f2ac 100644
--- a/tools/testing/selftests/openat2/Makefile
+++ b/tools/testing/selftests/openat2/Makefile
@@ -3,16 +3,18 @@
 CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
 TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
 
+LOCAL_HDRS += helpers.h
+
+include ../lib.mk
+
+$(TEST_GEN_PROGS): helpers.c
+
 # gcc requires -static-libasan in order to ensure that Address Sanitizer's
 # library is the first one loaded. However, clang already statically links the
 # Address Sanitizer if -fsanitize is specified. Therefore, simply omit
 # -static-libasan for clang builds.
-ifeq ($(LLVM),)
+# This check must be done after including ../lib.mk, in order to pick up the
+# correct value of SELFTESTS_CC_IS_CLANG.
+ifeq ($(SELFTESTS_CC_IS_CLANG),)
     CFLAGS += -static-libasan
 endif
-
-LOCAL_HDRS += helpers.h
-
-include ../lib.mk
-
-$(TEST_GEN_PROGS): helpers.c

base-commit: 9a5cd459be8a425d70cda1fa1c89af7875a35d17
-- 
2.45.2


