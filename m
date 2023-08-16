Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6F177D77A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 03:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbjHPBMr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 21:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240990AbjHPBMW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 21:12:22 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1362121;
        Tue, 15 Aug 2023 18:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9Yvy9kgrwTZ8s5SUD6WAzECtfCpaMjq7KBWetpax2ik461OqIW/Zx2LB5u+dBzLX8wVrU2zpw7+gHoydTGGqLTltIh1rfnxAejW05H7OtKHmkyOcEsYfHkr7bZ1OkbvgVXTzR1/RqvB8IQxbLZgJilBUpjtyC11M99kfya0fYeIeSHxqaQdrhsE9MO38cpVu4JFn4Xt+5Gf+oMoIuhURqqcIEhDTBOfUTKn8rr4ht9BjWCxGLBvkPStgAIobaHY3sDYAh/nATlbRAD433QShRp0QRfuycMoUaazifPC3gYsS63z2Jzw93NYXdL178fzd8IRumaH6fcHJlkcMexjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nf1V/AFdtZNNUo5XybdRlY7HYjxRFoa3VD8beyqYfcU=;
 b=YxtsgIH+ESmtR+ZcmKXSYV/QzByHZn6koYK2OvShQ0t5wcbcKrhfwNJFTE03kvXtB/tYL/GObhgwdGaBvGkBemrAX50anKT6Nqevbgq3ZwYnmEGlsp2GKiOdZFK1UNBY4HpOeJ3j/Y8vxCphaHt78so0YJLgo4GL5inJQ3zBTYy/3WKATyw7KIRsYLE4nFfmsyh6SfRjKPOIC/Ifot+7itgGoiUFT9sd2bXTMeHylsF67+szCNlgp9QzxCBywrKcZOMqhH6o6e5+LgHbaeB9IUJp874YpmVVh+UxwKbV4DU7bw2nTYszsJJR5bL8Q2VNkfk73VicLrlk6FWFnoD2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nf1V/AFdtZNNUo5XybdRlY7HYjxRFoa3VD8beyqYfcU=;
 b=NBRbhswRY5wc3z8Q5RUvlihFApv/7IObHpxAr5XdoksbLFJqOLIMTZUve4ZaWk9OkAN2sxCqWrvg4QU8h76JxGcx/PbNfXI1dF91bhJ4qdUS1QWdBAlGOLwCuSdfmBTKxHxJhIAux4aArVfBBi5vP7+xtH7d08keGVAnmkbiYLILNaroMtPxFdyOCsTeDW3SudX6Ir+pYYTw1R3SwnaFzaSrobuUyRe/Px5xA6qjB1QaLHeXgOkYcuRdfYChUCPIAkgtLvc/oxbeVTu9zznlW5ZfVgflejl7RESs9yAsISqDxf1OtARA74tBtpGwBKkYZ+U0duhtaXYNcdkh2xZv2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9915.eurprd04.prod.outlook.com (2603:10a6:10:4ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 01:12:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 01:12:15 +0000
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
Subject: [PATCH bpf-next v14 4/4] selftests/bpf: Add mptcpify test
Date:   Wed, 16 Aug 2023 09:11:59 +0800
Message-Id: <364e72f307e7bb38382ec7442c182d76298a9c41.1692147782.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692147782.git.geliang.tang@suse.com>
References: <cover.1692147782.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9915:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c390344-fc33-486b-f5d9-08db9df5d39d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8KGxQ83QrUbZ+wGaHCB99ODW0XzsrahW395FWP8lgEZZdiRJKfscq28FG2lntBBWgUgwsWtLcJwxVt3imVuQ31wfKGkSsr953Fmqtez+jYSyHxwfQmXqg8dv3apJVg6mYebkBeOT4Xktiogj7W3E9QQgUWnqVZAjwkh/X00bIbHL5K6vmxD/HUAeg5M3Nk+ayDp1sk2YQoLSfoNLKgDL9CyHbx63v+NTeHthB0cKEYHwO7r/DCfuvleGeouiisNOLIMKhu70sMYzMJiYXt8A60wY4xcbSwG3tMY10xRfe8aaDZGkPTuRYGs2MzXjUfpCxIGq/5ZnZgpLE6PXIJuZu2JZRbomrMOZ30pzjjlgXWowssER61pVKCGpDUIzmqm0IreHNzqmQP82s5jt0GsaZ3wrzkTxO7eupRUsYw4xY+Tsr/09RHa5O/K5Al6LQmxWzs+SpToX+/2tw95WSLUILU2J5wts/+cfYAh+wq+i/0695dffeCmc6z329gP8jzN3yjo0N32SkewEIttWJrX/1wXKVx3Sb0LGN2V/9/HiBN3J7xUp1CznLNs6GJJiFp0l5TIB9PQIRcmxGKw8JgyxuXE6f8T8DMCM0kcyKPX6LzVSeKXtMXqtQXf5iIJgrM3L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199024)(186009)(1800799009)(38100700002)(36756003)(86362001)(921005)(6506007)(66476007)(41300700001)(44832011)(26005)(316002)(4326008)(8676002)(66556008)(83380400001)(2616005)(6512007)(6486002)(6666004)(2906002)(478600001)(110136005)(5660300002)(7406005)(66946007)(8936002)(54906003)(7416002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4orGl9lKQYDOu1BCKdSunhiFg9IseS9Hf73gJjGJFGc/HHXCv7RK3muoEJnf?=
 =?us-ascii?Q?Vh/cdME2899fpOT4w98bjCjcV8ISRsD/vqSoTHPQYVFiNyquQeDLNy8HvP9/?=
 =?us-ascii?Q?OjcmN0al8SF5CGkaq3ICxa/OecIi46bJ1BRnoooVWAxkSuG6UDiAWwKZFebf?=
 =?us-ascii?Q?QLRRqeunCRtpnxgmkLWiwZsisYzNOVC0x/YlZaFrNk0smKLvjNOotluLS8bQ?=
 =?us-ascii?Q?QG3Pd78gkxNEVtDGFl6ufWHOJHbAncVO4/ZKnrTH8sH+pqXDRQGMq4aN9PyO?=
 =?us-ascii?Q?GxWNSSLm9mr9V7sUhEFJSXlkTk8QA5ggei8SiyGbKCAc5ThrvdulYFxO+4iS?=
 =?us-ascii?Q?tX0a+IpLB6m/yQG+Dm/J53esYdFz42PawT1vBbcG/MmzjGC0dgKfHIgej20x?=
 =?us-ascii?Q?S2ALL79Yw4AQVOBPPCX3bUuoOFOgHVWy5mTyyUoIewDjP9+Fr2A/ivhdYeV+?=
 =?us-ascii?Q?tA8kGMIu6uCEN/VFYuEoBuV6lZSWiU1nAAsJ1faBSZ1Uxzg/JO+FZe0Sz51B?=
 =?us-ascii?Q?Qdwq2EghXPcextYnLFFOo+3XZ4uMYKMQVJwG27oq1RY1y97pX3rXkt7UMqLw?=
 =?us-ascii?Q?bjpjDH/FXW8K/Vc3jgHuo4fy5jeYU/2DEUWpXz+ICHq2k9arZ3DvhKRn8esi?=
 =?us-ascii?Q?dsrFezRV2WQRYWPC+TowbiFoTlWYiTQDI2ZVsIe3wQmQHz2sXTf/pmAHyU77?=
 =?us-ascii?Q?C3vQ0NbZz0iBySftuJOgi4kfV5sTwVyTGdMgAbpQhVi+rOjhVLBRoxheWkj+?=
 =?us-ascii?Q?znxg6IYjgMxSaGdgr+5PYKrxY+iCafZV1nyuCZyRdDeUKymBnTpRzNkGkJ9X?=
 =?us-ascii?Q?tiLLgmx9Y1TPNAA7FWPck4SSVULWwO2e1QopHHr92jeejznRSxN3/TY2Ly7Q?=
 =?us-ascii?Q?8oR2+0LJTm7PxLUMTlZJ4Rf6+Hnde5Sbbr5kjd9yaGGDtdGrICyksTi99smt?=
 =?us-ascii?Q?lPkeOcfazr/Rc4YBhJFHJhtEx9WMSIedPofUfzL3S72rXlFiBcw5/koZ+2IL?=
 =?us-ascii?Q?T7GgSmgg0ooWolHp3DfVyHmgYw8/95Jmqt8f4hugcFQG7j7b1eRawZLSqYZ2?=
 =?us-ascii?Q?0hw/MUf4RaSqQey3JhHEz/h60tnFGauA7ft6OSgc3WCQyExdIrJLH663ZYB1?=
 =?us-ascii?Q?ONj3yuV95eUuKbihepYNa/xTDGXwJl8rZzmpKG6LMFLqkaxe7xkekPCM985d?=
 =?us-ascii?Q?QYyjPUFoaT4IMweWEq5oqh8ikRObnEztkIF5SexJKR6UID4RtYkW4jfVUCp3?=
 =?us-ascii?Q?ng8Oe4dkxjlqmBqK3oiUCxn2tWKmyzm26qoSxpSTroDH1Oa+1grPo6EeCpKf?=
 =?us-ascii?Q?+j4Xh+1xQ4ix0ceJiLAE+hpc1C/1khVFoecXkGg58SYVOVo/x8Hbq0RaZh9o?=
 =?us-ascii?Q?0G/WN0V80rP1BJZ8gjSgMyedBHmYRpeHctN2g1kTdgHP/piDBcXWtGvj+7JH?=
 =?us-ascii?Q?D33CkllDujnY6fgm1Ngl79J0LmFMHMZSj8QKcWule35KwKSIi+ZJqHVC9rcs?=
 =?us-ascii?Q?X6OJJ0YBu9cJhhxRArChvUmIIi+Rn5DutDGyqWC+mN/HMXusaELNf7rB1lBx?=
 =?us-ascii?Q?pi20tO3YOOuHyaLVABVlL6k1IwekHi2sS5KNF8II?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c390344-fc33-486b-f5d9-08db9df5d39d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 01:12:14.9441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SN50zyUr/gle8bCzlZF1EpdIHVzuWE4bmqktV7l/ge7G8uIchgm7wqI3lh6eIDJFAKKVF5h9kvhBUmI3PuRhfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9915
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
and 'getsockopt(MPTCP_INFO)'.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 116 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcpify.c  |  20 +++
 2 files changed, 136 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 3d3999067e27..68ebf9735e16 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -2,13 +2,30 @@
 /* Copyright (c) 2020, Tessares SA. */
 /* Copyright (c) 2022, SUSE. */
 
+#include <linux/mptcp.h>
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
+#ifndef MPTCP_INFO
+#define MPTCP_INFO		1
+#endif
+#ifndef MPTCP_INFO_FLAG_FALLBACK
+#define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
+#endif
+#ifndef MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED
+#define MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED	_BITUL(1)
+#endif
+
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
 #endif
@@ -183,8 +200,107 @@ static void test_base(void)
 	close(cgroup_fd);
 }
 
+static void send_byte(int fd)
+{
+	char b = 0x55;
+
+	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
+}
+
+static int verify_mptcpify(int server_fd, int client_fd)
+{
+	struct mptcp_info info;
+	socklen_t optlen;
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
+	optlen = sizeof(info);
+	if (!ASSERT_OK(getsockopt(client_fd, SOL_MPTCP, MPTCP_INFO, &info, &optlen),
+		       "getsockopt(MPTCP_INFO)"))
+		return -1;
+
+	if (!ASSERT_GE(info.mptcpi_flags, 0, "unexpected mptcpi_flags"))
+		err++;
+	if (!ASSERT_FALSE(info.mptcpi_flags & MPTCP_INFO_FLAG_FALLBACK,
+			  "MPTCP fallback"))
+		err++;
+	if (!ASSERT_TRUE(info.mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED,
+			 "no remote key received"))
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
+
+	err = verify_mptcpify(server_fd, client_fd);
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

