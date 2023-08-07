Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA6F771A90
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 08:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjHGGkr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 02:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjHGGkk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 02:40:40 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0E71735;
        Sun,  6 Aug 2023 23:40:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4fnI/+HF5/NaoLEfBrLlhNvk+9FdDxec2p7aSbG0FSSZ6IRkKMe158jsWRHCTFtetlNusAZecJLjubBtBw8AVMaZ8rK0q3NRnxOduNgMnSRmRWi8BwL5nzIpqE1hGN1/a6m5OMFcOrQWALN3xJapkhE1hkrEhN4LgsB/Qii+JlRZh2JfGYrfctnm3NlOwD0YVgOMkmlpbv2xS4G3o6O5qDcKukkGjUDtYFnlVlz81aGxJ174vjJeu5nf9ZxsGcFO7uwLSzqUg6JKs0HysWkON+/X6Jamq2Cc+QlfFid1jvheVEyRqQFGd5o+Vc84jNDUhz9BV7i1NtVc6rI/sMXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91LvCAz0v9un/ZvlpuBytJaFlxBmo6bbLsI8aHbToaU=;
 b=aDg7g8nvNXkONn2sTjSNMD5ctIuEpjLXH+KNzyJvYKouXG0hulaHZ/xa+qpkZEY85ZkSf1t77ZBu4//uJohKzFRdyS7r+zBN7IpPkm9zYaKq0Ixd0kzHFpYc+FcjguGBaYl4lr8smAFSejdrqjgNv3B70aAWV6uwAFJt57FA79Q5kXzUsqajz1FUzitnwOfZ4LwwuqbaQmezr4MyXyTwzpA/1kB0PCbIT5S6zCRxf8k0rTUaHSJNYvLr+gM59oMmPCUImsN2yPXKrpsqtE/uSeNTuX62+YiRDXdEgY0RKY6mY7PGCFXZNnILfaND+5OOj5X6RXNws5tthnDqq7qwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91LvCAz0v9un/ZvlpuBytJaFlxBmo6bbLsI8aHbToaU=;
 b=P7+eyk8G2/AHs72cjitVDLbLlk5VJeXiyaghcx4488ywNRbqkPT7ujlcDUNLYeKJHKcU1Jo6gzz+LDcELfqckTLdRlO5kQRkIPfUrQf9U9xn1556eO8PUnxNzMQkxAlX1sWPdHl6KHFPYhBWsDq2/egA0HqqL9DntulwvkwsJPMyINMUVjckyxdj7u+InFPcgoH0eqe1wCuA1gTXBu7zA66PJidJkGbjURjoOYyOo8HuYHXt97YwJqqZCRq3VGshqA6pD+rken1fcYe+KNfBQvDvqgyuw9Wg1AwC6+YJuQ3x2BIquPE4ENkeOU9OxBVif15Ssh2NHKMgIf1vpkfu4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7763.eurprd04.prod.outlook.com (2603:10a6:20b:246::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 06:40:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 06:40:31 +0000
Date:   Mon, 7 Aug 2023 14:40:44 +0800
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
Message-ID: <20230807064044.GA11180@localhost.localdomain>
References: <cover.1691125344.git.geliang.tang@suse.com>
 <15d7646940fcbb8477b1be1aa11a5d5485d10b48.1691125344.git.geliang.tang@suse.com>
 <8b706f66-2afa-b3d0-a13a-11f1ffb452fe@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b706f66-2afa-b3d0-a13a-11f1ffb452fe@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1e8c98-6570-49ae-3b50-08db971131fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGmS76Sm9kCbmQq9zO6cTZLnDbIQS/y+rQIWMu/u+2QKjOtyQ3Mv1/IJr5VxjqkIlNlJ5nh1ILsJXBGfs+91fUCahjK/W2d/qDq43ptwUebCefEFlOSHZykQPgDUpEhx6Rwk6FqXuuXjZ0UkKWxudsS/ru8c4vY7PbtAdPkTTFDaG7mUzxjXou811LB+VUBPGhDlZ7q+vqyY5pBC7rOGmk/R0/VYJKZ3n49GlZgeTiJoATvxjTbPJmStWYP2xU7iiOV1imaKnY6MUyk2HD4oGJxqKlCQvOc3vpa4p3LJmw78Sbai6I8H0vfwpdOwCuFKEVAVNNa+42LlCFu7LVI7z8qHDG05yVW7MpPwK3guPKA70degmbWXF5kJCTbonOgD8CKqvuDdMK22nMaA90Ce50mPiOOSUTUjhumUj9rR6kFU6eeQuSPMj9ny0MSTsp+vRqwFzCROhNnO3NIp3ZLYmX+zMGseaOJnMD+gwepe8pj3pBOvVckJds4ovfhZ4BJ7P02zh9jhAsuvcvLpcywqv04nhuWX+PFJka5R+LwMhzNVvpdicdUHeQFZvs62z0RGFDziybuBPvl9PyadHWgeTYLAtDp0wvIrHjcKFwCFLmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(186006)(1800799003)(9686003)(6512007)(4326008)(316002)(86362001)(6916009)(478600001)(54906003)(38100700002)(66946007)(6666004)(6486002)(66476007)(66556008)(33656002)(53546011)(6506007)(41300700001)(1076003)(26005)(8676002)(8936002)(2906002)(83380400001)(7406005)(7416002)(5660300002)(44832011)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/XudbASiPau38uTYEJf3Zv4EfqzYhpuK4vIonI+D42/JkrCtErZK2N8oExYT?=
 =?us-ascii?Q?DE3L/ZsN36i7dlDBtqoQthwv8oeIMBY2YbLimp7cNJkUiJrwM0wPi1mlcyxY?=
 =?us-ascii?Q?mtLPwO5Gx3V4QC44n5jS8R4wcQglE+JVCri0Ku+xYPyFGHRMQ68MfWqe/Spd?=
 =?us-ascii?Q?OzYofFioHtUj770hyqkfGTeTzmKQ2ZbqAhwljUNDvNWDmXMXshhWhVBPqaZu?=
 =?us-ascii?Q?+8WByrq3iLygvEmD08KwAq5i97go+6leWj5IPBMWqNH6R6h1iF1rPAjlHoyb?=
 =?us-ascii?Q?v3Mjja2IthhIG7TcDTs4+IZkPg+ubuQobvylP1JpWutuxLrY1afnUIA2cVYa?=
 =?us-ascii?Q?DW81Vvq3NrhTz/DmIV13IuO5Lz5/p0LFs+nq2SaGgfc81QSHHDTDRY/DVK/P?=
 =?us-ascii?Q?hja6/KToa1y6RAFtNyDlQuIeAoihzdZFgoCYwOpnJotBS9ipQL2Uw+3G3NcU?=
 =?us-ascii?Q?fNcAOH3+i0tRWaCerC0YIs2AwUBN095PT6f4vnFbijeh4yrBwW0hXXP1yy+o?=
 =?us-ascii?Q?pORj5cQqwzr1ON02sbAqb+81zvQCXKxVK0uq2ZZ8WVh9k2qhrnQ8KucrIQ/b?=
 =?us-ascii?Q?YFKg1JJrrrMPTYSl/68/BdEZMh+Sa2rwRMa66jjZTUaNiBrZQeCAvDhjMGtC?=
 =?us-ascii?Q?+sm+/alSdmntrlG0wgKJbdIf5O3XwvXw+6k/LMm8sSdcA0+6/J4Lnw0XykMj?=
 =?us-ascii?Q?3DDXjO4pZDjLRA/g9xWGo1vHsJoLCRBmtGgXJkI6WwLxv0RJ5NueEa2Ho7oR?=
 =?us-ascii?Q?a29tiJ07fWafWzydAszuCIzB1e8tcqSaPyBvzn6TiEh8lxF9TENSQXXbS1dq?=
 =?us-ascii?Q?XquTumYTvHrgYSGyytyBcwoeai2hDCg4CislMflQA3RFx4oIrtYapXw2+6vM?=
 =?us-ascii?Q?wP6bx2/nP0alR7R9JIXSb94mf8xkwSbDfHO4uq077uydEn7tUZCza7yd2wOU?=
 =?us-ascii?Q?HyxBT8PC6Bn47lnZXkUG/5yfU1cXw/V4JP5KC22+4E2etAGAgYfBwb8ldSzy?=
 =?us-ascii?Q?nIffRup3svOdBAiCpduO4rTLhIwWz/YshM3gRzMKqxwZKMPTJjjycWgH7Obo?=
 =?us-ascii?Q?6mIkt4BOJ3T/xkVXC1g1leXQuY+tIQf+JPlU7PJfk9P/fooZNBsEFPXZbAPs?=
 =?us-ascii?Q?caUE79PwhAsSvJrfXjnAMPCp90VSLMIElM8klb+J5ck4dEb6ORsrnyf66kOE?=
 =?us-ascii?Q?8NfM7c6iQE5lhBth0X08NbPAMCTb8EmSGadytq7atRXoROaAioRupnZLR3kM?=
 =?us-ascii?Q?/025XjTIO5qPQVMCdRXtzq54KFr955IhKrfe302bmg3+ENKyHZq4I8Kbdwdk?=
 =?us-ascii?Q?HzKU9CKdtK6wWk8Z4InW74jdKKL7EJDuD4UkZHxVCayYc0Pl5lc9Wt6XLh3u?=
 =?us-ascii?Q?pR+RFxQSFhoodjnnI+ADR4MKRudov6dS6UGVtwXOcwKADXg/5br5sYoFg7JM?=
 =?us-ascii?Q?boZE7c5TINIoZOEPE/HZsqXiomVy+R6ak0AHq08TRkSG1luG5UAbsZN79Lcc?=
 =?us-ascii?Q?xeAnms6qxRuY3ha1w9q/JHkxN7tPi897bCTeCNHZJLMyIHKRmgGIGfeQHmA4?=
 =?us-ascii?Q?FXKgFOxofnR1Ii0B+CU/GCL9r539o6To8mb/LM24?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1e8c98-6570-49ae-3b50-08db971131fe
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 06:40:31.3951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29GH0/L7XD+RvxOuyynNLvPEatSXDSPkDYPlKu3sevPlS38/z0On/UdxxpBQrtMtTswwGG1Rch3jdI0pUvg27Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7763
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 04, 2023 at 05:23:32PM -0700, Martin KaFai Lau wrote:
> On 8/3/23 10:07 PM, Geliang Tang wrote:
> > Use rand() to generate a random netns name instead of using the fixed
> > name "mptcp_ns" for every test.
> > 
> > By doing that, we can re-launch the test even if there was an issue
> > removing the previous netns or if by accident, a netns with this generic
> > name already existed on the system.
> > 
> > Note that using a different name each will also help adding more
> > subtests in future commits.

Hi Martin,

I tried to run mptcp tests simultaneously, and got "Cannot create
namespace file "/var/run/netns/mptcp_ns": File exists" errors sometimes.
So I add this patch to fix it.

It's easy to reproduce, just run this commands in multiple terminals:
 > for i in `seq 1 100`; do sudo ./test_progs -t mptcp; done

> 
> I run test_progs repeatedly without rebooting qemu to save time. If there is
> a test did not clean up its netns, I would rather uncover it earlier and fix
> it instead. Randomizing the name is hiding the issue and does not help to
> uncover the broken test sooner. Although this change is to mptcp test alone,
> this could be referred in other future tests.

I added "ip netns show" after "ip netns del" in v12 to check if there is
a test did not clean up its netns.

Thanks,
-Geliang

> 
> afaik, I don't remember bpf CI ever run into a test failure because the
> picked name had already been used by the system. It seems you ran into this
> issue a lot with the mptcp test in your setup. Could you explain a little
> more?
