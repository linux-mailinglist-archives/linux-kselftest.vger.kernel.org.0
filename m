Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BAA767DCF
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 11:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjG2J5b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 05:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjG2J5a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 05:57:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2088.outbound.protection.outlook.com [40.107.6.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E07129;
        Sat, 29 Jul 2023 02:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCaIbJWy2f4BNsjwBDYXnfXFMs09wZhsf1421Iw+3EbfN5C5qgVbw7gpL75l5LVp9YCbtEsKOfMNAnT2ZfPQYu1/XpxWFzrRQLg7YUmPWI7LjPVp85rHrOfzzDqEa1KWOh1/tDEAVeaJQI5k2OU45/5irrp4zsjpbq+ApRpxjgmf1O5JGINCakp8e+A5ZuYPbwHCzZJGu5NriDKw055XCUoHqrillewkQ3FOfWqurLtCCXs19oi0qkgbuT/CbFsX4z9oiLgh7iqjRFx35u/l6Eo5JHiAwQl3D7RoXVvB6HPNWHV1t8jORYUXeN4orKg19nkkJaTJ8zKv4UD5mpeAnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uc3rWPqpo9AJ3vXV8zv6TYKhLBzpJxCa6nqvVpw+HO4=;
 b=gvgSY2J3O9IFAar+WHEsbUfCy53A20a+UDiPvXVq1IDJ9vHgbo2vZ9p7vFg+ogJ9Iv+V4mmgMjPDEdOaGn7l2DKiIePXc4BbDLdcSrgAmHvqBWOX3TTAjEtl0rJ9c48wKozDvJy/x6PmPzu0WHcIRpIPGvGXurrhrCHicZo52VVCPiA+L34/AXhzBYl8REyWi/CPuYthsdmrFxjGNWojlOGTLURFBESrPM99+YED7FbVc0uH5U8YzCn2MmOSBvbnu+rPMG7ZlWYdYo0oyRRrWLvm/szy1goBFoNXf1A2/TYDHrraO2Lz/3YfeiBFpo4DSEDn/ZEsx6I9RLOpByY0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uc3rWPqpo9AJ3vXV8zv6TYKhLBzpJxCa6nqvVpw+HO4=;
 b=HgQuFWPhcWnEDFqewQmnKxHnVI34as32vjwD495WjsQRB9gqyeR0KO9f2+bjE3qyG/SKz1MMazkY8oTTYy3hSuR/sFQm2Yn4ybD9CCbCSrxcE9HkP3ULA/wdvWfCD1oKOHIgg8/QJ+lofNBORX5d16XcjVe3mKzWmDJ+JfNw24QUOUAyfdBPwVwZxYN8AS9SKAxXRclmVU1/WJvD5ZjAowfIsYtJ8xBuefyHY6AmrrbkR1Tu4Srk7ZwZxWh1+enmf645+AlRVhtZsZmBbChAmzJNueNIb98N3j6dDRf3+ZbKHP2gaFOeB1WB98v1yvoO+FwjCRoSXQHwXQEPo5Oz3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9733.eurprd04.prod.outlook.com (2603:10a6:150:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 09:57:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 09:57:27 +0000
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
Subject: [RFC bpf-next v7 1/6] net: socket: add update_socket_protocol hook
Date:   Sat, 29 Jul 2023 17:57:22 +0800
Message-Id: <b6637b9e4345bc906dcc336269e9faa5eafe0786.1690624340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690624340.git.geliang.tang@suse.com>
References: <cover.1690624340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 51060d3e-b7a2-4139-105a-08db901a371d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1V6Pn18qOTTcgd2CGW3OGsePRBjt78LkccaH2pYefjN4+0wxlLAYlCVIL89HkeUJpELFEMc5TNLfiouI037P4l3VsvsDBXWZq1l60CfS3A+bsVrClYN5UyJn1L4rTitXsGnUaS8veLhTWWL3hAFvNgq2Vk3lnqFLZbVv4mSDczDcJDVz/PQljjfT4Wg3wlTg+LKCvz/UCnhDNPRCqPD9j5jaby3ysC0dU6gGqldxQE1Q2IA02r5zUV2WP3j5dhk/temSBbrBmK46i7G7AZO8xYgw2GLcY25TT57qcc5NQlJPF4sNWnuNRiQ5bZ/m36OajaL/zCPXznNQNMJRAMi3Xj6HZ1XTTKskvRq4K51DnfUdamgPm9M61kQjg/yxgEVVKzDl44oYHOOS4iVW0yYzIAq+YlwcFV9jVqxeYfQGRiIHrmoC/rN9nfasWz4syLUunh/AN9W9wTXZeLUJNvF3lrK3OAm/cU/rXG6wOhIUJgjwnpgKsbN+m8frxukRA++qRP11tWxafowx3SvCVvQtURJx88Vgryw4Z64sj9tqh00uTEfMDmOjsNz4xgO7bje7B3MD78e5Hr0kmUkMWeZz28k+T2+g+9JO+MCAPVqPXak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(316002)(8676002)(110136005)(478600001)(38100700002)(66556008)(921005)(86362001)(5660300002)(4326008)(66946007)(66476007)(6486002)(6512007)(6666004)(186003)(6506007)(26005)(7416002)(7406005)(8936002)(2906002)(41300700001)(44832011)(2616005)(36756003)(15650500001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NwfQMjzDi3ij7zhb75TJgkXCU5qmgxtjW5gJmj1AxAJQpNWb92imztPQKlWv?=
 =?us-ascii?Q?qnfC2JPb97gNPC4xhekOS2Y8U5WEQ+n5T+5pjI/iNx++SOM3rWWS0T9KYm8o?=
 =?us-ascii?Q?3LkZlr2jSNKB1fQJ3WSKKoJjtUGmcNvmyjHHWxlTqv7/ZcleeAwBBShtpn0N?=
 =?us-ascii?Q?sguOvNxnBwE7icUjPIVPVayl4JnXJP04XvljGL21bKTfJ1hSr+YrxKtOZNa2?=
 =?us-ascii?Q?VQldMNC8v5Ebtq4805cxBVFVsccaM9KkqZcqL+c7ngC7mBl+pVeaE/IApz5o?=
 =?us-ascii?Q?2t2oXflG6xb7eLm8XS/uBgAcjy9qgSbdWN1wb+C5ON0ic6M7xVMiUjMhrmGM?=
 =?us-ascii?Q?gdGbEmkBBKcVOoEEFUp1YXzGWGeRS7va2CxRUY3QOAdW0SFAip15Au0BfBVr?=
 =?us-ascii?Q?yH2glocAiydW1XpiZdGIQKc6k2Kjq+QWr4ce/tS94cVDs/Y5vFbHpp9T+KP1?=
 =?us-ascii?Q?bNf37QMEIt/otkaLNfbwpxZqhzoAcDXr3HCypFsNrH4tGxe5sbjbN6nnwXAc?=
 =?us-ascii?Q?4SA5RqjYwQWwbEzxVY/3C8qGKqSdvLVX/xFboHdEeVuE7BILkX14cyUI4eNN?=
 =?us-ascii?Q?qI7KRhmt6HB3x4aKG27VCSQAuK/ytacbw66yH86ONdbL6GNYOMKwsFx2qdC0?=
 =?us-ascii?Q?id91E7xzOK26goewG3wjtOKvDWgmIB8IxWnRFCxHjHwfLqXoXwGUOp7ckMOO?=
 =?us-ascii?Q?FEXxfHUr427ahEM6Zasy2ANkKC22GuLusUbmIUmHH9oB4h+9Zlw4b6PR7UlG?=
 =?us-ascii?Q?Ol/KiefP7c0tz0bMI9FNMF6h9UGty9gDztBqQzUxrQy4AMdv7utEKJFS/PqU?=
 =?us-ascii?Q?YpeYvFp4tRlrOUoVfKY4zEAUt+/yhdU7nfpSmf4x3bPF+RK7CUoAMhHjXFj8?=
 =?us-ascii?Q?ozpVa+93EmT4yzvTMgUom1vTFZ3NwTVEflNzzfduaqnxF7SELlVeE1NTARQE?=
 =?us-ascii?Q?7szGjEk1k7+ZMRnPUjMTiwH4hRPfb5LngSnJmHar7NmiDiX1fbBMf55EPyTu?=
 =?us-ascii?Q?0BCrKwID3SyHZvOr3KFJzbYY35xK2Ed4jy73Oj6adKaFOzRVnVsDtfIoRdTZ?=
 =?us-ascii?Q?Us8BRltsYG2WfA19PnXHp/E1Tbl7NR4JQniHeAqFu11+V9aW5gOBk3m8gUxE?=
 =?us-ascii?Q?CBqaF/4I8SkNWZ+QIyOmes99c1vECIvTIUdHqlljFL0BfFmXSkYt8IQMH66P?=
 =?us-ascii?Q?Trt9wow0aERzgb+3L7xpznB4ZlWPe8//Joe641roM4hxZHwqACKd6GadEeqN?=
 =?us-ascii?Q?TKjwqNKEUCJOMpha282VfLsAIlWXFR66LUE0hOQHgm1nJ8sqAFPE8Zk6R9MS?=
 =?us-ascii?Q?sdubz4Q8gl0nMryAw8fADOf26d2wuFlifmYxdYyEMR6pGVxrNVEvEobqzQIV?=
 =?us-ascii?Q?seNOqbVsX7eS+JSQGFm03/1RVkXGA9yylp8lxGTxiccEaSI644Q7SFnx84xu?=
 =?us-ascii?Q?UNXuENPIx/wBkIuNRxuQyVm2sugWzN+/H6f4uk5pcUUAciSvd6p5Jp5C0KjX?=
 =?us-ascii?Q?RoChSBXjGM9a8t3ERmelWA5Huahdjd+E5CuaGUK+tz6vggEFBrLjXInKFVw/?=
 =?us-ascii?Q?kdwKPpT7iGdo0GrHnHrqVfoc1FllykeHMBvc4/PD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51060d3e-b7a2-4139-105a-08db901a371d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 09:57:27.4710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iw9BOxp+zLyyEO9RqxZXCe9qtJTu4A8AIPVLQBlYMbZ9g0uNiiFQb5PGBRcw7EEYxzuaCWl3gzuCcDRuzbVxNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a hook named update_socket_protocol in __sys_socket(), for bpf progs
to attach to and update socket protocol. One user case is to force
legacy TCP apps to create and use MPTCP sockets instead of TCP ones.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/socket.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/socket.c b/net/socket.c
index 2b0e54b2405c..6837a517ac9f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1644,11 +1644,37 @@ struct file *__sys_socket_file(int family, int type, int protocol)
 	return sock_alloc_file(sock, flags, NULL);
 }
 
+/*
+ * A hook for bpf progs to attach to and update socket protocol.
+ *
+ * A static noinline declaration here could cause the compiler to optimize away
+ * the function. A global noinline declaration will keep the definition, but may
+ * optimize away the callsite. Therefore, __weak is needed to ensure that the
+ * call is still emitted, by telling the compiler that we don't know what the
+ * function might eventually be.
+ *
+ * __diag_* below are needed to dismiss the missing prototype warning.
+ */
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
+	if (protocol < 0 || protocol >= IPPROTO_MAX)
+		return -EINVAL;
+
 	sock = __sys_socket_create(family, type, protocol);
 	if (IS_ERR(sock))
 		return PTR_ERR(sock);
-- 
2.35.3

