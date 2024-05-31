Return-Path: <linux-kselftest+bounces-11051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 373B88D69DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DECA82899D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1613E17F4FB;
	Fri, 31 May 2024 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AeO6DSEi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14817E479;
	Fri, 31 May 2024 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184332; cv=fail; b=e8rgw9rNBNn/3iUlC//HeCbvdkVDPU49DgFtKy34wNMKXi/y5wwVWj5Q5kbpeFh3rOC+bhxcrNFoDdJJIB70WbObS6GhbaAKXAK0UKhAprwIatGxVKAmB8vA4clKjeOc50BOdkPIiPpexywsaxP59dSCZiJ8rtfqEzsCkscsR4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184332; c=relaxed/simple;
	bh=mBCT2MCnrTyQltQDei7ef7SuHYpumNtvDyYn7JVI9yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PAbKV+VIBTpyrq6wWhxx2tuULMGS4xDLqu50JIGOxreNk2UPK7yl5d9GDpMgCnyOk4H5sxlEK/+5F2uzCMUIwF2AaY2g2uN6gKmyqphREtH8tXATZaQvvxgGNGfMICyO5Ml0K9zMtZhLpNFMV0H0oMk1mGYTyk7LLdjWr0gENjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AeO6DSEi; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jObT7CsRZuUVVi6Vv1e8SVO2Rd2knKVMCR+JYf5OE3Cw/UO8jwdbxrJ8Owr2+ELOGVCxpH69JI4MbLInNSoP7bSJfqQwEgdOvXQDAVwhcBHTd/dl/BRmoNZHkwEmMIjjUBcSyQmg+TvVy98pcAjSbZYEr7X4sJD2T+R1R/GrjEKEkJZyRlcmwubLc8x91kY371VQ/Qr6CDOuxcFw+u9xXiAkF9knmZiVqJDu3ypN3fVFVwMh7ou4bkoC1HpIiCSzKjfxVu0pXclNS0quOIxF+COrsRqX+Ps8w86whlDvDWzivd2LfnOeuxuqBstqhNgWcURP8eL6eowYYlFKP+GcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tkbxLO6jAdxUKHgdSlhyseHH0AZgmarl1xrRnVbabo=;
 b=LO2crAuIUt/aVXXuKe1I2QyDX16BdNmmvhUdRL/0cF1gMw0/onC/fPDoUyRtImiZTuvsTZ49FMENm9BcBaGqAs7cKX7AdaBcnzkAxD04yFsCxxePNOjdRR5XpE0PacLwuOjwL2TwDB2DXZ5/ba4JaNfZl3BUweWV0EDpUfpjLolGZ/Wehsf/EYq12wEwHIPmke0AxYrhWWPX8Qs0Aq9ctgHDP68G4MyCiDwyZaRiN1EcmBAv7Cyut4O/rDbbEJ/DOzuOx8aCfQmosx9zlgfC8wMXff9FG4TFKIf5RDZYWgjqcnb72TB1PQ3wrlkboO1/fy8YfgHCXE7Vh6vxlPDLZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tkbxLO6jAdxUKHgdSlhyseHH0AZgmarl1xrRnVbabo=;
 b=AeO6DSEiVWTbRwjUSfG7hUoCdaKBoUpX+5Nvf1SQn6H1DzEDdlvuzpLQj4xufTPxGS6UbRuqlrJqrAEXn3hc5pvZWb817Gb4MUlD6Hxat6FVfjy8LjG6W/Lw0opy9t/4834celb7siZgw9L6a3HRHt1b1eZcu2ZqQDxfAlkL2ydRSmQHwyIiTLoOI/Kef9mdwPWn7AQMBTXNXtnOG8tUQFTk7Cv36uyCARX+wjcco1aWikPuRbc3+H+Yr873/95BzyG8Kn/NVi/u25+WycCo6PN41I5gvhfk961603CXmZQfxII3dPrjJcds8bMrU4KV36FLtkHoPt3Q8efuVU/8XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Fri, 31 May
 2024 19:38:42 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 19:38:42 +0000
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
Subject: [PATCH v3 3/7] selftests/x86: build fsgsbase_restore.c with clang
Date: Fri, 31 May 2024 12:38:34 -0700
Message-ID: <20240531193838.108454-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531193838.108454-1-jhubbard@nvidia.com>
References: <20240531193838.108454-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::25) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ec0ea3-9747-4a06-4d20-08dc81a94726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QyHmoPwtXAhotRQJvtysALnE/bU3lDpBCr0ga7s41aKTuNwNsa4TPp30AUdc?=
 =?us-ascii?Q?r2QthQUYwidBOd6nv1ignUNk/Q/p6apwB+k3ny4KdbpzAOCgN0qZlw3yQepB?=
 =?us-ascii?Q?2G5RMhDLnnqKZ4DxcNoCWN9BycaCrwmb9Kj/hp95zz3Otvl4i7dSIqCDsO6E?=
 =?us-ascii?Q?w6sh+M9Oz5qD8vTtb/iUTizFeL9BV8tFmq8gsg84tG0AlbXq4iG9sK8K/sWY?=
 =?us-ascii?Q?+7Spi6Jx2PDk7rfDuPQpxVI3kNJrpov78n1VCylhHLwKCS0uw+KsuOPhtQve?=
 =?us-ascii?Q?HfD3kZA9mFfrhJFPe0KRA/DI8xhXSOa0nXv3+vxDpwULVwxQum5TnXWSEIPt?=
 =?us-ascii?Q?qbUrfa+8YOQswM/agitACRpSP+zQF6EGR0yh3xCWZ/9n6t0oU4mYfvqChA7o?=
 =?us-ascii?Q?xUYJmmTCqzDPXMH1B8PKnsnPbpo5b4pKQi+5MkQ9hc+tlFiozVlwQJum330R?=
 =?us-ascii?Q?DRf/CZ4AcfT3lqhRA4AuhTMpaU/4zCd5lrjcK5CK0pcsnXGpXaONTdG/f2oo?=
 =?us-ascii?Q?1PfYjFP1QoeHL/XOFIHfjJE+8mmE+UNzRCosTGLVYxzbTYA4rHuzyExcvVs0?=
 =?us-ascii?Q?qPMD/80C4uVxzkmyAc5/5vLNVnCApFrtswb/ac8q7RwcM0sReeQLlvamfZ5X?=
 =?us-ascii?Q?XnlOhjcqMKt6rtLJ2wTN9nh6LdbXeQpTkVvN65hm7FLxnwa6vVVg/IZFRbvF?=
 =?us-ascii?Q?rRF8wxuKC90SWkm9iv2c+TbDx2/FHUl0hL18TdPcYpRXVgY7ZxBBpWy3RgeQ?=
 =?us-ascii?Q?buv9F9YQN8SaqjWvTshg+k9N7qpvi2pdn/kL5wt00g6braJqihRC9AF7Z0eL?=
 =?us-ascii?Q?BwMU6JjpXMWa6CvfNmmlBe3noOwlq7rF1mC7D/jwFdV7evyVquDRuNOBzjUo?=
 =?us-ascii?Q?EL4J0jeuzW6Gm2a5WoL5scFykOew15H/qNtMGIA1UhH2MXPBita813MP4pg/?=
 =?us-ascii?Q?rj6cU7xShoTEAdoiD06f8dVNDstMkCWQHWNJwzOGvnTxjqncU+YvlSIH6c+H?=
 =?us-ascii?Q?E2gDgC60tMRiRvbHXcu4LS8XKHRzOEvwp94VpjDdtIYeXkRIUKSFXFGDrXPj?=
 =?us-ascii?Q?Rxt6m4LtEYBcO0Pj0ckGXqWSNoeHfX8cOL55t3hy9iE4ZLxo6q+hmo0aaJtP?=
 =?us-ascii?Q?yU23zwp+AKw85Mn+r9xCKk5seUzFDOGT8GzzPV4oR4jv+vC0A8I9FBr19nZp?=
 =?us-ascii?Q?ax29ZN7aOjCZi5FNADZ3KvTJFWWHjCWSyW/29Lv+QfjawS/hrGuns8qjgoZ6?=
 =?us-ascii?Q?+lJuW/8OGGSeNa2aCdVmQQ5cbB9cSJ96wj5l6tN7PA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r/EPgmt8j3KggWG+L4lY0sOTlnbjPNzLXrxQRJ9zNtL/1pNzf3po7GAX4USR?=
 =?us-ascii?Q?T2OMt8vgBWve/WYGPAILzsJqDtbLsEBjJRnfYK1PAlyf+UKJ/pQT1T1q5+02?=
 =?us-ascii?Q?o76NSl287G+ooMyvh7qZaS39N0t94t6mTfaQdNGf85eNmMiXDfnVw7iL0nUG?=
 =?us-ascii?Q?apZ03t8zRMQQmMVJqhA5qaoog04yZiO3Hh5kpuGEik+L+IjN0CYj5d1q4V6g?=
 =?us-ascii?Q?67j73213Qbm6ZH8OCNh4MyiszCZ3LIK+EWhLe+tqlA9hGnup+LKj9s6n1+xJ?=
 =?us-ascii?Q?26bpArYJk1p8WD7322knQUPRfSWn8VqQY/m+xLquXsGJrS2V/8sggxHj/vnn?=
 =?us-ascii?Q?ugB6Lj7TZ1WvIQaUeW38o/hcqsIf4uC5VdKjy02k2QuLYCtPYecgihrV+5oT?=
 =?us-ascii?Q?+hZVREOEuayYFZJp8Igvtabq5ALLI74PyE3ImhIZDRSMMYGYKonaWByPaGpA?=
 =?us-ascii?Q?Bi0n4RUYJJVlvVcJCFK4Nu0mj2/unNc22R0Eijpml2G8W1tKlor7gF9n3XzX?=
 =?us-ascii?Q?FUIQU6ReGUblmknJvmm13Ca8ZreJCBm4jY+mza1H0asTnVaQluU9KPhEeQfo?=
 =?us-ascii?Q?3atjgDD633Oc9fOvH1hvSepB+q3AyXa/KNeecANKB1XBMHRrFesGNrsowtD3?=
 =?us-ascii?Q?GolDhKsJdLlgOFapDdXhdTa+Zrmd8SShdMdrIrLaGhckW8yr9+BFClQ8gLFj?=
 =?us-ascii?Q?jvyRf9c5O6OoGeSt11OqisOxL/r9uwdPdFI6AxPLOX7Bgbln+f3WPsxj9b63?=
 =?us-ascii?Q?1y2kCC/ZkGBF1vosaZg0ijR80pQ4TnA78eajgJN3kUtv+D1S7ChMV2GwbhuY?=
 =?us-ascii?Q?RUMqqbNrVMea9LEv+Q2WxTj+P6gKIPhqzRo600PdaMgoh35m3wv2tG1WdhAA?=
 =?us-ascii?Q?h50+8K+hkYEWJBJBE/FWjZ0jBfG5xiYT0U9pbBLVIBQHAllYxBIid0xIYDbQ?=
 =?us-ascii?Q?tzCzA6AYHYhPrdELVwWpVWhVGgmnbNhs7axBsgzJ4LTXB32QG4/NyFmgdU6j?=
 =?us-ascii?Q?yzEPPDtiglYfH37teBl9ByphWCMgGSab401k05syOIx2qrbSJ8fauo9AZkN6?=
 =?us-ascii?Q?xQCHx71S1cEpkQeirx4HsLqeRY1yVnHR4Hc+FcHMV0qyL7fc14eHiU0w2qyg?=
 =?us-ascii?Q?Jvnrw61xAM25AYIirksj0hj03sCJHC9mEb4DXnVLGGTJgPCszoVMgzCHG967?=
 =?us-ascii?Q?7Hoev3O6Tuvr+TVyHsOZrDL5i2gb5Hu4SdlCsVaFPFW6NgIubXX+5IinyCb3?=
 =?us-ascii?Q?HdEicLcaUl/cFH1teYW/KkwQzbLMlEwrVisoMaIy1tjrdp0Km8REQbzhtAgv?=
 =?us-ascii?Q?rQDxM3Czl/qDBaTKuYNvbnnTkDKRfCMW/B6hp45YOvMQPT6rCpzyxBvhjTNL?=
 =?us-ascii?Q?phDD/kNr/QiyDcqVSJoutebiQ2QK0Cp9I3ZEmF2NpfQfxK/gjwumEJFmH7vq?=
 =?us-ascii?Q?/WJssT79+rKpLTwZ9Dpd/PykkX07g2UybUHEqGXpihpcGj6V/7GK+kyGOo46?=
 =?us-ascii?Q?/AaD1MzQJZV2FpfHDehRL9kQJ1Zt8boVB4dC5h3M1g+M9Umi0mYcmfTE04Yx?=
 =?us-ascii?Q?M+3GqAHEuiBGR3T4n9E3Dd1xZgkk9VG3mYVmEXG7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ec0ea3-9747-4a06-4d20-08dc81a94726
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 19:38:42.3617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rz/TvqQZPWRsrcDomN7e6KpAjq7Knvl1XKZj3YHQt4wBAaljqJT8kBP8eul2+sTBttnt5Gj2DpylX3fITAcNRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

