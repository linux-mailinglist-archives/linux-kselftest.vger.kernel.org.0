Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CB7767DCC
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 11:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjG2J5b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 05:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjG2J51 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 05:57:27 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F6FDE;
        Sat, 29 Jul 2023 02:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ww09lhaRxyUsIIu71prvvLNs1RLbXpio5FKSV8S9IBhPa1bR+wD2PKqUp5A4QiSvcOdyy0B+fajVHsAlOjjq8d9pYqZmLt6OQleRvUr4TZ/MhhUsWrUTnQh6ot6HSy9/1wC0zivT1RFhfi8GGXXhhLlbmRXVvPm5KlJRAbIfnKB+C8og5H3bLGwayUDcE34P1ZsWTcQoWJDPBss1FLne7E/Qlpz1uOLFxsVpI69hfnOnY/z30BtXS43jvxssktqi5KgfqGBUUjaqysLoOLIZHZjPGwtdYmEAyCfBu6IaSlSE4fHbeDJO8fjDPAZb54g+ssL33olqf8cFImdZ7drBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/J/yVO7GTFTHpVOQN9Au+19+9A7oXpuoFwB6tLUyzAQ=;
 b=MUId7YX0VPrURRiLeTNjuCPpmLmfFdX2u+WzLNjSCNrjOnp/whG/TyyyH28TtD1Zmd/oKxJVtagMriMMp/mJu/UatHjnDxOVg77zA3rQMLdZTFSTdlVZ7ehHozoFnEtrhYlvtjQCe2+MGh3Pmlw57lUGDxHPN7qgP7u2GBNVnH7z8KRgnycWxG5XnZtjxy0c5Hs0tdXAYsN19zeBZlqTt6NZvQvCP2HeECQilqpWsTplk8ER+H5TSHLWZcQDeTOWRiofKBtI792S9x6k1Aq8MJuXd7LQ3/kc4K3aUHxur7vK1SVMu9yjbl+Jbgypj0W/ISOfOYZq40SKHAdv8NPAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J/yVO7GTFTHpVOQN9Au+19+9A7oXpuoFwB6tLUyzAQ=;
 b=ilouPOfBAxdpTRBgsoSkoha0VTdslqPZcq/NzyWmRxt3vXL67AWsQEnKgOL8Ux9oOVSeD3kCgJ7Tj8RiijHIKP/9XaHW58zxkN0HV/vbk1AbeoJkPxToFULQqI6dJ6SKd0YMFeUmUpQPAuPlJMAyRxGEAN0F+fVpUdVrEXwP9PV+p3mC+ncPBaCTW6TxZgFUCNrMWxYFDHpCdlhw00S29w++S3PFtXJ5PGFikrprY/4p6LfKUMW5hK2gzD1mm6gxL+P0ILlfTkTUc9o3w4DZXJk8qOUba1qz10ieFNjweaQ8NMzAkY/UN5WYRHEXpTZ/nb72dVnx2GxECo8j0K4r0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9733.eurprd04.prod.outlook.com (2603:10a6:150:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 09:57:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 09:57:19 +0000
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
Subject: [RFC bpf-next v7 0/6] bpf: Force to MPTCP
Date:   Sat, 29 Jul 2023 17:57:21 +0800
Message-Id: <cover.1690624340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0105.apcprd02.prod.outlook.com
 (2603:1096:4:92::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 54fe800b-5459-4069-2909-08db901a322b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33BC9xxfFtUgI9qWuCVdX7njJNHi22cGGVUq5ScA1b8rWu5k19A6MJu32BJUW2izC83iNa5ngjp+zhjsIoUCTKgwMdMzdTpY8qNC494zrn5gbpts6fhmMi+t8w3o/YcV34+jBrQzUerpVoIuDyXlUCPe9YVnu7xoytCiYtWL2ELCHygZbn61Q9E56oDkdPDFRQuJhO453vEVrDQXtpy9Ran4hMhNKnQn6jteTb3p4fk3LbDDna85xOeVWZfD90dMTAvsExJjhDhjAiWa0qXRihDxoeF3elERQogs1MGmpLVD0cKEh1QKdKbtScpLR2mXbK+o3/cwyuacsiXscihDBkmviJsaf7/xrU2OnOSWEBNpkWQbH/jcoyU8CfII+kSDJfyXidJ5PV40u+7plHW33dYPzUXTVv5H2yMZ5YN933FJHqyNt4OjL/n1P6N84ulrhkVz7Urg5uVBEXggmEFlReB6r5App+yGQANsZavkQ80dgYGnc5lykbHdGf6YuEqBGFHrNtZIs4N5Z/Ood9rRV/cSPOn0Vq6cMu1EbPZkAtWe2+rrI06RtcqdNLcuuXtCBzOGlIFGQbrb55G8XIl0IGxiY6XoAatrBa8W8qtDsh/OBQkmZPn2UD2AMxMYUwJR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(316002)(8676002)(110136005)(478600001)(38100700002)(66556008)(921005)(86362001)(5660300002)(4326008)(66946007)(66476007)(966005)(6486002)(6512007)(6666004)(186003)(6506007)(26005)(7416002)(7406005)(8936002)(2906002)(41300700001)(44832011)(2616005)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s/ZqYu47HuTc8NCwkJdUJxx9vDvTYbiEmaVWUYOBruZq3LO8QUFHW6SJwLA8?=
 =?us-ascii?Q?LOyO/GKmTJRlSiUluxyywBD8GvIAr2SULI59qp/DHjsyOSxtM8+YzGxLU/Tj?=
 =?us-ascii?Q?tboafSBwJDhW0C/rYyD7oKOuSBQmCSZIxo4LHIwRiVUfOWZLZs0i/bisWFKd?=
 =?us-ascii?Q?qFtlg/va19X2peOU4D+XUa6hlGfzK0lMQ5p5duMtFOn5/EFVinK0qMQd8pT0?=
 =?us-ascii?Q?9bwqqQH1mrcQLHsWvbzMT07Zz3lc/e7S4jBJyRNKzWEKwnD3HU5q5BlEtwnH?=
 =?us-ascii?Q?n4uAzz5vlS1DN8QISgIYdIkC/qhvzdsMmapQHtFv+HK0KmxX5RlMfnj1fXVD?=
 =?us-ascii?Q?VIeuh4gTieFj/+o1zTOqNweMhhkda/CoefT5zjyzj80/vht4Vsp6XGoPPPP4?=
 =?us-ascii?Q?c73GcqBXSDGynwaEyC/xoM6RnxybY88lTtxPUuktmj1euEBJRX7DFoSd69P/?=
 =?us-ascii?Q?bkP6XPU7ctZF3WVro+ic9D7LMsftt5Bn3oV7dZKvU4+QgN14XwNeCQa7CANb?=
 =?us-ascii?Q?tlCkCX+UEivEZTYQp4k/6j/ttcT2/sUHFR5OCaURb8u0FQ5heDgPEa1hzQb0?=
 =?us-ascii?Q?04t9x6svCmJOv8+5lQvYHAkpbuEQ0ljobr/SzodiLvWPDRIeLX++/7F+KJv4?=
 =?us-ascii?Q?Nj869jIq/Yt6NJf0ElG80HxDbPcN4jQ7iRCTrBD8X8aEFW1ZzyXy7eULgyVu?=
 =?us-ascii?Q?p+we6gCw6w5wr/0Vj7C4sdT2g0cP7n5OOh9XPDMmx+YsELcNpNzIuDypXgwJ?=
 =?us-ascii?Q?IfztTpOrGHplsAFxsj/sfnTFRC5hKPEIqqH+Q1xsvgL48a2/b4U/8QjTJaq5?=
 =?us-ascii?Q?NcvFrhF2mfaimFwiy8m/OzArb7MTw3SJ3CKTD1O/dOaZmd6mv0GdH7jeZMxM?=
 =?us-ascii?Q?0G38L46kY62CmE9SmTt9FFKU9fLJbRDjAiE8NuulZ6XcUsKroChXxfAICeFW?=
 =?us-ascii?Q?wQMgMZsG3Xu/4DY9o606GzFC7at+24rGeMKt1d2KC1of33hsY5u5Pqgds93D?=
 =?us-ascii?Q?X4Po2jWjdQ0vb1UYmMDc+niEMMI/7o1c9MUbWSEXA3Fe8+XxaYSo5sIesKGb?=
 =?us-ascii?Q?2reBZOclb7sinSZARjgvEr0zGSYrXy52wiKbEeO66rIMtKzPbjp5LQ9M5MU6?=
 =?us-ascii?Q?jsDVMFg27xPCaOqig2OBPppzpJvmJsRweqscgNVVv00kVvOG9i0+AtaPKLyS?=
 =?us-ascii?Q?6hx18Ewhr3R/5r21NcZ6fkfV9JFeAGlLMo2kQoIAC4JZ7eJYISxaj/tUI5c9?=
 =?us-ascii?Q?ZEd+xCPKt7tv4sUkvPrcj36bXoiV0NwuEZLtrsiKD2caYn/TDXJz+9FzPDFh?=
 =?us-ascii?Q?2udH5OCsoTcHmS1brkTFxo/9u11IzIK2QUdO8lH5Cima41tMBgMbrFjf/KpS?=
 =?us-ascii?Q?f7B9E6TqmWAH3cm3dFDb4RI9m3DYcKAq9fLBxchMxVuziDoALSNCm2w5MG9r?=
 =?us-ascii?Q?bm4BaSvyeBALBl0UV3GD8/xxtU1piR+KGEAz91QuV/frfCtrNZdHCRfpufET?=
 =?us-ascii?Q?X8MwOx+GGzuwrzg5/ySXmfW0dJZZ1DSLcWCYB4rkb4i/1iYJiFzKwXep+gFw?=
 =?us-ascii?Q?ZqAkfcEsEBz3861ZCu6FNplnyZF9wx2nklae8asj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fe800b-5459-4069-2909-08db901a322b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 09:57:19.2777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ab9iTjr7zhoeuNqF0HHf97G1Dx8q0GJ1za6RTieR2JFV/Y1BLpm3c/JRVlMqaePFNSCZr/NnbJ5B+PWTjklpTg==
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

Geliang Tang (6):
  net: socket: add update_socket_protocol hook
  bpf: Register mptcp modret set
  selftests/bpf: Add mptcpify program
  selftests/bpf: use random netns name for mptcp
  selftests/bpf: add two mptcp netns helpers
  selftests/bpf: Add mptcpify selftest

 net/mptcp/bpf.c                               |  17 +++
 net/socket.c                                  |  26 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 125 ++++++++++++++++--
 tools/testing/selftests/bpf/progs/mptcpify.c  |  25 ++++
 4 files changed, 184 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

-- 
2.35.3

