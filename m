Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5904A771A29
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 08:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjHGGWr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 02:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHGGWq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 02:22:46 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D4F170A;
        Sun,  6 Aug 2023 23:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIUi28ZkGXmEjg1LUdm75eZ8mSS7aTXNTaYps3YJn5yGs5UT6qI3wXj/qU3RlBYlTD7gfPIqqDaD9LxSN5KF+XqN7WvtgQx53BYR8RKD437DraSxVQ10kJoCuburFANtynTKKmbv6Jp4Gz50wznxBf8iPJaiqzFJ1Q+u8JSyEWzilnZoBSapZOwqdH0JMN9iIm8IIQ6fmY+80DfNXhBCNOw4/m//oUWvoSCxlzkd5eg62Pb/xh8qEMNke8XHxFzl/0LYcmVLkWsWZCh6371PeZtB3gqk81T/oPujt0L0Ht4UyXMbB8ImPMbjEglRpPE3DKuwsNqjBvH0rfC0EuRYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAxFzr7wfHCtuXtb1bDExLdi+n7W+c1rboqRkQMU4L4=;
 b=eZRiDVZ+WMAXf2YW5e5acekTKoSiNXzc6+wmkfjKHdr5d3B9pZfqX7bbGpbcNITzvGitGqshUIE6cpKMPBhHJwIhb9fzB4FbqDX1YvquOubrTK4IFNXinnFs/XoO19umnM04uHRvFBqU0+o0wHE6Ld347HZgvn5V8Q3bch2V6zg0BNRCPkzmkYJlOIwcDBLtHT3ACIQHVtzokywavEtCitMYN0Bfd/T+VBNpeUQoyjESsZ0gvCWuo6hqOqpcLgOyYkERGjDV5icohQS/KB90vraEzZj/O9+DQNI4UN/ZA6BrioakxDECxhEL02dyMdaPM6FO6+4bBvAOwfkaCvAIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAxFzr7wfHCtuXtb1bDExLdi+n7W+c1rboqRkQMU4L4=;
 b=fLHPgrJt8Qjl+ibIQzoafiKvu6t723IwiyI2/t8SFN5LUP5YuvlqAikeeM3yWjatPtmyywLUgLfhPEXRa0mGJnv72EdznfizOeg8vHwCsLNIXR4oS4zj8IgqaKmNLl/kQP1USDtUrN7QUJ9eb0V0P7WPpgBepzj83fNjXV6toq+n6mRUkTo15aMwiphsCc5UxRB7ST/MIODmVHBI+Fe2krfzppwk48EY2BmbsfwGAgdU4diWSfWAmQlwzU5b/IPpBo4gKwlQTuYYlwgJA6+exjQTUFea4bSFUX0EGlwALVzU5emeC3Yim/WWxbZDoJ/bmkvajMoZN/x1RdQX5EBjzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8883.eurprd04.prod.outlook.com (2603:10a6:20b:42e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 06:22:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 06:22:40 +0000
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
Subject: [PATCH mptcp-next v12 1/5] bpf: Add update_socket_protocol hook
Date:   Mon,  7 Aug 2023 14:22:41 +0800
Message-Id: <d4097b251f64da58caa6912eff7b8f6c63f9cc39.1691388735.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691388735.git.geliang.tang@suse.com>
References: <cover.1691388735.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 03609ebf-4f75-4503-c760-08db970eb35e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZWLizeJIR5KwtgzWCpUQVETN1RLi4kK3BllMsWMT+ZvLqYRX0BV+ne2Ab0TvhgsufgJqKNHBrifNFfvZxBz/FJ6eal6xeIBPWeVo2iab5sFIcs+dSMAV40fC+YTzHS/kzlEC6qVKQH1VXHG6if27o5Rnf0wKr36WQNBK20Peevti6zLVyyrdsoQ8jbaVkyJlVH2p8fwsruSibJLQGYfryak11S6IyuTBhckEXEzMZbC3ZL5FWnCanYPekaxlD7aTuUolCZtTSlGe+7S05I8U8gd8qbHQXw6MBnhdn8ypftiWmi3DBI4YyU7GO+BEtGyVYUtZf/SS+JXTnh18oQWHbYF4lP29M/MLcOfBCqg2jnYZUTiYjELedEGRSQ4xV80Flgip+8xqsnXbFN0/JVQASMVoMjgTRFJFAFo4T5jnuWf/r9jCcq+KZ7bJ0Td3y8lxgrlVyai0dvMJfF07pkhNfPyr1GWgFBfjcj/XbiQYLacpItw+aSe8dvuREbZyOPwivMZ3WEglfM6MjOnTFAeZMI46avjGbrpF46n1PyYIhGddLmATUGPqejBYlBre3sHIcVfxtRJG+nH7uJ1Tyu1cNeLVlT1NTTYUUq95xg11Txo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(186006)(1800799003)(2616005)(36756003)(966005)(6512007)(4326008)(316002)(86362001)(478600001)(921005)(54906003)(110136005)(38100700002)(66946007)(6486002)(66556008)(66476007)(6506007)(41300700001)(26005)(15650500001)(8676002)(8936002)(2906002)(83380400001)(7416002)(7406005)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BK/kiIqZ51p5zuBkLazjcctuB2N9CD8KwFutpwURfNT/8o/EWb2ao8qPU+GU?=
 =?us-ascii?Q?yVylOAG1WreXZ4gCHHnXhIx/i3bSySD8oM2KT124yxRw2+s0+vuwuVHmQveY?=
 =?us-ascii?Q?BHOfgPtoZL8f5P+gByx/FEIlg/DX3wxbSw+EuVZp89ojga5tGY3QmOZ6jxHY?=
 =?us-ascii?Q?PEgjgugaO/x7sJ/ESMQsXB5HYiPwgtiCNhAC6JWlFRRPfAO40U/HG/f4+eoD?=
 =?us-ascii?Q?Pgwpnsd0OvXS+9vILUHQVb/cB8UqQVsLBoeijiCprz/aIp1ws/q6o+jODoZQ?=
 =?us-ascii?Q?XZUAT5PbXrH474t6nDfQaD5wwGh8Wj9CFKGNWbj5ZroTA74CIpwATSpnXTzN?=
 =?us-ascii?Q?9X8F4MlnpcTTr6ew9TFkqOcp3a0Sf0LAGpdvZ6lQufLghQd3UGZvp7efRs3s?=
 =?us-ascii?Q?fE2DxncOshOuW1hTLdEz7O3NGVVh6hKHwxENWiXX2A5dSHVb2kC+Agk5sfsk?=
 =?us-ascii?Q?mF08xpAK3A0xVzC+amZQet8cWY6W/QOAUCRUNhPzYSGM+9nIosyQUVvO6Zwa?=
 =?us-ascii?Q?eLunl6XQ/XZNvIwR37dfy6bDmXiRp9PlgqUZwxXCmwrI02Tm1qPu2plKvB1b?=
 =?us-ascii?Q?3bFHLt7XVaQBQX4KcLsNtGLyVDW24tQdryC9VOCXC+33BL57tophJjvzrkAz?=
 =?us-ascii?Q?rlpqep/kGqC6+5XlUOV5VVIVnGeL51d1jL+RfgHq5VP4tPl5urzg0GDMX8fD?=
 =?us-ascii?Q?yKDHUpOy3DVzc/6G8G53h3zdQEeq5DO3Ij0qG4qQ9UtFD9GX/AL6KXvChUQX?=
 =?us-ascii?Q?w6CuUwLppG587+qINUbfA2I4q6FxY32MdaWwE9swsKpjSYnSEkUyQ+tIGzvY?=
 =?us-ascii?Q?z9qSy37Yb5Bkvy/ux36tYrzNOj8Gn/qo6XLbAC7ijDvOtyMkMTILXBJIVShG?=
 =?us-ascii?Q?nBccOFftkH6eY4wQOGoz2zN/XBcmRuqo2MYoqyzV5MvOxjJ9TgO1W6IGICFz?=
 =?us-ascii?Q?v/9bF0CkyZk7wrUGkgNNtHJOWL5xsHB+erPL9BPxTFFe2B4LmKesxPPzE//5?=
 =?us-ascii?Q?/SVsS1WVC0uDLXZlESon7I1a0SmDzThh+2JqJ3xg/Aq5GVzkgtcsMVVNLFPj?=
 =?us-ascii?Q?hkk7OOHQ0G5VZ6LIvyMzoLHTfal3TwpqdNIO5HE9G+o5yEXrNM66s/khgCjF?=
 =?us-ascii?Q?URaMORrqAB/vJ6r22wnsMaN/qXoSN4zudofR/hdxzc5URRcz2TqfJFn1bbAL?=
 =?us-ascii?Q?J3Ri8tgfiBtNgWdqVAX8fkuPsGda2S7lLxWem3zBXn1cZ3LpjlW+PV2bFJI2?=
 =?us-ascii?Q?AzRl221Cluaw2FRoixEbjY4XQ+TKoT941kLvkncmnTKp+kHdXlSwDGR3Ni9G?=
 =?us-ascii?Q?Jl7a9lGEZMfdZL1KSlSBJv3PXmX5gMCheTjkKaqKl5ar92NxhJZ0GTs+JiDk?=
 =?us-ascii?Q?X5aa1a2Yj/db+w4uXwbu0AR5T/pSS+nSPNaU8STUsz4HYGBvriaAoYP45Tfh?=
 =?us-ascii?Q?xJ1CXuQVhblWMmBfKpvXWxYiyOpyCMfb1Uo2oqaiUn22qZ5Ah5NB3QJbw3NH?=
 =?us-ascii?Q?TUnucgzIY8leuO7JcMyWD/99LGbhLOp5GdStK9o/AV212CCecx7AIJqtwYMB?=
 =?us-ascii?Q?SWnvMSoI6wCVK59CebaATygF+woJmDToeyMU1UZM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03609ebf-4f75-4503-c760-08db970eb35e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 06:22:40.1315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89gonnVRTxvFMxXg8HTNnHLU75bVV/RAk5mRTjYtjmJe+PoCDwTSSXGBNzAiT70mWiyF7T1UqEH2OEM8U0zaGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8883
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham
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

Define a mod_ret set named bpf_mptcp_fmodret_ids, add the hook
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
index 2b0e54b2405c..e9b2e754a103 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1644,12 +1644,36 @@ struct file *__sys_socket_file(int family, int type, int protocol)
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

