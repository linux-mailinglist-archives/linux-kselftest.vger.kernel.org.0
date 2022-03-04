Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9DC4CCFDF
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 09:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiCDIYw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 03:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiCDIYv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 03:24:51 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300099.outbound.protection.outlook.com [40.107.130.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3D818BA5F;
        Fri,  4 Mar 2022 00:24:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhJOhKMHgGvk9fGXVWDvOfNakHcmbIYlfzeNw+4C2xzjjMxg3yVplDLz1n20O5RBZQ9XAu8jcoadWnKUuTTfob+wJeYcbCNZww1FmN37isrNmBb9mhVFG7T2so6pfImCYmUmgmNe2spu81i3sS9ofkpCwVq4iIs3GWDvIypjnL7V01s+cu9WbhhTyCFmCZzT/euA7eRDFVu4oRTaVObDZSqXg3FHbSiq4AZwX8rsJMGajL+2EIRuNlPhr9NkblRVsAXvJ5Ykdkb/b9LsnYtV8VAuQkdvVrI8m7T/8IiYIjq4TFBoLQeIF5w2QYycLrCRK0Wzg/YhwgE6FjoFNFQNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuqEfBXCTL5RtQccKhpIkfq/bB5XqscDbM/1iOAExRU=;
 b=DlDAKNfTPGv/UQmZsLoSEfw1yQq1OqpfhCoBQWZTEyroS84nryUE4THaP76YghOVie6Ladth8tGLm14J5MU5x4BqB0tW6l2sfBZESN5g0yYXEaixT64laXDkoLRZFIpnBScMCVT5xttTRmxFdtvs2k60GCygBc62iGb29AUbIExmmFD+CQjUrkIz99lK6mpHKyH8d2/co8OLlW3zXU/lTh+/A6CClqKwz9J4RNzGSZdejBc0y717+hdaOZKdam6KgW4+2qj9nnSSdLU0B+sa/ex7VkwdaNgD/4DcivE0RDmyk/UTSX+RmCzNYtXAqqXqp4mXth4TbBAcqPGRCCZREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuqEfBXCTL5RtQccKhpIkfq/bB5XqscDbM/1iOAExRU=;
 b=SlbyqeJAwo38c/nExbXdlJ4HwCHubDipXVHBnTv/8nRLJVredmojAf9XylBke3fjC/GJ1ovtYtvpy0BEZAxMaz5mfdRHQmYKU+oBwLEhI13du0x1c/HDQwaC3Swg0HqlrL/CNE1KwwTdryiH6iXk0wG0BT6wbFed5u2cHH/sTMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by SEYPR06MB5160.apcprd06.prod.outlook.com (2603:1096:101:5c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 4 Mar
 2022 08:24:00 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::d924:a610:681d:6d59]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::d924:a610:681d:6d59%5]) with mapi id 15.20.5038.014; Fri, 4 Mar 2022
 08:24:00 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Cc:     Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] userfaultfd/selftests: fix uninitialized_var.cocci warning
Date:   Fri,  4 Mar 2022 16:23:32 +0800
Message-Id: <20220304082333.9252-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0051.apcprd04.prod.outlook.com
 (2603:1096:202:14::19) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bffcd8f-fcd3-447e-d5d0-08d9fdb854bf
