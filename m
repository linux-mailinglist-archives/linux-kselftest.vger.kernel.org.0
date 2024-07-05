Return-Path: <linux-kselftest+bounces-13253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F905928DFB
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 21:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A244E1C22009
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 19:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D434176FCF;
	Fri,  5 Jul 2024 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rl3trHOW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8D16F0DB;
	Fri,  5 Jul 2024 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720209477; cv=fail; b=m+2LRsa6eCsTMn6tHa2T7CrUIo/dygXwPX8eO+ItMqA7VoINncLuxb7Iz0H3ukGvu/gveczjoGlSGGVP/FX3O4E6lH0pBEPClR5nl9cka5zY5oOwV+lAKQbmZEzfHBb9D7NNcuEd5sq8ZQSddSk7pwh2ZQqTLE64zf5Hx95bM+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720209477; c=relaxed/simple;
	bh=l4Qayl59V/s7Q9mn9YD+B18jKgdDP2BoP9T4RlmbXco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=An+syd97CJUKBZFNAwBeSgN9nYkZ1A3oft7JOOcFj96NZJEV4WosMuInXqzvd+xXuCm6+aoLKC2tvYO+ia4Y3/RNh5smhyYJzq9G236SFa+X/VvtYqzXB4PzYkfnS6lFuDWC5zd55h6ZTnQY8LV52PRlLO9k9iR+Dmi39rociXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rl3trHOW; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VG7B24GkWhDdk+KjSwC9wiHD5KUr3aX4vt0a4i03bIdLeIuHJfaYvyj23HYEK42dPNHpF1IARN1JhRSLeoL0NfWSUw6zvdrxvw2B1XCpjDiDqOiEGRvZDaMH27tTX3Kkh0GHl7c/4/HntWFVGT6ImRfPAhU8GjNCDUYXBSYRVLFtiQFpPCkdNRiGhSedUaFqxHKt1wMrOrtF6yAsV8S4m3ORJ7T3L7HUEwUXFHsWxzDEw+RGypIh+/BxlwIDDqk5HiCSKU5OcXZWUS8XTi86MJ6vLfxag6VzK0Zud9O83TBhiRXKq3a5Igks2vEX6MfQtDFf40W/hKCZIbEYCm6EIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oGgTKmR12kMPn7/W03CqVjSGfJLsOUVM96PrbZRhQU=;
 b=OuOlknib12wUcNbOb9cZCmouEerN9jI2enP4zfgWl1y7jWuY4PmkfZK/DACKZ1zReBFZWRZayJzGxIQ3eAwLtWkghh3WJR6lUyjO7cIjFgbZpOxl2L9Qcwf6nvxF3FF7UO2Sk5T28myCUexSDpCvsWJYoGXK4NyMatqsyC9loEM5EUMg4hlIQQwYtOWE8OPHPptfyy307g2ZubdE9PWa95YWDsmNO7c2bQh6037RKhxeimiiapSQjOBE+bGtKwAcsZOauDgzdQFtXwi/lnWH+mvzlXPmdifn3Z2KxMeNcyKtSTCCzBwpKwT2bfVTa+NeCtZPmR5AgUI/svly0Q2ZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oGgTKmR12kMPn7/W03CqVjSGfJLsOUVM96PrbZRhQU=;
 b=Rl3trHOWEiahMo3OJT8cpLgVjtzardaKwMldPSK8nV87z4PTX8iOTK3Kj3JkrcXslwIBnPGW/q0YUNdBMHQG9LQKzWiNzm/rHRWFbrEW6FbscsVSijrRdJwCC0ugaBD2//c8lQvKUHxBi0YBQGBCLJ2GNK99ZWNfgAQBFtl3IwaNbgT8vVpi+L1lNR2xDDuwxh2/vKgdWXUm4+2OzGZ5BIEt0a5bDhmhCY7AR1w5Ns8UITHfsU6Jfv29bWMCcXeUQ4MGCdK791U+744GfUdhsejmO5OFe9d5zkML1BdpTvAsSUR1GvzGm4zPBG9veWuASU7q+To9oa/mrks6bRltWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 19:57:52 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 19:57:52 +0000
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
Subject: [PATCH v5 3/3] selftests/vDSO: remove duplicate compiler invocations from Makefile
Date: Fri,  5 Jul 2024 09:57:36 -1000
Message-Id: <20240705195736.34039-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240705195736.34039-1-jhubbard@nvidia.com>
References: <20240705195736.34039-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::17) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: fea32154-2c6f-4202-9934-08dc9d2cc12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zOSU+B0M+6I4fIcSmp+UyzZJuYoDrGCi18r/1AcdkxfAleuKUJKoG+Kxoa5r?=
 =?us-ascii?Q?pNOgwgCyeH12XlnoeOm8LBRYZTV/Eo4wimsNKCDyl+HNOpFuGRK7EEepbWXG?=
 =?us-ascii?Q?hUwF2tuPWFz6nX3nJ+Ar/GYUTsGJUammpMi1Gs22a+2kuMBwXOKVSaDwe7cP?=
 =?us-ascii?Q?c1loWd9xvwd1C2za778OrALJImB7tushiulISML1VrVCMsNXe/KM8unL66Y1?=
 =?us-ascii?Q?mcbOcdqNC9uGEfb3cIVm/gZbARVVWz6PbUfCe9PrMMSAf7q9Iq3HzxcozZTy?=
 =?us-ascii?Q?L21aJ2Ie5DUskOVMiGKlDp2LL7pk8kDkutkXd6giW50JLt3mu1RsYgKoxZO1?=
 =?us-ascii?Q?bH3QFqho1KYkufZfqwECtKlVFND5HDnyVVc+gniGNIH0Wjg/Uff7oYDTCSKs?=
 =?us-ascii?Q?ae4mlPXX3U5EKY+n8sJkJduvj/KxkkDdRVa9ALvfnv+PPwXT7voFol37zirN?=
 =?us-ascii?Q?H7Y2Vd1w5K9G1zaGkSSQ+4b4E8PLCuodfLLvWFXYWvyiwpGTDsVMQT/hj7/0?=
 =?us-ascii?Q?SJrX4AW60K63US0567z8x8upiCFF74/EZVx+nbGN7gDXE+isZaZG9ut0ke8W?=
 =?us-ascii?Q?OHdfhSFh2kcKqWcTgbIvPNDVwQneMLXCZDOKZXAmcfuPRL26wpUpbNFkSmGf?=
 =?us-ascii?Q?lzuIGwif1FAHddYQvSg95GM/Vp5SPTxIb/rCk0YdL0+t5+5D727lxyrQa9mw?=
 =?us-ascii?Q?BWc/iNPCK/rejza3FkHj/TmrkKaWbqcICfXrNJixvlBihisVZSUe66X3t6jE?=
 =?us-ascii?Q?FuaaLEQykq9ItNk/61W+fRz+XFaM1hMyKEJxDISznYWK+T5JmXqSShkZdYF/?=
 =?us-ascii?Q?NwrMFvjTBYA3w3+HBKMDk+PFoLWUSDpsdg7CSTT2ni8nV5c98KZuIVSFNV1K?=
 =?us-ascii?Q?JIFK6Adk/Hmq+3pnNjFXEUsMry2Q0xKzjdkICNAWSxQzxP10E+Vx92yLvQh9?=
 =?us-ascii?Q?dy8X3xrq3ui+2RKhnmQQfLW7XTXYZOtHDFj00ZscBI9yVLC2RQlTGRiidqWQ?=
 =?us-ascii?Q?LCD9ZV7mAOcxWyttvNnPypcmD78QJ5we1ekT15KgF3pj9ntn8zLDybC3GRUP?=
 =?us-ascii?Q?rTmxuLC54tO4KoogSE29o5cCt1NPJ1lPuWI33yarOd9tNIlggjBJUIoXLss2?=
 =?us-ascii?Q?guaHBgwhH22aOAc1f1wiiPt/qkd2HnCAqwuRyMnuHfkkCwOonj/QRLAmPldz?=
 =?us-ascii?Q?zsoxydTqvN+1KhhlcZhD3Ae7c+e4xNSipGt3fVBDYHspzsduXnYGhnemAJdQ?=
 =?us-ascii?Q?GLa74Akj7zOoIizl9kYKFpV2aVJ+rpTlUdvrxfkuCSst0R1KoIfSzMTCwF0j?=
 =?us-ascii?Q?/Hyfx/2oc2CKp8GZaV7GmU/33+1TPmhUaO/bTG/u7V4EKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ygTaqa7SRl0GQQnafTdPKyFB7MTxcjBO0htGZF/NMPcP9HKSTiMXt3M+rNnE?=
 =?us-ascii?Q?bQ5nuP0BVbYWBGiVQjwTyL1AS7+TuHkpUp99UdBoMNKE8EVRLzrXmyuCS2sU?=
 =?us-ascii?Q?Kf5PoEmpACF83W0uxpdp4es72DfTm81KR7wq+O0iTsNO4SoFUR6ulHyaPhgs?=
 =?us-ascii?Q?v4aWTH7joki/X1c5/uf0cypxNkpIzhOhZznC+82x32WrzV0PT8oB7EjkkQo7?=
 =?us-ascii?Q?+CbooSdE8yt2YhaPGcTR694vmrDjJyy9nJQjuhSrKppyz/hQzdXJVM4jDhLh?=
 =?us-ascii?Q?0j0FaK2366rG5Am270f4lWIVj8oFULK19oRHE2Wnw+0r+vBS6P8uWFdEWMpI?=
 =?us-ascii?Q?+h08gH5yl3PgG/PGkbzCPG+d6iQyWmLs8EMeUsHkIM+2iuPQ/lKSK0uYRyNF?=
 =?us-ascii?Q?A7VFhYyWo1+6hyWgj3jD80Fs4BWCtY0GS0XH3KDeCZqOMIwZXQR9nrzs+YiY?=
 =?us-ascii?Q?th6neIT94X9KJTCp2QOiztLCpkoVpiYb9pb5fcy+LNJwcvQhs2aBBbV90983?=
 =?us-ascii?Q?RU9J824K+CFyScZV8DaRKkwKwsITleJey4Pe3O+y3Izz5pXd6cAqZRzz/fE8?=
 =?us-ascii?Q?BkMGxV2ySyXkxltjET9MNATHo6c7weo+B75fYL+hPWKh6Pqt0yyN7iebjDez?=
 =?us-ascii?Q?DdtM1TzErtYrOixR8imxngCgRhBaMFQ0WYWtmewhFWxAb6U0EMNBeZ9HEg5y?=
 =?us-ascii?Q?nnLsBk1UcvpqYZSqNso2OfwsXqI5MQy/Mu1OQbh/ONkR2agJSVL0AjBQ9/b6?=
 =?us-ascii?Q?aoIL+uAWewsfDlV5xEcu2Ce+jjkB1XIazutpXtzdiHHlcBQ/TKUSMul9x8AH?=
 =?us-ascii?Q?+4ZMjATT+RuD/ew83V83RThzxBp3DWsD2tgPy/pWAGcXujMk0Ta/tkpRkgtu?=
 =?us-ascii?Q?aTf5oZpaGx+bx92IJzcdykxONh3+vDg2Ib0X5TO3LPmxEZPckB9sarVfkEWH?=
 =?us-ascii?Q?5wwv/WBTSzcVueoz1yFJgb4GQ6p2FnWTKcjx2icfQGTEsQrmV5TFgHrdptHM?=
 =?us-ascii?Q?gYGNpbk5fm+KbaUeoBLzMBmBhnTiyQr43k/oL6llD2G4DcLbdvVahgvecKjs?=
 =?us-ascii?Q?flU+ie8yDU8V5taIsI18wCb/pk6BiIAbi+rkAjnTVEu1J4TCnjX0BGDbwDyk?=
 =?us-ascii?Q?nV2knI96KUXGfEAOjzKLOtUrJ02eCtp1fSfo8LPvhBbAuRoRSuVo6X110491?=
 =?us-ascii?Q?1dH2rYhZC2lFcUl3uefM9JbzLfkVY2NHWPdYjNnAJwy49RlFsXcS18qFmG47?=
 =?us-ascii?Q?0W5qsnMj6ZyvImrjyBLFTQfxm//2PVKPNGvEpyBLZ3qae9MQIIhvvaD+CjOq?=
 =?us-ascii?Q?5tEmMk2XiLQudD41V0cLwb1LiORMt7hBlma7YKJLYUWJzLfAaYTvp+KwS7gC?=
 =?us-ascii?Q?cmEUha+pIs7APQ06QOURPtqAL36EMVJAuQSyuCudajvJXon5HBlB8LtUoKd+?=
 =?us-ascii?Q?hJlphSrWzcapmXiK9aIEcMIoWFTObHJwO58RXIu6pC3z514HjwsnMmcnPK0g?=
 =?us-ascii?Q?DyBtEIbL0878ECKJkshBQK5qQestny6/TcLYy99MAl7Nv5R34n2BfCbeRoxm?=
 =?us-ascii?Q?woazjssZHytDjyaEJrnOx3XnAh4sJqCEo1mqW6Rb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea32154-2c6f-4202-9934-08dc9d2cc12d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 19:57:52.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rw4mOf2IiDDSXToEaF97K1h1WcMxqKSRdpJIpvuRVDGa4LjnKFpN9u/RESr0xAIOa8hYmQkLkVMVplls7CISDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877

