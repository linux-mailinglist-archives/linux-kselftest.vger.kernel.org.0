Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C417789B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 11:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjHKJ3D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 05:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjHKJ3C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 05:29:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDED26BC;
        Fri, 11 Aug 2023 02:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AY5tez26bxINybasaZi62Lrs0FQlmw9wqHt0upO+3y9K/Oei2SDyC1dBOQn32HDnT9cHMjitOLLYDN5fxKkDcRprjfDvJzjKGp1cVNifs4DMjrehOii31WWUkZoYmLOtQ3Xci/ii1wHKfFP4pPh4XT21gfNB7YrLU0C8ny9lEoAOpy1QG+6hYtNgbkPMr3gBkCxQd8WjXk14z7XweQ2j2zpkAgMbe77u+RWzs+2oeoJ/UkErNjMhnGQS60+D6W2n9HG8rjuqvQ3psx7oe5j+mSEDX4KpJx8UVw8xfd76ab3QIftuWITIznUDodAyn8+JZUGxV/xgSMm2NYjpxzzwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY4L2OQGLdsiygbFypbdBEOvZv8FTG8scfQBlSGqzLY=;
 b=I2Z+L7SfDJetmQi3s1MraGVQOW1NU8q327IEYomsHTR4zzhwez54sRcCczFRorbixVfEc2umnqi9CXib6tY3xclV5cLW6R5RzTtHRhFdD9l0OgL0dFs/hwtqbOpC6msMSjM9plQ+gxvaKBex5TZk2caAApZ5fhY9vevC9gqr8CVgDwIerLG/yDGlzh8xknkbHRt8SkEJydnH5OwHpv67xEMcRKhNtQ9Vy3peC1LzGkbjPq5zs9mVOCbLpcq6uZeMZAQIGeVfyuy3a/eeQQdLwOAnYx04eh9UTBu6md6+F9Est7ornomDcZzdr7FJQcuIYHu9noxO9J8mqrb4kkCQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY4L2OQGLdsiygbFypbdBEOvZv8FTG8scfQBlSGqzLY=;
 b=xzPDR5rESNbn7umZqiaNwU2WfJzF31L8V/6ytWiBU+hNzu2pFHJnZvtCVPSF7WTlPo3l1u34Be8g9fRaZm4KqsEmcVOoueXMZdwJd3cS+9t0Wjw8+Ne9fIvQAI9mNvINFxGhuHrZ2daKw9HMvUiucbpiN5FI68amDZShBuzhZTE3WAoMYpC/y/Vm8Ydcup83vvaDO2VtLQmya5R8uit32OORCBZevjcxAsM4/XznCH9sAp27WInHFO9aXpS5He7nacawoQj8dA0qoy3QAI9rdjo2cts2LYULOVkzUwSLUHEpoJ+6irWzil7YmIGDL0x9UL3wPEhzjjmb+AXtvIaP9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Fri, 11 Aug
 2023 09:28:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 09:28:56 +0000
