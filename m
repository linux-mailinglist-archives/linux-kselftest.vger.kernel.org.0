Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A71876F965
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 07:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjHDFKQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 01:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjHDFIA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 01:08:00 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2052.outbound.protection.outlook.com [40.107.6.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0694C2F;
        Thu,  3 Aug 2023 22:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNIv6B3omhPeRHbBT2Pc663BfZ8lWi0p10L9vfW99e1/kM3q9hr6B7WnZ5OQnfwYMwwGbrkKvgcvwkfTmpSPd3X2UTbpVdE7AAMXtaZf5P2tsDu6YxdIP8C2tW8fasnim8EkH0umIUKzZUV2ANcUs5VvvWbhd1LGnIwtgRrNKYDeT2Ra6AKHRDF5KFQOIwzyaF7aYoK8ufR3PHCVSXLUkPFYiygIUGOd7xjySquIHgy5j/lwDTsT9+exvZjcB6zTMXfylCjCBmJA5wceqBUtQf8u6nsHYRppK82Bh9mdEs2bqsrr2Pbs+Q0Uwa7zqusw91fXTc3UtRC3HKSHoyPCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wP7m4Z1KueX23fCfLn/JL9twyhPWY0e3IuS/1OJvSU0=;
 b=VUQxbjy13YJf6x6IbqHz649xsi8LqCccRcjpNEsRK85vlN8tbyJqilHA0EHlzHNePFkMRF/b6QvcejXz0APAt/YDz3Lg1GiEbMCvp9rVS6BBEMU+iA1/832iQGFDKh+LXqvNbhq59thF2jE3qyS7eTZFXfEGZVD0UQTn+lCbdz2KF7KL59oWw6p7Adnc2Efq1D26bXfcuTCjpSQhwO+yR7NW4jJExxnQ1fgAUc+sUrODHON3O0yPsx/U6etezd/J2JmXWgaOfCaRJgkGzmLKiQiiSw0fb3Zllx0RP/0rQzFoJjIb9qkw9vSGsLVnbg2QzFXRhga5ldnp7oSLBY9t1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP7m4Z1KueX23fCfLn/JL9twyhPWY0e3IuS/1OJvSU0=;
 b=I1njfW8mC4nXltxTYkkeoM846CjWp8SpK/4ygJit4B+q1jVqB8vBoIAQjmK4Ly6XbPbm2b77UgJcIymmSglykGyjCXG6nv7YJ0OJkURhDX8xOo7xTEfTjA7iZ+TKysdWE3i8nJbJzudEpdiNFtUgVoUgZBTyY+G2ujcc8Mp9kpfTCf8yQqZRpzbML9cQr4nYnn/QHhYbWR2Dbu5eXymcFNMjn1D4+KLOHc7rxkFqMphXjSDQWLb0oU7L2WgVySW7pmN6H0WkBUpNZ3K7+nmjigT+sEXK6HXMb7nc1+d3mAs21Hmc81lRdiF5q2IG7zCN5ZUez4Jy9YuZvF7uY45tfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10061.eurprd04.prod.outlook.com (2603:10a6:10:4df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 05:07:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 05:07:29 +0000
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
Subject: [PATCH bpf-next v11 0/5] bpf: Force to MPTCP
Date:   Fri,  4 Aug 2023 13:07:38 +0800
Message-Id: <cover.1691125344.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10061:EE_
X-MS-Office365-Filtering-Correlation-Id: e213b7e0-744f-428b-7446-08db94a8b395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rV1EZ7LQhKBepJRvl0wWwMF+zbxdkMtqqZ3GFMW8WTBoPXCAsQymyrNyf26L4J1GxA6yEkhDuHDxnTj81MW2Wl/5SOVIIhsfZrsvRfsZ/ncBkScStHnw5t6sl0M2PfZIjVay/yT5KADKJpbDFSwyrwy1tmvDlyXuqLBRCOjkNODoIIFllypFlo/FZN6zistAFOEvsjyVUSyYrgjrSgTRGm22KbrgSZlN0efYHXEvpBVVmhIHDlSf7FCDzqINhG3RNLDJSVgrC+zWyfj6tXA4zJxXn6wGGGI/WHEsekMhqxYTrs4kbhZiZnaxInVC161Uz/8pRf9WIA6NSR4yx4FF3mwipBOinzf96qf1tFmTExtbWhj5W2L6/17Hb3fGdiVqNSjqEdxJ/t9E9t/2kjXvAmR+5Oh14nZ+dJ1X3qiwOPDWQyvQ5FTRERsnQwlDw2trC5/fNiSnODhlegncAl9MQolifocH7PpGt67a0o6wB2RkEo0+S6cLpDTPN2FhNX2W40B2/PNmwVxAgl4YGBekzf5Uy825PzgKgUOJ3vhrC9ju+sdog25ev9ahMa7+x1sWc8i9pxdFRSI/VQZu/oAdy3BEuZAh134K65N09OLROE9KNB/xMH+GcxwfEn3Hy69+viTgo3HOA9HDN3LTUH5W4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(346002)(376002)(1800799003)(186006)(451199021)(86362001)(36756003)(478600001)(110136005)(38100700002)(921005)(2616005)(83380400001)(6506007)(26005)(6666004)(6486002)(41300700001)(8936002)(8676002)(966005)(6512007)(4326008)(66476007)(7406005)(66556008)(44832011)(316002)(7416002)(5660300002)(66946007)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SM8/RXGHm0v1oZzPzAra5absZODyMBQzQU0ehlfAM6GGuIsOF4R06wAgzGhb?=
 =?us-ascii?Q?7Q/QBrBIxO5+sPcv6u7y5+rwsV33h5qF33NwWCdF/dFhfI+aH/hyPuFjifSQ?=
 =?us-ascii?Q?7IDJzVMNXgr28PWDc7mFofHCJFcUi39b9go76xxf84IKgRDeHfIS3R8jVmMH?=
 =?us-ascii?Q?EftswzgoE/GNHVQ3xY4Yq0btTqYl1DsXRyXAFhKjlBADILToca+0ViYzVf2C?=
 =?us-ascii?Q?53F3i7sMxh5+TgRnF1LYy+iOdHnzk0sVEwHS4vQAnIyg13B+tBzJLu5uwXzM?=
 =?us-ascii?Q?eLQx7RMXITuG1UYNPJjeO+Am3U2FoLH2pQqLZ5wZUM+JU+aW7uPnc/kXnbI/?=
 =?us-ascii?Q?PX7OlDIiP7prrRQw5FtimC8HjvvZXkvgIIQzi5m3zUa+2M8LO+qcT1WvPfLS?=
 =?us-ascii?Q?W73VPCeA3x4gxnF7CrYA+icuwnQobSd9Tp2sjZRux+0cJv0SIDkpS2UptO/z?=
 =?us-ascii?Q?t6GlA4OwNIagL61OBEJ/PqQAn7JzjSGKMJYD8kC76Awlvc1F4wWy8+Xlozbh?=
 =?us-ascii?Q?yqvwIFnIxkQku7rBdYAUcg7R/oGhPEATRBpYunbhRJD0NUr3y8ZKt+M7U4VF?=
 =?us-ascii?Q?m7ogh9S+uxzOTNs2WQ3iBapuR/8975DYLhXKJSuuPEbFGj4Lp7L3lLiASe3z?=
 =?us-ascii?Q?kj/efM1k0N+1aqovMRuj8UAjQ7IGX3T3aTw41DalReECdLFKc0itwbL9ENJb?=
 =?us-ascii?Q?iwWUsfJztVLSnk77wjoxyjz5WSVeXu4mBE1z6gFLFswBS+oidIlpY4GqkeMh?=
 =?us-ascii?Q?cEBAa2Sg6qO2BhaK68pCvHo+aS3tRMeuPWM1SfuM7x2M//cWnXjiyXy2lfU6?=
 =?us-ascii?Q?YxdOVHipWJ1XCKNH4k7GZk69P9KQicyxl7K7TNbuvIq/bBqRCWeLU5pzOpMR?=
 =?us-ascii?Q?BlKHOkj71mFxv32yEK4HmyEzMrS9I6j1lkSwPcwjtTAATpGHhB7MaK78E8vo?=
 =?us-ascii?Q?WeV/LLliUBeCXYejir1t+M2v1VVeNr+1OoXPRheI8YEQvFNMPt8OlfjQQRYi?=
 =?us-ascii?Q?b2DnaEB9q6kNxYSMyIzT0g2sTDd7RmXfuVNiKzaV9tJ8iiTZCngqrh3tos7X?=
 =?us-ascii?Q?gnsD/Rgp1BD0rrIplf6EhAXFhHiG87O1hPqvZp2CkCRjMpXVUAEAqx8b8X1K?=
 =?us-ascii?Q?qMYtaSMuEzHEDLLW7RJVRJN82REYoNl43hW3KMNyeAOYjfeXTBA8APJpFdZP?=
 =?us-ascii?Q?bgKVEnqv+bBRWvFJfyAzLxsEMFzHgkcXIBDf3aLptG8sa03F6JAkx9j+aUgh?=
 =?us-ascii?Q?UZaXZxPU0gUyDhWgXW0bW7Yp9k9N0Glfn0O2iC1EhJjixKTXl6UiTtnN4FrZ?=
 =?us-ascii?Q?8yCFPDwoYONxK/u9S3bosUQ/MbcqJXOf/yyWcfQxfPgPtUj4tOOl2VSEp6Gr?=
 =?us-ascii?Q?vDfiBNrNoUQySSnP3mJ0XaTcQlZ+pIrB4JbSJ0/AF9tcRoE8QBC1ei7cQgwn?=
 =?us-ascii?Q?Y51mxgw/mFcTtRVa9qfhoFlNHsvZ7qKW4Q6SGnnZHniJypkZJm4IP59nSv2V?=
 =?us-ascii?Q?vqx1mq26mpcFCpWtoqOtt66Q34AJtdpn1uLgKKlH3KCrBizCqo7JRApMFMOL?=
 =?us-ascii?Q?W0Qv1/ITYsVHpvW/Yfq3OUPRoiTVBcnEr03D6jpv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e213b7e0-744f-428b-7446-08db94a8b395
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 05:07:29.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzqD1PjdYVsfypuoIgN+5h1INFvP4cdjnz4OF7qP9CSWGuTJ7U09Rjk1d0sC9VuZaXd8AEVoa8X/dpZQXdoIHg==
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

As is described in the "How to use MPTCP?" section in MPTCP wiki [1]:

"Your app should create sockets with IPPROTO_MPTCP as the proto:
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

The main idea is to add a hook in sys_socket() to change the protocol id
from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.

[1]
https://github.com/multipath-tcp/mptcp_net-next/wiki
[2]
https://github.com/multipath-tcp/mptcp_net-next/issues/79

v11:
 - add comments about outputs of 'ss' and 'nstat'.
 - use "err = verify_mptcpify()" instead of using =+.

v10:
 - drop "#ifdef CONFIG_BPF_JIT".
 - include vmlinux.h and bpf_tracing_net.h to avoid defining some
macros.
 - drop unneeded checks for mptcp.

v9:
 - update comment for 'update_socket_protocol'.

v8:
 - drop the additional checks on the 'protocol' value after the
'update_socket_protocol()' call.

v7:
 - add __weak and __diag_* for update_socket_protocol.

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

Geliang Tang (5):
  bpf: Add update_socket_protocol hook
  selftests/bpf: Use random netns name for mptcp
  selftests/bpf: Add two mptcp netns helpers
  selftests/bpf: Drop unneeded checks for mptcp
  selftests/bpf: Add mptcpify test

 net/mptcp/bpf.c                               |  15 ++
 net/socket.c                                  |  24 +++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 139 +++++++++++++++---
 tools/testing/selftests/bpf/progs/mptcpify.c  |  20 +++
 4 files changed, 179 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

-- 
2.35.3