X-MS-TrafficTypeDiagnostic: SEYPR06MB5160:EE_
X-Microsoft-Antispam-PRVS: <SEYPR06MB5160CCB164B1EFB1C92FAAA6C7059@SEYPR06MB5160.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +03uD3mxD1jaXM1lltqSI38hO9Pqx99S5xDHoAtq5kO3w9QUFRTPqVeR39YiRNQezMwkXNb4bNktytMtQCHYA9uqkEhKSC+aKMICNQo2dZC6JtElnJsE6vilCk073kjT1eLFcsQm73qwcWUQLkNgY4PqV3NT/VwkKISOubzb4xIUxOxAzNXOiJlt9H7SblJmkxqTMpVDGprSHiwLWxE8KRPre0X+sr6mX+bBHxPQRa/1epaKDPfLBlGSvfVyJtZvGaMiNLJ0wJWB/9QzWcAgZHAGctvoiSnz11sBNegcFLPcUW5JVKeWrENv0fvOaQc1cYsgMpPF4gqXniGsWIIq4YvTGCX9EZGY6V5iX+plPC09sFHzzjuKFvCHcHWtbaPH66wQ2Ld3Y4EABl0L84mMRxL1aiRZUnJBiUvdC3XgCmdszftNtDmYjwPh720etNzeG/eSqQFy0QDGgoQw3ZL/ZdMee3njlzVExX6/DI9QmYRncY7/sGd4c7aKEN4TyqYTKTRq9phFb33hpqil7fPdvIgbmL36s1VrRK6wXC3r25Bn/2K5q9B5pFsHM64s8CeyChWZUWkU/wGfgMIjG96E8x8pPTnyN/Le5sqMbEApXKVT83kWxpsVPCQKthbCdaxBgJkGW++v+/974GhxzlXBMzeOpoCeZjL51McA6cdjX+JYqGmYNfdJoF0RPL8aG5MNmC0yKZKbz+XSuz0VJOtdieEQw+ZOkv2FB188JJElMcdjrMTfx3g/FsEAGz7PyQkRxmH7Nv33940lZ8vHI5I6c+4zv08SNuStU2qOR/kRVR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(2906002)(107886003)(38100700002)(38350700002)(1076003)(110136005)(316002)(26005)(186003)(6506007)(5660300002)(6666004)(52116002)(8936002)(86362001)(66476007)(6512007)(4326008)(66556008)(66946007)(508600001)(6486002)(966005)(36756003)(83380400001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L3bMJsFDBGVaDOe+YjcGCAzpk+bBjEHfJdzqdyE6rWjV+owO+0vSAVBPxjcI?=
 =?us-ascii?Q?rubGf5GtxcSAVbf+7XT97hO+Hviz3knwhbzk7RguTEbikLVkeGNawhNSzz/2?=
 =?us-ascii?Q?6xIHIKMxMOfvFPlPpW0RFhG89VQRVrIn1hu5UJOnLhV9F97DOaMhRCqQsAHa?=
 =?us-ascii?Q?r6t2mq/quDbzowHEoKmNWaq1kqSxedQiI9h0W5Q4bNdQBbYi6HYW8mKwVjp9?=
 =?us-ascii?Q?jtDb0Ezn3GJ0xMPpwZNrm+oP1dleLTnqqu/vqHp6aAyeC3FzwmYpT7flWcvx?=
 =?us-ascii?Q?3JcISu3qEEqDlwLIvbNfFDPVGFNUMO17x84ho8QnRz0+VVE5PTy1u4NMTIQ7?=
 =?us-ascii?Q?d4WwQyCz5uJd2PbWM263kcAX4Sb+fPF6OoTdkwaYvYchLvY91JyUcJ4r5IxA?=
 =?us-ascii?Q?v5ySCcyQa6+pECV/i1Fdcj/TlXr+EQfys6VU8kdAMy89jbquI/jrOgwRBp77?=
 =?us-ascii?Q?Csbcwt0ZyRfsOX5GjcE+AyCf/lft7knSn3W5FXbB2UgRxBRGa3XOBlwCgSzA?=
 =?us-ascii?Q?MfCOiF9OiGzEmLf3F5Ob7wWABtdmkn+4vJdcNNYNymxk6xqk7sQTnO1Wn8R2?=
 =?us-ascii?Q?ykLa08gMM2jIpL50K5pPW9dTyLdhdGJq3K8drZPQu9lf0oG4D4clDER39DAu?=
 =?us-ascii?Q?8dZuWcgssbgIKCEQZPZU1dLVfIOHrbrZkqd5vhuO/WNqmJi0ykw3FDZI2aDb?=
 =?us-ascii?Q?FZpJoKU4g0sgrGoe3k86AGtyHcgFoFeD17nkGwGqBnVNKI2NLyGm4Vl3bJPP?=
 =?us-ascii?Q?rNT3zP3lqBem+aJEClYN+Zjz5T8RjpNGrqAfOQMC4sN0m9hQYf0SvwK3wX1H?=
 =?us-ascii?Q?VwmlUAmgNm3mrDb/+dcHxFNb7qUOoTZMoV6UkvfO1pS3TUF5TNSgseQu5bOg?=
 =?us-ascii?Q?i/mEhOitTBIHFzdTnlXq7Z6djUICHA8JvTivxpSiQsiux18ZBCNkXm03bbRw?=
 =?us-ascii?Q?meHnJ1hN9w3eizD9j1h1Kr8NtZIkDCMS5/12uFDkcXW2xBbb98nRYF+Lt1jY?=
 =?us-ascii?Q?snX24zev+QAKLZtZWZrAEXcZNHVeDvxV1h5pMkSKeW4TNlnPBKEgeyTpKqKE?=
 =?us-ascii?Q?nQ9axKpNYNYpZSJeLKUEDSccW0xye6w3mfFdQu/76Gyh7narzyCRm3t6/ePa?=
 =?us-ascii?Q?KvdbXrCQKniyN08vJ1d2Qz1Op4I3zbUbJbosKdLykj12MJujPYtiMcM6Z6NF?=
 =?us-ascii?Q?y+MLE3QJDiDao/N0XdAfTIA4G6xYkGvl6halgudLF+DP9rAwGB9B7d+E9teT?=
 =?us-ascii?Q?9c4U4sIiGxyMHDOQ1qVGO5Y4VHroMMXm7JfdtUGB9k5zInTo+K3rgIux80b9?=
 =?us-ascii?Q?Ycl0J9FICD+gYXh+IxDCAZJ7YEjf0R1Lidn9KmD9nwMiAF/VnMlGEYyN6Eki?=
 =?us-ascii?Q?P7W0GBwf0Mmo8h7IfyvUnMCYQg7Mk5DpaB0W39CHxNCxmJr15llCB8+kZ1OH?=
 =?us-ascii?Q?+uVVODHBbSxK8acBQp6dmZ8Q1ubizEjQjwgu28Qj6vDJA5MIafnNA77DUy4O?=
 =?us-ascii?Q?W765BMEgwXuXnmPehH9mHhEDmdPqkyOQcnDQfx/cSXtxO05zasxIaKbnXF4C?=
 =?us-ascii?Q?o5ITwtEJQ5xNJ9CcinSA43l5a0WHlqOa3IO/UY8wuY4j79ncxt4FmuD6GYzN?=
 =?us-ascii?Q?MP7BEJhimLCju3p49CZwU+c=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bffcd8f-fcd3-447e-d5d0-08d9fdb854bf
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 08:23:59.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVAwrjlod2jobgz6NL5mLANNAIfibddx1keXHO8tXaJGjdFN2QzhOIzeSXQ4LlhazMuDSV4wSW7RH2BF0BFF6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5160
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

fix following coccicheck warning:
tools/testing/selftests/vm/userfaultfd.c:556:23-24:
WARNING this kind of initialization is deprecated

`unsigned long page_nr = *(&page_nr)` has the same form of
uninitialized_var() macro. I remove the redundant assignement. It has
been tested with gcc (Debian 8.3.0-6) 8.3.0.

The patch which removed uninitialized_var() is:
https://lore.kernel.org/all/20121028102007.GA7547@gmail.com/
And there is very few "/* GCC */" comments in the Linux kernel code now.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index fe404398c65a..203c4a2c2109 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -553,7 +553,7 @@ static void continue_range(int ufd, __u64 start, __u64 len)
 static void *locking_thread(void *arg)
 {
 	unsigned long cpu = (unsigned long) arg;
-	unsigned long page_nr = *(&(page_nr)); /* uninitialized warning */
+	unsigned long page_nr;
 	unsigned long long count;
 
 	if (!(bounces & BOUNCE_RANDOM)) {
-- 
2.20.1

