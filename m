Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE5D76E18F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjHCHfS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjHCHeb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:34:31 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2057.outbound.protection.outlook.com [40.107.13.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0671D358B;
        Thu,  3 Aug 2023 00:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+xhAVzOXg7/wr8SUxxlM9gejl4mJWwEC3rmq2dA3fNQVhstATTEcGUSV7BhEP8bbJSW3H097OfLHpFx62M5I4lN7ZZ5D85kgfxls8VoKIwYEMTyA8inj8rYW98PMDb5esMEfIKpdvYvsWG+O3Nn8AyYqtSoxPDLejW97e7SrGYbrJ3A3Kbf4f84LTWsggdwZkr9/2W7XVAuuWrGiwv4cNVM2NLGymaXGkkvNSslRzmC+EzgIfMOoCgGcdjcJLJxmHS3Cj7XhqoH2DjE/rQcQYvYQdZGVn4f19E3h6d+MJ70XUkGYK8/ZajlYoSM0x2u2ldqXNIv/YyEglDX+Z9rFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3Zpc13VQKmdeew9QFMkdWECjPzXhN6puIMosDugDIo=;
 b=Jj78f2EI48WoTAsd18QYmUVu+8IDj+OxTejq5dQ9J3PZGyieDlQw9w5CjcgdzpUZbMa/gQfegRkyrILHZJDGqccDQAeiyc/OHTA7ThElXDUHSELX9/AyE1LyP2MzkYlZtdFbBYSouDv1PZicBn4quhE5QHlHeiyTTbnP/K/RCAEJJn8Lo1yWfDYAl+UAWVLYm1lEJw7fJdWfPiHk+Ze91QS1jQ0wDPt4T0Ft14AXhsantmaSUIXT1TdvfoV2WS+1xAadRZL8RKeCCHo9pKXbde2vIIuhluimXDMyLv/2bnHrw5kFQtwsrY06grnwyhU47QVuWvKRUfGPcmpRFlkfRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3Zpc13VQKmdeew9QFMkdWECjPzXhN6puIMosDugDIo=;
 b=tUdsImkPbgtZdwM4vOVXmfY5zKrUY8k+KlrRezmABatWWNx78fRlkHLeMMoCM+UZsYe0YdzVpRDXvIDZ8M0ef8uzzQMOq2pmllpxl9lue8KaEkFEStUmaXjjwLNiu3AnaEUMi0bOtwK+NgKpohfoUcaxNsK4MO7dv/JBB1HLKpF3/Z4MGxkUOr1k1a0tCFQijlckGLiP/5l8hIDavKUYsA4NjGfQwKOaC9+Wmb46Lpw/2a9tRTumwlEA6RWT9ozGihTAVHPsRrph7X9qSOTgB0cQbqUQa1q7vd24E2MpPumuWJ2EbPkJX/SbpSNnb8drasyDdCp/pqjvs7YbUKVmgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8571.eurprd04.prod.outlook.com (2603:10a6:20b:436::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 07:30:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 07:30:37 +0000
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
Subject: [PATCH bpf-next v8 0/4] bpf: Force to MPTCP
Date:   Thu,  3 Aug 2023 15:30:38 +0800
Message-Id: <cover.1691047403.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0095.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2dd2b7-692f-4c37-5ae0-08db93f38829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BtQbsr2arAfghba4qaXP9/8IGOVA7z+KXRguXbb+L+EsukAFC2v5RXXjQDYWGYwVJmcnno+5dCA7QvfgpHRvApbVMtFfvTjUSafn/hSq9FimWw3W8WJqsoPyHjSekYgo5goAyaK+Sl24Y/1V6xfCrRc084ddwj6LdcUWTkSC8A+4uovfXpnT4JCL0xe+byd6kMAx+gafwU+0/9IwsxHpmbR08p5hre8KBm5TKpPhD7JjhM45llfAg7A5QV17J6BZv1GCPbPeX3jf8vMnZcJw9+g9gC2soW2r/4CY0cBX6q8MM7oZkm5u7E062be+ttpz+QjBzeI277C/MjpLQEcNdhhykS4SD2V6jfaesLDrPH3zobZYzje0P74sMEt3NrCiGTw8QnQU0KWkskSAg6vFHMMITPP4nR62wF+dR4FBICAfGXUKShVrQfInEGsd4BvIAMs/2dn6UwFtHcUhZILYr2cTlkgVIL5IKLkaQ63DuW/a4dybkjOXDjuN4+eZJC/njK6GN6b1zFDl8EqDPO6hqi1fBIBV0XYoIump7OM51pToGy638hfmb/BVMtNuwkrzZ9Ub6bTaJiq0TkdlbhMYNQdtM8KbS3ogmAxanbte9x8bpXlJ4vdXo9RsLWa6gMSougO5oqS7m6fPrJhs9mU/uMXnrQXvtsfwTUC0wVIEURkT9IweX4lTtMYRb8fGqsWHsfqP22QXWh0noQpSo+a8CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(110136005)(6486002)(41300700001)(478600001)(7416002)(5660300002)(8936002)(8676002)(7406005)(186003)(4326008)(6512007)(966005)(316002)(66476007)(26005)(6506007)(66556008)(66946007)(2616005)(2906002)(83380400001)(44832011)(36756003)(38100700002)(921005)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v8rn6oh7Qa9b5+u01+DKZM9BjIf1GPH40I8UfYTX77hAPZYH7mpyFgFfmhgO?=
 =?us-ascii?Q?WtLv0o2aiHceLjQI7TxdLgcUZFpBnTtKfe7zlQJD6A5hNVSQVkp/VNj1BIjw?=
 =?us-ascii?Q?+k/4m4/TEw8k0Een8v3V4sCTcKgmg74wJjXQwWlUvXCjMJ7Al481tD6SaF/d?=
 =?us-ascii?Q?fw/xsg/ToYDGI+5cHsIXP/+a+Ar+Dwx2oKw89Wswh3eQDEe4Sb5S7BQtWJ3a?=
 =?us-ascii?Q?t2ckcFVHi2SJs+Tc6Jf2t1OUtnknvah7L9mVctaxBxjSJaoUfrg56nbC5YpL?=
 =?us-ascii?Q?sRbSHTesK7KgdFH2hvyFDJxyms2iaTvJdQIuschoNYlSflQ2i+GrC3VUSkwB?=
 =?us-ascii?Q?NupYLgjaEJVMfT47gyuymxHnCIr4lEhGQ/ELUwB7OA7PLOPx13+a6RtTM64C?=
 =?us-ascii?Q?P6MH8O1yfgEPLLZlz6njCGVJWm9z65RxKW3g8todQSUKtHG1Oi6mbRic2acM?=
 =?us-ascii?Q?M0iNocdG1zCBs0PkuljtdanWD5uF10gau743Ye+Ux3XdJfvHw3j9gizUFy3m?=
 =?us-ascii?Q?McX/MlsWpHhQvsIZBtyd3cb5tf/RFtmKPFGsnl3PbEAY59exEJsXwRgUaCuF?=
 =?us-ascii?Q?S+Fi8FqtaZR3ji/tNxodHmSbdXbl8NNATsUYTmNEIB9Ee0D6WH9ySfnnt7qP?=
 =?us-ascii?Q?Ql96CnXFt9dsczLM1mX2fIyJMz9hQZaL2kcR46g0GnImEoD4Mz7PaHAevNmL?=
 =?us-ascii?Q?LIFbGbn+gf8PFL+vCxgh9LEDt6oYQBuCgTx4EQTbSC5NruEc9Fbh5L7xMTq3?=
 =?us-ascii?Q?gM95iAKRczVxjjVdEP6+a2DRyQicLIs8j7/LtR5nMxBYQe30/o9W5rswyxgJ?=
 =?us-ascii?Q?Jst0UNtfyjBTnISNo/rmBXegpFu3ltctzqNlacqTdwYtMgZwEmgopuF+OSbe?=
 =?us-ascii?Q?Vk8XIOaqYVvS4hMmn8c0Dz5c94fQJyUOGJtcqcn0jPE7hHRGndpwN8V/W2z7?=
 =?us-ascii?Q?4NNPGQZYJqq9DzRjiRNGOzcVxY9jr2My4jTZgJrhb4Za7Isn4bEOCkXW+XDN?=
 =?us-ascii?Q?j20DPfSyEeJ3CLLw1Askez5wD0GTaoUyS9v6SJulznQSh+f6K2rLOrflwNDn?=
 =?us-ascii?Q?30yrgjjR20hGidQ/9VAyAEZyTw3ay+nbp9cvEBTghF7gerfnKirIAaq8wCFy?=
 =?us-ascii?Q?T/GRA4PuqFAmFrX10LYtM+u/jlvtyvEkkrSohRsj3k6qpuFpoLXQBqL2H3v5?=
 =?us-ascii?Q?T8gLKWQxOpEwveyurS+vL1HYuLqxgZWEumliPhWcZR27RU9grMzXtLucTJ1e?=
 =?us-ascii?Q?txSHUzyDYlI5oS3nd59fAsFRyvWeuuMuGDPBozxE5s0Ih0M6DvPapHyXM8lt?=
 =?us-ascii?Q?eEBrV365rlvzNYpQBRhiz19gHwjcN5bIbbDPvvAn6GiLdhoEMuubZQ7EDli6?=
 =?us-ascii?Q?+n6fkTyuJqQnwiLArD2cYjY2+/XfmpeLiPzTYwMRFuInBqZilob1RaWALLyo?=
 =?us-ascii?Q?q/BPo/ACqApmm3uzqoCrUBL7Hpj8mr2z93kH14Hql1gc/u81uYdFFRMs7Dwk?=
 =?us-ascii?Q?fDbnatp++Yf4ccfWz/IOOFuSrfpqauWtmVbdBr4wZgB7I5qRqjIZ6kcdG9C2?=
 =?us-ascii?Q?JUM+PDKNyVPpunVsCftwWETyMDHwK+3QTpF9wif82lhEJtPX5hsGvpOni65j?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2dd2b7-692f-4c37-5ae0-08db93f38829
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 07:30:37.7475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eo2o9q+ep6x+gORrupfJBJZvBkFrM+2jzzkFNlVWaWk5407uB5qwRgMEObmgk53hUWc0GnUiO8ht4hxyudduuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8571
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
  selftests/bpf: Use random netns name for mptcp
  selftests/bpf: Add two mptcp netns helpers
  selftests/bpf: Add mptcpify test

 net/mptcp/bpf.c                               |  17 +++
 net/socket.c                                  |  25 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 125 ++++++++++++++++--
 tools/testing/selftests/bpf/progs/mptcpify.c  |  25 ++++
 4 files changed, 183 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

-- 
2.35.3

