Return-Path: <linux-kselftest+bounces-9306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D09EA8BA51C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0202822D4
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 01:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAF511723;
	Fri,  3 May 2024 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N7BDlWTt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BE2E574;
	Fri,  3 May 2024 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714701509; cv=fail; b=S7qe0GVNBOSqx0kGK98FJCQmpqbbfHaXyWviAQ1UNGBlTXNVMUlkREC4q0XFFRr4oRqEpGjkT52jrXECkMsAsMSN3NJDe1UHeGla+VqdgzSY+WbzmYX+H5bB+dikZLGFy+a6IuO1BtsxxZXb/U88ZDQ2MZTWJ8l1q80wE6dlNAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714701509; c=relaxed/simple;
	bh=96xyeKhdShnden7AkA8wY7Cd9hruwWmBjGq/Kso+LOU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P4Ub0JaQl9o5Ug2/+iCf/L0LUizAjDluv3/1ojb4hkG9IBdSeOwSiLTFMzwMrmQab03p97+L9qYkzokWOJfWDFUqB91xUjvbVV9s/SEncYPDvKUGfgV41gWK3ZDa/2zD5i4UuNSIBwUP3cz+lDTu23Q7QiNGWuKX/9YrVMXIz2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N7BDlWTt; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNRsYPcTMjWo+2J9Kl0efdNkVLss6RKsv69B7iAWnkBYvHOjSHglbUIMdvv5+3SId/ZJAhRVzpcWelR+EP9CZYRwBAj0QI+CkS3TxmnIMFAEliNCE8YPvXqs/UP9eQmxSZRrEM6E49z9yKrgw7m0QrxHFUfID9zHkXbkj/QjYGOY0bx7L+WpH9z3VIviDwT+10H/I8ipb1Lgj57ac3xksVSnU3MmIFaYHK2bGQfqumzr+7OEKx/r1l+51IwfukHAh/N4V2tmjCaDI7F0uxhBZ4kpR1mxJZMcA3UNfHOWPP4TCdDGx7mNqkYwCcofxX0H4yAg/jtAADtXmnFgUghyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gZFWtKHxO9+oRYDVzBdOIQzHqCUagVWLxo5v8xRTSc=;
 b=cX0skUPqztmwrQNwAfFs1P2ImGbiMHBZ51qi80gWTvKRGm3rQMZ4VHapB67oLdQq4vAHypSc89dqW8xwkdwhJPh1+mZ0iqh8pnYi7lxjbsNFWzq44cBmwZ4pKrRRO8o2VFaA0KS7JAAPkaHwkqC1xBW2LH/3y8ddYunYra6acWRJoohuB2ob5EZ+Kev2QnvY8dqVGOKTntRWGDzv4rsF+iR/jrQ5rB5APiC4QsV/rb/QZyPyle2ezDEB/COZsV+wqljZ+vs8THxO8QBQuWOv3Hr+Raf6Z8wUBPAXn1eEbDQxkFINmPp+ePEeUvTPiSr19XDcRThjYf5edXXYNsGmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gZFWtKHxO9+oRYDVzBdOIQzHqCUagVWLxo5v8xRTSc=;
 b=N7BDlWTtC1QIyBBZGLvcu3jRYXImKvR8p6s/uPHllAVtmZgmtShNSkxCG0t+UuNs1eDC5Q8K2+Hj9ei+FJrk9ahKRRxL2Pl53LEb/Q+KQFJ/NQ3pPCUDAupptjh+rWRxFAzZ/8yzBwR3T1rTKhE+rjpAqyPlyTfnhg9Ojg+IsK/iOJD2Sub4u2DS9/5gsAIrXqWpxTWPrkzgKIE6lr/8wFThdxSZY7cCfOnC+PhUpO5nS7sL7kaUMZU7MjDF0zANjnoS+U8BgYFdC7YODb7Kj9c6SNNNvz/AFb2p1uf3ziV54+gmW6PJklfAlq2piyWIo24JXXOSGlVC5ws1aaJFrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 01:58:23 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 01:58:22 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev
