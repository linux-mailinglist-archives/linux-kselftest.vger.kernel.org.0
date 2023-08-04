Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0870976F738
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 03:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjHDB4D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 21:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjHDBz7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 21:55:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA7C1FF3;
        Thu,  3 Aug 2023 18:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScvC/mrSNAEoAnqWWXRL6XAjmUa7LsAln/OAJ5mAoX4vVmqGGM/5X2j8OHidv7nNROC03HVOILINjEEfHzvW35trPjCqD2qtmwWY42wiXvo8npu+ai9rj/bZeI8iAUU+wk4JE24MRR/DqEtBSQ7TM+kLD82moKG6UBpaa4H5YmWhRDI/vevQH8kdanyLjOWZKe+8fvupJpfsk6NfdslmSoiqusYdBMR24AwAS0gyYVs0Te+YCH8X3vxzkgftBcTXTx+QCL664xVVvDaXro8+J8Q5eljI4GzwJPE8yZgBxUYm1PgbeSvDpMExuuG/pMoNQjdVqoJSFzxhsPDgxoOnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHTWD5WwibfCNfatfe/o1L4JL9TuE7410T4Cf3XxDWM=;
 b=IxllGbCEtQ/4NOJSerQ6vLb3aoUFD0HZdX4aVjaYkBn2JRij9rAlPMvX3wSSZfUthAq2mztsjBoyDkcSopHKOgEnPq3mgSYjG+JFspKq7qmGcQVP1fq0SNxrrPLRNW+qzroEWz/UsW6RmUXwHi8WOawfFhG+juCbYI/riAfS9OSY1R0vUMDJw7e5rmU4iczzBeCFQiz8DfAKtv9AngCWvVH7dXZLPEhNq+VwqiX8XhxO2SIQKNCcYtGvBToB4eWsbZmTQJ0GwRm2m+GpDcNvAK0tbwehYEEWdROGV+RZHIKQ6IENuGS3KaxEj/8thsQvOc9h2/Fh7MlHT73MNjKb4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHTWD5WwibfCNfatfe/o1L4JL9TuE7410T4Cf3XxDWM=;
 b=1VbAmi8bDBHDhp19EAjn+WrRzqr+K5bBH5h+twKJAyv3smssEjZZTt36DO878CyEKQbmqnMhbEapVbvzOpqf2C9Ie3ROYHdKqV+FHaIbNgoAWKiT/Xraq88Hwvvm7ZIH1D8t6WgUkOrPw3/OfW+FC6PReymnEYHMqgkhwXayfo8Tpp1QtcSPFkVrZq2RRD5UgqSEc6sx9yOt/XClJwcL1ypjPsssAd7rPy0qiMdtlJPpiUyhp22l0cmNPn6apUmDjf+RlmNVoEGPoJokuKecqWz4OXvP9azpExYvLS1fUYYTDYz0Q/AD1QcIZwfKtIqjFmJJ3dEuzdK5p7fB3NTOVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9085.eurprd04.prod.outlook.com (2603:10a6:150:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 01:55:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 01:55:55 +0000
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
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Simon Horman <horms@kernel.org>
Cc:     Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v10 2/5] selftests/bpf: Use random netns name for mptcp
Date:   Fri,  4 Aug 2023 09:55:44 +0800
Message-Id: <256d03943f4dbaa5c1d0b3b23f64efac9cda8bd1.1691113640.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691113640.git.geliang.tang@suse.com>
References: <cover.1691113640.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 996aa739-f520-4134-c846-08db948df0ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DP6XWYgImjRZenqJfP0hYfln1xqXM+n+DJx9chXPYIiA4orndt/SR9KXaV+zw5XNj5a8AQECmSNZoQymJJYcuSP9Aa7ZmafVPr2gbpvYnajcJyQ8Xn7bIf7BGOfE6xMq1dq9hQJewr1+LGlF5C3wijbhlj3eagjQ9WInnl474IRQS0pJCVzqcrtWUFv17ZvLCNWL14Kl1TufIFn4m2YlZck4E/ixGL8s2cpuidUKVV6rPvv2QmywnzhD8rYBttnkuDSVSAOvELqKRNWmVk+LIUEcphEJwH0n4ky55grCejJXxAo9hztm+aX14dDQlGFXL2pS9F542xvvwgjDQlz5R4UJkUsysjE7e3Nu7q4buQIGndqp+1Emz6hgxSZZvFEVmWlGJfooKCDcRaH1A//7iNdXk4A7K2uWtLguaZmCMIFaTHOWoYeg653CgiuZZngQsEMnPuo/JWcN4u7QFMTs49ILEM0BzQmX6V7LnUDR8VMWAYl3S/XcCrbhEUdZlIhDdy2E4G4kLavU96RY1v57EsoVI8PT2FKMw8+ZKeVyWngT/NU/liH0pnbQ+Ejky3hpyRU9nv9pgVrlvsVNTEnNIn6GQtxYBV8jCRSiKzjBx+rroP3LDOW0qeKbmMOvLzTOIy6X0I87rsBctpz0OfDILB96vXB+6BFHQIGjMzJUF8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(346002)(39860400002)(186006)(451199021)(1800799003)(6506007)(38100700002)(921005)(26005)(478600001)(8676002)(8936002)(5660300002)(7416002)(110136005)(44832011)(7406005)(41300700001)(66556008)(54906003)(4326008)(66946007)(66476007)(6512007)(6666004)(86362001)(316002)(6486002)(2616005)(36756003)(2906002)(83380400001)(13296009)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y3vNWtPgufLEOUf3cl+u0GXxya4v6p/9UW1gPjn/bPLN25VMleO1Na4qdZlr?=
 =?us-ascii?Q?/skd6+DiAOb0x3BkHxxS0AnBBTzO2yeEQdQ4G5IDIa/x5E/B892xmoeVhdGF?=
 =?us-ascii?Q?P6WhNV9CzdmiNvWX3tSc7CBqGYMJgq2iEkHInmsaM3qGraw+1/RNjpdMmKTm?=
 =?us-ascii?Q?kYX1rSkjHGLuVNvryKJZEvWnarjiI3YBuhzGN42y3DyqjgsuAmIeDtzV7Uhr?=
 =?us-ascii?Q?l6nS54imVdgYQIQc+nkHZVQ4FdnyhRgFh3IFRqjw/FuVDLCz3GCm//pOHFJr?=
 =?us-ascii?Q?5sg0jWJdKlePcZ7eQ1siJmVBHPramTCWit9ibESmGS2Xk8jNwFYRMJkDcWLU?=
 =?us-ascii?Q?VfXf4/KUDLC1rvLb9TR8phYiBP75O6YS9VKBEu+1g6HEN060Chmoq+rjhXiQ?=
 =?us-ascii?Q?An3RTyh4OvnfCjPRjMhYG6WaX+nKMbZtAY79ewQXIJORu2dLOYBgeedqrzYv?=
 =?us-ascii?Q?XZ74wcnoAlHCD9W7Fz7ZMbjAj9mdAwO5FH2Cpul16/rKRKESTPJZWwE90OBu?=
 =?us-ascii?Q?ttFtLQ25R5LBgxzH9f2Cu3JYonYR2bUu3MHUvs+PFvethq0917cJXR9oOIJe?=
 =?us-ascii?Q?dWX6wAhznqX3ENBki65t89RdPiUR8eiJjAVcdOkkccArfhwHW8gUpgOI+I9o?=
 =?us-ascii?Q?SWNWk201bhQPlCWKAvAeVKO2gSZ7hLs04wxUN2xSSmjzpwp6nbIHx47b+PEu?=
 =?us-ascii?Q?VfpPwyU6PoDSbHm6VCyfdR2PGH5du4izYzMUluLSPq4dLwgIus/GwLvIeBXS?=
 =?us-ascii?Q?lkHq+T3h2o2xvX4EtbRSR5lwYK75EEYqg+DqpeRml6om/3OQjdkwLO6pm56U?=
 =?us-ascii?Q?TjIEvFBkJ/WyjMT45KyOhDwhD+D/M8QgM1XAG+OVeBHakXaYKSpLXyIQwaxj?=
 =?us-ascii?Q?YQ+DTRsIysmD5vD27kv8wF2kJMmkSpB+cbo524cbkqU3UEj8KLx2GaloQrXv?=
 =?us-ascii?Q?qWSByg0hx1n2ceTOCsscUPKkj1ulocKwetYejlLfn3j8yuJwDCgVlwjbYJ7D?=
 =?us-ascii?Q?6ffqR0lWI1MxAmHNFf6+pknWQCTWFx9kGWaKoJgbh/IwbPJ9g+RMF/yfQLyH?=
 =?us-ascii?Q?nwv/BhfT6wYZQ6EJ1nrwFko7ETBgg7zxFoVdZy8dFIETG9CtLgEZTF7CLz85?=
 =?us-ascii?Q?gQER8MFVcCAiKi2Ddhk3nc7MRyX924UUXIZQxezEiAdmM1UzZ7PpssxvigNx?=
 =?us-ascii?Q?u2HNJtwSYif+QYl3v19FVHi7fumZtYQvFr7NnFKrKgSorQKojgUPC3FlCbvC?=
 =?us-ascii?Q?xklrQ8/+qarqOuZuqk58VqJK2L2S8KvJbG3CA/2CqK//NQ0cUduAz6fEvnbt?=
 =?us-ascii?Q?TJcv881Fh7qI311GZ9j4lqsg+q59yHyn9fXNDjBaD61aiBKGeuMpt120RFNu?=
 =?us-ascii?Q?ECl1wYcR2C85rGS5aK8w4QPNwX48If1VWgzXApHFkSMs4urLGuw2oe7VY76Q?=
 =?us-ascii?Q?dR3uvbT6SF5/u0k6WduGcnj72UmmF7dQcgevEIby/xakuitXVGE6enjtc/gg?=
 =?us-ascii?Q?kbXlMZFyJhRq/YiBHrX+Q+RIb7rjQDbNiTqPgt5vrgzDLHpTXAQ2ewpHKDty?=
 =?us-ascii?Q?d8Ed7RjFJr2QkOFu9WWd20r3H9/P5EgKCPOfCDnl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996aa739-f520-4134-c846-08db948df0ae
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 01:55:55.3884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYcKUvZ/pG2WWmsKZA8QzR1J3Nt6VILN8R4MyEW4xgQRlp4DrT4GjQSdghM0zhmsTgJqLbjYCJXRGXfOe+06Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
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

