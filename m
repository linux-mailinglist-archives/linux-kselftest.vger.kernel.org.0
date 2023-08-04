Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D6D76F744
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 03:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjHDB40 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 21:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjHDB40 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 21:56:26 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EA1448B;
        Thu,  3 Aug 2023 18:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiL7ZnljGRyMxUp4LzhU7/r/IKLo3yE7d0crX5HqJ5h1umQUx9k2+OejXtz2jBpLA8jGHbd68CE6HPubXo2vn/1hImOmwh+BxcNVZ9ix+/jHsIJWgIoMYm2mas2RGFcoWIXNNLklmPa5+4qwFxJ06EOsjVzRoCRd6J43KW4BVekjDgaGD2uWh1mzu7x+ST/tqzOQwCjXdlE2ZyGKVTEr0BMRHc4HgYKp96eKXiaWhMHXAA6VRYjWiwhsugNms953qLiP1h3EG4TnZSrjJqulqOURBdDneQQuc8Sku1+Cz6e/jUksMMkgNS6IN8DFHu9yrEwxstlnJp9yCyy9HqWyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaZlExH8xswLU7fz/Py3NIyuDYG7Admr8DChIytTejs=;
 b=GFPGjGfZiLC06VXcJuBwUFomT60CxCXrwl50W9tm95pklE6buJ7wJ87kAUTlYCTXHLPDSG95lfYSz2lT4kUJAFVg/ePJ2q2WDKG05mAGBUGZRH7A03A1jI/7wWOnJXROKEuS3LWqwhAFxz9iWQSsCKkk2Xn1CWPf+b7RN5urv5yB2fhhPpIijIuoKvm5iSYyaN575Dtr1gssLPQ50PH3M4rIZchI/O2VtSNiJvHVZkU1eGxpBwPwAe3iKAnO4ipbpbTHtj8nKcI1NPS2AKl4QkMGURzPYVENEFwv7U5pGkTIGex07/bpvWUeYBq6L1MpM4RCDUxYOx9cK8y6gxKxkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaZlExH8xswLU7fz/Py3NIyuDYG7Admr8DChIytTejs=;
 b=de99LX6grtoBGKbRG6O3oQCpOtg9ehlRjyPB5/JTzm+bCf3+7GyWSCX55WACaE0joIQ9InMrONdzeunmmrMUsg4mw1VSq4X9esxGpelhXNmqzS1QVSCgONX2kSvqetMhmFDL2oHXgYFFfFiPYr4rdfUcCCuDTibLop5hCc3JGemIq96buazLJA92vkBD11LkK8En1hA9Q0jiKtn1yjNtChlkUesBYTJnj52K1FRkMBQ100NlOifm00+z+ODQyaRaXMlBWkKNDiOZnWOn9GnP/B1kZHM/q1mz7vlp56rl8w2QXFe7p8k/oQlrea/HIOF+VZjQCIZIBcxsjvczdIfRFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9085.eurprd04.prod.outlook.com (2603:10a6:150:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 01:56:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 01:56:22 +0000
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
Subject: [PATCH bpf-next v10 5/5] selftests/bpf: Add mptcpify test
Date:   Fri,  4 Aug 2023 09:55:47 +0800
Message-Id: <db0d187dabf08d272a3f953cb2edfba8e8bf47e8.1691113640.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691113640.git.geliang.tang@suse.com>
References: <cover.1691113640.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eead2ba-998f-458c-d9b7-08db948e0091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PebSSmdsCSqb6gaOSYjnT1avmhOvt1Z03zjkeU3E5yoAopKI/7cmIC/8Zyxvm6oAXqM1TPtb9kjYq8ZhbbhV9z9A2NbQRrb/4efXPax70eWlqIbMqCSm8n0h9TOLc898/DQsLG8v1+JhV491FFkckWWL9O6k8EPx1WW54l4n9bD6eR3ZAJT32I3cUNxKH85bG19o3LAzxxJBM5s5Tb62pV/xTYN3Ql584ihSSk40Lu2q+TFZ8joDyeaT+bhIiQbAdlpDSBZs5VImA7JbBEXgkjmMQAMgFMCNCBNv8D4fkcYzH6xXNz6a1c/XC8oEL0URhcasiOoNIYYYp78ginaIbdqpqIX46lsOLFa/Duo/wxSVCA0FP5qlYWOeQXCHlQOeFuhtl7bQwNwEhGZw+ebAxzu2/HwMSr8zcYOe7yKhTWe5CBa8HMV6oW88Nwl06qwDM9O4KjS6Qwb/+5q6stjHUvQTHI2tbIf8364xarnLe5zP1kiHeA2tBap6eDAVnbnurva7y5icg521kudKG+wOREvacOLJk/37PDhkClZsu6F5bJufSfwl7VXIyOFD9BwNbeVfmECpeE+kOGEURGf3GiyQB/flN/b8L/9o7Y4SJ9LwVfAGuaHlaZlsz1IrskwW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(346002)(39860400002)(186006)(451199021)(1800799003)(6506007)(38100700002)(921005)(26005)(478600001)(8676002)(8936002)(5660300002)(7416002)(110136005)(44832011)(7406005)(41300700001)(66556008)(4326008)(66946007)(66476007)(6512007)(6666004)(86362001)(316002)(6486002)(2616005)(36756003)(2906002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tQVpiMVx+hnYUpVd3+9GG1vgYlL+e6T78kTiR4agfDow1IemjIw6x21GDHef?=
 =?us-ascii?Q?GQo7SQ9AVnW7yykqqGEjl10UIZkn4MfG3By84VFtrBri7kjmKKakndTMSplo?=
 =?us-ascii?Q?1qNocaH9gpbHn3FkF0xxee3pVu6st829KiDt/SPhvUvKmVwuoNJBN6SH+Ifc?=
 =?us-ascii?Q?taQGuihcrHqQCwyFeWTB3D/4oz6oOZ8+bgjnyBvumJe4JQXaMT71qaGRgkoV?=
 =?us-ascii?Q?BYVqIHpO8cXVKb6IZLN3vUB6lguF02C66uJzYWYwOlzn8YaElR24s6ifSikG?=
 =?us-ascii?Q?1qgWL1uDuB/W33D6+qTRfuwt89lZVdHHtkXeboSVaGw3A06WHYjnHDqKyouC?=
 =?us-ascii?Q?mw2LL9/LMWHhO89thEj/zz5/hrTPSfHrQJd2/Std/ZQAPOTyRsW21Ug2VBWo?=
 =?us-ascii?Q?lUcReKxjrULvZeuPylafJBcLU//2hIYW3tthrPq1b8T/MRkRaCBWdXh8sOdS?=
 =?us-ascii?Q?YyLBZnzHqOUfAOn2cMGrMPSfD2JeLc9TVEOEKbXqZ+dasVHETPvtfGGAs6Di?=
 =?us-ascii?Q?eFsziMIZYREKwI2gMbc7Xz2jaL3zmUG0SPv2M8rN8dSRKfF1qs+6uXkjwHC7?=
 =?us-ascii?Q?/yG/i/TH3/7QlFHAZH6wjbKkheKuUcJcjAumqqEPRoF5/OSA3bvy8oQ06A+X?=
 =?us-ascii?Q?nL5P/eO1yvYMZvUHPuw+Eue+NQbnbZZk/WcJYHbaerBv/ltEWrC35Tf9xrBv?=
 =?us-ascii?Q?ssSqgl82UOEgucFsBYDyDEMipulfdGGEzXM+dQs7ynlE/81HjjfIV+cehznv?=
 =?us-ascii?Q?3q+tPcQArtWY0Bkd8ffW0Qivnkfadsj/i7b1wZMBLxzqO6OorZDCFWzx6Ko1?=
 =?us-ascii?Q?k/QvYQCT6m7jjUcTsAFiHzG/bJG5+FiHRgPNPbzSTLTNyTCW9eFTJMicSo9K?=
 =?us-ascii?Q?TznQ25P52Lf5n9ZcQiiSIKwaigIsSKDk6fbH+yCk0qUHCwH+390PjLcef3eq?=
 =?us-ascii?Q?Js5Oo0yFl6cXhbkEiYh600UkDrHYUhen166sbsXjQCb0jD8rXhpCNlQR6oxm?=
 =?us-ascii?Q?83JyqXx7wMxy9l6QXLt4zKr2IFqyB7jjcxpyRiTGoQqA1GLB5sFauuFDntvH?=
 =?us-ascii?Q?eir2KdmU9cS3VRLm2vwrNVfwo0bCxia2spjQlrfJ5oZRYuGYsN9C61J6wmUP?=
 =?us-ascii?Q?64i9jFTZIvOAoOjksnQmtQkYu8ErgnWRx0HwLsRJNJPWZ2v42YJaCU0tUpzp?=
 =?us-ascii?Q?0MnoTHYHY2cQDM2QZdsPfM+7mKvwnCONe12Ds++5/j0ocBgrNcS/bBqbrkZs?=
 =?us-ascii?Q?NkdHwZk+FK49socCBn1P8xc0JMNnE3TEP4TipAkhnom/xQQAG7oGon4S+YZA?=
 =?us-ascii?Q?Gw0tR5hrSKoAyg1EilMKp4BLcwZ452p0zn6P3U9dvkjNltFp2aknrZrhSFkF?=
 =?us-ascii?Q?kmvyyAnrERY4x9FS4B+2oQ350o3jh3Pjis11EHHq/M1GS1J1BPW2grhMT2NI?=
 =?us-ascii?Q?++/YmFyqONbFA9mkZJ6Ojb7cudx2rNGIPULnOdn5dDD3yKMFqkiOCOg6KUT5?=
 =?us-ascii?Q?4nn98ufK77hl28zsR1HkFPseYhoGACRD829PxhfWdCKR8DyX5JmSDM21hSZg?=
 =?us-ascii?Q?0XM5+pDCHcVDYtAUWH9h0pY2QpgGa5vm/bPbRAeT?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eead2ba-998f-458c-d9b7-08db948e0091
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 01:56:22.2224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oInnuNlV9p/BekQrprBmz/aslcRT1i3iKjN38qeV029MeXHDHrDHXx8F08j/OawRF0UhfqMN13UkyR1kIZ2bLA==
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
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 88 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcpify.c  | 20 +++++
 2 files changed, 108 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 3dc0ba2e7590..e5ac2c3aab7d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,6 +6,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
+#include "mptcpify.skel.h"
 
 char NS_TEST[32];
 
@@ -185,8 +186,95 @@ static void test_base(void)
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

