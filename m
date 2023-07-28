Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23892766630
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 10:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjG1ICS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 04:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbjG1IBl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 04:01:41 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEB84C03;
        Fri, 28 Jul 2023 01:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPvt6/JbEwIb/W4dbHDDEh9UavPeOyttvFsodJeg6gziefMUN8pkHKIXj2NHrjcqiIEzXUYv9E/LYLfnyw0cEpb8nPE+lJs3ZeQerzQirhMt0NHQBEjtHJjgQtgs797qjcw2ZST3qHsp63FlUMrc1W4mIGQ8xZBujvNLmYTJBMkU7ZA8By/CMDjdodY8d4Xneistq0krLUNDXpjjApz25cUqYxtckBvJXMSIuoz8LSX28BSz66gk1iOZUYmGTz2yhub1+klg49dzMZusATYvNYb+VUuXDy01MHhCltvytytCOTPrw6YjaBBQE0K8lBISNVmnygYrTnBqh90DUXLtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPlQ/LKXroahdW3LoSJhHPP55jIN9tHgH9sTEqJ/pqc=;
 b=b20X5r3CH/Wu25bBP7xQqOT3RnaS4aBtRdF8Xji4DeDuwYS7MIvb52yaBp3/zKGF1noXW8gbeiBZUvnzOplcxfmDVICphSbBv/9LsC+5XiFgMWrkFou7jRvluf4M6F8ah3OaYX9m+dIxCpFfpG2Wzdbf2Au3ufjQ9Ij6zT6xOuz0GA4GgfUbq8GovdrigzL/qmhcau8O8N56vzbh5iCTqB6xAsyHf1DjNqPD3D8mYKr+yBbaeixEFv7ILpUnBN1YJ4F3OmE8KgNgRxDJSgi349iNoAmJLIBM5yQ+DnF/vwGQlDj6xf7ELs29erUpwNlq2OVLFaos3N1StbYIG4FDHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPlQ/LKXroahdW3LoSJhHPP55jIN9tHgH9sTEqJ/pqc=;
 b=jIPwSUagTcqazoSzLvEPUzsP9T/xPSXb7/gLy3OQ9sri9//UOc07fKRHeuEVqeDPZq7pMslIWF2RlYGCIszdTA3QGsU5gY3avJJsinj0YL4Gco9iB3nC+lDvYqkabK5iHKAwVkLQnCGETmpsg3Dt+iO1yHO6XF+hSmRVZLpPaDyBcYqdINcGPIjOvqedCZD5Ol7i6t1PvmrSfID1yJ/oG9TRKJ8ybgk1ZM1t38lTPps5JWb688WqynQD99J7pYEtDVk04Od821K6dVMEXw7+jCXy0iTewXue4lCstk1BibvKAL1tW4MUYQtChPhtqrqzgsATx4cd01OQ+E0DzrxvhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 07:59:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 07:59:50 +0000
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
Subject: [RFC bpf-next v6] bpf: Force to MPTCP
Date:   Fri, 28 Jul 2023 15:59:49 +0800
Message-Id: <c0647d0d3c7158b96dec4604ba317df311c5012d.1690531142.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:404:f6::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: a76732a2-e31e-412e-0612-08db8f409e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xv64iWeOtRig2HoYFaX5DBda6vQT9kI9GFxTDqEZJukELg6RYMZiJWhw6fkfK5Ucq0QdlyQC0o/MaCRBlbNjTxu408/FnHwmGhkht0BNBDLCsXKiR0XQkglF7cUBF6iqevKpbroin3FMrI7/yL3Jl5InDDzSsyMhEXZSoO/dVDhTuYS3501zehPQ+ah2u/bpXmi9dC0CjyHrMIo2PRCaCOeqxP1Wson37n/TlqIgYM5Zw2ylySV6Yk4PZVJob/bqmUUvZW37clkt0MGwA4I9S6+DLuxw7X3Hk2wUvPQQYrTB70SXcPhHXnboUN0B02d4il14d1T3u6jXF7xUs1F1gJOcPzO5RuuebtknLZ8XZeAt9j8uihA9QVjiVBf6bBNicy6HiuY7K/0fLPXRNvYSZiD77g6bO3gzzsHmwHKBF8TJiabxEqn2kBFb+6FnmFEgnDqO241JrSFUBP/L/nWg/Bwzefwd+fpbWPVq+aZDRfmex5io8tJ2b7/1eUoiBqx7HRwNJcFXL9oNf/O/axJMR/s2x3RGMcPScTsPP3X0eRjgdnoBMc1bThG3ev2KYmxxVYooInS/Bju/SmrFuhH3wZSfphD/xeSBh+ZbIitPZ7a4cqLKbvZW1FSpKFzBELkh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199021)(2906002)(41300700001)(316002)(7416002)(5660300002)(7406005)(8676002)(8936002)(36756003)(86362001)(44832011)(6512007)(966005)(26005)(6506007)(478600001)(921005)(6486002)(83380400001)(186003)(4326008)(2616005)(38100700002)(110136005)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BbeeHKt0f0iEX6B+MgkYIk5kGhnargmq4tuHs/FO4CpxjuPidb/v9eiMM+5/?=
 =?us-ascii?Q?SKt4PCv+zRqH16r5W1spIqzEb4SeFkanhLC9US3UIWYjSW3q9M3jhnGPfXcB?=
 =?us-ascii?Q?OnUkXhyKzF5uvXd0ze1WLOcAQNhSqVczgyrkxzB7KR96v1g1pquUbGUVJemv?=
 =?us-ascii?Q?In1NiHhHuFZpMRLH8VfwF4qK5Q/0+enfTrf82qugi0yqQoQlUOK97rzS0pwJ?=
 =?us-ascii?Q?b3Q/rTh4HeP3hqAs4sPAF5Smz6XEk/I8Lfvx59RWkMdqq7yirIGnftBnWH/p?=
 =?us-ascii?Q?7lz03a1Gno5yrAUbG+TXdPnTsjesD2fzVPDm4HuDaEcfrYuqMnzyz7LpRzYE?=
 =?us-ascii?Q?q89sHCYnioyz9KG+wqODYNDhPsb0HssIGLuDFId97M+cKAgo9MDkwJQorVR0?=
 =?us-ascii?Q?J8ZLb2FyVx9uK/1pmUppMJLAQ+W3YshML/TTz/oL2OjbayEkdc+zpNeKichh?=
 =?us-ascii?Q?uQz1eNGiZSFbrp0kePpoLqZUuD2vc4D1SdpnlzVRBotxYQch4/wvQBm/PYax?=
 =?us-ascii?Q?w/P8rC0TV+SVSkf6OKipoG9yRbLEs0yrprX9C2m4SlK61OXp2YGYJMOVQwRg?=
 =?us-ascii?Q?4/93mn4RdxBbqOUl+6wLhSRZgdA+f9CuMp9uUU8gXuGFuQXv7QSj4dbXhz7c?=
 =?us-ascii?Q?xDhaz03V/w8dJ6NxWW3Hp+/Ufkd6Ie9DVfs3SLqvWbLoFmHoPpabvO/pNulV?=
 =?us-ascii?Q?SRFQMtkKxWquLfqTKKau75nsyjlJcSdrDH18iqBe7pOlCyQctstX5/iJBpUW?=
 =?us-ascii?Q?gK/ZNrOxE6NOT01qFoVcBFz0zfDq6eHmRgqXpd4sFQieGHGsy3prC426aOca?=
 =?us-ascii?Q?6pl9fqoLIiQx98RClV4aPvh86u7ouEY9/TCqoSDwPLEot+WxikndgdZUizNR?=
 =?us-ascii?Q?pmydkV2b2mSOc64pECOevju1DGlRqCS1q/Ew8ezL+5jZFekmoZLoSWXJarJu?=
 =?us-ascii?Q?4OLv59z7jSa9BcWtRj+nuWLoCdW14WBtMz1JvJaRt994bV+/L9yaDs/ZMwDC?=
 =?us-ascii?Q?h8LtgRASSCSFR1iC+kROq+AUGVtMGnuqW2YiEUlD9gkNFCrB7CRbipmj+Wpn?=
 =?us-ascii?Q?h3ZrBpgV7nc8LkLSEVp/cjng9snIA/W/kvqbFX/Qn7WytKCpnDNOtVB+SQYi?=
 =?us-ascii?Q?iSgs7KMDxul15iBPDl6ZzVgG6wr+q0SPh6sSRn6NHcFIZ9M9A2GMi1cdgyhb?=
 =?us-ascii?Q?c6dtc/kLiMzDTdiSBsxDem4MMlHPf6leY1QhjPnBGv/RBUAuqIf5K46kM/cn?=
 =?us-ascii?Q?bB3l2uzzDABY/a3oUfti6mDT+5zhEfDSr6uiOA0LKwviDXXFEaS1pBpsIwjK?=
 =?us-ascii?Q?s1fBv9dOCKp91UCJUr/r90CQ22DZ+pasX9R+6NqLFyO0A6pvqbi3vybaQKfL?=
 =?us-ascii?Q?NMznKv434eLxin2wdh9dqzsnVvUFxfcZhNjNgRXgBlJi4VFGUi/2oiz/N0P2?=
 =?us-ascii?Q?jPE+jXZa/g6FhUCuzCoRuCjxOGijdlrpEH3UDs6/t6v2kB/Dj1ASnZMVQds9?=
 =?us-ascii?Q?/gvxODHBKPYk2p/X3RgJVeYuLCotLXOpAebB4//AtJbiwVHKTDzFoH01YfmZ?=
 =?us-ascii?Q?HJMSpoEOMtG1piHfAdy/p8e5jOaeJ8i5oKvnhwzx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a76732a2-e31e-412e-0612-08db8f409e0e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 07:59:50.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zt2EVkgp7KaJYsGP51d3ny9mKdSIDj57/a4j42J6vZKb3yB2oPl+bf89HjLq2iytijhLOqxCa5qvAjGxuj9tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9436
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As is described in the "How to use MPTCP?" section in MPTCP wiki [1]:

