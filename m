Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FDE7DA52B
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Oct 2023 07:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjJ1FY7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Oct 2023 01:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjJ1FY6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 28 Oct 2023 01:24:58 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2072.outbound.protection.outlook.com [40.92.64.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25E510A;
        Fri, 27 Oct 2023 22:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXizZaTk2Srjz0Cjq/+4DOUvRDbf+3ZpfucdkyMmCx7msw05mFWxrik2IUUHYLmPaS0QX74WsaBHu9SmtQ2AfC0RJE5Lm8L0+8L9j0FXh81GEqsJDWcLXDWAGvKpHyinXm7IgjueaMXGzHJzOwoqx9CBh6zNiimrpOpaO5L+qAG51/14ty28wQPX7/ntX499axG1ki2EVlW8myfZ/QF/9xVy/QGrAsFouhJnW7E9f6vrvThePbbyluwe52xMHQxSTN+GFsAlg50amj1qP4S3G83R7T1GuXqbON7F5ITx/P9bUqyhu4weC16BrYEf4/mOI9nHr8HEF0d2L10q7G2yig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rw6P+LHilR4Y99GgX+aeXJgX90gEoaf5TE1qZjFpVSs=;
 b=QiHc/Ol2nh1NowvmkThn2u9wdpjt1hlwS0GL2oimXZSdw6CL2iDqP5RCDri5yDdzp4YMthQkHc8iFYY1FXvrATxzt3aq92CqM6EPdRfgjho50LtYzUeisazU2uqZPROnoPlDKzJlv7wBwjL4r0W1u0hxwmM5AOgWSwJVz5qu6qj7Ybk8wKuCrRrISpOERjbMZUmAUYkEc9Yywpl4INxuH8igv0n+PbnEh8DTGFhN5KUsxSfk333E7Xkv5gwSoBq4oxNhyMOpD+Jp84tiDQqsAJgKODAxU3y3/2Ioku6Xiy0mIDk+yNFydZxCJ++bu4SIDNrflx8ycvh+qwUJsLodMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rw6P+LHilR4Y99GgX+aeXJgX90gEoaf5TE1qZjFpVSs=;
 b=FdEvXdxHsEWOgmv73Sj3TAmSwJHj89O2KIDBHd6vY/B9uLxEyNCT8XdgsQjs7fg2bI9yvfKOMgOI56ch2y0vxth2nrYIHOwA25LUujiIUTiiUL8hSjz626zkWvMH2IewvPQBiRpzm32HENWdi08WysOu1xxQZr1SYDELPyqjGY4bp0kvijIsvnDVXHWomJ+qu2vFCtNS96eES9q15rkLmV0QAeVmJRCcC6AFi+cs0k8SluKAIaljEl7fLoTdxIfm28lzaIO6FKE/UkY5WczWC+W9KeYW6WLf4UzbyOm2y2bwBOLS0LLQdaT9HtQTYz39ithlDMd4g4DpIjzEnAeu5Q==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by DU0PR10MB6367.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Sat, 28 Oct
 2023 05:24:53 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6933.024; Sat, 28 Oct 2023
 05:24:53 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     bpf@vger.kernel.org, yonghong.song@linux.dev
Cc:     sinquersw@gmail.com, ast@kernel.org, brauner@kernel.org,
        daniel@iogearbox.net, haoluo@google.com, iii@linux.ibm.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        kuifeng@meta.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mykolal@fb.com, sdf@google.com,
        shuah@kernel.org, song@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Yuran Pereira <yuran.pereira@hotmail.com>
Subject: [PATCH bpf-next v3 0/2] selftests/bpf: Replaces CHECK macros and adds malloc failure checks to bpf_iter
Date:   Sat, 28 Oct 2023 10:54:12 +0530
Message-ID: <DB3PR10MB683535836CE7B90591B4FFC0E8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1698461732.git.yuran.pereira@hotmail.com>
References: <cover.1698461732.git.yuran.pereira@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [fhPuDa48xHBPgbbBLUj7T2oFxcpODZLj]
X-ClientProxiedBy: JN3P275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::6)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <cover.1698461732.git.yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|DU0PR10MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 8026327b-6a6c-4083-9daf-08dbd7763709
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/OlTyqwCt4mgP1coErEQg5/TFeNBRCoSuDPtY0PWVEwvG4qnTdfsjYlhLsT//wqHyU4j/0BuJVz5ErThLtdzbMCfpH+VpRh+Y5oPCTFXC0ImHdzTzdiaFH521S063A9GLjvS3jdAYpiB6dY0IzYrKvv9/jJ5kI2Sx43K8SloOH9K7e6ok9Np6yHzGQ2BTc/3SfXhjEjVt5dwaBeYm23WEJLuPg/L4r2rjvl/DKfLoe0Btafz2fPSPf113f6guMtsknNghbZPHBqo9zCBRixm7W/Vc7gETDK3Vv+24Bn2I+aEEZ11Ar9i032cV4XU6UmH3cghbsrgJPsDjkNRN5TEWm6KV6akuE1z6E71XSKbciu8vpVcMxZb1mbMat73CBj0oZzp71j0XvTYSY1SiqkbBoftzr4N8mReSvv+nRtFiPcSoOeNuW4avXo2TWtLUxHIQWwXfcY6+D9x3U9ZGb/Mzggx/k1igoSp4QXa+RpMtRRdNDZcBOONyvPPJu+38prKXYRPMG+i8vMAo6iGam6G0OCJw99EHaSpJu3B0nAo55JFH4046oA1nfcUQMr5eZX+7UWIdDB1wi/rpH9h7XXP98DMs9yKaAWp2cfsYc5uwN6s1C3JchpKyd4PUmSD5eyaBngvqr+dg4eo/xx0U7dJhUroTiXlgTsueHt6u3oIqw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?93pDYxgmSzT4auK8M+0tTRTiSc7C8egxig/ybcbZxqemR3C4b/Js1N4vJQxi?=
 =?us-ascii?Q?yHlPLGkI2q4cYCKkqBIFtYlc1hmvqAxXaUYcwjqb0FagFIu8iifdyHH+xHOW?=
 =?us-ascii?Q?nRNrUgOUHD2OGurckwBWtYDmRHuSBCI+xVFf2g4y0mwdNAQvJjC5XHYXuNv4?=
 =?us-ascii?Q?ouuKpfqchbBflbZI7p+R6ExQVgUOJWwRO4UEXctBIIBgYXm+ydD+PxjuyNXj?=
 =?us-ascii?Q?y0VgkZdkTNAzYl85WJjpZBeI1vyjd2PiiP/K995joP6+d+l1VyCu5S0i+64V?=
 =?us-ascii?Q?0UKzdiCLDX90UJjhrSPJUWXaaimSgP9D6QZP1W399B6G/3b+uiHPAR12J/XU?=
 =?us-ascii?Q?PreJWl4tYsCe/2SNB6lyoXjp6ztw04k/pIL7C0vngIsUdTrEWHx5qWy9dwQj?=
 =?us-ascii?Q?kMcMQ8p9LK2RKtRMZbQ8rBGC8HivWx6iqSqKPpJAIQwQVDRLX2+jTipJ37Cj?=
 =?us-ascii?Q?Sxcap56bAYy3oEjdgVQPQY0F33sepKeTF4RoWK3MPfuiwtPv3SFGPaleT+pW?=
 =?us-ascii?Q?rB7hOPV1YHhG53i7t295LAn9L9AQgoGDLk9OXOlUOhm/uqwxd6rB5ED5uQ4d?=
 =?us-ascii?Q?boT9yCoEj60/y09xagrzTcfxNOgYFa8NkkzoNCgVNSLLavMyT8Lg1tXydSu1?=
 =?us-ascii?Q?B89xkn5XRShz78XWe0QKZGbbC3CY2kMqFM/qOHvCfyO5wCJQHWIVvjZOmnMW?=
 =?us-ascii?Q?Af+CC+oIwOOIdznkBOjLjvjBDhvLffa7Mt+83R6EnjDM/zivTzTdVcrc0HfE?=
 =?us-ascii?Q?nVD1RsvhIO8ToWTEBtXwU9KFpbKGT2qGAP0Z8sXAJtT06TWrQY8EXuHOiBhW?=
 =?us-ascii?Q?YApnaClAuW6STOIM1FVuPmqvYU2Z0IPhMYP2fhM816RjDmZcOMOwTZt/MBEG?=
 =?us-ascii?Q?E4dVS+ia0wKuVus3locZMhxfIocu2U8gHcfTukXvrO2CxzJqmE/GDAlEOqKo?=
 =?us-ascii?Q?uILB1awmwjEDbNNRqUYvbm6ht+uoS1ajviTbUE3sAwuSc50tAX4+FZgjaVQ0?=
 =?us-ascii?Q?QDRUK/Hl9z9QEjoYp7gGNEaCUCPIp86+0ScRi9mfjb7OJHAEdulHLokDctIB?=
 =?us-ascii?Q?Z/d8wfA5Mi4xzcbzrASkV+qrNikC2rfk37VCNpFiUKPiMrsPxzSrjcNEs50u?=
 =?us-ascii?Q?qd3PVLIstWXEqtfoVtqnKWp39budQMYVsadfcLz+aYrPG4Ut3LanhsGIAlod?=
 =?us-ascii?Q?y/TBS32favrnOkubk8HNujs6R5Da0o/4urb/pgEwL8mJWUHb0GQGuHQ7X9U?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8026327b-6a6c-4083-9daf-08dbd7763709
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 05:24:53.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6367
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series contains the following updates:
- Replaces the usage of all the CHECK macros in bpf_iter
  to the appropriate ASSERT_* macro calls
