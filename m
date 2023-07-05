Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFC5748446
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 14:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjGEMfg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 08:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGEMff (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 08:35:35 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2113.outbound.protection.outlook.com [40.107.255.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259521713;
        Wed,  5 Jul 2023 05:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LInk5TFWd2wtLQOiokfn4CEbMXTIWtP84BWLnB5KxStWPlI5jpXziZLwguCjJsXz/pSCQFibSNzlT33vWBMO/q5rBJ5ZgANj5atWRtxbHgPElWTx1mkeaa7jwwb8u5BEBcLBdN5f4XtqIJ0HUKqs+XaSc0UP/momHC3bWRmx+OvfEF/OrFlrjv7mOgsEts8Rj5sq227dHb7A8lPwxSqlVL+hoeuLUL3zb2i3GX/6TwKtLXen0fHbDS7PhUHwTRHDjjaHi9HOP2PrEJn6Oid5F+1iBicEOZuKyYaV/yuV/6i0hA3lopqDdC418+8q8ROZiB7TgcjOrVhChbNWsdfMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSf1BwwojgtB5EZCgQ29ZfTWOsXM8XEouxTmdbpiBoY=;
 b=lBvNNWop7ObC2fAmwd2OB40Y/RKgYvlUqeb+FfSvgVtmUXO3MASS0/FzUtlDurNBex+0zb2L4YcUQT8eCnVz4Blz3YjIjwouA9Je/LQSrpf0W/KhVfI3sJgLcLZaBqa6SqsBxkau3FTLbiNJ8duGUBnPtXM9y1eeyWtqWRGKd5JVgzkJBavCRSAB6KA5CxjSQCMROJr4mayXaxPscMQhml3KDhH9DdLL05WznIhNlbMGeDtx+cFRQCBmh3FJ7YhcWJpXzylQmIAD2huY0UZM8/89CvjPF1teMNzEe7yoA1ljNsuT+OOZC7iBjrHFoz+1Oy6qlGp+6P0GbgNeAGHwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSf1BwwojgtB5EZCgQ29ZfTWOsXM8XEouxTmdbpiBoY=;
 b=AqdLUx36a0kmnIw5bsQCK2QdBe0ss0dobv8iH1vgp11VXXm6ObaV2MgYuBuM/RTgN1cVFROAxDeTfKDqtQmcMyZAAmNte0J4bxUWpkl/x6htnJdRi0B90ZKa0bnK4JRARX0BNRgU680I3W7Y8MMhIrCAIFEPLBPRR5Z+XHYiMX2PzrlCDjNPQGM0xRler4r7eoXGkA5MJ7x7U2AENuEGBlkQI5MOP3WUTiayAOtSHgU64Bw3ARQU8msVyhHYgl1X2cWPVxwvp5mMfwsjyS0W9+asEV9GPMlsWFk/naDY6jhJ2PWAPQCuLKgUp++kADCrkyzbG/LEJMVFtaKiJbNbcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18) by KL1PR0601MB5616.apcprd06.prod.outlook.com
 (2603:1096:820:9b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 12:35:23 +0000
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::9531:2f07:fc59:94e]) by PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::9531:2f07:fc59:94e%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 12:35:23 +0000
From:   Wang Ming <machel@vivo.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Wang Ming <machel@vivo.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v1] selftests:bpf:Fix repeated initialization
Date:   Wed,  5 Jul 2023 20:33:57 +0800
Message-Id: <20230705123432.1655-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0118.apcprd02.prod.outlook.com
 (2603:1096:4:92::34) To PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3737:EE_|KL1PR0601MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: c769e6f5-d712-444b-d2ca-08db7d544d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCH0cpI0Gnq4FlksUx8HvGkiAy/tct9D0BAzCN10jr7KHnm1DSVUVp9NSdiSsOojiaK7ZM2ms9cbj0JZYDnZAd0jtjuorinIq0vNtWmdedBuA+Itt/+PeWvTgfHd4Xz8btkg0Kx0bxyTvggDMVLICRsJytx3PanknHDuHWeL9RL0CgWXrMUy7YgVls4iv4VQFIsIAbJIqyN47mqDHkU1QkSQtD3Tgc51B61wr8AcVQy/DWZCg8Ff40fa9PSpJKoEzXlnNMEEWv9EaqwpuqU6rsC3FO9xVi7l2RrmFKq/vUXLCznjAoYeJj//xqV4HAUZzwhUnmZ4wcWH20ywPl4jyMTLO6IqbJiCEeCbbaxBI+5oIb1PwR9TYjiJQTPuauP0Ov+fH8XbL6GlgvGGuB6+bkZdDKw1pIqlIA4k2vv8GuHvAYH2SMxpR4JsuichUfun7FHmlDitoKw3jRGsgzWl65WHC9gdfXrNqXHOfkbAqLrrQtj/Tu7+iZ8L4L1ayyB3zCXFhTw1HAF967R8LQlm7nJ1HSg8GYE66GG02GUR1O12iE+zFpRfi8/Wz28Jt0EveU3uNEfLCZltLOyBuVk+nQuuTxJOoFrRuo0yI9wdTwbnY7fY1i6l6XxpS4ivDJB3sTdAfyEMgnpY7R7S4DtSfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR0601MB3737.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(66476007)(4326008)(66556008)(66946007)(2616005)(921005)(38350700002)(38100700002)(107886003)(86362001)(186003)(6506007)(26005)(1076003)(83380400001)(6666004)(478600001)(6512007)(52116002)(6486002)(110136005)(36756003)(4744005)(41300700001)(8936002)(8676002)(7416002)(5660300002)(2906002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PRtPWpdqwNthhecCc/YE5as2yQtxORJ9a6QqPjfggA2W1gvmNpCNS8XiPJTn?=
 =?us-ascii?Q?EiwEQ951tIER8Pyfr6slRruRZLrRJ8i02gWA/F9dY1H2KIg2IGhwNqjTTe2B?=
 =?us-ascii?Q?KO/yBHTjPYfIvCrOTaJp30AkS5Ja4//pBSO/n8Q63rwg2gx3i3/y7zpWatYE?=
 =?us-ascii?Q?ejYz8RLX0IU0/Qg6jxy0Mr+en49F0rdHdRbyWF57HAGLg1IjbachKQa58ZPj?=
 =?us-ascii?Q?8dPdULa3OOnMMZmJEBSBt3pZi3fCt5a4ZqEKKY15z/ki0T2NvtRhWX3Dr8o+?=
 =?us-ascii?Q?7zmdPguitME7kxzGU5jXG6ykVPl3/vG9HuUuyKOVG2jPx7COZQ1mQ2yZ7YcL?=
 =?us-ascii?Q?4VVfsFQYxGn0g66mLvNo46lVvkHV+L/effTzywbDQ+2SD6fFRRxLjTmzRogT?=
 =?us-ascii?Q?oiSf8CWdigTxi4vrL0Mn/wPMC1YwgxkV46oNF/tew8QBWf+Hs5Rmtw+Y+Cin?=
 =?us-ascii?Q?T4injlDH5Kd+1n7RHmrB/g66wPYxHasBbxlcJtwKYzscYrqfRB14P1tm1n/o?=
 =?us-ascii?Q?TZvinaPoaKdnBoMrsi7TSKqyRlaZ2G0zfKIAanAfy5EYP4GgDPBe3kMYLJNJ?=
 =?us-ascii?Q?oKleSoOTTv6tHEyVCtPmYaUNm096rp4cirrLjzF+5AIpEuK5qpMbSpK11sV1?=
 =?us-ascii?Q?+IF/tUyI/WwyuKVSzmVBtNtOy1GW/miYqs4duVGsVlHA1WyuexOa/pE8FV36?=
 =?us-ascii?Q?gFaXmX7VMAYEYlhgpcbBd8zYwJJr501tjyZDoiwYECTH9yF2shFQjKRemq3n?=
 =?us-ascii?Q?Grf95ZwXpK9W5sxbYD/Yu2meJaYBGgYD81Rgwl84hWlXFBfGdy8Cx3ZDkeu0?=
 =?us-ascii?Q?k35xZ+WTKh7pnRe4JUQ4GRjrO+YeXYmsgMELXVBiZ8ppco76MqI/+/yq7A5c?=
 =?us-ascii?Q?U+l0Oc85OD7UeLsE5U1SW4O1ExRhsjSZAGQrOQDJ93h9m283z92RZfI4kuA5?=
 =?us-ascii?Q?/DAtnVSfNGzfej65OBPhzSIHTrZaSLT6rTBdU4ltA/MLcMLlcTk7xM+a2YGU?=
 =?us-ascii?Q?mtikbrbMZPK8dkObN5++c6+ZxbiflP6jDoFy4in7LIjtRR1lN7zdRunIH4bS?=
 =?us-ascii?Q?OmBMDxok5EQYWcD76qsNKZLYyXKU/ldUTb4mSajiTHCJ1m/TFXGNCPykkoOu?=
 =?us-ascii?Q?sX6aGXQLjM7pBEozny5TOocpr2WL8ooK4BNr8hd4kiXri1yQUv+MM2hJAuJ3?=
 =?us-ascii?Q?5qaZT1Lie7ba42ncLaCz4mJLszcotBVz89gWfjZ2cm3OIXW8QAcrrrfrK1zi?=
 =?us-ascii?Q?mgII2ZYd8LoxBT9ZeB74ALNT/oIW9Uvmkw1xfhktOlLFFNQ4MfttRcEqTW/f?=
 =?us-ascii?Q?V0mG+bkESZbknXGBuKQ6853o1v2EmWj0VGN2YYVevby6CtzM5OdA7Lp5nrTu?=
 =?us-ascii?Q?KPadBpgnjM0HZ5UjjGvqDEvQPQFTdTNbSUChXgyDZqV1vhplCIIXkFS7a0yk?=
 =?us-ascii?Q?9pMZhZijr6IkPXVjn6JD3+zJsA5ZYA/RM893hiWGHVMRZb+IkMDxdpdY+GmQ?=
 =?us-ascii?Q?nVUWqfHqzwEqwlJFpkabLorY47Yy/HQnNPuvXM+Oolog20M5293sGGQbnERp?=
 =?us-ascii?Q?fmbKuvRRw1viSeuLbDhtdiBVybKZjtbX/BITr3Od?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c769e6f5-d712-444b-d2ca-08db7d544d30