"Your app can create sockets with IPPROTO_MPTCP as the proto:
( socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); ). Legacy apps can be
forced to create and use MPTCP sockets instead of TCP ones via the
mptcpize command bundled with the mptcpd daemon."

But the mptcpize (LD_PRELOAD technique) command has some limitations
[2]:

 - it doesn't work if the application is not using libc (e.g. GoLang
apps)
 - in some envs, it might not be easy to set env vars / change the way
apps are launched, e.g. on Android
 - mptcpize needs to be launched with all apps that want MPTCP: we could
have more control from BPF to enable MPTCP only for some apps or all the
ones of a netns or a cgroup, etc.
 - it is not in BPF, we cannot talk about it at netdev conf.

So this patchset attempts to use BPF to implement functions similer to
mptcpize.

The main idea is add a hook in sys_socket() to change the protocol id
from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.

[1]
https://github.com/multipath-tcp/mptcp_net-next/wiki
[2]
https://github.com/multipath-tcp/mptcp_net-next/issues/79

v6:
 - add update_socket_protocol.

v5:
 - add bpf_mptcpify helper.

v4:
 - use lsm_cgroup/socket_create

v3:
 - patch 8: char cmd[128]; -> char cmd[256];

v2:
 - Fix build selftests errors reported by CI

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c                               |  17 +++
 net/socket.c                                  |   6 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 126 ++++++++++++++++--
 tools/testing/selftests/bpf/progs/mptcpify.c  |  26 ++++
 4 files changed, 166 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 5a0a84ad94af..c43aee31014d 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -12,6 +12,23 @@
 #include <linux/bpf.h>
 #include "protocol.h"
 
