Return-Path: <linux-kselftest+bounces-11081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F2F8D6D64
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 03:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077EF1F2314F
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 01:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C06B645;
	Sat,  1 Jun 2024 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PQUwMhdH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7E1A94B;
	Sat,  1 Jun 2024 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206344; cv=fail; b=mO8SMwbHkE1/VuWiCiQ81iVHtZ2IxYBX1cvi6IzhIQzjWRyE5nNKVMP+fZwGQkwGtaJbDDNwoeybil3gM3krvHPkaBANLLR1hSYlfW57ELuNm4HYaUBXki52Q1NzyCdLsihdPm7d85vbMp61iS43aag8tBofCDYvxDTOEDVNrAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206344; c=relaxed/simple;
	bh=m1fN+drbJnwVgU7RzaZm7u/ijL+jMZxsWO77Ay+hJzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rCCVxfEcYx4PM85lhR/sQGn/LPd3C+pwEalDMQbKQ4/qKKYbUZfmYCnF4TIh/qWM4o/P9jRuu7SqJ3Ifa5pRYsTu/xmbeYjXofRsXRsgHxMIxR6wR16QtIFutejHa/hXlGcpZQiHB+e24V9u9CxzGST8zn7qc6tlgD9rRbqRGe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PQUwMhdH; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT2NgkT+icvomVDNt1OnY5Y+/3ZbNcQWVhrZK7jr3ZmtnxQHR2rU8GtQrJh5hwky9/veGMaga1YXCSnh0dlLV7xlo1brMvNChNf38z7nxQzgcDYwGPWcUGQKZgUV6LJpiyQEgwfZid9gH8lIgviKZ+RazOa5sJGwOXsDIBzzNA2b0idA6I9Rj3U+bL+aLlcQgMnK7O8lfPjyU2xbaC/XGYXvuLrlXA8+lsgcTlcJznHaJVxerrMYF1xfzzs2OzyLdBDNO3+8nZoXcrIV1qaGLSJ3GZjs7twoEeJ6GI6l7aGKBoEAa5G6r0mES4QNzWw0ODxrnvOuzzAWUUzGhG6sjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4RTD7DtfJktS46vAnCIqmmmNTvBa6rCm1wAK9h1yEE=;
 b=YhhSU0JBvHc0sdQ1cTmAtX/pJsY8La3H9T9mixWFIszAYSNRe72mpNT5byIA245Z3ekeOVWvKEc10X0gSLsvTlhJ5F4vaeamg6yq1XNg7WG1keSKQsZUmRNCrJ/Ptf/LDCohk10LgO4f4KlCu5Eai3pGBrsfxxkqtzytopz6I1OQXsUR4kfxzmrXdiv76Pagc/cnCQRnh/VG+31jy3b3LgT6rpJNSYo+o6zrr+a2uVPIynqHMIvc4pEYLmI6hdM1dw6nZFxx7ojSGB7x1xvPtFvwvYWmCgWGIrlHHdcg6p9u/ZxARvwGLLtylVi/SMUnUbf5NydPjSsD2At5zh157w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4RTD7DtfJktS46vAnCIqmmmNTvBa6rCm1wAK9h1yEE=;
 b=PQUwMhdHDZYA8QqeMND+flxA9DruLop1yOtvZozAiETTZ6lOqKIgPQzpfnjZgNr//C90XLFsgyT054Eg6bC1CmqsDfYURxB0uAsUZkPnkxr8/yGjqTGmJURos5T50gmwbbmsHLY38V+EnRmZDyoaC5NPpwxx8mLj5WOjtUU6mNUbQBwe7pSPEIZYwMZ3fYZmDRRo3x/Y8INIFszvk9AtFGMukeNEL31DHd3CCO8k5liugikl4w8DFrxBDWnN/qFMkXJl9zSwv6U+HxxRuI19Qi5V4HZ94Rx1MmBLszOzY/6oQ2bwBUpT+zFwGzH8KOrLp0hc40jFyGSD0/wKykQ2ZQ==
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
 01:45:37 +0000
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
Subject: [PATCH v2 1/2] selftests/openat2: fix clang build failures: -static-libasan, LOCAL_HDRS
Date: Fri, 31 May 2024 18:45:33 -0700
Message-ID: <20240601014534.268360-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240601014534.268360-1-jhubbard@nvidia.com>
References: <20240601014534.268360-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: c8aaf136-bb09-4956-d77e-08dc81dc890b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qjc1z7iRQZ9+MmDRt3nYNXX2Y4tvel/+HMH9lAnLPFXb5u6iaInacRbLJPme?=
 =?us-ascii?Q?yWLRPrwW3GJXU3reBRfO2qW23E2GZxV/fXuTykH7HB0fXVIQxH1/9bi978GP?=
 =?us-ascii?Q?iDT9nGqvIGT39skEnaoXWLPhN8WQFRBiI2paEUr/zZqAyjOhqcq30nBj3aLk?=
 =?us-ascii?Q?C43LF+u+VaEWwsRK8a5DPfmtC1bBo+CbPAZz3Cs5zwuBFRMbWv4q8HixDe7/?=
 =?us-ascii?Q?/e4PWuw/40TEMyOWlEjitpuZ4mqiuSe6N9tbB1QcSjzE/Jetbkw1Szk7lYl6?=
 =?us-ascii?Q?5/T4ohdZVytaWytm6KtpYZmT6RXmtu1e1S6sSdqCy41+nVW7jeCKfoJTioVV?=
 =?us-ascii?Q?3eu/J3LPkvtjQezuvsDTs+FGeeumiDm9B6jntXz2GAh9l1BFv5PHjp08ghY9?=
 =?us-ascii?Q?8fnU8X97y1cY6GSkhM1lSRxUgQL9K4PKpg2OBenkP5D6Cf14l6c+n751yHlx?=
 =?us-ascii?Q?oCTQJhCKPojflPJEDj5aGdl/fOEpuVA7W8+rx11Caf0787Oyq93oPlTwny+R?=
 =?us-ascii?Q?UarrPqckSicQPYZTH81Y7VDid+mU87XG0UCRsTV6mgztB7gPtlYoJV+Lr9Yp?=
 =?us-ascii?Q?xgW4bfE2Lh4dLFDXLHOWx860aVt2EO/uslYKc+aUrqZbYCAxlDmofrdEL3Kz?=
 =?us-ascii?Q?26ItlGlN4gdKbMYlePbUmXPgkEyw4nKREmY5Ajz5N9E9H0pCZY/pOWu6ID5W?=
 =?us-ascii?Q?gP7pVRC7DuihOvTgn3LVvhls+WxeqUATFSpNyE8jnYzoLhIwrK5NSyDVIzf0?=
 =?us-ascii?Q?gBAtDepgugcBVrzeRK88KtUfh970Zjeyte90G5fkRvofvZE4zcouKUfO4n+i?=
 =?us-ascii?Q?n21NU8HscObpMk5L1Nlp+HPPNawcNFgNIYI/qfh79neyN84VESD5ziqImmj7?=
 =?us-ascii?Q?Qq7jHZBnUkmHSwb00pDSAawM2rSSKKjbsnsQt9kPlPT6HJLATB4RsPpQrcR+?=
 =?us-ascii?Q?kXEMnQFslkgUbXvLIznJP4itU30Z5ELx3mEJuhVEcHOQfOl9CzUbAHSgg74V?=
 =?us-ascii?Q?tkMYfAartusU5lw0UlAYWU/hSlBINrbBSgFsLGkeEQWhorBVi928AQvqia29?=
 =?us-ascii?Q?kWLrz82Ym8ss0jgTc+VVpHV29+RtqpFv8XehNc0oQBbks6Xq06OMVi5/vR+E?=
 =?us-ascii?Q?j73gbszSvRDZWJm1bpZ9ouPZ2jbrRvHWxN4Or1BoKhKJITBYBzeLkB+oM/Ii?=
 =?us-ascii?Q?WDBNkUQAHlux1LSwz38hUB9UQmbtEMk0mvfzeVlRoMqcjl2HOt/tDKVJFgqF?=
 =?us-ascii?Q?iWuqzj7xMUXUyx7M9ROIYqHX1kBPgsC/dM6u+8/DDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jeZtWOURLQD3BAQzKCQ+wNdpF+8ncK8h3HXTVJlU30rjBx20xFMQuklh4IR2?=
 =?us-ascii?Q?d/JFic9PSfqzSzPCKNauhAEQk7oL7A3Lt7blENLslT00DCDEIDfQDBbLhwmo?=
 =?us-ascii?Q?zNS+4eRjQHULcFYIDIsSfpe6MnWQ/C1mT7xLjYa83p+4BcfFdWVPx62H9jZr?=
 =?us-ascii?Q?FEn3QZRNcM20OJoMxAK6dfsDB0oQWc7G+S/ILfP7rhkEE1CFU0uToFEghVcU?=
 =?us-ascii?Q?teLP3JZXVSbdbFb68Lx5o6z8mo964gR+fs8RsR95hLEq7w2f23HWt+edmYjp?=
 =?us-ascii?Q?oDonx+EHPjGMbwJEmF9CIr7/byecOJTWwzgj5UN/A9JSK/sGyNDcKI28/Wu1?=
 =?us-ascii?Q?5uRL3reOUCDvgkiRCxoehmuty/XQORLUvwAtAGDZUxwj4oHQdAsrSDRF8e+A?=
 =?us-ascii?Q?fIYHjM15T4h8gRpFYkadM0krH8f3UuSKhoMxE1GxMhJMsW55ITLDAL9reBAX?=
 =?us-ascii?Q?lWgChdbSZSKTd7focfjaLgXglbqoN0QxXgTOI0ylSMM6PH0Cg3U0QJEs0Fpe?=
 =?us-ascii?Q?NtwirjjVrhlChl/Jq1qg1yj8F7WBcRV5abh29kLq8RK5V+sRdmT3Z1w1iqhT?=
 =?us-ascii?Q?0d5OfwZSDRJe+y/gBKAvkK6sCOcWFppyFoChDcxYSaTc9+Jpu9xjXHai+TB1?=
 =?us-ascii?Q?R6UOv7IPBQ1CkPrNreiF4jZXsTjIdkwFDX8ZICrrJA/m2bBIXdoGQdJJk5Fy?=
 =?us-ascii?Q?amisWY2TquItMXOba7VYqJIMdvyWByjy4RwmEiwThx14DNwzkvOVZkBxZgHo?=
 =?us-ascii?Q?9s3h0C/nBoiuXAcG5YfLMgZQeUNaWqfz1GPZpuEshzbAeAkTTXVnK6u0EONG?=
 =?us-ascii?Q?HySo4AhdvVkz04I/IsffLZummnGY8nZRri6iLsQ+NYCnVwQrNo/Dj5uNqkwG?=
 =?us-ascii?Q?INU3OQWftC01WOquy3AqiBeYBxdLsChSs5M4V9ZV9kBub1hXCoRLaV+hjbks?=
 =?us-ascii?Q?1rJOuQpr8S+5fYLlUN4qq4SUu276HDB2bXmn6aS21paeC77xF/UhHMeyozur?=
 =?us-ascii?Q?0bkNMrO3NPhOhW/EDfhuI7oLkKzxGXaMQK6p2GwGEKQzYejW2kZRm0N2miEq?=
 =?us-ascii?Q?KQgXp5REfywvTruU+r9LUf1Vz6CWd2bGZB1ZFjFcwvQohp7yZuQcAW9bweQx?=
 =?us-ascii?Q?fOybBKJf/xR703iTWF6eGMXzMciiyugjX4y1YDvgvXGV+yKyoK9ZPQTNvq9x?=
 =?us-ascii?Q?oUHAkos9cbxJn26+F9R9SMe644eIj/iE29dp3ovQ7xuQNzDN6ixx6r9v+jug?=
 =?us-ascii?Q?TIWf0Rt+AFbwWECz1rdE7x+aoWb43mZqrbPpdNqWodpMsWpkhf/0Arn8xBYI?=
 =?us-ascii?Q?umM2KzMIHUZA1oTGHzHOkKeOwUim1z3HYG8PtnlCpBGxyWG3BfNxJl4t3Yor?=
 =?us-ascii?Q?fKVI0aKUI+CO5XChp5oxLYX1j/UXEKawTML3Rpl9wYEvoyGFAsHvzGachuJP?=
 =?us-ascii?Q?dhqzDoyvpFdh0yuYHPWKRIuzPHUp43xxuN3z9zDA5kDaT5/Atb8Z66BeG/gu?=
 =?us-ascii?Q?xXW+ENzrWOfle2klSMw2sCkQxmNhf+qAT92Omol2BEZrqBXiijfLaxhUQT1J?=
 =?us-ascii?Q?r9QijwilNgrIEKObfsT1LXpasrqqeIX4ZpzW3aF1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8aaf136-bb09-4956-d77e-08dc81dc890b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 01:45:37.2366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBV9ijaBXdud1rS+xpqL3otWW85g3IFUGf1z7L4Yxkv6FD2udadGnmUW9vbFgqVNUKJ1w4GEeOdn6qQQAo+yCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931

