Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC775A2074
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 07:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbiHZFua (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 01:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiHZFu3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 01:50:29 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2927D7D782;
        Thu, 25 Aug 2022 22:50:28 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q1wh04022830;
        Thu, 25 Aug 2022 22:49:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=WXXWTZkIRqbLfl0RtOV3Ej8+c20Ti+ifIXmidbHG98g=;
 b=DA5TlzYU+Q++f/Kl86fMy1bNKK500lT2hIxz3rEB65i/8cQY84wE9e7o30bYAbSL+AGE
 NMLUeFp3MhyIv3GpyuCb0yymtfGppOUjAGxwhlRrxskfPGUjuAcx2uWA5sl7e3n2o5FH
 bdDKxx/1PA9OTsJyOD1hXFPUcNTntpB4iK0= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6myh0wne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 22:49:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jbz2KxH5TM8ww26WSI9WeSSSqOXdcR/qboYsLiWAIOCB1vVp2+m+ZWQKjZTITrXy5U9BresdYDJegyPwO5bfbgJ6VM+f+QBx+9VtoA2FryxU3+JvgmnqH29HP2QpggLGlFvOAxFytaH6vb3c021ut9X5YXwk6V5i2EZGwIhzPVKPmeaHOGRFPLb9mq1eLMllNe1leVibYkbi3EBM292Ty/kALianU7ZVriA79o9H2TxRZ5p207qTVJ8ripgDNTSUWKlusnt1wVOHFEUQMVUiL+rbHAdlx1j0/SZ1GtojGdHLO0Iu7lzgxd4hqOdNR7O+nbdzaqN/KwxaUKms7o0a7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXXWTZkIRqbLfl0RtOV3Ej8+c20Ti+ifIXmidbHG98g=;
 b=euFXCnN49y3+0ClNDxi1oUe3De/iYX8cQO6eD8tpbR02+TElY+lNCMgZGlj/r41iU1IVDG2QfqrtQgE3Q45jOV/P1gk7GxWk0CDRXoiLF01bPxP5rGhVZbeGdVCzOVxyOEvQiRhx9Af6BWn5e4uX8rM5GFOknywLYJ1kybZAUMpu+PRQBcAwK5bAVTi6Apa0i6D8TF2qRfzYacWpPeFu5FO/7KSorH4FNVa8ArCWc4eidM1UZe0qikYex8N7njrhHolpxs6ZIHo/8KVlf7odTRlGx93NceFjGNuESvar/1FLS1DTaP0XM+QhpIgeX1oAizJjpOzGdUCcWM7Okhbeww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by CH2PR15MB3605.namprd15.prod.outlook.com (2603:10b6:610:7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 05:49:46 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 05:49:46 +0000
Date:   Thu, 25 Aug 2022 22:49:44 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: Fix bind{4,6} tcp/socket header type
 conflict
Message-ID: <20220826054944.5bcx7unsyx4ts6ok@kafai-mbp.dhcp.thefacebook.com>
References: <20220825221751.258958-1-james.hilliard1@gmail.com>
 <20220826051630.glhrbdhiybtqwc4p@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4rQdnd=V0tENFGCTtpTESwSCcwK+h3i9nZ75M+TywNWzA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4rQdnd=V0tENFGCTtpTESwSCcwK+h3i9nZ75M+TywNWzA@mail.gmail.com>
X-ClientProxiedBy: BY5PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::16) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e71ac0c8-7081-45fa-9a37-08da8726c820
X-MS-TrafficTypeDiagnostic: CH2PR15MB3605:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: unaaIxW06wZds54TrHgHovD7ZkejnmozJKsl7reyoeDHkHsAIjawYMXxNgVUxpNsSSz8XRpU+WNxlnC/R0TDrcuNC3gVPSXm0RNPM7pbj6eXirp12hO7qNI9+PHa2WpKxvVM+/yEDtppAsK4Q7K0mUva0LMBSXwX2k/iRbTQm/sE994w7TcbKNzLW0s9lQfV5wOpSfwUnNegIsfgd4uRwbHW6z/7c4L7ugoGSgTJlmaI+s3/1sCrJ9wkRw7id5mkHeFiQfi3d4Sz3XT4sK8wCIg6W6hFUWSBStCKqClySpoS3M5X7RYsUilIpA5yhGCQpx0utA5KZRigx8qQVgRjA2u25hoWEc/WyhK2R0vOVRId2/foFAiFfaaUzNt1yV3QkkruYG37FozkoD6uz7ivv0kgoBXXhBX7dhOmfnFWN1sCQn4OnRrW3+lMlYX3xb1UVPhfiXNMGCjdVkMlKXyypbqy1uzsVuIoZzQ1y9cMgnJJK7IH4zbckPftsOzY9gRIr1WJGCSGXXJytZb80qlq45d3z8Y6ApZO5y+fZrMvTHpmFFOog2NVX9eU4JT2zr3l+76oV/wGI9zv2+qll4XYGWvdM8Wc34qvunwK8yDOA86RgXb3Rz7ZeOSB5s5NtNfF8/mD5+2cxiO8aC9Jirold66dv8juYaOO+u4g1fBSFxqKsDMJ9HY4JNDqStGszMcGk99CylGRTyQngk6Otcr4HLZOhfJ7j8eZkCsyUHTgWGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(54906003)(6916009)(83380400001)(316002)(8936002)(86362001)(66476007)(8676002)(4326008)(66556008)(66946007)(6506007)(52116002)(53546011)(41300700001)(6512007)(9686003)(38100700002)(6486002)(966005)(478600001)(1076003)(186003)(5660300002)(2906002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SkUk61kKz3YnZgPFpXwuZsQCfDCg18Cg8J/prPpxT4n1VBq31CMrZabyvxA+?=
 =?us-ascii?Q?yzVmL1hIcCcwWx7+4JqpI807BQF9YNmGq+kOiJzA8wUld+O3fS/hfGSIBrLk?=
 =?us-ascii?Q?u+GYZN8B82LFj/wXKd+kRtEYw8zTInuc8wuLsfMXSsazcRvi5xEidKi6FLaP?=
 =?us-ascii?Q?s/xpMSQS4d9dNNZtvN9qA7wK69kn+kH94utGtI3Llu2YLKvsetzSpKZOJ0jf?=
 =?us-ascii?Q?Cl8KdayOmYbzLrD8M62JsL3KpuP2aYGp+LgCN7Q+Q0/kgI5X+XXF1fXpV+Ml?=
 =?us-ascii?Q?6o1OvvDDm3MNc7NLKlFvTkzd28E8WdTx3kmvUsrRmip+8zgFcw/Kz0dYkHpX?=
 =?us-ascii?Q?1mHTuiBXYkG9tIRWRywl1/7+2ZIr0T8xRzGA1Xm1/NVDdxoYo97jj+tQghwg?=
 =?us-ascii?Q?YsslNTKI8S6ZyclNxQxP+Z0atOX1RQeh4uAEhc3iwrT79onwjNU2DHyHhbMA?=
 =?us-ascii?Q?R7RQCS42aNkUWVR8ZeG7Ax7AO2OYWkcWLSERid7Hdoeh2B8GsU6TMmkf4YEr?=
 =?us-ascii?Q?ahzMqjRcdZjUQ9umWS69XrWrL5eELxYha2pUGr/LgTz02RsbT1pmURs9PYCE?=
 =?us-ascii?Q?jqY5iE2z6Vqj8/q1j/7eON1M+61U0AWIc1n3hVKXW3+wq0P6WtbUff839tLK?=
 =?us-ascii?Q?RwZ3GmehvtoZoMZgoYY2fnJQ/bd3T9qexbmC2+0rWJ1KDYE+eVmqVtp9IZx0?=
 =?us-ascii?Q?rCThN73BZyQZ1G4pptnEFOmnFbG5QkDW5h/WSM+VUgxjL7N7d2JQ5QCnyrO9?=
 =?us-ascii?Q?sWmGhRr7590DsQBkDDmmVDnzclRa9DPsEJmYgFjLG4gDfhrbbtY/e5kNUIkP?=
 =?us-ascii?Q?tsSqCJaY9GEsQlwlTAjvTuVKh82Heqzeiirs87HgzWOVlLwE8NIwYiNnV6nP?=
 =?us-ascii?Q?dIzX96BRUi3GNwEPMWnw4ww3uII4/TdpWF9V0DPy6oJFZgEgQWYvx6c6sPyN?=
 =?us-ascii?Q?kp+l7tHqczsd3OnNQ5Cqfv0zHsNud2mydoSU3uSxQC0uUJvLMOp0xwr86ND6?=
 =?us-ascii?Q?PuCVYqAV7QOutWHfxZlanIG34qZXUEZTYYhWyA9E5zokqfvscqp+0X5YY0gx?=
 =?us-ascii?Q?YiTPRHwinOOLotzvTksYEXBeneVp7CnKvaVwaKWyIMTWEjkcyuzPJl3gqcyp?=
 =?us-ascii?Q?HT6naoDbsTx24xQYcqp8H80dlmRdoZJ2ls1o5eIf46Vwtuffr7gB//MyTpbC?=
 =?us-ascii?Q?tzulEmb9NAWEXPeDjX9AReAa2e60wiX0/RVdLgGAai3Lwl3sHTh3BzZQ9bgY?=
 =?us-ascii?Q?SzNV1mULu4lDleno6P92ubvR59LbOSoBWwEK1Fv1pRstocQWsr0pLwk1QEwv?=
 =?us-ascii?Q?EZ1DqogXq0d/XClwI8OTZsQaJn7mZzwjq6FEBe+SHNbAypDfTI7Vh9mV0b6m?=
 =?us-ascii?Q?HaNsM0n5KQPuQ/B4ctqs27sA9jGGnLhN0ug9CcCj72ENUcNvfUBCGLLqmJWL?=
 =?us-ascii?Q?Z+KDoxa+dfhkUTnt96gunbFM3q9v1ZgJ6eYmDh7oFnD2eb9jarX6Pgow8cUa?=
 =?us-ascii?Q?IpywMZF5q6dgy+9moYU6pUwLDgWuHWosUBRgkcunUflOCHqN6e3ox6umur1G?=
 =?us-ascii?Q?rWR3BsPfY9CBE5XlZp0DecevG7CwLmr1iH3mop99AHAa2OdgFil1lH/wajlz?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71ac0c8-7081-45fa-9a37-08da8726c820
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 05:49:46.4308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPxPkBoyj0W5ihMQ0xojunLwOtaUowP68y+1qNBcGW/d/nAQYx05dL2aIzufUa4G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3605
X-Proofpoint-GUID: eU9b0jHeYUPSLtI71rTXMXuUTRe8heHN
X-Proofpoint-ORIG-GUID: eU9b0jHeYUPSLtI71rTXMXuUTRe8heHN
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_02,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 25, 2022 at 11:31:15PM -0600, James Hilliard wrote:
> On Thu, Aug 25, 2022 at 11:16 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Thu, Aug 25, 2022 at 04:17:49PM -0600, James Hilliard wrote:
> > > There is a potential for us to hit a type conflict when including
> > > netinet/tcp.h with sys/socket.h, we can replace both of these includes
> > > with linux/tcp.h to avoid this conflict.
> > >
> > > Fixes errors like:
> > > In file included from /usr/include/netinet/tcp.h:91,
> > >                  from progs/bind4_prog.c:10:
> > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
> > >    34 | typedef __INT8_TYPE__ int8_t;
> > >       |                       ^~~~~~
> > > In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
> > >                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
> > >                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
> > >                  from progs/bind4_prog.c:9:
> > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
> > >    24 | typedef __int8_t int8_t;
> > >       |                  ^~~~~~
> > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24: error: conflicting types for 'int64_t'; have 'long int'
> > >    43 | typedef __INT64_TYPE__ int64_t;
> > >       |                        ^~~~~~~
> > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous declaration of 'int64_t' with type 'int64_t' {aka 'long long int'}
> > >    27 | typedef __int64_t int64_t;
> > >       |                   ^~~~~~~
> > > make: *** [Makefile:537: /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/bind4_prog.o] Error 1
> > >
> > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > ---
> > >  tools/testing/selftests/bpf/progs/bind4_prog.c | 3 +--
> > >  tools/testing/selftests/bpf/progs/bind6_prog.c | 3 +--
> > >  2 files changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > index 474c6a62078a..6bd20042fd53 100644
> > > --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > @@ -6,8 +6,7 @@
> > >  #include <linux/bpf.h>
> > >  #include <linux/in.h>
> > >  #include <linux/in6.h>
> > > -#include <sys/socket.h>
> > > -#include <netinet/tcp.h>
> > These includes look normal to me.  What environment is hitting this.
> 
> I was hitting this error with GCC 13(GCC master branch).
These two includes (<sys/socket.h> and <netinet/tcp.h>) are normal,
so does it mean all existing programs need to change to use gcc 13 ?

> 
> > I don't prefer the selftest writers need to remember this rule.
> >
> > Beside, afaict, tcp.h should be removed because
> > I don't see this test needs it.  I tried removing it
> > and it works fine.  It should be removed instead of replacing it
> > with another unnecessary tcp.h.
> 
> Oh, that does also appear to work, thought I had tried that already but I guess
> I hadn't, sent a v2 with them removed:
> https://lore.kernel.org/bpf/20220826052925.980431-1-james.hilliard1@gmail.com/T/#u
> 
> >
> > > +#include <linux/tcp.h>
> > >  #include <linux/if.h>
> > >  #include <errno.h>
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
> > > index c19cfa869f30..f37617b35a55 100644
> > > --- a/tools/testing/selftests/bpf/progs/bind6_prog.c
> > > +++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
> > > @@ -6,8 +6,7 @@
> > >  #include <linux/bpf.h>
> > >  #include <linux/in.h>
> > >  #include <linux/in6.h>
> > > -#include <sys/socket.h>
> > > -#include <netinet/tcp.h>
> > > +#include <linux/tcp.h>
> > >  #include <linux/if.h>
> > >  #include <errno.h>
> > >
> > > --
> > > 2.34.1
> > >
