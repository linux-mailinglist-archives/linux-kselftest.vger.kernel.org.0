Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84979506295
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 05:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbiDSD2N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Apr 2022 23:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiDSD2L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Apr 2022 23:28:11 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2105.outbound.protection.outlook.com [40.107.117.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36FA286CA;
        Mon, 18 Apr 2022 20:25:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2sGkS+QYJJuNajI+qsHsO/APeKo6oIwzWe7Qhvbb24JJoi0aY7JhNPnpMWisYMatHFqIVSlwbuqI3HPSLzb4Py9YkYMWxqNLiPIIj5G88vbqC2Ek3sko6bDXar8pHgKQgRH665mGGLVTIAywrL5FWwS5MD7oQdNhLIPdL8ph3yYGPRPdFYPvZ1PacVJzdWvIEbkYJ81q7MzsZhbiLB0TZjPSr/98dYDuecIMCu/mTwBg2CL6GddhzCMTpTGkQli8A02yXVvt/1K2nAOJqCpglGYh7KV7GwQWzppNq5kg7yJKtOA019e68d6U0MS2nkX1YcyPaUJswzgicf4sz/Iyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lxH/MTX0jNaks6JGMCdLi/Geb1bRYgZzsHee2ToAWY=;
 b=BTm64zQ27DWnXl4V2ZBc/DLJB7wNNNH4E9THuQuk9otuhfF9g1iIGDAVUhKNMw11FXRJzptgzG7C1GQ5nHNQwZ0yYUbdCFjKD4RiC/wKweu8Ab8ibwghy05QffwDN9MaHqiTF6afASLzz59hknWAga2HB1X+zo81VBRxpQQzCixuMqXa7rtI2Jk95WHVDDUT9F4l/oJdr8Ryaa3Ic5Ft3J7Su9UPCQ3xckImMNjaoTOIS9jLbqwn8Ao9cjCwP8zKDe1U/O+/bUCfKu5t2P/fZpBwSUuEYHfGHjugmgaIAOW6zAxvEc160sP6RAAwRgtjk53U7uGLS4agnxpGRavkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lxH/MTX0jNaks6JGMCdLi/Geb1bRYgZzsHee2ToAWY=;
 b=iyRbwmiWla5xz3XiLNoUhY0HFhtutwlW6N+XGHbTNBWdQjASRJ8p8SWVqRqPKAVJ0kwF4D5IKQcPBSXCCMeVmL9hNcTUpXjT1rnrnXYLpQVwLMqWczei6Ow1PjWTgbD7t7/eVrsWMv/+vUotOjNNoLbgR1awTmy+HA1rcqbebrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by PS2PR06MB3350.apcprd06.prod.outlook.com (2603:1096:300:5e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.19; Tue, 19 Apr
 2022 03:25:26 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::5aa:dfff:8ca7:ae33]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::5aa:dfff:8ca7:ae33%6]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 03:25:25 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com
