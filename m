Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D7376F731
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 03:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjHDBzu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 21:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjHDBzt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 21:55:49 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A764482;
        Thu,  3 Aug 2023 18:55:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6J88Kcg/zhoCR/OEYkASEG1sJw7IVwJvKf2je82OkVk7/V9cCqdzc1GNxiDFoxS0I0rBf8mg9Y3aLQKjn38jrcPOKttwYEFhAuWOTPwD8Ay8jyAUuD2FyeoDMxz5MT3O9cEGXwBH/tbmhnPg75fFtxfTjJakSB/fW15d0DDnCttBQ4PhJtFzDaEHDY+5bTu5Gc99QzNE2jR4c9oOvZPSziyDsfFyyOMchZSbUckjKGfUMoIDYHNsdtjjhi822bhL9ul6P+aObGS1RX1z3agVwE1hR5mEAQHs6ixo0zcaavm3B74RbyA78TREEQfU6KWxWzNBntxbHXLXezAIUouKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpHzThLR1aylwyE1TaE2o6EmuBi7BJBUWEAI/K51DQI=;
 b=YRrrdgXtLFRVuLmWsifJbtrMVWmYI1gbDo8xnYu3SulcdDxP7XMzt7AGKaT7F/FdjTPk7Q18L3qY1UFnbjeYM/M83mGqwnwWpYkwD2/L1eoJbSqbX3sotaYK7T05gNZg9EwOOORHcVIn62dYUHde15FYb0dgH+va2Lty5TMCKj3ABvf5iuU9XtO78VB2Z1H0P1V7Ugo/AS6cE12n9Hf1JKmZK0Cay/23lIEHqeP8E7hkH/ERKuMYhWqf2rodB7P32nnQ6T/2R5PRFo4gThsyquvHwb+UpRFu6LtOeDy8LutGLVOm0Pir6q+8uOPtqZSQgpQ3H+XlFBL2z4TaCCOWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpHzThLR1aylwyE1TaE2o6EmuBi7BJBUWEAI/K51DQI=;
 b=u43nKaTFwwed8WVkMe+p6MvbTJX/LSyotEVgT37n27IvHXDiDSJPZs7F5sOyHopfifNyAo3voO4YqwyoR4domdBp0o5MfOP7yax7UlhdCw4QaCnWjvN+2ttObwW1oh74HZeWW7qFri+muVqtOzkP0aXjFFUX0B+UAJqkeenNlTdiBwwwF33QzczVO+Raal5OQ08jHQ3NhCnoPm8e20hRFt8zYyBZAoGkzoiuB1QWLuxz0vWmuDEdeaKlmkvAtrtFqgNt2El8FY++Q9zWZxuLxRahUn6Kp5aFFr9YVKThpeGH/DoQmeQgZ5sOA0CZpgtDBmnVKztFRkOkbq4CdoEM1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9085.eurprd04.prod.outlook.com (2603:10a6:150:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 01:55:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 01:55:42 +0000
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
Subject: [PATCH bpf-next v10 0/5] bpf: Force to MPTCP
Date:   Fri,  4 Aug 2023 09:55:42 +0800
Message-Id: <cover.1691113640.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: ead31ebb-80d7-40c9-48a7-08db948de841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+xC6EtnaPmVaOG5qHKQeZUHjXKF8EqUfaGBZVA5lpQF3jtUpBHcaEnabbu/ZXbULjoAwjWQmgkLzr4DTiFYX9U0pMU1cYVbqbdKDLxwEBeeHR4mkSa1Jf4wnpUtZCBPRj9W1eyjQwoT4vzNafAurYw4nu6WrHd/BhRMIgllhaP3faLfDXIqFbbl2T37tfZLig6uyx+/GzTJ2i78PQuPOmrtp3r5Gu3DU8XQRSfa2X0ZeKQMmIyWpvamf80q/KlvduVNWoXdTTPIe9vo15SVntA1zzDMIdnW5i58afx3BLsZ6BtUPYCJBs7F2+RG0zb6DIR5W2dopDi5JiEoPXodsE/f6tZWRTRKtSoICS5d6Xu+mVX2oNLF4CxbhVTn7I9n88SkqOPRdQ771+X4Ys3Mtkk21FC3pZvIMvIYBHmAALaTMtMQQOmLq+QlC+1uz4E7eAl/X5fc/M594FOgdJo0eZG+mQzR1JsuI7o9S3Q5AasUt2Grpak6ZVQzDekWDx0Wrr3bCXi02v1BdVIktbs55hONC9Y8IGUT3RMIX0+vCLlRPhXOLBVWy/umrkpIYIChxQPfhWTEvfzuRfVY8G1L9uckU/zU20Xe82k9IzZXJeTYBfscKa8bC9B2x79DzG/VYDXOCwUFvTt+4Ij6BDx4sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(346002)(39860400002)(186006)(451199021)(1800799003)(6506007)(38100700002)(921005)(26005)(478600001)(8676002)(8936002)(5660300002)(7416002)(110136005)(44832011)(7406005)(41300700001)(66556008)(4326008)(66946007)(66476007)(6512007)(86362001)(966005)(316002)(6486002)(2616005)(36756003)(2906002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XzZahfrYP9udcmA082ixIjlYRdA5tOa1XtClUAs2jcx1MaBGzvC3VzjoGgMj?=
 =?us-ascii?Q?u1ZzXcCHoQfUgdP61jMom3r8xbWqxngSSGbS3nCWxbv76/UdaaVrfomtqhP0?=
 =?us-ascii?Q?N77c8H9yokbSHkQx+iHPAEXv8A8WvVt3dTHF1O33qjJOO8aFxu3UUxvPuQ4/?=
 =?us-ascii?Q?ZuSbT33IajdXj6SmJJ5rwSbe2BCNTyS8ATRZr9I+iWkiQR/MhsF6qg6Zo9rm?=
 =?us-ascii?Q?QJ/om2WKp7nlUdA/Bmsuf+1yGpuxMxQ1NZEZLOb0EEN/3zOnNgo4AURD4F3O?=
 =?us-ascii?Q?bYj2lPe1XuV6yzCHkUqew8coT9Xtm5N6menSGxgBCIQNdqnG/3wEYQIzzuKb?=
 =?us-ascii?Q?ffPwv+IsKlPuOrWe34mGIBxY+XoBleNFxWslEZbd3DCiOGOwt2/14YHdOWkj?=
 =?us-ascii?Q?j1HytiWpZCs86GrlZviTGSqsscCBMR/vbHt/QrDSJKdiZHnyGK6rJEeT4Rl2?=
 =?us-ascii?Q?ZZk1W1CBnGP0Dis/rzrZ5cu9hsri8Sf32gSGinOQda347sO0fpeBSEwIEahu?=
 =?us-ascii?Q?BsLFDc7XjGK77Rks+IxTtoj4jVdXV/C4dwqNqHfu/11WOzZvyGxY4czM/YRi?=
 =?us-ascii?Q?2yV9pUOkPbvFFuR/vwi76AV/4UAXTjnCTRO/uszupVdWAAs97gu9TIoXIL+b?=
 =?us-ascii?Q?P97Oc5T0ZUsC3gmTdkdzoWzIeRDHbTtIfju16e1oQMvtbCt0pHS6GVrr8Uhq?=
 =?us-ascii?Q?ZJUjb9LKXrooMyxZTZcN2mv4XsiIW6J//KUhe04Y+5Gbyk8sQWLTtOpqIKE2?=
 =?us-ascii?Q?2+7od0H5cK57basS4vAqf6gHRE6gdJ6npkWBkom5AeuH9AZJkUt0D5hwBGkS?=
 =?us-ascii?Q?ymXtRr8Lz7h+DClBqgp6n00GYI9CmRuBlL7x0FmG5nv8Tzd//A7TyLwZVwPG?=
 =?us-ascii?Q?leFNjAyFY0s7u1AK74Q7k6w4i5SfoqXUaAg9uYoV3dsiCyNoxxbpNGtm0hTh?=
 =?us-ascii?Q?CsATCiUWs0snNJCB5czaEX1eqp6DPWYosW0DjQOrOce2ti8GprgsJfXkiFWn?=
 =?us-ascii?Q?e45LxshooA2JBjBUV6v2RItuiwMrv6f7ZsNHdGh2Bh/pzLPsojDlGcu83x4C?=
 =?us-ascii?Q?7QVXZpSMwcwmBcsiUcz4Z/Kcyo9BRTESkI3xZGKKYhOsSa8sp8wsZo6DJLdm?=
 =?us-ascii?Q?JEwRqUeKaYwNEQmRmkowapJkulHI/Du4R0dKVEm9dRPjWyHAtsGyWZ/oH0Ye?=
 =?us-ascii?Q?4l7qRe4ptxd42At2I2ZO/hqqB8vq60RWps/2gUwJLVvAzyOxW1d6IAOsC6GS?=
 =?us-ascii?Q?Cav8+a+b7JPBcSxsYZ1J1mIJzRKLzmxxhc0yUwsIOIEeyuRn1QcqdUwEhs59?=
 =?us-ascii?Q?U+tsyokT8waF/C3gMkPXFy2NxRcv8WbsOKlfNGq9/D238NT06PuBBPSsyKHD?=
 =?us-ascii?Q?g0MJzMp1FrKAQ7mRxI6RTyk9JqP7ZROe0WwxcYORVsLEuOx5Pp8BavaR49Ea?=
 =?us-ascii?Q?Rk75fLH2Zd/leFHevuBteh6cyVUzxpRj+CCGKw2UfnMg4FlqVgNaMrdEx/iB?=
 =?us-ascii?Q?OVVihpcVFWnhUwDIqe+jEGJHv7wGfDpzzcxOGvyOcSVPE0u9Y4F80OA5CnNk?=
 =?us-ascii?Q?3M89yDY9jINonTQFkWovMiSkyDwgdghaFsRmpw0F?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead31ebb-80d7-40c9-48a7-08db948de841
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 01:55:41.7400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IVoJoSOqqdpih7rcq655fcnRT5aX4UljyRSs2vkP4f+MzlTiPrSrCN+JcQgYvmKd5tGCYSVgKtvax1rrmBG5A==
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
 net/socket.c                                  |  24 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 129 +++++++++++++++---
 tools/testing/selftests/bpf/progs/mptcpify.c  |  20 +++
 4 files changed, 169 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

-- 
2.35.3

