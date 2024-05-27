Return-Path: <linux-kselftest+bounces-10748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D5A8D0EEF
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 23:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08276B21732
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 21:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E08168C33;
	Mon, 27 May 2024 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UMPQLR5S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9255A167DBD;
	Mon, 27 May 2024 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843683; cv=fail; b=O6HiqjDhEKrvUvdFUH06KETJFqmFKgB6PUgGqFmtOkT+lZgJnTJ3DUwBLSF1nQaIumZ2J8KwMO63QuS2GVNU8B59mVDivhTYiamNz+CwlteHGthpWkQ2JpB7dxG9LrEZZQXPcNIjaJOU+YNCxuVC4g7wL/yBPD+VoL6sJ37N8/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843683; c=relaxed/simple;
	bh=LcWrjcndeq3iuhARrc/mp+c08zzUu1zFoYgBoT4w7lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gER/SMUOL4/r+AaaGFHI0i0sSx7voyJQ1NUcyLEJyu+5mOF+UIomDTbHKtUrZNDxp3Z223YJS9ISNwBXkvszIeyes8azcURkFZpyuH1bjgBgZNOqwYzH2VJ7M3K+AlCxdd2onQfrxqUFFFb1YSYZR4qPH7jbADBA4+GEWK2DDiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UMPQLR5S; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iARgizJiXldJujcoALC2w8ZSZKMqY07CrubQsq2udLmQgD0JfO7VDvwvY4o/xSENncrCR5agJB3M9BkDr6KxB+Sp4C/M5hCw+WfUPNO2pPd4Dz8c3zSJwMQB8QgOvBuGg1dxIUAqu8tqigEp8yp7zgk8nCHmhuoSDw8FqFeS+I6VYOM7pbkc9Dp5I+6PrES2HbI/P9tva6wwtJJ3wfU3QNwgsBEEZemhSTCfaml9v5pWeso6TZOQKpBDgKkgQu5MdHMJzz1m6lW/S4el901Q7/LTGxRLHnO0OUAV5PC8CXTi1SeGj9lHUwh4ibmde+M8XmyBe6aYepbrwW9J9DZJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9NVry3VUsyNcWz2ZdDnrII1PJ3GUu9peaR80x/6epU=;
 b=bMiBEuRuyVbwm2hK9qC+wwqmPc3I+iMKyP3A1CdDjIAZwS3I8uXqsVYhU+wTmddTpKNmnO9Tim0b1SaBpwRgVXhVOZuaNquQTY8tGnFCnaIlGLLVoQPBcwAS8u8qOXwygkBrF52QTFfrZXAYCT9Ei2nNsSXjn/r85nMBUPmDZAMYHFsPLX22HeJfJTdJvt5Fon1o1MrUuD+hLQXMmzTX9IL6ZaiSjiGjBhqNCY5+li2lfBuL+DBdeg2+m4FC8LhW2xEnZhbzQYXHnXekg9r/fKk4EkwEcZMAeffoh5uYsTtJzj//ERhHL4gYZaTKQaxsZJetGECDmU0r6vjTNFCtLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9NVry3VUsyNcWz2ZdDnrII1PJ3GUu9peaR80x/6epU=;
 b=UMPQLR5ShcQajHXtuq3aCsVO8YLw4L0vyAUTyXyztai8AHf6msLIEP9cjL9JUnQmAq3tAhoqxSj5YHlkzSYZmnnk8RlEaZn/i1jkdrLjGzfKA0liQ+Ov30ksRl7iTk1Q8tM//ItqB19tExQcHSZMpi3EV77wlIwx8RwVMGJzakOVYYsE/S9J+KMg5FfcD3Fi9bsdviJNmlaggrL8BmTJGsG0X/fA9jTkBVxoELFrP+tKsORLrDcTwIkC1pKCsCySezdo1DudDyOr8KaQKT0xZbngglwRF3SYAeBOiofdxZ8a2FqoUAskfz3y3i2FOoqjnx4i3mTek1tK2yHcvZjX2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL3PR12MB6620.namprd12.prod.outlook.com (2603:10b6:208:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 21:01:10 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 21:01:10 +0000
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
Subject: [PATCH v2 6/6] selftests/x86: fix printk warnings reported by clang
Date: Mon, 27 May 2024 14:00:42 -0700
Message-ID: <20240527210042.220315-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527210042.220315-1-jhubbard@nvidia.com>
References: <20240527210042.220315-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:a03:334::13) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BL3PR12MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 317c3d96-de36-4bd1-04f9-08dc7e902297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pKNZmUVdnTqk4fMNqmRm7+3AiKPgV6++ndounRP6/q5AsoCJDJMfTJ5jrkuo?=
 =?us-ascii?Q?nzJajnXY6vQqV7Wse1oiAGABN9OShxqfW8JVYLr0+rvfZysu4K+2xUTmjnei?=
 =?us-ascii?Q?+OwiPvoOD7vOAFfKWA8P7ZOfBJHiRJAwZTs30YsNd9Zi4ZamuyecVuCROQc1?=
 =?us-ascii?Q?MKS9bWu1D80uL6WmmWSxBImxFCNsXmwFXGvVX/vdA+RtPDNmP/rkLvnpaOgj?=
 =?us-ascii?Q?AezztBX0d2qd8ZPi2IpKOKyCAkfNSflyswwPtpe4uVJCbu17pSuKZv3nO8up?=
 =?us-ascii?Q?RPtcclgxJMIThcHGgZyL6eAMreFkmpWq7shcqqy2r1jJokoifZgcvTR7g6e1?=
 =?us-ascii?Q?FJWL2a21G4ay6b5Ix/yhOlR403B8AuGyhNzJU+uIjJrO+px8zh9Frvz5DjTZ?=
 =?us-ascii?Q?AbcOteYzZxeGbxHEI2irW5UTR/HnhupL9CefBHBqyWNfHPuYHWCVr4Q1kFP2?=
 =?us-ascii?Q?bcSBdnNtxmncDE/BmCiqduGf6XZG7iLeprX4vUgaMPEaJ7nAizMAlUWVABTe?=
 =?us-ascii?Q?KlWUMLeTjxeIw+Qibf4pVo7jOeIMuyf1u/9y6Z6JHYtsdTlf1JYHJ+ibwyGE?=
 =?us-ascii?Q?gwN4xqe1k8tEUAdBv4KSHNOpiSrvMxUTN8LDdk0bZssJ+DrjG7sDSKBaqIBG?=
 =?us-ascii?Q?5/7++LjTAhFvrOocbcL/GvDc03FlPRDMt49+iYLhQTUvWEMlXlYL7By5RwaC?=
 =?us-ascii?Q?AXEgk+weBdWE5SQUweTBlEyHG5twNvl8mbqdeW1JgE6178W5yGrrEXK9iMvy?=
 =?us-ascii?Q?jz9SmmZjHcDhrXkq9X5rHTIWw0KvcRUwyLZQiohrkEEl3lS7FoLukWG3H0nT?=
 =?us-ascii?Q?HFQm4uJIxgEEQiEUfMuJc4wLPuIxh5BQxv/3nUFaV9xKDJmxWvojr3UN7ADn?=
 =?us-ascii?Q?w75VFN+tt4sdUHmpLyIwjfHrtZTwQWp4bt5jXrt/scpRF2AIdFJ6mxnsbSAW?=
 =?us-ascii?Q?EWdy8U5ua5Tf3+gplLyaqqGGBDwxc+RkC0ZW10PqFfwmwn2b3ffNy/79pe/P?=
 =?us-ascii?Q?gTkcil++3mlfE/oJ67sCmQ29Xl2J8gMr3ToXDV6KcKU6jR1uSkrVdjZGkujY?=
 =?us-ascii?Q?9Z7ezFyjGXqJtNhA/ZpZhBrhaGNlIEIUFiKR6oI+vlcXeOTwWoUb0+1+Uu2C?=
 =?us-ascii?Q?Fq8X2wD049PI/hYGfoKBwo+3eTD8iK2s1qw7S3lp6qsbSk5vpMOO80G8Ttbk?=
 =?us-ascii?Q?rklq1JmwOkCAvC66m88Vmj/0T1zBDSgDgWCwJ7H4qOu2mI63RqNgEcR+MgsV?=
 =?us-ascii?Q?suu1igLiqAn4tsjmhtvwZUjfRtJj9nzUI2Tlj5Ul3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UkSCmkCwyAjUTQAjwJYk/MhTVGHixHKOkHNWPeTJN9hQig9hUifeGE8UvxgX?=
 =?us-ascii?Q?BiirJXQhQvUNRf8AX9moyooim/zul9asi+uk1XRGhQa0l+t/pDh+wxmNndOk?=
 =?us-ascii?Q?44j3LGxvIkhc6q75gt8aAXoCyclGknPquQmch2qr3SoscoGQ5Sn88oiJL/1S?=
 =?us-ascii?Q?8y4J7FRK8MFsS65FkOOfOJ2qtLAn2lMNbpXaZ3s+ruUh3f+xo9yHwCK1WSd1?=
 =?us-ascii?Q?0SnZ54M7+u6KZlf4b3k9W6vsO/ngaw7iNPmIXpNgLQmQLrZv64PSLcXZYjNy?=
 =?us-ascii?Q?T7qJ6hhJPpGlJprgACYfqvjVa42K31FMVcynoBuaAwrQUrYPazTf/Gg7zHNY?=
 =?us-ascii?Q?UZ/Kw1FYurGroOLUdoT7EPUjuA0lW9J0hxaRZKrcchrZ2YgSWNWVQinxgNqg?=
 =?us-ascii?Q?LMJ3Dg3eJ/FmUbDLezew9g70BJlk9MSUJv26XKsEEpcgYRQsGskQbC8R5xhY?=
 =?us-ascii?Q?/HVGB6Ha2DcbeD1Fy3doypk2WGpAtFn91ilVlRGlCWpQEXbpgW/CnGBkrNOk?=
 =?us-ascii?Q?DLS3B6kJR8WsSsYFQ+xDsWp2fJCKlS6m/KZnMqlJsK9YyppVBw4qQj7LtljJ?=
 =?us-ascii?Q?sQvJl/CkKcQKQ/2HoFbjT52bPsCRwN3HDr/3q5NyJ/1g3elc55ec0VbksZeT?=
 =?us-ascii?Q?FjbCEo9JehcDqI1Biw36yBMAmEOR77QfQSLfifTpX7yrMDjESYbiOTqhJk98?=
 =?us-ascii?Q?d5aX8w5Akab7tbbAnfMp38LnA/ttKPFfwFoEfTCi8TQkZxkmJ8fJBy9EbLkq?=
 =?us-ascii?Q?KpqJrnLT0btSh6xTmwwNS47VpghQp3qw3MJLEyqpJNjUxCk40qXCM0jV/iIA?=
 =?us-ascii?Q?W6o36wZNwicW+IghYsr8OZuOrq1LLlOgOn47ZrrH0JeGKJRyhmZaLsJo3cmR?=
 =?us-ascii?Q?g3QYB9zdbVnWpBLU2FhqWtIb34mGV0MbJkoMvsTguMIZoFMefXT+NfyZZVjK?=
 =?us-ascii?Q?WoozWKaE7O6yrt9xhvTUJzCBcusRrDKiEWTdmV78pwT0os3pj8WFLDQA0O/e?=
 =?us-ascii?Q?ab1NPOvGm7iAxTDGeTVgRoVRJbxaBHvV3APjWAQ8sJbE1PzlLlH2GeoddklJ?=
 =?us-ascii?Q?C1wj1sV+Q8PCInSz7VLnojRd7yGYrVrJD6lbdW1H1xJBDh9DCG2JISsG548o?=
 =?us-ascii?Q?Aro3cwwi5yMXz5XW4kN77xTZaHZACYUbFYN8ajn++LdW/SoD1Yn8kXz5XFZ9?=
 =?us-ascii?Q?u+ODM8YrxgWq5FOZEvybXq9wgX9ShBrCArOsf58Pq2vBOoYliquVWzWZYH26?=
 =?us-ascii?Q?1s0ryXOeuJ0Wvv09nJcGxL7Ogqz6VU9AFjQwnx2T3Cn15/xZ/8tf/Be53RC6?=
 =?us-ascii?Q?MmduSjHXy1qiJdbYkC7X9VPz30WSMarDZ18crwjk7o4R+e8lkxnf16OIeZck?=
 =?us-ascii?Q?xHxo5A1F8d4X7cdxTLjvGnPYHNr+odsUdkLvAcnKEbtf7Dvvb7S0aUybsm/G?=
 =?us-ascii?Q?w4kFDXV3nnce5PdK5XXKhBFc8+MfNV9rBI03QpSMfKofNLddZY+oUAg7Teij?=
 =?us-ascii?Q?f+ngzdS6ep3uW4wAG/FeUVdK3KpcsEjuC66nGCJJrgGP2uD/3kXBfP9uO4uV?=
 =?us-ascii?Q?qXqMFLm3Hoq74Ga/t8SX8MHB9vLiegdY7Bu50nD8gB3Imm5FYEn3HFx+qqCx?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317c3d96-de36-4bd1-04f9-08dc7e902297
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 21:01:10.1162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0mihRnrBwG1l8Aj2ZwbkCBbalQ5i0sKH1NGfwdNM7KrJHM2ao9DTjRfxAC6A91N5cAo639ARmA9RXPpw7FGGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6620

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


