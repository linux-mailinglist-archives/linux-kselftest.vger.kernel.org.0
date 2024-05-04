Return-Path: <linux-kselftest+bounces-9452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386C98BB97A
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 06:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592491C217A0
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 04:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7E928FD;
	Sat,  4 May 2024 04:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TBqU5cob"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2CB33F9;
	Sat,  4 May 2024 04:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714797829; cv=fail; b=Spa0dE0fT9BOU04xHqU/JHpwaptxHtL7Nw/Qsq/Zfe4slX01rWVj9bkkQf81VtOfMmXSRqNpeNHx2IklgEnH1XX/tOym5ncZ5UP8Hr+zsLMIeXeP2CpZnmYzRd35YtkZtkRbvmkA6LrUwqvEz08bxE4dDjGv7Kwq7TRz1JQtxN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714797829; c=relaxed/simple;
	bh=NUQmwSJhkdCKSdD1hdLCCfeWZVTDqeIkq+px9eAesFA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E2ly+Ivmpv5flmcc/JlnltRvQ1t7xzQFseBTA5exfFdjb6iCbJXk80vz70ffidUMVDmRqXBwrc623KUM7gJ8uo9+kwQmxniAGbG+krPM6VpJM9ctQT3Yk+aO7aORZoAxqvzIcu6tzfn9zhUhHXSbw55uzrZ2UkP0Xv+fvDabJAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TBqU5cob; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdC4x1K+D688cqBdZhhMjR76xthY/PcmmGhWkrYpxyZCJAZko4znehnpdCq2uUHdIx3ehYPJBYfp6hho4Y3ygkJ/HlFPrA+1zyZxvdKHfA6a5oZLhrc/7s5CVqN8A59+0RRYvrYE/WTi6R0w/EYfroqfFBrBHsL9PNHLXt6tQpjz9CqO4oGZekvVuTcZk+qdNczfeIkPt78n/ICMrjO4d9jv/ko4UJkZ6/wL4Drn+rPBEUP7jdzOcRm/WrJQE3SwyVm5Y1LvQ2O5cNm2HY2kaKpdbQHW1LDVJ4/DrKWaQThM8OBm4oygkXaOFQ4wGAri9bhZUZGcZnglXCg4ZB71FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+9K61I8yFJ9e5M9lTTE9uk3gtVQ+p7vSBgx5VTMXB8=;
 b=g++jlOkpFPS6oPQKEYJIuIPTvkGhgv3zc4DZiO+1wtFT8w9+i+Acb28Lj8bQU3B8ytDMujXgM1g7Dc7RqNNCdB1ERqwgSP6NZ2Vjsri7WVo0Kp/ejYmKfxmPgkaaJX4rKiEoyQY6osTTCIgI15EIaUb67BSj918sFX5Vq06arZOpoYMWgnsdb59VrLLrIfTTrBTAJD29un+Z2PrMmTGUvC/gO2K00fLvNJ72Hl3G72VYFSmmNTbRoPnfbc9bi8qqvRRNJQZvzoD7T/mdEkw9WfRcT1mZSkM5bBkEIUrtbIUC4pYvm2bGTcRgYkP4WR43kP9UH4m2KZmAUzQzi5JQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+9K61I8yFJ9e5M9lTTE9uk3gtVQ+p7vSBgx5VTMXB8=;
 b=TBqU5cob5fPWn2rJzq444B80VfcbH96dqos0qpbYX1j6Pj6NpHmn9oDllhAV3WDuoUO6ayoABSrCFOjSbx0131xQnUfDSv8oxX0SSAn/EUQMeuvv1RtZ2KWy2C60++C0l8T2q6PwL+y35f9fu+HK+ijpuo5a1PyYPvd0L7y3NEYYQjk7tzB6EP4f8/6NeTHsIfJtlkfLnYRBccDz5uGO7ASBu4tEeijioafeqomX7uLc2j33h6PApG7jqXgdsb5i5ezLnybddu6srK3EjVyG4PZU40db5/l95erfbh6asmJd1vUsnAhBFcivbmmaykAeU765WAwzuLM6uS18Xb5F8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Sat, 4 May
 2024 04:43:42 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 04:43:42 +0000
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
Subject: [PATCH 1/2] selftests/openat2: fix clang build failures: -static-libasan, LOCAL_HDRS
Date: Fri,  3 May 2024 21:43:35 -0700
Message-ID: <20240504044336.14411-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:254::16) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 7321d832-0a75-40ff-78f4-08dc6bf4c626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+JIOBbmChMS6ULHxj9zj9HHI+tH4jP4iZyYJ/2FGYcV5vy0OzPwglGwQom6g?=
 =?us-ascii?Q?ll1RuCUKhSMJ2LxzWs+ijCJ54TDWt+qmZbuYGbzU5639WrsYUxSqs4TU/KR8?=
 =?us-ascii?Q?TMtzX1xqYGwEXsf2ofN9aR4aAFo1kiLxHH3jhKmr2igxiQKAXf8mwxVLeixZ?=
 =?us-ascii?Q?RivOy2ji+t8imikG2fQKglbTfSxVgNz7XsSPhJyj38Jwcg4fuKJPn9AvJxY0?=
 =?us-ascii?Q?NcQ5lvWDZgELepTCH0FtV1cv56l0xgfwMIVePuIp07Y3uU6/DhDRtRtpyz+R?=
 =?us-ascii?Q?zHItoI64jZm+/UsIRQIrdURDTcgKQ/BqX9sghFrSnWAj5g1Oe1LfH6GpzUm3?=
 =?us-ascii?Q?lXim/LIteoXd3PPhQZgKOn3g0xQDbEiQeCZj4sKZlvRzNjXoIz72ycrMBR+q?=
 =?us-ascii?Q?WS8061x2yeu5oe/qkURFkivMjiTO2IFJ2xM2vBeoOM1C9lIlzkM1BM2iiGz1?=
 =?us-ascii?Q?p2ERmeRLd2JjjNPO7Nnl7RvJYmAVwIbUzdXSaUKID3wMFQ5AMbI2kkIfAUBM?=
 =?us-ascii?Q?smc4YK7A1lMaokatA2Id5thZzuqBLvrbzcTyGLW6FSegT/gPTDCtUHXJP23x?=
 =?us-ascii?Q?yk3GqKdeKFRSdVbxKYulEM+p/Ge6VjFgWp217n7LsRz0Q8quEXORIkPlvIEi?=
 =?us-ascii?Q?+K9/BlMhcswCweaxCqS4Yat014XX4fDCcYln2McSk7mfQ6UpxtMbpgZnsJ0B?=
 =?us-ascii?Q?CtQcXLBgm7wI86UlcximE13MDS43SSyjpJnuTPmp/MMe2sHMuWdbVWX2tUbw?=
 =?us-ascii?Q?K6QGhCcxsVbeo7qtHCwyOWlFK3DO0ji7T9MktSRMCqNu9pFAgU9bi41vzO2o?=
 =?us-ascii?Q?MeNFITRr6V1IFVIsSltdN/81kXh2PmJS+7FHk7o0JdrfLT1BkfXn+HX9P+YO?=
 =?us-ascii?Q?4YymZhdbscTjMwqFNqj/YYBcXaoxZX9AqVq2RfeJUHqfnW4+qtkbf0qeHku0?=
 =?us-ascii?Q?W3P6QJGw0Gxwd65dUJt2K+QRykmCpTfcHvpbihldv8vQTYEhPnmu5WJG0sih?=
 =?us-ascii?Q?xe5bOHJpjqyo8jKssiFsBSJOMzJAnGXGMQcCIskJtdCuz+tdW85gCCA2WoOg?=
 =?us-ascii?Q?I9CTmXfXuLITBwuHBPwHDnINb3GIv3+cvSgf7WrlVak9CKNXn/rvIL6W/Tp8?=
 =?us-ascii?Q?9Hxy5dL/R/9XZ2SYqse9VXNuONynKoxsufJ0acDqkKWsHRy9rvIGE7p/8fht?=
 =?us-ascii?Q?DfxDKYg7DMVsrf38FHLWf84wE7WRReqAtBrsogJuyeuzqRAxZxF0nN0o8EsE?=
 =?us-ascii?Q?viaRS+DdEaVZeuL65yry3+bVFUbJG5a5anAegosdZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wYEBryD2c6DCZPEkH1RsIOqTq/wdNSaFLKCKkMo9AJOWjsWN6YRhErCOM/Mn?=
 =?us-ascii?Q?oPXW0ZoA87MujrGNUp8hxXRBxZSNGg7vWJL+IkFqMdPfx4VOBFaV32uH3NxL?=
 =?us-ascii?Q?kXxCJ54BTk+Cul9fKNls5eiebkxkIRLzVczjKt0yGy94M+PFTgQ7DH60Knfl?=
 =?us-ascii?Q?dlissZ9s4vdV1xmcjcfQvzJVzKbIWKyZxi4TGGFIFJthdI5QpUDU5RaZ64nV?=
 =?us-ascii?Q?p23r3En/6wHNEZ6nQWzUKH2d69C+LOviJ/QPyJ98MJWaKhffUhDsT3GxmiqW?=
 =?us-ascii?Q?qpK6VoNaS6aOkHQEFmmlGhi/NttThSDeHd7XE93HEhVqlA9y2Y2AeQgXvQek?=
 =?us-ascii?Q?vZ4F8O5QSEP/K3A+zATgNkZ+2B9C9kgDttbfFNWEUc2qtBFWk70yCKWdTyIM?=
 =?us-ascii?Q?fzZ3KSOG3wyZ+ZOVvTeOq2PnY+6wKQWlUZAOYmjZc1hhdkykGQRJAnOJCecz?=
 =?us-ascii?Q?Hu1wOsWvz3UKwvqTm12mwlgmk6u7rljSzC+ZTRkkgQS8mhs7pOtzUdlZ8vZg?=
 =?us-ascii?Q?R1h4WddbLCgxHM/A3AUbxVdE6V3AZqahgyODgCe0vn86d9VCy4EPQCojm0+N?=
 =?us-ascii?Q?IjIzQMohpAf2UQoVuGVzdFmfEkomsdf2c/D2DzqlpTXeFHsSHUMMNSvF40mf?=
 =?us-ascii?Q?H9v+YXNFn3FyFZS+j01tPCi0F40X2XZQQylJj6yPdqefChblpePUu2hO/loq?=
 =?us-ascii?Q?LfATNf6qdhQfHmsk6ZjUtjw7AKRxcvofBgDOZcNTirnN6mGhVBVcU1w89j9E?=
 =?us-ascii?Q?Jh95IqFG3/05z/SmQdYGq0R8kdP8nrYop4axO6DDI0M0TwtucTndq3V8oofz?=
 =?us-ascii?Q?EPbQdsp9RtdMRzLjWQBjsyv3VeSkwCXqh0KBaBlak6ZJA0u6fKte7gWyRNNO?=
 =?us-ascii?Q?wPhSYP0tyFLZjw3xGnvPRg5sIzCItl8zVP1xHvasQXypFjcje4rzGwVJNJdy?=
 =?us-ascii?Q?3LwcwOynwn0MPTHjOkLRNsXnqNoH+hep9rZaGpKiSytbVtYmS39LxIzpwZBc?=
 =?us-ascii?Q?AzjvsnCHFN+jImyA6+q4n7dwNzkV/XaZkGfsIQkUF4l4ho0QrDyyHQCp8/K1?=
 =?us-ascii?Q?8ZbwqQDXkgOB3bRE289pZhXKW8qSWnKIE3gp8Hb8M5rzetJTBOj13n/5IuiP?=
 =?us-ascii?Q?kLr0innOmjGdIRh/0CXZje9w7TsYMjQwpYtuJ4xONlN5BfE/orcp/+c9IjSj?=
 =?us-ascii?Q?T9IOp59ty2qFOE8TaGnd42XU5PZwCRzKShuHOEknKBIHyAnr0TSdo+bJnEC5?=
 =?us-ascii?Q?EIYwahw4fJ7pHKwdzhk/B0mtsvvCydYDg+Isf4UHuZhbHoI4NJH/S3TNnLeh?=
 =?us-ascii?Q?kyvMQzaYWC41bc6Be2lpof2r/vczInfwb6b5YFDuNcdERRLVrICAw8LA2bXh?=
 =?us-ascii?Q?vDceSf00GPQ7FsougGX00JkX9IDuTcjue4STjQJzcsovJyjwLwr37JpPTeZT?=
 =?us-ascii?Q?9ZKV9FSFfAJXKjR4LGgc7wTTlTr3sfJh2/dCJL7HpdqsqcOOX390vjKV0g4f?=
 =?us-ascii?Q?FmPkxZtws+qyVZBoH+dBYtITdTs3u8BZBlIWv+WIdO+ddDyfvXyVZrWZyQpf?=
 =?us-ascii?Q?t6qNIOBK8+xBRRSsCf76XcSJwmN53aYdTtFagO1Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7321d832-0a75-40ff-78f4-08dc6bf4c626
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 04:43:42.1419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bnqx9cqp81JFHKtmt9CUHOe/nDO8cjYFLVnLAHWq0Vkh9sPZ/L6UkC24c+RxjCWMsF9uzWctLeS8cu0GvnBzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174

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

Cc: Ryan Roberts <ryan.roberts@arm.com>
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

base-commit: ddb4c3f25b7b95df3d6932db0b379d768a6ebdf7
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


