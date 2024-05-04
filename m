Return-Path: <linux-kselftest+bounces-9453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A20E8BB97D
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 06:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FC1EB22D3D
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 04:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75176107A6;
	Sat,  4 May 2024 04:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bXeHdCjE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445D4689;
	Sat,  4 May 2024 04:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714797831; cv=fail; b=IhtJyAUJ5S0BwSShey33yyGdzf0h5S0ceSEBsRs0tKDCUn+bHLMro+GTrSx1N1PEQJH9NVDjDuy75rMYKLOiInv0YkH37oRa66aoPEcKwStdO7N6gq1JZihrSCbGKPlxN7FVgtCTouILGKv8q00yAmcopfRQvIPREtkI6FWPpr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714797831; c=relaxed/simple;
	bh=n/Ajp/0hjQqBBCMxBAfGACJin6cjhP/AyWeVR3mM0iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TjW9oIm+2oKd4ZSgow25eyImxwFE4NlWZLpeMk+FIzSG24G7pFHl5GCQoX2UHmIbxnOWhZvVz5BgtbG8Myg/QpGiiiLp4wuTcq1bUGsDMaQC6sLnJyYKGpUVGKJBtgv/US00b5Whyy3HfBp4yA0Zd57Ysh2gp9DLfZI/dXwgbjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bXeHdCjE; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB/eBRgMYdo3N6QOgnLHXTZxtp7JGnTPa1FCdp/I8oFQM4rrgkqQ/V8aQz9BiuzcwXTSQD8LzDS3CIEznZRm9299b5Dg0xFZmxzwm3vzTch5p717UJgofKlz3fszb87NditkSlVEUDCRHAoobOtVaz0M34RmLllqwIEL/BYWVREKDjG+06IBYzu7KmS5zNiybXPoms/2jOd6A/mcS1vM0YP2LkO3WFc9LL17S7RRyMv5r5kTgT/u8Q7J2oRppwSh6wxpi2J4iphUcQ7OWjjpcs1aFzMRetwBYMLej56S0rMoH3jrBPkvyELv9L0jL3ODiS7nYczFi8TVLpWbACAGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6LDn73ldiE+0JGGZAa2eVXiYtx60RVOPrO7dE22V+c=;
 b=KPCwgZQxrpqIkR1y+v5vzFC1WLzKlGkNidh0FidRV4FDHgYgt1s+2UrSxkUt6B+WU86j8s0XuVdRip2GkBcm/1GVw0unPeyv9juvVQm4p7YYvLBPhFGNbQfBAMUiqGcE2pr3IgfpfEoMyGKSo9RL+9BO1Foy7Tms94yZAm0teZwoTD8+FnF7YY6lMJAxtbNardknsIsd2+1nzuujCAuzG5dnxUzySAR4WZIxlNVgg8PrT6uAEQdr7IdOjx53uXsIAw5DUrOYJIltZ//M37wSIXYaS4xi3Dfaz2wHV4ihnMd5dkCeTpjDO+6h6s92jXPiyY4j/83dOLPSIzkljersYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6LDn73ldiE+0JGGZAa2eVXiYtx60RVOPrO7dE22V+c=;
 b=bXeHdCjEzQEND57J+sre36KAEcGn6pyzDpETBIZbMAtuX3LOm4VrvUdKn++KlDehkG6Y3sV/5gN9GOq/DWe2cOHsVLUXr9BKIQSCrDs8uiMavAyLlIXodC0tTQar/IUehmhu9JWqR9E29rKFym3Jq2ZGz1UTE2jGrS+fjmhHqsIMM7H9GKX5mRJ+IUleQ1iW5Da2zLFSRPd3k3l7hqtHiODJUvrF8giHQpe2OtevTTUAjd9CDdB4qpLJ8tDebrb/aFxAYmSwb0ma7pE0P16dOHtZPM9sWBRAV7e+kVm4AMn5v7nlB0PPKXTHODOVA6wYewqfO6grnsUe4ZoVQXINeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Sat, 4 May
 2024 04:43:43 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 04:43:43 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Alexey Gladkov <legion@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/2] selftests/fchmodat2: fix clang build failure due to -static-libasan