- Adds appropriate malloc failure checks to bpf_iter

Changes in v3:
- Modified and removed unnecessary `if` statements as suggested by
  Kui-Feng [1]

Changes in v2:
- Removed unused "duration" variable which caused compilation error
  as reported by Yonghong Song [2]
- Improved malloc failure handling as suggested by Kui-Feng Lee [3]
- Ensured propper patch formatting (i.e. sending it as a set instead
  of two distinct patches)

[1] https://lore.kernel.org/lkml/3739e65c-b86d-4c11-9cf5-7b76080400c2@gmail.com/
[2] https://lore.kernel.org/lkml/3531360b-c933-4c5f-a84c-17edf0592519@linux.dev/
[3] https://lore.kernel.org/lkml/7d703c4c-1a24-4806-a483-c02efb666059@gmail.com


Previous versions:
v2 - https://lore.kernel.org/lkml/DB3PR10MB6835598B901975BEAEBA8601E8DDA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
   - https://lore.kernel.org/lkml/DB3PR10MB68352B683F26EE9C342B71A9E8DDA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM

v1 - https://lore.kernel.org/lkml/DB3PR10MB683589A5F705C6CA5BE0D325E8DFA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
   - https://lore.kernel.org/lkml/DB3PR10MB68356D7CDF6005480BE5876CE8DEA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM


Yuran Pereira (2):
  selftests/bpf: Convert CHECK macros to ASSERT_* macros in bpf_iter
  selftests/bpf: Add malloc failure checks in bpf_iter

 .../selftests/bpf/prog_tests/bpf_iter.c       | 85 +++++++++----------
 1 file changed, 40 insertions(+), 45 deletions(-)

-- 
2.25.1

