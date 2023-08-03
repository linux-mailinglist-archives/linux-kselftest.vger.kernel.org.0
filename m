Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A0876EB02
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 15:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbjHCNpE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 09:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbjHCNog (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 09:44:36 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81BDE69;
        Thu,  3 Aug 2023 06:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1R9x/GY4VImCVetYDf3lmu1EGmWQe3rkXm5FD+BGaLyG5yGCD23HsSLj9BBpZsm5oUDAT/WZCotArLa07YJfk8mA97tOrRzyLFrRE0knHTLQCfjL5ujbKvm4MjsTMQB9aYMpRz8IpXHrub1USXE+tBk3RI6+dDpkShMgWftrP/IdPgunXDuePWu/EjESvQfGbTsMvAmUvvvbo4D6ZOTlcUp+yGKqmj9xxETATFQIoiooVIhBMIucZ/5Uatj/se/9UztjIA/ruOtR8x0QEFkzkriIHzvqD8ZblRSQstgyfIBp8W4J1jSkqT4Dazu96l1UUsNKPhaL51L/HRhIolaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1VBt/JAhAhmI+Q6YmiMxzFmwi+dFZb4ProetOfhOEI=;
 b=J3OWQE6h8YLe2htfX/1jlvCfAyv4D57813jY7y3/hbFR/olzT8sqM0bG39TCTsTogqxLIVju++Fyx6bE8WI8SO4ftGu1jYTnhjiG5jaDJIObnyg70BqPaYIR5j7VaQoRbhMAioiYtnKCoH1hxO56g4r/nRABfu1jTkWkKU4EaYufAeEdzaUee/vwQv8C5Amnp7vLhd/Hxp1qEK+54W0SVOoHR3ZqtO0EGJd6aXADJjklZdY9h7mMKTAgTxtU8gE+VQ40mGxk308VawNtDs9+eVSwzxVPcUlES+BYIjMjAO48xjDyxUkASuDsE8HeWyTS1naQIurrxYTskhJJTrxtoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1VBt/JAhAhmI+Q6YmiMxzFmwi+dFZb4ProetOfhOEI=;
 b=0I6MdQ5+KrPPAX4kMZp9UjTyDNLwOfAe1ZjQmt5+ROrttRu/EMRpVp/dt7fmkaVPtwE+ij7Wc/AEzoIpaRuCmaZKWJgF0XkE/Ll4Wl7XYvYph6Xqb2rYGN6EenFIRXDX01vjiqAeAdq1ShDk7k5MZFvgKv8BFWpB0vOw1mQ+qFRRDbxJduPLXanU+v2FtzrzvKOIJsxnwEzRxWt9h61Hrq2lhE+Cv8+FcqiwozGzqM8vRg+FlTL/SS/za57BzG3/DcaVlwx11MYQ1VPPYUfGTJIXM3BQLFL71R8GpLBKuhRaUZe3UqBtNpARWsHyY2JxX/Rvda0XKNxC4i0OgLL8eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DUZPR04MB9725.eurprd04.prod.outlook.com (2603:10a6:10:4e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 13:42:11 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797%5]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 13:42:11 +0000
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
Subject: [PATCH bpf-next v9 4/4] selftests/bpf: Add mptcpify test
Date:   Thu,  3 Aug 2023 21:41:46 +0800
Message-Id: <92ee6be5a465601ff3a2df29b6a517086e87ca3c.1691069778.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691069778.git.geliang.tang@suse.com>
References: <cover.1691069778.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DUZPR04MB9725:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aba6b0e-e3d6-4cea-c9c3-08db94277070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbM3AFGtLekJ0htcodtwRDk3ZCytajzQsAP0GS2YLI+pmFc4kEXyI1uiHUcbUYBnPFIyk4EYqx/XqQhvAWp/HPDR14Q/YzxEO29GVU+VXNv+EJCkLzJi6SDyvefBMKb4FaqSOnTFtgXUqqeutf0MEG9yFvXl/jALMPLN7Cp+QZBl7nL0Ent5UezGD8gTjnRoy4sRigG0PT7MMiSTeFnUEAxmBSt/baGlIcQddoXxaYqH009IDttMWHK2b84qs3w0iZ/WSt2dTAJSKUy6QLGUOecy6+fa8DWjYBFA383CAD9treZMdbqDHy+hVVYIU/aJZZCh8zKZq+jznlvXka6Mz0dvGhWG9q3RezzZ/oA3n5uw+VP0zhF61dvKPf6TP35Vq/wJgmzYY2dQiLntsy5FZbdPCziOiYkQ5hsJB0UsSX02FPCwAJX3R2dvh25+xOpccK2b9g2eOfwN30Tg9qVGwD/DA8wcgF0QP5jAP2pL2c5hO3mk9IB4x+MgxrRvSmYzubAbdCUqpIoWcVtkAmX3MjSfy0+oOVG7GuyC5XoTVYnXxpUfNJiun9nuHTxCauUktXfVUAJe4BlQVrYFWh57Q9N5zcItT08ZId6Q/QvV5/2jQFTYEFM68ELS3Q7/ehev
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(83380400001)(2906002)(44832011)(2616005)(86362001)(36756003)(38100700002)(921005)(41300700001)(6666004)(6486002)(110136005)(6512007)(66476007)(316002)(4326008)(66946007)(66556008)(26005)(6506007)(5660300002)(478600001)(7416002)(186003)(8676002)(8936002)(7406005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3//oaDnJB4diOXcxtTTwf9G/K3YcmnxsTGsXLTBmFO5htHKPJP73CTziTp9A?=
 =?us-ascii?Q?azp0PnorWn0Vw70xaCHt1UlyVvDABLpREyRku3HIbXSBGBGFObVaQYxm9BPC?=
 =?us-ascii?Q?Q+f07jiIWDWz/+6I+fiSqitcnYlzXFfGi3l1uUhH1CfBacIYdD5p9lKXY9/I?=
 =?us-ascii?Q?m1YHiwqDhZQsAy9qHCrNYGcvuiI+fiTVSkiKM7cLYUx7y6y4FpJhGwNSxqPp?=
 =?us-ascii?Q?aUiV8uKNiu7tts0ygKNuGVpg/R1LMlcKc54ZUik21T/Ik+0rwuGepsxWEB6M?=
 =?us-ascii?Q?6Q5H5QYLdmt3GGd/FAC3Mho3iPbdpP1cfofexCv1RchUn1PLvfbf441peqTk?=
 =?us-ascii?Q?unEOtxJMg1CzNX3jdeSNmRkjvQPfrpmx+QT4qsVg77zRLpuhAi/AiilOSxMz?=
 =?us-ascii?Q?P+y7pM4wq6jlOJTaRD8t6K3/kahtD2Qm69MjRNuo3Rnz2FNfKYPwnIntNNcw?=
 =?us-ascii?Q?J64YaIS6XT7dfCqUq9i0YzfuIB7rVsT0LXkLxS/ej9pVIBWqaHr8BpOdhlrL?=
 =?us-ascii?Q?RGylGeJDn2KzSvS6OoBnpwTAkahLi/g4hmOmxh+ck+W5gP9y8/tKnPqKlZyC?=
 =?us-ascii?Q?BAggtU0v5MsMu2QhJd31oWDmwM2xBVHpZF1LYF2Ib1Ux7fjGHVM7xcAhRLj9?=
 =?us-ascii?Q?qMLwfWSEkYP4wbsy533q3pgkQXSMvzOaZ2RVeWPBlqPiPyo8G6NxJBrZtJTk?=
 =?us-ascii?Q?S6pZYslanyCUISsMhZDFjcOuPKdNk+y6mXuQ96UO+kPTUOcelii4KHpOSw/c?=
 =?us-ascii?Q?gv99GPp4Sz7fBG6kwPuhmRDFVIVIzOLZdQ9MJHVG5Bw8GPguWo17O531tHKa?=
 =?us-ascii?Q?BMk5wI2Q6rvZrRnqEDiXXjSmx6AtgISvpdx/P+L6zUnNr4fG+8X/TGWT74/G?=
 =?us-ascii?Q?RNtcqTk2750Aua+zy6wReV1xP0UsQ9TojOOAyxYVjZiK/qLRuR1NAL8xIWAH?=
 =?us-ascii?Q?EoxCD1E42wTQsOerfFR7dDwJ3U7gRRepLxPE77jznTUF6L8DDPYSlAGKM727?=
 =?us-ascii?Q?KR+VWg/fLvmM0zBdpalWCawcqs4sXys9ZnDKzzzqmPN+iueI9YR4Gn+DLWs2?=
 =?us-ascii?Q?R2VX19B1RBx0qR1JoVtULsT2xSrYEXTuhD+wI38D45RkMKtD6dcMEmrUuCHU?=
 =?us-ascii?Q?/MCoFTTp82cqsr38bnspLosaZpMZPK43QPI9ChoAJbPnOOFdCNO0S+BULKbP?=
 =?us-ascii?Q?poM/OvtV41uhOfT5Tb+aSueMTli5qF8DFHntLJ6EgvPJTMdFMkxPpTAKNxPy?=
 =?us-ascii?Q?vN2jWeOG/Z9srGqZiUZMtfFPOkCv6irC8Jg4H1pfwxvvvjXQKmPh6KBSW0+D?=
 =?us-ascii?Q?tFUb03kjI5wBc9mE4ZYlFYcH6obfmYf9GfRNKBTjMpm3K5sCbBPJn2AhgY0X?=
 =?us-ascii?Q?1Ryk1YzU8wrVnLmK4msQy2c2YBBlqAp5fbPSJuo5NMpe6gaFgZM/VXSmvBtl?=
 =?us-ascii?Q?KpPrwN805Gdhl52rYl2oqOzMvPeiMLiWkpzbZeeAxKj8Gg4WfmYAd8ujft/S?=
 =?us-ascii?Q?uA5Ko4dAMkFlgjcAkC9SPx/Q2j2RW7251tbfOL0YW0yf5/9kiUYm3KawXTFx?=
 =?us-ascii?Q?uxPtI/FmQDmnO5QCKP+kZNJ6wtVhYJ/fHu0N6Quk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aba6b0e-e3d6-4cea-c9c3-08db94277070
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 13:42:11.6981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0Qg+wTLKzG90CW2so01IrLl5nXdfIFazhfODvIUCxGYMqadPuqnDmMVgVoRhfipKnG7EhVM5rQVUwPdMxpRkw==
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

Implement a new test program mptcpify: if the family is AF_INET or
AF_INET6, the type is SOCK_STREAM, and the protocol ID is 0 or
IPPROTO_TCP, set it to IPPROTO_MPTCP. It will be hooked in
update_socket_protocol().

Extend the MPTCP test base, add a selftest test_mptcpify() for the
mptcpify case. Open and load the mptcpify test prog to mptcpify the
TCP sockets dynamically, then use start_server() and connect_to_fd()
to create a TCP socket, but actually what's created is an MPTCP
socket, which can be verified through the outputs of 'ss' and 'nstat'
commands.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 94 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcpify.c  | 25 +++++
 2 files changed, 119 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 4407bd5c9e9a..caab3aa6a162 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,6 +6,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
+#include "mptcpify.skel.h"
 
 char NS_TEST[32];
 
@@ -195,8 +196,101 @@ static void test_base(void)
 	close(cgroup_fd);
 }
 
+static void send_byte(int fd)
+{
+	char b = 0x55;
+
+	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
+}
+
+static int verify_mptcpify(void)
+{
+	char cmd[256];
+	int err = 0;
+
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s ss -tOni | grep -q '%s'",
+		 NS_TEST, "tcp-ulp-mptcp");
+	if (!ASSERT_OK(system(cmd), "No tcp-ulp-mptcp found!"))
+		err++;
+
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s nstat -asz %s | awk '%s' | grep -q '%s'",
+		 NS_TEST, "MPTcpExtMPCapableSYNACKRX",
+		 "NR==1 {next} {print $2}", "1");
+	if (!ASSERT_OK(system(cmd), "No MPTcpExtMPCapableSYNACKRX found!"))
+		err++;
+
+	return err;
+}
+
+static int run_mptcpify(int cgroup_fd)
+{
+	int server_fd, client_fd, prog_fd, err = 0;
+	struct mptcpify *mptcpify_skel;
+
+	mptcpify_skel = mptcpify__open_and_load();
+	if (!ASSERT_OK_PTR(mptcpify_skel, "skel_open_load"))
+		return -EIO;
+
+	err = mptcpify__attach(mptcpify_skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	prog_fd = bpf_program__fd(mptcpify_skel->progs.mptcpify);
+	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd")) {
+		err = -EIO;
+		goto out;
+	}
+
+	/* without MPTCP */
+	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server")) {
+		err = -EIO;
+		goto out;
+	}
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd")) {
+		err = -EIO;
+		goto close_server;
+	}
+
+	send_byte(client_fd);
+	err += verify_mptcpify();
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+out:
+	mptcpify__destroy(mptcpify_skel);
+	return err;
+}
+
+static void test_mptcpify(void)
+{
+	struct nstoken *nstoken = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/mptcpify");
+	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
+		return;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		goto fail;
+
+	ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
+
+fail:
+	cleanup_netns(nstoken);
+	close(cgroup_fd);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
+	if (test__start_subtest("mptcpify"))
+		test_mptcpify();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing/selftests/bpf/progs/mptcpify.c
new file mode 100644
index 000000000000..9cf1febe982d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcpify.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define	AF_INET		2
+#define	AF_INET6	10
+#define	SOCK_STREAM	1
+#define	IPPROTO_TCP	6
+#define	IPPROTO_MPTCP	262
+
+SEC("fmod_ret/update_socket_protocol")
+int BPF_PROG(mptcpify, int family, int type, int protocol)
+{
+	if ((family == AF_INET || family == AF_INET6) &&
+	    type == SOCK_STREAM &&
+	    (!protocol || protocol == IPPROTO_TCP)) {
+		return IPPROTO_MPTCP;
+	}
+
+	return protocol;
+}
-- 
2.35.3

