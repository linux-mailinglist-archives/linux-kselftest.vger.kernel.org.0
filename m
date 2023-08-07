Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26049771A37
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 08:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjHGGXY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 02:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjHGGXX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 02:23:23 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1EF10F9;
        Sun,  6 Aug 2023 23:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Diw5fNLug4A90ji9r+lqVcuAK3WgIPfQfz9nnOn+iMBhGOPHa/XF3SChUtdEU6QeytQMvlfYR9uVd6Nbt7uduGRSVgejLTO0gAcewlAszGzv4Wwf/ORI4Jr/fjFlMOJKWkVY/0vcm4TB98PZHM4KQywOl0spKuLi1A7odVDD7807Jj8rJiqhIYJXRk2IrGitiMbRn5Tg31fA20ZnG8Hr586mLFibQePLu3ouD+kqclEa7oJHpOq15skZe6izFf3TtrsZnqEvM09AZuVJCtXKE0QQPwDhpe7Dv2/hiOqUEPZHpadmABHK+csPwqRyZVf3c9caKAhP6cA8Um9YCqTr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjvDefk6SgiQC4Qg99jZTVvTtpr7OsvgN+ma0j+6pY8=;
 b=OZ+3orlUvEvTxVz2TX+B0nmhCFTYwavihEw76RfFHZB8U02CeGwmKmsGlt/3SLF2i6DUOmv6E/SrVIyQS1k+lokcRTvQxh9n/P0re0l9PN8H1mDQB2Q2zZv2QyKLq9mMXpIsG0agrRA4f+yU6NyayOlwSOyAQQ3HU5RqZTo91Nt9V7HvB4W7jk4wrMrRaMbp8rJwd0mi9PcDHiBXkTGYbvvPBtV7QnURPWreoCymGJu0ywOaBvtO+kryi5+ZYos1mY9ZNpulxmhZFaezMAe0AEKjsN1hfrpks57w0fy0j+3QQJNVX7UgDUoe9ghHKALWuWIS05u4jS2pRmr488QhPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjvDefk6SgiQC4Qg99jZTVvTtpr7OsvgN+ma0j+6pY8=;
 b=xcqoPT6zsVl92hY4VRwQcgFHzCarrpRTSKXXAVfIQ6hPMYsKJKBhgKTBFqos1UfLg6TmZ4mZLbmV8YUAUVwBOR9MQzyB8HdE6xQQMtR4CRZ7YLsIX7bimO8nCwBbmTZ8q7ZRUVGV6HVHzzcOFNj0FexwAYe8y8JEvRcerKY5HWzGuzv7jNShbgaoFNDs6R7OYMU9BykTBcYPkPylvycm022M4KATcUURE1B34WtJb4nOdU1Y0pBJ9J5IlXZsa83m6MycNes1o0VIAJ+pMB/c6DDYt+obtiP5TDiNxSVvN319Kh2UrT4VKJllaDTqWkkTbdIbLMKG9KnMA/xlvuvcVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8883.eurprd04.prod.outlook.com (2603:10a6:20b:42e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 06:23:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 06:23:19 +0000
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
Subject: [PATCH mptcp-next v12 5/5] selftests/bpf: Add mptcpify test
Date:   Mon,  7 Aug 2023 14:22:45 +0800
Message-Id: <631531b093d54fcd0c4b33bd28b7387f1af174f4.1691388735.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691388735.git.geliang.tang@suse.com>
References: <cover.1691388735.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:403:a::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 936c257a-c540-42b0-b1cc-08db970ecab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: paVBQPchcssr4WpWQZUonQS3D9OA0rF6/Qdb7M7aEuRvs+hRdmqta5kMhoUzqSWhCDrhi0/VVSCyv0YJpO0/Pv3Dv66Uw5Z0cSXvIXxJJISyh/TmSZTbVUOgjcnc8QGRbWjQj4rdVIJ7XymmCJZM2MTn8qa15iyQB2MQbcWMOoMBFP21/WRPJVbehelIURgzZbzuVlhfw0/D5MCRS70FB+oEXVkQHucGWdcFVP6lR0foCwyO2NKkuAdbjFoa4Boh0K65M7xWM7kwLYLxVql00n6QPttt/BdBlxR0eFZ6Dg1wmoP7vvBrSSkKbvxTlSM1WvTsgxu4sr+Hcl5GWvU4mjz+36fXHpY//zSevLAgkLC4grFfCsjPfOyBk6pA6si75THz0M8JphHU8k2NEvvZK/ye8sleSeMXfesE5qkNAGWR0cfXOEwSsPckfn8P5qXE23J3p3MkRFkeCuQ+qyRYDODrVhye2I3CX8P67uE40b2Gfv/oA4aGoWeybg21ZTpdmOnTO6ZmgzWJbLicWKVBLCffSabhZvgzjE88nM1PhG9eKgN7skganKYZ2JI6pHPV0/+aNOL7t8fQZOGMVOcMHip57k5Snn5nh2VuKFSWBdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(86362001)(478600001)(921005)(54906003)(110136005)(38100700002)(66946007)(6666004)(6486002)(66556008)(66476007)(6506007)(41300700001)(26005)(8676002)(8936002)(2906002)(83380400001)(7416002)(7406005)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CTeboawSQpXP162iwjU/Cyl4fIMJ+yiiir8LKXL85Q7gvcfnk47+58uOfg0X?=
 =?us-ascii?Q?dNM4xiiosCNXovvyrV6LclibjWkwIVwKq5KazqQ8v1b4xVB5fpMflECNDcuA?=
 =?us-ascii?Q?7BoFO5nBkViT4ayHqfSHIyBRYvg/HguajHhqW2v2QpKqqffm+G2s0pn0or/H?=
 =?us-ascii?Q?IJwZ2005+DS5xBE6m/E9FT+InrmL48V20P0WFD6GMii+Z27DJoEngEvFtN8I?=
 =?us-ascii?Q?mDLRPiBzq22EWYnMOodysbXnq+cM29NWueh4ig2piNLoROISwL4Jer8ei6p6?=
 =?us-ascii?Q?ifGwq5km1ii0Hnw8Jk9DskuaeUAueTXeokCIj25GrlQXEa3cq0DmWwvqAf7B?=
 =?us-ascii?Q?L/ZI2guzDQDEo7OA+Vwkv6u8Kl+Epf8k/3LwtcVQN8Pph9YpaZkm4s9Mcedi?=
 =?us-ascii?Q?V7q5cdTDqThVwYB9KlVHyaHEWq6Y2aWjvw5M44snB8+fqfZMSJ/uI3i2SM+p?=
 =?us-ascii?Q?8y8S0MGj7dRWPYnh9IUlmwmunthzz83FTnn8dEc3Hi0znUSkz0ig1p7M0ct3?=
 =?us-ascii?Q?36oPVq6vqUZvVlICj2hXFplhYD8ae3NdviAiQ2uW98F+siKWSw4vWXtEH5pX?=
 =?us-ascii?Q?u9E0UixaR0d8nECDfqt7zcE2YBdCedIp0TQIWZpKP78QfBAGzX1+LJ8nLsck?=
 =?us-ascii?Q?9WwTjAqb14vabEcfqZWIQgO7C2GDeSk0cdoFCO2rgEpLUJ7OJuiCFhtvUSbl?=
 =?us-ascii?Q?tf2v0tqQBOiiTcqhQsvI5jNwN2KVc87TSuEgpgXv8mkm9Y8blM6ZkGtAAJsm?=
 =?us-ascii?Q?GqIyR61PKlcrSNLF1MgG/swlqGDKTG2HbeCGliQi3zW+P5CRrdfSPuoUVFqE?=
 =?us-ascii?Q?WRfj0VYX3SQjF8N4rqTySKbolTeBynbiYWioyqF1N/YilRJelXaVgRcmEfxq?=
 =?us-ascii?Q?KFUa01al7uhu1pZlQVutWv04UKD3qxpseHdhm9vN9mjW3hlT4y0AkAfbzGWm?=
 =?us-ascii?Q?F8iwaIHv48W9vsM2oDPQV1PpsFwsSHpUx9xm/v23GK8EUaZ8jMaXO+T56jfr?=
 =?us-ascii?Q?hHsV4tQeXk57N9Mfoqi9zmF4Bz1j5zpIPhT2eW5SPEoYHuoRw91bCNL1MwOb?=
 =?us-ascii?Q?YBrQx05tsfJuBy8RmWZe0gK/aabclmb4U8qFWWsrpLLPqUV0yANUf2zvitEM?=
 =?us-ascii?Q?dh3L6YqT/kxRxBotGnTiC7NbPmIzSf97YcxtGl/vpiqi64SEtpLmkzF5TmlG?=
 =?us-ascii?Q?vL1ZLnUOBwXBD5kXBUuAmhlETMREuaumwjZm7B/9OdgQIIelxCW8FNH4ZrQb?=
 =?us-ascii?Q?ARNIljH+p5TuDb4S31YP5Sbf6Yit3JUoyIM8zqEBN+/9jWZiuig2/v9fSX7o?=
 =?us-ascii?Q?nVnFw9jy/Qw6eVTyp0NDvPeMiAkAI5euTOWQiI1XSvGphNG19BgMwEGwmjXc?=
 =?us-ascii?Q?0m8arhebnExMuZsjBoB9e1/d6qg+AFkqcCOgBnK7RV3jUufFWVbUr19+mGta?=
 =?us-ascii?Q?td6k3YBlld9Dg+R7jzUVZ+6qVhNBmujoB3eqy31eqWfKynsPda2SRyKa21SU?=
 =?us-ascii?Q?Xk3bPpi7N6kIBR4+NXVzJSVArSqxvGOEhGzBtu0z1BWwJ6XOzL8u9KFrsMs1?=
 =?us-ascii?Q?zZkN71+YCpW9HyAt1o4BdWUiU12u63iQhCiob6Yo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936c257a-c540-42b0-b1cc-08db970ecab2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 06:23:19.2724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRNxlGoBUeEcYIAbwhnI8zgHLxYxfHWB+69CCDNBt0OgEzzIcqeHYTtpIs+dg0VubiDFqBG7T2kBfalKyRIsBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8883
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index 8cbd72981a01..16353a35d288 100644
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
 
 char NS_TEST[32];
 
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
 #endif
@@ -186,8 +192,104 @@ static void test_base(void)
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