Subject: [PATCH] kselftest/arm64: fix array_size.cocci warning
Date:   Tue, 19 Apr 2022 11:24:51 +0800
Message-Id: <20220419032501.22790-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::33) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a987c1a1-71fa-4ab3-52c5-08da21b43e75
X-MS-TrafficTypeDiagnostic: PS2PR06MB3350:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB3350A51B2DF3C9151E35A1B1C7F29@PS2PR06MB3350.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0b1+15DyLsLMr00HMVxlQ+O4VZ2CmIJ9gzemH+PgpVGRP7H3hhdGVnToHQPBtix/OGaftxq+OlEq4S+v0W+6jyrgett1W7miURzhFd/H93RIuk8k8bKFucJaTp4htCda8rzc8/aX78KQsezTANARHz3Oo4u5WvWhk0FEB+rHkBqGGvq4mIJx+MS7/EsYknbWIfHvVp+taDJAfdvntJgZ9Zz/dSdFWbjzSgwe8Omyf3ISahx2dc+ig/vXCjdewIXodY74u2uIkjfxSrwvTAGpRS1+AaNrVu72TNPwaMRDg1kWs7sXDtYQw/huHBQq7zoorrW2WLDz5t55x913QA+eKz9v5I+nlC/IvStc60tiCHH1spTx8rGXOE2zSB3/YVhd8Ons21E/ptyE+FzpSNS8PaHsS92OflETmHfcr720FW014HvpWQX6co1dIBAjLM95f50qDEaPXcZ6aGahq64S+uyY+ck7mt4gQvAhhrtVS3sxAJELoa6EwzVkjTnetna08xjm62CSxKbPXzbI6lZ1S2Uj7jbC9pFvPWRb+kKB1YlYlvDhzpXKWsDqw90C0nKn30MuyiCZR13SZGU54oXhEnlG7XrlkXxLiFqvz2HfiXJg5zGYgZDcxhdgSXU3orQU2h156IprFe9UWH6ieI6KAuLVX2FVL381St6D/cwNNAgPOnjmdkGyiRJ8k/sVtSxGGY5BS5ra0zHFmAkw+47Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(2906002)(6486002)(86362001)(38100700002)(38350700002)(66556008)(66946007)(8676002)(4326008)(66476007)(316002)(110136005)(5660300002)(2616005)(52116002)(1076003)(8936002)(6512007)(186003)(6666004)(83380400001)(36756003)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rt+JLI2CT5Pn2erErDJiAjuGWBz0AaCwpxh6ifk+ruYqLNm6u+UB65hrVuNn?=
 =?us-ascii?Q?yc85TH/sYQxwd2au57PE/0B2gQ50Yt3Vnm6jFqukfEJ48b/dfxRg8M22lLEm?=
 =?us-ascii?Q?LcjJV9pU76vZt94EVLSeNbPskKi0dSgPwMkBfLM57mZmPCCTOR7nzOiFTlpq?=
 =?us-ascii?Q?tARBHjkRF2nYEf4uHK16HO5Rmkj/RxGah6yIX2gyVesn3e2LNhBZ6zsFK33L?=
 =?us-ascii?Q?d7o80Uk4LzKXp84IuC/ykJcxC9K0aENfX0QhC/3ssxXaPGi+DSsZPQeOSPAZ?=
 =?us-ascii?Q?/h+lBrmcpattYtVj6JcddMDgsa1dmu4RMtBll+SnRJQ+re1lF3gXEdbzRvGZ?=
 =?us-ascii?Q?mHnzjkG2JfobUHjYsLfm71illX31b/62xE/kkUuV6w6LtUBz/a1dR/3VaYR/?=
 =?us-ascii?Q?Q+2qxjhbNccMQ9tiV37kOyPwTS749dngS+qk5tEgpm7U30t3vuhYkuhywPE6?=
 =?us-ascii?Q?JAf0QpM/yUfPqW64rbw7XzD7yj4E1uk30aqm6lPd1cuQ2qi9ScgCwmOvY2ud?=
 =?us-ascii?Q?gtj0PvGTGNRuOuCwWX+EfYcR6jy3cqPTKvgGize9cQ1CcztEuYoAPY4o0cQW?=
 =?us-ascii?Q?aMnqnLxUhTgF7nCmbAzFhROtxaLcA1RXKxnFWlbkEgheKJzi7TBBK7t659l0?=
 =?us-ascii?Q?1X0Yv5+X+b4fekUkpyR5dKugqCm9JqZ6dcWk0e1Uehd6dUqu+HKiULSyaxTU?=
 =?us-ascii?Q?pv7HeZseOzpw7m2mtAn7KRmSKICqPALFf8ryvtroOZkg5Lp7B2I6OofIuDtu?=
 =?us-ascii?Q?o6gdC9oJtwwmMaVieNBzmblYURCU+a4TEpzd9Bnnl0NaQnNtBMN0DWSR4Zeb?=
 =?us-ascii?Q?GOAJIK3he4vRg1+YFLQknUu7E0QPSnnANSRWALgtLpLdAwT6u+1My34rAFyj?=
 =?us-ascii?Q?sIdHSY5SGOMD6Cm85diSp3SDtaBvLKQWHxC8DkMy2C6lr03/0DUKqI/u9Mkr?=
 =?us-ascii?Q?fMzYED/8DRN4DRSD28A8oEiM0zC6Yhru/i1JWFG6V0lD+uLeb8pKViw2RRP8?=
 =?us-ascii?Q?oat3SQUOqFW7pg76gD4AWFSor5LF83/3pfnCc0sgnX+vZBMn7W25UVPr0xuy?=
 =?us-ascii?Q?mPvFgGe3hAkStbS/GOf2Lu1Y+g6YOpOVmsEOdbjR+hxI+wxNCgaTu8RxlhVv?=
 =?us-ascii?Q?vavfktOrOB5RiLcaUHpxCORAia1yVeIdyCP6N/waHSp2uSCNmNauAQuw3Aai?=
 =?us-ascii?Q?tPaktMEC3eY18mrd+w8yR/1/SanBoJoRKkT5xO55QPvv6TnkstfKRm3K7r+d?=
 =?us-ascii?Q?3VitkKcOsVX+X1JKPkRpbgAAYeILVrOpDfkKtFKyzL3EL1I0JLLFbfIR6fsy?=
 =?us-ascii?Q?rrnIWGeNdgCPuzsAHtzYda5krfBL1SF3jqZiQxObMvWGuOITu8bPgTC93rnJ?=
 =?us-ascii?Q?XG3c8i2UaUEd8r6eqwOGPaJxuIkeGWjjgWOptF6qLqltc9qSAqH6c44zwZdd?=
 =?us-ascii?Q?0f/QGmomPJMUEBN9bvXzgiCFeek2cSyqumw8/AMS8eW59MxSGDNcy5C/b/fs?=
 =?us-ascii?Q?V7Qkp5E7lksugQIBkXgXAnqHiuXO1BEzgzfP4fSDYpMLfo+aD6C6uc+v+L1H?=
 =?us-ascii?Q?C0RlfpwpufZInaOLWSJr5P3JfKeOVQUL9ErzAaiBXTVVn2A3sIeUpASiE3b8?=
 =?us-ascii?Q?PlkK6Yar6NPBeP0Atdu0b1xE49R9FV1+gkx+KzGb12f4iBvXae3KB8TILsrU?=
 =?us-ascii?Q?LYgCUOxeBq81wDGvVAhX7MozxNyFZMLEfB5XsJ42UkIaj13ha9EXVmSFvXca?=
 =?us-ascii?Q?9oPDVF3JnQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a987c1a1-71fa-4ab3-52c5-08da21b43e75
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 03:25:25.6271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QoT+knuIUsDNKo0grs7Yax/onR9qcNkyS3bQGwtSBr5P61DsU42jZGLd2zlk6U+TJfKEtrKCnarwlRP9Z188Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3350
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following coccicheck warnings:
tools/testing/selftests/arm64/mte/check_child_memory.c:110:25-26:
WARNING: Use ARRAY_SIZE
tools/testing/selftests/arm64/mte/check_child_memory.c:88:24-25:
WARNING: Use ARRAY_SIZE
tools/testing/selftests/arm64/mte/check_child_memory.c:90:20-21:
WARNING: Use ARRAY_SIZE
tools/testing/selftests/arm64/mte/check_child_memory.c:147:24-25:
WARNING: Use ARRAY_SIZE

