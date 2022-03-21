Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BAF4E2029
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 06:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344404AbiCUFat (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 01:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245302AbiCUFas (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 01:30:48 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2124.outbound.protection.outlook.com [40.107.215.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8710D8F68;
        Sun, 20 Mar 2022 22:29:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYrZXZQwq8qFzKZE7DDHHGFDZFtO9iTct9H5F2NvmuF/h7vJdc0RXZbWMYxSU8QYQU4ZcCmyZ4yNr4tyMOUe5uvcvE1jsv2WhDxYqrAMOJSTsdW36Si0WkyP5FatenwaFOqEHhtph7yZTEjdJBeKvVoBYeb2r3lF+nTJBR+/JLrcxU118RrZu2YMb3eR0gppIkgjm2Rqs0E92bJ8pg9IM8etoYf/xJ1uW0FJchLBBScQmDp4g7O6X/3FbzLxbdyAiXPr45kSuDhrGsLVcUj7vyM+rJMm/1LhFRquHWkCcEfPi0gakVtf+ngOZZ6llqf5nEBrHlfEJdImKoIa17By8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g446HCpuYtRDLtiZ6DOB3sLqw8elyizL3CjgbcXJPRQ=;
 b=N0zsSwAv5AjCe+9SmwHetgCSv/XYpltxvYk7SPCOC2faFzY4fJ9r/CtscjKuxgrmStGY9fRqpJFq0MJSMHWyM+yFSX8MyCFnpjJJ+nZaXEdOoqeDGgjr5YfuEVYVV89UOhtqjYCkyWvoUCa1rAS5vEVIq0iZI7BTi6S3pgx9ShcugV4IfjZDfFS738+IYAlCB1T7mt/PhpilExmo40BzN9qUAuJNe7bHPy9H0izhqDt31GHpxwWA1QGOi7AsyTxuuZYWolRi1wWrRQ8EhSGe/ODbdpN5dKCILiaCWv0K4AHlBIKB8RR9ohu1LElaS13ZuE/XrCHpsga7jrWgn4FpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g446HCpuYtRDLtiZ6DOB3sLqw8elyizL3CjgbcXJPRQ=;
 b=fhN9ezimUOOdRg4V5/SMJXL9l3xEahrbzsVJMo+f608PHNCZdW7WXb+GkRLKUXVxR68o77iritKHI7T+IU1Z8eycsb/KC5IJyyYFzG+ETHKmIDuKBQGUuzg7w1D+chiz5Q647O3iuI5NheTjCoZEK7wxJvj31tD5IHDc4YN02RE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by SG2PR06MB2491.apcprd06.prod.outlook.com (2603:1096:4:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.18; Mon, 21 Mar 2022 05:29:19 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::d924:a610:681d:6d59]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::d924:a610:681d:6d59%5]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 05:29:18 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Shuah Khan <shuah@kernel.org>, Guo Zhengkui <guozhengkui@vivo.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhengkui_guo@outlook.com
Subject: [PATCH linux-next] selftests/vDSO: fix array_size.cocci warning
Date:   Mon, 21 Mar 2022 13:27:42 +0800
Message-Id: <20220321052757.10918-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0115.apcprd02.prod.outlook.com
 (2603:1096:4:92::31) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e487a0f7-5000-4ed3-97f4-08da0afbbef9
X-MS-TrafficTypeDiagnostic: SG2PR06MB2491:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB249112305C380D345486F9C2C7169@SG2PR06MB2491.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89RIFHIqjY3oOfte/5sTsYzsZlnLXEW9hkx8zBRcqGTmOqV2dJp7z+u2qkddoAP26LSx9RoBdiWISSsTvC08J+iODUdq9lCIk72OXzCHj35ahkgoJXj1alf9GBCJ3qCn3N/2zqzKbB64OGb5FXMhY7B1FGtjgm2OACY4lRjYeYh3oZZpU+cHxyg14488cw5nN06Ksa4vwKNOH34XpVC6ijIWesX+8S2vvYgToTcbUkqSnFKV++xJO07ismPgJ1TTSPETnnpKAc77tcr+s6/ctjdeRs3IABaFs+osNVoi9r+0TVv9aFWtEat00fPAIa4iYTHggOR/zzuZpGPI17UGe3UG/ehwg5osmTdWwMyrLXuEiWwkTgUln7Y0C80VbU+m0/P0pSIgntEyiEJ36Tx93YPK7jdKAcZj0izq+zml6OC84pOmUZyMHeeElo0bI13sm10p+qC4jqGOpeg2ntXWlMv56AGRoWCJW9NsK4VCZjKAv6xfOFbTpBDMaLddbgMqm3U45oIC6lJuJX3zZha5Fk0o68KPpboMuUQqYZA/skh705qrq6L43B4Jf1Ft7mdTuIkX14cJx1s3OumbBR4WgjzSoDPbredMhAN9v7Z+bQ6EKvsLMxi4gDLMd5AWCZwM8rohI7a2EbpyULD3HtzXgexwBlesTf3YGBtBCtemQ40wkg0to+oVjRR1xQyHSZ0h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(66476007)(4326008)(6486002)(6512007)(2906002)(52116002)(6506007)(6666004)(186003)(8936002)(1076003)(26005)(38350700002)(38100700002)(508600001)(2616005)(5660300002)(86362001)(8676002)(110136005)(36756003)(83380400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VZPNmyn3Bio67nBSftsghPzraj69J/+9tNkOGDhvvwMvdFBEPQrxfO9pZ2tM?=
 =?us-ascii?Q?ZDhGFJuaSk2genrvvLqm3AqZBYM72LcJmkQWbl7qKBYyd4G4RtlS/JloS5gI?=
 =?us-ascii?Q?xvK7Ij/4HjvOXLcn+M8C5wpl/nYvR2evHnMXddKrpZ1gX2U8T44yK0jvJjSo?=
 =?us-ascii?Q?29Gr/nLZVID4UBoiWBbF5xmM96/1lxrTBl6oSX85ZHXQGgUsSQHVPhJGCkrO?=
 =?us-ascii?Q?cqSxIdikpEdDyDVn0QzDSWsvGrJ/xHzxbtzu6BEU6ENPfM139QM1q3f3VKna?=
 =?us-ascii?Q?nST6vbrvaKhZLfQMy9y7zWlig2vozb5UbeP2BHNfq9kNzolz7LPIznHnRMME?=
 =?us-ascii?Q?APdpEgCJasqyWTf/ixbnoY3qUIYH53xmOv+1w0sKi+YEAvlEolVnAAi5VStg?=
 =?us-ascii?Q?BD2fEyZazGpkjD638uRGD8++iJu1g5LhIQlfZY8du0VN26evdyz3W7HjOji/?=
 =?us-ascii?Q?7pn6Cuu3npIY+RzeYLnGHknNtrucVErvedGU0tKPI0/HF1kd26RvEbexgv3a?=
 =?us-ascii?Q?bHUK/XexWS1j/VC9DrA/ugM1JDq32/i+e4rKzFsKAKgDwIJXFTvpMnumOMih?=
 =?us-ascii?Q?Ch5fMDubih/Ks8sL4BH7KObiydvjVL+RzQGlH6JEDUcUWyf6bIYmiz55JIGx?=
 =?us-ascii?Q?hSJqYpn8SkgM10P7d1IrvqTjERIDfy+0R7XtSIxGTOYj/zMlwQ6mEInua/CX?=
 =?us-ascii?Q?xVtDtDfeiHmIAdOhXD10V+EK4ogtCo0fyvPDqdZVND6dl1LicnbSstNMcVYc?=
 =?us-ascii?Q?LaRNaWXkpuBz8rZvzgRXtJSqlMXWyO6bGmklcVrncaU9RMX0yB2P3d5kk7uo?=
 =?us-ascii?Q?8TqiDPElWSWz1Wfsx7wr261EBjwh0j6YJTsHWuTRH+scoJirFPzThbmkaWtb?=
 =?us-ascii?Q?tpz73YZ8zZikbJm+DZQQ5C7doTKQ6tSeInUhVegnM4/WBHECRbJqaecKXdM2?=
 =?us-ascii?Q?FFtaEsz1cTd6Fh5MJBEL99/FVzZ63YRf0pvd+rTceNWzoevyKSu0M3cNHTrg?=
 =?us-ascii?Q?aoEeCKbUdJRLKrdH4I8MVEYoF4kSOC698HKVNF6UlEJR8tZJbY2fiJ7XxwSJ?=
 =?us-ascii?Q?sxb3GLDeSuufOzozbS/1qnxumC9kX2Lb2PWaDvYfygDGP8PGSRmI2udn3x2g?=
 =?us-ascii?Q?BTqo9KFJWNCL94XZHtzs6LJJ0cyJvTMh0SZidSYY0lzzuiqAlYrr0jmKj559?=
 =?us-ascii?Q?vb+MdiudbbElmsKa1HvTCkwY5cGyiUCCZGUg1f2odHgbXH5PLikhjpHYG1qq?=
 =?us-ascii?Q?PoHR1W/UvQCdhxM08wcOTa8j6pGg5ZDe7nO4NOpPLGDC/TyDSEMZ8AoSwJd6?=
 =?us-ascii?Q?78IAdoaQhonv27mFdhmScIHpdkPBVgyEoss3jIfdJ6cWgLCV9C01Izg0U2eA?=
 =?us-ascii?Q?Yd6l6k1rTlJDbutyH4jQVnW3lLHbHjU+CdnvNc14n70iba0VNWtuTjv8IAlH?=
 =?us-ascii?Q?tVsHUB0Fb92s23mCdlbvLzx2S9hJJNNy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e487a0f7-5000-4ed3-97f4-08da0afbbef9
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 05:29:18.6568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2Se+3nf0HU5CQfwKtNFIemsIgZHzlaIYfhGxHWacbx0zC5xb+iAVBin2boqixivSiYVIghOSHGu8X7kiortTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2491
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following coccicheck warning:

tools/testing/selftests/vDSO/vdso_test_correctness.c:309:46-47:
WARNING: Use ARRAY_SIZE
tools/testing/selftests/vDSO/vdso_test_correctness.c:373:46-47:
WARNING: Use ARRAY_SIZE

It has been tested with gcc (Debian 8.3.0-6) 8.3.0 on x86_64.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 tools/testing/selftests/vDSO/vdso_test_correctness.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index c4aea794725a..e691a3cf1491 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -20,6 +20,7 @@
 #include <limits.h>
 
 #include "vdso_config.h"
+#include "../kselftest.h"
 
 static const char **name;
 
@@ -306,10 +307,8 @@ static void test_clock_gettime(void)
 		return;
 	}
 
-	for (int clock = 0; clock < sizeof(clocknames) / sizeof(clocknames[0]);
-	     clock++) {
+	for (int clock = 0; clock < ARRAY_SIZE(clocknames); clock++)
 		test_one_clock_gettime(clock, clocknames[clock]);
-	}
 
 	/* Also test some invalid clock ids */
 	test_one_clock_gettime(-1, "invalid");
@@ -370,10 +369,8 @@ static void test_clock_gettime64(void)
 		return;
 	}
 
-	for (int clock = 0; clock < sizeof(clocknames) / sizeof(clocknames[0]);
-	     clock++) {
+	for (int clock = 0; clock < ARRAY_SIZE(clocknames); clock++)
 		test_one_clock_gettime64(clock, clocknames[clock]);
-	}
 
 	/* Also test some invalid clock ids */
 	test_one_clock_gettime64(-1, "invalid");
-- 
2.20.1

