Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32E476F7CE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 04:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjHDCZH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 22:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjHDCYz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 22:24:55 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD862130;
        Thu,  3 Aug 2023 19:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWV8VHR2Ou30CDrhYMWMkMui57FX9o7uCUyRJCsTcn68S8QVZ9zlNJmRG+JA1OSagrrepV45cjbE8E82BIeGu6gGoPxa1dY1hlFAlC/bbp9u1GH95hbl+5kiBv0ZPnkwHStbYZqhj0IBbp2QmT8b14xCrzW9f4NLXenys3aJ6NNI2lPS7t96esoaN61alojMrwM5UqEZVEyrqc0ZIYXyzfhTRBry9IWBQ5WrqNisGJaueqwBkNhH/RAkEMUo9vJtSFD71DO/SHSh5VErnvnBxpe0P5kupVt5yCbH8AC9RSCJxR8lo6kOd+5gUsc2yDdxjvI+9PLwO+9gWnDUKMrmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fm1jzY4HxxL2rnalmJXLZHi5edPPOjUHyGaGnSAE/Jw=;
 b=Rp9P2FF7eTGIQYSwgUFZ+uZZXe8g4JkGZFLhtdNAzsaWxI9+htlm+4C6v43Lu+AL/4ahqMXGkOD7Ce7MLx48lyZFWtZpYsHy8g1EOx01bQSx5fAC6hzYOLBsd+2818X7mpM52EHlRGvzQ2eKKfy9zFwdHQ6YWu89NUX1WAvD22H8ZeCeSfezkNEFkSNdgS6jsbET1bZn7RYHEIJRZpnG4vDzbLh+JVYWfQZmRPMUlJYT3c6cJW10J/mBQqdRqAJY19XWkIIko3BYSiZy19G6pbE6uV//r3nb7aNiqzGkSc151nAm3GQhYMyKU0/RqFYYJwBM0kB4HOc4TzM4pJ+vqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fm1jzY4HxxL2rnalmJXLZHi5edPPOjUHyGaGnSAE/Jw=;
 b=3ha4WfE20oB1BhNEqbqM3i2lxtonrbtrZJQqd/f4nmWeQkqISdaQVvLcXyDq+JsZVlXE4IvFSmSrj17qe+1/l/g77pt15oALULTUcrSFZl5h8OH12tX4yE3O5SOoQ7KBQqkpdrPrQYgx1wkCktLEmTUuyvnocwT/TJkS2x0fWOhjEecdxiqctdT4/q0+MJ+FlvFcbKeqEw6TEfzzgZIW9fulmIvmlMf3A/P/WZEONJ3tcguIICg+J/213X133+0etoWfniPA2tomsWZgLJyCJO7u2o3Bhu2MSRWP7wYkz+3MefXzyuGoO+igQ3zseP30wh9uzYKCIVWOxFxeH1ifjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7632.eurprd04.prod.outlook.com (2603:10a6:102:e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 02:24:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 02:24:47 +0000
Date:   Fri, 4 Aug 2023 10:24:59 +0800
From:   Geliang Tang <geliang.tang@suse.com>
To:     Yonghong Song <yonghong.song@linux.dev>
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
Subject: Re: [PATCH bpf-next v9 4/4] selftests/bpf: Add mptcpify test
Message-ID: <20230804022459.GA28296@localhost>
References: <cover.1691069778.git.geliang.tang@suse.com>
 <92ee6be5a465601ff3a2df29b6a517086e87ca3c.1691069778.git.geliang.tang@suse.com>
 <1bf7f5cf-a944-a284-28af-83a6603542fb@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bf7f5cf-a944-a284-28af-83a6603542fb@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5cdb5b-3c1e-434e-3069-08db9491f92b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bkg/B50dGKh9j/hMbOO7vj5/CRkdM+eGLYb3PH8Zy9c5sx6H2u60QuFO+JmBgDCF76bvhmCGJHxbcet7GqSOP3xAMtdWNvcLub9DkVuVQt77DZsMAH82rAr4hLJ9PDxCVNoMFd2W6cIsNyf2nlJuaBFz7C8EQjBH/v4TpYmK/ZMlpBYcfY1WOHvVL3e/jXiNL1/mkGMKM+fJbduKTbHa28Tzoiq5dRGOqkgvkNiVGlVtq7jq1OHEpZ5J+c7tWNBBXZgDu3THTSfVI7nfVWLQ3uXcxOK1V9Oohu+TMLIT8UHi8duvZWlvOmYO8xB8OzMU4x/VmtOLsiwvxH82b/6We/UymBO9snlRmNCQ99G8rs/X39tg1o33YdFNTj3uMZcvUSsfRxqz0hbUkgiHiFKmatkBwcr4/ZMjW+BWurMhlJ1HYTazNbLYyNta5VjVIe5q8ejaIUB6dpmTU2yoS3UMz17KgAAVOpkaq8Qga6cCM2n+XMUyeQ/ehF24ebPHT4wPijNHBcmzhYYmI218nbt+7DRnDL6O2LYTS5KNeK0Zxq7Lkt5mi2GOQzeIk29TBYBKaTleXfPIxe7F7NgGU72v1lKLevlOLMciHCNJpdSHgio=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(1800799003)(186006)(1076003)(53546011)(8676002)(26005)(6506007)(83380400001)(66476007)(2906002)(316002)(4326008)(66946007)(5660300002)(6916009)(66556008)(44832011)(8936002)(7416002)(41300700001)(6666004)(7406005)(6486002)(9686003)(6512007)(478600001)(54906003)(38100700002)(33716001)(33656002)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?onN2daBVL0kIiYI8YzfK94zWLPEazeVTWaFhL2rlTrOG7kG8jVKDnnhboFZ+?=
 =?us-ascii?Q?N53GpEplo4YfFrxdVw+IfGuZLtXSJJWHHtp19mwHqB/fF0zhMbaOBh8ru7vG?=
 =?us-ascii?Q?B4MssmXgISPUUxrYjq8hZQjEu5dH3Ej873yD2YvAFaZU3GcSKa6Wu0iqslZe?=
 =?us-ascii?Q?UD+KYA9atNspPbNyPd8PQVCuDcjblI/JrWwkF5IgFNMYIPMThjro2hhA6I1l?=
 =?us-ascii?Q?nKOd6T06SDAmO8Fm0TakemwndsjDfIShXeRW5K/1GOFXCN9hlSU0qOzNwGSL?=
 =?us-ascii?Q?8WqqOmcJ6761KJVZ2V4sxEdXBuv5+Q7lSIc4IEDWzUqFRpyTEaq9sa7BzA+d?=
 =?us-ascii?Q?+EYi3ieVYpJWMrH9R1jbS6dHzYNlFT3llCnjapDgr/5a6MOf2L2ovCDGkitD?=
 =?us-ascii?Q?+HU51pvhlXhKwvv3OKYUmn8UarokMQXACYwfFde76/jd+9dtfI5dfHV4jq/a?=
 =?us-ascii?Q?oqZBYvQTlAK3cI8gROwqENd0cgMJ/IwmviYFvjJ4/mfbWTbTNmm7D6ARt5JB?=
 =?us-ascii?Q?Aqrn4ZqU0SfkEa3WXaHfFT/8MKBWP1KdIBbo/fieFibbfUhjG9BjHCnJOF5X?=
 =?us-ascii?Q?lbpsFnm5V/7wQwjSXy7YDexDM3D2AcqmtJJ13Lx2E1RF2Nx49+Mi87+a43B8?=
 =?us-ascii?Q?8OAcJR1t0APT6CUunqC+IHo4cQro11mfK/ZgefX5oybAKm8IdBhApHqM15ck?=
 =?us-ascii?Q?9mYF+4eZ8gKQ2HdjJvr3NHcRtdBCihjfKJTRrDVZZf7TojaV7nNgdDsLOpy+?=
 =?us-ascii?Q?qO8fwqb1XDWYSouKQZC8X54WXR8/yk7J3UN2geN4PScqokPgWWlJPCsjfj4/?=
 =?us-ascii?Q?e7tIYjCbguUASh1t3HrvPMAZ1Pm69t7m793TCAn85OjXqeFGHsZLgOv2BpNv?=
 =?us-ascii?Q?oUVanOX9HYG4mBgjzIIx34D4Tq7Nf9Dwa9ImpZR2yGYRiFKXYq4PF9erEEtI?=
 =?us-ascii?Q?Yz+nFCCG+lIrKPZ3tveLvfXkqPcll5g190bthWLRx/pohrpGvpzbNxZtI3D9?=
 =?us-ascii?Q?9CqcvTbtmU+G7K40R+n1joPTrvCyoddpB+XTAnAZKVJM7XhiBpNeZoXEbXuH?=
 =?us-ascii?Q?L8g3MaeaYTZm+J5z9i0XgNOrMmzVH4dP2hD6pSO8QOi+tAyn/cAKhQsSjDQA?=
 =?us-ascii?Q?2FrYjyu55tfwBoKDPRZOLB8RAVKVwUOjSSNIny6NTTPhBUyey9LIcHE1pk9i?=
 =?us-ascii?Q?nVVbU5DpwCrSIIMxSGBLznz7F3Nmp70InGBcPz9BtdcatatAelC1W2yNhxoE?=
 =?us-ascii?Q?1Shoa7b4FRxUmWRvvE7kSCa17cwcxseEcIugzV1bQBtJqR8OqGqa838r4RdA?=
 =?us-ascii?Q?AMeHunIa/q8lMpogbypUh8PCIWD4iSWWFgc31x/ef1mbR4mrvV7/eGAECFGx?=
 =?us-ascii?Q?C/uGBQQFOUyGEtWTKbJ7JZOIJrlJfPCZ9Kjx+tTHTweeG+V6U/6CPUFzEAex?=
 =?us-ascii?Q?yWeQv1Y5WeyfhhfDUerjiShpUjnN3uF7tiaFI00nqWS33YNxLN7Tv6/UO/pI?=
 =?us-ascii?Q?MMoJ5o4x639jL6yiMPACCtSytL4eWTbv9PQJh+nJbqz5MBoORztv0tfDFzP5?=
 =?us-ascii?Q?81vB239vxUejbURGrN3XukjMlQqqFXosScOFP8Zt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5cdb5b-3c1e-434e-3069-08db9491f92b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 02:24:47.8188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2icH+i7Fapm5+jc5cq5Cw4enEluL2D2afhbqltBw0RpC0QparNNs3ly9RagzpMe3aq78iHEtMrsW/pWOIkUug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7632
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Yonghong,

On Thu, Aug 03, 2023 at 06:23:57PM -0700, Yonghong Song wrote:
> 
> 
> On 8/3/23 6:41 AM, Geliang Tang wrote:
> > Implement a new test program mptcpify: if the family is AF_INET or
> > AF_INET6, the type is SOCK_STREAM, and the protocol ID is 0 or
> > IPPROTO_TCP, set it to IPPROTO_MPTCP. It will be hooked in
> > update_socket_protocol().
> > 
> > Extend the MPTCP test base, add a selftest test_mptcpify() for the
> > mptcpify case. Open and load the mptcpify test prog to mptcpify the
> > TCP sockets dynamically, then use start_server() and connect_to_fd()
> > to create a TCP socket, but actually what's created is an MPTCP
> > socket, which can be verified through the outputs of 'ss' and 'nstat'
> > commands.
> > 
> > Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >   .../testing/selftests/bpf/prog_tests/mptcp.c  | 94 +++++++++++++++++++
> >   tools/testing/selftests/bpf/progs/mptcpify.c  | 25 +++++
> >   2 files changed, 119 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > index 4407bd5c9e9a..caab3aa6a162 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > @@ -6,6 +6,7 @@
> >   #include "cgroup_helpers.h"
> >   #include "network_helpers.h"
> >   #include "mptcp_sock.skel.h"
> > +#include "mptcpify.skel.h"
> >   char NS_TEST[32];
> > @@ -195,8 +196,101 @@ static void test_base(void)
> >   	close(cgroup_fd);
> >   }
> > +static void send_byte(int fd)
> > +{
> > +	char b = 0x55;
> > +
> > +	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
> > +}
> > +
> > +static int verify_mptcpify(void)
> > +{
> > +	char cmd[256];
> > +	int err = 0;
> > +
> > +	snprintf(cmd, sizeof(cmd),
> > +		 "ip netns exec %s ss -tOni | grep -q '%s'",
> > +		 NS_TEST, "tcp-ulp-mptcp");
> 
> Could you show what is the expected output from the above command line
>   ip netns exec %s ss -tOni
> ?
> This way, users can easily reason about the ss states based on tests.

There're too many items in the output of command 'ip netns exec %s ss -tOni':

'''
State Recv-Q Send-Q Local Address:Port  Peer Address:Port Process                                                                                                                                                                                                                                                                                                                                                                                                                                    
ESTAB 0      0          127.0.0.1:42225    127.0.0.1:44180 cubic wscale:7,7 rto:201 rtt:0.034/0.017 ato:40 mss:16640 pmtu:65535 rcvmss:536 advmss:65483 cwnd:10 bytes_received:1 segs_out:1 segs_in:3 data_segs_in:1 send 39152941176bps lastsnd:7 lastrcv:7 lastack:7 pacing_rate 78305882352bps delivered:1 app_limited rcv_space:33280 rcv_ssthresh:33280 minrtt:0.034 snd_wnd:33280 tcp-ulp-mptcp flags:Mec token:0000(id:0)/3a1e0d3c(id:0) seq:c2802f11c5228db6 sfseq:1 ssnoff:49d3c135 maplen:1
ESTAB 0      0          127.0.0.1:44180    127.0.0.1:42225 cubic wscale:7,7 rto:201 rtt:0.036/0.02 mss:16640 pmtu:65535 rcvmss:536 advmss:65483 cwnd:10 bytes_sent:1 bytes_acked:2 segs_out:3 segs_in:2 data_segs_out:1 send 36977777778bps lastsnd:7 lastrcv:7 lastack:7 pacing_rate 72200677960bps delivery_rate 8874666664bps delivered:2 rcv_space:33280 rcv_ssthresh:33280 minrtt:0.015 snd_wnd:33280 tcp-ulp-mptcp flags:Mmec token:0000(id:0)/39429ce(id:0) seq:e3ed00de37c805c sfseq:1 ssnoff:d4e4d561 maplen:0
'''

We only care about this 'tcp-ulp-mptcp' item.

Show all output will confuse users. So we just pick and test the only
item we care.

> 
> > +	if (!ASSERT_OK(system(cmd), "No tcp-ulp-mptcp found!"))
> > +		err++;
> > +
> > +	snprintf(cmd, sizeof(cmd),
> > +		 "ip netns exec %s nstat -asz %s | awk '%s' | grep -q '%s'",
> > +		 NS_TEST, "MPTcpExtMPCapableSYNACKRX",
> > +		 "NR==1 {next} {print $2}", "1");
> 
> The same thing here. Could you show the expected output with
>    ip netns exec %s nstat -asz %s
> ?

The output of 'ip netns exec %s nstat -asz %s' is:

'''
#kernel
MPTcpExtMPCapableSYNACKRX       1                  0.0
'''

The same, we only check if it contains an MPTcpExtMPCapableSYNACKRX, not
show the output.

-Geliang

> 
> > +	if (!ASSERT_OK(system(cmd), "No MPTcpExtMPCapableSYNACKRX found!"))
> > +		err++;
> > +
> > +	return err;
> > +}
> > +
> [...]