X-MS-Exchange-CrossTenant-AuthSource: PS1PR0601MB3737.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 12:35:23.0769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCcht/UgTtl5WeORJlKaTRo5/DcknxxseGTbQjawZrC8et4sH1GVNKy4WBnag8nrj4b5op6iYeEewey8U7Lqxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5616
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In use_missing_map function, value is
initialized twice.There is no
connection between the two assignment.
This patch could fix this bug.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 tools/testing/selftests/bpf/progs/test_log_fixup.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_log_fixup.c b/tools/testing/selftests/bpf/progs/test_log_fixup.c
index 1bd48feaaa42..1c49b2f9be6c 100644
--- a/tools/testing/selftests/bpf/progs/test_log_fixup.c
+++ b/tools/testing/selftests/bpf/progs/test_log_fixup.c
@@ -52,13 +52,9 @@ struct {
 SEC("?raw_tp/sys_enter")
 int use_missing_map(const void *ctx)
 {
-	int zero = 0, *value;
+	int zero = 0;
 
-	value = bpf_map_lookup_elem(&existing_map, &zero);
-
-	value = bpf_map_lookup_elem(&missing_map, &zero);
-
-	return value != NULL;
+	return bpf_map_lookup_elem(&missing_map, &zero) != NULL;
 }
 
 extern int bpf_nonexistent_kfunc(void) __ksym __weak;
-- 
2.25.1

