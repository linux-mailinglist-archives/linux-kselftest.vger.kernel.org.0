Return-Path: <linux-kselftest+bounces-10745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674D8D0EE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 23:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9751C20A97
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 21:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9CC1667FD;
	Mon, 27 May 2024 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VQckyj5Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D421667C8;
	Mon, 27 May 2024 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843676; cv=fail; b=aCTu24cO+ROifRLpuS4gtNHiV4mr1jf1EEocNfUdzi79ZnecRRJ/sRtvfS3l9flLn7/LAmqnm5tXM0MeNJJvScdK0Gg3N1uPOZh3Ahr3Dh+N3VKNL6lLqZKyWHjOXOKZMyRpnAF77z6RxO6Jh9wlvjG1DfanIVS0j78de0mZteU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843676; c=relaxed/simple;
	bh=GuG5f0TQP6pUz66LVgwMcXUrRGN5M/R3zNBOo1yLChE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oBz2dQfnvOKfcALeJaVrV4mkhQS5rT3vDPEYUoivgrfCVtxnTakncXzqM8VdNVSbmZIEuZ4bImL88f1P4h9KmHshQx3iADlwMmYu+9aev3snTnyGxVMHni9y8exDtrtvZSClWnLbOLmtgDp5+X1l13KVMUBAc+l2PneAIsSMUWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VQckyj5Q; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nht7zSJdXH2LA4B75SfwZffNzyoGdn2CAAA6Wn1AuNffSZhH07sbnxkn9uWXNyncBgG7d2RpG8iFqmVsZjy9c7a7qB/l1/tDdp2SaUCuBTPNONqhq4DFXKjdWbcV9oazASw2HrUqVI+mgdkBxE/phwQsFB+vOolHTVHPgh0f+yzpN1ioJ4M6qGqXLbyHqDIfA9oTY31gxDgAGR/RW54i/XDdj1FAmJbFlXKo7YA6FynhrrlxpiWbdfJFiSwIoM+eYV0qxr0y+dqWza5oOsqC8vQh3aZkJCHZnudvBPtiRkH2qk5QFtQMYG70m/DlUFdBTVrXUInxh6hhHsr/PUgc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KsXrc64B/n7qJbqVHIkeMhVnrby9P0KpJTm+Hbyyb4=;
 b=Nl8gtS2rVh9LzU5K0vBu9SIBJK9pTZljR/UnrVI2tXbO2D36yK2BfaEy9p3973/kZxyXjZ1+/Ht2VqznZgFOhIfE5mf5JVtzKu2MtFBuiWAD0n137OvDDwAVukPedL9Sui4tVzY2sNKDcop9oUNGB1d9zt+Hm/VVxSRME94WkEjUu/mw5Zf3nOem2xDQAwQfbwLi88i4/KkmEkSjukd3N4/FluNIsL+U2O2qHRvWpG8NeBFAwnGPETjbZj07b7WlENuOSONON7Bn2NWK9ZhKR5D0Bfjg7u/qgA6/eOG+bkDrg7wLTM5T3nklM2bnQr/+qWBdzukU4qpZ++8TqTgWvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KsXrc64B/n7qJbqVHIkeMhVnrby9P0KpJTm+Hbyyb4=;
 b=VQckyj5QBJOJa4oE5ipahNRJWgwsd8OLwG+2e8YszLaD5++et5ZYfK9v9WTVvNTo85uuJwEJcpiu1Qvc3hqrJBjVdfhYWuJjwsVs3pBQ2hU41yNW7BlUPuVtylZz9KqjSXKBEm/DXY/+iUqvF8SL2Mbq3HN0M8Tl4vUS7Cv2KsqJc+KvUL3v8q1laoRpFM3+KvEWhpE2epGcTAr0VKCSxMFTUETmR2k2tdRYrGX9kUyiv8ag4EonXS89IPGv2SALVCvPRNuTAojc20zdvZWS2PjrQPrPK0l60KxjA5mix1FsezDlxQC++ctJ4EIK3uR19SSz4svI/tPEUsIJphRbqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL3PR12MB6620.namprd12.prod.outlook.com (2603:10b6:208:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 21:01:08 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 21:01:08 +0000
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
Subject: [PATCH v2 3/6] selftests/x86: build sysret_rip.c with clang
Date: Mon, 27 May 2024 14:00:39 -0700
Message-ID: <20240527210042.220315-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527210042.220315-1-jhubbard@nvidia.com>
References: <20240527210042.220315-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0387.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::32) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BL3PR12MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 12cfd5f2-2d39-4350-2f95-08dc7e90214d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v2UF9j6T0ZLjNz9n8vnH7n14dNCL1VUvEfbSd1edqpwAGER4UvvwII1gGovu?=
 =?us-ascii?Q?WEgyM0ZWNVA7Ni2nKlCxxtHHUN3xm21qRxld2U9jv+pXwR7M+t7M3WoKnZ+H?=
 =?us-ascii?Q?SIs+aO3waMf4wOHUIbzXMPuBmD9qLUXr/Nx+OZr5gmh+WpWyUwSOSFrHPYms?=
 =?us-ascii?Q?Q41bb6ROB/jYcuRNTXRAQpszYMnKcSqd3s1B3JyiHWHclZYgbi8B5kCtqrEM?=
 =?us-ascii?Q?MI0J1ALhMZ/UPJZbU0QRQM1fNssaDWlH3ZiFQAbMowuBNidu7d5DEwzjyl6J?=
 =?us-ascii?Q?xShzm08oOxGdxSvo1tAQtVK6HczSMHRZZKHRFC5Oebpw6LFO49jn6AGR04mz?=
 =?us-ascii?Q?6yWv60Rxa9xNIUN1qtpZBFjl9gi6AWqq34o/3vkD9GaEtxytLw4ihSfsvDlA?=
 =?us-ascii?Q?sF1x/L4yz2zUJk68z87m2EWX9uNkj+9Tr8TwIbcxTtl5xF41BlQZJCphpBzo?=
 =?us-ascii?Q?jrgFKyuNixw/7QklFBwYzgFDzi5ynYrTp6PZWT6vcn4tncBb2Yaxuq7DNDgV?=
 =?us-ascii?Q?BOpsvCB6pFqqta+W9WX0MCUTH6/DrDDlf2YPdQJuIXswup+nDEu33jxCH5sC?=
 =?us-ascii?Q?Lq9oabh2+qLU2a9Xp0U2l4JI7fZNaTrtTHRcyhRFfT4lku1sxNiL2cGsp83G?=
 =?us-ascii?Q?xc6wnbZ1LYVvHgc9iTEzsH2dBosaHTBj/Zy0yC2URLKjMu7J1hJpavIds0Zb?=
 =?us-ascii?Q?IHhd4xM2NqVE9pdR+OWfe5VPkcx0VdgoHXr7XdDpa9kfCH0eIyAAJTYMmom8?=
 =?us-ascii?Q?eWbT2CxMZeB2lSh0q8QcHwAFu69UFekIj6i0vt6XZ75iNgJ/fbRTYbn5HiQl?=
 =?us-ascii?Q?UGR8P0adpCNXigNcjRcWhw497Y26aXndyJBLHyjT6OBZYlgKset9fnd3Xhe4?=
 =?us-ascii?Q?SN2apodBgfaPoBQZdN7Y74oOFuIW/oMvkJcVDZpt4zdCiwVHlK0EvnZhNgOs?=
 =?us-ascii?Q?ObyrMMzgAbnalZg9p997+XmXu2lZzH3wmAFzHfx1UQcyYkFFY/e65L4p8c7u?=
 =?us-ascii?Q?tVT8yJbyXtfnhODVjdqLAzcKH6qyXwgjdjHP8WU9lDkbZuzRijHGT+zxfGva?=
 =?us-ascii?Q?VMBU9XWi7aCaLbBKC6BX+vOifgtiPoO/2Pyw04DyDilMEIzuruz4sdAu9Y2b?=
 =?us-ascii?Q?jlbGILuD2KvvGuBlgwe6M6MfGrjzfSAiSRLWIIMARxbPIYav+bJXor2n+Bnm?=
 =?us-ascii?Q?NAhwSToVKbSQh7okB+gaVcIqHRyaiCDOG5aHQAEpEc1MOYHThwULuTBHRvdj?=
 =?us-ascii?Q?oEnMRt7MoHeVm6tOgtjC2/0e7mqWO4GXL9btlFo3Eg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MhlawuCHpdgGZa4dIVxiD0+jEeALhkN58GWLEHJdor+yF5q6QZRnn86H3iNJ?=
 =?us-ascii?Q?fvbwbnfTJe5+aFnaCXMVIBE6THfpKyWCFApnuZqhS8zOyNbd69kYrA0UigJG?=
 =?us-ascii?Q?ALpw1kLvgVkABoeRoenYsYNdniSiX8gzBflwADUuU6S0APx+DX8DHYSUU+ZQ?=
 =?us-ascii?Q?sEs0G0a0V3ej/0i4bnZrYVxSDsqL47x9UixQA4hEdDKpOHqqoLS9xN8AxbzC?=
 =?us-ascii?Q?cgnY6nnZcXBj90xcGVxE2wSYwKWT7TEICCU10zjEUz6F9xPxUSbqQ9n08dbA?=
 =?us-ascii?Q?eVsoJ8xatrhUB56z9mkrZIw9wHStxrmm52hp68tTsFS+0FBzk/2MuPCtgiSV?=
 =?us-ascii?Q?1NUEZwqN0/Rcn2jRQepZb+dUUYVuT2jSc10wQqAWPSsIjX0dblnnmFnvj09d?=
 =?us-ascii?Q?P9WQuS0DZQQ+aImx/Ny+3jltrloXJwP9kRopkKvsg4db1fePSCRkJ04UlLPd?=
 =?us-ascii?Q?SEiK0aJI8exTPulvVvdXurhu8NBMnuRwBigApt5X0oXAhKu2gudK43XRnv4k?=
 =?us-ascii?Q?HXXheLF2ZWQCfWzU4fNXzpVHibsFE9HQKybSUkRsfNWPiwudoxw3/3zXYlhg?=
 =?us-ascii?Q?83rkOnktMXMmYRFc9HHFIJZmAX1jMWWv9Jwq/HRgavbJtpnIkz/JcGu/lxmY?=
 =?us-ascii?Q?g8tqT11vg3jDmCxBA2D5CNSZjtNpkSgHc//SvQHTudRp66ivnlHG2edlpHcv?=
 =?us-ascii?Q?ibEp/6GB9gEhnsVIQJguwQB2Im5vQ+5ZuFEh6rqCgUqvUDC0uKid0IEZuLSY?=
 =?us-ascii?Q?rZDdiVP6O6cdnkL//fy5adFiAdAbepSK+5RJpShv6KLfPF3h7PhhJfBk//9f?=
 =?us-ascii?Q?PZ+XFjoqATLpAq8OZnvgZ9erSQPtzEST3Fnb1Cq2HJTjzGpJipOozLmgmw00?=
 =?us-ascii?Q?5gqzLyTBRLZpEPGijKNVumsoThsWqe3JBYwp5ZFfQ19yIIdKhKPJjc5WyzmS?=
 =?us-ascii?Q?raBGDOO8desXabXTt+A1bMjPirkdNxC2/HTaE7KwRCpYnSaHwxufBjit0A6N?=
 =?us-ascii?Q?AX2AaWSfjTrj+W+lRAZ7ReVdtVfyhscmQ0ufU5goLJSxCjIRPDhlM9ASPBQM?=
 =?us-ascii?Q?CmNV+0ZrpfGxbyCo4XQvxZkfoNNvrnK22NqL6ChP+WfZ60eG3CfH/MUg5WCX?=
 =?us-ascii?Q?6kd1enPuB2bz9GKPcWqsDROi3IbZStcQLX4ygRBPBGb+nb53zY/2uowfc2lm?=
 =?us-ascii?Q?j4iQbTrRzyGpOZZCM6UXslkeFex/ThnLBWwv/tpxz5KnT1fSraA/SOCeEkbZ?=
 =?us-ascii?Q?XO9MN6VkJ+ZoYbiYYAKJa9pkhRa+u4smkPUKQwbxpNkMwbnwjfrnnpOw7lPN?=
 =?us-ascii?Q?o446xa/nhcGvwM85enY1tRI+8ZIWmTag96bP1Kuub0a3yRJUSFbzZ3FCnjiO?=
 =?us-ascii?Q?CWeK0wVpwVAflI8OpOlcN0xY+XqNbcSfZdn9new21Gop5vO3OF6cvjleeGC0?=
 =?us-ascii?Q?kT0fvnA7Gs9V0d+CHQQC7lke+7MeolOoTsFjyEfeV3MU19Rsz4pkPIda3Y+Q?=
 =?us-ascii?Q?di/GUNb2fbR/+iXNgdTCmrknjYt5EhewGmL4A/2WwqlpSIDeW0Z2ymaQ2Rzx?=
 =?us-ascii?Q?XAjjiMH+xBiqzE1nsyX3+v8Ps8mIkv3o+Ya94JMlidkGw3ejZbftJGaC4Si7?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cfd5f2-2d39-4350-2f95-08dc7e90214d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 21:01:07.9591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BT8LCEfG8ys21qA53zUQHDVEZyImzmWZ1EYKD6WS3OBFEOudAxs2N7rCfTldFfkLrUHbIma0DfKJbULQ9orGTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6620

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
2.45.1


