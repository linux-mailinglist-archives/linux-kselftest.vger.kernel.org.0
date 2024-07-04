Return-Path: <linux-kselftest+bounces-13176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF8D92707E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D2F0B23181
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 07:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D42D1A2FB0;
	Thu,  4 Jul 2024 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fc9XRb4R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964E1A257B;
	Thu,  4 Jul 2024 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077932; cv=fail; b=Y3vEbwhsDLUeCZtqowmE8sG3d5Y/kPU8ZyIJZuoqK/iFql0NiTohdxfJ2ysspFWPmjFXTJcIGlNV5peXKUw3HT5GHpvgE7mIT3dwj2xJ5p6xJZueLMkVDX0CmlRiuqYg1OccuYV8qTc9Ug5OnM9kE+7vQ5EbCr16+Gqn2sORw8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077932; c=relaxed/simple;
	bh=DTgQyBw9GXIK9jtF+2JVzwIyY7Rc1dncgmx3AN8ftAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AOkLhG6YqCNLcreEYJjw5YrEC+F5Eo0+g0cBMXABGPIg6yfK4oY5Uk09rGjYUlMGwV1rShVgULJX97wMWKwvmua9ALh66Il8ixmoZmbdt8+7mMiWjJheG89cAioPz5qICKBEj3/e4z380WwJYiVnbXwWN8qF+5xTEQCvJVEOcBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fc9XRb4R; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fo4K2mTaQY2J91KIybMea/E8Vy3hAeX2sDPSpWgS0PQ+xZTjWSZsPRCKLAEynsNMs6ke4fQErJ18OFkCZ/P+nnzo+011wyNPzdo9swaRvV9GFdAAreSJUcgO7UQcy+ARFr0SQsgbuw/wu3boW+17lKM1sDdTTzXCwv7Vwq83UDhdqoVjdCVgTB0b6ooKrQ/Rhjngu8unAqbp0n5SbXFcXbqXO6fH7UbGtGXCOLTnPusS4CFa13etc29nG2cAD6luaIipR+e5LDnjIJYekAHbILnEsNUA8HdecWFYXFwcvgxoRz38Vp5hX//fivEzdA8uA28gydtKcMB7M/I23Z9yOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiO9fnNaxrpy1qMqk2msiESE60kkn1veq7Dl0qy3pms=;
 b=fFLi2BqVUDeLIHRlvbhokcl+m/rvvmxzvV/9sw0PQ7XT9jdHqFV64ScqjEHbIh9Sn3c21i+w7kRLFIEwSddy870tpL2B9/MV9M+5QSBwMZKgYqEu8F+BwCm7K9IIKwORRWYhAJVvFMldq4qwWjG8G8JLwRwduMTDRQFe2TBFWsLxCEiYcOzVczAZ314IXr7bFvGye/HvklCojvkJePhbnQxkeueKYCKM11Rmay8VwU5SL4kc5DSWxVnwxa0ThR+0B9wcTGozTyH3JBs+8C9rvkUHnGSTmXdaRMhQ9UcfNjz/47TAsMiM5FJlwbJlnAN1nFHH72WS5agj7v7zleKavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiO9fnNaxrpy1qMqk2msiESE60kkn1veq7Dl0qy3pms=;
 b=fc9XRb4RZAHFD/fmg2afykAp/X8xi5Z486Oa3W3JL4nHS0y5BsPPUVh18nqLWz+EJnPsIiE4TPRYwI3sTco/tVnXo2uAiz3EUjK2FnarbeBYHrpXy5typV6yDi5MDtYWwm6aw9/4HIMe/EnbIAZ7LryLSQYDgh/Mss+3dd0LiwotoWNyzl9WQ9N0bbv/tB4Nr1Bj0NsVUuF5yhjbghodF88VxKnRNXjduVW7MwkFhWZnpxTdxHZRda3XwmsdDIAjUwUXDQAhSDs1TcaEf7k/+8qdXCn5/cKPF5JpqFpYeR7Un520zPSQ4NXh0ffNgozHf10LVnlc0+gI1uuLsAxFhA==
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
Subject: [PATCH v4 1/7] selftests/x86: fix Makefile dependencies to work with clang
Date: Thu,  4 Jul 2024 00:24:25 -0700
Message-ID: <20240704072431.111640-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704072431.111640-1-jhubbard@nvidia.com>
References: <20240704072431.111640-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0199.namprd05.prod.outlook.com
 (2603:10b6:a03:330::24) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f66860f-a632-4262-6859-08dc9bfa7688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XsxTyXSUfS7i55Jq6x/dEy+M3A39XRb01mnIsAV9C/4aaAJ1QKtdOBFcnOni?=
 =?us-ascii?Q?uiPuxO56hEvM70UKuorRBCF6m9VtxaCfczsrFvCx9hGqdJYV42c0PMrp/4AV?=
 =?us-ascii?Q?LgzilhXnFwRoHflOa4Ts0YXVVb/jR+NFJQIwEwP80d/DI622/9iF6Fi4DmQ+?=
 =?us-ascii?Q?daJazmUMOLc+0jWnwsAOV4s9FIJa+P1YiMOqk8NFpNmvo6qmFPiA5rUvu65W?=
 =?us-ascii?Q?lQXWDpSlTSMKqBAkA13jQxprkEL0quM5V/yMBT3KSQviMMmhK57hzb6ErFJR?=
 =?us-ascii?Q?zHmK1wjTY9qBeHixtto2DIP8IdFgbwJhh7MJWmX418h8mUoh/+UdF27lpPs4?=
 =?us-ascii?Q?2H7dqM7V4UMvH6ECrZu2jA7iwVy5k66aa7B/Kw6Pzg0va+kjzXqyawEbIf11?=
 =?us-ascii?Q?Rp5pc04DlH+6VxbgyKwXxAST6DSdDYxSifbDM65hhVikEKd/7kfZxCi1R+io?=
 =?us-ascii?Q?QTfPGNu+rFAYsxofhTzfC7UZGCz3WLiHDaCSGAAqHTLBzgXkm9l4dNTQsmyI?=
 =?us-ascii?Q?C1poYHu0+HaJ/VrFCWDwT82GYf/IZpj7034yerXyfE/EhaQqzADFK5Y+EVDy?=
 =?us-ascii?Q?0IafRavE8xU4R4uf5UsxV+DE5l95VGJ3XaBHxZaxkz3z195JkIjQie2sU7dF?=
 =?us-ascii?Q?V3oUKFWc3NO8hAM/Opb0Fhv3Gkp5V8liXJ3w+6PVhhS5Z+zx7Sj6/y8B9IZR?=
 =?us-ascii?Q?o4DJmfjN2OzZv7/3y0wiGbwnS4j+5cZ5HqLgQjV5z92VVv5/0QHQnOdy7ZiT?=
 =?us-ascii?Q?aquqk/PU9F63V5hqQ28xp4+m7+AiLCGGWqLLsjXgTRzC81EBbp2p8PzYxv0b?=
 =?us-ascii?Q?GKVzkLPT+pffB00I7upBc0BG9mqXkKFoc3OjuQdFI5Xs1PpR1hJnivj7MHJE?=
 =?us-ascii?Q?W6crlk79/daCS0/tpIc5bwWzuXcfSPtGghiMemTNH4eQ0MIesKApbZQvUPGM?=
 =?us-ascii?Q?9MSm6mOYRXFyc8tSP0Q/sL5ab2ed5wuNy8QctzdWRwzMN0ErpGQfT5eWw3JG?=
 =?us-ascii?Q?wF8TKPuRoSOvA/Vtmn6eiosSH8o8IFPQKP7oyqWes6Y+fvF2mzWbvgjb5wZe?=
 =?us-ascii?Q?/Hk1dQy6qQIIhlET78wNWfZLrt9Dn2qSS9DdoObgPpte+tM6v6y7YLrlhWWh?=
 =?us-ascii?Q?Dgg9Pk63NOLsSIuByoV+8b/WQyY4DJpiwNZNMTI0v2WcIMZGmNeaEnx23dN6?=
 =?us-ascii?Q?vbEN7jb97cBhACY1v7e0AU1mqqV6GqJ0Q98zEnE+nLSZj3ivjKSazUCSf6eo?=
 =?us-ascii?Q?swzHCJBQ8RYcwLbsszM14lutcb1IGK09uVYBzuTbuvZHO2NlVSaGmNtsAhWr?=
 =?us-ascii?Q?+eVMV4x0bcqrE42c3ZSbOfGbcuicMnPg12kCxiDRrU+rJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vz0qcBIzSrgdaI+C6DOoQkPpCZwitjYANQkZFXi5QU5ohoFj3zKl4z6nUnoB?=
 =?us-ascii?Q?xjlYfxkp5kug5C6sAn6TGLHJx4o6hUmYCiXsSLNWEuWH8kwEYiTCvp6Mt71R?=
 =?us-ascii?Q?6MltkK7wwrLHowYruq3QSdZ2FRTalitqUMJmb5r1fa5n6ccEYzK9/r9eudGi?=
 =?us-ascii?Q?ra7IAskypGkaBmsustglZP4D73zRq/UPXry5JSFJJCIuRrWjOsuqmj90PgxF?=
 =?us-ascii?Q?M1d9/XUlrYnP0KM5oaE2R2kKluNx4TQp6aN+SBZDcoKrvrZGGY5ZDPbetPv3?=
 =?us-ascii?Q?kKjFa8F0LDl5p+WCuo8YYh/yw2I8OHToe4F+MNF89ofnIunEBgtNXX+dIF+e?=
 =?us-ascii?Q?LjKlfGHaQAIr2vc1Ymoa8+05l2fugsTi8oE5iAQ0HOCOqbkq52BrlBc5ZcNZ?=
 =?us-ascii?Q?Vzlhn5vPmCplxHTWDJbJdbxpak1zaQBtqRpT9+wm4UG7Ot/ieaVT2wZ15NjT?=
 =?us-ascii?Q?QXvgb0L/5wGJMkUbh72Z5ipApKgW1qLb099HfyAP9RGugh7doJR8RZyXqPJD?=
 =?us-ascii?Q?PQJt+leuUdSPEG08Ed/l5UzLSU2PdLaoVtzMseCw8Jo7tV7vsqg5wAsjyMcx?=
 =?us-ascii?Q?zskq1Ej5Va3u/XKcjWozJhmzBQJNFGff64fciZI+3DYYVUhdWjiLU50vrTGe?=
 =?us-ascii?Q?sEVeJHwPISxQFJu5QuM0N1lGlW3Fk75mL+EZy34xLvcYYMLksmRrT1XmH9+S?=
 =?us-ascii?Q?YJmTMAsDrYaemag6oGM1j8z501RZinGTWAdvobt9Qk0sCoLESxP7tvASHm5y?=
 =?us-ascii?Q?+Ibh0Lh7QXwXriNNfZC1QA0RFtZ0AAU9AKojirz/SYhNBrLH+XBAslKq8SU6?=
 =?us-ascii?Q?9YWky8z14Uk7s9SYGpjozeQZoXS2bveUDUHsu2SrGmuvraffU5DnvMMh04Jz?=
 =?us-ascii?Q?2rNulrQI4zgX7vcIMxrWKIjRR47YW5BYyw8s5iBiN6wuHHkMTh6x43NIPLta?=
 =?us-ascii?Q?a0ZFz8LmBzZ/U+2UdKqxgdCNYyCp/QmAJ0SY3PyittGANuOs9QRRQZFnvHyV?=
 =?us-ascii?Q?sJJMjhxS43FNXdubyNy9TsO4smsg/poSjycD2boZRmSeA68isI99YLnCg27z?=
 =?us-ascii?Q?X2Q1maKoULhtlIzdTVIUkpwIZfLgkoCxRyuv6Wc0GGwtuVrIrojIINa32WA9?=
 =?us-ascii?Q?VSsd19dU3g7SDNtI08DZetppxTnFpdck4C/OFQUN+GCZuIyetSHqp+47d7T1?=
 =?us-ascii?Q?VqBktg4x6uXZ/uUjSZ2simCbutqtFBo8TBJV8gRLgF1P6UR8O3kDhDuclvt6?=
 =?us-ascii?Q?nCZz3QBo7H8d78vruO926LGjI1iNKJgzMR+WZZSda4lTrghGf+q/4F4N0Q0I?=
 =?us-ascii?Q?t96874HYG9GJ7woW67XTPdOhtdkdeVAzUmso81z8rYuJ4OwyhsdjiLc8m+t4?=
 =?us-ascii?Q?cJmQ832ELkQPF9cSyvfGaLNls/rvESutZp6jdRoTHzwTmyVJsWPvHkdboo4M?=
 =?us-ascii?Q?IXhih6YNWZ4vbfn51WLFnqq6ZJTc+G2Bmhy4X2mgcBZ5mOBDOoQB/zmBxe42?=
 =?us-ascii?Q?zr425JhTz7XB4WT/LCpRBi3L/tB2fja2VTdTEw3fLyMOACJSMVkXSC3yEjMY?=
 =?us-ascii?Q?RGJdWEJcR1ZTBMMQSr0Oci5ONb6mqtqy9d7KMg3xoTGYXNmPXb8FQyMsuHAe?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f66860f-a632-4262-6859-08dc9bfa7688
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 07:25:21.3164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbsEX/Uq5N4u8kBacoCHDT/0nyd9mvvr9RDv1GxuzN6CKLcVZSY9+gHNJNJwKr7zyv942Bva83VjB+gFLc/vGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...the following build failure occurs in selftests/x86:

   clang: error: cannot specify -o when generating multiple output files

