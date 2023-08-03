Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053A276E9BA
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 15:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjHCNNu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 09:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbjHCNNG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 09:13:06 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0628.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78B3423E;
        Thu,  3 Aug 2023 06:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpanmmMygwD1Njx6Qk/o/EX8gMzTRmxW6IjNf6XVm5PcXVp8WEVKgWrw6FVBrADkZdROQlxNgViSOu5LTbx1O2wXzUorTzZH/645vp+GoWF1tF8KEVTwzsEGE/X5vkxjB1ZVga0DjV10uQwm9IYw0edbquLDdJtxQqUH/uUTUTbQbi+LzOaxZ9D7UrgiKSobokS+1W3vuTM+0fJMb4JS6AulSZ03t1vY8R/i9RQFE1N+zuqSO5Yxxq+igXTLCtzg7GAbYqkk8pYOsU/1+ycjmu3A1IduRMwFzQ7X2C4oPTp19ZcKsRri0DzFAvhLsY2CS4EYaMfU8U+X4VTgtbUi9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7971kUc4bQHqMgAuReHK2apuc8JukyzzVsfUycH8yHg=;
 b=HN7EGAcmwlUvm30QS9VRpY4efAqhgGcywUcB/bXvLxy3zC4+XHFXwCzlhuhaPpFowqzkND/roq7u8+eRTVvpG9MhaccA2A+fqRrreZ4iw13AnPvNUzK4MR24Vh/kA6iHekoMNy8Qhdfwe8zq9Q0oLbGXvjPOEl9TiOtYzekPGhE7bGhTXYg6NtiRV9VE0MzRybGK6eUzPBx3ZT2PAVGo3l15tTl/BOQDgZO+0cidRa8yjC0WjNAknNciqhgXI3zD6RfACKZg9p8MCNl3n1iINK0/54MOUpiGeQA3+b1BYtlyx7aN8rHZHOtoRFMnMSJmVb8ZS7YMbAMt3SPVBk7NzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7971kUc4bQHqMgAuReHK2apuc8JukyzzVsfUycH8yHg=;
 b=YeMk8PE2MrWvSgw29ClEdI4A6iov2W8FxpU/GsiJF1zOFlE2GEqQwlfpPFOmRxmcBeb2HDFOZ57AUmjnJ8uZ/MhuILfCzBsCPv68AWOoFhyOY7TeROjOVWwZPDtund7xR582DCoLOB3zFY1xaasU9q0UKF3X8b21tVfJLOb2d/e2hdWR3qDLOR4QiwuUOlZfBOLsLslZrtTGlT8Z0dFrC/7dleONWDr1Ocfpl2s8ScxL3LCgBve6KbZ+MON9tZmzbG9mKYqErXKvj9aBg434QTyzC+WXYaVDoGzvCMtsr46/ZEZm1yArgSRoDZ3wZ3fTGomGHoH3VRmkO1vRDlQvEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS8PR04MB8182.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 13:05:25 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797%5]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 13:05:25 +0000
Date:   Thu, 3 Aug 2023 21:05:40 +0800
From:   Geliang Tang <geliang.tang@suse.com>
To:     Simon Horman <horms@kernel.org>
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
        bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 1/4] bpf: Add update_socket_protocol hook