`ARRAY_SIZE` macro is defined in tools/testing/selftests/kselftest.h.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 tools/testing/selftests/arm64/mte/check_child_memory.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_child_memory.c b/tools/testing/selftests/arm64/mte/check_child_memory.c
index 43bd94f853ba..7597fc632cad 100644
--- a/tools/testing/selftests/arm64/mte/check_child_memory.c
+++ b/tools/testing/selftests/arm64/mte/check_child_memory.c
@@ -85,9 +85,9 @@ static int check_child_memory_mapping(int mem_type, int mode, int mapping)
 {
 	char *ptr;
 	int run, result;
-	int item = sizeof(sizes)/sizeof(int);
+	int item = ARRAY_SIZE(sizes);
 
-	item = sizeof(sizes)/sizeof(int);
+	item = ARRAY_SIZE(sizes);
 	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
 	for (run = 0; run < item; run++) {
 		ptr = (char *)mte_allocate_memory_tag_range(sizes[run], mem_type, mapping,
@@ -107,7 +107,7 @@ static int check_child_file_mapping(int mem_type, int mode, int mapping)
 {
 	char *ptr, *map_ptr;
 	int run, fd, map_size, result = KSFT_PASS;
-	int total = sizeof(sizes)/sizeof(int);
+	int total = ARRAY_SIZE(sizes);
 
 	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
 	for (run = 0; run < total; run++) {
@@ -144,7 +144,7 @@ static int check_child_file_mapping(int mem_type, int mode, int mapping)
 int main(int argc, char *argv[])
 {
 	int err;
-	int item = sizeof(sizes)/sizeof(int);
+	int item = ARRAY_SIZE(sizes);
 
 	page_size = getpagesize();
 	if (!page_size) {
-- 
2.20.1

