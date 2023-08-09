Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3597754F7
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 10:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjHIITp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 04:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjHIITm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 04:19:42 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2065.outbound.protection.outlook.com [40.107.6.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE131FCD;
        Wed,  9 Aug 2023 01:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvlDpwGa6d1Ykg9DiSPPVpn3j7gwEkS3kPlmvGBHWCSuyFkUY8ecNcNzMw3L1MS69516N3mPAr+Kii7NltpheHnufeyeuokN6wbs/x3ugtSFpUe/lH2VMIncn7BWRL/iJW7rn0d/n0yo2FqeK8Ah9MVy5rDqWaHys6A3FpN6GWb3SXM+RLP1RxUtUWasaQ6aISIU+gDNaOAgYrPdCXJkJ+wmLzy+LRMLIOE6zcqoMogMAirxig+b0qOUPewAnMvk6Sz3cxuSP1DnV/uac29R5O9iIQVGlC4FGuDIJSvn1O2/x8oxnIhc8uUTIvoexx9PmEBk05RnDWGTRPT7VOEHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Lo/RD4XswqmNePe8PqD+/jsdunDBnXj7mvA38u9Mts=;
 b=X1sJiAMb2CgCygp+JwqMYkMqWrNFbpCe4B3vPE7/5UY9ZzDELVNjYTXqx72Dq1myUYbAEkuAXz3UQ5PgNenvkW/w7vhqHd4tDjKfXrmGv2zPO2RBMqmd2fN5bYfwxWYlRLQSN0Ik92ColbwHJnmldw8zzQDi1bpl/kg18iVnWM1OuqcBfjNnjKUxXWM4oERUMP8/XRWo/QzST4QipD8TBT1zfPc/B50tVO/HJ6mwxbCgS1MxeqxQoe3766Nlp+fEXbDXWm0uTZlI6GUedPBv83WNb87vuWMmvtu2TCiBVDLIN3hZr2OeSrl5J+5av3hKlwSQazMFdz9h1ghzXv0tqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Lo/RD4XswqmNePe8PqD+/jsdunDBnXj7mvA38u9Mts=;
 b=siZLzsUiL9RO/lu1dxrjUPgOQPDND5kYW+Nxkc7OgSP7FfEKaWfN20ZlweZzFxjV44DSJjTT32+7TsRX8mVkiRC5UrsgSxZg/dYLf9MpmQyAHtFH9WB7+wvac2Uv3PC0PerofEvxrxtgJWpVIYBK7yzNu8b0ZHSgGbI1U0jvl/JSHvmWET0zUjKRVSUDuKYpD9jUwW5eDfPHTmJKzB6sXYyX04U2GGmMqE0iHcwaVHjA25l5ftYo2RiGBEdNI3zkkLxOq0p9MIOrDmI61QPciugVWFuLAaZ2XOw4KvgJcbBUPOK89H+NvE8NMCCi4467GUzOKocdrzADri/AyiJhVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB9205.eurprd04.prod.outlook.com (2603:10a6:20b:44c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 08:19:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 08:19:28 +0000
Date:   Wed, 9 Aug 2023 16:19:44 +0800
From:   Geliang Tang <geliang.tang@suse.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
        Simon Horman <horms@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v11 2/5] selftests/bpf: Use random netns name
 for mptcp
Message-ID: <20230809081944.GA29707@bogon>
References: <cover.1691125344.git.geliang.tang@suse.com>
 <15d7646940fcbb8477b1be1aa11a5d5485d10b48.1691125344.git.geliang.tang@suse.com>
 <8b706f66-2afa-b3d0-a13a-11f1ffb452fe@linux.dev>
 <20230807064044.GA11180@localhost.localdomain>
 <9a84e026-402d-b6d9-b6d1-57d91455da47@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a84e026-402d-b6d9-b6d1-57d91455da47@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: ad76a832-76d1-4352-07d4-08db98b1596d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: THg4+BUNHYdhCgco002LMrCm53/y5SQPIzh/klQBgFvad+6eZZSNTCxHerZd9WAiLU/+YgW/pQ7gVm+UKKzZkPZqGQHoWWDHUbk7A67KHFd8+womQ//JiEoBa1qIMamPTBNLaYTH7+lF/DauwCjwDyLpBGIA4oQ1PttJLPhTiJ4XL++6+adHVwNuN6GyL31YDMESvu4YB+X/AHPUYMWqGz6tiL5J6WrmRlyNkG76fXdl9gilh0MGZR80WGsUNLYdryWN0U4Te9NrNl10QyF0N/VWLvhYLDLm6zBwdvq1tT4/O4onUPq8q5N+XrOJ+nSpPeFsa38x2n1WDVPOiMH7Zgp8v4qd18Ne8qUJv+iA7hBYgRJrJvVtg/fkf36iDXDV19X1J+g1utFa33OeKjYlA1k8TWH290ltt/3sWouqAFjuTk6HzTee0mlHRNqx+q4HEIWM6lDbb4VxYoOw/vvZ42NqPxnhdGT12lp0HZuIUYz8W01u/H2J8YFNtZp9ZvuY9TwXs98W6IyayMz/I58jnWeVDXotjO4cglfu0wTJdM9ycLghl5Cgqzq3rVH2j/46IAoCeBiZWQsy5KIzaaAMYfNwlRyplyiyPGTSuf3/4Tvl822KHYHLeHwlJ3Hj3XPl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(136003)(366004)(346002)(376002)(186006)(451199021)(1800799006)(6666004)(6486002)(478600001)(83380400001)(1076003)(6506007)(53546011)(9686003)(6512007)(26005)(966005)(6916009)(66556008)(66946007)(4326008)(66476007)(38100700002)(54906003)(5660300002)(8676002)(8936002)(33716001)(41300700001)(66899021)(7416002)(44832011)(7406005)(316002)(2906002)(86362001)(33656002)(13296009)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fOQL3NVqGvZb07AesveQgYNzyQMq4wY0q2mkLC1KQUQZc7zvw955v7xGxvsF?=
 =?us-ascii?Q?H4jICbY170cqsaWZk+Uc83toMcDUf5CXUuib+70N4hftFbkTPYD6+u8IaXp+?=
 =?us-ascii?Q?MpaEpaosDe1eds4zUeEHzRQTTO8F38KLiCa7yEsq2JxjSutci7aYWEHlV+as?=
 =?us-ascii?Q?UcUUQfHgv+MXpFMu3MgCXKTE21PEcah4Bl2ajjECOlIay3zuOy1Uy5iQgpzm?=
 =?us-ascii?Q?BFqRw1s24JsZT7DxzCCFeayH9gmRh6aW6bOprxfj+SeIa2ybovjIlj2M8T2Z?=
 =?us-ascii?Q?zSlCO0GVF8MKdiH8C7dQ8NtsaMK9yM2aXv+79y33Ko1rKeTJMJkzvtcKZVRv?=
 =?us-ascii?Q?Wx0G0iv+1SptNggRfGwIhL+RAGJpb1rtzVUJAXPcjaoydXXS3DXT/336f0AL?=
 =?us-ascii?Q?ijcPinhctgc4ZKHaIypUzp6eWLcBW7UYOG/RmDksTlvJ5hobbPl4EnBgKU3Q?=
 =?us-ascii?Q?P4UtC2Eo00bB9Emcqg10QhA9k6qF+rDwUCAJP259DZfyQlZiTtAIejrW2qNb?=
 =?us-ascii?Q?szjYjN63MjBA8ogoI7cwQOjFBebEuUQTrS3Wvp1nVa1NYRMqPplAUek0ExOf?=
 =?us-ascii?Q?lA579CWDJMQO1oz5t4Mqnk7EWd8lEclfqsBMTWMAhFCbfSxTowEqmNLctPxm?=
 =?us-ascii?Q?ZSJFzDJUl96lTkX+8Gm2Q7m4xurRbeVUTTP6lFqvcsWweyFMv3QecR3oNdO2?=
 =?us-ascii?Q?bJT+BjL8QdFlYlcdF1z9K85yNE713amEmr+RDKrR2+zVc5rv3pi9neo81qoB?=
 =?us-ascii?Q?GKzctQZLTdDEqPYcSZDSvwblbQQ8+U4u/wOf67f5Hsztn22QhS1t3Bwi4MHJ?=
 =?us-ascii?Q?fkAW5TRBjScTLNolBXN+6nH7KAoVItRTrjK+5bZas6eg7NpJj1XbcfOiSDcb?=
 =?us-ascii?Q?pwZ1NHAEuEFVB7J8zlYKxP2Mp3EvmE/9P/2sXDxuvQdXn3w4tzFVPujQuoI6?=
 =?us-ascii?Q?0Jq5pXxxvibLPu8zrgJirluiGLCWp3zi7rViuYtnqUUB3p7idaEUXOIG9IhH?=
 =?us-ascii?Q?6jgQAXeg9uDrYo0DtBWa2gPiIUef1D6oYVxFaUiUStS0DnKJq+ctEFy2q/dy?=
 =?us-ascii?Q?uIsHbyr6ScE4gjzbHlnd97iGzjUAmIJH/s8UtXAAv4Hp6GVWAAWBiRj791he?=
 =?us-ascii?Q?XxqeZjdmN944BGYK/tgDESPKLabEqrfB0X6I79RkZbDXR1E/vcedxL+C7qYZ?=
 =?us-ascii?Q?Y0QuC0k5trcV96NLw2HugwHKIlVJHLMDxTj5fp5HUT8imyL9dbpN7GIJ3ku9?=
 =?us-ascii?Q?LWmsVP1stBpM82bXnNwF4fK8MsuYzKpgUkdZPm0uC7uL7JpmUpEluSeSmMcg?=
 =?us-ascii?Q?t3HMQiK14OspgSrGacAehZOqpjJm9b8Arhr2va+3eAmgoeynGlowLFDwAJkG?=
 =?us-ascii?Q?DkUUIfGPbILvpFyOE56pTI94Bn4GhHAWdgxqJKyYx8m2x+bHZSkNk6JR55Oh?=
 =?us-ascii?Q?F/tZSsnEX4r9vOiOHAfUODUgaNDCdw/hxdNiDl49XqMuDCxRtWl7vinMX6E5?=
 =?us-ascii?Q?38MAg8HIogKs5o3bAKU1O4nZYDOjeIvb3oaMkUzDmveWuEPUMqSO7WHPTDqo?=
 =?us-ascii?Q?Zor0kl07p4p9tiW2RT9KJOH2APIspxJsVN48OY3P?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad76a832-76d1-4352-07d4-08db98b1596d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 08:19:28.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uBv9Zptjh6Qykqn1V4dcUMfJGp7LaMLJOf8v0omwYHRm8zp/ud7WE2uE8tkVmVEHdJoltYpyki7o88x/pxB5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 08, 2023 at 11:03:30PM -0700, Martin KaFai Lau wrote:
> On 8/6/23 11:40 PM, Geliang Tang wrote:
> > On Fri, Aug 04, 2023 at 05:23:32PM -0700, Martin KaFai Lau wrote:
> > > On 8/3/23 10:07 PM, Geliang Tang wrote:
> > > > Use rand() to generate a random netns name instead of using the fixed
> > > > name "mptcp_ns" for every test.
> > > > 
> > > > By doing that, we can re-launch the test even if there was an issue
> > > > removing the previous netns or if by accident, a netns with this generic
> > > > name already existed on the system.
> > > > 
> > > > Note that using a different name each will also help adding more
> > > > subtests in future commits.
> > 
> > Hi Martin,
> > 
> > I tried to run mptcp tests simultaneously, and got "Cannot create
> > namespace file "/var/run/netns/mptcp_ns": File exists" errors sometimes.
> > So I add this patch to fix it.
> > 
> > It's easy to reproduce, just run this commands in multiple terminals:
> >   > for i in `seq 1 100`; do sudo ./test_progs -t mptcp; done
> 
> Not only the "-t mptcp" test. Other tests in test_progs also don't support
> running parallel in multiple terminals. Does it really help to test the bpf
> part of the prog_tests/mptcp.c test by running like this? If it wants to
> exercise the other mptcp networking specific code like this, a separate
> mptcp test is needed outside of test_progs and it won't be run in the bpf
> CI.
> 
> If you agree, can you please avoid introducing unnecessary randomness to the
> test_progs where bpf CI and most users don't run in this way?

Thanks Martin. Sure, I agree. Let's drop this patch.

> 
> Also, please don't resend the patches too fast until the discussion is
> concluded. Please give reasonable time for others to reply.

Sure. Please give me a clear reminder next time that it's time to resend
a new version of the patches.

> 
> I have a high level question. In LPC 2022
> (https://lpc.events/event/16/contributions/1354/), I recall there was idea
> in using bpf to make other mptcp decision/policy. Any thought and progress
> on this? This set which only uses bpf to change the protocol feels like an
> incomplete solution.

We are implementing MPTCP packet scheduler using BPF. Patches aren't
sent to BPF mail list yet, only temporarily on our mptcp repo[1].

Here are the patches:

 selftests/bpf: Add bpf_burst test
 selftests/bpf: Add bpf_burst scheduler
 bpf: Export more bpf_burst related functions
 selftests/bpf: Add bpf_red test
 selftests/bpf: Add bpf_red scheduler
 selftests/bpf: Add bpf_rr test
 selftests/bpf: Add bpf_rr scheduler
 selftests/bpf: Add bpf_bkup test
 selftests/bpf: Add bpf_bkup scheduler
 selftests/bpf: Add bpf_first test
 selftests/bpf: Add bpf_first scheduler
 selftests/bpf: Add bpf scheduler test
 selftests/bpf: add two mptcp netns helpers
 selftests/bpf: use random netns name for mptcp
 selftests/bpf: Add mptcp sched structs
 bpf: Add bpf_mptcp_sched_kfunc_set
 bpf: Add bpf_mptcp_sched_ops

If you could take a look at these patches in advance, I would greatly
appreciate it. Any feedback is welcome.

[1]
https://github.com/multipath-tcp/mptcp_net-next.git

-Geliang

> 
