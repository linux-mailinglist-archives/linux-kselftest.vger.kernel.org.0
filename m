Return-Path: <linux-kselftest+bounces-11052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1AA8D69E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D441F282F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 19:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050CF17FAB6;
	Fri, 31 May 2024 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NcnQlOXe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2854017F4FD;
	Fri, 31 May 2024 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184333; cv=fail; b=T4bX1qPCAM2sY017It7H8WBBZX3CL3BG3sYuIE899/ukb62ypT20F8UzOGdUzoJxBjNEfzEXaSbkaX7QyP0DhJMUDs9NDJaloUdXAUli5+w/LnPmu5HvlHlxbgpx8sFaJJtWVOCm2inFPYRKXNhXDf7d7PIfGWzg43+IqsaMwHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184333; c=relaxed/simple;
	bh=sZCxTxWEtQxZGK+EifvLv5cZ5W/3JRXNJXdq4I5B6Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OwatYp9ARyZRvkIdbypGKtlX69wx0syTKrOscxObNhacnBDvGt0/ayzlTBQLwZRh2uJKlpyL4YPfVRjzGgicqdGozPKtLdAImy/3SkNY7TWUPGOXB9Z9gFzXxhRGxi88yqMCPt+XWP5Om591s3KshQX5orPOFkLU9LH1q2cBY6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NcnQlOXe; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiRSHgosmFajUhurbwMmoB5x6tXWfcEox4+yk+Vx/xYcjxONjhk924ut8VZWF7TAXYHj1SnWNla6rDp0LwDWCHlpuLMdWmr9fbAFTIrLhBOjI8J5I3mHwIzBd2b1pYcPoY9A+jNP87oneyvjeTMadDDv2Gn/TDvBTePuWVuzfKzg+K8BAXkiPNkgNvQErs0YyIHt9ao6tOeYlT/xNv8S+QjTWSrR05cUgrDBrWyUFty6h3ysJqKNPBuKFCf3uKDyiKlZjHZ/UdHttM929b+2YKeFkaeRhxMSuY6NoP8lurpgRcbZV8FrrOEV5kt1nSfY9nqiMxVokCChudLyFWYMhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kERYs7d59/Z7pbTD2r2wglhAfIzLK2oz7ZzqEz9Selc=;
 b=Y70ttOb1MC/aX/EZD4UjBaz9tXFQBOXbpWk+rTZmM4oj2TpycbCUJ/m1USLI+dF6WNXrJrjQp7qrfiiqiPwOLyAJ8v9rW5p/HysAOX6wFLJsDBVOzw0UeYjZ9pNNZ6VGcPvkkclWIe9/qnnc3qgbcqk6jKwarpomybHsvIwyVnHt1wdPp8DwbBVDxWlvOOjk3ouMDirvbkq2qAWHWBnkkeD2y2450THEiKq+fN508f+DIj7XsQVIVXJOlKgCAyO20QEJ8LtWGuHg6nzUTdnTkQSfQ1zRkDiFMPvgfOK7+wVoSUeoystKg6+GnWXr720MG/otoMNDr5JAvRBlarvZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kERYs7d59/Z7pbTD2r2wglhAfIzLK2oz7ZzqEz9Selc=;
 b=NcnQlOXeZEV6+LRHH+gtk53DgvGh3LmRW4BoWigSUqx+2+rVOlxZ6aTiG8Xpi033O9dvJ0sKR34TMS0S0/HSaIgjx/QFezsTlwypybI3BgDx6fPaLd8+DuDD0BAlXACHCLsX0UASvfFmHHlJNAL8A3nXw+3G7cq0idwsv33fYK24cINpRGA8ejJRnv75uXiRSWNwMZPO959RocQNMdd3T+Zx7ks/8Vv52+uI8zY6f+H64G4C1PV1qOS4ZACP0A/Y9Kz6GCoHlQnX2QVEBJQ6sHpLmGM7W/m9BmtukH4EHNHrb3SlAHum/zyCrjup/x54cya/jktOeW2D80qkGpvI0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Fri, 31 May
 2024 19:38:43 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 19:38:43 +0000
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
Subject: [PATCH v3 4/7] selftests/x86: build sysret_rip.c with clang
Date: Fri, 31 May 2024 12:38:35 -0700
Message-ID: <20240531193838.108454-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531193838.108454-1-jhubbard@nvidia.com>
References: <20240531193838.108454-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:332::7) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 729b9ecf-a275-4fe8-b3b7-08dc81a94767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dqlX0FPCbiOUjN4w0ux9tGScYxVDQmHsQV7BrxJF1zX/n3828zpf8M8NLIS1?=
 =?us-ascii?Q?DSKICNIyo+v4o/FZrEhfyVF0KzIA0leSzuObeuv14pHvuuN27cLyGlhOqwg0?=
 =?us-ascii?Q?vVQ8hnTXsHGSXtr8xaOitKpOZOgiqYLPTUoU9vXkQNU9NtYwDMCB3z/77Xmd?=
 =?us-ascii?Q?6FkQCoTe2XNqo30IGwJmj7xbCngdvh7OSG7OjPzmJhiSAwmLP2kP7d9KVDnQ?=
 =?us-ascii?Q?EpcmVq4bSgks5nKMoDue7eI10NQYBjCfA1x2xSmgZC3soqCrbXV1ZDKlnwf4?=
 =?us-ascii?Q?gu4R1TZC7xIPHXL4t9KD4NwmgCuKxz+PvXRG9ifg4/cs+ah6hlVAoLtwpwmP?=
 =?us-ascii?Q?2I3bX/j23yvRRvcNEsv9XOFu8puQlUvof0kAe8NWwGureLxHsw9VPlyEtH6S?=
 =?us-ascii?Q?KD3Fb97nvs2JwiFwJ8/f4k9ZV8EJUoEbvniABuLW4icyh127gnXWOFLE5IMv?=
 =?us-ascii?Q?9om8jITgLLumFZIA0H+bxodD3PLC4ly9/it9eUcoa1iOeLyYRW1KEad4g+YS?=
 =?us-ascii?Q?XrwtAKOBLflb4aOFNytRe3o/VbgCPwiOZgYHm6ZivIjY2opTnt9C4dmf+CR4?=
 =?us-ascii?Q?Q0lCdlB/4665s7bL7jboo+hk7/ZYtIX4oHEq8BRMhvfb83JCKs3OrOUPZmAA?=
 =?us-ascii?Q?On++5hfBMSRVjbnOIKnveLwZYoYMHvfGuSDCsMOsgIYN+zbVyKXZDYbNKCTw?=
 =?us-ascii?Q?SAlREYDN+52LoFv0N8FtFikKzb+J0uqrky1XJKC29ecfwrjMmemcqih22mRU?=
 =?us-ascii?Q?RrWt3u6zeTdQxuccogs+Wx3wBxLmPFJchT0VDug6hjUhy03nZPMIn7S2agsF?=
 =?us-ascii?Q?V9wlTklv2Qv8XC03NnRyG8nTr+wI0isfXPCIoK9K9LIy5goV9APiXeMZME3y?=
 =?us-ascii?Q?gbxdgSBzczpOKQXczBpNJVr4bmsVEeU5tAThE1Rn8Fbdio8RGCFV9iawtaFW?=
 =?us-ascii?Q?fxwxKDRtIiG6hIZPk9v+PRmED1Ky1x1ojJjWAiUPNf66G/pf4E/xlTRNTzhW?=
 =?us-ascii?Q?FgP3OTibjzEeFqXLhlFpqLXTv1XOyh8yhnhUaZaiSBT+pB7cjMyWZ7QAe5P6?=
 =?us-ascii?Q?r+U5bm9pnt3ahF7x8q0edC184dXwzF5k9YYAbgJDWFGBQoNV7gN+v9OnlQaO?=
 =?us-ascii?Q?ORiT2McNbsczmWqUoFJOE+ddFAxFwE0PVkJE1xbTPujxoVDL1ob8Q4oRAE17?=
 =?us-ascii?Q?ZP9GpgCqfUAdlOLkMtupbVW4VE6NV3ShaDQiCclxtwh7pSu0D/hVUr7iodaN?=
 =?us-ascii?Q?MPZ81xFAjqUCMC7QmCMugMme+JwqCzUliXzblI84ng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1lzfvi86/FlpeuPQlVzXYMHjVdl0oU30EyQHMJkKag9Co3s3KPz0X9levqmB?=
 =?us-ascii?Q?yVosz30cEOa1DBPKGhd5DUxeJdcB3YA6jAvMdSJE5rLNq3DWGVvZsfvsfnne?=
 =?us-ascii?Q?kzD/Gc07kUfqOBk7hW88MDiXdclIdkVBtRRzdeD8KrfQKpaKrc+gCZomoE9u?=
 =?us-ascii?Q?DfexIOj0LcGCeMvhnl6ZB+bOnAEIeGYUDwMLeuHW2x/pcGWSJzHZOLrHOgET?=
 =?us-ascii?Q?DYOMJFMW0K5Lz9PYOKY7YXWlq6h09/lzRMEycCOnQZ133muyrlXzbx+hQQhN?=
 =?us-ascii?Q?qH/ystjH+2vk8AQZrlDNir6lujYQomyAgrBcuCjxyJe8nDcQ7H0bPeXOw6Xg?=
 =?us-ascii?Q?QpF54s6KUFhb/Eoz9eQT/9l00Nj886hbUzxrNa3B3dX0jOcTB8jSVsVzghoL?=
 =?us-ascii?Q?194UVf3Cra+/V6KELwcvnfmW4M5AwTrrq49XQrRF/2BSZZjx5pTU4jFL0rVm?=
 =?us-ascii?Q?G4UiNGkACGGn9/rFktzEgje8xDa2DulN/Lgf+ltCvkbqXglRUWl4Pk3FxTvF?=
 =?us-ascii?Q?gsVT+gtyniPxs1Lbeyt92HjHNkbH7e40gOapDbDe+cpXNWEckgr6l/AtoAzx?=
 =?us-ascii?Q?BtVjJCBUocD0ojMCTSwaShQkO7AmMM6F+CJfbGBiugPf5/fz/sKwIvS1v659?=
 =?us-ascii?Q?arCq2+Xz73UklT23JVT+IKlFqo2z4tDPZfETft51plotOfi12RRIvVl0tdIS?=
 =?us-ascii?Q?I0XdpiM5w0WJP24XmA+lUz+GzCfxKjKLyYvHb8/Q6u78FKCajl18zad3XSgg?=
 =?us-ascii?Q?1Fc5JuQT79TSvPBzTBSMc7hXN97mGSumlREqVEzask9P3FHhls89QwAPrftx?=
 =?us-ascii?Q?E6UQKHIOWxGEiKocQectCjQaeiS3HWsIGtvhzwVnRsVVmbz3RT7bt78dxFgH?=
 =?us-ascii?Q?EcINfIaOJyZfn290nemLoBpl0dvtzyd2dyW2tiGGbfmBoH8DqDlYDrkzUynB?=
 =?us-ascii?Q?A73eCSPa9N1Jks/7O4YA64SJYdgaDliQDTYomjej/vQZ3FrARzNywKrpV89x?=
 =?us-ascii?Q?7Fnx02R6YYYlp0Hhd8hjs2m/ZjFwN3VdxP806sUBPN5IZ3YUqSY3kC9BRIPb?=
 =?us-ascii?Q?qYxgHoq/xWeldoarJ+auPfP4X84UmI5WuKdSSBVjYAcLq5Hq8+DR9j1zXlNQ?=
 =?us-ascii?Q?LFTHaTlEofEWXqdIbn+enxkYz4SpRDlZur84UGACvg3xg19fDekeEeUDr6GR?=
 =?us-ascii?Q?Rypuh90YR4cMHKktdUcC6wF6DlUZuUVBA5aENnQFxlhxmXq7eBDuB1MiqUw7?=
 =?us-ascii?Q?3j1//hpwR1YKONgEtj7go9kTWmhCISGVPY0eBsCQ6+I2TWpm2dfroSLDsPtt?=
 =?us-ascii?Q?lPJH0FjlqG29NP5m3MC+g5OrE77ZqOuYmxEJEtZ1iVMp1P5R9fyUSu3sZeVC?=
 =?us-ascii?Q?fIq0/TRyK522Bc8MCIMQPb4/hxlmRfGs3utp2tcFVAmwZAYyFqYG/wkSEpal?=
 =?us-ascii?Q?dCeluvUJR5gyLokXWkFJ7jCeomJrz2vELrj6bCuu9fe3opU3DpAyNEvwHjCs?=
 =?us-ascii?Q?a1uaegN+wzi+GXIbzGTiJOgD492ZH6s2+di12gFbMVj3J6A0O8xHMOy12avX?=
 =?us-ascii?Q?jTimR8T200RdzHOqXbYjpLnqgKiVIHFtvzG7mhl4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729b9ecf-a275-4fe8-b3b7-08dc81a94767
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 19:38:42.7901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvW7Hb3uRG2KZIuo/OQPjtyXAuLUHe/cJAXEvpJbTV7XNj6hAyrymJG/LpsoIO3k+iTszBRi5s66u9yAnopvYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...the build fails because clang's inline asm doesn't support all of the
features that are used in the asm() snippet in sysret_rip.c.

Fix this by moving the asm code into the clang_helpers_64.S file, where
it can be built with the assembler's full set of features.

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
2.45.1