Message-ID: <20230803130540.GA2792@bogon>
References: <cover.1691047403.git.geliang.tang@suse.com>
 <120b307aacd1791fac016d33e112069ffb7db21a.1691047403.git.geliang.tang@suse.com>
 <ZMujUofDnb8wMb36@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMujUofDnb8wMb36@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS8PR04MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 2023357e-c04b-48cd-709d-08db94224d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c5tJiC23ruuUMAR2ucH6MV4E/nmtkfNGqi0KY4hEDcjkiJonA8LKsHzMzCe+QWyyJEFXRaiUn0McG2qBfF/XO7qjAiRbpaIVexcnAu5ImyZNDeU78jUjIZU+gHvdxVcF8jCInPwOgBxa7o5+LLPVQE8tg4Zr0aCD5ewNnTdgUJLQz68WQuUbA6Oculj9uvUuGcIJrlUFVTRC0Fc13bE5zFd1KO0vSMPvvbXuf77j7zJCy8POlcuSIPvWPnQ97s/LGWaWFWjB2sP/DPm/3/fJGxi0WwG8zamsBxC/QSuN/M5tcBwl76k5vYAaqKPn5PGMjX2qa2RQW/8c/6vRr361uDRGJvBYoJZsFxxNLF2rxY1O4FoW27pCuEwLsjrd0KqVl+AUmMqkbtLgITLaN54dXcChVXOwtLiOfmMSkPUopDsFmAA3fe1IJApAYz8FhLfwBaSEiml5BqKHGz2jbVqUPH/gC7np3Cm9KHh9F6S3H0e5U9bORew22S31WlITsl5fmOignU84VnItxjUlkxFVu4EV6fOK3fZOPzRgFdVjIsv6p4mMMG87h6qotLtvLrdDuu2OxKjl7xM5QnfLCfjh31uAEq2vO9FqcdBxBxMLer4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(33716001)(86362001)(33656002)(54906003)(478600001)(38100700002)(1076003)(6506007)(186003)(26005)(83380400001)(8676002)(8936002)(6666004)(15650500001)(44832011)(41300700001)(9686003)(6512007)(6486002)(6916009)(316002)(66476007)(66556008)(5660300002)(4326008)(7416002)(7406005)(66946007)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IRJbROvOy/Lm4XykMMbCbirrCOtIBmcId35yqQmwcoIMnNh9g3U1uZEZnFy0?=
 =?us-ascii?Q?mZsNmdRA98CYfIp4ebg/MG89EhnsL8hiKJlqJzcFF7aXax8/XZq06DoifU6i?=
 =?us-ascii?Q?91YsfeJUThS55X0sZwh/X8gY0IG85C2r9XpQSrikEZ/D+U8RXrJd/uD8fiIB?=
 =?us-ascii?Q?/8CBumky4CV+Crdy3EcKl1VPGTd5F6C+d28GA5NbKQLZ806YqUAxSBKb78ni?=
 =?us-ascii?Q?eGj+3WhI4wE7dhrRTRaaB6KdosoEoGq7INUqXCiP0cBxvGQSj9dsZlONC1MG?=
 =?us-ascii?Q?kL4+tcjrIlK5O6OQlhkXv4v7AyyJdnBd7nIukxNwKRclF0Yq7noI3j7/wAxj?=
 =?us-ascii?Q?oPWc/FoSnGQaY3xjTCN/9yjqpxI4qfyHd5dVrhQdwcgKy3AG/H3n2vcdkCz4?=
 =?us-ascii?Q?iH2/Xadsa8JwJfJGeprfK/mgZn4CYZr+KU9TjO2636T26Vrdh5Mg3JcXGDX8?=
 =?us-ascii?Q?npUmM6LFmtQZPehlLpdC3awb6LRkCl77GDOnKTKOxriA2eiIsvwFBFHM4uge?=
 =?us-ascii?Q?6HgQv7dC+FHLu8kJko3t9FGK7AhS5N59jQBwLFQNXDU00xwUxM0ELpMRjle+?=
 =?us-ascii?Q?XLejfxGAd9Z7hM+N0hMIBDtE3b0gYJgLQsHv63h2ddY+6A966huqJJH9/JUW?=
 =?us-ascii?Q?yO5IT3gp8Dm7wfzhi74NWhc0XxwEtW49crWjxt5UH1Hq8+BmqnY++HkQxxZL?=
 =?us-ascii?Q?NAitf40S+In0/cFr+A9yf7EzSJWphI1KUtzXloSpNoFALVasot6dp0G+84A4?=
 =?us-ascii?Q?K4eOsSA52L/sVtmYHlvOPht+9fggDCyTNkm/kX1dYSdj5t3Lv5NDWI5CFEZq?=
 =?us-ascii?Q?tzp/aWdsBiMPhnYjXKvwRoyCyQ5nL8X3B7hh3XEc7CQQ3FNLqM9/3KIu/upD?=
 =?us-ascii?Q?05KI1PXWCd8B7nV1LBK76g64fSoQp6NbCUzKX0chcUvaZbYXrsHfqlBWKnPc?=
 =?us-ascii?Q?b1VjGRG61ScxOuHFqn5Ng82+xLGss0LBNwRVBMy0jKXsNOWdyZGn2AD7vraV?=
 =?us-ascii?Q?pETpJpmr+4V9F6VSi4lHxyGuzR9n4l3Ege0UuqfWfoPq2RRnz8ZJ9tBTlqkl?=
 =?us-ascii?Q?0nPxHfxYUP4s1kcmYa+NAa30eGYWfACJfWkJLUD07dQ062viX08DmGF+MQTg?=
 =?us-ascii?Q?X1JIE+ZlMZrGxWpOmI36seMdyYW8uI3pobVLPkxyy+w7g1wHDdwe6DEl+AVg?=
 =?us-ascii?Q?HU2j+XBj8zne+FKWdt/CNI7EHOOxtra4j1vVK+ujg37kg4H0jsx21/ryeQT8?=
 =?us-ascii?Q?914AijvGBAmpqn4TrDGBXxDMomUQt47Aby+nahl5kSZmWpE44hQr7kbSf4i2?=
 =?us-ascii?Q?Pu1TCWduV9qvDigGE08wi1dXzGZ+Jm32nMF9IvnwcJaA2Bpfl3P4A26xgguh?=
 =?us-ascii?Q?xyIZo9deOfNQo+c3CiNpm9NDnexTXb4CKBwI1Hb5vnojO3M1WhXfaHkwJbvY?=
 =?us-ascii?Q?haDPwihdCZNoqaRIkLtU/M83VQifSBIVdsTBXQEcKbhbZOKYlRwWgJzQwffe?=
 =?us-ascii?Q?s3k80BXTpkj13wllhUXA/4mtjCMuP9NKv3zCTZm7mxXqK885IKAjK6XaztSm?=
 =?us-ascii?Q?sZ7RUsf4Xno69jpo2HLR0JKGbWit6mPzH5/XGiiH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2023357e-c04b-48cd-709d-08db94224d0f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 13:05:24.9650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tsh1KYJLTgAkZocM85bFR8TuWONFcgCQE9fVGT4Igp2DLsdOuLVZW9R8Z+CFFKR6a1kfBM7V+axYacYoWfuRxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 03, 2023 at 02:53:38PM +0200, Simon Horman wrote:
