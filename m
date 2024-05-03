Return-Path: <linux-kselftest+bounces-9314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB2B8BA584
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 05:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE79C28148C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70321C683;
	Fri,  3 May 2024 03:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZitUjLd9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98118B1A;
	Fri,  3 May 2024 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714705354; cv=fail; b=cXErEhcBqcXLKvPqOK3bRaetAFgcw9K3q9W+olEmxiSN5vAXcQ81QdBF4GOwyTJ71VK5+iSkdHD1dzVoHxIVlj3k4r8mi+C6z4aSburZKO76hl923ENC0wvMlfPreMsDm0nFj81OuHkFMrEw7Mzo5NLM3fbPNRv4UXX1R7WNkLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714705354; c=relaxed/simple;
	bh=A8b+aEnZnKsHaceJ92fSVC8AA3iiS+E8E92LAo0tiK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jZavVWRG6DgPevCtgt//xaxMB7Ke+cXb3EwA0BEHLY2KevFMAmAyq9rOiFpoTpFAeu99L6KvMmMlfR9qCDepqroQ7l33/sSe+3EZaz0Sf+EqKbKEQljSuyMdcsRA6FNHczkjIIojw3BUphsBS/BgaeE8ylNN4M29EpUeUJ8lheQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZitUjLd9; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1EcJcw1/6tGVOeXY2mBxXE1sQjgVcpFt5QIGGEPMegHTCl8pAf68YeaSMtg5+cYVXYFI/E+lWsQxHjHkYuJlZqXxqpWy37NU68s0k2qWZzCMpdbt7d3kC2vwbcwSA6SI3v7d6+TFKW//vAxC5pcI5XN+q2ZMmWpmviXdOxKl8PrNWh7rCuVAz1OT5Hn1YhYeCo+YGZXMg9JYO3PZ2sYthvUGfLyYvG27ws5VrPzGk1uzqprTs/vn7ZnNuUEuoSEL0LWx44CvlvF0l+6Dh//fN3Q7rW/j77Kgx/RuZFY0UUCL9v+XJ1fKYK3g/sF/ombjqACgLrlbLqmQnxQ8qWhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcVxyQncfHX1ly+thnXuHYz+bhZTN2O+XYhizqACyJI=;
 b=ZSnXdkKGL3aySbwJuI1g2s5eJdWjodTGT4w1IUEOr74VDhFKH3n6WmJt2aZvC+o/BOxTELWDsYBlZTRIHml5si1jISIdjkGyMWCZo9KSC2gZSiEsLNAAZtw9ULNq0OL6GBROuJaTr1lYJxKgV3DMIsB0JYWk5DcXX7yw2CXC8AtMdcSNGu0+wgLEbvhmg2yelDc1Eqqqf2MMDmd2X86KbSvYDQGqAOgFEjbu9ZjXzMD2odmjtMUzCFoHKNIInoTJGvppA1/lydg7ski2KxscNayK4pqkFPL0ejYXsS+lOAoSFJu/XuJLmaXWRdGs6TadJERCNLn6HTPUXjzQ/h2E3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcVxyQncfHX1ly+thnXuHYz+bhZTN2O+XYhizqACyJI=;
 b=ZitUjLd9QStkrrDJn8Z0uzKcfrnOvSePAsJa8tUJFvjIwd67fNUHi64ioZHWrzioVUZAQialcv+k8Cc0fFtE6kGNJcCzmFesTdof/to/ZckglET2sMPil6TCp4ceSfAEr2EP1pwhgIGgaBUyt4TLxYFLnsl4drmRPATv9BHjgwGHHTNHe7+kV5SQGRFf+bMYRDSNw9Z4Upkj7Gx94f+LwVb6oj0yp/2WvIs6hiVNHNJCiFSTdDK4FP1OqaoqN8+9GJ+5ot2S/yuhtRVWcDN66+aiSNHDnVojqqarNbbDBKUu5RtBNDmItN41qijlxG1zwG/2xw4C+4GdYLikWlf+1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 03:02:20 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 03:02:20 +0000
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
Subject: [PATCH 5/7] selftests/x86: avoid -no-pie warnings from clang during compilation
Date: Thu,  2 May 2024 20:02:12 -0700
Message-ID: <20240503030214.86681-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503030214.86681-1-jhubbard@nvidia.com>
References: <20240503030214.86681-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: 54edd36c-7d95-4a20-6292-08dc6b1d7291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oU53Df12L+VGd4N5t3vrE3IH4yVJzbK/COQiLvZnXC1i5hrVs/02okECwbnR?=
 =?us-ascii?Q?b6IhbHuDppAlGqGA1KpV+zekQneyLQRmaorEMAbpG1b78md5z50VsFCxiJJT?=
 =?us-ascii?Q?XZ7GllVXphwYqiHIZjtIQKMuesBZ67CfEI+YWRCFrV++c+4a4gICiTHTd92O?=
 =?us-ascii?Q?JkAp19ZF7zGlLNtjXijTu3tPiklkDSk2CyJKPg9SdThDRlZaf+rnrJWkiXbl?=
 =?us-ascii?Q?JFtYZCdh7ghbZKwzmPVqjRgUQAELoslGrqWw5LpW6OGzFZAYDcwNqN7Df+pU?=
 =?us-ascii?Q?A+mmLzqyefNrHLidXehIwERqDeNoNAFCOYJGUpu2lDQenWpyxE3QcaOb+zfn?=
 =?us-ascii?Q?1m0WR9S472TWGSv0qE57WodvgVGLQ64I6bwSv5W2TxIDxkavSIHUKO1551I9?=
 =?us-ascii?Q?9TJ0YB0p9p/Ttqe8HqZ8Xfkdepx26yUjSUMe25DyGDBYo6LPsNxje2iPacq0?=
 =?us-ascii?Q?gn3ngWn7pJP2N+xFIGds4DT9qjn8Ny7OW9Ja33gRc2173IQUdkQUvmYqbrWt?=
 =?us-ascii?Q?VuiEKpcgSEGkbbXqqLuv+Oi2HmpfyqLRFLNh0gkG9IKk9xA84Kg220dPJ8CZ?=
 =?us-ascii?Q?D90Kv1DnaAd/Gn2CXXmNBq33dxy5QqzsY5u6+ko27pfoaceHoBpDmLqrlQIJ?=
 =?us-ascii?Q?meZ6xxvkSA6JkZ8i2ZyS5jK9epoaI3I+3E3o5B9aXyQMUjvwT6K2E6OfUIxD?=
 =?us-ascii?Q?4kublXXj2g7ZrhsiRugIhkB0GAAakYsrUQbQsY/xf2OkSJPWzBgMmD70iIUU?=
 =?us-ascii?Q?XsxW9aUGGK9ITd2/Do0klBQa47PVS2OsmAuZn1DVVYFVfONZtWI+Op1dj6WW?=
 =?us-ascii?Q?Gm5kcnbVFGWjWVfk9XJrZ8nQYA6nZ65S9y4Q1uW+vusCjF5o5gzO7IZFKQej?=
 =?us-ascii?Q?0LvRy0dgMVyvDnpF7Io6zuabujYIzIT16uNqqwQxIyhXPxyHHZNf6OMNrlru?=
 =?us-ascii?Q?cwhhdGM4zjc5vP5rfV+82hmuA17VLJFUwIDz/aQYW3KtK2vF1qTp+BHdg1Eu?=
 =?us-ascii?Q?BQojP5aQ3xd9M/zQlvw5TZObEiXKZPNN5XsJHFJ446uSy1B9/M5eu7hE8XLl?=
 =?us-ascii?Q?lmpKU7IktJCiN78d/6xNuRut9hPeeG4E5rtgwWhzGRQDezU3irRlrgJZU8OT?=
 =?us-ascii?Q?vmU+g6pjaZUpj5ULQYq12yhmagY8a676D6KVeaaoC4d4skVGjcaZ56fcm+uL?=
 =?us-ascii?Q?Pib8Uo28NdrDQA1kAW/Rk/2ySj0pFQHZDnFPwTxAEOEdpRMhc/FqC5kBUnTJ?=
 =?us-ascii?Q?Li1b7KlZA1qJbHtum/9rBnwG/ehR3bmJAHiGpdy8HA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6sI7Lp+SSps54Lm6oC3eBxf4iB8FYXgZA5bGG3Nz9BJq1syo1nFT1rsjvXho?=
 =?us-ascii?Q?/Ga8Z4qsdcHYQpW/1JnEOnLp6eZF/Rz60UTP+heagd0Rzi2QngCoCgtYUUL4?=
 =?us-ascii?Q?5Cv+XP/1DcXtx9aAe7kfpbQeKIHyjJ48aWDcUMtMlfuww/G40KBvT0TM9om8?=
 =?us-ascii?Q?i2Sd89M0ZGyHYoxibE+UVX2MqgSdYthyZVeQxSpcrR2IlZMwy/ONX5QDXX+U?=
 =?us-ascii?Q?cXxAmmsLbfDy3dxzXl4wQRZLmjmcf0YpL8SX+T61kdZm0FE74/jZONMfPRFe?=
 =?us-ascii?Q?6IhpJu4kkZyB1jSYMhqZ+iH/bb8k8pFOrKRIP7jIJlIStTWn17UwWDkNL4l5?=
 =?us-ascii?Q?7q/DNCzQ3tOfsMC7/QqfMYf6Rg4DNUfO4O6vuy67P5ep66WFtMN1xFUOVmmL?=
 =?us-ascii?Q?OV4pwHoxavBA4qMWgHeP/t0JTgSG0eTe2FusoqsDFdDtlBFU/2522AQWKkg4?=
 =?us-ascii?Q?ASWJoGbiuxk+iWvsPELRfXAfYlwRxFV/PycuYW9eheLVazul313XarZXFaBO?=
 =?us-ascii?Q?eRuPwZidl0faaxJsd8aqISM5+Ae1ySuczCaBxSugmM7QR8Rphdw+mTytuGWy?=
 =?us-ascii?Q?N8zyKEKhVzW8mkz5TIXD0fByctRfMtbdyELJhdLauw7Cxrl46HqVluv+0C04?=
 =?us-ascii?Q?Kp5dgj01thK/iUNfQ5pT438or9MJDirEoayihGIBf8NKTjV0YBkrNWtygQOu?=
 =?us-ascii?Q?hLpy4NxhSjW99f5kZiq7FonpOMzQSMePc9hnQcJhVWISwXzT08JWhjLf0oEV?=
 =?us-ascii?Q?DZQkzqNQfu4i7/PDB+sCbQ8sPUIAPwkOPcSbcPuQ8eayf38PnUK++KNzCRCr?=
 =?us-ascii?Q?W5/aqhXL3ng0RpRQa/DlFDeEDImAQ+3dTzz+gEfPvHfNo2CF0hkwcVgB+d1V?=
 =?us-ascii?Q?pKmh76uUPyxxMkA4mh4RoYIk+MiMOMfPE4LEJBN/vJzN6udnjt/8FHZ8BGsV?=
 =?us-ascii?Q?I4au32tTWMeEvMCUXpAnvQQX39N33U3kcLsK/5kcuCIUUMA2lkpIwbFGZ40V?=
 =?us-ascii?Q?2hQjXw/qslnIgZUCKuZtVLngGzHI6oay8dlU6E8D2fpFnwGBMu5gGr8ovKxI?=
 =?us-ascii?Q?YDnc7TyDF9bvRdbltbAULVVmXYWSVT2Z4S6szXSNIwa5+T0drf4cgcL0PKg6?=
 =?us-ascii?Q?UHZHx3S3rDzWdPu+DOB1rRJp0SdC7UOo+GmxrltxFlkvkOaxnI2azZVM/bV5?=
 =?us-ascii?Q?4iIrgirq4vaAZrFRs1H10/ZCjRg4duuzMAlDNnpbXUBF+ohey5fIBOMaSR59?=
 =?us-ascii?Q?dTm1z1VuuEfzQiymlWZXDYoIKqKkS5DGNUcTaM0BfkjLV36cm3fEBHy50oFa?=
 =?us-ascii?Q?F3epIQHWCXck7Gt1stQvPTPFoUyQGE4jjmJAVUhDbJIbYwofeBwcc3nRDR3C?=
 =?us-ascii?Q?MfqImcch3RgF3xqCQ6nPTFRhL1ib3gijABsxBl8WZDfUpkvjtw6S2fWAIlVU?=
 =?us-ascii?Q?9N+/Dv56m4HKJZC2iiZXctOcn1mUauEKBOSPbE24nohuxI9BTdN3nYGNL2VH?=
 =?us-ascii?Q?ZzPl3zro4RQ+DMDohBwLsAar7FLwdeDfQJ//EYs1A96cRLKqEyxc4VKeUn4E?=
 =?us-ascii?Q?C1WCTlTL2rrAUUXtz/19Sz4BWPPCqTPbdBQKdLZR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54edd36c-7d95-4a20-6292-08dc6b1d7291
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 03:02:20.1419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRPNV3CIrgTzexZy7mzerO7Xic41JALfevEoEcLsS1THoxocQLHgLy4uN51gDEJfVAkRcr0awIImR6HLFgmjfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang warns that -no-pie is "unused during compilation".

This occurs because clang only wants to see -no-pie during linking.
Here, we don't have a separate linking stage, so a compiler warning is
unavoidable without (wastefully) restructuring the Makefile.

Avoid the warning by simply disabling that warning, for clang builds.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index d0bb32bd5538..5c8757a25998 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -40,6 +40,13 @@ CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
 # call32_from_64 in thunks.S uses absolute addresses.
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)
 CFLAGS += -no-pie
+
+ifneq ($(LLVM),)
+# clang only wants to see -no-pie during linking. Here, we don't have a separate
+# linking stage, so a compiler warning is unavoidable without (wastefully)
+# restructuring the Makefile. Avoid this by simply disabling that warning.
+CFLAGS += -Wno-unused-command-line-argument
+endif
 endif
 
 define gen-target-rule-32
-- 
2.45.0