Date: Fri,  3 May 2024 21:43:36 -0700
Message-ID: <20240504044336.14411-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240504044336.14411-1-jhubbard@nvidia.com>
References: <20240504044336.14411-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: d37e3e15-e43b-4cde-d60f-08dc6bf4c694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G/K0b2M45P+cWHoY2Rbvk84gOduP30h2ypGNR9obHQfOGERNBoqsd306+cRd?=
 =?us-ascii?Q?JQMRJwdLur0PBc3kWSbkWEwRws/6Fs+cYtV20Q9RY+qfMb+cXwtRjoFAJdY6?=
 =?us-ascii?Q?mXyR3Wi4uq/WpNiKpz55ean/wNlPT526iyecnEFmw4DYCzqT+vuJ1ikrwUUR?=
 =?us-ascii?Q?WbEkshjyuWhzdYZSNaPQg1kcbHDa0ffUhhaw1YDazsh7xJFUfWruVMGpCP0B?=
 =?us-ascii?Q?IpxoPUqzYt9BLaSbzHK8IPgopAIunbHB1uEYMDdZxEItFnCHy5sZ5Z9Cd5hp?=
 =?us-ascii?Q?vkg/oyiCAcRT0NKR/vgFCnx69OS8r0wu6pRbL+ehs6AzqOWWcasWk8nkg5wY?=
 =?us-ascii?Q?cNLBxxup+3bNvCI+La8mNlWTpa/dQLWwdpWOQs+XBcViY80Lyj1N7T5aXbkJ?=
 =?us-ascii?Q?69bofF1ua5qbCJEp7Y7dQjUuDneSJ40vfDPFN1IdCGvkvryDa7OLc4qfjJpr?=
 =?us-ascii?Q?HtthmSQmwbsiLeghw5MB8CQ1K+dk89aOjmHlexoM0ID3h3dELKtWDRrdPKSi?=
 =?us-ascii?Q?Ow07pRPGLuArDGHg4yib1BOQhJzZL0GsPtpleMe2ZW6UuNib7eQikiTqBKP7?=
 =?us-ascii?Q?xdRz5R0pvVIxnOslN+hnCQQC0wn6N0GHSmKbPHh3eSNF8hSCc5z4pwJn4Sj7?=
 =?us-ascii?Q?ms/PwkGWWM96WasXimOF7fkp/ku03bvM/mIfkDf91LI/iAUg+YQi8wtFeuG7?=
 =?us-ascii?Q?y5O+kAxKDp0J5wPJjdC/NG6vwnrOg66PgLhTN+6dWWjzuS3ndJjY2nc8M6Xz?=
 =?us-ascii?Q?OsosjHDQCSYJ/lUWZqLfvZt5iJEumutIRNqcUAZ8TCsTN0sOJqqhhCN3geNy?=
 =?us-ascii?Q?CqW5VQ1NOegUs+0G4+9HQYLOnB57aEWuio+BDi9nz4rdFcLweN5if+BXAi0v?=
 =?us-ascii?Q?P3ocd7dsT1Vwmz4SXRlnCSlCu2iPqW+ZR84u0RPTPIZy4WT6f/Fha7t2J/vD?=
 =?us-ascii?Q?WKisM1t2DlwHFssPTAj+SN2qToLikJrEaHLvlnRqQ4fny4sWvysKAjyJdWo/?=
 =?us-ascii?Q?4dfaroVXVsTWX/SFA2V94GayTI+EXqmdbNv9n3nMq1smBVrV1uhpwr+umiIs?=
 =?us-ascii?Q?Y6CM/VmbrYAgDH4tgMNyzyzheq6/TQ320zLjYDjugzxZ98FyncGGWOToycTy?=
 =?us-ascii?Q?kIhq32cU1Xfgkht0xcSrYYP0TGz2lWPGIx9+xeStLbFzNt6iPbc3XqZq2fHd?=
 =?us-ascii?Q?M+3iGUngSc6/FzQhJabQJq3/xiub1sfzn8cMVmEkGtjMV5uCcGKhieGelUBh?=
 =?us-ascii?Q?PUPxQVOXKdG2IhWAXKGJ5YylUs1f3I+ruf9sTp49eg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FZ5LBJMztS/m9wBDuEPzOsPTLoyS8whH+pqSa9B8V7nd/U35HVw/zVy+omlk?=
 =?us-ascii?Q?CtV5ak5+TsKMOANhj5u0oafq94xYJGV0OlKFqTtvSa3YKFipDsFtpA9kXPmg?=
 =?us-ascii?Q?mj+778JMGhIQ5saIIbpkPL8pRI9lgZast0R92qB8DAskyUUSA6QFesHHOkoN?=
 =?us-ascii?Q?ermmH+PIPB15zLqhnUVpip4QUM8O20MeQheqr8Wry5R7YS1VMnNiVJY3bYW9?=
 =?us-ascii?Q?A/BNGUtHrheMFL8b6RgF9kaIyyBtYhq1mHs6yuT9mV/RA2LOPrhKTIddgcmg?=
 =?us-ascii?Q?K2jvgmxmrkVhy1afHkLB7B+AOnHsYbTE4TWJfSNmX3zbQWfdHVqVSC5GQ/uo?=
 =?us-ascii?Q?l4G7ACiFmww6gPMlOoNEF653wr0xYXiiQARbfs4s9Ne18k/inwpizB92Laes?=
 =?us-ascii?Q?DrIedpv3qUxH/VK10mb8aM8gCbcW6vbPuGunNQjM90xErxPDUprtM4h6UD/4?=
 =?us-ascii?Q?EMDd4k8aZaNTsC/Yl/5xgB2R5DG01behZnAc+ew1KiKiG3rl1ZhLcgNOhcZn?=
 =?us-ascii?Q?1d8bnEA/X/TSH13jlCU4K8vipFTp3Ms/1+nFl9grCSuT23OEBsJ4e8LN1zVI?=
 =?us-ascii?Q?o+uZCNkjmDxN/8EpLwAwqlgFjSE8y7ng0qf4K8V0Iy9Kzmp+Um3ZxV0UtUvx?=
 =?us-ascii?Q?bQL8kUorWXxMgZAC5fBtrc3pAr9Y29MTBUhA3jSjUZ4RnUNTHKg9EvOc5ais?=
 =?us-ascii?Q?YpKcfFOXPDSd3lpwksEiU9wos5tZUaDUOOnyyTp22OBWxGDZYHnB8hijczYs?=
 =?us-ascii?Q?Ycki10VcWrrrawSK2HwyZZDVpU8wV8uYQsfcpv7ugqquJm+yVoSnaswqLWQG?=
 =?us-ascii?Q?jD0od+EkCaWiGsYyBt2EiGO/M5eF8uoUh1dRKwFp6okSSTPE2VMr3Mt/EGxS?=
 =?us-ascii?Q?A/6bjSH8hzR0rb+i5hwOc2pZb1KpRSQ3D1i4hZBElxKHN0HRbNQrG0Seh5v1?=
 =?us-ascii?Q?UKMMY8G3H7DQp0wMzDEMx+vHyP3wJOhzNG3OwtjWhE0LziQUU5km+ANTOQ//?=
 =?us-ascii?Q?C9RU8JW8nDKOlMTKREZSRRWsLrxLxx27Ov+n8ce5iFVFT9UTXV/2nPq2ePJm?=
 =?us-ascii?Q?C7yKm9bugQN2u5dllSlqap1XYAHROD3BFlJe1lEl5uMy5ajGAb91HpwT9VK5?=
 =?us-ascii?Q?NG+dZ6SJnlj/Dg2jeZ/GP4GCrjX07T4SuIFnt4TsOjlH3LEVFIMiri9UB9un?=
 =?us-ascii?Q?6gy7FLew2qniRfwZiUFthVG1Ki7fr01p0indaNLi+83h3H8xnj58tACi22fh?=
 =?us-ascii?Q?vhgZ614pTixlk4Qy6ejd35Q/FJmAEkJ6z79rbBqR1TgOX6nxVl2GNKDBnIhc?=
 =?us-ascii?Q?ls39EBAKkM4Wrf93F8kxRZ1PXV4dOf4QEt/MAxIEleBj1lE5svIJm54z2FSd?=
 =?us-ascii?Q?WQfSFp+HYMepJVZojPbMP/6T/iQfSztEt0sRaEJ2F3VmBClLwXw+cwlZsDlL?=
 =?us-ascii?Q?6psAnB6l2giwVlRl7hu+BQb/jfO5R939NtqxkUY9kool/qbwlNTn33MPqiEH?=
 =?us-ascii?Q?EtxDa8hpJfIjlHOsH/+7VCoV4eb/lV/K4bJbPRjoPpoRoRiQdCLDRHPy7KH6?=
 =?us-ascii?Q?PhQ3uAqTpBvNA90xOtDfUsf6KNev8eu0q5z1p4H2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37e3e15-e43b-4cde-d60f-08dc6bf4c694
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 04:43:42.8512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpFuGi1ghOS0c9rE/2E7wX6NkZQkpx/ViWpl+3JsNLDDzf/QUhWVQ/AOw9pmH1dVS0SBnZJ73ol9PZ6AxoZnDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174

