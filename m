Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE97767DD6
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 11:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjG2J5r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 05:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjG2J5q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 05:57:46 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9322B2D7D;
        Sat, 29 Jul 2023 02:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1NURnK9h1ZPgaf/r4aZgSJFlHxn+wO6k2l16xmCy1Fbferqua24EYYUFYIGKEXLXC1t1S3Oy63kJMpzApXpjY0AqvWQf4vh3P7gYkrL+ALGGEByGAypMAeuEHqD65GXnxFx1yxB3sIBE39tIRtg2lyCLFoUxDhCjW4BoC0j4LjPWsmB+K5s0wB/MbuG1DK0x0WFvIpLD0T3jnwkwVcm78vtJTsFRYbcYpp3Cuq+tZGTZRpjRbvtgaQ8ewaGU0kbGD1Sb6stoQDbpEBtL4zrxVM+nXJw91WDUZQeVGJrEAOGD5KU5gZfkmCkjEqsGIMfL3dZwPUEXcajHFubMOOw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcaLXZJTVoyHFSatVfwmLIU99JHoAenSWZ911ljaTUQ=;
 b=dXYXMfN1zq4H0SZTUtQZtiWiXXXn243d8pyOnxAeXmv75v4GJGYvDZNQhK3sBi42YFIDg7q8scZw1NAEig6o3sFTjFvn6xs22+QTmT9+ZN2jRGw7muo7wS2il/vOTZziRHGqGSz/3SXka5Xze+1oAvAwyOTwUoh8mQbIoZSDir4kIyrEdWJ4+sdDz9s3b6G8WVLysasd4XZ0RzurSd2z5QCTTRImFaedTD3MbnLGAs0gQM8BvvKxIZjrZtYHhWxTYggvaE82+Et4jT2gOuBhg79vK/nJn6DtG1Pg/oey5tSq16M7ZaJu07XztwrKvPS7INPxJD74JkLuIcLIZwdGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcaLXZJTVoyHFSatVfwmLIU99JHoAenSWZ911ljaTUQ=;
 b=E45pRatNZLUHrDx+Sw0n8nNA0FcN7KdC0kWYyZcy15BCFtfXBm1iLWhYV2J9ZaNX17oeuR3NdIawtuOsxla5QpowSABCFffVleg5QkhoRF3Brc0vupeT/6uWXMMfdFL/QaiRO9u1FZSBtabgMoE1H698h9w+g03h/qQ+on/mHVOGKE4c7ZcBn2HExDNgpG52DMXPXe1IDMRQygjr1P+EcFVyEZBObmGPBDZnd+YcrSZHl4E7xehiRZI+KjH5QZ3uOmTpzZvrqBI/8rGmmeaS1IBEHHm+WSbY+Ai687+hzzUXFMhk7gV7Syp0D/RLBxd0X3qREXCrA2EU22fZA+z8Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9733.eurprd04.prod.outlook.com (2603:10a6:150:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 09:57:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 09:57:43 +0000
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
Subject: [RFC bpf-next v7 3/6] selftests/bpf: Add mptcpify program
Date:   Sat, 29 Jul 2023 17:57:24 +0800
Message-Id: <e3dc495377415400bab7f36ce035d3951380759a.1690624340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690624340.git.geliang.tang@suse.com>
References: <cover.1690624340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0103.apcprd02.prod.outlook.com
 (2603:1096:4:92::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f02adb-beb1-4980-7273-08db901a406f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /dQlla5zUjNowrSBJ6tuAbxeU5wlGMY7FLMoqktCc61n1GzUJD8eY/HNrUPYPkFK19o/mn2uu16V5g2tCzgWcPoHYPf+YeeMjgtENBwlgSvNa2D9enPZpYW1L8gMh4mZ/L+9KapHmF7IvM07lOYV+9RjXUV5Gl+b1nduiNzCp1U4pHLlDfUNL/7E/j0do6r8k3jPvfSKgts3+Ywlm6YjmvLtx+QSiavQosGP0Djc/0FfeQ7dXs/C6AZSI6kIGVvwE9FThzHNd2A96KmQh3PojoNOKBofUu9PURGFTEbXfEgBtt8utK3VHfcxX3SeBiRzAGJhQEV5VWD1itwGIYeCj/f6Izdkrj8vUz6BvFl/kFc0NWP/Aj6NjAbOfZA662Rywa1C+e7yB2+3tGlN1H70eoOgpFf+qgjoKaoVxpYN160tDfnVhVwQMGCGAWZ4/4S6pJH7rJ0os8LFyOExugaSyWTeeZrPSmLiKxtJirHeH4nsOikgs9pfRgP36/UPUSnVssvqpTUERJjA7fene1xDBzGtcurt3xUSH1r4gMdpEsgaIZJzawDkdx3Od+iGCjhfwFqJ55EIlS64apH82J95CjKrhxN6q5Plq3VB6SrZIgg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(316002)(8676002)(110136005)(478600001)(38100700002)(66556008)(921005)(86362001)(5660300002)(4326008)(66946007)(66476007)(6486002)(6512007)(6666004)(186003)(6506007)(26005)(7416002)(7406005)(8936002)(2906002)(41300700001)(44832011)(2616005)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fj2w0W15bj1J2J7Rs9nV0cp0PRADn11HQ3iLReMyUJ8rVwztaRGhhkrJtKQf?=
 =?us-ascii?Q?udYmiSesV/nByF/iCj1FNYTw9p1qFZrKMwmEUvDxhrISGcHg6BIaEkdcXCyQ?=
 =?us-ascii?Q?n+VNyoTynkYcSgLCiNwaDVejNayH4XGPxzeqm9Hljk8xInyB05vXpB0kRaao?=
 =?us-ascii?Q?m/UAywrYZWPosO26XQBACBi5+okzxW4b+fFlgaJfQg62XkQWoQ6aElmCAYhE?=
 =?us-ascii?Q?vsyWNPCaQ6jgNcjC6KdqqpiT9AcfQzotW8zCNl4RuBFO2n/x8e9ZofhsAT3/?=
 =?us-ascii?Q?jtMDbkCKNNDPQMlmQEY0jkZTI18sWke2UnvnTtMzzyUJ+qZTRu3lF5JPOoCy?=
 =?us-ascii?Q?hEKw4hFbnWAxFUXskWSiFemnf4IqXcTySSm/rjlxbe2zKLp8N3kmJg13AxQP?=
 =?us-ascii?Q?nvHnfUvCUktpH+xwRFzhWjTOiF59vo2Gx30jKvKs798Qg3tU5L4Cblitk8Uq?=
 =?us-ascii?Q?ZOqCKbE1ywmOcGs2FIbBU9LIISTuey4a7EPYBRt4cUpOV3I+OcC3XW9wmQz4?=
 =?us-ascii?Q?Fmctsh/q4iiUC4uZiJUQVdrt8vZaC5RorRVsGQdqJYx1G2Wq4qLAzJo/PomX?=
 =?us-ascii?Q?HalUVVDgv9cUqGZLETgW8/6sYA48/PCFKbmM80+HqC9wCnB6eHyATUqf2cpi?=
 =?us-ascii?Q?KfcyeJ49AF2eHV8xLjtdTHhJewlmYN5c4OkV4fgLiYJspyav+EuYycQvM12x?=
 =?us-ascii?Q?2sIwGawVDXZyXmSxwXInHPshymC6rJP+7VDltGt04eSgo5Ql4W++nXa3i1xm?=
 =?us-ascii?Q?YyP6BkPryS9fdlmQytR1Scr55BfyGYhWsuPJbAuQjcJF1pJKMfmqORs3ErC6?=
 =?us-ascii?Q?uCj7xh0XG7/f6BI1UI20CYlD9cUD+Tq2HcjQ+tGVFZzkW8AAfCo9S+T2A7uc?=
 =?us-ascii?Q?rYHxQA+G8ytyy/HpOLW2iE1vFjrdhfp92xSPXM8ILXrDooPqBZ4rpQlRAp7m?=
 =?us-ascii?Q?jhzHDqxNgb1QiUgwu/HTSEPfjglnolzva7mkRqTMDboNLqKkAYaw+fku+i0D?=
 =?us-ascii?Q?Ezmz4p+SOR9a9nunyGMv+mdrRSKFjpIv+MljtjuSfajrhzHOEdhZ5zgfdQA1?=
 =?us-ascii?Q?yLjfcdrjPUOTKkk8kQVhVCtC1gDIckrUN6untf7iacVf0YzPWfh8y0tTbhbS?=
 =?us-ascii?Q?RMhEwnhdnqb9RY4bhBcd22Qs2aRl8GZ0pfBx9J09tZq0W59mR2xbzMHFeeWa?=
 =?us-ascii?Q?Qi7W3+gq2RFhb/ORns4iJMtAQ+N0fUIyRKtDo8mu1LmKRVQJnu68Rz//q5hR?=
 =?us-ascii?Q?mBh6T2aV4+tnD2D2DQaiYLb8DtLrS1JUZBXtU770869TlnajzleaHqAy5xCo?=
 =?us-ascii?Q?gdBFvnLynO91BbwLD9EvpkHQa70y+IZ1iDFY9zv3LNtuWWPFdBouk1OaW1Q9?=
 =?us-ascii?Q?VJSJoyjvgP0cXV0PZIRw+dAfYErLSvEcS2wmSJV77nUqLmhrawFpDwzVC2TV?=
 =?us-ascii?Q?nUI4jOo+rz4VdLyZChS4UE1LQD17pD5ri2NrnAijCXD++F5KYo9c4minCwes?=
 =?us-ascii?Q?KlzH5ypTQ46zoCeAduKLp2upuEkmfchs/YOmBwTD8++NHacdBQqt7nvPM+9V?=
 =?us-ascii?Q?ivNAQyhU85u99VvHwIHKwFG3wgAzxOgb+FSKgsi2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f02adb-beb1-4980-7273-08db901a406f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 09:57:43.0864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioz81jGVZzM2YbIquirHnRj3/yburwcLc+KJh8mHxTZLI35SNC1fGd7Cl6AI1NjNxm5is1RreorLSHlyeDE82g==
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

This patch implements a new test program mptcpify: if the family is
AF_INET or AF_INET6, the type is SOCK_STREAM, and the protocol ID is
0 or IPPROTO_TCP, set it to IPPROTO_MPTCP.

It will be hooked in update_socket_protocol().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcpify.c | 25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing/selftests/bpf/progs/mptcpify.c
new file mode 100644
index 000000000000..9cf1febe982d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcpify.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_tracing.h>
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