+#ifdef CONFIG_BPF_JIT
+BTF_SET8_START(bpf_mptcp_fmodret_ids)
+BTF_ID_FLAGS(func, update_socket_protocol)
+BTF_SET8_END(bpf_mptcp_fmodret_ids)
+
+static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_mptcp_fmodret_ids,
+};
+
+static int __init bpf_mptcp_kfunc_init(void)
+{
+	return register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+}
+late_initcall(bpf_mptcp_kfunc_init);
+#endif /* CONFIG_BPF_JIT */
+
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
 	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
diff --git a/net/socket.c b/net/socket.c
index 2b0e54b2405c..4c7b2ff711f0 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1644,11 +1644,17 @@ struct file *__sys_socket_file(int family, int type, int protocol)
 	return sock_alloc_file(sock, flags, NULL);
 }
 
+noinline int update_socket_protocol(int family, int type, int protocol)
+{
+	return protocol;
+}
+
 int __sys_socket(int family, int type, int protocol)
 {
 	struct socket *sock;
 	int flags;
 
+	protocol = update_socket_protocol(family, type, protocol);
 	sock = __sys_socket_create(family, type, protocol);
 	if (IS_ERR(sock))
 		return PTR_ERR(sock);
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index cd0c42fff7c0..ffa98d5c46af 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,8 +6,9 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
+#include "mptcpify.skel.h"
 
-#define NS_TEST "mptcp_ns"
+char NS_TEST[32];
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -22,6 +23,26 @@ struct mptcp_storage {
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
@@ -147,11 +168,8 @@ static void test_base(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	nstoken = open_netns(NS_TEST);
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		goto fail;
 
 	/* without MPTCP */
@@ -174,11 +192,99 @@ static void test_base(void)
 	close(server_fd);
 
 fail:
-	if (nstoken)
-		close_netns(nstoken);
+	cleanup_netns(nstoken);
 
-	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
+	close(cgroup_fd);
+}
+
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
 	close(cgroup_fd);
 }
 
@@ -186,4 +292,6 @@ void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
+	if (test__start_subtest("mptcpify"))
+		test_mptcpify();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing/selftests/bpf/progs/mptcpify.c
new file mode 100644
index 000000000000..c5e5b27ac3df
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcpify.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
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

