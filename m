Return-Path: <linux-kselftest+bounces-10809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B422B8D2A9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 04:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D470C1C20445
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 02:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE9215AAD1;
	Wed, 29 May 2024 02:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kPzUp403"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A622324;
	Wed, 29 May 2024 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716948530; cv=fail; b=QzkXPxEV8CVMsNOJPn/R8x1JIpdr9MyF6FGXK8sC/xRCcKGYDtEX5AyvXE4+bm6tyB4QWRruu6RpYA1L5IBfOq4yIR5oGaom1uOlEx5sQ8CnIEQfbp3ind+zf/Wa/FolkywJLyW9T0lc/p2UDNl+43HKovm32ld+w2vnqHLnbHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716948530; c=relaxed/simple;
	bh=pp9bWfqqeEZbtm7S2inhY/QlcergszQi0EAv+89U7jY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=in+OQ86vDoLlwNUm+9+bjhQxkzI/bBL+nz6XcCxnfGX1keSq5wOBtC+Y6BddcqO+LGCADwT/a/tCiISGKshJmflSO6ODuuHTzGrTKYs8ZYi82R0LyojK2TxyaRRo4olLHW/h4Q1oa0fVh1D2FKGMGZS0grvSlj+CRwGsvRyKT2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kPzUp403; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBUgU7ytEGohYgZk4z0H6CdIg+6IGHkLCw4IRwelHfVvdGdfRI6G7Th1Fn/mIlGPxLALTcc2p2sIZgZBZ05xFM2w9jf/uMwBw6SF1QMWwsFGs2TgwshA8vHUUv7Ur1yjItLQIf/KL/GHBGAm7CpN+u5u3bhMa0WmwlaeB6haX0K5ZpDiOh72+Ad6axBr4HqSVYJsMvPUgpwyMdfd+wJzShNBqu/InBrnfaTWa0kLZUmhfCNK4mNmGE4pgxbJbqKhEPdIQ23JKtSdnfdxKBoD2Fa2q17AK7ePuhD93IiX6uhZlYp7p9t+NmTPskdhMphIda4YwbE0MvnGJgdLGgejrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+TLY8oZPISJ0GlB2rnsmYRq5mOfuXjGCEQ7V75LBMY=;
 b=V93VtfEnCAB41vgjmj8xTCb/PoTX54JHtOzdoYVhpPowZyPKr6/5llUMDBLWK8milliIUZJrixoPdA1mfyGE9RnnBVO3Df7n+z32VZTHFbbVMHFIpiWTZlMa/sI9v0NNuUwsBewkPGrHOeJQcbZQb3b8m+wNNPuU6hUCP3VxHCBbn2H6C/b7HqawgH4r3BLaTsl5YuAIvO+4V/efJvJF7CcGsoUsg1cxa7IcyKcROo7qe2MbHZ/we23tW0ae24PW8r9i12KF+SRelm+xkz3qEz4FhNufW2Wyh8JfIULQ+cVdvLBM/nfaQhw4+RZrvsOBJtEmoL6UINj+UcnPgNlJzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+TLY8oZPISJ0GlB2rnsmYRq5mOfuXjGCEQ7V75LBMY=;
 b=kPzUp403QFet63jI7yijgOH+9MOVdMAypEJ8I9kveJZtjXjNUrpHAo4ZjxIJx/U1/4aKTauA16Bn5a1U2tKutXGbZNquq9aeGiimu+NCq0R53wHOQ6LdpkriFSmt1GGIgfdoQme9gwEbIsx43pNwEk5S8IxQIi2BBNMjqd2FDPGHRjycWEfeXxpijYv0IrO4XZnASzXRTd+OiMU4AdCZ7eVY7RLbb0UgKnWYdvaXVoI5Aet0Z9RChb99brSRt70izv3JcfC8JQ9utTiertZG/rkS+ESrm7caNVQeJurnch+TNHaFKU2kbOGOBqAO0oXlkDbJA8bGBuqBgBKOL9e2VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 02:08:44 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 02:08:44 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Bill Wendling <morbo@google.com>,
	sunliming <sunliming@kylinos.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/2] selftests/lib.mk: LLVM=1, CC=clang, and warnings
