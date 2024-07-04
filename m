Return-Path: <linux-kselftest+bounces-13174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE7D927078
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E2B1C22FFE
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 07:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CEE1A256C;
	Thu,  4 Jul 2024 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OTFM3nmU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A83B1A2548;
	Thu,  4 Jul 2024 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077929; cv=fail; b=FMXxqe4iMTqTM4R4vjS0Ax2Sg3X94rDvlYz+LfRYH/XEyuFrZ93LpXxr1J0YRbOKGODrpx6j6ZsG7vi9kKWBduShlJFqhDns1k5U0eKeYTPIZ4E+2261xLx4KNcjGDYOkDduD8n3fm0reYb9Nj+XPtReeXkjiCH3g5QTZohWMs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077929; c=relaxed/simple;
	bh=Q1CNzg7KFgrBpGICrW6otC8HFz8qTN3t0zVW1WchG8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BADbzFgU3BIfFEHsfbVdf7SYRMmIPBZgSlL0PAiitlpHRPgwSpd/O4aPuPPSlTdm8Gkb0kR/bYwa5MG2R7CqCTgVjaHueIjEASez/2qM/DRFd9gWAhzbIAYPDUeOaUdn2KoN0oLGo03dE3wu1W1rz3Du04KtdSG9sDa5dMjA5Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OTFM3nmU; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oP1ZRtDBVLP+YrG4yBVSbryDMhsXv8/CVYiaglA5P+14Vq0glTVE+F9oNWlDIms4bYaGVaklozYa8+kAu3OE8Z+wyfBZRSBBAYjWHws4H//YFcafmF6BT0RHd2kprNMmenPN8KzyBndTVWNZvtMfzDeONxfolSS0yYc7Oad+Dg3cOOrNzlRR/sN1nb02JkhubW2x9zuCJbZ8OYS79P6MSrGF7sPM2lUlcY1qb+dkdJQVEYqHSBihyp4d2fIQsKV6ZBvKPXzFCSIpzOfQ0N2csQtr7hVaUv1s2qSMqPqHVWyqce8aBVM6yF5zG8MLBaJoNM9k4CGBeRxM2qbHs5TeTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrObOgsx3VK7nqLySm8Y0XSVs0ljqbPqnKHPwavHT9I=;
 b=NeFPRrNMZMPrZb/vIdS3n+tLUShxkRDXFxjWTMZaaE/o0pubBd9eWs0g4H7VU0n/8Yt/hsaaAGIDfUcm1feVgqwpIhCQnvW9mWEnN1/A7CHEKZm4f2vhNrkXfn0U0mPRi0CJPyJlT0Z1ISjHPrGnGHWlnVSPDojUm0UWFFpwnvGiZu+bSm/iA13cG9glJ2bMov0KP26biAp+E+iARBbho/12EpW1hao0n0aEMleJ3H1ENcEiOCieKvyyH8aS3+ZS+rpowS1Nh59Aq3blIDWjzoAQzNpd7Qi/5/7UKYlNR50/BZG0kS5ISIJdh6tjKePjf1yHonAwJ8BFK2uzmgf4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrObOgsx3VK7nqLySm8Y0XSVs0ljqbPqnKHPwavHT9I=;
 b=OTFM3nmU4gL1H9P86mo8KwEyloidJQ/wHjHUd4leEn5M6BARQBV/Zt6rXLLGAsLpHskKvBhrT4GNAkg+yWfq+d7Ys6fP3c5XW+w5NPm+od/AoV8wt+l82YxfiwuUuRdaIh/KRqpn4LVgokWa23310Sg04OqmVcTaaetclWntrEhx9H5ulvJp/SrZRurAyTCIPKPFSLrKrw2YzLd01ySx7SJUQna2Wa2A8uh+BRUkTu8E5lEBnxzaveEFEZy2TIVGq5lY2O5rrKnLYbL2y6vFTuCx4235AToFTcr802kQnPRa8FFnRofdJrMo3sJjhf5RX0bU2ps+ZXyF73pT4jKz9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Thu, 4 Jul
 2024 07:25:22 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 07:25:22 +0000
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
Subject: [PATCH v4 3/7] selftests/x86: build fsgsbase_restore.c with clang
Date: Thu,  4 Jul 2024 00:24:27 -0700
Message-ID: <20240704072431.111640-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704072431.111640-1-jhubbard@nvidia.com>
References: <20240704072431.111640-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::30) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: f57eb2c8-f3c6-4042-e794-08dc9bfa7718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8xN/ADqC4LuwHwfPsLV+lXqtMlJZEsuDg3iCHN600QaaZkTuw4qPqEKc396N?=
 =?us-ascii?Q?A/BC8gu7QGS0KUVpMVMRTNTfBefzuPOUoSgVj43PjjaJe/xGOLmFJ12O/R6g?=
 =?us-ascii?Q?lt73wHenv6atiZ6KHXKe3WABU8VXeFcYK3g26TI74Qao4rSzqFdqg8BMXypa?=
 =?us-ascii?Q?OWRGdW9r/+rLL1NWX01bGD1n8mR/RvIAdw3tlCoUJtNYcMqejZD9RtD746oc?=
 =?us-ascii?Q?MFDQBLd2NciU6dpew1zvQ5lhVf9E/itUz0UgOmaoY7O+/XuJb9BSPN7PZMtT?=
 =?us-ascii?Q?WHooNDre7pCbfsSrWeFNJRxnJOOxk/4TMHii+tUy3SswzfmyjmQ20c4f9qeJ?=
 =?us-ascii?Q?KJ15V6DHwsrvXRDem823x+l+IEMTfO0IzGoXhANL3Hyz+IorBuDOkmcOXLOo?=
 =?us-ascii?Q?DbFBuvncig5wkodEiifTStPWhSqwComx3Ra6QOaeiH7QXRM5b/9fs4D5Xja9?=
 =?us-ascii?Q?uDR6BX32JPOM7UBaGfajXp+NA/HtbXhRvchT7qbZ4EUXeRPm+D4HLPlxbnWK?=
 =?us-ascii?Q?UhEiWGgwLMrvP8M1tBLkxID8cbZ6HrPUPQ2I7atfsCVQDrXRxxy6ZkGxYlLt?=
 =?us-ascii?Q?Xv7V4Tbd1U63fPly0CMLOoKu5HoGj/roW0kzcCZXNsf8HKlAmdaDNYGyS7Po?=
 =?us-ascii?Q?Q19tXbYMnmY53LEEiLT05n/LLTu9N+00XCaoi3kjF467k9AUZ9pqq3W9u6P/?=
 =?us-ascii?Q?pq4Q8ik+IbYEha7XZWftKH63qiS8lTaZbzJvVJ5q8s/Rh5Hzr8SJmgM73EDe?=
 =?us-ascii?Q?o+tYo8TirEDn/rcMO+4rpx4Q0U8GJQt+T31+Gp3CE8Xcza9XsiMwea7kguVZ?=
 =?us-ascii?Q?IKhzZzANzqa1bRywHcHTZwskbUj0UjZeb2hKYdDL0drWhbm24jQY1x7lMdgU?=
 =?us-ascii?Q?E/CAdJf+1Pvt1ZpO6azEJCbY7kRbZ4pu+nVXR7diNPhtDAoAz0ngAqneJhqJ?=
 =?us-ascii?Q?NKvCpS+6NxRiU2ZKZa1ErVX2lZNN9A3n7RXOQXYVtX5svuRtZWX1/OoVD3jf?=
 =?us-ascii?Q?mhQvaxl6taJoCQIjljyTnvAoN4+f6bYaqO0MyUff5rAvFF+ofha8ioqSpzfj?=
 =?us-ascii?Q?vxQMz8mJJA9RqwxVbGRzr1H3GbFht4bxOzW5fR8mWK4iDOIieRBXPXnYR2O2?=
 =?us-ascii?Q?pYarz1EwGoEi412TmhNmjk9onq1hCiZSc7VBOgNN0BR5VlRHy34mfe5gCeI1?=
 =?us-ascii?Q?HM/fb4Wl0+xsIOHCIHIuZ6C+zQlR77c1OTXhlGcQJZmDX358IOAj+q1q+Ktw?=
 =?us-ascii?Q?FT26zIRXxaUEDX+qTO3PvYlYX8RaoB/YNuBJhC2zfF1Z1fHZ7wazZe8Ceg0i?=
 =?us-ascii?Q?qw1eq1Zkr0HjrQ9dmEFh3Rnk+UzhEr10vsZGKZYa3WLgTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IJd9XbI6cjcZRa9MSWROoBz8tM8cgLvS4oXt3A+NKVeQiLyFVYK3AVHcdh5F?=
 =?us-ascii?Q?gmVgen6OksZHMkXH50ImCEd30bdrKB1SIsW1RpZtnasE12lnf0rgl9ptPgkp?=
 =?us-ascii?Q?pp0oBkQeh37bxRSq4DL6pNSMlNyHte01vvh/f7hkCTx5v+CUIBpW2jGfpebQ?=
 =?us-ascii?Q?OwFDyl9M4n0n/qfHkv9UxKS+lHxX46MHYNKwNpo0I2vmsHlpULhmJ7J7zMS8?=
 =?us-ascii?Q?OTUOwdvgdk3dUv00IY7gWvDWh9Fy3jphu2R21xX1eCNJscwmi2rQx7YvQiZG?=
 =?us-ascii?Q?m1tigdJVeA5Lk0XGzOX4VHpSAVhmwxQ28lY670yhmm63tujJICdM+Glz1Yok?=
 =?us-ascii?Q?/Rs7FEB3FdpLqSf0ef2sgqjsRygxybzHFGv3Y8DJyNJ9xuZ40JDg1hPskRFf?=
 =?us-ascii?Q?9dVem6fufdyvAizlRPixEnULoS97voI6/jqfPTTXhnrjJJuekBjI9GaZM95R?=
 =?us-ascii?Q?DORFJJuEBZBTNSabzXFyZAxVm8wwSBScow5XTNYub9LGVdroiAqoyzI9gBVd?=
 =?us-ascii?Q?Hx92879BaPB7kCJpLZxdP3YfmGKeHXF6jigMQHfzp5VH8japJo+rJ4jg5V3g?=
 =?us-ascii?Q?cuad85MevmkkTW8jcf+c9hyuIGtmN+pgOLPOyWZMB3Br+WdIO9rrCP+tPQOC?=
 =?us-ascii?Q?sAJf1O1iI4omCFClD3K7tiT972A8BxpSkSiUKPtI7M27c56TeRanVhh3mI44?=
 =?us-ascii?Q?V1zzghVPcozCG8JJYySg4b8cAgpisyx8W/8X9VHvR1iY1b+bHLkv98oqiror?=
 =?us-ascii?Q?gkJ5dcSJM5cC6nhNjC00WP14/9J85Kbhd1qi+nVZopK/L1qbcxjmHRovrl2+?=
 =?us-ascii?Q?I8FsUh1E7UpfyyFyffbxtoJYhwqGI5X/7gup3xmirejukQ+ABsKg1XxWCmJT?=
 =?us-ascii?Q?G02BQoYCmHQ02lASXQ6olh/RTi/nb1k2UM2Zl7QjlC2ODcbIvGlTtxGCqgFr?=
 =?us-ascii?Q?J01YV++/KmukMXJofzgIa3kxB2HkG7bPO0KkSqZ56swqrjIFmrSQqWUOY2fO?=
 =?us-ascii?Q?Y6M5qPpg7YZsbEwKmtxH+vVcXcSC4t7L8QRsqRwkM/ZbZAtdXnD2YrSYHMOO?=
 =?us-ascii?Q?ilEjfnp5oiLh6w5KiZyItrnXrRlszQxfHg6hpPDe4zlT8oVhrvqnn/DSVvx9?=
 =?us-ascii?Q?FWR+QbDPXI4gPvEOIpLVMUbrV7GGANXTmPRhxGFFHICP/7mb4MlgU/kZQh17?=
 =?us-ascii?Q?DzEpmNTzA6g116z4jURIVACGA7x8TOd/29tmW6WkFZeVrv2Zn4aNTlV8CWED?=
 =?us-ascii?Q?Cv+iRUOClchvPN0j/n+gXfoEDVHElSBiYXE31ZURjizO6jkdvGfBsGnJloJU?=
 =?us-ascii?Q?60G0Xs+ea++T8obvwHHUZfFZN/kX5qi74uhl0MPkaT4AqogtMWRWMUIR0B6J?=
 =?us-ascii?Q?Cpz5M+89DIWVN5BCyi2ORDgjLs/oAJ90QzMNsODLtgp49QGk7gl8IixyFC1O?=
 =?us-ascii?Q?KEE7XN9NKssctbedStbYBmdqbw32ksyZOqdilb+WSsYNNQcfY2Wf8riuNMJr?=
 =?us-ascii?Q?KCbCClCw+6Km3/q8hnazqNkbdYZxQ4LA5IlpsnmUxWBr/PZrkfoYTmLMm6MU?=
 =?us-ascii?Q?IRpOl57yyhySdcSfY53HG6gDyBJSOeULEKAsygAAgaYjKEJRgdFFhrfLLtZI?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57eb2c8-f3c6-4042-e794-08dc9bfa7718
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 07:25:22.2609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9n4XtMtBwaqPfo4ZDHKSNYls7jpuXWdKwGkTiZIEvoFcSJCk9l/vcUWtf6Q2NcuPWEM1J9an2rGOparkQkTQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

Fix this by moving the inline asm to "pure" assembly, in two new files:
clang_helpers_32.S, clang_helpers_64.S.

As a bonus, the pure asm avoids the need for ifdefs, and is now very
simple and easy on the eyes.

Acked-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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
2.45.2


