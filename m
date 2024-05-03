Return-Path: <linux-kselftest+bounces-9313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689228BA582
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 05:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 826C9B22B7C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025B62E419;
	Fri,  3 May 2024 03:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IHqPfYTI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42779282EE;
	Fri,  3 May 2024 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714705353; cv=fail; b=kH3o+k/PmN/tgmXSWaO2iS1aHe41FDYacsjyjjMprbxqHQNpsm5Q8pf7NvCKVmJAscHrnurvrS2iI+/v2CbIRiYL1EErhYp9Dj638U9txHiW0ODFWZTUIZPwlTWScN9xrJDJU9h2J7zgwr28N88NXhtwAase2o4SkoHcHj8MUIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714705353; c=relaxed/simple;
	bh=rLFfhCwPVhxx2LuBytfPCW793/w/Mv/erRVKAQJQpPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NUesfKIxSi48lY5YKqwSSwCv0vDvwHwBfPD+u/7axnKY9z/tDsZiNvckF0xibdbRcMAwNd0IrFydYxklv3UtYsfs1cvmdm4ypt0JqoHMhE7JcIbaYHvgFroutV+q/mjnyP5/w737e4/cMbbG+1uwP2sk0ewwxhiafBWAeothQIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IHqPfYTI; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lidb3oY0xIV4IE/FpQ+sQqMuBHeaD39sc6X8TRH2LkJrVPE6Sr6JAxsrrUH4y3ctQTBiIiHnUWn4xRYKRJ2HoyNPaDCTbUWENR5cny/JcAt5Y5AhJLev88p1bP8vgT6oot2R80F+q7qFEFOgTcTryTT9SkNW9A6+ldSce8Tx82dKjlNOFat3Aovi0xNDE/GqADc3nA7trSb/Z3g6n8MR5nq+AbXAydHlNxzzyDyXfTXkB9A4+lc9ISBs+T/aO/6aYi0SqN9SoY0yRd6UZybrtBTHjj3/1v+sC6nl7A0fqR7QmBA65tlq4ZdN30GChtSTPxOR6Xk1UqAeKHVlfDJi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpznGdURjPIsk2AHw2htrP17OZUQysIZLjGVN0Dv3vY=;
 b=cLlr4DFkmXquuFzdxsSmaLNYhFn3N4YaDtutdTu/W/3ewPgga677dSKEXEzqXZOdKTWHGsTLX95a2IFx1yEFQxr0AZ4fPlb28Y5LKThZAe6aUZJj5ktRGEz2Cd/cM0VMoUSV8Y5S6lwQ/EQwI5HipA0AE24QiKG9p9vQ9I+8YDfwPoomqdMfLMTerjkmvkvGAUIO0Dfv81hTdDu09j/IyvOzEr8yQO/OIkYZ39143ubJ8EXmt00k5boj8E54G12lagYpMo1pdRQ44NwytTEm/brYDL5tW6qEMr+eGqpBQrj9ruwHkYvM1LlPX2Vu89BxhkNVSgxFBTCzDMJtmDmJ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpznGdURjPIsk2AHw2htrP17OZUQysIZLjGVN0Dv3vY=;
 b=IHqPfYTIV9kuD+5xFCh/TnDwd/2tw/e6tTDYdbDF8Y4CNlsMsyUPepG2Rx8RNNTgycghGC+FNFbWtp1w9gXteHUIyS3hSUIf6My76hrn6oN4nlrbRHKMxVc+eG9m8rYNqs5BLox+1Nf4u1pliWrXNmGolH/arEsjvhzDAlbSwDehPUpPfUdmDQIfsLDQ918wyOA8aQjtyzb5moDi98/vsclbr8LUlRQ9l5PydCdbcQcWHZzJ3oBV7DmHN0xzlwLplVnTHthPHjM6t+X9qTmznrrgQ5j5IM3q1ffxPwOmvNQmEH+FNmAiGoZOMa4jSov9r9NyrjeseiC61Ohdfq+p3w==
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
Subject: [PATCH 3/7] selftests/x86: build fsgsbase_restore.c with clang
Date: Thu,  2 May 2024 20:02:10 -0700
Message-ID: <20240503030214.86681-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503030214.86681-1-jhubbard@nvidia.com>
References: <20240503030214.86681-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:a03:54::42) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: 345f2796-ac92-4d7b-fd37-08dc6b1d71af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qs1z3GOVdKQZcJVsuBSgfNmQOW3sz2k7euWZZyHo7he44NJdpwxAfCZnqQHE?=
 =?us-ascii?Q?shN2RhcyAuIWmyQM/Rsla0Et3W3ATuqRNhHMa2wnlUqNUvJfeyFDnPq543yj?=
 =?us-ascii?Q?UFw6+3F4b/Y30hE0RoJbtTuv7bIYhroEB2mWdqUGPBLb04gTsjI0TcDbiDUq?=
 =?us-ascii?Q?xb8AdvcoW+70KzpBq/lktQDp3WMe7x09pTIMI2FNYa+I1B1VGvGgo5eJw5FL?=
 =?us-ascii?Q?3dTnoLxwdli3WljIEHtKyzGbO0muNC9gjeabhRRCmkI0kK9yeuwki81YKHkQ?=
 =?us-ascii?Q?VTC3lczR/EX/l48LYZ6Fm5pZx3W7du1GkkQ1V5TRjFkVF8mHiBx9YhiQRtTw?=
 =?us-ascii?Q?az2F/XBzehDi1PKqiCVkaUAGW3dDneI8SNZbd6A1qF6TKKzyrYRlM/0cMTxg?=
 =?us-ascii?Q?gCTf3WwS/tpDz6dE/RHlrBdD7YNwrielgqje3YT2Nnsgjs4DF9p+IgbrZjVl?=
 =?us-ascii?Q?CUea4w0h+fW6GsM/5y0Q59lezYo16Au6a505HkfFqe2kPuqpRrmyhKzB/eMB?=
 =?us-ascii?Q?UjxDBVtEgqaVGJAE/8J4aFYuUmY5xBYZBtZlhOPNYMJe0E+nLVyl3vz6K7zj?=
 =?us-ascii?Q?HdI/TvOIci+anEmMq28bDeod3AvvEXvtXLinTYC7F5E2h6zqMo9PHsYK7TAz?=
 =?us-ascii?Q?hYVT3T8ddtpiY3X7V5isqc9q2aIgzlQ+qDI9ijoW9Cu7sVuZkJstvl4BO9GS?=
 =?us-ascii?Q?AYhExe/wyzMn4UwGgAMzOl6GFNDhL/f9/J7BvbTI5F/hPHac+R1BrXS485O+?=
 =?us-ascii?Q?9vp9gXGRaHj/Xkfj2zZfQlLtzD+vEOLUug59ATmr9ImhLm9dwzxgDUmIS6ju?=
 =?us-ascii?Q?clpgvCr/DWh+mezkDgiA7kmKvJS8YtC0Dy8o05S2K8FvrQP4G3qS7PetaHOl?=
 =?us-ascii?Q?+01000QVV40yX0bsF0JFI0dkWYIKKLHnVwZpJfQXh/73Ygncrt+/AqASR+mt?=
 =?us-ascii?Q?c8qcA/ut09Y4mL+mIiwdwN4BRW+1k/jdwApXn5rwvE9EHTteObJxRAxbTcSw?=
 =?us-ascii?Q?0Y3xGU4SwRWpFFM53DGOQZkH49bclBYyw13hIllId6so7ILrLrWloDFH0nkH?=
 =?us-ascii?Q?wTiCpHDTLBjOYS21OwlywNVBrQfDhe11n+ZkBukF2lfLN/uV2dWs6WN4Rvqf?=
 =?us-ascii?Q?Xzmdgs6d/pVpVw7w6M2L3nHOQIB6rZLL7zY7POq+em4z0NXL5KbFD+oIb6Mt?=
 =?us-ascii?Q?kxrNpXpbRq9mqkN4GSSBG5XFeZ6UOZozOoh00fr6MxvZPR6E5d3iNG0eq9wt?=
 =?us-ascii?Q?lxRxNP3AuVrbjJSu3PGW5vqa4r5gl2G1q+8gJ6NBhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UO0EcOmfJ/7TiDtfF51I4FQMzDLEVRyrq+gge+24urQhaNo1P4P4qzoMGXaQ?=
 =?us-ascii?Q?3x6b52zHbLvew6UbDfMpmaWcTdqOqAAgiElRpQUwYdnwZpmjjK6gul/3ke+y?=
 =?us-ascii?Q?ZmgsXw3UFTg6oFNeM8cAhmzlx+fP8OVvgXh9w1PHkPujEvecS94T0BjwIA5d?=
 =?us-ascii?Q?d4o3nFi2EjqpHzKXrsaCZbdJNk9t23vGtecsZqYgXwsODE0/59vS4d7Rogpb?=
 =?us-ascii?Q?aKW8BnhfeMOOtxxzHMOfgvqMo9ELinckk3raZKBbFJd4twWei0j3xBa+enQ7?=
 =?us-ascii?Q?ytncA9dIUm1Zt0AT3hyZnDV5Jv/AG9Gi1MnJnqPDRP5RyZaraldiMr1IWaRL?=
 =?us-ascii?Q?7vBy3gT+O+D2UH+FV5pvvfpaz/uDIIC5fOVujwrPj43VpC8sJu17BZqLsGAO?=
 =?us-ascii?Q?AHGgwlgBO0F8B5SDSTJrREVj+RWtoUeh7i27Gyeod9jj5MEV13US8Ea5/KTJ?=
 =?us-ascii?Q?0iEHYak97RdXXvK4ruGLv5B6CEAKT8EIwU9tdjRMf7bqJQp4GyRqMmo8PYvB?=
 =?us-ascii?Q?J1ZAH2IzIR2ntM/VCW/Eux7pHWFFnwQa8lGjB/zv6Jnndw/g7ex2r+4fBMdy?=
 =?us-ascii?Q?HH1tbrhCKMIuouyKUlrtWeCjgWOUnDsDMYG4+MMneP+jBTunMZYaTrhOvHvh?=
 =?us-ascii?Q?UhX0bdbGTwjj7sJZG/bf6OI9rxAq9y0DWQzxTh+JX85LehkOSky/XgykB9DY?=
 =?us-ascii?Q?mP1BrnuvlSZKoEHvtE0WpRMY5pRZLZnbtOy8d7bBKE0NXClExeXrWYsE7SoI?=
 =?us-ascii?Q?WnJuq1noACQB5unm6faWWyH5lIEfAiAP537HNV+6G2OuzwtxkAXCFI/hJEKd?=
 =?us-ascii?Q?VeN3oKGkSERxcCwsapC6EVb0oo6GV0paVhFHnGNiyRlRwMPFQd2tAVozYfOq?=
 =?us-ascii?Q?DzQQ3oNiovKnqOHvaNrBvCqpo6XE5DGogDcvZy7A4uDjgcCLQxwS+wTNN22X?=
 =?us-ascii?Q?9XpuHpEs/tAmWH8vqtTIZmBoDJMsFTr/fY2b61YE9cCa6cOH0iQIu8VssYMH?=
 =?us-ascii?Q?s5j9Dsm2GtqDL0tgV3HDLIrwbNRsZzMy9GTmlk6MUMHp4Q+OfIjoJkHY+uzU?=
 =?us-ascii?Q?vIUokvU/eaxk22k6LSPw9oj04/szaA12Cgo4Pktzqenib8RsAlUJN85ICUmR?=
 =?us-ascii?Q?Rqsq6dJ1PWHGFlnmWEonPQMe5ANA1DlsrLNJcLYhD8+znlCXrO5wTpdi60x4?=
 =?us-ascii?Q?Ap8NsXsXGTyp4G7jI6YPxCEslR+bF9cLYFhu/xqAJL8RbFFKFkc11Bl4BxiP?=
 =?us-ascii?Q?o6S3XqHGn8AeB5WuGYeSTuhgnBunL/KYvonYAj2VzW/mO37//xjhJs+AE8I1?=
 =?us-ascii?Q?c7dMgiG9q1Wh3TfO4JjxtNX2JwlMn+Id81hkzsO2NgRDDbG3xdAx+V3yCmZ3?=
 =?us-ascii?Q?d1g+fW+Qsg3ztupoS7UJSPrOA/g8T3hBY5RoMEe8vFVgSyPpiWMxPOkCNPyj?=
 =?us-ascii?Q?c0YJegHyoK85yFTUWMGDBBNkm6BtFo6lC6Iv4lQVSrQoMngy/xYM9at8kr2W?=
 =?us-ascii?Q?cDAMG9Ut6rf6NFVn+34XxcQvSjRfHTAw1Kfaa7mZu+iOUfnKfUZvNik/6Bc8?=
 =?us-ascii?Q?NYyOqlr8WfIWwWnJm395G5EXlLfdo3JqkbHHCN99?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345f2796-ac92-4d7b-fd37-08dc6b1d71af
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 03:02:18.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YniczqJo/bjeESEoPJYXkG6QhQ1aNY2PWrOeuvBROU5QVlczBNnsKlzQAjdcf9Zf0jYThfFO2th8FqvbpzA4DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

Fix this by moving the inline asm to "pure" assembly, in two new files:
clang_helpers_32.S, clang_helpers_64.S.

As a bonus, the pure asm avoids the need for ifdefs, and is now very
simple and easy on the eyes.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

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
2.45.0


