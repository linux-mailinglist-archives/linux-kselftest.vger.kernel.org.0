Return-Path: <linux-kselftest+bounces-9311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC848BA57F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 05:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA4E1C225FF
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BF622EED;
	Fri,  3 May 2024 03:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mGlSPAfl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF141C6BE;
	Fri,  3 May 2024 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714705351; cv=fail; b=gKqbpnbtf1Ztig4CAmFFyQ+6PG6JgJChuT+XQI0RxXd5W7hCtSF+2mJY4L5n+0/jx1pFWdzeD1CgJMcWyWWPonSeHixcR3k50AyeR+L36P6H7AXYwfzHI7D5uazSKSl1BhLaIf9gt3VnD3BmUMtxf40bwG8R7phrWI1GVErZQ/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714705351; c=relaxed/simple;
	bh=cwA0gFYXz3BUdHrQnZZ9wj7J9+njZ+oBhrdJxstY7IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uV1IZsMmAohrVyOw1r8F+VLBhLJxZiPn3lo0DL/kwO9PaM8c/irOCgEdhMYvauxqnBtjjN+jm5Sxs4y5yDQ9dD7g8H66p4FI9Ysd0GHiVycOcidCZH7FEDji9pCITochKQGH98uc3ZdL9bd+ZpHsXgwDvj5eGqYm04FtY9P8g/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mGlSPAfl; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UztQze5idXQZNwKN0rDOCO4oQu54uAbNbvfl/mxD3HCWQu0BH0rixsOuxcm8HNMV2U9TCSwfMFVhEEzDnojzJzxXyL9OOQGTXOXIcNQfhPIbACH0Oh3HWRD+gA6egtcnCDUA/hz90NKQvjEiSsEwV8B+3Z+mmAV2Zq42BTi9kqwK4gi3wX/oi3W00zkKoavg4xbqmkA7EQwf2bybquoaebtqOP/3VaXXr5SEyxRdvKOCKcBdxvxnsw4jIH83aUSWC2Y7inhHPZpBSrXSVdqiedyjMyzFYXDyeGvDOUU4OwmOSA+6y1wJowjkuaJVOJho1SGqcQ5MKPFRj7IgEQOowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnmBrYk3OK4mw6MTPykzlq8+LK/K2jDYYaxhtdmsk5Y=;
 b=imCWiRlprgkrKQUCHm+Q6qrnJ+26Io5n4bpuACFPdrpVsNQ41ummOuoZ4P1htgBuU0ITXDvDnee2dUcLwdTnUzLwEsTXq15jHr7zLLdZCnb1aheaM+BJL8Ey9oG/92eisDFCPOeL9EZV2OsEJ8TMzLTfKMYckA+ecKtLEv+DpceWPGzXs/8t/wn+AEjaDyHaSkj4UDCqniGijEV4UaoTpC2rUZudWkdFCMRSTbbWP0xwSCjXfqJCkITj0CYoGBUT9bkNtsDOJOKRknGWK7PW4t9Tidd7g7NyeUJPyrfxIvYV/SGZ2xc/Xyy+041rRzFnYbDzssI34ACIXsSaqxmffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnmBrYk3OK4mw6MTPykzlq8+LK/K2jDYYaxhtdmsk5Y=;
 b=mGlSPAflDGZZogMp2To1RLYTULpJn0LlIKz4zRgbbZtzJSncXbSon+cKRcAuZJzOnnWtT4AbOxSubzDgDySAd9k+kcRmqb5sie/hDwurU1aqx4i4Vcn326AaCip/IV9uZUGOzbxwrifWVgEGTctTHfFOMBMb+xltP00vkacRLUDUTM2ygp2Zfkdaq7RsIjXS0RgZCFIBfgt0JmXkzSJ8e6lsKxKONkqUu0IUp1zsvrS0aAWik8fnLDRRqvhoNqbll/C54sK1ocZollqvOkpyYQLC7XyQ3cOOy9aodTYV9+nRceXU1IbhuMpC8dxXCMZo07IsyN1eGrV8z5x4+uL4vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 03:02:18 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 03:02:18 +0000
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
Subject: [PATCH 2/7] selftests/x86: build test_FISTTP.c with clang
Date: Thu,  2 May 2024 20:02:09 -0700
Message-ID: <20240503030214.86681-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503030214.86681-1-jhubbard@nvidia.com>
References: <20240503030214.86681-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0055.namprd02.prod.outlook.com
 (2603:10b6:a03:54::32) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffb178f-dc8c-4d00-6581-08dc6b1d7135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QXHJpi+zqT0wjPI4K9x9DiRVakUE2osFjlTHQVY4cLA6Q5rVuDWsPekwL5Mm?=
 =?us-ascii?Q?GF2BqcoDdxt4CtaVmPjwxkymJNLCQSnUfVQTLEu19tQ2MRbSUS2QnJ8RGmAR?=
 =?us-ascii?Q?eEgGm74ql8nLKSX01WyTccc2aLwS0IP5UTHjdsHf+XW7H/3MdWCCp0uuo9y+?=
 =?us-ascii?Q?QobDMdHo9xneAwTQT8gNL6rCH+NLPspa5kaw+fn6JOZu2QNbBGExhhYqK/4Y?=
 =?us-ascii?Q?UvCay69C4THczMSwvRJhz9GXuPbiGA6dhX6QhedncUTUnTz3xL29k7VrdRBx?=
 =?us-ascii?Q?zg4s4Ah/DNDCHwpWLBjZrm9RM7T8rduHAc6G2nT9vQktbg3+XotfqX7dFkjG?=
 =?us-ascii?Q?kpaVFo/vLYXKUlQiYxDGtueYW7POm6qtVkVdC8HMNQOve6XuFalv/JS2MWjP?=
 =?us-ascii?Q?N/4fJOO1JCCnJ08r3BKPr35Y9FZMgQf5mPvg8/voghYDO4dLVlHzu6zXUIzI?=
 =?us-ascii?Q?VpM7sTxaKS43kErhS3bLnOK7iFe0QOw4lfEdV5ij1U6nV9aVbEf2av0Cq3fh?=
 =?us-ascii?Q?J3Pmb5LSTNctvf/R4CKBJK0ne/5COzRMhuqRbiAEwt5eixxu9OCJ33j8+mHJ?=
 =?us-ascii?Q?E4Ud+u3hlglxdXsYwYMS92Gc78+01W8dP8KJRGiHaHULcmySXkXOVQlEtSjz?=
 =?us-ascii?Q?AneQ1dPu8du8ifiG6d5IgsXxKW4l9tmkr+SQvQwXSmrhR+0AETmm5prLvLDp?=
 =?us-ascii?Q?S9VO+Lb9oF4qlbd2NrM1cjo2dhzZyUmKQ+2a87g7Ntf8u2ziiM60Eu4zlKlt?=
 =?us-ascii?Q?0gkts4Q85/3VFdg+GP/nssLJC0HVTkgtRBpJ00/g+jZTI71j/a/8j5TcYeQo?=
 =?us-ascii?Q?n/5xlzvmI5/JB6mwAyBLYlSVi3GL3mba2UVkN8u9mlB7gQFEPLEjK/mqtkE7?=
 =?us-ascii?Q?j7HHSvPBPc3tSpp4z/4gIcw8JtBFnB/vIAC73i/kV3LD9K8ASONwFKX91EvH?=
 =?us-ascii?Q?n4JP9KwI2qREbL3H1aLBCzAfaLOa1qBeXJdILM/FLhRW+/kFqTS4H2qFqMXg?=
 =?us-ascii?Q?WogOcPeV+wJtEPNMP1E2B63rEfoGrsv72GLTQwmXf3J4dqki1mR1uMvyCBby?=
 =?us-ascii?Q?3F/4oaI2B+nnNQGZ5vpuQpN52tQey3u/HYW0rVU84XE8tF3R5P7oW4Jfsz7w?=
 =?us-ascii?Q?SeeIk9x3jxA0f38IYAncGirj2BL0kaGeNyl32ob/cQdsx3VU3NR89AaaAMOu?=
 =?us-ascii?Q?wQvYdN3UGv98bmn6n7xjX/rUGdjt7Od42Qpb2O7nrGlFSiPfakNch1PPkQCx?=
 =?us-ascii?Q?NXz9PqQsr7Z4qfE8+xAGiulPS+nVEsUG9Sfq67szFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nbRUHUyr6wp3CaHySv6LE/vVAvfRnbNE58cHHyrC0VGdemCI+hHlaBRY+3KC?=
 =?us-ascii?Q?ZB2PRXtrTkbGR4rNr+6arPYvksovWxpwU6fWR18qA7qPXUSQlZ89IQk8OK3d?=
 =?us-ascii?Q?w8Y/v27Fu/BfUUpNZ1g/BTJgRzELAdQp7hmDM3Y/BG7NVpA0RbiuAKyqFi96?=
 =?us-ascii?Q?444k7u4tlmonzlni+sR9lYuvS51bpyIb5+dKbeYrDzzN06jk6crhSJTTlmAb?=
 =?us-ascii?Q?G9FegmbUs2kNzjayAPwSOuTW+gixUZxBwMm5AXBMUJw9CMKFC5JSIKd6KXW7?=
 =?us-ascii?Q?xHFfUBRvfuyzzxt8Bf+ljJHdhUq9carvMWVYNEl5aWwMQaSENpdLuNZCP3Q3?=
 =?us-ascii?Q?Hk8NG+v5C86TXuIUXhYf0btMJZHdIo+mwaOYJBSlNIFW+tPrwCsTyxtQMM0x?=
 =?us-ascii?Q?TKfYI90gr842y0gNLvvkU02JADMRntIj8oeKN1DpDVF0vj5MrU+3q6YzILkD?=
 =?us-ascii?Q?HMUdOa8ZmnNSSGTglugL2EzrY+WfZie6oAUM7Gx6BIf1TFB4GP74geY1hUnq?=
 =?us-ascii?Q?flyvGjFL5jvvwMmzD+5u06uiehjApph1woTBwZWQP5h5ODFsb4dZF1JiI2mW?=
 =?us-ascii?Q?ebANvi4MLUN3qDhnyZVFCPZVvHucuCtaJnGhl7qWmJNfUGKIW9caAEEA6zey?=
 =?us-ascii?Q?9QjNBRCiSFPkdCJNHilWcdL7PHKffccv8heQY2S9PTpFrRJxD+VHqkL5XoRv?=
 =?us-ascii?Q?1nvQnRhznv78j4oH3Uoh5pIRmGuVne7wlloofNe8Zx3VpIOearUolW5yCliw?=
 =?us-ascii?Q?LVUq51BVo+msjgS5XVwbO8UBIbdl9RdHzzBYyKSIRoc+jiTewaAjV8tTTUTL?=
 =?us-ascii?Q?7yQZLkUVH2h8ww931TANcBmwQi1bpQhuUuSsP87g5XZvIQywpkv7VsVM+pVP?=
 =?us-ascii?Q?wzUSZkH6xsrvZzVl79bFa3imVyBPT2sxyYpchBH0tYoVByeNEPjpUcKEhUa7?=
 =?us-ascii?Q?Kt/931hc9E7D6Kd3IPzKOodNVI14r6b/8rfKOueMdqWu99//hb9e8nKyAILn?=
 =?us-ascii?Q?9O+zk7ex7lo3Kt6k6x8nI1LYItXPXOyi/OU071e64HSCOqrlIe3F76K+iOYV?=
 =?us-ascii?Q?HQqY+RJRPX1jC++yCPMBkhEX/UanLqiXJeINmw4m2/tOUPsGQXexrc5qnrww?=
 =?us-ascii?Q?w+Y1QAyJ5u3oOUnGh7GXb9n4GYzz3nV+Ttqkwx16mFqX3nc3p+6JGRVtgeXF?=
 =?us-ascii?Q?T1XuckRFvqHtooCSxJ67dzlt4A7MtC4guCY6LQU9fcnADon1b8SzPLSiHE2q?=
 =?us-ascii?Q?1ueb5Z8ZuUjqQUFqQgmHnVlEw6IBD98WVpegJKtUe0upTezuaf55HlcA+Unm?=
 =?us-ascii?Q?mluK7duU5kY7W/I6hsg4qQf8lAsKv/2lvz5hxukDkBbM3nSuAD6xmO4VUzzi?=
 =?us-ascii?Q?DCZjFSOodq8rtvxw3zg7e9nAWExLXOIFppEx+D7LoN5Wo9ufnMbTsznz90uf?=
 =?us-ascii?Q?m4Vw1VtoCnWqf/v+xnnXeghgyAzxbcKRSlcAAIGJW4ZM3f9pCQJnYPlZVcU0?=
 =?us-ascii?Q?c+twgu7N6snjrm72LaDaozn6a8MUao4QGEx6Tyx0zE108ouKzww8itAW8IGG?=
 =?us-ascii?Q?PJRUnuY6pos2xGie4g3iWO5Oc6ih/qI1xLIIe9RL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffb178f-dc8c-4d00-6581-08dc6b1d7135
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 03:02:17.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceBZyHNiQpsaQP7HKypQtrSxBWXbd6YjukOewGvX8UbxO5mc7MXIndsk9QbTq8T2e/bn3Z49NjxglPvIFmhdcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...the build fails because clang inline asm requires size suffixes for
instructions, including the fisttp instruction. In this case, the 16-bit
suffix 's' is missing.

