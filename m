Return-Path: <linux-kselftest+bounces-11985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 818F29094C6
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 01:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F821F21AA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 23:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5488618754D;
	Fri, 14 Jun 2024 23:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rlB/H1Np"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA917FAA4;
	Fri, 14 Jun 2024 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718407875; cv=fail; b=pafsqa59sHNjRZDy76NrF3ljSmJnz4WeP3NInQ+uswa4cKi10qlQcn65dApIa2JsghqRi98/YTHwlEnSrB+nMBRMbQN0Zaggxc2frsF5t44W5j7YeBuStxY1hfvgMhlmesBBXlsKZs7AF+wp/N4WMGip9iPtOazXtAomV3MAHKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718407875; c=relaxed/simple;
	bh=xz+IbFEVQi1i2+B3MIak2OoiRYbFH6kWotXqPDhvOEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QOfPyh3Lkx6RwgSSdU5px9InqqwGoq4+7feP54eA7h9s9iF+JkE92i8vkO+Vgm4gSBIVkV5lRF+VjR9Ef/lPHzLTsirUCByU9rwTUczmq9Y3fkuN2jY3nUI0Cmr38O8FZ30XcWdMxrQDgpa3VL1+XRdUz5RzcxidIexuYpt44io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rlB/H1Np; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyK/bplJVgzsKX24krHQ3aQc5cfNcAECs5gtlVt1EHasUZlC8YBJtfeIun6x0jnnjwKUurtPo0AYS/YauWamsItCDflks0BRwwqfr/ynE3NzUQPwNNcSHFjLQMGJ54yCSh8bexXNcQU9tcOXPgpvQ7V+5/o0/5VUItkrTL9VfWuRJqJoUoSp4C1+LB3hpnWI5G85nNhzEQJXxAojdZlpywdX4AuPSLiaXBfxcTm0vUScxz/6l4M38NUB8MIBlMnVs79WH8/Dl06C57/GXENui00eAuitQPQ4xTnVqHAlWKBmbxkC1hDqAta8cXD4is3ZcvarY5U100Vx29h5lGwAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4L7Mdw7LkQKm8VHtcpcip7zoUkVQc9BeISjiGBJ6DUM=;
 b=m0Ftwto9lxNLiK3b1GrwQEhcttjuG1bM6kcpubavoGffk3sI7j8uDqqWkikhXidEgWtuyYSqkytSCfzfHCY0DU8YpteTVCHG7yClnj/rz5MwPq3TQRltzY1GmgZfO8i2Ns9/1VwObxwtd8vsmznrzHSnM0Oe3lDoJY4Cz2+QwKj4//clh8HXMidLOBooVzECwBIXuiALUYZ57omfnFppGMhV2dyN42OPTsHirYV/MtmJyurUrafFL+FoAzWLcvdFQ1s8jRHVZ/6qQQ7vYQfhwEIRE/qqNMGQBAV6MXIJgcYw99P2NjlD9bHKW0uKW9rGc+ShVXysyHzxk7bxtmkpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4L7Mdw7LkQKm8VHtcpcip7zoUkVQc9BeISjiGBJ6DUM=;
 b=rlB/H1NpkuLxtKEF/n6mJTpELQydvEkA+mh48WH8Rtd+QwvJjYs5sbYiqKWyAgFIrH2pjYBNxxr6miQ4Hp/8aUbhesWLmoJsHUaCXGlmcyA8M2eZZbdjrTmU571fIHO1Gga0WI3XXPwRgPBAyX99Bl4eWekL2dqdJQjXwXyInoX6ZLjmI6k2ujwOXBG96T+llWiZP6KeU6mkbuojSKVYJFsqMlsThl+M4DVDaDrwLW7Sf1/PGV1kSem0ePoL9WptP4YN24dayzBZeLmgNhQjWaSfp1qWP0cRbKMFyqNJe89BASmS2jY9npKTfxbnD5icLEkjfIcmj7g4vwPQC6lAGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 23:31:07 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 23:31:07 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Andy Lutomirski <luto@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 2/3] selftests/mm: remove partially duplicated "all:" target in Makefile