gcc requires -static-libasan in order to ensure that Address Sanitizer's
library is the first one loaded. However, this leads to build failures
on clang, when building via:

    make LLVM=1 -C tools/testing/selftests

However, clang already does the right thing by default: it statically
links the Address Sanitizer if -fsanitize is specified. Therefore,
simply omit -static-libasan for clang builds. And leave behind a
comment, because the whole reason for static linking might not be
obvious.

Cc: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/fchmodat2/Makefile | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/fchmodat2/Makefile b/tools/testing/selftests/fchmodat2/Makefile
index 71ec34bf1501..4373cea79b79 100644
--- a/tools/testing/selftests/fchmodat2/Makefile
+++ b/tools/testing/selftests/fchmodat2/Makefile
@@ -1,6 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan $(KHDR_INCLUDES)
+CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined $(KHDR_INCLUDES)
+
+# gcc requires -static-libasan in order to ensure that Address Sanitizer's
+# library is the first one loaded. However, clang already statically links the
+# Address Sanitizer if -fsanitize is specified. Therefore, simply omit
+# -static-libasan for clang builds.
+ifeq ($(LLVM),)
+    CFLAGS += -static-libasan
+endif
+
 TEST_GEN_PROGS := fchmodat2_test
 
 include ../lib.mk
-- 
2.45.0


