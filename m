Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD1376EAFF
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 15:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbjHCNpD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 09:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbjHCNof (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 09:44:35 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C614744BC;
        Thu,  3 Aug 2023 06:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITkku8WInvNHtFCPJA/1IjHXGbwenSjM/iMS3iKSXqrU1jzKJjhjL3yypGHt1XJ9WCJZ1JvFfTASjD+72UfV+Bbv26YmpvplOk0/gZByCEpFgHdPD1J42NrZZYDKI7iSO9YdkMls/exZKbN245cTjKL6cllCh6yqP380EnslUHJY16BLmRwK88rdbK39Z47uWS2H2M+JFyHqVw0XWjak2lloPMqL/9XkvWV3pkzZpph0L8IgpS0LNsivSf0gkX4ya+N0RbQOR/W+bEGB3/EkCsSiiLrKQiWyMLq7hwF1SM6DpPGPJM2phb21AFEj0ekZS4fgsYW/3+CZ3s5wxSh0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWqMc9UT7yWdDRGAA1JFdqK94iY4Pu9Cr1Kw+TYOXMg=;
 b=Dx+M8Fqse0oYKa9o3jp8WL/D0Da6I9hj1pMPDROAPV0NxomzbpMo1k/BKrVnPhrUW1/Dn3cmF9Ja1t63pW00rP77AQGJBGqY8mV/8knL9JA92j8RejEPx0QZek3iZpg2VyM1zui4LkQoBSFPji9x6iuu8l1nVObimuLEZ41RttT8S5JEjnbsA2YVIKrYfjUPUH5gWUcZKpoKTnEQ49Fr4yOwP1Ug8xcYjvoGwHbwlygbRQJ9Yg5PC4R7IVefkH0fKvHxwtrcG1xomea19ONBDcI7iRqJDKxvtiCMNeVVqMI4Cokp4TJAgSfskHNb1MZm/akNuXo557gCeMLWpznbdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWqMc9UT7yWdDRGAA1JFdqK94iY4Pu9Cr1Kw+TYOXMg=;
 b=3X5nvhhNjDhU26tGLl8KCmM8o1+vLP7FnQVbjegRdnuAcyRIPWQAamVLTPx1AyOtykufm5o5xjtRDRDgFOnb0JiGUC0f0w92AjVGOlje/immkM61MnerUDnwWU3kiWKqElewUoNjMYsbWVvJIT0d4siN7AuUv8eCKISpWc+cX5Vx751XEOYZ2o3VMX8WAcX3tsFPKSLYDv6B5tkFLndhmhtxtfT+5h3eq0E1pA9BFPfO8KMzoitwqNMTOzR5b+iUql9nReZv/skQWdbwUHzXd2+hv12oacYGM9kpA9RI8av/D9woVcykGW2bKmK1BuX95ytAvUYwQv/zrear/MTlNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DUZPR04MB9725.eurprd04.prod.outlook.com (2603:10a6:10:4e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 13:42:04 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797%5]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 13:42:03 +0000
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
Subject: [PATCH bpf-next v9 3/4] selftests/bpf: Add two mptcp netns helpers
Date:   Thu,  3 Aug 2023 21:41:45 +0800
Message-Id: <27d3ccd2d762023b4829ba54e16a3e11925ad75d.1691069778.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691069778.git.geliang.tang@suse.com>
References: <cover.1691069778.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::23)
 To VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DUZPR04MB9725:EE_
