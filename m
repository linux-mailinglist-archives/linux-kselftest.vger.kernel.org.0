Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159BB767DD9
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 11:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjG2J54 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 05:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjG2J5y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 05:57:54 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF5130D6;
        Sat, 29 Jul 2023 02:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeU4nW1JrzOOeNqWBOQuF9hJ1mv72ebDwpAHjC/a2cmxOhJ9aUJYTB/Ta74jqdWSZIsEoZUDOIN6qTWQ7sVRwv0aTzCo3WCS24QOzLRKYcSZqI/e0djf8NiiXRoXOTKOsJ6l9f8Am8mlmhoxQtOcO3zvmaYkHK5aS64TlTMNvLt3yJXBjS4Wp+bW51a2cSCpLLnMgjsToZkvBxpyPcX05ZOevvU/GDY/9gYoq9aP9KIycrgyOoKoROlr1B5R/3V0tLu+I+rU2+HXIjEcFWEXP//DDb92QraXkOzr5VtTtZ5+AXaqQUyOkvswMMZv1+sBOM/MWpV/E2lXwcCo6sd/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02iyHHjkQUGelZcQ1iDaZ+J0TmCKyxhCWbnucp6bY4w=;
 b=fzzwnvq1aY05TXqdnWtGSdGv96oPF3KW8WjICLR/EOvdnvKL+QQEZWLBMikcAZ51IEMC3DjTSbUwUxJaXdfOf3K543AiVZ+0G/WESkSypXJdJ2DOS7hZOQunc1tw2OBQcEphZmg1+wIZh2sMfddx/0OwOYfgV439OZWPngX1WB1fwRCp6mKPlv8ndz/kyUjcLe0wLe7ZJSrW68wmVrDLpjuMT9dF8O7ixRHfW0FC/xKdOMYFj/R6DG6U3eNaBEDwuL3h3lfF5SMw8MR/cuGIm96AsO+KbTtactQyQu2sL9AY6nicmbdnToqrjUyredsnCqLP+2dfF+75+uIuXaCxMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02iyHHjkQUGelZcQ1iDaZ+J0TmCKyxhCWbnucp6bY4w=;
 b=db+o3fSCXHo3Z1sYVvbs8Qaj8yYzGlMaI5BQhI2kh/FNIhJzbYKqKs+sASMMQUMbAiX1vBdUXC9t6xTSNQSu1NozZ5laz+I9KwO9JyQPVxwH6LMUQmlHTd2zxvyl+bnMth8nOFb5pYol7OaUB0wZgv8CvG/Os8MWUkHhVnBCj2fjsAy78PKj1JNFBQ/IMSLwHhlYgZEGiK/6s/KX1u5xrE7q6S68KRo5szHXrdAu/MDyYRrTYruabOL+gvo2AZvKBPdMRw37aLxnZEcOZo1BciyIUS6Rq6uj5ip79TzIugxCrhngQPP2uWekWqP1ZonFAfuHu3sRab6w4bEJqHmwVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9733.eurprd04.prod.outlook.com (2603:10a6:150:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 09:57:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 09:57:50 +0000
From:   Geliang Tang <geliang.tang@suse.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc:     Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC bpf-next v7 4/6] selftests/bpf: use random netns name for mptcp
Date:   Sat, 29 Jul 2023 17:57:25 +0800
Message-Id: <59d5ab5d065bc35e26b31fe965c10b8c22aeae9d.1690624340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690624340.git.geliang.tang@suse.com>
References: <cover.1690624340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0102.apcprd02.prod.outlook.com
 (2603:1096:4:92::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: a0820d99-81a9-48f7-9946-08db901a451e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlktoZ/VtgeGF9MB+JBeID25VaZpDZ57qUgNd3zwraYhXM7wsWsu3h4KJGRYotOyG3IO1ysBE/B01IAC4ngjPPYJrzkilviw0EWlJjHu+Nsg05mKgSE8QTAx8t3uQNlaKut7dHsbeJDqEyxc+PgnQDmGfdnJwH/NVrHQzdu2k41OSt/fjjmIq17EGRb6eqRp+0NanyWCraj+pIlON+sEybRnPQVLNbELIm/FkguVk7EcLdSANnFr0/+uT4cFyq5FoDVVWiHIqysMjC3v9LoFJ4rHuOEvKgTOIUg1yFDIBRMONF4jdH38m8HDqAG1wRkqyh8Bkuz9ARYHAv16UcJl7DbMP/jkTtsibNAnT/iYRvnMWo+ez1BltFfqVydCBIcxYn9vOhfjY+T43B6e/5xy1y2/80FtiPI/igqGWhQh91q7kfNRNnqhioaBcMgWpI0IcSEJz7LyUER5DTEswmJsBk0cWaC7XMGy6GI9peyTMv0rdzATIgbz8+YwhS5BAy2TIGOYzHck7+P5mmeZ7W9KGVAUbS2jtwqgDgCal6xsThJlwBqg0vJFvweVNo2XD+A7n/azIdm1Z/UbpOytz24BcNaVnSJV3r3DfzlxPn+vB9NP2h0sV4PrcACRVPnLIJ6H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(316002)(8676002)(110136005)(478600001)(38100700002)(66556008)(921005)(86362001)(5660300002)(4326008)(66946007)(66476007)(6486002)(6512007)(6666004)(186003)(6506007)(26005)(7416002)(7406005)(8936002)(2906002)(41300700001)(44832011)(2616005)(36756003)(83380400001)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s5MzrCSpLqzi8CdNE5+gC94L0x85wyTYOWHFIP0gR7tSrazwwQ9ALDLH3XGd?=
 =?us-ascii?Q?fjp2biT78cvbzIVCEUVavPhQ8Jn+cf8CY9tDRYcLHSVfhx/j5b5z0/IGAOf8?=
 =?us-ascii?Q?/w9UC0AjYmBL6yLsWQjArxOl0z3yNg7Q/vw2dDDOTS+eAmKBJR4kLVTLUZ5l?=
 =?us-ascii?Q?Kj4K+U65Xs7bvFooMPFJMTFoC3Auzkx3rIm9OZoyJyFl3L4Vnl0W0Fgw70nL?=
 =?us-ascii?Q?S2kmELxHcNbXSr4dqMwijAe1BM5j+ne1DDdXCikvSHtBHhKDtg2f1yXxb+bI?=
 =?us-ascii?Q?gdYG/jWRpDegXqao7oVG8HZCdBY9NZps4PgvDBCSM1SMcDLqKr6ATEVhVHF2?=
 =?us-ascii?Q?q+IYP4fMXwPsV9nXNknpujdLJu3r5N90vt/G9yYS9l03srQN3l/wDD5spqKa?=
 =?us-ascii?Q?qcqyoj9uh+34QakcIocyMFlD5sHmQFX7ivaN63y+97JSdZvQX78XqXaZxgJm?=
 =?us-ascii?Q?YT4ihGlSLUT2dzKFbMGMqCsYqICcjSU47yqQ7ghX91aTEiJZw82Dqrku1o/V?=
 =?us-ascii?Q?HlW4ZVr590EfACmpNDjnNsYct7MLP8jRDtyJvqdrST21qSr//kHQYiyjZNd5?=
 =?us-ascii?Q?H4hML7cktgEdOREt9swigJ7RiaWfVpJvTRZLknInNp2rYmWZdI80WS6WAmIm?=
 =?us-ascii?Q?8w+060gXubsyxETX/KnUel3Rw42WkJzf37ntUO5sKURJvqUOqaeW6cQV7yKg?=
 =?us-ascii?Q?bFSaOqMOTXgVVCZgaT1ufetvctKh7k/YpCFM2O3GUq+zqfhzPM1pIV8KHhC/?=
 =?us-ascii?Q?IhkTvJP1bE8B7ErpnczdfvKbsCe4GGXqet5DUXl02g6E8mSkSgVrx4ZnY+4q?=
 =?us-ascii?Q?rDCmcDLRDAHbe+A7efn0Q4G70KIAS58Ag7YMyiZs+QvMDRSCYMoou0QKic3r?=
 =?us-ascii?Q?nKBDLbgiQAD/N0nhK5NmoI3QDPnO9Aamvc7urC9cd9lfRi07QhzYEqJLu8VW?=
 =?us-ascii?Q?5i+Sj/PCjgfBKrQ2xkdle2wURIQiOdOs8W98R+qqC5FmuZ6ONIQwSaqAbZqY?=
 =?us-ascii?Q?WoYioDwEDVfReTrqGiC8qdgWU6m0qhPNLmKpDIsCWNbQvI8O346a8Pn0XFGg?=
 =?us-ascii?Q?k+EafQShE4vnlO4narXoMz2eze2YgZb2XDO9th/I1v9xuOxhimjLoAB/xlAQ?=
 =?us-ascii?Q?NmH3wbeIs37GWZ+G4ozmI2z47XumRNP6L3NkFlZk9Nxy8H20pFl24fRCRaQR?=
 =?us-ascii?Q?9J9dhGdDH4GP0toPyxTH1Z4cHCnODlvxGmsM/h3gSqyn1hFz4y8s7tgOmkHU?=
 =?us-ascii?Q?/7flQeCU8RQpUjOHCwrivBRdtbz4eaX5gD8mVdXgvpaJm6kyH9sOCVTJ9++b?=
 =?us-ascii?Q?hYRqCqx83SYsMJ8Ijim75AJnOlu+2G65jIG5/jr2j2bp4QgRxl8deQLbv7aJ?=
 =?us-ascii?Q?xo3OoP/WQrbXDnAVxg1NfTHle4aNu7PS77wNLLF6PVOo3zbEuLIpfKNvFgSm?=
 =?us-ascii?Q?XXx54j0y/sJyGpRQ3VHMd5V2M9g2CXQljiJe084bM8CfsH5o/EgbsnA4Tfe7?=
 =?us-ascii?Q?l1ljXcfjtEYOnpx/Cwli2z0Kryim/Opm/U/fc2LAkaSxo/NuQF2OhjOSChja?=
 =?us-ascii?Q?QCTryQTNJV/WlDwNYExtDWtbB1L8RrcQ1/x1ywBd?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0820d99-81a9-48f7-9946-08db901a451e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 09:57:50.7748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/9AexyCJXiNo4zrg54Gy5sT4Enl+e/aSI1AH9ANMUf35mhg6VAYZvxvgY/JpKSJ/92ur2PbIxvEw6RH8QcVNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use rand() to generate a random netns name instead of using the fixed
name "mptcp_ns" for every test.

By doing that, we can re-launch the test even if there was an issue
removing the previous netns or if by accident, a netns with this generic
name already existed on the system.

Note that using a different name each will also help adding more
subtests in future commits.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index cd0c42fff7c0..4ccca3d39a8f 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -7,7 +7,7 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
 
-#define NS_TEST "mptcp_ns"
+char NS_TEST[32];
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -147,6 +147,8 @@ static void test_base(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
+	srand(time(NULL));
+	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
 	SYS(fail, "ip netns add %s", NS_TEST);
 	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
 
-- 
2.35.3

