Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5B5A30FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 23:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiHZV0U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 17:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbiHZV0Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 17:26:16 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7686E5925A;
        Fri, 26 Aug 2022 14:26:15 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIPAMH018100;
        Fri, 26 Aug 2022 14:25:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=gX/YZZLVeHzYylBMfigGJByo3JbRQMnTsFz/X7Dp2NU=;
 b=JKA0r5AMzfkfSItmsmjQ5SL4rMH5zu5szh+cXrOIuKYYhZQnnKHoB+t4bwzyFoY7m+sF
 rO1Njd7BE0eK1uKrA/Qt9rlubVr3oFLTXddDhY6koZRJjW8aoA0200CTk0xvHSsN7QQs
 3daoJ9TR/9BsAMb9HzV7Do44wjezZ8dI3IE= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6g8dyrvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 14:25:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPz8W1WueimRgeD4OrQaKdEMJEt8HjsWFvApUUlXN2XxBskTzXns6devyLqd98raXEZtjK2eMgPwdfxBXAsavFXqlnmKa3W4ciznPYg1czcrLD8d80kz9AML2iiNi6gn7hGOGU42sG90QeGvjkFC8sHF0LYJsCYvpkCSIwEULECi/OqGbgSJbHFK/M0AH7/ik6usNNc2Zddup5tW87uXZtg0eM3p/F0Zv2v/x3yJFe4J8JaeHvwZCfCXaI22cYgKBZ3wPB7RAri3tVcLkAPt3wsnP1weVQwfFlRQIFgPVBQrRQfmFB8zWMhWobVsydgk9Q/Lpqglj0/O9eLnyzPydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX/YZZLVeHzYylBMfigGJByo3JbRQMnTsFz/X7Dp2NU=;
 b=R7prYOnVHiGk9nKElzOywMrh/7kiyz74exIWuxEsoykRf9DOn3Hwv/haDa7Wb/g0pNSViR1/VcLFXhozs3jVWoagsk++A+0E46SQSY6J8M5+ss+sXFzkdijMbm/G/2sBgkzoODEWWtZZUtAgs8tdyurapXLluWtiN+xaikERMGx1ovGq0logefuT8NKWKwWV89s6GX+8kFusyndGSQ85Mjoh6PYyh8twI9n0Jk8sxFD/jfjSywXGDHec5NBsb+McFKr6c/F5x/hjelVrEuABdRCCFBqOJiQHH/cp8oXlOmTOc3hr2dqfTmZP7tbzUov760hVe3JYqEXGH6pELMGAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SA0PR15MB3760.namprd15.prod.outlook.com (2603:10b6:806:84::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 21:25:56 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 21:25:53 +0000
Date:   Fri, 26 Aug 2022 14:25:50 -0700
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
Message-ID: <20220826212550.mgugz6fomoqpgdbb@kafai-mbp.dhcp.thefacebook.com>
References: <20220825221751.258958-1-james.hilliard1@gmail.com>
 <20220826051630.glhrbdhiybtqwc4p@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4rQdnd=V0tENFGCTtpTESwSCcwK+h3i9nZ75M+TywNWzA@mail.gmail.com>
 <20220826054944.5bcx7unsyx4ts6ok@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4qNR+m2fQMMf9+=hMruhon8G_7yFC2_43-qhZ9X7ZW=8A@mail.gmail.com>
 <20220826171741.pdiqa4n4mls56bw3@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4qg6R9udazmGFoFhn9pXN6HOqLGEsQOhCAELi1LxzoTmw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4qg6R9udazmGFoFhn9pXN6HOqLGEsQOhCAELi1LxzoTmw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:332::21) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2164a7b9-0a62-419a-9be8-08da87a98e2f