Subject: [PATCH] selftests/binderfs: use the Makefile's rules, not Make's implicit rules
Date: Thu,  2 May 2024 18:58:20 -0700
Message-ID: <20240503015820.76394-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:a03:167::37) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d92555-d4eb-4fbb-5a3c-08dc6b148364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NoT2KnN2fWBobouOl3FCXIyD4MYsckqvRZQ8dQfIGCL3ZZj97U8oUuKlsSRX?=
 =?us-ascii?Q?IkzfHcOVBbFs0wRuIeYjEaIZTU4m9XhN4IUuvlfEnWdqvrs4N/Bf4clQdoHw?=
 =?us-ascii?Q?DVC/H1x+e67wNU5U+Jr65VYNWydkweGagZMJfX4YAjYvXhdLO4z8UTGaNQgk?=
 =?us-ascii?Q?sl6agrDTzqtp66mC+afG3eMWQ46CxbqUw/JyfGLtocQ0Uzh1ci89SVarwy4o?=
 =?us-ascii?Q?VtwzHXURseEF1zBvJKsP9G5Ty8EDSfwQNBek/x5dDjPUoUC2srXT14k18VTK?=
 =?us-ascii?Q?BSxiQq5A3ccUulvwba7Mj5N2eBzmIs9JSyLriXIGcnssfnLqIq4QykJPGv7T?=
 =?us-ascii?Q?zwOo0+IYLew8qo/S+uOtw7Taw42t/u/QAOdbua0mSD5mO2jjL2mI+fUklfbM?=
 =?us-ascii?Q?Bhg28I3K8EaKBPT2kmaFl3L4r0cmU9PNGE4mBkoBESxFf+VjR2b90bGUR14m?=
 =?us-ascii?Q?lwVErI0QMXGrM/472NTvkMMfhJU3WkxypCsuCpJw3slV64EXOc6LXdYDViTa?=
 =?us-ascii?Q?T8cmf2IPkZoStlK0U3C8g7l62L8U69CArJuldfsNpEDgHXwem/VPAH+Kg5fv?=
 =?us-ascii?Q?CjKf/53xRuA/gAMBdVAKl78LjP6yQIePI7j609+F2acBR3rbqbJoBnUQyAjW?=
 =?us-ascii?Q?lUdFdrgrZtL0H/p5h1AjPaXr7AZOPOdnAqr9CBHQXQabC7AqgqK5grToUs8u?=
 =?us-ascii?Q?d5DBKpsDzQ+QTnY+c07n1KFkC88oIGbFRV1b9sPZznMtPj8kb9msFLhAzn+r?=
 =?us-ascii?Q?uS3mRB7QveqCZdOBQhOGjvoe5wW4hKwfGMFgjE4bzrOoNh+9rZ+OA3zIIFTY?=
 =?us-ascii?Q?U4HPa7qHyOTiIY/Ret41zUqPc5XNlDlTxARBywiLcEYe7bNRwKo41e11uYO1?=
 =?us-ascii?Q?8hkN0//OZHtl8FQMPAXIUyGfUhHwR/6je1FSr03sZUBugXxcvbxVaIc/c2ao?=
 =?us-ascii?Q?JQ+qxm+60JuWkqDP2uKHCpF8aMkeIdFRlCvNzXvtQYwbh7Ccs0Yh5s3HH9kn?=
 =?us-ascii?Q?B0HAhbUZbetNVMBVIFkdnX8EYKP77YzhImR1g/NE62pKbiHExb2tBVhyBsRB?=
 =?us-ascii?Q?KiRrSdt0XaSPE5SWOjzyMOVT7r+L06s/YVL3W3MK4zgeTq8WWvnSbhDQ7eRu?=
 =?us-ascii?Q?jkHS5sDh798j0SFCe/JOUMqDWH5j3VsudWugOJYbaCEIkw65uNM0CyhTaYCY?=
 =?us-ascii?Q?EJvBo/cL/0iWQNBgVNiXUea96KichZ3v4xyRj2gSr+tAdoG9AYtH1NpTZGM/?=
 =?us-ascii?Q?wxspFMMfOQBz4VjDbZAlPa+0/WSkd8p8HDnTyhW/8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TE8PrzCq6wWIj4/q2le5dXzJux6B2AVbY/HFc4kIL8ohyQWgo+U0lBpJwjn2?=
 =?us-ascii?Q?8UO415VTHRFJtpSVEUkxmwRNt7TpRRPwkXoLzBEhnIL4twZLJTKntIFF4CaX?=
 =?us-ascii?Q?Fj/68VyGLksP/x6C1/G+OZxihLVV4roa9rO2Px0WQ/4c0vzt9RYZ04BS2N12?=
 =?us-ascii?Q?rB2nAG3RAivUglhCpSdUSuxmH2pICQKY4II+hbIroBdWYCdVEkO8rPOHxqBU?=
 =?us-ascii?Q?4MvcrerlS1Tnu1xoMsNi32lhxxTFlovLiMWnVKOE9vHC+htH6107HkScl4aN?=
 =?us-ascii?Q?5+AfSFFAgk+uob3f+q1ekOijWGa0BQIGL/JcKeQqQeFCyirjzRi1+WGOdLg+?=
 =?us-ascii?Q?zZkot0eQVmYs5SaHpmKATO+J6DfhiSVqRRJu1FEsSS+zN4kthTu3PqN5MhhO?=
 =?us-ascii?Q?2lFBZCzcO404Ev641HGbu8ckKawncLmqvEhfYC4Pw3yDV6rSaijbnyPHuExJ?=
 =?us-ascii?Q?DnPMUVy/bSaPNfjTGwGP5jUB5pcsDPvZEC657P6eqeJIVnnweo5R3wNHINRy?=
 =?us-ascii?Q?4Ms9yy0Hr7vv4jmF11iWnch44r0DNMl+sum+nf68aqPfAHrScTR0MSSVaCr5?=
 =?us-ascii?Q?hcYjVRlgtce8N4UxxGHQtlG1Wv0xyWocW6zvs88Z1AFWDBrFCb49L0f1jS+C?=
 =?us-ascii?Q?rxXzzz2lh7XGVoOsS2MqHsKYJ20wSKy/YOLFhsBos3nj9ldNPCoHpYKBhlSH?=
 =?us-ascii?Q?UO6eaS+//VX7LphNo71yv5r5OvtKw63qWsp+5sq5xN4ztUG/7r2xpdJXvL1U?=
 =?us-ascii?Q?f3CEiZKwiaNm4DuE1nZ1qcMlzw9f1CPk8nUyTw1/H8wmsvYSitxutAtJ5y1s?=
 =?us-ascii?Q?YGGKdlneMOSWNR6ojEY/q804eZnoy1YN8Bi5/rrjFCXrQvWfFGgMlrRDbFZc?=
 =?us-ascii?Q?VtfLg71G9UnYV2Sh8rYdNpmrXWyHaDB9b+C8UastxtvS3gK6JqaJ6hXE5Iez?=
 =?us-ascii?Q?tMrDARLq9J0tgHy6cds+5YxLej6rqpT8vtBiuAcM3Tpx88C7PpP1jPTVzwDP?=
 =?us-ascii?Q?BY6S1Ic6emXmCcqDNcttQwCHIEc1Z6A3P+HoBGy/fjOyyHaNFrZ9Awp/m4qo?=
 =?us-ascii?Q?Ies2sILn+WjCVgSWHiu+nIlfarSM59ERgaYlRKvzl6LG08DvcZeGKmk7WJ+p?=
 =?us-ascii?Q?0oY6t94UqhTfkwc2ipGZQvEtMVqtrWgWCSDfk6tb4N6Ze8Zb47iim9c7VCMW?=
 =?us-ascii?Q?Ueay57CXy4pCNEPnmYfqFUf7H3slne/MyEjxIaNnh6PUa0CUhO58gd70lAZZ?=
 =?us-ascii?Q?ADu6i0KO0RYrSXUCF0gPJF02zayb7YxOvs5EuK8fJ7Uo++JMwLZjglHX1Uyw?=
 =?us-ascii?Q?LAa6gJz+8Jstz0d/s03Y1gUqmKha6cOdKwJma/5njO5lOkFgVDChMBsZ7Fx9?=
 =?us-ascii?Q?hHCoOQ0lFR4wcySmRynbCLuTG/UO5VnMPgTrefJ9dSdJsb+M8dB7FuIbb8Xy?=
 =?us-ascii?Q?HzXNIJ2xtRIZiIbP/OVC3YH387+E2K7px70JOvvgozCYaVmm+yVK8bB0Wbr/?=
 =?us-ascii?Q?3S4UCy6t3/eA02m4K36/n7QE5BiGN/IuTluBe9BzVASQMjeg1xnPV8OxGEyl?=
 =?us-ascii?Q?4GVseCpfrMaPscncJc8rE+4iD2MpNa6x+c5JYB6w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d92555-d4eb-4fbb-5a3c-08dc6b148364
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 01:58:22.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+FM52WCMWr6icem923vAS8AuczLHTnDZjlDQSCyN5i9yJvUpP5WdIaqHBA2p64byId+Mnk06Orn9LhhCJHseA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...the following error occurs:

   clang: error: cannot specify -o when generating multiple output files

