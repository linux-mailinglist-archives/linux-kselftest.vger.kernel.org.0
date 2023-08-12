Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5594779CC2
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Aug 2023 04:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbjHLCyY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 22:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbjHLCyX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 22:54:23 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C565C30E8;
        Fri, 11 Aug 2023 19:54:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jw77lHjaZOAENjE9iXnoYQ2OmQRqP2ugD0D+VoL11qfe+OQAUejH4F3OC1Dcz4c2ENcmmpU3dbRJIVAtq3ZhRUGal2GgvG6JoOAteznq+HcmwoQiAPukTgWjnoBgvjMJ5WCIB7liImx4bQ4oIhcv3RaPg/UMY+5lmCCF5htCqvja1KHV9EHdVN6rTtx96pKa1zor4M2aoGhurGW3uahvzXPFp2TjTSaXoasFmgnusjogD9rlaIMwpW7xfaL1OALz3HZGHIGbBvajMXSzCTUGlkxWsjhC2i2QvaGUAJCVh0zZK01ScnW6uDO4nkGtWLq5nB1rWQANSVoaLfmIXyOS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnMhbEiHpGTh3Pv5z2ZWBnzhoqLmwMtcfsxsfWMp5CA=;
 b=jEGWdsx4/R5vlWMwnb/B+cW6pRDbYihO/pfmowjfjK44aH0RE2+rAPwVRkiFnxl/MmOXIp4iykj97Ive2+n4LOaRSN+Je3SThbbckzk/lSSGr3XpBhgMWg1OvPzzU97IaPSHsCHFMNqnB73QREBVKv1QMe5q0dKS0E1pVBhh6akrB4n9vq7E4h50Oeo6lKBA9xtfnng0ROutlLvAsTYd0lWy74w/0QggXwGLWwbLX6FqQwsXRl/xCVVlToTc8naNl/NUHSoKjdXDgVLKqnt34PAeLXwq/pd9dD0Xnw4iZd0sCP95nXmN9gpEFBUW1VO7Yvb4qJLqJSFr1i2Qr+gniQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnMhbEiHpGTh3Pv5z2ZWBnzhoqLmwMtcfsxsfWMp5CA=;
 b=B+HFFbS+hPC7ke7xqXRySxZau7ir151wD+ISY04qIROFGhpNx0BW0vagJ/0BpV1dx1zl3F1e5qG7/RyJP8Icm/X9lypQFSQK9NpML9Q30DNXaMYzsCYd8wLL410u/B7SojdgdX3BmiDBSoJgRRY9qSmpn5XULunZfrUGhkdrjYSf9qqos3H5KmSvsqpyIsNQ8TJnFp0/O9vthCnpANtAIm2WP9sZBSrqSKKzNpXmTwvb2tGqF2Oh1v96JPS5/QOmC3KsrxLLqkOoNkwS5ojg63pUcnTKbJoWbA0B13/GbwNIKsirrfXcfpq/deQB0r3NmvvDcrL+jQsnJCOTgyhHPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8981.eurprd04.prod.outlook.com (2603:10a6:10:2e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Sat, 12 Aug
 2023 02:54:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.022; Sat, 12 Aug 2023
 02:54:20 +0000
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
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH mptcp-next v13 4/4] selftests/bpf: Add mptcpify test
Date:   Sat, 12 Aug 2023 10:54:10 +0800
Message-Id: <15a618b03f65177166adf2850d4159cd4b77dfb1.1691808484.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691808484.git.geliang.tang@suse.com>
References: <cover.1691808484.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0089.apcprd02.prod.outlook.com
 (2603:1096:4:90::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: db2e6c08-6360-43be-a473-08db9adf6d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7a2Jowu9D+GB0yHh0yEFFd2LpslidT0zGA47Jl3wxSqkaWFxC69IfGiQ19HyJEgilTGlEgFlDfBtlW1UFjBCoPanRifUEamO8f6eO6A9W9QJgyLEpzDbYYrNNWKNpJuk+c+TWScoBZ4guyVWirfRajeypLXHtozgwEjIABuLaANZxipHio3SmqmjRo7SF76kYfS0mV2zZL/zj/UkRPZvwvxLPMB2GQUSo4eiI6hcfgz+mu0pDWMoFvCUNcKt8PjcZjwu/HASMEIOCHDOEH/5JX7DRz3bLFnA8tpGJXvKW1szRydnTmsVd6aG0gJRnETcBFeLPOAenus/ZxSBxHj0HlwPkOgRXiinO/2X6TXF6tF0qH31oreYxGCAk5ehiE7j94VL8kXJQkQe5xnCnZ9kLIwGpjv7l9Vrsn3pckJv4bOG22oNDPDUI6eM/GNIAPiv1EA/U88ZzByEIZBCLL2fFLZrAxmrzlLZds83dPxs9q08uBYOeCD9/clf1hmWfdSFbUOiHxptciOAinFO6r3KmyI65vDE0d/qi7baJq66nV2Yib495Yv3xZEdfYxXTJ2rV8+Sw3qXcehNgxnJNQ3wB3Hq5VfQ7RmTU4A04pPqoMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(39860400002)(346002)(1800799006)(186006)(451199021)(478600001)(2616005)(26005)(6506007)(110136005)(54906003)(38100700002)(6666004)(921005)(83380400001)(66946007)(66556008)(66476007)(6512007)(6486002)(4326008)(7406005)(316002)(5660300002)(8676002)(7416002)(86362001)(41300700001)(8936002)(2906002)(44832011)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?szNb0pezRyGgb5/UJNe3uveSUziSlzJ9rQOQY/xBBfAcu/zoae0jY789wgXR?=
 =?us-ascii?Q?SkmuWkJ/1dvXDpvkZVYV1xc3cqENwGiq0lbVMJDX02T9B8Kyf2tsF/Kno1n6?=
 =?us-ascii?Q?4/v8hj7emGdJR35Yxv9HMA1kvm39dpz2SazaT1ulPJ5jcdFqxvB3yAB+PNLC?=
 =?us-ascii?Q?gcOF+74t30qDoeKB3qAuOTabqkhYfC93Aw85hLmDAjGtwa+p0tZkk4N8Q+S6?=
 =?us-ascii?Q?qwoiXsbftYoA995RA8VBOx5HWw7DYDuDWrKhUOfzMpHnyF2vTR3CpE4+hNQ3?=
 =?us-ascii?Q?O4/GLouXhPT29gQrmr17SXCDXnmWYgVwkmZk4+RziToQhugqlmtEWo6LXH+Q?=
 =?us-ascii?Q?ieH0ylIaqmcZDn+2q9EtVOUXhFfPJNs4Nt8oEymUbL324+v6m4mnP53c/wGR?=
 =?us-ascii?Q?cbuErKx5Z1A2CVeQ8v7t+rUHsDelYb5pG5GSgF+s462ErJ616aVq3dluduV1?=
 =?us-ascii?Q?QoIREwdRyhgDNdziXGrt/w4o6rhLnT8G4uJzZyX+vIhRjjbbPHvpZ13c0C/X?=
 =?us-ascii?Q?wxD8qr+koBOotCAgJBsTu+vDil9DkDc121XeEhe1eAIkbqsEamnCHjaUyfBJ?=
 =?us-ascii?Q?pfgLfgBYzWVIemger06pi2I50h7venkvJrTv0npvIXjJ5ELRJPY2F3bCUe+B?=
 =?us-ascii?Q?n6DicvBNYHzo9RknI4tBQIQO6mIb68Hq5mm7h4wcXOVqVZIa7G9+gnEgVGVZ?=
 =?us-ascii?Q?G09B1TCaWco9YNMwFc7hBnbcjngUf1YFd0YiDwW14oFuaM7MPqU8Jw7ris+w?=
 =?us-ascii?Q?r6Ev1SsjGkmycBWPx/ih5btX8Efun3cdqULTVSeTKLysglfaMrZJPaxYIeiH?=
 =?us-ascii?Q?NyWFDFQheQuvYBgZu2rEfw5uwxrdpvSIOQxpfjC8ItqxGjecbgYK6197tUAG?=
 =?us-ascii?Q?bnEh0PuR3w7wxERj8OS0oghT5pPzKCk6bf5QbL9jj65EnXvXnwInoIlPYrVQ?=
 =?us-ascii?Q?VMKpv3wsL7yW1ZVYpitoaF70BFfAciL7GmO3OiSFYexkNKkB/U7UlDcHEEUZ?=
 =?us-ascii?Q?bIT2bQoZB19RepCKKgFFoP2++ZGBMfDY2mtTcARqM5wcZvjwVlyK5cBn29Do?=
 =?us-ascii?Q?ZbwPdTJHQtETqCEbEwY0+2rryf0lGk0+IGZTyiBsZAtxhRA0LXh4kxFK/9tX?=
 =?us-ascii?Q?PTzwm85iRfr++QUoI9LxnQ0M0VSek3KD9k5130aWdhEVnCArY5H9BL/8A9wc?=
 =?us-ascii?Q?noVPRSsEGc5cK0id4K2tbOUg8hHnHkSFfcR7bVoUp9CMiaeycXuMof+VjEBv?=
 =?us-ascii?Q?NCKDaLKM+1FWHQTQkua7TqCE2ydh6ZMjF9kviPxz4A/VPnvCykujWN54KP61?=
 =?us-ascii?Q?ivx6ZVmRfn+iMkujgSCgQfYxHclpZhjU5VwFVr76vUQpEDB3Aj/DF0WWQtIt?=
 =?us-ascii?Q?3K8nVPeRvInp9tba7SbMtRpGR0mGzU+feE7SyGKTm1mYOJYsKBkAJNVQIpNm?=
 =?us-ascii?Q?rByzKfS+vQu2LAWIWZQLYd92/C1KlsT2w84TiGnvKsF3vPeKBBawOxP7XY2U?=
 =?us-ascii?Q?jxEiF/++CppaOENSaSbvnCc14ybP52ZULcn7zjthXMZkDghcn9OvS9de84gK?=
 =?us-ascii?Q?fyrdpSZisiE7GKbM1xaxLI0JLuTRMxJW2XOYjGHd?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2e6c08-6360-43be-a473-08db9adf6d50
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 02:54:20.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ko/Oy0hNfubouJnwrU/+0d5dptbp5FtzVt8RSEWBLIVeoCLBLO52cpmj/8efiILTr4t2wBVxPj8gaPWi6p9lBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8981
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
socket, which can be verified through 'getsockopt(SOL_PROTOCOL)'
and 'nstat' commands.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 102 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcpify.c  |  20 ++++
 2 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 3d3999067e27..a6bbc734a876 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -2,13 +2,19 @@
 /* Copyright (c) 2020, Tessares SA. */
 /* Copyright (c) 2022, SUSE. */
 
+#include <netinet/in.h>
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
+#include "mptcpify.skel.h"
 
 #define NS_TEST "mptcp_ns"
 
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
 #endif
@@ -183,8 +189,104 @@ static void test_base(void)
 	close(cgroup_fd);
 }
 
+static void send_byte(int fd)
+{
+	char b = 0x55;
+
+	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
+}
+
+static int verify_mptcpify(int server_fd)
+{
+	socklen_t optlen;
+	char cmd[256];
+	int protocol;
+	int err = 0;
+
+	optlen = sizeof(protocol);
+	if (!ASSERT_OK(getsockopt(server_fd, SOL_SOCKET, SO_PROTOCOL, &protocol, &optlen),
+		       "getsockopt(SOL_PROTOCOL)"))
+		return -1;
+
+	if (!ASSERT_EQ(protocol, IPPROTO_MPTCP, "protocol isn't MPTCP"))
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
+		return libbpf_get_error(mptcpify_skel);
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
+	err = verify_mptcpify(server_fd);
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

