Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FDB77D766
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 03:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbjHPBMQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 21:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240959AbjHPBLu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 21:11:50 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8192121;
        Tue, 15 Aug 2023 18:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0p2qMHKFo7ZjLIj0eO0trm0tn1b9AXfL0c1Bv4fj03YcPgvSsZtTAhgYsFYMqo/X31Voi3IyGVITQDCUxQfMRYJQlMxZ6UFgPvjkemfINNKRWj4B+tPNT/+lwa4/65zOizW1qxFX5ciCOeEYxudNjF+88WAoDg1mo9TgHwWoHyOixBlcqQ99PTYBYq631AEpPYw69qAQ9oszK17YznXggpcyco4HVtk0cxuyTh34sB370OWpte14/wlRTGcpSUspGMj12XdyLK5ACxHP1C8oLhrXqy4PkTN6sNyq3+EfOxDGgO/nBnZj8SaQseI6vFWE1W9ocmFosnvVcWPH81VEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iml6OR8I2JQ4cESgcXAnb2RRlgoArFuxAjzffOeraLU=;
 b=XkwemW9bvWcPxlODDjuhdciim7ueNIqL3Rg3icUH968AFqXHnW4f2eGx2lYdLl3S92P3O4Tjn1QWmF+rBbBG16aGraBTbDPyH9iKHuNqjIGY/4U97uyDmUbR/UYPu68H1uVavcjmKA3m1KCUTegPIVWrPlx6ERBRjATx7ReIGTKj1eW01hQJPQRkQO+vPfZPeOQZklwaGIwVmgYS0nTc3z2d5tkSXO8B032Cr8155z6nGF8ke8DZSmwZqh+xgHCyYYq1gFS7tIgQHFgBh/wL0mb+AdbyxlBJN0Fvy14drx7tBZ8DL1ys1cNjgbie4Bfe2kFzNVH5wmr3bnxCdhgOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iml6OR8I2JQ4cESgcXAnb2RRlgoArFuxAjzffOeraLU=;
 b=NYnt58GAU20hWLmjpbnmvSAW9xvHUY1lhsgja2EcNqL1mulXmuwNLwIK+38YbkXmqJcjLmGXhUkgaSmwONZLMrIE2hH1BoE6o1hdzLlAD3kAWAAeYnjKz2gSAnLSfg5FwYdtnWWoFzTDG0Y7b44gH8WPZ3WBC+ZgCmhhaMRxn3RUlJMl6hr30j6ooBv1GeV5kw+sAEeK1OG/A6+uw7T4mkrYyTCGUU8c9YKkR/k+z5rzXAlHAMx1OBi7Hl5T7w57nuTNjSFY/4IbEsr98FDDd+BmK74Cya3TY/913GJix5AYtqcv9kNLeySkuyPmnw6BdOdxyVlgNzKboMDb2Kps5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9915.eurprd04.prod.outlook.com (2603:10a6:10:4ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 01:11:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 01:11:43 +0000
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
Subject: [PATCH bpf-next v14 0/4] bpf: Force to MPTCP
Date:   Wed, 16 Aug 2023 09:11:55 +0800
Message-Id: <cover.1692147782.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9915:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ff748d-3e6d-4f8f-709f-08db9df5c0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zn+9bXhWOX3/F4BpAt/skCk+11C73ZY0qpekYzt4NqNFuqruyAyCuOoUfw4Nszr28u921fkEpvomZTJ5cAOxWH7ZEz6RGGbs/78O3Ix0+4xmAH2BkshImB+YcvWgVgw8pPT5nR1bFQm7+/hkzg7InvRuXYH/E47cRYVxse1L+DIHAytgKdgecLSvbTLJFP4IYzjpyxNZdhVWZJlDfefCihLdWT8EzKCvdbi5xJKncagCCZbU894K3ermwWZ8fI4DsTxq/ph6JB6UJkwsF+xKY9931q+9ofxuS1hn52LDzhr+ijVoDgEFHJu1TUQuFoRAbZvsWKrdAGc395Gv3CN0fqMnT6LM/RYxCjHEzW/mgsw2XI0VTsp0bqmmObEp3x/rP8OIP9W6aFovNnYILJah0KGVWJ6AdAI9ga5H2bSBWGGQ7EbdAiIxUl+XlYCtq3Ae9fqa4z47h3Wslor52NBFJclY8R8toPBuL3buasbenKgIhvqY6U6wsYcu9K1eK7//K/0IMvoTEbmrorC9x4m4mOTmsJboFfnlCs41IHkmNoCHiqP9e2OWACl/x6zGo4jBFY1uGLQVw/N5RwV/1SCqExxaRIt0jDLjXeYDVknj7lAPWGbbGeAxfmFP/6nsNPXUoi9i96/y4FpPTarCFyrU+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199024)(186009)(1800799009)(38100700002)(36756003)(86362001)(921005)(6506007)(66476007)(41300700001)(44832011)(26005)(316002)(4326008)(8676002)(66556008)(83380400001)(2616005)(6512007)(6486002)(6666004)(966005)(2906002)(478600001)(110136005)(5660300002)(7406005)(66946007)(8936002)(7416002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wDi5Lq41kB68HvtHpZMoaUaRIHELoFq/AB8pXryd4rnQXkJnI9nEgQBZHeXF?=
 =?us-ascii?Q?sx9XgLOX6sv+qkCqzKVynfXte0NbphxSGYjs+v8DoeekfEEEv7wPOaHHSlMw?=
 =?us-ascii?Q?ikw4nVlkfZqjQba/UmcgcOE//i33jX+xNzyKPMVWmyxEr/JpCsnfigpcnuV0?=
 =?us-ascii?Q?tik718pB9V+WOe2oBLe5L7YpPQtK65/JqWFbiEqA3+S8ztSvZvEMt5wlXG0P?=
 =?us-ascii?Q?nMby9Ri17OFsjTaACAR2y8dQPl3UKnssKN2EAAmmuMXWWyg14RgyWuptDAIg?=
 =?us-ascii?Q?W2FTt2H/EDPT+3l7jtCsgPV7d4dYIOw8nJCOVVJg8n/jtV1/QAD8K9bKzz6R?=
 =?us-ascii?Q?KQa5CBK4nmNu/MqWBJZJXVl+3N7iXK01xK/rAS1ptFqwgfJSN+Sy5B/lLeTZ?=
 =?us-ascii?Q?TBRuceX6r028kjRBWxgrbtllldusdwI/hkp0tGCnfbB0yK3nQ2f22XP8BqrG?=
 =?us-ascii?Q?r8E8S8WISpPVSyP/fSFDcoTpc1MI7tf2Du7Q9zR9/jwP/1IHbOrNZg+GKskN?=
 =?us-ascii?Q?90WbkZU169nzHXfQyMoSSMeGfc+xViQjXVhZJK6pdeGsGin4HrV1sAMvY3if?=
 =?us-ascii?Q?IvF00UT/rY6HXunVN0Zc9oqhlNEywoT4RbvKTs5g3GD7lv9CYkomskIBrHP6?=
 =?us-ascii?Q?u6+KRyf2igwuNZg6SlxBe+zmDOeevLC4HOnvH5Fx+OZjK40iW5tIf+AsBjI4?=
 =?us-ascii?Q?1RMQHGwsxgmlwbsjsCKkKnUzqdEqnwvz07Hk/GQkSNdBYqQbwLt3cZVK7FXd?=
 =?us-ascii?Q?Xwq92icLKvmaE0imZyTV7QAMb/MdB3IH5ZZgNUnP9wyi6qPbOavDntZUnEAC?=
 =?us-ascii?Q?0a1uo/Zl2uKO/Tagq2HZ5jCeXXiTEdSJg2CcyJysCsxJ/KtNoJISZ+h+R8eN?=
 =?us-ascii?Q?K58ZNlfVVOIQF1bgSFN7+fyNWs4ujclZrcSIZWtVqkblknwv64wjDlNPam2+?=
 =?us-ascii?Q?nsWkC+zl59GOq3II53zeuIqQta9LE4kd4n5uNzdTVH9faeATWLaETaAT+bRm?=
 =?us-ascii?Q?p8xui+DNFW8uBOcTADwaMVzfAQoWryhemmvnvlICKD9GN906MPwCGrw8bW+J?=
 =?us-ascii?Q?5meyBDSU0e1CrRAqark/E3fvIhnz+/pStpj7G18Cx6SIDiiysutAGlzgaGFC?=
 =?us-ascii?Q?pDnbHORX6kj5xoGRs4+VcDhquZBVzHL0vVKSzSwg6s3VMXp/NM5YIYOC54E1?=
 =?us-ascii?Q?l6tlxbpTNJAIGqFdotz48+FcSaaKiEl5zn7l5rGKpkElUg2NXDPRayABXaoI?=
 =?us-ascii?Q?umS2L/HdBQLiISpsIBN/RE+CdGYCtgn0AgIRUqR5R0d1cEHswWsuNj9gMjh1?=
 =?us-ascii?Q?+a6lbAKUHN7FCZdPIwe00ySMy6fXW7j5dtUMYxzkWtS5fXRxDwjYCnekPlUA?=
 =?us-ascii?Q?OW8177bpUEbwBSxghD0/mobz0voLOv44AumkD7GA9hBQRb1biWnUAIFQQsKV?=
 =?us-ascii?Q?zxGZQU34uLd9pH8da5QRlx8TNKuXwxEO3KWo8LXTZDdjY+oh4insw5L0295k?=
 =?us-ascii?Q?ecAMFz3dCrqUw0zpRPZs0K3hjdEiIvDLxJkR7GNcuM/OcU6TeESDxzJObyby?=
 =?us-ascii?Q?CPvhG1Ato7yFeAcElv+F4/9XepXKuyxgmZA8M47vxMM+X7PiF0P/nTaLhlnw?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ff748d-3e6d-4f8f-709f-08db9df5c0b6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 01:11:43.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oA9Hl+XjgqbmCxR32DoBjGhyjYWp9BgMCcnXcki001rr2ZdTFlexMK8qm4aGmU483CNAnnOeW40lNG/7JYz9zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

v14:
 - Use getsockopt(MPTCP_INFO) to verify mptcp protocol intead of using
nstat command.

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
 net/socket.c                                  |  26 ++-
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 155 +++++++++++++++---
 tools/testing/selftests/bpf/progs/mptcpify.c  |  20 +++
 4 files changed, 196 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

-- 
2.35.3