X-MS-TrafficTypeDiagnostic: SA0PR15MB3760:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +f/jXRg2phBVBGF3i0XYIp3kemCRkOM3aXxWNjjsKsMT8NpGoymepkPpn4obIK40BtU+dwilk0np/cva33XiuqYFL3u/G+ZGUgNhLq+gfepY13qHDi13uGi4mkobPRprXxyp/mO4xDxQVYA6dSOvKZG/oxz3aTh4HnsAlbg2VM8I4Rm+I8h08YRXxc3ClEEJ1uAEe4k6N0BrjWmIuwnR8CvtiSplLvW1i2wP1m2s9FJIcysZIvFK7OcKeceo1nUaaJHdAWfUWysQlK77Ky8Kxh/WBe6xwvZFwFYp+ESqOKjNMxZ3QDViOERSMmsu/wfjn8Y2N1saITlYUQB6Tiu6YVV604tgFIcZ5SByfD368WG7KnDFEXkjNnVmbRlMrfg5P1Ey4fwRDIVhBU+08Uz8ZTGSRteDGgyVyw25Jge/y5k0qjXZXPMOPe6QHm+Orl+zu+mP7MLPlvuhebCqAArK2dQOPZpjOzC2by8LoV3DlP2fTLgC6V5G77RZoQnzmPqTTL0oCzT3jB0JKMr5kHI9sTJjylDxmvXqoR5JmUl8/yD1Viijagr+Wmmt8wkx4s+jPmF29cFl/WGWq62bfDbQmT/+TPM6WYvQBtr6DwBcIffcr7rKjLbGzLLyuqvN/TXbpsOl/QythZum33hXkTezOIwekIjHwrvRrC1VOaO3A/qXMA2ciKfeujyDrCicN1BBHRm3zitBL0mg9CTC7ejWUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(83380400001)(86362001)(38100700002)(6916009)(316002)(54906003)(2906002)(186003)(1076003)(7416002)(5660300002)(4326008)(66556008)(8676002)(66946007)(66476007)(8936002)(9686003)(478600001)(6486002)(41300700001)(53546011)(52116002)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0z7CeMlPnmcXpx3kJgDA4AeDoV0E6Fs6me8f62EfLUkGbviow5Yu96zE7W2Z?=
 =?us-ascii?Q?EgbTLI/biXOBJObJnqR8oZ30o+qKZbqzraZCABLEg5BV2Cdo2VpxXa9r88Kk?=
 =?us-ascii?Q?7UzBOvHqv3AA0jXkwqYiSRRTyJt0yIy4Qn2aS5IGh0nAJ0Ld1YFg4jp7whAH?=
 =?us-ascii?Q?3s7faTDwgUv/tUtYPT06XqXbiOk8FkAPY4nlQ4FoGeKhyy+tfvxyo2mcYhQz?=
 =?us-ascii?Q?gqoHAOQH32pDXyiKvumnIgcR0wWdhjmVrng1/a7qDa8A/YJWraVPgVkLEBIy?=
 =?us-ascii?Q?bJWVbWxpycxraZ9U2c9Aweee7ufnWZbiBLS1IQN2UwssTuk1Q1E8ygvX1zME?=
 =?us-ascii?Q?T/qiv38J27rRAQa5myTwaGiEb2pGuoUxmUcutoRB/qyQ4kxoOQXxNjqWdjql?=
 =?us-ascii?Q?mE5EU+eQ8jkt/QxBdv0Lea1r4/s5bhU6hy6roDpa4u1sfVtZLUheSrM1Roy/?=
 =?us-ascii?Q?JhDyLVYOEqEFnqZYy6v2T0YDpqMSJwspgBBJLv4pf5kyDwkC5M2M9kD14cgv?=
 =?us-ascii?Q?BsYfI/xx0AZNpPg3G+R4z/qXzz+mNPDbh2PyruMKkYIp9/pia+chZ1DLy1f1?=
 =?us-ascii?Q?uXWl/S9ITaeLpQrpf51saYEhS9DJ5ocGphXsHO+9jCE6QUSfdlOiehtE8yBw?=
 =?us-ascii?Q?MRuZzgt5IkpV0CisfRa6yC5oW1rC/DszzgOQdvfzgUdR4NQ/BA5SfX3L9Ntr?=
 =?us-ascii?Q?O1rfEKYR5/F9ZbBx+XfrZjrQV+fh2igdEsh4cFOZ3JJ5Oz72pZe1dnKIsUGy?=
 =?us-ascii?Q?USEavRjFgv2iewWXgmUXJNRd8eAUmpx1TyRZ+RaYseSU2Obr2orLi7uYL3w7?=
 =?us-ascii?Q?n0qqdThcc5lMj+gwdnhvQrXoMhbQ3AX5+YXn8hUde+60gYa8RVvYSE07/lKH?=
 =?us-ascii?Q?LvLJ6M2CWmuqlrVYrkP1NmEDgpQjipb/GuS3O9hMk/Pe5mU8epaQ6KyR+vU7?=
 =?us-ascii?Q?VzP134/+53HMxtaTfmL5FZbzMYvYQ1SIctaxWIwnh81LElcYppJkPlJOiUZ+?=
 =?us-ascii?Q?gSc9GvjAWRYWMMtl51paNPMTVPkI5ojWKlIUHuPzmZy+idv8htoDsz2gRh2Y?=
 =?us-ascii?Q?fgDdR+Pc1IBe4pWnQA0bi0EnEO8QUbH+KSI65WnO0c0BQS/tsAqKOObaQMV7?=
 =?us-ascii?Q?Ittxfd7R4hiW9fiKef6ea0KFILpDZ1B65cpUDKbJ/6YYjfc9mbbv7Q1X+Fhg?=
 =?us-ascii?Q?NJ9rDlkATqMUXs9E72j2yXLGWFmGPezKbx9vonVKFabLbxX5o7nVPJAQT6qV?=
 =?us-ascii?Q?dgb+oKddU2lMBDYnE3Xmcl6T6/YIDOabWuG/OMBWmz2MWlhARZuhxOPQFQ7G?=
 =?us-ascii?Q?HCwJD7QVLw1jxrJA+wi+1isdzLLHf6cgieHhsW7iLNy/eoKwD/LkuBs9GJmR?=
 =?us-ascii?Q?edisbe66KHzLERdEb/imvLH/XmPsUbF9knFEQK878VphdAYhejHO4X+sezRI?=
 =?us-ascii?Q?5LJcVK1ezepekLm1Je+0QuucBNMuOFOFl8PTZUOm072UDv3NoV/VaDnyQxDM?=
 =?us-ascii?Q?IM1Cn3/NIJyX5ZZ581XNYs3Smt2kWDl0Ogzz9rIQK0fEliggP3uQPACsvuu4?=
 =?us-ascii?Q?tgo9Y/BVVOSvO7q1QK3jkKte/X+wsKrLKVRIGzLvjIFohi2Iv7/sNtmLsuYR?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2164a7b9-0a62-419a-9be8-08da87a98e2f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 21:25:53.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtHIBmFJ3oyJEP2CbKHbSgM55L8RNwxqBasE7uVr7IA7o16C+rb8fx/rzfa7RnZb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3760