Fix by adding an 's' (short) suffix in each place that it is missing.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/test_FISTTP.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/x86/test_FISTTP.c b/tools/testing/selftests/x86/test_FISTTP.c
index 09789c0ce3e9..b9ae9d8cebcb 100644
--- a/tools/testing/selftests/x86/test_FISTTP.c
+++ b/tools/testing/selftests/x86/test_FISTTP.c
@@ -25,7 +25,7 @@ int test(void)
 	feclearexcept(FE_DIVBYZERO|FE_INEXACT|FE_INVALID|FE_OVERFLOW|FE_UNDERFLOW);
 	asm volatile ("\n"
 	"	fld1""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fld1""\n"
 	"	fisttpl	res32""\n"
 	"	fld1""\n"
@@ -45,7 +45,7 @@ int test(void)
 	feclearexcept(FE_DIVBYZERO|FE_INEXACT|FE_INVALID|FE_OVERFLOW|FE_UNDERFLOW);
 	asm volatile ("\n"
 	"	fldpi""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fldpi""\n"
 	"	fisttpl	res32""\n"
 	"	fldpi""\n"
@@ -66,7 +66,7 @@ int test(void)
 	asm volatile ("\n"
 	"	fldpi""\n"
 	"	fchs""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fldpi""\n"
 	"	fchs""\n"
 	"	fisttpl	res32""\n"
@@ -88,7 +88,7 @@ int test(void)
 	feclearexcept(FE_DIVBYZERO|FE_INEXACT|FE_INVALID|FE_OVERFLOW|FE_UNDERFLOW);
 	asm volatile ("\n"
 	"	fldln2""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fldln2""\n"
 	"	fisttpl	res32""\n"
 	"	fldln2""\n"
-- 
2.45.0