Date:   Fri, 11 Aug 2023 17:29:15 +0800
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
Message-ID: <20230811092915.GA8364@bogon>
References: <cover.1691125344.git.geliang.tang@suse.com>
 <15d7646940fcbb8477b1be1aa11a5d5485d10b48.1691125344.git.geliang.tang@suse.com>
 <8b706f66-2afa-b3d0-a13a-11f1ffb452fe@linux.dev>
 <20230807064044.GA11180@localhost.localdomain>
 <9a84e026-402d-b6d9-b6d1-57d91455da47@linux.dev>
 <20230809081944.GA29707@bogon>
 <ffd1bb86-ed32-3301-346a-e369219841de@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd1bb86-ed32-3301-346a-e369219841de@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 5073c41c-9ad1-4c48-e2d9-08db9a4d62c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lz1NqOvwQFJoTbDtn/awC6z3wKa/Tg1a169AzTx1C9qTsuN/qBRESFIf+XLu1lu5zbPYnEWjrsx0+3FCc88zz3/PioVdGamIIfunJUJ2jmF4xDNcyv3FPGf3dQssGqfH0/aMYCnuaWH7p1OD8D2UvQU9w84sDM7KuF5Zdd9RRBQlEd9cvAeD3i/bHk0wCp+fupflWB6j7V7nr0Cv1Y1yPGzy0ESTEweaMfcKVGGNOhMNFRb4puLnyYza7TEVugEVgprp7Q308f0zP6BRC2gLtcwErfhrj1abHavvfPK5mLV0xTaDRDn1Tqkgb/JOB55cXgL+ZV1jmb0TZ+jx88eRiWtfHjKA8izcIX2tPp6e8OqqwfOSnLMHN3I7N3WcKI0NWYo5CxoCQtMSgPj9pRZ435q+FhnZsOVN7wL5a/Ug9pQTjwnJc43AVoEf2d9w7fyCaHdamh6sKISZo3+cZn4CREgT9ekUXJ6CWp+EkTvADI7PJDcBeotYYYo6qQk7N2qkziRkV8HbHhY/hg7Ow5XZb2+jhbAawla8mlLdthq7R5Jc8TgpgEXG5JFKlO57g1xfh1V/natsQQcTAuoSd7t8ILDaSdB2O66+bZsySAL5NzacIbT4eDAZdafuzxL4T/MH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(1800799006)(186006)(4326008)(966005)(9686003)(6512007)(316002)(6916009)(6506007)(86362001)(66946007)(6666004)(38100700002)(66556008)(33716001)(66476007)(6486002)(53546011)(33656002)(478600001)(54906003)(7406005)(8676002)(8936002)(66899021)(1076003)(26005)(2906002)(83380400001)(41300700001)(7416002)(44832011)(5660300002)(13296009)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6KQ0WEQ3t6DjPbJ2owhAMvnV4tJHXPR6IR8f2AxjNeAOxkqzt/thMyneQlr4?=
 =?us-ascii?Q?GH+w1WxMpjBynTs7hZ7hjbezLswsWmJV9cqDIS+0wkut7GSo4FPctbdj5UbA?=
 =?us-ascii?Q?3o1exkX17DrG36VrEE31+uKPbEV7wpK45Ml7U8EtGRkrmT/cnVFiRZbCKA+N?=
 =?us-ascii?Q?D12A1goawzERTipHAYFYbJyP3WAA2puig2ecZvUQ60wNtzBGeqYfqtyAIObs?=
 =?us-ascii?Q?d7IauBB1Nx81PWN5brH0Ueln3jiKYcOlS5GZ/ahdtWjqs0oeUaymxr3uW14h?=
 =?us-ascii?Q?ChE/T/vputSu/6QEu3Jm496yL4ru6wC29X8cj7WRUOOaWanUUfKXfe9fniyH?=
 =?us-ascii?Q?PlXTAmLjSdZiVAjZxqy/ipL1W/xgad3ojyEifutE65ne9MSqsCesvgnscZuu?=
 =?us-ascii?Q?LgBY954bYSEVTbs6mKaXy2CNFac9NqtNBtTBmS+Q+Mjpqz8u3cSt4Lcu7gJd?=
 =?us-ascii?Q?8lsNcQJoN1yRfHKhqry7RRLMgGT2Z7NH+Y6PWqnQvOobMMhkEJdHODCP2hCt?=
 =?us-ascii?Q?oTj6H8WVhOiNyn5Kh1pwhf7R07o3hfWhSqNkgmtl6xp1a90LOG2ZNL3WgEEW?=
 =?us-ascii?Q?2mslIFK6FRwYWfsm2t7iawk0ILCByDGPE9AvlVXhMZ5DXB6JWBZOTXRtWk06?=
 =?us-ascii?Q?yumL50OvpJF0xyU51okVvpNxxMBQF63HeHpkXCHEpDW51WF76QUKvD6asT9c?=
 =?us-ascii?Q?3/HxyqOKF1SZPfIPeCzvOhEht3XE3+w+/IsWEgUJBqYG7pqSAouJf+pcQW9z?=
 =?us-ascii?Q?oONs4GWLbfVKe3IemA3iwfpbakJiqDdfYtCwTp0Eo8SFWM39ItkN9Wvfi2CP?=
 =?us-ascii?Q?FGtpndz63h2eMjRLC9yU7Yec/861m48Y0KNYWU8HK7Bsj0ZF9U5iZYSlwfZb?=
 =?us-ascii?Q?lxqMl6iDYOl+l28wXFEG5P4v08GBRZG6cMnoKRklYGtvSnWOUtOkQ1WhB54a?=
 =?us-ascii?Q?adCUi8YIuugj8S8zA4ouIPAM7y/wvTjP7XPxN1Dw4hKyvbFcnoE0kEXilycs?=
 =?us-ascii?Q?xtj75oj/IevkBRaTXFbOuPDL1VQYCryLwVqcA5OFGLClIKups1yXy0qoQW9j?=
 =?us-ascii?Q?lZKeZt/MSqkL52f4OL0TMJjeEj2IL/PJa312FpJfJGYCx5JHGmfz9g7qdZn3?=
 =?us-ascii?Q?u7vQT3+Clr6L5bWrlxBYJKHIxW3nQbmrC+1MK+x+Eo6Sgl1fzl51GJq20WjJ?=
 =?us-ascii?Q?kC9TJxxxe2sKSgp5+6OXrIx0X/lel74CgJFCEeQDT6Puarx7ybg3pipNgg9d?=
 =?us-ascii?Q?VFuGi4Wcjk9u4l1hrP5GW8+DJH1LPQbMC1uO60sRgXLFmAFWSm3fwqIvwkIX?=
 =?us-ascii?Q?XUDd76f3JaVTIpcUSpQ4xKzlNhM1ZQMiky8A6ZSCnee5HalsRKBJSJnCKsdO?=
 =?us-ascii?Q?uo1TjpmMnrNFtNuoDrHctWd39vP1GkoYn9yOzJCiiiuPW3awsZCGnQBLidRr?=
 =?us-ascii?Q?AFUjf/17SRanXqo5HCsULp2Y7NzzilXUpWt1woIxK2gB4WLwoGlmupeZ+YfD?=
 =?us-ascii?Q?rnsd1auvf4ME13KSf3aNwVlK6s69CIEmTCUQudBhUXJu+4TKBCyuuqVSS8cI?=
 =?us-ascii?Q?irkdjEttiCGiBsX0I2gpDEvYGDLAKErpoi1ietDK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5073c41c-9ad1-4c48-e2d9-08db9a4d62c9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 09:28:56.6875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UyKYZOvIHqamXNdrdj5L5P8xisvDeEjSaYNwNCa3ZoMYcpVlFD3Lv+n0F0v3C4OPw93xhLVgpBA8vHOISbnbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 10, 2023 at 10:53:38PM -0700, Martin KaFai Lau wrote:
