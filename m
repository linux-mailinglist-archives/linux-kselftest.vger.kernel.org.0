Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0ED76E1A2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjHCHgX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjHCHfi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:35:38 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2057.outbound.protection.outlook.com [40.107.13.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A181D46B5;
        Thu,  3 Aug 2023 00:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcfNmCKG00gaZ009jvHNpqgk9gmRdZLucdjbUaw0GFEgMUT2wSMGPnQYVL1gqGSDeFtRE3zs0r3ldOcS9tI6bBA5F23L6OHxxwMFW3qSw6rlXpL4z0fnr9txF4MykZdnvCw+Ah2qIl5lUufNmThp5yZI5P69Oz0S+hus7+unJ7kK+ZuRe71bPZaVZV5S4p6Awlb/QpRKvcMCCQOPf75nobB/Io/G18YB0BqDa9tKj3/TBCAfgTS9RmhjlzWUFSGqS/hk8sn6UMxoSdHRN72IAGzs+syqJL8Ia3qwaQydi1HA6YwUZ6VdEGdVdauq5ACEwb6uMU4hhETkbjpuXvBw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxXqoum9NhQcoERuGhzIEPoRQjesqfpaFmgm/mh4i4c=;
 b=Zq2SZ6ZwMvgOdsH506kgZtm9sx9xT8nZOS7Z6ACyO1StWGOHzAfwDt1NFvIRolsTzHvXjt9WwjJeSK6L+gcGAcsYmwA2wsKqdTBV9ssDF0t8KxWzUumMHMvkcifsbxmfUIwcrocfkt+JmkpnimWJogBJ2w9nBQ5hRlqV0B7F+vYoh3aIRFnJNaDkZcODIZVMdT40l3tLcrA4aDTl54wOlXspZAJQ/zNLJU4vEBsx62OuT+HEWqNc1FSpHP7JCR5hWJRQHyzFgud3OKKvqSH8klxIlC69kvfKquvOc6A/R3c7qtw/mEhWGrdtTemR8CUzwnAVhAVAr8GKZPHzaaiBaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxXqoum9NhQcoERuGhzIEPoRQjesqfpaFmgm/mh4i4c=;
 b=Id97hJRs9LRUvdjvjvgnzM3zJlWekemCMWlaJt8ZoT/1nIYcptjkwFlvMeksMXsgD7t1+ybYk8gggkEOZp6Wkl525eQFOBfHNjB+gSbTqxHnvIVCtnE15SPtblUI0t/lNKgjIEUuqbiVf1K+14Z4EBNv0Amb2nWxpTSOr93u39ZzE8jEi+orDNKVNke2QkBeg0z8VtroY76WIFgCGt7sxIyjC9waocvoL+2s/hKCwTxqdzk+OJ0514mNm/G5QkrA3UQrkBWI1cfyzb8lqavHkkXTIH0NW+yAxWVWBvvgEIzfc07tvY80qpJixCfL5/3Qqo/itPgIFkTnoAF+vReUmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8571.eurprd04.prod.outlook.com (2603:10a6:20b:436::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 07:31:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 07:31:21 +0000
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
Subject: [PATCH bpf-next v8 4/4] selftests/bpf: Add mptcpify test
Date:   Thu,  3 Aug 2023 15:30:42 +0800
Message-Id: <4b95511da1a9dfd1a55734e32b7b6510739a7ab7.1691047403.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691047403.git.geliang.tang@suse.com>
References: <cover.1691047403.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0036.jpnprd01.prod.outlook.com
 (2603:1096:404:28::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: ca065f5a-b85f-498e-7cd8-08db93f3a1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obDaF79jR3fErVYYvkxiHpwtIa7G4N3LFe0LEkAwxpmBIXOLI5bdoHMz95M/RValjz9BR4g7NQpy2mY3p5XcRV0a3vjFooW/3rusHffypxjYIaELyqPV7IHrC05iawGZO/VGVlAcFyr4mHKyEWvK95kKOFJ/dD2SGEIAZVTevspbbqgh0ynD+hKQjbn/ARenW0d7pS2Ax9PtN3U0FSp3HLEbHTK8eVuWRVz9JLZD2IZLWGLztFMWeJEmrJ13tu3P9XXz/u9z2FHMsbhCZKWwkAzJ78KT4+HJ+F0LqPc9XIRIpmkyBHpkRNIyRsxSdE4j2pbIAeU9rbYGVhnSPuOZPqynrWCNIx6cKT9h8iCo5Cdn7l8GLUdJUiLmahsVGvxpFkEKEZEnu+mlDOKTUC5XFEu+eiewF/qXzjidGXCH2itBm07nXHlUQKC8miztgeAXONBqU9fpMujYtHxMRmMnG4Obte7nI+OMmB2TTqaJfyGR7Hd4MsiEytgyT2kNDlUwt67qRN84V9cb0FgVhK4LUStIzIQcEALautCXGYLMEmtAaJ8I97DNwKk5+t47JKXDVH6aFFTLfcAm8vNx1eDWpZ8l6g6JyMz6Sk+HBQhZNxEDrhI81aPIEJW9ZNuvh8OeHOQdCJcbIDHhF3WaORydR80o4RtQBPzcevypr0HV2Tydigqz7FMhytA1yl7BMBCF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(6666004)(110136005)(6486002)(41300700001)(478600001)(7416002)(5660300002)(8936002)(8676002)(7406005)(186003)(4326008)(6512007)(316002)(66476007)(26005)(6506007)(66556008)(66946007)(2616005)(2906002)(83380400001)(44832011)(36756003)(38100700002)(921005)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?93xKlZa/wwapV+1dspy1fJhHV7ciQskSQVIep2rWEkHdnTGYZu7qqyx+ZLu0?=
 =?us-ascii?Q?7ykBZj4Ohm9foEmaUOyyBLTych0LB+tT11+QHjmocB7lP50D9jAqex/2B3Bl?=
 =?us-ascii?Q?8WT7mwvfdgAIu0jRnKPk085kfatEcnty/9VrbwF9a2MXOrBLAiffHa3v6JYW?=
 =?us-ascii?Q?HYEqp4CcziHF6MGtjUFCjGb2P62AGxA8JpeuuaOGaq7l3BYzd3XYwYuiyhbW?=
 =?us-ascii?Q?iipF5uMD3osoB0xNmzeYGXOoRcyIzKyg7a9FVm2iIVa9PmrphsMcR6fhQLCq?=
 =?us-ascii?Q?gYODR1TFe/vMFWt7T86MuRrhlhgmqwuBuBMEwKlojaKbGk+3GrxGDvmf1y4Y?=
 =?us-ascii?Q?Z+qrG0dAGu5aZNLbpdLh9/icEHWuuqzss7zKvP9jbDsfDnVo4YZezOYRSIgd?=
 =?us-ascii?Q?DJ11yK449Gq8lpydo8U2h1bw4/CVEbFAjWVVbxifBHGlWoVqZpRjAPdfcZrJ?=
 =?us-ascii?Q?105GLOVIAa7nj2/KF5BAj44WTOViAlnM1KFdQktPYj4yEGQ1Nr/8f5Z4rWaD?=
 =?us-ascii?Q?xVD69DpfCctAMZ074sP6ZRk47LARv1JkiPw/nVhVZiIDI6j/MMDGoo6JgHUK?=
 =?us-ascii?Q?h5NT3yLpTh4fpLytO1QkgQYnetKYyz6JjhvhSpQ44sID97+ag7oi8U2tcH9p?=
 =?us-ascii?Q?ZgL/fV8ylWKLGc6knzW7f7WgKKRYw8pvs/scmElkhQXJDLQiyMRsIvD+6MFD?=
 =?us-ascii?Q?YtAqV2Ud6EWUWJfLr7/hqjXm82bjWDa3/kWZAS2M64swEP5JMvEE4gtFqjds?=
 =?us-ascii?Q?jgb1y3ZsJNMwsb5dxNpzy76dZz3vXR9WiBAaiCqpqtT5k7PbOINUVRcHXAwV?=
 =?us-ascii?Q?uHiSJscTa6EjDwtJKaWYzKZru4p2xNrVAvog+mHh0Y9mTINTGKKV+Zs/ySaq?=
 =?us-ascii?Q?r1RcOEvxVBcVmBUMTKrWsnfd0OcwykNGXhDQXFd4jJ6rEqmAIeJwmii2K5Jj?=
 =?us-ascii?Q?wZSP/rxGO2ZlTnaXDtZLecDo5n+CJ1VzfvrvBCHbLUI75sidUL+2merGjLTf?=
 =?us-ascii?Q?SZlZqkXv3gNbDp5CHSxaH2pxHIfwaJ2eibQeNSP7tXjvgrO9ougW5TmzGhOP?=
 =?us-ascii?Q?A+A1cAIZHsXwtp052AW219cXtyQ9ieXnuld1jfA1agaPv4ajVSnfwP+BSwX/?=
 =?us-ascii?Q?ldkV+/CuIgs70qRkgRUlunMtXqcRq5HdDxUsB9QyDH+VDUOY7TtnVu3Qt0Ql?=
 =?us-ascii?Q?sWF8gAAKkEDdA7eaM8xQ09S4EpHwdkGeqQvtAYrwIoj/qYVHhzdxY4dOKuF6?=
 =?us-ascii?Q?vm08PeB7Jw64xGg/s7BB3Smil2lwcCjUczrcNMhH3r+F9yr9ABEL7Rr7v8OF?=
 =?us-ascii?Q?mPaep4R2iHOXiyXU939Tmfd+48kXFt5Oaenju1D213qo7ukTJSdnDitcdPKD?=
 =?us-ascii?Q?zm7P5hfvVzatI9656Yzl0rn/K7u8aYTJbuWowRPwj6ktsNeHLvXgS45l9+rJ?=
 =?us-ascii?Q?CiXT1Ri0pqpqmZokuWWBJF1hT9lPr8pd7AFZ9AqRN52Lqw6KewBLutXYJMNC?=
 =?us-ascii?Q?+POJPpemffpza0ZUl7n560TRagbxI/kbP1s6Gi9qFpzXjUDECKAviuf9LMq7?=
 =?us-ascii?Q?fqFSdJDO02mMAEQTFeyUPhYEQmPVEPB00zHEy/Zy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca065f5a-b85f-498e-7cd8-08db93f3a1eb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 07:31:20.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OMMfRJ1e9oC13G1Dof9Ec5krmXNHTlf3uODEaJ4CKNq0to9jdy2dlf11n3XAeAYKuJC8N+lNAY7oTvShdkdWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8571
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