Date: Fri, 14 Jun 2024 16:31:04 -0700
Message-ID: <20240614233105.265009-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614233105.265009-1-jhubbard@nvidia.com>
References: <20240614233105.265009-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::17) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a34855d-9056-4223-c9fb-08dc8cca1105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZxztDYhdieUqAhRCrFJ9IyZeluJlAYYF61eqBs/Bt15wGIy7GitTSFFp+RGg?=
 =?us-ascii?Q?JYenRU+p2YZLjuyPXH3BIrkGQu8XDku1Rs3j3+it6wg1096PMRszT9fQKH3V?=
 =?us-ascii?Q?uhM5Pnhkd+0LXEAJQ2GG6kWvfX/xYIDhA5fNxy7thH6cO3XjNh2VEhEZ5G8g?=
 =?us-ascii?Q?HHw7OWspXtoE8A4mjDqKtHrDff8HZFgiM5hYP1L6h4LebHZilqeJUvEnYG+K?=
 =?us-ascii?Q?6rhIAS3eZjL2QeO/NJzzKlRXYes/d9AEbiAotYiHlqcIuVO+C9111dPdp9eR?=
 =?us-ascii?Q?6XlzHkVDtxCutdyl9KOMXGESZo6T2gxK+kus6tM/tX5+/N6YnSk8AoPBq8wk?=
 =?us-ascii?Q?DlJWlj/gyKQa8z5YERjUINBfQ3SBLID65UH6p7HuobSpT5v1oS/Gswa8d8bW?=
 =?us-ascii?Q?bo9a8y0hE63/D43x8yGlCncDcG7OxQXzFEtJTX4/Z8d/thRKPvNIPiQVOdBj?=
 =?us-ascii?Q?Ih/9dZUbAWiyq+D1kSBhwEznWgyPvO2fVGhj8PrtuD9jFIXOr6f/+kKoBs7r?=
 =?us-ascii?Q?rDhg5vTUYk3Vkk+liOtsZwVy57NalRFCgIvEMvbD3APYCxvuxS+yJh08GrJM?=
 =?us-ascii?Q?TgLY0uSphKkwdu5SMa18l+rxkhpNocouXk2LZsEohR7O13ApsqZQ3mbXqAnQ?=
 =?us-ascii?Q?C3CsnTGXxBVVmJ0Ynv2fIOlFuUcpzC5tFzInRe81uuz35QaOJY3SG7qr5JP0?=
 =?us-ascii?Q?YI04hI4Wcoqk+2DpG4qNkOHH6di/DwG/mhn+zPwl9ajfr3knm9hj3t0Rfteu?=
 =?us-ascii?Q?AIz4nLbQO6jErZy2OMgemYdUMCJOqTOw5iQELihBMxlB+uyyQIl0bGBJSlQS?=
 =?us-ascii?Q?LsVBByJBiEWsJbQqH3pWwNyOhCYjs/n8iiPmCr+VUrwPrUDcfQT7u3ZnDom9?=
 =?us-ascii?Q?0biTi6GLk8OjAPdGJ7YUv/9cTVx21yxm1Kyq+PB7dbFSumLrah3FxWhyJq21?=
 =?us-ascii?Q?vvAJ9JLu5nDSjSL5GVJBhehhsuWG+Ouyqah7E5P7H/SWcPt+p35bSY1evKhv?=
 =?us-ascii?Q?pr9tYIouqocM84uReMLiUXgFEpzF4TJNU5C6QBZPewtUv67lmXw0Cvm3a7PZ?=
 =?us-ascii?Q?Wd5ry71idsmWApwYlVAOcBG6nE1wEQIDxeZ+3+Ro/Jn53C1I1l2x6SJPjMHi?=
 =?us-ascii?Q?ZuNBEiO5thqhArxU9jLtZ3zc14rO9kwpnrIs09NpcLaLcd7+1EOHH1HCzrGZ?=
 =?us-ascii?Q?K3CRKWlyGqcnjo94lHNTg04OryzE6hKug3bT6To2nbC33hkBwDRUTpO5PCWF?=
 =?us-ascii?Q?vOdHOov65dbDTGFRV2AihpSwsKBolP2dI2Kd3l50bGxPJlMvXw+P/JZT74Bs?=
 =?us-ascii?Q?lMasIa2J+fuLF449S7gmzxHc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eDDVPcwiq/oR00eGeHIoq8dxpYTeIdgPfMs4LBpl88i/thFNeeQSpFBCkvV+?=
 =?us-ascii?Q?1j4PmqJT6hF0TpIuyn/EqmE62hYvfxyi4zEJNRLwWie6OnbNzBvKPP6/Zxtd?=
 =?us-ascii?Q?IfHwiM2oTpNzrPgRHuI5L3cAIyPCPlwhYzYuDEeZJIRk/XutbSgilPZmfiOh?=
 =?us-ascii?Q?cUGqUEcETpeqkGiPCSXCfp893S331m7WkEUL3QkdhaUZW3N2qS3bXJyYlJA5?=
 =?us-ascii?Q?yKUuG0jNdahCuJMfeAvp5rTSnsNJcvtJRJeS2otmwWNy2jrwbrDlEIuP01nH?=
 =?us-ascii?Q?k7owzHaAOMoSp3tWcQpRbwQEqeifI47g4uBpBFj+Wm/Jtyj0Tewmy74B0PZY?=
 =?us-ascii?Q?6m6SbNTURn+4zwRpD3+ChZIVf7SfzxjkA58+tXBYC1KsvRyXhdPT9b02vDJK?=
 =?us-ascii?Q?tl5m/Tz1z6kdu5gUJ13ovk+r6JE/v8WmayysRg5tsDCKcIFMwyMupeVh+yjN?=
 =?us-ascii?Q?efG3jo74DKNPLGrX5XGieU1+huOOmSqd6Bt612TeKRldKsCDblPcbR03dvuk?=
 =?us-ascii?Q?y4cxhxQTh0Dzr/kIim5YdepygtcIOTi9hziw4M1JAFUKcwzVjtf977eVdvVi?=
 =?us-ascii?Q?SFOBipywEXnA/kISUMUN07JQYs1QfsgsB6+tL7zAxEpUnwjdNw4UPhM3uYJP?=
 =?us-ascii?Q?8rwKHzmH4M1dnCFHEkVQi81fPcUVF6H3lBGO+Pw6LzFHHzJbs5sBu3ijLq9x?=
 =?us-ascii?Q?6ySCfzjqShspgM8lgH6Wu4j84y/HtUoOI0eNVmUCTrFy67sGDlfBk0+/obO3?=
 =?us-ascii?Q?FkTr8x0hQNkvS5NpFMgMcKRvGS+l0obBzVqvvS40rXghHBHcROdWoN3EHpof?=
 =?us-ascii?Q?ijbeQ9Mm24gUMxcDQJwgzHiF+PnSXjsmhpTJUHOPApWm01/BaPpQklmYCY4f?=
 =?us-ascii?Q?AK3FZhzsiAU9jyR1P1EZkfcPfxXtY/yBxldrkqIeU1T6JT/cj5BPZOK0loyg?=
 =?us-ascii?Q?8HUg5dYIpVFjP4zvcbAypQvNYEdVQK3XuTtLM3IZ/AK6qafOFH+ixmUNvDCA?=
 =?us-ascii?Q?SkBsylHldH14DkNhSsmvOLYrljaBG4w43oaeAcLiHz6CqCzepB2+dtNbGvKo?=
 =?us-ascii?Q?8tB/9Y7y85M63dosTsd7Ln+oxbDZyUSLfKzjA+Vc1APi6tJiE0+LDgBdC5yk?=
 =?us-ascii?Q?uLGCyaOfBAItsilQyI6O8ngb1LOCBaSFoHYaGQGQbew+yO1+3lqAeC+9gl6d?=
 =?us-ascii?Q?ft4kfp4/6+8zgyp4s+NhPIuVoHPoeoG/Y099zkKKooE4Epa4vtXf6+Rk5lU1?=
 =?us-ascii?Q?SRie/6jcMwaXmeHxeX/8HuDhsvI3+igRwPtEDySRpg/UCeZRTsNmEpwD67Ei?=
 =?us-ascii?Q?PSs/lYFSR8OEJbVUULoIg+AS0QYLpDyej+Jh0DTSXu1A7apViQxTVmUbSqWq?=
 =?us-ascii?Q?MZrpxLtQDYYcoagsAX9XqtEY+HC325ztym4j77sjA6LBZp4oBdON9nDLIL4i?=
 =?us-ascii?Q?y2vnLfWkmZ/i1MwcuJq+SnRKfj0U/JLJT8yT6ziJy6jzz4zth9FwxH9198Bx?=
 =?us-ascii?Q?r+Trgr5cQ4vPRTbsBoMzG9ghzM1HTPLw6bcbnDWuFABfXXVM6TC5NWl2gymX?=
 =?us-ascii?Q?R6te7sMAAKyv7XQska24xZAOLBUrOBL+WerLrPu/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a34855d-9056-4223-c9fb-08dc8cca1105
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 23:31:07.7245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnUUirwW6o2j7jIOgU22pfmB/IocOXlZ//fyNFKYxZGaVqAjMtSGHNpCqPqu44BiMUMVcTwtTLPFBUzAQ6/jdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953

