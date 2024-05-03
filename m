Return-Path: <linux-kselftest+bounces-9312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E2B8BA581
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 05:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D5C1C22700
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B4A2C684;
	Fri,  3 May 2024 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z3Xm39li"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4323748;
	Fri,  3 May 2024 03:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714705353; cv=fail; b=Wykl9+fr8f8n4OiykrK9SjGCVaidsz55BoyRMzuRaGojuiTE/rq61Ft5y567tp7kYsAJIg0WHnciCi13yWwFzfxNpsZOm0bhL3jRm8AIM2dfbC9yECJrcenhQZS/iHDrHCGFO0oL0/HVJh004sX4vFkzDnTwgWmvBuRt2AHnwA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714705353; c=relaxed/simple;
	bh=Gv5MNFQjHt7YKiTu3eHcG3fEBXerk+8LxISmOrEvjo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LcZZGxA4iCf7nK5Oqff/6JBUSocHr8+61/F2uVLN2sBbBHiv1JOs5ff+TohtMHqlQiJIdzK+7iU/LU6RpzOE+WWv260ZqOlG3bKnalzCwKzZVKZJq8k8nwzRJ9wexamZouXRqrMZl6E7qeF3Ng4oN1Ak7jVG6JdeIp7qjFYnpAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z3Xm39li; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYPidyHBSXwZf3l5/r30oqZXX3+SyJTvB+6Ode1UM3WZ6MAZMZhluUvXYBHlAN+dKrXI1ce8oqDjUS5ZTNP/aRX7u8F3KbTvJvTYbXRR2ccRTt6jCOQrovbE+BnSGjyvNSl1Qr6q5d36ehmGQG4AN0jZtOa1kQ0mi91yGFEvebfReip1RFJanWfPsid6yEkXqRyo5+vt7wgkNCuSYpELEi5noYqLDiH0c+fDbyayfHKDqC3SZ8PyHZYI1ZymWY6cEPsWGYpwhjqkMFONFhDeC8DQJynM0VH8TURUBcEAHcLLDXT4KtYys055KCifj7fo4ALXZg78BD9ZkaUSQW6rBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZmUlXAUJgZP4ZJ7jjUF7x2AitQ28TLfjFTzo9TywuY=;
 b=Ss0LP3GMEDdEXlcfjq3IXaZ07Ev07fQc6fuv+y21lwua6Of3desaZ0k1m9mj2ncDMDbR1vC8ML1nsMtWhGVIomzcgp8eKmjI2tR9hVgLSExa6zUmvbqXUTk2YKiwDq3qDDNzLVGed5i6lezu4NOYkMSD1MOprQ3XmaD/YovctBS5tn6ooEFrVMe316hLMpAQTuJZiNcX1mO4gdLKzolCsM61i1nzqvqGbwQqmpuqmKTVyTsUs2blH3/S0jxiTavboNw+Fsry+n0oHLzz+F34OKyQv3gfEtzRpWkoPqtnSvds/sEExqhdcnZ12nuX1XjgakfZ8LUko4jAOpvSKTZ/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZmUlXAUJgZP4ZJ7jjUF7x2AitQ28TLfjFTzo9TywuY=;
 b=Z3Xm39liQosBb3jCk/1cZDZjqZIKFO4WNRHgiBQnIeYRyII11Tbqq4ndElecWYKYZDghKR+JHnWlS2FrUpFn99336sEb5ltIRNg71Nu7zmZ0f0CJtuNeS9zp6h/cTP1nQh21tN0SX6uWpaPeJ8CinCgqpvlcCImqTeBkZ1YpSJxGT/UWDP7wjqzgLESYJLn7o3qILsWhDqzLzILqKrHD5BHPqZ+sIdYtYCcytHbHWtXAxOIs/W4/Cm3uFRn8G8RwdbbBITte8kMpGX2CTfDqd+arHg6AKYKuaeOR4GGGwEwz+jB595NPI1M0b/QtGpwa7zwwfxS3CXnBmecpXpw6Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 03:02:19 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 03:02:19 +0000
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
Subject: [PATCH 4/7] selftests/x86: build sysret_rip.c with clang
Date: Thu,  2 May 2024 20:02:11 -0700
Message-ID: <20240503030214.86681-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503030214.86681-1-jhubbard@nvidia.com>
References: <20240503030214.86681-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::7) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: de5a64be-f814-4b1a-c878-08dc6b1d7227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KzZXgRihM2j9kewsqFML4Jx8w8wyv7SmtiKqR2Bk+spD3Ee4faJ7Qfux1z08?=
 =?us-ascii?Q?40qhYQ7UAmoNuLAgDaVuUlOaZqccrLFgR83rtibwG9Zg1IkQlNNqCQq9bJVh?=
 =?us-ascii?Q?qCvagCHrw+/jpYZuJeIRazziWkudOn7wGBxD08wk3er13KKpaJdrnwIiLsGk?=
 =?us-ascii?Q?O1gJGYE2JbDZ/m+ztHo5DHh1AR8cuEBDPuQ9evXQKmGHFkZn9te+e/tRl7+9?=
 =?us-ascii?Q?kf1z3bZCJDksDb8KEYIjDSaoXIGGadQc+2QDqEbERk/8fpFmDnE7Jfhz1Dt7?=
 =?us-ascii?Q?mKfNs76wbNcpDJSRFcsn8VIA4+s6cK4NSC5++jS9/8zMdZLHnDxFzqNI+RTI?=
 =?us-ascii?Q?SoUkIUEEhNxGOSoxy8n4lQz4mXaSDIiuHF/UtvxXTkm1HLqo58cKXUzeIgZS?=
 =?us-ascii?Q?BZywjMVBIh1CIHTJwMMARdcfOhBhTv2AeYLVJnRps2C6vQ4wxd/1ERv7RC19?=
 =?us-ascii?Q?yHnsuXm2nLTt541hLujhv9yESy63kUBMUGD9KE+i75Q1/zBN/AeNSS0b24DH?=
 =?us-ascii?Q?GH5g5ObhuLJn/izpkU0tik99itCFTfXc0Z2BHiQzQFedOS5USAOC/sY84wpv?=
 =?us-ascii?Q?Hh8/P8y4DtKyvugwcMi+q44wtQCIfLAgYIXFM4G8imJ94fF9y8jkVinQ59VF?=
 =?us-ascii?Q?mcaUU/NWkdS4P8AZwRBHsw7HTOzd+lsk6CIw2R1ONbUYUk2OKJn2J4sslFkE?=
 =?us-ascii?Q?6sJmlnkj8wx1nJuXmKLfSsvUdmEhM49SXevTUtj+6U3e1YFymvWuFt2pAlSh?=
 =?us-ascii?Q?GJ6QhhAYYd20BWEL9pSpJkEh3zEgDUo9S8Sn5y5s6cZ6dsreK7cVxU8LGur0?=
 =?us-ascii?Q?zPJ4oU6LHoZqYWVk6l+8bbuZGy/PRDQpYNjR322v+FAnN2/QaP72FkPraKcQ?=
 =?us-ascii?Q?CSE0KD76gvNGizPcU6EKu5wHeAsRxRz2pHgmW6Ghlbt8GUYO8ejiRVDj5Sxd?=
 =?us-ascii?Q?fiqXvb3Ij37IYIFuo7VzEu52aj9oc63jBdj4Hx1Qj3KBfMBZEw9WJSnOGaj4?=
 =?us-ascii?Q?iW3zsV87COC6iF3xx/545JBwLxBUNILUL2Mdz/0t5TOMHjoFdf8erYTR6fm9?=
 =?us-ascii?Q?PH7n2VKL+B9DtBQ9mF6vqRM4hJnVgIH8bFaImI4amZVaPjAxzNn1BjWxDG58?=
 =?us-ascii?Q?tyAellpTArjf4F25vGAIvmQFVg5pq5LDvO40gp8+jkXmajaL7fhQuVhH7Yxf?=
 =?us-ascii?Q?E3mtRnpaSlgyW5UYk1ItskEu5VOogSqZnBjgQi15zHhwzmCxI44e6H68aMX8?=
 =?us-ascii?Q?7qxhBZXAIIHd5UyanWvCHDe4D8JQTC+02H+JSwOu1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2+doEb4jMegOjYuKoSvojUVs5dHXWPyhrJ1h4Td5OG13msfSrlvb6jSkuupm?=
 =?us-ascii?Q?8zSJQQ+oVL5aquWWiyDSfDdFDnHxeObX5e4Gp2W8hv2gQjtjLgH5GwJPzhDw?=
 =?us-ascii?Q?mek0xnxVEGMV1CL24wGa2s/o3mhJ8OdE/cLD8NHhrdZ5+3Fu3d5SpLrWOEeG?=
 =?us-ascii?Q?uuhV6TI0ygkJccWtTDzBW+SL2SKc35+7CAGaHRijJ6U7RbXRqLW53HKEJpTR?=
 =?us-ascii?Q?XR2Su+782uraASW5Ff6Nq4u3MbtxyqZuXRnGRvS1Vz4dI2UTs16kyMdkaLyG?=
 =?us-ascii?Q?Aml08QkTNrcU3ohzvOMX2fkV7hjtvmVuV5TGyrjqRRBRal1tmXPsmkTs9d2j?=
 =?us-ascii?Q?/C/D1EXYHNEV0wDgSFcWXbRGX4D3hTnCz5iXC9ICkMNhdFjs5U178c/0gRho?=
 =?us-ascii?Q?t7YR2s/zAy24rLCTukemfpUx2hk/aUffyD4bsF6Lg1ZPYPgj1VDzqkPJELLJ?=
 =?us-ascii?Q?F8Bl6/ZM6HHAKnivH5Tvi869cpy3M4MlgAQ2Jq1Hfi6cK5wiGbRe6S3mONUh?=
 =?us-ascii?Q?e7oGz344wX3skwIYiotjoHPVQ/86wK+qFuEqnrPO3b3MyG+VeruTGHL1loxz?=
 =?us-ascii?Q?TyL4fAqKMMOknySVlfRkJKeqLOVsolk24h1SRWUQ4lygQ/MzmToRBAvuLwsV?=
 =?us-ascii?Q?CxwUheI+HmQ+I3TCsBRZCQJoXIv1uiTZlxY/o52MtBzpXUmEl9aZAy932p8v?=
 =?us-ascii?Q?i1r8RtqlFj5g0tdFZDQPK2CvQskDOS4CnbQLT9VWPWnwvOlK2xvqVTuWceaV?=
 =?us-ascii?Q?zpUiDcnQFeqdL9Mg/VDP8pgLMOGomN+mqZ/MdwrwT0m/1OLCug2o+w4mXeK4?=
 =?us-ascii?Q?yNXlYlGjrRfwQpe+A60gWoMFRfNuS9IBH3/uGYFBz0qzxl+ldVlkodIwJYWF?=
 =?us-ascii?Q?7NOOJxKrxzoaF3OJG3fbv7MFywHKvPqq8UBVgdZFKKZQK0crrrzhUVh8mvxj?=
 =?us-ascii?Q?TqAWn7a8kRm1bR2qZWJVYRK1IHLvJy5FTVhkzJARFMK+a9b4h0cdFAlPqWvk?=
 =?us-ascii?Q?SdnHVRJOxu4s0HhNXWfvv8WBpmL/JQ/7mQ/3+eUjbEd3DozK71HfBnCiHpXT?=
 =?us-ascii?Q?sNz1dtt50TPpkcqSzJVoMYdYSqUJQFcgs/jbDAPh5fSxXwk8owf2BJDY4aGw?=
 =?us-ascii?Q?AltN8OrZERRQUh96O9Z+1kf1ynA/sfFtbH43qXqtkCFED+nr8prvJzuC7vNm?=
 =?us-ascii?Q?hTCUCuamvNlWw+jSaiJcSHUQ33QaA4KnK7uiqAv2XSoDX223kaxNYHaXLZHa?=
 =?us-ascii?Q?X+Cn+ZbQw4RznIbxm67SPKmZ9vikz7t0CYbNMXCaSWU4/VXIiLBDOvFTpXZE?=
 =?us-ascii?Q?kf9obScl5elG/LnjgPAKCSnYeBS5Y7NOJ+TPTQCVDLRVFR8aJGYHPVdbWlBC?=
 =?us-ascii?Q?mx9tKd1zmWuWEbvNQ1MjItO/ssvSpJsQ+4B0bnD58xp+BU3NtQS0JNXFo2YX?=
 =?us-ascii?Q?zxbcfXAJCj7Z83PBFomvWQUbHE4xOXa69xQ021xRLOMH0Jh2aeUuDxAsgNZU?=
 =?us-ascii?Q?QMNoaj+XrV7ivQ9DKmyybr8x6N337QOrkoEvxYiXDJqOM1WskLySlaLcpeqN?=
 =?us-ascii?Q?Uq0zeqUEi1gnDEPI9GCzfThpZxlQQS2FitUxW98c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5a64be-f814-4b1a-c878-08dc6b1d7227
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 03:02:19.4060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRoy7JuqtIWscrbXROeeHA7YTMRqif0QWQQXjAGlMstSvpFzc+Xs9v737Gph4o8KzESWJu0Cobo0MUQb2r8low==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...the build fails because clang's inline asm doesn't support all of the
features that are used in the asm() snippet in sysret_rip.c.