> On 8/9/23 1:19 AM, Geliang Tang wrote:
> > On Tue, Aug 08, 2023 at 11:03:30PM -0700, Martin KaFai Lau wrote:
> > > On 8/6/23 11:40 PM, Geliang Tang wrote:
> > > > On Fri, Aug 04, 2023 at 05:23:32PM -0700, Martin KaFai Lau wrote:
> > > > > On 8/3/23 10:07 PM, Geliang Tang wrote:
> > > > > > Use rand() to generate a random netns name instead of using the fixed
> > > > > > name "mptcp_ns" for every test.
> > > > > > 
> > > > > > By doing that, we can re-launch the test even if there was an issue
> > > > > > removing the previous netns or if by accident, a netns with this generic
> > > > > > name already existed on the system.
> > > > > > 
> > > > > > Note that using a different name each will also help adding more
> > > > > > subtests in future commits.
> > > > 
> > > > Hi Martin,
> > > > 
> > > > I tried to run mptcp tests simultaneously, and got "Cannot create
> > > > namespace file "/var/run/netns/mptcp_ns": File exists" errors sometimes.
> > > > So I add this patch to fix it.
> > > > 
> > > > It's easy to reproduce, just run this commands in multiple terminals:
> > > >    > for i in `seq 1 100`; do sudo ./test_progs -t mptcp; done
> > > 
> > > Not only the "-t mptcp" test. Other tests in test_progs also don't support
> > > running parallel in multiple terminals. Does it really help to test the bpf
> > > part of the prog_tests/mptcp.c test by running like this? If it wants to
> > > exercise the other mptcp networking specific code like this, a separate
> > > mptcp test is needed outside of test_progs and it won't be run in the bpf
> > > CI.
> > > 
> > > If you agree, can you please avoid introducing unnecessary randomness to the
> > > test_progs where bpf CI and most users don't run in this way?
> > 
> > Thanks Martin. Sure, I agree. Let's drop this patch.
> 
> Thanks you.
> 
> > > I have a high level question. In LPC 2022
> > > (https://lpc.events/event/16/contributions/1354/), I recall there was idea
> > > in using bpf to make other mptcp decision/policy. Any thought and progress
> > > on this? This set which only uses bpf to change the protocol feels like an
> > > incomplete solution.
> > 
> > We are implementing MPTCP packet scheduler using BPF. Patches aren't
> > sent to BPF mail list yet, only temporarily on our mptcp repo[1].
> > 
> > Here are the patches:
> > 
> >   selftests/bpf: Add bpf_burst test
> >   selftests/bpf: Add bpf_burst scheduler
> >   bpf: Export more bpf_burst related functions
> >   selftests/bpf: Add bpf_red test
> >   selftests/bpf: Add bpf_red scheduler
> >   selftests/bpf: Add bpf_rr test
> >   selftests/bpf: Add bpf_rr scheduler
> >   selftests/bpf: Add bpf_bkup test
> >   selftests/bpf: Add bpf_bkup scheduler
> >   selftests/bpf: Add bpf_first test
> >   selftests/bpf: Add bpf_first scheduler
> >   selftests/bpf: Add bpf scheduler test
> >   selftests/bpf: add two mptcp netns helpers
> >   selftests/bpf: use random netns name for mptcp
> >   selftests/bpf: Add mptcp sched structs
> >   bpf: Add bpf_mptcp_sched_kfunc_set
> >   bpf: Add bpf_mptcp_sched_ops
> > 
> > If you could take a look at these patches in advance, I would greatly
> > appreciate it. Any feedback is welcome.
> > 
> > [1]
> > https://github.com/multipath-tcp/mptcp_net-next.git
> 
> Thanks for sharing. I did not go into the details. iiuc, the scheduler is
> specific to a namespace. Do you see if it is useful to have more finer
> control like depending on what IP address it is connected to? BPF policy is
> usually found more useful to have finer policy control than global or
> per-netns.
> 
> The same question goes for the fmod_ret here in this patch. The
> progs/mptcpify.c selftest is as good as upgrading all TCP connections. Is it
> your only use case and no need for finer selection?

This per-netns control is just the first step. We do need finer selection. The
most ideal mode is to select one app to upgrade it's TCP connections only. So
per-cgroup control is much better than per-netns. But we haven't found a good
per-cgroup solution yet.

Thanks,
-Geliang

> 
