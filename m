Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BD8779CB5
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Aug 2023 04:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjHLCx4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 22:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjHLCxz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 22:53:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E45211B;
        Fri, 11 Aug 2023 19:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTQaLc6fkVVuhf0bSxqNAHTeerxUPjEFpSATASGvLo+zHS08b4ofcODrSKGdw1XhM8qyYEWX7yAShbip4rTMbl+1rEdXhNVL2rZyZf9eHpf1tVGXKnAUyYLmLGgDvppNgRLEpIyZ4qp16mc4y9QVekCj/qL3nWqLmx5a5MpM1YGQZZrpm6uVlOExgcd5Cx2P8rBcYAVcghAO9OKIccvtPouz+Le4j/SDCH4GwsjfmUsZbDWgHcJQpoTbYjgiyHFHrq2JmunuAfZnbUHODvEIyl6SpWtT18nBznM1mGvR4ZizffgEb2KnJsYvBrZ0VpPt+aX6h6rRg0Kd1YaSV460FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0l6GXk9W8qT2fpaOmXKiyEjhUkgdfs24yW1TQt2nxA=;
 b=d4GgfwaNyiM7/EM9yI7tTkTYaUMFcdklypx6G5Lt4i6fk88QCd+nxMRnS2wS2pLYbbB8CrLlyVP1vPTMQDhbCBHQksw1W48PgIKbLbhm8DHJz9mKIaqabq+6gybr0zQcOJ/Lc3ZciNFm9+BfzEDR/bQcqnUS9s1AG9vzTuNTA4dcSPKVUSLuTcwWY6WuTROjhx++y1tI0IiIKvIYsFxe+fa6OZDjFF53Ra2Lnjl3b6Ay37Wo50Y8nKefG1W2nn4aISH2iDjcLGSxjVoIkHbGB8Jh4UwQPvh0jwVyiEbqIVYM1sMZAAPZ2PmPSU8JSZVEDfINx5cdf7GvQdoS/mhhaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0l6GXk9W8qT2fpaOmXKiyEjhUkgdfs24yW1TQt2nxA=;
 b=n+ltvFBDUM9UfEG5kBPOfkABXuhjLXrcxvud7m0D53PTwhXOEAqvOzLU6Xp2GltABWMzxUe6PIqhKY0AKzP1esx3/XBdoB7JZzWATcAE3sZdUZ8yyQ7Bd/NXYLbLYt4mlNDY8VOGtdUfNQu2KCt2mX1YPM2cOLVXhopE3n4DeoAZqlXPwvARnXIt4h0pNOL2erdUCldh2pwQ8VOzHQRsfy3xw7SPnvZZRjV/YPquNxtozduUF+MfwcIrC2ilZX1KacHgRuVhH6bYrAdzaf7SfRAbBaQIe3ETqQQt6kdysyYG4y+TcNvKQPqwdN2nP/1m6i6mX3ASSAi/By2fvbifSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8981.eurprd04.prod.outlook.com (2603:10a6:10:2e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Sat, 12 Aug
 2023 02:53:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.022; Sat, 12 Aug 2023
 02:53:49 +0000
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
        linux-kselftest@vger.kernel.org
Subject: [PATCH mptcp-next v13 0/4] bpf: Force to MPTCP
Date:   Sat, 12 Aug 2023 10:54:06 +0800
Message-Id: <cover.1691808484.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: cda6c2b3-763b-4a74-00f5-08db9adf5a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jt2lSAiy8cQY4Y1J7NH1ZS6jLjhUyDsgH7F8m/FXMLiyc2fZDlpd61aL+BbBGQ8B+XasI36FL20odQq6bmvbya3uXEhk23xj4Loi389SBFj+dtHaYBXe4tJBMWcmEthWN/1t33KyOTRrkxEv7KUUqGv/3ISsSqSeSe69qOuiMtCwn0ci1mkNRn964fGvBVWuf/vX3YkLJ5jPHx5tQYm2QB8OyugkJyJZ6IeY56kSqFVrlwk+HE3GHD3oRzHn6vqfh5oIHkNpqiErZcy+NMFsAljXMpHAdkWrsIfLxsHzfWJ1o+uMNwsAE5nMXabYqhBV+QD8mY78nTfciA5XF/444W9YYjonyvsXxLFAW4ymt3RGl0jv4EcvIZhFLf3BJwPfnpueKfioYHsJ9ir4WMOCfu8CylZl6SxwrcJCvSu6Eo0dZevpVJHO5crfobN+VyyMlYGu1qJKpv9JZa2j6JtpA5KaulvaoThwrNZATf2yyOO2PmPRrIIjYFCqYWdoFbQUQNGmH3AHEETb9MaJGlQIxKSHFwoRR63XgoBQN0h0xBWZPTBaNtB6yOa5/Wm9u2Go5PX7goHDDsINi9oURvMv/OiQ/gMPs7ekCt3vqmHxHUZp4hqoW1SHTr9INqq3t/wq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(39860400002)(346002)(1800799006)(186006)(451199021)(478600001)(2616005)(26005)(6506007)(110136005)(38100700002)(6666004)(921005)(83380400001)(66946007)(66556008)(66476007)(966005)(6512007)(6486002)(4326008)(7406005)(316002)(5660300002)(8676002)(7416002)(86362001)(41300700001)(8936002)(2906002)(44832011)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yc3pCGFYN6lqEBYwLLP1txjpFHHzWG0LJ0fAoV82oAlk3RqwZ0+pvAnkKlKj?=
 =?us-ascii?Q?/vajlysViY6ARCXUeIFAPuox8jNp1QZ5aYKAXqSsUn3jCZWQ1IuvbO8OwW7B?=
 =?us-ascii?Q?5xHHSWay0c/4XMrfhdCrXtC9oeObovBCNvTbk9r8prefgnBErpmOWNqc+pyT?=
 =?us-ascii?Q?ZNKDSujpMTFTJCYTl4+Jzmx0YSr+HR9aakahRsLXQZOxqhxmxPcem1paPa6G?=
 =?us-ascii?Q?Uan9r6EVtH8u97n9MeA4iACfpKc45XWbHVuUzWZBDOSvTb83VWUVNKlgPiSa?=
 =?us-ascii?Q?o1YvtD4Z6LV3bnJq2TiNx2YCiDdJ/9osSVGQhBqYbMKeGvQp2hsLEM5qy5EM?=
 =?us-ascii?Q?cyLnrINyHQnIVGxKv6DOJZKQ++ihmrMoQikwDqpPXp2pLYA7Xv8+XshhCjxe?=
 =?us-ascii?Q?neOea8rSVEFr35rAadoWO9FIl4CNqlAbLN5Dt8DcdoTA7ILOPDdIHAdFpxSP?=
 =?us-ascii?Q?L5lV7AkGT+tbMBtY0KfCJUokKMXsixRNAXBMWMw3MPRdKkchvDuPPiZvDRla?=
 =?us-ascii?Q?Gg9g8H6e3H+tShzilCKoB5JtEUYk8Bl7wUAIXLmiLem88pe9zsNjHg70dOJK?=
 =?us-ascii?Q?c2ugi0QKMFMHUWrhYob2u+3bO29z5juZtBEnFSrlMTM50o4zLEu5TH8UJ2uV?=
 =?us-ascii?Q?6W8XO8Ri70bwm/ji9XKTk/7QB1tv+nVbrT6lyODRiTBwcZ1NkrPWiJGgxigh?=
 =?us-ascii?Q?+SDTkAy3RoWWbgol1E0FxdqSLPWbNlN1jCvO13VDwsH2PVmYyaSU/3m+Uegp?=
 =?us-ascii?Q?agjf0vil6WTY1tH6r8/Y6eFR36QyoDR0/4VLDiHIjuAnKQK8KrbRe/xt5PGc?=
 =?us-ascii?Q?A0aCoOBUq5jmzEeJx1PqEm4Yf/XXOEf67ruCNF+u0muIbT4CZqVzNwBgv1kI?=
 =?us-ascii?Q?3a+pcUeijiu4/z/ZoFGDqjINo/WCVnj1TPL1iGE9KxyzyG1zGe9ywX5eJ0ft?=
 =?us-ascii?Q?RSPEsUWr1YJ7AlAg53YsuOcHYv01DUmmhFDY9kb9WXAuQU/5qF4tYWZEQHk8?=
 =?us-ascii?Q?/YVAMSq/Ev6/G4Vz85sBLX9qYuQYdE5Z36cDWPPZQd/b0OT+twDrFOa1rbA8?=
 =?us-ascii?Q?CYOvuHmPgtahhGMNS8PAaAgXJ2XmCXlraOqLEuOBqe4tlDKxKJSI/TncKdpZ?=
 =?us-ascii?Q?YvH21NQA9aK4g8fOvu/EJSTQ7xrGIILpQBGnVK7hGyiaX/RlCAM54zvKjBK1?=
 =?us-ascii?Q?ttG1AyDa0E10rW1zmxEkjs+brqn9tV9JQ92Ks05UAaMyFwo1JgYMYSJiZLqq?=
 =?us-ascii?Q?mG8HVrts/HATo/PhDse3KhhD3oz0bRqJWzLk/4BC7QkYLLrQV2L/wSd1IMwR?=
 =?us-ascii?Q?eAdc9SW5yxoEsQNZXhof+Ao8AloiHexrWRTvt4iUXQ6zrelS/aBl5oO91WGH?=
 =?us-ascii?Q?aWi/UOFgAB1bQCmLfGLbFqDJoRqBVhQv9D24wUTsXQq5BvUhno8WPhlM2+JD?=
 =?us-ascii?Q?NTKMiwYiRZKJBbKoYdnBerrfQ+hH9nX1/9RMaEJgjX4GLrBGg45nbYXtqSZu?=
 =?us-ascii?Q?tWD2O5+kcqJg0SAGjGYIP5e4cK/YTHuLd51ECzgSzr+QBi3pEEv531ZrNgZU?=
 =?us-ascii?Q?11lDT7qSK2HF7M0P/Oi6gu3RaTXgovtZGhN9BzDK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda6c2b3-763b-4a74-00f5-08db9adf5a24
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 02:53:49.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kn4OdKHRReNaHvllyyOFSmCTx2eHbljwUqz9/aJ/VrSw9PtBkHEP0sNup5/H5bYSXzdWQY+EG7ec9xLaxW2DpQ==
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

v13:
 - drop "Use random netns name for mptcp" patch.

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

Geliang Tang (4):
  bpf: Add update_socket_protocol hook
  selftests/bpf: Add two mptcp netns helpers
  selftests/bpf: Fix error checks of mptcp open_and_load
  selftests/bpf: Add mptcpify test

 net/mptcp/bpf.c                               |  15 ++
 net/socket.c                                  |  26 +++-
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 141 +++++++++++++++---
 tools/testing/selftests/bpf/progs/mptcpify.c  |  20 +++
 4 files changed, 182 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

-- 
2.35.3

