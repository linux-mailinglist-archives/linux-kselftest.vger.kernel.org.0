Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4563376F959
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 07:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjHDFKD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 01:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjHDFIA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 01:08:00 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B594226;
        Thu,  3 Aug 2023 22:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXZfdhlssHsvNFQypnENJI8ufnm2XnI94XRop6+RtD/moryiYZR+umbKHeaSdSyAhxEUpqIoMh43TvcfTvDv3hK3M4drvaEfSFL8EQAbmV1PWp5EcbljmHuVqHdVMznbpIms7ZguB8IrkoHpqo+pNBCGo5HZ3aoQ3/xkTbHRREbLJuPtPWiwQslQMYn1t+Yh/ErdwKGBEIUf+QATshgi2fF+oL8m1MXjF/ZVkE4yQeym5ieSHdGgjPkYcC8VR1zNzDj4tD9US3xSb1AroQPW7uK84GtUM90IHa5EXCmeCfO9Dt6IL/nAh2bb0goxY1CSUuWE5LXrLK92C3su6AkgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqQC7wtcem5w25ikCspTa0HnuFuf5IRIq7RQHED/ZEY=;
 b=HmBQfAohHe7DAoljvx6iZRdkljlQMZxZ5BgR8Ivnit8SaaDRzniOt5jgTwPvmQX4NNAwHvVfhnKq2wrrXK4jdwoyrAmY6n5VcjzxJDsSRJ97M99OWVVDcDRKj6JXftxc0s9yN/eDmq6BYJogpYCZk4dFfwPk9B36z5hSyMbqAS/zSqFI2ZfS4wi+o1ZmPLDtBE8hPImCT85pMTT1/F8DHBZ7zU8Oz0qwAOQrcsC5vRy6puEb2kBHViS/zZ+vqetF9VP4Pnj6N3B5LR99cTf6tesGzXAlrmuLTPhFEAMw51YstEVLhBE/C4Qclf5IFbee0hVNnfOwu97l6yvGJmjtpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqQC7wtcem5w25ikCspTa0HnuFuf5IRIq7RQHED/ZEY=;
 b=1GvAhVrVpIxktJeajVVvYXzLrKku15VGR0D6U37lbAib7uC+J3yW1nBMgYbpqBT7tzzgJfckgumYs+vgnee4A8FOVSB4Pq60ooZqMpnKk0/+TkTnJRfPmUstLYG3j1aKQTAcgyfHsTDumTv0n0PDhYkhRO80DOhSvFeMV7TMKe7ke3+YPjWqYTSjs2DKhSMwZU5TVeSCyF0kvqqXgyufFBYxbCheg/5jGUUH5p9Dbh3pUCyjK0Xgg/483HWbcNQPI21I2tuHqY6XhzdmCFTTIf0VwyvaaEKPkTuWoR28TuJM/zaxWekLlmvH9cQOOrgiXaQNHVtu1H5yBlw4wjjleQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10061.eurprd04.prod.outlook.com (2603:10a6:10:4df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 05:07:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 05:07:38 +0000
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
Subject: [PATCH bpf-next v11 1/5] bpf: Add update_socket_protocol hook
Date:   Fri,  4 Aug 2023 13:07:39 +0800
Message-Id: <5155cc5bc678564fcc4e0f6d4a4f82f646c66beb.1691125344.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691125344.git.geliang.tang@suse.com>
References: <cover.1691125344.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10061:EE_
X-MS-Office365-Filtering-Correlation-Id: 92fcfff0-56a4-47cf-5673-08db94a8b8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BaLHE1LwLlzY7p4aU/AEJKrDJnHELmucfQ3tiQvQzfkCVN+Xsvmw7EJWP9g7jrEpYlCChhwulqnVbh4AmnBh5G3BigXhd/eMVVwQhS9FB8fYcOjgDRJv/cu6/2zrsopUvdxjkKPsJ6C6TUSEFkBjFbn6tjRcAComZH6PtyrkzVyU7zklRvwolfYYOUB2L+pXpAypq+NcXn4UiRQA6y2PdVPirmvXLfT5lyAVJ7yecB/3eDtKa9L+UWLwoHIlHNJGHQ4XclsAMjfdvdyfVhl6RIut8tRkY6BsBSMoLNoFPhb5WDx8gJaImJhrvCpTTYR9kPckuGT+JmyL5nMRS4XlWRDJPZlKNjQdFbJ4Q+iJEnKAwxS3t7aOFHL0juMNiQrPjXICcJ4K08z49+6IZpgP+CUnr/JvoZqeAgZ649ANWRYop5l8u3GLrE1R7xdUPfp8mPCBWuYJWWUfI1TiNAaRJc057mxbfVgyLLhBhcL0c3f8Rmqy92M0e0du0GEFjH+4lKc35/iAF17ot/sr6xFFjBWs5hTzY5tBGsHrCBnKjkJn6c4siFF8Xx3I+p/Y7apCptZ5B6P8B8Ee59XShkws2+l9yfEq5ZvUPAQzgN886tM7OdVBjv/AIOWrEqfIrt/k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(346002)(376002)(1800799003)(186006)(451199021)(86362001)(36756003)(54906003)(478600001)(110136005)(38100700002)(921005)(2616005)(83380400001)(6506007)(26005)(6486002)(41300700001)(8936002)(8676002)(15650500001)(966005)(6512007)(4326008)(66476007)(7406005)(66556008)(44832011)(316002)(7416002)(5660300002)(66946007)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lHXxGiJ/OmZKuCSO4pA8LvWah7rS2b7eYmeg6i6b/0oqNPInA1Db1BEg+xgH?=
 =?us-ascii?Q?km6eONxzK53JwgHmFITH7dqwLUjSuz6UkGCNpqL3EfR/wk4YTZ2oKqDmb/6M?=
 =?us-ascii?Q?7SdYJCTMi44ibWeoxF4cR8jqQdGkmg3767VtEH4bkDXl+IAmetnO6dxLzFT1?=
 =?us-ascii?Q?5ag96jPU47ad47RVnHmdb4Mroqqy8KOudt6jyEyrc8zTk6EOaGVJ/rsrqG5c?=
 =?us-ascii?Q?rBYIHLFzKE4rQ03fEVsSqlPeMAmRnUrCkO8Olk/jnpiQc24RHA+Luh7QPh9+?=
 =?us-ascii?Q?GKSMAK38TFrADB5u50SWOwQSDaeB/o7wlXz0d8PhAJ3x5gK95YFQYDepjoMU?=
 =?us-ascii?Q?efWcNh07k4OOGf9SB08xFSh7/k37yuI3xiuFgQ8PxNnItl/MJpeif2uw94dY?=
 =?us-ascii?Q?vk7UMgZH01GWNGlT1eirJS2WLNi4UUAJt8CqED12dojP2GT8XA/I90F+flCz?=
 =?us-ascii?Q?6EtLNdumPAlHRjnIBMeBE0Wx4ijSmbjYWBIWhSc+WNSSFrevTEcxs96D23ai?=
 =?us-ascii?Q?kaqa7y4kIIf5JKqADhws1yh8f3gd/O9thv9jKkM/LLGT8AAcVZoHtYuQ3L9B?=
 =?us-ascii?Q?++xjmR7UDNOqQBzB8sQCb/KLoCPhNTqJYKJWAXkAWz0K0q4Nq9Z9sZHGJga9?=
 =?us-ascii?Q?ATEJLarQdI7erfakbuE2J3tcAIqVPIHxJuaWtDGW5EX1dK5ggCO1fmeytlQs?=
 =?us-ascii?Q?f0hJnOzEtVVxryislrH+phLjdhOS9+5dMue5K4idcg7jj/Rj72hCF48x9Ur2?=
 =?us-ascii?Q?b/WPFblyZF7z0NNj/t39vOb5I0neZNswuOUlmD/DUM+yZwFSPpdWRsjqEDO4?=
 =?us-ascii?Q?OCIuV7ZB52CYrEGKwtvKvbdsiwf3vyAAflSUb7sxH/FxdU9J5HZhqYmA7y7Z?=
 =?us-ascii?Q?68IGHI4CqCqBFQcGXrxWE8UrcXYN0Olk/RclZEN526vSwYiTRwvDw6OV2DJH?=
 =?us-ascii?Q?BJ2FnAVUR8H0p5u30Cz8rxL4coebYuaDRGLCobcWg27GsULxhChShvGS3b2U?=
 =?us-ascii?Q?Y3ws2oBkscSfamS/p7C3L3V2uBi+IDzGo0sFCJkY3Qlp7glK+Wu61AsNGoE3?=
 =?us-ascii?Q?CBoeQ/ZgmwfGKZB5ZvsSBszcDOcIf8PfF4VQtw3Z2qhRfPAeOs8mFJ7CG+Vy?=
 =?us-ascii?Q?yQgFdOgY5tj20WninrDkg7O5QOKJiKxJ6S3YMgOmKe99WfuUW1b2VmbcQpcW?=
 =?us-ascii?Q?fT0/5AlroaHxcV9kXA0ATpL0DRpNLpox3AiVrzgyHwQbUemLgai4fIY5TzZA?=
 =?us-ascii?Q?y6R4q1k5kYoJLvFJteXF8+xUTGjpgo+dbHIEjpJvOLT3lT8PzqeH8EzzSmR6?=
 =?us-ascii?Q?WWLy273K5wZ7+RUAP7Q2VNzoxLYCB1EksC+GT3nP7jndgCYfq1Tdqqg0eeGl?=
 =?us-ascii?Q?SWAr65jBbYWGJoJPprUkpJg+eitomOGEytB9ZXkBFbRZAFBr+EPhVN31Er6e?=
 =?us-ascii?Q?VeqggeUlhFBVYZrXb6OhAg23sqrp/kuKxyo/CH++kOJtvcM0HASha16zNXvF?=
 =?us-ascii?Q?JKhc+cCmCDQurt/6TjT+Pcylb2ArQHITzRVTRq8qf1cVhwmRS/TYDW9SEVJq?=
 =?us-ascii?Q?S5QflXUucKRIFcZUCrObe2OsuT0jThrtiaYqu+RE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fcfff0-56a4-47cf-5673-08db94a8b8c5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 05:07:38.1228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpBmmYCkebPHfVYQf+8oXtYGPloS6hlSe7tZWXSwvLoAuSp+nQE1I/UkTBe7o7g49K+CTuSUuXlRWr6k5w8IEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 net/socket.c    | 24 ++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

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

