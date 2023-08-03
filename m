Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C542176EAF6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 15:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbjHCNot (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 09:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbjHCNob (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 09:44:31 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA8D44A1;
        Thu,  3 Aug 2023 06:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXUNnsCQV0iSqJ75Jq7K+suRfbUtSktLrNAO8xNwLXO+ygGOmbuztXvq5r6xAoCp2KmF+LiSGXe7aOU7lsAvixGu0x+v8RdGcswELFIGhdgKwz6T5O1grNcmE+fttYGHmtn1QzhEV/WJqsdPwRI8HCeBR/ab26rHAVlE0nlfSVeIOu0w8zZbuSSlTTOm+klRZG4zNPSRFfz6h3GnqGx70t7ep/L+51Jfnrtr3T6WvN/2ZgszE5ZGbznftq8GjZOx8a7tzl8ORL3V9wNKm9Xg5EX6G44ZaSuOpKltmsXTRuc6zrKinMSzVhjUdggUhuFLKoT8NfQrPm2UAp5jNnYVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD0kw2+0/ffqwVvqYQuyKv0x7CGp4nGi8nyUCwahJ5M=;
 b=OXdWovl0KgbMFS4s4HInC2ZBSLix5kOt5zG8ovVtCk8xzl6BCsBCUrg8jWqlk3ONyqY3hdD3rH6i6s6Eb/j8NzBNlzanijm71gD+PzBX6WEqVenOG21Ot8jiXstnT4dwMU5PoOS+rDEbV0ASJYA0p26gSjku8YXQDxMnQxTOxiBMaYztXi0xOIg0BIFa4mUqH3/YOpqmqZ+G/grqDGie2G2iiRrOzrw1mSEHMspKdbdFgYxm4VBJBqbObAYEMh8/pBgPjBj3vD8L8n6RXVbhM17Zn3Xd0amyn4+c9PKNYsLbUHym5XM0aljQ6QXAmokGbF1QtIf7+5N3YIWLHKELCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD0kw2+0/ffqwVvqYQuyKv0x7CGp4nGi8nyUCwahJ5M=;
 b=2RJriGX74msZ353XAvRx+ytouBF/p+81nbcl05QQ++/gZ2YEVbql289i8GWVl+7J2VyXZi1xONvizVgfbguH7cfDiknLNCVnqFu6rwnHm9VnxuCqAhE+1sH3BYhjZxWwDwyjWUVhAiroSQQSX2pOsmgiEzQizlSjmEEk7mfv/IAAt30mzWwWdHOfcIWUg8uR72jAy0PZk613FtT7vEwUB9f8+1IPsMcB0fSJnh0lR/D7eydCrO0TVk4oEp9owKB+LP7zR9vBuqefNIrnudlnlnH0OYoRWjcQoAQgZFcXJdHZHUe4h78YWgq135izTkNZb++VT2mxbSPasXOLZHCE5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS8PR04MB8580.eurprd04.prod.outlook.com (2603:10a6:20b:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 13:41:47 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797%5]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 13:41:47 +0000
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
Subject: [PATCH bpf-next v9 1/4] bpf: Add update_socket_protocol hook
Date:   Thu,  3 Aug 2023 21:41:43 +0800
Message-Id: <fc284a49832630e4b908f11c7e07a8066b7bd789.1691069778.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691069778.git.geliang.tang@suse.com>
References: <cover.1691069778.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:4:7c::27) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS8PR04MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 569c0b44-6c0f-4114-5db7-08db94276238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6p/IXflHlT4gD7oJp13einpP78p25kze6EgC37WDaFYH8ilpl3x2o4FF6utntCZwQFoGeON/zopDCbW/E/9Th1Vj9Gi1L82UpWpAQkanrpsVpW0gdJo0yepha/kI74TjvwpTsk6fNwee85DTLJkFN6MIPNrASi7Bj4J3A0Onw02rPp0NzHD+VKlVz+NLydl1zosgc3h/ZtdJ+vHv7nw+nb8+E6s/43lP2TDmbLjGrodqZDqVJ4XrXmkdIBo/LdlQtzBrOs8LYdv23UH1fal6Mwk0ocbJ63gTXBAjApjw2DkrgqyFbVQfll9OSVqTF4+1+MlUHYbRM4Pba2fqhK3LD6kuq45LiI/q1e3Cglk1WcM3odgg00hDdfoeyMEbgbOZh8FM71R18JmMAmfURbe3OpYwxcLyp847oOp8n6AQTdgasuge26D/miHNyH4odpGItZskyog7QHnyLrwTeP0vFttyABvXgqPfQPKmmxwRc7K/KUgyx90Oi4yGuNSRerXUjn9ebbaEBfHyRXvQwIyhpDMcjwLg/LSjvUYSJH+cOXhqP1qQz+9/86LmWC2AVuj/GB+FlZ82GV+zuThcXZh4QGYtKc0T16DEkZ4L02QlKI+iym44Ytniwnu64Kl/7Bx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(2616005)(83380400001)(6506007)(26005)(186003)(41300700001)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(316002)(44832011)(7416002)(8676002)(8936002)(6666004)(6486002)(15650500001)(966005)(6512007)(7406005)(478600001)(110136005)(38100700002)(921005)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JBCTRUDswJgzTVxgvJxdDXnWa/+vbMTl02HauuLnsU5t766L4apK3AkUjeSs?=
 =?us-ascii?Q?tzWWlAPCCd/X8HhiTcq4ov4LrpSZYv6Sn0IEL+s0aD3nHew2fd93IuFWx3Y8?=
 =?us-ascii?Q?JIG8En8+fns7w7MJMfFWwob+/gc/48iD2Ca5/ae9mZ5yNaLfLZ4d0YfD5fre?=
 =?us-ascii?Q?lZN70PwQHljn4fUJaFNc4s+F2yvTGloBRGS4+sPpp1jSYpCSBKcfKyMH9+tz?=
 =?us-ascii?Q?UpcdJXFRswBq5s54w6JNWqSlKxJkngg5NX1siINwhCd6pttOTzZ/Yr7zbe5O?=
 =?us-ascii?Q?ubE5uiHXXtftYHPLsTYF2yZMIuC/poaJ+L4bkSzn30HzYJWwLRs5ynQj2x4s?=
 =?us-ascii?Q?9bT187vToyGEhF4O/K6pHODOAOdMl8SbJ2Z1lDC802oLE7KpHppNcQecZwgS?=
 =?us-ascii?Q?9mKMGoZPenbc4hM7KNopUI6jhnV1C1GXldGYSFQS644K3tbqQKRcwMnlm9iS?=
 =?us-ascii?Q?BcAUZDQZiQZWyJZckpOJSKHw69aaB4Ye0iR9ql9+tD/VXNAWYkfVA6W9kVH3?=
 =?us-ascii?Q?oTgwkA5iOwYC1Lgm440hiAw59q6wYMWeEii7F+vIqe9/r1JGK2uIcXyz28Qy?=
 =?us-ascii?Q?8TH46dHK2ABYxqjxzoD9Blbd13S/8qn5zCBs7+d+2L1QB3YsIKmrO+VbOSb7?=
 =?us-ascii?Q?rFBmWWnCQGNHaNGmW2JULg3NGjK+dwazxC1K+er/ih1a70eRlyMKV3BlJ+Ff?=
 =?us-ascii?Q?RPlR1y3LpCc8afsmvbjC1XFm/8Td7U35+o1Ga8gzAVKGeLCpI/6jnTC2/I/e?=
 =?us-ascii?Q?IyDWXWfrP6BOAIZjBajb4tRK3764abBW4I4uUHKt+JyMJhejVY8XCppmCJCH?=
 =?us-ascii?Q?lzIPX+DuEUQ17rks0S+7wTCUlLNod1KNBJmqzaUDXHADlGVPoWVm/JAuDlAM?=
 =?us-ascii?Q?71mK65Qvp4BBfjq03aBTt8X5Tbhw9md4uZ4asduVE4fDlMXh2nVOKKxGvK/f?=
 =?us-ascii?Q?4RXZ5gu7h9hYhMvjWiGYDDfHVHC9VV6TJYILHsuTyJm+qtCS1rzbr0cAUR+P?=
 =?us-ascii?Q?sZGpZAMq6OLNUYjOVX0xQimiycXUVnWpPDM1xiE+7zgsVMQ0y28R7UErNzTI?=
 =?us-ascii?Q?A59Oks+XQXlXTpGcWixXqLRjrtGd6u60hR2yqHA1z5HBoTGk27t8mW7xH/mb?=
 =?us-ascii?Q?NG6Rz1vnlRKBafSf1gFa/NEdohO61NwWM55Qdg4gokkTR3oxrtDEQHPXFniO?=
 =?us-ascii?Q?9WOmfGR4Xemz7BwcJ30jE7zLpOf+vY5IenRFoRKKc8VdoCuKE2UOdrgsMwcv?=
 =?us-ascii?Q?O67JqlxWj+OKxBFv8LmOuIpkfI4kYrQt8XGZM8nl2Egcdakh0iwWmZeCFd3f?=
 =?us-ascii?Q?3QlPIyIYT/RaSkMyDRVCRw6bIfghD5fLbiRypeGAqpIyp+lnIpRas3ix4VGj?=
 =?us-ascii?Q?uR30i3G7Mynh09lv1TA54hodlXTEzKDPQQ46SucK/qVmbjH9tRqF7Rwr9g8X?=
 =?us-ascii?Q?rHsaw7vU7v0BoFLWWuW7wapnLO5yTnHGPJ6LI1zeQdB58yqf5C1KJsBFcByZ?=
 =?us-ascii?Q?YDT78O8MNeEszjxEv8CKHFJDtVvCet20vGuDVi1ylHkZUDdQNUa/jZDBPMei?=
 =?us-ascii?Q?hP2iMC9kmaGb9KJ/nMBHyKSr9JazE9cDiZy6zh27?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569c0b44-6c0f-4114-5db7-08db94276238
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 13:41:47.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwJ8ovNZW1Z19b5fZYDs4twvOT9dIEIE0luDZM5MY6r9XbyCJsSzhMgOTLKnJQ/U5NbL/6XTx1Bb1Mo8q97mIQ==
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

Add a hook named update_socket_protocol in __sys_socket(), for bpf
progs to attach to and update socket protocol. One user case is to
force legacy TCP apps to create and use MPTCP sockets instead of
TCP ones.

Define a mod_ret set named bpf_mptcp_fmodret_ids, add the hook
update_socket_protocol into this set, and register it in
bpf_mptcp_kfunc_init().

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 17 +++++++++++++++++
 net/socket.c    | 24 ++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

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
index 2b0e54b2405c..9f98ced88ac5 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1644,11 +1644,35 @@ struct file *__sys_socket_file(int family, int type, int protocol)
 	return sock_alloc_file(sock, flags, NULL);
 }
 
+/*	A hook for bpf progs to attach to and update socket protocol.
+ *
+ *	A static noinline declaration here could cause the compiler to
+ *	optimize away the function. A global noinline declaration will
+ *	keep the definition, but may optimize away the callsite.
+ *	Therefore, __weak is needed to ensure that the call is still
+ *	emitted, by telling the compiler that we don't know what the
+ *	function might eventually be.
+ *
+ *	__diag_* below are needed to dismiss the missing prototype warning.
+ */
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
+__weak noinline int update_socket_protocol(int family, int type, int protocol)
+{
+	return protocol;
+}
+
+__diag_pop();
+
 int __sys_socket(int family, int type, int protocol)
 {
 	struct socket *sock;
 	int flags;
 
+	protocol = update_socket_protocol(family, type, protocol);
 	sock = __sys_socket_create(family, type, protocol);
 	if (IS_ERR(sock))
 		return PTR_ERR(sock);
-- 
2.35.3