Fix this by moving the inline asm to "pure" assembly, in two new files:
clang_helpers_32.S, clang_helpers_64.S.

As a bonus, the pure asm avoids the need for ifdefs, and is now very
simple and easy on the eyes.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/Makefile           |  2 ++
 tools/testing/selftests/x86/clang_helpers_32.S | 11 +++++++++++
 tools/testing/selftests/x86/clang_helpers_64.S | 12 ++++++++++++
 tools/testing/selftests/x86/fsgsbase_restore.c | 11 +++++------
 4 files changed, 30 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/x86/clang_helpers_32.S
 create mode 100644 tools/testing/selftests/x86/clang_helpers_64.S

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index c1269466e0f8..99bc2ef84f5a 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -113,6 +113,8 @@ endef
 $(eval $(call extra-files,sysret_ss_attrs_64,thunks.S))
 $(eval $(call extra-files,ptrace_syscall_32,raw_syscall_helper_32.S))
 $(eval $(call extra-files,test_syscall_vdso_32,thunks_32.S))
+$(eval $(call extra-files,fsgsbase_restore_64,clang_helpers_64.S))
+$(eval $(call extra-files,fsgsbase_restore_32,clang_helpers_32.S))
 
 # check_initial_reg_state is special: it needs a custom entry, and it
 # needs to be static so that its interpreter doesn't destroy its initial