This is because clang, unlike gcc, won't accept invocations of this
form:

    clang file1.c header2.h

While trying to fix this, I noticed that:

a) selftests/lib.mk already avoids the problem, and

b) The binderfs Makefile indavertently bypasses the selftests/lib.mk
build system, and quitely uses Make's implicit build rules for .c files
instead.

The Makefile attempts to set up both a dependency and a source file,
neither of which was needed, because lib.mk is able to automatically
handle both. This line:

    binderfs_test: binderfs_test.c

...causes Make's implicit rules to run, which builds binderfs_test
without ever looking at lib.mk.

Fix this by simply deleting the "binderfs_test:" Makefile target and
letting lib.mk handle it instead.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Fixes: 6e29225af902 ("binderfs: port tests to test harness infrastructure")
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/filesystems/binderfs/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile b/tools/testing/selftests/filesystems/binderfs/Makefile
index c2f7cef919c0..eb4c3b411934 100644
--- a/tools/testing/selftests/filesystems/binderfs/Makefile
+++ b/tools/testing/selftests/filesystems/binderfs/Makefile
@@ -3,6 +3,4 @@
 CFLAGS += $(KHDR_INCLUDES) -pthread
 TEST_GEN_PROGS := binderfs_test
 
-binderfs_test: binderfs_test.c ../../kselftest.h ../../kselftest_harness.h
-
 include ../../lib.mk

base-commit: f03359bca01bf4372cf2c118cd9a987a5951b1c8
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


