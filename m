Return-Path: <linux-kselftest+bounces-10810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C8D8D2AA1
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 04:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD90F1F23781
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 02:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F91D15ADB8;
	Wed, 29 May 2024 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RFSRBEfh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D424515AD9A;
	Wed, 29 May 2024 02:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716948532; cv=fail; b=FY5cmLzHQ0dN6NefMB72eYLDU9gt9eZsC9njGFvyXkiTSQFLMh2XoDZZMFOjAbGycyrgYJ8dESJN8yiAlSBHDAAxc89uVLplgZpJwR4XOyk17duycD1sEy/wvPj+Su04MnMDxoyz9HHhLZt5DfJkXhT2Nbr1Gbiqe1DxNPmlzbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716948532; c=relaxed/simple;
	bh=moeVUqSHo2UKVYGHJhvkLChv9In2GZ4ucc2wxNeMM2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MVK9/NdAuQ9ebGm6t64p6osOJFOgCSh876g3NTnDpcwA+lMVTRYl19vjNyhEQx9XDVDpSqQ0cgJY2RiHtMDxVpiP7/4Xubuq0Gzc/Pteho7EK6fButXA9YeSj3QgtSsr7G1esdCElNI9m51MHalVXCcnEWZCgT4C/4UfnhMIOK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RFSRBEfh; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXOGdjTAM1gDWuiBkXK/EMfcqXAli81HxxF+pt+mUSvebZNz43T1HN7fTk1g2+f25U47DmAA8vibyssghGrrD6W46H4ZS/Am+xFUuva+ZSuEwflpqlNGqk2/vCGF30WVYjPEhllQiUPbvKL5dQP6vy5OC4gGc5QTfthMLwidOabda+auHYwwzppdMIjAKNH+qb3nSHDqrkvKleTmSBicCU64QEQcu21Bq1iiwj2zKN7JvAYq3QfxvT2UluuVQygvVz2HEfnTxJnTgUI4/MdDdcUiruZN0R4lIpaGxNoOs0imNByfd7+xprZlW4aZ9HyE+sJbVfMK+a1idMJV/ktNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8mLsY97dn+gG43ev4hFjruZ1Izz2zefk/N5jtvvWAQ=;
 b=DdOZyrqsA9yB/+yTtanQ5gl7f0q6S7eNGVU+jJkiiyF95JnGJm5bxMQPQ1ETDO4DWNN33ul0InAAVg61yhXomO8l0ew1tDgLQSHCqEltdNSGxWV1HGJmqWfpqn8xi3asTZpAla564eOULwPUe3piUoVzM1zR0f6U1vq1MqQbsO8T7Co8nHtaD1LeQjqk0GSfFt+fL0WqfS0br+5P+mvOKbN5E5T8p3B8KIBS84vp0HixxBEh0GL2uJjxAtIPFOASHq15VTQzgv3e5RTBQeL2PXnZh7PdFa/kRXUMwMrBKfrk2sT96Dw+Z4WpPc7vC2E8oZv4HzGByZOv8Toignr75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8mLsY97dn+gG43ev4hFjruZ1Izz2zefk/N5jtvvWAQ=;
 b=RFSRBEfhshOfVyrpSd8YkrdNOu8GKUbo0WJRPoODb8MDCinpHGpiAHX+VTTsWukB+Cqa0yI407w52V0mTs86wnOqgDTQtnmY7Ir18vH1qyCudkuqqje00mlFuxraBqJOiuq6J6T6+Yj+g2JbjwDmHSVfmrTUgJL7U6lK3dhsqxTLmyAUlHlOpeJ1cXtvQYKFw6/sIi3u6sSoBTwD2QZVYNPzqdfRsZ6QypaDYzyaJ+UNgdViMi3/E190h/JEUoORuwn3n9dKtMTpFgZdLsNAbEz50lm2dyRLofBce9no7hObWZu5MX3ZPb2/78HdcpWNRXtKCpZXuN69P4cvFpj67g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 02:08:45 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 02:08:45 +0000
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
	John Hubbard <jhubbard@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH 1/2] selftests/lib.mk: handle both LLVM=1 and CC=clang builds
