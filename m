Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6194B779CB8
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Aug 2023 04:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjHLCyA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 22:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjHLCx7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 22:53:59 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C73830E7;
        Fri, 11 Aug 2023 19:53:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1ggk7C+aReJfmezkzj+8Rsl1g7je4e8jS9PcxJbNJalz6grFDDORerC3uF+sd6cKfuT0uZQ01uzDy6gKhDsg+vNxI1YiBtHpRa8qhKjr2oS1IPxEVxbkTugGLUYdJSN4tQmXffsCt5wYYRXDvyfcyIXMEyI9BqbgQQ6pbctfu635feHvcZZsosR9r/JrhU3FHCknNUwXjCezIo7jFcW1kRMLWqTYyBXoZ034wvSMFEbkH5mk7teQpwAYIf7Csr6bKG/NlCFr+deKhFR9bXE0lNC2NGDDnu8PgLHgn7UwmcAWT5szzVHzcAWFdCqkyZdvy5dLhTpf/CuT5loIWYBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frsRNrxXxqJadeOymcQavUtRjGEgKb5wlejqmgRLXig=;
 b=DOQpg/mOsD/birCmp+r5UfomQaV3hQlEyBHRHw3kNsocY+eeN4v5BaAZu1CE1NOKXWiupBHNEXvxU4VmfKqJU7T/bbJLvRTQM8w3evu8TmnqGXA9d3GGywZYV87sgg3XIKJavAnqkuRRAHz5YxaxtgdBS5M40H8nNALvbN3dD27D+52FxNie2xM8nvYqBak7nzyi625n1RMGA6gWr5fOx2jJmq5NBBKMe7AwABZc7yjt+H8sVoVhgl8t3mMFjZNzZzFgjo0kQzZSZ3IeUbMzTJ18mMCHRUNujdMxKkY3WQzDhpxcBxNT1jrhGeOs4noFl8fW+avd20jlQBGYFChu0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frsRNrxXxqJadeOymcQavUtRjGEgKb5wlejqmgRLXig=;
 b=AJ9oYG6Q5Dlef+gJx/73x7qMSPG3jcNCjIVj8FrpkLIEkyl+fop8uERkTxnCXYRzZeUbrDS+H9bF1+gJnrgrmLJKP+3xXyMRZS7AlSChvq3jyPdWwePSzvlf5qa6lUCjmbjj4L3N6bjgek9/VS/2glR4tXRsvgAv+kkKboxFtEmBcD6yNnmU/Zss4aP8WRKOhj+dDoEmM9d9584xqHnhyMC5DSkpKSjJzkDtHgo8Y2RdCZWkfuSam1D6l2PVzwChoozqOgRKuj7RpHl1/2m/NKwDFjlixP5xfRFryy5VF3KORGjULpBJRiGEUh1BNZbrbm4HrkUXhrVlyfzen6shFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8981.eurprd04.prod.outlook.com (2603:10a6:10:2e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Sat, 12 Aug
 2023 02:53:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.022; Sat, 12 Aug 2023
 02:53:57 +0000
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
Subject: [PATCH mptcp-next v13 1/4] bpf: Add update_socket_protocol hook
Date:   Sat, 12 Aug 2023 10:54:07 +0800
Message-Id: <34fef6dcda2ea460f3ac5eb426f9d821009a739c.1691808484.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691808484.git.geliang.tang@suse.com>
References: <cover.1691808484.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: c01eb8f6-f8df-4cc1-f75d-08db9adf5f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcNTfTskpzMCb9fJOdwwEOoIoUxJ1+g/IU5AEPs8tMkyKI9boaOy8QvFLitGUzkCW+7a6uZeBqL1864H/bGG+Rm9RHwhv//xDH0LfsnrgLTbbdM8N2x62DRuYPx9rsGBzXD4s2Yfc/gmfdgKVcMGzmsGVSImIQQO5afYMjRUdAH9TS1Us6KQEKpfNK4jJnWpNP8fbFYMwBneElo0u7xI/T5uj/zrSUefOlOsjyymoA1XLXOQbMHk5IXSJthLygJGQMUGA4HbFPILtRER+Hd3VqYnQsckluJAm/6e7bSkQznhvyu7TokqMH6xUt/iMVtfbGJpWsb/fonID0TehHZQiWcdOuJovFGpUJc1M2BDWpsco/KCiD1QztqOMCd9gI8JFElkELrxRn9uQMMr68Laf8fHtTOvl7DiDA0b7FnTUmzp4p3WuQ+0QVdsOxZJea+rGyXggFrDavQkkVwe1ZZevB0zcf0aqtuL92s2JpGnqxwwXEtavjU2nI8E2rA/IWwk9GTMUnciaN6KRaT3GWC10jTl7htrNvf1DCt2mGJCzQwn33iL4XePasiijDvEBeWdLli9pkMIfhC2jsol0amnT+p7Be+fnVUDgMbsl0/OH+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(39860400002)(346002)(1800799006)(186006)(451199021)(478600001)(2616005)(26005)(6506007)(110136005)(54906003)(38100700002)(6666004)(921005)(83380400001)(66946007)(66556008)(66476007)(966005)(6512007)(6486002)(4326008)(7406005)(316002)(5660300002)(8676002)(7416002)(15650500001)(86362001)(41300700001)(8936002)(2906002)(44832011)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QndmyAbKoh+pSZoFB6KrxYIENHRXXddPqEmrbeOAbFbhybPYaHjL85P3oyIN?=
 =?us-ascii?Q?MQJvAQOop9txYml3H22iGxIogU/SQxyfum88jtna0k50lLzJhBkFYrAFQsGL?=
 =?us-ascii?Q?WzGqflAFFUlnm2PxVRPR0WS75cUqhLziWcEf6ExAZQjPXrtxGUk0NVdF9JdP?=
 =?us-ascii?Q?UhziZwv5L4gnIl3H/vXGAVzYCsnJ6sRrpt3f1j3dHttE/GCgHHBvFYYd/I+d?=
 =?us-ascii?Q?nGReJhIrs6I4+6EFikeW1bEQ15bzMSWp/GvILvEVOrmxmFZkDdVIV0Hh354j?=
 =?us-ascii?Q?AoXQAALQ5TKCbZw7xUb83QSy/ESAF2OL8T23CO6AfKLT8jm9oqyol0DmEikr?=
 =?us-ascii?Q?k27h/rbDBxrolpmGzSVWXcTtK8MaHIhz+0qfRF186ESUQUH4sdPs2F4+qsyh?=
 =?us-ascii?Q?aDOkEeLpLYGhmxHAhSCkjcFsasnVweg9FYOku3DPWlmHpa/cEBfni3Oh3U5Q?=
 =?us-ascii?Q?KnxFJHPSY6yKmrBi4tz17NBwr9ZEppllDoQk3DLN3Ero+4kymRsWPW10C8YH?=
 =?us-ascii?Q?r+Kzzc+bmgEYrtml+FOH1N3xmqacbP+f3MlPSVaUfKA+MoJa30OHTZMg9A2Z?=
 =?us-ascii?Q?fSeC4vBsb3xLzMYnB5g8aN8hPdwNH7iLnOL/OgT9+CNANpUsy9PK2xCGBadM?=
 =?us-ascii?Q?xDb1/UUv6XHpnJpEhzPO+ZNL6sGHbvMD7OcMw6bfeeu3NMdMQCRjyDy5KlvR?=
 =?us-ascii?Q?0w7Fr3iOVnhzHB1xqFdlAG4BrLeYWyCYpxhp2U3xusY2Hbx+I257i4DCY1kP?=
 =?us-ascii?Q?WuB/56nXeBuM3li8Djf5wnHT/wddclXL4K6LNUkm/hj7y8DQp3OBgqDuBSVF?=
 =?us-ascii?Q?cQRRBquX0cEwOAm2i449Nd8emlqgER+4pf6bAxJQEAwN6RHAwWZccp+vHda5?=
 =?us-ascii?Q?jtJUETeiPxrG6tpetj75TflEJVQILI8/0HPyTxeNDEy7NpJJWA/esbmu7UYy?=
 =?us-ascii?Q?b9tO9F5BEn0ozuCig6nO2SZoS96R9fiLHEjb3hz6WQYOPjaxqqne4jKHhn7e?=
 =?us-ascii?Q?08arXAe+FlKocIHKxCuXYLgwadCuD6xzmauk5WuyhpCzfA1jSff8McyBaM9G?=
 =?us-ascii?Q?2hogrjeH6WbRxMZBfcEprPRFNbvJJwUtgAO1m9IqEYhbHwoIj9KsSGIMO1Kw?=
 =?us-ascii?Q?BlelBzS9svid7yW+4S1U9uS01Ak1gJ4d0o8gcXw6FzlvG7UNLYbnbW5MljT0?=
 =?us-ascii?Q?hOGUoqpn4EsljkRkO13v/vWB5w1fALhryYExjLndC8OY1ZajZ6xUlAE1wu0L?=
 =?us-ascii?Q?+sfaBvaqRrWoy/IKYM+mCLKmqeb5kl9sBYO8aE7DScTpf+ghBZ3kvIt2hqni?=
 =?us-ascii?Q?W8Y5e+m6KEXQlstZMvwVlw/BcgIWViCTQeMRDg5y55YrvsesmGgD63EOZ8XF?=
 =?us-ascii?Q?V6MYzlImCKm4D0sN3tbGvhAY9bVX4O5Xkf6Wyua+joypXWfttyoxXdz7dXzI?=
 =?us-ascii?Q?RR/6V6b1/HDnpHC2hnTqSt5oMuC7QF+KvOMXMPKGp3yeXp8HgrxEcqVpIRV9?=
 =?us-ascii?Q?1qAQApiF075IY2AxsML7+8+vnKcNY1FovqBc3icYAjOjz+6zYPlUxuZag6l1?=
 =?us-ascii?Q?+aVIZPs2gGxDuBHUOwupvVrieKakrvnSS3Gfzt5t?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01eb8f6-f8df-4cc1-f75d-08db9adf5f47
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 02:53:57.3316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7xGTMSeATIL5z1r+LUhQlM3ts7UTuKuCJ2gjgMZnhJpcbWuOk3+QIEc3M6ewxB4R4vDubXE1oUDRi0bxKCfZw==
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