X-Proofpoint-GUID: -Tp3yAfs-n_56naINW6TtJO_dcEgax1K
X-Proofpoint-ORIG-GUID: -Tp3yAfs-n_56naINW6TtJO_dcEgax1K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_12,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 26, 2022 at 11:42:10AM -0600, James Hilliard wrote:
> On Fri, Aug 26, 2022 at 11:17 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Fri, Aug 26, 2022 at 12:13:54AM -0600, James Hilliard wrote:
> > > On Thu, Aug 25, 2022 at 11:49 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > >
> > > > On Thu, Aug 25, 2022 at 11:31:15PM -0600, James Hilliard wrote:
> > > > > On Thu, Aug 25, 2022 at 11:16 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > > >
> > > > > > On Thu, Aug 25, 2022 at 04:17:49PM -0600, James Hilliard wrote:
> > > > > > > There is a potential for us to hit a type conflict when including
> > > > > > > netinet/tcp.h with sys/socket.h, we can replace both of these includes
> > > > > > > with linux/tcp.h to avoid this conflict.
> > > > > > >
> > > > > > > Fixes errors like:
> > > > > > > In file included from /usr/include/netinet/tcp.h:91,
> > > > > > >                  from progs/bind4_prog.c:10:
> > > > > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
> > > > > > >    34 | typedef __INT8_TYPE__ int8_t;
> > > > > > >       |                       ^~~~~~
> > > > > > > In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
> > > > > > >                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
> > > > > > >                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
> > > > > > >                  from progs/bind4_prog.c:9:
> > > > > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
> > > > > > >    24 | typedef __int8_t int8_t;
> > > > > > >       |                  ^~~~~~
> > > > > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24: error: conflicting types for 'int64_t'; have 'long int'
> > > > > > >    43 | typedef __INT64_TYPE__ int64_t;
> > > > > > >       |                        ^~~~~~~
> > > > > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous declaration of 'int64_t' with type 'int64_t' {aka 'long long int'}
> > > > > > >    27 | typedef __int64_t int64_t;
> > > > > > >       |                   ^~~~~~~
> > > > > > > make: *** [Makefile:537: /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/bind4_prog.o] Error 1
> > > > > > >
> > > > > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > > > > > ---
> > > > > > >  tools/testing/selftests/bpf/progs/bind4_prog.c | 3 +--
> > > > > > >  tools/testing/selftests/bpf/progs/bind6_prog.c | 3 +--
> > > > > > >  2 files changed, 2 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > > > > > index 474c6a62078a..6bd20042fd53 100644
> > > > > > > --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > > > > > +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > > > > > @@ -6,8 +6,7 @@
> > > > > > >  #include <linux/bpf.h>
> > > > > > >  #include <linux/in.h>
> > > > > > >  #include <linux/in6.h>
> > > > > > > -#include <sys/socket.h>
> > > > > > > -#include <netinet/tcp.h>
> > > > > > These includes look normal to me.  What environment is hitting this.
> > > > >
> > > > > I was hitting this error with GCC 13(GCC master branch).
> > > > These two includes (<sys/socket.h> and <netinet/tcp.h>) are normal,
> > > > so does it mean all existing programs need to change to use gcc 13 ?
> > >
> > > Well I think it's mostly just an issue getting hit with GCC-BPF as it
> > > looks to me like a cross compilation host/target header conflict.
> > The users have been using these headers in the bpf progs.
> 
> Users can migrate away from libc headers over time, migrating away
imo, not without a good reason.

> shouldn't cause regressions and should improve reliability.
May be I am missing something.  I also don't understand the reliability
part.

In this sys/socket.h as an example, what is wrong in using
"'int8_t' {aka 'signed char'}" from libc and the one from
gcc "'int8_t'; have 'char'" must be used instead.

Why LLVM bpf does not have issue ?

> 
> > The solution should be on the GCC-BPF side instead of changing
> > all bpf progs.
> 
> I mean, GCC doesn't really control which libc is available, it seems to
> be a bad idea to use libc headers in general as they are developed
> separately from GCC and the kernel/libbpf.
> 
> I'm not really sure how one would fix this on the GCC-BPF side without
> introducing more potential header conflicts.