Date: Tue, 28 May 2024 19:08:41 -0700
Message-ID: <20240529020842.127275-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529020842.127275-1-jhubbard@nvidia.com>
References: <20240529020842.127275-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0071.namprd17.prod.outlook.com
 (2603:10b6:a03:167::48) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: af3891b6-0c8e-48eb-e09d-08dc7f84451a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9KF2d8mlvRTSdnq18h+I3e/NMS9JvTxMHYyroAxG++QAOLefXvjC9jI2kINn?=
 =?us-ascii?Q?O4ILLlJVieymhbE97+EONVB4Gu9wZJF4+5iJHmL7Wzha0q6I4zgAzHD+NPZM?=
 =?us-ascii?Q?RpIz8BP0/xkxHk7akGYrAJAZulaXcWSSnSE5vxB9pozNEWasM4GFnP9QafE7?=
 =?us-ascii?Q?yk/NAvn+7KuZldZld4ClFoETm05tT8dmXkQjrdJE/Y68YADkKgNLZ52+OSQB?=
 =?us-ascii?Q?ntWGUtexYhZkjhYhZtqudkAdWILkvYo1yDVsSIXJxYrWQeblA+rfH1jLi4Qx?=
 =?us-ascii?Q?BboPSxbzKIZssY3hHUI25SD+UMkTUne7+c6QOTLd48nOhy7FBvILmsM5xfja?=
 =?us-ascii?Q?351XbAzhZNp091e3qhyQcXudYjPVvIneqRcryhgJhLrlt792FQCd9gK8J8Sy?=
 =?us-ascii?Q?0QL+mLs28KZea8JXO8jFwV3zFK6LhVBLyZmVBFOYdIDyPQgiWBKwhtm4qr+C?=
 =?us-ascii?Q?cxBNRiZ765ENnRhhcmrcuw9Rbq8KEF791trlb3a5OIRRwpeiJXOwNxGwGbZH?=
 =?us-ascii?Q?l5uhtdbfymX6nKYm7lMzzENtHiHdDBonuVJ8o+hLCXV8ZAnQTGRJFjxiQLIF?=
 =?us-ascii?Q?TGf7357Eixp/riapDhj+sLcWdbPL3q94pP5g4KrA6VlsLQTtabiuxsBwA/gl?=
 =?us-ascii?Q?e1TeLUP6BkOSv6frj0NFGOpWCEXWfYVpooLwssUByx68giA30P//p6U6Wyxx?=
 =?us-ascii?Q?Ufzb/1uziSaBMV0YsazBDhRuEQLni3FIoqCVKhw1C6FEDjsipaULEt445GYV?=
 =?us-ascii?Q?Tgo/O1Aq5yWP5dljUU1YWAr1F9R0nT2XLtcQ59qU3+2Web2twvkt9mliMdYK?=
 =?us-ascii?Q?00TvlG2PY5wauqiOJ99sh+noxktwWcLv0GtxtSLEEEDI4y2S6cEThhIhA55G?=
 =?us-ascii?Q?OVxn8rgxRrdMOBtCAHV6xfPAmzb9xH8srmlHv8H1mZkaYAfSFjZ4KQ910JGh?=
 =?us-ascii?Q?sRhK6vEJ2lj09UKGMSk1WpDBC8XlDDAaVLLBw75fIayr3CoPL3MUxXLcb8a2?=
 =?us-ascii?Q?0+Zzi4ewi0iBNoQwepq7g5o8Kyg2JftMDu/1Ge8IstKgUsrPuLvH6kw48Efm?=
 =?us-ascii?Q?FXHPoBgsEIm6cayog/xPYdP+X/0Bh6Jg8dXflVNWHh6oRnYgUbGQlYJmqWgk?=
 =?us-ascii?Q?nXqaxfDAw1xX70XJu9WdN+uZyeWs/K26+W+FvuK93IQoSYuiwPkEdJgXHH6/?=
 =?us-ascii?Q?ZRr7qw85E2ASBmF6DMx4UwL/ocFKw1LpE67hdCdtGkxU/AI5N9643Nzw+Bcn?=
 =?us-ascii?Q?5zWea6DHcs4sE4N/UxUNBc+QPAxX1eX337DjuM5o0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oOeVjPg7ktG+jPNOkfGto1n6wpg/ZxSnsyjUfXBS7oDEM4biPT25zFvU+eRV?=
 =?us-ascii?Q?txX/Fu3uRyIKt+V44ukhdRKyj9Hv+TANZmVRGfph/eYla8OY25sOcaMHJcH5?=
 =?us-ascii?Q?Thimh4jyyQ3HGL8Jpb6fsN2tI0mMFnLBhSS3u93WrI0XQAoJ7aXfs9w+WD4Z?=
 =?us-ascii?Q?Yof/YnZ5uNOAmGOtUcRwelC/oMlw/D/WEBn0mLkEqd3qKWFqLnA7RktuZdr4?=
 =?us-ascii?Q?Kd9W7dZgceQ0aK4yUK0ilPZ1uwo7KltTQNfHO6y8tTR89JE8jyuTgUUld4NK?=
 =?us-ascii?Q?QLTgJkisY/9R/cRNgGJXilaCYOTwOogKG+gKs21SP8lkDMN4Fv1Vstyl3yij?=
 =?us-ascii?Q?PD6k5E5VCH7CLC9Rl26zc5Th7yd1tzLhxWydMNDptkfu/gEK8WO29qasHFA7?=
 =?us-ascii?Q?bCrIc7USxFq1EPCwACFqhIsySeN3Qr25u0dKPr4vbp93A0yaNoVVIfv5a8SS?=
 =?us-ascii?Q?Qh2OuJsKJMlEW4aCII+7hDOB/NQBOZQj/0Fi5UdbeOweCNo4E3mjNSGsQUx9?=
 =?us-ascii?Q?1V3ZxIF4b3Klui/tkyxXt6JWBWFhikqE6dO0S0v9N0IlSjX7x9PBHtk3u81v?=
 =?us-ascii?Q?kogeXZevb7sZysXab/scwcdlQglfQ5CpLsJ7q2IIThK5vvQ54nnvJIMEzNvn?=
 =?us-ascii?Q?HQT3rjK8QqgyHyFzcheBxJu+dI011N8l58oCvzWO0d5GzkFYi8Fs5M7q+ldS?=
 =?us-ascii?Q?YpWvSfx5HqcDLWa8N7LWiw+xeFzSfvXLFY61kKAQaPW6D/PYecyqiQCRWQEy?=
 =?us-ascii?Q?5FbfjZ75Kz6rLnwfcyKlv/prJe1L6xrw/Nqhq2A2a7OywuKtQUOFP2msM6k/?=
 =?us-ascii?Q?/plMkGthIksSfmgS87ELDp2yCWRW63UEIcMkzKqdRgKCYfnaUhX+RFlj5SLT?=
 =?us-ascii?Q?KZdpxapH6Zxd3yQWUFQVY6qqMs8VTUU/gm9Zuhoh8W4D6XnUwPAZtydoULaw?=
 =?us-ascii?Q?4nBpOYSgmcjs5YgtYmrVDaWuGwgHlK0+4C5YCgDi1A85v34vB5l9OQT2G2XT?=
 =?us-ascii?Q?34znky1cK8mUx4Cx5xkj6BKdSIEOyQb7bJvUHNnHP9pa9pvaAsC/MKJ55bzg?=
 =?us-ascii?Q?3GKvitmbH6+TKqqI4CuQZn29Jq9KtazrpZTPX82N0JGMIAWJ5PmJdciZXZZJ?=
 =?us-ascii?Q?UYFc2IquMcwDCDgAOJCZtuARje6eAknK38oKkWLB8NOpAScY/imOiG6g5uTt?=
 =?us-ascii?Q?0Sp9qLE9B9bJtQpsIHfYr06MlRnHnmLZIOgpxMd00/ERHkHdKaNZgHQSMBqF?=
 =?us-ascii?Q?PnzwfJdzFg6VWBwS2p56lLKv6JpEq/DJtraWGPVOgUiJ3W1NDBNZYy4DCvPP?=
 =?us-ascii?Q?Ms2PX2cBMum13KNIUCdsOcPO8D3tqrJw7FybiXNP7dSzjN0fjdczCO2VGlOh?=
 =?us-ascii?Q?rf9qa9iyE7/sDa9fv+Jg6IUm6tftojdOaAc35xrXVKPbBy9/3h0fMeZVsoWw?=
 =?us-ascii?Q?sncboRlPz6gMchd33pOeDSaHRVfpRkg8rGKRXht6OvzAzNFh1cKO9O3GadqL?=
 =?us-ascii?Q?ITRGXxsjP6H89FAipv/K65lIDVkkGTw5FbJ2B8ZmkrxZJF8vFlsLHu4sDrTr?=
 =?us-ascii?Q?ciQIFnrAMg9gsS528N2DfEPT0b24szEzr36uiKyH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3891b6-0c8e-48eb-e09d-08dc7f84451a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 02:08:45.2266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnS853BtOLi3CMvQRrLUiWMouitXvxL7yh1qbRb/NbPVs03M5I6j7LIBg4vinVE+1xMkrtrepoLkTq0CYSLPZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642

The kselftests may be built in a couple different ways:
    make LLVM=1
    make CC=clang

In order to handle both cases, set LLVM=1 if CC=clang. That way,the rest
of lib.mk, and any Makefiles that include lib.mk, can base decisions
solely on whether or not LLVM is set.

Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/lib.mk | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 429535816dbd..2902787b89b2 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -1,5 +1,17 @@
 # This mimics the top-level Makefile. We do it explicitly here so that this
 # Makefile can operate with or without the kbuild infrastructure.
+
+# The kselftests may be built in a couple different ways:
+#     make LLVM=1
+#     make CC=clang
+#
+# In order to handle both cases, set LLVM=1 if CC=clang. That way,the rest of
+# lib.mk, and any Makefiles that include lib.mk, can base decisions solely on
+# whether or not LLVM is set.
+ifeq ($(CC),clang)
+    LLVM := 1
+endif
+
 ifneq ($(LLVM),)
 ifneq ($(filter %/,$(LLVM)),)
 LLVM_PREFIX := $(LLVM)
-- 
2.45.1