When building with clang via:

    make LLVM=1 -C tools/testing/selftests

two distinct failures occur:

1) gcc requires -static-libasan in order to ensure that Address
Sanitizer's library is the first one loaded. However, this leads to
build failures on clang, when building via:

       make LLVM=1 -C tools/testing/selftests

However, clang already does the right thing by default: it statically
links the Address Sanitizer if -fsanitize is specified. Therefore, fix
this by simply omitting -static-libasan for clang builds. And leave
behind a comment, because the whole reason for static linking might not
be obvious.

2) clang won't accept invocations of this form, but gcc will:

    $(CC) file1.c header2.h

Fix this by using selftests/lib.mk facilities for tracking local header
file dependencies: add them to LOCAL_HDRS, leaving only the .c files to
be passed to the compiler.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/openat2/Makefile | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
index 254d676a2689..185dc76ebb5f 100644
--- a/tools/testing/selftests/openat2/Makefile
+++ b/tools/testing/selftests/openat2/Makefile
@@ -1,8 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan
+CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
 TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
 
+# gcc requires -static-libasan in order to ensure that Address Sanitizer's
+# library is the first one loaded. However, clang already statically links the
+# Address Sanitizer if -fsanitize is specified. Therefore, simply omit
+# -static-libasan for clang builds.
+ifeq ($(LLVM),)
+    CFLAGS += -static-libasan
+endif
+
+LOCAL_HDRS += helpers.h
+
 include ../lib.mk
 
-$(TEST_GEN_PROGS): helpers.c helpers.h
+$(TEST_GEN_PROGS): helpers.c
-- 
2.45.1