Fix this by moving the asm code into the clang_helpers_64.S file, where
it can be built with the assembler's full set of features.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/Makefile          |  1 +
 .../testing/selftests/x86/clang_helpers_64.S  | 16 +++++++++++++++
 tools/testing/selftests/x86/sysret_rip.c      | 20 ++++++-------------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 99bc2ef84f5a..d0bb32bd5538 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -115,6 +115,7 @@ $(eval $(call extra-files,ptrace_syscall_32,raw_syscall_helper_32.S))
 $(eval $(call extra-files,test_syscall_vdso_32,thunks_32.S))
 $(eval $(call extra-files,fsgsbase_restore_64,clang_helpers_64.S))
 $(eval $(call extra-files,fsgsbase_restore_32,clang_helpers_32.S))
+$(eval $(call extra-files,sysret_rip_64,clang_helpers_64.S))
 
 # check_initial_reg_state is special: it needs a custom entry, and it
 # needs to be static so that its interpreter doesn't destroy its initial
diff --git a/tools/testing/selftests/x86/clang_helpers_64.S b/tools/testing/selftests/x86/clang_helpers_64.S
index 0d81c71cad97..185a69dbf39c 100644
--- a/tools/testing/selftests/x86/clang_helpers_64.S
+++ b/tools/testing/selftests/x86/clang_helpers_64.S
@@ -9,4 +9,20 @@ dereference_seg_base:
 	mov %gs:(0), %rax
 	ret
 
+.global test_page
+.global test_syscall_insn
+
+.pushsection ".text", "ax"
+.balign 4096
+test_page: .globl test_page
+	.fill 4094,1,0xcc
+
+test_syscall_insn:
+	syscall
+
+.ifne . - test_page - 4096
+	.error "test page is not one page long"
+.endif
+.popsection
+
 .section .note.GNU-stack,"",%progbits
diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index 84d74be1d902..b30de9aaa6d4 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -22,21 +22,13 @@
 #include <sys/mman.h>
 #include <assert.h>
 
-
-asm (
-	".pushsection \".text\", \"ax\"\n\t"
-	".balign 4096\n\t"
-	"test_page: .globl test_page\n\t"
-	".fill 4094,1,0xcc\n\t"
-	"test_syscall_insn:\n\t"
-	"syscall\n\t"
-	".ifne . - test_page - 4096\n\t"
-	".error \"test page is not one page long\"\n\t"
-	".endif\n\t"
-	".popsection"
-    );
-
+/*
+ * These items are in clang_helpers_64.S, in order to avoid clang inline asm
+ * limitations:
+ */
+void test_syscall_ins(void);
 extern const char test_page[];
+
 static void const *current_test_page_addr = test_page;
 
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-- 
2.45.0