diff --git a/tools/testing/selftests/x86/clang_helpers_32.S b/tools/testing/selftests/x86/clang_helpers_32.S
new file mode 100644
index 000000000000..dc16271bac70
--- /dev/null
+++ b/tools/testing/selftests/x86/clang_helpers_32.S
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * 32-bit assembly helpers for asm operations that lack support in both gcc and
+ * clang. For example, clang asm does not support segment prefixes.
+ */
+.global dereference_seg_base
+dereference_seg_base:
+	mov %fs:(0), %eax
+	ret
+
+.section .note.GNU-stack,"",%progbits
diff --git a/tools/testing/selftests/x86/clang_helpers_64.S b/tools/testing/selftests/x86/clang_helpers_64.S
new file mode 100644
index 000000000000..0d81c71cad97
--- /dev/null
+++ b/tools/testing/selftests/x86/clang_helpers_64.S
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * 64-bit assembly helpers for asm operations that lack support in both gcc and
+ * clang. For example, clang asm does not support segment prefixes.
+ */
+.global dereference_seg_base
+
+dereference_seg_base:
+	mov %gs:(0), %rax
+	ret
+
+.section .note.GNU-stack,"",%progbits
diff --git a/tools/testing/selftests/x86/fsgsbase_restore.c b/tools/testing/selftests/x86/fsgsbase_restore.c
index 6fffadc51579..224058c1e4b2 100644
--- a/tools/testing/selftests/x86/fsgsbase_restore.c
+++ b/tools/testing/selftests/x86/fsgsbase_restore.c
@@ -39,12 +39,11 @@
 # define SEG "%fs"
 #endif
 
-static unsigned int dereference_seg_base(void)
-{
-	int ret;
-	asm volatile ("mov %" SEG ":(0), %0" : "=rm" (ret));
-	return ret;
-}
+/*
+ * Defined in clang_helpers_[32|64].S, because unlike gcc, clang inline asm does
+ * not support segmentation prefixes.
+ */
+unsigned int dereference_seg_base(void);
 
 static void init_seg(void)
 {
-- 
2.45.1