There were a couple of errors here:

1. TEST_GEN_PROGS was incorrectly prepending $(OUTPUT) to each program
to be built. However, lib.mk already does that because it assumes "bare"
program names are passed in, so this ended up creating
$(OUTPUT)/$(OUTPUT)/file.c, which of course won't work as intended.

2. lib.mk was included before TEST_GEN_PROGS was set, which led to
lib.mk's "all:" target not seeing anything to rebuild.

So nothing worked, which caused the author to force things by creating
an "all:" target locally--while still including ../lib.mk.

Fix all of this by including ../lib.mk at the right place, and removing
the $(OUTPUT) prefix to the programs to be built, and removing the
duplicate "all:" target.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vDSO/Makefile | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index d53a4d8008f9..209ede5de208 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -1,16 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
-include ../lib.mk
-
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
-TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday $(OUTPUT)/vdso_test_getcpu
-TEST_GEN_PROGS += $(OUTPUT)/vdso_test_abi
-TEST_GEN_PROGS += $(OUTPUT)/vdso_test_clock_getres
+TEST_GEN_PROGS := vdso_test_gettimeofday
+TEST_GEN_PROGS += vdso_test_getcpu
+TEST_GEN_PROGS += vdso_test_abi
+TEST_GEN_PROGS += vdso_test_clock_getres
 ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
-TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
+TEST_GEN_PROGS += vdso_standalone_test_x86
 endif
-TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
+TEST_GEN_PROGS += vdso_test_correctness
 
 CFLAGS := -std=gnu99
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
@@ -19,7 +18,7 @@ ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
 endif
 
-all: $(TEST_GEN_PROGS)
+include ../lib.mk
 $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
-- 
2.45.2


