Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8A14F96DD
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 15:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiDHNip (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 09:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiDHNio (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 09:38:44 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14AD1DF850
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1649424999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tlxIOHtAN/TwcqxBd9NUAqYjDhRKf8AmmPp1TVtAmVo=;
        b=IKdcxpOz1DyHa/CeTgqzVboScxL1jmFTTaFgp2/2558DTmPAUJ5LeddYTLkzR4680QF9Hk
        jfM+knjOFw1rXTTahbuA+WJckLU2ddPL+QoIrVwPRmbp+Ig70jZpAWLrxS5idrypRO0TG9
        NSGvmHQiB172ezax7uGJJsHcTW9ksTI=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-W6Bp9XJlPxikTONmP6GMig-1; Fri, 08 Apr 2022 15:36:33 +0200
X-MC-Unique: W6Bp9XJlPxikTONmP6GMig-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpT4Kv0Br+fXm+yfc078qhu8ZCdD0VAtjBYtGzzMMFsZ3+2MORvWSIEWVnmwBcuSBLS+HIew+Zp3J6zVv/M+0G5PoU8bOTJ8bgHw8Krq0UXAzfdHr75/nik8Fd8ysdzg2pGcVUppKcgIStTng5OpXc/DHZQL2pnamZZAprJl525uZFT57d8DErkMKRnzeLd/3UWu1Cv3tr8rmein/EF4tTE9nZGQQLq1bzL7cIzsc6VST48psB+1kDde5qKpnAJ+/je/IT0NBuwTjk62Au1vd7Z2X9cDvYZ08DofFyYm3S8KukTx+JdR6v8dar0H1MxL1SRC0NfI/rdiiaEn8ULPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9vI8VJ4yC5Z8TvyYDjRUJlglc6DEkr4mOvob4RcWeg=;
 b=O7E09N8Ytb06FU4/+wopJlOV0FqcW3RC/tfdMYhm8PD9zkcyThq1aUieu2NzAWdV5GSNnZRcTPQrD74q2qIfLTsttyuWgUSJZcbMvcWllUYQQGoyLghoQYVgAFP+saOA22QBmmRaJYmykhXvZiFNrdyb312mMk6pK6NJKnXwdtoBrw6yAijxcZ1IsU39NzH5gK9UcanGLc6O07FeA593rGuxotvCAFsD9rJo0LK+lNo+egJ1KKlPfgDzD8wJATSbJ5aatCNRUhsGNCaEQzqmAnvj8DBXDPLV6D39r5QYXf0eShohVo5JrIEa9qyOPsmq1EK3wfU82yCUVPoOvGwYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7766.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 13:36:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 13:36:32 +0000
From:   Geliang Tang <geliang.tang@suse.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
CC:     Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/2] selftests: mqueue: drop duplicate min definition
Date:   Fri,  8 Apr 2022 21:36:24 +0800
Message-ID: <36201289cc9281ea7653127b0008ba01a1c14290.1649424565.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649424565.git.geliang.tang@suse.com>
References: <cover.1649424565.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0014.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d219f4f6-360c-434a-10bb-08da1964cb12
X-MS-TrafficTypeDiagnostic: AS8PR04MB7766:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB7766E07D01CFB6D810B3F24AF8E99@AS8PR04MB7766.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uThhfdjZwoXiZD4vofp6WzQhc4VgALfbFRSewbk8htjFnXci5WiYU/GsqAwyKTVQx+WmLDuGXzXiQLLOgctJnM8koyYcaOuhIhKhve/n21ea5/5Xn2DRVF9YyCKTV5kS3GnJqd17GGNyibfRswAbztD6EmNUu4nZ3l0h7Orqe8n7GCap255WX8QwyHzcISYoNGRvm8zVergwqY57mOOWqpDFPhlCZhwRKyaTizmK99DEkXEk2laPvcRlCLdqAnioR8tWMWi2YUtWz/8sBrqBzA8osRATEvLVYeSZReFRPQ52IICd9c8sk056fTbUewQWqWrfQvStcxCyKavP5etIgi0ow+nIVaL+WFKKLsZ90sYfuDjfM2JGdBtybn2b0vZKSQNYEr4oWY8/RjXiGelOOA5Ya1tIse4KNOPIBQMPAAQMQ7LP/xEoJegc2ePn2e0SgIkJAL1um2jLRuuDNDNyl1jpGqw7+SFK71ysx8mfwsDEroKy8IpewWUgcH3feYGKumtkArJ56jxMxB+lr82dxAjVczf7SenTxwE+90vvdqtnNVMZqB/9awJmpkckIq1oPHicvNA0bgK9elZnawLISgpEIuoox357GYkVZFlecrXnScuzPxK2/UF/qKfBLEsnA6f3+a7yB4CWZpUsu8JRSIsIuqQNpCX5aoFNnAICEtnBtDmANZq2bHsy6IiB0TsH3pqp/8uJDQ7o6tRhqkU1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(4326008)(8676002)(66946007)(66556008)(66476007)(5660300002)(7416002)(26005)(316002)(110136005)(36756003)(508600001)(186003)(6486002)(2616005)(6666004)(6512007)(6506007)(2906002)(8936002)(86362001)(44832011)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2f3/1Sboez7y5ehOOqy09KO0kzHh6gBJvnejMcXudyAhTJnxOBbyYLXO3kaU?=
 =?us-ascii?Q?VM8MxRU0vcs7LJSXJ+48pQZlLV7cGaKtJz5DV2DmzUums739CjBtIqHlKYay?=
 =?us-ascii?Q?euNkLhX0FDx/dlGkA8z+fZTQ6kOQk0GhAIlxNC2yiNGUWDbHXAI9wt6zX+uG?=
 =?us-ascii?Q?VHCdbzO/UDfCBdZocvlUv3m8+8vBGz1paHAIP990qyhzEAld3I18rnE6OTvq?=
 =?us-ascii?Q?/hlQ8MLu4esWyk8gcDoi5Ow+N9VgMn4tI0WPMX/ksXtVoS9o2sstZ/o/cQWV?=
 =?us-ascii?Q?t281AAgM9buK2xyhkOnvnAYxgRyYDhIJWxfsmWMIqxdTgAITk0MQjDA8dZnQ?=
 =?us-ascii?Q?iX9DaCeyM3iefSVrnAVZI1u09O8JgaVUlFTckaB0kssvibNd9DE2o9KL4PSj?=
 =?us-ascii?Q?VBYr55CCkntQKfYbuPUaRkxDEYu7TvCIc1qzHnOHyO2Q5g3Ysy3dJZIgwM0+?=
 =?us-ascii?Q?tvTtdbG6wlI6embYPXaWcIo1Yo6wMoHCCdmmK1YczDRgxpJUnUCZQpWJohlO?=
 =?us-ascii?Q?jT6+qALVMhbtIdUNLv5tw6avcdX/Leb294OYHkOVg5qFnFKYDkSXBJ5upZRA?=
 =?us-ascii?Q?3WD7G2abGxYZNOGfLMchL+60PqoWSXZfz+XApvlNhS4HADgPD+fAOT/Kw4/B?=
 =?us-ascii?Q?r51uFsfocbHjKdlZlzovIcVlUIV0IFyCjIiWWhCeV8E6u4yojC+I+IBaO13E?=
 =?us-ascii?Q?ye3M6TYnZbnVLUxy5iXL65hk6+CcVKpUt39mWrMh9i7bvs0Rmacca9iOT2No?=
 =?us-ascii?Q?QZoDpvOGdIYewF08SO4o0RplHavZKhcmrK4ZQ74JRP1MFbFLD3ZeoO/jDcGW?=
 =?us-ascii?Q?aogcnYh9wENzeFjQbJ9svIpd/BmelUeFAzufmHSXyarpC5NKzMfCO6NGzWd1?=
 =?us-ascii?Q?kB+7PnomV7yNju+LTXWKcOSwyKDmSik0vIP5NdGUi34+SFKdxtMHJVqSQeHR?=
 =?us-ascii?Q?041lqn7b4iK8jACZPATgilqERED6jor4VZ8nGbcY8hlWLg9CNR2LG9Ot04Li?=
 =?us-ascii?Q?oJ+1RW/NTixVWnFWvbOWy13IRUw/9Fd5WMVnh6KK+PjG0n7I9hWfAlzP11iV?=
 =?us-ascii?Q?qCbQLao8d2GmRbW1NAOr7rFe1IG5YwpZ56n7PAFuZbRGs0PlUGOHPLCu5rve?=
 =?us-ascii?Q?KIID6Pj6L1Svkx7qVXwD2snOROmU39PUe8KPIDn080mZkiMOb1p01yDeCDVs?=
 =?us-ascii?Q?AxWHcMJ1h95+lp1Ki8bFmi9syrLfMmi3eq8K1+/bHLim507wrLwnCULS5XG4?=
 =?us-ascii?Q?Rj12Yz6tiqj44TSz0+ZDfYqJDD6YmX5EnrWRjcobBJyi1F3I8kLuVHeFd/eE?=
 =?us-ascii?Q?i3C8NdB8+SZ2q99dSKS7cjGiSJeDXBRupHKtMmE1Rynx4v17JmqDnLFFeMH+?=
 =?us-ascii?Q?lQwr53OtBxBe+742qkL/sTgZ5xdGhcbjV56HQBqduBB0PD8GNhSLP3qIWTHP?=
 =?us-ascii?Q?729jP5gLX24iEvVsrrbhcGiQhTD8WCuZMaX6Ax1lbac5nQxTT2mzqYjsVTrB?=
 =?us-ascii?Q?RAeGeByWBfzPlUqQlzmy7J3CgFNKSVYIlOmntj0tv1kFLZcWmupr74dwIt3y?=
 =?us-ascii?Q?YTj9qdYXN+QhNUp9FCqkRmDSpPei2jUO5sNdVNO1qdw5qRSD/pNmHdE0wbSW?=
 =?us-ascii?Q?ExdCysnXgnVaFcyGTDx8HGJZkpROlcS6EPbMA7JFBzQ8e3umN52dp5qdBPJ1?=
 =?us-ascii?Q?Pot8JxxT+gvnA9lYRkJvOav0XvrEJ9gXTYJ6WBfnYvgpJBVY0yemEF4ZjzHK?=
 =?us-ascii?Q?AQx5BeQ5l2nlOvvHrmLnv/EG3VogFsA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d219f4f6-360c-434a-10bb-08da1964cb12
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 13:36:32.1354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXMlS+xa5K7v/y3EUp5taRgHWxFQhI10QwF3Z5AYVsOrtHFlXv0JJzXL5KBR6gY1yF7rDqb2WsRjpKIpAPRwkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7766
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Drop duplicate macro min() definition in mq_perf_tests.c, use MIN() in
sys/param.h instead.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/mqueue/mq_perf_tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing=
/selftests/mqueue/mq_perf_tests.c
index b019e0b8221c..6df1b2a7ec88 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -35,6 +35,7 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/stat.h>
+#include <sys/param.h>
 #include <mqueue.h>
 #include <popt.h>
 #include <error.h>
@@ -73,7 +74,6 @@ static char *usage =3D
 char *MAX_MSGS =3D "/proc/sys/fs/mqueue/msg_max";
 char *MAX_MSGSIZE =3D "/proc/sys/fs/mqueue/msgsize_max";
=20
-#define min(a, b) ((a) < (b) ? (a) : (b))
 #define MAX_CPUS 64
 char *cpu_option_string;
 int cpus_to_pin[MAX_CPUS];
@@ -551,7 +551,7 @@ int main(int argc, char *argv[])
 		perror("sysconf(_SC_NPROCESSORS_ONLN)");
 		exit(1);
 	}
-	cpus_online =3D min(MAX_CPUS, sysconf(_SC_NPROCESSORS_ONLN));
+	cpus_online =3D MIN(MAX_CPUS, sysconf(_SC_NPROCESSORS_ONLN));
 	cpu_set =3D CPU_ALLOC(cpus_online);
 	if (cpu_set =3D=3D NULL) {
 		perror("CPU_ALLOC()");
--=20
2.34.1