The Makefile open-codes compiler invocations that ../lib.mk already
provides.

Avoid this by using a Make feature that allows setting per-target
variables, which in this case are: CFLAGS and LDFLAGS. This approach
generates the exact same compiler invocations as before, but removes all
of the code duplication, along with the quirky mangled variable names.
So now the Makefile is smaller, less unusual, and easier to read.

The new dependencies are listed after including lib.mk, in order to
let lib.mk provide the first target ("all:"), and are grouped together
with their respective source file dependencies, for visual clarity.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vDSO/Makefile | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 209ede5de208..98d8ba2afa00 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -12,8 +12,7 @@ endif
 TEST_GEN_PROGS += vdso_test_correctness
 
 CFLAGS := -std=gnu99
-CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
-LDFLAGS_vdso_test_correctness := -ldl
+
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
 endif
@@ -23,12 +22,9 @@ $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
 $(OUTPUT)/vdso_test_clock_getres: vdso_test_clock_getres.c
+
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
-	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
-		vdso_standalone_test_x86.c parse_vdso.c \
-		-o $@
+$(OUTPUT)/vdso_standalone_test_x86: CFLAGS +=-nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
+
 $(OUTPUT)/vdso_test_correctness: vdso_test_correctness.c
-	$(CC) $(CFLAGS) \
-		vdso_test_correctness.c \
-		-o $@ \
-		$(LDFLAGS_vdso_test_correctness)
+$(OUTPUT)/vdso_test_correctness: LDFLAGS += -ldl
-- 
2.40.1