X-MS-Office365-Filtering-Correlation-Id: d56cca4c-3cf6-493a-d9a8-08db94276bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJ2VoOYri/nwzygMAWMhIE7OYHSnzYwlFvvMEfqSqomtrrlik+mUyOzSfgOjzIl3wi3/O5z48JsJZUYzODFfaJxddS9zCtPDwv+spZhPMB7VhYH3STH8RnS2TTdx52LnkAhTj359CoFSX69dRW0OvDapa4elSGI3/s/lEIDBp3edHPuQmbqetA0h06+EodhgZXSTNJZAiBgAFUOsb9mBW2fwIXHlkrzBI0KGXHEbPG9SnvVd0N34RLNeXT1ts5Rdxtwh4Ns+ayFnd8W8Vafq6WUY0GUNMbNY3ybrtgTmR42WriWPYdzmVWuxje69oHSp4+deYI59AHR2sz39rtOg0lQxbMT94kKw6FL8RuUoxhdjh4ebfaR/7Tj6Hr6uWfwflWlR+VxOCr4NgK4tV4p5IoxxGWxhTL0F2bMMGymtAa7dc0V9HV/Ojyve/H0Txc2sq5EnyEpK3LPvjy8KzoH1LFJpoSM/Vz+B10QnPxxj6fm67eSs3/sBzW5BFsePXZlCuuuvfXNCU0lYlwHjy2ZplXM6Q7G6COkAe4Zkid9oGZIMa/e4NACfXxaAjyvsnfVmfc+c6/p9UAf0zRtCiPyDUmFrnSDd9xgN7SxPPGBzg2clLMpecVVo3VBq68E+ygaf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(83380400001)(2906002)(44832011)(2616005)(86362001)(36756003)(38100700002)(921005)(41300700001)(6666004)(6486002)(110136005)(6512007)(66476007)(316002)(4326008)(66946007)(66556008)(26005)(6506007)(5660300002)(478600001)(7416002)(186003)(8676002)(8936002)(7406005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5U470G6gR1tesQBYZsOstOMh7CpdWaRMOAPcbEmbDbKT2CKG5H8589BEMbDm?=
 =?us-ascii?Q?UFYazi9SAIDe0evutOktRW7ejAZsMGpEqjJRzhuPvoEOMfGd8/If7IiW41xu?=
 =?us-ascii?Q?iXsVeamdG3lxsbOHX8TZob0nQHNYMbFNaoDVTHRZRxuIZ4+8g4ww9yJoft16?=
 =?us-ascii?Q?OSxeJZnoqB5+XQTBIsDykQbZ+0W8RPL08ipGy2L/qa5JegYrgxZkHQqtWJ/Q?=
 =?us-ascii?Q?cN66MJ5rdU5PV9vuV9ocUPIAAFVeP0id89H0kekAKoIXATvo+BP2WGjZJsWX?=
 =?us-ascii?Q?TVvYjGqdKUqMqKS7Exv+r8dc/6eLg2UCxsTmF7/lsaXZvjxSgiWiRRDlZpyO?=
 =?us-ascii?Q?XiiD84QQWW/SU4dgu2Js/tY/2aqcberPXu9H+fVJzAuQkKAAV5YGh86eyL2Q?=
 =?us-ascii?Q?R5Z6eHDeB+CvP5iCSetHVZeScz05/t4Wr5AUpSKcfgGB84becRRO49IZVXK0?=
 =?us-ascii?Q?gMR3fcEodyphufX4JB3HiUB/OP8NyIsvIhgwNgQ06oYaN1KzZQII+mUlFtLJ?=
 =?us-ascii?Q?oKlZiS4qV5+GKQ7PkZi6dMO3CRyigj4YHElDrKHY0uTTmqgSdN4QqkF9U5f+?=
 =?us-ascii?Q?T+31bBZwgS5z/kl93BaKs/9wkKbpvNXAaUR9u/6xfpPPY6wcRxNeXzDY06n+?=
 =?us-ascii?Q?jX02gtwYgwl6JbTics1tLeUywg7QJIbHqAEHoCg/HW6Iuss4e1znIT5J6BsM?=
 =?us-ascii?Q?K4Kf4WFAbENVXWP2bIAF1D7uho8lcdmb01gEMUGdS31XKxiRFCyX18UPv6K1?=
 =?us-ascii?Q?keeg0BxRSYwZUgaBNl9vTW8yauOudxYiy7bHVejhrapaWqYSFqYJBChxzqVa?=
 =?us-ascii?Q?lQnhozdYkd6X3d0wvbS9aJ5GvsUVpt28Cnk1NJM5673gCgdikc2kUrV3Z7CN?=
 =?us-ascii?Q?SFhRw9/WKVFjCLUAZe76pLyo9joYss8x2wk7TLPJ3yAJoLmnIn5psQjBIDVK?=
 =?us-ascii?Q?DPU3gGG76ftk9SUkDyf1vOLIJx8+6RcJs4/3pPzOoExZpxLfB9sCoodBDAvB?=
 =?us-ascii?Q?kmZ2Lp1JQ+EQ3Jr3pCO5y97a19AlniMaDHXXjsr5RvUmltlTc1cI5nAcS7gQ?=
 =?us-ascii?Q?HSkQjdhJH4EBnu6Q8mxkN994/SAGKp1Eqd4pfZoquDzB+uJvUEQQkS9bkOz0?=
 =?us-ascii?Q?DFqMMDXzN0fRe7bRcYq7RpcA2kjObzN9cuoFSW6w1Kqo2u2bvT7eFxEP7x41?=
 =?us-ascii?Q?QynB57RTPzUW8dLO6OXrMUrX03dZQ0ariIcm5kQJ91QxIyEuksIYHlsQ8BRh?=
 =?us-ascii?Q?l4SEOmRY3jHJ4GsbtlpvnMlgVDk1iJsRuOCMBHymjsuPHqGYq84LB7EzKZ+X?=
 =?us-ascii?Q?8PlOFSibhSoRS9drsiVTArcQOG9moDC0TU7FZZWji/KqVgHOvYX6NDqKJkaD?=
 =?us-ascii?Q?jENNU4jSHCHgTh4QZI6yuu/yDz9PzFi5YFjyChWz4RT5JflOKXD30W09ihTH?=
 =?us-ascii?Q?KT+sZ9ifqk923zvkweI7PBq26zw9PgzAfGDhjHwcxjR/LlpQ40Lu98Wr/gfe?=
 =?us-ascii?Q?I/lYVSo5lvNu2uczhBJuZpd1g6hyvNONRHR4dWk8+1wSq8R1XLQASJfP0ZRj?=
 =?us-ascii?Q?8bdMSAQjiMXcFH430YBce55USsh20kfsqv4Np3/3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56cca4c-3cf6-493a-d9a8-08db94276bbc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 13:42:03.7900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7q/A8R96SQP56qvWbO5q1EnNMJOonfoUPFGLCalSMIZxpmOtbSE9uMqpx+QmY9Z4RYB3dBWM2ryyd4Cw2yQFRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9725
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add two netns helpers for mptcp tests: create_netns() and
cleanup_netns(). Use them in test_base().

These new helpers will be re-used in the following commits introducing
new tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 35 ++++++++++++-------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 4ccca3d39a8f..4407bd5c9e9a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -22,6 +22,26 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
+static struct nstoken *create_netns(void)
+{
+	srand(time(NULL));
+	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+	return open_netns(NS_TEST);
+fail:
+	return NULL;
+}
+
+static void cleanup_netns(struct nstoken *nstoken)
+{
+	if (nstoken)
+		close_netns(nstoken);
+
+	SYS_NOFAIL("ip netns del %s &> /dev/null", NS_TEST);
+}
+
 static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd = client_fd;
@@ -147,13 +167,8 @@ static void test_base(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	srand(time(NULL));
-	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	nstoken = open_netns(NS_TEST);
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		goto fail;
 
 	/* without MPTCP */
@@ -176,11 +191,7 @@ static void test_base(void)
 	close(server_fd);
 
 fail:
-	if (nstoken)
-		close_netns(nstoken);
-
-	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
-
+	cleanup_netns(nstoken);
 	close(cgroup_fd);
 }
 
-- 
2.35.3