This happens because, although gcc doesn't complain if you invoke it
like this:

    gcc file1.c header2.h

...clang won't accept that form--it rejects the .h file(s). Also, the
above approach is inaccurate anyway, because file.c includes header2.h
in this case, and the inclusion of header2.h on the invocation is an
artifact of the Makefile's desire to maintain dependencies.

In Makefiles of this type, a better way to do it is to use Makefile
dependencies to trigger the appropriate incremental rebuilds, and
separately use file lists (see EXTRA_FILES in this commit) to track what
to pass to the compiler.

This commit splits those concepts up, by setting up both EXTRA_FILES and
the Makefile dependencies with a single call to the new Makefile
function extra-files.

That fixes the build failure, while still providing the correct
dependencies in all cases.

Acked-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/Makefile | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 0b872c0a42d2..c1269466e0f8 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -73,10 +73,10 @@ all_64: $(BINARIES_64)
 EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
 
 $(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
-	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
+	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $< $(EXTRA_FILES) -lrt -ldl -lm
 
 $(BINARIES_64): $(OUTPUT)/%_64: %.c helpers.h
-	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
+	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $< $(EXTRA_FILES) -lrt -ldl
 
 # x86_64 users should be encouraged to install 32-bit libraries
 ifeq ($(CAN_BUILD_I386)$(CAN_BUILD_X86_64),01)
@@ -100,10 +100,19 @@ warn_32bit_failure:
 	exit 0;
 endif
 
-# Some tests have additional dependencies.
-$(OUTPUT)/sysret_ss_attrs_64: thunks.S
-$(OUTPUT)/ptrace_syscall_32: raw_syscall_helper_32.S
-$(OUTPUT)/test_syscall_vdso_32: thunks_32.S
+# Add an additional file to the source file list for a given target, and also
+# add a Makefile dependency on that same file. However, do these separately, so
+# that the compiler invocation ("$(CC) file1.c file2.S") is not combined with
+# the dependencies ("header3.h"), because clang, unlike gcc, will not accept
+# header files as an input to the compiler invocation.
+define extra-files
+$(OUTPUT)/$(1): EXTRA_FILES := $(2)
+$(OUTPUT)/$(1): $(2)
+endef
+
+$(eval $(call extra-files,sysret_ss_attrs_64,thunks.S))
+$(eval $(call extra-files,ptrace_syscall_32,raw_syscall_helper_32.S))
+$(eval $(call extra-files,test_syscall_vdso_32,thunks_32.S))
 
 # check_initial_reg_state is special: it needs a custom entry, and it
 # needs to be static so that its interpreter doesn't destroy its initial
-- 
2.45.2


