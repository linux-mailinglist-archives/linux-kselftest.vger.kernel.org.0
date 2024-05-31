Return-Path: <linux-kselftest+bounces-11053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521828D69E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C29289E50
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 19:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E7F17FACB;
	Fri, 31 May 2024 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z54wfO3J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9117DE17;
	Fri, 31 May 2024 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184334; cv=fail; b=RNWx7GwGjJwLdB0msFqSnKPdgBqSD1hSfmtx7fcZGXquIeYegki30UllwMnSaxt5lPSgNEJhTOZ/R4MuSC227PRLmK/a8ATw6A6ZwW+1kWNW5+aNPMem+KX2+f8RaCM9aQ3aCKbdk3GPVqPRNiGIueB76wNtVJcyPAKc6wrgO/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184334; c=relaxed/simple;
	bh=LcWrjcndeq3iuhARrc/mp+c08zzUu1zFoYgBoT4w7lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NB5YuMSD4M1s2S8h6Ah9E7TgTk4j46fCVoXdBm5b0H3IMSx16J6c+3x6KOjJxuyc2ZCHd11a7zVOpU/4urzfUlqLL1rTaO3XvROC/szVKoQU7deC1XCmm8CoJqzwOrCuzg1xV3pJw05WdXxV6tBNJS+8dbuwAemd5xhYCw9lHM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z54wfO3J; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuoYVURVWGhgeZdEncNBfj1gpHM2WXh1tDueuJ8eJ3uvjq+6DCLp2KMO8vUvNsooO0Sirne/yYbbCWM1OUNftRLh9LHEhGBpO7T7b2kCOgFbrn2Mo1HuuDMhZ5Y/VQF5X5M3poAQSt4mYUefR3UmvVyfwo+La9Wvus8Wc44Tq+lfMjn0mhpeRChkMc7HJ0MvMaZCS3RJ8IqFoR29Zdr5buYQFZV0nBc1HLFoVBDaxBoYdl5y6Xxd6RnGS0jHdPTjyAncWnxO/dlgPVwc7OtdoV5HDVYwMhMiRg1Bh7T7u0X3ufDWBs9wzhNSx/uKZ5nfS4NWPES63LqUy0ClsxKpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9NVry3VUsyNcWz2ZdDnrII1PJ3GUu9peaR80x/6epU=;
 b=BWal/cv453Fs0BZUN++AQYRfDNRP4klPOGrIvzKs9S5GczYJCH8/a1XXfcxM4weVhWZeIdEHh3qqrn5YSQXr8zAljsO03vgUsLSQe9MZhrXdq/sWpQY2oim8oJb59X93601rvTXsI+cgpsk9XFFtOiqdjNcRL6/T5KNX1QKflCWJuw5PIXmQYM+JTMno5L8tPxUehLS5+vf4PNrOvZnK25uIb1rjA+SGs+XIGLJSmH5kUZMM50PoqmoLRpc5PxFKfpz+h1DJP4C0kQQ8T8GWJW0Jt64JgyZuZrps9jLDeAt3n6xmqpEXH2dq3kdgAghZBXMRue4o79QuiOMe10Awdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9NVry3VUsyNcWz2ZdDnrII1PJ3GUu9peaR80x/6epU=;
 b=Z54wfO3JyZnFJ3IIhlFyvNsoxbWTSpLzx32beLbavEpKoEMeVxPxWbJO4wok+uAvgfWmq7T4fQRCR0ggApDWAWxzxaWPH54p5FfRSCU7dXAbeiW8x0gcVJ9fiTDtlZPS50FvNt9OZNIkfXK/a+hmN0PKGrN1IfcpwccD0skw5ewCh3AgjLsW31E6S8TqXZFMBloR3TeLMlrfFVZKDCvBJQPaB3Hd28f2jXH3b9/tiyBjq+SuI0X6/lhoHH5KrX0VmWJg31R/QFS1t5Qwf+D67TOhViVbL8XiBKx1gNBjCpI/ctnxEUs7oyj8aIIU/9Qt8ejYA3F5LpguKKFL8pgGmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 19:38:45 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 19:38:45 +0000
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
Subject: [PATCH v3 7/7] selftests/x86: fix printk warnings reported by clang
Date: Fri, 31 May 2024 12:38:38 -0700
Message-ID: <20240531193838.108454-8-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531193838.108454-1-jhubbard@nvidia.com>
References: <20240531193838.108454-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:a03:334::12) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: e43449c7-8d04-48b5-4d69-08dc81a948e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sXrdEkxm0kEbsA2jqP4hGdkYIa7Ljtr11xz5PIZyn5EoROBI+NwPF6gcnAjH?=
 =?us-ascii?Q?8213L+PZQg4PrlBVrjGUVjjsbLg7oSYY92lvKKA6UO1+9ogHxAxSZox4BI66?=
 =?us-ascii?Q?NTps3GLbPliS9vs6i4/CIvgpT0l/t8NRvCDwrMivgdkEnhGu0ICXeSfIgIX5?=
 =?us-ascii?Q?JjsOAJ/00iU/cUaorue9k9lxYYq7ruGMMUbERULsPfoy9wuORq+DTUkQGl56?=
 =?us-ascii?Q?HFmeiKKOVfEw9BRfAsuPKyz/+YA88cvdD73P0WlQSd1vF5aPDMFLMDgc64dB?=
 =?us-ascii?Q?SNgPPBNGvMN4Bb31l8pdZ3mElVBjo5QUFKSdu4DjpFQ7iZg//BjjXW60snxf?=
 =?us-ascii?Q?mlM3oi0BtJFwdjKhwIZL6xiShXzFCNYg3hugPjD+BsvjQEO+BNRPJo2lNeT/?=
 =?us-ascii?Q?At4WjnAqUwKjySRO56ytg66/Hk9LyXb4wmDCVHHTi9eqG03IeusO8W/rpVhS?=
 =?us-ascii?Q?8Ma0Rmuq4yaxiuuVrL5n+uaUX2WEIeMrLf51EcgpJCItf9PFfr0ZZ0WSnvjb?=
 =?us-ascii?Q?5VgfOP3wb2L26NjeFn+fsRzvxy+j4eJ3EtP9eXGBfyTomMVqgpdx6lkLGfkx?=
 =?us-ascii?Q?LKEMbPpaSdYC2N26meMTDaM++MVLIFKfoHYaKtBEsRwvdcFdkxl8X8hEputz?=
 =?us-ascii?Q?rjo6tXtv9VkdxZ6Or1qnN0Np+yQdJ6i4w3A3Wgj/Qu5xrkIsnEOnWGicMLEI?=
 =?us-ascii?Q?piZrqbTWceBAZ3T2QL0Fj2izZxFj+21YBnPA94ApEQ4U7BrAtUoTrQbN7+Ei?=
 =?us-ascii?Q?KMMKk4iBjKcOQie8kNp3WAs0RbnLhErWLXxTvrXbgepBUDigD/W3d3WKlt5I?=
 =?us-ascii?Q?RiLKs89Hnte2aG4hrUI8b9F6sfCP2uW8/Wb6BFg9LJY68HfLz0cNjmrSv3IM?=
 =?us-ascii?Q?daj7Pr+6o6Jsv72YiAYZv0558yXdrSupkWOoDYHpuHBsgMZ2Ebzz+63COcDp?=
 =?us-ascii?Q?6Xay2j0CIH6iaTIEvP7uGkTWgpvJ/FCnlcqCt+7HkwBaErnvYmqFmceWBBnR?=
 =?us-ascii?Q?xsTfn0JCUnpoDrNTtDIGdfPIAIXThOM8lFEidMcInJPZ0pUQEk5sUaLIbm65?=
 =?us-ascii?Q?jK7wc5J/sFcWPMeMhFc9oY7EWfKS4OKMkThB+SZp7x1rkpNPIJTRWGlMUoyU?=
 =?us-ascii?Q?q/Spd0dTpNSSPQaOZKvozS1Ndyv4+CI8kHlFyzn5ri7QZ0OMfO+r3UHw0icR?=
 =?us-ascii?Q?SSa0KlRmuTTZxnzG8Vfe5mXJzwHjfbOTFJPxr15tBsGr3i4+mGaJhBiU9i4A?=
 =?us-ascii?Q?lnp7YXgO8qatrjdIm/Pn9uRuoVyrjWRGbQBNphyJSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QekZLF1DdLUf1PpNcrRJlgeB2uZ6Yq2hTMD3nGZxwHLoKpm9YC1fyOAzwt07?=
 =?us-ascii?Q?FuvgDNbl2+U1ucDnhfbBTZ9oUh0aNkdfByFO8OM2fVlC3Hoa9keHZSsMRRpV?=
 =?us-ascii?Q?CWHPbmyQzLmuKCB1xk+Kh7Dnr4oVgyDCbOc8haqHKoqaojhWG5FATgR8GrY1?=
 =?us-ascii?Q?zBB+R8q5CPNFMBe3Y5l973SiWP9GiSGnwmxNsvHpx7k4TYFfWXjpc6st8a1R?=
 =?us-ascii?Q?wcoPafakKX25qLki7vC9OD2v8cDMn+gZUOAyHz+6YOqpSuFXEQm6Of/dyOC6?=
 =?us-ascii?Q?mR6I4EMwFLOfQKixA3GgSJA+XnijYBZw2a/VTemOcxQT/tFc+f4gaS3GepGs?=
 =?us-ascii?Q?x5AD9Nznr/1Dc3cWASTyq9cXWz3bVONDk9rxnWrk2S4nERrs8+n5XouLkH+K?=
 =?us-ascii?Q?XrmA9VS8cPlloDc7/D9syldESfK8AfaCGgpWa/4SD1v+1GNytsoGwN2tnpDU?=
 =?us-ascii?Q?dwU3tBDoMKX9wDuxBObmDDbowrOaQdsXNx0WhzDU7cxL3Fa7FM+47gZTpONQ?=
 =?us-ascii?Q?voSce9HKRkXxY5q5DadkspcySz3GGllK6ifFGA5z/8+cbu3jMLhDY/oXLFEA?=
 =?us-ascii?Q?CdQdWk+eLzZDbRxiL1rUdAIssg+EzPg4yx//MBIKrBMqxPiJ8Myk0fyWEyD8?=
 =?us-ascii?Q?0vApYH3qQP8sOEapYSTzCKhvOAMV7GtYjVr5BsmR7mHkAJ9uibU0EJ8xINjT?=
 =?us-ascii?Q?Nu729xdmgzaeeOc0pG6s0HpPXPL9zeLwcivyOIAJXmdrWKKDQxNV+Mj5zWJV?=
 =?us-ascii?Q?5wzJ382Pqs1u1tGOOJ1LQQDrCd9PzOE9goQ5s17BX7V+0YLyJKrJ7vnSGPpD?=
 =?us-ascii?Q?MWGtIpJXg2rGxVBxdYmQ7QNOjqe0Pz97TrB2+n34vLlPOkB8DZHY4Et4tIdN?=
 =?us-ascii?Q?rvBo+NbvctBIvGaCUNJP/Rq/rwDhGjVeRTsPBmyeHDqxRqcGelm28zjQOygB?=
 =?us-ascii?Q?NdzWYO7oGZRQFGo+LPoHAbtSud+EFUgMOoJXfTRwMSjVWLZM7qAtCPJ7X5kb?=
 =?us-ascii?Q?SZWdeKnyafn9p4blZcdqFg3QN+MA/JeK66EgfmYq8ztW9MJOpOEc0AhGymxA?=
 =?us-ascii?Q?yR5pVGe3AWyfBNfHaPgoFk5osfBnUntP2g8hmZGF4FQ30YFPPLFwM94BdMzR?=
 =?us-ascii?Q?V8WMaIrDsHFTGKRQ6mto0JylSajZvfaS8M4vBDIUp/Jjh/GNe7XLNrKwjWWi?=
 =?us-ascii?Q?wpe7ii7s3a+VdbEosQ1EZmA5O+wvhvjm32YHaBV8V23ec2XINIJXXBGS5EC4?=
 =?us-ascii?Q?4pXgfic1TCwCj6O0Rg7Y+Kzcm4h7bmDTu3LFOqrfLOoTppYPG51o4bHPiQ0D?=
 =?us-ascii?Q?P9W7jThLlXSSNuswv4yldvZLRTYLtwKPjRMS5nwA++vyaJdyPhaQaw1p43ID?=
 =?us-ascii?Q?6GieFkkYCKcB+HmXriDXyiX3ewhmsfuEcWGz7i86rrc10zoQuUt0rjvTHuxO?=
 =?us-ascii?Q?QqFtt8AntY38lECtASizwsNwjz4aFg72LWFtMkXjb3PQGgng++BtP0Z0eIeP?=
 =?us-ascii?Q?c3bpYyXZUUjh/u+fpIw/Q32kd+SGlg8neF+lYO+ongdxwY3XQmdCzkt+GbGG?=
 =?us-ascii?Q?TyfC1Djfh1rbpBXpZdIBLNetzoj6dqvR73lE6bdb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43449c7-8d04-48b5-4d69-08dc81a948e2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 19:38:45.2618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5E6rJkENFqPkz4LVJD/Wtz1vXbZJQ9vYm4vEpY0tpYWjgmq7yuG0dRnOq/K108aKdI70GylbLVMMSWMU7AvsdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008

