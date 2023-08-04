Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AA476F735
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 03:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjHDBz4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 21:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjHDBzv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 21:55:51 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A93F1FF3;
        Thu,  3 Aug 2023 18:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoLwFTsKFsDl08OVLLil++PNt0O4NMbuFplx0EgRWdt4oTuwGldEyTDv2Neq5YLj9rD2RAYcQLCSv+Xw7VoFQiDB7bw0SbwxT2grwO+EyvHCwGURx0+7IXcBCddxgvb3NZ7tn2ZozxiZ9BFaylikaedqJgzft3MkQwAA+GDHPUxbN/Un7yb/tXIpJOo4NvLSEji4MoLnx5zdK7ahcMKVkYTcetTmFErctpVbVYs1kAexKK2kD9/r8fZobCnz3DfaIhbRJh7iU4a/nbvmbbETnJVkCD1gMNJ6dP/2Q0sPwD0Ti1pQjiycs4kgj8Ng/gjSTD+qddgO77v+/Km1/eAETA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpD3bEfg+gDFZ3eM+fAhpETWevC1iCBWrGrJJSjfmo4=;
 b=kgSzP9xtbHJEWu8gtZ7xJJ0d71OuzoN54IYA9uMmxtw0TsXXKI9HghYnTem6ztK10l5usVLXxGzhrwDdGcGxLkiHVylBwXgqu/tWNlOGtxhvCWZfIRM6C/LUOe37jobriiMZG0m3T5HUOSuOvc8wkF68Oc8DeZEPE/nfLyQ/RKdKqL/633yeOhJi9F3OpDYXf0XOWm6L4SWyLMdyL3wkF70ohiV8+5lCUX0GRR6gQ1593aBFQ1wGBa9/33QJW/ct44VxuAf3TbBvWtB2UAoVnQUOI+Y0R3Uxc3679WQZE+vkr1fFGULuG5OG1OLDJ1IRDOA5/HVEGpy7CMx8JZDzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpD3bEfg+gDFZ3eM+fAhpETWevC1iCBWrGrJJSjfmo4=;
 b=slBDxJhMIr5pZl8RCkuOWyZAqHNHG73brJrerMe1gpb17nqs6SFmk61pR2oAkYt0EiThR132wnq+jutfAhcXJ6b4AXgl67QbhsufwC68Pxn+MLzWjUwKUZcaXvdn8mJ9b3UPuAIBQOCw1dExuCKCY0/5MJ/3gXx1ypgvXacC4Def/MlbVjcTZnld8hwxOpxOUjupwYvGEsgSdheZ9IztyIMX7FnomA7dBjUhSTywPOjmkKaqgJA1UniWxKeTcIv0XoMLXGE33SXGDzNm+dwPC1FaFUixS2biZT8hWMhuWylhmh/2W37slgFIMHrrUWeLBa7EsenxCQPNHTEMfY5bIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9085.eurprd04.prod.outlook.com (2603:10a6:150:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 01:55:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 01:55:48 +0000
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
Subject: [PATCH bpf-next v10 1/5] bpf: Add update_socket_protocol hook
Date:   Fri,  4 Aug 2023 09:55:43 +0800
Message-Id: <079989b68ddded562b9f2149cc50642072575001.1691113640.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691113640.git.geliang.tang@suse.com>
References: <cover.1691113640.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbe9310-6a70-4dc6-9df5-08db948dec5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jOJL2OylNL4GvH0SjR065NAyAltY17EBfwUjY+SEjY7gOILmGv4gQSvUrUtquCBQbn6eLae2NTceXC+ZdjbFZ7xiiDUSXybKOIxGp7Wvdtli0P4G9rA4clWfR3kuzzUevfgJYycEhY9jbdr8Kt1vgt67t82J3XJYFYUVJlfBy0Nv20Z99pc++PNMMI8Puy9DkkrmT9Os5DA7bdzFaK3F03665QtqkVQ95sDzbwBrxaoB+XQHVZ8bd0iZWtPNsmeo0BogDs19j+IVYZE5W70BiwYA+6tbytVACSFqlRfz9G9hV54VgQq3IhsPnBYM1OgjYBhwa9OyfcmNBXjnhFS1jW21xHXA+zjJT1HL4WXsFI35MbOAzUnqzP7X0UTAVFobi6e/v/2CbVQ+oMQmOfh5euZNJv5gw7iIbHxXLdkf5ZspmN8lMrtZerTUc+0YaJjBEUG1cKCxmYo5ZyDwHuLbGjeeuUilXB5eMavsF4736JFLNLmXRfQONxL3E/pV1aZTRV5UNUfA+Q7pqhNTmEr6hxrqXLWR//1BDhdrvMQg4F9J5DVJiZdUgDC5m09/GtpjxaVWNRRB/8NWAI5x+Cz2KgNKvTrLEUrM/VOg1Jn4UfO9L0kFpx5baGcigGcVb8v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(346002)(39860400002)(186006)(451199021)(1800799003)(6506007)(38100700002)(921005)(26005)(478600001)(8676002)(15650500001)(8936002)(5660300002)(7416002)(110136005)(44832011)(7406005)(41300700001)(66556008)(4326008)(66946007)(66476007)(6512007)(6666004)(86362001)(966005)(316002)(6486002)(2616005)(36756003)(2906002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XSo/jXZlcDmeuLuZb72mYKO3wo4RCPWd7h4CWFrWIKWlbDVAC+sKKrlNKNLe?=
 =?us-ascii?Q?f0iErvO/mDnESId1MhxipvtKhH3UtZ6AzFGONmUhpQoivJHiRZYjJdaHUx0y?=
 =?us-ascii?Q?DlkoDROF7pUTfRgghwXDmbMz0UXQNbjEMRMoFBsrnzz8/SldcV5jVfd6MtXO?=
 =?us-ascii?Q?otUL2H3Ch7A67XKTKKwrNWbCqLMnJVTvjBkKAjSV3LMQkzUXST+48rkeePck?=
 =?us-ascii?Q?i15/RClBSAuHaSidb2w92nSTRPgRzspRAEul3Tm/0wyoOx7wGJP2QYpH3f1y?=
 =?us-ascii?Q?oSNU1+FD8V3mmO3YgPrPT/4qvK1XNRV6BnaCCBl/96LMvzkZ+CecVsGbi+K+?=
 =?us-ascii?Q?AWfEd+5JNXj6gG3GgXlswH4OHVosCiQ2Wb9DLQYEepqrwnvwML3bOs0ZUAXK?=
 =?us-ascii?Q?Hun1y/2vkm65cqxIKwKR279+Wovj0RBtxOjuin0LHX4nLJ9D4DdkhxcUkC2J?=
 =?us-ascii?Q?EK9djdbNb6clRlztrsga7TZKpEgeh94cj3Tj3g8PiSjxBvlFT/8Qnf5u148j?=
 =?us-ascii?Q?xk/GC0ZuEqBgCvPs6iPoAXKwlL2EjML7eeZkpobKDY10monIfJMRe+l0hGmH?=
 =?us-ascii?Q?LpmTclUc/2R8KOh7DaNhjhGj09Le5YGCcgB5de2PshEI1OlJbUWTUcsx8fsL?=
 =?us-ascii?Q?MOTr7P3iY4tF6qKOZdNRRXBgwz404qIpefns0MXQB6Yo6JskCxD2iXUoDyse?=
 =?us-ascii?Q?6Wb3f0jaBTWnGEBBTKaIq0QIOjZEcJ6I6POGrS3zgsn/1qHbLllQjkhL8kxN?=
 =?us-ascii?Q?C7cuAFRHPFzaUzO0Eg/JzoOFhqs57O8TueUSiK5OEImQ0+vYhvbxzoVYsnYd?=
 =?us-ascii?Q?n005yU9pJ0Ab9Q1odwYx/V+lR1KX1rmp8Bg+XZcMtbS3mz64J5UESpF6+ENz?=
 =?us-ascii?Q?Ag84hw38QodNmuvK/Xtlb3GzPnwWq1O+lyUh+jw1Kk5Lh+vJkKKUn8Xm5oJt?=
 =?us-ascii?Q?vFn9CwC4SszRVBZX0tgyuz6+9iDv5wBz4mIKcQsZv+ADz8KpmrSnEj1nVraa?=
 =?us-ascii?Q?n6/bzJvZ2papZA96DAmS5KIwxKquSJk/naJoVJ3N53+rSDrjGTZ1/NTeDiaC?=
 =?us-ascii?Q?49CdPVA61TLE0H1ItorrleHCLkku55oP6u/APrMU8hWIfFhi/ClcEX8TdV2r?=
 =?us-ascii?Q?t9w01hCGTL7a2AxCSNoVl72gKDDesi3mG9frbjDPqClchJZHTPP5P9zWJsID?=
 =?us-ascii?Q?DCpntmlhqRaja6PfI38Qv6FfIeRO5PqZ3H1ninzMeTGPe9KsRK8aohYgfxPL?=
 =?us-ascii?Q?qm93/QwkUGYvyEwu71PBPQiJN2h5kRdru2QtPNH/RubsRRX368fUnUBke5VS?=
 =?us-ascii?Q?hasiIyJbOKJZJuGdgG0jW2x1fbuHgyjjYf0sdD8HFLYfF5edoAMPX+GDFaGs?=
 =?us-ascii?Q?dykt+THBufRfI8djDnc4MFOI8+3e5IsvtpDnVdEKV+d42KtbvcsVgVSY8lv8?=
 =?us-ascii?Q?kdlxcJIpuIEAhuK5IW8MuZWYwx8C6I5eQJGmYrjqtL2/MuvL8qcY+wWDi4xX?=
 =?us-ascii?Q?jMWYPc+Kgcshovc7saBsvkaK5uBdAeI9soPF3+cd8YxzheJ5rWx0QfJWbKpt?=
 =?us-ascii?Q?M7Y2ko0QX9Lz65lPtR+NPut1yti9g8X00+ne8oBI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbe9310-6a70-4dc6-9df5-08db948dec5c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 01:55:48.2990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkiXxHv1QT5LB3rr5uJYkEQdwpmnrJgotfsfD8v78MuVChIWPeJx0igckq++oBYSCgSkZ3jm8+FBuP6x1/cQGQ==
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