> On Thu, Aug 03, 2023 at 03:30:39PM +0800, Geliang Tang wrote:
> > Add a hook named update_socket_protocol in __sys_socket(), for bpf
> > progs to attach to and update socket protocol. One user case is to
> > force legacy TCP apps to create and use MPTCP sockets instead of
> > TCP ones.
> > 
> > Define a mod_ret set named bpf_mptcp_fmodret_ids, add the hook
> > update_socket_protocol into this set, and register it in
> > bpf_mptcp_kfunc_init().
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> 
> ...
> 
> > diff --git a/net/socket.c b/net/socket.c
> > index 2b0e54b2405c..586a437d7a5e 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -1644,11 +1644,36 @@ struct file *__sys_socket_file(int family, int type, int protocol)
> >  	return sock_alloc_file(sock, flags, NULL);
> >  }
> >  
> > +/**
> 
> Hi Geliang Tang,
> 
> nit: The format of the text below is not in kernel doc format,
>      so it is probably better if the comment begins with '/*'
>      rather than '/**'.

I do use '/*' here first, but got a checkpatch.pl warning:

  ./scripts/checkpatch.pl v8-0001-bpf-Add-update_socket_protocol-hook.patch 
  WARNING: networking block comments don't use an empty /* line, use /* Comment...
  #63: FILE: net/socket.c:1648:
  +/*
  + *	A hook for bpf progs to attach to and update socket protocol.

  total: 0 errors, 1 warnings, 0 checks, 59 lines checked

And I found that other comments in net/socket.c all begins with '/**'.
So I use '/**' here too.

Thanks,
-Geliang

> 
> > + *	A hook for bpf progs to attach to and update socket protocol.
> > + *
> > + *	A static noinline declaration here could cause the compiler to
> > + *	optimize away the function. A global noinline declaration will
> > + *	keep the definition, but may optimize away the callsite.
> > + *	Therefore, __weak is needed to ensure that the call is still
> > + *	emitted, by telling the compiler that we don't know what the
> > + *	function might eventually be.
> > + *
> > + *	__diag_* below are needed to dismiss the missing prototype warning.
> > + */
> 
> ...