These warnings are all of the form, "the format specified a short
(signed or unsigned) int, but the value is a full length int".

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/sigreturn.c     |  2 +-
 tools/testing/selftests/x86/test_vsyscall.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
index 5d7961a5f7f6..0b75b29f794b 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -487,7 +487,7 @@ static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
 	greg_t asm_ss = ctx->uc_mcontext.gregs[REG_CX];
 	if (asm_ss != sig_ss && sig == SIGTRAP) {
 		/* Sanity check failure. */
-		printf("[FAIL]\tSIGTRAP: ss = %hx, frame ss = %hx, ax = %llx\n",
+		printf("[FAIL]\tSIGTRAP: ss = %hx, frame ss = %x, ax = %llx\n",
 		       ss, *ssptr(ctx), (unsigned long long)asm_ss);
 		nerrs++;
 	}
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 1c9895cfc660..6de11b4df458 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -247,7 +247,7 @@ static void test_getcpu(int cpu)
 
 	if (ret_sys == 0) {
 		if (cpu_sys != cpu)
-			ksft_print_msg("syscall reported CPU %hu but should be %d\n",
+			ksft_print_msg("syscall reported CPU %u but should be %d\n",
 				       cpu_sys, cpu);
 
 		have_node = true;
@@ -265,10 +265,10 @@ static void test_getcpu(int cpu)
 
 			if (cpu_vdso != cpu || node_vdso != node) {
 				if (cpu_vdso != cpu)
-					ksft_print_msg("vDSO reported CPU %hu but should be %d\n",
+					ksft_print_msg("vDSO reported CPU %u but should be %d\n",
 						       cpu_vdso, cpu);
 				if (node_vdso != node)
-					ksft_print_msg("vDSO reported node %hu but should be %hu\n",
+					ksft_print_msg("vDSO reported node %u but should be %u\n",
 						       node_vdso, node);
 				ksft_test_result_fail("Wrong values\n");
 			} else {
@@ -290,10 +290,10 @@ static void test_getcpu(int cpu)
 
 			if (cpu_vsys != cpu || node_vsys != node) {
 				if (cpu_vsys != cpu)
-					ksft_print_msg("vsyscall reported CPU %hu but should be %d\n",
+					ksft_print_msg("vsyscall reported CPU %u but should be %d\n",
 						       cpu_vsys, cpu);
 				if (node_vsys != node)
-					ksft_print_msg("vsyscall reported node %hu but should be %hu\n",
+					ksft_print_msg("vsyscall reported node %u but should be %u\n",
 						       node_vsys, node);
 				ksft_test_result_fail("Wrong values\n");
 			} else {
-- 
2.45.1


