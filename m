Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E3376E195
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbjHCHfs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjHCHfQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:35:16 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2047.outbound.protection.outlook.com [40.107.13.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685FF44B6;
        Thu,  3 Aug 2023 00:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItgGjcowWbAZFs+pzozMm9FpHyjt96cCK7Rt+NNOQTPTfBhUQlZNqOmC9O4s1p0HP/Lid4Nmc4y2F8mZ2FPGV/cVwFx8s8PrD/WoZuWOo1BZalNVnUHE+GiLwgbn7Ck9hqbGv173+lrCAEnmuM5vO4qWjTwOuNIQl36sqQ+zJBCfiG6GY2l/ey6I0WVDa6STGiOFPN8g2q9Kh6yPxER0FzoLGv40WnOMGwSSJ1mGi1KBBeb5pMWY+mgAqgIrwMCRbAbp8jGWReZsC+Qi8X0Hn95MS4cjjLNsXklxlaRukqRLHlwNgZj4dgw/PuNau+tRsrkl8WSSTzbIZIMDPHgDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ytRqdk3KEB9d6aj4yqz0u8W0I4u0l3uPJT5jvEkMqs=;
 b=m/d+4nPH1JTFQdjLb+/ivpX7vK0QnJ57Te0KHMkrU43rnWlvzuGeqJaVXrHamZ1gt0gIMcLNw3eRBlUry8mse/g9uWbjDywa2bDvpJOs0PU4K5wBfYUGKUlLPkSc50Lm4o7zXl59jZYC4HVSZT9ilnJl9/vBNJ/jO59/L2gNhrQAdwDegoxHNYuI6e74mnVBGGosSD09ZqatvyLlA9t8L9EyDQSqLyzL6R2hcK2wlyAiitHs8tV5nLrncdQV1SCLhvQn6vIbN9AVTAMv5OreyHSYZWqZwNGzPOBKkx4xKMe6Xu4LX+RoiXVSBDFgJvC3itC5foopSKr5APtVzVqWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ytRqdk3KEB9d6aj4yqz0u8W0I4u0l3uPJT5jvEkMqs=;
 b=ZOFQBJRC5PuUUwmr1DYNO2oaw+YUhn7O2iRFoR6dDZ1biRBu6GJ34W592cjy46gJylSvi9T1Hgt7CFGTP2wzwUiezsLX4dQhh0wmnLQ3hIRkgpveKqETrc4b/B+Dx+om5syeOGY+CTho0Foza4DHNWqzFTNL326PS3UR2QHNqEqjHXt+DodJ1+Lr58XYa6AYfzCHoQTGEjiTyHB2gR8tyb8F404aNntw4gVPV8+/8+H55NnyfFrUBF1MD+5LHuy/s8bYVEvGm/9P5MBXkF35mwEJw1HD06a34BL4NRoiki/RSkdXP4W5IxwjbFKT7hUISIJyxcIHFUzk1qdFhWyhmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8571.eurprd04.prod.outlook.com (2603:10a6:20b:436::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 07:30:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 07:30:49 +0000
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
Subject: [PATCH bpf-next v8 1/4] bpf: Add update_socket_protocol hook
Date:   Thu,  3 Aug 2023 15:30:39 +0800
Message-Id: <120b307aacd1791fac016d33e112069ffb7db21a.1691047403.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691047403.git.geliang.tang@suse.com>
References: <cover.1691047403.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0090.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 602f81aa-90a5-4ff5-e34d-08db93f38f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lNkwWiVe5D/uNZCyQ49nX0gkNC4IsG7FAGRy8KjLmweVM9YZukGQZZR1obBt2i8alOpEAquBPppJwlq4n3LxWvkKwFkWhtlw16M2+4qSsx6X9W23GIf0vEpF0yDacPdaTTc48jwC7wmv15ojbi1/dAcPpQZPswONL+3R6P4qa6R9DRnKAhLfaxmlw7Val39lfn3UfxyTvRk4JyEFnZWTf29k0PgHyTGEw5fMEfm38OjwwzcbjH4I2/Yl5AmtzfDS3L4Hd8AR1wV/Bj+uKct/2kizS6M3mCX3+a+qLnrpwdAHZKVyXait/bPp91kG1/E3QJL8dodkrK+udYsV768+hL/K7jsuxVkgpkmtV5k9c8a1g+OamrN+Y1zKrkoyn1Ih7W+6Mxqswt+LaahZDWWWAwAWyxH6PG2LAJUXawyjGg9U00ZH4S7dYo6qQKzmZsKEqnbd7i41ZcHXpVISb3lxs+eRAGI88WQloQ2UiQpa0Zvkt44P+7J/17SI6pr/vgm7vQ8c8Ets3pLCm+QQd/WC5aNCDSxDo88LNdUOAWEGamm8ZXZhQx7Hj0Vb0t/g3Wjx2Km6M/nTt0L1rr3d2C0ME/p27UbDwy8oXAIm1cMg0A4nzc24SgI94U9I+zGPBPih6+NtRvv/txA2BH0xwixGw8l0VMTqMFFGMLXcRTme3itvZXks6+LglZ6mAXRoiq/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(6666004)(110136005)(6486002)(41300700001)(478600001)(7416002)(5660300002)(8936002)(8676002)(7406005)(186003)(4326008)(6512007)(316002)(66476007)(26005)(6506007)(66556008)(66946007)(15650500001)(2616005)(2906002)(83380400001)(44832011)(36756003)(38100700002)(921005)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uzj8iTRFp0bP2Z6FMfAtyK5O091SPllwMsvRAvp0yDCaK6YXXzE28oRB/tCV?=
 =?us-ascii?Q?cgFCJ2cHvNGzlwgvJi1FSkdbVXIovFp8yNsIoKZCRtrkJnEx9U7LO9X70RYZ?=
 =?us-ascii?Q?QSOpL/AiNyxRlhtOX8y6MuN0G3kCsyvbo362t/pP9GqDTf/eG5VxD1q6xMJ2?=
 =?us-ascii?Q?BTlQXWTV8VU52u9GlAsO6cQLKZEaDfNpJM1piDx8BOfQBWxXHaaJm/JqHdNv?=
 =?us-ascii?Q?1jX+EpSDJPPUYz+nZtFZspu1dqA5jG4OvsIqx7MVj+VAAmAy0HWIvjWznaVZ?=
 =?us-ascii?Q?8LvT/NmI0bA6wM39xKC9Z+GVcP/9PEEPF/6gSvBCQWX69ywRXoqcmFdBk76z?=
 =?us-ascii?Q?doNoocDDrNNcRXwXeCduRCxqiu2DaTKhwSJed6KnpSk2SV/CJNdkw09/Sz+V?=
 =?us-ascii?Q?wC7PFV4fVX9/7nhEXZzpu0n5JeSc3s3qoxhiAhEHkC86u7io5CRTFK8oUUu1?=
 =?us-ascii?Q?/pPF2Ti8XTDuxVO65NtfjYb95cxvDay6xUwOMT9MU/IhydnFhxFDNEqKdooV?=
 =?us-ascii?Q?xj9JS73Qz3OwvS2cxscglZtCDHjkXpzeWecP6UA1B7SlSWQIU0L9wY8UBorn?=
 =?us-ascii?Q?DMQvIISl2p8LSdB2B+9UEYrQcp6FFXisSU2musQPuybuI7n5Dd2hK0RBO+1T?=
 =?us-ascii?Q?B+syVuJoDC/PdAWOWQrAM1Aj+V/D5qyWwZiukI5iaStzKTONNnARQVIJxkOK?=
 =?us-ascii?Q?/cdy5sn6AlJyhdchXTtGLxt+et+Pz7Z9xgROxklH4v7/eeT4ku9Ze8wk3WKG?=
 =?us-ascii?Q?ZiQNYPst5kIDGAcfb9zlTH95V/o4hIwS83Eh/Kx5j8qXg2wQbfbS9ogbXNpl?=
 =?us-ascii?Q?5MMw3lMGWm5Zo+MGLnuea8+lUI0d3qe6QhTis4SoQLPjlg5k/qHYMzTc05yI?=
 =?us-ascii?Q?Z0Eq6czYoUDD2cn5oPGbcBb/2X+95anca7h98IVE0865bZ4b8W3jy9pPdWEW?=
 =?us-ascii?Q?NU6uTjjURuOS4NA0FwkRfgi8/gSB7MDoaxtYjXlEf9c0TpwnvW9QHBCh0/hk?=
 =?us-ascii?Q?g2od6O0TXPnnLZa5zKsHs+XzAZQ2VDxy8kWP+ZNzavD+CQH/Qd+I0JsR28vB?=
 =?us-ascii?Q?idqTzHr1ATrQv27UZSWugVg/GvVX50KON5ogeIq9cUIoLM5TDNCEiG4ukUXV?=
 =?us-ascii?Q?lGqi3hGk1aTi/zTFOFXa+/XriBezRwSMvzC8DLdB8Eo8GYuZjIugAeXIHGVC?=
 =?us-ascii?Q?/VqIG7BRlxBBWbVoFTtp/yRYUMHK6FZ7kahcMlRhRkkSRG8xhxAmMoVhAGOr?=
 =?us-ascii?Q?WmH1ML0jOmL4hB9hdakjx1EADEv4fjQZSHPYO77YYVGzKKU4xdzlljjHZ65v?=
 =?us-ascii?Q?0gQF6iuwl73YlJR1LQNgOlNW8U8/D2NuRAcQx1R662e13rbPHHEE3czejTLe?=
 =?us-ascii?Q?atA7LBAcysR3LoIESbUSlCUZWzt8DdVVJDj8mih/e01ipsuTVzFh9/WGhiwa?=
 =?us-ascii?Q?esfyn4BQ7B2QCFxW+nj3tcYGBqnVtH/niFiMfk3lqbujVMPQHdA1ioM3Yhge?=
 =?us-ascii?Q?v1IiB1CVZ/6bEr+n/xi2OCbW6H19D4VKb3T6gIeNX0u/piwXkz3W+xmoDrbg?=
 =?us-ascii?Q?2/ghdJyJMoEIBzUsj9mMbOZiwl+9LDzWLZXW/VAy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602f81aa-90a5-4ff5-e34d-08db93f38f2e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 07:30:49.5182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAxDRXM23xoUk1SWG0V5X7EKJBqjTW2D3MqeZ6VZcm6HyaiPEx8CO418m8TpzOLx7YLfJxSzKKHxU8CxjAA+QQ==
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

Add a hook named update_socket_protocol in __sys_socket(), for bpf
progs to attach to and update socket protocol. One user case is to
force legacy TCP apps to create and use MPTCP sockets instead of
TCP ones.

Define a mod_ret set named bpf_mptcp_fmodret_ids, add the hook
update_socket_protocol into this set, and register it in
bpf_mptcp_kfunc_init().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 17 +++++++++++++++++
 net/socket.c    | 25 +++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

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
index 2b0e54b2405c..586a437d7a5e 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1644,11 +1644,36 @@ struct file *__sys_socket_file(int family, int type, int protocol)
 	return sock_alloc_file(sock, flags, NULL);
 }
 
+/**
+ *	A hook for bpf progs to attach to and update socket protocol.
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

