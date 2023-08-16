Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB5377D76B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 03:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbjHPBMR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 21:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240962AbjHPBLz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 21:11:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B721FFC;
        Tue, 15 Aug 2023 18:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGqtS0HZa6bi2SRl4I/pSSRI39GeH0TFQ6Gzy3XDCJqP4M9ygVYJRMumPKw4vKYNPHmaqBA/xFiU5MXJ8bDbWMEebafGqyFBsezU317Ok8F/PFsQR/34l5CFTcdVM3S5JEgtBrXky27GWNzonYtujlENrPNpN2dLHHBkNM97Y/EkXxaWYJRGtCkmeAh4QVtcBXxdcCV/deRdFiYZ/PRNoBM3UZNyxy98cXZOLc/NP4o3rTLWZlVpV+3EeqgXPT4GWZHKQEI2fPdwIV4bJBYBhG3pr1VTCeo4lUPXZv2Q9KysEvZTqXDK2tQONRhQo6B7RqgQSUxmHWsmJFIvSJo0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frsRNrxXxqJadeOymcQavUtRjGEgKb5wlejqmgRLXig=;
 b=XDFxnp70F4BcbxvGxWX9uFYYxN4zxsX1xjRNHd46XB30UIceiEyghvz8bhdzwHn5bzdTqxlj/0xulqbDIPT7Xmji6Asy+aacZfQMP2/kZEpVctRJVvu8tb/9o/B9enp1JbRgIAZKjHcYhbrDgTKHPbQKrJmzJ6MvJZzkgt3W3ulOS4KdJmD2BnWFxpAR+aLx19q+Yc1poxkkx3IiY/E0iWINDwnx3KKiWC/aRXpbD6VjhwgKUSnHX4Y6q4q2QtVq8+Gqa1d+ioRfMrE+2DEmx/gN3iOm2s+Xz/HEbin0xkh3Ze174mM74hjeNAbyRfjipeJYmM/OqtocCK5AnY64iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frsRNrxXxqJadeOymcQavUtRjGEgKb5wlejqmgRLXig=;
 b=qiCmgTQ0BZdaIX95uXj/eqviUP2InTX8DF1TxDee7vHQmnKifpEphFOv/joMVaiUiiw8DZd+fTUJHFKQudf+9ILcIQ8fQ5JrLck230Jzv8jSV4GfU6qJ7xM0U+tTTBspdzEiENtlrMg8l66FqLsDW5oKv8/gXOoyyBEWT6mtJ7oKIQ05PWXunxESj3yvvyB0I6khkIZXP4zMLpCsgr3CW0e0GiE5FZnqjy8ZR82+4gL6fOt+lGy2T7XjF3Fm4VLXvlzHA5Tl6k7E8UolXNZznxPzUICz4j3xhFoe4tDZzPK1pzjmgrrmioVHNg7kGDKchLf+YuJ+UgUmLKD1innyZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9915.eurprd04.prod.outlook.com (2603:10a6:10:4ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 01:11:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 01:11:51 +0000
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
Subject: [PATCH bpf-next v14 1/4] bpf: Add update_socket_protocol hook
Date:   Wed, 16 Aug 2023 09:11:56 +0800
Message-Id: <ac84be00f97072a46f8a72b4e2be46cbb7fa5053.1692147782.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692147782.git.geliang.tang@suse.com>
References: <cover.1692147782.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9915:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e47aa61-29ab-4641-5c1b-08db9df5c56a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VmdO1CSLQ8WKnjv6qGVt/rkZjawcQkjrE/OKcNtN3RjGGW7OYJUKUoXY9Zr15T4cRmij/b1BQo+hD3tnxzMbqX2ySh1WrAhKGEDe5Zn6tNOaPG1rrOcFyl797XSyZjqN0i28LQaYKSukLavvJIBhh/ZAMAKJDyCDcJ3NhCyQFeRyJ+97FrahWM1vJzkYee5DM/qds72R2uSDE3bQbw7F8Ycccseym5ducC3l2+EyudxvkVGUhJg+l5PPuYsUoRD3a2TFsKv5F4Xp3H0rWijr7ocZaDeLVupPesA5l/xIH9Va+WCLHSoYnYtxBC0jVS4U2OGt2X6IpozWUiimBwsTeIt+ZLrIZ525fy/vZxQgtyf7cZWcjFhKkKeweWpFMpRkdeqDcDuitH3xNIuE1/q817H8bZ5HDEkte4AH/By7xHwH6gB9KVjcbRXog8n9j7QJnkORgrx0KeuJyoM4LnkWPo0IPZrT2glyhhXgWIYo8o9012h/JVlt6NUCBYvcehfn/B7m3O5bEkS6fdKsNWJFZ8hqkAxRvpNUDooXDO0x/8H9rJV6HvwvqsUvnHHUIq00IJqmM28N+QdjZ4CFWindE+XRZdUDpq06TUUqp+xgq7nUpJ9OuHJNs3SZA1jIrY5s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199024)(186009)(1800799009)(38100700002)(36756003)(86362001)(921005)(6506007)(66476007)(41300700001)(44832011)(26005)(316002)(4326008)(15650500001)(8676002)(66556008)(83380400001)(2616005)(6512007)(6486002)(966005)(2906002)(478600001)(110136005)(5660300002)(7406005)(66946007)(8936002)(54906003)(7416002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bOIZE0GkhjehdedE7GcJLJhMcDIWftwAm8Bde/DJkYFEslckHNeP7UwPf5JW?=
 =?us-ascii?Q?U1J3Vrfo4NRLcYMJC8UjeRrwMBf7ACPpBaZlthc8zoclSs3U73UwfMx5xL7R?=
 =?us-ascii?Q?Fp2FBi2wEyhkBLo4oWEm/wpwVsKci+OQtR+0A4MQdlixXy8m5cdNxb95f/0l?=
 =?us-ascii?Q?o6PNGdOVzeeliOOiJpgRtqZL7trx+gI6mc/FlwLibM9onAmQROK1tHLKyuqT?=
 =?us-ascii?Q?qLvsKMwsUldteoRA6KZz7v+pVtPtfqezU9q1bqOkz6OmgyX3VRe/cKHrvJN0?=
 =?us-ascii?Q?wXh2UFzGU5o/yb9lUwz0xptE9aK6eJ0MzmLc9NVe1AOnRFP/ItD3ynqNhul+?=
 =?us-ascii?Q?Q/u46fxSDnLLnR8O/2iiJZ88uDspJvynEhmSwATDwAR5mq+rwn1kU1wAmkkJ?=
 =?us-ascii?Q?tScPHkiG8phLEfH5aT/bUT/EBSIH/hbsnVW2kuyqxdhqGpWQfnBakMbeES3c?=
 =?us-ascii?Q?Tm+iJjqWdCfNRbGQueeZjQVjln7fFtRIkhqZt64gXMyDBK8LKAXJtD1ibVxe?=
 =?us-ascii?Q?N4xHjq6+BGbB9ivDoK6WV7mnxec2+pDVmSk0UDMtoOYDwPDEc+NK8GVygtpB?=
 =?us-ascii?Q?ZWad0Wzit8ZNzekBYXZWATMtXmy5TTILy250LyRt76UlbwBKDxH/0EXj6hmm?=
 =?us-ascii?Q?FVaq2RMr35ERqeYqQwfmtEQcLqd/2iKz3qQ/ffPFlukGaWPcUKqDBX+HEgK7?=
 =?us-ascii?Q?DOgc8N7oRngvn/OrtOrSZ8U76ATyOkPnUQAQ1Va9FACHnoIY2+5B4cO20Ifx?=
 =?us-ascii?Q?lPwvBaTHBu0+Tly/qauODWOy+HCN5KZbR/Js2HJ+zcMAQwdxRabCAZgvK9wJ?=
 =?us-ascii?Q?Recot+Xk/pph8pVl+yisj9eR6cmfrEaYG8NPohuIU0tJG2Lp5N1IcqhDj4UF?=
 =?us-ascii?Q?1dI5XU0X+2KX61wRC1HAG4wICKFqEX2ofaIs6U6EwQ8mn2KJ9xc1PmUxb4nX?=
 =?us-ascii?Q?qOsO+hALkIn9Uofl4UpGidQ7jyMSlLgbi8UP9/arfVu2xgC+0Cmt1iDCfkG5?=
 =?us-ascii?Q?hxGcALK3q3XLgDZtKkJPtuGOdGj/HSE0KlnFkYYEeTx4P9vv1PqKQyJu7f85?=
 =?us-ascii?Q?SToIU1WdKjEan+2oex2L7Wsn7AoGa8BpXfzqaO1gFX/bYG6QStbea8mTdPzX?=
 =?us-ascii?Q?emgk12cji5+EenxU+AMtBD5iDG9IaVMr/IA0Q3Pderd4OWd1rOv4J3Zl1n4d?=
 =?us-ascii?Q?IhPEAhqFZ3b6TRKEQPYuu+BjNfg9T7qeX/bw24G66jLWqN5J+s1pi+1lIrnc?=
 =?us-ascii?Q?qH8/r+yHYXMa8mUXucMsox3ke/8f4H8yW8cuO1SOBEdiFcC4pyDa5ctDoIOl?=
 =?us-ascii?Q?DDuHYQSu+94vJpqLu416CrM/BuQJGbgr89EE3XNRG0xOCsdv1vVvJKiqQTcP?=
 =?us-ascii?Q?jzKvGqX3Ym7KN4V9t5q+5U2oOw8oxslZa0Kdhai3k5zgjJ6gxzL6hN6LAInE?=
 =?us-ascii?Q?Y/r1zxtaQ/azruq5BWFEuMqxj/T5YhaQQwYh+SeL7yfID5Fj6PBdM5ViFNGI?=
 =?us-ascii?Q?E5A35iJbG9P5dFtR+YA3aNC+Ztqee/4yMQ6IYX4ZSW2pGDw1olvGMbZBkgJ8?=
 =?us-ascii?Q?NMxgq8BAyAt1CtlI10Zciu/qV8KMF9X2Vgwtd2gh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e47aa61-29ab-4641-5c1b-08db9df5c56a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 01:11:51.1031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqnN1y66G4BSx7Pk3mUW2rsKjN5HUTi5UuAvjERoA6VmsX/ZJfN5xPv2SU8LGaWRdSmkGkREWN9iaewyP0KMnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a hook named update_socket_protocol in __sys_socket(), for bpf
progs to attach to and update socket protocol. One user case is to
force legacy TCP apps to create and use MPTCP sockets instead of
TCP ones.

Define a fmod_ret set named bpf_mptcp_fmodret_ids, add the hook
update_socket_protocol into this set, and register it in
bpf_mptcp_kfunc_init().

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 15 +++++++++++++++
 net/socket.c    | 26 +++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 5a0a84ad94af..8a16672b94e2 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -19,3 +19,18 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 
 	return NULL;
 }
+
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
diff --git a/net/socket.c b/net/socket.c
index 5d4e37595e9a..fdb5233bf560 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1657,12 +1657,36 @@ struct file *__sys_socket_file(int family, int type, int protocol)
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
+		  "A fmod_ret entry point for BPF programs");
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
 
-	sock = __sys_socket_create(family, type, protocol);
+	sock = __sys_socket_create(family, type,
+				   update_socket_protocol(family, type, protocol));
 	if (IS_ERR(sock))
 		return PTR_ERR(sock);
 
-- 
2.35.3

