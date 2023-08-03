Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA5576EAFA
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbjHCNov (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 09:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbjHCNod (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 09:44:33 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A916544AF;
        Thu,  3 Aug 2023 06:41:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1+8J4Xty0D26GxpMgSM7ikOQr8mj4k9jdE06HoO1+gXg+Uihh2lkileEAwxzHJkTcyNUknpH1iPtuR3YWbCUjrs4jpX/0ecgw2I8P41ZltXGGkO1+aA+fOg4wC/QPoLX4t9EwLX8gBhmLFll+0NlDljDy9DuSUwJ40p58/tvpBiyfULyJF7peQvjxrA58zGTs2LfmqGOkNOWDBeeTg+tCzWnxoS/r4hdSOzgMLrsiY5T1Cj4edMaU9bFd+KYT6CuulycdScoqkMx7gyi47CJzpbiDL9J4FmFjvj1FTSb2bcnHuE/PelUaIO2L/PALHKBKPLlZ5gbRUJsMIz9VEqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02iyHHjkQUGelZcQ1iDaZ+J0TmCKyxhCWbnucp6bY4w=;
 b=fttcYwfjV3bwpK2LXnXnZkcyXlFJAOYsw0wWyZbrgx93f1h9NgnmaHikzuBMY6qkdhEkz5bUEhpqMRN5XR3hIT+Gc7WEqyb0uavQ/zWXgnJ/KPgkEcLfe1sV+4BJgguMBv3mzwt4OW6MN087lKpnKIQU+2I+bS0CbjP59U1CFiLsZscFIQqfM7zeh9OGn1YOERWMB1pR5J7kRZl9Zvr9ixk3MmZdy4gxkadPg2OdfKTq+Zm4MHNsFwtAibdXodz/Et0yj57wYO8/abuodLT5jf6OSN0ZkzKQuYJamwyRJvC6HYLdF0okatna3vvYwMgQzFNC0/N0S4isBmS1OguU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02iyHHjkQUGelZcQ1iDaZ+J0TmCKyxhCWbnucp6bY4w=;
 b=jUSyGbb/0xngYWavV3OdfrMohiKmVur0eV9Xo1MfzTJ5Gd1pnIxwzhj+kQ6cmf/WBtRxyunvhm+cioqZrOgikgDjeT94FNrkcfRBwv7vRU2D5Q24vWXp7sI1vcFgoGOSfoRDjhurFbYa+N0SrfTD4bw2BR/NUxbl5ED4NV3lVubDanWWZzHE5RUnVDkKcriv7bQpC3BBoiCSRUUhLq8642Nsmr62GFdPBopHbIIoTv1mnF4nkCzetpDzD01FWpVrzjJP/SbScib1KAjNofY5D/FLDBGKkfrkZS0FbJHjlCLoLUnV+AMXW330j3BpcWCEjrFtabcoZEtYLKFEtUqyXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS8PR04MB8580.eurprd04.prod.outlook.com (2603:10a6:20b:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 13:41:56 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797%5]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 13:41:56 +0000
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
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v9 2/4] selftests/bpf: Use random netns name for mptcp
Date:   Thu,  3 Aug 2023 21:41:44 +0800
Message-Id: <54307a065383fd3171a6306ddf30395b686aaccc.1691069778.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691069778.git.geliang.tang@suse.com>
References: <cover.1691069778.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27)
 To VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS8PR04MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 592c70b2-073e-4a19-e5c4-08db94276746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9PpGBH/rrDQu6td2smlAiduRmi3wR9x7qU0spzPfiHXsxy42Fu6NsfymZNIwOxqi+URSC/gnp8EjCGsLji8cVNUHrEK6/fztumnVQJ5f3M/LYb36NbvoDEavIfM1QzaHCUJR2iJJU/T4u0q57MRxZD8b+H5Q1gjyDzG3z1731q+Dhdw0J/o9MF/+qSAIcbhyRmpthY6iFH9JT5NlhN6CPn7RGyhysMQnaNTiv4yEuf53Ak8WGzy3s+hGXNFk083qIXvDPfEgd1+MB7eP4MQrvPD5r02pEOTdfXnU5uYu/xTXeKFbYue8rWKE7KtJ0qJIhSUDwzufHqba5hntPjBl1NhEnRGC4t/y18yKA+Mkl4EMkGrG7Zmdi9p6nHd8Pm+EM1WQrT3Yb69bnDPspoPIyNpoiM6daK4TFY5CTMSBd6u8vGnJuzkpEGYvgvpRNVBI3ohqYET1XY3bvjvcuR4WPwgBxWAQLfGDwh/afSlHk2Sk44AlFreJVWXl0eoEUqulOmPR/c3osAT43qGwcbLNqQ0d/5dJIbfD4NLZy84HT0+8XAQfUMChliDurD4qPyadPEJjm5szwjke8Zei5rKgBysgL7qCEal4Rh30NF8/SoPeJfvAsZmY3bswEayQAGn5h4bAk9VW2pgGvu2U2oDl8cL7QjJQgJBiUTV/TPbPY/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(2616005)(83380400001)(6506007)(26005)(186003)(41300700001)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(316002)(44832011)(7416002)(8676002)(8936002)(6666004)(6486002)(6512007)(7406005)(478600001)(110136005)(38100700002)(921005)(86362001)(36756003)(13296009)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U8lvmSX6mDFgHAnFIz7KzWVyZCYbdWnokzduOMTYnOuPd9sFO4VTTBI/b8iZ?=
 =?us-ascii?Q?uYOB0BTfML2sHxEH4z9fF0b6AnbkGxSPeooIXF4/VfyG/c6XcEbPmFwxy6eR?=
 =?us-ascii?Q?Oy4w9ZuekWyt0JWMMknH7Z4zkjvji0s079fEs8iWzIMA0e+M+S31FnL7uMGh?=
 =?us-ascii?Q?i48IKOwkinW2RC7lWTao0Gc8JYJq5ux8o98ihq45dbV/UHofsulXdvQ2cUna?=
 =?us-ascii?Q?KNTFBNYSA1dwWFnvJMNDtvAGL1YfiJMqK5uoeYPZa9EO2UvNWkDDRa8m110c?=
 =?us-ascii?Q?mDYeKRyxhsGQxAMZ6Pein5/s+AcLgw3xa/RXXoE17kvYNtT2D4s8M40yLVkE?=
 =?us-ascii?Q?NZSRJsbm9GpnBtMbqxbyG9VtgWc/vwwirktEwsRn0c4tBr9HFOt/iWw06OQA?=
 =?us-ascii?Q?UeKusiEYfsPTupwdLGE0XAV1CCPz3MDYMIvMwS/TNPRnqP+eGClxQ4mdm9bb?=
 =?us-ascii?Q?LlUENFz3YEF0GrZ2B5CeR+qJs9/lK/Oahx4jbLFIprnOp/bB4Rp3I+ukp1/2?=
 =?us-ascii?Q?zRQQ4mbk8X97x+pOkCyLCgM/LSbR+ijezDkoT7oi0F0BefkbZcYXEmkAt5cs?=
 =?us-ascii?Q?xmUrKd94JlpvURzjkIosfHht0YyaUXDjjUyt1RSeC8dYw+KwqCo7zHCu7du5?=
 =?us-ascii?Q?/3FMfw8Ty+78Unlxhu84GYXBBK/HxHY3BKiqjItbsDIDfTwXhLl0nzsDrqKn?=
 =?us-ascii?Q?lJHuUALpb7nEmzDKvu5GISYLlRPsJEObw5sirQjFNrTZqzuSFxI7364QXSVW?=
 =?us-ascii?Q?zuYRGAWPn/Tm8YSeekM/2FLKeFZ1MBM6Cvh3nGmrDwZI3tYCcBiNa5H87rZl?=
 =?us-ascii?Q?nx/Lbgsq4PF63SD/NNCwq35Sh0xEL4r7kpfXT64e6KgPIhv87GDCdobqhHDJ?=
 =?us-ascii?Q?6JZohmVlHHJrrhNumRnAP/cwb3aFWOFbQKL5SLdhhgWgLf2k64h1itvEkhIn?=
 =?us-ascii?Q?Pf+8l3d083QrvHQ1jjMQiAtZzEd2uPPqYhZlh0rc0y1Lbk8Aig7zwcTgm/9J?=
 =?us-ascii?Q?l54HFofrnIkDk5Oh3MhrRjCGG3vNhzueplR3fd6AwKmXzFUKzUrgHNKs+6IZ?=
 =?us-ascii?Q?x5qhIyxT1J1xqlvXWZ9JGt1lwY93kAL1chxyQz2oataUbCDmVu/b/6ZK49bU?=
 =?us-ascii?Q?uQ0qHQ+9ruIbNJaIi4uAP5Hn2PUaHDYxanRt/bT8ywsYkMhghq81QFPNIDOR?=
 =?us-ascii?Q?DDlQlF6bJD3iqfSYigyecvYPnKXEEl5cUFBIU7VBSdJ1kZwz58SwsxRGvO4P?=
 =?us-ascii?Q?1DkW3keMa2NIZ9Mmaj3E1sZHTRfSD/ppdKzvyW0/7JHk8djQH2R5+3APOUh6?=
 =?us-ascii?Q?lR4YUal0NLQoG8W9cDAmn15EqpmYK5FfG/zWvYytL1LyCAeEgEyeZIbkD+ic?=
 =?us-ascii?Q?plfuDVMFpLHgRYtjQ1639j1R1Nn+OsjCSWuSaWvPO3UCvNNSl3/q9V5FHCL4?=
 =?us-ascii?Q?QGVOzs4dTbY68ttUzGUu2bi+LtkFsuKbNTXz18uaqjZGCXfHQLRRpFQUcjmz?=
 =?us-ascii?Q?jCjtXt4XQLMR+rvSWzv0N4aLG/8JayvYurwv4EVujNj1z7FpG2Hb8+brnW7r?=
 =?us-ascii?Q?TtvCRTcGOJNbsxCnVD+Wm+l3Bzfyb/jd3+vzPKbf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592c70b2-073e-4a19-e5c4-08db94276746
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 13:41:56.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIrs8EpwfIA905RX9lHHk+G1QJRrgMiPoc8zbebzD6iuT4ShVQOU2ngaUGduAdZQJ6d3CpIveyWE6m5w1jUnuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8580
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

