Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE4976F969
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 07:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjHDFK0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 01:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjHDFII (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 01:08:08 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A412688;
        Thu,  3 Aug 2023 22:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp1stQ0qRXhZ5WM8s49srNKcpJF+DMtKny7Vs7qIoDKaTBLNyhOkeaDuftbfoAQjH7xuhOn7uRZMqF7twiyOiad8yEnu421YL/WqmOhkijkZL789eBrpAARCmB7RJrTArhKcvSMHOBH8XOraswaCdXn7ufoJdxDFkUioYQjEB2WWiqEzmcEss7aVkUIV6Fi70l1BjxUabDKz5jENoPpyFQirhG+5Ko3XXA6P9ywAK1KUCYBuvLYDRHjftzH7ua+5IFMvDtADt8LzGJQc+NabvUOjqYmPSxCQ6kMnqQP2BKXr6rkbAVWV/CGXrfdU8VO3zojt9oSuVdI+n3h/6cyWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13wKlekbfF8LLe8HDSW1X/4CtojDqgveqxTtDofm7Nc=;
 b=SlYIHtMmpHrQc7+betHc3RPdDLBDrUHsU85QURegKdJb4CP4o1zzRgbg8ffeVd26qRgi+di+AbRLhIkiCo03rdHwN/8GjxNSweW8mibbe2h0W6M6v7IcsDjX2xt4dvWup6SF8RHx3MCcYP4RH4RqXSM9Wo4Gh5VSu0mJbgGX2MY6/YDubL4VU1HaTHv2s/1vNd9wX5YIf9y47aJAymLpEJBmv0ApQJefF6QSDYYB9FdSaRiJ/Cos9+71/4CZOYBiCyNWX1TFG5BO5eafIcARahQvylo+fIxk3B5rcvV56qKDL3U0xYzg92Ayp+/sXkuysX+uNH2RBhebbOsa7sV6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13wKlekbfF8LLe8HDSW1X/4CtojDqgveqxTtDofm7Nc=;
 b=0ayBoEc/z4HU86pWIaCBHvGUQ75s7e7o6xvq43Jg3bZ93Vz1+//BBavtMU0o/LW2UtRaFNN6l95mDxV0AfO//SWLKS5ruii7EKtIgqH0qSytWL5KFiZ4PqwpARQklpFDnHGHbKgnuoq4QNBM4yPCgGcQuFU77yd/SZmr1mnGkz6b1YfijHTH09VwY2RizgAFZXhyImHX+XcSGp/uMek+VaQiyurq+Ll8qiVlvm8SPRgjLFicvBBPmrWhUqJfJuixSIvVfxPbPotmWxR3X14a31rtfQ5tI1/GlJ/abrRBzeYwfk1LE55GnoYeErfY3+HS7eHMw/3Slw+Y9uYklsHCkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10061.eurprd04.prod.outlook.com (2603:10a6:10:4df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 05:08:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 05:08:04 +0000
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
Subject: [PATCH bpf-next v11 5/5] selftests/bpf: Add mptcpify test
Date:   Fri,  4 Aug 2023 13:07:43 +0800
Message-Id: <1effb0a793140532be749aebbd7912798245745e.1691125344.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691125344.git.geliang.tang@suse.com>
References: <cover.1691125344.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10061:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d99d15-374d-4a51-4978-08db94a8c882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCaWEUj/MudoTB/hh7j1DwnGjzPFOXbwweOONlRNfOZt0oa2mcAXYed068KzeStwWvknzPT4VZKvulK0ViQ+Z2fxxKz2md7wBToMDTX4AYNas+JrklGudJnTDiUcAI1Pc1GpP5Qqxwq4BfPA9ixxpf8/vth3JLqNchlmAwPQaZLID9ykOnFejMO29MVcNuR0+ZGJcf1KjEjSSZFFyDipLspnjiPSl8E0hlHColxQfg6mQCDKr4QmxhucrqZamKX025SyGqBe9RkrKHVBXSmiFjHwG021t/0BnfWFBeyp9LRIVBt5TkknUSC2/YJMKwlSewwGVlbR6lQzinQmhi8O3x2PQsJM6RL/LRNDG9oWOc69L+fjbnK22tsKdveK1kDtHXzoKUcsrGfL4EAS58QY1XFqN6PF6rtrQRiBJaziaUlerbINOxFYWnYR4dKpmUWKcAltfTG9zD3FeiUAkKlxlJXyncWXJknvIDMsePqdkqShSTQnb3W3sNWUwNAERP43YyuGlVpaYcx1AjShgD8Fu2n7rc/gWi1K7HL/HGTDl2JFp0eDSDWuXXx3zvZMhX6pGJFRvI12VZoQ8Z3E+C6dGwpQIW5mqG8tg0RHHYp4dgVvhOPWeW06RGYgzcoR3m+e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(346002)(376002)(1800799003)(186006)(451199021)(86362001)(36756003)(54906003)(478600001)(110136005)(38100700002)(921005)(2616005)(83380400001)(6506007)(26005)(6666004)(6486002)(41300700001)(8936002)(8676002)(6512007)(4326008)(66476007)(7406005)(66556008)(44832011)(316002)(7416002)(5660300002)(66946007)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y6T2eXF8lVUZPGelLEUZp5Rzt6rt7DTE1cXpCLIg85ZO1uc4zOkHHBl0auII?=
 =?us-ascii?Q?ylhPZ4p4Nc2D5jJ1SXVFp7adJuficV+Ts4LRsF+tOA+kxjGsPS4qS3/00Ee6?=
 =?us-ascii?Q?gNOI68Y1HVlmMy84iZkYtBYF16IltFDJELGi+kmtrpBpXpsJ5b0hUZRMS7Cp?=
 =?us-ascii?Q?QDsjWNQRah6+7j9H654LH5iPVWY7u9p1UQwKfGF0M13wP3aLA0J4mafvKVm5?=
 =?us-ascii?Q?yUuWi7/O22m4ilfA5kTrG9ZzGoqoYUsI5UzmBa9+aQULLuNYmE4PJN6bB5TP?=
 =?us-ascii?Q?7iHFVX5ItnofMpG1+m2uGMMksb1pF13X8RIR4xcYW7+FT3Ap07i0dx9qEn4/?=
 =?us-ascii?Q?JRZgQTykMYKJUwOjmFD5Mz77zxBzi4Zsza+wEQLYU372SShDRGvR72kp470c?=
 =?us-ascii?Q?PbyNJHTt7cD3S2gf4h6ULWyXrmhDHnBhuzzeEsGnonjNQF8ejAUwsaZKzCkD?=
 =?us-ascii?Q?GdzQbk7LWeP4PiKhXxYTGMGbb/QDlqQtkDtHj1UT/zYE3zRKUEAVD2iz9Fzw?=
 =?us-ascii?Q?LxTD+qMhBgf+XW+fs/jbDam+JL10uVBXf0txAgLrqBDBmzF9xI1TjabKOLjX?=
 =?us-ascii?Q?hXFDhSwIz12r8Chl/0fV2pRczdgsKdBnlx7RUZZ6HoO6dbEoz3pS4IQFpihQ?=
 =?us-ascii?Q?lL1lhfQ4bTM0eIgqPZNAvhiZVDzT4Vjq2jdXI+S5hbkjICmkPw+Z8lh8l9Uv?=
 =?us-ascii?Q?EZV49PUX5z4P6Kvbb+afQgJKdBF/E2LA1yh+3YqGRhpjyK/jMP0DjFdJUt43?=
 =?us-ascii?Q?LbvhPC1etP2IQo2JmM9D14oBmVosVN6c4GV9XcE0DwN0vCgE3EBYkpb55Ahi?=
 =?us-ascii?Q?0Cr0gAsTZ75b7/DSadG2NfHPx0r98gPFk3IHRqhzro3cg9Ik7fbxB9GfO3iH?=
 =?us-ascii?Q?1gu/S3TFCrmwNdgQmcCeGCg4vaQ1bu8mZZdWwLsHDm0uetkClNzN71NGNIoY?=
 =?us-ascii?Q?iP9SApG8fJesZ/ZB7OWqp6vJCgd0AAeiK8B/X/edny4ujQkU7XkrWE3UOvq6?=
 =?us-ascii?Q?0p1H9CcqQY+7VYFgyq13Kmg435A1L1d8qmSCAKlI+a8uMUzF9Xv6r9G2MeX0?=
 =?us-ascii?Q?rIDXeMmTiQVqwply8nwcCtT6ab/bu0gCNytlOqwONtqsdzEnzp7qKbupkM/1?=
 =?us-ascii?Q?grNgPpGf61Of6LvTxz+3LwrYMO2VZ80MLbKKHK0iw3t3XcB11S0bE4c1i3v0?=
 =?us-ascii?Q?yh7rm7Q1DL6b1PzbJ7rXIcaTuQoySk2411nhGFbw/sufuRQ+gGlmYIrfD0ws?=
 =?us-ascii?Q?ZO41xYyTMT3f7M5UYCUCJmBqhZbzrdFY3MvMxMaYvYDcEHXoTCpHsJia3h9o?=
 =?us-ascii?Q?yydSb22ViIuhhKUZ/aXM3b0BRoHauyr44XEpD2vRdhIX/wMvbpP5wBGm24Ru?=
 =?us-ascii?Q?Sk/eWY/lGsUSyuSEo/lyPEuRzZ1J+i6a23K52ry70Xu2PwL8rsx+Xw0XOnYt?=
 =?us-ascii?Q?CoOrhGsfa4ormf2+CW7UabTwhEW9y3WoLhC9kQvmnUAg/BPHq8FP3S9SyBq5?=
 =?us-ascii?Q?N8BGuHj7ACSuMiKuJDEhInr7GdCgo9lc+7ERnj5sx61109PMwnlebTuzhom6?=
 =?us-ascii?Q?fXYvQFBMR1r9EomsMwdHFZ48jWCQpc8gk9m8j1PD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d99d15-374d-4a51-4978-08db94a8c882
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 05:08:04.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPTjeTyQaJ8QqMokVWIqgTj3v+UDF67SlaLvcAoT/JRZBPMnhV4ADguSxAFmwaPXTfoODBHVzCTskLIOV7qYOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 98 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcpify.c  | 20 ++++
 2 files changed, 118 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 3dc0ba2e7590..e6aafb4cfa8e 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,6 +6,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
+#include "mptcpify.skel.h"
 
 char NS_TEST[32];
 
@@ -185,8 +186,105 @@ static void test_base(void)
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
+	/* Output of ss:
+	 *
+	 * ESTAB 0      0          127.0.0.1:44180    127.0.0.1:42225 cubic
+	 * ... tcp-ulp-mptcp flags:Mmec ...
+	 */
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s ss -tOni | grep -q '%s'",
+		 NS_TEST, "tcp-ulp-mptcp");
+	if (!ASSERT_OK(system(cmd), "No tcp-ulp-mptcp found!"))
+		err++;
+
+	/* Output of nstat:
+	 *
+	 * #kernel
+	 * MPTcpExtMPCapableSYNACKRX       1                  0.0
+	 */
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
+	int server_fd, client_fd, err = 0;
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
+	err = verify_mptcpify();
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
index 000000000000..53301ae8a8f7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcpify.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include "bpf_tracing_net.h"
+
+char _license[] SEC("license") = "GPL";
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

