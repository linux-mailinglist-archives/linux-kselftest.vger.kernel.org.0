Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0FD76EAF0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 15:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbjHCNoo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 09:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbjHCNoI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 09:44:08 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01206422F;
        Thu,  3 Aug 2023 06:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNsTlo6+2odnfjFMtTgmBsTOqQdwM1N6d4HvKfPFkovGljKxMruL+FXlHW7Ho4UuaA2e1k5ZQsB74n+o1VJ+LlFkSwjArx4VWvqg5GREiLaIdw5u5p4sZ0WGdLeTt7ypeJJSKRN1BayFMvclkAfNpyjQqCMbzARpU0J7fPCkfd1FwqbJEuy1aucqfqG1jNfXA6DsVBq1MQhl+FWNUKCrxhi+7XnFegOHB+529eaUJGvOs2u1eAcfDwc7elnIPXyqt+nITCQK96mwMh2ipqGAObVjBnspy6YlvmnnJ04BPzCQUOXJ8SFBKruA1y7vaolVyq26uqTVzGrVaeC29uDmyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHt9lnuTPzBs9yuIh7r3tTyg5wegWX1/XWlBHuDdcDg=;
 b=YBUdhgqcaYfGEFnc2BWQqtOsgt2gexhXUdCmBY+INL2xlEZSCOfz0a2hGO81+hnP3NdqAxSJ7K6TPatfVK6m0t2dad//ADO9Qw47o4d4IGIbELhW9vjfl2tKPyG9Qg3pwCUjfcAUztKvrQ8vod0chcistvgrDx8pKMhhpueF1Ms5mgZ1DeOYD3ZGay+iEHFl5DjPj8ROuYYttAqIv8oEmofneRu6mk05M6GdOT4+kxo9zNqTm1wbonHagTZrhUKD1o9VvbcpnhigT806dRo7Es8E3AkrNoNJ0Fy/t7UbFA1TlcMR7rY0WoCF4vtv9o+Ubuugp6GyZpBkhaoiUxC8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHt9lnuTPzBs9yuIh7r3tTyg5wegWX1/XWlBHuDdcDg=;
 b=BQkluhnJYopdp+SUfjIXdCISdLaow8Be9+5uIGkTUYrmiNSjvspXbwEPl8DWYfnPHVwRlmGgVE84WVzMHU7LyAnlJyBFjtH0yqngmHeApK0OuhlOfsP88ZdfioP0IGE3dFlE97ykZVKYCRSMcfPI2PM92ZgdsPBqNDKQjM8nmUY18pIHmhtVKmNBS6XL0SlfWqWT1KEH5NAQ8uWC2pMYD/vxQJkiAVn6AASE3JGk/FPSaUGSZBV5uN3EjSJR6ouOC93XjHdbxcVNlNwXzx4bXzACAu7YJHMipgH/bbC2OkjsGtGAqF9P56Ma/9ALVo+EIAtevjkyogSwTQB9QQiwmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS8PR04MB8580.eurprd04.prod.outlook.com (2603:10a6:20b:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 13:41:40 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797%5]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 13:41:39 +0000
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
Subject: [PATCH bpf-next v9 0/4] bpf: Force to MPTCP
Date:   Thu,  3 Aug 2023 21:41:42 +0800
Message-Id: <cover.1691069778.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:4:7c::19) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS8PR04MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3413f7-4429-4c43-6f89-08db94275d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uxj+1/GalyM4ukBpPQoYUUhYkmVqMMp9m0w/6FZF51m/lvbR227KBziLQo+0gJPkOsTtFU3hr3zW2HdsdH5hKJJY5wLYn4zDggEm621f599voo+LJvwXHbxNYPy0gq7JWoGqEw7kY4/pUBxU6SWyIy4SdALI6yWsVCDDWVasZ0f32xPvBA24mhk4rxyAGhqoldAIrpW1mNXJHI1MtU4ahXGVkz5SPAzSMwfLodJ+HTHynqFWJQXPr3q5wCCAXzVwchMqGLpoKyIGOfubu1kmtsHCCJyQpU5Mr9ncV6zmwBAsoMH+Fgke53yDTaBA+sN5F3wx2v9tdfNu7QbXDX/0Ggo7QIbmOe85R1Q8GTTbc5CX3pdLPuTFJfCi/vO+GrfCfgQjhTTHSKN5yB0LEMmx54OPIA+6DCGGyTAUD4hdRZrhwPC7gQWZC5SuE1ysDckNvUoIPNHbXXdAA18jBT0qHDl20on85HqaDVwL337r/ND/vsP7nbxO6UOfwthvy0w6k8Igmh15WR4pNBEDmOzH1Gfhoe8RmBaqs4mR0fS/t+5dvAMEhVQdRtbvpPEu3CO3rAnd6WKI4arM0d7AJvLdBQgIobmFqBYxtOPVZt3pe6oBbWPrgCYfvS7FbS31gG+Cht4Dk9UrzxUB7nxXKOIKWIFKi7flUjvcSIlRyV49vbQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(2616005)(83380400001)(6506007)(26005)(186003)(41300700001)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(316002)(44832011)(7416002)(8676002)(8936002)(6666004)(6486002)(966005)(6512007)(7406005)(478600001)(110136005)(38100700002)(921005)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dHFyxfzvp+DC0zDR94XgfHlqrpYkv7w6U/7WwpeA+s/Axj0iGtVE2rXx8ylr?=
 =?us-ascii?Q?HcTlSHqdpoObA0/97oTrQ15q2SEQVP34mkmPQC6+HD+VWkLDSMpdnUrmgJIm?=
 =?us-ascii?Q?KKijDXJZc7NXWzoT5KMjhAXqZFR+tZI3pViqOC8FIWvsBG4PzYaDr5DyWkx9?=
 =?us-ascii?Q?UVS5nevmZztilK7UVp4rwwNRDyv1pO8MSK3nE4dYQ5gyO/B7j7Je2vO198y3?=
 =?us-ascii?Q?LnmqXQTkqfhwdnuo2jBHOsHR8F2a8s3fP8RlwhT1Cow+M2ee7xak86T2nwH4?=
 =?us-ascii?Q?8f9aw62ki/7HWFt5uJeaKSuAL4uyLAuENS4Hy10r6vXx/IqVLowrYOhPJ2Ap?=
 =?us-ascii?Q?HHQndFxoAQcpXbEC6RokZTDbk7x2sHjZk6O7VnzbQ3j4iIKegurKyY7IAHIp?=
 =?us-ascii?Q?ai+UBInrGPZoNm5lTsPSIYuyg422i9onOixv+OvAvwl4pVcq/4nx4yXfSAPG?=
 =?us-ascii?Q?47Tazoa8c278mwNTUu1t5y/nz25E1hPfePXTBmLd9RuayEjfYiexaqKjmdQh?=
 =?us-ascii?Q?ZxI8FA7xhDaC+A+ccj5w8b2iT4ukYEOBAu1IGodT7N/46SPz5YUHV3AJmp4E?=
 =?us-ascii?Q?92XIFjjPwhLKIccs+HrL3ReiRtme2zEzuHu79CjJbQdrK2j6PO4wO6DayEf0?=
 =?us-ascii?Q?T0hAqP9bxsFyGuqoNzRn6wKu5lLcEHwnf2I+1KgKXrofdScC1LezI/DxkcER?=
 =?us-ascii?Q?kIswXtH+nvnE8tl12hPU9TNNfmBmwHBDy3Fb2oYZp3bxF06AEUezinThwEK5?=
 =?us-ascii?Q?G1+0SXMH3bcwW60sqZn08hr4td+0J1UcwBqNUtMn4+0APqWOh/nECHoPJr7u?=
 =?us-ascii?Q?RDHYRI+KElfoKq7sPVHVLI42GvEtQjADzDmn3olCCMTV1uWHf/KXAC/awchO?=
 =?us-ascii?Q?pwB8lUdDxjg/+IoCsLjvHuD//+Paq3JAf/8QX1/SpDQne9Bv1V4ut2f/A/tx?=
 =?us-ascii?Q?XHW1ig+iIaPxReTmeQBSWEs2p74MA1WxFxZeaxPy6QjB5XX3vSedtwo1lbl4?=
 =?us-ascii?Q?4PHYp/PwYFUCtNlmcssnv50fJc7sIQERj4vWs5/QRKMYfQxX0sNcRyc4Gekd?=
 =?us-ascii?Q?oFmASG214uKe4glOJ//QaYXSPfW7zABuxL4sagIZ1pHHIgz2p5KPQis/4XqI?=
 =?us-ascii?Q?5al/Mm7ZjToQFuPwfrX+icASNBjxE3EcMHW7vIhGOGtyWaPdJI64Rh0gcZWs?=
 =?us-ascii?Q?4uErvVOyZFBZ15fR+6woX+dcNxnBXoE0OIG5r+HvS1o3lnjWv7Fd8lmjoVvt?=
 =?us-ascii?Q?8Yc3f+N3VMcbJ5KpqxC8bPvuVidLmSBmPZfFCTYMHXTNuz4Jw7nG4uOr1oQP?=
 =?us-ascii?Q?sCbHnGKFrbSP90U5eBKcFzu9etOPjrzoT5+6EaSET41McLtTwBwh8u80/VnD?=
 =?us-ascii?Q?rKD0oaZFCSgNu2weuHQVgOrreV98JJeHtwzFZ0qyvEKO/svmRu+pQMhpUnkJ?=
 =?us-ascii?Q?eD7pTO40e5k3JbEx3AKDs+TSX5sB5MnxKufwKAZoLcyFsAvjFLm9fRzhOU03?=
 =?us-ascii?Q?7f/8GBvUzV4pB93DuFf+wNg4yGV0oDdDwv/ngfTEw3b68gBeFXq82uHyJoWr?=
 =?us-ascii?Q?Vgq/jBrSHX8n9aoZjadgA2OK81kwDdPERrhxKVAn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3413f7-4429-4c43-6f89-08db94275d65
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 13:41:39.8089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szj7qYwakcUGahkGyrRMptT84ULiBT5/dtT8lgIHuzQ7d/XEM9zqQ7Pfr1C3qFYzHr8vZ+g62OIOj2I4NCtFXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8580
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
  selftests/bpf: Use random netns name for mptcp
  selftests/bpf: Add two mptcp netns helpers
  selftests/bpf: Add mptcpify test

 net/mptcp/bpf.c                               |  17 +++
 net/socket.c                                  |  24 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 125 ++++++++++++++++--
 tools/testing/selftests/bpf/progs/mptcpify.c  |  25 ++++
 4 files changed, 182 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

-- 
2.35.3

