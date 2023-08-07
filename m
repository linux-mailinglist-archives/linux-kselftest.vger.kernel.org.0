Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226FB771A25
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 08:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjHGGWk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 02:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHGGWj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 02:22:39 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C678F9;
        Sun,  6 Aug 2023 23:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5H/YdsRE5pu71BEPBEIXXzty3Hf5Bz/DzpwAkh7SL4vG5fySJ1/v+65trU8u9Sz3Z2Uz+ejVb6trBOcZPEHrFJW1HEhEvhCavaGXcF83pD5nSNfbSczi0k8HQP2GKbU/ptEFPb/KKj28zD+gZutykPRUaF4Ur11b2Ceu4ytc9iIW9OALz6tmamKQoqK4oxXLP73VXhMbVdaRajnjHcAC4w6V45xEtIBVM8r2zKrcb8HuuQ4vK6xQcJIPYgYk34ed+XQDteULQ/TiLn2O/r6TsvD2NMM6h8P7SIXoAZLlNtb6CjvtCfvZ9mTmr/8zaG/LUOim4ZW3Wt1ViF/trRCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2au8DBz7j7eg9cKzottwBjwIBzQuljtd9/Ps5tIeBY=;
 b=Fr20qUqGC3hwOSjMJE7CEwFlbmfO8x9BxstD7WFXG6dVb7nHBB++sPfjf7J6/2mp9eiqe3ZDPJY9UdZuu5xMz44PBUNM0BbEhsfpd6KxoU0byYfi1hLaDARCNqrHLpHAnE3TcZ3kc73SwUzQT+C3G57xIpsN1DnurcPdWbrjLmeKi5j5rCIXOlWU3F8L1n7GZZ0H03XvAuoN95kL/Os2KnE0rn1qfK2bPCc4e9v511qboiXSehbsRC0Uja1/DlbJTUAc5Sl+jLu942r70UWcp2jxreThyWadBPkSbsQXKPy8RA1z/qFkIqbfr7muEgoxee0L/R6wR66+Mn7eDCmdlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2au8DBz7j7eg9cKzottwBjwIBzQuljtd9/Ps5tIeBY=;
 b=d/RR2AImC0DxDQ75N41yywJmM1sS9bQqwc15ZmuJHnKUqnPkz2US7pCbzHQddr1KAN9r/ai2vOuM3lcJp5OHDDGe/aXpRAjhA9vXZItLJj/mmOnHKwFdHcH27Q59ADzZIZwznLFcX1XfZmxlgRDTAGYl+5A8rUC68kMMoBgrBeTq5av4y4+37QtrLbf2QCWzJmZ6vacxG05EsVYF2Dc6XRRWjxFoDAOkyEbUFkQe4b+6/uJsrUQIRmY4Fbz9ybMORZekCmJNf71COpdIMi81kQJzP+jVIkl+P9w2z3lxDlqIF9I8zRWL6IbkvvMqZTeedvSjc1oGztTPURLEiFjHGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10039.eurprd04.prod.outlook.com (2603:10a6:10:4d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 06:22:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 06:22:31 +0000
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
Subject: [PATCH mptcp-next v12 0/5] bpf: Force to MPTCP
Date:   Mon,  7 Aug 2023 14:22:40 +0800
Message-Id: <cover.1691388735.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10039:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6a0b5f-b190-418f-8a36-08db970eadb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74JmYAb0RH/lCH2jska7VmPi4G4L9TZdgX6EgcAbpTksx4siE5jXuXL41giRYfWq89tEAgS21T+eAmtPyQlt8pyBcL1dLGuLVc1Zj+wdnLahhZDuuAJqeQgo1TyODF9dcdQ2C3gOR2F+gzmKTBuNwYYxT5IlHKB6N5fxxq8i1gotCHiJY8jZor4X+j5A2UNWy2bc7/dqGXm5dnfK4YSm1Ev6cxhVBxjt0qsfi5+bEfDl17vJQ51GJBqHctFTZgiu28bADnnilfloY3WSPcbxDs49P/149dPsFrfnBI/OKVIV5H+gOVbKdCnUmS6YXGpWo3zAiBT8cBSExs7jsJF4D00owMTmmJDm6rTZ70h0lEHF/6x/MSzvMsCT8IWLTclKrPSFcNXI3WOAhWsIOuVk3zGNgn7R8FLPVh8ZKrqwT5ynUhG0V45G52gSMy7e758qAQMDNSqUtjasTEPgLVXoC/GawiKQGLiDAlI6X0BS5QbLIYClLPw36YL2SQPNVk1P7wus6SZIaG/VuZMrFONVhT+N8d9OnM+/GEHUf/ziKwPFXYu5yNwpTrojO8Z9PrAhtZrzRTjqBkT1uILDbgCVaCZErm1MzGJ6xsUmH4as3UDCB5ddp1wIsz1fBbPKdoNW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39860400002)(1800799003)(186006)(451199021)(41300700001)(26005)(2906002)(5660300002)(44832011)(83380400001)(7406005)(7416002)(8676002)(8936002)(2616005)(86362001)(921005)(316002)(6506007)(110136005)(38100700002)(6486002)(66556008)(66476007)(66946007)(6666004)(478600001)(6512007)(966005)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nBWLv7SqXitg9exKvl2ZJj2cA8hhD7P7aiuY9CAd/ZEflIPXSgZmPnA1x3h7?=
 =?us-ascii?Q?aENNRq8OfnvCo3B7jrRRAWalwY02PtWcNCyTowUmPgSmMy7M/E8Ph9bswuoy?=
 =?us-ascii?Q?7UOz5FnTrlksFduRAdKk9caj14Z5ltUej8UBHKfZc4J/EMygzAPmbq//0Ttg?=
 =?us-ascii?Q?BjqiCRPYvfZy0lwGJsLoiNLzi6NFI+UwAyO0QIgB0uWUbO/xahfgBJ2k+6eL?=
 =?us-ascii?Q?IKKKs+li+NfSaUMwl7+FluBFh+YCwLcslpNkiHXCRoN5AdfU52alFrmM3jc6?=
 =?us-ascii?Q?WNP2fAhgCChoMqJcaqVCqG+zc2VNV1Bupwa2IEgc/yzzIMui2j2WJSiujclI?=
 =?us-ascii?Q?pVDisGivFc30/Z2FbLSa+mErK1pcq0Pk1KM3zTMth5EdJSLp+0HayhyVoX7P?=
 =?us-ascii?Q?i+S4FEd0jOvWKWJvx4+X8H/XQkSo/WIs8dt+4KtAeHspHvFbLhXjITQGp3bE?=
 =?us-ascii?Q?FQaF5R6BDzlKTSsYZ8MPD5REAdd4GCq6N6WQKucAQk4bqMeGxofBIavwf0c9?=
 =?us-ascii?Q?v1DXSCBQAaeLJP1b/rcH3ZGENw1jVRMJli1C8syhUPffVxAmO5aBWVzA/+9x?=
 =?us-ascii?Q?9VRiZ4YQyp0J8a+gcliEigXWHSh+JLBNMZe6Uvwl44j+KnIjQJS1ezhTay3K?=
 =?us-ascii?Q?vhUq+mQVPBHP1Xdg7BPDvfgfl1K92yZWiG2TVeURZv/0ASfkBtz4iBl+DIX1?=
 =?us-ascii?Q?f0jRPR77pU75T6+ontw2BhSEX4MaEM3Q0o5qevQLxFbysWlC2xu97nM8hQxi?=
 =?us-ascii?Q?j/KmmkWrl7STWOgSk5BuCTsYJBPmeOQgUu+ia4A1+0ro1sSggexZfRUe3fD8?=
 =?us-ascii?Q?+MxW6qEt2ZnhLjpxOxi85fuCVWv3RDgybZvFntjn0fAYz6/1RYJo5z3/vy+3?=
 =?us-ascii?Q?OWAkoLW+KUuPit0oXQ/IVbDz5BlCu182i224YW2+f728d1QdlKKEmB2crse9?=
 =?us-ascii?Q?NMHgDsVYfeOTesBIeK/0MSn5UtZU4wkPeDv9wiV5ETZ171nQveWF/YQ7ZjBP?=
 =?us-ascii?Q?ygA4YiPUBdJ3LRYodwrwigtsTqMSov0rPHTnzHhBpI1PfrjbzHkGoxbjPr0k?=
 =?us-ascii?Q?4V7gSBCurh/9WDO0uaKgm7pvCnj6K4i75CPV4fMpu2FGowVRyfFjBoc4IZ7j?=
 =?us-ascii?Q?tvjseprwy+UxfLT4yffAyWr+kE8YoBh7EOyYP2ajKgrH0AEvw5KnZw3x23OP?=
 =?us-ascii?Q?861nzaHaIEor0zeiB6fAehV5VJbyIO0z+5OMJ/Epk5cyFfvAo7A8JY05UPAg?=
 =?us-ascii?Q?vSULmRNoYmYUVVQuV4JA1mAvWHDmY7SRy2nwmQlDjWsjO6TwdEpBKBa1Magh?=
 =?us-ascii?Q?4vrxTpyXuwJHcPjPUs4yujp8CZpo7gkAwIxw0RpGBkbK0HGfmEGnfhodgTUq?=
 =?us-ascii?Q?jHLwoPNkG77c3QgZTFMlx7eaiFVZfF9gB6RXZopu5vtAlvwiwCFDR6fiQxTO?=
 =?us-ascii?Q?oy7QVJceTPCPjeBcZaXincFUeaVqvF0NKEUUuh7F4mmEPd9RvhXDwxgynVRH?=
 =?us-ascii?Q?K5uuoYvn2PwlCFCqGRNsr2aThE/f2gwMNPoy9LI1uK54BZiTizy54wjM4sJU?=
 =?us-ascii?Q?lpPewQq8AL9/xoV2UPRzhmoV0UIjMUpr0FBlqFiR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6a0b5f-b190-418f-8a36-08db970eadb0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 06:22:30.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2A/eHPCmNqKhTj/ep9jr5RKJJitqWF4o8JBHwSaU/fa3rU6mdy2xt5pRFodadEWXfKtI45Fn1e7WS6AptnUJlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10039
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
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

v12:
 - update diag_* log of update_socket_protocol.
 - add 'ip netns show' after 'ip netns del' to check if there is
a test did not clean up its netns.
 - return libbpf_get_error() instead of -EIO for the error from
open_and_load().
 - Use getsockopt(SOL_PROTOCOL) to verify mptcp protocol intead of
using 'ss -tOni'.

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
  selftests/bpf: Fix error checks of mptcp open_and_load
  selftests/bpf: Add mptcpify test

 net/mptcp/bpf.c                               |  15 ++
 net/socket.c                                  |  26 +++-
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 146 +++++++++++++++---
 tools/testing/selftests/bpf/progs/mptcpify.c  |  20 +++
 4 files changed, 186 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

-- 
2.35.3