Date: Tue, 28 May 2024 19:08:40 -0700
Message-ID: <20240529020842.127275-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0067.prod.exchangelabs.com (2603:10b6:a03:94::44)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a1df4e-bfc3-4ac3-e12e-08dc7f84447e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GmtAzY/NjPD6Ys4ALYwolm6Ce7iBHocbQ/i2VdJW2KUQehqwdzK2u5rrC0bM?=
 =?us-ascii?Q?H3Hl9dhngYND0vS7c3cOL8G5MgRDdciy2lt1I5fJKjpjhnBxIvQjD1LbGkGA?=
 =?us-ascii?Q?I/A8KFFPEzpR8lPvkoBzHBn6FXQKdefVGFzYzhJs2GG/m5Vd96+0rgVDdWJd?=
 =?us-ascii?Q?80YD7fXo4GGlcxhaEbxlBi1H4DjtdbasYsvwwEJZCu63L0WxhCDg+NnjzK12?=
 =?us-ascii?Q?BPnHbrto0smiBx93yvI+LAb2T2zGPfGR7MbZssBIvqJq2m8BRBtTDryqZ+gO?=
 =?us-ascii?Q?ghsqWKhKnxI54aoeL0ToZTRwMZ0AAUd9X/klmZGlFiRAy0HuN+NZD2IyxXrv?=
 =?us-ascii?Q?jml92YyENWHWBK1QgLZsEwlCTHj7ZNCMX1f/u2pwLcHf68h9yXcs8K6Gg29Z?=
 =?us-ascii?Q?oIMzTUPDPx9IPX1WDDL0xYccN4PwQ2c6LnEwcOkZXCzMtN3CQqbIVsJgkKQI?=
 =?us-ascii?Q?Ud+B40TiL2i5dHrHVkptHb4Gkfep4I5PIBdiwMStc4SKPKQ4tJYFtsBMh7WD?=
 =?us-ascii?Q?dr6ccKmFojXFYVsRiGMzghZGYjoUOsHzjL0oNGwop2uc6YLc3A7ponC2wcyc?=
 =?us-ascii?Q?A2Fp1JzUGo3ObM4K1Ik2t2rAFdrfo07/GdZBb5ge07TO3CDTYuSZx7+IWNEK?=
 =?us-ascii?Q?SyXo+d8Lpye6JGuJzAXGsdnSQKydPE5xQ0uUhvcP6IVFEYgDC8N5tUdUi2Al?=
 =?us-ascii?Q?HrkM711s/LpvlYf48rlzI3sxkRYwcOjEYOBJr3hSYomXwWkERtGgNqlkNkN4?=
 =?us-ascii?Q?MrihaS7j/ZS/aIEpb5hJrLe7YOqy/F3SdvORLdMbixqWtXXk+1GhRmk6Ek5/?=
 =?us-ascii?Q?6mefXBYmI3WdxAwPKmRev9pCsPiRIrndcLnU/n9+jeoGo3OB0iLr3FXi2Jay?=
 =?us-ascii?Q?X5SWHx9hYISz0Fr8UbuV5/V0IDWKR0TJTCTongScwAgJGAakXZNh9PgFLYh/?=
 =?us-ascii?Q?0lve12LSWCDLrdDjkQzCaPz4sgM2CxOojlH5jJ/5x5ltNsFM4m3r1RdjzS0J?=
 =?us-ascii?Q?4n5ZkOTCWGIkLgV2gJbNR4df8yDP3XQXJDiR3590j2BFv6l1lI8NsVOz1UD/?=
 =?us-ascii?Q?VXxb0VfR2ogMlej7bRGv3/L9Z2+N8vyOAbEsaYVatx3r1Xw3BnsGUX0oiNcZ?=
 =?us-ascii?Q?tH0sB4hZMluhOwlb97pY6e0AT4pYmHbQKlwNWBSthA+Y76Srfn7ytVvP1t1B?=
 =?us-ascii?Q?2vmadwfkyRAirToGiZ1qqusGjF2Mjyt2ahTOR3lPG+TzGR1zgY7+xVASVV8t?=
 =?us-ascii?Q?p73qhegzbSZkkNE8rVxdQHMRCNbD4CjCMY8rwYCLZalsx1p52NC5za1VJCNr?=
 =?us-ascii?Q?EDs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n2fGiBXcM4CakuGVeStuiedePiBZTMOKyBvDlDnPvUerf4bYLHJCNlYsRHp8?=
 =?us-ascii?Q?TfNrYsMPfc8HdvSJt8EHETuJwZb9JavArz4E/C7L367uF7Phu6bboXSmQ9M6?=
 =?us-ascii?Q?h5HTBZBQrvu3O4MBJIxPmBQn6QwkKHq1qjih7FKQIbkvVcSa46Pq/+cWvSdJ?=
 =?us-ascii?Q?FzDvFyjDFl1xNnsGylD92Yd6PfWaXYeSKLbxE4sPdSSVanSTVMavLDlODpuD?=
 =?us-ascii?Q?sbfms26OBb4ODfiBSYJguw4vlENIS25NOSlDXK6ei3HqFbgPp6Cq6lwAZ/BW?=
 =?us-ascii?Q?7hy/9KfiQUQ4g+/H9rNz8TtIo/BTY+3ybwixyGydxUTwEbRQ+KWdyCEBVC6v?=
 =?us-ascii?Q?2gefWjtZhIjOr6TBmTWpYTI34wNC3oERP0GBKcFgqnXSiGziMbGxU50nOf4A?=
 =?us-ascii?Q?8M7skP1F9LvBmy+eCBXsKDBnuGBdKPSNSloFFna6L8bkPYAEmSQjrPG9DY2A?=
 =?us-ascii?Q?oxS+UJ5bEyhe9nOFhvZj4f5NIrouEJMY+pQLJc8T3xY+lN0vFvSLmlIY6p64?=
 =?us-ascii?Q?RMRn8H5RNWsM1CFTwKrceUzjqIckswg2H+q2bJACHm/9IWqnmt1j4U+3UXsE?=
 =?us-ascii?Q?0A84Gxvvi1ruIYlgwvK6qrW/nuba20vIbvkyGBwyG2FJxX+PUOMAuDG+FvPZ?=
 =?us-ascii?Q?mg1QCfgh9DOEcKlMcAQtdQeApqyd27flMZyrWfL6GN3/4yscoG/6M+ZhAWOL?=
 =?us-ascii?Q?CgMEn0J50jwdqsIeny5DeoPLgjW/ydEouUs4MzB9P42HbAZ2TKH8rvbfzYpj?=
 =?us-ascii?Q?YAm4Luz4XrMy2SKy3wYxYGKxxIw6mupdB4v70MalJncVWBeDkLGPt+o/1Sw0?=
 =?us-ascii?Q?48jaiXWOC3TuDEEIr7Qy2a38nSMU0eAP1XlX06TvDDnfzpm72kStMjXd5vfD?=
 =?us-ascii?Q?5hGJJqjZKB+YH/QHt5QkoPaMzzZWrypCpgKI4oqfIwbfm73nYKOQI6PwVXQY?=
 =?us-ascii?Q?VgpXGr22rxTcc+ad4A25e/DvEv2NsDFmzQkGGvmfF/tlWSSLAOWHOz1IdZt9?=
 =?us-ascii?Q?H8jlnvBCOSAO8lA/7j1tMQmSgmHLDUzQzXp/Aphw7P+wvMAASeaCVXyFyyJa?=
 =?us-ascii?Q?u5lWfhPuOo26kfDc1BXOLxyYJUu2gy/3YTD3aZLkhWd66qk2u0W2T7wjmuFp?=
 =?us-ascii?Q?AsA3N1O3VHKv+Y59mhHO6qD5c2eimUKqoJQlSm4TIN6W/r9jz+nYnie2Bv6y?=
 =?us-ascii?Q?s2pSjEmOEQM5v4/YGjQxVX9qMh8TKNNreGpBQlUK3nS/jAGCFPg4iZKrKBuB?=
 =?us-ascii?Q?4mFGPV2Q9mrXPrdfLuYjlrbOE1wyRbXdO4WuqjeBzZ/hNdtdFzZJCZILJJdY?=
 =?us-ascii?Q?zaU+dASXyaca0uGxNMTmsDMZTxoTgppAqqKWKme8SPWPJGeZIWtV0NbqahIt?=
 =?us-ascii?Q?IembJ8Yrrp7n0gDBQ29Ru2X1PlctgIJgL6QmRUZo3JNgcMbAE8MnFayP+0Wj?=
 =?us-ascii?Q?OkMvjAd0qmU1p/Q5D50fjMPkxKyKDkwjFfm4wJKQTg1ZM0VR9I8yHAeWasIn?=
 =?us-ascii?Q?69IVVlpuJrYKI8Sm8ZLr3NN9fELP0g5nKFtqdxGG6VskhcHoHmU03MyoTS2S?=
 =?us-ascii?Q?FfN8MUsnxMbqRQK2c8jIH8uWdSIbgLkxxpIrt4BM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a1df4e-bfc3-4ac3-e12e-08dc7f84447e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 02:08:44.2373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7+S2NxOUiywJp0Nc5IeX8tCO6iEsRiFkhhuJtFFsMbI4d+gpoQFjF0ajSlMDnlbEDxkbm/AfyvEz+lguQjrmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642

The kselftests may be built in a couple different ways:
    make LLVM=1
    make CC=clang

In order to handle both cases, set LLVM=1 if CC=clang. That way,the rest
of lib.mk, and any Makefiles that include lib.mk, can base decisions
solely on whether or not LLVM is set.

Then, build upon that to disable a pair of clang warnings that are
already silenced on gcc.

Doing it this way is much better than the piecemeal approach that I
started with in [1] and [2]. Thanks to Nathan Chancellor for the patch
reviews that led to this approach.

[1] https://lore.kernel.org/20240527214704.300444-1-jhubbard@nvidia.com
[2] https://lore.kernel.org/20240527213641.299458-1-jhubbard@nvidia.com

John Hubbard (2):
  selftests/lib.mk: handle both LLVM=1 and CC=clang builds
  selftests/lib.mk: silence some clang warnings that gcc already ignores

 tools/testing/selftests/lib.mk | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)


base-commit: e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc
-- 
2.45.1


